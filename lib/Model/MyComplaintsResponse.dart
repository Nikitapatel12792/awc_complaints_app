class MyComplaintsResponse {
  String? status;
  String? message;
  Data? data;

  MyComplaintsResponse({this.status, this.message, this.data});

  MyComplaintsResponse.fromJson(Map<String, dynamic> json) {
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
  List<ComplaintLists>? complaintLists;
  int? unreadNotifications;
  Pagination? pagination;

  Data({this.complaintLists, this.unreadNotifications, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['complaintLists'] != null) {
      complaintLists = <ComplaintLists>[];
      json['complaintLists'].forEach((v) {
        complaintLists!.add(new ComplaintLists.fromJson(v));
      });
    }
    unreadNotifications = json['unreadNotifications'];
    pagination = json['Pagination'] != null
        ? new Pagination.fromJson(json['Pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.complaintLists != null) {
      data['complaintLists'] =
          this.complaintLists!.map((v) => v.toJson()).toList();
    }
    data['unreadNotifications'] = this.unreadNotifications;
    if (this.pagination != null) {
      data['Pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class ComplaintLists {
  int? id;
  int? userId;
  String ?complaintNumber;
  int? buildingId;
  String? referenceNo;
  String? locationOfComplaint;
  String? description;
  String? image;
  int? complaintStatus;
  int ?isView;
  String? isShowFlash;
  int? isDeleted;
  String? createdAt;
  String ?updatedAt;
  String? buildingName;
  String ?complaintDate;
  String? complaintStatusTxt;

  ComplaintLists(
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
        this.complaintDate,
        this.complaintStatusTxt});

  ComplaintLists.fromJson(Map<String, dynamic> json) {
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
    complaintDate = json['complaintDate'];
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
    data['complaintDate'] = this.complaintDate;
    data['complaint_status_txt'] = this.complaintStatusTxt;
    return data;
  }
}

class Pagination {
  int? totalRecords;
  int? limit;
  int? totalPage;
  int? currentPage;
  int? nextPage;
  int? remainingPage;

  Pagination(
      {this.totalRecords,
        this.limit,
        this.totalPage,
        this.currentPage,
        this.nextPage,
        this.remainingPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalRecords = json['totalRecords'];
    limit = json['limit'];
    totalPage = json['totalPage'];
    currentPage = json['currentPage'];
    nextPage = json['nextPage'];
    remainingPage = json['remainingPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalRecords'] = this.totalRecords;
    data['limit'] = this.limit;
    data['totalPage'] = this.totalPage;
    data['currentPage'] = this.currentPage;
    data['nextPage'] = this.nextPage;
    data['remainingPage'] = this.remainingPage;
    return data;
  }
}
