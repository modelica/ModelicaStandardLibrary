within Modelica.Electrical.Machines.SpacePhasors.Components;
model SpacePhasor
  "Physical transformation: three-phase <-> space phasors"
  import Modelica.Constants.pi;
  constant Integer m=3 "Number of phases";
  parameter Real turnsRatio=1 "Turns ratio";
  SI.Voltage v[m] "Instantaneous phase voltages";
  SI.Current i[m] "Instantaneous phase currents";
protected
  parameter Real TransformationMatrix[2, m]=2/m*{{cos(+(k - 1)/m*2*pi)
      for k in 1:m},{+sin(+(k - 1)/m*2*pi) for k in 1:m}};
  parameter Real InverseTransformation[m, 2]={{cos(-(k - 1)/m*2*pi),-sin(
      -(k - 1)/m*2*pi)} for k in 1:m};
public
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p(final m=m)
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_n(final m=m)
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin zero annotation (
      Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin ground annotation (
      Placement(transformation(extent={{90,-110},{110,-90}})));
  Machines.Interfaces.SpacePhasor spacePhasor
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
equation
  v/turnsRatio = plug_p.pin.v - plug_n.pin.v;
  i*turnsRatio = +plug_p.pin.i;
  i*turnsRatio = -plug_n.pin.i;
  m*zero.v = sum(v);
  spacePhasor.v_ = TransformationMatrix*v;
  //v  = fill(zero.v,m) + InverseTransformation*spacePhasor.v_;
  -m*zero.i = sum(i);
  -spacePhasor.i_ = TransformationMatrix*i;
  //-i  = fill(zero.i,m) + InverseTransformation*spacePhasor.i_;
  ground.v = 0;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{0,0},{80,80},{60,72},{72,60},{80,80}}, color={0,0,255}),
        Line(points={{0,0},{80,-80},{72,-60},{60,-72},{80,-80}}, color={0,0,255}),
        Line(
          points={{-80,0},{-73.33,10},{-66.67,17.32},{-60,20},{-53.33,
              17.32},{-46.67,10},{-40,0},{-33.33,-10},{-26.67,-17.32},{-20,
              -20},{-13.33,-17.32},{-6.67,-10},{0,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-90,0},{-83.33,10},{-76.67,17.32},{-70,20},{-63.33,
              17.32},{-56.67,10},{-50,0},{-43.33,-10},{-36.67,-17.32},{-30,
              -20},{-23.33,-17.32},{-16.67,-10},{-10,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-70,0},{-63.33,10},{-56.67,17.32},{-50,20},{-43.33,
              17.32},{-36.67,10},{-30,0},{-23.33,-10},{-16.67,-17.32},{-10,
              -20},{-3.33,-17.32},{3.33,-10},{10,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Text(
          extent={{-150,-120},{150,-160}},
          textColor={0,0,255},
          textString="%name"),
        Text(
          extent={{40,10},{90,-10}},
          textColor={0,0,255},
          textString="zero"),
        Line(points={{90,-100},{60,-100}}, color={0,0,255}),
        Line(points={{60,-84},{60,-116}}, color={0,0,255}),
        Line(points={{50,-90},{50,-110}}, color={0,0,255}),
        Line(points={{40,-96},{40,-104}}, color={0,0,255})}),
      Documentation(info="<html>
Physical transformation of voltages and currents: three-phases &lt;-&gt; space phasors:<br>
x[k] = X0 + {cos(-(k - 1)/m*2*pi),-sin(-(k - 1)/m*2*pi)}*X[Re,Im]<br>
and vice versa:<br>
X0 = sum(x[k])/m<br>
X[Re,Im] = sum(2/m*{cos((k - 1)/m*2*pi),sin((k - 1)/m*2*pi)}*x[k])<br>
were x designates three-phase values, X[Re,Im] designates the space phasor and X0 designates the zero sequence system.<br>
<em>Physical transformation</em> means that both voltages and currents are transformed in both directions.<br>
Zero-sequence voltage and current are present at pin zero. An additional zero-sequence impedance could be connected between pin zero and pin ground.
</html>"));
end SpacePhasor;
