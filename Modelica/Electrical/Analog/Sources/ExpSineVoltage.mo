within Modelica.Electrical.Analog.Sources;
model ExpSineVoltage "Exponentially damped sine voltage source"
  parameter SI.Voltage V(start=1) "Amplitude of sine wave";
  parameter SI.Frequency f(start=2) "Frequency of sine wave";
  parameter SI.Angle phase=0 "Phase of sine wave";
  parameter SI.Damping damping(start=1) "Damping coefficient of sine wave";
  extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.ExpSine
      signalSource(
      final amplitude=V,
      final f=f,
      final phase=phase,
      final damping=damping));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Line(points={{-64,-14},{-59.2,18.3},{-56,36.3},
              {-52.7,50.5},{-49.5,60.2},{-46.3,65.3},{-43.1,65.6},{-39.9,61.3},
              {-36.7,53.1},{-32.6,38.2},{-27,11.8},{-19,-27.9},{-14.2,-47.7},
              {-10.1,-59.9},{-6.1,-67.2},{-2.1,-69.3},{1.9,-66.5},{5.9,-59.3},
              {10.77,-46.1},{24.44,-0.3},{29.3,12.4},{34.1,20.8},{38.1,24},{
              42.9,23.2},{47.8,17.8},{54.2,5.4},{67.1,-24.5},{73.5,-35.2},{
              79.1,-39.9},{84.7,-39.9},{91.2,-34.5},{96,-27.8}}, color={192,
              192,192})}),
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
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/ExpSineVoltage.png\"
     alt=\"ExpSineVoltage.png\">
</div>
</html>"));
end ExpSineVoltage;
