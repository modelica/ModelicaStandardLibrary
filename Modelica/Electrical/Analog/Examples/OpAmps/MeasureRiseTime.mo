within Modelica.Electrical.Analog.Examples.OpAmps;
model MeasureRiseTime "Measure riseTime as voltageFollower"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage Vps=+15 "Positive supply";
  parameter SI.Voltage Vns=-15 "Negative supply";
  parameter SI.Voltage Vin=10 "Amplitude of input voltage";
  parameter Real V0=15000 "No-load amplification of opAmp";
  parameter Modelica.Units.SI.Frequency G_BW=0.15E6 "Gain-bandwidth-product";
  parameter Modelica.Units.SI.Frequency fc=G_BW/V0 "Cut-off frequency (open loop)";
  parameter Modelica.Units.SI.Time Tau=1/(2*pi*fc) "Time constant of firstOrder rise";
  parameter Modelica.Units.SI.VoltageSlope slewRate=0.1E6 "Slew rate";
  parameter Modelica.Units.SI.Time tStart=0.001 "Start time of input step";
  discrete SI.Time t10(start=0) "Time after input step when output reaches 10% Vin";
  discrete SI.Time t90(start=0) "Time after input step when output reaches 90% Vin";
  Modelica.Units.SI.Time MeasuredRiseTime=if t90<=t10 then 0 else t90 - t10 "Rise time";
  Modelica.Units.SI.VoltageSlope MeasuredSlewRate=
    if MeasuredRiseTime<=0 then 0 else 0.8*Vin/MeasuredRiseTime "Measured slew rate";
  Modelica.Electrical.Analog.Ideal.OpAmpLimited opAmp(
    V0=V0,
    Vps=Vps,
    Vns=Vns,
    enableOutputRise=true,
    G_BW=G_BW,
    slewRate=slewRate)
             annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Sources.SignalVoltage                               vIn
                                           annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-10,-20})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={30,-20})));
  Blocks.Sources.Pulse          pulse(
    amplitude=Vin,
    width=50,
    period=0.002,
    nperiod=1,
    startTime=tStart)
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
equation
  when vOut.v>=0.10*Vin then
    t10=time - tStart;
  end when;
  when vOut.v>=0.90*Vin then
    t90=time - tStart;
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
  connect(pulse.y, vIn.v)
    annotation (Line(points={{-29,-20},{-22,-20}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This is a simple voltage follower. 
An input step voltage is applied, and the output voltage does not follow immediately but with a first order delay whose slew rate is limited.<br>
The measured rise time from 10&percnt; to 90&percnt; allows the calculation of the slew rate: <code>0.8 &sdot; Vin / MeasuredRiseTime</code>
</p>
<p>Relationship between the parameters (which could be taken from manufacturer's datasheet):</p>
<table>
<tr><td>Open-loop amplification       </td><td><code>V0</code></td></tr>
<tr><td>Gain-bandwidth product        </td><td><code>G_BW</code></td></tr>
<tr><td>Cut-off frequency (open loop) </td><td><code>fc = G_BW/V0</code></td></tr>
<tr><td>Time constant of voltage rise </td><td><code>T = 1/(2*&pi;*fc)</code></td></tr>
<tr><td>Slew rate                     </td><td><code>slewRate</code></td></tr>
</table>
</html>"),
    experiment(
      StartTime=0,
      StopTime=3e-3,
      Interval=1e-7,
      Tolerance=1e-006));
end MeasureRiseTime;
