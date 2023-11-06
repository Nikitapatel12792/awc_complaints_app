class NotificationResponse {
  String? status;
  String? message;
  Data? data;

  NotificationResponse({this.status, this.message, this.data});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
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
  List<Notifications>? notifications;

  Data({this.notifications});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int? id;
  int? userId;
  int? complaintId;
  String? action;
  int? isRead;
  String? locationOfComplaint;
  String? referenceNo;
  String? complaintNumber;
  int? complaintStatus;
  String? complaintStatusTxt;
  String? complaintTitle;
  String? description;
  String? complaintText;
  String? complaintImage;
  String? complaintDate;

  Notifications(
      {this.id,
        this.userId,
        this.complaintId,
        this.action,
        this.isRead,
        this.locationOfComplaint,
        this.referenceNo,
        this.complaintNumber,
        this.complaintStatus,
        this.complaintStatusTxt,
        this.complaintTitle,
        this.description,
        this.complaintText,
        this.complaintImage,
        this.complaintDate});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    complaintId = json['complaint_id'];
    action = json['action'];
    isRead = json['is_read'];
    locationOfComplaint = json['location_of_complaint'];
    referenceNo = json['reference_no'];
    complaintNumber = json['complaint_number'];
    complaintStatus = json['complaint_status'];
    complaintStatusTxt = json['complaint_status_txt'];
    complaintTitle = json['complaint_title'];
    description = json['description'];
    complaintText = json['complaint_text'];
    complaintImage = json['complaint_image'];
    complaintDate = json['complaintDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['complaint_id'] = this.complaintId;
    data['action'] = this.action;
    data['is_read'] = this.isRead;
    data['location_of_complaint'] = this.locationOfComplaint;
    data['reference_no'] = this.referenceNo;
    data['complaint_number'] = this.complaintNumber;
    data['complaint_status'] = this.complaintStatus;
    data['complaint_status_txt'] = this.complaintStatusTxt;
    data['complaint_title'] = this.complaintTitle;
    data['description'] = this.description;
    data['complaint_text'] = this.complaintText;
    data['complaint_image'] = this.complaintImage;
    data['complaintDate'] = this.complaintDate;
    return data;
  }
}
