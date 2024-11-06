import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget cardInformationSuhuHomeShimmerEffect() {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      childAspectRatio: 0.9,
    ),
    itemCount: 2,
    itemBuilder: (BuildContext context, int index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: const BoxDecoration(
            color: Color(0xFFE8E8E8),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(5.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFF171717),
                  ),
                  child: Center(
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Colors.white, // Placeholder shimmer effect
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 100,
                height: 20,
                color: Colors.white, // Placeholder shimmer effect
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 15,
                    color: Colors.white, // Placeholder shimmer effect
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 120,
                    height: 15,
                    color: Colors.white, // Placeholder shimmer effect
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
