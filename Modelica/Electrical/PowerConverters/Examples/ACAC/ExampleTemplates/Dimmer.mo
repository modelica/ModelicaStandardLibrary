within Modelica.Electrical.PowerConverters.Examples.ACAC.ExampleTemplates;
partial model Dimmer "Dimmer including control"
  extends Icons.ExampleTemplate;
  import Modelica.Constants.pi;
  parameter SI.Frequency f=50 "Source frequency";
  parameter SI.Voltage Vrms=110 "RMS source voltage";
  parameter SI.ApparentPower S=1000 "Load apparent power";
  parameter Real powerFactor(final min=0, final max=1)=0.87 "Load power factor";
  parameter SI.Impedance ZLoad=Vrms^2/S "Load impedance";
  parameter SI.Resistance RLoad=ZLoad*powerFactor "Load resistance";
  parameter SI.Inductance LLoad=ZLoad*sqrt(1 - powerFactor^2)/(2*pi*f) "Load inductance";
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(final V=sqrt(2)*
        Vrms, f=f) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,10})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-90,-40},{-70,-20}})));
  PowerConverters.ACAC.SinglePhaseTriac triac(Ron=1e-9, Goff=1e-9)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-60,10})));
  PowerConverters.ACDC.Control.Signal2mPulse adaptor(
    m=1,
    useConstantFiringAngle=false,
    f=f) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Electrical.Analog.Sensors.MultiSensor multiSensor
    annotation (Placement(transformation(extent={{10,30},{30,50}})));
  PowerConverters.ACAC.Control.VoltageToAngle voltageToAngle(VNominal=1,
      voltage2Angle=PowerConverters.Types.Voltage2AngleType.RMS) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-40})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=1,
    rising=2,
    width=2,
    falling=2,
    period=8,
    nperiod=1,
    offset=0,
    startTime=1)
    annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));
  Modelica.Blocks.Math.Mean meanPower(f=f) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,10})));
  Modelica.Blocks.Math.RootMeanSquare vRMS(f=f)
    annotation (Placement(transformation(extent={{70,-60},{90,-40}})));
  Modelica.Blocks.Math.Harmonic vH01(f=f, k=1)
    annotation (Placement(transformation(extent={{70,-90},{90,-70}})));
  Modelica.Blocks.Math.RootMeanSquare iRMS(f=f)
    annotation (Placement(transformation(extent={{30,-60},{50,-40}})));
  Modelica.Blocks.Math.Harmonic iH01(f=f, k=1)
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
equation
  connect(sineVoltage.n, ground.p)
    annotation (Line(points={{-80,0},{-80,-20}},   color={0,0,255}));
  connect(ground.p, voltageSensor.n) annotation (Line(points={{-80,-20},
          {-60,-20},{-60,0}}, color={0,0,255}));
  connect(voltageSensor.v, adaptor.v[1])
    annotation (Line(points={{-49,10},{-42,10}}, color={0,0,127}));
  connect(sineVoltage.p, triac.p)
    annotation (Line(points={{-80,20},{-80,40},{-40,40}}, color={0,0,255}));
  connect(triac.p, voltageSensor.p) annotation (Line(points={{-40,40},{
          -60,40},{-60,20}}, color={0,0,255}));
  connect(adaptor.fire_p[1], triac.fire1)
    annotation (Line(points={{-36,21},{-36,28}}, color={255,0,255}));
  connect(adaptor.fire_n[1], triac.fire2)
    annotation (Line(points={{-24,21},{-24,28}}, color={255,0,255}));
  connect(triac.n, multiSensor.pc)
    annotation (Line(points={{-20,40},{10,40}},  color={0,0,255}));
  connect(multiSensor.pc, multiSensor.pv)
    annotation (Line(points={{10,40},{10,50},{20,50}},  color={0,0,255}));
  connect(voltageToAngle.firingAngle, adaptor.firingAngle)
    annotation (Line(points={{-30,-29},{-30,-2}}, color={0,0,127}));
  connect(trapezoid.y, voltageToAngle.vRef)
    annotation (Line(points={{-49,-70},{-30,-70},{-30,-52}}, color={0,0,127}));
  connect(multiSensor.power, meanPower.u) annotation (Line(points={{9,
          34},{0,34},{0,22}}, color={0,0,127}));
  connect(ground.p, multiSensor.nv) annotation (Line(points={{-80,-20},
          {20,-20},{20,30}}, color={0,0,255}));
  connect(multiSensor.i, iRMS.u) annotation (Line(points={{14,29},{14,
          -50},{28,-50}}, color={0,0,127}));
  connect(multiSensor.i, iH01.u) annotation (Line(points={{14,29},{14,
          -80},{28,-80}}, color={0,0,127}));
  connect(multiSensor.v, vRMS.u) annotation (Line(points={{26,29},{26,
          -30},{60,-30},{60,-50},{68,-50}}, color={0,0,127}));
  connect(multiSensor.v, vH01.u) annotation (Line(points={{26,29},{26,
          -30},{60,-30},{60,-80},{68,-80}}, color={0,0,127}));
  annotation (Documentation(
        info="<html>
<p>Dimmer example template including supply and sensors; load is not yet included</p>
</html>"));
end Dimmer;
