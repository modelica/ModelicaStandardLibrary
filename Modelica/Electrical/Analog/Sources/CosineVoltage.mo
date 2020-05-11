within Modelica.Electrical.Analog.Sources;
model CosineVoltage "Cosine voltage source"
  parameter SI.Voltage V(start=1) "Amplitude of cosine wave";
  parameter SI.Angle phase=0 "Phase of cosine wave";
  parameter SI.Frequency f(start=1) "Frequency of cosine wave";
  extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Cosine
      signalSource(
      final amplitude=V,
      final f=f,
      final phase=phase));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Line(
          points={{-71,70},{-68.4,69.8},{-63.5,67},{-58.6,61},{-53.6,52},{-48,
              38.6},{-40.98,18.6},{-26.21,-26.9},{-19.9,-44},{-14.2,-56.2},{-9.3,
              -64},{-4.4,-68.6},{0.5,-70},{5.5,-67.9},{10.4,-62.5},{15.3,-54.1},
              {20.9,-41.3},{28,-21.7},{35,0}},
          color={192,192,192},
          smooth=Smooth.Bezier), Line(points={{35,0},{44.8,29.9},{51.2,46.5},
              {56.8,58.1},{61.7,65.2},{66.7,69.2},{71.6,69.8}}, color={192,
              192,192})}),
    Documentation(revisions="<html>
<ul>
<li>Initially implemented by Christian Kral on 2013-05-14</li>
</ul>
</html>",
        info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/CosineVoltage.png\"
     alt=\"CosineVoltage.png\">
</div>
</html>"));

end CosineVoltage;
