class LoginModal {
  String? _phone;
  String? _password;

  LoginModal({String? phone, String? password}) {
    if (phone != null) {
      _phone = phone;
    }
    if (password != null) {
      _password = password;
    }
  }

  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get password => _password;
  set password(String? password) => _password = password;

  LoginModal.fromJson(Map<String, dynamic> json) {
    _phone = json['phone'];
    _password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this._phone;
    data['password'] = this._password;
    return data;
  }
}