within Modelica.Utilities;
package Streams "Read from files and write to files"
  extends Modelica.Icons.Package;

  function print "Print string to terminal or file"
    extends Modelica.Icons.Function;
    input String string="" "String to be printed";
    input String fileName=""
      "File where to print (empty string is the terminal)"
                 annotation(Dialog(__Dymola_saveSelector(filter="Text files (*.txt)",
                        caption="Text file to store the output of print(..)")));
  external "C" ModelicaInternal_print(string, fileName);
    annotation (Library="ModelicaExternalC",
  Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Streams.<b>print</b>(string);
Streams.<b>print</b>(string,fileName);
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>print</b>(..) opens automatically the given file, if
it is not yet open. If the file does not exist, it is created.
If the file does exist, the given string is appended to the file.
If this is not desired, call \"Files.remove(fileName)\" before calling print
(\"remove(..)\" is silent, if the file does not exist).
The Modelica environment may close the file whenever appropriate.
This can be enforced by calling <b>Streams.close</b>(fileName).
After every call of \"print(..)\" a \"new line\" is printed automatically.
</p>
<h4>Example</h4>
<blockquote><pre>
  Streams.print(\"x = \" + String(x));
  Streams.print(\"y = \" + String(y));
  Streams.print(\"x = \" + String(y), \"mytestfile.txt\");
</pre></blockquote>
<p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams\">Streams</a>,
<a href=\"modelica://Modelica.Utilities.Streams.error\">Streams.error</a>,
<a href=\"modelica://ModelicaReference.Operators.string\">String</a>
</p>
</HTML>"));
  end print;

  function readFile
    "Read content of a file and return it in a vector of strings"
    extends Modelica.Icons.Function;
    input String fileName "Name of the file that shall be read"
                 annotation(Dialog(__Dymola_loadSelector(filter="Text files (*.txt)",
                        caption="Open text file for reading")));
    output String stringVector[countLines(fileName)] "Content of file";

  algorithm
    for i in  1:size(stringVector, 1) loop
      stringVector[i] := readLine(fileName, i);
    end for;
    Streams.close(fileName);
    annotation ( Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
stringVector = Streams.<b>readFile</b>(fileName)
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>readFile</b>(..) opens the given file, reads the complete
content, closes the file and returns the content as a vector of strings. Lines are separated by LF or CR-LF; the returned strings do not contain the line separators.
</p>
</html>"));
  end readFile;

  function readLine
    "Reads a line of text from a file and returns it in a string"
    extends Modelica.Icons.Function;
    input String fileName "Name of the file that shall be read"
                        annotation(Dialog(__Dymola_loadSelector(filter="Text files (*.txt)",
                        caption="Open text file for reading")));
    input Integer lineNumber(min=1) "Number of line to read";
    output String string "Line of text";
    output Boolean endOfFile
      "If true, end-of-file was reached when trying to read line";
   external "C" string=  ModelicaInternal_readLine(fileName,lineNumber,endOfFile);
    annotation (Library="ModelicaExternalC",Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
(string, endOfFile) = Streams.<b>readLine</b>(fileName, lineNumber)
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>readLine</b>(..) opens the given file, reads enough of the
content to get the requested line, and returns the line as a string.
Lines are separated by LF or CR-LF; the returned string does not
contain the line separator. The file might remain open after
the call.
</p>
<p>
If lineNumber > countLines(fileName), an empty string is returned
and endOfFile=true. Otherwise endOfFile=false.
</p>
</html>"));
  end readLine;

  function countLines "Returns the number of lines in a file"
    extends Modelica.Icons.Function;
    input String fileName "Name of the file that shall be read"
                       annotation(Dialog(__Dymola_loadSelector(filter="Text files (*.txt)",
                        caption="Open text file for coutning lines")));

    output Integer numberOfLines "Number of lines in file";
  external "C" numberOfLines=  ModelicaInternal_countLines(fileName);
    annotation (Library="ModelicaExternalC",Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
numberOfLines = Streams.<b>countLines</b>(fileName)
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>countLines</b>(..) opens the given file, reads the complete
content, closes the file and returns the number of lines. Lines are
separated by LF or CR-LF.
</p>
</html>"));
  end countLines;

  function error "Print error message and cancel all actions"
    extends Modelica.Icons.Function;
    input String string "String to be printed to error message window";
    external "C" ModelicaError(string);
    annotation (Library="ModelicaExternalC",
  Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Streams.<b>error</b>(string);
</pre></blockquote>
<h4>Description</h4>
<p>
Print the string \"string\" as error message and
cancel all actions. Line breaks are characterized
by \"\\n\" in the string.
</p>
<h4>Example</h4>
<blockquote><pre>
  Streams.error(\"x (= \" + String(x) + \")\\nhas to be in the range 0 .. 1\");
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams\">Streams</a>,
<a href=\"modelica://Modelica.Utilities.Streams.print\">Streams.print</a>,
<a href=\"modelica://ModelicaReference.Operators.string\">String</a>
</p>
</html>"));
  end error;

  function close "Close file"
    extends Modelica.Icons.Function;
    input String fileName "Name of the file that shall be closed"
                 annotation(Dialog(__Dymola_loadSelector(filter="Text files (*.txt)",
                        caption="Close text file")));
    external "C" ModelicaStreams_closeFile(fileName);
    annotation (Library="ModelicaExternalC",Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Streams.<b>close</b>(fileName)
</pre></blockquote>
<h4>Description</h4>
<p>
Close file if it is open. Ignore call if
file is already closed or does not exist.
</p>
</html>"));
  end close;
  annotation (
    Documentation(info="<HTML>
<h4>Library content</h4>
<p>
Package <b>Streams</b> contains functions to input and output strings
to a message window or on files. Note that a string is interpreted
and displayed as html text (e.g., with print(..) or error(..))
if it is enclosed with the Modelica html quotation, e.g.,
</p>
<center>
string = \"&lt;html&gt; first line &lt;br&gt; second line &lt;/html&gt;\".
</center>
<p>
It is a quality of implementation, whether (a) all tags of html are supported
or only a subset, (b) how html tags are interpreted if the output device
does not allow to display formatted text.
</p>
<p>
In the table below an example call to every function is given:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Function/type</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Streams.print\">print</a>(string)<br>
          <a href=\"modelica://Modelica.Utilities.Streams.print\">print</a>(string,fileName)</td>
      <td valign=\"top\"> Print string \"string\" or vector of strings to message window or on
           file \"fileName\".</td>
  </tr>
  <tr><td valign=\"top\">stringVector =
         <a href=\"modelica://Modelica.Utilities.Streams.readFile\">readFile</a>(fileName)</td>
      <td valign=\"top\"> Read complete text file and return it as a vector of strings.</td>
  </tr>
  <tr><td valign=\"top\">(string, endOfFile) =
         <a href=\"modelica://Modelica.Utilities.Streams.readLine\">readLine</a>(fileName, lineNumber)</td>
      <td valign=\"top\">Returns from the file the content of line lineNumber.</td>
  </tr>
  <tr><td valign=\"top\">lines =
         <a href=\"modelica://Modelica.Utilities.Streams.countLines\">countLines</a>(fileName)</td>
      <td valign=\"top\">Returns the number of lines in a file.</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Streams.error\">error</a>(string)</td>
      <td valign=\"top\"> Print error message \"string\" to message window
           and cancel all actions</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Streams.close\">close</a>(fileName)</td>
      <td valign=\"top\"> Close file if it is still open. Ignore call if
           file is already closed or does not exist. </td>
  </tr>
</table>
<p>
Use functions <b>scanXXX</b> from package
<a href=\"modelica://Modelica.Utilities.Strings\">Strings</a>
to parse a string.
</p>
<p>
If Real, Integer or Boolean values shall be printed
or used in an error message, they have to be first converted
to strings with the builtin operator
<a href=\"modelica://ModelicaReference.Operators.string\">String</a>(...).
Example:
</p>
<pre>
  <b>if</b> x &lt; 0 <b>or</b> x &gt; 1 <b>then</b>
     Streams.error(\"x (= \" + String(x) + \") has to be in the range 0 .. 1\");
  <b>end if</b>;
</pre>
</HTML>
"));
end Streams;
