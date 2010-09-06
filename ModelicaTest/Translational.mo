within ModelicaTest;
package Translational
extends Modelica.Icons.ExamplesPackage;

  model AllComponents

    Modelica.Mechanics.Translational.Components.Mass slidingMass
      annotation (Placement(transformation(extent={{-60,60},{-40,80}}, rotation=
             0)));
    Modelica.Mechanics.Translational.Components.Rod rod
                                             annotation (Placement(
          transformation(extent={{-28,60},{-8,80}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Spring spring
      annotation (Placement(transformation(extent={{0,60},{20,80}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Damper damper(
                                                   d=10)
      annotation (Placement(transformation(extent={{26,60},{46,80}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass1
      annotation (Placement(transformation(extent={{54,60},{74,80}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.SpringDamper springDamper
      annotation (Placement(transformation(extent={{-30,20},{-10,40}}, rotation=
             0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass2
      annotation (Placement(transformation(extent={{0,20},{20,40}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.ElastoGap elastoGap
      annotation (Placement(transformation(extent={{30,20},{50,40}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass3
      annotation (Placement(transformation(extent={{60,20},{80,40}}, rotation=0)));
    Modelica.Mechanics.Translational.Sources.Position position
      annotation (Placement(transformation(extent={{-68,-20},{-48,0}}, rotation=
             0)));
    Modelica.Blocks.Sources.Sine sine annotation (Placement(transformation(
            extent={{-100,-20},{-80,0}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass4
      annotation (Placement(transformation(extent={{-40,-20},{-20,0}}, rotation=
             0)));
    Modelica.Mechanics.Translational.Sources.Speed position1
      annotation (Placement(transformation(extent={{-68,-60},{-48,-40}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine1 annotation (Placement(transformation(
            extent={{-100,-60},{-80,-40}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass5
      annotation (Placement(transformation(extent={{-40,-60},{-20,-40}},
            rotation=0)));
    Modelica.Mechanics.Translational.Sources.Accelerate position2
      annotation (Placement(transformation(extent={{-68,-100},{-48,-80}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine2 annotation (Placement(transformation(
            extent={{-100,-100},{-80,-80}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass6
      annotation (Placement(transformation(extent={{-40,-100},{-20,-80}},
            rotation=0)));
    Modelica.Mechanics.Translational.Sources.Move position3
      annotation (Placement(transformation(extent={{32,-20},{52,0}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine3[3] annotation (Placement(transformation(
            extent={{0,-20},{20,0}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass7
      annotation (Placement(transformation(extent={{60,-20},{80,0}}, rotation=0)));
    Modelica.Mechanics.Translational.Sources.Force force
      annotation (Placement(transformation(extent={{-70,20},{-50,40}}, rotation=
             0)));
    Modelica.Mechanics.Translational.Components.RelativeStates relativeStates
      annotation (Placement(transformation(extent={{-2,82},{18,102}}, rotation=
              0)));
    Modelica.Blocks.Sources.Sine sine4 annotation (Placement(transformation(
            extent={{-100,20},{-80,40}}, rotation=0)));
  equation
    connect(slidingMass.flange_b, rod.flange_a) annotation (Line(
        points={{-40,70},{-28,70}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(rod.flange_b, spring.flange_a) annotation (Line(
        points={{-8,70},{0,70}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(spring.flange_b, damper.flange_a) annotation (Line(
        points={{20,70},{26,70}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(damper.flange_b, slidingMass1.flange_a) annotation (Line(
        points={{46,70},{54,70}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(slidingMass.flange_b, springDamper.flange_a) annotation (Line(
        points={{-40,70},{-40,30},{-30,30}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(springDamper.flange_b, slidingMass2.flange_a) annotation (Line(
        points={{-10,30},{0,30}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(slidingMass2.flange_b, elastoGap.flange_a) annotation (Line(
        points={{20,30},{30,30}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(elastoGap.flange_b, slidingMass3.flange_a) annotation (Line(
        points={{50,30},{60,30}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(sine.y, position.s_ref) annotation (Line(
        points={{-79,-10},{-70,-10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(position.flange,   slidingMass4.flange_a) annotation (Line(
        points={{-48,-10},{-40,-10}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(position1.flange,   slidingMass5.flange_a) annotation (Line(
        points={{-48,-50},{-40,-50}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(position2.flange,   slidingMass6.flange_a) annotation (Line(
        points={{-48,-90},{-40,-90}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(position3.flange,   slidingMass7.flange_a) annotation (Line(
        points={{52,-10},{60,-10}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(sine1.y, position1.v_ref) annotation (Line(
        points={{-79,-50},{-70,-50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine2.y,position2.a_ref)
                                  annotation (Line(
        points={{-79,-90},{-70,-90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine3.y, position3.u) annotation (Line(
        points={{21,-10},{30,-10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(force.flange,   springDamper.flange_a) annotation (Line(
        points={{-50,30},{-30,30}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(slidingMass.flange_b, relativeStates.flange_a) annotation (Line(
        points={{-40,70},{-34,70},{-34,92},{-2,92}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(relativeStates.flange_b, damper.flange_a) annotation (Line(
        points={{18,92},{26,92},{26,70}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(sine4.y, force.f) annotation (Line(
        points={{-79,30},{-72,30}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics),
      experiment(StopTime=1.1));
  end AllComponents;
end Translational;
