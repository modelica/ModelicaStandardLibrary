within Modelica.Electrical.Batteries.Utilities;
block PulseSeries "Series of pulses"
  import Modelica.Math.BooleanVectors.oneTrue;
  parameter Real amplitude1= 1 "Amplitude of 1st pulse series";
  parameter Integer n1(min=0)=1 "Number of pulses of 1st series";
  parameter SI.Time T1 "Length of pulses of 1st series";
  parameter SI.Time Tp1 "Pause between pulses of 1st series";
  parameter Real amplitude2=-amplitude1 "Amplitude of 2nd pulse series";
  parameter Integer n2(min=0)=1 "Number of pulses of 2nd series";
  parameter SI.Time T2=T1 "Length of pulses of 2nd series";
  parameter SI.Time Tp2=Tp1 "Pause between pulses of 1st series";
  parameter SI.Time Tp "Pause between the two series";
  extends Modelica.Blocks.Interfaces.SignalSource;
protected
  parameter SI.Time Tstart1[n1]={startTime + (k-1)*(T1 + Tp1) for k in 1:n1};
  parameter SI.Time Tstart2[n1]={startTime + n1*(T1 + Tp1) + Tp + (k-1)*(T2 + Tp2) for k in 1:n2};
  Boolean on1, on2;
equation
  on1 = oneTrue({time >= Tstart1[k] and time < Tstart1[k] + T1 for k in 1:n1});
  on2 = oneTrue({time >= Tstart2[k] and time < Tstart2[k] + T2 for k in 1:n1});
  y= offset + (if on1 then amplitude1 elseif on2 then amplitude2 else 0);
  annotation (Icon(graphics={
        Line(
          points={{-100,0},{-80,0}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(points={{-10,0},{-10,-60},{10,-60},{10,0},{20,0}}, color={0,0,0}),
        Line(points={{-50,0},{-50,60},{-40,60},{-40,0},{-20,0}}, color={0,0,0}),
        Line(
          points={{-20,0},{-10,0}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(points={{-80,0},{-80,60},{-70,60},{-70,0},{-50,0}}, color={0,0,0}),
        Line(points={{20,0},{20,-60},{40,-60},{40,0},{50,0}}, color={0,0,0}),
        Line(points={{50,0},{50,-60},{70,-60},{70,0},{80,0}}, color={0,0,0}),
        Line(
          points={{80,0},{100,0}},
          color={0,0,0},
          pattern=LinePattern.Dash)}), Documentation(info="<html>
<p>
Starting at <code>time = startTime</code>, first a series of <code>n1</code> pulses of <code>amplitude1</code> with length <code>T1</code> and pause after each pulse <code>Tp1</code> is issued.<br>
Then, after a pause <code>Tp</code>, a series of <code>n2</code> pulses of <code>amplitude2</code> with length <code>T2</code> and pause after each pulse <code>Tp2</code> is issued.
</p>
</html>"));
end PulseSeries;
