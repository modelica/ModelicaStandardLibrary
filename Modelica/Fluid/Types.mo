within Modelica.Fluid;
package Types "Common types for fluid models"
  extends Modelica.Icons.Package;

  type HydraulicConductance = Modelica.Icons.TypeReal (
      final quantity="HydraulicConductance",
      final unit="kg/(s.Pa)") "Real type for hydraulic conductance";
  type HydraulicResistance = Modelica.Icons.TypeReal (
      final quantity="HydraulicResistance",
      final unit="Pa.s/kg") "Real type for hydraulic resistance";

  type Roughness = Modelica.Icons.TypeReal (final quantity="Length", final unit="m", displayUnit="mm")
    "Real type for roughness of a pipe"
    annotation (Documentation(info="<html>
<p>
This Real type defines the absolute roughness of the inner surface of a
pipe or fitting, i.e., the absolute average height of surface asperities.
It has usually to
be estimated. In <i>[Idelchik 1994, pp. 105-109,
Table 2-5; Miller 1990, p. 190, Table 8-1]</i> many examples are given.
As a short summary:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td colspan=\"2\" align=\"center\"><b>Type of pipe</b></td>
      <td align=\"center\">Roughness</td></tr>

  <tr><td><b>Smooth pipes</b></td>
      <td>Drawn brass, coper, aluminium, glass, etc.</td>
      <td> 0.0025 mm</td>
  </tr>
  <tr><td rowspan=\"3\"><b>Steel pipes</b></td>
      <td>New smooth pipes</td>
      <td>0.025 mm</td>
  </tr>
  <tr><td>Mortar lined, average finish</td>
      <td>0.1 mm</td>
  </tr>
  <tr><td>Heavy rust</td>
      <td>1 mm</td>
  </tr>
  <tr><td rowspan=\"3\"><b>Concrete pipes</b></td>
      <td>Steel forms, first class workmanship</td>
      <td>0.025 mm</td>
  </tr>
  <tr><td>Steel forms, average workmanship</td>
      <td>0.1 mm</td>
  </tr>
  <tr><td>Block linings</td>
      <td>1 mm</td>
  </tr>
</table>

<h4>References</h4>

<dl>
    <dt>Idelchik I.E. (1994):</dt>
    <dd><a href=\"http://www.bookfinder.com/dir/i/Handbook_of_Hydraulic_Resistance/0849399084/\"><b>Handbook
        of Hydraulic Resistance</b></a>. 3rd edition, Begell House, ISBN
        0-8493-9908-4</dd>
    <dt>Miller D. S. (1990):</dt>
    <dd><b>Internal flow systems</b>.
    2nd edition. Cranfield:BHRA(Information Services).</dd>
</dl>
</html>"));
  type Dynamics = enumeration(
      DynamicFreeInitial
        "DynamicFreeInitial -- Dynamic balance, Initial guess value",
      FixedInitial "FixedInitial -- Dynamic balance, Initial value fixed",
      SteadyStateInitial
        "SteadyStateInitial -- Dynamic balance, Steady state initial with guess value",

      SteadyState "SteadyState -- Steady state balance, Initial guess value")
    "Enumeration to define definition of balance equations"
  annotation (Documentation(info="<html>
<p>
Enumeration to define the formulation of balance equations
(to be selected via choices menu):
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Dynamics.</b></th><th><b>Meaning</b></th></tr>
<tr><td>DynamicFreeInitial</td><td>Dynamic balance, Initial guess value</td></tr>

<tr><td>FixedInitial</td><td>Dynamic balance, Initial value fixed</td></tr>

<tr><td>SteadyStateInitial</td><td>Dynamic balance, Steady state initial with guess value</td></tr>

<tr><td>SteadyState</td><td>Steady state balance, Initial guess value</td></tr>
</table>

<p>
The enumeration \"Dynamics\" is used for the mass, energy and momentum balance equations
respectively. The exact meaning for the three balance equations is stated in the following
tables:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><td colspan=\"3\"><b>Mass balance</b> </td>
<tr><td><b>Dynamics.</b></td>
    <td><b>Balance equation</b></td>
    <td><b>Initial condition</b></td></tr>

<tr><td> DynamicFreeInitial</td>
    <td> no restrictions </td>
    <td> no initial conditions </td></tr>

<tr><td> FixedInitial</td>
    <td> no restrictions </td>
    <td> <b>if</b> Medium.singleState <b>then</b> <br>
         &nbsp;&nbsp;no initial condition<br>
         <b>else</b> p=p_start </td></tr>

<tr><td> SteadyStateInitial</td>
    <td> no restrictions </td>
    <td> <b>if</b> Medium.singleState <b>then</b> <br>
         &nbsp;&nbsp;no initial condition<br>
         <b>else</b> <b>der</b>(p)=0 </td></tr>

<tr><td> SteadyState</td>
    <td> <b>der</b>(m)=0  </td>
    <td> no initial conditions </td></tr>
</table>

&nbsp;<br>

<table border=1 cellspacing=0 cellpadding=2>
<tr><td colspan=\"3\"><b>Energy balance</b> </td>
<tr><td><b>Dynamics.</b></td>
    <td><b>Balance equation</b></td>
    <td><b>Initial condition</b></td></tr>

<tr><td> DynamicFreeInitial</td>
    <td> no restrictions </td>
    <td> no initial conditions </td></tr>

<tr><td> FixedInitial</td>
    <td> no restrictions </td>
    <td> T=T_start or h=h_start </td></tr>

<tr><td> SteadyStateInitial</td>
    <td> no restrictions </td>
    <td> <b>der</b>(T)=0 or <b>der</b>(h)=0 </td></tr>

<tr><td> SteadyState</td>
    <td> <b>der</b>(U)=0  </td>
    <td> no initial conditions </td></tr>
</table>

&nbsp;<br>

<table border=1 cellspacing=0 cellpadding=2>
<tr><td colspan=\"3\"><b>Momentum balance</b> </td>
<tr><td><b>Dynamics.</b></td>
    <td><b>Balance equation</b></td>
    <td><b>Initial condition</b></td></tr>

<tr><td> DynamicFreeInitial</td>
    <td> no restrictions </td>
    <td> no initial conditions </td></tr>

<tr><td> FixedInitial</td>
    <td> no restrictions </td>
    <td> m_flow = m_flow_start </td></tr>

<tr><td> SteadyStateInitial</td>
    <td> no restrictions </td>
    <td> <b>der</b>(m_flow)=0 </td></tr>

<tr><td> SteadyState</td>
    <td> <b>der</b>(m_flow)=0 </td>
    <td> no initial conditions </td></tr>
</table>

<p>
In the tables above, the equations are given for one-substance fluids. For multiple-substance
fluids and for trace substances, equivalent equations hold.
</p>

<p>
Medium.singleState is a medium property and defines whether the medium is only
described by one state (+ the mass fractions in case of a multi-substance fluid). In such
a case one initial condition less must be provided. For example, incompressible
media have Medium.singleState = <b>true</b>.
</p>

</html>"));

  type CvTypes = enumeration(
      Av "Av (metric) flow coefficient",
      Kv "Kv (metric) flow coefficient",
      Cv "Cv (US) flow coefficient",
      OpPoint "Av defined by operating point")
    "Enumeration to define the choice of valve flow coefficient" annotation (
      Documentation(info="<html>

<p>
Enumeration to define the choice of valve flow coefficient
(to be selected via choices menu):
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>CvTypes.</b></th>
    <th><b>Meaning</b></th></tr>

<tr><td>Av</td>
    <td>Av (metric) flow coefficient</td></tr>

<tr><td>Kv</td>
    <td>Kv (metric) flow coefficient</td></tr>

<tr><td>Cv</td>
    <td>Cv (US) flow coefficient</td></tr>

<tr><td>OpPoint</td>
    <td>Av defined by operating point</td></tr>

</table>

<p>
The details of the coefficients are explained in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">
   User's Guide </a>.
</p>

</html>"));

  type PortFlowDirection = enumeration(
      Entering "Fluid flow is only entering",
      Leaving "Fluid flow is only leaving",
      Bidirectional "No restrictions on fluid flow (flow reversal possible)")
    "Enumeration to define whether flow reversal is allowed" annotation (
      Documentation(info="<html>

<p>
Enumeration to define the assumptions on the model for the
direction of fluid flow at a port (to be selected via choices menu):
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>PortFlowDirection.</b></th>
    <th><b>Meaning</b></th></tr>

<tr><td>Entering</td>
    <td>Fluid flow is only entering the port from the outside</td></tr>

<tr><td>Leaving</td>
    <td>Fluid flow is only leaving the port to the outside</td></tr>

<tr><td>Bidirectional</td>
    <td>No restrictions on fluid flow (flow reversal possible)</td></tr>
</table>

<p>
The default is \"PortFlowDirection.Bidirectional\". If you are completely sure that
the flow is only in one direction, then the other settings may
make the simulation of your model faster.
</p>

</html>"));

  type ModelStructure = enumeration(
      av_vb "av_vb: port_a - volume - flow model - volume - port_b",
      a_v_b "a_v_b: port_a - flow model - volume - flow model - port_b",
      av_b "av_b: port_a - volume - flow model - port_b",
      a_vb "a_vb: port_a - flow model - volume - port_b")
    "Enumeration with choices for model structure in distributed pipe model"
    annotation (Documentation(info="<html>

<p>
Enumeration to define the discretization structure of
distributed pipe models according to the staggered grid scheme:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>ModelStructure.</b></th>
    <th><b>Meaning</b></th></tr>

<tr><td>av_vb</td>
    <td>port_a - volume - flow model - volume - port_b</td></tr>

<tr><td>a_v_b</td>
    <td>port_a - flow model - volume - flow model - port_b</td></tr>

<tr><td>av_b</td>
    <td>port_a - volume - flow model - port_b</td></tr>

<tr><td>a_vb</td>
    <td>port_a - flow model - volume - port_b</td></tr>
</table>

<p>
The default is \"ModelStructure.av_vb\", i.e., the distributed pipe
has \"volumes\" at its both ends. The advantage is that connections
of the pipe to flow models (like fittings) lead to the desirable structure
of alternating volume and flow models, which means that no non-linear
algebraic equations occur.
</p>

<p>
Direct connections of distributed pipes with
this option means that two volumes are directly connected together. Due to the
stream concept this means that the pressures of the two connected volumes
are identical, but the temperatures are not set equal
(this corresponds to volumes that are connected together with a very
short distance and it needs some time until different volume temperatures
are equilibrated). Since the pressures of the volumes are identical, the number
of states is reduced and index reduction takes place (which means that medium
equations depending on pressure are differentiated and the number of required
initial conditions is reduced by one).
</p>

<p>
The default option \"av_vb\" cannot be used, if the dynamic pipe is connected to a model with non-differentiable pressure, like a Sources.Boundary_pT with prescribed jumping pressure. The modelStructure can be configured as appropriate in such situations, in order to place a momentum balance between a pressure state of the pipe and a non-differentiable boundary condition
(e.g., if the jumping pressure component is connected to port_a, use model structure
ModelStructure.a_vb).
</p>

</html>"));

  annotation (preferedView="info",
              Documentation(info="<html>

</html>"));
end Types;
