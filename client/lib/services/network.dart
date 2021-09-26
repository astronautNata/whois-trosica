import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:whois_trosica/constants/endpoints.dart';
import 'package:whois_trosica/models/Failure.dart';
import 'package:whois_trosica/models/WhoisResponse.dart';
import 'package:whois_trosica/utils/exception_parser.dart';

class Network {
  Network._();

  static final Network _instance = Network._();

  static Network get instance => _instance;

  Future<WhoisResponse> getWhois({
    required String domen,
  }) async {
    try {
      final res =
          await Dio().get('http://192.168.0.29:5001/api/Search/${domen}');

      if (res.data.toString().isEmpty) throw Failure('Error');

      return WhoisResponse.fromJson(res.data, domen);
    } on Exception catch (e) {
      throw NetworkExceptionParser.parseException(e);
    } on Failure {
      rethrow;
    }
  }

  Future<bool> subscribe({
    required String domen,
    required String token,
    required String email,
  }) async {
    try {
      final res = await Dio().post(Endpoints.WHOIS_API, queryParameters: {
        'domain': domen,
        'token': token,
        'email': email,
      });

      if (res.data.toString().isEmpty) throw Failure('Error');

      return true;
    } on Exception catch (e) {
      throw NetworkExceptionParser.parseException(e);
    } on Failure {
      rethrow;
    }
  }

  Future<bool> cencelSubscription({
    required String domen,
    required String token,
    required String email,
  }) async {
    try {
      final res = await Dio().delete(Endpoints.WHOIS_API, queryParameters: {
        'domain': domen,
        'token': token,
        'email': email,
      });

      if (res.data.toString().isEmpty) throw Failure('Error');

      return true;
    } on Exception catch (e) {
      throw NetworkExceptionParser.parseException(e);
    } on Failure {
      rethrow;
    }
  }

  Map<String, dynamic> _parseResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson =
            json.decode(response.data.toString().replaceAll('\n', ''));
        return responseJson;
      case 400:
        throw Failure(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      case 401:
      case 403:
        throw Failure(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      case 500:
      default:
        throw Failure(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
