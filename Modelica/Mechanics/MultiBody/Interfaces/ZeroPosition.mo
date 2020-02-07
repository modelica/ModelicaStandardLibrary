within Modelica.Mechanics.MultiBody.Interfaces;
model ZeroPosition
  "Set absolute position vector of frame_resolve to a zero vector and the orientation object to a null rotation"
   extends Modelica.Blocks.Icons.Block;
  Interfaces.Frame_resolve frame_resolve annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
equation
  Connections.root(frame_resolve.R);
  frame_resolve.R = Modelica.Mechanics.MultiBody.Frames.nullRotation();
  frame_resolve.r_0 = zeros(3);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-74,24},{80,-20}},
          textString="r = 0")}), Documentation(info="<html>
<p>
Element consisting of a frame (frame_resolve) that is fixed in the world
frame and has it's position and orientation identical with the world, i.e.
the position vector from origin of world frame to frame_resolve is zero vector
and the relative orientation between those two frames is identity matrix.
</p>
<p>
This component provides no visualization.
</p>
</html>"));
end ZeroPosition;
