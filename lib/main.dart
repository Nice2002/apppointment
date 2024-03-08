import 'package:apppointment/notification_controller.dart';
import 'package:apppointment/page-2/calendarpage.dart';
import 'package:apppointment/page-2/home.dart';
import 'package:apppointment/page-2/index.dart';
import 'package:apppointment/page-2/login.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel",
        channelName: "Basic Notification",
        channelDescription: "basic notification channel",
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: "basic_channel_group",
          channelGroupName: "Basic Group"),
    ],
  );
  bool isAllowedToSendNotifications =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotifications) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivesMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
        ),
        useMaterial3: true,
        fontFamily: GoogleFonts.prompt().fontFamily,
      ),
      home: Login(),
      // home: Scaffold(
      //     floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     AwesomeNotifications().createNotification(
      //         content: NotificationContent(
      //       id: 1,
      //       channelKey: "basic_channel",
      //       title: "Notification Title",
      //       body: "Notification Body",
      //       color: Colors.deepPurple,
      //     ));
      //   },
      //   child: Icon(Icons.notification_add),
      // )),
      debugShowCheckedModeBanner: false,
    );
  }
}
