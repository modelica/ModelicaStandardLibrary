within Modelica.Blocks.Tables;
block CombiTable2Dv "Table look-up in two dimensions (matrix/file) with vector inputs and vector output of size n"
  extends Modelica.Blocks.Interfaces.MI2MO;
  extends Internal.CombiTable2DBase;
equation
  if verboseExtrapolation and (
    extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or
    extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
    for j in 1:n loop
      assert(noEvent(u1[j] >= u_min[1]), "
Extrapolation warning: The value u1["
                                    + String(j) + "] (=" + String(u1[j]) + ") must be greater or equal
than the minimum abscissa value u_min[1] (="
                                           + String(u_min[1]) + ") defined in the table.
",
 level=AssertionLevel.warning);
      assert(noEvent(u1[j] <= u_max[1]), "
Extrapolation warning: The value u1["
                                    + String(j) + "] (=" + String(u1[j]) + ") must be less or equal
than the maximum abscissa value u_max[1] (="
                                           + String(u_max[1]) + ") defined in the table.
",
 level=AssertionLevel.warning);
      assert(noEvent(u2[j] >= u_min[2]), "
Extrapolation warning: The value u2["
                                    + String(j) + "] (=" + String(u2[j]) + ") must be greater or equal
than the minimum abscissa value u_min[2] (="
                                           + String(u_min[2]) + ") defined in the table.
",
 level=AssertionLevel.warning);
      assert(noEvent(u2[j] <= u_max[2]), "
Extrapolation warning: The value u2["
                                    + String(j) + "] (=" + String(u2[j]) + ") must be less or equal
than the maximum abscissa value u_max[2] (="
                                           + String(u_max[2]) + ") defined in the table.
",
 level=AssertionLevel.warning);
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
    \"tableName\". Both text and MATLAB MAT-file format is possible.
    (The text format is described below).
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
