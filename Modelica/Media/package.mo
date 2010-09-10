within Modelica;
package Media "Library of media property models"
extends Modelica.Icons.Package;
import SI = Modelica.SIunits;

package UsersGuide "User's Guide of Media Library"
  extends Modelica.Icons.Information;

  package MediumUsage "Medium usage"
    extends Modelica.Icons.Information;

    class BasicUsage "Basic usage"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<HTML>
<h4>Basic usage of medium model</h4>
<p>
Media models in Modelica.Media are provided by packages, inheriting from the
partial package Modelica.Media.Interfaces.PartialMedium. Every package defines:
<ul>
<li> Medium <b>constants</b> (such as the number of chemical substances,
     molecular data, critical properties, etc.).
<li> A BaseProperties <b>model</b>, to compute the basic thermodynamic
     properties of the fluid;
<li> <b>setState_XXX</b> functions to compute the thermodynamic state record from
     different input arguments (such as density, temperature, and composition which
     would be setState_dTX);
<li> <b>Functions</b> to compute additional properties (such as saturation
     properties, viscosity, thermal conductivity, etc.).
</ul>
There are - as stated above - two different basic ways of using the Media library which
will be described in more details in the following section. One way is to use the model BaseProperties.
Every instance of BaseProperties for any medium model provides <b>3+nXi
equations</b> for the following <b>5+nXi variables</b> that are declared in
the medium model (nXi is the number of independent mass fractions, see
explanation below):
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Variable</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">T</td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">temperature</td></tr>
  <tr><td valign=\"top\">p</td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">absolute pressure</td></tr>
  <tr><td valign=\"top\">d</td>
      <td valign=\"top\">kg/m3</td>
      <td valign=\"top\">density</td></tr>
  <tr><td valign=\"top\">u</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific internal energy</td></tr>
  <tr><td valign=\"top\">h</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific enthalpy (h = u + p/d)</td></tr>
  <tr><td valign=\"top\">Xi[nXi]</td>
      <td valign=\"top\">kg/kg</td>
      <td valign=\"top\">independent mass fractions m_i/m</td></tr>
  <tr><td valign=\"top\">X[nX]</td>
      <td valign=\"top\">kg/kg</td>
      <td valign=\"top\">All mass fractions m_i/m. X is defined in BaseProperties by:<br>
          X = <b>if</b> reducedX <b>then</b> vector([Xi; 1-<b>sum</b>(Xi)])
          <b>else</b> Xi </td></tr>
</table>
<p>
<b>Two</b> variables out of p, d, h, or u, as well as the
<b>mass fractions</b> Xi are the <b>independent</b> variables and the
medium model basically provides equations to compute
the remaining variables, including the full mass fraction vector X
(more details to Xi and X are given further below).
</p>
<p>
In a component, the most basic usage of a medium model is as follows
</p>
<pre>
  <b>model</b> Pump
    <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
                         \"Medium model\" <b>annotation</b> (__Dymola_choicesAllMatching = <b>true</b>);
    Medium.BaseProperties medium_a \"Medium properties at location a (e.g., port_a)\";
    // Use medium variables (medium_a.p, medium_a.T, medium_a.h, ...)
     ...
  <b>end</b> Pump;
</pre>
<p>
The second way is to use the setState_XXX functions to compute the thermodynamic state
record from which all other thermodynamic state variables can be computed (see
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.BasicDefinition\">
Basic definition of medium</a> for further details on ThermodynamicState). The setState_XXX functions
accept either X or Xi (see explanation below) and will decide internally which of these two compositions
is provided by the user. The four fundamental setState_XXX functions are provided in PartialMedium
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Function</b></td>
      <td valign=\"top\"><b>Description</b></td>
      <td valign=\"top\"><b>Short-form for<br>single component medium</b></td></tr>
  <tr><td valign=\"top\">setState_dTX</td>
      <td valign=\"top\">computes ThermodynamicState from density, temperature, and composition X or Xi</td>
      <td valign=\"top\">setState_dT</td></tr>
  <tr><td valign=\"top\">setState_phX</td>
      <td valign=\"top\">computes ThermodynamicState from pressure, specific enthalpy, and composition X or Xi</td>
      <td valign=\"top\">setState_ph</td></tr>
  <tr><td valign=\"top\">setState_psX</td>
      <td valign=\"top\">computes ThermodynamicState from pressure, specific entropy, and composition X or Xi</td>
      <td valign=\"top\">setState_ps</td></tr>
  <tr><td valign=\"top\">setState_pTX</td>
      <td valign=\"top\">computes ThermodynamicState from pressure, temperature, and composition X or Xi</td>
      <td valign=\"top\">setState_pT</td></tr>
</table>
<p>
The simple example that explained the basic usage of BaseProperties would then become
<pre>
  <b>model</b> Pump
    <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
                         \"Medium model\" <b>annotation</b> (__Dymola_choicesAllMatching = <b>true</b>);
    Medium.ThermodynamicState state_a \"Thermodynamic state record at location a (e.g., port_a)\";
    // Compute medium variables from thermodynamic state record (pressure(state_a), temperature(state_a),
    // specificEnthalpy(state_a), ...)
    ...
  <b>end</b> Pump;
</pre>
<p>
All media models are directly or indirectly a subpackage of package
Modelica.Media.Interfaces.PartialMedium. Therefore,
a medium model in a component should inherit from this
partial package. Via the annotation \"__Dymola_choicesAllMatching = true\" it
is defined that the tool should display a selection box with
all loaded packages that inherit from PartialMedium. An example
is given in the next figure:
</p>
<IMG src=\"modelica://Modelica/Resources/Images/Media/UsersGuide/mediumMenu.png\" ALT=\"medium selection menu\">
<p>
A selected medium model leads, e.g., to the following equation:
</p>
<pre>
  Pump pump(<b>redeclare package</b> Medium = Modelica.Media.Water.SimpleLiquidWater);
</pre>
<p>
Usually, a medium model is associated with the variables of a
fluid connector. Therefore, equations have to be defined in a model
that relate the variables in the connector with the variables
in the medium model:
</p>
<pre>
  <b>model</b> Pump
    <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
                         \"Medium model\" <b>annotation</b> (__Dymola_choicesAllMatching = <b>true</b>);
    Medium.BaseProperties medium_a \"Medium properties of port_a\";
    // definition of the fluid port port_a
     ...
  <b>equation</b>
    medium.p = port_a.p;
    medium.h = port_a.h;
    medium.Xi = port_a.Xi;
     ...
  <b>end</b> Pump;
</pre>
in the case of using BaseProperties or
<pre>
  <b>model</b> Pump
    <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
                         \"Medium model\" <b>annotation</b> (__Dymola_choicesAllMatching = <b>true</b>);
    Medium.ThermodynamicState state_a \"Thermodynamic state record of medium at port_a\";
    // definition of the fluid port port_a
     ...
  <b>equation</b>
    state_a = Medium.setState_phX(port_a.p, port_a.h, port_a.Xi) // if port_a contains the variables
                                                                 // p, h, and Xi
     ...
  <b>end</b> Pump;
</pre>
in the case of using ThermodynamicState.
<p>
If a component model shall treat both single and multiple
substance fluids, equations for the mass fractions have to be
present (above: medium.Xi = port_a.Xi) in the model. According
to the Modelica semantics, the equations of the mass fractions
are ignored, if the dimension of Xi is zero, i.e., for a single-component
medium. Note, by specific techniques sketched in section
\"Medium definition\", the independent variables in the medium model
need not to be the same as the variables in the connector and still
get the same efficiency, as if the same variables would be used.
</p>

<p>
If a fluid consists of a single
substance, <b>nXi = 0</b> and the vector of mass fractions Xi is not
present. If a fluid consists of nS substances,
the medium model may define the number of independent
mass fractions <b>nXi</b> to be <b>nS</b>, <b>nS-1</b>, or zero.
In all cases, balance equations for nXi substances have to be
given in the corresponding component (see discussion below).
Note, that if nXi = nS, the constraint \"sum(Xi)=1\" between the mass
fractions is <b>not</b> present in the model; in that case, it is necessary to
provide consistent start values for Xi such that sum(Xi) = 1.
</p>

<p>
The reason for this definition of Xi is that a fluid component library
can be implemented by using only the independent mass fractions Xi and
then via the medium it is defined how Xi is interpreted:
</p>

<ul>
<li> If Xi = nS, then the constraint equation sum(X) = 1 is neglected
     during simulation. By making sure that the initial conditions of X
     fulfill this constraint, it can usually be guaranteed that small
     errors in sum(X) = 1 remain small although this constraint equation is
     not explicitly used during the simulation. This approach is usually useful
     if components of the mixture can become very small. If such a small
     quantity is computed via the equation 1 - sum(X[1:nX-1]), there might
     be large numerical errors and it is better to compute it via
     the corresponding balance equation.</li>
<li> If Xi = nS-1, then the true independent mass fractions are used
     in the fluid component and the last component of X is computed via
     X[nX] = 1 - sum(Xi). This is useful for, e.g., MoistAir, where the
     number of states should be as small as possible without introducing
     numerical problems.</li>
<li> If Xi = 0, then the reference value of composition reference_X is
     assumed. This case is useful to avoid composition states in all
     the cases when the composition will always be constant, e.g., with
     circuits having fixed composition sources.
</ul>

<p>
The full vector of mass fractions <b>X[nX]</b> is computed in
PartialMedium.BaseProperties based on Xi, reference_X, and the information whether Xi = nS or nS-1. For single-substance media, nX = 0, so there's also no X vector. For multiple-substance media, nX = nS, and X always contains the full vector of mass fractions. In order to reduce confusion for the user of a fluid component library, \"Xi\" has the annotation \"HideResult=true\", meaning, that this variable is not shown in the plot window. Only X is shown in the plot window and this vector always contains all mass fractions.
</p>
</HTML>"));
    end BasicUsage;

    class BalanceVolume "Balance volume"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<HTML>
<p>
Fluid libraries usually have balance volume components with one fluid connector
port that fulfill the mass and energy balance and on a different grid components that
fulfill the momentum balance. A balance volume component, called junction
volume below, should be primarily implemented in the following way
(see also the implementation in
<a href=\"modelica://Modelica.Media.Examples.Tests.Components.PortVolume\">
Modelica.Media.Examples.Tests.Components.PortVolume</a>):
</p>
<pre>
  <b>model</b> JunctionVolume
    <b>import</b> SI=Modelica.SIunits;
    <b>import</b> Modelica.Media.Examples.Tests.Components.FluidPort_a;

    <b>parameter</b> SI.Volume V = 1e-6 \"Fixed size of junction volume\";
    <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
                           \"Medium model\" <b>annotation</b> (__Dymola_choicesAllMatching = <b>true</b>);

    FluidPort_a port(<b>redeclare package</b> Medium = Medium);
    Medium.BaseProperties medium(preferredMediumStates = <b>true</b>);

    SI.Energy U               \"Internal energy of junction volume\";
    SI.Mass   M               \"Mass of junction volume\";
    SI.Mass   MX[Medium.nXi] \"Independent substance masses of junction volume\";
  <b>equation</b>
    medium.p   = port.p;
    medium.h   = port.h;
    medium.Xi = port.Xi;

    M  = V*medium.d;                  // mass of JunctionVolume
    MX = M*medium.Xi;                // mass fractions in JunctionVolume
    U  = M*medium.u;                  // internal energy in JunctionVolume

    <b>der</b>(M)  = port.m_flow;    // mass balance
    <b>der</b>(MX) = port.mX_flow;   // substance mass balance
    <b>der</b>(U)  = port.H_flow;    // energy balance
  <b>end</b> JunctionVolume;
</pre>
<p>
Assume the Modelica.Media.Air.SimpleAir medium model is used with
the JunctionVolume model above. This medium model uses pressure p
and temperature T as independent variables. If the flag
\"preferredMediumStates\" is set to <b>true</b> in the declaration
of \"medium\", then the independent variables of this medium model
get the attribute \"stateSelect = StateSelect.prefer\", i.e., the
Modelica translator should use these variables as states, if this
is possible. Basically, this means that
constraints between the
potential states p,T and the potential states U,M are present.
A Modelica tool will therefore <b>automatically</b>
differentiate medium equations and will use the following
equations for code generation (note the equations related to X are
removed, because SimpleAir consists of a single substance only):
</p>
<pre>
    M  = V*medium.d;
    U  = M*medium.u;

    // balance equations
    <b>der</b>(M)  = port.m_flow;
    <b>der</b>(U)  = port.H_flow;

    // abbreviations introduced to get simpler terms
    p = medium.p;
    T = medium.T;
    d = medium.d;
    u = medium.u;
    h = medium.h;

    // medium equations
    d = fd(p,T);
    h = fh(p,T);
    u = h - p/d;

    // equations derived <b>automatically</b> by a Modelica tool due to index reduction
    <b>der</b>(U) = <b>der</b>(M)*u + M*<b>der</b>(u);
    <b>der</b>(M) = V*<b>der</b>(d);
    <b>der</b>(u) = <b>der</b>(h) - <b>der</b>(p)/d - p/<b>der</b>(d);
    <b>der</b>(d) = <b>der</b>(fd,p)*<b>der</b>(p) + <b>der</b>(fd,T)*<b>der</b>(T);
    <b>der</b>(h) = <b>der</b>(fh,p)*<b>der</b>(p) + <b>der</b>(fd,T)*<b>der</b>(T);
</pre>
<p>
Note, that \"der(y,x)\" is an operator that characterizes
in the example above the partial derivative of y with respect to x
(this operator will be included in one of the next Modelica language
releases).
All media models in this library are written in such a way that
at least the partial derivatives of the medium variables with
respect to the independent variables are provided, either because
the equations are directly given (= symbolic differentiation is possible)
or because the derivative of the corresponding function (such as fd above)
is provided. A Modelica tool will transform the equations above
in differential equations with p and T as states, i.e., will
generate equations to compute <b>der</b>(p) and <b>der</b>(T) as function of p and T.
</p>

<p>
Note, when preferredMediumStates = <b>false</b>, no differentiation
will take place and the Modelica translator will use the variables
appearing differentiated as states, i.e., M and U. This has the
disadvantage that for many media non-linear systems of equations are
present to compute the intrinsic properties p, d, T, u, h from
M and U.
</p>
</HTML>"));
    end BalanceVolume;

    class ShortPipe "Short pipe"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<HTML>
<p>
Fluid libraries have components with two ports that store
neither mass nor energy and fulfill the
momentum equation between their two ports, e.g., a short pipe. In most
cases this means that an equation is present relating the pressure
drop between the two ports and the mass flow rate from one to the
other port. Since no mass or energy is stored, no differential
equations for thermodynamic variables are present. A component model of this type
has therefore usually the following structure
(see also the implementation in
<a href=\"modelica://Modelica.Media.Examples.Tests.Components.ShortPipe\">
Modelica.Media.Examples.Tests.Components.ShortPipe</a>):
</p>
<pre>
  <b>model</b> ShortPipe
    <b>import</b> SI=Modelica.SIunits;
    <b>import</b> Modelica.Media.Examples.Tests.Components;

    // parameters defining the pressure drop equation

    <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
                           \"Medium model\" <b>annotation</b> (__Dymola_choicesAllMatching = <b>true</b>);

    Component.FluidPort_a port_a (<b>redeclare package</b> Medium = Medium);
    Component.FluidPort_b port_b (<b>redeclare package</b> Medium = Medium);

    SI.Pressure dp = port_a.p - port_b.p \"Pressure drop\";
    Medium.BaseProperties medium_a \"Medium properties in port_a\";
    Medium.BasePropreties medium_b \"Medium properties in port_b\";
  <b>equation</b>
    // define media models of the ports
    medium_a.p   = port_a.p;
    medium_a.h   = port_a.h;
    medium_a.Xi = port_a.Xi;

    medium_b.p   = port_b.p;
    medium_b.h   = port_b.h;
    medium_b.Xi = port_b.Xi;

    // Handle reverse and zero flow (semiLinear is a built-in Modelica operator)
    port_a.H_flow   = <b>semiLinear</b>(port_a.m_flow, port_a.h, port_b.h);
    port_a.mXi_flow = <b>semiLinear</b>(port_a.m_flow, port_a.Xi, port_b.Xi);

    // Energy, mass and substance mass balance
    port_a.H_flow + port_b.H_flow = 0;
    port_a.m_flow + port_b.m_flow = 0;
    port_a.mXi_flow + port_b.mXi_flow = zeros(Medium.nXi);

    // Provide equation: port_a.m_flow = f(dp)
  <b>end</b> ShortPipe;
</pre>

<p>
The <b>semiLinear</b>(..) operator is basically defined as:
</p>
<pre>
    semiLinear(m_flow, ha, hb) = if m_flow &ge; 0 then m_flow*ha else m_flow*hb;
</pre>

<p>
that is, it computes the enthalpy flow rate either from the port_a or
from the port_b properties, depending on flow direction. The exact
details of this operator are given in
<a href=\"modelica://ModelicaReference.Operators.SemiLinear\">
ModelicaReference.Operators.SemiLinear</a>. Especially, rules
are defined in the Modelica specification that m_flow = 0 can be treated
in a \"meaningful way\". Especially, if n fluid components (such as pipes)
are connected together and the fluid connector from above is used,
a linear system of equations appear between
medium1.h, medium2.h, medium3.h, ..., port1.h, port2.h, port3.h, ...,
port1.H_flow, port2.H_flow, port3.H_flow, .... The rules for the
semiLinear(..) operator allow the following solution of this
linear system of equations:
</p>

<ul>
<li> n = 2 (two components are connected):<br>
     The linear system of equations can be analytically solved
     with the result
     <pre>
     medium1.h = medium2.h = port1.h = port2.h
     0 = port1.H_flow + port2.H_flow
     </pre>
     Therefore, no problems with zero mass flow rate are present.</li>

<li> n &gt; 2 (more than two components are connected together):<br>
     The linear system of equations is solved numerically during simulation.
     For m_flow = 0, the linear system becomes singular and has an
     infinite number of solutions. The simulator could use the solution t
     that is closest to the solution in the previous time step
     (\"least squares solution\"). Physically, the solution is determined
     by diffusion which is usually neglected. If diffusion is included,
     the linear system is regular.</li>
</ul>

</HTML>"));
    end ShortPipe;

    class OptionalProperties "Optional properties"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<HTML>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the functions listed in the following table. They are
defined as partial functions within package
<a href=\"modelica://Modelica.Media.Interfaces.PartialMedium\">PartialMedium</a>,
and then (optionally) implemented in actual medium packages.
If a component calls such an optional function and the
medium package does not provide a new implementation for this
function, an error message is printed at translation time,
since the function is \"partial\", i.e., incomplete.
The argument of all functions is the <b>state</b> record,
automatically defined by the BaseProperties model or specifically computed using the
setState_XXX functions, which contains the
minimum number of thermodynamic variables needed to compute all the additional
properties. In the table it is assumed that there is a declaration of the
form:
</p>
<pre>
   <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium;
   Medium.ThermodynamicState state;
</pre>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Function call</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">Medium.dynamicViscosity(state)</b></td>
      <td valign=\"top\">Pa.s</td>
      <td valign=\"top\">dynamic viscosity</td></tr>
  <tr><td valign=\"top\">Medium.thermalConductivity(state)</td>
      <td valign=\"top\">W/(m.K)</td>
      <td valign=\"top\">thermal conductivity</td></tr>
  <tr><td valign=\"top\">Medium.prandtlNumber(state)</td>
      <td valign=\"top\">1</td>
      <td valign=\"top\">Prandtl number</td></tr>
  <tr><td valign=\"top\">Medium.specificEntropy(state)</td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">specific entropy</td></tr>
  <tr><td valign=\"top\">Medium.specificHeatCapacityCp(state)</td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">specific heat capacity at constant pressure</td></tr>
  <tr><td valign=\"top\">Medium.specificHeatCapacityCv(state)</td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">specific heat capacity at constant density</td></tr>
  <tr><td valign=\"top\">Medium.isentropicExponent(state)</td>
      <td valign=\"top\">1</td>
      <td valign=\"top\">isentropic exponent</td></tr>
  <tr><td valign=\"top\">Medium.isentropicEnthatlpy(pressure, state)</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">isentropic enthalpy</td></tr>
  <tr><td valign=\"top\">Medium.velocityOfSound(state)</td>
      <td valign=\"top\">m/s</td>
      <td valign=\"top\">velocity of sound</td></tr>
  <tr><td valign=\"top\">Medium.isobaricExpansionCoefficient(state)</td>
      <td valign=\"top\">1/K</td>
      <td valign=\"top\">isobaric expansion coefficient</td></tr>
  <tr><td valign=\"top\">Medium.isothermalCompressibility(state)</td>
      <td valign=\"top\">1/Pa</td>
      <td valign=\"top\">isothermal compressibility</td></tr>
  <tr><td valign=\"top\">Medium.density_derp_h(state)</td>
      <td valign=\"top\">kg/(m3.Pa)</td>
      <td valign=\"top\">derivative of density by pressure at constant enthalpy</td></tr>
  <tr><td valign=\"top\">Medium.density_derh_p(state)</td>
      <td valign=\"top\">kg2/(m3.J)</td>
      <td valign=\"top\">derivative of density by enthalpy at constant pressure</td></tr>
  <tr><td valign=\"top\">Medium.density_derp_T(state)</td>
      <td valign=\"top\">kg/(m3.Pa)</td>
      <td valign=\"top\">derivative of density by pressure at constant temperature</td></tr>
  <tr><td valign=\"top\">Medium.density_derT_p(state)</td>
      <td valign=\"top\">kg/(m3.K)</td>
      <td valign=\"top\">derivative of density by temperature at constant pressure</td></tr>
  <tr><td valign=\"top\">Medium.density_derX(state)</td>
      <td valign=\"top\">kg/m3</td>
      <td valign=\"top\">derivative of density by mass fraction</td></tr>
  <tr><td valign=\"top\">Medium.molarMass(state)</td>
      <td valign=\"top\">kg/mol</td>
      <td valign=\"top\">molar mass</td></tr>
</table>
<p>
There are also some short forms provided for user convenience that allow the computation of certain
thermodynamic state variables without using the ThermodynamicState record explicitly. Those short forms
are for example useful to compute consistent start values in the initial equation section. Let's
consider the function temperature_phX(p,h,X) as an exmaple. This function computes the temperature
from pressure, specific enthalpy, and composition X (or Xi) and is a short form for writing
</p>
<pre>
  temperature(setState_phX(p,h,X))
</pre>
<p>
The following functions are predefined in PartialMedium (other functions can be added in the actual
medium implementation package if they are useful)
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\">Medium.specificEnthalpy_pTX(p,T,X)</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">Specific enthalpy at p, T, X </td></tr>
  <tr><td valign=\"top\">Medium.temperature_phX(p,h,X)</td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">Temperature at p, h, X</td></tr>
  <tr><td valign=\"top\">Medium.density_phX(p,h,X)</td>
      <td valign=\"top\">kg/m3</td>
      <td valign=\"top\">Density at p, h, X</td></tr>
  <tr><td valign=\"top\">Medium.temperature_psX(p,s,X)</td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">Temperature at p, s, X</td></tr>
  <tr><td valign=\"top\">Medium.specificEnthalpy_psX(p,s,X)</td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">Specific entropy at p, s, X</td></tr>
</table>
<p>
Assume for example that the dynamic viscosity eta is needed in
the pressure drop equation of a short pipe. Then, the
model of a short pipe has to be changed to:
</p>
<pre>
  <b>model</b> ShortPipe
      ...
    Medium.BaseProperties medium_a \"Medium properties in port_a\";
    Medium.BaseProperties medium_b \"Medium properties in port_b\";
      ...
    Medium.DynamicViscosity eta;
      ...
    eta = <b>if</b> port_a.m_flow &gt; 0 <b>then</b>
               Medium.dynamicViscosity(medium_a.state)
          <b>else</b>
               Medium.dynamicViscosity(medium_b.state);
    // use eta in the pressure drop equation: port_a.m_flow = f(dp, eta)
  <b>end</b> ShortPipe;
</pre>

<p>
Note, \"Medium.DynamicViscosity\" is a type defined in Modelica.Interfaces.PartialMedium
as
</p>

<pre>
  <b>import</b> SI = Modelica.SIunits;
  <b>type</b> DynamicViscosity = SI.DynamicViscosity (
                                     min=0,
                                     max=1.e8,
                                     nominal=1.e-3,
                                     start=1.e-3);
</pre>

<p>
Every medium model may modify the attributes, to provide, e.g.,
min, max, nominal, and start values adapted to the medium.
Also, other types, such as AbsolutePressure, Density, MassFlowRate,
etc. are defined in PartialMedium. Whenever possible, these medium
specific types should be used in a model in order that medium information,
e.g., about nominal or start values, are automatically utilized.
</p>

</pre>

</HTML>"));
    end OptionalProperties;

    class Constants "Constants"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<HTML>
<p>
Every medium model provides the following <b>constants</b>. For example,
if a medium is declared as:
</p>
<pre>
   <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium;
</pre>
<p>
then constants \"Medium.mediumName\", \"Medium.nX\", etc. are defined:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Type</b></td>
      <td valign=\"top\"><b>Name</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">String</td><td valign=\"top\">mediumName</td>
      <td valign=\"top\">Unique name of the medium (is usually used to check whether
          the media in different components connected together
          are the same, by providing Medium.mediumName as quantity
          attribute of the mass flow rate in the connector)</td></tr>
  <tr><td valign=\"top\">String</td><td valign=\"top\">substanceNames[nS]</td>
      <td valign=\"top\">Names of the substances that make up the medium.
          If only one substance is present, substanceNames = {mediumName}.</td></tr>
  <tr><td valign=\"top\">String</td><td valign=\"top\">extraPropertiesNames[nC]</td>
      <td valign=\"top\">Names of the extra transported substances, outside of mass and
          energy balances.</td></tr>
  <tr><td valign=\"top\">Boolean</td><td valign=\"top\">singleState</td>
      <td valign=\"top\">= <b>true</b>, if u and d are not a function of pressure, and thus only
          a function of a single thermal variable (temperature or enthalpy) and
          of Xi for a multiple substance medium. Usually, this flag is
          <b>true</b> for incompressible media. It is used in a model to determine
          whether 1+nXi (singleState=<b>true</b>) or 2+nXi (singleState=<b>false</b>)
          initial conditions have to be provided for a volume element that
          contains mass and energy balance.</td></tr>
  <tr><td valign=\"top\">AbsolutePressure</td><td valign=\"top\">reference_p</td>
      <td valign=\"top\">Reference pressure for the medium</td></tr>
  <tr><td valign=\"top\">MassFraction</td><td valign=\"top\">reference_X[nX]</td>
      <td valign=\"top\">Reference composition for the medium</td></tr>
  <tr><td valign=\"top\">AbsolutePressure</td><td valign=\"top\">p_default</td>
      <td valign=\"top\">Default value for pressure of medium (for initialization)</td></tr>
  <tr><td valign=\"top\">Temperature</td><td valign=\"top\">T_default</td>
      <td valign=\"top\">Default value for temperature of medium (for initialization)</td></tr>
  <tr><td valign=\"top\">SpecificEnthalpy</td><td valign=\"top\">h_default</td>
      <td valign=\"top\">Default value for specific enthalpy of medium (for initialization)</td></tr>
  <tr><td valign=\"top\">MassFraction</td><td valign=\"top\">X_default[nX]</td>
      <td valign=\"top\">Default value for mass fractions of medium (for initialization)</td></tr>
  <tr><td valign=\"top\">Integer</td><td valign=\"top\">nS</td>
      <td valign=\"top\">number of substances contained in the medium.</td></tr>
  <tr><td valign=\"top\">Integer</td><td valign=\"top\">nX</td>
      <td valign=\"top\">Size of the full mass fraction vector X nX=nS.</td></tr>
  <tr><td valign=\"top\">Integer</td><td valign=\"top\">nXi</td>
      <td valign=\"top\">Number of independent mass fractions. If there is a single substance,
          then nXi = 0. </td></tr>
  <tr><td valign=\"top\">Boolean</td><td valign=\"top\">reducedX</td>
      <td valign=\"top\">= <b>true</b>, if the medium has a single substance, or if the medium model
          has multiple substances and contains the equation sum(X) = 1.
          In both cases, nXi = nS - 1 (unless fixedX = true).<br>
          = <b>false</b>, if the medium has multiple substances and does not contain the
          equation sum(X)=1, i.e., nXi = nX = nS (unless fixedX = true).
       </td></tr>
  <tr><td valign=\"top\">Boolean</td><td valign=\"top\">fixedX</td>
      <td valign=\"top\">= <b>false</b>: the composition of the medium can vary, and is
          determined by nXi independent mass fractions (see reducedX above).<br>
          = <b>true</b>: the composition of the medium is always reference_X,
          and nXi = 0.</td></tr>
  <tr><td valign=\"top\">FluidConstants</td><td valign=\"top\">fluidConstants[nS]</td>
      <td valign=\"top\">Critical, triple, molecular and other
          standard data that are provided for
          every substance of a medium.</td></tr>
</table>

<p>
The record FluidConstants that is defined in PartialMedium contains the following elements
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Type</b></td>
      <td valign=\"top\"><b>Name</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>

  <tr><td valign=\"top\">String</td>
      <td valign=\"top\">iupacName</td>
      <td valign=\"top\">complete IUPAC name</td></tr>

  <tr><td valign=\"top\">String</td>
      <td valign=\"top\">casRegistryNumber</td>
      <td valign=\"top\">chemical abstracts sequencing number</td></tr>

  <tr><td valign=\"top\">String</td>
      <td valign=\"top\">chemicalFormula</td>
      <td valign=\"top\">Chemical formula, (brutto, nomenclature according to Hill)</td></tr>

  <tr><td valign=\"top\">String</td>
      <td valign=\"top\">structureFormula</td>
      <td valign=\"top\">Chemical structure formula</td></tr>

  <tr><td valign=\"top\">MolarMass</td>
      <td valign=\"top\">molarMass</td>
      <td valign=\"top\">molar mass</td></tr>
</table>

<p> This record is extended in the partial packages further down the hierarchy (such as
PartialTwoPhaseMedium or PartialMixtureMedium) and may contain some or all of the following
elements</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\">Temperature</td>
      <td valign=\"top\">criticalTemperature</td>
      <td valign=\"top\">critical temperature</td></tr>

  <tr><td valign=\"top\">AbsolutePressure</td>
      <td valign=\"top\">criticalPressure</td>
      <td valign=\"top\">critical pressure</td></tr>

  <tr><td valign=\"top\">MolarVolume</td>
      <td valign=\"top\">criticalMolarVolume</td>
      <td valign=\"top\">critical molar Volume</td></tr>

  <tr><td valign=\"top\">Real</td>
      <td valign=\"top\">acentricFactor</td>
      <td valign=\"top\">Pitzer acentric factor</td></tr>

  <tr><td valign=\"top\">Temperature</td>
      <td valign=\"top\">triplePointTemperature</td>
      <td valign=\"top\">triple point temperature</td></tr>

  <tr><td valign=\"top\">AbsolutePressure</td>
      <td valign=\"top\">triplePointPressure</td>
      <td valign=\"top\">triple point pressure</td></tr>

  <tr><td valign=\"top\">Temperature</td>
      <td valign=\"top\">meltingPoint</td>
      <td valign=\"top\">melting point at 101325 Pa</td></tr>

  <tr><td valign=\"top\">Temperature</td>
      <td valign=\"top\">normalBoilingPoint</td>
      <td valign=\"top\">normal boiling point (at 101325 Pa)</td></tr>

  <tr><td valign=\"top\">DipoleMoment</td>
      <td valign=\"top\">dipoleMoment</td>
      <td valign=\"top\">dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)</td></tr>

  <tr><td valign=\"top\">Boolean</td>
      <td valign=\"top\">hasIdealGasHeatCapacity</td>
      <td valign=\"top\">true if ideal gas heat capacity is available</td></tr>

  <tr><td valign=\"top\">Boolean</td>
      <td valign=\"top\">hasCriticalData</td>
      <td valign=\"top\">true if critical data are known</td></tr>

  <tr><td valign=\"top\">Boolean</td>
      <td valign=\"top\">hasDipoleMoment</td>
      <td valign=\"top\">true if a dipole moment known</td></tr>

  <tr><td valign=\"top\">Boolean</td>
      <td valign=\"top\">hasFundamentalEquation</td>
      <td valign=\"top\">true if a fundamental equation</td></tr>

  <tr><td valign=\"top\">Boolean</td>
      <td valign=\"top\">hasLiquidHeatCapacity</td>
      <td valign=\"top\">true if liquid heat capacity is available</td></tr>

  <tr><td valign=\"top\">Boolean</td>
      <td valign=\"top\">hasSolidHeatCapacity</td>
      <td valign=\"top\">true if solid heat capacity is available</td></tr>

  <tr><td valign=\"top\">Boolean</td>
      <td valign=\"top\">hasAccurateViscosityData</td>
      <td valign=\"top\">true if accurate data for a viscosity function is available</td></tr>

  <tr><td valign=\"top\">Boolean</td>
      <td valign=\"top\">hasAccurateConductivityData</td>
      <td valign=\"top\">true if accurate data for thermal conductivity is available</td></tr>

  <tr><td valign=\"top\">Boolean</td>
      <td valign=\"top\">hasVapourPressureCurve</td>
      <td valign=\"top\">true if vapour pressure data, e.g., Antoine coefficents are known</td></tr>

  <tr><td valign=\"top\">Boolean</td>
      <td valign=\"top\">hasAcentricFactor</td>
      <td valign=\"top\">true if Pitzer accentric factor is known</td></tr>

  <tr><td valign=\"top\">SpecificEnthalpy</td>
      <td valign=\"top\">HCRIT0</td>
      <td valign=\"top\">Critical specific enthalpy of the fundamental equation</td></tr>

  <tr><td valign=\"top\">SpecificEntropy</td>
      <td valign=\"top\">SCRIT0</td>
      <td valign=\"top\">Critical specific entropy of the fundamental equation</td></tr>

  <tr><td valign=\"top\">SpecificEnthalpy</td>
      <td valign=\"top\">deltah</td>
      <td valign=\"top\">Difference between specific enthalpy model
          (h_m) and f.eq. (h_f) (h_m - h_f)</td></tr>

  <tr><td valign=\"top\">SpecificEntropy</td>
      <td valign=\"top\">deltas</td>
      <td valign=\"top\">Difference between specific enthalpy model (s_m) and f.eq.
          (s_f) (s_m - s_f)</td></tr>

</table>

</HTML>
"));
    end Constants;

    class TwoPhase "Two-phase media"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<HTML>
<p>
Models for media which can exist in one-phase or two-phase conditions inherit
from <a href=\"modelica://Modelica.Media.Interfaces.PartialTwoPhaseMedium\">
Modelica.Media.Interfaces.PartialTwoPhaseMedium</a>
(which inherits from PartialMedium). The basic usage of these
media models is the same as described in the previous sections. However, additional
functionalities are provided, which apply only to potentially two-phase media.
</p>
<p>
The following additional medium <b>constants</b> are provided:
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Type</b></td>
      <td valign=\"top\"><b>Name</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">Boolean</td>
      <td valign=\"top\">smoothModel</b></td>
      <td valign=\"top\">If this flag is false (default value), then events are triggered
          whenever the saturation boundary is crossed; otherwise, no events
      are generated.</td></tr>
  <tr><td valign=\"top\">Boolean</td>
      <td valign=\"top\">onePhase</b></td>
      <td valign=\"top\">If this flag is true, then the medium model assumes it will be never
          called in the two-phase region. This can be useful to speed up
      the computations in a two-phase medium, when the user is sure it will
      always work in the one-phase region. Default value: false.</td></tr>
</table>
</p>
<p>
The setState_ph(), setState_ps(), setState_dT() and setState_pT() functions have
one extra input, named <i>phase</i>. If the phase input is not specified, or if
it is given a value of zero, then the setState function will determine the phase,
based on the other input values. An input phase = 1 will force the setState
function to return a state vector corresponding to a one-phase state, while
phase = 2 will force the setState value to return a state vector corresponding
to a two-phase state, as shown in the following example;

</p>
<pre>
   <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
   Medium.ThermodynamicState state, state1, state2;
 <b>equation</b>
   // Set the state, given the pressure and the specific enthalpy
   // the phase is determined by the (p, h) values, and can be retrieved
   // from the state record
   state = Medium.setState_ph(p, h);
   phase = state1.phase;

   // Force the computation of the state with one-phase
   // equations of state, irrespective of the (p, h) values
   state1 = Medium.setState_ph(p, h, 1);

   // Force the computation of the state with 2-phase
   // equations of state, irrespective of the (p, h) values
   state2 = Medium.setState_ph(p, h, 2);
</pre>

<p> This feature can be used for the following purposes:
<ul>
<li> saving computational time, if one knows in advance the phase of the medium;
<li> unambiguously determine the phase, when the two inputs correspond to a point on the saturation boundary (the derivative functions have substantially different values on either side);
<li> get the properties of metastable states, like superheated water or subcooled vapour.
</ul>
</p>

<p>
Many additional optional functions are defined to compute properties of
saturated media, either liquid (bubble point) or vapour (dew point).
The argument to such functions is a SaturationProperties record, which can be
set starting from either the saturation pressure or the saturation temperature,
as shown in the following example.
</p>
<pre>
   <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
   Medium.SaturationProperties sat_p;
   Medium.SaturationProperties sat_T;
 <b>equation</b>
   // Set sat_p to saturation properties at pressure p
   sat_p = Medium.setSat_p(p);

   // Compute saturation properties at pressure p
   saturationTemperature_p = Medium.saturationTemperature_sat(sat_p);
   bubble_density_p =        Medium.bubbleDensity(sat_p);
   dew_enthalpy_p   =        Medium.dewEnthalpy(sat_p);

   // Set sat_T to saturation properties at temperature T
   sat_T = Medium.setSat_T(T);

   // Compute saturation properties at temperature T
   saturationTemperature_T = Medium.saturationPressure_sat(sat_T);
   bubble_density_T =        Medium.bubbleDensity(sat_T);
   dew_enthalpy_T =          Medium.dewEnthalpy(sat_T);
