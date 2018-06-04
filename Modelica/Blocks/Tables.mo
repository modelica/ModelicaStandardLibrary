within Modelica.Blocks;
package Tables
  "Library of blocks to interpolate in one and two-dimensional tables"
  extends Modelica.Icons.Package;
  block CombiTable1D
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
        loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
            caption="Open file in which table is present")));
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
          if tableOnFile then tableName else "NoName",
          if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
          table,
          columns,
          smoothness,
          extrapolation,
          if tableOnFile then verboseRead else false) "External table object";
    function readTableData = // No longer used, but kept for backward compatibility
      Modelica.Blocks.Tables.Internal.readTable1DData "Read table data from text or MATLAB MAT-file";
  equation
    if tableOnFile then
      assert(tableName <> "NoName",
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
<pre>
   table = [0,  0;
            1,  1;
            2,  4;
            4, 16]
   If, e.g., the input u = 1.0, the output y =  1.0,
       e.g., the input u = 1.5, the output y =  2.5,
       e.g., the input u = 2.0, the output y =  4.0,
       e.g., the input u =-1.0, the output y = -1.0 (i.e., extrapolation).
</pre>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<pre>
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
</pre></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<pre>
  extrapolation = 1: Hold the first or last value of the table,
                     if outside of the table scope.
                = 2: Extrapolate by using the derivative at the first/last table
                     points if outside of the table scope.
                     (If smoothness is LinearSegments or ConstantSegments
                     this means to extrapolate linearly through the first/last
                     two table points.).
                = 3: Periodically repeat the table data (periodical function).
                = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></li>
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
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". Both text and MATLAB MAT-file format is possible.
    (The text format is described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<pre>
   save tables.mat tab1 tab2 tab3
</pre>
    or Scilab by command
<pre>
   savematfile tables.mat tab1 tab2 tab3
</pre>
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
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<pre>
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
</pre>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
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
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
      Line(points={{0.0,40.0},{0.0,-40.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60.0,20.0},{-30.0,40.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60.0,0.0},{-30.0,20.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60.0,-20.0},{-30.0,0.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60.0,-40.0},{-30.0,-20.0}})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Rectangle(
            extent={{-60,60},{60,-60}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{-100,0},{-58,0}}, color={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255}),
          Text(
            extent={{-100,100},{100,64}},
            textString="Univariate constant, linear or cubic Hermite spline table interpolation",
            lineColor={0,0,255}),
          Line(points={{-54,40},{-54,-40},{54,-40},{54,40},{28,40},{28,-40},{-28,
                -40},{-28,40},{-54,40},{-54,20},{54,20},{54,0},{-54,0},{-54,-20},
                {54,-20},{54,-40},{-54,-40},{-54,40},{54,40},{54,-40}}, color={
                0,0,0}),
          Line(points={{0,40},{0,-40}}),
          Rectangle(
            extent={{-54,40},{-28,20}},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-54,20},{-28,0}},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-54,0},{-28,-20}},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-54,-20},{-28,-40}},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-50,54},{-32,42}},
            textString="u[1]/[2]",
            lineColor={0,0,255}),
          Text(
            extent={{-24,54},{0,42}},
            textString="y[1]",
            lineColor={0,0,255}),
          Text(
            extent={{-2,-40},{30,-54}},
            textString="columns",
            lineColor={0,0,255}),
          Text(
            extent={{2,54},{26,42}},
            textString="y[2]",
            lineColor={0,0,255})}));
  end CombiTable1D;

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
        loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
            caption="Open file in which table is present")));
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
          if tableOnFile then tableName else "NoName",
          if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
          table,
          columns,
          smoothness,
          extrapolation,
          if tableOnFile then verboseRead else false) "External table object";
    function readTableData = // No longer used, but kept for backward compatibility
      Modelica.Blocks.Tables.Internal.readTable1DData "Read table data from text or MATLAB MAT-file";
  equation
    if tableOnFile then
      assert(tableName <> "NoName",
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
<pre>
   table = [0,  0;
            1,  1;
            2,  4;
            4, 16]
   If, e.g., the input u = 1.0, the output y =  1.0,
       e.g., the input u = 1.5, the output y =  2.5,
       e.g., the input u = 2.0, the output y =  4.0,
       e.g., the input u =-1.0, the output y = -1.0 (i.e., extrapolation).
</pre>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<pre>
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
</pre></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<pre>
  extrapolation = 1: Hold the first or last value of the table,
                     if outside of the table scope.
                = 2: Extrapolate by using the derivative at the first/last table
                     points if outside of the table scope.
                     (If smoothness is LinearSegments or ConstantSegments
                     this means to extrapolate linearly through the first/last
                     two table points.).
                = 3: Periodically repeat the table data (periodical function).
                = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></li>
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
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". Both text and MATLAB MAT-file format is possible.
    (The text format is described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<pre>
   save tables.mat tab1 tab2 tab3
</pre>
    or Scilab by command
<pre>
   savematfile tables.mat tab1 tab2 tab3
</pre>
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
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<pre>
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
</pre>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
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
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
      Line(points={{0.0,40.0},{0.0,-40.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60.0,20.0},{-30.0,40.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60.0,0.0},{-30.0,20.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60.0,-20.0},{-30.0,0.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60.0,-40.0},{-30.0,-20.0}})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Rectangle(
            extent={{-60,60},{60,-60}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{-100,0},{-58,0}}, color={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255}),
          Text(
            extent={{-100,100},{100,64}},
            textString="Univariate constant, linear or cubic Hermite spline table interpolation",
            lineColor={0,0,255}),
          Line(points={{-54,40},{-54,-40},{54,-40},{54,40},{28,40},{28,-40},{-28,
                -40},{-28,40},{-54,40},{-54,20},{54,20},{54,0},{-54,0},{-54,-20},
                {54,-20},{54,-40},{-54,-40},{-54,40},{54,40},{54,-40}}, color={
                0,0,0}),
          Line(points={{0,40},{0,-40}}),
          Rectangle(
            extent={{-54,40},{-28,20}},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-54,20},{-28,0}},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-54,0},{-28,-20}},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-54,-20},{-28,-40}},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-52,56},{-34,44}},
            textString="u",
            lineColor={0,0,255}),
          Text(
            extent={{-22,54},{2,42}},
            textString="y[1]",
            lineColor={0,0,255}),
          Text(
            extent={{4,54},{28,42}},
            textString="y[2]",
            lineColor={0,0,255}),
          Text(
            extent={{0,-40},{32,-54}},
            textString="columns",
            lineColor={0,0,255})}));
  end CombiTable1Ds;

  block CombiTable2D "Table look-up in two dimensions (matrix/file)"
    extends Modelica.Blocks.Interfaces.SI2SO;
    extends Internal.CombiTable2DBase;
    function readTableData = // No longer used, but kept for backward compatibility
      Modelica.Blocks.Tables.Internal.readTable2DData "Read table data from text or MATLAB MAT-file";
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
<pre>
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
</pre>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<pre>
  smoothness = 1: Bilinear interpolation
             = 2: Bivariate Akima interpolation: Smooth interpolation by bicubic Hermite
                  splines such that der(y) is continuous, also if extrapolated.
             = 3: Constant segments
             = 4: Fritsch-Butland interpolation: Not supported
             = 5: Steffen interpolation: Not supported
