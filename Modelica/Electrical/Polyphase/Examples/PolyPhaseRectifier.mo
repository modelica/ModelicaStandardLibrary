within Modelica.Electrical.Polyphase.Examples;
model PolyPhaseRectifier "Demonstrate a polyphase diode rectifier"
  extends Icons.Example;
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  parameter Integer m(final min=2)=6 "Number of phases";
  parameter Modelica.SIunits.Voltage VrmsY=100 "RMS voltage line to starpoint";
  parameter Modelica.SIunits.Frequency f=50 "Source frequency";
  final parameter Integer mSystems=numberOfSymmetricBaseSystems(m)
    "Number of base systems";
  final parameter Integer mBasic=integer(m/mSystems)
    "Phase number of base systems";
  final parameter Integer kPolygon=if m==2 then 1 else integer((mBasic - 1)/2)
    "Alternative of largest polygon voltage";
  Sources.SineVoltage sineVoltage(
    m=m,
    V=sqrt(2)*fill(VrmsY, m),
    f=fill(f, m))         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,0})));
  Basic.MultiStarResistance multiStar(m=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-30})));
  Analog.Basic.Resistor resistor2ground(R=1e6) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-60})));
  Analog.Basic.Ground groundAC
    annotation (Placement(transformation(extent={{-90,-100},{-70,-80}})));
  Basic.MultiDelta multiDelta(m=m, kPolygon=kPolygon)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,50})));
  Sensors.VoltageSensor voltageSensor(m=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,50})));
  Modelica.Blocks.Math.Harmonic vH1(f=f, k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,70})));
  Sensors.CurrentSensor currentSensorAC(m=m)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Math.Harmonic iH1(f=f, k=1) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-50,-10})));
  Ideal.IdealDiode diode1(
    m=m,
    Ron=fill(1e-6, m),
    Goff=fill(1e-6, m),
    Vknee=fill(0, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,40})));
  Ideal.IdealDiode diode2(
    m=m,
    Ron=fill(1e-6, m),
    Goff=fill(1e-6, m),
    Vknee=fill(0, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,0})));
  Basic.Star star1(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,60})));
  Basic.Star star2(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,-20})));
  Analog.Sensors.CurrentSensor currentSensorDC
    annotation (Placement(transformation(extent={{10,70},{30,50}})));
  Modelica.Blocks.Math.Mean iDC(f=f) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={90,20})));
  Analog.Sensors.VoltageSensor voltageSensorDC
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={60,20})));
  Modelica.Blocks.Math.Mean vDC(f=f) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,90})));
  Analog.Basic.Resistor resistor1(R=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,40})));
  Analog.Basic.Resistor resistor2(R=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,0})));
  Analog.Basic.Ground groundDC annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,20})));
equation
  connect(sineVoltage.plug_n, multiStar.plug)
    annotation (Line(points={{-80,-10},{-80,-20}}, color={0,0,255}));
  connect(multiDelta.plug_p, sineVoltage.plug_p)
    annotation (Line(points={{-90,40},{-80,40},{-80,10}},  color={0,0,255}));
  connect(sineVoltage.plug_p, currentSensorAC.plug_p)
    annotation (Line(points={{-80,10},{-80,20},{-60,20}},color={0,0,255}));
  connect(currentSensorAC.plug_n, diode1.plug_p)
    annotation (Line(points={{-40,20},{-30,20},{-30,30}},
                                                        color={0,0,255}));
  connect(currentSensorAC.plug_n, diode2.plug_n)
    annotation (Line(points={{-40,20},{-30,20},{-30,10}},color={0,0,255}));
  connect(star1.plug_p, diode1.plug_n)
    annotation (Line(points={{-20,60},{-30,60},{-30,50}}, color={0,0,255}));
  connect(diode2.plug_p, star2.plug_p)
    annotation (Line(points={{-30,-10},{-30,-20},{-20,-20}}, color={0,0,255}));
  connect(star1.pin_n, currentSensorDC.p)
    annotation (Line(points={{0,60},{10,60}}, color={0,0,255}));
  connect(currentSensorDC.n, resistor1.p)
    annotation (Line(points={{30,60},{40,60},{40,50}}, color={0,0,255}));
  connect(star2.pin_n, resistor2.n)
    annotation (Line(points={{0,-20},{40,-20},{40,-10}}, color={0,0,255}));
  connect(resistor1.n, groundDC.p)
    annotation (Line(points={{40,30},{40,20}},color={0,0,255}));
  connect(groundDC.p, resistor2.p)
    annotation (Line(points={{40,20},{40,10}}, color={0,0,255}));
  connect(resistor1.p, voltageSensorDC.p)
    annotation (Line(points={{40,50},{60,50},{60,30}}, color={0,0,255}));
  connect(resistor2.n, voltageSensorDC.n)
    annotation (Line(points={{40,-10},{60,-10},{60,10}},  color={0,0,255}));
  connect(multiDelta.plug_p, voltageSensor.plug_p)
    annotation (Line(points={{-90,40},{-70,40}}, color={0,0,255}));
  connect(multiDelta.plug_n, voltageSensor.plug_n)
    annotation (Line(points={{-90,60},{-70,60}}, color={0,0,255}));
  connect(voltageSensor.v[1], vH1.u)
    annotation (Line(points={{-59,50},{-50,50},{-50,58}}, color={0,0,127}));
  connect(currentSensorAC.i[1], iH1.u)
    annotation (Line(points={{-50,9},{-50,2}},     color={0,0,127}));
  connect(vDC.u, currentSensorDC.i)
    annotation (Line(points={{20,78},{20,71}}, color={0,0,127}));
  connect(voltageSensorDC.v, iDC.u)
    annotation (Line(points={{71,20},{78,20}},
                                             color={0,0,127}));
  connect(multiStar.pin, resistor2ground.p)
    annotation (Line(points={{-80,-40},{-80,-50}}, color={0,0,255}));
  connect(resistor2ground.n, groundAC.p)
    annotation (Line(points={{-80,-70},{-80,-80}}, color={0,0,255}));
  annotation (experiment(StopTime=0.2, Interval=0.0001), Documentation(info="<html>
<p>
This example demonstrates a polyphase rectifier, as well as proper usage of ground.
</p>
<p>
You may try different number of phases 2&le;m, and investigate:
</p>
<ul>
<li>AC voltage line-to-line vH1 (1st harmonice rms)</li>
<li>AC current iH1 (1st harmonice rms)</li>
<li>DC voltage vDC (mean)<li>
<li>DC current iDC (mean)<li>
</ul>
<p>
Note that kPolygon=(mBasic - 1)/2 is set to achieve the highest possible line-to-line voltage.
</p>
<p>
AC rms voltage line-to-neutral is set by parameter VrmsY.
</p>
</html>"));
end PolyPhaseRectifier;
