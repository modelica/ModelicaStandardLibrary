within Modelica.Electrical.Analog.Examples.OpAmps;
model SchmittTrigger "Schmitt trigger with hysteresis"
  extends Modelica.Icons.Example;
  parameter Real V0=15000.0 "No-load amplification";
  parameter Modelica.Units.SI.Voltage Vps=+15 "Positive supply";
  parameter Modelica.Units.SI.Voltage Vns=-15 "Negative supply";
  parameter Modelica.Units.SI.Voltage Vin=5 "Amplitude of input voltage";
  parameter Modelica.Units.SI.Frequency f=10 "Frequency of input voltage";
  parameter Modelica.Units.SI.Voltage vHys=1 "(Positive) hysteresis voltage";
  parameter Real k=vHys/Vps "Auxiliary calculated parameter to be used in R2 calculation";
  parameter Modelica.Units.SI.Resistance R1=1000 "Arbitrary resistance";
  parameter Modelica.Units.SI.Resistance R2=R1/k
    "Calculated resistance to reach hysteresis voltage";
  Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp(
    V0=V0,
    useSupply=false,
    Vps=Vps,
    Vns=Vns,
    regularized=true,
    smoothed=false,
    strict=false)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
  Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
    rising=0.2/f,
    width=0.3/f,
    falling=0.2/f,
    period=1/f,
    nperiod=-1,
    startTime=-(vIn.rising + vIn.width/2),
    V=2*Vin,
    offset=-Vin) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,0})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={40,-10})));
  Modelica.Electrical.Analog.Basic.Resistor r1(R=R1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-30,20})));
  Modelica.Electrical.Analog.Basic.Resistor r2(R=R2) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={10,20})));
equation
  connect(ground.p, vIn.n) annotation (Line(
      points={{0,-80},{-40,-80},{-40,-10}},   color={0,0,255}));
  connect(ground.p, vOut.n) annotation (Line(
      points={{0,-80},{40,-80},{40,-20}},   color={0,0,255}));
  connect(opAmp.out, vOut.p) annotation (Line(
      points={{10,0},{40,0}},          color={0,0,255}));
  connect(opAmp.out, r2.n) annotation (Line(
      points={{10,0},{20,0},{20,20}},         color={0,0,255}));
  connect(r2.p, opAmp.in_p) annotation (Line(
      points={{0,20},{-10,20},{-10,6}},       color={0,0,255}));
  connect(r2.p, r1.n) annotation (Line(
      points={{0,20},{-20,20}}, color={0,0,255}));
  connect(r1.p, vIn.p) annotation (Line(
      points={{-40,20},{-40,10}},          color={0,0,255}));
  connect(opAmp.in_n, ground.p) annotation (Line(points={{-10,-6},{-10,-20},{0,-20},
          {0,-80}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>This is a (non-inverting) Schmitt trigger. Resistance R1 can be chosen, resistance R2 is defined by the desired hysteresis. The output gets Vp for input voltage &gt; vHys and Vn for input voltage &lt; vHys*Vns/Vps.</p>
<p>The example is taken from: U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 6.5.2</p>
</html>"),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-006,
      Interval=0.001));
end SchmittTrigger;
