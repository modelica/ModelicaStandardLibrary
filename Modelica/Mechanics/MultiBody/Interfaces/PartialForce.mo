within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialForce
  "Base model for force elements (provide frame_b.f and frame_b.t in subclasses)"
  extends PartialTwoFrames;
  SI.Position r_rel_b[3]
    "Position vector from origin of frame_a to origin of frame_b, resolved in frame_b";
equation
  // Determine relative position vector between frame_a and frame_b
  r_rel_b = Frames.resolve2(frame_b.R, frame_b.r_0 - frame_a.r_0);

  // Force and torque balance between frame_a and frame_b
  zeros(3) = frame_a.f + Frames.resolveRelative(frame_b.f, frame_b.R, frame_a.R);
  zeros(3) = frame_a.t + Frames.resolveRelative(frame_b.t + cross(r_rel_b, frame_b.f), frame_b.R, frame_a.R);
  annotation (Documentation(info="<html>
<p>
All <strong>3-dimensional force</strong> and <strong>torque elements</strong>
should be based on this superclass.
This model defines frame_a and frame_b, computes the relative
translation and rotation between the two frames and calculates
the cut-force and cut-torque at frame_a by a force and torque
balance from the cut-force and cut-torque at frame_b.
As a result, in a subclass, only the relationship between
the cut-force and cut-torque at frame_b has to be defined as
a function of the following relative quantities:
</p>
<blockquote><pre>
r_rel_b[3]: Position vector from origin of frame_a to origin
            of frame_b, resolved in frame_b
R_rel     : Relative orientation object to rotate from frame_a to frame_b
</pre></blockquote>
<p>
Assume that force f = {100,0,0} should be applied on the body
to which this force element is attached at frame_b, then
the definition should be:
</p>
<blockquote><pre>
<strong>model</strong> Constant_x_Force
   extends Modelica.Mechanics.MultiBody.Interfaces.PartialForce;
<strong>equation</strong>
   frame_b.f = {-100, 0, 0};
   frame_b.t = zeros(3);
<strong>end</strong> Constant_x_Force;
</pre></blockquote>
<p>
Note, that frame_b.f and frame_b.t are flow variables and therefore
the negative value of frame_b.f and frame_b.t is acting at the part
to which this force element is connected.
</p>
</html>"));
end PartialForce;
