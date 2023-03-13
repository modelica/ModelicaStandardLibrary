within Modelica.Mechanics.MultiBody.Interfaces;
partial model TwoFrames
  "Base model for components providing two frame connectors and outer world"

  Interfaces.Frame_a frame_a
    "Coordinate system a fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b
    "Coordinate system b fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));
protected
  outer Modelica.Mechanics.MultiBody.World world;

  annotation (
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
      graphics={
        Text(
          extent={{-136,-25},{-100,-50}},
          textColor={128,128,128},
          textString="a"),
        Text(
          extent={{100,-25},{136,-50}},
          textColor={128,128,128},
          textString="b")}),
    Documentation(info="<html>
<p>
This partial model provides two frame connectors and access to
the world object.
Therefore, inherit from this partial model if the two frame
connectors are needed.
</p>
</html>"));
end TwoFrames;
