# toml.dart Examples

[![Example CI](https://github.com/just95/toml.dart/workflows/Example%20CI/badge.svg?branch=main)][toml-dart/actions/example]

This directory contains examples for the usage of the `toml.dart` package.

 - [`./filesystem_config_loader`][toml-dart/example/filesystem_config_loader] contains an example for how to load a configuration file in the Dart VM from the local filesystem.

 - [`./filesystem_config_saver`][toml-dart/example/filesystem_config_saver] contains an example for how to save a configuration file in the Dart VM to the local filesystem.

 - [`./flutter_example`][toml-dart/example/flutter_example] contains a Flutter example for how to use the `toml.dart` library to decode a TOML document as an asset string.

 - [`./http_config_loader`][toml-dart/example/http_config_loader] contains an example for how to load a configuration file in the browser via HTTP.

 - [`./toml_encoder`][toml-dart/example/toml_encoder] contains an example for how to use the `TomlDocument.fromMap` and `TomlDocument.toString` methods to encode a `Map` as a TOML document.

 - [`./toml_parser`][toml-dart/example/toml_parser] contains an example for how to use the `TomlDocument.parse` and `TomlDocument.toMap` methods to decode a TOML document from a string that has been read from `stdin`.

 - [`./toml_to_json`][toml-dart/example/toml_to_json] contains an example application for the conversion of TOML documents to JSON.

[toml-dart/actions/example]:
  https://github.com/just95/toml.dart/actions?query=workflow%3A%22Example+CI%22
  "toml.dart CI Pipeline for Examples"

[toml-dart/example/filesystem_config_loader]:
  https://github.com/just95/toml.dart/tree/main/example/filesystem_config_loader
  "FilesystemConfigLoader Example | toml.dart"

[toml-dart/example/flutter_example]:
  https://github.com/just95/toml.dart/tree/main/example/flutter_example
  "Flutter Example | toml.dart"

[toml-dart/example/http_config_loader]:
  https://github.com/just95/toml.dart/tree/main/example/http_config_loader
  "HttpConfigLoader Example | toml.dart"

[toml-dart/example/toml_encoder]:
  https://github.com/just95/toml.dart/tree/main/example/toml_encoder
  "TomlEncoder Example | toml.dart"

[toml-dart/example/toml_parser]:
  https://github.com/just95/toml.dart/tree/main/example/toml_parser
  "TOML Parser Example | toml.dart"

[toml-dart/example/toml_to_json]:
  https://github.com/just95/toml.dart/tree/main/example/toml_to_json
  "TOML to JSON Converter Example Application | toml.dart"
