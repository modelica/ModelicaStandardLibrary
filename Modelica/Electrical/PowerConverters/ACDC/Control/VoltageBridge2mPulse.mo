within Modelica.Electrical.PowerConverters.ACDC.Control;
model VoltageBridge2mPulse "Control of 2*m pulse bridge rectifier"
  import Modelica.Constants.pi;
  extends Icons.Control;
  parameter Integer m(final min=3) = 3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Frequency f=50 "Frequency";
  parameter Boolean useConstantFiringAngle=true
    "Use constant firing angle instead of signal input";
  parameter SI.Angle constantFiringAngle=0 "Firing angle"
    annotation (Dialog(enable=useConstantFiringAngle));
  parameter SI.Angle firingAngleMax(
    final min=0,
    final max=Modelica.Constants.pi) = Modelica.Constants.pi
    "Maximum firing angle";
  parameter Boolean useFilter=true "Enable use of filter"
    annotation (Dialog(tab="Filter"));
  parameter SI.Frequency fCut=2*f
    "Cut off frequency of filter"
    annotation (Dialog(tab="Filter", enable=useFilter));
  parameter SI.Voltage vStart[m]=zeros(m)
    "Start voltage of filter output"
    annotation (Dialog(tab="Filter", enable=useFilter));
  Modelica.Blocks.Interfaces.RealInput firingAngle(unit="rad") if not
    useConstantFiringAngle "Firing angle" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Signal2mPulse twomPulse(
    final useConstantFiringAngle=useConstantFiringAngle,
    final f=f,
    final constantFiringAngle=constantFiringAngle,
    final firingAngleMax=firingAngleMax,
    final m=m,
    useFilter=useFilter,
    final fCut=fCut,
    final vStart=vStart) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={0,10})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac(final m=m)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Polyphase.Basic.MultiDelta delta(final m=m)
    "Delta connection" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-80,10})));
  Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor(
      final m=m) "Voltage sensor" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-44,10})));
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
equation
  connect(ac, voltageSensor.plug_p) annotation (Line(
      points={{-100,0},{-44,0}}, color={0,0,255}));
  connect(voltageSensor.plug_p, delta.plug_n) annotation (Line(
      points={{-44,0},{-80,0}}, color={0,0,255}));
  connect(delta.plug_p, voltageSensor.plug_n) annotation (Line(
      points={{-80,20},{-44,20}}, color={0,0,255}));
  connect(voltageSensor.v, twomPulse.v) annotation (Line(
      points={{-33,10},{-12,10}}, color={0,0,127}));
  connect(firingAngle, twomPulse.firingAngle) annotation (Line(
      points={{0,-120},{0,-2}}, color={0,0,127}));
  connect(twomPulse.fire_n, fire_n) annotation (Line(
      points={{6,21},{6,80},{60,80},{60,110}}, color={255,0,255}));
  connect(twomPulse.fire_p, fire_p) annotation (Line(
      points={{-6,21},{-6,80},{-60,80},{-60,110}}, color={255,0,255}));
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
    Documentation(info="<html>

<p>
General information about controllers is summarized in
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control\">Control</a>.
</p>

<p>
Half of the semiconductors of the <code>2*m</code> pulse bridge rectifier are connected with the positive DC output pin (firing signal <code>fire_p</code>). The other half of the semiconductors is connected with the negative DC output pin (firing signal <code>fire_n</code>). Parameter <code>m</code> indicates the number of phases.
</p>
</html>",
    revisions="<html>
</html>"));
end VoltageBridge2mPulse;
