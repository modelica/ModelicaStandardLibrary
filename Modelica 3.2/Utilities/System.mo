within Modelica.Utilities;
package System "Interaction with environment"
  extends Modelica.Icons.Package;

function getWorkDirectory "Get full path name of work directory"
  extends Modelica.Icons.Function;
  output String directory "Full path name of work directory";
// POSIX function "getcwd"
  external "C" directory = ModelicaInternal_getcwd(0);
    annotation (Library="ModelicaExternalC",Documentation(info="<html>

</html>"));
end getWorkDirectory;

function setWorkDirectory "Set work directory"
  extends Modelica.Icons.Function;
  input String directory "New work directory";
// POSIX function "chdir"
external "C" ModelicaInternal_chdir(directory);
    annotation (Library="ModelicaExternalC",Documentation(info="<html>

</html>"));
end setWorkDirectory;

function getEnvironmentVariable "Get content of environment variable"
  extends Modelica.Icons.Function;
  input String name "Name of environment variable";
  input Boolean convertToSlash =  false
      "True, if native directory separators in 'result' shall be changed to '/'";
  output String content
      "Content of environment variable (empty, if not existent)";
  output Boolean exist
      "= true, if environment variable exists; = false, if it does not exist";
  external "C" ModelicaInternal_getenv(name, convertToSlash, content, exist);
    annotation (Library="ModelicaExternalC",Documentation(info="<html>

</html>"));
end getEnvironmentVariable;

function setEnvironmentVariable "Set content of local environment variable"
  extends Modelica.Icons.Function;
  input String name "Name of environment variable";
  input String content "Value of the environment variable";
  input Boolean convertFromSlash =  false
      "True, if '/' in content shall be changed to the native directory separator";
external "C" ModelicaInternal_setenv(name, content, convertFromSlash);
    annotation (Library="ModelicaExternalC",Documentation(info="<html>

</html>"));
end setEnvironmentVariable;

function command "Execute command in default shell"
  extends Modelica.Icons.Function;
  input String string "String to be passed to shell";
  output Integer result "Return value from command (depends on environment)";
  external "C" result = system(string);
    annotation (Library="ModelicaExternalC",Documentation(info="<html>

</html>"));
end command;

function exit "Terminate execution of Modelica environment"
  extends Modelica.Icons.Function;
  input Integer status=0
      "Result to be returned by environment (0 means success)";
  external "C" ModelicaInternal_exit(status);

  annotation(Library="ModelicaExternalC");
end exit;
    annotation (
Documentation(info="
<HTML>
<p>
This package contains functions to interact with the environment.
</p>
</HTML>
"));
end System;
