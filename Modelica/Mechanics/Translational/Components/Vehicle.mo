within Modelica.Mechanics.Translational.Components;
model Vehicle "Simple vehicle model"
  parameter SI.Mass m "Total mass of vehicle";
  parameter SI.Acceleration g=Modelica.Constants.g_n "Constant gravity acceleration";
  parameter SI.Inertia J "Total rotational inertia of drive train";
  parameter SI.Length R "Wheel radius";
  parameter SI.Area A(start=1) "Cross section of vehicle"
    annotation(Dialog(tab="Driving resistances", group="Drag resistance"));
  parameter Real Cd(start=0.5) "Drag resistance coefficient"
    annotation(Dialog(tab="Driving resistances", group="Drag resistance"));
  parameter SI.Density rho=1.2 "Density of air"
    annotation(Dialog(tab="Driving resistances", group="Drag resistance"));
  parameter Boolean useWindInput=false "Enable signal input for wind velocity"
    annotation(Dialog(tab="Driving resistances", group="Drag resistance"));
  parameter SI.Velocity vWindConstant=0 "Constant wind velocity"
    annotation(Dialog(tab="Driving resistances", group="Drag resistance", enable=not useWindInput));
  parameter Boolean useCrInput=false "Enable signal input for Cr"
    annotation(Dialog(tab="Driving resistances", group="Rolling resistance"));
  parameter Real CrConstant=0.015 "Constant rolling resistance coefficient"
    annotation(Dialog(tab="Driving resistances", group="Rolling resistance", enable=not useCrInput));
  parameter SI.Velocity vReg=1e-3 "Velocity for regularization around 0"
    annotation(Dialog(tab="Driving resistances", group="Rolling resistance"));
  parameter Boolean useInclinationInput=false "Enable signal input for inclination"
    annotation(Dialog(tab="Driving resistances", group="Inclination resistance"));
  parameter Real inclinationConstant=0 "Constant inclination = tan(angle)"
    annotation(Dialog(tab="Driving resistances", group="Inclination resistance", enable=not useInclinationInput));
  SI.Position s(displayUnit="km", start=0)=mass.s "Position of vehicle";
  SI.Velocity v(displayUnit="km/h", start=0)=mass.v "Velocity of vehicle";
  SI.Acceleration a=mass.a "Acceleration of vehicle";
protected
  constant SI.Velocity vRef=1 "Reference velocity for air drag";
public
  Sources.QuadraticSpeedDependentForce fDrag(
    final useSupport=true,
    final f_nominal=-Cd*A*rho*vRef^2/2,
    final ForceDirection=false,
    final v_nominal=vRef) "Drag resistance"
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  RollingResistance fRoll(
    final fWeight=m*g,
    final useCrInput=useCrInput,
    final CrConstant=CrConstant,
    final useInclinationInput=useInclinationInput,
    final inclinationConstant=inclinationConstant,
    final reg=Modelica.Blocks.Types.Regularization.Linear,
    final v0=vReg) "Rolling resistance"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={60,0})));
  Sources.Force fGrav "Inclination resistance"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={60,30})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flangeT "Translational flange"
    annotation (Placement(transformation(extent={{90,10},{110,-10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flangeR "Rotational flange"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Rotational.Components.Inertia inertia(final J=J)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  IdealRollingWheel idealRollingWheel(final radius=R)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Mass mass(final m=m) annotation (Placement(transformation(extent={{30,50},
            {50,70}})));
  Modelica.Blocks.Interfaces.RealInput inclination if useInclinationInput
    "Inclination=tan(angle)"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.RealInput cr if useCrInput
    "Rolling resistance coefficient"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealInput vWind(unit="m/s") if useWindInput
    "Wind velocity"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Sources.Speed windSpeed(s(fixed=true))  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-60})));
  Blocks.Math.Gain gravForceGain(final k=-m*g) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={20,30})));
protected
  Modelica.Blocks.Sources.Constant constInclination(k=inclinationConstant) if not useInclinationInput
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-80,-90})));
  Modelica.Blocks.Sources.Constant constWindSpeed(k=vWindConstant) if not useWindInput
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={40,-90})));
public
  Blocks.Math.Atan atan annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-40,30})));
  Blocks.Math.Sin sin annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-10,30})));

