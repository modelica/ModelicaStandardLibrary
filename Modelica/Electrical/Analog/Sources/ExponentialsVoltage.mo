within Modelica.Electrical.Analog.Sources;
model ExponentialsVoltage "Rising and falling exponential voltage source"
  parameter Real vMax(start=1) "Upper bound for rising edge";
  parameter SI.Time riseTime(min=0, start=0.5) "Rise time";
  parameter SI.Time riseTimeConst(min=Modelica.Constants.small, start=0.1)
    "Rise time constant";
  parameter SI.Time fallTimeConst(min=Modelica.Constants.small, start=
        riseTimeConst) "Fall time constant";
  extends Interfaces.VoltageSource(redeclare
      Modelica.Blocks.Sources.Exponentials signalSource(
      final outMax=vMax,
      final riseTime=riseTime,
      final riseTimeConst=riseTimeConst,
      final fallTimeConst=fallTimeConst));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Line(points={{-76,-59},{-73.2,-44.3},{-70.3,-31.1},
              {-66.8,-16.6},{-63.3,-4},{-59.7,6.92},{-55.5,18.18},{-51.3,27.7},
              {-46.3,37},{-40.6,45.5},{-34.3,53.1},{-27.2,59.6},{-18.7,65.3},
              {-8.1,70.2},{-6,71},{-3.88,58.5},{-1.05,43.7},{1.78,30.8},{
              4.606,19.45},{8.14,7.3},{11.68,-3},{15.9,-13.2},{20.2,-21.6},{
              25.1,-29.5},{30.8,-36.4},{37.1,-42.3},{44.9,-47.5},{54.8,-51.8},
              {64,-54.4}}, color={192,192,192})}),
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
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/ExponentialsVoltage.png\"
     alt=\"ExponentialsVoltage.png\">
</div>
</html>"));
end ExponentialsVoltage;
