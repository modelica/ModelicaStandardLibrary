within Modelica.Magnetic.FluxTubes.Basic;
model VariableReluctance "Variable reluctance"

  extends Interfaces.TwoPort;
  extends Modelica.Magnetic.FluxTubes.Icons.Reluctance;
  Modelica.Blocks.Interfaces.RealInput R_m(quantity="Reluctance", unit="H-1") "Magnetic reluctance"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));

equation
  V_m = Phi*R_m;

  annotation (defaultComponentName="reluctance",      Documentation(info="<html>
<p>
The reluctance of this model is controlled by a real signal input.
</p>
</html>"));
end VariableReluctance;
