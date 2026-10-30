import 'package:flutter/material.dart';
import '../services/school_data_service.dart';
import '../services/url_launcher_service.dart';
import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import '../widgets/announcement_ticker.dart';
import '../widgets/student_id_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/search_delegate_view.dart';
import 'gallery_screen.dart';
import 'activities_screen.dart';
import 'institutional_profile_screen.dart';

class HomeDashboardScreen extends StatefulWidget {
  final Function(int) onTabChange;

  const HomeDashboardScreen({
    super.key,
    required this.onTabChange,
  });

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  final SchoolDataService _dataService = SchoolDataService();
  final AuthService _authService = AuthService();
  String _selectedLanguage = 'Eng';

  void _openSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: SchoolSearchDelegate(
        onNavigateToTab: widget.onTabChange,
        onNavigateToScreen: (screen) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
        },
      ),
    );
  }

  void _openVoiceSearch(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => VoiceSearchModal(
        onVoiceCommandDetected: (detectedText) {
          Navigator.pop(ctx);
          showSearch(
            context: context,
            query: detectedText,
            delegate: SchoolSearchDelegate(
              onNavigateToTab: widget.onTabChange,
              onNavigateToScreen: (screen) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final student = _dataService.getStudentProfile();
    final user = _authService.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==========================================
              // TOP HEADER: Greeting Row & School Crest
              // ==========================================
              Container(
                color: AppColors.surfaceContainerLowest,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Institutional Crest Avatar
                            GestureDetector(
                              onTap: () => widget.onTabChange(3), // Open School Profile
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.surfaceContainer,
                                  border: Border.all(color: AppColors.outlineVariant),
                                ),
                                child: const Center(
                                  child: Icon(Icons.school, size: 26, color: AppColors.primaryContainer),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'STUDENT SMART PORTAL',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.secondary,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: AppColors.secondary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  user?.displayName ?? 'SMRISS GGSSS Bathinda',
                                  style: const TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Notification Bell Pill: Opens Message & Notification Google Doc
                        IconButton(
                          onPressed: () {
                            UrlLauncherService.openMessagesAndNotifications();
                          },
                          icon: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceContainer,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.outlineVariant),
                                ),
                                child: const Icon(Icons.notifications_outlined, size: 20, color: AppColors.primaryContainer),
                              ),
                              Positioned(
                                top: -2,
                                right: -2,
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Text(
                                    '3',
                                    style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // ==========================================
                    // INTEGRATED FUNCTIONAL SEARCH BAR & MIC
                    // ==========================================
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _openSearch(context),
                            child: Container(
                              height: 42,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.outlineVariant),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.search, size: 19, color: AppColors.outline),
                                  const SizedBox(width: 8),
                                  const Expanded(
                                    child: Text(
                                      'Search syllabus, timetable, notices...',
                                      style: TextStyle(fontSize: 12, color: AppColors.outline),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  // Functional Voice Search Mic
                                  GestureDetector(
                                    onTap: () => _openVoiceSearch(context),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryContainer.withOpacity(0.08),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.mic, size: 18, color: AppColors.secondary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Language Selector Pill
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedLanguage = _selectedLanguage == 'Eng' ? 'ਪੰਜਾਬੀ' : 'Eng';
                            });
                          },
                          child: Container(
                            height: 42,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainer,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.outlineVariant),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  _selectedLanguage,
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                                ),
                                const Icon(Icons.arrow_drop_down, size: 16, color: AppColors.primary),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Marquee Broadcast Ticker
              GestureDetector(
                onTap: () => UrlLauncherService.openMessagesAndNotifications(),
                child: const AnnouncementTicker(
                  text: 'Winter uniform guidelines released • Pre-board examination timetable active in Google Doc • Tap to read official notice.',
                ),
              ),

              // Main Canvas Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Campus Hero Panoramic Card
                    GestureDetector(
                      onTap: () => widget.onTabChange(3), // Open School Profile
                      child: Container(
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image: NetworkImage('https://images.unsplash.com/photo-1562774053-701939374585?w=800&q=80'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    AppColors.primaryDark.withOpacity(0.85),
                                  ],
                                ),
                              ),
                            ),
                            // Top Badges
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(9999),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.verified, size: 14, color: AppColors.secondary),
                                        SizedBox(width: 4),
                                        Text('Smart Campus', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary,
                                      borderRadius: BorderRadius.circular(9999),
                                    ),
                                    child: const Text('Admissions Open', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                            // Bottom Campus Details
                            const Positioned(
                              bottom: 12,
                              left: 14,
                              right: 14,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 14, color: AppColors.tertiaryFixed),
                                      SizedBox(width: 4),
                                      Text('Mall Road, Bathinda • Punjab', style: TextStyle(fontSize: 11, color: AppColors.tertiaryFixed, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Shaheed Major Ravi Inder Singh Sandhu GGSSS',
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Student Smart ID Card
                    StudentIdCard(student: student),

                    const SizedBox(height: 20),

                    // ==========================================
                    // QUICK ACADEMIC HUB (6 SERVICES INTEGRATION)
                    // ==========================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Quick Academic Hub',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '6 Services',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // 6 Interactive Tiles with Exact URL Launcher & Wireframe Routing
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.15,
                      children: [
                        // 1. Timetable Button -> Google Sheets URL
                        QuickActionCard(
                          icon: Icons.table_chart_rounded,
                          title: 'Daily Timetable',
                          subtitle: 'Live period & room schedule',
                          actionLabel: 'Open Sheet',
                          actionIcon: Icons.open_in_new,
                          onTap: () {
                            UrlLauncherService.openTimetable();
                          },
                        ),

                        // 2. School Website Button -> Google Sites URL
                        QuickActionCard(
                          icon: Icons.public_rounded,
                          title: 'School Website',
                          subtitle: 'Official portal & updates',
                          actionLabel: 'Visit Portal',
                          actionIcon: Icons.open_in_new,
                          onTap: () {
                            UrlLauncherService.openWebsite();
                          },
                        ),

                        // 3. School Gallery Button -> Navigates to 'Gallery Wireframe' screen
                        QuickActionCard(
                          icon: Icons.photo_library_rounded,
                          title: 'School Gallery',
                          subtitle: 'Campus, labs & sports photos',
                          actionLabel: 'Open Gallery',
                          actionIcon: Icons.arrow_forward,
                          onTap: () {
                            widget.onTabChange(2); // Switches to Gallery Wireframe
                          },
                        ),

                        // 4. Syllabus Button -> http://pseb.ac.in
                        QuickActionCard(
                          icon: Icons.menu_book_rounded,
                          title: 'Syllabus',
                          subtitle: 'PSEB Class 6th-12th curriculum',
                          actionLabel: 'Open PSEB',
                          actionIcon: Icons.download_rounded,
                          onTap: () {
                            UrlLauncherService.openSyllabus();
                          },
                        ),

                        // 5. Message & Notification Button -> Google Docs URL
                        QuickActionCard(
                          icon: Icons.campaign_rounded,
                          title: 'Messages & Notices',
                          subtitle: 'Official circulars doc & alerts',
                          actionLabel: 'Open Doc',
                          actionIcon: Icons.open_in_new,
                          badgeText: 'Live Doc',
                          badgeColor: AppColors.secondary,
                          iconColor: AppColors.secondary,
                          onTap: () {
                            UrlLauncherService.openMessagesAndNotifications();
                          },
                        ),

                        // 6. Activity Button -> Navigates to 'Activity Wireframe' screen
                        QuickActionCard(
                          icon: Icons.local_activity_rounded,
                          title: 'Activities Hub',
                          subtitle: 'Clubs, BIS, Eco & Campaigns',
                          actionLabel: 'Open Activities',
                          actionIcon: Icons.arrow_forward,
                          badgeText: 'Featured',
                          badgeColor: AppColors.tertiaryDark,
                          iconColor: AppColors.tertiaryDark,
                          onTap: () {
                            widget.onTabChange(1); // Switches to Activity Wireframe
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ==========================================
                    // PRINCIPAL SIR'S DESK BULLETIN (Preview)
                    // ==========================================
                    GestureDetector(
                      onTap: () => widget.onTabChange(3), // Navigate to School Profile
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(16),
                          border: const Border(
                            left: BorderSide(color: AppColors.secondary, width: 4),
                            top: BorderSide(color: AppColors.outlineVariant),
                            right: BorderSide(color: AppColors.outlineVariant),
                            bottom: BorderSide(color: AppColors.outlineVariant),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.verified_user, color: AppColors.secondary, size: 20),
                                    SizedBox(width: 6),
                                    Text(
                                      "Principal's Desk Note",
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryFixed,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text('State Awardee', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '"Welcome to the smart portal of SMRISS GGSSS. We empower our daughters with digital excellence, discipline, and ethical fortitude under smart education infrastructure."',
                              style: TextStyle(
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                color: AppColors.onSurface,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'S. Kulwinder Singh Sandhu',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'View Full Profile',
                                      style: TextStyle(fontSize: 11, color: AppColors.secondary, fontWeight: FontWeight.bold),
                                    ),
                                    Icon(Icons.chevron_right, size: 14, color: AppColors.secondary),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
