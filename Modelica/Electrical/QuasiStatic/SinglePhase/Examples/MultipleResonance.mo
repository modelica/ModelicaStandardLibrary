within Modelica.Electrical.QuasiStatic.SinglePhase.Examples;
model MultipleResonance
  "Demonstrates series and parallel resonance using a transformer"
  extends Icons.Example;
  import Modelica.ComplexMath.j;
  import Modelica.Constants.small;
  parameter Modelica.Units.SI.Voltage V=0.5 "Source rms voltage";
  parameter Modelica.Units.SI.Frequency fLo=5.e6 "Lower source frequency";
  parameter Modelica.Units.SI.Frequency fUp=15e6 "Upper source frequency";
  parameter Modelica.Units.SI.ComplexImpedance Zi=Modelica.Units.SI.ComplexImpedance(100 +j*0) "Source inner impedance";
  parameter Modelica.Units.SI.Inductance L1=30e-6 "Transformer primary inductance";
  parameter Modelica.Units.SI.Inductance L2=1.e-6 "Transformer secondary inductance";
  parameter Real k(min=small, max=1)=0.95 "Transformer coupling factor";
  parameter Modelica.Units.SI.Inductance M=k*sqrt(L1*L2) "Transformer mutual inductance"
    annotation(Dialog(enable=false));
  parameter Modelica.Units.SI.Resistance R=5 "Load resistance";
  parameter Modelica.Units.SI.Inductance L=5e-6 "Load inductance";
  parameter Modelica.Units.SI.Capacitance C=50e-12 "Load capacitance";
  Sources.VariableVoltageSource voltageSource(
    gamma(fixed=true))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-40,0})));
  Basic.Impedance zi(Z_ref=Zi)
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Basic.Transformer transformer(
    L1=L1,
    L2=L2,
    M=M)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Basic.Ground ground1
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Basic.Ground ground2
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  Basic.Resistor loadResistor(R_ref=R) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,50})));
  Basic.Inductor loadInductor(L=L) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,20})));
  Basic.Capacitor loadCapacitor(C=C) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-10})));
  ComplexBlocks.Sources.ComplexConstant complexConst(k(re=V, im=0))
    annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  Blocks.Sources.LogFrequencySweep frequencySweep(
    duration=1,
    wMin=fLo,
    wMax=fUp) annotation (Placement(transformation(origin={-80,-20}, extent={{-10,
            -10},{10,10}})));
  Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(extent={{0,30},{20,10}})));
equation
  connect(voltageSource.pin_n, ground1.pin) annotation (Line(points={{-40,-10},
          {-40,-20},{20,-20}}, color={85,170,255}));
  connect(ground1.pin, transformer.pin_n1) annotation (Line(points={{20,-20},{
          30,-20},{30,-10}}, color={85,170,255}));
  connect(transformer.pin_n2, ground2.pin) annotation (Line(points={{50,-9.8},{
          50,-20},{60,-20}}, color={85,170,255}));
  connect(ground2.pin, loadCapacitor.pin_n)
    annotation (Line(points={{60,-20},{80,-20}}, color={85,170,255}));
  connect(loadCapacitor.pin_p, loadInductor.pin_n)
    annotation (Line(points={{80,0},{80,10}}, color={85,170,255}));
  connect(loadInductor.pin_p, loadResistor.pin_n)
    annotation (Line(points={{80,30},{80,40}}, color={85,170,255}));
  connect(complexConst.y, voltageSource.V) annotation (Line(points={{-69,20},{
          -60,20},{-60,6},{-52,6}}, color={85,170,255}));
  connect(transformer.pin_p2, loadResistor.pin_p)
    annotation (Line(points={{50,10},{50,60},{80,60}}, color={85,170,255}));
  connect(voltageSource.pin_p, zi.pin_p)
    annotation (Line(points={{-40,10},{-40,20},{-30,20}}, color={85,170,255}));
  connect(frequencySweep.y, voltageSource.f) annotation (Line(points={{-69,-20},
          {-60,-20},{-60,-6},{-52,-6}}, color={0,0,127}));
  connect(zi.pin_n, currentSensor.pin_p)
    annotation (Line(points={{-10,20},{0,20}}, color={85,170,255}));
  connect(currentSensor.pin_n, transformer.pin_p1)
    annotation (Line(points={{20,20},{30,20},{30,10}}, color={85,170,255}));
  annotation (experiment(
      StopTime=1.0,
      Interval=0.0001),
      Documentation(info="<html>
<p>
The series resonance load circuit is fed by a voltage source with inner impedance. 
By using a transformer between source and load, we achieve multiple resonance by varying the source frequency:
</p>
<ul>
<li>series resonance: Im{Z}=0</li>
<li>parallel resonance: Im{Y}=0</li>
</ul>
<p>
Plot <code>currentSensor.abs_i</code> and <code>currentSensor.arg_i</code> versus frequency, i.e. <code>frequencySweep.y</code>. 
Note that the behaviour is fundamentally different from that of a simple series resonance circuit.
</p>
</html>"));
end MultipleResonance;
