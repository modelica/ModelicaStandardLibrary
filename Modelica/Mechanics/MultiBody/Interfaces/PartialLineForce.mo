within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialLineForce "Base model for massless line force elements"
  extends LineForceBase;

  SI.Position r_rel_a[3]
    "Position vector from origin of frame_a to origin of frame_b, resolved in frame_a";
  Real e_a[3](each final unit="1")
    "Unit vector on the line connecting the origin of frame_a with the origin of frame_b resolved in frame_a (directed from frame_a to frame_b)";
  SI.Force f
    "Line force acting on frame_a and on frame_b (positive, if acting on frame_b and directed from frame_a to frame_b)";
equation
  // Determine relative position vector between the two frames
  r_rel_a = Frames.resolve2(frame_a.R, r_rel_0);
  e_a = r_rel_a/s;

  // Determine forces and torques at frame_a and frame_b
  frame_a.f = -e_a*f;
  frame_b.f = -Frames.resolve2(Frames.relativeRotation(frame_a.R, frame_b.R), frame_a.f);

  annotation (Documentation(info="<html>
<p>
All massless <strong>line force</strong> elements should be based on this base model.
This model defines frame_a and frame_b, computes the (guarded) relative
distance <strong>s</strong> and provides the force and torque
balance of the cut-forces and cut-torques at frame_a and
frame_b, respectively. In sub-models, only the line force <strong>f</strong>,
acting at frame_b on the line from frame_a to frame_b, as a function
of the relative distance <strong>s</strong> and its derivative <strong>der</strong>(<strong>s</strong>)
has to be defined. Example:
</p>
<blockquote><pre>
<strong>model</strong> Spring
   <strong>parameter</strong> Real c \"spring constant\",
   <strong>parameter</strong> Real s_unstretched \"unstretched spring length\";
   <strong>extends</strong> Modelica.Mechanics.MultiBody.Interfaces.PartialLineForce;
<strong>equation</strong>
   f = c*(s-s_unstretched);
<strong>end</strong> Spring;
</pre></blockquote>
</html>"),
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Ellipse(visible=fixedRotationAtFrame_a, extent={{-70,30},{-130,-30}}, lineColor={255,0,0}),
        Text(visible=fixedRotationAtFrame_a,
          extent={{-62,50},{-140,30}},
          textColor={255,0,0},
          textString="R=0"),
        Ellipse(visible=fixedRotationAtFrame_b, extent={{70,30},{130,-30}}, lineColor={255,0,0}),
        Text(visible=fixedRotationAtFrame_b,
          extent={{62,50},{140,30}},
          textColor={255,0,0},
          textString="R=0")}));
end PartialLineForce;
