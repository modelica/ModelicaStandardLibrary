within Modelica.Magnetic.FluxTubes.Basic;
model VariablePermeance "Variable permeance"

  extends Interfaces.TwoPorts;
  extends Modelica.Magnetic.FluxTubes.Icons.Reluctance;
  Modelica.Blocks.Interfaces.RealInput G_m(quantity="Permeance", unit="H") "Magnetic permeance"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));

equation
  G_m * V_m = Phi;

  annotation (defaultComponentName="permeance", Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}})),
      Documentation(info="<html>
<p>
The permeance of this model is controlled by a real signal input.
</p>
</html>"));
end VariablePermeance;
