within Modelica.Magnetic.FluxTubes.Basic;
model ConstantPermeance "Constant permeance"

  extends Interfaces.TwoPort;
  extends Modelica.Magnetic.FluxTubes.Icons.Reluctance;
  parameter SI.Permeance G_m=1 "Magnetic permeance";

equation
  G_m * V_m = Phi;

  annotation (defaultComponentName="permeance", Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,-40},{150,-80}},
          textColor={0,0,0},
          textString="G_m=%G_m")}),
                                Documentation(info="<html>
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
