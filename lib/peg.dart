library pegjs;

import "dart:js";

final JsObject PEG = context["PEG"];

class PegParser {
  String grammar;
  var exception;
  JsObject parser;
  PegParser(this.grammar,this.parser,[this.exception=null]);
  /**
   * To generate a parser, call the PEG.buildParser method and pass your 
   * grammar as a parameter:
   *     var parser = PEG.buildParser("start = ('a' / 'b')+");
   * The method will return generated parser object or its source code 
   * as a string (depending on the value of the output option — see below). 
   * It will throw an exception if the grammar is invalid. The exception
   * will contain message property with more details about the error.
   * You can tweak the generated parser by passing a second parameter with 
   * an options object to PEG.buildParser. 
   * The following options are supported:
   * **cache**
   *   If true, makes the parser cache results, avoiding exponential 
   *   parsing time in pathological cases but making the parser slower 
   *   *(default: false)*.
   * **allowedStartRules**
   *   Rules the parser will be allowed to start parsing from 
   *   *(default: the first rule in the grammar)*.
   * **output**
   *   If set to "parser", the method will return generated parser object; 
   *  if set to "source", it will return parser source code as a string 
   *  *(default: "parser")*.
   * **optimize**
   *   Selects between optimizing the generated parser for parsing speed 
   *   ("speed") or code size ("size")
   *   *(default: "speed")*.
   * **plugins**
   *   Plugins to use.
   */
  factory PegParser.buildParser( String peg_, {cache:null, allowedStartRules:null, 
      output:null, optimize:null, plugins:null} ){
    Map args = { 'cache':cache, 'allowedStartRules':allowedStartRules,
                 'output':output, 'optimize':optimize, 'plugins':plugins };
    var jsArgs = new JsObject.jsify(args);
    JsObject parser = null;
    var exception;
    try{
      parser = PEG.callMethod("buildParser",[peg_]);
    }catch( e ){
      exception = e;
    }
    return new PegParser(peg_,parser,exception);
  }
  parse( String txt_ ){
    return parser.callMethod("parse", [txt_] );
  }
}
