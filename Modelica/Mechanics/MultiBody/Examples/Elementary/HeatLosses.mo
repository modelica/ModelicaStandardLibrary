within Modelica.Mechanics.MultiBody.Examples.Elementary;
model HeatLosses "Demonstrate the modeling of heat losses"
   extends Modelica.Icons.Example;
  inner World                              world annotation (Placement(
        transformation(extent={{-100,50},{-80,70}})));
  Parts.Body                              body1(
    m=1,
    r_CM={0,-0.2,0},
    cylinderDiameter=0.05,
    sphereDiameter=0.15,
    I_11=0.1,
    I_22=0.1,
    I_33=0.1,
    r_0(start={0.3,-0.2,0}, each fixed=true),
    v_0(each fixed=true),
    angles_fixed=true,
    w_0_fixed=true,
    w_0_start(each displayUnit="deg/s") = {0,0,0.034906585039887})
              annotation (Placement(transformation(
        origin={-40,-20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Parts.FixedTranslation                              bar1(                     r={0.3,0,0})
    annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  Parts.FixedTranslation                              bar2(r={0.3,0,0})
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Forces.Spring                              spring1(
    s_unstretched=0.1,
    coilWidth=0.01,
    c=30,
    numberOfWindings=10,
    width=0.1) annotation (Placement(transformation(
        origin={-30,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Forces.Damper                              damper1(d=2, useHeatPort=true)
    annotation (Placement(transformation(
        origin={-50,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Forces.SpringDamperParallel springDamper(
    d=2,
    c=30,
    s_unstretched=0.1,
    width=0.1,
    coilWidth=0.01,
    numberOfWindings=10,
    useHeatPort=true) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,20})));
  Parts.Body                              body2(
    m=1,
    r_CM={0,-0.2,0},
    cylinderDiameter=0.05,
    sphereDiameter=0.15,
    I_11=0.1,
    I_22=0.1,
    I_33=0.1,
    v_0(each fixed=true),
    angles_fixed=true,
    w_0_fixed=true,
    w_0_start(each displayUnit="deg/s") = {0,0,0.034906585039887},
    r_0(start={0.6,-0.2,0}, each fixed=true))
              annotation (Placement(transformation(
        origin={20,-20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Parts.FixedTranslation                              bar3(r={0.3,0,0})
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Forces.SpringDamperSeries springDamperSeries(
    d=2,
    c=30,
    s_unstretched=0.1,
    useHeatPort=true) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={80,20})));
  Parts.Body                              body3(
    m=1,
    r_CM={0,-0.2,0},
    cylinderDiameter=0.05,
    sphereDiameter=0.15,
    I_11=0.1,
    I_22=0.1,
    I_33=0.1,
    v_0(each fixed=true),
    angles_fixed=true,
    w_0_fixed=true,
    w_0_start(each displayUnit="deg/s") = {0,0,0.034906585039887},
    r_0(start={0.9,-0.2,0}, each fixed=true))
              annotation (Placement(transformation(
        origin={70,-20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Forces.Spring spring(
    s_unstretched=0.2,
    width=0.05,
    c=30) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,20})));
  Blocks.Sources.Constant const(k=20)
    annotation (Placement(transformation(extent={{-8,-100},{12,-80}})));
  Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(extent={{20,-50},{40,-70}})));
  Thermal.HeatTransfer.Celsius.FixedTemperature TAmbient(T=25)
    "Ambient temperature"
    annotation (Placement(transformation(extent={{80,-70},{60,-50}})));
equation

  connect(world.frame_b,bar1. frame_a)
    annotation (Line(
      points={{-80,60},{-70,60}},
      color={95,95,95},
      thickness=0.5));
  connect(bar1.frame_b,bar2. frame_a)
    annotation (Line(
      points={{-50,60},{-20,60}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1.frame_a,bar1. frame_b) annotation (Line(
      points={{-50,30},{-50,40},{-40,40},{-40,60},{-50,60}},
      color={95,95,95},
      thickness=0.5));
  connect(spring1.frame_a,bar1. frame_b) annotation (Line(
      points={{-30,30},{-30,40},{-40,40},{-40,60},{-50,60}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1.frame_b,body1. frame_a) annotation (Line(
      points={{-50,10},{-50,0},{-40,0},{-40,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(spring1.frame_b,body1. frame_a) annotation (Line(
      points={{-30,10},{-30,0},{-40,0},{-40,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(bar2.frame_b, springDamper.frame_a) annotation (Line(
      points={{0,60},{20,60},{20,30}},
      color={95,95,95},
      thickness=0.5));
  connect(springDamper.frame_b, body2.frame_a) annotation (Line(
      points={{20,10},{20,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(bar3.frame_b, springDamperSeries.frame_a)
                                               annotation (Line(
      points={{60,60},{70,60},{70,40},{80,40},{80,30}},
      color={95,95,95},
      thickness=0.5));
  connect(springDamperSeries.frame_b, body3.frame_a)
                                                annotation (Line(
      points={{80,10},{80,0},{70,0},{70,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(bar3.frame_a, bar2.frame_b) annotation (Line(
      points={{40,60},{0,60}},
      color={95,95,95},
      thickness=0.5));
  connect(bar3.frame_b, spring.frame_a) annotation (Line(
      points={{60,60},{70,60},{70,40},{60,40},{60,30}},
      color={95,95,95},
      thickness=0.5));
  connect(spring.frame_b, body3.frame_a) annotation (Line(
      points={{60,10},{60,0},{70,0},{70,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(const.y,convection. Gc) annotation (Line(
      points={{13,-90},{30,-90},{30,-70}}, color={0,0,127}));
  connect(TAmbient.port,convection. fluid) annotation (Line(
      points={{60,-60},{40,-60}}, color={191,0,0}));
  connect(damper1.heatPort, convection.solid) annotation (Line(
      points={{-60,30},{-60,-40},{0,-40},{0,-60},{20,-60}},
                                            color={191,0,0}));
  connect(springDamper.heatPort, convection.solid) annotation (Line(
      points={{10,30},{0,30},{0,-60},{20,-60}}, color={191,0,0}));
  connect(springDamperSeries.heatPort, convection.solid) annotation (Line(
      points={{90,30},{92,30},{92,-40},{0,-40},{0,-60},{20,-60}}, color={191,0,0}));
  annotation (
    experiment(StopTime=3),
    Documentation(info="<html>
<p>
This model demonstrates how to model the dissipated power of a multi-body
force element by enabling the heatPort of all components and connecting these heatPorts via
a convection element to the environment. The total heat flow generated by the
elements of this multi-body system and transported to the environment
is present in variable convection.fluid.
</p>
</html>"));
end HeatLosses;
