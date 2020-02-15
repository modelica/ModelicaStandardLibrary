within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model VariableReluctance "Variable reluctance"

  extends Interfaces.TwoPort;
  extends Modelica.Magnetic.QuasiStatic.FluxTubes.Icons.Reluctance;

  Blocks.Interfaces.RealInput R_m(quantity="Reluctance", unit="H-1") "Magnetic reluctance"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
equation
  V_m = Phi*R_m;

  annotation (Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Line(points={{70,0},{90,0}}, color={255,170,85}),
      Text(
        extent={{-150,50},{150,90}},
        textString="%name",
        textColor={0,0,255})}), Documentation(info="<html>
<p>
The reluctance of this model is controlled by a real signal input.
</p>
</html>"));
end VariableReluctance;
