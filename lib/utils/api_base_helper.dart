import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:http/io_client.dart';
import 'package:http_interceptor/http_interceptor.dart' as customHttp;
import 'package:path/path.dart';
import 'package:http/http.dart' as flutter_http;
import 'package:travel_claim/configs/api_constants.dart';
import 'package:travel_claim/configs/app_config.dart';
import 'package:travel_claim/modules/login/controllers/auth_controller.dart';
import 'package:travel_claim/utils/app_exception.dart';
import 'package:travel_claim/utils/shared_preferences_data_provider.dart';

class ApiBaseHelper {
  final String _baseUrl = AppConfig.baseUrl;

  final Map<String, String> _headers = AppConfig.headers;
  final Map<String, String> _headersMultipart = AppConfig.headersMultipart;
  late dynamic http;

  ApiBaseHelper() {
    http = customHttp.InterceptedClient.build(
        interceptors: [
          CsmApiInterceptor(),
        ],
        retryPolicy: ExpiredTokenRetryPolicy(),
        requestTimeout: const Duration(seconds: 10));
  }

  Future<IOClient> createIoClient() async {
    // Create a custom SecurityContext
    SecurityContext context = SecurityContext();

    // Create the HttpClient with badCertificateCallback
    final httpClient = HttpClient(context: context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    return IOClient(httpClient);
  }

  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    dynamic responseJson;
    try {
      if (headers != null) {
        headers.addAll(_headers);
      }
      var uri =
          Uri.parse(_baseUrl + url).replace(queryParameters: queryParameters);
      print("the url is get here $uri");

      //     final client = await createIoClient();

      // // Perform the GET request using the IOClient
      // final response = await client.get(uri, headers: headers);

      final response = await http.get(uri, headers: headers); //original
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataTimeOutException('Connection timeout.');
    }
    return responseJson;
  }

  Future<dynamic> post(String url,
      {Map<String, dynamic> body = const {},
      Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      if (headers != null) {
        headers.addAll(_headers);
      }
      var uri = Uri.parse(_baseUrl + url);
      print("the url is post here $uri");

      final client = await createIoClient();
      final response = await client
          .post(uri, body: jsonEncode(body), headers: headers)
          .timeout(Duration(seconds: 30));

      // final response = await http
      //     .post(uri, body: jsonEncode(body), headers: headers)
      //     .timeout(Duration(seconds: 30));
      print(body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataTimeOutException('Connection timeout.');
    }
    return responseJson;
  }

  Future<dynamic> patch(String url,
      {Map<String, dynamic> body = const {},
      Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      if (headers != null) {
        headers.addAll(_headers);
      }
      var uri = Uri.parse(_baseUrl + url);
      final response =
          await http.patch(uri, body: jsonEncode(body), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataTimeOutException('Connection timeout.');
    }
    return responseJson;
  }

  Future<dynamic> postMultipart(String url,
      {Map<String, String>? body,
      Map<String, String>? headers,
      required String key,
      String file = '',
      List<String> files = const [],
      bool isPut = false,
      String? baseUrl}) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse((baseUrl ?? _baseUrl) + url);
      var request = customHttp.MultipartRequest(
        isPut
            ? customHttp.HttpMethod.PUT.asString
            : customHttp.HttpMethod.POST.asString,
        uri,
      );

      if (headers != null) {
        headers.addAll(_headersMultipart);
        request.headers.addAll(headers);
      }
      if (body != null) {
        request.fields.addAll(body);
      }

      if (file.isNotEmpty) {
        request.files.add(await customHttp.MultipartFile.fromPath(key, file));
      }

      if (files.isNotEmpty) {
        for (var element in files) {
          request.files
              .add(await customHttp.MultipartFile.fromPath(key, element));
          print(element);
        }
      }

      final streamedResponse = await http.send(request);
      final response = await customHttp.Response.fromStream(streamedResponse);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataTimeOutException('Connection timeout.');
    }
    return responseJson;
  }

