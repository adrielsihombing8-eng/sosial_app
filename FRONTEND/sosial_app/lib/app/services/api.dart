import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:sosial_app/app/services/auth_store.dart';
import 'package:sosial_app/app/util/constants.dart';

class Api {
  static String BaseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: "$apiUrl",
  );

  static Future<Map<String, dynamic>> register(
    Map<String, dynamic> data,
  ) async {
    var url = Uri.parse("$BaseUrl$authUser$registerUser");

    try {
      final res = await http.post(url, body: jsonEncode(data));

      final result = jsonDecode(res.body);
      print(jsonDecode(res.body));
      if (res.statusCode == 201) {
        var result = jsonDecode(res.body);
        await AuthStore.saveTokens(result['token'], result['refreshToken']);

        return {
          "statuscode": res.statusCode,
          "_id": result['_id'],
          "username": result['username'],
          "email": result['email'],
        };
      } else {
        return {
          "statusCode": res.statusCode,
          "messanges": result['messange'] ?? "",
        };
      }
    } catch (err) {
      print(err.toString());
      return {"statusCode": 0, "messanges": err.toString()};
    }
  }

  static Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    var url = Uri.parse("$BaseUrl$authUser$loginUser");

    try {
      final res = await http.post(url, body: jsonEncode(data));

      final result = jsonDecode(res.body);
      if (res.statusCode == 200) {
        var result = jsonDecode(res.body);
        await AuthStore.saveTokens(result['token'], result['refreshToken']);

        return {
          "statuscode": res.statusCode,
          "_id": result['_id'],
          "username": result['username'],
          "email": result['email'],
        };
      } else {
        return {"statuscode": res.statusCode, "messange": result['messange']};
      }
    } catch (err) {
      return {"statusCode": 0, "messanges": err.toString()};
    }
  }

  static Future<bool> cekToken(String token) async {
    var Url = Uri.parse("$BaseUrl$authUser$authCek");

    try {
      var res = await http.get(
        Url,
        headers: {"Authorization": "Bearer $token"},
      );
      if (res.statusCode == 200) {
        var result = jsonDecode(res.body);
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err.toString());
      return false;
    }
  }
}
