within Modelica.Magnetic.FluxTubes.Basic;
model ConstantPermeance "Constant permeance"

  extends Interfaces.TwoPorts;

  parameter SI.Permeance G_m=1 "Magnetic permeance";

equation
  G_m * V_m = Phi;

  annotation (defaultComponentName="permeance", Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Rectangle(
        extent={{-70,30},{70,-30}},
        lineColor={255,128,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Line(points={{-70,0},{-90,0}}, color={255,128,0}),
      Line(points={{70,0},{90,0}}, color={255,128,0}),
        Text(
          extent={{-150,50},{150,90}},
          textColor={0,0,255},
          textString="%name")}),Documentation(info="<html>
<p>
This constant permeance is provided for test purposes and simple magnetic network models. The permeance is not calculated from geometry and permeability of a flux tube, but is provided as parameter.
</p>
</html>",
      revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian Kral)</h5>
<ul>
<li>Added constant permeance model</li>
</ul>

</html>"));
end ConstantPermeance;
