import 'dart:convert';

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
      Map<String, dynamic> data, String userId) async {
    http.Response res = await putApi(
      url: ApiInterface.baseUrl + Endpoints.getUserDetails + "/$userId",
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
          // 'authorization': ApiInterface.auth!
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

  Future<http.Response> getFCMToken(Map<String,dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.getFCMToken, data: data
        );
    return res;
  }
  Future<http.Response> updateFCMToken(Map<String,dynamic> data) async {
    http.Response res = await postApi(
        url: ApiInterface.baseUrl + Endpoints.updateFCMToken, data: data
        );
    return res;
  }
}
