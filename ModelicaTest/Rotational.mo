within ModelicaTest;
package Rotational "Test models for Modelica.Mechanics.Rotational"
  extends Modelica.Icons.ExamplesPackage;

  package ForUsersGuide "Models used as screenshot for the users guide"
    extends Modelica.Icons.ExamplesPackage;

    model SimpleDriveTrain
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Sine sine(freqHz=1) annotation (Placement(
            transformation(extent={{-80,0},{-60,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=true)
        annotation (Placement(transformation(extent={{-40,0},{-20,20}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (
          Placement(transformation(extent={{-40,-20},{-20,0}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J1(
        J=0.2,
        phi(start=0, fixed=true),
        w(start=0, fixed=true)) annotation (Placement(transformation(extent={{-10,
                0},{10,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio=5,
          useSupport=true) annotation (Placement(transformation(extent={{20,0},
                {40,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J2(J=5) annotation (
          Placement(transformation(extent={{50,0},{70,20}}, rotation=0)));
    equation
      connect(sine.y, torque.tau) annotation (Line(
          points={{-59,10},{-42,10}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(torque.support, fixed.flange) annotation (Line(
          points={{-30,0},{-30,-10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(torque.flange, J1.flange_a) annotation (Line(
          points={{-20,10},{-10,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(gear.flange_b, J2.flange_a) annotation (Line(
          points={{40,10},{50,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed.flange, gear.support) annotation (Line(
          points={{-30,-10},{30,-10},{30,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(J1.flange_b, gear.flange_a) annotation (Line(
          points={{10,10},{20,10}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (experiment(StopTime=1.1));
    end SimpleDriveTrain;

    model ConnectionPossibilities
      extends Modelica.Icons.Example;

      Modelica.Mechanics.Rotational.Components.Inertia inertia1(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-60,
                40},{-40,60}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=1)
        annotation (Placement(transformation(extent={{-20,40},{0,60}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia3(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-60,
                -20},{-40,0}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia4(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                30,-20},{50,0}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Spring spring1(c=1e4)
        annotation (Placement(transformation(extent={{-30,-20},{-10,0}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Spring spring2(c=1e4)
        annotation (Placement(transformation(extent={{0,-20},{20,0}}, rotation=
                0)));

    equation
      connect(inertia1.flange_b, inertia2.flange_a) annotation (Line(
          points={{-40,50},{-20,50}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia3.flange_b, spring1.flange_a) annotation (Line(
          points={{-40,-10},{-30,-10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring1.flange_b, spring2.flange_a) annotation (Line(
          points={{-10,-10},{0,-10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring2.flange_b, inertia4.flange_a) annotation (Line(
          points={{20,-10},{30,-10}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (experiment(StopTime=1.1));
    end ConnectionPossibilities;

    model SupportTorque1
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Sine sine2(freqHz=1) annotation (Placement(
            transformation(extent={{-100,0},{-80,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=true)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation (
          Placement(transformation(extent={{-60,-20},{-40,0}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia3(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-30,
                0},{-10,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.IdealGear idealGear2(ratio=1,
          useSupport=true) annotation (Placement(transformation(extent={{0,0},{
                20,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia4(J=1)
        annotation (Placement(transformation(extent={{60,0},{80,20}}, rotation=
                0)));
      Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction1(
         useSupport=true) annotation (Placement(transformation(extent={{30,0},{
                50,20}}, rotation=0)));
    equation
      connect(sine2.y, torque2.tau) annotation (Line(
          points={{-79,10},{-62,10}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(torque2.support, fixed1.flange) annotation (Line(
          points={{-50,0},{-50,-10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(torque2.flange, inertia3.flange_a) annotation (Line(
          points={{-40,10},{-30,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed1.flange, idealGear2.support) annotation (Line(
          points={{-50,-10},{10,-10},{10,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia3.flange_b, idealGear2.flange_a) annotation (Line(
          points={{-10,10},{0,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(idealGear2.flange_b, bearingFriction1.flange_a) annotation (Line(
          points={{20,10},{30,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(bearingFriction1.flange_b, inertia4.flange_a) annotation (Line(
          points={{50,10},{60,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed1.flange, bearingFriction1.support) annotation (Line(
          points={{-50,-10},{40,-10},{40,0}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (experiment(StopTime=1.1));
    end SupportTorque1;

    model Directions
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Sine sine(freqHz=1) annotation (Placement(
            transformation(extent={{-80,50},{-60,70}}, rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=true)
        annotation (Placement(transformation(extent={{-44,50},{-24,70}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J1(
        J=0.2,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10,
                50},{10,70}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio=5,
          useSupport=true) annotation (Placement(transformation(extent={{20,50},
                {40,70}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J2(J=5) annotation (
          Placement(transformation(extent={{52,50},{72,70}}, rotation=0)));
      Modelica.Blocks.Sources.Sine sine1(freqHz=1) annotation (Placement(
            transformation(extent={{-80,-10},{-60,10}}, rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=true)
        annotation (Placement(transformation(extent={{-44,-10},{-24,10}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J3(
        J=0.2,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10,
                -10},{10,10}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.IdealGear gear1(ratio=1/5,
          useSupport=true) annotation (Placement(transformation(extent={{40,-10},
                {20,10}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J4(J=5) annotation (
          Placement(transformation(extent={{52,-10},{72,10}}, rotation=0)));
      Modelica.Blocks.Sources.Sine sine2(freqHz=1) annotation (Placement(
            transformation(extent={{-80,-70},{-60,-50}}, rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=true)
        annotation (Placement(transformation(extent={{-44,-70},{-24,-50}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J5(
        J=0.2,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10,
                -70},{10,-50}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.IdealGear gear2(ratio=1/5,
          useSupport=true) annotation (Placement(transformation(extent={{40,-70},
                {20,-50}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J6(J=5) annotation (
          Placement(transformation(extent={{72,-70},{52,-50}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation (
          Placement(transformation(extent={{-10,30},{10,50}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed2 annotation (
          Placement(transformation(extent={{-10,-26},{10,-6}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed3 annotation (
          Placement(transformation(extent={{-10,-90},{10,-70}}, rotation=0)));
    equation
      connect(sine.y, torque.tau) annotation (Line(
          points={{-59,60},{-46,60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(torque.flange, J1.flange_a) annotation (Line(
          points={{-24,60},{-10,60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(gear.flange_b, J2.flange_a) annotation (Line(
          points={{40,60},{52,60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(J1.flange_b, gear.flange_a) annotation (Line(
          points={{10,60},{20,60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(sine1.y, torque1.tau) annotation (Line(
          points={{-59,0},{-46,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(torque1.flange, J3.flange_a) annotation (Line(
          points={{-24,0},{-10,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(J3.flange_b, gear1.flange_b) annotation (Line(
          points={{10,0},{20,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(gear1.flange_a, J4.flange_a) annotation (Line(
          points={{40,0},{52,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(sine2.y, torque2.tau) annotation (Line(
          points={{-59,-60},{-46,-60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(torque2.flange, J5.flange_a) annotation (Line(
          points={{-24,-60},{-10,-60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(J5.flange_b, gear2.flange_b) annotation (Line(
          points={{10,-60},{20,-60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(gear2.flange_a, J6.flange_b) annotation (Line(
          points={{40,-60},{52,-60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(torque.support, fixed1.flange) annotation (Line(
          points={{-34,50},{-34,40},{0,40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed1.flange, gear.support) annotation (Line(
          points={{0,40},{30,40},{30,50}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(torque1.support, fixed2.flange) annotation (Line(
          points={{-34,-10},{-34,-16},{0,-16}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed2.flange, gear1.support) annotation (Line(
          points={{0,-16},{30,-16},{30,-10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(torque2.support, fixed3.flange) annotation (Line(
          points={{-34,-70},{-34,-80},{0,-80}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed3.flange, gear2.support) annotation (Line(
          points={{0,-80},{30,-80},{30,-70}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics={Polygon(
                  points={{-23,87},{-13,84},{-23,81},{-23,87}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Line(points={{-23,84},{-53,84}},
              color={0,0,0}),Text(
                  extent={{-18,88},{72,80}},
                  lineColor={0,0,0},
                  textString="(positive) axis of rotation")}), experiment(
            StopTime=2));
    end Directions;

    model Directions2
      extends Modelica.Icons.Example;

      Modelica.Mechanics.Rotational.Components.Inertia J2(
        J=5,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-60,
                55},{-40,75}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J4(
        J=5,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-8,
                55},{12,75}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J6(
        J=5,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                65,55},{45,75}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia1(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-30,
                -10},{-10,10}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                10,-10},{30,10}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia3(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-80,
                -100},{-60,-80}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia4(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-6,
                -64},{-26,-44}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia5(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{0,
                -100},{20,-80}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia6(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(
            origin={40,-50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=true)
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=true)
        annotation (Placement(transformation(extent={{60,-10},{40,10}},
              rotation=0)));
      Modelica.Blocks.Sources.Sine sine1(freqHz=1) annotation (Placement(
            transformation(extent={{-90,-10},{-70,10}}, rotation=0)));
      Modelica.Blocks.Sources.Sine sine2(freqHz=1) annotation (Placement(
            transformation(extent={{90,-10},{70,10}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.IdealPlanetary idealPlanetary1(
          ratio=2) annotation (Placement(transformation(extent={{-50,-100},{-30,
                -80}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.IdealPlanetary idealPlanetary2(
          ratio=2) annotation (Placement(transformation(extent={{60,-100},{80,-80}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation (
          Placement(transformation(extent={{-60,-27},{-40,-7}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed2 annotation (
          Placement(transformation(extent={{40,-24},{60,-4}}, rotation=0)));
    equation
      connect(torque1.flange, inertia1.flange_a) annotation (Line(
          points={{-40,0},{-37.5,0},{-37.5,0},{-35,0},{-35,
              0},{-30,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(sine1.y, torque1.tau) annotation (Line(
          points={{-69,0},{-67.25,0},{-67.25,0},{-65.5,0},
              {-65.5,0},{-62,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(torque2.flange, inertia2.flange_b) annotation (Line(
          points={{40,0},{37.5,0},{37.5,0},{35,0},{35,0},
              {30,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(sine2.y, torque2.tau) annotation (Line(
          points={{69,0},{67.25,0},{67.25,0},{65.5,0},{
              65.5,0},{62,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(idealPlanetary1.sun, inertia3.flange_b) annotation (Line(
          points={{-50,-90},{-60,-90}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(idealPlanetary1.carrier, inertia4.flange_b) annotation (Line(
          points={{-50,-86},{-56,-86},{-56,-54},{-26,-54}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia5.flange_b, idealPlanetary2.sun) annotation (Line(
          points={{20,-90},{60,-90}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia6.flange_a, idealPlanetary2.carrier) annotation (Line(
          points={{40,-60},{40,-86},{60,-86}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(torque1.support, fixed1.flange) annotation (Line(
          points={{-50,-10},{-50,-17}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed2.flange, torque2.support) annotation (Line(
          points={{50,-14},{50,-10}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}),
              graphics={Text(
                  extent={{-28,94},{62,86}},
                  lineColor={0,0,0},
                  textString="(positive) axis of rotation"),Line(points={{-61,
              65},{-80,65}}, color={0,0,0}),Polygon(
                  points={{-68,67},{-61,65},{-68,63},{-68,67}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-57,69},{-91,73}},
                  lineColor={0,0,0},
                  textString="J2.flange_a.tau"),Line(points={{-42,45},{-61,45}},
              color={0,0,0}),Polygon(
                  points={{-49,47},{-42,45},{-49,43},{-49,47}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-33,38},{-67,42}},
                  lineColor={0,0,0},
                  textString="J2.w"),Line(points={{-9,65},{-28,65}}, color={0,0,
              0}),Polygon(
                  points={{-16,67},{-9,65},{-16,63},{-16,67}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-5,69},{-39,73}},
                  lineColor={0,0,0},
                  textString="J4.flange_a.tau"),Line(points={{10,45},{-9,45}},
              color={0,0,0}),Polygon(
                  points={{3,47},{10,45},{3,43},{3,47}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{19,38},{-15,42}},
                  lineColor={0,0,0},
                  textString="J4.w"),Line(points={{44,65},{25,65}}, color={0,0,
              0}),Polygon(
                  points={{37,67},{44,65},{37,63},{37,67}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{48,69},{14,73}},
                  lineColor={0,0,0},
                  textString="J6.flange_b.tau"),Line(points={{63,45},{44,45}},
              color={0,0,0}),Polygon(
                  points={{56,47},{63,45},{56,43},{56,47}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{72,38},{38,42}},
                  lineColor={0,0,0},
                  textString="J6.w"),Line(points={{-32,90},{-62,90}}, color={0,
              0,0}),Polygon(
                  points={{-32,93},{-22,90},{-32,87},{-32,93}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-19,24},{71,16}},
                  lineColor={0,0,0},
                  textString="(positive) axis of rotation"),Line(points={{-23,
              20},{-53,20}}, color={0,0,0}),Polygon(
                  points={{-23,23},{-13,20},{-23,17},{-23,23}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-47,-47},{-54,-49},{-47,-51},{-47,-47}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Line(points={{-52,-49},{-33,-49}},
              color={0,0,0}),Line(points={{31.5,-79.5},{31.5,-60.5}}, color={0,
              0,0}),Polygon(
                  points={{29.5,-75.5},{31.5,-82.5},{33.5,-75.5},{29.5,-75.5}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid)}), experiment(StopTime=2));
    end Directions2;

    model Directions3
      extends Modelica.Icons.Example;

      Modelica.Mechanics.Rotational.Components.Inertia J1(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-80,
                40},{-60,60}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J2(J=1) annotation (
          Placement(transformation(extent={{-20,40},{-40,60}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J3(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                20,40},{40,60}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J4(J=1) annotation (
          Placement(transformation(extent={{60,40},{80,60}}, rotation=0)));
    equation
      connect(J1.flange_b, J2.flange_b) annotation (Line(
          points={{-60,50},{-40,50}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(J3.flange_b, J4.flange_b) annotation (Line(
          points={{40,50},{50,50},{50,30},{90,30},{90,50},{80,50}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics={Line(points={{-60,66},{-80,66}},
              color={0,0,0}),Polygon(
                  points={{-67,68},{-60,66},{-67,64},{-67,68}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-34,68},{-41,66},{-34,64},{-34,68}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Line(points={{-20,66},{-39,66}},
              color={0,0,0}),Text(
                  extent={{-10,60},{14,40}},
                  lineColor={0,0,0},
                  textString="="),Line(points={{40,66},{20,66}}, color={0,0,0}),
              Polygon(
                  points={{33,68},{40,66},{33,64},{33,68}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Line(points={{80,66},{60,66}},
              color={0,0,0}),Polygon(
                  points={{73,68},{80,66},{73,64},{73,68}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
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
                40},{-70,60}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2(
        J=1,
        stateSelect=StateSelect.default,
        w(fixed=true, start=2),
        phi(fixed=false, start=0.017453292519943),
        a(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10,
                40},{10,60}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia3(
        J=1,
        stateSelect=StateSelect.prefer,
        a(fixed=false),
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                40,40},{60,60}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia4(
        J=1,
        stateSelect=StateSelect.always,
        a(fixed=false),
        w(fixed=true, start=-2),
        phi(fixed=true, start=-0.017453292519943)) annotation (Placement(
            transformation(extent={{80,40},{100,60}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia5(
        J=1,
        stateSelect=StateSelect.avoid,
        a(fixed=false),
        w(fixed=true, start=33),
        phi(fixed=true, start=0.38397243543875)) annotation (Placement(
            transformation(extent={{-90,0},{-70,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia6(
        J=1,
        a(fixed=true, start=44),
        phi(fixed=false),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10,
                0},{10,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia7(
        J=1,
        a(fixed=true, start=3),
        phi(fixed=true, start=0.017453292519943),
        w(fixed=true, start=2)) annotation (Placement(transformation(extent={{
                20,0},{40,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia7a(
        J=1,
        a(start=3),
        phi(start=0.017453292519943),
        w(start=2, fixed=true)) annotation (Placement(transformation(extent={{
                80,0},{100,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia8(
        J=1,
        w(fixed=true, start=0),
        a(fixed=true, start=0),
        phi(fixed=false, start=0)) annotation (Placement(transformation(extent=
                {{-80,-40},{-60,-20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia8a(
        J=1,
        phi(fixed=true, start=0),
        w(start=0, fixed=true)) annotation (Placement(transformation(extent={{-20,
                -40},{0,-20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia9(
        J=1,
        a(fixed=true, start=33),
        w(fixed=true, start=22),
        phi(fixed=true, start=0.19198621771938)) annotation (Placement(
            transformation(extent={{20,-40},{40,-20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia9a(
        J=1,
        a(start=33),
        phi(start=0.19198621771938),
        w(start=22, fixed=true)) annotation (Placement(transformation(extent={{
                80,-40},{100,-20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Spring spring(c=10000)
        annotation (Placement(transformation(extent={{-40,40},{-20,60}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (
          Placement(transformation(extent={{-60,40},{-40,60}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Spring spring1(c=10000)
        annotation (Placement(transformation(extent={{50,0},{70,20}}, rotation=
                0)));
      Modelica.Mechanics.Rotational.Components.Spring spring2(c=10000)
        annotation (Placement(transformation(extent={{-40,0},{-20,20}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation (
          Placement(transformation(extent={{-60,0},{-40,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Spring spring3(c=10000)
        annotation (Placement(transformation(extent={{-50,-40},{-30,-20}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Spring spring4(c=10000)
        annotation (Placement(transformation(extent={{50,-40},{70,-20}},
              rotation=0)));
    equation
      connect(spring.flange_b, inertia2.flange_a) annotation (Line(
          points={{-20,50},{-10,50}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed.flange, spring.flange_a) annotation (Line(
          points={{-50,50},{-40,50}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia7.flange_b, spring1.flange_a) annotation (Line(
          points={{40,10},{50,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring1.flange_b, inertia7a.flange_a) annotation (Line(
          points={{70,10},{80,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring2.flange_b, inertia6.flange_a) annotation (Line(
          points={{-20,10},{-10,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed1.flange, spring2.flange_a) annotation (Line(
          points={{-50,10},{-40,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia8.flange_b, spring3.flange_a) annotation (Line(
          points={{-60,-30},{-50,-30}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring3.flange_b, inertia8a.flange_a) annotation (Line(
          points={{-30,-30},{-20,-30}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia9.flange_b, spring4.flange_a) annotation (Line(
          points={{40,-30},{50,-30}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring4.flange_b, inertia9a.flange_a) annotation (Line(
          points={{70,-30},{80,-30}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (experiment(StopTime=1.1), Diagram(graphics={Rectangle(
              extent={{-90,98},{90,64}},
              lineColor={255,170,85},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid), Text(
              extent={{-80,100},{80,60}},
              lineColor={0,0,255},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              textString="Since the initialization was changed some elements here
are redundant (e.g. inertia4, inertia5).
But for compatibility reasons they were not deleted yet.")}));
    end Inertia;

    model SpringDamper
      extends Modelica.Icons.Example;

      Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (
          Placement(transformation(extent={{-100,60},{-80,80}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia1(J=1)
        annotation (Placement(transformation(extent={{-40,60},{-20,80}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=1)
        annotation (Placement(transformation(extent={{-40,20},{-20,40}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia3(J=1)
        annotation (Placement(transformation(extent={{-40,-20},{-20,0}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia4(J=1, w(fixed=
              true, start=0)) annotation (Placement(transformation(extent={{-40,
                -60},{-20,-40}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia5(J=1, phi(fixed=
              true, start=0)) annotation (Placement(transformation(extent={{-40,
                -100},{-20,-80}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia6(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                20,40},{40,60}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia7(J=1)
        annotation (Placement(transformation(extent={{74,40},{94,60}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper1(
        c=1e4,
        d=10,
        w_rel(start=2, fixed=true),
        phi_rel(start=1, fixed=true)) annotation (Placement(transformation(
              extent={{-70,60},{-50,80}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper2(
        c=1e4,
        d=10,
        stateSelect=StateSelect.prefer,
        a_rel(fixed=true),
        w_rel(fixed=true, start=-2),
        phi_rel(fixed=false, start=-1)) annotation (Placement(transformation(
              extent={{-70,20},{-50,40}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper3(
        c=1e4,
        d=10,
        stateSelect=StateSelect.always,
        a_rel(fixed=false),
        w_rel(fixed=true, start=2),
        phi_rel(fixed=true, start=1)) annotation (Placement(transformation(
              extent={{-70,-20},{-50,0}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper4(
        c=1e4,
        d=10,
        stateSelect=StateSelect.avoid,
        a_rel(fixed=false),
        phi_rel(fixed=true),
        w_rel(fixed=false)) annotation (Placement(transformation(extent={{-70,-60},
                {-50,-40}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper5(
        c=1e4,
        d=10,
        stateSelect=StateSelect.never,
        a_rel(fixed=false),
        phi_rel(fixed=false),
        w_rel(fixed=true, start=3)) annotation (Placement(transformation(extent=
               {{-70,-100},{-50,-80}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Spring spring(c=1e4) annotation (
         Placement(transformation(extent={{48,40},{68,60}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.RelativeStates relativeStates(
          phi_rel(fixed=true), w_rel(fixed=true)) annotation (Placement(
            transformation(extent={{48,20},{68,40}}, rotation=0)));
    equation
      connect(springDamper1.flange_a, fixed.flange) annotation (Line(
          points={{-70,70},{-90,70}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(springDamper1.flange_b, inertia1.flange_a) annotation (Line(
          points={{-50,70},{-40,70}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia2.flange_a, springDamper2.flange_b) annotation (Line(
          points={{-40,30},{-50,30}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(springDamper2.flange_a, fixed.flange) annotation (Line(
          points={{-70,30},{-80,30},{-80,70},{-90,70}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia3.flange_a, springDamper3.flange_b) annotation (Line(
          points={{-40,-10},{-50,-10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(springDamper3.flange_a, fixed.flange) annotation (Line(
          points={{-70,-10},{-80,-10},{-80,70},{-90,70}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia4.flange_a, springDamper4.flange_b) annotation (Line(
          points={{-40,-50},{-50,-50}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(springDamper4.flange_a, fixed.flange) annotation (Line(
          points={{-70,-50},{-80,-50},{-80,70},{-90,70}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia5.flange_a, springDamper5.flange_b) annotation (Line(
          points={{-40,-90},{-50,-90}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(springDamper5.flange_a, fixed.flange) annotation (Line(
          points={{-70,-90},{-80,-90},{-80,70},{-90,70}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia6.flange_b, spring.flange_a) annotation (Line(
          points={{40,50},{48,50}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring.flange_b, inertia7.flange_a) annotation (Line(
          points={{68,50},{74,50}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(relativeStates.flange_b, spring.flange_b) annotation (Line(
          points={{68,30},{68,50}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring.flange_a, relativeStates.flange_a) annotation (Line(
          points={{48,50},{48,30}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (experiment(StopTime=1.1), Diagram(graphics={Polygon(
                  points={{-72,86},{-72,54},{-14,54},{-14,6},{-72,6},{-72,-32},
                {100,-32},{100,20},{10,20},{10,86},{-72,86}},
                  lineColor={255,170,85},
                  smooth=Smooth.None,
                  fillColor={255,213,170},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{10,20},{90,-30}},
                  lineColor={0,0,255},
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
          false) annotation (Placement(transformation(extent={{-20,60},{0,80}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(J=1) annotation (
        Placement(transformation(extent={{20,60},{40,80}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Speed speed2(
      f_crit=5,
      exact=true,
      useSupport=false) annotation (Placement(transformation(extent={{-20,20},{
              0,40}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=1) annotation (
        Placement(transformation(extent={{20,20},{40,40}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine2(freqHz=1) annotation (Placement(
          transformation(extent={{-60,20},{-40,40}}, rotation=0)));
    Modelica.Blocks.Sources.Step step(startTime=0.5) annotation (Placement(
          transformation(extent={{-60,60},{-40,80}}, rotation=0)));
    Modelica.Mechanics.Translational.Sources.Speed speed3(f_crit=5, s(start=1))
      annotation (Placement(transformation(extent={{-20,-20},{0,0}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass mass1(m=2) annotation (
        Placement(transformation(extent={{20,-20},{40,0}}, rotation=0)));
    Modelica.Blocks.Sources.Step step1(startTime=0.5) annotation (Placement(
          transformation(extent={{-60,-20},{-40,0}}, rotation=0)));
    Modelica.Mechanics.Translational.Sources.Speed speed4(exact=true, s(start=1))
      annotation (Placement(transformation(extent={{-20,-60},{0,-40}}, rotation=
             0)));
    Modelica.Mechanics.Translational.Components.Mass mass2(m=2) annotation (
        Placement(transformation(extent={{20,-60},{40,-40}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine4(freqHz=1) annotation (Placement(
          transformation(extent={{-60,-60},{-40,-40}}, rotation=0)));
  equation
    connect(speed1.flange, inertia1.flange_a)
      annotation (Line(points={{0,70},{20,70}}, color={0,0,0}));
    connect(speed2.flange, inertia2.flange_a)
      annotation (Line(points={{0,30},{20,30}}, color={0,0,0}));
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
      m=1) annotation (Placement(transformation(extent={{66,36},{86,56}},
            rotation=0)));
    Modelica.Mechanics.MultiBody.Joints.Revolute ActuatedRevolute1(
        useAxisFlange=true) annotation (Placement(transformation(extent={{32,0},
              {52,20}}, rotation=0)));
    inner Modelica.Mechanics.MultiBody.World world(g=0) annotation (Placement(
          transformation(extent={{0,0},{20,20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Move move(useSupport=false)
      annotation (Placement(transformation(extent={{20,40},{40,60}}, rotation=0)));
    Modelica.Blocks.Routing.Multiplex3 Multiplex3_1 annotation (Placement(
          transformation(extent={{-56,40},{-36,60}}, rotation=0)));
    Modelica.Blocks.Sources.Constant Constant1(k=1) annotation (Placement(
          transformation(extent={{-100,16},{-80,36}}, rotation=0)));
    Modelica.Blocks.Sources.Constant Constant2(k=0) annotation (Placement(
          transformation(extent={{-100,70},{-80,90}}, rotation=0)));
    Modelica.Mechanics.Translational.Sources.Move move1 annotation (Placement(
          transformation(extent={{-20,-40},{0,-20}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass(m=2)
      annotation (Placement(transformation(extent={{20,-40},{40,-20}}, rotation=
             0)));
  equation
    connect(ActuatedRevolute1.frame_b, Body1.frame_a) annotation (Line(
        points={{52,10},{62,10},{62,46},{66,46}},
        color={0,0,0},
        thickness=0.5));
    connect(world.frame_b, ActuatedRevolute1.frame_a) annotation (Line(
        points={{20,10},{32,10}},
        color={0,0,0},
        thickness=0.5));
    connect(move.flange, ActuatedRevolute1.axis)
      annotation (Line(points={{40,50},{42,50},{42,20}}, color={0,0,0}));
    connect(Multiplex3_1.y, move.u)
      annotation (Line(points={{-35,50},{18,50}}, color={0,0,127}));
    connect(Constant1.y, Multiplex3_1.u3[1]) annotation (Line(points={{-79,26},
            {-74,26},{-74,43},{-58,43}}, color={0,0,127}));
    connect(Constant2.y, Multiplex3_1.u1[1]) annotation (Line(points={{-79,80},
            {-74,80},{-74,57},{-58,57}}, color={0,0,127}));
    connect(Constant2.y, Multiplex3_1.u2[1]) annotation (Line(points={{-79,80},
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
        Placement(transformation(extent={{-80,80},{-60,100}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio=3,
        useSupport=true) annotation (Placement(transformation(extent={{-50,80},
              {-30,100}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.IdealPlanetary idealPlanetary(
        ratio=3) annotation (Placement(transformation(extent={{-16,80},{4,100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (Placement(
          transformation(extent={{-50,50},{-30,70}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(J=2) annotation (
        Placement(transformation(extent={{-50,120},{-30,140}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2(
      J=4,
      phi(start=0, fixed=true),
      w(start=0, fixed=true)) annotation (Placement(transformation(extent={{40,
              80},{60,100}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Spring spring(c=1e4) annotation (
        Placement(transformation(extent={{12,80},{32,100}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Damper damper(
      d=10,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{12,98},{
              32,118}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.SpringDamper springDamper(
      c=1e4,
      d=10,
      phi_rel0=1.7453292519943e-05,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{-78,120},
              {-58,140}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia3(
      J=2,
      phi(start=0.0174532925199433),
      w(start=2)) annotation (Placement(transformation(extent={{-112,120},{-92,
              140}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.ElastoBacklash elastoBacklash(
      c=1e4,
      d=20,
      b=1.7453292519943e-07,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{-10,120},
              {10,140}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia4(J=2) annotation (
        Placement(transformation(extent={{20,120},{40,140}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
      tau_pos=[0, 2],
      peak=1.1,
      useSupport=true) annotation (Placement(transformation(extent={{44,120},{
              64,140}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Clutch clutch(
      mue_pos=[0, 1],
      peak=1.1,
      cgeo=1.2,
      fn_max=1.3,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{-106,100},
              {-86,80}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia5(J=3) annotation (
        Placement(transformation(extent={{-136,80},{-116,100}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine(freqHz=1) annotation (Placement(
          transformation(extent={{-124,50},{-104,70}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Brake brake(useSupport=true,
        fn_max=1) annotation (Placement(transformation(extent={{80,80},{100,100}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine1(freqHz=1) annotation (Placement(
          transformation(
          origin={90,130},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(useSupport=
          true, ratio=1) annotation (Placement(transformation(extent={{-140,120},
              {-120,140}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia6(
      J=2,
      a(fixed=false),
      phi(fixed=true, start=0.0174532925199433),
      w(fixed=true, start=2)) annotation (Placement(transformation(extent={{-170,
              120},{-150,140}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Gearbox gear2_1(
      ratio=2,
      lossTable=[0, 0.9, 1, 0, 0],
      c=1e4,
      d=10,
      useSupport=true,
      b=1.7453292519943e-07,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{-100,0},
              {-80,20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia7(J=3) annotation (
        Placement(transformation(extent={{-130,0},{-110,20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia8(
      J=3,
      phi(start=0, fixed=true),
      w(start=0, fixed=true)) annotation (Placement(transformation(extent={{-68,
              0},{-48,20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Position position(useSupport=true, w(
          fixed=true)) annotation (Placement(transformation(extent={{30,30},{50,
              50}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation (Placement(
          transformation(extent={{-100,-20},{-80,0}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed2 annotation (Placement(
          transformation(extent={{28,10},{48,30}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia9(J=3) annotation (
        Placement(transformation(extent={{60,30},{80,50}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine2(freqHz=1) annotation (Placement(
          transformation(extent={{0,30},{20,50}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine3(freqHz=1) annotation (Placement(
          transformation(extent={{0,-20},{20,0}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia10(J=3) annotation (
       Placement(transformation(extent={{60,-20},{80,0}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed3 annotation (Placement(
          transformation(extent={{30,-40},{50,-20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Speed speed(useSupport=true)
      annotation (Placement(transformation(extent={{30,-20},{50,0}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine4(freqHz=1) annotation (Placement(
          transformation(extent={{0,-80},{20,-60}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia11(J=3) annotation (
       Placement(transformation(extent={{60,-80},{80,-60}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed4 annotation (Placement(
          transformation(extent={{30,-100},{50,-80}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Accelerate accelerate(useSupport=true)
      annotation (Placement(transformation(extent={{30,-80},{50,-60}}, rotation=
             0)));
    Modelica.Blocks.Sources.Sine sine5[3](each amplitude=2, freqHz={1,1,1})
      annotation (Placement(transformation(extent={{0,-140},{20,-120}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia12(J=3) annotation (
       Placement(transformation(extent={{60,-140},{80,-120}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed5 annotation (Placement(
          transformation(extent={{30,-160},{50,-140}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Move move(useSupport=true)
      annotation (Placement(transformation(extent={{30,-140},{50,-120}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=true)
      annotation (Placement(transformation(extent={{130,80},{110,100}},rotation=
             0)));
    Modelica.Blocks.Sources.Sine sine6(freqHz=1) annotation (Placement(
          transformation(extent={{160,80},{140,100}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque2 torque2_1 annotation (
        Placement(transformation(extent={{92,-20},{112,0}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia13(
      J=3,
      phi(start=0, fixed=true),
      w(start=0, fixed=true)) annotation (Placement(transformation(extent={{120,
              -20},{140,0}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine7(freqHz=1) annotation (Placement(
          transformation(extent={{74,6},{94,26}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
      linearSpeedDependentTorque(
      tau_nominal=10,
      w_nominal=10,
      useSupport=true) annotation (Placement(transformation(extent={{-162,0},{-142,
              20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque(
      tau_nominal=100,
      w_nominal=1,
      useSupport=true) annotation (Placement(transformation(extent={{-10,0},{-32,
              20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(
        tau_constant=11, useSupport=true) annotation (Placement(transformation(
            extent={{-140,-60},{-120,-40}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia14(
      J=3,
      phi(start=0, fixed=true),
      w(start=0, fixed=true)) annotation (Placement(transformation(extent={{-104,
              -80},{-84,-60}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep(
      stepTorque=22,
      offsetTorque=11,
      startTime=1,
      useSupport=true) annotation (Placement(transformation(extent={{-140,-100},
              {-120,-80}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed6 annotation (Placement(
          transformation(extent={{-140,-120},{-120,-100}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=
          11, useSupport=true) annotation (Placement(transformation(extent={{-90,
              -110},{-70,-90}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia15(J=3, phi(start=0,
          fixed=true)) annotation (Placement(transformation(extent={{-60,-110},
              {-40,-90}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.RelativeStates relativeStates
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation (
        Placement(transformation(extent={{98,-80},{118,-60}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
        Placement(transformation(extent={{98,-56},{118,-36}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sensors.AccSensor accSensor annotation (
        Placement(transformation(extent={{98,-106},{118,-86}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sensors.RelAngleSensor relAngleSensor
      annotation (Placement(transformation(extent={{120,30},{140,50}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Sensors.RelSpeedSensor relSpeedSensor
      annotation (Placement(transformation(extent={{146,-48},{166,-28}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sensors.RelAccSensor relAccSensor annotation (
       Placement(transformation(extent={{140,-90},{160,-70}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor annotation (
       Placement(transformation(extent={{-60,-150},{-40,-130}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor annotation (
        Placement(transformation(extent={{-90,-150},{-70,-130}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia16(J=3) annotation (
       Placement(transformation(extent={{-120,-150},{-100,-130}}, rotation=0)));
  equation
    connect(inertia.flange_b, idealGear.flange_a) annotation (Line(
        points={{-60,90},{-50,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGear.flange_b, idealPlanetary.sun) annotation (Line(
        points={{-30,90},{-16,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGear.support, fixed.flange) annotation (Line(
        points={{-40,80},{-40,60}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealPlanetary.carrier, inertia1.flange_b) annotation (Line(
        points={{-16,94},{-22,94},{-22,130},{-30,130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealPlanetary.ring, spring.flange_a) annotation (Line(
        points={{4,90},{12,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(spring.flange_b, inertia2.flange_a) annotation (Line(
        points={{32,90},{40,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealPlanetary.ring, damper.flange_a) annotation (Line(
        points={{4,90},{8,90},{8,108},{12,108}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(damper.flange_b, inertia2.flange_a) annotation (Line(
        points={{32,108},{40,108},{40,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(springDamper.flange_b, inertia1.flange_a) annotation (Line(
        points={{-58,130},{-50,130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia3.flange_b, springDamper.flange_a) annotation (Line(
        points={{-92,130},{-78,130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia1.flange_b, elastoBacklash.flange_a) annotation (Line(
        points={{-30,130},{-10,130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(elastoBacklash.flange_b, inertia4.flange_a) annotation (Line(
        points={{10,130},{20,130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia4.flange_b, bearingFriction.flange_a) annotation (Line(
        points={{40,130},{44,130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed.flange, bearingFriction.support) annotation (Line(
        points={{-40,60},{70,60},{70,114},{54,114},{54,120}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(clutch.flange_b, inertia.flange_a) annotation (Line(
        points={{-86,90},{-80,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia5.flange_b, clutch.flange_a) annotation (Line(
        points={{-116,90},{-106,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine.y, clutch.f_normalized) annotation (Line(
        points={{-103,60},{-96,60},{-96,79}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertia2.flange_b, brake.flange_a) annotation (Line(
        points={{60,90},{80,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine1.y, brake.f_normalized) annotation (Line(
        points={{90,119},{90,101}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(fixed.flange, brake.support) annotation (Line(
        points={{-40,60},{90,60},{90,80}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(lossyGear.flange_b, inertia3.flange_a) annotation (Line(
        points={{-120,130},{-112,130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia6.flange_b, lossyGear.flange_a) annotation (Line(
        points={{-150,130},{-140,130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(lossyGear.support, fixed.flange) annotation (Line(
        points={{-130,120},{-130,110},{-150,110},{-150,40},{-60,40},{-60,60},{-40,
            60}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia7.flange_b, gear2_1.flange_a) annotation (Line(
        points={{-110,10},{-100,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(gear2_1.flange_b, inertia8.flange_a) annotation (Line(
        points={{-80,10},{-68,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed1.flange, gear2_1.support) annotation (Line(
        points={{-90,-10},{-90,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed2.flange, position.support) annotation (Line(
        points={{38,20},{38,30},{40,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position.flange, inertia9.flange_a) annotation (Line(
        points={{50,40},{60,40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine2.y, position.phi_ref) annotation (Line(
        points={{21,40},{28,40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine3.y, speed.w_ref) annotation (Line(
        points={{21,-10},{28,-10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(speed.flange, inertia10.flange_a) annotation (Line(
        points={{50,-10},{60,-10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(speed.support, fixed3.flange) annotation (Line(
        points={{40,-20},{40,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine4.y, accelerate.a_ref) annotation (Line(
        points={{21,-70},{28,-70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(accelerate.flange, inertia11.flange_a) annotation (Line(
        points={{50,-70},{60,-70}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(accelerate.support, fixed4.flange) annotation (Line(
        points={{40,-80},{40,-90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine5.y, move.u) annotation (Line(
        points={{21,-130},{28,-130}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(move.flange, inertia12.flange_a) annotation (Line(
        points={{50,-130},{60,-130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(move.support, fixed5.flange) annotation (Line(
        points={{40,-140},{40,-150}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(brake.flange_b, torque.flange) annotation (Line(
        points={{100,90},{110,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed.flange, torque.support) annotation (Line(
        points={{-40,60},{120,60},{120,80}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine6.y, torque.tau) annotation (Line(
        points={{139,90},{132,90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(torque2_1.flange_a, inertia10.flange_b) annotation (Line(
        points={{92,-10},{80,-10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque2_1.flange_b, inertia13.flange_a) annotation (Line(
        points={{112,-10},{120,-10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine7.y, torque2_1.tau) annotation (Line(
        points={{95,16},{102,16},{102,-6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(linearSpeedDependentTorque.flange, inertia7.flange_a) annotation (
        Line(
        points={{-142,10},{-130,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(linearSpeedDependentTorque.support, fixed1.flange) annotation (Line(
        points={{-152,0},{-152,-10},{-90,-10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(quadraticSpeedDependentTorque.flange, inertia8.flange_b)
      annotation (Line(
        points={{-32,10},{-48,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed1.flange, quadraticSpeedDependentTorque.support) annotation (
        Line(
        points={{-90,-10},{-21,-10},{-21,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(constantTorque.flange, inertia14.flange_a) annotation (Line(
        points={{-120,-50},{-110,-50},{-110,-70},{-104,-70}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torqueStep.flange, inertia14.flange_a) annotation (Line(
        points={{-120,-90},{-110,-90},{-110,-70},{-104,-70}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed6.flange, torqueStep.support) annotation (Line(
        points={{-130,-110},{-130,-100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed6.flange, constantTorque.support) annotation (Line(
        points={{-130,-110},{-150,-110},{-150,-60},{-130,-60}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torqueStep.support, constantSpeed.support) annotation (Line(
        points={{-130,-100},{-130,-110},{-80,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(constantSpeed.flange, inertia15.flange_a) annotation (Line(
        points={{-70,-100},{-60,-100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia8.flange_b, relativeStates.flange_b) annotation (Line(
        points={{-48,10},{-40,10},{-40,-30},{-60,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(relativeStates.flange_a, inertia7.flange_b) annotation (Line(
        points={{-80,-30},{-110,-30},{-110,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia11.flange_b, angleSensor.flange) annotation (Line(
        points={{80,-70},{98,-70}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia11.flange_b, speedSensor.flange) annotation (Line(
        points={{80,-70},{84,-70},{84,-46},{98,-46}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia11.flange_b, accSensor.flange) annotation (Line(
        points={{80,-70},{84,-70},{84,-96},{98,-96}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia9.flange_b, relAngleSensor.flange_a) annotation (Line(
        points={{80,40},{120,40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia13.flange_b, relAngleSensor.flange_b) annotation (Line(
        points={{140,-10},{150,-10},{150,40},{140,40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia13.flange_b, relSpeedSensor.flange_a) annotation (Line(
        points={{140,-10},{140,-38},{146,-38}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia12.flange_b, relSpeedSensor.flange_b) annotation (Line(
        points={{80,-130},{178,-130},{178,-38},{166,-38}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia13.flange_b, relAccSensor.flange_a) annotation (Line(
        points={{140,-10},{140,-80}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(relAccSensor.flange_b, inertia12.flange_b) annotation (Line(
        points={{160,-80},{168,-80},{168,-130},{80,-130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia15.flange_b, torqueSensor.flange_b) annotation (Line(
        points={{-40,-100},{-30,-100},{-30,-140},{-40,-140}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torqueSensor.flange_a, powerSensor.flange_b) annotation (Line(
        points={{-60,-140},{-70,-140}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia16.flange_b, powerSensor.flange_a) annotation (Line(
        points={{-100,-140},{-90,-140}},
        color={0,0,0},
        smooth=Smooth.None));
    annotation (experiment(StopTime=0.9), Diagram(coordinateSystem(
            preserveAspectRatio=true, extent={{-160,-160},{160,160}})));
  end AllComponents;

  model TestBearingConversion
    "Test, whether conversion of bearing to support is correctly performed"
    extends Modelica.Icons.Example;

    Modelica.Mechanics.Rotational.Components.IdealGear idealGear(useSupport=
          false, ratio=1) annotation (Placement(transformation(extent={{-150,
              160},{-130,180}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-180,
              160},{-160,180}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.IdealGear idealGear1(useSupport=
          true, ratio=1) annotation (Placement(transformation(extent={{-118,160},
              {-98,180}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
        useSupport=true) annotation (Placement(transformation(extent={{-90,160},
              {-70,180}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-180,
              110},{-160,130}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction1(
        useSupport=false) annotation (Placement(transformation(extent={{-150,
              110},{-130,130}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (Placement(
          transformation(extent={{-118,144},{-98,164}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Brake brake(useSupport=true,
        fn_max=1) annotation (Placement(transformation(extent={{-150,40},{-130,
              60}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine(freqHz=1) annotation (Placement(
          transformation(extent={{-180,70},{-160,90}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-180,
              40},{-160,60}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Brake brake1(useSupport=false,
        fn_max=1) annotation (Placement(transformation(extent={{-70,40},{-50,60}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia3(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-100,
              40},{-80,60}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation (Placement(
          transformation(extent={{-150,20},{-130,40}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(useSupport=
          false, ratio=1) annotation (Placement(transformation(extent={{-70,110},
              {-50,130}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia4(J=1) annotation (
        Placement(transformation(extent={{-100,110},{-80,130}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia5(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-40,
              110},{-20,130}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear1(useSupport=
          true, ratio=1) annotation (Placement(transformation(extent={{30,110},
              {50,130}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia6(J=1) annotation (
        Placement(transformation(extent={{0,110},{20,130}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia7(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{60,
              110},{80,130}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed2 annotation (Placement(
          transformation(extent={{30,90},{50,110}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Gearbox gear2_1(
      useSupport=false,
      ratio=1,
      c=100000,
      d=0,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{30,40},{
              50,60}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia8(J=1) annotation (
        Placement(transformation(extent={{0,40},{20,60}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia9(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{60,
              40},{80,60}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Position position(useSupport=false, w(
          fixed=true)) annotation (Placement(transformation(extent={{-140,-20},
              {-120,0}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine1(freqHz=1) annotation (Placement(
          transformation(extent={{-180,-20},{-160,0}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia12(J=1) annotation (
       Placement(transformation(extent={{-110,-20},{-90,0}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Position position1(useSupport=true, w(
          fixed=true)) annotation (Placement(transformation(extent={{-140,-50},
              {-120,-30}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia13(J=1) annotation (
       Placement(transformation(extent={{-110,-50},{-90,-30}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed4 annotation (Placement(
          transformation(extent={{-140,-66},{-120,-46}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Gearbox gear2_2(
      useSupport=true,
      ratio=1,
      c=100000,
      d=0,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{30,160},
              {50,180}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia10(J=1) annotation (
       Placement(transformation(extent={{2,160},{22,180}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia11(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{60,
              160},{80,180}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed3 annotation (Placement(
          transformation(extent={{30,144},{50,164}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Speed position2(useSupport=false)
      annotation (Placement(transformation(extent={{-20,-20},{0,0}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine2(freqHz=1) annotation (Placement(
          transformation(extent={{-60,-20},{-40,0}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia14(J=1) annotation (
       Placement(transformation(extent={{10,-20},{30,0}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Speed position3(useSupport=true)
      annotation (Placement(transformation(extent={{-20,-50},{0,-30}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia15(J=1) annotation (
       Placement(transformation(extent={{10,-50},{30,-30}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed5 annotation (Placement(
          transformation(extent={{-20,-66},{0,-46}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Accelerate position4(useSupport=false)
      annotation (Placement(transformation(extent={{100,-20},{120,0}}, rotation=
             0)));
    Modelica.Blocks.Sources.Sine sine3(freqHz=1) annotation (Placement(
          transformation(extent={{60,-20},{80,0}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia16(J=1) annotation (
       Placement(transformation(extent={{130,-20},{150,0}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Accelerate position5(useSupport=true)
      annotation (Placement(transformation(extent={{100,-50},{120,-30}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia17(J=1) annotation (
       Placement(transformation(extent={{130,-50},{150,-30}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed6 annotation (Placement(
          transformation(extent={{100,-66},{120,-46}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Move position6(useSupport=false)
      annotation (Placement(transformation(extent={{-140,-110},{-120,-90}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine4[3](freqHz={1,1,1}) annotation (Placement(
          transformation(extent={{-180,-110},{-160,-90}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia18(J=1) annotation (
       Placement(transformation(extent={{-110,-110},{-90,-90}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Move position7(useSupport=true)
      annotation (Placement(transformation(extent={{-140,-140},{-120,-120}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia19(J=1) annotation (
       Placement(transformation(extent={{-110,-140},{-90,-120}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed8 annotation (Placement(
          transformation(extent={{-140,-158},{-120,-138}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine5(freqHz=1) annotation (Placement(
          transformation(extent={{-58,-110},{-38,-90}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=false)
      annotation (Placement(transformation(extent={{-20,-110},{0,-90}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
      linearSpeedDependentTorque(
      tau_nominal=1,
      w_nominal=1,
      useSupport=false) annotation (Placement(transformation(extent={{-20,-144},
              {0,-124}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque(
      tau_nominal=1,
      w_nominal=1,
      useSupport=false) annotation (Placement(transformation(extent={{-20,-180},
              {0,-160}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(
        tau_constant=1, useSupport=false) annotation (Placement(transformation(
            extent={{40,-144},{20,-124}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep(
      useSupport=false,
      stepTorque=1,
      offsetTorque=0) annotation (Placement(transformation(extent={{40,-180},{
              20,-160}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia20(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{20,
              -110},{40,-90}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine6(freqHz=1) annotation (Placement(
          transformation(extent={{60,-110},{80,-90}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=true)
      annotation (Placement(transformation(extent={{100,-110},{120,-90}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
      linearSpeedDependentTorque1(
      tau_nominal=1,
      w_nominal=1,
      useSupport=true) annotation (Placement(transformation(extent={{100,-144},
              {120,-124}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque1(
      tau_nominal=1,
      w_nominal=1,
      useSupport=true) annotation (Placement(transformation(extent={{100,-180},
              {120,-160}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque1(
        tau_constant=1, useSupport=true) annotation (Placement(transformation(
            extent={{160,-144},{140,-124}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep1(
      useSupport=true,
      stepTorque=1,
      offsetTorque=0) annotation (Placement(transformation(extent={{160,-180},{
              140,-160}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia21(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{140,
              -110},{160,-90}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed7 annotation (Placement(
          transformation(extent={{130,-200},{150,-180}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.IdealGearR2T idealGearR2T(
      useSupportR=false,
      useSupportT=false,
      ratio=1) annotation (Placement(transformation(extent={{130,160},{150,180}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia22(J=1) annotation (
       Placement(transformation(extent={{100,160},{120,180}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass(
      m=1,
      s(fixed=true),
      v(fixed=true)) annotation (Placement(transformation(extent={{160,160},{
              180,180}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.IdealGearR2T idealGearR2T1(
      useSupportR=true,
      useSupportT=true,
      ratio=1) annotation (Placement(transformation(extent={{130,110},{150,130}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia23(J=1) annotation (
       Placement(transformation(extent={{100,110},{120,130}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass1(
      m=1,
      s(fixed=true),
      v(fixed=true)) annotation (Placement(transformation(extent={{160,110},{
              180,130}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed9 annotation (Placement(
          transformation(extent={{120,92},{140,112}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Fixed fixed10 annotation (
        Placement(transformation(extent={{142,92},{162,112}}, rotation=0)));
  equation
    connect(inertia.flange_b, idealGear.flange_a) annotation (Line(
        points={{-160,170},{-150,170}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGear.flange_b, idealGear1.flange_a) annotation (Line(
        points={{-130,170},{-118,170}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGear1.flange_b, bearingFriction.flange_a) annotation (Line(
        points={{-98,170},{-90,170}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia1.flange_b, bearingFriction1.flange_a) annotation (Line(
        points={{-160,120},{-150,120}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGear1.support, fixed.flange) annotation (Line(
        points={{-108,160},{-108,154}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed.flange, bearingFriction.support) annotation (Line(
        points={{-108,154},{-80,154},{-80,160}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine.y, brake.f_normalized) annotation (Line(
        points={{-159,80},{-140,80},{-140,61}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertia2.flange_b, brake.flange_a) annotation (Line(
        points={{-160,50},{-150,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia3.flange_b, brake1.flange_a) annotation (Line(
        points={{-80,50},{-70,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine.y, brake1.f_normalized) annotation (Line(
        points={{-159,80},{-60,80},{-60,61}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(brake.support, fixed1.flange) annotation (Line(
        points={{-140,40},{-140,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia4.flange_b, lossyGear.flange_a) annotation (Line(
        points={{-80,120},{-70,120}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(lossyGear.flange_b, inertia5.flange_a) annotation (Line(
        points={{-50,120},{-40,120}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia6.flange_b, lossyGear1.flange_a) annotation (Line(
        points={{20,120},{30,120}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(lossyGear1.flange_b, inertia7.flange_a) annotation (Line(
        points={{50,120},{60,120}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed2.flange, lossyGear1.support) annotation (Line(
        points={{40,100},{40,110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia8.flange_b, gear2_1.flange_a) annotation (Line(
        points={{20,50},{30,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(gear2_1.flange_b, inertia9.flange_a) annotation (Line(
        points={{50,50},{60,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine1.y, position.phi_ref) annotation (Line(
        points={{-159,-10},{-142,-10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(position.flange, inertia12.flange_a) annotation (Line(
        points={{-120,-10},{-110,-10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position1.flange, inertia13.flange_a) annotation (Line(
        points={{-120,-40},{-110,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine1.y, position1.phi_ref) annotation (Line(
        points={{-159,-10},{-150,-10},{-150,-40},{-142,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(position1.support, fixed4.flange) annotation (Line(
        points={{-130,-50},{-130,-56}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia10.flange_b, gear2_2.flange_a) annotation (Line(
        points={{22,170},{30,170}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(gear2_2.flange_b, inertia11.flange_a) annotation (Line(
        points={{50,170},{60,170}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed3.flange, gear2_2.support) annotation (Line(
        points={{40,154},{40,160}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position2.flange, inertia14.flange_a) annotation (Line(
        points={{0,-10},{10,-10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position3.flange, inertia15.flange_a) annotation (Line(
        points={{0,-40},{10,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position3.support, fixed5.flange) annotation (Line(
        points={{-10,-50},{-10,-56}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine2.y, position2.w_ref) annotation (Line(
        points={{-39,-10},{-22,-10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine2.y, position3.w_ref) annotation (Line(
        points={{-39,-10},{-30,-10},{-30,-40},{-22,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(position4.flange, inertia16.flange_a) annotation (Line(
        points={{120,-10},{130,-10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position5.flange, inertia17.flange_a) annotation (Line(
        points={{120,-40},{130,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position5.support, fixed6.flange) annotation (Line(
        points={{110,-50},{110,-56}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine3.y, position4.a_ref) annotation (Line(
        points={{81,-10},{98,-10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine3.y, position5.a_ref) annotation (Line(
        points={{81,-10},{90,-10},{90,-40},{98,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(position6.flange, inertia18.flange_a) annotation (Line(
        points={{-120,-100},{-110,-100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position7.flange, inertia19.flange_a) annotation (Line(
        points={{-120,-130},{-110,-130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position7.support, fixed8.flange) annotation (Line(
        points={{-130,-140},{-130,-148}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine4.y, position6.u) annotation (Line(
        points={{-159,-100},{-142,-100}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine4.y, position7.u) annotation (Line(
        points={{-159,-100},{-152,-100},{-152,-130},{-142,-130}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine5.y, torque.tau) annotation (Line(
        points={{-37,-100},{-22,-100}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(torque.flange, inertia20.flange_a) annotation (Line(
        points={{0,-100},{20,-100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(linearSpeedDependentTorque.flange, inertia20.flange_a) annotation (
        Line(
        points={{0,-134},{10,-134},{10,-100},{20,-100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(quadraticSpeedDependentTorque.flange, inertia20.flange_a)
      annotation (Line(
        points={{0,-170},{10,-170},{10,-100},{20,-100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(constantTorque.flange, inertia20.flange_a) annotation (Line(
        points={{20,-134},{10,-134},{10,-100},{20,-100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torqueStep.flange, inertia20.flange_a) annotation (Line(
        points={{20,-170},{10,-170},{10,-100},{20,-100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine6.y, torque1.tau) annotation (Line(
        points={{81,-100},{98,-100}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(torque1.flange, inertia21.flange_a) annotation (Line(
        points={{120,-100},{140,-100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(linearSpeedDependentTorque1.flange, inertia21.flange_a) annotation (
       Line(
        points={{120,-134},{130,-134},{130,-100},{140,-100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(quadraticSpeedDependentTorque1.flange, inertia21.flange_a)
      annotation (Line(
        points={{120,-170},{130,-170},{130,-100},{140,-100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(constantTorque1.flange, inertia21.flange_a) annotation (Line(
        points={{140,-134},{130,-134},{130,-100},{140,-100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torqueStep1.flange, inertia21.flange_a) annotation (Line(
        points={{140,-170},{130,-170},{130,-100},{140,-100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torqueStep1.support, fixed7.flange) annotation (Line(
        points={{150,-180},{140,-180},{140,-190}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(constantTorque1.support, fixed7.flange) annotation (Line(
        points={{150,-144},{170,-144},{170,-180},{140,-180},{140,-190}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(quadraticSpeedDependentTorque1.support, fixed7.flange) annotation (
        Line(
        points={{110,-180},{140,-180},{140,-190}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(linearSpeedDependentTorque1.support, fixed7.flange) annotation (
        Line(
        points={{110,-144},{90,-144},{90,-180},{140,-180},{140,-190}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque1.support, fixed7.flange) annotation (Line(
        points={{110,-110},{110,-110},{90,-110},{90,-180},{140,-180},{140,-190}},
        color={0,0,0},
        smooth=Smooth.None));

    connect(inertia22.flange_b, idealGearR2T.flangeR) annotation (Line(
        points={{120,170},{130,170}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGearR2T.flangeT, slidingMass.flange_a) annotation (Line(
        points={{150,170},{160,170}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(inertia23.flange_b, idealGearR2T1.flangeR) annotation (Line(
        points={{120,120},{130,120}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGearR2T1.flangeT, slidingMass1.flange_a) annotation (Line(
        points={{150,120},{160,120}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(idealGearR2T1.supportR, fixed9.flange) annotation (Line(
        points={{130,110},{130,102}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed10.flange, idealGearR2T1.supportT) annotation (Line(
        points={{152,102},{152,110},{150,110}},
        color={0,127,0},
        smooth=Smooth.None));
    annotation (experiment(StopTime=0.5), Diagram(coordinateSystem(
            preserveAspectRatio=true, extent={{-200,-200},{200,200}})));
  end TestBearingConversion;

  model TestFriction "Test friction elements"
    extends Modelica.Icons.Example;

    Modelica.Mechanics.Rotational.Components.Inertia inertia(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10,
              80},{10,100}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
        useSupport=false) annotation (Placement(transformation(extent={{20,80},
              {40,100}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=false)
      annotation (Placement(transformation(extent={{-40,80},{-20,100}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine(amplitude=10, freqHz=1) annotation (
        Placement(transformation(extent={{-80,80},{-60,100}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(
      J=1,
      phi(fixed=true, start=0),
      w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10,
              20},{10,40}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=false)
      annotation (Placement(transformation(extent={{-40,20},{-20,40}}, rotation=
             0)));
    Modelica.Blocks.Sources.Sine sine1(amplitude=10, freqHz=1) annotation (
        Placement(transformation(extent={{-80,20},{-60,40}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Brake brake(useSupport=false,
        fn_max=1) annotation (Placement(transformation(extent={{20,20},{40,40}},
            rotation=0)));
    Modelica.Blocks.Sources.Step step(height=100, startTime=0.5) annotation (
        Placement(transformation(extent={{-10,50},{10,70}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2(
      J=1,
      phi(start=0, fixed=true),
      w(start=0, fixed=true)) annotation (Placement(transformation(extent={{-10,
              -40},{10,-20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=false)
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine2(amplitude=10, freqHz=1) annotation (
        Placement(transformation(extent={{-80,-40},{-60,-20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Clutch clutch(
      fn_max=1,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{20,-40},
              {40,-20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia3(J=1) annotation (
        Placement(transformation(extent={{50,-40},{70,-20}}, rotation=0)));
    Modelica.Blocks.Sources.Step step1(height=100, startTime=0.5) annotation (
        Placement(transformation(extent={{-12,-10},{8,10}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia4(
      J=1,
      phi(start=0, fixed=true),
      w(start=0, fixed=true)) annotation (Placement(transformation(extent={{-8,
              -100},{12,-80}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque3(useSupport=false)
      annotation (Placement(transformation(extent={{-38,-100},{-18,-80}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine3(amplitude=10, freqHz=1) annotation (
        Placement(transformation(extent={{-78,-100},{-58,-80}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia5(J=1) annotation (
        Placement(transformation(extent={{50,-100},{70,-80}}, rotation=0)));
    Modelica.Blocks.Sources.Step step2(height=100, startTime=0.5) annotation (
        Placement(transformation(extent={{-10,-70},{10,-50}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.OneWayClutch oneWayClutch(
      fn_max=1,
      phi_rel(fixed=true),
      w_rel(fixed=true),
      startForward(fixed=true),
      stuck(fixed=true)) annotation (Placement(transformation(extent={{40,-100},
              {20,-80}}, rotation=0)));
  equation
    connect(inertia.flange_b, bearingFriction.flange_a) annotation (Line(
        points={{10,90},{20,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque.flange, inertia.flange_a) annotation (Line(
        points={{-20,90},{-10,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine.y, torque.tau) annotation (Line(
        points={{-59,90},{-42,90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(torque1.flange, inertia1.flange_a) annotation (Line(
        points={{-20,30},{-10,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine1.y, torque1.tau) annotation (Line(
        points={{-59,30},{-42,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertia1.flange_b, brake.flange_a) annotation (Line(
        points={{10,30},{20,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(step.y, brake.f_normalized) annotation (Line(
        points={{11,60},{30,60},{30,41}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(torque2.flange, inertia2.flange_a) annotation (Line(
        points={{-20,-30},{-10,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine2.y, torque2.tau) annotation (Line(
        points={{-59,-30},{-42,-30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertia2.flange_b, clutch.flange_a) annotation (Line(
        points={{10,-30},{20,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(clutch.flange_b, inertia3.flange_a) annotation (Line(
        points={{40,-30},{50,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(step1.y, clutch.f_normalized) annotation (Line(
        points={{9,0},{30,0},{30,-19}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(torque3.flange, inertia4.flange_a) annotation (Line(
        points={{-18,-90},{-8,-90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine3.y, torque3.tau) annotation (Line(
        points={{-57,-90},{-40,-90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(step2.y, oneWayClutch.f_normalized) annotation (Line(
        points={{11,-60},{30,-60},{30,-79}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(oneWayClutch.flange_b, inertia4.flange_b) annotation (Line(
        points={{20,-90},{12,-90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(oneWayClutch.flange_a, inertia5.flange_a) annotation (Line(
        points={{40,-90},{50,-90}},
        color={0,0,0},
        smooth=Smooth.None));
    annotation (experiment(StopTime=1.1));
  end TestFriction;
end Rotational;
