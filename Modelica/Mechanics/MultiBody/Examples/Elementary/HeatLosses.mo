within Modelica.Mechanics.MultiBody.Examples.Elementary;
model HeatLosses "Demonstrate the modeling of heat losses"
   extends Modelica.Icons.Example;
  inner World                              world annotation (Placement(
        transformation(extent={{-100,40},{-80,60}},rotation=0)));
  Parts.Body                              body1(
    m=1,
    r_CM={0,-0.2,0},
    cylinderDiameter=0.05,
    sphereDiameter=0.15,
    I_11=0.1,
    I_22=0.1,
    I_33=0.1,
    r_0(start={0.3,-0.2,0}, fixed=true),
    v_0(fixed=true),
    angles_fixed=true,
    w_0_fixed=true,
    w_0_start(displayUnit="deg/s") = {0,0,0.034906585039887})
              annotation (Placement(transformation(
        origin={-40,-30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Parts.FixedTranslation                              bar1(                     r={0.3,0,0})
    annotation (Placement(transformation(extent={{-66,40},{-46,60}}, rotation=0)));
  Parts.FixedTranslation                              bar2(r={0.3,0,0})
    annotation (Placement(transformation(extent={{-20,40},{0,60}},rotation=0)));
  Forces.Spring                              spring1(
    s_unstretched=0.1,
    coilWidth=0.01,
    c=30,
    numberOfWindings=10,
    width=0.1) annotation (Placement(transformation(
        origin={-26,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Forces.Damper                              damper1(d=2, useHeatPort=true)
    annotation (Placement(transformation(
        origin={-50,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Forces.SpringDamperParallel springDamper(
    d=2,
    c=30,
    s_unstretched=0.1,
    width=0.1,
    coilWidth=0.01,
    numberOfWindings=10,
    useHeatPort=true)                       annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={26,10})));
  Parts.Body                              body2(
    m=1,
    r_CM={0,-0.2,0},
    cylinderDiameter=0.05,
    sphereDiameter=0.15,
    I_11=0.1,
    I_22=0.1,
    I_33=0.1,
    v_0(fixed=true),
    angles_fixed=true,
    w_0_fixed=true,
    w_0_start(displayUnit="deg/s") = {0,0,0.034906585039887},
    r_0(start={0.6,-0.2,0}, fixed=true))
              annotation (Placement(transformation(
        origin={26,-30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Parts.FixedTranslation                              bar3(r={0.3,0,0})
    annotation (Placement(transformation(extent={{34,40},{54,60}},rotation=0)));
  Forces.SpringDamperSeries springDamperSeries(
    d=2,
    c=30,
    s_unstretched=0.1,
    useHeatPort=true)                       annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={80,10})));
  Parts.Body                              body3(
    m=1,
    r_CM={0,-0.2,0},
    cylinderDiameter=0.05,
    sphereDiameter=0.15,
    I_11=0.1,
    I_22=0.1,
    I_33=0.1,
    v_0(fixed=true),
    angles_fixed=true,
    w_0_fixed=true,
    w_0_start(displayUnit="deg/s") = {0,0,0.034906585039887},
    r_0(start={0.9,-0.2,0}, fixed=true))
              annotation (Placement(transformation(
        origin={80,-30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Forces.Spring spring(
    s_unstretched=0.2,
    width=0.05,
    c=30)              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,10})));
  Blocks.Sources.Constant const(k=20)
    annotation (Placement(transformation(extent={{-8,-100},{12,-80}})));
  Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(extent={{26,-52},{46,-72}})));
  Thermal.HeatTransfer.Celsius.FixedTemperature TAmbient(T=25)
    "Ambient temperature"
    annotation (Placement(transformation(extent={{80,-72},{60,-52}})));
equation

  connect(world.frame_b,bar1. frame_a)
    annotation (Line(
      points={{-80,50},{-66,50}},
      color={95,95,95},
      thickness=0.5));
  connect(bar1.frame_b,bar2. frame_a)
    annotation (Line(
      points={{-46,50},{-20,50}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1.frame_a,bar1. frame_b) annotation (Line(
      points={{-50,20},{-50,30},{-40,30},{-40,50},{-46,50}},
      color={95,95,95},
      thickness=0.5));
  connect(spring1.frame_a,bar1. frame_b) annotation (Line(
      points={{-26,20},{-26,30},{-40,30},{-40,50},{-46,50}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1.frame_b,body1. frame_a) annotation (Line(
      points={{-50,0},{-50,-8},{-40,-8},{-40,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(spring1.frame_b,body1. frame_a) annotation (Line(
      points={{-26,0},{-26,-8},{-40,-8},{-40,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(bar2.frame_b, springDamper.frame_a)  annotation (Line(
      points={{0,50},{26,50},{26,20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(springDamper.frame_b, body2.frame_a)  annotation (Line(
      points={{26,0},{26,-5},{26,-5},{26,-10},{26,-20},{26,-20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(bar3.frame_b, springDamperSeries.frame_a)
                                               annotation (Line(
      points={{54,50},{80,50},{80,20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(springDamperSeries.frame_b, body3.frame_a)
                                                annotation (Line(
      points={{80,0},{80,-20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(bar3.frame_a, bar2.frame_b) annotation (Line(
      points={{34,50},{0,50}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(bar3.frame_b, spring.frame_a) annotation (Line(
      points={{54,50},{60,50},{60,20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(spring.frame_b, body3.frame_a) annotation (Line(
      points={{60,0},{60,-12},{80,-12},{80,-20}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(const.y,convection. Gc) annotation (Line(
      points={{13,-90},{36,-90},{36,-72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TAmbient.port,convection. fluid) annotation (Line(
      points={{60,-62},{46,-62}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(damper1.heatPort, convection.solid) annotation (Line(
      points={{-60,20},{-60,-62},{26,-62}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(springDamper.heatPort, convection.solid) annotation (Line(
      points={{16,20},{4,20},{4,-62},{26,-62}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(springDamperSeries.heatPort, convection.solid) annotation (Line(
      points={{90,20},{96,20},{96,-46},{4,-46},{4,-62},{26,-62}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=3),
    experimentSetupOutput,
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
