library toml.src.ast.value.date_time.local_time;

import 'package:meta/meta.dart';
import 'package:petitparser/petitparser.dart';
import 'package:quiver/core.dart';

import '../../value.dart';
import '../../visitor/value/date_time.dart';
import '../date_time.dart';
import 'local_date_time.dart';

/// AST node that represents a TOML local time value.
///
///     local-time = partial-time
@immutable
class TomlLocalTime extends TomlDateTime {
  /// Parser for a TOML local time value.
  static final Parser<TomlLocalTime> parser =
      TomlPartialTime.parser.map((time) => TomlLocalTime(time));

  /// The time without time-zone offset.
  final TomlPartialTime time;

  /// Creates a new local time value.
  TomlLocalTime(this.time);

  /// Gets a [TomlLocalDateTime] that represents this time at the given date.
  TomlLocalDateTime atDate(TomlFullDate date) => TomlLocalDateTime(date, time);

  @override
  TomlType get type => TomlType.localTime;

  @override
  T acceptDateTimeVisitor<T>(TomlDateTimeVisitor<T> visitor) =>
      visitor.visitLocalTime(this);

  @override
  bool operator ==(Object other) =>
      other is TomlLocalTime && time == other.time;

  @override
  int get hashCode => hash2(type, time);
}
