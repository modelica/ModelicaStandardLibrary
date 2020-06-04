within Modelica.Electrical.Analog.Sources;
model SawToothCurrent "Saw tooth current source"
  parameter SI.Current I(start=1) "Amplitude of saw tooth";
  parameter SI.Time period(start=1) "Time for one period";
  extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.SawTooth
      signalSource(final amplitude=I, final period=period));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Line(points={{-70,-71},{-50,-71},{10,70},{10,-71},
              {70,70},{70,-71}}, color={192,192,192})}),
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
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/SawToothCurrent.png\"
     alt=\"SawToothCurrent.png\">
</div>
</html>"));
end SawToothCurrent;
