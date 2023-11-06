class IsNewNotificationResponse {
  String? status;
  String? message;
  Data? data;

  IsNewNotificationResponse({this.status, this.message, this.data});

  IsNewNotificationResponse.fromJson(Map<String, dynamic> json) {
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
  int? unreadNotifications;

  Data({this.unreadNotifications});

  Data.fromJson(Map<String, dynamic> json) {
    unreadNotifications = json['unreadNotifications'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unreadNotifications'] = this.unreadNotifications;
    return data;
  }
}
