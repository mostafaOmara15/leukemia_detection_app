// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class SetAlarmPage extends StatefulWidget {
//   @override
//   _SetAlarmPageState createState() => _SetAlarmPageState();
// }
//
// class _SetAlarmPageState extends State<SetAlarmPage> {
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   late TimeOfDay selectedTime;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the local notifications plugin
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     var initializationSettingsAndroid =
//     AndroidInitializationSettings('app_icon');
//     var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//     flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification());
//   }
//
//   Future onSelectNotification(String payload) async {
//     // Handle notification tapped
//   }
//
//   Future<void> _scheduleNotification() async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'alarm_channel',
//       'Alarm',
//       'Channel for alarm notifications',
//       importance: Importance.high,
//       priority: Priority.high,
//       showWhen: false,
//     );
//     var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//     );
//
//     // Convert the selected time to DateTime
//     var now = DateTime.now();
//     var selectedDateTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       selectedTime.hour,
//       selectedTime.minute,
//     );
//
//     // Schedule the notification
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       'Alarm',
//       'Wake up!',
//       TZDateTime.from(selectedDateTime, local),
//       platformChannelSpecifics,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//       UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Set Alarm'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Selected time:',
//               style: TextStyle(fontSize: 20),
//             ),
//             SizedBox(height: 10),
//             Text(
//               selectedTime == null
//                   ? 'Please select a time'
//                   : selectedTime.format(context),
//               style: TextStyle(fontSize: 30),
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () async {
//                 // Show the time picker and update the selected time
//                  var time = await showTimePicker(
//                   context: context,
//                   initialTime: TimeOfDay.now(),
//                 );
//                 setState(() {
//                   selectedTime = time!;
//                 });
//               },
//               child: Text('Select Time'),
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: selectedTime == null ? null : _scheduleNotification,
//               child: Text('Set Alarm'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }