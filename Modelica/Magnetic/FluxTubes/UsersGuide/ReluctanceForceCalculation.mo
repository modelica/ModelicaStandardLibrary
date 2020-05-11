within Modelica.Magnetic.FluxTubes.UsersGuide;
class ReluctanceForceCalculation "Reluctance forces"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Calculation of reluctance forces from lumped magnetic network models</h4>

<p>
Generally, the thrust <em>F</em> developed by a translatory electro-magneto-mechanical actuator (similar for the rotational case with torque and angular position) is equal to the change of magnetic co-energy <em>W<sub>m</sub><sup>*</sup></em> with armature position <em>x</em> according to
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/ReluctanceForceCalculation/eq_CoEnergy_general.png\" alt=\"Equation for force calculation from change of magnetic co-energy with armature position\">
</div>

<p>
(<em>&Psi;</em> flux linkage, <em>i</em> actuator current). In lumped magnetic network models, the above equation simplifies to
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/ReluctanceForceCalculation/eq_forceFromPermeance_network.png\" alt=\"Equation for force calculation in lumped magnetic network models\">
</div>

<p>
where <em>n<sub>linear</sub></em> is the number of flux tube elements with constant relative permeability that change its permeance <em>G<sub>m i</sub></em> with armature position (index <em>i</em>), <em>V<sub>m i</sub></em> the magnetic voltage across each respective flux tube and <em>dG<sub>m i</sub>/dx</em> the derivative of the respective permeances with respect to armature position. Transition from the general formula based on magnetic co-energy to the latter one is outlined in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[KEQ+12]</a> for the reciprocal of the permeance, i.e., for the magnetic reluctance <em>R<sub>m</sub></em>. Note that
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/ReluctanceForceCalculation/eq_transition_forceReluctancePermeance.png\" alt=\"Transition from force calculation based on reluctance to calculation based on permeance\">
</div>

<p>with <em>&Phi;<sub>i</sub></em> being the magnetic flux through each respective flux tube element.</p>

<p>
Flux tube elements with <em>non-linear</em> material characteristics <em>&mu;<sub>r</sub></em>(<em>B</em>) in magnetic network models do not restrict the usability of the above equation. However, it is required that these nonlinear flux tube elements do not change its shape with armature motion (e.g., portion of a solenoid plunger where the magnetic flux passes through in axial direction). This limitation is not a strong one, since the permeance of nonlinear, but highly permeable ferromagnetic flux tube elements and its change with armature position compared to that of air gap flux tubes can be neglected in most cases. Because of this constraint, the dimensions of possibly nonlinear flux tube elements in sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">Shapes.FixedShape</a> are fixed, whereas the dimension in direction of motion of the linear flux tube elements in sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Shapes.Force</a> can vary during simulation. For the flux tubes defined in this package with their rather simple shapes, the derivative <em>dG<sub>m</sub>/dx</em> is given analytically. For more complex shapes and variations of dimensions with armature motion, it must be provided analytically during model development, preferably by extending the partial model <a href=\"modelica://Modelica.Magnetic.FluxTubes.BaseClasses.Force\">BaseClasses.Force</a>.
</p>

<p>
The sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a> contains flux tube shapes typical for leakage flux around prismatic or cylindrical poles. Since the permeance of these flux tubes does not change with armature position, they do not contribute to a reluctance actuator's thrust.
</p>

</html>"));
end ReluctanceForceCalculation;
