within Modelica.Mechanics.Translational.Examples;
model Vehicle "One-dimensional vehicle with driving resistances"
  extends Modelica.Icons.Example;
  import Modelica.Constants.g_n;
  parameter SI.Mass m=100 "Mass of vehicle";
  parameter SI.Length R=0.25 "Radius of wheel";
  parameter SI.Area A=1 "Cross section of vehicle";
  parameter Real Cd=0.5 "Drag resistance coefficient";
  parameter SI.Density rho=1.18 "Density of air";
  parameter SI.Velocity vWind=0 "Constant wind velocity";
  parameter Real Cr=0.01 "Rolling resistance coefficient";
  //Check nominal force
  parameter Real inclination=0 "Constant inclination = tan(angle)";
  parameter SI.Velocity vNom=25/3.5 "Nominal velocity";
  final parameter SI.Force fDrag=Cd*A*rho*(vNom - vWind)^2/2 "Drag resistance"
    annotation(Dialog(enable=false));
  final parameter SI.Angle alpha=atan(inclination) "Inclination angle"
    annotation(Dialog(enable=false));
  final parameter SI.Force fRoll=Cr*m*g_n*cos(alpha) "Roll resistance"
    annotation(Dialog(enable=false));
  final parameter SI.Force fGrav=m*g_n*sin(alpha) "Grav resistance"
  annotation(Dialog(enable=false));
  Components.Vehicle vehicle(
    m=m,
    J=0,
    R=R,
    A=A,
    Cd=Cd,
    CrConstant=Cr,
    vWindConstant=vWind,
    useInclinationInput=true,
    s(fixed=true),
    v(fixed=true))
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Components.Vehicle vehicle1(
    m=m,
    J=0,
    R=R,
    A=A,
    Cd=Cd,
    CrConstant=Cr,
    vWindConstant=vWind,
    useInclinationInput=true,
    s(fixed=true),
    v(fixed=true))
    annotation (Placement(transformation(extent={{30,40},{50,60}})));
  Components.Vehicle trailer(
    m=m,
    J=0,
    R=R,
    A=A,
    Cd=Cd,
    CrConstant=Cr,
    vWindConstant=vWind,
    useInclinationInput=true,
    s(fixed=false),
    v(fixed=false)) annotation (Placement(transformation(extent={{70,40},{90,60}})));
  Modelica.Mechanics.Translational.Sensors.MultiSensor multiSensor
    annotation (Placement(transformation(extent={{60,84},{80,64}})));
  Modelica.Blocks.Sources.CombiTimeTable timeTableTorqueInclination(
    table=[0,0,0; 5,0,0; 5,5.6,0; 10.8,5.6,0; 10.8,1,0; 20,1,0; 20,2.8,0.05;
           25,2.8,0.05; 25,1,0; 50,1,0; 50,-5,0; 55,-5,0; 55,0,0; 60,0,0],
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Rotational.Sources.Torque torque1
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Math.Gain gain(k=(fDrag + fRoll + fGrav)*R)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Blocks.Math.Gain gain1(k=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,30})));
equation
  connect(timeTableTorqueInclination.y[1], gain.u)
    annotation (Line(points={{-59,0},{-42,0}}, color={0,0,127}));
  connect(timeTableTorqueInclination.y[2], vehicle.inclination)
    annotation (Line(points={{-59,0},{-50,0},{-50,-20},{34,-20},{34,-12}}, color={0,0,127}));
  connect(gain.y, torque.tau)
    annotation (Line(points={{-19,0},{-2,0}}, color={0,0,127}));
  connect(torque.flange, vehicle.flangeR)
    annotation (Line(points={{20,0},{30,0}}, color={0,0,0}));
  connect(torque1.flange, vehicle1.flangeR)
    annotation (Line(points={{20,50},{30,50}}, color={0,0,0}));
  connect(vehicle.inclination, vehicle1.inclination) annotation (Line(
        points={{34,-12},{34,-20},{60,-20},{60,30},{34,30},{34,38}}, color=
          {0,0,127}));
  connect(vehicle1.inclination, trailer.inclination) annotation (Line(points={{34,38},{34,30},{74,30},{74,38}}, color={0,0,127}));
  connect(gain.y, gain1.u)
    annotation (Line(points={{-19,0},{-10,0},{-10,18}}, color={0,0,127}));
  connect(gain1.y, torque1.tau)
    annotation (Line(points={{-10,41},{-10,50},{-2,50}}, color={0,0,127}));
  connect(vehicle1.flangeT, multiSensor.flange_a)
    annotation (Line(points={{50,50},{50,74},{60,74}}, color={0,127,0}));
  connect(multiSensor.flange_b, trailer.flangeT) annotation (Line(points={{80,74},{90,74},{90,50}}, color={0,127,0}));
  annotation (experiment(StopTime=60, Interval=0.01), Documentation(info="<html>
<p>
Vehicles <code>vehicle</code> and <code>vehicle1</code> are accelerated
and decelerated by a&nbsp;driving torque.
Nominal torque is defined as the sum of driving resistances at nominal
velocity <code>vNom</code> times wheel radius&nbsp;<code>R</code>.
</p>
<p>
Starting at 5&nbsp;s, the <code>vehicle</code> is accelerated by a&nbsp;multiple of nominal torque until it nearly reaches nominal velocity, then driven by nominal torque.
Between 20&nbsp;s and 25&nbsp;s, an inclination of 5&nbsp;% occurs and driving torque is increased to a&nbsp;multiple of nominal torque temporarily.
Between 50&nbsp;s and 55&nbsp;s, the driving torque is set below zero, causing the vehicle to decelerate.
After 55&nbsp;s, the vehicle decelerates due to the driving resistances.
</p>
<p>
Coupling the <code>trailer</code> with the same data but without drive,
the driving torque of <code>vehicle1</code> has to be doubled to achieve the same acceleration and velocity.
Force and power between the two vehicles is measured.
</p>

<h4>Note</h4>
<p>
Since the <code>trailer</code> is coupled tightly with the <code>vehicle1</code>,
initialization of the trailer has to be removed.
</p>
</html>"));
end Vehicle;
