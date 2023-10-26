class FileUploadResponse {
  Data? _data;

  FileUploadResponse({Data? data}) {
    if (data != null) {
      _data = data;
    }
  }

  Data? get data => _data;
  set data(Data? data) => _data = data;

  FileUploadResponse.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}

class Data {
  String? _msg;
  String? _url;

  Data({String? msg, String? url}) {
    if (msg != null) {
      _msg = msg;
    }
    if (url != null) {
      _url = url;
    }
  }

  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  String? get url => _url;
  set url(String? url) => _url = url;

  Data.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
    _url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['msg'] = _msg;
    data['url'] = _url;
    return data;
  }
}