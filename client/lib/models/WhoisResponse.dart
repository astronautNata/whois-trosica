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
  String domen;
  Map<String, dynamic> data;

  WhoisResponse({required this.data, required this.domen});

  factory WhoisResponse.fromJson(Map<String, dynamic> json, String domen) =>
      WhoisResponse(data: json, domen: domen);

  factory WhoisResponse.fromSharedJson(Map<String, dynamic> json) =>
      WhoisResponse(data: json['data'], domen: json['domen']);

  Map<String, dynamic> toJson() => {'domen': domen, 'data': data};

  @override
  bool operator ==(o) => o is WhoisResponse && domen == o.domen;

  @override
  int get hashCode => domen.hashCode;
}
