within Modelica.Magnetic.FluxTubes.Examples;
package MovingCoilActuator "Two translatory electrodynamic actuator models of different modelling depth and their comparison"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
<p>
Moving coil actuators are often called electrodynamic actuators and a proportional behaviour between force and current is expressed by a converter constant (see <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a>). However, in a simple moving coil actuator as presented in this example there is an additional non-linear force component that is due to the increase of the inductance when the armature coil moves into the ferromagnetic stator. A simple <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> can be used to describe this non-linear force component.
</p>
</html>"));
end MovingCoilActuator;
