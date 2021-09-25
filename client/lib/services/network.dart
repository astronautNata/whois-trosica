import 'dart:convert';

import 'package:whois_trosica/models/WhoisResponse.dart';

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

      String rawJson =
          '{"whois": {"owner": "string","register": "string","start": "long","end": "long"},"dns": {"nameservers": ["ns1", "ns2"],"ipAdresses": ["ip1", "ip2"],"dnsRecords": ["r1", "r2"]}}';
      Map<String, dynamic> map = jsonDecode(rawJson);

      return WhoisResponse.fromJson(map, domen);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
