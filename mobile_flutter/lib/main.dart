import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/analytics_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/roadmap_screen.dart';
import 'screens/settings_screen.dart';
import 'services/firebase_service.dart';
import 'services/notification_service.dart';
import 'services/progress_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var firebaseEnabled = true;
  try {
    await Firebase.initializeApp();
  } catch (_) {
    firebaseEnabled = false;
  }

  final firebaseService = FirebaseService();
  final notificationService = NotificationService();
  await notificationService.init();

  final progressService = ProgressService(firebaseService: firebaseService);
  await progressService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: progressService),
      ],
      child: RoadmapApp(
        firebaseService: firebaseService,
        notificationService: notificationService,
        firebaseEnabled: firebaseEnabled,
      ),
    ),
  );
}

class RoadmapApp extends StatelessWidget {
  const RoadmapApp({
    super.key,
    required this.firebaseService,
    required this.notificationService,
    required this.firebaseEnabled,
  });

  final FirebaseService firebaseService;
  final NotificationService notificationService;
  final bool firebaseEnabled;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '.NET Roadmap Tracker',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF38BDF8),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0E1A),
      ),
      home: firebaseEnabled
          ? StreamBuilder(
              stream: firebaseService.authStateChanges(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return LoginScreen(firebaseService: firebaseService);
                }
                return MainShell(
                  firebaseService: firebaseService,
                  notificationService: notificationService,
                );
              },
            )
          : MainShell(
              firebaseService: firebaseService,
              notificationService: notificationService,
            ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({
    super.key,
    required this.firebaseService,
    required this.notificationService,
  });

  final FirebaseService firebaseService;
  final NotificationService notificationService;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeDashboardScreen(),
      const RoadmapScreen(),
      const AnalyticsScreen(),
      const CalendarScreen(),
      SettingsScreen(notificationService: widget.notificationService),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('.NET Learning Tracker'),
        actions: [
          IconButton(
            onPressed: widget.firebaseService.signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: screens[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.menu_book), label: 'Roadmap'),
          NavigationDestination(icon: Icon(Icons.analytics), label: 'Analytics'),
          NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
