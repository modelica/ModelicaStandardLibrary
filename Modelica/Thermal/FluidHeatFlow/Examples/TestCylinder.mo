within Modelica.Thermal.FluidHeatFlow.Examples;
model TestCylinder "Two cylinder system"
  extends Modelica.Icons.Example;
  output SI.Force f1=-10*cylinder1.f "10 x Force on piston 1";
  output SI.Position s1=0.1*cylinder1.s "0.1 x Position of piston 1";
  output SI.Position s2=cylinder2.s "Position of piston 2";
  output SI.Force f2=-cylinder2.f "Force on piston 2";
  output SI.Force f=springDamper.f "Force of springDamper";
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,0; 0.25,-1; 0.5,0; 0.75,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Mechanics.Translational.Sources.Force force
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  FluidHeatFlow.Components.Cylinder cylinder1(
    A=0.1,
    L=10,
    s(fixed=true, start=cylinder1.L/2),
    T0=313.15,
    T0fixed=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,0})));
  FluidHeatFlow.Components.Cylinder cylinder2(
    T(fixed=true),
    A=1,
    L=1,
    T0=313.15,
    T0fixed=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={10,0})));
  Modelica.Mechanics.Translational.Components.Mass mass(m=1)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Mechanics.Translational.Components.SpringDamper springDamper(
    s_rel0=cylinder2.L/2,
    c=100,
    s_rel(fixed=true, start=cylinder2.L/2),
    v_rel(fixed=true, start=0),
    d=10) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Mechanics.Translational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
equation
  connect(cylinder1.flowPort, cylinder2.flowPort) annotation (Line(points={
          {-10,-1.33227e-15},{-4,-1.33227e-15},{-4,0},{0,0}}, color={255,0,0}));
  connect(force.flange, cylinder1.flange) annotation (Line(points={{-40,0},
          {-34,0},{-34,1.33227e-15},{-30,1.33227e-15}}, color={0,127,0}));
  connect(combiTimeTable.y[1], force.f)
    annotation (Line(points={{-69,0},{-62,0}}, color={0,0,127}));
  connect(cylinder2.flange, mass.flange_a)
    annotation (Line(points={{20,0},{30,0}}, color={0,127,0}));
  connect(springDamper.flange_b, mass.flange_b)
    annotation (Line(points={{60,0},{50,0}}, color={0,127,0}));
  connect(springDamper.flange_a, fixed.flange)
    annotation (Line(points={{80,0},{90,0}}, color={0,127,0}));
  annotation (Documentation(info="<html>
<p>
Test of a system with 2 cylinders (with same volume):
</p>
<ul>
<li>cylinder1: A = 0.1 m2, L=10. m, initial position of piston at s=L/2</li>
<li>cylinder2: A = 1.0 m2, L=1.0 m, initial position of piston at s=L/2</li>
</ul>
<p>
A force is applied that presses from 0.25 s to 0.50 s with 1 Nm on piston1.
Due to the ratio of areas 10:1
</p>
<ul>
<li>the force at piston2 is ten times the force at piston1</li>
<li>movement of piston1 is ten times the movement of piston2</li>
</ul>
<p>
At piston2 a mass is mounted which is moved and presses the springDamper.
When the force at piston1 is removed, the springDamper pushes back the mass and a damped oscillation occurs.
</p>
<p>
Note: Take care of the initial conditions. The unstretched spring length is cylinder2.L/2,
i.e. when piston2 is the middle of its cylinder the spring applies no force to the mass (and piston2).
</p>
</html>"), experiment(StopTime=2, Interval=0.001));
end TestCylinder;
