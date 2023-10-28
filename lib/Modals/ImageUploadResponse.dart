class ImageUploadResponse {
  Data? data;

  ImageUploadResponse({this.data});

  ImageUploadResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? msg;
  String? url;

  Data({this.msg, this.url});

  Data.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['url'] = this.url;
    return data;
  }
}