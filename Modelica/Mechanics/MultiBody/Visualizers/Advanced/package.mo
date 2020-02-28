within Modelica.Mechanics.MultiBody.Visualizers;
package Advanced "Visualizers that require basic knowledge about Modelica in order to use them"

  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
Package <strong>Visualizers.Advanced</strong> contains components to visualize
3-dimensional shapes with dynamical sizes. None of the components
has a frame connector. The position and orientation is set via
modifiers. Basic knowledge of Modelica
is needed in order to utilize the components of this package.
These components have also to be used for models,
where the forces and torques in the frame connector are set via
equations (in this case, the models of the Visualizers package cannot be used,
since they all have frame connectors).
</p>
<h4>Content</h4>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow\">Arrow</a></td>
      <td>Visualizing an arrow where all parts of the arrow can vary dynamically:<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Arrow.png\" alt=\"model Visualizers.Advanced.Arrow\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.DoubleArrow\">DoubleArrow</a></td>
      <td>Visualizing a double arrow where all parts of the arrow can vary dynamically:<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Advanced/DoubleArrow.png\" alt=\"model Visualizers.Advanced.DoubleArrow\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Shape</a></td>
      <td>Visualizing an elementary object with variable size.
      The following shape types are supported:<br>&nbsp;<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/FixedShape.png\" alt=\"model Visualizers.Advanced.Shape\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\">Surface</a></td>
      <td>Visualizing a moveable parameterized surface:<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Advanced/Surface_small.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.PipeWithScalarField\">PipeWithScalarField</a></td>
      <td>Visualizing a pipe with a scalar field represented by a color coding:<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/PipeWithScalarFieldIcon.png\">
      </td>
  </tr>
</table>
</html>"));
end Advanced;
