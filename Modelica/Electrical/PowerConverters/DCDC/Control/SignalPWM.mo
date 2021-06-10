within Modelica.Electrical.PowerConverters.DCDC.Control;
model SignalPWM
  "Generates a pulse width modulated (PWM) boolean fire signal"
  extends Icons.Control;
  import Modelica.Electrical.PowerConverters.Types.SingleReferenceType;
  parameter Boolean useConstantDutyCycle=true
    "Enables constant duty cycle";
  parameter Real constantDutyCycle=0 "Constant duty cycle"
    annotation (Dialog(enable=useConstantDutyCycle));
  parameter SI.Frequency f=1000 "Switching frequency";
  parameter SingleReferenceType refType=Modelica.Electrical.PowerConverters.Types.SingleReferenceType.Sawtooth
    "Type of reference signal";
  parameter SI.Time startTime=0 "Start time";
  Modelica.Blocks.Interfaces.RealInput dutyCycle if not
    useConstantDutyCycle "Duty cycle"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput fire "Firing PWM signal"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,110})));
  Modelica.Blocks.Interfaces.BooleanOutput notFire "Firing PWM signal"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,110})));
  Modelica.Blocks.Sources.Constant const(final k=constantDutyCycle) if
    useConstantDutyCycle
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Logical.Less greaterEqual annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        origin={22,-8})));
  Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold(final startTime=
        startTime, final samplePeriod=1/f)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Sources.SawTooth sawtooth(
    final period=1/f,
    final amplitude=1,
    final nperiod=-1,
    final offset=0,
    final startTime=startTime) if refType==SingleReferenceType.Sawtooth
    annotation (Placement(transformation(origin={-50,-50}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Trapezoid triangle(
    rising=0.5/f,
    width=0,
    falling=0.5/f,
    final period=1/f,
    final amplitude=1,
    final nperiod=-1,
    final offset=0,
    final startTime=startTime) if refType==SingleReferenceType.Triangle
    annotation (Placement(transformation(origin={-50,-80}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Logical.Not inverse annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={52,20})));
equation
  connect(const.y, limiter.u) annotation (Line(
      points={{-79,-50},{-70,-50},{-70,0},{-62,0}}, color={0,0,127}));
  connect(dutyCycle, limiter.u) annotation (Line(
      points={{-120,0},{-62,0}}, color={0,0,127}));
  connect(limiter.y, zeroOrderHold.u) annotation (Line(
      points={{-39,0},{-32,0}}, color={0,0,127}));
  connect(zeroOrderHold.y, greaterEqual.u2) annotation (Line(
      points={{-9,0},{10,0}}, color={0,0,127}));
  connect(sawtooth.y, greaterEqual.u1) annotation (Line(
      points={{-39,-50},{0,-50},{0,-8},{10,-8}}, color={0,0,127}));
  connect(greaterEqual.y, inverse.u) annotation (Line(
      points={{33,-8},{52,-8},{52,8}}, color={255,0,255}));
  connect(greaterEqual.y, fire) annotation (Line(
      points={{33,-8},{36,-8},{36,80},{-60,80},{-60,110}}, color={255,0,255}));
  connect(inverse.y, notFire) annotation (Line(
      points={{52,31},{52,80},{60,80},{60,110}}, color={255,0,255}));
  connect(greaterEqual.u1, triangle.y) annotation (Line(points={{10,-8},{0,-8},{
          0,-80},{-39,-80}}, color={0,0,127}));
  annotation (defaultComponentName="pwm",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),graphics={Line(
                points={{-100,0},{-98,0},{12,0}},
                color={0,0,255}),Line(
                points={{-60,-22},{-60,-64},{44,-64},{44,-36}},
                color={0,0,255}),Line(
                points={{-80,-16},{-80,-20},{-40,20},{-40,-20},{-36,-16}},
                color={0,0,255}),Line(
                points={{-62,0},{-76,4},{-76,-4},{-62,0}},
                color={0,0,255}),Line(
                points={{44,-36},{44,-36},{40,-50},{44,-50},{48,-50},{44,
            -36}},
                color={0,0,255}),Line(
                points={{20,-20},{22,-20},{24,-20},{24,20},{44,20},{44,-20},
            {64,-20},{64,-16}},
                color={255,0,255}),Line(
                points={{-40,-16},{-40,-20},{0,20},{0,-20},{4,-16}},
                color={0,0,255}),Line(
                points={{60,-20},{62,-20},{64,-20},{64,20},{84,20},{84,-20},
            {84,-20},{88,-20}},
                color={255,0,255})}),
    Documentation(info="<html>
<p>
This controller can be used both for DC/DC and AC/DC converters.
The signal input of the PWM controller is the duty cycle; the duty cycle is the ratio of the on time
to the switching period. The output firing signal is strictly determined by the actual duty cycle, indicated as <code>d</code> in Fig.&nbsp;1.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Firing (<code>fire</code>) and inverse firing (<code>notFire</code>) signal of PWM control; <code>d</code> = duty cycle; <code>f</code> = switching frequency </caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/PowerConverters/dutyCycle.png\">
    </td>
  </tr>
</table>

<p>
The firing signal is generated by comparing the sampled duty cycle input with a periodic saw tooth signal [<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.References\">Williams2006</a>].
</p>
</html>"));
end SignalPWM;
