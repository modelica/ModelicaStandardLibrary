within Modelica.Electrical.Analog.Sources;
model ExpSineCurrent "Exponentially damped sine current source"
  parameter Real I(start=1) "Amplitude of sine wave";
  parameter SI.Frequency f(start=2) "Frequency of sine wave";
  parameter SI.Angle phase=0 "Phase of sine wave";
  parameter SI.Damping damping(start=1) "Damping coefficient of sine wave";
  extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.ExpSine
      signalSource(
      final amplitude=I,
      final f=f,
      final phase=phase,
      final damping=damping));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Line(points={{-80,-14},{-75.2,18.3},{-72,36.3},
              {-68.7,50.5},{-65.5,60.2},{-62.3,65.3},{-59.1,65.6},{-55.9,61.3},
              {-52.7,53.1},{-48.6,38.2},{-43,11.8},{-35,-27.9},{-30.2,-47.7},
              {-26.1,-59.9},{-22.1,-67.2},{-18.1,-69.3},{-14.1,-66.5},{-10.1,
              -59.3},{-5.23,-46.1},{8.44,-0.3},{13.3,12.4},{18.1,20.8},{22.1,
              24},{26.9,23.2},{31.8,17.8},{38.2,5.4},{51.1,-24.5},{57.5,-35.2},
              {63.1,-39.9},{68.7,-39.9},{75.2,-34.5},{80,-27.8}}, color={192,
              192,192})}),
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>This current source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/ExpSineCurrent.png\"
     alt=\"ExpSineCurrent.png\">
</div>
</html>"));
end ExpSineCurrent;
