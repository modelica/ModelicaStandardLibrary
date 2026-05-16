within Modelica.Electrical.Analog.Examples;
model ChuaDiode "Demonstrate Chuas Diode"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vs=7.66667 "Supply voltage";
  //NIC1+2
  parameter SI.Resistance R1=220 "Pos. and neg. feedback resistance of NIC1";
  parameter SI.Resistance Rg1=2200 "Resistance to ground of NIC1";
  parameter SI.Resistance R2=22000 "Pos. and neg. feedback resistance of NIC2";
  parameter SI.Resistance Rg2=3300 "Resistance to ground of NIC2";
  //Results for NIC1+2
  parameter SI.Voltage VLim1=Vs*Rg1/(Rg1 + R1) "NIC1: Left and right corner voltage";
  parameter SI.Conductance gPos1=1/R1 "NIC1: Positive differential conductance";
  parameter SI.Conductance gNeg1=-1/Rg1 "NIC1: Negative (inner) conductance";
  parameter SI.Voltage VLim2=Vs*Rg2/(Rg2 + R2) "NIC2: Left and right corner voltage";
  parameter SI.Conductance gPos2=1/R2 "NIC2: Positive differential conductance";
  parameter SI.Conductance gNeg2=-1/Rg2 "NIC2: Negative (inner) conductance";
  //Results for Chuas Diode
  parameter SI.Conductance Ga=gNeg1 + gNeg2 "CHUA: Inner slope";
  parameter SI.Voltage Ve=min(VLim1, VLim2) "CHUA: Inner limit";
  parameter SI.Conductance Gb=if VLim1<VLim2 then gPos1 + gNeg2 else gNeg1 + gPos2
    "CHUA: Intermediate slope";
  parameter SI.Voltage Vp=max(VLim1, VLim2) "CHUA: Outer limit";
  parameter SI.Conductance Gc=gPos1 + gPos2 "CHUA: Outer slope";
  Modelica.Electrical.Analog.Basic.Resistor rPos1(R=R1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,40})));
  Modelica.Electrical.Analog.Ideal.OpAmpLimited opAmp1(Vps=+Vs, Vns=-Vs) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-70,10})));
  Modelica.Electrical.Analog.Basic.Resistor rNeg1(R=R1) annotation (Placement(
        transformation(extent={{-80,-10},{-60,-30}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor rg1(R=Rg1, i(start=0))  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-40})));
  Modelica.Electrical.Analog.Basic.Resistor rPos2(R=R2) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-30,40})));
  Modelica.Electrical.Analog.Ideal.OpAmpLimited opAmp2(Vps=+Vs, Vns=-Vs) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-30,10})));
  Modelica.Electrical.Analog.Basic.Resistor rNeg2(R=R2) annotation (Placement(
        transformation(extent={{-20,-10},{-40,-30}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor rg2(R=Rg2, i(start=0))  annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-40,-40})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Electrical.Analog.Sources.SineVoltage source(V=8,    f=10)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensorA
    annotation (Placement(transformation(extent={{-20,70},{-40,50}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensorB
    annotation (Placement(transformation(extent={{20,70},{40,50}})));
  Modelica.Electrical.Analog.Examples.Utilities.NonlinearResistor chuasDiode(
    Ga(min=-1) = Ga,
    Gb(min=-1) = Gb,
    Ve=Ve)    annotation (Placement(transformation(
        origin={50,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(opAmp1.in_n, rNeg1.n)
    annotation (Line(points={{-60,4},{-60,-20}},  color={0,0,255}));
  connect(opAmp1.out, rNeg1.p)
    annotation (Line(points={{-80,10},{-80,-20}},color={0,0,255}));
  connect(opAmp1.out, rPos1.p)
    annotation (Line(points={{-80,10},{-80,40}},color={0,0,255}));
  connect(opAmp1.in_p, rPos1.n)
    annotation (Line(points={{-60,16},{-60,40}},color={0,0,255}));
  connect(rNeg1.n, rg1.p)
    annotation (Line(points={{-60,-20},{-60,-30}}, color={0,0,255}));
  connect(opAmp2.out, rNeg2.p)
    annotation (Line(points={{-20,10},{-20,-20}},color={0,0,255}));
  connect(opAmp2.in_n, rNeg2.n)
    annotation (Line(points={{-40,4},{-40,-20}},  color={0,0,255}));
  connect(rPos2.n, opAmp2.in_p)
    annotation (Line(points={{-40,40},{-40,16}},color={0,0,255}));
  connect(rNeg2.n, rg2.p)
    annotation (Line(points={{-40,-20},{-40,-30}}, color={0,0,255}));
  connect(rPos2.p, opAmp2.out)
    annotation (Line(points={{-20,40},{-20,10}},color={0,0,255}));
  connect(source.n, ground.p)
    annotation (Line(points={{0,-10},{0,-60}}, color={0,0,255}));
  connect(rg1.n, ground.p)
    annotation (Line(points={{-60,-50},{-50,-50},{-50,-60},{0,-60}},
                                                           color={0,0,255}));
  connect(ground.p, rg2.n)
    annotation (Line(points={{0,-60},{-50,-60},{-50,-50},{-40,-50}},
                                                           color={0,0,255}));
  connect(currentSensorA.p, source.p)
    annotation (Line(points={{-20,60},{0,60},{0,10}}, color={0,0,255}));
  connect(currentSensorA.n, rPos2.n) annotation (Line(points={{-40,60},{-50,60},
          {-50,40},{-40,40}},          color={0,0,255}));
  connect(rPos1.n, rPos2.n) annotation (Line(points={{-60,40},{-40,40}},
                     color={0,0,255}));
  connect(source.p, currentSensorB.p)
    annotation (Line(points={{0,10},{0,60},{20,60}}, color={0,0,255}));
  connect(currentSensorB.n, chuasDiode.p)
    annotation (Line(points={{40,60},{50,60},{50,10}}, color={0,0,255}));
  connect(ground.p, chuasDiode.n)
    annotation (Line(points={{0,-60},{50,-60},{50,-10}}, color={0,0,255}));
  annotation (experiment(
      StopTime=1.0,
      Interval=0.001,
      Tolerance=1e-06), Documentation(info="<html>
<p>
This example demonstrates how <a href=\"modelica://Modelica.Electrical.Analog.Examples.ChuaCircuit\">Chua&#39;s diode</a> can be implemented two OpAmp-circuits called NIC
(negative impedance converter) using each an operational amplifier. The relations between the parameters of the OpAmp-circuit and the 
ideal <a href=\"modelica://Modelica.Electrical.Analog.Examples.Utilities.NonlinearResistor\">nonlinear resistor</a> can be seen from the parameter calculations in the text layer.
</p>
<p>Plot <code>currentSensorA.i</code> and <code>currentSensorB.i</code> versus <code>source.v</code> to inspect the characteristic.</p>
<p><strong>Note:</strong><br>
The implementation using 2 NICs shows an outer positive slope which is not present in the ideal nonlinear resistor.</p>
</html>"));
end ChuaDiode;
