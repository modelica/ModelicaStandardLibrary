within ;
package ModelicaTest "Library to test components of library Modelica "
  annotation (version="1.1", versionDate="2007-10-19", uses(Modelica(version=
          "3.1")),
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
Copyright &copy; 1998-2007, Modelica Association.
</p>
<p>
<i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</html>"),
  conversion(from(version="1.0", script="ConvertFromModelicaTest_1.0.mos")));


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
  result := ModelicaTest.Math.Polynomials(logFile);
  result := ModelicaTest.Math.Matrices(logFile);
  result := ModelicaTest.Utilities.testAll(logFile);
  ok := true;
end testAllFunctions;
end ModelicaTest;
