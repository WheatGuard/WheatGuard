import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  bool isSending = false;

  Future<void> sendMessage() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String message = messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
        ),
      );
      return;
    }

    setState(() {
      isSending = true;
    });

    try {
      final response = await http.post(
        Uri.parse("https://api.emailjs.com/api/v1.0/email/send"),
        headers: {
          "origin": "http://localhost",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "service_id": "service_u5kd69e",
          "template_id": "template_t4ocrms",
          "user_id": "Zd9zR5pw0ulY3OerU",
          "template_params": {
            "title": "New WheatGuard Message",
            "name": name,
            "email": email,
            "message": message,
            "time": DateTime.now().toString(),
          }
        }),
      );

      print(response.body);

      if (!mounted) return;

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Message Sent Successfully!"),
          ),
        );

        nameController.clear();
        emailController.clear();
        messageController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("Failed: ${response.body}"),
          ),
        );
      }
    } catch (e) {
      print(e);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error: $e"),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 700;
        bool isTablet = constraints.maxWidth >= 700 && constraints.maxWidth < 1100;

        double logoSize = isMobile ? 24 : isTablet ? 28 : 32;
        double headingSize = isMobile ? 22 : isTablet ? 26 : 30;
        double bodySize = isMobile ? 14 : isTablet ? 16 : 18;
        double buttonSize = isMobile ? 15 : isTablet ? 16 : 18;
        double copyrightSize = isMobile ? 12 : isTablet ? 14 : 16;
        double iconSize = isMobile ? 30 : isTablet ? 34 : 38;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 18 : isTablet ? 40 : 70,
            vertical: isMobile ? 35 : 50,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF012A12),
                Color(0xFF001F0E),
              ],
            ),
          ),
          child: Column(
            children: [
              Wrap(
                spacing: isMobile ? 25 : 50,
                runSpacing: isMobile ? 28 : 40,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: isMobile ? double.infinity : isTablet ? 280 : 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.grass,
                              color: Colors.amber,
                              size: iconSize,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "WheatGuard",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: logoSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isMobile ? 18 : 25),
                        Text(
                          "AI-powered wheat disease detection system helping farmers diagnose crop diseases quickly and accurately.",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: bodySize,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: isMobile ? double.infinity : isTablet ? 260 : 280,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Connect With Us",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: headingSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: isMobile ? 18 : 25),
                        Text(
                          "Email: wheatguard.ai@gmail.com",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: bodySize,
                          ),
                        ),
                        SizedBox(height: isMobile ? 14 : 20),
                        Text(
                          "Final Year Project — BS(IT)",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: bodySize,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: isMobile ? double.infinity : isTablet ? 330 : 360,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact Form",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: headingSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: isMobile ? 18 : 25),
                        textField(
                          controller: nameController,
                          hint: "Your Name",
                          fontSize: bodySize,
                        ),
                        SizedBox(height: isMobile ? 14 : 18),
                        textField(
                          controller: emailController,
                          hint: "Your Email",
                          fontSize: bodySize,
                        ),
                        SizedBox(height: isMobile ? 14 : 18),
                        textField(
                          controller: messageController,
                          hint: "Your Message",
                          maxLines: 5,
                          fontSize: bodySize,
                        ),
                        SizedBox(height: isMobile ? 18 : 25),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isSending ? null : sendMessage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(
                                vertical: isMobile ? 14 : 18,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isSending
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    "Send Message",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: buttonSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 32 : 50),
              const Divider(color: Colors.white24),
              SizedBox(height: isMobile ? 14 : 20),
              Text(
                "© 2026 WheatGuard | Developed by Ayesha Sadaf & Kinza Fayyaz",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: copyrightSize,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget textField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    required double fontSize,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white70,
          fontSize: fontSize,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}