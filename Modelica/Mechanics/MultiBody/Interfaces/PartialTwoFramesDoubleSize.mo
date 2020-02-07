within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialTwoFramesDoubleSize
  "Base model for components providing two frame connectors + outer world + assert to guarantee that the component is connected (default icon size is factor 2 larger as usual)"

  Interfaces.Frame_a frame_a "Coordinate system fixed to the component with one cut-force and cut-torque" annotation (Placement(transformation(extent={{-108,-8},{-92,8}})));
  Interfaces.Frame_b frame_b "Coordinate system fixed to the component with one cut-force and cut-torque" annotation (Placement(transformation(extent={{92,-8},{108,8}})));

protected
  outer Modelica.Mechanics.MultiBody.World world;
equation
  assert(cardinality(frame_a) > 0,
    "Connector frame_a of component is not connected");
  assert(cardinality(frame_b) > 0,
    "Connector frame_b of component is not connected");
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.2), graphics={Text(
          extent={{-117,-13},{-106,-23}},
          textColor={128,128,128},
          textString="a"), Text(
          extent={{110,-15},{122,-25}},
          textColor={128,128,128},
          textString="b")}),
    Documentation(info="<html>
<p>
This partial model provides two frame connectors, access to the world
object and an assert to check that both frame connectors are connected.
Therefore, inherit from this partial model if the two frame connectors are
needed and if the two frame connectors should be connected for a correct model.
</p>
<p>
When dragging \"PartialTwoFrames\", the default size is a factor of two
larger as usual. This partial model is used by the Joint.Assemblies
joint aggregation models.
</p>
</html>"));
end PartialTwoFramesDoubleSize;
