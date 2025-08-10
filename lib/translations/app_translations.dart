import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'hello': 'Hello',
      'dark_mode': 'Dark Mode',
      'change_lang': 'Change Language',
      'from_station': 'From Station',
      'from': 'From',
      'station': 'Station',
      'to': 'To',
      'where_to_go': 'Where to go?',
    },
    'ar_EG': {
      'hello': 'مرحباً',
      'dark_mode': 'الوضع الداكن',
      'change_lang': 'تغيير اللغة',
      'from_station': 'من محطة',
      'from': 'من',
      'station': 'محطة',
      'to': 'الى',
      'where_to_go': 'الي اين انت ذاهب',
    },
  };
}
