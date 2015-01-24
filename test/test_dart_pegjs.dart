import "package:unittest/unittest.dart";
import 'package:unittest/html_config.dart';
import 'dart:html';
import "package:pegjs/peg.dart";

void onArithmeticPeg( String txt_ ){
  PegParser parser = new PegParser.buildParser(txt_);
  var result = parser.parse("2*(3+4)");
  print( "Result: $result");
  expect( result, equals(14) );
  expect( parser.parser, isNotNull );
  expect( parser.grammar, equals(txt_) );
}


void onArithmeticErrorPeg( String txt_ ){
  String txt = "foo\n$txt_";
  PegParser parser = new PegParser.buildParser(txt);
  expect( parser.exception, isNotNull );
  expect( parser.exception, startsWith('SyntaxError: Expected "=" or string but "{" found.') );
  expect( parser.parser, isNull );
  expect( parser.grammar, equals(txt) );
}

void main(){
  useHtmlConfiguration();
  group( "PEG jsInterop", (){
    test( "PEG JS context loaded", (){
      expect( PEG, isNotNull );
    });
    test( "PEG Arithmetic loads and parses", (){
      var request = HttpRequest.getString("arithmetic.pegjs").then( expectAsync(onArithmeticPeg) );
    });
    test( "PEG error", (){
      var request = HttpRequest.getString("arithmetic.pegjs").then( expectAsync(onArithmeticErrorPeg) );
    });
  });
}