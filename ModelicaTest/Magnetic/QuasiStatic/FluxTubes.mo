within ModelicaTest.Magnetic.QuasiStatic;
package FluxTubes "Test examples of Modelica.Magnetic.QuasiStatic.FluxTubes"
  extends Modelica.Icons.ExamplesPackage;
  model NoPhysicalTestLeakage "Testing leakage models"
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    parameter SI.RelativePermeability mu_rConst = 100 "Relative permeability";

    output SI.ComplexMagneticFlux Phi1 = magFluxSensor1.Phi "Flux of circuit 1";
    output SI.ComplexMagneticFlux Phi2 = magFluxSensor1.Phi "Flux of circuit 2";

    Modelica.Magnetic.QuasiStatic.FluxTubes.Sources.ConstantMagneticPotentialDifference constantSource1(f=50,
      gamma(fixed=true, start=0),
      V_m(re=200, im=-100)) annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.Ground ground1 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          origin={-90,10})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage.QuarterHollowCylinder quarterHollowCylinder(ratio=0.3, l=0.1) annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage.HalfCylinder halfCylinder(l=0.1) annotation (Placement(transformation(extent={{-20,30},{0,50}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage.HalfHollowCylinder halfHollowCylinder(ratio=0.3, l=0.1) annotation (Placement(transformation(extent={{10,30},{30,50}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Sources.ConstantMagneticPotentialDifference constantSource2(f=50,
      gamma(start=0, fixed=true),
      V_m(re=200, im=-100)) annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.Ground ground2 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          origin={-90,-70})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage.QuarterSphere quarterSphere(r=0.005) annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage.QuarterHollowSphere quarterHollowSphere(t=0.2) annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage.EighthOfSphere eighthOfSphere(r=0.01) annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage.EighthOfHollowSphere eighthOfHollowSphere(t=0.2) annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage.CoaxCylindersEndFaces coaxCylindersEndFaces(
      r_0=10e-3,
      r_1=17e-3,
      r_2=20e-3) annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors.MagneticFluxSensor magFluxSensor1 annotation (Placement(transformation(extent={{-60,80},{-40,60}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors.MagneticFluxSensor magFluxSensor2 annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  equation
    connect(ground1.port, constantSource1.port_p) annotation (Line(
        points={{-90,20},{-90,40},{-80,40}},
        color={255,170,85}));
    connect(constantSource1.port_n, quarterHollowCylinder.port_p) annotation (
        Line(
        points={{-60,40},{-50,40}},
        color={255,170,85}));
    connect(quarterHollowCylinder.port_n, halfCylinder.port_p) annotation (Line(
        points={{-30,40},{-20,40}},
        color={255,170,85}));
    connect(halfCylinder.port_n, halfHollowCylinder.port_p) annotation (Line(
        points={{0,40},{10,40}},
        color={255,170,85}));
    connect(ground2.port, constantSource2.port_p) annotation (Line(
        points={{-90,-60},{-90,-40},{-80,-40}},
        color={255,170,85}));
    connect(constantSource2.port_n, quarterSphere.port_p) annotation (Line(
        points={{-60,-40},{-50,-40}},
        color={255,170,85}));
    connect(quarterSphere.port_n, quarterHollowSphere.port_p) annotation (Line(
        points={{-30,-40},{-20,-40}},
        color={255,170,85}));
    connect(quarterHollowSphere.port_n, eighthOfSphere.port_p) annotation (Line(
        points={{0,-40},{10,-40}},
        color={255,170,85}));
    connect(eighthOfSphere.port_n, eighthOfHollowSphere.port_p) annotation (Line(
        points={{30,-40},{40,-40}},
        color={255,170,85}));
    connect(eighthOfHollowSphere.port_n, coaxCylindersEndFaces.port_p)
      annotation (Line(
        points={{60,-40},{70,-40}},
        color={255,170,85}));
    connect(magFluxSensor1.port_p, constantSource1.port_p) annotation (Line(points={{-60,70},{-90,70},{-90,40},{-80,40}}, color={255,170,85}));
    connect(magFluxSensor1.port_n, halfHollowCylinder.port_n) annotation (Line(points={{-40,70},{40,70},{40,40},{30,40}}, color={255,170,85}));
    connect(magFluxSensor2.port_p, constantSource2.port_p) annotation (Line(points={{-60,-10},{-90,-10},{-90,-40},{-80,-40}}, color={255,170,85}));
    connect(magFluxSensor2.port_n, coaxCylindersEndFaces.port_n) annotation (Line(points={{-40,-10},{90,-10},{90,-40}}, color={255,170,85}));
    annotation (experiment(Interval=0.001, StartTime=0, StopTime=1, Tolerance=1e-06));
  end NoPhysicalTestLeakage;

  model VariableComponents "Test of reluctance and permeance model with signal inputs"
    extends Modelica.Icons.Example;
    Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.VariableReluctance reluctance annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={40,0})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.VariablePermeance permeance annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={20,0})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.Ground ground annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Sources.ConstantMagneticFlux magFluxSource(
      gamma(fixed=true),
      f=50,
      Phi=Complex(1, 0)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-40,0})));
    Modelica.Blocks.Sources.Ramp rampPermeance(
      height=1,
      duration=0.3,
      offset=0,
      startTime=0.6) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    Modelica.Blocks.Sources.Ramp rampReluctance(
      height=1,
      duration=0.3,
      offset=0,
      startTime=0.1) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  equation
    connect(rampPermeance.y, permeance.G_m) annotation (Line(points={{1,0},{8,0}}, color={0,0,127}));
    connect(reluctance.R_m, rampReluctance.y) annotation (Line(points={{52,-2.22045e-15},{56,-2.22045e-15},{56,0},{59,0}}, color={0,0,127}));
    connect(magFluxSource.port_p, ground.port) annotation (Line(points={{-40,-10},{-40,-30},{0,-30}}, color={255,170,85}));
    connect(ground.port, permeance.port_n) annotation (Line(points={{0,-30},{20,-30},{20,-10}}, color={255,170,85}));
    connect(ground.port, reluctance.port_n) annotation (Line(points={{0,-30},{40,-30},{40,-10}}, color={255,170,85}));
    connect(magFluxSource.port_n, permeance.port_p) annotation (Line(points={{-40,10},{-40,30},{20,30},{20,10}}, color={255,170,85}));
    connect(reluctance.port_p, permeance.port_p) annotation (Line(points={{40,10},{40,30},{20,30},{20,10}}, color={255,170,85}));
    annotation (experiment(StopTime=1));
  end VariableComponents;
end FluxTubes;
