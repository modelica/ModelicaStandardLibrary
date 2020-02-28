within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model Idle "Idle running branch"
  extends Interfaces.TwoPort;
equation
  Phi = Complex(0);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-100,0},{-40,0}}, color={255,170,85}),
        Line(points={{40,0},{100,0}}, color={255,170,85}),
      Text(
        extent={{-150,50},{150,90}},
        textString="%name",
        textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This is a simple idle running branch. The magnetic flux through this component is equal to zero.
</p></html>",
      revisions="<html>
</html>"));
end Idle;
