import 'package:intl/intl.dart';

/// Extension functions on Num
extension NumExtension on num {
  String get toGroupSeparate =>
      this < 1000 ? "$this" : NumberFormat('#,##,000', "en_US").format(this);
}
