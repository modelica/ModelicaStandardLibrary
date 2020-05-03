within Modelica.Magnetic.QuasiStatic.FluxTubes.Examples.Leakage;
model GeneralLeakage "Magnetic circuit with generic leakage mode"
  extends Modelica.Icons.Example;
  Basic.ConstantReluctance constantReluctance(R_m=1E-5)
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Basic.LeakageWithCoefficient leakageWithCoefficient(c_usefulFlux=0.7,
                                                      R_mUsefulTot=1E-5)
    annotation (Placement(transformation(extent={{20,10},{0,30}})));
  Basic.EddyCurrent eddyCurrent(useConductance=true, G=10000) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,40})));
  Sources.ConstantMagneticPotentialDifference constantSource(
    gamma(fixed=true, start=0), f=50, V_m(re=100, im=0))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,40})));
  Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
equation
  connect(constantReluctance.port_p, constantSource.port_p) annotation (Line(
      points={{0,60},{-20,60},{-20,50}},
      color={255,170,85}));
  connect(constantReluctance.port_n, eddyCurrent.port_p) annotation (Line(
      points={{20,60},{40,60},{40,50}},
      color={255,170,85}));
  connect(eddyCurrent.port_n, leakageWithCoefficient.port_p) annotation (Line(
      points={{40,30},{40,20},{20,20}},
      color={255,170,85}));
  connect(leakageWithCoefficient.port_n, constantSource.port_n) annotation (
      Line(
      points={{0,20},{-20,20},{-20,30}},
      color={255,170,85}));
  connect(ground.port, constantSource.port_n) annotation (Line(
      points={{-20,0},{-20,30}},
      color={255,170,85}));
  annotation (
    experiment(StopTime=1,Interval=0.001),
  Documentation(info="<html>
<p>Magnetic circuit with two reluctances, leakage reluctance,  and eddy current loss.</p>
</html>"));
end GeneralLeakage;
