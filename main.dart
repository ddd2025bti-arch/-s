import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'theme/app_colors.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_navigation_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization notice: $e');
  }

  runApp(const SMRISSSmartApp());
}

class SMRISSSmartApp extends StatelessWidget {
  const SMRISSSmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMRISS GGSSS Bathinda Smart Portal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AuthGate(),
    );
  }
}

/// ==========================================
/// STRICT AUTHENTICATION GUARD
/// The Homepage MUST NOT open unless user is authenticated
/// via Gmail/Google Sign-In with google-services.json
/// ==========================================
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // While checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: AppColors.primaryContainer,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.tertiary),
            ),
          );
        }

        // User is authenticated via Google/Firebase -> Grant access to Homepage
        if (snapshot.hasData && snapshot.data != null) {
          return const MainNavigationScreen();
        }

        // User is NOT authenticated -> Lock Homepage & present Login / Welcome
        return const WelcomeScreen();
      },
    );
  }
}
