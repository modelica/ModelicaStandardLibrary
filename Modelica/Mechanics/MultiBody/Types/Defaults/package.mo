within Modelica.Mechanics.MultiBody.Types;
package Defaults "Default settings of the MultiBody library via constants"
  extends Modelica.Icons.Package;

  // Color defaults
  constant Types.Color BodyColor={0,128,255} "Default color for body shapes that have mass (light blue)";
  constant Types.Color RodColor={155,155,155} "Default color for massless rod shapes (grey)";
  constant Types.Color JointColor={255,0,0} "Default color for elementary joints (red)";
  constant Types.Color ForceColor={0,128,0} "Default color for force arrow (dark green)";
  constant Types.Color TorqueColor={0,128,0} "Default color for torque arrow (dark green)";
  constant Types.Color SpringColor={0,0,255} "Default color for a spring (blue)";
  constant Types.Color SensorColor={255,255,0} "Default color for sensors (yellow)";
  constant Types.Color FrameColor={0,0,0} "Default color for frame axes and labels (black)";
  constant Types.Color ArrowColor={0,0,255} "Default color for arrows and double arrows (blue)";

  // Arrow and frame defaults
  constant Real FrameHeadLengthFraction=5.0
    "Frame arrow head length / arrow diameter";
  constant Real FrameHeadWidthFraction=3.0
    "Frame arrow head width / arrow diameter";
  constant Real FrameLabelHeightFraction=3.0
    "Height of frame label / arrow diameter";
  constant Real ArrowHeadLengthFraction=4.0
    "Arrow head length / arrow diameter";
  constant Real ArrowHeadWidthFraction=3.0
    "Arrow head width / arrow diameter";

  // Other defaults
  constant Real BodyCylinderDiameterFraction=3
    "Default for body cylinder diameter as a fraction of body sphere diameter";
  constant Real JointRodDiameterFraction=2
    "Default for rod diameter as a fraction of joint sphere diameter attached to rod";

  /*
  constant Real N_to_m(unit="N/m") = 1000
    "Default force arrow scaling (length = force/N_to_m_default)";
  constant Real Nm_to_m(unit="N.m/m") = 1000
    "Default torque arrow scaling (length = torque/Nm_to_m_default)";
*/
  annotation (Documentation(info="<html>
<p>
This package contains constants used as default setting
in the MultiBody library.
</p>
</html>"));
end Defaults;
