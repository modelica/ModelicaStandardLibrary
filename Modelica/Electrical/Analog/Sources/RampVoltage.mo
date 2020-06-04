within Modelica.Electrical.Analog.Sources;
model RampVoltage "Ramp voltage source"
  parameter SI.Voltage V(start=1) "Height of ramp";
  parameter SI.Time duration(min=Modelica.Constants.small, start=2)
    "Duration of ramp";
  extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Ramp
      signalSource(final height=V, final duration=duration));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Line(points={{-80,-60},{-50,-60},{50,60},{80,60}},
            color={192,192,192})}),
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
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/RampVoltage.png\"
     alt=\"RampVoltage.png\">
</div>
</html>"));
end RampVoltage;
