within Modelica.Electrical.PowerConverters.ACDC.Control;
model VoltageBridge2Pulse "Control of 2 pulse bridge rectifier"
  import Modelica.Constants.pi;
  extends Icons.Control;
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
  parameter SI.Voltage vStart=0
    "Start voltage of filter output"
    annotation (Dialog(tab="Filter", enable=useFilter));
  Modelica.Blocks.Interfaces.RealInput firingAngle(unit="rad") if not
    useConstantFiringAngle "Firing angle" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Signal2mPulse twoPulse(
    final useConstantFiringAngle=useConstantFiringAngle,
    final f=f,
    final constantFiringAngle=constantFiringAngle,
    final firingAngleMax=firingAngleMax,
    final m=1,
    final useFilter=useFilter,
    final fCut=fCut,
    final vStart=fill(vStart, 1)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin ac_p
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin ac_n
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,0})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_p annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,110})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_n annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,110})));
equation
  connect(voltageSensor.v, twoPulse.v[1]) annotation (Line(
      points={{-69,0},{-12,0}},
               color={0,0,127}));
  connect(voltageSensor.p, ac_p) annotation (Line(
      points={{-80,10},{-80,60},{-100,60}}, color={0,0,255}));
  connect(voltageSensor.n, ac_n) annotation (Line(
      points={{-80,-10},{-80,-60},{-100,-60}}, color={0,0,255}));
  connect(firingAngle, twoPulse.firingAngle) annotation (Line(
      points={{0,-120},{0,-12}}, color={0,0,127}));
  connect(twoPulse.fire_n[1], fire_n) annotation (Line(
      points={{6,11},{6,80},{60,80},{60,110}}, color={255,0,255}));
  connect(twoPulse.fire_p[1], fire_p) annotation (Line(
      points={{-6,11},{-6,80},{-60,80},{-60,110}}, color={255,0,255}));
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
                textString="2")}),
    Documentation(revisions="<html>
</html>",
    info="<html>

<p>
General information about controllers is summarized in
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control\">Control</a>.
</p>

<p>
This model provides two firing signal for Graetz bridge thyristor and half bridge rectifiers. The boolean
signal <code>fire_p</code> is assigned to the thyristors connected with the positive DC output pin.
The boolean
signal <code>fire_n</code> is assigned to the thyristors connected with the negative DC output pin.
</p>
</html>"));
end VoltageBridge2Pulse;
