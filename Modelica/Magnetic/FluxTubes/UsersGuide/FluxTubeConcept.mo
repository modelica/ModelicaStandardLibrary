within Modelica.Magnetic.FluxTubes.UsersGuide;
class FluxTubeConcept "Flux tube concept"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Overview of the Concept of Magnetic Flux Tubes</h4>
<p>
Following below, the concept of magnetic flux tubes is outlined in short. For a detailed description of flux tube elements, please have a look at the listed literature. Magnetic flux tubes enable for modeling of magnetic fields with lumped networks. The figure below and the following equations illustrate the transition from the original magnetic field quantities described by <em>Maxwell</em>'s equations to network elements with a flow variable and an across variable:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/magnetic_flux_tube_schematic.png\" alt=\"Magnetic flux tube\">
</div>

<p>
For a region with an approximately homogeneous distribution of the magnetic field strength <strong>H</strong> and the magnetic flux density <strong>B</strong> through cross sectional area <em>A</em> at each length coordinate <em>s</em>  (<em>A</em> perpendicular to the direction of the magnetic field lines), a magnetic reluctance <em>R<sub>m</sub></em> can be defined:</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_transition_reluctance_flowAcross_IntegralQuantities.png\" alt=\"Transition from field quantities to flow- and across variables\">
</div>

<p>
With the definition of the magnetic potential difference <em>V<sub>m</sub></em> as an across variable and the magnetic flux <em>&Phi;</em> as flow variable, a reluctance element <em>R<sub>m</sub></em> can be defined similar to resistive network elements in other physical domains. Using <em>Maxwell</em>'s constitutive equation
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_MaxwellConstitutive.png\" alt=\"Maxwell's constitutive equation\">
</div>

<p>the general formula for the calculation of a magnetic reluctance <em>R<sub>m</sub></em> from its geometric and material properties is:</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_reluctance_general.png\" alt=\"General formula for calculation of a magnetic reluctance\">
</div>

<p>
For a prismatic or cylindrical volume of length <em>l</em> and cross sectional area <em>A</em> with the magnetic flux entering and leaving the region through its end planes, the above equation simplifies to:</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_reluctance_prismatic.png\" alt=\"Magnetic reluctance of a prismatic or cylindrical volume\">
</div>

<p>
Similar equations can be derived for other geometries. In cases where a direct integration is not possible, the reluctance can be calculated on base of average length, average cross sectional area and volume <em>V</em> respectively:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_reluctanceFromAverageGeometry.png\" alt=\"Reluctance calculation from average geometric quantities\">
</div>

<p>
Network elements for sources of a magnetic potential difference or magnetomotive force, i.e., coils or permanent magnets can be formulated as well. The resulting magnetic network models of actuators reflect the main dimensions of these devices as well as the normally nonlinear characteristics of their magnetically active materials.
</p>

</html>"));
end FluxTubeConcept;
