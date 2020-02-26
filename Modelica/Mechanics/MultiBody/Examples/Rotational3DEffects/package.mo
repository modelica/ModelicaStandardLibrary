within Modelica.Mechanics.MultiBody.Examples;
package Rotational3DEffects "Demonstrates the usage of 1-dim. rotational elements with all 3-dim. effects included"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
<p>
This package demonstrates the usage of elements of the Mechanics.Rotational library
by taking into account all 3-dim. effects. The reason for this type of modeling is
to speedup the simulation drastically. This is possible if moving bodies have
rotational symmetry. A typical application area are drive trains, driving joints of
a multi-body system.
</p>
</html>"));
end Rotational3DEffects;
