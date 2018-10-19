within ModelicaTest;
package Translational "Test models for Modelica.Mechanics.Translational"
extends Modelica.Icons.ExamplesPackage;

  model AllComponents
    extends Modelica.Icons.Example;

    Modelica.Mechanics.Translational.Components.Mass slidingMass(
      m=1,
      s(fixed=true),
      v(fixed=true))
      annotation (Placement(transformation(extent={{-70,60},{-50,80}})));
    Modelica.Mechanics.Translational.Components.Rod rod(L=0)
                                             annotation (Placement(
          transformation(extent={{-30,60},{-10,80}})));
    Modelica.Mechanics.Translational.Components.Spring spring(c=1)
      annotation (Placement(transformation(extent={{0,60},{20,80}})));
    Modelica.Mechanics.Translational.Components.Damper damper(
                                                   d=10, s_rel(fixed=true))
      annotation (Placement(transformation(extent={{30,60},{50,80}})));
    Modelica.Mechanics.Translational.Components.Mass slidingMass1(m=1)
      annotation (Placement(transformation(extent={{60,60},{80,80}})));
    Modelica.Mechanics.Translational.Components.SpringDamper springDamper(
      c=1,
      d=1,
      s_rel(fixed=true),
      v_rel(fixed=true))
      annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
    Modelica.Mechanics.Translational.Components.Mass slidingMass2(m=1)
      annotation (Placement(transformation(extent={{0,20},{20,40}})));
    Modelica.Mechanics.Translational.Components.ElastoGap elastoGap(
      c=1,
      d=1,
      s_rel(fixed=true),
      v_rel(fixed=true))
      annotation (Placement(transformation(extent={{30,20},{50,40}})));
    Modelica.Mechanics.Translational.Components.Mass slidingMass3(m=1)
      annotation (Placement(transformation(extent={{60,20},{80,40}})));
    Modelica.Mechanics.Translational.Sources.Position position(v(fixed=true))
      annotation (Placement(transformation(extent={{-70,-20},{-50,0}})));
    Modelica.Blocks.Sources.Sine sine(freqHz=1)
                                      annotation (Placement(transformation(
            extent={{-100,-20},{-80,0}})));
    Modelica.Mechanics.Translational.Components.Mass slidingMass4(m=1)
      annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
    Modelica.Mechanics.Translational.Sources.Speed position1
      annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));
    Modelica.Blocks.Sources.Sine sine1(freqHz=1)
                                       annotation (Placement(transformation(
            extent={{-100,-60},{-80,-40}})));
    Modelica.Mechanics.Translational.Components.Mass slidingMass5(m=1)
      annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
    Modelica.Mechanics.Translational.Sources.Accelerate position2
      annotation (Placement(transformation(extent={{-70,-100},{-50,-80}})));
    Modelica.Blocks.Sources.Sine sine2(freqHz=1)
                                       annotation (Placement(transformation(
            extent={{-100,-100},{-80,-80}})));
    Modelica.Mechanics.Translational.Components.Mass slidingMass6(m=1)
      annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
    Modelica.Mechanics.Translational.Sources.Move position3
      annotation (Placement(transformation(extent={{30,-20},{50,0}})));
    Modelica.Blocks.Sources.Sine sine3[3](freqHz={1,1,1})
                                          annotation (Placement(transformation(
            extent={{0,-20},{20,0}})));
    Modelica.Mechanics.Translational.Components.Mass slidingMass7(m=1)
      annotation (Placement(transformation(extent={{60,-20},{80,0}})));
    Modelica.Mechanics.Translational.Sources.Force force
      annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
    Modelica.Mechanics.Translational.Components.RelativeStates relativeStates(s_rel(
          fixed=true), v_rel(fixed=true))
      annotation (Placement(transformation(extent={{-20,80},{0,100}})));
    Modelica.Blocks.Sources.Sine sine4(freqHz=1)
                                       annotation (Placement(transformation(
            extent={{-100,20},{-80,40}})));
  equation
    connect(slidingMass.flange_b, rod.flange_a) annotation (Line(
        points={{-50,70},{-30,70}}, color={0,127,0}));
    connect(rod.flange_b, spring.flange_a) annotation (Line(
        points={{-10,70},{0,70}}, color={0,127,0}));
    connect(spring.flange_b, damper.flange_a) annotation (Line(
        points={{20,70},{30,70}}, color={0,127,0}));
    connect(damper.flange_b, slidingMass1.flange_a) annotation (Line(
        points={{50,70},{60,70}}, color={0,127,0}));
    connect(slidingMass.flange_b, springDamper.flange_a) annotation (Line(
        points={{-50,70},{-40,70},{-40,30},{-30,30}}, color={0,127,0}));
    connect(springDamper.flange_b, slidingMass2.flange_a) annotation (Line(
        points={{-10,30},{0,30}}, color={0,127,0}));
    connect(slidingMass2.flange_b, elastoGap.flange_a) annotation (Line(
        points={{20,30},{30,30}}, color={0,127,0}));
    connect(elastoGap.flange_b, slidingMass3.flange_a) annotation (Line(
        points={{50,30},{60,30}}, color={0,127,0}));
    connect(sine.y, position.s_ref) annotation (Line(
        points={{-79,-10},{-72,-10}}, color={0,0,127}));
    connect(position.flange,   slidingMass4.flange_a) annotation (Line(
        points={{-50,-10},{-40,-10}}, color={0,127,0}));
    connect(position1.flange,   slidingMass5.flange_a) annotation (Line(
        points={{-50,-50},{-40,-50}}, color={0,127,0}));
    connect(position2.flange,   slidingMass6.flange_a) annotation (Line(
        points={{-50,-90},{-40,-90}}, color={0,127,0}));
    connect(position3.flange,   slidingMass7.flange_a) annotation (Line(
        points={{50,-10},{60,-10}}, color={0,127,0}));
    connect(sine1.y, position1.v_ref) annotation (Line(
        points={{-79,-50},{-72,-50}}, color={0,0,127}));
    connect(sine2.y,position2.a_ref)
                                  annotation (Line(
        points={{-79,-90},{-72,-90}}, color={0,0,127}));
    connect(sine3.y, position3.u) annotation (Line(
        points={{21,-10},{28,-10}}, color={0,0,127}));
    connect(force.flange,   springDamper.flange_a) annotation (Line(
        points={{-50,30},{-30,30}}, color={0,127,0}));
    connect(slidingMass.flange_b, relativeStates.flange_a) annotation (Line(
        points={{-50,70},{-40,70},{-40,90},{-20,90}}, color={0,127,0}));
    connect(relativeStates.flange_b, damper.flange_a) annotation (Line(
        points={{0,90},{30,90},{30,70}}, color={0,127,0}));
    connect(sine4.y, force.f) annotation (Line(
        points={{-79,30},{-72,30}}, color={0,0,127}));
    annotation (      experiment(StopTime=1.1));
  end AllComponents;

  model TestBraking
    extends Modelica.Icons.Example;
    Modelica.Mechanics.Translational.Components.Mass mass1(
      m=1,
      s(fixed=true, start=0),
      v(fixed=true, start=100))
      annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
    Modelica.Mechanics.Translational.Sources.LinearSpeedDependentForce
      linearSpeedDependentForce(f_nominal=-100, v_nominal=100)
      annotation (Placement(transformation(extent={{40,50},{20,70}})));
    Modelica.Mechanics.Translational.Components.Mass mass2(
      m=1,
      s(fixed=true, start=0),
      v(fixed=true, start=100))
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Modelica.Mechanics.Translational.Sources.QuadraticSpeedDependentForce
      quadraticSpeedDependentForce(f_nominal=-100, v_nominal=100)
      annotation (Placement(transformation(extent={{40,20},{20,40}})));
    Modelica.Mechanics.Translational.Components.Mass mass3(
      m=1,
      s(fixed=true, start=0),
      v(fixed=true, start=100))
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    Modelica.Mechanics.Translational.Sources.ConstantForce constantForce(
        f_constant=-100)
      annotation (Placement(transformation(extent={{40,-10},{20,10}})));
    Modelica.Mechanics.Translational.Components.Mass mass4(
      m=1,
      s(fixed=true, start=0),
      v(fixed=true, start=100))
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
    Modelica.Mechanics.Translational.Sources.SignForce signForce(f_nominal=-100,
        v0=1) annotation (Placement(transformation(extent={{40,-40},{20,-20}})));
    Modelica.Mechanics.Translational.Sources.EddyCurrentForce eddyCurrentForce(
      f_nominal=100,
      v_nominal=10,
      useHeatPort=true,
      TRef=293.15,
      alpha20(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper)
      annotation (Placement(transformation(extent={{40,-70},{20,-50}})));
    Modelica.Mechanics.Translational.Components.Mass mass5(
      m=1,
      s(fixed=true, start=0),
      v(fixed=true, start=20))
      annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=1, T(
          fixed=true)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={40,-90})));
  equation
    connect(mass1.flange_b, linearSpeedDependentForce.flange)
      annotation (Line(points={{-20,60},{20,60}}, color={0,127,0}));
    connect(quadraticSpeedDependentForce.flange, mass2.flange_b)
      annotation (Line(points={{20,30},{-20,30}}, color={0,127,0}));
    connect(constantForce.flange, mass3.flange_b)
      annotation (Line(points={{20,0},{-20,0}}, color={0,127,0}));
    connect(signForce.flange, mass4.flange_b)
      annotation (Line(points={{20,-30},{-20,-30}}, color={0,127,0}));
    connect(eddyCurrentForce.heatPort, heatCapacitor.port) annotation (Line(
          points={{40,-70},{40,-80}}, color={191,0,0}));
    connect(eddyCurrentForce.flange, mass5.flange_b) annotation (Line(points={{20,-60},{-20,-60}}, color={0,127,0}));
    annotation (
      experiment(StopTime=2));
  end TestBraking;

end Translational;
