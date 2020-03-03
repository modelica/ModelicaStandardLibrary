within Modelica.Blocks.Sources;
block IntegerTable
  "Generate an Integer output signal based on a table matrix with [time, yi] values"

  parameter Real table[:, 2]=fill(0,0,2) "Table matrix (first column: time; second column: y)" annotation(Dialog(group="Table data definition"));
  parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint
    "Extrapolation of data outside the definition range" annotation(Dialog(group="Table data interpretation"));
  parameter SI.Time startTime=-Modelica.Constants.inf
    "Output = 0 for time < startTime" annotation(Dialog(group="Table data interpretation"));
  parameter SI.Time shiftTime=0
    "Shift time of first table column" annotation(Dialog(group="Table data interpretation"));

  extends Interfaces.IntegerSO;

  CombiTimeTable combiTimeTable(
    final table=table,
    final smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    final columns={2},
    final extrapolation=extrapolation,
    final startTime=startTime,
    final shiftTime=shiftTime) annotation(Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Math.RealToInteger realToInteger annotation(Placement(transformation(extent={{10,-10},{30,10}})));

protected
    function isValidTable "Check if table is valid"
      extends Modelica.Icons.Function;
      input Real table[:, 2] "Table matrix";
  protected
      SI.Time t_last;
      Integer n=size(table, 1) "Number of table points";
    algorithm
      if n > 0 then
        // Check whether time values are strict monotonically increasing
        t_last := table[1, 1];
        for i in 2:n loop
          assert(table[i, 1] > t_last,
            "Time values of table not strict monotonically increasing: table["
             + String(i - 1) + ",1] = " + String(table[i - 1, 1]) + "table[" +
            String(i) + ",1] = " + String(table[i, 1]));
        end for;

        // Check that all values in the second column are Integer values
        for i in 1:n loop
          assert(rem(table[i, 2], 1) == 0.0,
            "Table value is not an Integer: table[" + String(i) + ",2] = " +
            String(table[i, 2]));
        end for;
      end if;
    end isValidTable;

    parameter Integer n=size(table, 1) "Number of table points";
initial algorithm
    isValidTable(table);
equation
    assert(n > 0, "No table values defined.");
    assert(extrapolation <> Modelica.Blocks.Types.Extrapolation.LastTwoPoints, "Unsuitable extrapolation setting.");
    connect(combiTimeTable.y[1], realToInteger.u) annotation(Line(points={{-9,0},{8,0}}, color={0,0,127}));
    connect(realToInteger.y, y) annotation(Line(points={{31,0},{110,0},{110,0}}, color={255,127,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-80,64},{-80,-84}}, color={192,192,192}),
        Polygon(
          points={{-80,86},{-88,64},{-72,64},{-80,86}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-74},{82,-74}}, color={192,192,192}),
        Polygon(
          points={{90,-74},{68,-66},{68,-82},{90,-74}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-46,68},{4,-52}},
          lineColor={255,255,255},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-46,-52},{-46,68},{54,68},{54,-52},{-46,-52},{-46,-22},
              {54,-22},{54,8},{-46,8},{-46,38},{54,38},{54,68},{4,68},{4,-53}})}),
    Documentation(info="<html>

<p>
This block generates an Integer output signal by using a table.
The time points and y-values are stored in a matrix
<strong>table[i,j]</strong>, where the first column table[:,1] contains the
Real time points and the second column contains the Integer value of the
output y at this time point.
The table interpolation has the following properties:
</p>

<ul>
<li>An assert is triggered, if no table values are provided, if the
    time points are not strict monotonically increasing, or if
    the second column of the table matrix does not contain Integer values.</li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last value of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (This setting is not suitable and triggers an assert.)
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and
    the table values of this row are just returned.</li>
<li>Via parameter <strong>shiftTime</strong> the curve defined by the table can be shifted
    in time.
    The time instants stored in the table are therefore <strong>relative</strong>
    to <strong>shiftTime</strong>.</li>
<li>If time &lt; startTime, no interpolation is performed and zero
    is used as ordinate value for the output.</li>
</ul>

<p>
Example:
</p>
<blockquote><pre>
table = [  0, 1;
           1, 4;
         1.5, 5;
           2, 6];
</pre></blockquote>
<p>
results in the following output:
</p>

<blockquote><p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/IntegerTable.png\"
     alt=\"IntegerTable.png\">
</p></blockquote>

</html>"));
end IntegerTable;
