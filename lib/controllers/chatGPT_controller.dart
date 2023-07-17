// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:diyet_asistanim/models/chatGPT_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GptController extends GetxController {
  final String text;
  Rx<ChatGptModel?> chatGptResponse = Rx<ChatGptModel?>(null);
  var isLoading = false.obs;

  GptController(this.text);

  @override
  void onInit() {
    sendRequestToGPT(text);
    super.onInit();
  }

  Future<void> sendRequestToGPT(String prompt) async {
    try {
      isLoading(true);
      final url = Uri.parse('https://api.openai.com/v1/completions');
      final response = await http.post(
        url,
        headers: {
          'Authorization':
              'Bearer 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',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "model": "text-davinci-003",
            "prompt": prompt,
            "temperature": 0,
            "max_tokens": 300
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        chatGptResponse.value = ChatGptModel.fromJson(data);
      } else {
        throw Exception('Failed to connect to the API.');
      }
    } catch (e) {
      //print("Error while getting data is $e");
    } finally {
      isLoading(false);
    }
  }

  updateAiList(String aiList) async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    var store = firestore.collection(usersCollection).doc(uid);
    await store.set({'aiList': aiList}, SetOptions(merge: true));
  }
}
