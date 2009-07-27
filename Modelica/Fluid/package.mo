within ;
package Modelica_Fluid "Modelica_Fluid, 1.0: One-dimensional thermo-fluid flow models using the Modelica.Media media description (requires package Modelica 3.0 or later, and stream connector support in the Modelica tool)"
  extends Modelica.Icons.Library;
  import SI = Modelica.SIunits;

package UsersGuide "Users Guide"

  annotation (DocumentationClass=true, Documentation(info="<HTML>
 
<p>
The library <b>Modelica_Fluid</b> is a <b>free</b> Modelica package provided under the
<a href=\"Modelica://Modelica_Fluid.UsersGuide.ModelicaLicense2\">Modelica License 2</a>.
The library contains components describing
<b>1-dimensional thermo-fluid flow</b> in networks of pipes. A unique feature is that the
component equations and the media models
as well as pressure loss and heat transfer correlations are decoupled from each other.
All components are implemented such that they can be used for
media from the Modelica.Media library. This means especially that an
incompressible or compressible medium, a single or a multiple
substance medium with one or more phases might be used.
The goal is to include
the Modelica_Fluid library in the Modelica standard library as Modelica.Fluid.
</p>
</HTML>"));

  class Overview "Overview"

    annotation (Documentation(info="<HTML>
<p>
The Modelica_Fluid library provides basic interfaces and
components to model 1-dimensional thermo-fluid flow in networks of pipes.
It is not the intention that this library covers all
application cases because the fluid flow area is too large and
because for special applications it is possible to implement
libraries with simpler component interfaces.
Instead, the goal is that the Modelica_Fluid library provides
a <b>reasonable set of components</b> and that it <b>demonstrates</b>
how to implement components of a fluid flow library in Modelica,
in particular to cope with difficult issues such as connector
design, reversing flow and initialization. It is planned to
include more components in the future. User proposals are
welcome.
</p>
<p>
This library has the following main features:
</p>
<ul>
<li> The connectors Modelica_Fluid.Interfaces.FluidPort_a/_b are designed
     for one-dimensional flow of a <b>single substance</b>
     or of a <b>mixture of substances</b> with optional <b>multiple phases</b>.
     All media models from Modelica.Media can be utilized when
     connecting components. For one substance media, the additional arrays for
     multiple
     substance media have zero dimension and are therefore removed
     from the code during translation. The general connector definition
     therefore does not introduce an overhead for special cases.<br>&nbsp;</li>
<li> All the components of the Modelica_Fluid library are designed
     that they can be utilized for all media models from
     Modelica.Media if this is posssible. For example, all media can
     be utilized for the Modelica_Fluid.Sensors/Sources components.
     For some components only special media are possible, since additional
     functionality is required. For example,
     Modelica_Fluid.Components.Evaporator requires a two phase medium
     (extending from Modelica.Media.Interfaces.PartialTwoPhaseMedium).
     <br>&nbsp;</li>
<li> In order to simplify the initialization in the components,
     there is the restriction that only media models are supported
     that have T, (p,T), (p,h), (T,X), (p,T,X) or (p,h,X) as
     independent variables. Other media models would be possible,
     e.g., with (T,d) as independent variables. However, this requires
     to rewrite the code for the component initialization.
     (Note, T is temperature, p is pressure, d is density,
     h is specific enthalpy, and X is a mass fraction vector).
     <br>&nbsp;</li>
<li> All components work for <b>incompressible</b> and <b>compressible</b> media.
     This is implemented by a small change in the initialization of a
     component, if the medium is incompressible. Otherwise, the equations
     of the components are not influenced by this property.<br>&nbsp;</li>
<li> All components allow fluid flow in both directions, i.e.,
     <b>reversing flow</b> is supported. However, it is possible to declare that
     the flow through a component only has the design direction, in order to
     obtain faster simulation code.<br>&nbsp;</li>
<li> Two or more components can be connected together. This means that
     the pressures of all connected ports are equal and the mass flow rates
     sum up to zero. Specific enthalpy, mass fractions and trace substances are
     mixed according to the mass flow rates.<br>&nbsp;</li>
<li> The <b>momentum balance</b> and the <b>energy balance</b> are only fulfilled exactly if
     <b>two ports of equal diameter</b> are connected. In all other cases, the balances
     are approximated, because kinetic and friction effect are neglected. An explicit fitting
     or junction should be used if these are important for the specific problem at hand.
     In all circuits where friction dominates, or components such as pumps determine the flow rate,
     kinetic pressure is typically irrelevant. You can consider the 
     <a href=\"Modelica://Modelica_Fluid.Examples.Explanatory.MomentumBalanceFittings\">
     Modelica_Fluid.Examples.Explanatory.MomentumBalanceFittings</a> model (and its documentation)
     to see one case where the momentum balance essentially depends on kinetic pressure,
     so it is necessary to use explicit fittings in order to obtain correct results. 
     <br>&nbsp;</li>
<li> Given the above-mentioned limitations, there is no restriction how components can be connected
     together. The resulting simulation performance however often strongly depends on the
     model structure and modeling assumptions made. In particular the direct connection of
     fluid volumes generally results in high-index DAEs for the pressures. The direct
     connection of flow models generally results in systems of implicit nonlinear algebraic
     equations.<br>&nbsp;</li> 
</ul>
</HTML>
"));
  equation

  end Overview;

  class GettingStarted "Getting started"

    annotation (Documentation(info="<html>
 
<p>
Please explore the
<a href=\"Modelica://Modelica_Fluid.Examples\">Examples</a>,
which provide simple models for a broad variety of applications.
</p>
</html>
"));
  equation

  end GettingStarted;

  package ComponentDefinition "Component definition"

    annotation (Documentation(info="<html>
 
<p>
In this section it is described how the components
of the Modelica_Fluid library are implemented.
If you would like to introduce new components either in
Modelica_Fluid or your own library, you should be aware
of the issues discussed in this section.
</p>
<p>
This section is partly based on the following paper:
</p>
<dl>
<dt> Elmqvist H., Tummescheit H., and Otter M.:</dt>
<dd> <b>Object-Oriented Modeling of Thermo-Fluid Systems</b>.
     Modelica 2003 Conference, Link&ouml;ping, Sweden,
     pp. 269-286, Nov. 3-4, 2003.
     Download from:
     <a href=\"http://www.modelica.org/Conference2003/papers/h40_Elmqvist_fluid.pdf\">http://www.modelica.org/Conference2003/papers/h40_Elmqvist_fluid.pdf</a>
     </dd>
</dl>
Please note that the design of the connectors has been changed with respect to the design presented in that paper.
</html>
"));

  class FluidConnectors "Fluid connectors"

    annotation (Documentation(info="<html>
<p>
In this section the design of the fluid connectors is
explained. </p>
<p>Fluid connectors represent the points in a device (e.g. the
flanges) through which a fluid can flow into or out of the component, carrying its
thermodynamic properties; these flanges are assumed to be fixed in space. </p>
<p>
A major design goal is that components can be arbitrarily
connected and that the important balance equations are automatically
fulfilled when 2 or more components are connected together at
one point as shown in the next figure:
</p>
<p align=\"center\">
<img src=\"../Images/UsersGuide/MixingConnections.png\">
</p>
<p>
In such a case the balance equations define <b>ideal mixing</b>,
i.e., the upstream discretization scheme of each component uses
values that result from ideal mixing in
an infinitely small time period. If more realistic modelling
is desired that takes into account mixing losses, an explicit
model has to be used in the connection point.
</p>
<h4><font color=\"#008000\">Single substance media</font></h4>
<p>
For a single substance medium, the connector definition in
Modelica_Fluid.Interfaces.FluidPort reduces to
</p>
<pre>
  <b>connector</b> FluidPort
     <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
              \"Medium model of the fluid\";
     <b>flow</b> Medium.MassFlowRate m_flow;
              \"Mass flow rate from the connection point into the component\"; 
     Medium.AbsolutePressure p 
              \"Thermodynamic pressure in the connection point\";
     <b>stream</b> Medium.SpecificEnthalpy h_outflow
               \"Specific thermodynamic enthalpy close to the connection point if m_flow &lt; 0\";
  <b>end</b> FluidPort;
</pre> 
<p>
The first statement defines the Medium flowing through the connector.
In a medium, medium specific types such as \"Medium.AbsolutePressure\"
are defined that contain medium specific values for the min, max and
nominal attributes. Furthermore, Medium.MassFlowRate is defined as:
</p>
<pre>
   <b>type</b> MassFlowRate = 
      Modelica.SIunits.MassFlowRate(quantity=\"MassFlowRate.\" + mediumName);
</pre>
<p>
With the current library design, it is necessary to explictly select the medium
model for each component in a circuit. This model is then propagated to the ports,
and a Modelica translator will check that the quantity and unit attributes
of connected interfaces are identical. Therefore, an error occurs,
if connected FluidPorts do not have a medium with the same medium name.
In the future, automatic propagation of fluid models through the ports will be
introduced, but this still not possible with Modelica 3.0.
</p>
 
<p>
The thermodynamic pressure is an <i>effort</i> variable, which means that the connection
of two or more ports states that the port pressures are the same. 
</p>
 
<p>
The mass flow rate is a <i>flow </i>variable, which means that the connection of two or
more ports states that the sum of all flow rates is zero.
<p>
 
<p>
The last variable is a <i>stream</i> variable, i.e., a specific quantity carried by the
flow variable. The quantity on the connector always
corresponds to the value close to the connection point, assuming that the fluid is
flowing out of the connector, regardless of the actual direction of the flow. This helps
avoiding singularities when the mass flow goes through zero. The stream properties for the
other flow direction can be inquired with the built-in operator inStream(..), while the
value of the stream variable corresponding to the actual flow direction can be inquired
through the built-in operator actualStream(..).
</p>
<p>
The actual equations corresponding to these operators are introduced and solved automatically
by the tool. In principle, they correspond to the balance equation 
sum(flow_variable) = 0 and sum(flow_variable*stream_variable_at_connection) = 0 applied to the set of connected ports. In this case the first equation is the mass balance sum(m_flow) = 0, and the second is the energy balance at the connection point sum(m_flow*h_connection) = 0. 
</p>
<p>
In the simpler case of a one-to-one connections between port_a and port_b,
inStream(port_a.h_outflow) just returns port_b.h_outflow. For multiple-way connections,
mixing equations are generated, and special care is taken in order to avoid discontinuities
around zero flow rates. For more details, see this 
<a href=\"..\\help\\Documentation\\Stream-Connectors-Overview-Rationale.pdf\">presentation</a>
which illustrates the stream concept rationale and the underlying technicalities. 
</p>
 
<p>
A connector should have only the minimal number of variables to
describe the interface, otherwise there will be connection
restrictions in certain cases. Therefore, in the connector
no redundant variables are present, e.g., the temperature T
is not present because it can be computed from the connector
variables pressure p and specific enthalpy h.
</p>
 
<p>
Here are two simple examples to illustrate modeling with stream connectors. The first
one is a rigid adiabatic volume mixing two flows, where the kinetic and gravitational
terms in the energy balance are neglected for simplicity.
</p>
 
<pre>
model MixingVolume \"Volume that mixes two flows\"
  replaceable package Medium = Modelica.Media.Interfaces.PartialPureSubstance;
  FluidPort port_a, port_b;
  parameter Modelica.SIunits.Volume V \"Volume of device\";
  Modelica.SIunits.Mass             m \"Mass in device\";
  Modelica.SIunits.Energy           U \"Inner energy in device\";
  Medium.BaseProperties medium(preferredMediumStates=true) \"Medium in the device\";
equation
  // Definition of port variables
  port_a.p         = medium.p;
  port_b.p         = medium.p;
  port_a.h_outflow = medium.h;  // The stream variable always corresponds to the
  port_b.h_outflow = medium.h;  // properties of the fluid holdup (outgoing flow)
 
  // Total quantities
  m = V*medium.d;
  U = m*medium.u;
   // Mass and energy balance (actualStream(..) is a built-in operator for streams to
  // compute the right h, depending on the flow direction)
  der(m) = port_a.m_flow + port_b.m_flow;
  der(U) = port_a.m_flow*actualStream(port_a.h_outflow) +
           port_b.m_flow*actualStream(port_b.h_outflow);
end MixingVolume;
</pre>
 
<p>
The second example is the model of a component describing a lumped pressure loss
between two ports, with no energy storage and no heat transfer. An isenthalpic
transformation is assumed (changes in kinetic and potential energy between
inlet and outlet are neglected)
</p>
<pre>
model PressureLoss \"Pressure loss component\"
  replaceable package Medium=Modelica.Media.Interfaces.PartialPureSubstance;
  FluidPort port_a, port_b:
  Medium.ThermodynamicState port_a_state_inflow \"State at port_a if inflowing\";
  Medium.ThermodynamicState port_b_state_inflow \"State at port_b if inflowing\";
  Medium density d_a, d_b \"Density at ports a and b if inflowing\";
  replaceable function f \"Function to compute the mass flow rate\";
equation
  // Medium states for inflowing fluid
  port_a_state_inflow = Medium.setState_phX(port_a.p, inStream(port_a.h_outflow));
  port_b_state_inflow = Medium.setState_phX(port_b.p, inStream(port_b.h_outflow));
  // Mass balance
  0 = port_a.m_flow + port_b.m_flow;
  // Instantaneous propagation of enthalpy flow between the ports with
  // isenthalpic state transformation (no storage and no loss of energy)
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);
  // (Regularized) Momentum balance
  port_a.m_flow = f(port_a.p, port_b.p, d_a, d_b);
end PressureLoss;
</pre>
 
<p>
If many such components are connected in series between two models with storage, the
specific enthalpies are propagated in both directions and available to all pressure
loss components, without problems when the mass flow goes through zero. The function
f then uses either d_a or d_b depending on the sign of port_a.p-port_b.p, with a
suitable regularization around zero to avoid discontinuities.
</p>
 
<p>
Please note that these models are highly idealized in order to explain the stream connector
concept. Device models in the library are much more complete, handling issues such as
initialization, steady vs. dynamic modelling, heat transfer from the outside, etc.
</p>
 
<h4><font color=\"#008000\">Multiple-substance media</font></h4>
<p>
Modelica_Fluid can handle models where the fluid contains multiple substances, so that its
composition can be characterized by mass fraction vectors. 
</p>
<pre>
<b>connector</b> FluidPort
   <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
      \"Medium model of the fluid\";
   <b>flow</b> Medium.MassFlowRate m_flow;
      \"Mass flow rate from the connection point into the component\" 
   Medium.AbsolutePressure p 
      \"Thermodynamic pressure in the connection point\";
   <b>stream</b> Medium.SpecificEnthalpy h_outflow
       \"Specific thermodynamic enthalpy close to the connection point if m_flow &lt; 0\";
   <b>stream</b> Medium.MassFraction Xi_outflow[Medium.nXi] 
       \"Independent mixture mass fractions m_i/m close to the connection point if m_flow &lt; 0\";
   <b>stream</b> Medium.ExtraProperty C_outflow[Medium.nC] 
       \"Properties c_i/m close to the connection point if m_flow &lt; 0\";
  <b>end</b> FluidPort;
</pre>
The mass fraction vectors Xi and C are also stream quantities, as they are carried by the mass
flow rate. The corresponding connection equations are sum(m_flow*Xi) and sum(m_flow*C), which correspond to mass balances for the single substances. The vector Xi contains the mass fractions
of the main components of the fluid, and is used together with p and h to determine the
thermodynamic state of the fluid. The vector C contains the mass fraction of the trace components,
which are accounted for in mass balances, but is ignored when computing the fluid properties. This
allows to easily declare and use medium models with trace components starting from existing medium
models (e.g. adding CO<sub>2</sub> traces to Moist Air for air conditioning models).
 
<h4><font color=\"#008000\">Approximations in balance equations at connection point</font></h4>
<p>
Summing up, when two or more ports of the type FluidPort are connected, the following
equations are generated by the tool:
</p>
<pre>
sum(port_j.m_flow) = 0;               // Total Mass balance
port_j = port_k;                      // Momentum balance
sum(port_j.m_flow*h_connection) = 0;  // Energy balance
sum(port_j.m_flow*Xi_connection) = 0; // Single component mass balances
sum(port_j.m_flow*C_connection) = 0;  // Trace components mass balances
</pre>
<p>
It is <b>very important</b> to bear in mind that
<ul>
<li> the mass balances are always exact; </li>
<li> the momentum and energy balance are only exact when two port with the same
diameter are connected, because there is no friction and no change in fluid velocity. </li>
</ul>
</p>
<p>
In all other cases, i.e., different port diameters and/or multple port connections: 
<ul>
<li> The momentum balance does not consider friction effects and changes of pressure due to changes
in velocity. </li>
<li> There might thus be errors in the momentum balance of the order of magnitude
of the dynamic pressure &rho;v<sup>2</sup>/2.</li>
<li> The energy balance does not consider the kinetic terms (gravity terms cancel out due
to the infinitesimal size of the connection volume). There might thus be errors in the
</li> momentum balance of the order of magnitude of the kinetic energy v^2/2. </li>
</ul>
In many applications, where fluid speeds are low and thermal phenomena are mainly of interest,
these approximations are commonly made and lead to acceptable results.
In all other cases, explicit fitting and junction models should be used, that model explicitly
all the kinetic phenomena with the appropriate level of detail.
</p></html>"));
  end FluidConnectors;

  class BalanceEquations "Balance equations"

    annotation (Documentation(info="<html>
 
<p>
For one-dimensional flow
along the coordinate \"x\", the following partial differential
equations hold
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td> Mass balance</td>
      <td> <img src=\"../Images/UsersGuide/massBalance.png\"></td>
  </tr>
  <tr><td> Momentum balance</td>
      <td> <img src=\"../Images/UsersGuide/momentumBalance.png\"></td>
  </tr>
  <tr><td> Energy balance 1</td>
      <td> <img src=\"../Images/UsersGuide/energyBalance1.png\"></td>
  </tr>
  <tr><td> Pipe friction</td>
      <td> <img src=\"../Images/UsersGuide/pipeFriction.png\"></td>
  </tr>
  <tr><td></td>
      <td>x: independent spatial coordinate (flow is along coordinate x)<br>
          t: time<br>
          v(x,t): mean velocity<br>
          p(x,t): mean pressure<br>
          T(x,t): mean temperature<br>
          &rho;(x,t): mean density<br>
          u(x,t): specific internal energy<br>
          z(x): height over ground<br>
          A(x): area perpendicular to direction x<br>
          g: gravity constant<br>
          f: Fanning friction factor<br>
          S: circumference
  </tr>
</table>
<p>
An alternative energy balance can be derived by multiplying
the momentum balance with \"v\" and substracting it
from the energy balance 1 above. This results in
the \"energy balance 2\":
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td> Energy balance 2</td>
      <td> <img src=\"../Images/UsersGuide/energyBalance2.png\"></td>
  </tr>
</table>
 
<p>
This formulation separates the internal energy of the fluid from the kinetic energy of fluid flow.
The internal energy is treated by the energy balance 2, the kinetic energy is treated by the momentum balance equally well.
The evaluation of medium properties, which are independent of the kinetic energy, and the formulation of many fluid models is simplified with the energy balance 2.
The overall conservation of energy is achieved by considering the mutual dependencies of energy and momentum balance.
</p>
<p>
Some components in the library, like DynamicPipe, provide a rigorous implementation of mass,
momentum and energy balance, using the energy balance 2 equation. Other components, like Valves and
Fittings, neglect the impact of changes of the kinetic energy and potential energy on the energy
balance, because they are usually irrelevant compared to changes due to heat flows. The StaticPipe
component neglects the effect of kinetic energy, but includes the potential energy in the balance,
which might be substantial. 
</p>
<p>
All modelling assumptions and simplifications are stated in the component documentation; please note that some of the assumptions might be stated in the base classes the
component inherits from.
</p>
</html>
"));
  end BalanceEquations;

  class UpstreamDiscretization "Upstream discretization"

    annotation (Documentation(info="<html>
 
<p>
When implementing a Fluid component, the difficult arises that
the value of intensive quantities (such as p, T, &rho;)
shall be accessed from the
<b>upstream</b> volume. For example, if the fluid flows
from volume A to volume B, then the intensive quantities of
volume B have no influence on the fluid between the
two volumes. On the other hand, if the flow direction is reversed,
the intensive quantities of volume A have no influence
on the fluid between the two volumes.
</p>
<p>
In the Modelica_Fluid library, such a situation is handeled
with the following code fragment
(from Interfaces.PartialTwoPortTransport):
</p>
<pre>    <b>replaceable package</b> Medium =
                   Modelica.Media.Interfaces.PartialMedium
                   <b>annotation</b>(choicesAllMatching = <b>true</b>);
 
    Interfaces.FluidPort_a port_a(<b>redeclare package</b> Medium = Medium);
    Interfaces.FluidPort_b port_b(<b>redeclare package</b> Medium = Medium);
 
    Medium.ThermodynamicState port_a_state_inflow
                    \"Medium state close to port_a for inflowing mass flow\";
    Medium.ThermodynamicState port_b_state_inflow
                    \"Medium state close to port_b for inflowing mass flow\";
 
  <b>equation</b>
    // Isenthalpic state transformation (no storage and no loss of energy)
    port_a.h_outflow  = <b>inStream</b>(port_b.h_outflow);
    port_b.h_outflow  = <b>inStream</b>(port_a.h_outflow);
 
    port_a.Xi_outflow = <b>inStream</b>(port_b.Xi_outflow);
    port_b.Xi_outflow = <b>inStream</b>(port_a.Xi_outflow);
 
    // Mass balance
    port_a.m_flow + port_b.m_flow = 0;
 
    // Medium states for inflowing medium
    port_a_state_inflow = Medium.setState_phX(port_a.p, port_b.h_outflow, port_b.Xi_outflow);
    port_b_state_inflow = Medium.setState_phX(port_b.p, port_a.h_outflow, port_a.Xi_outflow);
 
    // Densities close to the parts when mass flows in to the respective port
    port_a_rho_inflow = Medium.density(port_a_state_inflow);
    port_b_rho_inflow = Medium.density(port_b_state_inflow);
 
    // Pressure drop correlation (k_ab, k_ba are the loss factors for the two flow
    // directions; e.g. for a circular device: k = 8*zeta/(pi*diameter)^2)^2)
    m_flow = Utilities.regRoot2(port_a.p - port_b.p, dp_small,
                                port_a_rho_inflow/k1, port_b_rho_inflow/k2);
</pre>
<p>
The medium states for inflowing media can be used to compute density and dynamic
viscosity which in turn can be use to formulate the pressure drop equation.
The standard pressure drop equation
</p>
 
<pre>
   dp = port_a - port_b;
   m_flow = sqrt(2/(zeta*diameter))*if dp >= 0 then  sqrt(dp)
                                               else -sqrt(-dp)
</pre>
 
<p>
cannot be used, since the function has an infinite derivative at dp=0.
Instead the region around zero mass flow rate must be regularized using
one of the regularization functions of Modelica_Fluid.Utilities.
This requires to have density and/or other medium properties for both
flow directions at the same time. These media properties can be computed
from the medium states of the inflowing fluid at the two ports.
</p>
 
<p>
If the above component is connected between two volumes, i.e.,
the independent medium variables in port_a and port_b are
usually states, then port_a.h and port_b.h are either states
(i.e., known quantities in the model) or are computed from
states. In either case they are \"known\". In such a situation,
all equations can be directly evaluated without any problems.
Zero or reversed mass flow rate does not pose any problems because
the medium properties are always computed for both flow directions
and are then used in the regularization function.
</p>
 
<p>
If 3 or more components are connected together, it can be shown
that a system of non-linear algebraic equations appear.
The equations are written by purpose in such a form, that
a tool can select mass flow rates and pressures as iteration
variables of this system. The advantage is that these iteration
variables are continuous and even often differentiable. The
alternative to use the medium states as iteration variables
is not good, because T,h,d are discontinuous for reversing flow
direction.
</p>
</html>
"));
  end UpstreamDiscretization;

  class RegularizingCharacteristics "Regularizing characteristics"

    annotation (Documentation(info="<html>
 
<p>
Pressure drop equations and other fluid characteristics are usually
computed by <b>semi-empirical</b> equations. Unfortunately, the developers
of semi-empirical equations nearly never take into account that the
equation might be used in a simulation program. As a consequence, these
semi-empirical equations can nearly never be used blindly but must
be slightly modified or adapted in order that obvious
simulation problems are avoided. Below, examples are given to
demonstrate what problems occur and how to regularize the characteristics:
</p>
 
<h4><font color=\"#008000\">Square root function</font></h4>
<p>
In several empirical formulae, expressions of the following form
are present, e.g., for turbulent flow in a pipe:
</p>
<pre>   y = <b>if</b> x &lt; 0 <b>then</b> -<b>sqrt</b>( <b>abs</b>(x) ) <b>else</b> <b>sqrt</b>(x)
</pre>
<p>
A plot of this characteristic is shown in the next figure:
</p>
<p align=\"center\">
<img src=\"../Images/UsersGuide/sqrt.png\">
</p>
<p>                                                                                                                                                                            
The difficulty with this function is that the derivative at x=0 is infinity.
In reality, such a function does not exist. E.g., for pipe flow,
the flow becomes laminar for small velocities and therefore around zero the
sqrt() function is replaced by a linear function. Since the laminar region is
usually of not much practical interest, the above approximation is used.
</p>
<p>
The direct implementation above does not work in Modelica, because
an event is generated when x &lt; 0 changes sign. In order to detect
this event, an event iteration takes place. During the event iteration,
the active if-branch is not changed. For example, assume that x is positive
(= \"else\" branch) and shall become negative. During the event iteration
x is slightly negative and the else branch, i.e., sqrt(x), is evaluated.
Since this results in an imaginary number, an error occurs.
It would be possible to fix this, by using the <b>noEvent</b>() operator
to explicitly switch of an event:
</p>
<pre>   y = <b>if</b> <b>noEvent</b>(x &lt; 0) <b>then</b> -<b>sqrt</b>( <b>abs</b>(x) ) <b>else</b> <b>sqrt</b>(x)
</pre>
<p>
Still, it is highly likely that good integrators will not work well
around x=0, because they will recognize that the derivative changes very
sharply and will reduce the step size drastically.
</p>
<p>
There are several solutions around this problem: Around x=0, the sqrt() function
can be replaced by a polynomial of 3rd order which is determined in such a way
that it smoothly touches the sqrt() function, i.e., the whole function is continuous
and continuously differentiable. In the Modelica_Fluid library, implementations of
such critical functions are provided in sublibrary Modelica_Fluid.Utilities.
The above sqrt() type function is computed by function <b>Utilities.regRoot</b>().
This function is defined as:
</p>
<pre>     y := x/(x*x+delta*delta)^0.25;
</pre>
<p>
where \"delta\" is the size of the small region around zero where the
sqrt() function is approximated by another function. The plot of the
function above is practically identical to the one of the original function.
However, it has a finite derivative at x=0 and is differentiable upto
any order. With the default value of delta=0.01, the difference between
the function above and regRoot(x) is 16% around x=0.01, 0.25% around x=0.1
and 0.0025% around x=1.
</p>
</html>
"));
  end RegularizingCharacteristics;

  class WallFriction "Wall friction"

    annotation (Documentation(info="<html>
 
 
<p>
One important special case for a pressure loss is the friction at the
wall of a pipe under the assumption of quasi steady state flow (i.e., the
mass flow rate varies only slowly). In this section it is explained how this case is
handeled in the Modelica_Fluid library for pipes with
<b>nonuniform roughness</b>, including the smooth pipe
as a special case (see
<a href=\"Modelica://Modelica_Fluid.Pipes.BaseClasses.WallFriction\">Pipes.BaseClasses.WallFriction</a>.
The treatment is non-standard in order to get a
numerically well-posed description.
</p>
 
<p>
For pipes with circular cross section the pressure drop is computed as:
</p>
 
<pre>
   dp = &lambda;(Re,<font face=\"Symbol\">D</font>)*(L/D)*&rho;*v*|v|/2
      = &lambda;(Re,<font face=\"Symbol\">D</font>)*8*L/(&pi;^2*D^5*&rho;)*m_flow*|m_flow|
      = &lambda;2(Re,<font face=\"Symbol\">D</font>)*k2*sign(m_flow);
 
with
   Re     = |v|*D*&rho;/&mu;
          = |m_flow|*4/(&pi;*D*&mu;)
   m_flow = A*v*&rho;
   A      = &pi;*(D/2)^2
   &lambda;2     = &lambda;*Re^2
   k2     = L*&mu;^2/(2*D^3*&rho;)
</pre>
 
<p>
where
</p>
<ul>
<li> L is the length of the pipe.</li>
<li> D is the diameter of the pipe. If the pipe has not a
     circular cross section, D = 4*A/P, where A is the cross section
     area and P is the wetted perimeter.</li>
<li> &lambda; = &lambda;(Re,<font face=\"Symbol\">D</font>) is the \"usual\" wall friction coefficient.</li>
<li> &lambda;2 = &lambda;*Re^2 is the used friction coefficient to get a numerically
     well-posed formulation.</li>
<li> Re = |v|*D*&rho;/&mu; is the Reynolds number.</li>
<li> <font face=\"Symbol\">D</font> = <font face=\"Symbol\">d</font>/D is the relative roughness where
     \"<font face=\"Symbol\">d</font>\" is
     the absolute \"roughness\", i.e., the averaged height of asperities in the pipe
     (<font face=\"Symbol\">d</font> may change over time due to growth of surface asperities during
      service, see <i>[Idelchick 1994, p. 85, Tables 2-1, 2-2])</i>.</li>
<li> &rho; is the upstream density.</li>
<li> &mu; is the upstream dynamic viscosity.</li>
<li> v is the mean velocity.</li>
</ul>
<p>
The first form with &lambda; is used and presented in textbooks,
see \"blue\" curve in the next figure:
</p>
 
<IMG SRC=\"../Images/Components/PipeFriction1.png\" ALT=\"PipeFriction1\">
 
<p>
This form is not suited for a simulation program since
&lambda; = 64/Re if Re &lt; 2000, i.e., a division by zero occurs for
zero mass flow rate because Re = 0 in this case.
More useful for a simulation model is the friction coefficient
&lambda;2 = &lambda;*Re^2, because &lambda;2 = 64*Re if Re &lt; 2000 and
therefore no problems for zero mass flow rate occur.
The characteristic of &lambda;2 is shown in the next figure and is
used in Modelica_Fluid:
</p>
 
<IMG SRC=\"../Images/Components/PipeFriction2.png\" ALT=\"PipeFriction2\">
 
<p>
The pressure loss characteristic is divided into three regions:
</p>
 
<ul>
<li> <b>Region 1</b>:
     For <b>Re &le; 2000</b>, the flow is <b>laminar</b> and the exact solution of the
     3-dim. Navier-Stokes equations (momentum and mass balance) is used under the
     assumptions of steady flow, constant pressure gradient and constant
     density and viscosity (= Hagen-Poiseuille flow) leading to &lambda;2 = 64*Re.
     Therefore:
     <pre> dp = 128*&mu;*L/(&pi;*D^4*&rho;)*m_flow </pre> <br>&nbsp;
</li>
 
<li> <b>Region 3</b>:
     For <b>Re &ge; 4000</b>, the flow is <b>turbulent</b>.
     Depending on the calculation direction (see \"inverse formulation\"
     below) either of two explicite equations are used. If the pressure drop dp
     is assumed to be known, &lambda;2 = |dp|/k2. The
     Colebrook-White equation
     <i>[Colebrook 1939; Idelchik 1994, p. 83, eq. (2-9)]</i>:
     <pre>1/sqrt(&lambda;) = -2*lg( 2.51/(Re*sqrt(&lambda;)) + 0.27*<font face=\"Symbol\">D</font>) </pre>
     gives an implicit relationship between Re and &lambda;.
     Inserting &lambda;2 = &lambda;*Re^2 allows to solve this equation analytically
     for Re: <pre>Re = -2*sqrt(&lambda;2)*lg(2.51/sqrt(&lambda;2) + 0.27*<font face=\"Symbol\">D</font>)</pre>
     Finally, the mass flow rate m_flow is computed from Re via
     m_flow = Re*&pi;*D*&mu;/4*sign(dp).
     These are the <b>red</b> curves in the diagrams above.<br>
     If the mass flow rate is assumed known (and therefore implicitly
     also the Reynolds number), then &lambda;2 is computed by an
     approximation of the inverse of the Colebrook-White equation
     <i>[Swamee and Jain 1976;
     Miller 1990, p. 191, eq.(8.4)]</i> adapted to &lambda;2:
     <pre> &lambda;2 = 0.25*(Re/lg(<font face=\"Symbol\">D</font>/3.7 + 5.74/Re^0.9))^2 </pre>
     The pressure drop is then computed as dp = k2*&lambda;2*sign(m_flow).
     These are the <b>blue</b> curves in the diagrams above.<br>&nbsp;</li>
 
<li> <b>Region 2</b>:
     For <b>2000 &le; Re &le; 4000</b> there is a transition region between laminar
     and turbulent flow. The value of &lambda;2 depends on more factors as just
     the Reynolds number and the relative roughness, therefore only crude
     approximations are possible in this area.<br>
     The deviation from the laminar region depends on the
     relative roughness. A laminar flow at Re=2000 is only reached for smooth pipes.
     The deviation Reynolds number Re1 is computed according to
     <i>[Samoilenko 1968; Idelchik 1994, p. 81, sect. 2.1.21]</i> as:
     <pre>Re1 = 745*e^(if <font face=\"Symbol\">D</font> &le; 0.0065 then 1 else 0.0065/<font face=\"Symbol\">D</font>)</pre>
     These are the <b>blue</b> curves in the diagrams above.<br>
     Between Re1=Re1(<font face=\"Symbol\">d</font>/D) and Re2=4000,
     &lambda;2 is approximated by a cubic
     polynomial in the \"lg(&lambda;2) - lg(Re)\" chart (see figures above) such that the
     first derivative is continuous at these two points. In order to avoid
     the solution of non-linear equations, two different cubic polynomials are used
     for the direct and the inverse formulation. This leads to some discrepancies
     in &lambda;2 (= differences between the red and the blue curves).
     This is acceptable, because the transition region is anyway not
     precisely known since the actual friction coefficient depends on
     additional factors and since the operating points are usually
     not in this region.</li>
</ul>
<p>
The absolute roughness <font face=\"Symbol\">d</font> has usually to
be estimated. In <i>[Idelchik 1994, pp. 105-109,
Table 2-5; Miller 1990, p. 190, Table 8-1]</i> many examples are given.
As a short summary:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Smooth pipes</b></td>
      <td>Drawn brass, coper, aluminium, glass, etc.</td>
      <td><font face=\"Symbol\">d</font> = 0.0025 mm</td>
  </tr>
  <tr><td rowspan=\"3\"><b>Steel pipes</b></td>
      <td>New smooth pipes</td>
      <td><font face=\"Symbol\">d</font> = 0.025 mm</td>
  </tr>
  <tr><td>Mortar lined, average finish</td>
      <td><font face=\"Symbol\">d</font> = 0.1 mm</td>
  </tr>
  <tr><td>Heavy rust</td>
      <td><font face=\"Symbol\">d</font> = 1 mm</td>
  </tr>
  <tr><td rowspan=\"3\"><b>Concrete pipes</b></td>
      <td>Steel forms, first class workmanship</td>
      <td><font face=\"Symbol\">d</font> = 0.025 mm</td>
  </tr>
  <tr><td>Steel forms, average workmanship</td>
      <td><font face=\"Symbol\">d</font> = 0.1 mm</td>
  </tr>
  <tr><td>Block linings</td>
      <td><font face=\"Symbol\">d</font> = 1 mm</td>
  </tr>
</table>
<p>
The equations above are valid for incompressible flow.
They can also be applied for <b>compressible</b> flow up to about <b>Ma = 0.6</b>
(Ma is the Mach number) with a maximum error in &lambda; of about 3 %.
The effect of gas compressibility in a wide region can be taken into
account by the following formula derived by Voronin
<i>[Voronin 1959; Idelchick 1994, p. 97, sect. 2.1.81]</i>:
</p>
<pre>
  &lambda;_comp = &lambda;*(1 + (&kappa;-1)/2 * Ma^2)^(-0.47)
</pre>
<p>
where &kappa; is the isentropic coefficient
(for ideal gases, &kappa; is the ratio of specific heat capacities cp/cv).
An appreciable decrease in the coefficent \"&lambda;_comp\" is observed
only in a narrow transonic region and also at supersonic flow velocities
by about 15% <i>[Idelchick 1994, p. 97, sect. 2.1.81]</i>.
This effect is not yet included in Modelica_Fluid.
Another restriction is that the pressure drop model is valid
only for steady state or slowly changing mass flow rate.
For large fluid acceleration, the pressure drop depends additionally
on the frequency of the changing mass flow rate.
</p>
 
<h4><font color=\"#008000\">Inverse formulation</font></h4>
 
<p>
In the \"Advanced menu\" it is possible via parameter
\"from_dp\" to define in which form the
pressure drop equation is actually evaluated (<b>default</b> is from_dp = <b>true</b>):
</p>
<pre>
   from_dp = <b>true</b>:   m_flow = f1(dp)
           = <b>false</b>:  dp     = f2(m_flow)
</pre>
<p>
\"from_dp\" can be useful to avoid nonlinear systems of equations
in cases where the inverse pressure loss function is needed.
</p>
 
 
<h4><font color=\"#008000\">Summary</font></h4>
 
<p>
A detailed pressure drop model for pipe wall friction is
provided in the form m_flow = f1(dp, <font face=\"Symbol\">D</font>) or
dp = f2(m_flow, <font face=\"Symbol\">D</font>).
These functions are continuous and differentiable,
are provided in an explicit form without solving non-linear equations,
and do behave well also at small mass flow rates. This pressure drop
model can be used stand-alone in a static momentum balance and in
a dynamic momentum balance as the friction pressure drop term.
It is valid for incompressible and compressible flow up to a Mach number of 0.6.
</p>
 
<h4><font color=\"#008000\">References</font></h4>
 
<dl><dt>Colebrook F. (1939):</dt>
    <dd><b>Turbulent flow in pipes with particular reference to the transition
         region between the smooth and rough pipe laws</b>.
         J. Inst. Civ. Eng. no. 4, 14-25.</dd>
    <dt>Idelchik I.E. (1994):</dt>
    <dd><a href=\"http://www.begellhouse.com/books/00c0f05b040d2ec0.html\"><b>Handbook
        of Hydraulic Resistance</b></a>. 3rd edition, Begell House, ISBN
        0-8493-9908-4</dd>
    <dt>Miller D. S. (1990):</dt>
    <dd><b>Internal flow systems</b>.
    2nd edition. Cranfield:BHRA(Information Services).</dd>
    <dt>Samoilenko L.A. (1968):</dt>
    <dd><b>Investigation of the Hydraulic Resistance of Pipelines in the
        Zone of Transition from Laminar into Turbulent Motion</b>.
        Thesis (Cand. of Technical Science), Leningrad.</dd>
    <dt>Swamee P.K. and Jain A.K. (1976):</dt>
    <dd><b>Explicit equations for pipe-flow problems</b>.
         Proc. ASCE, J.Hydraul. Div., 102 (HY5), pp. 657-664.</dd>
    <dt>Voronin F.S. (1959):</dt>
    <dd><b>Effect of contraction on the friction coefficient in a
           turbulent gas flow</b>.
           Inzh. Fiz. Zh., vol. 2, no. 11, pp. 81-85.</dd>
</dl>
 
</html>
"));
  end WallFriction;

  class ValveCharacteristics "Valve characteristics"

    annotation (Documentation(info="<html>
<p>
The control valves in
<a href=\"Modelica://Modelica_Fluid.Valves\">Modelica_Fluid.Valves</a>
have the parameters <b>Kv</b> and <b>Cv</b>. They are defined
as unit-less variables, but in the description text a unit
is given. The reason for this definition is the following:
</p>
 
<p>
The basic equation for valves is:
</p>
 
<pre>
  q = Av*sqrt(dp/rho)
</pre>
 
<p>
In SI units, [q] is m3/s, [dp] is Pascal, [rho] is [kg/m3], and Av is an area, thus [Av] = m2. Basically, the equation stems from Bernoulli's law. Av is roughly 1.4 times the area of the valve throat. Now, usually valves aren't so big that their throat area is of the order of magnitude of square meters - depending on the applications it is from a few square millimeters to a few square centimeters. Therefore, in the common engineering practice, the following equations are used:
</p>
 
<p>
Europe:
</p>
 
<pre>
  q = Kv sqrt(dp/(rho/rho0)) , with [q] = m3/h, [dp] = bar
</pre>
 
<p>
US:
</p>
 
<pre>
  q = Cv sqrt(dp/(rho/rho0)) , with [q] = USG/min, [dp] = psi
</pre>
 
<p>
In both cases rho0 is the density of cold water at 4 °C, 999 kg/m3. Note that these equations use relative, not absolute densities.
</p>
 
<p>
It turns out that Kv = 1e6/27.7*Av and Cv = 1e6/24*Av, so both US and EU engineers get more or less the same numbers (just by sheer luck), with a range between a few units and a few hundred units for typical industrial applications, and everybody is happy.
</p>
 
<p>
Now, we've got two problems here. First, depending on the unit, we change the equation: with SI units, we use the density, with non-SI units, we use the relative density. So the quantities (not only the units!) of Av and Cv/Kv are different.
</p>
 
<p>
Second, the units of Kv and Cv are usually labelled \"m3/h\" and \"USG/min\", but as a matter of fact they are different, as can be seen from the equations above: they are actually
m3/(h*sqrt(bar)) and USG/(min*sqrt(psi)). If I have a valve with Kv = 10 m3/h, it means I get 10 m3/h \"for a pressure drop of 1 bar\". Unfortunately, this is not correct from the point of view of strict dimensional analysis, but nobody uses sqrt(Pa) or sqrt(bar).
</p>
 
<p>
You might think this is crazy (it is, expecially when you try to explain it), but as a matter of fact the valve coefficient is <b>never</b> given in square meters in any catalog or datasheet; Cv is still the most used (even in Europe), followed by Kv. So, it will be very inconvenient for users to type in Av in square meters.
</p>
 
<p>
The pragmatic approach used in Modelica_Fluid.ControlValves is to accept the fact that m3/h and USG/min are not the real units of Cv and Kv, so we can't use the general unit conversion mechanism, put them just as mnemonic labels in the comment, use non-dimensional coefficients in the interface, and then define properly dimensioned unit conversion within the model
</p>
 
</html>
"));
  end ValveCharacteristics;

  end ComponentDefinition;

  package BuildingSystemModels "Building system models"
    class SystemComponent "System component"

      annotation (Documentation(info="<html>
 
<p>
The Modelica_Fluid library is designed so that each model of a system must
include an instance <tt>system</tt> of the <tt>System</tt> component at the top level, in the same way as the <tt>World</tt> model of the MultiBody Library. The System component contains the parameters that
describe the environment surrounding the components (ambient pressure and
temperature, gravity acceleration), and also provides default settings
for many parameters which are used consistently by the models in the library.
These parameters are then propagated to the individual components
using the inner/outer variable mechanism. In case the system model is structured
hieararchically, it is possible to either put a single System
component at the top level, or possibly to put many of them at different levels,
which will only influence the system components from that level down. 
</p>
<p>All the parameters defined in the System model are used as default values for the parameters of the individual components of the system model. Note that it is always possible to ovverride these defaults locally by changing the value of the parameters in the specific component instance.
</p>
<ul>
<li>
The <i>General</i> tab of the System model allows to set the default enviroment variables (pressure, temperature and gravity) 
used by all the components.
</li>
<li>
The <i>Assumptions</i> tab allows to change the default modelling assumptions
used by all the components (see the section <i>Customizing a system model later</i>)</li>
<li>
The <i>Initialization</i> tab allows to define default start values for mass flow rates, pressures and temperatures in the model; this can be useful to help nonlinear solver converge to the solution of any nonlinear system of equations that involves such variables, by providing meaningful guess values. </li>
<li>
The <i>Advanced</i> tab contains default values for parameters used in
the advanced settings of some components.</i>
</ul>
<p>
Remember to <b>always add a System component</b> at the top level of
your system model, otherwise you will get errors when compiling the model. The tool will automatically name it <tt>system</tt>, so that it
is recognised by all other components.
</p>
</html>"));
    end SystemComponent;

    class MediumDefinition "Definition of the medium models"

      annotation (Documentation(info="<html>
 
<p>
All the models in Modelica_Fluid compute fluid properties by using medium
models defined by Modelica.Media packages. Custom fluid models can also be
used, provided they extend the interfaces defined in
Modelica.Media.Interfaces.
</p>
<p>
All the components in Modelica_Fluid use a <i>replaceable</i> medium package, called <tt>Medium</tt>: the model is written for a generic fluid, and a specific fluid model can then be specified when building a system model by redeclaring the package. This can be done in different ways:
<ul>
<li>
If several components use the same medium, it is possible to select
all of them within a GUI, and set them simultaneously (as they are
all named Medium).
</li>
<li>It is also possible to declare one or more (possibly replaceable) medium packages in the model, and then use them to set up the individual
components</li>.
</ul>
</html>"));
    end MediumDefinition;

    class CustomizingModel "Customizing a system model"

      annotation (Documentation(info="<html>
 
<p>
Once a system model has been built, it is possible to obtain different approximations by
appropriately setting the defaults in the System component (and/or the settings of specific
components. 
</p>
<p>
The Assumptions | allowFlowReversal parameter determines whether reversing flow conditions
(i.e. flow direction opposite to design direction) are modelled or not. By default,
reversing flow conditions are considered by the models, but this causes a significant increase
of complexity in the equations, due to the conditional equations depending on the flow direction.
If you know in advance that the flow in a certain component (or in the whole system) will always
be in the design direction, then setting this parameter to false will produce a much faster and
possibly more robust simulation code.
</p>
<p>
The flags in the Assumptions | Dynamics tab allow different degrees of approximation on
the mass, energy, and momentum equations of the components.
<ul>
<li>DynamicFreeInitial: dynamic equations are considered (nonzero storage), no 
initial equations are provided, and the start values are used as guess values.</li>
<li>FixedInitial: dynamic equations are considered (nonzero storage) and initial
equations are included, fixing the states to the start values provided by the
component parameters.</li>
<li>SteadyStateInitial: dynamic equations are considered (nonzero storage), initial
equations are included, declaring that the state derivatives are zero (steady-state
initialization) and the start values are used as guess values for the nonlinear solver. </li>
<li>SteadyState: algebraic (or static) balance equations are considered (no storage)
and the start values are used as guess values for the nonlinear solver.</li>
</ul>
It is then possible to neglect the storage of mass, momentum, and energy in the whole system
(or just in parts of it) just by a few mouse clicks in a GUI, and also to change the type of
initialization when considering dynamic models. Please note that some combinations of the
options might be contradictory, and will therefore trigger compilation errors.
 
</p>
</html>"));
    end CustomizingModel;
    annotation (Documentation(info="<html>
 
<p>
This section is a quick primer explaining how to build a system model using Modelica_Fluid.
It covers some key issues, such as the System component, the definition of medium models in the
system, and the typical customizations available in the Modelica_Fluid models.
</p> 
</html>"));
  end BuildingSystemModels;

  class ReleaseNotes "Release notes"

    annotation (Documentation(info="<HTML>
 
<h4><font color=\"#008000\">Version 1.0, 2009-01-28</font></h4>
 
<p>
Modelica_Fluid was refactored and finalized for the release:
</p>
 
<ul>
<li> Refactoring of the code<br>
     This became necessary as the previous release Modelica_Fluid Streams Beta3
     still reflected the long development history, while the basic concepts had been crystalized.
     Please consult the subversion control (SVN) logs for individual changes.</li>
 
<li> Device oriented package names<br>
     The former sub-packages Junctions and PressureLosses have been combined into the new subpackage Fittings.
     The former Pumps and Volumes.SweptVolume have become the initial version of fluid Machines.
     The former Volumes package is now called Vessels.</li>
 
<li> Complete implementation of one-dimenstional fluid flow<br>
     The balance equations as documented in
     <a href=\"Modelica://Modelica_Fluid.UsersGuide.ComponentDefinition.BalanceEquations\">UsersGuide.ComponentDefinition.BalanceEquations</a>
     are now completely implemented. The implementations with generic boundary flow and source terms find in:
     <ul>
     <li><a href=\"Modelica://Modelica_Fluid.Interfaces.PartialDistributedVolume\">Interfaces.PartialDistributedVolume</a>,
         <a href=\"Modelica://Modelica_Fluid.Interfaces.PartialLumpedVolume\">Interfaces.PartialLumpedVolume</a>:
         Energy, Mass and Substance balances</li>
     <li><a href=\"Modelica://Modelica_Fluid.Interfaces.PartialDistributedFlow\">Interfaces.PartialDistributedFlow</a>,
         <a href=\"Modelica://Modelica_Fluid.Interfaces.PartialLumpedFlow\">Interfaces.PartialLumpedFlow</a>:
         Momentum balance</li>
     </ul>
     Specific models combine the balances and define the boundary flow and source terms as appropriate.
     For instance
     <ul>
     <li><a href=\"Modelica://Modelica_Fluid.Vessels.OpenTank\">Vessels.OpenTank</a> extends from
         <a href=\"Modelica://Modelica_Fluid.Interfaces.PartialLumpedVolume\">Interfaces.PartialLumpedVolume</a>,</li>
     <li><a href=\"Modelica://Modelica_Fluid.Fittings.SimpleGenericOrifice\">Fittings.SimpleGenericOrifice</a> extends from
         <a href=\"Modelica://Modelica_Fluid.Interfaces.PartialLumpedFlow\">Interfaces.PartialLumpedFlow</a>, besides
         <a href=\"Modelica://Modelica_Fluid.Interfaces.PartialTwoPortTransport\">Interfaces.PartialTwoPortTransport</a>,</li>
     <li><a href=\"Modelica://Modelica_Fluid.Pipes.DynamicPipe\">Pipes.DynamicPipe</a> is based on
         <a href=\"Modelica://Modelica_Fluid.Interfaces.PartialDistributedVolume\">Interfaces.PartialDistributedVolume</a> and
         <a href=\"Modelica://Modelica_Fluid.Interfaces.PartialDistributedFlow\">Interfaces.PartialDistributedFlow</a>,
         besides <a href=\"Modelica://Modelica_Fluid.Interfaces.PartialTwoPort\">Interfaces.PartialTwoPort</a>.</li>
     </ul>
     All non-trivial mass and energy balances of Vessels, Machines and Fittings have been replaced with PartialLumpedVolume.
     The mass and energy balances of Pipes are based on PartialDistributedVolume.<br>
     See <a href=\"Modelica://Modelica_Fluid.Examples.BranchingDynamicPipes\">Examples.BranchingDynamicPipes</a>
     for an example utilizing the complete balance equations.
 
<li> New approach for the connection of distributed flow models<br>
     The staggered grid approach offers different choices for the connection approach. So far the preferred modeling was to put full mass balances
     into the pipes and expose half momentum balances through the ports (ModelStructure a_v_b).
     This resulted in nonlinear equation systems for pressure/flow correlations in connection sets.
     A new default ModelStructure av_vb has been introduced putting full momentum balances into the models and
     exposing half mass balances through the ports (av_vb replaces the former avb). This way the nonlinear equation systems are avoided.
     High-index DAEs need to be treated instead in connection sets.
     Alternatively a Fitting like SuddenExpansion can be introduced to account for different cross flow areas of connected flow models.</li>
 
<li> New Vessels.BaseClasses.PartialLumpedVessel treating the ports, including hydraulic resistances, for ClosedVolume, SimpleTank and SweptVolume.</li>
 
<li> Clarification of modeling assumptions<br>
     The documentation has been extended to better explain the modeling assumptions made. In particular the section
     <a href=\"Modelica://Modelica_Fluid.UsersGuide.ComponentDefinition.FluidConnectors\">UsersGuide.ComponentDefinition.FluidConnectors</a>
     now makes clear that the ports represent the thermodynamic enthalpy, as opposed to stagnation enthalpy,
     and thermodynamic or static pressure, as opposed to total pressure. An new package Explanatory has been added to the
     examples to show the difference beteen static pressure and total pressure and possible implications. See
     <a href=\"Modelica://Modelica_Fluid.Examples.Explanatory.MomentumBalanceFittings\">Examples.Explanatory.MomentumBalanceFittings</a>.
 
<li> System (former Ambient)<br>
     The use of the global System object has been extended towards common default values for
     modeling assumptions, initialization, and advanced settings that are different for each application of the library
     but should nevertheless provide default values for reasons of convenience. 
     In particular steady-state initialization and complete steady-state simulation can now be specified system-wide.
     A new Types.Init.Dynamics has been introduced, combining steady-state and initial conditions.
     The former Types.Init has become obsolete.
     <br>See <a href=\"Modelica://Modelica_Fluid.Examples.HeatingSystem\">Examples.HeatingSystem</a></li>.
 
<li> Extension of pumps for better consideration of zero flow and heat transfer with environment<br>
     The simplified mass and energy balances have been replaced with a rigorous formulation.
     Moreover an optional heat transfer model can be configured for heat exchanged with the environment or the housing.<br>
     See <a href=\"Modelica://Modelica_Fluid.Machines.BaseClasses.PartialPump\">Machines.BaseClasses.PartialPump</a></li>
 
<li> Refinement of valves for flow reversal<br>
     All valves now use upstream discretization for reverting flow conditions.</li>
 
<li> Finalization of trace substrances<br>
     Modelica_Fluid now provides a sound implementation for trace substances,
     which can easily be added to existing Media models, in order to study their evolution in a fluid system.</li>
     <br>See <a href=\"Modelica://Modelica_Fluid.Examples.TraceSubstances.RoomCO2WithControls\">Examples.TraceSubstances.RoomCO2WithControls</a></li>.
 
<li> Vectorized ports for volumes<br>
     The ports of models that typically have large volumes, like Vessels and Sources,
     have been vectorized. Formerly the connection of multiple flow models to the same port
     of such volume models resulted in unintended mixing equations for stream variables
     in connection sets outside the volumes. The mixing takes place inside the volumes
     when using multiple ports. Moreover a
     <a href=\"Modelica://Modelica_Fluid.Fittings.MultiPort\">Fittings.MultiPort</a>
     has been introduced. It can be attached to components like pipes,
     which don't have vectorized ports on their own.</li>
 
<li> Inverse parameterization of flow models with nominal operational conditions<br>
     Flow models have been added or extended to support the parameterization with nominal values
     (Machines.ControlledPump, Orifices.SimpleGenericOrifice, Pipes.BaseClasses.FlowModels.NominalTurbulentFlow).
     They are intended for early phases of system modeling, if geometries and flow characteristics
     are of secondary interest. As these models use the same interfaces, base classes and naming conventions,
     they can easily be replaced with more detailed models
     as more information shall be taken into account later on.<br>
     See <a href=\"Modelica://Modelica_Fluid.Examples.InverseParameterization\">Examples.InverseParameterization</a></li>.
 
<li> Replaceable HeatTransfer models<br>
     The Vessels and the Machines now have replaceable HeatTransfer models,
     besides the Pipes. All HeatTransfer models are optional.
     The heat transfer models are parameterized with the Medium and the ThermodynamicState
     of involved flow segments.<br>
     See <a href=\"Modelica://Modelica_Fluid.Interfaces.PartialHeatTransfer\">Interfaces.PartialHeatTransfer</a>.
 
<li> All examples are working now (using Dymola 7.1).<br>
     The number of examples has been extended with the former critical test cases
     HeatingSystem and IncompressibleFluidNetwork. Moreover the HeatExchangers have been
     moved into Examples.</li>
 
</ul>
 
 
<h4><font color=\"#008000\">Version 1.0 Streams Beta 3, 2008-10-12</font></h4>
 
<p>
Modelica_Fluid was further improved:
</p>
 
<ul>
<li> Volumes, tanks, junctions<br>
     Added asserts to require that ports are connected at most once.
     If a user would perform more than one connection, ideal mixing
     takes place for the connected components and this is nearly never
     what the user would like to have </li>
 
<li> Ambient<br>
     Renamed Ambient to System, including adaptation of models.<br>
     Introduced default values system.flowDirection and
     as a comment system.initType. system.flowDirection is used in
     two port components as default.</li>
 
<li> GenericJunction<br>
     Corrected specification of flowDirection.<br>
     Added a HeatPort.</li>
 
<li> PartialDistributedFlow models<br>
     Adapted determination of velocities to usage of
     upstream properties at ports.<br>
     Corrected and unified initialization of p_start[*] values.<li>
 
<li> DistributedPipe models<br>
     Changed treatment of port densities and viscosities
     to the treatment of the lumped pipe model. This way events are
     avoided if the mass flow rate crosses or approaches zero.<br>
     Correct determination of Reynolds numbers.<br>
     Added test model DistributedPipeClosingValve.</li>
 
<li> ControlValves<br>
     Changed flowCharacteristic into valveCharacteristic<br>
     Removed parameter Kv and added dp_nom, m_flow_nom from linear
     and discrete valve interfaces. Added test cases.<br>
     Adapted Examples to new LinearValve and DiscreteValve,
     using nominal values instead of Kv. <br>
     Changed default flow coefficient selection to OpPoint<li>
 
<li> Fixed units for Kv and Cv in control valve models.</li>
 
<li> Updated tests for valves.</li>
 
<li> Bug in Modelica_Fluid.Test.TestComponents.Pumps.TestWaterPump2 corrected
     (complicated redeclaration issue).</li>
 
<li> Adapted AST_BatchPlant so that \"Check\" is sucessful.
     Simulation fails after 600 s.</li>
 
<li> Introduced
     density_pTX(Medium.p_default, Medium.T_default, Medium.X_default)
     as default value for nominal densities (previously it was a literal
     such as 1000).</li>
 
<li> Pumps<br>
     Updated energy balance equations for pumps (no division by zero anymore,
     fixed several bugs related to Np).<br>
     Added two more test cases for pumps.<br>
     Fixed pump initialization options.</li>
 
<li> PartialPump<br>
     Explanation for the energy balanced added as comment<br>
     \"h=0\" replaced by \"h=Medium.h_default\" since otherwise an assert is triggered
     if \"h=0\" is not in the medium range.<br>
     Fluid ports positioned in the middle line
     and using the same size as for all other components.</li>
 
<li> Pumps.Pump <br>
     Resized input connector, so that it has the same size as the
     standard input connectors.<br>
     Changed icon text to input connector to \"N_in [rpm]\".<br>
     Added unit 1/min to the external and internal input connector.</li>
 
<li> PartialValve<br>
     fillcolor=white added to icon<br>
     made line Thickness = Single,
     since icon does not look nice sometimes</li>
 
<li> All components<br>
     Changed %name color from black to blue
     (is a conversion bug, since Modelica 2 has blue as default
     color whereas Modelica 3 has black and Dymola is not
     taking care off this).</li>
 
<li> Sources<br>
     Made icon elements unvisible, if corresponding input is disabled.</li>
 
<li> Valves, Pipes, PressureLosses, HeatExchangers, two port senors<br>
     Added an arrow in the icon for the \"design flow direction\" from
     port_a to port_b.</li>
 
<li> Moved default initialization in \"System\" in to a comment, since no effect yet</li>
 
<li> Added the explanation from Francesco for Kv, Cv for valves in the
     users guide and added links in the corresponding valves to this description</li>
</ul>
 
<p>
\"Check\" for the library is successful. \"Check with Simulation\"
(i.e., simulating all test models in the library) is successful
with the exceptions:
</p>
 
<ul>
<li> Examples.AST_BatchPlant.BatchPlant_StandardWater<br>
     Need to be fixed in a later release (requires quite a lot of work).</li>
<li> Test.TestOverdeterminedSteadyStateInit.Test5<br>
     Test.TestOverdeterminedSteadyStateInit.Test6<br>
     These are test cases where too much initial conditions are given.
     The goal is to work on methods how this can be handled.
     So, this is a principal problem that these models do not simulate.</li>
</ul>
 
 
 
<h4><font color=\"#008000\">Version 1.0 Streams Beta 2, 2008-10-08</font></h4>
 
<p>
Modelica_Fluid was transformed to Modelica 3 and to Modelica Standard
library 3.0 (by automatic conversion). Further changes:
</p>
 
<ul>
<li> Emulated enumerations changed to real enumerations.</li>
<li> Improved ControlValves code</li>
<li> Introduced stream connectors with stream keyword (was previously an annotation)</li>
<li> Introduced inStream() instead of inflow() </li>
<li> Introduced m_flow*actualStream(h_outflow) instead of
     streamFlow() or semiLinear(m_flow, inStream(h_outflow), medium.h)</li>
<li> Removed Modelica_Fluid.Media and all references to it (since now available
     in Modelica.Media of MSL3.0).</li>
<li> Fixed PartialLumpedVolume for media with multiple substances</li>
<li> New function \"Utilities.RegFun3\" for regularization with static head</li>
<li> Fix density in static head models with the new RegFun3 functions
     (ticket 7)</li>
<li> Minor bug in MixingVolume corrected:<br>
     V_lumped and Wb_flow have been set as modifiers when extending from PartialLumpedVolume,
     although they are not declared as input. This is not allowed in Modelica 3.
     Fixed by replacing the modifiers by equations.</li>
<li> Modelica_Fluid.Sources.FixedBoundary<br>
     Introduced p_default, T_default, h_default as default values, since
     otherwise warnings will always be printed because parameter value is missing.</li>
<li> Modelica_Fluid.Sources.Boundary_pT<br>
     Modelica_Fluid.Sources.Boundary_ph<br>
     Modelica_Fluid.Sources.MassFlowSource_T<br>
     Changed default values of parameters reference_p, reference_T to
     p_default, T_default (some have been xx_default, some reference_xx,
     it seems best to always use the same approach)</li>
<li> Modelica_Fluid.Pipes.BaseClasses.PartialDistributedFlow<br>
     Added default value for parameter \"rho_nominal\" =
     Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default)
     in order to avoid unnecessary warning messages.
     Should be replaced by \"Medium.rho_default\", once available.</li>
<li> Modelica_Fluid.Pipes.DistributedPipe<br>
     Modelica_Fluid.Pipes.DistributedPipeSb<br>
     Modelica_Fluid.Pipes.DistributedPipeSa<br>
     Added default value for parameter \"mu_nominal\"
    (computed with default values of p,T,X from dynamicViscosity(..))</li>
<li> Modelica_Fluid.Pipes.BaseClasses.PartialDistributedFlowLumpedPressure<br>
     Replaced default value \"rho_nominal=0.01\" by
     Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default)</li>
<li> Modelica_Fluid.Volumes.OpenTank<br>
     Modelica_Fluid.Volumes.Tank<br>
     Corrected icons of ports (wrongly sized by automatic conversion from
     Modelica 2 to Modelica 3).</li>
<li> Examples.BranchingDistributedPipes<br>
     Modelica_Fluid.Test.TestComponents.Junctions.TestGenericJunction<br>
     Modelica_Fluid.Test.TestComponents.Pipes.TestDistributedPipe01<br>
     Parameters dp_nom, m_flow_nom are not defined in junction components.
     Values provided.</li>
<li> PressureLosses.BaseClasses.QuadraticTurbulent.BaseModel<br>
     No default or start values for \"parameter LossFactorData data\"
     Changed the model to \"partial model\" to avoid warning messages</li>
</ul>
 
 
<h4><font color=\"#008000\">Version 1.0 Streams Beta 1, 2008-05-02</font></h4>
 
<p>
Changed connectors to stream connectors and adapted the following sublibraries:
</p>
 
<ul>
<li> Volumes</li>
<li> PressureLosses </li>
<li> Sensors </li>
<li> Sources </li>
<li> ControlValves </li>
<li> HeatExchangers </li>
<li> Junctions </li>
<li> Pipes </li>
<li> Pumps </li>
<li> Test and Exampleas (most of the examples and tests are simulating)</li>
</ul>
 
<p>
Other changes:
</p>
 
<ul>
<li> Introduced HeatPorts with vectorized icon in Modelica_Fluid.Interfaces</li>
<li> Deleted Modelica_Fluid.WorkInProgress since it seems to be too much work
     to convert it to stream connectors</li>
<li> Added Modelica_Fluid.Media (contains ConstantLiquidWater
     medium because functions are missing in Modelica.Media),<lI>
<li> Added two additional test cases with LumpedPipes
    (to identify problems with hierarchically connected stream connectors).</li>
<li> Deleted TestPortVolumes since PortVolumes can no longer be implemented with
     stream connectors</li>
<li> Leakage flow introduced for valves</li>
<li> Drumboiler Example corrected</li>
<li> Regularization for sensors (T,h,...), in order that no discontinuity
     for bi-directional flow</li>
<li> Density computation in static head corrected</li>
<li> New functions Utilities.regUnitStep, regStep</li>
<li> New components (TestComponents.Sensors.TestOnePortSensors1/.TestOnePortSensors2l,
     TestRegStep)</li>
<li> PartialTwoPortTransport<br>
     <ul>
     <li> Introduced port_a.T, port_b.T (for plotting)</li>
     <li> Removed initialization menu</li>
     <li> Introduced dp_start, m_flow_start</li>
     <li> Removed previous start values of PartialTwoPortTransport in all models</li>
     </ul></li>
<li> PartialPump: Removed p_nom, since no longer needed (only dp_nom)</li>
<li> Made \"%name\" in the icons of all components unified (and better looking)</li>
<li> Changed default value of leackage flow of valves to zero.</li>
<li> Fixed Modelica_Fluid.Junctions.MassFlowRatio so that it compiles
     (inflow(..) currently only supported for scalars, not for vectors)</li>
<li> Added script libraryinfo.mos, in order that Modelica_Fluid appears in the
     Dymola library window automatically (provided library is in MODELICAPATH)</li>
<li> Replaced semiLinear(..) by streamFlow(..) (not yet at all places)</li>
<li> Introduced check-boxes in parameter menu of Sources (is more convenient to use)</li>
<li> TwoPortTransport<br>
     Computation of V_flow and optionally port_a_T, port_b_T.
     Error in temperature calculation corrected</li>
<li> Tank:<br>
     Default of bottom pipe diameter changed from 0 to 0.1, since
     otherwise a division by zero (if not connected and not changed).</li>
<li> Modelica_Fluid.ControlValves.ValveVaporizing:<br>
     Due to changes in PartialTwoPortTransport, port_a_T_inflow does no longer exist
     and the usage to it is removed.
     </li>
<li> Modelica_Fluid.Test.TestComponents.Sensors.TestTemperatureSensor:<br>
     Due to changes in PartialTwoPortTransport,
     p_start does no longer exist and the usage to it is removed.</li>
<li> VersionBuild introduced, as well as automatic update of
     VersionBuild/VersionDate</li>
</ul>
 
 
 
<h4><font color=\"#008000\">Version 1.0 Beta 4, 2008-04-26</font></h4>
 
<p>
Changes according to the Modelica Design Meetings since the
last beta version. This version is used to \"freeze\" the current
development, in order to change to a version with a new
connector design using stream variables.
</p>
 
 
<h4><font color=\"#008000\">Version 1.0 Beta 3, 2007-06-05</font></h4>
 
<p>
Changes according to the Modelica Design Meetings since the
Modelica'2006 conference, especially, improved initialization,
changed Source components (input connectors must be enabled),
improved tank component, moved test models from Examples to
new package Test, many more test models, etc.
This version is slightly non-backward compatible to version 1.0 Beta 2.
</p>
 
 
<h4><font color=\"#008000\">Version 1.0 Beta 2, 2006-08-28</font></h4>
 
<p>
Package considerably restructured and some new components added.
New examples (ControlledTankSystem, AST_BatchPlant).
</p>
 
 
<h4><font color=\"#008000\">Version 0.96, 2006-01-08</font></h4>
 
<ul>
<li> New package Modelica_Fluid.PressureLosses.</li>
<li> New package Modelica_Fluid.WorkInProgress.</li>
<li> New components in Modelica_Fluid.Components:<br>
     ShortPipe, OpenTank, ValveDiscrete, StaticHead.</li>
<li> New components in Modelica_Fluid.Examples.</li>
<li> Improved users guide.</li>
</ul>
 
<h4><font color=\"#008000\">Version 0.910, 2005-10-25</font></h4>
<ul>
<li> Changes as decided on 41th-45th Modelica Design Meetings
     (details, see minutes).
</ul>
<h4><font color=\"#008000\">Version 0.900, 2004-10-18</font></h4>
<ul>
<li> Changes as decided on 40th Modelica Design Meeting in Dresden
     (see also minutes)
</ul>
<h4><font color=\"#008000\">Version 0.794, 2004-05-31</font></h4>
<ul>
<li> Sensors.mo, Examples/DrumBoiler.mo: extend sensors with user choice
     for measurement unit.</li>
<li> Components.mo, Types.mo: moved components and types to
     package Examples.</li>
<li> Moved Examples from <b>file</b> Modelica_Fluid/package.mo to
     Modelica.Media/Examples <b>subdirectory</b> and created separate
     file per sub-package. This shall simplify the maintenance of
     examples by different authors</li>
<li> Moved Interfaces from file Modelica_Fluid/package.mo to
     Modelica_Fluid/Interfaces.mo</li>
</ul>
<h4><font color=\"#008000\">Version 0.793, 2004-05-18</font></h4>
<ul>
<li> Removed \"semiLinear\" function since available as
     Modelica 2.1 built-in operator in Dymola.</li>
<li> Minor bug in \"Components.ShortPipe\" corrected.</li>
<li> Bug in \"Components.Orifice\" corrected
     (dp was previously calculated in
      Interfaces.PartialTwoPortTransport,
      but this was removed and not updated in Orifice).</li>
</ul>
<h4><font color=\"#008000\">Version 0.792, 2003-11-07</font></h4>
<p>
This is the first consolidated version made up from
several changes for Modelica'2003.
Modelica_Fluid is still quite far away
from a library that could be included in the Modelica
standard library.
</p>
<h4><font color=\"#008000\">Previous Releases</font></h4>
<ul>
<li><i>Oct., 2003</i><br>
       by Martin Otter: Adapted to latest design of the Modelica.Media
       library.<br>
       by Ruediger Franke: Included sensor components and
       Modelica_Fluid.Examples.DrumBoiler example.</li>
<li><i>Sept., 2003</i><br>
       by Martin Otter: Changes according to the decisions of the
       Modelica design meeting in Dearborn, Sept. 2-4, 2003.
       Fluid library splitt in to two packages: Modelica.Media
       that contains the media models and Modelica_Fluid that
       contains fluid flow components. Modelica.Media is
       independent of Modelica_Fluid and my be used also from
       other packages that may have a different design as
       Modelica_Fluid.
<li><i>Aug., 2003</i><br>
       by Martin Otter: Improved documentation, PortVicinity (now called semiLinear)
       manually expanded, two different volume types,
       replaced number of massFractions from n to n-1 in order
       that usage of model for single substances is easier
       and in order that no special cases have to be treated
       in the equations (previously the massFraction equations had to
       be removed for single substance flow; now they are removed
       automatically, since the dimensions are zero, and not one
       as previously), included asserts to check the validity of
       the medium models, included the dynamic viscosity in the
       medium models, adapted the examples and medium models to the
       changes in Interfaces, improved menus according to the new
       features in Dymola 5.1. Added \"Components.ShortPipe\" that
       contains a detailed model of the frictional losses in pipes
       over a very wide range.</li>
<li><i>Feb., 2003</i><br>
       by Martin Otter: Included several elementary components and
       a model for moisted air. Some elementary components, such as
       FixedAmbient, are adapted versions from the SimpleFlow fluid library
       of Anton Haumer.</li>
<li><i>Dec., 2002</i><br>
       by Hubertus Tummescheit:
       Improved version of the high precision water model
       (Copy from ThermoFluid library, code reorganization,
       enhanced documentation, additional functions).</li>
<li><i>Nov. 30, 2002</i><br>
       by Martin Otter: Improved the design from the design meeting:
       Adapted to Modelica standard library 1.5,
       added \"choicesAllMatching=true\" annotation,
       added short documentation to \"Interfaces\",
       added packages \"Examples\" and \"Media\" (previously called \"Properties\")
       from previous versions and adapted them to the updated
       \"Interfaces\" package.</li>
<li><i>Nov. 20-21, 2002</i><br>
       by Hilding Elmqvist, Mike Tiller, Allan Watson, John Batteh, Chuck Newman,
       Jonas Eborn: Improved at the 32nd Modelica Design Meeting.</li>
<li><i>Nov. 11, 2002</i><br>
       by Hilding Elmqvist, Martin Otter: improved version.</li>
<li><i>Nov. 6, 2002</i><br>
       by Hilding Elmqvist: first version of the basic design.</li>
</ul>
</HTML>
"));
  equation

  end ReleaseNotes;

  class ModelicaLicense2 "Modelica License 2"

      annotation (Documentation(info="<html>
 
<P STYLE=\"text-indent: 0pt; font-weight: medium\">
This page contains the &ldquo;Modelica License 2&rdquo; which was
released by the Modelica Association on Nov. 19, 2008. It is used for
all material from the Modelica Association provided to the public
after this date. It is recommended that other providers of free
Modelica packages license their library also under &ldquo;Modelica
License 2&rdquo;. Additionally, this document contains a description
how to apply the license and has a &ldquo;Frequently Asked Questions&rdquo;
section.</P>
 
<P STYLE=\"text-indent: 0pt; line-height: 150%\">
<A HREF=\"#1. The Modelica License 2|outline\">             The Modelica License 2</A>
   (in other formats:
   <A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2.html\">standalone html</A>,
   <A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2.pdf\">pdf</A>,
   <A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2.odt\">odt</A>,
   <A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2.doc\">doc</A>)<br>
   <A HREF=\"#2. How to Apply the Modelica License 2|outline\">How to Apply the Modelica License 2</A><br>
   <A HREF=\"#3. Frequently Asked Questions|outline\">         Frequently Asked Questions</A><br>&nbsp;</P>
 
<hr>
<H4><A NAME=\"_Ref208223390\"></A><A NAME=\"1. The Modelica License 2|outline\"></A>
The Modelica License 2</H4>
 
<P>
<B>Preamble. </B>The goal of this license is that Modelica related
model libraries, software, images, documents, data files etc. can be
used freely in the original or a modified form, in open source and in
commercial environments (as long as the license conditions below are
fulfilled, in particular sections 2c) and 2d). The Original Work is
provided free of charge and the use is completely at your own risk.
Developers of free Modelica packages are encouraged to utilize this
license for their work.</P>
<P>
The Modelica License applies to any Original Work that contains the
following licensing notice adjacent to the copyright notice(s) for
this Original Work:</P>
<P ALIGN=CENTER STYLE=\"text-indent: 0pt\"><B>Licensed
by &lt;name of Licensor&gt; under the Modelica License 2</B></P>
<P><B>1.
Definitions.</B></P>
<OL>
        <LI>
        &ldquo;License&rdquo; is this Modelica License.</LI>
        <LI>
        &ldquo;Original Work&rdquo; is any work of authorship, including
        software, images, documents, data files, that contains the above
        licensing notice or that is packed together with a licensing notice
        referencing it.</LI>
        <LI>
        &ldquo;Licensor&rdquo; is the provider of the Original Work who has
        placed this licensing notice adjacent to the copyright notice(s) for
        the Original Work. The Original Work is either directly provided by
        the owner of the Original Work, or by a licensee of the owner.</LI>
        <LI>
        &ldquo;Derivative Work&rdquo; is any modification of the Original
        Work which represents, as a whole, an original work of authorship.
        For the matter of clarity and as examples:
        <OL>
                <LI>
                Derivative Work shall not include work that remains separable from
                the Original Work, as well as merely extracting a part of the
                Original Work without modifying it.</LI>
                <LI>
                Derivative Work shall not include (a) fixing of errors and/or (b)
                adding vendor specific Modelica annotations and/or (c) using a
                subset of the classes of a Modelica package, and/or (d) using a
                different representation, e.g., a binary representation.</LI>
                <LI>
                Derivative Work shall include classes that are copied from the
                Original Work where declarations, equations or the documentation
                are modified.</LI>
                <LI>
                Derivative Work shall include executables to simulate the models
                that are generated by a Modelica translator based on the Original
                Work (of a Modelica package).</LI>
        </OL>
        <LI>
        &ldquo;Modified Work&rdquo; is any modification of the Original Work
        with the following exceptions: (a) fixing of errors and/or (b)
        adding vendor specific Modelica annotations and/or (c) using a
        subset of the classes of a Modelica package, and/or (d) using a
        different representation, e.g., a binary representation.</LI>
        <LI>
        &quot;Source Code&quot; means the preferred form of the Original
        Work for making modifications to it and all available documentation
        describing how to modify the Original Work.</LI>
        <LI>
        &ldquo;You&rdquo; means an individual or a legal entity exercising
        rights under, and complying with all of the terms of, this License. </LI>
        <LI>
        &ldquo;Modelica package&rdquo; means any Modelica library that is
        defined with the &ldquo;<TT><B>package</B> &lt;Name&gt; ... <B>end</B> &lt;Name&gt;;</TT>&ldquo;
        Modelica language element.</LI>
</OL>
 
<P>
<B>2. </B><B>Grant of Copyright License. </B>Licensor grants You a
worldwide, royalty-free, non-exclusive, sublicensable license, for
the duration of the copyright, to do the following:</P>
<OL>
        <LI>
        To reproduce the Original Work in copies, either alone or as part of
        a collection.</LI>
        <LI><P>
        To create Derivative Works according to Section 1d) of this License.</LI>
        <LI>
        To distribute or communicate to the public copies of the <U>Original
        Work</U> or a <U>Derivative Work</U> under <U>this License</U>. No
        fee, neither as a copyright-license fee, nor as a selling fee for
        the copy as such may be charged under this License. Furthermore, a
        verbatim copy of this License must be included in any copy of the
        Original Work or a Derivative Work under this License.<BR>      For
        the matter of clarity, it is permitted A) to distribute or
        communicate such copies as part of a (possible commercial)
        collection where other parts are provided under different licenses
        and a license fee is charged for the other parts only and B) to
        charge for mere printing and shipping costs.</LI>
        <LI>
        To distribute or communicate to the public copies of a <U>Derivative
        Work</U>, alternatively to Section 2c), under <U>any other license</U>
        of your choice, especially also under a license for
        commercial/proprietary software, as long as You comply with Sections
        3, 4 and 8 below. <BR>      For the matter of clarity, no
        restrictions regarding fees, either as to a copyright-license fee or
        as to a selling fee for the copy as such apply.</LI>
        <LI>
        To perform the Original Work publicly.</LI>
        <LI>
        To display the Original Work publicly.</LI>
</OL>
 
<P>
<B>3. </B><B>Acceptance. </B>Any use of the Original Work or a
Derivative Work, or any action according to either Section 2a) to 2f)
above constitutes Your acceptance of this License.</P>
 
<P>
<B>4. </B><B>Designation of Derivative Works and of Modified Works.
</B>The identifying designation of Derivative Work and of Modified
Work must be different to the corresponding identifying designation
of the Original Work. This means especially that the (root-level)
name of a Modelica package under this license must be changed if the
package is modified (besides fixing of errors, adding vendor specific
Modelica annotations, using a subset of the classes of a Modelica
package, or using another representation, e.g. a binary
representation).</P>
 
<P>
<B>5. </B><B>Grant of Patent License.</B>
Licensor grants You a worldwide, royalty-free, non-exclusive, sublicensable license,
under patent claims owned by the Licensor or licensed to the Licensor by
the owners of the Original Work that are embodied in the Original Work
as furnished by the Licensor, for the duration of the patents,
to make, use, sell, offer for sale, have made, and import the Original Work
and Derivative Works under the conditions as given in Section 2.
For the matter of clarity, the license regarding Derivative Works covers
patent claims to the extent as they are embodied in the Original Work only.</P>
 
<P>
<B>6. Provision of </B><B>Source Code. </B>Licensor agrees to provide
You with a copy of the Source Code of the Original Work but reserves
the right to decide freely on the manner of how the Original Work is
provided.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For the matter of clarity, Licensor might provide only a binary
representation of the Original Work. In that case, You may (a) either
reproduce the Source Code from the binary representation if this is
possible (e.g., by performing a copy of an encrypted Modelica
package, if encryption allows the copy operation) or (b) request the
Source Code from the Licensor who will provide it to You.</P>
 
<P>
<B>7. </B><B>Exclusions from License Grant. </B>Neither the names of
Licensor, nor the names of any contributors to the Original Work, nor
any of their trademarks or service marks, may be used to endorse or
promote products derived from this Original Work without express
prior permission of the Licensor. Except as otherwise expressly
stated in this License and in particular in Sections 2 and 5, nothing
in this License grants any license to Licensor&rsquo;s trademarks,
copyrights, patents, trade secrets or any other intellectual
property, and no patent license is granted to make, use, sell, offer
for sale, have made, or import embodiments of any patent claims.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No license is granted to the trademarks of
Licensor even if such trademarks are included in the Original Work,
except as expressly stated in this License. Nothing in this License
shall be interpreted to prohibit Licensor from licensing under terms
different from this License any Original Work that Licensor otherwise
would have a right to license.</P>
 
<P>
<B>8. </B><B>Attribution Rights. </B>You must retain in the Source
Code of the Original Work and of any Derivative Works that You
create, all author, copyright, patent, or trademark notices, as well
as any descriptive text identified therein as an &quot;Attribution
Notice&quot;. The same applies to the licensing notice of this
License in the Original Work. For the matter of clarity, &ldquo;author
notice&rdquo; means the notice that identifies the original
author(s). <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You must cause the Source Code for any Derivative
Works that You create to carry a prominent Attribution Notice
reasonably calculated to inform recipients that You have modified the
Original Work. <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In case the Original Work or Derivative Work is not provided in
Source Code, the Attribution Notices shall be appropriately
displayed, e.g., in the documentation of the Derivative Work.</P>
 
<P><B>9. </B><B>Disclaimer
of Warranty. <BR></B><U><B>The Original Work is provided under this
License on an &quot;as is&quot; basis and without warranty, either
express or implied, including, without limitation, the warranties of
non-infringement, merchantability or fitness for a particular
purpose. The entire risk as to the quality of the Original Work is
with You.</B></U><B> </B>This disclaimer of warranty constitutes an
essential part of this License. No license to the Original Work is
granted by this License except under this disclaimer.</P>
 
<P>
<B>10. </B><B>Limitation of Liability. </B>Under no circumstances and
under no legal theory, whether in tort (including negligence),
contract, or otherwise, shall the Licensor, the owner or a licensee
of the Original Work be liable to anyone for any direct, indirect,
general, special, incidental, or consequential damages of any
character arising as a result of this License or the use of the
Original Work including, without limitation, damages for loss of
goodwill, work stoppage, computer failure or malfunction, or any and
all other commercial damages or losses. This limitation of liability
shall not apply to the extent applicable law prohibits such
limitation.</P>
 
<P>
<B>11. </B><B>Termination. </B>This License conditions your rights to
undertake the activities listed in Section 2 and 5, including your
right to create Derivative Works based upon the Original Work, and
doing so without observing these terms and conditions is prohibited
by copyright law and international treaty. Nothing in this License is
intended to affect copyright exceptions and limitations. This License
shall terminate immediately and You may no longer exercise any of the
rights granted to You by this License upon your failure to observe
the conditions of this license.</P>
 
<P>
<B>12. </B><B>Termination for Patent Action. </B>This License shall
terminate automatically and You may no longer exercise any of the
rights granted to You by this License as of the date You commence an
action, including a cross-claim or counterclaim, against Licensor,
any owners of the Original Work or any licensee alleging that the
Original Work infringes a patent. This termination provision shall
not apply for an action alleging patent infringement through
combinations of the Original Work under combination with other
software or hardware.</P>
 
<P>
<B>13. </B><B>Jurisdiction. </B>Any action or suit relating to this
License may be brought only in the courts of a jurisdiction wherein
the Licensor resides and under the laws of that jurisdiction
excluding its conflict-of-law provisions. The application of the
United Nations Convention on Contracts for the International Sale of
Goods is expressly excluded. Any use of the Original Work outside the
scope of this License or after its termination shall be subject to
the requirements and penalties of copyright or patent law in the
appropriate jurisdiction. This section shall survive the termination
of this License.</P>
 
<P>
<B>14. </B><B>Attorneys&rsquo; Fees. </B>In any action to enforce the
terms of this License or seeking damages relating thereto, the
prevailing party shall be entitled to recover its costs and expenses,
including, without limitation, reasonable attorneys' fees and costs
incurred in connection with such action, including any appeal of such
action. This section shall survive the termination of this License.</P>
 
<P>
<B>15. </B><B>Miscellaneous. </B>
</P>
<OL>
        <LI>If any
        provision of this License is held to be unenforceable, such
        provision shall be reformed only to the extent necessary to make it
        enforceable.</LI>
        <LI>No verbal
        ancillary agreements have been made. Changes and additions to this
        License must appear in writing to be valid. This also applies to
        changing the clause pertaining to written form.</LI>
        <LI>You may use the
        Original Work in all ways not otherwise restricted or conditioned by
        this License or by law, and Licensor promises not to interfere with
        or be responsible for such uses by You.</LI>
</OL>
 
<hr>
 
<H4><A NAME=\"2. How to Apply the Modelica License 2|outline\"></A>
How to Apply the Modelica License 2</H4>
 
<P STYLE=\"text-indent: 0pt; font-weight: medium\">
At the top level of your Modelica package and at every important
subpackage, add the following notices in the info layer of the
package:</P>
 
<table border=\"0\"><tr><td>&nbsp;&nbsp;&nbsp;</td><td>
Licensed by &lt;Licensor&gt; under the Modelica License 2<br>
Copyright &copy; &lt;year1&gt;-&lt;year2&gt;, &lt;name of copyright
holder(s)&gt;.
</td></tr></table>
 
<table border=\"0\"><tr><td>&nbsp;&nbsp;&nbsp;</td><td>
<I>This Modelica package is <U>free</U> software and
the use is completely at <U>your own risk</U>;
it can be redistributed and/or modified under the terms of the
Modelica license 2, see the license conditions (including the
disclaimer of warranty)
<A HREF=\"Modelica://Modelica_Fluid.UsersGuide.ModelicaLicense2\">here</A></U>
or at
<A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2\">
http://www.modelica.org/licenses/ModelicaLicense2</A>.
</td></tr></table>
 
<P STYLE=\"text-indent: 0pt; font-weight: medium\">Include
a copy of the Modelica License 2 under
<B>&lt;library&gt;.UsersGuide.ModelicaLicense2</B>
(use <A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2.mo\">
http://www.modelica.org/licenses/ModelicaLicense2.mo</A>). Furthermore, add
the list of authors and contributors under
<B>&lt;library&gt;.UsersGuide.Contributors</B> or
<B>&lt;library&gt;.UsersGuide.Contact</B>.</P>
 
<P STYLE=\"text-indent: 0pt; font-weight: medium\">For
example, sublibrary Modelica.Blocks of the Modelica Standard Library
may have the following notices:</P>
 
<table border=\"0\"><tr><td>&nbsp;&nbsp;&nbsp;</td><td>
Licensed by Modelica Association under the Modelica License 2<br>
Copyright &copy; 1998-2009, Modelica Association.
</td></tr></table>
 
<table border=\"0\"><tr><td>&nbsp;&nbsp;&nbsp;</td><td>
<I>This Modelica package is <U>free</U> software and
the use is completely at <U>your own risk</U>;
it can be redistributed and/or modified under the terms of the
Modelica license 2, see the license conditions (including the
disclaimer of warranty)
<A HREF=\"Modelica://Modelica_Fluid.UsersGuide.ModelicaLicense2\">here</A></U>
or at
<A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2\">
http://www.modelica.org/licenses/ModelicaLicense2</A>.</I>
</td></tr></table>
 
 
<P STYLE=\"text-indent: 0pt; font-weight: medium\">For
C-source code and documents, add similar notices in the corresponding
file.</P>
 
<P STYLE=\"text-indent: 0pt; font-weight: medium\">For
images, add a &ldquo;readme.txt&rdquo; file to the directories where
the images are stored and include a similar notice in this file.</P>
 
 
<P STYLE=\"text-indent: 0pt; font-weight: medium\">In
these cases, save a copy of the Modelica License 2 in one directory
of the distribution, e.g.,
<A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2.html\">
http://www.modelica.org/licenses/ModelicaLicense2.html</A>
in directory <B>&lt;library&gt;/help/documentation/ModelicaLicense2.html</B>.</P>
 
 
<hr>
<H4><A NAME=\"_Ref202857474\"></A><A NAME=\"3. Frequently Asked Questions|outline\"></A>
Frequently Asked Questions</H4>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">
This section contains questions/answer to users and/or distributors of
Modelica packages and/or documents under Modelica License 2. Note,
the answers to the questions below are not a legal interpretation of
the Modelica License 2. In case of a conflict, the language of the
license shall prevail.</P>
 
<P STYLE=\"text-indent: 0pt; font-weight: medium\"><BR>
</P>
 
<P STYLE=\"text-indent: 0pt; font-weight: medium; color: green; font-size:140%\">
<b>Using or Distributing a Modelica <U>Package</U> under the Modelica License 2</b></P>
 
<P STYLE=\"text-indent: 0pt\"><B>What are the main
differences to the previous version of the Modelica License?</B></P>
<OL>
        <LI>
        Modelica License 1 is unclear whether the licensed Modelica package
        can be distributed under a different license. Version 2 explicitly
        allows that &ldquo;Derivative Work&rdquo; can be distributed under
        any license of Your choice, see examples in Section 1d) as to what
        qualifies as Derivative Work (so, version 2 is clearer).</LI>
        <LI>
        If You modify a Modelica package under Modelica License 2 (besides
        fixing of errors, adding vendor specific Modelica annotations, using
        a subset of the classes of a Modelica package, or using another
        representation, e.g., a binary representation), you must rename the
        root-level name of the package for your distribution. In version 1
        you could keep the name (so, version 2 is more restrictive). The
        reason of this restriction is to reduce the risk that Modelica
        packages are available that have identical names, but different
        functionality.</LI>
        <LI>
        Modelica License 1 states that &ldquo;It is not allowed to charge a
        fee for the original version or a modified version of the software,
        besides a reasonable fee for distribution and support<SPAN LANG=\"en-GB\">&ldquo;.
        Version 2 has a </SPAN>similar intention for all Original Work under
        <U>Modelica License 2</U> (to remain free of charge and open source)
        but states this more clearly as &ldquo;No fee, neither as a
        copyright-license fee, nor as a selling fee for the copy as such may
        be charged&rdquo;. Contrary to version 1, Modelica License 2 has no
        restrictions on fees for Derivative Work that is provided under a
        different license (so, version 2 is clearer and has fewer
        restrictions).</LI>
        <LI>
        Modelica License 2 introduces several useful provisions for the
        licensee (articles 5, 6, 12), and for the licensor (articles 7, 12,
        13, 14) that have no counter part in version 1.</LI>
        <LI>
        Modelica License 2 can be applied to all type of work, including
        documents, images and data files, contrary to version 1 that was
        dedicated for software only (so, version 2 is more general).</LI>
</OL>
 
<P><B>Can I distribute a
Modelica package (under Modelica License 2) as part of my commercial
Modelica modeling and simulation environment?</B></P>
<P>Yes,
according to Section 2c). However, you are not allowed to charge a
fee for this part of your environment. Of course, you can charge for
your part of the environment.
</P>
 
<P><B>Can I distribute a
Modelica package (under Modelica License 2) under a different
license?</B></P>
<P>No.
The license of an unmodified Modelica package cannot be changed
according to Sections 2c) and 2d). This means that you cannot <U>sell</U>
copies of it, any distribution has to be free of charge.</P>
 
<P><B>Can I distribute a
Modelica package (under Modelica License 2) under a different license
when I first encrypt the package?</B></P>
<P>No.
Merely encrypting a package does not qualify for Derivative Work and
therefore the encrypted package has to stay under Modelica License 2.</P>
 
 
<P><B>Can I distribute a
Modelica package (under Modelica License 2) under a different license
when I first add classes to the package?</B></P>
<P>No.
The package itself remains unmodified, i.e., it is Original Work, and
therefore the license for this part must remain under Modelica
License 2. The newly added classes can be, however, under a different
license.
</P>
 
<P><B>Can
I copy a class out of a Modelica package (under Modelica License 2)
and include it </B><U><B>unmodified</B></U><B> in a Modelica package
under a </B><U><B>commercial/proprietary license</B></U><B>?</B></P>
<P>No,
according to article 2c). However, you can include model, block,
function, package, record and connector classes in your Modelica
package under <U>Modelica License 2</U>. This means that your
Modelica package could be under a commercial/proprietary license, but
one or more classes of it are under Modelica License 2.<BR>Note, a
&ldquo;type&rdquo; class (e.g., type Angle = Real(unit=&rdquo;rad&rdquo;))
can be copied and included unmodified under a commercial/proprietary
license (for details, see the next question).</P>
 
<P><B>Can
I copy a type class or </B><U><B>part</B></U><B> of a model, block,
function, record, connector class, out of a Modelica package (under
Modelica License 2) and include it modified or unmodified in a
Modelica package under a </B><U><B>commercial/proprietary</B></U><B>
license</B></P>
<P>Yes,
according to article 2d), since this will in the end usually qualify
as Derivative Work. The reasoning is the following: A type class or
part of another class (e.g., an equation, a declaration, part of a
class description) cannot be utilized &ldquo;by its own&rdquo;. In
order to make this &ldquo;usable&rdquo;, you have to add additional
code in order that the class can be utilized. This is therefore
usually Derivative Work and Derivative Work can be provided under a
different license. Note, this only holds, if the additional code
introduced is sufficient to qualify for Derivative Work. Merely, just
copying a class and changing, say, one character in the documentation
of this class would be no Derivative Work and therefore the copied
code would have to stay under Modelica License 2.</P>
 
<P><B>Can
I copy a class out of a Modelica package (under Modelica License 2)
and include it in </B><U><B>modified </B></U><B>form in a
</B><U><B>commercial/proprietary</B></U><B> Modelica package?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">Yes.
If the modification can be seen as a &ldquo;Derivative Work&rdquo;,
you can place it under your commercial/proprietary license. If the
modification does not qualify as &ldquo;Derivative Work&rdquo; (e.g.,
bug fixes, vendor specific annotations), it must remain under
Modelica License 2. This means that your Modelica package could be
under a commercial/proprietary license, but one or more parts of it
are under Modelica License 2.</P>
 
<P><B>Can I distribute a
&ldquo;save total model&rdquo; under my commercial/proprietary
license, even if classes under Modelica License 2 are included?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">Your
classes of the &ldquo;save total model&rdquo; can be distributed
under your commercial/proprietary license, but the classes under
Modelica License 2 must remain under Modelica License 2. This means
you can distribute a &ldquo;save total model&rdquo;, but some parts
might be under Modelica License 2.</P>
 
<P><B>Can I distribute a
Modelica package (under Modelica License 2) in encrypted form?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">Yes.
Note, if the encryption does not allow &ldquo;copying&rdquo; of
classes (in to unencrypted Modelica source code), you have to send
the Modelica source code of this package to your customer, if he/she
wishes it, according to article&nbsp;6.</P>
 
<P><B>Can I distribute an
executable under my commercial/proprietary license, if the model from
which the executable is generated uses models from a Modelica package
under Modelica License 2?</B></P>
<P>Yes,
according to article 2d), since this is seen as Derivative Work. The
reasoning is the following: An executable allows the simulation of a
concrete model, whereas models from a Modelica package (without
pre-processing, translation, tool run-time library) are not able to
be simulated without tool support. By the processing of the tool and
by its run-time libraries, significant new functionality is added (a
model can be simulated whereas previously it could not be simulated)
and functionality available in the package is removed (e.g., to build
up a new model by dragging components of the package is no longer
possible with the executable).</P>
 
<P><B>Is my modification to
a Modelica package (under Modelica License 2) a Derivative Work?</B></P>
<P>It
is not possible to give a general answer to it. To be regarded as &quot;an
original work of authorship&quot;, a derivative work must be
different enough from the original or must contain a substantial
amount of new material. Making minor changes or additions of little
substance to a preexisting work will not qualify the work as a new
version for such purposes.
</P>
 
 
<P STYLE=\"text-indent: 0pt; font-weight: medium; color: green; font-size:140%\">
<b>Using or Distributing a Modelica <U>Document</U> under the Modelica License 2</b></P>
 
<P STYLE=\"text-indent: 0pt; font-weight: medium\">This
section is devoted especially for the following applications:</P>
<OL>
        <LI>
        A Modelica tool extracts information out of a Modelica package and
        presents the result in form of a &ldquo;manual&rdquo; for this
        package in, e.g., html, doc, or pdf format.</LI>
        <LI>
        The Modelica language specification is a document defining the
        Modelica language. It will be licensed under Modelica License 2.</LI>
        <LI>
        Someone writes a book about the Modelica language and/or Modelica
        packages and uses information which is available in the Modelica
        language specification and/or the corresponding Modelica package.</LI>
</OL>
 
<P><B>Can I sell a manual
that was basically derived by extracting information automatically
from a Modelica package under Modelica License 2 (e.g., a &ldquo;reference
guide&rdquo; of the Modelica Standard Library):</B></P>
<P>Yes.
Extracting information from a Modelica package, and providing it in a
human readable, suitable format, like html, doc or pdf format, where
the content is significantly modified (e.g. tables with interface
information are constructed from the declarations of the public
variables) qualifies as Derivative Work and there are no restrictions
to charge a fee for Derivative Work under alternative 2d).</P>
 
<P><B>Can
I copy a text passage out of a Modelica document (under Modelica
License 2) and use it </B><U><B>unmodified</B></U><B> in my document
(e.g. the Modelica syntax description in the Modelica Specification)?</B></P>
<P>Yes.
In case you distribute your document, the copied parts are still
under Modelica License 2 and you are not allowed to charge a license
fee for this part. You can, of course, charge a fee for the rest of
your document.</P>
 
<P><B>Can
I copy a text passage out of a Modelica document (under Modelica
License 2) and use it in </B><U><B>modified</B></U><B> form in my
document?</B></P>
<P>Yes,
the creation of Derivative Works is allowed. In case the content is
significantly modified this qualifies as Derivative Work and there
are no restrictions to charge a fee for Derivative Work under
alternative 2d).</P>
 
<P><B>Can I sell a printed
version of a Modelica document (under Modelica License 2), e.g., the
Modelica Language Specification?</B></P>
<P>No,
if you are not the c" + "opyright-holder, since article 2c) does not allow
a selling fee for a (in this case physical) copy. However, mere
printing and shipping costs may be recovered.</P>
</html>
"));

  end ModelicaLicense2;

class Contact "Contact"

    annotation (Documentation(info="<html>
 
<dl>
<dt>The Modelica_Fluid library (this Modelica package)
    is developed by many people from different organizations (see list below).
    It is licensed under the
    <a href=\"Modelica://Modelica_Fluid.UsersGuide.ModelicaLicense2\">Modelica License 2</a>
    by:<br>&nbsp;</dt>
<dd>Modelica Association<br>
    (Ideella F&ouml;reningar 822003-8858 in Link&ouml;ping) <br>
    c/o PELAB, IDA, Link&ouml;pings Universitet<br>
    S-58183 Link&ouml;ping<br>
    Sweden<br>
    email: <a href=\"mailto:Board@Modelica.org\">Board@Modelica.org</a><br>
    web: <a href=\"http://www.Modelica.org\">http://www.Modelica.org</a><br>&nbsp;<br>&nbsp;</dd>
</dl>
 
<dl>
<dt>The development of the Modelica_Fluid package is organized by<br>&nbsp;</dt>
<dd>
<table border=0 cellspacing=0 cellpadding=2>
<tr>
<td>
    Francesco Casella<br>
    Dipartimento di Elettronica e Informazione<br>
    Politecnico di Milano<br>
    Via Ponzio 34/5<br>
    I-20133 Milano, Italy<br>
    email: <A HREF=\"mailto:casella@elet.polimi.it\">casella@elet.polimi.it</A><br>&nbsp;
</td>
<td></td>
<td>and</td>
<td></td>
<td>
    R&uuml;diger Franke<br>
    ABB AG<br>
    PTSP-E22<br>
    Kallstadter Str. 1<br>
    D-68163, Germany<br>
    email: <A HREF=\"mailto:ruediger.franke@de.abb.com\">ruediger.franke@de.abb.com</A><br>&nbsp;
</td>
</tr>
</table>
</dd>
</dl>
<p><b>Acknowledgements:</b></p>
<p>
The development of this library has been a collaborative effort
and many have contributed.
</p>
<ul>
<li> The previous design of this library (until beginning of 2008) was based on the paper
     Elmqvist H., Tummescheit H., and Otter M.:
     <a href=\"http://www.modelica.org/events/Conference2003/papers/h40_Elmqvist_fluid.pdf\">
     Object-Oriented Modeling of Thermo-Fluid Systems</a>.
     Modelica 2003 Conference, Link&ouml;ping, Sweden, pp. 269-286, Nov. 3-4, 2003.<br>
     This design has been partly changed, especially by the introduction of the streams
     concept.</li>
 
<li> The Fluid library development was organized in 2002-2004 by Martin
     Otter, since 2004 it is organized by Francesco Casella, and
     since 2008 it is organized jointly by Francesco Casella and R&uuml;diger Franke.</li>
 
<li> Francesco Casella included several components of his ThermoPower
     library with some rewriting. The stream connector concept used in Modelica_Fluid is
     based on a similar concept developed by him for the ThermoPower library.</li>
 
<li> R&uuml;diger Franke initiated the stream connector concept as an extension
     and improved version of the ThermoPower concept. In Nov. 2008 - Jan. 2009 he
     greatly restructured and improved the library.<li>
 
<li> Michael Wetter introduced trace constituents in Modelica_Fluid consistently and
     provided corresponding examples under Examples.TraceSubstances.</li>
 
<li> The following people contributed to the fluid component models,
     examples, and the further design of the library
     (alphabetical list):<br>
     John Batteh,
     Francesco Casella, Jonas Eborn, Hilding Elmqvist,
     R&uuml;diger Franke, Manuel Gr&auml;ber, Henning Knigge,
     Sven Erik Mattsson, Chuck Newman, Hans Olsson,
     Martin Otter, Katrin Pr&ouml;l&szlig;,
     Christoph Richter, Michael Sielemann, Mike Tiller, Hubertus Tummescheit,
     Allan Watson, Michael Wetter.</li>
</ul>
 
<p>
  Partial financial support of ABB and DLR by BMBF (BMBF Förderkennzeichen: 01IS07022F) for the further development
     of this library within the <a href=\"http://www.itea2.org\">ITEA</a> project
     <a href=\"http://www.itea2.org/public/project_leaflets/EUROSYSLIB_profile_oct-07.pdf\">EUROSYSLIB</a>
     is highly appreciated.</p>
 
 
</html>"));
end Contact;
end UsersGuide;

annotation (
  version="1.0",
  versionBuild="$Rev$",
  versionDate="$Date::                            $",
  preferedView="info",
  Settings(NewStateSelection=true),
  uses(Modelica(version="3.0.1")),
  classOrder={"UsersGuide","Examples","System","Vessels","Pipes","Machines","Valves",
      "Fittings", "Sources", "Sensors", "Interfaces", "Types", "Utilities", "Icons", "Test", "*"},
  Documentation(info="<html>
<p>
The <b>Modelica_Fluid</b> library is a <b>free</b> Modelica package provided under the
<a href=\"Modelica://Modelica_Fluid.UsersGuide.ModelicaLicense2\">Modelica License 2</a>.
The library contains components describing
<b>1-dimensional thermo-fluid flow</b> in networks of vessels, pipes, fluid machines, valves and fittings. 
A unique feature is that the component equations and the media models
as well as pressure loss and heat transfer correlations are decoupled from each other.
All components are implemented such that they can be used for
media from the Modelica.Media library. This means especially that an
incompressible or compressible medium, a single or a multiple
substance medium with one or more phases might be used.
The goal is to include
the Modelica_Fluid library in the Modelica standard library as Modelica.Fluid.
</p>
 
<p>
In the next figure, several features of the library are demonstrated with
a simple heating system with a closed flow cycle. By just changing one configuration parameter in the system object the equations are changed between steady-state and dynamic simulation with fixed or steady-state initial conditions.
</p>
 
<blockquote>
    <img src=\"../Images/UsersGuide/HeatingSystem.png\" border=1>
</blockquote>
 
<p>
With respect to previous versions, the design
of the connectors has been changed in a non-backward compatible way,
using the recently developed concept
of stream connectors that results in much more reliable simulations
(see an overview and a rationale
<a href=\"..\\help\\Documentation\\Stream-Connectors-Overview-Rationale.pdf\">here</a>).
This extension will be included in Modelica 3.1.
As of Jan. 2009, the stream concept is supported in Dymola 7.1.
It is recommended to use Dymola 7.2 (announced for Feb. 2009), or a later Dymola version, since this version supports a new annotation to connect very
conveniently to vectors of connectors.
Other tool vendors will support the stream concept as well.
</p>
 
<p>
The following parts are useful, when newly starting with this library:
</p>
<ul>
<li> <a href=\"Modelica://Modelica_Fluid.UsersGuide\">Modelica_Fluid.UsersGuide</a>.</li>
<li> <a href=\"Modelica://Modelica_Fluid.UsersGuide.ReleaseNotes\">Modelica_Fluid.UsersGuide.ReleaseNotes</a>
     summarizes the changes of the library releases.</li>
<li> <a href=\"Modelica://Modelica_Fluid.Examples\">Modelica_Fluid.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>
 
 
<p>
<b>Licensed by the Modelica Association under the Modelica License 2</b><br>
Copyright &copy; 2002-2009, ABB, DLR, Dynasim, Modelon, TU Braunschweig, TU Hamburg-Harburg, Politecnico di Milano.
</p>
 
<p>
<i>This Modelica package is <u>free</u> software and
the use is completely at <u>your own risk</u>;
it can be redistributed and/or modified under the terms of the
Modelica license 2, see the license conditions (including the
disclaimer of warranty)
<a href=\"Modelica://Modelica_Fluid.UsersGuide.ModelicaLicense2\">here</a></u>
or at
<a href=\"http://www.Modelica.org/licenses/ModelicaLicense2\">
http://www.Modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
 
</html>"));
end Modelica_Fluid;
