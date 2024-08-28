import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../service/dialog_helper.dart';
import '../local/my_shared_pref.dart';
import 'api_interface.dart';
import 'endpoints.dart';

class ApiService extends ApiInterface {
  @override
  Future deleteApi(
      {String? url, Map<String, String>? headers, Map? data}) async {
    var client = http.Client();
    final response = await client.delete(
      Uri.parse(url!),
      headers: <String, String>{
        'accept': 'application/json',
        'content-type': 'application/json',
        'authorization': ApiInterface.auth!
      },
    );
    return response;
  }

  @override
  Future getApi({
    String? url,
    Map<String, String>? headers,
  }) async {
    var client = http.Client();
    print(url);
    final response = await client.get(Uri.parse(url!),
        headers: headers ??
            <String, String>{
              'accept': 'application/json',
              'content-type': 'application/json',
              'authorization': ApiInterface.auth!
            });
    return response;
  }

  @override
  Future postApi({String? url, Map<String, String>? headers, Map? data}) async {
    var client = http.Client();
    print("======================Post=======================");
    print(data);
    http.Response res = await client.post(Uri.parse(url!),
        headers: headers ??
            <String, String>{
              'content-type': 'application/json',
              'authorization': ApiInterface.auth!
            },
        body: jsonEncode(data));
    print(res.body);
    print("======================Post=======================");

    return res;
  }

  @override
  Future putApi({String? url, Map<String, String>? headers, Map? data}) async {
    var client = http.Client();
    final response = await client.put(Uri.parse(url!),
        headers: headers ??
            <String, String>{
              'accept': 'application/json',
              'content-type': 'application/json',
              'authorization': ApiInterface.auth!
            },
        body: jsonEncode(data));
    return response;
  }

  Map<String, dynamic>? _parseBaseResponse(http.Response res) {
    print("--------------------------------------");
    Map<String, dynamic> response = jsonDecode(res.body);
    print(response);
    if (response.containsKey("error")) {
      try {
        List entryList = response['error'].entries.toList();
        List<dynamic> errorList = [];
        entryList.forEach((element) {
          errorList.add(element.value.first);
        });
        DialogHelper.showErrorDialog("Error", errorList.join("\n"));
      } catch (e) {
        DialogHelper.showErrorDialog("Error", response['error']);
      }
      return null;
    } else {
      return response;
    }
  }

  Future<Map> createUserAccount(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.createPartner, data: data);
    return _parseBaseResponse(res) ?? {};
  }

  Future<Map> loginUser(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.loginCustomer,
        data: data,
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
          'authorization': ApiInterface.auth!
        });
    return _parseBaseResponse(res) ?? {};
  }

  Future<Map> forgotPassword(String email) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.forgotPassword,
        data: {"email": email});

    return _parseBaseResponse(res) ?? {};
  }

  Future<http.Response> changePassword(String password, String userid) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl +
            Endpoints.updatePassword +
            "?user_id=$userid&password=$password");
    return res;
  }

  Future<String> getUserIdByEmail(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.getUserId, data: data);
    return res.body;
  }

  Future<Map<String, dynamic>> getUserDetails(String userid) async {
    http.Response res = await getApi(
        url: ApiInterface.baseUrl + Endpoints.getUserDetails + "/$userid",
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
          'authorization': ApiInterface.auth!
        });
    return _parseBaseResponse(res) ?? {};
  }

  Future<http.Response> updateUserDetails(
      Map<String, dynamic> data) async {
    http.Response res = await postApi(
      url: ApiInterface.baseUrl + Endpoints.updateProfileData,
      data: data,
    );
    return res;
  }

  Future<Map<String, dynamic>> deleteCustomer() async {
    http.Response res = await deleteApi(
        url: ApiInterface.baseUrl +
            Endpoints.getUserDetails +
            "/${MySharedPref.getUserId()}?force=true");
    return _parseBaseResponse(res) ?? {};
  }

  Future<http.Response> getOrdersList(String orderlistCustoms) async {
    http.Response res = await getApi(
        url: ApiInterface.baseUrl + Endpoints.orders + orderlistCustoms,
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
          'authorization': ApiInterface.auth!
        });
    return res;
  }

  Future<http.Response> getAcademyBookings(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.getAcademyBooking, data: data);
    return res;
  }

  Future<http.Response> getVenueBookings(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.getVenueBooking, data: data);
    return res;
  }

  Future<http.Response> getSubscriptionBookings(
      Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.getSubscriptionsBooking,
        data: data);
    return res;
  }

  Future<http.Response> getListAcademies(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.getProductsByPartner, data: data);
    return res;
  }

  Future<http.Response> getListVenues(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.getProductsByPartner, data: data);
    return res;
  }

  Future<Map<String, dynamic>> updateOrder(
      Map<String, dynamic> data, String orderid) async {
    http.Response res = await putApi(
        url: ApiInterface.baseUrl + Endpoints.createOrder + "/$orderid",
        data: data);
    return _parseBaseResponse(res) ?? {};
  }

  Future<http.Response> getFCMToken(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.getFCMToken, data: data);
    return res;
  }

  Future<http.Response> updateFCMToken(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.updateFCMToken, data: data);
    return res;
  }

  Future<http.Response> updateProfileImage(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.updateProfileImg, data: data);
    return res;
  }

  Future<http.Response> togglecodpayment(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.togglepayment, data: data);
    return res;
  }

  Future<http.Response> getorderdetail(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.getorderdetail, data: data);
    return res;
  }

  Future<http.Response> availablecodoption(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.codoption, data: data);
    return res;
  }

  Future<http.Response> getProfileImage(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.getProfileImage, data: data);
    return res;
  }

  Future<http.Response> getUpcomingBookings(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.upcomingBookings, data: data);
    return res;
  }

  Future<http.Response> getUpcomingSubscripitions(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.upcomingSubscriptions, data: data);
    return res;
  }

   Future<http.Response> updateOrderStatus(Map<String, dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.notificationServiceUrl  + Endpoints.updateOrderPayment, data: data);
    return res;
  }

  Future<Map<String, dynamic>> createOrdernotes(
      Map<String, dynamic> data, String orderid) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl +
            Endpoints.createOrder +
            "/$orderid" +
            Endpoints.ordernotes,
        data: data);
    return _parseBaseResponse(res) ?? {};
  }

  static dynamic returnResponse(http.Response response) {
    try {
      dynamic responseJson = /*jsonDecode(*/ response.body /*)*/;
      debugPrint("RESPONSE $responseJson");
      return responseJson;
    } catch (e) {
      return {};
    }
  }

  static Future sendBookingNotification(
      String customerUserId, String orderId) async {
    String user_id = MySharedPref.getUserId() ?? "0";
    late String fcmToken;
    try {
      fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    } catch (e) {
      // Get.snackbar("Error",
      //     "An error has occured",
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white,
      //     snackPosition: SnackPosition.BOTTOM);
      print(e);
    }

    try {
      var client = http.Client();
      dynamic responseJson;
      Map body = {
        "userid": user_id,
        "fcmToken": fcmToken,
        "order_id": orderId,
        "customerUserId": customerUserId
      };
      print(body);
      final response = await client.post(
        Uri.parse(ApiInterface.notificationServiceUrl +
            Endpoints.sendBookingNotification),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authorization': ApiInterface.auth!
        },
        body: jsonEncode(body),
      );
      responseJson = returnResponse(response);
      return responseJson;
    } catch (e) {
      // print("++++++++++++++++++++++++++++++++++++++++++++++");
      print(e);
      Get.snackbar("Internet Connectivity Error",
          "Please Check your internet connection",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
