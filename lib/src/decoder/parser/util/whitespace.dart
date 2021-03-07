library toml.src.parser.util.whitespace;

import 'package:petitparser/petitparser.dart';

import 'join.dart';
import 'ranges.dart';

/// Parser for TOML whitespace.
///
///     ws = *wschar
final Parser<String> tomlWhitespace = tomlWhitespaceChar.star().join();

/// Parser for a single TOML whitepsace character.
///     wschar =  %x20  ; Space
///     wschar =/ %x09  ; Horizontal tab
final Parser<String> tomlWhitespaceChar =
    (char(' ') | char('\t')).cast<String>();

/// Parser for a TOML newline.
///
///     newline =  %x0A     ; LF
///     newline =/ %x0D.0A  ; CRLF
final Parser<String> tomlNewline = ChoiceParser([char('\n'), string('\r\n')]);

/// A regular expression for [tomlNewline].
final RegExp tomlNewlinePattern = RegExp('\n|\r\n');

/// Parser for a TOML comment.
///
///     comment-start-symbol = %x23 ; #
///     comment = comment-start-symbol *non-eol
final Parser tomlComment = char('#') & tomlNonEol.star();

/// Parser for arbitrarily many [tomlWhitespaceChar]s, [tomlNewline]s and
/// [tomlComment]s.
///
///     ws-comment-newline = *( wschar / [ comment ] newline )
final Parser tomlWhitespaceCommentNewline =
    (tomlWhitespaceChar | tomlComment.optional() & tomlNewline).star();
