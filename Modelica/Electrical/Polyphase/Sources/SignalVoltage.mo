within Modelica.Electrical.Polyphase.Sources;
model SignalVoltage "Polyphase signal voltage source"
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  SI.Current i[m]=plug_p.pin.i
    "Currents flowing into positive plugs";
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput v[m](each unit="V")
    "Voltage between pin p and n (= p.v - n.v) as input signal" annotation (
     Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage[m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(signalVoltage.p, plug_p.pin)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(signalVoltage.n, plug_n.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(v, signalVoltage.v)
    annotation (Line(points={{0,120},{0,12}}, color={0,0,255}));
  annotation (
    Icon(graphics={Line(points={{-90,0},{-50,0}}, color={0,0,255}),
          Line(points={{50,0},{90,0}}, color={0,0,255}),Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{-50,0},{50,0}},
          color={0,0,255}),Text(
              extent={{-150,60},{150,100}},
              textString="%name",
              textColor={0,0,255}),
        Text(
          extent={{150,-100},{-150,-60}},
          textString="m=%m"),
        Line(points={{-70,30},{-70,10}}, color={0,0,255}),
        Line(points={{-80,20},{-60,20}}, color={0,0,255}),
        Line(points={{60,20},{80,20}}, color={0,0,255})}),
                                 Documentation(info="<html>
<p>
Contains m signal controlled voltage sources (Modelica.Electrical.Analog.Sources.SignalVoltage)
</p>
</html>"));
end SignalVoltage;
