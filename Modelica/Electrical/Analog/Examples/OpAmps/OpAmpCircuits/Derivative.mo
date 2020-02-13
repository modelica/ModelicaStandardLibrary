within Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits;
model Derivative "Lowpass filter operational amplifier circuit"
  extends PartialOpAmp;
  import Modelica.Constants.pi;
  parameter Real k(final min=0)=1 "Desired amplification";
  parameter SI.Resistance R1=1000 "Resistance at negative input of OpAmp";
  parameter SI.Resistance R2=k*R1 "Calculated resistance to reach k";
  parameter SI.Time T "Time constant";
  parameter SI.Capacitance C=T/R1 "Calculated capacitance to reach T";
  SI.Voltage v(start=0)=c.v "Capacitor voltage = state";
  Basic.Resistor                            r1(R=R1)
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Basic.Resistor                            r2(R=R2)
    annotation (Placement(transformation(extent={{30,20},{10,40}})));
  Basic.Capacitor                            c(C=C)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
equation
  connect(n1, n2)
    annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
  connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}},
        color={0,0,255}));
  connect(n1, opAmp.in_p) annotation (Line(points={{-100,-100},{-10,-100},{-10,-6}},
        color={0,0,255}));
  connect(r1.n, opAmp.in_n)
    annotation (Line(points={{-30,30},{-10,30},{-10,6}}, color={0,0,255}));
  connect(opAmp.in_n, r2.n)
    annotation (Line(points={{-10,6},{-10,30},{10,30}}, color={0,0,255}));
  connect(opAmp.out, r2.p)
    annotation (Line(points={{10,0},{30,0},{30,30}}, color={0,0,255}));
  connect(c.n, r1.p)
    annotation (Line(points={{-60,30},{-50,30}}, color={0,0,255}));
  connect(c.p, p1)
    annotation (Line(points={{-80,30},{-80,100},{-100,100}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>Inverting highpass filter = derivative, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model.</p>
<p>Transfer function: <code>vOut/vIn = -k*s/(1 + s*T)</code></p>
</html>"),
       Icon(graphics={
  Polygon(lineColor={192,192,192},
    fillColor={192,192,192},
    fillPattern=FillPattern.Solid,
    points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
    Line(points={{-80.0,78.0},{-80.0,-90.0}},
      color={192,192,192}),
  Line(origin = {-24.667,-27.333},
    points = {{-55.333,87.333},{-19.333,-40.667},{86.667,-52.667}},
    color = {0,0,127},
    smooth = Smooth.Bezier),
  Line(points={{-90.0,-80.0},{82.0,-80.0}},
    color={192,192,192}),
  Polygon(lineColor={192,192,192},
    fillColor={192,192,192},
    fillPattern=FillPattern.Solid,
    points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}})}));
end Derivative;
