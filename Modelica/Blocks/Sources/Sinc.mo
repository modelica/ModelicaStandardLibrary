within Modelica.Blocks.Sources;
block Sinc "Generate sinc signal"
  import Modelica.Constants.pi;
  import Modelica.Constants.eps;
  parameter Real amplitude=1 "Amplitude of sine wave"
  annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Sinc.png"));
  parameter SI.Frequency f(start=1) "Frequency of sine wave";
  extends Interfaces.SignalSource;
protected
  SI.Angle x=2*pi*f*(time - startTime);
equation
  y = offset + (if time < startTime then 0 else amplitude*
    (if noEvent(time - startTime)<eps then 1 else (sin(x))/x));
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
        Text(
          extent={{-147,-152},{153,-112}},
          textString="f=%f",
          textColor={0,0,0}),
    Line(points={
      {-80, 80.0},{-76, 78.7},{-72, 74.8},{-68, 68.7},{-64, 60.5},
      {-60, 50.9},{-56, 40.4},{-52, 29.4},{-48, 18.7},{-44,  8.7},
      {-40,  0.0},{-36, -7.2},{-32,-12.5},{-28,-15.8},{-24,-17.3},
      {-20,-17.0},{-16,-15.1},{-12,-12.1},{ -8, -8.3},{ -4, -4.1},
      {  0,  0.0},{  4,  3.7},{  8,  6.8},{ 12,  9.0},{ 16, 10.1},
      { 20, 10.2},{ 24,  9.3},{ 28,  7.6},{ 32,  5.3},{ 36,  2.7},
      { 40,  0.0},{ 44, -2.5},{ 48, -4.7},{ 52, -6.2},{ 56, -7.1},
      { 60, -7.3},{ 64, -6.7},{ 68, -5.6},{ 72, -3.9},{ 76, -2.0},
      { 80,  0.0}}, smooth = Smooth.Bezier)}),
    Documentation(info="<html>
<p>
The Real output y is a sinc signal: <code> amplitude*(sin(2*&pi;*f*t))/((2*&pi;*f*t))</code>
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Sinc.png\"
     alt=\"Sinc.png\">
</p>
</html>"));
end Sinc;
