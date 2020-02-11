within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialOneFrame_b
  "Base model for components providing one frame_b connector + outer world + assert to guarantee that the component is connected"

  Interfaces.Frame_b frame_b "Coordinate system fixed to the component with one cut-force and cut-torque" annotation (Placement(transformation(extent={{84,-16},{116,16}})));
protected
  outer Modelica.Mechanics.MultiBody.World world;
equation
  assert(cardinality(frame_b) > 0,
    "Connector frame_b of component is not connected");
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{94,-20},{130,-45}},
          textColor={128,128,128},
          textString="b")}),
    Documentation(info="<html>
<p>
This partial model provides one frame_b connector, access to the world
object and an assert to check that the frame_b connector is connected.
Therefore, inherit from this partial model if the frame_b connector is
needed and if this connector should be connected for a correct model.
</p>
</html>"));
end PartialOneFrame_b;
