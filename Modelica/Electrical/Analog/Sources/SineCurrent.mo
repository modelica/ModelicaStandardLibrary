within Modelica.Electrical.Analog.Sources;
model SineCurrent "Sine current source"
  parameter SI.Current I(start=1) "Amplitude of sine wave";
  parameter SI.Angle phase=0 "Phase of sine wave";
  parameter SI.Frequency f(start=1) "Frequency of sine wave";
  extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Sine
      signalSource(
      final amplitude=I,
      final f=f,
      final phase=phase));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Line(points={{-70,0},{-60.2,29.9},{-53.8,46.5},
              {-48.2,58.1},{-43.3,65.2},{-38.3,69.2},{-33.4,69.8},{-28.5,67},
              {-23.6,61},{-18.6,52},{-13,38.6},{-5.98,18.6},{8.79,-26.9},{
              15.1,-44},{20.8,-56.2},{25.7,-64},{30.6,-68.6},{35.5,-70},{40.5,
              -67.9},{45.4,-62.5},{50.3,-54.1},{55.9,-41.3},{63,-21.7},{70,0}},
            color={192,192,192})}),
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
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/SineCurrent.png\"
     alt=\"SineCurrent.png\">
</div>
</html>"));

end SineCurrent;
