within ModelicaTest;
package Rotational "Test models for Modelica.Mechanics.Rotational"
extends Modelica.Icons.ExamplesPackage;

  package ForUsersGuide "Models used as screenshot for the users guide"
  extends Modelica.Icons.ExamplesPackage;

  model SimpleDriveTrain

    Modelica.Blocks.Sources.Sine sine annotation (Placement(transformation(
              extent={{-80,0},{-60,20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=true)
      annotation (Placement(transformation(extent={{-44,0},{-24,20}}, rotation=
                0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed
      annotation (Placement(transformation(extent={{-44,-20},{-24,0}}, rotation=
               0)));
    Modelica.Mechanics.Rotational.Components.Inertia J1(
                                             J=0.2)
      annotation (Placement(transformation(extent={{-10,0},{10,20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.IdealGear gear(
                                                 ratio=5, useSupport=true)
      annotation (Placement(transformation(extent={{20,0},{40,20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia J2(
                                             J=5)
      annotation (Placement(transformation(extent={{52,0},{72,20}}, rotation=0)));
  equation
    connect(sine.y, torque.tau) annotation (Line(
          points={{-59,10},{-46,10}},
          color={0,0,127},
          smooth=Smooth.None));
    connect(torque.support,fixed.flange)    annotation (Line(
          points={{-34,0},{-34,-10}},
          color={0,0,0},
          smooth=Smooth.None));
    connect(torque.flange,   J1.flange_a) annotation (Line(
          points={{-24,10},{-10,10}},
          color={0,0,0},
          smooth=Smooth.None));
    connect(gear.flange_b, J2.flange_a) annotation (Line(
          points={{40,10},{52,10}},
          color={0,0,0},
          smooth=Smooth.None));
    connect(fixed.flange,gear.support)    annotation (Line(
          points={{-34,-10},{30,-10},{30,0}},
          color={0,0,0},
          smooth=Smooth.None));
    connect(J1.flange_b, gear.flange_a) annotation (Line(
          points={{10,10},{20,10}},
          color={0,0,0},
          smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                         experiment(StopTime=1.1));
  end SimpleDriveTrain;

    model ConnectionPossibilities

      Modelica.Mechanics.Rotational.Components.Inertia inertia1
        annotation (Placement(transformation(extent={{-60,40},{-40,60}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2
        annotation (Placement(transformation(extent={{-20,40},{0,60}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia3
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia4
        annotation (Placement(transformation(extent={{30,-20},{50,0}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Components.Spring spring1(
                                                   c=1e4)
        annotation (Placement(transformation(extent={{-30,-20},{-10,0}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Spring spring2(
                                                   c=1e4)
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
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
        experiment(StopTime=2),
        experimentSetupOutput,
                  Diagram, experiment(StopTime=1.1));
    end ConnectionPossibilities;

    model SupportTorque1

      Modelica.Blocks.Sources.Sine sine2
                                        annotation (Placement(transformation(
              extent={{-80,0},{-60,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=true)
        annotation (Placement(transformation(extent={{-44,0},{-24,20}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed1
        annotation (Placement(transformation(extent={{-44,-20},{-24,0}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia3(
                                                     J=1)
        annotation (Placement(transformation(extent={{-14,0},{6,20}}, rotation=
                0)));
      Modelica.Mechanics.Rotational.Components.IdealGear idealGear2(
                                                         ratio=1, useSupport=
            true)
        annotation (Placement(transformation(extent={{16,0},{36,20}}, rotation=
                0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia4(
                                                     J=1)
        annotation (Placement(transformation(extent={{74,0},{94,20}}, rotation=
                0)));
      Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction1(
         useSupport=true)
        annotation (Placement(transformation(extent={{46,0},{66,20}}, rotation=
                0)));
    equation
      connect(sine2.y, torque2.tau)
                                  annotation (Line(
          points={{-59,10},{-46,10}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(torque2.support,fixed1.flange)  annotation (Line(
          points={{-34,0},{-34,-10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(torque2.flange,   inertia3.flange_a)
                                            annotation (Line(
          points={{-24,10},{-14,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed1.flange,idealGear2.support)
                                            annotation (Line(
          points={{-34,-10},{26,-10},{26,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia3.flange_b, idealGear2.flange_a)
                                          annotation (Line(
          points={{6,10},{16,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(idealGear2.flange_b, bearingFriction1.flange_a) annotation (Line(
          points={{36,10},{46,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(bearingFriction1.flange_b, inertia4.flange_a) annotation (Line(
          points={{66,10},{74,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed1.flange,bearingFriction1.support)    annotation (Line(
          points={{-34,-10},{56,-10},{56,0}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
                           experiment(StopTime=1.1),
                  Diagram,
        experiment(StopTime=2),
        experimentSetupOutput);
    end SupportTorque1;

    model Directions

      Modelica.Blocks.Sources.Sine sine annotation (Placement(transformation(
              extent={{-80,60},{-60,80}}, rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=true)
        annotation (Placement(transformation(extent={{-44,60},{-24,80}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J1(
                                               J=0.2)
        annotation (Placement(transformation(extent={{-10,60},{10,80}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.IdealGear gear(
                                                   ratio=5, useSupport=true)
        annotation (Placement(transformation(extent={{20,60},{40,80}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Components.Inertia J2(
                                               J=5)
        annotation (Placement(transformation(extent={{52,60},{72,80}}, rotation=
               0)));
      Modelica.Blocks.Sources.Sine sine1
                                        annotation (Placement(transformation(
              extent={{-80,10},{-60,30}}, rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=true)
        annotation (Placement(transformation(extent={{-44,10},{-24,30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J3(
                                               J=0.2)
        annotation (Placement(transformation(extent={{-10,10},{10,30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.IdealGear gear1(
                                                    ratio=1/5, useSupport=true)
        annotation (Placement(transformation(extent={{40,10},{20,30}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Components.Inertia J4(
                                               J=5)
        annotation (Placement(transformation(extent={{52,10},{72,30}}, rotation=
               0)));
      Modelica.Blocks.Sources.Sine sine2
                                        annotation (Placement(transformation(
              extent={{-80,-50},{-60,-30}}, rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=true)
        annotation (Placement(transformation(extent={{-44,-50},{-24,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J5(
                                               J=0.2)
        annotation (Placement(transformation(extent={{-10,-50},{10,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.IdealGear gear2(
                                                    ratio=1/5, useSupport=true)
        annotation (Placement(transformation(extent={{40,-50},{20,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J6(
                                               J=5)
        annotation (Placement(transformation(extent={{72,-50},{52,-30}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed1
        annotation (Placement(transformation(extent={{-10,42},{10,62}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed2
        annotation (Placement(transformation(extent={{-10,-6},{10,14}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed3
        annotation (Placement(transformation(extent={{-10,-66},{10,-46}},
              rotation=0)));
    equation
      connect(sine.y,torque. tau) annotation (Line(
          points={{-59,70},{-46,70}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(torque.flange,  J1. flange_a) annotation (Line(
          points={{-24,70},{-10,70}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(gear.flange_b,J2. flange_a) annotation (Line(
          points={{40,70},{52,70}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(J1.flange_b,gear. flange_a) annotation (Line(
          points={{10,70},{20,70}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(sine1.y, torque1.tau)
                                  annotation (Line(
          points={{-59,20},{-46,20}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(torque1.flange,   J3.flange_a)
                                            annotation (Line(
          points={{-24,20},{-10,20}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(J3.flange_b, gear1.flange_b) annotation (Line(
          points={{10,20},{20,20}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(gear1.flange_a, J4.flange_a) annotation (Line(
          points={{40,20},{52,20}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(sine2.y, torque2.tau)
                                  annotation (Line(
          points={{-59,-40},{-46,-40}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(torque2.flange,   J5.flange_a)
                                            annotation (Line(
          points={{-24,-40},{-10,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(J5.flange_b, gear2.flange_b) annotation (Line(
          points={{10,-40},{20,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(gear2.flange_a, J6.flange_b) annotation (Line(
          points={{40,-40},{52,-40}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(torque.support,fixed1.flange)    annotation (Line(
          points={{-34,60},{-34,52},{0,52}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed1.flange,gear.support)    annotation (Line(
          points={{0,52},{30,52},{30,60}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(torque1.support,fixed2.flange)    annotation (Line(
          points={{-34,10},{-34,4},{0,4}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed2.flange,gear1.support)    annotation (Line(
          points={{0,4},{30,4},{30,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(torque2.support,fixed3.flange)    annotation (Line(
          points={{-34,-50},{-34,-56},{0,-56}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed3.flange,gear2.support)    annotation (Line(
          points={{0,-56},{30,-56},{30,-50}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics={
            Polygon(
              points={{-23,97},{-13,94},{-23,91},{-23,97}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{-23,94},{-53,94}}, color={0,0,0}),
            Text(
              extent={{-18,98},{72,90}},
              lineColor={0,0,0},
              textString=
                   "(positive) axis of rotation")}),
        experiment(StopTime=2),
        experimentSetupOutput);
    end Directions;

    model Directions2

      Modelica.Mechanics.Rotational.Components.Inertia J2(
                                               J=5)
        annotation (Placement(transformation(extent={{-60,55},{-40,75}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J4(
                                               J=5)
        annotation (Placement(transformation(extent={{-8,55},{12,75}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Components.Inertia J6(
                                               J=5)
        annotation (Placement(transformation(extent={{65,55},{45,75}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia1
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=true)
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}},
              rotation=0)));
      Modelica.Blocks.Sources.Sine sine1
                                        annotation (Placement(transformation(
              extent={{-90,-10},{-70,10}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2
        annotation (Placement(transformation(extent={{10,-10},{30,10}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=true)
        annotation (Placement(transformation(extent={{60,-10},{40,10}},
              rotation=0)));
      Modelica.Blocks.Sources.Sine sine2
                                        annotation (Placement(transformation(
              extent={{90,-10},{70,10}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia3
        annotation (Placement(transformation(extent={{-80,-100},{-60,-80}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia4
        annotation (Placement(transformation(extent={{-6,-64},{-26,-44}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.IdealPlanetary idealPlanetary1
        annotation (Placement(transformation(extent={{-50,-100},{-30,-80}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.IdealPlanetary idealPlanetary2
        annotation (Placement(transformation(extent={{60,-100},{80,-80}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia5
        annotation (Placement(transformation(extent={{0,-100},{20,-80}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia6
        annotation (Placement(transformation(
            origin={40,-50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed1
        annotation (Placement(transformation(extent={{-60,-27},{-40,-7}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed2
        annotation (Placement(transformation(extent={{40,-24},{60,-4}},
              rotation=0)));
    equation
      connect(torque1.flange,   inertia1.flange_a) annotation (Line(
          points={{-40,0},{-30,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(sine1.y, torque1.tau) annotation (Line(
          points={{-69,0},{-62,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(torque2.flange,   inertia2.flange_b) annotation (Line(
          points={{40,0},{30,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(sine2.y, torque2.tau) annotation (Line(
          points={{69,0},{62,0}},
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
      connect(torque1.support,fixed1.flange)    annotation (Line(
          points={{-50,-10},{-50,-17}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed2.flange,torque2.support)    annotation (Line(
          points={{50,-14},{50,-10}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Text(
              extent={{-28,94},{62,86}},
              lineColor={0,0,0},
              textString=
                   "(positive) axis of rotation"),
            Line(points={{-61,65},{-80,65}}, color={0,0,0}),
            Polygon(
              points={{-68,67},{-61,65},{-68,63},{-68,67}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-57,69},{-91,73}},
              lineColor={0,0,0},
              textString=
                   "J2.flange_a.tau"),
            Line(points={{-42,45},{-61,45}}, color={0,0,0}),
            Polygon(
              points={{-49,47},{-42,45},{-49,43},{-49,47}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-33,38},{-67,42}},
              lineColor={0,0,0},
              textString=
                   "J2.w"),
            Line(points={{-9,65},{-28,65}}, color={0,0,0}),
            Polygon(
              points={{-16,67},{-9,65},{-16,63},{-16,67}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-5,69},{-39,73}},
              lineColor={0,0,0},
              textString=
                   "J4.flange_a.tau"),
            Line(points={{10,45},{-9,45}}, color={0,0,0}),
            Polygon(
              points={{3,47},{10,45},{3,43},{3,47}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{19,38},{-15,42}},
              lineColor={0,0,0},
              textString=
                   "J4.w"),
            Line(points={{44,65},{25,65}}, color={0,0,0}),
            Polygon(
              points={{37,67},{44,65},{37,63},{37,67}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{48,69},{14,73}},
              lineColor={0,0,0},
              textString=
                   "J6.flange_b.tau"),
            Line(points={{63,45},{44,45}}, color={0,0,0}),
            Polygon(
              points={{56,47},{63,45},{56,43},{56,47}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{72,38},{38,42}},
              lineColor={0,0,0},
              textString=
                   "J6.w"),
            Line(points={{-32,90},{-62,90}}, color={0,0,0}),
            Polygon(
              points={{-32,93},{-22,90},{-32,87},{-32,93}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-19,24},{71,16}},
              lineColor={0,0,0},
              textString=
                   "(positive) axis of rotation"),
            Line(points={{-23,20},{-53,20}}, color={0,0,0}),
            Polygon(
              points={{-23,23},{-13,20},{-23,17},{-23,23}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-47,-47},{-54,-49},{-47,-51},{-47,-47}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{-52,-49},{-33,-49}}, color={0,0,0}),
            Line(points={{31.5,-79.5},{31.5,-60.5}}, color={0,0,0}),
            Polygon(
              points={{29.5,-75.5},{31.5,-82.5},{33.5,-75.5},{29.5,-75.5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}),
        experiment(StopTime=2));
    end Directions2;

    model Directions3

      Modelica.Mechanics.Rotational.Components.Inertia J1(
                                               J=1)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J2(
                                               J=1)
        annotation (Placement(transformation(extent={{-20,40},{-40,60}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia J3(
                                               J=1)
        annotation (Placement(transformation(extent={{20,40},{40,60}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Components.Inertia J4(
                                               J=1)
        annotation (Placement(transformation(extent={{60,40},{80,60}}, rotation=
               0)));
    equation
      connect(J1.flange_b, J2.flange_b) annotation (Line(
          points={{-60,50},{-40,50}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(J3.flange_b, J4.flange_b) annotation (Line(
          points={{40,50},{50,50},{50,34},{86,34},{86,50},{80,50}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics={
            Line(points={{-60,33},{-79,33}}, color={0,0,0}),
            Polygon(
              points={{-67,35},{-60,33},{-67,31},{-67,35}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-32,35},{-39,33},{-32,31},{-32,35}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{-16,33},{-35,33}}, color={0,0,0}),
            Text(
              extent={{-10,60},{14,40}},
              lineColor={0,0,0},
              textString=
                   "="),
            Line(points={{40,33},{21,33}}, color={0,0,0}),
            Polygon(
              points={{33,35},{40,33},{33,31},{33,35}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{80,27},{61,27}}, color={0,0,0}),
            Polygon(
              points={{73,29},{80,27},{73,25},{73,29}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}),
        experiment(StopTime=2));
    end Directions3;
  end ForUsersGuide;

  package InitializationConversion
  extends Modelica.Icons.ExamplesPackage;
    model Inertia

      Modelica.Mechanics.Rotational.Components.Inertia inertia1(phi(start=
              0.0174532925199433), w(start=2))
                                annotation (Placement(transformation(extent={{
                -86,40},{-66,60}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2(
        stateSelect=StateSelect.default,
        a(fixed=true),
        phi(fixed=false, start=0.0174532925199433),
        w(fixed=true, start=2))
        annotation (Placement(transformation(extent={{0,40},{20,60}}, rotation=
                0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia3(
          stateSelect=StateSelect.prefer,
        a(fixed=false),
        phi(fixed=true),
        w(fixed=true))
        annotation (Placement(transformation(extent={{40,40},{60,60}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia4(
        stateSelect=StateSelect.always,
        a(fixed=false),
        phi(fixed=true, start=-0.0174532925199433),
        w(fixed=false, start=-2))
        annotation (Placement(transformation(extent={{80,40},{100,60}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia5(
        stateSelect=StateSelect.avoid,
        a(fixed=false),
        phi(fixed=false, start=0.3839724354387525),
        w(fixed=true, start=33))
        annotation (Placement(transformation(extent={{-86,0},{-66,20}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia6(
        a(fixed=true, start=44),
        phi(fixed=false),
        w(fixed=false))
                      annotation (Placement(transformation(extent={{-14,0},{6,
                20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia7(
        a(fixed=true, start=3),
        phi(fixed=true, start=0.0174532925199433),
        w(fixed=false, start=2))
                   annotation (Placement(transformation(extent={{22,0},{42,20}},
              rotation=0)));

      Modelica.Mechanics.Rotational.Components.Inertia inertia8(
        a(fixed=true),
        phi(fixed=false),
        w(fixed=true))
        annotation (Placement(transformation(extent={{-84,-40},{-64,-20}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia9(
        a(fixed=true, start=33),
        phi(fixed=true, start=0.1919862177193762),
        w(fixed=true, start=22))
                    annotation (Placement(transformation(extent={{20,-40},{40,
                -20}}, rotation=0)));

      Modelica.Mechanics.Rotational.Components.Spring spring(
                                                  c=10000)
        annotation (Placement(transformation(extent={{-28,40},{-8,60}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed
                                                annotation (Placement(
            transformation(extent={{-50,40},{-30,60}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Spring spring1(
                                                   c=10000)
        annotation (Placement(transformation(extent={{50,0},{70,20}}, rotation=
                0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia7a(
        a(start=3),
        phi(start=0.0174532925199433),
        w(start=2))                   annotation (Placement(transformation(
              extent={{80,0},{100,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Spring spring2(
                                                   c=10000)
        annotation (Placement(transformation(extent={{-40,0},{-20,20}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed1
                                                 annotation (Placement(
            transformation(extent={{-60,0},{-40,20}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Spring spring3(
                                                   c=10000)
        annotation (Placement(transformation(extent={{-52,-40},{-32,-20}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia8a
        annotation (Placement(transformation(extent={{-26,-40},{-6,-20}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Spring spring4(
                                                   c=10000)
        annotation (Placement(transformation(extent={{52,-40},{72,-20}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia9a(
        a(start=33),
        phi(start=0.1919862177193762),
        w(start=22))                  annotation (Placement(transformation(
              extent={{80,-40},{100,-20}}, rotation=0)));
    equation
      connect(spring.flange_b, inertia2.flange_a) annotation (Line(
          points={{-8,50},{0,50}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed.flange,   spring.flange_a) annotation (Line(
          points={{-40,50},{-28,50}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia7.flange_b, spring1.flange_a) annotation (Line(
          points={{42,10},{50,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring1.flange_b, inertia7a.flange_a) annotation (Line(
          points={{70,10},{80,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring2.flange_b, inertia6.flange_a) annotation (Line(
          points={{-20,10},{-14,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed1.flange,   spring2.flange_a) annotation (Line(
          points={{-50,10},{-40,10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia8.flange_b, spring3.flange_a) annotation (Line(
          points={{-64,-30},{-52,-30}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring3.flange_b, inertia8a.flange_a) annotation (Line(
          points={{-32,-30},{-26,-30}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia9.flange_b, spring4.flange_a) annotation (Line(
          points={{40,-30},{52,-30}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring4.flange_b, inertia9a.flange_a) annotation (Line(
          points={{72,-30},{80,-30}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
        experiment(StopTime=1.1));
    end Inertia;

    model SpringDamper

      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper1(
        c=1e4,
        d=10,
        phi_rel(start=1),
        w_rel(start=2))
                       annotation (Placement(transformation(extent={{-70,60},{
                -50,80}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed
        annotation (Placement(transformation(extent={{-100,60},{-80,80}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia1
        annotation (Placement(transformation(extent={{-40,60},{-20,80}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2
        annotation (Placement(transformation(extent={{-40,20},{-20,40}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper2(
        c=1e4,
        d=10,
        stateSelect=StateSelect.prefer,
        a_rel(fixed=true),
        phi_rel(fixed=false, start=-1),
        w_rel(fixed=true, start=-2))
        annotation (Placement(transformation(extent={{-70,20},{-50,40}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper3(
        c=1e4,
        d=10,
        stateSelect=StateSelect.always,
        a_rel(fixed=false),
        phi_rel(fixed=true, start=1),
        w_rel(fixed=true, start=2))
        annotation (Placement(transformation(extent={{-70,-20},{-50,0}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia3
        annotation (Placement(transformation(extent={{-40,-20},{-20,0}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper4(
        c=1e4,
        d=10,
        stateSelect=StateSelect.avoid,
        a_rel(fixed=false),
        phi_rel(fixed=true),
        w_rel(fixed=false))
        annotation (Placement(transformation(extent={{-70,-60},{-50,-40}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia4
        annotation (Placement(transformation(extent={{-40,-60},{-20,-40}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper5(
        c=1e4,
        d=10,
        stateSelect=StateSelect.never,
        a_rel(fixed=false),
        phi_rel(fixed=false),
        w_rel(fixed=true, start=3))
        annotation (Placement(transformation(extent={{-70,-100},{-50,-80}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia5
        annotation (Placement(transformation(extent={{-40,-100},{-20,-80}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia6
        annotation (Placement(transformation(extent={{20,40},{40,60}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Components.Spring spring(
                                                  c=1e4)
        annotation (Placement(transformation(extent={{48,40},{68,60}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia7
        annotation (Placement(transformation(extent={{74,40},{94,60}}, rotation=
               0)));
      Modelica.Mechanics.Rotational.Components.RelativeStates relativeStates
        annotation (Placement(transformation(extent={{48,20},{68,40}}, rotation=
               0)));
    equation
      connect(springDamper1.flange_a,fixed.flange)    annotation (Line(
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
      connect(springDamper2.flange_a,fixed.flange)    annotation (Line(
          points={{-70,30},{-80,30},{-80,70},{-90,70}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia3.flange_a, springDamper3.flange_b) annotation (Line(
          points={{-40,-10},{-50,-10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(springDamper3.flange_a,fixed.flange)    annotation (Line(
          points={{-70,-10},{-80,-10},{-80,70},{-90,70}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia4.flange_a, springDamper4.flange_b) annotation (Line(
          points={{-40,-50},{-50,-50}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(springDamper4.flange_a,fixed.flange)    annotation (Line(
          points={{-70,-50},{-80,-50},{-80,70},{-90,70}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia5.flange_a, springDamper5.flange_b) annotation (Line(
          points={{-40,-90},{-50,-90}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(springDamper5.flange_a,fixed.flange)    annotation (Line(
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
          points={{48,50},{48,30},{48,30}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics),
        experiment(StopTime=1.1));
    end SpringDamper;

  end InitializationConversion;

  model TestSpeed

    Modelica.Mechanics.Rotational.Sources.Speed speed1(
                                               f_crit=5, useSupport=false)
      annotation (Placement(transformation(extent={{-20,60},{0,80}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1
      annotation (Placement(transformation(extent={{20,60},{40,80}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Speed speed2(
      f_crit=5,
      exact=true,
      useSupport=false)
                  annotation (Placement(transformation(extent={{-20,20},{0,40}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2
      annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine2 annotation (Placement(transformation(
            extent={{-60,20},{-40,40}}, rotation=0)));
    Modelica.Blocks.Sources.Step step(startTime=0.5)
      annotation (Placement(transformation(extent={{-60,60},{-40,80}}, rotation=
             0)));
    Modelica.Mechanics.Translational.Sources.Speed speed3(   f_crit=5, s(start=
            1))
      annotation (Placement(transformation(extent={{-20,-20},{0,0}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass mass1(
                                                       m=2)
      annotation (Placement(transformation(extent={{20,-20},{40,0}}, rotation=0)));
    Modelica.Blocks.Sources.Step step1(startTime=0.5)
      annotation (Placement(transformation(extent={{-60,-20},{-40,0}}, rotation=
             0)));
    Modelica.Mechanics.Translational.Sources.Speed speed4(   exact=true, s(start=
            1))
      annotation (Placement(transformation(extent={{-20,-60},{0,-40}}, rotation=
             0)));
    Modelica.Mechanics.Translational.Components.Mass mass2(
                                                       m=2)
      annotation (Placement(transformation(extent={{20,-60},{40,-40}}, rotation=
             0)));
    Modelica.Blocks.Sources.Sine sine4 annotation (Placement(transformation(
            extent={{-60,-60},{-40,-40}}, rotation=0)));
  equation
    connect(speed1.flange,   inertia1.flange_a)
      annotation (Line(points={{0,70},{20,70}}, color={0,0,0}));
    connect(speed2.flange,   inertia2.flange_a)
      annotation (Line(points={{0,30},{20,30}}, color={0,0,0}));
    connect(sine2.y, speed2.w_ref) annotation (Line(points={{-39,30},{-22,30}},
          color={0,0,127}));
    connect(step.y, speed1.w_ref) annotation (Line(points={{-39,70},{-22,70}},
          color={0,0,127}));
    connect(speed3.flange,   mass1.flange_a)
      annotation (Line(points={{0,-10},{20,-10}}, color={0,127,0}));
    connect(step1.y, speed3.v_ref) annotation (Line(points={{-39,-10},{-22,-10}},
          color={0,0,127}));
    connect(speed4.flange,   mass2.flange_a)
      annotation (Line(points={{0,-50},{20,-50}}, color={0,127,0}));
    connect(sine4.y, speed4.v_ref) annotation (Line(points={{-39,-50},{-22,-50}},
          color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics),
      experiment(StopTime=1.1));
  end TestSpeed;

  model TestMove

    Modelica.Mechanics.MultiBody.Parts.Body Body1(I_33=2)
      annotation (Placement(transformation(extent={{66,36},{86,56}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Joints.Revolute ActuatedRevolute1(
        useAxisFlange=true)
      annotation (Placement(transformation(extent={{32,0},{52,20}}, rotation=0)));
    inner Modelica.Mechanics.MultiBody.World world(g=0)
      annotation (Placement(transformation(extent={{0,0},{20,20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Move move(useSupport=false)
                                             annotation (Placement(
          transformation(extent={{20,40},{40,60}}, rotation=0)));
    Modelica.Blocks.Routing.Multiplex3 Multiplex3_1
      annotation (Placement(transformation(extent={{-56,40},{-36,60}}, rotation=
             0)));
    Modelica.Blocks.Sources.Constant Constant1
      annotation (Placement(transformation(extent={{-100,16},{-80,36}},
            rotation=0)));
    Modelica.Blocks.Sources.Constant Constant2(k=0)
      annotation (Placement(transformation(extent={{-100,70},{-80,90}},
            rotation=0)));
    Modelica.Mechanics.Translational.Sources.Move move1
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}}, rotation=
             0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass(
                                                             m=2)
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
    connect(move.flange,   ActuatedRevolute1.axis)  annotation (Line(points={{
            40,50},{42,50},{42,20}}, color={0,0,0}));
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
    connect(move1.flange,   slidingMass.flange_a)
      annotation (Line(points={{0,-30},{20,-30}}, color={0,127,0}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics),
      experiment(StopTime=1.1));
  end TestMove;

  model AllComponents

    Modelica.Mechanics.Rotational.Components.Inertia inertia(
                                                  J=3)
      annotation (Placement(transformation(extent={{-60,40},{-40,60}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.IdealGear idealGear(
                                                      ratio=3, useSupport=true)
      annotation (Placement(transformation(extent={{-30,40},{-10,60}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.IdealPlanetary idealPlanetary(
                                                                ratio=3)
      annotation (Placement(transformation(extent={{4,40},{24,60}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed
      annotation (Placement(transformation(extent={{-30,10},{-10,30}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(
                                                   J=2)
      annotation (Placement(transformation(extent={{-30,80},{-10,100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2(
                                                   J=4)
      annotation (Placement(transformation(extent={{60,40},{80,60}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Spring spring(
                                                c=1e4)
      annotation (Placement(transformation(extent={{32,40},{52,60}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Damper damper(
                                                d=10)
      annotation (Placement(transformation(extent={{32,58},{52,78}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.SpringDamper springDamper(
                                                            c=1e4, d=10,
      phi_rel0=1.74532925199433e-005)
      annotation (Placement(transformation(extent={{-58,80},{-38,100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia3(
      J=2,
      phi(start=0.0174532925199433),
      w(start=2))
      annotation (Placement(transformation(extent={{-92,80},{-72,100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.ElastoBacklash elastoBacklash(
      b=1.74532925199433e-007,
      c=1e4,
      d=20) annotation (Placement(transformation(extent={{10,80},{30,100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia4(
                                                   J=2)
      annotation (Placement(transformation(extent={{40,80},{60,100}}, rotation=
              0)));
    Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
                                                                  tau_pos=[0,2],
        peak=1.1,
      useSupport=true)
                  annotation (Placement(transformation(extent={{64,80},{84,100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Clutch clutch(
      mue_pos=[0,1],
      peak=1.1,
      cgeo=1.2,
      fn_max=1.3) annotation (Placement(transformation(extent={{-86,60},{-66,40}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia5(
                                                   J=3)
      annotation (Placement(transformation(extent={{-116,40},{-96,60}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine annotation (Placement(transformation(
            extent={{-104,10},{-84,30}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Brake brake(useSupport=true)
      annotation (Placement(transformation(extent={{100,40},{120,60}}, rotation=
             0)));
    Modelica.Blocks.Sources.Sine sine1
      annotation (Placement(transformation(
          origin={110,90},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(useSupport=
          true)
      annotation (Placement(transformation(extent={{-120,80},{-100,100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia6(
      J=2,
      a(fixed=false),
      phi(fixed=true, start=0.0174532925199433),
      w(fixed=true, start=2))
      annotation (Placement(transformation(extent={{-150,80},{-130,100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Gearbox gear2_1(
      ratio=
        2,
      lossTable=[0,0.9,1,0,0],
      c=1e4,
      d=10,
      b=1.74532925199433e-007,
      useSupport=true)         annotation (Placement(transformation(extent={{
              -80,-40},{-60,-20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia7(
                                                   J=3)
      annotation (Placement(transformation(extent={{-110,-40},{-90,-20}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia8(
                                                   J=3)
      annotation (Placement(transformation(extent={{-48,-40},{-28,-20}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Position position(useSupport=true)
      annotation (Placement(transformation(extent={{48,-10},{68,10}}, rotation=
              0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed1
      annotation (Placement(transformation(extent={{-80,-60},{-60,-40}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed2
      annotation (Placement(transformation(extent={{48,-30},{68,-10}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia9(
                                                   J=3)
      annotation (Placement(transformation(extent={{80,-10},{100,10}}, rotation=
             0)));
    Modelica.Blocks.Sources.Sine sine2 annotation (Placement(transformation(
            extent={{18,-10},{38,10}}, rotation=0)));
    Modelica.Blocks.Sources.Sine sine3 annotation (Placement(transformation(
            extent={{20,-60},{40,-40}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia10(
                                                    J=3)
      annotation (Placement(transformation(extent={{80,-60},{100,-40}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed3
      annotation (Placement(transformation(extent={{50,-80},{70,-60}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Sources.Speed speed(useSupport=true)
      annotation (Placement(transformation(extent={{50,-60},{70,-40}}, rotation=
             0)));
    Modelica.Blocks.Sources.Sine sine4 annotation (Placement(transformation(
            extent={{20,-120},{40,-100}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia11(
                                                    J=3)
      annotation (Placement(transformation(extent={{80,-120},{100,-100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed4
      annotation (Placement(transformation(extent={{50,-140},{70,-120}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Accelerate accelerate(useSupport=true)
      annotation (Placement(transformation(extent={{50,-120},{70,-100}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine5[3](each amplitude=2)
      annotation (Placement(transformation(extent={{20,-180},{40,-160}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia12(
                                                    J=3)
      annotation (Placement(transformation(extent={{80,-180},{100,-160}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed5
      annotation (Placement(transformation(extent={{50,-200},{70,-180}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Move move(useSupport=true)
      annotation (Placement(transformation(extent={{50,-180},{70,-160}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=true)
      annotation (Placement(transformation(extent={{160,40},{140,60}}, rotation=
             0)));
    Modelica.Blocks.Sources.Sine sine6 annotation (Placement(transformation(
            extent={{192,40},{172,60}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque2 torque2_1
      annotation (Placement(transformation(extent={{112,-60},{132,-40}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia13(
                                                    J=3)
      annotation (Placement(transformation(extent={{140,-60},{160,-40}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine7 annotation (Placement(transformation(
            extent={{94,-34},{114,-14}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
      linearSpeedDependentTorque(tau_nominal=10, w_nominal=10,
      useSupport=true)
      annotation (Placement(transformation(extent={{-142,-40},{-122,-20}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque(tau_nominal=100, w_nominal=1,
      useSupport=true)
      annotation (Placement(transformation(extent={{6,-40},{-16,-20}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(
                                                                tau_constant=11,
        useSupport=true)
      annotation (Placement(transformation(extent={{-120,-100},{-100,-80}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia14(
                                                    J=3)
      annotation (Placement(transformation(extent={{-84,-120},{-64,-100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep(
      stepTorque=22,
      offsetTorque=11,
      startTime=1,
      useSupport=true)
                   annotation (Placement(transformation(extent={{-120,-140},{
              -100,-120}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed6
      annotation (Placement(transformation(extent={{-120,-162},{-100,-142}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
                                                              w_fixed=11,
        useSupport=true)
      annotation (Placement(transformation(extent={{-60,-140},{-40,-120}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia15(
                                                    J=3)
      annotation (Placement(transformation(extent={{-30,-140},{-10,-120}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.RelativeStates relativeStates
      annotation (Placement(transformation(extent={{-60,-80},{-40,-60}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
      annotation (Placement(transformation(extent={{118,-120},{138,-100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
      annotation (Placement(transformation(extent={{118,-96},{138,-76}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sensors.AccSensor accSensor
      annotation (Placement(transformation(extent={{118,-146},{138,-126}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sensors.RelAngleSensor relAngleSensor
      annotation (Placement(transformation(extent={{152,-20},{172,0}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Sensors.RelSpeedSensor relSpeedSensor
      annotation (Placement(transformation(extent={{166,-88},{186,-68}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sensors.RelAccSensor relAccSensor
      annotation (Placement(transformation(extent={{160,-130},{180,-110}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor
      annotation (Placement(transformation(extent={{-26,-170},{-6,-150}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
      annotation (Placement(transformation(extent={{-58,-170},{-38,-150}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia16(
                                                    J=3)
      annotation (Placement(transformation(extent={{-88,-170},{-68,-150}},
            rotation=0)));
  equation
    connect(inertia.flange_b, idealGear.flange_a) annotation (Line(
        points={{-40,50},{-30,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGear.flange_b, idealPlanetary.sun) annotation (Line(
        points={{-10,50},{4,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGear.support,fixed.flange)    annotation (Line(
        points={{-20,40},{-20,20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealPlanetary.carrier, inertia1.flange_b) annotation (Line(
        points={{4,54},{-2,54},{-2,90},{-10,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealPlanetary.ring, spring.flange_a) annotation (Line(
        points={{24,50},{32,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(spring.flange_b, inertia2.flange_a) annotation (Line(
        points={{52,50},{60,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealPlanetary.ring, damper.flange_a) annotation (Line(
        points={{24,50},{28,50},{28,68},{32,68}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(damper.flange_b, inertia2.flange_a) annotation (Line(
        points={{52,68},{60,68},{60,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(springDamper.flange_b, inertia1.flange_a) annotation (Line(
        points={{-38,90},{-30,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia3.flange_b, springDamper.flange_a) annotation (Line(
        points={{-72,90},{-58,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia1.flange_b, elastoBacklash.flange_a) annotation (Line(
        points={{-10,90},{10,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(elastoBacklash.flange_b, inertia4.flange_a) annotation (Line(
        points={{30,90},{40,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia4.flange_b, bearingFriction.flange_a) annotation (Line(
        points={{60,90},{64,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed.flange,bearingFriction.support)    annotation (Line(
        points={{-20,20},{92,20},{92,74},{74,74},{74,80}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(clutch.flange_b, inertia.flange_a) annotation (Line(
        points={{-66,50},{-60,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia5.flange_b, clutch.flange_a) annotation (Line(
        points={{-96,50},{-86,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine.y, clutch.f_normalized) annotation (Line(
        points={{-83,20},{-76,20},{-76,39}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertia2.flange_b, brake.flange_a) annotation (Line(
        points={{80,50},{100,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine1.y, brake.f_normalized) annotation (Line(
        points={{110,79},{110,61}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(fixed.flange,brake.support)    annotation (Line(
        points={{-20,20},{110,20},{110,40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(lossyGear.flange_b, inertia3.flange_a) annotation (Line(
        points={{-100,90},{-92,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia6.flange_b, lossyGear.flange_a) annotation (Line(
        points={{-130,90},{-120,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(lossyGear.support,fixed.flange)    annotation (Line(
        points={{-110,80},{-112,80},{-112,64},{-130,64},{-130,-6},{-44,-6},{-44,
            20},{-20,20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia7.flange_b, gear2_1.flange_a) annotation (Line(
        points={{-90,-30},{-80,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(gear2_1.flange_b, inertia8.flange_a) annotation (Line(
        points={{-60,-30},{-48,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed1.flange,gear2_1.support)    annotation (Line(
        points={{-70,-50},{-70,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed2.flange,position.support)    annotation (Line(
        points={{58,-20},{58,-10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position.flange,   inertia9.flange_a) annotation (Line(
        points={{68,0},{80,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine2.y, position.phi_ref) annotation (Line(
        points={{39,0},{46,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine3.y, speed.w_ref) annotation (Line(
        points={{41,-50},{48,-50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(speed.flange,   inertia10.flange_a) annotation (Line(
        points={{70,-50},{80,-50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(speed.support,fixed3.flange)    annotation (Line(
        points={{60,-60},{60,-70}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine4.y,accelerate.a_ref)
                                   annotation (Line(
        points={{41,-110},{48,-110}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(accelerate.flange,   inertia11.flange_a) annotation (Line(
        points={{70,-110},{80,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(accelerate.support,fixed4.flange)    annotation (Line(
        points={{60,-120},{60,-130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine5.y, move.u) annotation (Line(
        points={{41,-170},{48,-170}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(move.flange,   inertia12.flange_a) annotation (Line(
        points={{70,-170},{80,-170}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(move.support,fixed5.flange)    annotation (Line(
        points={{60,-180},{60,-190}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(brake.flange_b,torque.flange)    annotation (Line(
        points={{120,50},{140,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed.flange,torque.support)    annotation (Line(
        points={{-20,20},{150,20},{150,40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine6.y, torque.tau) annotation (Line(
        points={{171,50},{164.5,50},{164.5,50},{162,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(torque2_1.flange_a, inertia10.flange_b) annotation (Line(
        points={{112,-50},{100,-50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque2_1.flange_b, inertia13.flange_a) annotation (Line(
        points={{132,-50},{140,-50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine7.y, torque2_1.tau) annotation (Line(
        points={{115,-24},{122,-24},{122,-46}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(linearSpeedDependentTorque.flange, inertia7.flange_a) annotation (Line(
        points={{-122,-30},{-110,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(linearSpeedDependentTorque.support,fixed1.flange)    annotation (Line(
        points={{-132,-42},{-132,-50},{-70,-50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(quadraticSpeedDependentTorque.flange, inertia8.flange_b)
      annotation (Line(
        points={{-16,-30},{-28,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed1.flange,quadraticSpeedDependentTorque.support)    annotation (Line(
        points={{-70,-50},{-5,-50},{-5,-42}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(constantTorque.flange, inertia14.flange_a) annotation (Line(
        points={{-100,-90},{-92,-90},{-92,-110},{-84,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torqueStep.flange, inertia14.flange_a) annotation (Line(
        points={{-100,-130},{-84,-130},{-84,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed6.flange,torqueStep.support)    annotation (Line(
        points={{-110,-152},{-110,-142}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed6.flange,constantTorque.support)    annotation (Line(
        points={{-110,-152},{-130,-152},{-130,-102},{-110,-102}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torqueStep.support,constantSpeed.support)  annotation (Line(
        points={{-110,-142},{-50,-142}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(constantSpeed.flange, inertia15.flange_a) annotation (Line(
        points={{-40,-130},{-30,-130}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia8.flange_b, relativeStates.flange_b) annotation (Line(
        points={{-28,-30},{-30,-30},{-30,-70},{-40,-70}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(relativeStates.flange_a, inertia7.flange_b) annotation (Line(
        points={{-60,-70},{-90,-70},{-90,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia11.flange_b,angleSensor.flange)    annotation (Line(
        points={{100,-110},{118,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia11.flange_b,speedSensor.flange)    annotation (Line(
        points={{100,-110},{104,-110},{104,-86},{118,-86}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia11.flange_b,accSensor.flange)    annotation (Line(
        points={{100,-110},{104,-110},{104,-136},{118,-136}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia9.flange_b, relAngleSensor.flange_a) annotation (Line(
        points={{100,0},{132,0},{132,-10},{152,-10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia13.flange_b, relAngleSensor.flange_b) annotation (Line(
        points={{160,-50},{186,-50},{186,-10},{172,-10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia13.flange_b, relSpeedSensor.flange_a) annotation (Line(
        points={{160,-50},{160,-78},{166,-78}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia12.flange_b, relSpeedSensor.flange_b) annotation (Line(
        points={{100,-170},{198,-170},{198,-78},{186,-78}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia13.flange_b, relAccSensor.flange_a) annotation (Line(
        points={{160,-50},{160,-120}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(relAccSensor.flange_b, inertia12.flange_b) annotation (Line(
        points={{180,-120},{188,-120},{188,-170},{100,-170}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia15.flange_b, torqueSensor.flange_b) annotation (Line(
        points={{-10,-130},{8,-130},{8,-162},{-6,-162},{-6,-160}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torqueSensor.flange_a, powerSensor.flange_b) annotation (Line(
        points={{-26,-160},{-38,-160}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia16.flange_b, powerSensor.flange_a) annotation (Line(
        points={{-68,-160},{-58,-160}},
        color={0,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-140,-200},{200,100}},
          initialScale=0.1), graphics),
      experiment(StopTime=0.9));
  end AllComponents;

  model TestBearingConversion
    "Test, whether conversion of bearing to support is correctly performed"

    Modelica.Mechanics.Rotational.Components.IdealGear idealGear(useSupport=
          false)
      annotation (Placement(transformation(extent={{-60,140},{-40,160}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia
      annotation (Placement(transformation(extent={{-90,140},{-70,160}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.IdealGear idealGear1(useSupport=
          true)
      annotation (Placement(transformation(extent={{-28,140},{-8,160}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
        useSupport=true)
      annotation (Placement(transformation(extent={{0,140},{20,160}}, rotation=
              0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1
      annotation (Placement(transformation(extent={{-90,90},{-70,110}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction1(
        useSupport=false)
      annotation (Placement(transformation(extent={{-60,90},{-40,110}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed
      annotation (Placement(transformation(extent={{-28,124},{-8,144}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Brake brake(useSupport=true)
      annotation (Placement(transformation(extent={{-60,30},{-40,50}}, rotation=
             0)));
    Modelica.Blocks.Sources.Sine sine annotation (Placement(transformation(
            extent={{-90,60},{-70,80}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2
      annotation (Placement(transformation(extent={{-90,30},{-70,50}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.Brake brake1(useSupport=false)
      annotation (Placement(transformation(extent={{16,30},{36,50}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia3
      annotation (Placement(transformation(extent={{-20,30},{0,50}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed1
      annotation (Placement(transformation(extent={{-60,10},{-40,30}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(useSupport=
          false)
      annotation (Placement(transformation(extent={{4,90},{24,110}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia4
      annotation (Placement(transformation(extent={{-24,90},{-4,110}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia5
      annotation (Placement(transformation(extent={{34,90},{54,110}}, rotation=
              0)));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear1(useSupport=
          true)
      annotation (Placement(transformation(extent={{102,90},{122,110}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia6
      annotation (Placement(transformation(extent={{74,90},{94,110}}, rotation=
              0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia7
      annotation (Placement(transformation(extent={{132,90},{152,110}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed2
      annotation (Placement(transformation(extent={{102,72},{122,92}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.Gearbox gear2_1(useSupport=false)
      annotation (Placement(transformation(extent={{76,30},{96,50}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia8
      annotation (Placement(transformation(extent={{50,30},{70,50}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia9
      annotation (Placement(transformation(extent={{104,30},{124,50}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Sources.Position position(useSupport=false)
      annotation (Placement(transformation(extent={{-60,-28},{-40,-8}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine1 annotation (Placement(transformation(
            extent={{-96,-28},{-76,-8}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia12
      annotation (Placement(transformation(extent={{-30,-28},{-10,-8}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Position position1(useSupport=true)
      annotation (Placement(transformation(extent={{-60,-58},{-40,-38}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia13
      annotation (Placement(transformation(extent={{-30,-58},{-10,-38}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed4
      annotation (Placement(transformation(extent={{-60,-76},{-40,-56}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Gearbox gear2_2(useSupport=true)
      annotation (Placement(transformation(extent={{66,142},{86,162}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia10
      annotation (Placement(transformation(extent={{40,142},{60,162}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia11
      annotation (Placement(transformation(extent={{94,142},{114,162}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed3
      annotation (Placement(transformation(extent={{66,124},{86,144}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Sources.Speed position2(useSupport=false)
      annotation (Placement(transformation(extent={{40,-30},{60,-10}}, rotation=
             0)));
    Modelica.Blocks.Sources.Sine sine2 annotation (Placement(transformation(
            extent={{4,-30},{24,-10}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia14
      annotation (Placement(transformation(extent={{70,-30},{90,-10}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Sources.Speed position3(useSupport=true)
      annotation (Placement(transformation(extent={{40,-60},{60,-40}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia15
      annotation (Placement(transformation(extent={{70,-60},{90,-40}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed5
      annotation (Placement(transformation(extent={{40,-78},{60,-58}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Sources.Accelerate position4(useSupport=false)
      annotation (Placement(transformation(extent={{146,-30},{166,-10}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine3 annotation (Placement(transformation(
            extent={{110,-30},{130,-10}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia16
      annotation (Placement(transformation(extent={{176,-30},{196,-10}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Accelerate position5(useSupport=true)
      annotation (Placement(transformation(extent={{146,-60},{166,-40}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia17
      annotation (Placement(transformation(extent={{176,-60},{196,-40}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed6
      annotation (Placement(transformation(extent={{146,-78},{166,-58}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Move position6(useSupport=false)
      annotation (Placement(transformation(extent={{-60,-120},{-40,-100}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine4[3]
      annotation (Placement(transformation(extent={{-96,-120},{-76,-100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia18
      annotation (Placement(transformation(extent={{-30,-120},{-10,-100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Move position7(useSupport=true)
      annotation (Placement(transformation(extent={{-60,-150},{-40,-130}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia19
      annotation (Placement(transformation(extent={{-30,-150},{-10,-130}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed8
      annotation (Placement(transformation(extent={{-60,-168},{-40,-148}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine5 annotation (Placement(transformation(
            extent={{24,-120},{44,-100}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=false)
      annotation (Placement(transformation(extent={{60,-120},{80,-100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
      linearSpeedDependentTorque(tau_nominal=1, w_nominal=1,
      useSupport=false)          annotation (Placement(transformation(extent={{
              60,-154},{80,-134}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque(tau_nominal=1, w_nominal=1,
      useSupport=false)             annotation (Placement(transformation(extent=
             {{58,-190},{78,-170}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(
                                                                tau_constant=1,
        useSupport=false)
      annotation (Placement(transformation(extent={{60,-224},{80,-204}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep(useSupport=
          false)
      annotation (Placement(transformation(extent={{60,-260},{80,-240}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia20
      annotation (Placement(transformation(extent={{98,-120},{118,-100}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine6 annotation (Placement(transformation(
            extent={{140,-120},{160,-100}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=true)
      annotation (Placement(transformation(extent={{176,-120},{196,-100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
      linearSpeedDependentTorque1(tau_nominal=1, w_nominal=1,
      useSupport=true)            annotation (Placement(transformation(extent={
              {176,-154},{196,-134}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque1(tau_nominal=1, w_nominal=1,
      useSupport=true)               annotation (Placement(transformation(
            extent={{174,-190},{194,-170}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque1(
                                                                 tau_constant=1,
        useSupport=true)
      annotation (Placement(transformation(extent={{176,-224},{196,-204}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep1(useSupport=
          true)
      annotation (Placement(transformation(extent={{176,-260},{196,-240}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia21
      annotation (Placement(transformation(extent={{214,-120},{234,-100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed7
      annotation (Placement(transformation(extent={{220,-280},{240,-260}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.IdealGearR2T idealGearR2T(
        useSupportR=false, useSupportT=false)
      annotation (Placement(transformation(extent={{220,140},{240,160}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia22
      annotation (Placement(transformation(extent={{184,140},{204,160}},
            rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass
      annotation (Placement(transformation(extent={{260,140},{280,160}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.IdealGearR2T idealGearR2T1(
        useSupportR=true, useSupportT=true)
      annotation (Placement(transformation(extent={{216,100},{236,120}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia23
      annotation (Placement(transformation(extent={{180,100},{200,120}},
            rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass slidingMass1
      annotation (Placement(transformation(extent={{256,100},{276,120}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed9
      annotation (Placement(transformation(extent={{210,82},{230,102}},
            rotation=0)));
    Modelica.Mechanics.Translational.Components.Fixed fixed10
      annotation (Placement(transformation(extent={{232,82},{252,102}},
            rotation=0)));
  equation
    connect(inertia.flange_b, idealGear.flange_a) annotation (Line(
        points={{-70,150},{-60,150}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGear.flange_b, idealGear1.flange_a) annotation (Line(
        points={{-40,150},{-28,150}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGear1.flange_b, bearingFriction.flange_a) annotation (Line(
        points={{-8,150},{0,150}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia1.flange_b, bearingFriction1.flange_a) annotation (Line(
        points={{-70,100},{-60,100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGear1.support,fixed.flange)    annotation (Line(
        points={{-18,140},{-18,134}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed.flange,bearingFriction.support)    annotation (Line(
        points={{-18,134},{10,134},{10,140}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine.y, brake.f_normalized) annotation (Line(
        points={{-69,70},{-50,70},{-50,51}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertia2.flange_b, brake.flange_a) annotation (Line(
        points={{-70,40},{-60,40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia3.flange_b, brake1.flange_a) annotation (Line(
        points={{0,40},{16,40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine.y, brake1.f_normalized) annotation (Line(
        points={{-69,70},{26,70},{26,51}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(brake.support,fixed1.flange)    annotation (Line(
        points={{-50,30},{-50,20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia4.flange_b, lossyGear.flange_a) annotation (Line(
        points={{-4,100},{4,100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(lossyGear.flange_b, inertia5.flange_a) annotation (Line(
        points={{24,100},{34,100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia6.flange_b, lossyGear1.flange_a) annotation (Line(
        points={{94,100},{102,100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(lossyGear1.flange_b, inertia7.flange_a) annotation (Line(
        points={{122,100},{132,100}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed2.flange,lossyGear1.support)    annotation (Line(
        points={{112,82},{112,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia8.flange_b, gear2_1.flange_a) annotation (Line(
        points={{70,40},{76,40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(gear2_1.flange_b, inertia9.flange_a) annotation (Line(
        points={{96,40},{104,40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine1.y, position.phi_ref) annotation (Line(
        points={{-75,-18},{-62,-18}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(position.flange,   inertia12.flange_a) annotation (Line(
        points={{-40,-18},{-30,-18}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position1.flange,   inertia13.flange_a) annotation (Line(
        points={{-40,-48},{-30,-48}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine1.y, position1.phi_ref) annotation (Line(
        points={{-75,-18},{-70,-18},{-70,-48},{-62,-48}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(position1.support,fixed4.flange)    annotation (Line(
        points={{-50,-58},{-50,-66}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia10.flange_b, gear2_2.flange_a) annotation (Line(
        points={{60,152},{66,152}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(gear2_2.flange_b, inertia11.flange_a) annotation (Line(
        points={{86,152},{94,152}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed3.flange,gear2_2.support)    annotation (Line(
        points={{76,134},{76,142}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position2.flange,   inertia14.flange_a) annotation (Line(
        points={{60,-20},{70,-20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position3.flange,   inertia15.flange_a) annotation (Line(
        points={{60,-50},{70,-50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position3.support,fixed5.flange)    annotation (Line(
        points={{50,-60},{50,-68}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine2.y, position2.w_ref) annotation (Line(
        points={{25,-20},{38,-20}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine2.y, position3.w_ref) annotation (Line(
        points={{25,-20},{30,-20},{30,-50},{38,-50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(position4.flange,   inertia16.flange_a) annotation (Line(
        points={{166,-20},{176,-20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position5.flange,   inertia17.flange_a) annotation (Line(
        points={{166,-50},{176,-50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position5.support,fixed6.flange)    annotation (Line(
        points={{156,-60},{156,-68}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine3.y,position4.a_ref)
                                  annotation (Line(
        points={{131,-20},{144,-20}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine3.y,position5.a_ref)
                                  annotation (Line(
        points={{131,-20},{136,-20},{136,-50},{144,-50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(position6.flange,   inertia18.flange_a) annotation (Line(
        points={{-40,-110},{-30,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position7.flange,   inertia19.flange_a) annotation (Line(
        points={{-40,-140},{-30,-140}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(position7.support,fixed8.flange)    annotation (Line(
        points={{-50,-150},{-50,-158}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine4.y, position6.u) annotation (Line(
        points={{-75,-110},{-62,-110}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine4.y, position7.u) annotation (Line(
        points={{-75,-110},{-72,-110},{-72,-140},{-62,-140}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine5.y, torque.tau) annotation (Line(
        points={{45,-110},{50.5,-110},{50.5,-110},{58,-110}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(torque.flange,   inertia20.flange_a) annotation (Line(
        points={{80,-110},{98,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(linearSpeedDependentTorque.flange, inertia20.flange_a) annotation (Line(
        points={{80,-144},{92,-144},{92,-110},{98,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(quadraticSpeedDependentTorque.flange, inertia20.flange_a)
      annotation (Line(
        points={{78,-180},{92,-180},{92,-110},{98,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(constantTorque.flange, inertia20.flange_a) annotation (Line(
        points={{80,-214},{92,-214},{92,-110},{98,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torqueStep.flange, inertia20.flange_a) annotation (Line(
        points={{80,-250},{92,-250},{92,-110},{98,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine6.y, torque1.tau) annotation (Line(
        points={{161,-110},{174,-110}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(torque1.flange,   inertia21.flange_a) annotation (Line(
        points={{196,-110},{214,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(linearSpeedDependentTorque1.flange, inertia21.flange_a) annotation (Line(
        points={{196,-144},{208,-144},{208,-110},{214,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(quadraticSpeedDependentTorque1.flange, inertia21.flange_a)
      annotation (Line(
        points={{194,-180},{208,-180},{208,-110},{214,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(constantTorque1.flange, inertia21.flange_a) annotation (Line(
        points={{196,-214},{208,-214},{208,-110},{214,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torqueStep1.flange, inertia21.flange_a) annotation (Line(
        points={{196,-250},{208,-250},{208,-110},{214,-110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torqueStep1.support,fixed7.flange)    annotation (Line(
        points={{186,-260},{186,-270},{230,-270}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(constantTorque1.support,fixed7.flange)    annotation (Line(
        points={{186,-224},{208,-224},{208,-228},{230,-228},{230,-270}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(quadraticSpeedDependentTorque1.support,fixed7.flange)
      annotation (Line(
        points={{184,-190},{230,-190},{230,-270}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(linearSpeedDependentTorque1.support,fixed7.flange)    annotation (Line(
        points={{186,-154},{230,-154},{230,-270}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque1.support,fixed7.flange)    annotation (Line(
        points={{186,-120},{186,-126},{230,-126},{230,-270}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia22.flange_b,idealGearR2T.flangeR)   annotation (Line(
        points={{204,150},{220,150}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGearR2T.flangeT,  slidingMass.flange_a) annotation (Line(
        points={{240,150},{260,150}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(inertia23.flange_b,idealGearR2T1.flangeR)   annotation (Line(
        points={{200,110},{216,110}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGearR2T1.flangeT,  slidingMass1.flange_a) annotation (Line(
        points={{236,110},{256,110}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(idealGearR2T1.supportR,fixed9.flange)    annotation (Line(
        points={{216,100},{216,96},{220,96},{220,92}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed10.flange,idealGearR2T1.supportT)    annotation (Line(
        points={{242,92},{242,100},{236,100}},
        color={0,127,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-300},{300,200}},
          initialScale=0.1), graphics),
      experiment(StopTime=0.5),
      experimentSetupOutput);
  end TestBearingConversion;

  model TestFriction "Test friction elements"

    Modelica.Mechanics.Rotational.Components.Inertia inertia
      annotation (Placement(transformation(extent={{-8,80},{12,100}}, rotation=
              0)));
    Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
        useSupport=false)
      annotation (Placement(transformation(extent={{22,80},{42,100}}, rotation=
              0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=false)
      annotation (Placement(transformation(extent={{-40,80},{-20,100}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine(amplitude=10)
      annotation (Placement(transformation(extent={{-80,80},{-60,100}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1
      annotation (Placement(transformation(extent={{-8,20},{12,40}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=false)
      annotation (Placement(transformation(extent={{-40,20},{-20,40}}, rotation=
             0)));
    Modelica.Blocks.Sources.Sine sine1(amplitude=10)
      annotation (Placement(transformation(extent={{-80,20},{-60,40}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.Brake brake(useSupport=false)
                                              annotation (Placement(
          transformation(extent={{20,20},{40,40}}, rotation=0)));
    Modelica.Blocks.Sources.Step step(height=100, startTime=0.5)
      annotation (Placement(transformation(extent={{-18,50},{2,70}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2
      annotation (Placement(transformation(extent={{-8,-40},{12,-20}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=false)
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine2(amplitude=10)
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Clutch clutch
      annotation (Placement(transformation(extent={{24,-40},{44,-20}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia3
      annotation (Placement(transformation(extent={{58,-40},{78,-20}}, rotation=
             0)));
    Modelica.Blocks.Sources.Step step1(height=100, startTime=0.5)
      annotation (Placement(transformation(extent={{-12,-10},{8,10}}, rotation=
              0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia4
      annotation (Placement(transformation(extent={{-6,-100},{14,-80}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque3(useSupport=false)
      annotation (Placement(transformation(extent={{-38,-100},{-18,-80}},
            rotation=0)));
    Modelica.Blocks.Sources.Sine sine3(amplitude=10)
      annotation (Placement(transformation(extent={{-78,-100},{-58,-80}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia5
      annotation (Placement(transformation(extent={{60,-100},{80,-80}},
            rotation=0)));
    Modelica.Blocks.Sources.Step step2(height=100, startTime=0.5)
      annotation (Placement(transformation(extent={{-10,-70},{10,-50}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.OneWayClutch oneWayClutch
      annotation (Placement(transformation(extent={{46,-100},{26,-80}},
            rotation=0)));
  equation
    connect(inertia.flange_b, bearingFriction.flange_a) annotation (Line(
        points={{12,90},{22,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque.flange,   inertia.flange_a) annotation (Line(
        points={{-20,90},{-8,90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine.y, torque.tau) annotation (Line(
        points={{-59,90},{-42,90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(torque1.flange,   inertia1.flange_a) annotation (Line(
        points={{-20,30},{-8,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine1.y, torque1.tau) annotation (Line(
        points={{-59,30},{-42,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertia1.flange_b, brake.flange_a) annotation (Line(
        points={{12,30},{20,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(step.y, brake.f_normalized) annotation (Line(
        points={{3,60},{30,60},{30,41}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(torque2.flange,   inertia2.flange_a) annotation (Line(
        points={{-20,-30},{-8,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine2.y, torque2.tau) annotation (Line(
        points={{-59,-30},{-42,-30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertia2.flange_b, clutch.flange_a) annotation (Line(
        points={{12,-30},{24,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(clutch.flange_b, inertia3.flange_a) annotation (Line(
        points={{44,-30},{58,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(step1.y, clutch.f_normalized) annotation (Line(
        points={{9,0},{34,0},{34,-19}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(torque3.flange,   inertia4.flange_a) annotation (Line(
        points={{-18,-90},{-6,-90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine3.y, torque3.tau) annotation (Line(
        points={{-57,-90},{-40,-90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(step2.y, oneWayClutch.f_normalized) annotation (Line(
        points={{11,-60},{36,-60},{36,-79}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(oneWayClutch.flange_b, inertia4.flange_b) annotation (Line(
        points={{26,-90},{14,-90}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(oneWayClutch.flange_a, inertia5.flange_a) annotation (Line(
        points={{46,-90},{60,-90}},
        color={0,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics),
      experiment(StopTime=1.1));
  end TestFriction;
end Rotational;
