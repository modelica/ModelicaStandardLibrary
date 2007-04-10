package UtilitiesForTesting 
  "Utility functions to simulate several models and to call several functions that are used for testing" 
function test_that_models_simulate 
    "Simulates a set of models and reports whether all simulate or not (useful to test the examples of a library)" 
    import Modelica.Utilities.Streams.*;
    import Modelica.Utilities.Files.*;
    import Modelica.Utilities.System.*;
  extends Modelica.Icons.Function;
  input String models[:] 
      "Full Modelica names of the models that shall be simulated";
    
  protected 
  Integer nTests = size(models,1);
  Boolean passed[nTests] = fill(false,nTests);
  Integer notPassed=0;
  Integer i;
  String workDirectory;
algorithm 
// Go one level up, if directory is a package directory
   workDirectory :=getWorkDirectory();
   if exist(workDirectory + "/package.mo") then
      setWorkDirectory("..");
      workDirectory :=getWorkDirectory();
      print("... work directory changed to: " + workDirectory);
   end if;
    
for i in 1:nTests loop
   print("... test " + models[i]);
   passed[i] := simulateModel(models[i]);
      
   if not passed[i] then
      notPassed := notPassed + 1;
   end if;
end for;
    
if notPassed == 0 then
  print("\n... All models simulated without error.");
else
  print("\n... The following models did not simulate:");
  for i in 1:nTests loop
     if not passed[i] then
         print("   " + models[i]);
     end if;
  end for;
end if;
    
end test_that_models_simulate;
  extends Modelica.Icons.Library;
function test_that_functions_operate 
    "Calls a set of functions and reports whether all return true (useful to test the functional examples of a library)" 
    import Modelica.Utilities.Streams.*;
    import Modelica.Utilities.Files.*;
    import Modelica.Utilities.System.*;
  extends Modelica.Icons.Function;
  input String functions[:] 
      "Full Modelica names of the functions that shall be called";
  output Boolean ok;
  protected 
  Integer nTests = size(functions,1);
  Boolean passed[nTests] = fill(false,nTests);
  Integer notPassed=0;
  String workDirectory;
  String scriptName = "TestFunctionsScript.mos";
  Integer i;
algorithm 
// Go one level up, if directory is a package directory
   workDirectory :=getWorkDirectory();
   if exist(workDirectory + "/package.mo") then
      setWorkDirectory("..");
      workDirectory :=getWorkDirectory();
      print("... work directory changed to: " + workDirectory);
   end if;
    
// Generate script
   removeFile(scriptName);
   print("import Modelica.Utilities.Streams.print;", scriptName);
   print("functions = fill(\"\"," + String(nTests) + ");", scriptName);
   print("passed = fill(false," + String(nTests) + ");", scriptName);
   print("notPassed = 0;", scriptName);
   for i in 1:nTests loop
      print("print(\"... test " + functions[i] + "\");", scriptName);
      print("functions[" + String(i) + "] = \"" + functions[i] + "\";", scriptName);
      print("passed[" + String(i) + "] = " + functions[i] + "();", scriptName);
      print("if not passed[" + String(i) + "] then\n" +
            "   notPassed := notPassed + 1;\n" +
            "end if;", scriptName);
   end for;
   print("if notPassed == 0 then\n" +
         "   print(\" \");" +
         "   print(\"... All functions returned without error.\");\n" +
         "else\n" +
         "   print(\"... The following functions returned with an error:\");\n" +
         "   for i in 1:" + String(nTests) + " loop\n" +
         "      if not passed[i] then\n" +
         "         print(\"   \" + functions[i]);\n" +
         "      end if;\n" +
         "   end for;\n" +
         "end if;", scriptName);
    
// Execute script
   ok :=RunScript(scriptName,silent=true);
    
    annotation (Documentation(info="<html>
<p>
This function calls all the functions that are provided
as input arguments and calls them one after each other.>
It is assumed, that all functions can be called without input arguments
and that the only output argument returns <b>true</b> for a succesful
evaluation and <b>false</b> for a non successful evaluation.
</p>
</html>"));
end test_that_functions_operate;
  
end UtilitiesForTesting;
