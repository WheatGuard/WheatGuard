import 'package:flutter/material.dart';

import '../widgets/footer.dart';
import '../widgets/navbar.dart';
import '../widgets/wheat_cycle_slider.dart';
import 'upload_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061A0B),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavbar(),

            LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 700;
                bool isTablet =
                    constraints.maxWidth >= 700 && constraints.maxWidth < 1100;

                double titleSize = isMobile ? 40 : isTablet ? 56 : 72;
                double subtitleSize = isMobile ? 16 : isTablet ? 20 : 24;
                double buttonTextSize = isMobile ? 14 : isTablet ? 16 : 18;
                double cardTitleSize = isMobile ? 18 : isTablet ? 20 : 22;
                double cardTextSize = isMobile ? 14 : isTablet ? 15 : 16;
                double iconSize = isMobile ? 45 : isTablet ? 50 : 55;

                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 80,
                    vertical: isMobile ? 50 : 100,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/bg.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(isMobile ? 22 : 30),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "WheatGuard",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: titleSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          "AI-powered wheat disease detection system helping farmers diagnose crop diseases quickly and accurately.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: subtitleSize,
                            height: 1.6,
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 40),

                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          alignment: WrapAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UploadScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.upload,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Upload Image",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: buttonTextSize,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 22 : 30,
                                  vertical: isMobile ? 14 : 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),

                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UploadScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.analytics,
                                color: Colors.white,
                              ),
                              label: Text(
                                "AI Detection",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: buttonTextSize,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 22 : 30,
                                  vertical: isMobile ? 14 : 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 70),

                        Wrap(
                          spacing: 25,
                          runSpacing: 25,
                          alignment: WrapAlignment.center,
                          children: [
                            featureCard(
                              Icons.bug_report,
                              "Disease Detection",
                              "Detect multiple wheat diseases using AI.",
                              cardTitleSize,
                              cardTextSize,
                              iconSize,
                            ),
                            featureCard(
                              Icons.health_and_safety,
                              "Crop Health",
                              "Monitor wheat crop health instantly.",
                              cardTitleSize,
                              cardTextSize,
                              iconSize,
                            ),
                            featureCard(
                              Icons.analytics,
                              "Confidence Score",
                              "Get accurate prediction confidence.",
                              cardTitleSize,
                              cardTextSize,
                              iconSize,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 40,
              ),
              child: Center(
                child: WheatCycleSlider(),
              ),
            ),

            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget featureCard(
    IconData icon,
    String title,
    String subtitle,
    double titleSize,
    double textSize,
    double iconSize,
  ) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white12,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: iconSize,
            color: Colors.greenAccent,
          ),

          const SizedBox(height: 20),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: textSize,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}