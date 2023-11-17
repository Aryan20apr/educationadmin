class BannersUploadResponse {
  Data? data;

  BannersUploadResponse({this.data});

  BannersUploadResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? msg;
  Banner? banner;

  Data({this.msg, this.banner});

  Data.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    banner =
        json['banner'] != null ? Banner.fromJson(json['banner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['msg'] = msg;
    if (banner != null) {
      data['banner'] = banner!.toJson();
    }
    return data;
  }
}

class Banner {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? image;
  int? createdBy;

  Banner({this.id, this.createdAt, this.updatedAt, this.image, this.createdBy});

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    image = json['image'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['image'] = image;
    data['createdBy'] = createdBy;
    return data;
  }
}