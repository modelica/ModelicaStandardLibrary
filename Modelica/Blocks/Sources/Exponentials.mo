within Modelica.Blocks.Sources;
block Exponentials "Generate a rising and falling exponential signal"

  parameter Real outMax=1 "Height of output for infinite riseTime"
  annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Exponentials.png"));
  parameter SI.Time riseTime(min=0,start=0.5) "Rise time";
  parameter SI.Time riseTimeConst(min=Modelica.Constants.small) = 0.1
    "Rise time constant; rising is defined as outMax*(1-exp(-riseTime/riseTimeConst))";
  parameter SI.Time fallTimeConst(min=Modelica.Constants.small)=
    riseTimeConst "Fall time constant";
  extends Interfaces.SignalSource;
protected
  Real y_riseTime;

equation
  y_riseTime = outMax*(1 - Modelica.Math.exp(-riseTime/riseTimeConst));
  y = offset + (if (time < startTime) then 0 else if (time < (startTime +
    riseTime)) then outMax*(1 - Modelica.Math.exp(-(time - startTime)/
    riseTimeConst)) else y_riseTime*Modelica.Math.exp(-(time - startTime -
    riseTime)/fallTimeConst));

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,-70},{68,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-70},{-77.2,-55.3},{-74.3,-42.1},{-70.8,-27.6},{-67.3,
              -15},{-63.7,-4.08},{-59.5,7.18},{-55.3,16.7},{-50.3,26},{-44.6,
              34.5},{-38.3,42.1},{-31.2,48.6},{-22.7,54.3},{-12.1,59.2},{-10,
              60},{-7.88,47.5},{-5.05,32.7},{-2.22,19.8},{0.606,8.45},{4.14,-3.7},
              {7.68,-14},{11.9,-24.2},{16.2,-32.6},{21.1,-40.5},{26.8,-47.4},
              {33.1,-53.3},{40.9,-58.5},{50.8,-62.8},{60,-65.4}}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Text(
          extent={{-150,-150},{150,-110}},
          textString="riseTime=%riseTime")}),
    Documentation(info="<html>
<p>
The Real output y is a rising exponential followed
by a falling exponential signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Exponentials.png\"
     alt=\"Exponentials.png\">
</p>
</html>"));
end Exponentials;
