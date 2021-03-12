library toml.test.decoder.parser.value_test;

import 'package:test/test.dart';
import 'package:toml/toml.dart';

void main() {
  group('TomlValue.parse', () {
    group('Array', () {
      test('can parse empty array', () {
        expect(
          TomlValue.parse('[]'),
          equals(TomlArray([])),
        );
      });
      test('can parse empty array with whitespace', () {
        expect(
          TomlValue.parse('[ ]'),
          equals(TomlArray([])),
        );
      });
      test('can parse array of integers', () {
        expect(
          TomlValue.parse('[1, 2, 3]'),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse heterogeneous arrays', () {
        expect(
          TomlValue.parse('[1, true, 3.0]'),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlBoolean(true),
            TomlFloat(3.0),
          ])),
        );
      });
      test('can parse array with trailing comma', () {
        expect(
          TomlValue.parse('[1, 2, 3,]'),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('cannot parse array with comma only', () {
        expect(
          () => TomlValue.parse('[,]'),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('can parse array with whitespace after the opening bracket', () {
        expect(
          TomlValue.parse('[ 1, 2, 3]'),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with whitespace before the closing bracket', () {
        expect(
          TomlValue.parse('[1, 2, 3 ]'),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with whitespace before commas', () {
        expect(
          TomlValue.parse('[1 , 2 , 3]'),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with newlines after the opening bracket', () {
        expect(
          TomlValue.parse('[\n1, 2, 3]'),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with newlines before the closing bracket', () {
        expect(
          TomlValue.parse('[1, 2, 3\n]'),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with newlines after commas', () {
        expect(
          TomlValue.parse(
            '[1,\n'
            ' 2,\n'
            ' 3]',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with newlines before commas', () {
        expect(
          TomlValue.parse(
            '[1\n'
            ', 2\n'
            ', 3]',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with indentation before commas', () {
        expect(
          TomlValue.parse(
            '[   1\n'
            '  , 2\n'
            '  , 3\n'
            ']',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with indentation before closing bracket', () {
        expect(
          TomlValue.parse(
            '[ 1, 2, 3\n'
            '  ]',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with comment after opening bracket', () {
        expect(
          TomlValue.parse(
            '[ # Comment\n'
            '  1, 2, 3 ]',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with multiline comment after opening bracket', () {
        expect(
          TomlValue.parse(
            '[ # Line 1\n'
            '  # Line 2\n'
            '  1, 2, 3 ]',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with comment before closing bracket', () {
        expect(
          TomlValue.parse(
            '[ 1, 2, 3 # Comment\n'
            ']',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with multiline comment before closing bracket', () {
        expect(
          TomlValue.parse(
            '[ 1, 2, 3 # Line 1\n'
            '          # Line 2\n'
            ']',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with comment after comma', () {
        expect(
          TomlValue.parse(
            '[ 1, # Comment\n'
            '  2, 3 ]',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with multiline comment after comma', () {
        expect(
          TomlValue.parse(
            '[ 1, # Line 1\n'
            '     # Line 2\n'
            '  2, 3 ]',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with comment before comma', () {
        expect(
          TomlValue.parse(
            '[ 1 # Comment\n'
            ', 2, 3 ]',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with multiline comment before comma', () {
        expect(
          TomlValue.parse(
            '[ 1 # Line 1\n'
            '    # Line 2\n'
            ', 2, 3 ]',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with comment after trailing comma', () {
        expect(
          TomlValue.parse(
            '[ 1, 2, 3, # Comment\n'
            ']',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with multiline comment after trailing comma', () {
        expect(
          TomlValue.parse(
            '[ 1, 2, 3, # Line 1\n'
            '           # Line 2\n'
            ']',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with comment before trailing comma', () {
        expect(
          TomlValue.parse(
            '[ 1, 2, 3 # Comment\n'
            ', ]',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
      test('can parse array with multiline comment before trailing comma', () {
        expect(
          TomlValue.parse(
            '[ 1, 2, 3 # Line 1\n'
            '          # Line 2\n'
            ', ]',
          ),
          equals(TomlArray([
            TomlInteger.dec(BigInt.from(1)),
            TomlInteger.dec(BigInt.from(2)),
            TomlInteger.dec(BigInt.from(3))
          ])),
        );
      });
    });
    group('Boolean', () {
      test('can parse true', () {
        expect(
          TomlValue.parse('true'),
          equals(TomlBoolean(true)),
        );
      });
      test('can parse false', () {
        expect(
          TomlValue.parse('false'),
          equals(TomlBoolean(false)),
        );
      });
    });
    group('Offset Date-Time', () {
      test('can parse UTC date-times', () {
        expect(
          TomlValue.parse('1989-11-09 17:53:00Z'),
          equals(TomlOffsetDateTime(
            TomlFullDate(1989, 11, 9),
            TomlPartialTime(17, 53, 0),
            TomlTimeZoneOffset.utc(),
          )),
        );
      });
      test('allows \'T\' as a separator between date and time', () {
        expect(
          TomlValue.parse('1989-11-09T17:53:00Z'),
          equals(TomlOffsetDateTime(
            TomlFullDate(1989, 11, 9),
            TomlPartialTime(17, 53, 0),
            TomlTimeZoneOffset.utc(),
          )),
        );
      });
      test('can parse date-times with numeric time zone offset', () {
        expect(
          TomlValue.parse('1989-11-09 18:53:00+01:00'),
          equals(TomlOffsetDateTime(
            TomlFullDate(1989, 11, 9),
            TomlPartialTime(18, 53, 0),
            TomlTimeZoneOffset.positive(1, 0),
          )),
        );
      });
      test('can parse date-times with fractions of a second', () {
        expect(
          TomlValue.parse('1989-11-09 18:53:00.0099999+01:00'),
          equals(TomlOffsetDateTime(
            TomlFullDate(1989, 11, 9),
            TomlPartialTime(18, 53, 0, [009, 999, 900]),
            TomlTimeZoneOffset.positive(1, 0),
          )),
        );
      });
      test('rejects offset date-times with invalid hours', () {
        expect(
          () => TomlValue.parse('1989-11-09 18:53:00+24:00'),
          throwsA(isA<ArgumentError>()),
        );
      });
      test('rejects offset date-times with invalid minutes', () {
        expect(
          () => TomlValue.parse('1989-11-09 18:53:00+01:60'),
          throwsA(isA<ArgumentError>()),
        );
      });
    });
    group('Local Date-Time', () {
      test('can parse date-times without time-zone offset', () {
        expect(
          TomlValue.parse('1989-11-09 17:53:00'),
          equals(TomlLocalDateTime(
            TomlFullDate(1989, 11, 9),
            TomlPartialTime(17, 53, 0),
          )),
        );
      });
      test('allows \'T\' as a separator between date and time', () {
        expect(
          TomlValue.parse('1989-11-09T17:53:00'),
          equals(TomlLocalDateTime(
            TomlFullDate(1989, 11, 9),
            TomlPartialTime(17, 53, 0),
          )),
        );
      });
      test('can parse date-times with fractions of a second', () {
        expect(
          TomlValue.parse('1989-11-09 18:53:00.0099999'),
          equals(TomlLocalDateTime(
            TomlFullDate(1989, 11, 9),
            TomlPartialTime(18, 53, 0, [009, 999, 900]),
          )),
        );
      });
    });
    group('Local Date', () {
      test('can parse dates without time', () {
        expect(
          TomlValue.parse('1989-11-09'),
          equals(TomlLocalDate(TomlFullDate(1989, 11, 9))),
        );
      });
      test('rejects dates with invalid months', () {
        expect(
          () => TomlValue.parse('1989-13-09'),
          throwsA(isA<ArgumentError>()),
        );
      });
      test('rejects dates with invalid day', () {
        expect(
          () => TomlValue.parse('1989-11-31'),
          throwsA(isA<ArgumentError>()),
        );
      });
      test('accepts leap day of leap-year', () {
        expect(
          TomlValue.parse('2020-02-29'),
          equals(TomlLocalDate(TomlFullDate(2020, 2, 29))),
        );
      });
      test('rejects leap day of non-leap-year', () {
        expect(
          () => TomlValue.parse('2021-02-29'),
          throwsA(isA<ArgumentError>()),
        );
      });
    });
    group('Local Time', () {
      test('can parse time without date', () {
        expect(
          TomlValue.parse('17:53:00'),
          equals(TomlLocalTime(TomlPartialTime(17, 53, 0))),
        );
      });
      test('can parse time with fractions of a second', () {
        expect(
          TomlValue.parse('18:53:00.0099999'),
          equals(TomlLocalTime(TomlPartialTime(18, 53, 0, [009, 999, 900]))),
        );
      });
    });
    group('Float', () {
      test('can parse zero without sign', () {
        expect(
          TomlValue.parse('0.0'),
          equals(TomlFloat(0.0)),
        );
      });
      test('can parse zero with plus sign', () {
        var node = TomlValue.parse('+0.0');
        expect(node, isA<TomlFloat>());
        if (node is TomlFloat) {
          expect(node.value, isZero);
          expect(node.value.isNegative, equals(false));
        }
      });
      test('can parse zero with minus sign', () {
        var node = TomlValue.parse('-0.0');
        expect(node, isA<TomlFloat>());
        if (node is TomlFloat) {
          expect(node.value, isZero);
          expect(node.value.isNegative, equals(true));
        }
      });
      test('can parse positive float with plus sign', () {
        expect(
          TomlValue.parse('+1.0'),
          equals(TomlFloat(1.0)),
        );
      });
      test('can parse positive float without plus sign', () {
        expect(
          TomlValue.parse('3.1415'),
          equals(TomlFloat(3.1415)),
        );
      });
      test('can parse negative float', () {
        expect(
          TomlValue.parse('-0.01'),
          equals(TomlFloat(-0.01)),
        );
      });
      test('can parse float with zero in exponent', () {
        expect(
          TomlValue.parse('1e0'),
          equals(TomlFloat(1)),
        );
      });
      test('can parse float without fractional part but with exponent', () {
        expect(
          TomlValue.parse('1e6'),
          equals(TomlFloat(1e6)),
        );
      });
      test('can parse float with plus sign in exponent', () {
        expect(
          TomlValue.parse('1e+6'),
          equals(TomlFloat(1e6)),
        );
      });
      test('can parse float with minus sign in exponent', () {
        expect(
          TomlValue.parse('1e-6'),
          equals(TomlFloat(1e-6)),
        );
      });
      test('can parse float with fractional and exponent part', () {
        expect(
          TomlValue.parse('6.626e-34'),
          equals(TomlFloat(6.626e-34)),
        );
      });
      test('rejects float with decimal dot but integer part', () {
        expect(
          () => TomlValue.parse('.1415'),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('rejects float with decimal dot but no fractional digits', () {
        expect(
          () => TomlValue.parse('3.'),
          throwsA(isA<TomlParserException>()),
        );
      });
      test(
        'rejects float with decimal dot and exponent part but no '
        'fractional digits',
        () {
          expect(
            () => TomlValue.parse('3.e+20'),
            throwsA(isA<TomlParserException>()),
          );
        },
      );
      test('requires the fractional part to precede the exponent part', () {
        expect(
          () => TomlValue.parse('6e-34.626'),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('allows underscores in integer part', () {
        expect(
          TomlValue.parse('1_2.34e57'),
          equals(TomlFloat(12.34e57)),
        );
      });
      test('allows underscores in fraction part', () {
        expect(
          TomlValue.parse('12.3_4e57'),
          equals(TomlFloat(12.34e57)),
        );
      });
      test('allows underscores in exponent', () {
        expect(
          TomlValue.parse('12.34e5_7'),
          equals(TomlFloat(12.34e57)),
        );
      });
      test('does not allow leading underscores in integer part', () {
        expect(
          () => TomlValue.parse('_12.34e57'),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('does not allow leading underscores in fractional part', () {
        expect(
          () => TomlValue.parse('12._34e57'),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('does not allow leading underscores in exponent', () {
        expect(
          () => TomlValue.parse('12.34e_57'),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('does not allow trailing underscores in integer part', () {
        expect(
          () => TomlValue.parse('12_.34e57'),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('does not allow trailing underscores in fractional part', () {
        expect(
          () => TomlValue.parse('12.34_e57'),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('does not allow trailing underscores in exponent', () {
        expect(
          () => TomlValue.parse('12.34e57_'),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('does not allow consecutive underscores in integer part', () {
        expect(
          () => TomlValue.parse('1__2.34e57'),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('does not allow consecutive underscores in fractional part', () {
        expect(
          () => TomlValue.parse('12.3__4e57'),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('does not allow consecutive underscores in exponent', () {
        expect(
          () => TomlValue.parse('12.34e5__7'),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('allows leading zeros in exponent part', () {
        expect(
          TomlValue.parse('12.34e+009'),
          equals(TomlFloat(12.34e9)),
        );
      });
      test('can parse positive infinity without plus sign', () {
        expect(
          TomlValue.parse('inf'),
          equals(TomlFloat(double.infinity)),
        );
      });
      test('can parse positive infinity with plus sign', () {
        expect(
          TomlValue.parse('+inf'),
          equals(TomlFloat(double.infinity)),
        );
      });
      test('can parse negative infinity', () {
        expect(
          TomlValue.parse('-inf'),
          equals(TomlFloat(double.negativeInfinity)),
        );
      });
      test('can parse NaN without sign', () {
        expect(TomlValue.parse('nan'), equals(TomlFloat(double.nan)));
      });
      test('can parse NaN with plus sign', () {
        expect(TomlValue.parse('+nan'), equals(TomlFloat(double.nan)));
      });
      test('can parse NaN with minus sign', () {
        expect(TomlValue.parse('-nan'), equals(TomlFloat(double.nan)));
      });
    });
    group('Integer', () {
      group('Binary', () {
        test('can parse binary integers', () {
          expect(
            TomlValue.parse('0b101010'),
            equals(TomlInteger.bin(BigInt.from(42))),
          );
        });
        test('can parse binary integers with leading zeros', () {
          expect(
            TomlValue.parse('0b00101010'),
            equals(TomlInteger.bin(BigInt.from(42))),
          );
        });
        test('can parse binary integers with underscores', () {
          expect(
            TomlValue.parse('0b10_10_10'),
            equals(TomlInteger.bin(BigInt.from(42))),
          );
        });
        test('cannot parse binary integer with leading underscores', () {
          expect(
            () => TomlValue.parse('0b_101010'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('cannot parse binary integer with trailing underscores', () {
          expect(
            () => TomlValue.parse('0b101010_'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('cannot parse binary integer with consecutive underscores', () {
          expect(
            () => TomlValue.parse('0b10__1010'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('cannot parse binary integer without digits', () {
          expect(
            () => TomlValue.parse('0b'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('cannot parse binary integer with non-binary digits', () {
          expect(
            () => TomlValue.parse('0b123'),
            throwsA(isA<TomlParserException>()),
          );
        });
      });
      group('Octal', () {
        test('can parse octal integers', () {
          expect(
            TomlValue.parse('0o755'),
            equals(TomlInteger.oct(BigInt.from(493))),
          );
        });
        test('can parse octal integers with leading zeros', () {
          expect(
            TomlValue.parse('0o0755'),
            equals(TomlInteger.oct(BigInt.from(493))),
          );
        });
        test('can parse octal integers with underscores', () {
          expect(
            TomlValue.parse('0o7_5_5'),
            equals(TomlInteger.oct(BigInt.from(493))),
          );
        });
        test('cannot parse octal integer with leading underscores', () {
          expect(
            () => TomlValue.parse('0o_755'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('cannot parse octal integer with trailing underscores', () {
          expect(
            () => TomlValue.parse('0o755_'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('cannot parse octal integer with consecutive underscores', () {
          expect(
            () => TomlValue.parse('0o7__55'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('cannot parse octal integer without digits', () {
          expect(
            () => TomlValue.parse('0o'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('cannot parse octal integer with non-octal digits', () {
          expect(
            () => TomlValue.parse('0o888'),
            throwsA(isA<TomlParserException>()),
          );
        });
      });
      group('Decimal', () {
        test('can parse zero without sign', () {
          expect(
            TomlValue.parse('0'),
            equals(TomlInteger.dec(BigInt.from(0))),
          );
        });
        test('can parse zero with plus sign', () {
          expect(
            TomlValue.parse('+0'),
            equals(TomlInteger.dec(BigInt.from(0))),
          );
        });
        test('can parse zero with minus sign', () {
          expect(
            TomlValue.parse('-0'),
            equals(TomlInteger.dec(BigInt.from(0))),
          );
        });
        test('can parse positive number with plus sign', () {
          expect(
            TomlValue.parse('+99'),
            equals(TomlInteger.dec(BigInt.from(99))),
          );
        });
        test('can parse positive number without plus sign', () {
          expect(
            TomlValue.parse('42'),
            equals(TomlInteger.dec(BigInt.from(42))),
          );
        });
        test('can parse negative number', () {
          expect(
            TomlValue.parse('-17'),
            equals(TomlInteger.dec(BigInt.from(-17))),
          );
        });
        test('does not allow leading zeros', () {
          expect(
            () => TomlValue.parse('0777'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('allows underscores to be used as separators', () {
          expect(
            TomlValue.parse('1_000'),
            equals(TomlInteger.dec(BigInt.from(1000))),
          );
        });
        test('allows underscores between every number', () {
          expect(
            TomlValue.parse('1_2_3_4_5'),
            equals(TomlInteger.dec(BigInt.from(12345))),
          );
        });
        test('does not allow leading underscores', () {
          expect(
            () => TomlValue.parse('_1000'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('does not allow trailing underscores', () {
          expect(
            () => TomlValue.parse('1000_'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('does not allow consecutive underscores', () {
          expect(
            () => TomlValue.parse('1__000'),
            throwsA(isA<TomlParserException>()),
          );
        });
      });
      group('Hexadecimal', () {
        test('can parse lower case hexadecimal integers', () {
          expect(
            TomlValue.parse('0xbadc0ded'),
            equals(TomlInteger.hex(BigInt.from(0xbadc0ded))),
          );
        });
        test('can parse upper case hexadecimal integers', () {
          expect(
            TomlValue.parse('0xBADC0DED'),
            equals(TomlInteger.hex(BigInt.from(0xbadc0ded))),
          );
        });
        test('can parse mixed case hexadecimal integers', () {
          expect(
            TomlValue.parse('0xBadC0ded'),
            equals(TomlInteger.hex(BigInt.from(0xbadc0ded))),
          );
        });
        test('can parse hexadecimal integers with leading zeros', () {
          expect(
            TomlValue.parse('0x0000c0de'),
            equals(TomlInteger.hex(BigInt.from(0xc0de))),
          );
        });
        test('can parse octal integers with underscores', () {
          expect(
            TomlValue.parse('0xbad_c0ded'),
            equals(TomlInteger.hex(BigInt.from(0xbadc0ded))),
          );
        });
        test('cannot parse octal integer with leading underscores', () {
          expect(
            () => TomlValue.parse('0x_badc0ded'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('cannot parse octal integer with trailing underscores', () {
          expect(
            () => TomlValue.parse('0xbadc0ded_'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('cannot parse octal integer with consecutive underscores', () {
          expect(
            () => TomlValue.parse('0xbad__c0ded'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('cannot parse octal integer without digits', () {
          expect(
            () => TomlValue.parse('0x'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('cannot parse octal integer with non-octal digits', () {
          expect(
            () => TomlValue.parse('0xZZZ'),
            throwsA(isA<TomlParserException>()),
          );
        });
      });
    });
    group('Inline Table', () {
      test('can parse empty inline table', () {
        expect(
          TomlValue.parse('{}'),
          equals(TomlInlineTable([])),
        );
      });
      test('can parse empty inline table with whitespace', () {
        expect(
          TomlValue.parse('{ }'),
          equals(TomlInlineTable([])),
        );
      });
      test('can parse empty inline table with single key/value pair', () {
        expect(
          TomlValue.parse('{ key = "value" }'),
          equals(TomlInlineTable([
            TomlKeyValuePair(
              TomlKey([TomlUnquotedKey('key')]),
              TomlBasicString('value'),
            )
          ])),
        );
      });
      test('can parse empty inline table with multiple key/value pairs', () {
        expect(
          TomlValue.parse('{ x = 1, y = 2, z = 3 }'),
          equals(TomlInlineTable([
            TomlKeyValuePair(
              TomlKey([TomlUnquotedKey('x')]),
              TomlInteger.dec(BigInt.from(1)),
            ),
            TomlKeyValuePair(
              TomlKey([TomlUnquotedKey('y')]),
              TomlInteger.dec(BigInt.from(2)),
            ),
            TomlKeyValuePair(
              TomlKey([TomlUnquotedKey('z')]),
              TomlInteger.dec(BigInt.from(3)),
            ),
          ])),
        );
      });
      test('does not allow trailing comma in inline table', () {
        expect(
          () => TomlValue.parse('{ x = 1, y = 2, z = 3, }'),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('allows multiline values in inline table', () {
        expect(
          TomlValue.parse(
            '{ key = """\n'
            '""" }',
          ),
          equals(TomlInlineTable([
            TomlKeyValuePair(
              TomlKey([TomlUnquotedKey('key')]),
              TomlMultilineBasicString(''),
            ),
          ])),
        );
      });
      test('does not allow newline after opening brace of inline table', () {
        expect(
          () => TomlValue.parse(
            '{\n'
            '  x = 1, y = 2, z = 3 }',
          ),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('does not allow newline before closing brace of inline table', () {
        expect(
          () => TomlValue.parse(
            '{ x = 1, y = 2, z = 3 \n'
            '}',
          ),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('does not allow newline before commas in inline table', () {
        expect(
          () => TomlValue.parse(
            '{ x = 1\n'
            ', y = 2\n'
            ', z = 3 }',
          ),
          throwsA(isA<TomlParserException>()),
        );
      });
      test('does not allow newline after commas in inline table', () {
        expect(
          () => TomlValue.parse(
            '{ x = 1,\n'
            '  y = 2,\n'
            '  z = 3 }',
          ),
          throwsA(isA<TomlParserException>()),
        );
      });
    });
    group('String', () {
      group('Basic', () {
        test('can parse empty basic string', () {
          expect(
            TomlValue.parse('""'),
            equals(TomlBasicString('')),
          );
        });
        test('can parse basic string with escape sequences', () {
          expect(
            TomlValue.parse(
              '"I\'m a string. '
              r'\"You can quote me\". '
              r'Name\tJos\u00E9\nLocation\tSF."',
            ),
            equals(TomlBasicString(
              'I\'m a string. '
              '\"You can quote me\". '
              'Name\tJos\u00E9\nLocation\tSF.',
            )),
          );
        });
        test('can parse basic string with escaped backslash', () {
          expect(
            TomlValue.parse(r'"some\\windows\\path"'),
            equals(TomlBasicString(r'some\windows\path')),
          );
        });
        test('does not allow invalid escape sequences', () {
          expect(
            () => TomlValue.parse(r'"some\windows\path"'),
            throwsA(isA<TomlInvalidEscapeSequenceException>()),
          );
        });
        test('does not allow newlines', () {
          expect(
            () => TomlValue.parse(
              '"Line 1\n'
              'Line 2"',
            ),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('allows raw tabs', () {
          expect(
            TomlValue.parse(
              '"Column 1\tColumn 2"',
            ),
            equals(TomlBasicString('Column 1\tColumn 2')),
          );
        });
        test('does not allow control characters', () {
          expect(
            () => TomlValue.parse('"\u0000"'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('does not allow unpaired UTF-16 surrogate code points', () {
          expect(
            () => TomlValue.parse(
              '"High surrogate \uD83E without low surrogat"',
            ),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('allows UTF-16 surrogate pairs', () {
          expect(
            TomlValue.parse(
              '"High and low surrogate \uD83E\uDDA6 as a pair"',
            ),
            equals(TomlBasicString(
              'High and low surrogate \uD83E\uDDA6 as a pair',
            )),
          );
        });
      });
      group('Multiline Basic', () {
        test('can parse empty multiline basic strings', () {
          expect(
            TomlValue.parse(
              '""""""',
            ),
            equals(TomlMultilineBasicString('')),
          );
        });
        test('can parse multiline basic string without newlines', () {
          expect(
            TomlValue.parse(
              '"""Roses are red, Violets are blue"""',
            ),
            equals(TomlMultilineBasicString(
              'Roses are red, Violets are blue',
            )),
          );
        });
        test('can parse multiline basic string with newlines', () {
          expect(
            TomlValue.parse(
              '"""Roses are red\n'
              'Violets are blue"""',
            ),
            equals(TomlMultilineBasicString(
              'Roses are red\n'
              'Violets are blue',
            )),
          );
        });
        test('allows Windows newlines', () {
          expect(
            TomlValue.parse(
              '"""Roses are red\r\nViolets are blue"""',
            ),
            equals(TomlMultilineBasicString(
              'Roses are red\r\nViolets are blue',
            )),
          );
        });
        test('trims first newline after opening delimiter', () {
          expect(
            TomlValue.parse(
              '"""\n'
              'Roses are red\n'
              'Violets are blue"""',
            ),
            equals(TomlMultilineBasicString(
              'Roses are red\n'
              'Violets are blue',
            )),
          );
        });
        test('does not trim final newline before closing delimiter', () {
          expect(
            TomlValue.parse(
              '"""Roses are red\n'
              'Violets are blue\n'
              '"""',
            ),
            equals(TomlMultilineBasicString(
              'Roses are red\n'
              'Violets are blue\n',
            )),
          );
        });
        test('allows trailing newlines and whitespace to be escaped', () {
          expect(
            TomlValue.parse(
              '"""\\\n'
              '  The quick brown \\\n'
              '\tfox jumps over \\  \n'
              '\t\tthe lazy dog.\\    \n'
              '"""',
            ),
            equals(TomlMultilineBasicString(
              'The quick brown fox jumps over the lazy dog.',
            )),
          );
        });
        test('requires line-ending backslashes to be unescaped', () {
          expect(
            TomlValue.parse(
              '"""Roses are red \\\\\n'
              'Violets are blue\n'
              '"""',
            ),
            equals(TomlMultilineBasicString(
              'Roses are red \\\n'
              'Violets are blue\n',
            )),
          );
        });
        test('allows two consecutive double quotes without escaping', () {
          expect(
            TomlValue.parse('"""Foo ""Bar"" Baz"""'),
            equals(TomlMultilineBasicString(
              'Foo ""Bar"" Baz',
            )),
          );
        });
        test('requires the third consecutive double quote to be escaped', () {
          expect(
            () => TomlValue.parse('"""Foo """Bar""" Baz"""'),
            throwsA(isA<TomlParserException>()),
          );
          expect(
            TomlValue.parse(r'"""Foo ""\"Bar""\" Baz"""'),
            equals(TomlMultilineBasicString(
              'Foo """Bar""" Baz',
            )),
          );
        });
        test('allows raw tabs', () {
          expect(
            TomlValue.parse(
              '"""Roses are red\tViolets are blue"""',
            ),
            equals(TomlMultilineBasicString('Roses are red\tViolets are blue')),
          );
        });
        test('does not allow control characters', () {
          expect(
            () => TomlValue.parse('"""\u0000"""'),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('does not allow unpaired UTF-16 surrogate code points', () {
          expect(
            () => TomlValue.parse(
              '"""High surrogate \uD83E without low surrogat"""',
            ),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('allows UTF-16 surrogate pairs', () {
          expect(
            TomlValue.parse(
              '"""High and low surrogate \uD83E\uDDA6 as a pair"""',
            ),
            equals(TomlMultilineBasicString(
              'High and low surrogate \uD83E\uDDA6 as a pair',
            )),
          );
        });
      });
      group('Literal', () {
        test('can parse empty literal strings', () {
          expect(
            TomlValue.parse("''"),
            equals(TomlLiteralString('')),
          );
        });
        test('ignores escape sequences in literal strings', () {
          expect(
            TomlValue.parse(r"'C:\Users\nodejs\templates'"),
            equals(TomlLiteralString(r'C:\Users\nodejs\templates')),
          );
        });
        test('allows raw tabs', () {
          expect(
            TomlValue.parse(
              "'Roses are red\tViolets are blue'",
            ),
            equals(TomlLiteralString('Roses are red\tViolets are blue')),
          );
        });
        test('does not allow unpaired UTF-16 surrogate code points', () {
          expect(
            () => TomlValue.parse(
              "'High surrogate \uD83E without low surrogat'",
            ),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('allows UTF-16 surrogate pairs', () {
          expect(
            TomlValue.parse(
              "'High and low surrogate \uD83E\uDDA6 as a pair'",
            ),
            equals(TomlLiteralString(
              'High and low surrogate \uD83E\uDDA6 as a pair',
            )),
          );
        });
      });
      group('Multiline Literal', () {
        test('can parse empty multiline literal strings', () {
          expect(
            TomlValue.parse("''''''"),
            equals(TomlMultilineLiteralString('')),
          );
        });
        test('trims first newline after opening delimiter', () {
          expect(
            TomlValue.parse(
              "'''\n"
              'Roses are red\n'
              'Violets are blue'
              "'''",
            ),
            equals(TomlMultilineLiteralString(
              'Roses are red\n'
              'Violets are blue',
            )),
          );
        });
        test('does not trim final newline before closing delimiter', () {
          expect(
            TomlValue.parse(
              "'''Roses are red\n"
              'Violets are blue\n'
              "'''",
            ),
            equals(TomlMultilineLiteralString(
              'Roses are red\n'
              'Violets are blue\n',
            )),
          );
        });
        test('allows raw tabs', () {
          expect(
            TomlValue.parse(
              "'''Roses are red\tViolets are blue'''",
            ),
            equals(TomlMultilineLiteralString(
              'Roses are red\tViolets are blue',
            )),
          );
        });
        test('allows Windows newlines', () {
          expect(
            TomlValue.parse(
              "'''Roses are red\r\nViolets are blue'''",
            ),
            equals(TomlMultilineLiteralString(
              'Roses are red\r\nViolets are blue',
            )),
          );
        });
        test('does not allow unpaired UTF-16 surrogate code points', () {
          expect(
            () => TomlValue.parse(
              "'''High surrogate \uD83E without low surrogat'''",
            ),
            throwsA(isA<TomlParserException>()),
          );
        });
        test('allows UTF-16 surrogate pairs', () {
          expect(
            TomlValue.parse(
              "'''High and low surrogate \uD83E\uDDA6 as a pair'''",
            ),
            equals(TomlMultilineLiteralString(
              'High and low surrogate \uD83E\uDDA6 as a pair',
            )),
          );
        });
      });
    });
  });
}
