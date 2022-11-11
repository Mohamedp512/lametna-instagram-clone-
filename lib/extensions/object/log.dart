import 'dart:developer'as devtools;

extension Log on Object {
  void log() => devtools.log(toString());
}