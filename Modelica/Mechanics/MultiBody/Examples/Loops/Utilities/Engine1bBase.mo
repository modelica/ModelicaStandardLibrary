within Modelica.Mechanics.MultiBody.Examples.Loops.Utilities;
partial block Engine1bBase
  "Base model for one cylinder engine with gas force"
  extends Engine1Base;

  GasForce2 gasForce(d=0.1, L=0.35)
    annotation (Placement(transformation(
      origin={90,80},
      extent={{10,-10},{-10,10}},
      rotation=90)));
end Engine1bBase;
