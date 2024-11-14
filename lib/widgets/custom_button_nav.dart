import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iqacs/providers/page_provider.dart';

class CustomBottomNavigationBarWidget extends ConsumerWidget {
  const CustomBottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    final pageController = ref.watch(pageControllerProvider);

    return Container(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFF171717),
          borderRadius: const BorderRadius.all(Radius.circular(14.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
                'assets/icons/home', 0, selectedIndex, ref, pageController),
            _buildNavItem(
                'assets/icons/scan', 1, selectedIndex, ref, pageController),
            _buildNavItem(
                'assets/icons/docs', 2, selectedIndex, ref, pageController),
            _buildNavItem(
                'assets/icons/user', 3, selectedIndex, ref, pageController),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconBasePath, int index, int selectedIndex,
      WidgetRef ref, PageController pageController) {
    final isSelected = selectedIndex == index;
    final iconPath =
        isSelected ? '$iconBasePath-green.png' : '$iconBasePath-white.png';

    return InkWell(
      onTap: () {
        ref.read(selectedIndexProvider.notifier).state = index;
        pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            width: 28,
            height: 28,
          ),
        ),
      ),
    );
  }
}
