package Streams "Read from files and write to files" 
  extends Modelica.Icons.Library;
  
  annotation (
  version="0.3",
  versionDate="2004-08-21",
  preferedView="info",
    Documentation(info="<HTML>
<h3><font color=\"#008000\">Library content</font></h3>
<p>
Package <b>Streams</b> contains functions to input and output strings
to a message window or on files. In this very preliminary version,
only two functions are provided (it is planned to add much more 
functions to this package). In the table below an example is 
given for every function definition.
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Function/type</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td><a href=\"Modelica:Modelica.Streams.error\">error</a>(str)</td>
      <td> Print error message \"str\" to message window and cancel all actions</td>
  </tr>
  <tr><td><a href=\"Modelica:Modelica.Streams.print\">print</a>(str)<br>
          <a href=\"Modelica:Modelica.Streams.print\">print</a>(str,newLines=3)</td>
      <td> Print string \"str\" to message window. The number of new line
           characters<br> is specified with the optional second argument
           (default is newLines=1)</td>
  </tr>
</table>
<p>
If Real, Integer or Boolean values shall be printed to the message
window or used in an error message, they have to be first converted
to strings with the built-in operator 
<a href=\"Modelica:ModelicaReference.Operators.string\">String</a>(...).
Example:
</p>
<pre>
  <b>if</b> x &lt; 0 <b>or</b> x &gt; 1 <b>then</b>
     Streams.error(\"x (= \" + String(x) + \") has to be in the range 0 .. 1\");
  <b>end if</b>;
</pre>
<p>
This has the same effect as (but with less information for the user):
</p>
<pre>
   <b>assert</b>(x &ge; 0 <b>and</b> x &le; 1, \"x has to be in the range 0 .. 1\");
</pre>

</HTML>
"));
  
  function error "Print error message and cancel all actions" 
    extends Modelica.Icons.Function;
    input String string "String to be printed to error message window";
    external "C" ModelicaError(string);
    annotation (  preferedView="info",
  Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Streams.<b>error</b>(str);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Print the string \"str\" as error message and
cancel all actions. Line breaks are characterized 
by \"\\n\" in the string.
</p>
<h3><font color=\"#008000\">Example</font></h3>
<blockquote><pre>
  Streams.error(\"x (= \" + String(x) + \")\\nhas to be in the range 0 .. 1\");
</pre></blockquote>
<h3><font color=\"#008000\">See also</font></h3>
<p>
<a href=\"Modelica:Modelica.Streams\">Streams</a>,
<a href=\"Modelica:Modelica.Streams.print\">Streams.print</a>,
<a href=\"Modelica:ModelicaReference.Operators.string\">String</a>
</p>
</html>"));
  end error;
  
  function print "Print string to message window with optional newlines" 
    extends Modelica.Icons.Function;
    input String string="" "String to be printed to message window";
    input Integer newLines(min=0)=1 "= number of new line characters";
  protected 
    Boolean dummy;
  algorithm 
    dummy :=Utilities.ModelicaMessage(string);
    for i in 1:newLines loop
       dummy :=Utilities.ModelicaMessage("\n");
    end for;
    annotation (  preferedView="info",
  Documentation(info="<HTML>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Streams.<b>print</b>(str);
Streams.<b>print</b>(str,2);
Streams.<b>print</b>(str,newLines=2);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Print string \"str\" to message window. The number of new line
characters included after the string is specified with the 
optional second argument
(default is newLines=1). Line breaks are characterized 
by \"\\n\" in the string.
</p>
<h3><font color=\"#008000\">Example</font></h3>
<blockquote><pre>
  Streams.print(\"x = \" + String(x));
  Streams.print(\"y = \" + String(y), newLines=3);
</pre></blockquote>
<p>
is the same as
</p>
<blockquote><pre>
  Streams.print(\"x = \" + String(x) + \"\\n\" +
                \"y = \" + String(y), 3);
</pre></blockquote>
<h3><font color=\"#008000\">See also</font></h3>
<p>
<a href=\"Modelica:Modelica.Streams\">Streams</a>,
<a href=\"Modelica:Modelica.Streams.error\">Streams.error</a>,
<a href=\"Modelica:ModelicaReference.Operators.string\">String</a>
</p>
</HTML>"));
  end print;
  
/*  
protected 
  function ModelicaMessage "Print string to message window" 
    extends Modelica.Icons.Function;
    input String string="" "String to be printed to message window";
    external "C" ModelicaMessage(string);
  end ModelicaMessage;
*/
end Streams;
