within Modelica.Magnetic.QuasiStatic.FluxTubes.UsersGuide;
class FluxTubeConcept "Flux tube concept"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Overview of the concept of quasi-static magnetic flux tubes</h4>
<p>
Following below, the concept of magnetic flux tubes is outlined in short. For a detailed description of flux tube elements, please have a look at the listed literature. Magnetic flux tubes enable the modeling of magnetic fields with lumped equivalent circuit networks.</p>

<p>Since quasi-static conditions are assumed, each field quantity can be represented by a complex phasor -- which is indicated by underlining the respective variable:
</p>

<ul>
<li>Normal component of magnetic flux density,
    <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/B_n.png\"> </li>
<li>Normal component of magnetic field strength,
    <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/H_n.png\"> </li>
<li>Magnetic flux,
    <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/Phi.png\"> </li>
<li>Magnetic potential difference,
    <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/V_m.png\"> </li>
</ul>

<p>The figure below and the following equations illustrate the relationships between</p>

<ul>
<li>the normal component of flux density and magnetic flux, and</li>
<li>the normal component of field strength and magnetic potential difference.</li>
</ul>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/magnetic_flux_tube_schematic_qs.png\" alt=\"Magnetic flux tube\">
</div>

<p>A <strong>flux tube</strong> confines the magnetic flux. Flied lines, and flux tubes, respectively are always closed. So there is no flux entering or leaving a flux tube. The total flux of a configuration can be represented by parallel flux tubes, representing different flux paths. This is considered by connecting the elements of a lumped circuit model, such that the sum of all fluxes of a connection is equivalent to zero.</p>

<p>
For a section of a flux tube with length
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/l.png\">
the magnetic potential difference is determined by the length integral over the magnetic field strength:</p>

<dl>
<dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/V_m-H_n.png\">
</dd>
</dl>

<p>
The magnetic flux entering, and leaving a flux tube, respectively, is determined by the surface integral of the normal component
of the magnetic field strength:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/Phi-B_n.png\">
</dd></dl>
<p>The magnetic potential difference and the magnetic flux have the same angle, so the reluctance a real (non complex) quantity:</p>

<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m-V_m-Phi.png\">
</dd></dl>

<p>
For a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape.GenericFluxTube\">generic flux tube</a> reluctance with constant
area of cross section,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/A.png\">,
and length,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/l.png\">,
the magnetic reluctance is:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m_cuboid.png\">
</dd></dl>

<h4>Assumptions</h4>

<ul>
<li><strong>Force</strong> interaction is not considered</li>
<li>Reluctance models are <strong>linear</strong>; so non-linearities can only be taken into account by adapting the constant relative permeability;
see example
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Examples.NonLinearInductor\">NonLinearInductor</a></li>
</ul>

<h4>Notes</h4>

<p>The parameter and variable names are chosen as close as possible to the transient
<a href=\"modelica://Modelica.Magnetic.FluxTubes\">FluxTubes</a> library, to avoid additional effort when converting transient into quasi-static flux tubes models.</p>

<h4>Reference Note</h4>

<p>A similar approach on quasi-static flux tube models is published in
[<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.UsersGuide.Literature\">Raabe2012</a>].</p>
</html>"));
end FluxTubeConcept;
