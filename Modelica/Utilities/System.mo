within Modelica.Utilities;
package System "Interaction with environment"
  extends Modelica.Icons.FunctionsPackage;

function getWorkDirectory "Get full path name of work directory"
  extends Modelica.Icons.Function;
  output String directory "Full path name of work directory";
// POSIX function "getcwd"
  external "C" directory = ModelicaInternal_getcwd(0) annotation(Library="ModelicaExternalC");
    annotation (__ModelicaAssociation_Impure=true,
Documentation(info="<html>

</html>"));
end getWorkDirectory;

function setWorkDirectory "Set work directory"
  extends Modelica.Icons.Function;
  input String directory "New work directory";
// POSIX function "chdir"
external "C" ModelicaInternal_chdir(directory) annotation(Library="ModelicaExternalC");
    annotation (__ModelicaAssociation_Impure=true,
Documentation(info="<html>

</html>"));
end setWorkDirectory;

function getEnvironmentVariable "Get content of environment variable"
  extends Modelica.Icons.Function;
  input String name "Name of environment variable";
  input Boolean convertToSlash =  false
      "True, if native directory separators in environment variable shall be changed to '/'";
  output String content
      "Content of environment variable (empty, if not existent)";
  output Boolean exist
      "= true, if environment variable exists; = false, if it does not exist";
  external "C" ModelicaInternal_getenv(name, convertToSlash, content, exist) annotation(Library="ModelicaExternalC");
    annotation (__ModelicaAssociation_Impure=true,
Documentation(info="<html>

</html>"));
end getEnvironmentVariable;

function setEnvironmentVariable "Set content of local environment variable"
  extends Modelica.Icons.Function;
  input String name "Name of environment variable";
  input String content "Value of the environment variable";
  input Boolean convertFromSlash =  false
      "True, if '/' in environment variable shall be changed to native directory separators";
external "C" ModelicaInternal_setenv(name, content, convertFromSlash) annotation(Library="ModelicaExternalC");
    annotation (__ModelicaAssociation_Impure=true,
Documentation(info="<html>

</html>"));
end setEnvironmentVariable;

  function getTime "Retrieve the local time (in the local time zone)"
    extends Modelica.Icons.Function;
    output Integer ms "Millisecond";
    output Integer sec "Second";
    output Integer min "Minute";
    output Integer hour "Hour";
    output Integer day "Day";
    output Integer mon "Month";
    output Integer year "Year";
    external "C" ModelicaInternal_getTime(ms,sec,min,hour,day,mon,year)
      annotation(Library="ModelicaExternalC");
    annotation (__ModelicaAssociation_Impure=true,
Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
(ms, sec, min, hour, day, mon, year) = System.<strong>getTime</strong>();
</pre></blockquote>
<h4>Description</h4>
<p>
Returns the local time at the time instant this function was called.
All returned values are of type Integer and have the following meaning:
</p>

<blockquote>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Argument</th>
    <th>Range</th>
    <th>Description</th></tr>

<tr><td>ms</td> <td>0 .. 999</td>
    <td>Milli-seconds after seconds</td></tr>

<tr><td>sec</td> <td>0 .. 59</td>
    <td>Seconds after minute</td></tr>

<tr><td>min</td> <td>0 .. 59</td>
    <td>Minutes after hour</td></tr>

<tr><td>hour</td> <td>0 .. 23</td>
    <td>Hours after midnight</td></tr>

<tr><td>day</td> <td>1 .. 31</td>
    <td>Day of month</td></tr>

<tr><td>mon</td> <td>1 .. 12</td>
    <td>Current month</td></tr>

<tr><td>year</td> <td>&ge; 2015</td>
    <td>Current year</td></tr>
</table>
</blockquote>

<h4>Example</h4>
<blockquote><pre>
(ms, sec, min, hour, mon, year) = getTime()   // = (281, 30, 13, 10, 15, 2, 2015)
                                              // Feb. 15, 2015 at 10:13 after 30.281 s
</pre></blockquote>
<h4>Note</h4>
<p>This function is impure!</p>
</html>",   revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end getTime;

  function getPid "Retrieve the current process id"
    extends Modelica.Icons.Function;
    output Integer pid "Process ID";
    external "C" pid=  ModelicaInternal_getpid() annotation(Library="ModelicaExternalC");
    annotation (__ModelicaAssociation_Impure=true,
Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
pid = System.<strong>getPid</strong>();
</pre></blockquote>
<h4>Description</h4>
<p>
Returns the pid (process identification) of the process in which this function
is called. This is an impure function and the returned value depends on the
operating system.
</p>

<h4>Example</h4>
<blockquote><pre>
getPid()   // = 3044
</pre></blockquote>
<h4>Note</h4>
<p>This function is impure!</p>
</html>",   revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end getPid;

function command "Execute command in default shell"
  extends Modelica.Icons.Function;
  input String string "String to be passed to shell";
  output Integer result "Return value from command (depends on environment)";
  external "C" result = system(string) annotation(Include="#include <stdlib.h>", Library="ModelicaExternalC");
    annotation (__ModelicaAssociation_Impure=true,
Documentation(info="<html>

</html>"));
end command;

function exit "Terminate execution of Modelica environment"
  extends ModelicaServices.System.exit;
    annotation (__ModelicaAssociation_Impure=true,
Documentation(info="<html>

</html>"));
end exit;
    annotation (
Documentation(info="<html>
<p>
This package contains functions to interact with the environment.
</p>
</html>"));
end System;
