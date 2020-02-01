within Modelica.Thermal.HeatTransfer.Components;
model Convection
  "Lumped thermal element for heat convection (Q_flow = Gc*dT)"
  SI.HeatFlowRate Q_flow "Heat flow rate from solid -> fluid";
  SI.TemperatureDifference dT "= solid.T - fluid.T";
  Modelica.Blocks.Interfaces.RealInput Gc(unit="W/K")
    "Signal representing the convective thermal conductance in [W/K]"
    annotation (Placement(transformation(
        origin={0,100},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Interfaces.HeatPort_a solid annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}})));
  Interfaces.HeatPort_b fluid annotation (Placement(transformation(extent={{
            90,-10},{110,10}})));
equation
  dT = solid.T - fluid.T;
  solid.Q_flow = Q_flow;
  fluid.Q_flow = -Q_flow;
  Q_flow = Gc*dT;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-62,80},{98,-80}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,80},{-60,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{-150,-90},{150,-130}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{100,0},{100,0}}, color={0,127,255}),
        Line(points={{-60,20},{76,20}}, color={191,0,0}),
        Line(points={{-60,-20},{76,-20}}, color={191,0,0}),
        Line(points={{-34,80},{-34,-80}}, color={0,127,255}),
        Line(points={{6,80},{6,-80}}, color={0,127,255}),
        Line(points={{40,80},{40,-80}}, color={0,127,255}),
        Line(points={{76,80},{76,-80}}, color={0,127,255}),
        Line(points={{-34,-80},{-44,-60}}, color={0,127,255}),
        Line(points={{-34,-80},{-24,-60}}, color={0,127,255}),
        Line(points={{6,-80},{-4,-60}}, color={0,127,255}),
        Line(points={{6,-80},{16,-60}}, color={0,127,255}),
        Line(points={{40,-80},{30,-60}}, color={0,127,255}),
        Line(points={{40,-80},{50,-60}}, color={0,127,255}),
        Line(points={{76,-80},{66,-60}}, color={0,127,255}),
        Line(points={{76,-80},{86,-60}}, color={0,127,255}),
        Line(points={{56,-30},{76,-20}}, color={191,0,0}),
        Line(points={{56,-10},{76,-20}}, color={191,0,0}),
        Line(points={{56,10},{76,20}}, color={191,0,0}),
        Line(points={{56,30},{76,20}}, color={191,0,0}),
        Text(
          extent={{22,124},{92,98}},
          textString="Gc")}),
    Documentation(info="<html>
<p>
This is a model of linear heat convection, e.g., the heat transfer between a plate and the surrounding air; see also:
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor\">ConvectiveResistor</a>.
It may be used for complicated solid geometries and fluid flow over the solid by determining the
convective thermal conductance Gc by measurements. The basic constitutive equation for convection is
</p>
<blockquote><pre>
Q_flow = Gc*(solid.T - fluid.T);
Q_flow: Heat flow rate from connector 'solid' (e.g., a plate)
   to connector 'fluid' (e.g., the surrounding air)
</pre></blockquote>
<p>
Gc = G.signal[1] is an input signal to the component, since Gc is
nearly never constant in practice. For example, Gc may be a function
of the speed of a cooling fan. For simple situations,
Gc may be <em>calculated</em> according to
</p>
<blockquote><pre>
Gc = A*h
A: Convection area (e.g., perimeter*length of a box)
h: Heat transfer coefficient
</pre></blockquote>
<p>
where the heat transfer coefficient h is calculated
from properties of the fluid flowing over the solid. Examples:
</p>
<p>
<strong>Machines cooled by air</strong> (empirical, very rough approximation according
to [<a href=\"modelica://Modelica.Thermal.HeatTransfer.UsersGuide.References\">Fischer2017</a>, p. 452]:
</p>
<blockquote><pre>
h = 7.8*v^0.78 [W/(m2.K)] (forced convection)
  = 12         [W/(m2.K)] (free convection)
where
  v: Air velocity in [m/s]
</pre></blockquote>
<p><strong>Laminar</strong> flow with constant velocity of a fluid along a
<strong>flat plate</strong> where the heat flow rate from the plate
to the fluid (= solid.Q_flow) is kept constant
(according to [<a href=\"modelica://Modelica.Thermal.HeatTransfer.UsersGuide.References\">Holman2010</a>, p.265]):
</p>
<blockquote><pre>
h  = Nu*k/x;
Nu = 0.453*Re^(1/2)*Pr^(1/3);
where
   h  : Heat transfer coefficient
   Nu : = h*x/k       (Nusselt number)
   Re : = v*x*rho/mu  (Reynolds number)
   Pr : = cp*mu/k     (Prandtl number)
   v  : Absolute velocity of fluid
   x  : distance from leading edge of flat plate
   rho: density of fluid (material constant
   mu : dynamic viscosity of fluid (material constant)
   cp : specific heat capacity of fluid (material constant)
   k  : thermal conductivity of fluid (material constant)
and the equation for h holds, provided
   Re &lt; 5e5 and 0.6 &lt; Pr &lt; 50
</pre></blockquote>
</html>"),
       Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Line(points={{100,0},{100,0}}, color={0,127,255}),
        Line(points={{100,0},{100,0}}, color={0,127,255}),
        Line(points={{100,0},{100,0}}, color={0,127,255})}));
end Convection;
