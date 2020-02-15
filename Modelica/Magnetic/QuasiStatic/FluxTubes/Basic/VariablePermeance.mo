within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model VariablePermeance "Variable permeance"

  extends Interfaces.TwoPort;
  extends Modelica.Magnetic.QuasiStatic.FluxTubes.Icons.Reluctance;

  Blocks.Interfaces.RealInput G_m(quantity="Permeance", unit="H") "Magnetic permeance"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
equation
  G_m * V_m = Phi;

  annotation (Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Line(points={{70,0},{90,0}}, color={255,170,85}),
      Text(
        extent={{-150,50},{150,90}},
        textString="%name",
        textColor={0,0,255})}), Documentation(info="<html>
<p>
This constant permeance is provided for test purposes and simple magnetic network models. The permeance is not calculated from geometry and permeability of a flux tube, but is provided as parameter.
</p>
</html>",
      revisions="<html>
</html>"));
end VariablePermeance;
