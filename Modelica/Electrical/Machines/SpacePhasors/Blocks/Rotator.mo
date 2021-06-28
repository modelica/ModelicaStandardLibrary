within Modelica.Electrical.Machines.SpacePhasors.Blocks;
block Rotator "Rotates space phasor"
  extends Modelica.Blocks.Interfaces.MIMOs(final n=2);
protected
  Real RotationMatrix[2, 2]={{+cos(-angle),-sin(-angle)},{+sin(-angle),+
      cos(-angle)}};
  //Real InverseRotator[2,2] = {{+cos(+angle),-sin(+angle)},{+sin(+angle),+cos(+angle)}};
public
  Modelica.Blocks.Interfaces.RealInput angle(unit="rad") annotation (Placement(
        transformation(
        origin={0,-120},
        extent={{-20,-20},{20,20}},
        rotation=90)));
equation
  y = RotationMatrix*u;
  //u = InverseRotator*y;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Line(points={{0,0},{0,80},{-10,
          60},{10,60},{0,80}}, color={0,0,255}),Line(points={{0,0},{80,0},
          {60,10},{60,-10},{80,0}}, color={0,0,255}),
                                     Polygon(
                points={{50,0},{42,14},{54,16},{50,0}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),Text(
                extent={{-88,-72},{84,-92}},
                textString="angle"),
        Line(
          points={{0,50},{18,48},{32,40},{42,28},{48,16},{50,0}},
          color={0,0,255},
          smooth=Smooth.Bezier)}),     Documentation(info="<html>
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
