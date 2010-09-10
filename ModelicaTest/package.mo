within ;
package ModelicaTest "Library to test components of library Modelica "
extends Modelica.Icons.Package;

function testAllFunctions "Runs all test cases for functions"
  import Modelica.Utilities.Streams.print;
  input String logFile = "ModelicaTestLog.txt"
    "Filename where the log of all functions is stored";
  output Boolean ok;
protected
  Boolean result;
  String file;
algorithm
  file :=Modelica.Utilities.Files.fullPathName(logFile);
  print("... testAllFunctions(..) is logged in " + file);

  if file <> "" then
     Modelica.Utilities.Files.removeFile(file);
  end if;

  print("--- Test functions of Modelica library", logFile);
  Modelica.Math.Nonlinear.Examples.quadratureLobatto1();
  Modelica.Math.Nonlinear.Examples.quadratureLobatto2();
  Modelica.Math.Nonlinear.Examples.solveNonlinearEquations1();
  Modelica.Math.Nonlinear.Examples.solveNonlinearEquations2();

  print("--- Test functions of ModelicaTest library", logFile);
  result := ModelicaTest.Math.ScalarFunctions(logFile);
  result := ModelicaTest.Math.BooleanFunctions(logFile);
  result := ModelicaTest.Math.Polynomials(logFile);
  result := ModelicaTest.Math.Matrices(logFile);
  result := ModelicaTest.Math.Matrices2();
  result := ModelicaTest.Math.Vectors();
  result := ModelicaTest.Utilities.testAll(logFile);
  result := ModelicaTest.ComplexMath.ComplexFunctions(logFile);
  result := ModelicaTest.ComplexMath.ComplexOperations();

  ok := true;
end testAllFunctions;

  annotation (version="1.1",
       versionDate="2007-10-19",
       versionBuild=2,
       dateModified = "2010-04-22 00:00:00Z",
       uses(Modelica(version="3.2")),
    Documentation(info="<html>
<p>
This library provides models and functions to test components of
<b>package Modelica</b> (the Modelica Standard Library).
</p>

<p>
Further development of this library should be performed in the following
way:
</p>

<ul>
<li> Functions that are added to this library to test functions of the
     Modelica Standard Library, should be called in \"ModelicaTest.testAllFunctions()\".
     The idea is that all test functions are called, when calling
     \"testAllFunctions()\".</li>

<li> Models that are added to this library should have the annotation
     (with an appropriate StopTime):
     <pre>
         <b>annotation</b>(experiment(StopTime=1.1)); </pre>
     This gives the tool vendors the possibility to automatically identify
     the models that shall be simulated and, e.g., that shall be used in an automatic
     regression test.</li>
</ul>

<p>
Copyright &copy; 1998-2010, Modelica Association.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>"),
  conversion(from(version="1.0", script="ConvertFromModelicaTest_1.0.mos")));
end ModelicaTest;
