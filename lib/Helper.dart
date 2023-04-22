import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todo/pages/Home.dart';
import 'package:todo/pages/login.dart';
import 'package:todo/pages/signup.dart';

class Helper {
  static Future<void> SignUp(fullname, mobile, email, password) async {
    final response = await http
        .post(Uri.parse('https://api.abolfazlabasi.ir/api/register'), body: {
      'name': fullname,
      'phone': mobile,
      'email': email,
      'password': password
    });
    if (response.statusCode == 200) {
      var token = "Bearer " + jsonDecode(response.body)['token'];
      saveToken(token);
      Get.offAll(Homepage());
    }
  }

  static Future<void> Login(email, password) async {
    final response = await http.post(
        Uri.parse('https://api.abolfazlabasi.ir/api/login'),
        body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      var token = "Bearer " + jsonDecode(response.body)['token'];
      saveToken(token);
      Get.offAll(Homepage());
    }
  }

  static sendDataToServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var data = {
      'Authorization': '$token',
    };
    var response = await http
        .get(Uri.parse('https://api.abolfazlabasi.ir/api/user'), headers: data);
    return jsonDecode(response.body)['id'];
  }

  static Future<Widget> handel() async {
    bool authenticated = await Helper.isAuthenticated();
    if (authenticated) {
      return Homepage();
    } else {
      return LoginPage();
    }
  }

  static Future<bool> isAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token != null;
  }

  static Future<void> saveToken(String token) async {
    final Savetoken = await SharedPreferences.getInstance();
    await Savetoken.setString('token', token);
  }

  static Future<void> RemoveToken() async {
    final Savetoken = await SharedPreferences.getInstance();
    await Savetoken.remove('token');
  }
}
