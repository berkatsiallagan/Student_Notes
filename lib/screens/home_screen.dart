import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/note_provider.dart';
import '../providers/course_provider.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/note_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/loading_shimmer.dart';
import '../utils/constants.dart';
import 'note_detail_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);

    if (userProvider.currentUser != null) {
      await Future.wait([
        noteProvider.loadNotes(userProvider.currentUser!.id),
        courseProvider.loadCourses(userProvider.currentUser!.id),
      ]);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterDialog() {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Consumer<NoteProvider>(
          builder: (context, provider, _) {
            return Padding(
              padding: const EdgeInsets.all(AppConstants.padding * 1.5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter Catatan',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Hanya Favorit'),
                    value: provider.showFavoritesOnly,
                    onChanged: (value) {
                      provider.toggleFavoritesFilter();
                    },
                    activeTrackColor: AppConstants.primaryColor,
                  ),
                  const Divider(),
                  Text(
                    'Mata Kuliah',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('Semua'),
                        selected: provider.selectedCourse == null,
                        onSelected: (selected) {
                          provider.filterByCourse(null);
                        },
                      ),
                      ...courseProvider.courses.map((course) {
                        return FilterChip(
                          label: Text(course.courseName),
                          selected: provider.selectedCourse == course.courseName,
                          onSelected: (selected) {
                            provider.filterByCourse(
                              selected ? course.courseName : null,
                            );
                          },
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        provider.clearFilters();
                        Navigator.pop(context);
                      },
                      child: const Text('Reset Filter'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _isSearching ? '' : AppConstants.appName,
        showLogo: !_isSearching,
        leading: _isSearching
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                    _searchController.clear();
                  });
                  Provider.of<NoteProvider>(context, listen: false)
                      .searchNotes('');
                },
              )
            : null,
        actions: [
          if (_isSearching)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Cari catatan...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onChanged: (value) {
                    Provider.of<NoteProvider>(context, listen: false)
                        .searchNotes(value);
                  },
                ),
              ),
            )
          else ...[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() => _isSearching = true);
              },
            ),
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _showFilterDialog,
            ),
            IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            ),
          ],
        ],
      ),
      body: Consumer2<NoteProvider, CourseProvider>(
        builder: (context, noteProvider, courseProvider, _) {
          if (noteProvider.isLoading) {
            return const LoadingShimmer();
          }

          if (noteProvider.notes.isEmpty) {
            if (noteProvider.searchQuery.isNotEmpty ||
                noteProvider.selectedCourse != null ||
                noteProvider.showFavoritesOnly) {
              return EmptyState(
                title: 'Tidak Ada Hasil',
                message: 'Tidak ada catatan yang sesuai dengan filter Anda',
                icon: Icons.search_off,
                onActionPressed: () {
                  noteProvider.clearFilters();
                  _searchController.clear();
                  setState(() => _isSearching = false);
                },
                actionLabel: 'Reset Filter',
              );
            }

            return EmptyState(
              title: 'Belum Ada Catatan',
              message:
                  'Mulai buat catatan kuliah pertama Anda dengan menekan tombol + di bawah',
              icon: Icons.note_add_outlined,
            );
          }

          return RefreshIndicator(
            onRefresh: _loadData,
            child: Column(
              children: [
                // Statistics Card
                Container(
                  margin: const EdgeInsets.all(AppConstants.padding),
                  padding: const EdgeInsets.all(AppConstants.padding),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppConstants.primaryColor,
                        AppConstants.secondaryColor,
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: AppConstants.primaryColor.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        context,
                        Icons.note_outlined,
                        noteProvider.totalNotes.toString(),
                        'Total Catatan',
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      _buildStatItem(
                        context,
                        Icons.book_outlined,
                        courseProvider.courses.length.toString(),
                        'Mata Kuliah',
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      _buildStatItem(
                        context,
                        Icons.star_outline,
                        noteProvider.favoriteCount.toString(),
                        'Favorit',
                      ),
                    ],
                  ),
                ),
                // Notes List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: noteProvider.notes.length,
                    itemBuilder: (context, index) {
                      final note = noteProvider.notes[index];
                      final courseColor =
                          courseProvider.getCourseColor(note.course);

                      return NoteCard(
                        note: note,
                        courseColor: courseColor,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NoteDetailScreen(note: note),
                            ),
                          );
                          _loadData();
                        },
                        onFavoriteToggle: () {
                          noteProvider.toggleFavorite(note);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const NoteDetailScreen(),
            ),
          );
          _loadData();
        },
        icon: const Icon(Icons.add),
        label: const Text('Buat Catatan'),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
        ),
      ],
    );
  }
}
