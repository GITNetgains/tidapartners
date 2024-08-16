import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidapartners/app/data/remote/api_service.dart';
import 'package:tidapartners/app/modules/home/models/subscription_model.dart'
    as subscription;
import 'app/data/models/Push_notification_model.dart';
import 'app/data/local/my_shared_pref.dart';
import 'app/modules/profile/models/academy_model.dart' as academyBookings;
import 'app/modules/profile/models/venue_model.dart' as venueBookings;
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:cached_network_image/cached_network_image.dart';

late final FirebaseMessaging _messaging;
PushNotificationModel? _notificationInfo;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.data}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupInteractedMessage();
  // Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // requestAndRegisterNotification();
  // _messaging = FirebaseMessaging.instance;
  // NotificationSettings settings = await _messaging.requestPermission(
  //     alert: true, badge: true, provisional: false, sound: true);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    onDidReceiveBackgroundNotificationResponse:
        onDidReceiveBackgroundNotificationResponse,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                icon: "@mipmap/ic_launcher",
                importance: Importance.high,
                priority: Priority.high,
              ),
              iOS: const DarwinNotificationDetails()),
          payload: json.encode(message.data));
    }
  });
  await MySharedPref.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, widget) {
        return GetMaterialApp(
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
        );
      },
    ));
  });
}

