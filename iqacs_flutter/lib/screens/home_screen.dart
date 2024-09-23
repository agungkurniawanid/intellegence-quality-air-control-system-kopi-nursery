import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iqacs/widgets/custom_appbar.dart';
import 'package:iqacs/widgets/custom_card.dart';
import 'package:iqacs/widgets/custom_filter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                const CustomAppbar(),
                const Gap(20),
                const CustomMainCard(),
                const Gap(20),
                const CustomFilterSuhuInformation(),
                const Gap(20),
                const CustomCardSuhu(),
                const Gap(10),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.9,
                  children: const [
                    CustomCardSprayer(),
                    CustomCardReportInformation(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
