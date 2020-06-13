class TopicModel {
  static const String collection = "topics";

  String key;
  String userKey;
  String title;
  String description;
  String details;
  String author;
  bool closed;
  DateTime createdAt;

  TopicModel({
    this.key,
    this.userKey,
    this.title,
    this.description,
    this.details,
    this.author,
    this.closed: false,
    this.createdAt,
  });

  TopicModel.fromJson(String key, Map<String, dynamic> json) {
    this.key = key;
    userKey = json['userKey'];
    title = json['title'];
    description = json['description'];
    details = json['details'];
    author = json['author'];
    closed = json['closed'];
    int utcCreationTime = json['createdAt'];
    createdAt = DateTime.fromMillisecondsSinceEpoch(utcCreationTime).toLocal();
  }

  Map<String, dynamic> toJson() {
    final data = new Map<String, dynamic>();
    data['userKey'] = this.userKey;
    data['title'] = this.title;
    data['description'] = this.description;
    data['details'] = this.details;
    data['author'] = this.author;
    data['closed'] = this.closed;
    data['createdAt'] = this.createdAt.toUtc().millisecondsSinceEpoch;

    return data;
  }
}
