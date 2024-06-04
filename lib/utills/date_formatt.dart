import 'package:intl/intl.dart';

String getFormattedDateTime(dynamic date) {
  DateFormat formattedDate = DateFormat('MMM dd yyyy, hh:mm a');
  // print(date);
  String tmp = '';
  DateTime? dt;
  if (date is String) {
    dt = DateTime.tryParse(date);

    if (dt != null) {
      tmp = formattedDate.format(dt);
    }
  } else if (date is DateTime) {
    tmp = formattedDate.format(date);
  }

  return tmp;
}

String getTimeAgo(dynamic date) {
  String tmp = '';
  DateTime? dt;
  Duration diff = Duration();

  if (date is String) {
    dt = DateTime.tryParse(date);

    if (dt != null) {
      diff = DateTime.now().difference(dt);
      tmp = diff.inDays.toString();
    }
  } else if (date is DateTime) {
    diff = DateTime.now().difference(date);

    tmp = diff.inDays.toString();
  }
  return diff.inHours < 24 ? "${diff.inHours} hr ago" : "$tmp days ago";
}
