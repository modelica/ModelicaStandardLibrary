within Modelica.Magnetic;
package FluxTubes "Library for modelling of electromagnetic devices with lumped magnetic networks"

  import Modelica.Constants.pi;
  import Modelica.Constants.mu_0;

  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
This library contains components for modelling of electromagnetic devices with lumped magnetic networks. Those models are suited for both rough design of the magnetic subsystem of a device as well as for efficient dynamic simulation at system level together with neighbouring subsystems. At present, components and examples for modelling of <em>translatory</em> electromagnetic and electrodynamic actuators are provided. If needed, these components can be adapted to network modelling of <em>rotational</em> electrical machines.
</p>
<p>
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide\">User's Guide</a> gives a short introduction to the underlying concept of <strong>magnetic flux tubes</strong>, summarizes the calculation of magnetic <strong>reluctance forces</strong> from lumped magnetic network models and lists <strong>reference literature</strong>.
</p>
<p>
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples\">Examples</a> illustrates the usage of magnetic network models with simple models from different fields of application.
</p>

<p>
Copyright &copy; 2005-2024, Modelica Association and contributors
</p>
</html>", revisions="<html>
<p>
See <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.ReleaseNotes\">release notes</a>
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
    Polygon(
      origin={-3.75,0.0},
      fillColor={160,160,164},
      fillPattern=FillPattern.Solid,
      points={{33.75,50.0},{-46.25,50.0},{-46.25,-50.0},{33.75,-50.0},{33.75,-30.0},{-21.25,-30.0},{-21.25,30.0},{33.75,30.0}}),
    Ellipse(
      origin={10.4708,41.6771},
      extent={{-86.0,-24.0},{-78.0,-16.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.0,-20.0},{-78.0,-20.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.1812,-31.6229},{-32.0,-40.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.0,-20.0},{-32.0,-28.0}}),
    Ellipse(
      origin={10.4708,41.6771},
      extent={{-86.0,-60.0},{-78.0,-52.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.0,-56.0},{-78.0,-56.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.0,-44.0},{-32.0,-52.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.0,-56.0},{-32.0,-64.0}}),
    Rectangle(
      origin={62.5,0.0},
      fillColor={160,160,164},
      fillPattern=FillPattern.Solid,
      extent={{-12.5,-50.0},{12.5,50.0}})}));
end FluxTubes;
