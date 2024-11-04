import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iqacs/providers/page_provider.dart';
import 'package:iqacs/screens/home_screen.dart';
import 'package:iqacs/screens/profile_screen.dart';
import 'package:iqacs/screens/report_screen.dart';
import 'package:iqacs/screens/scanner_screen.dart';
import 'package:iqacs/widgets/custom_button_nav.dart';

class PageScreen extends ConsumerWidget {
  const PageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: MainContent()),
      bottomNavigationBar: CustomBottomNavigationBarWidget(),
    );
  }
}

class MainContent extends ConsumerWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(pageControllerProvider);
    final pages = [
      const Center(child: HomeScreen()),
      const Center(child: ScannerScreen()),
      const Center(child: ReportScreen()),
      const Center(child: ProfileScreen()),
    ];

    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        ref.read(selectedIndexProvider.notifier).state = index;
      },
      children: pages,
    );
  }
}
