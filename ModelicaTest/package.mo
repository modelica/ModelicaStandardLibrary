within ;
package ModelicaTest "Library to test components of package Modelica - Version 4.0.0"
extends Modelica.Icons.Package;

  import Modelica.Units.SI;

function testAllFunctions "Runs all test cases for functions"
  extends Modelica.Icons.Function;
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

  print("--- Test functions of Modelica library");
  print("--- Test functions of Modelica library", logFile);
  Modelica.Math.Nonlinear.Examples.quadratureLobatto1();
  Modelica.Math.Nonlinear.Examples.quadratureLobatto2();
  Modelica.Math.Nonlinear.Examples.solveNonlinearEquations1();
  Modelica.Math.Nonlinear.Examples.solveNonlinearEquations2();

  print("--- Test functions of ModelicaTest library");
  print("--- Test functions of ModelicaTest library", logFile);
  result := ModelicaTest.Math.ScalarFunctions(logFile);
  result := ModelicaTest.Math.BooleanFunctions(logFile);
  result := ModelicaTest.Math.Polynomials(logFile);
  result := ModelicaTest.Math.Matrices(logFile);
  result := ModelicaTest.Math.Matrices2();
  result := ModelicaTest.Math.Vectors();
  result := ModelicaTest.Math.colorMapToSvg();

  result := ModelicaTest.Math.Random.randomNumbers();
  result := ModelicaTest.Math.Random.special();
  result := ModelicaTest.Math.Random.distributions();
  result := ModelicaTest.Math.Random.truncatedDistributions();

  result := ModelicaTest.Utilities.testAll(logFile);
  result := ModelicaTest.ComplexMath.ComplexFunctions(logFile);
  result := ModelicaTest.ComplexMath.ComplexOperations();

  ok := true;
end testAllFunctions;

  annotation (preferredView="info",
       version="4.0.0",
       versionDate="2020-06-04",
       dateModified = "2020-06-04 11:00:00Z",
       revisionId="$Format:%h %ci$",
       uses(Modelica(version="4.0.0")),
    Documentation(info="<html>
<p>
This library provides models and functions to test components of
<strong>package Modelica</strong> (the Modelica Standard Library).
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
     <blockquote><pre>
         <strong>annotation</strong>(experiment(StopTime=1.1));
     </pre></blockquote>
     This gives the tool vendors the possibility to automatically identify
     the models that shall be simulated and, e.g., that shall be used in an automatic
     regression test.</li>
</ul>

<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>

<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>"),
    Icon(graphics={Polygon(
          points={{-70,0},{-44,0},{-24,-34},{50,56},{78,56},{-24,-74},{-70,0}},
          lineColor={75,138,73},
          fillColor={75,138,73},
          fillPattern=FillPattern.Solid)}));
end ModelicaTest;
