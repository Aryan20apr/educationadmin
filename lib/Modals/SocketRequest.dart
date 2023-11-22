class SocketData {
  String? room;
  String? message;
  String? userName;

  SocketData({this.room, this.message, this.userName});

  SocketData.fromJson(Map<String, dynamic> json) {
    room = json['room'];
    message = json['message'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room'] = this.room;
    data['message'] = this.message;
    data['userName'] = this.userName;
    return data;
  }
}

class JoinResponse {
  String? clientId;
  String? room;
  String? userName;

  JoinResponse({this.clientId, this.room, this.userName});

  JoinResponse.fromJson(Map<String, dynamic> json) {
    clientId = json['clientId'];
    room = json['room'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientId'] = this.clientId;
    data['room'] = this.room;
    data['userName'] = this.userName;
    return data;
  }
}
