class GeneralResponse {
  String? _msg;
  bool? _status;

  GeneralResponse({String? msg, bool? status}) {
    if (msg != null) {
      _msg = msg;
    }
    if (status != null) {
      _status = status;
    }
  }

  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  bool? get status => _status;
  set status(bool? status) => _status = status;

  GeneralResponse.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['msg'] = _msg;
    data['status'] = _status;
    return data;
  }



  
}