void requestAndRegisterNotification() async {
  // _messaging = FirebaseMessaging.instance;
  // NotificationSettings settings = await _messaging.requestPermission(
  //     alert: true, badge: true, provisional: false, sound: true);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // const initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');
  // const DarwinInitializationSettings initializationSettingsDarwin =
  //     DarwinInitializationSettings();
  // const InitializationSettings initializationSettings = InitializationSettings(
  //   android: initializationSettingsAndroid,
  //   iOS: initializationSettingsDarwin,
  // );
  // flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //   String? token = await _messaging.getToken();
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       // final http.Response response =
  //       //     await http.get(Uri.parse(android.imageUrl ?? ""));
  //       // BigPictureStyleInformation bigPictureStyleInformation =
  //       //     BigPictureStyleInformation(ByteArrayAndroidBitmap.fromBase64String(
  //       //         base64Encode(response.bodyBytes)));

  //       flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               channel.id,
  //               channel.name,
  //               channelDescription: channel.description,
  //               color: Colors.blue,
  //               icon: "@mipmap/ic_launcher",
  //               importance: Importance.high,
  //               priority: Priority.high,
  //             ),
  //             iOS: const DarwinNotificationDetails()),
  //       );
  //     }
  //     PushNotificationModel pushNotificationModel = PushNotificationModel(
  //       title: message.notification?.title,
  //       body: message.notification?.body,
  //     );
  //     _notificationInfo = pushNotificationModel;
  //     totalnotifications++;
  //   });
  //   if (_notificationInfo != null) {
  //     Get.to(() => OrderDetails());
  //   }
  // }
}

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notification payload: $payload');
    Map<String, dynamic> data = json.decode(payload ?? "");
    print(data["order_id"]);
    if (data["order_type"] == "subscription_variation") {
      dynamic res =
          await ApiService().getorderdetail({"order_id": data["order_id"]});
      subscription.Data subscriptionDataModel = subscription.Data();
      if (res.statusCode == 200) {
        res = await jsonDecode(res.body);
        if (res["message"] != null) {
          if (res["message"]["data"] != null) {
            subscriptionDataModel =
                await subscription.Data.fromJson(res["message"]["data"]);
            subscriptionDataModel.id = int.parse(data["order_id"]);
            print(subscriptionDataModel);
            Get.toNamed(AppPages.DETAILS_SCREEN, arguments: {
              "data": subscriptionDataModel,
              "detailname": "subscription",
            });
          } else {
            Get.toNamed(AppPages.PROFILE);
          }
        } else {
          Get.toNamed(AppPages.PROFILE);
        }
      } else {
        Get.toNamed(AppPages.PROFILE);
      }
    } else if (data["order_type"] == "variation") {
      dynamic res =
          await ApiService().getorderdetail({"order_id": data["order_id"]});
      academyBookings.Data academyDataModel = academyBookings.Data();
      if (res.statusCode == 200) {
        res = await jsonDecode(res.body);
        if (res["message"] != null) {
          if (res["message"]["data"] != null) {
            academyDataModel =
                await academyBookings.Data.fromJson(res["message"]["data"]);
            //  academyDataModel.id = int.parse(data["order_id"]);
            print(academyDataModel);
            Get.toNamed(AppPages.DETAILS_SCREEN, arguments: {
              "data": academyDataModel,
              "orderid": data["order_id"],
              "detailname": "booking",
            });
          } else {
            Get.toNamed(AppPages.PROFILE);
          }
        } else {
          Get.toNamed(AppPages.PROFILE);
        }
      } else {
        Get.toNamed(AppPages.PROFILE);
      }
    } else {
      dynamic res =
          await ApiService().getorderdetail({"order_id": data["order_id"]});
      venueBookings.Data venueDataModel = venueBookings.Data();

      if (res.statusCode == 200) {
        res = await jsonDecode(res.body);
        if (res["message"] != null) {
          if (res["message"]["data"] != null) {
            venueDataModel =
                await venueBookings.Data.fromJson(res["message"]["data"]);
            //  academyDataModel.id = int.parse(data["order_id"]);
            print(venueDataModel);
            Get.toNamed(AppPages.DETAILS_SCREEN, arguments: {
              "data": venueDataModel,
              "orderid": data["order_id"],
              "detailname": "slots",
            });
          } else {
            Get.toNamed(AppPages.PROFILE);
          }
        } else {
          Get.toNamed(AppPages.PROFILE);
        }
      } else {
        Get.toNamed(AppPages.PROFILE);
      }
    }
  }
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(
    NotificationResponse notificationResponse) async {
  debugPrint("ondidrecievebackgroundnotificationresponse  ");
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');

  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notification payload: $payload');
    Map<String, dynamic> data = json.decode(payload ?? "");
    print(data["order_id"]);
    if (data["order_type"] == "subscription_variation") {
      dynamic res =
          await ApiService().getorderdetail({"order_id": data["order_id"]});
      subscription.Data subscriptionDataModel = subscription.Data();
      if (res.statusCode == 200) {
        res = await jsonDecode(res.body);
        if (res["message"] != null) {
          if (res["message"]["data"] != null) {
            subscriptionDataModel =
                await subscription.Data.fromJson(res["message"]["data"]);
            subscriptionDataModel.id = int.parse(data["order_id"]);
            print(subscriptionDataModel);
            Get.toNamed(AppPages.DETAILS_SCREEN,
                arguments: {"data": subscriptionDataModel});
          } else {
            Get.toNamed(AppPages.PROFILE);
          }
        } else {
          Get.toNamed(AppPages.PROFILE);
        }
      } else {
        Get.toNamed(AppPages.PROFILE);
      }
    } else if (data["order_type"] == "variation") {
      dynamic res =
          await ApiService().getorderdetail({"order_id": data["order_id"]});
      academyBookings.Data academyDataModel = academyBookings.Data();
      if (res.statusCode == 200) {
        res = await jsonDecode(res.body);
        if (res["message"] != null) {
          if (res["message"]["data"] != null) {
            academyDataModel =
                await academyBookings.Data.fromJson(res["message"]["data"]);
            //  academyDataModel.id = int.parse(data["order_id"]);
            print(academyDataModel);
            Get.toNamed(AppPages.DETAILS_SCREEN, arguments: {
              "data": academyDataModel,
              "orderid": data["order_id"]
            });
          } else {
            Get.toNamed(AppPages.PROFILE);
          }
        } else {
          Get.toNamed(AppPages.PROFILE);
        }
      } else {
        Get.toNamed(AppPages.PROFILE);
      }
    } else {
      dynamic res =
          await ApiService().getorderdetail({"order_id": data["order_id"]});
      venueBookings.Data venueDataModel = venueBookings.Data();

      if (res.statusCode == 200) {
        res = await jsonDecode(res.body);
        if (res["message"] != null) {
          if (res["message"]["data"] != null) {
            venueDataModel =
                await venueBookings.Data.fromJson(res["message"]["data"]);
            //  academyDataModel.id = int.parse(data["order_id"]);
            print(venueDataModel);
            Get.toNamed(AppPages.DETAILS_SCREEN, arguments: {
              "data": venueDataModel,
              "orderid": data["order_id"]
            });
          } else {
            Get.toNamed(AppPages.PROFILE);
          }
        } else {
          Get.toNamed(AppPages.PROFILE);
        }
      } else {
        Get.toNamed(AppPages.PROFILE);
      }
    }
  }
}

Future<void> setupInteractedMessage() async {
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null)
      await ApiService().updateFCMToken(
          {"userid": MySharedPref.getUserId(), "fcm_token": token});
  } catch (e) {
    print(e);
  }

  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

  FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
    await ApiService().updateFCMToken(
        {"userid": MySharedPref.getUserId(), "fcm_token": token});
  });
}

void _handleMessage(RemoteMessage message) {
  if (message.data.containsKey("order_id")) {
    // OrdersController _c = Get.put(OrdersController());
    // _c.selectedBookingId(message.data["order_id"]);
    // Get.to(() => OrderDetails());
  }
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  FirebaseMessaging _messaging = FirebaseMessaging.instance;

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final bool? result = await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: true,
    sound: true,
  );

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await _messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}
