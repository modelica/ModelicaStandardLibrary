within ModelicaTest.Electrical.PowerConverters.Examples.DCAC.PolyphaseTwoLevel;
model TestPWM "Test pwm result: rms of base harmonic"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage epsilon=VNom*0.005 "Comparison threshold";
  parameter SI.Voltage V_LL=400 "RMS line-to-line voltage";
  parameter SI.Voltage V_DC=sqrt(2)*V_LL "Ideal DC volatge";
  parameter SI.Voltage Vmax=2/3*V_DC*cos(pi/6) "Max. output voltage";
  parameter SI.Frequency f_sw=2000 "Switching frequency";
  parameter SI.Voltage VNom=Vmax/sqrt(2) "Nominal RMS output voltage";
  parameter SI.Frequency fRef=50 "Reference frequency";
  Modelica.Electrical.Analog.Sources.ConstantVoltage dcPos(V=V_DC/2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,78})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage dcNeg(V=V_DC/2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-70})));
  Modelica.Electrical.Analog.Basic.Ground groundSource annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,0})));
  Modelica.Electrical.PowerConverters.DCAC.Polyphase2Level multiPhase2Level1
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Electrical.PowerConverters.DCAC.Control.SVPWM svPWM(
    uMax=Vmax, f=f_sw)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,50})));
  Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor1
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,80})));
  Modelica.Blocks.Math.Harmonic h01V1(f=fRef, k=1)
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
  Modelica.Blocks.Sources.Cosine cosine(amplitude=sqrt(2)*VNom, f=fRef)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=sqrt(2)*VNom, f=fRef)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Electrical.Polyphase.Basic.Star star1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,50})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=1e6) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,20})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,0})));
  Modelica.Electrical.PowerConverters.DCAC.Polyphase2Level multiPhase2Level2
    annotation (Placement(transformation(extent={{-10,-70},{10,-90}})));
  Modelica.Electrical.PowerConverters.DCAC.Control.IntersectivePWM
    intersectivePWM(uMax=Vmax, f=f_sw)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-50})));
  Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor2
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-80})));
  Modelica.Blocks.Math.Harmonic h01V2(f=fRef, k=1)
    annotation (Placement(transformation(extent={{70,-70},{90,-90}})));
  Modelica.Electrical.Polyphase.Basic.Star star2 annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={40,-50})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R=1e6) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={40,-20})));
equation
  when terminal() then
    assert(abs(h01V1.y_rms - VNom)<epsilon, "rms of svPWM wrong");
    assert(abs(h01V2.y_rms - VNom*sqrt(3)/2)<epsilon, "rms of intersectivePWM wrong");
  end when;
  connect(svPWM.fire_p, multiPhase2Level1.fire_p)
    annotation (Line(points={{-6,61},{-6,68}}, color={255,0,255}));
  connect(svPWM.fire_n, multiPhase2Level1.fire_n)
    annotation (Line(points={{6,61},{6,68}}, color={255,0,255}));
  connect(dcNeg.n, multiPhase2Level1.dc_n) annotation (Line(points={{-80,-80},{-30,
          -80},{-30,74},{-10,74}}, color={0,0,255}));
  connect(dcPos.p, multiPhase2Level1.dc_p) annotation (Line(points={{-80,88},{-20,
          88},{-20,86},{-10,86}}, color={0,0,255}));
  connect(dcPos.n, groundSource.p)
    annotation (Line(points={{-80,68},{-80,0}}, color={0,0,255}));
  connect(groundSource.p, dcNeg.p)
    annotation (Line(points={{-80,0},{-80,-60}}, color={0,0,255}));
  connect(voltageSensor1.v[1], h01V1.u)
    annotation (Line(points={{51,80},{68,80}}, color={0,0,127}));
  connect(multiPhase2Level1.ac, voltageSensor1.plug_p)
    annotation (Line(points={{10,80},{20,80},{20,90},{40,90}},
                                               color={0,0,255}));
  connect(cosine.y, svPWM.u[1])
    annotation (Line(points={{-39,20},{0.5,20},{0.5,38}}, color={0,0,127}));
  connect(sine.y, svPWM.u[2]) annotation (Line(points={{-39,-20},{-0.5,-20},{-0.5,
          38}}, color={0,0,127}));
  connect(voltageSensor1.plug_n, star1.plug_p)
    annotation (Line(points={{40,70},{40,60}}, color={0,0,255}));
  connect(star1.pin_n, resistor1.p)
    annotation (Line(points={{40,40},{40,30}}, color={0,0,255}));
  connect(resistor1.n, ground.p)
    annotation (Line(points={{40,10},{40,0}}, color={0,0,255}));
  connect(dcNeg.n, multiPhase2Level2.dc_n) annotation (Line(points={{-80,-80},{-30,
          -80},{-30,-74},{-10,-74}}, color={0,0,255}));
  connect(dcPos.p, multiPhase2Level2.dc_p) annotation (Line(points={{-80,88},{-20,
          88},{-20,-86},{-10,-86}}, color={0,0,255}));
  connect(intersectivePWM.fire_p, multiPhase2Level2.fire_p)
    annotation (Line(points={{-6,-61},{-6,-68}}, color={255,0,255}));
  connect(intersectivePWM.fire_n, multiPhase2Level2.fire_n)
    annotation (Line(points={{6,-61},{6,-68}}, color={255,0,255}));
  connect(cosine.y, intersectivePWM.u[1])
    annotation (Line(points={{-39,20},{0.5,20},{0.5,-38}}, color={0,0,127}));
  connect(sine.y, intersectivePWM.u[2]) annotation (Line(points={{-39,-20},{-0.5,
          -20},{-0.5,-38}}, color={0,0,127}));
  connect(ground.p, resistor2.n)
    annotation (Line(points={{40,0},{40,-10}}, color={0,0,255}));
  connect(resistor2.p, star2.pin_n)
    annotation (Line(points={{40,-30},{40,-40}}, color={0,0,255}));
  connect(multiPhase2Level2.ac, voltageSensor2.plug_p) annotation (Line(points={
          {10,-80},{20,-80},{20,-90},{40,-90}}, color={0,0,255}));
  connect(voltageSensor2.plug_n, star2.plug_p)
    annotation (Line(points={{40,-70},{40,-60}}, color={0,0,255}));
  connect(h01V2.u, voltageSensor2.v[1])
    annotation (Line(points={{68,-80},{51,-80}}, color={0,0,127}));
  annotation (experiment(
      StopTime=0.1,
      Interval=0.001,
      Tolerance=1e-07),
    TestCase(shouldPass = true,
      __ModelicaAssociation(Comparison(timeWindows={TimeWindow(0.08, 0.1)}))));
end TestPWM;
