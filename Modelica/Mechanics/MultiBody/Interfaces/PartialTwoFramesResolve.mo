within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialTwoFramesResolve
  "Base model for components providing two frame connectors, frame_resolve connector and outer world"
  extends PartialTwoFrames;

protected
  parameter Boolean enableFrameResolve = false "= true, if frame_resolve shall be enabled"
    annotation(Evaluate=true, HideResult=true);

public
  Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if enableFrameResolve
    "Coordinate system in which input/output vector is optionally resolved"
    annotation (Placement(transformation(extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={0,-100})));

  annotation (
    Documentation(info="<html>
<p>
This partial model provides two frame connectors, a&nbsp;frame connector for
resolving vectors in this frame and access to the world object.
It is reasonable to inherit from this partial model if the two frame connectors
are needed.
</p>

<p>
The conditional <code>frame_resolve</code> connector is activated by a&nbsp;protected
parameter <code>enableFrameResolve</code>. This parameter can be set directly
in the extending class. In a&nbsp;more typical case &ndash; such as for sensors or
forces, it can be utilized to define in which frame a&nbsp;particular vector is
resolved. In such a&nbsp;case, a&nbsp;definition similar to the following can be
utilized.
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>resolveInFrame =<br>Types.ResolveInFrameA.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve</td></tr>
</table>
</html>"));
end PartialTwoFramesResolve;
