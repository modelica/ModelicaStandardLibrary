within Modelica.Utilities;
package Streams "Read from files and write to files"
  extends Modelica.Icons.FunctionsPackage;

  function print "Print string to terminal or file"
    extends Modelica.Icons.Function;
    input String string="" "String to be printed";
    input String fileName=""
      "File where to print (empty string is the terminal)"
                 annotation(Dialog(saveSelector(filter="Text files (*.txt)",
                        caption="Text file to store the output of print(..)")));
  external "C" ModelicaInternal_print(string, fileName) annotation(Library="ModelicaExternalC");

    annotation (__ModelicaAssociation_Impure=true,
Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Streams.<strong>print</strong>(string);
Streams.<strong>print</strong>(string,fileName);
</pre></blockquote>
<h4>Description</h4>
<p>
Function <strong>print</strong>(..) opens automatically the given file, if
it is not yet open. If the file does not exist, it is created.
If the file does exist, the given string is appended to the file.
If this is not desired, call \"Files.remove(fileName)\" before calling print
(\"remove(..)\" is silent, if the file does not exist).
The Modelica environment may close the file whenever appropriate.
This can be enforced by calling <strong>Streams.close</strong>(fileName).
After every call of \"print(..)\" a \"new line\" is printed automatically.
</p>
<h4>Example</h4>
<blockquote><pre>
  Streams.print(\"x = \" + String(x));
  Streams.print(\"y = \" + String(y));
  Streams.print(\"x = \" + String(y), \"mytestfile.txt\");
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams\">Streams</a>,
<a href=\"modelica://Modelica.Utilities.Streams.error\">Streams.error</a>,
<a href=\"modelica://ModelicaReference.Operators.'String()'\">ModelicaReference.Operators.'String()'</a>
</p>
</html>"));
  end print;

  function readFile
    "Read content of a file and return it in a vector of strings"
    extends Modelica.Icons.Function;
    input String fileName "Name of the file that shall be read"
                 annotation(Dialog(loadSelector(filter="Text files (*.txt)",
                        caption="Open text file for reading")));
    output String stringVector[countLines(fileName)] "Content of file";
    external "C" ModelicaInternal_readFile(fileName,stringVector,size(stringVector,1)) annotation(Library="ModelicaExternalC");
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
stringVector = Streams.<strong>readFile</strong>(fileName)
</pre></blockquote>
<h4>Description</h4>
<p>
Function <strong>readFile</strong>(..) opens the given file, reads the complete
content, closes the file and returns the content as a vector of strings. Lines are separated by LF or CR-LF; the returned strings do not contain the line separators.
Note, a fileName can be defined as URI by using the helper function
<a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.
</p>
</html>"));
  end readFile;

  function readLine "Read a line of text from a file and return it in a string"
    extends Modelica.Icons.Function;
    input String fileName "Name of the file that shall be read"
                        annotation(Dialog(loadSelector(filter="Text files (*.txt)",
                        caption="Open text file for reading")));
    input Integer lineNumber(min=1) "Number of line to read";
    output String string "Line of text";
    output Boolean endOfFile
      "If true, end-of-file was reached when trying to read line";
   external "C" string=  ModelicaInternal_readLine(fileName,lineNumber,endOfFile) annotation(Library="ModelicaExternalC");
    annotation (__ModelicaAssociation_Impure=true,
Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
(string, endOfFile) = Streams.<strong>readLine</strong>(fileName, lineNumber)
</pre></blockquote>
<h4>Description</h4>
<p>
Function <strong>readLine</strong>(..) opens the given file, reads enough of the
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

  function countLines "Return the number of lines in a file"
    extends Modelica.Icons.Function;
    input String fileName "Name of the file that shall be read"
                       annotation(Dialog(loadSelector(filter="Text files (*.txt)",
                        caption="Open text file for counting lines")));

    output Integer numberOfLines "Number of lines in file";
  external "C" numberOfLines=  ModelicaInternal_countLines(fileName) annotation(Library="ModelicaExternalC");
    annotation (__ModelicaAssociation_Impure=true,
Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
numberOfLines = Streams.<strong>countLines</strong>(fileName)
</pre></blockquote>
<h4>Description</h4>
<p>
Function <strong>countLines</strong>(..) opens the given file, reads the complete
content, closes the file and returns the number of lines. Lines are
separated by LF or CR-LF.
</p>
</html>"));
  end countLines;

  function error "Print error message and cancel all actions - in case of an unrecoverable error"
    extends Modelica.Icons.Function;
    input String string "String to be printed to error message window";
    external "C" ModelicaError(string) annotation(Library="ModelicaExternalC");
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Streams.<strong>error</strong>(string);
</pre></blockquote>
<h4>Description</h4>
<p>
In case of an unrecoverable error (i.e., if the solver is unable to recover from the error),
print the string \"string\" as error message and cancel all actions.
This function is semantically equivalent with the built-in function <strong>assert</strong> if called with the (default) <strong>AssertionLevel.error</strong>.
Line breaks are characterized by \"\\n\" in the string.
</p>
<h4>Example</h4>
<blockquote><pre>
  Streams.error(\"x (= \" + String(x) + \")\\nhas to be in the range 0 .. 1\");
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams\">Streams</a>,
<a href=\"modelica://Modelica.Utilities.Streams.print\">Streams.print</a>,
<a href=\"modelica://ModelicaReference.Operators.'assert()'\">ModelicaReference.Operators.'assert()'</a>
<a href=\"modelica://ModelicaReference.Operators.'String()'\">ModelicaReference.Operators.'String()'</a>
</p>
</html>"));
  end error;

  function close "Close file"
    extends Modelica.Icons.Function;
    input String fileName "Name of the file that shall be closed"
                 annotation(Dialog(loadSelector(filter="Text files (*.txt)",
                        caption="Close text file")));
    external "C" ModelicaStreams_closeFile(fileName) annotation(Library="ModelicaExternalC");
    annotation (__ModelicaAssociation_Impure=true,
Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Streams.<strong>close</strong>(fileName)
</pre></blockquote>
<h4>Description</h4>
<p>
Close file if it is open. Ignore call if
file is already closed or does not exist.
</p>
</html>"));
  end close;

  function readMatrixSize "Read dimensions of a Real matrix from a MATLAB MAT file"
    extends Modelica.Icons.Function;
    input String fileName "File where external data is stored" annotation(Dialog(loadSelector(filter="MATLAB MAT files (*.mat)", caption="Open MATLAB MAT file")));
    input String matrixName "Name / identifier of the 2D Real array on the file";
    output Integer dim[2] "Number of rows and columns of the 2D Real array";
    external "C" ModelicaIO_readMatrixSizes(fileName, matrixName, dim)
    annotation(Library={"ModelicaIO", "ModelicaMatIO", "zlib"});
    annotation(Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
dim = Streams.<strong>readMatrixSize</strong>(fileName, matrixName)
</pre></blockquote>

<h4>Description</h4>
<p>
Function <strong>readMatrixSize</strong>(..) opens the given MATLAB MAT file
(in format v4, v6, v7, and if HDF is supported in the Modelica tool, also v7.3),
and reads the dimensions of the given Real matrix.
These dimensions are returned in the Integer vector dim.
</p>

<h4>Example</h4>
<p>
See <a href=\"modelica://Modelica.Utilities.Examples.ReadRealMatrixFromFile\">Examples.ReadRealMatrixFromFile</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams.readRealMatrix\">readRealMatrix</a>,
<a href=\"modelica://Modelica.Utilities.Streams.writeRealMatrix\">writeRealMatrix</a>
</p>
</html>"));
  end readMatrixSize;

  function readRealMatrix "Read Real matrix from MATLAB MAT file"
    extends Modelica.Icons.Function;
    input String fileName "File where external data is stored" annotation(Dialog(loadSelector(filter="MATLAB MAT files (*.mat)", caption="Open MATLAB MAT file")));
    input String matrixName "Name / identifier of the 2D Real array on the file";
    input Integer nrow "Number of rows of the 2D Real array";
    input Integer ncol "Number of columns of the 2D Real array";
    input Boolean verboseRead = true
      "= true: Print info message; = false: No info message";
    output Real matrix[nrow, ncol] "2D Real array";
    external "C" ModelicaIO_readRealMatrix(fileName, matrixName, matrix, size(matrix, 1), size(matrix, 2), verboseRead)
    annotation(Library={"ModelicaIO", "ModelicaMatIO", "zlib"});
    annotation(
Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
matrix = Streams.<strong>readRealMatrix</strong>(fileName, matrixName, nrow, ncol, verboseRead)
</pre></blockquote>

<h4>Description</h4>
<p>
Function <strong>readRealMatrix</strong>(..) opens the given MATLAB MAT file
(in format v4, v6, v7, and if HDF is supported in the Modelica tool, also v7.3),
and reads the given matrix from this file. The dimensions of this matrix must first
be inquired with function
<a href=\"modelica://Modelica.Utilities.Streams.readMatrixSize\">readMatrixSize</a>
and passed via arguments nrow and ncol to this function.
</p>

<h4>Example</h4>
<p>
See <a href=\"modelica://Modelica.Utilities.Examples.ReadRealMatrixFromFile\">Examples.ReadRealMatrixFromFile</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams.readMatrixSize\">readMatrixSize</a>,
<a href=\"modelica://Modelica.Utilities.Streams.writeRealMatrix\">writeRealMatrix</a>
</p>
</html>"));
  end readRealMatrix;

  function writeRealMatrix "Write Real matrix to a MATLAB MAT file"
    extends Modelica.Icons.Function;
    input String fileName "File where external data is to be stored" annotation(Dialog(saveSelector(filter="MATLAB MAT files (*.mat)", caption="Save MATLAB MAT file")));
    input String matrixName "Name / identifier of the 2D Real array on the file";
    input Real matrix[:,:] "2D Real array";
    input Boolean append = false "Append values to file";
    input String format = "4" "MATLAB MAT file version: \"4\" -> v4, \"6\" -> v6, \"7\" -> v7"
      annotation(choices(choice="4" "MATLAB v4 MAT file",
                         choice="6" "MATLAB v6 MAT file",
                         choice="7" "MATLAB v7 MAT file"));
    output Boolean success "true if successful";
    external "C" success = ModelicaIO_writeRealMatrix(fileName, matrixName, matrix, size(matrix, 1), size(matrix, 2), append, format)
    annotation(Library={"ModelicaIO", "ModelicaMatIO", "zlib"});

    annotation(__ModelicaAssociation_Impure=true,
Documentation(info="<html>

<h4>Syntax</h4>
<blockquote><pre>
success = Streams.<strong>writeRealMatrix</strong>(fileName, matrixName, matrix, append, format)
</pre></blockquote>

<h4>Description</h4>
<p>
Function <strong>writeRealMatrix</strong>(..) writes the given matrix to a new or an existing MATLAB MAT file
(in format v4, v6, v7, and if HDF is supported in the Modelica tool, also v7.3).
If <code>append = false</code> (= default), the file is newly created
(or an existing file is deleted and re-created).
If <code>append = true</code>, the matrix is included in an existing file or if the
file does not yet exists this flag is ignored. If the file exists and
<code>append = true</code>, argument format is ignored.
</p>

<p>
Parameter <strong>format</strong> defines the format in which the values are stored on file.
The following formats are supported:<br>&nbsp;
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><td>format = </td><td>Type of format</td></tr>
<tr><td>\"4\"  </td><td>MATLAB MAT version v4</td></tr>
<tr><td>\"6\"  </td><td>MATLAB MAT version v6</td></tr>
<tr><td>\"7\"  </td><td>MATLAB MAT version v7</td></tr>
<tr><td>\"7.3\"</td><td>MATLAB MAT version v7.3<br>
                      (requires HDF support in the Modelica tool)</td></tr>
</table>

<p>
The function returns <code>success = true</code> if the matrix was successfully written
to file. Otherwise, an error message is printed and the function returns with
<code>success = false</code>.
</p>

<h4>Example</h4>
<p>
See <a href=\"modelica://Modelica.Utilities.Examples.WriteRealMatrixToFile\">Examples.WriteRealMatrixToFile</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams.readMatrixSize\">readMatrixSize</a>,
<a href=\"modelica://Modelica.Utilities.Streams.readRealMatrix\">readRealMatrix</a>
</p>
</html>"));
  end writeRealMatrix;
  annotation (
    Documentation(info="<html>
<h4>Library content</h4>
<p>
Package <strong>Streams</strong> contains functions to input and output strings
to a message window or on files, as well as reading matrices from file
and writing matrices to file. Note that a string is interpreted
and displayed as html text (e.g., with print(..) or error(..))
if it is enclosed with the Modelica html quotation, e.g.,
</p>
<blockquote><p>
string = \"&lt;html&gt; first line &lt;br&gt; second line &lt;/html&gt;\".
</p></blockquote>
<p>
It is a quality of implementation, whether (a) all tags of html are supported
or only a subset, (b) how html tags are interpreted if the output device
does not allow to display formatted text.
</p>
<p>
In the table below an example call to every function is given:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><strong><em>Function/type</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Streams.print\">print</a>(string)<br>
          <a href=\"modelica://Modelica.Utilities.Streams.print\">print</a>(string,fileName)</td>
      <td> Print string \"string\" or vector of strings to message window or on
           file \"fileName\".</td>
  </tr>
  <tr><td>stringVector =
         <a href=\"modelica://Modelica.Utilities.Streams.readFile\">readFile</a>(fileName)</td>
      <td> Read complete text file and return it as a vector of strings.</td>
  </tr>
  <tr><td>(string, endOfFile) =
         <a href=\"modelica://Modelica.Utilities.Streams.readLine\">readLine</a>(fileName, lineNumber)</td>
      <td>Returns from the file the content of line lineNumber.</td>
  </tr>
  <tr><td>lines =
         <a href=\"modelica://Modelica.Utilities.Streams.countLines\">countLines</a>(fileName)</td>
      <td>Returns the number of lines in a file.</td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Streams.error\">error</a>(string)</td>
      <td> Print error message \"string\" to message window
           and cancel all actions</td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Streams.close\">close</a>(fileName)</td>
      <td> Close file if it is still open. Ignore call if
           file is already closed or does not exist. </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Streams.readMatrixSize\">readMatrixSize</a>(fileName, matrixName)</td>
      <td> Read dimensions of a Real matrix from a MATLAB MAT file. </td></tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Streams.readRealMatrix\">readRealMatrix</a>(fileName, matrixName, nrow, ncol)</td>
      <td> Read a Real matrix from a MATLAB MAT file. </td></tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Streams.writeRealMatrix\">writeRealMatrix</a>(fileName, matrixName, matrix, append, format)</td>
      <td> Write Real matrix to a MATLAB MAT file. </td></tr>
</table>
<p>
Use functions <strong>scanXXX</strong> from package
<a href=\"modelica://Modelica.Utilities.Strings\">Strings</a>
to parse a string.
</p>
<p>
If Real, Integer or Boolean values shall be printed
or used in an error message, they have to be first converted
to strings with the builtin operator
<a href=\"modelica://ModelicaReference.Operators.'String()'\">ModelicaReference.Operators.'String()'</a>(...).
Example:
</p>
<pre>
  <strong>if</strong> x &lt; 0 <strong>or</strong> x &gt; 1 <strong>then</strong>
     Streams.error(\"x (= \" + String(x) + \") has to be in the range 0 .. 1\");
  <strong>end if</strong>;
</pre>
</html>"));
end Streams;
