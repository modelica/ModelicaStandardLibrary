within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model EddyCurrent
"For modelling of eddy current in a conductive magnetic flux tube"

  constant Complex j=Complex(0, 1);
  extends Interfaces.TwoPort;

  parameter Boolean useConductance = false
  "Use conductance instead of geometry data and rho"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
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

  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
      final T=273.15);

equation
  lossPower = (pi/2)*Modelica.ComplexMath.imag(omega*V_m*
    Modelica.ComplexMath.conj(Phi));
  // Alternative calculation of loss power
  // lossPower = -(pi/2)*Modelica.ComplexMath.real(j*omega*V_m*Modelica.ComplexMath.conj(Phi));
  if G > 0 then
    (pi/2)*V_m = j*omega*Phi * (if useConductance then G else 1/R);
  else
    V_m = Complex(0, 0);
  end if;

  annotation (Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Line(points={{-70,0},{-90,0}}, color={255,170,85}),
      Line(points={{70,0},{90,0}}, color={255,170,85}),
      Rectangle(
          extent={{-70,30},{70,-30}},
          lineColor={255,170,85},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid),
      Text(
        extent={{-150,50},{150,90}},
        textString="%name",
        textColor={0,0,255})}), Documentation(info="<html>
<p>
Eddy currents are induced in a conductive magnetic flux tube when the flux changes with time. This causes a magnetic voltage drop in addition to the voltage drop that is due to the reluctance of this flux tube. The eddy current component can be thought of as a short-circuited secondary winding of a transformer with only one turn. Its resistance is then determined by the geometry and resistivity of the eddy current path. Alternatively, a total conductance parameter can be used.
</p>

<p>
Partitioning of a solid conductive cylinder or prism into several hollow cylinders or separate nested prisms and modelling of each of these flux tubes connected in parallel with a series connection of a reluctance element and an eddy current component can model the delayed buildup of the magnetic field in the complete flux tube from the outer to the inner sections. Please refer to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ka08]</a> for an illustration.
</p>
</html>", revisions="<html>
</html>"));
end EddyCurrent;
