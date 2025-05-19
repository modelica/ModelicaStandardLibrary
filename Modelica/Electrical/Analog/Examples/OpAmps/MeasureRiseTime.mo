within Modelica.Electrical.Analog.Examples.OpAmps;
model MeasureRiseTime "Measure riseTime as voltageFollower"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vps=+15 "Positive supply";
  parameter SI.Voltage Vns=-15 "Negative supply";
  parameter SI.Voltage Vin=10 "Amplitude of input voltage";
  parameter Real V0=15000 "No-load amplification of opAmp";
  parameter SI.Time Tr=1e-3 "Rise time (unrealistic low for visibility)";
  parameter SI.Time Tau=V0/log(9)*Tr "Time constant of firstOrder";
  discrete SI.Time t10(start=0) "Time when output reaches 10% Vin";
  discrete SI.Time t90(start=0) "Time when output reaches 90% Vin";
  SI.Time riseTime=t90-t10 "Measured rise time";
  Modelica.Electrical.Analog.Ideal.ImprovedOpAmpLimited opAmp(
    V0=V0,                                                    Vps=Vps, Vns=Vns,
    useFirstOrder=true,
    Tau=Tau)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Sources.StepVoltage                                 vIn(
    V=Vin,
    offset=0,
    startTime=1e-3)                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-20})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={30,-20})));
equation
  when vOut.v>=0.10*Vin then
    t10=time;
  end when;
  when vOut.v>=0.90*Vin then
    t90=time;
  end when;
  connect(ground.p, vIn.n) annotation (Line(
      points={{-10,-40},{-10,-30}},           color={0,0,255}));
  connect(opAmp.out, vOut.p) annotation (Line(
      points={{20,0},{30,0},{30,-10}}, color={0,0,255}));
  connect(ground.p, vOut.n) annotation (Line(
      points={{-10,-40},{30,-40},{30,-30}}, color={0,0,255}));
  connect(opAmp.out, opAmp.in_n) annotation (Line(
      points={{20,0},{30,0},{30,20},{-10,20},{-10,6},{0,6}}, color={0,0,255}));
  connect(vIn.p, opAmp.in_p)
    annotation (Line(points={{-10,-10},{-10,-6},{0,-6}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>This is a voltage follower. Rise time is measured between the time instances when output reaches 10&#037; and 90&#037; of input step.</p>
</html>"),
    experiment(
      StartTime=0,
      StopTime=5e-3,
      Interval=1e-7,
      Tolerance=1e-006));
end MeasureRiseTime;
