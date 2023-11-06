class MasterResponse {
  String? status;
  String? message;
  Data? data;

  MasterResponse({this.status, this.message, this.data});

  MasterResponse.fromJson(Map<String, dynamic> json) {
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
  List<ComplaintStatuslists>? complaintStatuslists;
  List<BuildingLists>? buildingLists;

  Data({this.complaintStatuslists, this.buildingLists});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['complaintStatuslists'] != null) {
      complaintStatuslists = <ComplaintStatuslists>[];
      json['complaintStatuslists'].forEach((v) {
        complaintStatuslists!.add(new ComplaintStatuslists.fromJson(v));
      });
    }
    if (json['buildingLists'] != null) {
      buildingLists =<BuildingLists>[];
      json['buildingLists'].forEach((v) {
        buildingLists!.add(new BuildingLists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.complaintStatuslists != null) {
      data['complaintStatuslists'] =
          this.complaintStatuslists!.map((v) => v.toJson()).toList();
    }
    if (this.buildingLists != null) {
      data['buildingLists'] =
          this.buildingLists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ComplaintStatuslists {
  String? id;
  String? name;

  ComplaintStatuslists({this.id, this.name});

  ComplaintStatuslists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class BuildingLists {
  String? name;
  int? id;

  BuildingLists({this.name, this.id});

  BuildingLists.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
