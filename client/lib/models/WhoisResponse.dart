class WhoisResponseList {
  final List<WhoisResponse> whoiss;

  WhoisResponseList({
    required this.whoiss,
  });

  factory WhoisResponseList.fromJson(
      Map<String, dynamic> json, String inputText) {
    var whoiss = json['data']['whoiss']
        .map<WhoisResponse>((post) => WhoisResponse.fromJson(post, inputText))
        .toList();

    return WhoisResponseList(
      whoiss: whoiss,
    );
  }
}

class WhoisResponse {
  String? domen;
  String? owner;
  String? registrar;
  DateTime? registrationDate;
  DateTime? expirationDate;
  List<String>? nameservers;
  String? completeInfo;

  WhoisResponse({
    required this.domen,
    required this.owner,
    required this.registrar,
    required this.registrationDate,
    required this.expirationDate,
    required this.nameservers,
    required this.completeInfo,
  });

  factory WhoisResponse.fromJson(Map<String, dynamic> json, String domen) =>
      WhoisResponse(
        domen: domen,
        owner: json['owner'],
        registrar: json['registrar'],
        registrationDate:
            DateTime.fromMillisecondsSinceEpoch(json['registrationDate']),
        expirationDate:
            DateTime.fromMillisecondsSinceEpoch(json['expirationDate']),
        nameservers: json['nameservers'].cast<String>(),
        completeInfo: json['completeInfo'],
      );

  factory WhoisResponse.fromSharedJson(Map<String, dynamic> json) =>
      WhoisResponse(
        domen: json['domen'],
        owner: json['owner'],
        registrar: json['registrar'],
        registrationDate: DateTime.fromMillisecondsSinceEpoch(
            int.parse(json['registrationDate'])),
        expirationDate: DateTime.fromMillisecondsSinceEpoch(
            int.parse(json['expirationDate'])),
        nameservers: json['nameservers'].cast<String>(),
        completeInfo: json['completeInfo'],
      );

  Map<String, dynamic> toJson() => {
        'domen': domen,
        'owner': owner,
        'registrar': registrar,
        'registrationDate': registrationDate?.millisecondsSinceEpoch.toString(),
        'expirationDate': expirationDate?.microsecondsSinceEpoch.toString(),
        'nameservers': nameservers,
        'completeInfo': completeInfo,
      };

  @override
  bool operator ==(o) => o is WhoisResponse && domen == o.domen;

  @override
  int get hashCode => domen.hashCode;
}
