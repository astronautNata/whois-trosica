import 'dart:io';

import 'package:whois_trosica/models/Failure.dart';

class NetworkExceptionParser {
  static Failure parseException(Exception ex) {
    if (ex is SocketException) {
      return Failure('No Internet connection');
    } else if (ex is HttpException) {
      return Failure("Couldn't find the domen");
    } else if (ex is FormatException) {
      return Failure('Bad response format');
    }

    return Failure(ex.toString());
  }
}
