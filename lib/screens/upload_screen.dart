import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api_service.dart';
import '../widgets/footer.dart';
import '../widgets/navbar.dart';
import 'result_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  Uint8List? imageBytes;

  bool loading = false;

  Future pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (picked == null) return;

    imageBytes = await picked.readAsBytes();

    setState(() {});
  }

  Future predictDisease() async {
    if (imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select image"),
        ),
      );

      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final result = await ApiService.predictDisease(
        imageBytes!,
      );

      if (!mounted) return;

      setState(() {
        loading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            disease: result["disease"].toString(),
            confidence: result["confidence"].toString(),
            cure: result["cure"].toString(),
            confidenceLabel: result["confidence_label"].toString(),
            originalImage: imageBytes!,
            highlightedImage: result["highlighted_image"].toString(),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Backend connection failed",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/bg.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            color: Colors.black.withValues(
              alpha: 0.4,
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                const CustomNavbar(),

                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isMobile = constraints.maxWidth < 700;

                    bool isTablet =
                        constraints.maxWidth >= 700 &&
                        constraints.maxWidth < 1100;

                    double titleSize =
                        isMobile ? 24 : isTablet ? 28 : 32;

                    double buttonTextSize =
                        isMobile ? 14 : isTablet ? 16 : 18;

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 20 : 40,
                        vertical: isMobile ? 50 : 80,
                      ),
                      child: Center(
                        child: Container(
                          width: isMobile ? double.infinity : 700,
                          padding: EdgeInsets.all(
                            isMobile ? 22 : 40,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(
                              alpha: 0.15,
                            ),
                            borderRadius: BorderRadius.circular(
                              25,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Upload Wheat Leaf Image",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: titleSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 30),

                              if (imageBytes != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                  child: Image.memory(
                                    imageBytes!,
                                    height: isMobile ? 200 : 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                              const SizedBox(height: 25),

                              SizedBox(
                                width: isMobile ? double.infinity : 250,
                                child: ElevatedButton(
                                  onPressed: pickImage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: EdgeInsets.symmetric(
                                      vertical: isMobile ? 14 : 18,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        14,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "Choose Image",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: buttonTextSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              SizedBox(
                                width: isMobile ? double.infinity : 250,
                                child: ElevatedButton(
                                  onPressed:
                                      loading ? null : predictDisease,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    padding: EdgeInsets.symmetric(
                                      vertical: isMobile ? 14 : 18,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        14,
                                      ),
                                    ),
                                  ),
                                  child: loading
                                      ? const SizedBox(
                                          height: 22,
                                          width: 22,
                                          child:
                                              CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          "Predict Disease",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: buttonTextSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 60),

                const Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}