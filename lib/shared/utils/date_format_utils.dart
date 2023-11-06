import 'package:intl/intl.dart';

String dobDateFormat(DateTime date) {
  DateFormat dateFormat = DateFormat("MMMM d");
  return dateFormat.format(date);
}

String travelDateFormat(DateTime? date){
  DateFormat dateFormat = DateFormat("EEE dd-MM-yyyy  @ hh:mm a");
  return date!=null? dateFormat.format(date):"null";
}

String systemDateFormat(DateTime date){
  DateFormat dateFormat = DateFormat("dd-MM-yyyy @ hh:mm a");
  return dateFormat.format(date);
}
