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
    Modelica.Blocks.Sources.Sine sine(f=1)
                                      annotation (Placement(transformation(
            extent={{-100,-20},{-80,0}})));
    Modelica.Mechanics.Translational.Components.Mass slidingMass4(m=1)
      annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
    Modelica.Mechanics.Translational.Sources.Speed position1
      annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));
    Modelica.Blocks.Sources.Sine sine1(f=1)
                                       annotation (Placement(transformation(
            extent={{-100,-60},{-80,-40}})));
    Modelica.Mechanics.Translational.Components.Mass slidingMass5(m=1)
      annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
    Modelica.Mechanics.Translational.Sources.Accelerate position2
      annotation (Placement(transformation(extent={{-70,-100},{-50,-80}})));
    Modelica.Blocks.Sources.Sine sine2(f=1)
                                       annotation (Placement(transformation(
            extent={{-100,-100},{-80,-80}})));
    Modelica.Mechanics.Translational.Components.Mass slidingMass6(m=1)
      annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
    Modelica.Mechanics.Translational.Sources.Move position3
      annotation (Placement(transformation(extent={{30,-20},{50,0}})));
    Modelica.Blocks.Sources.Sine sine3[3](f={1,1,1})
                                          annotation (Placement(transformation(
            extent={{0,-20},{20,0}})));
    Modelica.Mechanics.Translational.Components.Mass slidingMass7(m=1)
      annotation (Placement(transformation(extent={{60,-20},{80,0}})));
    Modelica.Mechanics.Translational.Sources.Force force
      annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
    Modelica.Mechanics.Translational.Components.RelativeStates relativeStates(s_rel(
          fixed=true), v_rel(fixed=true))
      annotation (Placement(transformation(extent={{-20,80},{0,100}})));
    Modelica.Blocks.Sources.Sine sine4(f=1)
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
    annotation (experiment(StopTime=1.1));
  end AllComponents;

  model TestBraking
    extends Modelica.Icons.Example;
    Modelica.Mechanics.Translational.Components.Mass mass1(
      m=1,
      s(fixed=true, start=0),
      v(fixed=true, start=100))
      annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
    Modelica.Mechanics.Translational.Sources.LinearSpeedDependentForce
      linearSpeedDependentForce(f_nominal=-100, v_nominal=100)
      annotation (Placement(transformation(extent={{40,70},{20,90}})));
    Modelica.Mechanics.Translational.Components.Mass mass2(
      m=1,
      s(fixed=true, start=0),
      v(fixed=true, start=100))
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    Modelica.Mechanics.Translational.Sources.QuadraticSpeedDependentForce
      quadraticSpeedDependentForce(f_nominal=-100, v_nominal=100)
      annotation (Placement(transformation(extent={{40,40},{20,60}})));
    Modelica.Mechanics.Translational.Components.Mass mass3(
      m=1,
      s(fixed=true, start=0),
      v(fixed=true, start=100))
      annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
    Modelica.Mechanics.Translational.Sources.ConstantForce constantForce(
        f_constant=-100)
      annotation (Placement(transformation(extent={{40,10},{20,30}})));
    Modelica.Mechanics.Translational.Components.Mass mass4(
      m=1,
      s(fixed=true, start=0),
      v(fixed=true, start=100))
      annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
    Modelica.Mechanics.Translational.Sources.SignForce signForce(f_nominal=-100,
        v0=1) annotation (Placement(transformation(extent={{40,-20},{20,0}})));
    Modelica.Mechanics.Translational.Sources.EddyCurrentForce eddyCurrentForce(
      f_nominal=100,
      v_nominal=10,
      useHeatPort=true,
      TRef=293.15,
      alpha20(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper)
      annotation (Placement(transformation(extent={{40,-50},{20,-30}})));
    Modelica.Mechanics.Translational.Components.Mass mass5(
      m=1,
      s(fixed=true, start=0),
      v(fixed=true, start=20))
      annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=1, T(
          fixed=true)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={60,-60})));
    Modelica.Mechanics.Translational.Components.Mass mass6(
      m=1,
      s(fixed=true, start=0),
      v(fixed=true, start=100))
      annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
    Modelica.Mechanics.Translational.Sources.InverseSpeedDependentForce inverseSpeedDependentForce(
      f_nominal=-100,
      v_nominal=100,
      v0=1) annotation (Placement(transformation(extent={{40,-90},{20,-70}})));
  equation
    connect(mass1.flange_b, linearSpeedDependentForce.flange)
      annotation (Line(points={{-20,80},{20,80}}, color={0,127,0}));
    connect(quadraticSpeedDependentForce.flange, mass2.flange_b)
      annotation (Line(points={{20,50},{-20,50}}, color={0,127,0}));
    connect(constantForce.flange, mass3.flange_b)
      annotation (Line(points={{20,20},{-20,20}},
                                                color={0,127,0}));
    connect(signForce.flange, mass4.flange_b)
      annotation (Line(points={{20,-10},{-20,-10}}, color={0,127,0}));
    connect(eddyCurrentForce.heatPort, heatCapacitor.port) annotation (Line(
          points={{40,-50},{60,-50}}, color={191,0,0}));
    connect(eddyCurrentForce.flange, mass5.flange_b) annotation (Line(points={{20,-40},{-20,-40}}, color={0,127,0}));
    connect(inverseSpeedDependentForce.flange, mass6.flange_b)
      annotation (Line(points={{20,-80},{-20,-80}},   color={0,127,0}));
    annotation (
      experiment(StopTime=2),
      Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
  end TestBraking;

  model Vehicles
    extends Modelica.Icons.Example;
    Modelica.Mechanics.Translational.Components.Vehicle vehicleDrag(
      m=1200,
      J=2.3,
      R=0.31,
      A=2.2,
      Cd=0.31,
      vWindConstant=-2,
      CrConstant=0,
      inclinationConstant=0,
      v(fixed=true, start=27.777777777778)) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Modelica.Mechanics.Translational.Components.Vehicle vehicleDragInConst(
      m=1200,
      J=2.3,
      R=0.31,
      A=2.2,
      Cd=0.31,
      useWindInput=true,
      vWindConstant=1,
      CrConstant=0,
      inclinationConstant=0,
      v(fixed=true, start=27.777777777778)) annotation (Placement(transformation(extent={{0,40},{20,60}})));
    Modelica.Mechanics.Translational.Components.Vehicle vehicleDragInVar(
      m=1200,
      J=2.3,
      R=0.31,
      A=2.2,
      Cd=0.31,
      useWindInput=true,
      vWindConstant=1,
      CrConstant=0,
      inclinationConstant=0,
      v(fixed=true, start=27.777777777778)) annotation (Placement(transformation(extent={{80,40},{100,60}})));
    Modelica.Mechanics.Translational.Components.Vehicle vehicleRoll(
      m=1200,
      J=2.3,
      R=0.31,
      A=0,
      Cd=0.31,
      CrConstant=0.013,
      inclinationConstant=0,
      v(fixed=true, start=27.777777777778)) annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
    Modelica.Mechanics.Translational.Components.Vehicle vehicleRollInConst(
      m=1200,
      J=2.3,
      R=0.31,
      A=0,
      Cd=0.31,
      useCrInput=true,
      CrConstant=0.013,
      inclinationConstant=0,
      v(fixed=true, start=27.777777777778)) annotation (Placement(transformation(extent={{-2,0},{18,20}})));
    Modelica.Mechanics.Translational.Components.Vehicle vehicleRollInVar(
      m=1200,
      J=2.3,
      R=0.31,
      A=0,
      Cd=0.31,
      useCrInput=true,
      CrConstant=0.013,
      inclinationConstant=0,
      v(fixed=true, start=27.777777777778)) annotation (Placement(transformation(extent={{78,0},{98,20}})));
    Modelica.Mechanics.Translational.Components.Vehicle vehicleInclination(
      m=1200,
      J=2.3,
      R=0.31,
      A=0,
      Cd=0.31,
      CrConstant=0,
      inclinationConstant=0.05,
      v(fixed=true, start=27.777777777778)) annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
    Modelica.Mechanics.Translational.Components.Vehicle vehicleInclinationInConst(
      m=1200,
      J=2.3,
      R=0.31,
      A=0,
      Cd=0.31,
      CrConstant=0,
      useInclinationInput=true,
      inclinationConstant=0.12,
      v(fixed=true, start=27.777777777778)) annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
    Modelica.Mechanics.Translational.Components.Vehicle vehicleInclinationInVar(
      m=1200,
      J=2.3,
      R=0.31,
      A=0,
      Cd=0.31,
      CrConstant=0,
      useInclinationInput=true,
      inclinationConstant=0.12,
      v(fixed=true, start=27.777777777778)) annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
    Modelica.Blocks.Sources.Constant const1(k=-2) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Modelica.Blocks.Sources.Constant const2(k=0.013) annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
    Modelica.Blocks.Sources.Constant const3(k=0.05) annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
    Modelica.Blocks.Sources.Sine sine1(
      amplitude=1,
      f=1,
      offset=-2) annotation (Placement(transformation(extent={{40,20},{60,40}})));
    Modelica.Blocks.Sources.Sine sine2(
      amplitude=0.013,
      f=0.5,
      offset=0.013) annotation (Placement(transformation(extent={{40,-20},{60,0}})));
    Modelica.Blocks.Sources.Sine sine3(
      amplitude=-0.05,
      f=1,
      offset=0.05) annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  equation
    connect(const1.y, vehicleDragInConst.vWind) annotation (Line(points={{-19,30},{16,30},{16,38}}, color={0,0,127}));
    connect(const2.y, vehicleRollInConst.cr) annotation (Line(points={{-19,-10},{8,-10},{8,-2}}, color={0,0,127}));
    connect(const3.y, vehicleInclinationInConst.inclination) annotation (Line(points={{-19,-50},{4,-50},{4,-42}}, color={0,0,127}));
    connect(sine1.y, vehicleDragInVar.vWind) annotation (Line(points={{61,30},{96,30},{96,38}}, color={0,0,127}));
    connect(sine2.y, vehicleRollInVar.cr) annotation (Line(points={{61,-10},{88,-10},{88,-2}}, color={0,0,127}));
    connect(sine3.y, vehicleInclinationInVar.inclination) annotation (Line(points={{61,-50},{84,-50},{84,-42}}, color={0,0,127}));
    annotation (
      experiment(StopTime=2));
  end Vehicles;

  model TestFrictionPosition
    extends Modelica.Icons.Example;

    Modelica.Mechanics.Translational.Sources.Position position(exact=true)
      annotation (Placement(transformation(extent={{-10,30},{10,50}})));

    Modelica.Blocks.Sources.Sine sine(
      amplitude=0.1,
      f=1,
      phase=0.78539816339745,
      offset=0.5) annotation (Placement(transformation(extent={{-70,30},{-50,50}})));

    Modelica.Mechanics.Translational.Components.SupportFriction supportFriction(f_pos=
          Modelica.Mechanics.Translational.Examples.Utilities.GenerateStribeckFrictionTable(
          1,
          5,
          10,
          1,
          12,
          50), peak=1.001)
      annotation (Placement(transformation(extent={{46,30},{66,50}})));
    Modelica.Mechanics.Translational.Sources.Force    force
      annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
    Modelica.Blocks.Sources.Sine sine1(
      amplitude=25,
      f=1,
      phase=0.78539816339745,
      offset=0.5) annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
    Modelica.Mechanics.Translational.Components.SupportFriction supportFriction1(f_pos=
          Modelica.Mechanics.Translational.Examples.Utilities.GenerateStribeckFrictionTable(
            1,
            5,
            10,
            1,
            12,
            50), peak=1.001)
      annotation (Placement(transformation(extent={{46,-50},{66,-30}})));
    Modelica.Mechanics.Translational.Components.Mass mass(m=1, v(start=-2, fixed=true))
      annotation (Placement(transformation(extent={{74,-50},{94,-30}})));
    Modelica.Mechanics.Translational.Sources.Position position1(exact=true)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Sine sine2(
      amplitude=0.3,
      f=1,
      phase=2.3561944901923,
      offset=0.5) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
    Modelica.Mechanics.Translational.Components.SupportFriction supportFriction2(f_pos=
          Modelica.Mechanics.Translational.Examples.Utilities.GenerateStribeckFrictionTable(
            1,
            5,
            10,
            1,
            12,
            50), peak=1.001)
      annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  equation
    connect(sine.y, position.s_ref) annotation (Line(points={{-49,40},{-12,40}},
                                                                               color={0,0,127}));

    connect(position.flange, supportFriction.flange_a) annotation (Line(points={{10,40},{46,40}},
                                                                                                color={0,127,0}));
    connect(force.flange, supportFriction1.flange_a) annotation (Line(points={{10,-40},{46,-40}}, color={0,127,0}));
    connect(supportFriction1.flange_b, mass.flange_a) annotation (Line(points={{66,-40},{74,-40}}, color={0,127,0}));
    connect(sine1.y, force.f) annotation (Line(points={{-49,-40},{-12,-40}}, color={0,0,127}));
    connect(sine2.y, position1.s_ref) annotation (Line(points={{-49,0},{-12,0}}, color={0,0,127}));
    connect(position1.flange, supportFriction2.flange_a) annotation (Line(points={{10,0},{46,0}}, color={0,127,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end TestFrictionPosition;

  model TestFrictionPositionInertial
    extends Modelica.Icons.Example;

    Modelica.Mechanics.Translational.Sources.Speed speed(exact=true)
      annotation (Placement(transformation(extent={{-10,30},{10,50}})));

    Modelica.Blocks.Sources.Cosine cosine(
      amplitude=0.1,
      f=1,
      phase=0,
      continuous=true,
      offset=0.5,
      startTime=0.1) annotation (Placement(transformation(extent={{-70,30},{-50,50}})));

    Modelica.Mechanics.Translational.Components.SupportFriction supportFriction(
      f_pos=Modelica.Mechanics.Translational.Examples.Utilities.GenerateStribeckFrictionTable(
          1,
          5,
          10,
          1,
          12,
          50),
      peak=1.001) annotation (Placement(transformation(extent={{46,30},{66,50}})));
    Modelica.Mechanics.Translational.Sources.Speed speed1(exact=true)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Cosine cosine1(
      amplitude=0.3,
      f=1,
      phase=3.1415926535898,
      continuous=true,
      offset=0.5,
      startTime=0.1) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
    Modelica.Mechanics.Translational.Components.SupportFriction supportFriction2(
      f_pos=Modelica.Mechanics.Translational.Examples.Utilities.GenerateStribeckFrictionTable(
          1,
          5,
          10,
          1,
          12,
          50),
      peak=1.001) annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  equation

    connect(speed.flange, supportFriction.flange_a) annotation (Line(points={{10,40},{46,40}}, color={0,127,0}));
    connect(speed1.flange, supportFriction2.flange_a) annotation (Line(points={{10,0},{46,0}}, color={0,127,0}));
    connect(cosine.y, speed.v_ref) annotation (Line(points={{-49,40},{-12,40},{-12,40}}, color={0,0,127}));
    connect(cosine1.y, speed1.v_ref) annotation (Line(points={{-49,0},{-12,0}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end TestFrictionPositionInertial;
end Translational;