</pre>
</p>
<p>With reference to a model defining a pressure p, a temperature T, and a
SaturationProperties record sat, the following functions are provided:
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Function call</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">Medium.saturationPressure(T)</b></td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">Saturation pressure at temperature T</td></tr>
  <tr><td valign=\"top\">Medium.saturationTemperature(p)</b></td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">Saturation temperature at pressure p</td></tr>
  <tr><td valign=\"top\">Medium.saturationTemperature_derp(p)</b></td>
      <td valign=\"top\">K/Pa</td>
      <td valign=\"top\">Derivative of saturation temperature with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.saturationTemperature_sat(sat)</b></td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">Saturation temperature</td></tr>
  <tr><td valign=\"top\">Medium.saturationPressure_sat(sat)</b></td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">Saturation pressure</td></tr>
  <tr><td valign=\"top\">Medium.bubbleEnthalpy(sat)</b></td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">Specific enthalpy at bubble point</td></tr>
  <tr><td valign=\"top\">Medium.dewEnthalpy(sat)</b></td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">Specific enthalpy at dew point</td></tr>
  <tr><td valign=\"top\">Medium.bubbleEntropy(sat)</b></td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">Specific entropy at bubble point</td></tr>
  <tr><td valign=\"top\">Medium.dewEntropy(sat)</b></td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">Specific entropy at dew point</td></tr>
  <tr><td valign=\"top\">Medium.bubbleDensity(sat)</b></td>
      <td valign=\"top\">kg/m3</td>
      <td valign=\"top\">Density at bubble point</td></tr>
  <tr><td valign=\"top\">Medium.dewDensity(sat)</b></td>
      <td valign=\"top\">kg/m3</td>
      <td valign=\"top\">Density at dew point</td></tr>
  <tr><td valign=\"top\">Medium.saturationTemperature_derp_sat(sat)</b></td>
      <td valign=\"top\">K/Pa</td>
      <td valign=\"top\">Derivative of saturation temperature with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.dBubbleDensity_dPressure(sat)</b></td>
      <td valign=\"top\">kg/(m3.Pa)</td>
      <td valign=\"top\">Derivative of density at bubble point with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.dDewDensity_dPressure(sat)</b></td>
      <td valign=\"top\">kg/(m3.Pa)</td>
      <td valign=\"top\">Derivative of density at dew point with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.dBubbleEnthalpy_dPressure(sat)</b></td>
      <td valign=\"top\">J/(kg.Pa)</td>
      <td valign=\"top\">Derivative of specific enthalpy at bubble point with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.dDewEnthalpy_dPressure(sat)</b></td>
      <td valign=\"top\">J/(kg.Pa)</td>
      <td valign=\"top\">Derivative of specific enthalpy at dew point with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.surfaceTension(sat)</b></td>
      <td valign=\"top\">N/m</td>
      <td valign=\"top\">Surface tension between liquid and vapour phase</td></tr>
</table>
</p>
<p>
Sometimes it can be necessary to compute fluid properties in the thermodynamic
plane, just inside or outside the saturation dome. In this case, it is possible
to obtain an instance of a ThermodynamicState state vector, and then use it
to call the additional functions already defined for one-phase media.
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Function call</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">Medium.setBubbleState(sat, phase)</b></td>
      <td valign=\"top\">Obtain the thermodynamic state vector
          corresponding to the bubble point. If phase==1 (default), the state is
      on the one-phase side; if phase==2, the state is on the two-phase
      side </td></tr>
  <tr><td valign=\"top\">Medium.setDewState(sat, phase)</b></td>
      <td valign=\"top\">Obtain the thermodynamic state vector
          corresponding to the dew point. If phase==1 (default), the state is
      on the one-phase side; if phase==2, the state is on the two-phase
      side </td></tr>
  </table>
</p>
<p>
Here are some examples:
</p>
<pre>
   <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
   Medium.SaturationProperties sat;
   Medium.ThermodynamicState   dew_1;    // dew point, one-phase side
   Medium.ThermodynamicState   bubble_2; // bubble point, two phase side
 <b>equation</b>
   // Set sat to saturation properties at pressure p
   sat = setSat_p(p);

   // Compute dew point properties, (default) one-phase side
   dew_1 = setDewState(sat);
   cpDew = Medium.specificHeatCapacityCp(dew_1);
   drho_dp_h_1 = Medium.density_derp_h(dew_1);

   // Compute bubble point properties, two-phase side
   bubble_2    = setBubbleState(sat, 2);
   drho_dp_h_2 = Medium.density_derp_h(bubble_2);
</pre>
</p>
</HTML>
"));
    end TwoPhase;

    class Initialization "Initialization"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<HTML>

<p>
When a medium model is used in a balance volume, differential
equations for the independent medium variables are present and
therefore initial conditions have to be provided.
The following possibilities exist:
</p>

<h4>Steady state initialization</h4>
<p>
Modelica has currently no language element to define
steady state initialization. In the Modelica simulation
environment Dymola, the option
<pre>
   Advanced.DefaultSteadyStateInitialization = <b>true</b>
</pre>
can be set before translation. Then, missing initial
conditions are provided by automamtically setting appropriate
state derivatives to zero.
</p>

<h4>Explicit start values or initial equations</h4>
<p>
Explicit start values can be defined with the \"start\" and
\"fixed\" attributes. The number of independent variables nx
need to be known which can be deduced from the medium
constants (nx = nXi + <b>if</b> singleState <b>then</b> 1 <b>else</b> 2).
Then, start values or initial equations can be defined
for nx variables (= p, T, d, u, h, Xi) from Medium.BaseProperties,
e.g., in the form:
<pre>
     <b>replaceable</b> package Medium = Medium.Interfaces.PartialMedium;
     Medium.BaseProperties medium1 (p(start=1e5, fixed=<b>not</b> Medium.singleState),
                                    T(start=300, fixed=<b>true</b>));
     Medium.BaseProperties medium2;
  <b>initial equation</b>
     <b>if not</b> Medium.singleState <b>then</b>
        medium2.p = 1e5;
     <b>end if</b>;
     medium2.T = 300;
  <b>equation</b>
  </pre>
If initial conditions are not provided for the independent
medium variables, non-linear systems of equations may
occur to compute the initial values of the independent
medium variables from the provided initial conditions.
</p>

<h4>Guess values</h4>
<p>
If non-linear systems of equations occur during initialization,
e.g., in case of steady state initialization, guess values
for the iteration variables of the non-linear system of equations
have to be provided via the \"start\" attribute (and fixed=false).
Unfortunately, it is usually not known in
advance which variables are selected as iteration variables of
a non-linear system of equations. One of the following possibilies
exist:
</p>
<ul>
<li> Do not supply start values and hope that the medium specific
     types have meaningful start values, such as in \"Medium.AbsolutePressure\"
     </li>
<li> Supply start values on all variables of the BaseProperties model,
     i.e., on p, T, d, u, h, Xi.</li>
