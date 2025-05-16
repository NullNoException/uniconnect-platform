import 'package:customer_app/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProgramDetailsScreen extends ConsumerStatefulWidget {
  final String programId;

  const ProgramDetailsScreen({required this.programId, super.key});

  @override
  ConsumerState<ProgramDetailsScreen> createState() =>
      _ProgramDetailsScreenState();
}

class _ProgramDetailsScreenState extends ConsumerState<ProgramDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isBookmarked = false;

  // Mock data for UI development
  final Map<String, dynamic> _programData = {
    'id': '101',
    'name': 'Computer Science',
    'universityId': '1',
    'universityName': 'Harvard University',
    'universityLogo': 'https://example.com/harvard_logo.png',
    'location': 'Cambridge, Massachusetts, USA',
    'degreeLevel': 'Bachelor of Science',
    'duration': '4 years',
    'studyMode': 'Full-time',
    'language': 'English',
    'tuitionFee': 54768,
    'applicationFee': 75,
    'applicationDeadline': '2025-12-15',
    'startDate': 'September 2026',
    'description':
        'The Computer Science program at Harvard provides students with a solid foundation in the theoretical and mathematical aspects of computing, alongside practical skills in areas such as programming, algorithms, data structures, systems design, and artificial intelligence. The curriculum emphasizes both theoretical understanding and hands-on experience through projects and internships.',
    'requirements': [
      'High School Diploma or equivalent',
      'SAT/ACT scores',
      'Strong academic record in mathematics and science',
      'Programming experience recommended',
      'English language proficiency (TOEFL/IELTS for international students)',
    ],
    'curriculum': [
      {
        'year': 'Year 1',
        'courses': [
          'Introduction to Computer Science',
          'Discrete Mathematics',
          'Data Structures and Algorithms',
          'Calculus I & II',
          'Academic Writing',
          'Liberal Arts Electives',
        ],
      },
      {
        'year': 'Year 2',
        'courses': [
          'Computer Systems',
          'Algorithms and Complexity',
          'Database Systems',
          'Linear Algebra',
          'Statistics',
          'Technical Electives',
        ],
      },
      {
        'year': 'Year 3',
        'courses': [
          'Operating Systems',
          'Software Engineering',
          'Computer Networks',
          'Artificial Intelligence',
          'Technical Electives',
          'Humanities Electives',
        ],
      },
      {
        'year': 'Year 4',
        'courses': [
          'Senior Project',
          'Computer Graphics',
          'Machine Learning',
          'Technical Electives',
          'General Electives',
        ],
      },
    ],
    'careerOpportunities': [
      'Software Engineer',
      'Data Scientist',
      'Systems Analyst',
      'UX Designer',
      'Database Administrator',
      'Cybersecurity Specialist',
      'Machine Learning Engineer',
      'Research Scientist',
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProgramInfo(),
                const Divider(height: 1),
                _buildTabBar(),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildCurriculumTab(),
                _buildRequirementsTab(),
                _buildCareersTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withPreciseOpacity(0.4),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withPreciseOpacity(0.4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            setState(() {
              _isBookmarked = !_isBookmarked;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _isBookmarked
                      ? 'Added to bookmarks'
                      : 'Removed from bookmarks',
                ),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withPreciseOpacity(0.4),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.share, color: Colors.white),
          ),
          onPressed: () {
            // TODO: Implement share functionality
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Gradient background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(
                      context,
                    ).colorScheme.primary.withPreciseOpacity(0.8),
                  ],
                ),
              ),
            ),
            // Gradient overlay for better text visibility
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withPreciseOpacity(0.7),
                  ],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
            // Program name and university
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _programData['name'],
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      context.go('/university/${_programData['universityId']}');
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.white,
                          child: Text(
                            _programData['universityName'][0],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _programData['universityName'],
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildInfoItem(
            Icons.school_outlined,
            'Degree',
            _programData['degreeLevel'],
          ),
          _buildInfoItem(
            Icons.access_time,
            'Duration',
            _programData['duration'],
          ),
          _buildInfoItem(Icons.language, 'Language', _programData['language']),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: Theme.of(context).colorScheme.primary,
      unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
      indicatorColor: Theme.of(context).colorScheme.primary,
      isScrollable: true,
      tabs: const [
        Tab(text: 'Overview'),
        Tab(text: 'Curriculum'),
        Tab(text: 'Requirements'),
        Tab(text: 'Careers'),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Program Description',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            _programData['description'],
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Text(
            'Program Details',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildDetailRow('Study Mode', _programData['studyMode']),
                  const Divider(height: 16),
                  _buildDetailRow('Start Date', _programData['startDate']),
                  const Divider(height: 16),
                  _buildDetailRow(
                    'Annual Tuition Fee',
                    '\$${_programData['tuitionFee'].toString()}',
                  ),
                  const Divider(height: 16),
                  _buildDetailRow(
                    'Application Deadline',
                    _formatDate(_programData['applicationDeadline']),
                  ),
                  const Divider(height: 16),
                  _buildDetailRow(
                    'Application Fee',
                    '\$${_programData['applicationFee'].toString()}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurriculumTab() {
    final curriculum = _programData['curriculum'] as List;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: curriculum.length,
      itemBuilder: (context, index) {
        final yearData = curriculum[index];
        final courses = yearData['courses'] as List;

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Text(yearData['year']),
            initiallyExpanded: index == 0,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                itemCount: courses.length,
                itemBuilder: (context, courseIndex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.circle, size: 8),
                        const SizedBox(width: 8),
                        Expanded(child: Text(courses[courseIndex])),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRequirementsTab() {
    final requirements = _programData['requirements'] as List;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Admission Requirements',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    requirements.map((requirement) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Text(requirement)),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Application Process',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildStepItem(
                    '1',
                    'Create Account',
                    'Register on the university portal',
                  ),
                  const SizedBox(height: 16),
                  _buildStepItem(
                    '2',
                    'Complete Application',
                    'Fill out all required information',
                  ),
                  const SizedBox(height: 16),
                  _buildStepItem(
                    '3',
                    'Upload Documents',
                    'Submit transcripts, test scores, and other required documents',
                  ),
                  const SizedBox(height: 16),
                  _buildStepItem(
                    '4',
                    'Pay Application Fee',
                    'Submit payment of \$${_programData['applicationFee']}',
                  ),
                  const SizedBox(height: 16),
                  _buildStepItem(
                    '5',
                    'Track Application',
                    'Monitor your application status through the portal',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(String number, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCareersTab() {
    final careers = _programData['careerOpportunities'] as List;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Career Opportunities',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: careers.length,
            itemBuilder: (context, index) {
              return Card(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      careers[index],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Industry Outlook',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatItem('Average Starting Salary', '\$85,000'),
                  const Divider(height: 16),
                  _buildStatItem('Employment Rate', '96%'),
                  const Divider(height: 16),
                  _buildStatItem('Industry Growth', '15% annually'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alumni Success',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Our graduates work at leading technology companies including Google, Microsoft, Apple, Amazon, and Facebook, as well as innovative startups and research institutions worldwide.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  context.go('/university/${_programData['universityId']}');
                },
                style: OutlinedButton.styleFrom(minimumSize: const Size(0, 50)),
                child: const Text('View University'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to program application form
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 50),
                ),
                child: const Text('Apply Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    // In a real app, we'd use intl package to format dates properly
    final parts = dateStr.split('-');
    if (parts.length == 3) {
      return '${parts[2]}/${parts[1]}/${parts[0]}';
    }
    return dateStr;
  }
}
