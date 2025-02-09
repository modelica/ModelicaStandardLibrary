within ModelicaTest;
package Rotational "Test models for Modelica.Mechanics.Rotational"
  extends Modelica.Icons.ExamplesPackage;

  package ForUsersGuide "Models used as screenshot for the users guide"
    extends Modelica.Icons.ExamplesPackage;

    model SimpleDriveTrain
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Sine sine(f=1) annotation (Placement(
            transformation(extent={{-80,0},{-60,20}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=true)
        annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
      Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (
          Placement(transformation(extent={{-40,-20},{-20,0}})));
      Modelica.Mechanics.Rotational.Components.Inertia J1(
        J=0.2,
        phi(start=0, fixed=true),
        w(start=0, fixed=true)) annotation (Placement(transformation(extent={{-10,
                0},{10,20}})));
      Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio=5,
          useSupport=true) annotation (Placement(transformation(extent={{20,0},
                {40,20}})));
      Modelica.Mechanics.Rotational.Components.Inertia J2(J=5) annotation (
          Placement(transformation(extent={{50,0},{70,20}})));
    equation
      connect(sine.y, torque.tau) annotation (Line(
          points={{-59,10},{-42,10}}, color={0,0,127}));
      connect(torque.support, fixed.flange) annotation (Line(
          points={{-30,0},{-30,-10}}));
      connect(torque.flange, J1.flange_a) annotation (Line(
          points={{-20,10},{-10,10}}));
      connect(gear.flange_b, J2.flange_a) annotation (Line(
          points={{40,10},{50,10}}));
      connect(fixed.flange, gear.support) annotation (Line(
          points={{-30,-10},{30,-10},{30,0}}));
      connect(J1.flange_b, gear.flange_a) annotation (Line(
          points={{10,10},{20,10}}));
      annotation (experiment(StopTime=1.1));
    end SimpleDriveTrain;

    model ConnectionPossibilities
      extends Modelica.Icons.Example;

      Modelica.Mechanics.Rotational.Components.Inertia inertia1(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-60,
                40},{-40,60}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=1)
        annotation (Placement(transformation(extent={{-20,40},{0,60}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia3(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-60,
                -20},{-40,0}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia4(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                30,-20},{50,0}})));
      Modelica.Mechanics.Rotational.Components.Spring spring1(c=1e4)
        annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
      Modelica.Mechanics.Rotational.Components.Spring spring2(c=1e4)
        annotation (Placement(transformation(extent={{0,-20},{20,0}})));

    equation
      connect(inertia1.flange_b, inertia2.flange_a) annotation (Line(
          points={{-40,50},{-20,50}}));
      connect(inertia3.flange_b, spring1.flange_a) annotation (Line(
          points={{-40,-10},{-30,-10}}));
      connect(spring1.flange_b, spring2.flange_a) annotation (Line(
          points={{-10,-10},{0,-10}}));
      connect(spring2.flange_b, inertia4.flange_a) annotation (Line(
          points={{20,-10},{30,-10}}));
      annotation (experiment(StopTime=1.1));
    end ConnectionPossibilities;

    model SupportTorque1
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Sine sine2(f=1) annotation (Placement(
            transformation(extent={{-100,0},{-80,20}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=true)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation (
          Placement(transformation(extent={{-60,-20},{-40,0}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia3(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-30,
                0},{-10,20}})));
      Modelica.Mechanics.Rotational.Components.IdealGear idealGear2(ratio=1,
          useSupport=true) annotation (Placement(transformation(extent={{0,0},{
                20,20}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia4(J=1)
        annotation (Placement(transformation(extent={{60,0},{80,20}})));
      Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction1(
         useSupport=true) annotation (Placement(transformation(extent={{30,0},{
                50,20}})));
    equation
      connect(sine2.y, torque2.tau) annotation (Line(
          points={{-79,10},{-62,10}}, color={0,0,127}));
      connect(torque2.support, fixed1.flange) annotation (Line(
          points={{-50,0},{-50,-10}}));
      connect(torque2.flange, inertia3.flange_a) annotation (Line(
          points={{-40,10},{-30,10}}));
      connect(fixed1.flange, idealGear2.support) annotation (Line(
          points={{-50,-10},{10,-10},{10,0}}));
      connect(inertia3.flange_b, idealGear2.flange_a) annotation (Line(
          points={{-10,10},{0,10}}));
      connect(idealGear2.flange_b, bearingFriction1.flange_a) annotation (Line(
          points={{20,10},{30,10}}));
      connect(bearingFriction1.flange_b, inertia4.flange_a) annotation (Line(
          points={{50,10},{60,10}}));
      connect(fixed1.flange, bearingFriction1.support) annotation (Line(
          points={{-50,-10},{40,-10},{40,0}}));
      annotation (experiment(StopTime=1.1));
    end SupportTorque1;

    model Directions
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Sine sine(f=1) annotation (Placement(
            transformation(extent={{-80,50},{-60,70}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=true)
        annotation (Placement(transformation(extent={{-44,50},{-24,70}})));
      Modelica.Mechanics.Rotational.Components.Inertia J1(
        J=0.2,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10,
                50},{10,70}})));
      Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio=5,
          useSupport=true) annotation (Placement(transformation(extent={{20,50},
                {40,70}})));
      Modelica.Mechanics.Rotational.Components.Inertia J2(J=5) annotation (
          Placement(transformation(extent={{52,50},{72,70}})));
      Modelica.Blocks.Sources.Sine sine1(f=1) annotation (Placement(
            transformation(extent={{-80,-10},{-60,10}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=true)
        annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
      Modelica.Mechanics.Rotational.Components.Inertia J3(
        J=0.2,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10,
                -10},{10,10}})));
      Modelica.Mechanics.Rotational.Components.IdealGear gear1(ratio=1/5,
          useSupport=true) annotation (Placement(transformation(extent={{40,-10},
                {20,10}})));
      Modelica.Mechanics.Rotational.Components.Inertia J4(J=5) annotation (
          Placement(transformation(extent={{52,-10},{72,10}})));
      Modelica.Blocks.Sources.Sine sine2(f=1) annotation (Placement(
            transformation(extent={{-80,-70},{-60,-50}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=true)
        annotation (Placement(transformation(extent={{-44,-70},{-24,-50}})));
      Modelica.Mechanics.Rotational.Components.Inertia J5(
        J=0.2,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10,
                -70},{10,-50}})));
      Modelica.Mechanics.Rotational.Components.IdealGear gear2(ratio=1/5,
          useSupport=true) annotation (Placement(transformation(extent={{40,-70},
                {20,-50}})));
      Modelica.Mechanics.Rotational.Components.Inertia J6(J=5) annotation (
          Placement(transformation(extent={{72,-70},{52,-50}})));
      Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation (
          Placement(transformation(extent={{-10,30},{10,50}})));
      Modelica.Mechanics.Rotational.Components.Fixed fixed2 annotation (
          Placement(transformation(extent={{-10,-26},{10,-6}})));
      Modelica.Mechanics.Rotational.Components.Fixed fixed3 annotation (
          Placement(transformation(extent={{-10,-90},{10,-70}})));
    equation
      connect(sine.y, torque.tau) annotation (Line(
          points={{-59,60},{-46,60}}, color={0,0,127}));
      connect(torque.flange, J1.flange_a) annotation (Line(
          points={{-24,60},{-10,60}}));
      connect(gear.flange_b, J2.flange_a) annotation (Line(
          points={{40,60},{52,60}}));
      connect(J1.flange_b, gear.flange_a) annotation (Line(
          points={{10,60},{20,60}}));
      connect(sine1.y, torque1.tau) annotation (Line(
          points={{-59,0},{-46,0}}, color={0,0,127}));
      connect(torque1.flange, J3.flange_a) annotation (Line(
          points={{-24,0},{-10,0}}));
      connect(J3.flange_b, gear1.flange_b) annotation (Line(
          points={{10,0},{20,0}}));
      connect(gear1.flange_a, J4.flange_a) annotation (Line(
          points={{40,0},{52,0}}));
      connect(sine2.y, torque2.tau) annotation (Line(
          points={{-59,-60},{-46,-60}}, color={0,0,127}));
      connect(torque2.flange, J5.flange_a) annotation (Line(
          points={{-24,-60},{-10,-60}}));
      connect(J5.flange_b, gear2.flange_b) annotation (Line(
          points={{10,-60},{20,-60}}));
      connect(gear2.flange_a, J6.flange_b) annotation (Line(
          points={{40,-60},{52,-60}}));
      connect(torque.support, fixed1.flange) annotation (Line(
          points={{-34,50},{-34,40},{0,40}}));
      connect(fixed1.flange, gear.support) annotation (Line(
          points={{0,40},{30,40},{30,50}}));
      connect(torque1.support, fixed2.flange) annotation (Line(
          points={{-34,-10},{-34,-16},{0,-16}}));
      connect(fixed2.flange, gear1.support) annotation (Line(
          points={{0,-16},{30,-16},{30,-10}}));
      connect(torque2.support, fixed3.flange) annotation (Line(
          points={{-34,-70},{-34,-80},{0,-80}}));
      connect(fixed3.flange, gear2.support) annotation (Line(
          points={{0,-80},{30,-80},{30,-70}}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics={Polygon(
                  points={{-23,87},{-13,84},{-23,81},{-23,87}},
                  fillPattern=FillPattern.Solid),Line(points={{-23,84},{-53,84}}),Text(
                  extent={{-18,88},{72,80}},
                  textString="(positive) axis of rotation")}), experiment(
            StopTime=2));
    end Directions;

    model Directions2
      extends Modelica.Icons.Example;

      Modelica.Mechanics.Rotational.Components.Inertia J2(
        J=5,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-60,
                55},{-40,75}})));
      Modelica.Mechanics.Rotational.Components.Inertia J4(
        J=5,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-8,
                55},{12,75}})));
      Modelica.Mechanics.Rotational.Components.Inertia J6(
        J=5,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                65,55},{45,75}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia1(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-30,
                -10},{-10,10}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                10,-10},{30,10}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia3(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-80,
                -100},{-60,-80}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia4(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-6,
                -64},{-26,-44}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia5(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{0,
                -100},{20,-80}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia6(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(
            origin={40,-50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=true)
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=true)
        annotation (Placement(transformation(extent={{60,-10},{40,10}})));
      Modelica.Blocks.Sources.Sine sine1(f=1) annotation (Placement(
            transformation(extent={{-90,-10},{-70,10}})));
      Modelica.Blocks.Sources.Sine sine2(f=1) annotation (Placement(
            transformation(extent={{90,-10},{70,10}})));
      Modelica.Mechanics.Rotational.Components.IdealPlanetary idealPlanetary1(
          ratio=2) annotation (Placement(transformation(extent={{-50,-100},{-30,
                -80}})));
      Modelica.Mechanics.Rotational.Components.IdealPlanetary idealPlanetary2(
          ratio=2) annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
      Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation (
          Placement(transformation(extent={{-60,-27},{-40,-7}})));
      Modelica.Mechanics.Rotational.Components.Fixed fixed2 annotation (
          Placement(transformation(extent={{40,-24},{60,-4}})));
    equation
      connect(torque1.flange, inertia1.flange_a) annotation (Line(
          points={{-40,0},{-37.5,0},{-37.5,0},{-35,0},{-35,
              0},{-30,0}}));
      connect(sine1.y, torque1.tau) annotation (Line(
          points={{-69,0},{-67.25,0},{-67.25,0},{-65.5,0},
              {-65.5,0},{-62,0}}, color={0,0,127}));
      connect(torque2.flange, inertia2.flange_b) annotation (Line(
          points={{40,0},{37.5,0},{37.5,0},{35,0},{35,0},
              {30,0}}));
      connect(sine2.y, torque2.tau) annotation (Line(
          points={{69,0},{67.25,0},{67.25,0},{65.5,0},{
              65.5,0},{62,0}}, color={0,0,127}));
      connect(idealPlanetary1.sun, inertia3.flange_b) annotation (Line(
          points={{-50,-90},{-60,-90}}));
      connect(idealPlanetary1.carrier, inertia4.flange_b) annotation (Line(
          points={{-50,-86},{-56,-86},{-56,-54},{-26,-54}}));
      connect(inertia5.flange_b, idealPlanetary2.sun) annotation (Line(
          points={{20,-90},{60,-90}}));
      connect(inertia6.flange_a, idealPlanetary2.carrier) annotation (Line(
          points={{40,-60},{40,-86},{60,-86}}));
      connect(torque1.support, fixed1.flange) annotation (Line(
          points={{-50,-10},{-50,-17}}));
      connect(fixed2.flange, torque2.support) annotation (Line(
          points={{50,-14},{50,-10}}));
      annotation (Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}),
              graphics={Text(
                  extent={{-28,94},{62,86}},
                  textString="(positive) axis of rotation"),Line(points={{-61,
              65},{-80,65}}),Polygon(
                  points={{-68,67},{-61,65},{-68,63},{-68,67}},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-57,69},{-91,73}},
                  textString="J2.flange_a.tau"),Line(points={{-42,45},{-61,45}}),Polygon(
                  points={{-49,47},{-42,45},{-49,43},{-49,47}},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-33,38},{-67,42}},
                  textString="J2.w"),Line(points={{-9,65},{-28,65}}),
              Polygon(
                  points={{-16,67},{-9,65},{-16,63},{-16,67}},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-5,69},{-39,73}},
                  textString="J4.flange_a.tau"),Line(points={{10,45},{-9,45}}),Polygon(
                  points={{3,47},{10,45},{3,43},{3,47}},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{19,38},{-15,42}},
                  textString="J4.w"),Line(points={{44,65},{25,65}}),
              Polygon(
                  points={{37,67},{44,65},{37,63},{37,67}},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{48,69},{14,73}},
                  textString="J6.flange_b.tau"),Line(points={{63,45},{44,45}}),Polygon(
                  points={{56,47},{63,45},{56,43},{56,47}},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{72,38},{38,42}},
                  textString="J6.w"),Line(points={{-32,90},{-62,90}}),
              Polygon(
                  points={{-32,93},{-22,90},{-32,87},{-32,93}},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-19,24},{71,16}},
                  textString="(positive) axis of rotation"),Line(points={{-23,
              20},{-53,20}}),Polygon(
                  points={{-23,23},{-13,20},{-23,17},{-23,23}},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-47,-47},{-54,-49},{-47,-51},{-47,-47}},
                  fillPattern=FillPattern.Solid),Line(points={{-52,-49},{-33,-49}}),Line(points={{31.5,-79.5},{31.5,-60.5}}),
              Polygon(
                  points={{29.5,-75.5},{31.5,-82.5},{33.5,-75.5},{29.5,-75.5}},
                  fillPattern=FillPattern.Solid)}), experiment(StopTime=2));
    end Directions2;

    model Directions3
      extends Modelica.Icons.Example;

      Modelica.Mechanics.Rotational.Components.Inertia J1(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-80,
                40},{-60,60}})));
      Modelica.Mechanics.Rotational.Components.Inertia J2(J=1) annotation (
          Placement(transformation(extent={{-20,40},{-40,60}})));
      Modelica.Mechanics.Rotational.Components.Inertia J3(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                20,40},{40,60}})));
      Modelica.Mechanics.Rotational.Components.Inertia J4(J=1) annotation (
          Placement(transformation(extent={{60,40},{80,60}})));
    equation
      connect(J1.flange_b, J2.flange_b) annotation (Line(
          points={{-60,50},{-40,50}}));
      connect(J3.flange_b, J4.flange_b) annotation (Line(
          points={{40,50},{50,50},{50,30},{90,30},{90,50},{80,50}}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics={Line(points={{-60,66},{-80,66}}),Polygon(
                  points={{-67,68},{-60,66},{-67,64},{-67,68}},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-34,68},{-41,66},{-34,64},{-34,68}},
                  fillPattern=FillPattern.Solid),Line(points={{-20,66},{-39,66}}),Text(
                  extent={{-10,60},{14,40}},
                  textString="="),Line(points={{40,66},{20,66}}),
              Polygon(
                  points={{33,68},{40,66},{33,64},{33,68}},
                  fillPattern=FillPattern.Solid),Line(points={{80,66},{60,66}}),Polygon(
                  points={{73,68},{80,66},{73,64},{73,68}},
                  fillPattern=FillPattern.Solid)}), experiment(StopTime=2));
    end Directions3;
  end ForUsersGuide;

  package InitializationConversion
    extends Modelica.Icons.ExamplesPackage;
    model Inertia
      extends Modelica.Icons.Example;

      Modelica.Mechanics.Rotational.Components.Inertia inertia1(
        J=1,
        phi(start=0.017453292519943, fixed=true),
        w(start=2, fixed=true)) annotation (Placement(transformation(extent={{-90,
                40},{-70,60}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2(
        J=1,
        stateSelect=StateSelect.default,
        w(fixed=true, start=2),
        phi(fixed=false, start=0.017453292519943),
        a(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10,
                40},{10,60}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia3(
        J=1,
        stateSelect=StateSelect.prefer,
        a(fixed=false),
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                40,40},{60,60}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia4(
        J=1,
        stateSelect=StateSelect.always,
        a(fixed=false),
        w(fixed=true, start=-2),
        phi(fixed=true, start=-0.017453292519943)) annotation (Placement(
            transformation(extent={{80,40},{100,60}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia5(
        J=1,
        stateSelect=StateSelect.avoid,
        a(fixed=false),
        w(fixed=true, start=33),
        phi(fixed=true, start=0.38397243543875)) annotation (Placement(
            transformation(extent={{-90,0},{-70,20}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia6(
        J=1,
        a(fixed=true, start=44),
        phi(fixed=false),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10,
                0},{10,20}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia7(
        J=1,
        a(fixed=true, start=3),
        phi(fixed=true, start=0.017453292519943),
        w(fixed=true, start=2)) annotation (Placement(transformation(extent={{
                20,0},{40,20}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia7a(
        J=1,
        a(start=3),
        phi(start=0.017453292519943),
        w(start=2, fixed=true)) annotation (Placement(transformation(extent={{
                80,0},{100,20}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia8(
        J=1,
        w(fixed=true, start=0),
        a(fixed=true, start=0),
        phi(fixed=false, start=0)) annotation (Placement(transformation(extent=
                {{-80,-40},{-60,-20}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia8a(
        J=1,
        phi(fixed=true, start=0),
        w(start=0, fixed=true)) annotation (Placement(transformation(extent={{-20,
                -40},{0,-20}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia9(
        J=1,
        a(fixed=true, start=33),
        w(fixed=true, start=22),
        phi(fixed=true, start=0.19198621771938)) annotation (Placement(
            transformation(extent={{20,-40},{40,-20}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia9a(
        J=1,
        a(start=33),
        phi(start=0.19198621771938),
        w(start=22, fixed=true)) annotation (Placement(transformation(extent={{
                80,-40},{100,-20}})));
      Modelica.Mechanics.Rotational.Components.Spring spring(c=10000)
        annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
      Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (
          Placement(transformation(extent={{-60,40},{-40,60}})));
      Modelica.Mechanics.Rotational.Components.Spring spring1(c=10000)
        annotation (Placement(transformation(extent={{50,0},{70,20}})));
      Modelica.Mechanics.Rotational.Components.Spring spring2(c=10000)
        annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
      Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation (
          Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica.Mechanics.Rotational.Components.Spring spring3(c=10000)
        annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
      Modelica.Mechanics.Rotational.Components.Spring spring4(c=10000)
        annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
    equation
      connect(spring.flange_b, inertia2.flange_a) annotation (Line(
          points={{-20,50},{-10,50}}));
      connect(fixed.flange, spring.flange_a) annotation (Line(
          points={{-50,50},{-40,50}}));
      connect(inertia7.flange_b, spring1.flange_a) annotation (Line(
          points={{40,10},{50,10}}));
      connect(spring1.flange_b, inertia7a.flange_a) annotation (Line(
          points={{70,10},{80,10}}));
      connect(spring2.flange_b, inertia6.flange_a) annotation (Line(
          points={{-20,10},{-10,10}}));
      connect(fixed1.flange, spring2.flange_a) annotation (Line(
          points={{-50,10},{-40,10}}));
      connect(inertia8.flange_b, spring3.flange_a) annotation (Line(
          points={{-60,-30},{-50,-30}}));
      connect(spring3.flange_b, inertia8a.flange_a) annotation (Line(
          points={{-30,-30},{-20,-30}}));
      connect(inertia9.flange_b, spring4.flange_a) annotation (Line(
          points={{40,-30},{50,-30}}));
      connect(spring4.flange_b, inertia9a.flange_a) annotation (Line(
          points={{70,-30},{80,-30}}));
      annotation (experiment(StopTime=1.1), Diagram(graphics={Rectangle(
              extent={{-90,98},{90,64}},
              lineColor={255,170,85},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid), Text(
              extent={{-80,100},{80,60}},
              textColor={0,0,255},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              textString="Since the initialization was changed some elements here
are redundant (e.g. inertia4, inertia5).
But for compatibility reasons they were not deleted yet.")}));
    end Inertia;

    model SpringDamper
      extends Modelica.Icons.Example;

      Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (
          Placement(transformation(extent={{-100,60},{-80,80}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia1(J=1)
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=1)
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia3(J=1)
        annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia4(J=1, w(fixed=
              true, start=0)) annotation (Placement(transformation(extent={{-40,
                -60},{-20,-40}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia5(J=1, phi(fixed=
              true, start=0)) annotation (Placement(transformation(extent={{-40,
                -100},{-20,-80}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia6(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                20,40},{40,60}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia7(J=1)
        annotation (Placement(transformation(extent={{74,40},{94,60}})));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper1(
        c=1e4,
        d=10,
        w_rel(start=2, fixed=true),
        phi_rel(start=1, fixed=true)) annotation (Placement(transformation(
              extent={{-70,60},{-50,80}})));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper2(
        c=1e4,
        d=10,
        stateSelect=StateSelect.prefer,
        a_rel(fixed=true),
        w_rel(fixed=true, start=-2),
        phi_rel(fixed=false, start=-1)) annotation (Placement(transformation(
              extent={{-70,20},{-50,40}})));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper3(
        c=1e4,
        d=10,
        stateSelect=StateSelect.always,
        a_rel(fixed=false),
        w_rel(fixed=true, start=2),
        phi_rel(fixed=true, start=1)) annotation (Placement(transformation(
              extent={{-70,-20},{-50,0}})));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper4(
        c=1e4,
        d=10,
        stateSelect=StateSelect.avoid,
        a_rel(fixed=false),
        phi_rel(fixed=true),
        w_rel(fixed=false)) annotation (Placement(transformation(extent={{-70,-60},
                {-50,-40}})));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper5(
        c=1e4,
        d=10,
        stateSelect=StateSelect.never,
        a_rel(fixed=false),
        phi_rel(fixed=false),
        w_rel(fixed=true, start=3)) annotation (Placement(transformation(extent=
               {{-70,-100},{-50,-80}})));
      Modelica.Mechanics.Rotational.Components.Spring spring(c=1e4) annotation (
         Placement(transformation(extent={{48,40},{68,60}})));
      Modelica.Mechanics.Rotational.Components.RelativeStates relativeStates(
          phi_rel(fixed=true), w_rel(fixed=true)) annotation (Placement(
            transformation(extent={{48,20},{68,40}})));
    equation
      connect(springDamper1.flange_a, fixed.flange) annotation (Line(
          points={{-70,70},{-90,70}}));
      connect(springDamper1.flange_b, inertia1.flange_a) annotation (Line(
          points={{-50,70},{-40,70}}));
      connect(inertia2.flange_a, springDamper2.flange_b) annotation (Line(
          points={{-40,30},{-50,30}}));
      connect(springDamper2.flange_a, fixed.flange) annotation (Line(
          points={{-70,30},{-80,30},{-80,70},{-90,70}}));
      connect(inertia3.flange_a, springDamper3.flange_b) annotation (Line(
          points={{-40,-10},{-50,-10}}));
      connect(springDamper3.flange_a, fixed.flange) annotation (Line(
          points={{-70,-10},{-80,-10},{-80,70},{-90,70}}));
      connect(inertia4.flange_a, springDamper4.flange_b) annotation (Line(
          points={{-40,-50},{-50,-50}}));
      connect(springDamper4.flange_a, fixed.flange) annotation (Line(
          points={{-70,-50},{-80,-50},{-80,70},{-90,70}}));
      connect(inertia5.flange_a, springDamper5.flange_b) annotation (Line(
          points={{-40,-90},{-50,-90}}));
      connect(springDamper5.flange_a, fixed.flange) annotation (Line(
          points={{-70,-90},{-80,-90},{-80,70},{-90,70}}));
      connect(inertia6.flange_b, spring.flange_a) annotation (Line(
          points={{40,50},{48,50}}));
      connect(spring.flange_b, inertia7.flange_a) annotation (Line(
          points={{68,50},{74,50}}));
      connect(relativeStates.flange_b, spring.flange_b) annotation (Line(
          points={{68,30},{68,50}}));
      connect(spring.flange_a, relativeStates.flange_a) annotation (Line(
          points={{48,50},{48,30}}));
      annotation (experiment(StopTime=1.1), Diagram(graphics={Polygon(
                  points={{-72,86},{-72,54},{-14,54},{-14,6},{-72,6},{-72,-32},
                {100,-32},{100,20},{10,20},{10,86},{-72,86}},
                  lineColor={255,170,85},
                  fillColor={255,213,170},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{10,20},{90,-30}},
                  textColor={0,0,255},
                  textString="This two parts are identical
concerning structure, parameters
and initialization.
But for compatibility reasons
they were not deleted yet.")}));
    end SpringDamper;

  end InitializationConversion;

  model TestSpeed
    extends Modelica.Icons.Example;

    Modelica.Mechanics.Rotational.Sources.Speed speed1(f_crit=5, useSupport=
          false) annotation (Placement(transformation(extent={{-20,60},{0,80}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(J=1) annotation (
        Placement(transformation(extent={{20,60},{40,80}})));
    Modelica.Mechanics.Rotational.Sources.Speed speed2(
      f_crit=5,
      exact=true,
      useSupport=false) annotation (Placement(transformation(extent={{-20,20},{
              0,40}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=1) annotation (
        Placement(transformation(extent={{20,20},{40,40}})));
    Modelica.Blocks.Sources.Sine sine2(f=1) annotation (Placement(
          transformation(extent={{-60,20},{-40,40}})));
    Modelica.Blocks.Sources.Step step(startTime=0.5) annotation (Placement(
          transformation(extent={{-60,60},{-40,80}})));
    Modelica.Mechanics.Translational.Sources.Speed speed3(f_crit=5, s(start=1))
      annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
    Modelica.Mechanics.Translational.Components.Mass mass1(m=2) annotation (
        Placement(transformation(extent={{20,-20},{40,0}})));
    Modelica.Blocks.Sources.Step step1(startTime=0.5) annotation (Placement(
          transformation(extent={{-60,-20},{-40,0}})));
    Modelica.Mechanics.Translational.Sources.Speed speed4(exact=true, s(start=1))
      annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
    Modelica.Mechanics.Translational.Components.Mass mass2(m=2) annotation (
        Placement(transformation(extent={{20,-60},{40,-40}})));
    Modelica.Blocks.Sources.Sine sine4(f=1) annotation (Placement(
          transformation(extent={{-60,-60},{-40,-40}})));
  equation
    connect(speed1.flange, inertia1.flange_a)
      annotation (Line(points={{0,70},{20,70}}));
    connect(speed2.flange, inertia2.flange_a)
      annotation (Line(points={{0,30},{20,30}}));
    connect(sine2.y, speed2.w_ref)
      annotation (Line(points={{-39,30},{-22,30}}, color={0,0,127}));
    connect(step.y, speed1.w_ref)
      annotation (Line(points={{-39,70},{-22,70}}, color={0,0,127}));
    connect(speed3.flange, mass1.flange_a)
      annotation (Line(points={{0,-10},{20,-10}}, color={0,127,0}));
    connect(step1.y, speed3.v_ref)
      annotation (Line(points={{-39,-10},{-22,-10}}, color={0,0,127}));
    connect(speed4.flange, mass2.flange_a)
      annotation (Line(points={{0,-50},{20,-50}}, color={0,127,0}));
    connect(sine4.y, speed4.v_ref)
      annotation (Line(points={{-39,-50},{-22,-50}}, color={0,0,127}));
    annotation (experiment(StopTime=1.1));
  end TestSpeed;

  model TestMove
    extends Modelica.Icons.Example;

    Modelica.Mechanics.MultiBody.Parts.Body Body1(
      I_33=2,
      r_CM={0,0,0},
      m=1) annotation (Placement(transformation(extent={{66,36},{86,56}})));
    Modelica.Mechanics.MultiBody.Joints.Revolute ActuatedRevolute1(
        useAxisFlange=true) annotation (Placement(transformation(extent={{32,0},
              {52,20}})));
    inner Modelica.Mechanics.MultiBody.World world(g=0) annotation (Placement(
          transformation(extent={{0,0},{20,20}})));
    Modelica.Mechanics.Rotational.Sources.Move move(useSupport=false)
      annotation (Placement(transformation(extent={{20,40},{40,60}})));
    Modelica.Blocks.Routing.Multiplex Multiplex3_1(n=3) annotation (Placement(
          transformation(extent={{-56,40},{-36,60}})));
    Modelica.Blocks.Sources.Constant Constant1(k=1) annotation (Placement(
          transformation(extent={{-100,16},{-80,36}})));
    Modelica.Blocks.Sources.Constant Constant2(k=0) annotation (Placement(
          transformation(extent={{-100,70},{-80,90}})));
    Modelica.Mechanics.Translational.Sources.Move move1 annotation (Placement(
          transformation(extent={{-20,-40},{0,-20}})));
    Modelica.Mechanics.Translational.Components.Mass slidingMass(m=2)
      annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  equation
    connect(ActuatedRevolute1.frame_b, Body1.frame_a) annotation (Line(
        points={{52,10},{62,10},{62,46},{66,46}},
        thickness=0.5));
    connect(world.frame_b, ActuatedRevolute1.frame_a) annotation (Line(
        points={{20,10},{32,10}},
        thickness=0.5));
    connect(move.flange, ActuatedRevolute1.axis)
      annotation (Line(points={{40,50},{42,50},{42,20}}));
    connect(Multiplex3_1.y, move.u)
      annotation (Line(points={{-35,50},{18,50}}, color={0,0,127}));
    connect(Constant1.y, Multiplex3_1.u[3]) annotation (Line(points={{-79,26},
            {-74,26},{-74,43},{-58,43}}, color={0,0,127}));
    connect(Constant2.y, Multiplex3_1.u[1]) annotation (Line(points={{-79,80},
            {-74,80},{-74,57},{-58,57}}, color={0,0,127}));
    connect(Constant2.y, Multiplex3_1.u[2]) annotation (Line(points={{-79,80},
            {-74,80},{-74,50},{-58,50}}, color={0,0,127}));
    connect(Multiplex3_1.y, move1.u) annotation (Line(points={{-35,50},{-28,50},
            {-28,-30},{-22,-30}}, color={0,0,127}));
    connect(move1.flange, slidingMass.flange_a)
      annotation (Line(points={{0,-30},{20,-30}}, color={0,127,0}));
    annotation (experiment(StopTime=1.1));
  end TestMove;

  model AllComponents
    extends Modelica.Icons.Example;

    Modelica.Mechanics.Rotational.Components.Inertia inertia(J=3) annotation (
        Placement(transformation(extent={{-80,80},{-60,100}})));
    Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio=3,
        useSupport=true) annotation (Placement(transformation(extent={{-50,80},
              {-30,100}})));
    Modelica.Mechanics.Rotational.Components.IdealPlanetary idealPlanetary(
        ratio=3) annotation (Placement(transformation(extent={{-16,80},{4,100}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (Placement(
          transformation(extent={{-50,50},{-30,70}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(J=2) annotation (
        Placement(transformation(extent={{-50,120},{-30,140}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2(
      J=4,
      phi(start=0, fixed=true),
      w(start=0, fixed=true)) annotation (Placement(transformation(extent={{40,
              80},{60,100}})));
    Modelica.Mechanics.Rotational.Components.Spring spring(c=1e4) annotation (
        Placement(transformation(extent={{12,80},{32,100}})));
    Modelica.Mechanics.Rotational.Components.Damper damper(
      d=10,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{12,98},{
              32,118}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper springDamper(
      c=1e4,
      d=10,
      phi_rel0=1.7453292519943e-05,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{-78,120},
              {-58,140}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia3(
      J=2,
      phi(start=0.0174532925199433),
      w(start=2)) annotation (Placement(transformation(extent={{-112,120},{-92,
              140}})));
    Modelica.Mechanics.Rotational.Components.ElastoBacklash elastoBacklash(
      c=1e4,
      d=20,
      b=1.7453292519943e-07,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{-10,120},
              {10,140}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia4(J=2) annotation (
        Placement(transformation(extent={{20,120},{40,140}})));
    Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
      tau_pos=[0, 2],
      peak=1.1,
      useSupport=true) annotation (Placement(transformation(extent={{44,120},{
              64,140}})));
    Modelica.Mechanics.Rotational.Components.Clutch clutch(
      mu_pos=[0, 1],
      peak=1.1,
      cgeo=1.2,
      fn_max=1.3,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{-106,100},
              {-86,80}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia5(J=3) annotation (
        Placement(transformation(extent={{-136,80},{-116,100}})));
    Modelica.Blocks.Sources.Sine sine(f=1) annotation (Placement(
          transformation(extent={{-124,50},{-104,70}})));
    Modelica.Mechanics.Rotational.Components.Brake brake(useSupport=true,
        fn_max=1) annotation (Placement(transformation(extent={{80,80},{100,100}})));
    Modelica.Blocks.Sources.Sine sine1(f=1) annotation (Placement(
          transformation(
          origin={90,130},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(useSupport=
          true, ratio=1) annotation (Placement(transformation(extent={{-140,120},
              {-120,140}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia6(
      J=2,
      a(fixed=false),
      phi(fixed=true, start=0.0174532925199433),
      w(fixed=true, start=2)) annotation (Placement(transformation(extent={{-170,
              120},{-150,140}})));
    Modelica.Mechanics.Rotational.Components.Gearbox gear2_1(
      ratio=2,
      lossTable=[0, 0.9, 1, 0, 0],
      c=1e4,
      d=10,
      useSupport=true,
      b=1.7453292519943e-07,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{-100,0},
              {-80,20}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia7(J=3) annotation (
        Placement(transformation(extent={{-130,0},{-110,20}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia8(
      J=3,
      phi(start=0, fixed=true),
      w(start=0, fixed=true)) annotation (Placement(transformation(extent={{-68,
              0},{-48,20}})));
    Modelica.Mechanics.Rotational.Sources.Position position(useSupport=true, w(
          fixed=true)) annotation (Placement(transformation(extent={{30,30},{50,
              50}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation (Placement(
          transformation(extent={{-100,-20},{-80,0}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed2 annotation (Placement(
          transformation(extent={{28,10},{48,30}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia9(J=3) annotation (
        Placement(transformation(extent={{60,30},{80,50}})));
    Modelica.Blocks.Sources.Sine sine2(f=1) annotation (Placement(
          transformation(extent={{0,30},{20,50}})));
    Modelica.Blocks.Sources.Sine sine3(f=1) annotation (Placement(
          transformation(extent={{0,-20},{20,0}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia10(J=3) annotation (
       Placement(transformation(extent={{60,-20},{80,0}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed3 annotation (Placement(
          transformation(extent={{30,-40},{50,-20}})));
    Modelica.Mechanics.Rotational.Sources.Speed speed(useSupport=true)
      annotation (Placement(transformation(extent={{30,-20},{50,0}})));
    Modelica.Blocks.Sources.Sine sine4(f=1) annotation (Placement(
          transformation(extent={{0,-80},{20,-60}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia11(J=3) annotation (
       Placement(transformation(extent={{60,-80},{80,-60}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed4 annotation (Placement(
          transformation(extent={{30,-100},{50,-80}})));
    Modelica.Mechanics.Rotational.Sources.Accelerate accelerate(useSupport=true)
      annotation (Placement(transformation(extent={{30,-80},{50,-60}})));
    Modelica.Blocks.Sources.Sine sine5[3](each amplitude=2, f={1,1,1})
      annotation (Placement(transformation(extent={{0,-140},{20,-120}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia12(J=3) annotation (
       Placement(transformation(extent={{60,-140},{80,-120}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed5 annotation (Placement(
          transformation(extent={{30,-160},{50,-140}})));
    Modelica.Mechanics.Rotational.Sources.Move move(useSupport=true)
      annotation (Placement(transformation(extent={{30,-140},{50,-120}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=true)
      annotation (Placement(transformation(extent={{130,80},{110,100}})));
    Modelica.Blocks.Sources.Sine sine6(f=1) annotation (Placement(
          transformation(extent={{160,80},{140,100}})));
    Modelica.Mechanics.Rotational.Sources.Torque2 torque2_1 annotation (
        Placement(transformation(extent={{92,-20},{112,0}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia13(
      J=3,
      phi(start=0, fixed=true),
      w(start=0, fixed=true)) annotation (Placement(transformation(extent={{120,
              -20},{140,0}})));
    Modelica.Blocks.Sources.Sine sine7(f=1) annotation (Placement(
          transformation(extent={{74,6},{94,26}})));
    Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
      linearSpeedDependentTorque(
      tau_nominal=10,
      w_nominal=10,
      useSupport=true) annotation (Placement(transformation(extent={{-162,0},{-142,
              20}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque(
      tau_nominal=100,
      w_nominal=1,
      useSupport=true) annotation (Placement(transformation(extent={{-10,0},{-32,
              20}})));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(
        tau_constant=11, useSupport=true) annotation (Placement(transformation(
            extent={{-140,-60},{-120,-40}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia14(
      J=3,
      phi(start=0, fixed=true),
      w(start=0, fixed=true)) annotation (Placement(transformation(extent={{-104,
              -80},{-84,-60}})));
    Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep(
      stepTorque=22,
      offsetTorque=11,
      startTime=1,
      useSupport=true) annotation (Placement(transformation(extent={{-140,-100},
              {-120,-80}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed6 annotation (Placement(
          transformation(extent={{-140,-120},{-120,-100}})));
    Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=
          11, useSupport=true) annotation (Placement(transformation(extent={{-90,
              -110},{-70,-90}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia15(J=3, phi(start=0,
          fixed=true)) annotation (Placement(transformation(extent={{-60,-110},
              {-40,-90}})));
    Modelica.Mechanics.Rotational.Components.RelativeStates relativeStates
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
    Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation (
        Placement(transformation(extent={{98,-80},{118,-60}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
        Placement(transformation(extent={{98,-56},{118,-36}})));
    Modelica.Mechanics.Rotational.Sensors.AccSensor accSensor annotation (
        Placement(transformation(extent={{98,-106},{118,-86}})));
    Modelica.Mechanics.Rotational.Sensors.RelAngleSensor relAngleSensor
      annotation (Placement(transformation(extent={{120,30},{140,50}})));
    Modelica.Mechanics.Rotational.Sensors.RelSpeedSensor relSpeedSensor
      annotation (Placement(transformation(extent={{146,-48},{166,-28}})));
    Modelica.Mechanics.Rotational.Sensors.RelAccSensor relAccSensor annotation (
       Placement(transformation(extent={{140,-90},{160,-70}})));
    Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor annotation (
       Placement(transformation(extent={{-60,-150},{-40,-130}})));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor annotation (
        Placement(transformation(extent={{-90,-150},{-70,-130}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia16(J=3) annotation (
       Placement(transformation(extent={{-120,-150},{-100,-130}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia17(
                                                              J=2,
      phi(fixed=true, start=0),
      w(fixed=true, start=0))                                      annotation (
        Placement(transformation(extent={{-70,-190},{-50,-170}})));
    Modelica.Mechanics.Rotational.Components.ElastoBacklash2 elastoBacklash2(
      c=1e4,
      d=20,
      phi_rel(fixed=true),
      w_rel(fixed=true),
      b=1.7453292519943e-07,
      stateSelect=StateSelect.always)
                         annotation (Placement(transformation(extent={{-30,-190},{
              -10,-170}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia18(
                                                              J=2) annotation (
        Placement(transformation(extent={{0,-190},{20,-170}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque1
      annotation (Placement(transformation(extent={{-96,-190},{-76,-170}})));
    Modelica.Blocks.Sources.ExpSine expSine(f=2, damping=0.5)
      annotation (Placement(transformation(extent={{-140,-190},{-120,-170}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia19(
      J=2,
      phi(start=0),
      w(start=0))                                                  annotation (
        Placement(transformation(extent={{-80,-230},{-60,-210}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia20(J=2)
                                                                   annotation (
        Placement(transformation(extent={{-20,-230},{0,-210}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque2
      annotation (Placement(transformation(extent={{30,-230},{10,-210}})));
    Modelica.Mechanics.Rotational.Components.Coupling coupling
      annotation (Placement(transformation(extent={{-50,-230},{-30,-210}})));
    Modelica.Mechanics.Rotational.Sources.Speed speed2(useSupport=false, exact=true)
      annotation (Placement(transformation(extent={{-110,-230},{-90,-210}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=100,
      duration=0.5,
      offset=0,
      startTime=0)
      annotation (Placement(transformation(extent={{-140,-230},{-120,-210}})));
    Modelica.Blocks.Sources.Step step(
      height=400,
      offset=0,
      startTime=0.75)
      annotation (Placement(transformation(extent={{60,-230},{40,-210}})));
  equation
    connect(inertia.flange_b, idealGear.flange_a) annotation (Line(
        points={{-60,90},{-50,90}}));
    connect(idealGear.flange_b, idealPlanetary.sun) annotation (Line(
        points={{-30,90},{-16,90}}));
    connect(idealGear.support, fixed.flange) annotation (Line(
        points={{-40,80},{-40,60}}));
    connect(idealPlanetary.carrier, inertia1.flange_b) annotation (Line(
        points={{-16,94},{-22,94},{-22,130},{-30,130}}));
    connect(idealPlanetary.ring, spring.flange_a) annotation (Line(
        points={{4,90},{12,90}}));
    connect(spring.flange_b, inertia2.flange_a) annotation (Line(
        points={{32,90},{40,90}}));
    connect(idealPlanetary.ring, damper.flange_a) annotation (Line(
        points={{4,90},{8,90},{8,108},{12,108}}));
    connect(damper.flange_b, inertia2.flange_a) annotation (Line(
        points={{32,108},{40,108},{40,90}}));
    connect(springDamper.flange_b, inertia1.flange_a) annotation (Line(
        points={{-58,130},{-50,130}}));
    connect(inertia3.flange_b, springDamper.flange_a) annotation (Line(
        points={{-92,130},{-78,130}}));
    connect(inertia1.flange_b, elastoBacklash.flange_a) annotation (Line(
        points={{-30,130},{-10,130}}));
    connect(elastoBacklash.flange_b, inertia4.flange_a) annotation (Line(
        points={{10,130},{20,130}}));
    connect(inertia4.flange_b, bearingFriction.flange_a) annotation (Line(
        points={{40,130},{44,130}}));
    connect(fixed.flange, bearingFriction.support) annotation (Line(
        points={{-40,60},{70,60},{70,114},{54,114},{54,120}}));
    connect(clutch.flange_b, inertia.flange_a) annotation (Line(
        points={{-86,90},{-80,90}}));
    connect(inertia5.flange_b, clutch.flange_a) annotation (Line(
        points={{-116,90},{-106,90}}));
    connect(sine.y, clutch.f_normalized) annotation (Line(
        points={{-103,60},{-96,60},{-96,79}}, color={0,0,127}));
    connect(inertia2.flange_b, brake.flange_a) annotation (Line(
        points={{60,90},{80,90}}));
    connect(sine1.y, brake.f_normalized) annotation (Line(
        points={{90,119},{90,101}}, color={0,0,127}));
    connect(fixed.flange, brake.support) annotation (Line(
        points={{-40,60},{90,60},{90,80}}));
    connect(lossyGear.flange_b, inertia3.flange_a) annotation (Line(
        points={{-120,130},{-112,130}}));
    connect(inertia6.flange_b, lossyGear.flange_a) annotation (Line(
        points={{-150,130},{-140,130}}));
    connect(lossyGear.support, fixed.flange) annotation (Line(
        points={{-130,120},{-130,110},{-150,110},{-150,40},{-60,40},{-60,60},{-40,
            60}}));
    connect(inertia7.flange_b, gear2_1.flange_a) annotation (Line(
        points={{-110,10},{-100,10}}));
    connect(gear2_1.flange_b, inertia8.flange_a) annotation (Line(
        points={{-80,10},{-68,10}}));
    connect(fixed1.flange, gear2_1.support) annotation (Line(
        points={{-90,-10},{-90,0}}));
    connect(fixed2.flange, position.support) annotation (Line(
        points={{38,20},{38,30},{40,30}}));
    connect(position.flange, inertia9.flange_a) annotation (Line(
        points={{50,40},{60,40}}));
    connect(sine2.y, position.phi_ref) annotation (Line(
        points={{21,40},{28,40}}, color={0,0,127}));
    connect(sine3.y, speed.w_ref) annotation (Line(
        points={{21,-10},{28,-10}}, color={0,0,127}));
    connect(speed.flange, inertia10.flange_a) annotation (Line(
        points={{50,-10},{60,-10}}));
    connect(speed.support, fixed3.flange) annotation (Line(
        points={{40,-20},{40,-30}}));
    connect(sine4.y, accelerate.a_ref) annotation (Line(
        points={{21,-70},{28,-70}}, color={0,0,127}));
    connect(accelerate.flange, inertia11.flange_a) annotation (Line(
        points={{50,-70},{60,-70}}));
    connect(accelerate.support, fixed4.flange) annotation (Line(
        points={{40,-80},{40,-90}}));
    connect(sine5.y, move.u) annotation (Line(
        points={{21,-130},{28,-130}}, color={0,0,127}));
    connect(move.flange, inertia12.flange_a) annotation (Line(
        points={{50,-130},{60,-130}}));
    connect(move.support, fixed5.flange) annotation (Line(
        points={{40,-140},{40,-150}}));
    connect(brake.flange_b, torque.flange) annotation (Line(
        points={{100,90},{110,90}}));
    connect(fixed.flange, torque.support) annotation (Line(
        points={{-40,60},{120,60},{120,80}}));
    connect(sine6.y, torque.tau) annotation (Line(
        points={{139,90},{132,90}}, color={0,0,127}));
    connect(torque2_1.flange_a, inertia10.flange_b) annotation (Line(
        points={{92,-10},{80,-10}}));
    connect(torque2_1.flange_b, inertia13.flange_a) annotation (Line(
        points={{112,-10},{120,-10}}));
    connect(sine7.y, torque2_1.tau) annotation (Line(
        points={{95,16},{102,16},{102,-6}}, color={0,0,127}));
    connect(linearSpeedDependentTorque.flange, inertia7.flange_a) annotation (
        Line(
        points={{-142,10},{-130,10}}));
    connect(linearSpeedDependentTorque.support, fixed1.flange) annotation (Line(
        points={{-152,0},{-152,-10},{-90,-10}}));
    connect(quadraticSpeedDependentTorque.flange, inertia8.flange_b)
      annotation (Line(
        points={{-32,10},{-48,10}}));
    connect(fixed1.flange, quadraticSpeedDependentTorque.support) annotation (
        Line(
        points={{-90,-10},{-21,-10},{-21,0}}));
    connect(constantTorque.flange, inertia14.flange_a) annotation (Line(
        points={{-120,-50},{-110,-50},{-110,-70},{-104,-70}}));
    connect(torqueStep.flange, inertia14.flange_a) annotation (Line(
        points={{-120,-90},{-110,-90},{-110,-70},{-104,-70}}));
    connect(fixed6.flange, torqueStep.support) annotation (Line(
        points={{-130,-110},{-130,-100}}));
    connect(fixed6.flange, constantTorque.support) annotation (Line(
        points={{-130,-110},{-150,-110},{-150,-60},{-130,-60}}));
    connect(torqueStep.support, constantSpeed.support) annotation (Line(
        points={{-130,-100},{-130,-110},{-80,-110}}));
    connect(constantSpeed.flange, inertia15.flange_a) annotation (Line(
        points={{-70,-100},{-60,-100}}));
    connect(inertia8.flange_b, relativeStates.flange_b) annotation (Line(
        points={{-48,10},{-40,10},{-40,-30},{-60,-30}}));
    connect(relativeStates.flange_a, inertia7.flange_b) annotation (Line(
        points={{-80,-30},{-110,-30},{-110,10}}));
    connect(inertia11.flange_b, angleSensor.flange) annotation (Line(
        points={{80,-70},{98,-70}}));
    connect(inertia11.flange_b, speedSensor.flange) annotation (Line(
        points={{80,-70},{84,-70},{84,-46},{98,-46}}));
    connect(inertia11.flange_b, accSensor.flange) annotation (Line(
        points={{80,-70},{84,-70},{84,-96},{98,-96}}));
    connect(inertia9.flange_b, relAngleSensor.flange_a) annotation (Line(
        points={{80,40},{120,40}}));
    connect(inertia13.flange_b, relAngleSensor.flange_b) annotation (Line(
        points={{140,-10},{150,-10},{150,40},{140,40}}));
    connect(inertia13.flange_b, relSpeedSensor.flange_a) annotation (Line(
        points={{140,-10},{140,-38},{146,-38}}));
    connect(inertia12.flange_b, relSpeedSensor.flange_b) annotation (Line(
        points={{80,-130},{178,-130},{178,-38},{166,-38}}));
    connect(inertia13.flange_b, relAccSensor.flange_a) annotation (Line(
        points={{140,-10},{140,-80}}));
    connect(relAccSensor.flange_b, inertia12.flange_b) annotation (Line(
        points={{160,-80},{168,-80},{168,-130},{80,-130}}));
    connect(inertia15.flange_b, torqueSensor.flange_b) annotation (Line(
        points={{-40,-100},{-30,-100},{-30,-140},{-40,-140}}));
    connect(torqueSensor.flange_a, powerSensor.flange_b) annotation (Line(
        points={{-60,-140},{-70,-140}}));
    connect(inertia16.flange_b, powerSensor.flange_a) annotation (Line(
        points={{-100,-140},{-90,-140}}));
    connect(inertia17.flange_b, elastoBacklash2.flange_a) annotation (Line(
          points={{-50,-180},{-30,-180}}));
    connect(elastoBacklash2.flange_b, inertia18.flange_a)
      annotation (Line(points={{-10,-180},{0,-180}}));
    connect(inertia17.flange_a, torque1.flange) annotation (Line(points={{-70,-180},
            {-76,-180}}));
    connect(torque1.tau, expSine.y) annotation (Line(points={{-98,-180},{-119,-180}},
                                color={0,0,127}));
    connect(torque2.flange, inertia20.flange_b)
      annotation (Line(points={{10,-220},{0,-220}}, color={0,0,0}));
    connect(inertia19.flange_b, coupling.flange_a)
      annotation (Line(points={{-60,-220},{-50,-220}}, color={0,0,0}));
    connect(coupling.flange_b, inertia20.flange_a)
      annotation (Line(points={{-30,-220},{-20,-220}}, color={0,0,0}));
    connect(speed2.flange, inertia19.flange_a)
      annotation (Line(points={{-90,-220},{-80,-220}}, color={0,0,0}));
    connect(ramp.y, speed2.w_ref)
      annotation (Line(points={{-119,-220},{-112,-220}}, color={0,0,127}));
    connect(step.y, torque2.tau)
      annotation (Line(points={{39,-220},{32,-220}}, color={0,0,127}));
    annotation (experiment(StopTime=0.9), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-180,-240},{180,160}})));
  end AllComponents;

  model TestBearingConversion
    "Test, whether conversion of bearing to support is correctly performed"
    extends Modelica.Icons.Example;

    Modelica.Mechanics.Rotational.Components.IdealGear idealGear(useSupport=
          false, ratio=1) annotation (Placement(transformation(extent={{-150,
              160},{-130,180}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-180,
              160},{-160,180}})));
    Modelica.Mechanics.Rotational.Components.IdealGear idealGear1(useSupport=
          true, ratio=1) annotation (Placement(transformation(extent={{-118,160},
              {-98,180}})));
    Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
        useSupport=true) annotation (Placement(transformation(extent={{-90,160},
              {-70,180}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-180,
              110},{-160,130}})));
    Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction1(
        useSupport=false) annotation (Placement(transformation(extent={{-150,
              110},{-130,130}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (Placement(
          transformation(extent={{-118,144},{-98,164}})));
    Modelica.Mechanics.Rotational.Components.Brake brake(useSupport=true,
        fn_max=1) annotation (Placement(transformation(extent={{-150,40},{-130,
              60}})));
    Modelica.Blocks.Sources.Sine sine(f=1) annotation (Placement(
          transformation(extent={{-180,70},{-160,90}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-180,
              40},{-160,60}})));
    Modelica.Mechanics.Rotational.Components.Brake brake1(useSupport=false,
        fn_max=1) annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia3(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-100,
              40},{-80,60}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation (Placement(
          transformation(extent={{-150,20},{-130,40}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(useSupport=
          false, ratio=1) annotation (Placement(transformation(extent={{-70,110},
              {-50,130}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia4(J=1) annotation (
        Placement(transformation(extent={{-100,110},{-80,130}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia5(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-40,
              110},{-20,130}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear1(useSupport=
          true, ratio=1) annotation (Placement(transformation(extent={{30,110},
              {50,130}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia6(J=1) annotation (
        Placement(transformation(extent={{0,110},{20,130}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia7(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{60,
              110},{80,130}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed2 annotation (Placement(
          transformation(extent={{30,90},{50,110}})));
    Modelica.Mechanics.Rotational.Components.Gearbox gear2_1(
      useSupport=false,
      ratio=1,
      c=100000,
      d=0,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{30,40},{
              50,60}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia8(J=1) annotation (
        Placement(transformation(extent={{0,40},{20,60}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia9(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{60,
              40},{80,60}})));
    Modelica.Mechanics.Rotational.Sources.Position position(useSupport=false, w(
          fixed=true)) annotation (Placement(transformation(extent={{-140,-20},
              {-120,0}})));
    Modelica.Blocks.Sources.Sine sine1(f=1) annotation (Placement(
          transformation(extent={{-180,-20},{-160,0}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia12(J=1) annotation (
       Placement(transformation(extent={{-110,-20},{-90,0}})));
    Modelica.Mechanics.Rotational.Sources.Position position1(useSupport=true, w(
          fixed=true)) annotation (Placement(transformation(extent={{-140,-50},
              {-120,-30}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia13(J=1) annotation (
       Placement(transformation(extent={{-110,-50},{-90,-30}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed4 annotation (Placement(
          transformation(extent={{-140,-66},{-120,-46}})));
    Modelica.Mechanics.Rotational.Components.Gearbox gear2_2(
      useSupport=true,
      ratio=1,
      c=100000,
      d=0,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{30,160},
              {50,180}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia10(J=1) annotation (
       Placement(transformation(extent={{2,160},{22,180}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia11(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{60,
              160},{80,180}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed3 annotation (Placement(
          transformation(extent={{30,144},{50,164}})));
    Modelica.Mechanics.Rotational.Sources.Speed position2(useSupport=false)
      annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
    Modelica.Blocks.Sources.Sine sine2(f=1) annotation (Placement(
          transformation(extent={{-60,-20},{-40,0}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia14(J=1) annotation (
       Placement(transformation(extent={{10,-20},{30,0}})));
    Modelica.Mechanics.Rotational.Sources.Speed position3(useSupport=true)
      annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia15(J=1) annotation (
       Placement(transformation(extent={{10,-50},{30,-30}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed5 annotation (Placement(
          transformation(extent={{-20,-66},{0,-46}})));
    Modelica.Mechanics.Rotational.Sources.Accelerate position4(useSupport=false)
      annotation (Placement(transformation(extent={{100,-20},{120,0}})));
    Modelica.Blocks.Sources.Sine sine3(f=1) annotation (Placement(
          transformation(extent={{60,-20},{80,0}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia16(J=1) annotation (
       Placement(transformation(extent={{130,-20},{150,0}})));
    Modelica.Mechanics.Rotational.Sources.Accelerate position5(useSupport=true)
      annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia17(J=1) annotation (
       Placement(transformation(extent={{130,-50},{150,-30}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed6 annotation (Placement(
          transformation(extent={{100,-66},{120,-46}})));
    Modelica.Mechanics.Rotational.Sources.Move position6(useSupport=false)
      annotation (Placement(transformation(extent={{-140,-110},{-120,-90}})));
    Modelica.Blocks.Sources.Sine sine4[3](f={1,1,1}) annotation (Placement(
          transformation(extent={{-180,-110},{-160,-90}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia18(J=1) annotation (
       Placement(transformation(extent={{-110,-110},{-90,-90}})));
    Modelica.Mechanics.Rotational.Sources.Move position7(useSupport=true)
      annotation (Placement(transformation(extent={{-140,-140},{-120,-120}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia19(J=1) annotation (
       Placement(transformation(extent={{-110,-140},{-90,-120}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed8 annotation (Placement(
          transformation(extent={{-140,-158},{-120,-138}})));
    Modelica.Blocks.Sources.Sine sine5(f=1) annotation (Placement(
          transformation(extent={{-58,-110},{-38,-90}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=false)
      annotation (Placement(transformation(extent={{-20,-110},{0,-90}})));
    Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
      linearSpeedDependentTorque(
      tau_nominal=1,
      w_nominal=1,
      useSupport=false) annotation (Placement(transformation(extent={{-20,-144},
              {0,-124}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque(
      tau_nominal=1,
      w_nominal=1,
      useSupport=false) annotation (Placement(transformation(extent={{-20,-180},
              {0,-160}})));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(
        tau_constant=1, useSupport=false) annotation (Placement(transformation(
            extent={{40,-144},{20,-124}})));
    Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep(
      useSupport=false,
      stepTorque=1,
      offsetTorque=0) annotation (Placement(transformation(extent={{40,-180},{
              20,-160}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia20(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{20,
              -110},{40,-90}})));
    Modelica.Blocks.Sources.Sine sine6(f=1) annotation (Placement(
          transformation(extent={{60,-110},{80,-90}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=true)
      annotation (Placement(transformation(extent={{100,-110},{120,-90}})));
    Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
      linearSpeedDependentTorque1(
      tau_nominal=1,
      w_nominal=1,
      useSupport=true) annotation (Placement(transformation(extent={{100,-144},
              {120,-124}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque1(
      tau_nominal=1,
      w_nominal=1,
      useSupport=true) annotation (Placement(transformation(extent={{100,-180},
              {120,-160}})));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque1(
        tau_constant=1, useSupport=true) annotation (Placement(transformation(
            extent={{160,-144},{140,-124}})));
    Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep1(
      useSupport=true,
      stepTorque=1,
      offsetTorque=0) annotation (Placement(transformation(extent={{160,-180},{
              140,-160}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia21(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{140,
              -110},{160,-90}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed7 annotation (Placement(
          transformation(extent={{130,-200},{150,-180}})));
    Modelica.Mechanics.Rotational.Components.IdealGearR2T idealGearR2T(
      useSupportR=false,
      useSupportT=false,
      ratio=1) annotation (Placement(transformation(extent={{130,160},{150,180}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia22(J=1) annotation (
       Placement(transformation(extent={{100,160},{120,180}})));
    Modelica.Mechanics.Translational.Components.Mass slidingMass(
      m=1,
      s(fixed=true),
      v(fixed=true)) annotation (Placement(transformation(extent={{160,160},{
              180,180}})));
    Modelica.Mechanics.Rotational.Components.IdealGearR2T idealGearR2T1(
      useSupportR=true,
      useSupportT=true,
      ratio=1) annotation (Placement(transformation(extent={{130,110},{150,130}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia23(J=1) annotation (
       Placement(transformation(extent={{100,110},{120,130}})));
    Modelica.Mechanics.Translational.Components.Mass slidingMass1(
      m=1,
      s(fixed=true),
      v(fixed=true)) annotation (Placement(transformation(extent={{160,110},{
              180,130}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed9 annotation (Placement(
          transformation(extent={{120,92},{140,112}})));
    Modelica.Mechanics.Translational.Components.Fixed fixed10 annotation (
        Placement(transformation(extent={{142,92},{162,112}})));
  equation
    connect(inertia.flange_b, idealGear.flange_a) annotation (Line(
        points={{-160,170},{-150,170}}));
    connect(idealGear.flange_b, idealGear1.flange_a) annotation (Line(
        points={{-130,170},{-118,170}}));
    connect(idealGear1.flange_b, bearingFriction.flange_a) annotation (Line(
        points={{-98,170},{-90,170}}));
    connect(inertia1.flange_b, bearingFriction1.flange_a) annotation (Line(
        points={{-160,120},{-150,120}}));
    connect(idealGear1.support, fixed.flange) annotation (Line(
        points={{-108,160},{-108,154}}));
    connect(fixed.flange, bearingFriction.support) annotation (Line(
        points={{-108,154},{-80,154},{-80,160}}));
    connect(sine.y, brake.f_normalized) annotation (Line(
        points={{-159,80},{-140,80},{-140,61}}, color={0,0,127}));
    connect(inertia2.flange_b, brake.flange_a) annotation (Line(
        points={{-160,50},{-150,50}}));
    connect(inertia3.flange_b, brake1.flange_a) annotation (Line(
        points={{-80,50},{-70,50}}));
    connect(sine.y, brake1.f_normalized) annotation (Line(
        points={{-159,80},{-60,80},{-60,61}}, color={0,0,127}));
    connect(brake.support, fixed1.flange) annotation (Line(
        points={{-140,40},{-140,30}}));
    connect(inertia4.flange_b, lossyGear.flange_a) annotation (Line(
        points={{-80,120},{-70,120}}));
    connect(lossyGear.flange_b, inertia5.flange_a) annotation (Line(
        points={{-50,120},{-40,120}}));
    connect(inertia6.flange_b, lossyGear1.flange_a) annotation (Line(
        points={{20,120},{30,120}}));
    connect(lossyGear1.flange_b, inertia7.flange_a) annotation (Line(
        points={{50,120},{60,120}}));
    connect(fixed2.flange, lossyGear1.support) annotation (Line(
        points={{40,100},{40,110}}));
    connect(inertia8.flange_b, gear2_1.flange_a) annotation (Line(
        points={{20,50},{30,50}}));
    connect(gear2_1.flange_b, inertia9.flange_a) annotation (Line(
        points={{50,50},{60,50}}));
    connect(sine1.y, position.phi_ref) annotation (Line(
        points={{-159,-10},{-142,-10}}, color={0,0,127}));
    connect(position.flange, inertia12.flange_a) annotation (Line(
        points={{-120,-10},{-110,-10}}));
    connect(position1.flange, inertia13.flange_a) annotation (Line(
        points={{-120,-40},{-110,-40}}));
    connect(sine1.y, position1.phi_ref) annotation (Line(
        points={{-159,-10},{-150,-10},{-150,-40},{-142,-40}}, color={0,0,127}));
    connect(position1.support, fixed4.flange) annotation (Line(
        points={{-130,-50},{-130,-56}}));
    connect(inertia10.flange_b, gear2_2.flange_a) annotation (Line(
        points={{22,170},{30,170}}));
    connect(gear2_2.flange_b, inertia11.flange_a) annotation (Line(
        points={{50,170},{60,170}}));
    connect(fixed3.flange, gear2_2.support) annotation (Line(
        points={{40,154},{40,160}}));
    connect(position2.flange, inertia14.flange_a) annotation (Line(
        points={{0,-10},{10,-10}}));
    connect(position3.flange, inertia15.flange_a) annotation (Line(
        points={{0,-40},{10,-40}}));
    connect(position3.support, fixed5.flange) annotation (Line(
        points={{-10,-50},{-10,-56}}));
    connect(sine2.y, position2.w_ref) annotation (Line(
        points={{-39,-10},{-22,-10}}, color={0,0,127}));
    connect(sine2.y, position3.w_ref) annotation (Line(
        points={{-39,-10},{-30,-10},{-30,-40},{-22,-40}}, color={0,0,127}));
    connect(position4.flange, inertia16.flange_a) annotation (Line(
        points={{120,-10},{130,-10}}));
    connect(position5.flange, inertia17.flange_a) annotation (Line(
        points={{120,-40},{130,-40}}));
    connect(position5.support, fixed6.flange) annotation (Line(
        points={{110,-50},{110,-56}}));
    connect(sine3.y, position4.a_ref) annotation (Line(
        points={{81,-10},{98,-10}}, color={0,0,127}));
    connect(sine3.y, position5.a_ref) annotation (Line(
        points={{81,-10},{90,-10},{90,-40},{98,-40}}, color={0,0,127}));
    connect(position6.flange, inertia18.flange_a) annotation (Line(
        points={{-120,-100},{-110,-100}}));
    connect(position7.flange, inertia19.flange_a) annotation (Line(
        points={{-120,-130},{-110,-130}}));
    connect(position7.support, fixed8.flange) annotation (Line(
        points={{-130,-140},{-130,-148}}));
    connect(sine4.y, position6.u) annotation (Line(
        points={{-159,-100},{-142,-100}}, color={0,0,127}));
    connect(sine4.y, position7.u) annotation (Line(
        points={{-159,-100},{-152,-100},{-152,-130},{-142,-130}}, color={0,0,127}));
    connect(sine5.y, torque.tau) annotation (Line(
        points={{-37,-100},{-22,-100}}, color={0,0,127}));
    connect(torque.flange, inertia20.flange_a) annotation (Line(
        points={{0,-100},{20,-100}}));
    connect(linearSpeedDependentTorque.flange, inertia20.flange_a) annotation (
        Line(
        points={{0,-134},{10,-134},{10,-100},{20,-100}}));
    connect(quadraticSpeedDependentTorque.flange, inertia20.flange_a)
      annotation (Line(
        points={{0,-170},{10,-170},{10,-100},{20,-100}}));
    connect(constantTorque.flange, inertia20.flange_a) annotation (Line(
        points={{20,-134},{10,-134},{10,-100},{20,-100}}));
    connect(torqueStep.flange, inertia20.flange_a) annotation (Line(
        points={{20,-170},{10,-170},{10,-100},{20,-100}}));
    connect(sine6.y, torque1.tau) annotation (Line(
        points={{81,-100},{98,-100}}, color={0,0,127}));
    connect(torque1.flange, inertia21.flange_a) annotation (Line(
        points={{120,-100},{140,-100}}));
    connect(linearSpeedDependentTorque1.flange, inertia21.flange_a) annotation (
       Line(
        points={{120,-134},{130,-134},{130,-100},{140,-100}}));
    connect(quadraticSpeedDependentTorque1.flange, inertia21.flange_a)
      annotation (Line(
        points={{120,-170},{130,-170},{130,-100},{140,-100}}));
    connect(constantTorque1.flange, inertia21.flange_a) annotation (Line(
        points={{140,-134},{130,-134},{130,-100},{140,-100}}));
    connect(torqueStep1.flange, inertia21.flange_a) annotation (Line(
        points={{140,-170},{130,-170},{130,-100},{140,-100}}));
    connect(torqueStep1.support, fixed7.flange) annotation (Line(
        points={{150,-180},{140,-180},{140,-190}}));
    connect(constantTorque1.support, fixed7.flange) annotation (Line(
        points={{150,-144},{170,-144},{170,-180},{140,-180},{140,-190}}));
    connect(quadraticSpeedDependentTorque1.support, fixed7.flange) annotation (
        Line(
        points={{110,-180},{140,-180},{140,-190}}));
    connect(linearSpeedDependentTorque1.support, fixed7.flange) annotation (
        Line(
        points={{110,-144},{90,-144},{90,-180},{140,-180},{140,-190}}));
    connect(torque1.support, fixed7.flange) annotation (Line(
        points={{110,-110},{110,-110},{90,-110},{90,-180},{140,-180},{140,-190}}));

    connect(inertia22.flange_b, idealGearR2T.flangeR) annotation (Line(
        points={{120,170},{130,170}}));
    connect(idealGearR2T.flangeT, slidingMass.flange_a) annotation (Line(
        points={{150,170},{160,170}}, color={0,127,0}));
    connect(inertia23.flange_b, idealGearR2T1.flangeR) annotation (Line(
        points={{120,120},{130,120}}));
    connect(idealGearR2T1.flangeT, slidingMass1.flange_a) annotation (Line(
        points={{150,120},{160,120}}, color={0,127,0}));
    connect(idealGearR2T1.supportR, fixed9.flange) annotation (Line(
        points={{130,110},{130,102}}));
    connect(fixed10.flange, idealGearR2T1.supportT) annotation (Line(
        points={{152,102},{152,110},{150,110}}, color={0,127,0}));
    annotation (experiment(StopTime=0.5), Diagram(coordinateSystem(
            preserveAspectRatio=true, extent={{-200,-200},{200,200}})));
  end TestBearingConversion;

  model TestFriction "Test friction elements"
    extends Modelica.Icons.Example;

    Modelica.Mechanics.Rotational.Components.Inertia inertia(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10,
              80},{10,100}})));
    Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
        useSupport=false) annotation (Placement(transformation(extent={{20,80},
              {40,100}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=false)
      annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
    Modelica.Blocks.Sources.Sine sine(amplitude=10, f=1) annotation (
        Placement(transformation(extent={{-80,80},{-60,100}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10,
              20},{10,40}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=false)
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Modelica.Blocks.Sources.Sine sine1(amplitude=10, f=1) annotation (
        Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Mechanics.Rotational.Components.Brake brake(useSupport=false,
        fn_max=1) annotation (Placement(transformation(extent={{20,20},{40,40}})));
    Modelica.Blocks.Sources.Step step(height=100, startTime=0.5) annotation (
        Placement(transformation(extent={{-10,50},{10,70}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2(
      J=1,
      phi(start=0, fixed=true),
      w(start=0, fixed=true)) annotation (Placement(transformation(extent={{-10,
              -40},{10,-20}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=false)
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
    Modelica.Blocks.Sources.Sine sine2(amplitude=10, f=1) annotation (
        Placement(transformation(extent={{-80,-40},{-60,-20}})));
    Modelica.Mechanics.Rotational.Components.Clutch clutch(
      fn_max=1,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{20,-40},
              {40,-20}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia3(J=1) annotation (
        Placement(transformation(extent={{50,-40},{70,-20}})));
    Modelica.Blocks.Sources.Step step1(height=100, startTime=0.5) annotation (
        Placement(transformation(extent={{-12,-10},{8,10}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia4(
      J=1,
      phi(start=0, fixed=true),
      w(start=0, fixed=true)) annotation (Placement(transformation(extent={{-8,
              -100},{12,-80}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque3(useSupport=false)
      annotation (Placement(transformation(extent={{-38,-100},{-18,-80}})));
    Modelica.Blocks.Sources.Sine sine3(amplitude=10, f=1) annotation (
        Placement(transformation(extent={{-78,-100},{-58,-80}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia5(J=1) annotation (
        Placement(transformation(extent={{50,-100},{70,-80}})));
    Modelica.Blocks.Sources.Step step2(height=100, startTime=0.5) annotation (
        Placement(transformation(extent={{-10,-70},{10,-50}})));
    Modelica.Mechanics.Rotational.Components.OneWayClutch oneWayClutch(
      fn_max=1,
      phi_rel(fixed=true),
      w_rel(fixed=true),
      startForward(fixed=true),
      stuck(fixed=true)) annotation (Placement(transformation(extent={{40,-100},
              {20,-80}})));
  equation
    connect(inertia.flange_b, bearingFriction.flange_a) annotation (Line(
        points={{10,90},{20,90}}));
    connect(torque.flange, inertia.flange_a) annotation (Line(
        points={{-20,90},{-10,90}}));
    connect(sine.y, torque.tau) annotation (Line(
        points={{-59,90},{-42,90}}, color={0,0,127}));
    connect(torque1.flange, inertia1.flange_a) annotation (Line(
        points={{-20,30},{-10,30}}));
    connect(sine1.y, torque1.tau) annotation (Line(
        points={{-59,30},{-42,30}}, color={0,0,127}));
    connect(inertia1.flange_b, brake.flange_a) annotation (Line(
        points={{10,30},{20,30}}));
    connect(step.y, brake.f_normalized) annotation (Line(
        points={{11,60},{30,60},{30,41}}, color={0,0,127}));
    connect(torque2.flange, inertia2.flange_a) annotation (Line(
        points={{-20,-30},{-10,-30}}));
    connect(sine2.y, torque2.tau) annotation (Line(
        points={{-59,-30},{-42,-30}}, color={0,0,127}));
    connect(inertia2.flange_b, clutch.flange_a) annotation (Line(
        points={{10,-30},{20,-30}}));
    connect(clutch.flange_b, inertia3.flange_a) annotation (Line(
        points={{40,-30},{50,-30}}));
    connect(step1.y, clutch.f_normalized) annotation (Line(
        points={{9,0},{30,0},{30,-19}}, color={0,0,127}));
    connect(torque3.flange, inertia4.flange_a) annotation (Line(
        points={{-18,-90},{-8,-90}}));
    connect(sine3.y, torque3.tau) annotation (Line(
        points={{-57,-90},{-40,-90}}, color={0,0,127}));
    connect(step2.y, oneWayClutch.f_normalized) annotation (Line(
        points={{11,-60},{30,-60},{30,-79}}, color={0,0,127}));
    connect(oneWayClutch.flange_b, inertia4.flange_b) annotation (Line(
        points={{20,-90},{12,-90}}));
    connect(oneWayClutch.flange_a, inertia5.flange_a) annotation (Line(
        points={{40,-90},{50,-90}}));
    annotation (experiment(StopTime=1.1));
  end TestFriction;

  model TestFrictionPosition
    extends Modelica.Icons.Example;

    Modelica.Mechanics.Rotational.Sources.Position    position(exact=true)
      annotation (Placement(transformation(extent={{-10,30},{10,50}})));

    Modelica.Blocks.Sources.Sine sine(
      amplitude=0.1,
      f=1,
      phase=0.78539816339745,
      offset=0.5) annotation (Placement(transformation(extent={{-70,30},{-50,50}})));

    Modelica.Mechanics.Rotational.Components.BearingFriction    bearingFriction(tau_pos=[0,5; 100,5],
               peak=1.001)
      annotation (Placement(transformation(extent={{46,30},{66,50}})));
    Modelica.Mechanics.Rotational.Sources.Torque      torque
      annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
    Modelica.Blocks.Sources.Sine sine1(
      amplitude=25,
      f=1,
      phase=0.78539816339745,
      offset=0.5) annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
    Modelica.Mechanics.Rotational.Components.BearingFriction    bearingFriction1(tau_pos=[0,5; 100,5], peak=1.001)
      annotation (Placement(transformation(extent={{46,-50},{66,-30}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J=1, w(start=-2, fixed=true))
      annotation (Placement(transformation(extent={{74,-50},{94,-30}})));
    Modelica.Mechanics.Rotational.Sources.Position    position1(exact=true)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Sine sine2(
      amplitude=0.3,
      f=1,
      phase=2.3561944901923,
      offset=0.5) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
    Modelica.Mechanics.Rotational.Components.BearingFriction    bearingFriction2(tau_pos=[0,5; 100,5], peak=1.001)
      annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  equation

    connect(sine.y, position.phi_ref) annotation (Line(points={{-49,40},{-12,40}}, color={0,0,127}));
    connect(position.flange, bearingFriction.flange_a) annotation (Line(points={{10,40},{48,40},{48,40},{46,40}}, color={0,0,0}));
    connect(sine1.y, torque.tau) annotation (Line(points={{-49,-40},{-12,-40}}, color={0,0,127}));
    connect(torque.flange, bearingFriction1.flange_a) annotation (Line(points={{10,-40},{46,-40}}, color={0,0,0}));
    connect(bearingFriction1.flange_b, inertia.flange_a) annotation (Line(points={{66,-40},{74,-40}}, color={0,0,0}));
    connect(sine2.y, position1.phi_ref) annotation (Line(points={{-49,0},{-12,0}}, color={0,0,127}));
    connect(position1.flange, bearingFriction2.flange_a) annotation (Line(points={{10,0},{46,0}}, color={0,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end TestFrictionPosition;

  model TestFrictionPositionInertial
    extends Modelica.Icons.Example;

    Modelica.Mechanics.Rotational.Sources.Position position(exact=true)
      annotation (Placement(transformation(extent={{-10,30},{10,50}})));

    Modelica.Blocks.Sources.Cosine cosine(
      amplitude=0.1,
      f=1,
      phase=0,
      continuous=true,
      offset=0.5,
      startTime=0.1) annotation (Placement(transformation(extent={{-70,30},{-50,50}})));

    Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
      tau_pos=[0,5; 100,5],
      peak=1.001,
      J_inv_fixed=1e-15) annotation (Placement(transformation(extent={{46,30},{66,50}})));
    Modelica.Mechanics.Rotational.Sources.Position position1(exact=true)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Cosine cosine1(
      amplitude=0.3,
      f=1,
      phase=3.1415926535898,
      continuous=true,
      offset=0.5,
      startTime=0.1) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
    Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction2(
      tau_pos=[0,5; 100,5],
      peak=1.001,
      J_inv_fixed=1e-15) annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  equation

    connect(cosine.y, position.phi_ref) annotation (Line(points={{-49,40},{-12,40}}, color={0,0,127}));
    connect(position.flange, bearingFriction.flange_a) annotation (Line(points={{10,40},{48,40},{48,40},{46,40}}, color={0,0,0}));
    connect(cosine1.y, position1.phi_ref) annotation (Line(points={{-49,0},{-12,0}}, color={0,0,127}));
    connect(position1.flange, bearingFriction2.flange_a) annotation (Line(points={{10,0},{46,0}}, color={0,0,0}));
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  end TestFrictionPositionInertial;

  model TestBraking
    extends Modelica.Icons.Example;
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=100))
      annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
    Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
      linearSpeedDependentTorque(w_nominal=100, tau_nominal=-100)
      annotation (Placement(transformation(extent={{40,70},{20,90}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=100))
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque(tau_nominal=-100, w_nominal=100)
      annotation (Placement(transformation(extent={{40,40},{20,60}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia3(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=100))
      annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(
        tau_constant=-100)
      annotation (Placement(transformation(extent={{40,10},{20,30}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia4(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=100))
      annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
    Modelica.Mechanics.Rotational.Sources.SignTorque signTorque(tau_nominal=-100,
        w0=1) annotation (Placement(transformation(extent={{40,-20},{20,0}})));
    Modelica.Mechanics.Rotational.Sources.EddyCurrentTorque eddyCurrentTorque(
      tau_nominal=100,
      w_nominal=10,
      useSupport=false,
      alpha20(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper,
      TRef=293.15,
      useHeatPort=true)
      annotation (Placement(transformation(extent={{40,-50},{20,-30}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia5(
      phi(fixed=true, start=0),
      J=1,
      w(fixed=true, start=20))
      annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=1, T(
          fixed=true)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={60,-60})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia6(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=100))
      annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
    Modelica.Mechanics.Rotational.Sources.InverseSpeedDependentTorque inverseSpeedDependentTorque(
      tau_nominal=-100,
      w_nominal=100,
      w0=1) annotation (Placement(transformation(extent={{40,-90},{20,-70}})));
  equation
    connect(inertia1.flange_b, linearSpeedDependentTorque.flange)
      annotation (Line(points={{-20,80},{20,80}}));
    connect(inertia2.flange_b, quadraticSpeedDependentTorque.flange)
      annotation (Line(points={{-20,50},{20,50}}));
    connect(inertia3.flange_b, constantTorque.flange)
      annotation (Line(points={{-20,20},{20,20}}));
    connect(signTorque.flange, inertia4.flange_b)
      annotation (Line(points={{20,-10},{-20,-10}}));
    connect(eddyCurrentTorque.heatPort, heatCapacitor.port) annotation (Line(
          points={{40,-50},{60,-50}}, color={191,0,0}));
    connect(inertia5.flange_b, eddyCurrentTorque.flange) annotation (Line(points={{-20,-40},{20,-40}}, color={0,0,0}));
    connect(inverseSpeedDependentTorque.flange, inertia6.flange_b)
      annotation (Line(points={{20,-80},{-20,-80}}));
    annotation (
      experiment(StopTime=2),
      Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
  end TestBraking;

  model GenerationOfFMUs
    "Example to demonstrate variants to generate FMUs (Functional Mock-up Units)"
    extends Modelica.Icons.Example;

    Modelica.Blocks.Sources.Sine sine1(f=2, amplitude=10)
      annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
    Modelica.Mechanics.Rotational.Examples.Utilities.DirectInertia
      directInertia(J=1.1)
      annotation (Placement(transformation(extent={{0,40},{20,60}})));
    Modelica.Mechanics.Rotational.Examples.Utilities.InverseInertia
      inverseInertia(J=2.2)
      annotation (Placement(transformation(extent={{40,40},{60,60}})));
    Modelica.Mechanics.Rotational.Examples.Utilities.SpringDamper
      springDamper(c=1e4, d=100)
      annotation (Placement(transformation(extent={{20,-20},{40,0}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2a(
      J=1.1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0))
      annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque2
      annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
    Modelica.Mechanics.Rotational.Components.GeneralTorqueToAngleAdaptor torqueToAngle2a(use_pder2=
         false)
      annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2b(
      J=2.2,
      phi(fixed=true, start=0),
      w(fixed=true, start=0))
      annotation (Placement(transformation(extent={{70,-20},{90,0}})));
    Modelica.Mechanics.Rotational.Components.GeneralTorqueToAngleAdaptor torqueToAngle2b(use_pder2=
         false) annotation (Placement(transformation(extent={{70,-20},{50,0}})));
    Modelica.Mechanics.Rotational.Examples.Utilities.Spring spring(c=1e4)
      annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia3a(
      J=1.1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent=
             {{-30,-80},{-10,-60}})));
    Modelica.Mechanics.Rotational.Sources.Torque   force3
      annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
    Modelica.Mechanics.Rotational.Components.GeneralTorqueToAngleAdaptor torqueToAngle3a(use_pder=
          false, use_pder2=false)
      annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia3b(
      J=2.2,
      phi(fixed=true, start=0),
      w(fixed=true, start=0))
      annotation (Placement(transformation(extent={{70,-80},{90,-60}})));
    Modelica.Mechanics.Rotational.Components.GeneralTorqueToAngleAdaptor torqueToAngle3b(use_pder=
          false, use_pder2=false)
      annotation (Placement(transformation(extent={{70,-80},{50,-60}})));
  equation
    connect(sine1.y, directInertia.tauDrive)
      annotation (Line(points={{-79,50},{-2,50}}, color={0,0,127}));
    connect(directInertia.phi, inverseInertia.phi)
      annotation (Line(points={{21,58},{38,58}}, color={0,0,127}));
    connect(directInertia.w, inverseInertia.w)
      annotation (Line(points={{21,53},{38,53}}, color={0,0,127}));
    connect(directInertia.a, inverseInertia.a)
      annotation (Line(points={{21,47},{38,47}}, color={0,0,127}));
    connect(inverseInertia.tau, directInertia.tau)
      annotation (Line(points={{39,42},{22,42}}, color={0,0,127}));
    connect(sine1.y, torque2.tau) annotation (Line(points={{-79,50},{-70,
            50},{-70,-10},{-62,-10}}, color={0,0,127}));
    connect(sine1.y, force3.tau) annotation (Line(points={{-79,50},{-70,
            50},{-70,-70},{-62,-70}}, color={0,0,127}));
    connect(torqueToAngle2b.flange, inertia2b.flange_a)
      annotation (Line(points={{62,-10},{70,-10}}));
    connect(inertia2a.flange_b, torqueToAngle2a.flange)
      annotation (Line(points={{-10,-10},{-2,-10}}));
    connect(torque2.flange, inertia2a.flange_a)
      annotation (Line(points={{-40,-10},{-30,-10}}));
    connect(inertia3a.flange_b, torqueToAngle3a.flange)
      annotation (Line(points={{-10,-70},{-2,-70}}));
    connect(force3.flange, inertia3a.flange_a)
      annotation (Line(points={{-40,-70},{-30,-70}}));
    connect(torqueToAngle3b.flange, inertia3b.flange_a)
      annotation (Line(points={{62,-70},{70,-70}}));
    connect(torqueToAngle2a.p, springDamper.phi1)
      annotation (Line(points={{3,-2},{18,-2}}, color={0,0,127}));
    connect(torqueToAngle2a.pder, springDamper.w1) annotation (Line(points={{3,
            -5},{9.5,-5},{9.5,-7},{18,-7}}, color={0,0,127}));
    connect(torqueToAngle2a.f, springDamper.tau1)
      annotation (Line(points={{3,-18},{19,-18}}, color={0,0,127}));
    connect(springDamper.phi2, torqueToAngle2b.p)
      annotation (Line(points={{42,-2},{57,-2}}, color={0,0,127}));
    connect(springDamper.w2, torqueToAngle2b.pder) annotation (Line(points={{42,
            -7},{49,-7},{49,-5},{57,-5}}, color={0,0,127}));
    connect(springDamper.tau2, torqueToAngle2b.f)
      annotation (Line(points={{41,-18},{57,-18}}, color={0,0,127}));
    connect(torqueToAngle3a.p, spring.phi1)
      annotation (Line(points={{3,-62},{18,-62}}, color={0,0,127}));
    connect(torqueToAngle3a.f, spring.tau1)
      annotation (Line(points={{3,-78},{19,-78}}, color={0,0,127}));
    connect(spring.phi2, torqueToAngle3b.p)
      annotation (Line(points={{42,-62},{57,-62}}, color={0,0,127}));
    connect(spring.tau2, torqueToAngle3b.f)
      annotation (Line(points={{41,-78},{57,-78}}, color={0,0,127}));
    annotation (experiment(StopTime=1, Interval=0.001), Documentation(info="<html>
<p>
This example demonstrates how to generate an input/output block (e.g. in form of an
FMU - <a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>) from various Rotational components.
The goal is to export such an input/output block from Modelica and import
it in another modeling environment. The essential issue is that before
exporting it must be known in which way the component is utilized in the
target environment. Depending on the target usage, different flange variables
need to be in the interface with either input or output causality.
Note, this example model can be used to test the FMU export/import of a Modelica tool.
Just export the components marked in the icons as \"toFMU\" as FMUs and import
them back. The models should then still work and give the same results as a
pure Modelica model.
</p>

<p>
<strong>Connecting two inertias</strong><br>
The upper part (DirectInertia, InverseInertia)
demonstrates how to export two inertias and connect them
together in a target system. This requires that one of the inertias
(here: DirectInertia)
is defined to have states and the angle, angular velocity and
angular acceleration are provided in the interface.
The other mass (here: InverseInertia) is moved according
to the provided input angle, angular velocity and angular acceleration.
</p>

<p>
<strong>Connecting a force element that needs angles and angular velocities</strong><br>
The middle part (SpringDamper) demonstrates how to export a force element
that needs both angles and angular velocities for its force law and connect this
force law in a target system between two inertias.
</p>

<p>
<strong>Connecting a force element that needs only angles</strong><br>
The lower part (Spring) demonstrates how to export a force element
that needs only angles for its force law and connect this
force law in a target system between two inertias.
</p>
</html>"));
  end GenerationOfFMUs;

  package Utilities "Utility classes used by rotational example models"
    extends Modelica.Icons.UtilitiesPackage;

    model DirectInertia "Input/output block of a direct inertia model"
      extends Modelica.Blocks.Icons.Block;
      parameter SI.Inertia J(min=0)=1 "Inertia";
      Modelica.Mechanics.Rotational.Components.Inertia inertia(
        J=J,
        phi(start=0, fixed=true),
        w(start=0, fixed=true))
        annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
      Modelica.Mechanics.Rotational.Sources.Torque torqueSource
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      Modelica.Blocks.Interfaces.RealInput tauDrive(unit="N.m")
        "Accelerating torque acting at flange (= -flange.tau)"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Mechanics.Rotational.Components.GeneralTorqueToAngleAdaptor
        torqueToAngle
        annotation (Placement(transformation(extent={{10,-10},{30,10}})));
      Modelica.Blocks.Interfaces.RealOutput phi(unit="rad")
        "Inertia moves with angle phi due to torque tau"
        annotation (Placement(transformation(extent={{100,70},{120,90}})));
      Modelica.Blocks.Interfaces.RealOutput w(unit="rad/s")
        "Inertia moves with speed w due to torque tau"
        annotation (Placement(transformation(extent={{100,20},{120,40}})));
      Modelica.Blocks.Interfaces.RealOutput a(unit="rad/s2")
        "Inertia moves with acceleration a due to torque tau"
        annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
      Modelica.Blocks.Interfaces.RealInput tau(unit="N.m")
        "Torque to drive the inertia" annotation (Placement(
            transformation(extent={{140,-100},{100,-60}})));
    equation
      connect(tauDrive, torqueSource.tau)
        annotation (Line(points={{-120,0},{-52,0}}, color={0,0,127}));
      connect(torqueSource.flange, inertia.flange_a)
        annotation (Line(points={{-30,0},{-20,0}}));
      connect(inertia.flange_b, torqueToAngle.flange)
        annotation (Line(points={{0,0},{18,0}}));
      connect(torqueToAngle.p, phi) annotation (Line(points={{23,8},{40,8},
              {40,80},{110,80}}, color={0,0,127}));
      connect(torqueToAngle.pder, w) annotation (Line(points={{23,5},{60,
              5},{60,30},{110,30}}, color={0,0,127}));
      connect(torqueToAngle.pder2, a) annotation (Line(points={{23,2},{60,
              2},{60,-30},{110,-30}}, color={0,0,127}));
      connect(tau, torqueToAngle.f) annotation (Line(points={{120,-80},{
              40,-80},{40,-8},{23,-8}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
                    extent={{-84,-58},{24,-90}},
                    textColor={135,135,135},
                    textString="to FMU"),Text(
                    extent={{8,96},{92,66}},
                    horizontalAlignment=TextAlignment.Right,
              textString="phi"),                            Text(
                    extent={{10,46},{94,16}},
                    horizontalAlignment=TextAlignment.Right,
              textString="w"),   Text(
                    extent={{10,-10},{94,-40}},
                    horizontalAlignment=TextAlignment.Right,
                    textString="a"),Text(
                    extent={{-150,-110},{150,-140}},
                    textString="J=%J"),Bitmap(extent={{-96,-42},{64,54}},
                fileName="modelica://Modelica/Resources/Images/Mechanics/Rotational/DirectInertia.png"),
              Text( extent={{10,-60},{94,-90}},
                    horizontalAlignment=TextAlignment.Right,
              textString="tau")}), Documentation(info="<html>
<p>
A rotational component with pure signal interface which can be applied for
a FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>)
exchange.
The input torque <code>tauDrive</code> is applied on one side of a rotational
component with inertia whereby the input torque <code>tau</code> is applied
on the other side of it.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.Utilities.InverseInertia\">InverseInertia</a>.
</p>
</html>"));
    end DirectInertia;

    model InverseInertia "Input/output block of an inverse inertia model"
      extends Modelica.Blocks.Icons.Block;
      parameter SI.Inertia J=1 "Inertia";
      Modelica.Mechanics.Rotational.Components.Inertia inertia(
        J=J,
        phi(start=0),
        w(start=0))             annotation (Placement(transformation(
              extent={{-10,-10},{10,10}})));
      Modelica.Mechanics.Rotational.Components.GeneralAngleToTorqueAdaptor
        angleToTorque
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
      Modelica.Blocks.Interfaces.RealInput phi(unit="rad")
        "Angle to drive the inertia"
        annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
      Modelica.Blocks.Interfaces.RealInput w(unit="rad/s")
        "Speed to drive the inertia"
        annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
      Modelica.Blocks.Interfaces.RealInput a(unit="rad/s2")
        "Acceleration to drive the inertia"         annotation (Placement(
            transformation(extent={{-140,-50},{-100,-10}})));
      Modelica.Blocks.Interfaces.RealOutput tau(unit="N.m")
        "Torque needed to drive the flange according to phi, w, a"
        annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
    equation

      connect(angleToTorque.flange, inertia.flange_a)
        annotation (Line(points={{-18,0},{-10,0}}));
      connect(phi, angleToTorque.p) annotation (Line(points={{-120,80},{
              -40,80},{-40,8},{-23,8}}, color={0,0,127}));
      connect(w, angleToTorque.pder) annotation (Line(points={{-120,30},{
              -60,30},{-60,5},{-23,5}}, color={0,0,127}));
      connect(a, angleToTorque.pder2) annotation (Line(points={{-120,-30},
              {-60,-30},{-60,2},{-23,2}}, color={0,0,127}));
      connect(tau, angleToTorque.f) annotation (Line(points={{-110,-80},{
              -40,-80},{-40,-8},{-23,-8}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
                    extent={{0,-62},{96,-94}},
                    textColor={135,135,135},
                    textString="to FMU"),Text(
                    extent={{-94,96},{-10,66}},
                    horizontalAlignment=TextAlignment.Left,
              textString="phi"),      Text(
                    extent={{-94,46},{-10,16}},
                    horizontalAlignment=TextAlignment.Left,
              textString="w"),      Text(
                    extent={{-92,-14},{-8,-44}},
                    horizontalAlignment=TextAlignment.Left,
                    textString="a"),Text(
                    extent={{-150,-110},{150,-140}},
                    textString="J=%J"),Bitmap(extent={{-58,-42},{98,48}},
                fileName="modelica://Modelica/Resources/Images/Mechanics/Rotational/InverseInertia.png"),
              Text( extent={{-90,-64},{-6,-94}},
                    horizontalAlignment=TextAlignment.Left,
              textString="tau")}), Documentation(info="<html>
<p>
A rotational component with pure signal interface which can be applied for
a FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>)
exchange.
Based on the kinematic inputs applied on a component with inertia
the output torque <code>tau</code> is returned.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.Utilities.DirectInertia\">DirectInertia</a>.
</p>
</html>"));
    end InverseInertia;

    model SpringDamper "Input/output block of a spring/damper model"
      extends Modelica.Blocks.Icons.Block;
      parameter SI.RotationalSpringConstant c=1e4
        "Spring constant";
      parameter SI.RotationalDampingConstant d=1
        "Damping constant";
      parameter SI.Angle phi_rel0=0
        "Unstretched spring angle";

      Modelica.Mechanics.Rotational.Components.GeneralAngleToTorqueAdaptor
        angleToTorque1(use_pder2=false)
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
      Modelica.Blocks.Interfaces.RealInput phi1(unit="rad")
        "Angle of left flange of force element"
        annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
      Modelica.Blocks.Interfaces.RealInput w1(unit="rad/s")
        "Speed to left flange of force element"
        annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
      Modelica.Blocks.Interfaces.RealOutput tau1(unit="N.m")
        "Torque generated by the force element"
        annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
      Modelica.Blocks.Interfaces.RealInput phi2(unit="rad")
        "Angle of right flange of force element"
        annotation (Placement(transformation(extent={{140,60},{100,100}})));
      Modelica.Blocks.Interfaces.RealInput w2(unit="rad/s")
        "Speed to right flange of force element"
        annotation (Placement(transformation(extent={{140,10},{100,50}})));
      Modelica.Blocks.Interfaces.RealOutput tau2(unit="N.m")
        "Torque generated by the force element"
        annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
      Modelica.Mechanics.Rotational.Components.GeneralAngleToTorqueAdaptor
        angleToTorque2(use_pder2=false)
        annotation (Placement(transformation(extent={{30,-10},{10,10}})));
      Modelica.Mechanics.Rotational.Examples.Utilities.SpringDamperNoRelativeStates
                                   springDamper(
        c=c,
        d=d,
        phi_rel0=phi_rel0)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation

      connect(springDamper.flange_b, angleToTorque2.flange)
        annotation (Line(points={{10,0},{18,0}}));
      connect(angleToTorque1.flange, springDamper.flange_a)
        annotation (Line(points={{-18,0},{-10,0}}));
      connect(angleToTorque2.p, phi2) annotation (Line(points={{23,8},{40,
              8},{40,80},{120,80}}, color={0,0,127}));
      connect(angleToTorque2.pder, w2) annotation (Line(points={{23,5},{
              60,5},{60,30},{120,30}}, color={0,0,127}));
      connect(angleToTorque2.f, tau2) annotation (Line(points={{23,-8},{60,-8},{60,-80},{110,-80}},
                                          color={0,0,127}));
      connect(angleToTorque1.p, phi1) annotation (Line(points={{-23,8},{
              -40,8},{-40,80},{-120,80}}, color={0,0,127}));
      connect(angleToTorque1.pder, w1) annotation (Line(points={{-23,5},{
              -60,5},{-60,30},{-120,30}}, color={0,0,127}));
      connect(angleToTorque1.f, tau1) annotation (Line(points={{-23,-8},{
              -60,-8},{-60,-80},{-110,-80}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
              extent={{-48,-36},{48,-68}},
              textColor={128,128,128},
              textString="to FMU"),      Text(
                    extent={{-94,96},{-10,66}},
                    horizontalAlignment=TextAlignment.Left,
              textString="phi1"),      Text(
                    extent={{-150,-118},{150,-148}},
                    textString="c=%c
d=%d"),       Bitmap(extent={{-72,-44},{84,46}},
                 fileName="modelica://Modelica/Resources/Images/Mechanics/Rotational/SpringDamper.png"),
              Text( extent={{12,96},{96,66}},
                    horizontalAlignment=TextAlignment.Right,
              textString="phi2"),      Text(
                    extent={{12,48},{96,18}},
                    horizontalAlignment=TextAlignment.Right,
              textString="w2"),      Text(
                    extent={{10,-60},{94,-90}},
                    horizontalAlignment=TextAlignment.Right,
              textString="tau2"),      Text(
                    extent={{-94,46},{-10,16}},
                    horizontalAlignment=TextAlignment.Left,
              textString="w1"),      Text(
                    extent={{-90,-64},{-6,-94}},
                    horizontalAlignment=TextAlignment.Left,
              textString="tau1")}), Documentation(info="<html>
<p>
A linear 1D rotational spring and damper in parallel with pure signal
interface which can be applied for
a FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>)
exchange.
</p>
</html>"));
    end SpringDamper;

    model Spring "Input/output block of a spring model"
      extends Modelica.Blocks.Icons.Block;
      parameter SI.RotationalSpringConstant c=1e4
        "Spring constant";
      parameter SI.Angle phi_rel0=0
        "Unstretched spring angle";

      Modelica.Mechanics.Rotational.Components.GeneralAngleToTorqueAdaptor
        angleToTorque1(use_pder=false, use_pder2=false)
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
      Modelica.Blocks.Interfaces.RealInput phi1(unit="rad")
        "Angle of left flange of force element"
        annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
      Modelica.Blocks.Interfaces.RealOutput tau1(unit="N.m")
        "Torque generated by the force element"
        annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
      Modelica.Mechanics.Rotational.Components.Spring spring(c=c,
          phi_rel0=phi_rel0) annotation (Placement(transformation(extent={{-10,-10},
                {10,10}})));
      Modelica.Blocks.Interfaces.RealInput phi2(unit="rad")
        "Angle of right flange of force element"
        annotation (Placement(transformation(extent={{140,60},{100,100}})));
      Modelica.Blocks.Interfaces.RealOutput tau2(unit="N.m")
        "Torque generated by the force element"
        annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
      Modelica.Mechanics.Rotational.Components.GeneralAngleToTorqueAdaptor
        angleToTorque2(use_pder=false, use_pder2=false)
        annotation (Placement(transformation(extent={{30,-10},{10,10}})));
    equation

      connect(angleToTorque1.flange, spring.flange_a)
        annotation (Line(points={{-18,0},{-10,0}}));
      connect(spring.flange_b, angleToTorque2.flange)
        annotation (Line(points={{10,0},{18,0}}));
      connect(angleToTorque1.p, phi1) annotation (Line(points={{-23,8},{
              -40,8},{-40,80},{-120,80}}, color={0,0,127}));
      connect(angleToTorque1.f, tau1) annotation (Line(points={{-23,-8},{
              -40,-8},{-40,-80},{-110,-80}}, color={0,0,127}));
      connect(angleToTorque2.f, tau2) annotation (Line(points={{23,-8},{
              40,-8},{40,-80},{110,-80}}, color={0,0,127}));
      connect(angleToTorque2.p, phi2) annotation (Line(points={{23,8},{40,
              8},{40,80},{120,80}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
              extent={{-48,-36},{48,-68}},
              textColor={128,128,128},
              textString="to FMU"),      Text(
                    extent={{-94,96},{-10,66}},
                    horizontalAlignment=TextAlignment.Left,
              textString="phi1"),      Text(
                    extent={{-150,-114},{150,-144}},
                    textString="c=%c"),Bitmap(extent={{-88,-36},{92,56}},
                fileName="modelica://Modelica/Resources/Images/Mechanics/Rotational/Spring.png"),
              Text( extent={{12,96},{96,66}},
                    horizontalAlignment=TextAlignment.Right,
              textString="phi2"),      Text(
                    extent={{10,-60},{94,-90}},
                    horizontalAlignment=TextAlignment.Right,
              textString="tau2"),      Text(
                    extent={{-90,-64},{-6,-94}},
                    horizontalAlignment=TextAlignment.Left,
              textString="tau1")}), Documentation(info="<html>
<p>
A linear 1D rotational spring with pure signal
interface which can be applied for
a FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>)
exchange.
</p>
</html>"));
    end Spring;

    annotation (Documentation(info="<html>
<p>
This package contains utility models and functions used by some
of the example models from the rotational mechanics package.
</p>
</html>"));
  end Utilities;
end Rotational;
