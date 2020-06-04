within Modelica.Electrical.Analog.Sources;
model PulseVoltage "Pulse voltage source"
  parameter SI.Voltage V(start=1) "Amplitude of pulse";
  parameter Real width(
    final min=Modelica.Constants.small,
    final max=100,
    start=50) "Width of pulse in % of period";
  parameter SI.Time period(final min=Modelica.Constants.small, start=1)
    "Time for one period";
  extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Pulse
      signalSource(
      final amplitude=V,
      final width=width,
      final period=period));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Line(points={{-70,-70},{-40,-70},{-40,70},{0,70},
              {0,-70},{40,-70},{40,70},{80,70}}, color={192,192,192})}),
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
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/PulseVoltage.png\"
     alt=\"PulseVoltage.png\">
</div>
</html>"));
end PulseVoltage;
