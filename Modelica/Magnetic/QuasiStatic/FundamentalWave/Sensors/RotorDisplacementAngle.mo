within Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors;
model RotorDisplacementAngle "Rotor lagging angle"
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter Integer p(min=1) "Number of pole pairs";
  parameter Boolean positiveRange=false "Use only positive output range, if true";
  parameter Boolean useSupport=false "Use support or fixed housing"
    annotation (Evaluate=true);
  Modelica.Blocks.Interfaces.RealOutput rotorDisplacementAngle(final
      quantity="Angle", final unit="rad") annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug
                                                         plug_p(final m=m)
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug
                                                         plug_n(final m=m)
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation (
      Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Mechanics.Rotational.Sensors.RelAngleSensor relativeAngleSensor
    annotation (Placement(transformation(extent={{40,70},{20,90}})));
  Modelica.Blocks.Sources.Constant constant_(final k=Modelica.Constants.pi/
        2) annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Blocks.Math.Add add(final k2=1, final k1=p) annotation (
      Placement(transformation(
        origin={-10,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support if useSupport
    "Support at which the reaction torque is acting" annotation (Placement(
        transformation(extent={{90,90},{110,110}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed if (not useSupport)
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.ReferenceSensor
    referenceSensor(final m=m)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageSensor
    voltageSensor(final m=m) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-90,-20})));
  Modelica.Blocks.Math.Add3 add3_1(k1=-1)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Blocks.ToSpacePhasor
    toSpacePhasor(m=m)
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.ToPolar toPolar
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Blocks.Math.WrapAngle wrapAngle(final positiveRange=positiveRange)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(relativeAngleSensor.flange_b, flange)
    annotation (Line(points={{20,80},{0,80},{0,100}}));
  connect(relativeAngleSensor.flange_a, support) annotation (Line(
      points={{40,80},{60,80},{60,100},{100,100}}));
  connect(relativeAngleSensor.flange_a, fixed.flange) annotation (Line(
      points={{40,80},{100,80}}));
  connect(relativeAngleSensor.phi_rel, add.u1) annotation (Line(
      points={{30,69},{30,50},{-4,50},{-4,42}}, color={85,170,255}));
  connect(constant_.y, add.u2) annotation (Line(
      points={{-29,50},{-16,50},{-16,42}}, color={85,170,255}));
  connect(plug_p, referenceSensor.plug_p) annotation (Line(points={{-100,60},
          {-100,60},{-90,60},{-90,20},{-80,20}}, color={85,170,255}));
  connect(voltageSensor.plug_p, plug_p) annotation (Line(points={{-90,-10},{
          -90,-10},{-90,60},{-100,60}}, color={85,170,255}));
  connect(voltageSensor.plug_n, plug_n) annotation (Line(points={{-90,-30},{
          -90,-60},{-100,-60}}, color={85,170,255}));
  connect(referenceSensor.gamma, add3_1.u2) annotation (Line(points={{-59,20},{-30,20},{-30,0},{-2,0}}, color={85,170,255}));
  connect(add.y, add3_1.u1)
    annotation (Line(points={{-10,19},{-10,8},{-2,8}}, color={85,170,255}));
  connect(toSpacePhasor.u,voltageSensor.v)  annotation (Line(points={{-72,-20},
          {-70,-20},{-79,-20}}, color={85,170,255}));
  connect(toSpacePhasor.y, toPolar.u)
    annotation (Line(points={{-49,-20},{-42,-20}}, color={85,170,255}));
  connect(toPolar.y[2], add3_1.u3) annotation (Line(points={{-19,-20},{-14,
          -20},{-10,-20},{-10,-8},{-2,-8}}, color={85,170,255}));
  connect(add3_1.y, wrapAngle.u)
    annotation (Line(points={{21,0},{29.5,0},{38,0}}, color={85,170,255}));
  connect(wrapAngle.y, rotorDisplacementAngle) annotation (Line(points={{61,
          0},{80,0},{80,0},{110,0}}, color={85,170,255}));
  annotation (defaultComponentName="angleSensor",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Ellipse(
              extent={{-60,80},{60,40}},
              lineColor={0,255,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Ellipse(
              extent={{-60,-40},{60,-80}},
              lineColor={0,255,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{-60,60},{60,40}},
              lineColor={0,255,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{-60,-40},{60,-60}},
              lineColor={0,255,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={0,255,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{0,0},{-80,80}},
          color={0,0,255}),Polygon(
              points={{-80,80},{-68,76},{-76,68},{-80,80}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{0,0},{0,80}},
          color={0,255,0}),Polygon(
              points={{0,84},{4,72},{-4,72},{0,84}},
              lineColor={0,255,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Rectangle(
              extent={{80,120},{120,80}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),Line(
              visible=not useSupport,
              points={{80,100},{120,100}}),Line(
              visible=not useSupport,
              points={{90,120},{80,100}}),Line(
              visible=not useSupport,
              points={{100,120},{90,100}}),Line(
              visible=not useSupport,
              points={{110,120},{100,100}}),Line(
              visible=not useSupport,
              points={{120,120},{110,100}}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="rad")}),
    Documentation(info="<html>
<p>
Calculates rotor lagging angle by measuring the stator phase voltages, transforming them to the corresponding space phasor in stator-fixed coordinate system,
rotating the space phasor to the rotor-fixed coordinate system and calculating the angle of this space phasor.</p>
<p>
The sensor's housing can be implicitly fixed (<code>useSupport=false</code>).
If the machine's stator also implicitly fixed (<code>useSupport=false</code>), the angle at the flange
is equal to the angle of the machine's rotor against the stator.
Otherwise, the sensor's support has to be connected to the machine's support.
</p>
</html>"));
end RotorDisplacementAngle;
