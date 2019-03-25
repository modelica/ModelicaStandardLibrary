within Modelica.Utilities;
package Examples
  "Examples to demonstrate the usage of package Modelica.Utilities"
  extends Modelica.Icons.ExamplesPackage;

  function calculator
    "Interpreter to evaluate simple expressions consisting of +, -, *, /, (), sin(), cos(), tan(), sqrt(), asin(), acos(), atan(), exp(), log(), pi"
    import Modelica.Utilities.Strings;
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
result = <strong>calculator</strong>(expression);
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
   asin(expression)
   acos(expression)
   atan(expression)
   exp(expression)
   log(expression)
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
    "Expression interpreter that returns with the position after the expression (expression may consist of +, -, *, /, (), sin(), cos(), tan(), sqrt(), asin(), acos(), atan(), exp(), log(), pi)"
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
         elseif functionName == "asin" then
           result := Math.asin(result);
         elseif functionName == "acos" then
           result := Math.acos(result);
         elseif functionName == "atan" then
           result := Math.atan(result);
         elseif functionName == "exp" then
           result := Math.exp(result);
         elseif functionName == "log" then
           if result <= 0.0 then
             Strings.syntaxError(string, startIndex, "Argument of call \"log(" + String(result) + ")\" is not positive.\n" + message);
           end if;
           result := Math.log(result);
         else
           Strings.syntaxError(string, startIndex, "Function \"" + functionName + "\" is unknown (not supported)\n" + message);
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
             result = <strong>expression</strong>(string);
