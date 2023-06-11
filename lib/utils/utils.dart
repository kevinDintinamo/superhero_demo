import 'package:intl/intl.dart';

class Utils {
  static String getDateFormatted(String modifiedDate) {
    final dateTime = DateTime.tryParse(modifiedDate);
    if (dateTime == null) {
      return '';
    }

    final formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }
}
