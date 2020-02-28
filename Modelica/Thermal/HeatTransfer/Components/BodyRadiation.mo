within Modelica.Thermal.HeatTransfer.Components;
model BodyRadiation "Lumped thermal element for radiation heat transfer"
  extends Interfaces.Element1D;
  parameter Real Gr(unit="m2")
    "Net radiation conductance between two surfaces (see docu)";
equation
  Q_flow = Gr*Modelica.Constants.sigma*(port_a.T^4 - port_b.T^4);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{50,80},{90,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-90,80},{-50,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Line(points={{-36,10},{36,10}}, color={191,0,0}),
        Line(points={{-36,10},{-26,16}}, color={191,0,0}),
        Line(points={{-36,10},{-26,4}}, color={191,0,0}),
        Line(points={{-36,-10},{36,-10}}, color={191,0,0}),
        Line(points={{26,-16},{36,-10}}, color={191,0,0}),
        Line(points={{26,-4},{36,-10}}, color={191,0,0}),
        Line(points={{-36,-30},{36,-30}}, color={191,0,0}),
        Line(points={{-36,-30},{-26,-24}}, color={191,0,0}),
        Line(points={{-36,-30},{-26,-36}}, color={191,0,0}),
        Line(points={{-36,30},{36,30}}, color={191,0,0}),
        Line(points={{26,24},{36,30}}, color={191,0,0}),
        Line(points={{26,36},{36,30}}, color={191,0,0}),
        Text(
          extent={{-150,125},{150,85}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-90},{150,-120}},
          textString="Gr=%Gr"),
        Rectangle(
          extent={{-50,80},{-44,-80}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{45,80},{50,-80}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This is a model describing the thermal radiation, i.e., electromagnetic
radiation emitted between two bodies as a result of their temperatures.
The following constitutive equation is used:
</p>
<blockquote><pre>
Q_flow = Gr*sigma*(port_a.T^4 - port_b.T^4);
</pre></blockquote>
<p>
where Gr is the radiation conductance and sigma is the Stefan-Boltzmann
constant (= Modelica.Constants.sigma). Gr may be determined by
measurements and is assumed to be constant over the range of operations.
</p>
<p>
For simple cases, Gr may be analytically computed. The analytical
equations use epsilon, the emission value of a body which is in the
range 0..1. Epsilon=1, if the body absorbs all radiation (= black body).
Epsilon=0, if the body reflects all radiation and does not absorb any.
</p>
<blockquote><pre>
Typical values for epsilon:
aluminium, polished    0.04
copper, polished       0.04
gold, polished         0.02
paper                  0.09
rubber                 0.95
silver, polished       0.02
wood                   0.85..0.9
</pre></blockquote>
<p><strong>Analytical Equations for Gr</strong></p>
<p>
<strong>Small convex object in large enclosure</strong>
(e.g., a hot machine in a room):
</p>
<blockquote><pre>
Gr = e*A
where
   e: Emission value of object (0..1)
   A: Surface area of object where radiation
      heat transfer takes place
</pre></blockquote>
<p><strong>Two parallel plates</strong>:</p>
<blockquote><pre>
Gr = A/(1/e1 + 1/e2 - 1)
where
   e1: Emission value of plate1 (0..1)
   e2: Emission value of plate2 (0..1)
   A : Area of plate1 (= area of plate2)
</pre></blockquote>
<p><strong>Two long cylinders in each other</strong>, where radiation takes
place from the inner to the outer cylinder):
</p>
<blockquote><pre>
Gr = 2*pi*r1*L/(1/e1 + (1/e2 - 1)*(r1/r2))
where
   pi: = Modelica.Constants.pi
   r1: Radius of inner cylinder
   r2: Radius of outer cylinder
   L : Length of the two cylinders
   e1: Emission value of inner cylinder (0..1)
   e2: Emission value of outer cylinder (0..1)
</pre></blockquote>
</html>"));
end BodyRadiation;
