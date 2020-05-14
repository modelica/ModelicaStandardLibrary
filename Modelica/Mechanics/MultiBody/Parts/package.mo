within Modelica.Mechanics.MultiBody;
package Parts "Rigid components such as bodies with mass and inertia and massless rods"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
Package <strong>Parts</strong> contains <strong>rigid components</strong> of a
multi-body system. These components may be used to build up
more complicated structures. For example, a part may be built up of
a \"Body\" and of several \"FixedTranslation\" components.
</p>
<h4>Content</h4>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>Model</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Fixed\">Fixed</a></td>
      <td>Frame fixed in world frame at a given position.
          It is visualized with a shape, see <strong>shapeType</strong> below
         (the frames on the two
          sides do not belong to the component):<br>&nbsp;<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/Fixed.png\" alt=\"model Parts.Fixed\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.FixedTranslation\">FixedTranslation</a></td>
      <td>Fixed translation of frame_b with respect to frame_a.
          It is visualized with a shape, see <strong>shapeType</strong> below
          (the frames on the two sides do not belong to the component):<br>&nbsp;<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/FixedTranslation.png\" alt=\"model Parts.FixedTranslation\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.FixedRotation\">FixedRotation</a></td>
      <td>Fixed translation and fixed rotation of frame_b with respect to frame_a
          It is visualized with a shape, see <strong>shapeType</strong>  below
          (the frames on the two sides do not belong to the component):<br>&nbsp;<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/FixedRotation.png\" alt=\"model Parts.FixedRotation\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Body</a></td>
      <td>Rigid body with mass, inertia tensor and one frame connector.
          It is visualized with a cylinder and a sphere at the
          center of mass:<br>&nbsp;<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/Body.png\" alt=\"model Parts.Body\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.BodyShape\">BodyShape</a></td>
      <td>Rigid body with mass, inertia tensor, different shapes
          (see <strong>shapeType</strong> below)
          for animation, and two frame connectors:<br>&nbsp;<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/BodyShape.png\" alt=\"model Parts.BodyShape\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Fixed\">Fixed BodyBox</a></td>
      <td>Rigid body with box shape (mass and animation properties are computed
          from box data and from density):<br>&nbsp;<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/BodyBox.png\" alt=\"model Parts.BodyBox\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.BodyCylinder\">BodyCylinder</a></td>
      <td>Rigid body with cylinder shape (mass and animation properties
          are computed from cylinder data and from density):<br>&nbsp;<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/BodyCylinder.png\" alt=\"model Parts.BodyCylinder\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.PointMass\">PointMass</a></td>
      <td>Rigid body where inertia tensor and rotation is neglected:<br>&nbsp;<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/PointMass.png\" alt=\"model Parts.PointMass\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Mounting1D\">Mounting1D</a></td>
      <td> Propagate 1-dim. support torque to 3-dim. system
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Rotor1D\">Rotor1D</a></td>
      <td>1D inertia attachable on 3-dim. bodies (without neglecting dynamic effects)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/Rotor1D.png\" alt=\"model Parts.Rotor1D\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.BevelGear1D\">BevelGear1D</a></td>
      <td>1D gearbox with arbitrary shaft directions (3D bearing frame)
      </td>
  </tr>
</table>
<p>
Components <strong>Fixed</strong>, <strong>FixedTranslation</strong>, <strong>FixedRotation</strong>
and <strong>BodyShape</strong> are visualized according to parameter
<strong>shapeType</strong>, that may have the following values (e.g., shapeType = \"box\"):<br>&nbsp;<br>
</p>
<div><img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/FixedShape.png\" alt=\"model Visualizers.FixedShape\"></div>
<p>
All the details of the visualization shape parameters are
given in
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedShape\">Visualizers.FixedShape</a>
</p>
<p>
Colors in all animation parts are defined via parameter <strong>color</strong>.
This is an Integer vector with 3 elements, {r, g, b}, and specifies the
color of the shape. {r, g, b} are the \"red\", \"green\" and \"blue\" color parts,
given in the ranges 0&nbsp;&hellip;&nbsp;255, respectively. The predefined type
<strong>MultiBody.Types.Color</strong> contains a menu
definition of the colors used in the MultiBody library
(this will be replaced by a color editor).
</p>
</html>"), Icon(graphics={Rectangle(
          extent={{-80,28},{2,-16}},
          lineColor={95,95,95},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,215,215},
          radius=10), Ellipse(
          extent={{-8,52},{86,-42}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Sphere,
          fillColor={215,215,215})}));
end Parts;