</pre></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<pre>
  extrapolation = 1: Hold the first or last values of the table,
                     if outside of the table scope.
                = 2: Extrapolate by using the derivative at the first/last table
                     points if outside of the table scope.
                     (If smoothness is LinearSegments or ConstantSegments
                     this means to extrapolate linearly through the first/last
                     two table points.).
                = 3: Periodically repeat the table data (periodical function).
                = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></li>
<li>If the table has only <strong>one element</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>If the input signal <strong>u1</strong> or <strong>u2</strong> is <strong>outside</strong> of the defined
    <strong>interval</strong>, the corresponding value is also determined by linear
    interpolation through the last or first two points of the table.</li>
<li>The grid values (first column and first row) have to be strictly
    increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". Both text and MATLAB MAT-file format is possible.
    (The text format is described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<pre>
   save tables.mat tab1 tab2 tab3
</pre>
    or Scilab by command
<pre>
   savematfile tables.mat tab1 tab2 tab3
</pre>
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
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<pre>
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
</pre>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
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
  end CombiTable2D;

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
<pre>
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
</pre>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<pre>
  smoothness = 1: Bilinear interpolation
             = 2: Bivariate Akima interpolation: Smooth interpolation by bicubic Hermite
                  splines such that der(y) is continuous, also if extrapolated.
             = 3: Constant segments
             = 4: Fritsch-Butland interpolation: Not supported
             = 5: Steffen interpolation: Not supported
</pre></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<pre>
  extrapolation = 1: Hold the first or last values of the table,
                     if outside of the table scope.
                = 2: Extrapolate by using the derivative at the first/last table
                     points if outside of the table scope.
                     (If smoothness is LinearSegments or ConstantSegments
                     this means to extrapolate linearly through the first/last
                     two table points.).
                = 3: Periodically repeat the table data (periodical function).
                = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></li>
<li>If the table has only <strong>one element</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>If the input signal <strong>u1</strong> or <strong>u2</strong> is <strong>outside</strong> of the defined
    <strong>interval</strong>, the corresponding value is also determined by linear
    interpolation through the last or first two points of the table.</li>
<li>The grid values (first column and first row) have to be strictly
    increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". Both text and MATLAB MAT-file format is possible.
    (The text format is described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<pre>
   save tables.mat tab1 tab2 tab3
</pre>
    or Scilab by command
<pre>
   savematfile tables.mat tab1 tab2 tab3
</pre>
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
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<pre>
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
</pre>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
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
    partial block CombiTable2DBase "Base class for variants of CombiTable2D"
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
          loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
              caption="Open file in which table is present")));
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
            if tableOnFile then tableName else "NoName",
            if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
            table,
            smoothness,
            extrapolation,
            if tableOnFile then verboseRead else false) "External table object";
      equation
        if tableOnFile then
          assert(tableName <> "NoName",
            "tableOnFile = true and no table name given");
        else
          assert(size(table, 1) > 0 and size(table, 2) > 0,
            "tableOnFile = false and parameter table is an empty matrix");
        end if;
      annotation(Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
      Line(points={{0.0,40.0},{0.0,-40.0}}),
      Line(points={{-60.0,40.0},{-30.0,20.0}}),
      Line(points={{-30.0,40.0},{-60.0,20.0}}),
      Rectangle(origin={2.3077,-0.0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,0.0},{-32.3077,20.0}}),
      Rectangle(origin={2.3077,-0.0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-20.0},{-32.3077,0.0}}),
      Rectangle(origin={2.3077,-0.0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-40.0},{-32.3077,-20.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-30.0,20.0},{0.0,40.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{0.0,20.0},{30.0,40.0}}),
      Rectangle(origin={-2.3077,-0.0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{32.3077,20.0},{62.3077,40.0}})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={
          Rectangle(
            extent={{-60,60},{60,-60}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{60,0},{100,0}}, color={0,0,255}),
          Text(
            extent={{-100,100},{100,64}},
            textString="Bivariate constant, bilinear or bivariate Akima table interpolation",
            lineColor={0,0,255}),
          Line(points={{-54,40},{-54,-40},{54,-40},{54,40},{28,40},{28,-40},{-28,
                -40},{-28,40},{-54,40},{-54,20},{54,20},{54,0},{-54,0},{-54,-20},
                {54,-20},{54,-40},{-54,-40},{-54,40},{54,40},{54,-40}}, color={
                0,0,0}),
          Line(points={{0,40},{0,-40}}),
          Rectangle(
            extent={{-54,20},{-28,0}},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-54,0},{-28,-20}},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-54,-20},{-28,-40}},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-28,40},{0,20}},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{0,40},{28,20}},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{28,40},{54,20}},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-54,40},{-28,20}}),
          Line(points={{-28,40},{-54,20}}),
          Text(
            extent={{-54,-40},{-30,-56}},
            textString="u1",
            lineColor={0,0,255}),
          Text(
            extent={{28,58},{52,44}},
            textString="u2",
            lineColor={0,0,255}),
          Text(
            extent={{-2,12},{32,-22}},
            textString="y",
            lineColor={0,0,255})}));
    end CombiTable2DBase;

    function readTimeTableData "Read table data from text or MATLAB MAT-file"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
      input Boolean forceRead = false
        "= true: Force reading of table data; = false: Only read, if not yet read.";
      output Real readSuccess "Table read success";
      input Boolean verboseRead = true
        "= true: Print info message; = false: No info message";
      external"C" readSuccess = ModelicaStandardTables_CombiTimeTable_read(tableID, forceRead, verboseRead)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation(__ModelicaAssociation_Impure=true);
    end readTimeTableData;

    function getTimeTableValue
      "Interpolate 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
      input Integer icol;
      input Real timeIn;
      discrete input Real nextTimeEvent;
      discrete input Real pre_nextTimeEvent;
      output Real y;
      external"C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(
          noDerivative=nextTimeEvent,
          noDerivative=pre_nextTimeEvent) = getDerTimeTableValue);
    end getTimeTableValue;

    function getTimeTableValueNoDer
      "Interpolate 1-dim. table where first column is time (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
      input Integer icol;
      input Real timeIn;
      discrete input Real nextTimeEvent;
      discrete input Real pre_nextTimeEvent;
      output Real y;
      external"C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTimeTableValueNoDer;

    function getDerTimeTableValue
      "Derivative of interpolated 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
      input Integer icol;
      input Real timeIn;
      discrete input Real nextTimeEvent;
      discrete input Real pre_nextTimeEvent;
      input Real der_timeIn;
      output Real der_y;
      external"C" der_y = ModelicaStandardTables_CombiTimeTable_getDerValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDerTimeTableValue;

    function getTimeTableTmin
      "Return minimum abscissa value of 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
      output Real timeMin "Minimum abscissa value in table";
      external"C" timeMin = ModelicaStandardTables_CombiTimeTable_minimumTime(tableID)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTimeTableTmin;

    function getTimeTableTmax
      "Return maximum abscissa value of 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
      output Real timeMax "Maximum abscissa value in table";
      external"C" timeMax = ModelicaStandardTables_CombiTimeTable_maximumTime(tableID)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTimeTableTmax;

    function readTable1DData "Read table data from text or MATLAB MAT-file"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
      input Boolean forceRead = false
        "= true: Force reading of table data; = false: Only read, if not yet read.";
      input Boolean verboseRead = true
        "= true: Print info message; = false: No info message";
      output Real readSuccess "Table read success";
      external"C" readSuccess = ModelicaStandardTables_CombiTable1D_read(tableID, forceRead, verboseRead)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation(__ModelicaAssociation_Impure=true);
    end readTable1DData;

    function getNextTimeEvent
      "Return next time event value of 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
      input Real timeIn;
      output Real nextTimeEvent "Next time event in table";
      external"C" nextTimeEvent = ModelicaStandardTables_CombiTimeTable_nextTimeEvent(tableID, timeIn)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getNextTimeEvent;

    function getTable1DValue "Interpolate 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
      input Integer icol;
      input Real u;
      output Real y;
      external"C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative = getDerTable1DValue);
    end getTable1DValue;

    function getTable1DValueNoDer
      "Interpolate 1-dim. table defined by matrix (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
      input Integer icol;
      input Real u;
      output Real y;
      external"C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable1DValueNoDer;

    function getDerTable1DValue
      "Derivative of interpolated 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
      input Integer icol;
      input Real u;
      input Real der_u;
      output Real der_y;
      external"C" der_y = ModelicaStandardTables_CombiTable1D_getDerValue(tableID, icol, u, der_u)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDerTable1DValue;

    function getTable1DAbscissaUmin
      "Return minimum abscissa value of 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
      output Real uMin "Minimum abscissa value in table";
      external"C" uMin = ModelicaStandardTables_CombiTable1D_minimumAbscissa(tableID)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable1DAbscissaUmin;

    function getTable1DAbscissaUmax
      "Return maximum abscissa value of 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
      output Real uMax "Maximum abscissa value in table";
      external"C" uMax = ModelicaStandardTables_CombiTable1D_maximumAbscissa(tableID)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable1DAbscissaUmax;

    function readTable2DData "Read table data from text or MATLAB MAT-file"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
      input Boolean forceRead = false
        "= true: Force reading of table data; = false: Only read, if not yet read.";
      input Boolean verboseRead = true
        "= true: Print info message; = false: No info message";
      output Real readSuccess "Table read success";
      external"C" readSuccess = ModelicaStandardTables_CombiTable2D_read(tableID, forceRead, verboseRead)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation(__ModelicaAssociation_Impure=true);
    end readTable2DData;

    function getTable2DValue "Interpolate 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
      input Real u1;
      input Real u2;
      output Real y;
      external"C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative = getDerTable2DValue);
    end getTable2DValue;

    function getTable2DValueNoDer
      "Interpolate 2-dim. table defined by matrix (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
      input Real u1;
      input Real u2;
      output Real y;
      external"C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable2DValueNoDer;

    function getDerTable2DValue
      "Derivative of interpolated 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
      input Real u1;
      input Real u2;
      input Real der_u1;
      input Real der_u2;
      output Real der_y;
      external"C" der_y = ModelicaStandardTables_CombiTable2D_getDerValue(tableID, u1, u2, der_u1, der_u2)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDerTable2DValue;

    function getTable2DAbscissaUmin
      "Return minimum abscissa value of 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
      output Real uMin[2] "Minimum abscissa value in table";
      external"C" ModelicaStandardTables_CombiTable2D_minimumAbscissa(tableID, uMin)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable2DAbscissaUmin;

    function getTable2DAbscissaUmax
      "Return maximum abscissa value of 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
      output Real uMax[2] "Maximum abscissa value in table";
      external"C" ModelicaStandardTables_CombiTable2D_maximumAbscissa(tableID, uMax)
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
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
<p>A possible (though a bit &quot;hackish&quot;) Modelica standard conformant approach is to pull in the required files by utilizing a &quot;dummy&quot;-function that uses the Modelica external function
interface to pull in the required &quot;usertab.c&quot;. An example how this can be done is given below.</p>
<pre>
model Test25_usertab \"Test utilizing the usertab.c interface\"
  extends Modelica.Icons.Example;
public
  Modelica.Blocks.Sources.RealExpression realExpression(y=getUsertab(t_new.y))
    annotation (Placement(transformation(extent={{-40,-34},{-10,-14}})));
  Modelica.Blocks.Tables.CombiTable1D t_new(tableOnFile=true, tableName=\"TestTable_1D_a\")
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.Clock clock
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
protected
  encapsulated function getUsertab
    input Real dummy_u[:];
    output Real dummy_y;
    external \"C\" dummy_y=  mydummyfunc(dummy_u);
    annotation(IncludeDirectory=\"modelica://Modelica/Resources/Data/Tables\",
           Include = \"#include \"usertab.c\"
double mydummyfunc(double* dummy_in) {
   return 0;
}
\");
  end getUsertab;
equation
  connect(clock.y,t_new. u[1]) annotation (Line(
      points={{-59,10},{-42,10}}, color={0,0,127}));
  annotation (experiment(StartTime=0, StopTime=5), uses(Modelica(version=\"3.2.2\")));
end Test25_usertab;
</pre>
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
