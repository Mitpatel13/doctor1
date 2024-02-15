class FindTime {
  String fromTime(String hour, String minute, String amPm) {
    if (hour == "12" && amPm == "AM") {
      return "00" + minute;
    } else if (amPm == "PM" && hour != "12") {
      return (int.parse(hour) + 12).toString() + minute;
    } else {
      return hour + minute;
    }
  }

  String toTime(int time) {
    var times = time.toString().padLeft(4, "0");
    if (times.substring(0, 2) == 00) {
      return "12 " + times.substring(2) + " AM";
    } else if (time < 1300 && time >= 1200) {
      return times.substring(0, 2) + " " + times.substring(2) + " PM";
      // {
      //   "hour": times.substring(0, 2),
      //   "time": times.substring(2),
      //   "amPm": "PM"
      // };
    } else if (time >= 1300) {
      times = (time - 1200).toString().padLeft(4, "0");
      return times.substring(0, 2) + " " + times.substring(2) + " PM";
    } else {
      return times.substring(0, 2) + " " + times.substring(2) + " AM";
    }
  }
}
