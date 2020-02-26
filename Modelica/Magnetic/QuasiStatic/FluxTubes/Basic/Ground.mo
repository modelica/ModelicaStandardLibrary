within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model Ground "Zero magnetic potential"

  FluxTubes.Interfaces.PositiveMagneticPort port annotation (Placement(transformation(extent={{-10,110},{10,90}}, rotation=-0)));
equation
  port.V_m = Complex(0);
  annotation (
    Documentation(info="<html>
<p>
The magnetic potential at the magnetic ground node is zero. Every magnetic network model must contain at least one magnetic ground object.
</p>
</html>"),
    Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Line(points={{-60,50},{60,50}}, color={255,170,85}),
      Line(points={{-40,30},{40,30}}, color={255,170,85}),
      Line(points={{-20,10},{20,10}}, color={255,170,85}),
      Line(points={{0,90},{0,50}}, color={255,170,85}),
      Text(
        extent={{-150,-50},{150,-10}},
        textColor={0,0,255},
        textString="%name")}));
end Ground;
