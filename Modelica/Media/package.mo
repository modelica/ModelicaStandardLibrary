within Modelica;
package Media "Library of media property models"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;
  import Cv = Modelica.Units.Conversions;

package UsersGuide "User's Guide of Media Library"
  extends Modelica.Icons.Information;

  package MediumUsage "Medium usage"
    extends Modelica.Icons.Information;

    class BasicUsage "Basic usage"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<h4>Basic usage of medium model</h4>
<p>
Media models in Modelica.Media are provided by packages, inheriting from the
partial package Modelica.Media.Interfaces.PartialMedium. Every package defines:
</p>
<ul>
<li> Medium <strong>constants</strong> (such as the number of chemical substances,
     molecular data, critical properties, etc.).</li>
<li> A BaseProperties <strong>model</strong>, to compute the basic thermodynamic
     properties of the fluid;</li>
<li> <strong>setState_XXX</strong> functions to compute the thermodynamic state record from
     different input arguments (such as density, temperature, and composition which
     would be setState_dTX);</li>
<li> <strong>Functions</strong> to compute additional properties (such as saturation
     properties, viscosity, thermal conductivity, etc.).</li>
</ul>
<p>
There are - as stated above - two different basic ways of using the Media library which
will be described in more details in the following section. One way is to use the model BaseProperties.
Every instance of BaseProperties for any medium model provides <strong>3+nXi
equations</strong> for the following <strong>5+nXi variables</strong> that are declared in
the medium model (nXi is the number of independent mass fractions, see
explanation below):
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Variable</strong></td>
      <td><strong>Unit</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>T</td>
      <td>K</td>
      <td>temperature</td></tr>
  <tr><td>p</td>
      <td>Pa</td>
      <td>absolute pressure</td></tr>
  <tr><td>d</td>
      <td>kg/m3</td>
      <td>density</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>specific internal energy</td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>specific enthalpy (h = u + p/d)</td></tr>
  <tr><td>Xi[nXi]</td>
      <td>kg/kg</td>
      <td>independent mass fractions m_i/m</td></tr>
  <tr><td>X[nX]</td>
      <td>kg/kg</td>
      <td>All mass fractions m_i/m. X is defined in BaseProperties by:<br>
          X = <strong>if</strong> reducedX <strong>then</strong> vector([Xi; 1-<strong>sum</strong>(Xi)])
          <strong>else</strong> Xi </td></tr>
</table>
<p>
<strong>Two</strong> variables out of p, d, h, or u, as well as the
<strong>mass fractions</strong> Xi are the <strong>independent</strong> variables and the
medium model basically provides equations to compute
the remaining variables, including the full mass fraction vector X
(more details to Xi and X are given further below).
</p>
<p>
In a component, the most basic usage of a medium model is as follows
</p>
<blockquote><pre>
<strong>model</strong> Pump
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium
                       \"Medium model\" <strong>annotation</strong> (choicesAllMatching = <strong>true</strong>);
  Medium.BaseProperties medium_a \"Medium properties at location a (e.g., port_a)\";
  // Use medium variables (medium_a.p, medium_a.T, medium_a.h, ...)
   ...
<strong>end</strong> Pump;
</pre></blockquote>
<p>
The second way is to use the setState_XXX functions to compute the thermodynamic state
record from which all other thermodynamic state variables can be computed (see
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.BasicDefinition\">
Basic definition of medium</a> for further details on ThermodynamicState). The setState_XXX functions
accept either X or Xi (see explanation below) and will decide internally which of these two compositions
is provided by the user. The four fundamental setState_XXX functions are provided in PartialMedium
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Function</strong></td>
      <td><strong>Description</strong></td>
      <td><strong>Short-form for<br>single component medium</strong></td></tr>
  <tr><td>setState_dTX</td>
      <td>computes ThermodynamicState from density, temperature, and composition X or Xi</td>
      <td>setState_dT</td></tr>
  <tr><td>setState_phX</td>
      <td>computes ThermodynamicState from pressure, specific enthalpy, and composition X or Xi</td>
      <td>setState_ph</td></tr>
  <tr><td>setState_psX</td>
      <td>computes ThermodynamicState from pressure, specific entropy, and composition X or Xi</td>
      <td>setState_ps</td></tr>
  <tr><td>setState_pTX</td>
      <td>computes ThermodynamicState from pressure, temperature, and composition X or Xi</td>
      <td>setState_pT</td></tr>
</table>
<p>
The simple example that explained the basic usage of BaseProperties would then become
</p>
<blockquote><pre>
<strong>model</strong> Pump
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium
                       \"Medium model\" <strong>annotation</strong> (choicesAllMatching = <strong>true</strong>);
  Medium.ThermodynamicState state_a \"Thermodynamic state record at location a (e.g., port_a)\";
  // Compute medium variables from thermodynamic state record (pressure(state_a), temperature(state_a),
  // specificEnthalpy(state_a), ...)
  ...
<strong>end</strong> Pump;
</pre></blockquote>
<p>
All media models are directly or indirectly a subpackage of package
Modelica.Media.Interfaces.PartialMedium. Therefore,
a medium model in a component should inherit from this
partial package. Via the annotation \"choicesAllMatching = true\" it
is defined that the tool should display a selection box with
all loaded packages that inherit from PartialMedium. An example
is given in the next figure:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Media/UsersGuide/MediumUsage/mediumMenu.png\" alt=\"medium selection menu\">
</div>

<p>
A selected medium model leads, e.g., to the following equation:
</p>
<blockquote><pre>
Pump pump(<strong>redeclare package</strong> Medium = Modelica.Media.Water.SimpleLiquidWater);
</pre></blockquote>
<p>
Usually, a medium model is associated with the variables of a
fluid connector. Therefore, equations have to be defined in a model
that relate the variables in the connector with the variables
in the medium model:
</p>
<blockquote><pre>
<strong>model</strong> Pump
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium
                       \"Medium model\" <strong>annotation</strong> (choicesAllMatching = <strong>true</strong>);
  Medium.BaseProperties medium_a \"Medium properties of port_a\";
  // definition of the fluid port port_a
   ...
<strong>equation</strong>
  medium.p = port_a.p;
  medium.h = port_a.h;
  medium.Xi = port_a.Xi;
   ...
<strong>end</strong> Pump;
</pre></blockquote>
in the case of using BaseProperties or
<blockquote><pre>
<strong>model</strong> Pump
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium
                       \"Medium model\" <strong>annotation</strong> (choicesAllMatching = <strong>true</strong>);
  Medium.ThermodynamicState state_a \"Thermodynamic state record of medium at port_a\";
  // definition of the fluid port port_a
   ...
<strong>equation</strong>
  state_a = Medium.setState_phX(port_a.p, port_a.h, port_a.Xi) // if port_a contains the variables
                                                               // p, h, and Xi
   ...
<strong>end</strong> Pump;
</pre></blockquote>
<p>
in the case of using ThermodynamicState.
</p>
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
substance, <strong>nXi = 0</strong> and the vector of mass fractions Xi is not
present. If a fluid consists of nS substances,
the medium model may define the number of independent
mass fractions <strong>nXi</strong> to be <strong>nS</strong>, <strong>nS-1</strong>, or zero.
In all cases, balance equations for nXi substances have to be
given in the corresponding component (see discussion below).
Note, that if nXi = nS, the constraint \"sum(Xi)=1\" between the mass
fractions is <strong>not</strong> present in the model; in that case, it is necessary to
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
     circuits having fixed composition sources.</li>
</ul>

<p>
The full vector of mass fractions <strong>X[nX]</strong> is computed in
PartialMedium.BaseProperties based on Xi, reference_X, and the information whether Xi = nS or nS-1. For single-substance media, nX = 0, so there's also no X vector. For multiple-substance media, nX = nS, and X always contains the full vector of mass fractions. In order to reduce confusion for the user of a fluid component library, \"Xi\" has the annotation \"HideResult=true\", meaning, that this variable is not shown in the plot window. Only X is shown in the plot window and this vector always contains all mass fractions.
</p>
</html>"));
    end BasicUsage;

    class BalanceVolume "Balance volume"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
Fluid libraries usually have balance volume components with one fluid connector
port that fulfill the mass and energy balance and on a different grid components that
fulfill the momentum balance. A balance volume component, called junction
volume below, should be primarily implemented in the following way
(see also the implementation in
<a href=\"modelica://Modelica.Media.Examples.Utilities.PortVolume\">
Modelica.Media.Examples.Utilities.PortVolume</a>):
</p>
<blockquote><pre>
<strong>model</strong> JunctionVolume
  <strong>import</strong> Modelica.Units.SI;
  <strong>import</strong> Modelica.Media.Examples.Utilities.FluidPort_a;

  <strong>parameter</strong> SI.Volume V = 1e-6 \"Fixed size of junction volume\";
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium
                         \"Medium model\" <strong>annotation</strong> (choicesAllMatching = <strong>true</strong>);

  FluidPort_a port(<strong>redeclare package</strong> Medium = Medium);
  Medium.BaseProperties medium(preferredMediumStates = <strong>true</strong>);

  SI.Energy U              \"Internal energy of junction volume\";
  SI.Mass   M              \"Mass of junction volume\";
  SI.Mass   MX[Medium.nXi] \"Independent substance masses of junction volume\";
<strong>equation</strong>
  medium.p   = port.p;
  medium.h   = port.h;
  medium.Xi = port.Xi;

  M  = V*medium.d;                  // mass of JunctionVolume
  MX = M*medium.Xi;                 // mass fractions in JunctionVolume
  U  = M*medium.u;                  // internal energy in JunctionVolume

  <strong>der</strong>(M)  = port.m_flow;    // mass balance
  <strong>der</strong>(MX) = port.mX_flow;   // substance mass balance
  <strong>der</strong>(U)  = port.H_flow;    // energy balance
<strong>end</strong> JunctionVolume;
</pre></blockquote>
<p>
Assume the Modelica.Media.Air.SimpleAir medium model is used with
the JunctionVolume model above. This medium model uses pressure p
and temperature T as independent variables. If the flag
\"preferredMediumStates\" is set to <strong>true</strong> in the declaration
of \"medium\", then the independent variables of this medium model
get the attribute \"stateSelect = StateSelect.prefer\", i.e., the
Modelica translator should use these variables as states, if this
is possible. Basically, this means that
constraints between the
potential states p,T and the potential states U,M are present.
A Modelica tool will therefore <strong>automatically</strong>
differentiate medium equations and will use the following
equations for code generation (note the equations related to X are
removed, because SimpleAir consists of a single substance only):
</p>
<blockquote><pre>
M  = V*medium.d;
U  = M*medium.u;

// balance equations
<strong>der</strong>(M)  = port.m_flow;
<strong>der</strong>(U)  = port.H_flow;

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

// equations derived <strong>automatically</strong> by a Modelica tool due to index reduction
<strong>der</strong>(U) = <strong>der</strong>(M)*u + M*<strong>der</strong>(u);
<strong>der</strong>(M) = V*<strong>der</strong>(d);
<strong>der</strong>(u) = <strong>der</strong>(h) - <strong>der</strong>(p)/d - p/<strong>der</strong>(d);
<strong>der</strong>(d) = <strong>der</strong>(fd,p)*<strong>der</strong>(p) + <strong>der</strong>(fd,T)*<strong>der</strong>(T);
<strong>der</strong>(h) = <strong>der</strong>(fh,p)*<strong>der</strong>(p) + <strong>der</strong>(fd,T)*<strong>der</strong>(T);
</pre></blockquote>
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
generate equations to compute <strong>der</strong>(p) and <strong>der</strong>(T) as function of p and T.
</p>

<p>
Note, when preferredMediumStates = <strong>false</strong>, no differentiation
will take place and the Modelica translator will use the variables
appearing differentiated as states, i.e., M and U. This has the
disadvantage that for many media non-linear systems of equations are
present to compute the intrinsic properties p, d, T, u, h from
M and U.
</p>
</html>"));
    end BalanceVolume;

    class ShortPipe "Short pipe"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
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
<a href=\"modelica://Modelica.Media.Examples.Utilities.ShortPipe\">
Modelica.Media.Examples.Utilities.ShortPipe</a>):
</p>
<blockquote><pre>
<strong>model</strong> ShortPipe
  <strong>import</strong> Modelica.Units.SI;
  <strong>import</strong> Modelica.Media.Examples.Utilities;

  // parameters defining the pressure drop equation

  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium
                         \"Medium model\" <strong>annotation</strong> (choicesAllMatching = <strong>true</strong>);

  Utilities.FluidPort_a port_a (<strong>redeclare package</strong> Medium = Medium);
  Utilities.FluidPort_b port_b (<strong>redeclare package</strong> Medium = Medium);

  SI.Pressure dp = port_a.p - port_b.p \"Pressure drop\";
  Medium.BaseProperties medium_a \"Medium properties in port_a\";
  Medium.BaseProperties medium_b \"Medium properties in port_b\";
<strong>equation</strong>
  // define media models of the ports
  medium_a.p   = port_a.p;
  medium_a.h   = port_a.h;
  medium_a.Xi = port_a.Xi;

  medium_b.p   = port_b.p;
  medium_b.h   = port_b.h;
  medium_b.Xi = port_b.Xi;

  // Handle reverse and zero flow (semiLinear is a built-in Modelica operator)
  port_a.H_flow   = <strong>semiLinear</strong>(port_a.m_flow, port_a.h, port_b.h);
  port_a.mXi_flow = <strong>semiLinear</strong>(port_a.m_flow, port_a.Xi, port_b.Xi);

  // Energy, mass and substance mass balance
  port_a.H_flow + port_b.H_flow = 0;
  port_a.m_flow + port_b.m_flow = 0;
  port_a.mXi_flow + port_b.mXi_flow = zeros(Medium.nXi);

  // Provide equation: port_a.m_flow = f(dp)
<strong>end</strong> ShortPipe;
</pre></blockquote>

<p>
The <strong>semiLinear</strong>(..) operator is basically defined as:
</p>
<blockquote><pre>
semiLinear(m_flow, ha, hb) = if m_flow &ge; 0 then m_flow*ha else m_flow*hb;
</pre></blockquote>

<p>
that is, it computes the enthalpy flow rate either from the port_a or
from the port_b properties, depending on flow direction. The exact
details of this operator are given in
<a href=\"modelica://ModelicaReference.Operators.'semiLinear()'\">
ModelicaReference.Operators.'semiLinear()'</a>. Especially, rules
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
     <blockquote><pre>
medium1.h = medium2.h = port1.h = port2.h
0 = port1.H_flow + port2.H_flow
     </pre></blockquote>
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

</html>"));
    end ShortPipe;

    class OptionalProperties "Optional properties"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
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
The argument of all functions is the <strong>state</strong> record,
automatically defined by the BaseProperties model or specifically computed using the
setState_XXX functions, which contains the
minimum number of thermodynamic variables needed to compute all the additional
properties. In the table it is assumed that there is a declaration of the
form:
</p>
<blockquote><pre>
<strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium;
Medium.ThermodynamicState state;
</pre></blockquote>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Function call</strong></td>
      <td><strong>Unit</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>Medium.dynamicViscosity(state)</td>
      <td>Pa.s</td>
      <td>dynamic viscosity</td></tr>
  <tr><td>Medium.thermalConductivity(state)</td>
      <td>W/(m.K)</td>
      <td>thermal conductivity</td></tr>
  <tr><td>Medium.prandtlNumber(state)</td>
      <td>1</td>
      <td>Prandtl number</td></tr>
  <tr><td>Medium.specificEntropy(state)</td>
      <td>J/(kg.K)</td>
      <td>specific entropy</td></tr>
  <tr><td>Medium.specificHeatCapacityCp(state)</td>
      <td>J/(kg.K)</td>
      <td>specific heat capacity at constant pressure</td></tr>
  <tr><td>Medium.specificHeatCapacityCv(state)</td>
      <td>J/(kg.K)</td>
      <td>specific heat capacity at constant density</td></tr>
  <tr><td>Medium.isentropicExponent(state)</td>
      <td>1</td>
      <td>isentropic exponent</td></tr>
  <tr><td>Medium.isentropicEnthatlpy(pressure, state)</td>
      <td>J/kg</td>
      <td>isentropic enthalpy</td></tr>
  <tr><td>Medium.velocityOfSound(state)</td>
      <td>m/s</td>
      <td>velocity of sound</td></tr>
  <tr><td>Medium.isobaricExpansionCoefficient(state)</td>
      <td>1/K</td>
      <td>isobaric expansion coefficient</td></tr>
  <tr><td>Medium.isothermalCompressibility(state)</td>
      <td>1/Pa</td>
      <td>isothermal compressibility</td></tr>
  <tr><td>Medium.density_derp_h(state)</td>
      <td>kg/(m3.Pa)</td>
      <td>derivative of density by pressure at constant enthalpy</td></tr>
  <tr><td>Medium.density_derh_p(state)</td>
      <td>kg2/(m3.J)</td>
      <td>derivative of density by enthalpy at constant pressure</td></tr>
  <tr><td>Medium.density_derp_T(state)</td>
      <td>kg/(m3.Pa)</td>
      <td>derivative of density by pressure at constant temperature</td></tr>
  <tr><td>Medium.density_derT_p(state)</td>
      <td>kg/(m3.K)</td>
      <td>derivative of density by temperature at constant pressure</td></tr>
  <tr><td>Medium.density_derX(state)</td>
      <td>kg/m3</td>
      <td>derivative of density by mass fraction</td></tr>
  <tr><td>Medium.molarMass(state)</td>
      <td>kg/mol</td>
      <td>molar mass</td></tr>
</table>
<p>
There are also some short forms provided for user convenience that allow the computation of certain
thermodynamic state variables without using the ThermodynamicState record explicitly. Those short forms
are for example useful to compute consistent start values in the initial equation section. Let's
consider the function temperature_phX(p,h,X) as an example. This function computes the temperature
from pressure, specific enthalpy, and composition X (or Xi) and is a short form for writing
</p>
<blockquote><pre>
temperature(setState_phX(p,h,X))
</pre></blockquote>
<p>
The following functions are predefined in PartialMedium (other functions can be added in the actual
medium implementation package if they are useful)
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td>Medium.specificEnthalpy_pTX(p,T,X)</td>
      <td>J/kg</td>
      <td>Specific enthalpy at p, T, X </td></tr>
  <tr><td>Medium.temperature_phX(p,h,X)</td>
      <td>K</td>
      <td>Temperature at p, h, X</td></tr>
  <tr><td>Medium.density_phX(p,h,X)</td>
      <td>kg/m3</td>
      <td>Density at p, h, X</td></tr>
  <tr><td>Medium.temperature_psX(p,s,X)</td>
      <td>K</td>
      <td>Temperature at p, s, X</td></tr>
  <tr><td>Medium.specificEnthalpy_psX(p,s,X)</td>
      <td>J/(kg.K)</td>
      <td>Specific entropy at p, s, X</td></tr>
</table>
<p>
Assume for example that the dynamic viscosity eta is needed in
the pressure drop equation of a short pipe. Then, the
model of a short pipe has to be changed to:
</p>
<blockquote><pre>
<strong>model</strong> ShortPipe
    ...
  Medium.BaseProperties medium_a \"Medium properties in port_a\";
  Medium.BaseProperties medium_b \"Medium properties in port_b\";
    ...
  Medium.DynamicViscosity eta;
    ...
  eta = <strong>if</strong> port_a.m_flow &gt; 0 <strong>then</strong>
             Medium.dynamicViscosity(medium_a.state)
        <strong>else</strong>
             Medium.dynamicViscosity(medium_b.state);
  // use eta in the pressure drop equation: port_a.m_flow = f(dp, eta)
<strong>end</strong> ShortPipe;
</pre></blockquote>

<p>
Note, \"Medium.DynamicViscosity\" is a type defined in Modelica.Interfaces.PartialMedium
as
</p>

<blockquote><pre>
<strong>import</strong> Modelica.Units.SI;
<strong>type</strong> DynamicViscosity = SI.DynamicViscosity (
                                   min=0,
                                   max=1.e8,
                                   nominal=1.e-3,
                                   start=1.e-3);
</pre></blockquote>

<p>
Every medium model may modify the attributes, to provide, e.g.,
min, max, nominal, and start values adapted to the medium.
Also, other types, such as AbsolutePressure, Density, MassFlowRate,
etc. are defined in PartialMedium. Whenever possible, these medium
specific types should be used in a model in order that medium information,
e.g., about nominal or start values, are automatically utilized.
</p>
</html>"));
    end OptionalProperties;

    class Constants "Constants"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
Every medium model provides the following <strong>constants</strong>. For example,
if a medium is declared as:
</p>
<blockquote><pre>
<strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium;
</pre></blockquote>
<p>
then constants \"Medium.mediumName\", \"Medium.nX\", etc. are defined:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Type</strong></td>
      <td><strong>Name</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>String</td><td>mediumName</td>
      <td>Unique name of the medium (is usually used to check whether
          the media in different components connected together
          are the same, by providing Medium.mediumName as quantity
          attribute of the mass flow rate in the connector)</td></tr>
  <tr><td>String</td><td>substanceNames[nS]</td>
      <td>Names of the substances that make up the medium.
          If only one substance is present, substanceNames = {mediumName}.</td></tr>
  <tr><td>String</td><td>extraPropertiesNames[nC]</td>
      <td>Names of the extra transported substances, outside of mass and
          energy balances.</td></tr>
  <tr><td>Boolean</td><td>singleState</td>
      <td>= <strong>true</strong>, if u and d are not a function of pressure, and thus only
          a function of a single thermal variable (temperature or enthalpy) and
          of Xi for a multiple substance medium. Usually, this flag is
          <strong>true</strong> for incompressible media. It is used in a model to determine
          whether 1+nXi (singleState=<strong>true</strong>) or 2+nXi (singleState=<strong>false</strong>)
          initial conditions have to be provided for a volume element that
          contains mass and energy balance.</td></tr>
  <tr><td>AbsolutePressure</td><td>reference_p</td>
      <td>Reference pressure for the medium</td></tr>
  <tr><td>MassFraction</td><td>reference_X[nX]</td>
      <td>Reference composition for the medium</td></tr>
  <tr><td>AbsolutePressure</td><td>p_default</td>
      <td>Default value for pressure of medium (for initialization)</td></tr>
  <tr><td>Temperature</td><td>T_default</td>
      <td>Default value for temperature of medium (for initialization)</td></tr>
  <tr><td>SpecificEnthalpy</td><td>h_default</td>
      <td>Default value for specific enthalpy of medium (for initialization)</td></tr>
  <tr><td>MassFraction</td><td>X_default[nX]</td>
      <td>Default value for mass fractions of medium (for initialization)</td></tr>
  <tr><td>Integer</td><td>nS</td>
      <td>number of substances contained in the medium.</td></tr>
  <tr><td>Integer</td><td>nX</td>
      <td>Size of the full mass fraction vector X nX=nS.</td></tr>
  <tr><td>Integer</td><td>nXi</td>
      <td>Number of independent mass fractions. If there is a single substance,
          then nXi = 0. </td></tr>
  <tr><td>Boolean</td><td>reducedX</td>
      <td>= <strong>true</strong>, if the medium has a single substance, or if the medium model
          has multiple substances and contains the equation sum(X) = 1.
          In both cases, nXi = nS - 1 (unless fixedX = true).<br>
          = <strong>false</strong>, if the medium has multiple substances and does not contain the
          equation sum(X)=1, i.e., nXi = nX = nS (unless fixedX = true).
       </td></tr>
  <tr><td>Boolean</td><td>fixedX</td>
      <td>= <strong>false</strong>: the composition of the medium can vary, and is
          determined by nXi independent mass fractions (see reducedX above).<br>
          = <strong>true</strong>: the composition of the medium is always reference_X,
          and nXi = 0.</td></tr>
  <tr><td>FluidConstants</td><td>fluidConstants[nS]</td>
      <td>Critical, triple, molecular and other
          standard data that are provided for
          every substance of a medium.</td></tr>
</table>

<p>
The record FluidConstants that is defined in PartialMedium contains the following elements
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Type</strong></td>
      <td><strong>Name</strong></td>
      <td><strong>Description</strong></td></tr>

  <tr><td>String</td>
      <td>iupacName</td>
      <td>complete IUPAC name</td></tr>

  <tr><td>String</td>
      <td>casRegistryNumber</td>
      <td>chemical abstracts sequencing number</td></tr>

  <tr><td>String</td>
      <td>chemicalFormula</td>
      <td>Chemical formula, (brutto, nomenclature according to Hill)</td></tr>

  <tr><td>String</td>
      <td>structureFormula</td>
      <td>Chemical structure formula</td></tr>

  <tr><td>MolarMass</td>
      <td>molarMass</td>
      <td>molar mass</td></tr>
</table>

<p> This record is extended in the partial packages further down the hierarchy (such as
PartialTwoPhaseMedium or PartialMixtureMedium) and may contain some or all of the following
elements</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td>Temperature</td>
      <td>criticalTemperature</td>
      <td>critical temperature</td></tr>

  <tr><td>AbsolutePressure</td>
      <td>criticalPressure</td>
      <td>critical pressure</td></tr>

  <tr><td>MolarVolume</td>
      <td>criticalMolarVolume</td>
      <td>critical molar Volume</td></tr>

  <tr><td>Real</td>
      <td>acentricFactor</td>
      <td>Pitzer acentric factor</td></tr>

  <tr><td>Temperature</td>
      <td>triplePointTemperature</td>
      <td>triple point temperature</td></tr>

  <tr><td>AbsolutePressure</td>
      <td>triplePointPressure</td>
      <td>triple point pressure</td></tr>

  <tr><td>Temperature</td>
      <td>meltingPoint</td>
      <td>melting point at 101325 Pa</td></tr>

  <tr><td>Temperature</td>
      <td>normalBoilingPoint</td>
      <td>normal boiling point (at 101325 Pa)</td></tr>

  <tr><td>DipoleMoment</td>
      <td>dipoleMoment</td>
      <td>dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)</td></tr>

  <tr><td>Boolean</td>
      <td>hasIdealGasHeatCapacity</td>
      <td>true if ideal gas heat capacity is available</td></tr>

  <tr><td>Boolean</td>
      <td>hasCriticalData</td>
      <td>true if critical data are known</td></tr>

  <tr><td>Boolean</td>
      <td>hasDipoleMoment</td>
      <td>true if a dipole moment known</td></tr>

  <tr><td>Boolean</td>
      <td>hasFundamentalEquation</td>
      <td>true if a fundamental equation</td></tr>

  <tr><td>Boolean</td>
      <td>hasLiquidHeatCapacity</td>
      <td>true if liquid heat capacity is available</td></tr>

  <tr><td>Boolean</td>
      <td>hasSolidHeatCapacity</td>
      <td>true if solid heat capacity is available</td></tr>

  <tr><td>Boolean</td>
      <td>hasAccurateViscosityData</td>
      <td>true if accurate data for a viscosity function is available</td></tr>

  <tr><td>Boolean</td>
      <td>hasAccurateConductivityData</td>
      <td>true if accurate data for thermal conductivity is available</td></tr>

  <tr><td>Boolean</td>
      <td>hasVapourPressureCurve</td>
      <td>true if vapour pressure data, e.g., Antoine coefficients are known</td></tr>

  <tr><td>Boolean</td>
      <td>hasAcentricFactor</td>
      <td>true if Pitzer acentric factor is known</td></tr>

  <tr><td>SpecificEnthalpy</td>
      <td>HCRIT0</td>
      <td>Critical specific enthalpy of the fundamental equation</td></tr>

  <tr><td>SpecificEntropy</td>
      <td>SCRIT0</td>
      <td>Critical specific entropy of the fundamental equation</td></tr>

  <tr><td>SpecificEnthalpy</td>
      <td>deltah</td>
      <td>Difference between specific enthalpy model
          (h_m) and f.eq. (h_f) (h_m - h_f)</td></tr>

  <tr><td>SpecificEntropy</td>
      <td>deltas</td>
      <td>Difference between specific enthalpy model (s_m) and f.eq.
          (s_f) (s_m - s_f)</td></tr>

</table>

</html>"));
    end Constants;

    class TwoPhase "Two-phase media"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
Models for media which can exist in one-phase or two-phase conditions inherit
from <a href=\"modelica://Modelica.Media.Interfaces.PartialTwoPhaseMedium\">
Modelica.Media.Interfaces.PartialTwoPhaseMedium</a>
(which inherits from PartialMedium). The basic usage of these
media models is the same as described in the previous sections. However, additional
functionalities are provided, which apply only to potentially two-phase media.
</p>
<p>
The following additional medium <strong>constants</strong> are provided:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Type</strong></td>
      <td><strong>Name</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>Boolean</td>
      <td>smoothModel</td>
      <td>If this flag is false (default value), then events are triggered
          whenever the saturation boundary is crossed; otherwise, no events
      are generated.</td></tr>
  <tr><td>Boolean</td>
      <td>onePhase</td>
      <td>If this flag is true, then the medium model assumes it will be never
          called in the two-phase region. This can be useful to speed up
      the computations in a two-phase medium, when the user is sure it will
      always work in the one-phase region. Default value: false.</td></tr>
</table>
<p>
The setState_ph(), setState_ps(), setState_dT() and setState_pT() functions have
one extra input, named <em>phase</em>. If the phase input is not specified, or if
it is given a value of zero, then the setState function will determine the phase,
based on the other input values. An input phase = 1 will force the setState
function to return a state vector corresponding to a one-phase state, while
phase = 2 will force the setState value to return a state vector corresponding
to a two-phase state, as shown in the following example;
</p>
<blockquote><pre>
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
  Medium.ThermodynamicState state, state1, state2;
<strong>equation</strong>
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
</pre></blockquote>
<p>
This feature can be used for the following purposes:
</p>
<ul>
<li> saving computational time, if one knows in advance the phase of the medium;</li>
<li> unambiguously determine the phase, when the two inputs correspond to a point on the saturation boundary (the derivative functions have substantially different values on either side);</li>
<li> get the properties of metastable states, like superheated water or subcooled vapour.</li>
</ul>
<p>
Many additional optional functions are defined to compute properties of
saturated media, either liquid (bubble point) or vapour (dew point).
The argument to such functions is a SaturationProperties record, which can be
set starting from either the saturation pressure or the saturation temperature,
as shown in the following example.
</p>
<blockquote><pre>
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
  Medium.SaturationProperties sat_p;
  Medium.SaturationProperties sat_T;
<strong>equation</strong>
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
</pre></blockquote>
<p>With reference to a model defining a pressure p, a temperature T, and a
SaturationProperties record sat, the following functions are provided:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Function call</strong></td>
      <td><strong>Unit</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>Medium.saturationPressure(T)</td>
      <td>Pa</td>
      <td>Saturation pressure at temperature T</td></tr>
  <tr><td>Medium.saturationTemperature(p)</td>
      <td>K</td>
      <td>Saturation temperature at pressure p</td></tr>
  <tr><td>Medium.saturationTemperature_derp(p)</td>
      <td>K/Pa</td>
      <td>Derivative of saturation temperature with respect to pressure</td></tr>
  <tr><td>Medium.saturationTemperature_sat(sat)</td>
      <td>K</td>
      <td>Saturation temperature</td></tr>
  <tr><td>Medium.saturationPressure_sat(sat)</td>
      <td>Pa</td>
      <td>Saturation pressure</td></tr>
  <tr><td>Medium.bubbleEnthalpy(sat)</td>
      <td>J/kg</td>
      <td>Specific enthalpy at bubble point</td></tr>
  <tr><td>Medium.dewEnthalpy(sat)</td>
      <td>J/kg</td>
      <td>Specific enthalpy at dew point</td></tr>
  <tr><td>Medium.bubbleEntropy(sat)</td>
      <td>J/(kg.K)</td>
      <td>Specific entropy at bubble point</td></tr>
  <tr><td>Medium.dewEntropy(sat)</td>
      <td>J/(kg.K)</td>
      <td>Specific entropy at dew point</td></tr>
  <tr><td>Medium.bubbleDensity(sat)</td>
      <td>kg/m3</td>
      <td>Density at bubble point</td></tr>
  <tr><td>Medium.dewDensity(sat)</td>
      <td>kg/m3</td>
      <td>Density at dew point</td></tr>
  <tr><td>Medium.saturationTemperature_derp_sat(sat)</td>
      <td>K/Pa</td>
      <td>Derivative of saturation temperature with respect to pressure</td></tr>
  <tr><td>Medium.dBubbleDensity_dPressure(sat)</td>
      <td>kg/(m3.Pa)</td>
      <td>Derivative of density at bubble point with respect to pressure</td></tr>
  <tr><td>Medium.dDewDensity_dPressure(sat)</td>
      <td>kg/(m3.Pa)</td>
      <td>Derivative of density at dew point with respect to pressure</td></tr>
  <tr><td>Medium.dBubbleEnthalpy_dPressure(sat)</td>
      <td>J/(kg.Pa)</td>
      <td>Derivative of specific enthalpy at bubble point with respect to pressure</td></tr>
  <tr><td>Medium.dDewEnthalpy_dPressure(sat)</td>
      <td>J/(kg.Pa)</td>
      <td>Derivative of specific enthalpy at dew point with respect to pressure</td></tr>
  <tr><td>Medium.surfaceTension(sat)</td>
      <td>N/m</td>
      <td>Surface tension between liquid and vapour phase</td></tr>
