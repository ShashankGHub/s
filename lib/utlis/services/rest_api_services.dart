import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rova_23/models/auth_model.dart';
import 'package:rova_23/utlis/constants/api_end_points.dart';
import 'package:rova_23/utlis/helpers/app_exceptions.dart';

class ApiBaseHelper {
  final String _baseUrl = "http://65.0.95.51/";

  Future<dynamic> get(String url) async {
    var responseJson;

    Map<String, String> headers = {
      "Accept": "application/json",
      //   "Authorization": token
    };

    try {
      final response =
          await http.get(Uri.parse(_baseUrl + url), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("connection_error");
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    //print('Api Post, url $url');
    var responseJson;
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
    try {
      final response = await http.post(Uri.parse(_baseUrl + url),
          body: jsonEncode(body), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      //print('No net');
      throw FetchDataException("Connection error");
    }
    return responseJson;
  }

  Future<dynamic> uploadImageMediaPostRequest(String filename) async {
    var responseJson;
    try {
      Map<String, String> headers = {
        "accept": "application/json",
        "content-Type": "multipart/form-data"
      };

      var request = http.MultipartRequest(
          'POST', Uri.parse(_baseUrl + ApiEndPoints.tomatoEndPoints));
      request.headers.addAll(headers);
      request.files.add(http.MultipartFile('file',
          File(filename).readAsBytes().asStream(), File(filename).lengthSync(),
          filename: filename.split("/").last));
      print("${request}");
      // var res = await request.send();

      // print("this is the response${res}");
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("Connection error");
    }
    return responseJson;
  }

  Future<dynamic> generateOtp(Authmodel authmodel) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST', Uri.parse('http://192.168.0.108:2022/api/Users/signUp'));
      request.body =
          json.encode(authmodel);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return "Otp Sent";
      } else {}
    } catch (Exception) {
      print("error");
    } finally {
      return "error";
    }
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      throw BadRequestException(errorHandler(response));
    case 401:
    case 403:
      throw UnauthorisedException(response.statusCode.toString());
    case 422:
    case 419:
      throw FetchDataException(errorHandler(response));
    default:
      throw FetchDataException(response.statusCode.toString());
    //'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}

errorHandler(http.Response response) {
  var responseJson = json.decode(response.body.toString());
  final map = responseJson['errors'];
  if (!["", null, false, 0].contains(map)) {
    List errorsList = [];
    for (var key in map.keys) {
      errorsList.add(map[key]);
    }
    var errors = errorsList.expand((i) => i).toList();
    return errors.join('\n');
  } else {
    return responseJson['message'];
  }
}
