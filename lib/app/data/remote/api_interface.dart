import 'dart:convert';

abstract class ApiInterface {
  //static const oldbaseUrl = "https://wahine.netgains.org/api/";
  //static const oldimgPath = "https://wahine.netgains.org/";
  static String consumer_key = 'ck_57b3bde95118c7b9cb1a8d38959c52eec132e844';
  static String consumer_secret = 'cs_24722f47f9f76230d1b0f41062050eabb74cacbb';
  static const baseUrl = "https://tidasports.com/wp-json";
  static const imgPath = "https://tidasports.com/wp-json";
  static const notificationServiceUrl = "https://tida-notification-service.onrender.com";

  static String? auth =
      'Basic ${base64.encode(utf8.encode('$consumer_key:$consumer_secret'))}';

  Future getApi({
    String? url,
    Map<String, String>? headers,
  });

  Future postApi({
    String? url,
    Map<String, String>? headers,
    Map? data,
  });

  Future putApi({
    String? url,
    Map<String, String>? headers,
    Map? data,
  });

  Future deleteApi({
    String? url,
    Map<String, String>? headers,
    Map? data,
  });
}
