within Modelica.Electrical.Polyphase.Examples.Utilities;
model AnalysatorDC "Analyze DC voltage, current and power"
  extends Icons.RoundSensor;
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  parameter SI.Frequency f=50 "Mains frequency";
  Analog.Interfaces.NegativePin nv "Negative electrical pin"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealOutput pDC(unit="W") "Mean power" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        origin={-110,-60})));
  Modelica.Blocks.Interfaces.RealOutput iMean(unit="A") "Mean current" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-110})));
  Modelica.Blocks.Interfaces.RealOutput vMean(unit="V") "Mean voltage" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-110})));
  Analog.Sensors.MultiSensor multiSensorDC annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Mean powerTotal(f=f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-30})));
  Modelica.Blocks.Math.Mean meanCurrent(f=f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-50})));
  Modelica.Blocks.Math.Mean meanVoltage(f=f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-50})));
equation
  connect(multiSensorDC.pc,multiSensorDC. pv)
    annotation (Line(points={{-10,0},{-10,10},{0,10}}, color={0,0,255}));
  connect(multiSensorDC.nv, nv)
    annotation (Line(points={{0,-10},{0,-100}}, color={0,0,255}));
  connect(powerTotal.y, pDC) annotation (Line(points={{-50,-41},{-50,-60},{-110,-60}},
                 color={0,0,127}));
  connect(multiSensorDC.power, powerTotal.u)
    annotation (Line(points={{-11,-6},{-50,-6},{-50,-18}}, color={0,0,127}));
  connect(meanCurrent.y, iMean) annotation (Line(points={{-20,-61},{-20,-80},{-60,
          -80},{-60,-110}}, color={0,0,127}));
  connect(multiSensorDC.i, meanCurrent.u) annotation (Line(points={{-6,-11},{-6,
          -20},{-20,-20},{-20,-38}}, color={0,0,127}));
  connect(multiSensorDC.v, meanVoltage.u) annotation (Line(points={{6,-11},{6,-20},
          {20,-20},{20,-38}}, color={0,0,127}));
  connect(meanVoltage.y, vMean) annotation (Line(points={{20,-61},{20,-80},{60,-80},
          {60,-110}}, color={0,0,127}));
  connect(multiSensorDC.pc, p)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(multiSensorDC.nc, n)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  annotation (Icon(graphics={
        Text(
          extent={{-152,80},{148,120}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-100,-40},{-60,-80}},
            textColor={64,64,64},
            textString="W"),
        Text(
          extent={{-80,-60},{-40,-100}},
            textColor={64,64,64},
            textString="A"),
        Text(
          extent={{40,-60},{80,-100}},
            textColor={64,64,64},
            textString="V")}), Documentation(info="<html>
<p>
Provides mean values over one period:
</p>
<ul>
<li>power</li>
<li>voltage</li>
<li>current</li>
</ul>
</html>"));
end AnalysatorDC;
