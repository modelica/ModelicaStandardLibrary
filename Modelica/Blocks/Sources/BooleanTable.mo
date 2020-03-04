within Modelica.Blocks.Sources;
block BooleanTable
  "Generate a Boolean output signal based on a vector of time instants"

  parameter SI.Time table[:]={0,1}
    "Vector of time points. At every time point, the output y gets its opposite value (e.g., table={0,1})" annotation(Dialog(group="Table data definition"));
  parameter Boolean startValue=false
    "Start value of y. At time = table[1], y changes to 'not startValue'" annotation(Dialog(group="Table data interpretation",
    groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/BooleanTable.png"));
  parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint
    "Extrapolation of data outside the definition range" annotation(Dialog(group="Table data interpretation"));
  parameter SI.Time startTime=-Modelica.Constants.inf
    "Output = false for time < startTime" annotation(Dialog(group="Table data interpretation"));
  parameter SI.Time shiftTime=0
    "Shift time of table" annotation(Dialog(group="Table data interpretation"));

  extends Interfaces.partialBooleanSO;

  CombiTimeTable combiTimeTable(
    final table=if n > 0 then if startValue then [table[1], 1.0; table, {mod(i + 1, 2.0) for i in 1:n}] else [table[1], 0.0; table, {mod(i, 2.0) for i in 1:n}] else if startValue then [0.0, 1.0] else [0.0, 0.0],
    final smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    final columns={2},
    final extrapolation=extrapolation,
    final startTime=startTime,
    final shiftTime=shiftTime) annotation(Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean annotation(Placement(transformation(extent={{10,-10},{30,10}})));

protected
    function isValidTable "Check if table is valid"
      extends Modelica.Icons.Function;
      input Real table[:] "Vector of time instants";
  protected
      Integer n=size(table, 1) "Number of table points";
    algorithm
      if n > 0 then
        // Check whether time values are strict monotonically increasing
        for i in 2:n loop
          assert(table[i] > table[i-1],
            "Time values of table not strict monotonically increasing: table["
             + String(i - 1) + "] = " + String(table[i - 1]) + ", table[" +
            String(i) + "] = " + String(table[i]));
        end for;
      end if;
    end isValidTable;

    parameter Integer n=size(table, 1) "Number of table points";
initial algorithm
    isValidTable(table);
equation
    assert(extrapolation <> Modelica.Blocks.Types.Extrapolation.LastTwoPoints, "Unsuitable extrapolation setting.");
    connect(combiTimeTable.y[1], realToBoolean.u) annotation(Line(points={{-9,0},{8,0}}, color={0,0,127}));
    connect(realToBoolean.y, y) annotation(Line(points={{31,0},{110,0},{110,0}}, color={255,127,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Polygon(
          points={{-80,88},{-88,66},{-72,66},{-80,88}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,66},{-80,-82}}, color={255,0,255}),
        Line(points={{-90,-70},{72,-70}}, color={255,0,255}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-18,70},{32,-50}},
          lineColor={255,255,255},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid), Line(points={{-18,-50},{-18,70},{32,
              70},{32,-50},{-18,-50},{-18,-20},{32,-20},{32,10},{-18,10},{-18,
              40},{32,40},{32,70},{32,70},{32,-51}})}),
    Documentation(info="<html>
<p>
The Boolean output y is a signal defined by parameter vector <strong>table</strong>.
In the vector time points are stored.
The table interpolation has the following properties:
</p>

<ul>
<li>At every time point, the output y
    changes its value to the negated value of the previous one.</li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the <strong>startValue</strong> or last value of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (This setting is not suitable and triggers an assert.)
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>Via parameter <strong>shiftTime</strong> the curve defined by the table can be shifted
    in time.
    The time instants stored in the table are therefore <strong>relative</strong>
    to <strong>shiftTime</strong>.</li>
<li>If time &lt; startTime, no interpolation is performed and <strong>false</strong>
    is used as ordinate value for the output.</li>
</ul>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanTable.png\"
     alt=\"BooleanTable.png\">
</p>

<p>
The precise semantics is:
</p>

<blockquote><pre>
<strong>if</strong> size(table,1) == 0 <strong>then</strong>
   y = startValue;
<strong>else</strong>
   //            time &lt; table[1]: y = startValue
   // table[1] &le; time &lt; table[2]: y = not startValue
   // table[2] &le; time &lt; table[3]: y = startValue
   // table[3] &le; time &lt; table[4]: y = not startValue
   // ...
<strong>end if</strong>;
</pre></blockquote>
</html>"));
end BooleanTable;
