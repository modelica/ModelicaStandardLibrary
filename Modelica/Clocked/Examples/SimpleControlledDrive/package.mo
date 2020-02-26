within Modelica.Clocked.Examples;
package SimpleControlledDrive "Examples based on a simple controlled drive with different ways to define the sampling"
extends Modelica.Icons.ExamplesPackage;

annotation (Documentation(info="<html>
<p>
This package shows the same example in different variants.
</p>

<p>
Model <a href=\"modelica://Modelica.Clocked.Examples.SimpleControlledDrive.Continuous\">SimpleControlledDrive.Continuous</a>
is the <strong>continuous-time</strong> model from which the sampled-data versions are derived.
The model consists of a reference controller (\"ramp\"), a feedback controller
(\"feedback\" and \"PI\") and a plant (\"torque\", \"load\" and \"speed\").
The task of the controller is to control the speed of the load inertia
using a simple PI controller.
</p>

<p>
The other example models under this package show different variants how
the continuous-time model from above can be transformed to a periodic sampled-data
system with one sample period.
</p>
</html>"));
end SimpleControlledDrive;
