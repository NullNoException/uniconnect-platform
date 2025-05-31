import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_app/core/utils/color_utils.dart';

// Mock data models for UI development
class BookmarkedItem {
  final String id;
  final String name;
  final String type; // 'university' or 'program'
  final String imageUrl;
  final String details;

  BookmarkedItem({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.details,
  });
}

// Sample provider for bookmarks
final bookmarksProvider =
    StateNotifierProvider<BookmarksNotifier, List<BookmarkedItem>>((ref) {
      return BookmarksNotifier();
    });

class BookmarksNotifier extends StateNotifier<List<BookmarkedItem>> {
  BookmarksNotifier() : super(_initialBookmarks);

  void removeBookmark(String id) {
    state = state.where((bookmark) => bookmark.id != id).toList();
  }
}

// Initial mock data
final List<BookmarkedItem> _initialBookmarks = [
  BookmarkedItem(
    id: '1',
    name: 'Harvard University',
    type: 'university',
    imageUrl: 'https://example.com/harvard.jpg',
    details: 'Cambridge, Massachusetts, USA',
  ),
  BookmarkedItem(
    id: '101',
    name: 'Computer Science',
    type: 'program',
    imageUrl: 'https://example.com/cs_program.jpg',
    details: 'Harvard University • Bachelor • 4 years',
  ),
  BookmarkedItem(
    id: '2',
    name: 'Stanford University',
    type: 'university',
    imageUrl: 'https://example.com/stanford.jpg',
    details: 'Stanford, California, USA',
  ),
  BookmarkedItem(
    id: '102',
    name: 'Business Administration',
    type: 'program',
    imageUrl: 'https://example.com/mba_program.jpg',
    details: 'Stanford University • Master • 2 years',
  ),
];

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksProvider);
    final universities = bookmarks
        .where((item) => item.type == 'university')
        .toList();
    final programs = bookmarks.where((item) => item.type == 'program').toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Saved'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Universities'),
              Tab(text: 'Programs'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildBookmarksList(context, ref, bookmarks),
            _buildBookmarksList(context, ref, universities),
            _buildBookmarksList(context, ref, programs),
          ],
        ),
      ),
    );
  }

  Widget _buildBookmarksList(
    BuildContext context,
    WidgetRef ref,
    List<BookmarkedItem> items,
  ) {
    if (items.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildBookmarkCard(context, ref, item);
      },
    );
  }

  Widget _buildBookmarkCard(
    BuildContext context,
    WidgetRef ref,
    BookmarkedItem item,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          // Navigate to the appropriate detail screen
          if (item.type == 'university') {
            context.go('/university/${item.id}');
          } else {
            context.go('/program/${item.id}');
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Item image or icon
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 60,
                  height: 60,
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withPreciseOpacity(0.1),
                  child: Center(
                    child: Icon(
                      item.type == 'university'
                          ? Icons.account_balance
                          : Icons.school,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Item details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.details,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          item.type == 'university'
                              ? Icons.location_on
                              : Icons.access_time,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.type == 'university' ? 'University' : 'Program',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Remove bookmark button
              IconButton(
                icon: const Icon(Icons.bookmark),
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  // Remove the bookmark
                  ref.read(bookmarksProvider.notifier).removeBookmark(item.id);

                  // Show confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Removed from bookmarks'),
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          // In a real app, we would restore the removed bookmark
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No saved items',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Items you bookmark will appear here',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigate back to explore
              context.go('/home');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Explore Universities'),
          ),
        ],
      ),
    );
  }
}
