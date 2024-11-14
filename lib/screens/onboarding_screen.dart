import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iqacs/providers/page_provider.dart';
import 'package:iqacs/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingModel {
  String? image;
  String? heading;
  String? description;
  String? textButton;

  OnboardingModel({
    this.image,
    this.heading,
    this.description,
    this.textButton,
  });
}

class OnboardingScreen extends ConsumerWidget {
  OnboardingScreen({super.key});

  final List<OnboardingModel> onboardingData = [
    OnboardingModel(
      image: "assets/images/onboarding/onboarding1.png",
      heading: "Welcome to!",
      description: "IQACS Nursery Coffee.",
      textButton: "Get Started",
    ),
    OnboardingModel(
      image: "assets/images/onboarding/onboarding2.png",
      heading: "Temperature & Humidity.",
      description: "Monitoring & Controlling.",
      textButton: "Next",
    ),
    OnboardingModel(
      image: "assets/images/onboarding/onboarding3.png",
      heading: "Greenhouse Coffe.",
      description: "Deteksi Penyakit Dini Bibit Kopi.",
      textButton: "Finish",
    ),
  ];

  Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('has_seen_onboarding') ?? false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(pageControllerOnboardingProvider);
    final currentIndex = ref.watch(selectedIndexOnboardingProvider);

    return FutureBuilder<bool>(
      future: hasSeenOnboarding(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          // Pengguna sudah pernah melihat onboarding, arahkan ke halaman login
          return const LoginScreen(title: "Login | IQACS");
        } else {
          // Tampilkan onboarding
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: onboardingData.length,
                      onPageChanged: (index) {
                        ref
                            .read(selectedIndexOnboardingProvider.notifier)
                            .state = index;
                      },
                      itemBuilder: (context, index) {
                        final item = onboardingData[index];
                        return Column(
                          children: [
                            if (index != 0)
                              Transform(
                                transform:
                                    Matrix4.translationValues(0.0, 80.0, 0.0),
                                child: Image(
                                  image: AssetImage(item.image ??
                                      "assets/images/onboarding/onboarding1.png"),
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                ).animate().fadeIn(duration: 1000.ms),
                              ),
                            Padding(
                              padding: index != 0
                                  ? const EdgeInsets.only(top: 120, left: 20)
                                  : const EdgeInsets.only(top: 60, left: 20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: index == 0
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.heading ?? "Welcome to!",
                                            style: GoogleFonts.poppins(
                                                color: const Color(0xFF171717),
                                                fontSize: 28,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            item.description ??
                                                "IQACS Nursery Coffee.",
                                            style: GoogleFonts.poppins(
                                                color: const Color(0xFF065F46),
                                                fontSize: 44,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ...[
                                            Text(
                                              item.heading ?? "Welcome to!",
                                              style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xFF171717),
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              item.description ??
                                                  "IQACS Nursery Coffee.",
                                              style: GoogleFonts.poppins(
                                                  color:
                                                      const Color(0xFF065F46),
                                                  fontSize: 44,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ].reversed,
                                        ],
                                      ),
                              ),
                            ),
                            if (index == 0)
                              ClipRect(
                                child: Transform(
                                  transform:
                                      Matrix4.translationValues(90.0, 0.0, 0.0),
                                  child: Image(
                                    image: AssetImage(item.image ??
                                        "assets/images/onboarding/onboarding1.png"),
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  ).animate().fadeIn(duration: 1000.ms),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(onboardingData.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: currentIndex == index ? 24.0 : 14.0,
                        height: 14.0,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? const Color(0xFF065F46)
                              : const Color(0xFFB0BEC5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: currentIndex == 2
                          ? MediaQuery.of(context).size.width * 0.6
                          : MediaQuery.of(context).size.width * 0.6,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (currentIndex < onboardingData.length - 1) {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('has_seen_onboarding', true);

                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen(
                                          title: "Login | IQACS",
                                        )),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF065F46),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                          child: Text(
                            onboardingData[currentIndex].textButton ??
                                "Get Started",
                            key: ValueKey<String>(
                                onboardingData[currentIndex].textButton!),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
