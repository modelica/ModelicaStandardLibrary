within ModelicaTest.Magnetic.QuasiStatic;
package FluxTubes "Test examples of Modelica.Magnetic.QuasiStatic.FluxTubes"
  extends Modelica.Icons.ExamplesPackage;
  model NoPhysicalTestLeakage "Testing leakage models"
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    parameter Modelica.SIunits.RelativePermeability mu_rConst = 100 "Relative permeability";

    output Modelica.SIunits.ComplexMagneticFlux Phi1 = magFluxSensor1.Phi "Flux of circuit 1";
    output Modelica.SIunits.ComplexMagneticFlux Phi2 = magFluxSensor1.Phi "Flux of circuit 2";

    Modelica.Magnetic.QuasiStatic.FluxTubes.Sources.ConstantMagneticPotentialDifference constantSource1(f=50,
      gamma(fixed=true, start=0),
      V_m(re=200, im=-100))                                                                                                      annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.Ground ground1 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-90,10})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage.QuarterHollowCylinder quarterHollowCylinder(ratio=0.3, l=0.1) annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage.HalfCylinder halfCylinder(l=0.1) annotation (Placement(transformation(extent={{-20,30},{0,50}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage.HalfHollowCylinder halfHollowCylinder(ratio=0.3, l=0.1) annotation (Placement(transformation(extent={{10,30},{30,50}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Sources.ConstantMagneticPotentialDifference constantSource2(f=50,
      gamma(start=0, fixed=true),
      V_m(re=200, im=-100))                                                                                                      annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
    Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.Ground ground2 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
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
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})),
      experiment(Interval=0.001, StartTime=0, StopTime=1, Tolerance=1e-06));
  end NoPhysicalTestLeakage;
end FluxTubes;
