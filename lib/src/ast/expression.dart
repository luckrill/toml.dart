library toml.src.ast.expression;

import 'package:petitparser/petitparser.dart';

import '../decoder/parser/whitespace.dart';
import '../util/parser.dart';
import 'expression/key_value_pair.dart';
import 'expression/table.dart';
import 'node.dart';
import 'visitor/expression.dart';
import 'visitor/node.dart';

/// Base class of all TOML expression nodes.
///
/// Expressions are either [TomlKeyValuePair]s or [TomlTable]s.
///
///     expression =  ws [ comment ]
///     expression =/ ws keyval ws [ comment ]
///     expression =/ ws table ws [ comment ]
abstract class TomlExpression extends TomlNode {
  /// Parser for TOML expressions.
  ///
  /// Returns `null` if the expression is just a blank line or comment.
  static final Parser<TomlExpression?> parser = ChoiceParser(
    [_keyvalParser, _tableParser, _blackParser],
    failureJoiner: selectFarthestJoined,
  );

  /// Parser for a TOML key value pair with indentation and an optional comment.
  static final Parser<TomlExpression> _keyvalParser = TomlKeyValuePair.parser
      .surroundedBy(tomlWhitespace)
      .followedBy(tomlComment.optional())
      .followedBy(_lookAheadParser);

  /// Parser for TOML table header with indentation and an optional comment.
  static final Parser<TomlExpression> _tableParser = TomlTable.parser
      .surroundedBy(tomlWhitespace)
      .followedBy(tomlComment.optional())
      .followedBy(_lookAheadParser);

  /// Parser for blank line with optional comment.
  static final Parser<Null> _blackParser = epsilonWith(null)
      .followedBy(tomlWhitespace)
      .followedBy(tomlComment.optional())
      .followedBy(_lookAheadParser);

  /// A parser that looks ahead for a newline or end of input but does not
  /// consume anything.
  ///
  /// This parser improves the error message that is reported when there
  /// are multiple expressions on the same line. Without this parser syntax
  /// errors in expressions would not be reported either since [_blackParser]
  /// would always match.
  static final Parser _lookAheadParser = ChoiceParser([
    tomlNewline,
    endOfInput('newline or end of input expected'),
  ]).and();

  /// Invokes the correct `visit*` method for this expression of the given
  /// visitor.
  T acceptExpressionVisitor<T>(TomlExpressionVisitor<T> visitor);

  @override
  T acceptVisitor<T>(TomlVisitor<T> visitor) => visitor.visitExpression(this);
}
