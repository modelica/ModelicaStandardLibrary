within Modelica.Mechanics.Rotational.Examples;
model CompareBrakingTorque "Compare different braking torques"
  extends Modelica.Icons.Example;
  parameter SI.Inertia J=1 "Moment of inertia";
  parameter SI.AngularVelocity w_start=100 "Initial speed of inertia";
  parameter SI.Torque tau_nominal=100 "Nominal torque";
  parameter SI.AngularVelocity w_nominal=abs(w_start) "Nominal speed";
  parameter SI.AngularVelocity w0=1 "Speed limit for regularization";
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(
    J=J,
    phi(fixed=true, start=0),
    w(fixed=true, start=w_start))
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Mechanics.Rotational.Sources.SignTorque signTorque(
    tau_nominal=-tau_nominal,
    reg=Modelica.Blocks.Types.Regularization.Linear,
    w0=w0)   annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2(
    J=J,
    phi(fixed=true, start=0),
    w(fixed=true, start=w_start))
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
    linearSpeedDependentTorque(
    tau_nominal=-tau_nominal,
    TorqueDirection=false,
    w_nominal=w_nominal)
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia3(
    J=J,
    phi(fixed=true, start=0),
    w(fixed=true, start=w_start))
    annotation (Placement(transformation(extent={{-8,-30},{12,-10}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticSpeedDependentTorque(
    tau_nominal=-tau_nominal,
    TorqueDirection=false,
    w_nominal=w_nominal)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia4(
    J=J,
    phi(fixed=true, start=0),
    w(fixed=true, start=w_start))
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Modelica.Mechanics.Rotational.Sources.InverseSpeedDependentTorque
    inverseSpeedDependentTorque(
    tau_nominal=-tau_nominal,
    TorqueDirection=false,
    w_nominal=w_nominal,
    w0=w0) annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
equation
  connect(signTorque.flange, inertia1.flange_a)
    annotation (Line(points={{-20,60},{-10,60}}, color={0,0,0}));
  connect(linearSpeedDependentTorque.flange, inertia2.flange_a)
    annotation (Line(points={{-20,20},{-10,20}}, color={0,0,0}));
  connect(quadraticSpeedDependentTorque.flange, inertia3.flange_a)
    annotation (Line(points={{-20,-20},{-8,-20}}, color={0,0,0}));
  connect(inverseSpeedDependentTorque.flange, inertia4.flange_a)
    annotation (Line(points={{-20,-60},{-10,-60}}, color={0,0,0}));
  annotation (
    experiment(
      StopTime=5,
      Interval=0.0001),
    Documentation(info="<html>
<p>
Compare the effect of different braking torques on inertia&apos;s angular velocity
(<code>inertiaN.w</code>, N = {1, 2, 3, 4}):
</p>
<ol>
<li>Constant torque</li>
<li>Linear speed dependent torque</li>
<li>Quadratic speed dependent torque</li>
<li>Inverse speed dependent torque</li>
</ol>
</html>"));
end CompareBrakingTorque;
