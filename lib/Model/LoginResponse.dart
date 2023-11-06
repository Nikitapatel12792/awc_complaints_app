class LoginResponse {
  String? status;
  String? message;
  Data? data;

  LoginResponse({this.status, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String ?buildingId;
  String? email;
  String? mobile;
  String? fullName;
  String? image;
  String? buildingName;

  Data(
      {this.id,
        this.buildingId,
        this.email,
        this.mobile,
        this.fullName,
        this.image,
        this.buildingName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buildingId = json['building_id'];
    email = json['email'];
    mobile = json['mobile'];
    fullName = json['full_name'];
    image = json['image'];
    buildingName = json['building_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['building_id'] = this.buildingId;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    data['building_name'] = this.buildingName;
    return data;
  }
}
