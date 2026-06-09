import 'dart:async';

import 'package:flutter/material.dart';

class WheatCycleSlider extends StatefulWidget {
  const WheatCycleSlider({super.key});

  @override
  State<WheatCycleSlider> createState() => _WheatCycleSliderState();
}

class _WheatCycleSliderState extends State<WheatCycleSlider> {
  int currentIndex = 0;

  late Timer timer;

  final List<Map<String, String>> items = [
    {
      "image": "assets/seed.jpg",
      "title": "Wheat Seeds",
      "desc": "Healthy wheat seeds are selected for cultivation."
    },
    {
      "image": "assets/sowing.jpg",
      "title": "Seed Sowing",
      "desc": "Seeds are planted carefully in prepared soil."
    },
    {
      "image": "assets/growth.jpg",
      "title": "Crop Growth",
      "desc": "Wheat plants begin healthy vegetative growth."
    },
    {
      "image": "assets/wheatfield.jpg",
      "title": "Field Development",
      "desc": "The wheat field becomes dense and productive."
    },
    {
      "image": "assets/harvest.jpg",
      "title": "Harvest Stage",
      "desc": "Mature wheat crops are harvested successfully."
    },
  ];

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        setState(() {
          currentIndex = (currentIndex + 1) % items.length;
        });
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        bool isMobile = constraints.maxWidth < 700;
        bool isTablet =
            constraints.maxWidth >= 700 && constraints.maxWidth < 1100;

        double cardHeight = isMobile ? 380 : isTablet ? 460 : 520;
        double titleSize = isMobile ? 16 : isTablet ? 21 : 24;
        double descSize = isMobile ? 14 : isTablet ? 17 : 19;
        double paddingSize = isMobile ? 20 : isTablet ? 30 : 40;

        return Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 1100,
            ),
            width: double.infinity,
            height: cardHeight,
            margin: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: AssetImage(
                  items[currentIndex]["image"]!,
                ),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.75),
                    Colors.black.withValues(alpha: 0.25),
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(paddingSize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 16,
                        vertical: isMobile ? 6 : 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        items[currentIndex]["title"]!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: titleSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Container(
                      constraints: BoxConstraints(
                        maxWidth: isMobile ? double.infinity : 600,
                      ),
                      child: Text(
                        items[currentIndex]["desc"]!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: descSize,
                          height: 1.7,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Row(
                      children: List.generate(
                        items.length,
                        (index) {
                          bool isActive = currentIndex == index;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            margin: const EdgeInsets.only(right: 8),
                            width: isActive ? 28 : 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Colors.white
                                  : Colors.white54,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}