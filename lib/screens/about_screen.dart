import 'package:flutter/material.dart';

import '../widgets/footer.dart';
import '../widgets/navbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            color: Colors.black.withValues(alpha: 0.4),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                const CustomNavbar(),

                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isMobile = constraints.maxWidth < 700;
                    bool isTablet = constraints.maxWidth >= 700 &&
                        constraints.maxWidth < 1100;

                    double titleSize =
                        isMobile ? 28 : isTablet ? 32 : 34;

                    double bodySize =
                        isMobile ? 15 : isTablet ? 17 : 18;

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 20 : 40,
                        vertical: isMobile ? 60 : 100,
                      ),
                      child: Center(
                        child: Container(
                          width: isMobile ? double.infinity : 700,
                          padding: EdgeInsets.all(
                            isMobile ? 25 : 40,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "About WheatGuard",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: titleSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 20),

                              Text(
                                "WheatGuard is an AI-powered wheat disease detection system developed as a Final Year Project. It helps farmers identify wheat diseases using deep learning technology.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: bodySize,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                const Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
