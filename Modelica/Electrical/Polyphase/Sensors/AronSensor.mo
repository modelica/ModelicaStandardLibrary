within Modelica.Electrical.Polyphase.Sensors;
model AronSensor "Three-phase Aron sensor for active power"
  extends Modelica.Icons.RoundSensor;
  final parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput power(unit="W") "Active power" annotation (
      Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Basic.PlugToPins_p plugToPins_p(final m=m)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Basic.PlugToPins_n plugToPins_n(final m=m)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor1
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor3
    annotation (Placement(transformation(extent={{20,-30},{40,-50}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-70})));
equation
  connect(plug_p, plugToPins_p.plug_p)
    annotation (Line(points={{-100,0},{-72,0}}, color={0,0,255}));
  connect(plugToPins_n.plug_n, plug_n)
    annotation (Line(points={{72,0},{100,0}}, color={0,0,255}));
  connect(plugToPins_p.pin_p[1], powerSensor1.pc) annotation (Line(points={{-68,0},
          {-68,40},{-40,40}},            color={0,0,255}));
  connect(powerSensor1.pc, powerSensor1.pv)
    annotation (Line(points={{-40,40},{-40,50},{-30,50}}, color={0,0,255}));
  connect(powerSensor1.nc, plugToPins_n.pin_n[1]) annotation (Line(points={{-20,40},
          {68,40},{68,0}},            color={0,0,255}));
  connect(plugToPins_p.pin_p[2], plugToPins_n.pin_n[2])
    annotation (Line(points={{-68,0},{68,0}}, color={0,0,255}));
  connect(plugToPins_p.pin_p[3], powerSensor3.pc) annotation (Line(points={{-68,0},
          {-68,-40},{20,-40}},            color={0,0,255}));
  connect(powerSensor3.pc, powerSensor3.pv)
    annotation (Line(points={{20,-40},{20,-50},{30,-50}}, color={0,0,255}));
  connect(powerSensor3.nc, plugToPins_n.pin_n[3]) annotation (Line(points={{40,-40},
          {68,-40},{68,0}},        color={0,0,255}));
  connect(powerSensor1.nv, plugToPins_p.pin_p[2])
    annotation (Line(points={{-30,30},{-30,0},{-68,0}}, color={0,0,255}));
  connect(powerSensor3.nv, plugToPins_p.pin_p[2])
    annotation (Line(points={{30,-30},{30,0},{-68,0}}, color={0,0,255}));
  connect(add.y, power)
    annotation (Line(points={{0,-81},{0,-110}}, color={0,0,127}));
  connect(powerSensor1.power, add.u2) annotation (Line(points={{-40,29},{-40,-50},
          {-6,-50},{-6,-58}}, color={0,0,127}));
  connect(powerSensor3.power, add.u1) annotation (Line(points={{20,-29},{20,-20},
          {6,-20},{6,-58}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
                            Line(points={{100,0},{-100,0}}, color={0,0,255}),
                                       Line(points={{0,-100},
          {0,-70}}, color={0,0,127}),
        Text(
          extent={{150,-100},{-150,-70}},
          textString="m=%m"),
        Text(
          extent={{-150,80},{150,120}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="W")}),      Documentation(info="<html>
<p>Contains two <a href=\"modelica://Modelica.Electrical.Analog.Sensors.PowerSensor\">power meters</a> to measure total active power in a three-phase system.</p>
<p>This device works only in three-phase systems without neutral.</p>
<p>The rationale behind this sensor is that power exchanged between two parts of a circuit is the sum of the products of currents in the <em>m</em> wires connecting the two parts times wires&apos; potentials evaluated with reference to an arbitrary potential <em>v</em><sub>ref</sub>:</p>
<p><em>P</em>=(<em>v</em><sub>1</sub>-<em>v</em><sub>ref</sub>)*<em>i</em><sub>1</sub>+(<em>v</em><sub>2</sub>-<em>v</em><sub>ref</sub>)*<em>i</em><sub>2</sub>+&hellip;+(<em>v</em><sub>m</sub>-<em>v</em><sub>ref</sub>)*<em>i</em><sub>m</sub></p>
<p>In case of a three-phase system without neutral we may want to measure power flowing in a line, connecting, say, the left part of the circuit to its right part. The wires connecting the two parts are only three (i.e., <em>m</em>=3)
and therefore all currents between these two parts are <em>i</em><sub>1</sub>, <em>i</em><sub>2</sub>, <em>i</em><sub>3</sub>.&nbsp;</p>
<p>Since the voltage to be taken as reference is arbitrary, we can take the voltage of conductor 2. Therefore our power becomes:</p>
<p><em>P</em>=(<em>v</em><sub>1</sub>-<em>v</em><sub>2</sub>)*<em>i</em><sub>1</sub>+(<em>v</em><sub>2</sub>-<em>v</em><sub>2</sub>)*<em>i</em><sub>2</sub>+(<em>v</em><sub>3</sub>-<em>v</em><sub>2)</sub>*<em>i</em><sub>3 </sub>=
(<em>v</em><sub>1</sub>-<em>v</em><sub>2</sub>)*i<sub>1</sub>+(<em>v</em><sub>3</sub>-<em>v</em><sub>2</sub>)* i<sub>3</sub></p>
<p>In this way, we can just sum up the power from two wattmeters to get the three-phase power.</p>
<p>Note, that this formula does not work if there are additional current paths between the left and right parts of our circuits, e.g., if both have grounds (and current flows through it).</p>
<p>For more information on why power flowing in a circuit between two subcircuits is the sum of products of voltages times currents, the voltages being measured to an arbitrary reference potential, see
[<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.References\">Ceraolo2014</a>, par. 3.8.1].</p>
</html>"));
end AronSensor;
