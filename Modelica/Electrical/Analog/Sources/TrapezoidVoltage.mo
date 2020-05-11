within Modelica.Electrical.Analog.Sources;
model TrapezoidVoltage "Trapezoidal voltage source"
  parameter SI.Voltage V(start=1) "Amplitude of trapezoid";
  parameter SI.Time rising(final min=0, start=0)
    "Rising duration of trapezoid";
  parameter SI.Time width(final min=0, start=0.5)
    "Width duration of trapezoid";
  parameter SI.Time falling(final min=0, start=0)
    "Falling duration of trapezoid";
  parameter SI.Time period(final min=Modelica.Constants.small, start=1)
    "Time for one period";
  parameter Integer nperiod(start=-1)
    "Number of periods (< 0 means infinite number of periods)";
  extends Interfaces.VoltageSource(redeclare
      Modelica.Blocks.Sources.Trapezoid signalSource(
      final amplitude=V,
      final rising=rising,
      final width=width,
      final falling=falling,
      final period=period,
      final nperiod=nperiod));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Line(points={{-81,-70},{-60,-70},{-30,70},{1,70},
              {30,-70},{51,-70},{80,70}}, color={192,192,192})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={         Line(
            points={{60,81},{60,-30}},
            color={192,192,192},
            pattern=LinePattern.Dash)}),
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/TrapezoidVoltage.png\"
     alt=\"TrapezoidVoltage.png\">
</div>
</html>"));
end TrapezoidVoltage;
