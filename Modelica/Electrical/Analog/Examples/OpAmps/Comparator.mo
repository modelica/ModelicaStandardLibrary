within Modelica.Electrical.Analog.Examples.OpAmps;
model Comparator "Comparator"
  extends Modelica.Icons.Example;
  parameter Real V0=15000.0 "No-load amplification";
  parameter Modelica.Units.SI.Voltage Vps=+15 "Positive supply";
  parameter Modelica.Units.SI.Voltage Vns=-15 "Negative supply";
  parameter Modelica.Units.SI.Voltage Vin=5 "Amplitude of input voltage";
  parameter Modelica.Units.SI.Frequency f=10 "Frequency of input voltage";
  parameter Modelica.Units.SI.Voltage Vref=0 "Reference voltage";
  parameter Real k=(Vref - Vns)/(Vps - Vns) "Calculated potentiometer ratio to reach Vref";
  parameter Modelica.Units.SI.Resistance R=1000 "Resistance of potentiometer";
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
  Modelica.Electrical.Analog.Basic.Potentiometer potentiometer(R=R, rConstant=
       k) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        origin={-20,-30})));
  Modelica.Electrical.Analog.Sources.SupplyVoltage supplyVoltage(Vps=Vps, Vns=
       Vns) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-20,-50})));
equation
  connect(vIn.p, opAmp.in_p) annotation (Line(
      points={{-40,10},{-10,10},{-10,6}},       color={0,0,255}));
  connect(opAmp.out, vOut.p) annotation (Line(
      points={{10,0},{40,0}},          color={0,0,255}));
  connect(ground.p, vOut.n) annotation (Line(
      points={{0,-80},{40,-80},{40,-20}},   color={0,0,255}));
  connect(ground.p, vIn.n) annotation (Line(
      points={{0,-80},{-40,-80},{-40,-10}},   color={0,0,255}));
  connect(potentiometer.contact, opAmp.in_n) annotation (Line(
      points={{-10,-20},{-10,-6}},
                               color={0,0,255}));
  connect(potentiometer.pin_p, supplyVoltage.pin_p) annotation (Line(
      points={{-30,-30},{-30,-50}}, color={0,0,255}));
  connect(potentiometer.pin_n, supplyVoltage.pin_n) annotation (Line(
      points={{-10,-30},{-10,-50}},
                                color={0,0,255}));
  connect(ground.p, supplyVoltage.ground) annotation (Line(
      points={{0,-80},{-20,-80},{-20,-50}},
                                    color={0,0,255}));
  annotation (Documentation(info="<html>
<p>This is a comparator. Resistance R1 can be chosen, resistance R2 is defined by the desired reference voltage Vref (between Vn and Vp). The output switches between Vn for input voltage &lt; Vref and Vp for input voltage &gt; Vref.</p>
</html>"),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-006,
      Interval=0.001));
end Comparator;