  Future<dynamic> put(String url,
      {Map<String, dynamic> body = const {},
      Map<String, String> header = const {}}) async {
    dynamic responseJson;
    try {
      header.addAll(_headers);
      var uri = Uri.parse(_baseUrl + url);
      final response =
          await http.put(uri, body: jsonEncode(body), headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataTimeOutException('Connection timeout.');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url,
      {Map<String, String> header = const {}}) async {
    dynamic responseJson;
    try {
      header.addAll(_headers);
      var uri = Uri.parse(_baseUrl + url);
      final response = await http.delete(uri, headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataTimeOutException('Connection timeout.');
    }
    return responseJson;
  }
}

dynamic _returnResponse(response) {
  debugPrint(
      "${response.request.url.toString()}\n${response.request.headers.toString()}\n\n${response.statusCode}\n${response.body}"); // \n${response.request.body.toString()}
  switch (response.statusCode) {
    case 200:
    case 201:
    case 204:
    case 400:
    case 403:
    case 404:
    case 422:
      return json.decode(response.body.toString());
    case 401:
      throw UnauthorisedException(
          json.decode(response.body.toString())['message'] ??
              response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
  }
}

class CsmApiInterceptor implements customHttp.InterceptorContract {
  @override
  Future<customHttp.BaseRequest> interceptRequest(
      {required customHttp.BaseRequest request}) async {
    var preferences = SharedPreferencesDataProvider();

    String token = await preferences.getAccessToken();
    print('auth token: $token');

    if (token.isNotEmpty) {
      request.headers["Authorization"] = "Bearer $token";
    }
    request.headers['Content-Type'] = 'application/json';
    return request;
  }

  @override
  Future<customHttp.BaseResponse> interceptResponse(
      {required customHttp.BaseResponse response}) async {
    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() {
    return Future.value(true);
  }

  @override
  Future<bool> shouldInterceptResponse() {
    return Future.value(true);
  }
}

class ExpiredTokenRetryPolicy extends customHttp.RetryPolicy {
  @override
  int get maxRetryAttempts => 2;

  @override
  Future<bool> shouldAttemptRetryOnResponse(
      customHttp.BaseResponse response) async {
    if (response.statusCode == 401 &&
        !response.request!.url.toString().contains(ApiConstants.login) &&
        !response.request!.url.toString().contains(ApiConstants.logout)) {
      log("Retrying request...");
      // call refresh api
      try {
        late final _preferences = SharedPreferencesDataProvider();
        String refreshToken = await _preferences.getRefreshToken();
        final headers = AppConfig.headers;
        var uri = Uri.parse(AppConfig.baseUrl + ApiConstants.refreshToken);
        print(jsonEncode({'random_string': refreshToken}));
        final response = await flutter_http.post(uri,
            headers: headers,
            body: jsonEncode({'random_string': refreshToken}));
        log(response.statusCode.toString());
        log(response.body);
        if (response.statusCode == 200) {
          var responseJson = json.decode(response.body.toString());

          if (responseJson.containsKey('statusCode') &&
              responseJson['statusCode'] == 401) {
            if (!Get.isRegistered<AuthController>()) {
              Get.create(() => AuthController());
            }
            Get.find<AuthController>().logout();
            return false;
          }

          if (!responseJson.containsKey('token')) {
            return false;
          }
          String accessToken = responseJson['token'];
          //String refreshToken = responseJson['data']['refresh'];

          _preferences.saveAccessToken(accessToken);
          // _preferences.saveRefreshToken(refreshToken);
          log("token saved");
          return true;
        } else {
          print('logout from expired token');
          if (!Get.isRegistered<AuthController>()) {
            Get.create(() => AuthController());
          }
          Get.find<AuthController>().logout();
          Fluttertoast.showToast(
              msg: "Session expired! Please login.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
          return false;
        }
      } on SocketException {
        log("Error");
        if (!Get.isRegistered<AuthController>()) {
          Get.create(() => AuthController());
        }
        Get.find<AuthController>().logout();
        Fluttertoast.showToast(
            msg: "Session expired! Please login.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      } catch (_) {
        log("Error: ${_.toString()}");
        if (!Get.isRegistered<AuthController>()) {
          Get.create(() => AuthController());
        }
        Get.find<AuthController>().logout();
        Fluttertoast.showToast(
            msg: "Session expired! Please login.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      }
    }
    return false;
  }
}
