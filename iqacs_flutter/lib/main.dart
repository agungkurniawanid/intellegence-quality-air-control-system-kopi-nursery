import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iqacs/screens/splash_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  runApp(
    ProviderScope(
      child: ResponsiveBreakpoints.builder(
        breakpoints: [
          const Breakpoint(start: 0, end: 600, name: 'MOBILE_SMALL'),
          const Breakpoint(start: 600, end: 768, name: 'MOBILE_LARGE'),
          const Breakpoint(start: 768, end: 1024, name: 'TABLET'),
          const Breakpoint(start: 1024, end: 1280, name: 'LAPTOP_SMALL'),
          const Breakpoint(start: 1280, end: 1536, name: 'LAPTOP_MEDIUM'),
          const Breakpoint(start: 1536, end: 1920, name: 'LATPOP_LARGE'),
          const Breakpoint(start: 1920, end: double.infinity, name: '4K'),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IQACS Kopi Nursery',
      home: SplashScreen(),
    );
  }
}
