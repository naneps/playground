import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

/// A utility class for formatting dates and times.
class DateFormatter {
  final String? locale;
  final DateFormat _dateFormat;

  /// Constructs a [DateFormatter] instance.
  ///
  /// The [locale] parameter specifies the locale to be used for formatting.
  /// The [format] parameter specifies the date format pattern.
  DateFormatter({this.locale, String? format})
      : _dateFormat = DateFormat(format ?? 'dd MMMM yyyy', locale);

  /// Formats the given [date] as a relative time from now.
  ///
  /// Returns a string representing the relative time from now, such as "2 minutes ago".
  String dateFromNow(String date) {
    initialize();
    final dateTime = DateTime.parse(date);
    final diff = DateTime.now().difference(dateTime);
    return _formatTimeDifference(
      diff,
      'ago',
    );
  }

  /// Formats the given [date] as a future time from now.
  ///
  /// Returns a string representing the future time from now, such as "in 2 minutes".
  String dateFuture(String date) {
    initialize();
    final dateTime = DateTime.parse(date);
    final diff = dateTime.difference(DateTime.now());
    return _formatTimeDifference(diff, 'lagi');
  }

  /// Formats the given [date] as "day month year" format.
  ///
  /// Returns a string representing the date in the format "Saturday 25 May".
  String dayMonthYear(String date) {
    initialize();
    final dateTime = DateTime.parse(date);
    final format = DateFormat('EEEE dd MMMM', locale);
    return format.format(dateTime);
  }

  /// Formats the given [date] as "dd MMMM yyyy" format.
  ///
  /// Returns a string representing the date in the format "25 May 2022".
  String ddMMMMyyyy(String date) {
    initialize();
    final dateTime = DateTime.parse(date);
    return _dateFormat.format(dateTime);
  }

  /// Formats the given [date] as "dd MM yyyy" format.
  ///
  /// Returns a string representing the date in the format "25 05 2022".
  String ddMMyyyy(String date) {
    initialize();
    final dateTime = DateTime.parse(date);
    return _dateFormat.format(dateTime);
  }

  /// Formats the given [date] as "dd MMMM yyyy HH:mm" format.
  ///
  /// Returns a string representing the date and time in the format "25 May 2022 13:45".
  String ddMMyyyyHHmm(String date) {
    initialize();
    final format = DateFormat('dd MMMM yyyy HH:mm', locale);
    final dateTime = DateTime.parse(date);
    return format.format(dateTime);
  }

  /// Formats the given [date] as "dd MMMM yyyy HH:mm:ss" format.
  ///
  /// Returns a string representing the date and time in the format "25 May 2022 13:45:30".
  String ddMMyyyyHHmmss(String date) {
    initialize();
    final format = DateFormat('dd MMMM yyyy HH:mm:ss', locale);
    final dateTime = DateTime.parse(date);
    return format.format(dateTime);
  }

  /// Initializes the date formatting for the specified locale.
  void initialize() {
    initializeDateFormatting(locale ?? 'en');
  }

  /// Returns the name of the month based on the given [month] number.
  ///
  /// The [isShort] parameter specifies whether to return the abbreviated month name.
  /// Returns the month name, such as "May" or "Jan" depending on the [isShort] parameter.
  String monthFromNumber(
    int month, {
    bool isShort = false,
  }) {
    initialize();
    final format = DateFormat(isShort ? 'MMM' : 'MMMM', locale);
    final dateTime = DateTime(2000, month);
    return format.format(dateTime);
  }

  /// Formats the given [time] as a relative time from now.
  ///
  /// Returns a string representing the relative time from now, such as "13:45".
  String timeFromNow(String time) {
    initialize();
    final format = DateFormat('HH:mm', locale);
    final dateTime = DateTime.parse(time);
    return format.format(dateTime);
  }

  String _formatTimeDifference(
    Duration difference,
    String label,
  ) {
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute $label';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour $label';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day $label';
    } else {
      return _dateFormat.format(DateTime.now().subtract(difference));
    }
  }
}
