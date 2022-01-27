within Modelica.Electrical.Analog.Examples;
model DemoPowerSupplyWithBuffer
  "Demonstrate how to avoid back current to the DC Power Supply"
  extends Modelica.Icons.Example;
  parameter SI.Current amplitude = 50 "Pulse current amplitude peak-to-peak";
  parameter SI.Current offset = -25 "Pulse current offset";
  parameter Real dutyCycle(final min = 0, final max = 1) = 0.5 "Pulse current duty cycle";
  parameter SI.Frequency f = 1e3 "Pulse current frequency";
  Modelica.Electrical.Analog.Sources.DCPowerSupply dcPowerSupply(
    Gcc=0.01,
    Rcv=0.01,
    iBack=0.1) annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(transformation(extent={{-10,10},{10,-10}},      rotation = 90, origin={-20,50})));
  Modelica.Electrical.Analog.Basic.Resistor cable(R = 1e-3) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={10,40})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={10,10})));
  Modelica.Electrical.Analog.Basic.Capacitor bufferCapacitor(v(fixed = true, start = 0), C = 100e-3) annotation (
    Placement(transformation(extent={{10,0},{-10,-20}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent loadCurrent annotation (
    Placement(transformation(extent={{10,-20},{-10,-40}})));
  Modelica.Blocks.Sources.Pulse pulse(amplitude = amplitude, width = dutyCycle * 100, period = 1 / f, startTime = 0.5) annotation (
    Placement(transformation(extent = {{-42, -90}, {-22, -70}})));
  Modelica.Blocks.Sources.Step step(height = offset, startTime = 0.5) annotation (
    Placement(transformation(extent={{40,-90},{20,-70}})));
  Modelica.Blocks.Math.Add      add      annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, -60})));
equation
  connect(dcPowerSupply.n, ground.p) annotation (
    Line(points={{-10,60},{-10,50}},    color = {0, 0, 255}));
  connect(dcPowerSupply.p, cable.p) annotation (
    Line(points={{10,60},{10,50}},        color = {0, 0, 255}));
  connect(cable.n, diode.p) annotation (
    Line(points={{10,30},{10,20}},        color = {0, 0, 255}));
  connect(pulse.y, add.u1)
    annotation (Line(points={{-21,-80},{-6,-80},{-6,-72}}, color={0,0,127}));
  connect(add.y, loadCurrent.i)
    annotation (Line(points={{5.55112e-16,-49},{0,-42}}, color={0,0,127}));
  connect(step.y, add.u2)
    annotation (Line(points={{19,-80},{6,-80},{6,-72}}, color={0,0,127}));
  connect(diode.n, bufferCapacitor.p)
    annotation (Line(points={{10,0},{10,-10}}, color={0,0,255}));
  connect(bufferCapacitor.p, loadCurrent.p)
    annotation (Line(points={{10,-10},{10,-30}}, color={0,0,255}));
  connect(bufferCapacitor.n, loadCurrent.n)
    annotation (Line(points={{-10,-10},{-10,-30}}, color={0,0,255}));
  connect(ground.p, bufferCapacitor.n)
    annotation (Line(points={{-10,50},{-10,-10}}, color={0,0,255}));
  annotation (
    experiment(Interval = 1e-05, Tolerance = 1e-6, StartTime = 0, StopTime = 1),
    Documentation(info="<html>
<p>
At the beginning, the DC power supply charges the buffer capacitor within its limits (current, power, voltage). 
The DC power supply is protected from back current by a buffer capacitor and a diode. 
This also reduces current ripple of the power supply. 
</p>
<p>
Of course, if the load current feeds back a too high current to the buffer capacitor for a longer period of time, 
the buffer capacitor's voltage increases. This should be under surveillance.
</p>
<p>
The load current is 0 up to 0.5 s, afterwards a pulse with amplitude 50 A, an offset of -25 A, a dutyCycle of 0.5 and a frequency of 1 kHz. 
</p>
</html>"));
end DemoPowerSupplyWithBuffer;
