within Modelica.Utilities;
package Examples
  "Examples to demonstrate the usage of package Modelica.Utilities"

  function calculator
    "Interpreter to evaluate simple expressions consisting of +,-,*,/,(),sin(), cos(), tan(), sqrt(), pi"
    import Modelica.Utilities.Strings.*;
    extends Modelica.Icons.Function;
    input String string "Expression that is evaluated";
    output Real result "Value of expression";

  protected
    Integer nextIndex;
  algorithm
    (result,nextIndex) := expression(string, 1);
    Strings.scanNoToken(string,nextIndex);

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
result = <b>calculator</b>(expression);
</pre></blockquote>
<h4>Description</h4>
<p>
This function demonstrates how a simple expression calculator
can be implemented in form of a recursive decent parser
using basically the Strings.scanToken(..) and Strings.scanDelimiter(..)
function.
</p>
<p>
The following operations are supported (pi=3.14.. is a predefined constant):
</p>
<pre>
   +, -
   *, /
   (expression)
   sin(expression)
   cos(expression)
   tan(expression)
   sqrt(expression)
   pi
</pre>
<h4>Example</h4>
<blockquote><pre>
  calculator(\"2+3*(4-1)\");  // returns 11
  calculator(\"sin(pi/6)\");  // returns 0.5
</pre></blockquote>
</html>"));
  end calculator;

  function expression
    "Expression interpreter that returns with the position after the expression (expression may consist of +,-,*,/,(),sin(), cos(), tan(), sqrt(), pi"
    import Modelica.Utilities.Types;
    import Modelica.Utilities.Strings;
    import Modelica.Math;
    import Modelica.Constants;

    extends Modelica.Icons.Function;
    input String string "Expression that is evaluated";
    input Integer startIndex=1
      "Start scanning of expression at character startIndex";
    input String message=""
      "Message used in error message if scan is not successful";
    output Real result "Value of expression";
    output Integer nextIndex "Index after the scanned expression";

  protected
  function term "Evaluate term of an expression"
    extends Modelica.Icons.Function;
    input String string;
    input Integer startIndex;
    input String message="";
    output Real result;
    output Integer nextIndex;
    protected
    Real result2;
    Boolean scanning=true;
    String opString;
  algorithm
    // scan for "primary * primary" or "primary / primary"
    (result, nextIndex) := primary(string, startIndex, message);
    while scanning loop
      (opString, nextIndex) := Strings.scanDelimiter(
                                      string, nextIndex, {"*","/",""}, message);
      if opString == "" then
         scanning := false;
      else
         (result2, nextIndex) := primary(string, nextIndex, message);
         result := if opString == "*" then result*result2 else result/result2;
      end if;
    end while;
  end term;

  function primary "Evaluate primary of an expression"
    extends Modelica.Icons.Function;

    input String string;
    input Integer startIndex;
    input String message="";
    output Real result;
    output Integer nextIndex;
    protected
    Types.TokenValue token;
    Real result2;
    String delimiter;
    String functionName;
    Real pi = Constants.pi;
  algorithm
    (token,nextIndex) := Strings.scanToken(string, startIndex,unsigned=true);
    if token.tokenType == Types.TokenType.DelimiterToken and token.string == "(" then
      (result,nextIndex) := expression(string, nextIndex,message);
      (delimiter,nextIndex) := Strings.scanDelimiter(string,nextIndex,{")"}, message);

    elseif token.tokenType == Types.TokenType.RealToken then
      result := token.real;

    elseif token.tokenType == Types.TokenType.IntegerToken then
      result := token.integer;

    elseif token.tokenType == Types.TokenType.IdentifierToken then
      if token.string == "pi" then
         result := pi;
      else
         functionName := token.string;
         (delimiter,nextIndex) := Strings.scanDelimiter(string,nextIndex,{"("}, message);
         (result,nextIndex)    := expression(string, nextIndex, message);
         (delimiter,nextIndex) := Strings.scanDelimiter(string,nextIndex,{")"}, message);
         if functionName == "sin" then
           result := Math.sin(result);
         elseif functionName == "cos" then
           result := Math.cos(result);
         elseif functionName == "tan" then
           result := Math.tan(result);
         elseif functionName == "sqrt" then
           if result < 0.0 then
              Strings.syntaxError(string, startIndex, "Argument of call \"sqrt(" + String(result) + ")\" is negative.\n" +
                          "Imaginary numbers are not supported by the calculator.\n" + message);
           end if;
           result := sqrt(result);
         else
           Strings.syntaxError(string, startIndex, "Function \"" + functionName + "\" is unknown (not supported)\n" +
                                           message);
         end if;
      end if;

    else
      Strings.syntaxError(string, startIndex, "Invalid primary of expression.\n" + message);
    end if;
  end primary;

    Real result2;
    String signOfNumber;
    Boolean scanning=true;
    String opString;
  algorithm
    // scan for optional leading "+" or "-" sign
    (signOfNumber, nextIndex) :=Strings.scanDelimiter(
                                     string, startIndex, {"+","-",""}, message);

    // scan for "term + term" or "term - term"
    (result, nextIndex) := term(string, nextIndex, message);
    if signOfNumber == "-" then
       result := -result;
    end if;

    while scanning loop
      (opString, nextIndex) := Strings.scanDelimiter(
                                      string, nextIndex, {"+","-",""}, message);
      if opString == "" then
         scanning := false;
      else
         (result2, nextIndex) := term(string, nextIndex, message);
         result := if opString == "+" then result+result2 else result-result2;
      end if;
    end while;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
             result = <b>expression</b>(string);
(result, nextIndex) = <b>expression</b>(string, startIndex=1, message=\"\");
</pre></blockquote>
<h4>Description</h4>
<p>
This function is nearly the same as Examples.<b>calculator</b>.
The essential difference is that function \"expression\" might be
used in other parsing operations: After the expression is
parsed and evaluated, the function returns with the value
of the expression as well as the position of the character
directly after the expression.
</p>
<p>
This function demonstrates how a simple expression calculator
can be implemented in form of a recursive decent parser
using basically the Strings.scanToken(..) and scanDelimiters(..)
function. There are 2 local functions (term, primary) that
implement the corresponding part of the grammar.
</p>
<p>
The following operations are supported (pi=3.14.. is a predefined constant):
</p>
<pre>
   +, -
   *, /
   (expression)
   sin(expression)
   cos(expression)
   tan(expression)
   sqrt(expression)
   pi
</pre>
<p>
The optional argument \"startIndex\" defines at which position
scanning of the expression starts.
</p>
<p>
In case of error,
the optional argument \"message\" is appended to the error
message, in order to give additional information where
the error occured.
</p>
<p>
This function parses the following grammaer
</p>
<pre>
  expression: [ add_op ] term { add_op term }
  add_op    : \"+\" | \"-\"
  term      : primary { mul_op primary }
  mul_op    : \"*\" | \"/\"
  primary   : UNSIGNED_NUMBER
              | pi
              | ( expression )
              | functionName( expression )
  function  :   sin
              | cos
              | tan
              | sqrt
</pre>
<p>
Note, in Examples.readRealParameter it is shown, how the expression
function can be used as part of another scan operation.
</p>
<h4>Example</h4>
<blockquote><pre>
  expression(\"2+3*(4-1)\");  // returns 11
  expression(\"sin(pi/6)\");  // returns 0.5
</pre></blockquote>
</html>"));
  end expression;

  function readRealParameter "Read the value of a Real parameter from file"
    import Modelica.Utilities.*;
    extends Modelica.Icons.Function;
    input String fileName "Name of file"       annotation(Dialog(
                           __Dymola_loadSelector(filter="Text files (*.txt)",
                           caption="Open file in which Real parameters are present")));
    input String name "Name of parameter";
    output Real result "Actual value of parameter on file";

  protected
    String line;
    String identifier;
    String delimiter;
    Integer nextIndex;
    Integer iline=1;
    Types.TokenValue token;
    String message = "in file \"" + fileName + "\" on line ";
    String message2;
    Boolean found = false;
    Boolean endOfFile=false;
  algorithm
   (line, endOfFile) :=Streams.readLine(fileName, iline);

    while not found and not endOfFile loop
      (token, nextIndex) := Strings.scanToken(line);
       if token.tokenType == Types.TokenType.NoToken then
          // skip line
          iline := iline + 1;
       elseif token.tokenType == Types.TokenType.IdentifierToken then
          if token.string == name then
             // name found, get value of "name = value;"
             message2 := message + String(iline);
             (delimiter,nextIndex) := Strings.scanDelimiter(line, nextIndex, {"="}, message2);
             (result,nextIndex)    := Examples.expression(line, nextIndex, message2);
             (delimiter,nextIndex) := Strings.scanDelimiter(line, nextIndex, {";", ""}, message2);
             Strings.scanNoToken(line, nextIndex, message2);
             found := true;
          else
             // wrong name, skip line
             iline := iline + 1;
          end if;
       else
          // wrong token
          Strings.syntaxError(line, nextIndex, "Expected identifier " + message + String(iline));
       end if;

       // read next line
       (line, endOfFile) :=Streams.readLine(fileName, iline);
    end while;

    if not found then
       Streams.error("Parameter \"" + name + "\" not found in file \"" + fileName + "\"");
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
result = <b>readRealParameter</b>(fileName, name);
</pre></blockquote>
<h4>Description</h4>
<p>
This function demonstrates how a function can be implemented
that reads the value of a parameter from file. The function
performs the following actions:
</p>
<ol>
<li> It opens file \"fileName\" and reads the lines of the file.</li>
<li> In every line, Modelica line comments (\"// ... end-of-line\")
     are skipped </li>
<li> If a line consists of \"name = expression\" and the \"name\"
     in this line is identical to the second argument \"name\"
     of the function call, the expression calculator Examples.expression
     is used to evaluate the expression after the \"=\" character.
     The expression can optionally be terminated with a \";\".</li>
<li> The result of the expression evaluation is returned as
     the value of the parameter \"name\". </li>
</ol>
<h4>Example</h4>
<p>
On file \"test.txt\" the following lines might be present:
</p>
<blockquote><pre>
// Motor data
J        = 2.3     // inertia
w_rel0   = 1.5*2;  // relative angular velocity
phi_rel0 = pi/3
</pre></blockquote>
<p>
The function returns the value \"3.0\" when called as:
</p>
<blockquote><pre>
readRealParameter(\"test.txt\", \"w_rel0\")
</pre></blockquote>
</html>"));
  end readRealParameter;

  model readRealParameterModel
    "Demonstrate usage of Examples.readRealParameter/.expression"
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Example;

    parameter String file = "Modelica/Utilities/data/Examples_readRealParameters.txt"
      "File on which data is present"
          annotation(Dialog(__Dymola_loadSelector(filter="Text files (*.txt)",
                        caption="Open text file to read parameters of the form \"name = value\"")));
    parameter SI.Inertia J =              readRealParameter(file, "J")
      "Inertia";
    parameter SI.Angle phi_rel0 =         readRealParameter(file, "phi_rel0")
      "Relative angle";
    parameter SI.AngularVelocity w_rel0 = readRealParameter(file, "w_rel0")
      "Relative angular velocity";

    annotation (Documentation(info="<html>
<p>
Model that shows the usage of Examples.readRealParameter and Examples.expression.
The model has 3 parameters and the values of these parameters are read
from a file.
</p>
</html>"));
  end readRealParameterModel;
  annotation (Documentation(info="<html>
<p>
This package contains quite involved examples that demonstrate how to
use the functions of package Modelica.Utilities. In particular
the following examples are present.
</p>
<ul>
<li> Function <a href=\"Modelica://Modelica.Utilities.Examples.calculator\">calculator</a>
     is an interpreter to evaluate
     expressions consisting of +,-,*,/,(),sin(), cos(), tan(), sqrt(), pi.
     For example: calculator(\"1.5*sin(pi/6)\"); <br>&nbsp;</li>
<li> Function <a href=\"Modelica://Modelica.Utilities.Examples.expression\">expression</a>
     is the basic function used in \"calculator\" to evaluate an expression.
     It is useful if the expression interpreter is used in a larger
     scan operation (such as readRealParameter below).<br>&nbsp;</li>
<li> Function <a href=\"Modelica://Modelica.Utilities.Examples.readRealParameter\">readRealParameter</a>
     reads the value of a parameter
     from file, given the file and the parameter name. The value
     on file is interpreted with the Examples.expression function
     and can therefore be an expression.<br>&nbsp;</li>
<li> Model <a href=\"Modelica://Modelica.Utilities.Examples.readRealParameterModel\">readRealParameterModel</a>
     is a test model to demonstrate the usage of \"readRealParameter\". The model
     contains 3 parameters that are read from file \"Modelica.Utilities/data/Examples_readRealParameters.txt\".
     </li>
</ul>
</html>"));
end Examples;
