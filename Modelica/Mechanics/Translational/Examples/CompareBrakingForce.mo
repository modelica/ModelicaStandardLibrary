within Modelica.Mechanics.Translational.Examples;
model CompareBrakingForce "Compare different braking forces"
  extends Modelica.Icons.Example;
  parameter SI.Mass m=1 "Mass";
  parameter SI.Velocity v_start=100 "Initial speed of mass";
  parameter SI.Force f_nominal=100 "Nominal force";
  parameter SI.Velocity v_nominal=abs(v_start) "Nominal speed";
  parameter SI.Velocity v0=1 "Speed limit for regularization";
  Modelica.Mechanics.Translational.Components.Mass mass1(
    m=m,
    s(fixed=true, start=0),
    v(fixed=true, start=v_start))
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Mechanics.Translational.Sources.SignForce signForce(
    f_nominal=-f_nominal,
    reg=Modelica.Blocks.Types.Regularization.Linear,
    v0=v0)   annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Mechanics.Translational.Components.Mass mass2(
    m=m,
    s(fixed=true, start=0),
    v(fixed=true, start=v_start))
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Mechanics.Translational.Sources.LinearSpeedDependentForce
    linearSpeedDependentForce(
    f_nominal=-f_nominal,
    ForceDirection=false,
    v_nominal=v_nominal)
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Mechanics.Translational.Components.Mass mass3(
    m=m,
    s(fixed=true, start=0),
    v(fixed=true, start=v_start))
    annotation (Placement(transformation(extent={{-8,-30},{12,-10}})));
  Modelica.Mechanics.Translational.Sources.QuadraticSpeedDependentForce
    quadraticSpeedDependentForce(
    f_nominal=-f_nominal,
    ForceDirection=false,
    v_nominal=v_nominal)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Mechanics.Translational.Components.Mass mass4(
    m=m,
    s(fixed=true, start=0),
    v(fixed=true, start=v_start))
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Modelica.Mechanics.Translational.Sources.InverseSpeedDependentForce
    inverseSpeedDependentForce(
    f_nominal=-f_nominal,
    ForceDirection=false,
    v_nominal=v_nominal,
    v0=v0) annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
equation
  connect(signForce.flange, mass1.flange_a)
    annotation (Line(points={{-20,60},{-10,60}}, color={0,127,0}));
  connect(linearSpeedDependentForce.flange, mass2.flange_a)
    annotation (Line(points={{-20,20},{-10,20}}, color={0,127,0}));
  connect(quadraticSpeedDependentForce.flange, mass3.flange_a)
    annotation (Line(points={{-20,-20},{-8,-20}}, color={0,127,0}));
  connect(inverseSpeedDependentForce.flange, mass4.flange_a)
    annotation (Line(points={{-20,-60},{-10,-60}}, color={0,127,0}));
  annotation (
    experiment(
      StopTime=5,
      Interval=0.0001),
    Documentation(info="<html>
<p>
Compare the effect of different braking forces on mass&apos; velocity
(<code>massN.v</code>, N = {1, 2, 3, 4}):
</p>
<ol>
<li>Constant force</li>
<li>Linear speed dependent force</li>
<li>Quadratic speed dependent force</li>
<li>Inverse speed dependent force</li>
</ol>
</html>"));
end CompareBrakingForce;
