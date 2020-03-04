within Modelica.Blocks.Sources;
block ExpSine "Generate exponentially damped sine signal"
  import Modelica.Constants.pi;
  parameter Real amplitude=1 "Amplitude of sine wave"
  annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/ExpSine.png"));
  parameter SI.Frequency f(start=2) "Frequency of sine wave";
  parameter SI.Angle phase=0 "Phase of sine wave";
  parameter SI.Damping damping(start=1)
    "Damping coefficient of sine wave";
  extends Interfaces.SignalSource;
equation
  y = offset + (if time < startTime then 0 else amplitude*Modelica.Math.exp(-
    (time - startTime)*damping)*Modelica.Math.sin(2*pi*f*(time -
    startTime) + phase));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,0},{-75.2,32.3},{-72,50.3},{-68.7,64.5},{-65.5,74.2},
              {-62.3,79.3},{-59.1,79.6},{-55.9,75.3},{-52.7,67.1},{-48.6,52.2},
              {-43,25.8},{-35,-13.9},{-30.2,-33.7},{-26.1,-45.9},{-22.1,-53.2},
              {-18.1,-55.3},{-14.1,-52.5},{-10.1,-45.3},{-5.23,-32.1},{8.44,
              13.7},{13.3,26.4},{18.1,34.8},{22.1,38},{26.9,37.2},{31.8,31.8},
              {38.2,19.4},{51.1,-10.5},{57.5,-21.2},{63.1,-25.9},{68.7,-25.9},
              {75.2,-20.5},{80,-13.8}}, smooth = Smooth.Bezier),
        Text(
          extent={{-147,-152},{153,-112}},
          textString="f=%f")}),
    Documentation(info="<html>
<p>
The Real output y is a sine signal with exponentially changing amplitude:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/ExpSine.png\"
     alt=\"ExpSine.png\">
</p>
</html>"));
end ExpSine;
