import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget DateFormatter(
  dynamic _date,
) {
  return Jiffy(DateTime.parse(_date))
          .fromNow()
          .toString()
          .contains(RegExp(r'hours|minutes|seconds'))
      ? Text(
          Jiffy(DateTime.parse(_date)).fromNow(),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        )
      : Text(
          DateFormat('MMM dd, yyyy').format(DateTime.parse(_date)),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        );
}
