import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class ApiService {

  static Future<Map<String, dynamic>>
      predictDisease(
    Uint8List imageBytes,
  ) async {

    var request = http.MultipartRequest(

      "POST",

      Uri.parse(
        "https://wheatguard-wheatguard-backend.hf.space/predict",
      ),
    );

    request.files.add(

      http.MultipartFile.fromBytes(

        'image',

        imageBytes,

        filename: 'leaf.jpg',
      ),
    );

    var response = await request.send();

    var responseData =
        await response.stream.bytesToString();

    var decodedData =
        jsonDecode(responseData);

    return {

      "disease":
          decodedData["disease"],

      "confidence":
          decodedData["confidence"],

      "confidence_label":
          decodedData["confidence_label"],

      "cure":
          decodedData["cure"],

      // NEW
      "highlighted_image":
          decodedData["highlighted_image"] ?? "",
    };
  }
}