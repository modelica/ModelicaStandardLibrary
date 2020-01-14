within Modelica.Magnetic.FluxTubes.Basic;
model VariableReluctance "Variable reluctance"

  extends Interfaces.TwoPorts;
  extends Modelica.Magnetic.FluxTubes.Icons.Reluctance;
  Modelica.Blocks.Interfaces.RealInput R_m(quantity="Reluctance", unit="H-1") "Magnetic reluctance"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));

equation
  V_m = Phi*R_m;

  annotation (defaultComponentName="reluctance", Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}})),
      Documentation(info="<html>
<p>
This constant reluctance is provided for test purposes and simple magnetic network models. The reluctance is not calculated from geometry and permeability of a flux tube, but is provided as parameter.
</p>
</html>", revisions=""));
end VariableReluctance;
