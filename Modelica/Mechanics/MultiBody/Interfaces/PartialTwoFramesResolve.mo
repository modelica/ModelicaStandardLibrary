within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialTwoFramesResolve
  "Base model for components providing two frame connectors, frame_resolve connector and outer world"

  Interfaces.Frame_a frame_a "Coordinate system a fixed to the component with one cut-force and cut-torque" annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b "Coordinate system b fixed to the component with one cut-force and cut-torque" annotation (Placement(transformation(extent={{84,-16},{116,16}})));
  Interfaces.Frame_resolve frame_resolve
    "Coordinate system in which input/output vector is optionally resolved"
    annotation (Placement(transformation(extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={0,-100})));
protected
  outer Modelica.Mechanics.MultiBody.World world;

  annotation (
    Documentation(info="<html>
<p>
This partial model provides two frame connectors, a&nbsp;frame connector
<code>frame_resolve</code> for resolving input/output or whatever vector
in this frame, and access to the protected outer world object.
This partial class can, thus, cover a&nbsp;wide range of use cases.
If either of the components is not needed in the extending class, it can
be simply disabled &ndash; such as the connector <code>frame_a</code> in
the following.
</p>

<blockquote><pre>
<strong>model</strong> A
  <strong>extends</strong> Interfaces.PartialTwoFramesResolve(
    <strong>break</strong> frame_a);
  ...
<strong>end</strong> A;
</pre></blockquote>
</html>"));
end PartialTwoFramesResolve;
