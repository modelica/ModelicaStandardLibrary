within Modelica.Magnetic.FluxTubes.Basic;
model Short "Short cut branch"
  extends Interfaces.TwoPortElementary;

equation
  connect(port_p, port_n) annotation (Line(points={{-100,0},{-1,0},{-1,0},{100,0}}, color={255,128,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{-100,0},{100,0}}, color={255,128,0}),
        Text(
          extent={{-150,50},{150,90}},
          textColor={0,0,255},
          textString="%name")}),                              Documentation(
        info="<html>
<p>
This is a simple short cut branch.
</p>

</html>", revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian Kral)</h5>
<ul>
<li>Added short model</li>
</ul>

</html>"));
end Short;