(result, nextIndex) = <strong>expression</strong>(string, startIndex=1, message=\"\");
</pre></blockquote>
<h4>Description</h4>
<p>
This function is nearly the same as Examples.<strong>calculator</strong>.
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
   asin(expression)
   acos(expression)
   atan(expression)
   exp(expression)
   log(expression)
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
the error occurred.
</p>
<p>
This function parses the following grammar
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
              | asin
              | acos
              | atan
              | exp
              | log
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
    extends Modelica.Icons.Function;
    input String fileName "Name of file" annotation(Dialog(
                           loadSelector(filter="Text files (*.txt)",
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
    annotation (Documentation(info=
                   "<html>
<h4>Syntax</h4>
<blockquote><pre>
result = <strong>readRealParameter</strong>(fileName, name);
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
     are skipped</li>
<li> If a line consists of \"name = expression\" and the \"name\"
     in this line is identical to the second argument \"name\"
     of the function call, the expression calculator Examples.expression
     is used to evaluate the expression after the \"=\" character.
     The expression can optionally be terminated with a \";\".</li>
<li> The result of the expression evaluation is returned as
     the value of the parameter \"name\".</li>
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

    parameter String file = Modelica.Utilities.Files.loadResource(
    "modelica://Modelica/Resources/Data/Utilities/Examples_readRealParameters.txt")
      "File on which data is present"
          annotation(Dialog(loadSelector(filter="Text files (*.txt)",
                        caption="Open text file to read parameters of the form \"name = value\"")));
    parameter SI.Inertia J =              readRealParameter(file, "J")
      "Inertia";
    parameter SI.Angle phi_rel0 =         readRealParameter(file, "phi_rel0")
      "Relative angle";
    parameter SI.AngularVelocity w_rel0 = readRealParameter(file, "w_rel0")
      "Relative angular velocity";
  equation
    when terminal() then
      Streams.close(file);
    end when;

    annotation (preferredView="text", Documentation(info="<html>
<p>
Model that shows the usage of Examples.readRealParameter and Examples.expression.
The model has 3 parameters and the values of these parameters are read
from a file.
</p>
</html>"), experiment(StopTime=1.01));
  end readRealParameterModel;

  model WriteRealMatrixToFile
    "Demonstrate usage of function Streams.writeRealMatrix"
    extends Modelica.Icons.Example;
    parameter Real A[3,2] = [11, 12;
                             21, 22;
                             31, 32] "Matrix stored in different formats on files";
    output Boolean success1 "= true if writing to Test_RealMatrix_v4.mat is successful";
    output Boolean success2 "= true if appending to Test_RealMatrix_v4.mat is successful";
    output Boolean success3 "= true if writing to Test_RealMatrix_v6.mat is successful";
    output Boolean success4 "= true if writing to Test_RealMatrix_v7.mat is successful";
  algorithm
    when initial() then
      success1 := Modelica.Utilities.Streams.writeRealMatrix("Test_RealMatrix_v4.mat", "Matrix_A", A);
      success2 := Modelica.Utilities.Streams.writeRealMatrix("Test_RealMatrix_v4.mat", "Matrix_B", A, append=true, format="4");
      success3 := Modelica.Utilities.Streams.writeRealMatrix("Test_RealMatrix_v6.mat", "Matrix_A", A, format="6");
      success4 := Modelica.Utilities.Streams.writeRealMatrix("Test_RealMatrix_v7.mat", "Matrix_A", A, format="7");
    end when;

    annotation (preferredView="text", experiment(StopTime=0.1), Documentation(info="<html>
<p>
Example model that shows how to write a Real matrix in MATLAB MAT format on file
using function <a href=\"modelica://Modelica.Utilities.Streams.writeRealMatrix\">writeRealMatrix</a>.
</p>
</html>"));
  end WriteRealMatrixToFile;

  model ReadRealMatrixFromFile
    "Demonstrate usage of function Streams.readRealMatrix"
    import Modelica.Utilities.Streams.print;
    extends Modelica.Icons.Example;
    parameter String file = Modelica.Utilities.Files.loadResource("modelica://Modelica/Resources/Data/Utilities/Test_RealMatrix_v4.mat") "File name of matrix"
      annotation(Dialog(loadSelector(filter="MATLAB MAT files (*.mat)", caption="Open MATLAB MAT file")));
    parameter String matrixName = "Matrix_A" "Matrix name in file";
    final parameter Integer dim[2] = Modelica.Utilities.Streams.readMatrixSize(file,matrixName) "Dimension of matrix";
    final parameter Real A[:,:] = Modelica.Utilities.Streams.readRealMatrix(file,matrixName,dim1[1],dim1[2]) "Matrix data";

    final parameter String file1 = Modelica.Utilities.Files.loadResource("modelica://Modelica/Resources/Data/Utilities/Test_RealMatrix_v4.mat") "File name of check matrix 1";
    final parameter String file2 = Modelica.Utilities.Files.loadResource("modelica://Modelica/Resources/Data/Utilities/Test_RealMatrix_v6.mat") "File name of check matrix 2";
    final parameter String file3 = Modelica.Utilities.Files.loadResource("modelica://Modelica/Resources/Data/Utilities/Test_RealMatrix_v7.mat") "File name of check matrix 3";
    final parameter String matrixName1 = "Matrix_A" "Names of check matrices";
    final parameter Integer dim1[2] = Modelica.Utilities.Streams.readMatrixSize(file1,matrixName1) "Dimension of check matrix 1";
    final parameter Integer dim2[2] = Modelica.Utilities.Streams.readMatrixSize(file2,matrixName1) "Dimension of check matrix 2";
    final parameter Integer dim3[2] = Modelica.Utilities.Streams.readMatrixSize(file3,matrixName1) "Dimension of check matrix 3";
    final parameter Real A1[:,:] = Modelica.Utilities.Streams.readRealMatrix(file1,matrixName1,dim1[1],dim1[2]) "Data of check matrix 1";
    final parameter Real A2[:,:] = Modelica.Utilities.Streams.readRealMatrix(file2,matrixName1,dim2[1],dim2[2]) "Data of check matrix 2";
    final parameter Real A3[:,:] = Modelica.Utilities.Streams.readRealMatrix(file3,matrixName1,dim3[1],dim3[2]) "Data of check matrix 3";
    Real x(start=1, fixed=true) "Dummy state";
  protected
    constant Real eps = 10* Modelica.Constants.eps;
  equation
    assert(abs(A1[1,1] - 11) <= eps, "Resources/Data/Utilities/Test_RealMatrix_v4.mat not correctly loaded");
    assert(abs(A2[1,1] - 11) <= eps, "Resources/Data/Utilities/Test_RealMatrix_v6.mat not correctly loaded");
    assert(abs(A3[1,1] - 11) <= eps, "Resources/Data/Utilities/Test_RealMatrix_v7.mat not correctly loaded");

    der(x) = -A[1,1]*x;
  algorithm
    when initial() then
       print("... Matrix " + matrixName + "[" + String(size(A,1)) + "," + String(size(A,2)) + "] read from file " + file);
       print("...    " + matrixName + "[1,1] = " + String(A[1,1]));
    end when;

    annotation(preferredView="text", experiment(StopTime=0.1), Documentation(info="<html>
<p>
Example model that shows how to read a Real matrix in MATLAB MAT format from file
using functions
<a href=\"modelica://Modelica.Utilities.Streams.readMatrixSize\">readMatrixSize</a> and
<a href=\"modelica://Modelica.Utilities.Streams.readRealMatrix\">readRealMatrix</a>.
</p>

<p>
Additionally, specific matrices from the supported file formats are loaded and it is checked
whether the loaded matrices have the expected values.
</p>
</html>"));
  end ReadRealMatrixFromFile;
  annotation (Documentation(info="<html>
<p>
This package contains quite involved examples that demonstrate how to
use the functions of package Modelica.Utilities. In particular
the following examples are present.
</p>
<ul>
<li> Function <a href=\"modelica://Modelica.Utilities.Examples.calculator\">calculator</a>
     is an interpreter to evaluate
     expressions consisting of +,-,*,/,(),sin(), cos(), tan(), sqrt(), pi.
     For example: calculator(\"1.5*sin(pi/6)\");<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Examples.expression\">expression</a>
     is the basic function used in \"calculator\" to evaluate an expression.
     It is useful if the expression interpreter is used in a larger
     scan operation (such as readRealParameter below).<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Examples.readRealParameter\">readRealParameter</a>
     reads the value of a parameter
     from file, given the file and the parameter name. The value
     on file is interpreted with the Examples.expression function
     and can therefore be an expression.<br>&nbsp;</li>
<li> Model <a href=\"modelica://Modelica.Utilities.Examples.readRealParameterModel\">readRealParameterModel</a>
     is a test model to demonstrate the usage of \"readRealParameter\". The model
     contains 3 parameters that are read from file <a href=\"modelica://Modelica/Resources/Data/Utilities/Examples_readRealParameters.txt\">Examples_readRealParameters.txt</a>.<br>&nbsp;
     </li>
<li> Model <a href=\"modelica://Modelica.Utilities.Examples.WriteRealMatrixToFile\">WriteRealMatrixToFile</a>
     demonstrates the usage of function \"Streams.writeReaMatrix\" to store a matrix in various MATLAB MAT formats on file.<br>&nbsp;
     </li>
<li> Model <a href=\"modelica://Modelica.Utilities.Examples.ReadRealMatrixFromFile\">ReadRealMatrixFromFile</a>
     demonstrates the usage of functions \"Streams.readMatrixSize\" and \"Streams.readRealMatrix\"
     to read a matrix in various MATLAB MAT formats from file.
     </li>
</ul>
</html>"));
end Examples;
