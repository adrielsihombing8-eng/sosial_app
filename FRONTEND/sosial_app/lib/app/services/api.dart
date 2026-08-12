import 'dart:convert';
import 'dart:io';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosial_app/app/model/authModel.dart';
import 'package:sosial_app/app/services/auth_store.dart';
import 'package:sosial_app/app/services/postservices.dart';
import 'package:sosial_app/app/util/constants.dart';

class Api {
  static String BaseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: "$apiUrl",
  );

  //register
  static Future<Map<String, dynamic>> register(
    Map<String, dynamic> data,
  ) async {
    var url = Uri.parse("$BaseUrl$authUser$registerUser");

    try {
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

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

  //login
  static Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    var url = Uri.parse("$BaseUrl$authUser$loginUser");

    try {
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      final result = jsonDecode(res.body);
      if (res.statusCode == 200) {
        var result = jsonDecode(res.body);
        await AuthStore.saveTokens(result['token'], result['refreshToken']);

        print("berhasil login");
        return {
          "statuscode": res.statusCode,
          "_id": result['_id'],
          "username": result['username'],
          "email": result['email'],
        };
      } else {
        print("gagal login");
        return {"statuscode": res.statusCode, "messange": result['messange']};
      }
    } catch (err) {
      return {"statusCode": 0, "messanges": err.toString()};
    }
  }

  //cektoken
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

  //refresh token
  static Future<String?> refreshToken() async {
    final refreshToken = await AuthStore.getRefreshToken();
    if (refreshToken == null) return null;
    var Url = Uri.parse("$BaseUrl$authUser$refreshToken");

    try {
      var res = await http.post(
        Url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (res.statusCode == 200) {
        var result = jsonDecode(res.body);
        await AuthStore.saveToken(result['token']);
      } else {
        return null;
      }
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  //load data content
  static Future<Postservices> getPosts({String? cursor, int limit = 10}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final queryParams = {
      'limit': limit.toString(),
      if (cursor != null) 'cursor': cursor,
    };

    final uri = Uri.parse(
      '$BaseUrl$contenUrl$loadData',
    ).replace(queryParameters: queryParams);

    var res = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode == 401) {
      final newToken = await refreshToken();
      if (newToken == null) {
        throw Exception('SESSION_EXPIRED');
      }
      await prefs.setString('token', newToken);
      res = await http.get(uri, headers: {'Authorization': 'Bearer $newToken'});
    }

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return Postservices.fromJson(data);
    } else {
      throw Exception('Gagal mengambil post: ${res.statusCode}');
    }
  }

  //send post content
  static Future<Postservices> addData(
    String title,
    String content,
    File? imageFile,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final uri = Uri.parse('$BaseUrl$contenUrl$addcontent');

    Future<http.StreamedResponse> sendRequest(String? authToken) async {
      final request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $authToken';
      request.fields['content'] = content;

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path),
        );
      }

      return await request.send();
    }

    var streamedResponse = await sendRequest(token);
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 401) {
      final newToken = await refreshToken();
      if (newToken == null) {
        throw Exception('Sesi berakhir, silakan login ulang');
      }

      await AuthStore.saveToken(newToken);

      streamedResponse = await sendRequest(newToken);
      response = await http.Response.fromStream(streamedResponse);
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Postservices.fromJson(data);
    } else {
      throw Exception('Gagal menambahkan post: ${response.statusCode}');
    }
  }

  //find user
  static Future<Authmodel> userData(String userId, String token) async {
    Authmodel user;
    var url = Uri.parse(
      "$BaseUrl$contenUrl$findUser",
    ).replace(queryParameters: {'userId': userId});
    try {
      var res = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        var userJson = data['userdata'];
        user = Authmodel(
          id: userJson['_id'],
          username: userJson['username'],
          email: userJson['email'],
        );

        return user;
      } else {
        user = Authmodel(id: null, username: null, email: null);
        return user;
      }
    } catch (err) {
      throw new Exception('ERROR_DATA');
    }
  }

  //add data of view
  static Future<void> addPostView(String postId, String token) async {
    final url = Uri.parse('$BaseUrl');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 401) {
      throw Exception('SESSION_EXPIRED');
    }
  }
}
