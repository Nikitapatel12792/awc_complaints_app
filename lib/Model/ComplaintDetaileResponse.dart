class ComplaintDetaileResponse {
  String? status;
  String? message;
  Data? data;

  ComplaintDetaileResponse({this.status, this.message, this.data});

  ComplaintDetaileResponse.fromJson(Map<String, dynamic> json) {
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
  ComplaintDetails? complaintDetails;

  Data({this.complaintDetails});

  Data.fromJson(Map<String, dynamic> json) {
    complaintDetails = json['complaintDetails'] != null
        ? new ComplaintDetails.fromJson(json['complaintDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.complaintDetails != null) {
      data['complaintDetails'] = this.complaintDetails!.toJson();
    }
    return data;
  }
}

class ComplaintDetails {
  int? id;
  int? userId;
  String? complaintNumber;
  int? buildingId;
  String? referenceNo;
  String? locationOfComplaint;
  String? description;
  String? image;
  int? complaintStatus;
  int? isView;
  String? isShowFlash;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? buildingName;
  String? comolaintDate;
  String? complaintStatusTxt;

  ComplaintDetails(
      {this.id,
        this.userId,
        this.complaintNumber,
        this.buildingId,
        this.referenceNo,
        this.locationOfComplaint,
        this.description,
        this.image,
        this.complaintStatus,
        this.isView,
        this.isShowFlash,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.buildingName,
        this.comolaintDate,
        this.complaintStatusTxt});

  ComplaintDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    complaintNumber = json['complaint_number'];
    buildingId = json['building_id'];
    referenceNo = json['reference_no'];
    locationOfComplaint = json['location_of_complaint'];
    description = json['description'];
    image = json['image'];
    complaintStatus = json['complaint_status'];
    isView = json['is_view'];
    isShowFlash = json['is_show_flash'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    buildingName = json['building_name'];
    comolaintDate = json['comolaintDate'];
    complaintStatusTxt = json['complaint_status_txt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['complaint_number'] = this.complaintNumber;
    data['building_id'] = this.buildingId;
    data['reference_no'] = this.referenceNo;
    data['location_of_complaint'] = this.locationOfComplaint;
    data['description'] = this.description;
    data['image'] = this.image;
    data['complaint_status'] = this.complaintStatus;
    data['is_view'] = this.isView;
    data['is_show_flash'] = this.isShowFlash;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['building_name'] = this.buildingName;
    data['comolaintDate'] = this.comolaintDate;
    data['complaint_status_txt'] = this.complaintStatusTxt;
    return data;
  }
}
