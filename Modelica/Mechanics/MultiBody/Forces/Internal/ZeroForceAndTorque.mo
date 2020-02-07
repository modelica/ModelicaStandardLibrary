within Modelica.Mechanics.MultiBody.Forces.Internal;
model ZeroForceAndTorque "Set force and torque to zero"
   extends Modelica.Blocks.Icons.Block;
  Interfaces.Frame_a frame_a
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
equation
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-74,24},{80,-20}},
          textString="f = t = 0")}), Documentation(info="<html>
<p>Set force and torque vectors on frame connector frame_a to zero.</p>
<!--a placeholder to fulfill minimum documentation length-->
</html>"));
end ZeroForceAndTorque;
