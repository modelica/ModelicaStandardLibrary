within Modelica.Electrical.Polyphase.Sources;
model SignalCurrent "Polyphase signal current source"
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  SI.Voltage v[m]=plug_p.pin.v - plug_n.pin.v
    "Voltage drops between the two plugs";
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput i[m](each unit="A")
    "Current flowing from pin p to pin n as input signal" annotation (
      Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent[m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(signalCurrent.p, plug_p.pin)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(signalCurrent.n, plug_n.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(i, signalCurrent.i)
    annotation (Line(points={{0,120},{0,12}}, color={0,0,255}));
  annotation (
    Icon(graphics={Line(points={{-90,0},{-50,0}}, color={0,0,255}),
          Line(points={{50,0},{90,0}}, color={0,0,255}),Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{0,50},{0,-50}},
          color={0,0,255}), Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
                           Text(
              extent={{-150,60},{150,100}},
              textString="%name",
              textColor={0,0,255}),
        Text(
          extent={{150,-100},{-150,-60}},
          textString="m=%m")}), Documentation(info="<html>
<p>
Contains m signal controlled current sources (Modelica.Electrical.Analog.Sources.SignalCurrent)
</p>
</html>"));
end SignalCurrent;
