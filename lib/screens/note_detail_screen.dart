import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';
import '../providers/user_provider.dart';
import '../providers/course_provider.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note? note;

  const NoteDetailScreen({super.key, this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String? _selectedCourse;
  bool _isLoading = false;
  bool _hasChanges = false;

  bool get isEditMode => widget.note != null;

  @override
  void initState() {
    super.initState();
    if (isEditMode) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      _selectedCourse = widget.note!.course;
    }

    _titleController.addListener(() => _hasChanges = true);
    _contentController.addListener(() => _hasChanges = true);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (!_hasChanges) return true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Buang Perubahan?'),
        content: const Text(
          'Anda memiliki perubahan yang belum disimpan. Apakah Anda yakin ingin keluar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Buang'),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  Future<void> _saveNote() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCourse == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih mata kuliah terlebih dahulu'),
          backgroundColor: AppConstants.errorColor,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final noteProvider = Provider.of<NoteProvider>(context, listen: false);

      if (isEditMode) {
        final updatedNote = widget.note!.copyWith(
          title: _titleController.text.trim(),
          course: _selectedCourse!,
          content: _contentController.text.trim(),
        );
        await noteProvider.updateNote(updatedNote);
      } else {
        await noteProvider.createNote(
          userId: userProvider.currentUser!.id,
          title: _titleController.text.trim(),
          course: _selectedCourse!,
          content: _contentController.text.trim(),
        );
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditMode
                ? 'Catatan berhasil diperbarui'
                : 'Catatan berhasil dibuat',
          ),
          backgroundColor: AppConstants.successColor,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan catatan: $e'),
          backgroundColor: AppConstants.errorColor,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteNote() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Catatan?'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus catatan ini? Tindakan ini tidak dapat dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: AppConstants.errorColor,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isLoading = true);

    try {
      final noteProvider = Provider.of<NoteProvider>(context, listen: false);
      await noteProvider.deleteNote(widget.note!.id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Catatan berhasil dihapus'),
          backgroundColor: AppConstants.successColor,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus catatan: $e'),
          backgroundColor: AppConstants.errorColor,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEditMode ? 'Edit Catatan' : 'Buat Catatan'),
          actions: [
            if (isEditMode)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: _isLoading ? null : _deleteNote,
              ),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _isLoading ? null : _saveNote,
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppConstants.padding),
            children: [
              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul Catatan',
                  hintText: 'Masukkan judul catatan',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: Validators.validateTitle,
                enabled: !_isLoading,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 16),
              // Course Dropdown
              Consumer<CourseProvider>(
                builder: (context, courseProvider, _) {
                  return DropdownButtonFormField<String>(
                    initialValue: _selectedCourse,
                    decoration: const InputDecoration(
                      labelText: 'Mata Kuliah',
                      hintText: 'Pilih mata kuliah',
                      prefixIcon: Icon(Icons.book_outlined),
                    ),
                    items: courseProvider.courses.map((course) {
                      return DropdownMenuItem(
                        value: course.courseName,
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Color(int.parse(
                                  course.colorCode.replaceFirst('#', '0xFF'),
                                )),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(course.courseName),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: _isLoading
                        ? null
                        : (value) {
                            setState(() {
                              _selectedCourse = value;
                              _hasChanges = true;
                            });
                          },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Pilih mata kuliah';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              // Content Field
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Konten Catatan',
                  hintText: 'Tulis catatan Anda di sini...',
                  alignLabelWithHint: true,
                ),
                maxLines: 15,
                validator: Validators.validateContent,
                enabled: !_isLoading,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 24),
              // Save Button
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _saveNote,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.save),
                label: Text(isEditMode ? 'Perbarui Catatan' : 'Simpan Catatan'),
              ),
              if (isEditMode) ...[
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _isLoading ? null : _deleteNote,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Hapus Catatan'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppConstants.errorColor,
                    side: const BorderSide(color: AppConstants.errorColor),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
