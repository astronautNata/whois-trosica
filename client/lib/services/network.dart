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
    required String? token,
    required String? email,
  }) async {
    try {
      final res = await Dio().post(Endpoints.WHOIS_API, data: {
        'domain': domen,
        'token': token,
        'email': email,
        'test': true,
      });

      return true;
    } on Exception catch (e) {
      throw NetworkExceptionParser.parseException(e);
    } on Failure {
      rethrow;
    }
  }

  Future<bool> cencelSubscription({
    required String domen,
    required String? token,
    required String? email,
  }) async {
    try {
      final res = await Dio().delete(Endpoints.WHOIS_API, data: {
        'domain': domen,
        'token': token,
        'email': email,
      });

      return true;
    } on Exception catch (e) {
      throw NetworkExceptionParser.parseException(e);
    } on Failure {
      rethrow;
    }
  }
}
