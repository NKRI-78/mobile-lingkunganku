import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../modules/app/bloc/app_bloc.dart';
import 'injections.dart';

class BaseNetworkClient extends http.BaseClient {
  String get token => getIt<AppBloc>().state.token;
  Map<String, String> get _defaultHeaders => {
        // 'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

  final http.Client _httpClient = http.Client();

  void removeTokenFromHeader() {
    _mergedHeaders({HttpHeaders.authorizationHeader: ''});
  }

  addTokenToHeader(String token) {
    _mergedHeaders({HttpHeaders.authorizationHeader: 'Bearer $token'});
  }

  Map<String, String> _mergedHeaders(Map<String, String> headers) {
    return {..._defaultHeaders, ...headers};
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _httpClient.send(request).then((response) async {
      _checkError(await http.Response.fromStream(response));

      return response;
    });
  }

  @override
  Future<Response> get(url, {Map<String, String>? headers}) {
    return _httpClient
        .get(url,
            headers:
                headers != null ? _mergedHeaders(headers) : _defaultHeaders)
        .then(_checkError);
  }

  @override
  Future<Response> post(url,
      {Map<String, String>? headers, dynamic body, Encoding? encoding}) {
    return _httpClient
        .post(url,
            headers:
                headers != null ? _mergedHeaders(headers) : _defaultHeaders,
            body: body,
            encoding: encoding)
        .then(_checkError);
  }

  @override
  Future<Response> patch(url,
      {Map<String, String>? headers, dynamic body, Encoding? encoding}) {
    return _httpClient
        .patch(url,
            headers:
                headers != null ? _mergedHeaders(headers) : _defaultHeaders,
            body: body,
            encoding: encoding)
        .then(_checkError);
  }

  @override
  Future<Response> put(url,
      {Map<String, String>? headers, dynamic body, Encoding? encoding}) {
    return _httpClient
        .put(url,
            headers:
                headers != null ? _mergedHeaders(headers) : _defaultHeaders,
            body: body,
            encoding: encoding)
        .then(_checkError);
  }

  @override
  Future<Response> head(url, {Map<String, String>? headers}) {
    return _httpClient
        .head(url,
            headers:
                headers != null ? _mergedHeaders(headers) : _defaultHeaders)
        .then(_checkError);
  }

  @override
  Future<Response> delete(url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return _httpClient
        .delete(url,
            headers:
                headers != null ? _mergedHeaders(headers) : _defaultHeaders)
        .then(_checkError);
  }

  Response _checkError(Response response) {
    // final int statusCode = response.statusCode;

    // if (statusCode < 200 || statusCode >= 400) {
    //   // ✅ Perbaikan batas error
    //   throw Exception("HTTP Error: ${response.statusCode}, ${response.body}");
    // }
    return response;
  }
}
