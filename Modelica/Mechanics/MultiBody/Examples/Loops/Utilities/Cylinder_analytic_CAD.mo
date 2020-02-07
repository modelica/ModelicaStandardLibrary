within Modelica.Mechanics.MultiBody.Examples.Loops.Utilities;
model Cylinder_analytic_CAD
  "One cylinder with analytic handling of kinematic loop and CAD visualization"
  extends CylinderBase;
  Visualizers.FixedShape crankShape(
    animation=animation,
    shapeType="modelica://Modelica/Resources/Data/Shapes/Engine/crank.dxf",
    lengthDirection={1,0,0},
    extra=1,
    widthDirection={0,1,0},
    length=crankPinOffset/0.5,
    width=crankPinOffset/0.5,
    height=crankPinOffset/0.5,
    r_shape={crankLength - crankPinLength/2 - 0.002,0,0})
    annotation (Placement(transformation(
        origin={-90,-30},
        extent={{-10,10},{10,-10}},
        rotation=180)));
equation

  connect(crankShape.frame_a, crankAngle.frame_b)
    annotation (Line(
      points={{-80,-30},{-70,-30},{-70,-60}},
      color={95,95,95},
      thickness=0.5));
  annotation (Documentation(info="<html>
<p>
Slider-crank mechanism with analytic handling of kinematic loop to model one cylinder in an engine.
</p>
</html>"));
end Cylinder_analytic_CAD;
