within Modelica.Mechanics.MultiBody.Examples.Loops.Utilities;
model GasForce2 "Rough approximation of gas force in a combustion engine's cylinder"
  import Modelica.Constants.pi;

  extends Modelica.Mechanics.Translational.Interfaces.PartialCompliant;
  parameter SI.Length L "Length of cylinder";
  parameter SI.Length d "Diameter of cylinder";
  parameter SI.Volume k0=0.01
    "Volume V = k0 + k1*(1-x), with x = 1 - s_rel/L";
  parameter SI.Volume k1=1
    "Volume V = k0 + k1*(1-x), with x = 1 - s_rel/L";
  parameter SI.HeatCapacity k=1 "Gas constant (p*V = k*T)";

/*
  parameter Real k0=0.01;
  parameter Real k1=1;
  parameter Real k=1;
*/
  Real x "Normalized position of cylinder (= 1 - s_rel/L)";
  SI.Density dens;
  SI.AbsolutePressure press "Cylinder pressure";
  SI.Volume V;
  SI.Temperature T;
  SI.Velocity v_rel "Relative piston velocity (<0: compression;  >0: expansion)";

protected
  constant SI.SpecificHeatCapacity R_air = Modelica.Constants.R/0.0289651159;
equation
  x = 1 - s_rel/L;
  v_rel = der(s_rel);

  press = 1e5 * (
    if v_rel < 0 then (
      if x < 0.986061 then 177.4132*x^4 - 287.2189*x^3 + 151.8252*x^2 - 24.9973*x + 2.4
      else 2836360*x^4 - 10569296*x^3 + 14761814*x^2 - 9158505*x + 2129670)
    else (
      if x > 0.933 then -3929704*x^4 + 14748765*x^3 - 20747000*x^2 + 12964477*x - 3036495
      else 145.930*x^4 - 131.707*x^3 + 17.3438*x^2 + 17.9272*x + 2.4));

  f = -press*pi*d^2/4;

  V = k0 + k1*(1 - x);
  dens = press/(R_air*T);
  press*V = k*T;

  assert(s_rel >= -1e-12, "flange_b.s - flange_a.s (= " + String(s_rel,
    significantDigits=14) + ") >= 0 required for GasForce2 component.\n" +
    "Most likely, the component has to be flipped.");
  assert(s_rel <= L + 1e-12, " flange_b.s - flange_a.s (= " + String(s_rel,
    significantDigits=14) + ") <= L (= " + String(L, significantDigits=14) +
    ") required for GasForce2 component.\n" +
    "Most likely, parameter L is not correct.");
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-90,50},{90,-50}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,4},{-65,4},{-65,15},{-90,0},{-65,-15},{-65,-4},{-50,-4},{-50,4}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-135,44},{-99,19}},
          textColor={128,128,128},
          textString="a"),
        Text(
          extent={{97,40},{133,15}},
          textColor={128,128,128},
          textString="b"),
        Polygon(
          points={{50,4},{70,4},{65,4},{65,15},{90,0},{65,-15},{65,-4},{50,-4},{50,4}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-50,-100},{30,-100}}),
        Polygon(
              points={{60,-100},{30,-90},{30,-110},{60,-100}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
        Polygon(
          points={{-30,-22},{-13.9727,-29.1797},{10,-30},{54,-32},{70,-30},{70,-26},{48,-22},{14,-16},{-4,-8},{-18,4},{-24,22},{-28,38},{-30,28},{-32,8},{-32,-4},{-30,-22}},
          lineColor={95,95,95},
          smooth=Smooth.Bezier),
        Line(points={{-46,-40},{76,-40}}, color={135,135,135}),
        Line(points={{-40,-46},{-40,40}}, color={135,135,135}),
        Text(extent={{-140,-60},{140,-90}}, textString="L=%L")}),
    Diagram(
        coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-90,50},{90,-50}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{12,5},{70,5},{65,5},{65,16},{90,1},{65,-14},{65,-3},{12,-3},
              {12,5}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-13,5},{-16,5},{-65,5},{-65,16},{-90,1},{-65,-14},{-65,-3},
              {-13,-3},{-13,5}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
The gas force in a cylinder of a combustion engine is computed as function of the relative
distance of the two flanges. It is required that s_rel&nbsp;=&nbsp;flange_b.s&nbsp;-&nbsp;flange_a.s
is in the range
</p>
<blockquote><pre>
0 &le; s_rel &le; L,
</pre></blockquote>
<p>
where the parameter&nbsp;L is the length of the cylinder.
If this assumption is not fulfilled, an error occurs.
The resulting approximation of the gas pressure is shown in
the following figure and depends on both s_rel and
the relative velocity v_rel&nbsp;=&nbsp;der(s_rel).
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Utilities/gasForceCycle.png\"
alt=\"model Modelica.Mechanics.MultiBody.Examples.Loops.Utilities.GasForce2\">
</blockquote>
</html>"));
end GasForce2;
