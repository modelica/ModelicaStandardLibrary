within Modelica.Electrical.QuasiStationary.MultiPhase.Sensors;
model PowerSensor
  parameter Integer m(min=1) = 3 "number of phases";
  Modelica.SIunits.AngularVelocity omega = der(currentP.reference.gamma);
  Interfaces.PositivePlug currentP
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  Interfaces.NegativePlug currentN
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  Interfaces.PositivePlug voltageP
    annotation (Placement(transformation(extent={{-10,90},{10,110}}, rotation=0)));
  Interfaces.NegativePlug voltageN
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}, rotation=
           0)));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput y
    annotation (Placement(transformation(
        origin={-80,-110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.PlugToPins_p plugToPinsCurrentP(final m=m)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}}, rotation=
            0)));
  Basic.PlugToPins_p plugToPinsVoltageP(final m=m)
    annotation (Placement(transformation(
        origin={0,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.PlugToPins_n plugToPinsCurrentN(final m=m)
    annotation (Placement(transformation(extent={{80,-10},{60,10}}, rotation=0)));
  Basic.PlugToPins_n plugToPinsVoltageN(final m=m)
    annotation (Placement(transformation(
        origin={0,-70},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  SinglePhase.Sensors.PowerSensor powerSensor[m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
  Modelica.ComplexBlocks.ComplexMath.Sum sum(final nin=m)
    annotation (Placement(transformation(
        origin={-80,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(plugToPinsCurrentP.plug_p, currentP)
    annotation (Line(points={{-72,0},{-79,0},{-79,1.16573e-015},{-86,1.16573e-015},
          {-86,0},{-100,0}},
                          color={85,170,255}));
  connect(currentN, plugToPinsCurrentN.plug_n)
    annotation (Line(points={{100,0},{93,0},{93,1.16573e-015},{86,1.16573e-015},
          {86,0},{72,0}},
        color={85,170,255}));
  connect(voltageP, plugToPinsVoltageP.plug_p) annotation (Line(points={{0,100},
          {0,100},{0,72},{3.67394e-016,72}},                             color=
          {85,170,255}));
  connect(plugToPinsVoltageN.plug_n, voltageN) annotation (Line(points={{-1.22465e-016,
          -72},{0,-72},{0,-100}},                                    color={85,
          170,255}));
  connect(plugToPinsCurrentP.pin_p, powerSensor.currentP)
    annotation (Line(points={{-68,0},{-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},
          {-39,0},{-10,0}},
        color={85,170,255}));
  connect(powerSensor.currentN, plugToPinsCurrentN.pin_n)
    annotation (Line(points={{10,0},{24.5,0},{24.5,1.22125e-015},{39,1.22125e-015},
          {39,0},{68,0}},
        color={85,170,255}));
  connect(powerSensor.voltageP, plugToPinsVoltageP.pin_p) annotation (Line(
        points={{0,10},{0,10},{0,68},{-3.67394e-016,68}},
        color={85,170,255}));
  connect(powerSensor.voltageN, plugToPinsVoltageN.pin_n) annotation (Line(
        points={{0,-10},{0,-10},{0,-68},{1.22465e-016,-68}},
                 color={85,170,255}));
  connect(powerSensor.y, sum.u) annotation (Line(points={{-8,-11},{-8,-40},{-80,
          -40},{-80,-58}}, color={85,170,255}));
  connect(sum.y, y) annotation (Line(points={{-80,-81},{-80,-110}}, color={85,
          170,255}));
  connect(currentP, currentP) annotation (Line(points={{-100,0},{-100,0},{-100,0}},
                                                   color={85,170,255}));
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
This sensor can be used to measure <i>m</i> complex apparent power values, using <i>m</i>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">single phase PowerSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">SinglePhase.PowerSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>
</p>

</html>"));
end PowerSensor;
