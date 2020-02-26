within Modelica.Clocked.Examples;
package CascadeControlledDrive "Examples based on a simple drive with cascade controller and different ways to define the sampling and super-sampling"
  extends Modelica.Icons.ExamplesPackage;

annotation (Documentation(info="<html>
<p>
This package shows the same example in different variants.
</p>

<p>
Model <a href=\"modelica://Modelica.Clocked.Examples.CascadeControlledDrive.Continuous\">CascadeControlledDrive.Continuous</a>
is the <strong>continuous-time</strong> model from which the sampled-data versions are derived.
The \"CascadeControlledDrive\" example adds another position control cascade to the
<a href=\"modelica://Modelica.Clocked.Examples.SimpleControlledDrive\">SimpleControlledDrive</a>
example. This model demonstrates a control system with two cascaded control loops.
The goal is to control the angle of the load inertia.
</p>

<p>
The other example models under this package show different variants how
the continuous-time model from above can be transformed to a periodic sampled-data
system with two sample periods, where the two discrete-time controllers are
precisely time-synchronized to each other.
</p>
</html>"));
end CascadeControlledDrive;
