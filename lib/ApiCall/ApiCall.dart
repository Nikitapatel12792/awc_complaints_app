import 'dart:convert';
import 'dart:core';
import 'package:awc_complaints_app/Model/BeforeLoginResponse.dart';
import 'package:awc_complaints_app/Model/CommonResponse.dart';
import 'package:awc_complaints_app/Model/ComplaintDetaileResponse.dart';
import 'package:awc_complaints_app/Model/EditProfileResponse.dart';
import 'package:awc_complaints_app/Model/IsNewNotificationResponse.dart';
import 'package:awc_complaints_app/Model/LoginResponse.dart';
import 'package:awc_complaints_app/Model/MasterResponse.dart';
import 'package:awc_complaints_app/Model/MobileVarifyResponse.dart';
import 'package:awc_complaints_app/Model/MyComplaintsResponse.dart';
import 'package:awc_complaints_app/Model/NotificationResponse.dart';
import 'package:awc_complaints_app/Model/UserDetailResponse.dart';
import 'package:awc_complaints_app/Utill/Constant.dart';
import 'package:http/http.dart' as http;

class URLS {
  // static const String BASE_URL = 'https://umarsyafiq.com/awc/mobile/';
//  static const String BASE_URL = 'https://awsb.e-aduan.awc.com.my/mobile/';
  static const String BASE_URL = 'https://awc.apextreasure.com/mobile/';
  static const String ApiKey = '999930';
}

class ApiService {
  static Future<MobileVarifyResponse> mobileVerify(String phoneno) async {
    final response = await http.post(
      Uri.parse(URLS.BASE_URL + 'mobile_verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'mobile': phoneno, 'apikey': '999930'}),
    );
    print(response.body);
    print(response.request);

    if (response.statusCode == 200) {
      MobileVarifyResponse loginResponse =
          MobileVarifyResponse.fromJson(jsonDecode(response.body));
      if (loginResponse.status == "success") {
        print("Success");
      } else {
        print("Error");
      }
      return loginResponse;
    } else {
      throw Exception('Failed to load ');
    }
  }

  static Future<LoginResponse> login(String mobile, String password) async {
    final response = await http.post(
      Uri.parse(URLS.BASE_URL + 'login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobile': mobile,
        'password': password,
        'device_token': device_token,
        'device_type': device_type,
        'apikey': URLS.ApiKey
      }),
    );
    print(response.body);
    print(response.request);
    print("device_token= " + device_token);
    print("device_type= " + device_type);
    if (response.statusCode == 200) {
      LoginResponse loginResponse =
          LoginResponse.fromJson(jsonDecode(response.body));
      if (loginResponse.status == "success") {
        print("Success");
      } else {
        print(loginResponse.message);
        print("Error");
      }
      return loginResponse;
    } else {
      throw Exception('Failed to load ');
    }
  }

  static Future<LoginResponse> sign_up(
      String full_name,
      String mobile,
      String building,
      String designation,
      String department,
      String password) async {
    final response = await http.post(
      Uri.parse(URLS.BASE_URL + 'sign_up'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'full_name': full_name,
        'mobile': mobile,
        'building': building,
        'designation': designation,
        'department': department,
        'password': password,
        'device_token': device_token,
        'device_type': device_type,
        'apikey': URLS.ApiKey
      }),
    );
    print(response.body);
    print(response.request);
    print("device_token= " + device_token);
    print("device_type= " + device_type);
    if (response.statusCode == 200) {
      LoginResponse loginResponse =
          LoginResponse.fromJson(jsonDecode(response.body));
      if (loginResponse.status == "success") {
        print("Success");
      } else {
        print(loginResponse.message);
        print("Error");
      }
      return loginResponse;
    } else {
      throw Exception('Failed to load ');
    }
  }

  static Future<UserDetailResponse> userDetails(String user_id) async {
    final response = await http.post(
      Uri.parse(URLS.BASE_URL + 'user_details'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'user_id': user_id, 'apikey': URLS.ApiKey}),
    );

    UserDetailResponse userDetailResponse =
        UserDetailResponse.fromJson(jsonDecode(response.body));
    return userDetailResponse;
  }

  static Future<CommonResponse> logout(String user_id) async {
    final response = await http.post(
      Uri.parse(URLS.BASE_URL + 'logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'user_id': user_id, 'apikey': URLS.ApiKey}),
    );

    CommonResponse commonResponse =
        CommonResponse.fromJson(jsonDecode(response.body));
    return commonResponse;
  }

  static Future<CommonResponse> addComplaint(String user_id, String building_no,
      String location_of_complaint, String description) async {
    final response = await http.post(
      Uri.parse(URLS.BASE_URL + 'add_complaint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': user_id,
        'building_no': building_no,
        'location_of_complaint': location_of_complaint,
        'description': description,
        'apikey': URLS.ApiKey
      }),
    );

    CommonResponse userDetailResponse =
        CommonResponse.fromJson(jsonDecode(response.body));
    return userDetailResponse;
  }

  static Future<EditProfileResponse> edit_profile(
      String user_id, String mobile, String email) async {
    final response = await http.post(
      Uri.parse(URLS.BASE_URL + 'edit_profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': user_id,
        'mobile': mobile,
        'email': email,
        'apikey': URLS.ApiKey
      }),
    );
    print(response.body);
    EditProfileResponse editProfileResponse =
        EditProfileResponse.fromJson(jsonDecode(response.body));
    return editProfileResponse;
  }

  Future<MyComplaintsResponse> my_complaint(
      String user_id, String complaint_status, String page_number) async {
    final response = await http.post(
      Uri.parse(URLS.BASE_URL + 'my_complaint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': user_id,
        'complaint_status': complaint_status,
        'page_number': page_number,
        'apikey': URLS.ApiKey
      }),
    );
    print(response.body);
    print("userid " + user_id);
    print("complaint_status " + complaint_status);
    print("page_number " + page_number);

    print(response.request!.url);
    if (response.statusCode == 200) {
      MyComplaintsResponse myComplaintsResponse =
          MyComplaintsResponse.fromJson(jsonDecode(response.body));
      return myComplaintsResponse;
    } else {
      throw Exception("Failed to Load");
    }
  }
}

