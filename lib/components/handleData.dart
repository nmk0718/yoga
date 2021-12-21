handleDate(String oldTime) {
  String nowTime =
      new DateTime.now().toString().split('.')[0];

  int nowyear = int.parse(nowTime.split(" ")[0].split('-')[0]);
  int nowmonth = int.parse(nowTime.split(" ")[0].split('-')[1]);
  int nowday = int.parse(nowTime.split(" ")[0].split('-')[2]);
  int nowhour = int.parse(nowTime.split(" ")[1].split(':')[0]);
  int nowmin = int.parse(nowTime.split(" ")[1].split(':')[1]);
  int nowsed = int.parse(nowTime.split(" ")[1].split(':')[2]);

  int oldyear = int.parse(oldTime.split(" ")[0].split('-')[0]);
  int oldmonth = int.parse(oldTime.split(" ")[0].split('-')[1]);
  int oldday = int.parse(oldTime.split(" ")[0].split('-')[2]);
  int oldhour = int.parse(oldTime.split(" ")[1].split(':')[0]);
  int oldmin = int.parse(oldTime.split(" ")[1].split(':')[1]);
  int oldsed = int.parse(oldTime.split(" ")[1].split(':')[2]);

  var now = new DateTime(nowyear, nowmonth, nowday, nowhour, nowmin, nowsed);
  var old = new DateTime(oldyear, oldmonth, oldday, oldhour, oldmin, oldsed);
  var difference = now.difference(old);

  if (difference.inDays > 365) {
    return old.year.toString() +
        '年' +
        old.month.toString() +
        '月' +
        old.day.toString() +
        "日";
  } else if (difference.inDays > 6 && difference.inDays < 365) {
    return old.month.toString() + '月' + old.day.toString() + "日";
  } else if (difference.inDays >= 1 && difference.inDays < 6) {
    return (difference.inDays).toString() + '天';
  } else if (difference.inHours >= 1 && difference.inHours < 24) {
    return (difference.inHours).toString() + '时';
  } else if (difference.inMinutes >= 1 && difference.inMinutes < 60) {
    return (difference.inMinutes).toString() + '分';
  } else if (difference.inSeconds >= 1 && difference.inSeconds < 60) {
    return (difference.inSeconds).toString() + '秒';
  }
}
