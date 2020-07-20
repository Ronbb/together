import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:together/ignore/license.dart';

class HomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Meeting> meetings;
  final controller = MapController(
    location: LatLng(116.481485, 39.990464),
  );

  @override
  Widget build(BuildContext context) {
    controller.location = LatLng(116.481485, 39.990464);
    return Scaffold(
      body: Map(
        controller: controller,
        provider: const AMapProvider(),
      ),
      // body: SfCalendar(
      //   view: CalendarView.schedule,
      //   dataSource: MeetingDataSource(_getDataSource()),
      //   // by default the month appointment display mode set as Indicator, we can
      //   // change the display mode as appointment using the appointment display mode
      //   // property
      //   monthViewSettings: MonthViewSettings(
      //     appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
      //   ),
      // ),
    );
  }

//   List<Meeting> _getDataSource() {
//     meetings = <Meeting>[];
//     final DateTime today = DateTime.now();
//     final DateTime startTime =
//         DateTime(today.year, today.month, today.day, 9, 0, 0);
//     final DateTime endTime = startTime.add(const Duration(hours: 2));
//     meetings.add(Meeting(
//         'Conference', startTime, endTime, const Color(0xFF0F8644), false));
//     return meetings;
//   }
// }

// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }

//   @override
//   DateTime getStartTime(int index) {
//     return appointments[index].from;
//   }

//   @override
//   DateTime getEndTime(int index) {
//     return appointments[index].to;
//   }

//   @override
//   String getSubject(int index) {
//     return appointments[index].eventName;
//   }

//   @override
//   Color getColor(int index) {
//     return appointments[index].background;
//   }

//   @override
//   bool isAllDay(int index) {
//     return appointments[index].isAllDay;
//   }
// }

// class Meeting {
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

//   String eventName;
//   DateTime from;
//   DateTime to;
//   Color background;
//   bool isAllDay;
}

class AMapProvider extends MapProvider {
  const AMapProvider();

  @override
  ImageProvider getTile(int x, int y, int z) {
    //Can also use CachedNetworkImageProvider.
    return NetworkImage(
        'https://restapi.amap.com/v3/staticmap?location=$x,$y&zoom=10&size=2000*2000&markers=mid,,A:$x,$y&key=$AMAP_KEY');
  }
}