</table>
<p>
Sometimes it can be necessary to compute fluid properties in the thermodynamic
plane, just inside or outside the saturation dome. In this case, it is possible
to obtain an instance of a ThermodynamicState state vector, and then use it
to call the additional functions already defined for one-phase media.
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Function call</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>Medium.setBubbleState(sat, phase)</td>
      <td>Obtain the thermodynamic state vector
          corresponding to the bubble point. If phase==1 (default), the state is
      on the one-phase side; if phase==2, the state is on the two-phase
      side </td></tr>
  <tr><td>Medium.setDewState(sat, phase)</td>
      <td>Obtain the thermodynamic state vector
          corresponding to the dew point. If phase==1 (default), the state is
      on the one-phase side; if phase==2, the state is on the two-phase
      side </td></tr>
  </table>
<p>
Here are some examples:
</p>
<blockquote><pre>
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
  Medium.SaturationProperties sat;
  Medium.ThermodynamicState   dew_1;    // dew point, one-phase side
  Medium.ThermodynamicState   bubble_2; // bubble point, two phase side
<strong>equation</strong>
  // Set sat to saturation properties at pressure p
  sat = setSat_p(p);

  // Compute dew point properties, (default) one-phase side
  dew_1 = setDewState(sat);
  cpDew = Medium.specificHeatCapacityCp(dew_1);
  drho_dp_h_1 = Medium.density_derp_h(dew_1);

  // Compute bubble point properties, two-phase side
  bubble_2    = setBubbleState(sat, 2);
  drho_dp_h_2 = Medium.density_derp_h(bubble_2);
</pre></blockquote>
</html>"));
    end TwoPhase;

    class Initialization "Initialization"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>

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
</p>
<blockquote><pre>
Advanced.DefaultSteadyStateInitialization = <strong>true</strong>
</pre></blockquote>
<p>
can be set before translation. Then, missing initial
conditions are provided by automatically setting appropriate
state derivatives to zero.
</p>

<h4>Explicit start values or initial equations</h4>
<p>
Explicit start values can be defined with the \"start\" and
\"fixed\" attributes. The number of independent variables nx
need to be known which can be deduced from the medium
constants (nx = nXi + <strong>if</strong> singleState <strong>then</strong> 1 <strong>else</strong> 2).
Then, start values or initial equations can be defined
for nx variables (= p, T, d, u, h, Xi) from Medium.BaseProperties,
e.g., in the form:
</p>
<blockquote><pre>
   <strong>replaceable</strong> package Medium = Medium.Interfaces.PartialMedium;
   Medium.BaseProperties medium1 (p(start=1e5, fixed=<strong>not</strong> Medium.singleState),
                                  T(start=300, fixed=<strong>true</strong>));
   Medium.BaseProperties medium2;
<strong>initial equation</strong>
   <strong>if not</strong> Medium.singleState <strong>then</strong>
      medium2.p = 1e5;
   <strong>end if</strong>;
   medium2.T = 300;
