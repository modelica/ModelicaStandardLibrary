within ModelicaTest;
package FluxTubes "Test library for Modelica.Magnetic.FluxTubes"
  extends Modelica.Icons.ExamplesPackage;

  model BasicComponents
    "Test model with all components from Modelica.Magnetic.FluxTubes.Basic"
    extends Modelica.Icons.Example;
    Modelica.Magnetic.FluxTubes.Basic.Ground ground
      annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
    Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter(N=1, i(
          start=0, fixed=true))
      annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
    Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverterWithLeakageInductance
      converter1(N=1, i(fixed=true, start=0))
                 annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Magnetic.FluxTubes.Basic.ConstantReluctance constantReluctance
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={20,70})));
    Modelica.Magnetic.FluxTubes.Basic.LeakageWithCoefficient
      leakageWithCoefficient(R_mUsefulTot=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,70})));
    Modelica.Magnetic.FluxTubes.Basic.EddyCurrent eddyCurrent(Phi(start=0,
          fixed=true))
      annotation (Placement(transformation(extent={{-10,10},{10,30}})));
    Modelica.Magnetic.FluxTubes.Basic.Idle idle annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={90,10})));
    Modelica.Magnetic.FluxTubes.Basic.Short short
      annotation (Placement(transformation(extent={{50,10},{70,30}})));
    Modelica.Magnetic.FluxTubes.Basic.Crossing crossing annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={30,10})));
    Modelica.Electrical.Analog.Basic.Ground ground1
      annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
    Modelica.Electrical.Analog.Basic.Conductor conductor(G=1)
      annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
    Modelica.Electrical.Analog.Sources.StepVoltage stepVoltage(V=1) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,70})));
    Modelica.Magnetic.FluxTubes.Basic.Ground ground2
      annotation (Placement(transformation(extent={{10,30},{30,50}})));
    Modelica.Electrical.Analog.Basic.Ground ground3
      annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
    Modelica.Electrical.Analog.Basic.Conductor conductor1(G=1)
      annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
    Modelica.Electrical.Analog.Sources.StepVoltage stepVoltage1(V=1) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,10})));
    Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance constantPermeance
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={80,10})));
  equation
    connect(ground1.p, stepVoltage.n) annotation (Line(
        points={{-80,50},{-80,60}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(stepVoltage.p, conductor.p) annotation (Line(
        points={{-80,80},{-70,80}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(conductor.n, converter.p) annotation (Line(
        points={{-50,80},{-40,80},{-40,76}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(converter.n, stepVoltage.n) annotation (Line(
        points={{-40,64},{-40,60},{-80,60}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(converter.port_p, leakageWithCoefficient.port_p) annotation (Line(
        points={{-20,76},{-20,80},{0,80}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(leakageWithCoefficient.port_p, constantReluctance.port_p) annotation (
       Line(
        points={{0,80},{20,80}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(constantReluctance.port_n, leakageWithCoefficient.port_n) annotation (
       Line(
        points={{20,60},{0,60}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(leakageWithCoefficient.port_n, converter.port_n) annotation (Line(
        points={{0,60},{-20,60},{-20,64}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(ground3.p, stepVoltage1.n) annotation (Line(
        points={{-80,-10},{-80,0}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(stepVoltage1.p, conductor1.p) annotation (Line(
        points={{-80,20},{-70,20}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground2.port, constantReluctance.port_n) annotation (Line(
        points={{20,50},{20,60}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(converter1.port_p, eddyCurrent.port_p) annotation (Line(
        points={{-20,16},{-20,20},{-10,20}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(conductor1.n, converter1.p) annotation (Line(
        points={{-50,20},{-40,20},{-40,16}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(converter1.n, stepVoltage1.n) annotation (Line(
        points={{-40,4},{-40,0},{-80,0}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground.port, converter1.port_n) annotation (Line(
        points={{-20,-10},{-20,4}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(eddyCurrent.port_n, crossing.port_n2) annotation (Line(
        points={{10,20},{20,20}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(crossing.port_p2, short.port_p) annotation (Line(
        points={{40,20},{50,20}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(crossing.port_p1, converter1.port_n) annotation (Line(
        points={{20,0},{-20,0},{-20,4}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(constantPermeance.port_p, short.port_n) annotation (Line(
        points={{80,20},{70,20}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(constantPermeance.port_n, crossing.port_n1) annotation (Line(
        points={{80,0},{40,0}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(idle.port_p, short.port_n) annotation (Line(
        points={{90,20},{70,20}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(idle.port_n, constantPermeance.port_n) annotation (Line(
        points={{90,0},{80,0}},
        color={255,127,0},
        smooth=Smooth.None));
    annotation (experiment(StartTime=0, StopTime=14, Interval=3e-3, Tolerance=1e-005),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end BasicComponents;

  package Shapes
    model FixedShape
      extends Modelica.Icons.Example;
      Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube genericFluxTube(
        l=0.01,
        area=1e-4,
        nonLinearPermeability=true,
        material=
            Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet.M330_50A())
                annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,10})));

      Modelica.Magnetic.FluxTubes.Shapes.FixedShape.Cuboid cuboid(
        l=0.01,
        a=0.01,
        b=0.01,
        nonLinearPermeability=true,
        material=
            Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet.M330_50A())
                annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={40,10})));

      Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
        hollowCylinderAxialFlux(
        nonLinearPermeability=true,
        material=
            Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet.M330_50A(),
        l=0.01,
        r_i=0,
        r_o=0.01) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}},
            rotation=270,
            origin={60,10})));
      Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
        hollowCylinderRadialFlux(
        nonLinearPermeability=true,
        material=
            Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet.M330_50A(),
        l=0.01,
        r_i=0.01,
        r_o=0.02) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}},
            rotation=270,
            origin={80,10})));
      Modelica.Magnetic.FluxTubes.Basic.Ground ground
        annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
      Modelica.Magnetic.FluxTubes.Sources.SignalMagneticPotentialDifference
        signalSource annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-20,10})));
      Modelica.Blocks.Sources.Ramp ramp(height=5, duration=1)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    equation

      connect(signalSource.port_n, ground.port)
        annotation (Line(points={{-20,0},{-20,-20}}, color={255,127,0}));
      connect(genericFluxTube.port_n, ground.port) annotation (Line(points={{
              20,0},{20,-20},{-20,-20}}, color={255,127,0}));
      connect(hollowCylinderRadialFlux.port_n, ground.port) annotation (Line(
            points={{80,0},{80,-20},{-20,-20}}, color={255,127,0}));
      connect(hollowCylinderAxialFlux.port_n, ground.port) annotation (Line(
            points={{60,0},{60,-20},{-20,-20}}, color={255,127,0}));
      connect(cuboid.port_n, ground.port) annotation (Line(points={{40,0},{40,
              -20},{-20,-20}}, color={255,127,0}));
      connect(genericFluxTube.port_p, signalSource.port_p) annotation (Line(
            points={{20,20},{20,40},{-20,40},{-20,20}}, color={255,127,0}));
      connect(hollowCylinderRadialFlux.port_p, signalSource.port_p)
        annotation (Line(points={{80,20},{80,40},{-20,40},{-20,20}}, color={
              255,127,0}));
      connect(hollowCylinderAxialFlux.port_p, signalSource.port_p)
        annotation (Line(points={{60,20},{60,40},{-20,40},{-20,20}}, color={
              255,127,0}));
      connect(cuboid.port_p, signalSource.port_p) annotation (Line(points={{
              40,20},{40,40},{-20,40},{-20,20}}, color={255,127,0}));
      connect(ramp.y, signalSource.V_m)
        annotation (Line(points={{-39,10},{-29,10}}, color={0,0,127}));
      annotation (experiment(StartTime=0, StopTime=1, Interval=1e-3, Tolerance=1e-005), Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));
    end FixedShape;
    extends Modelica.Icons.ExamplesPackage;

    model Force
      extends Modelica.Icons.Example;
      Modelica.Magnetic.FluxTubes.Shapes.Force.HollowCylinderAxialFlux
        hollowCylinderAxialFlux(
        dlBydx=1,
        r_i=0,
        r_o=0.01,
        useSupport=false,
        mu_r=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-60,50})));
      Modelica.Magnetic.FluxTubes.Shapes.Force.CuboidParallelFlux
        cuboidParallelFlux(mu_r=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-20,10})));
      Modelica.Magnetic.FluxTubes.Shapes.Force.CuboidOrthogonalFlux
        cuboidOrthogonalFlux(mu_r=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-10})));
      Modelica.Magnetic.FluxTubes.Sources.ConstantMagneticPotentialDifference
        constantSource(V_m=10) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-80,10})));
      Modelica.Magnetic.FluxTubes.Basic.Ground ground
        annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
      Modelica.Mechanics.Translational.Sources.Position position(v(fixed=true,
            start=0))
        annotation (Placement(transformation(extent={{70,-20},{50,0}})));
      Modelica.Blocks.Sources.Ramp ramp(
        duration=1,
        offset=0.1e-3,
        startTime=0,
        height=5e-3)
        annotation (Placement(transformation(extent={{100,-20},{80,0}})));
      Modelica.Magnetic.FluxTubes.Shapes.Force.HollowCylinderRadialFlux
        hollowCylinderRadialFlux(
        mu_r=1,
        dlBydx=1,
        r_i=0.01,
        r_o=0.015) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-40,30})));
      Modelica.Magnetic.FluxTubes.Shapes.Force.LeakageAroundPoles
        leakageAroundPoles(
        mu_r=1,
        dlBydx=1,
        w=0.1,
        r=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,-30})));
    equation

      connect(constantSource.port_p, hollowCylinderAxialFlux.port_p)
        annotation (Line(points={{-80,20},{-80,20},{-80,80},{-60,80},{-60,60}},
            color={255,127,0}));
      connect(cuboidOrthogonalFlux.port_p, hollowCylinderAxialFlux.port_p)
        annotation (Line(points={{1.77636e-015,0},{1.77636e-015,80},{-60,80},{
              -60,60}}, color={255,127,0}));
      connect(cuboidParallelFlux.port_p, hollowCylinderAxialFlux.port_p)
        annotation (Line(points={{-20,20},{-20,80},{-60,80},{-60,60}}, color={
              255,127,0}));
      connect(constantSource.port_n, ground.port)
        annotation (Line(points={{-80,0},{-80,-60}}, color={255,127,0}));
      connect(cuboidOrthogonalFlux.port_n, ground.port) annotation (Line(points=
             {{-1.77636e-015,-20},{-1.77636e-015,-60},{-80,-60}}, color={255,
              127,0}));
      connect(cuboidParallelFlux.port_n, ground.port) annotation (Line(points={
              {-20,0},{-20,-60},{-80,-60}}, color={255,127,0}));
      connect(hollowCylinderAxialFlux.port_n, ground.port) annotation (Line(
            points={{-60,40},{-60,-60},{-80,-60}}, color={255,127,0}));
      connect(position.flange, cuboidOrthogonalFlux.flange) annotation (Line(
            points={{50,-10},{50,-10},{10,-10}}, color={0,127,0}));
      connect(cuboidParallelFlux.flange, cuboidOrthogonalFlux.flange)
        annotation (Line(points={{-10,10},{-10,10},{40,10},{40,-10},{10,-10}},
            color={0,127,0}));
      connect(hollowCylinderAxialFlux.flange, cuboidOrthogonalFlux.flange)
        annotation (Line(points={{-50,50},{40,50},{40,-10},{10,-10}}, color={0,
              127,0}));
      connect(ramp.y, position.s_ref)
        annotation (Line(points={{79,-10},{72,-10}}, color={0,0,127}));
      connect(hollowCylinderRadialFlux.port_p, hollowCylinderAxialFlux.port_p)
        annotation (Line(points={{-40,40},{-40,80},{-60,80},{-60,60}}, color={
              255,127,0}));
      connect(hollowCylinderRadialFlux.port_n, ground.port) annotation (Line(
            points={{-40,20},{-40,-60},{-80,-60}}, color={255,127,0}));
      connect(hollowCylinderRadialFlux.flange, cuboidOrthogonalFlux.flange)
        annotation (Line(points={{-30,30},{40,30},{40,-10},{10,-10}}, color={0,
              127,0}));
      connect(leakageAroundPoles.port_p, hollowCylinderAxialFlux.port_p)
        annotation (Line(points={{20,-20},{20,80},{-60,80},{-60,60}}, color={
              255,127,0}));
      connect(leakageAroundPoles.port_n, ground.port) annotation (Line(points={
              {20,-40},{20,-40},{20,-60},{-80,-60}}, color={255,127,0}));
      connect(leakageAroundPoles.flange, cuboidOrthogonalFlux.flange)
        annotation (Line(points={{30,-30},{40,-30},{40,-10},{10,-10}}, color={0,
              127,0}));
      annotation (experiment(StartTime=0, StopTime=1, Interval=1e-3, Tolerance=1e-005), Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));
    end Force;

    model Leakage
      extends Modelica.Icons.Example;
      Modelica.Magnetic.FluxTubes.Shapes.Leakage.QuarterCylinder
        quarterCylinder(l=0.1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-60,-10})));
      Modelica.Magnetic.FluxTubes.Shapes.Leakage.QuarterHollowCylinder
        quarterHollowCylinder(l=0.1, ratio=1) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-40,-10})));
      Modelica.Magnetic.FluxTubes.Shapes.Leakage.HalfCylinder halfCylinder(l=
            0.1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-20,-10})));
      Modelica.Magnetic.FluxTubes.Shapes.Leakage.HalfHollowCylinder
        halfHollowCylinder(l=0.1, ratio=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-10})));
      Modelica.Magnetic.FluxTubes.Shapes.Leakage.QuarterSphere quarterSphere(r=
            0.005) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,-10})));
      Modelica.Magnetic.FluxTubes.Shapes.Leakage.QuarterHollowSphere
        quarterHollowSphere(t=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={40,-10})));
      Modelica.Magnetic.FluxTubes.Shapes.Leakage.EighthOfSphere eighthOfSphere(
          r=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={60,-10})));
      Modelica.Magnetic.FluxTubes.Shapes.Leakage.EighthOfHollowSphere
        eighthOfHollowSphere(t=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={80,-10})));
      Modelica.Magnetic.FluxTubes.Shapes.Leakage.CoaxCylindersEndFaces
        coaxCylindersEndFaces(
        r_0=10e-3,
        r_1=17e-3,
        r_2=20e-3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={100,-10})));
      Modelica.Magnetic.FluxTubes.Sources.ConstantMagneticPotentialDifference
        constantSource(V_m=10) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-100,-10})));
      Modelica.Magnetic.FluxTubes.Basic.Ground ground
        annotation (Placement(transformation(extent={{-110,-60},{-90,-40}})));
    equation

      connect(ground.port, constantSource.port_n) annotation (Line(points={{
              -100,-40},{-100,-30},{-100,-20}}, color={255,127,0}));
      connect(constantSource.port_p, coaxCylindersEndFaces.port_p) annotation (
          Line(points={{-100,0},{-100,20},{100,20},{100,0}}, color={255,127,0}));
      connect(eighthOfHollowSphere.port_p, coaxCylindersEndFaces.port_p)
        annotation (Line(points={{80,0},{80,20},{100,20},{100,0}}, color={255,
              127,0}));
      connect(eighthOfSphere.port_p, coaxCylindersEndFaces.port_p) annotation (
          Line(points={{60,0},{60,20},{100,20},{100,0}}, color={255,127,0}));
      connect(quarterHollowSphere.port_p, coaxCylindersEndFaces.port_p)
        annotation (Line(points={{40,0},{40,20},{100,20},{100,0}}, color={255,
              127,0}));
      connect(quarterSphere.port_p, coaxCylindersEndFaces.port_p) annotation (
          Line(points={{20,0},{20,20},{100,20},{100,0}}, color={255,127,0}));
      connect(halfHollowCylinder.port_p, coaxCylindersEndFaces.port_p)
        annotation (Line(points={{1.77636e-015,0},{0,20},{100,20},{100,0}},
            color={255,127,0}));
      connect(halfCylinder.port_p, coaxCylindersEndFaces.port_p) annotation (
          Line(points={{-20,0},{-20,20},{100,20},{100,0}}, color={255,127,0}));
      connect(quarterHollowCylinder.port_p, coaxCylindersEndFaces.port_p)
        annotation (Line(points={{-40,0},{-40,20},{100,20},{100,0}}, color={255,
              127,0}));
      connect(quarterCylinder.port_p, coaxCylindersEndFaces.port_p) annotation (
         Line(points={{-60,0},{-60,20},{100,20},{100,0}}, color={255,127,0}));
      connect(coaxCylindersEndFaces.port_n, ground.port) annotation (Line(
            points={{100,-20},{100,-40},{-100,-40}}, color={255,127,0}));
      connect(quarterCylinder.port_n, ground.port) annotation (Line(points={{
              -60,-20},{-60,-40},{-100,-40}}, color={255,127,0}));
      connect(quarterHollowCylinder.port_n, ground.port) annotation (Line(
            points={{-40,-20},{-40,-40},{-100,-40}}, color={255,127,0}));
      connect(halfCylinder.port_n, ground.port) annotation (Line(points={{-20,
              -20},{-20,-40},{-100,-40}}, color={255,127,0}));
      connect(halfHollowCylinder.port_n, ground.port) annotation (Line(points={
              {-1.77636e-015,-20},{0,-40},{-100,-40}}, color={255,127,0}));
      connect(quarterSphere.port_n, ground.port) annotation (Line(points={{20,
              -20},{20,-40},{-100,-40}}, color={255,127,0}));
      connect(quarterHollowSphere.port_n, ground.port) annotation (Line(points=
              {{40,-20},{40,-40},{-100,-40}}, color={255,127,0}));
      connect(eighthOfSphere.port_n, ground.port) annotation (Line(points={{60,
              -20},{60,-40},{-100,-40}}, color={255,127,0}));
      connect(eighthOfHollowSphere.port_n, ground.port) annotation (Line(points=
             {{80,-20},{80,-40},{-100,-40}}, color={255,127,0}));
      annotation (experiment(StartTime=0, StopTime=1, Interval=1e-3, Tolerance=1e-005), Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));
    end Leakage;

    model HysteresisAndMagnets
      extends Modelica.Icons.Example;
      Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenSoft
        Core(
        MagRel(fixed=true),
        Js=1.8,
        Br=0.9,
        Hc=120,
        K=1,
        derHstat(fixed=false)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,50})));
      Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenEverett
        Core2(
        MagRel(fixed=true),
        mat=Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter.M330_50A(),
        derHstat(fixed=false)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,50})));

      Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenTable
        Core3(
        MagRel(fixed=true),
        mat=Modelica.Magnetic.FluxTubes.Material.HysteresisTableData.M330_50A(),
        derHstat(fixed=false)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={40,50})));

      Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystPreisachEverett
        Core4(
        MagRel(fixed=true),
        mat=Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter.M330_50A(),
        derHstat(fixed=false)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={60,50})));

      Modelica.Magnetic.FluxTubes.Sources.SignalMagneticPotentialDifference
        signalSource annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-40,50})));
      Modelica.Blocks.Sources.Sine sine(amplitude=100, freqHz=2)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Magnetic.FluxTubes.Basic.Ground ground
        annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
      Modelica.Blocks.Sources.Sine sine1(freqHz=2, amplitude=100000)
        annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
      Modelica.Magnetic.FluxTubes.Sources.SignalMagneticPotentialDifference
        signalSource1 annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-40,-50})));
      Modelica.Magnetic.FluxTubes.Basic.Ground ground1
        annotation (Placement(transformation(extent={{-50,-100},{-30,-80}})));
      Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenHard
        Core1(derHstat(fixed=false), MagRel(fixed=true)) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-50})));
      Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenPermanentMagnet
        PM(MagRel(start=-1), derHstat(fixed=false)) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,-50})));
      Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericLinearPermanentMagnet
        PM1(mat=Modelica.Magnetic.FluxTubes.Material.HardMagnetic.NdFeB())
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={40,-50})));
    equation

      connect(sine.y, signalSource.V_m)
        annotation (Line(points={{-59,50},{-49,50}}, color={0,0,127}));
      connect(ground.port, signalSource.port_n) annotation (Line(points={{-40,
              20},{-40,30},{-40,40}}, color={255,127,0}));
      connect(signalSource.port_p, Core.port_p) annotation (Line(points={{-40,
              60},{-40,80},{0,80},{0,60}}, color={255,127,0}));
      connect(Core2.port_p, Core.port_p) annotation (Line(points={{20,60},{20,
              80},{0,80},{0,60}}, color={255,127,0}));
      connect(Core3.port_p, Core.port_p) annotation (Line(points={{40,60},{40,
              80},{0,80},{0,60}}, color={255,127,0}));
      connect(Core4.port_p, Core.port_p) annotation (Line(points={{60,60},{60,
              80},{0,80},{0,60}}, color={255,127,0}));
      connect(Core.port_n, ground.port) annotation (Line(points={{0,40},{0,40},
              {0,20},{-40,20}}, color={255,127,0}));
      connect(Core2.port_n, ground.port) annotation (Line(points={{20,40},{20,
              20},{-40,20}}, color={255,127,0}));
      connect(Core3.port_n, ground.port) annotation (Line(points={{40,40},{40,
              20},{-40,20}}, color={255,127,0}));
      connect(Core4.port_n, ground.port) annotation (Line(points={{60,40},{60,
              20},{-40,20}}, color={255,127,0}));
      connect(sine1.y, signalSource1.V_m)
        annotation (Line(points={{-59,-50},{-49,-50}}, color={0,0,127}));
      connect(ground1.port, signalSource1.port_n) annotation (Line(points={{-40,
              -80},{-40,-70},{-40,-60}}, color={255,127,0}));
      connect(signalSource1.port_p, Core1.port_p) annotation (Line(points={{-40,
              -40},{-40,-20},{1.77636e-015,-20},{1.77636e-015,-40}}, color={255,
              127,0}));
      connect(Core1.port_n, ground1.port) annotation (Line(points={{
              -1.77636e-015,-60},{0,-60},{0,-80},{-40,-80}}, color={255,127,0}));
      connect(PM.port_p, Core1.port_p) annotation (Line(points={{20,-40},{20,
              -20},{1.77636e-015,-20},{1.77636e-015,-40}}, color={255,127,0}));
      connect(PM1.port_p, Core1.port_p) annotation (Line(points={{40,-40},{40,
              -20},{1.77636e-015,-20},{1.77636e-015,-40}}, color={255,127,0}));
      connect(PM.port_n, ground1.port) annotation (Line(points={{20,-60},{20,
              -80},{-40,-80}}, color={255,127,0}));
      connect(PM1.port_n, ground1.port) annotation (Line(points={{40,-60},{40,
              -80},{-40,-80}}, color={255,127,0}));
      annotation (experiment(StartTime=0, StopTime=1, Interval=1e-3, Tolerance=1e-005), Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));
    end HysteresisAndMagnets;
  end Shapes;

  model Sources
    extends Modelica.Icons.Example;
    Modelica.Magnetic.FluxTubes.Sources.ConstantMagneticPotentialDifference
      constantSource(V_m=15.9) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,40})));
    Modelica.Magnetic.FluxTubes.Sources.SignalMagneticPotentialDifference
      signalSource annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={20,40})));
    Modelica.Magnetic.FluxTubes.Sources.ConstantMagneticFlux constantSource1(
        Phi=2e-4) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,-40})));
    Modelica.Magnetic.FluxTubes.Sources.SignalMagneticFlux signalSource1
      annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={20,-40})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube
      genericFluxTube(
      nonLinearPermeability=false,
      mu_rConst=1000,
      l=0.01,
      area=1e-4) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,40})));
    Modelica.Magnetic.FluxTubes.Basic.Ground ground
      annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube
      genericFluxTube1(
      nonLinearPermeability=false,
      mu_rConst=1000,
      l=0.01,
      area=1e-4) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={60,40})));
    Modelica.Blocks.Sources.Ramp ramp(
      duration=1,
      offset=0,
      startTime=0,
      height=15.9)
      annotation (Placement(transformation(extent={{-6,34},{6,46}})));
    Modelica.Blocks.Sources.Ramp ramp1(
      duration=1,
      offset=0,
      startTime=0,
      height=2e-4)
      annotation (Placement(transformation(extent={{-6,-46},{6,-34}})));
    Modelica.Magnetic.FluxTubes.Basic.Ground ground1
      annotation (Placement(transformation(extent={{10,0},{30,20}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube
      genericFluxTube2(
      nonLinearPermeability=false,
      mu_rConst=1000,
      l=0.01,
      area=1e-4) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,-40})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube
      genericFluxTube3(
      nonLinearPermeability=false,
      mu_rConst=1000,
      l=0.01,
      area=1e-4) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={60,-40})));
    Modelica.Magnetic.FluxTubes.Basic.Ground ground2
      annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
    Modelica.Magnetic.FluxTubes.Basic.Ground ground3
      annotation (Placement(transformation(extent={{10,-80},{30,-60}})));
  equation

    connect(constantSource.port_n, ground.port) annotation (Line(points={{-80,
            30},{-80,30},{-80,20}}, color={255,127,0}));
    connect(constantSource.port_p, genericFluxTube.port_p) annotation (Line(
          points={{-80,50},{-80,60},{-40,60},{-40,50}}, color={255,127,0}));
    connect(genericFluxTube.port_n, ground.port) annotation (Line(points={{-40,
            30},{-40,20},{-80,20}}, color={255,127,0}));
    connect(signalSource.port_p, genericFluxTube1.port_p) annotation (Line(
          points={{20,50},{20,60},{60,60},{60,50}}, color={255,127,0}));
    connect(signalSource.V_m, ramp.y)
      annotation (Line(points={{11,40},{6.6,40}}, color={0,0,127}));
    connect(constantSource1.port_p, genericFluxTube2.port_p) annotation (Line(
          points={{-80,-30},{-80,-30},{-80,-20},{-40,-20},{-40,-30}}, color={
            255,127,0}));
    connect(signalSource.port_n, ground1.port)
      annotation (Line(points={{20,30},{20,25},{20,20}}, color={255,127,0}));
    connect(genericFluxTube1.port_n, ground1.port)
      annotation (Line(points={{60,30},{60,20},{20,20}}, color={255,127,0}));
    connect(ramp1.y, signalSource1.Phi)
      annotation (Line(points={{6.6,-40},{11,-40}}, color={0,0,127}));
    connect(signalSource1.port_p, genericFluxTube3.port_p) annotation (Line(
          points={{20,-30},{20,-20},{60,-20},{60,-30}}, color={255,127,0}));
    connect(genericFluxTube3.port_n, ground3.port) annotation (Line(points={{60,
            -50},{60,-60},{20,-60}}, color={255,127,0}));
    connect(signalSource1.port_n, ground3.port) annotation (Line(points={{20,
            -50},{20,-50},{20,-60}}, color={255,127,0}));
    connect(constantSource1.port_n, ground2.port) annotation (Line(points={{-80,
            -50},{-80,-55},{-80,-60}}, color={255,127,0}));
    connect(genericFluxTube2.port_n, ground2.port) annotation (Line(points={{
            -40,-50},{-40,-60},{-80,-60}}, color={255,127,0}));
    annotation (experiment(StartTime=0, StopTime=1, Interval=1e-3, Tolerance=1e-005), Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}})));
  end Sources;

  model Sensors
    extends Modelica.Icons.Example;
    Modelica.Magnetic.FluxTubes.Sources.SignalMagneticPotentialDifference
      signalSource annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-30,20})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube
      genericFluxTube(
      nonLinearPermeability=false,
      mu_rConst=1000,
      l=0.01,
      area=1e-4) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={30,20})));
    Modelica.Blocks.Sources.Ramp ramp(
      duration=1,
      offset=0,
      startTime=0,
      height=15.9)
      annotation (Placement(transformation(extent={{-56,14},{-44,26}})));
    Modelica.Magnetic.FluxTubes.Basic.Ground ground1
      annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
    Modelica.Magnetic.FluxTubes.Sensors.MagneticPotentialDifferenceSensor
      magneticPotentialDifferenceSensor annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={54,20})));
    Modelica.Magnetic.FluxTubes.Sensors.MagneticFluxSensor magneticFluxSensor
      annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  equation

    connect(signalSource.V_m, ramp.y)
      annotation (Line(points={{-39,20},{-43.4,20}}, color={0,0,127}));
    connect(signalSource.port_n, ground1.port)
      annotation (Line(points={{-30,10},{-30,5},{-30,0}}, color={255,127,0}));
    connect(genericFluxTube.port_n, ground1.port)
      annotation (Line(points={{30,10},{30,0},{-30,0}}, color={255,127,0}));
    connect(magneticPotentialDifferenceSensor.port_n, ground1.port)
      annotation (Line(points={{54,10},{54,0},{-30,0}}, color={255,127,0}));
    connect(magneticFluxSensor.port_p, signalSource.port_p) annotation (Line(
          points={{-10,40},{-30,40},{-30,30}}, color={255,127,0}));
    connect(magneticFluxSensor.port_n, genericFluxTube.port_p)
      annotation (Line(points={{10,40},{30,40},{30,30}}, color={255,127,0}));
    connect(magneticPotentialDifferenceSensor.port_p, genericFluxTube.port_p)
      annotation (Line(points={{54,30},{54,40},{30,40},{30,30}}, color={255,127,
            0}));
    annotation (experiment(StartTime=0, StopTime=1, Interval=1e-3, Tolerance=1e-005), Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}})));
  end Sensors;
end FluxTubes;
