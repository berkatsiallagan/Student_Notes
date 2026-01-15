import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';
import '../database/database_helper.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String? _selectedCourse;
  bool _showFavoritesOnly = false;

  List<Note> get notes => _filteredNotes;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  String? get selectedCourse => _selectedCourse;
  bool get showFavoritesOnly => _showFavoritesOnly;

  int get totalNotes => _notes.length;
  int get favoriteCount => _notes.where((note) => note.isFavorite).length;
  
  Set<String> get allCourses {
    return _notes.map((note) => note.course).toSet();
  }

  Future<void> loadNotes(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _notes = await DatabaseHelper.instance.getNotesByUser(userId);
      _applyFilters();
    } catch (e) {
      debugPrint('Error loading notes: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createNote({
    required String userId,
    required String title,
    required String course,
    required String content,
  }) async {
    try {
      final note = Note(
        id: const Uuid().v4(),
        userId: userId,
        title: title,
        course: course,
        content: content,
        dateCreated: DateTime.now(),
        dateUpdated: DateTime.now(),
      );

      await DatabaseHelper.instance.createNote(note);
      _notes.insert(0, note);
      _applyFilters();
      notifyListeners();
    } catch (e) {
      debugPrint('Error creating note: $e');
      rethrow;
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      final updatedNote = note.copyWith(dateUpdated: DateTime.now());
      await DatabaseHelper.instance.updateNote(updatedNote);
      
      final index = _notes.indexWhere((n) => n.id == note.id);
      if (index != -1) {
        _notes[index] = updatedNote;
        _applyFilters();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating note: $e');
      rethrow;
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await DatabaseHelper.instance.deleteNote(noteId);
      _notes.removeWhere((note) => note.id == noteId);
      _applyFilters();
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting note: $e');
      rethrow;
    }
  }

  Future<void> toggleFavorite(Note note) async {
    try {
      final updatedNote = note.copyWith(isFavorite: !note.isFavorite);
      await updateNote(updatedNote);
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }

  void searchNotes(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void filterByCourse(String? course) {
    _selectedCourse = course;
    _applyFilters();
    notifyListeners();
  }

  void toggleFavoritesFilter() {
    _showFavoritesOnly = !_showFavoritesOnly;
    _applyFilters();
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCourse = null;
    _showFavoritesOnly = false;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredNotes = _notes;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      _filteredNotes = _filteredNotes.where((note) {
        return note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            note.content.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Apply course filter
    if (_selectedCourse != null) {
      _filteredNotes = _filteredNotes.where((note) {
        return note.course == _selectedCourse;
      }).toList();
    }

    // Apply favorites filter
    if (_showFavoritesOnly) {
      _filteredNotes = _filteredNotes.where((note) => note.isFavorite).toList();
    }
  }

  Note? getNoteById(String id) {
    try {
      return _notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }
}
