import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Auto-navigate to Login after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        _navigateToLogin();
      }
    });
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryContainer,
      body: SafeArea(
        child: GestureDetector(
          onTap: _navigateToLogin,
          child: Stack(
            children: [
              // Academic watermark icon in background
              Positioned.fill(
                child: Opacity(
                  opacity: 0.05,
                  child: Center(
                    child: Icon(
                      Icons.school_rounded,
                      size: 380,
                      color: AppColors.surfaceContainerLowest,
                    ),
                  ),
                ),
              ),

              // Ambient glowing blobs
              Positioned(
                top: -60,
                right: -60,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryFixedDim.withOpacity(0.12),
                  ),
                ),
              ),
              Positioned(
                bottom: -60,
                left: -60,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondaryContainer.withOpacity(0.1),
                  ),
                ),
              ),

              // Main Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    // Top Status Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SMRISS SMART APP',
                          style: TextStyle(
                            color: AppColors.primaryFixedDim,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.wifi, size: 13, color: AppColors.primaryFixed),
                              SizedBox(width: 4),
                              Text('Online', style: TextStyle(color: AppColors.primaryFixed, fontSize: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const Spacer(flex: 2),

                    // Central Emblem Halo & Crest
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Backing Halo
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.tertiaryContainer.withOpacity(0.15),
                          ),
                        ),
                        // Crest Container
                        Container(
                          width: 120,
                          height: 120,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: AppColors.tertiaryContainer.withOpacity(0.7),
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.school,
                              size: 64,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Institutional Name Hierarchy
                    const Text(
                      'Shaheed Major Ravi Inder Singh Sandhu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Govt Girls Sen Sec Smart School',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryFixed,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, size: 15, color: AppColors.tertiaryFixed),
                        SizedBox(width: 4),
                        Text(
                          'Mall Road, Bathinda, Punjab',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.primaryFixedDim,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Motto Ribbon
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.tertiaryContainer.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(
                          color: AppColors.tertiaryContainer.withOpacity(0.5),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.military_tech, size: 16, color: AppColors.tertiaryFixed),
                          SizedBox(width: 6),
                          Text(
                            'ENDEAVOR TO EXCEL',
                            style: TextStyle(
                              color: AppColors.tertiaryFixed,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Text(
                      'Empowering Young Minds • Smart Education Portal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryFixedDim,
                        fontSize: 13,
                      ),
                    ),

                    const Spacer(flex: 3),

                    // Bottom Loading Bar & Status
                    SizedBox(
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: const LinearProgressIndicator(
                          minHeight: 4,
                          backgroundColor: AppColors.primaryDark,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.tertiary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Preparing smart learning environment...',
                      style: TextStyle(
                        color: AppColors.primaryFixedDim,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 24),
                    const Divider(color: Colors.white12),
                    const SizedBox(height: 8),

                    // Affiliation footer
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.verified_user, size: 14, color: AppColors.primaryFixedDim),
                        SizedBox(width: 6),
                        Text(
                          'Affiliated to PSEB / Punjab Education Department',
                          style: TextStyle(
                            color: AppColors.primaryFixedDim,
                            fontSize: 11,
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
      ),
    );
  }
}
