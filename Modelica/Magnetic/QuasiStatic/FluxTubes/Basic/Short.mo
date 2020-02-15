within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model Short "Short cut branch"
  extends Interfaces.TwoPort;
equation
  V_m = Complex(0,0);
annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{-100,0},{100,0}}, color={255,170,85}),
      Text(
        extent={{-150,50},{150,90}},
        textString="%name",
        textColor={0,0,255})}), Documentation(
        info="<html>
<p>
This is a simple short cut branch. The magnetic voltage of this component is equal to zero.
</p></html>",
          revisions="<html>
</html>"));
end Short;
