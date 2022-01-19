import 'dart:async';
import 'dart:io';
import 'app_exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
// Cleint for Account Creation

class BaseClient {
  static const int TIME_OUT_DURATION = 20;
  //POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = convert.jsonEncode(payloadObj);
    try {
      var response = await http
          .post(uri,
              headers: {"Content-type": "application/json; charset=UTF-8"},
              body: payload)
          .timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Took longer to respond', uri.toString());
    }
  }

  //PUT
  Future<dynamic> put(
      String baseUrl, String api, Map<String, dynamic> payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = convert.jsonEncode(payloadObj);
    try {
      var response = await http
          .put(uri,
              headers: {"Content-type": "application/json"}, body: payload)
          .timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Took longer to respond', uri.toString());
    }
  }

  //DELETE
  Future<dynamic> delete(
      String baseUrl, String api, Map<String, dynamic> payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = convert.jsonEncode(payloadObj);
    try {
      var response = await http
          .delete(uri,
              headers: {"Content-type": "application/json"}, body: payload)
          .timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Took longer to respond', uri.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = convert.jsonDecode(response.body);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(convert.jsonDecode(response.body)['message'],
            response.request.url.toString());
      case 401:
      case 404:
      case 403:
        throw UnAuthorizedException(
            convert.jsonDecode(response.body)['message'],
            response.request.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code: ${response.statusCode}',
            response.request.url.toString());
    }
  }
}
