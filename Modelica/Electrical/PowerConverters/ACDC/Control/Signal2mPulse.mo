within Modelica.Electrical.PowerConverters.ACDC.Control;
block Signal2mPulse "Generic control of 2*m pulse rectifiers"
  import Modelica.Constants.pi;
  extends PowerConverters.Icons.Control;
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  parameter Boolean useConstantFiringAngle=true
    "Use constant firing angle instead of signal input";
  parameter SI.Angle constantFiringAngle=0 "Firing angle"
    annotation (Dialog(enable=useConstantFiringAngle));
  parameter Boolean useFilter=true "Enable use of filter"
    annotation (Dialog(tab="Filter"));
  parameter SI.Frequency f=50 "Frequency";
  parameter SI.Frequency fCut=2*f
    "Cut off frequency of filter"
    annotation (Dialog(tab="Filter", enable=useFilter));
  parameter SI.Voltage vStart[m]=zeros(m)
    "Start voltage of filter output"
    annotation (Dialog(tab="Filter", enable=useFilter));
  Modelica.Blocks.Interfaces.RealInput firingAngle(unit="rad") if not
    useConstantFiringAngle "Firing angle" annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={0,-120})));
  parameter SI.Angle firingAngleMax(
    final min=0, final max=pi) = Modelica.Constants.pi
    "Maximum firing angle";
  parameter SI.Angle firingAngleMin(
    final min=0, final max=pi) = 0
    "Minimum firing angle";
  Modelica.Blocks.Sources.Constant constantconstantFiringAngle(final k=
        constantFiringAngle) if useConstantFiringAngle annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-30,-80})));
  Modelica.Blocks.Logical.GreaterThreshold positiveThreshold[m](threshold=
       zeros(m)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-60,-20})));
  Modelica.Blocks.Logical.LessThreshold negativeThreshold[m](threshold=
        zeros(m)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={60,-20})));
  Modelica.Blocks.Logical.Timer timerPositive[m] annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-60,10})));
  Modelica.Blocks.Logical.Timer timerNegative[m] annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={60,10})));
  Modelica.Blocks.Logical.Greater greaterPositive[m] annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-60,80})));
  Modelica.Blocks.Logical.Greater greaterNegative[m] annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={60,80})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_p[m] annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,110})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_n[m] annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,110})));
  Modelica.Blocks.Math.Gain gain(final k=1/pi)     annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,10})));
  Modelica.Blocks.Routing.Replicator replicator(final nout=m) annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,40})));
  Modelica.Blocks.Nonlinear.Limiter limiter(final uMax=min(firingAngleMax, pi),
      final uMin=max(firingAngleMin, 0))
                                       annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,-20})));
  Modelica.Blocks.Interfaces.RealInput v[m](each unit="V") "Voltages" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        origin={-120,0})));
  Filter filter[m](
    each final f=f,
    each final fCut=fCut,
    yStart=vStart) if useFilter annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-80,-80})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough[m] if not
    useFilter "Pass through in case filter is off"
    annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));
  Modelica.Blocks.Math.Gain gainPositive[m](each final k=2*f) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-60,40})));
  Modelica.Blocks.Math.Gain gainNegative[m](each final k=2*f) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={60,40})));
equation
  assert(firingAngleMax>firingAngleMin,
    "Signal2mPulse: firingAngleMax has to be greater than firingAngleMin");
  connect(positiveThreshold.y, timerPositive.u) annotation (Line(
      points={{-60,-9},{-60,-2}}, color={255,0,255}));
  connect(negativeThreshold.y, timerNegative.u) annotation (Line(
      points={{60,-9},{60,-2}}, color={255,0,255}));
  connect(greaterPositive.y, fire_p) annotation (Line(
      points={{-60,91},{-60,110}}, color={255,0,255}));
  connect(greaterNegative.y, fire_n)
    annotation (Line(points={{60,91},{60,110}}, color={255,0,255}));
  connect(gain.y, replicator.u) annotation (Line(
      points={{0,21},{0,28}}, color={0,0,127}));
  connect(replicator.y, greaterPositive.u2) annotation (Line(
      points={{0,51},{0,60},{-52,60},{-52,68}}, color={0,0,127}));
  connect(replicator.y, greaterNegative.u2)
    annotation (Line(points={{0,51},{0,60},{52,60},{52,68}}, color={0,0,127}));
  connect(limiter.y, gain.u) annotation (Line(
      points={{0,-9},{0,-2}}, color={0,0,127}));
  connect(firingAngle, limiter.u) annotation (Line(
      points={{0,-120},{0,-32}}, color={0,0,127}));
  connect(constantconstantFiringAngle.y, limiter.u) annotation (Line(
      points={{-19,-80},{0,-80},{0,-32}}, color={0,0,127}));
  connect(v, filter.u) annotation (Line(
      points={{-120,0},{-100,0},{-100,-80},{-92,-80}}, color={0,0,127}));
  connect(filter.y, positiveThreshold.u) annotation (Line(
      points={{-69,-80},{-60,-80},{-60,-32}},color={0,0,127}));
  connect(filter.y, negativeThreshold.u) annotation (Line(
      points={{-69,-80},{-60,-80},{-60,-50},{60,-50},{60,-32}},
                    color={0,0,127}));
  connect(realPassThrough.u, v) annotation (Line(
      points={{-92,-50},{-100,-50},{-100,0},{-120,0}}, color={0,0,127}));
  connect(realPassThrough.y, positiveThreshold.u) annotation (Line(
      points={{-69,-50},{-60,-50},{-60,-32}},color={0,0,127}));
  connect(realPassThrough.y, negativeThreshold.u) annotation (Line(
      points={{-69,-50},{60,-50},{60,-32}},                    color={0,0,127}));
  connect(timerPositive.y, gainPositive.u)
    annotation (Line(points={{-60,21},{-60,28}}, color={0,0,127}));
  connect(gainPositive.y, greaterPositive.u1)
    annotation (Line(points={{-60,51},{-60,68}}, color={0,0,127}));
  connect(gainNegative.y, greaterNegative.u1)
    annotation (Line(points={{60,51},{60,68}}, color={0,0,127}));
  connect(timerNegative.y, gainNegative.u)
    annotation (Line(points={{60,21},{60,28}}, color={0,0,127}));
  annotation (defaultComponentName="adaptor",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),graphics={Line(
                points={{-40,-20},{-40,-24},{-20,-24},{-20,-40},{-40,-40},
            {-40,-60}},
                color={255,0,255}),Line(
                points={{20,-20},{20,-44},{40,-44},{40,-60},{20,-60},{20,
            -60}},
                color={255,0,255}),Text(
                extent={{-40,60},{40,0}},
                textColor={255,0,255},
                textString="2*%m%")}),
    Documentation(revisions="<html>
</html>",
    info="<html>

<p>
General information about controllers is summarized in
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control\">Control</a>.
</p>
</html>"));
end Signal2mPulse;