Future<MasterResponse> masters() async {
  final response = await http.post(
    Uri.parse(URLS.BASE_URL + 'masters'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'apikey': URLS.ApiKey}),
  );
  print(response.body);
  MasterResponse masterResponse =
      MasterResponse.fromJson(jsonDecode(response.body));
  return masterResponse;
}

Future<BeforeLoginResponse> before_login() async {
  final response = await http.post(
    Uri.parse(URLS.BASE_URL + 'before_login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'apikey': URLS.ApiKey}),
  );
  print("ress body => ${response.body}");
  print("ress request => ${response.request}");
  print("ress statusCode => ${response.statusCode}");
  if (response.statusCode == 200) {
    BeforeLoginResponse beforeLoginResponse =
        BeforeLoginResponse.fromJson(jsonDecode(response.body));
    return beforeLoginResponse;
  } else {
    throw Exception("Failed to Load");
  }
}

Future<MyComplaintsResponse> my_complaint(
    String user_id, String complaint_status, String page_number) async {
  final response = await http.post(
    Uri.parse(URLS.BASE_URL + 'my_complaint'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'user_id': user_id,
      'complaint_status': complaint_status,
      'page_number': page_number,
      'apikey': URLS.ApiKey
    }),
  );
  print(response.body);
  print("userid " + user_id);
  print("complaint_status " + complaint_status);
  print("page_number " + page_number);

  print(response.request!.url);
  if (response.statusCode == 200) {
    MyComplaintsResponse myComplaintsResponse =
        MyComplaintsResponse.fromJson(jsonDecode(response.body));
    return myComplaintsResponse;
  } else {
    throw Exception("Failed to Load");
  }
}

Future<NotificationResponse> notifications(String user_id) async {
  final response = await http.post(
    Uri.parse(URLS.BASE_URL + 'notifications'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:
        jsonEncode(<String, String>{'user_id': user_id, 'apikey': URLS.ApiKey}),
  );
  print(response.body);
  print("userid " + user_id);

  print(response.request!.url);
  if (response.statusCode == 200) {
    NotificationResponse notificationResponse =
        NotificationResponse.fromJson(jsonDecode(response.body));
    return notificationResponse;
  } else {
    throw Exception("Failed to Load");
  }
}

Future<ComplaintDetaileResponse> complaintDetails(
    String user_id, String complaint_id) async {
  final response = await http.post(
    Uri.parse(URLS.BASE_URL + 'complaint_details'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'user_id': user_id,
      'complaint_id': complaint_id,
      'apikey': URLS.ApiKey
    }),
  );

  print(response.body);
  print(response.request);
  print(response.request);

  if (response.statusCode == 200) {
    ComplaintDetaileResponse complaintDetaileResponse =
        ComplaintDetaileResponse.fromJson(jsonDecode(response.body));
    if (complaintDetaileResponse.status == "success") {
      print("Success");
    } else {
      print("Error");
    }
    return complaintDetaileResponse;
  } else {
    throw Exception('Failed to load ');
  }
}

Future<IsNewNotificationResponse> check_new_notification(String user_id) async {
  final response = await http.post(
    Uri.parse(URLS.BASE_URL + 'check_new_notification'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:
        jsonEncode(<String, String>{'user_id': user_id, 'apikey': URLS.ApiKey}),
  );

  print(response.body);
  print(response.request);
  print(response.request);

  if (response.statusCode == 200) {
    IsNewNotificationResponse isNewNotificationResponse =
        IsNewNotificationResponse.fromJson(jsonDecode(response.body));
    if (isNewNotificationResponse.status == "success") {
      print("Success");
    } else {
      print("Error");
    }
    return isNewNotificationResponse;
  } else {
    throw Exception('Failed to load ');
  }
}
