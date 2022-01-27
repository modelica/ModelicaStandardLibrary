within Modelica.Electrical.PowerConverters.DCAC.Control;
block PWM "Pulse width modulation"
  extends Modelica.Blocks.Icons.Block;
  constant Integer m=3 "Number of phases";
  parameter PowerConverters.Types.PWMType pwmType=PowerConverters.Types.PWMType.SVPWM
    "PWM Type" annotation (Evaluate=true);
  parameter SI.Frequency f "Switching frequency";
  parameter SI.Time startTime=0 "Start time of PWM";
  parameter Real uMax "Maximum amplitude of signal";
  parameter PowerConverters.Types.ReferenceType refType=PowerConverters.Types.ReferenceType.Triangle3
    "Type of reference signal" annotation (Evaluate=true, Dialog(enable=pwmType
           == PowerConverters.Types.PWMType.Intersective));
  Modelica.Blocks.Interfaces.RealInput u[2] "Reference space phasor"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_p[m] "Positive fire signal"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_n[m] "Negative fire signal"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  PowerConverters.DCAC.Control.SVPWM svPWM(
    f=f,
    startTime=startTime,
    uMax=uMax) if pwmType == PowerConverters.Types.PWMType.SVPWM
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  PowerConverters.DCAC.Control.IntersectivePWM intersectivePWM(
    f=f,
    startTime=startTime,
    uMax=uMax,
    refType=refType) if pwmType == PowerConverters.Types.PWMType.Intersective
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
equation
  connect(u, svPWM.u) annotation (Line(points={{-120,0},{-60,0},{-60,40},{-12,40}},
        color={0,0,127}));
  connect(u, intersectivePWM.u) annotation (Line(points={{-120,0},{-60,0},{-60,-40},
          {-12,-40}}, color={0,0,127}));
  connect(svPWM.fire_p, fire_p) annotation (Line(points={{11,46},{40,46},{40,60},
          {110,60}}, color={255,0,255}));
  connect(intersectivePWM.fire_p, fire_p) annotation (Line(points={{11,-34},{40,
          -34},{40,60},{110,60}}, color={255,0,255}));
  connect(svPWM.fire_n, fire_n) annotation (Line(points={{11,34},{60,34},{60,-60},
          {110,-60}}, color={255,0,255}));
  connect(intersectivePWM.fire_n, fire_n) annotation (Line(points={{11,-46},{60,
          -46},{60,-60},{110,-60}}, color={255,0,255}));
  annotation (defaultComponentName="pwm", Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-70,80},{70,40}},
          textString="P W M"), Text(
          extent={{-70,-40},{70,-80}},
          textString="f=%f"), Text(
          extent={{-70,20},{70,-20}},
          textString="%pwmType")}),    Documentation(info="<html>
<p>
Let the user choose the PWM type from:
</p>
<ul>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.SVPWM\">Space vector pulse width modulation</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.IntersectivePWM\">Intersective pulse width modulation</a></li>
</ul>
</html>"));
end PWM;
