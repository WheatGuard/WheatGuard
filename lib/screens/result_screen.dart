import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {

  final String disease;
  final String confidence;
  final String cure;

  // NEW
  final String confidenceLabel;

  final Uint8List originalImage;

  final String highlightedImage;

  const ResultScreen({
    super.key,

    required this.disease,

    required this.confidence,

    required this.cure,

    required this.confidenceLabel,

    required this.originalImage,

    required this.highlightedImage,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.green.shade900,

      body: LayoutBuilder(

        builder: (context, constraints) {

          bool isMobile =
              constraints.maxWidth < 700;

          bool isTablet =
              constraints.maxWidth >= 700 &&
              constraints.maxWidth < 1100;

          double headingSize =
              isMobile ? 26 : isTablet ? 29 : 32;

          double diseaseSize =
              isMobile ? 22 : isTablet ? 25 : 28;

          double confidenceSize =
              isMobile ? 17 : isTablet ? 20 : 22;

          double cureSize =
              isMobile ? 15 : isTablet ? 17 : 18;

          Uint8List? highlightedBytes;

          // Decode highlighted image
          if (highlightedImage.isNotEmpty) {

            try {

              highlightedBytes =
                  base64Decode(
                highlightedImage,
              );

            } catch (e) {
              highlightedBytes = null;
            }
          }

          return Center(

            child: SingleChildScrollView(

              padding: EdgeInsets.symmetric(
                horizontal:
                    isMobile ? 20 : 40,
                vertical: 40,
              ),

              child: Container(

                width:
                    isMobile
                        ? double.infinity
                        : 700,

                padding: EdgeInsets.all(
                  isMobile ? 25 : 40,
                ),

                decoration: BoxDecoration(

                  color: Colors.white.withValues(
                    alpha: 0.15,
                  ),

                  borderRadius:
                      BorderRadius.circular(25),
                ),

                child: Column(

                  mainAxisSize: MainAxisSize.min,

                  children: [

                    Text(

                      "Diagnosis Result",

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        color: Colors.white,

                        fontSize: headingSize,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ORIGINAL IMAGE
                    ClipRRect(

                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),

                      child: Image.memory(

                        originalImage,

                        height:
                            isMobile ? 220 : 280,

                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(

                      "Original Image",

                      style: TextStyle(

                        color: Colors.white70,

                        fontSize: 16,
                      ),
                    ),

                    // AI ANALYSIS IMAGE
                    if (highlightedBytes != null)
                      Column(

                        children: [

                          const SizedBox(height: 35),

                          ClipRRect(

                            borderRadius:
                                BorderRadius.circular(
                              18,
                            ),

                            child: Image.memory(

                              highlightedBytes,

                              height:
                                  isMobile
                                      ? 220
                                      : 280,

                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Text(

                            "AI Highlighted Analysis",

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(

                              color:
                                  Colors.orangeAccent,

                              fontSize: 17,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(

                            "Highlighted regions indicate areas influencing AI prediction.",

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(

                              color:
                                  Colors.white70,

                              height: 1.5,
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 35),

                    Text(

                      disease,

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        color: Colors.yellow,

                        fontSize: diseaseSize,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(

                      "Confidence: $confidence%",

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        color: Colors.white,

                        fontSize:
                            confidenceSize,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // CONFIDENCE LABEL
                    Container(

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(

                        color:
                            confidenceLabel ==
                                    "High Confidence"
                                ? Colors.green
                                : confidenceLabel ==
                                        "Moderate Confidence"
                                    ? Colors.orange
                                    : Colors.red,

                        borderRadius:
                            BorderRadius.circular(
                          30,
                        ),
                      ),

                      child: Text(

                        confidenceLabel,

                        style: const TextStyle(

                          color: Colors.white,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Text(

                      cure,

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        color: Colors.white,

                        fontSize: cureSize,

                        height: 1.7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
