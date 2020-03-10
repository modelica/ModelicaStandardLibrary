within Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits;
model Integrator "Integrating operational amplifier circuit"
  extends PartialOpAmp(v2(start=0));
  import Modelica.Constants.pi;
  parameter Real k(final min=0)=1 "Desired amplification at frequency f";
  parameter SI.Frequency f "Frequency";
  parameter SI.Resistance R=1000 "Resistance at negative input of OpAmp";
  parameter SI.Capacitance C=1/k/(2*pi*f*R) "Calculated capacitance to reach desired amplification k";
  SI.Voltage v(start=0)=c.v "Capacitor voltage = state";
  Basic.Capacitor  c(final C=C)
    annotation (Placement(transformation(extent={{30,20},{10,40}})));
  Basic.Resistor r(final R=R)
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
equation
  connect(n1, n2)
    annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
  connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}},
        color={0,0,255}));
  connect(n1, opAmp.in_p) annotation (Line(points={{-100,-100},{-10,-100},{-10,-6}},
        color={0,0,255}));
  connect(r.p, p1) annotation (Line(points={{-50,30},{-80,30},{-80,100},{-100,100}},
        color={0,0,255}));
  connect(r.n, opAmp.in_n)
    annotation (Line(points={{-30,30},{-10,30},{-10,6}}, color={0,0,255}));
  connect(opAmp.in_n, c.n)
    annotation (Line(points={{-10,6},{-10,30},{10,30}}, color={0,0,255}));
  connect(opAmp.out, c.p)
    annotation (Line(points={{10,0},{30,0},{30,30}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>Inverting integrator, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model.</p>
<p><code>k*vin = -der(dvOut)</code></p>
</html>"),
       Icon(graphics={
          Polygon(
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
          Line(
            points={{-80.0,78.0},{-80.0,-90.0}},
            color={192,192,192}),
          Line(
            points=DynamicSelect({{-80.0,-80.0},{80.0,80.0}}, if use_reset then {{-80.0,-80.0},{60.0,60.0},{60.0,-80.0},{80.0,-60.0}} else {{-80.0,-80.0},{80.0,80.0}}),
            color={0,0,127}),
          Line(
            points={{-90.0,-80.0},{82.0,-80.0}},
            color={192,192,192}),
          Polygon(
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}}),
                          Text(
          extent={{-80,40},{0,-40}},
          textColor={0,0,255},
          textString="I")}));
end Integrator;
