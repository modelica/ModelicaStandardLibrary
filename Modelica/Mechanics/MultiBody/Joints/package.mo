within Modelica.Mechanics.MultiBody;
package Joints "Components that constrain the motion between two frames"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
This package contains <strong>joint components</strong>,
that is, idealized, massless elements that constrain
the motion between frames. In subpackage <strong>Assemblies</strong>
aggregation joint components are provided to handle
kinematic loops analytically (this means that non-linear systems
of equations occurring in these joint aggregations are analytically
solved, i.e., robustly and efficiently).
</p>
<h4>Content</h4>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>Model</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Prismatic\">Prismatic</a></td>
      <td>Prismatic joint and actuated prismatic joint
          (1 translational degree-of-freedom, 2 potential states)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Prismatic.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Revolute\">Revolute</a>
 </td>
      <td>Revolute and actuated revolute joint
          (1 rotational degree-of-freedom, 2 potential states)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Revolute.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Cylindrical\">Cylindrical</a></td>
      <td>Cylindrical joint (2 degrees-of-freedom, 4 potential states)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Cylindrical.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Universal\">Universal</a></td>
      <td>Universal joint (2 degrees-of-freedom, 4 potential states)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Universal.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Planar\">Planar</a></td>
      <td>Planar joint (3 degrees-of-freedom, 6 potential states)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Planar.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Spherical\">Spherical</a></td>
      <td>Spherical joint (3 constraints and no potential states, or 3 degrees-of-freedom and 3 states)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Spherical.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.FreeMotion\">FreeMotion</a></td>
      <td>Free motion joint (6 degrees-of-freedom, 12 potential states)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/FreeMotion.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.SphericalSpherical\">SphericalSpherical</a></td>
      <td>Spherical - spherical joint aggregation (1 constraint,
          no potential states) with an optional point mass in the middle<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/SphericalSpherical.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.UniversalSpherical\">UniversalSpherical</a></td>
      <td>Universal - spherical joint aggregation (1 constraint, no potential states)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/UniversalSpherical.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.GearConstraint\">GearConstraint</a></td>
      <td>Ideal 3-dim. gearbox (arbitrary shaft directions)
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies\">MultiBody.Joints.Assemblies</a></td>
      <td><strong>Package</strong> of joint aggregations for analytic loop handling.
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Constraints\">MultiBody.Joints.Constraints</a></td>
      <td><strong>Package</strong> of components that define joints by constraints
      </td>
  </tr>
</table>
</html>"),
    Icon(
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(
          origin={30,-22},
          lineColor={64,64,64},
          fillColor={235,235,235},
          fillPattern=FillPattern.VerticalCylinder,
          extent={{-20,0},{20,100}},
          rotation=110),
        Rectangle(
          origin={30,-22},
          lineColor={64,64,64},
          fillColor={215,215,215},
          fillPattern=FillPattern.VerticalCylinder,
          extent={{-20,0},{20,100}}),
        Rectangle(
          origin={30,-22},
          lineColor={64,64,64},
          extent={{-20,0},{20,100}}),
        Rectangle(
          origin={30,-22},
          lineColor={64,64,64},
          extent={{-20,0},{20,100}},
          rotation=110),
        Ellipse(
          origin={30,-22},
          rotation=-45,
          lineColor={64,64,64},
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-34,-34},{34,34}}),
        Ellipse(
          origin={30,-22},
          lineColor={64,64,64},
          fillColor={64,64,64},
          fillPattern=FillPattern.Solid,
          extent={{-14,14},{14,-14}}),
        Ellipse(
          extent={{-34,34},{34,-34}},
          lineColor={64,64,64},
          origin={30,-22})}));
end Joints;
