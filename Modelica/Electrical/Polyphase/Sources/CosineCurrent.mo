within Modelica.Electrical.Polyphase.Sources;
model CosineCurrent "Polyphase cosine current source"
  extends Interfaces.TwoPlug;
  parameter SI.Current I[m](start=fill(1, m))
    "Amplitudes of cosine waves";
  parameter SI.Angle phase[m]=-
      Polyphase.Functions.symmetricOrientation(                    m)
    "Phases of cosine waves";
  parameter SI.Frequency f[m](start=fill(1, m))
    "Frequencies of cosine waves";
  parameter SI.Current offset[m]=zeros(m) "Current offsets";
  parameter SI.Time startTime[m]=zeros(m) "Time offsets";
  Modelica.Electrical.Analog.Sources.CosineCurrent cosineCurrent[m](
    final I=I,
    final phase=phase,
    final f=f,
    final offset=offset,
    final startTime=startTime)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(cosineCurrent.p, plug_p.pin)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(cosineCurrent.n, plug_n.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
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
                              Line(
              points={{-71,70},{-68.4,69.8},{-63.5,67},{-58.6,61},{-53.6,52},{-48,38.6},{-40.98,18.6},{-26.21,-26.9},{-19.9,-44},{-14.2,-56.2},{-9.3,-64},{-4.4,-68.6},{0.5,-70},{5.5,-67.9},{10.4,-62.5},{15.3,-54.1},{20.9,-41.3},{28,-21.7},{35,0}},
              color={192,192,192},
              smooth=Smooth.Bezier),Line(points={{35,0},{44.8,29.9},{51.2,46.5},{56.8,58.1},{61.7,65.2},{66.7,69.2},{71.6,69.8}},
                                                                  color={
          192,192,192}), Text(
              extent={{-150,60},{150,100}},
              textString="%name",
              textColor={0,0,255}),
        Text(
          extent={{150,-100},{-150,-60}},
          textString="m=%m")}), Documentation(info="<html>
<p>
Contains m cosine current sources (Modelica.Electrical.Analog.Sources.CosineCurrent)
with a default phase shift determined by
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a>.
</p>
</html>"));
end CosineCurrent;
