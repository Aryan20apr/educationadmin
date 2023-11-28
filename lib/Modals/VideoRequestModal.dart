class VideoRequestModal {
  String? title;
  String? link;
  String? isPaid;
  bool? isLive;
  String? type;
  bool? isStreaming;
  int? channelId;
  String? startDate;
  String? startTime;

  VideoRequestModal(
      {this.title,
      this.link,
      this.isPaid,
      this.isLive,
      this.type,
      this.isStreaming,
      this.channelId,
      this.startDate,
      this.startTime});

  VideoRequestModal.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    isPaid = json['isPaid'];
    isLive = json['isLive'];
    type = json['type'];
    isStreaming = json['isStreaming'];
    channelId = json['channelId'];
    startDate = json['startDate'];
    startTime = json['startTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['link'] = link;
    data['isPaid'] = isPaid;
    data['isLive'] = isLive;
    data['type'] = type;
    data['isStreaming'] = isStreaming;
    data['channelId'] = channelId;
    data['startDate'] = startDate;
    data['startTime'] = startTime;
    return data;
  }
}