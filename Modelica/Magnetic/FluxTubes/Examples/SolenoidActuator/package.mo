within Modelica.Magnetic.FluxTubes.Examples;
package SolenoidActuator "Two models of a reluctance actuator of different modelling depth and their comparison and usage"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
<p>
In electromagnetic or reluctance actuators, a thrust or reluctance force is generated due to a non-zero gradient of the relative magnetic permeability mu_r at surfaces between regions of different permeability (non-saturated ferromagnetic material: mu_r>>1, adjacent air: mu_r=1). In lumped magnetic network models, this force can be calculated as shortly outlined in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.ReluctanceForceCalculation\">Reluctance Forces</a> of the User's Guide.
</p>

<p>
As an example of a reluctance actuator, a simple axis-symmetric lifting magnet with planar end planes of armature and pole is shown. Often, a <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid\">SimpleSolenoid</a> model is sufficient for initial rough design of such an actuator's magnetic subsystem. Higher accuracy can be gained from an <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.AdvancedSolenoid\">AdvancedSolenoid</a> model where the coil-imposed magnetomotive force is split and the leakage flux between armature and yoke is accounted for more precisely.
</p>

<p>
The differences between these two models in static behaviour can be analysed and compared to results obtained with a more accurate finite element analysis (FEA) in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.ComparisonQuasiStatic\">ComparisonQuasiStatic</a>. The resulting differences in dynamic behaviour can be analysed and compared to FEA results with simulation of a pull-in stroke in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.ComparisonPullInStroke\">ComparisonPullInStroke</a>.
</p>
</html>"));
end SolenoidActuator;
