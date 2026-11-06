within Modelica.Mechanics.MultiBody.Interfaces;
partial model OneFrame_a
  "Base model for components providing one frame_a connector and outer world"

  Interfaces.Frame_a frame_a
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
protected
  outer Modelica.Mechanics.MultiBody.World world;

  annotation (Documentation(info="<html>
<p>
This partial model provides one frame_a connector and access to
the world object.
Therefore, inherit from this partial model if both is needed.
</p>
</html>"));
end OneFrame_a;
