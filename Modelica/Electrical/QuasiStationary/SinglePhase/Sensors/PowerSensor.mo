within Modelica.Electrical.QuasiStationary.SinglePhase.Sensors;
model PowerSensor "Power sensor"
  import Modelica.ComplexMath.conj;
  QuasiStationary.SinglePhase.Interfaces.PositivePin currentP 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  QuasiStationary.SinglePhase.Interfaces.NegativePin currentN 
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  QuasiStationary.SinglePhase.Interfaces.PositivePin voltageP 
    annotation (Placement(transformation(extent={{-10,90},{10,110}}, rotation=0)));
  QuasiStationary.SinglePhase.Interfaces.NegativePin voltageN 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}, rotation=
           0)));
  output Modelica.SIunits.ComplexCurrent i;
  output Modelica.SIunits.ComplexVoltage v;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput y 
    annotation (Placement(transformation(
        origin={-80,-110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  Connections.branch(currentP.reference, currentN.reference);
  currentP.reference.gamma = currentN.reference.gamma;
  Connections.branch(voltageP.reference, voltageN.reference);
  voltageP.reference.gamma = voltageN.reference.gamma;
  currentP.i + currentN.i = Complex(0);
  currentP.v - currentN.v = Complex(0);
  i = currentP.i;
  voltageP.i + voltageN.i = Complex(0);
  voltageP.i = Complex(0);
  v = voltageP.v - voltageN.v;
//P + j*Q = v * conj(i);
  y = v*conj(i);
  annotation (Diagram(graphics),
                       Icon(graphics={
        Ellipse(
          extent={{-70,70},{70,-70}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,100},{0,70}}, color={0,0,255}),
        Line(points={{0,-70},{0,-100}}, color={0,0,255}),
        Line(points={{-100,0},{100,0}}, color={0,0,255}),
        Line(points={{0,70},{0,40}}, color={0,0,0}),
        Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
        Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),
        Line(points={{37.6,13.7},{65.8,23.9}}, color={0,0,0}),
        Line(points={{-37.6,13.7},{-65.8,23.9}}, color={0,0,0}),
        Line(points={{0,0},{9.02,28.6}}, color={0,0,0}),
        Polygon(
          points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-5,5},{5,-5}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-29,-11},{30,-70}},
          lineColor={0,0,0},
          textString=
               "P"),
        Line(points={{-80,-100},{-80,0}}, color={85,170,255})}),
  Documentation(info="<html>

<p>
This sensor can be used to measure the complex apparent power.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
</p>

</html>"));
end PowerSensor;
