import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/color_utils.dart';

// Sample data models for UI development
class University {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final double rating;

  University({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
  });
}

class Program {
  final String id;
  final String name;
  final String universityName;
  final String duration;
  final String degreeLevel;
  final double tuitionFee;

  Program({
    required this.id,
    required this.name,
    required this.universityName,
    required this.duration,
    required this.degreeLevel,
    required this.tuitionFee,
  });
}

// Sample data for UI development
final List<University> _sampleUniversities = [
  University(
    id: '1',
    name: 'Harvard University',
    location: 'Cambridge, MA',
    imageUrl: 'https://example.com/harvard.jpg',
    rating: 4.9,
  ),
  University(
    id: '2',
    name: 'Stanford University',
    location: 'Stanford, CA',
    imageUrl: 'https://example.com/stanford.jpg',
    rating: 4.8,
  ),
  University(
    id: '3',
    name: 'MIT',
    location: 'Cambridge, MA',
    imageUrl: 'https://example.com/mit.jpg',
    rating: 4.9,
  ),
  University(
    id: '4',
    name: 'Oxford University',
    location: 'Oxford, UK',
    imageUrl: 'https://example.com/oxford.jpg',
    rating: 4.8,
  ),
];

final List<Program> _samplePrograms = [
  Program(
    id: '1',
    name: 'Computer Science',
    universityName: 'Harvard University',
    duration: '4 years',
    degreeLevel: 'Bachelor',
    tuitionFee: 50000,
  ),
  Program(
    id: '2',
    name: 'Business Administration',
    universityName: 'Stanford University',
    duration: '2 years',
    degreeLevel: 'Master',
    tuitionFee: 70000,
  ),
  Program(
    id: '3',
    name: 'Artificial Intelligence',
    universityName: 'MIT',
    duration: '2 years',
    degreeLevel: 'Master',
    tuitionFee: 65000,
  ),
  Program(
    id: '4',
    name: 'Data Science',
    universityName: 'Oxford University',
    duration: '4 years',
    degreeLevel: 'Bachelor',
    tuitionFee: 45000,
  ),
];

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildCurrentScreen()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border_outlined),
            activeIcon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return _buildExploreTab();
      case 2:
        return _buildSavedTab();
      case 3:
        return _buildProfileTab();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, John',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                      'Find your perfect university',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  // TODO: Implement notifications
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search universities or programs',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Featured Universities', () {
            // TODO: Navigate to all universities screen
          }),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _sampleUniversities.length,
              itemBuilder: (context, index) {
                final university = _sampleUniversities[index];
                return _buildUniversityCard(university);
              },
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Popular Programs', () {
            // TODO: Navigate to all programs screen
          }),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _samplePrograms.length,
            itemBuilder: (context, index) {
              final program = _samplePrograms[index];
              return _buildProgramCard(program);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExploreTab() {
    // Placeholder for the explore tab
    return Center(
      child: Text(
        'Explore Tab',
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }

  Widget _buildSavedTab() {
    // Navigate to bookmarks screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(AppConstants.bookmarksRoute);
    });
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildProfileTab() {
    // Navigate to profile screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(AppConstants.profileRoute);
    });
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildSectionHeader(String title, VoidCallback onViewAllPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        TextButton(onPressed: onViewAllPressed, child: const Text('View All')),
      ],
    );
  }

  Widget _buildUniversityCard(University university) {
    return GestureDetector(
      onTap: () {
        context.go('/university/${university.id}');
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withPreciseOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // University image placeholder
            Container(
              height: 120,
              color: Theme.of(
                context,
              ).colorScheme.primary.withPreciseOpacity(0.1),
              child: Center(
                child: Icon(
                  Icons.account_balance,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    university.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          university.location,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        university.rating.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramCard(Program program) {
    return GestureDetector(
      onTap: () {
        context.go('/program/${program.id}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withPreciseOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                program.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.account_balance_outlined,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    program.universityName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.school_outlined,
                          size: 16,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          program.degreeLevel,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          program.duration,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${program.tuitionFee.toStringAsFixed(0)}/year',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Implement application flow
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
