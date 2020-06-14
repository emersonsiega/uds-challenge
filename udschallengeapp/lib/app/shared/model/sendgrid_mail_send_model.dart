class SendgridMailSendModel {
  List<Personalizations> personalizations;
  From from;
  String templateId;

  SendgridMailSendModel({
    this.personalizations,
    this.from,
    this.templateId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.personalizations != null) {
      data['personalizations'] =
          this.personalizations.map((v) => v.toJson()).toList();
    }
    if (this.from != null) {
      data['from'] = this.from.toJson();
    }
    data['template_id'] = this.templateId;
    return data;
  }
}

class Personalizations {
  List<To> to;
  DynamicTemplateData dynamicTemplateData;

  Personalizations({
    this.to,
    this.dynamicTemplateData,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.to != null) {
      data['to'] = this.to.map((v) => v.toJson()).toList();
    }
    if (this.dynamicTemplateData != null) {
      data['dynamic_template_data'] = this.dynamicTemplateData.toJson();
    }
    return data;
  }
}

class To {
  String email;

  To({
    this.email,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}

class DynamicTemplateData {
  String userName;
  String userPassword;

  DynamicTemplateData({
    this.userName,
    this.userPassword,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_password'] = this.userPassword;
    return data;
  }
}

class From {
  final String email;
  final String name;

  const From({
    this.email,
    this.name,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    return data;
  }
}
