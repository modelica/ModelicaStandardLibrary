within Modelica.Mechanics.Rotational.Examples;
model HeatLosses "Demonstrate the modeling of heat losses"
  extends Modelica.Icons.Example;
  Blocks.Sources.Sine sine(f=5, amplitude=20)
    annotation (Placement(transformation(extent={{-140,-10},{-120,10}})));
  Sources.Torque torque
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Components.Inertia inertia1(
    J=2,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Components.Damper damper(useHeatPort=true, d=10) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={-50,-20})));
  Components.Fixed fixed
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(extent={{0,-50},{20,-70}})));
  Thermal.HeatTransfer.Celsius.FixedTemperature TAmbient(T=25)
    "Ambient temperature"
    annotation (Placement(transformation(extent={{48,-70},{28,-50}})));
  Blocks.Sources.Constant const(k=20)
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  Components.SpringDamper springDamper(
    c=1e4,
    d=20,
    useHeatPort=true)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Components.Inertia inertia2(
    J=2,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Components.ElastoBacklash elastoBacklash(
    c=1e5,
    d=100,
    useHeatPort=true,
    b(displayUnit="rad") = 0.001)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Components.Inertia inertia3(
    J=2,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Components.BearingFriction bearingFriction(useHeatPort=true)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Components.Spring spring3(c=1e4)
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  Components.Inertia inertia4(
    J=2,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Components.LossyGear lossyGear(
    ratio=2,
    lossTable=[0, 0.8, 0.8, 1, 1; 1, 0.7, 0.7, 2, 2],
    useHeatPort=true)
    annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  Components.Clutch clutch(
    useHeatPort=true,
    fn_max=10,
    phi_rel(fixed=true),
    w_rel(fixed=true))
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Components.Inertia inertia5(J=2)
    annotation (Placement(transformation(extent={{30,40},{50,60}})));
  Blocks.Sources.Sine sine2(f=0.2, amplitude=1)
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Components.Inertia inertia6(J=2)
    annotation (Placement(transformation(extent={{90,40},{110,60}})));
  Components.OneWayClutch oneWayClutch(
    phi_rel(fixed=true),
    w_rel(fixed=true),
    startForward(fixed=true),
    stuck(fixed=true),
    fn_max=1,
    useHeatPort=true)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Components.Brake brake(fn_max=2, useHeatPort=true)
    annotation (Placement(transformation(extent={{120,40},{140,60}})));
equation

  connect(sine.y, torque.tau) annotation (Line(
      points={{-119,0},{-112,0}}, color={0,0,127}));
  connect(torque.flange, inertia1.flange_a) annotation (Line(
      points={{-90,0},{-80,0}}));
  connect(inertia1.flange_b, damper.flange_b) annotation (Line(
      points={{-60,0},{-50,0},{-50,-10}}));
  connect(damper.flange_a, fixed.flange) annotation (Line(
      points={{-50,-30},{-50,-40}}));
  connect(damper.heatPort, convection.solid) annotation (Line(
      points={{-40,-30},{-20,-30},{-20,-60},{0,-60}},
                                           color={191,0,0}));
  connect(TAmbient.port, convection.fluid) annotation (Line(
      points={{28,-60},{20,-60}}, color={191,0,0}));
  connect(const.y, convection.Gc) annotation (Line(
      points={{1,-90},{10,-90},{10,-70}},  color={0,0,127}));
  connect(inertia1.flange_b, springDamper.flange_a) annotation (Line(
      points={{-60,0},{-30,0}}));
  connect(springDamper.heatPort, convection.solid) annotation (Line(
      points={{-30,-10},{-30,-30},{-20,-30},{-20,-60},{0,-60}},
                                            color={191,0,0}));
  connect(springDamper.flange_b, inertia2.flange_a) annotation (Line(
      points={{-10,0},{0,0}}));
  connect(elastoBacklash.flange_a, inertia2.flange_b) annotation (Line(
      points={{30,0},{20,0}}));
  connect(elastoBacklash.heatPort, convection.solid) annotation (Line(
      points={{30,-10},{30,-30},{-20,-30},{-20,-60},{0,-60}},
                                                          color={191,0,0}));
  connect(elastoBacklash.flange_b, inertia3.flange_a) annotation (Line(
      points={{50,0},{60,0}}));
  connect(inertia3.flange_b, bearingFriction.flange_a) annotation (Line(
      points={{80,0},{90,0}}));
  connect(convection.solid, bearingFriction.heatPort) annotation (Line(
      points={{0,-60},{-20,-60},{-20,-30},{90,-30},{90,-10}},
                                                            color={191,0,0}));
  connect(spring3.flange_b, inertia4.flange_a) annotation (Line(
      points={{-70,50},{-60,50}}));
  connect(bearingFriction.flange_b, spring3.flange_a) annotation (Line(
      points={{110,0},{110,20},{-90,20},{-90,50}}));
  connect(inertia4.flange_b, lossyGear.flange_a) annotation (Line(
      points={{-40,50},{-30,50}}));
  connect(lossyGear.heatPort, convection.solid) annotation (Line(
      points={{-30,40},{-30,30},{120,30},{120,-30},{-20,-30},{-20,-60},{0,-60}},
                                                                              color={191,0,0}));

  connect(lossyGear.flange_b, clutch.flange_a) annotation (Line(
      points={{-10,50},{0,50}}));
  connect(clutch.heatPort, convection.solid) annotation (Line(
      points={{0,40},{0,30},{120,30},{120,-30},{-20,-30},{-20,-60},{0,-60}},color={191,0,0}));

  connect(clutch.flange_b, inertia5.flange_a) annotation (Line(
      points={{20,50},{30,50}}));
  connect(sine2.y, clutch.f_normalized) annotation (Line(
      points={{1,90},{10,90},{10,61}},    color={0,0,127}));
  connect(inertia5.flange_b, oneWayClutch.flange_a) annotation (Line(
      points={{50,50},{60,50}}));
  connect(oneWayClutch.flange_b, inertia6.flange_a) annotation (Line(
      points={{80,50},{90,50}}));
  connect(sine2.y, oneWayClutch.f_normalized) annotation (Line(
      points={{1,90},{70,90},{70,61}},    color={0,0,127}));
  connect(inertia6.flange_b, brake.flange_a) annotation (Line(
      points={{110,50},{120,50}}));
  connect(sine2.y, brake.f_normalized) annotation (Line(
      points={{1,90},{130,90},{130,61}},    color={0,0,127}));
  connect(oneWayClutch.heatPort, convection.solid) annotation (Line(
      points={{60,40},{60,30},{120,30},{120,-30},{-20,-30},{-20,-60},{0,-60}},
                                                                            color={191,0,0}));

  connect(brake.heatPort, convection.solid) annotation (Line(
      points={{120,40},{120,-30},{-20,-30},{-20,-60},{0,-60}},
                                                            color={191,0,0}));

  annotation (
    Documentation(info="<html>
<p>
This model demonstrates how to model the dissipated power of a drive train,
by enabling the heatPort of all components and connecting these heatPorts via
a convection element to the environment. The total heat flow generated by the
elements of the drive train and transported to the environment
is present in variable convection.fluid.
</p>
</html>"),
    experiment(StopTime=1.0, Interval=0.0001),
    Diagram(coordinateSystem(extent={{-140,-100},{140,100}})));
end HeatLosses;
