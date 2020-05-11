within Modelica.Electrical.Analog.Sources;
model SineVoltage "Sine voltage source"
  parameter SI.Voltage V(start=1) "Amplitude of sine wave";
  parameter SI.Angle phase=0 "Phase of sine wave";
  parameter SI.Frequency f(start=1) "Frequency of sine wave";
  extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Sine
      signalSource(
      final amplitude=V,
      final f=f,
      final phase=phase));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Line(points={{-66,0},{-56.2,29.9},{-49.8,46.5},
              {-44.2,58.1},{-39.3,65.2},{-34.3,69.2},{-29.4,69.8},{-24.5,67},
              {-19.6,61},{-14.6,52},{-9,38.6},{-1.98,18.6},{12.79,-26.9},{
              19.1,-44},{24.8,-56.2},{29.7,-64},{34.6,-68.6},{39.5,-70},{44.5,
              -67.9},{49.4,-62.5},{54.3,-54.1},{59.9,-41.3},{67,-21.7},{74,0}},
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
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/SineVoltage.png\"
     alt=\"SineVoltage.png\">
</div>
</html>"));

end SineVoltage;
