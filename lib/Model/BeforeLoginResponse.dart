class BeforeLoginResponse {
  String? status;
  String? message;
  Data? data;

  BeforeLoginResponse({this.status, this.message, this.data});

  BeforeLoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? signupStatus;

  Data({this.signupStatus});

  Data.fromJson(Map<String, dynamic> json) {
    signupStatus = json['signup_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['signup_status'] = this.signupStatus;
    return data;
  }
}
