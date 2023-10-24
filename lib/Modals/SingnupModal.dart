class SignupModal {
  String? _name;
  String? _email;
  String? _phone;
  String? _password;

  SignupModal({String? name, String? email, String? phone, String? password}) {
    if (name != null) {
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
    if (phone != null) {
      this._phone = phone;
    }
    if (password != null) {
      this._password = password;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get password => _password;
  set password(String? password) => _password = password;

  SignupModal.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['email'] = this._email;
    data['phone'] = this._phone;
    data['password'] = this._password;
    return data;
  }
}