within Modelica.Magnetic.FluxTubes.Basic;
model EddyCurrent
  "For modelling of eddy current in a conductive magnetic flux tube"

  extends Interfaces.TwoPort;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(
    final T=273.15);

  parameter Boolean useConductance = false
    "Use conductance instead of geometry data and rho"
    annotation(Evaluate=true, choices(checkBox=true));
  parameter SI.Conductance G(min=0) = 1/0.098e-6
    "Equivalent loss conductance G=A/rho/l"
    annotation(Dialog(enable=useConductance),Evaluate=true);
  parameter SI.Resistivity rho=0.098e-6
    "Resistivity of flux tube material (default: Iron at 20degC)"
    annotation(Dialog(enable=not useConductance));
  parameter SI.Length l=1 "Average length of eddy current path"
    annotation(Dialog(enable=not useConductance));
  parameter SI.Area A=1 "Cross sectional area of eddy current path"
    annotation(Dialog(enable=not useConductance));

  final parameter SI.Resistance R=rho*l/A
    "Electrical resistance of eddy current path"
    annotation(Dialog(enable=not useConductance));

equation
  LossPower = V_m*der(Phi);
  V_m =(if useConductance then G else 1/R) * der(Phi);
  //Magnetic voltage drop in magnetic network due to eddy current
  annotation (Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Rectangle(
        extent={{-70,30},{70,-30}},
        lineColor={255,128,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Line(points={{-70,0},{-90,0}}, color={255,128,0}),
      Line(points={{70,0},{90,0}}, color={255,128,0}),
      Rectangle(
        extent={{-70,30},{70,-30}},
        lineColor={255,128,0},
        fillColor={255,128,0},
        fillPattern=FillPattern.Solid),
      Text(
        extent={{-150,50},{150,90}},
        textString="%name",
        textColor={0,0,255})}), Documentation(info="<html>
<p>
Eddy currents are induced in a conductive magnetic flux tube when the flux changes with time. This causes a magnetic voltage drop in addition to the voltage drop that is due to the reluctance of this flux tube. The eddy current component can be thought of as a short-circuited secondary winding of a transformer with only one turn. Its resistance is calculated from the geometry and resistivity of the eddy current path.
</p>

<p>
Partitioning of a solid conductive cylinder or prism into several hollow cylinders or separate nested prisms and modelling of each of these flux tubes connected in parallel with a series connection of a reluctance element and an eddy current component can model the delayed buildup of the magnetic field in the complete flux tube from the outer to the inner sections. Please refer to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ka08]</a> for an illustration.
</p>
</html>", revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian&nbsp;Kral)</h5>
<ul>
<li>Added parameter <code>useConductance</code> including alternative parameterization</li>
</ul>
</html>"));
end EddyCurrent;
