within Modelica.Electrical.Analog.Examples.OpAmps;
model Comparator "Comparator"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vps=+15 "Positive supply";
  parameter SI.Voltage Vns=-15 "Negative supply";
  parameter SI.Voltage Vin=5 "Amplitude of input voltage";
  parameter SI.Frequency f=10 "Frequency of input voltage";
  parameter SI.Voltage Vref=0 "Reference voltage";
  parameter Real k=(Vref - Vns)/(Vps - Vns) "Calculated potentiometer ratio to reach Vref";
  parameter SI.Resistance R=1000 "Resistance of potentiometer";
  Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp(Vps=Vps, Vns=
        Vns) annotation (Placement(transformation(extent={{0,10},{20,-10}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
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
        origin={-80,0})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={50,-20})));
  Modelica.Electrical.Analog.Basic.Potentiometer potentiometer(R=R, rConstant=
       k) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        origin={-10,-30})));
  Modelica.Electrical.Analog.Sources.SupplyVoltage supplyVoltage(Vps=Vps, Vns=
       Vns) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-10,-50})));
equation
  connect(vIn.p, opAmp.in_p) annotation (Line(
      points={{-80,10},{-10,10},{-10,6},{0,6}}, color={0,0,255}));
  connect(opAmp.out, vOut.p) annotation (Line(
      points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
  connect(ground.p, vOut.n) annotation (Line(
      points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
  connect(ground.p, vIn.n) annotation (Line(
      points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
  connect(potentiometer.contact, opAmp.in_n) annotation (Line(
      points={{0,-20},{0,-6}}, color={0,0,255}));
  connect(potentiometer.pin_p, supplyVoltage.pin_p) annotation (Line(
      points={{-20,-30},{-20,-50}}, color={0,0,255}));
  connect(potentiometer.pin_n, supplyVoltage.pin_n) annotation (Line(
      points={{0,-30},{0,-50}}, color={0,0,255}));
  connect(ground.p, supplyVoltage.ground) annotation (Line(
      points={{-10,-80},{-10,-50}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>This is a comparator. Resistance R1 can be chosen, resistance R2 is defined by the desired reference voltage Vref (between Vn and Vp). The output switches between Vn for input voltage &lt; Vref and Vp for input voltage &gt; Vref.</p>
</html>"),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-006,
      Interval=0.001));
end Comparator;
