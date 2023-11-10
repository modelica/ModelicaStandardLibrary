within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialFrameResolveConditional
  "Base model for components providing conditional connector frame_resolve"

protected
  parameter Boolean enableFrameResolve = false "= true, if frame_resolve shall be enabled"
    annotation(Evaluate=true, HideResult=true);

public
  Interfaces.Frame_resolve frame_resolve if enableFrameResolve
    "Coordinate system in which input/output vector is optionally resolved"
    annotation (Placement(transformation(extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={0,-100})));

  annotation (
    Documentation(info="<html>
<p>
This partial model provides one conditional connector <code>frame_resolve</code>
for resolving input/output vectors in this frame.
The connector is activated by a&nbsp;protected parameter <code>enableFrameResolve</code>.
This parameter can be set directly in the extending class.
In a&nbsp;more typical case &ndash; such as for sensors or forces, this partial class
can be utilized to define in which frame a&nbsp;particular vector is resolved.
In such a&nbsp;case, a&nbsp;definition similar to the following can be
utilized.
</p>

<blockquote><pre>
<strong>model</strong> A
  <strong>import</strong> Modelica.Mechanics.MultiBody.Types.ResolveInFrameB;
  ...
  <strong>extends</strong> Interfaces.PartialFrameResolveConditional(
    final enableFrameResolve = resolveInFrame==ResolveInFrameB.frame_resolve);
  <strong>parameter</strong> ResolveInFrameB resolveInFrame = ResolveInFrameB.world
    \"Frame in which input u is resolved\";
  Modelica.Blocks.Interfaces.RealInput u[3]
    \"x-, y-, z-coordinates of force resolved in frame defined by resolveInFrame\"
  ...
<strong>end</strong> A;
</pre></blockquote>

<p>
Note, the <code>ResolveInFrameB</code> type is not part of this class since there
exist more similar types which can be used instead &ndash; depending on a&nbsp;use
case.
</p>
</html>"));
end PartialFrameResolveConditional;
