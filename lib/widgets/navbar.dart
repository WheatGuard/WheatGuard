import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/upload_screen.dart';
import '../screens/about_screen.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 768;
        bool isVerySmall = constraints.maxWidth < 380;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isVerySmall ? 12 : 20,
            vertical: isVerySmall ? 12 : 15,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.85),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: isMobile
              ? mobileNavbar(context, isVerySmall)
              : desktopNavbar(context),
        );
      },
    );
  }

  Widget desktopNavbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Text(
              "🌾",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "WheatGuard",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            navButton(
              context,
              "Home",
              const HomeScreen(),
            ),
            navButton(
              context,
              "Upload",
              const UploadScreen(),
            ),
            navButton(
              context,
              "About",
              const AboutScreen(),
            ),
          ],
        ),
      ],
    );
  }

  Widget mobileNavbar(
    BuildContext context,
    bool isVerySmall,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            children: [
              Text(
                "🌾",
                style: TextStyle(
                  fontSize: isVerySmall ? 22 : 26,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  "WheatGuard",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isVerySmall ? 18 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        PopupMenuButton<String>(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: isVerySmall ? 24 : 28,
          ),
          color: const Color(0xFF052B12),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (value) {
            if (value == "home") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomeScreen(),
                ),
              );
            } else if (value == "upload") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const UploadScreen(),
                ),
              );
            } else if (value == "about") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AboutScreen(),
                ),
              );
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: "home",
              child: Text(
                "Home",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            PopupMenuItem(
              value: "upload",
              child: Text(
                "Upload",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            PopupMenuItem(
              value: "about",
              child: Text(
                "About",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget navButton(
    BuildContext context,
    String text,
    Widget page,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}