within Modelica.Electrical.PowerConverters.DCAC.Control;
block IntersectivePWM "Intersective PWM"
  extends Modelica.Blocks.Icons.Block;
  import Modelica.Electrical.PowerConverters.Types.ReferenceType;
  constant Integer m=3 "Number of phases";
  parameter SI.Frequency f "Switching frequency";
  parameter SI.Time startTime=0 "Start time of PWM";
  parameter Real uMax "Maximum amplitude of signal";
  parameter PowerConverters.Types.ReferenceType refType=PowerConverters.Types.ReferenceType.Triangle3
    "Type of reference signal" annotation (Evaluate=true);
  Modelica.Blocks.Interfaces.RealInput u[2] "Reference space phasor"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_p[m] "Positive fire signal"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_n[m] "Negative fire signal"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.FromSpacePhasor
    fromSpacePhasor(final m=m)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Sources.Constant zero(final k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,30})));
  Modelica.Blocks.Sources.SawTooth sawTooth[m](
    each final nperiod=-1,
    each final amplitude=uMax,
    each final offset=-uMax/2,
    each final period=1/f,
    final startTime={startTime - 1.5 + (if refType == ReferenceType.Sawtooth1
         then 0 else k)/m for k in 0:m - 1}/f)
         if (refType==ReferenceType.Sawtooth1 or refType==ReferenceType.Sawtooth3)
      annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid[3](
    each final amplitude=uMax,
    each final width=0,
    each final nperiod=-1,
    each final offset=-uMax/2,
    each final rising=0.5/f,
    each final falling=0.5/f,
    each final period=1/f,
    final startTime={startTime - 1.25 + (if refType == ReferenceType.Triangle1
         then 0 else k)/m for k in 0:m - 1}/f)
         if (refType==ReferenceType.Triangle1 or refType==ReferenceType.Triangle3)
      annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual[m]
    annotation (Placement(transformation(extent={{30,50},{50,70}})));
  Modelica.Blocks.Logical.Not negation[m]
    annotation (Placement(transformation(extent={{72,-70},{92,-50}})));
  Modelica.Blocks.Logical.Switch switch1[m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant const[m](each k=-uMax) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-30})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=time >=
        startTime)
    annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout=m)
    annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
equation
  connect(u, fromSpacePhasor.u) annotation (Line(points={{-120,0},{-90,0},{-90,60},
          {-62,60}}, color={0,0,127}));
  connect(zero.y, fromSpacePhasor.zero)
    annotation (Line(points={{-70,41},{-70,52},{-62,52}}, color={0,0,127}));
  connect(fromSpacePhasor.y, greaterEqual.u1)
    annotation (Line(points={{-39,60},{28,60}}, color={0,0,127}));
  connect(greaterEqual.y, fire_p)
    annotation (Line(points={{51,60},{110,60}}, color={255,0,255}));
  connect(negation.y, fire_n)
    annotation (Line(points={{93,-60},{110,-60}}, color={255,0,255}));
  connect(greaterEqual.y, negation.u) annotation (Line(points={{51,60},{60,60},{
          60,-60},{70,-60}}, color={255,0,255}));
  connect(switch1.y, greaterEqual.u2)
    annotation (Line(points={{11,0},{20,0},{20,52},{28,52}}, color={0,0,127}));
  connect(sawTooth.y, switch1.u1) annotation (Line(points={{-59,-20},{-50,-20},{
          -50,8},{-12,8}}, color={0,0,127}));
  connect(trapezoid.y, switch1.u1) annotation (Line(points={{-59,-50},{-50,-50},
          {-50,8},{-12,8}}, color={0,0,127}));
  connect(const.y, switch1.u3)
    annotation (Line(points={{-20,-19},{-20,-8},{-12,-8}}, color={0,0,127}));
  connect(booleanReplicator.y, switch1.u2) annotation (Line(points={{-49,-80},{-40,
          -80},{-40,0},{-12,0}}, color={255,0,255}));
  connect(booleanExpression.y, booleanReplicator.u)
    annotation (Line(points={{-79,-80},{-72,-80}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-60,0},{-51.6,34.2},{-46.1,53.1},{-41.3,66.4},{-37.1,74.6},{-32.9,
              79.1},{-28.64,79.8},{-24.42,76.6},{-20.201,69.7},{-15.98,59.4},{-11.16,
              44.1},{-5.1,21.2},{7.5,-30.8},{13,-50.2},{17.8,-64.2},{22,-73.1},{
              26.2,-78.4},{30.5,-80},{34.7,-77.6},{38.9,-71.5},{43.1,-61.9},{47.9,
              -47.2},{54,-24.8},{60,0}},
          color={0,0,255},
          thickness=0.5,
          smooth=Smooth.Bezier), Line(points={{-60,-80},{-48,80},{-40,-80},{-30,
              80},{-20,-80},{-10,80},{0,-80},{10,80},{20,-78},{30,80},{40,-80},{
              50,80},{60,-80}}, color={238,46,47})}),    Documentation(info="<html>
<p>
The intersective PWM transforms the input space phasor <u>u</u> to the three-phase voltages,
and compares them with the reference signals.
As long as the phase voltage is greater than the corresponding reference signal, the corresponding fire signal is true.
The switching pattern of the negative fire signal is just the inverse of the positive fire signal.
</p>
<p>
The user can choose from 4 different reference signals:
</p>
<ul>
<li>Sawtooth1: sawtooth signal, same phase in all three phases</li>
<li>Sawtooth3: sawtooth signal, phase shift between the three phases = period/3</li>
<li>Triangle1: triangle signal, same phase in all three phases</li>
<li>Triangle3: triangle signal, phase shift between the three phases = period/3</li>
</ul>
</html>"));
end IntersectivePWM;
