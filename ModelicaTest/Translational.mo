within ModelicaTest;
package Translational "Test models for Modelica.Mechanics.Translational"
extends Modelica.Icons.ExamplesPackage;

  model AllComponents
    extends Modelica.Icons.Example;

    Modelica.Mechanics.Translational.Components.Mass slidingMass(
      m=1,
      s(fixed=true),
      v(fixed=true))
      annotation (Placement(transformation(extent={{-70,60},{-50,80}}, rotation=
             0)));
    Modelica.Mechanics.Translational.Components.Rod rod(L=0)
                                             annotation (Placement(
          transformation(extent={{-30,60},{-10,80}},rotation=0)));
    Modelica.Mechanics.Translational.Components.Spring spring(c=1)
      annotation (Placement(transformation(extent={{0,60},{20,80}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Damper damper(
                                                   d=10, s_rel(fixed=true))
      annotation (Placement(transformation(extent={{30,60},{50,80}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass1(m=1)
      annotation (Placement(transformation(extent={{60,60},{80,80}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.SpringDamper springDamper(
      c=1,
      d=1,
      s_rel(fixed=true),
      v_rel(fixed=true))
      annotation (Placement(transformation(extent={{-30,20},{-10,40}}, rotation=
             0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass2(m=1)
      annotation (Placement(transformation(extent={{0,20},{20,40}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.ElastoGap elastoGap(
      c=1,
      d=1,
      s_rel(fixed=true),
      v_rel(fixed=true))
      annotation (Placement(transformation(extent={{30,20},{50,40}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass3(m=1)
      annotation (Placement(transformation(extent={{60,20},{80,40}}, rotation=0)));
    Modelica.Mechanics.Translational.Sources.Position position(v(fixed=true))
      annotation (Placement(transformation(extent={{-70,-20},{-50,0}}, rotation=
             0)));
    Modelica.Blocks.Sources.Sine sine(freqHz=1)
                                      annotation (Placement(transformation(
            extent={{-100,-20},{-80,0}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass4(m=1)
      annotation (Placement(transformation(extent={{-40,-20},{-20,0}}, rotation=
             0)));
    Modelica.Mechanics.Translational.Sources.Speed position1
      annotation (Placement(transformation(extent={{-70,-60},{-50,-40}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine1(freqHz=1)
                                       annotation (Placement(transformation(
            extent={{-100,-60},{-80,-40}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass5(m=1)
      annotation (Placement(transformation(extent={{-40,-60},{-20,-40}},
            rotation=0)));
    Modelica.Mechanics.Translational.Sources.Accelerate position2
      annotation (Placement(transformation(extent={{-70,-100},{-50,-80}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine2(freqHz=1)
                                       annotation (Placement(transformation(
            extent={{-100,-100},{-80,-80}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass6(m=1)
      annotation (Placement(transformation(extent={{-40,-100},{-20,-80}},
            rotation=0)));
    Modelica.Mechanics.Translational.Sources.Move position3
      annotation (Placement(transformation(extent={{30,-20},{50,0}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine3[3](freqHz={1,1,1})
                                          annotation (Placement(transformation(
            extent={{0,-20},{20,0}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass7(m=1)
      annotation (Placement(transformation(extent={{60,-20},{80,0}}, rotation=0)));
    Modelica.Mechanics.Translational.Sources.Force force
      annotation (Placement(transformation(extent={{-70,20},{-50,40}}, rotation=
             0)));
    Modelica.Mechanics.Translational.Components.RelativeStates relativeStates(s_rel(
          fixed=true), v_rel(fixed=true))
      annotation (Placement(transformation(extent={{-20,80},{0,100}}, rotation=
              0)));
    Modelica.Blocks.Sources.Sine sine4(freqHz=1)
                                       annotation (Placement(transformation(
            extent={{-100,20},{-80,40}}, rotation=0)));
  equation
    connect(slidingMass.flange_b, rod.flange_a) annotation (Line(
        points={{-50,70},{-30,70}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(rod.flange_b, spring.flange_a) annotation (Line(
        points={{-10,70},{0,70}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(spring.flange_b, damper.flange_a) annotation (Line(
        points={{20,70},{30,70}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(damper.flange_b, slidingMass1.flange_a) annotation (Line(
        points={{50,70},{60,70}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(slidingMass.flange_b, springDamper.flange_a) annotation (Line(
        points={{-50,70},{-40,70},{-40,30},{-30,30}},
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
        points={{-79,-10},{-72,-10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(position.flange,   slidingMass4.flange_a) annotation (Line(
        points={{-50,-10},{-40,-10}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(position1.flange,   slidingMass5.flange_a) annotation (Line(
        points={{-50,-50},{-40,-50}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(position2.flange,   slidingMass6.flange_a) annotation (Line(
        points={{-50,-90},{-40,-90}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(position3.flange,   slidingMass7.flange_a) annotation (Line(
        points={{50,-10},{60,-10}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(sine1.y, position1.v_ref) annotation (Line(
        points={{-79,-50},{-72,-50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine2.y,position2.a_ref)
                                  annotation (Line(
        points={{-79,-90},{-72,-90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine3.y, position3.u) annotation (Line(
        points={{21,-10},{28,-10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(force.flange,   springDamper.flange_a) annotation (Line(
        points={{-50,30},{-30,30}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(slidingMass.flange_b, relativeStates.flange_a) annotation (Line(
        points={{-50,70},{-40,70},{-40,90},{-20,90}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(relativeStates.flange_b, damper.flange_a) annotation (Line(
        points={{0,90},{30,90},{30,70}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(sine4.y, force.f) annotation (Line(
        points={{-79,30},{-72,30}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (      experiment(StopTime=1.1));
  end AllComponents;
end Translational;
