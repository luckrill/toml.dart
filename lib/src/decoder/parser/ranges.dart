library toml.src.decoder.parser.ranges;

import 'package:petitparser/petitparser.dart';

/// Parser for a binary digits.
///
///     digit0-1 = %x30-31                 ; 0-1
Parser<String> tomlBinDigit([String message = 'binary digit expected']) =>
    pattern('0-1', message);

/// Parser for a octal digits.
///
///     digit0-7 = %x30-37                 ; 0-7
Parser<String> tomlOctDigit([String message = 'octal digit expected']) =>
    pattern('0-7', message);

/// Parser for hexadecimal digits.
///
///     HEXDIG = DIGIT / "A" / "B" / "C" / "D" / "E" / "F"
Parser<String> tomlHexDigit([String message = 'hexadecimal digit expected']) =>
    pattern('0-9a-fA-F', message);

/// Parser for non-EOL characters that are allowed in TOML comments.
///
///     non-eol = %x09 / %x20-7E / non-ascii
final Parser<String> tomlNonEol =
    ChoiceParser([char(0x09), range(0x20, 0x7E), tomlNonAscii]);

/// Parser for non-ASCII characters that are allowed in TOML comments and
/// literal strings.
///
///     non-ascii = %x80-D7FF / %xE000-10FFFF
///
/// The subrange `%x10000-10FFFF` is represented as surrogate pairs by Dart.
/// Since `petitparser` can only work with 16-Bit code units, we have to
/// parse the surrogate pairs manually.
final Parser<String> tomlNonAscii = ChoiceParser([
  range(0x80, 0xD7FF),
  range(0xE000, 0xFFFF),
  _tomlSurrogatePair,
]);

/// Parser for a UTF-16 surrogate pair.
///
/// Returns the combined Unicode code-point of the surrogate pair.
final Parser<String> _tomlSurrogatePair =
    (_tomlHighSurrogate & _tomlLowSurrogate).flatten('Surrogate pair expected');

/// Parser for high surrogates (`%xD800-DBFF`).
final Parser<String> _tomlHighSurrogate = range(0xD800, 0xDBFF);

/// Parser for low surrogates (`%xDC00-DFFF`).
final Parser<String> _tomlLowSurrogate = range(0xDC00, 0xDFFF);
