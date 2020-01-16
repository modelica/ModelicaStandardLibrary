within Modelica.Mechanics.Translational.UsersGuide;
class SupportForces "Support Forces"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html>

<p>The following figure shows examples of components equipped with
a support flange (framed flange in the lower center), which can be used
to fix components on the ground or on other moving elements or to combine
them with force elements. Via Boolean parameter <strong>useSupport</strong>, the
support flange is enabled or disabled. If it is enabled, it must be connected.
If it is disabled, it needs not be connected.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/bearing.png\" alt=\"bearing\">
</div>

<p>
Depending on the setting of <strong>useSupport</strong>, the icon of the corresponding
component is changing, to either show the support flange or a ground mounting.
For example, the two implementations in the following figure give
identical results.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/bearing2.png\" alt=\"bearing2\">
</div>
</html>"));

end SupportForces;
