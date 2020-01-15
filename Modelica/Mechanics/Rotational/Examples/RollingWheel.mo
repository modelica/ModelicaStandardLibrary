within Modelica.Mechanics.Rotational.Examples;
model RollingWheel "Demonstrate coupling Rotational - Translational"
  extends Modelica.Icons.Example;
  Rotational.Components.IdealRollingWheel idealRollingWheel(radius=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Rotational.Components.Inertia inertia(
    J=1,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Rotational.Sources.TorqueStep torqueStep(
    stepTorque=10,
    offsetTorque=0,
    startTime=0.1,
    useSupport=false)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Translational.Components.Mass mass(L=0, m=1)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Translational.Sources.QuadraticSpeedDependentForce
    quadraticSpeedDependentForce(
    f_nominal=-10,
    ForceDirection=false,
    v_nominal=5)
    annotation (Placement(transformation(extent={{72,-10},{52,10}})));
equation

  connect(torqueStep.flange, inertia.flange_a) annotation (Line(
      points={{-50,0},{-40,0}}));
  connect(inertia.flange_b, idealRollingWheel.flangeR) annotation (Line(
      points={{-20,0},{-10,0}}));
  connect(idealRollingWheel.flangeT, mass.flange_a) annotation (Line(
      points={{10,0},{20,0}}, color={0,127,0}));
  connect(quadraticSpeedDependentForce.flange, mass.flange_b) annotation (
      Line(
      points={{52,0},{40,0}}, color={0,127,0}));
  annotation (Documentation(info="<html>
<p>
This model demonstrates the coupling between rotational and translational components:<br>
A torque (step) accelerates both the inertia (of the wheel) and the mass (of the vehicle).<br>
Du to a speed dependent force (like driving resistance), we find an equilibrium at 5 m/s after approx. 5 s.
</p>
</html>"),
       experiment(StopTime=5.0, Interval=0.001));
end RollingWheel;
