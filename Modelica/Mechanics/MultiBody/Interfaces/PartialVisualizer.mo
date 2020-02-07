within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialVisualizer
  "Base model for visualizers (has a frame_a on the left side + outer world + assert to guarantee that the component is connected)"

  Interfaces.Frame_a frame_a "Coordinate system in which visualization data is resolved" annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
protected
  outer Modelica.Mechanics.MultiBody.World world;
equation
  assert(cardinality(frame_a) > 0,
    "Connector frame_a of visualizer object is not connected");
  annotation (Documentation(info="<html>
<p>
This partial model provides one frame_a connector, access to the world
object and an assert to check that the frame_a connector is connected.
It is used by inheritance from all visualizer objects.
</p>
</html>"));
end PartialVisualizer;
