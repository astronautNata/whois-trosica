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
      final res = await Dio().get(Endpoints.WHOIS_API, queryParameters: {
        'domain': domen,
      });
      // var map = _parseResponse(res);

      // String rawJson =
      //     '{"owner":"Individual","registrar":"mCloud doo","registrationDate":"10.03.2008 12:30:17","expirationDate":"10.03.2022 12:30:17","nameservers":["ns.bg2.ha.rs - 91.222.7.7","ns.bg3.ha.rs - 87.237.206.34","bg1.mns-dns.net -","us1.mns-dns.com -"],"completeInfo":""}';
      // Map<String, dynamic> map = jsonDecode(rawJson);

      return WhoisResponse.fromJson(res.data, domen);
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
