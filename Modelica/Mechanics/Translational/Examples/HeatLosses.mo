within Modelica.Mechanics.Translational.Examples;
model HeatLosses "Demonstrate the modeling of heat losses"
  extends Modelica.Icons.Example;
  Components.Mass mass1(
    m=1,
    s(fixed=true),
    L=0.1,
    v(fixed=true))
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Components.SpringDamper springDamper(
    s_rel(fixed=true),
    v_rel(fixed=true),
    c=100,
    d=10,
    useHeatPort=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Components.Damper damper(d=10, useHeatPort=true) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-40,-40})));
  Components.ElastoGap elastoGap(
    c=100,
    d=20,
    s_rel0=-0.02,
    useHeatPort=true)
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Components.Fixed fixed1
    annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
  Sources.Force force
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Blocks.Sources.Sine sine1(f=1, amplitude=20)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Components.Mass mass2(
    m=1,
    L=0.1,
    s(fixed=false),
    v(fixed=false))
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Components.SupportFriction supportFriction(useHeatPort=true)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Components.Spring spring(c=100, s_rel(fixed=true))
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Components.Mass mass3(
    m=1,
    L=0.1,
    s(fixed=false),
    v(fixed=true))
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Components.Brake brake(fn_max=10, useHeatPort=true)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Blocks.Sources.Sine sine2(amplitude=10, f=2)
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  Components.MassWithStopAndFriction massWithStopAndFriction(
    L=0.1,
    m=1,
    F_prop=0.5,
    F_Coulomb=1,
    F_Stribeck=2,
    fexp=2,
    smin=0,
    smax=0.4,
    v(fixed=true),
    useHeatPort=true)
    annotation (Placement(transformation(extent={{80,50},{100,70}})));
  Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Blocks.Sources.Constant const(k=20)
    annotation (Placement(transformation(extent={{70,-60},{50,-40}})));
  Thermal.HeatTransfer.Celsius.FixedTemperature TAmbient(T=25)
    "Ambient temperature"
    annotation (Placement(transformation(extent={{70,-90},{50,-70}})));
  Components.Fixed fixed2
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Components.SpringDamper springDamper1(
    c=10000,
    d=1000,
    useHeatPort=true,
    s_rel(fixed=true))
    annotation (Placement(transformation(extent={{50,50},{70,70}})));
equation

  connect(mass1.flange_b, springDamper.flange_a) annotation (Line(
      points={{-20,0},{-10,0}},   color={0,127,0}));
  connect(sine1.y, force.f) annotation (Line(
      points={{-79,0},{-72,0}},   color={0,0,127}));
  connect(force.flange, mass1.flange_a) annotation (Line(
      points={{-50,0},{-40,0}},   color={0,127,0}));
  connect(mass1.flange_a, damper.flange_a) annotation (Line(
      points={{-40,0},{-40,-30}},color={0,127,0}));
  connect(damper.flange_b, fixed1.flange) annotation (Line(
      points={{-40,-50},{-40,-60}}, color={0,127,0}));
  connect(springDamper.flange_b, mass2.flange_a) annotation (Line(
      points={{10,0},{20,0}},   color={0,127,0}));
  connect(mass2.flange_b, supportFriction.flange_a) annotation (Line(
      points={{40,0},{50,0}},   color={0,127,0}));
  connect(supportFriction.flange_b, spring.flange_a) annotation (Line(
      points={{70,0},{70,20},{-50,20},{-50,60},{-40,60}},
                                color={0,127,0}));
  connect(spring.flange_b, mass3.flange_a) annotation (Line(
      points={{-20,60},{-10,60}},
                                color={0,127,0}));
  connect(mass3.flange_b, brake.flange_a) annotation (Line(
      points={{10,60},{20,60}},   color={0,127,0}));
  connect(sine2.y, brake.f_normalized) annotation (Line(
      points={{21,90},{30,90},{30,71}},    color={0,0,127}));
  connect(elastoGap.flange_b, mass1.flange_a) annotation (Line(
      points={{-50,-30},{-40,-30},{-40,0}},
                                         color={0,127,0}));
  connect(const.y, convection.Gc) annotation (Line(
      points={{49,-50},{30,-50},{30,-70}},
                                         color={0,0,127}));
  connect(TAmbient.port, convection.fluid) annotation (Line(
      points={{50,-80},{40,-80}}, color={191,0,0}));
  connect(elastoGap.flange_a, fixed2.flange) annotation (Line(
      points={{-70,-30},{-90,-30}},
                                 color={0,127,0}));
  connect(elastoGap.heatPort, convection.solid) annotation (Line(
      points={{-70,-40},{-70,-80},{20,-80}},  color={191,0,0}));
  connect(damper.heatPort, convection.solid) annotation (Line(
      points={{-30,-30},{-10,-30},{-10,-80},{20,-80}},
                                            color={191,0,0}));
  connect(springDamper.heatPort, convection.solid) annotation (Line(
      points={{-10,-10},{-10,-80},{20,-80}}, color={191,0,0}));
  connect(supportFriction.heatPort, convection.solid) annotation (Line(
      points={{50,-10},{50,-30},{-10,-30},{-10,-80},{20,-80}},
                                                           color={191,0,0}));
  connect(brake.heatPort, convection.solid) annotation (Line(
      points={{20,50},{20,30},{90,30},{90,-30},{-10,-30},{-10,-80},{20,-80}},
                                                             color={191,0,0}));
  connect(massWithStopAndFriction.heatPort, convection.solid) annotation (
      Line(
      points={{80,50},{80,30},{90,30},{90,-30},{-10,-30},{-10,-80},{20,-80}},
                                                             color={191,0,0}));
  connect(brake.flange_b, springDamper1.flange_a) annotation (Line(
      points={{40,60},{50,60}},   color={0,127,0}));
  connect(springDamper1.flange_b, massWithStopAndFriction.flange_a)
    annotation (Line(
      points={{70,60},{80,60}},   color={0,127,0}));
  connect(springDamper1.heatPort, convection.solid) annotation (Line(
      points={{50,50},{50,30},{90,30},{90,-30},{-10,-30},{-10,-80},{20,-80}},
                                                             color={191,0,0}));
  annotation (
    Documentation(info="<html>
<p>
This model demonstrates how to model the dissipated power of a Translational model,
by enabling the heatPort of all components and connecting these heatPorts via
a convection element to the environment. The total heat flow generated by the
elements and transported to the environment
is present in variable convection.fluid.
</p>
</html>"),
    experiment(StopTime=2.0, Interval=0.001));
end HeatLosses;
