within Modelica.Mechanics.MultiBody.Types;
type ResolveInFrameAB = enumeration(
    world "Resolve in world frame",
    frame_a "Resolve in frame_a",
    frame_b "Resolve in frame_b",
    frame_resolve
      "Resolve in frame_resolve (frame_resolve must be connected)")
  "Enumeration to define the frame in which a relative vector is resolved (world, frame_a, frame_b, frame_resolve)"
                                             annotation (Documentation(info="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameAB.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>world</td>
    <td>Resolve vector in world frame</td></tr>

<tr><td>frame_a</td>
    <td>Resolve vector in frame_a</td></tr>

<tr><td>frame_b</td>
    <td>Resolve vector in frame_b</td></tr>

<tr><td>frame_resolve</td>
    <td>Resolve vector in frame_resolve (frame_resolve must be connected)</td></tr>
</table>
</html>"));
