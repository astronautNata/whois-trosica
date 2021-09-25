import 'dart:convert';

import 'package:dio/dio.dart';
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
      // final res = await Dio().post(Endpoints.WHOIS_API, queryParameters: {
      //   'domen': domen,
      // });
      // Map<String, dynamic> map = _parseResponse(res);

      String rawJson =
          '{"whois": {"owner": "string","register": "string","start": "long","end": "long"},"dns": {"nameservers": ["ns1", "ns2"],"ipAdresses": ["ip1", "ip2"],"dnsRecords": ["r1", "r2"]}}';
      Map<String, dynamic> map = jsonDecode(rawJson);

      return WhoisResponse.fromJson(map, domen);
    } on Exception catch (e) {
      throw NetworkExceptionParser.parseException(e);
    } on Failure {
      rethrow;
    }
  }

  Map<String, dynamic> _parseResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.data.toString());
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
