within Modelica.Electrical.Analog.Examples.OpAmps;
model LowPass "Low-pass filter"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vin=5 "Amplitude of input voltage";
  parameter SI.Frequency f=10 "Frequency of input voltage";
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Sources.PulseVoltage vIn(
    width=50,
    period=1/f,
    V=2*Vin,
    offset=-Vin)
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,0})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={40,0})));
  OpAmpCircuits.FirstOrder firstOrder(
    v2(fixed=true),
    T=0.1/f,
    opAmp(v_in(start=0)))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(vIn.n, firstOrder.n1)
    annotation (Line(points={{-40,-10},{-10,-10}}, color={0,0,255}));
  connect(vIn.p, firstOrder.p1)
    annotation (Line(points={{-40,10},{-10,10}}, color={0,0,255}));
  connect(firstOrder.p2, vOut.n)
    annotation (Line(points={{10,10},{40,10}}, color={0,0,255}));
  connect(firstOrder.n2, vOut.p)
    annotation (Line(points={{10,-10},{40,-10}}, color={0,0,255}));
  connect(firstOrder.n1, ground.p)
    annotation (Line(points={{-10,-10},{-10,-20},{-10,-20}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>This is a (inverting) low pass filter. Resistance R1 can be chosen, resistance R2 is defined by the desired amplification k, capacitance C is defined by the desired cut-off frequency.</p>
<p>The example is taken from: U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 13.3</p>
<p>Note: <code>vOut</code> measure the negative output voltage.</p>
</html>"),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-006,
      Interval=0.001));
end LowPass;
