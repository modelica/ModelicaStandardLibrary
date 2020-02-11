within Modelica.Mechanics.MultiBody.Joints.Internal;
model InitPosition
 "Internal model to initialize r_rel_a for Joints.FreeMotionScalarInit"
  extends Modelica.Blocks.Icons.Block;

  import Modelica.Mechanics.MultiBody.Frames;

  input SI.Position r_a_0[3] annotation(Dialog);
  input SI.Position r_b_0[3] annotation(Dialog);
  input Frames.Orientation R_a annotation(Dialog);

  Modelica.Blocks.Interfaces.RealOutput r_rel_a[3](each final quantity="Length", each final unit="m") annotation (Placement(transformation(extent={{100,-10},
            {120,10}})));

equation
  r_b_0 = r_a_0 + Frames.resolve1(R_a, {r_rel_a[1], r_rel_a[2], r_rel_a[3]});

  annotation (Icon(coordinateSystem(
         preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
       graphics={Text(
         extent={{-88,16},{82,-12}},
         textString="r_rel_a")}), Documentation(info="<html>
<p>
Compute relative position vector r_rel_a from a position vector r_a_0 to
a position vector r_b_0, resolved in frame given by an
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a> R_a.
</p>
</html>"));
end InitPosition;
