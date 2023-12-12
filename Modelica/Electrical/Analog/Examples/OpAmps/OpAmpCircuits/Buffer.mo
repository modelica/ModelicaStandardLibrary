within Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits;
model Buffer "Non inverting operational amplifier circuit"
  extends PartialOpAmp;
  parameter Real k(final min=0)=1 "Desired amplification";
  parameter SI.Resistance R1=1000 "Resistance at negative pin(s)";
  parameter SI.Resistance R2=(k - 1)*R1 "Calculated resistance to reach desired amplification k";
  Basic.Resistor                            r1(final R=R1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,-70})));
  Basic.Resistor                            r2(final R=R2)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={10,-30})));
equation
  connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}},
        color={0,0,255}));
  connect(n1, n2)
    annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
  connect(n1, r1.n) annotation (Line(points={{-100,-100},{10,-100},{10,-80}},
        color={0,0,255}));
  connect(opAmp.out, r2.p)
    annotation (Line(points={{10,0},{10,-20}}, color={0,0,255}));
  connect(r2.n, r1.p)
    annotation (Line(points={{10,-40},{10,-60}}, color={0,0,255}));
  connect(r2.n, opAmp.in_n) annotation (Line(points={{10,-40},{10,-50},{-20,-50},
          {-20,6},{-10,6}}, color={0,0,255}));
  connect(opAmp.in_p, p1) annotation (Line(points={{-10,-6},{-80,-6},{-80,100},{
          -100,100}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>Non-inverting amplifier = buffer, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model.</p>
<p><code>vOut = k*vIn</code></p>
</html>"),
       Icon(graphics={
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
        Line(points={{-80,-80},{-80,40},{60,40}},                color = {0,0,127}),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,10},{100,-10}},
          textColor={0,0,255},
          textString="non-inverting")}));
end Buffer;
