import 'package:flutter/material.dart';
import '../services/school_data_service.dart';
import '../theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class InstitutionalProfileScreen extends StatelessWidget {
  final bool showBackButton;

  const InstitutionalProfileScreen({
    super.key,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final details = SchoolDataService().getSchoolDetails();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: showBackButton,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Institutional Profile', style: TextStyle(fontFamily: 'Outfit', fontSize: 17, fontWeight: FontWeight.bold)),
            Text('SMRISS GGSSS Mall Road Bathinda', style: TextStyle(fontSize: 11, color: AppColors.outline)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, size: 20),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing school profile portal link...')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Crest & ESTD Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.outlineVariant),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.surfaceContainer,
                          border: Border.all(color: AppColors.secondary, width: 2.5),
                        ),
                        child: const Icon(Icons.school, size: 44, color: AppColors.primaryContainer),
                      ),
                      Positioned(
                        bottom: -8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(9999),
                            border: Border.all(color: AppColors.tertiary, width: 1.5),
                          ),
                          child: const Text(
                            'ESTD 1954',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Shaheed Major Ravi Inder Singh Sandhu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Govt. Girls Sen. Sec. Smart School',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, size: 14, color: AppColors.secondary),
                      SizedBox(width: 4),
                      Text('Mall Road, Bathinda, Punjab', style: TextStyle(fontSize: 12, color: AppColors.outline)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.tertiaryFixed.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Motto: "Endeavor to Excel"',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.tertiaryDark),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Key Statistics Grid
            Row(
              children: [
                _buildStatCard('2,450+', 'Enrolled Students', Icons.groups_rounded, AppColors.primary),
                const SizedBox(width: 10),
                _buildStatCard('32', 'Smart Classrooms', Icons.smart_screen_rounded, AppColors.secondary),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildStatCard('85+', 'Expert Faculty', Icons.badge_rounded, AppColors.tertiaryDark),
                const SizedBox(width: 10),
                _buildStatCard('6', 'Modern Labs', Icons.science_rounded, AppColors.primaryContainer),
              ],
            ),

            const SizedBox(height: 20),

            // ==========================================
            // PRINCIPAL SIR'S PICTURE & LEADERSHIP WIREFRAME LAYOUT
            // ==========================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'School Leadership & Mentorship',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryFixed,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'State Awardee',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.secondary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Text(
              'Guiding excellence with vision and dedication',
              style: TextStyle(fontSize: 11, color: AppColors.outline),
            ),
            const SizedBox(height: 12),

            // Principal Card with Picture
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.outlineVariant),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Principal Sir's Picture
                      Container(
                        width: 76,
                        height: 94,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.secondary, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.secondary.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/images/principal.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'S. Kulwinder Singh Sandhu',
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.verified, size: 12, color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Principal & Head of Institution',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'A true visionary and the backbone of our educational institution. With his deep knowledge, immense patience, and unparalleled administrative skills, he guides our school toward excellence every single day.',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.onSurfaceVariant,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: AppColors.outlineVariant),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          launchUrl(Uri.parse('mailto:contact.principal@smriss.edu'));
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.mail_outline, size: 14, color: AppColors.primary),
                            SizedBox(width: 4),
                            Text(
                              'contact.principal@smriss.edu',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Office: Room 101',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Principal's Quote Callout Banner (Matching Stitch design)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryDark.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  const Positioned(
                    right: 0,
                    bottom: -6,
                    child: Icon(
                      Icons.format_quote,
                      size: 64,
                      color: Colors.white12,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '"Under his brilliant leadership, the school campus has transformed into a highly disciplined, positive, and vibrant space where education thrives effortlessly for every single student."',
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(width: 20, height: 2, color: AppColors.tertiaryFixed),
                          const SizedBox(width: 6),
                          const Text(
                            '— From the Principal\'s Desk',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryFixed,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Heritage & Martyr's Tribute Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.military_tech, color: AppColors.secondary, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Honoring Our Heroic Namesake',
                        style: TextStyle(fontFamily: 'Outfit', fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Named in eternal remembrance of Shaheed Major Ravi Inder Singh Sandhu, who fought with exemplary courage in defense of our nation. The institution instills the patriotic values of selfless service, fearlessness, and academic excellence in every girl child passing through its historic gates.',
                    style: TextStyle(fontSize: 13, color: AppColors.onSurface, height: 1.45),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Campus Facilities
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Campus Infrastructure & Facilities',
                    style: TextStyle(fontFamily: 'Outfit', fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                  const SizedBox(height: 12),
                  _buildFacilityRow(Icons.laptop_chromebook, 'ICT & Smart Interactive Whiteboards in all halls'),
                  _buildFacilityRow(Icons.biotech, 'Modern Physics, Chemistry & Biology Laboratories'),
                  _buildFacilityRow(Icons.local_library, 'Central Library with 15,000+ books & periodicals'),
                  _buildFacilityRow(Icons.sports_volleyball, 'Dedicated Athletic Grounds, Badminton & Kho-Kho court'),
                  _buildFacilityRow(Icons.solar_power, 'Eco-Friendly Campus with 50kW Rooftop Solar System'),
                  _buildFacilityRow(Icons.security, '24x7 CCTV Surveillance & Safe Transport Zone'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Contact & Administrative Directory
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Official Contact & Affiliation',
                    style: TextStyle(fontFamily: 'Outfit', fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                  const SizedBox(height: 10),
                  _buildContactItem(Icons.verified, 'PSEB School Code: 07412 • Smart ID: SM-BTI-01'),
                  _buildContactItem(Icons.phone, details['phone']),
                  _buildContactItem(Icons.email, details['email']),
                  _buildContactItem(Icons.pin_drop, details['address']),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(fontSize: 11, color: AppColors.outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFacilityRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.primaryContainer),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 13, color: AppColors.onSurface)),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.outline),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
          ),
        ],
      ),
    );
  }
}
