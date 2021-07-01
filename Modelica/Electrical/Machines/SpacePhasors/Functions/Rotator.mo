within Modelica.Electrical.Machines.SpacePhasors.Functions;
function Rotator "Rotates space phasor"
  extends Modelica.Icons.Function;
  input Real x[2] "Input space phasor";
  input SI.Angle angle "Input angle of rotation";
  output Real y[2] "Output space phasor";
protected
  Real RotationMatrix[2, 2]={{+cos(-angle),-sin(-angle)},{+sin(-angle),+
      cos(-angle)}};
algorithm
  y := RotationMatrix*x;
  annotation (Inline=true, Documentation(info="<html>
Rotates a space phasor (voltage or current) input <code>u</code> by the <code>angle</code> in negative mathematical direction. This block represents the transformation of one space phasor <code>u</code> from one rotating reference (coordinate) frame into another where the space phasor is <code>y</code>. The output reference frame leads the input reference frame by angle <code>angle</code>.

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/Rotator.png\">
    </td>
  </tr>
  <caption><strong>Fig. 1:</strong> Original and rotated reference frame of a space phasor </caption>
</table>
</html>"));
end Rotator;
