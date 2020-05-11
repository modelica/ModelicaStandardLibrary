within Modelica.Electrical.Analog.Sources;
model StepCurrent "Step current source"
  parameter SI.Current I(start=1) "Height of step";
  extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Step
      signalSource(final height=I));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Line(points={{-86,-70},{-14,-70},{-14,70},{57,
              70}}, color={192,192,192})}),
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
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/StepCurrent.png\"
     alt=\"StepCurrent.png\">
</div>
</html>"));
end StepCurrent;
