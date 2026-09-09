within Modelica.Blocks;
package Tables
  "Library of blocks to interpolate in one and two-dimensional tables"
  extends Modelica.Icons.Package;
  block CombiTable1Ds
    "Table look-up in one dimension (matrix/file) with one input and n outputs"
    extends Modelica.Blocks.Interfaces.SIMO(final nout=size(columns, 1));
    parameter Boolean tableOnFile=false
      "= true, if table is defined on file or in function usertab"
      annotation (Dialog(group="Table data definition"));
    parameter Real table[:, :] = fill(0.0, 0, 2)
      "Table matrix (grid = first column; e.g., table=[0, 0; 1, 1; 2, 4])"
      annotation (Dialog(group="Table data definition",enable=not tableOnFile));
    parameter String tableName="NoName"
      "Table name on file or in function usertab (see docu)"
      annotation (Dialog(group="Table data definition",enable=tableOnFile));
    parameter String fileName="NoName" "File where matrix is stored"
      annotation (Dialog(
        group="Table data definition",
        enable=tableOnFile,
        loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat);;Comma-separated values files (*.csv)",
            caption="Open file in which table is present")));
    parameter String delimiter="," "Column delimiter character for CSV file"
      annotation (Dialog(
        group="Table data definition",
        enable=tableOnFile and isCsvExt),
        choices(choice=" " "Blank", choice="," "Comma", choice="\t" "Horizontal tabulator", choice=";" "Semicolon"));
    parameter Integer nHeaderLines=0 "Number of header lines to ignore for CSV file"
      annotation (Dialog(group="Table data definition",enable=tableOnFile and isCsvExt));
    parameter Boolean verboseRead=true
      "= true, if info message that file is loading is to be printed"
      annotation (Dialog(group="Table data definition",enable=tableOnFile));
    parameter Integer columns[:]=2:size(table, 2)
      "Columns of table to be interpolated"
      annotation (Dialog(group="Table data interpretation"));
    parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
      "Smoothness of table interpolation"
      annotation (Dialog(group="Table data interpretation"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints
      "Extrapolation of data outside the definition range"
      annotation (Dialog(group="Table data interpretation"));
    parameter Boolean verboseExtrapolation=false
      "= true, if warning messages are to be printed if table input is outside the definition range"
      annotation (Dialog(group="Table data interpretation", enable=extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    final parameter Real u_min=Internal.getTable1DAbscissaUmin(tableID)
      "Minimum abscissa value defined in table";
    final parameter Real u_max=Internal.getTable1DAbscissaUmax(tableID)
      "Maximum abscissa value defined in table";
  protected
    parameter Modelica.Blocks.Types.ExternalCombiTable1D tableID=
        Modelica.Blocks.Types.ExternalCombiTable1D(
          if tableOnFile then if isCsvExt then "Values" else tableName else "NoName",
          if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
          table,
          columns,
          smoothness,
          extrapolation,
          if tableOnFile then verboseRead else false,
          delimiter,
          nHeaderLines) "External table object";
    final parameter Boolean isCsvExt = if tableOnFile then Modelica.Utilities.Strings.findLast(fileName, ".csv", caseSensitive=false) + 3 == Modelica.Utilities.Strings.length(fileName) else false;
  equation
    if tableOnFile then
      assert(tableName <> "NoName" or isCsvExt,
        "tableOnFile = true and no table name given");
    else
      assert(size(table, 1) > 0 and size(table, 2) > 0,
        "tableOnFile = false and parameter table is an empty matrix");
    end if;

    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      assert(noEvent(u >= u_min), "
Extrapolation warning: The value u (=" + String(u) + ") must be greater or equal
than the minimum abscissa value u_min (=" + String(u_min) + ") defined in the table.
", level=AssertionLevel.warning);
      assert(noEvent(u <= u_max), "
Extrapolation warning: The value u (=" + String(u) + ") must be less or equal
than the maximum abscissa value u_max (=" + String(u_max) + ") defined in the table.
", level=AssertionLevel.warning);
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for i in 1:nout loop
        y[i] = Internal.getTable1DValueNoDer(tableID, i, u);
      end for;
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      for i in 1:nout loop
        y[i] = Internal.getTable1DValueNoDer2(tableID, i, u);
      end for;
    else
      for i in 1:nout loop
        y[i] = Internal.getTable1DValue(tableID, i, u);
      end for;
    end if;
    annotation (
      Documentation(info="<html>
<p>
<strong>Univariate constant</strong>, <strong>linear</strong> or <strong>cubic Hermite
spline interpolation</strong> in <strong>one</strong> dimension of a
<strong>table</strong>.
Via parameter <strong>columns</strong> it can be defined how many columns of the
table are interpolated. If, e.g., columns={2,4}, it is assumed that
2 output signals are present and that the first output interpolates
via column 2 and the second output interpolates via column 4 of the
table matrix.
</p>
<p>
The grid points and function values are stored in a matrix \"table[i,j]\",
where the first column \"table[:,1]\" contains the grid points and the
other columns contain the data to be interpolated. Example:
</p>
<blockquote><pre>
table = [0,  0;
         1,  1;
         2,  4;
         4, 16]
If, e.g., the input u = 1.0, the output y =  1.0,
    e.g., the input u = 1.5, the output y =  2.5,
    e.g., the input u = 2.0, the output y =  4.0,
    e.g., the input u =-1.0, the output y = -1.0 (i.e., extrapolation).
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Linear interpolation
           = 2: Akima interpolation: Smooth interpolation by cubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Smooth interpolation by cubic
                Hermite splines such that y preserves the monotonicity and
                der(y) is continuous, also if extrapolated.
           = 5: Steffen interpolation: Smooth interpolation by cubic Hermite
                splines such that y preserves the monotonicity and der(y)
                is continuous, also if extrapolated.
           = 6: Modified Akima interpolation: Smooth interpolation by cubic
                Hermite splines such that der(y) is continuous, also if
                extrapolated. Additionally, overshoots and edge cases of the
                original Akima interpolation method are avoided.
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last value of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one row</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column) have to be strictly increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<blockquote><pre>
tableName is \"NoName\" or has only blanks,
fileName  is \"NoName\" or has only blanks.
</pre></blockquote></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". CSV, text and MATLAB MAT-file format is possible.
    (Both the limitations on the CSV format and the text format are described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<blockquote><pre>
save tables.mat tab1 tab2 tab3
</pre></blockquote>
    or Scilab by command
<blockquote><pre>
savematfile tables.mat tab1 tab2 tab3
</pre></blockquote>
    when the three tables tab1, tab2, tab3 should be used from the model.<br>
    Note, a fileName can be defined as URI by using the helper function
    <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>Statically stored in function \"usertab\" in file \"usertab.c\".
    The matrix is identified by \"tableName\". Parameter
    fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If the table is read from a CSV file, the following limitations apply
</p>
<ol>
<li>Non-numeric data is not supported (in the lines following the header lines), even if such columns are excluded.</li>
<li>Double-quoted data entries in the first header line shall not contain the column delimiter.</li>
</ol>
<p>
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double tab1(5,2)   # comment line
  0   0
  1   1
  2   4
  3   9
  4  16
double tab2(5,2)   # another comment line
  0   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre></blockquote>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
A valid matrix name (e.g., \"tab1\") must be ASCII encoded and not contain blanks, line breaks, tab (\\t), comma (,) or parentheses.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Text files should either be ASCII or UTF-8 encoded, where UTF-8 encoded strings are only allowed in line comments and an optional UTF-8 BOM at the start of the text file is ignored.
Other characters, like trailing non comments, are not allowed in the file.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"),
      Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
        graphics={
      Line(points={{-60,40},{-60,-40},{60,-40},{60,40},{30,40},{30,-40},{-30,-40},{-30,40},{-60,40},{-60,20},{60,20},{60,0},{-60,0},{-60,-20},{60,-20},{60,-40},{-60,-40},{-60,40},{60,40},{60,-40}}),
      Line(points={{0,40},{0,-40}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60,20},{-30,40}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60,0},{-30,20}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60,-20},{-30,0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60,-40},{-30,-20}}),
      Text(extent={{-150,-150},{150,-110}}, textString="tableOnFile=%tableOnFile")}));
  end CombiTable1Ds;

  block CombiTable1Dv
    "Table look-up in one dimension (matrix/file) with n inputs and n outputs"
    extends Modelica.Blocks.Interfaces.MIMOs(final n=size(columns, 1));
    parameter Boolean tableOnFile=false
      "= true, if table is defined on file or in function usertab"
      annotation (Dialog(group="Table data definition"));
    parameter Real table[:, :] = fill(0.0, 0, 2)
      "Table matrix (grid = first column; e.g., table=[0, 0; 1, 1; 2, 4])"
      annotation (Dialog(group="Table data definition",enable=not tableOnFile));
    parameter String tableName="NoName"
      "Table name on file or in function usertab (see docu)"
      annotation (Dialog(group="Table data definition",enable=tableOnFile));
    parameter String fileName="NoName" "File where matrix is stored"
      annotation (Dialog(
        group="Table data definition",
        enable=tableOnFile,
        loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat);;Comma-separated values files (*.csv)",
            caption="Open file in which table is present")));
    parameter String delimiter="," "Column delimiter character for CSV file"
      annotation (Dialog(
        group="Table data definition",
        enable=tableOnFile and isCsvExt),
        choices(choice=" " "Blank", choice="," "Comma", choice="\t" "Horizontal tabulator", choice=";" "Semicolon"));
    parameter Integer nHeaderLines=0 "Number of header lines to ignore for CSV file"
      annotation (Dialog(group="Table data definition",enable=tableOnFile and isCsvExt));
    parameter Boolean verboseRead=true
      "= true, if info message that file is loading is to be printed"
      annotation (Dialog(group="Table data definition",enable=tableOnFile));
    parameter Integer columns[:]=2:size(table, 2)
      "Columns of table to be interpolated"
      annotation (Dialog(group="Table data interpretation"));
    parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
      "Smoothness of table interpolation"
      annotation (Dialog(group="Table data interpretation"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints
      "Extrapolation of data outside the definition range"
      annotation (Dialog(group="Table data interpretation"));
    parameter Boolean verboseExtrapolation=false
      "= true, if warning messages are to be printed if table input is outside the definition range"
      annotation (Dialog(group="Table data interpretation", enable=extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    final parameter Real u_min=Internal.getTable1DAbscissaUmin(tableID)
      "Minimum abscissa value defined in table";
    final parameter Real u_max=Internal.getTable1DAbscissaUmax(tableID)
      "Maximum abscissa value defined in table";
  protected
    parameter Modelica.Blocks.Types.ExternalCombiTable1D tableID=
        Modelica.Blocks.Types.ExternalCombiTable1D(
          if tableOnFile then if isCsvExt then "Values" else tableName else "NoName",
          if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
          table,
          columns,
          smoothness,
          extrapolation,
          if tableOnFile then verboseRead else false,
          delimiter,
          nHeaderLines) "External table object";
    final parameter Boolean isCsvExt = if tableOnFile then Modelica.Utilities.Strings.findLast(fileName, ".csv", caseSensitive=false) + 3 == Modelica.Utilities.Strings.length(fileName) else false;
  equation
    if tableOnFile then
      assert(tableName <> "NoName" or isCsvExt,
        "tableOnFile = true and no table name given");
    else
      assert(size(table, 1) > 0 and size(table, 2) > 0,
        "tableOnFile = false and parameter table is an empty matrix");
    end if;

    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      for i in 1:n loop
        assert(noEvent(u[i] >= u_min), "
Extrapolation warning: The value u[" + String(i) +"] (=" + String(u[i]) + ") must be greater or equal
than the minimum abscissa value u_min (=" + String(u_min) + ") defined in the table.
", level=AssertionLevel.warning);
        assert(noEvent(u[i] <= u_max), "
Extrapolation warning: The value u[" + String(i) +"] (=" + String(u[i]) + ") must be less or equal
than the maximum abscissa value u_max (=" + String(u_max) + ") defined in the table.
", level=AssertionLevel.warning);
      end for;
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for i in 1:n loop
        y[i] = Internal.getTable1DValueNoDer(tableID, i, u[i]);
      end for;
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      for i in 1:n loop
        y[i] = Internal.getTable1DValueNoDer2(tableID, i, u[i]);
      end for;
    else
      for i in 1:n loop
        y[i] = Internal.getTable1DValue(tableID, i, u[i]);
      end for;
    end if;
    annotation (
      Documentation(info="<html>
<p>
<strong>Univariate constant</strong>, <strong>linear</strong> or <strong>cubic Hermite
spline interpolation</strong> in <strong>one</strong> dimension of a
<strong>table</strong>.
Via parameter <strong>columns</strong> it can be defined how many columns of the
table are interpolated. If, e.g., columns={2,4}, it is assumed that 2 input
and 2 output signals are present and that the first output interpolates
the first input via column 2 and the second output interpolates the
second input via column 4 of the table matrix.
</p>
<p>
The grid points and function values are stored in a matrix \"table[i,j]\",
where the first column \"table[:,1]\" contains the grid points and the
other columns contain the data to be interpolated. Example:
</p>
<blockquote><pre>
table = [0,  0;
         1,  1;
         2,  4;
         4, 16]
If, e.g., the input u = 1.0, the output y =  1.0,
    e.g., the input u = 1.5, the output y =  2.5,
    e.g., the input u = 2.0, the output y =  4.0,
    e.g., the input u =-1.0, the output y = -1.0 (i.e., extrapolation).
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Linear interpolation
           = 2: Akima interpolation: Smooth interpolation by cubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Smooth interpolation by cubic
                Hermite splines such that y preserves the monotonicity and
                der(y) is continuous, also if extrapolated.
           = 5: Steffen interpolation: Smooth interpolation by cubic Hermite
                splines such that y preserves the monotonicity and der(y)
                is continuous, also if extrapolated.
           = 6: Modified Akima interpolation: Smooth interpolation by cubic
                Hermite splines such that der(y) is continuous, also if
                extrapolated. Additionally, overshoots and edge cases of the
                original Akima interpolation method are avoided.
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last value of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one row</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column) have to be strictly increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<blockquote><pre>
tableName is \"NoName\" or has only blanks,
fileName  is \"NoName\" or has only blanks.
</pre></blockquote></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". CSV, text and MATLAB MAT-file format is possible.
    (Both the limitations on the CSV format and the text format are described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<blockquote><pre>
save tables.mat tab1 tab2 tab3
</pre></blockquote>
    or Scilab by command
<blockquote><pre>
savematfile tables.mat tab1 tab2 tab3
</pre></blockquote>
    when the three tables tab1, tab2, tab3 should be used from the model.<br>
    Note, a fileName can be defined as URI by using the helper function
    <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>Statically stored in function \"usertab\" in file \"usertab.c\".
    The matrix is identified by \"tableName\". Parameter
    fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If the table is read from a CSV file, the following limitations apply
</p>
<ol>
<li>Non-numeric data is not supported (in the lines following the header lines), even if such columns are excluded.</li>
<li>Double-quoted data entries in the first header line shall not contain the column delimiter.</li>
</ol>
<p>
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double tab1(5,2)   # comment line
  0   0
  1   1
  2   4
  3   9
  4  16
double tab2(5,2)   # another comment line
  0   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre></blockquote>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
A valid matrix name (e.g., \"tab1\") must be ASCII encoded and not contain blanks, line breaks, tab (\\t), comma (,) or parentheses.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Text files should either be ASCII or UTF-8 encoded, where UTF-8 encoded strings are only allowed in line comments and an optional UTF-8 BOM at the start of the text file is ignored.
Other characters, like trailing non comments, are not allowed in the file.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"),
      Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
        graphics={
      Line(points={{-60,40},{-60,-40},{60,-40},{60,40},{30,40},{30,-40},{-30,-40},{-30,40},{-60,40},{-60,20},{60,20},{60,0},{-60,0},{-60,-20},{60,-20},{60,-40},{-60,-40},{-60,40},{60,40},{60,-40}}),
      Line(points={{0,40},{0,-40}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60,20},{-30,40}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60,0},{-30,20}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60,-20},{-30,0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60,-40},{-30,-20}}),
      Text(extent={{-150,-150},{150,-110}}, textString="tableOnFile=%tableOnFile")}));
  end CombiTable1Dv;

  block CombiTable2Ds "Table look-up in two dimensions (matrix/file)"
    extends Modelica.Blocks.Interfaces.SI2SO;
    extends Internal.CombiTable2DBase;
  equation
    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      assert(noEvent(u1 >= u_min[1]), "
Extrapolation warning: The value u1 (=" + String(u1) + ") must be greater or equal
than the minimum abscissa value u_min[1] (=" + String(u_min[1]) + ") defined in the table.
", level=AssertionLevel.warning);
      assert(noEvent(u1 <= u_max[1]), "
Extrapolation warning: The value u1 (=" + String(u1) + ") must be less or equal
than the maximum abscissa value u_max[1] (=" + String(u_max[1]) + ") defined in the table.
", level=AssertionLevel.warning);
      assert(noEvent(u2 >= u_min[2]), "
Extrapolation warning: The value u2 (=" + String(u2) + ") must be greater or equal
than the minimum abscissa value u_min[2] (=" + String(u_min[2]) + ") defined in the table.
", level=AssertionLevel.warning);
      assert(noEvent(u2 <= u_max[2]), "
Extrapolation warning: The value u2 (=" + String(u2) + ") must be less or equal
than the maximum abscissa value u_max[2] (=" + String(u_max[2]) + ") defined in the table.
", level=AssertionLevel.warning);
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      y = Internal.getTable2DValueNoDer(tableID, u1, u2);
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      y = Internal.getTable2DValueNoDer2(tableID, u1, u2);
    else
      y = Internal.getTable2DValue(tableID, u1, u2);
    end if;
    annotation (
      Documentation(info="<html>
<p>
<strong>Bivariate constant</strong>, <strong>bilinear</strong> or <strong>bivariate
Akima interpolation</strong> of a <strong>two-dimensional table</strong>.
The grid points and function values are stored in a matrix \"table[i,j]\",
where:
</p>
<ul>
<li>the first column \"table[2:,1]\" contains the u1 grid points,</li>
<li>the first row \"table[1,2:]\" contains the u2 grid points,</li>
<li>the other rows and columns contain the data to be interpolated.</li>
</ul>
<p>
Example:
</p>
<blockquote><pre>
        |       |       |       |
        |  1.0  |  2.0  |  3.0  |  // u2
    ----*-------*-------*-------*
    1.0 |  1.0  |  3.0  |  5.0  |
    ----*-------*-------*-------*
    2.0 |  2.0  |  4.0  |  6.0  |
    ----*-------*-------*-------*
  // u1
is defined as
   table = [0.0,   1.0,   2.0,   3.0;
            1.0,   1.0,   3.0,   5.0;
            2.0,   2.0,   4.0,   6.0]
If, e.g., the input u1 is 1.0, input u2 is 1.0 and smoothness is LinearSegments, the output y is 1.0,
    e.g., the input u1 is 2.0, input u2 is 1.5 and smoothness is LinearSegments, the output y is 3.0.
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Bilinear interpolation
           = 2: Bivariate Akima interpolation: Smooth interpolation by bicubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Not supported
           = 5: Steffen interpolation: Not supported
           = 6: Modified Akima interpolation: Not supported
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last values of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one element</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column and first row) have to be strictly
    increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<blockquote><pre>
tableName is \"NoName\" or has only blanks,
fileName  is \"NoName\" or has only blanks.
</pre></blockquote></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". CSV, text and MATLAB MAT-file format is possible.
    (Both the limitations on the CSV format and the text format are described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<blockquote><pre>
save tables.mat tab1 tab2 tab3
</pre></blockquote>
    or Scilab by command
<blockquote><pre>
savematfile tables.mat tab1 tab2 tab3
</pre></blockquote>
    when the three tables tab1, tab2, tab3 should be used from the model.<br>
    Note, a fileName can be defined as URI by using the helper function
    <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>Statically stored in function \"usertab\" in file \"usertab.c\".
    The matrix is identified by \"tableName\". Parameter
    fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If the table is read from a CSV file, the following limitations apply
</p>
<ol>
<li>Non-numeric data is not supported (in the lines following the header lines).</li>
<li>Double-quoted data entries in the first header line shall not contain the column delimiter.</li>
</ol>
<p>
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double table2D_1(3,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0

double table2D_2(4,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0
3.0  3.0  5.0  7.0
-----------------------------------------------------
</pre></blockquote>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
A valid matrix name (e.g., \"tab1\") must be ASCII encoded and not contain blanks, line breaks, tab (\\t), comma (,) or parentheses.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Text files should either be ASCII or UTF-8 encoded, where UTF-8 encoded strings are only allowed in line comments and an optional UTF-8 BOM at the start of the text file is ignored.
Other characters, like trailing non comments, are not allowed in the file.
The matrix elements are interpreted in exactly the same way
as if the matrix is given as a parameter. For example, the first
column \"table2D_1[2:,1]\" contains the u[1] grid points,
and the first row \"table2D_1[1,2:]\" contains the u[2] grid points.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"));
  end CombiTable2Ds;

  block CombiTable2Dv "Table look-up in two dimensions (matrix/file) with vector inputs and vector output of size n"
    extends Modelica.Blocks.Interfaces.MI2MO;
    extends Internal.CombiTable2DBase;
  equation
    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      for j in 1:n loop
        assert(noEvent(u1[j] >= u_min[1]), "
Extrapolation warning: The value u1[" + String(j) + "] (=" + String(u1[j]) + ") must be greater or equal
than the minimum abscissa value u_min[1] (=" + String(u_min[1]) + ") defined in the table.
", level=AssertionLevel.warning);
        assert(noEvent(u1[j] <= u_max[1]), "
Extrapolation warning: The value u1[" + String(j) + "] (=" + String(u1[j]) + ") must be less or equal
than the maximum abscissa value u_max[1] (=" + String(u_max[1]) + ") defined in the table.
", level=AssertionLevel.warning);
        assert(noEvent(u2[j] >= u_min[2]), "
Extrapolation warning: The value u2[" + String(j) + "] (=" + String(u2[j]) + ") must be greater or equal
than the minimum abscissa value u_min[2] (=" + String(u_min[2]) + ") defined in the table.
", level=AssertionLevel.warning);
        assert(noEvent(u2[j] <= u_max[2]), "
Extrapolation warning: The value u2[" + String(j) + "] (=" + String(u2[j]) + ") must be less or equal
than the maximum abscissa value u_max[2] (=" + String(u_max[2]) + ") defined in the table.
", level=AssertionLevel.warning);
      end for;
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for j in 1:n loop
        y[j] = Modelica.Blocks.Tables.Internal.getTable2DValueNoDer(tableID, u1[j], u2[j]);
      end for;
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      for j in 1:n loop
        y[j] = Modelica.Blocks.Tables.Internal.getTable2DValueNoDer2(tableID, u1[j], u2[j]);
      end for;
    else
      for j in 1:n loop
        y[j] = Modelica.Blocks.Tables.Internal.getTable2DValue(tableID, u1[j], u2[j]);
      end for;
    end if;
  annotation(Documentation(info="<html>
<p>
<strong>Bivariate constant</strong>, <strong>bilinear</strong> or <strong>bivariate
Akima interpolation</strong> of a <strong>two-dimensional table</strong>.
The grid points and function values are stored in a matrix \"table[i,j]\",
where:
</p>
<ul>
<li>the first column \"table[2:,1]\" contains the u1 grid points,</li>
<li>the first row \"table[1,2:]\" contains the u2 grid points,</li>
<li>the other rows and columns contain the data to be interpolated.</li>
</ul>
<p>
Example:
</p>
<blockquote><pre>
        |       |       |       |
        |  1.0  |  2.0  |  3.0  |  // u2
    ----*-------*-------*-------*
    1.0 |  1.0  |  3.0  |  5.0  |
    ----*-------*-------*-------*
    2.0 |  2.0  |  4.0  |  6.0  |
    ----*-------*-------*-------*
  // u1
is defined as
   table = [0.0,   1.0,   2.0,   3.0;
            1.0,   1.0,   3.0,   5.0;
            2.0,   2.0,   4.0,   6.0]
If, e.g., the input u1 is {1.0}, input u2 is {1.0} and smoothness is LinearSegments, the output y is {1.0},
    e.g., the input u1 is {2.0}, input u2 is {1.5} and smoothness is LinearSegments, the output y is {3.0}.
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Bilinear interpolation
           = 2: Bivariate Akima interpolation: Smooth interpolation by bicubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Not supported
           = 5: Steffen interpolation: Not supported
           = 6: Modified Akima interpolation: Not supported
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last values of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one element</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column and first row) have to be strictly
    increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<blockquote><pre>
tableName is \"NoName\" or has only blanks,
fileName  is \"NoName\" or has only blanks.
</pre></blockquote></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". CSV, text and MATLAB MAT-file format is possible.
    (Both the limitations on the CSV format and the text format are described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<blockquote><pre>
save tables.mat tab1 tab2 tab3
</pre></blockquote>
    or Scilab by command
<blockquote><pre>
savematfile tables.mat tab1 tab2 tab3
</pre></blockquote>
    when the three tables tab1, tab2, tab3 should be used from the model.<br>
    Note, a fileName can be defined as URI by using the helper function
    <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>Statically stored in function \"usertab\" in file \"usertab.c\".
    The matrix is identified by \"tableName\". Parameter
    fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If the table is read from a CSV file, the following limitations apply
</p>
<ol>
<li>Non-numeric data is not supported (in the lines following the header lines).</li>
<li>Double-quoted data entries in the first header line shall not contain the column delimiter.</li>
</ol>
<p>
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double table2D_1(3,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0

double table2D_2(4,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0
3.0  3.0  5.0  7.0
-----------------------------------------------------
</pre></blockquote>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
A valid matrix name (e.g., \"tab1\") must be ASCII encoded and not contain blanks, line breaks, tab (\\t), comma (,) or parentheses.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Text files should either be ASCII or UTF-8 encoded, where UTF-8 encoded strings are only allowed in line comments and an optional UTF-8 BOM at the start of the text file is ignored.
Other characters, like trailing non comments, are not allowed in the file.
The matrix elements are interpreted in exactly the same way
as if the matrix is given as a parameter. For example, the first
column \"table2D_1[2:,1]\" contains the u[1] grid points,
and the first row \"table2D_1[1,2:]\" contains the u[2] grid points.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"));
  end CombiTable2Dv;

  package Internal "Internal external object definitions for table functions that should not be directly utilized by the user"
    extends Modelica.Icons.InternalPackage;
    partial block CombiTable2DBase "Base class for variants of table look-up in two dimensions"
      parameter Boolean tableOnFile=false
        "= true, if table is defined on file or in function usertab"
        annotation (Dialog(group="Table data definition"));
      parameter Real table[:, :] = fill(0.0, 0, 2)
        "Table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0, 0; 0, 1])"
        annotation (Dialog(group="Table data definition",enable=not tableOnFile));
      parameter String tableName="NoName"
        "Table name on file or in function usertab (see docu)"
        annotation (Dialog(group="Table data definition",enable=tableOnFile));
      parameter String fileName="NoName" "File where matrix is stored"
        annotation (Dialog(
          group="Table data definition",
          enable=tableOnFile,
          loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat);;Comma-separated values files (*.csv)",
              caption="Open file in which table is present")));
      parameter String delimiter="," "Column delimiter character for CSV file"
        annotation (Dialog(
          group="Table data definition",
          enable=tableOnFile and isCsvExt),
          choices(choice=" " "Blank", choice="," "Comma", choice="\t" "Horizontal tabulator", choice=";" "Semicolon"));
      parameter Integer nHeaderLines=0 "Number of header lines to ignore for CSV file"
        annotation (Dialog(group="Table data definition",enable=tableOnFile and isCsvExt));
      parameter Boolean verboseRead=true
        "= true, if info message that file is loading is to be printed"
        annotation (Dialog(group="Table data definition",enable=tableOnFile));
      parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
        "Smoothness of table interpolation"
        annotation (Dialog(group="Table data interpretation"));
      parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints
        "Extrapolation of data outside the definition range"
        annotation (Dialog(group="Table data interpretation"));
      parameter Boolean verboseExtrapolation=false
        "= true, if warning messages are to be printed if table input is outside the definition range"
        annotation (Dialog(group="Table data interpretation", enable=extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
      final parameter Real u_min[2]=getTable2DAbscissaUmin(tableID)
        "Minimum abscissa value defined in table";
      final parameter Real u_max[2]=getTable2DAbscissaUmax(tableID)
        "Maximum abscissa value defined in table";
      protected
        parameter Modelica.Blocks.Types.ExternalCombiTable2D tableID=
          Modelica.Blocks.Types.ExternalCombiTable2D(
            if tableOnFile then if isCsvExt then "Values" else tableName else "NoName",
            if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
            table,
            smoothness,
            extrapolation,
            if tableOnFile then verboseRead else false,
            delimiter,
            nHeaderLines) "External table object";
      final parameter Boolean isCsvExt = if tableOnFile then Modelica.Utilities.Strings.findLast(fileName, ".csv", caseSensitive=false) + 3 == Modelica.Utilities.Strings.length(fileName) else false;
    equation
        if tableOnFile then
          assert(tableName <> "NoName" or isCsvExt,
            "tableOnFile = true and no table name given");
        else
          assert(size(table, 1) > 0 and size(table, 2) > 0,
            "tableOnFile = false and parameter table is an empty matrix");
        end if;
      annotation(Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
        graphics={
      Line(points={{-60,40},{-60,-40},{60,-40},{60,40},{30,40},{30,-40},{-30,-40},{-30,40},{-60,40},{-60,20},{60,20},{60,0},{-60,0},{-60,-20},{60,-20},{60,-40},{-60,-40},{-60,40},{60,40},{60,-40}}),
      Line(points={{0,40},{0,-40}}),
      Line(points={{-60,40},{-30,20}}),
      Line(points={{-30,40},{-60,20}}),
      Rectangle(origin={2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,0},{-32.3077,20}}),
      Rectangle(origin={2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-20},{-32.3077,0}}),
      Rectangle(origin={2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-40},{-32.3077,-20}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-30,20},{0,40}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{0,20},{30,40}}),
      Rectangle(origin={-2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{32.3077,20},{62.3077,40}}),
      Text(extent={{-150,-150},{150,-110}}, textString="tableOnFile=%tableOnFile")}));
    end CombiTable2DBase;

    pure function getTimeTableValue
      "Interpolate 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      input Real nextTimeEvent "(Scaled) next time event in table";
      input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(
          noDerivative=nextTimeEvent,
          noDerivative=pre_nextTimeEvent) = getDerTimeTableValue);
    end getTimeTableValue;

    pure function getTimeTableValueNoDer
      "Interpolate 1-dim. table where first column is time (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      input Real nextTimeEvent "(Scaled) next time event in table";
      input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTimeTableValueNoDer;

    pure function getTimeTableValueNoDer2
      "Interpolate 1-dim. table where first column is time (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      input Real nextTimeEvent "(Scaled) next time event in table";
      input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(
          noDerivative=nextTimeEvent,
          noDerivative=pre_nextTimeEvent) = getDerTimeTableValueNoDer);
    end getTimeTableValueNoDer2;

    pure function getDerTimeTableValue
      "Derivative of interpolated 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      input Real nextTimeEvent "(Scaled) next time event in table";
      input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      input Real der_timeIn "Derivative of (scaled) time value";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTimeTable_getDerValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(
          order=2,
          noDerivative=nextTimeEvent,
          noDerivative=pre_nextTimeEvent) = getDer2TimeTableValue);
    end getDerTimeTableValue;

    pure function getDerTimeTableValueNoDer
      "Derivative of interpolated 1-dim. table where first column is time (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      input Real nextTimeEvent "(Scaled) next time event in table";
      input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      input Real der_timeIn "Derivative of (scaled) time value";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTimeTable_getDerValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDerTimeTableValueNoDer;

    pure function getDer2TimeTableValue
      "Second derivative of interpolated 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      input Real nextTimeEvent "(Scaled) next time event in table";
      input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      input Real der_timeIn "Derivative of (scaled) time value";
      input Real der2_timeIn "Second derivative of (scaled) time value";
      output Real der2_y "Second derivative of interpolated value";
      external "C" der2_y = ModelicaStandardTables_CombiTimeTable_getDer2Value(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn, der2_timeIn)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDer2TimeTableValue;

    pure function getTimeTableTmin
      "Return minimum abscissa value of 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      output Real timeMin "Minimum abscissa value in table";
      external "C" timeMin = ModelicaStandardTables_CombiTimeTable_minimumTime(tableID)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTimeTableTmin;

    pure function getTimeTableTmax
      "Return maximum abscissa value of 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      output Real timeMax "Maximum abscissa value in table";
      external "C" timeMax = ModelicaStandardTables_CombiTimeTable_maximumTime(tableID)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTimeTableTmax;

    pure function getNextTimeEvent
      "Return next time event value of 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Real timeIn "(Scaled) time value";
      output Real nextTimeEvent "(Scaled) next time event in table";
      external "C" nextTimeEvent = ModelicaStandardTables_CombiTimeTable_nextTimeEvent(tableID, timeIn)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getNextTimeEvent;

    pure function getTable1DValue "Interpolate 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative = getDerTable1DValue);
    end getTable1DValue;

    pure function getTable1DValueNoDer
      "Interpolate 1-dim. table defined by matrix (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable1DValueNoDer;

    pure function getTable1DValueNoDer2
      "Interpolate 1-dim. table defined by matrix (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative = getDerTable1DValueNoDer);
    end getTable1DValueNoDer2;

    pure function getDerTable1DValue
      "Derivative of interpolated 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      input Real der_u "Derivative of abscissa value";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTable1D_getDerValue(tableID, icol, u, der_u)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(order=2) = getDer2Table1DValue);
    end getDerTable1DValue;

    pure function getDerTable1DValueNoDer
      "Derivative of interpolated 1-dim. table defined by matrix (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      input Real der_u "Derivative of abscissa value";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTable1D_getDerValue(tableID, icol, u, der_u)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDerTable1DValueNoDer;

    pure function getDer2Table1DValue
      "Second derivative of interpolated 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      input Real der_u "Derivative of abscissa value";
      input Real der2_u " Second derivative of abscissa value";
      output Real der2_y "Second derivative of interpolated value";
      external "C" der2_y = ModelicaStandardTables_CombiTable1D_getDer2Value(tableID, icol, u, der_u, der2_u)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDer2Table1DValue;

    pure function getTable1DAbscissaUmin
      "Return minimum abscissa value of 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      output Real uMin "Minimum abscissa value in table";
      external "C" uMin = ModelicaStandardTables_CombiTable1D_minimumAbscissa(tableID)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable1DAbscissaUmin;

    pure function getTable1DAbscissaUmax
      "Return maximum abscissa value of 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      output Real uMax "Maximum abscissa value in table";
      external "C" uMax = ModelicaStandardTables_CombiTable1D_maximumAbscissa(tableID)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable1DAbscissaUmax;

    pure function getTable2DValue "Interpolate 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative = getDerTable2DValue);
    end getTable2DValue;

    pure function getTable2DValueNoDer
      "Interpolate 2-dim. table defined by matrix (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable2DValueNoDer;

    pure function getTable2DValueNoDer2
      "Interpolate 2-dim. table defined by matrix (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative = getDerTable2DValueNoDer);
    end getTable2DValueNoDer2;

    pure function getDerTable2DValue
      "Derivative of interpolated 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      input Real der_u1 "Derivative of first independent variable";
      input Real der_u2 "Derivative of second independent variable";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTable2D_getDerValue(tableID, u1, u2, der_u1, der_u2)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(order=2) = getDer2Table2DValue);
    end getDerTable2DValue;

    pure function getDerTable2DValueNoDer
      "Derivative of interpolated 2-dim. table defined by matrix (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      input Real der_u1 "Derivative of first independent variable";
      input Real der_u2 "Derivative of second independent variable";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTable2D_getDerValue(tableID, u1, u2, der_u1, der_u2)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDerTable2DValueNoDer;

    pure function getDer2Table2DValue
      "Second derivative of interpolated 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      input Real der_u1 "Derivative of first independent variable";
      input Real der_u2 "Derivative of second independent variable";
      input Real der2_u1 "Second derivative of first independent variable";
      input Real der2_u2 "Second derivative of second independent variable";
      output Real der2_y "Second derivative of interpolated value";
      external "C" der2_y = ModelicaStandardTables_CombiTable2D_getDer2Value(tableID, u1, u2, der_u1, der_u2, der2_u1, der2_u2)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDer2Table2DValue;

    pure function getTable2DAbscissaUmin
      "Return minimum abscissa value of 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      output Real uMin[2] "Minimum abscissa value in table";
      external "C" ModelicaStandardTables_CombiTable2D_minimumAbscissa(tableID, uMin)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable2DAbscissaUmin;

    pure function getTable2DAbscissaUmax
      "Return maximum abscissa value of 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      output Real uMax[2] "Maximum abscissa value in table";
      external "C" ModelicaStandardTables_CombiTable2D_maximumAbscissa(tableID, uMax)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable2DAbscissaUmax;
  end Internal;
  annotation (Documentation(info="<html>
<p>This package contains blocks for one- and two-dimensional interpolation in tables.</p>
<h4>Special interest topic: Statically stored tables for real-time simulation targets</h4>
<p>Especially for use on real-time platform targets (e.g., HIL-simulators) with <strong>no file system</strong>, it is possible to statically
store tables using a function &quot;usertab&quot; in a file conventionally named &quot;usertab.c&quot;. This can be more efficient than providing the tables as Modelica parameter arrays.</p>
<p>This is achieved by providing the tables in a specific structure as C-code and compiling that C-code together with the rest of the simulation model into a binary
that can be executed on the target platform. The &quot;Resources/Data/Tables/&quot; subdirectory of the MSL installation directory contains the files
<a href=\"modelica://Modelica/Resources/Data/Tables/usertab.c\">&quot;usertab.c&quot;</a> and <a href=\"modelica://Modelica/Resources/Data/Tables/usertab.h\">&quot;usertab.h&quot;</a>
that can be used as a template for own developments. While &quot;usertab.c&quot; would be typically used unmodified, the
&quot;usertab.h&quot; needs to adapted for the own needs.</p>
<p>In order to work it is necessary that the compiler pulls in the &quot;usertab.c&quot; file. Different Modelica tools might provide different mechanisms to do so.
Please consult the respective documentation/support for your Modelica tool.</p>
<p>A possible (though slightly makeshift) approach is to pull in the required files by utilizing a &quot;dummy&quot;-function that uses the Modelica external function
interface to include the required &quot;usertab.c&quot;. An example how this can be done is given below.</p>
<blockquote><pre>
model ExampleCTable \"Example utilizing the usertab.c interface\"
  extends Modelica.Icons.Example;
  parameter Real dummy(fixed=false) \"Dummy parameter\" annotation(HideResult=true);
  Modelica.Blocks.Tables.CombiTable1Dv table(tableOnFile=true, tableName=\"TestTable_1D_a\")
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.ContinuousClock clock
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
protected
  encapsulated impure function getUsertab \"External dummy function to include \\\"usertab.c\\\"\"
    input Real dummy_u[:];
    output Real dummy_y;
    external \"C\" dummy_y = mydummyfunc(dummy_u);
    annotation(IncludeDirectory=\"modelica://Modelica/Resources/Data/Tables\",
           Include = \"#include \"usertab.c\"
double mydummyfunc(const double* dummy_in) {
   return 0;
}
\");
  end getUsertab;
initial equation
  dummy = getUsertab(table.y);
equation
  connect(clock.y, table.u[1]) annotation (Line(points={{-59,10},{-42,10}}, color={0,0,127}));
  annotation (experiment(StartTime=0, StopTime=5));
end ExampleCTable;
</pre></blockquote>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-76,-26},{80,-76}},
          lineColor={95,95,95},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-76,24},{80,-26}},
          lineColor={95,95,95},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-76,74},{80,24}},
          lineColor={95,95,95},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-28,74},{-28,-76}},
          color={95,95,95}),
        Line(
          points={{24,74},{24,-76}},
          color={95,95,95})}));
end Tables;
