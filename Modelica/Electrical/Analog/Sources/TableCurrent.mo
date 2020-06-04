within Modelica.Electrical.Analog.Sources;
model TableCurrent "Current source by linear interpolation in a table"
  parameter Real table[:, :]=[0, 0; 1, 1; 2, 4]
    "Table matrix (time = first column, current = second column)";
  extends Interfaces.CurrentSource(redeclare
      Modelica.Blocks.Sources.TimeTable signalSource(final table=table));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Line(points={{-66,-36},{-66,84},{34,84},{34,-36},
              {-66,-36},{-66,-6},{34,-6},{34,24},{-66,24},{-66,54},{34,54},{
              34,84},{-16,84},{-16,-37}}, color={192,192,192})}),
    Documentation(info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p><br>This block generates a current source by <strong>linear interpolation</strong> in a table. The time points and current values are stored in a matrix <strong>table[i,j]</strong>, where the first column table[:,1] contains the time points and the second column contains the current to be interpolated. The table interpolation has the following properties:</p>
<ul>
<li>The time points need to be <strong>monotonically increasing</strong>.</li>
<li><strong>Discontinuities</strong> are allowed, by providing the same time point twice in the table.</li>
<li>Values <strong>outside</strong> of the table range, are computed by <strong>extrapolation</strong> through the last or first two points of the table.</li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and the current value is just returned independently of the actual time instant, i.e., this is a constant current source.</li>
<li>Via parameters <strong>startTime</strong> and <strong>offset</strong> the curve defined by the table can be shifted both in time and in the current.</li>
<li>The table is implemented in a numerically sound way by generating <strong>time events</strong> at interval boundaries.
    This generates continuously differentiable values for the integrator.</li>
</ul>
<p>Example:</p>
<blockquote><pre>
   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]
If, e.g., time = 1.0, the current i =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the current i =  2.5,
    e.g., time = 2.0, the current i =  4.0,
    e.g., time = 5.0, the current i = 23.0 (i.e., extrapolation).
</pre></blockquote>
<p><br> Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/TableCurrent.png\"
     alt=\"TableCurrent.png\">
</div>
</html>",
        revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
end TableCurrent;
