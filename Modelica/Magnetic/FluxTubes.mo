within Modelica.Magnetic;
package FluxTubes
  "Library for modelling of electromagnetic devices with lumped magnetic networks"

  import SI = Modelica.SIunits;
  import Modelica.Constants.pi;
  import mu_0 = Modelica.Constants.mue_0;

  extends Modelica.Icons.Package;

  package UsersGuide "User's Guide"
    extends Modelica.Icons.Information;

    class FluxTubeConcept "Flux tube concept"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<h4>Overview of the Concept of Magnetic Flux Tubes</h4>
<p>
Following below, the concept of magnetic flux tubes is outlined in short. For a detailed description of flux tube elements, please have a look at the listed literature. Magnetic flux tubes enable for modeling of magnetic fields with lumped networks. The figure below and the following equations illustrate the transition from the original magnetic field quantities described by <em>Maxwell</em>'s equations to network elements with a flow variable and an across variable:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/magnetic_flux_tube_schematic.png\" alt=\"Magnetic flux tube\">
</p>



<p>
For a region with an approximately homogeneous distribution of the magnetic field strength <strong>H</strong> and the magnetic flux density <strong>B</strong> through cross sectional area <em>A</em> at each length coordinate <em>s</em>  (<em>A</em> perpendicular to the direction of the magnetic field lines), a magnetic reluctance <em>R<sub>m</sub></em> can be defined:</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_transition_reluctance_flowAcross_IntegralQuantities.png\" alt=\"Transition from field quantities to flow- and across variables\">
</p>

<p>
With the definition of the magnetic potential difference <em>V<sub>m</sub></em> as an across variable and the magnetic flux <em>&Phi;</em> as flow variable, a reluctance element <em>R<sub>m</sub></em> can be defined similar to resistive network elements in other physical domains. Using <em>Maxwell</em>'s constitutive equation
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_MaxwellConstitutive.png\" alt=\"Maxwell's constitutive equation\">
</p>

<p>the general formula for the calculation of a magnetic reluctance <em>R<sub>m</sub></em> from its geometric and material properties is:</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_reluctance_general.png\" alt=\"General formula for calculation of a magnetic reluctance\">
</p>

<p>
For a prismatic or cylindrical volume of length <em>l</em> and cross sectional area <em>A</em> with the magnetic flux entering and leaving the region through its end planes, the above equation simplifies to:</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_reluctance_prismatic.png\" alt=\"Magnetic reluctance of a prismatic or cylindrical volume\">
</p>

<p>
Similar equations can be derived for other geometries. In cases where a direct integration is not possible, the reluctance can be calculated on base of average length, average cross sectional area and volume <em>V</em> respectively:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/FluxTubeConcept/eq_reluctanceFromAverageGeometry.png\" alt=\"Reluctance calculation from average geometric quantities\">
</p>

<p>
Network elements for sources of a magnetic potential difference or magnetomotive force, i.e., coils or permanent magnets can be formulated as well. The resulting magnetic network models of actuators reflect the main dimensions of these devices as well as the normally nonlinear characteristics of their magnetically active materials.
</p>

</html>"));
    end FluxTubeConcept;

    class ReluctanceForceCalculation "Reluctance forces"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<h4>Calculation of reluctance forces from lumped magnetic network models</h4>

<p>
Generally, the thrust <em>F</em> developed by a translatory electro-magneto-mechanical actuator (similar for the rotational case with torque and angular position) is equal to the change of magnetic co-energy <em>W<sub>m</sub><sup>*</sup></em> with armature position <em>x</em> according to
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/ReluctanceForceCalculation/eq_CoEnergy_general.png\" alt=\"Equation for force calculation from change of magnetic co-energy with armature position\">
</p>

<p>
(<em>&Psi;</em> flux linkage, <em>i</em> actuator current). In lumped magnetic network models, the above equation simplifies to
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/ReluctanceForceCalculation/eq_forceFromPermeance_network.png\" alt=\"Equation for force calculation in lumped magnetic network models\">
</p>

<p>
where <em>n<sub>linear</sub></em> is the number of flux tube elements with constant relative permeability that change its permeance <em>G<sub>m i</sub></em> with armature position (index <em>i</em>), <em>V<sub>m i</sub></em> the magnetic voltage across each respective flux tube and <em>dG<sub>m i</sub>/dx</em> the derivative of the respective permeances with respect to armature position. Transition from the general formula based on magnetic co-energy to the latter one is outlined in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[KEQ+12]</a> for the reciprocal of the permeance, i.e., for the magnetic reluctance <em>R<sub>m</sub></em>. Note that
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/ReluctanceForceCalculation/eq_transition_forceReluctancePermeance.png\" alt=\"Transition from force calculation based on reluctance to calculation based on permeance\">
</p>

<p>with <em>&Phi;<sub>i</sub></em> being the magnetic flux through each respective flux tube element.</p>

<p>
Flux tube elements with <em>non-linear</em> material characteristics <em>&mu;<sub>r</sub></em>(<em>B</em>) in magnetic network models do not restrict the usability of the above equation. However, it is required that these nonlinear flux tube elements do not change its shape with armature motion (e.g., portion of a solenoid plunger where the magnetic flux passes through in axial direction). This limitation is not a strong one, since the permeance of nonlinear, but highly permeable ferromagnetic flux tube elements and its change with armature position compared to that of air gap flux tubes can be neglected in most cases. Because of this constraint, the dimensions of possibly nonlinear flux tube elements in sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">Shapes.FixedShape</a> are fixed, whereas the dimension in direction of motion of the linear flux tube elements in sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Shapes.Force</a> can vary during simulation. For the flux tubes defined in this package with their rather simple shapes, the derivative <em>dG<sub>m</sub>/dx</em> is given analytically. For more complex shapes and variations of dimensions with armature motion, it must be provided analytically during model development, preferably by extending the partial model <a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.PartialForce\">Interfaces.PartialForce</a>.
</p>

<p>
The sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a> contains flux tube shapes typical for leakage flux around prismatic or cylindrical poles. Since the permeance of these flux tubes does not change with armature position, they do not contribute to a reluctance actuator's thrust.
</p>

</html>"));
    end ReluctanceForceCalculation;

    package Hysteresis "Hysteresis"
      extends Modelica.Icons.Information;
      package StaticHysteresis "Static Hysteresis"
        extends Modelica.Icons.Information;
        class Tellinen "Tellinen Hysteresis Model"
          extends Modelica.Icons.Information;

          annotation (Documentation(info="<html>
<h4>The Tellinen hysteresis model</h4>

<p>
The Tellinen hysteresis model is described in more detail in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Te98, ZB12]</a>. It is a simple model to describe the static magnetic hysteresis behavior of ferromagnetic materials. It only requires the Upper B<sub>U</sub>(H) and lower B<sub>L</sub>(H) branches of the limiting hysteresis loop for the adaption to a material specific hysteresis shape. Coming from negative magnetic saturation with increasing magnetic field strength H(t) the flux density B(T) travels along the B<sub>L</sub>(H). Coming from positive saturation with a decreasing H(t), B(t) travels along B<sub>U</sub>(H). The Tellinen model is defined by the following equation, which gives a calculation rule for time derivative of the magnetic flux density B(t) with respect to the current value of B(t), H(t) and its slope dH(t)/dt.
</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\"><tr>
<td><p><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Tellinen/Eqn_Tellinen01.png\"/></p></td>
</tr>
</table>

<p>
Therein, S<sub>U</sub>(H) and S<sub>L</sub>(H) are the derivatives of limiting branches of the hysteresis loop with respect to the magnetic field strength H, as illustrated in Fig 1.
</p>
<p>
<strong>Fig. 1:</strong> Upper B<sub>U</sub>(H) and lower B<sub>L</sub>(H) branches of the hysteresis envelope curve, their corresponding slope functions S<sub>UH</sub>(H) and S<sub>LH</sub>(H) and the actual operating point H(t), B(t).</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\"><tr>
<td><p><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Tellinen/TellinenDesc1.png\"/></p></td>
</tr>
</table>
</html>"));
        end Tellinen;

        class Preisach "Preisach Hysteresis Model"
          extends Modelica.Icons.Information;

          annotation (Documentation(info="<html>
<h4>The Preisach hysteresis model</h4>

<p>
This section gives an very brief overview of the Preisach hysteresis model, which is explained in more detail in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Pr35, Ma03, Zi12]</a>. The classical Preisach hysteresis model describes the course of magnetic flux density B(t) of a ferromagnetic core material as a function of the course of the magnetic field strength H(t) and its history. The model assumes an infinite set of elementary hysteresis operators &gamma;&alpha;&beta;. The simple rectangular pattern of the output &gamma;&alpha;&beta;H(t) of such an operator with its upper and lower switching limits &alpha; and &beta; is shown Fig. 1.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1: </strong>Characteristics of an elementary hysteresis operator.</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Preisach/preisach_elementaryOperator.png\">
    </td>
  </tr>
</table>

<p>
Due to &alpha;&ge;&beta;, the switching limits &alpha; and &beta; span a right triangular region, often referred to as Preisach plane (see Fig. 2a). For each single point (&alpha;,&beta;) on this plane exactly one elementary hysteresis operator is defined with exactly the switching limits of &alpha; and &beta;.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 2:</strong> Preisach Plane (a) and exemplary plot of the Preisach distribution function P(&alpha;,&beta;) (b)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Preisach/preisach_PlaneAndDist.png\">
    </td>
  </tr>
</table>

<p>
Additionally, the Preisach distribution function P(&alpha;,&beta;) is defined over the Preisach plane, which gives each operator an individual weight (see Fig. 2b). The Preisach plane can be separated into two regions. The S+ region, in which all the operators being in the &quot;+1&quot; state and the S- region, in which all the operators being in the &quot;-1&quot; state. The line L(t), which separates the regions S+ and S- develops along with the variation of the magnetic field strength H(t) and holds information about its history. The current magnetic flux density can than be computed as follows:
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Preisach/Eqn_PreisachBt.png\">
    </td>
  </tr>
</table>

<h4>Hysteresis shape and computing of the double integral</h4>

<p>
The equation above shows, that the double integral of P(&alpha;,&beta;) have to be computed in every time step to compute B(t) according to the Preisach hysteresis model. Typically, the Preisach distribution function is not analytically integrable twice. A numerical double integration in every time step would be very computationally intensive. Therefore, an analytical description of the Everett function <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[YUY89]</a> is used to define the hysteresis shape.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Preisach/Eqn_EverettFcn.png\">
    </td>
  </tr>
</table>

<p>
The Everett function returns the change in magnetization which results when all elementary hysteresis operators of the region R switch from \"-1\" to the \"+1\" state (see Fig 3.). The entire Region S+ can be now be decomposed into several smaller triangular regions similar to R. This way the magnetization B(t) can be efficiently evaluated without the need of the numerical integration of the Preisach distribution function.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 3:</strong> Preisach plane and region R over which P(&alpha;,&beta;) is integrated to obtain E(H1,H2)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Preisach/EverettRegion.png\">
    </td>
  </tr>
</table>

<p>
According to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[YUY89]</a> the used analytical form of the Everett function is parameterized by 8 parameters. Several parameter sets were identified to fit measured or published static hysteresis behavior of different materials. These predefined parameter sets are stored in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\"><code>FluxTubes.Material.HysteresisEverettParameter</code></a> library and can be used with the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystPreisachEverett\"><code>GenericHystPreisachEverett</code></a> flux tube element. Additionally, also the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenEverett\"><code>GenericHystTellinenEverett</code></a> element can use this library.
</p>

</html>"));
        end Preisach;
        annotation (Documentation(info="<html>
<p>
Two different types of hysteresis models are supported:</p>
<ul>
<li> Tellinen model (a simple model to describe the static magnetic hysteresis behavior of ferromagnetic materials).</li>
<li> Preisach model (a more detailed, but also computationally more involved hysteresis model).</li>
</ul>
</html>"));
      end StaticHysteresis;

      class DynamicHysteresis "Dynamic Hysteresis (Eddy Currents)"
        extends Modelica.Icons.Information;
        annotation (Documentation(info="<html>

<h4>Dynamic Hysteresis (Eddy Currents)</h4>

<p>
Some of the hysteresis flux tubes elements of the package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> are capable of simulating eddy currents (dynamic hysteresis) additional to the static hysteresis behavior of the core material. The computation of eddy currents can be activated via the switch <code>includeEddyCurrents</code> in the \"LossesAndHeat\" tab of the corresponding elements parameter dialog. The total magnetic field strength <code>H</code> of the element is the sum of the ferromagnetic portion <code>Hstat</code> and the eddy current portion <code>Heddy:</code>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/DynamicHysteresis/Eqn_EddyCurrent_Ht.png\">
    </td>
  </tr>
</table>

<p>
The eddy current portion of the magnetic field strength is the product of the classical eddy current factor (<code>&sigma;<sub>cl</sub></code>) <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[BE01,Te98]</a> and the time derivative of the magnetic flux density B(t):
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/DynamicHysteresis/Eqn_EddyCurrent_Heddy.png\">
    </td>
  </tr>
</table>

<p>
Where <code>&sigma;</code> is the electrical conductivity and <code>d</code> the thickness of the used electric steel sheets. Fig. 1 shows the decomposition of an exemplary dynamic hysteresis in its static and eddy current portion.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 1:</strong> Static and dynamic portion of the hysteresis B(H)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/DynamicHysteresis/Eddy_BHBHstatBHeddy.png\">
    </td>
  </tr>
</table>

<p>
The following two figures show a comparison between measured and simulated dynamic hysteresis at several frequencies. The measurements were performed with a 25 cm Epstein frame  according to DIN EN 60404-2. The magnetic core was made up of four layers of M330-50A steel sheet. The primary Winding of the used Epstein frame had 720 turns. The primary voltage was adjusted so that the magnetic excitation was about Hmax = 400 A/m, but 72 V in maximum. The simulation results (see Fig. 3) were generated with a simple model of this setup using the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenTable\">GenericHystTellinenTable</a> hysteresis flux tube element for modeling the magnetic core.
</p>


<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 2:</strong> Dynamic hysteresis measurements with an 25 cm Epstein frame according to DIN EN 60404-2 (Material: M330-50A, 4 Sheets)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/DynamicHysteresis/EddyCurrent_Epstein_Meas.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 3:</strong> Simulation results of a 25 cm Epstein frame model according to the measurement setup of Fig. 1</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/DynamicHysteresis/EddyCurrent_Epstein_Sim.png\">
    </td>
  </tr>
</table>


</html>"));
      end DynamicHysteresis;

      class HysteresisLosses "Hysteresis losses"
        extends Modelica.Icons.Information;
        annotation (Documentation(info="<html>
<h4>Hysteresis power losses</h4>
<p>The total power loss (<code>LossPower</code>) of an hysteresis flux tube element is the sum of the power loss due to the static ferromagnetic hysteresis (<code>LossPowerStat</code>) and the power loss due to eddy currents (<code>LossPowerEddy</code>).</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/Eqn_LossPower01.png\">
    </td>
  </tr>
</table>

<p>
The two components <code>LossPowerStat</code> and <code>LossPowerEddy</code> can be calculated as follows.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/Eqn_LossPower02.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/Eqn_LossPower03.png\">
    </td>
  </tr>
</table>

<p>
Where <code>&sigma;<sub>cl</sub></code> is the classical eddy current factor (see <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.DynamicHysteresis\">UsersGuide.Hysteresis.DynamicHysteresis</a>) and V the volume of the core material. The equations show that <code>LossPowerStat</code> acts as power sink and power source (magnetic energy storage) whereas <code>LossPowerEddy</code> is always positive (Power sink). By means of an simple example the following figures show the time course of the magnetic flux density,  the magnetic field strength and the hysteresis losses. The pulsating course of the power loss (see Fig. 3c) makes it difficult to estimate an average loss. For this reason, the hysteresis flux tube elements are capable of directly computing the moving average of the power losses. Therefore, <code>t_avg</code> of the \"LossesAndHeat\" tab of the elements parameter dialog may be adjusted to set an adequate time interval (see Fig. 3d).
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Diagram of a simple transformer with ferromagnetic core (model available at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis.SinglePhaseTransformerWithHysteresis1\">Examples.Hysteresis.SinglePhaseTransformerWithHysteresis1</a>)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/PowerLoss_Hysteresis01.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 2:</strong> Simulated total dynamic hysteresis loop with its static and eddy current fractions</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/PowerLoss_Hysteresis02.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 3:</strong> Simulated outputs of the <code>Core</code> component of Fig. 1</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/PowerLoss_Hysteresis03.png\">
    </td>
  </tr>
</table>

</html>"));
      end HysteresisLosses;
      annotation (Documentation(info="<html>

<h4>Introduction</h4>

<p>
The elements provided in the package Shapes.HysteresisAndMagnets allow for consideration of ferromagnetic and dynamic hysteresis during the simulation of electromagnetic networks. The ferromagnetic hysteresis is a material property of the core material and frequency independent. Due to eddy currents the static ferromagnetic hysteresis is superposed by a frequency dependent hysteresis when the ferromagnetic material is exposed to an alternating magnetic field. Fig 1 exemplary shows the simulated hysteresis characteristics of a simple inductor with an iron core for three different excitation frequencies. Thereby, the 0 Hz hysteresis loop represents the static ferromagnetic hysteresis of the core material. The widening of the loops for higher frequencies is due to eddy currents induced in the core material.
</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Inductor with ferromagnetic core and hysteresis effects; (a) diagram of the network model; (b) simulated hysteresis characteristics of the core for different excitation frequencies of 0, 10 and 100 Hz (the example model can be found at: <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis.InductorWithHysteresis\">Examples.Hysteresis.InductorWithHysteresis</a>)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/InductorWithHysteresis_DiagramAndSim.png\">
   </td>
  </tr>
</table>

<p>
Several models to describe the static hysteresis behavior of ferromagnetic materials are known. In this library two of them are implemented. The simple but fast <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a> and the more accurate but complex <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Preisach\">Preisach hysteresis model</a>. Click the links for a short description of both models.
</p>

<h4>Flux tube elements of the Package HysteresisAndMagnets</h4>

<table border=1 cellspacing=0 cellpadding=2>
 <tr>
  <th>Name / Icon</th><th>Description</th>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenSoft\">GenericHystTellinenSoft</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystTellinenS.png\">
  </td>
  <td>
  Flux tube element for modeling soft magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The shape of the limiting hysteresis loop is described by simple hyperbolic tangent functions with 4 parameters. Therefore, the hysteresis shape variety is limited but the parameterization of the model is very simple and the model is relatively fast and robust.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenHard\">GenericHystTellinenHard</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystTellinenH.png\">
  </td>
  <td>
  Flux tube element for modeling the ferromagnetic (static) hysteresis of hard magnetic materials. The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The shape of the limiting hysteresis loop is described by simple hyperbolic tangent functions with 4 parameters.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenEverett\">GenericHystTellinenEverett</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystTellinenE.png\">
  </td>
  <td>
  Flux tube element for modeling soft magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The Shape of the limiting ferromagnetic hysteresis loop is specified by an analytical description of the Everett function, which is also used to parameterize the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystPreisachEverett\">GenericHystPreisachEverett</a> model. A library of predefined parameter sets can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a>.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenTable\">GenericHystTellinenTable</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystTellinenT.png\">
  </td>
  <td>
  Flux tube element for modeling magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The rising and falling branch of the limiting ferromagnetic hysteresis loop are specified by table data. Therefore, almost any hysteresis shapes are possible. A library with predefined tables can be found at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisTableData\">FluxTubes.Material.HysteresisTableData</a>.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystPreisachEverett\">GenericHystPreisachEverett</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystPreisachE.png\">
  </td>
  <td>
  Flux tube element for modeling magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Preisach\">Preisach hysteresis model</a>. The Shape of the limiting ferromagnetic hysteresis loop is specified by an analytical description of the Everett function. A library of predefined parameter sets can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a>.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenPermanentMagnet\">GenericHystTellinenPermanentMagnet</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystTellinenPM.png\">
  </td>
  <td>
  Flux tube element for modeling the hard magnetic hysteresis of permanent magnets. The model is similar to <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenHard\">GenericHystTellinenHard</a> but has an initial magnetization preset of -100% and an adapted icon for better readability of the diagram.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericLinearPermanentMagnet\">GenericLinearPermanentMagnet</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericLinearPM.png\">
  </td>
  <td>
  Simple model of a linear permanent Magnet. Typical characteristics of common permanent magnetic materials can be found at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">FluxTubes.Material.HardMagnetic</a>.
  </td>
 </tr>

</table>

</html>"));
    end Hysteresis;

    class Literature "Literature"
      extends Modelica.Icons.References;

      annotation (Documentation(info="<html>
<h4>Literature</h4>
<ul>
<li><strong> Usage of the Modelica Magnetic library is described in:</strong>

<br><table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td>[B&ouml;08]</td>
      <td>B&ouml;drich, T.:
        <em>Electromagnetic Actuator Modelling with the Extended Modelica Magnetic Library</em>,
        Modelica 2008 Conference, Bielefeld, Germany,pp. 221-227, March 3-4, 2008. Download from: <a href=\"https://www.modelica.org/events/modelica2008/Proceedings/sessions/session2d2.pdf\">https://www.modelica.org/events/modelica2008/&shy;Proceedings/sessions/session2d2.pdf</a></td>
    </tr>
</table><br>

</li>
<li><strong>The method of magnetic flux tubes as well as derivation of the permeance of many flux tube shapes is explained in detail in:</strong>

<br><table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td>[Ro41]</td>
      <td>Roters, H.:
        <em>Electromagnetic Devices</em>,
        New York: John Wiley &amp; Sons 1941 (8th Printing 1961)</td>
    </tr>
</table><br>
</li>

<li><strong>Structure, properties, applications and design of electromagnetic (reluctance type) actuators are thoroughly described in:</strong>

<br><table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td>[KEQ+12]</td>
      <td>Kallenbach, E.; Eick, R.; Quendt, P.; Str&ouml;hla, T.; Feindt, K.; Kallenbach, M.; Radler, O.:
        <em>Elektromagnete: Grundlagen, Berechnung, Entwurf und Anwendung</em>,
        3rd ed., Wiesbaden: Vieweg Teubner 2008 (in German).</td>
    </tr>

    <tr>
      <td>[Ro00]</td>
      <td>Roschke, T.:
        <em>Entwurf geregelter elektromagnetischer Antriebe f&uuml;r Luftsch&uuml;tze</em>,
        Fortschritt-Berichte VDI, Reihe 21, Nr. 293, D&uuml;sseldorf: VDI-Verlag 2000 (in German).</td>
    </tr>
</table><br>
</li>

<li><strong> Application of the method of magnetic flux tubes to the design of rotational electrical machines is explained for example in:</strong>

<br><table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td>[HM94]</td>
      <td>Hendershot, J.R. Jr.; Miller, T.J.E.:
        <em>Design of Brushless Permanent-Magnet Motors</em>,
        Magna Physics Publishing and Oxford University Press 1994.</td>
    </tr>
</table><br>
</li>

<li><strong>Information related to the implemented hysteresis models can be found in:</strong>

<br><table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td>[BE01]</td>
      <td>Bergqvist, A. J.; Engdahl, S. G.:
        <em>A Homogenization Procedure of Field Quantities in Laminated Electric Steel</em>,
        IEEE Transactions on Magnetics, vol.37, no.5, pp.3329-3331, 2001.</td>
    </tr>
    <tr>
      <td>[Te98]</td>
      <td>Tellinen, J:
        <em>A simple scalar model for magnetic hysteresis</em>,
        IEEE Translation Journal on Magnetics in Japan, vol.4, no.6, pp.353-359, 1989.</td>
    </tr>
    <tr>
      <td>[Pr35]</td>
      <td>Preisach, F.:
        <em>&Uuml;ber die magnetische Nachwirkung</em>,
        Zeitschrift f&uuml;r Physik A Hadrons and Nuclei, vol. 94, pp. 277-302, 1935.</td>
    </tr>
    <tr>
      <td>[Ma03]</td>
      <td>Mayergoyz, I.:
        <em>Mathematical Models of Hysteresis and their Application</em>,
        Elsevier, 2003.</td>
    </tr>
    <tr>
      <td>[Va01]</td>
      <td>VAC Vacuumschmelze:
        <em>Soft Magnetic Cobalt-Iron-Alloys</em>, 2001.
        Download from: <a  href=\"http://www.vacuumschmelze.com/fileadmin/docroot/medialib/documents/broschueren/htbrosch/Pht-004_e.pdf\">http://www.vacuumschmelze.com/fileadmin/&shy;docroot/medialib/documents/&shy;broschueren/htbrosch/Pht-004_e.pdf</a></td>
    </tr>
    <tr>
      <td>[YUY89]</td>
      <td>Yamaguchi, T.; Ueda, F.; Yamamoto, E.:
        <em>Simulation of Hysteresis Characteristics of Core Materials Using the Everett Function</em>,
        IEEE Translation Journal on Magnetics in Japan, vol.4, no.6, pp.353-359, 1989.</td>
    </tr>
    <tr>
      <td>[ZB12]</td>
      <td>Ziske, J.; B&ouml;drich, T.:
        <em>Magnetic Hysteresis Models for Modelica</em>,
        Proc. of the 9th Modelica Conference, Munich, Germany, pp. 151-158, September 3-5, 2012. Download from: <a  href=\"http://www.ep.liu.se/ecp/076/014/ecp12076014.pdf\">http://www.ep.liu.se/ecp/&shy;076/014/ecp12076014.pdf</a></td>
    </tr>
    <tr>
      <td>[ZB14]</td>
      <td>Ziske, J.; B&ouml;drich, T.:
        <em>http://www.ep.liu.se/ecp/096/017/ecp14096017.pdf</em>,
        Proc. of the 10th Modelica Conference, Lund, Sweden, pp. 165-172, March 10-12, 2014. Download from: <a  href=\"http://www.ep.liu.se/ecp/096/017/ecp14096017.pdf\">http://www.ep.liu.se/ecp/&shy;096/017/ecp14096017.pdf</a></td>
    </tr>

</table><br>
</li>

</ul>

</html>"));
    end Literature;

    class ReleaseNotes "Release Notes"
      extends Modelica.Icons.ReleaseNotes;
      annotation (Documentation(info="<html>

<h5>Version 3.2.2, 2014-12-05 (Johannes&nbsp;Ziske, Thomas&nbsp;B&ouml;drich)</h5>

<ul>
<li>Added package <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">FluxTubes.UsersGuide.Hysteresis</a></li>
<li>Added package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis\">FluxTubes.Examples.Hysteresis</a></li>
<li>Added package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">FluxTubes.Shapes.HysteresisAndMagnets</a></li>
<li>Added package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a></li>
<li>Added package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisTableData\">FluxTubes.Material.HysteresisTableData</a></li>
<li>Updated <a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.PartialFixedShape\">FluxTubes.Interfaces.PartialFixedShape</a> for differentiability</li>
<li>Updated <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">FluxTubes.UsersGuide.Literature</a></li>
</ul>

<h5>Version 3.2.2, 2014-01-15 (Christian&nbsp;Kral)</h5>

<ul>
<li>Added constant
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance\">permeance model</a></li>
<li>Added
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube\">GenericFluxTube</a></li>
<li>Added parameter <code>useConductance</code> including alternative parameterization in
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.EddyCurrent\">EddyCurrent</a></li>
<li>Added
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.Idle\">Idle</a></li>
<li>Added
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.Short\">Short</a></li>
<li>Added
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.Crossing\">Crossing</a></li>
</ul>

<h5>Version 1.5, 2013-01-04 (Martin&nbsp;Otter, Thomas&nbsp;B&ouml;drich, Johannes&nbsp;Ziske)</h5>
<ul>
<li>Added missing initial conditions</li>
<li>Fixed initial parameter values</li>
</ul>

<h5>Version 1.4, 2011-08-01 (Thomas&nbsp;B&ouml;drich)</h5>
<ul>
<li>MagneticPort declared with MagneticPotential instead of MagneticPotentialDifference</li>
</ul>

<h5>Version 1.3, 2010-04-22 (Christian&nbsp;Kral)</h5>
<ul>
<li>Added conditional heat port to EddyCurrent model</li>
</ul>

<h5>Version 1.2, 2009-08-11 (Christian&nbsp;Kral, Anton&nbsp;Haumer, Thomas&nbsp;B&ouml;drich, Martin&nbsp;Otter)</h5>
<ul>
<li>Update and improvement for inclusion in the
    Modelica Standard Library</li>
</ul>

<h5>Version 1.1, 2009-05-19 (Thomas&nbsp;B&ouml;drich)</h5>
<ul>
<li>Coupling coefficient in Basic.ElectroMagneticConverter removed</li>
<li>Basic.EddyCurrent added</li>
<li>Example MovingCoilActuator, especially PermeanceModel, completely revised</li>
<li>Leakage coefficient replaced by coupling coefficient in Basic.LeakageWithCoefficient</li>
<li>Utilities.CoilDesign: parameter U renamed to V_op,CoilDesign moved to Utilities.</li>
<li>Reference direction for magnetic flux added in all sources</li>
<li>degC replaced by K for compatibility with Modelica 3.0</li>
<li>redeclare in Sensors for compatibility with Modelica 3.0 removed</li>
<li>Partial flux tube components moved to Interfaces and basic elements moved to new package Basic</li>
</ul>

<h5>Version 1,0, 2007-10-11 (Thomas&nbsp;B&ouml;drich)</h5>
<ul>
<li>Release of version 1.0 of the library</li>
</ul>

<h5>2005 (Thomas&nbsp;B&ouml;drich)</h5>
<ul>
<li>First release of a Modelica magnetic library</li>
</ul>

</html>"));
    end ReleaseNotes;

    class Contact "Contact"
      extends Modelica.Icons.Contact;

      annotation (Documentation(info="<html>
<h4>Main authors</h4>

<p>
<a href=\"http://www.ifte.de/mitarbeiter/boedrich.html\"><strong>Thomas B&ouml;drich</strong></a><br>
    Dresden University of Technology<br>
    Institute of Electromechanical and Electronic Design<br>
    01062 Dresden, Germany<br>
    Phone: +49 - 351 - 463 36296<br>
    Fax: +49 - 351 - 463 37183<br>
    email: <a href=\"mailto:Thomas.Boedrich@tu-dresden.de\">Thomas.Boedrich@tu-dresden.de</a>
</p>
<p>
<a href=\"http://www.ifte.de/mitarbeiter/ziske.html\"><strong>Johannes Ziske</strong></a><br>
    Dresden University of Technology<br>
    Institute of Electromechanical and Electronic Design<br>
    01062 Dresden, Germany<br>
    Phone: +49 - 351 - 463 35250<br>
    Fax: +49 - 351 - 463 37183<br>
    email: <a href=\"mailto:Johannes.Ziske@tu-dresden.de\">Johannes.Ziske@tu-dresden.de</a>
</p>

<h4>Acknowledgements</h4>

<ul>
<li> The magnetisation characteristics of the included soft magnetic materials were compiled and measured respectively by Thomas Roschke, now with Johnson Electric. Provision of this data is highly appreciated. He also formulated the approximation function used for description of the magnetisation characteristics of these materials.
</li>
<li> Andr&eacute; Klick of then Dresden University of Technology, Dresden, Germany gave valuable support on the implementation of this library. His contribution is highly appreciated, too.
</li>
<li> The hysteresis models of this library have been developed by Johannes Ziske and Thomas B&ouml;drich as part of the
   <a href=\"http://www.cleansky.eu/\">Clean Sky</a> JTI project; project number: 296369; Theme:
   <a href=\"http://cordis.europa.eu/project/rcn/101194_en.html\">JTI-CS-2011-1-SGO-02-026</a>;
   MOMOLIB - Modelica Model Library Development for Media, Magnetic Systems and Wavelets.
   The partial financial support by the European Union for this development is highly appreciated.</li>
</ul>
</html>"));
    end Contact;

    annotation (DocumentationClass=true, Documentation(info="<html>
<p>
This library contains components for modelling of electromagnetic devices with lumped magnetic networks. Those models are suited for both rough design of the magnetic subsystem of a device as well as for efficient dynamic simulation at system level together with neighbouring subsystems. At present, components and examples for modelling of <em>translatory</em> electromagnetic and electrodynamic actuators are provided. If needed, these components can be adapted to network modelling of <em>rotational</em> electrical machines.
</p>
<p>
This user's guide gives a short introduction to the underlying concept of <strong>magnetic flux tubes</strong>, summarizes the calculation of magnetic <strong>reluctance forces</strong> from lumped magnetic network models and lists <strong>reference literature</strong>.
</p>
<p>
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples\">Examples</a> illustrates the usage of magnetic network models with simple models from different fields of application.</p>
</html>"));
  end UsersGuide;

  package Examples
    "Illustration of component usage with simple models of various devices"
    extends Modelica.Icons.ExamplesPackage;

    model SaturatedInductor
      "Inductor with saturation in the ferromagnetic core"
      extends Modelica.Icons.Example;

      FluxTubes.Basic.Ground ground_m annotation (Placement(transformation(
              extent={{50,-30},{70,-10}})));
      Modelica.Electrical.Analog.Sources.SineVoltage source(
        freqHz=50,
        phase=pi/2,
        V=230*sqrt(2)) "Voltage applied to inductor" annotation (Placement(
            transformation(
            origin={-80,10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor r(R=7.5)
        "Inductor coil resistance" annotation (Placement(transformation(extent=
                {{-61,10},{-41,30}})));
      FluxTubes.Basic.ElectroMagneticConverter coil(N=600, i(fixed=true))
        "Inductor coil" annotation (Placement(transformation(extent={{-30,0},{-10,
                20}})));
      Basic.ConstantReluctance r_mLeak(R_m=1.2e6) "Constant leakage reluctance"
        annotation (Placement(transformation(
            origin={10,10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Shapes.FixedShape.Cuboid r_mAirPar(
        a=0.025,
        b=0.025,
        nonLinearPermeability=false,
        mu_rConst=1,
        l=0.0001)
        "Reluctance of small parasitic air gap (ferromagnetic core packeted from single sheets)"
        annotation (Placement(transformation(extent={{26,10},{46,30}})));
      Shapes.FixedShape.Cuboid r_mFe(
        mu_rConst=1000,
        a=0.025,
        b=0.025,
        nonLinearPermeability=true,
        l=4*0.065,
        material=
            Material.SoftMagnetic.ElectricSheet.M350_50A(),
        B(start=0)) "Reluctance of ferromagnetic inductor core" annotation (
          Placement(transformation(
            origin={60,10},
            extent={{-10,-10},{10,10}},
            rotation=270)));

      Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
            transformation(extent={{-90,-30},{-70,-10}})));

    equation
      connect(source.p, r.p)
        annotation (Line(points={{-80,20},{-61,20}}, color={0,0,255}));
      connect(r.n, coil.p) annotation (Line(points={{-41,20},{-30,20},{-30,20}}, color={0,0,255}));
      connect(source.n, coil.n)
        annotation (Line(points={{-80,0},{-30,0},{-30,0}}, color={0,0,255}));
      connect(coil.port_p, r_mLeak.port_p) annotation (Line(points={{-10,20},{-10,20},{10,20}},
                                color={255,127,0}));
      connect(r_mLeak.port_p, r_mAirPar.port_p)
        annotation (Line(points={{10,20},{26,20}}, color={255,127,0}));
      connect(r_mAirPar.port_n, r_mFe.port_p)
        annotation (Line(points={{46,20},{54,20},{60,20}}, color={255,127,0}));
      connect(r_mFe.port_n, r_mLeak.port_n) annotation (Line(points={{60,0},{
              47.5,0},{35,0},{10,0}}, color={255,127,0}));
      connect(r_mFe.port_n, coil.port_n)
        annotation (Line(points={{60,0},{-10,0},{-10,0}}, color={255,127,0}));
      connect(ground.p, source.n) annotation (Line(
          points={{-80,-10},{-80,0}}, color={0,0,255}));
      connect(ground_m.port, r_mFe.port_n) annotation (Line(
          points={{60,-10},{60,0}}, color={255,127,0}));
      annotation (experiment(StopTime=0.1, Tolerance=1e-007), Documentation(
            info="<html>
<p>
This model demonstrates the effects of non-linear magnetisation characteristics of soft magnetic materials (hysteresis neglected). A sinusoidal voltage is applied to an inductor with a closed ferromagnetic core of rectangular shape. Set the <strong>tolerance</strong> to <strong>1e-7</strong>, <strong>simulate for 0.1 s</strong> and plot for example:
</p>

<pre>
    coil.i vs. time           // non-harmonic current due to saturation of the core material
    r_mFe.mu_r vs. r_mFe.B    // relative permeability vs. flux density inside core
    r_mFe.B vs. r_mFe.H       // magnetisation curve B(H); hysteresis neglected
</pre>

<p>
The magnetisation characteristics of the flux tube element representing the ferromagnetic core can easily be changed from simplified linear behaviour (nonLinearPermeability set to false and R_mFe.mu_rConst set to a positive value, preferably mu_rConst >> 1) to non-linear behaviour (e.g., selection of one of the electric sheets in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">Material.SoftMagnetic</a> with nonLinearPermeability set to true). This enables for convenient initial design of magnetic circuits with linear material characteristics prior to simulation with non-linear behaviour.
</p>

<h4>Note</h4>

<p>
If the supply voltage has a zero-crossing when applied to the inductor at time t=0 (i.e., source.phase set to zero instead of &pi;/2), then the inrush current that is typical for switching of inductive loads can be observed.
</p>
</html>"));
    end SaturatedInductor;

    package MovingCoilActuator
      "Two translatory electrodynamic actuator models of different modelling depth and their comparison"
      extends Modelica.Icons.ExamplesPackage;

      model ForceCurrentBehaviour
        "Comparison of the force-current characteristics of both converter models with armature blocked at mid-position"

        extends Modelica.Icons.Example;

        Modelica.Electrical.Analog.Basic.Ground pmGround annotation (Placement(
              transformation(extent={{-70,-100},{-50,-80}})));
        FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator pmActuator(x(start=0),
            material=Material.HardMagnetic.PlasticNdFeB())
          "Moving coil actuator described with permeance model" annotation (
            Placement(transformation(extent={{-20,-70},{0,-50}})));
        Modelica.Mechanics.Translational.Components.Fixed pmFixedPos(s0=0)
          "Fixed armature position" annotation (Placement(transformation(extent=
                 {{10,-70},{30,-50}})));
        Modelica.Electrical.Analog.Sources.RampCurrent pmRampCurrent(
          I=-6,
          duration=6,
          offset=3) "Ideal current source" annotation (Placement(
              transformation(
              origin={-60,-60},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground cGround annotation (Placement(
              transformation(extent={{-70,-20},{-50,0}})));
        Modelica.Mechanics.Translational.Components.Fixed cFixedPos(s0=0)
          "Fixed armature position" annotation (Placement(transformation(extent=
                 {{10,10},{30,30}})));
        Modelica.Electrical.Analog.Sources.RampCurrent cRampCurrent(
          I=-6,
          duration=6,
          offset=3) "Ideal current source" annotation (Placement(
              transformation(
              origin={-60,20},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator cActuator
          "Moving coil actuator described with converter constant" annotation (
            Placement(transformation(extent={{-20,10},{0,30}})));
        Modelica.Blocks.Tables.CombiTable1Ds comparisonWithFEA(table=[-3, -9.65653;
              -2.5, -8.28587; -2, -6.82002; -1.5, -5.25898; -1, -3.60274; -0.5,
              -1.85131; 0, -0.00468; 0.5, 1.93714; 1, 3.97415; 1.5, 6.10636; 2,
              8.33376; 2.5, 10.65636; 3, 13.07415])
          "Column 1: current, col. 2: force; mu_rFe=const.=1000 in FEA model"
          annotation (Placement(transformation(extent={{40,40},{60,60}})));
        Modelica.Electrical.Analog.Sensors.CurrentSensor iSensor
          "Input value for look-up table with FEA results" annotation (
            Placement(transformation(extent={{-50,40},{-30,20}})));
      equation
        connect(pmFixedPos.flange, pmActuator.flange)
          annotation (Line(points={{20,-60},{0,-60}}, color={0,127,0}));
        connect(pmRampCurrent.p, pmActuator.p) annotation (Line(points={{-60,-50},{-30,-50},{-30,-50},{-20,-50}},
                                                color={0,0,255}));
        connect(pmActuator.n, pmRampCurrent.n) annotation (Line(points={{-20,-70},{-30,-70},{-30,-70},{-60,-70}},
                                                color={0,0,255}));
        connect(pmGround.p, pmRampCurrent.n)
          annotation (Line(points={{-60,-80},{-60,-70}}, color={0,0,255}));
        connect(cGround.p, cRampCurrent.n)
          annotation (Line(points={{-60,0},{-60,10}}, color={0,0,255}));
        connect(cActuator.flange, cFixedPos.flange)
          annotation (Line(points={{0,20},{20,20}}, color={0,127,0}));
        connect(cRampCurrent.n, cActuator.n) annotation (Line(points={{-60,10},{-30,10},{-30,10},{-20,10}},
                                             color={0,0,255}));
        connect(cRampCurrent.p, iSensor.p)
          annotation (Line(points={{-60,30},{-50,30}}, color={0,0,255}));
        connect(cActuator.p, iSensor.n) annotation (Line(points={{-20,30},{-30,30},{-30,30}},
                               color={0,0,255}));
        connect(iSensor.i, comparisonWithFEA.u) annotation (Line(points={{-40,41},{-40,50},{38,50}},
                                       color={0,0,127}));
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={Text(
                      extent={{-98,96},{100,86}},
                      lineColor={0,0,255},
                      textString=
                  "Comparison of the force-current characteristics of both converter models"),
                Text( extent={{-98,88},{2,78}},
                      lineColor={0,0,255},
                      textString="with armature blocked at mid-position")}),
          experiment(StopTime=6, Tolerance=1e-007),
          Documentation(info="<html>
<p>
Have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a> and at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> for an explanation of both converter models.<br>
</p>
<p>
Simulation of the force-current characteristics of both converter models with the armature blocked at mid-position x=0 reveals the difference between the two models. In the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a>, force is proportional to current. In the simple <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> there is an additional non-linear force component that is due to the dependency of the inductance on the armature position. Comparison with FEA results validates the higher accuracy of the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a>. In the FEA model, the relative permeability of the stator iron was set to mu_rFe=const.=1000 in order to avoid additional non-linear force components due to saturation. <strong>Simulate for 6 s</strong> and <strong>plot vs. current (e.g., iSensor.i)</strong></p>
<pre>
    pmFixedPos.flange_b.f       // force of permeance model
    cFixedPos.flange_b.f        // force of converter constant model
    comparisonWithFEA.y[1]      // force of FEA model for comparison
</pre>
</html>"));
      end ForceCurrentBehaviour;

      model ForceStrokeBehaviour
        "Force-stroke characteristic of the permeance model at constant current"

        extends Modelica.Icons.Example;

        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(extent={{-70,-30},{-50,-10}})));
        FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator actuator(x(start=0),
            material=Material.HardMagnetic.PlasticNdFeB()) annotation (
            Placement(transformation(extent={{-30,0},{-10,20}})));
        Modelica.Electrical.Analog.Sources.ConstantCurrent source(I=3)
          annotation (Placement(transformation(
              origin={-60,10},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Sources.Ramp sweepX(
          height=7.99e-3,
          duration=8,
          offset=-3.995e-3,
          startTime=-4) annotation (Placement(transformation(extent={{70,0},{50,
                  20}})));
        Modelica.Mechanics.Translational.Sources.Position feedX(exact=true)
          annotation (Placement(transformation(extent={{30,0},{10,20}})));
        Modelica.Blocks.Tables.CombiTable1Ds comparisonWithFEA(table=[-0.004, -8.8729,
              -9.07503, 0.00332; -0.0035, -9.05239, -9.25042, 0.00352; -0.003,
              -9.1915, -9.38558, 0.00371; -0.0025, -9.28247, -9.47266, 0.0039;
              -0.002, -9.3587, -9.54503, 0.00409; -0.0015, -9.41568, -9.59782,
              0.00429; -0.001, -9.45496, -9.6331, 0.00448; -0.0005, -9.47427, -9.64839,
              0.00467; 0, -9.48639, -9.65616, 0.00486; 0.0005, -9.48623, -9.65174,
              0.00505; 0.001, -9.4732, -9.63435, 0.00524; 0.0015, -9.44143, -9.59825,
              0.00543; 0.002, -9.39915, -9.55226, 0.00562; 0.0025, -9.33166, -9.47988,
              0.00581; 0.003, -9.23707, -9.38112, 0.006; 0.0035, -9.09497, -9.23417,
              0.00619; 0.004, -8.91839, -9.05337, 0.00638])
          "Column 1: position, col.2: force with non-linear stator iron, col.3: force with mu_rFe=const.=1000, col.4: inductance with mu_rFe=const.=1000"
          annotation (Placement(transformation(extent={{50,30},{70,50}})));
      equation
        connect(ground.p, source.n)
          annotation (Line(points={{-60,-10},{-60,0}}, color={0,0,255}));
        connect(source.n, actuator.n) annotation (Line(points={{-60,0},{-46,0},{-46,0},{-30,0}},
                                  color={0,0,255}));
        connect(source.p, actuator.p) annotation (Line(points={{-60,20},{-46,20},{-46,20},{-30,20}},
                                    color={0,0,255}));
        connect(sweepX.y, feedX.s_ref)
          annotation (Line(points={{49,10},{32,10}}, color={0,0,127}));
        connect(feedX.flange, actuator.flange)
          annotation (Line(points={{10,10},{-10,10}}, color={0,127,0}));
        connect(feedX.s_ref, comparisonWithFEA.u)
          annotation (Line(points={{32,10},{40,10},{40,40},{48,40}},
                                                             color={0,0,127}));
        annotation (experiment(
            StartTime=-4,
            StopTime=4,
            Tolerance=1e-007), Documentation(info="<html>
<p>
Have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a> and at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> for an explanation of both converter models.<br>
</p>
<p>
Simulation of the force-stroke characteristic of the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> with a constant current I=3A and a forced armature movement (similar to measurements in reality) shows the dependency of both force-generating permeances G_ma and G_mb as well as inductance L on armature position x. <strong>Simulate for 8 s</strong> and <strong>plot vs.</strong> armature position <strong>feedX.flange_b.s</strong> (same physical quantities together in a common diagram for comparison):</p>
<pre>
    feedX.flange_b.f            // force of permeance model (permeance of stator iron neglected in this model)
    comparisonWithFEA.y[1]      // force of FEA model with non-linear stator iron 1.0718
    comparisonWithFEA.y[2]      // force of FEA model with mu_rFe=const.=1000
    actuator.g_ma.G_m           // permeance G_ma
    actuator.g_mb.G_m           // permeance G_mb
    actuator.L                  // inductance of permeance model
    comparisonWithFEA.y[3]      // inductance of FEA model for comparison (mu_rFe=const.=1000).
</pre>
</html>"));
      end ForceStrokeBehaviour;

      model ArmatureStroke
        "Armature stroke of both moving coil actuator models after a voltage step at time t=0"

        extends Modelica.Icons.Example;

        Modelica.Electrical.Analog.Basic.Ground pmGround annotation (Placement(
              transformation(extent={{-80,-70},{-60,-50}})));
        Modelica.Electrical.Analog.Sources.StepVoltage pmSource(startTime=0, V=
              pmActuator.R*1.5) "Steady state current 1.5A" annotation (
            Placement(transformation(
              origin={-70,-30},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator pmActuator(
          material=Material.HardMagnetic.PlasticNdFeB(),
          x(start=pmActuator.x_min, fixed=true),
          armature(v(fixed=true)),
          coil(i(fixed=true)))
          "Moving coil actuator described with permeance model" annotation (
            Placement(transformation(extent={{-40,-40},{-20,-20}})));

        Modelica.Mechanics.Translational.Components.Mass pmLoad(m=0.05)
          "Load to be moved in addition to the armature mass" annotation (
            Placement(transformation(extent={{0,-40},{20,-20}})));
        Modelica.Electrical.Analog.Basic.Ground cGround annotation (Placement(
              transformation(extent={{-80,0},{-60,20}})));
        Modelica.Electrical.Analog.Sources.StepVoltage cSource(startTime=0, V=
              cActuator.R*1.5) "Steady state current 1.5A" annotation (
            Placement(transformation(
              origin={-70,40},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator cActuator(
          x(start=cActuator.x_min, fixed=true),
          armature(v(fixed=true)),
          l(i(start=0, fixed=true)))
          "Moving coil actuator described with converter constant" annotation (
            Placement(transformation(extent={{-40,30},{-20,50}})));
        Modelica.Mechanics.Translational.Components.Mass cLoad(m=0.05)
          "Load to be moved in addition to the armature mass" annotation (
            Placement(transformation(extent={{0,30},{20,50}})));
      equation
        connect(pmLoad.flange_a, pmActuator.flange)
          annotation (Line(points={{0,-30},{-20,-30}}, color={0,127,0}));
        connect(cGround.p, cSource.n)
          annotation (Line(points={{-70,20},{-70,30}}, color={0,0,255}));
        connect(cLoad.flange_a, cActuator.flange)
          annotation (Line(points={{0,40},{-20,40}}, color={0,127,0}));
        connect(cSource.p, cActuator.p) annotation (Line(points={{-70,50},{-56,50},{-56,50},{-40,50}},
                                        color={0,0,255}));
        connect(cSource.n, cActuator.n) annotation (Line(points={{-70,30},{-56,30},{-56,30},{-40,30}},
                                        color={0,0,255}));
        connect(pmSource.n, pmGround.p)
          annotation (Line(points={{-70,-40},{-70,-50}}, color={0,0,255}));
        connect(pmSource.n, pmActuator.n) annotation (Line(points={{-70,-40},{-54,-40},{-54,-40},{-40,-40}},
                                           color={0,0,255}));
        connect(pmSource.p, pmActuator.p) annotation (Line(points={{-70,-20},{-55,-20},{-55,-20},{-40,-20}},
                                           color={0,0,255}));
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={Text(
                      extent={{-98,98},{48,86}},
                      lineColor={0,0,255},
                      textString=
                  "Comparison of a pull-in stroke of both converter models"),
                Text( extent={{-98,90},{-30,80}},
                      lineColor={0,0,255},
                      textString="after a voltage step at t=0")}),
          experiment(StopTime=0.05, Tolerance=1e-007),
          Documentation(info="<html>
<p>
Have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a> and at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a>
for an explanation of both actuator models.</p>

<p>
A voltage step at time t=0 is applied to both actuator models. In each model, the armature and an attached load mass perform a stroke between the two stoppers included in cActuator.armature and pmActuator.armature respectively. <strong>Simulate for 0.05 s</strong> and plot vs. time (same physical quantities together in a common diagram for comparison):
</p>
<pre>
    cActuator.p.i                     // input current to converter constant model
    pmActuator.p.i                    // input current to permeance model
    cActuator.armature.flange_a.f     // actuator force of converter constant model
    pmActuator.armature.flange_a.f    // actuator force of permeance model
    cActuator.x                       // armature position of converter constant model
    pmActuator.x                      // armature position of permeance model
    cActuator.L                       // inductance of converter constant model
    pmActuator.L                      // inductance of permeance model
</pre>
<p>
The initial current rise in both actuator models is due to the inductance of the actuator coil. After acceleration of the armature and the load, the current decreases due to the motion-induced back-emf. Bouncing occurs when the armatures of both models arrive at the stopper at maximum armature position. The bouncing is rather intense due to the absence of any kind of external friction in this simple example (apart from the nonlinear damping in the stopper elements). After decay of the bouncing, both actuators operate under conditions valid for a blocked armature.
</p>
<p>
Whereas the steady state current is the same in both models, the steady state actuator force is not due to the neglect of the non-linear force component in the converter constant model. Differences in the current rise of both models are due to the neglect of the coil inductance variation in the converter constant model.
</p>
</html>"));
      end ArmatureStroke;

      package Components "Components to be used in examples"
        extends Modelica.Icons.Package;

        model PermeanceActuator
          "Detailed actuator model for rough magnetic design of actuator and system simulation"

          parameter Real N=140 "Number of turns" annotation (Dialog(group=
                  "Parameters", groupImage=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/MovingCoilActuator/MovingCoilActuator_dimensions.png"));
          parameter SI.Resistance R=2.86 "Coil resistance";

          parameter SI.Radius r_core=12.5e-3
            "Radius of ferromagnetic stator core";

          parameter SI.Length l_PM=3.5e-3
            "Radial thickness of permanent magnet ring";
          parameter SI.Length t=0.02
            "Axial length of permanent magnet ring and air gap respectively";

          parameter SI.Length l_air=3e-3
            "Total radial length of armature air gap";

          parameter SI.Length l_FeOut=4e-3
            "Radial thickness of outer back iron (for estimation of leakage permeance)";

          parameter FluxTubes.Material.HardMagnetic.BaseData material=
              Material.HardMagnetic.BaseData()
            "Ferromagnetic material characteristics"
            annotation (choicesAllMatching=true, Dialog(group="Material"));

          parameter SI.Mass m_a=0.012 "Mass of armature"
            annotation (Dialog(group="Armature and stopper"));

          parameter SI.TranslationalSpringConstant c=1e11
            "Spring stiffness between impact partners"
            annotation (Dialog(group="Armature and stopper"));
          parameter SI.TranslationalDampingConstant d=400
            "Damping coefficient between impact partners"
            annotation (Dialog(group="Armature and stopper"));
          parameter SI.Position x_min=-4e-3
            "Position of stopper at minimum armature position"
            annotation (Dialog(group="Armature and stopper"));
          parameter SI.Position x_max=4e-3
            "Position of stopper at maximum armature position"
            annotation (Dialog(group="Armature and stopper"));

          SI.Position x(start=x_min, stateSelect=StateSelect.prefer)
            "Armature position, alias for flange position";

          SI.Inductance L "Coil inductance";

          FluxTubes.Sources.ConstantMagneticPotentialDifference mmf_PM(final V_m=
               material.H_cB*l_PM) "Permanent magnet's magnetomotive force"
            annotation (Placement(transformation(
                origin={10,20},
                extent={{-10,-10},{10,10}},
                rotation=270)));

          FluxTubes.Examples.Utilities.TranslatoryArmatureAndStopper armature(
            final L=0,
            final m=m_a,
            final c=c,
            final d=d,
            n=2,
            final x_max=x_max,
            final x_min=x_min)
            "Inertia of moving coil + coil carrier; stoppers at end of stroke range"
            annotation (Placement(transformation(extent={{60,-10},{80,10}})));
          Modelica.Electrical.Analog.Basic.Resistor r(final R=R) annotation (
              Placement(transformation(
                origin={-80,30},
                extent={{-10,-10},{10,10}},
                rotation=270)));

          Basic.Ground ground annotation (Placement(transformation(extent={{30,
                    -38},{50,-18}})));
          FluxTubes.Basic.ElectroMagneticConverter coil(final N=N) annotation (
              Placement(transformation(
                origin={0,-20},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          FluxTubes.Shapes.Force.HollowCylinderRadialFlux g_ma(
            final dlBydx=1,
            final l=t/2 + x,
            final r_i=r_core,
            final r_o=r_core + l_air + l_PM,
            final mu_r=1.05,
            final useSupport=false) annotation (Placement(transformation(
                origin={-20,0},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          FluxTubes.Shapes.Force.HollowCylinderRadialFlux g_mb(
            final r_i=r_core,
            final r_o=r_core + l_air + l_PM,
            final dlBydx=-1,
            final l=t/2 - x,
            final mu_r=1.05,
            final useSupport=false) annotation (Placement(transformation(
                origin={30,0},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          FluxTubes.Shapes.Leakage.CoaxCylindersEndFaces g_mLeak1(
            final r_1=r_core + l_air + l_PM,
            final r_2=r_core + l_air + l_PM + l_FeOut,
            final r_0=r_core)
            "Leakage between coaxial end planes of ferromagnetic stator core and outer back iron"
            annotation (Placement(transformation(
                origin={-60,10},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          FluxTubes.Shapes.Leakage.HalfCylinder g_mLeak2(final l=2*pi*(r_core +
                (l_air + l_PM)/2))
            "Leakage between edges of ferromagnetic stator core and outer back iron"
            annotation (Placement(transformation(
                origin={-40,10},
                extent={{-10,-10},{10,10}},
                rotation=270)));

          Modelica.Electrical.Analog.Interfaces.PositivePin p
            "Electrical connector" annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin n
            "Electrical connector" annotation (Placement(transformation(extent={{-90,-110},{-110,-90}})));
          Modelica.Mechanics.Translational.Interfaces.Flange_b flange
            "Flange of component" annotation (Placement(transformation(extent={
                    {90,-10},{110,10}})));
        equation
          x = flange.s;
          L = coil.N^2*(g_ma.G_m + g_mLeak1.G_m + g_mLeak2.G_m);

          connect(armature.flange_b, flange) annotation (Line(
              points={{80,0},{100,0}}, color={0,127,0}));
          connect(r.p, p) annotation (Line(points={{-80,40},{-80,100},{-100,100}},
                                                                                 color={0,0,255}));
          connect(armature.flange_a, g_mb.flange)
            annotation (Line(points={{60,0},{40,0}}, color={0,127,0}));
          connect(g_mb.flange, g_ma.flange) annotation (Line(points={{40,0},{40,
                  40},{-10,40},{-10,0}}, color={0,127,0}));
          connect(g_mLeak1.port_n, g_ma.port_n) annotation (Line(points={{-60,0},
                  {-60,-10},{-20,-10}}, color={255,127,0}));
          connect(g_mLeak2.port_n, g_ma.port_n) annotation (Line(points={{-40,0},
                  {-40,-10},{-20,-10}}, color={255,127,0}));
          connect(g_ma.port_n, coil.port_p) annotation (Line(points={{-20,-10},{-18,-10},{-18,-12},{-14,-12},{-14,-10},{-10,-10}},
                                                                     color={255,
                  127,0}));
          connect(coil.port_n, g_mb.port_n)
            annotation (Line(points={{10,-10},{30,-10}},color={255,127,0}));
          connect(g_mb.port_n, mmf_PM.port_p) annotation (Line(points={{30,-10},
                  {50,-10},{50,30},{10,30}}, color={255,127,0}));
          connect(mmf_PM.port_p, g_mLeak2.port_p) annotation (Line(points={{10,
                  30},{-40,30},{-40,20}}, color={255,127,0}));
          connect(mmf_PM.port_p, g_mLeak1.port_p) annotation (Line(points={{10,
                  30},{-60,30},{-60,20}}, color={255,127,0}));
          connect(g_ma.port_p, mmf_PM.port_n)
            annotation (Line(points={{-20,10},{10,10}}, color={255,127,0}));
          connect(mmf_PM.port_n, g_mb.port_p)
            annotation (Line(points={{10,10},{30,10}}, color={255,127,0}));
          connect(r.n, coil.p) annotation (Line(points={{-80,20},{-80,-30},{-10,-30}},
                         color={0,0,255}));
          connect(coil.n, n) annotation (Line(points={{10,-30},{10,-100},{-100,-100}},
                                                                                   color={0,0,255}));
          connect(ground.port, g_mb.port_n) annotation (Line(
              points={{40,-18},{40,-10},{30,-10}}, color={255,127,0}));
          annotation (Documentation(info="<html>
<p>
In the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a> model the force F is strictly proportional to the current i as indicated by the converter constant c. However, there is an additional non-linear force component in such an actuator that is due to the dependency of the coil inductance L on the armature position x. The inductance increases as the armature moves into the stator. The total force is
</p>

<pre>
        1  2 dL
    F = - i  --  + c i
        2    dx
</pre>

<p>
Both force components are properly considered with a simple permeance model as shown in the figures below. Figure (a) illustrates the dimensions of the axis-symmetric moving coil actuator that are needed in the permeance model. Figure (b) shows partitioning into flux tubes and the permanent magnetic field without current. G_ma and G_mb both are the permeances resulting from a series connection of the permanent magnet and air gap sections. The field plot of the coil-imposed mmf is shown in figure (c) without the permanent magnetic mmf (H_cB=0). The placement of the magnetic network components in figure (d) retains the geometric structure of the actuator. In figure (e), the permeance model is restructured and thus simplified.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/MovingCoilActuator/MovingCoilActuator_PermeanceModel.png\" alt=\"Structure, assigned flux tubes and field plots of the moving coil actuator\">
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={Rectangle(
                          extent={{-90,100},{90,-100}},
                          lineColor={255,128,0},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Rectangle(
                          extent={{-90,100},{-50,-100}},
                          lineColor={0,0,255},
                          pattern=LinePattern.None,
                          fillColor={255,128,0},
                          fillPattern=FillPattern.Solid),Rectangle(
                          extent={{90,80},{-90,100}},
                          lineColor={0,0,255},
                          pattern=LinePattern.None,
                          fillColor={255,128,0},
                          fillPattern=FillPattern.Solid),Rectangle(
                          extent={{90,-80},{-90,-100}},
                          lineColor={0,0,255},
                          pattern=LinePattern.None,
                          fillColor={255,128,0},
                          fillPattern=FillPattern.Solid),Rectangle(
                          extent={{70,34},{-90,-34}},
                          lineColor={0,0,255},
                          pattern=LinePattern.None,
                          fillColor={255,128,0},
                          fillPattern=FillPattern.Solid),Rectangle(
                          extent={{90,52},{-16,64}},
                          lineColor={0,0,255},
                          pattern=LinePattern.None,
                          fillColor={255,213,170},
                          fillPattern=FillPattern.Solid),Rectangle(
                          extent={{90,-64},{-12,-52}},
                          lineColor={0,0,255},
                          pattern=LinePattern.None,
                          fillColor={255,213,170},
                          fillPattern=FillPattern.Solid),Text(
                          extent={{150,150},{-150,110}},
                          lineColor={0,0,255},
                          textString="%name")}));
        end PermeanceActuator;

        model ConstantActuator
          "Simple behavioural actuator model for system simulation"

          parameter SI.ElectricalForceConstant k=3.88 "Converter constant";
          parameter SI.Resistance R=2.86 "Coil resistance";
          parameter SI.Inductance L=0.0051 "Coil inductance at mid-stroke";
          parameter SI.Mass m_a=0.012 "Armature mass"
            annotation (Dialog(group="Armature and stopper"));
          parameter Modelica.SIunits.TranslationalSpringConstant c=1e11
            "Spring stiffness between impact partners"
            annotation (Dialog(group="Armature and stopper"));
          parameter Modelica.SIunits.TranslationalDampingConstant d=400
            "Damping coefficient between impact partners"
            annotation (Dialog(group="Armature and stopper"));
          parameter SI.Position x_min=-4e-3 "Minimum armature position"
            annotation (Dialog(group="Armature and stopper"));
          parameter SI.Position x_max=4e-3 "Maximum armature position"
            annotation (Dialog(group="Armature and stopper"));

          SI.Position x(start=x_min, stateSelect=StateSelect.prefer)
            "Armature position, alias for flange position";

          Modelica.Electrical.Analog.Basic.Resistor r(final R=R)
            "Coil resistance" annotation (Placement(transformation(extent={{-90,
                    50},{-70,70}})));
          FluxTubes.Examples.Utilities.TranslatoryArmatureAndStopper armature(
            final m=m_a,
            final x_max=x_max,
            final x_min=x_min,
            final L=0,
            final c=c,
            final d=d,
            n=2) "Armature inertia with stoppers at end of stroke range"
            annotation (Placement(transformation(extent={{60,-10},{80,10}})));

          Modelica.Electrical.Analog.Basic.Inductor l(final L=L)
            "Coil inductance" annotation (Placement(transformation(extent={{-60,
                    50},{-40,70}})));
          Modelica.Electrical.Analog.Basic.TranslationalEMF
            electroTranslationalConverter(final k=k) annotation (Placement(
                transformation(extent={{-40,-10},{-20,10}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin p
            "Electrical connector" annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin n
            "Electrical connector" annotation (Placement(transformation(extent={{-90,-110},{-110,-90}})));
          Modelica.Mechanics.Translational.Interfaces.Flange_b flange
            "Flange of component" annotation (Placement(transformation(extent={
                    {90,-10},{110,10}})));
        equation
          flange.s = x;

          connect(r.p, p)
            annotation (Line(points={{-90,60},{-100,60},{-100,100}},
                                                          color={0,0,255}));
          connect(l.p, r.n)
            annotation (Line(points={{-60,60},{-70,60}}, color={0,0,255}));
          connect(armature.flange_b, flange) annotation (Line(points={{80,0},{
                  85,0},{90,0},{100,0}}, color={0,127,0}));
          connect(l.n, electroTranslationalConverter.p) annotation (Line(points=
                 {{-40,60},{-30,60},{-30,10}}, color={0,0,255}));
          connect(n, electroTranslationalConverter.n) annotation (Line(points={{-100,-100},{-30,-100},{-30,-10}},
                                                   color={0,0,255}));
          connect(electroTranslationalConverter.flange, armature.flange_a)
            annotation (Line(points={{-20,0},{0,0},{20,0},{60,0}}, color={0,127,
                  0}));
          connect(p, p) annotation (Line(points={{-100,100},{-100,100}}, color={0,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={
                    {-100,-100},{100,100}}), graphics={Rectangle(
                          extent={{-80,100},{80,-100}},
                          lineColor={255,128,0},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Text(
                          extent={{-70,80},{72,-80}},
                          lineColor={255,128,0},
                          textString="c"),Line(points={{-90,100},{-80,100}},
                  color={0,0,255}),Line(points={{-90,-100},{-80,-100}},
                                                                      color={0,0,255}),
                  Line(points={{80,0},{90,0}}, color={0,127,0}),Text(
                          extent={{150,150},{-150,110}},
                          lineColor={0,0,255},
                          textString="%name")}), Documentation(info="<html>
<p>
Similar to rotational DC-Motors, the electro-mechanical energy conversion of translatory electrodynamic actuators and generators of moving coil and moving magnet type can be described with the following two converter equations:
</p>

<pre>
      F = c * i
    V_i = c * v
</pre>

<p>
with electrodynamic or <em>Lorentz</em> force F, converter constant c, current i, induced back-emf V_i and armature velocity v. The model is very similar to the well-known behavioural model of a rotational one-phase DC-Machine, except that it is for translatory motion. For a moving coil actuator with a coil inside an air gap with flux density B and a total wire length l inside the magnetic field, the converter constant becomes
</p>

<pre>
    c = B * l.
</pre>

<p>
The converter constant c as well as coil resistance R and inductance L are assumed to be known, e.g., from measurements or catalogue data. Hence this model is well-suited for system simulation together with neighbouring subsystems, but not for actuator design, where the motor constant is to be found on base of the magnetic circuit's geometry, material properties and winding data. See <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> for a more accurate model of this actuator that is based on a magnetic network. Due to identical connectors, both models can be used in system simulation, e.g. to simulate a stroke as demonstrated in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.ArmatureStroke\">ArmatureStroke</a>.
</p>
</html>"));
        end ConstantActuator;
      end Components;
      annotation (Documentation(info="<html>
<p>
Moving coil actuators are often called electrodynamic actuators and a proportional behaviour between force and current is expressed by a converter constant (see <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a>). However, in a simple moving coil actuator as presented in this example there is an additional non-linear force component that is due to the increase of the inductance when the armature coil moves into the ferromagnetic stator. A simple <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a> can be used to describe this non-linear force component.
</p>
</html>"));
    end MovingCoilActuator;

    package SolenoidActuator
      "Two models of a reluctance actuator of different modelling depth and their comparison and usage"
      extends Modelica.Icons.ExamplesPackage;

      model ComparisonQuasiStationary
        "Slow forced armature motion of both solenoid models so that electromagnetic field and current are quasi-stationary"

        extends Modelica.Icons.Example;

        parameter SI.Voltage v_step=12 "Applied voltage";

        Modelica.Blocks.Sources.Ramp x_set(
          duration=10,
          height=-(advancedSolenoid.x_max - advancedSolenoid.x_min),
          offset=advancedSolenoid.x_max)
          "Prescribed armature position, slow enforced motion from x_max to x_min"
          annotation (Placement(transformation(extent={{80,-10},{60,10}})));
        Modelica.Electrical.Analog.Basic.Ground advancedGround annotation (
            Placement(transformation(extent={{-80,10},{-60,30}})));
        Modelica.Electrical.Analog.Sources.StepVoltage advancedSource(V=v_step)
          annotation (Placement(transformation(
              origin={-70,50},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        FluxTubes.Examples.SolenoidActuator.Components.AdvancedSolenoid advancedSolenoid
          annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
        Modelica.Mechanics.Translational.Sources.Position advancedFeed_x(f_crit=
             1000, exact=false)
                               annotation (Placement(transformation(
              origin={0,50},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Modelica.Electrical.Analog.Basic.Ground simpleGround annotation (
            Placement(transformation(extent={{-80,-90},{-60,-70}})));
        Modelica.Electrical.Analog.Sources.StepVoltage simpleSource(V=v_step)
          annotation (Placement(transformation(
              origin={-70,-50},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid simpleSolenoid
          annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
        Modelica.Mechanics.Translational.Sources.Position simpleFeed_x(f_crit=
              1000, exact=false) annotation (Placement(transformation(
              origin={0,-50},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Modelica.Blocks.Tables.CombiTable1Ds comparisonWithFEA(table=[0.00025,
              -85.8619, 0.00014821, 0.11954; 0.0005, -59.9662, 0.00013931,
              0.11004; 0.00075, -41.0806, 0.0001277, 0.098942; 0.001, -28.88,
              0.00011587, 0.088425; 0.00125, -21.4113, 0.00010643, 0.08015;
              0.0015, -16.8003, 9.9406e-005, 0.073992; 0.00175, -13.6942,
              9.3416e-005, 0.068792; 0.002, -11.1188, 8.8564e-005, 0.064492;
              0.00225, -9.6603, 8.4505e-005, 0.060917; 0.0025, -8.4835,
              8.1215e-005, 0.058017; 0.00275, -7.4658, 7.7881e-005, 0.055125;
              0.003, -6.5591, 7.5197e-005, 0.052733; 0.00325, -5.9706,
              7.2447e-005, 0.05035; 0.0035, -5.5013, 7.0342e-005, 0.048525;
              0.00375, -5.0469, 6.8527e-005, 0.046867; 0.004, -4.6573,
              6.6526e-005, 0.045158; 0.00425, -4.2977, 6.4425e-005, 0.043442;
              0.0045, -4.0912, 6.2747e-005, 0.04205; 0.00475, -3.7456,
              6.1231e-005, 0.040733; 0.005, -3.5869, 5.9691e-005, 0.039467])
          "Valid for u_source=12V only; column 1: position, col.2: force, col.3: armature flux, col.4: inductance"
          annotation (Placement(transformation(extent={{60,40},{80,60}})));
      equation
        connect(advancedGround.p, advancedSource.n)
          annotation (Line(points={{-70,30},{-70,40}}, color={0,0,255}));
        connect(x_set.y, advancedFeed_x.s_ref) annotation (Line(points={{59,0},
                {20,0},{20,50},{12,50}}, color={0,0,127}));
        connect(simpleSolenoid.p, simpleSource.p) annotation (Line(points={{-40,-40},{-50,-40},{-50,-40},{-70,-40}},
                                                     color={0,0,255}));
        connect(simpleSolenoid.n, simpleSource.n) annotation (Line(points={{-40,-60},{-50,-60},{-50,-60},{-70,-60}},
                                                     color={0,0,255}));
        connect(simpleSolenoid.flange, simpleFeed_x.flange)
          annotation (Line(points={{-20,-50},{-10,-50}}, color={0,127,0}));
        connect(advancedSolenoid.n, advancedSource.n) annotation (Line(points={{-40,40},{-50,40},{-50,40},{-70,40}},
                                                      color={0,0,255}));
        connect(simpleFeed_x.s_ref, x_set.y) annotation (Line(points={{12,-50},
                {20,-50},{20,0},{59,0}}, color={0,0,127}));
        connect(x_set.y, comparisonWithFEA.u) annotation (Line(points={{59,0},{50,0},{50,50},{58,50}},
                                        color={0,0,127}));
        connect(advancedFeed_x.flange, advancedSolenoid.flange)
          annotation (Line(points={{-10,50},{-20,50}}, color={0,127,0}));
        connect(advancedSource.p, advancedSolenoid.p) annotation (Line(points={{-70,60},{-50,60},{-50,60},{-40,60}},
                                                      color={0,0,255}));
        connect(simpleGround.p, simpleSource.n)
          annotation (Line(points={{-70,-70},{-70,-60}}, color={0,0,255}));
        annotation (experiment(StopTime=10, Tolerance=1e-007), Documentation(
              info="<html>
<p>
Have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator\">SolenoidActuator</a> for general comments and at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid\">SimpleSolenoid</a> and <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.AdvancedSolenoid\">AdvancedSolenoid</a> for a detailed description of both magnetic network models.
</p>

<p>
Similar to static force-stroke measurements on real actuators, the armatures of both actuator models are forced to move slowly here. Hence, the dynamics of the electrical subsystems due to coil inductance and armature motion can be neglected and the static force-stroke characteristics are obtained. To illustrate the accuracy to be expected from the lumped magnetic network models, results obtained with stationary FEA are included as reference (position-dependent force, armature flux and actuator inductance). Note that these reference values are valid for the default supply voltage v_step=12V DC only!
</p>

<p>
Set the <strong>tolerance</strong> to <strong>1e-7</strong> and <strong>simulate for 10 s</strong>. Plot in one common window the electromagnetic force of the two magnetic network models and the FEA reference <strong>vs. armature position x_set.y</strong>:
</p>

<pre>
    simpleSolenoid.armature.flange_a.f     // electromagnetic force of simple magnetic network model
    advancedSolenoid.armature.flange_a.f   // electromagnetic force of advanced magnetic network model
    comparisonWithFEA.y[1]                 // electromagnetic force obtained with FEA as reference
</pre>

<p>
Electromagnetic or reluctance forces always act towards a decrease of air gap lengths. With the defined armature position coordinate x, the forces of the models are negative.
</p>

<p>
The magnetic flux through the armature and the actuator's static inductance both illustrate the differences between the two magnetic network models. Similar to the forces, compare these quantities in one common plot window for each variable (plot vs. armature position x_set.y):
</p>

<pre>
    simpleSolenoid.G_mFeArm.Phi            // magnetic flux through armature of simple magnetic network model
    advancedSolenoid.G_mFeArm.Phi          // magnetic flux through armature of advanced magnetic network model
    comparisonWithFEA.y[2]                 // magnetic flux obtained with FEA as reference

    simpleSolenoid.coil.L_stat             // static inductance of simple magnetic network model
    advancedSolenoid.L_statTot             // series connection of both partial coils of advanced network model
    comparisonWithFEA.y[3]                 // static inductance obtained with FEA as reference
</pre>

<p>
As mentioned in the description of both magnetic network models, one can tell the higher armature flux and inductance of the advanced solenoid model at large air gaps compared to that of the simple model. The effect of this difference on dynamic model behaviour can be analysed in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.ComparisonPullInStroke\">ComparisonPullInStroke</a>.
</p>
</html>"));
      end ComparisonQuasiStationary;

      model ComparisonPullInStroke
        "Pull-in stroke of both solenoid models after a voltage step at time t=0"

        extends Modelica.Icons.Example;

        parameter SI.Voltage v_step=12 "Applied voltage";

        Modelica.Electrical.Analog.Basic.Ground advancedGround annotation (
            Placement(transformation(extent={{-70,-10},{-50,10}})));
        Modelica.Electrical.Analog.Sources.StepVoltage advancedSource(V=v_step)
          annotation (Placement(transformation(
              origin={-60,30},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        FluxTubes.Examples.SolenoidActuator.Components.AdvancedSolenoid advancedSolenoid(x(fixed=
                true)) annotation (Placement(transformation(extent={{-20,20},{0,
                  40}})));
        Modelica.Mechanics.Translational.Components.Mass advancedLoad(m=0.01)
          "Translatory load to be pulled horizontally" annotation (Placement(
              transformation(extent={{20,20},{40,40}})));
        Modelica.Electrical.Analog.Basic.Ground simpleGround annotation (
            Placement(transformation(extent={{-70,-90},{-50,-70}})));
        Modelica.Electrical.Analog.Sources.StepVoltage simpleSource(V=v_step)
          annotation (Placement(transformation(
              origin={-60,-50},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid simpleSolenoid(x(fixed=
                true)) annotation (Placement(transformation(extent={{-20,-60},{0,
                  -40}})));
        Modelica.Mechanics.Translational.Components.Mass simpleLoad(m=0.01)
          "Translatory load to be pulled horizontally" annotation (Placement(
              transformation(extent={{20,-60},{40,-40}})));
        Modelica.Blocks.Sources.CombiTimeTable comparisonWithFEA(
          table=[0, 0, 0, 0.005; 2.61165e-007, 7.93537e-005, -1.97914e-005,
              0.005; 2.61165e-007, 7.93537e-005, -1.97914e-005, 0.005; 0.0001,
              0.0300045, -0.00748335, 0.005; 0.0002, 0.05926, -0.0147799, 0.005;
              0.0003, 0.0877841, -0.021894, 0.00499999; 0.0004, 0.115593, -0.036608,
              0.00499997; 0.0005, 0.142707, -0.0568957, 0.00499994; 0.0006,
              0.169143, -0.076676, 0.00499988; 0.0007, 0.194915, -0.0959614,
              0.0049998; 0.0008, 0.220042, -0.124763, 0.00499968; 0.0009,
              0.244539, -0.155317, 0.00499951; 0.001, 0.26842, -0.185107,
              0.00499928; 0.0011, 0.291701, -0.214153, 0.00499898; 0.0012,
              0.314394, -0.249655, 0.0049986; 0.0013, 0.336514, -0.288306,
              0.00499812; 0.0014, 0.358074, -0.325991, 0.00499754; 0.0015,
              0.379086, -0.362735, 0.00499682; 0.0016, 0.399562, -0.398563,
              0.00499597; 0.0017, 0.419514, -0.44324, 0.00499496; 0.0018,
              0.438955, -0.487015, 0.00499378; 0.0019, 0.457893, -0.529698,
              0.00499242; 0.002, 0.47634, -0.571317, 0.00499085; 0.0021,
              0.494305, -0.611901, 0.00498906; 0.0022, 0.511799, -0.657374,
              0.00498704; 0.0023, 0.528832, -0.704491, 0.00498476; 0.0024,
              0.545412, -0.750434, 0.00498221; 0.0025, 0.561548, -0.795237,
              0.00497937; 0.0026, 0.577248, -0.83893, 0.00497623; 0.0027,
              0.592521, -0.881543, 0.00497277; 0.0028, 0.607375, -0.926803,
              0.00496896; 0.0029, 0.62182, -0.974598, 0.0049648; 0.003, 0.63586,
              -1.02121, 0.00496027; 0.0031, 0.649503, -1.06667, 0.00495534;
              0.0032, 0.662756, -1.11102, 0.00495; 0.0033, 0.675625, -1.15428,
              0.00494424; 0.0034, 0.688119, -1.19648, 0.00493803; 0.0035,
              0.700242, -1.23778, 0.00493136; 0.0036, 0.712005, -1.28391,
              0.00492421; 0.0037, 0.72341, -1.32891, 0.00491657; 0.0038,
              0.734463, -1.3728, 0.00490842; 0.0039, 0.74517, -1.41563,
              0.00489974; 0.004, 0.755536, -1.45743, 0.00489052; 0.0041,
              0.765568, -1.49822, 0.00488074; 0.0042, 0.775269, -1.53803,
              0.00487038; 0.0043, 0.784646, -1.57689, 0.00485943; 0.0044,
              0.793704, -1.61483, 0.00484787; 0.0045, 0.80245, -1.65314,
              0.00483569; 0.0046, 0.810888, -1.69366, 0.00482288; 0.0047,
              0.81902, -1.7332, 0.00480941; 0.0048, 0.826851, -1.77179,
              0.00479528; 0.0049, 0.834387, -1.80945, 0.00478046; 0.005,
              0.841631, -1.84622, 0.00476495; 0.0051, 0.84859, -1.88259,
              0.00474873; 0.0052, 0.855304, -1.92429, 0.00473179; 0.0053,
              0.861739, -1.96564, 0.0047141; 0.0054, 0.8679, -2.00668,
              0.00469566; 0.0055, 0.873791, -2.04743, 0.00467645; 0.0056,
              0.879419, -2.08794, 0.00465645; 0.0057, 0.884782, -2.1282,
              0.00463565; 0.0058, 0.889885, -2.16824, 0.00461403; 0.0059,
              0.894731, -2.20808, 0.00459157; 0.006, 0.899322, -2.24774,
              0.00456827; 0.0061, 0.903661, -2.28927, 0.0045441; 0.0062,
              0.907752, -2.33091, 0.00451905; 0.0063, 0.911603, -2.37014,
              0.0044931; 0.0064, 0.915232, -2.40274, 0.00446624; 0.0065,
              0.91862, -2.43469, 0.00443846; 0.0066, 0.92177, -2.466,
              0.00440974; 0.0067, 0.924686, -2.49668, 0.00438007; 0.0068,
              0.927368, -2.52672, 0.00434945; 0.0069, 0.929822, -2.55615,
              0.00431785; 0.007, 0.93205, -2.58498, 0.00428527; 0.0071,
              0.934052, -2.61318, 0.00425169; 0.0072, 0.935241, -2.64973,
              0.00421711; 0.0073, 0.936164, -2.68643, 0.00418151; 0.0074,
              0.936854, -2.7228, 0.00414488; 0.0075, 0.937309, -2.7588,
              0.0041072; 0.0076, 0.937532, -2.7944, 0.00406845; 0.0077,
              0.937522, -2.82958, 0.00402864; 0.0078, 0.937411, -2.866,
              0.00398773; 0.0079, 0.937385, -2.90613, 0.00394572; 0.008,
              0.937133, -2.94589, 0.0039026; 0.0081, 0.936656, -2.98525,
              0.00385834; 0.0082, 0.935953, -3.02414, 0.00381293; 0.0083,
              0.935024, -3.06251, 0.00376636; 0.0084, 0.934308, -3.10824,
              0.00371862; 0.0085, 0.933608, -3.15783, 0.00366967; 0.0086,
              0.93269, -3.20708, 0.00361952; 0.0087, 0.931553, -3.25592,
              0.00356812; 0.0088, 0.930194, -3.30427, 0.00351548; 0.0089,
              0.928473, -3.35247, 0.00346157; 0.009, 0.926467, -3.40014,
              0.00340636; 0.0091, 0.924232, -3.44698, 0.00334985; 0.0092,
              0.921766, -3.49289, 0.00329202; 0.0093, 0.918579, -3.53879,
              0.00323283; 0.0094, 0.913925, -3.5856, 0.00317229; 0.0095,
              0.909004, -3.63034, 0.00311037; 0.0096, 0.903809, -3.67275,
              0.00304706; 0.0097, 0.89859, -3.72881, 0.00298233; 0.0098,
              0.893783, -3.82589, 0.00291616; 0.0099, 0.888707, -3.92096,
              0.00284852; 0.01, 0.883343, -4.01357, 0.00277938; 0.0101,
              0.876979, -4.10734, 0.00270869; 0.0102, 0.869783, -4.19987,
              0.00263642; 0.0103, 0.862246, -4.28752, 0.00256254; 0.0104,
              0.854574, -4.37627, 0.00248701; 0.0105, 0.847614, -4.49154,
              0.00240979; 0.0106, 0.840302, -4.60102, 0.00233085; 0.0107,
              0.832625, -4.70399, 0.00225014; 0.0108, 0.822938, -4.82647,
              0.00216761; 0.0109, 0.812813, -4.93752, 0.00208323; 0.011,
              0.802204, -5.04175, 0.00199695; 0.0111, 0.78997, -5.30274,
              0.00190873; 0.0112, 0.777197, -5.54515, 0.00181846; 0.0113,
              0.763521, -5.78149, 0.00172606; 0.0114, 0.748272, -6.039,
              0.00163144; 0.0115, 0.73235, -6.25778, 0.0015345; 0.0116,
              0.715211, -6.57852, 0.00143514; 0.0117, 0.696998, -6.91971,
              0.00133326; 0.0118, 0.677065, -7.30735, 0.00122872; 0.0119,
              0.652791, -7.88085, 0.00112136; 0.012, 0.62734, -8.29718,
              0.00101097; 0.0121, 0.597125, -9.13179, 0.000897364; 0.0122,
              0.564919, -9.82427, 0.000780251; 0.0123, 0.527838, -11.1684,
              0.000659331; 0.0124, 0.487477, -12.1609, 0.000534142; 0.0125,
              0.436631, -14.9103, 0.000404205; 0.0126, 0.379243, -16.2449,
              0.000268616; 0.0126134, 0.371242, -16.2777, 0.00025; 0.0126134,
              0.371242, -16.2777, 0.00025; 0.0126868, 0.350822, -16.2554,
              0.000198624; 0.0126868, 0.350822, -16.2554, 0.000198624; 0.0127,
              0.351869, -16.3218, 0.000199455; 0.0128, 0.37695, -17.0338,
              0.000241587; 0.0128157, 0.381787, -17.1198, 0.00025; 0.0128157,
              0.381787, -17.1198, 0.00025; 0.0129, 0.406591, -17.48,
              0.000292352; 0.013, 0.433421, -17.8191, 0.000336402; 0.0131,
              0.457261, -17.8337, 0.000373609; 0.0132, 0.477911, -17.6706,
              0.000403962; 0.0133, 0.495294, -17.4605, 0.00042752; 0.0134,
              0.509353, -17.3988, 0.000444358; 0.0135, 0.520015, -17.4878,
              0.0004545; 0.0136, 0.527192, -17.7433, 0.000457911; 0.0136003,
              0.527207, -17.7443, 0.000457911; 0.0136003, 0.527207, -17.7443,
              0.000457911; 0.0137, 0.530748, -18.1997, 0.000454491; 0.0138,
              0.530517, -18.8646, 0.000444064; 0.0139, 0.526294, -19.7142,
              0.000426376; 0.014, 0.517828, -20.6871, 0.000401101; 0.0141,
              0.504836, -21.6765, 0.000367869; 0.0142, 0.487037, -22.6627,
              0.000326301; 0.0143, 0.464073, -23.4017, 0.000276025; 0.0143458,
              0.451744, -23.5657, 0.00025; 0.0143458, 0.451744, -23.5657,
              0.00025; 0.0144, 0.439383, -23.6302, 0.000223375; 0.0144518,
              0.438001, -23.8106, 0.00021654; 0.0144518, 0.438001, -23.8106,
              0.00021654; 0.0145, 0.442437, -24.0882, 0.000220288; 0.0146,
              0.459291, -24.7355, 0.000241352; 0.014643, 0.466338, -24.9736,
              0.00025; 0.014643, 0.466338, -24.9736, 0.00025; 0.0147, 0.47417,
              -25.2545, 0.000258795; 0.0148, 0.483493, -25.7045, 0.000266567;
              0.0148288, 0.485111, -25.8323, 0.00026698; 0.0148288, 0.485111, -25.8323,
              0.00026698; 0.0149, 0.486998, -26.1506, 0.000264454; 0.015,
              0.484444, -26.5924, 0.000252282; 0.0150127, 0.483671, -26.6456,
              0.00025; 0.0150127, 0.483671, -26.6456, 0.00025; 0.0151, 0.477935,
              -26.9803, 0.000233764; 0.0151954, 0.478678, -27.3825, 0.000227777;
              0.0151954, 0.478678, -27.3825, 0.000227777; 0.0152, 0.478896, -27.404,
              0.000227786; 0.0153, 0.486112, -27.9096, 0.000231723; 0.0154,
              0.494618, -28.4114, 0.000237745; 0.0154716, 0.499054, -28.7526,
              0.000239402; 0.0154716, 0.499054, -28.7526, 0.000239402; 0.0155,
              0.500242, -28.8872, 0.000239151; 0.0156, 0.502893, -29.3755,
              0.000235871; 0.0157, 0.505639, -29.8643, 0.000232816; 0.0158,
              0.509736, -30.3772, 0.000231912; 0.0158118, 0.51029, -30.4396,
              0.000231905; 0.0158118, 0.51029, -30.4396, 0.000231905; 0.0159,
              0.514622, -30.9065, 0.000232198; 0.016, 0.519654, -31.4343,
              0.000232755; 0.016048, 0.521947, -31.6846, 0.000232849; 0.016048,
              0.521947, -31.6846, 0.000232849; 0.0161, 0.524291, -31.9527,
              0.000232753; 0.0162, 0.528618, -32.4638, 0.000232328; 0.0163,
              0.53296, -32.9726, 0.000231976; 0.0164, 0.537374, -33.4793,
              0.000231787; 0.0165, 0.541801, -33.9827, 0.000231672; 0.0166,
              0.546199, -34.4828, 0.000231561; 0.0167, 0.550555, -34.9795,
              0.000231435; 0.0168, 0.554875, -35.4729, 0.0002313; 0.0169,
              0.559164, -35.9631, 0.000231166; 0.017, 0.56344, -36.4518,
              0.000231035; 0.0171, 0.567726, -36.9417, 0.000230906; 0.0172,
              0.571982, -37.4284, 0.000230779; 0.0173, 0.576209, -37.9119,
              0.000230653; 0.0174, 0.580407, -38.3923, 0.000230528; 0.0175,
              0.584575, -38.8695, 0.000230405; 0.0176, 0.588716, -39.3436,
              0.000230284; 0.0177, 0.593137, -39.8493, 0.000230163; 0.0178,
              0.59757, -40.357, 0.000230038; 0.0179, 0.601967, -40.8716,
              0.000229911; 0.018, 0.60633, -41.3953, 0.000229783; 0.0181,
              0.610659, -41.9153, 0.000229654; 0.0182, 0.614955, -42.4317,
              0.000229526; 0.0183, 0.619218, -42.9441, 0.0002294; 0.0184,
              0.623441, -43.452, 0.000229276; 0.0185, 0.627634, -43.9562,
              0.000229154; 0.0186, 0.631795, -44.4569, 0.000229034; 0.0187,
              0.635926, -44.954, 0.000228915; 0.0188, 0.640026, -45.4476,
              0.000228797; 0.0189, 0.644096, -45.9377, 0.000228681; 0.019,
              0.648136, -46.4242, 0.000228566; 0.0191, 0.652146, -46.9074,
              0.000228453; 0.0192, 0.656126, -47.387, 0.000228341; 0.0193,
              0.660077, -47.8633, 0.000228231; 0.0194, 0.663999, -48.3362,
              0.000228122; 0.0195, 0.667892, -48.8057, 0.000228014; 0.0196,
              0.671756, -49.2718, 0.000227908; 0.0197, 0.675592, -49.7347,
              0.000227802; 0.0198, 0.67979, -50.2404, 0.000227697; 0.0199,
              0.684118, -50.7623, 0.000227586; 0.02, 0.688404, -51.2799,
              0.000227471; 0.0201, 0.692654, -51.7933, 0.000227355; 0.0202,
              0.696868, -52.3025, 0.000227241; 0.0203, 0.701047, -52.8002,
              0.00022713; 0.0204, 0.705193, -53.2717, 0.000227022; 0.0205,
              0.709307, -53.7394, 0.000226918; 0.0206, 0.713479, -54.2135,
              0.000226817; 0.0207, 0.717635, -54.686, 0.000226716; 0.0208,
              0.721755, -55.1544, 0.000226615; 0.0209, 0.725839, -55.619,
              0.000226515; 0.021, 0.729888, -56.0796, 0.000226416; 0.0211,
              0.733903, -56.5364, 0.000226319; 0.0212, 0.737883, -56.9893,
              0.000226222; 0.0213, 0.741829, -57.4383, 0.000226127; 0.0214,
              0.745732, -57.8827, 0.000226033; 0.0215, 0.749587, -58.3217,
              0.000225941; 0.0216, 0.75341, -58.7569, 0.00022585; 0.0217,
              0.757199, -59.1885, 0.00022576; 0.0218, 0.760956, -59.6164,
              0.000225671; 0.0219, 0.764681, -60.0407, 0.000225583; 0.022,
              0.768373, -60.4614, 0.000225497; 0.0221, 0.772034, -60.8786,
              0.000225411; 0.0222, 0.775663, -61.2922, 0.000225326; 0.0223,
              0.779579, -61.7378, 0.000225242; 0.0224, 0.784355, -62.2802,
              0.000225151; 0.0225, 0.789065, -62.8168, 0.000225046; 0.0226,
              0.793716, -63.3474, 0.000224938; 0.0227, 0.798315, -63.8721,
              0.000224831; 0.0228, 0.802863, -64.3256, 0.000224728; 0.0229,
              0.80737, -64.7356, 0.000224637; 0.023, 0.811833, -65.1406,
              0.000224555; 0.0231, 0.816247, -65.541, 0.000224477; 0.0232,
              0.820611, -65.9369, 0.000224399; 0.0233, 0.824909, -66.3269,
              0.000224322; 0.0234, 0.829106, -66.7079, 0.000224246; 0.0235,
              0.833258, -67.0845, 0.000224172; 0.0236, 0.837362, -67.457,
              0.000224099; 0.0237, 0.84142, -67.8252, 0.000224027; 0.0238,
              0.845433, -68.1893, 0.000223957; 0.0239, 0.8494, -68.5494,
              0.000223887; 0.024, 0.853323, -68.9053, 0.000223818; 0.0241,
              0.857201, -69.2573, 0.00022375; 0.0242, 0.861036, -69.6053,
              0.000223683; 0.0243, 0.864828, -69.9494, 0.000223617; 0.0244,
              0.868577, -70.2896, 0.000223552; 0.0245, 0.873541, -70.7381,
              0.000223484; 0.0246, 0.878506, -71.1879, 0.000223404; 0.0247,
              0.883389, -71.6312, 0.00022332; 0.0248, 0.888198, -72.0678,
              0.000223236; 0.0249, 0.892935, -72.4978, 0.000223154; 0.025,
              0.8976, -72.9212, 0.000223074; 0.0251, 0.902194, -73.2832,
              0.000222997; 0.0252, 0.906729, -73.5797, 0.00022293; 0.0253,
              0.911203, -73.8711, 0.000222873; 0.0254, 0.915611, -74.1579,
              0.00022282; 0.0255, 0.919953, -74.4404, 0.000222768; 0.0256,
              0.924227, -74.7185, 0.000222716; 0.0257, 0.928436, -74.9923,
              0.000222665; 0.0258, 0.932872, -75.2805, 0.000222615; 0.0259,
              0.937419, -75.5759, 0.000222563; 0.026, 0.941886, -75.8664,
              0.000222509; 0.0261, 0.946276, -76.1519, 0.000222456; 0.0262,
              0.950592, -76.4326, 0.000222404; 0.0263, 0.954834, -76.7084,
              0.000222354; 0.0264, 0.959005, -76.9795, 0.000222304; 0.0265,
              0.963104, -77.246, 0.000222255; 0.0266, 0.967134, -77.5079,
              0.000222207; 0.0267, 0.971094, -77.7654, 0.00022216; 0.0268,
              0.974988, -78.0184, 0.000222114; 0.0269, 0.978815, -78.2671,
              0.000222068; 0.027, 0.982577, -78.5115, 0.000222024; 0.0271,
              0.986275, -78.7518, 0.00022198; 0.0272, 0.98991, -78.9879,
              0.000221937; 0.0273, 0.993484, -79.2201, 0.000221895; 0.0274,
              0.996996, -79.4482, 0.000221854; 0.0275, 1.00082, -79.6845,
              0.000221813; 0.0276, 1.00486, -79.8903, 0.000221773; 0.0277,
              1.00883, -80.0919, 0.000221735; 0.0278, 1.01272, -80.2892,
              0.000221699; 0.0279, 1.01653, -80.4824, 0.000221665; 0.028,
              1.02026, -80.6717, 0.000221631; 0.0281, 1.02392, -80.8572,
              0.000221597; 0.0282, 1.0275, -81.0389, 0.000221565; 0.0283,
              1.03101, -81.2168, 0.000221533; 0.0284, 1.03445, -81.3911,
              0.000221501; 0.0285, 1.03781, -81.5619, 0.000221471; 0.0286,
              1.04111, -81.7292, 0.000221441; 0.0287, 1.04434, -81.893,
              0.000221412; 0.0288, 1.04751, -82.0535, 0.000221383; 0.0289,
              1.05061, -82.2107, 0.000221355; 0.029, 1.05365, -82.3647,
              0.000221328; 0.0291, 1.05663, -82.5155, 0.000221301; 0.0292,
              1.05954, -82.6633, 0.000221275; 0.0293, 1.0624, -82.808,
              0.000221249; 0.0294, 1.0652, -82.9498, 0.000221224; 0.0295,
              1.06794, -83.0887, 0.000221199; 0.0296, 1.07063, -83.2248,
              0.000221175; 0.0297, 1.07326, -83.3581, 0.000221151; 0.0298,
              1.07584, -83.4886, 0.000221128; 0.0299, 1.07836, -83.6165,
              0.000221106; 0.03, 1.08088, -83.7439, 0.000221083; 0.0301,
              1.08376, -83.8895, 0.000221061; 0.0302, 1.08657, -84.0316,
              0.000221037; 0.0303, 1.08931, -84.1703, 0.000221012; 0.0304,
              1.09198, -84.3057, 0.000220988; 0.0305, 1.09459, -84.4378,
              0.000220965; 0.0306, 1.09714, -84.5667, 0.000220942; 0.0307,
              1.09962, -84.6924, 0.00022092; 0.0308, 1.10205, -84.7987,
              0.000220899; 0.0309, 1.10442, -84.8994, 0.00022088; 0.031,
              1.10673, -84.9975, 0.000220862; 0.0311, 1.10898, -85.0932,
              0.000220846; 0.0312, 1.11119, -85.1866, 0.000220829; 0.0313,
              1.11333, -85.2778, 0.000220813; 0.0314, 1.11543, -85.3668,
              0.000220798; 0.0315, 1.11748, -85.4536, 0.000220782; 0.0316,
              1.11947, -85.5382, 0.000220768; 0.0317, 1.12142, -85.6209,
              0.000220753; 0.0318, 1.12332, -85.7015, 0.000220739; 0.0319,
              1.12518, -85.7802, 0.000220725; 0.032, 1.12699, -85.857,
              0.000220712; 0.0321, 1.12875, -85.9319, 0.000220699; 0.0322,
              1.13048, -86.005, 0.000220686; 0.0323, 1.13216, -86.0763,
              0.000220673; 0.0324, 1.1338, -86.1459, 0.000220661; 0.0325,
              1.1354, -86.2138, 0.000220649; 0.0326, 1.13696, -86.28,
              0.000220638; 0.0327, 1.13849, -86.3447, 0.000220627; 0.0328,
              1.13997, -86.4078, 0.000220616; 0.0329, 1.14143, -86.4693,
              0.000220605; 0.033, 1.14284, -86.5294, 0.000220594; 0.0331,
              1.14423, -86.588, 0.000220584; 0.0332, 1.14558, -86.6452,
              0.000220574; 0.0333, 1.14689, -86.701, 0.000220564; 0.0334,
              1.14818, -86.7555, 0.000220555; 0.0335, 1.14943, -86.8086,
              0.000220546; 0.0336, 1.15065, -86.8605, 0.000220537; 0.0337,
              1.15185, -86.9111, 0.000220528; 0.0338, 1.15301, -86.9605,
              0.000220519; 0.0339, 1.15415, -87.0086, 0.000220511; 0.034,
              1.15526, -87.0556, 0.000220503; 0.0341, 1.15634, -87.1015,
              0.000220495; 0.0342, 1.1574, -87.1463, 0.000220487; 0.0343,
              1.15843, -87.19, 0.000220479; 0.0344, 1.15943, -87.2326,
              0.000220472; 0.0345, 1.16041, -87.2742, 0.000220465; 0.0346,
              1.16137, -87.3148, 0.000220458; 0.0347, 1.16231, -87.3544,
              0.000220451; 0.0348, 1.16322, -87.3931, 0.000220444; 0.0349,
              1.16411, -87.4308, 0.000220438; 0.035, 1.16498, -87.4676,
              0.000220431; 0.0351, 1.16582, -87.5035, 0.000220425; 0.0352,
              1.16665, -87.5385, 0.000220419; 0.0353, 1.16746, -87.5727,
              0.000220413; 0.0354, 1.16824, -87.6061, 0.000220407; 0.0355,
              1.16901, -87.6386, 0.000220402; 0.0356, 1.16976, -87.6704,
              0.000220396; 0.0357, 1.17049, -87.7014, 0.000220391; 0.0358,
              1.17121, -87.7316, 0.000220386; 0.0359, 1.1719, -87.7612,
              0.00022038; 0.036, 1.17258, -87.79, 0.000220375; 0.0361, 1.17325,
              -87.8181, 0.000220371; 0.0362, 1.1739, -87.8455, 0.000220366;
              0.0363, 1.17453, -87.8722, 0.000220361; 0.0364, 1.17514, -87.8984,
              0.000220357; 0.0365, 1.17574, -87.9238, 0.000220352; 0.0366,
              1.17633, -87.9487, 0.000220348; 0.0367, 1.1769, -87.9729,
              0.000220344; 0.0368, 1.17746, -87.9966, 0.00022034; 0.0369,
              1.17801, -88.0197, 0.000220336; 0.037, 1.17858, -88.0441,
              0.000220332; 0.0371, 1.17922, -88.0712, 0.000220328; 0.0372,
              1.17985, -88.0975, 0.000220323; 0.0373, 1.18045, -88.123,
              0.000220319; 0.0374, 1.18103, -88.1477, 0.000220314; 0.0375,
              1.1816, -88.1717, 0.00022031; 0.0376, 1.18215, -88.195,
              0.000220306; 0.0377, 1.18268, -88.2176, 0.000220302; 0.0378,
              1.1832, -88.2395, 0.000220299; 0.0379, 1.1837, -88.2607,
              0.000220295; 0.038, 1.18419, -88.2814, 0.000220291; 0.0381,
              1.18466, -88.3014, 0.000220288; 0.0382, 1.18512, -88.3208,
              0.000220284; 0.0383, 1.18556, -88.3396, 0.000220281; 0.0384,
              1.18599, -88.3578, 0.000220278; 0.0385, 1.18641, -88.3756,
              0.000220275; 0.0386, 1.18682, -88.3928, 0.000220272; 0.0387,
              1.18721, -88.4094, 0.000220269; 0.0388, 1.18759, -88.4256,
              0.000220266; 0.0389, 1.18796, -88.4413, 0.000220264; 0.039,
              1.18832, -88.4565, 0.000220261; 0.0391, 1.18867, -88.4713,
              0.000220258; 0.0392, 1.18901, -88.4856, 0.000220256; 0.0393,
              1.18934, -88.4995, 0.000220253; 0.0394, 1.18965, -88.513,
              0.000220251; 0.0395, 1.18996, -88.5261, 0.000220249; 0.0396,
              1.19026, -88.5388, 0.000220247; 0.0397, 1.19055, -88.5511,
              0.000220245; 0.0398, 1.19084, -88.563, 0.000220242; 0.0399,
              1.19111, -88.5746, 0.00022024; 0.04, 1.19137, -88.5859,
              0.000220239; 0.0401, 1.19163, -88.5968, 0.000220237; 0.0402,
              1.19188, -88.6074, 0.000220235; 0.0403, 1.19212, -88.6176,
              0.000220233; 0.0404, 1.19236, -88.6276, 0.000220231; 0.0405,
              1.19259, -88.6373, 0.00022023; 0.0406, 1.19281, -88.6466,
              0.000220228; 0.0407, 1.19302, -88.6557, 0.000220226; 0.0408,
              1.19323, -88.6646, 0.000220225; 0.0409, 1.19343, -88.6731,
              0.000220223; 0.041, 1.19363, -88.6814, 0.000220222; 0.0411,
              1.19382, -88.6895, 0.000220221; 0.0412, 1.19401, -88.6973,
              0.000220219; 0.0413, 1.19418, -88.7049, 0.000220218; 0.0414,
              1.19436, -88.7122, 0.000220217; 0.0415, 1.19453, -88.7194,
              0.000220215; 0.0416, 1.19469, -88.7263, 0.000220214; 0.0417,
              1.19485, -88.733, 0.000220213; 0.0418, 1.195, -88.7395,
              0.000220212; 0.0419, 1.19515, -88.7459, 0.000220211; 0.042,
              1.1953, -88.752, 0.00022021; 0.0421, 1.19544, -88.7579,
              0.000220209; 0.0422, 1.19557, -88.7637, 0.000220208; 0.0423,
              1.19571, -88.7693, 0.000220207; 0.0424, 1.19583, -88.7747,
              0.000220206; 0.0425, 1.19596, -88.78, 0.000220205; 0.0426,
              1.19608, -88.7851, 0.000220204; 0.0427, 1.1962, -88.7901,
              0.000220203; 0.0428, 1.19631, -88.7949, 0.000220202; 0.0429,
              1.19642, -88.7996, 0.000220202; 0.043, 1.19653, -88.8041,
              0.000220201; 0.0431, 1.19663, -88.8085, 0.0002202; 0.0432,
              1.19673, -88.8127, 0.000220199; 0.0433, 1.19683, -88.8169,
              0.000220199; 0.0434, 1.19692, -88.8209, 0.000220198; 0.0435,
              1.19702, -88.8248, 0.000220197; 0.0436, 1.1971, -88.8286,
              0.000220197; 0.0437, 1.19719, -88.8322, 0.000220196; 0.0438,
              1.19728, -88.8358, 0.000220195; 0.0439, 1.19736, -88.8392,
              0.000220195; 0.044, 1.19744, -88.8426, 0.000220194; 0.0441,
              1.19751, -88.8458, 0.000220194; 0.0442, 1.19759, -88.8489,
              0.000220193; 0.0443, 1.19766, -88.852, 0.000220192; 0.0444,
              1.19773, -88.855, 0.000220192; 0.0445, 1.1978, -88.8578,
              0.000220191; 0.0446, 1.19786, -88.8606, 0.000220191; 0.0447,
              1.19793, -88.8633, 0.000220191; 0.0448, 1.19799, -88.8659,
              0.00022019; 0.0449, 1.19805, -88.8685, 0.00022019; 0.045, 1.19811,
              -88.871, 0.000220189; 0.0451, 1.19816, -88.8734, 0.000220189;
              0.0452, 1.19822, -88.8757, 0.000220188; 0.0453, 1.19827, -88.8779,
              0.000220188; 0.0454, 1.19832, -88.8801, 0.000220188; 0.0455,
              1.19837, -88.8822, 0.000220187; 0.0456, 1.19842, -88.8843,
              0.000220187; 0.0457, 1.19847, -88.8863, 0.000220187; 0.0458,
              1.19851, -88.8882, 0.000220186; 0.0459, 1.19856, -88.8901,
              0.000220186; 0.046, 1.1986, -88.8919, 0.000220186; 0.0461,
              1.19864, -88.8937, 0.000220185; 0.0462, 1.19868, -88.8954,
              0.000220185; 0.0463, 1.19872, -88.897, 0.000220185; 0.0464,
              1.19876, -88.8987, 0.000220184; 0.0465, 1.1988, -88.9002,
              0.000220184; 0.0466, 1.19883, -88.9017, 0.000220184; 0.0467,
              1.19887, -88.9032, 0.000220184; 0.0468, 1.1989, -88.9046,
              0.000220183; 0.0469, 1.19893, -88.906, 0.000220183; 0.047,
              1.19897, -88.9074, 0.000220183; 0.0471, 1.199, -88.9087,
              0.000220183; 0.0472, 1.19903, -88.91, 0.000220182; 0.0473,
              1.19906, -88.9112, 0.000220182; 0.0474, 1.19908, -88.9124,
              0.000220182; 0.0475, 1.19911, -88.9135, 0.000220182; 0.0476,
              1.19914, -88.9146, 0.000220182; 0.0477, 1.19916, -88.9157,
              0.000220181; 0.0478, 1.19919, -88.9168, 0.000220181; 0.0479,
              1.19921, -88.9178, 0.000220181; 0.048, 1.19924, -88.9188,
              0.000220181; 0.0481, 1.19926, -88.9198, 0.000220181; 0.0482,
              1.19928, -88.9207, 0.000220181; 0.0483, 1.1993, -88.9216,
              0.00022018; 0.0484, 1.19932, -88.9225, 0.00022018; 0.0485,
              1.19934, -88.9233, 0.00022018; 0.0486, 1.19936, -88.9242,
              0.00022018; 0.0487, 1.19938, -88.925, 0.00022018; 0.0488, 1.1994,
              -88.9258, 0.00022018; 0.0489, 1.19942, -88.9265, 0.00022018;
              0.049, 1.19944, -88.9273, 0.000220179; 0.0491, 1.19945, -88.928,
              0.000220179; 0.0492, 1.19947, -88.9287, 0.000220179; 0.0493,
              1.19948, -88.9293, 0.000220179; 0.0494, 1.1995, -88.93,
              0.000220179; 0.0495, 1.19951, -88.9306, 0.000220179; 0.0496,
              1.19953, -88.9312, 0.000220179; 0.0497, 1.19954, -88.9318,
              0.000220179; 0.0498, 1.19956, -88.9324, 0.000220179; 0.0499,
              1.19957, -88.933, 0.000220178; 0.05, 1.19958, -88.9335,
              0.000220178; 0.05, 1.19958, -88.9335, 0.000220178],
          tableOnFile=false,
          columns=2:4,
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
          "Valid for u_source=12VDC and m_load=0.01kg only; column 2: current, col.3: force, col.4: position"
          annotation (Placement(transformation(extent={{-40,60},{-20,80}})));

      equation
        connect(advancedGround.p, advancedSource.n)
          annotation (Line(points={{-60,10},{-60,20}}, color={0,0,255}));
        connect(advancedSource.p, advancedSolenoid.p) annotation (Line(points={{-60,40},{-40,40},{-40,40},{-20,40}},
                                                      color={0,0,255}));
        connect(advancedSolenoid.n, advancedSource.n) annotation (Line(points={{-20,20},{-40,20},{-40,20},{-60,20}},
                                                      color={0,0,255}));
        connect(advancedSolenoid.flange, advancedLoad.flange_a)
          annotation (Line(points={{0,30},{20,30}}, color={0,127,0}));
        connect(simpleGround.p, simpleSource.n)
          annotation (Line(points={{-60,-70},{-60,-60}}, color={0,0,255}));
        connect(simpleSource.p, simpleSolenoid.p) annotation (Line(points={{-60,-40},{-40,-40},{-40,-40},{-20,-40}},
                                                     color={0,0,255}));
        connect(simpleSolenoid.n, simpleSource.n) annotation (Line(points={{-20,-60},{-40,-60},{-40,-60},{-60,-60}},
                                                     color={0,0,255}));
        connect(simpleSolenoid.flange, simpleLoad.flange_a)
          annotation (Line(points={{0,-50},{20,-50}}, color={0,127,0}));
        annotation (experiment(StopTime=0.05, Tolerance=1e-007), Documentation(
              info="<html>
<p>
Have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator\">SolenoidActuator</a> for general comments and at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid\">SimpleSolenoid</a> and <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.AdvancedSolenoid\">AdvancedSolenoid</a> for a detailed description of both magnetic network models.
</p>

<p>
A voltage step is applied to both solenoid models at time t=0. The armatures of both models and therewith connected loads are pulled from their rest position at maximum air gap length to their minimum position that is due to a stopper. As a reference, simulation results obtained with a dynamic model based on stationary FEA look-up tables (not part of this library) are included. Note that these reference results are valid for the default supply voltage v_step=12V DC and the default load mass m_load=0.01kg only!
</p>

<p>
Set the <strong>tolerance</strong> to <strong>1e-7</strong> and <strong>simulate for 0.05 s</strong>. Plot actuator current, force and position of the two magnetic network models and the FEA-based reference <strong>vs. time</strong> (each quantity in one common plot window):
</p>

<pre>
Plot window for current:
    simpleSolenoid.p.i          // rapid current rise indicates low inductance of simple network model
    advancedSolenoid.p.i        // current rise slower, better match with FEA reference
    comparisonWithFEA.y[1]      // current obtained from dynamic model based on stationary FEA look-up tables

Plot window for force:
    simpleSolenoid.armature.flange_a.f       // reluctance force of simple actuator model
    advancedSolenoid.armature.flange_a.f     // reluctance force of advanced actuator model
    comparisonWithFEA.y[2]      // force obtained from dynamic model based on stationary FEA look-up tables

Plot window for position:
    simpleSolenoid.x            // armature position of simple actuator model
    advancedSolenoid.x          // armature position of advanced actuator model
    comparisonWithFEA.y[3]      // position obtained from dynamic model based on stationary FEA look-up tables
</pre>

<p>
The characteristic current drop during pull-in is due to both armature motion and increasing inductance with decreasing air gap length. Bouncing occurs when  armature and load of each model arrive at the stopper at minimum position. Although the pull-in times of the two magnetic network models are relatively close to the time obtained with the reference model, the accuracy of the advanced solenoid model is better, as one can tell from a comparison of the current rise at the beginning of the stroke.
</p>
</html>"));
      end ComparisonPullInStroke;

      package Components "Components to be used in examples"
        extends Modelica.Icons.Package;

        model SimpleSolenoid
          "Simple network model of a lifting magnet with planar armature end face"

          parameter SI.Resistance R=10 "Armature coil resistance";
          parameter Real N=957 "Number of turns";

          //yoke
          parameter SI.Radius r_yokeOut=15e-3 "Outer yoke radius" annotation (
              Dialog(group="Parameters", groupImage=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/SolenoidActuator/Solenoid_dimensions.png"));
          parameter SI.Radius r_yokeIn=13.5e-3 "Inner yoke radius";
          parameter SI.Length l_yoke=35e-3 "Axial yoke length";
          parameter SI.Length t_yokeBot=3.5e-3 "Axial thickness of yoke bottom";

          //pole
          parameter SI.Length l_pole=6.5e-3 "Axial length of pole";
          parameter SI.Length t_poleBot=3.5e-3
            "Axial thickness of bottom at pole side";

          parameter SI.Length t_airPar=0.65e-3
            "Radial thickness of parasitic air gap due to slide guiding";

          parameter FluxTubes.Material.SoftMagnetic.BaseData material=
              Material.SoftMagnetic.Steel.Steel_9SMnPb28()
            "Ferromagnetic material characteristics"
            annotation (choicesAllMatching=true, Dialog(group="Material"));

          //armature
          parameter SI.Radius r_arm=5e-3 "Armature radius = pole radius"
            annotation (Dialog(group="Armature and stopper"));
          parameter SI.Length l_arm=26e-3 "Armature length"
            annotation (Dialog(group="Armature and stopper"));
          parameter Modelica.SIunits.TranslationalSpringConstant c=1e11
            "Spring stiffness between impact partners"
            annotation (Dialog(group="Armature and stopper"));
          parameter Modelica.SIunits.TranslationalDampingConstant d=400
            "Damping coefficient between impact partners"
            annotation (Dialog(group="Armature and stopper"));
          parameter SI.Position x_min=0.25e-3
            "Stopper at minimum armature position"
            annotation (Dialog(group="Armature and stopper"));
          parameter SI.Position x_max=5e-3
            "Stopper at maximum armature position"
            annotation (Dialog(group="Armature and stopper"));

          SI.Position x(start=x_max, stateSelect=StateSelect.prefer)
            "Armature position, alias for flange position (identical with length of working air gap)";

        protected
          parameter SI.Density rho_steel=7853
            "Density for calculation of armature mass from geometry";

        public
          FluxTubes.Basic.Ground ground annotation (Placement(transformation(
                  extent={{50,10},{70,30}})));
          FluxTubes.Basic.ElectroMagneticConverter coil(final N=N, i(fixed=true))
            "Electro-magnetic converter" annotation (Placement(transformation(
                origin={0,20},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Resistor r(final R=R)
            "Coil resistance" annotation (Placement(transformation(extent={{-70,
                    -30},{-50,-10}})));
          FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFeYokeSide(
            final nonLinearPermeability=true,
            final material=material,
            final l=l_yoke - (t_poleBot + t_yokeBot)/2,
            final r_i=r_yokeIn,
            final r_o=r_yokeOut)
            "Permeance of hollow cylindric section of ferromagnetic yoke"
            annotation (Placement(transformation(extent={{-10,80},{10,100}})));

          FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFeArm(
            final nonLinearPermeability=true,
            final material=material,
            final l=l_yoke - (t_yokeBot + t_poleBot)/2 - l_pole - (x_max +
                x_min)/2,
            final r_i=0,
            final r_o=r_arm) "Permeance of ferromagnetic armature" annotation (
              Placement(transformation(
                origin={16,40},
                extent={{-10,-10},{10,10}},
                rotation=180)));

          FluxTubes.Shapes.Force.HollowCylinderAxialFlux g_mAirWork(
            final mu_r=1,
            final dlBydx=1,
            final r_i=0,
            final r_o=r_arm,
            final useSupport=false,
            final l=flange.s)
            "Permeance of working air gap (between armature and pole end faces)"
            annotation (Placement(transformation(
                origin={-30,30},
                extent={{-10,10},{10,-10}},
                rotation=180)));
          FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux g_mFeYokeBot(
            final nonLinearPermeability=true,
            final material=material,
            final l=t_yokeBot,
            final r_i=r_arm + t_airPar,
            final r_o=r_yokeIn)
            "Permeance of bottom side of ferromagnetic yoke" annotation (
              Placement(transformation(
                origin={80,80},
                extent={{-10,-10},{10,10}},
                rotation=90)));

          FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux g_mAirPar(
            final nonLinearPermeability=false,
            final mu_rConst=1,
            final l=t_yokeBot,
            final r_i=r_arm,
            final r_o=r_arm + t_airPar)
            "Permeance of parasitic radial air gap due to slide guiding"
            annotation (Placement(transformation(
                origin={80,50},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux g_mFePoleBot(
            final l=t_poleBot,
            final r_i=r_arm,
            final r_o=r_yokeIn,
            final nonLinearPermeability=true,
            final material=material) "Permeance of bottom side of pole"
            annotation (Placement(transformation(
                origin={-72,80},
                extent={{-10,-10},{10,10}},
                rotation=90)));

          FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFePole(
            final nonLinearPermeability=true,
            final material=material,
            final l=l_pole,
            final r_i=0,
            final r_o=r_arm) "Permeance of ferromagnetic pole" annotation (
              Placement(transformation(
                origin={-72,40},
                extent={{10,-10},{-10,10}},
                rotation=270)));

          FluxTubes.Examples.Utilities.TranslatoryArmatureAndStopper armature(
            final m=rho_steel*l_arm*pi*r_arm^2,
            final x_max=x_max,
            final x_min=x_min,
            final L=0,
            final c=c,
            final d=d,
            n=2,
            v(fixed=true))
            "Inertia of armature and stoppers at end of stroke range"
            annotation (Placement(transformation(extent={{64,-10},{84,10}})));
          FluxTubes.Shapes.Leakage.QuarterCylinder g_mLeak1(l=2*pi*(r_arm +
                t_airPar/2))
            "Leakage permeance between inner edge of yoke bore and armature side face"
            annotation (Placement(transformation(
                origin={60,50},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          FluxTubes.Shapes.Leakage.QuarterHollowCylinder g_mLeak2(final l=2*pi*
                r_arm, final ratio=8)
            "Leakage permeance between inner side of yoke bottom and armature side (r_i = t_airPar)"
            annotation (Placement(transformation(
                origin={40,50},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          FluxTubes.Shapes.Force.LeakageAroundPoles g_mLeakWork(
            final mu_r=1,
            final dlBydx=1,
            final w=2*pi*(r_arm + 0.0015),
            final r=0.003,
            final l=flange.s,
            final useSupport=false)
            "Permeance of leakage air gap around working air gap (between armature and pole side faces)"
            annotation (Placement(transformation(
                origin={-30,70},
                extent={{-10,10},{10,-10}},
                rotation=180)));
          Modelica.Electrical.Analog.Interfaces.PositivePin p
            "Electrical connector" annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin n
            "Electrical connector" annotation (Placement(transformation(extent={{-90,-110},{-110,-90}})));
          Modelica.Mechanics.Translational.Interfaces.Flange_b flange
            "Flange of component" annotation (Placement(transformation(extent={
                    {90,-10},{110,10}})));
        equation
          x = flange.s;
          connect(r.p, p) annotation (Line(points={{-70,-20},{-90,-20},{-90,100},{-100,100}},
                              color={0,0,255}));
          connect(armature.flange_b, flange) annotation (Line(points={{84,0},{
                  88,0},{92,0},{100,0}}, color={0,127,0}));
          connect(armature.flange_a, g_mAirWork.flange) annotation (Line(points=
                 {{64,0},{34,0},{34,52},{-30,52},{-30,40}}, color={0,127,0}));
          connect(g_mAirWork.flange, g_mLeakWork.flange) annotation (Line(
                points={{-30,40},{-30,52},{34,52},{34,80},{-30,80}}, color={0,
                  127,0}));
          connect(r.n, coil.p) annotation (Line(points={{-50,-20},{-10,-20},{-10,10}},
                        color={0,0,255}));
          connect(coil.n, n) annotation (Line(points={{10,10},{10,-100},{-100,-100}},
                                                                                  color={0,0,255}));
          connect(coil.port_p, g_mAirWork.port_p)
            annotation (Line(points={{-10,30},{-20,30}},color={255,127,0}));
          connect(g_mAirWork.port_p, g_mLeakWork.port_p)
            annotation (Line(points={{-20,30},{-20,70}}, color={255,127,0}));
          connect(g_mAirWork.port_n, g_mLeakWork.port_n)
            annotation (Line(points={{-40,30},{-40,70}}, color={255,127,0}));
          connect(g_mFePole.port_p, g_mAirWork.port_n)
            annotation (Line(points={{-72,30},{-40,30}}, color={255,127,0}));
          connect(g_mFePoleBot.port_p, g_mFePole.port_n)
            annotation (Line(points={{-72,70},{-72,50}}, color={255,127,0}));
          connect(g_mFePoleBot.port_n, g_mFeYokeSide.port_p)
            annotation (Line(points={{-72,90},{-10,90}}, color={255,127,0}));
          connect(g_mFeYokeSide.port_n, g_mFeYokeBot.port_n)
            annotation (Line(points={{10,90},{80,90}}, color={255,127,0}));
          connect(g_mFeYokeBot.port_p, g_mAirPar.port_n)
            annotation (Line(points={{80,70},{80,60}}, color={255,127,0}));
          connect(g_mFeArm.port_p, g_mLeak2.port_p)
            annotation (Line(points={{26,40},{40,40}}, color={255,127,0}));
          connect(g_mLeak2.port_p, g_mLeak1.port_p)
            annotation (Line(points={{40,40},{60,40}}, color={255,127,0}));
          connect(g_mLeak1.port_p, g_mAirPar.port_p)
            annotation (Line(points={{60,40},{80,40}}, color={255,127,0}));
          connect(g_mLeak2.port_n, g_mLeak1.port_n)
            annotation (Line(points={{40,60},{60,60}}, color={255,127,0}));
          connect(g_mLeak1.port_n, g_mAirPar.port_n)
            annotation (Line(points={{60,60},{80,60}}, color={255,127,0}));
          connect(g_mFeArm.port_n, coil.port_n) annotation (Line(points={{6,40},{6,30},{10,30}},
                                  color={255,127,0}));
          connect(ground.port, g_mLeak1.port_p) annotation (Line(
              points={{60,30},{60,40}}, color={255,127,0}));
          annotation (Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Rectangle(
                extent={{-90,100},{90,-100}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,-30},{-4,30}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-40,-30},{-90,30}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,-100},{-90,100}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,90},{-90,100}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,-100},{-90,-90}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,40},{80,100}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,-100},{80,-40}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-70,80},{70,40}},
                lineColor={255,213,170},
                fillColor={255,213,170},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-70,-40},{70,-80}},
                lineColor={255,213,170},
                fillColor={255,213,170},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{150,150},{-150,110}},
                lineColor={0,0,255},
                textString="%name")}), Documentation(info="<html>
<p>
Please refer to the <strong>Parameters</strong> section for a schematic drawing of this axis-symmetric lifting magnet.
In the half-section below, the flux tube elements of the actuator's magnetic circuit are superimposed on a field plot obtained with FEA. The magnetomotive force imposed by the coil is modelled as one lumped element. As a result, the radial leakage flux between armature and yoke that occurs especially at large working air gaps can not be considered properly. This leads to a a higher total reluctance and lower inductance respectively compared to FEA for large working air gaps (i.e., armature close to x_max). Please have a look at the comments associated with the individual model components for a short explanation of their purpose in the model.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/SolenoidActuator/SimpleSolenoidModel_fluxTubePartitioning.png\" alt=\"Field lines and assigned flux tubes of the simple solenoid model\">
</p>

<p>
The coupling coefficient c_coupl in the coil is set to 1 in this example, since leakage flux is accounted for explicitly with the flux tube element G_mLeakWork. Although this leakage model is rather simple, it describes the reluctance force due to the leakage field sufficiently, especially at large air gaps. With decreasing air gap length, the influence of the leakage flux on the actuator's net reluctance force decreases due to the increasing influence of the main working air gap G_mAirWork.
</p>

<p>
During model-based actuator design, the radii and lengths of the flux tube elements (and hence their cross-sectional areas and flux densities) should be assigned with parametric equations so that common design rules are met (e.g., allowed flux density in ferromagnetic parts, allowed current density and required cross-sectional area of winding). For simplicity, those equations are omitted in the example. Instead, the found values are assigned to the model elements directly.
</p>
</html>"));
        end SimpleSolenoid;

        model AdvancedSolenoid
          "Advanced network model of a lifting magnet with planar armature end face, split magnetomotive force"

          parameter Real N=957 "Number of turns" annotation (Dialog(group=
                  "Parameters", groupImage=
                  "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/SolenoidActuator/Solenoid_dimensions.png"));
          parameter SI.Resistance R=5 "Coil resistance";
          parameter SI.Resistance R_par=1e5
            "Resistance parallel to the coil, in series to C_par";
          parameter SI.Capacitance C_par=1e-9
            "Capacitance parallel to the coil, in series to R_par";

          //yoke
          parameter SI.Radius r_yokeOut=15e-3 "Outer yoke radius";
          parameter SI.Radius r_yokeIn=13.5e-3 "Inner yoke radius";
          parameter SI.Length l_yoke=35e-3 "Axial yoke length";
          parameter SI.Length t_yokeBot=3.5e-3 "Axial thickness of yoke bottom";

          //pole
          parameter SI.Length l_pole=6.5e-3 "Axial length of pole";
          parameter SI.Length t_poleBot=3.5e-3
            "Axial thickness of bottom at pole side";

          parameter SI.Length t_airPar=0.65e-3
            "Radial thickness of parasitic air gap due to slide guiding";

          parameter FluxTubes.Material.SoftMagnetic.BaseData material=
              Material.SoftMagnetic.Steel.Steel_9SMnPb28()
            "Ferromagnetic material characteristics"
            annotation (choicesAllMatching=true, Dialog(group="Material"));

          //armature
          parameter SI.Radius r_arm=5e-3 "Armature radius = pole radius"
            annotation (Dialog(group="Armature and stopper"));
          parameter SI.Length l_arm=26e-3 "Armature length"
            annotation (Dialog(group="Armature and stopper"));
          parameter Modelica.SIunits.TranslationalSpringConstant c=1e11
            "Spring stiffness between impact partners"
            annotation (Dialog(group="Armature and stopper"));
          parameter Modelica.SIunits.TranslationalDampingConstant d=400
            "Damping coefficient between impact partners"
            annotation (Dialog(group="Armature and stopper"));
          parameter SI.Position x_min=0.25e-3
            "Stopper at minimum armature position"
            annotation (Dialog(group="Armature and stopper"));
          parameter SI.Position x_max=5e-3
            "Stopper at maximum armature position"
            annotation (Dialog(group="Armature and stopper"));

          SI.Position x(start=x_max, stateSelect=StateSelect.prefer)
            "Armature position";

          SI.MagneticFlux Psi_tot "Total flux linkage for information only";
          SI.Inductance L_statTot
            "Total static inductance for information only";

        protected
          parameter SI.Density rho_steel=7853
            "Density for calculation of armature mass from geometry";

        public
          FluxTubes.Basic.Ground ground annotation (Placement(transformation(
                  extent={{42,2},{62,22}})));
          FluxTubes.Basic.ElectroMagneticConverter coil1(final N=N/2, i(fixed=true))
            "Electro-magnetic conversion in first half of coil" annotation (
              Placement(transformation(
                origin={-46,20},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Resistor r_1(final R=R)
            "Resistance of first half of coil" annotation (Placement(
                transformation(extent={{-84,-30},{-64,-10}})));
          FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFeYokeSide1(
            final l=l_yoke/2 - t_poleBot/2,
            final r_i=r_yokeIn,
            final r_o=r_yokeOut,
            final nonLinearPermeability=true,
            final material=material)
            "Permeance of first half of yoke's hollow cylindric section"
            annotation (Placement(transformation(extent={{-50,70},{-30,90}})));

          FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFeArm(
            final r_i=0,
            final l=l_yoke - (t_yokeBot + t_poleBot)/2 - l_pole - (x_max +
                x_min)/2,
            final r_o=r_arm,
            final nonLinearPermeability=true,
            final material=material) "Permeance of ferromagnetic armature"
            annotation (Placement(transformation(
                origin={10,30},
                extent={{-10,10},{10,-10}},
                rotation=180)));

          FluxTubes.Shapes.Force.HollowCylinderAxialFlux g_mAirWork(
            final r_o=r_arm,
            final useSupport=false,
            final mu_r=1,
            final dlBydx=1,
            final r_i=0,
            final l=flange.s)
            "Permeance of working air gap (between armature and pole end faces)"
            annotation (Placement(transformation(
                origin={-20,30},
                extent={{-10,10},{10,-10}},
                rotation=180)));
          FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux g_mFeYokeBot(
            final l=t_yokeBot,
            final r_i=r_arm + t_airPar,
            final r_o=r_yokeIn,
            final nonLinearPermeability=true,
            final material=material)
            "Permeance of bottom side of ferromagnetic yoke" annotation (
              Placement(transformation(
                origin={74,70},
                extent={{-10,-10},{10,10}},
                rotation=90)));

          FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux g_mAirPar(
            final l=t_yokeBot,
            final r_i=r_arm,
            final r_o=r_arm + t_airPar,
            final nonLinearPermeability=false,
            final mu_rConst=1)
            "Permeance of parasitic radial air gap due to slide guiding"
            annotation (Placement(transformation(
                origin={74,40},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux g_mFePoleBot(
            final l=t_poleBot,
            final r_i=r_arm,
            final r_o=r_yokeIn,
            final nonLinearPermeability=true,
            final material=material) "Permeance of bottom side of pole"
            annotation (Placement(transformation(
                origin={-78,56},
                extent={{-10,-10},{10,10}},
                rotation=90)));

          FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFePole(
            final l=l_pole,
            final r_o=r_arm,
            final nonLinearPermeability=true,
            final material=material,
            r_i=0) "Permeance of ferromagnetic pole" annotation (Placement(
                transformation(
                origin={-68,30},
                extent={{-10,10},{10,-10}},
                rotation=180)));

          FluxTubes.Examples.Utilities.TranslatoryArmatureAndStopper armature(
            final x_max=x_max,
            final x_min=x_min,
            final m=rho_steel*l_arm*pi*r_arm^2,
            final L=0,
            final c=c,
            final d=d,
            n=2,
            v(fixed=true))
            "Inertia of armature and stoppers at end of stroke range"
            annotation (Placement(transformation(extent={{64,-10},{84,10}})));
          FluxTubes.Shapes.Leakage.QuarterCylinder g_mLeak1(final l=2*pi*(r_arm +
                t_airPar/2))
            "Leakage permeance between inner edge of yoke bore and armature side face"
            annotation (Placement(transformation(
                origin={60,40},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          FluxTubes.Shapes.Leakage.QuarterHollowCylinder g_mLeak2(final ratio=8,
              final l=2*pi*r_arm)
            "Leakage permeance between inner side of yoke bottom and armature side (r_i = t_airPar)"
            annotation (Placement(transformation(
                origin={46,40},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          FluxTubes.Basic.ElectroMagneticConverter coil2(final N=N/2, i(fixed=true))
            "Electro-magnetic conversion in first half of coil" annotation (
              Placement(transformation(
                origin={30,20},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          Modelica.Electrical.Analog.Basic.Capacitor c_par1(final C=C_par, v(
                start=0, fixed=true))
            "Parasitic capacitance assigned to first half of coil" annotation (
              Placement(transformation(extent={{-56,-50},{-36,-30}})));
          FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux G_mLeakRad(
            final mu_rConst=1,
            final r_i=r_arm,
            final r_o=r_yokeIn,
            final l=l_yoke/4,
            final nonLinearPermeability=false)
            "Permeance of radial leakage flux tube between armature side and yoke side"
            annotation (Placement(transformation(
                origin={0,56},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFeYokeSide2(
            final l=l_yoke/2 - t_yokeBot/2,
            final r_i=r_yokeIn,
            r_o=r_yokeOut,
            final nonLinearPermeability=true,
            final material=material)
            "Permeance of second half of yoke's hollow cylindric section"
            annotation (Placement(transformation(extent={{20,70},{40,90}})));

          Modelica.Electrical.Analog.Basic.Capacitor c_par2(final C=C_par, v(
                start=0, fixed=true))
            "Parasitic capacitance assigned to second half of coil" annotation (
             Placement(transformation(extent={{20,-50},{40,-30}})));
          Modelica.Electrical.Analog.Basic.Resistor r_par1(final R=R_par)
            "Parasitic resistance assigned to first half of coil" annotation (
              Placement(transformation(extent={{-84,-50},{-64,-30}})));
          Modelica.Electrical.Analog.Basic.Resistor r_par2(final R=R_par)
            "Parasitic resistance assigned to second half of coil" annotation (
              Placement(transformation(extent={{-8,-50},{12,-30}})));
          Modelica.Electrical.Analog.Basic.Resistor r_2(final R=R)
            "Resistance of second half of coil" annotation (Placement(
                transformation(extent={{-8,-30},{12,-10}})));
          FluxTubes.Shapes.Leakage.QuarterCylinder g_mLeak3(final l=2*pi*(r_arm +
                t_airPar/2))
            "Leakage permeance between outer edge of yoke bore and armature side face"
            annotation (Placement(transformation(
                origin={88,40},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          FluxTubes.Shapes.Force.LeakageAroundPoles g_mLeakWork(
            final w=2*pi*(r_arm + 0.0015),
            final r=0.003,
            final useSupport=false,
            final mu_r=1,
            final dlBydx=1,
            final l=flange.s)
            "Permeance of leakage air gap around working air gap (between armature and pole side faces)"
            annotation (Placement(transformation(
                origin={-20,64},
                extent={{-10,10},{10,-10}},
                rotation=180)));
          Modelica.Electrical.Analog.Interfaces.PositivePin p
            "Electrical connector" annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin n
            "Electrical connector" annotation (Placement(transformation(extent={{-90,-110},{-110,-90}})));
          Modelica.Mechanics.Translational.Interfaces.Flange_b flange
            "Flange of component" annotation (Placement(transformation(extent={
                    {90,-10},{110,10}})));
        equation
          x = flange.s;
          Psi_tot = coil1.Psi + coil2.Psi;
          L_statTot = coil1.L_stat + coil2.L_stat;
          connect(armature.flange_b, flange) annotation (Line(points={{84,0},{
                  88,0},{92,0},{100,0}}, color={0,127,0}));
          connect(r_par1.n, c_par1.p)
            annotation (Line(points={{-64,-40},{-56,-40}}, color={0,0,255}));
          connect(r_par1.p, r_1.p)
            annotation (Line(points={{-84,-40},{-84,-20}}, color={0,0,255}));
          connect(c_par2.p, r_par2.n)
            annotation (Line(points={{20,-40},{12,-40}}, color={0,0,255}));
          connect(r_par2.p, r_2.p)
            annotation (Line(points={{-8,-40},{-8,-20}}, color={0,0,255}));
          connect(r_1.p, p) annotation (Line(points={{-84,-20},{-92,-20},{-92,100},{-100,100}},
                                  color={0,0,255}));
          connect(g_mLeakWork.flange, g_mAirWork.flange) annotation (Line(
                points={{-20,74},{-6,74},{-6,40},{-20,40}}, color={0,127,0}));
          connect(g_mAirWork.flange, armature.flange_a) annotation (Line(points=
                 {{-20,40},{-6,40},{-6,0},{64,0}}, color={0,127,0}));
          connect(n, c_par2.n) annotation (Line(points={{-100,-100},{40,-100},{40,-40}},
                         color={0,0,255}));
          connect(coil2.port_p, g_mFeArm.port_p)
            annotation (Line(points={{20,30},{20,30}}, color={255,127,0}));
          connect(G_mLeakRad.port_p, g_mFeArm.port_n) annotation (Line(points={{
                  0,46},{0,46},{0,30}}, color={255,127,0}));
          connect(g_mAirWork.port_p, g_mFeArm.port_n)
            annotation (Line(points={{-10,30},{0,30}}, color={255,127,0}));
          connect(coil1.port_n, g_mAirWork.port_n)
            annotation (Line(points={{-36,30},{-30,30}}, color={255,127,0}));
          connect(g_mAirWork.port_n, g_mLeakWork.port_n)
            annotation (Line(points={{-30,30},{-30,64}}, color={255,127,0}));
          connect(g_mLeakWork.port_p, g_mAirWork.port_p)
            annotation (Line(points={{-10,64},{-10,30}}, color={255,127,0}));
          connect(coil1.port_p, g_mFePole.port_p)
            annotation (Line(points={{-56,30},{-58,30}}, color={255,127,0}));
          connect(g_mFePole.port_n, g_mFePoleBot.port_p)
            annotation (Line(points={{-78,30},{-78,46}}, color={255,127,0}));
          connect(g_mFePoleBot.port_n, g_mFeYokeSide1.port_p) annotation (Line(
                points={{-78,66},{-78,80},{-50,80}}, color={255,127,0}));
          connect(g_mFeYokeSide1.port_n, G_mLeakRad.port_n) annotation (Line(
                points={{-30,80},{0,80},{0,66}}, color={255,127,0}));
          connect(g_mFeYokeSide1.port_n, g_mFeYokeSide2.port_p)
            annotation (Line(points={{-30,80},{20,80}}, color={255,127,0}));
          connect(g_mFeYokeSide2.port_n, g_mFeYokeBot.port_n)
            annotation (Line(points={{40,80},{74,80}}, color={255,127,0}));
          connect(coil2.port_n, g_mLeak2.port_p)
            annotation (Line(points={{40,30},{46,30}}, color={255,127,0}));
          connect(g_mLeak2.port_p, g_mLeak1.port_p)
            annotation (Line(points={{46,30},{60,30}}, color={255,127,0}));
          connect(g_mLeak1.port_p, g_mAirPar.port_p)
            annotation (Line(points={{60,30},{74,30}}, color={255,127,0}));
          connect(g_mAirPar.port_p, g_mLeak3.port_p)
            annotation (Line(points={{74,30},{88,30}}, color={255,127,0}));
          connect(g_mLeak2.port_n, g_mLeak1.port_n)
            annotation (Line(points={{46,50},{60,50}}, color={255,127,0}));
          connect(g_mLeak1.port_n, g_mAirPar.port_n)
            annotation (Line(points={{60,50},{74,50}}, color={255,127,0}));
          connect(g_mAirPar.port_n, g_mLeak3.port_n)
            annotation (Line(points={{74,50},{88,50}}, color={255,127,0}));
          connect(g_mFeYokeBot.port_p, g_mAirPar.port_n)
            annotation (Line(points={{74,60},{74,50}}, color={255,127,0}));
          connect(coil2.p, r_2.n) annotation (Line(points={{20,10},{20,-20},{12,-20}},
                         color={0,0,255}));
          connect(coil2.n, c_par2.n)
            annotation (Line(points={{40,10},{40,-40}}, color={0,0,255}));
          connect(coil1.n, c_par1.n)
            annotation (Line(points={{-36,10},{-36,-40}}, color={0,0,255}));
          connect(coil1.n, r_2.p) annotation (Line(points={{-36,10},{-36,-20},{-8,-20}},
                            color={0,0,255}));
          connect(r_1.n, coil1.p) annotation (Line(points={{-64,-20},{-56,-20},{-56,10}},
                             color={0,0,255}));
          connect(ground.port, g_mLeak2.port_p) annotation (Line(
              points={{52,22},{52,30},{46,30}}, color={255,127,0}));
          annotation (Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}), graphics={
              Rectangle(
                extent={{-90,100},{90,-100}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,-30},{-4,30}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-40,-30},{-90,30}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,-100},{-90,100}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,90},{-90,100}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,-100},{-90,-90}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,40},{80,100}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{90,-100},{80,-40}},
                lineColor={255,128,0},
                fillColor={255,128,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-70,80},{70,40}},
                lineColor={255,213,170},
                fillColor={255,213,170},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-70,-40},{70,-80}},
                lineColor={255,213,170},
                fillColor={255,213,170},
                fillPattern=FillPattern.Solid),
              Line(points={{4,30},{4,32},{2,38},{-4,48},{-14,60},{-22,72},{-24,
                    80},{-24,90}}, color={255,128,0}),
              Line(points={{22,30},{22,32},{20,38},{14,48},{4,60},{-4,72},{-6,
                    80},{-6,90}}, color={255,128,0}),
              Line(points={{40,30},{40,32},{38,38},{32,48},{22,60},{14,72},{12,
                    80},{12,90}}, color={255,128,0}),
              Text(
                extent={{150,150},{-150,110}},
                lineColor={0,0,255},
                textString="%name")}), Documentation(info="<html>
<p>
Please have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid\">SimpleSolenoid</a> for a general description of this actuator. Unlike in that simple magnetic network model, the coil is split into two lumped elements here. This enables for more realistic modelling of the radial leakage flux between armature and yoke (leakage permeance G_mLeakRad). Especially for large air gaps, the influence of this leakage flux on the actuator's inductance and its electromagnetic force is rather strong. Please have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.ComparisonQuasiStationary\">ComparisonQuasiStationary</a> for a comparison of both models with FEA-based results included as reference.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/SolenoidActuator/AdvancedSolenoidModel_fluxTubePartitioning.png\" alt=\"Assigned flux tubes and field plot of the solenoid actuator\">
</p>

<p>
The parasitic capacitances c_par1 and c_par2 across both partial coils assure that the voltages across these coils are well-defined during simulation.
</p>
</html>"));
        end AdvancedSolenoid;
      end Components;
      annotation (Documentation(info="<html>
<p>
In electromagnetic or reluctance actuators, a thrust or reluctance force is generated due to a non-zero gradient of the relative magnetic permeability mu_r at surfaces between regions of different permeability (non-saturated ferromagnetic material: mu_r>>1, adjacent air: mu_r=1). In lumped magnetic network models, this force can be calculated as shortly outlined in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.ReluctanceForceCalculation\">Reluctance Forces</a> of the User's Guide.
</p>

<p>
As an example of a reluctance actuator, a simple axis-symmetric lifting magnet with planar end planes of armature and pole is shown. Often, a <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid\">SimpleSolenoid</a> model is sufficient for initial rough design of such an actuator's magnetic subsystem. Higher accuracy can be gained from an <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components.AdvancedSolenoid\">AdvancedSolenoid</a> model where the coil-imposed magnetomotive force is split and the leakage flux between armature and yoke is accounted for more precisely.
</p>

<p>
The differences between these two models in static behaviour can be analysed and compared to results obtained with a more accurate finite element analysis (FEA) in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.ComparisonQuasiStationary\">ComparisonQuasiStationary</a>. The resulting differences in dynamic behaviour can be analysed and compared to FEA results with simulation of a pull-in stroke in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.ComparisonPullInStroke\">ComparisonPullInStroke</a>.
</p>
</html>"));
    end SolenoidActuator;

    package Hysteresis
      extends Modelica.Icons.ExamplesPackage;

      model HysteresisModelComparison
        "Comparison of the different hysteresis models"
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,0.0; 1,500; 3,-500;
              5,500; 6,-24; 7,24; 8,-24; 9,24; 10,-24; 11,24; 12,-24; 13,24; 14,
              -24; 15,24])
          annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
        Basic.ElectroMagneticConverterWithLeakageInductance winding1(N=1) "Winding 1" annotation (Placement(transformation(extent={{30,50},{50,70}})));
        Modelica.Electrical.Analog.Basic.Ground elGnd1
          annotation (Placement(transformation(extent={{0,30},{20,50}})));
        Basic.Ground magGnd1
          annotation (Placement(transformation(extent={{60,30},{80,50}})));
        Modelica.Electrical.Analog.Basic.Resistor resistor1(R=1) annotation (Placement(transformation(extent={{0,60},{20,80}})));
        Modelica.Electrical.Analog.Sources.SignalVoltage vSource1 annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-10,60})));
        Basic.ElectroMagneticConverterWithLeakageInductance winding2(N=1) "Winding 2" annotation (Placement(transformation(extent={{30,-10},{50,10}})));
        Modelica.Electrical.Analog.Basic.Ground elGnd2
          annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
        Shapes.HysteresisAndMagnets.GenericHystTellinenTable tellinenTable(
          includeEddyCurrents=false,
          sigma=1,
          K=100,
          mat=FluxTubes.Material.HysteresisTableData.M330_50A(),
          l=1,
          MagRel(fixed=true, start=0))
               annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={70,10})));
        Basic.Ground magGnd2
          annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
        Modelica.Electrical.Analog.Basic.Resistor resistor2(R=1) annotation (Placement(transformation(extent={{0,0},{20,20}})));
        Modelica.Electrical.Analog.Sources.SignalVoltage vSource2 annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-10,0})));
        Basic.ElectroMagneticConverterWithLeakageInductance winding3(N=1) "Winding 3" annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
        Modelica.Electrical.Analog.Basic.Ground elGnd3
          annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
        Shapes.HysteresisAndMagnets.GenericHystPreisachEverett preisachEverett(
          includeEddyCurrents=false,
          sigma=1,
          mat=FluxTubes.Material.HysteresisEverettParameter.M330_50A(),
          l=1,
          MagRel(fixed=true, start=0))
               annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={70,-50})));
        Basic.Ground magGnd3
          annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
        Modelica.Electrical.Analog.Basic.Resistor resistor3(R=1) annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
        Modelica.Electrical.Analog.Sources.SignalVoltage vSource3 annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-10,-60})));
        Modelica.Blocks.Math.Gain gain(k=1)
          annotation (Placement(transformation(extent={{-58,50},{-38,70}})));
        Shapes.HysteresisAndMagnets.GenericHystTellinenSoft tellinenSoft(
          l=1,
          Js=1.35,
          Br=1.0,
          Hc=40,
          K=100,
          MagRel(fixed=true, start=0))
          annotation (Placement(transformation(extent={{62,60},{82,80}})));
      equation
        connect(winding1.port_n, magGnd1.port) annotation (Line(points={{50,50},{70,50}}, color={255,127,0}));
        connect(resistor1.n, winding1.p) annotation (Line(points={{20,70},{30,70}}, color={0,0,255}));
        connect(winding1.n, elGnd1.p) annotation (Line(points={{30,50.2},{30,50},{10,50}}, color={0,0,255}));
        connect(vSource1.p, resistor1.p) annotation (Line(points={{-10,70},{0,70}}, color={0,0,255}));
        connect(elGnd1.p, vSource1.n) annotation (Line(points={{10,50},{-10,50}}, color={0,0,255}));
        connect(winding2.port_n, magGnd2.port) annotation (Line(points={{50,-10},{70,-10}}, color={255,127,0}));
        connect(winding2.port_p, tellinenTable.port_p) annotation (Line(points={{50,10},{60,10}}, color={255,127,0}));
        connect(resistor2.n, winding2.p) annotation (Line(points={{20,10},{26,10},{26,10},{26,10},{26,10},{30,10}}, color={0,0,255}));
        connect(winding2.n, elGnd2.p) annotation (Line(points={{30,-9.8},{30,-10},{10,-10}}, color={0,0,255}));
        connect(vSource2.p, resistor2.p) annotation (Line(points={{-10,10},{-6,10},{-6,10},{-4,10},{-4,10},{0,10}}, color={0,0,255}));
        connect(elGnd2.p, vSource2.n) annotation (Line(points={{10,-10},{-10,-10}}, color={0,0,255}));
        connect(tellinenTable.port_n, magGnd2.port) annotation (Line(
            points={{80,10},{90,10},{90,-10},{70,-10}},
                                                    color={255,127,0}));
        connect(vSource2.v, vSource1.v) annotation (Line(points={{-22,0},{-30,0},{-30,60},{-22,60}}, color={0,0,127}));
        connect(winding3.port_n, magGnd3.port) annotation (Line(points={{50,-70},{70,-70}}, color={255,127,0}));
        connect(winding3.port_p, preisachEverett.port_p) annotation (Line(points={{50,-50},{60,-50}}, color={255,127,0}));
        connect(resistor3.n, winding3.p) annotation (Line(points={{20,-50},{30,-50}}, color={0,0,255}));
        connect(winding3.n, elGnd3.p) annotation (Line(points={{30,-69.8},{30,-70},{10,-70}}, color={0,0,255}));
        connect(vSource3.p, resistor3.p) annotation (Line(points={{-10,-50},{0,-50}}, color={0,0,255}));
        connect(elGnd3.p, vSource3.n) annotation (Line(points={{10,-70},{-10,-70}}, color={0,0,255}));
        connect(preisachEverett.port_n, magGnd3.port) annotation (Line(
            points={{80,-50},{90,-50},{90,-70},{70,-70}}, color={255,127,0}));
        connect(vSource3.v, vSource1.v) annotation (Line(points={{-22,-60},{-30,-60},{-30,60},{-22,60}}, color={0,0,127}));
        connect(timeTable.y, gain.u) annotation (Line(
            points={{-69,60},{-60,60}},     color={0,0,127}));
        connect(gain.y, vSource1.v) annotation (Line(points={{-37,60},{-22,60}}, color={0,0,127}));
        connect(winding1.port_p, tellinenSoft.port_p) annotation (Line(points={{50,70},{62,70}}, color={255,127,0}));
        connect(magGnd1.port,tellinenSoft. port_n) annotation (Line(points={{70,50},{90,50},{90,70},{82,70}},
                                              color={255,127,0}));
        annotation (experiment(StartTime=0, StopTime=14, Interval=3e-3, Tolerance=1e-005), Documentation(info="<html>
<p>
Use the following simulation settings:
</p>
<ul>
  <li>Stop time: 14 s</li>
  <li>Number of intervals: 5000</li>
  <li>Tolerance: 1e-5</li>
</ul>
<p>
This example compares the behavior of three different hysteresis models due to the exact same input magnetic field strength. The three different models are:
</p>
<ol>
  <li>Model=GenericHystTellinenSoft, Tellinen hysteresis model, the upper and lower branch of the limiting hysteresis loop is roughly approximated with simple hyperbolic tangent functions (Fig1. c)</li>
  <li>Model=GenericHystTellinenTable, Tellinen hysteresis model, the upper and lower branch of the limiting hysteresis loop can be defined with almost arbitrary table data (Fig1. d)</li>
  <li>Model=GenericHystPreisachEverett,Preisach hysteresis model, the hysteresis shape is defined by the Everett function (Fig1. e)</li>
</ol>
<p>
Compared to the complex Preisach hysteresis model the Tellinen model is very simple and thus computationally more effective and stable. It is sufficient for many applications. But the Tellinen model has inherently a problem with small periodic input field variations at locations where the outer hysteresis loop has large slopes. In such a case, the simulated minor loops settle to the center of the hysteresis envelope curve, whereas the minor loops of the Preisach model stay constant ('property of equal vertical chords', <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ma03]</a>). The input signal of the example (Fig. 1 a) corresponds to that case and Fig. 1 b-e shows the behavior of the different models.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1: </strong>Simulated magnetic flux densities B of different hysteresis models (b) due to an applied mangetic field strength shown in (a). Corresponding B(H) loops of the hysteresis models GenericHystTellinenSoft (c), GenericHystTellinenTable (d) and GenericHystPreisachEverett (e).</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/HysteresisModelComparison/plot1.png\">
    </td>
  </tr>
</table>
</html>"));
      end HysteresisModelComparison;

      model InductorWithHysteresis
        extends Modelica.Icons.Example;
        Basic.Ground mag_ground
          annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
        Basic.ElectroMagneticConverterWithLeakageInductance winding(i(fixed=
                true), N=10)
          annotation (Placement(transformation(extent={{-10,0},{10,20}})));
        Modelica.Electrical.Analog.Basic.Ground el_ground
          annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
        Modelica.Electrical.Analog.Basic.Resistor resistor(R=0.1) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
        Modelica.Electrical.Analog.Sources.SineVoltage vSource(freqHz=200, V=5) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-50,10})));
        Shapes.HysteresisAndMagnets.GenericHystTellinenEverett core(
          mat=FluxTubes.Material.HysteresisEverettParameter.M330_50A(),
          A=4e-4,
          MagRel(fixed=true, start=0),
          includeEddyCurrents=true,
          derHstat(fixed=true),
          l=0.1)
          annotation (Placement(transformation(extent={{20,20},{40,40}})));
      equation
        connect(winding.port_n, mag_ground.port) annotation (Line(
            points={{10,0},{10,-10}}, color={255,127,0}));
        connect(vSource.p, resistor.p) annotation (Line(points={{-50,20},{-50,30},{-40,30}}, color={0,0,255}));
        connect(vSource.n, el_ground.p) annotation (Line(points={{-50,0},{-50,-10}}, color={0,0,255}));
        connect(winding.n, el_ground.p) annotation (Line(
            points={{-10,0.2},{-10,-10},{-50,-10}},
                                                  color={0,0,255}));
        connect(resistor.n, winding.p) annotation (Line(points={{-20,30},{-10,30},{-10,20},{-10,20}}, color={0,0,255}));
        connect(winding.port_p,core. port_p) annotation (Line(points={{10,20},{10,30},{20,30}},
                                 color={255,127,0}));
        connect(mag_ground.port,core. port_n) annotation (Line(points={{10,-10},{46,-10},{46,30},{40,30}},
                                           color={255,127,0}));
        annotation (experiment(StartTime=0, StopTime=0.02, Interval=4e-6, Tolerance=1e-004), Documentation(info="<html>
<p>
This is a simple model of an inductor with a ferromagnetic core. The used GenericHystTellinenEverett model considers the ferromagnetic hysteresis, eddy currents and remanence of the core material. For example you can simulate the model for 0.02s and plot Core.B vs. Core.H to visualize the resulting hysteresis loops.
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1: </strong>Results Core.B(t) and Core.B(H) of the magnetic Core.</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/InductorWithHysteresis/plot1.png\">
    </td>
  </tr>
</table>
</html>"));
      end InductorWithHysteresis;

      model SinglePhaseTransformerWithHysteresis1
        extends Modelica.Icons.Example;
        Basic.Ground mag_ground
          annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
        Basic.ElectroMagneticConverterWithLeakageInductance winding1(N=10, i(fixed=true)) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
        Modelica.Electrical.Analog.Basic.Ground el_ground1
          annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
        Modelica.Electrical.Analog.Basic.Resistor resistor1(R=0.05) annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
        Modelica.Electrical.Analog.Sources.SineVoltage vSource(freqHz=400, V=8) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,0})));
        Basic.ElectroMagneticConverterWithLeakageInductance winding2(N=10, i(fixed=true)) annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=180,
              origin={30,0})));
        Modelica.Electrical.Analog.Basic.Resistor resistor2(R=2) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={62,20})));
        Modelica.Electrical.Analog.Basic.Ground el_ground2
          annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
        Shapes.HysteresisAndMagnets.GenericHystTellinenTable core(
          asc(fixed=false),
          mat=FluxTubes.Material.HysteresisTableData.M330_50A(),
          includeEddyCurrents=true,
          l=0.2,
          A=5e-4,
          MagRel(start=0.5, fixed=true))
          annotation (Placement(transformation(extent={{-10,10},{10,30}})));
      equation
        connect(winding1.port_n, mag_ground.port) annotation (Line(points={{-20,-10},{-20,-20},{0,-20}}, color={255,127,0}));
        connect(vSource.p, resistor1.p) annotation (Line(points={{-80,10},{-80,20},{-70,20}}, color={0,0,255}));
        connect(vSource.n, el_ground1.p) annotation (Line(points={{-80,-10},{-80,-20},{-60,-20}}, color={0,0,255}));
        connect(winding1.n, el_ground1.p) annotation (Line(points={{-40,-9.8},{-40,-20},{-60,-20}}, color={0,0,255}));
        connect(resistor1.n, winding1.p) annotation (Line(points={{-50,20},{-40,20},{-40,10}}, color={0,0,255}));
        connect(winding2.port_n, mag_ground.port) annotation (Line(points={{20,-10},{20,-20},{0,-20}}, color={255,127,0}));
        connect(winding2.p, resistor2.p) annotation (Line(points={{40,10},{40,20},{52,20}}, color={0,0,255}));
        connect(winding2.n, el_ground2.p) annotation (Line(points={{40,-9.8},{40,-20},{60,-20}}, color={0,0,255}));
        connect(resistor2.n, el_ground2.p) annotation (Line(points={{72,20},{80,20},{80,-20},{60,-20}}, color={0,0,255}));
        connect(winding1.port_p, core.port_p) annotation (Line(points={{-20,10},{-20,20},{-10,20}}, color={255,127,0}));
        connect(core.port_n, winding2.port_p) annotation (Line(points={{10,20},{20,20},{20,10}}, color={255,127,0}));
        annotation (experiment(StartTime=0, StopTime=0.02, Interval=4e-6, Tolerance=1e-006), Documentation(info="<html>
<p>
This simple model of an single phase transformer shows the inrush currents due to the remanence of the core material (M330-50A). For an accurate modelling of the core material the GenericHystTellinenTable hysteresis flux tube element is used. The initial magnetization MagRel of the Core component is set to 80%. Simulation settings:
</p>
<ul>
  <li>Stop time: 0.02 s</li>
  <li>Number of intervals: 5000</li>
  <li>Tolerance: 1e-6</li>
</ul>
<p>
Then plot the flux density of the Core Core.B over the magnetic field strength Core.H and additionally the time course of the primary and secondary current and e.g. the power consumption of the iron core Core.LossPower (see the following figures).
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/SinglePhaseTransformerWithHysteresis1/plot01.png\" hspace=\"10\" vspace=\"10\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/SinglePhaseTransformerWithHysteresis1/plot02.png\" hspace=\"10\" vspace=\"10\">
    </td>
  </tr>
</table>

</html>"));
      end SinglePhaseTransformerWithHysteresis1;

      model SinglePhaseTransformerWithHysteresis2
        extends Modelica.Icons.Example;
        Modelica.Electrical.Analog.Basic.Ground el_ground1
          annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
        Modelica.Electrical.Analog.Basic.Resistor resistor1(R=0.05) annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
        Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage(freqHz=
             400, V=6) annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=270,
              origin={-60,20})));
        Modelica.Electrical.Analog.Basic.Resistor resistor2(R=2) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={40,40})));
        Modelica.Electrical.Analog.Basic.Ground el_ground2
          annotation (Placement(transformation(extent={{30,-20},{50,0}})));
        Components.Transformer1PhaseWithHysteresis transformer(
          mat=FluxTubes.Material.HysteresisEverettParameter.M330_50A(),
          MagRelFixed=true,
          I1Fixed=true,
          EddyCurrents=false,
          HFixed=false) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
      equation
        connect(SineVoltage.p, resistor1.p) annotation (Line(points={{-60,30},{-60,40},{-50,40}}, color={0,0,255}));
        connect(SineVoltage.n, el_ground1.p) annotation (Line(points={{-60,10},{-60,0},{-40,0}},color={0,0,255}));
        connect(resistor2.n, el_ground2.p) annotation (Line(points={{50,40},{60,40},{60,0},{40,0}}, color={0,0,255}));
        connect(resistor1.n, transformer.p1) annotation (Line(points={{-30,40},{-20,40},{-20,30},{-10,30}}, color={0,0,255}));
        connect(transformer.n1, el_ground1.p) annotation (Line(points={{-10,10},{-20,10},{-20,0},{-40,0}}, color={0,0,255}));
        connect(transformer.p2, resistor2.p) annotation (Line(points={{10,30},{10,30},{20,30},{20,40},{30,40}}, color={0,0,255}));
        connect(transformer.n2, el_ground2.p) annotation (Line(points={{10,10},{10,12},{20,12},{20,0},{40,0}}, color={0,0,255}));
        annotation (experiment(StartTime=0, StopTime=0.1, Interval=2e-5, Tolerance=1e-004), Documentation(info="<html>
<p>
A simple model of an single phase transformer (similar to <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis.SinglePhaseTransformerWithHysteresis1\">SinglePhaseTransformerWithHysteresis1</a> but with separate transformer model: <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis.Components.Transformer1PhaseWithHysteresis\">Transformer1PhaseWithHysteresis</a>). Use the simulation settings:
</p>
<ul>
  <li>Stop time: 0.1 s</li>
  <li>Number of intervals: 5000.</li>
</ul>
<p>
The figure shows the magnetic hysteresis in the transformer core. In (a) the consideration of the eddy currents is switched off, in (b) it is enabled.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/SinglePhaseTransformerWithHysteresis2/plot1.png\" hspace=\"10\" vspace=\"10\">
    </td>
  </tr>
</table>

</html>"));
      end SinglePhaseTransformerWithHysteresis2;

      model ThreePhaseTransformerWithRectifier
        "3 Phase transformer (including hysteresis effect) with rectifier"
        extends Modelica.Icons.Example;

        Modelica.Electrical.Analog.Basic.Ground ground1 annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
        Modelica.Electrical.Analog.Basic.Ground ground2 annotation (Placement(transformation(extent={{-36,-90},{-16,-70}})));
        Modelica.Electrical.Analog.Sources.SineVoltage vSource1(
          offset=0,
          freqHz=50,
          V=50) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-140,-40})));
        Components.Transformer3PhaseYyWithHysteresis transformer(
          EddyCurrents=true,
          N1=200,
          N2=10,
          mat=FluxTubes.Material.HysteresisEverettParameter.M330_50A(),
          sigma=2.2e6,
          HFixed={true,true,true},
          MagRelFixed={true,true,false},
          I1Fixed={true,true,true},
          I2Fixed={true,false,false},
          useHeatPort=false,
          MagRelStart={-0.4,0.8,-0.4},
          l1=0.2,
          l2=0.15,
          a=0.04,
          b=0.04,
          t=0.0005) annotation (Placement(transformation(extent={{-40,-15},{-20,5}})));
        Modelica.Electrical.Analog.Sources.SineVoltage vSource2(
          offset=0,
          freqHz=vSource1.freqHz,
          V=50,
          phase=4.1887902047864) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-120,-40})));
        Modelica.Electrical.Analog.Sources.SineVoltage vSource3(
          offset=0,
          freqHz=vSource1.freqHz,
          V=50,
          phase=2.0943951023932) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-100,-40})));
        Modelica.Electrical.Analog.Basic.Resistor resistor1(R=0) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-70,15})));
        Modelica.Electrical.Analog.Basic.Resistor resistor2(R=resistor1.R) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-70,-5})));
        Modelica.Electrical.Analog.Basic.Resistor resistor3(R=resistor1.R) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-70,-25})));
        Modelica.Electrical.Analog.Ideal.IdealDiode diode1(Vknee=0.7) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={30,20})));
        Modelica.Electrical.Analog.Ideal.IdealDiode diode2(Vknee=0.7) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={30,-30})));
        Modelica.Electrical.Analog.Basic.Resistor resistorL(R=5) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={120,-5})));
        Modelica.Electrical.Analog.Ideal.IdealDiode diode3(Vknee=0.7) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={50,20})));
        Modelica.Electrical.Analog.Ideal.IdealDiode diode4(Vknee=0.7) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={50,-30})));
        Modelica.Electrical.Analog.Ideal.IdealDiode diode5(Vknee=0.7) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={70,20})));
        Modelica.Electrical.Analog.Ideal.IdealDiode diode6(Vknee=0.7) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={70,-30})));
        Modelica.Electrical.Analog.Basic.Capacitor capacitor1(C=1e-6, v(fixed=
                true)) annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={90,20})));
        Modelica.Electrical.Analog.Basic.Inductor inductor1(L=1e-3) annotation (Placement(transformation(extent={{-10,4},{10,24}})));
        Modelica.Electrical.Analog.Basic.Inductor inductor2(L=1e-3)
          annotation (Placement(transformation(extent={{-10,-15},{10,5}})));
        Modelica.Electrical.Analog.Basic.Inductor inductor3(L=1e-3)
          annotation (Placement(transformation(extent={{-10,-35},{10,-15}})));
        Modelica.Electrical.Analog.Basic.Capacitor capacitor2(C=1e-6, v(fixed=
                true)) annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={90,-30})));
        Modelica.Blocks.Sources.RealExpression rExp1(y=transformer.LossPowerStat) annotation (Placement(transformation(extent={{-113,77},{-82,93}})));
        Modelica.Blocks.Sources.RealExpression rExp2(y=transformer.LossPowerEddy) annotation (Placement(transformation(extent={{-113,57},{-81,73}})));
        Modelica.Blocks.Sources.RealExpression rExp3(y=transformer.LossPowerWinding) annotation (Placement(transformation(extent={{-113,37},{-81,53}})));
        Modelica.Blocks.Continuous.Filter pdissStatAvg(f_cut=10)
          "Approx. average static hysteresis losses"
          annotation (Placement(transformation(extent={{-50,80},{-40,90}})));
        Modelica.Blocks.Continuous.Filter pdissEddyAvg(f_cut=10)
          "Approx. average eddy current losses"
          annotation (Placement(transformation(extent={{-50,60},{-40,70}})));
        Modelica.Blocks.Continuous.Filter pdissCopAvg(f_cut=10)
          "Approx. average copper losses"
          annotation (Placement(transformation(extent={{-50,40},{-40,50}})));
      equation
        connect(vSource1.n, ground1.p) annotation (Line(points={{-140,-50},{-140,-70},{-110,-70}}, color={0,0,255}));
        connect(vSource2.n, ground1.p) annotation (Line(points={{-120,-50},{-120,-70},{-110,-70}}, color={0,0,255}));
        connect(vSource3.n, ground1.p) annotation (Line(points={{-100,-50},{-100,-70},{-110,-70}}, color={0,0,255}));
        connect(resistor1.n, transformer.p1) annotation (Line(points={{-60,15},{-50,15},{-50,1},{-40,1}}, color={0,0,255}));
        connect(resistor1.p, vSource1.p) annotation (Line(points={{-80,15},{-140,15},{-140,-30}}, color={0,0,255}));
        connect(resistor2.n, transformer.p2) annotation (Line(points={{-60,-5},{-40,-5}}, color={0,0,255}));
        connect(resistor2.p, vSource2.p) annotation (Line(points={{-80,-5},{-120,-5},{-120,-30}}, color={0,0,255}));
        connect(vSource3.p, resistor3.p) annotation (Line(points={{-100,-30},{-100,-25},{-80,-25}}, color={0,0,255}));
        connect(resistor3.n, transformer.p3) annotation (Line(points={{-60,-25},{-50,-25},{-50,-11},{-40,-11}}, color={0,0,255}));
        connect(diode2.n, diode1.p) annotation (Line(points={{30,-20},{30,10}}, color={0,0,255}));
        connect(diode4.n, diode3.p) annotation (Line(points={{50,-20},{50,10}}, color={0,0,255}));
        connect(diode6.n, diode5.p) annotation (Line(points={{70,-20},{70,10}}, color={0,0,255}));
        connect(diode2.p, diode4.p) annotation (Line(points={{30,-40},{50,-40}}, color={0,0,255}));
        connect(diode4.p, diode6.p) annotation (Line(points={{50,-40},{70,-40}}, color={0,0,255}));
        connect(diode1.n, diode3.n) annotation (Line(points={{30,30},{50,30}}, color={0,0,255}));
        connect(diode3.n, diode5.n) annotation (Line(points={{50,30},{70,30}}, color={0,0,255}));
        connect(diode5.n, capacitor1.p) annotation (Line(points={{70,30},{90,30}}, color={0,0,255}));
        connect(resistorL.p, capacitor1.p) annotation (Line(points={{120,5},{120,30},{90,30}}, color={0,0,255}));
        connect(transformer.n1, inductor1.p) annotation (Line(points={{-20,1},{-10,1},{-10,14}}, color={0,0,255}));
        connect(transformer.n2, inductor2.p) annotation (Line(points={{-20,-5},{-10,-5}}, color={0,0,255}));
        connect(inductor2.n, diode3.p) annotation (Line(points={{10,-5},{50,-5},{50,10}}, color={0,0,255}));
        connect(inductor3.p, transformer.n3) annotation (Line(points={{-10,-25},{-10,-11},{-20,-11}}, color={0,0,255}));
        connect(inductor3.n, diode6.n) annotation (Line(points={{10,-25},{10,-10},{70,-10},{70,-20}}, color={0,0,255}));
        connect(capacitor2.n, diode6.p) annotation (Line(points={{90,-40},{70,-40}}, color={0,0,255}));
        connect(capacitor2.p, capacitor1.n) annotation (Line(points={{90,-20},{90,10}},color={0,0,255}));
        connect(inductor1.n, diode1.p) annotation (Line(points={{10,14},{10,0},{30,0},{30,10}}, color={0,0,255}));
        connect(resistorL.n, capacitor2.n) annotation (Line(points={{120,-15},{120,-40},{90,-40}}, color={0,0,255}));
        connect(transformer.starPoint1, ground1.p) annotation (Line(points={{-34,-15},{-34,-70},{-110,-70}}, color={0,0,255}));
        connect(transformer.starPoint2, ground2.p) annotation (Line(points={{-26,-15},{-26,-70}}, color={0,0,255}));
        connect(ground2.p, capacitor2.p) annotation (Line(points={{-26,-70},{105,-70},{105,-4},{90,-4},{90,-20}}, color={0,0,255}));
        connect(rExp3.y,pdissCopAvg. u) annotation (Line(points={{-79.4,45},{-51,45}}, color={0,0,127}));
        connect(rExp2.y,pdissEddyAvg. u) annotation (Line(points={{-79.4,65},{-51,65}}, color={0,0,127}));
        connect(rExp1.y,pdissStatAvg. u) annotation (Line(points={{-80.45,85},{-51,85}}, color={0,0,127}));
        annotation (experiment(StartTime=0, StopTime=0.2, Interval=1e-4, Tolerance=1e-006), Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-150,-100},{150,100}},
              grid={1,1})), Documentation(info="<html>
<p>
This is a model of a three-phase transformer and rectifier unit using the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis.Components.Transformer3PhaseYyWithHysteresis\">Transformer3PhaseYyWithHysteresis</a> model. Use the following simulation settings:
</p>

<ul>
  <li>Stop time: 0.2 s</li>
  <li>Number of intervals: 5000</li>
  <li>Tolerance: 1e-6</li>
</ul>

<p>
An example simulation shows the transformer inrush currents due to an initially magnetized transformer core.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 1:</strong> Transformer inrush currents due to initial magnetization of the magnetic core; (a) transformer primary currents; (b)  transformer secondary currents; (c) flux densities of the transformer legs; (d) B(H) hysteresis loops of transformer leg one.; (e) instantaneous static hysteresis, eddy current and copper losses of the transformer; (f) approximated average static hysteresis, eddy current and copper losses of the transformer</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/ThreePhaseTransformerWithRectifier/plot01.png\" hspace=\"10\" vspace=\"10\">
    </td>
  </tr>
</table>
</html>"));
      end ThreePhaseTransformerWithRectifier;

      package Components "Components to be used in examples"
        extends Modelica.Icons.Package;

        model Transformer1PhaseWithHysteresis
          "Single Phase transformer with ferromagnetic core and hysteresis"

          Modelica.Electrical.Analog.Interfaces.NegativePin n1 "Negative pin of primary winding" annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), iconTransformation(extent={{-110,-110},{-90,-90}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin p1 "Positive pin of primary winding" annotation (Placement(transformation(extent={{-110,90},{-90,110}}), iconTransformation(extent={{-110,90},{-90,110}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin n2 "Negative pin of secondary winding" annotation (Placement(transformation(extent={{90,-110},{110,-90}}), iconTransformation(extent={{90,-110},{110,-90}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin p2 "Positive pin of secondary winding" annotation (Placement(transformation(extent={{90,90},{110,110}}), iconTransformation(extent={{90,90},{110,110}})));

          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempSource annotation (Placement(transformation(extent={{-94,-54},{-86,-46}})));

          // Tab: Electrical //Group:Primary Winding
          parameter Integer N1=10 "Primary turns"
            annotation(Dialog(tab="Electrical", group="Primary Winding"));
          parameter SI.Length L1(displayUnit="mm") = 1.2*2*(a+b)
            "Mean primary turn length"
            annotation(Dialog(tab="Electrical", group="Primary Winding"));
          parameter SI.Length d1(displayUnit="mm") = 0.5e-3
            "Wire diameter of primary turns"
            annotation(Dialog(tab="Electrical", group="Primary Winding"));
          parameter SI.Resistivity rho1 = 1.678e-8
            "Resistivity of primary winding (at 20degC)"
            annotation(Dialog(tab="Electrical", group="Primary Winding"));
          parameter SI.LinearTemperatureCoefficient alpha1 = 0
            "Temperature coefficient of primary turns" annotation(Dialog(tab="Electrical", group="Primary Winding"));

          // Tab: Electrical //Group:Secondary Winding
          parameter Integer N2=10 "Secondary turns"
            annotation(Dialog(tab="Electrical", group="Secondary Winding"));
          parameter SI.Length L2(displayUnit="mm") = L1
            "Mean secondary turn length"
            annotation(Dialog(tab="Electrical", group="Secondary Winding"));
          parameter SI.Length d2(displayUnit="mm") = d1
            "Wire diameter of secondary turns"
            annotation(Dialog(tab="Electrical", group="Secondary Winding"));
          parameter SI.Resistivity rho2 = rho1
            "Resistivity of secondary winding (at 20degC)"
            annotation(Dialog(tab="Electrical", group="Secondary Winding"));

          parameter SI.LinearTemperatureCoefficient alpha2 = alpha1
            "Temperature coefficient of secondary turns" annotation(Dialog(tab="Electrical", group="Secondary Winding"));

          parameter SI.Length l1(displayUnit="mm") = 40e-3
            "Mean Length l1 of core" annotation (Dialog(tab="Core", group="Geometry", groupImage="modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/Components/Transformer1PhaseWithHysteresis/Core_SinglePhase.png"));
          parameter SI.Length l2(displayUnit="mm") = 60e-3
            "Mean Length l2 of core" annotation (Dialog(tab="Core", group="Geometry"));
          parameter SI.Length a(displayUnit="mm") = 15e-3 "Height of core" annotation (Dialog(tab="Core", group="Geometry"));
          parameter SI.Length b(displayUnit="mm") = 10e-3 "Width of core" annotation (Dialog(tab="Core", group="Geometry"));

          //
          parameter FluxTubes.Material.HysteresisEverettParameter.BaseData mat=
              FluxTubes.Material.HysteresisEverettParameter.BaseData()
            "Parameter set of ferromagnetic Hysteresis" annotation (Dialog(tab="Core",
                group="Material"), choicesAllMatching=true);

          output SI.Voltage v1 "Primary voltage drop";
          output SI.Voltage v2 "secondary voltage drop";

          output SI.Resistance R1 "Primary resistance of Winding";
          output SI.Resistance R2 "Secondary resistance of Winding";

          output SI.Current i1 "Primary current";
          output SI.Current i2 "Secondary current";

          output SI.MagneticFluxDensity B "Magnetic Flux Density of Core";
          output SI.MagneticFieldStrength Hstat
            "Ferromagnetic portion of magnetic field strength";
          output SI.MagneticFieldStrength Heddy
            "Eddy current portion of magnetic field strength";
          output SI.MagneticFieldStrength H
            "Total magnetic field strength of core";

          //output SI.Resistance R1

          parameter Real MagRelStart=0 "Initial magnetization of Core (-1..1)"
            annotation (Dialog(tab="Core", group="Initialization"));
          parameter Boolean MagRelFixed = false "Fixed" annotation (Dialog(tab="Core", group="Initialization"),choices(checkBox=true));

          parameter SI.MagneticFieldStrength HStart=0
            "Initial magnetic field strength of Core"
            annotation (Dialog(tab="Core", group="Initialization"));
          parameter Boolean HFixed = false "Fixed"
            annotation (Dialog(tab="Core", group="Initialization"),choices(checkBox=true));
          parameter SI.ElectricCurrent I1Start=0
            "Initial primary current through winding" annotation (Dialog(tab="Core", group="Initialization"));
          parameter Boolean I1Fixed = false "Fixed" annotation (Dialog(tab="Core", group="Initialization"),choices(checkBox=true));

          output SI.Power LossPowerWinding "Winding losses";
          output SI.Power LossPowerStat "Ferromagnetic hysteresis losses";
          output SI.Power LossPowerEddy "Eddy current losses";

          extends Interfaces.ConditionalHeatPort;
          parameter Boolean EddyCurrents = false "Enable eddy currents"
            annotation(Dialog(tab="Losses and Heat", group="Eddy Currents"), choices(checkBox=true));
          parameter SI.Conductivity sigma = mat.sigma
            "Conductivity of core material" annotation (Dialog(tab="Losses and Heat", group="Eddy Currents", enable=EddyCurrents));
          parameter SI.Length t(displayUnit="mm") = 0.5e-3
            "Thickness of lamination" annotation (Dialog(tab="Losses and Heat", group="Eddy Currents", enable=EddyCurrents));
          parameter SI.Length L_l1=10e-3 "Length of leakage of primary Winding" annotation (Dialog(tab="Leakage"));
          parameter SI.Area A_l1=10e-6
            "Cross section of leakage of primary Winding" annotation (Dialog(tab="Leakage"));
          parameter Real mu_rel1=1
            "Constant relative permeability of primary leakage (>0 required)" annotation (Dialog(tab="Leakage"));
          parameter SI.Length L_l2=10e-3
            "Length of leakage of secondary Winding" annotation (Dialog(tab="Leakage"));
          parameter SI.Area A_l2=10e-6
            "Cross section of leakage of secondary Winding" annotation (Dialog(tab="Leakage"));
          parameter Real mu_rel2=1
            "Constant relative permeability of secondary leakage (>0 required)" annotation (Dialog(tab="Leakage"));

        protected
          Basic.Ground ground
            annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
          Basic.ElectroMagneticConverterWithLeakageInductance winding1(
            N=N1,
            L=L_l1,
            A=A_l1,
            mu_rel=mu_rel1,
            i(start=I1Start, fixed=I1Fixed)) annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
          Basic.ElectroMagneticConverterWithLeakageInductance winding2(
            N=N2,
            L=L_l2,
            mu_rel=mu_rel2,
            A=A_l2) annotation (Placement(transformation(extent={{60,-20},{40,0}})));

          Modelica.Electrical.Analog.Basic.Resistor resistor1(
            R=rho1*N1*L1/(pi/4*d1^2),
            useHeatPort=true,
            alpha=alpha1,
            T_ref=293.15) annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
          Modelica.Electrical.Analog.Basic.Resistor resistor2(
            R=rho2*N2*L2/(pi/4*d2^2),
            useHeatPort=true,
            alpha=alpha2,
            T_ref=293.15) annotation (Placement(transformation(extent={{70,-10},{90,10}})));

        public
          Shapes.HysteresisAndMagnets.GenericHystTellinenEverett core(
            mat=mat,
            l=2*(l1 + l2),
            A=a*b,
            includeEddyCurrents=EddyCurrents,
            sigma=sigma,
            d=t,
            H(start=HStart, fixed=HFixed),
            MagRel(start=MagRelStart, fixed=MagRelFixed))
            annotation (Placement(transformation(extent={{-10,0},{10,20}})));
        equation
          v1 =p1.v - n1.v;
          i1 =resistor1.i;
          R1 =resistor1.R_actual;

          v2 =p2.v - n2.v;
          i2 =resistor2.i;
          R2 =resistor2.R_actual;

          B =core.B;
          Hstat =core.Hstat;
          Heddy =core.Heddy;
          H =core.H;
          //der(MagRel)=0;

          tempSource.T = if useHeatPort then T_heatPort else T;

          LossPowerWinding =resistor1.LossPower + resistor2.LossPower;
                                                          //AvgWinding.y;
          LossPowerStat =core.LossPowerStat;
          LossPowerEddy =core.LossPowerEddy;
          LossPower = LossPowerWinding + LossPowerEddy + LossPowerStat;

          connect(winding1.port_n, ground.port) annotation (Line(points={{-40,-20},{-40,-30},{0,-30}}, color={255,127,0}));
          connect(resistor1.n, winding1.p) annotation (Line(points={{-70,0},{-60,0}}, color={0,0,255}));
          connect(resistor1.p, p1) annotation (Line(points={{-90,0},{-100,0},{-100,100}}, color={0,0,255}));
          connect(resistor2.n, p2) annotation (Line(points={{90,0},{100,0},{100,100}}, color={0,0,255}));
          connect(winding1.n, n1) annotation (Line(points={{-60,-19.8},{-60,-100},{-100,-100}}, color={0,0,255}));
          connect(tempSource.port, resistor1.heatPort) annotation (Line(points={{-86,-50},{-80,-50},{-80,-10}}, color={191,0,0}));
          connect(resistor2.heatPort, tempSource.port) annotation (Line(points={{80,-10},{80,-50},{-86,-50}}, color={191,0,0}));
          connect(winding2.port_n, ground.port) annotation (Line(points={{40,-20},{40,-30},{0,-30}}, color={255,127,0}));
          connect(winding2.n, resistor2.p) annotation (Line(points={{60,-19.8},{70,-19.8},{70,0}}, color={0,0,255}));
          connect(n2, winding2.p) annotation (Line(points={{100,-100},{94,-100},{94,20},{60,20},{60,0}}, color={0,0,255}));
          connect(core.port_p, winding1.port_p) annotation (Line(points={{-10,10},{-40,10},{-40,0}}, color={255,127,0}));
          connect(core.port_n, winding2.port_p) annotation (Line(points={{10,10},{40,10},{40,0}}, color={255,127,0}));
          annotation (defaultComponentName="transformer", Icon(graphics={
                Polygon(
                  points={{50,60},{30,40},{30,-40},{50,-60},{50,60}},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.VerticalCylinder),
                Polygon(
                  points={{-50,60},{-30,40},{-30,-40},{-50,-60},{-50,60}},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.VerticalCylinder),
                Rectangle(
                  extent={{-68,36},{-12,-36}},
                  lineColor={0,128,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={0,128,255}),
                Rectangle(
                  extent={{20,20},{60,-20}},
                  lineColor={128,0,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={128,0,255}),
                Text(
                  extent={{150,150},{-150,110}},
                  lineColor={0,0,255},
                  textString="%name"),
                Polygon(
                  points={{-10,60},{10,40},{10,-20},{-10,-40},{-10,60}},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.VerticalCylinder,
                  origin={10,-50},
                  rotation=90),
                Polygon(
                  points={{-10,20},{-30,0},{-30,-60},{-10,-80},{-10,-44.0625},{-10,20}},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.VerticalCylinder,
                  origin={-30,70},
                  rotation=90),
                Line(points={{-100,90},{-100,36},{-68,36}}, color={0,0,255}),
                Line(points={{-100,-90},{-100,-36},{-68,-36}}, color={0,0,255}),
                Line(points={{100,-90},{100,-20},{60,-20}}, color={0,0,255}),
                Line(points={{100,90},{100,20},{60,20}}, color={0,0,255})}),
            Documentation(info="<html>
<p>
Simple model of a single phase transformer with a primary and a secondary winding and a magnetic core. The core is modeled with <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenEverett\">GenericHystTellinenEverett</a> flux tube elements. Thus, this element considers static and dynamic hysteresis.
</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Sketch of the modelled transformer with magnetic core, primary and secondary winding</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/Components/Transformer1PhaseWithHysteresis/Core_SinglePhase.png\">
   </td>
  </tr>
</table>

</html>"));
        end Transformer1PhaseWithHysteresis;

        model Transformer3PhaseYyWithHysteresis
          "Three phase transformer in Yy configuration"

          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature Temp
            annotation (Placement(transformation(extent={{-166,14},{-154,26}})));

          // Tab: Electrical //Group:Primary Winding
          parameter Integer N1=10 "Primary turns"
            annotation(Dialog(tab="Electrical", group="Primary Winding"));
          parameter SI.Length L1(displayUnit="mm") = 1.2*2*(a+b)
            "Mean primary turn length"
            annotation(Dialog(tab="Electrical", group="Primary Winding"));
          parameter SI.Length d1(displayUnit="mm") = 0.5e-3
            "Wire diameter of primary turns"
            annotation(Dialog(tab="Electrical", group="Primary Winding"));
          parameter SI.Resistivity rho1 = 1.678e-8
            "Resistivity of primary winding (at 20degC)"
            annotation(Dialog(tab="Electrical", group="Primary Winding"));
          parameter SI.LinearTemperatureCoefficient alpha1 = 0
            "Temperature coefficient of primary turns" annotation(Dialog(tab="Electrical", group="Primary Winding"));

          // Tab: Electrical //Group:Secondary Winding
          parameter Integer N2=10 "Secondary turns"
             annotation(Dialog(tab="Electrical", group="Secondary Winding"));
          parameter SI.Length L2(displayUnit="mm") = L1
            "Mean secondary turn length"
            annotation(Dialog(tab="Electrical", group="Secondary Winding"));
          parameter SI.Length d2(displayUnit="mm") = d1
            "Wire diameter of secondary turns"
            annotation(Dialog(tab="Electrical", group="Secondary Winding"));
          parameter SI.Resistivity rho2 = rho1
            "Resistivity of secondary winding (at 20degC)"
            annotation(Dialog(tab="Electrical", group="Secondary Winding"));

          parameter SI.LinearTemperatureCoefficient alpha2 = alpha1
            "Temperature coefficient of secondary turns" annotation(Dialog(tab="Electrical", group="Secondary Winding"));

          parameter SI.Length l1(displayUnit="mm") = 40e-3
            "Mean length l1 of core" annotation (Dialog(tab="Core", group="Geometry", groupImage="modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/Components/Transformer3PhaseYyWithHysteresis/Core_ThreePhase1.png"));
          parameter SI.Length l2(displayUnit="mm") = 60e-3
            "Mean length l2 of core" annotation (Dialog(tab="Core", group="Geometry"));
          parameter SI.Length a(displayUnit="mm") = 15e-3 "Height of core" annotation (Dialog(tab="Core", group="Geometry"));
          parameter SI.Length b(displayUnit="mm") = 10e-3 "Width of core" annotation (Dialog(tab="Core", group="Geometry"));

          parameter FluxTubes.Material.HysteresisEverettParameter.BaseData mat=
              FluxTubes.Material.HysteresisEverettParameter.BaseData()
            "Core Material" annotation (Dialog(tab="Core", group="Material"),
              choicesAllMatching=true);

          output SI.Voltage v1[3] "Voltage drop of primary winding 1-3";
          output SI.Voltage v2[3] "Voltage drop of secondary winding 1-3";

          output SI.Resistance R1[3] "Resistance of primary winding 1-3";
          output SI.Resistance R2[3] "Resistance of secondary winding 1-3";

          output SI.Current i1[3] "Current in primary winding 1-3";
          output SI.Current i2[3] "Current in secondary winding 1-3";

          output SI.MagneticFluxDensity B[3]
            "Magnetic Flux Density in core portions 1-3";
          output SI.MagneticFlux Phi[3]
            "Magnetic Flux through core portions 1-3";

          output SI.MagneticFieldStrength Hstat[3]
            "Ferromagnetic portion of magnetic field strength";
          output SI.MagneticFieldStrength Heddy[3]
            "Eddy current portion of magnetic field strength";
          output SI.MagneticFieldStrength H[3]
            "Total magnetic field strength of core";

          //output SI.Resistance R1

          parameter Real MagRelStart[3]={0,0,0}
            "Initial magnetization of Core (-1..1)" annotation (Dialog(tab="Core", group="Initialization"));
          parameter Boolean MagRelFixed[3] = {false,false,false} "Fixed" annotation (Dialog(tab="Core", group="Initialization"));

          parameter SI.MagneticFieldStrength HStart[3]={0,0,0}
            "Initial magnetic field strength of Core" annotation (Dialog(tab="Core", group="Initialization"));
          parameter Boolean HFixed[3] = {false,false,false} "Fixed" annotation (Dialog(tab="Core", group="Initialization"),choices(checkBox=true));

          parameter SI.ElectricCurrent I1Start[3]={0,0,0}
            "Initial current of primary Windings" annotation (Dialog(tab="Core", group="Initialization"));
          parameter Boolean I1Fixed[3] = {false,false,false} "Fixed" annotation (Dialog(tab="Core", group="Initialization"),choices(checkBox=true));

          parameter SI.ElectricCurrent I2Start[3]={0,0,0}
            "Initial current of secondary Windings" annotation (Dialog(tab="Core", group="Initialization"));
          parameter Boolean I2Fixed[3] = {false,false,false} "Fixed" annotation (Dialog(tab="Core", group="Initialization"),choices(checkBox=true));

          output SI.Power LossPowerWinding "Winding losses";
          output SI.Power LossPowerStat "Ferromagnetic hysteresis losses";
          output SI.Power LossPowerEddy "Eddy current losses";

          extends Interfaces.ConditionalHeatPort;
          parameter Boolean EddyCurrents = false "Enable eddy currents" annotation(Dialog(tab="Losses and Heat", group="Eddy Currents"), choices(checkBox=true));
          parameter SI.Conductivity sigma = mat.sigma
            "Conductivity of core material" annotation (Dialog(tab="Losses and Heat", group="Eddy Currents", enable=EddyCurrents));
          parameter SI.Length t(displayUnit="mm") = 0.5e-3
            "Thickness of lamination" annotation (Dialog(tab="Losses and Heat", group="Eddy Currents", enable=EddyCurrents));

          parameter SI.Length L_l1=10e-3 "Length of leakage of primary Winding" annotation (Dialog(tab="Leakage"));
          parameter SI.Area A_l1=10e-6
            "Cross section of leakage of primary Winding" annotation (Dialog(tab="Leakage"));
          parameter Real mu_rel1=1
            "Constant relative permeability of primary leakage (>0 required)" annotation (Dialog(tab="Leakage"));
          parameter SI.Length L_l2=10e-3
            "Cross section of leakage of secondary Winding" annotation (Dialog(tab="Leakage"));
          parameter SI.Area A_l2=10e-6 "Length of leakage of secondary Winding" annotation (Dialog(tab="Leakage"));
          parameter Real mu_rel2=1
            "Constant relative permeability of secondary leakage (>0 required)" annotation (Dialog(tab="Leakage"));

        protected
          Shapes.HysteresisAndMagnets.GenericHystTellinenEverett core1(
            mat=mat,
            A=a*b,
            sigma=sigma,
            d=t,
            useHeatPort=false,
            includeEddyCurrents=EddyCurrents,
            l=l1 + 2*l2,
            H(start=HStart[1], fixed=HFixed[1]),
            MagRel(start=MagRelStart[1], fixed=MagRelFixed[1])) annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                origin={-40,114})));
          Shapes.HysteresisAndMagnets.GenericHystTellinenEverett core2(
            mat=mat,
            A=a*b,
            sigma=sigma,
            d=t,
            useHeatPort=false,
            includeEddyCurrents=EddyCurrents,
            l=l2,
            H(start=HStart[2], fixed=HFixed[2]),
            MagRel(start=MagRelStart[2], fixed=MagRelFixed[2])) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={10,92})));

          Shapes.HysteresisAndMagnets.GenericHystTellinenEverett core3(
            mat=mat,
            A=a*b,
            includeEddyCurrents=EddyCurrents,
            sigma=sigma,
            d=t,
            l=l1 + 2*l2,
            H(start=HStart[3], fixed=HFixed[3]),
            MagRel(start=MagRelStart[3], fixed=MagRelFixed[3]))
            annotation (Placement(transformation(extent={{70,104},{90,124}})));

          Basic.Ground ground
            annotation (Placement(transformation(extent={{0,-80},{20,-60}})));

          Basic.ElectroMagneticConverterWithLeakageInductance winding11(
            N=N1,
            L=L_l1,
            A=A_l1,
            mu_rel=mu_rel1,
            i(start=I1Start[1], fixed=I1Fixed[1])) annotation (Placement(transformation(extent={{-110,40},{-90,60}})));

          Basic.ElectroMagneticConverterWithLeakageInductance winding12(
            L=L_l1,
            A=A_l1,
            mu_rel=mu_rel1,
            i(start=I1Start[2], fixed=I1Fixed[2]),
            final N=N1) annotation (Placement(transformation(extent={{-10,40},{10,60}})));

          Basic.ElectroMagneticConverterWithLeakageInductance winding13(
            N=N1,
            L=L_l1,
            A=A_l1,
            mu_rel=mu_rel1,
            i(start=I1Start[3], fixed=I1Fixed[3])) annotation (Placement(transformation(extent={{110,40},{130,60}})));

           Basic.ElectroMagneticConverterWithLeakageInductance winding21(
            N=N2,
            L=L_l2,
            A=A_l2,
            mu_rel=mu_rel2,
            i(start=I2Start[1], fixed=I2Fixed[1])) annotation (Placement(transformation(extent={{-110,-20},{-90,0}})));

           Basic.ElectroMagneticConverterWithLeakageInductance winding22(
            N=N2,
            L=L_l2,
            A=A_l2,
            mu_rel=mu_rel2,
            i(start=I2Start[1], fixed=I2Fixed[1])) annotation (Placement(transformation(extent={{-10,-20},{10,0}})));

          Basic.ElectroMagneticConverterWithLeakageInductance winding23(
            N=N2,
            L=L_l2,
            A=A_l2,
            mu_rel=mu_rel2,
            i(start=I2Start[1], fixed=I2Fixed[1])) annotation (Placement(transformation(extent={{110,-20},{130,0}})));

          Modelica.Electrical.Analog.Basic.Resistor resistor11(
            R=rho1*N1*L1/(pi/4*d1^2),
            useHeatPort=true,
            alpha=alpha1,
            T_ref=293.15) annotation (Placement(transformation(extent={{-140,50},{-120,70}})));
          Modelica.Electrical.Analog.Basic.Resistor resistor21(
            R=rho2*N2*L2/(pi/4*d2^2),
            useHeatPort=true,
            alpha=alpha2,
            T_ref=293.15) annotation (Placement(transformation(extent={{-120,-10},{-140,10}})));

          Modelica.Electrical.Analog.Basic.Resistor resistor12(
            R=rho1*N1*L1/(pi/4*d1^2),
            useHeatPort=true,
            alpha=alpha1,
            T_ref=293.15) annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
          Modelica.Electrical.Analog.Basic.Resistor resistor22(
            R=rho2*N2*L2/(pi/4*d2^2),
            useHeatPort=true,
            alpha=alpha2,
            T_ref=293.15) annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));

          Modelica.Electrical.Analog.Basic.Resistor resistor23(
            R=rho2*N2*L2/(pi/4*d2^2),
            useHeatPort=true,
            alpha=alpha2,
            T_ref=293.15) annotation (Placement(transformation(extent={{100,-10},{80,10}})));

          Modelica.Electrical.Analog.Basic.Resistor resistor13(
            R=rho1*N1*L1/(pi/4*d1^2),
            useHeatPort=true,
            alpha=alpha1,
            T_ref=293.15) annotation (Placement(transformation(extent={{80,50},{100,70}})));
          Shapes.FixedShape.Cuboid leakage(
            nonLinearPermeability=false,
            mu_rConst=1,
            l=l2,
            a=a,
            b=b/1000)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={32,90})));

        public
          Modelica.Electrical.Analog.Interfaces.PositivePin p1 "Primary winding 1" annotation (Placement(transformation(extent={{-170,50},{-150,70}}), iconTransformation(extent={{-110,50},{-90,70}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin p2 "Primary winding 2" annotation (Placement(transformation(extent={{-70,50},{-50,70}}), iconTransformation(extent={{-110,-10},{-90,10}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin p3 "Primary winding 3" annotation (Placement(transformation(extent={{50,50},{70,70}}), iconTransformation(extent={{-110,-70},{-90,-50}})));
          Electrical.Analog.Interfaces.NegativePin n1 "Secondary winding 1" annotation (Placement(transformation(extent={{-170,-10},{-150,10}}), iconTransformation(extent={{90,50},{110,70}})));
          Electrical.Analog.Interfaces.NegativePin n2 "Secondary winding 2" annotation (Placement(transformation(extent={{-70,-10},{-50,10}}), iconTransformation(extent={{90,-10},{110,10}})));
          Electrical.Analog.Interfaces.NegativePin n3 "Secondary winding 3" annotation (Placement(transformation(extent={{50,-10},{70,10}}), iconTransformation(extent={{90,-70},{110,-50}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin starPoint2 "Star point of secondary windings" annotation (Placement(transformation(extent={{-120,-44},{-100,-24}}), iconTransformation(extent={{30,-110},{50,-90}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin starPoint1 "Star point of primary windings" annotation (Placement(transformation(extent={{-120,20},{-100,40}}), iconTransformation(extent={{-50,-110},{-30,-90}})));

        equation
          v1[1] =resistor11.p.v - winding11.n.v;
          v1[2] =resistor12.p.v - winding12.n.v;
          v1[3] =resistor13.p.v - winding13.n.v;
          i1[1] =resistor11.i;
          i1[2] =resistor12.i;
          i1[3] =resistor13.i;
          R1[1] =resistor11.R_actual;
          R1[2] =resistor12.R_actual;
          R1[3] =resistor13.R_actual;

          v2[1] =resistor21.n.v - winding21.n.v;
          v2[2] =resistor21.n.v - winding21.n.v;
          v2[3] =resistor21.n.v - winding21.n.v;
          i2[1] =resistor21.i;
          i2[2] =resistor22.i;
          i2[3] =resistor23.i;
          R2[1] =resistor21.R_actual;
          R2[2] =resistor22.R_actual;
          R2[3] =resistor23.R_actual;

          B[1] =core1.B;
          B[2] =core2.B;
          B[3] =core3.B;

          Phi[1] =core1.Phi;
          Phi[2] =core2.Phi;
          Phi[3] =core3.Phi;

          Hstat[1] =core1.Hstat;
          Hstat[2] =core2.Hstat;
          Hstat[3] =core3.Hstat;
          Heddy[1] =core1.Heddy;
          Heddy[2] =core2.Heddy;
          Heddy[3] =core3.Heddy;
          H[1] =core1.H;
          H[2] =core2.H;
          H[3] =core3.H;

          Temp.T = if useHeatPort then T_heatPort else T;

          LossPowerWinding =resistor11.LossPower + resistor12.LossPower + resistor13.LossPower + resistor21.LossPower + resistor22.LossPower + resistor23.LossPower;
          LossPowerStat =core1.LossPowerStat  +core2.LossPowerStat  +core3.LossPowerStat;
          LossPowerEddy =core1.LossPowerEddy  +core2.LossPowerEddy  +core3.LossPowerEddy;
          LossPower = LossPowerWinding + LossPowerEddy + LossPowerStat;

          connect(winding11.port_n, winding21.port_p) annotation (Line(points={{-90,40},{-90,0}}, color={255,127,0}));
          connect(winding11.p, resistor11.n) annotation (Line(points={{-110,60},{-116,60},{-116,60},{-120,60}}, color={0,0,255}));
          connect(resistor11.p, p1) annotation (Line(points={{-140,60},{-160,60}}, color={0,0,255}));
          connect(winding12.p, resistor12.n) annotation (Line(points={{-10,60},{-16,60},{-16,60},{-20,60}}, color={0,0,255}));
          connect(winding13.p, resistor13.n) annotation (Line(points={{110,60},{104,60},{104,60},{100,60}}, color={0,0,255}));
          connect(winding12.port_p, core2.port_n) annotation (Line(points={{10,60},{10,82}}, color={255,127,0}));
          connect(winding12.port_n, winding22.port_p) annotation (Line(points={{10,40},{10,0}}, color={255,127,0}));
          connect(winding21.port_n, ground.port) annotation (Line(points={{-90,-20},{-90,-60},{10,-60}}, color={255,127,0}));
          connect(ground.port, winding22.port_n) annotation (Line(points={{10,-60},{10,-20}}, color={255,127,0}));
          connect(winding23.port_n, ground.port) annotation (Line(points={{130,-20},{130,-60},{10,-60}}, color={255,127,0}));
          connect(winding23.port_p, winding13.port_n) annotation (Line(points={{130,0},{130,40}}, color={255,127,0}));
          connect(winding13.port_p, core3.port_n) annotation (Line(points={{130,60},{130,114},{90,114}}, color={255,127,0}));
          connect(p2, resistor12.p) annotation (Line(points={{-60,60},{-40,60}}, color={0,0,255}));
          connect(p3, resistor13.p) annotation (Line(points={{60,60},{80,60}}, color={0,0,255}));
          connect(Temp.port, resistor11.heatPort) annotation (Line(points={{-154,20},{-130,20},{-130,50}}, color={191,0,0}));
          connect(resistor12.heatPort, Temp.port) annotation (Line(points={{-30,50},{-30,20},{-154,20}}, color={191,0,0}));
          connect(resistor13.heatPort, Temp.port) annotation (Line(points={{90,50},{90,20},{-154,20}}, color={191,0,0}));
          connect(resistor23.heatPort, Temp.port) annotation (Line(points={{90,-10},{46,-10},{46,20},{-154,20}}, color={191,0,0}));
          connect(resistor22.heatPort, Temp.port) annotation (Line(points={{-30,-10},{-80,-10},{-80,20},{-154,20}}, color={191,0,0}));
          connect(resistor21.heatPort, Temp.port) annotation (Line(points={{-130,-10},{-146,-10},{-146,20},{-154,20}}, color={191,0,0}));
          connect(resistor21.p, winding21.p) annotation (Line(points={{-120,0},{-110,0},{-110,0}}, color={0,0,255}));
          connect(resistor22.p, winding22.p) annotation (Line(points={{-20,0},{-10,0},{-10,0}}, color={0,0,255}));
          connect(resistor23.p, winding23.p) annotation (Line(points={{100,0},{110,0},{110,0}}, color={0,0,255}));
          connect(resistor21.n, n1) annotation (Line(points={{-140,0},{-160,0}}, color={0,0,255}));
          connect(resistor22.n, n2) annotation (Line(points={{-40,0},{-60,0}}, color={0,0,255}));
          connect(resistor23.n, n3) annotation (Line(points={{80,0},{60,0}}, color={0,0,255}));
          connect(leakage.port_n, ground.port) annotation (Line(
              points={{32,80},{32,-60},{10,-60}}, color={255,127,0}));
          connect(winding11.port_p, core1.port_n) annotation (Line(points={{-90,60},{-90,114},{-50,114}}, color={255,127,0}));
          connect(core1.port_p,core2. port_p) annotation (Line(
              points={{-30,114},{10,114},{10,102}}, color={255,127,0}));
          connect(core3.port_p,core1. port_p) annotation (Line(
              points={{70,114},{-30,114}}, color={255,127,0}));
          connect(leakage.port_p,core3. port_p) annotation (Line(
              points={{32,100},{32,114},{70,114}}, color={255,127,0}));

          connect(winding11.n, starPoint1) annotation (Line(points={{-110,40.2},{-110,30}}, color={0,0,255}));
          connect(starPoint1, winding13.n) annotation (Line(points={{-110,30},{110,30},{110,40.2}}, color={0,0,255}));
          connect(starPoint1, winding12.n) annotation (Line(points={{-110,30},{-10,30},{-10,40.2}}, color={0,0,255}));
          connect(winding21.n, starPoint2) annotation (Line(points={{-110,-19.8},{-110,-34}}, color={0,0,255}));
          connect(starPoint2, winding22.n) annotation (Line(points={{-110,-34},{-10,-34},{-10,-19.8}}, color={0,0,255}));
          connect(winding23.n, starPoint2) annotation (Line(points={{110,-19.8},{110,-34},{-110,-34}}, color={0,0,255}));

          annotation (defaultComponentName="transformer", Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-200,
                    -200},{200,200}})),     Icon(graphics={
                Polygon(
                  points={{70,60},{50,40},{50,-40},{70,-60},{70,60}},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.VerticalCylinder),
                Polygon(
                  points={{-70,60},{-50,40},{-50,-40},{-70,-60},{-70,60}},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.VerticalCylinder),
                Rectangle(
                  extent={{-74,36},{-46,-36}},
                  lineColor={128,0,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={128,0,255}),
                Text(
                  extent={{150,130},{-150,90}},
                  lineColor={0,0,255},
                  textString="%name"),
                Polygon(
                  points={{-20,10},{0,-10},{1.22465e-016,-50},{-10,-60},{-20,-60},{-20,10}},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.VerticalCylinder,
                  origin={-60,-40},
                  rotation=90),
                Polygon(
                  points={{-10,40},{0,50},{10,40},{10,-40},{0,-50},{-10,-40},{-10,40}},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.VerticalCylinder),
                Polygon(
                  points={{-20,-10},{0,10},{0,50},{-10,60},{-20,60},{-20,-10}},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.VerticalCylinder,
                  origin={60,-40},
                  rotation=90),
                Polygon(
                  points={{20,10},{0,-10},{0,-50},{10,-60},{20,-60},{20,10}},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.VerticalCylinder,
                  origin={-60,40},
                  rotation=90),
                Polygon(
                  points={{20,-10},{0,10},{0,50},{10,60},{20,60},{20,-10}},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.VerticalCylinder,
                  origin={60,40},
                  rotation=90),
                Rectangle(
                  extent={{-80,26},{-40,-26}},
                  lineColor={0,128,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={0,128,255}),
                Rectangle(
                  extent={{-14,36},{14,-36}},
                  lineColor={128,0,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={128,0,255}),
                Rectangle(
                  extent={{-20,26},{20,-26}},
                  lineColor={0,128,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={0,128,255}),
                Rectangle(
                  extent={{46,36},{74,-36}},
                  lineColor={128,0,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={128,0,255}),
                Rectangle(
                  extent={{40,26},{80,-26}},
                  lineColor={0,128,255},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={0,128,255})}),
            Documentation(info="<html>
<p>
Simple model of a three phase transformer with primary and a secondary windings and a magnetic E-I shaped core. The core is modeled with <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenEverett\">GenericHystTellinenEverett</a> flux tube elements. Thus, this model considers static and dynamic hysteresis as well as initial flux.
</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Sketch of the modelled transformer with magnetic core, primary and secondary winding</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/Components/Transformer3PhaseYyWithHysteresis/Core_ThreePhase1.png\">
   </td>
  </tr>
</table>
</html>"));
        end Transformer3PhaseYyWithHysteresis;
      end Components;

    end Hysteresis;

    package Utilities "Utilities to be used in examples"
      extends Modelica.Icons.UtilitiesPackage;

      model TranslatoryArmatureAndStopper
        "Mass with free travel between two stoppers"

        parameter SI.Length L(start=0)
          "Length of component from left flange to right flange (= flange_b.s - flange_a.s)";
        parameter SI.Mass m(start=1) "Armature mass";

        parameter Modelica.SIunits.TranslationalSpringConstant c(start=1e11)
          "Spring stiffness between impact partners";
        parameter Modelica.SIunits.TranslationalDampingConstant d(start=2e7)
          "Damping coefficient between impact partners";
        parameter Real n(final min=1) = 2
          "Exponent of spring forces (f_c = c*|s_rel|^n)"
          annotation (Evaluate=true);

        parameter SI.Position x_max(start=10e-3)
          "Position of stopper at maximum armature position";
        parameter SI.Position x_min(start=0)
          "Position of stopper at minimum armature position";
        Modelica.SIunits.Position s(start=0)
          "Absolute position of center of component (= flange_a.s + L/2)";
        Modelica.SIunits.Velocity v(start=0)
          "Absolute velocity of components (= der(s))";
        Modelica.SIunits.Acceleration a(start=0)
          "Absolute acceleration of components (= der(v))";
        Modelica.Mechanics.Translational.Components.Mass mass(final L=L, final
            m=m) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Mechanics.Translational.Components.Fixed limit_xMin(s0=x_min)
          annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
        Modelica.Mechanics.Translational.Components.Fixed limit_xMax(s0=x_max)
          annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
        Modelica.Mechanics.Translational.Components.ElastoGap stopper_xMax(
          final c=c,
          final d=d,
          final n=n,
          final s_rel0=0) annotation (Placement(transformation(extent={{50,-30},
                  {70,-10}})));
        Modelica.Mechanics.Translational.Components.ElastoGap stopper_xMin(
          final c=c,
          final d=d,
          final n=n,
          final s_rel0=0) annotation (Placement(transformation(extent={{-70,-30},
                  {-50,-10}})));

      equation
        mass.s = s;
        mass.v = v;
        mass.a = a;
        connect(mass.flange_a, stopper_xMin.flange_b) annotation (Line(points={
                {-10,0},{-40,0},{-40,-20},{-50,-20}}, color={0,127,0}));
        connect(limit_xMax.flange, stopper_xMax.flange_b)
          annotation (Line(points={{70,-40},{70,-20}}, color={0,191,0}));
        connect(stopper_xMax.flange_a, mass.flange_b) annotation (Line(points={
                {50,-20},{40,-20},{40,0},{10,0}}, color={0,127,0}));
        connect(mass.flange_a, flange_a) annotation (Line(points={{-10,0},{-32.5,
                0},{-55,0},{-100,0}}, color={0,127,0}));
        connect(limit_xMin.flange, stopper_xMin.flange_a)
          annotation (Line(points={{-70,-40},{-70,-20}}, color={0,127,0}));
        connect(flange_b, mass.flange_b)
          annotation (Line(points={{100,0},{10,0}}, color={0,127,0}));
        annotation (
          defaultComponentName="armature",
          Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}), graphics={Line(
                      points={{-80,-60},{-80,-80}},
                      color={160,160,164},
                      thickness=0.5),Line(
                      points={{-80,-76},{-40,-76}},
                      color={160,160,164},
                      thickness=0.5,
                      arrow={Arrow.None,Arrow.Filled}),Text(
                      extent={{-84,-82},{-76,-92}},
                      lineColor={160,160,164},
                      textString="0"),Text(
                      extent={{-46,-82},{-38,-92}},
                      lineColor={160,160,164},
                      textString="x"),Ellipse(
                      extent={{-82,-78},{-78,-74}},
                      lineColor={175,175,175},
                      fillColor={175,175,175},
                      fillPattern=FillPattern.Solid)}),
          Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-90,10},{90,-10}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={255,127,0}),
            Text(
              extent={{-120,140},{120,100}},
              lineColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-50,60},{50,-60}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={255,127,0}),
            Rectangle(
              extent={{-80,-20},{-88,-80}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{88,-20},{80,-80}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-80,80},{-88,20}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{88,80},{80,20}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-100,-100},{100,-140}},
              textString="m=%m"),
            Line(points={{-50,-80},{30,-80}}),
            Polygon(
              points={{60,-80},{30,-70},{30,-90},{60,-80}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>
<p>
In translatory actuators with limited stroke, the armature with its inertia can travel between two stoppers.
</p>
</html>"));
      end TranslatoryArmatureAndStopper;

      record CoilDesign
        "Calculation of winding parameters (wire diameter, number of turns et al.) and recalculation with optionally chosen parameters; to be adapted to particular design tasks"
        extends Modelica.Icons.Record;

        parameter SI.Resistivity rho_20=0.0178e-6
          "Resistivity of conductor material at 20 degC (default: Copper)";
        parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_20=0.0039
          "Temperature coefficient of conductor material's resistivity at 20 degC (default: Copper)";
        parameter SI.Temperature T_op=293.15 "Operating temperature of winding";

        final parameter SI.Resistivity rho=rho_20*(1 + alpha_20*(T_op - (20 -
            Modelica.Constants.T_zero))) "Resistivity at operating temperature";

        parameter SI.Length h_w "Height of winding cross-section";
        parameter SI.Length b_w "Width of winding cross-section";

        final parameter SI.Area A_w=h_w*b_w "Cross-section area of winding";

        parameter SI.Length l_avg "Average length of one turn";

        parameter SI.Voltage V_op
          "Operating voltage (nominal/ minimum/ maximum voltage depending on design objective)";

        parameter SI.CurrentDensity J_desired=4e6
          "DESIRED current density at operating temperature and voltage resp.";

        parameter Real c_condFillChosen=0.6
          "CHOSEN conductor filling factor = total conductor area without insulation/ total winding area";

        final parameter Real N_calculated=V_op/(rho*l_avg*J_desired)
          "CALCULATED number of turns";

        final parameter SI.Diameter d_wireCalculated=sqrt(4*A_w*
            c_condFillChosen/(pi*N_calculated))
          "CALCULATED wire diameter (without insulation)";

        final parameter SI.Area A_wireCalculated=pi*d_wireCalculated^2/4
          "Calculated wire cross-section area";

        final parameter SI.Resistance R_calculated=rho*N_calculated*l_avg/
            A_wireCalculated
          "Winding resistance at operating temperature and voltage resp. with CALCULATED number of turns and wire diameter";

        final parameter SI.Power P_calculated=V_op^2/R_calculated
          "Winding's ohmic losses at operating temperature and voltage resp. with CALCULATED number of turns and wire diameter";

        parameter SI.Diameter d_wireChosen=d_wireCalculated
          "CHOSEN available wire diameter (without insulation)"
          annotation (Dialog(group="Chosen feasible parameters (optional)"));

        parameter Real N_chosen=N_calculated "CHOSEN number of turns"
          annotation (Dialog(group="Chosen feasible parameters (optional)"));

        final parameter SI.Area A_wireChosen=pi*d_wireChosen^2/4
          "Wire cross-section area resulting from CHOSEN wire diameter";

        final parameter SI.Resistance R_actual=rho*N_chosen*l_avg/A_wireChosen
          "Winding resistance at operating temperature and voltage resp. resulting from CHOSEN number of turns and wire diameter";

        final parameter SI.Power P_actual=V_op^2/R_actual
          "Winding's ohmic losses at operating temperature and voltage resp. resulting from CHOSEN number of turns and wire diameter";

        final parameter SI.CurrentDensity J_actual=V_op*4/(R_actual*pi*
            d_wireChosen^2)
          "Current density at operating temperature and voltage resp. resulting from CHOSEN number of turns and wire diameter";

        final parameter Real c_condFillActual=N_chosen*pi*d_wireChosen^2/(4*A_w)
          "Conductor filling factor resulting from CHOSEN number of turns and wire diameter";

        annotation (Documentation(info="<html>
<p>
This model example shows dimensioning of a winding (wire diameter, number of turns) based on desired operating conditions (voltage, temperature, current density, conductor filling factor) for a given cross-section area of the winding. It can be modified according to the parameters given and sought after for a particular design project.
</p>

<p>
The calculated winding resistance and number of turns can be used as input parameters to the electrical subsystem
of a device to be modelled. Operating voltage V_op can be minimum, nominal and maximum voltage respectively as specified for a particular design project. In conjunction with the setting of the operating temperature T_op, this enables for analysis of the device under worst-case conditions (e.g., minimum required magnetomotive force, maximum allowed ohmic losses, minimum and maximum force respectively).
</p>

<p>
For manufacturing of a winding, the obtained wire diameter d_wireCalculated must be rounded to that of an available wire. In order to analyse the influence of this rounding, one can enter the chosen wire diameter d_wireChosen and number of turns N_chosen as optional input. Calculation of the resulting winding parameters enables for comparison with the ones obtained otherwise.
</p>
</html>"));

      end CoilDesign;
    end Utilities;
    annotation (Documentation(info="<html>
<p>
This package contains examples to demonstrate the usage of the flux tubes components.
</p>
</html>"));
  end Examples;

  package Basic "Basic elements of magnetic network models"
    extends Modelica.Icons.Package;

    model Ground "Zero magnetic potential"

      FluxTubes.Interfaces.PositiveMagneticPort port annotation (Placement(
            transformation(extent={{-10,110},{10,90}}, rotation=-0)));
    equation
      port.V_m = 0;
      annotation (
        Documentation(info="<html>
<p>
The magnetic potential at the magnetic ground node is zero. Every magnetic network model must contain at least one magnetic ground object.
</p>
</html>"),
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-60,50},{60,50}}, color={255,127,0}),
          Line(points={{-40,30},{40,30}}, color={255,127,0}),
          Line(points={{-20,10},{20,10}}, color={255,127,0}),
          Line(points={{0,90},{0,50}}, color={255,127,0}),
          Text(
            extent={{-150,-50},{150,-10}},
            lineColor={0,0,255},
            textString="%name")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={Line(
                  points={{-60,50},{60,50}},
                  color={255,127,0},
                  thickness=0.5),Line(
                  points={{-40,30},{40,30}},
                  color={255,127,0},
                  thickness=0.5),Line(
                  points={{-20,10},{20,10}},
                  color={255,127,0},
                  thickness=0.5),Line(
                  points={{0,100},{0,50}},
                  color={255,127,0},
                  thickness=0.5),Text(
                  extent={{-40,-40},{40,20}},
                  lineColor={0,0,255},
                  textString="port.V_m = 0")}));
    end Ground;

    model ElectroMagneticConverter "Ideal electro-magnetic energy conversion"

      FluxTubes.Interfaces.PositiveMagneticPort port_p "Positive magnetic port"
        annotation (Placement(transformation(extent={{90,90},{110,110}}), iconTransformation(extent={{90,90},{110,110}})));
      FluxTubes.Interfaces.NegativeMagneticPort port_n "Negative magnetic port"
        annotation (Placement(transformation(extent={{110,-110},{90,-90}}), iconTransformation(extent={{110,-110},{90,-90}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin p "Positive electrical pin"
        annotation (Placement(transformation(extent={{-90,90},{-110,110}}), iconTransformation(extent={{-90,90},{-110,110}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n "Negative electrical pin"
        annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), iconTransformation(extent={{-110,-110},{-90,-90}})));
      SI.Voltage v "Voltage";
      SI.Current i(start=0, stateSelect=StateSelect.prefer) "Current";
      SI.MagneticPotentialDifference V_m "Magnetic potential difference";
      SI.MagneticFlux Phi "Magnetic flux coupled into magnetic circuit";

      parameter Real N=1 "Number of turns";

      // For information only:
      SI.MagneticFlux Psi "Flux linkage";
      SI.Inductance L_stat "Static inductance abs(Psi/i)";

    protected
      Real eps=100*Modelica.Constants.eps;
    equation
      v = p.v - n.v;
      0 = p.i + n.i;
      i = p.i;

      V_m = port_p.V_m - port_n.V_m;
      0 = port_p.Phi + port_n.Phi;
      Phi = port_p.Phi;

      // Converter equations
      V_m = i*N "Ampere's law";
      N*der(Phi) = -v "Faraday's law";

      // For information only
      Psi = N*Phi;
      // Use of abs() for positive results; due to Modelica sign conventions for flow into connectors
      L_stat = noEvent(if abs(i) > eps then abs(Psi/i) else abs(Psi/eps));

      annotation (
        defaultComponentName="converter",
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={Polygon(
                  points={{-134,63},{-124,60},{-134,57},{-134,63}},
                  lineColor={160,160,164},
                  fillColor={160,160,164},
                  fillPattern=FillPattern.Solid),Line(points={{-150,60},{-125,
              60}}, color={160,160,164}),Polygon(
                  points={{141,-57},{151,-60},{141,-63},{141,-57}},
                  lineColor={160,160,164},
                  fillColor={160,160,164},
                  fillPattern=FillPattern.Solid),Line(points={{125,-60},{150,-60}},
              color={160,160,164}),Text(
                  extent={{128,-56},{144,-41}},
                  lineColor={160,160,164},
                  textString="Phi"),Text(
                  extent={{128,64},{145,79}},
                  textString="Phi"),Line(points={{-150,-59},{-125,-59}}, color=
              {160,160,164}),Polygon(
                  points={{-140,-56},{-150,-59},{-140,-62},{-140,-56}},
                  lineColor={160,160,164},
                  fillColor={160,160,164},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-141,-56},{-124,-41}},
                  lineColor={160,160,164},
                  textString="i"),Text(
                  extent={{-150,63},{-133,78}},
                  lineColor={160,160,164},
                  textString="i"),Line(points={{124,61},{149,61}}, color={160,160,164}),
              Polygon(
                  points={{134,64},{124,61},{134,58},{134,64}},
                  lineColor={160,160,164},
                  fillColor={160,160,164},
                  fillPattern=FillPattern.Solid)}),
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-150,150},{150,110}},
            lineColor={0,0,255},
            textString="%name"),
            Line(points={{-30,100},{-90,100}},
                                             color={0,0,255}),
            Line(points={{-30,-100},{-90,-100}},
                                               color={0,0,255}),
            Line(
              points={{0,80},{-100,80}},
              color={0,0,255},
              pattern=LinePattern.Dash),
            Line(
              points={{-100,80},{-100,-80}},
              color={0,0,255},
              pattern=LinePattern.Dash),
            Line(
              points={{0,-80},{-100,-80}},
              color={0,0,255},
              pattern=LinePattern.Dash),
            Line(
              points={{100,80},{0,80}},
              color={255,127,0},
              pattern=LinePattern.Dash),
            Line(
              points={{100,-80},{0,-80}},
              color={255,127,0},
              pattern=LinePattern.Dash),
            Line(
              points={{100,80},{100,-80}},
              color={255,127,0},
              pattern=LinePattern.Dash),
            Ellipse(extent={{-4,-34},{64,34}}, lineColor={255,127,0}),
            Line(points={{30,-100},{30,-34}},color={255,127,0}),
            Line(points={{18,0},{42,0}}, color={255,127,0}),
            Line(points={{42,10},{42,-12}}, color={255,127,0}),
            Line(points={{30,34},{30,100}},color={255,127,0}),
            Line(points={{30,100},{90,100}},color={255,127,0}),
            Line(points={{30,-100},{90,-100}},
                                             color={255,127,0}),
            Text(
              extent={{-150,150},{150,110}},
              lineColor={0,0,255},
              textString="%name"),
            Line(points={{18,10},{18,-12}}, color={255,127,0}),
            Line(points={{-110,30},{-110,-30}},
                                              color={0,0,255}),
            Polygon(
              points={{-110,-30},{-104,-10},{-116,-10},{-110,-30}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Line(points={{110,32},{110,-28}}, color={255,128,0}),
            Polygon(
              points={{110,-28},{116,-8},{104,-8},{110,-28}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-23,45},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-23,15},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-23,-15},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-23,-45},
              rotation=270),
            Line(points={{-30,60},{-30,100}}, color={28,108,200}),
            Line(points={{-30,-100},{-30,-60}}, color={28,108,200})}),
        Documentation(info="<html>
<p>
The electro-magnetic energy conversion is given by <em>Ampere</em>'s law and <em>Faraday</em>'s law respectively:
</p>

<pre>
    V_m = i * N
    N * d&Phi;/dt = -v
</pre>

<p>
V_m is the magnetomotive force that is supplied to the connected magnetic circuit, &Phi; is the magnetic flux through the associated branch of this magnetic circuit. The negative sign of the induced voltage v is due to <em>Lenz</em>'s law.
</p>

<p>
The flux linkage &Psi; and the static inductance L_stat = |&Psi;/i| are calculated for information only. Note that L_stat is set to |&Psi;/eps| if |i| &lt; eps
(= 100*Modelica.Constants.eps).
</p>
</html>"));
    end ElectroMagneticConverter;

    model ElectroMagneticConverterWithLeakageInductance
      "Electro-magnetic energy conversion with a leakage inductance"

      Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_p "Positive magnetic port"
        annotation (Placement(transformation(extent={{90,90},{110,110}}), iconTransformation(extent={{90,90},{110,110}})));
      Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort port_n "Negative magnetic port"
        annotation (Placement(transformation(extent={{110,-110},{90,-90}}), iconTransformation(extent={{110,-110},{90,-90}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin p "Positive electrical pin"
        annotation (Placement(transformation(extent={{-90,90},{-110,110}}), iconTransformation(extent={{-90,90},{-110,110}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n "Negative electrical pin"
        annotation (Placement(transformation(extent={{-110,-108},{-90,-88}}), iconTransformation(extent={{-110,-108},{-90,-88}})));
      SI.Voltage v "Voltage";
      SI.Current i(start=0, stateSelect=StateSelect.prefer) "Current";
      SI.MagneticPotentialDifference V_m "Magnetic potential difference";
      SI.MagneticFlux Phi(stateSelect=StateSelect.never)
        "Total Magnetic flux coupled into magnetic circuit (= Phi_ind + Phi_leak)";
      SI.MagneticFlux Phi_ind(stateSelect=StateSelect.never)
        "Magnetic flux of converter";
      SI.MagneticFlux Phi_leak(stateSelect=StateSelect.never)
        "Magnetic flux of leakage inductance";
      parameter Real N(start=1, min=Modelica.Constants.eps) "Number of turns";

      parameter SI.Length L=10e-3 "Length in direction of flux"
        annotation (Dialog(tab="LeakageInductance"));
      parameter SI.Area A=10e-6 "Area of cross-section"
        annotation (Dialog(tab="LeakageInductance"));
      parameter SI.RelativePermeability mu_rel(min=Modelica.Constants.eps) = 1
        "Constant relative permeability of leakage inductance (> 0 required)"
        annotation (Dialog(tab="LeakageInductance"));
      final parameter SI.Permeance G_m=Modelica.Constants.mue_0*mu_rel*A/L
        "Magnetic permeance of leakage inductance";

      // For information only
      SI.MagneticFlux Psi "Flux linkage";
      SI.Inductance L_stat "Static inductance abs(Psi/i)";

    protected
      constant Real eps=100*Modelica.Constants.eps;
    equation
      v = p.v - n.v;
      0 = p.i + n.i;
      i = p.i;

      V_m = port_p.V_m - port_n.V_m;
      0 = port_p.Phi + port_n.Phi;
      Phi = port_p.Phi;

      // Converter equations
      V_m = i*N "Ampere's law";
      N*der(Phi_ind) = -v "Faraday's law";

      // Leakage equations
      Phi_leak = G_m*V_m;
      Phi = Phi_ind + Phi_leak;

      // For information only
      Psi = N*Phi_ind;
      //use of abs() for positive results; due to Modelica sign conventions for flow into connectors
      L_stat = noEvent(if abs(i) > eps then abs(Psi/i) else abs(Psi/eps));

      annotation (
        defaultComponentName="converter",
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Polygon(
              points={{-134,63},{-124,60},{-134,57},{-134,63}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Line(points={{-150,60},{-125,60}}, color={160,160,164}),
            Polygon(
              points={{141,-57},{151,-60},{141,-63},{141,-57}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Line(points={{125,-60},{150,-60}}, color={160,160,164}),
            Text(
              extent={{128,-56},{144,-41}},
              lineColor={160,160,164},
              textString="Phi"),
            Text(
              extent={{128,64},{145,79}},
              textString="Phi"),
            Line(points={{-150,-59},{-125,-59}}, color={160,160,164}),
            Polygon(
              points={{-140,-56},{-150,-59},{-140,-62},{-140,-56}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-141,-56},{-124,-41}},
              lineColor={160,160,164},
              textString="i"),
            Text(
              extent={{-150,63},{-133,78}},
              lineColor={160,160,164},
              textString="i"),
            Line(points={{124,61},{149,61}}, color={160,160,164}),
            Polygon(
              points={{134,64},{124,61},{134,58},{134,64}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid)}),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Line(points={{-30,100},{-90,100}},
                                             color={0,0,255}),
            Line(points={{-30,-100},{-90,-100}},
                                               color={0,0,255}),
            Line(
              points={{0,80},{-100,80}},
              color={0,0,255},
              pattern=LinePattern.Dash),
            Line(
              points={{-100,80},{-100,-80}},
              color={0,0,255},
              pattern=LinePattern.Dash),
            Line(
              points={{0,-80},{-100,-80}},
              color={0,0,255},
              pattern=LinePattern.Dash),
            Line(
              points={{100,80},{0,80}},
              color={255,127,0},
              pattern=LinePattern.Dash),
            Line(
              points={{100,-80},{0,-80}},
              color={255,127,0},
              pattern=LinePattern.Dash),
            Line(
              points={{100,80},{100,-80}},
              color={255,127,0},
              pattern=LinePattern.Dash),
            Ellipse(extent={{-4,-34},{64,34}}, lineColor={255,127,0}),
            Line(points={{30,-100},{30,-34}},color={255,127,0}),
            Line(points={{18,0},{42,0}}, color={255,127,0}),
            Line(points={{42,10},{42,-12}}, color={255,127,0}),
            Line(points={{30,34},{30,100}},color={255,127,0}),
            Line(points={{30,100},{90,100}},color={255,127,0}),
            Line(points={{30,-100},{90,-100}},
                                             color={255,127,0}),
            Text(
              extent={{-150,150},{150,110}},
              lineColor={0,0,255},
              textString="%name"),
            Line(points={{18,10},{18,-12}}, color={255,127,0}),
            Line(points={{-110,30},{-110,-30}},
                                              color={0,0,255}),
            Polygon(
              points={{-110,-30},{-104,-10},{-116,-10},{-110,-30}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Line(points={{110,32},{110,-28}}, color={255,128,0}),
            Polygon(
              points={{110,-28},{116,-8},{104,-8},{110,-28}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{72,28},{88,-24}},
              lineColor={255,128,0},
              fillPattern=FillPattern.Solid,
              fillColor={255,255,255}),
            Line(
              points={{80,28},{80,100}},
              color={255,128,0}),
            Line(
              points={{80,-24},{80,-100}},
              color={255,128,0}),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-23,45},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-23,15},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-23,-15},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-23,-45},
              rotation=270),
            Line(points={{-30,60},{-30,100}}, color={28,108,200}),
            Line(points={{-30,-100},{-30,-60}}, color={28,108,200})}),
        Documentation(info="<html>
<p>
Same as <a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter\">ElectroMagneticConverter</a> with an additional leakage path on the magnetic side (leakage inductance, leakage flux). This model may improve stability especially when the magnetic circuit contains more than one electro-magnetic converter.
</p>
</html>"));
    end ElectroMagneticConverterWithLeakageInductance;

    model ConstantReluctance "Constant reluctance"

      extends FluxTubes.Interfaces.PartialTwoPorts;

      parameter SI.Reluctance R_m=1 "Magnetic reluctance";

    equation
      V_m = Phi*R_m;

      annotation (defaultComponentName="reluctance", Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={255,128,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-70,0},{-90,0}}, color={255,128,0}),
          Line(points={{70,0},{90,0}}, color={255,128,0}),
            Text(
              extent={{-150,50},{150,90}},
              lineColor={0,0,255},
              textString="%name")}),Documentation(info="<html>
<p>
This constant reluctance is provided for test purposes and simple magnetic network models. The reluctance is not calculated from geometry and permeability of a flux tube, but is provided as parameter.
</p>
</html>"));
    end ConstantReluctance;

    model ConstantPermeance "Constant permeance"

      extends FluxTubes.Interfaces.PartialTwoPorts;

      parameter SI.Permeance G_m=1 "Magnetic permeance";

    equation
      G_m * V_m = Phi;

      annotation (defaultComponentName="permeance", Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={255,128,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-70,0},{-90,0}}, color={255,128,0}),
          Line(points={{70,0},{90,0}}, color={255,128,0}),
            Text(
              extent={{-150,50},{150,90}},
              lineColor={0,0,255},
              textString="%name")}),Documentation(info="<html>
<p>
This constant permeance is provided for test purposes and simple magnetic network models. The permeance is not calculated from geometry and permeability of a flux tube, but is provided as parameter.
</p>
</html>", revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian Kral)</h5>
<ul>
<li>Added constant permeance model</li>
</ul>

</html>"));
    end ConstantPermeance;

    model LeakageWithCoefficient
      "Leakage reluctance with respect to the reluctance of a useful flux path (not for dynamic simulation of actuators)"

      extends FluxTubes.Interfaces.PartialLeakage;

      parameter SI.CouplingCoefficient c_usefulFlux=0.7
        "Ratio useful flux/(leakage flux + useful flux) = useful flux/total flux";

      input SI.Reluctance R_mUsefulTot
        "Total reluctance of useful flux path as reference" annotation (Dialog(
            group="Reference reluctance", groupImage=
              "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Basic/LeakageWithCoefficient.png"));

    equation
      (1 - c_usefulFlux)*R_m = c_usefulFlux*R_mUsefulTot;
      // Generalized Kirchhoff's current law

      annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Differently from the flux tube elements of package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a>
that are calculated from their geometry, this leakage reluctance is calculated with reference to the total reluctance of a useful flux path. Please refer to the <strong>Parameters</strong> section for an illustration of the resulting magnetic network. Exploiting <em>Kirchhoff</em>'s generalized current law, the leakage reluctance is calculated by means of a coupling coefficient c_usefulFlux.
</p>

<h4>Attention:</h4>

<p>
This element must <strong>not</strong> be used <strong>for dynamic simulation of</strong> electro-magneto-mechanical <strong>actuators</strong>, where the shape of at least one flux tube element with reluctance force generation in the useful flux path changes with armature motion (e.g., air gap). This change results in a non-zero derivative dG_m/dx of those elements permeance G_m with respect to armature position x, which in turn will lead to a non-zero derivative of the leakage permeance with respect to armature position. This would generate a reluctance force in the leakage element that is not accounted for properly. <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force.LeakageAroundPoles\">Shapes.Force.LeakageAroundPoles</a> provides a simple leakage reluctance with force generation.
</p>
</html>"));
    end LeakageWithCoefficient;

    model EddyCurrent
      "For modelling of eddy current in a conductive magnetic flux tube"

      extends FluxTubes.Interfaces.PartialTwoPorts;
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(
        final T=273.15);

      parameter Boolean useConductance = false
        "Use conductance instead of geometry data and rho"
        annotation(Evaluate=true, choices(checkBox=true));
      parameter Modelica.SIunits.Conductance G(min=0) = 1/0.098e-6
        "Equivalent loss conductance G=A/rho/l"
        annotation(Dialog(enable=useConductance),Evaluate=true);
      parameter SI.Resistivity rho=0.098e-6
        "Resistivity of flux tube material (default: Iron at 20degC)"
        annotation(Dialog(enable=not useConductance));
      parameter SI.Length l=1 "Average length of eddy current path"
        annotation(Dialog(enable=not useConductance));
      parameter SI.Area A=1 "Cross sectional area of eddy current path"
        annotation(Dialog(enable=not useConductance));

      final parameter SI.Resistance R=rho*l/A
        "Electrical resistance of eddy current path"
        annotation(Dialog(enable=not useConductance));

    equation
      LossPower = V_m*der(Phi);
      V_m =(if useConductance then G else 1/R) * der(Phi);
      //Magnetic voltage drop in magnetic network due to eddy current
      annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={255,128,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-70,0},{-90,0}}, color={255,128,0}),
          Line(points={{70,0},{90,0}}, color={255,128,0}),
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={255,128,0},
            fillColor={255,128,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255})}), Documentation(info="<html>
<p>
Eddy currents are induced in a conductive magnetic flux tube when the flux changes with time. This causes a magnetic voltage drop in addition to the voltage drop that is due to the reluctance of this flux tube. The eddy current component can be thought of as a short-circuited secondary winding of a transformer with only one turn. Its resistance is calculated from the geometry and resistivity of the eddy current path.
</p>

<p>
Partitioning of a solid conductive cylinder or prism into several hollow cylinders or separate nested prisms and modelling of each of these flux tubes connected in parallel with a series connection of a reluctance element and an eddy current component can model the delayed buildup of the magnetic field in the complete flux tube from the outer to the inner sections. Please refer to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ka08]</a> for an illustration.
</p>
</html>",     revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian&nbsp;Kral)</h5>
<ul>
<li>Added parameter <code>useConductance</code> including alternative parameterization</li>
</ul>
</html>"));
    end EddyCurrent;

    model Idle "Idle running branch"
      extends FluxTubes.Interfaces.PartialTwoPorts;
    equation
      Phi = 0;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,50},{150,90}},
              lineColor={0,0,255},
              textString="%name"),
            Line(points={{-100,0},{-40,0}}, color={255,128,0}),
            Line(points={{40,0},{100,0}}, color={255,128,0})}),
        Documentation(info="<html>
<p>
This is a simple idle running branch.
</p>


</html>", revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian Kral)</h5>
<ul>
<li>Added idle model</li>
</ul>

</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{-100,0},{-60,0}}, color={
              255,128,0}),Line(points={{60,0},{100,0}}, color={255,128,0}),Line(
              points={{-60,0},{-40,2},{-18,6},{0,14},{12,26}}, color={255,128,0}),
              Line(points={{60,0},{40,-2},{18,-6},{0,-14},{-12,-26}}, color={
              255,128,0})}));
    end Idle;

    model Short "Short cut branch"
      extends FluxTubes.Interfaces.PartialTwoPortsElementary;
    equation
      connect(port_p, port_n) annotation (Line(points={{-100,0},{-1,0},{-1,0},{
              100,0}}, color={255,128,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-100,0},{100,0}}, color={255,128,0}),
            Text(
              extent={{-150,50},{150,90}},
              lineColor={0,0,255},
              textString="%name")}),                              Documentation(
            info="<html>
<p>
This is a simple short cut branch.
</p>

</html>",     revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian Kral)</h5>
<ul>
<li>Added short model</li>
</ul>

</html>"));
    end Short;

    model Crossing "Crossing of two branches"

      FluxTubes.Interfaces.PositiveMagneticPort port_p1
        "Positive port_p1 connected with port_p2"
        annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
      FluxTubes.Interfaces.PositiveMagneticPort port_p2
        "Positive port_p2 connected with port_p1"
        annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
      FluxTubes.Interfaces.NegativeMagneticPort port_n1
        "Negative port_n1 connected with port_n2"
        annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
      FluxTubes.Interfaces.NegativeMagneticPort port_n2
        "Negative port_n2 connected with port_n1"
        annotation (Placement(transformation(extent={{90,90},{110,110}})));

    equation
      connect(port_p1, port_p2) annotation (Line(
          points={{-100,100},{-100,20},{0,20},{0,-20},{100,-20},{100,-100}}, color={255,128,0}));
      connect(port_n1, port_n2) annotation (Line(
          points={{-100,-100},{-100,0},{100,0},{100,100}}, color={255,128,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
          Line(
              points={{100,100},{40,100},{-40,-100},{-100,-100}},
              color={255,128,0}),
          Line(
              points={{-100,100},{-40,100},{40,-100},{100,-100}},
              color={255,128,0}),
            Text(
              extent={{-150,110},{150,150}},
              lineColor={0,0,255},
              textString="%name")}),Documentation(
            info="<html>
<p>
This is a simple crossing of two branches. The ports <code>port_p1</code> and <code>port_p2</code> are connected, as well as <code>port_n1</code> and <code>port_n2</code>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Idle\">Idle</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Short</a>
</p>

</html>", revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian Kral)</h5>
<ul>
<li>Added crossing model</li>
</ul>

</html>"));
    end Crossing;
  end Basic;

  package Shapes
    "Reluctance and permeance elements respectively based on geometric shapes"
    extends Modelica.Icons.Package;

    package FixedShape
      "Flux tubes with fixed shape during simulation and linear or non-linear material characteristics"
      extends Modelica.Icons.VariantsPackage;

      model GenericFluxTube
        "Flux tube with fixed cross-section and length; linear or non-linear material characteristics"

        extends FluxTubes.Interfaces.PartialFixedShape;

        parameter SI.Length l=0.01 "Length in direction of flux"
          annotation(Dialog(group="Fixed geometry", groupImage=
            "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/GenericFluxTube.png"));
        parameter SI.CrossSection area=0.0001 "Area of cross section"
          annotation (Dialog(group="Fixed geometry"));
      equation
        A=area;
        G_m = (mu_0*mu_r*A)/l;

        annotation (defaultComponentName="generic", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">FixedShape</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>", revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian&nbsp;Kral)</h5>
<ul>
<li>Added GenericFluxTube</li>
</ul>

</html>"));
      end GenericFluxTube;

      model Cuboid
        "Flux tube with rectangular cross-section; fixed shape; linear or non-linear material characteristics"

        extends FluxTubes.Interfaces.PartialFixedShape;

        parameter SI.Length l=0.01 "Length in direction of flux" annotation (
            Dialog(group="Fixed geometry", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/CuboidParallelFlux.png"));
        parameter SI.Length a=0.01 "Width of rectangular cross-section"
          annotation (Dialog(group="Fixed geometry"));
        parameter SI.Length b=0.01 "Height of rectangular cross-section"
          annotation (Dialog(group="Fixed geometry"));

      equation
        A = a*b;
        G_m = (mu_0*mu_r*A)/l;

        annotation (Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">FixedShape</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end Cuboid;

      model HollowCylinderAxialFlux
        "(Hollow) cylinder with axial flux; fixed shape; linear or non-linear material characteristics"

        extends FluxTubes.Interfaces.PartialFixedShape;

        parameter SI.Length l=0.01 "Axial length (in direction of flux)"
          annotation (Dialog(group="Fixed geometry", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderAxialFlux.png"));
        parameter SI.Radius r_i=0
          "Inner radius of hollow cylinder (zero for cylinder)"
          annotation (Dialog(group="Fixed geometry"));
        parameter SI.Radius r_o=0.01 "Outer radius of (hollow) cylinder"
          annotation (Dialog(group="Fixed geometry"));

      equation
        A = pi*(r_o^2 - r_i^2);
        G_m = (mu_0*mu_r*A)/l;

        annotation (defaultComponentName="cylinder", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">FixedShape</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>

<p>
Set the inner radius r_i=0 for modelling of a solid cylindric flux tube.
</p>
</html>"));
      end HollowCylinderAxialFlux;

      model HollowCylinderRadialFlux
        "Hollow cylinder with radial flux; fixed shape; linear or non-linear material characteristics"

        extends FluxTubes.Interfaces.PartialFixedShape;

        parameter SI.Length l=0.01 "Width (orthogonal to flux direction)"
                                                 annotation (Dialog(group=
                "Fixed geometry", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderRadialFlux.png"));
        parameter SI.Radius r_i=0.01 "Inner radius of hollow cylinder"
          annotation (Dialog(group="Fixed geometry"));
        parameter SI.Radius r_o=0.02 "Outer radius of hollow cylinder"
          annotation (Dialog(group="Fixed geometry"));

      equation
        A = l*pi*(r_o + r_i);
        // Area at arithmetic mean radius for calculation of average flux density
        G_m = 2*pi*mu_0*mu_r*l/Modelica.Math.log(r_o/r_i);

        annotation (defaultComponentName="cylinder", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">FixedShape</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>

<p>
For hollow cylindric flux tubes with a radial magnetic flux, the flux density is a function of the radius. For that reason, the characteristic mu_r(B) is evaluated for the flux density at the flux tube's mean radius.
</p>

<p>
For those flux tube sections of a magnetic device that have a nonlinear material characteristic mu_r(B) and a large aspect ratio of outer to inner radius r_o/r_i, the section can be split up in a series connection of several hollow cylindric flux tubes with radial flux. This allows for more realistic modelling of the dependence of flux density on the radius compared to modelling with just one flux tube element.
</p>
</html>"));
      end HollowCylinderRadialFlux;

      annotation (Documentation(info="<html>
<p>
Please have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.ReluctanceForceCalculation\">UsersGuide.ReluctanceForceCalculation</a> for an explanation of the different flux tube categories and resulting sub-packages.
</p>

<p>
Due to the restrictions on reluctance force calculation outlined there, flux tube elements with a possibly non-linear material characteristic mu_r(B) must have a fixed shape during simulation of converter motion. Hence, the dimensions of these flux tubes are defined as parameters in the model components that extend the base class <a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.PartialFixedShape\">Interfaces.PartialFixedShape</a>.</p>

<p>
For initial design of magnetic circuits, the relative permeability of possibly non-linear flux tube elements can easily be set to a constant value mu_rConst (non-linearPermeability set to false). In some cases, this can simplify the rough geometric design of a device's magnetic circuit. Once an initial geometry is found, the magnetic subsystem can be simulated and fine-tuned with more realistic non-linear characteristics of ferromagnetic materials. Doing so requires setting of the parameter non-linearPermeability to true and selection of one of the soft magnetic materials of <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">Material.SoftMagnetic</a>.
</p>
</html>"));
    end FixedShape;

    package Force
      "Flux tubes with reluctance force generation; constant permeability"
      extends Modelica.Icons.VariantsPackage;

      model HollowCylinderAxialFlux
        "(Hollow) cylinder with axial flux; constant permeability"

        extends FluxTubes.Interfaces.PartialForce;

        SI.Length l=s "Axial length (in direction of flux)" annotation (Dialog(
              group="Variable geometry", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderAxialFlux.png"));
        parameter SI.Radius r_i=0 "Inner radius of (hollow) cylinder";
        parameter SI.Radius r_o=0.01 "Outer radius of (hollow) cylinder";

        SI.MagneticFluxDensity B "Homogeneous flux density";

      protected
        parameter SI.Area A=pi*(r_o^2 - r_i^2)
          "Cross-sectional area orthogonal to direction of flux";

      equation
        G_m = mu_0*mu_r*A/l;

        dGmBydx = -1*mu_0*mu_r*A/l^2*dlBydx;

        B = Phi/A;

        annotation (defaultComponentName="force", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Force</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end HollowCylinderAxialFlux;

      model HollowCylinderRadialFlux
        "Hollow cylinder with radial flux; constant permeability"

        extends FluxTubes.Interfaces.PartialForce;

        SI.Length l=s "Axial length (orthogonal to direction of flux)"
          annotation (Dialog(group="Variable geometry", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderRadialFlux.png"));
        parameter SI.Radius r_i=0.01 "Inner radius of hollow cylinder";
        parameter SI.Radius r_o=0.015 "Outer radius of hollow cylinder";

        SI.MagneticFluxDensity B_avg
          "Average flux density (at arithmetic mean radius)";

      protected
        SI.Area A_avg
          "Average cross-sectional area orthogonal to direction of flux (at arithmetic mean radius)";

      equation
        G_m = mu_0*mu_r*2*pi*l/Modelica.Math.log(r_o/r_i);

        dGmBydx = mu_0*mu_r*2*pi/Modelica.Math.log(r_o/r_i)*dlBydx;

        A_avg = pi*(r_i + r_o)*l;
        B_avg = Phi/A_avg;

        annotation (defaultComponentName="force", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Force</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end HollowCylinderRadialFlux;

      model CuboidParallelFlux
        "Cuboid with flux in direction of motion, e.g., air gap with rectangular cross-section; constant permeability"

        extends FluxTubes.Interfaces.PartialForce;

        SI.Length l=s "Axial length (in direction of flux)" annotation (Dialog(
              group="Variable geometry", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/CuboidParallelFlux.png"));
        parameter SI.Length a=0.01 "Width of rectangular cross-section";
        parameter SI.Length b=0.01 "Height of rectangular cross-section";

        SI.MagneticFluxDensity B "Homogeneous flux density";

      protected
        parameter SI.Area A=a*b
          "Cross-sectional area orthogonal to direction of flux";

      equation
        G_m = mu_0*mu_r*A/l;

        dGmBydx = -1*mu_0*mu_r*A/l^2*dlBydx;

        B = Phi/A;

        annotation (defaultComponentName="force", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Force</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end CuboidParallelFlux;

      model CuboidOrthogonalFlux
        "Cuboid with flux orthogonal to direction of motion; constant permeability"

        extends FluxTubes.Interfaces.PartialForce;

        SI.Length l=s "Length in direction of motion (orthogonal to flux)"
          annotation (Dialog(group="Variable geometry", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/CuboidOrthogonalFlux.png"));
        parameter SI.Length a=0.01 "Width of rectangular cross-section";
        parameter SI.Length b=0.01
          "Height of rectangular cross-section (in flux direction)";

        SI.MagneticFluxDensity B "Homogeneous flux density";

      protected
        SI.Area A "Cross-sectional area orthogonal to direction of flux";

      equation
        A = a*l;
        G_m = mu_0*mu_r*A/b;

        dGmBydx = mu_0*mu_r*a/b*dlBydx;

        B = Phi/A;

        annotation (defaultComponentName="force", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Force</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end CuboidOrthogonalFlux;

      model LeakageAroundPoles
        "Leakage flux tube around cylindrical or prismatic poles"

        extends FluxTubes.Interfaces.PartialForce;
        SI.Length l=s "Axial length (in direction of flux)" annotation (Dialog(
              group="Variable geometry", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/LeakageAroundPoles.png"));
        parameter SI.Length w=0.1
          "Width orthogonal to flux; mean circumference of flux tube in case of cylindrical poles";
        parameter SI.Radius r=0.01 "Radius of leakage field";

      equation
        //adapted from [Ka08], but corrected
        //(in [Ka08] equation accidentally swapped with that of a similar element)
        G_m = mu_0*w/pi*Modelica.Math.log(1 + pi*r/l);

        //derivative at full length:
        //  dGmBydx = mu_0 * w /pi * 1/(1 + pi * r/l) * (-1)*pi*r/l^2  * dlBydx;
        //simplified:
        dGmBydx = -mu_0*w*r*dlBydx/(l^2*(1 + pi*r/l));

        annotation (defaultComponentName="force", Documentation(info="<html>
<p>
Please refer to the description of  the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Force</a> for a description of all elements of this package.
</p>

<p>
Leakage flux around a prismatic or cylindric air gap between to poles can be described with this model. Due to its constant radius of the leakage field r, the model is rather simple. Whereas in reality the leakage radius is approximately constant for air gap lengths l greater than this radius, it decreases with air gap lengths less than the leakage radius. This decrease for small air gaps is neglected here, since the influence of the leakage flux tube compared to that of the enclosed main air gap (connected in parallel) decreases for decreasing air gap length l.
</p>

<p>
Note that in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ka08]</a> the equation for G_m is accidentally swapped with that of a similar element.
</p>
</html>"));
      end LeakageAroundPoles;

      annotation (Documentation(info="<html>
<p>
Please have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.ReluctanceForceCalculation\">UsersGuide.ReluctanceForceCalculation</a> for an explanation of the different flux tube categories and resulting sub-packages.
</p>
<p>
Flux tube elements with generation of a reluctance force are intended for modelling of position-dependent air gap sections and permanent magnet sections respectively of translatory actuators. By default, the position co-ordinate of the mechanical connector flange.s is identical with the dimension l of the package's flux tube elements. l is the dimension changes with armature motion. If needed, the identity l=flange.s can be replaced by an actuator-specific equation, for example, when a flux tube length increases with decreasing armature position. The position co-ordinate of an element's translatory connector flange.s in turn will be identical with the armature position x in most cases, as the examples illustrate.</p>
<p>
The derivative of each element's permeance with respect to armature position <code>dGmBydx</code> is calculated from the derivative of the flux tube's permeance with respect to its varying dimension dGmBydl and the derivative of this dimension with respect to armature position <code>dlBydx</code>:</p>

<pre>
    dG_m   dG_m   dl
    ---- = ---- * --
     dx     dl    dx
</pre>

<p>
The parameter <code>dlBydx</code> must be set in each flux tube element to +1 or -1 according to the definition of the armature co-ordinate and the position of the element in a device's magnetic circuit. Proper match between armature motion and resulting variation of the flux tube length assures that the element's reluctance force acts in the right direction.
</p>
<p>
The shapes of the flux tubes defined in this package are rather simple. Only one dimension varies with armature motion. Flux tubes with more complex variations of dimensions with armature motion can be defined by extending the base class <a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.PartialForce\">Interfaces.PartialForce</a>, if needed. Determination of the analytic derivative dGmBydl could become more complex for those flux tubes.
</p>
</html>"));
    end Force;

    package Leakage
      "Leakage flux tubes with position-independent permeance and hence no force generation; mu_r=1"
      extends Modelica.Icons.VariantsPackage;

      model QuarterCylinder
        "Leakage flux from one edge to the opposite plane through a quarter cylinder"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length l=0.1
          "Axial length orthogonal to flux (=2*pi*r for cylindrical pole and r>>distance between edge and plane)"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterCylinder.png"));
      equation
        G_m = mu_0*0.52*l;

        annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end QuarterCylinder;

      model QuarterHollowCylinder
        "Leakage flux in circumferential direction through a quarter hollow cylinder"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length l=0.1
          "Axial length orthogonal to flux (=2*pi*r for cylindrical pole and r>>r_i)"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterHollowCylinder.png"));
        parameter Real ratio(start=1) "Constant ratio t/r_i";

      equation
        G_m = 2*mu_0*l*Modelica.Math.log(1 + ratio)/pi;

        annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end QuarterHollowCylinder;

      model HalfCylinder "Leakage flux through the edges of a half cylinder"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length l=0.1
          "Axial length orthogonal to flux (=2*pi*r for cylindrical pole and r>>distance between edges)"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/HalfCylinder.png"));

      equation
        G_m = mu_0*0.26*l;

        annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end HalfCylinder;

      model HalfHollowCylinder
        "Leakage flux in circumferential direction through a half hollow cylinder"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length l=0.1
          "Axial length orthogonal to flux (=2*pi*r for cylindrical pole and r>>r_i)"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/HalfHollowCylinder.png"));
        parameter Real ratio(start=1) "Constant ratio t/r_i";

      equation
        G_m = mu_0*l*Modelica.Math.log(1 + ratio)/pi;

        annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end HalfHollowCylinder;

      model QuarterSphere
        "Leakage flux through the corners of a quarter sphere"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Radius r=0.005 "Radius of quarter sphere"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterSphere.png"));

      equation
        G_m = mu_0*0.077*2*r;

        annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end QuarterSphere;

      model QuarterHollowSphere
        "Leakage flux through the edges of a quarter hollow sphere"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length t(start=0.01) "Thickness of spherical shell"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterHollowSphere.png"));

      equation
        G_m = mu_0*0.25*t;

        annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end QuarterHollowSphere;

      model EighthOfSphere
        "Leakage flux through one edge and the opposite plane of an eighth of a sphere"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Radius r=0.01 "Radius of eighth of sphere"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/EighthOfSphere.png"));

      equation
        G_m = mu_0*0.308*r;

        annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end EighthOfSphere;

      model EighthOfHollowSphere
        "Leakage flux through one edge and the opposite plane of an eighth of a hollow sphere"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Length t(start=0.01) "Thickness of spherical shell"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/EighthOfHollowSphere.png"));

      equation
        G_m = mu_0*0.5*t;

        annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end EighthOfHollowSphere;

      model CoaxCylindersEndFaces
        "Leakage flux between the end planes of a inner solid cylinder and a coaxial outer hollow cylinder"

        extends FluxTubes.Interfaces.PartialLeakage;

        parameter SI.Radius r_0=10e-3 "Radius of inner solid cylinder"
          annotation (Dialog(group="Parameters", groupImage=
                "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/CoaxCylindersEndFaces.png"));
        parameter SI.Radius r_1=17e-3 "Inner radius of outer hollow cylinder";
        parameter SI.Radius r_2=20e-3 "Outer radius of outer hollow cylinder";

        final parameter SI.Distance l_g=r_1 - r_0
          "Radial gap length between both cylinders";
        final parameter SI.Length t=r_2 - r_1
          "Radial thickness of outer hollow cylinder";

      equation
        // [Ro41], p. 139, Eq. (22)
        G_m = if t <= r_0 then 2*mu_0*(r_0 + l_g/2)*Modelica.Math.log(1 + 2*t/
          l_g) else 2*mu_0*(r_0 + l_g/2)*Modelica.Math.log(1 + 2*r_0/l_g);

        annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>
</html>"));
      end CoaxCylindersEndFaces;

      annotation (Documentation(info="<html>
<p>
Please have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.ReluctanceForceCalculation\">UsersGuide.ReluctanceForceCalculation</a> for an explanation of the different flux tube categories and resulting sub-packages.
</p>

<p>
The permeances of all elements of this package are calculated from their geometry. These flux tube elements are intended for modelling of leakage fields through vacuum, air and other media with a relative permeability mu_r=1. <a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.LeakageWithCoefficient\">Basic.LeakageWithCoefficient</a> accounts for leakage not by the geometry of flux tubes, but by a coupling coefficient c_usefulFlux.
</p>

<p>
All dimensions are defined as parameters. As a result, the shape of these elements will remain constant during dynamic simulation of actuators and reluctance forces will not be generated in these flux tube elements. A simple leakage flux tube with reluctance force generation is provided with the element <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force.LeakageAroundPoles\">Force.LeakageAroundPoles</a>. In cases where the accuracy of that element is not sufficient, the leakage elements of this package can be adapted and extended so that they are able to change their shape with armature motion and to generate reluctance forces. This requires an extension of the partial model <a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.PartialForce\">Interfaces.PartialForce</a>, a higher variability of the variables representing the flux tube's dimensions, definition of a relationship between armature position and these dimensions and determination of the analytic derivative dG_m/dx of the flux tube's permeance G_m with respect to armature position x.
</p>
</html>"));
    end Leakage;

    package HysteresisAndMagnets
      "Flux tube elements for modelling ferromagnetic hysteresis, eddy currents and permanent magnets"
      extends Modelica.Icons.VariantsPackage;
      model GenericHystTellinenSoft
        "Generic flux tube with soft magnetic hysteresis based on the Tellinen model and simple tanh()-functions"
        // Dialog Group Hysteresis
        parameter SI.MagneticFluxDensity Js = 1.8 "Saturation polarization" annotation (Dialog(group="Hysteresis", groupImage="modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenSoft/SoftMagneticHysteresis2.png"));
        parameter SI.MagneticFluxDensity Br=0.9 "Remanence" annotation (Dialog(group="Hysteresis"));
        parameter SI.MagneticFieldStrength Hc=120 "Coercitivity" annotation (Dialog(group="Hysteresis"));
        parameter Real K=1 "mu_0 multiplier" annotation (Dialog(group="Hysteresis"));

        extends Interfaces.PartialGenericHysteresisTellinen(mu0=K*mu_0);

      protected
        parameter SI.MagneticFluxDensity eps=Js/1000;
        //parameter Real mu0(final unit="N/A2")=K*mu_0;
        parameter Real H0=0.5*Modelica.Math.log((1 + Br/Js)/(1 - Br/Js));
        parameter Real M=H0/Hc;
        constant SI.MagneticFieldStrength unitH = 1;

      equation
        hystR = Js*tanh((M*Hstat - H0)/unitH) + mu0*Hstat - eps/2;
        hystF = Js*tanh((M*Hstat + H0)/unitH) + mu0*Hstat + eps/2;

        annotation (defaultComponentName="core", Documentation(info="<html>
<p>Flux tube element for modeling soft magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The shape of the limiting hysteresis loop (see Fig. 1) is described by simple hyperbolic tangent functions with 4 parameters. Therefore, the hysteresis shape variety is limited but the parameterization of the model is very simple and the model is relatively fast and robust. The rising (hyst<sub>R</sub>) and falling (hyst<sub>F</sub>) branches of the limiting hysteresis loop are defined by the following equations.</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenSoft/Eqn_ShapeFunctionsTellinen.png\"/></p><p><br><strong>Fig. 1:</strong> Hyperbolic tangent functions define the shape of the ferromagnetic (static) hysteresis</p><p><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenSoft/SoftMagneticHysteresis1.png\"/></p>
<p><br>An overview over of available hysteresis and permanent magnet elements of the package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>.</p>
</td>
</tr>
</table>
</html>"), Icon(graphics={Text(
                extent={{40,0},{40,-30}},
                lineColor={255,128,0},
                textString="TS")}));
      end GenericHystTellinenSoft;

      model GenericHystTellinenHard
        "Generic flux tube with hard magnetic hysteresis based on the Tellinen model and simple tanh()-functions"

        extends Interfaces.PartialGenericHysteresisTellinen(mu0=K*mu_0);

        //Hysteresis parameter
        parameter SI.MagneticFluxDensity Br=1.2 "Remanence" annotation (Dialog(group="Hysteresis", groupImage="modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenHard/HardMagneticHysteresis.png"));
        parameter SI.MagneticFieldStrength Hc=5e5 "Coercitivity" annotation (Dialog(group="Hysteresis"));
        parameter Real M = 10/Hc "Slope of tanh()-function" annotation (Dialog(group="Hysteresis"));
        parameter Real K=1 "mu_0 multiplier" annotation (Dialog(group="Hysteresis"));

      protected
        final parameter SI.MagneticFluxDensity eps = Br/1000;
        //final parameter Real mu0(final unit="N/A2") = K*mu_0;
        final parameter SI.MagneticFieldStrength H0= 0.5*log((1+mu0*Hc/Br)/(1-mu0*Hc/Br)) + M*Hc;
        constant SI.MagneticFieldStrength unitH = 1;

        Real tanhR;
        Real tanhF;

      equation
        tanhR = tanh((M*H - H0)/unitH);
        tanhF = tanh((M*H + H0)/unitH);
        hystR = Br*tanhR + mu0*H - eps/2;
        hystF = Br*tanhF + mu0*H + eps/2;

       annotation (defaultComponentName="core", Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                  -100},{100,100}}), graphics={
              Rectangle(
                extent={{-70,32},{70,-30}},
                lineColor={255,128,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{70,0},{100,0}},
                color={255,128,0}),
              Line(
                points={{-90,0},{-70,0}},
                color={255,128,0}), Line(
                points={{-30,-20},{-14,-20},{-6,-16},{2,0},{10,16},{18,20},{26,20}},
                color={255,128,0},
                smooth=Smooth.Bezier,
                origin={-14,0},
                rotation=180), Line(
                points={{-18,-20},{-2,-20},{6,-16},{14,0},{22,16},{30,20},{38,
                    20}},
                color={255,128,0},
                smooth=Smooth.Bezier),
              Line(
                points={{-18,-20},{-42,-20}},
                color={255,128,0}),
              Line(
                points={{16,20},{40,20}},
                color={255,128,0}),
              Text(
                extent={{40,-2},{40,-30}},
                lineColor={255,128,0},
                textString="TH")}), Documentation(info="<html>
<p>
  Flux tube element for modeling the ferromagnetic (static) hysteresis of hard magnetic materials. The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The shape of the limiting hysteresis loop is described by simple hyperbolic tangent functions with 4 parameters.
</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Hyperbolic tangent functions define the shape of the ferromagnetic (static) hysteresis</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenHard/HardMagneticHysteresis.png\">
   </td>
  </tr>
</table>

<p>
An overview of all available hysteresis and permanent magnet elements of the package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>.
</p>
</html>"));
      end GenericHystTellinenHard;

      model GenericHystTellinenEverett
        "Generic flux tube with ferromagnetic hysteresis based on the Tellinen model and the Everett function [Ya89])"

        parameter FluxTubes.Material.HysteresisEverettParameter.BaseData mat=
            FluxTubes.Material.HysteresisEverettParameter.BaseData()
          "Material properties"
          annotation (Dialog(group="Material"), choicesAllMatching=true);
        extends Interfaces.PartialGenericHysteresisTellinen(mu0=mat.K*mu_0, sigma=mat.sigma);

      protected
        parameter SI.MagneticFluxDensity Js = 0.5 * FluxTubes.Utilities.everett(
                                                           mat.Hsat,-mat.Hsat, mat, false)
          "Saturation polarization";
        //final parameter Real mu0 = mat.K * mu_0;
        parameter SI.MagneticFluxDensity eps=mat.M/1000;
        parameter Real P1 = (mat.M*mat.r*(2/pi*atan(mat.q*(mat.Hsat-mat.Hc))+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*(mat.Hsat-mat.Hc))+exp(-mat.p2*(mat.Hsat-mat.Hc)))));
        parameter Real P4 = (mat.M*mat.r*(2/pi*atan(mat.q*(-mat.Hsat-mat.Hc))+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*(-mat.Hsat-mat.Hc))+exp(-mat.p2*(-mat.Hsat-mat.Hc)))));

        SI.MagneticFieldStrength H2;
        SI.MagneticFieldStrength H3;
        Real P2;
        Real P3;
        Real H_lim;
        constant SI.MagneticFluxDensity unitT = 1;

      equation
        H_lim = if Hstat<-mat.Hsat then -mat.Hsat elseif Hstat>mat.Hsat then mat.Hsat else Hstat;
        H2 = H_lim-mat.Hc;
        H3 = -H_lim-mat.Hc;

        P2 = (mat.M*mat.r*(2/pi*atan(mat.q*H2)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H2)+exp(-mat.p2*H2))));
        P3 = (mat.M*mat.r*(2/pi*atan(mat.q*H3)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H3)+exp(-mat.p2*H3))));

        hystR = -Js + unitT*(P1*P2-P3*P4) + mu0*Hstat - eps/2;
        hystF =  Js + unitT*(P4*P2-P3*P1) + mu0*Hstat + eps/2;

        annotation (defaultComponentName="core", Icon(graphics={Text(
                extent={{40,0},{40,-30}},
                lineColor={255,128,0},
                textString="TE")}),
          Documentation(info="<html>

<p>
Flux tube element for modeling soft magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The Shape of the limiting ferromagnetic hysteresis loop is specified by an analytical description of the Everett function, which is also used to parameterize the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystPreisachEverett\">GenericHystPreisachEverett</a> model. A library of predefined parameter sets can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a>.
</p>


<p>
An overview of all available hysteresis and permanent magnet elements of the package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>.
</p>

</html>"));
      end GenericHystTellinenEverett;

      model GenericHystTellinenTable
        "Generic flux tube with ferromagnetic hysteresis based on the Tellinen model and table data"

        parameter FluxTubes.Material.HysteresisTableData.BaseData mat=
            FluxTubes.Material.HysteresisTableData.BaseData()
          annotation (choicesAllMatching=true, Dialog(group="Hysteresis"));
        parameter Real K = 1
          "Slope of hysteresis in the saturation region (K*mu_0)" annotation(Dialog(group="Hysteresis"));

        extends Interfaces.PartialGenericHysteresisTellinen(mu0=mu_0*K, sigma=mat.sigma);

      protected
        constant SI.MagneticFluxDensity unitT=1;
        parameter SI.MagneticFluxDensity eps = unitT*mat.tabris[size(mat.tabris,1),2]/1000;

        Modelica.Blocks.Tables.CombiTable1D tabris(
          table=mat.tabris,
          smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

        Modelica.Blocks.Tables.CombiTable1D tabfal(
          table=mat.tabfal,
          smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative);

      equation
        tabris.u[1]=Hstat;
        tabfal.u[1]=Hstat;

        hystR = unitT*tabris.y[1]+mu0*Hstat-eps;
        hystF = unitT*tabfal.y[1]+mu0*Hstat+eps;

        annotation (defaultComponentName="core", Icon(graphics={Text(
                extent={{40,0},{40,-30}},
                lineColor={255,128,0},
                textString="TT")}),
          Documentation(info="<html>

<p>
Flux tube element for modeling magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>. The rising and falling branch of the limiting ferromagnetic hysteresis loop are specified by table data. Therefore, almost any hysteresis shapes are possible. A library with predefined tables can be found at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisTableData\">FluxTubes.Material.HysteresisTableData</a>.
</p>
<p>
An overview of all available hysteresis and permanent magnet elements of the package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>.
</p>

</html>"));
      end GenericHystTellinenTable;

      model GenericHystPreisachEverett
        "Generic flux tube with ferromagnetic hysteresis based on the Preisach model and the Everett function [Ya89])"
        import Modelica.Constants.pi;

        parameter FluxTubes.Material.HysteresisEverettParameter.BaseData mat=
            FluxTubes.Material.HysteresisEverettParameter.BaseData()
          "Preisach Parameters"
          annotation (Dialog(group="Material"), choicesAllMatching=true);

        parameter Integer Count=100 "Length of history array" annotation(Dialog(group="Advanced"));
        parameter SI.MagneticFieldStrength eps=1e-5
          "Tolerance in Preisach history" annotation(Dialog(group="Advanced"));
        parameter SI.Time t1=1e-6 "Initialization time" annotation(Dialog(group="Advanced"));

        extends Interfaces.PartialGenericHysteresis(sigma=mat.sigma);

      protected
        final parameter Real mu0=mat.K*Modelica.Constants.mue_0;

        SI.MagneticFluxDensity J "Polarisation";
        SI.MagneticFieldStrength hmax(start=0, min=0) "maximum value of h";

        SI.MagneticFieldStrength alpha
          "Current alpha coordinate of Everett-Function everett(alpha,beta)";
        SI.MagneticFieldStrength beta
          "Current beta coordinate of Everett-Function everett(alpha,beta)";

        Boolean asc(start=true, fixed=true) "=asc without chatter";
        Boolean asc2 "Hstat is ascending der(Hstat)>0";
        Boolean delAsc(start=false)
          "wipeout history vertex at ascending Hstat";
        Boolean delDesc(start=false)
          "wipeout history vertex at descending Hstat";
        Boolean del(start=false) "delAsc or delDesc";
        Boolean init(start=false, fixed=true)
          "If init=1 then J runs on the initial magnetization curve";
        Boolean evInit(start=false) "Event init=0 -> init=1";
        Boolean evAsc(start=false) "Event asc=0 -> asc=1";
        Boolean evDesc(start=false) "Event asc=1 -> asc=0";

        SI.MagneticFieldStrength aSav[Count]
          "1xCount array of alpha history (vertices on Preisach Plane)";
        SI.MagneticFieldStrength bSav[Count]
          "1xCount array of beta history (vertices on Preisach Plane)";

        SI.MagneticFluxDensity E "Everett function";
        SI.MagneticFieldStrength H1 "Term for computing the Everett function";
        SI.MagneticFieldStrength H2 "Term for computing the Everett function";
        SI.MagneticFieldStrength H3 "Term for computing the Everett function";
        SI.MagneticFieldStrength H4 "Term for computing the Everett function";
        constant SI.MagneticFluxDensity unitT=1;

        Real v(start=0,  fixed=true, final unit="1");

        Boolean init2(start=false, fixed=true);
        Boolean init3;
        SI.MagneticFieldStrength x(start=0)
          "Variable for initialization of the Preisach model";
        discrete Real aSavI(start=0, fixed=true);
        discrete Real bSavI(start=0, fixed=true);
        discrete Real bI(start=0, fixed=true);
        discrete Real hmaxI(start=0, fixed=true);

      initial equation
        J = 0.5*(FluxTubes.Utilities.everett(
                H,
                -mat.Hsat,
                mat,
                false)*(1 - MagRel) - FluxTubes.Utilities.everett(
                mat.Hsat,
                H,
                mat,
                false)*(1 + MagRel) + FluxTubes.Utilities.everett(
                mat.Hsat,
                -mat.Hsat,
                mat,
                false)*MagRel);
        J = FluxTubes.Utilities.initPreisach(
                x,
                H,
                mat);
        aSav=fill( mat.Hsat,Count);
        bSav=fill(-mat.Hsat,Count);
        beta=alpha;
        hmax=mat.Hsat;

      equation
        init2 = time >= 1.5*t1;
        init3 = edge(init2);

        der(x) = 0;
        when init2 then
          hmaxI = abs(Hstat)+abs(x);
          if hmax<eps then
            aSavI = mat.Hsat;
            bSavI = -mat.Hsat;
          elseif asc and x<0 then
            aSavI = mat.Hsat;
            bSavI = -hmax;
          elseif asc and x>0 then
            aSavI = hmax;
            bSavI = alpha;
          elseif not asc and x<0 then
            aSavI = alpha;
            bSavI = -hmax;
          else
            aSavI = hmax;
            bSavI = -mat.Hsat;
          end if;
          bI = if asc then bSav[1] else aSav[1];
        end when;

        alpha = if Hstat<=-mat.Hsat then -mat.Hsat elseif Hstat>=mat.Hsat then mat.Hsat else Hstat;

        asc2 = der(Hstat)>0;
        der(v)= if (asc2 and v<1) then 0.5/t1 elseif (not asc2 and v>0) then -0.5/t1 else 0;
        asc = v>0.5;

        evAsc = (not pre(asc)) and asc;
        evDesc = pre(asc) and (not asc);

        der(beta) = if init then -der(alpha) else 0;

        delAsc = (alpha > pre(aSav[1]));
        delDesc = (alpha < pre(bSav[1]));
        del = delAsc or delDesc or evInit;

        init = (abs(alpha) >= pre(hmax)) and time>=2*t1;

        evInit = init and not pre(init);

        when init3 or (change(asc) and pre(init)) then
          hmax = if init3 then hmaxI else abs(Hstat);
        end when;

        //##### bSav #####
        when {init3, evAsc, del} then
          if init3 then
            bSav=cat(1,{bSavI},fill(-mat.Hsat,Count-1));
          elseif evAsc then
            bSav = if (alpha-eps)>pre(bSav[1]) then cat(1,{alpha},pre(bSav[1:end-1])) else pre(bSav);
          elseif del then
            bSav = cat(1,pre(bSav[2:end]),{-mat.Hsat});
          else
            bSav = pre(bSav);
          end if;
        end when;

        //##### REINIT aSav #####
        when {init3, evDesc, del} then
          if init3 then
            aSav=cat(1,{aSavI},fill(mat.Hsat,Count-1));
          elseif evDesc then
            aSav = if (alpha+eps)<pre(aSav[1]) then cat(1,{alpha},pre(aSav[1:end-1])) else pre(aSav);
          elseif del then
            aSav = cat(1,pre(aSav[2:end]),{mat.Hsat});
          else
            aSav = pre(aSav);
          end if;
        end when;

        // #### beta ####
        when {init3, change(asc), evInit, del} then
          reinit(beta, if init3 then bI elseif change(asc) then alpha elseif evInit then -alpha elseif asc then bSav[1] else aSav[1]);
        end when;

        H1= -beta-mat.Hc;
        H2= alpha-mat.Hc;
        H3= -alpha-mat.Hc;
        H4= beta-mat.Hc;

        E = unitT*
            ((mat.M*mat.r*(2/pi*atan(mat.q*H1)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H1)+exp(-mat.p2*H1))))*
            (mat.M*mat.r*(2/pi*atan(mat.q*H2)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H2)+exp(-mat.p2*H2))))-
            (mat.M*mat.r*(2/pi*atan(mat.q*H3)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H3)+exp(-mat.p2*H3))))*
            (mat.M*mat.r*(2/pi*atan(mat.q*H4)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H4)+exp(-mat.p2*H4)))));

        der(J) = (if init then 0.5 else 1) * der(E);
        B = J + mu0 * Hstat;

        annotation (defaultComponentName="core", Icon(graphics={Text(
                extent={{40,0},{40,-30}},
                lineColor={255,128,0},
                textString="PE")}),
          Documentation(info="<html>
<p>
Flux tube element for modeling magnetic materials with ferromagnetic and dynamic hysteresis (eddy currents). The ferromagnetic hysteresis behavior is defined by the
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Preisach\">Preisach hysteresis model</a>. The Shape of the limiting ferromagnetic hysteresis loop is specified by an analytical description of the Everett function. A library of predefined parameter sets can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a>.
</p>

<p>
An overview over all available hysteresis and permanent magnet elements of the package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>.
</p>

</html>"));
      end GenericHystPreisachEverett;

      model GenericHystTellinenPermanentMagnet
        "Permanent magnet based on the Tellinen hysteresis model"

        extends FluxTubes.Interfaces.PartialGenericHysteresisTellinen(mu0=K*
              Modelica.Constants.mue_0, MagRel(start=-1, fixed=true));

        parameter SI.MagneticFluxDensity Br=1.2 "Remanence" annotation (Dialog(group="Hysteresis", groupImage="modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenHard/HardMagneticHysteresis.png"));
        parameter SI.MagneticFieldStrength Hc=5e5 "Coercitivity" annotation (Dialog(group="Hysteresis"));
        parameter Real M(final unit="1") = unitH*10/Hc
          "Slope of tanh()-function" annotation (Dialog(group="Hysteresis"));
        parameter Real K(final unit="1")=1 "mu_0 multiplier" annotation (Dialog(group="Hysteresis"));

      protected
        constant SI.MagneticFieldStrength unitH = 1;
        parameter SI.MagneticFluxDensity eps= Br/1000;
        parameter SI.MagneticFieldStrength H0= 0.5*log((1+mu0*Hc/Br)/(1-mu0*Hc/Br)) + M*Hc;

      equation
        hystR = Br*tanh((M*H - H0)/unitH) + mu0*H - eps/2;
        hystF = Br*tanh((M*H + H0)/unitH) + mu0*H + eps/2;

        annotation (defaultComponentName="pm",
                    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                  -100},{100,100}}), graphics={
              Rectangle(
                extent={{-70,30},{70,-30}},
                lineColor={255,128,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{70,0},{100,0}},
                color={255,128,0}),
              Rectangle(
                extent={{34,20},{60,-20}},
                lineColor={0,127,0},
                fillColor={0,127,0},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-20,13},{20,-13}},
                textStyle={TextStyle.Bold},
                origin={47,0},
                rotation=90,
                textString="S"), Line(
                points={{-38,-20},{-4,-20},{4,-16},{12,0},{20,16},{28,20},{36,
                    20}},
                color={255,128,0},
                smooth=Smooth.Bezier), Line(
                points={{-42,-20},{-14,-20},{-6,-16},{2,0},{10,16},{18,20},{28,
                    20}},
                color={255,128,0},
                smooth=Smooth.Bezier,
                origin={-6,0},
                rotation=180),
              Line(
                points={{-100,0},{-70,0}},
                color={255,128,0}),
              Rectangle(
                extent={{-60,20},{-34,-20}},
                lineColor={255,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-20,13},{20,-13}},
                textStyle={TextStyle.Bold},
                textString="N",
                origin={-47,0},
                rotation=90),
              Text(
                extent={{22,0},{22,-18}},
                lineColor={255,128,0},
                textString="TH")}), Documentation(info="<html>

<p>
Flux tube element for modeling the hard magnetic hysteresis of permanent magnets. The model is similar to <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenHard\">GenericHystTellinenHard</a> but has an initial magnetization preset of -100% and an adapted icon for better readability of the diagram.
</p>

<p>
An overview over all available hysteresis and permanent magnet elements of the package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>.
</p>

</html>"));
      end GenericHystTellinenPermanentMagnet;

      model GenericLinearPermanentMagnet
        "Permanent Magnet with linear characteristic"
        extends Interfaces.PartialGeneric;

        parameter Material.HardMagnetic.BaseData mat=
            Material.HardMagnetic.BaseData() "Material" annotation (Dialog(group="Material"),choicesAllMatching=true);

        output SI.MagneticFieldStrength H;
        output SI.MagneticFluxDensity B;

      equation
        V_m = H*l;
        Phi = B*A;
        B = -mat.B_r+mu_0*mat.mu_r*H;
        annotation (defaultComponentName="pm",Icon(graphics={
              Rectangle(
                extent={{-70,30},{70,-30}},
                lineColor={255,128,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-100,0},{-70,0}},
                color={255,128,0}),
              Line(
                points={{70,0},{100,0}},
                color={255,128,0}),
              Rectangle(
                extent={{-60,20},{-34,-20}},
                lineColor={255,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-20,13},{20,-13}},
                textStyle={TextStyle.Bold},
                textString="N",
                origin={-47,0},
                rotation=90),
              Rectangle(
                extent={{34,20},{60,-20}},
                lineColor={0,127,0},
                fillColor={0,127,0},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-20,13},{20,-13}},
                textStyle={TextStyle.Bold},
                origin={47,0},
                rotation=90,
                textString="S")}),
          Documentation(info="<html>
<p>
Simple model of a linear permanent Magnet. Typical characteristics of common permanent magnetic materials can be found at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">FluxTubes.Material.HardMagnetic</a>.
</p>

<p>
An overview over all available hysteresis and permanent magnet elements of the package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a> can be found in <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>.
</p>

</html>"));
      end GenericLinearPermanentMagnet;

      annotation (Documentation(info="<html>

<p>
Please have a look at <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a> for an explanation of the Content of the package.
</p>

</html>"));
    end HysteresisAndMagnets;
  end Shapes;

  package Material
    "Magnetisation characteristics of common soft magnetic and hard magnetic materials"
    extends Modelica.Icons.MaterialPropertiesPackage;

    package SoftMagnetic
      "Characteristics mu_r(B) of common soft magnetic materials; hysteresis neglected"
      extends Modelica.Icons.MaterialPropertiesPackage;

      record BaseData
        "Coefficients for approximation of soft magnetic materials"

        extends Modelica.Icons.Record;

        parameter SI.RelativePermeability mu_i=1
          "Initial relative permeability at B=0";
        parameter SI.MagneticFluxDensity B_myMax=1
          "Flux density at maximum relative permeability";
        parameter Real c_a=1 "Coefficient of approximation function";
        parameter Real c_b=1 "Coefficient of approximation function";
        parameter Real n=1 "Exponent of approximation function";

        annotation (Documentation(info="<html>
<p>
The parameters needed for <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.mu_rApprox\">approximation of the magnetisation characteristics</a> of included soft magnetic materials are declared in this record.
</p>
</html>"));
      end BaseData;

      package Steel "Various ferromagnetic steels"
        extends Modelica.Icons.MaterialPropertiesPackage;
        record Steel_9SMnPb28 "9SMnPb28 (1.0718)"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=400,
            B_myMax=1.488,
            c_a=1200,
            c_b=3,
            n=12.5);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
        end Steel_9SMnPb28;

        record Steel_9SMn28K "9SMn28k (1.0715)"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=500,
            B_myMax=1.036,
            c_a=43414,
            c_b=35.8,
            n=14);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
        end Steel_9SMn28K;

        record DC01 "DC01 (1.0330, previously St2)"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=5,
            B_myMax=1.1,
            c_a=6450,
            c_b=3.65,
            n=7.7);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
        end DC01;

        record DC03 "DC03 (1.0347, previously St3)"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=0,
            B_myMax=1.05,
            c_a=27790,
            c_b=16,
            n=10.4);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
        end DC03;

        record X6Cr17 "X6Cr17 (1.4016)"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=274,
            B_myMax=1.1,
            c_a=970,
            c_b=1.2,
            n=8.3);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
        end X6Cr17;

        record AISI_1008 "AISI 1008 (1.0204)"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=200,
            B_myMax=1.17,
            c_a=8100,
            c_b=2.59,
            n=10);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
        end AISI_1008;

        record AISI_12L14 "AISI 12L14 (1.0718)"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=10,
            B_myMax=0.94,
            c_a=5900,
            c_b=4.19,
            n=6.4);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
        end AISI_12L14;
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
      end Steel;

      package ElectricSheet "Various electric sheets"
        extends Modelica.Icons.MaterialPropertiesPackage;

        record M330_50A "M330-50A (1.0809) @ 50Hz"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=500,
            B_myMax=0.7,
            c_a=24000,
            c_b=9.38,
            n=9.6);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: complete core after machining and packet assembling<br>
</p>
</html>"));
        end M330_50A;

        record M350_50A "M350-50A (1.0810) @ 50Hz"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=1210,
            B_myMax=1.16,
            c_a=24630,
            c_b=2.44,
            n=14);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: sheet strip<br>
Measurement: Epstein frame
</p>
</html>"));
        end M350_50A;

        record M530_50A "M530-50A (1.0813) @ 50Hz"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=2120,
            B_myMax=1.25,
            c_a=12400,
            c_b=1.6,
            n=13.5);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: sheet strip<br>
Measurement: Epstein frame
</p>
</html>"));
        end M530_50A;

        record M700_100A "M700-100A (1.0826) @ 50Hz"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=1120,
            B_myMax=1.2,
            c_a=20750,
            c_b=3.55,
            n=13.15);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: sheet strip<br>
Measurement: Epstein frame
</p>
</html>"));
        end M700_100A;

        record M940_100A "M940-100A @ 50Hz"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=680,
            B_myMax=1.26,
            c_a=17760,
            c_b=3.13,
            n=13.9);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Sample: sheet strip<br>
Measurement: Epstein frame
</p>
</html>"));
        end M940_100A;

        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
</html>"));
      end ElectricSheet;

      package PureIron "Pure iron"
        extends Modelica.Icons.MaterialPropertiesPackage;

        record RFe80 "Hyperm 0 (RFe80)"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=123,
            B_myMax=1.27,
            c_a=44410,
            c_b=6.4,
            n=10);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Source of B(H) characteristics: Product catalogue <em>Magnequench</em>, 2000
</p>
</html>"));
        end RFe80;

        record VacoferS2 "VACOFER S2 (99.95% Fe)"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=2666,
            B_myMax=1.15,
            c_a=187000,
            c_b=4.24,
            n=19);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<dl>
<dt>Source of B(H) characteristics:</dt>
    <dd><p><em>Boll, R.</em>: Weichmagnetische Werkstoffe: Einf&uuml;hrung in den Magnetismus, VAC-Werkstoffe und ihre Anwendungen. 4th ed. Berlin, M&uuml;nchen: Siemens Aktiengesellschaft 1990</p>
    </dd>
</dl>
</html>"));
        end VacoferS2;
      end PureIron;

      package CobaltIron "Cobalt iron"
        extends Modelica.Icons.MaterialPropertiesPackage;

        record Vacoflux50 "Vacoflux 50 (50% CoFe)"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=3850,
            B_myMax=1.75,
            c_a=11790,
            c_b=2.63,
            n=15.02);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Source of B(H) characteristics: VACUUMSCHMELZE GmbH &amp; Co. KG, Germany
</p>
</html>"));
        end Vacoflux50;
      end CobaltIron;

      package NickelIron "Nickel iron"
        extends Modelica.Icons.MaterialPropertiesPackage;

        record MuMetall "MUMETALL (77% NiFe)"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=27300,
            B_myMax=0.46,
            c_a=1037500,
            c_b=3.67,
            n=10);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Source of B(H) characteristics:
</p>
<ul>
<li><em>Boll, R.</em>: Weichmagnetische Werkstoffe: Einf&uuml;hrung in den Magnetismus, VAC-Werkstoffe und ihre Anwendungen. 4th ed. Berlin, M&uuml;nchen: Siemens Aktiengesellschaft 1990</li>
</ul>
</html>"));
        end MuMetall;

        record Permenorm3601K3 "PERMENORM 3601 K3 (36% NiFe)"
          extends FluxTubes.Material.SoftMagnetic.BaseData(
            mu_i=3000,
            B_myMax=0.67,
            c_a=50000,
            c_b=2.39,
            n=9.3);
          annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a> for a description of all soft magnetic material characteristics of this package.
</p>
<p>
Source of B(H) characteristics:
</p>
<ul>
<li><em>Boll, R.</em>: Weichmagnetische Werkstoffe: Einf&uuml;hrung in den Magnetismus, VAC-Werkstoffe und ihre Anwendungen. 4th ed. Berlin, M&uuml;nchen: Siemens Aktiengesellschaft 1990</li>
</ul>
</html>"));
        end Permenorm3601K3;
      end NickelIron;

      function mu_rApprox
        "Approximation of relative permeability mu_r as a function of flux density B for soft magnetic materials"

        extends Modelica.Icons.Function;

        input Modelica.SIunits.MagneticFluxDensity B
          "Flux density in ferromagnetic flux tube element";
        //Material specific parameter set:
        input Modelica.SIunits.RelativePermeability mu_i
          "Initial relative permeability at B=0";
        input Modelica.SIunits.MagneticFluxDensity B_myMax
          "Flux density at maximum relative permeability";
        input Real c_a "Coefficient of approximation function";
        input Real c_b "Coefficient of approximation function";
        input Real n "Exponent of approximation function";

        output Modelica.SIunits.RelativePermeability mu_r
          "Relative magnetic permeability of ferromagnetic flux tube element";

      protected
        Real B_N
          "Flux density B normalized to flux density at maximum relative permeability B_myMax";

      algorithm
        B_N := abs(B/B_myMax);
        mu_r := 1 + (mu_i - 1 + c_a*B_N)/(1 + c_b*B_N + B_N^n);

        annotation (Documentation(info="<html>
<p>
The relative permeability mu_r as a function of flux density B for all soft magnetic materials currently included in this library is approximated with the following function <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro00]</a>:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/SoftMagnetic/eq_mu_rApprox.png\" alt=\"Equation for approximation mu_r(B)\"/>
</p>

<p>
Two of the five parameters of this equation have a physical meaning, namely the initial relative permeability mu_i at B=0 and the magnetic flux density at maximum permeability B_myMax. B_N is the flux density normalized to latter parameter.</p>
</html>"));
      end mu_rApprox;
      annotation (Documentation(info="<html>
<p>
The magnetisation characteristics mu_r(B) of all soft magnetic materials currently included in this library are approximated with a <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.mu_rApprox\">function</a>. Each material is characterised by the five parameters of this function. The approximated characteristics mu_r(B) for most of the ferromagnetic materials currently included are shown in the plots below (solid lines) together with the original data points compiled from measurements and literature.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/SoftMagnetic/Steel.png\" alt=\"Approximated magnetization characteristics of selected steels\"><br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/SoftMagnetic/Miscellaneous.png\" alt=\"Approximated magnetization characteristics of miscellaneous soft magnetic materials\"><br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/SoftMagnetic/ElectricSheet.png\" alt=\"Approximated magnetization characteristics of included electric sheets\"><br>
</p>

<p>
For the nonlinear curve fit, data points for high flux densities (approximately B>1T) have been weighted higher than the ones for low flux densities. This is due to the large impact of saturated ferromagnetic sections in a magnetic circuit compared to that of non-saturated sections with relative permeabilities mu_r>>1.
</p>

<p>
Note that the magnetisation characteristics largely depend on possible previous machining and on measurement conditions. A virgin material normally has a considerably higher permeability than the same material after machining (and packet assembling in case of electric sheets). This is indicated in the above plots by different magnetisation curves for similar materials. In most cases, the original data points represent commutating curves obtained with measurements at 50Hz.
</p>

<p>
Additional user-specific materials can be defined as needed. This requires determination of the approximation parameters from the original data points, preferably with a nonlinear curve fit.
</p>
</html>"));

    end SoftMagnetic;

    package HardMagnetic
      "Characteristics of common permanent magnetic materials (temperature dependence considered)"
      extends Modelica.Icons.MaterialPropertiesPackage;

      record BaseData "Record for permanent magnetic material data"
        extends Modelica.Icons.Record;

        parameter SI.MagneticFieldStrength H_cBRef=1
          "Coercivity at reference temperature";
        parameter SI.MagneticFluxDensity B_rRef=1
          "Remanence at reference temperature";
        parameter SI.Temperature T_ref=293.15 "Reference temperature";
        parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_Br=0
          "Temperature coefficient of remanence at reference temperature";

        parameter SI.Temperature T_op=293.15 "Operating temperature";

        final parameter SI.MagneticFluxDensity B_r=B_rRef*(1 + alpha_Br*(T_op
             - T_ref)) "Remanence at operating temperature";
        final parameter SI.MagneticFieldStrength H_cB=H_cBRef*(1 + alpha_Br*(
            T_op - T_ref)) "Coercivity at operating temperature";
        final parameter SI.RelativePermeability mu_r=B_r/(mu_0*H_cB)
          "Relative permeability";

        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end BaseData;

      record NdFeB "NdFeB sintered; exemplary values"
        extends FluxTubes.Material.HardMagnetic.BaseData(
          H_cBRef=900000,
          B_rRef=1.2,
          T_ref=20 + 273.15,
          alpha_Br=-0.001);
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end NdFeB;

      record Sm2Co17 "Sm2Co17 sintered, exemplary values"
        extends FluxTubes.Material.HardMagnetic.BaseData(
          H_cBRef=750000,
          B_rRef=1.02,
          T_ref=20 + 273.15,
          alpha_Br=-0.0003);
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end Sm2Co17;

      record SmCo5 "SmCo5 sintered, exemplary values"
        extends FluxTubes.Material.HardMagnetic.BaseData(
          H_cBRef=720000,
          B_rRef=0.95,
          T_ref=20 + 273.15,
          alpha_Br=-0.0004);
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end SmCo5;

      record PlasticNdFeB "Plastic-bonded NdFeB, exemplary values"
        extends FluxTubes.Material.HardMagnetic.BaseData(
          H_cBRef=400000,
          B_rRef=0.58,
          T_ref=20 + 273.15,
          alpha_Br=-0.001);
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end PlasticNdFeB;

      record PlasticSmCo "Plastic-bonded Sm-Co, exemplary values"
        extends FluxTubes.Material.HardMagnetic.BaseData(
          H_cBRef=385000,
          B_rRef=0.57,
          T_ref=20 + 273.15,
          alpha_Br=-0.0004);
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end PlasticSmCo;

      record HardFerrite "Hard ferrite sintered, exemplary values"
        extends FluxTubes.Material.HardMagnetic.BaseData(
          H_cBRef=170000,
          B_rRef=0.38,
          T_ref=20 + 273.15,
          alpha_Br=-0.002);
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end HardFerrite;

      record PlasticHardFerrite "Plastic-bonded hard ferrite, exemplary values"
        extends FluxTubes.Material.HardMagnetic.BaseData(
          H_cBRef=130000,
          B_rRef=0.21,
          T_ref=20 + 273.15,
          alpha_Br=-0.002);
        annotation (Documentation(info="<html>
<p>
Please refer to the description of  the enclosing package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a> for a description of all permanent magnetic material characteristics of this package.
</p>
</html>"));
      end PlasticHardFerrite;

      annotation (Documentation(info="<html>
<p>
Typical values for remanence, coercivity and the temperature coefficient of remanence are provided for the common permanent magnetic materials illustrated below.</p>
<dl>
<dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HardMagnetic/HardMagneticMaterials.png\" alt=\"Demagnetization characteristics of included permanent magnetic materials\">
</dd>
</dl>
<p>
Linear demagnetization curves are modelled. The characteristic, temperature-dependent \"knee\" of many permanent magnetic materials is not considered, since proper design of permanent magnetic circuits should avoid operation of permanent magnets \"below\" that point due to partial demagnetization. As a result, the temperature coefficient of coercivity is not considered. Only the temperature coefficient of remanence alpha_Br is accounted for, since it describes the dependence of the demagnetization curve on the temperature sufficiently for the region \"above the knee-point\".
</p>
<p>
Additional user-specific materials can be defined as needed.
</p>
</html>"));
    end HardMagnetic;

    package HysteresisEverettParameter
      "Parameter sets for an analytical description of the Everett function"
      extends Modelica.Icons.MaterialPropertiesPackage;
      record BaseData "Base Data Record"
        extends Modelica.Icons.Record;
        parameter SI.MagneticFieldStrength Hsat=100
          "Hysteresis region between -Hsat .. Hsat";
        parameter Real M(final unit="1")=0.95
          "Related to saturation value of magnetization";
        parameter Real r(final unit="1")=0.55
          "Proportion of the straight region in the vicinity of Hc";
        parameter Real q(final unit="m/A")=2.4e-1
          "Slope of the straight region in the vicinity of Hc";
        parameter Real p1(final unit="m/A")=1.2e-1 "Sharpness of major loop";
        parameter Real p2(final unit="m/A")=8e-1 "Sharpness of major loop";
        parameter SI.MagneticFieldStrength Hc=7.4 "Major loop coercivity";
        parameter Real K(final unit="1")=1
          "Slope in saturation region mue_0*K";
        parameter SI.Conductivity sigma = 1
          "Electrical conductivity of material";

        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisEverettParameter/hyst_BaseData.png\">
   </td>
  </tr>
</table>
</html>"));
      end BaseData;

      record Vacoflux17 "Vacoflux17"
        extends BaseData(
          M = 0.919590,
          r = 0.728070,
          q = 0.015757,
          p1 = 0.016407,
          p2 = 0.001049,
          Hc = 98.0842,
          K = 110,
          Hsat = 1000,
          sigma = 2.56e6);
        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisEverettParameter/hyst_Vacoflux17.png\">
   </td>
  </tr>
</table>
</html>"));
      end Vacoflux17;

      record Vacodur50 "Vacodur50"
        extends BaseData(
          M = 1.002,
          r = 1.0835,
          q = 0.052305,
          p1 = 0.79581,
          p2 = 0.00898,
          Hc = 133.5884,
          K = 160,
          Hsat = 800,
          sigma=2.38e6);
        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisEverettParameter/hyst_Vacodur50.png\">
   </td>
  </tr>
</table>
</html>"));
      end Vacodur50;

      record M270_50A "M270-50A"
        extends BaseData(
          Hsat = 650,
          M = 0.980890,
          r = 0.429330,
          q = 0.027285,
          p1 = 0.48567,
          p2 = 0.000549,
          Hc = 24.4948,
          K = 50,
          sigma = 1.72e6);
        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisEverettParameter/hyst_M270-50A.png\">
   </td>
  </tr>
</table>
</html>"));
      end M270_50A;

      record M330_50A "M330-50A"
        extends BaseData(
          Hsat = 650,
          M = 0.967,
          r = 0.502560,
          q = 0.039964,
          p1 = 0.188070,
          p2 = 0.000781,
          Hc = 42.2283,
          K = 50,
          sigma = 2.2e6);
        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisEverettParameter/hyst_M330-50A.png\">
   </td>
  </tr>
</table>
</html>"));
      end M330_50A;

      record M400_50A "M400-50A"
        extends BaseData(
          Hsat = 700,
          M = 0.96642,
          r = 0.44216,
          q = 0.027763,
          p1 = 0.29943,
          p2 = 0.000757,
          Hc = 43.2967,
          K = 50,
          sigma = 2.22e6);
        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisEverettParameter/hyst_M400-50A.png\">
   </td>
  </tr>
</table>
</html>"));
      end M400_50A;

      record M400_50AP "M400-50AP"
        extends BaseData(
          Hsat = 600,
          M = 1.0013,
          r = 0.42687,
          q = 0.034302,
          p1 = 0.31794,
          p2 = 0.000759,
          Hc = 36.204,
          K = 50,
          sigma = 2.22e6);
        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisEverettParameter/hyst_M400-50AP.png\">
   </td>
  </tr>
</table>
</html>"));
      end M400_50AP;

      record M800_65A "M800-65A"
        extends BaseData(
          Hsat = 700,
          M = 1.146100,
          r = 0.160700,
          q = 0.012965,
          p1 = 0.183490,
          p2 = 0.000425,
          Hc = 100.0602,
          K = 50,
          sigma = 3.27e6);
        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisEverettParameter/hyst_M800-65A.png\">
   </td>
  </tr>
</table>
</html>"));
      end M800_65A;
      annotation (Documentation(info="<html>
<p>These parameter records contain the parameters which adapt the analytical Everett function to a specific hysteresis shape (see <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[YUY89]</a> for a detailed description of that function). The Everett function is used to define the shape of the ferromagnetic hysteresis of the <code><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenEverett\">GenericHystTellinenEverett</a></code> and the <code><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystPreisachEverett\">GenericHystPreisachEverett</a></code> flux tube elements.</p>
</html>"));
    end HysteresisEverettParameter;

    package HysteresisTableData
      extends Modelica.Icons.MaterialPropertiesPackage;
      record BaseData "Hysteresis table data"

        extends Modelica.Icons.Record;

        parameter Real[:,:] tabris=[
          -10000000, -0.8000;
          -1000, -0.8000;
          -300, -0.8000;
          -200, -0.8000;
          -190, -0.8000;
          -180, -0.8000;
          -160, -0.7999;
          -150, -0.7998;
          -140, -0.7997;
          -130, -0.7996;
          -120, -0.7993;
          -110, -0.7989;
          -100, -0.7982;
          -90, -0.7971;
          -80, -0.7953;
          -70, -0.7924;
          -60, -0.7878;
          -50, -0.7802;
          -40, -0.7680;
          -30, -0.7486;
          -20, -0.7180;
          -10, -0.6708;
          0, -0.6000;
          10, -0.4983;
          20, -0.3611;
          30, -0.1908;
          40, 0.0000;
          50, 0.1908;
          60, 0.3611;
          70, 0.4983;
          80, 0.6000;
          90, 0.6708;
          100, 0.7180;
          110, 0.7486;
          120, 0.7680;
          130, 0.7802;
          140, 0.7878;
          150, 0.7924;
          160, 0.7953;
          170, 0.7971;
          180, 0.7982;
          190, 0.7989;
          200, 0.7993;
          300, 0.8000;
          1000, 0.8000;
          10000000, 0.8000]
          "Table data of the rising (lower) branch of the hysteresis envelope curve (H, B)";

        parameter Real[:,:] tabfal=[
          -10000000, -0.8000;
          -1000, -0.8000;
          -300, -0.8000;
          -200, -0.7993;
          -190, -0.7989;
          -180, -0.7982;
          -170, -0.7971;
          -160, -0.7953;
          -150, -0.7924;
          -140, -0.7878;
          -130, -0.7802;
          -120, -0.7680;
          -110, -0.7486;
          -100, -0.7180;
          -90, -0.6708;
          -80, -0.6000;
          -70, -0.4983;
          -60, -0.3611;
          -50, -0.1908;
          -40, 0.0000;
          -30, 0.1908;
          -20, 0.3611;
          -10, 0.4983;
          0, 0.6000;
          10, 0.6708;
          20, 0.7180;
          30, 0.7486;
          40, 0.7680;
          50, 0.7802;
          60, 0.7878;
          70, 0.7924;
          80, 0.7953;
          90, 0.7971;
          100, 0.7982;
          110, 0.7989;
          120, 0.7993;
          130, 0.7996;
          140, 0.7997;
          150, 0.7998;
          160, 0.7999;
          180, 0.8000;
          190, 0.8000;
          200, 0.8000;
          300, 0.8000;
          1000, 0.8000;
          10000000, 0.8000]
          "Table data of the falling (upper) branch of the hysteresis envelope curve (H, B)";
        parameter SI.Conductivity sigma = 1;
        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/hysttd_BaseData.png\">
   </td>
  </tr>
</table>
</html>"));
      end BaseData;

      record Vacoflux17 "Vacoflux17"
        extends FluxTubes.Material.HysteresisTableData.BaseData(
          tabris=[-1e7,-1.577; -1000.000,-1.577; -800.000,-1.577; -655.738,-1.555;
              -505.647,-1.526; -374.499,-1.483; -253.552,-1.417; -135.519,-1.315;
              -88.889,-1.221; -45.173,-1.097; -20.401,-0.967; 11.658,-0.770; 69.945,
              -0.269; 102.004,0.138; 122.404,0.429; 145.719,0.690; 177.778,0.887;
              211.293,1.025; 253.552,1.148; 306.011,1.243; 376.463,1.340; 480.978,
              1.422; 673.913,1.528; 800.000,1.577; 1000.000,1.577; 1e7,1.577],
          tabfal=[-1e7,-1.577; -1000.000,-1.577; -800.000,-1.577; -576.505,-1.477;
              -409.072,-1.377; -292.851,-1.245; -213.838,-1.046; -176.321,-0.858;
              -147.177,-0.661; -122.404,-0.414; -103.461,-0.109; -85.975,0.138;
              -71.403,0.298; -48.087,0.516; -10.200,0.807; 27.687,1.032; 93.261,
              1.250; 145.719,1.344; 192.350,1.388; 264.841,1.453; 351.184,1.497;
              543.534,1.555; 657.609,1.572; 800.000,1.577; 1000.000,1.577; 1e7,1.577],
          sigma=2.56e6);

        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/hysttd_Vacoflux17.png\">
   </td>
  </tr>
</table>
</html>"));
      end Vacoflux17;

      record Vacoflux48 "Vacoflux48"
        extends FluxTubes.Material.HysteresisTableData.BaseData(
          tabris=[-1500,-2.22424; -1000,-2.22424; -798.541,-2.22424; -641.021,-2.19521;
              -476.208,-2.15167; -320.146,-2.09361; -187.42,-1.9775; -134.913,-1.93396;
              -98.4503,-1.87591; -66.3628,-1.8106; -43.0264,-1.73803; -24.0656,-1.66546;
              -8.02188,-1.59289; 3.64631,-1.51306; 16.773,-1.41147; 22.6071,-1.32438;
              25.5242,-1.23004; 29.8997,-0.33019; 35.7338,0.56241; 43.0264,1.15022;
              51.7776,1.38244; 61.9872,1.52758; 72.1969,1.62917; 88.2407,1.71626;
              107.201,1.78157; 123.245,1.83237; 149.499,1.90493; 177.211,1.94848;
              207.84,1.99202; 244.303,2.0283; 292.434,2.07184; 352.233,2.10813;
              433.911,2.14441; 512.671,2.17344; 597.265,2.19521; 706.655,2.21698;
              800,2.23149; 1000,2.23149; 1500,2.23149],
          tabfal=[-1500,-2.22424; -1000,-2.22424; -798.541,-2.22424; -641.021,-2.19521;
              -476.208,-2.15167; -320.146,-2.07184; -187.42,-1.92671; -136.372,-1.84688;
              -111.577,-1.78882; -91.1577,-1.709; -76.5725,-1.63643; -57.6117,-1.49129;
              -44.485,-1.28084; -38.6509,-0.94703; -31.3582,-0.09797; -25.5242,0.83091;
              -19.6901,1.36792; -13.856,1.44775; -2.18778,1.52758; 8.02188,1.61466;
              28.4412,1.67997; 64.9043,1.78882; 95.5333,1.8579; 126.162,1.91945;
              159.708,1.96163; 207.84,2.00653; 244.303,2.03585; 292.434,2.07184;
              352.233,2.10813; 433.911,2.14441; 512.671,2.17344; 597.265,2.19521;
              706.655,2.21698; 800,2.23149; 1000,2.23149; 1500,2.23149],
          sigma=2.27e6);
        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/hysttd_Vacoflux48.png\">
   </td>
  </tr>
</table>
</html>"));
      end Vacoflux48;

      record Vacodur50 "Vacodur50"
        extends FluxTubes.Material.HysteresisTableData.BaseData(
          tabris=[-10000000.000,-2.137; -1500.000,-2.137; -1000.000,-2.137; -798.541,
              -2.137; -632.270,-2.108; -464.540,-2.072; -283.683,-1.999; -145.123,
              -1.912; -34.275,-1.825; 24.066,-1.716; 45.944,-1.644; 67.821,-1.549;
              85.324,-1.419; 101.367,-1.208; 121.787,-0.584; 131.996,-0.004; 146.582,
              0.795; 158.250,1.208; 175.752,1.586; 185.962,1.673; 206.381,1.753;
              235.552,1.847; 279.307,1.912; 347.858,1.970; 467.457,2.036; 594.348,
              2.072; 798.541,2.123; 1000.000,2.123; 1500.000,2.123; 10000000.000,
              2.123],
          tabfal=[-10000000.000,-2.137; -1500.000,-2.137; -1000.000,-2.137; -795.624,
              -2.130; -627.894,-2.094; -464.540,-2.036; -330.356,-1.963; -282.224,
              -1.927; -247.220,-1.876; -203.464,-1.753; -178.669,-1.629; -168.459,
              -1.477; -158.250,-1.274; -148.040,-0.983; -142.206,-0.541; -131.996,
              -0.105; -121.787,0.483; -102.826,1.085; -85.324,1.390; -53.236,1.578;
              -10.939,1.738; 56.153,1.825; 127.621,1.898; 200.547,1.941; 299.727,
              2.007; 385.779,2.043; 468.915,2.057; 800.000,2.123; 1000.000,2.123;
              1500.000,2.123; 10000000.000,2.123],
          sigma=2.38e6);
        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/hysttd_Vacodur50.png\">
   </td>
  </tr>
</table>
</html>"));
      end Vacodur50;

      record M270_50A "M270-50A"
        extends FluxTubes.Material.HysteresisTableData.BaseData(
          tabris=[-50000,-2.36142149079005; -37500,-2.34572149079005; -25000,-2.20784143083814;
              -12500,-1.94778131093431; -9500,-1.85604366776894; -9000,-1.83955155226256;
              -8500,-1.82258455430894; -8000,-1.80507033229993; -7500,-1.78711018607209;
              -7000,-1.76854566993810; -6500,-1.74932788983047; -6000,-1.72941810924188;
              -5500,-1.70874679619234; -5000,-1.68715955603320; -4500,-1.66464746674895;
              -4000,-1.64100464903791; -3500,-1.61593724456462; -3000,-1.58926699830608;
              -2500,-1.56035493729185; -2000,-1.52877764744974; -1500,-1.49303148569657;
              -1000,-1.45033726325941; -500,-1.39107814253068; -475,-1.38697746828591;
              -450,-1.38267482765617; -425,-1.37833105973775; -400,-1.37377662153415;
              -375,-1.36882438008219; -350,-1.36356879129129; -325,-1.35799622091367;
              -300,-1.35190077460742; -275,-1.34512176251881; -250,-1.33773575415686;
              -225,-1.32942423700513; -200,-1.31952959523452; -175,-1.30728420632473;
              -150,-1.29378356382414; -125,-1.27626065020945; -100,-1.25268401433474;
              -75,-1.22153894002743; -50,-1.17227751254882; -45,-1.16075298668474;
              -40,-1.14606393745292; -35,-1.13142982553525; -30,-1.11531942595351;
              -25,-1.09396956307260; -20,-1.07095509280378; -15,-1.04859501123272;
              -10,-1.02107504052280; -5,-0.989392176805378; 0,-0.959829637667445;
              5,-0.908604709968595; 10,-0.846864392654515; 15,-0.749655834487944;
              20,-0.398773687293659; 25,0.373311242081990; 30,0.590020294584589;
              35,0.671821320404104; 40,0.736659219518838; 45,0.791353153207790;
              50,0.838655490546030; 75,0.988585111647679; 100,1.07559475808794;
              125,1.13210758630769; 150,1.17332186681192; 175,1.20616261336206;
              200,1.23146912912525; 225,1.25215125877909; 250,1.26844972752130;
              275,1.28315829857436; 300,1.29515203325250; 325,1.30647370432217;
              350,1.31576370455381; 375,1.32425072416663; 400,1.33229409096317;
              425,1.34007989376204; 450,1.34727951499250; 475,1.35321892573422;
              500,1.35863485716407; 1000,1.43330411726965; 1500,1.48096951700072;
              2000,1.51920274857903; 2500,1.55230032928980; 3000,1.58218256821786;
              3500,1.60957343077396; 4000,1.63525269735252; 4500,1.65934255632023;
              5000,1.68218796544641; 5500,1.70405627320433; 6000,1.72494039832143;
              6500,1.74511951283721; 7000,1.76457818244663; 7500,1.78337203170120;
              8000,1.80154227627029; 8500,1.81922495056038; 9000,1.83634585185398;
              9500,1.85301443870688; 12500,1.94475208187226; 25000,2.20481220177608;
              37500,2.34269226172799; 50000,2.35839226172799],
          tabfal=[-50000,-2.36142149079005; -37500,-2.34572149079005; -25000,-2.20784143083814;
              -12500,-1.94778131093431; -9500,-1.85604366776894; -9000,-1.83942307876298;
              -8500,-1.82229989817775; -8000,-1.80468156576120; -7500,-1.78650645752764;
              -7000,-1.76779510063662; -6500,-1.74834500001267; -6000,-1.72817242280115;
              -5500,-1.70728853838413; -5000,-1.68540616617853; -4500,-1.66253513933876;
              -4000,-1.63841123419282; -3500,-1.61289397609053; -3000,-1.58542016678115;
              -2500,-1.55553231646565; -2000,-1.52241494895645; -1500,-1.48420672559264;
              -1000,-1.43662690910042; -500,-1.36140193513238; -475,-1.35578382798670;
              -450,-1.34963814839912; -425,-1.34267878891743; -400,-1.33485841403481;
              -375,-1.32703597143112; -350,-1.31847214273919; -325,-1.30814609379248;
              -300,-1.29797786984086; -275,-1.28582125972062; -250,-1.27062684432575;
              -225,-1.25467155812574; -200,-1.23320681958327; -175,-1.20836849729829;
              -150,-1.17466441368633; -125,-1.13213335917786; -100,-1.07327113174349;
              -75,-0.983943258578330; -50,-0.831860723978254; -45,-0.791174630360292;
              -40,-0.730860778213513; -35,-0.648944604927353; -30,-0.539436531904091;
              -25,-0.297969678679362; -20,0.423561463624426; -15,0.783143776259089;
              -10,0.870481236955322; -5,0.919860864365896; 0,0.958355916902741;
              5,0.995210026018745; 10,1.02830008136892; 15,1.05003168490807; 20,
              1.07204589744377; 25,1.09488735273993; 30,1.11425511031784; 35,1.13333619269922;
              40,1.14706537678261; 45,1.16224717605861; 50,1.17393024108665; 75,
              1.22100249420562; 100,1.25247361546262; 125,1.27577025429942; 150,
              1.29301878595457; 175,1.30648315753826; 200,1.31783072682881; 225,
              1.32740651813805; 250,1.33561633582420; 275,1.34310089621653; 300,
              1.34973173145922; 325,1.35576000065507; 350,1.36138307638896; 375,
              1.36668264869560; 400,1.37167426041476; 425,1.37635180685877; 450,
              1.38069509895108; 475,1.38477922097523; 500,1.38869331314083; 1000,
              1.44801140511640; 1500,1.49066348689616; 2000,1.52647802510402; 2500,
              1.55811034242703; 3000,1.58688253425227; 3500,1.61359336867843; 4000,
              1.63866877100998; 4500,1.66232889093008; 5000,1.68483122212201; 5500,
              1.70635087911731; 6000,1.72703063606343; 6500,1.74700304982812; 7000,
              1.76618126253122; 7500,1.78476734506602; 8000,1.80273806456998; 8500,
              1.82018416370832; 9000,1.83715524334565; 9500,1.85361777911541; 12500,
              1.94535542228079; 25000,2.20541554218462; 37500,2.34329560213653;
              50000,2.35899560213653],
          sigma=1.72e6);
        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/hysttd_M270-50A.png\">
   </td>
  </tr>
</table>
</html>"));
      end M270_50A;

      record M330_50A "M330-50A"
        extends FluxTubes.Material.HysteresisTableData.BaseData(
          tabris=[-50000,-2.44743549087484; -37500,-2.43173549087484; -25000,-2.29175406960198;
              -12500,-2.02749122705627; -9500,-1.93424060373981; -9000,-1.91734557383536;
              -8500,-1.90003831579647; -8000,-1.88228336311722; -7500,-1.86410325306585;
              -7000,-1.84544168583579; -6500,-1.82622653273328; -6000,-1.80643712142018;
              -5500,-1.78596588967781; -5000,-1.76475673275961; -4500,-1.74274295978669;
              -4000,-1.71958116023747; -3500,-1.69519681691703; -3000,-1.66922815434013;
              -2500,-1.64113365434545; -2000,-1.61012556776875; -1500,-1.57460825746692;
              -1000,-1.53154975676172; -500,-1.47050141163166; -475,-1.46622093109730;
              -450,-1.46200139454249; -425,-1.45756401383884; -400,-1.45283335606619;
              -375,-1.44773279142268; -350,-1.44239226856165; -325,-1.43674835101656;
              -300,-1.43044338373318; -275,-1.42369405062971; -250,-1.41658602660702;
              -225,-1.40843067805861; -200,-1.39918824257754; -175,-1.38897584817539;
              -150,-1.37684878370263; -125,-1.36190318298965; -100,-1.34364363168061;
              -75,-1.32096745150757; -50,-1.28806145284464; -45,-1.28061490419651;
              -40,-1.27162255870714; -35,-1.26154821540497; -30,-1.25078841368914;
              -25,-1.23833667771816; -20,-1.22599711027031; -15,-1.21088890996667;
              -10,-1.19741834476920; -5,-1.17811735498978; 0,-1.15454734935544;
              5,-1.13014547258613; 10,-1.10617621802212; 15,-1.06773732096551; 20,
              -1.02246701683548; 25,-0.902119509520453; 30,-0.558593283376474; 35,
              -0.158787116256930; 40,0.113151131584899; 45,0.336783141080566; 50,
              0.541865704013350; 75,0.955840735658849; 100,1.08873353832287; 125,
              1.16057378694876; 150,1.21270126546580; 175,1.24969229404607; 200,
              1.27939785471278; 225,1.30397489820994; 250,1.32243760947971; 275,
              1.33988626282660; 300,1.35445139381851; 325,1.36639472361266; 350,
              1.37831513730715; 375,1.38815641351734; 400,1.39715852973264; 425,
              1.40525966753328; 450,1.41256069744102; 475,1.42022154092164; 500,
              1.42690491746546; 1000,1.50993903640482; 1500,1.56009261898428; 2000,
              1.59913154972533; 2500,1.63215979009916; 3000,1.66178246326100; 3500,
              1.68850800352239; 4000,1.71272916087899; 4500,1.73572148025338; 5000,
              1.75764646474993; 5500,1.77872746673938; 6000,1.79900863540491; 6500,
              1.81866581587930; 7000,1.83769268690732; 7500,1.85624654695152; 8000,
              1.87427340278025; 8500,1.89178891688000; 9000,1.90886536500246; 9500,
              1.92560023719942; 12500,2.01885086051588; 25000,2.28311370306159;
              37500,2.42309512433445; 50000,2.43879512433445],
          tabfal=[-50000,-2.44743549087484; -37500,-2.43173549087484; -25000,-2.29175406960198;
              -12500,-2.02749122705627; -9500,-1.93424060373981; -9000,-1.91734557383536;
              -8500,-1.90003831579647; -8000,-1.88228336311722; -7500,-1.86396184546015;
              -7000,-1.84524857210249; -6500,-1.82591070525470; -6000,-1.80594439934052;
              -5500,-1.78531310330034; -5000,-1.76382025520505; -4500,-1.74142910912243;
              -4000,-1.71783221361736; -3500,-1.69280878752801; -3000,-1.66591530113576;
              -2500,-1.63649294648485; -2000,-1.60339863123377; -1500,-1.56442149385622;
              -1000,-1.51441561468259; -500,-1.43080809535224; -475,-1.42450289449529;
              -450,-1.41732721660085; -425,-1.40951882234757; -400,-1.40118064526704;
              -375,-1.39220914273277; -350,-1.38211113291766; -325,-1.37125742032855;
              -300,-1.35917182037113; -275,-1.34411680370286; -250,-1.32861822862062;
              -225,-1.30745835828352; -200,-1.28557369127376; -175,-1.25419814205060;
              -150,-1.21937409523818; -125,-1.16769743255509; -100,-1.08621953798151;
              -75,-0.949248973899088; -50,-0.463062524232745; -45,-0.241397022221927;
              -40,-0.0917328024445698; -35,0.182881911670973; -30,0.647941622043669;
              -25,0.925720611599761; -20,1.01589911772097; -15,1.06212781456762;
              -10,1.09723124440593; -5,1.13156726933814; 0,1.15460822013300; 5,1.17506808994058;
              10,1.19012140311265; 15,1.20695474596496; 20,1.22235157331926; 25,
              1.23492992961726; 30,1.24500433228815; 35,1.25511140047050; 40,1.26642123811028;
              45,1.27567122597037; 50,1.28254253926943; 75,1.31450423011738; 100,
              1.33781959105884; 125,1.35535350494447; 150,1.37076038889320; 175,
              1.38300521211089; 200,1.39317334290652; 225,1.40231271538781; 250,
              1.41003370402153; 275,1.41775224948779; 300,1.42443612181079; 325,
              1.43071011319246; 350,1.43632820821805; 375,1.44160298825063; 400,
              1.44689685195180; 425,1.45157598310516; 450,1.45604404631093; 475,
              1.46029335493483; 500,1.46434035987343; 1000,1.52527944546714; 1500,
              1.56827087926856; 2000,1.60364207715609; 2500,1.63460389841854; 3000,
              1.66261092660742; 3500,1.68850800352239; 4000,1.71272916087899; 4500,
              1.73572148025338; 5000,1.75764646474993; 5500,1.77872746673938; 6000,
              1.79900863540491; 6500,1.81866581587930; 7000,1.83769268690732; 7500,
              1.85624654695152; 8000,1.87427340278025; 8500,1.89178891688000; 9000,
              1.90886536500246; 9500,1.92560023719942; 12500,2.01885086051588; 25000,
              2.28311370306159; 37500,2.42309512433445; 50000,2.43879512433445],
          sigma=2.2e6);

        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/hysttd_M330-50A.png\">
   </td>
  </tr>
</table>
</html>"));
      end M330_50A;

      record M400_50A "M400-50A"
        extends FluxTubes.Material.HysteresisTableData.BaseData(
          tabris=[-50000,-2.40794008749097; -37500,-2.39224008749097; -25000,-2.24695058192848;
              -12500,-1.97207157080350; -9500,-1.87499912679850; -9000,-1.85751518672007;
              -8500,-1.83965523812239; -8000,-1.82141038807705; -7500,-1.80269741316036;
              -7000,-1.78361027358886; -6500,-1.76397706310715; -6000,-1.74376646292382;
              -5500,-1.72310546808403; -5000,-1.70181437219379; -4500,-1.67962462884578;
              -4000,-1.65666284827733; -3500,-1.63264436534337; -3000,-1.60708993405725;
              -2500,-1.57974973637101; -2000,-1.54982226707762; -1500,-1.51586253475425;
              -1000,-1.47496092753935; -500,-1.41663981975470; -475,-1.41272678886742;
              -450,-1.40867695906844; -425,-1.40429024210058; -400,-1.39949573135137;
              -375,-1.39437411472418; -350,-1.38910109228470; -325,-1.38358638889354;
              -300,-1.37741291943839; -275,-1.37055394225841; -250,-1.36313596477737;
              -225,-1.35455952163501; -200,-1.34470907175791; -175,-1.33378230144229;
              -150,-1.32070821907347; -125,-1.30469411228698; -100,-1.28463220674296;
              -75,-1.25712368223457; -50,-1.22156402021633; -45,-1.21248835333625;
              -40,-1.20398927138400; -35,-1.19366676583453; -30,-1.18308077897121;
              -25,-1.17112000211898; -20,-1.15424024453449; -15,-1.13849009536025;
              -10,-1.12200378482708; -5,-1.10250992067697; 0,-1.08424243844649;
              5,-1.05584135449536; 10,-1.02126486868300; 15,-0.992421905049552;
              20,-0.949405100423591; 25,-0.900754074748590; 30,-0.793043668212206;
              35,-0.543461193341693; 40,0.0460983803994556; 45,0.349171417184043;
              50,0.500051423262693; 75,0.858218702672487; 100,0.988821492542939;
              125,1.07418126307667; 150,1.12775610877896; 175,1.16833527822034;
              200,1.19966429488883; 225,1.22449543932453; 250,1.24530028024648;
              275,1.26418294609521; 300,1.27970325326426; 325,1.29226375074143;
              350,1.30381327176382; 375,1.31461362475715; 400,1.32412514622875;
              425,1.33300046485911; 450,1.34137963352322; 475,1.34908136246852;
              500,1.35559133448013; 1000,1.44068827636001; 1500,1.49232320632115;
              2000,1.53261053126646; 2500,1.56686963341284; 3000,1.59719357713455;
              3500,1.62461949559943; 4000,1.65018830452586; 4500,1.67439400887558;
              5000,1.69730736756213; 5500,1.71941215481472; 6000,1.74068353487267;
              6500,1.76130076608619; 7000,1.78127426070862; 7500,1.80062725888872;
              8000,1.81956050551157; 8500,1.83806221770118; 9000,1.85616144832625;
              9500,1.87384237012775; 12500,1.97091481413274; 25000,2.24579382525772;
              37500,2.39108333082021; 50000,2.40678333082021],
          tabfal=[-50000,-2.40794008749097; -37500,-2.39224008749097; -25000,-2.24695058192848;
              -12500,-1.97207157080350; -9500,-1.87499912679850; -9000,-1.85723961648917;
              -8500,-1.83914182012976; -8000,-1.82064286718470; -7500,-1.80170149544270;
              -7000,-1.78229030140852; -6500,-1.76238978953953; -6000,-1.74186533334584;
              -5500,-1.72064937133164; -5000,-1.69867319886329; -4500,-1.67570536641489;
              -4000,-1.65154759695206; -3500,-1.62602751204391; -3000,-1.59846991740992;
              -2500,-1.56817580922799; -2000,-1.53394382544710; -1500,-1.49351750990638;
              -1000,-1.44179121964259; -500,-1.35699503821154; -475,-1.35058208948424;
              -450,-1.34305096520136; -425,-1.33434484732302; -400,-1.32567786111080;
              -375,-1.31566996645446; -350,-1.30487255910588; -325,-1.29319860879985;
              -300,-1.28023272360678; -275,-1.26390126428613; -250,-1.24676054534940;
              -225,-1.22561280869116; -200,-1.19976520976629; -175,-1.16838696849014;
              -150,-1.12556294836344; -125,-1.06829053659527; -100,-0.985799775563185;
              -75,-0.852111241109577; -50,-0.492720171584574; -45,-0.278242753704216;
              -40,0.0448369570554025; -35,0.641381355833371; -30,0.802736389022337;
              -25,0.893394884424712; -20,0.949121302392295; -15,1.00155835207574;
              -10,1.03239600457521; -5,1.05524756193883; 0,1.08419795677726; 5,1.10137204522905;
              10,1.12479679237370; 15,1.13871579138954; 20,1.15405008546833; 25,
              1.16800772243013; 30,1.18098283835024; 35,1.19282831091812; 40,1.20269143661662;
              45,1.21148630541073; 50,1.22169947272959; 75,1.25854635534815; 100,
              1.28423656861203; 125,1.30451634362611; 150,1.32044675392559; 175,
              1.33356822941784; 200,1.34416172543795; 225,1.35388748675014; 250,
              1.36266379345288; 275,1.37005108590170; 300,1.37691263179040; 325,
              1.38311998030807; 350,1.38871246553893; 375,1.39407316354554; 400,
              1.39913287717800; 425,1.40385644364325; 450,1.40820401223748; 475,
              1.41229579159378; 500,1.41636730911577; 1000,1.47444101764742; 1500,
              1.51537103879942; 2000,1.54920274539220; 2500,1.57895514526599; 3000,
              1.60622369280379; 3500,1.63168409169342; 4000,1.65582030634452; 4500,
              1.67885056600531; 5000,1.70095243004908; 5500,1.72241606513783; 6000,
              1.74315976223534; 6500,1.76320320694510; 7000,1.78274594002133; 7500,
              1.80182103074219; 8000,1.82045219174860; 8500,1.83870653811386; 9000,
              1.85653503322130; 9500,1.87395783314220; 12500,1.97103027714719; 25000,
              2.24590928827217; 37500,2.39119879383466; 50000,2.40689879383466],
          sigma=3.22e6);

        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/hysttd_M400-50A.png\">
   </td>
  </tr>
</table>
</html>"));
      end M400_50A;

      record M400_50AP "M400-50AP"
        extends FluxTubes.Material.HysteresisTableData.BaseData(
          tabris=[-50000,-2.46382892861845; -37500,-2.44812892861845; -25000,-2.30818994558873;
              -12500,-2.04401197952928; -9500,-1.95079191174787; -9000,-1.93387674112452;
              -8500,-1.91672556778064; -8000,-1.89896942464980; -7500,-1.88073461400595;
              -7000,-1.86206758074805; -6500,-1.84279298755417; -6000,-1.82293917426668;
              -5500,-1.80230388639417; -5000,-1.78099763229757; -4500,-1.75874869462130;
              -4000,-1.73550951637937; -3500,-1.71090173903357; -3000,-1.68470473348043;
              -2500,-1.65633183092179; -2000,-1.62508354107692; -1500,-1.58945673773091;
              -1000,-1.54678762740518; -500,-1.48805055931781; -475,-1.48423891995731;
              -450,-1.48004980187494; -425,-1.47566539435348; -400,-1.47112736749377;
              -375,-1.46629117626267; -350,-1.46106365058826; -325,-1.45578439873425;
              -300,-1.45024393347103; -275,-1.44384833074375; -250,-1.43686477876995;
              -225,-1.42915277935868; -200,-1.42063394319262; -175,-1.41108689895730;
              -150,-1.39962738080824; -125,-1.38553227888587; -100,-1.36815309444647;
              -75,-1.34451261907668; -50,-1.31064672792780; -45,-1.30130000392603;
              -40,-1.29011128031286; -35,-1.27641439332424; -30,-1.26334375372063;
              -25,-1.25166624249455; -20,-1.23641244162183; -15,-1.22034808978838;
              -10,-1.20576927906433; -5,-1.18337366296358; 0,-1.15820720032109;
              5,-1.12319720329000; 10,-1.09595857510564; 15,-1.05606410752299; 20,
              -0.999110118045015; 25,-0.888838803452849; 30,-0.579572416199649;
              35,0.108724547956082; 40,0.497629081605811; 45,0.619843487025022;
              50,0.710919795734406; 75,1.00699336611590; 100,1.11949200274764; 125,
              1.19303802014454; 150,1.24146292713087; 175,1.27893709765235; 200,
              1.30790216535830; 225,1.33049099545422; 250,1.34886614236863; 275,
              1.36515185404256; 300,1.37866255521476; 325,1.39070623112655; 350,
              1.40108019942174; 375,1.41015975780422; 400,1.41863013677997; 425,
              1.42680652152224; 450,1.43405894041434; 475,1.44096910543117; 500,
              1.44716608767129; 1000,1.52657859162748; 1500,1.57566132262307; 2000,
              1.61442921237017; 2500,1.64765924917206; 3000,1.67728059650028; 3500,
              1.70449246758517; 4000,1.72974728303406; 4500,1.75356276150791; 5000,
              1.77613593000974; 5500,1.79734490172157; 6000,1.81785143984963; 6500,
              1.83764169193727; 7000,1.85684560873870; 7500,1.87546284116314; 8000,
              1.89361565580100; 8500,1.91130272210699; 9000,1.92850585042699; 9500,
              1.94523522262764; 12500,2.03845529040904; 25000,2.30263325646849;
              37500,2.44257223949821; 50000,2.45827223949821],
          tabfal=[-50000,-2.46382892861845; -37500,-2.44812892861845; -25000,-2.30818994558873;
              -12500,-2.04401197952928; -9500,-1.95079191174787; -9000,-1.93383868193463;
              -8500,-1.91641714272642; -8000,-1.89859545198052; -7500,-1.88022305703523;
              -7000,-1.86140480107545; -6500,-1.84194696861618; -6000,-1.82178502031352;
              -5500,-1.80099882340133; -5000,-1.77933152536594; -4500,-1.75675721368131;
              -4000,-1.73300740439535; -3500,-1.70779475482113; -3000,-1.68069079162634;
              -2500,-1.65105957378560; -2000,-1.61796187192022; -1500,-1.57931567521232;
              -1000,-1.53046463851206; -500,-1.45119364742972; -475,-1.44514068330733;
              -450,-1.43819841365508; -425,-1.43082858336197; -400,-1.42333429622881;
              -375,-1.41500193723060; -350,-1.40572943265705; -325,-1.39506609342774;
              -300,-1.38381293060116; -275,-1.37034205983274; -250,-1.35502271722346;
              -225,-1.33563207501628; -200,-1.31379388380889; -175,-1.28690380857075;
              -150,-1.25062187633717; -125,-1.20172681221045; -100,-1.13058070927231;
              -75,-1.01847079254535; -50,-0.773262273660970; -45,-0.670922877950458;
              -40,-0.520873450464802; -35,-0.215347366687344; -30,0.233189343929989;
              -25,0.824474360863061; -20,0.971400317810317; -15,1.03213316422303;
              -10,1.07516463012753; -5,1.10780824092723; 0,1.14713548342183; 5,1.16795524606017;
              10,1.19579823142800; 15,1.21532492908983; 20,1.23368599507119; 25,
              1.24744497272300; 30,1.26055274055566; 35,1.27386822207864; 40,1.28475215847344;
              45,1.29572380774099; 50,1.30298288864754; 75,1.33896606719870; 100,
              1.36309730594176; 125,1.38096649430808; 150,1.39488378292637; 175,
              1.40671263362037; 200,1.41681797855726; 225,1.42518599056065; 250,
              1.43272842101261; 275,1.43951928933170; 300,1.44587724763213; 325,
              1.45187209472306; 350,1.45721096962617; 375,1.46226908169060; 400,
              1.46714904797764; 425,1.47155977424238; 450,1.47587033754042; 475,
              1.48001915913557; 500,1.48395824378596; 1000,1.54292152451423; 1500,
              1.58537041880632; 2000,1.62086780535223; 2500,1.65195517411888; 3000,
              1.68019216457496; 3500,1.70625619278504; 4000,1.73080495757818; 4500,
              1.75401239418427; 5000,1.77613593000974; 5500,1.79734490172157; 6000,
              1.81785143984963; 6500,1.83764169193727; 7000,1.85684560873870; 7500,
              1.87546284116314; 8000,1.89361565580100; 8500,1.91130272210699; 9000,
              1.92850585042699; 9500,1.94523522262764; 12500,2.03845529040904; 25000,
              2.30263325646849; 37500,2.44257223949821; 50000,2.45827223949821],
          sigma=2.22e6);

        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/hysttd_M400-50AP.png\">
   </td>
  </tr>
</table>
</html>"));
      end M400_50AP;

      record M800_65A "M800-65A"
        extends FluxTubes.Material.HysteresisTableData.BaseData(
          tabris=[-50000,-2.41999852648723; -37500,-2.40429852648723; -25000,-2.27880094925962;
              -12500,-2.04350579480440; -9500,-1.96068353920052; -9000,-1.94568995233264;
              -8500,-1.93041822970326; -8000,-1.91475949701547; -7500,-1.89874433390909;
              -7000,-1.88236828095776; -6500,-1.86537308304654; -6000,-1.84783939049721;
              -5500,-1.82981032196217; -5000,-1.81107184740532; -4500,-1.79159897726765;
              -4000,-1.77123035482398; -3500,-1.74979929331988; -3000,-1.72692693859863;
              -2500,-1.70207572583859; -2000,-1.67452174917622; -1500,-1.64239094777668;
              -1000,-1.60247237131668; -500,-1.54533600718972; -475,-1.54168227527625;
              -450,-1.53757207272177; -425,-1.53354365522856; -400,-1.52930457910108;
              -375,-1.52501703732544; -350,-1.52047052595297; -325,-1.51534762021198;
              -300,-1.50988805208212; -275,-1.50448604508862; -250,-1.49864942593720;
              -225,-1.49267327153294; -200,-1.48607902904147; -175,-1.47826700048845;
              -150,-1.47049749975416; -125,-1.46165991590660; -100,-1.45073713730738;
              -75,-1.43953712623273; -50,-1.42606350889752; -45,-1.42306059615738;
              -40,-1.42003788116232; -35,-1.41677039682308; -30,-1.41311031012442;
              -25,-1.40937572039118; -20,-1.40539518874169; -15,-1.40139646331311;
              -10,-1.39733567044656; -5,-1.39316537981227; 0,-1.38859559387787;
              5,-1.38393180627993; 10,-1.37910270072745; 15,-1.37303527101498; 20,
              -1.36647146416808; 25,-1.36003055780954; 30,-1.35246976780151; 35,
              -1.34480250683144; 40,-1.33661841921041; 45,-1.32660958220509; 50,
              -1.31553366281474; 75,-1.20910700118601; 100,0.532882913959500; 125,
              1.02662015074423; 150,1.14103374810766; 175,1.21035479681112; 200,
              1.26117867073488; 225,1.29990005326361; 250,1.32928682416420; 275,
              1.35349589983733; 300,1.37497864892124; 325,1.39154723105790; 350,
              1.40623400788508; 375,1.41962698015960; 400,1.43092716185703; 425,
              1.44180550696708; 450,1.45154225103006; 475,1.46045094827107; 500,
              1.46827716942789; 1000,1.56502686789323; 1500,1.61813266260293; 2000,
              1.65691785176050; 2500,1.68862359484650; 3000,1.71602291200781; 3500,
              1.74076601755817; 4000,1.76360452982075; 4500,1.78385282919978; 5000,
              1.80316458712648; 5500,1.82176933161498; 6000,1.83977798278110; 6500,
              1.85715410433795; 7000,1.87401121805731; 7500,1.89035061534208; 8000,
              1.90631333368602; 8500,1.92193342101337; 9000,1.93701667085534; 9500,
              1.95187443686403; 12500,2.03469669246791; 25000,2.26999184692313;
              37500,2.39548942415074; 50000,2.41118942415074],
          tabfal=[-50000,-2.41999852648723; -37500,-2.40429852648723; -25000,-2.27880094925962;
              -12500,-2.04350579480440; -9500,-1.96068353920052; -9000,-1.94559764965089;
              -8500,-1.93012471087006; -8000,-1.91431436677689; -7500,-1.89804454750764;
              -7000,-1.88136056469418; -6500,-1.86414170412796; -6000,-1.84629637075897;
              -5500,-1.82783197926636; -5000,-1.80860853371515; -4500,-1.78849721730208;
              -4000,-1.76727398124316; -3500,-1.74455485772303; -3000,-1.71995764003778;
              -2500,-1.69263734912522; -2000,-1.66110452490584; -1500,-1.62250111260705;
              -1000,-1.56951283599084; -500,-1.47373308898170; -475,-1.46574359498977;
              -450,-1.45725321084224; -425,-1.44792419910822; -400,-1.43731948098116;
              -375,-1.42607124814977; -350,-1.41341880892223; -325,-1.39822468414060;
              -300,-1.38205239395401; -275,-1.36124323845596; -250,-1.33769536106313;
              -225,-1.30626151822381; -200,-1.27091203465938; -175,-1.22139379835218;
              -150,-1.15427523748093; -125,-1.02992248377946; -100,-0.608768490711078;
              -75,1.18882367706862; -50,1.30642658694914; -45,1.31694528126388;
              -40,1.32814566191774; -35,1.33514513339720; -30,1.34371244491101;
              -25,1.35168731983670; -20,1.35843175053249; -15,1.36469564105692;
              -10,1.37097132070720; -5,1.37590996027985; 0,1.38027193786232; 5,1.38486560748417;
              10,1.38948101768076; 15,1.39350772834206; 20,1.39753051177479; 25,
              1.40117224620763; 30,1.40481398064048; 35,1.40851870679405; 40,1.41223590538195;
              45,1.41547339350741; 50,1.41852318447409; 75,1.43211067244877; 100,
              1.44427442904375; 125,1.45435264246972; 150,1.46359132926859; 175,
              1.47161026636863; 200,1.47874657754524; 225,1.48569764333275; 250,
              1.49197145197213; 275,1.49786150413129; 300,1.50347448393359; 325,
              1.50857087126280; 350,1.51349777185305; 375,1.51810575247842; 400,
              1.52254893507848; 425,1.52673061275018; 450,1.53104072452336; 475,
              1.53492503963004; 500,1.53857480545245; 1000,1.59579332675057; 1500,
              1.63555234030539; 2000,1.66746001465413; 2500,1.69491356421077; 3000,
              1.71953285083828; 3500,1.74228408813402; 4000,1.76364065532799; 4500,
              1.78385282919978; 5000,1.80316458712648; 5500,1.82176933161498; 6000,
              1.83977798278110; 6500,1.85715410433795; 7000,1.87401121805731; 7500,
              1.89035061534208; 8000,1.90631333368602; 8500,1.92193342101337; 9000,
              1.93701667085534; 9500,1.95187443686403; 12500,2.03469669246791; 25000,
              2.26999184692313; 37500,2.39548942415074; 50000,2.41118942415074],
          sigma=3.27e6);

        annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/hysttd_M800-65A.png\">
   </td>
  </tr>
</table>
</html>"));
      end M800_65A;
      annotation (Documentation(info="<html>
<p>
Material table data for the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenTable\">GenericHystTellinenTable</a> flux tube element. The records contain two data tables <code>tabris</code> and <code>tabfal</code> describing the rising and the falling branch of the hysteresis envelope curve of the corresponding material. The first colum is the magnetic field strength H and has to be strictly monotonically increasing. The second collumn contains the corresponding values of the magnetic fluxdensity B. Both curves may not intersect each other.
</p>

<p>
Fig. 1 and Fig. 2 show library entries based on own measurements of several steel sheet qualities in two different ranges of the magnetic field strength. For the measurements a 25 cm Epstein frame was used according to DIN EN 60404-2.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 1:</strong> Static hysteresis envelope curves of several steel sheets</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/StaticLoops01.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 2:</strong> Static hysteresis envelope curves of several steel sheets</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/StaticLoops02.png\">
    </td>
  </tr>
</table>

<p>
Fig. 3 shows the static hysteresis loop library entries for soft magnetic cobalt-iron-alloys which were extracted from <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Va01]</a>.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 3:</strong> Soft magnetic cobalt iron library entries <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Va01]</a></caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/StaticLoops03.png\">
    </td>
  </tr>
</table>

</html>"));
    end HysteresisTableData;
    annotation (Documentation(info="<html>
</html>"));
  end Material;

  package Interfaces "Interfaces of magnetic network components"
    extends Modelica.Icons.InterfacesPackage;

    connector MagneticPort "Generic magnetic port"
      SI.MagneticPotential V_m "Magnetic potential at the port";
      flow SI.MagneticFlux Phi "Magnetic flux flowing into the port";

      annotation (defaultComponentName="mag");
    end MagneticPort;

    connector PositiveMagneticPort "Positive magnetic port"
      extends FluxTubes.Interfaces.MagneticPort;

      annotation (
        defaultComponentName="port_p",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,127,0},
              fillColor={255,127,0},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{-100,160},{-100,100}},
              lineColor={255,127,0},
              textString="%name"), Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={255,127,0},
              fillColor={255,127,0},
              fillPattern=FillPattern.Solid)}));

    end PositiveMagneticPort;

    connector NegativeMagneticPort "Negative magnetic port"
      extends FluxTubes.Interfaces.MagneticPort;

      annotation (
        defaultComponentName="port_n",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,127,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{100,160},{100,100}},
              lineColor={255,127,0},
              textString="%name"), Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={255,127,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));

    end NegativeMagneticPort;

    partial model PartialTwoPortsElementary
      "Partial component with two magnetic ports p and n for textual programming"

      FluxTubes.Interfaces.PositiveMagneticPort port_p "Positive magnetic port"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      FluxTubes.Interfaces.NegativeMagneticPort port_n "Negative magnetic port"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));

      annotation (Documentation(info="<html>
<p>
Partial model of a flux tube component with two magnetic ports:
the positive port connector port_p, and the negative port
connector port_n.
</p>
</html>"));
    end PartialTwoPortsElementary;

    partial model PartialTwoPorts
      "Partial component with magnetic potential difference of the two magnetic ports p and n and magnetic flux Phi from p to n"

      extends FluxTubes.Interfaces.PartialTwoPortsElementary;
      SI.MagneticPotentialDifference V_m
        "Magnetic potential difference of ports";
      SI.MagneticFlux Phi(start=0) "Magnetic flux from port_p to port_n";

    equation
      V_m = port_p.V_m - port_n.V_m;
      Phi = port_p.Phi;
      0 = port_p.Phi + port_n.Phi;

      annotation (Documentation(info="<html>
<p>
It is assumed that the magnetic flux flowing into port_p is identical to the flux flowing out of port_n.
This magnetic flux is provided explicitly as flux Phi.
</p>
</html>"));
    end PartialTwoPorts;

    partial model PartialFixedShape
      "Base class for flux tubes with fixed shape during simulation; linear or non-linear material characteristics"

      extends FluxTubes.Interfaces.PartialTwoPorts;

      parameter Boolean nonLinearPermeability=true
        "= true, if non-linear rel. permeability is used, otherwise constant rel. permeability"
        annotation (Dialog(group="Material"), Evaluate=true);
      parameter SI.RelativePermeability mu_rConst=1
        "Constant relative permeability; used if nonLinearPermeability = false"
        annotation (Dialog(group="Material", enable=not nonLinearPermeability));

      parameter FluxTubes.Material.SoftMagnetic.BaseData material=
          Material.SoftMagnetic.BaseData()
        "Ferromagnetic material characteristics; used if nonLinearPermeability = true"
        annotation (choicesAllMatching=true, Dialog(group="Material", enable=
              nonLinearPermeability));

      SI.Reluctance R_m "Magnetic reluctance";
      SI.Permeance G_m "Magnetic permeance";
      SI.MagneticFluxDensity B "Magnetic flux density";
      SI.CrossSection A "Cross-sectional area penetrated by magnetic flux";
      SI.MagneticFieldStrength H "Magnetic field strength";

      SI.RelativePermeability mu_r "Relative magnetic permeability";

    protected
      Real B_N "Absolute value of normalized B";

    equation
      B_N = abs(B/material.B_myMax);
      mu_r = if nonLinearPermeability then
        1 + (material.mu_i - 1 + material.c_a*B_N)/(1 + material.c_b*B_N + B_N^material.n) else mu_rConst;

      R_m = 1/G_m;
      V_m = Phi*R_m;
      B = Phi/A;
      H = B/(mu_0*mu_r);

      annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={255,128,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-70,0},{-90,0}}, color={255,128,0}),
          Line(points={{70,0},{90,0}}, color={255,128,0}),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255})}), Documentation(info="<html>
<p>
Please refer to the description of  the sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">Shapes.FixedShape</a> for utilisation of this partial model.
</p>
</html>"));
    end PartialFixedShape;

    partial model PartialForce
      "Base class for flux tubes with reluctance force generation; constant permeability"

      extends FluxTubes.Interfaces.PartialTwoPorts;

      parameter Boolean useSupport=false
        "= true, if support flange enabled, otherwise implicitly grounded"
        annotation (Evaluate=true, HideResult=true);

      parameter SI.RelativePermeability mu_r(start=1)
        "Relative magnetic permeability";

      SI.Force F_m "Reluctance force";
      Modelica.SIunits.Length s=flange.s - s_support
        "Distance between flange and support";

      SI.Reluctance R_m "Magnetic reluctance";
      SI.Permeance G_m "Magnetic permeance";
      SI.Permeability dGmBydx
        "Derivative of permeance with respect to armature position";
      parameter Integer dlBydx=1
        "Derivative of flux tube's varying dimension with respect to armature position; set to +1 or -1";

      Modelica.Mechanics.Translational.Interfaces.Flange_b flange
        "Generated reluctance force at armature position" annotation (Placement(
            transformation(extent={{-10,90},{10,110}})));
      Modelica.Mechanics.Translational.Interfaces.Support support(s=s_support,
          f=-flange.f) if useSupport "Support/housing of component" annotation (
         Placement(transformation(extent={{-10,-110},{10,-90}})));

    protected
      Modelica.SIunits.Length s_support "Absolute position of support flange";

    equation
      V_m = Phi*R_m;
      R_m = 1/G_m;
      F_m = 0.5*V_m^2*dGmBydx;

      if not useSupport then
        s_support = 0;
      end if;
      flange.f = -F_m;

      annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{30,30},{70,-30}},
            lineColor={255,128,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-70,0},{-90,0}}, color={255,128,0}),
          Line(points={{70,0},{90,0}}, color={255,128,0}),
          Text(
            extent={{-150,-80},{150,-40}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-10,-100},{-30,-120}}),
          Line(points={{-30,-100},{-50,-120}}),
          Line(points={{-30,-100},{30,-100}}),
          Line(points={{10,-100},{-10,-120}}),
          Line(points={{30,-100},{10,-120}}),
          Rectangle(
            extent={{-70,30},{-30,-30}},
            lineColor={255,128,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-10,80},{10,-30}},
            fillColor={0,127,0},
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
Please refer to the description of  the sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Shapes.Force</a> for utilisation of this partial model.
</p>
</html>"));
    end PartialForce;

    partial model PartialLeakage
      "Base class for leakage flux tubes with position-independent permeance and hence no force generation; mu_r=1"

      extends FluxTubes.Interfaces.PartialTwoPorts;

      SI.Reluctance R_m "Magnetic reluctance";
      SI.Permeance G_m "Magnetic permeance";

    equation
      V_m = Phi*R_m;
      R_m = 1/G_m;

      annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={255,128,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-70,0},{-90,0}}, color={255,128,0}),
          Line(points={{70,0},{90,0}}, color={255,128,0}),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255})}), Documentation(info="<html>
<p>
Please refer to the description of  the sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a> for utilisation of this partial model.
</p>
</html>"));
    end PartialLeakage;

    partial model PartialGeneric "Partial Tellinen hysteresis model"
      extends Interfaces.PartialTwoPorts;

      // Group Fixed Geometry (Cuboid)
      parameter SI.Length l=0.1 "Length in direction of flux" annotation (Dialog(group="Fixed geometry", groupImage=
              "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Interfaces/GenericParallelFlux.png"));

      parameter SI.Area A=1e-4 "Area of cross section" annotation (Dialog(group="Fixed geometry", groupImage=
              "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/GenericParallelFlux.png"));
      final parameter SI.Volume V = A * l "Volume of FluxTube";
      annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-150,50},{150,90}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{-70,0},{-100,0}}, color={255,128,0}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{70,0},{100,0}}, color={255,128,0})}),
                                     Documentation(info="<html>
</html>"));
    end PartialGeneric;

    partial model ConditionalHeatPort
      "Partial model to include a conditional HeatPort in order to describe the power loss via a thermal network"

      parameter Boolean useHeatPort = false "=true, if HeatPort is enabled"
      annotation(Evaluate=true, HideResult=true, choices(checkBox=true), Dialog(tab="Losses and Heat", group="HeatPort"));
      parameter Modelica.SIunits.Temperature T=293.15
        "Fixed device temperature if useHeatPort = false" annotation(Dialog(tab="Losses and Heat", group="HeatPort", enable=not useHeatPort));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(final T=T_heatPort, final Q_flow=-LossPower) if useHeatPort
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
            iconTransformation(extent={{-10,-110},{10,-90}})));
      Modelica.SIunits.Power LossPower
        "Loss power leaving component via HeatPort";
      Modelica.SIunits.Temperature T_heatPort "Temperature of HeatPort";
    equation
      if not useHeatPort then
         T_heatPort = T;
      end if;

      annotation (Documentation(revisions="<html>
<ul>
<li><em>February 17, 2009</em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
<p>
This partial model provides a conditional heating port for the connection to a thermal network.
</p>
<ul>
<li> If <strong>useHeatPort</strong> is set to <strong>false</strong> (default), no heat port is available, and the thermal
     loss power flows internally to the ground. In this case, the parameter <strong>T</strong> specifies
     the fixed device temperature (the default for T = 20<sup>o</sup>C).</li>
<li> If <strong>useHeatPort</strong> is set to <strong>true</strong>, a heat port is available.</li>
</ul>

<p>
If this model is used, the loss power has to be provided by an equation in the model which inherits from
ConditionalHeatingPort model (<strong>lossPower = ...</strong>). As device temperature
<strong>T_heatPort</strong> can be used to describe the influence of the device temperature
on the model behaviour.
</p>
</html>"));
    end ConditionalHeatPort;

    partial model PartialGenericHysteresis "Partial hysteresis model"
      extends Interfaces.PartialGeneric;
      extends Interfaces.ConditionalHeatPort(final T=293.15);

      parameter Boolean includeEddyCurrents = false
        "=true, if eddy current losses are enabled"
      annotation(Dialog(tab="Losses and Heat", group="Eddy Currents"), Evaluate=true, HideResult=true, choices(checkBox=true));

      parameter SI.Conductivity sigma=10e6 "Conductivity of core material" annotation (Dialog(tab="Losses and Heat", group="Eddy Currents", enable=includeEddyCurrents));
      parameter SI.Length d = 0.5e-3 "Thickness of lamination" annotation (Dialog(tab="Losses and Heat", group="Eddy Currents", enable=includeEddyCurrents));

      output SI.MagneticFieldStrength H(start=0) "Magnetic field strength";
      output SI.MagneticFieldStrength Hstat
        "Static (ferromagnetic) portion of the magnetic field strength";
      output SI.MagneticFieldStrength Heddy
        "Dynamic (eddy currents) portion of the magnetic field strength";
      output SI.MagneticFluxDensity B "Magnetic flux density";
      output Real MagRel(final quantity="Relative magnetization", final unit="1", start=0, min=-1, max=1)
        "Relative magnetization at initialization (-1..1)";
      output SI.Power LossPowerStat "Ferromagnetic (static) hysteresis losses";
      output SI.Power LossPowerEddy
        "Eddy current losses (dynamic hysteresis losses)";
      //output SI.Power LossPower "Total power loss of core (ferromagnetic + eddy currents)"; // defined in ConditionalHeatPort
      Real derHstat(start=0, unit="A/(m.s)")=der(Hstat);

    protected
      final parameter Real eddyCurrentFactor(final unit="S.m") = (sigma * d^2)/12;

    equation
      der(MagRel)=0;

      H = Hstat + Heddy;
      H = V_m/l;
      Phi = B*A;

      Heddy = if includeEddyCurrents then eddyCurrentFactor* der(B)  else 0;

      LossPowerStat = Hstat * der(B) * V;
      LossPowerEddy = Heddy * der(B) * V;
      LossPower = LossPowerStat + LossPowerEddy;
      annotation (Icon(graphics={Line(
              points={{-30,-20},{-14,-20},{-6,-16},{2,0},{10,16},{18,20},{26,20}},
              color={255,128,0},
              smooth=Smooth.Bezier), Line(
              points={{-30,-20},{-14,-20},{-6,-16},{2,0},{10,16},{18,20},{26,20}},
              color={255,128,0},
              smooth=Smooth.Bezier,
              origin={-4,0},
              rotation=180)}));
    end PartialGenericHysteresis;

    partial model PartialGenericHysteresisTellinen
      "Partial Tellinen hysteresis model"
      extends Interfaces.PartialGenericHysteresis;

      //Real MagRel(start=0, min=-100, max=100) "Relative magnetization at initialization (-100-100%)";
      output Boolean asc(start=true) "True when der(Hstat)>0";
    protected
      SI.MagneticFluxDensity hystR "Rising branch of limiting hysteresis loop";
      SI.MagneticFluxDensity hystF "Falling branch of limiting hysteresis loop";

      SI.MagneticFluxDensity diffHyst
        "Distance between rising and falling limiting hysteresis branch at the current operating point";
      Real dHyst(final quantity="MagneticFluxDensitySlope", final unit="T/s")
        "Slope of the Rising (when der(H)>0) or Falling (when der(H)<0) limiting hysteresis branch at the current operating point";
      Real k;

      parameter Real mu0(final unit="N/A2") = mu_0;

    initial equation

      B = (hystR+hystF)/2 + MagRel*diffHyst/2;

    equation

      asc = der(Hstat) > 0;

      der(B) = k * dHyst + mu0 * der(Hstat);

      diffHyst = hystF - hystR;

      if initial() then
        k = 0.01;
        dHyst = 0;
      elseif asc then
        dHyst = der(hystR-mu0*Hstat);
        k = max(0.01,(hystF - B)/diffHyst);
      else
        dHyst = der(hystF-mu0*Hstat);
        k = max(0.01, (B - hystR)/diffHyst);
      end if;

      annotation (Documentation(info="<html>
<p>A reluctance with the Tellinen hysteresis model. The major hysteresis loop is defined by the hyperbolic tangent function.</p>
<h4>The Tellinen Hysteresis Model</h4>
<p>The Tellinen hysteresis model is a simple model to describe the magnetic hysteresis behavior of ferromagnetic materials. It only uses the rising (hystR) and falling (hystF) branch of the major hysteresis loop and their derivatives der(hystR) and der(hystF). See Fig. 1 and the following equations for a short description of the Tellinen hysteresis model.</p>
<blockquote><pre>
diffHyst = hystF - hystR;
dhR = hystF - b;
dhF = b - hystR;
</pre></blockquote>
<p>if the magnetic field intensity increases (der(h)&gt;0)</p>
<blockquote><pre>
der(b) = dhR/diffHyst * der(hystR);
</pre></blockquote>
<p>if the magnetic field intensity decreases (der(h)&lt;0)</p>
<blockquote><pre>
der(b) = dhF/diffHyst * der(hystF);
</pre></blockquote>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\"><tr>
<td><p><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Tellinen/TellinenDesc1.png\"/></p></td>
</tr>
</table>
<strong>Fig. 1:</strong> Description of the Tellinen hysteresis model.
</html>"));
    end PartialGenericHysteresisTellinen;
    annotation (Documentation(info="<html>
<p>
This package contains connectors for the magnetic domain and partial models for lumped magnetic network components.
</p>

</html>"));
  end Interfaces;

  package Sources
    "Sources of different complexity of magnetomotive force and magnetic flux"
    extends Modelica.Icons.SourcesPackage;

    model ConstantMagneticPotentialDifference "Constant magnetomotive force"

      extends FluxTubes.Interfaces.PartialTwoPortsElementary;
      parameter SI.MagneticPotentialDifference V_m
        "Magnetic potential difference";
      SI.MagneticFlux Phi "Magnetic flux from port_p to port_n";

    equation
      V_m = port_p.V_m - port_n.V_m;
      Phi = port_p.Phi;
      0 = port_p.Phi + port_n.Phi;

      annotation (
        defaultComponentName="magVoltageSource",
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
            extent={{-50,-50},{50,50}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{100,0},{50,0}}, color={255,127,0}),
          Line(points={{-50,0},{-100,0}}, color={255,127,0}),
          Text(
            extent={{-150,60},{150,100}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-50,0},{50,0}}, color={255,127,0}),
            Line(points={{-70,30},{-70,10}}, color={255,128,0}),
            Line(points={{-80,20},{-60,20}}, color={255,128,0}),
            Line(points={{60,20},{80,20}}, color={255,128,0})}),
        Documentation(info="<html>
<p>
Magnetic circuits under steady-state conditions, i.e., with stationary magnetic fields (change of magnetic flux  d&Phi;/dt = 0) can be described with constant sources of a magnetic potential difference or magnetomotive force (mmf). Constant magnetic potential differences are imposed by
</p>
<ul>
<li>coils with stationary current (di / dt = 0) and</li>
<li>permanent magnets modelled with <em>Th&eacute;venin</em>'s equivalent magnetic circuit.</li>
</ul>
<p>
For modelling of reluctance actuators with this source component it is assumed that the armature is fixed so that no motion-induced flux change d&Phi;/dt can occur.
</p>
</html>"));
    end ConstantMagneticPotentialDifference;

    model SignalMagneticPotentialDifference
      "Signal-controlled magnetomotive force"

      extends FluxTubes.Interfaces.PartialTwoPortsElementary;
      Modelica.Blocks.Interfaces.RealInput V_m(unit="A")
        "Magnetic potential difference"
        annotation (Placement(transformation(
            origin={0,90},
            extent={{10,-10},{-10,10}},
            rotation=90), iconTransformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={0,110})));
      SI.MagneticFlux Phi "Magnetic flux from port_p to port_n";

    equation
      V_m = port_p.V_m - port_n.V_m;
      Phi = port_p.Phi;
      0 = port_p.Phi + port_n.Phi;
      annotation (
        defaultComponentName="magVoltageSource",
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-100,0},{-50,0}}, color={255,127,0}),
          Line(points={{50,0},{100,0}}, color={255,127,0}),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255}),
          Ellipse(
            extent={{-50,-50},{50,50}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-50,0},{50,0}}, color={255,127,0}),
            Line(points={{-70,30},{-70,10}}, color={255,128,0}),
            Line(points={{-80,20},{-60,20}}, color={255,128,0}),
            Line(points={{60,20},{80,20}}, color={255,128,0})}),
        Documentation(info="<html>
<p>
In electromagnetic devices, a change of a coil's magnetic flux linkage &Psi; reacts on the electrical subsystem in that a voltage v is induced due to <em>Faraday</em>'s law:
</p>
<pre>
    v = - d&Psi;/dt
</pre>
<p>This reaction can possibly be neglected for</p>
<ul>
<li>modelling of electromagnetic actuators under quasi-stationary conditions (slow current change, slow armature motion),</li>
<li>modelling of current-controlled electromagnetic actuators (ideal current source) and</li>
<li>for system simulation where the system dynamics is not governed by an electromagnetic actuator, but by the surrounding subsystems.</li>
</ul>
<p>
In these cases, the magnetic potential difference or magnetomotive force imposed by a coil can easily be modelled with a signal-controlled source. Except for the neglected dynamics, steady-state actuator forces will be calculated properly in actuator models based on these sources.
</p>
</html>"));
    end SignalMagneticPotentialDifference;

    model ConstantMagneticFlux "Source of constant magnetic flux"

      extends FluxTubes.Interfaces.PartialTwoPortsElementary;
      parameter SI.MagneticFlux Phi=1 "Magnetic flux";
      SI.MagneticPotentialDifference V_m
        "Magnetic potential difference between both ports";

    equation
      V_m = port_p.V_m - port_n.V_m;
      Phi = port_p.Phi;
      0 = port_p.Phi + port_n.Phi;
      annotation (
        defaultComponentName="magFluxSource",
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-150,60},{150,100}},
            textString="%name",
            lineColor={0,0,255}),
          Polygon(
            points={{80,0},{60,6},{60,-6},{80,0}},
            lineColor={255,128,0},
            fillColor={255,128,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-100,0},{-50,0}}, color={255,127,0}),
          Line(points={{50,0},{100,0}}, color={255,127,0}),
          Ellipse(
            extent={{-50,-50},{50,50}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{0,50},{0,-50}}, color={255,127,0})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={Line(points={{-125,0},{-115,0}}, color={160,160,164}),
              Line(points={{-120,-5},{-120,5}}, color={160,160,164}),
              Line(points={{115,0},{125,0}}, color={160,160,164})}),
        Documentation(info="<html>
<p>
Sources of a constant magnetic flux are useful for modelling of permanent magnets with <em>Norton</em>'s magnetic equivalent circuit.
</p>
</html>"));
    end ConstantMagneticFlux;

    model SignalMagneticFlux "Signal-controlled magnetic flux source"

      extends FluxTubes.Interfaces.PartialTwoPortsElementary;
      Modelica.Blocks.Interfaces.RealInput Phi(unit="Wb") "Magnetic flux" annotation (
          Placement(transformation(
            origin={0,110},
            extent={{10,-10},{-10,10}},
            rotation=90), iconTransformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={0,110})));
      SI.MagneticPotentialDifference V_m
        "Magnetic potential difference between both ports";

    equation
      V_m = port_p.V_m - port_n.V_m;
      Phi = port_p.Phi;
      0 = port_p.Phi + port_n.Phi;
      annotation (
        defaultComponentName="magFluxSource",
        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Polygon(
            points={{80,0},{60,6},{60,-6},{80,0}},
            lineColor={255,128,0},
            fillColor={255,128,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-100,0},{-50,0}}, color={255,127,0}),
          Line(points={{50,0},{100,0}}, color={255,127,0}),
          Ellipse(
            extent={{-50,-50},{50,50}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{0,50},{0,-50}}, color={255,127,0})}),
        Documentation(info="<html>
<p>
This source of a magnetic flux is intended for test purposes, e.g., for simulation and subsequent plotting of a softmagnetic material's magnetisation characteristics if used together with a non-linear reluctance element.
</p>
</html>"));
    end SignalMagneticFlux;

    annotation (Documentation(info="<html>
<p>
This package contains sources of a magnetic potential difference or a magnetic flux:
</p>
</html>"));
  end Sources;

  package Sensors "Sensors to measure variables in magnetic networks"
    extends Modelica.Icons.SensorsPackage;

    model MagneticPotentialDifferenceSensor
      "Sensor to measure magnetic potential difference"
      extends Modelica.Icons.RotationalSensor;
      extends FluxTubes.Interfaces.PartialTwoPortsElementary;

      Modelica.Blocks.Interfaces.RealOutput V_m(final quantity=
            "MagneticPotential", final unit="A")
        "Magnetic potential difference between ports p and n as output signal"
        annotation (Placement(transformation(
            origin={0,-100},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      SI.MagneticFlux Phi "Magnetic flux from port_p to port_n";

    equation
      V_m = port_p.V_m - port_n.V_m;
      Phi = port_p.Phi;
      Phi = 0;
      0 = port_p.Phi + port_n.Phi;

      annotation (defaultComponentName="magVoltageSensor",
    Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-52,1},{48,-57}},
              textString="V_m"),
            Line(points={{-70,0},{-90,0}}, color={255,128,0}),
            Line(points={{70,0},{90,0}}, color={255,128,0}),
            Line(points={{0,-90},{0,-70}}),
            Text(
              extent={{-150,120},{150,80}},
              textString="%name",
              lineColor={0,0,255})}), Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={Line(points={{-70,0},{-100,0}}, color={255,128,0}),
              Line(points={{70,0},{100,0}}, color={255,128,0}),Line(
              points={{0,-100},{0,-70}})}));
    end MagneticPotentialDifferenceSensor;

    model MagneticFluxSensor "Sensor to measure magnetic flux"
      extends FluxTubes.Interfaces.PartialTwoPortsElementary;
      extends Modelica.Icons.RotationalSensor;

      Modelica.Blocks.Interfaces.RealOutput Phi(final quantity="MagneticFlux",
          final unit="Wb")
        "Magnetic flux from port p to port n as output signal" annotation (
          Placement(transformation(
            origin={0,-100},
            extent={{10,-10},{-10,10}},
            rotation=90)));
    equation
      port_p.V_m = port_n.V_m;
      Phi = port_p.Phi;
      0 = port_p.Phi + port_n.Phi;

      annotation (defaultComponentName="magFluxSensor",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Line(points={{0,-100},{0,-70}}),Line(points={{-70,0},{-90,0}}, color={255,128,0}),
                                                                                                            Line(
              points={{70,0},{90,0}}, color={255,128,0}),
                                      Text(extent={{-29,-11},{30,
              -70}}, textString="Phi"),Text(
                  extent={{-150,120},{150,80}},
                  textString="%name",
                  lineColor={0,0,255}),Line(points={{0,-90},{0,-70}})}));
    end MagneticFluxSensor;
    annotation (Documentation(info="<html>
<p>
For analysis of magnetic networks, only magnetic potential differences and magnetic flux are variables of interest. For that reason, a magnetic potential sensor is not provided.
</p>
</html>"));
  end Sensors;

  package Utilities "Package with utility functions"
    extends Modelica.Icons.FunctionsPackage;
    function everett "Everett function, see [YUY89]"
      extends Modelica.Icons.Function;
      import Modelica.Constants.pi;
      input SI.MagneticFieldStrength a_;
      input SI.MagneticFieldStrength b_;
      input FluxTubes.Material.HysteresisEverettParameter.BaseData p;
      input Boolean mirror "If true then J(a,b)=-J(b,a) else J(a,b)=0 for a<b";

      output SI.MagneticFluxDensity J "Magnetic polarisation";

    protected
      SI.MagneticFieldStrength a;
      SI.MagneticFieldStrength b;
      SI.MagneticFieldStrength h1;
      SI.MagneticFieldStrength h2;
      SI.MagneticFieldStrength h3;
      SI.MagneticFieldStrength h4;
      constant SI.MagneticFluxDensity unitT=1;

    algorithm
      if a_>=b_ or mirror then

        a :=if a_ > p.Hsat then p.Hsat elseif a_ < -p.Hsat then -p.Hsat else a_;
        b :=if b_ > p.Hsat then p.Hsat elseif b_ < -p.Hsat then -p.Hsat else b_;

        h1:=-b-p.Hc;
        h2:=a-p.Hc;
        h3:=-a-p.Hc;
        h4:=b-p.Hc;

        J:= unitT*(
            (p.M*p.r*(2/pi*atan(p.q*h1)+1)+(2*p.M*(1-p.r))/(1+1/2*(exp(-p.p1*h1)+exp(-p.p2*h1))))*
            (p.M*p.r*(2/pi*atan(p.q*h2)+1)+(2*p.M*(1-p.r))/(1+1/2*(exp(-p.p1*h2)+exp(-p.p2*h2))))-
            (p.M*p.r*(2/pi*atan(p.q*h3)+1)+(2*p.M*(1-p.r))/(1+1/2*(exp(-p.p1*h3)+exp(-p.p2*h3))))*
            (p.M*p.r*(2/pi*atan(p.q*h4)+1)+(2*p.M*(1-p.r))/(1+1/2*(exp(-p.p1*h4)+exp(-p.p2*h4)))));
      else
        J:=0;
      end if;
      annotation (Documentation(info="<html>
</html>"));
    end everett;

    function initPreisach
      "Function used for the initialization of the Preisach hysteresis model GenericHystPreisachEverett"
      extends Modelica.Icons.Function;

      input SI.MagneticFieldStrength x;
      input SI.MagneticFieldStrength H;
      input FluxTubes.Material.HysteresisEverettParameter.BaseData p;
      output SI.MagneticFluxDensity B;

    protected
      SI.MagneticFieldStrength hmax;
      SI.MagneticFieldStrength H_l;

    algorithm
      H_l :=if H <= -p.Hsat then -p.Hsat elseif H >= p.Hsat then p.Hsat else H;
      hmax :=abs(H) + abs(x);
      B := if x < 0
      then
         -0.5*everett(hmax,-hmax,p,false)
         + everett(H_l, -hmax, p, false)
         + p.K*mu_0*H
      else
        0.5*everett(hmax, -hmax, p, false)
         - everett(hmax, H_l, p, false) + p.K*mu_0*H;

    end initPreisach;

  end Utilities;
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
Copyright &copy; 2005-2018, Modelica Association and Thomas B&ouml;drich.
</p>
<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
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
