within Modelica.Electrical.Analog.Sources;
model TableVoltage "Voltage source by linear interpolation in a table"
  parameter Real table[:, :]=[0, 0; 1, 1; 2, 4]
    "Table matrix (time = first column, voltage = second column)";
  extends Interfaces.VoltageSource(redeclare
      Modelica.Blocks.Sources.TimeTable signalSource(final table=table));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Line(points={{-58,-36},{-58,84},{42,84},{42,-36},
              {-58,-36},{-58,-6},{42,-6},{42,24},{-58,24},{-58,54},{42,54},{
              42,84},{-8,84},{-8,-37}}, color={192,192,192})}),
    Documentation(info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package.  Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<p><br>This block generates a voltage source by <strong>linear interpolation</strong> in a table. The time points and voltage values are stored in a matrix <strong>table[i,j]</strong>, where the first column table[:,1] contains the time points and the second column contains the voltage to be interpolated. The table interpolation has the following properties:</p>
<ul>
<li>The time points need to be <strong>monotonically increasing</strong>.</li>
<li><strong>Discontinuities</strong> are allowed, by providing the same time point twice in the table.</li>
<li>Values <strong>outside</strong> of the table range, are computed by <strong>extrapolation</strong> through the last or first two points of the table.</li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and the voltage value is just returned independently of the actual time instant, i.e., this is a constant voltage source.</li>
<li>Via parameters <strong>startTime</strong> and <strong>offset</strong> the curve defined by the table can be shifted both in time and in the voltage.</li>
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
If, e.g., time = 1.0, the voltage v =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the voltage v =  2.5,
    e.g., time = 2.0, the voltage v =  4.0,
    e.g., time = 5.0, the voltage v = 23.0 (i.e., extrapolation).
</pre></blockquote>
<p><br>  Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/TableVoltage.png\"
     alt=\"TableVoltage.png\">
</div>
</html>",
        revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
end TableVoltage;