<li> Determine the iteration variables of the non-linear systems of
     equations and provide start values for these variables.
     In the Modelica simulation environment Dymola, the iteration
     variables can be determined by setting the command
     <pre>
     Advanced.OutputModelicaCode = <b>true</b>
     </pre>
     and by inspection of the file \"dsmodel.mof\" that is generated
     when this option is set (search for \"nonlinear\").</li>
</ul>
</HTML>"));
    end Initialization;

    annotation (__Dymola_DocumentationClass=true, Documentation(info="<HTML>
<p>
Content:
</p>
<ol>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.BasicUsage\">
      Basic usage of medium model</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.BalanceVolume\">
      Medium model for a balance volume</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.ShortPipe\">
      Medium model for a pressure loss</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">
     Optional medium properties</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.Constants\">
     Constants provided by medium model</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">
     Two-phase media</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.Initialization\">
     Initialization</a></li>
</ol>

<p>
A good demonstration how to use the media from Modelica.Media is
given in package Modelica.Media.Examples.Tests. Under
<a href=\"modelica://Modelica.Media.Examples.Tests.Components\">
Tests.Components</a> the most basic components of a Fluid library
are defined. Under Tests.MediaTestModels these basic components are used to test
all media models with some very simple piping networks.
</p>

</HTML>"));
  end MediumUsage;

  package MediumDefinition "Medium definition"
    extends Modelica.Icons.Information;

    class BasicStructure "Basic structure"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<HTML>
<p>
A medium model of Modelica.Media is essentially a <b>package</b>
that contains the following definitions:
</p>
<ul>
<li>
Definition of <b>constants</b>, such as the medium name.</li>
<li>
A <b>model</b> in the package that contains the 3 basic
thermodynamic equations that relate the 5+nXi primary medium variables.</li>
<li><b>Optional functions</b> to compute medium properties that are
only needed in certain circumstances, such as dynamic viscosity. These optional
functions need not be provided by every medium model.</li>
<li>
<b>Type</b> definitions, which are adapted to the particular
medium. For example, a type <b>Temperature</b> is defined where the attributes
<b>min</b>
and <b>max</b> define the validity region of the medium, and a suitable default
start value is given. In a device model, it is advisable to use these type
definitions, e.g., for parameters, in order that medium limits are checked as
early as possible, and that iteration variables of non-linear
systems of equations get reasonable start values.</li>
</ul>
<p>
Note, although we use the term <b>medium model</b>, it
is actually a Modelica <b>package</b> that contains all the constants and
definitions required for a complete <b>medium model</b>. The basic interface to a
medium is defined by Modelica.Media.Interfaces.PartialMedium that has the
following structure:</p>
<pre>
<b>partial package</b> PartialMedium
  <b>import</b> SI = Modelica.SIunits;
  <b>constant</b> String           mediumName = \"\";
  <b>constant</b> String           substanceNames[:] = {mediumName};
  <b>constant</b> String           extraPropertiesNames[:] = fill(\"\",0);
  <b>constant</b> Boolean          singleState = <b>false</b>;
  <b>constant</b> Boolean          reducedX = <b>true</b>;
  <b>constant</b> Boolean          fixedX = <b>false</b>;
  <b>constant</b> AbsolutePressure reference_p = 101325;
  <b>constant</b> MassFraction     reference_X[nX]=fill(1/nX,nX);
  <b>constant</b> AbsolutePressure p_default = 101325;
  <b>constant</b> Temperature      T_default = Modelica.SIunits.Conversions.from_degC(20);
  <b>constant</b> SpecificEnthalpy h_default =
                            specificEnthalpy_pTX(p_default, T_default, X_default);
  <b>constant</b> MassFraction     X_default[nX]=reference_X;
  <b>final constant</b> Integer    nS  = size(substanceNames,1);
  <b>final constant</b> Integer    nX  = nS;
  <b>final constant</b> Integer    nXi = <b>if</b> fixedX <b>then</b> 0
                                  <b>else if</b> reducedX <b>or</b> nS == 1
                                  <b>then</b> nS-1 <b>else</b> nS;
  <b>final constant</b> Integer    nC  = size(extraPropertiesNames,1);
  <b>constant</b> FluidConstants[nS] fluidConstants;

  <b>replaceable record</b> BasePropertiesRecord
    AbsolutePressure p;
    Density d;
    Temperature T;
    SpecificEnthalpy h;
    SpecificInternalEnergy u;
    MassFraction[nX] X;
    MassFraction[nXi] Xi;
    SpecificHeatCapacity R;
    MolarMass MM;
  <b>end</b> BasePropertiesRecord;

  <b>replaceable partial model</b> BaseProperties
    <b>extends</b> BasePropertiesRecord;
    ThermodynamicState state;
    <b>parameter</b> Boolean preferredMediumStates=false;
    SI.Conversions.NonSIunits.Temperature_degC T_degC =
       Modelica.SIunits.Conversions.to_degC(T)
    SI.Conversions.NonSIunits.Pressure_bar p_bar =
       Modelica.SIunits.Conversions.to_bar(p)
  <b>equation</b>
    Xi = X[1:nXi];
    <b>if</b> nX > 1 <b>then</b>
       <b>if</b> fixedX <b>then</b>
          X = reference_X;
       <b>elseif</b> reducedX <b>then</b>
          X[nX] = 1 - sum(Xi);
       <b>end if</b>;
    <b>end if</b>;
    // equations such as
    //    d = d(p,T);
    //    u = u(p,T);
    //    h = u + p/d;
    //    state.p = p;
    //    state.T = T;
    // will go here in actual media implementations, but are not present
    // in the base class since the ThermodynamicState record is still empty
   <b>end</b> BaseProperties

  <b>replaceable record</b> ThermodynamicState
     // there are no \"standard\" thermodynamic variables in the base class
     // but they will be defined here in actual media extending PartialMedium
     // Example:
     //    AbsolutePressure p \"Absolute pressure of medium\";
     //    Temperature      T \"Temperature of medium\";
  <b>end</b> ThermodynamicState;

  // optional medium properties
  <b>replaceable partial function</b> dynamicViscosity
    <b>input</b>  ThermodynamicState state;
    <b>output</b> DynamicViscosity eta;
  <b>end</b> dynamicViscosity;

  // other optional functions

  // medium specific types
  <b>type</b> AbsolutePressure = SI.AbsolutePressure (
                               min     = 0,
                               max     = 1.e8,
                               nominal = 1.e5,
                               start   = 1.e5);
  <b>type</b> DynamicViscosity = ...;
  // other type definitions
<b>end</b> PartialMedium;
</pre>
<p>
We will discuss all parts of this package in the
following paragraphs. An actual medium model should extend from PartialMedium
and has to provide implementations of the various parts.
</p>

<p>
Some of the constants at the beginning of the package do not have a value yet
(this is valid in Modelica), but a value has to be provided when extending from
package PartialMedium. A given value can be modified until the model is
translated or the <b>final</b> prefix is set.
The reason to use constants instead of parameters in the model BaseProperties
is that some of these constants are used in a context where parameters
are not allowed. For example, in connector definitions the
number of independent mass fractions nXi is used as dimension
of a vector Xi. When defining the
connector, only <i>constants</i> in packages can be accessed, but not
<i>parameters</i> in a model, because a connector cannot contain an instance
of BaseProperties.
</p>

<p>The record BasePropertiesRecord contains the variables
primarily used in balance equations. Three equations for these variables have
to be provided by every medium in model BaseProperties, plus two equations
for the gas constant and the molar mass.
</p>

<p>Optional medium properties are defined by functions, such as the function
dynamicViscosity (see code Section above) to compute the dynamic viscosity.
The argument of those functions is the ThermodynamicState record, defined
in BaseProperties, which contains the minimum number of thermodynamic variables
needed as an input to compute all the optional properties.
This construction simplifies the usage
considerably as demonstrated in the following code fragment:
</p>

<pre>
  <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium;
  Medium.BaseProperties   medium;
  Medium.DynamicViscosity eta;
  ...
  U   = m*medium.u; //Internal energy
  eta = Medium.dynamicViscosity(medium.state);
</pre>

<p>Medium is the medium package that satisfies the
requirements of a PartialMedium (when using the model above, a value for
Medium has to be provided by a redeclaration). The medium component is an
instance of the model Medium.BaseProperties and contains the core medium
equations. Variables in this model can be accessed just by dot-notation, such
as medium.u or medium.T. If an optional medium variable has to be computed, the
corresponding function from the actual Medium package is called, such as
Medium.dynamicViscosity. The medium.state vector can be given as input argument
to this function, and its fields are kept consistent to those of BaseProperties
by suitable equations, contained in BaseProperties itself (see above).
</p>

<p>If a medium model does not provide implementations of all
optional functions and one of these functions is called in a model, an error
occurs during translation since the optional functions which have not been
redeclared have the <i>partial</i> attribute. For example, if function
dynamicViscosity is not provided in the medium model when it is used, only
simple pressure drop loss models without a reference to the viscosity can be
used and not the sophisticated ones.
</p>

<p>At the bottom of the PartialMedium package type declarations
are present, that are used in all other parts of the PartialMedium package and
that should be used in all models and connectors where a medium model is
accessed. The reason is that minimum, maximum, nominal, and start
values are defined and these values can be adapted to the particular medium at
hand. For example, the nominal value of AbsolutePressure is 10<sup>5</sup>
Pa. If a simple model of water steam is used that is only valid above 100 &deg;C,
then the minimum value in the Temperature type should be set to this value. The
minimum and maximum values are also important for parameters in order to get an
early message if data outside of the validity region is given. The nominal
attribute is important as a scaling value if the variable is used as a state in
a differential equation or as an iteration variable in a non-linear system of
equations. The start attribute can be very useful to provide a meaningful
default start or guess value if the variable is used, e.g., as iteration
variable in a non-linear system of equations. Note, that all these attributes
can be set specifically for a medium in the following way:
</p>

<p>
<pre>
<b>package</b> MyMedium
  <b>extends</b> Modelica.Media.Interfaces.PartialMedium(
     ...
     Temperature(min=373));
<b>end</b> MyMedium;
</pre>
</p>

<p>
The type PartialMedium.MassFlowRate is defined as
</p>

<p>
<pre>
<b>type</b> MassFlowRate = Modelica.SIunits.MassFlowRate
     (quantity = \"MassFlowRate.\" + mediumName);
</pre>
</p>

<p>Note that the constant mediumName, that has to be
defined in every medium model, is used in the quantity attribute. For example,
if mediumName = SimpleLiquidWater, then the quantity attribute has the value
MassFlowRate.SimpleLiquidWater. This type should be used in a connector
definition of a fluid library:
</p>

<p>
<pre>
<b>connector</b> FluidPort
  <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium;
  <b>flow</b> Medium.MassFlowRate m_flow;
  ...
<b>end</b> FluidPort;
</pre></p>

<p>In the model where this connector is used, the actual
Medium has to be defined. Connectors can only be connected together, if the
corresponding attributes are either not defined or have identical values. Since
mediumName is part of the quantity attribute of MassFlowRate, it is not
possible to connect connectors with different media models together. In Dymola
this is already checked when models are connected together in the diagram layer
of the graphical user interface.</p>
</HTML>
"));
    end BasicStructure;

    class BasicDefinition "Basic definition"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<HTML>
<p>
Let's now walk through the definition of a new medium model. Please refer to
<a href=\"modelica://Modelica.Media.Interfaces.TemplateMedium\">
Modelica.Media.Interfaces.TemplateMedium</a> to obtain a template of the new
medium model code. For the moment being, consider a single-substance medium
model.
<p>
The new medium model is obtained by extending Modelica.Media.Interfaces.PartialMedium, and
setting the following package constants:
<ul>
<li>mediumName is a String containing the name of the medium.
<li>substancesNames is a vector of strings containing the names of the substances
    that make up the medium. In this case, it will contain only mediumName.
<li>singleState can be set to true if u and d in BaseProperties do not depend
    on pressure. In other words, density does not depend on pressure
    (incompressible fluid), and it is assumed that also u does not depend on
    pressure. This setting can be useful for fluids having high density and
    low compressibility (e.g., liquids at moderate pressure); fast states
    resulting from the low compressibility effects are automatically avoided.
<li>reducedX = true for single-substance media, which do not need mass
    fractions at all.
</ul>
It is also possible to change the default min, max, nominal, and start
attributes of Medium-defined types (see TemplateMedium).</p>
<p>
All other package constants, such as nX, nXi, nS, are automatically set
by the declarations of the base package Interfaces.PartialMedium.</p>
<p>
The second step is to provide an implementation to the BaseProperties model,
partially defined in the base class Interfaces.PartialMedium. In the case of
single-substance media, two independent state variables must be selected among
p, T, d, u, h, and three equations must be written to provide the values of
the remaining variables. Two equations must then be added to compute the molar
mass MM and the gas constant R. <p>
<p>
The third step is to consider the optional functions that are going to be
implemented, among the partial functions defined by the base class PartialMedium.
A minimal set of state variables that could be provided as an input to
<i>all</i> those functions must be selected, and included in the redeclaration
of the ThermodynamicState record. Subsequently, equations must be added to
BaseProperties in order that the instance of that record inside BaseProperties
(named \"state\") is kept updated. For example, assume that all additional
properties can be computed as a function of p and T. Then, ThermodynamicState
should be redclared as follows:</p>
<p><pre>
  <b>redeclare replaceable record</b> ThermodynamicState
    AbsolutePressure p \"Absolute pressure of medium\";
    Temperature T \"Temperature of medium\";
  <b>end</b> ThermodynamicState;
</pre></p>
and the following equations should be added to BaseProperties:
<p><pre>
  state.p = p;
  state.T = T;
</pre></p>
The additional functions can now be implemented by redeclaring the functions
defined in the base class and adding their algorithms, e.g.:
</p>
<p><pre>
    <b>redeclare function extends</b> dynamicViscosity \"Return dynamic viscosity\"
    <b>algorithm</b>
      eta := 10 - state.T*0.3 + state.p*0.2;
    <b>end</b> dynamicViscosity;
</pre></p>
</HTML>
"));
    end BasicDefinition;

    class MultipleSubstances "Multiple Substances"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<HTML>
<p>
When writing the model of a multiple-substance medium, a fundamental issue
concerns how to consider the mass fractions of the fluid. If there are nS
substances, there are also nS mass fractions; however, one of them is redundant,
as sum(X) = 1. Therefore there are basically two options, concerning the number
of independent mass fractions nXi:
<ul>
<li> <i>Reduced-state models</i>: reducedX = <b>true</b> and nXi = nS - 1. In this
case, the number of independent mass fractions nXi is the minimum possible.
The full state vector X is provided by equations declared in the base class
Interfaces.PartialMedium.BaseProperties: the first nXi elements are equal to
Xi, and the last one is 1 - sum(Xi).
<li> <i>Full-state models</i>: reducedX = <b>false</b> and nXi = nS. In this case,
Xi = X, i.e., all the elements of the composition vector are considered as
independent variables, and the constraint sum(X) = 1 is never written explicitly.
Although this kind of model is heavier, as it provides one extra state variable,
it can be less prone to numerical and/or symbolic problems, which can be
caused by that constraint.
<li> <i>Fixed-composition models</i>: fixedX = <b>true</b> and nXi = 0. In this case X = reference_X, i.e., all the elements of the composition vector are fixed.
</ul>
<p> The medium implementor can declare the value reducedX as <b>final</b>. In
this way only one implementation must be given. For instance,
Modelica.Media.IdealGases models declare <b>final</b> reducedX = <b>false</b>, so that the
implementation can always assume nXi = nX. The same is true for Air.MoistAir,
which declares <b>final</b> reducedX = <b>true</b>, and always assumes nXi = nX - 1 = 1.</p>
<p>It is also possible to leave reducedX modifiable. In this case, the
BaseProperties model and all additional functions should check for the actual
value of reducedX, and provide the corresponding implementation.</p>

<p>If fixedX is left modifiable, then the implementation should also handle the
case fixedX = true properly.</p>
<p>Fluid connectors should always use composition vectors of size Xi, such as
in the Modelica_Fluid library:</p>
<p><pre>
<b>connector</b> FluidPort
  <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium;
  Medium.AbsolutePressure      p;
  <b>flow</b> Medium.MassFlowRate     m_flow;

  Medium.SpecificEnthalpy      h;
  <b>flow</b> Medium.EnthalpyFlowRate H_flow;

  Medium.MassFraction          Xi    [Medium.nXi];
  <b>flow</b> Medium.MassFlowRate     mX_flow[Medium.nXi];
<b>end</b> FluidPort;
</pre></p>
<p>
For further details, refer to the implementation of
<a href=\"modelica://Modelica.Media.IdealGases.Common.MixtureGasNasa\">
      MixtureGasNasa model</a> and
<a href=\"modelica://Modelica.Media.Air.MoistAir\">
      MoistAir model</a>.
</p>
</HTML>
"));
    end MultipleSubstances;

    class SpecificEnthalpyAsFunction "Specific enthalpy as function"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
If pressure p and specific enthalpy h are <b>not</b> used as
independent medium variables, the specific enthalpy should
be computed by a Modelica function that has as input arguments
only the independent medium variables. It should <b>not</b> be
computed by an equation. For example, if p and T are used
as independent medium variables, a function h_pT(p,T) should
be defined that is called to compute h:
</p>

<pre>
    h = h_pT(p,T);
</pre>

<p>
The reason for this rule requires a longer explanation.
In short, if h is not a computed by a Modelica function and
this function is non-linear in the independent medium variables,
then non-linear systems of equations will occur at
every connection point, if the FluidPort connectors from the
Modelica_Fluid library are used (these are the same as in
Modelica.Media.Examples.Tests.Components.FluidPort).
Only, if the above rule is fulfilled, a tool is able to
remove these non-linear system of equations in most cases.
</p>

<p>
The basic idea of the FluidPort connector is that 2 or more
components can be connected together at a point and that
automatically the mass and energy balance is fulfilled
in the connection point, i.e., the ideal mixing equations
are generated. Note, the momentum balance is only correct for
straight line connections. If \"ideal mixing\" is not sufficient,
a special component to define the mixing equations must be introduced.
</p>

<p>
The mass and momentum balance equations in a component are
derived from the partial differential equations along the
flow direction of a pipe:
</p>

<IMG src=\"modelica://Modelica/Resources/Images/Media/UsersGuide/BalanceEquations1.png\">

<p>
Note, F<sub>F</sub> is the fanning friction factor.
The energy balance can be given in different forms.
Usually, it is given as:
</p>

<IMG src=\"modelica://Modelica/Resources/Images/Media/UsersGuide/EnergyBalance1.png\">

<p>
This form describes the change of the internal energy, kinetic
energy and potential energy of a volume as function of the
in and out flowing fluid. Multiplying the momentum balance
with the flow velocity v and subtracting it from the energy
balance above, results in the following alternative form
of the energy balance:
</p>

<IMG src=\"modelica://Modelica/Resources/Images/Media/UsersGuide/EnergyBalance2.png\">

<p>
This form has the advantage that the kinetic and potential
energy is no longer part of the energy balance and therefore
the energy balance is substantially simpler (e.g., additional non-linear
systems of equations occur in the first form since the velocity
is present in the energy balance; in the second form this is not
the case and it is still valid also for high speeds).
</p>

<p>
Assume now that the second form of the energy balance above
is used in all components and that the following FluidPort connector
is used in all components:
</p>

<pre>
<b>connector</b> FluidPort
  <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium;
  Medium.AbsolutePressure      p;
  <b>flow</b> Medium.MassFlowRate     m_flow;

  Medium.SpecificEnthalpy      h;
  <b>flow</b> Medium.EnthalpyFlowRate H_flow;

  Medium.MassFraction          Xi    [Medium.nXi];
  <b>flow</b> Medium.MassFlowRate     mX_flow[Medium.nXi];
<b>end</b> FluidPort;
</pre>

<p>
As an example, assume that 3 components
are connected together and that the medium is a single substance
fluid. This will result in the following
connection equations:
</p>

<pre>
    p1=p2=p3;
    h1=h2=h3;
    0 = m_flow1 + m_flow2 + m_flow3;
    0 = H_flow1 + H_flow2 + H_flow3;
</pre>

<p>
These are the mass balance and the
energy balance (form 2) of an infinitesimal volume
in the connection point under the assumption that no
mass or energy is stored in this volume. In other words,
the connection equations are the equations that describe
ideal mixing. Under the assumption that the velocity
vectors of the 3 flows are identical (especially, they are
parallel), also the momentum balance is fulfilled:
</p>

<pre>
   0 = m_flow1*v1 + m_flow2*v2 + m_flow3*v3;
     = v*(m_flow1 + m_flow2 + m_flow3);
     = 0;
</pre>

<p>
With the above connector it is therefore possible to
connect components together in a nearly arbitrary fashion,
because every connection fulfills automatically the
balance equations. This approach has, however, one drawback:
If two components are connected together, then the medium
variables on both sides of the connector are identical.
However, due to the connector, only the two equations
</p>

<pre>
   p1 = p2;
   h1 = h2;
</pre>

<p>
are present. Assume, that p,T are the independent medium variables
and that the medium properties are computed at one side of the
connections. This means, the following equations are basically
present:
</p>

<pre>
    h1 = h(p1,T1);
    h2 = h(p2,T2);
    p1 = p2;
    h1 = h2;
</pre>

<p>
These equations can be solved in the following way:
</p>

<pre>
    h1 := h(p1,T1)
    p2 := p1;
    h2 := h1;
    0  := h2 - h(p2,T2);   // non-linear system of equations for T2
</pre>

<p>
This means that T2 is computed by solving a non-linear system
of equations. If h1 and h2 are provided as Modelica functions,
a Modelica translator, such as Dymola, can replace
this non-linear system of equations by the equation:
</p>

<pre>
   T2 := T1;
</pre>

<p>
because after alias substition there are two function calls
</p>

<pre>
    h1 := h(p1,T1);
    h1 := h(p1,T2);
</pre>

<p>
Since the left hand side of the function call and the first
argument are the same, the second arguments T1 and T2 must also be
identical and therefore T2 := T1. This type of analysis seems
to be only possible, if the specific enthalpy is defined as a function
of the independent medium variables.
</p>

</html>"));
    end SpecificEnthalpyAsFunction;

    class StaticStateSelection "Static State Selection"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
Without pre-caution when implementing a medium model,
it is very easy that non-linear algebraic
systems of equations occur when using the medium model.
In this section it is explained how to avoid non-linear
systems of equations that result from unnecessary
dynamic state selections.
</p>
<p>
A medium model should be implemented in such a way that
a tool is able to select states of a medium in a balance volume
statically (during translation). This is only possible if the
medium equations are written in a specific way. Otherwise,
a tool has to dynamically select states during simulation.
Since medium equations are usually non-linear, this means that
non-linear algebraic systems of equations would occur in every
balance volume.
</p>
<p>
It is assumed that medium equations in a balance volume
are defined in the following way:
</p>
<pre>
    <b>package</b> Medium = Modelica.Media.Interfaces.PartialMedium;
    Medium.BaseProperties medium;
  <b>equation</b>
     // mass balance
       <b>der</b>(M)  = port_a.m_flow + port_b.m_flow;
       <b>der</b>(MX) = port_a_mX_flow + port_b_mX_flow;
             M = V*medium.d;
            MX = M*medium.X;

     // Energy balance
     U = M*medium.u;
     <b>der</b>(U) = port_a.H_flow+port_b.H_flow;
</pre>
<p>
<b>Single Substance Media</b>
</p>
<p>
A medium consisting of a single substance
has to define two of \"p,T,d,u,h\" with
stateSelect=StateSelect.prefer if BaseProperties.preferredMediumstates = <b>true</b>
and has to provide the other three variables as function of these
states. This results in:
</p>
<ul>
<li> static state selection (no dynamic choices).</li>
<li> a linear system of equations in the two
     state derivatives.</li>
</ul>
<p>
<b>Example for a single substance medium</b>
</p>
<p>
p, T are preferred states (i.e., StateSelect.prefer is set)
and there are three equations written in the form:
</p>
<pre>
   d = fd(p,T)
   u = fu(p,T)
   h = fh(p,T)
</pre>
<p>
Index reduction leads to the equations:
</p>
<pre>
   <b>der</b>(M) = V*<b>der</b>(d)
   <b>der</b>(U) = <b>der</b>(M)*u + M*<b>der</b>(u)
   <b>der</b>(d) = <b>der</b>(fd,p)*<b>der</b>(p) + <b>der</b>(fd,T)*<b>der</b>(T)
   <b>der</b>(u) = <b>der</b>(fu,p)*<b>der</b>(p) + <b>der</b>(fu,T)*<b>der</b>(T)
</pre>
<p>
Note, that <b>der</b>(y,x) is the partial derivative of y with respect to x
and that this operator will be introduced in a future version
of the Modelica language.
The above equations imply, that if p,T are provided from the
integrator as states, all functions, such as fd(p,T)
or <b>der</b>(fd,p) can be evaluated as function of the states.
The overall system results in a linear system
of equations in <b>der</b>(p) and <b>der</b>(T) after eliminating
<b>der</b>(M), <b>der</b>(U), <b>der</b>(d), <b>der</b>(u) via tearing.
</p>
<p>
<b>Counter Example for a single substance medium</b>
</p>
<p>
An ideal gas with one substance is written in the form
</p>
<pre>
  <b>redeclare model extends</b> BaseProperties(
     T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
     p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default)
  <b>equation</b>
     h = h(T);
     u = h - R*T;
     p = d*R*T;
      ...
  <b>end</b> BaseProperties;
</pre>
<p>
If p, T are preferred states, these equations are <b>not</b>
written in the recommended form, because d is not a
function of p and T. If p,T would be states, it would be
necessary to solve for the density:
</p>
<pre>
   d = p/(R*T)
</pre>
<p>
If T or R are zero, this results in a division by zero.
A tool does not know that R or T cannot become zero.
Therefore, a tool must assume that p, T <b>cannot</b> always be
selected as states and has to either use another static
state selection or use dynamic state selection. The only
other choice for static state selection is d,T, because
h,u,p are given as functions of d,T.
However, as potential states only variables appearing differentiated and variables
declared with StateSelect.prefer or StateSelect.always
are used. Since \"d\" does not appear differentiated and has
StateSelect.default, it cannot be selected as a state.
As a result, the tool has to select states dynamically
during simulation. Since the equations above are non-linear
and they are utilized in the dynamic state
selection, a non-linear system of equations is present
in every balance volume.
</p>
<p>
To summarize, for single substance ideal gas media there
are the following two possibilities to get static
state selection and linear systems of equations:
</p>
<ol>
<li> Use p,T as preferred states and write the equation
     for d in the form: d = p/(T*R)</li>
<li> Use d,T as preferred states and write the equation
     for p in the form: p = d*T*R</li>
</ol>
<p>
All other settings (other/no preferred states etc.) lead
to dynamic state selection and non-linear systems of
equations for a balance volume.
</p>
<p>
<b>Multiple Substance Media</b>
</p>
<p>
A medium consisting of multiple substance
has to define two of \"p,T,d,u,h\" as well
as the mass fractions Xi with
stateSelect=StateSelect.prefer (if BaseProperties.preferredMediumStates = <b>true</b>)
and has to provide
the other three variables as functions of these
states. Only then, static selection is possible
for a tool.
</p>
<p>
<b>Example for a multiple substance medium:</b></p>
</p>
<p>
p, T and Xi are defined as preferred states and
the equations are written in the form:
</p>
<pre>
   d = fp(p,T,Xi);
   u = fu(p,T,Xi);
   h = fh(p,T,Xi);
</pre>
<p>
Since the balance equations are written in the form:
</p>
<pre>
              M = V*medium.d;
            MXi = M*medium.Xi;
</pre>
<p>
The variables M and MXi appearing differentiated in the
balance equations are provided as functions of d and Xi
and since d is given as a function of p, T and Xi, it
is possible to compute M and MXi directly from the desired
states. This means that static state selection is possible.
</p>

</html>"));
    end StaticStateSelection;

    class TestOfMedium "Test of medium"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
After implementation of a new medium model, it should
be tested. A basic test is already provided with model
Modelica.Media.Examples.Tests.Components.PartialTestModel
which might be used in the following way:
</p>

<pre>
  <b>model</b> TestOfMyMedium
     <b>extends</b> Modelica.Media.Examples.Tests.Components.PartialTestModel(
              <b>redeclare package</b> Medium = MyMedium);
  <b>end</b> TestOfMyMedium;
</pre>

<p>
It might be necessary to adapt or change initial values
depending on the validity range of the medium.
The model above should translate and simulate.
If the medium model is written according to the
suggestions given in the previous sections (and the Modelica
translator has appropriate algorithms implemented),
there should be only static state selection everywhere
and no non-linear system of equations, provided h is an independent
medium variable or is only a function of T. If h is a function
of, say h=h(p,T), one non-linear system of equations occurs that
cannot be avoided.
</p>

<p>
The test model above can be used to test the most basic
properties. Of course, more tests should be performed.
</p>

</html>"));
    end TestOfMedium;
    annotation (__Dymola_DocumentationClass=true, Documentation(info="<HTML>
<p>
If a new medium model shall be introduced, copy package
<a href=\"modelica://Modelica.Media.Interfaces.TemplateMedium\">
Modelica.Media.Interfaces.TemplateMedium</a> to the desired
location, remove the
\"partial\" keyword from the package and provide
the information that is requested in the comments of the
Modelica source.
A more detailed description for the different parts of the
TemplateMedium package is given here:
</p>
<ol>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.BasicStructure\">
      Basic structure of medium interface</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.BasicDefinition\">
      Basic definition of medium model</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.MultipleSubstances\">
      Multiple Substances</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.SpecificEnthalpyAsFunction\">
      Specific enthalpy as function</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.StaticStateSelection\">
      Static State Selection</a></li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.TestOfMedium\">
      Test of medium model</a></li>
</ol>
</HTML>"));
  end MediumDefinition;

  class ReleaseNotes "Release notes"
    extends Modelica.Icons.ReleaseNotes;
    annotation (Documentation(info="<HTML>
<h4>Version included in Modelica 3.0</h4>
<p> See top-level release notes for MSL.</p>
<h4>Version 1.0, 2005-03-01</h4>
<p>
Many improvements in the library, e.g., providing mixtures
of the ideal gases, table based media, test suite for all media, improved and
updated User's Guide.
</p>
<h4><font color=\"#008000\">Version 0.9, 2004-10-18</font></h4>
<ul>
<li> Changed the redeclaration/extends within packages from the
     experimental feature to the language keywords introduced
     in Modelica 2.1.</li>
<li> Re-introduced package \"Water.SaltWater\" in order to test
     substance mixtures (this medium model does not describe
     real mixing of water and salt). </li>
<li> Started to improve the documentation in
     Modelica.Media.UsersGuide.MediumDefinition.BasicStructure</li>
</ul>
<h4><font color=\"#008000\">Version 0.792, 2003-10-28</font></h4>
<p>
This is the first version made available for the public
for the Modelica'2003 conference (for evaluation).
</p>
</HTML>
"));
  end ReleaseNotes;

  class Future "Future"
    extends Modelica.Icons.Information;
    annotation (Documentation(info="<html>

<h4>Planned changes for version 3.1</h4>

<p>Several changes are planned for version 3.1 of Modelica.Media. In order to have an easy transition, the current verison is moved
  to the ObsoleteModelica-package and current users can continue to use ot for many years. The goal for the new version is to cover many more fluids, be easier to use for users and less for implementors that want to include their own models. A beta-version of the new media libray will be available in the first quarter of 2009.</p>

<p>The main user-visible changes are:</p>
<ul>
<li>No distinction between pure fluids and mixtures on the interface level: pure fluids are mixtures with 1 component</li>
<li>Compressibility will in the future be a flag that can be set for those media where it makes sense. It will thus be possible to treat an ideal gas as incompressible, which is adequate for certain applications, and also use the same medium model for thermal-only applications, and thermal-hydraulic ones.</li>
<li>All functions will have derivatives to enable analytic Jacobians.</li>
<li>Mole-fraction based media for process applications</li>
</ul>
<p>For further information on the upcoming version, please contact the <a href=\"modelica://Modelica.Media.UsersGuide.Contact\">Author</a></p>

<h4>Forward compatibility</h4>
<p> In order to simplify transition to the upcoming version of
Modelica.Media for Modelica 3.1, a new enumeration has been
introduced:  <a href=\"modelica://Modelica.Media.Interfaces.PartialMedium.Choices.IndependentVariables\">IndependentVariables</a> with the
entries ph, pT, pTX, phX and dTX. Users are advised to use this enumeration to determine the independent variables of a medium. If they are going to use the function based interface of the current Modelica.Media (and not use the BaseProperties from Modelica.Media), they should not have any trouble using the next version without any need for changes in their code.</p>

</html>"));
  end Future;

class Contact "Contact"
  extends Modelica.Icons.Contact;
    annotation (Documentation(info="<html>
<dl>
<dt><b>Main author and maintainer:</b>
<dd>Hubertus Tummescheit<br>
    Modelon AB<br>
    Ideon Science Park<br>
    SE-22730 Lund, Sweden<br>
    email: <A HREF=\"mailto:Hubertus.Tummescheit@Modelon.se\">Hubertus.Tummescheit@Modelon.se</A><br>
</dl>
<p><b>Acknowledgements:</b></p>
<p>
The development of this library has been a collaborative effort
and many have contributed:
</p>
<ul>
<li> The essential parts of the media models have been implemented
     in the ThermoFluid library by Hubertus Tummescheit with
     help from Jonas Eborn and Falko Jens Wagner. These media models
     have been converted to the Modelica.Media interface definition
     and have been improved by Hubertus Tummescheit. </li>
<li> The effort for the development of the Modelica.Media library has been
     organized by Martin Otter who also contributed to the design,
     implemented part of the generic models, contributed to the User's Guide
     and provided the generic test suite Modelica.Media.Examples.Tests.</li>
<li> The basic idea for the medium model interface based on packages
     is from Michael Tiller who also contributed to the design.</li>
<li> The first design of the medium model interface is from
     Hilding Elmqvist. The design and the implementation has been further
     improved at the Modelica design meetings in<br>
     Dearborn, Nov. 20-22, 2002<br>
     Dearborn, Sept. 2-4, 2003<br>
     Lund Jan. 28-30, 2004<br>
     Munich, May 26-28, 2004<br>
     Lund, Aug. 30-31, 2004<br>
     Dearborn, Nov. 15-17, 2004<br>
     Cremona Jan. 31 - Feb. 2, 2005.</li>
<li> Hans Olsson, Sven Erik Mattsson and Hilding Elmqvist developed
     symbolic transformation algorithms and implemented them in Dymola
     to improve the efficiency considerably (e.g., to avoid non-linear
        systems of equations).</li>
<li>Katrin Pr&ouml;&szlig; implemented the moist air model</li>
<li> R&uuml;diger Franke performed the first realistic tests of the Modelica.Media
        and Modelica_Fluid libraries and gave valuable feedback.</li>
<li> Francesco Casella has been the most relentless bug-hunter and tester of the
     water and ideal gas properties. He also contributed to the User's Guide.</li>
<li> John Batteh, Daniel Bouskela, Jonas Eborn, Andreas Idebrant, Charles Newman,
     Gerhart Schmitz, and the users of the ThermoFluid library provided
     many useful comments and feedback.</li>
</ul>
</html>"));
end Contact;

  annotation (__Dymola_DocumentationClass=true, Documentation(info="<HTML>
<p>
Library <b>Modelica.Media</b> is a <b>free</b> Modelica package providing
a standardized interface to fluid media models and specific
media models based on this interface.
A fluid medium model defines <b>algebraic</b> equations
for the intensive thermodynamic variables used in the <b>mass</b>
and <b>energy</b> balance of component models. Optionally, additional
medium properties can be computed such as dynamic viscosity or thermal
conductivity. Medium models are defined for <b>single</b> and
<b>multiple substance</b> fluids with <b>one</b> and
<b>multiple phases</b>.
</p>
<p>
A large part of the library provides specific medium models
that can be directly utilized. This library can be used in
all types of Modelica fluid libraries that may have different connectors
and design philosophies. It is particularily utilized
in the Modelica_Fluid library (the Modelica_Fluid library is currently
under development to provide 1D thermo-fluid flow components for
single and multiple substance flow with one and multiple phases).
The Modelica.Media library has the following
main features:
</p>
<ul>
<li> Balance equations and media model equations
     are decoupled.
     This means that the used medium model does usually not have an
     influence on how the balance equations are formulated.
     For example, the same balance equations are used for media
     that use pressure and temperature, or pressure and specific
     enthalpy as independent variables, as well as for
     incompressible and compressible media models.
     A Modelica tool will have enough information to
     generate as efficient code as a traditional
     (coupled) definition. This feature is described in more
     detail in section
     <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.StaticStateSelection\">Static State Selection</a>.</li>
<li> Optional variables, such as dynamic viscosity, are only computed if
     needed in the corresponding component.</li>
<li> The independent variables of a medium model do not
     influence the definition of a fluid connector port.
     Especially, the media models are implemented in such a way
     that a connector may have the minimum number of independent
     medium variables in a connector and still get the same
     efficiency as if all medium variables are passed by the
     connector from one component to the next one (the latter
     approach has the restriction that a fluid port can only
     connect two components and not more). Note, the Modelica_Fluid
     library uses the first approach, i.e., having a set of
     independent medium variables in a connector.</li>
<li> The medium models are implemented with regards to
     efficient dynamic simulation. For example, two phase
     medium models trigger state events at phase boundaries
     (because the medium variables are not differentiable
     at this point).</li>
</ul>
<p>
This User's Guide has the following main parts:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage\">Medium usage</a>
     describes how to use a medium model from
     this library in a component model.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition\">Medium definition</a>
     describes how a new fluid medium
     model has to be implemented.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.ReleaseNotes\">ReleaseNotes</a>
     summarizes the changes of the library releases.</li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.Future\">Future</a>
    provides information about the upcoming version 3.1 of Modelica.Media and
    some changes to this version to enable forward compatibility.</li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.Contact\">Contact</a>
    provides information about the authors of the library as well as
    acknowledgements.</li>
</ul>
</HTML>"));
end UsersGuide;

package Examples
  "Demonstrate usage of property models (currently: simple tests)"

  extends Modelica.Icons.ExamplesPackage;

  model SimpleLiquidWater "Example for Water.SimpleLiquidWater medium model"

    import SI = Modelica.SIunits;
    extends Modelica.Icons.Example;
    parameter SI.Volume V=1 "Volume";
    parameter SI.EnthalpyFlowRate H_flow_ext=1.e6
      "Constant enthalpy flow rate into the volume";

    package Medium = Water.ConstantPropertyLiquidWater (SpecificEnthalpy(max=1e6))
      "Medium model";
    Medium.BaseProperties medium(
      T(start=300,fixed=true));

    Medium.BaseProperties medium2;
    Medium.ThermodynamicState state;
    Real m_flow_ext2;
    Real der_p;
    Real der_T;

    SI.Mass m(start = 1.0);
    SI.InternalEnergy U;

    // Use type declarations from the Medium
    Medium.MassFlowRate m_flow_ext;
    Medium.DynamicViscosity eta=Medium.dynamicViscosity(medium);
    Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium);
  equation
    medium.p = 1.0e5;
    m = medium.d*V;
    U = m*medium.u;

    // Mass balance
    der(m) = m_flow_ext;

    // Energy balance
    der(U) = H_flow_ext;

    // Smooth state
    medium2.p = 1e5*time/10;
    medium2.T = 330;
    m_flow_ext2 = time - 30;
    state = Medium.setSmoothState(m_flow_ext2, medium.state, medium2.state, 10);
    der_p = der(state.p);
    der_T = der(state.T);
    annotation (experiment(StopTime=100), Documentation(info="<html>

</html>"));
  end SimpleLiquidWater;

  model IdealGasH2O "IdealGas H20 medium model"
    extends Modelica.Icons.Example;
    package Medium = IdealGases.SingleGases.H2O "Medium model";
    Medium.ThermodynamicState state "thermodynamic state record";
    Medium.ThermodynamicState state2;
    Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(state);
    Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(state);
    Medium.IsentropicExponent k=Medium.isentropicExponent(state);
    Medium.SpecificEntropy s=Medium.specificEntropy(state);
    //  Medium.SpecificEntropy s2=Medium.specificEntropy(state2);
    Medium.VelocityOfSound a=Medium.velocityOfSound(state);
    Real beta = Medium.isobaricExpansionCoefficient(state);
    Real gamma = Medium.isothermalCompressibility(state);
    Medium.SpecificEnthalpy h_is = Medium.isentropicEnthalpyApproximation(2.0, state);

    Medium.ThermodynamicState smoothState;
    Real m_flow_ext;
    Real der_p;
    Real der_T;

  equation
    state.p = 100000.0;
    state.T = 200 + 1000*time;
    state2.p = 2.0e5;
    state2.T = 500.0;
    //  s2 = s;

    // Smooth state
    m_flow_ext = time - 0.5;
    smoothState = Medium.setSmoothState(m_flow_ext, state, state2, 0.1);
    der_p = der(smoothState.p);
    der_T = der(smoothState.T);

    annotation (Documentation(info="<html>
<p>An example for using ideal gas properties and how to compute
  isentropic enthalpy changes.
  The function that is implemented is approximate, but usually
   very good: the second medium record medium2
   is given to compare the approximation.
</p>
</html>"),
      experiment(StopTime=1));
  end IdealGasH2O;

  model WaterIF97 "WaterIF97 medium model"
    extends Modelica.Icons.Example;
    package Medium = Water.StandardWater "Medium model";
    Medium.BaseProperties medium(
      p(start=1.e5, stateSelect=StateSelect.prefer),
      h(start=1.0e5, stateSelect=StateSelect.prefer),
      T(start = 275.0),
      d(start = 999.0));
    Modelica.SIunits.Volume V(start = 0.1);
    parameter Modelica.SIunits.VolumeFlowRate dV = 0.0
      "Fixed time derivative of volume";
    parameter Medium.MassFlowRate m_flow_ext=0
      "Fixed mass flow rate into volume";
    parameter Medium.EnthalpyFlowRate H_flow_ext=10000
      "Fixed enthalpy flow rate into volume";
    Modelica.SIunits.Mass m "Mass of volume";
    Modelica.SIunits.InternalEnergy U "Internal energy of volume";

    Medium.ThermodynamicState state2;
    Medium.ThermodynamicState state;
    Real m_flow_ext2;
    Real der_p;
    Real der_T;

  equation
    der(V) = dV;
    m = medium.d*V;
    U = m*medium.u;

    // Mass balance
    der(m) = m_flow_ext;

    // Energy balance
    der(U) = H_flow_ext;

    // smooth states
    m_flow_ext2 = time - 0.5;
    state2 = Medium.setState_pT(1e5*(1+time), 300+200*time);
    state = Medium.setSmoothState(m_flow_ext2, medium.state, state2, 0.05);
    der_p = der(state.p);
    der_T = der(state.T);
    annotation (Documentation(info="<html>

</html>"),
      experiment(StopTime=1));
  end WaterIF97;

  model MixtureGases "Test gas mixtures"
    extends Modelica.Icons.Example;

    parameter Modelica.SIunits.Volume V=1 "Fixed size of volume 1 and volume 2";
    parameter Modelica.SIunits.MassFlowRate m_flow_ext=0.01
      "Fixed mass flow rate in to volume 1 and in to volume 2";
    parameter Modelica.SIunits.EnthalpyFlowRate H_flow_ext=5000
      "Fixed enthalpy flow rate in to volume and in to volume 2";

    package Medium1 = Modelica.Media.IdealGases.MixtureGases.CombustionAir
      "Medium model";
    Medium1.BaseProperties medium1(p(start=1.e5, stateSelect=StateSelect.prefer),
       T(start=300, stateSelect=StateSelect.prefer),
       X(start={0.8,0.2}));
    Real m1(quantity=Medium1.mediumName, start = 1.0);
    SI.InternalEnergy U1;
    Medium1.SpecificHeatCapacity cp1=Medium1.specificHeatCapacityCp(medium1.state);
    Medium1.DynamicViscosity eta1= Medium1.dynamicViscosity(medium1.state);
    Medium1.ThermalConductivity lambda1= Medium1.thermalConductivity(medium1.state);

    package Medium2 = Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas
      "Medium model";
    Medium2.BaseProperties medium2(p(start=1.e5, stateSelect=StateSelect.prefer),
       T(start=300, stateSelect=StateSelect.prefer),
       X(start={0.1,0.1,0.1,0.2,0.2,0.3}));
    Real m2(quantity=Medium2.mediumName, start = 1.0);
    SI.InternalEnergy U2;
    Medium2.SpecificHeatCapacity cp2=Medium2.specificHeatCapacityCp(medium2.state);
    Medium2.DynamicViscosity eta2= Medium2.dynamicViscosity(medium2.state);
    Medium2.ThermalConductivity lambda2= Medium2.thermalConductivity(medium2.state);

    Medium2.ThermodynamicState state2 = Medium2.setState_pTX(1.005e5, 302, {0.3,0.2,0.2,0.1,0.1,0.1});
    Medium2.ThermodynamicState smoothState;
    Real m_flow_ext2;
    Real der_p;
    Real der_T;

  equation
    medium1.X = {0.8,0.2};
    m1 = medium1.d*V;
    U1 = m1*medium1.u;
    der(m1) = m_flow_ext;
    der(U1) = H_flow_ext;

    medium2.X ={0.1,0.1,0.1,0.2,0.2,0.3};
    m2 = medium2.d*V;
    U2 = m2*medium2.u;
    der(m2) = m_flow_ext;
    der(U2) = H_flow_ext;

    // Smooth state
    m_flow_ext2 = time - 0.5;
    smoothState = Medium2.setSmoothState(m_flow_ext2, medium2.state, state2, 0.2);
    der_p = der(smoothState.p);
    der_T = der(smoothState.T);
    annotation (Documentation(info="<html>

</html>"),
      experiment(StopTime=1));
  end MixtureGases;

model MoistAir "Ideal gas flue gas  model"
    extends Modelica.Icons.Example;
    package Medium = Air.MoistAir "Medium model";
    Medium.BaseProperties medium(
       T(start = 274.0),
       X(start = {0.95,0.05}),
       p(start = 1.0e5));
  //  Medium.SpecificEntropy s=Medium.specificEntropy(medium);
  //  Medium.SpecificEnthalpy h_is = Medium.isentropicEnthalpyApproximation(medium, 2.0e5);
    parameter Medium.MolarMass[2] MMx = {Medium.dryair.MM,Medium.steam.MM}
      "Vector of molar masses (consisting of dry air and of steam)";
    Medium.MolarMass MM = 1/((1-medium.X[1])/MMx[1]+medium.X[1]/MMx[2])
      "Molar mass of gas part of mixture";
  //  Real[4] dddX=Medium.density_derX(medium,MM);

  Medium.ThermodynamicState state1;
  Medium.ThermodynamicState state2;
  Medium.ThermodynamicState smoothState;
  Real m_flow_ext;
  Real der_p;
  Real der_T;
equation
    der(medium.p) = 0.0;
    der(medium.T) = 90;
    medium.X[Medium.Air] = 0.95;
    //    medium.X[Medium.Water] = 0.05;
    // one simple assumption only for quick testing:
  //  medium.X_liquidWater = if medium.X_sat < medium.X[2] then medium.X[2] - medium.X_sat else 0.0;

   // Smooth state
   m_flow_ext = time - 0.5;
   state1.p = 1.e5*(1+time);
   state1.T = 300 + 10*time;
   state1.X = {time, 1-time};
   state2.p = 1.e5*(1+time/2);
   state2.T = 340 - 20*time;
   state2.X = {0.5*time, 1-0.5*time};
   smoothState = Medium.setSmoothState(m_flow_ext, state1, state2, 0.2);
   der_p = der(smoothState.p);
   der_T = der(smoothState.T);
    annotation (Documentation(info="<html>
<p>An example for using ideal gas properties and how to compute isentropic enthalpy changes.
The function that is implemented is approximate, but usually very good: the second medium record medium2
is given to compare the approximation.
</p>
</html>"),
      experiment(Tolerance=1e-005));
end MoistAir;

  package TwoPhaseWater "extension of the StandardWater package"
    extends Modelica.Media.Water.StandardWater;
    redeclare model extends BaseProperties
      "Make StandardWater.BaseProperties non replaceable in order that inheritance is possible in model ExtendedProperties"
    end BaseProperties;

    model ExtendedProperties "plenty of two-phase properties"
      extends BaseProperties;
      ThermodynamicState dew "dew line Properties";
      ThermodynamicState bubble "bubble line Properties";
      ThermodynamicState bubble2 "bubble line Properties, on the 2-phase side";
      DynamicViscosity eta "viscosity (McAdams mixture rules if in 2-phase)";
      DynamicViscosity eta_d "dew line viscosity";
      DynamicViscosity eta_b "bubble line viscosity";
      ThermalConductivity lambda_d "dew line thermal conductivity";
      ThermalConductivity lambda_b "bubble line thermal conductivity";
      SpecificHeatCapacity cp_d "dew line Specific heat capacity";
      SpecificHeatCapacity cp_b "bubble line Specific heat capacity";
      Real ddhp;
      Real ddhp_d;
      Real ddhp_b "derivatives";
      Real ddph;
      Real ddph_d;
      Real ddph_b "derivatives";
      Real ddhp_b2;
      Real ddph_b2 "derivatives";
      // no derivatives yet, ... sat should be temporary
      MassFraction x "steam mass fraction";
      Real dTp;
      Real dTp2;
      SpecificEntropy s_b;
      SpecificEntropy s_d;
    equation
      eta = if phase == 1 then dynamicViscosity(state) else 1/(x/eta_d + (1 - x)
        /eta_b);
      dew =  setDewState(sat);
      bubble =  setBubbleState(sat);
      bubble2 =  setBubbleState(sat,2);
      x = (h - bubble.h)/max(dew.h - bubble.h,1e-6);
      eta_d = dynamicViscosity(dew);
      eta_b = dynamicViscosity(bubble);
      lambda_d = thermalConductivity(dew);
      lambda_b = thermalConductivity(bubble);
      cp_d = specificHeatCapacityCp(dew);
      cp_b = specificHeatCapacityCp(bubble);
      s_d = specificEntropy(dew);
      s_b = specificEntropy(bubble);
      ddph = density_derp_h(state);
      ddph_d = density_derp_h(dew);
      ddph_b = density_derp_h(bubble);
      ddhp = density_derh_p(state);
      ddhp_d = density_derh_p(dew);
      ddhp_b = density_derh_p(bubble);
      ddhp_b2 = density_derh_p(bubble2);
      ddph_b2 = density_derp_h(bubble2);
      dTp = saturationTemperature_derp(p);
      dTp2 = (1/dew.d - 1/bubble.d)/max(s_d - s_b,1e-6);
      annotation (Documentation(info=""));
    end ExtendedProperties;

    model TestTwoPhaseStates "Test the above model"
      extends Modelica.Icons.Example;
      ExtendedProperties medium(p(start = 700.0),
       h(start = 8.0e5));
      parameter Real dh = 80000.0 "80 kJ/second";
      parameter Real dp = 1.0e6 "10 bars per second";
    equation
      der(medium.p) = dp;
      der(medium.h) = dh;
      annotation (experiment(StopTime=22, NumberOfIntervals=2500),
        Documentation(info="<html>
<p> For details see the documentation of the example package TwoPhaseWater</p>
</html>
"));
    end TestTwoPhaseStates;
    annotation (Documentation(info="<html>
<h4>Example: TwoPhaseWater</h4>
The TwoPhaseWater package demonstrates how to extend the parsimonius
BaseProperties with a minimal set of properties from the standard water
package with most properties that are needed in two-phase situations.
The model also demonstrates how to compute additional&nbsp; properties
for the medium model. In this scenario, that builds a new medium model
with many more properties than the default, the standard BaseProperties
is used as a basis. For additional properties, a user has to:<br>
<ol>
<li>Declare a new variable of the wanted type, e.g., <span
style=\"color: rgb(0, 0, 153);\">\"<span style=\"color: rgb(51, 51, 255);\">DynamicViscosity
eta</span>\"</span>.</li>
<li>Compute that variable by calling the function form the package,
e.g., <span style=\"color: rgb(51, 51, 255);\">eta =
dynamicViscosity(state)</span>. Note that the instance of
ThermodynamicState is used as an input to the function. This instance
\"state\" is declared in PartialMedium and thus available in every medium
model. A user does not have to know what actual variables are required
to compute the dynamic viscosity, because the state instance is
guaranteed to contain what is needed.&nbsp;<span
style=\"color: rgb(255, 0, 0);\"></span></li>
<li><span style=\"color: rgb(255, 0, 0);\">Attention</span>: Many
properties are not well defined in the two phase region and the
functions might return undesired values if called there. It is the
user's responsibility&nbsp; to take care of such ituations. The example
uses one of several possible models to compute an averaged viscosity
for two-phase flows. </li>
</ol>
In two phase models, properties are often needed on the phase boundary
just outside the two phase dome, right on the border.. To compute the
thermodynamic state there, two auxiliary functions are provided: <b>setDewState(sat)</b> and <b>setBubbleState(sat)</b>. They take an
instance of SaturationProperties as input. By default they are in
one-phase, but with the optional phase argument set to 2, the output is
forced to be just inside the phase boundary. This is only needed when
derivatives like cv are computed with are different on both sides of
the boundaries. The ususal steps to compute properties on the phase
boundary are: <br>
<ol>
<li>Declare an instance of ThermodynamicState, e.g., \"ThermodynamicState&nbsp; dew\".</li>
<li>Compute the state, using an instance of SaturationProperties,
e.g., dew = setDewState(sat)</li>
<li>Compute properties on the phase boundary to your full desire,
e.g., \"cp_d = specificHeatCapacityCp(dew)\". <br>
</li>
</ol>
<p>The sample model TestTwoPhaseStates test the extended properties</p>

<p>
The same procedure can be used to compute properties at other state
points, e.g., when an isentropic reference state is computed.
</p>
</html>
"));
  end TwoPhaseWater;

  package TestOnly "examples for testing purposes: move for final version "
    extends Modelica.Icons.ExamplesPackage;
    model MixIdealGasAir "Ideal gas air medium model"
      extends Modelica.Icons.Example;
      package Medium = IdealGases.MixtureGases.CombustionAir "Medium model";
      Medium.BaseProperties medium(
         T(start = 200.0),
         X(start = {0.2,0.8}),
         p(start = 1.0e5));
      Medium.BaseProperties medium2(
         T(start = 300.0),
         X(start = {0.2,0.8}),
         p(start = 2.0e5));
      Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(medium.state);
      Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium.state);
      Medium.IsentropicExponent gamma=Medium.isentropicExponent(medium.state);
      Medium.SpecificEntropy s=Medium.specificEntropy(medium.state);
      Medium.SpecificEntropy s2=Medium.specificEntropy(medium2.state);
      Medium.VelocityOfSound a=Medium.velocityOfSound(medium.state);
      Medium.DynamicViscosity eta= Medium.dynamicViscosity(medium.state);
      Medium.ThermalConductivity lambda= Medium.thermalConductivity(medium.state);
      Real beta = Medium.isobaricExpansionCoefficient(medium.state);
      Real gamma2 = Medium.isothermalCompressibility(medium2.state);
      Medium.SpecificEnthalpy h_is = Medium.isentropicEnthalpyApproximation(2.0e5, medium);
    equation
      der(medium.p) = 1000.0;
      der(medium.T) = 1000;
      medium.X = {0.2,0.8};
      der(medium2.p) = 1.0e3;
      der(medium2.T) = 0.0;
      der(medium2.X) = {0.0,0.0};
    //  s2 = s;
      annotation (Documentation(info="<html>
<p>An example for using ideal gas properties and how to compute isentropic enthalpy changes.
The function that is implemented is approximate, but usually very good: the second medium record medium2
is given to compare the approximation.
</p>
</html>"),
        experiment(StopTime=1));
    end MixIdealGasAir;

    model FlueGas "Ideal gas flue gas  model"
      extends Modelica.Icons.Example;
      package Medium = IdealGases.MixtureGases.FlueGasLambdaOnePlus
        "Medium model";
      Medium.ThermodynamicState state(
         T(start = 200.0),
         X(start = {0.2,0.3,0.4,0.1}),
         p(start = 1.0e5));
      Medium.BaseProperties medium2(
         T(start = 300.0),
         X(start = {0.2,0.1,0.3,0.4}),
         p(start = 2.0e5));
      Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(state);
      Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(state);
      Medium.IsentropicExponent gamma=Medium.isentropicExponent(state);
      Medium.SpecificEntropy s=Medium.specificEntropy(state);
      Medium.SpecificEntropy s2=Medium.specificEntropy(medium2.state);
      Medium.VelocityOfSound a=Medium.velocityOfSound(state);
      Real beta = Medium.isobaricExpansionCoefficient(state);
      Real gamma2 = Medium.isothermalCompressibility(medium2.state);
      Medium.SpecificEnthalpy h_is = Medium.isentropicEnthalpyApproximation(2.0e5, medium2);
      parameter Medium.MolarMass[4] MMx = Medium.data.MM
        "Molar masses of flue gas";
      Medium.MolarMass MM =  1/sum(state.X[j]/MMx[j] for j in 1:4) "molar mass";
      Real[4] dddX=Medium.density_derX(medium2.state);
    equation
      der(state.p) = 1000.0;
      der(state.T) = 1000;
      state.X = {0.2,0.2,0.4,0.2};
      der(medium2.p) = 1.0e3;
      der(medium2.T) = 0.0;
      der(medium2.X[1:Medium.nX]) = {0.0,0.0,0.0,0.0};
      annotation (Documentation(info="<html>
<p>An example for using ideal gas properties and how to compute isentropic enthalpy changes.
The function that is implemented is approximate, but usually very good: the second medium record medium2
is given to compare the approximation.
</p>
</html>"),
        experiment(StopTime=1));
    end FlueGas;

  package N2AsMix "air and steam mixture (no condensation!, pseudo-mixture)"
    extends IdealGases.Common.MixtureGasNasa(
       mediumName="Nitrogen",
       data={IdealGases.Common.SingleGasesData.N2},
      fluidConstants={IdealGases.Common.FluidData.N2},
       substanceNames = {"Nitrogen"},
       reference_X={1.0});
    annotation (Documentation(info="<html>

</html>"));
  end N2AsMix;

    model IdealGasN2 "Test IdealGas.SingleMedia.N2 medium model"
      extends Modelica.Icons.Example;

      parameter Modelica.SIunits.Volume V=1 "Size of fixed volume";
      parameter Medium.MassFlowRate m_flow_ext=0.01
        "Mass flow rate into volume";
      parameter Medium.EnthalpyFlowRate H_flow_ext=5000
        "Enthalpy flow rate into volume";

      package Medium = IdealGases.SingleGases.N2 "Medium model";
      // initType=Medium.Choices.Init.SteadyState,

      Medium.BaseProperties medium(preferredMediumStates=true,
        p(start=1.e5),
        T(start=300));

      Real m(quantity=Medium.mediumName, start = 1.0);
      SI.InternalEnergy U;

      Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(medium);
      Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium);
      Medium.IsentropicExponent gamma=Medium.isentropicExponent(medium);
      Medium.SpecificEntropy s=Medium.specificEntropy(medium);
      Medium.VelocityOfSound a=Medium.velocityOfSound(medium);
    equation

      m = medium.d*V;
      U = m*medium.u;

      // Mass balance
      der(m) = m_flow_ext;

      // Energy balance
      der(U) = H_flow_ext;
      annotation (Documentation(info="<html>

</html>"),
        experiment(StopTime=1));
    end IdealGasN2;

    package TestMedia "Test interfaces of media"
      extends Modelica.Icons.Package;
      model TemplateMedium "Test Interfaces.TemplateMedium"
        extends Modelica.Icons.Example;
        package Medium = Interfaces.TemplateMedium "Medium model";
        Medium.ThermodynamicState medium;

        Medium.DynamicViscosity eta=Medium.dynamicViscosity(medium);
        Medium.ThermalConductivity lambda=Medium.thermalConductivity(medium);
        Medium.SpecificEntropy s=Medium.specificEntropy(medium);
        Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(medium);
        Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium);
        Medium.IsentropicExponent gamma=Medium.isentropicExponent(medium);
        Medium.VelocityOfSound a=Medium.velocityOfSound(medium);
      equation
        medium.p = 1.0e5;
        medium.T = 300 + time/1000;
        annotation (Documentation(info="<html>

</html>"));
      end TemplateMedium;

      annotation (Documentation(info="<html>

</html>"));
    end TestMedia;

    model IdealGasN2Mix "Test IdealGas.SingleMedia.N2 medium model"
      extends Modelica.Icons.Example;

      parameter Modelica.SIunits.Volume V=1 "Size of volume";
      parameter Medium.MassFlowRate m_flow_ext=0.01
        "Mass flow rate flowing into volume";
      parameter Medium.EnthalpyFlowRate H_flow_ext=5000
        "Enthalpy flow rate flowing into volume";

      package Medium = N2AsMix "Medium model";
      // initType=Medium.Choices.Init.SteadyState,

      Medium.BaseProperties medium(preferredMediumStates=true,
        p(start=1.e5),
        T(start=300));

      Real m(quantity=Medium.mediumName, start = 1.0);
      SI.InternalEnergy U;

      Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(medium);
      Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium);
      Medium.IsentropicExponent gamma=Medium.isentropicExponent(medium);
      Medium.SpecificEntropy s=Medium.specificEntropy(medium);
      Medium.VelocityOfSound a=Medium.velocityOfSound(medium);
    equation

      m = medium.d*V;
      U = m*medium.u;
      medium.X = {1.0};
      // Mass balance
      der(m) = m_flow_ext;

      // Energy balance
      der(U) = H_flow_ext;
      annotation (Documentation(info="<html>

</html>"),
        experiment(StopTime=1));
    end IdealGasN2Mix;
  annotation (Documentation(info="<html>

</html>"));
  end TestOnly;

  package Tests
    "Library to test that all media models simulate and fulfill the expected structural properties"

    extends Modelica.Icons.Package;

    package Components
      "Functions, connectors and models needed for the media model tests"

       extends Modelica.Icons.Package;

      connector FluidPort
        "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)"

        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (__Dymola_choicesAllMatching=true);

        Medium.AbsolutePressure p "Pressure in the connection point";
        flow Medium.MassFlowRate m_flow
          "Mass flow rate from the connection point into the component";

        Medium.SpecificEnthalpy h
          "Specific mixture enthalpy in the connection point";
        flow Medium.EnthalpyFlowRate H_flow
          "Enthalpy flow rate into the component (if m_flow > 0, H_flow = m_flow*h)";

        Medium.MassFraction Xi[Medium.nXi]
          "Independent mixture mass fractions m_i/m in the connection point";
        flow Medium.MassFlowRate mXi_flow[Medium.nXi]
          "Mass flow rates of the independent substances from the connection point into the component (if m_flow > 0, mX_flow = m_flow*X)";

        Medium.ExtraProperty C[Medium.nC]
          "properties c_i/m in the connection point";
        flow Medium.ExtraPropertyFlowRate mC_flow[Medium.nC]
          "Flow rates of auxiliary properties from the connection point into the component (if m_flow > 0, mC_flow = m_flow*C)";

        annotation (Documentation(info="<html>

</html>"));
      end FluidPort;

      connector FluidPort_a "Fluid connector with filled icon"
        extends FluidPort;
        annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,127,255},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-88,206},{112,112}},
                textString="%name",
                lineColor={0,0,255})}),
             Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,127,255},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid), Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>Modelica.Media.Examples.Tests.Components.FluidPort_a
</html>"));
      end FluidPort_a;

      connector FluidPort_b "Fluid connector with outlined icon"
        extends FluidPort;
        annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,127,255},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-80,80},{80,-80}},
                lineColor={0,127,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-88,192},{112,98}},
                textString="%name",
                lineColor={0,0,255})}),
             Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={
              Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,127,255},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-80,80},{80,-80}},
                lineColor={0,127,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>

</html>"));
      end FluidPort_b;

      model PortVolume
        "Fixed volume associated with a port by the finite volume method"
        import SI = Modelica.SIunits;

        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model"
           annotation (__Dymola_choicesAllMatching=true);

        parameter SI.Volume V=1e-6 "Fixed size of junction volume";

        parameter Boolean use_p_start=true "select p_start or d_start"
          annotation (Evaluate=true, Dialog(group="Initial pressure or initial density"));
        parameter Medium.AbsolutePressure p_start = 101325 "Initial pressure"
          annotation (Dialog(group="Initial pressure or initial density", enable=use_p_start));
        parameter Medium.Density d_start=1 "Initial density"
          annotation (Dialog(group="Initial pressure or initial density", enable=not use_p_start));
        parameter Boolean use_T_start=true "select T_start or h_start"
          annotation (Evaluate=true, Dialog(group="Initial temperature or initial specific enthalpy"));
        parameter Medium.Temperature T_start = Modelica.SIunits.Conversions.from_degC(20)
          "Initial temperature"
          annotation (Dialog(group="Initial temperature or initial specific enthalpy", enable=use_T_start));
        parameter Medium.SpecificEnthalpy h_start = 1.e4
          "Initial specific enthalpy"
          annotation (Dialog(group="Initial temperature or initial specific enthalpy", enable=not use_T_start));
        parameter Medium.MassFraction X_start[Medium.nX]
          "Initial mass fractions m_i/m"
          annotation (Dialog(group="Only for multi-substance flow", enable=Medium.nX > 0));

        FluidPort_a port(redeclare package Medium = Medium) annotation (Placement(
              transformation(extent={{-10,-10},{10,10}}, rotation=0)));
        Medium.BaseProperties medium(preferredMediumStates=true);
        SI.Energy U "Internal energy of port volume";
        SI.Mass m "Mass of junction volume";
        SI.Mass mXi[Medium.nXi]
          "Independent substance masses of junction volume";

      initial equation
        if not Medium.singleState then
          if use_p_start then
             medium.p = p_start;
          else
             medium.d = d_start;
          end if;
        end if;

        if use_T_start then
           medium.T = T_start;
        else
           medium.h = h_start;
        end if;

        medium.Xi = X_start[1:Medium.nXi];
      equation
        // Connect port to medium variables
           medium.p = port.p;
           medium.h = port.h;
           medium.Xi = port.Xi;

        // Total quantities
           m    = V*medium.d;
           mXi = m*medium.Xi;
           U    = m*medium.u;

        // Mass and energy balance
           der(m)    = port.m_flow;
           der(mXi) = port.mXi_flow;
           der(U)    = port.H_flow;
        annotation (
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillPattern=FillPattern.Sphere,
                fillColor={170,213,255}),
              Text(
                extent={{-144,178},{146,116}},
                textString="%name",
                lineColor={0,0,255}),
              Text(
                extent={{-130,-108},{144,-150}},
                lineColor={0,0,0},
                textString="V=%V")}),
                               Documentation(info="<html>
<p>
This component models the <b>volume</b> of <b>fixed size</b> that is
associated with the <b>fluid port</b> to which it is connected.
This means that all medium properties inside the volume, are identical
to the port medium properties. In particular, the specific enthalpy
inside the volume (= medium.h) is always identical to the specific enthalpy
in the port (port.h = medium.h). Usually, this model is used when
discretizing a component according to the finite volume method into
volumes in internal ports that only store energy and mass and into
transport elements that just transport energy, mass and momentum
between the internal ports without storing these quantities during the
transport.
</p>
</html>"),Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}),
                  graphics));
      end PortVolume;

      model FixedMassFlowRate
        "Ideal pump that produces a constant mass flow rate from a large reservoir at fixed temperature and mass fraction"

        parameter Medium.MassFlowRate m_flow
          "Fixed mass flow rate from an infinite reservoir to the fluid port";

        parameter Boolean use_T_ambient=true "select T_ambient or h_ambient"
          annotation (Evaluate=true, Dialog(group=
                "Ambient temperature or ambient specific enthalpy"));
        parameter Medium.Temperature T_ambient=
            Modelica.SIunits.Conversions.from_degC(20) "Ambient temperature"
          annotation (Dialog(group="Ambient temperature or ambient specific enthalpy",
                                                                    enable=
                use_T_ambient));
        parameter Medium.SpecificEnthalpy h_ambient=
            1.e4 "Ambient specific enthalpy"
          annotation (Dialog(group="Ambient temperature or ambient specific enthalpy",
                                                                    enable=not
                use_T_ambient));
        parameter Medium.MassFraction X_ambient[Medium.nX]
          "Ambient mass fractions m_i/m of reservoir";

        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model"
           annotation (__Dymola_choicesAllMatching=true);

        Medium.BaseProperties medium "Medium in the source";
        FluidPort_b port(redeclare package Medium = Medium)
          annotation (Placement(transformation(extent={{100,-10},{120,10}},
                rotation=0)));
      equation
         if use_T_ambient then
           medium.T = T_ambient;
         else
           medium.h = h_ambient;
         end if;

         medium.Xi     = X_ambient[1:Medium.nXi];
         medium.p      = port.p;
         port.m_flow   = -m_flow;
         port.mXi_flow = semiLinear(port.m_flow, port.Xi, medium.Xi);
         port.H_flow   = semiLinear(port.m_flow, port.h, medium.h);
        annotation (
          Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={
              Rectangle(
                extent={{20,60},{100,-60}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={192,192,192}),
              Rectangle(
                extent={{38,40},{100,-40}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={0,127,255}),
              Ellipse(
                extent={{-100,80},{60,-80}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,255}),
              Polygon(
                points={{-60,70},{60,0},{-60,-68},{-60,70}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-54,32},{16,-30}},
                lineColor={255,0,0},
                textString="m"),
              Text(
                extent={{-142,142},{156,88}},
                textString="%name",
                lineColor={0,0,255}),
              Text(
                extent={{-154,-88},{150,-132}},
                lineColor={0,0,0},
                textString="%m_flow"),
              Ellipse(
                extent={{-26,30},{-18,22}},
                lineColor={255,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid)}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics),
          Documentation(info="<html>

</html>"));
      end FixedMassFlowRate;

      model FixedAmbient
        "Ambient pressure, temperature and mass fraction source"
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model"
           annotation (__Dymola_choicesAllMatching=true);

        parameter Boolean use_p_ambient=true "select p_ambient or d_ambient"
          annotation (Evaluate=true, Dialog(group=
                "Ambient pressure or ambient density"));
        parameter Medium.AbsolutePressure p_ambient= 101325 "Ambient pressure"          annotation (
           Dialog(group="Ambient pressure or ambient density", enable=use_p_ambient));
        parameter Medium.Density d_ambient=1 "Ambient density"
                             annotation (Dialog(group=
                "Ambient pressure or ambient density", enable=not use_p_ambient));
        parameter Boolean use_T_ambient=true "select T_ambient or h_ambient"
          annotation (Evaluate=true, Dialog(group=
                "Ambient temperature or ambient specific enthalpy"));
        parameter Medium.Temperature T_ambient=
            Modelica.SIunits.Conversions.from_degC(20) "Ambient temperature"
          annotation (Dialog(group="Ambient temperature or ambient specific enthalpy",
                                                                    enable=
                use_T_ambient));
        parameter Medium.SpecificEnthalpy h_ambient=
            1.e4 "Ambient specific enthalpy"
          annotation (Dialog(group="Ambient temperature or ambient specific enthalpy",
                                                                    enable=not
                use_T_ambient));
        parameter Medium.MassFraction X_ambient[Medium.nX]
          "Ambient mass fractions m_i/m"                                                   annotation (Dialog(group=
                "Only for multi-substance flow", enable=Medium.nX > 0));

        Medium.BaseProperties medium "Medium in the source";
        FluidPort_b port(redeclare package Medium = Medium)
          annotation (Placement(transformation(extent={{100,-10},{120,10}},
                rotation=0)));

      equation
        if use_p_ambient or Medium.singleState then
          medium.p = p_ambient;
        else
          medium.d = d_ambient;
        end if;

        if use_T_ambient then
          medium.T = T_ambient;
        else
          medium.h = h_ambient;
        end if;

        medium.Xi = X_ambient[1:Medium.nXi];

        port.p = medium.p;
        port.H_flow   = semiLinear(port.m_flow, port.h, medium.h);
        port.mXi_flow = semiLinear(port.m_flow, port.Xi, medium.Xi);
        annotation (
          Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={Ellipse(
                extent={{-100,80},{100,-80}},
                lineColor={0,0,0},
                fillPattern=FillPattern.Sphere,
                fillColor={0,127,255}), Text(
                extent={{-136,144},{132,82}},
                textString="%name",
                lineColor={0,0,255})}),
          Documentation(info="<html>
<p>
Model <b>FixedAmbient_pt</b> defines constant values for ambient conditions:
</p>
<ul>
<li> Ambient pressure.</li>
<li> Ambient temperature.</li>
<li> Ambient mass fractions (only for multi-substance flow).</li>
</ul>
<p>
Note, that ambient temperature
and mass fractions have only an effect if the mass flow
is from the ambient into the port. If mass is flowing from
the port into the ambient, the ambient definitions,
with exception of ambient pressure, do not have an effect.
</p>
</html>"));
      end FixedAmbient;

      model ShortPipe "Simple pressure loss in pipe"
         replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model"
           annotation (__Dymola_choicesAllMatching=true);

        parameter Medium.AbsolutePressure dp_nominal(min=1.e-10)
          "Nominal pressure drop";
        parameter Medium.MassFlowRate m_flow_nominal(min=1.e-10)
          "Nominal mass flow rate at nominal pressure drop";

        FluidPort_a port_a(redeclare package Medium = Medium)
          annotation (Placement(transformation(extent={{-120,-10},{-100,10}},
                rotation=0)));
        FluidPort_b port_b(redeclare package Medium = Medium)
          annotation (Placement(transformation(extent={{120,-10},{100,10}},
                rotation=0)));
        // Medium.BaseProperties medium_a(p=port_a.p, h=port_a.h, Xi=port_a.Xi)
        //   "Medium properties in port_a";
        // Medium.BaseProperties medium_b(p=port_b.p, h=port_b.h, Xi=port_b.Xi)
        //   "Medium properties in port_b";
        Medium.MassFlowRate m_flow
          "Mass flow rate from port_a to port_b (m_flow > 0 is design flow direction)";
        Modelica.SIunits.Pressure dp "Pressure drop from port_a to port_b";
      equation
        /* Handle reverse and zero flow */
        port_a.H_flow   = semiLinear(port_a.m_flow, port_a.h,   port_b.h);
        port_a.mXi_flow = semiLinear(port_a.m_flow, port_a.Xi, port_b.Xi);

        /* Energy, mass and substance mass balance */
        port_a.H_flow + port_b.H_flow = 0;
        port_a.m_flow + port_b.m_flow = 0;
        port_a.mXi_flow + port_b.mXi_flow = zeros(Medium.nXi);

        // Design direction of mass flow rate
        m_flow = port_a.m_flow;

        // Pressure drop
        dp = port_a.p - port_b.p;
        m_flow = (m_flow_nominal/dp_nominal)*dp;
                                                                                         annotation (Icon(
              coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Rectangle(
                extent={{-100,60},{100,-60}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={192,192,192}),
              Rectangle(
                extent={{-100,34},{100,-36}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={0,127,255}),
              Text(
                extent={{-150,140},{150,80}},
                lineColor={0,0,0},
                textString="%name"),
              Text(
                extent={{-136,-62},{122,-108}},
                lineColor={0,0,0},
                textString="k=%m_flow_nominal/%dp_nominal")}),
                                                 Documentation(info="<html>
<p>
Model <b>ShortPipe</b> defines a simple pipe model
with pressure loss due to friction. It is assumed that
no mass or energy is stored in the pipe.
</p>
</html>"));
      end ShortPipe;

      partial model PartialTestModel "Basic test model to test a medium"
        import SI = Modelica.SIunits;
        extends Modelica.Icons.Example;

        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (__Dymola_choicesAllMatching=true);
        parameter SI.AbsolutePressure p_start = Medium.p_default
          "Initial value of pressure";
        parameter SI.Temperature T_start = Medium.T_default
          "Initial value of temperature";
        parameter SI.SpecificEnthalpy h_start = Medium.h_default
          "Initial value of specific enthalpy";
        parameter Real X_start[Medium.nX] = Medium.X_default
          "Initial value of mass fractions";

      /*
  parameter SI.AbsolutePressure p_start = 1.0e5 "Initial value of pressure";
  parameter SI.Temperature T_start = 300 "Initial value of temperature";
  parameter SI.Density h_start = 1 "Initial value of specific enthalpy";
  parameter Real X_start[Medium.nX] = Medium.reference_X
    "Initial value of mass fractions";
*/
        PortVolume volume(redeclare package Medium = Medium,
                          p_start=p_start,
                          T_start=T_start,
                          h_start=h_start,
                          X_start = X_start,
                          V=0.1)
                 annotation (Placement(transformation(extent={{-40,0},{-20,20}},
                rotation=0)));
        FixedMassFlowRate fixedMassFlowRate(redeclare package Medium = Medium,
          T_ambient=1.2*T_start,
          h_ambient=1.2*h_start,
          m_flow=1,
          X_ambient=0.5*X_start)
                                annotation (Placement(transformation(extent={{
                  -80,0},{-60,20}}, rotation=0)));
        FixedAmbient ambient(
          redeclare package Medium = Medium,
          T_ambient=T_start,
          h_ambient=h_start,
          X_ambient=X_start,
          p_ambient=p_start) annotation (Placement(transformation(extent={{60,0},
                  {40,20}}, rotation=0)));
        ShortPipe shortPipe(redeclare package Medium = Medium,
          m_flow_nominal=1,
          dp_nominal=0.1e5)
          annotation (Placement(transformation(extent={{0,0},{20,20}}, rotation=
                 0)));
      equation
        connect(fixedMassFlowRate.port, volume.port) annotation (Line(points={{
                -59,10},{-30,10}}, color={0,127,255}));
        connect(volume.port, shortPipe.port_a)
          annotation (Line(points={{-30,10},{-1,10}}, color={0,127,255}));
        connect(shortPipe.port_b, ambient.port)
          annotation (Line(points={{21,10},{39,10}}, color={0,127,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                            graphics),
                             Documentation(info="<html>

</html>"));
      end PartialTestModel;

      partial model PartialTestModel2
        "slightly larger test model to test a medium"
        import SI = Modelica.SIunits;
        extends Modelica.Icons.Example;

        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (__Dymola_choicesAllMatching=true);
        parameter SI.AbsolutePressure p_start = 1.0e5
          "Initial value of pressure";
        parameter SI.Temperature T_start = 300 "Initial value of temperature";
        parameter SI.SpecificEnthalpy h_start = 1
          "Initial value of specific enthalpy";
        parameter Real X_start[Medium.nX] = Medium.reference_X
          "Initial value of mass fractions";
        PortVolume volume(redeclare package Medium = Medium,
                          p_start=p_start,
                          T_start=T_start,
                          h_start=h_start,
                          X_start = X_start,
                          V=0.1)
                 annotation (Placement(transformation(extent={{-60,0},{-40,20}},
                rotation=0)));
        FixedMassFlowRate fixedMassFlowRate(redeclare package Medium = Medium,
          T_ambient=1.2*T_start,
          h_ambient=1.2*h_start,
          m_flow=1,
          X_ambient=0.5*X_start)
                                annotation (Placement(transformation(extent={{
                  -100,0},{-80,20}}, rotation=0)));
        FixedAmbient ambient(
          redeclare package Medium = Medium,
          T_ambient=T_start,
          h_ambient=h_start,
          X_ambient=X_start,
          p_ambient=p_start) annotation (Placement(transformation(extent={{92,0},
                  {72,20}}, rotation=0)));
        ShortPipe shortPipe(redeclare package Medium = Medium,
          m_flow_nominal=1,
          dp_nominal=0.1e5)
          annotation (Placement(transformation(extent={{-30,0},{-10,20}},
                rotation=0)));
        PortVolume volume1(
                          redeclare package Medium = Medium,
                          p_start=p_start,
                          T_start=T_start,
                          h_start=h_start,
                          X_start = X_start,
                          V=0.1)
                 annotation (Placement(transformation(extent={{0,0},{20,20}},
                rotation=0)));
        ShortPipe shortPipe1(
                            redeclare package Medium = Medium,
          m_flow_nominal=1,
          dp_nominal=0.1e5)
          annotation (Placement(transformation(extent={{36,0},{56,20}},
                rotation=0)));
      equation
        connect(fixedMassFlowRate.port, volume.port) annotation (Line(points={{
                -79,10},{-50,10}}, color={0,127,255}));
        connect(volume.port, shortPipe.port_a)
          annotation (Line(points={{-50,10},{-31,10}}, color={0,127,255}));
        connect(volume1.port, shortPipe1.port_a)
          annotation (Line(points={{10,10},{35,10}}, color={0,127,255}));
        connect(shortPipe.port_b, volume1.port)
          annotation (Line(points={{-9,10},{10,10}}, color={0,127,255}));
        connect(shortPipe1.port_b, ambient.port)
          annotation (Line(points={{57,10},{71,10}}, color={0,127,255}));
        annotation (         Documentation(info="<html>

</html>"));
      end PartialTestModel2;
      annotation (Documentation(info="<html>

</html>"));
    end Components;

    package MediaTestModels "Test models to test all media"
      extends Modelica.Icons.Package;
      package Air "Test models of library Modelica.Media.Air"
        extends Modelica.Icons.Package;
        model SimpleAir "Test Modelica.Media.Air.SimpleAir"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = Modelica.Media.Air.SimpleAir);
          annotation (Documentation(info="<html>

</html>"));
        end SimpleAir;

        model DryAirNasa "Test Modelica.Media.Air.DryAirNasa"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = Modelica.Media.Air.DryAirNasa);
          annotation (Documentation(info="<html>

</html>"));
        end DryAirNasa;

        model MoistAir "Test Modelica.Media.Air.MoistAir"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = Modelica.Media.Air.MoistAir);
          annotation (Documentation(info="<html>

</html>"));
        end MoistAir;
        annotation (Documentation(info="<html>

</html>"));
      end Air;

      package IdealGases "Test models of library Modelica.Media.IdealGases"
        extends Modelica.Icons.Package;

        model Air "Test single gas Modelica.Media.IdealGases.SingleGases.Air"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium =
                Modelica.Media.Air.DryAirNasa);
          annotation (Documentation(info="<html>

</html>"));
        end Air;

        model Nitrogen
          "Test single gas Modelica.Media.IdealGases.SingleGases.N2"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium =
                Modelica.Media.IdealGases.SingleGases.N2);
          annotation (Documentation(info="<html>

</html>"));
        end Nitrogen;

        model SimpleNaturalGas
          "Test mixture gas Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium =
                Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas);
          annotation (Documentation(info="<html>

</html>"));
        end SimpleNaturalGas;

        model SimpleNaturalGasFixedComposition
          "Test mixture gas Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium =
                Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGasFixedComposition);
          annotation (experiment(StopTime=1));
        end SimpleNaturalGasFixedComposition;
      end IdealGases;

      package Incompressible
        "Test models of library Modelica.Media.Incompressible"
        extends Modelica.Icons.Package;
        model Glycol47 "Test Modelica.Media.Incompressible.Examples.Glycol47"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium =
                Modelica.Media.Incompressible.Examples.Glycol47(final
                  singleState =                                                   true,
                  final enthalpyOfT =                                                              true));
          annotation (Documentation(info="<html>

</html>"));
        end Glycol47;

        model Essotherm650
          "Test Modelica.Media.Incompressible.Examples.Essotherm65"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium =
                Modelica.Media.Incompressible.Examples.Essotherm650);
          annotation (Documentation(info="<html>

</html>"));
        end Essotherm650;
        annotation (Documentation(info="<html>

</html>"));
      end Incompressible;

      package Water "Test models of library Modelica.Media.Water"
        extends Modelica.Icons.Package;
        model ConstantPropertyLiquidWater
          "Test Modelica.Media.Water.ConstantPropertyLiquidWater"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium =
                Modelica.Media.Water.ConstantPropertyLiquidWater);
          annotation (Documentation(info="<html>

</html>"));
        end ConstantPropertyLiquidWater;

        model IdealSteam "Test Modelica.Media.Water.IdealSteam"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = Modelica.Media.Water.IdealSteam);
          annotation (Documentation(info="<html>

</html>"));
        end IdealSteam;

        model WaterIF97OnePhase_ph
          "Test Modelica.Media.Water.WaterIF97OnePhase_ph"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium =
                Modelica.Media.Water.WaterIF97OnePhase_ph,
            fixedMassFlowRate(use_T_ambient=false, h_ambient=363755),
            ambient(use_T_ambient=false, h_ambient=112570));
          annotation (Documentation(info="<html>

</html>"));
        end WaterIF97OnePhase_ph;

        model WaterIF97_pT "Test Modelica.Media.Water.WaterIF97_pT"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = Modelica.Media.Water.WaterIF97_pT);
          annotation (Documentation(info="<html>

</html>"));
        end WaterIF97_pT;

        model WaterIF97_ph "Test Modelica.Media.Water.WaterIF97_ph"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
            ambient(use_T_ambient=false, h_ambient=112570),
            fixedMassFlowRate(use_T_ambient=false, h_ambient=363755));
          annotation (Documentation(info="<html>

</html>"));
        end WaterIF97_ph;
        /*
        model WaterIF97_dT "Test Modelica.Media.Water.WaterIF97_dT"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = Modelica.Media.Water.WaterIF97_dT,
              ambient(use_p_ambient=false, d_ambient=996.557));
        end WaterIF97_dT;
*/
        annotation (Documentation(info="<html>

</html>"));
      end Water;

      package LinearFluid
        "Test models of library Modelica.Media.Incompressible"
        extends Modelica.Icons.Package;
        model LinearColdWater
          "Test Modelica.Media.Incompressible.Examples.Glycol47"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium =
                Modelica.Media.CompressibleLiquids.LinearColdWater);
          annotation (Documentation(info="<html>

</html>"));
        end LinearColdWater;

        model LinearWater_pT
          "Test Modelica.Media.Incompressible.Examples.Essotherm65"
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium =
                Modelica.Media.CompressibleLiquids.LinearWater_pT_Ambient);
          annotation (Documentation(info="<html>

</html>"));
        end LinearWater_pT;
        annotation (Documentation(info="<html>

</html>"));
      end LinearFluid;
      annotation (Documentation(info="<html>

</html>"));
    end MediaTestModels;
    annotation (Documentation(info="<html>

</html>"));
  end Tests;

  package SolveOneNonlinearEquation
    "Demonstrate how to solve one non-linear algebraic equation in one unknown"
    extends Modelica.Icons.ExamplesPackage;

   model Inverse_sine "Solve y = A*sin(w*x) for x, given y"
      import Modelica.Utilities.Streams.print;
      extends Modelica.Icons.Example;

      parameter Real y_zero = 0.5 "Desired value of A*sin(w*x)";
      parameter Real x_min = -1.7 "Minimum value of x_zero";
      parameter Real x_max = 1.7 "Maximum value of x_zero";
      parameter Real A = 1;
      parameter Real w = 1;
      parameter Inverse_sine_definition.f_nonlinear_Data data=
                Inverse_sine_definition.f_nonlinear_Data(A=A, w=w);
      Real x_zero "y_zero = A*sin(w*x_zero)";

   encapsulated package Inverse_sine_definition
        "Define sine as non-linear equation to be solved"
        import Modelica;
      extends Modelica.Media.Common.OneNonLinearEquation;

      redeclare record extends f_nonlinear_Data "Data for nonlinear equation"
         Real A;
         Real w;
          annotation (Documentation(info="<html>

</html>"));
      end f_nonlinear_Data;

      redeclare function extends f_nonlinear "Non-linear equation to be solved"
      algorithm
          y := f_nonlinear_data.A*Modelica.Math.sin(f_nonlinear_data.w*x);
      end f_nonlinear;

      // Dummy definition has to be added for current Dymola (advice from Hans)
      redeclare function extends solve
          "Solution algorithm of non-linear equation"
      end solve;
        annotation (Documentation(info="<html>

</html>"));
   end Inverse_sine_definition;

   equation
      x_zero = Inverse_sine_definition.solve(y_zero, x_min, x_max, f_nonlinear_data=data);

      print("x_zero = " + String(x_zero) + ", y_zero = " + String(y_zero) + ", A*sin(w*x_zero) = " +
            String(data.A*Modelica.Math.sin(data.w*x_zero)));
      annotation (
        experiment(StopTime=0),
        Documentation(info="<html>
<p>
This models solves the following non-linear equation
</p>

<pre>
   y = A*sin(w*x); -> determine x for given y
</pre>

<p>
Translate model \"Inverse_sine\"
and simulate for 0 sec. The result is printed to the
output window.
</p>

</html>"));
   end Inverse_sine;

   model Inverse_sh_T
      "Solve h = h_T(T), s = s_T(T) for T, if h or s is given for ideal gas NASA"
      import SI = Modelica.SIunits;
      extends Modelica.Icons.Example;

      replaceable package Medium = Modelica.Media.Air.DryAirNasa
            constrainedby Modelica.Media.IdealGases.Common.SingleGasNasa
        "Medium model"     annotation (__Dymola_choicesAllMatching=true);

     parameter SI.Temperature T_min = 300
        "Vary temperature linearly from T_min (time=0) upto T_max (time=1)";
     parameter SI.Temperature T_max = 500
        "Vary temperature linearly from T_min (time=0) upto T_max (time=1)";
     parameter SI.Pressure p = 1.0e5 "Fixed pressure in model";
     final parameter SI.SpecificEnthalpy h_min = Medium.h_T(Medium.data,T_min)
        "Specific enthalpy at T_min";
     final parameter SI.SpecificEnthalpy h_max = Medium.h_T(Medium.data,T_max)
        "Specific enthalpy at T_max";
     final parameter SI.SpecificEntropy s_min = Medium.specificEntropy(Medium.setState_pT(p,T_min))
        "Specific entropy at T_min";
     final parameter SI.SpecificEntropy s_max = Medium.specificEntropy(Medium.setState_pT(p,T_max))
        "Specific entropy at T_max";
     SI.SpecificEnthalpy h1 "Pre-defined specific enthalpy";
     SI.SpecificEnthalpy h2 "Specific enthalpy computed from T (= h1 required)";
     SI.SpecificEntropy s1 "Pre-defined specific entropy";
     SI.SpecificEntropy s2 "Specific entropy computed from T (= h1 required)";
     SI.Temperature Th "Temperature computed from h1";
     SI.Temperature Ts "Temperature computed from s1";

    protected
     constant SI.Time timeUnit = 1.0;

   equation
      // Define specific enthalpy and specific entropy
      h1 = if time < 0 then h_min else
           if time > 1 then h_max else
              h_min + time/timeUnit*(h_max - h_min);
      s1 = if time < 0 then s_min else
           if time > 1 then s_max else
              s_min + time/timeUnit*(s_max - s_min);

      // Solve for temperature
      Th = Medium.temperature_phX(p, h1, fill(0.0,0));
      Ts = Medium.temperature_psX(p, s1, fill(0.0,0));

      // Check (h2 must be identical to h1)
      h2 = Medium.specificEnthalpy_pTX(p, Th, fill(0.0,0));
      s2 = Medium.specificEntropy(Medium.setState_pT(p,Ts));
     annotation (experiment(StopTime=1),
                 Documentation(info="<html>
                               </html>"));
   end Inverse_sh_T;

   model InverseIncompressible_sh_T
      "inverse computation for incmpressible media"
      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;
     extends Modelica.Icons.Example;

     replaceable package Medium =
          Modelica.Media.Incompressible.Examples.Glycol47 "Medium model"
                        annotation (__Dymola_choicesAllMatching=true);

     parameter SI.Temperature T_min = Medium.T_min
        "Vary temperature linearly from T_min (time=0) upto T_max (time=1)";
     parameter SI.Temperature T_max = Medium.T_max
        "Vary temperature linearly from T_min (time=0) upto T_max (time=1)";
     parameter SI.Pressure p = 1.0e5 "Fixed pressure in model";
     final parameter SI.SpecificEnthalpy h_min = Medium.h_T(Medium.T_min)
        "Specific enthalpy at T_min";
     final parameter SI.SpecificEnthalpy h_max = Medium.h_T(Medium.T_max)
        "Specific enthalpy at T_max";
     final parameter SI.SpecificEntropy s_min = Medium.specificEntropy(Medium.setState_pT(p,T_min))
        "Specific entropy at T_min";
     final parameter SI.SpecificEntropy s_max = Medium.specificEntropy(Medium.setState_pT(p,T_max))
        "Specific entropy at T_max";

     SI.SpecificEnthalpy h1 "Pre-defined specific enthalpy";
     SI.SpecificEnthalpy h2 "Specific enthalpy computed from T (= h1 required)";
     SI.SpecificEntropy s1 "Pre-defined specific entropy";
     SI.SpecificEntropy s2 "Specific entropy computed from T (= h1 required)";
     SI.Temperature Th "Temperature computed from h1";
     SI.Temperature Ts "Temperature computed from s1";

    protected
     constant SI.Time timeUnit = 1.0;

   equation
     // Define specific enthalpy
     h1 = if time < 0 then h_min else
       if time > 1 then h_max else
       h_min + time/timeUnit*(h_max - h_min);
     s1 = if time < 0 then s_min else
       if time > 1 then s_max else
       s_min + time/timeUnit*(s_max - s_min);

     // Solve for temperature
     Th = Medium.temperature_phX(p, h1, fill(0.0,0));
     Ts = Medium.temperature_psX(p, s1, fill(0.0,0));

     // Check (h2 must be identical to h1)
     h2 = Medium.specificEnthalpy_pTX(p, Th, fill(0.0,0));
     s2 = Medium.specificEntropy(Medium.setState_pT(p, Ts));
     annotation (experiment(StopTime=1),
                 Documentation(info="<html>

                               </html>"));
   end InverseIncompressible_sh_T;

   model Inverse_sh_TX
      "Solve h = h_TX(TX) for T, if h is given for ideal gas NASA"
      import SI = Modelica.SIunits;
      extends Modelica.Icons.Example;

      replaceable package Medium =
          Modelica.Media.IdealGases.MixtureGases.FlueGasLambdaOnePlus
            constrainedby Modelica.Media.IdealGases.Common.MixtureGasNasa
        "Medium model"     annotation (__Dymola_choicesAllMatching=true);

     parameter SI.Temperature T_min = 300
        "Vary temperature linearly from T_min (time=0) upto T_max (time=1)";
     parameter SI.Temperature T_max = 500
        "Vary temperature linearly from T_min (time=0) upto T_max (time=1)";
     parameter SI.Pressure p = 1.0e5 "Fixed pressure in model";
     SI.SpecificEnthalpy h_min = Medium.h_TX(T_min,X)
        "Specific enthalpy at T_min";
     SI.SpecificEnthalpy h_max = Medium.h_TX(T_max,X)
        "Specific enthalpy at T_max";
     SI.SpecificEntropy s_min = Medium.specificEntropy(Medium.setState_pTX(p,T_min,Medium.reference_X))
        "Specific entropy at T_min";
     SI.SpecificEntropy s_max = Medium.specificEntropy(Medium.setState_pTX(p,T_max,Medium.reference_X))
        "Specific entropy at T_max";
     SI.SpecificEnthalpy h1 "Pre-defined specific enthalpy";
     SI.SpecificEnthalpy h2 "Specific enthalpy computed from T (= h1 required)";
     SI.SpecificEntropy s1 "Pre-defined specific entropy";
     SI.SpecificEntropy s2 "Specific entropy computed from T (= h1 required)";
     SI.Temperature Th "Temperature computed from h1";
     SI.Temperature Ts "Temperature computed from s1";
     SI.MassFraction[4] X "mass fraction vector";

    protected
     constant SI.Time timeUnit = 1.0;

   equation
     X = Medium.reference_X;
      // Define specific enthalpy
      h1 = if time < 0 then h_min else
           if time > 1 then h_max else
              h_min + time/timeUnit*(h_max - h_min);
      s1 = if time < 0 then s_min else
           if time > 1 then s_max else
              s_min + time/timeUnit*(s_max - s_min);

      // Solve for temperature
      Th = Medium.temperature_phX(p, h1, X);
      Ts = Medium.temperature_psX(p, s1, X);

      // Check (h2 must be identical to h1)
      h2 = Medium.specificEnthalpy_pTX(p, Th, X);
      s2 = Medium.specificEntropy(Medium.setState_pTX(p,Ts,X));
     annotation (
       experiment(StopTime=1),
       Documentation(info="<html>

</html>"));
   end Inverse_sh_TX;

    annotation (Documentation(info="<html>
<p>
This package demonstrates how to solve one non-linear algebraic
equation in one unknown with function
Modelica.Media.Common.OneNonLinearEquation.
</p>

</html>"));
  end SolveOneNonlinearEquation;
  annotation (Documentation(info="<html>
<h4>Examples</h4>
Physical properties for fluids are needed in so many different variants
that a library can only provide models for the most common situations.
With the following examples we are going to demonstrate how to use the
existing packages and functions in Modelica.Media to customize these
models for advanced applications. The high level functions try to
abstract as much as possible form the fact that different media are
based on different variables, e.g., ideal gases need pressure and
temperature, while many refrigerants are based on Helmholtz functions
of density and temperature, and many water proeprties are based on
pressure and specific enthalpy. Medium properties are needed in control
volumes in the dynamic state equations and in many thermodynamic state
locations that are independent of the dynamic states of a control
volume, e.g., at a wall temperature, an isentropic reference state or at
a phase boundary. The general structure of the library is such that:<br>
<ul>
<li>Each medium has a model called BaseProperties. BaseProperties
contains the minimum set of medium properties needed in a dynamic
control volume model.</li>
<li>Each instance of BaseProperties contains a \"state\" record that is
an input to all the functions to compute properties. If these functions
need further inputs, like e.g., the molarMass, these are accessible as
constants in the package.</li>
<li>The simplest way to compute properties at any other reference
point is to declare an instance of ThermodynamicState and use that as
input to arbitrary property functions.<br>
</li>
</ul>

<p>
A small library of generic volume, pipe, pump and ambient models
is provided in Modelica.Media.Examples.Tests.Components to demonstrate
how fluid components should be implemented that are using Modelica.Media
models. This library is also used to test all media models in
Modelica.Media.Examples.Tests.MediaTestModels.
</p>
</html>
"));
end Examples;

package Interfaces "Interfaces for media models"

  extends Modelica.Icons.InterfacesPackage;
  import SI = Modelica.SIunits;

  partial package TemplateMedium "Template for media models"
    /* For a new medium, make a copy of this package and remove
     the "partial" keyword from the package definition above.
     The statement below extends from PartialMedium and sets some
     package constants. Provide values for these constants
     that are appropriate for your medium model. Note that other
     constants (such as nX, nXi) are automatically defined by
     definitions given in the base class Interfaces.PartialMedium"
  */
    extends Modelica.Media.Interfaces.PartialMedium(
      final mediumName =   "NameOfMedium",
      final substanceNames={mediumName},
      final singleState=false,
      final reducedX =  true,
      final fixedX = true,
      Temperature(min=273, max=450, start=323));

      // Provide medium constants here
      constant SpecificHeatCapacity cp_const = 123456
      "Constant specific heat capacity at constant pressure";

      /* The vector substanceNames is mandatory, as the number of
         substances is determined based on its size. Here we assume
         a single-component medium.
         singleState is true if u and d do not depend on pressure, but only
         on a thermal variable (temperature or enthalpy). Otherwise, set it
         to false.
         For a single-substance medium, just set reducedX and fixedX to true, and there's
         no need to bother about medium compositions at all. Otherwise, set
         final reducedX = true if the medium model has nS-1 independent mass
         fraction, or reducedX = false if the medium model has nS independent
         mass fractions (nS = number of substances).
         If a mixture has a fixed composition set fixedX=true, otherwise false.
         The modifiers for reducedX and fixedX should normally be final
         since the other equations are based on these values.

         It is also possible to redeclare the min, max, and start attributes of
         Medium types, defined in the base class Interfaces.PartialMedium
         (the example of Temperature is shown here). Min and max attributes
         should be set in accordance to the limits of validity of the medium
         model, while the start attribute should be a reasonable default value
         for the initialization of nonlinear solver iterations */

    /* Provide an implementation of model BaseProperties,
     that is defined in PartialMedium. Select two independent
     variables from p, T, d, u, h. The other independent
     variables are the mass fractions "Xi", if there is more
     than one substance. Provide 3 equations to obtain the remaining
     variables as functions of the independent variables.
     It is also necessary to provide two additional equations to set
     the gas constant R and the molar mass MM of the medium.
     Finally, the thermodynamic state vector, defined in the base class
     Interfaces.PartialMedium.BaseProperties, should be set, according to
     its definition (see ThermodynamicState below).
     The computation of vector X[nX] from Xi[nXi] is already included in
     the base class Interfaces.PartialMedium.BaseProperties, so it should not
     be repeated here.
     The code fragment below is for a single-substance medium with
     p,T as independent variables.
  */

    redeclare model extends BaseProperties(final standardOrderComponents=true)
      "Base properties of medium"

    equation
      d = 1;
      h = cp_const*T;
      u = h - p/d;
      MM = 0.024;
      R  = 8.3144/MM;
      state.p = p;
      state.T = T;
    end BaseProperties;

    /* Provide implementations of the following optional properties.
     If not available, delete the corresponding function.
     The record "ThermodynamicState" contains the input arguments
     of all the function and is defined together with the used
     type definitions in PartialMedium. The record most often contains two of the
     variables "p, T, d, h" (e.g., medium.T)
  */
    redeclare replaceable record ThermodynamicState
      "a selction of variables that uniquely defines the thermodynamic state"
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
      annotation (Documentation(info="<html>

</html>"));
    end ThermodynamicState;

    redeclare function extends dynamicViscosity "Return dynamic viscosity"
    algorithm
      eta := 10 - state.T*0.3 + state.p*0.2;
      annotation (Documentation(info="<html>

</html>"));
    end dynamicViscosity;

    redeclare function extends thermalConductivity
      "Return thermal conductivity"
    algorithm
      lambda := 0;
      annotation (Documentation(info="<html>

</html>"));
    end thermalConductivity;

    redeclare function extends specificEntropy "Return specific entropy"
    algorithm
      s := 0;
      annotation (Documentation(info="<html>

</html>"));
    end specificEntropy;

    redeclare function extends specificHeatCapacityCp
      "Return specific heat capacity at constant pressure"
    algorithm
      cp := 0;
      annotation (Documentation(info="<html>

</html>"));
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv
      "Return specific heat capacity at constant volume"
    algorithm
      cv := 0;
      annotation (Documentation(info="<html>

</html>"));
    end specificHeatCapacityCv;

    redeclare function extends isentropicExponent "Return isentropic exponent"
      extends Modelica.Icons.Function;
    algorithm
       gamma := 1;
      annotation (Documentation(info="<html>

</html>"));
    end isentropicExponent;

    redeclare function extends velocityOfSound "Return velocity of sound"
      extends Modelica.Icons.Function;
    algorithm
      a := 0;
      annotation (Documentation(info="<html>

</html>"));
    end velocityOfSound;

    annotation (Documentation(info="<HTML>
<p>
This package is a <b>template</b> for <b>new medium</b> models. For a new
medium model just make a copy of this package, remove the
\"partial\" keyword from the package and provide
the information that is requested in the comments of the
Modelica source.
</p>
</HTML>"));
  end TemplateMedium;

  partial package PartialMedium
    "Partial medium properties (base package of all media packages)"

    import SI = Modelica.SIunits;
    extends Modelica.Icons.MaterialPropertiesPackage;

    // Constants to be set in Medium
    constant
      Modelica.Media.Interfaces.PartialMedium.Choices.IndependentVariables
      ThermoStates "Enumeration type for independent variables";
    constant String mediumName = "unusablePartialMedium" "Name of the medium";
    constant String substanceNames[:]={mediumName}
      "Names of the mixture substances. Set substanceNames={mediumName} if only one substance.";
    constant String extraPropertiesNames[:]=fill("", 0)
      "Names of the additional (extra) transported properties. Set extraPropertiesNames=fill(\"\",0) if unused";
    constant Boolean singleState
      "= true, if u and d are not a function of pressure";
    constant Boolean reducedX=true
      "= true if medium contains the equation sum(X) = 1.0; set reducedX=true if only one substance (see docu for details)";
    constant Boolean fixedX=false
      "= true if medium contains the equation X = reference_X";
    constant AbsolutePressure reference_p=101325
      "Reference pressure of Medium: default 1 atmosphere";
    constant Temperature reference_T=298.15
      "Reference temperature of Medium: default 25 deg Celsius";
    constant MassFraction reference_X[nX]= fill(1/nX, nX)
      "Default mass fractions of medium";
    constant AbsolutePressure p_default=101325
      "Default value for pressure of medium (for initialization)";
    constant Temperature T_default = Modelica.SIunits.Conversions.from_degC(20)
      "Default value for temperature of medium (for initialization)";
    constant SpecificEnthalpy h_default = specificEnthalpy_pTX(p_default, T_default, X_default)
      "Default value for specific enthalpy of medium (for initialization)";
    constant MassFraction X_default[nX]=reference_X
      "Default value for mass fractions of medium (for initialization)";

    final constant Integer nS=size(substanceNames, 1) "Number of substances" annotation(Evaluate=true);
    constant Integer nX = nS "Number of mass fractions"
                                 annotation(Evaluate=true);
    constant Integer nXi=if fixedX then 0 else if reducedX then nS - 1 else nS
      "Number of structurally independent mass fractions (see docu for details)"
      annotation(Evaluate=true);

    final constant Integer nC=size(extraPropertiesNames, 1)
      "Number of extra (outside of standard mass-balance) transported properties"
     annotation(Evaluate=true);
    constant Real C_nominal[nC](min=fill(Modelica.Constants.eps, nC)) = 1.0e-6*ones(nC)
      "Default for the nominal values for the extra properties";
    replaceable record FluidConstants
      "critical, triple, molecular and other standard data of fluid"
      extends Modelica.Icons.Record;
      String iupacName "complete IUPAC name (or common name, if non-existent)";
      String casRegistryNumber
        "chemical abstracts sequencing number (if it exists)";
      String chemicalFormula
        "Chemical formula, (brutto, nomenclature according to Hill";
      String structureFormula "Chemical structure formula";
      MolarMass molarMass "molar mass";
    end FluidConstants;

    replaceable record ThermodynamicState
      "Minimal variable set that is available as input argument to every medium function"
      extends Modelica.Icons.Record;
    end ThermodynamicState;

    replaceable partial model BaseProperties
      "Base properties (p, d, T, h, u, R, MM and, if applicable, X and Xi) of a medium"
      InputAbsolutePressure p "Absolute pressure of medium";
      InputMassFraction[nXi] Xi(start=reference_X[1:nXi])
        "Structurally independent mass fractions";
      InputSpecificEnthalpy h "Specific enthalpy of medium";
      Density d "Density of medium";
      Temperature T "Temperature of medium";
      MassFraction[nX] X(start=reference_X)
        "Mass fractions (= (component mass)/total mass  m_i/m)";
      SpecificInternalEnergy u "Specific internal energy of medium";
      SpecificHeatCapacity R "Gas constant (of mixture if applicable)";
      MolarMass MM "Molar mass (of mixture or single fluid)";
      ThermodynamicState state
        "thermodynamic state record for optional functions";
      parameter Boolean preferredMediumStates=false
        "= true if StateSelect.prefer shall be used for the independent property variables of the medium"
        annotation (Evaluate=true, Dialog(tab="Advanced"));
      parameter Boolean standardOrderComponents = true
        "if true, and reducedX = true, the last element of X will be computed from the other ones";
      SI.Conversions.NonSIunits.Temperature_degC T_degC=
          Modelica.SIunits.Conversions.to_degC(T)
        "Temperature of medium in [degC]";
      SI.Conversions.NonSIunits.Pressure_bar p_bar=
       Modelica.SIunits.Conversions.to_bar(p)
        "Absolute pressure of medium in [bar]";

      // Local connector definition, used for equation balancing check
      connector InputAbsolutePressure = input SI.AbsolutePressure
        "Pressure as input signal connector";
      connector InputSpecificEnthalpy = input SI.SpecificEnthalpy
        "Specific enthalpy as input signal connector";
      connector InputMassFraction = input SI.MassFraction
        "Mass fraction as input signal connector";

    equation
      if standardOrderComponents then
        Xi = X[1:nXi];

          if fixedX then
            X = reference_X;
          end if;
          if reducedX and not fixedX then
            X[nX] = 1 - sum(Xi);
          end if;
          for i in 1:nX loop
            assert(X[i] >= -1.e-5 and X[i] <= 1 + 1.e-5, "Mass fraction X[" +
                   String(i) + "] = " + String(X[i]) + "of substance "
                   + substanceNames[i] + "\nof medium " + mediumName + " is not in the range 0..1");
          end for;

      end if;

      assert(p >= 0.0, "Pressure (= " + String(p) + " Pa) of medium \"" +
        mediumName + "\" is negative\n(Temperature = " + String(T) + " K)");
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}), Text(
              extent={{-152,164},{152,102}},
              textString="%name",
              lineColor={0,0,255})}),
                  Documentation(info="<html>
<p>
Model <b>BaseProperties</b> is a model within package <b>PartialMedium</b>
and contains the <b>declarations</b> of the minimum number of
variables that every medium model is supposed to support.
A specific medium inherits from model <b>BaseProperties</b> and provides
the equations for the basic properties.</p>
<p>
The BaseProperties model contains the following <b>7+nXi variables</b>
(nXi is the number of independent mass fractions defined in package
PartialMedium):
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Variable</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">T</td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">temperature</td></tr>
  <tr><td valign=\"top\">p</td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">absolute pressure</td></tr>
  <tr><td valign=\"top\">d</td>
      <td valign=\"top\">kg/m3</td>
      <td valign=\"top\">density</td></tr>
  <tr><td valign=\"top\">h</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific enthalpy</td></tr>
  <tr><td valign=\"top\">u</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific internal energy</td></tr>
  <tr><td valign=\"top\">Xi[nXi]</td>
      <td valign=\"top\">kg/kg</td>
      <td valign=\"top\">independent mass fractions m_i/m</td></tr>
  <tr><td valign=\"top\">R</td>
      <td valign=\"top\">J/kg.K</td>
      <td valign=\"top\">gas constant</td></tr>
  <tr><td valign=\"top\">M</td>
      <td valign=\"top\">kg/mol</td>
      <td valign=\"top\">molar mass</td></tr>
</table>
<p>
In order to implement an actual medium model, one can extend from this
base model and add <b>5 equations</b> that provide relations among
these variables. Equations will also have to be added in order to
set all the variables within the ThermodynamicState record state.</p>
<p>
If standardOrderComponents=true, the full composition vector X[nX]
is determined by the equations contained in this base class, depending
on the independent mass fraction vector Xi[nXi].</p>
<p>Additional <b>2 + nXi</b> equations will have to be provided
when using the BaseProperties model, in order to fully specify the
thermodynamic conditions. The input connector qualifier applied to
p, h, and nXi indirectly declares the number of missing equations,
permitting advanced equation balance checking by Modelica tools.
Please note that this doesn't mean that the additional equations
should be connection equations, nor that exactly those variables
should be supplied, in order to complete the model.
For further information, see the Modelica.Media User's guide, and
Section 4.7 (Balanced Models) of the Modelica 3.0 specification.</p>
</html>"));
    end BaseProperties;

    replaceable partial function setState_pTX
      "Return thermodynamic state as function of p, T and composition X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "thermodynamic state record";
    end setState_pTX;

    replaceable partial function setState_phX
      "Return thermodynamic state as function of p, h and composition X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "thermodynamic state record";
    end setState_phX;

    replaceable partial function setState_psX
      "Return thermodynamic state as function of p, s and composition X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "thermodynamic state record";
    end setState_psX;

    replaceable partial function setState_dTX
      "Return thermodynamic state as function of d, T and composition X or Xi"
      extends Modelica.Icons.Function;
      input Density d "density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "thermodynamic state record";
    end setState_dTX;

    replaceable partial function setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
      extends Modelica.Icons.Function;
      input Real x "m_flow or dp";
      input ThermodynamicState state_a "Thermodynamic state if x > 0";
      input ThermodynamicState state_b "Thermodynamic state if x < 0";
      input Real x_small(min=0)
        "Smooth transition in the region -x_small < x < x_small";
      output ThermodynamicState state
        "Smooth thermodynamic state for all x (continuous and differentiable)";
      annotation(Documentation(info="<html>
<p>
This function is used to approximate the equation
</p>
<pre>
    state = <b>if</b> x &gt; 0 <b>then</b> state_a <b>else</b> state_b;
</pre>

<p>
by a smooth characteristic, so that the expression is continuous and differentiable:
</p>

<pre>
   state := <b>smooth</b>(1, <b>if</b> x &gt;  x_small <b>then</b> state_a <b>else</b>
                      <b>if</b> x &lt; -x_small <b>then</b> state_b <b>else</b> f(state_a, state_b));
</pre>

<p>
This is performed by applying function <b>Media.Common.smoothStep</b>(..)
on every element of the thermodynamic state record.
</p>

<p>
If <b>mass fractions</b> X[:] are approximated with this function then this can be performed
for all <b>nX</b> mass fractions, instead of applying it for nX-1 mass fractions and computing
the last one by the mass fraction constraint sum(X)=1. The reason is that the approximating function has the
property that sum(state.X) = 1, provided sum(state_a.X) = sum(state_b.X) = 1.
This can be shown by evaluating the approximating function in the abs(x) &lt; x_small
region (otherwise state.X is either state_a.X or state_b.X):
</p>

<pre>
    X[1]  = smoothStep(x, X_a[1] , X_b[1] , x_small);
    X[2]  = smoothStep(x, X_a[2] , X_b[2] , x_small);
       ...
    X[nX] = smoothStep(x, X_a[nX], X_b[nX], x_small);
</pre>

<p>
or
</p>

<pre>
    X[1]  = c*(X_a[1]  - X_b[1])  + (X_a[1]  + X_b[1])/2
    X[2]  = c*(X_a[2]  - X_b[2])  + (X_a[2]  + X_b[2])/2;
       ...
    X[nX] = c*(X_a[nX] - X_b[nX]) + (X_a[nX] + X_b[nX])/2;
    c     = (x/x_small)*((x/x_small)^2 - 3)/4
</pre>

<p>
Summing all mass fractions together results in
</p>

<pre>
    sum(X) = c*(sum(X_a) - sum(X_b)) + (sum(X_a) + sum(X_b))/2
           = c*(1 - 1) + (1 + 1)/2
           = 1
</pre>

</html>"));
    end setSmoothState;

    replaceable partial function dynamicViscosity "Return dynamic viscosity"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output DynamicViscosity eta "Dynamic viscosity";
    end dynamicViscosity;

    replaceable partial function thermalConductivity
      "Return thermal conductivity"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output ThermalConductivity lambda "Thermal conductivity";
    end thermalConductivity;

    replaceable function prandtlNumber "Return the Prandtl number"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output PrandtlNumber Pr "Prandtl number";
    algorithm
      Pr := dynamicViscosity(state)*specificHeatCapacityCp(state)/thermalConductivity(
        state);
    end prandtlNumber;

    replaceable partial function pressure "Return pressure"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output AbsolutePressure p "Pressure";
    end pressure;

    replaceable partial function temperature "Return temperature"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output Temperature T "Temperature";
    end temperature;

    replaceable partial function density "Return density"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output Density d "Density";
    end density;

    replaceable partial function specificEnthalpy "Return specific enthalpy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output SpecificEnthalpy h "Specific enthalpy";
    end specificEnthalpy;

    replaceable partial function specificInternalEnergy
      "Return specific internal energy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output SpecificEnergy u "Specific internal energy";
    end specificInternalEnergy;

    replaceable partial function specificEntropy "Return specific entropy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output SpecificEntropy s "Specific entropy";
    end specificEntropy;

    replaceable partial function specificGibbsEnergy
      "Return specific Gibbs energy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output SpecificEnergy g "Specific Gibbs energy";
    end specificGibbsEnergy;

    replaceable partial function specificHelmholtzEnergy
      "Return specific Helmholtz energy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output SpecificEnergy f "Specific Helmholtz energy";
    end specificHelmholtzEnergy;

    replaceable partial function specificHeatCapacityCp
      "Return specific heat capacity at constant pressure"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output SpecificHeatCapacity cp
        "Specific heat capacity at constant pressure";
    end specificHeatCapacityCp;

    function heatCapacity_cp = specificHeatCapacityCp
      "alias for deprecated name";

    replaceable partial function specificHeatCapacityCv
      "Return specific heat capacity at constant volume"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output SpecificHeatCapacity cv
        "Specific heat capacity at constant volume";
    end specificHeatCapacityCv;

    function heatCapacity_cv = specificHeatCapacityCv
      "alias for deprecated name";

    replaceable partial function isentropicExponent
      "Return isentropic exponent"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output IsentropicExponent gamma "Isentropic exponent";
    end isentropicExponent;

    replaceable partial function isentropicEnthalpy
      "Return isentropic enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p_downstream "downstream pressure";
      input ThermodynamicState refState "reference state for entropy";
      output SpecificEnthalpy h_is "Isentropic enthalpy";
      annotation(Documentation(info="<html>
<p>
This function computes an isentropic state transformation:
</p>
<ol>
<li> A medium is in a particular state, refState.</li>
<li> The enhalpy at another state (h_is) shall be computed
     under the assumption that the state transformation from refState to h_is
     is performed with a change of specific entropy ds = 0 and the pressure of state h_is
     is p_downstream and the composition X upstream and downstream is assumed to be the same.</li>
</ol>

</html>"));
    end isentropicEnthalpy;

    replaceable partial function velocityOfSound "Return velocity of sound"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output VelocityOfSound a "Velocity of sound";
    end velocityOfSound;

    replaceable partial function isobaricExpansionCoefficient
      "Return overall the isobaric expansion coefficient beta"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output IsobaricExpansionCoefficient beta "Isobaric expansion coefficient";
      annotation(Documentation(info="<html>
<pre>
beta is defined as  1/v * der(v,T), with v = 1/d, at constant pressure p.
</pre>
</html>"));
    end isobaricExpansionCoefficient;

    function beta = isobaricExpansionCoefficient
      "alias for isobaricExpansionCoefficient for user convenience";

    replaceable partial function isothermalCompressibility
      "Return overall the isothermal compressibility factor"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output SI.IsothermalCompressibility kappa "Isothermal compressibility";
      annotation(Documentation(info="<html>
<pre>

kappa is defined as - 1/v * der(v,p), with v = 1/d at constant temperature T.

</pre>
</html>"));
    end isothermalCompressibility;

    function kappa = isothermalCompressibility
      "alias of isothermalCompressibility for user convenience";

    // explicit derivative functions for finite element models
    replaceable partial function density_derp_h
      "Return density derivative w.r.t. pressure at const specific enthalpy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output DerDensityByPressure ddph "Density derivative w.r.t. pressure";
    end density_derp_h;

    replaceable partial function density_derh_p
      "Return density derivative w.r.t. specific enthalpy at constant pressure"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output DerDensityByEnthalpy ddhp
        "Density derivative w.r.t. specific enthalpy";
    end density_derh_p;

    replaceable partial function density_derp_T
      "Return density derivative w.r.t. pressure at const temperature"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output DerDensityByPressure ddpT "Density derivative w.r.t. pressure";
    end density_derp_T;

    replaceable partial function density_derT_p
      "Return density derivative w.r.t. temperature at constant pressure"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output DerDensityByTemperature ddTp
        "Density derivative w.r.t. temperature";
    end density_derT_p;

    replaceable partial function density_derX
      "Return density derivative w.r.t. mass fraction"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output Density[nX] dddX "Derivative of density w.r.t. mass fraction";
    end density_derX;

    replaceable partial function molarMass
      "Return the molar mass of the medium"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state record";
      output MolarMass MM "Mixture molar mass";
    end molarMass;

    replaceable function specificEnthalpy_pTX
      "Return specific enthalpy from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy(setState_pTX(p,T,X));
      annotation(inverse(T = temperature_phX(p,h,X)));
    end specificEnthalpy_pTX;

    replaceable function specificEntropy_pTX
      "Return specific enthalpy from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output SpecificEntropy s "Specific entropy";
    algorithm
      s := specificEntropy(setState_pTX(p,T,X));

      annotation(inverse(T = temperature_psX(p,s,X)));
    end specificEntropy_pTX;

    replaceable function density_pTX "Return density from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:] "Mass fractions";
      output Density d "Density";
    algorithm
      d := density(setState_pTX(p,T,X));
    end density_pTX;

    replaceable function temperature_phX
      "Return temperature from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output Temperature T "Temperature";
    algorithm
      T := temperature(setState_phX(p,h,X));
    end temperature_phX;

    replaceable function density_phX "Return density from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output Density d "Density";
    algorithm
      d := density(setState_phX(p,h,X));
    end density_phX;

    replaceable function temperature_psX
      "Return temperature from p,s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output Temperature T "Temperature";
    algorithm
      T := temperature(setState_psX(p,s,X));
      annotation(inverse(s = specificEntropy_pTX(p,T,X)));
    end temperature_psX;

    replaceable function density_psX "Return density from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output Density d "Density";
    algorithm
      d := density(setState_psX(p,s,X));
    end density_psX;

    replaceable function specificEnthalpy_psX
      "Return specific enthalpy from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy(setState_psX(p,s,X));
    end specificEnthalpy_psX;

    type AbsolutePressure = SI.AbsolutePressure (
        min=0,
        max=1.e8,
        nominal=1.e5,
        start=1.e5)
      "Type for absolute pressure with medium specific attributes";

    type Density = SI.Density (
        min=0,
        max=1.e5,
        nominal=1,
        start=1) "Type for density with medium specific attributes";
    type DynamicViscosity = SI.DynamicViscosity (
        min=0,
        max=1.e8,
        nominal=1.e-3,
        start=1.e-3)
      "Type for dynamic viscosity with medium specific attributes";
    type EnthalpyFlowRate = SI.EnthalpyFlowRate (
        nominal=1000.0,
        min=-1.0e8,
        max=1.e8) "Type for enthalpy flow rate with medium specific attributes";
    type MassFlowRate = SI.MassFlowRate (
        quantity="MassFlowRate." + mediumName,
        min=-1.0e5,
        max=1.e5) "Type for mass flow rate with medium specific attributes";
    type MassFraction = Real (
        quantity="MassFraction",
        final unit="kg/kg",
        min=0,
        max=1,
        nominal=0.1) "Type for mass fraction with medium specific attributes";
    type MoleFraction = Real (
        quantity="MoleFraction",
        final unit="mol/mol",
        min=0,
        max=1,
        nominal=0.1) "Type for mole fraction with medium specific attributes";
    type MolarMass = SI.MolarMass (
        min=0.001,
        max=0.25,
        nominal=0.032) "Type for molar mass with medium specific attributes";
    type MolarVolume = SI.MolarVolume (
        min=1e-6,
        max=1.0e6,
        nominal=1.0) "Type for molar volume with medium specific attributes";
    type IsentropicExponent = SI.RatioOfSpecificHeatCapacities (
        min=1,
        max=500000,
        nominal=1.2,
        start=1.2)
      "Type for isentropic exponent with medium specific attributes";
    type SpecificEnergy = SI.SpecificEnergy (
        min=-1.0e8,
        max=1.e8,
        nominal=1.e6)
      "Type for specific energy with medium specific attributes";
    type SpecificInternalEnergy = SpecificEnergy
      "Type for specific internal energy with medium specific attributes";
    type SpecificEnthalpy = SI.SpecificEnthalpy (
        min=-1.0e10,
        max=1.e10,
        nominal=1.e6)
      "Type for specific enthalpy with medium specific attributes";
    type SpecificEntropy = SI.SpecificEntropy (
        min=-1.e7,
        max=1.e7,
        nominal=1.e3)
      "Type for specific entropy with medium specific attributes";
    type SpecificHeatCapacity = SI.SpecificHeatCapacity (
        min=0,
        max=1.e7,
        nominal=1.e3,
        start=1.e3)
      "Type for specific heat capacity with medium specific attributes";
    type SurfaceTension = SI.SurfaceTension
      "Type for surface tension with medium specific attributes";
    type Temperature = SI.Temperature (
        min=1,
        max=1.e4,
        nominal=300,
        start=300) "Type for temperature with medium specific attributes";
    type ThermalConductivity = SI.ThermalConductivity (
        min=0,
        max=500,
        nominal=1,
        start=1)
      "Type for thermal conductivity with medium specific attributes";
    type PrandtlNumber = SI.PrandtlNumber (
        min=1e-3,
        max=1e5,
        nominal=1.0) "Type for Prandtl number with medium specific attributes";
    type VelocityOfSound = SI.Velocity (
        min=0,
        max=1.e5,
        nominal=1000,
        start=1000)
      "Type for velocity of sound with medium specific attributes";
    type ExtraProperty = Real (min=0.0, start=1.0)
      "Type for unspecified, mass-specific property transported by flow";
    type CumulativeExtraProperty = Real (min=0.0, start=1.0)
      "Type for conserved integral of unspecified, mass specific property";
    type ExtraPropertyFlowRate = Real(unit="kg/s")
      "Type for flow rate of unspecified, mass-specific property";
    type IsobaricExpansionCoefficient = Real (
        min=0,
        max=1.0e8,
        unit="1/K")
      "Type for isobaric expansion coefficient with medium specific attributes";
    type DipoleMoment = Real (
        min=0.0,
        max=2.0,
        unit="debye",
        quantity="ElectricDipoleMoment")
      "Type for dipole moment with medium specific attributes";

    type DerDensityByPressure = SI.DerDensityByPressure
      "Type for partial derivative of density with resect to pressure with medium specific attributes";
    type DerDensityByEnthalpy = SI.DerDensityByEnthalpy
      "Type for partial derivative of density with resect to enthalpy with medium specific attributes";
    type DerEnthalpyByPressure = SI.DerEnthalpyByPressure
      "Type for partial derivative of enthalpy with resect to pressure with medium specific attributes";
    type DerDensityByTemperature = SI.DerDensityByTemperature
      "Type for partial derivative of density with resect to temperature with medium specific attributes";

    package Choices "Types, constants to define menu choices"

      type IndependentVariables = enumeration(
          T "Temperature",
          pT "Pressure, Temperature",
          ph "Pressure, Specific Enthalpy",
          phX "Pressure, Specific Enthalpy, Mass Fraction",
          pTX "Pressure, Temperature, Mass Fractions",
          dTX "Density, Temperature, Mass Fractions")
        "Enumeration defining the independent variables of a medium";

      type Init = enumeration(
          NoInit "NoInit (no initialization)",
          InitialStates "InitialStates (initialize medium states)",
          SteadyState "SteadyState (initialize in steady state)",
          SteadyMass
            "SteadyMass (initialize density or pressure in steady state)")
        "Enumeration defining initialization for fluid flow"
                annotation (Evaluate=true);

      type ReferenceEnthalpy = enumeration(
          ZeroAt0K
            "The enthalpy is 0 at 0 K (default), if the enthalpy of formation is excluded",

          ZeroAt25C
            "The enthalpy is 0 at 25 degC, if the enthalpy of formation is excluded",

          UserDefined
            "The user-defined reference enthalpy is used at 293.15 K (25 degC)")
        "Enumeration defining the reference enthalpy of a medium"
          annotation (Evaluate=true);

      type ReferenceEntropy = enumeration(
          ZeroAt0K "The entropy is 0 at 0 K (default)",
          ZeroAt0C "The entropy is 0 at 0 degC",
          UserDefined
            "The user-defined reference entropy is used at 293.15 K (25 degC)")
        "Enumeration defining the reference entropy of a medium"
          annotation (Evaluate=true);

      type pd = enumeration(
          default "Default (no boundary condition for p or d)",
          p_known "p_known (pressure p is known)",
          d_known "d_known (density d is known)")
        "Enumeration defining whether p or d are known for the boundary condition"
          annotation (Evaluate=true);

      type Th = enumeration(
          default "Default (no boundary condition for T or h)",
          T_known "T_known (temperature T is known)",
          h_known "h_known (specific enthalpy h is known)")
        "Enumeration defining whether T or h are known as boundary condition"
          annotation (Evaluate=true);

      annotation (Documentation(info="<html>
<h2>Enumerations and data types for all types of fluids</h2>
<p>Note: Reference enthalpy might have to be extended with enthalpy of formation.</p>
</html>"));
    end Choices;

    annotation (Documentation(info="<html>
<p>
<b>PartialMedium</b> is a package and contains all <b>declarations</b> for
a medium. This means that constants, models, and functions
are defined that every medium is supposed to support
(some of them are optional). A medium package
inherits from <b>PartialMedium</b> and provides the
equations for the medium. The details of this package
are described in
<a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.
</p>
</html>
", revisions="<html>

</html>"));
  end PartialMedium;

  partial package PartialPureSubstance
    "base class for pure substances of one chemical substance"
    extends PartialMedium(final reducedX = true, final fixedX=true);

   replaceable function setState_pT "Return thermodynamic state from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output ThermodynamicState state "thermodynamic state record";
   algorithm
      state := setState_pTX(p,T,fill(0,0));
   end setState_pT;

    replaceable function setState_ph "Return thermodynamic state from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      state := setState_phX(p,h,fill(0, 0));
    end setState_ph;

    replaceable function setState_ps "Return thermodynamic state from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      state := setState_psX(p,s,fill(0,0));
    end setState_ps;

    replaceable function setState_dT "Return thermodynamic state from d and T"
      extends Modelica.Icons.Function;
      input Density d "density";
      input Temperature T "Temperature";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      state := setState_dTX(d,T,fill(0,0));
    end setState_dT;

    replaceable function density_ph "Return density from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output Density d "Density";
    algorithm
      d := density_phX(p, h, fill(0,0));
    end density_ph;

    replaceable function temperature_ph "Return temperature from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output Temperature T "Temperature";
    algorithm
      T := temperature_phX(p, h, fill(0,0));
    end temperature_ph;

    replaceable function pressure_dT "Return pressure from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      output AbsolutePressure p "Pressure";
    algorithm
      p := pressure(setState_dTX(d, T, fill(0,0)));
    end pressure_dT;

    replaceable function specificEnthalpy_dT
      "Return specific enthalpy from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      output SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := specificEnthalpy(setState_dTX(d, T, fill(0,0)));
    end specificEnthalpy_dT;

    replaceable function specificEnthalpy_ps
      "Return specific enthalpy from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := specificEnthalpy_psX(p,s,fill(0,0));
    end specificEnthalpy_ps;

    replaceable function temperature_ps "Return temperature from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output Temperature T "Temperature";
    algorithm
      T := temperature_psX(p,s,fill(0,0));
    end temperature_ps;

    replaceable function density_ps "Return density from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output Density d "Density";
    algorithm
      d := density_psX(p, s, fill(0,0));
    end density_ps;

    replaceable function specificEnthalpy_pT
      "Return specific enthalpy from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := specificEnthalpy_pTX(p, T, fill(0,0));
    end specificEnthalpy_pT;

    replaceable function density_pT "Return density from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output Density d "Density";
    algorithm
      d := density(setState_pTX(p, T, fill(0,0)));
    end density_pT;

    redeclare replaceable partial model extends BaseProperties(
      final standardOrderComponents=true)
    end BaseProperties;
  end PartialPureSubstance;

partial package PartialLinearFluid
    "Generic pure liquid model with constant cp, compressibility and thermal expansion coefficients"

    import Modelica.Media.*;
    import SI = Modelica.SIunits;

      extends Interfaces.PartialPureSubstance(
        ThermoStates = Choices.IndependentVariables.pTX,
        singleState = false);
      constant SpecificHeatCapacity cp_const
      "Specific heat capacity at constant pressure";
      constant IsobaricExpansionCoefficient beta_const
      "Thermal expansion coefficient at constant pressure";
      constant SI.IsothermalCompressibility kappa_const
      "Isothermal compressibility";
      constant MolarMass MM_const "Molar mass";
      constant Density reference_d "Density in reference conditions";
      constant SpecificEnthalpy reference_h
      "Specific enthalpy in reference conditions";
      constant SpecificEntropy reference_s
      "Specific enthalpy in reference conditions";
      constant Boolean constantJacobian
      "if true, entries in thermodynamic Jacobian are constant, taken at reference conditions";

      redeclare record ThermodynamicState
      "a selection of variables that uniquely defines the thermodynamic state"
        AbsolutePressure p "Absolute pressure of medium";
        Temperature T "Temperature of medium";
      end ThermodynamicState;

      redeclare model extends BaseProperties(
        T(stateSelect=if preferredMediumStates then StateSelect.prefer else
                           StateSelect.default),
        p(stateSelect=if preferredMediumStates then StateSelect.prefer else
                           StateSelect.default)) "Base properties of medium"
      equation
        d = (1 + (p-reference_p)*kappa_const - (T-reference_T)*beta_const)*reference_d;
        h = reference_h +
            (T-reference_T)*cp_const +
            (p-reference_p)*(1-beta_const*reference_T)/reference_d;
        u = h - p/d;
        p = state.p;
        T = state.T;
        MM = MM_const;
        R  = 8.3144/MM;
      end BaseProperties;

      redeclare function extends setState_pTX
      "set the thermodynamic state record from p and T (X not needed)"
      algorithm
        state := ThermodynamicState(p=p,T=T);
      end setState_pTX;

      redeclare function extends setState_phX
      "set the thermodynamic state record from p and h (X not needed)"
      algorithm
        state := ThermodynamicState(p=p,
                                    T=(h - reference_h - (p - reference_p)*((1 - beta_const*reference_T)
                                      /reference_d))/cp_const + reference_T);
      end setState_phX;

      redeclare function extends setState_psX
      "set the thermodynamic state record from p and s (X not needed)"
      algorithm
        state := ThermodynamicState(p=p,
                                    T=reference_T*cp_const/(cp_const - s+reference_s +(p-reference_p)*
                                      (-beta_const/reference_d)));
      end setState_psX;

      redeclare function extends setState_dTX
      "set the thermodynamic state record from d and T (X not needed)"
      algorithm
        state := ThermodynamicState(p=((d-reference_d) + (state.T-reference_T)*beta_const*reference_d)
                                      /(reference_d*kappa_const) + reference_p,
                                    T=T);
      end setState_dTX;

      redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
      algorithm
        state := ThermodynamicState(p= Media.Common.smoothStep(x, state_a.p, state_b.p, x_small),
                                    T= Media.Common.smoothStep(x, state_a.T, state_b.T, x_small));
      end setSmoothState;

      redeclare function extends pressure
      "Return the pressure from the thermodynamic state"
      algorithm
        p :=state.p;
      end pressure;

      redeclare function extends temperature
      "Return the temperature from the thermodynamic state"
      algorithm
        T :=state.T;
      end temperature;

      redeclare function extends density
      "Return the density from the thermodynamic state"
      algorithm
        d := (1 + (state.p-reference_p)*kappa_const - (state.T-reference_T)*beta_const)*reference_d;
      end density;

      redeclare function extends specificEnthalpy
      "Return the specific enthalpy from the thermodynamic state"
      algorithm
      h := reference_h +
          (state.T-reference_T)*cp_const +
          (state.p-reference_p)*(1-beta_const*reference_T)/reference_d;
      end specificEnthalpy;

      redeclare function extends specificEntropy
      "Return the specific entropy from the thermodynamic state"
      algorithm
      s := reference_s +
          (state.T-reference_T)*cp_const/state.T +
          (state.p-reference_p)*(-beta_const/reference_d);
      end specificEntropy;

      redeclare function extends specificInternalEnergy
      "Return the specific internal energy from the thermodynamic state"
      algorithm
        u := specificEnthalpy(state)-state.p/reference_d;
      end specificInternalEnergy;

      redeclare function extends specificGibbsEnergy
      "Return specific Gibbs energy from the thermodynamic state"
        extends Modelica.Icons.Function;
      algorithm
        g := specificEnthalpy(state) - state.T*specificEntropy(state);
      end specificGibbsEnergy;

      redeclare function extends specificHelmholtzEnergy
      "Return specific Helmholtz energy from the thermodynamic state"
        extends Modelica.Icons.Function;
      algorithm
        f := specificInternalEnergy(state) - state.T*specificEntropy(state);
      end specificHelmholtzEnergy;

      redeclare function extends velocityOfSound
      "Return velocity of sound from the thermodynamic state"
        extends Modelica.Icons.Function;
      algorithm
        a := sqrt(max(0,1/(kappa_const*density(state) -beta_const*beta_const*state.T/cp_const)));
      end velocityOfSound;

      redeclare function extends isentropicExponent
      "Return isentropic exponent from the thermodynamic state"
        extends Modelica.Icons.Function;
      algorithm
       gamma := 1/(state.p*kappa_const)*cp_const/specificHeatCapacityCv(state);
      end isentropicExponent;

    redeclare function extends isentropicEnthalpy "Return isentropic enthalpy"

    /* Previous wrong equation:

protected
  SpecificEntropy s_upstream = specificEntropy(refState)
    "specific entropy at component inlet";
  ThermodynamicState downstreamState "state at downstream location";
algorithm
  downstreamState.p := p_downstream;
  downstreamState.T := reference_T*cp_const/
    (s_upstream -reference_s -(p_downstream-reference_p)*(-beta_const/reference_d) - cp_const);
  h_is := specificEnthalpy(downstreamState);
*/
    algorithm
      /* s := reference_s + (refState.T-reference_T)*cp_const/refState.T +
                        (refState.p-reference_p)*(-beta_const/reference_d)
        = reference_s + (state.T-reference_T)*cp_const/state.T +
                        (p_downstream-reference_p)*(-beta_const/reference_d);

      (state.T-reference_T)*cp_const/state.T
     = (refState.T-reference_T)*cp_const/refState.T + (refState.p-reference_p)*(-beta_const/reference_d)
       - (p_downstream-reference_p)*(-beta_const/reference_d)
     = (refState.T-reference_T)*cp_const/refState.T + (refState.p-p_downstream)*(-beta_const/reference_d)

     (x - reference_T)/x = k
     x - reference_T = k*x
     (1-k)*x = reference_T
     x = reference_T/(1-k);

     state.T = reference_T/(1 - ((refState.T-reference_T)*cp_const/refState.T + (refState.p-p_downstream)*(-beta_const/reference_d))/cp_const)
  */

      h_is :=specificEnthalpy(setState_pTX(
        p_downstream,
        reference_T/(1 - ( (refState.T - reference_T)/refState.T +
                           (refState.p - p_downstream)*(-beta_const/(reference_d*cp_const)))),
        reference_X));
      annotation (Documentation(info="<html>
<p>
A minor approximation is used: the reference density is used instead of the real
one, which would require a numeric solution.
</p>
</html>"));
    end isentropicEnthalpy;

      redeclare function extends specificHeatCapacityCp
      "Return specific heat capacity at constant volume"
      algorithm
        cp := cp_const;
      end specificHeatCapacityCp;

      redeclare function extends specificHeatCapacityCv
      "Return specific heat capacity at constant volume from the thermodynamic state"
      algorithm
        cv := if constantJacobian then cp_const - reference_T*beta_const*beta_const/(kappa_const*reference_d) else
              state.T*beta_const*beta_const/(kappa_const*reference_d);
      end specificHeatCapacityCv;

      redeclare function extends isothermalCompressibility
      "Return the iso-thermal compressibility kappa"
      algorithm
        kappa := kappa_const;
      end isothermalCompressibility;

      redeclare function extends isobaricExpansionCoefficient
      "Return the iso-baric expansion coefficient"
      algorithm
        beta := beta_const;
      end isobaricExpansionCoefficient;

      redeclare function extends density_derp_h
      "Return density derivative w.r.t. pressure at const specific enthalpy"
      algorithm
        ddph := if constantJacobian then kappa_const*reference_d +
          (beta_const*(1-reference_T*beta_const))/cp_const else
              kappa_const*density(state) +
           (beta_const*(1-temperature(state)*beta_const))/cp_const;
      end density_derp_h;

      redeclare function extends density_derh_p
      "Return density derivative w.r.t. specific enthalpy at constant pressure"
      algorithm
      ddhp := if constantJacobian then -beta_const*reference_d/cp_const else
              -beta_const*density(state)/cp_const;
      end density_derh_p;

      redeclare function extends density_derp_T
      "Return density derivative w.r.t. pressure at const temperature"
      algorithm
        ddpT := if constantJacobian then kappa_const*reference_d else
              kappa_const*density(state);
      end density_derp_T;

      redeclare function extends density_derT_p
      "Return density derivative w.r.t. temperature at constant pressure"
      algorithm
        ddTp := if constantJacobian then -beta_const*reference_d else
             -beta_const*density(state);
      end density_derT_p;

  redeclare function extends density_derX
      "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature"
  algorithm
    dddX := fill(0,nX);
  end density_derX;

      redeclare function extends molarMass "Return molar mass"
      algorithm
        MM  := MM_const;
      end molarMass;

      function T_ph "Return temperature from pressure and specific enthalpy"
        input SpecificEnthalpy h "Specific enthalpy";
        input AbsolutePressure p "pressure";
        output Temperature T "Temperature";
      algorithm
        T :=(h - reference_h - (p - reference_p)*((1 - beta_const*reference_T)
          /reference_d))/cp_const + reference_T;
      end T_ph;

      function T_ps "Return temperature from pressure and specific entropy"
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        output Temperature T "Temperature";
      algorithm
        T := reference_T*cp_const/(s-reference_s -(p-reference_p)*(-beta_const/reference_d) - cp_const);
      end T_ps;

  annotation (Documentation(info="<html>
<h4>Linear Compressibility Fluid Model</h4>
<p>This linear compressibility fluid model is based on the assumptions that:
</p>
<ul>
<li>The specific heat capacity at constant pressure (cp) is constant</li>
<li>The isobaric expansion coefficient (beta) is constant</li>
<li>The isothermal compressibility (kappa) is constant</li>
<li>Pressure and temperature are used as states</li>
<li>The influence of density on specific enthalpy (h), entropy (s), inner energy (u) and heat capacity (cv) at constant volume is neglected.
</ul>
<p>
That means that the density is a linear function in temperature and in pressure.
In order to define the complete model, a number of constant reference values are needed which
are computed at the reference values of the states pressure p and temperature T. The model can
be interprested as a linearization of a full non-linear fluid model (but it is not linear in all
thermodynamic coordinates). Reference values are needed for
</p>
<ol>
<li>the density (reference_d),</li>
<li>the specific enthalpy (reference_h),</li>
<li>the specific entropy (reference_s).</li>
</ol>
<p>
Apart from that, a user needs to define the molar mass, MM_const.
Note that it is possible to define a fluid by computing the reference
values from a full non-linear fluid model by computing the package constants
using the standard functions defined in a fluid package (see example in liquids package).
</p>
<p>
In order to avoid numerical inversion of the temperature in the T_ph and T_ps functions, the density
is always taken to be the reference density in the computation of h, s, u and cv. For liquids (and this
model is intended only for liquids) the relative error of doing so is 1e-3 to 1e-4 at most. The model would
be more \"correct\" based on the other assumptions, if occurences of reference_d in the computations of h,s,u
and cv would be replaced by a call to density(state). That would require a numerical solution for T_ps, while T_ph can be solved symbolicallyfrom a quadratic function. Errors from this approximation are small because liquid density varies little.</p>
<h4>Efficiency considerations</h4>
<p>One of the main reasons to use a simple, linear fluid model is to achieve high performance
in simulations. There are a number of possible compromises and possibilities to improve performance.
Some of them can be influenced by a flag. The following rules where used in this model:</p>
<ul>
<li>All forward evaluations (using the ThermodynamicState record as input) are exactly following
the assumptions above.</li>
<li>If the flag <b>constantJacobian</b> is set to true in the package, all functions that
typically appear in thermodynamic jacobians (specificHeatCapacityCv, density_derp_h, density_derh_p,
density_derp_T, density_derT_p) are evaluated at reference conditions (that means using the reference
density) instead of the density of the current pressure and temperature. This makes it possible to evaluate
the thermodynamic jacobian at compile time.</li>
<li>For inverse functions using other inputs than the states (e.g pressure p and specific enthalpy h),
the inversion is using the reference state whenever that is necessary to achieve a symbolic inversion.</li>
<li>If <b>constantJacobian</b> is set to false, the above list of functions is computed exactly according
to the above list of assumptions</li>
</ul>
<dl> <b>Authors:</b>
<dd>Francesco Casella<br>
    Dipartimento di Elettronica e Informazione<br>
    Politecnico di Milano<br>
    Via Ponzio 34/5<br>
    I-20133 Milano, Italy<br>
    email: <A HREF=\"mailto:casella@elet.polimi.it\">casella@elet.polimi.it</A><br>
    and <br>
    Hubertus Tummescheit<br>
    Modelon AB<br>
    Ideon Science Park<br>
    SE-22730 Lund, Sweden<br>
    email: <A HREF=\"mailto:Hubertus.Tummescheit@Modelon.se\">Hubertus.Tummescheit@Modelon.se</A><br>

</dd>
</dl>
</html>"));
end PartialLinearFluid;

partial package PartialMixtureMedium
    "Base class for pure substances of several chemical substances"
    extends PartialMedium;

    redeclare replaceable record extends ThermodynamicState
      "thermodynamic state variables"
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
      MassFraction X[nX]
        "Mass fractions (= (component mass)/total mass  m_i/m)";
    end ThermodynamicState;

    redeclare replaceable record extends FluidConstants
      "extended fluid constants"
      Temperature criticalTemperature "critical temperature";
      AbsolutePressure criticalPressure "critical pressure";
      MolarVolume criticalMolarVolume "critical molar Volume";
      Real acentricFactor "Pitzer acentric factor";
      Temperature triplePointTemperature "triple point temperature";
      AbsolutePressure triplePointPressure "triple point pressure";
      Temperature meltingPoint "melting point at 101325 Pa";
      Temperature normalBoilingPoint "normal boiling point (at 101325 Pa)";
      DipoleMoment dipoleMoment
        "dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
      Boolean hasIdealGasHeatCapacity=false
        "true if ideal gas heat capacity is available";
      Boolean hasCriticalData=false "true if critical data are known";
      Boolean hasDipoleMoment=false "true if a dipole moment known";
      Boolean hasFundamentalEquation=false "true if a fundamental equation";
      Boolean hasLiquidHeatCapacity=false
        "true if liquid heat capacity is available";
      Boolean hasSolidHeatCapacity=false
        "true if solid heat capacity is available";
      Boolean hasAccurateViscosityData=false
        "true if accurate data for a viscosity function is available";
      Boolean hasAccurateConductivityData=false
        "true if accurate data for thermal conductivity is available";
      Boolean hasVapourPressureCurve=false
        "true if vapour pressure data, e.g., Antoine coefficents are known";
      Boolean hasAcentricFactor=false
        "true if Pitzer accentric factor is known";
      SpecificEnthalpy HCRIT0=0.0
        "Critical specific enthalpy of the fundamental equation";
      SpecificEntropy SCRIT0=0.0
        "Critical specific entropy of the fundamental equation";
      SpecificEnthalpy deltah=0.0
        "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
      SpecificEntropy deltas=0.0
        "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
    end FluidConstants;

  constant FluidConstants[nS] fluidConstants "constant data for the fluid";

  replaceable function gasConstant
      "Return the gas constant of the mixture (also for liquids)"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state";
      output SI.SpecificHeatCapacity R "mixture gas constant";
  end gasConstant;

    function moleToMassFractions "Return mass fractions X from mole fractions"
      extends Modelica.Icons.Function;
      input SI.MoleFraction moleFractions[:] "Mole fractions of mixture";
      input MolarMass[:] MMX "molar masses of components";
      output SI.MassFraction X[size(moleFractions, 1)]
        "Mass fractions of gas mixture";
    protected
      MolarMass Mmix =  moleFractions*MMX "molar mass of mixture";
    algorithm
      for i in 1:size(moleFractions, 1) loop
        X[i] := moleFractions[i]*MMX[i] /Mmix;
      end for;
      annotation(smoothOrder=5);
    end moleToMassFractions;

    function massToMoleFractions "Return mole fractions from mass fractions X"
      extends Modelica.Icons.Function;
      input SI.MassFraction X[:] "Mass fractions of mixture";
      input SI.MolarMass[:] MMX "molar masses of components";
      output SI.MoleFraction moleFractions[size(X, 1)]
        "Mole fractions of gas mixture";
    protected
      Real invMMX[size(X, 1)] "inverses of molar weights";
      SI.MolarMass Mmix "molar mass of mixture";
    algorithm
      for i in 1:size(X, 1) loop
        invMMX[i] := 1/MMX[i];
      end for;
      Mmix := 1/(X*invMMX);
      for i in 1:size(X, 1) loop
        moleFractions[i] := Mmix*X[i]/MMX[i];
      end for;
      annotation(smoothOrder=5);
    end massToMoleFractions;

end PartialMixtureMedium;

  partial package PartialCondensingGases
    "Base class for mixtures of condensing and non-condensing gases"
    extends PartialMixtureMedium(
         ThermoStates = Choices.IndependentVariables.pTX);

  replaceable partial function saturationPressure
      "Return saturation pressure of condensing fluid"
    extends Modelica.Icons.Function;
    input Temperature Tsat "saturation temperature";
    output AbsolutePressure psat "saturation pressure";
  end saturationPressure;

  replaceable partial function enthalpyOfVaporization
      "Return vaporization enthalpy of condensing fluid"
    extends Modelica.Icons.Function;
    input Temperature T "temperature";
    output SpecificEnthalpy r0 "vaporization enthalpy";
  end enthalpyOfVaporization;

  replaceable partial function enthalpyOfLiquid
      "Return liquid enthalpy of condensing fluid"
    extends Modelica.Icons.Function;
    input Temperature T "temperature";
    output SpecificEnthalpy h "liquid enthalpy";
  end enthalpyOfLiquid;

  replaceable partial function enthalpyOfGas
      "Return enthalpy of non-condensing gas mixture"
    extends Modelica.Icons.Function;
    input Temperature T "temperature";
    input MassFraction[:] X "vector of mass fractions";
    output SpecificEnthalpy h "specific enthalpy";
  end enthalpyOfGas;

  replaceable partial function enthalpyOfCondensingGas
      "Return enthalpy of condensing gas (most often steam)"
    extends Modelica.Icons.Function;
    input Temperature T "temperature";
    output SpecificEnthalpy h "specific enthalpy";
  end enthalpyOfCondensingGas;

  replaceable partial function enthalpyOfNonCondensingGas
      "Return enthalpy of the non-condensing species"
    extends Modelica.Icons.Function;
    input Temperature T "temperature";
    output SpecificEnthalpy h "specific enthalpy";
  end enthalpyOfNonCondensingGas;
  end PartialCondensingGases;

  partial package PartialTwoPhaseMedium
    "Base class for two phase medium of one substance"
    extends PartialPureSubstance;

    constant Boolean smoothModel
      "true if the (derived) model should not generate state events";
    constant Boolean onePhase
      "true if the (derived) model should never be called with two-phase inputs";

    record FluidLimits "validity limits for fluid model"
      extends Modelica.Icons.Record;
      Temperature TMIN "minimum temperature";
      Temperature TMAX "maximum temperature";
      Density DMIN "minimum density";
      Density DMAX "maximum density";
      AbsolutePressure PMIN "minimum pressure";
      AbsolutePressure PMAX "maximum pressure";
      SpecificEnthalpy HMIN "minimum enthalpy";
      SpecificEnthalpy HMAX "maximum enthalpy";
      SpecificEntropy SMIN "minimum entropy";
      SpecificEntropy SMAX "maximum entropy";
      annotation(Documentation(
          info="<html>
          <p>The minimum pressure mostly applies to the liquid state only.
          The minimum density is also arbitrary, but is reasonable for techical
          applications to limit iterations in non-linear systems. The limits in
          enthalpy and entropy are used as safeguards in inverse iterations.</p>
          </html>"));
    end FluidLimits;

    redeclare replaceable record extends FluidConstants
      "extended fluid constants"
      Temperature criticalTemperature "critical temperature";
      AbsolutePressure criticalPressure "critical pressure";
      MolarVolume criticalMolarVolume "critical molar Volume";
      Real acentricFactor "Pitzer acentric factor";
      Temperature triplePointTemperature "triple point temperature";
      AbsolutePressure triplePointPressure "triple point pressure";
      Temperature meltingPoint "melting point at 101325 Pa";
      Temperature normalBoilingPoint "normal boiling point (at 101325 Pa)";
      DipoleMoment dipoleMoment
        "dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
      Boolean hasIdealGasHeatCapacity=false
        "true if ideal gas heat capacity is available";
      Boolean hasCriticalData=false "true if critical data are known";
      Boolean hasDipoleMoment=false "true if a dipole moment known";
      Boolean hasFundamentalEquation=false "true if a fundamental equation";
      Boolean hasLiquidHeatCapacity=false
        "true if liquid heat capacity is available";
      Boolean hasSolidHeatCapacity=false
        "true if solid heat capacity is available";
      Boolean hasAccurateViscosityData=false
        "true if accurate data for a viscosity function is available";
      Boolean hasAccurateConductivityData=false
        "true if accurate data for thermal conductivity is available";
      Boolean hasVapourPressureCurve=false
        "true if vapour pressure data, e.g., Antoine coefficents are known";
      Boolean hasAcentricFactor=false
        "true if Pitzer accentric factor is known";
      SpecificEnthalpy HCRIT0=0.0
        "Critical specific enthalpy of the fundamental equation";
      SpecificEntropy SCRIT0=0.0
        "Critical specific entropy of the fundamental equation";
      SpecificEnthalpy deltah=0.0
        "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
      SpecificEntropy deltas=0.0
        "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
    end FluidConstants;

  constant FluidConstants[nS] fluidConstants "constant data for the fluid";

  redeclare replaceable record extends ThermodynamicState
      "Thermodynamic state of two phase medium"
      FixedPhase phase(min=0, max=2)
        "phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use";
  end ThermodynamicState;

    replaceable record SaturationProperties
      "Saturation properties of two phase medium"
      extends Modelica.Icons.Record;
      AbsolutePressure psat "saturation pressure";
      Temperature Tsat "saturation temperature";
    end SaturationProperties;

    type FixedPhase = Integer(min=0,max=2)
      "phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use";

    redeclare replaceable partial model extends BaseProperties
      "Base properties (p, d, T, h, u, R, MM, sat) of two phase medium"
      SaturationProperties sat "Saturation properties at the medium pressure";
    end BaseProperties;

    replaceable partial function setDewState
      "Return the thermodynamic state on the dew line"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation point";
      input FixedPhase phase(min = 1, max = 2) =  1
        "phase: default is one phase";
      output ThermodynamicState state "complete thermodynamic state info";
    end setDewState;

    replaceable partial function setBubbleState
      "Return the thermodynamic state on the bubble line"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation point";
      input FixedPhase phase(min = 1, max = 2) =  1
        "phase: default is one phase";
      output ThermodynamicState state "complete thermodynamic state info";
    end setBubbleState;

    redeclare replaceable partial function extends setState_dTX
      "Return thermodynamic state as function of d, T and composition X or Xi"
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
    end setState_dTX;

    redeclare replaceable partial function extends setState_phX
      "Return thermodynamic state as function of p, h and composition X or Xi"
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
    end setState_phX;

    redeclare replaceable partial function extends setState_psX
      "Return thermodynamic state as function of p, s and composition X or Xi"
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
    end setState_psX;

    redeclare replaceable partial function extends setState_pTX
      "Return thermodynamic state as function of p, T and composition X or Xi"
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
    end setState_pTX;

    replaceable function setSat_T
      "Return saturation property record from temperature"
      extends Modelica.Icons.Function;
      input Temperature T "temperature";
      output SaturationProperties sat "saturation property record";
    algorithm
      sat.Tsat := T;
      sat.psat := saturationPressure(T);
    end setSat_T;

    replaceable function setSat_p
      "Return saturation property record from pressure"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "pressure";
      output SaturationProperties sat "saturation property record";
    algorithm
      sat.psat := p;
      sat.Tsat := saturationTemperature(p);
    end setSat_p;

    replaceable partial function bubbleEnthalpy
      "Return bubble point specific enthalpy"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output SI.SpecificEnthalpy hl "boiling curve specific enthalpy";
    end bubbleEnthalpy;

      replaceable partial function dewEnthalpy
      "Return dew point specific enthalpy"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output SI.SpecificEnthalpy hv "dew curve specific enthalpy";
      end dewEnthalpy;

      replaceable partial function bubbleEntropy
      "Return bubble point specific entropy"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output SI.SpecificEntropy sl "boiling curve specific entropy";
      end bubbleEntropy;

      replaceable partial function dewEntropy
      "Return dew point specific entropy"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output SI.SpecificEntropy sv "dew curve specific entropy";
      end dewEntropy;

      replaceable partial function bubbleDensity "Return bubble point density"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output Density dl "boiling curve density";
      end bubbleDensity;

      replaceable partial function dewDensity "Return dew point density"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output Density dv "dew curve density";
      end dewDensity;

      replaceable partial function saturationPressure
      "Return saturation pressure"
        extends Modelica.Icons.Function;
        input Temperature T "temperature";
        output AbsolutePressure p "saturation pressure";
      end saturationPressure;

      replaceable partial function saturationTemperature
      "Return saturation temperature"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "pressure";
        output Temperature T "saturation temperature";
      end saturationTemperature;

      replaceable function saturationPressure_sat
      "Return saturation temperature"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output AbsolutePressure p "saturation pressure";
      algorithm
        p := sat.psat;
      end saturationPressure_sat;

      replaceable function saturationTemperature_sat
      "Return saturation temperature"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output Temperature T "saturation temperature";
      algorithm
        T := sat.Tsat;
      end saturationTemperature_sat;

      replaceable partial function saturationTemperature_derp
      "Return derivative of saturation temperature w.r.t. pressure"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "pressure";
        output Real dTp "derivative of saturation temperature w.r.t. pressure";
      end saturationTemperature_derp;

      replaceable function saturationTemperature_derp_sat
      "Return derivative of saturation temperature w.r.t. pressure"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output Real dTp "derivative of saturation temperature w.r.t. pressure";
      algorithm
        dTp := saturationTemperature_derp(sat.psat);
      end saturationTemperature_derp_sat;

    replaceable partial function surfaceTension
      "Return surface tension sigma in the two phase region"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output SurfaceTension sigma
        "Surface tension sigma in the two phase region";
    end surfaceTension;

      redeclare replaceable partial function extends molarMass
      "Return the molar mass of the medium"
      algorithm
        MM := fluidConstants[1].molarMass;
      end molarMass;

      replaceable partial function dBubbleDensity_dPressure
      "Return bubble point density derivative"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output DerDensityByPressure ddldp "boiling curve density derivative";
      end dBubbleDensity_dPressure;

      replaceable partial function dDewDensity_dPressure
      "Return dew point density derivative"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output DerDensityByPressure ddvdp "saturated steam density derivative";
      end dDewDensity_dPressure;

      replaceable partial function dBubbleEnthalpy_dPressure
      "Return bubble point specific enthalpy derivative"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output DerEnthalpyByPressure dhldp
        "boiling curve specific enthalpy derivative";
      end dBubbleEnthalpy_dPressure;

      replaceable partial function dDewEnthalpy_dPressure
      "Return dew point specific enthalpy derivative"
        extends Modelica.Icons.Function;

        input SaturationProperties sat "saturation property record";
        output DerEnthalpyByPressure dhvdp
        "saturated steam specific enthalpy derivative";
      end dDewEnthalpy_dPressure;

      redeclare replaceable function specificEnthalpy_pTX
      "Return specific enthalpy from pressure, temperature and mass fraction"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[nX] "Mass fractions";
        input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "Specific enthalpy at p, T, X";
      algorithm
        h := specificEnthalpy(setState_pTX(p,T,X,phase));
      end specificEnthalpy_pTX;

      redeclare replaceable function temperature_phX
      "Return temperature from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[nX] "Mass fractions";
        input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
        output Temperature T "Temperature";
      algorithm
        T := temperature(setState_phX(p,h,X,phase));
      end temperature_phX;

      redeclare replaceable function density_phX
      "Return density from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[nX] "Mass fractions";
        input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
        output Density d "density";
      algorithm
        d := density(setState_phX(p,h,X,phase));
      end density_phX;

      redeclare replaceable function temperature_psX
      "Return temperature from p, s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[nX] "Mass fractions";
        input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
        output Temperature T "Temperature";
      algorithm
        T := temperature(setState_psX(p,s,X,phase));
      end temperature_psX;

      redeclare replaceable function density_psX
      "Return density from p, s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[nX] "Mass fractions";
        input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
        output Density d "Density";
      algorithm
        d := density(setState_psX(p,s,X,phase));
      end density_psX;

      redeclare replaceable function specificEnthalpy_psX
      "Return specific enthalpy from p, s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[nX] "Mass fractions";
        input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "specific enthalpy";
      algorithm
        h := specificEnthalpy(setState_psX(p,s,X,phase));
      end specificEnthalpy_psX;

    redeclare replaceable function setState_pT
      "Return thermodynamic state from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      state := setState_pTX(p,T,fill(0,0),phase);
    end setState_pT;

    redeclare replaceable function setState_ph
      "Return thermodynamic state from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      state := setState_phX(p,h,fill(0, 0),phase);
    end setState_ph;

    redeclare replaceable function setState_ps
      "Return thermodynamic state from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      state := setState_psX(p,s,fill(0,0),phase);
    end setState_ps;

    redeclare replaceable function setState_dT
      "Return thermodynamic state from d and T"
      extends Modelica.Icons.Function;
      input Density d "density";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      state := setState_dTX(d,T,fill(0,0),phase);
    end setState_dT;

    replaceable function setState_px
      "Return thermodynamic state from pressure and vapour quality"
      input AbsolutePressure p "Pressure";
      input MassFraction x "Vapour quality";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_ph(
        p,
        (1-x)*bubbleEnthalpy(setSat_p(p)) + x*dewEnthalpy(setSat_p(p)),
        2);
    end setState_px;

    replaceable function setState_Tx
      "Return thermodynamic state from temperature and vapour quality"
      input Temperature T "Temperature";
      input MassFraction x "Vapour quality";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      state := setState_ph(
        saturationPressure_sat(setSat_T(T)),
        (1-x)*bubbleEnthalpy(setSat_T(T)) + x*dewEnthalpy(setSat_T(T)),
        2);
    end setState_Tx;

    replaceable function vapourQuality "Return vapour quality"
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction x "Vapour quality";
    protected
      constant SpecificEnthalpy eps = 1e-8;
    algorithm
      x := min(max(
        (specificEnthalpy(state)-bubbleEnthalpy(setSat_p(pressure(state)))) /
        (dewEnthalpy(setSat_p(pressure(state))) - bubbleEnthalpy(setSat_p(pressure(state))) + eps),
        0),1);
    end vapourQuality;

    redeclare replaceable function density_ph "Return density from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm
      d := density_phX(p, h, fill(0,0), phase);
    end density_ph;

    redeclare replaceable function temperature_ph
      "Return temperature from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Temperature T "Temperature";
    algorithm
      T := temperature_phX(p, h, fill(0,0),phase);
    end temperature_ph;

    redeclare replaceable function pressure_dT "Return pressure from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output AbsolutePressure p "Pressure";
    algorithm
      p := pressure(setState_dTX(d, T, fill(0,0),phase));
    end pressure_dT;

    redeclare replaceable function specificEnthalpy_dT
      "Return specific enthalpy from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := specificEnthalpy(setState_dTX(d, T, fill(0,0),phase));
    end specificEnthalpy_dT;

    redeclare replaceable function specificEnthalpy_ps
      "Return specific enthalpy from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := specificEnthalpy_psX(p,s,fill(0,0));
    end specificEnthalpy_ps;

    redeclare replaceable function temperature_ps
      "Return temperature from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Temperature T "Temperature";
    algorithm
      T := temperature_psX(p,s,fill(0,0),phase);
    end temperature_ps;

    redeclare replaceable function density_ps "Return density from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm
      d := density_psX(p, s, fill(0,0), phase);
    end density_ps;

    redeclare replaceable function specificEnthalpy_pT
      "Return specific enthalpy from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := specificEnthalpy_pTX(p, T, fill(0,0),phase);
    end specificEnthalpy_pT;

    redeclare replaceable function density_pT "Return density from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm
      d := density(setState_pTX(p, T, fill(0,0),phase));
    end density_pT;
  end PartialTwoPhaseMedium;

  partial package PartialSimpleMedium
    "Medium model with linear dependency of u, h from temperature. All other quantities, especially density, are constant."

    extends Interfaces.PartialPureSubstance(
          final ThermoStates = Choices.IndependentVariables.pT,
          final singleState=true);

    import SI = Modelica.SIunits;
    constant SpecificHeatCapacity cp_const
      "Constant specific heat capacity at constant pressure";
    constant SpecificHeatCapacity cv_const
      "Constant specific heat capacity at constant volume";
    constant Density d_const "Constant density";
    constant DynamicViscosity eta_const "Constant dynamic viscosity";
    constant ThermalConductivity lambda_const "Constant thermal conductivity";
    constant VelocityOfSound a_const "Constant velocity of sound";
    constant Temperature T_min "Minimum temperature valid for medium model";
    constant Temperature T_max "Maximum temperature valid for medium model";
    constant Temperature T0=reference_T "Zero enthalpy temperature";
    constant MolarMass MM_const "Molar mass";

    constant FluidConstants[nS] fluidConstants "fluid constants";

    redeclare record extends ThermodynamicState "Thermodynamic state"
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
    end ThermodynamicState;

    redeclare replaceable model extends BaseProperties(
      T(stateSelect=if preferredMediumStates then StateSelect.prefer else
                         StateSelect.default),
      p(stateSelect=if preferredMediumStates then StateSelect.prefer else
                         StateSelect.default)) "Base properties"
    equation
          assert(T >= T_min and T <= T_max, "
Temperature T (= "     + String(T) + " K) is not
in the allowed range ("     + String(T_min) + " K <= T <= " + String(T_max)
             + " K)
required from medium model \""     + mediumName + "\".
");

          // h = cp_const*(T-T0);
      h = specificEnthalpy_pTX(p,T,X);
      u = cv_const*(T-T0);
      d = d_const;
      R = 0;
      MM = MM_const;
      state.T = T;
      state.p = p;
          annotation (Documentation(info="<HTML>
<p>
This is the most simple incompressible medium model, where
specific enthalpy h and specific internal energy u are only
a function of temperature T and all other provided medium
quantities are assumed to be constant.
Note that the (small) influence of the pressure term p/d is neglected.
</p>

</p>
</HTML>"));
    end BaseProperties;

    redeclare function setState_pTX
      "Return thermodynamic state from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p,T=T);
    end setState_pTX;

    redeclare function setState_phX
      "Return thermodynamic state from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p,T=T0+h/cp_const);
    end setState_phX;

    redeclare replaceable function setState_psX
      "Return thermodynamic state from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p,T=Modelica.Math.exp(s/cp_const + Modelica.Math.log(reference_T)))
        "here the incompressible limit is used, with cp as heat capacity";
    end setState_psX;

    redeclare function setState_dTX
      "Return thermodynamic state from d, T, and X or Xi"
      extends Modelica.Icons.Function;
      input Density d "density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      assert(false,"pressure can not be computed from temperature and density for an incompressible fluid!");
    end setState_dTX;

        redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
        algorithm
          state :=ThermodynamicState(p=Media.Common.smoothStep(x, state_a.p, state_b.p, x_small),
                                     T=Media.Common.smoothStep(x, state_a.T, state_b.T, x_small));
        end setSmoothState;

    redeclare function extends dynamicViscosity "Return dynamic viscosity"

    algorithm
      eta := eta_const;
    end dynamicViscosity;

    redeclare function extends thermalConductivity
      "Return thermal conductivity"

    algorithm
      lambda := lambda_const;
    end thermalConductivity;

    redeclare function extends pressure "Return pressure"

    algorithm
      p := state.p;
    end pressure;

    redeclare function extends temperature "Return temperature"

    algorithm
      T := state.T;
    end temperature;

    redeclare function extends density "Return density"

    algorithm
      d := d_const;
    end density;

    redeclare function extends specificEnthalpy "Return specific enthalpy"

    algorithm
      h := cp_const*(state.T-T0);
    end specificEnthalpy;

    redeclare function extends specificHeatCapacityCp
      "Return specific heat capacity at constant pressure"

    algorithm
      cp := cp_const;
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv
      "Return specific heat capacity at constant volume"

    algorithm
      cv := cv_const;
    end specificHeatCapacityCv;

    redeclare function extends isentropicExponent "Return isentropic exponent"

    algorithm
      gamma := cp_const/cv_const;
    end isentropicExponent;

    redeclare function extends velocityOfSound "Return velocity of sound "

    algorithm
      a := a_const;
    end velocityOfSound;

    redeclare function specificEnthalpy_pTX
      "Return specific enthalpy from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[nX] "Mass fractions";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := cp_const*(T-T0);
      annotation(Documentation(info="<html>
<p>
This function computes the specific enthalpy of the fluid, but neglects the (small) influence of the pressure term p/d.
</p>
</html>"));
    end specificEnthalpy_pTX;

    redeclare function temperature_phX
      "Return temperature from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[nX] "Mass fractions";
      output Temperature T "Temperature";
    algorithm
      T := T0 + h/cp_const;
    end temperature_phX;

    redeclare function density_phX "Return density from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[nX] "Mass fractions";
      output Density d "density";
    algorithm
      d := density(setState_phX(p,h,X));
    end density_phX;

    redeclare function extends specificInternalEnergy
      "Return specific internal energy"
      extends Modelica.Icons.Function;
    algorithm
    //  u := cv_const*(state.T - T0) - reference_p/d_const;
      u := cv_const*(state.T - T0);
      annotation (Documentation(info="<html>
<p>
This function computes the specific internal energy of the fluid, but neglects the (small) influence of the pressure term p/d.
</p>
</html>"));
    end specificInternalEnergy;

    redeclare function extends specificEntropy "Return specific entropy"
      extends Modelica.Icons.Function;
    algorithm
      s := cv_const*Modelica.Math.log(state.T/T0);
    end specificEntropy;

    redeclare function extends specificGibbsEnergy
      "Return specific Gibbs energy"
      extends Modelica.Icons.Function;
    algorithm
      g := specificEnthalpy(state) - state.T*specificEntropy(state);
    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy
      "Return specific Helmholtz energy"
      extends Modelica.Icons.Function;
    algorithm
      f := specificInternalEnergy(state) - state.T*specificEntropy(state);
    end specificHelmholtzEnergy;

    redeclare function extends isentropicEnthalpy "Return isentropic enthalpy"
    algorithm
      h_is := cp_const*(temperature(refState) - T0);
    end isentropicEnthalpy;

    redeclare function extends isobaricExpansionCoefficient
      "Returns overall the isobaric expansion coefficient beta"
    algorithm
      beta := 0.0;
    end isobaricExpansionCoefficient;

    redeclare function extends isothermalCompressibility
      "Returns overall the isothermal compressibility factor"
    algorithm
      kappa := 0;
    end isothermalCompressibility;

    redeclare function extends density_derp_T
      "Returns the partial derivative of density with respect to pressure at constant temperature"
    algorithm
      ddpT := 0;
    end density_derp_T;

    redeclare function extends density_derT_p
      "Returns the partial derivative of density with respect to temperature at constant pressure"
    algorithm
      ddTp := 0;
    end density_derT_p;

    redeclare function extends density_derX
      "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature"
    algorithm
      dddX := fill(0,nX);
    end density_derX;

    redeclare function extends molarMass "return the molar mass of the medium"
    algorithm
      MM := MM_const;
    end molarMass;
  end PartialSimpleMedium;

  partial package PartialSimpleIdealGasMedium
    "Medium model of Ideal gas with constant cp and cv. All other quantities, e.g., transport properties, are constant."

    extends Interfaces.PartialPureSubstance(
         ThermoStates = Choices.IndependentVariables.pT,
         final singleState=false);

    import SI = Modelica.SIunits;
    constant SpecificHeatCapacity cp_const
      "Constant specific heat capacity at constant pressure";
    constant SpecificHeatCapacity cv_const= cp_const - R_gas
      "Constant specific heat capacity at constant volume";
    constant SpecificHeatCapacity R_gas "medium specific gas constant";
    constant MolarMass MM_const "Molar mass";
    constant DynamicViscosity eta_const "Constant dynamic viscosity";
    constant ThermalConductivity lambda_const "Constant thermal conductivity";
    constant Temperature T_min "Minimum temperature valid for medium model";
    constant Temperature T_max "Maximum temperature valid for medium model";
    constant Temperature T0= reference_T "Zero enthalpy temperature";

    redeclare record extends ThermodynamicState
      "Thermodynamic state of ideal gas"
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
    end ThermodynamicState;

    redeclare record extends FluidConstants "fluid constants"
    end FluidConstants;

    redeclare replaceable model extends BaseProperties(
      T(stateSelect=if preferredMediumStates then StateSelect.prefer else
                         StateSelect.default),
      p(stateSelect=if preferredMediumStates then StateSelect.prefer else
                         StateSelect.default)) "Base properties of ideal gas"
    equation
          assert(T >= T_min and T <= T_max, "
Temperature T (= "     + String(T) + " K) is not
in the allowed range ("     + String(T_min) + " K <= T <= " + String(T_max)
             + " K)
required from medium model \""     + mediumName + "\".
");
      h = specificEnthalpy_pTX(p,T,X);
      u = h-R*T;
      R = R_gas;
      d = p/(R*T);
      MM = MM_const;
      state.T = T;
      state.p = p;
          annotation (Documentation(info="<HTML>
<p>
This is the most simple incompressible medium model, where
specific enthalpy h and specific internal energy u are only
a function of temperature T and all other provided medium
quantities are assumed to be constant.
</p>
</HTML>"));
    end BaseProperties;

    redeclare function setState_pTX
      "Return thermodynamic state from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p,T=T);
    end setState_pTX;

    redeclare function setState_phX
      "Return thermodynamic state from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p,T=T0+h/cp_const);
    end setState_phX;

    redeclare replaceable function setState_psX
      "Return thermodynamic state from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p,T=Modelica.Math.exp(s/cp_const + Modelica.Math.log(reference_T))
                                  + R_gas*Modelica.Math.log(p/reference_p));
    end setState_psX;

    redeclare function setState_dTX
      "Return thermodynamic state from d, T, and X or Xi"
      extends Modelica.Icons.Function;
      input Density d "density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=d*R_gas*T,T=T);
    end setState_dTX;

        redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
        algorithm
          state := ThermodynamicState(p=Media.Common.smoothStep(x, state_a.p, state_b.p, x_small),
                                      T=Media.Common.smoothStep(x, state_a.T, state_b.T, x_small));
        end setSmoothState;

    redeclare function extends pressure "Return pressure of ideal gas"

    algorithm
      p := state.p;
    end pressure;

    redeclare function extends temperature "Return temperature of ideal gas"

    algorithm
      T := state.T;
    end temperature;

    redeclare function extends density "Return density of ideal gas"
    algorithm
      d := state.p/(R_gas*state.T);
    end density;

    redeclare function extends specificEnthalpy "Return specific enthalpy"
        extends Modelica.Icons.Function;
    algorithm
      h := cp_const*(state.T-T0);
    end specificEnthalpy;

    redeclare function extends specificInternalEnergy
      "Return specific internal energy"
      extends Modelica.Icons.Function;
    algorithm
      // u := (cp_const-R_gas)*(state.T-T0);
      u := cp_const*(state.T-T0) - R_gas*state.T;
    end specificInternalEnergy;

    redeclare function extends specificEntropy "Return specific entropy"
        extends Modelica.Icons.Function;
    algorithm
      s := cp_const*Modelica.Math.log(state.T/T0) - R_gas*Modelica.Math.log(state.p/reference_p);
    end specificEntropy;

    redeclare function extends specificGibbsEnergy
      "Return specific Gibbs energy"
      extends Modelica.Icons.Function;
    algorithm
      g := cp_const*(state.T-T0) - state.T*specificEntropy(state);
    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy
      "Return specific Helmholtz energy"
      extends Modelica.Icons.Function;
    algorithm
      f := (cp_const-R_gas)*(state.T-T0) - state.T*specificEntropy(state);
    end specificHelmholtzEnergy;

    redeclare function extends dynamicViscosity "Return dynamic viscosity"

    algorithm
      eta := eta_const;
    end dynamicViscosity;

    redeclare function extends thermalConductivity
      "Return thermal conductivity"

    algorithm
      lambda := lambda_const;
    end thermalConductivity;

    redeclare function extends specificHeatCapacityCp
      "Return specific heat capacity at constant pressure"

    algorithm
      cp := cp_const;
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv
      "Return specific heat capacity at constant volume"

    algorithm
      cv := cv_const;
    end specificHeatCapacityCv;

    redeclare function extends isentropicExponent "Return isentropic exponent"

    algorithm
      gamma := cp_const/cv_const;
    end isentropicExponent;

    redeclare function extends velocityOfSound "Return velocity of sound "

    algorithm
      a := sqrt(cp_const/cv_const*R_gas*state.T);
    end velocityOfSound;

    redeclare function specificEnthalpy_pTX
      "Return specific enthalpy from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[nX] "Mass fractions";
      output SpecificEnthalpy h "Specific enthalpy at p, T, X";
    algorithm
      h := cp_const*(T-T0);
    end specificEnthalpy_pTX;

    redeclare function temperature_phX
      "Return temperature from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[nX] "Mass fractions";
      output Temperature T "Temperature";
    algorithm
      T := h/cp_const + T0;
    end temperature_phX;

    redeclare function density_phX "Return density from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[nX] "Mass fractions";
      output Density d "density";
    algorithm
      d := density(setState_phX(p,h,X));
    end density_phX;

    redeclare function extends isentropicEnthalpy "Return isentropic enthalpy"
    algorithm
      /*  s = cp_const*log(refState.T/T0) - R_gas*log(refState.p/reference_p)
          = cp_const*log(state.T/T0) - R_gas*log(p_downstream/reference_p)

        log(state.T) = log(refState.T) +
                       (R_gas/cp_const)*(log(p_downstream/reference_p) - log(refState.p/reference_p))
                     = log(refState.T) + (R_gas/cp_const)*log(p_downstream/refState.p)
                     = log(refState.T) + log( (p_downstream/refState.p)^(R_gas/cp_const) )
                     = log( refState.T*(p_downstream/refState.p)^(R_gas/cp_const) )
        state.T = refstate.T*(p_downstream/refstate.p)^(R_gas/cp_const)
    */
      h_is := cp_const*(refState.T*(p_downstream/refState.p)^(R_gas/cp_const) - T0);
    end isentropicEnthalpy;

    redeclare function extends isobaricExpansionCoefficient
      "Returns overall the isobaric expansion coefficient beta"
    algorithm
      /* beta = 1/v * der(v,T), with v = 1/d, at constant pressure p:
       v = R*T/p
       der(v,T) = R/p
       beta = p/(R*T)*R/p
            = 1/T
    */

      beta := 1/state.T;
    end isobaricExpansionCoefficient;

    redeclare function extends isothermalCompressibility
      "Returns overall the isothermal compressibility factor"
    algorithm
      /* kappa = - 1/v * der(v,p), with v = 1/d at constant temperature T.
       v = R*T/p
       der(v,T) = -R*T/p^2
       kappa = p/(R*T)*R*T/p^2
             = 1/p
    */
      kappa := 1/state.p;
    end isothermalCompressibility;

    redeclare function extends density_derp_T
      "Returns the partial derivative of density with respect to pressure at constant temperature"
    algorithm
      /*  d = p/(R*T)
        ddpT = 1/(R*T)
    */
      ddpT := 1/(R_gas*state.T);
    end density_derp_T;

    redeclare function extends density_derT_p
      "Returns the partial derivative of density with respect to temperature at constant pressure"
    algorithm
      /*  d = p/(R*T)
        ddpT = -p/(R*T^2)
    */
      ddTp := -state.p/(R_gas*state.T*state.T);
    end density_derT_p;

    redeclare function extends density_derX
      "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature"
    algorithm
      dddX := fill(0,nX);
    end density_derX;

    redeclare function extends molarMass "Returns the molar mass of the medium"
    algorithm
      MM := MM_const;
    end molarMass;
  end PartialSimpleIdealGasMedium;

  annotation (Documentation(info="<HTML>
<p>
This package provides basic interfaces definitions of media models for different
kind of media.
</p>
</HTML>"));
end Interfaces;

package Common "data structures and fundamental functions for fluid properties"

  extends Modelica.Icons.Package;
protected
  type Rate = Real (final quantity="Rate", final unit="s-1");
  type MolarFlowRate = Real (final quantity="MolarFlowRate", final unit="mol/s");
  type MolarReactionRate = Real (final quantity="MolarReactionRate", final unit=
         "mol/(m3.s)");
  type MolarEnthalpy = Real (final quantity="MolarEnthalpy", final unit="J/mol");
  type DerDensityByEntropy = Real (final quantity="DerDensityByEntropy", final unit=
             "kg2.K/(m3.J)");
  type DerEnergyByPressure = Real (final quantity="DerEnergyByPressure", final unit=
             "J/Pa");
  type DerEnergyByMoles = Real (final quantity="DerEnergyByMoles", final unit=
          "J/mol");
  type DerEntropyByTemperature = Real (final quantity="DerEntropyByTemperature",
         final unit="J/K2");
  type DerEntropyByPressure = Real (final quantity="DerEntropyByPressure",
        final unit="J/(K.Pa)");
  type DerEntropyByMoles = Real (final quantity="DerEntropyByMoles", final unit=
         "J/(mol.K)");
  type DerPressureByDensity = Real (final quantity="DerPressureByDensity",
        final unit="Pa.m3/kg");
  type DerPressureBySpecificVolume = Real (final quantity=
          "DerPressureBySpecificVolume", final unit="Pa.kg/m3");
  type DerPressureByTemperature = Real (final quantity=
          "DerPressureByTemperature", final unit="Pa/K");
  type DerVolumeByTemperature = Real (final quantity="DerVolumeByTemperature",
        final unit="m3/K");
  type DerVolumeByPressure = Real (final quantity="DerVolumeByPressure", final unit=
             "m3/Pa");
  type DerVolumeByMoles = Real (final quantity="DerVolumeByMoles", final unit=
          "m3/mol");
  type IsenthalpicExponent = Real (final quantity="IsenthalpicExponent", unit=
          "1");
  type IsentropicExponent = Real (final quantity="IsentropicExponent", unit="1");
  type IsobaricVolumeExpansionCoefficient = Real (final quantity=
          "IsobaricVolumeExpansionCoefficient", unit="1/K");
  type IsochoricPressureCoefficient = Real (final quantity=
          "IsochoricPressureCoefficient", unit="1/K");
  type IsothermalCompressibility = Real (final quantity=
          "IsothermalCompressibility", unit="1/Pa");
  type JouleThomsonCoefficient = Real (final quantity="JouleThomsonCoefficient",
         unit="K/Pa");
  // introduce min-manx-nominal values
  constant Real MINPOS=1.0e-9
    "minimal value for physical variables which are always > 0.0";

  constant SI.Area AMIN=MINPOS "minimal init area";
  constant SI.Area AMAX=1.0e5 "maximal init area";
  constant SI.Area ANOM=1.0 "nominal init area";
  constant SI.AmountOfSubstance MOLMIN=-1.0*MINPOS "minimal Mole Number";
  constant SI.AmountOfSubstance MOLMAX=1.0e8 "maximal Mole Number";
  constant SI.AmountOfSubstance MOLNOM=1.0 "nominal Mole Number";
  constant SI.Density DMIN=MINPOS "minimal init density";
  constant SI.Density DMAX=1.0e5 "maximal init density";
  constant SI.Density DNOM=1.0 "nominal init density";
  constant SI.ThermalConductivity LAMMIN=MINPOS "minimal thermal conductivity";
  constant SI.ThermalConductivity LAMNOM=1.0 "nominal thermal conductivity";
  constant SI.ThermalConductivity LAMMAX=1000.0 "maximal thermal conductivity";
  constant SI.DynamicViscosity ETAMIN=MINPOS "minimal init dynamic viscosity";
  constant SI.DynamicViscosity ETAMAX=1.0e8 "maximal init dynamic viscosity";
  constant SI.DynamicViscosity ETANOM=100.0 "nominal init dynamic viscosity";
  constant SI.Energy EMIN=-1.0e10 "minimal init energy";
  constant SI.Energy EMAX=1.0e10 "maximal init energy";
  constant SI.Energy ENOM=1.0e3 "nominal init energy";
  constant SI.Entropy SMIN=-1.0e6 "minimal init entropy";
  constant SI.Entropy SMAX=1.0e6 "maximal init entropy";
  constant SI.Entropy SNOM=1.0e3 "nominal init entropy";
  constant SI.MassFlowRate MDOTMIN=-1.0e5 "minimal init mass flow rate";
  constant SI.MassFlowRate MDOTMAX=1.0e5 "maximal init mass flow rate";
  constant SI.MassFlowRate MDOTNOM=1.0 "nominal init mass flow rate";
  constant SI.MassFraction MASSXMIN=-1.0*MINPOS "minimal init mass fraction";
  constant SI.MassFraction MASSXMAX=1.0 "maximal init mass fraction";
  constant SI.MassFraction MASSXNOM=0.1 "nominal init mass fraction";
  constant SI.Mass MMIN=-1.0*MINPOS "minimal init mass";
  constant SI.Mass MMAX=1.0e8 "maximal init mass";
  constant SI.Mass MNOM=1.0 "nominal init mass";
  constant SI.MolarMass MMMIN=0.001 "minimal initial molar mass";
  constant SI.MolarMass MMMAX=250.0 "maximal initial molar mass";
  constant SI.MolarMass MMNOM=0.2 "nominal initial molar mass";
  constant SI.MoleFraction MOLEYMIN=-1.0*MINPOS "minimal init mole fraction";
  constant SI.MoleFraction MOLEYMAX=1.0 "maximal init mole fraction";
  constant SI.MoleFraction MOLEYNOM=0.1 "nominal init mole fraction";
  constant SI.MomentumFlux GMIN=-1.0e8 "minimal init momentum flux";
  constant SI.MomentumFlux GMAX=1.0e8 "maximal init momentum flux";
  constant SI.MomentumFlux GNOM=1.0 "nominal init momentum flux";
  constant SI.Power POWMIN=-1.0e8 "minimal init power or heat";
  constant SI.Power POWMAX=1.0e8 "maximal init power or heat";
  constant SI.Power POWNOM=1.0e3 "nominal init power or heat";
  constant SI.Pressure PMIN=1.0e4 "minimal init pressure";
  constant SI.Pressure PMAX=1.0e8 "maximal init pressure";
  constant SI.Pressure PNOM=1.0e5 "nominal init pressure";
  constant SI.Pressure COMPPMIN=-1.0*MINPOS "minimal init pressure";
  constant SI.Pressure COMPPMAX=1.0e8 "maximal init pressure";
  constant SI.Pressure COMPPNOM=1.0e5 "nominal init pressure";
  constant SI.RatioOfSpecificHeatCapacities KAPPAMIN=1.0
    "minimal init isentropic exponent";
  constant SI.RatioOfSpecificHeatCapacities KAPPAMAX=1.7
    "maximal init isentropic exponent";
  constant SI.RatioOfSpecificHeatCapacities KAPPANOM=1.2
    "nominal init isentropic exponent";
  constant SI.SpecificEnergy SEMIN=-1.0e8 "minimal init specific energy";
  constant SI.SpecificEnergy SEMAX=1.0e8 "maximal init specific energy";
  constant SI.SpecificEnergy SENOM=1.0e6 "nominal init specific energy";
  constant SI.SpecificEnthalpy SHMIN=-1.0e8 "minimal init specific enthalpy";
  constant SI.SpecificEnthalpy SHMAX=1.0e8 "maximal init specific enthalpy";
  constant SI.SpecificEnthalpy SHNOM=1.0e6 "nominal init specific enthalpy";
  constant SI.SpecificEntropy SSMIN=-1.0e6 "minimal init specific entropy";
  constant SI.SpecificEntropy SSMAX=1.0e6 "maximal init specific entropy";
  constant SI.SpecificEntropy SSNOM=1.0e3 "nominal init specific entropy";
  constant SI.SpecificHeatCapacity CPMIN=MINPOS
    "minimal init specific heat capacity";
  constant SI.SpecificHeatCapacity CPMAX=1.0e6
    "maximal init specific heat capacity";
  constant SI.SpecificHeatCapacity CPNOM=1.0e3
    "nominal init specific heat capacity";
  constant SI.Temperature TMIN=MINPOS "minimal init temperature";
  constant SI.Temperature TMAX=1.0e5 "maximal init temperature";
  constant SI.Temperature TNOM=320.0 "nominal init temperature";
  constant SI.ThermalConductivity LMIN=MINPOS
    "minimal init thermal conductivity";
  constant SI.ThermalConductivity LMAX=500.0
    "maximal init thermal conductivity";
  constant SI.ThermalConductivity LNOM=1.0 "nominal init thermal conductivity";
  constant SI.Velocity VELMIN=-1.0e5 "minimal init speed";
  constant SI.Velocity VELMAX=1.0e5 "maximal init speed";
  constant SI.Velocity VELNOM=1.0 "nominal init speed";
  constant SI.Volume VMIN=0.0 "minimal init volume";
  constant SI.Volume VMAX=1.0e5 "maximal init volume";
  constant SI.Volume VNOM=1.0e-3 "nominal init volume";

  package ThermoFluidSpecial "property records used by the ThermoFluid library"

    record FixedIGProperties "constant properties for ideal gases"
      extends Modelica.Icons.Record;
      parameter Integer nspecies(min=1) "number of components";
      SI.MolarMass[nspecies] MM "molar mass of components";
      Real[nspecies] invMM "inverse of molar mass of components";
      SI.SpecificHeatCapacity[nspecies] R "gas constant";
      SI.SpecificEnthalpy[nspecies] Hf "enthalpy of formation at 298.15K";
      SI.SpecificEnthalpy[nspecies] H0 "H0(298.15K) - H0(0K)";
    end FixedIGProperties;

    record ThermoBaseVars
      extends Modelica.Icons.Record;
      parameter Integer n(min=1) "discretization number";
      parameter Integer nspecies(min=1) "number of species";
      SI.Pressure[n] p(
        min=PMIN,
        max=PMAX,
        nominal=PNOM,
        start=fill(1.0e5, n)) "Pressure";
      SI.Temperature[n] T(
        min=TMIN,
        max=TMAX,
        nominal=TNOM) "temperature";
      SI.Density[n] d(
        min=DMIN,
        max=DMAX,
        nominal=DNOM) "density";
      SI.SpecificEnthalpy[n] h(
        min=SHMIN,
        max=SHMAX,
        nominal=SHNOM) "specific enthalpy";
      SI.SpecificEntropy[n] s(
        min=SSMIN,
        max=SSMAX,
        nominal=SSNOM) "specific entropy";
      SI.RatioOfSpecificHeatCapacities[n] kappa "ratio of cp/cv";
      SI.Mass[n] M(
        min=MMIN,
        max=MMAX,
        nominal=MNOM) "Total mass";
      SI.Energy[n] U(
        min=EMIN,
        max=EMAX,
        nominal=ENOM) "Inner energy";
      SI.MassFlowRate[n] dM(
        min=MDOTMIN,
        max=MDOTMAX,
        nominal=MDOTNOM) "Change in total mass";
      SI.Power[n] dU(
        min=POWMIN,
        max=POWMAX,
        nominal=POWNOM) "Change in inner energy";
      SI.Volume[n] V(
        min=VMIN,
        max=VMAX,
        nominal=VNOM) "Volume";
      SI.MassFraction[n,nspecies] mass_x(
        min=MASSXMIN,
        max=MASSXMAX,
        nominal=MASSXNOM) "mass fraction";
      SI.MoleFraction[n,nspecies] mole_y(
        min=MOLEYMIN,
        max=MOLEYMAX,
        nominal=MOLEYNOM) "mole fraction";
      SI.Mass[n,nspecies] M_x(
        min=MMIN,
        max=MMAX,
        nominal=MNOM) "component mass";
      SI.MassFlowRate[n,nspecies] dM_x(
        min=MDOTMIN,
        max=MDOTMAX,
        nominal=MDOTNOM) "rate of change in component mass";
      MolarFlowRate[n, nspecies] dZ(
        min=-1.0e6,
        max=1.0e6,
        nominal=0.0) "rate of change in component moles";
      MolarFlowRate[n, nspecies] rZ(
        min=-1.0e6,
        max=1.0e6,
        nominal=0.0) "Reaction(source) mole rates";
      SI.MolarMass[n] MM(
        min=MMMIN,
        max=MMMAX,
        nominal=MMNOM) "molar mass of mixture";
      SI.AmountOfSubstance[n] Moles(
        min=MOLMIN,
        max=MOLMAX,
        nominal=MOLNOM) "total moles";
      SI.AmountOfSubstance[n,nspecies] Moles_z(
        min=MOLMIN,
        max=MOLMAX,
        nominal=MOLNOM) "mole vector";
      annotation (Documentation(info="<HTML>
                         <h4>Model description</h4>
                              <p>
                              <b>ThermoBaseVars</b> is inherited by all medium property models
                              and by all models defining the dynamic states for the conservation
                              of mass and energy. Thus it is a good choice as a restricting class
                              for any medium model or dynamic state model.
                           </p>
                              </HTML>
                              "));
    end ThermoBaseVars;

    record ThermoProperties
      "Thermodynamic base property data for all state models"
      extends Modelica.Icons.Record;
      parameter Integer nspecies(min=1) "number of species";
      SI.Temperature T(
        min=TMIN,
        max=TMAX,
        nominal=TNOM) "temperature";
      SI.Density d(
        min=DMIN,
        max=DMAX,
        nominal=DNOM) "density";
      SI.Pressure p(
        min=PMIN,
        max=PMAX,
        nominal=PNOM) "pressure";
      SI.Volume V(
        min=VMIN,
        max=VMAX,
        nominal=VNOM) "Volume";
      SI.SpecificEnthalpy h(
        min=SHMIN,
        max=SHMAX,
        nominal=SHNOM) "specific enthalpy";
      SI.SpecificEnergy u(
        min=SEMIN,
        max=SEMAX,
        nominal=SENOM) "specific inner energy";
      SI.SpecificEntropy s(
        min=SSMIN,
        max=SSMAX,
        nominal=SSNOM) "specific entropy";
      SI.SpecificGibbsFreeEnergy g(
        min=SHMIN,
        max=SHMAX,
        nominal=SHNOM) "specific Gibbs free energy";
      SI.SpecificHeatCapacity cp(
        min=CPMIN,
        max=CPMAX,
        nominal=CPNOM) "heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=CPMIN,
        max=CPMAX,
        nominal=CPNOM) "heat capacity at constant volume";
      SI.SpecificHeatCapacity R(
        min=CPMIN,
        max=CPMAX,
        nominal=CPNOM) "gas constant";
      SI.MolarMass MM(
        min=MMMIN,
        max=MMMAX,
        nominal=MMNOM) "molar mass of mixture";
      SI.MassFraction[nspecies] mass_x(
        min=MASSXMIN,
        max=MASSXMAX,
        nominal=MASSXNOM) "mass fraction";
      SI.MoleFraction[nspecies] mole_y(
        min=MOLEYMIN,
        max=MOLEYMAX,
        nominal=MOLEYNOM) "mole fraction";
      SI.RatioOfSpecificHeatCapacities kappa "ratio of cp/cv";
      SI.DerDensityByTemperature ddTp
        "derivative of density by temperature at constant pressure";
      SI.DerDensityByPressure ddpT
        "derivative of density by pressure at constant temperature";
      Real dupT(unit="m3.kg-1")
        "derivative of inner energy by pressure at constant T";
      Real dudT(unit="(J.m3)/(kg2)")
        "derivative of inner energy by density at constant T";
      SI.SpecificHeatCapacity duTp
        "derivative of inner energy by temperature at constant p";
      SI.SpecificEnergy ddx[nspecies]
        "derivative vector of density by change in mass composition";
      SI.SpecificEnergy[nspecies] compu(
        min=SEMIN,
        max=SEMAX,
        nominal=SENOM) "inner energy of the components";
      SI.Pressure[nspecies] compp(
        min=COMPPMIN,
        max=COMPPMAX,
        nominal=COMPPNOM) "partial pressures of the components";
      SI.Velocity a(
        min=VELMIN,
        max=VELMAX,
        nominal=VELNOM) "speed of sound";
      SI.HeatCapacity dUTZ
        "derivative of inner energy by temperature at constant moles";
      SI.MolarInternalEnergy[nspecies] dUZT
        "derivative of inner energy by moles at constant temperature";
      SI.SpecificEnthalpy[nspecies] dHMxT(
        min=SEMIN,
        max=SEMAX,
        nominal=SENOM)
        "derivative of total enthalpy w.r.t. component mass at constant T";
      Real dpT "derivative of pressure w.r.t. temperature";
      Real dpZ[nspecies] "derivative of pressure w.r.t. moles";
      annotation (Documentation(info="<HTML>
        <h4>Model description</h4>
        <p>
        A base class for medium property models which work with most of the
        versions of dynamic states that are available in the ThermoFluid
        library. Currently used by all ideal gas models.
     </p>
        </HTML>
        "));
    end ThermoProperties;

    record ThermoProperties_ph
      "Thermodynamic property data for pressure p and specific enthalpy h as dynamic states"

      extends Modelica.Icons.Record;
      SI.Temperature T(
        min=1.0e-9,
        max=10000.0,
        nominal=298.15) "temperature";
      SI.Density d(
        min=1.0e-9,
        max=10000.0,
        nominal=10.0) "density";
      SI.SpecificEnergy u(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "specific inner energy";
      SI.SpecificEntropy s(
        min=-1.0e6,
        max=1.0e6,
        nominal=1.0e3) "specific entropy";
      SI.SpecificHeatCapacity cp(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "heat capacity at constant volume";
      SI.SpecificHeatCapacity R(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "gas constant";
      SI.RatioOfSpecificHeatCapacities kappa "ratio of cp/cv";
      SI.Velocity a(
        min=1.0,
        max=10000.0,
        nominal=300.0) "speed of sound";
      SI.DerDensityByEnthalpy ddhp
        "derivative of density by enthalpy at constant pressure";
      SI.DerDensityByPressure ddph
        "derivative of density by pressure at constant enthalpy";
      Real duph(unit="m3/kg")
        "derivative of inner energy by pressure at constant enthalpy";
      Real duhp(unit="1")
        "derivative of inner energy by enthalpy at constant pressure";
      annotation (Documentation(info="<HTML>
<h4>Model description</h4>
<p>
A base class for medium property models which
use pressure and enthalpy as dynamic states.
This is the preferred model for fluids that can also be in the
two phase and liquid regions.
</p>
</HTML>
"));
    end ThermoProperties_ph;

    record ThermoProperties_pT
      "Thermodynamic property data for pressure p and temperature T as dynamic states"

      extends Modelica.Icons.Record;
      SI.Density d(
        min=1.0e-9,
        max=10000.0,
        nominal=10.0) "density";
      SI.SpecificEnthalpy h(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "specific enthalpy";
      SI.SpecificEnergy u(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "specific inner energy";
      SI.SpecificEntropy s(
        min=-1.0e6,
        max=1.0e6,
        nominal=1.0e3) "specific entropy";
      SI.SpecificHeatCapacity cp(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "heat capacity at constant volume";
      SI.SpecificHeatCapacity R(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "gas constant";
      SI.RatioOfSpecificHeatCapacities kappa "ratio of cp/cv";
      SI.Velocity a(
        min=1.0,
        max=10000.0,
        nominal=300.0) "speed of sound";
      SI.DerDensityByTemperature ddTp
        "derivative of density by temperature at constant pressure";
      SI.DerDensityByPressure ddpT
        "derivative of density by pressure at constant temperature";
      Real dupT(unit="m3.kg-1")
        "derivative of inner energy by pressure at constant T";
      SI.SpecificHeatCapacity duTp
        "derivative of inner energy by temperature at constant p";
      annotation (Documentation(info="<HTML>
<h4>Model description</h4>
<p>
A base class for medium property models which use pressure and temperature as dynamic states.
This is a reasonable model for fluids that can also be in the gas and
liquid regions, but never in the two-phase region.
</p>
</HTML>
"));
    end ThermoProperties_pT;

    record ThermoProperties_dT
      "Thermodynamic property data for density d and temperature T as dynamic states"

      extends Modelica.Icons.Record;
      SI.Pressure p(
        min=1.0,
        max=1.0e9,
        nominal=1.0e5) "pressure";
      SI.SpecificEnthalpy h(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "specific enthalpy";
      SI.SpecificEnergy u(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "specific inner energy";
      SI.SpecificEntropy s(
        min=-1.0e6,
        max=1.0e6,
        nominal=1.0e3) "specific entropy";
      SI.SpecificHeatCapacity cp(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "heat capacity at constant volume";
      SI.SpecificHeatCapacity R(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "gas constant";
      SI.RatioOfSpecificHeatCapacities kappa "ratio of cp/cv";
      SI.Velocity a(
        min=1.0,
        max=10000.0,
        nominal=300.0) "speed of sound";
      Real dudT(unit="m5/(kg.s2)")
        "derivative of inner energy by density at constant T";
      annotation (Documentation(info="<HTML>
<h4>Model description</h4>
<p>
A base class for medium property models which use density and temperature as dynamic states.
This is a reasonable model for fluids that can be in the gas, liquid
and two-phase region. The model is numerically not well suited for
liquids except if the pressure is always above approx. 80% of the
critical pressure.
</p>
</HTML>
"));
    end ThermoProperties_dT;

    //   record GibbsDerivs

      //     "derivatives of dimensionless Gibbs-function w.r.t. dimensionless pressure and temperature"
    //     extends Modelica.Icons.Record;
    //     Real pi "dimensionless pressure";
    //     Real tau "dimensionless temperature";
    //     Real g "dimensionless Gibbs-function";
    //     Real gpi "derivative of g w.r.t. pi";
    //     Real gpipi "2nd derivative of g w.r.t. pi";
    //     Real gtau "derivative of g w.r.t. tau";
    //     Real gtautau "2nd derivative of g w.r.t. tau";
    //     Real gtaupi "mixed derivative of g w.r.t. pi and tau";
    //   end GibbsDerivs;

    //   record HelmholtzDerivs

      //     "derivatives of dimensionless Helmholtz-function w.r.t. dimensionless pressuredensity and temperature"
    //     extends Modelica.Icons.Record;
    //     Real delta "dimensionless density";
    //     Real tau "dimensionless temperature";
    //     Real f "dimensionless Helmholtz-function";
    //     Real fdelta "derivative of f w.r.t. delta";
    //     Real fdeltadelta "2nd derivative of f w.r.t. delta";
    //     Real ftau "derivative of f w.r.t. tau";
    //     Real ftautau "2nd derivative of f w.r.t. tau";
    //     Real fdeltatau "mixed derivative of f w.r.t. delta and tau";
    //   end HelmholtzDerivs;

    record TransportProps "record with transport properties"
      extends Modelica.Icons.Record;
      SI.DynamicViscosity eta;
      SI.ThermalConductivity lam;
    end TransportProps;

    function gibbsToProps_ph
      "calulate property record for pressure and specific enthalpy as states from dimensionless Gibbs function"

      extends Modelica.Icons.Function;
      input GibbsDerivs g "dimensionless derivatives of Gibbs function";
      output ThermoProperties_ph pro
        "property record for pressure and specific enthalpy as dynamic states";
    protected
      Real vt(unit="m3.kg-1.K-1")
        "derivative of specific volume w.r.t. temperature";
      Real vp(unit="m4.kg-2.s2")
        "derivative of specific volume w.r.t. pressure";
    algorithm
      pro.T := g.T;
      pro.R := g.R;
      pro.d := g.p/(pro.R*pro.T*g.pi*g.gpi);
      pro.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
      pro.s := pro.R*(g.tau*g.gtau - g.g);
      pro.cp := -pro.R*g.tau*g.tau*g.gtautau;
      pro.cv := pro.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/(g.gpipi));
      pro.a := abs(g.R*g.T*(g.gpi*g.gpi/((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.
        tau*g.gtaupi)/(g.tau*g.tau*g.gtautau) - g.gpipi)))^0.5;
      vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      pro.kappa := -1/(pro.d*g.p)*pro.cp/(vp*pro.cp + vt*vt*g.T);
      pro.ddhp := -pro.d*pro.d*vt/(pro.cp);
      pro.ddph := -pro.d*pro.d*(vp*pro.cp - vt/pro.d + g.T*vt*vt)/pro.cp;
      pro.duph := -1/pro.d + g.p/(pro.d*pro.d)*pro.ddph;
      pro.duhp := 1 + g.p/(pro.d*pro.d)*pro.ddhp;
    end gibbsToProps_ph;

    function gibbsToBoundaryProps
      "calulate phase boundary property record from dimensionless Gibbs function"

      extends Modelica.Icons.Function;
      input GibbsDerivs g "dimensionless derivatives of Gibbs function";
      output PhaseBoundaryProperties sat "phase boundary properties";
    protected
      Real vt(unit="m3.kg-1.K-1")
        "derivative of specific volume w.r.t. temperature";
      Real vp(unit="m4.kg-2.s2")
        "derivative of specific volume w.r.t. pressure";
    algorithm
      sat.d := g.p/(g.R*g.T*g.pi*g.gpi);
      sat.h := g.R*g.T*g.tau*g.gtau;
      sat.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
      sat.s := g.R*(g.tau*g.gtau - g.g);
      sat.cp := -g.R*g.tau*g.tau*g.gtautau;
      sat.cv := g.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/(g.gpipi));
      vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      // sat.kappa := -1/(sat.d*g.p)*sat.cp/(vp*sat.cp + vt*vt*g.T);
      sat.pt := -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
      sat.pd := -g.R*g.T*g.gpi*g.gpi/(g.gpipi);
    end gibbsToBoundaryProps;

    function gibbsToProps_dT
      "calulate property record for density and temperature as states from dimensionless Gibbs function"

      extends Modelica.Icons.Function;
      input GibbsDerivs g "dimensionless derivatives of Gibbs function";
      output ThermoProperties_dT pro
        "property record for density and temperature as dynamic states";
    protected
      Real vt(unit="m3.kg-1.K-1")
        "derivative of specific volume w.r.t. temperature";
      Real vp(unit="m4.kg-2.s2")
        "derivative of specific volume w.r.t. pressure";
      Modelica.SIunits.Density d;
    algorithm
      pro.R := g.R;
      pro.p := g.p;
      pro.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
      pro.h := g.R*g.T*g.tau*g.gtau;
      pro.s := pro.R*(g.tau*g.gtau - g.g);
      pro.cp := -pro.R*g.tau*g.tau*g.gtautau;
      pro.cv := pro.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/g.gpipi);
      vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      pro.kappa := -1/((g.p/(pro.R*g.T*g.pi*g.gpi))*g.p)*pro.cp/(vp*pro.cp + vt
        *vt*g.T);
      pro.a := abs(g.R*g.T*(g.gpi*g.gpi/((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.
        tau*g.gtaupi)/(g.tau*g.tau*g.gtautau) - g.gpipi)))^0.5;

      d := g.p/(pro.R*g.T*g.pi*g.gpi);
      pro.dudT := (pro.p - g.T*vt/vp)/(d*d);
    end gibbsToProps_dT;

    function gibbsToProps_pT
      "calulate property record for pressure and temperature as states from dimensionless Gibbs function"

      extends Modelica.Icons.Function;
      input GibbsDerivs g "dimensionless derivatives of Gibbs function";
      output ThermoProperties_pT pro
        "property record for pressure and temperature as dynamic states";
    protected
      Real vt(unit="m3.kg-1.K-1")
        "derivative of specific volume w.r.t. temperature";
      Real vp(unit="m4.kg-2.s2")
        "derivative of specific volume w.r.t. pressure";
    algorithm
      pro.R := g.R;
      pro.d := g.p/(pro.R*g.T*g.pi*g.gpi);
      pro.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
      pro.h := g.R*g.T*g.tau*g.gtau;
      pro.s := pro.R*(g.tau*g.gtau - g.g);
      pro.cp := -pro.R*g.tau*g.tau*g.gtautau;
      pro.cv := pro.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/g.gpipi);
      vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      pro.kappa := -1/(pro.d*g.p)*pro.cp/(vp*pro.cp + vt*vt*g.T);
      pro.a := abs(g.R*g.T*(g.gpi*g.gpi/((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.
        tau*g.gtaupi)/(g.tau*g.tau*g.gtautau) - g.gpipi)))^0.5;
      pro.ddpT := -(pro.d*pro.d)*vp;
      pro.ddTp := -(pro.d*pro.d)*vt;
      pro.duTp := pro.cp - g.p*vt;
      pro.dupT := -g.T*vt - g.p*vp;
    end gibbsToProps_pT;

    function helmholtzToProps_ph
      "calulate property record for pressure and specific enthalpy as states from dimensionless Helmholtz function"

      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
      output ThermoProperties_ph pro
        "property record for pressure and specific enthalpy as dynamic states";
    protected
      SI.Pressure p "pressure";
      DerPressureByDensity pd "derivative of pressure w.r.t. density";
      DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
      DerPressureBySpecificVolume pv
        "derivative of pressure w.r.t. specific volume";
    algorithm
      pro.d := f.d;
      pro.T := f.T;
      pro.R := f.R;
      pro.s := f.R*(f.tau*f.ftau - f.f);
      pro.u := f.R*f.T*f.tau*f.ftau;
      p := pro.d*pro.R*pro.T*f.delta*f.fdelta;
      pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      pv := -pd*f.d*f.d;

      // calculating cp near the critical point may be troublesome (cp -> inf).
      pro.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
        *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
      pro.cv := f.R*(-f.tau*f.tau*f.ftautau);
      pro.kappa := 1/(f.d*f.R*f.d*f.T*f.delta*f.fdelta)*((-pv*pro.cv + pt*pt*f.
        T)/(pro.cv));
      pro.a := abs(f.R*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta
         - ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta -
        f.delta*f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
      pro.ddph := (f.d*(pro.cv*f.d + pt))/(f.d*f.d*pd*pro.cv + f.T*pt*pt);
      pro.ddhp := -f.d*f.d*pt/(f.d*f.d*pd*pro.cv + f.T*pt*pt);
      pro.duph := -1/pro.d + p/(pro.d*pro.d)*pro.ddph;
      pro.duhp := 1 + p/(pro.d*pro.d)*pro.ddhp;
    end helmholtzToProps_ph;

    function helmholtzToProps_pT
      "calulate property record for pressure and temperature as states from dimensionless Helmholtz function"

      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
      output ThermoProperties_pT pro
        "property record for pressure and temperature as dynamic states";
    protected
      DerPressureByDensity pd "derivative of pressure w.r.t. density";
      DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
      DerPressureBySpecificVolume pv
        "derivative of pressure w.r.t. specific volume";
      IsobaricVolumeExpansionCoefficient alpha
        "isobaric volume expansion coefficient";
      // beta in Bejan
      IsothermalCompressibility gamma "isothermal compressibility";
      // kappa in Bejan
     SI.Pressure p "Pressure";
    algorithm
      pro.d := f.d;
      pro.R := f.R;
      pro.s := f.R*(f.tau*f.ftau - f.f);
      pro.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
      pro.u := f.R*f.T*f.tau*f.ftau;
      pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      pv := -(f.d*f.d)*pd;
      alpha := -f.d*pt/pv;
      gamma := -f.d/pv;
      p := f.R*f.d*f.T*f.delta*f.fdelta;
      // calculating cp near the critical point may be troublesome (cp -> inf).
      pro.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
        *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
      pro.cv := f.R*(-f.tau*f.tau*f.ftautau);
      pro.kappa := 1/(f.d*f.R*f.d*f.T*f.delta*f.fdelta)*((-pv*pro.cv + pt*pt*f.
        T)/(pro.cv));
      pro.a := abs(f.R*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta
         - ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta -
        f.delta*f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
      pro.ddTp := -pt/pd;
      pro.ddpT := 1/pd;
      //problem with units in last two lines
      pro.dupT := gamma*p/f.d - alpha*f.T/f.d;
      pro.duTp := pro.cp - alpha*p/f.d;
    end helmholtzToProps_pT;

    function helmholtzToProps_dT
      "calulate property record for density and temperature as states from dimensionless Helmholtz function"

      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
      output ThermoProperties_dT pro
        "property record for density and temperature as dynamic states";
    protected
      DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
      DerPressureBySpecificVolume pv "derivative of pressure w.r.t. pressure";
    algorithm
      pro.p := f.R*f.d*f.T*f.delta*f.fdelta;
      pro.R := f.R;
      pro.s := f.R*(f.tau*f.ftau - f.f);
      pro.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
      pro.u := f.R*f.T*f.tau*f.ftau;
      pv := -(f.d*f.d)*f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);

      // calculating cp near the critical point may be troublesome (cp -> inf).
      pro.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
        *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
      pro.cv := f.R*(-f.tau*f.tau*f.ftautau);
      pro.kappa := 1/(f.d*pro.p)*((-pv*pro.cv + pt*pt*f.T)/(pro.cv));
      pro.a := abs(f.R*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta
         - ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta -
        f.delta*f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
      pro.dudT := (pro.p - f.T*pt)/(f.d*f.d);
    end helmholtzToProps_dT;

    function TwoPhaseToProps_ph
      "compute property record for pressure and specific enthalpy as states from saturation properties"

      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output ThermoProperties_ph pro
        "property record for pressure and specific enthalpy as dynamic states";
    protected
      Real dht(unit="(J/kg)/K")
        "derivative of specific enthalpy w.r.t. temperature";
      Real dhd(unit="(J/kg)/(kg/m3)")
        "derivative of specific enthalpy w.r.t. density";
      Real detph(unit="m4.s4/(K.s8)") "thermodynamic determinant";
    algorithm
      pro.d := sat.d;
      pro.T := sat.T;
      pro.u := sat.u;
      pro.s := sat.s;
      pro.cv := sat.cv;
      pro.R := sat.R;
      pro.cp := Modelica.Constants.inf;
      pro.kappa := -1/(sat.d*sat.p)*sat.dpT*sat.dpT*sat.T/sat.cv;
      pro.a := Modelica.Constants.inf;
      dht := sat.cv + sat.dpT/sat.d;
      dhd := -sat.T*sat.dpT/(sat.d*sat.d);
      detph := -sat.dpT*dhd;
      pro.ddph := dht/detph;
      pro.ddhp := -sat.dpT/detph;
    end TwoPhaseToProps_ph;

    function TwoPhaseToProps_dT
      "compute property record for density and temperature as states from saturation properties"

      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation properties";
      output ThermoProperties_dT pro
        "property record for density and temperature as dynamic states";
    algorithm
      pro.p := sat.p;
      pro.h := sat.h;
      pro.u := sat.u;
      pro.s := sat.s;
      pro.cv := sat.cv;
      pro.cp := Modelica.Constants.inf;
      pro.R := sat.R;
      pro.kappa := -1/(sat.d*sat.p)*sat.dpT*sat.dpT*sat.T/sat.cv;
      pro.a := Modelica.Constants.inf;
      pro.dudT := (sat.p - sat.T*sat.dpT)/(sat.d*sat.d);
    end TwoPhaseToProps_dT;

  end ThermoFluidSpecial;

public
  record SaturationProperties "properties in the two phase region"
    extends Modelica.Icons.Record;
    SI.Temp_K T "temperature";
    SI.Density d "density";
    SI.Pressure p "pressure";
    SI.SpecificEnergy u "specific inner energy";
    SI.SpecificEnthalpy h "specific enthalpy";
    SI.SpecificEntropy s "specific entropy";
    SI.SpecificHeatCapacity cp "heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv "heat capacity at constant volume";
    SI.SpecificHeatCapacity R "gas constant";
    SI.RatioOfSpecificHeatCapacities kappa "isentropic expansion coefficient";
    PhaseBoundaryProperties liq
      "thermodynamic base properties on the boiling curve";
    PhaseBoundaryProperties vap
      "thermodynamic base properties on the dew curve";
    Real dpT(unit="Pa/K")
      "derivative of saturation pressure w.r.t. temperature";
    SI.MassFraction x "vapour mass fraction";
  end SaturationProperties;

  record SaturationBoundaryProperties
    "properties on both phase boundaries, including some derivatives"

    extends Modelica.Icons.Record;
    SI.Temp_K T "Saturation temperature";
    SI.Density dl "Liquid density";
    SI.Density dv "Vapour density";
    SI.SpecificEnthalpy hl "Liquid specific enthalpy";
    SI.SpecificEnthalpy hv "Vapour specific enthalpy";
    Real dTp "derivative of temperature w.r.t. saturation pressure";
    Real ddldp "derivative of density along boiling curve";
    Real ddvdp "derivative of density along dew curve";
    Real dhldp "derivative of specific enthalpy along boiling curve";
    Real dhvdp "derivative of specific enthalpy along dew curve";
    SI.MassFraction x "vapour mass fraction";
  end SaturationBoundaryProperties;

  record IF97BaseTwoPhase "Intermediate property data record for IF 97"
    extends Modelica.Icons.Record;
    Integer phase= 0 "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
    Integer region(min=1, max=5) "IF 97 region";
    SI.Pressure p "pressure";
    SI.Temperature T "temperature";
    SI.SpecificEnthalpy h "specific enthalpy";
    SI.SpecificHeatCapacity R "gas constant";
    SI.SpecificHeatCapacity cp "specific heat capacity";
    SI.SpecificHeatCapacity cv "specific heat capacity";
    SI.Density rho "density";
    SI.SpecificEntropy s "specific entropy";
    DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
    DerPressureByDensity pd "derivative of pressure w.r.t. density";
    Real vt "derivative of specific volume w.r.t. temperature";
    Real vp "derivative of specific volume w.r.t. pressure";
    Real x "dryness fraction";
    Real dpT "dp/dT derivative of saturation curve";
  end IF97BaseTwoPhase;

  record IF97PhaseBoundaryProperties
    "thermodynamic base properties on the phase boundary for IF97 steam tables"

    extends Modelica.Icons.Record;
    Boolean region3boundary "true if boundary between 2-phase and region 3";
    SI.SpecificHeatCapacity R "specific heat capacity";
    SI.Temperature T "temperature";
    SI.Density d "density";
    SI.SpecificEnthalpy h "specific enthalpy";
    SI.SpecificEntropy s "specific entropy";
    SI.SpecificHeatCapacity cp "heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv "heat capacity at constant volume";
    DerPressureByTemperature dpT "dp/dT derivative of saturation curve";
    DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
    DerPressureByDensity pd "derivative of pressure w.r.t. density";
    Real vt(unit="m3/(kg.K)")
      "derivative of specific volume w.r.t. temperature";
    Real vp(unit="m3/(kg.Pa)") "derivative of specific volume w.r.t. pressure";
  end IF97PhaseBoundaryProperties;

  record GibbsDerivs
    "derivatives of dimensionless Gibbs-function w.r.t. dimensionless pressure and temperature"

    extends Modelica.Icons.Record;
    SI.Pressure p "pressure";
    SI.Temperature T "temperature";
    SI.SpecificHeatCapacity R "specific heat capacity";
    Real pi(unit="1") "dimensionless pressure";
    Real tau(unit="1") "dimensionless temperature";
    Real g(unit="1") "dimensionless Gibbs-function";
    Real gpi(unit="1") "derivative of g w.r.t. pi";
    Real gpipi(unit="1") "2nd derivative of g w.r.t. pi";
    Real gtau(unit="1") "derivative of g w.r.t. tau";
    Real gtautau(unit="1") "2nd derivative of g w.r.t. tau";
    Real gtaupi(unit="1") "mixed derivative of g w.r.t. pi and tau";
  end GibbsDerivs;

  record HelmholtzDerivs
    "derivatives of dimensionless Helmholtz-function w.r.t. dimensionless pressuredensity and temperature"
    extends Modelica.Icons.Record;
    SI.Density d "density";
    SI.Temperature T "temperature";
    SI.SpecificHeatCapacity R "specific heat capacity";
    Real delta(unit="1") "dimensionless density";
    Real tau(unit="1") "dimensionless temperature";
    Real f(unit="1") "dimensionless Helmholtz-function";
    Real fdelta(unit="1") "derivative of f w.r.t. delta";
    Real fdeltadelta(unit="1") "2nd derivative of f w.r.t. delta";
    Real ftau(unit="1") "derivative of f w.r.t. tau";
    Real ftautau(unit="1") "2nd derivative of f w.r.t. tau";
    Real fdeltatau(unit="1") "mixed derivative of f w.r.t. delta and tau";
  end HelmholtzDerivs;

  record TwoPhaseTransportProps
    "defines properties on both phase boundaries, needed in the two phase region"
    extends Modelica.Icons.Record;
    SI.Density d_vap "density on the dew line";
    SI.Density d_liq "density on the bubble line";
    SI.DynamicViscosity eta_vap "dynamic viscosity on the dew line";
    SI.DynamicViscosity eta_liq "dynamic viscosity on the bubble line";
    SI.ThermalConductivity lam_vap "thermal conductivity on the dew line";
    SI.ThermalConductivity lam_liq "thermal conductivity on the bubble line";
    SI.SpecificHeatCapacity cp_vap "cp on the dew line";
    SI.SpecificHeatCapacity cp_liq "cp on the bubble line";
    SI.MassFraction x "steam quality";
  end TwoPhaseTransportProps;

  record PhaseBoundaryProperties
    "thermodynamic base properties on the phase boundary"
    extends Modelica.Icons.Record;
    SI.Density d "density";
    SI.SpecificEnthalpy h "specific enthalpy";
    SI.SpecificEnergy u "inner energy";
    SI.SpecificEntropy s "specific entropy";
    SI.SpecificHeatCapacity cp "heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv "heat capacity at constant volume";
    DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
    DerPressureByDensity pd "derivative of pressure w.r.t. density";
  end PhaseBoundaryProperties;

  record NewtonDerivatives_ph
    "derivatives for fast inverse calculations of Helmholtz functions: p & h"

    extends Modelica.Icons.Record;
    SI.Pressure p "pressure";
    SI.SpecificEnthalpy h "specific enthalpy";
    DerPressureByDensity pd "derivative of pressure w.r.t. density";
    DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
    Real hd "derivative of specific enthalpy w.r.t. density";
    Real ht "derivative of specific enthalpy w.r.t. temperature";
  end NewtonDerivatives_ph;

  record NewtonDerivatives_ps
    "derivatives for fast inverse calculation of Helmholtz functions: p & s"

    extends Modelica.Icons.Record;
    SI.Pressure p "pressure";
    SI.SpecificEntropy s "specific entropy";
    DerPressureByDensity pd "derivative of pressure w.r.t. density";
    DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
    Real sd "derivative of specific entropy w.r.t. density";
    Real st "derivative of specific entropy w.r.t. temperature";
  end NewtonDerivatives_ps;

  record NewtonDerivatives_pT
    "derivatives for fast inverse calculations of Helmholtz functions:p & T"

    extends Modelica.Icons.Record;
    SI.Pressure p "pressure";
    DerPressureByDensity pd "derivative of pressure w.r.t. density";
  end NewtonDerivatives_pT;

  record ExtraDerivatives "additional thermodynamic derivatives"
    extends Modelica.Icons.Record;
    IsentropicExponent kappa "isentropic expansion coefficient";
    // k in Bejan
    IsenthalpicExponent theta "isenthalpic exponent";
    // same as kappa, except derivative at const h
    IsobaricVolumeExpansionCoefficient alpha
      "isobaric volume expansion coefficient";
    // beta in Bejan
    IsochoricPressureCoefficient beta "isochoric pressure coefficient";
    // kT in Bejan
    IsothermalCompressibility gamma "isothermal compressibility";
    // kappa in Bejan
    JouleThomsonCoefficient mu "Joule-Thomson coefficient";
    // mu_J in Bejan
  end ExtraDerivatives;

  record BridgmansTables
    "Calculates all entries in Bridgmans tables if first seven variables given"
    extends Modelica.Icons.Record;
    // the first 7 need to calculated in a function!
    SI.SpecificVolume v "specific volume";
    SI.Pressure p "pressure";
    SI.Temperature T "temperature";
    SI.SpecificEntropy s "specific entropy";
    SI.SpecificHeatCapacity cp "heat capacity at constant pressure";
    IsobaricVolumeExpansionCoefficient alpha
      "isobaric volume expansion coefficient";
    // beta in Bejan
    IsothermalCompressibility gamma "isothermal compressibility";
    // kappa in Bejan
    // Derivatives at constant pressure
    Real dTp=1 "coefficient in Bridgmans table, see info for usage";
    Real dpT=-dTp "coefficient in Bridgmans table, see info for usage";
    Real dvp=alpha*v "coefficient in Bridgmans table, see info for usage";
    Real dpv=-dvp "coefficient in Bridgmans table, see info for usage";
    Real dsp=cp/T "coefficient in Bridgmans table, see info for usage";
    Real dps=-dsp "coefficient in Bridgmans table, see info for usage";
    Real dup=cp - alpha*p*v
      "coefficient in Bridgmans table, see info for usage";
    Real dpu=-dup "coefficient in Bridgmans table, see info for usage";
    Real dhp=cp "coefficient in Bridgmans table, see info for usage";
    Real dph=-dhp "coefficient in Bridgmans table, see info for usage";
    Real dfp=-s - alpha*p*v
      "coefficient in Bridgmans table, see info for usage";
    Real dpf=-dfp "coefficient in Bridgmans table, see info for usage";
    Real dgp=-s "coefficient in Bridgmans table, see info for usage";
    Real dpg=-dgp "coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant Temperature
    Real dvT=gamma*v "coefficient in Bridgmans table, see info for usage";
    Real dTv=-dvT "coefficient in Bridgmans table, see info for usage";
    Real dsT=alpha*v "coefficient in Bridgmans table, see info for usage";
    Real dTs=-dsT "coefficient in Bridgmans table, see info for usage";
    Real duT=alpha*T*v - gamma*p*v
      "coefficient in Bridgmans table, see info for usage";
    Real dTu=-duT "coefficient in Bridgmans table, see info for usage";
    Real dhT=-v + alpha*T*v
      "coefficient in Bridgmans table, see info for usage";
    Real dTh=-dhT "coefficient in Bridgmans table, see info for usage";
    Real dfT=-gamma*p*v "coefficient in Bridgmans table, see info for usage";
    Real dTf=-dfT "coefficient in Bridgmans table, see info for usage";
    Real dgT=-v "coefficient in Bridgmans table, see info for usage";
    Real dTg=-dgT "coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant v
    Real dsv=alpha*alpha*v*v - gamma*v*cp/T
      "coefficient in Bridgmans table, see info for usage";
    Real dvs=-dsv "coefficient in Bridgmans table, see info for usage";
    Real duv=T*alpha*alpha*v*v - gamma*v*cp
      "coefficient in Bridgmans table, see info for usage";
    Real dvu=-duv "coefficient in Bridgmans table, see info for usage";
    Real dhv=T*alpha*alpha*v*v - alpha*v*v - gamma*v*cp
      "coefficient in Bridgmans table, see info for usage";
    Real dvh=-dhv "coefficient in Bridgmans table, see info for usage";
    Real dfv=gamma*v*s "coefficient in Bridgmans table, see info for usage";
    Real dvf=-dfv "coefficient in Bridgmans table, see info for usage";
    Real dgv=gamma*v*s - alpha*v*v
      "coefficient in Bridgmans table, see info for usage";
    Real dvg=-dgv "coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant s
    Real dus=dsv*p "coefficient in Bridgmans table, see info for usage";
    Real dsu=-dus "coefficient in Bridgmans table, see info for usage";
    Real dhs=-v*cp/T "coefficient in Bridgmans table, see info for usage";
    Real dsh=-dhs "coefficient in Bridgmans table, see info for usage";
    Real dfs=alpha*v*s + dus
      "coefficient in Bridgmans table, see info for usage";
    Real dsf=-dfs "coefficient in Bridgmans table, see info for usage";
    Real dgs=alpha*v*s - v*cp/T
      "coefficient in Bridgmans table, see info for usage";
    Real dsg=-dgs "coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant u
    Real dhu=p*alpha*v*v + gamma*v*cp*p - v*cp - p*T*alpha*alpha*v*v
      "coefficient in Bridgmans table, see info for usage";
    Real duh=-dhu "coefficient in Bridgmans table, see info for usage";
    Real dfu=s*T*alpha*v - gamma*v*cp*p - gamma*v*s*p + p*T*alpha*alpha*v*v
      "coefficient in Bridgmans table, see info for usage";
    Real duf=-dfu "coefficient in Bridgmans table, see info for usage";
    Real dgu=alpha*v*v*p + alpha*v*s*T - v*cp - gamma*v*s*p
      "coefficient in Bridgmans table, see info for usage";
    Real dug=-dgu "coefficient in Bridgmans table, see info for usage";
    //  Derivatives at constant h
    Real dfh=(s - v*alpha*p)*(v - v*alpha*T) - gamma*v*cp*p
      "coefficient in Bridgmans table, see info for usage";
    Real dhf=-dfh "coefficient in Bridgmans table, see info for usage";
    Real dgh=alpha*v*s*T - v*(s + cp)
      "coefficient in Bridgmans table, see info for usage";
    Real dhg=-dgh "coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant g
    Real dfg=gamma*v*s*p - v*s - alpha*v*v*p
      "coefficient in Bridgmans table, see info for usage";
    Real dgf=-dfg "coefficient in Bridgmans table, see info for usage";
    annotation (Documentation(info="<HTML>
<p>
Important: the phase equilibrium conditions are not yet considered.
this means that bridgemans tables do not yet work in the two phase region.
Some derivatives are 0 or infinity anyways.
Idea: don't use the values in Bridgmans table directly, all
derivatives are calculated as the quotient of two entries in the
table. The last letter indicates which variable is held constant in
taking the derivative. The second letters are the two variables
involved in the derivative and the first letter is alwys a d to remind
of differentiation.
</p>

<pre>
Example 1: Get the derivative of specific entropy s w.r.t. Temperature at
constant specific volume (btw identical to constant density)
constant volume  --> last letter v
Temperature      --> second letter T
Specific entropy --> second letter s
--> the needed value is dsv/dTv
Known variables:
Temperature T
pressure p
specific volume v
specific inner energy u
specific enthalpy h
specific entropy s
specific helmholtz energy f
specific gibbs enthalpy g
Not included but useful:
density d
In order to convert derivatives involving density use the following
rules:
at constant density == at constant specific volume
ddx/dyx = -d*d*dvx/dyx with y,x any of T,p,u,h,s,f,g
dyx/ddx = -1/(d*d)dyx/dvx with y,x any of T,p,u,h,s,f,g
Usage example assuming water as the medium:
model BridgmansTablesForWater
extends ThermoFluid.BaseClasses.MediumModels.Water.WaterSteamMedium_ph;
Real derOfsByTAtConstantv \"derivative of sp. entropy by temperature at constant sp. volume\"
ThermoFluid.BaseClasses.MediumModels.Common.ExtraDerivatives dpro;
ThermoFluid.BaseClasses.MediumModels.Common.BridgmansTables bt;
equation
dpro = ThermoFluid.BaseClasses.MediumModels.SteamIF97.extraDerivs_pT(p[1],T[1]);
bt.p = p[1];
bt.T = T[1];
bt.v = 1/pro[1].d;
bt.s = pro[1].s;
bt.cp = pro[1].cp;
bt.alpha = dpro.alpha;
bt.gamma = dpro.gamma;
derOfsByTAtConstantv =  bt.dsv/bt.dTv;
                ...
end BridgmansTablesForWater;
                </pre>

                </HTML>
                "));
  end BridgmansTables;

  function gibbsToBridgmansTables
    "calculates base coefficients for bridgemans tables from gibbs enthalpy"

    extends Modelica.Icons.Function;
    input GibbsDerivs g "dimensionless derivatives of Gibbs function";
    output SI.SpecificVolume v "specific volume";
    output SI.Pressure p=g.p "pressure";
    output SI.Temperature T=g.T "temperature";
    output SI.SpecificEntropy s "specific entropy";
    output SI.SpecificHeatCapacity cp "heat capacity at constant pressure";
    output IsobaricVolumeExpansionCoefficient alpha
      "isobaric volume expansion coefficient";
    // beta in Bejan
    output IsothermalCompressibility gamma "isothermal compressibility";
    // kappa in Bejan
  protected
    Real vt(unit="m3/(kg.K)")
      "derivative of specific volume w.r.t. temperature";
    Real vp(unit="m4.kg-2.s2") "derivative of specific volume w.r.t. pressure";
  algorithm
    vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    v := (g.R*g.T*g.pi*g.gpi)/g.p;
    s := g.R*(g.tau*g.gtau - g.g);
    cp := -g.R*g.tau*g.tau*g.gtautau;
    alpha := vt/v;
    gamma := -vp/v;
  end gibbsToBridgmansTables;

  function helmholtzToBridgmansTables
    "calculates base coefficients for Bridgmans tables from helmholtz energy"
    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output SI.SpecificVolume v=1/f.d "specific volume";
    output SI.Pressure p "pressure";
    output SI.Temperature T=f.T "temperature";
    output SI.SpecificEntropy s "specific entropy";
    output SI.SpecificHeatCapacity cp "heat capacity at constant pressure";
    output IsobaricVolumeExpansionCoefficient alpha
      "isobaric volume expansion coefficient";
    // beta in Bejan
    output IsothermalCompressibility gamma "isothermal compressibility";
    // kappa in Bejan
  protected
    DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
    DerPressureBySpecificVolume pv
      "derivative of pressure w.r.t. specific volume ";
    SI.SpecificHeatCapacity cv "isochoric specific heat capacity";
  algorithm
    p := f.R*f.d*f.T*f.delta*f.fdelta;
    pv := -(f.d*f.d)*f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    s := f.R*(f.tau*f.ftau - f.f);
    alpha := -f.d*pt/pv;
    gamma := -f.d/pv;
    cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.
      fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
  end helmholtzToBridgmansTables;

  function gibbsToBoundaryProps
    "calulate phase boundary property record from dimensionless Gibbs function"

    extends Modelica.Icons.Function;
    input GibbsDerivs g "dimensionless derivatives of Gibbs function";
    output PhaseBoundaryProperties sat "phase boundary properties";
  protected
    Real vt "derivative of specific volume w.r.t. temperature";
    Real vp "derivative of specific volume w.r.t. pressure";
  algorithm
    sat.d := g.p/(g.R*g.T*g.pi*g.gpi);
    sat.h := g.R*g.T*g.tau*g.gtau;
    sat.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
    sat.s := g.R*(g.tau*g.gtau - g.g);
    sat.cp := -g.R*g.tau*g.tau*g.gtautau;
    sat.cv := g.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi - g.
       tau*g.gtaupi)/(g.gpipi));
    vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    // sat.kappa := -1/(sat.d*g.p)*sat.cp/(vp*sat.cp + vt*vt*g.T);
    sat.pt := -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
    sat.pd := -g.R*g.T*g.gpi*g.gpi/(g.gpipi);
  end gibbsToBoundaryProps;

  function helmholtzToBoundaryProps
    "calulate phase boundary property record from dimensionless Helmholtz function"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output PhaseBoundaryProperties sat "phase boundary property record";
  protected
    SI.Pressure p "pressure";
  algorithm
    p := f.R*f.d*f.T*f.delta*f.fdelta;
    sat.d := f.d;
    sat.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
    sat.s := f.R*(f.tau*f.ftau - f.f);
    sat.u := f.R*f.T*f.tau*f.ftau;
    sat.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.
       fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
    sat.cv := f.R*(-f.tau*f.tau*f.ftautau);
    sat.pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    sat.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
  end helmholtzToBoundaryProps;

  function cv2Phase
    "compute isochoric specific heat capacity inside the two-phase region"

    extends Modelica.Icons.Function;
    input PhaseBoundaryProperties liq "properties on the boiling curve";
    input PhaseBoundaryProperties vap "properties on the condensation curve";
    input SI.MassFraction x "vapour mass fraction";
    input SI.Temperature T "temperature";
    input SI.Pressure p "preoperties";
    output SI.SpecificHeatCapacity cv "isochoric specific heat capacity";
  protected
    Real dpT "derivative of pressure w.r.t. temperature";
    Real dxv "derivative of vapour mass fraction w.r.t. specific volume";
    Real dvTl "derivative of liquid specific volume w.r.t. temperature";
    Real dvTv "derivative of vapour specific volume w.r.t. temperature";
    Real duTl "derivative of liquid specific inner energy w.r.t. temperature";
    Real duTv "derivative of vapour specific inner energy w.r.t. temperature";
    Real dxt "derivative of vapour mass fraction w.r.t. temperature";
  algorithm
    dxv := if (liq.d <> vap.d) then liq.d*vap.d/(liq.d - vap.d) else 0.0;
    dpT := (vap.s - liq.s)*dxv;
    // wrong at critical point
    dvTl := (liq.pt - dpT)/liq.pd/liq.d/liq.d;
    dvTv := (vap.pt - dpT)/vap.pd/vap.d/vap.d;
    dxt := -dxv*(dvTl + x*(dvTv - dvTl));
    duTl := liq.cv + (T*liq.pt - p)*dvTl;
    duTv := vap.cv + (T*vap.pt - p)*dvTv;
    cv := duTl + x*(duTv - duTl) + dxt*(vap.u - liq.u);
  end cv2Phase;

  function cvdpT2Phase
    "compute isochoric specific heat capacity inside the two-phase region and derivative of pressure w.r.t. temperature"

    extends Modelica.Icons.Function;
    input PhaseBoundaryProperties liq "properties on the boiling curve";
    input PhaseBoundaryProperties vap "properties on the condensation curve";
    input SI.MassFraction x "vapour mass fraction";
    input SI.Temperature T "temperature";
    input SI.Pressure p "preoperties";
    output SI.SpecificHeatCapacity cv "isochoric specific heat capacity";
    output Real dpT "derivative of pressure w.r.t. temperature";
  protected
    Real dxv "derivative of vapour mass fraction w.r.t. specific volume";
    Real dvTl "derivative of liquid specific volume w.r.t. temperature";
    Real dvTv "derivative of vapour specific volume w.r.t. temperature";
    Real duTl "derivative of liquid specific inner energy w.r.t. temperature";
    Real duTv "derivative of vapour specific inner energy w.r.t. temperature";
    Real dxt "derivative of vapour mass fraction w.r.t. temperature";
  algorithm
    dxv := if (liq.d <> vap.d) then liq.d*vap.d/(liq.d - vap.d) else 0.0;
    dpT := (vap.s - liq.s)*dxv;
    // wrong at critical point
    dvTl := (liq.pt - dpT)/liq.pd/liq.d/liq.d;
    dvTv := (vap.pt - dpT)/vap.pd/vap.d/vap.d;
    dxt := -dxv*(dvTl + x*(dvTv - dvTl));
    duTl := liq.cv + (T*liq.pt - p)*dvTl;
    duTv := vap.cv + (T*vap.pt - p)*dvTv;
    cv := duTl + x*(duTv - duTl) + dxt*(vap.u - liq.u);
  end cvdpT2Phase;

  function gibbsToExtraDerivs
    "compute additional thermodynamic derivatives from dimensionless Gibbs function"

    extends Modelica.Icons.Function;
    input GibbsDerivs g "dimensionless derivatives of Gibbs function";
    output ExtraDerivatives dpro "additional property derivatives";
  protected
    Real vt "derivative of specific volume w.r.t. temperature";
    Real vp "derivative of specific volume w.r.t. pressure";
    SI.Density d "density";
    SI.SpecificVolume v "specific volume";
    SI.SpecificHeatCapacity cv "isochoric heat capacity";
    SI.SpecificHeatCapacity cp "isobaric heat capacity";
  algorithm
    d := g.p/(g.R*g.T*g.pi*g.gpi);
    v := 1/d;
    vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    cp := -g.R*g.tau*g.tau*g.gtautau;
    cv := g.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau
      *g.gtaupi)/g.gpipi);
    dpro.kappa := -1/(d*g.p)*cp/(vp*cp + vt*vt*g.T);
    dpro.theta := cp/(d*g.p*(-vp*cp + vt*v - g.T*vt*vt));
    dpro.alpha := d*vt;
    dpro.beta := -vt/(g.p*vp);
    dpro.gamma := -d*vp;
    dpro.mu := -(v - g.T*vt)/cp;
  end gibbsToExtraDerivs;

  function helmholtzToExtraDerivs
    "compute additional thermodynamic derivatives from dimensionless Helmholtz function"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output ExtraDerivatives dpro "additional property derivatives";
  protected
    SI.Pressure p "pressure";
    SI.SpecificVolume v "specific volume";
    DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
    DerPressureBySpecificVolume pv
      "derivative of pressure w.r.t. specific volume";
    SI.SpecificHeatCapacity cv "isochoric specific heat capacity";
  algorithm
    v := 1/f.d;
    p := f.R*f.d*f.T*f.delta*f.fdelta;
    pv := -(f.d*f.d)*f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    cv := f.R*(-f.tau*f.tau*f.ftautau);
    dpro.kappa := 1/(f.d*p)*((-pv*cv + pt*pt*f.T)/(cv));
    dpro.theta := -1/(f.d*p)*((-pv*cv + f.T*pt*pt)/(cv + pt*v));
    dpro.alpha := -f.d*pt/pv;
    dpro.beta := pt/p;
    dpro.gamma := -f.d/pv;
    dpro.mu := (v*pv + f.T*pt)/(pt*pt*f.T - pv*cv);
  end helmholtzToExtraDerivs;

  function Helmholtz_ph
    "function to calculate analytic derivatives for computing d and t given p and h"
    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output NewtonDerivatives_ph nderivs
      "derivatives for Newton iteration to calculate d and t from p and h";
  protected
    SI.SpecificHeatCapacity cv "isochoric heat capacity";
  algorithm
    cv := -f.R*(f.tau*f.tau*f.ftautau);
    nderivs.p := f.d*f.R*f.T*f.delta*f.fdelta;
    nderivs.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
    nderivs.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    nderivs.pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    nderivs.ht := cv + nderivs.pt/f.d;
    nderivs.hd := (nderivs.pd - f.T*nderivs.pt/f.d)/f.d;
  end Helmholtz_ph;

  function Helmholtz_pT
    "function to calculate analytic derivatives for computing d and t given p and t"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output NewtonDerivatives_pT nderivs
      "derivatives for Newton iteration to compute d and t from p and t";
  algorithm
    nderivs.p := f.d*f.R*f.T*f.delta*f.fdelta;
    nderivs.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
  end Helmholtz_pT;

  function Helmholtz_ps
    "function to calculate analytic derivatives for computing d and t given p and s"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output NewtonDerivatives_ps nderivs
      "derivatives for Newton iteration to compute d and t from p and s";
  protected
    SI.SpecificHeatCapacity cv "isochoric heat capacity";
  algorithm
    cv := -f.R*(f.tau*f.tau*f.ftautau);
    nderivs.p := f.d*f.R*f.T*f.delta*f.fdelta;
    nderivs.s := f.R*(f.tau*f.ftau - f.f);
    nderivs.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    nderivs.pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    nderivs.st := cv/f.T;
    nderivs.sd := -nderivs.pt/(f.d*f.d);
  end Helmholtz_ps;

  function smoothStep
    "Approximation of a general step, such that the characteristic is continuous and differentiable"
    extends Modelica.Icons.Function;
    input Real x "Abszissa value";
    input Real y1 "Ordinate value for x > 0";
    input Real y2 "Ordinate value for x < 0";
    input Real x_small(min=0) = 1e-5
      "Approximation of step for -x_small <= x <= x_small; x_small > 0 required";
    output Real y "Ordinate value to approximate y = if x > 0 then y1 else y2";
  algorithm
    y := smooth(1, if x >  x_small then y1 else
                   if x < -x_small then y2 else
                   if abs(x_small)>0 then (x/x_small)*((x/x_small)^2 - 3)*(y2-y1)/4 + (y1+y2)/2 else (y1+y2)/2);

    annotation(Documentation(revisions="<html>
<ul>
<li><i>April 29, 2008</i>
    by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
    Designed and implemented.</li>
<li><i>August 12, 2008</i>
    by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br>
    Minor modification to cover the limit case <code>x_small -> 0</code> without division by zero.</li>
</ul>
</html>", info="<html>
<p>
This function is used to approximate the equation
</p>
<pre>
    y = <b>if</b> x &gt; 0 <b>then</b> y1 <b>else</b> y2;
</pre>

<p>
by a smooth characteristic, so that the expression is continuous and differentiable:
</p>

<pre>
   y = <b>smooth</b>(1, <b>if</b> x &gt;  x_small <b>then</b> y1 <b>else</b>
                 <b>if</b> x &lt; -x_small <b>then</b> y2 <b>else</b> f(y1, y2));
</pre>

<p>
In the region -x_small &lt; x &lt; x_small a 2nd order polynomial is used
for a smooth transition from y1 to y2.
</p>

<p>
If <b>mass fractions</b> X[:] are approximated with this function then this can be performed
for all <b>nX</b> mass fractions, instead of applying it for nX-1 mass fractions and computing
the last one by the mass fraction constraint sum(X)=1. The reason is that the approximating function has the
property that sum(X) = 1, provided sum(X_a) = sum(X_b) = 1
(and y1=X_a[i], y2=X_b[i]).
This can be shown by evaluating the approximating function in the abs(x) &lt; x_small
region (otherwise X is either X_a or X_b):
</p>

<pre>
    X[1]  = smoothStep(x, X_a[1] , X_b[1] , x_small);
    X[2]  = smoothStep(x, X_a[2] , X_b[2] , x_small);
       ...
    X[nX] = smoothStep(x, X_a[nX], X_b[nX], x_small);
</pre>

<p>
or
</p>

<pre>
    X[1]  = c*(X_a[1]  - X_b[1])  + (X_a[1]  + X_b[1])/2
    X[2]  = c*(X_a[2]  - X_b[2])  + (X_a[2]  + X_b[2])/2;
       ...
    X[nX] = c*(X_a[nX] - X_b[nX]) + (X_a[nX] + X_b[nX])/2;
    c     = (x/x_small)*((x/x_small)^2 - 3)/4
</pre>

<p>
Summing all mass fractions together results in
</p>

<pre>
    sum(X) = c*(sum(X_a) - sum(X_b)) + (sum(X_a) + sum(X_b))/2
           = c*(1 - 1) + (1 + 1)/2
           = 1
</pre>
</html>"));
  end smoothStep;

 package OneNonLinearEquation
    "Determine solution of a non-linear algebraic equation in one unknown without derivatives in a reliable and efficient way"
   extends Modelica.Icons.Package;

    replaceable record f_nonlinear_Data
      "Data specific for function f_nonlinear"
      extends Modelica.Icons.Record;
    end f_nonlinear_Data;

    replaceable partial function f_nonlinear
      "Nonlinear algebraic equation in one unknown: y = f_nonlinear(x,p,X)"
      extends Modelica.Icons.Function;
      input Real x "Independent variable of function";
      input Real p = 0.0 "disregaded variables (here always used for pressure)";
      input Real[:] X = fill(0,0)
        "disregaded variables (her always used for composition)";
      input f_nonlinear_Data f_nonlinear_data
        "Additional data for the function";
      output Real y "= f_nonlinear(x)";
      // annotation(derivative(zeroDerivative=y)); // this must hold for all replaced functions
    end f_nonlinear;

    replaceable function solve
      "Solve f_nonlinear(x_zero)=y_zero; f_nonlinear(x_min) - y_zero and f_nonlinear(x_max)-y_zero must have different sign"
      import Modelica.Utilities.Streams.error;
      extends Modelica.Icons.Function;
      input Real y_zero
        "Determine x_zero, such that f_nonlinear(x_zero) = y_zero";
      input Real x_min "Minimum value of x";
      input Real x_max "Maximum value of x";
      input Real pressure = 0.0
        "disregaded variables (here always used for pressure)";
      input Real[:] X = fill(0,0)
        "disregaded variables (here always used for composition)";
       input f_nonlinear_Data f_nonlinear_data
        "Additional data for function f_nonlinear";
       input Real x_tol =  100*Modelica.Constants.eps
        "Relative tolerance of the result";
       output Real x_zero "f_nonlinear(x_zero) = y_zero";
    protected
       constant Real eps = Modelica.Constants.eps "machine epsilon";
       constant Real x_eps = 1e-10
        "Slight modification of x_min, x_max, since x_min, x_max are usually exactly at the borders T_min/h_min and then small numeric noise may make the interval invalid";
       Real x_min2 = x_min - x_eps;
       Real x_max2 = x_max + x_eps;
       Real a = x_min2 "Current best minimum interval value";
       Real b = x_max2 "Current best maximum interval value";
       Real c "Intermediate point a <= c <= b";
       Real d;
       Real e "b - a";
       Real m;
       Real s;
       Real p;
       Real q;
       Real r;
       Real tol;
       Real fa "= f_nonlinear(a) - y_zero";
       Real fb "= f_nonlinear(b) - y_zero";
       Real fc;
       Boolean found = false;
    algorithm
       // Check that f(x_min) and f(x_max) have different sign
       fa :=f_nonlinear(x_min2, pressure, X, f_nonlinear_data) - y_zero;
       fb :=f_nonlinear(x_max2, pressure, X, f_nonlinear_data) - y_zero;
       fc := fb;
       if fa > 0.0 and fb > 0.0 or
          fa < 0.0 and fb < 0.0 then
          error("The arguments x_min and x_max to OneNonLinearEquation.solve(..)\n" +
                "do not bracket the root of the single non-linear equation:\n" +
                "  x_min  = " + String(x_min2) + "\n" +
                "  x_max  = " + String(x_max2) + "\n" +
                "  y_zero = " + String(y_zero) + "\n" +
                "  fa = f(x_min) - y_zero = " + String(fa) + "\n" +
                "  fb = f(x_max) - y_zero = " + String(fb) + "\n" +
                "fa and fb must have opposite sign which is not the case");
       end if;

       // Initialize variables
       c :=a;
       fc :=fa;
       e :=b - a;
       d :=e;

       // Search loop
       while not found loop
          if abs(fc) < abs(fb) then
             a :=b;
             b :=c;
             c :=a;
             fa :=fb;
             fb :=fc;
             fc :=fa;
          end if;

          tol :=2*eps*abs(b) + x_tol;
          m :=(c - b)/2;

          if abs(m) <= tol or fb == 0.0 then
             // root found (interval is small enough)
             found :=true;
             x_zero :=b;
          else
             // Determine if a bisection is needed
             if abs(e) < tol or abs(fa) <= abs(fb) then
                e :=m;
                d :=e;
             else
                s :=fb/fa;
                if a == c then
                   // linear interpolation
                   p :=2*m*s;
                   q :=1 - s;
                else
                   // inverse quadratic interpolation
                   q :=fa/fc;
                   r :=fb/fc;
                   p :=s*(2*m*q*(q - r) - (b - a)*(r - 1));
                   q :=(q - 1)*(r - 1)*(s - 1);
                end if;

                if p > 0 then
                   q :=-q;
                else
                   p :=-p;
                end if;

                s :=e;
                e :=d;
                if 2*p < 3*m*q-abs(tol*q) and p < abs(0.5*s*q) then
                   // interpolation successful
                   d :=p/q;
                else
                   // use bi-section
                   e :=m;
                   d :=e;
                end if;
             end if;

             // Best guess value is defined as "a"
             a :=b;
             fa :=fb;
             b :=b + (if abs(d) > tol then d else if m > 0 then tol else -tol);
             fb :=f_nonlinear(b, pressure, X, f_nonlinear_data) - y_zero;

             if fb > 0 and fc > 0 or
                fb < 0 and fc < 0 then
                // initialize variables
                c :=a;
                fc :=fa;
                e :=b - a;
                d :=e;
             end if;
          end if;
       end while;
    end solve;

    annotation (Documentation(info="<html>
<p>
This function should currently only be used in Modelica.Media,
since it might be replaced in the future by another strategy,
where the tool is responsible for the solution of the non-linear
equation.
</p>

<p>
This library determines the solution of one non-linear algebraic equation \"y=f(x)\"
in one unknown \"x\" in a reliable way. As input, the desired value y of the
non-linear function has to be given, as well as an interval x_min, x_max that
contains the solution, i.e., \"f(x_min) - y\" and \"f(x_max) - y\" must
have a different sign. If possible, a smaller interval is computed by
inverse quadratic interpolation (interpolating with a quadratic polynomial
through the last 3 points and computing the zero). If this fails,
bisection is used, which always reduces the interval by a factor of 2.
The inverse quadratic interpolation method has superlinear convergence.
This is roughly the same convergence rate as a globally convergent Newton
method, but without the need to compute derivatives of the non-linear
function. The solver function is a direct mapping of the Algol 60 procedure
\"zero\" to Modelica, from:
</p>

<dl>
<dt> Brent R.P.:</dt>
<dd> <b>Algorithms for Minimization without derivatives</b>.
     Prentice Hall, 1973, pp. 58-59.</dd>
</dl>

<p>
Due to current limitations of the
Modelica language (not possible to pass a function reference to a function),
the construction to use this solver on a user-defined function is a bit
complicated (this method is from Hans Olsson, Dassault Syst&egrave;mes AB). A user has to
provide a package in the following way:
</p>

<pre>
  <b>package</b> MyNonLinearSolver
    <b>extends</b> OneNonLinearEquation;

    <b>redeclare record extends</b> Data
      // Define data to be passed to user function
      ...
    <b>end</b> Data;

    <b>redeclare function extends</b> f_nonlinear
    <b>algorithm</b>
       // Compute the non-linear equation: y = f(x, Data)
    <b>end</b> f_nonlinear;

    // Dummy definition that has to be present for current Dymola
    <b>redeclare function extends</b> solve
    <b>end</b> solve;
  <b>end</b> MyNonLinearSolver;

  x_zero = MyNonLinearSolver.solve(y_zero, x_min, x_max, data=data);
</pre>
</html>"));
 end OneNonLinearEquation;
  annotation (Documentation(info="<HTML><h4>Package description</h4>
      <p>Package Modelica.Media.Common provides records and functions shared by many of the property sub-packages.
      High accuracy fluid property models share a lot of common structure, even if the actual models are different.
      Common data structures and computations shared by these property models are collected in this library.
   </p>

</HTML>
", revisions="<html>
      <ul>
      <li>First implemented: <i>July, 2000</i>
      by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
      for the ThermoFluid Library with help from Jonas Eborn and Falko Jens Wagner
      </li>
      <li>Code reorganization, enhanced documentation, additional functions: <i>December, 2002</i>
      by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a> and move to Modelica
                            properties library.</li>
      <li>Inclusion into Modelica.Media: September 2003 </li>
      </ul>

      <address>Author: Hubertus Tummescheit, <br>
      Lund University<br>
      Department of Automatic Control<br>
      Box 118, 22100 Lund, Sweden<br>
      email: hubertus@control.lth.se
      </address>
</html>"));
end Common;

annotation (
  Documentation(info="<HTML>
<p>
This library contains <a href=\"modelica://Modelica.Media.Interfaces\">interface</a>
definitions for media and the following <b>property</b> models for
single and multiple substance fluids with one and multiple phases:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Media.IdealGases\">Ideal gases:</a><br>
     1241 high precision gas models based on the
     NASA Glenn coefficients, plus ideal gas mixture models based
     on the same data.</li>
<li> <a href=\"modelica://Modelica.Media.Water\">Water models:</a><br>
     ConstantPropertyLiquidWater, WaterIF97 (high precision
     water model according to the IAPWS/IF97 standard)</li>
<li> <a href=\"modelica://Modelica.Media.Air\">Air models:</a><br>
     SimpleAir, DryAirNasa, and MoistAir</li>
<li> <a href=\"modelica://Modelica.Media.Incompressible\">
     Incompressible media:</a><br>
     TableBased incompressible fluid models (properties are defined by tables rho(T),
     HeatCapacity_cp(T), etc.)</li>
<li> <a href=\"modelica://Modelica.Media.CompressibleLiquids\">
     Compressible liquids:</a><br>
     Simple liquid models with linear compressibility</li>
</ul>
<p>
The following parts are useful, when newly starting with this library:
<ul>
<li> <a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage\">Modelica.Media.UsersGuide.MediumUsage</a>
     describes how to use a medium model in a component model.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition\">
     Modelica.Media.UsersGuide.MediumDefinition</a>
     describes how a new fluid medium model has to be implemented.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.ReleaseNotes\">Modelica.Media.UsersGuide.ReleaseNotes</a>
     summarizes the changes of the library releases.</li>
<li> <a href=\"modelica://Modelica.Media.Examples\">Modelica.Media.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>
<p>
Copyright &copy; 1998-2010, Modelica Association.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</HTML>"));
end Media;