equation
  connect(idealRollingWheel.flangeT, mass.flange_a)
    annotation (Line(points={{10,60},{30,60}},
                                             color={0,127,0}));
  connect(constWindSpeed.y, windSpeed.v_ref)
    annotation (Line(points={{51,-90},{60,-90},{60,-72}}, color={0,0,127}));
  connect(vWind, windSpeed.v_ref)
    annotation (Line(points={{60,-120},{60,-72}}, color={0,0,127}));
  connect(fDrag.support, windSpeed.flange)
    annotation (Line(points={{60,-40},{60,-50}}, color={0,127,0}));
  connect(mass.flange_b, flangeT) annotation (Line(points={{50,60},{80,60},{80,0},{100,0}},
                    color={0,127,0}));
  connect(sin.u, atan.y)
    annotation (Line(points={{-22,30},{-29,30}},   color={0,0,127}));
  connect(gravForceGain.u, sin.y) annotation (Line(points={{8,30},{1,30}},     color={0,0,127}));
  connect(gravForceGain.y, fGrav.f)
    annotation (Line(points={{31,30},{48,30}}, color={0,0,127}));
  connect(mass.flange_b, fDrag.flange) annotation (Line(points={{50,60},{80,60},{80,-30},{70,-30}},
                                  color={0,127,0}));
  connect(mass.flange_b, fRoll.flange) annotation (Line(points={{50,60},{80,60},{80,0},{70,0}},
                              color={0,127,0}));
  connect(mass.flange_b, fGrav.flange) annotation (Line(points={{50,60},{80,60},{80,30},{70,30}},
                                color={0,127,0}));
  connect(inertia.flange_b, idealRollingWheel.flangeR)
    annotation (Line(points={{-30,60},{-10,60}}, color={0,0,0}));
  connect(flangeR, inertia.flange_a) annotation (Line(points={{-100,0},{-80,0},{
          -80,60},{-50,60}}, color={0,0,0}));
  connect(cr,fRoll.cr)
    annotation (Line(points={{0,-120},{0,-6},{48,-6}}, color={0,0,127}));
  connect(inclination, fRoll.inclination)
    annotation (Line(points={{-60,-120},{-60,6},{48,6}}, color={0,0,127}));
  connect(inclination, atan.u) annotation (Line(points={{-60,-120},{-60,30},
          {-52,30}}, color={0,0,127}));
  connect(atan.u, constInclination.y) annotation (Line(points={{-52,30},{
          -60,30},{-60,-90},{-69,-90}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
    Line(points={{-80,-70},{80,-70}}, color={0,127,0}),
    Line(points={{-80,0},{85.607,-1.19754}},
      color={0,127,0}, origin={-3,-49}, rotation=15),
    Ellipse(extent={{-130,-120},{-30,-20}}, lineColor={0,127,0},
      startAngle=0, endAngle=15,
      closure=EllipseClosure.None),
    Polygon(points={{-70,15},{-70,-25},{50,-25},{50,15},{38,25},{-60,25},{-70,15}},
      lineColor={0,127,0}, fillColor={160,215,160}, fillPattern=FillPattern.Solid, origin={0,-9}, rotation=15),
    Line(points={{-40,0},{40,0}}, color={95,127,95}, origin={-40,32}, rotation=15),
    Polygon(points={{15,0},{-15,10},{-15,-10},{15,0}}, lineColor={95,127,95}, fillColor={95,127,95},
      fillPattern = FillPattern.Solid, origin={11,46}, rotation=15),
    Text(extent={{-150,100},{150,60}}, textString="%name", textColor={0,0,255}),
    Polygon(points={{-20,0},{0,10},{0,4},{20,4},{20,-4},{0,-4},{0,-10},{-20,0}}, lineColor={0,127,0}, fillColor={160,215,160},
      fillPattern = FillPattern.Solid, origin={68,18}, rotation=15),
    Text(
      extent={{-80,-80},{-40,-100}},
      textColor={64,64,64},
      textString="inc."),
    Text(
      extent={{-20,-80},{20,-100}},
      textColor={64,64,64},
      textString="cr"),
    Text(
      extent={{30,-80},{90,-100}},
      textColor={64,64,64},
      textString="wind"),
    Ellipse(extent={{-50,-34},{-26,-58}},lineColor={0,127,0}, fillPattern=FillPattern.Sphere, fillColor={160,215,160}),
    Ellipse(extent={{20,-16},{44,-40}},  lineColor={0,127,0}, fillPattern=FillPattern.Sphere, fillColor={160,215,160}),
    Ellipse(extent={{26,-22},{38,-34}},  lineColor={0,127,0}, fillPattern=FillPattern.Solid,
      fillColor={255,255,255}),
    Ellipse(extent={{-44,-40},{-32,-52}},lineColor={0,127,0}, fillPattern=FillPattern.Solid,
      fillColor={255,255,255})}),
    Documentation(info="<html>
<p>
This is a simple model of a&nbsp;ground vehicle, comprising the mass, the aerodynamic drag, the rolling resistance and
the inclination resistance (caused by the road grade).
For all particular resistances, significant variables can be either given by a&nbsp;parameter or input by a&nbsp;time-variable signal.
</p>
<p>
The vehicle can be driven at the rotational flange <code>flangeR</code>, e.g. by an electric motor and a&nbsp;gearbox.
It is possible to use the vehicle as a&nbsp;passive trailer, leaving the rotational flange <code>flangeR</code> unconnected.
</p>
<p>
At the translational flange <code>flangeT</code> the vehicle can be coupled with another vehicle,
e.g. as a&nbsp;trailer or to pull a&nbsp;trailer.
It is possible to leave the translational flange <code>flangeT</code> unconnected.
</p>
<p>
The velocity&nbsp;<code>v</code> and the driven distance&nbsp;<code>s</code> of the vehicle are provided as variables;
the vehicle can be initialized using these variables.
</p>

<h4>Mass and inertia</h4>
<p>
Both the translational vehicle mass and the rotational inertias (e.g. the wheels)
are accelerated when the vehicle is accelerated.
This nature is usually put into account for fundamental vehicle analyses
done either in the rotational or translational domain, e.g. when analysing
vehicle&apos;s driveline.
Then, the vehicle mass&nbsp;<code>m</code> can be expressed as an additional
equivalent inertia <code>J_eq&nbsp;=&nbsp;m&nbsp;*&nbsp;R<sup>2</sup></code> or
vice versa rotational inertia&nbsp;<code>J</code> as an additional
equivalent mass <code>m_eq&nbsp;=&nbsp;J/R<sup>2</sup></code>,
where&nbsp;<code>R</code> is the wheel radius.
Since this model introduces rolling resistance and inclination resistance as well
where just the vehicle mass plays a&nbsp;role,
the approach of equivalent mass/inertia would lead to incorrect simulation results
and shall therefore not be applied here.
</p>

<h4>Drag resistance</h4>
<blockquote>
<pre>
fDrag = Cd*rho*A*(v - vWind)^2/2
</pre>
</blockquote>
<p>
Wind velocity is measured in the same direction as velocity of <code>flangeT</code>.
Wind velocity is either constant or prescribed by the input <code>vWind</code>.
</p>

<h4>Rolling resistance</h4>
<blockquote>
<pre>
fRoll = Cr*m*g*cos(alpha)
</pre>
</blockquote>
<p>
Rolling resistance coefficient&nbsp;<var>Cr</var> is either constant
or prescribed by the input <code>cr</code>.
Rolling resistance has a&nbsp;crossover from positive to negative velocity within <code>[-vReg,&nbsp;vReg]</code>.
</p>
<p>
The inclination angle&nbsp;<var>&alpha;</var> is either constant or prescribed by
the input <code>inclination</code> = tan(<var>&alpha;</var>).
This corresponds to the road rise over running distance of 100&nbsp;m which,
in general, is written as a&nbsp;percentage.
For example for a&nbsp;road rising by 10&nbsp;m over 100&nbsp;m the
grade&nbsp;=&nbsp;10&nbsp;% and, thus, the parameter
<code>inclinationConstant&nbsp;=&nbsp;0.1</code>.
Positive inclination means driving uphill, negative inclination means
driving downhill, in case of positive vehicle velocity.
</p>

<h4>Inclination resistance</h4>
<blockquote>
<pre>
fGrav = m*g*sin(alpha)
</pre>
</blockquote>
<p>
With the inclination angle&nbsp;<var>&alpha;</var> described above.
</p>
</html>"));
end Vehicle;
