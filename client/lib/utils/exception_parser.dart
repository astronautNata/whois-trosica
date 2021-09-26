import 'dart:io';

import 'package:whois_trosica/i18n/strings.g.dart';
import 'package:whois_trosica/models/Failure.dart';

class NetworkExceptionParser {
  static Failure parseException(Exception ex) {
    if (ex is SocketException) {
      return Failure(t.no_internet_connection);
    } else if (ex is HttpException) {
      return Failure(t.cannot_find_domain);
    } else if (ex is FormatException) {
      return Failure(t.bad_response);
    }

    return Failure(ex.toString());
  }
}