<strong>equation</strong>
</pre></blockquote>
<p>
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
a non-linear system of equations. One of the following possibilities
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
     <code>Advanced.OutputModelicaCode = <strong>true</strong></code>
     and by inspection of the file \"dsmodel.mof\" that is generated
     when this option is set (search for \"nonlinear\").</li>
</ul>
</html>"));
    end Initialization;

    annotation (DocumentationClass=true, Documentation(info="<html>
<p>
Content:
</p>
<ol>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.BasicUsage\">Basic usage of medium model</a></li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.BalanceVolume\">Medium model for a balance volume</a></li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.ShortPipe\">Medium model for a pressure loss</a></li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">Optional medium properties</a></li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.Constants\">Constants provided by medium model</a></li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">Two-phase media</a></li>
<li><a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.Initialization\">Initialization</a></li>
</ol>

<p>
A good demonstration how to use the media from Modelica.Media is
given in package ModelicaTest.Media.TestsWithFluid. Under
<a href=\"modelica://Modelica.Media.Examples.Utilities\">
Modelica.Media.Examples.Utilities</a> the most basic components of a Fluid library
are defined. Additional media models with some very simple piping networks can be found in the
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/tree/master/ModelicaTest\">ModelicaTest library</a> under
<code>ModelicaTest.Media.TestsWithFluid.MediaTestModels</code>.
</p>

</html>"));
  end MediumUsage;

  package MediumDefinition "Medium definition"
    extends Modelica.Icons.Information;

    class BasicStructure "Basic structure"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
A medium model of Modelica.Media is essentially a <strong>package</strong>
that contains the following definitions:
</p>
<ul>
<li>
Definition of <strong>constants</strong>, such as the medium name.</li>
<li>
A <strong>model</strong> in the package that contains the 3 basic
thermodynamic equations that relate the 5+nXi primary medium variables.</li>
<li><strong>Optional functions</strong> to compute medium properties that are
only needed in certain circumstances, such as dynamic viscosity. These optional
functions need not be provided by every medium model.</li>
<li>
<strong>Type</strong> definitions, which are adapted to the particular
medium. For example, a type <strong>Temperature</strong> is defined where the attributes
<strong>min</strong>
and <strong>max</strong> define the validity region of the medium, and a suitable default
start value is given. In a device model, it is advisable to use these type
definitions, e.g., for parameters, in order that medium limits are checked as
early as possible, and that iteration variables of non-linear
systems of equations get reasonable start values.</li>
</ul>
<p>
Note, although we use the term <strong>medium model</strong>, it
is actually a Modelica <strong>package</strong> that contains all the constants and
definitions required for a complete <strong>medium model</strong>. The basic interface to a
medium is defined by Modelica.Media.Interfaces.PartialMedium that has the
following structure:</p>
<blockquote><pre>
<strong>partial package</strong> PartialMedium
  <strong>import</strong> Modelica.Units.SI;
  <strong>constant</strong> String           mediumName = \"\";
  <strong>constant</strong> String           substanceNames[:] = {mediumName};
  <strong>constant</strong> String           extraPropertiesNames[:] = fill(\"\",0);
  <strong>constant</strong> Boolean          singleState = <strong>false</strong>;
  <strong>constant</strong> Boolean          reducedX = <strong>true</strong>;
  <strong>constant</strong> Boolean          fixedX = <strong>false</strong>;
  <strong>constant</strong> AbsolutePressure reference_p = 101325;
  <strong>constant</strong> MassFraction     reference_X[nX]=fill(1/nX,nX);
  <strong>constant</strong> AbsolutePressure p_default = 101325;
  <strong>constant</strong> Temperature      T_default = Modelica.Units.Conversions.from_degC(20);
  <strong>constant</strong> SpecificEnthalpy h_default =
                            specificEnthalpy_pTX(p_default, T_default, X_default);
  <strong>constant</strong> MassFraction     X_default[nX]=reference_X;
  <strong>final constant</strong> Integer    nS  = size(substanceNames,1);
  <strong>final constant</strong> Integer    nX  = nS;
  <strong>final constant</strong> Integer    nXi = <strong>if</strong> fixedX <strong>then</strong> 0
                                  <strong>else if</strong> reducedX <strong>or</strong> nS == 1
                                  <strong>then</strong> nS-1 <strong>else</strong> nS;
  <strong>final constant</strong> Integer    nC  = size(extraPropertiesNames,1);
  <strong>constant</strong> FluidConstants[nS] fluidConstants;

  <strong>replaceable record</strong> BasePropertiesRecord
    AbsolutePressure p;
    Density d;
    Temperature T;
    SpecificEnthalpy h;
    SpecificInternalEnergy u;
    MassFraction[nX] X;
    MassFraction[nXi] Xi;
    SpecificHeatCapacity R_s;
    MolarMass MM;
  <strong>end</strong> BasePropertiesRecord;

  <strong>replaceable partial model</strong> BaseProperties
    <strong>extends</strong> BasePropertiesRecord;
    ThermodynamicState state;
    <strong>parameter</strong> Boolean preferredMediumStates=false;
    Modelica.Units.NonSI.Temperature_degC T_degC =
       Modelica.Units.Conversions.to_degC(T)
    Modelica.Units.NonSI.Pressure_bar p_bar =
       Modelica.Units.Conversions.to_bar(p)
  <strong>equation</strong>
    Xi = X[1:nXi];
    <strong>if</strong> nX > 1 <strong>then</strong>
       <strong>if</strong> fixedX <strong>then</strong>
          X = reference_X;
       <strong>elseif</strong> reducedX <strong>then</strong>
          X[nX] = 1 - sum(Xi);
       <strong>end if</strong>;
    <strong>end if</strong>;
    // equations such as
    //    d = d(p,T);
    //    u = u(p,T);
    //    h = u + p/d;
    //    state.p = p;
    //    state.T = T;
    // will go here in actual media implementations, but are not present
    // in the base class since the ThermodynamicState record is still empty
   <strong>end</strong> BaseProperties

  <strong>replaceable record</strong> ThermodynamicState
     // there are no \"standard\" thermodynamic variables in the base class
     // but they will be defined here in actual media extending PartialMedium
     // Example:
     //    AbsolutePressure p \"Absolute pressure of medium\";
     //    Temperature      T \"Temperature of medium\";
  <strong>end</strong> ThermodynamicState;

  // optional medium properties
  <strong>replaceable partial function</strong> dynamicViscosity
    <strong>input</strong>  ThermodynamicState state;
    <strong>output</strong> DynamicViscosity eta;
  <strong>end</strong> dynamicViscosity;

  // other optional functions

  // medium specific types
  <strong>type</strong> AbsolutePressure = SI.AbsolutePressure (
                               min     = 0,
                               max     = 1.e8,
                               nominal = 1.e5,
                               start   = 1.e5);
  <strong>type</strong> DynamicViscosity = ...;
  // other type definitions
<strong>end</strong> PartialMedium;
</pre></blockquote>
<p>
We will discuss all parts of this package in the
following paragraphs. An actual medium model should extend from PartialMedium
and has to provide implementations of the various parts.
</p>

<p>
Some of the constants at the beginning of the package do not have a value yet
(this is valid in Modelica), but a value has to be provided when extending from
package PartialMedium. A given value can be modified until the model is
translated or the <strong>final</strong> prefix is set.
The reason to use constants instead of parameters in the model BaseProperties
is that some of these constants are used in a context where parameters
are not allowed. For example, in connector definitions the
number of independent mass fractions nXi is used as dimension
of a vector Xi. When defining the
connector, only <em>constants</em> in packages can be accessed, but not
<em>parameters</em> in a model, because a connector cannot contain an instance
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

<blockquote><pre>
<strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium;
Medium.BaseProperties   medium;
Medium.DynamicViscosity eta;
...
U   = m*medium.u; //Internal energy
eta = Medium.dynamicViscosity(medium.state);
</pre></blockquote>

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
redeclared have the <em>partial</em> attribute. For example, if function
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

<blockquote><pre>
<strong>package</strong> MyMedium
  <strong>extends</strong> Modelica.Media.Interfaces.PartialMedium(
     ...
     Temperature(min=373));
<strong>end</strong> MyMedium;
</pre></blockquote>

<p>
The type PartialMedium.MassFlowRate is defined as
</p>

<blockquote><pre>
<strong>type</strong> MassFlowRate = SI.MassFlowRate
     (quantity = \"MassFlowRate.\" + mediumName);
</pre></blockquote>

<p>Note that the constant mediumName, that has to be
defined in every medium model, is used in the quantity attribute. For example,
if mediumName = SimpleLiquidWater, then the quantity attribute has the value
MassFlowRate.SimpleLiquidWater. This type should be used in a connector
definition of a fluid library:
</p>

<blockquote><pre>
<strong>connector</strong> FluidPort
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium;
  <strong>flow</strong> Medium.MassFlowRate m_flow;
  ...
<strong>end</strong> FluidPort;
</pre></blockquote>

<p>In the model where this connector is used, the actual
Medium has to be defined. Connectors can only be connected together, if the
corresponding attributes are either not defined or have identical values. Since
mediumName is part of the quantity attribute of MassFlowRate, it is not
possible to connect connectors with different media models together.</p>
</html>"));
    end BasicStructure;

    class BasicDefinition "Basic definition"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
Let's now walk through the definition of a new medium model. Please refer to
<a href=\"modelica://Modelica.Media.Interfaces.TemplateMedium\">
Modelica.Media.Interfaces.TemplateMedium</a> to obtain a template of the new
medium model code. For the moment being, consider a single-substance medium
model.
</p>
<p>
The new medium model is obtained by extending Modelica.Media.Interfaces.PartialMedium, and
setting the following package constants:
</p>
<ul>
<li>mediumName is a String containing the name of the medium.</li>
<li>substanceNames is a vector of strings containing the names of the substances
    that make up the medium. In this case, it will contain only mediumName.</li>
<li>singleState can be set to true if u and d in BaseProperties do not depend
    on pressure. In other words, density does not depend on pressure
    (incompressible fluid), and it is assumed that also u does not depend on
    pressure. This setting can be useful for fluids having high density and
    low compressibility (e.g., liquids at moderate pressure); fast states
    resulting from the low compressibility effects are automatically avoided.</li>
<li>reducedX = true for single-substance media, which do not need mass
    fractions at all.</li>
</ul>
<p>
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
mass MM and the gas constant R_s.</p>
<p>
The third step is to consider the optional functions that are going to be
implemented, among the partial functions defined by the base class PartialMedium.
A minimal set of state variables that could be provided as an input to
<em>all</em> those functions must be selected, and included in the redeclaration
of the ThermodynamicState record. Subsequently, equations must be added to
BaseProperties in order that the instance of that record inside BaseProperties
(named \"state\") is kept updated. For example, assume that all additional
properties can be computed as a function of p and T. Then, ThermodynamicState
should be redeclared as follows:</p>
<blockquote><pre>
<strong>redeclare replaceable record</strong> ThermodynamicState
  AbsolutePressure p \"Absolute pressure of medium\";
  Temperature T \"Temperature of medium\";
<strong>end</strong> ThermodynamicState;
</pre></blockquote>
<p>
and the following equations should be added to BaseProperties:
</p>
<blockquote><pre>
state.p = p;
state.T = T;
</pre></blockquote>
<p>
The additional functions can now be implemented by redeclaring the functions
defined in the base class and adding their algorithms, e.g.:
</p>
<blockquote><pre>
<strong>redeclare function extends</strong> dynamicViscosity \"Return dynamic viscosity\"
<strong>algorithm</strong>
  eta := 10 - state.T*0.3 + state.p*0.2;
<strong>end</strong> dynamicViscosity;
</pre></blockquote>
</html>"));
    end BasicDefinition;

    class MultipleSubstances "Multiple Substances"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
When writing the model of a multiple-substance medium, a fundamental issue
concerns how to consider the mass fractions of the fluid. If there are nS
substances, there are also nS mass fractions; however, one of them is redundant,
as sum(X) = 1. Therefore there are basically two options, concerning the number
of independent mass fractions nXi:
</p>
<ul>
<li> <em>Reduced-state models</em>: reducedX = <strong>true</strong> and nXi = nS - 1. In this
case, the number of independent mass fractions nXi is the minimum possible.
The full state vector X is provided by equations declared in the base class
Interfaces.PartialMedium.BaseProperties: the first nXi elements are equal to
Xi, and the last one is 1 - sum(Xi).</li>
<li> <em>Full-state models</em>: reducedX = <strong>false</strong> and nXi = nS. In this case,
Xi = X, i.e., all the elements of the composition vector are considered as
independent variables, and the constraint sum(X) = 1 is never written explicitly.
Although this kind of model is heavier, as it provides one extra state variable,
it can be less prone to numerical and/or symbolic problems, which can be
caused by that constraint.</li>
<li> <em>Fixed-composition models</em>: fixedX = <strong>true</strong> and nXi = 0. In this case X = reference_X, i.e., all the elements of the composition vector are fixed.</li>
</ul>
<p> The medium implementer can declare the value reducedX as <strong>final</strong>. In
this way only one implementation must be given. For instance,
Modelica.Media.IdealGases models declare <strong>final</strong> reducedX = <strong>false</strong>, so that the
implementation can always assume nXi = nX. The same is true for Air.MoistAir,
which declares <strong>final</strong> reducedX = <strong>true</strong>, and always assumes nXi = nX - 1 = 1.</p>
<p>It is also possible to leave reducedX modifiable. In this case, the
BaseProperties model and all additional functions should check for the actual
value of reducedX, and provide the corresponding implementation.</p>

<p>If fixedX is left modifiable, then the implementation should also handle the
case fixedX = true properly.</p>
<p>Fluid connectors should always use composition vectors of size Xi, such as
in the Modelica.Fluid library:</p>
<blockquote><pre>
<strong>connector</strong> FluidPort
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium;
  Medium.AbsolutePressure      p;
  <strong>flow</strong> Medium.MassFlowRate     m_flow;

  Medium.SpecificEnthalpy      h;
  <strong>flow</strong> Medium.EnthalpyFlowRate H_flow;

  Medium.MassFraction          Xi    [Medium.nXi];
  <strong>flow</strong> Medium.MassFlowRate     mX_flow[Medium.nXi];
<strong>end</strong> FluidPort;
</pre></blockquote>
<p>
For further details, refer to the implementation of
<a href=\"modelica://Modelica.Media.IdealGases.Common.MixtureGasNasa\">
      MixtureGasNasa model</a> and
<a href=\"modelica://Modelica.Media.Air.MoistAir\">
      MoistAir model</a>.
</p>
</html>"));
    end MultipleSubstances;

    class SpecificEnthalpyAsFunction "Specific enthalpy as function"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
If pressure p and specific enthalpy h are <strong>not</strong> used as
independent medium variables, the specific enthalpy should
be computed by a Modelica function that has as input arguments
only the independent medium variables. It should <strong>not</strong> be
computed by an equation. For example, if p and T are used
as independent medium variables, a function h_pT(p,T) should
be defined that is called to compute h:
</p>

<blockquote><pre>
h = h_pT(p,T);
</pre></blockquote>

<p>
The reason for this rule requires a longer explanation.
In short, if h is not a computed by a Modelica function and
this function is non-linear in the independent medium variables,
then non-linear systems of equations will occur at
every connection point, if the FluidPort connectors from the
Modelica.Fluid library are used (these are the same as in
Modelica.Media.Examples.Utilities.FluidPort).
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

<div>
<img src=\"modelica://Modelica/Resources/Images/Media/UsersGuide/MediumDefinition/BalanceEquations1.png\">
</div>

<p>
Note, F<sub>F</sub> is the fanning friction factor.
The energy balance can be given in different forms.
Usually, it is given as:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Media/UsersGuide/MediumDefinition/EnergyBalance1.png\">
</div>

<p>
This form describes the change of the internal energy, kinetic
energy and potential energy of a volume as function of the
in and out flowing fluid. Multiplying the momentum balance
with the flow velocity v and subtracting it from the energy
balance above, results in the following alternative form
of the energy balance:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Media/UsersGuide/MediumDefinition/EnergyBalance2.png\">
</div>

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

<blockquote><pre>
<strong>connector</strong> FluidPort
  <strong>replaceable package</strong> Medium = Modelica.Media.Interfaces.PartialMedium;
  Medium.AbsolutePressure      p;
  <strong>flow</strong> Medium.MassFlowRate     m_flow;

  Medium.SpecificEnthalpy      h;
  <strong>flow</strong> Medium.EnthalpyFlowRate H_flow;

  Medium.MassFraction          Xi    [Medium.nXi];
  <strong>flow</strong> Medium.MassFlowRate     mX_flow[Medium.nXi];
<strong>end</strong> FluidPort;
</pre></blockquote>

<p>
As an example, assume that 3 components
are connected together and that the medium is a single substance
fluid. This will result in the following
connection equations:
</p>

<blockquote><pre>
p1=p2=p3;
h1=h2=h3;
0 = m_flow1 + m_flow2 + m_flow3;
0 = H_flow1 + H_flow2 + H_flow3;
</pre></blockquote>

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

<blockquote><pre>
0 = m_flow1*v1 + m_flow2*v2 + m_flow3*v3;
  = v*(m_flow1 + m_flow2 + m_flow3);
  = 0;
</pre></blockquote>

<p>
With the above connector it is therefore possible to
connect components together in a nearly arbitrary fashion,
because every connection fulfills automatically the
balance equations. This approach has, however, one drawback:
If two components are connected together, then the medium
variables on both sides of the connector are identical.
However, due to the connector, only the two equations
</p>

<blockquote><pre>
p1 = p2;
h1 = h2;
</pre></blockquote>

<p>
are present. Assume, that p,T are the independent medium variables
and that the medium properties are computed at one side of the
connections. This means, the following equations are basically
present:
</p>

<blockquote><pre>
h1 = h(p1,T1);
h2 = h(p2,T2);
p1 = p2;
h1 = h2;
</pre></blockquote>

<p>
These equations can be solved in the following way:
</p>

<blockquote><pre>
h1 := h(p1,T1)
p2 := p1;
h2 := h1;
0  := h2 - h(p2,T2);   // non-linear system of equations for T2
</pre></blockquote>

<p>
This means that T2 is computed by solving a non-linear system
of equations. If h1 and h2 are provided as Modelica functions,
a Modelica translator can replace
this non-linear system of equations by the equation:
</p>

<blockquote><pre>
T2 := T1;
</pre></blockquote>

<p>
because after alias substitution there are two function calls
</p>

<blockquote><pre>
h1 := h(p1,T1);
h1 := h(p1,T2);
</pre></blockquote>

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
<blockquote><pre>
  <strong>package</strong> Medium = Modelica.Media.Interfaces.PartialMedium;
  Medium.BaseProperties medium;
<strong>equation</strong>
   // mass balance
     <strong>der</strong>(M)  = port_a.m_flow + port_b.m_flow;
     <strong>der</strong>(MX) = port_a_mX_flow + port_b_mX_flow;
           M = V*medium.d;
          MX = M*medium.X;

   // Energy balance
   U = M*medium.u;
   <strong>der</strong>(U) = port_a.H_flow+port_b.H_flow;
</pre></blockquote>
<p>
<strong>Single Substance Media</strong>
</p>
<p>
A medium consisting of a single substance
has to define two of \"p,T,d,u,h\" with
stateSelect=StateSelect.prefer if BaseProperties.preferredMediumstates = <strong>true</strong>
and has to provide the other three variables as function of these
states. This results in:
</p>
<ul>
<li> static state selection (no dynamic choices).</li>
<li> a linear system of equations in the two
     state derivatives.</li>
</ul>
<p>
<strong>Example for a single substance medium</strong>
</p>
<p>
p, T are preferred states (i.e., StateSelect.prefer is set)
and there are three equations written in the form:
</p>
<blockquote><pre>
d = fd(p,T)
u = fu(p,T)
h = fh(p,T)
</pre></blockquote>
<p>
Index reduction leads to the equations:
</p>
<blockquote><pre>
<strong>der</strong>(M) = V*<strong>der</strong>(d)
<strong>der</strong>(U) = <strong>der</strong>(M)*u + M*<strong>der</strong>(u)
<strong>der</strong>(d) = <strong>der</strong>(fd,p)*<strong>der</strong>(p) + <strong>der</strong>(fd,T)*<strong>der</strong>(T)
<strong>der</strong>(u) = <strong>der</strong>(fu,p)*<strong>der</strong>(p) + <strong>der</strong>(fu,T)*<strong>der</strong>(T)
</pre></blockquote>
<p>
Note, that <strong>der</strong>(y,x) is the partial derivative of y with respect to x
and that this operator is available in Modelica only for declaring partial derivative functions,
see <a href=\"https://specification.modelica.org/v3.4/Ch12.html#partial-derivatives-of-functions\">Section&nbsp;12.7.2
(Partial Derivatives of Functions) of the Modelica 3.4 specification</a>.
</p>
<p>
The above equations imply, that if p,T are provided from the
integrator as states, all functions, such as fd(p,T)
or <strong>der</strong>(fd,p) can be evaluated as function of the states.
The overall system results in a linear system
of equations in <strong>der</strong>(p) and <strong>der</strong>(T) after eliminating
<strong>der</strong>(M), <strong>der</strong>(U), <strong>der</strong>(d), <strong>der</strong>(u) via tearing.
</p>
<p>
<strong>Counter Example for a single substance medium</strong>
</p>
<p>
An ideal gas with one substance is written in the form
</p>
<blockquote><pre>
<strong>redeclare model extends</strong> BaseProperties(
   T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
   p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default)
<strong>equation</strong>
   h = h(T);
     u = h - R_s*T;
     p = d*R_s*T;
    ...
<strong>end</strong> BaseProperties;
</pre></blockquote>
<p>
If p, T are preferred states, these equations are <strong>not</strong>
written in the recommended form, because d is not a
function of p and T. If p,T would be states, it would be
necessary to solve for the density:
</p>
<blockquote><pre>
   d = p/(R_s*T)
</pre></blockquote>
<p>
If T or R_s are zero, this results in a division by zero.
A tool does not know that R_s or T cannot become zero.
Therefore, a tool must assume that p, T <strong>cannot</strong> always be
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
     for d in the form: d = p/(T*R_s)</li>
<li> Use d,T as preferred states and write the equation
     for p in the form: p = d*T*R_s</li>
</ol>
<p>
All other settings (other/no preferred states etc.) lead
to dynamic state selection and non-linear systems of
equations for a balance volume.
</p>
<p>
<strong>Multiple Substance Media</strong>
</p>
<p>
A medium consisting of multiple substance
has to define two of \"p,T,d,u,h\" as well
as the mass fractions Xi with
stateSelect=StateSelect.prefer (if BaseProperties.preferredMediumStates = <strong>true</strong>)
and has to provide
the other three variables as functions of these
states. Only then, static selection is possible
for a tool.
</p>
<p>
<strong>Example for a multiple substance medium:</strong>
</p>
<p>
p, T and Xi are defined as preferred states and
the equations are written in the form:
</p>
<blockquote><pre>
d = fp(p,T,Xi);
u = fu(p,T,Xi);
h = fh(p,T,Xi);
</pre></blockquote>
<p>
Since the balance equations are written in the form:
</p>
<blockquote><pre>
  M = V*medium.d;
MXi = M*medium.Xi;
</pre></blockquote>
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
Modelica.Media.Examples.Utilities.PartialTestModel
which might be used in the following way:
</p>

<blockquote><pre>
<strong>model</strong> TestOfMyMedium
   <strong>extends</strong> Modelica.Media.Examples.Utilities.PartialTestModel(
            <strong>redeclare package</strong> Medium = MyMedium);
<strong>end</strong> TestOfMyMedium;
</pre></blockquote>

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
    annotation (DocumentationClass=true, Documentation(info="<html>
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
</html>"));
  end MediumDefinition;

  class ReleaseNotes "Release notes"
    extends Modelica.Icons.ReleaseNotes;
    annotation (Documentation(info="<html>
<h4>Version included in Modelica 3.0</h4>
<p> See top-level release notes for MSL.</p>
<h4>Version 1.0, 2005-03-01</h4>
<p>
Many improvements in the library, e.g., providing mixtures
of the ideal gases, table based media, test suite for all media, improved and
updated User's Guide.
</p>
<h4>Version 0.9, 2004-10-18</h4>
<ul>
<li> Changed the redeclaration/extends within packages from the
     experimental feature to the language keywords introduced
     in Modelica 2.1.</li>
<li> Re-introduced package \"Water.SaltWater\" in order to test
     substance mixtures (this medium model does not describe
     real mixing of water and salt).</li>
<li> Started to improve the documentation in
     Modelica.Media.UsersGuide.MediumDefinition.BasicStructure</li>
</ul>
<h4>Version 0.792, 2003-10-28</h4>
<p>
This is the first version made available for the public
for the Modelica'2003 conference (for evaluation).
</p>
</html>"));
  end ReleaseNotes;

  class Contact "Contact"
    extends Modelica.Icons.Contact;
    annotation (Documentation(info="<html>
<h4>Library officer and main author</h4>

<p>
<strong>Hubertus Tummescheit</strong><br>
Modelon AB<br>
Ideon Science Park<br>
SE-22730 Lund, Sweden<br>
email: <a href=\"mailto:Hubertus.Tummescheit@Modelon.se\">Hubertus.Tummescheit@Modelon.se</a>
</p>

<h4>Acknowledgements</h4>

<p>
The development of this library has been a collaborative effort
and many have contributed:
</p>
<ul>
<li> The essential parts of the media models have been implemented
     in the ThermoFluid library by Hubertus Tummescheit with
     help from Jonas Eborn and Falko Jens Wagner. These media models
     have been converted to the Modelica.Media interface definition
     and have been improved by Hubertus Tummescheit.</li>
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

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
Library <strong>Modelica.Media</strong> is a <strong>free</strong> Modelica package providing
a standardized interface to fluid media models and specific
media models based on this interface.
A fluid medium model defines <strong>algebraic</strong> equations
for the intensive thermodynamic variables used in the <strong>mass</strong>
and <strong>energy</strong> balance of component models. Optionally, additional
medium properties can be computed such as dynamic viscosity or thermal
conductivity. Medium models are defined for <strong>single</strong> and
<strong>multiple substance</strong> fluids with <strong>one</strong> and
<strong>multiple phases</strong>.
</p>
<p>
A large part of the library provides specific medium models
that can be directly utilized. This library can be used in
all types of Modelica fluid libraries that may have different connectors
and design philosophies. It is particularly utilized
in the Modelica.Fluid library (1D therm-fluid flow components for
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
     connect two components and not more). Note, the Modelica.Fluid
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
<li><a href=\"modelica://Modelica.Media.UsersGuide.Contact\">Contact</a>
    provides information about the authors of the library as well as
    acknowledgements.</li>
</ul>
</html>"));
end UsersGuide;

package Examples
  "Demonstrate usage of property models"

  extends Modelica.Icons.ExamplesPackage;

  model SimpleLiquidWater "Example for Water.SimpleLiquidWater medium model"
    extends Modelica.Icons.Example;

    parameter SI.Volume V=1 "Volume";
    parameter SI.EnthalpyFlowRate H_flow_ext=1.e6
      "Constant enthalpy flow rate into the volume";

    package Medium = Water.ConstantPropertyLiquidWater (SpecificEnthalpy(max=
              1e6)) "Medium model";
    Medium.BaseProperties medium(T(start=300, fixed=true));

    Medium.BaseProperties medium2;
    Medium.ThermodynamicState state;
    Real m_flow_ext2;
    Real der_p;
    Real der_T;

    SI.Mass m(start=1.0);
    SI.InternalEnergy U;

    // Use type declarations from the Medium
    Medium.MassFlowRate m_flow_ext;
    Medium.DynamicViscosity eta=Medium.dynamicViscosity(state);
    Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(state);
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
    state = Medium.setSmoothState(
          m_flow_ext2,
          medium.state,
          medium2.state,
          10);
    der_p = der(state.p);
    der_T = der(state.T);
    annotation (experiment(StopTime=100), Documentation(info="<html>

</html>"));
  end SimpleLiquidWater;

  model IdealGasH2O "IdealGas H20 medium model"
    extends Modelica.Icons.Example;
    package Medium = IdealGases.SingleGases.H2O "Medium model";
    Medium.ThermodynamicState state "Thermodynamic state record";
    Medium.ThermodynamicState state2;
    Medium.SpecificHeatCapacity cp=Medium.specificHeatCapacityCp(state);
    Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(state);
    Medium.IsentropicExponent k=Medium.isentropicExponent(state);
    Medium.SpecificEntropy s=Medium.specificEntropy(state);
    //  Medium.SpecificEntropy s2=Medium.specificEntropy(state2);
    Medium.VelocityOfSound a=Medium.velocityOfSound(state);
    Real beta=Medium.isobaricExpansionCoefficient(state);
    Real gamma=Medium.isothermalCompressibility(state);
    Medium.SpecificEnthalpy h_is=Medium.isentropicEnthalpyApproximation(2.0,
        state);

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
    smoothState = Medium.setSmoothState(
          m_flow_ext,
          state,
          state2,
          0.1);
    der_p = der(smoothState.p);
    der_T = der(smoothState.T);

    annotation (Documentation(info="<html>
<p>An example for using ideal gas properties and how to compute isentropic enthalpy changes.
The function that is implemented is approximate, but usually very good: the second medium record medium2
is given to compare the approximation.
</p>
</html>"), experiment(StopTime=1));
  end IdealGasH2O;

  model WaterIF97 "WaterIF97 medium model"
    extends Modelica.Icons.Example;
    package Medium = Water.StandardWater "Medium model";
    Medium.BaseProperties medium(
      p(start=1.e5,
        fixed=true,
        stateSelect=StateSelect.prefer),
      h(start=1.0e5,
        fixed=true,
        stateSelect=StateSelect.prefer),
      T(start=275.0),
      d(start=999.0));
    SI.Volume V(start=0.1, fixed=true);
    parameter SI.VolumeFlowRate dV=0.0
      "Fixed time derivative of volume";
    parameter Medium.MassFlowRate m_flow_ext=0
      "Fixed mass flow rate into volume";
    parameter Medium.EnthalpyFlowRate H_flow_ext=10000
      "Fixed enthalpy flow rate into volume";
    SI.Mass m "Mass of volume";
    SI.InternalEnergy U "Internal energy of volume";

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
    state2 = Medium.setState_pT(1e5*(1 + time), 300 + 200*time);
    state = Medium.setSmoothState(
          m_flow_ext2,
          medium.state,
          state2,
          0.05);
    der_p = der(state.p);
    der_T = der(state.T);
    annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1));
  end WaterIF97;

  model MixtureGases "Test gas mixtures"
    extends Modelica.Icons.Example;

    parameter SI.Volume V=1 "Fixed size of volume 1 and volume 2";
    parameter SI.MassFlowRate m_flow_ext=0.01
      "Fixed mass flow rate into volume 1 and into volume 2";
    parameter SI.EnthalpyFlowRate H_flow_ext=5000
      "Fixed enthalpy flow rate into volume 1 and into volume 2";

    package Medium1 = Modelica.Media.IdealGases.MixtureGases.CombustionAir
      "Medium model";
    Medium1.BaseProperties medium1(
      p(start=1.e5,
        fixed=true,
        stateSelect=StateSelect.prefer),
      T(start=300,
        fixed=true,
        stateSelect=StateSelect.prefer),
      X(start={0.8,0.2}));
    Real m1(quantity=Medium1.mediumName, start=1.0);
    SI.InternalEnergy U1;
    Medium1.SpecificHeatCapacity cp1=Medium1.specificHeatCapacityCp(medium1.state);
    Medium1.DynamicViscosity eta1=Medium1.dynamicViscosity(medium1.state);
    Medium1.ThermalConductivity lambda1=Medium1.thermalConductivity(medium1.state);

    package Medium2 = Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas
      "Medium model";
    Medium2.BaseProperties medium2(
      p(start=1.e5,
        fixed=true,
        stateSelect=StateSelect.prefer),
      T(start=300,
        fixed=true,
        stateSelect=StateSelect.prefer),
      X(start={0.1,0.1,0.1,0.2,0.2,0.3}));
    Real m2(quantity=Medium2.mediumName, start=1.0);
    SI.InternalEnergy U2;
    Medium2.SpecificHeatCapacity cp2=Medium2.specificHeatCapacityCp(medium2.state);
    Medium2.DynamicViscosity eta2=Medium2.dynamicViscosity(medium2.state);
    Medium2.ThermalConductivity lambda2=Medium2.thermalConductivity(medium2.state);

    Medium2.ThermodynamicState state2=Medium2.setState_pTX(
            1.005e5,
            302,
            {0.3,0.2,0.2,0.1,0.1,0.1});
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

    medium2.X = {0.1,0.1,0.1,0.2,0.2,0.3};
    m2 = medium2.d*V;
    U2 = m2*medium2.u;
    der(m2) = m_flow_ext;
    der(U2) = H_flow_ext;

    // Smooth state
    m_flow_ext2 = time - 0.5;
    smoothState = Medium2.setSmoothState(
          m_flow_ext2,
          medium2.state,
          state2,
          0.2);
    der_p = der(smoothState.p);
    der_T = der(smoothState.T);
    annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1));
  end MixtureGases;

  model MoistAir "Example for moist air"
    extends Modelica.Icons.Example;
    package Medium = Air.MoistAir "Medium model";
    Medium.BaseProperties medium(
      T(start=274.0, fixed=true),
      X(start={0.95,0.05}),
      p(start=1.0e5, fixed=true));
    //  Medium.SpecificEntropy s=Medium.specificEntropy(medium);
    //  Medium.SpecificEnthalpy h_is = Medium.isentropicEnthalpyApproximation(medium, 2.0e5);
    parameter Medium.MolarMass[2] MMx={Medium.dryair.MM,Medium.steam.MM}
      "Vector of molar masses (consisting of dry air and of steam)";
    Medium.MolarMass MM=1/((1 - medium.X[1])/MMx[1] + medium.X[1]/MMx[2])
      "Molar mass of gas part of mixture";
    //  Real[4] dddX=Medium.density_derX(medium,MM);

    Medium.ThermodynamicState state1;
    Medium.ThermodynamicState state2;
    Medium.ThermodynamicState smoothState;
    Real m_flow_ext;
    Real der_p;
    Real der_T;
  protected
    constant SI.Time unitTime=1;
  equation
    der(medium.p) = 0.0;
    der(medium.T) = 90;
    medium.X[Medium.Air] = 0.95;
    //    medium.X[Medium.Water] = 0.05;
    // one simple assumption only for quick testing:
    //  medium.X_liquidWater = if medium.X_sat < medium.X[2] then medium.X[2] - medium.X_sat else 0.0;

    // Smooth state
    m_flow_ext = time - 0.5;
    state1.p = 1.e5*(1 + time);
    state1.T = 300 + 10*time;
    state1.X = {time,1 - time}/unitTime;
    state2.p = 1.e5*(1 + time/2);
    state2.T = 340 - 20*time;
    state2.X = {0.5*time,1 - 0.5*time}/unitTime;
    smoothState = Medium.setSmoothState(
          m_flow_ext,
          state1,
          state2,
          0.2);
    der_p = der(smoothState.p);
    der_T = der(smoothState.T);
    annotation (Documentation(info="<html>

</html>"), experiment(StopTime=1.0, Tolerance=1e-005));
  end MoistAir;

  model PsychrometricData "Produces plot data for psychrometric charts"
    extends Modelica.Icons.Example;
    package Medium = Modelica.Media.Air.MoistAir "Used medium package";
    parameter SI.Pressure p_const=1e5 "Pressure";
    parameter Integer n_T=11 "Number of isotherms";
    parameter SI.Temperature T_min=253.15 "Lowest isotherm";
    parameter SI.Temperature T_step=10
      "Temperature step between two isotherms";
    parameter Integer n_h=16 "Number of lines with constant specific enthalpy";
    parameter SI.SpecificEnthalpy h_min=-20e3
      "Lowest line of constant enthalpy";
    parameter SI.SpecificEnthalpy h_step=1e4
      "Enthalpy step between two lines of constant enthalpy";
    parameter Integer n_phi=10
      "Number of lines with constant relative humidity";
    parameter Real phi_min=0.1 "Lowest line of constant humidity";
    parameter Real phi_step=0.1 "Step between two lines of constant humidity";
    parameter SI.MassFraction x_min=0.00
      "Minimum diagram absolute humidity";
    parameter SI.MassFraction x_max=0.03
      "Maximum diagram absolute humidity";
    parameter SI.Time t=1 "Simulation time";

    final parameter SI.Temperature[n_T] T_const={T_min - T_step + i*
        T_step for i in 1:n_T} "Constant temperatures";
    final parameter SI.SpecificEnthalpy[n_h] h_const={(i - 1)*h_step +
        h_min for i in 1:n_h} "Constant enthalpies";
    final parameter Real[n_phi] phi_const={(i - 1)*phi_step + phi_min for i in
            1:n_phi} "Constant relative humidities";
    final parameter Real diagSlope=Medium.enthalpyOfVaporization(273.15)
      "Rotation of diagram that zero degrees isotherm becomes horizontal outside the fog region";
    final parameter SI.MassFraction x_start=x_min
      "Initial absolute humidity in kg water/kg dry air";

    SI.MassFraction x(start=x_start)
      "Absolute humidity in kg water/kg dry air";
    SI.SpecificEnthalpy[n_T] hx_T "h_1+x for const T";
    SI.SpecificEnthalpy[n_h] hx_h(start=h_const, each fixed=true)
      "Const h_1+x";
    SI.SpecificEnthalpy[n_phi] hx_phi "h_1+x for const phi";
    SI.SpecificEnthalpy[n_T] y_T "Chart enthalpy for const T";
    SI.SpecificEnthalpy[n_h] y_h "Chart enthalpy for const h";
    SI.SpecificEnthalpy[n_phi] y_phi "Chart enthalpy for const phi";
    Medium.BaseProperties[n_T] medium_T "Medium properties for const T";
    Medium.BaseProperties[n_phi] medium_phi "Medium properties for const phi";

  protected
    SI.Pressure[n_phi] ps_phi "Saturation pressure for constant-phi-lines";
    SI.Temperature[n_phi] T_phi(each start=290);
    Boolean[n_T] fog(start=fill(false, n_T))
      "Triggers events at intersection of isotherms with phi=1";
    SI.Pressure[n_T] pd "Steam partial pressure along isotherms";
  initial equation
    x = x_min;
  equation

    der(x) = (x_max - x_min)/t;

    for i in 1:n_T loop
      medium_T[i].T = T_const[i];
      medium_T[i].p = p_const;
      medium_T[i].Xi = {x/(1 + x)};
      hx_T[i] = medium_T[i].h*(medium_T[i].x_water + 1);
      y_T[i] = hx_T[i] - diagSlope*x;

      //trigger events
      pd[i] = medium_T[i].Xi[1]*medium_T[i].MM/Medium.MMX[1]*p_const;
      fog[i] = pd[i] >= Medium.saturationPressure(T_const[i]);
    end for;
    for i in 1:n_h loop
      der(hx_h[i]) = 0.0;
      y_h[i] = hx_h[i] - diagSlope*x;
    end for;
    for i in 1:n_phi loop
      medium_phi[i].p = p_const;
      ps_phi[i] = p_const*x/phi_const[i]/(Medium.k_mair + x);
      T_phi[i] = if x < 5e-6 then 200 else Medium.saturationTemperature(
        ps_phi[i]);
      medium_phi[i].T = T_phi[i];
      medium_phi[i].Xi = {x/(1 + x)};
      hx_phi[i] = medium_phi[i].h*(medium_phi[i].x_water + 1);
      y_phi[i] = hx_phi[i] - diagSlope*x;
    end for;

    annotation (Documentation(info="<html>
<p>This model produces psychrometric data from the moist air model in this library to be plotted in charts. The two most common chart varieties are the Mollier Diagram and the Psychrometric Chart. The first is widely used in some European countries while the second is more common in the Anglo-American world. Specific enthalpy is plotted over absolute humidity in the Mollier Diagram, it is the other way round in the Psychrometric Chart.<br>
It must be noted that the relationship of both axis variables is not right-angled, the absolute humidity follows a slope which equals the enthalpy of vaporization at 0 &deg;C. For better reading and in order to reduce the fog region the humidity axis is rotated to obtain a right-angled plot. Both charts usually contain additional information as isochores or auxiliary scales for e.g., heat ratios. Those information are omitted in this model and the charts below. Other important features of psychrometric chart data are that all mass specific variables (like absolute humidity, specific enthalpy etc.) are expressed in terms of kg dry air and that their baseline of 0 enthalpy is found at 0 &deg;C and zero humidity.</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Media/Air/Mollier.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Media/Air/PsycroChart.png\">
</div>

<p>
<strong>Legend:</strong> blue - constant specific enthalpy, red - constant temperature, black - constant relative humidity</p>

<p>The model provides data for lines of constant specific enthalpy, temperature and relative humidity in a Mollier Diagram or Psychrometric Chart as they were used for the figures above. For limitations and ranges of validity please refer to the <a href=\"modelica://Modelica.Media.Air.MoistAir\">MoistAir package description</a>. Absolute humidity <strong>x</strong> is increased with time in this model. The specific enthalpies adjusted for plotting are then obtained from:</p>
<ul>
<li><strong>y_h</strong>: constant specific enthalpy</li>
<li><strong>y_T</strong>: constant temperature</li>
<li><strong>y_phi</strong>: constant relative humidity</li>
</ul>
</html>"), experiment(StopTime=1.0, Interval=0.001));
  end PsychrometricData;

  package TwoPhaseWater "Extension of the StandardWater package"
    extends Modelica.Media.Water.StandardWater;
    redeclare model extends BaseProperties
      "Make StandardWater.BaseProperties non replaceable in order that inheritance is possible in model ExtendedProperties"
    end BaseProperties;

    model ExtendedProperties "Plenty of two-phase properties"
      extends BaseProperties;
      ThermodynamicState dew "Dew line Properties";
      ThermodynamicState bubble "Bubble line Properties";
      ThermodynamicState bubble2 "Bubble line Properties, on the 2-phase side";
      DynamicViscosity eta "Viscosity (McAdams mixture rules if in 2-phase)";
      DynamicViscosity eta_d "Dew line viscosity";
      DynamicViscosity eta_b "Bubble line viscosity";
      ThermalConductivity lambda_d "Dew line thermal conductivity";
      ThermalConductivity lambda_b "Bubble line thermal conductivity";
      SpecificHeatCapacity cp_d "Dew line Specific heat capacity";
      SpecificHeatCapacity cp_b "Bubble line Specific heat capacity";
      Real ddhp;
      Real ddhp_d;
      Real ddhp_b "Derivatives";
      Real ddph;
      Real ddph_d;
      Real ddph_b "Derivatives";
      Real ddhp_b2;
      Real ddph_b2 "Derivatives";
      // no derivatives yet, ... sat should be temporary
      MassFraction x "Steam mass fraction";
      Real dTp;
      Real dTp2;
      SpecificEntropy s_b;
      SpecificEntropy s_d;
    equation
      eta = if phase == 1 then dynamicViscosity(state) else 1/(x/eta_d + (1 - x)
        /eta_b);
      dew = setDewState(sat);
      bubble = setBubbleState(sat);
      bubble2 = setBubbleState(sat, 2);
      x = (h - bubble.h)/max(dew.h - bubble.h, 1e-6);
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
      dTp2 = (1/dew.d - 1/bubble.d)/max(s_d - s_b, 1e-6);
      annotation (Documentation(info="<html>
</html>"));
    end ExtendedProperties;

    model TestTwoPhaseStates "Test the TwoPhaseWater model"
      extends Modelica.Icons.Example;
      ExtendedProperties medium(p(start=2000.0, fixed=true), h(start=8.0e5,
            fixed=true));
      parameter Real dh(unit="J/(kg.s)", displayUnit="kJ/(kg.s)")=80000.0 "Derivative of specific enthalpy of medium";
      parameter Real dp(unit="Pa/s", displayUnit="bar/s")=1.0e6 "Derivative of pressure of medium";
    equation
      der(medium.p) = dp;
      der(medium.h) = dh;
      annotation (experiment(StopTime=22, Interval=0.01), Documentation(info="<html>
<p> For details see the documentation of the example package TwoPhaseWater</p>
</html>"));
    end TestTwoPhaseStates;
    annotation (Documentation(info="<html>
<h4>Example: TwoPhaseWater</h4>
The TwoPhaseWater package demonstrates how to extend the parsimonious
BaseProperties with a minimal set of properties from the standard water
package with most properties that are needed in two-phase situations.
The model also demonstrates how to compute additional&nbsp; properties
for the medium model. In this scenario, that builds a new medium model
with many more properties than the default, the standard BaseProperties
is used as a basis. For additional properties, a user has to:<br>
<ol>
<li>Declare a new variable of the wanted type, e.g., \"<span style=\"color: rgb(51, 51, 255);\">DynamicViscosity
eta</span>\".</li>
<li>Compute that variable by calling the function form the package,
e.g., <span style=\"color: rgb(51, 51, 255);\">eta =
dynamicViscosity(state)</span>. Note that the instance of
ThermodynamicState is used as an input to the function. This instance
\"state\" is declared in PartialMedium and thus available in every medium
model. A user does not have to know what actual variables are required
to compute the dynamic viscosity, because the state instance is
guaranteed to contain what is needed.</li>
<li><span style=\"color: rgb(255, 0, 0);\">Attention</span>: Many
properties are not well defined in the two phase region and the
functions might return undesired values if called there. It is the
user's responsibility&nbsp; to take care of such situations. The example
uses one of several possible models to compute an averaged viscosity
for two-phase flows.</li>
</ol>
In two phase models, properties are often needed on the phase boundary
just outside the two phase dome, right on the border.. To compute the
thermodynamic state there, two auxiliary functions are provided: <strong>setDewState(sat)</strong> and <strong>setBubbleState(sat)</strong>. They take an
instance of SaturationProperties as input. By default they are in
one-phase, but with the optional phase argument set to 2, the output is
forced to be just inside the phase boundary. This is only needed when
derivatives like cv are computed with are different on both sides of
the boundaries. The usual steps to compute properties on the phase
boundary are:<br>
<ol>
<li>Declare an instance of ThermodynamicState, e.g., \"ThermodynamicState&nbsp; dew\".</li>
<li>Compute the state, using an instance of SaturationProperties,
e.g., dew = setDewState(sat)</li>
<li>Compute properties on the phase boundary to your full desire,
e.g., \"cp_d = specificHeatCapacityCp(dew)\".<br>
</li>
</ol>
<p>The sample model TestTwoPhaseStates test the extended properties</p>

<p>
The same procedure can be used to compute properties at other state
points, e.g., when an isentropic reference state is computed.
</p>
</html>"));
  end TwoPhaseWater;

  package ReferenceAir
    "Examples for detailed dry air and moist air medium models"
    extends Modelica.Icons.ExamplesPackage;

    model DryAir1 "Example 1 for dry air"
      extends Modelica.Icons.Example;
      extends Modelica.Media.Examples.Utilities.PartialTestModel(
          redeclare package Medium = Modelica.Media.Air.ReferenceAir.Air_pT);
      annotation (experiment(StopTime=1.01));
    end DryAir1;

    model DryAir2 "Example 2 for dry air"
      extends Modelica.Icons.Example;
      extends Modelica.Media.Examples.Utilities.PartialTestModel2(
          redeclare package Medium = Modelica.Media.Air.ReferenceAir.Air_pT);
      annotation (experiment(StopTime=1.01));
    end DryAir2;

    model MoistAir "Example for moist air"
      extends Modelica.Icons.Example;
      parameter SI.Temperature T_start=274
        "Initial guess value for temperature";
      parameter SI.Pressure p_start=1e5
        "Initial guess value for pressure";
      package Medium = Modelica.Media.Air.ReferenceMoistAir "Medium model";
      Medium.BaseProperties medium(
        T(start=T_start, fixed=true),
        X(start={0.95,0.05}),
        p(start=p_start, fixed=true));
      parameter Medium.MolarMass[2] MMx={Medium.dryair.MM,Medium.steam.MM}
        "Vector of molar masses (consisting of dry air and of steam)";
      Medium.MolarMass MM=1/((1 - medium.X[1])/MMx[1] + medium.X[1]/MMx[2])
        "Molar mass of gas part of mixture";
      Medium.ThermodynamicState state1;
      Medium.ThermodynamicState state2;
      Medium.ThermodynamicState smoothState(T(start=T_start), p(start=p_start));
      Real m_flow_ext;
      Real der_p;
      Real der_T;
    protected
      constant SI.Time unitTime=1;
    equation
      der(medium.p) = 0.0;
      der(medium.T) = 90;
      medium.X[Medium.Air] = 0.95;
      m_flow_ext = time - 0.5;
      state1.p = 1.e5*(1 + time);
      state1.T = 300 + 10*time;
      state1.X = {time,1 - time}/unitTime;
      state2.p = 1.e5*(1 + time/2);
      state2.T = 340 - 20*time;
      state2.X = {0.5*time,1 - 0.5*time}/unitTime;
      smoothState = Medium.setSmoothState(
              m_flow_ext,
              state1,
              state2,
              0.2);
      der_p = der(smoothState.p);
      der_T = der(smoothState.T);
      annotation (experiment(StopTime=1.0, Tolerance=1e-005));
    end MoistAir;

    model MoistAir1 "Example 1 for moist air"
      extends Modelica.Icons.Example;
      extends Modelica.Media.Examples.Utilities.PartialTestModel(
          redeclare package Medium = Modelica.Media.Air.ReferenceMoistAir);
      annotation (experiment(StopTime=1.01));
    end MoistAir1;

    model MoistAir2 "Example 2 for moist air"
      extends Modelica.Icons.Example;
      extends Modelica.Media.Examples.Utilities.PartialTestModel2(
          redeclare package Medium = Modelica.Media.Air.ReferenceMoistAir);
      annotation (experiment(StopTime=1.01));
    end MoistAir2;

    model Inverse_sh_T
      "Solve h = h_pT(p, T), s = s_pT(p, T) for T, if h or s is given"
      extends Modelica.Icons.Example;

      import Medium = Modelica.Media.Air.ReferenceAir.Air_pT "Medium model";

      parameter SI.Temperature T_min=300
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Temperature T_max=500
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Pressure p=1.0e5 "Fixed pressure in model";
      final parameter SI.SpecificEnthalpy h_min=
          Medium.specificEnthalpy(Medium.setState_pT(p, T_min))
        "Specific enthalpy at T_min";
      final parameter SI.SpecificEnthalpy h_max=
          Medium.specificEnthalpy(Medium.setState_pT(p, T_max))
        "Specific enthalpy at T_max";
      final parameter SI.SpecificEntropy s_min=
          Medium.specificEntropy(Medium.setState_pT(p, T_min))
        "Specific entropy at T_min";
      final parameter SI.SpecificEntropy s_max=
          Medium.specificEntropy(Medium.setState_pT(p, T_max))
        "Specific entropy at T_max";
      SI.SpecificEnthalpy h1 "Pre-defined specific enthalpy";
      SI.SpecificEnthalpy h2
        "Specific enthalpy computed from T (= h1 required)";
      SI.SpecificEntropy s1 "Pre-defined specific entropy";
      SI.SpecificEntropy s2
        "Specific entropy computed from T (= h1 required)";
      SI.Temperature Th "Temperature computed from h1";
      SI.Temperature Ts "Temperature computed from s1";

    protected
      constant SI.Time timeUnit=1.0;

    equation
      // Define specific enthalpy and specific entropy
      h1 = if time < 0 then h_min else if time >= 1 then h_max else h_min + time
        /timeUnit*(h_max - h_min);
      s1 = if time < 0 then s_min else if time >= 1 then s_max else s_min + time
        /timeUnit*(s_max - s_min);

      // Solve for temperature
      Th = Medium.temperature_phX(
              p,
              h1,
              fill(0.0, 0));
      Ts = Medium.temperature_psX(
              p,
              s1,
              fill(0.0, 0));

      // Check (h2 must be identical to h1)
      h2 = Medium.specificEnthalpy_pTX(
              p,
              Th,
              fill(0.0, 0));
      s2 = Medium.specificEntropy_pTX(
              p,
              Ts,
              fill(0, 0));
      assert(abs(h1 - h2) < 1e-3, "Inverse for h not correctly computed");
      assert(abs(s1 - s2) < 1e-3, "Inverse for s not correctly computed");
      annotation (experiment(StopTime=1));
    end Inverse_sh_T;

    model Inverse_sh_TX
      "Solve h = h_pTX(p, T, X), s = s_pTX(p, T, X) for T, if h or s is given"
      extends Modelica.Icons.Example;

      import Medium = Modelica.Media.Air.ReferenceMoistAir "Medium model";

      parameter SI.Temperature T_min=300
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Temperature T_max=500
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Pressure p=1.0e5 "Fixed pressure in model";
      parameter SI.MassFraction[:] X=Modelica.Media.Air.ReferenceMoistAir.reference_X
        "Mass fraction vector";
      final parameter SI.SpecificEnthalpy h_min=
          Modelica.Media.Air.ReferenceMoistAir.specificEnthalpy(
          Modelica.Media.Air.ReferenceMoistAir.setState_pTX(
                p,
                T_min,
                X)) "Specific enthalpy at T_min";
      final parameter SI.SpecificEnthalpy h_max=
          Modelica.Media.Air.ReferenceMoistAir.specificEnthalpy(
          Modelica.Media.Air.ReferenceMoistAir.setState_pTX(
                p,
                T_max,
                X)) "Specific enthalpy at T_max";
      final parameter SI.SpecificEntropy s_min=
          Modelica.Media.Air.ReferenceMoistAir.specificEntropy(
          Modelica.Media.Air.ReferenceMoistAir.setState_pTX(
                p,
                T_min,
                X)) "Specific entropy at T_min";
      final parameter SI.SpecificEntropy s_max=
          Modelica.Media.Air.ReferenceMoistAir.specificEntropy(
          Modelica.Media.Air.ReferenceMoistAir.setState_pTX(
                p,
                T_max,
                X)) "Specific entropy at T_max";
      SI.SpecificEnthalpy h1 "Pre-defined specific enthalpy";
      SI.SpecificEnthalpy h2
        "Specific enthalpy computed from T (= h1 required)";
      SI.SpecificEntropy s1 "Pre-defined specific entropy";
      SI.SpecificEntropy s2
        "Specific entropy computed from T (= h1 required)";
      SI.Temperature Th "Temperature computed from h1";
      SI.Temperature Ts "Temperature computed from s1";

    protected
      constant SI.Time timeUnit=1.0;

    equation
      // Define specific enthalpy
      h1 = if time < 0 then h_min else if time >= 1 then h_max else h_min + time
        /timeUnit*(h_max - h_min);
      s1 = if time < 0 then s_min else if time >= 1 then s_max else s_min + time
        /timeUnit*(s_max - s_min);

      // Solve for temperature
      Th = Medium.temperature_phX(
              p,
              h1,
              X);
      Ts = Medium.temperature_psX(
              p,
              s1,
              X);

      // Check (h2 must be identical to h1)
      h2 = Medium.specificEnthalpy_pTX(
              p,
              Th,
              X);
      s2 = Medium.specificEntropy_pTX(
              p,
              Ts,
              X);
      assert(abs(h1 - h2) < 1e-3, "Inverse for h not correctly computed");
      assert(abs(s1 - s2) < 1e-3, "Inverse for s not correctly computed");

      annotation (experiment(StopTime=1), Documentation(info="<html>

</html>"));
    end Inverse_sh_TX;
  end ReferenceAir;

  package R134a "Examples for R134a"
    extends Modelica.Icons.ExamplesPackage;

    model R134a1 "Example 1 for R134a"
      extends Modelica.Icons.Example;
      extends Modelica.Media.Examples.Utilities.PartialTestModel(
        redeclare package Medium = Modelica.Media.R134a.R134a_ph,
        h_start=107390,
        fixedMassFlowRate(use_T_ambient=false),
        volume(use_T_start=false),
        ambient(use_T_ambient=false));
      annotation (experiment(StopTime=1.01));
    end R134a1;

    model R134a2 "Example 2 for R134a"
      extends Modelica.Icons.Example;
      extends Modelica.Media.Examples.Utilities.PartialTestModel2(
        redeclare package Medium = Modelica.Media.R134a.R134a_ph,
        h_start=107390,
        fixedMassFlowRate(use_T_ambient=false),
        volume(use_T_start=false),
        ambient(use_T_ambient=false));
      annotation (experiment(StopTime=1.01));
    end R134a2;
  end R134a;

  package SolveOneNonlinearEquation
    "Demonstrate how to solve one non-linear algebraic equation in one unknown"
    extends Modelica.Icons.ExamplesPackage;

    model Inverse_sine "Solve y = A*sin(w*x) for x, given y"
      import Modelica.Utilities.Streams.print;
      extends Modelica.Icons.Example;

      parameter Real y_zero=0.5 "Desired value of A*sin(w*x)";
      parameter Real x_min=-1.7 "Minimum value of x_zero";
      parameter Real x_max=1.7 "Maximum value of x_zero";
      parameter Real A=1 "Amplitude of sine";
      parameter Real w=1 "Angular frequency of sine";
      Real x_zero "y_zero = A*sin(w*x_zero)";

      function f_nonlinear "Define sine as non-linear equation to be solved"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input Real A=1 "Amplitude of sine";
        input Real w=1 "Angular frequency of sine";
        input Real s=0 "Shift of sine";
      algorithm
        y := A*Modelica.Math.sin(w*u) + s;
      end f_nonlinear;

    equation
      x_zero = Modelica.Math.Nonlinear.solveOneNonlinearEquation(
        function f_nonlinear(A=A, w=w, s=-y_zero), x_min, x_max);

      print("x_zero = " + String(x_zero) + ", y_zero = " + String(y_zero) +
        ", A*sin(w*x_zero) = " + String(A*Modelica.Math.sin(w*x_zero)));
      annotation (experiment(StopTime=0), Documentation(info="<html>
<p>
This models solves the following non-linear equation
</p>

<blockquote><pre>
y = A*sin(w*x); -> determine x for given y
</pre></blockquote>

<p>
Translate model \"Inverse_sine\"
and simulate for 0 sec. The result is printed to the
output window.
</p>

</html>"));
    end Inverse_sine;

    model Inverse_sh_T
      "Solve h = h_T(T), s = s_T(T) for T, if h or s is given for ideal gas NASA"
      extends Modelica.Icons.Example;

      replaceable package Medium = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.IdealGases.Common.SingleGasNasa
        "Medium model"
        annotation (choicesAllMatching=true);

      parameter SI.Temperature T_min=300
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Temperature T_max=500
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Pressure p=1.0e5 "Fixed pressure in model";
      final parameter SI.SpecificEnthalpy h_min=Medium.specificEnthalpy(
          Medium.setState_pT(p, T_min)) "Specific enthalpy at T_min";
      final parameter SI.SpecificEnthalpy h_max=Medium.specificEnthalpy(
          Medium.setState_pT(p, T_max)) "Specific enthalpy at T_max";
      final parameter SI.SpecificEntropy s_min=Medium.specificEntropy(
          Medium.setState_pT(p, T_min)) "Specific entropy at T_min";
      final parameter SI.SpecificEntropy s_max=Medium.specificEntropy(
          Medium.setState_pT(p, T_max)) "Specific entropy at T_max";
      SI.SpecificEnthalpy h1(start=h_min, fixed=true)
        "Pre-defined specific enthalpy";
      SI.SpecificEnthalpy h2
        "Specific enthalpy computed from Th (= h1 required)";
      SI.SpecificEntropy s1(start=s_min, fixed=true)
        "Pre-defined specific entropy";
      SI.SpecificEntropy s2 "Specific entropy computed from Ts (= s1 required)";
      SI.Temperature Th "Temperature computed from h1";
      SI.Temperature Ts "Temperature computed from s1";

    protected
      constant SI.Time timeUnit=1.0;

    equation
      // Define specific enthalpy and specific entropy
      der(h1) = if time < 1.0 then 1/timeUnit*(h_max - h_min) else 0.0;
      der(s1) = if time < 1.0 then 1/timeUnit*(s_max - s_min) else 0.0;

      // Solve for temperatures
      Th = Medium.temperature_phX(p, h1, fill(0.0, 0));
      Ts = Medium.temperature_psX(p, s1, fill(0.0, 0));

      // Check (h2 must be identical to h1, s2 must be identical to s1)
      h2 = Medium.specificEnthalpy_pTX(p, Th, fill(0.0, 0));
      s2 = Medium.specificEntropy(Medium.setState_pT(p, Ts));
      annotation (experiment(StopTime=1), Documentation(info="<html>
<p>
This models computes the temperature <code>Th</code> for predefined specific enthalpy <code>h1</code> via numerical inversion of function <a href=\"modelica://Modelica.Media.IdealGases.Common.Functions.h_T\">Modelica.Media.IdealGases.Common.Functions.h_T</a>.
The specific enthalpy <code>h2</code> is computed as check variable from temperature <code>Th</code> and must be identical to <code>h1</code>.
</p>

<p>
In an analogous manner, the temperature <code>Ts</code> is computed for predefined specific entropy <code>s1</code> via numerical inversion of function <a href=\"modelica://Modelica.Media.IdealGases.Common.Functions.s0_T\">Modelica.Media.IdealGases.Common.Functions.s0_T</a>.
The specific entropy <code>s2</code> is computed as check variable from temperature <code>Ts</code> and must be identical to <code>s1</code>.
</p>

<p>
The numerical computation of the inverse function is performed by function <a href=\"modelica://Modelica.Math.Nonlinear.solveOneNonlinearEquation\">Modelica.Math.Nonlinear.solveOneNonlinearEquation</a> in both cases.
</p>

</html>"));
    end Inverse_sh_T;

    model InverseIncompressible_sh_T
      "Inverse computation for incompressible media"
      extends Modelica.Icons.Example;

      replaceable package Medium =
          Modelica.Media.Incompressible.Examples.Glycol47 "Medium model"
        annotation (choicesAllMatching=true);

      parameter SI.Temperature T_min=Medium.T_min
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Temperature T_max=Medium.T_max
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Pressure p=1.0e5 "Fixed pressure in model";
      final parameter SI.SpecificEnthalpy h_min=Medium.h_T(Medium.T_min)
        "Specific enthalpy at T_min";
      final parameter SI.SpecificEnthalpy h_max=Medium.h_T(Medium.T_max)
        "Specific enthalpy at T_max";
      final parameter SI.SpecificEntropy s_min=Medium.specificEntropy(
          Medium.setState_pT(p, T_min)) "Specific entropy at T_min";
      final parameter SI.SpecificEntropy s_max=Medium.specificEntropy(
          Medium.setState_pT(p, T_max)) "Specific entropy at T_max";

      SI.SpecificEnthalpy h1(start=h_min, fixed=true)
        "Pre-defined specific enthalpy";
      SI.SpecificEnthalpy h2
        "Specific enthalpy computed from Th (= h1 required)";
      SI.SpecificEntropy s1(start=s_min, fixed=true)
        "Pre-defined specific entropy";
      SI.SpecificEntropy s2 "Specific entropy computed from Ts (= s1 required)";
      SI.Temperature Th "Temperature computed from h1";
      SI.Temperature Ts "Temperature computed from s1";

    protected
      constant SI.Time timeUnit=1.0;

    equation
      // Define specific enthalpy and specific entropy
      der(h1) = if time < 1.0 then 1/timeUnit*(h_max - h_min) else 0.0;
      der(s1) = if time < 1.0 then 1/timeUnit*(s_max - s_min) else 0.0;

      // Solve for temperatures
      Th = Medium.temperature_phX(p, h1, fill(0.0, 0));
      Ts = Medium.temperature_psX(p, s1, fill(0.0, 0));

      // Check (h2 must be identical to h1, s2 must be identical to s1)
      h2 = Medium.specificEnthalpy_pTX(p, Th, fill(0.0, 0));
      s2 = Medium.specificEntropy(Medium.setState_pT(p, Ts));
      annotation (experiment(StopTime=1), Documentation(info="<html>
<p>
This models computes the temperature <code>Th</code> for predefined specific enthalpy <code>h1</code> via numerical inversion of function <a href=\"modelica://Modelica.Media.Incompressible.TableBased.h_T\">Modelica.Media.Incompressible.TableBased.h_T</a>.
The specific enthalpy <code>h2</code> is computed as check variable from temperature <code>Th</code> and must be identical to <code>h1</code>.
</p>

<p>
In an analogous manner, the temperature <code>Ts</code> is computed for predefined specific entropy <code>s1</code> via numerical inversion of function <a href=\"modelica://Modelica.Media.Incompressible.TableBased.s_T\">Modelica.Media.Incompressible.TableBased.s_T</a>.
The specific entropy <code>s2</code> is computed as check variable from temperature <code>Ts</code> and must be identical to <code>s1</code>.
</p>

<p>
The numerical computation of the inverse function is performed by function <a href=\"modelica://Modelica.Math.Nonlinear.solveOneNonlinearEquation\">Modelica.Math.Nonlinear.solveOneNonlinearEquation</a> in both cases.
</p>

</html>"));
    end InverseIncompressible_sh_T;

    model Inverse_sh_TX
      "Solve h = h_TX(TX) for T, if h is given for ideal gas NASA"
      extends Modelica.Icons.Example;

      replaceable package Medium =
          Modelica.Media.IdealGases.MixtureGases.FlueGasLambdaOnePlus
        constrainedby Modelica.Media.IdealGases.Common.MixtureGasNasa
        "Medium model" annotation (choicesAllMatching=true);

      parameter SI.Temperature T_min=300
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Temperature T_max=500
        "Vary temperature linearly from T_min (time=0) up to T_max (time=1)";
      parameter SI.Pressure p=1.0e5 "Fixed pressure in model";
      final parameter SI.SpecificEnthalpy h_min=Medium.h_TX(T_min, X)
        "Specific enthalpy at T_min";
      final parameter SI.SpecificEnthalpy h_max=Medium.h_TX(T_max, X)
        "Specific enthalpy at T_max";
      final parameter SI.SpecificEntropy s_min=Medium.specificEntropy(
        Medium.setState_pTX(p, T_min, Medium.reference_X)) "Specific entropy at T_min";
      final parameter SI.SpecificEntropy s_max=Medium.specificEntropy(
        Medium.setState_pTX(p, T_max, Medium.reference_X)) "Specific entropy at T_max";
      SI.SpecificEnthalpy h1(start=h_min, fixed=true)
        "Pre-defined specific enthalpy";
      SI.SpecificEnthalpy h2
        "Specific enthalpy computed from Th (= h1 required)";
      SI.SpecificEntropy s1(start=s_min, fixed=true)
        "Pre-defined specific entropy";
      SI.SpecificEntropy s2 "Specific entropy computed from Ts (= s1 required)";
      SI.Temperature Th "Temperature computed from h1";
      SI.Temperature Ts "Temperature computed from s1";
      parameter SI.MassFraction[4] X=Medium.reference_X "Mass fraction vector";

    protected
      constant SI.Time timeUnit=1.0;

    equation
      // Define specific enthalpy and specific entropy
      der(h1) = if time < 1.0 then 1/timeUnit*(h_max - h_min) else 0.0;
      der(s1) = if time < 1.0 then 1/timeUnit*(s_max - s_min) else 0.0;

      // Solve for temperatures
      Th = Medium.temperature_phX(p, h1, X);
      Ts = Medium.temperature_psX(p, s1, X);

      // Check (h2 must be identical to h1, s2 must be identical to s1)
      h2 = Medium.specificEnthalpy_pTX(p, Th, X);
      s2 = Medium.specificEntropy(Medium.setState_pTX(p, Ts, X));
      annotation (experiment(StopTime=1), Documentation(info="<html>
<p>
This models computes the temperature <code>Th</code> for predefined specific enthalpy <code>h1</code> via numerical inversion of function <a href=\"modelica://Modelica.Media.IdealGases.Common.Functions.h_T\">Modelica.Media.IdealGases.Common.Functions.h_T</a>.
The specific enthalpy <code>h2</code> is computed as check variable from temperature <code>Th</code> and must be identical to <code>h1</code>.
</p>

<p>
In an analogous manner, the temperature <code>Ts</code> is computed for predefined specific entropy <code>s1</code> via numerical inversion of function <a href=\"modelica://Modelica.Media.IdealGases.Common.Functions.s0_T\">Modelica.Media.IdealGases.Common.Functions.s0_T</a>.
The specific entropy <code>s2</code> is computed as check variable from temperature <code>Ts</code> and must be identical to <code>s1</code>.
</p>

<p>
The numerical computation of the inverse function is performed by function <a href=\"modelica://Modelica.Math.Nonlinear.solveOneNonlinearEquation\">Modelica.Math.Nonlinear.solveOneNonlinearEquation</a> in both cases.
</p>

</html>"));
    end Inverse_sh_TX;

    annotation (Documentation(info="<html>
<p>
This package demonstrates how to solve one non-linear algebraic
equation in one unknown with function <a href=\"modelica://Modelica.Math.Nonlinear.solveOneNonlinearEquation\">solveOneNonlinearEquation</a>.
</p>

</html>"));
  end SolveOneNonlinearEquation;

    package Utilities
      "Functions, connectors and models needed for the media model tests"

      extends Modelica.Icons.UtilitiesPackage;

      connector FluidPort
        "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)"
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);

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
          "Properties c_i/m in the connection point";
        flow Medium.ExtraPropertyFlowRate mC_flow[Medium.nC]
          "Flow rates of auxiliary properties from the connection point into the component (if m_flow > 0, mC_flow = m_flow*C)";

        annotation (Documentation(info="<html>

</html>"));
      end FluidPort;

      connector FluidPort_a "Fluid connector with filled icon"
        extends FluidPort;
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={Ellipse(
                        extent={{-100,100},{100,-100}},
                        lineColor={0,127,255},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid),Ellipse(
                        extent={{-100,100},{100,-100}},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid),Text(
                        extent={{-88,206},{112,112}},
                        textString="%name",
                        textColor={0,0,255})}),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Ellipse(
                        extent={{-100,100},{100,-100}},
                        lineColor={0,127,255},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid),Ellipse(
                        extent={{-100,100},{100,-100}},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>Modelica.Media.Examples.Tests.Components.FluidPort_a
</html>"));
      end FluidPort_a;

      connector FluidPort_b "Fluid connector with outlined icon"
        extends FluidPort;
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={Ellipse(
                        extent={{-100,100},{100,-100}},
                        lineColor={0,127,255},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid),Ellipse(
                        extent={{-100,100},{100,-100}},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid),Ellipse(
                        extent={{-80,80},{80,-80}},
                        lineColor={0,127,255},
                        fillColor={255,255,255},
                        fillPattern=FillPattern.Solid),Text(
                        extent={{-88,192},{112,98}},
                        textString="%name",
                        textColor={0,0,255})}),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Ellipse(
                        extent={{-100,100},{100,-100}},
                        lineColor={0,127,255},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid),Ellipse(
                        extent={{-100,100},{100,-100}},
                        fillColor={0,127,255},
                        fillPattern=FillPattern.Solid),Ellipse(
                        extent={{-80,80},{80,-80}},
                        lineColor={0,127,255},
                        fillColor={255,255,255},
                        fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>

</html>"));
      end FluidPort_b;

      model PortVolume
        "Fixed volume associated with a port by the finite volume method"
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);

        parameter SI.Volume V=1e-6 "Fixed size of junction volume";

        parameter Boolean use_p_start=true "Select p_start or d_start"
          annotation (Evaluate=true, Dialog(group=
                "Initial pressure or initial density"));
        parameter Medium.AbsolutePressure p_start=101325 "Initial pressure"
          annotation (Dialog(group="Initial pressure or initial density",
              enable=use_p_start));
        parameter Medium.Density d_start=1 "Initial density" annotation (Dialog(
              group="Initial pressure or initial density", enable=not
                use_p_start));
        parameter Boolean use_T_start=true "Select T_start or h_start"
          annotation (Evaluate=true, Dialog(group=
                "Initial temperature or initial specific enthalpy"));
        parameter Medium.Temperature T_start=
            Modelica.Units.Conversions.from_degC(20) "Initial temperature"
          annotation (Dialog(group=
                "Initial temperature or initial specific enthalpy", enable=
                use_T_start));
        parameter Medium.SpecificEnthalpy h_start=1.e4
          "Initial specific enthalpy" annotation (Dialog(group=
                "Initial temperature or initial specific enthalpy", enable=not
                use_T_start));
        parameter Medium.MassFraction X_start[Medium.nX]
          "Initial mass fractions m_i/m" annotation (Dialog(group=
                "Only for multi-substance flow", enable=Medium.nX > 0));

        FluidPort_a port(redeclare package Medium = Medium) annotation (
            Placement(transformation(extent={{-10,-10},{10,10}})));
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
        m = V*medium.d;
        mXi = m*medium.Xi;
        U = m*medium.u;

        // Mass and energy balance
        der(m) = port.m_flow;
        der(mXi) = port.mXi_flow;
        der(U) = port.H_flow;
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Ellipse(
                        extent={{-100,100},{100,-100}},
                        fillPattern=FillPattern.Sphere,
                        fillColor={170,213,255}),Text(
                        extent={{-150,150},{150,110}},
                        textString="%name",
                        textColor={0,0,255}), Text(
                        extent={{-150,-110},{150,-150}},
                        textString="V=%V")}), Documentation(info="<html>
<p>
This component models the <strong>volume</strong> of <strong>fixed size</strong> that is
associated with the <strong>fluid port</strong> to which it is connected.
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
</html>"));
      end PortVolume;

      model FixedMassFlowRate
        "Ideal pump that produces a constant mass flow rate from a large reservoir at fixed temperature and mass fraction"
        parameter Medium.MassFlowRate m_flow
          "Fixed mass flow rate from an infinite reservoir to the fluid port";

        parameter Boolean use_T_ambient=true "Select T_ambient or h_ambient"
          annotation (Evaluate=true, Dialog(group=
                "Ambient temperature or ambient specific enthalpy"));
        parameter Medium.Temperature T_ambient=
            Modelica.Units.Conversions.from_degC(20) "Ambient temperature"
          annotation (Dialog(group=
                "Ambient temperature or ambient specific enthalpy", enable=
                use_T_ambient));
        parameter Medium.SpecificEnthalpy h_ambient=1.e4
          "Ambient specific enthalpy" annotation (Dialog(group=
                "Ambient temperature or ambient specific enthalpy", enable=not
                use_T_ambient));
        parameter Medium.MassFraction X_ambient[Medium.nX]
          "Ambient mass fractions m_i/m of reservoir";

        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);

        Medium.BaseProperties medium "Medium in the source";
        FluidPort_b port(redeclare package Medium = Medium) annotation (
            Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        if use_T_ambient then
          medium.T = T_ambient;
        else
          medium.h = h_ambient;
        end if;

        medium.Xi = X_ambient[1:Medium.nXi];
        medium.p = port.p;
        port.m_flow = -m_flow;
        port.mXi_flow = semiLinear(
                  port.m_flow,
                  port.Xi,
                  medium.Xi);
        port.H_flow = semiLinear(
                  port.m_flow,
                  port.h,
                  medium.h);
        annotation (Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={Rectangle(
                        extent={{20,60},{100,-60}},
                        fillPattern=FillPattern.HorizontalCylinder,
                        fillColor={192,192,192}),Rectangle(
                        extent={{38,40},{100,-40}},
                        fillPattern=FillPattern.HorizontalCylinder,
                        fillColor={0,127,255}),Ellipse(
                        extent={{-100,80},{60,-80}},
                        fillColor={255,255,255},
                        fillPattern=FillPattern.Solid,
                        lineColor={0,0,255}),Polygon(
                        points={{-60,70},{60,0},{-60,-68},{-60,70}},
                        lineColor={0,0,255},
                        fillColor={0,0,255},
                        fillPattern=FillPattern.Solid),Text(
                        extent={{-54,32},{16,-30}},
                        textColor={255,0,0},
                        textString="m"),Text(
                        extent={{-150,150},{150,110}},
                        textString="%name",
                        textColor={0,0,255}), Text(
                        extent={{-150,-110},{150,-150}},
                        textString="%m_flow"), Ellipse(
                        extent={{-26,30},{-18,22}},
                        lineColor={255,0,0},
                        fillColor={255,0,0},
                        fillPattern=FillPattern.Solid)}), Documentation(info="<html>

</html>"));
      end FixedMassFlowRate;

      model FixedAmbient
        "Ambient pressure, temperature and mass fraction source"
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);

        parameter Boolean use_p_ambient=true "Select p_ambient or d_ambient"
          annotation (Evaluate=true, Dialog(group=
                "Ambient pressure or ambient density"));
        parameter Medium.AbsolutePressure p_ambient=101325 "Ambient pressure"
          annotation (Dialog(group="Ambient pressure or ambient density",
              enable=use_p_ambient));
        parameter Medium.Density d_ambient=1 "Ambient density" annotation (
            Dialog(group="Ambient pressure or ambient density", enable=not
                use_p_ambient));
        parameter Boolean use_T_ambient=true "Select T_ambient or h_ambient"
          annotation (Evaluate=true, Dialog(group=
                "Ambient temperature or ambient specific enthalpy"));
        parameter Medium.Temperature T_ambient=
            Modelica.Units.Conversions.from_degC(20) "Ambient temperature"
          annotation (Dialog(group=
                "Ambient temperature or ambient specific enthalpy", enable=
                use_T_ambient));
        parameter Medium.SpecificEnthalpy h_ambient=1.e4
          "Ambient specific enthalpy" annotation (Dialog(group=
                "Ambient temperature or ambient specific enthalpy", enable=not
                use_T_ambient));
        parameter Medium.MassFraction X_ambient[Medium.nX]
          "Ambient mass fractions m_i/m" annotation (Dialog(group=
                "Only for multi-substance flow", enable=Medium.nX > 0));

        Medium.BaseProperties medium "Medium in the source";
        FluidPort_b port(redeclare package Medium = Medium) annotation (
            Placement(transformation(extent={{100,-10},{120,10}})));

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
        port.H_flow = semiLinear(
                  port.m_flow,
                  port.h,
                  medium.h);
        port.mXi_flow = semiLinear(
                  port.m_flow,
                  port.Xi,
                  medium.Xi);
        annotation (Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={Ellipse(
                        extent={{-100,100},{100,-100}},
                        fillPattern=FillPattern.Sphere,
                        fillColor={0,127,255}), Text(
                        extent={{-150,150},{150,110}},
                        textString="%name",
                        textColor={0,0,255})}), Documentation(info="<html>
<p>
Model <strong>FixedAmbient_pt</strong> defines constant values for ambient conditions:
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
          "Medium model" annotation (choicesAllMatching=true);

        parameter Medium.AbsolutePressure dp_nominal(min=1e-10)
          "Nominal pressure drop";
        parameter Medium.MassFlowRate m_flow_nominal(min=1e-10)
          "Nominal mass flow rate at nominal pressure drop";

        FluidPort_a port_a(redeclare package Medium = Medium) annotation (
            Placement(transformation(extent={{-120,-10},{-100,10}})));
        FluidPort_b port_b(redeclare package Medium = Medium) annotation (
            Placement(transformation(extent={{120,-10},{100,10}})));
        // Medium.BaseProperties medium_a(p=port_a.p, h=port_a.h, Xi=port_a.Xi)
        //   "Medium properties in port_a";
        // Medium.BaseProperties medium_b(p=port_b.p, h=port_b.h, Xi=port_b.Xi)
        //   "Medium properties in port_b";
        Medium.MassFlowRate m_flow
          "Mass flow rate from port_a to port_b (m_flow > 0 is design flow direction)";
        SI.Pressure dp "Pressure drop from port_a to port_b";
      equation
        /* Handle reverse and zero flow */
        port_a.H_flow = semiLinear(
                  port_a.m_flow,
                  port_a.h,
                  port_b.h);
        port_a.mXi_flow = semiLinear(
                  port_a.m_flow,
                  port_a.Xi,
                  port_b.Xi);

        /* Energy, mass and substance mass balance */
        port_a.H_flow + port_b.H_flow = 0;
        port_a.m_flow + port_b.m_flow = 0;
        port_a.mXi_flow + port_b.mXi_flow = zeros(Medium.nXi);

        // Design direction of mass flow rate
        m_flow = port_a.m_flow;

        // Pressure drop
        dp = port_a.p - port_b.p;
        m_flow = (m_flow_nominal/dp_nominal)*dp;
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                        extent={{-100,60},{100,-60}},
                        fillPattern=FillPattern.HorizontalCylinder,
                        fillColor={192,192,192}),Rectangle(
                        extent={{-100,34},{100,-36}},
                        fillPattern=FillPattern.HorizontalCylinder,
                        fillColor={0,127,255}),Text(
                        extent={{-150,110},{150,70}},
                        textString="%name", textColor={0,0,255}), Text(
                        extent={{-150,-70},{150,-110}},
                        textString="k=%m_flow_nominal/%dp_nominal")}),
            Documentation(info="<html>
<p>
Model <strong>ShortPipe</strong> defines a simple pipe model
with pressure loss due to friction. It is assumed that
no mass or energy is stored in the pipe.
</p>
</html>"));
      end ShortPipe;

      partial model PartialTestModel "Basic test model to test a medium"

        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);
        parameter SI.AbsolutePressure p_start=Medium.p_default
          "Initial value of pressure";
        parameter SI.Temperature T_start=Medium.T_default
          "Initial value of temperature";
        parameter SI.SpecificEnthalpy h_start=Medium.h_default
          "Initial value of specific enthalpy";
        parameter Real X_start[Medium.nX]=Medium.X_default
          "Initial value of mass fractions";

        /*
  parameter SI.AbsolutePressure p_start = 1.0e5 "Initial value of pressure";
  parameter SI.Temperature T_start = 300 "Initial value of temperature";
  parameter SI.Density h_start = 1 "Initial value of specific enthalpy";
  parameter Real X_start[Medium.nX] = Medium.reference_X
    "Initial value of mass fractions";
*/
        PortVolume volume(
          redeclare package Medium = Medium,
          p_start=p_start,
          T_start=T_start,
          h_start=h_start,
          X_start=X_start,
          V=0.1) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
        FixedMassFlowRate fixedMassFlowRate(
          redeclare package Medium = Medium,
          T_ambient=1.2*T_start,
          h_ambient=1.2*h_start,
          m_flow=1,
          X_ambient=0.5*X_start) annotation (Placement(transformation(extent={{
                  -80,0},{-60,20}})));
        FixedAmbient ambient(
          redeclare package Medium = Medium,
          T_ambient=T_start,
          h_ambient=h_start,
          X_ambient=X_start,
          p_ambient=p_start) annotation (Placement(transformation(extent={{60,0},
                  {40,20}})));
        ShortPipe shortPipe(
          redeclare package Medium = Medium,
          m_flow_nominal=1,
          dp_nominal=0.1e5) annotation (Placement(transformation(extent={{0,0},
                  {20,20}})));
      equation
        connect(fixedMassFlowRate.port, volume.port)
          annotation (Line(points={{-59,10},{-30,10}}, color={0,127,255}));
        connect(volume.port, shortPipe.port_a)
          annotation (Line(points={{-30,10},{-1,10}}, color={0,127,255}));
        connect(shortPipe.port_b, ambient.port)
          annotation (Line(points={{21,10},{39,10}}, color={0,127,255}));
        annotation (Documentation(info="<html>

</html>"));
      end PartialTestModel;

      partial model PartialTestModel2
        "Slightly larger test model to test a medium"
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);
        parameter SI.AbsolutePressure p_start=1.0e5 "Initial value of pressure";
        parameter SI.Temperature T_start=300 "Initial value of temperature";
        parameter SI.SpecificEnthalpy h_start=1
          "Initial value of specific enthalpy";
        parameter Real X_start[Medium.nX]=Medium.reference_X
          "Initial value of mass fractions";
        PortVolume volume(
          redeclare package Medium = Medium,
          p_start=p_start,
          T_start=T_start,
          h_start=h_start,
          X_start=X_start,
          V=0.1) annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
        FixedMassFlowRate fixedMassFlowRate(
          redeclare package Medium = Medium,
          T_ambient=1.2*T_start,
          h_ambient=1.2*h_start,
          m_flow=1,
          X_ambient=0.5*X_start) annotation (Placement(transformation(extent={{
                  -100,0},{-80,20}})));
        FixedAmbient ambient(
          redeclare package Medium = Medium,
          T_ambient=T_start,
          h_ambient=h_start,
          X_ambient=X_start,
          p_ambient=p_start) annotation (Placement(transformation(extent={{92,0},
                  {72,20}})));
        ShortPipe shortPipe(
          redeclare package Medium = Medium,
          m_flow_nominal=1,
          dp_nominal=0.1e5) annotation (Placement(transformation(extent={{-30,0},
                  {-10,20}})));
        PortVolume volume1(
          redeclare package Medium = Medium,
          p_start=p_start,
          T_start=T_start,
          h_start=h_start,
          X_start=X_start,
          V=0.1) annotation (Placement(transformation(extent={{0,0},{20,20}})));
        ShortPipe shortPipe1(
          redeclare package Medium = Medium,
          m_flow_nominal=1,
          dp_nominal=0.1e5) annotation (Placement(transformation(extent={{36,0},
                  {56,20}})));
      equation
        connect(fixedMassFlowRate.port, volume.port)
          annotation (Line(points={{-79,10},{-50,10}}, color={0,127,255}));
        connect(volume.port, shortPipe.port_a)
          annotation (Line(points={{-50,10},{-31,10}}, color={0,127,255}));
        connect(volume1.port, shortPipe1.port_a)
          annotation (Line(points={{10,10},{35,10}}, color={0,127,255}));
        connect(shortPipe.port_b, volume1.port)
          annotation (Line(points={{-9,10},{10,10}}, color={0,127,255}));
        connect(shortPipe1.port_b, ambient.port)
          annotation (Line(points={{57,10},{71,10}}, color={0,127,255}));
        annotation (Documentation(info="<html>

</html>"));
      end PartialTestModel2;
      annotation (Documentation(info="<html>

</html>"));
    end Utilities;
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
of density and temperature, and many water properties are based on
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
</html>"));
end Examples;

package Interfaces "Interfaces for media models"
  extends Modelica.Icons.InterfacesPackage;

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
      final mediumName="NameOfMedium",
      final substanceNames={mediumName},
      final singleState=false,
      final reducedX=true,
      final fixedX=true,
      Temperature(
        min=273,
        max=450,
        start=323));

    // Provide medium constants here
    constant SpecificHeatCapacity cp_const=123456
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
     the gas constant R_s and the molar mass MM of the medium.
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
      R_s = Modelica.Constants.R/MM;
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
      "A selection of variables that uniquely defines the thermodynamic state"
      extends Modelica.Icons.Record;
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

    annotation (Documentation(info="<html>
<p>
This package is a <strong>template</strong> for <strong>new medium</strong> models. For a new
medium model just make a copy of this package, remove the
\"partial\" keyword from the package and provide
the information that is requested in the comments of the
Modelica source.
</p>
</html>"));
  end TemplateMedium;

  partial package PartialMedium
    "Partial medium properties (base package of all media packages)"
    extends Modelica.Media.Interfaces.Types;
    extends Modelica.Icons.MaterialPropertiesPackage;

    // Constants to be set in Medium
    constant Modelica.Media.Interfaces.Choices.IndependentVariables
      ThermoStates "Enumeration type for independent variables";
    constant String mediumName="unusablePartialMedium" "Name of the medium";
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
    constant MassFraction reference_X[nX]=fill(1/nX, nX)
      "Default mass fractions of medium";
    constant AbsolutePressure p_default=101325
      "Default value for pressure of medium (for initialization)";
    constant Temperature T_default=Modelica.Units.Conversions.from_degC(20)
      "Default value for temperature of medium (for initialization)";
    constant SpecificEnthalpy h_default=specificEnthalpy_pTX(
            p_default,
            T_default,
            X_default)
      "Default value for specific enthalpy of medium (for initialization)";
    constant MassFraction X_default[nX]=reference_X
      "Default value for mass fractions of medium (for initialization)";
    constant ExtraProperty C_default[nC]=fill(0, nC)
      "Default value for trace substances of medium (for initialization)";

    final constant Integer nS=size(substanceNames, 1) "Number of substances";
    constant Integer nX=nS "Number of mass fractions";
    constant Integer nXi=if fixedX then 0 else if reducedX then nS - 1 else nS
      "Number of structurally independent mass fractions (see docu for details)";

    final constant Integer nC=size(extraPropertiesNames, 1)
      "Number of extra (outside of standard mass-balance) transported properties";
    constant Real C_nominal[nC](min=fill(Modelica.Constants.eps, nC)) = 1.0e-6*
      ones(nC) "Default for the nominal values for the extra properties";
    replaceable record FluidConstants =
        Modelica.Media.Interfaces.Types.Basic.FluidConstants
      "Critical, triple, molecular and other standard data of fluid";

    replaceable record ThermodynamicState
      "Minimal variable set that is available as input argument to every medium function"
      extends Modelica.Icons.Record;
    end ThermodynamicState;

    replaceable partial model BaseProperties
      "Base properties (p, d, T, h, u, R_s, MM and, if applicable, X and Xi) of a medium"
      InputAbsolutePressure p "Absolute pressure of medium";
      InputMassFraction[nXi] Xi(start=reference_X[1:nXi])
        "Structurally independent mass fractions";
      InputSpecificEnthalpy h "Specific enthalpy of medium";
      Density d "Density of medium";
      Temperature T "Temperature of medium";
      MassFraction[nX] X(start=reference_X)
        "Mass fractions (= (component mass)/total mass  m_i/m)";
      SpecificInternalEnergy u "Specific internal energy of medium";
      SpecificHeatCapacity R_s "Gas constant (of mixture if applicable)";
      MolarMass MM "Molar mass (of mixture or single fluid)";
      ThermodynamicState state
        "Thermodynamic state record for optional functions";
      parameter Boolean preferredMediumStates=false
        "= true if StateSelect.prefer shall be used for the independent property variables of the medium"
        annotation (Evaluate=true, Dialog(tab="Advanced"));
      parameter Boolean standardOrderComponents=true
        "If true, and reducedX = true, the last element of X will be computed from the other ones";
      Modelica.Units.NonSI.Temperature_degC T_degC=
          Modelica.Units.Conversions.to_degC(T)
        "Temperature of medium in [degC]";
      Modelica.Units.NonSI.Pressure_bar p_bar=
          Modelica.Units.Conversions.to_bar(p)
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
            String(i) + "] = " + String(X[i]) + "of substance " +
            substanceNames[i] + "\nof medium " + mediumName +
            " is not in the range 0..1");
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
              textColor={0,0,255})}), Documentation(info="<html>
<p>
Model <strong>BaseProperties</strong> is a model within package <strong>PartialMedium</strong>
and contains the <strong>declarations</strong> of the minimum number of
variables that every medium model is supposed to support.
A specific medium inherits from model <strong>BaseProperties</strong> and provides
the equations for the basic properties.</p>
<p>
The BaseProperties model contains the following <strong>7+nXi variables</strong>
(nXi is the number of independent mass fractions defined in package
PartialMedium):
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>Variable</strong></td>
      <td><strong>Unit</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>T</td>
      <td>K</td>
      <td>Temperature</td></tr>
  <tr><td>p</td>
      <td>Pa</td>
      <td>Absolute pressure</td></tr>
  <tr><td>d</td>
      <td>kg/m3</td>
      <td>Density</td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>Specific enthalpy</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>Specific internal energy</td></tr>
  <tr><td>Xi[nXi]</td>
      <td>kg/kg</td>
      <td>Structurally independent mass fractions</td></tr>
  <tr><td>R_s</td>
      <td>J/(kg.K)</td>
      <td>Specific gas constant (of mixture if applicable)</td></tr>
  <tr><td>MM</td>
      <td>kg/mol</td>
      <td>Molar mass</td></tr>
</table>
<p>
In order to implement an actual medium model, one can extend from this
base model and add <strong>5 equations</strong> that provide relations among
these variables. Equations will also have to be added in order to
set all the variables within the ThermodynamicState record state.</p>
<p>
If standardOrderComponents=true, the full composition vector X[nX]
is determined by the equations contained in this base class, depending
on the independent mass fraction vector Xi[nXi].</p>
<p>Additional <strong>2 + nXi</strong> equations will have to be provided
when using the BaseProperties model, in order to fully specify the
thermodynamic conditions. The input connector qualifier applied to
p, h, and nXi indirectly declares the number of missing equations,
permitting advanced equation balance checking by Modelica tools.
Please note that this doesn't mean that the additional equations
should be connection equations, nor that exactly those variables
should be supplied, in order to complete the model.
For further information, see the <a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media User's guide</a>, and
<a href=\"https://specification.modelica.org/v3.4/Ch4.html#balanced-models\">Section 4.7 (Balanced Models) of the Modelica 3.4 specification</a>.</p>
</html>"));
    end BaseProperties;

    replaceable partial function setState_pTX
      "Return thermodynamic state as function of p, T and composition X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    end setState_pTX;

    replaceable partial function setState_phX
      "Return thermodynamic state as function of p, h and composition X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    end setState_phX;

    replaceable partial function setState_psX
      "Return thermodynamic state as function of p, s and composition X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    end setState_psX;

    replaceable partial function setState_dTX
      "Return thermodynamic state as function of d, T and composition X or Xi"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
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
      annotation (Documentation(info="<html>
<p>
This function is used to approximate the equation
</p>
<blockquote><pre>
state = <strong>if</strong> x &gt; 0 <strong>then</strong> state_a <strong>else</strong> state_b;
</pre></blockquote>

<p>
by a smooth characteristic, so that the expression is continuous and differentiable:
</p>

<blockquote><pre>
state := <strong>smooth</strong>(1, <strong>if</strong> x &gt;  x_small <strong>then</strong> state_a <strong>else</strong>
                   <strong>if</strong> x &lt; -x_small <strong>then</strong> state_b <strong>else</strong> f(state_a, state_b));
</pre></blockquote>

<p>
This is performed by applying function <strong>Media.Common.smoothStep</strong>(..)
on every element of the thermodynamic state record.
</p>

<p>
If <strong>mass fractions</strong> X[:] are approximated with this function then this can be performed
for all <strong>nX</strong> mass fractions, instead of applying it for nX-1 mass fractions and computing
the last one by the mass fraction constraint sum(X)=1. The reason is that the approximating function has the
property that sum(state.X) = 1, provided sum(state_a.X) = sum(state_b.X) = 1.
This can be shown by evaluating the approximating function in the abs(x) &lt; x_small
region (otherwise state.X is either state_a.X or state_b.X):
</p>

<blockquote><pre>
X[1]  = smoothStep(x, X_a[1] , X_b[1] , x_small);
X[2]  = smoothStep(x, X_a[2] , X_b[2] , x_small);
   ...
X[nX] = smoothStep(x, X_a[nX], X_b[nX], x_small);
</pre></blockquote>

<p>
or
</p>

<blockquote><pre>
X[1]  = c*(X_a[1]  - X_b[1])  + (X_a[1]  + X_b[1])/2
X[2]  = c*(X_a[2]  - X_b[2])  + (X_a[2]  + X_b[2])/2;
   ...
X[nX] = c*(X_a[nX] - X_b[nX]) + (X_a[nX] + X_b[nX])/2;
c     = (x/x_small)*((x/x_small)^2 - 3)/4
</pre></blockquote>

<p>
Summing all mass fractions together results in
</p>

<blockquote><pre>
sum(X) = c*(sum(X_a) - sum(X_b)) + (sum(X_a) + sum(X_b))/2
       = c*(1 - 1) + (1 + 1)/2
       = 1
</pre></blockquote>

</html>"));
    end setSmoothState;

    replaceable partial function dynamicViscosity "Return dynamic viscosity"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output DynamicViscosity eta "Dynamic viscosity";
    end dynamicViscosity;

    replaceable partial function thermalConductivity
      "Return thermal conductivity"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output ThermalConductivity lambda "Thermal conductivity";
    end thermalConductivity;

    replaceable function prandtlNumber "Return the Prandtl number"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output PrandtlNumber Pr "Prandtl number";
    algorithm
      Pr := dynamicViscosity(state)*specificHeatCapacityCp(state)/
        thermalConductivity(state);
    end prandtlNumber;

    replaceable partial function pressure "Return pressure"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output AbsolutePressure p "Pressure";
    end pressure;

    replaceable partial function temperature "Return temperature"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output Temperature T "Temperature";
    end temperature;

    replaceable partial function density "Return density"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output Density d "Density";
    end density;

    replaceable partial function specificEnthalpy "Return specific enthalpy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnthalpy h "Specific enthalpy";
    end specificEnthalpy;

    replaceable partial function specificInternalEnergy
      "Return specific internal energy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnergy u "Specific internal energy";
    end specificInternalEnergy;

    replaceable partial function specificEntropy "Return specific entropy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEntropy s "Specific entropy";
    end specificEntropy;

    replaceable partial function specificGibbsEnergy
      "Return specific Gibbs energy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnergy g "Specific Gibbs energy";
    end specificGibbsEnergy;

    replaceable partial function specificHelmholtzEnergy
      "Return specific Helmholtz energy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnergy f "Specific Helmholtz energy";
    end specificHelmholtzEnergy;

    replaceable partial function specificHeatCapacityCp
      "Return specific heat capacity at constant pressure"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificHeatCapacity cp
        "Specific heat capacity at constant pressure";
    end specificHeatCapacityCp;

    function heatCapacity_cp = specificHeatCapacityCp
      "Alias for deprecated name";

    replaceable partial function specificHeatCapacityCv
      "Return specific heat capacity at constant volume"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificHeatCapacity cv
        "Specific heat capacity at constant volume";
    end specificHeatCapacityCv;

    function heatCapacity_cv = specificHeatCapacityCv
      "Alias for deprecated name";

    replaceable partial function isentropicExponent
      "Return isentropic exponent"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output IsentropicExponent gamma "Isentropic exponent";
    end isentropicExponent;

    replaceable partial function isentropicEnthalpy
      "Return isentropic enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p_downstream "Downstream pressure";
      input ThermodynamicState refState "Reference state for entropy";
      output SpecificEnthalpy h_is "Isentropic enthalpy";
      annotation (Documentation(info="<html>
<p>
This function computes an isentropic state transformation:
</p>
<ol>
<li> A medium is in a particular state, refState.</li>
<li> The enthalpy at another state (h_is) shall be computed
     under the assumption that the state transformation from refState to h_is
     is performed with a change of specific entropy ds = 0 and the pressure of state h_is
     is p_downstream and the composition X upstream and downstream is assumed to be the same.</li>
</ol>

</html>"));
    end isentropicEnthalpy;

    replaceable partial function velocityOfSound "Return velocity of sound"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output VelocityOfSound a "Velocity of sound";
    end velocityOfSound;

    replaceable partial function isobaricExpansionCoefficient
      "Return overall the isobaric expansion coefficient beta"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output IsobaricExpansionCoefficient beta "Isobaric expansion coefficient";
      annotation (Documentation(info="<html>
<blockquote><pre>
beta is defined as  1/v * der(v,T), with v = 1/d, at constant pressure p.
</pre></blockquote>
</html>"));
    end isobaricExpansionCoefficient;

    function beta = isobaricExpansionCoefficient
      "Alias for isobaricExpansionCoefficient for user convenience";

    replaceable partial function isothermalCompressibility
      "Return overall the isothermal compressibility factor"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SI.IsothermalCompressibility kappa "Isothermal compressibility";
      annotation (Documentation(info="<html>
<blockquote><pre>

kappa is defined as - 1/v * der(v,p), with v = 1/d at constant temperature T.

</pre></blockquote>
</html>"));
    end isothermalCompressibility;

    function kappa = isothermalCompressibility
      "Alias of isothermalCompressibility for user convenience";

    // explicit derivative functions for finite element models
    replaceable partial function density_derp_h
      "Return density derivative w.r.t. pressure at const specific enthalpy"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output DerDensityByPressure ddph "Density derivative w.r.t. pressure";
    end density_derp_h;

    replaceable partial function density_derh_p
      "Return density derivative w.r.t. specific enthalpy at constant pressure"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output DerDensityByEnthalpy ddhp
        "Density derivative w.r.t. specific enthalpy";
    end density_derh_p;

    replaceable partial function density_derp_T
      "Return density derivative w.r.t. pressure at const temperature"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output DerDensityByPressure ddpT "Density derivative w.r.t. pressure";
    end density_derp_T;

    replaceable partial function density_derT_p
      "Return density derivative w.r.t. temperature at constant pressure"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output DerDensityByTemperature ddTp
        "Density derivative w.r.t. temperature";
    end density_derT_p;

    replaceable partial function density_derX
      "Return density derivative w.r.t. mass fraction"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output Density[nX] dddX "Derivative of density w.r.t. mass fraction";
    end density_derX;

    replaceable partial function molarMass
      "Return the molar mass of the medium"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
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
      h := specificEnthalpy(setState_pTX(
              p,
              T,
              X));
      annotation (inverse(T=temperature_phX(
                    p,
                    h,
                    X)));
    end specificEnthalpy_pTX;

    replaceable function specificEntropy_pTX
      "Return specific enthalpy from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output SpecificEntropy s "Specific entropy";
    algorithm
      s := specificEntropy(setState_pTX(
              p,
              T,
              X));

      annotation (inverse(T=temperature_psX(
                    p,
                    s,
                    X)));
    end specificEntropy_pTX;

    replaceable function density_pTX "Return density from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:] "Mass fractions";
      output Density d "Density";
    algorithm
      d := density(setState_pTX(
              p,
              T,
              X));
    end density_pTX;

    replaceable function temperature_phX
      "Return temperature from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output Temperature T "Temperature";
    algorithm
      T := temperature(setState_phX(
              p,
              h,
              X));
    end temperature_phX;

    replaceable function density_phX "Return density from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output Density d "Density";
    algorithm
      d := density(setState_phX(
              p,
              h,
              X));
    end density_phX;

    replaceable function temperature_psX
      "Return temperature from p,s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output Temperature T "Temperature";
    algorithm
      T := temperature(setState_psX(
              p,
              s,
              X));
      annotation (inverse(s=specificEntropy_pTX(
                    p,
                    T,
                    X)));
    end temperature_psX;

    replaceable function density_psX "Return density from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output Density d "Density";
    algorithm
      d := density(setState_psX(
              p,
              s,
              X));
    end density_psX;

    replaceable function specificEnthalpy_psX
      "Return specific enthalpy from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy(setState_psX(
              p,
              s,
              X));
    end specificEnthalpy_psX;

    type MassFlowRate = SI.MassFlowRate (
        quantity="MassFlowRate." + mediumName,
        min=-1.0e5,
        max=1.e5) "Type for mass flow rate with medium specific attributes";

    annotation (Documentation(info="<html>
<p>
<strong>PartialMedium</strong> is a package and contains all <strong>declarations</strong> for
a medium. This means that constants, models, and functions
are defined that every medium is supposed to support
(some of them are optional). A medium package
inherits from <strong>PartialMedium</strong> and provides the
equations for the medium. The details of this package
are described in
<a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.
</p>
</html>", revisions="<html>

</html>"));
  end PartialMedium;

  partial package PartialPureSubstance
    "Base class for pure substances of one chemical substance"
    extends PartialMedium(final reducedX=true, final fixedX=true);

    replaceable function setState_pT "Return thermodynamic state from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_pTX(
              p,
              T,
              fill(0, 0));
    end setState_pT;

    replaceable function setState_ph "Return thermodynamic state from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_phX(
              p,
              h,
              fill(0, 0));
    end setState_ph;

    replaceable function setState_ps "Return thermodynamic state from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_psX(
              p,
              s,
              fill(0, 0));
    end setState_ps;

    replaceable function setState_dT "Return thermodynamic state from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_dTX(
              d,
              T,
              fill(0, 0));
    end setState_dT;

    replaceable function density_ph "Return density from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output Density d "Density";
    algorithm
      d := density_phX(
              p,
              h,
              fill(0, 0));
    end density_ph;

    replaceable function temperature_ph "Return temperature from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output Temperature T "Temperature";
    algorithm
      T := temperature_phX(
              p,
              h,
              fill(0, 0));
    end temperature_ph;

    replaceable function pressure_dT "Return pressure from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      output AbsolutePressure p "Pressure";
    algorithm
      p := pressure(setState_dTX(
              d,
              T,
              fill(0, 0)));
    end pressure_dT;

    replaceable function specificEnthalpy_dT
      "Return specific enthalpy from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy(setState_dTX(
              d,
              T,
              fill(0, 0)));
    end specificEnthalpy_dT;

    replaceable function specificEnthalpy_ps
      "Return specific enthalpy from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy_psX(
              p,
              s,
              fill(0, 0));
    end specificEnthalpy_ps;

    replaceable function temperature_ps "Return temperature from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output Temperature T "Temperature";
    algorithm
      T := temperature_psX(
              p,
              s,
              fill(0, 0));
    end temperature_ps;

    replaceable function density_ps "Return density from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output Density d "Density";
    algorithm
      d := density_psX(
              p,
              s,
              fill(0, 0));
    end density_ps;

    replaceable function specificEnthalpy_pT
      "Return specific enthalpy from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy_pTX(
              p,
              T,
              fill(0, 0));
    end specificEnthalpy_pT;

    replaceable function density_pT "Return density from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output Density d "Density";
    algorithm
      d := density(setState_pTX(
              p,
              T,
              fill(0, 0)));
    end density_pT;

    redeclare replaceable partial model extends BaseProperties(final
        standardOrderComponents=true)
    end BaseProperties;
  end PartialPureSubstance;

  partial package PartialLinearFluid
    "Generic pure liquid model with constant cp, compressibility and thermal expansion coefficients"

    extends Interfaces.PartialPureSubstance(ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX,
        singleState=false);
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
      "Specific entropy in reference conditions";
    constant Boolean constantJacobian
      "If true, entries in thermodynamic Jacobian are constant, taken at reference conditions";

    redeclare record ThermodynamicState
      "A selection of variables that uniquely defines the thermodynamic state"
      extends Modelica.Icons.Record;
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
    end ThermodynamicState;

    redeclare model extends BaseProperties(T(stateSelect=if
            preferredMediumStates then StateSelect.prefer else StateSelect.default),
        p(stateSelect=if preferredMediumStates then StateSelect.prefer else
            StateSelect.default)) "Base properties of medium"
    equation
      d = (1 + (p - reference_p)*kappa_const - (T - reference_T)*beta_const)*
        reference_d;
      h = reference_h + (T - reference_T)*cp_const + (p - reference_p)*(1 -
        beta_const*reference_T)/reference_d;
      u = h - p/d;
      p = state.p;
      T = state.T;
      MM = MM_const;
      R_s = Modelica.Constants.R/MM;
    end BaseProperties;

    redeclare function extends setState_pTX
      "Set the thermodynamic state record from p and T (X not needed)"
    algorithm
      state := ThermodynamicState(p=p, T=T);
    end setState_pTX;

    redeclare function extends setState_phX
      "Set the thermodynamic state record from p and h (X not needed)"
    algorithm
      state := ThermodynamicState(p=p, T=(h - reference_h - (p - reference_p)*(
        (1 - beta_const*reference_T)/reference_d))/cp_const + reference_T);
    end setState_phX;

    redeclare function extends setState_psX
      "Set the thermodynamic state record from p and s (X not needed)"
    algorithm
      state := ThermodynamicState(p=p, T=reference_T*cp_const/(cp_const - s +
        reference_s + (p - reference_p)*(-beta_const/reference_d)));
    end setState_psX;

    redeclare function extends setState_dTX
      "Set the thermodynamic state record from d and T (X not needed)"
    algorithm
      state := ThermodynamicState(p=((d - reference_d) + (T - reference_T)
        *beta_const*reference_d)/(reference_d*kappa_const) + reference_p, T=T);
    end setState_dTX;

    redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
    algorithm
      state := ThermodynamicState(p=Media.Common.smoothStep(
              x,
              state_a.p,
              state_b.p,
              x_small), T=Media.Common.smoothStep(
              x,
              state_a.T,
              state_b.T,
              x_small));
    end setSmoothState;

    redeclare function extends pressure
      "Return the pressure from the thermodynamic state"
    algorithm
      p := state.p;
    end pressure;

    redeclare function extends temperature
      "Return the temperature from the thermodynamic state"
    algorithm
      T := state.T;
    end temperature;

    redeclare function extends density
      "Return the density from the thermodynamic state"
    algorithm
      d := (1 + (state.p - reference_p)*kappa_const - (state.T - reference_T)*
        beta_const)*reference_d;
    end density;

    redeclare function extends specificEnthalpy
      "Return the specific enthalpy from the thermodynamic state"
    algorithm
      h := reference_h + (state.T - reference_T)*cp_const + (state.p -
        reference_p)*(1 - beta_const*reference_T)/reference_d;
    end specificEnthalpy;

    redeclare function extends specificEntropy
      "Return the specific entropy from the thermodynamic state"
    algorithm
      s := reference_s + (state.T - reference_T)*cp_const/state.T + (state.p -
        reference_p)*(-beta_const/reference_d);
    end specificEntropy;

    redeclare function extends specificInternalEnergy
      "Return the specific internal energy from the thermodynamic state"
    algorithm
      u := specificEnthalpy(state) - state.p/reference_d;
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
      a := sqrt(max(0, 1/(kappa_const*density(state) - beta_const*beta_const*
        state.T/cp_const)));
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
    "Specific entropy at component inlet";
  ThermodynamicState downstreamState "State at downstream location";
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

      h_is := specificEnthalpy(setState_pTX(
              p_downstream,
              reference_T/(1 - ((refState.T - reference_T)/refState.T + (
          refState.p - p_downstream)*(-beta_const/(reference_d*cp_const)))),
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
      cv := if constantJacobian then cp_const - reference_T*beta_const*
        beta_const/(kappa_const*reference_d) else state.T*beta_const*beta_const
        /(kappa_const*reference_d);
    end specificHeatCapacityCv;

    redeclare function extends isothermalCompressibility
      "Return the isothermal compressibility kappa"
    algorithm
      kappa := kappa_const;
    end isothermalCompressibility;

    redeclare function extends isobaricExpansionCoefficient
      "Return the isobaric expansion coefficient"
    algorithm
      beta := beta_const;
    end isobaricExpansionCoefficient;

    redeclare function extends density_derp_h
      "Return density derivative w.r.t. pressure at const specific enthalpy"
    algorithm
      ddph := if constantJacobian then kappa_const*reference_d + (beta_const*(1
         - reference_T*beta_const))/cp_const else kappa_const*density(state) +
        (beta_const*(1 - temperature(state)*beta_const))/cp_const;
    end density_derp_h;

    redeclare function extends density_derh_p
      "Return density derivative w.r.t. specific enthalpy at constant pressure"
    algorithm
      ddhp := if constantJacobian then -beta_const*reference_d/cp_const else -
        beta_const*density(state)/cp_const;
    end density_derh_p;

    redeclare function extends density_derp_T
      "Return density derivative w.r.t. pressure at const temperature"
    algorithm
      ddpT := if constantJacobian then kappa_const*reference_d else kappa_const
        *density(state);
    end density_derp_T;

    redeclare function extends density_derT_p
      "Return density derivative w.r.t. temperature at constant pressure"
    algorithm
      ddTp := if constantJacobian then -beta_const*reference_d else -beta_const
        *density(state);
    end density_derT_p;

    redeclare function extends density_derX
      "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature"
    algorithm
      dddX := fill(0, nX);
    end density_derX;

    redeclare function extends molarMass "Return molar mass"
    algorithm
      MM := MM_const;
    end molarMass;

    function T_ph "Return temperature from pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input SpecificEnthalpy h "Specific enthalpy";
      input AbsolutePressure p "Pressure";
      output Temperature T "Temperature";
    algorithm
      T := (h - reference_h - (p - reference_p)*((1 - beta_const*reference_T)/
        reference_d))/cp_const + reference_T;
    end T_ph;

    function T_ps "Return temperature from pressure and specific entropy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output Temperature T "Temperature";
    algorithm
      T := reference_T*cp_const/(s - reference_s - (p - reference_p)*(-
        beta_const/reference_d) - cp_const);
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
<li>The influence of density on specific enthalpy (h), entropy (s), inner energy (u) and heat capacity (cv) at constant volume is neglected.</li>
</ul>
<p>
That means that the density is a linear function in temperature and in pressure.
In order to define the complete model, a number of constant reference values are needed which
are computed at the reference values of the states pressure p and temperature T. The model can
be interpreted as a linearization of a full non-linear fluid model (but it is not linear in all
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
be more \"correct\" based on the other assumptions, if occurrences of reference_d in the computations of h,s,u
and cv would be replaced by a call to density(state). That would require a numerical solution for T_ps, while T_ph can be solved symbolically from a quadratic function. Errors from this approximation are small because liquid density varies little.</p>
<h4>Efficiency considerations</h4>
<p>One of the main reasons to use a simple, linear fluid model is to achieve high performance
in simulations. There are a number of possible compromises and possibilities to improve performance.
Some of them can be influenced by a flag. The following rules where used in this model:</p>
<ul>
<li>All forward evaluations (using the ThermodynamicState record as input) are exactly following
the assumptions above.</li>
<li>If the flag <strong>constantJacobian</strong> is set to true in the package, all functions that
typically appear in thermodynamic Jacobians (specificHeatCapacityCv, density_derp_h, density_derh_p,
density_derp_T, density_derT_p) are evaluated at reference conditions (that means using the reference
density) instead of the density of the current pressure and temperature. This makes it possible to evaluate
the thermodynamic Jacobian at compile time.</li>
<li>For inverse functions using other inputs than the states (e.g pressure p and specific enthalpy h),
the inversion is using the reference state whenever that is necessary to achieve a symbolic inversion.</li>
<li>If <strong>constantJacobian</strong> is set to false, the above list of functions is computed exactly according
to the above list of assumptions</li>
</ul>
<dl>
<dt><strong>Authors:</strong></dt>
<dd>Francesco Casella<br>
    Dipartimento di Elettronica e Informazione<br>
    Politecnico di Milano<br>
    Via Ponzio 34/5<br>
    I-20133 Milano, Italy<br>
    email: <a href=\"mailto:casella@elet.polimi.it\">casella@elet.polimi.it</a><br>
    and<br>
    Hubertus Tummescheit<br>
    Modelon AB<br>
    Ideon Science Park<br>
    SE-22730 Lund, Sweden<br>
    email: <a href=\"mailto:Hubertus.Tummescheit@Modelon.se\">Hubertus.Tummescheit@Modelon.se</a>
</dd>
</dl>
</html>"));
  end PartialLinearFluid;

  partial package PartialMixtureMedium
    "Base class for pure substances of several chemical substances"
    extends PartialMedium(redeclare replaceable record FluidConstants =
          Modelica.Media.Interfaces.Types.IdealGas.FluidConstants);

    redeclare replaceable record extends ThermodynamicState
      "Thermodynamic state variables"
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
      MassFraction[nX] X(start=reference_X)
        "Mass fractions (= (component mass)/total mass  m_i/m)";
    end ThermodynamicState;

    constant FluidConstants[nS] fluidConstants "Constant data for the fluid";

    replaceable function gasConstant
      "Return the gas constant of the mixture (also for liquids)"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state";
      output SI.SpecificHeatCapacity R_s "Mixture gas constant";
    end gasConstant;

    function moleToMassFractions "Return mass fractions X from mole fractions"
      extends Modelica.Icons.Function;
      input SI.MoleFraction moleFractions[:] "Mole fractions of mixture";
      input MolarMass[:] MMX "Molar masses of components";
      output SI.MassFraction X[size(moleFractions, 1)]
        "Mass fractions of gas mixture";
    protected
      MolarMass Mmix=moleFractions*MMX "Molar mass of mixture";
    algorithm
      for i in 1:size(moleFractions, 1) loop
        X[i] := moleFractions[i]*MMX[i]/Mmix;
      end for;
      annotation (smoothOrder=5);
    end moleToMassFractions;

    function massToMoleFractions "Return mole fractions from mass fractions X"
      extends Modelica.Icons.Function;
      input SI.MassFraction X[:] "Mass fractions of mixture";
      input SI.MolarMass[:] MMX "Molar masses of components";
      output SI.MoleFraction moleFractions[size(X, 1)]
        "Mole fractions of gas mixture";
    protected
      Real invMMX[size(X, 1)] "Inverses of molar weights";
      SI.MolarMass Mmix "Molar mass of mixture";
    algorithm
      for i in 1:size(X, 1) loop
        invMMX[i] := 1/MMX[i];
      end for;
      Mmix := 1/(X*invMMX);
      for i in 1:size(X, 1) loop
        moleFractions[i] := Mmix*X[i]/MMX[i];
      end for;
      annotation (smoothOrder=5);
    end massToMoleFractions;

  end PartialMixtureMedium;

  partial package PartialCondensingGases
    "Base class for mixtures of condensing and non-condensing gases"
    extends PartialMixtureMedium(ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX);

    replaceable partial function saturationPressure
      "Return saturation pressure of condensing fluid"
      extends Modelica.Icons.Function;
      input Temperature Tsat "Saturation temperature";
      output AbsolutePressure psat "Saturation pressure";
    end saturationPressure;

    replaceable partial function enthalpyOfVaporization
      "Return vaporization enthalpy of condensing fluid"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output SpecificEnthalpy r0 "Vaporization enthalpy";
    end enthalpyOfVaporization;

    replaceable partial function enthalpyOfLiquid
      "Return liquid enthalpy of condensing fluid"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output SpecificEnthalpy h "Liquid enthalpy";
    end enthalpyOfLiquid;

    replaceable partial function enthalpyOfGas
      "Return enthalpy of non-condensing gas mixture"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      input MassFraction[:] X "Vector of mass fractions";
      output SpecificEnthalpy h "Specific enthalpy";
    end enthalpyOfGas;

    replaceable partial function enthalpyOfCondensingGas
      "Return enthalpy of condensing gas (most often steam)"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output SpecificEnthalpy h "Specific enthalpy";
    end enthalpyOfCondensingGas;

    replaceable partial function enthalpyOfNonCondensingGas
      "Return enthalpy of the non-condensing species"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output SpecificEnthalpy h "Specific enthalpy";
    end enthalpyOfNonCondensingGas;
  end PartialCondensingGases;

  partial package PartialRealCondensingGases
    "Base class for mixtures of real condensing and non-condensing gases"
    extends Modelica.Media.Interfaces.PartialMixtureMedium(
      redeclare replaceable record FluidConstants =
        Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants);

    replaceable partial function saturationPressure
      "Return saturation pressure of condensing fluid"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output AbsolutePressure psat "Saturation pressure";
    end saturationPressure;

    replaceable partial function saturationTemperature
      "Return saturation temperature of condensing fluid"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output Temperature Tsat "Saturation temperature";
    end saturationTemperature;

    replaceable partial function massFractionSaturation
      "Return saturation mass fractions"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction[:] Xsat "Saturation mass fractions";
    end massFractionSaturation;

    replaceable partial function massFraction_pTphi
      "Return mass fractions as a function of pressure, temperature and relative humidity"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input Real phi "Relative humidity";
      output MassFraction[:] X "Mass fractions";
    end massFraction_pTphi;

    replaceable partial function relativeHumidity "Return relative humidity"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output Real phi "Relative humidity";
    end relativeHumidity;

    replaceable partial function enthalpyOfVaporization
      "Return vaporization enthalpy of condensing fluid"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnthalpy r0 "Vaporization enthalpy";
    end enthalpyOfVaporization;

    replaceable partial function enthalpyOfLiquid
      "Return liquid enthalpy of condensing fluid"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnthalpy h "Liquid enthalpy";
    end enthalpyOfLiquid;

    replaceable partial function enthalpyOfGas
      "Return enthalpy of non-condensing gas mixture"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnthalpy h "Specific enthalpy";
    end enthalpyOfGas;

    replaceable partial function enthalpyOfCondensingGas
      "Return enthalpy of condensing gas (most often steam)"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnthalpy h "Specific enthalpy";
    end enthalpyOfCondensingGas;

    replaceable partial function enthalpyOfNonCondensingGas
      "Return enthalpy of the non-condensing species"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SpecificEnthalpy h "Specific enthalpy";
    end enthalpyOfNonCondensingGas;

    replaceable partial function specificEntropy_phX
      "Return specific entropy as a function of pressure, specific enthalpy and mass fractions"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output SpecificEntropy s "Specific entropy";
    algorithm
      s := specificEntropy(setState_phX(
              p,
              h,
              X));
    end specificEntropy_phX;

  end PartialRealCondensingGases;

  partial package PartialTwoPhaseMedium
    "Base class for two phase medium of one substance"
    extends PartialPureSubstance(redeclare replaceable record FluidConstants =
          Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants);
    constant Boolean smoothModel=false
      "True if the (derived) model should not generate state events";
    constant Boolean onePhase=false
      "True if the (derived) model should never be called with two-phase inputs";

    constant FluidConstants[nS] fluidConstants "Constant data for the fluid";

    redeclare replaceable record extends ThermodynamicState
      "Thermodynamic state of two phase medium"
      FixedPhase phase(min=0, max=2)
        "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use";
    end ThermodynamicState;

    redeclare replaceable partial model extends BaseProperties
      "Base properties (p, d, T, h, u, R_s, MM, sat) of two phase medium"
      SaturationProperties sat "Saturation properties at the medium pressure";
    end BaseProperties;

    replaceable partial function setDewState
      "Return the thermodynamic state on the dew line"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation point";
      input FixedPhase phase(
        min=1,
        max=2) = 1 "Phase: default is one phase";
      output ThermodynamicState state "Complete thermodynamic state info";
    end setDewState;

    replaceable partial function setBubbleState
      "Return the thermodynamic state on the bubble line"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation point";
      input FixedPhase phase(
        min=1,
        max=2) = 1 "Phase: default is one phase";
      output ThermodynamicState state "Complete thermodynamic state info";
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
      input Temperature T "Temperature";
      output SaturationProperties sat "Saturation property record";
    algorithm
      sat.Tsat := T;
      sat.psat := saturationPressure(T);
    end setSat_T;

    replaceable function setSat_p
      "Return saturation property record from pressure"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      output SaturationProperties sat "Saturation property record";
    algorithm
      sat.psat := p;
      sat.Tsat := saturationTemperature(p);
    end setSat_p;

    replaceable partial function bubbleEnthalpy
      "Return bubble point specific enthalpy"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output SI.SpecificEnthalpy hl "Boiling curve specific enthalpy";
    end bubbleEnthalpy;

    replaceable partial function dewEnthalpy
      "Return dew point specific enthalpy"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output SI.SpecificEnthalpy hv "Dew curve specific enthalpy";
    end dewEnthalpy;

    replaceable partial function bubbleEntropy
      "Return bubble point specific entropy"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output SI.SpecificEntropy sl "Boiling curve specific entropy";
    end bubbleEntropy;

    replaceable partial function dewEntropy "Return dew point specific entropy"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output SI.SpecificEntropy sv "Dew curve specific entropy";
    end dewEntropy;

    replaceable partial function bubbleDensity "Return bubble point density"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output Density dl "Boiling curve density";
    end bubbleDensity;

    replaceable partial function dewDensity "Return dew point density"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output Density dv "Dew curve density";
    end dewDensity;

    replaceable partial function saturationPressure
      "Return saturation pressure"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output AbsolutePressure p "Saturation pressure";
    end saturationPressure;

    replaceable partial function saturationTemperature
      "Return saturation temperature"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      output Temperature T "Saturation temperature";
    end saturationTemperature;

    replaceable function saturationPressure_sat "Return saturation pressure"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output AbsolutePressure p "Saturation pressure";
    algorithm
      p := sat.psat;
    end saturationPressure_sat;

    replaceable function saturationTemperature_sat
      "Return saturation temperature"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output Temperature T "Saturation temperature";
    algorithm
      T := sat.Tsat;
    end saturationTemperature_sat;

    replaceable partial function saturationTemperature_derp
      "Return derivative of saturation temperature w.r.t. pressure"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      output DerTemperatureByPressure dTp
        "Derivative of saturation temperature w.r.t. pressure";
    end saturationTemperature_derp;

    replaceable function saturationTemperature_derp_sat
      "Return derivative of saturation temperature w.r.t. pressure"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output DerTemperatureByPressure dTp
        "Derivative of saturation temperature w.r.t. pressure";
    algorithm
      dTp := saturationTemperature_derp(sat.psat);
    end saturationTemperature_derp_sat;

    replaceable partial function surfaceTension
      "Return surface tension sigma in the two phase region"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output SurfaceTension sigma
        "Surface tension sigma in the two phase region";
    end surfaceTension;

    redeclare replaceable function extends molarMass
      "Return the molar mass of the medium"
    algorithm
      MM := fluidConstants[1].molarMass;
    end molarMass;

    replaceable partial function dBubbleDensity_dPressure
      "Return bubble point density derivative"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output DerDensityByPressure ddldp "Boiling curve density derivative";
    end dBubbleDensity_dPressure;

    replaceable partial function dDewDensity_dPressure
      "Return dew point density derivative"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output DerDensityByPressure ddvdp "Saturated steam density derivative";
    end dDewDensity_dPressure;

    replaceable partial function dBubbleEnthalpy_dPressure
      "Return bubble point specific enthalpy derivative"
      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output DerEnthalpyByPressure dhldp
        "Boiling curve specific enthalpy derivative";
    end dBubbleEnthalpy_dPressure;

    replaceable partial function dDewEnthalpy_dPressure
      "Return dew point specific enthalpy derivative"
      extends Modelica.Icons.Function;

      input SaturationProperties sat "Saturation property record";
      output DerEnthalpyByPressure dhvdp
        "Saturated steam specific enthalpy derivative";
    end dDewEnthalpy_dPressure;

    redeclare replaceable function specificEnthalpy_pTX
      "Return specific enthalpy from pressure, temperature and mass fraction"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:] "Mass fractions";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "Specific enthalpy at p, T, X";
    algorithm
      h := specificEnthalpy(setState_pTX(
              p,
              T,
              X,
              phase));
    end specificEnthalpy_pTX;

    redeclare replaceable function temperature_phX
      "Return temperature from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:] "Mass fractions";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Temperature T "Temperature";
    algorithm
      T := temperature(setState_phX(
              p,
              h,
              X,
              phase));
    end temperature_phX;

    redeclare replaceable function density_phX
      "Return density from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:] "Mass fractions";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm
      d := density(setState_phX(
              p,
              h,
              X,
              phase));
    end density_phX;

    redeclare replaceable function temperature_psX
      "Return temperature from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:] "Mass fractions";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Temperature T "Temperature";
    algorithm
      T := temperature(setState_psX(
              p,
              s,
              X,
              phase));
    end temperature_psX;

    redeclare replaceable function density_psX
      "Return density from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:] "Mass fractions";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm
      d := density(setState_psX(
              p,
              s,
              X,
              phase));
    end density_psX;

    redeclare replaceable function specificEnthalpy_psX
      "Return specific enthalpy from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:] "Mass fractions";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy(setState_psX(
              p,
              s,
              X,
              phase));
    end specificEnthalpy_psX;

    redeclare replaceable function setState_pT
      "Return thermodynamic state from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_pTX(
              p,
              T,
              fill(0, 0),
              phase);
    end setState_pT;

    redeclare replaceable function setState_ph
      "Return thermodynamic state from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_phX(
              p,
              h,
              fill(0, 0),
              phase);
    end setState_ph;

    redeclare replaceable function setState_ps
      "Return thermodynamic state from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_psX(
              p,
              s,
              fill(0, 0),
              phase);
    end setState_ps;

    redeclare replaceable function setState_dT
      "Return thermodynamic state from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_dTX(
              d,
              T,
              fill(0, 0),
              phase);
    end setState_dT;

    replaceable function setState_px
      "Return thermodynamic state from pressure and vapour quality"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input MassFraction x "Vapour quality";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_ph(
              p,
              (1 - x)*bubbleEnthalpy(setSat_p(p)) + x*dewEnthalpy(setSat_p(p)),
              2);
    end setState_px;

    replaceable function setState_Tx
      "Return thermodynamic state from temperature and vapour quality"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      input MassFraction x "Vapour quality";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := setState_ph(
              saturationPressure_sat(setSat_T(T)),
              (1 - x)*bubbleEnthalpy(setSat_T(T)) + x*dewEnthalpy(setSat_T(T)),
              2);
    end setState_Tx;

    replaceable function vapourQuality "Return vapour quality"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction x "Vapour quality";
    protected
      constant SpecificEnthalpy eps=1e-8;
    algorithm
      x := min(max((specificEnthalpy(state) - bubbleEnthalpy(setSat_p(pressure(
        state))))/(dewEnthalpy(setSat_p(pressure(state))) - bubbleEnthalpy(
        setSat_p(pressure(state))) + eps), 0), 1);
    end vapourQuality;

    redeclare replaceable function density_ph "Return density from p and h"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm
      d := density_phX(
              p,
              h,
              fill(0, 0),
              phase);
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
      T := temperature_phX(
              p,
              h,
              fill(0, 0),
              phase);
    end temperature_ph;

    redeclare replaceable function pressure_dT "Return pressure from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output AbsolutePressure p "Pressure";
    algorithm
      p := pressure(setState_dTX(
              d,
              T,
              fill(0, 0),
              phase));
    end pressure_dT;

    redeclare replaceable function specificEnthalpy_dT
      "Return specific enthalpy from d and T"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy(setState_dTX(
              d,
              T,
              fill(0, 0),
              phase));
    end specificEnthalpy_dT;

    redeclare replaceable function specificEnthalpy_ps
      "Return specific enthalpy from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy_psX(
              p,
              s,
              fill(0, 0));
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
      T := temperature_psX(
              p,
              s,
              fill(0, 0),
              phase);
    end temperature_ps;

    redeclare replaceable function density_ps "Return density from p and s"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm
      d := density_psX(
              p,
              s,
              fill(0, 0),
              phase);
    end density_ps;

    redeclare replaceable function specificEnthalpy_pT
      "Return specific enthalpy from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := specificEnthalpy_pTX(
              p,
              T,
              fill(0, 0),
              phase);
    end specificEnthalpy_pT;

    redeclare replaceable function density_pT "Return density from p and T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm
      d := density(setState_pTX(
              p,
              T,
              fill(0, 0),
              phase));
    end density_pT;
  end PartialTwoPhaseMedium;

  partial package PartialSimpleMedium
    "Medium model with linear dependency of u, h from temperature. All other quantities, especially density, are constant."

    extends Interfaces.PartialPureSubstance(final ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pT,
        final singleState=true);

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

    constant FluidConstants[nS] fluidConstants "Fluid constants";

    redeclare record extends ThermodynamicState "Thermodynamic state"
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
    end ThermodynamicState;

    redeclare replaceable model extends BaseProperties(T(stateSelect=if
            preferredMediumStates then StateSelect.prefer else StateSelect.default),
        p(stateSelect=if preferredMediumStates then StateSelect.prefer else
            StateSelect.default)) "Base properties"
    equation
      assert(T >= T_min and T <= T_max, "
Temperature T (= " + String(T) + " K) is not
in the allowed range (" + String(T_min) + " K <= T <= " + String(T_max) + " K)
required from medium model \"" + mediumName + "\".
");

      // h = cp_const*(T-T0);
      h = specificEnthalpy_pTX(
              p,
              T,
              X);
      u = cv_const*(T - T0);
      d = d_const;
      R_s = 0;
      MM = MM_const;
      state.T = T;
      state.p = p;
      annotation (Documentation(info="<html>
<p>
This is the most simple incompressible medium model, where
specific enthalpy h and specific internal energy u are only
a function of temperature T and all other provided medium
quantities are assumed to be constant.
Note that the (small) influence of the pressure term p/d is neglected.
</p>
</html>"));
    end BaseProperties;

    redeclare function setState_pTX
      "Return thermodynamic state from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p, T=T);
    end setState_pTX;

    redeclare function setState_phX
      "Return thermodynamic state from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p, T=T0 + h/cp_const);
    end setState_phX;

    redeclare replaceable function setState_psX
      "Return thermodynamic state from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p, T=Modelica.Math.exp(s/cp_const +
        Modelica.Math.log(reference_T)))
        "Here the incompressible limit is used, with cp as heat capacity";
    end setState_psX;

    redeclare function setState_dTX
      "Return thermodynamic state from d, T, and X or Xi"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      assert(false,
        "Pressure can not be computed from temperature and density for an incompressible fluid!");
    end setState_dTX;

    redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
    algorithm
      state := ThermodynamicState(p=Media.Common.smoothStep(
              x,
              state_a.p,
              state_b.p,
              x_small), T=Media.Common.smoothStep(
              x,
              state_a.T,
              state_b.T,
              x_small));
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
      h := cp_const*(state.T - T0);
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

    redeclare function extends velocityOfSound "Return velocity of sound"

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
      h := cp_const*(T - T0);
      annotation (Documentation(info="<html>
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
      output Density d "Density";
    algorithm
      d := density(setState_phX(
              p,
              h,
              X));
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
      dddX := fill(0, nX);
    end density_derX;

    redeclare function extends molarMass "Return the molar mass of the medium"
    algorithm
      MM := MM_const;
    end molarMass;
  end PartialSimpleMedium;

  partial package PartialSimpleIdealGasMedium
    "Medium model of Ideal gas with constant cp and cv. All other quantities, e.g., transport properties, are constant."

    extends Interfaces.PartialPureSubstance(
      redeclare replaceable record FluidConstants =
          Modelica.Media.Interfaces.Types.Basic.FluidConstants,
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pT,
      final singleState=false);

    constant SpecificHeatCapacity cp_const
      "Constant specific heat capacity at constant pressure";
    constant SpecificHeatCapacity cv_const=cp_const - R_gas
      "Constant specific heat capacity at constant volume";
    constant SpecificHeatCapacity R_gas "Medium specific gas constant";
    constant MolarMass MM_const "Molar mass";
    constant DynamicViscosity eta_const "Constant dynamic viscosity";
    constant ThermalConductivity lambda_const "Constant thermal conductivity";
    constant Temperature T_min "Minimum temperature valid for medium model";
    constant Temperature T_max "Maximum temperature valid for medium model";
    constant Temperature T0=reference_T "Zero enthalpy temperature";
    constant FluidConstants[nS] fluidConstants "Fluid constants";

    redeclare record extends ThermodynamicState
      "Thermodynamic state of ideal gas"
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
    end ThermodynamicState;

    redeclare replaceable model extends BaseProperties(T(stateSelect=if
            preferredMediumStates then StateSelect.prefer else StateSelect.default),
        p(stateSelect=if preferredMediumStates then StateSelect.prefer else
            StateSelect.default)) "Base properties of ideal gas"
    equation
      assert(T >= T_min and T <= T_max, "
Temperature T (= " + String(T) + " K) is not
in the allowed range (" + String(T_min) + " K <= T <= " + String(T_max) + " K)
required from medium model \"" + mediumName + "\".
");
      h = specificEnthalpy_pTX(
              p,
              T,
              X);
      u = h - R_s*T;
      R_s = R_gas;
      d = p/(R_s*T);
      MM = MM_const;
      state.T = T;
      state.p = p;
      annotation (Documentation(info="<html>
<p>
This is the most simple incompressible medium model, where
specific enthalpy h and specific internal energy u are only
a function of temperature T and all other provided medium
quantities are assumed to be constant.
</p>
</html>"));
    end BaseProperties;

    redeclare function setState_pTX
      "Return thermodynamic state from p, T, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p, T=T);
    end setState_pTX;

    redeclare function setState_phX
      "Return thermodynamic state from p, h, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p, T=T0 + h/cp_const);
    end setState_phX;

    redeclare replaceable function setState_psX
      "Return thermodynamic state from p, s, and X or Xi"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=p, T=Modelica.Math.exp(s/cp_const +
        Modelica.Math.log(reference_T) + R_gas*Modelica.Math.log(p/reference_p)));
    end setState_psX;

    redeclare function setState_dTX
      "Return thermodynamic state from d, T, and X or Xi"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state record";
    algorithm
      state := ThermodynamicState(p=d*R_gas*T, T=T);
    end setState_dTX;

    redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
    algorithm
      state := ThermodynamicState(p=Media.Common.smoothStep(
              x,
              state_a.p,
              state_b.p,
              x_small), T=Media.Common.smoothStep(
              x,
              state_a.T,
              state_b.T,
              x_small));
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
      h := cp_const*(state.T - T0);
    end specificEnthalpy;

    redeclare function extends specificInternalEnergy
      "Return specific internal energy"
      extends Modelica.Icons.Function;
    algorithm
      u := cp_const*(state.T - T0) - R_gas*state.T;
    end specificInternalEnergy;

    redeclare function extends specificEntropy "Return specific entropy"
      extends Modelica.Icons.Function;
    algorithm
      s := cp_const*Modelica.Math.log(state.T/T0) - R_gas*Modelica.Math.log(
        state.p/reference_p);
    end specificEntropy;

    redeclare function extends specificGibbsEnergy
      "Return specific Gibbs energy"
      extends Modelica.Icons.Function;
    algorithm
      g := cp_const*(state.T - T0) - state.T*specificEntropy(state);
    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy
      "Return specific Helmholtz energy"
      extends Modelica.Icons.Function;
    algorithm
      f := specificInternalEnergy(state) - state.T*specificEntropy(state);
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

    redeclare function extends velocityOfSound "Return velocity of sound"

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
      h := cp_const*(T - T0);
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
      output Density d "Density";
    algorithm
      d := density(setState_phX(
              p,
              h,
              X));
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
      h_is := cp_const*(refState.T*(p_downstream/refState.p)^(R_gas/cp_const)
         - T0);
    end isentropicEnthalpy;

    redeclare function extends isobaricExpansionCoefficient
      "Returns overall the isobaric expansion coefficient beta"
    algorithm
      /* beta = 1/v * der(v,T), with v = 1/d, at constant pressure p:
       v = R_s*T/p
       der(v,T) = R_s/p
       beta = p/(R_s*T)*R_s/p
            = 1/T
    */

      beta := 1/state.T;
    end isobaricExpansionCoefficient;

    redeclare function extends isothermalCompressibility
      "Returns overall the isothermal compressibility factor"
    algorithm
      /* kappa = - 1/v * der(v,p), with v = 1/d at constant temperature T.
       v = R_s*T/p
       der(v,T) = -R_s*T/p^2
       kappa = p/(R_s*T)*R_s*T/p^2
             = 1/p
    */
      kappa := 1/state.p;
    end isothermalCompressibility;

    redeclare function extends density_derp_T
      "Returns the partial derivative of density with respect to pressure at constant temperature"
    algorithm
      /*  d = p/(R_s*T)
        ddpT = 1/(R_s*T)
    */
      ddpT := 1/(R_gas*state.T);
    end density_derp_T;

    redeclare function extends density_derT_p
      "Returns the partial derivative of density with respect to temperature at constant pressure"
    algorithm
      /*  d = p/(R_s*T)
        ddpT = -p/(R_s*T^2)
    */
      ddTp := -state.p/(R_gas*state.T*state.T);
    end density_derT_p;

    redeclare function extends density_derX
      "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature"
    algorithm
      dddX := fill(0, nX);
    end density_derX;

    redeclare function extends molarMass "Returns the molar mass of the medium"
    algorithm
      MM := MM_const;
    end molarMass;
  end PartialSimpleIdealGasMedium;

  package Choices "Types, constants to define menu choices"
    extends Modelica.Icons.Package;

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
      "Enumeration defining initialization for fluid flow" annotation (Evaluate=
         true);

    type ReferenceEnthalpy = enumeration(
        ZeroAt0K
          "The enthalpy is 0 at 0 K (default), if the enthalpy of formation is excluded",
        ZeroAt25C
          "The enthalpy is 0 at 25 degC, if the enthalpy of formation is excluded",
        UserDefined
          "The user-defined reference enthalpy is used at 293.15 K (25 degC)")
      "Enumeration defining the reference enthalpy of a medium" annotation (
        Evaluate=true);

    type ReferenceEntropy = enumeration(
        ZeroAt0K "The entropy is 0 at 0 K (default)",
        ZeroAt0C "The entropy is 0 at 0 degC",
        UserDefined
          "The user-defined reference entropy is used at 293.15 K (25 degC)")
      "Enumeration defining the reference entropy of a medium" annotation (
        Evaluate=true);

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
<p>
Enumerations and data types for all types of fluids
</p>

<p>
Note: Reference enthalpy might have to be extended with enthalpy of formation.
</p>
</html>"));
  end Choices;

  package Types "Types to be used in fluid models"
    extends Modelica.Icons.Package;

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
        start=288.15) "Type for temperature with medium specific attributes";
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
    type ExtraPropertyFlowRate = Real (unit="kg/s")
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
      "Type for partial derivative of density with respect to pressure with medium specific attributes";
    type DerDensityByEnthalpy = SI.DerDensityByEnthalpy
      "Type for partial derivative of density with respect to enthalpy with medium specific attributes";
    type DerEnthalpyByPressure = SI.DerEnthalpyByPressure
      "Type for partial derivative of enthalpy with respect to pressure with medium specific attributes";
    type DerDensityByTemperature = SI.DerDensityByTemperature
      "Type for partial derivative of density with respect to temperature with medium specific attributes";
    type DerTemperatureByPressure = Real (final unit="K/Pa")
      "Type for partial derivative of temperature with respect to pressure with medium specific attributes";

    replaceable record SaturationProperties
      "Saturation properties of two phase medium"
      extends Modelica.Icons.Record;
      AbsolutePressure psat "Saturation pressure";
      Temperature Tsat "Saturation temperature";
    end SaturationProperties;

    record FluidLimits "Validity limits for fluid model"
      extends Modelica.Icons.Record;
      Temperature TMIN "Minimum temperature";
      Temperature TMAX "Maximum temperature";
      Density DMIN "Minimum density";
      Density DMAX "Maximum density";
      AbsolutePressure PMIN "Minimum pressure";
      AbsolutePressure PMAX "Maximum pressure";
      SpecificEnthalpy HMIN "Minimum enthalpy";
      SpecificEnthalpy HMAX "Maximum enthalpy";
      SpecificEntropy SMIN "Minimum entropy";
      SpecificEntropy SMAX "Maximum entropy";
      annotation (Documentation(info="<html>
          <p>The minimum pressure mostly applies to the liquid state only.
          The minimum density is also arbitrary, but is reasonable for technical
          applications to limit iterations in non-linear systems. The limits in
          enthalpy and entropy are used as safeguards in inverse iterations.</p>
          </html>"));
    end FluidLimits;

    type FixedPhase = Integer (min=0, max=2)
      "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use";
    package Basic
      "The most basic version of a record used in several degrees of detail"
      extends Icons.Package;

      record FluidConstants
        "Critical, triple, molecular and other standard data of fluid"
        extends Modelica.Icons.Record;
        String iupacName
          "Complete IUPAC name (or common name, if non-existent)";
        String casRegistryNumber
          "Chemical abstracts sequencing number (if it exists)";
        String chemicalFormula
          "Chemical formula, (brutto, nomenclature according to Hill";
        String structureFormula "Chemical structure formula";
        MolarMass molarMass "Molar mass";
      end FluidConstants;

    end Basic;

    package IdealGas
      "The ideal gas version of a record used in several degrees of detail"
      extends Icons.Package;

      record FluidConstants "Extended fluid constants"
        extends Modelica.Media.Interfaces.Types.Basic.FluidConstants;
        Temperature criticalTemperature "Critical temperature";
        AbsolutePressure criticalPressure "Critical pressure";
        MolarVolume criticalMolarVolume "Critical molar Volume";
        Real acentricFactor "Pitzer acentric factor";
        //   Temperature triplePointTemperature "Triple point temperature";
        //   AbsolutePressure triplePointPressure "Triple point pressure";
        Temperature meltingPoint "Melting point at 101325 Pa";
        Temperature normalBoilingPoint "Normal boiling point (at 101325 Pa)";
        DipoleMoment dipoleMoment
          "Dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
        Boolean hasIdealGasHeatCapacity=false
          "True if ideal gas heat capacity is available";
        Boolean hasCriticalData=false "True if critical data are known";
        Boolean hasDipoleMoment=false "True if a dipole moment known";
        Boolean hasFundamentalEquation=false "True if a fundamental equation";
        Boolean hasLiquidHeatCapacity=false
          "True if liquid heat capacity is available";
        Boolean hasSolidHeatCapacity=false
          "True if solid heat capacity is available";
        Boolean hasAccurateViscosityData=false
          "True if accurate data for a viscosity function is available";
        Boolean hasAccurateConductivityData=false
          "True if accurate data for thermal conductivity is available";
        Boolean hasVapourPressureCurve=false
          "True if vapour pressure data, e.g., Antoine coefficients are known";
        Boolean hasAcentricFactor=false
          "True if Pitzer acentric factor is known";
        SpecificEnthalpy HCRIT0=0.0
          "Critical specific enthalpy of the fundamental equation";
        SpecificEntropy SCRIT0=0.0
          "Critical specific entropy of the fundamental equation";
        SpecificEnthalpy deltah=0.0
          "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
        SpecificEntropy deltas=0.0
          "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
      end FluidConstants;
    end IdealGas;

    package TwoPhase
      "The two phase fluid version of a record used in several degrees of detail"
      extends Icons.Package;

      record FluidConstants "Extended fluid constants"
        extends Modelica.Media.Interfaces.Types.Basic.FluidConstants;
        Temperature criticalTemperature "Critical temperature";
        AbsolutePressure criticalPressure "Critical pressure";
        MolarVolume criticalMolarVolume "Critical molar Volume";
        Real acentricFactor "Pitzer acentric factor";
        Temperature triplePointTemperature "Triple point temperature";
        AbsolutePressure triplePointPressure "Triple point pressure";
        Temperature meltingPoint "Melting point at 101325 Pa";
        Temperature normalBoilingPoint "Normal boiling point (at 101325 Pa)";
        DipoleMoment dipoleMoment
          "Dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
        Boolean hasIdealGasHeatCapacity=false
          "True if ideal gas heat capacity is available";
        Boolean hasCriticalData=false "True if critical data are known";
        Boolean hasDipoleMoment=false "True if a dipole moment known";
        Boolean hasFundamentalEquation=false "True if a fundamental equation";
        Boolean hasLiquidHeatCapacity=false
          "True if liquid heat capacity is available";
        Boolean hasSolidHeatCapacity=false
          "True if solid heat capacity is available";
        Boolean hasAccurateViscosityData=false
          "True if accurate data for a viscosity function is available";
        Boolean hasAccurateConductivityData=false
          "True if accurate data for thermal conductivity is available";
        Boolean hasVapourPressureCurve=false
          "True if vapour pressure data, e.g., Antoine coefficients are known";
        Boolean hasAcentricFactor=false
          "True if Pitzer acentric factor is known";
        SpecificEnthalpy HCRIT0=0.0
          "Critical specific enthalpy of the fundamental equation";
        SpecificEntropy SCRIT0=0.0
          "Critical specific entropy of the fundamental equation";
        SpecificEnthalpy deltah=0.0
          "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
        SpecificEntropy deltas=0.0
          "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
      end FluidConstants;
    end TwoPhase;

  end Types;
  annotation (Documentation(info="<html>
<p>
This package provides basic interfaces definitions of media models for different
kind of media.
</p>
</html>"));
end Interfaces;

package Common "Data structures and fundamental functions for fluid properties"

  extends Modelica.Icons.Package;
  type Rate = Real (final quantity="Rate", final unit="s-1");
  type MolarFlowRate = Real (final quantity="MolarFlowRate", final unit="mol/s");
  type MolarReactionRate = Real (final quantity="MolarReactionRate", final unit=
         "mol/(m3.s)");
  type MolarEnthalpy = Real (final quantity="MolarEnthalpy", final unit="J/mol");
  type DerDensityByEntropy = Real (final quantity="DerDensityByEntropy", final
        unit="kg2.K/(m3.J)");
  type DerEnergyByPressure = Real (final quantity="DerEnergyByPressure", final
        unit="J/Pa");
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
  type DerVolumeByPressure = Real (final quantity="DerVolumeByPressure", final
        unit="m3/Pa");
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
    "Minimal value for physical variables which are always > 0.0";

  constant SI.Area AMIN=MINPOS "Minimal init area";
  constant SI.Area AMAX=1.0e5 "Maximal init area";
  constant SI.Area ANOM=1.0 "Nominal init area";
  constant SI.AmountOfSubstance MOLMIN=-1.0*MINPOS "Minimal Mole Number";
  constant SI.AmountOfSubstance MOLMAX=1.0e8 "Maximal Mole Number";
  constant SI.AmountOfSubstance MOLNOM=1.0 "Nominal Mole Number";
  constant SI.Density DMIN=1e-6 "Minimal init density";
  constant SI.Density DMAX=30.0e3 "Maximal init density";
  constant SI.Density DNOM=1.0 "Nominal init density";
  constant SI.ThermalConductivity LAMMIN=MINPOS "Minimal thermal conductivity";
  constant SI.ThermalConductivity LAMNOM=1.0 "Nominal thermal conductivity";
  constant SI.ThermalConductivity LAMMAX=1000.0 "Maximal thermal conductivity";
  constant SI.DynamicViscosity ETAMIN=MINPOS "Minimal init dynamic viscosity";
  constant SI.DynamicViscosity ETAMAX=1.0e8 "Maximal init dynamic viscosity";
  constant SI.DynamicViscosity ETANOM=100.0 "Nominal init dynamic viscosity";
  constant SI.Energy EMIN=-1.0e10 "Minimal init energy";
  constant SI.Energy EMAX=1.0e10 "Maximal init energy";
  constant SI.Energy ENOM=1.0e3 "Nominal init energy";
  constant SI.Entropy SMIN=-1.0e6 "Minimal init entropy";
  constant SI.Entropy SMAX=1.0e6 "Maximal init entropy";
  constant SI.Entropy SNOM=1.0e3 "Nominal init entropy";
  constant SI.MassFlowRate MDOTMIN=-1.0e5 "Minimal init mass flow rate";
  constant SI.MassFlowRate MDOTMAX=1.0e5 "Maximal init mass flow rate";
  constant SI.MassFlowRate MDOTNOM=1.0 "Nominal init mass flow rate";
  constant SI.MassFraction MASSXMIN=-1.0*MINPOS "Minimal init mass fraction";
  constant SI.MassFraction MASSXMAX=1.0 "Maximal init mass fraction";
  constant SI.MassFraction MASSXNOM=0.1 "Nominal init mass fraction";
  constant SI.Mass MMIN=-1.0*MINPOS "Minimal init mass";
  constant SI.Mass MMAX=1.0e8 "Maximal init mass";
  constant SI.Mass MNOM=1.0 "Nominal init mass";
  constant SI.MolarMass MMMIN=0.001 "Minimal initial molar mass";
  constant SI.MolarMass MMMAX=250.0 "Maximal initial molar mass";
  constant SI.MolarMass MMNOM=0.2 "Nominal initial molar mass";
  constant SI.MoleFraction MOLEYMIN=-1.0*MINPOS "Minimal init mole fraction";
  constant SI.MoleFraction MOLEYMAX=1.0 "Maximal init mole fraction";
  constant SI.MoleFraction MOLEYNOM=0.1 "Nominal init mole fraction";
  constant SI.MomentumFlux GMIN=-1.0e8 "Minimal init momentum flux";
  constant SI.MomentumFlux GMAX=1.0e8 "Maximal init momentum flux";
  constant SI.MomentumFlux GNOM=1.0 "Nominal init momentum flux";
  constant SI.Power POWMIN=-1.0e8 "Minimal init power or heat";
  constant SI.Power POWMAX=1.0e8 "Maximal init power or heat";
  constant SI.Power POWNOM=1.0e3 "Nominal init power or heat";
  constant SI.Pressure PMIN=1.0e4 "Minimal init pressure";
  constant SI.Pressure PMAX=1.0e8 "Maximal init pressure";
  constant SI.Pressure PNOM=1.0e5 "Nominal init pressure";
  constant SI.Pressure COMPPMIN=-1.0*MINPOS "Minimal init pressure";
  constant SI.Pressure COMPPMAX=1.0e8 "Maximal init pressure";
  constant SI.Pressure COMPPNOM=1.0e5 "Nominal init pressure";
  constant SI.RatioOfSpecificHeatCapacities KAPPAMIN=1.0
    "Minimal init isentropic exponent";
  constant SI.RatioOfSpecificHeatCapacities KAPPAMAX=1.7
    "Maximal init isentropic exponent";
  constant SI.RatioOfSpecificHeatCapacities KAPPANOM=1.2
    "Nominal init isentropic exponent";
  constant SI.SpecificEnergy SEMIN=-1.0e8 "Minimal init specific energy";
  constant SI.SpecificEnergy SEMAX=1.0e8 "Maximal init specific energy";
  constant SI.SpecificEnergy SENOM=1.0e6 "Nominal init specific energy";
  constant SI.SpecificEnthalpy SHMIN=-1.0e8 "Minimal init specific enthalpy";
  constant SI.SpecificEnthalpy SHMAX=1.0e8 "Maximal init specific enthalpy";
  constant SI.SpecificEnthalpy SHNOM=1.0e6 "Nominal init specific enthalpy";
  constant SI.SpecificEntropy SSMIN=-1.0e6 "Minimal init specific entropy";
  constant SI.SpecificEntropy SSMAX=1.0e6 "Maximal init specific entropy";
  constant SI.SpecificEntropy SSNOM=1.0e3 "Nominal init specific entropy";
  constant SI.SpecificHeatCapacity CPMIN=MINPOS
    "Minimal init specific heat capacity";
  constant SI.SpecificHeatCapacity CPMAX=1.0e6
    "Maximal init specific heat capacity";
  constant SI.SpecificHeatCapacity CPNOM=1.0e3
    "Nominal init specific heat capacity";
  constant SI.Temperature TMIN=1.0 "Minimal init temperature";
  constant SI.Temperature TMAX=6000.0 "Maximal init temperature";
  constant SI.Temperature TNOM=320.0 "Nominal init temperature";
  constant SI.ThermalConductivity LMIN=MINPOS
    "Minimal init thermal conductivity";
  constant SI.ThermalConductivity LMAX=500.0
    "Maximal init thermal conductivity";
  constant SI.ThermalConductivity LNOM=1.0 "Nominal init thermal conductivity";
  constant SI.Velocity VELMIN=-1.0e5 "Minimal init speed";
  constant SI.Velocity VELMAX=1.0e5 "Maximal init speed";
  constant SI.Velocity VELNOM=1.0 "Nominal init speed";
  constant SI.Volume VMIN=0.0 "Minimal init volume";
  constant SI.Volume VMAX=1.0e5 "Maximal init volume";
  constant SI.Volume VNOM=1.0e-3 "Nominal init volume";

  package ThermoFluidSpecial "Property records used by the ThermoFluid library"
    extends Modelica.Icons.Package;
    record FixedIGProperties "Constant properties for ideal gases"
      extends Modelica.Icons.Record;
      parameter Integer nspecies(min=1) "Number of components";
      SI.MolarMass[nspecies] MM "Molar mass of components";
      Real[nspecies] invMM "Inverse of molar mass of components";
      SI.SpecificHeatCapacity[nspecies] R_s "Gas constant";
      SI.SpecificEnthalpy[nspecies] Hf "Enthalpy of formation at 298.15K";
      SI.SpecificEnthalpy[nspecies] H0 "H0(298.15K) - H0(0K)";
    end FixedIGProperties;

    record ThermoBaseVars
      extends Modelica.Icons.Record;
      parameter Integer n(min=1) "Discretization number";
      parameter Integer nspecies(min=1) "Number of species";
      SI.Pressure[n] p(
        min=PMIN,
        max=PMAX,
        nominal=PNOM,
        start=fill(1.0e5, n)) "Pressure";
      SI.Temperature[n] T(
        min=TMIN,
        max=TMAX,
        nominal=TNOM) "Temperature";
      SI.Density[n] d(
        min=DMIN,
        max=DMAX,
        nominal=DNOM) "Density";
      SI.SpecificEnthalpy[n] h(
        min=SHMIN,
        max=SHMAX,
        nominal=SHNOM) "Specific enthalpy";
      SI.SpecificEntropy[n] s(
        min=SSMIN,
        max=SSMAX,
        nominal=SSNOM) "Specific entropy";
      SI.RatioOfSpecificHeatCapacities[n] kappa "Ratio of cp/cv";
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
      SI.MassFraction[n, nspecies] mass_x(
        min=MASSXMIN,
        max=MASSXMAX,
        nominal=MASSXNOM) "Mass fraction";
      SI.MoleFraction[n, nspecies] mole_y(
        min=MOLEYMIN,
        max=MOLEYMAX,
        nominal=MOLEYNOM) "Mole fraction";
      SI.Mass[n, nspecies] M_x(
        min=MMIN,
        max=MMAX,
        nominal=MNOM) "Component mass";
      SI.MassFlowRate[n, nspecies] dM_x(
        min=MDOTMIN,
        max=MDOTMAX,
        nominal=MDOTNOM) "Rate of change in component mass";
      MolarFlowRate[n, nspecies] dZ(
        min=-1.0e6,
        max=1.0e6,
        nominal=0.0) "Rate of change in component moles";
      MolarFlowRate[n, nspecies] rZ(
        min=-1.0e6,
        max=1.0e6,
        nominal=0.0) "Reaction(source) mole rates";
      SI.MolarMass[n] MM(
        min=MMMIN,
        max=MMMAX,
        nominal=MMNOM) "Molar mass of mixture";
      SI.AmountOfSubstance[n] Moles(
        min=MOLMIN,
        max=MOLMAX,
        nominal=MOLNOM) "Total moles";
      SI.AmountOfSubstance[n, nspecies] Moles_z(
        min=MOLMIN,
        max=MOLMAX,
        nominal=MOLNOM) "Mole vector";
      annotation (Documentation(info="<html>
                         <h4>Model description</h4>
                              <p>
                              <strong>ThermoBaseVars</strong> is inherited by all medium property models
                              and by all models defining the dynamic states for the conservation
                              of mass and energy. Thus it is a good choice as a restricting class
                              for any medium model or dynamic state model.
                           </p>
                              </html>"));
    end ThermoBaseVars;

    record ThermoProperties
      "Thermodynamic base property data for all state models"
      extends Modelica.Icons.Record;
      parameter Integer nspecies(min=1) "Number of species";
      SI.Temperature T(
        min=TMIN,
        max=TMAX,
        nominal=TNOM) "Temperature";
      SI.Density d(
        min=DMIN,
        max=DMAX,
        nominal=DNOM) "Density";
      SI.Pressure p(
        min=PMIN,
        max=PMAX,
        nominal=PNOM) "Pressure";
      SI.Volume V(
        min=VMIN,
        max=VMAX,
        nominal=VNOM) "Volume";
      SI.SpecificEnthalpy h(
        min=SHMIN,
        max=SHMAX,
        nominal=SHNOM) "Specific enthalpy";
      SI.SpecificEnergy u(
        min=SEMIN,
        max=SEMAX,
        nominal=SENOM) "Specific inner energy";
      SI.SpecificEntropy s(
        min=SSMIN,
        max=SSMAX,
        nominal=SSNOM) "Specific entropy";
      SI.SpecificGibbsFreeEnergy g(
        min=SHMIN,
        max=SHMAX,
        nominal=SHNOM) "Specific Gibbs free energy";
      SI.SpecificHeatCapacity cp(
        min=CPMIN,
        max=CPMAX,
        nominal=CPNOM) "Heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=CPMIN,
        max=CPMAX,
        nominal=CPNOM) "Heat capacity at constant volume";
      SI.SpecificHeatCapacity R_s(
        min=CPMIN,
        max=CPMAX,
        nominal=CPNOM) "Gas constant";
      SI.MolarMass MM(
        min=MMMIN,
        max=MMMAX,
        nominal=MMNOM) "Molar mass of mixture";
      SI.MassFraction[nspecies] mass_x(
        min=MASSXMIN,
        max=MASSXMAX,
        nominal=MASSXNOM) "Mass fraction";
      SI.MoleFraction[nspecies] mole_y(
        min=MOLEYMIN,
        max=MOLEYMAX,
        nominal=MOLEYNOM) "Mole fraction";
      SI.RatioOfSpecificHeatCapacities kappa "Ratio of cp/cv";
      SI.DerDensityByTemperature ddTp
        "Derivative of density by temperature at constant pressure";
      SI.DerDensityByPressure ddpT
        "Derivative of density by pressure at constant temperature";
      Real dupT(unit="m3.kg-1")
        "Derivative of inner energy by pressure at constant T";
      Real dudT(unit="(J.m3)/(kg2)")
        "Derivative of inner energy by density at constant T";
      SI.SpecificHeatCapacity duTp
        "Derivative of inner energy by temperature at constant p";
      SI.SpecificEnergy ddx[nspecies]
        "Derivative vector of density by change in mass composition";
      SI.SpecificEnergy[nspecies] compu(
        min=SEMIN,
        max=SEMAX,
        nominal=SENOM) "Inner energy of the components";
      SI.Pressure[nspecies] compp(
        min=COMPPMIN,
        max=COMPPMAX,
        nominal=COMPPNOM) "Partial pressures of the components";
      SI.Velocity a(
        min=VELMIN,
        max=VELMAX,
        nominal=VELNOM) "Speed of sound";
      SI.HeatCapacity dUTZ
        "Derivative of inner energy by temperature at constant moles";
      SI.MolarInternalEnergy[nspecies] dUZT
        "Derivative of inner energy by moles at constant temperature";
      SI.SpecificEnthalpy[nspecies] dHMxT(
        min=SEMIN,
        max=SEMAX,
        nominal=SENOM)
        "Derivative of total enthalpy w.r.t. component mass at constant T";
      Real dpT "Derivative of pressure w.r.t. temperature";
      Real dpZ[nspecies] "Derivative of pressure w.r.t. moles";
      annotation (Documentation(info="<html>
        <h4>Model description</h4>
        <p>
        A base class for medium property models which work with most of the
        versions of dynamic states that are available in the ThermoFluid
        library. Currently used by all ideal gas models.
     </p>
        </html>"));
    end ThermoProperties;

    record ThermoProperties_ph
      "Thermodynamic property data for pressure p and specific enthalpy h as dynamic states"

      extends Modelica.Icons.Record;
      SI.Temperature T(
        min=1.0e-9,
        max=10000.0,
        nominal=298.15) "Temperature";
      SI.Density d(
        min=1.0e-9,
        max=10000.0,
        nominal=10.0) "Density";
      SI.SpecificEnergy u(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "Specific inner energy";
      SI.SpecificEntropy s(
        min=-1.0e6,
        max=1.0e6,
        nominal=1.0e3) "Specific entropy";
      SI.SpecificHeatCapacity cp(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Heat capacity at constant volume";
      SI.SpecificHeatCapacity R_s(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Gas constant";
      SI.RatioOfSpecificHeatCapacities kappa "Ratio of cp/cv";
      SI.Velocity a(
        min=1.0,
        max=10000.0,
        nominal=300.0) "Speed of sound";
      SI.DerDensityByEnthalpy ddhp
        "Derivative of density by enthalpy at constant pressure";
      SI.DerDensityByPressure ddph
        "Derivative of density by pressure at constant enthalpy";
      Real duph(unit="m3/kg")
        "Derivative of inner energy by pressure at constant enthalpy";
      Real duhp(unit="1")
        "Derivative of inner energy by enthalpy at constant pressure";
      annotation (Documentation(info="<html>
<h4>Model description</h4>
<p>
A base class for medium property models which
use pressure and enthalpy as dynamic states.
This is the preferred model for fluids that can also be in the
two phase and liquid regions.
</p>
</html>"));
    end ThermoProperties_ph;

    record ThermoProperties_pT
      "Thermodynamic property data for pressure p and temperature T as dynamic states"

      extends Modelica.Icons.Record;
      SI.Density d(
        min=1.0e-9,
        max=10000.0,
        nominal=10.0) "Density";
      SI.SpecificEnthalpy h(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "Specific enthalpy";
      SI.SpecificEnergy u(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "Specific inner energy";
      SI.SpecificEntropy s(
        min=-1.0e6,
        max=1.0e6,
        nominal=1.0e3) "Specific entropy";
      SI.SpecificHeatCapacity cp(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Heat capacity at constant volume";
      SI.SpecificHeatCapacity R_s(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Gas constant";
      SI.RatioOfSpecificHeatCapacities kappa "Ratio of cp/cv";
      SI.Velocity a(
        min=1.0,
        max=10000.0,
        nominal=300.0) "Speed of sound";
      SI.DerDensityByTemperature ddTp
        "Derivative of density by temperature at constant pressure";
      SI.DerDensityByPressure ddpT
        "Derivative of density by pressure at constant temperature";
      Real dupT(unit="m3.kg-1")
        "Derivative of inner energy by pressure at constant T";
      SI.SpecificHeatCapacity duTp
        "Derivative of inner energy by temperature at constant p";
      annotation (Documentation(info="<html>
<h4>Model description</h4>
<p>
A base class for medium property models which use pressure and temperature as dynamic states.
This is a reasonable model for fluids that can also be in the gas and
liquid regions, but never in the two-phase region.
</p>
</html>"));
    end ThermoProperties_pT;

    record ThermoProperties_dT
      "Thermodynamic property data for density d and temperature T as dynamic states"

      extends Modelica.Icons.Record;
      SI.Pressure p(
        min=1.0,
        max=1.0e9,
        nominal=1.0e5) "Pressure";
      SI.SpecificEnthalpy h(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "Specific enthalpy";
      SI.SpecificEnergy u(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "Specific inner energy";
      SI.SpecificEntropy s(
        min=-1.0e6,
        max=1.0e6,
        nominal=1.0e3) "Specific entropy";
      SI.SpecificHeatCapacity cp(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Heat capacity at constant volume";
      SI.SpecificHeatCapacity R_s(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "Gas constant";
      SI.RatioOfSpecificHeatCapacities kappa "Ratio of cp/cv";
      SI.Velocity a(
        min=1.0,
        max=10000.0,
        nominal=300.0) "Speed of sound";
      Real dudT(unit="m5/(kg.s2)")
        "Derivative of inner energy by density at constant T";
      annotation (Documentation(info="<html>
<h4>Model description</h4>
<p>
A base class for medium property models which use density and temperature as dynamic states.
This is a reasonable model for fluids that can be in the gas, liquid
and two-phase region. The model is numerically not well suited for
liquids except if the pressure is always above approx. 80% of the
critical pressure.
</p>
</html>"));
    end ThermoProperties_dT;

    //   record GibbsDerivs

    //     "Derivatives of dimensionless Gibbs-function w.r.t. dimensionless pressure and temperature"
    //     extends Modelica.Icons.Record;
    //     Real pi "Dimensionless pressure";
    //     Real tau "Dimensionless temperature";
    //     Real g "Dimensionless Gibbs-function";
    //     Real gpi "Derivative of g w.r.t. pi";
    //     Real gpipi "2nd derivative of g w.r.t. pi";
    //     Real gtau "Derivative of g w.r.t. tau";
    //     Real gtautau "2nd derivative of g w.r.t. tau";
    //     Real gtaupi "Mixed derivative of g w.r.t. pi and tau";
    //   end GibbsDerivs;

    //   record HelmholtzDerivs

    //     "Derivatives of dimensionless Helmholtz-function w.r.t. dimensionless pressure, density and temperature"
    //     extends Modelica.Icons.Record;
    //     Real delta "Dimensionless density";
    //     Real tau "Dimensionless temperature";
    //     Real f "Dimensionless Helmholtz-function";
    //     Real fdelta "Derivative of f w.r.t. delta";
    //     Real fdeltadelta "2nd derivative of f w.r.t. delta";
    //     Real ftau "Derivative of f w.r.t. tau";
    //     Real ftautau "2nd derivative of f w.r.t. tau";
    //     Real fdeltatau "Mixed derivative of f w.r.t. delta and tau";
    //   end HelmholtzDerivs;

    record TransportProps "Record with transport properties"
      extends Modelica.Icons.Record;
      SI.DynamicViscosity eta;
      SI.ThermalConductivity lam;
    end TransportProps;

    function gibbsToProps_ph
      "Calculate property record for pressure and specific enthalpy as states from dimensionless Gibbs function"

      extends Modelica.Icons.Function;
      input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
      output ThermoProperties_ph pro
        "Property record for pressure and specific enthalpy as dynamic states";
    protected
      Real vt(unit="m3.kg-1.K-1")
        "Derivative of specific volume w.r.t. temperature";
      Real vp(unit="m4.kg-2.s2")
        "Derivative of specific volume w.r.t. pressure";
    algorithm
      pro.T := g.T;
      pro.R_s := g.R_s;
      pro.d := g.p/(pro.R_s*pro.T*g.pi*g.gpi);
      pro.u := g.T*g.R_s*(g.tau*g.gtau - g.pi*g.gpi);
      pro.s := pro.R_s*(g.tau*g.gtau - g.g);
      pro.cp := -pro.R_s*g.tau*g.tau*g.gtautau;
      pro.cv := pro.R_s*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/(g.gpipi));
      pro.a := abs(g.R_s*g.T*(g.gpi*g.gpi/((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau
        *g.gtaupi)/(g.tau*g.tau*g.gtautau) - g.gpipi)))^0.5;
      vt := g.R_s/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R_s*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      pro.kappa := -1/(pro.d*g.p)*pro.cp/(vp*pro.cp + vt*vt*g.T);
      pro.ddhp := -pro.d*pro.d*vt/(pro.cp);
      pro.ddph := -pro.d*pro.d*(vp*pro.cp - vt/pro.d + g.T*vt*vt)/pro.cp;
      pro.duph := -1/pro.d + g.p/(pro.d*pro.d)*pro.ddph;
      pro.duhp := 1 + g.p/(pro.d*pro.d)*pro.ddhp;
    end gibbsToProps_ph;

    function gibbsToBoundaryProps
      "Calculate phase boundary property record from dimensionless Gibbs function"

      extends Modelica.Icons.Function;
      input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
      output PhaseBoundaryProperties sat "Phase boundary properties";
    protected
      Real vt(unit="m3.kg-1.K-1")
        "Derivative of specific volume w.r.t. temperature";
      Real vp(unit="m4.kg-2.s2")
        "Derivative of specific volume w.r.t. pressure";
    algorithm
      sat.d := g.p/(g.R_s*g.T*g.pi*g.gpi);
      sat.h := g.R_s*g.T*g.tau*g.gtau;
      sat.u := g.T*g.R_s*(g.tau*g.gtau - g.pi*g.gpi);
      sat.s := g.R_s*(g.tau*g.gtau - g.g);
      sat.cp := -g.R_s*g.tau*g.tau*g.gtautau;
      sat.cv := g.R_s*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/(g.gpipi));
      vt := g.R_s/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R_s*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      // sat.kappa := -1/(sat.d*g.p)*sat.cp/(vp*sat.cp + vt*vt*g.T);
      sat.pt := -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
      sat.pd := -g.R_s*g.T*g.gpi*g.gpi/(g.gpipi);
    end gibbsToBoundaryProps;

    function gibbsToProps_dT
      "Calculate property record for density and temperature as states from dimensionless Gibbs function"

      extends Modelica.Icons.Function;
      input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
      output ThermoProperties_dT pro
        "Property record for density and temperature as dynamic states";
    protected
      Real vt(unit="m3.kg-1.K-1")
        "Derivative of specific volume w.r.t. temperature";
      Real vp(unit="m4.kg-2.s2")
        "Derivative of specific volume w.r.t. pressure";
      SI.Density d;
    algorithm
      pro.R_s := g.R_s;
      pro.p := g.p;
      pro.u := g.T*g.R_s*(g.tau*g.gtau - g.pi*g.gpi);
      pro.h := g.R_s*g.T*g.tau*g.gtau;
      pro.s := pro.R_s*(g.tau*g.gtau - g.g);
      pro.cp := -pro.R_s*g.tau*g.tau*g.gtautau;
      pro.cv := pro.R_s*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/g.gpipi);
      vt := g.R_s/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R_s*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      pro.kappa := -1/((g.p/(pro.R_s*g.T*g.pi*g.gpi))*g.p)*pro.cp/(vp*pro.cp + vt
        *vt*g.T);
      pro.a := abs(g.R_s*g.T*(g.gpi*g.gpi/((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau
        *g.gtaupi)/(g.tau*g.tau*g.gtautau) - g.gpipi)))^0.5;

      d := g.p/(pro.R_s*g.T*g.pi*g.gpi);
      pro.dudT := (pro.p - g.T*vt/vp)/(d*d);
    end gibbsToProps_dT;

    function gibbsToProps_pT
      "Calculate property record for pressure and temperature as states from dimensionless Gibbs function"

      extends Modelica.Icons.Function;
      input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
      output ThermoProperties_pT pro
        "Property record for pressure and temperature as dynamic states";
    protected
      Real vt(unit="m3.kg-1.K-1")
        "Derivative of specific volume w.r.t. temperature";
      Real vp(unit="m4.kg-2.s2")
        "Derivative of specific volume w.r.t. pressure";
    algorithm
      pro.R_s := g.R_s;
      pro.d := g.p/(pro.R_s*g.T*g.pi*g.gpi);
      pro.u := g.T*g.R_s*(g.tau*g.gtau - g.pi*g.gpi);
      pro.h := g.R_s*g.T*g.tau*g.gtau;
      pro.s := pro.R_s*(g.tau*g.gtau - g.g);
      pro.cp := -pro.R_s*g.tau*g.tau*g.gtautau;
      pro.cv := pro.R_s*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/g.gpipi);
      vt := g.R_s/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R_s*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      pro.kappa := -1/(pro.d*g.p)*pro.cp/(vp*pro.cp + vt*vt*g.T);
      pro.a := abs(g.R_s*g.T*(g.gpi*g.gpi/((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau
        *g.gtaupi)/(g.tau*g.tau*g.gtautau) - g.gpipi)))^0.5;
      pro.ddpT := -(pro.d*pro.d)*vp;
      pro.ddTp := -(pro.d*pro.d)*vt;
      pro.duTp := pro.cp - g.p*vt;
      pro.dupT := -g.T*vt - g.p*vp;
    end gibbsToProps_pT;

    function helmholtzToProps_ph
      "Calculate property record for pressure and specific enthalpy as states from dimensionless Helmholtz function"

      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
      output ThermoProperties_ph pro
        "Property record for pressure and specific enthalpy as dynamic states";
    protected
      SI.Pressure p "Pressure";
      DerPressureByDensity pd "Derivative of pressure w.r.t. density";
      DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
      DerPressureBySpecificVolume pv
        "Derivative of pressure w.r.t. specific volume";
    algorithm
      pro.d := f.d;
      pro.T := f.T;
      pro.R_s := f.R_s;
      pro.s := f.R_s*(f.tau*f.ftau - f.f);
      pro.u := f.R_s*f.T*f.tau*f.ftau;
      p := pro.d*pro.R_s*pro.T*f.delta*f.fdelta;
      pd := f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      pv := -pd*f.d*f.d;

      // calculating cp near the critical point may be troublesome (cp -> inf).
      pro.cp := f.R_s*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
        *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
      pro.cv := f.R_s*(-f.tau*f.tau*f.ftautau);
      pro.kappa := 1/(f.d*f.R_s*f.d*f.T*f.delta*f.fdelta)*((-pv*pro.cv + pt*pt*f.T)
        /(pro.cv));
      pro.a := abs(f.R_s*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta
         - ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta -
        f.delta*f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
      pro.ddph := (f.d*(pro.cv*f.d + pt))/(f.d*f.d*pd*pro.cv + f.T*pt*pt);
      pro.ddhp := -f.d*f.d*pt/(f.d*f.d*pd*pro.cv + f.T*pt*pt);
      pro.duph := -1/pro.d + p/(pro.d*pro.d)*pro.ddph;
      pro.duhp := 1 + p/(pro.d*pro.d)*pro.ddhp;
    end helmholtzToProps_ph;

    function helmholtzToProps_pT
      "Calculate property record for pressure and temperature as states from dimensionless Helmholtz function"

      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
      output ThermoProperties_pT pro
        "Property record for pressure and temperature as dynamic states";
    protected
      DerPressureByDensity pd "Derivative of pressure w.r.t. density";
      DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
      DerPressureBySpecificVolume pv
        "Derivative of pressure w.r.t. specific volume";
      IsobaricVolumeExpansionCoefficient alpha
        "Isobaric volume expansion coefficient";
      // beta in Bejan
      IsothermalCompressibility gamma "Isothermal compressibility";
      // kappa in Bejan
      SI.Pressure p "Pressure";
    algorithm
      pro.d := f.d;
      pro.R_s := f.R_s;
      pro.s := f.R_s*(f.tau*f.ftau - f.f);
      pro.h := f.R_s*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
      pro.u := f.R_s*f.T*f.tau*f.ftau;
      pd := f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      pv := -(f.d*f.d)*pd;
      alpha := -f.d*pt/pv;
      gamma := -f.d/pv;
      p := f.R_s*f.d*f.T*f.delta*f.fdelta;
      // calculating cp near the critical point may be troublesome (cp -> inf).
      pro.cp := f.R_s*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
        *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
      pro.cv := f.R_s*(-f.tau*f.tau*f.ftautau);
      pro.kappa := 1/(f.d*f.R_s*f.d*f.T*f.delta*f.fdelta)*((-pv*pro.cv + pt*pt*f.T)
        /(pro.cv));
      pro.a := abs(f.R_s*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta
         - ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta -
        f.delta*f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
      pro.ddTp := -pt/pd;
      pro.ddpT := 1/pd;
      //problem with units in last two lines
      pro.dupT := gamma*p/f.d - alpha*f.T/f.d;
      pro.duTp := pro.cp - alpha*p/f.d;
    end helmholtzToProps_pT;

    function helmholtzToProps_dT
      "Calculate property record for density and temperature as states from dimensionless Helmholtz function"

      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
      output ThermoProperties_dT pro
        "Property record for density and temperature as dynamic states";
    protected
      DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
      DerPressureBySpecificVolume pv "Derivative of pressure w.r.t. pressure";
    algorithm
      pro.p := f.R_s*f.d*f.T*f.delta*f.fdelta;
      pro.R_s := f.R_s;
      pro.s := f.R_s*(f.tau*f.ftau - f.f);
      pro.h := f.R_s*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
      pro.u := f.R_s*f.T*f.tau*f.ftau;
      pv := -(f.d*f.d)*f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);

      // calculating cp near the critical point may be troublesome (cp -> inf).
      pro.cp := f.R_s*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
        *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
      pro.cv := f.R_s*(-f.tau*f.tau*f.ftautau);
      pro.kappa := 1/(f.d*pro.p)*((-pv*pro.cv + pt*pt*f.T)/(pro.cv));
      pro.a := abs(f.R_s*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta
         - ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta -
        f.delta*f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
      pro.dudT := (pro.p - f.T*pt)/(f.d*f.d);
    end helmholtzToProps_dT;

    function TwoPhaseToProps_ph
      "Compute property record for pressure and specific enthalpy as states from saturation properties"

      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation property record";
      output ThermoProperties_ph pro
        "Property record for pressure and specific enthalpy as dynamic states";
    protected
      Real dht(unit="(J/kg)/K")
        "Derivative of specific enthalpy w.r.t. temperature";
      Real dhd(unit="(J/kg)/(kg/m3)")
        "Derivative of specific enthalpy w.r.t. density";
      Real detph(unit="m4.s4/(K.s8)") "Thermodynamic determinant";
    algorithm
      pro.d := sat.d;
      pro.T := sat.T;
      pro.u := sat.u;
      pro.s := sat.s;
      pro.cv := sat.cv;
      pro.R_s := sat.R_s;
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
      "Compute property record for density and temperature as states from saturation properties"

      extends Modelica.Icons.Function;
      input SaturationProperties sat "Saturation properties";
      output ThermoProperties_dT pro
        "Property record for density and temperature as dynamic states";
    algorithm
      pro.p := sat.p;
      pro.h := sat.h;
      pro.u := sat.u;
      pro.s := sat.s;
      pro.cv := sat.cv;
      pro.cp := Modelica.Constants.inf;
      pro.R_s := sat.R_s;
      pro.kappa := -1/(sat.d*sat.p)*sat.dpT*sat.dpT*sat.T/sat.cv;
      pro.a := Modelica.Constants.inf;
      pro.dudT := (sat.p - sat.T*sat.dpT)/(sat.d*sat.d);
    end TwoPhaseToProps_dT;

  end ThermoFluidSpecial;

public
  record SaturationProperties "Properties in the two phase region"
    extends Modelica.Icons.Record;
    SI.Temperature T "Temperature";
    SI.Density d "Density";
    SI.Pressure p "Pressure";
    SI.SpecificEnergy u "Specific inner energy";
    SI.SpecificEnthalpy h "Specific enthalpy";
    SI.SpecificEntropy s "Specific entropy";
    SI.SpecificHeatCapacity cp "Heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv "Heat capacity at constant volume";
    SI.SpecificHeatCapacity R_s "Gas constant";
    SI.RatioOfSpecificHeatCapacities kappa "Isentropic expansion coefficient";
    PhaseBoundaryProperties liq
      "Thermodynamic base properties on the boiling curve";
    PhaseBoundaryProperties vap
      "Thermodynamic base properties on the dew curve";
    Real dpT(unit="Pa/K")
      "Derivative of saturation pressure w.r.t. temperature";
    SI.MassFraction x "Vapour mass fraction";
  end SaturationProperties;

  record SaturationBoundaryProperties
    "Properties on both phase boundaries, including some derivatives"

    extends Modelica.Icons.Record;
    SI.Temperature T "Saturation temperature";
    SI.Density dl "Liquid density";
    SI.Density dv "Vapour density";
    SI.SpecificEnthalpy hl "Liquid specific enthalpy";
    SI.SpecificEnthalpy hv "Vapour specific enthalpy";
    Real dTp "Derivative of temperature w.r.t. saturation pressure";
    Real ddldp "Derivative of density along boiling curve";
    Real ddvdp "Derivative of density along dew curve";
    Real dhldp "Derivative of specific enthalpy along boiling curve";
    Real dhvdp "Derivative of specific enthalpy along dew curve";
    SI.MassFraction x "Vapour mass fraction";
  end SaturationBoundaryProperties;

  record IF97BaseTwoPhase "Intermediate property data record for IF 97"
    extends Modelica.Icons.Record;
    Integer phase(start=0)
      "Phase: 2 for two-phase, 1 for one phase, 0 if unknown";
    Integer region(min=1, max=5) "IF 97 region";
    SI.Pressure p "Pressure";
    SI.Temperature T "Temperature";
    SI.SpecificEnthalpy h "Specific enthalpy";
    SI.SpecificHeatCapacity R_s "Gas constant";
    SI.SpecificHeatCapacity cp "Specific heat capacity";
    SI.SpecificHeatCapacity cv "Specific heat capacity";
    SI.Density rho "Density";
    SI.SpecificEntropy s "Specific entropy";
    DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    DerPressureByDensity pd "Derivative of pressure w.r.t. density";
    Real vt "Derivative of specific volume w.r.t. temperature";
    Real vp "Derivative of specific volume w.r.t. pressure";
    Real x "Dryness fraction";
    Real dpT "dp/dT derivative of saturation curve";
  end IF97BaseTwoPhase;

  record IF97PhaseBoundaryProperties
    "Thermodynamic base properties on the phase boundary for IF97 steam tables"

    extends Modelica.Icons.Record;
    Boolean region3boundary "True if boundary between 2-phase and region 3";
    SI.SpecificHeatCapacity R_s "Specific heat capacity";
    SI.Temperature T "Temperature";
    SI.Density d "Density";
    SI.SpecificEnthalpy h "Specific enthalpy";
    SI.SpecificEntropy s "Specific entropy";
    SI.SpecificHeatCapacity cp "Heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv "Heat capacity at constant volume";
    DerPressureByTemperature dpT "dp/dT derivative of saturation curve";
    DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    DerPressureByDensity pd "Derivative of pressure w.r.t. density";
    Real vt(unit="m3/(kg.K)")
      "Derivative of specific volume w.r.t. temperature";
    Real vp(unit="m3/(kg.Pa)") "Derivative of specific volume w.r.t. pressure";
  end IF97PhaseBoundaryProperties;

  record GibbsDerivs
    "Derivatives of dimensionless Gibbs-function w.r.t. dimensionless pressure and temperature"

    extends Modelica.Icons.Record;
    SI.Pressure p "Pressure";
    SI.Temperature T "Temperature";
    SI.SpecificHeatCapacity R_s "Specific heat capacity";
    Real pi(unit="1") "Dimensionless pressure";
    Real tau(unit="1") "Dimensionless temperature";
    Real g(unit="1") "Dimensionless Gibbs-function";
    Real gpi(unit="1") "Derivative of g w.r.t. pi";
    Real gpipi(unit="1") "2nd derivative of g w.r.t. pi";
    Real gtau(unit="1") "Derivative of g w.r.t. tau";
    Real gtautau(unit="1") "2nd derivative of g w.r.t. tau";
    Real gtaupi(unit="1") "Mixed derivative of g w.r.t. pi and tau";
  end GibbsDerivs;

  record HelmholtzDerivs
    "Derivatives of dimensionless Helmholtz-function w.r.t. dimensionless pressure, density and temperature"
    extends Modelica.Icons.Record;
    SI.Density d "Density";
    SI.Temperature T "Temperature";
    SI.SpecificHeatCapacity R_s "Specific heat capacity";
    Real delta(unit="1") "Dimensionless density";
    Real tau(unit="1") "Dimensionless temperature";
    Real f(unit="1") "Dimensionless Helmholtz-function";
    Real fdelta(unit="1") "Derivative of f w.r.t. delta";
    Real fdeltadelta(unit="1") "2nd derivative of f w.r.t. delta";
    Real ftau(unit="1") "Derivative of f w.r.t. tau";
    Real ftautau(unit="1") "2nd derivative of f w.r.t. tau";
    Real fdeltatau(unit="1") "Mixed derivative of f w.r.t. delta and tau";
  end HelmholtzDerivs;

  record TwoPhaseTransportProps
    "Defines properties on both phase boundaries, needed in the two phase region"
    extends Modelica.Icons.Record;
    SI.Density d_vap "Density on the dew line";
    SI.Density d_liq "Density on the bubble line";
    SI.DynamicViscosity eta_vap "Dynamic viscosity on the dew line";
    SI.DynamicViscosity eta_liq "Dynamic viscosity on the bubble line";
    SI.ThermalConductivity lam_vap "Thermal conductivity on the dew line";
    SI.ThermalConductivity lam_liq "Thermal conductivity on the bubble line";
    SI.SpecificHeatCapacity cp_vap "Cp on the dew line";
    SI.SpecificHeatCapacity cp_liq "Cp on the bubble line";
    SI.MassFraction x "Steam quality";
  end TwoPhaseTransportProps;

  record PhaseBoundaryProperties
    "Thermodynamic base properties on the phase boundary"
    extends Modelica.Icons.Record;
    SI.Density d "Density";
    SI.SpecificEnthalpy h "Specific enthalpy";
    SI.SpecificEnergy u "Inner energy";
    SI.SpecificEntropy s "Specific entropy";
    SI.SpecificHeatCapacity cp "Heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv "Heat capacity at constant volume";
    DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    DerPressureByDensity pd "Derivative of pressure w.r.t. density";
  end PhaseBoundaryProperties;

  record NewtonDerivatives_ph
    "Derivatives for fast inverse calculations of Helmholtz functions: p & h"

    extends Modelica.Icons.Record;
    SI.Pressure p "Pressure";
    SI.SpecificEnthalpy h "Specific enthalpy";
    DerPressureByDensity pd "Derivative of pressure w.r.t. density";
    DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    Real hd "Derivative of specific enthalpy w.r.t. density";
    Real ht "Derivative of specific enthalpy w.r.t. temperature";
  end NewtonDerivatives_ph;

  record NewtonDerivatives_ps
    "Derivatives for fast inverse calculation of Helmholtz functions: p & s"

    extends Modelica.Icons.Record;
    SI.Pressure p "Pressure";
    SI.SpecificEntropy s "Specific entropy";
    DerPressureByDensity pd "Derivative of pressure w.r.t. density";
    DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    Real sd "Derivative of specific entropy w.r.t. density";
    Real st "Derivative of specific entropy w.r.t. temperature";
  end NewtonDerivatives_ps;

  record NewtonDerivatives_pT
    "Derivatives for fast inverse calculations of Helmholtz functions:p & T"

    extends Modelica.Icons.Record;
    SI.Pressure p "Pressure";
    DerPressureByDensity pd "Derivative of pressure w.r.t. density";
  end NewtonDerivatives_pT;

  record ExtraDerivatives "Additional thermodynamic derivatives"
    extends Modelica.Icons.Record;
    IsentropicExponent kappa "Isentropic expansion coefficient";
    // k in Bejan
    IsenthalpicExponent theta "Isenthalpic exponent";
    // same as kappa, except derivative at const h
    IsobaricVolumeExpansionCoefficient alpha
      "Isobaric volume expansion coefficient";
    // beta in Bejan
    IsochoricPressureCoefficient beta "Isochoric pressure coefficient";
    // kT in Bejan
    IsothermalCompressibility gamma "Isothermal compressibility";
    // kappa in Bejan
    JouleThomsonCoefficient mu "Joule-Thomson coefficient";
    // mu_J in Bejan
  end ExtraDerivatives;

  record BridgmansTables
    "Calculates all entries in Bridgmans tables if first seven variables given"
    extends Modelica.Icons.Record;
    // the first 7 need to calculated in a function!
    SI.SpecificVolume v "Specific volume";
    SI.Pressure p "Pressure";
    SI.Temperature T "Temperature";
    SI.SpecificEntropy s "Specific entropy";
    SI.SpecificHeatCapacity cp "Heat capacity at constant pressure";
    IsobaricVolumeExpansionCoefficient alpha
      "Isobaric volume expansion coefficient";
    // beta in Bejan
    IsothermalCompressibility gamma "Isothermal compressibility";
    // kappa in Bejan
    // Derivatives at constant pressure
    Real dTp=1 "Coefficient in Bridgmans table, see info for usage";
    Real dpT=-dTp "Coefficient in Bridgmans table, see info for usage";
    Real dvp=alpha*v "Coefficient in Bridgmans table, see info for usage";
    Real dpv=-dvp "Coefficient in Bridgmans table, see info for usage";
    Real dsp=cp/T "Coefficient in Bridgmans table, see info for usage";
    Real dps=-dsp "Coefficient in Bridgmans table, see info for usage";
    Real dup=cp - alpha*p*v
      "Coefficient in Bridgmans table, see info for usage";
    Real dpu=-dup "Coefficient in Bridgmans table, see info for usage";
    Real dhp=cp "Coefficient in Bridgmans table, see info for usage";
    Real dph=-dhp "Coefficient in Bridgmans table, see info for usage";
    Real dfp=-s - alpha*p*v
      "Coefficient in Bridgmans table, see info for usage";
    Real dpf=-dfp "Coefficient in Bridgmans table, see info for usage";
    Real dgp=-s "Coefficient in Bridgmans table, see info for usage";
    Real dpg=-dgp "Coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant Temperature
    Real dvT=gamma*v "Coefficient in Bridgmans table, see info for usage";
    Real dTv=-dvT "Coefficient in Bridgmans table, see info for usage";
    Real dsT=alpha*v "Coefficient in Bridgmans table, see info for usage";
    Real dTs=-dsT "Coefficient in Bridgmans table, see info for usage";
    Real duT=alpha*T*v - gamma*p*v
      "Coefficient in Bridgmans table, see info for usage";
    Real dTu=-duT "Coefficient in Bridgmans table, see info for usage";
    Real dhT=-v + alpha*T*v
      "Coefficient in Bridgmans table, see info for usage";
    Real dTh=-dhT "Coefficient in Bridgmans table, see info for usage";
    Real dfT=-gamma*p*v "Coefficient in Bridgmans table, see info for usage";
    Real dTf=-dfT "Coefficient in Bridgmans table, see info for usage";
    Real dgT=-v "Coefficient in Bridgmans table, see info for usage";
    Real dTg=-dgT "Coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant v
    Real dsv=alpha*alpha*v*v - gamma*v*cp/T
      "Coefficient in Bridgmans table, see info for usage";
    Real dvs=-dsv "Coefficient in Bridgmans table, see info for usage";
    Real duv=T*alpha*alpha*v*v - gamma*v*cp
      "Coefficient in Bridgmans table, see info for usage";
    Real dvu=-duv "Coefficient in Bridgmans table, see info for usage";
    Real dhv=T*alpha*alpha*v*v - alpha*v*v - gamma*v*cp
      "Coefficient in Bridgmans table, see info for usage";
    Real dvh=-dhv "Coefficient in Bridgmans table, see info for usage";
    Real dfv=gamma*v*s "Coefficient in Bridgmans table, see info for usage";
    Real dvf=-dfv "Coefficient in Bridgmans table, see info for usage";
    Real dgv=gamma*v*s - alpha*v*v
      "Coefficient in Bridgmans table, see info for usage";
    Real dvg=-dgv "Coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant s
    Real dus=dsv*p "Coefficient in Bridgmans table, see info for usage";
    Real dsu=-dus "Coefficient in Bridgmans table, see info for usage";
    Real dhs=-v*cp/T "Coefficient in Bridgmans table, see info for usage";
    Real dsh=-dhs "Coefficient in Bridgmans table, see info for usage";
    Real dfs=alpha*v*s + dus
      "Coefficient in Bridgmans table, see info for usage";
    Real dsf=-dfs "Coefficient in Bridgmans table, see info for usage";
    Real dgs=alpha*v*s - v*cp/T
      "Coefficient in Bridgmans table, see info for usage";
    Real dsg=-dgs "Coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant u
    Real dhu=p*alpha*v*v + gamma*v*cp*p - v*cp - p*T*alpha*alpha*v*v
      "Coefficient in Bridgmans table, see info for usage";
    Real duh=-dhu "Coefficient in Bridgmans table, see info for usage";
    Real dfu=s*T*alpha*v - gamma*v*cp*p - gamma*v*s*p + p*T*alpha*alpha*v*v
      "Coefficient in Bridgmans table, see info for usage";
    Real duf=-dfu "Coefficient in Bridgmans table, see info for usage";
    Real dgu=alpha*v*v*p + alpha*v*s*T - v*cp - gamma*v*s*p
      "Coefficient in Bridgmans table, see info for usage";
    Real dug=-dgu "Coefficient in Bridgmans table, see info for usage";
    //  Derivatives at constant h
    Real dfh=(s - v*alpha*p)*(v - v*alpha*T) - gamma*v*cp*p
      "Coefficient in Bridgmans table, see info for usage";
    Real dhf=-dfh "Coefficient in Bridgmans table, see info for usage";
    Real dgh=alpha*v*s*T - v*(s + cp)
      "Coefficient in Bridgmans table, see info for usage";
    Real dhg=-dgh "Coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant g
    Real dfg=gamma*v*s*p - v*s - alpha*v*v*p
      "Coefficient in Bridgmans table, see info for usage";
    Real dgf=-dfg "Coefficient in Bridgmans table, see info for usage";
    annotation (Documentation(info="<html>
<p>
Important: the phase equilibrium conditions are not yet considered.
this means that Bridgman's tables do not yet work in the two phase region.
Some derivatives are 0 or infinity anyways.
Idea: Do not use the values in Bridgmans table directly, all
derivatives are calculated as the quotient of two entries in the
table. The last letter indicates which variable is held constant in
taking the derivative. The second letters are the two variables
involved in the derivative and the first letter is always a d to remind
of differentiation.
</p>

<blockquote><pre>
Example 1: Get the derivative of specific entropy s w.r.t. Temperature at
constant specific volume (between identical to constant density)
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
specific Helmholtz energy f
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
                </pre></blockquote>

                </html>"));
  end BridgmansTables;

  record FundamentalConstants "Constants of the medium"
    extends Modelica.Icons.Record;
    SI.MolarHeatCapacity R_bar;
    SI.SpecificHeatCapacity R_s;
    SI.MolarMass MM;
    SI.MolarDensity rhored;
    SI.Temperature Tred;
    SI.AbsolutePressure pred;
    SI.SpecificEnthalpy h_off;
    SI.SpecificEntropy s_off;
  end FundamentalConstants;

  record AuxiliaryProperties "Intermediate property data record"
    extends Modelica.Icons.Record;
    SI.Pressure p "Pressure";
    SI.Temperature T "Temperature";
    SI.SpecificEnthalpy h "Specific enthalpy";
    SI.SpecificHeatCapacity R_s "Gas constant";
    SI.SpecificHeatCapacity cp "Specific heat capacity";
    SI.SpecificHeatCapacity cv "Specific heat capacity";
    SI.Density rho "Density";
    SI.SpecificEntropy s "Specific entropy";
    SI.DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    SI.DerPressureByDensity pd "Derivative of pressure w.r.t. density";
    Real vt "Derivative of specific volume w.r.t. temperature";
    Real vp "Derivative of specific volume w.r.t. pressure";
  end AuxiliaryProperties;

  record GibbsDerivs2
    "Derivatives of Gibbs function w.r.t. pressure and temperature"

    extends Modelica.Icons.Record;
    SI.Pressure p "Pressure";
    SI.Temperature T "Temperature";
    SI.SpecificHeatCapacity R_s "Specific heat capacity";
    Real pi(unit="1") "Dimensionless pressure";
    Real theta(unit="1") "Dimensionless temperature";
    Real g(unit="J/kg") "Gibbs function";
    Real gp(unit="m3/kg") "Derivative of g w.r.t. p";
    Real gpp(unit="m3/(kg.Pa)") "2nd derivative of g w.r.t. p";
    Real gT(unit="J/(kg.K)") "Derivative of g w.r.t. T";
    Real gTT(unit="J/(kg.K2)") "2nd derivative of g w.r.t. T";
    Real gTp(unit="m3/(kg.K)") "Mixed derivative of g w.r.t. T and p";
  end GibbsDerivs2;

  record NewtonDerivatives_dT
    "Derivatives for fast inverse calculations of Gibbs function"
    extends Modelica.Icons.Record;
    SI.SpecificVolume v "Specific volume";
    Real vp "Derivative of specific volume w.r.t. pressure";
  end NewtonDerivatives_dT;

  function gibbsToBridgmansTables
    "Calculates base coefficients for Bridgman's tables from gibbs enthalpy"

    extends Modelica.Icons.Function;
    input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
    output SI.SpecificVolume v "Specific volume";
    output SI.Pressure p=g.p "Pressure";
    output SI.Temperature T=g.T "Temperature";
    output SI.SpecificEntropy s "Specific entropy";
    output SI.SpecificHeatCapacity cp "Heat capacity at constant pressure";
    output IsobaricVolumeExpansionCoefficient alpha
      "Isobaric volume expansion coefficient";
    // beta in Bejan
    output IsothermalCompressibility gamma "Isothermal compressibility";
    // kappa in Bejan
  protected
    Real vt(unit="m3/(kg.K)")
      "Derivative of specific volume w.r.t. temperature";
    Real vp(unit="m4.kg-2.s2") "Derivative of specific volume w.r.t. pressure";
  algorithm
    vt := g.R_s/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R_s*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    v := (g.R_s*g.T*g.pi*g.gpi)/g.p;
    s := g.R_s*(g.tau*g.gtau - g.g);
    cp := -g.R_s*g.tau*g.tau*g.gtautau;
    alpha := vt/v;
    gamma := -vp/v;
  end gibbsToBridgmansTables;

  function helmholtzToBridgmansTables
    "Calculates base coefficients for Bridgmans tables from Helmholtz energy"
    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
    output SI.SpecificVolume v=1/f.d "Specific volume";
    output SI.Pressure p "Pressure";
    output SI.Temperature T=f.T "Temperature";
    output SI.SpecificEntropy s "Specific entropy";
    output SI.SpecificHeatCapacity cp "Heat capacity at constant pressure";
    output IsobaricVolumeExpansionCoefficient alpha
      "Isobaric volume expansion coefficient";
    // beta in Bejan
    output IsothermalCompressibility gamma "Isothermal compressibility";
    // kappa in Bejan
  protected
    DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    DerPressureBySpecificVolume pv
      "Derivative of pressure w.r.t. specific volume";
    SI.SpecificHeatCapacity cv "Isochoric specific heat capacity";
  algorithm
    p := f.R_s*f.d*f.T*f.delta*f.fdelta;
    pv := -(f.d*f.d)*f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    s := f.R_s*(f.tau*f.ftau - f.f);
    alpha := -f.d*pt/pv;
    gamma := -f.d/pv;
    cp := f.R_s*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)
      ^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
  end helmholtzToBridgmansTables;

  function gibbsToBoundaryProps
    "Calculate phase boundary property record from dimensionless Gibbs function"

    extends Modelica.Icons.Function;
    input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
    output PhaseBoundaryProperties sat "Phase boundary properties";
  protected
    Real vt "Derivative of specific volume w.r.t. temperature";
    Real vp "Derivative of specific volume w.r.t. pressure";
  algorithm
    sat.d := g.p/(g.R_s*g.T*g.pi*g.gpi);
    sat.h := g.R_s*g.T*g.tau*g.gtau;
    sat.u := g.T*g.R_s*(g.tau*g.gtau - g.pi*g.gpi);
    sat.s := g.R_s*(g.tau*g.gtau - g.g);
    sat.cp := -g.R_s*g.tau*g.tau*g.gtautau;
    sat.cv := g.R_s*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau
      *g.gtaupi)/(g.gpipi));
    vt := g.R_s/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R_s*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    // sat.kappa := -1/(sat.d*g.p)*sat.cp/(vp*sat.cp + vt*vt*g.T);
    sat.pt := -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
    sat.pd := -g.R_s*g.T*g.gpi*g.gpi/(g.gpipi);
  end gibbsToBoundaryProps;

  function helmholtzToBoundaryProps
    "Calculate phase boundary property record from dimensionless Helmholtz function"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
    output PhaseBoundaryProperties sat "Phase boundary property record";
  protected
    SI.Pressure p "Pressure";
  algorithm
    p := f.R_s*f.d*f.T*f.delta*f.fdelta;
    sat.d := f.d;
    sat.h := f.R_s*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
    sat.s := f.R_s*(f.tau*f.ftau - f.f);
    sat.u := f.R_s*f.T*f.tau*f.ftau;
    sat.cp := f.R_s*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)
      ^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
    sat.cv := f.R_s*(-f.tau*f.tau*f.ftautau);
    sat.pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    sat.pd := f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
  end helmholtzToBoundaryProps;

  function cv2Phase
    "Compute isochoric specific heat capacity inside the two-phase region"

    extends Modelica.Icons.Function;
    input PhaseBoundaryProperties liq "Properties on the boiling curve";
    input PhaseBoundaryProperties vap "Properties on the condensation curve";
    input SI.MassFraction x "Vapour mass fraction";
    input SI.Temperature T "Temperature";
    input SI.Pressure p "Properties";
    output SI.SpecificHeatCapacity cv "Isochoric specific heat capacity";
  protected
    Real dpT "Derivative of pressure w.r.t. temperature";
    Real dxv "Derivative of vapour mass fraction w.r.t. specific volume";
    Real dvTl "Derivative of liquid specific volume w.r.t. temperature";
    Real dvTv "Derivative of vapour specific volume w.r.t. temperature";
    Real duTl "Derivative of liquid specific inner energy w.r.t. temperature";
    Real duTv "Derivative of vapour specific inner energy w.r.t. temperature";
    Real dxt "Derivative of vapour mass fraction w.r.t. temperature";
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
    "Compute isochoric specific heat capacity inside the two-phase region and derivative of pressure w.r.t. temperature"

    extends Modelica.Icons.Function;
    input PhaseBoundaryProperties liq "Properties on the boiling curve";
    input PhaseBoundaryProperties vap "Properties on the condensation curve";
    input SI.MassFraction x "Vapour mass fraction";
    input SI.Temperature T "Temperature";
    input SI.Pressure p "Properties";
    output SI.SpecificHeatCapacity cv "Isochoric specific heat capacity";
    output Real dpT "Derivative of pressure w.r.t. temperature";
  protected
    Real dxv "Derivative of vapour mass fraction w.r.t. specific volume";
    Real dvTl "Derivative of liquid specific volume w.r.t. temperature";
    Real dvTv "Derivative of vapour specific volume w.r.t. temperature";
    Real duTl "Derivative of liquid specific inner energy w.r.t. temperature";
    Real duTv "Derivative of vapour specific inner energy w.r.t. temperature";
    Real dxt "Derivative of vapour mass fraction w.r.t. temperature";
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
    "Compute additional thermodynamic derivatives from dimensionless Gibbs function"

    extends Modelica.Icons.Function;
    input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
    output ExtraDerivatives dpro "Additional property derivatives";
  protected
    Real vt "Derivative of specific volume w.r.t. temperature";
    Real vp "Derivative of specific volume w.r.t. pressure";
    SI.Density d "Density";
    SI.SpecificVolume v "Specific volume";
    SI.SpecificHeatCapacity cv "Isochoric heat capacity";
    SI.SpecificHeatCapacity cp "Isobaric heat capacity";
  algorithm
    d := g.p/(g.R_s*g.T*g.pi*g.gpi);
    v := 1/d;
    vt := g.R_s/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R_s*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    cp := -g.R_s*g.tau*g.tau*g.gtautau;
    cv := g.R_s*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau
      *g.gtaupi)/g.gpipi);
    dpro.kappa := -1/(d*g.p)*cp/(vp*cp + vt*vt*g.T);
    dpro.theta := cp/(d*g.p*(-vp*cp + vt*v - g.T*vt*vt));
    dpro.alpha := d*vt;
    dpro.beta := -vt/(g.p*vp);
    dpro.gamma := -d*vp;
    dpro.mu := -(v - g.T*vt)/cp;
  end gibbsToExtraDerivs;

  function helmholtzToExtraDerivs
    "Compute additional thermodynamic derivatives from dimensionless Helmholtz function"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
    output ExtraDerivatives dpro "Additional property derivatives";
  protected
    SI.Pressure p "Pressure";
    SI.SpecificVolume v "Specific volume";
    DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
    DerPressureBySpecificVolume pv
      "Derivative of pressure w.r.t. specific volume";
    SI.SpecificHeatCapacity cv "Isochoric specific heat capacity";
  algorithm
    v := 1/f.d;
    p := f.R_s*f.d*f.T*f.delta*f.fdelta;
    pv := -(f.d*f.d)*f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    cv := f.R_s*(-f.tau*f.tau*f.ftautau);
    dpro.kappa := 1/(f.d*p)*((-pv*cv + pt*pt*f.T)/(cv));
    dpro.theta := -1/(f.d*p)*((-pv*cv + f.T*pt*pt)/(cv + pt*v));
    dpro.alpha := -f.d*pt/pv;
    dpro.beta := pt/p;
    dpro.gamma := -f.d/pv;
    dpro.mu := (v*pv + f.T*pt)/(pt*pt*f.T - pv*cv);
  end helmholtzToExtraDerivs;

  function Helmholtz_ph
    "Function to calculate analytic derivatives for computing d and t given p and h"
    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
    output NewtonDerivatives_ph nderivs
      "Derivatives for Newton iteration to calculate d and t from p and h";
  protected
    SI.SpecificHeatCapacity cv "Isochoric heat capacity";
  algorithm
    cv := -f.R_s*(f.tau*f.tau*f.ftautau);
    nderivs.p := f.d*f.R_s*f.T*f.delta*f.fdelta;
    nderivs.h := f.R_s*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
    nderivs.pd := f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    nderivs.pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    nderivs.ht := cv + nderivs.pt/f.d;
    nderivs.hd := (nderivs.pd - f.T*nderivs.pt/f.d)/f.d;
  end Helmholtz_ph;

  function Helmholtz_pT
    "Function to calculate analytic derivatives for computing d and t given p and t"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
    output NewtonDerivatives_pT nderivs
      "Derivatives for Newton iteration to compute d and t from p and t";
  algorithm
    nderivs.p := f.d*f.R_s*f.T*f.delta*f.fdelta;
    nderivs.pd := f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
  end Helmholtz_pT;

  function Helmholtz_ps
    "Function to calculate analytic derivatives for computing d and t given p and s"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
    output NewtonDerivatives_ps nderivs
      "Derivatives for Newton iteration to compute d and t from p and s";
  protected
    SI.SpecificHeatCapacity cv "Isochoric heat capacity";
  algorithm
    cv := -f.R_s*(f.tau*f.tau*f.ftautau);
    nderivs.p := f.d*f.R_s*f.T*f.delta*f.fdelta;
    nderivs.s := f.R_s*(f.tau*f.ftau - f.f);
    nderivs.pd := f.R_s*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    nderivs.pt := f.R_s*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    nderivs.st := cv/f.T;
    nderivs.sd := -nderivs.pt/(f.d*f.d);
  end Helmholtz_ps;

  function smoothStep
    "Approximation of a general step, such that the characteristic is continuous and differentiable"
    extends Modelica.Icons.Function;
    input Real x "Abscissa value";
    input Real y1 "Ordinate value for x > 0";
    input Real y2 "Ordinate value for x < 0";
    input Real x_small(min=0) = 1e-5
      "Approximation of step for -x_small <= x <= x_small; x_small > 0 required";
    output Real y "Ordinate value to approximate y = if x > 0 then y1 else y2";
  algorithm
    y := smooth(1, if x > x_small then y1 else if x < -x_small then y2 else if
      abs(x_small) > 0 then (x/x_small)*((x/x_small)^2 - 3)*(y2 - y1)/4 + (y1
       + y2)/2 else (y1 + y2)/2);

    annotation (
      Inline=true,
      smoothOrder=1,
      Documentation(revisions="<html>
<ul>
<li><em>April 29, 2008</em>
    by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
    Designed and implemented.</li>
<li><em>August 12, 2008</em>
    by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br>
    Minor modification to cover the limit case <code>x_small -> 0</code> without division by zero.</li>
</ul>
</html>", info="<html>
<p>
This function is used to approximate the equation
</p>
<blockquote><pre>
y = <strong>if</strong> x &gt; 0 <strong>then</strong> y1 <strong>else</strong> y2;
</pre></blockquote>

<p>
by a smooth characteristic, so that the expression is continuous and differentiable:
</p>

<blockquote><pre>
y = <strong>smooth</strong>(1, <strong>if</strong> x &gt;  x_small <strong>then</strong> y1 <strong>else</strong>
              <strong>if</strong> x &lt; -x_small <strong>then</strong> y2 <strong>else</strong> f(y1, y2));
</pre></blockquote>

<p>
In the region -x_small &lt; x &lt; x_small a 2nd order polynomial is used
for a smooth transition from y1 to y2.
</p>

<p>
If <strong>mass fractions</strong> X[:] are approximated with this function then this can be performed
for all <strong>nX</strong> mass fractions, instead of applying it for nX-1 mass fractions and computing
the last one by the mass fraction constraint sum(X)=1. The reason is that the approximating function has the
property that sum(X) = 1, provided sum(X_a) = sum(X_b) = 1
(and y1=X_a[i], y2=X_b[i]).
This can be shown by evaluating the approximating function in the abs(x) &lt; x_small
region (otherwise X is either X_a or X_b):
</p>

<blockquote><pre>
X[1]  = smoothStep(x, X_a[1] , X_b[1] , x_small);
X[2]  = smoothStep(x, X_a[2] , X_b[2] , x_small);
   ...
X[nX] = smoothStep(x, X_a[nX], X_b[nX], x_small);
</pre></blockquote>

<p>
or
</p>

<blockquote><pre>
X[1]  = c*(X_a[1]  - X_b[1])  + (X_a[1]  + X_b[1])/2
X[2]  = c*(X_a[2]  - X_b[2])  + (X_a[2]  + X_b[2])/2;
   ...
X[nX] = c*(X_a[nX] - X_b[nX]) + (X_a[nX] + X_b[nX])/2;
c     = (x/x_small)*((x/x_small)^2 - 3)/4
</pre></blockquote>

<p>
Summing all mass fractions together results in
</p>

<blockquote><pre>
sum(X) = c*(sum(X_a) - sum(X_b)) + (sum(X_a) + sum(X_b))/2
       = c*(1 - 1) + (1 + 1)/2
       = 1
</pre></blockquote>
</html>"));
  end smoothStep;

  function Gibbs2_ph
    "Function to calculate analytic derivatives for computing T given p and h"
    extends Modelica.Icons.Function;
    input Modelica.Media.Common.GibbsDerivs2 g
      "Dimensionless derivatives of Gibbs function";
    output Modelica.Media.Common.NewtonDerivatives_ph nderivs
      "Derivatives for Newton iteration to calculate d and t from p and h";

  algorithm
    nderivs.h := g.g - g.T*g.gT;
    nderivs.ht := -g.T*g.gTT;

    //dummy values - DO NOT USE
    nderivs.p := 0.0;
    nderivs.pd := 0.0;
    nderivs.pt := 0.0;
    nderivs.hd := 0.0;
  end Gibbs2_ph;

  function Gibbs2_dT
    "Function to calculate analytic derivatives for computing p given d and T"
    extends Modelica.Icons.Function;
    input Modelica.Media.Common.GibbsDerivs2 g
      "Dimensionless derivatives of Gibbs function";
    output Modelica.Media.Common.NewtonDerivatives_dT nderivs
      "Derivatives for Newton iteration to compute p from d and T";

  algorithm
    nderivs.v := g.gp;
    nderivs.vp := nderivs.v*g.gpp/g.gp;
  end Gibbs2_dT;

  function Gibbs2_ps
    "Function to calculate analytic derivatives for computing d and t given p and s"

    extends Modelica.Icons.Function;
    input Modelica.Media.Common.GibbsDerivs2 g
      "Dimensionless derivatives of Gibbs function";
    output Modelica.Media.Common.NewtonDerivatives_ps nderivs
      "Derivatives for Newton iteration to compute T from p and s";

  algorithm
    nderivs.s := -g.gT;
    nderivs.st := -g.gTT;

    //dummy values - DO NOT USE
    nderivs.p := 0.0;
    nderivs.pd := 0.0;
    nderivs.pt := 0.0;
    nderivs.sd := 0.0;
  end Gibbs2_ps;

  annotation (Documentation(info="<html><h4>Package description</h4>
      <p>Package Modelica.Media.Common provides records and functions shared by many of the property sub-packages.
      High accuracy fluid property models share a lot of common structure, even if the actual models are different.
      Common data structures and computations shared by these property models are collected in this library.
   </p>

</html>", revisions="<html>
      <ul>
      <li>First implemented: <em>July, 2000</em>
      by Hubertus Tummescheit
      for the ThermoFluid Library with help from Jonas Eborn and Falko Jens Wagner
      </li>
      <li>Code reorganization, enhanced documentation, additional functions: <em>December, 2002</em>
      by Hubertus Tummescheit and move to Modelica
                            properties library.</li>
      <li>Inclusion into Modelica.Media: September 2003</li>
      </ul>

      <address>Author: Hubertus Tummescheit,<br>
      Lund University<br>
      Department of Automatic Control<br>
      Box 118, 22100 Lund, Sweden<br>
      email: hubertus@control.lth.se
      </address>
</html>"));
end Common;
annotation (preferredView="info",Documentation(info="<html>
<p>
This library contains <a href=\"modelica://Modelica.Media.Interfaces\">interface</a>
definitions for media and the following <strong>property</strong> models for
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
     SimpleAir, DryAirNasa, ReferenceAir, MoistAir, ReferenceMoistAir.</li>
<li> <a href=\"modelica://Modelica.Media.Incompressible\">
     Incompressible media:</a><br>
     TableBased incompressible fluid models (properties are defined by tables rho(T),
     HeatCapacity_cp(T), etc.)</li>
<li> <a href=\"modelica://Modelica.Media.CompressibleLiquids\">
     Compressible liquids:</a><br>
     Simple liquid models with linear compressibility</li>
<li> <a href=\"modelica://Modelica.Media.R134a\">Refrigerant Tetrafluoroethane (R134a)</a>.</li>
</ul>
<p>
The following parts are useful, when newly starting with this library:</p>
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
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>", revisions="<html>
<ul>
<li><em>February 01, 2017</em> by Thomas Beutlich:<br>
    Fixed data errors of the NASA Glenn coefficients in some ideal gases (CH2, CH3, CH3OOH, C2CL2, C2CL4, C2CL6, C2HCL, C2HCL3, CH2CO_ketene, O_CH_2O, HO_CO_2OH, CH2BrminusCOOH, C2H3CL, CH2CLminusCOOH, HO2, HO2minus, OD, ODminus), see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1922\">#1922</a></li>
<li><em>May 16, 2013</em> by Stefan Wischhusen (XRG Simulation):<br>
    Added new media models Air.ReferenceMoistAir, Air.ReferenceAir, R134a.</li>
<li><em>May 25, 2011</em> by Francesco Casella:<br>Added min/max attributes to Water, TableBased, MixtureGasNasa, SimpleAir and MoistAir local types.</li>
<li><em>May 25, 2011</em> by Stefan Wischhusen:<br>Added individual settings for polynomial fittings of properties.</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Line(
          points = {{-76,-80},{-62,-30},{-32,40},{4,66},{48,66},{73,45},{62,-8},{48,-50},{38,-80}},
          color={64,64,64},
          smooth=Smooth.Bezier),
        Line(
          points={{-40,20},{68,20}},
          color={175,175,175}),
        Line(
          points={{-40,20},{-44,88},{-44,88}},
          color={175,175,175}),
        Line(
          points={{68,20},{86,-58}},
          color={175,175,175}),
        Line(
          points={{-60,-28},{56,-28}},
          color={175,175,175}),
        Line(
          points={{-60,-28},{-74,84},{-74,84}},
          color={175,175,175}),
        Line(
          points={{56,-28},{70,-80}},
          color={175,175,175}),
        Line(
          points={{-76,-80},{38,-80}},
          color={175,175,175}),
        Line(
          points={{-76,-80},{-94,-16},{-94,-16}},
          color={175,175,175})}));
end Media;
