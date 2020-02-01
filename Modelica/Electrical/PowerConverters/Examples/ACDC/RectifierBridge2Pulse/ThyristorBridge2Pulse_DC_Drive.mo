within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse;
model ThyristorBridge2Pulse_DC_Drive
  "Two pulse Graetz thyristor bridge feeding a DC drive"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage Vrms=dcpmData.VaNominal/(2/pi*sin(
      pi/2)*sqrt(2)) "RMS supply voltage";
  parameter SI.Frequency f=50 "Frequency";
  parameter SI.ApparentPower SMains=250E3
    "Mains short circuit apparent power";
  parameter Real lamdaMains=0.1 "Mains short circuit power factor";
  final parameter SI.Impedance ZMains=Vrms^2/SMains
    "Mains short circuit impedance";
  final parameter SI.Resistance RMains=ZMains*lamdaMains
    "Mains resistance" annotation (Evaluate=true);
  final parameter SI.Inductance LMains=ZMains*sqrt(1 - lamdaMains^2)/(2*pi*f)
    "Mains inductance" annotation (Evaluate=true);
  parameter SI.Inductance Ld=10*dcpmData.La
    "Smoothing inductance" annotation (Evaluate=true);
  final parameter SI.Torque tauNominal=dcpmData.ViNominal
      *dcpmData.IaNominal/dcpmData.wNominal "Nominal torque";
  output SI.AngularVelocity w(displayUnit="rpm") = dcpm.wMechanical "Angular velocity of drive";
  output SI.Torque tau=dcpm.tauShaft "Shaft torque of drive";
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-80,-50},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage(V=sqrt(2)*
        Vrms, f=f) annotation (Placement(transformation(
        origin={-80,0},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  PowerConverters.ACDC.ThyristorBridge2Pulse rectifier(useHeatPort=false)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
    annotation (Placement(transformation(
        origin={50,10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Blocks.Math.Mean meanVoltage(f=2*f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={80,40})));
  Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*f)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={80,10})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,-40})));
  Modelica.Blocks.Math.Mean meanCurrent(f=2*f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={80,-60})));
  PowerConverters.ACDC.Control.VoltageBridge2Pulse pulse2(
      useConstantFiringAngle=false, useFilter=true) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,-30})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=Ld) annotation (
      Placement(transformation(
        origin={30,-10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet
    dcpm(
    VaNominal=dcpmData.VaNominal,
    IaNominal=dcpmData.IaNominal,
    wNominal=dcpmData.wNominal,
    TaNominal=dcpmData.TaNominal,
    Ra=dcpmData.Ra,
    TaRef=dcpmData.TaRef,
    La=dcpmData.La,
    Jr=dcpmData.Jr,
    useSupport=false,
    Js=dcpmData.Js,
    frictionParameters=dcpmData.frictionParameters,
    coreParameters=dcpmData.coreParameters,
    strayLoadParameters=dcpmData.strayLoadParameters,
    brushParameters=dcpmData.brushParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true, start=dcpmData.wNominal),
    TaOperational=293.15,
    alpha20a=dcpmData.alpha20a,
    ia(start=0, fixed=true)) annotation (Placement(transformation(
          extent={{10,-90},{30,-70}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.DcPermanentMagnetData
    dcpmData "Data record of PM excited DC machine"
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{60,-90},{40,-70}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=10,
    startTime=5,
    height=tauNominal,
    offset=-tauNominal)
    annotation (Placement(transformation(extent={{90,-90},{70,-70}})));
  Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-30,-60})));
  Modelica.Electrical.Analog.Basic.Resistor rMains(R=RMains)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,30})));
  Modelica.Electrical.Analog.Basic.Inductor lMains(L=LMains)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,60})));
initial equation
  lMains.i = 0;

equation
  connect(meanCurrent.u, currentSensor.i) annotation (Line(
      points={{68,-60},{0,-60},{0,-51}}, color={0,0,127}));
  connect(ground.p, sinevoltage.n) annotation (Line(
      points={{-80,-40},{-80,-10}}, color={0,0,255}));
  connect(voltagesensor.v, meanVoltage.u) annotation (Line(
      points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
  connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
      points={{61,10},{68,10}}, color={0,0,127}));
  connect(sinevoltage.n, rectifier.ac_n) annotation (Line(
      points={{-80,-10},{-60,-10},{-60,-6},{-40,-6}}, color={0,0,255}));
  connect(rectifier.dc_n, currentSensor.n) annotation (Line(
      points={{-20,-6},{-10,-6},{-10,-40}},   color={0,0,255}));
  connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
      points={{-20,6},{-10,6},{-10,40},{50,40},{50,20}}, color={0,0,255}));
  connect(voltagesensor.n, currentSensor.p) annotation (Line(
      points={{50,0},{50,-40},{10,-40}}, color={0,0,255}));
  connect(pulse2.fire_p, rectifier.fire_p) annotation (Line(
      points={{-36,-19},{-36,-12}}, color={255,0,255}));
  connect(pulse2.fire_n, rectifier.fire_n) annotation (Line(
      points={{-24,-19},{-24,-12}}, color={255,0,255}));
  connect(pulse2.ac_p, rectifier.ac_p) annotation (Line(
      points={{-40,-24},{-54,-24},{-54,6},{-40,6}}, color={0,0,255}));
  connect(rectifier.ac_n, pulse2.ac_n) annotation (Line(
      points={{-40,-6},{-50,-6},{-50,-36},{-40,-36}}, color={0,0,255}));
  connect(inductor.n, dcpm.pin_ap) annotation (Line(
      points={{30,-20},{30,-70},{26,-70}}, color={0,0,255}));
  connect(torque.flange, dcpm.flange) annotation (Line(
      points={{40,-80},{30,-80}}));
  connect(ramp.y, torque.tau) annotation (Line(
      points={{69,-80},{62,-80}}, color={0,0,127}));
  connect(rectifier.dc_p, inductor.p) annotation (Line(
      points={{-20,6},{-10,6},{-10,40},{30,40},{30,0}}, color={0,0,255}));
  connect(currentSensor.p, dcpm.pin_an) annotation (Line(
      points={{10,-40},{10,-70},{14,-70}}, color={0,0,255}));
  connect(const.y, pulse2.firingAngle) annotation (Line(
      points={{-30,-49},{-30,-42}}, color={0,0,127}));
  connect(rMains.n, lMains.p) annotation (Line(
      points={{-80,40},{-80,50}}, color={0,0,255}));
  connect(rMains.p, sinevoltage.p) annotation (Line(
      points={{-80,20},{-80,10}}, color={0,0,255}));
  connect(rectifier.ac_p, lMains.n) annotation (Line(
      points={{-40,6},{-60,6},{-60,70},{-80,70}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=15,
      Interval=0.0002,
      Tolerance=1e-006),
    Documentation(info="<html>
<p>
In this example a PM excited DC machine is started with nominal torque at nominal speed. After 5 seconds, load torque is reduced to zero over a period of additional 10 seconds. At 15 seconds, the machine is operating at no load.
</p>

<p>
Plot torque <code>tau</code>, current <code>currentSensor.i</code> and average current <code>meanCurrent.y</code>. Also plot speed <code>w</code>, voltage <code>voltageSensor.v</code> and the average voltage <code>meanVoltage.y</code>.</p>
</html>"));
end ThyristorBridge2Pulse_DC_Drive;
