package Media "Property models of media"
extends Modelica.Icons.Library;
import SI = Modelica.SIunits;


annotation (
  version="1.0",
  versionDate="2005-03-01",
  preferedView="info",
  Documentation(info="<HTML>
<p>
This library contains <a href=\"Modelica:Modelica.Media.Interfaces\">interface</a> 
definitions for media and the following <b>property</b> models for
single and multiple substance fluids with one and multiple phases:
</p>
<ul>
<li> <a href=\"Modelica:Modelica.Media.IdealGases\">Ideal gases:</a><br>
     1241 high precision gas models based on the
     NASA Glenn coefficients, plus ideal gas mixture models based 
     on the same data.</li>
<li> <a href=\"Modelica:Modelica.Media.Water\">Water models:</a><br>
     ConstantPropertyLiquidWater, WaterIF97 (high precision
     water model according to the IAPWS/IF97 standard)</li>
<li> <a href=\"Modelica:Modelica.Media.Air\">Air models:</a><br>
     SimpleAir, DryAirNasa, and MoistAir</li>
<li> <a href=\"Modelica:Modelica.Media.Incompressible\">
     Incompressible media:</a><br>
     TableBased (template medium for user defined properties from tables rho(T),
     HeatCapacity_cp(T), etc.)</li>
</ul>
<p>
The following parts are useful, when newly starting with this library:
<ul>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.</li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage\">Modelica.Media.UsersGuide.MediumUsage</a> 
     describes how to use a medium model in a component model.</li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition\">
     Modelica.Media.UsersGuide.MediumDefinition</a> 
     describes how a new fluid medium model has to be implemented.</li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.ReleaseNotes\">Modelica.Media.UsersGuide.ReleaseNotes</a>
     summarizes the changes of the library releases.</li>
<li> <a href=\"Modelica:Modelica.Media.Examples\">Modelica.Media.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>
<p>
Copyright &copy; 1998-2006, Modelica Association.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p><br>
</HTML>"),
  conversion(from(version="0.795", script=
          "../ConvertFromModelica.Media_0.795.mos")));


package UsersGuide "Users Guide" 
  
  annotation (DocumentationClass=true, Documentation(info="<HTML>
<h3><font color=\"#008000\" size=5>Users Guide of package Modelica.Media</font></h3>
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
     <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition.StaticStateSelection\">Static State Selection</a>.</li>
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
This Users Guide has the following main parts:
</p>
<ul>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage\">Medium usage</a> 
     describes how to use a medium model from
     this library in a component model.</li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition\">Medium definition</a> 
     describes how a new fluid medium
     model has to be implemented.</li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.ReleaseNotes\">ReleaseNotes</a>
     summarizes the changes of the library releases.</li>
<li><a href=\"Modelica://Modelica.Media.UsersGuide.Contact\">Contact</a> 
    provides information about the authors of the library as well as
    acknowledgements.</li>
</ul>
</HTML>"));
  
  package MediumUsage "Medium usage" 
    
    annotation (DocumentationClass=true, Documentation(info="<HTML>
<h3><font color=\"#008000\" size=5>Using a fluid medium model</font></h3>
<p>
Content:
</p>
<ol>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage.BasicUsage\">
      Basic usage of medium model</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage.BalanceVolume\">
      Medium model for a balance volume</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage.ShortPipe\">
      Medium model for a pressure loss</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">
     Optional medium properties</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage.Constants\">
     Constants provided by medium model</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">
     Two-phase media</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage.Initialization\">
     Initialization</a></li>
</ol>
 
<p>
A good demonstration how to use the media from Modelica.Media is
given in package Modelica.Media.Examples.Tests. Under 
<a href=\"Modelica:Modelica.Media.Examples.Tests.Components\">
Tests.Components</a> the most basic components of a Fluid library 
are defined. Under Tests.MediaTestModels these basic components are used to test
all media models with some very simple piping networks.
</p>
 
</HTML>"));
    
    class BasicUsage "Basic usage" 
      
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Basic usage of medium model</font></h3>
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
  <tr><td><b>Variable</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>T</td>
      <td>K</td>
      <td>temperature</td></tr>
  <tr><td>p</td>
      <td>Pa</td>
      <td>absolute pressure</td></tr>
  <tr><td>d</td>
      <td>kg/m^3</td>
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
                         \"Medium model\" <b>annotation</b> (choicesAllMatching = <b>true</b>);
    Medium.BaseProperties medium_a \"Medium properties at location a (e.g. port_a)\";
    // Use medium variables (medium_a.p, medium_a.T, medium_a.h, ...)
     ...
  <b>end</b> Pump;
</pre>
<p>
The second way is to use the setState_XXX functions to compute the thermodynamic state
record from which all other thermodynamic state variables can be computed (see 
<a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition.BasicDefinition\">
Basic definition of medium</a> for further details on ThermodynamicState). The setState_XXX functions
accept either X or Xi (see explanation below) and will decide internally which of these two compositions 
is provided by the user. The four fundamental setState_XXX functions are provided in PartialMedium
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Function</b></td>
      <td><b>Description</b></td>
      <td><b>Short-form for<br>single component medium</b></td></tr>
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
<pre>
  <b>model</b> Pump
    <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
                         \"Medium model\" <b>annotation</b> (choicesAllMatching = <b>true</b>);
    Medium.ThermodynamicState state_a \"Thermodynamic state record at location a (e.g. port_a)\";
    // Compute medium variables from thermodynamic state record (pressure(state_a), temperature(state_a), 
    // specificEnthalpy(state_a), ...)
    ...
  <b>end</b> Pump;
</pre>
<p>
All media models are directly or indirectly a subpackage of package
Modelica.Media.Interfaces.PartialMedium. Therefore,
a medium model in a component should inherit from this
partial package. Via the annotation \"choicesAllMatching = true\" it
is defined that the tool should display a selection box with
all loaded packages that inherit from PartialMedium. An example
is given in the next figure:
</p>
<IMG SRC=\"../Images/Media/UsersGuide/mediumMenu.png\" ALT=\"medium selection menu\">
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
                         \"Medium model\" <b>annotation</b> (choicesAllMatching = <b>true</b>);
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
                         \"Medium model\" <b>annotation</b> (choicesAllMatching = <b>true</b>);
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
     the cases when the composition will always be constant, e.g. with
     circuits having fixed composition sources.
</ul>
 
<p>
The full vector of mass fractions <b>X[nX]</b> is computed in
PartialMedium.BaseProperties based on Xi, reference_X, and the information whether Xi = nS or nS-1. For single-substance media, nX = 0, so there's also no X vector. For multiple-substance media, nX = nS, and X always contains the full vector of mass fractions. In order to reduce confusion for the user of a fluid component library, \"Xi\" has the annotation \"Hide=true\", meaning, that this variable is not shown in the plot window. Only X is shown in the plot window and this vector always contains all mass fractions.
</p>
</HTML>"));
    end BasicUsage;
    
    class BalanceVolume "Balance volume" 
      
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Medium model for a balance volume</font></h3>
<p>
Fluid libraries usually have balance volume components with one fluid connector
port that fulfill the mass and energy balance and on a different grid components that
fulfill the momentum balance. A balance volume component, called junction
volume below, should be primarily implemented in the following way
(see also the implementation in 
<a href=\"Modelica:Modelica.Media.Examples.Tests.Components.PortVolume\">
Modelica.Media.Examples.Tests.Components.PortVolume</a>):
</p>
<pre>
  <b>model</b> JunctionVolume
    <b>import</b> SI=Modelica.SIunits;
    <b>import</b> Modelica.Media.Examples.Tests.Components.FluidPort_a;
 
    <b>parameter</b> SI.Volume V = 1e-6 \"Fixed size of junction volume\";
    <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
                           \"Medium model\" <b>annotation</b> (choicesAllMatching = <b>true</b>);
 
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
      
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Medium model for a short pipe</font></h3>
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
<a href=\"Modelica:Modelica.Media.Examples.Tests.Components.ShortPipe\">
Modelica.Media.Examples.Tests.Components.ShortPipe</a>):
</p>
<pre>
  <b>model</b> ShortPipe
    <b>import</b> SI=Modelica.SIunits;
    <b>import</b> Modelica.Media.Examples.Tests.Components;
 
    // parameters defining the pressure drop equation
 
    <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
                           \"Medium model\" <b>annotation</b> (choicesAllMatching = <b>true</b>);
 
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
<a href=\"Modelica:ModelicaReference.Operators.SemiLinear\">
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
      
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Optional medium properties</font></h3>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the functions listed in the following table. They are
defined as partial functions within package 
<a href=\"Modelica:Modelica.Media.Interfaces.PartialMedium\">PartialMedium</a>,
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
  <tr><td><b>Function call</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>Medium.dynamicViscosity(state)</b></td>
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
  <tr><td>Medium.specificEnthalpy_pTX(p,T,X)</td>
      <td>J/kg</td>
      <td>Specific enthalpy at p, T, X </td></tr>
  <tr><td>Medium.temperature_phX(p,h,X)</td>
      <td>K</td>
      <td>Temperature at p, h, X</td></tr>
  <tr><td>Medium.density_phX(p,h,X)</td>
      <td>kg/m³</td>
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
      
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Constants provided by medium model</font></h3>
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
  <tr><td><b>Type</b></td>
      <td><b>Name</b></td>
      <td><b>Description</b></td></tr>
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
      <td>= <b>true</b>, if u and d are not a function of pressure, and thus only
          a function of a single thermal variable (temperature or enthalpy) and
          of Xi for a multiple substance medium. Usually, this flag is
          <b>true</b> for incompressible media. It is used in a model to determine
          whether 1+nXi (singleState=<b>true</b>) or 2+nXi (singleState=<b>false</b>)
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
      <td>Size of the full mass fraction vector X. If there is a single 
          substance, then nX = 0, else nX=nS.</td></tr>
  <tr><td>Integer</td><td>nXi</td>
      <td>Number of independent mass fractions. If there is a single substance,
          then nXi = 0. </td></tr>
  <tr><td>Boolean</td><td>reducedX</td>
      <td>= <b>true</b>, if the medium has a single substance, or if the medium model 
          has multiple substances and contains the equation sum(X) = 1. 
          In both cases, nXi = nS - 1 (unless fixedX = true).<br>
          = <b>false</b>, if the medium has multiple substances and does not contain the
          equation sum(X)=1, i.e., nXi = nX = nS (unless fixedX = true).
       </td></tr>
  <tr><td>Boolean</td><td>fixedX</td>
      <td>= <b>false</b>: the composition of the medium can vary, and is
          determined by nXi independent mass fractions (see reducedX above).<br>
          = <b>true</b>: the composition of the medium is always reference_X,
          and nXi = 0.</td></tr>
  <tr><td>FluidConstants</td><td>fluidConstants[nS]</td>
      <td>Critical, triple, molecular and other
          standard data that are provided for
          every substance of a medium.</td></tr>
</table>
 
<p>
The record FluidConstants that is defined in PartialMedium contains the following elements
</p>
 
 
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Type</b></td>
      <td><b>Name</b></td>
      <td><b>Description</b></td></tr>
 
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
elements </p>

<table border=1 cellspacing=0 cellpadding=2>
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
      <td>true if vapour pressure data, e.g. Antoine coefficents are known</td></tr>
 
  <tr><td>Boolean</td>
      <td>hasAcentricFactor</td>
      <td>true if Pitzer accentric factor is known</td></tr>
 
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
 
</HTML>
"));
    end Constants;
    
    class TwoPhase "Two-phase media" 
      
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Two-phase Media</font></h3>
<p>
Models for media which can exist in one-phase or two-phase conditions inherit
from <a href=\"Modelica:Modelica.Media.Interfaces.PartialTwoPhaseMedium\">
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
  <tr><td><b>Type</b></td>
      <td><b>Name</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>Boolean</td>
      <td>smoothModel</b></td>
      <td>If this flag is false (default value), then events are triggered
          whenever the saturation boundary is crossed; otherwise, no events
      are generated.</td></tr>
  <tr><td>Boolean</td>
      <td>onePhase</b></td>
      <td>If this flag is true, then the medium model assumes it will be never
          called in the two-phase region. This can be useful to speed up
      the computations in a two-phase medium, when the user is sure it will
      always work in the one-phase region. Default value: false.</td></tr>
</table>
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
   sat_p.psat = p;
   sat_p.Tsat = Medium.saturationTemperature(p);
 
   // Compute saturation properties at pressure p
   bubble_density_p = Medium.bubbleDensity(sat_p);
   dew_enthalpy_p   = Medium.dewEnthalpy(sat_p);
 
   // Set sat_T to saturation properties at temperature T
   sat_T.Tsat = T;
   sat_T.psat = Medium.saturationPressure(T);
 
   // Compute saturation properties at temperature T
   bubble_density_T = Medium.bubbleDensity(sat_T);
   dew_enthalpy_T   = Medium.dewEnthalpy(sat_T);
</pre>
</p>
<p>With reference to a model defining a pressure p, a temperature T, and a 
SaturationProperties record sat, the following functions are provided:
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Function call</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>Medium.saturationPressure(T)</b></td>
      <td>Pa</td>
      <td>Saturation pressure at temperature T</td></tr>
  <tr><td>Medium.saturationTemperature(p)</b></td>
      <td>K</td>
      <td>Saturation temperature at pressure p</td></tr>
  <tr><td>Medium.saturationTemperature_derp(p)</b></td>
      <td>K/Pa</td>
      <td>Derivative of saturation temperature with respect to pressure</td></tr>
  <tr><td>Medium.bubbleEnthalpy(sat)</b></td>
      <td>J/kg</td>
      <td>Specific enthalpy at bubble point</td></tr>
  <tr><td>Medium.dewEnthalpy(sat)</b></td>
      <td>J/kg</td>
      <td>Specific enthalpy at dew point</td></tr>
  <tr><td>Medium.bubbleEntropy(sat)</b></td>
      <td>J/(kg.K)</td>
      <td>Specific entropy at bubble point</td></tr>
  <tr><td>Medium.dewEntropy(sat)</b></td>
      <td>J/(kg.K)</td>
      <td>Specific entropy at dew point</td></tr>
  <tr><td>Medium.bubbleDensity(sat)</b></td>
      <td>kg/m3</td>
      <td>Density at bubble point</td></tr>
  <tr><td>Medium.dewDensity(sat)</b></td>
      <td>kg/m3</td>
      <td>Density at dew point</td></tr>
  <tr><td>Medium.dBubbleDensity_dPressure(sat)</b></td>
      <td>kg/(m3.Pa)</td>
      <td>Derivative of density at bubble point with respect to pressure</td></tr>
  <tr><td>Medium.dDewDensity_dPressure(sat)</b></td>
      <td>kg/(m3.Pa)</td>
      <td>Derivative of density at dew point with respect to pressure</td></tr>
  <tr><td>Medium.dBubbleEnthalpy_dPressure(sat)</b></td>
      <td>J/(kg.Pa)</td>
      <td>Derivative of specific enthalpy at bubble point with respect to pressure</td></tr>
  <tr><td>Medium.dDewEnthalpy_dPressure(sat)</b></td>
      <td>J/(kg.Pa)</td>
      <td>Derivative of specific enthalpy at dew point with respect to pressure</td></tr>
  <tr><td>Medium.surfaceTension(sat)</b></td>
      <td>N/m</td>
      <td>Surface tension between liquid and vapour phase</td></tr>
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
  <tr><td><b>Function call</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>Medium.setBubbleState(sat, phase)</b></td>
      <td>Obtain the thermodynamic state vector 
          corresponding to the bubble point. If phase==1 (default), the state is
      on the one-phase side; if phase==2, the state is on the two-phase 
      side </td></tr>
  <tr><td>Medium.setDewState(sat, phase)</b></td>
      <td>Obtain the thermodynamic state vector 
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
   sat.psat = p;
   sat.Tsat = Medium.saturationTemperature(p);
 
   // Compute dew point properties, one-phase side
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
      
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Initialization of Medium</font></h3>
 
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
    
  end MediumUsage;
  
  package MediumDefinition "Medium definition" 
    
    annotation (DocumentationClass=true, Documentation(info="<HTML>
<h3><font color=\"#008000\" size=5>Defining a fluid medium model</font></h3>
<p>
If a new medium model shall be introduced, copy package
<a href=\"Modelica:Modelica.Media.Interfaces.TemplateMedium\">
Modelica.Media.Interfaces.TemplateMedium</a> to the desired
location, remove the
\"partial\" keyword from the package and provide
the information that is requested in the comments of the
Modelica source.
A more detailed description for the different parts of the
TemplateMedium package is given here:
</p>
<ol>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition.BasicStructure\">
      Basic structure of medium interface</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition.BasicDefinition\">
      Basic definition of medium model</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition.MultipleSubstances\">
      Multiple Substances</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition.SpecificEnthalpyAsFunction\">
      Specific enthalpy as function</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition.StaticStateSelection\">
      Static State Selection</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition.TestOfMedium\">
      Test of medium model</a></li>
</ol>
</HTML>"));
    
    class BasicStructure "Basic structure" 
      
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Basic structure of medium interface</font></h3>
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
  <b>final constant</b> Integer    nX  = <b>if</b> nS==1 <b>then</b> 0 <b>else</b> nS; 
  <b>final constant</b> Integer    nXi = <b>if</b> fixedX <b>then</b> 0 
                                  <b>else if</b> reducedX <b>then</b> nS-1 <b>else</b> nS; 
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
      
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Basic definition of a medium model</font></h3>
<p>
Let's now walk through the definition of a new medium model. Please refer to 
<a href=\"Modelica:Modelica.Media.Interfaces.TemplateMedium\">
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
by the declarations of the base package Interfaces.PartialMedium. </p>
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
should be redclared as follows: </p>
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
      
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Models of multiple-substance media</font></h3>
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
<li> <i>Fixed-composition models</i>: fixedX = <b>true</b> and nXi = 0. In this case X = reference_X, i.e. all the elements of the composition vector are fixed.
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
in the Modelica_Fluid library: </p>
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
<a href=\"Modelica:Modelica.Media.IdealGases.Common.MixtureGasNasa\">
      MixtureGasNasa model</a> and
<a href=\"Modelica:Modelica.Media.Air.MoistAir\">
      MoistAir model</a>.
</p>
</HTML>
"));
    end MultipleSubstances;
    
    model SpecificEnthalpyAsFunction "Specific enthalpy as function" 
      
      annotation (Documentation(info="<html>
<h3><font color=\"#008000\">Specific enthalpy as function</font></h3>
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
 
<IMG SRC=\"../Images/Media/UsersGuide/BalanceEquations1.png\">
 
<p>
Note, F<sub>F</sub> is the fanning friction factor.
The energy balance can be given in different forms.
Usually, it is given as:
</p>
 
<IMG SRC=\"../Images/Media/UsersGuide/EnergyBalance1.png\">
 
<p>
This form describes the change of the internal energy, kinetic
energy and potential energy of a volume as function of the
in and out flowing fluid. Multiplying the momentum balance
with the flow velocity v and subtracting it from the energy
balance above, results in the following alternative form
of the energy balance:
</p>
 
<IMG SRC=\"../Images/Media/UsersGuide/EnergyBalance2.png\">
 
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
    equation 
      
    end SpecificEnthalpyAsFunction;
    
    model StaticStateSelection "Static State Selection" 
      
      annotation (Documentation(info="<html>
<h3><font color=\"#008000\">Static State Selection</font></h3>
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
p, T are preferred states (i.e. StateSelect.prefer is set)
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
    equation 
      
    end StaticStateSelection;
    
    model TestOfMedium "Test of medium" 
      
      annotation (Documentation(info="<html>
<h3><font color=\"#008000\">Test of medium</font></h3>
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
    equation 
      
    end TestOfMedium;
  end MediumDefinition;
  
  model ReleaseNotes "Release notes" 
    
    annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\" size=5>Release notes</font></h3>
<h4><font color=\"#008000\">Version 1.0, 2005-03-01</font></h4>
<p>
Many improvements in the library, e.g., providing mixtures
of the ideal gases, table based media, test suite for all media, improved and
updated users guide.
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
  equation 
    
  end ReleaseNotes;
  
class Contact "Contact" 
    
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
     implemented part of the generic models, contributed to the users guide
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
     water and ideal gas properties. He also contributed to the users guide.</li>      
<li> John Batteh, Daniel Bouskela, Jonas Eborn, Andreas Idebrant, Charles Newman, 
     Gerhart Schmitz, and the users of the ThermoFluid library provided
     many useful comments and feedback.</li>
</ul>
</html>"));
end Contact;
  
end UsersGuide;


package Examples 
  "Demonstrate usage of property models (currently: simple tests)" 
  
  extends Modelica.Icons.Library;
  
  model SimpleLiquidWater "Example for Water.SimpleLiquidWater medium model" 
    
    annotation (experiment(StopTime=100), Documentation(info="<html>
 
</html>"));
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Example;
    parameter SI.Volume V=1 "Volume";
    parameter SI.EnthalpyFlowRate H_flow_ext=1.e6 
      "Constant enthalpy flow rate into the volume";
    
    package Medium = Water.ConstantPropertyLiquidWater (SpecificEnthalpy(max=1e6));
    Medium.BaseProperties medium(
      T(start=300,fixed=true));
    
    SI.Mass m(start = 1.0);
    SI.InternalEnergy U;
    
    // Use type declarations from the Medium
    Medium.MassFlowRate m_flow_ext;
    Medium.DynamicViscosity eta=Medium.dynamicViscosity(medium);
    Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium);
  equation 
    medium.p = 1.e5;
    
    m = medium.d*V;
    U = m*medium.u;
    
    // Mass balance
    der(m) = m_flow_ext;
    
    // Energy balance
    der(U) = H_flow_ext;
  end SimpleLiquidWater;
  
  model IdealGasH2O "IdealGas H20 medium model" 
    extends Modelica.Icons.Example;
    package Medium = IdealGases.SingleGases.H2O;
    Medium.ThermodynamicState state;
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
  equation 
    state.p = 100000.0;
    state.T = 200 + 1000*time;
    state2.p = 2.0e5;
    state2.T = 500.0;
    //  s2 = s;
    annotation (Documentation(info="<html>
<p>An example for using ideal gas properties and how to compute 
  isentropic enthalpy changes.
  The function that is implemented is approximate, but usually 
   very good: the second medium record medium2
   is given to compare the approximation.
</p>
</html>"));
  end IdealGasH2O;
  
  model WaterIF97 "WaterIF97 medium model" 
    extends Modelica.Icons.Example;
    package Medium = Water.StandardWater;
    Medium.BaseProperties medium(
      p(start=1.e5, stateSelect=StateSelect.prefer),
      h(start=1.0e5, stateSelect=StateSelect.prefer),
      T(start = 275.0),
      d(start = 999.0));
    Real V(start = 0.1);
    parameter Real dV = 0.0;
    parameter Medium.MassFlowRate m_flow_ext=0;
    parameter Real H_flow_ext=10000;
    Real m;
    Real U;
  equation 
    der(V) = dV;
    m = medium.d*V;
    U = m*medium.u;
    
    // Mass balance
    der(m) = m_flow_ext;
    
    // Energy balance
    der(U) = H_flow_ext;
    annotation (Documentation(info="<html>
  
</html>"));
  end WaterIF97;
  
  model MixtureGases "Test gas mixtures" 
    extends Modelica.Icons.Example;
    
    parameter Real V=1;
    parameter Real m_flow_ext=0.01;
    parameter Real H_flow_ext=5000;
    
    package Medium1 = Modelica.Media.IdealGases.MixtureGases.CombustionAir;
    Medium1.BaseProperties medium1(p(start=1.e5, stateSelect=StateSelect.prefer),
       T(start=300, stateSelect=StateSelect.prefer),
       X(start={0.8,0.2}));
    Real m1(quantity=Medium1.mediumName, start = 1.0);
    SI.InternalEnergy U1;
    Medium1.SpecificHeatCapacity cp1=Medium1.specificHeatCapacityCp(medium1.state);
    Medium1.DynamicViscosity eta1= Medium1.dynamicViscosity(medium1.state);
    Medium1.ThermalConductivity lambda1= Medium1.thermalConductivity(medium1.state);
    
    package Medium2 = Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas;
    Medium2.BaseProperties medium2(p(start=1.e5, stateSelect=StateSelect.prefer),
       T(start=300, stateSelect=StateSelect.prefer),
       X(start={0.1,0.1,0.1,0.2,0.2,0.3}));
    Real m2(quantity=Medium2.mediumName, start = 1.0);
    SI.InternalEnergy U2;
    Medium2.SpecificHeatCapacity cp2=Medium2.specificHeatCapacityCp(medium2.state);
    Medium2.DynamicViscosity eta2= Medium2.dynamicViscosity(medium2.state);
    Medium2.ThermalConductivity lambda2= Medium2.thermalConductivity(medium2.state);
    
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
    annotation (Documentation(info="<html>
  
</html>"));
  end MixtureGases;
  
model MoistAir "Ideal gas flue gas  model" 
    extends Modelica.Icons.Example;
    package Medium = Air.MoistAir;
    Medium.BaseProperties medium(
       T(start = 274.0),
       X(start = {0.95,0.05}),
       p(start = 1.0e5));
  //  Medium.SpecificEntropy s=Medium.specificEntropy(medium);
  //  Medium.SpecificEnthalpy h_is = Medium.isentropicEnthalpyApproximation(medium, 2.0e5);
    parameter Real[2] MMx = {Medium.dryair.MM,Medium.steam.MM};
    Real MM = 1/((1-medium.X[1])/MMx[1]+medium.X[1]/MMx[2]) 
      "molar mass of gas part of mixture";
  //  Real[4] dddX=Medium.density_derX(medium,MM);
    annotation (Documentation(info="<html>
<body>
<p>An example for using ideal gas properties and how to compute isentropic enthalpy changes.
The function that is implemented is approximate, but usually very good: the second medium record medium2
is given to compare the approximation.
</p>
</body>
</html>"),
      experiment(Tolerance=1e-005),
      experimentSetupOutput);
equation 
    der(medium.p) = 0.0;
    der(medium.T) = 90;
    medium.X[Medium.Air] = 0.95;
    //    medium.X[Medium.Water] = 0.05;
    // one simple assumption only for quick testing:
  //  medium.X_liquidWater = if medium.X_sat < medium.X[2] then medium.X[2] - medium.X_sat else 0.0;
end MoistAir;
  
  package TwoPhaseWater "extension of the StandardWater package" 
    extends Modelica.Media.Water.StandardWater;
    
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
    
    annotation (Documentation(info="<html>
<body>
<h3>Example: TwoPhaseWater</h3>
The TwoPhaseWater package demonstrates how to extend the parsimonius
BaseProperties with a minimal set of properties from the standard water
package with most properties that are needed in two-phase situations.
The model also demonstrates how to compute additional&nbsp; properties
for the medium model. In this scenario, that builds a new medium model
with many more properties than the default, the standard BaseProperties
is used as a basis. For additional properties, a user has to:<br>
<ol>
<li>Declare a new variable of the wanted type, e.g. <span
style=\"color: rgb(0, 0, 153);\">\"<span style=\"color: rgb(51, 51, 255);\">DynamicViscosity
eta</span>\"</span>.</li>
<li>Compute that variable by calling the function form the package,
e.g. <span style=\"color: rgb(51, 51, 255);\">eta =
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
users responsibility&nbsp; to take care of such ituations. The example
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
<li>Declare an instance of ThermodynamicState, e.g. \"ThermodynamicState&nbsp; dew\".</li>
<li>Compute the state, using an instance of SaturationProperties,
e.g. dew = setDewState(sat)</li>
<li>Compute properties on the phase boundary to your full desire,
e.g. \"cp_d = specificHeatCapacityCp(dew)\". <br>
</li>
</ol>
<p>The sample model TestTwoPhaseStates test the extended properties</p>
The same procedure can be used to compute properties at other state
points, e.g. when an isentropic reference state is computed.<br>
<br>
</body>
</html>
"));
    model TestTwoPhaseStates "test the above model" 
      ExtendedProperties medium(p(start = 700.0),
       h(start = 8.0e5));
      parameter Real dh = 80000.0 "80 kJ/second";
      parameter Real dp = 1.0e6 "10 bars per second";
    equation 
      der(medium.p) = dp;
      der(medium.h) = dh;
      annotation (experiment(StopTime=22, NumberOfIntervals=2500),
          experimentSetupOutput,
        Documentation(info="<html>
<body>
<h3>Example:TestTwoPhaseStates</h3>
</p> For details see the documentation of the example package TwoPhaseWater<p>
</body>
</html>
"));
    end TestTwoPhaseStates;
  end TwoPhaseWater;
  
  package TestOnly "examples for testing purposes: move for final version " 
    extends Modelica.Icons.Library;
    model MixIdealGasAir "Ideal gas air medium model" 
      extends Modelica.Icons.Example;
      package Medium = IdealGases.MixtureGases.CombustionAir;
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
      annotation (Documentation(info="<html>
<body>
<p>An example for using ideal gas properties and how to compute isentropic enthalpy changes.
The function that is implemented is approximate, but usually very good: the second medium record medium2
is given to compare the approximation.
</p>
</body>
</html>"));
    equation 
      der(medium.p) = 1000.0;
      der(medium.T) = 1000;
      medium.X = {0.2,0.8};
      der(medium2.p) = 1.0e3;
      der(medium2.T) = 0.0;
      der(medium2.X) = {0.0,0.0};
    //  s2 = s;
    end MixIdealGasAir;
    
    model FlueGas "Ideal gas flue gas  model" 
      extends Modelica.Icons.Example;
      package Medium = IdealGases.MixtureGases.FlueGasLambdaOnePlus;
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
      parameter Real[4] MMx = Medium.data.MM;
      Real MM =  1/sum(state.X[j]/MMx[j] for j in 1:4) "molar mass";
      Real[4] dddX=Medium.density_derX(medium2.state);
      annotation (Documentation(info="<html>
<body>
<p>An example for using ideal gas properties and how to compute isentropic enthalpy changes.
The function that is implemented is approximate, but usually very good: the second medium record medium2
is given to compare the approximation.
</p>
</body>
</html>"));
    equation 
      der(state.p) = 1000.0;
      der(state.T) = 1000;
      state.X = {0.2,0.2,0.4,0.2};
      der(medium2.p) = 1.0e3;
      der(medium2.T) = 0.0;
      der(medium2.X[1:Medium.nX]) = {0.0,0.0,0.0,0.0};
    end FlueGas;
    
    package TestMedia 
      extends Modelica.Icons.Library;
      model TemplateMedium "Test Interfaces.TemplateMedium" 
        extends Modelica.Icons.Example;
        package Medium = Interfaces.TemplateMedium;
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
    
    model IdealGasAir "Test IdealGas.SingleMedia.Air medium model" 
      extends Modelica.Icons.Example;
      
      parameter Real V=1;
      parameter Real m_flow_ext=0.01;
      parameter Real H_flow_ext=5000;
      
      package Medium = IdealGases.SingleGases.Air;
      // initType=Medium.Choices.Init.SteadyState,
      
      Medium.BaseProperties medium(
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
  
</html>"));
    end IdealGasAir;
    annotation (Documentation(info="<html>
 
</html>"));
  end TestOnly;
  annotation (Documentation(info="<html>
<h3>Examples</h3>
Physical properties for fluids are needed in so many different variants
that a library can only provide models for the most common situations.
With the following examples we are going to demonstrate how to use the
existing packages and functions in Modelica.Media to customize these
models for advanced applications. The high level functions try to
abstract as much as possible form the fact that different media are
based on different variables, e.g. ideal gases need pressure and
temperature, while many refrigerants are based on Helmholtz functions
of density and temperature, and many water proeprties are based on
pressure and specific enthalpy. Medium properties are needed in control
volumes in the dynamic state equations and in many thermodynamic state
locations that are independent of the dynamic states of a control
volume, e.g. at a wall temperature, an isentropic reference state or at
a phase boundary. The general structure of the library is such that:<br>
<ul>
<li>Each medium has a model called BaseProperties. BaseProperties
contains the minimum set of medium properties needed in a dynamic
control volume model.</li>
<li>Each instance of BaseProperties contains a \"state\" record that is
an input to all the functions to compute properties. If these functions
need further inputs, like e.g. the molarMass, these are accessible as
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
  
  package Tests 
    "Library to test that all media models simulate and fulfill the expected structural properties" 
    
    extends Modelica.Icons.Library;
    
    package Components 
      "Functions, connectors and models needed for the media model tests" 
      
       extends Modelica.Icons.Library;
      
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
          "properties c_i/m in the connection point";
        flow Medium.ExtraPropertyFlowRate mC_flow[Medium.nC] 
          "Flow rates of auxiliary properties from the connection point into the component (if m_flow > 0, mC_flow = m_flow*C)";
        
        annotation (Documentation(info="<html>
    
</html>"));
      end FluidPort;
      
      connector FluidPort_a "Fluid connector with filled icon" 
        extends FluidPort;
        annotation (Diagram(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                   fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                   fillColor=69)), Text(extent=[-88, 206; 112, 112], string="%name")),
             Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                  fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                  fillColor=69))),
          Documentation(info="<html>Modelica.Media.Examples.Tests.Components.FluidPort_a
</html>"));
      end FluidPort_a;
      
      connector FluidPort_b "Fluid connector with outlined icon" 
        extends FluidPort;
        annotation (Diagram(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                   fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                   fillColor=69)), Ellipse(extent=[-80, 80; 80, -80], style(color=69,
                   fillColor=7)), Text(extent=[-88, 192; 112, 98], string="%name")),
             Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                  fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                  fillColor=69)), Ellipse(extent=[-80, 80; 80, -80], style(color=69,
                   fillColor=7))),
          Documentation(info="<html> 
  
</html>"));
      end FluidPort_b;
      
      model PortVolume 
        "Fixed volume associated with a port by the finite volume method" 
        import SI = Modelica.SIunits;
        
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model" 
           annotation (choicesAllMatching=true);
        
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
        
        FluidPort_a port(redeclare package Medium = Medium) annotation (extent=[-10, -10; 10, 10], rotation=0);
        Medium.BaseProperties medium(p=port.p, h=port.h, Xi=port.Xi,
                                     preferredMediumStates=true);
        SI.Energy U "Internal energy of port volume";
        SI.Mass m "Mass of junction volume";
        SI.Mass mXi[Medium.nXi] 
          "Independent substance masses of junction volume";
        
        annotation (
         Icon(
            Ellipse(extent=[-100, 100; 100, -100], style(
                color=0,
                rgbcolor={0,0,0},
                gradient=3,
                fillColor=68,
                rgbfillColor={170,213,255})),
            Text(extent=[-144, 178; 146, 116], string="%name"),
            Text(
              extent=[-130, -108; 144, -150],
              style(color=0),
              string="V=%V")), Documentation(info="<html>
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
</html>"),Diagram);
        
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
        // Total quantities
           m    = V*medium.d;
           mXi = m*medium.Xi;
           U    = m*medium.u;
        
        // Mass and energy balance
           der(m)    = port.m_flow;
           der(mXi) = port.mXi_flow;
           der(U)    = port.H_flow;
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
           annotation (choicesAllMatching=true);
        
        Medium.BaseProperties medium(p=port.p, Xi=X_ambient[1:Medium.nXi]) 
          "Medium in the source";
        FluidPort_b port(redeclare package Medium = Medium) 
          annotation (extent=[100, -10; 120, 10], rotation=0);
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Rectangle(extent=[20, 60; 100, -60], style(
                color=0,
                gradient=2,
                fillColor=8)),
            Rectangle(extent=[38, 40; 100, -40], style(
                color=69,
                gradient=2,
                fillColor=69)),
            Ellipse(extent=[-100, 80; 60, -80], style(fillColor=7)),
            Polygon(points=[-60, 70; 60, 0; -60, -68; -60, 70], style(color=73,
                  fillColor=73)),
            Text(
              extent=[-54, 32; 16, -30],
              style(color=41, fillColor=41),
              string="m"),
            Text(extent=[-142, 142; 156, 88], string="%name"),
            Text(
              extent=[-154,-88; 150,-132],
              style(color=0),
              string="%m_flow"),
            Ellipse(extent=[-26, 30; -18, 22], style(color=1, fillColor=1))),
          Window(
            x=0.45,
            y=0.01,
            width=0.44,
            height=0.65),
          Diagram,
          Documentation(info="<html>
    
</html>"));
      equation 
         if use_T_ambient then
           medium.T = T_ambient;
         else
           medium.h = h_ambient;
         end if;
        
         port.m_flow   = -m_flow;
         port.mXi_flow = semiLinear(port.m_flow, port.Xi, medium.Xi);
         port.H_flow   = semiLinear(port.m_flow, port.h, medium.h);
      end FixedMassFlowRate;
      
      model FixedAmbient 
        "Ambient pressure, temperature and mass fraction source" 
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model" 
           annotation (choicesAllMatching=true);
        
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
          annotation (extent=[100, -10; 120, 10], rotation=0);
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(Ellipse(extent=[-100, 80; 100, -80], style(
                color=69,
                gradient=3,
                fillColor=69)), Text(extent=[-136, 144; 132, 82], string="%name")),
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
      end FixedAmbient;
      
      model ShortPipe "Simple pressure loss in pipe" 
         replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model" 
           annotation (choicesAllMatching=true);
        
        parameter Medium.AbsolutePressure dp_nominal(min=1.e-10) 
          "Nominal pressure drop";
        parameter Medium.MassFlowRate m_flow_nominal(min=1.e-10) 
          "Nominal mass flow rate at nominal pressure drop";
        
        FluidPort_a port_a(redeclare package Medium = Medium) 
          annotation (extent=[-120, -10; -100, 10]);
        FluidPort_b port_b(redeclare package Medium = Medium) 
          annotation (extent=[120, -10; 100, 10]);
        // Medium.BaseProperties medium_a(p=port_a.p, h=port_a.h, Xi=port_a.Xi) 
        //   "Medium properties in port_a";
        // Medium.BaseProperties medium_b(p=port_b.p, h=port_b.h, Xi=port_b.Xi) 
        //   "Medium properties in port_b";
        Medium.MassFlowRate m_flow 
          "Mass flow rate from port_a to port_b (m_flow > 0 is design flow direction)";
        Modelica.SIunits.Pressure dp "Pressure drop from port_a to port_b";
                                                                                         annotation (Icon(
            Rectangle(extent=[-100,60; 100,-60],   style(
                color=0,
                gradient=2,
                fillColor=8)),
            Rectangle(extent=[-100,34; 100,-36],   style(
                color=69,
                gradient=2,
                fillColor=69)),
            Text(
              extent=[-150,140; 150,80],
              string="%name",
              style(gradient=2, fillColor=69)),
            Text(
              extent=[-136,-62; 122,-108],
              style(color=0, rgbcolor={0,0,0}),
              string="k=%m_flow_nominal/%dp_nominal")),
                                                 Documentation(info="<html>
<p>
Model <b>ShortPipe</b> defines a simple pipe model 
with pressure loss due to friction. It is assumed that
no mass or energy is stored in the pipe. 
The details of the pipe friction model are described
<a href=\"Modelica://Modelica_Fluid.Utilities.PipeFriction\">here</a>.
</p>
</html>"));
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
      end ShortPipe;
      
      partial model PartialTestModel "Basic test model to test a medium" 
        import SI = Modelica.SIunits;
        extends Modelica.Icons.Example;
        
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model" annotation (choicesAllMatching=true);
        parameter SI.AbsolutePressure p_start = Medium.p_default 
          "Initial value of pressure";
        parameter SI.Temperature T_start = Medium.T_default 
          "Initial value of temperature";
        parameter SI.Density h_start = Medium.h_default 
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
                 annotation (extent=[-40,0; -20,20]);
        FixedMassFlowRate fixedMassFlowRate(redeclare package Medium = Medium,
          T_ambient=1.2*T_start,
          h_ambient=1.2*h_start,
          m_flow=1,
          X_ambient=0.5*X_start) 
                                annotation (extent=[-80,0; -60,20]);
        annotation (Diagram, Documentation(info="<html>
  
</html>"));
        FixedAmbient ambient(
          redeclare package Medium = Medium,
          T_ambient=T_start,
          h_ambient=h_start,
          X_ambient=X_start,
          p_ambient=p_start) annotation (extent=[60,0; 40,20]);
        ShortPipe shortPipe(redeclare package Medium = Medium,
          m_flow_nominal=1,
          dp_nominal=0.1e5) 
          annotation (extent=[0,0; 20,20]);
      equation 
        connect(fixedMassFlowRate.port, volume.port) annotation (points=[-59,10; -30,
              10],     style(color=69, rgbcolor={0,127,255}));
        connect(volume.port, shortPipe.port_a) 
          annotation (points=[-30,10; -1,10], style(color=69, rgbcolor={0,127,255}));
        connect(shortPipe.port_b, ambient.port) 
          annotation (points=[21,10; 39,10], style(color=69, rgbcolor={0,127,255}));
      end PartialTestModel;
      
      partial model PartialTestModel2 
        "slightly larger test model to test a medium" 
        import SI = Modelica.SIunits;
        extends Modelica.Icons.Example;
        
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model" annotation (choicesAllMatching=true);
        parameter SI.AbsolutePressure p_start = 1.0e5 
          "Initial value of pressure";
        parameter SI.Temperature T_start = 300 "Initial value of temperature";
        parameter SI.Density h_start = 1 "Initial value of specific enthalpy";
        parameter Real X_start[Medium.nX] = Medium.reference_X 
          "Initial value of mass fractions";
        PortVolume volume(redeclare package Medium = Medium,
                          p_start=p_start,
                          T_start=T_start,
                          h_start=h_start,
                          X_start = X_start,
                          V=0.1) 
                 annotation (extent=[-60,0; -40,20]);
        FixedMassFlowRate fixedMassFlowRate(redeclare package Medium = Medium,
          T_ambient=1.2*T_start,
          h_ambient=1.2*h_start,
          m_flow=1,
          X_ambient=0.5*X_start) 
                                annotation (extent=[-100,0; -80,20]);
        annotation (Diagram, Documentation(info="<html>
  
</html>"));
        FixedAmbient ambient(
          redeclare package Medium = Medium,
          T_ambient=T_start,
          h_ambient=h_start,
          X_ambient=X_start,
          p_ambient=p_start) annotation (extent=[92,0; 72,20]);
        ShortPipe shortPipe(redeclare package Medium = Medium,
          m_flow_nominal=1,
          dp_nominal=0.1e5) 
          annotation (extent=[-30,0; -10,20]);
        PortVolume volume1(
                          redeclare package Medium = Medium,
                          p_start=p_start,
                          T_start=T_start,
                          h_start=h_start,
                          X_start = X_start,
                          V=0.1) 
                 annotation (extent=[0,0; 20,20]);
        ShortPipe shortPipe1(
                            redeclare package Medium = Medium,
          m_flow_nominal=1,
          dp_nominal=0.1e5) 
          annotation (extent=[36,0; 56,20]);
      equation 
        connect(fixedMassFlowRate.port, volume.port) annotation (points=[-79,10; -50,
              10],     style(color=69, rgbcolor={0,127,255}));
        connect(volume.port, shortPipe.port_a) 
          annotation (points=[-50,10; -31,10],style(color=69, rgbcolor={0,127,255}));
        connect(volume1.port, shortPipe1.port_a) 
          annotation (points=[10,10; 35,10],  style(color=69, rgbcolor={0,127,255}));
        connect(shortPipe.port_b, volume1.port) 
          annotation (points=[-9,10; 10,10], style(color=69, rgbcolor={0,127,255}));
        connect(shortPipe1.port_b, ambient.port) 
          annotation (points=[57,10; 71,10], style(color=69, rgbcolor={0,127,255}));
      end PartialTestModel2;
      annotation (Documentation(info="<html>
  
</html>"));
    end Components;
    
    package MediaTestModels "Test models to test all media" 
      extends Modelica.Icons.Library;
      package Air "Test models of library Modelica.Media.Air" 
        extends Modelica.Icons.Library;
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
        extends Modelica.Icons.Library;
        
        model Air "Test single gas Modelica.Media.IdealGases.SingleGases.Air" 
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = 
                Modelica.Media.IdealGases.SingleGases.Air);
          annotation (Documentation(info="<html>
  
</html>"));
        end Air;
        
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
        end SimpleNaturalGasFixedComposition;
      end IdealGases;
      
      package Incompressible 
        "Test models of library Modelica.Media.Incompressible" 
        extends Modelica.Icons.Library;
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
        extends Modelica.Icons.Library;
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
      
      annotation (Documentation(info="<html>
  
</html>"));
    end MediaTestModels;
    annotation (Documentation(info="<html>
  
</html>"));
  end Tests;
  
  package SolveOneNonlinearEquation 
    "Demonstrate how to solve one non-linear algebraic equation in one unknown" 
    
    annotation (uses(Modelica(version="2.2")), Documentation(info="<html>
<p>
This package demonstrates how to solve one non-linear algebraic
equation in one unknown with function 
Modelica.Media.Common.OneNonLinearEquation.
</p>
 
</html>"));
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
        
      redeclare record extends f_nonlinear_Data 
         Real A;
         Real w;
          annotation (Documentation(info="<html>
  
</html>"));
      end f_nonlinear_Data;
        
      redeclare function extends f_nonlinear 
      algorithm 
          y := f_nonlinear_data.A*Modelica.Math.sin(f_nonlinear_data.w*x);
      end f_nonlinear;
        
      // Dummy definition has to be added for current Dymola (advice from Hans)
      redeclare function extends solve 
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
        experimentSetupOutput,
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
            extends Modelica.Media.IdealGases.Common.SingleGasNasa 
        "Medium model"     annotation (choicesAllMatching=true);
      
     parameter SI.Temperature T_min = 300;
     parameter SI.Temperature T_max = 500;
     parameter SI.Pressure p = 1.0e5;
     parameter SI.SpecificEnthalpy h_min = Medium.h_T(Medium.data,T_min);
     parameter SI.SpecificEnthalpy h_max = Medium.h_T(Medium.data,T_max);
     parameter SI.SpecificEntropy s_min = Medium.specificEntropy(Medium.setState_pT(p,T_min));
     parameter SI.SpecificEntropy s_max = Medium.specificEntropy(Medium.setState_pT(p,T_max));
     SI.SpecificEnthalpy h1 "Pre-defined specific enthalpy";
     SI.SpecificEnthalpy h2 "Specific enthalpy computed from T (= h1 required)";
     SI.SpecificEntropy s1 "Pre-defined specific entropy";
     SI.SpecificEntropy s2 "Specific entropy computed from T (= h1 required)";
     SI.Temperature Th "Temperature computed from h1";
     SI.Temperature Ts "Temperature computed from s1";
     annotation (experiment,
                 experimentSetupOutput,
                 Documentation(info="<html>
                               </html>"));
      
   equation 
      // Define specific enthalpy
      h1 = if time < 0 then h_min else 
           if time > 1 then h_max else 
              h_min + time*(h_max - h_min);
      s1 = if time < 0 then s_min else 
           if time > 1 then s_max else 
              s_min + time*(s_max - s_min);
      
      // Solve for temperature
      Th = Medium.temperature_phX(p, h1, fill(0.0,0));
      Ts = Medium.temperature_psX(p, s1, fill(0.0,0));
      
      // Check (h2 must be identical to h1)
      h2 = Medium.specificEnthalpy_pTX(p, Th, fill(0.0,0));
      s2 = Medium.specificEntropy(Medium.setState_pT(p,Ts));
   end Inverse_sh_T;
    
   model InverseIncompressible_sh_T 
      "inverse computation for incmpressible media" 
     import SI = Modelica.SIunits;
     import Cv = Modelica.SIunits.Conversions;
     extends Modelica.Icons.Example;
      
     replaceable package Medium = 
          Modelica.Media.Incompressible.Examples.Glycol47 "Medium model" 
                        annotation (choicesAllMatching=true);
      
     parameter SI.Temperature T_min = Medium.T_min;
     parameter SI.Temperature T_max = Medium.T_max;
     parameter SI.Pressure p = 1.0e5;
     parameter SI.SpecificEnthalpy h_min = Medium.h_T(Medium.T_min);
     parameter SI.SpecificEnthalpy h_max = Medium.h_T(Medium.T_max);
     parameter SI.SpecificEntropy s_min = Medium.specificEntropy(Medium.setState_pT(p,T_min));
     parameter SI.SpecificEntropy s_max = Medium.specificEntropy(Medium.setState_pT(p,T_max));
     SI.SpecificEnthalpy h1 "Pre-defined specific enthalpy";
     SI.SpecificEnthalpy h2 "Specific enthalpy computed from T (= h1 required)";
     SI.SpecificEntropy s1 "Pre-defined specific entropy";
     SI.SpecificEntropy s2 "Specific entropy computed from T (= h1 required)";
     SI.Temperature Th "Temperature computed from h1";
     SI.Temperature Ts "Temperature computed from s1";
     annotation (experiment,
                 experimentSetupOutput,
                 Documentation(info="<html>
                               
                               </html>"));
      
   equation 
     // Define specific enthalpy
     h1 = if time < 0 then h_min else 
       if time > 1 then h_max else 
       h_min + time*(h_max - h_min);
     s1 = if time < 0 then s_min else 
       if time > 1 then s_max else 
       s_min + time*(s_max - s_min);
      
     // Solve for temperature
     Th = Medium.temperature_phX(p, h1, fill(0.0,0));
     Ts = Medium.temperature_psX(p, s1, fill(0.0,0));
      
     // Check (h2 must be identical to h1)
     h2 = Medium.specificEnthalpy_pTX(p, Th, fill(0.0,0));
     s2 = Medium.specificEntropy(Medium.setState_pT(p, Ts));
   end InverseIncompressible_sh_T;
    
   model Inverse_sh_TX 
      "Solve h = h_TX(TX) for T, if h is given for ideal gas NASA" 
      import SI = Modelica.SIunits;
      extends Modelica.Icons.Example;
      
      replaceable package Medium = 
          Modelica.Media.IdealGases.MixtureGases.FlueGasLambdaOnePlus 
            extends Modelica.Media.IdealGases.Common.MixtureGasNasa 
        "Medium model"     annotation (choicesAllMatching=true);
      
     parameter SI.Temperature T_min = 300;
     parameter SI.Temperature T_max = 500;
     parameter SI.Pressure p = 1.0e5;
     SI.SpecificEnthalpy h_min = Medium.h_TX(T_min,X);
     SI.SpecificEnthalpy h_max = Medium.h_TX(T_max,X);
     parameter SI.SpecificEntropy s_min = Medium.specificEntropy(Medium.setState_pTX(p,T_min,Medium.reference_X));
     parameter SI.SpecificEntropy s_max = Medium.specificEntropy(Medium.setState_pTX(p,T_max,Medium.reference_X));
     SI.SpecificEnthalpy h1 "Pre-defined specific enthalpy";
     SI.SpecificEnthalpy h2 "Specific enthalpy computed from T (= h1 required)";
     SI.SpecificEntropy s1 "Pre-defined specific entropy";
     SI.SpecificEntropy s2 "Specific entropy computed from T (= h1 required)";
     SI.Temperature Th "Temperature computed from h1";
     SI.Temperature Ts "Temperature computed from s1";
     SI.MassFraction[4] X "mass fraction vector";
     annotation (
       experiment,
       experimentSetupOutput,
       Documentation(info="<html>
 
</html>"));
      
   equation 
     X = Medium.reference_X;
      // Define specific enthalpy
      h1 = if time < 0 then h_min else 
           if time > 1 then h_max else 
              h_min + time*(h_max - h_min);
      s1 = if time < 0 then s_min else 
           if time > 1 then s_max else 
              s_min + time*(s_max - s_min);
      
      // Solve for temperature
      Th = Medium.temperature_phX(p, h1, X);
      Ts = Medium.temperature_psX(p, s1, X);
      
      // Check (h2 must be identical to h1)
      h2 = Medium.specificEnthalpy_pTX(p, Th, X);
      s2 = Medium.specificEntropy(Medium.setState_pTX(p,Ts,X));
   end Inverse_sh_TX;
    
  end SolveOneNonlinearEquation;
end Examples;


package Interfaces "Interfaces for media models" 
  
  annotation (Documentation(info="<HTML>
<p>
This package provides basic interfaces definitions of media models for different
kind of media.
</p>
</HTML>"));
  
  extends Modelica.Icons.Library;
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
      Temperature(min=273, max=450, start=323));
      /* The vector substanceNames is mandatory, as the number of 
         substances is determined based on its size. Here we assume
         a single-component medium. 
         singleState is true if u and d do not depend on pressure, but only
         on a thermal variable (temperature or enthalpy). Otherwise, set it
         to false.
         For a single-substance medium, just set reducedX to true, and there's
         no need to bother about medium compositions at all. Otherwise, set
         final reducedX = true if the medium model has nS-1 independent mass
         fraction, or reducedX = false if the medium model has nS independent
         mass fractions (nS = number of substances).
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
    
    redeclare model extends BaseProperties "Base properties of medium" 
    equation 
      d = 1;
      h = 0;
      u = h - p/d;
      p = state.p;
      T = state.T;
      MM = 0.024;
      R  = 8.3144/MM;
      state.p = p;
      state.T = T;
      annotation (Documentation(revisions="<html>
 
</html>"));
    end BaseProperties;
    
    /* Provide implementations of the following optional properties.
     If not available, delete the corresponding function.
     The record "ThermodynamicState" contains the input arguments
     of all the function and is defined together with the used
     type definitions in PartialMedium. The record most often contains two of the
     variables "p, T, d, h" (e.g. medium.T)
  */
    redeclare replaceable record ThermodynamicState 
      "a selction of variables that uniquely defines the thermodynamic state" 
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
      annotation (Documentation(revisions="<html>
  
</html>"));
    end ThermodynamicState;
    
    redeclare function extends dynamicViscosity "Return dynamic viscosity" 
    algorithm 
      eta := 10 - state.T*0.3 + state.p*0.2;
      annotation (Documentation(revisions="<html>
  
</html>"));
    end dynamicViscosity;
    
    redeclare function extends thermalConductivity 
      "Return thermal conductivity" 
    algorithm 
      lambda := 0;
      annotation (Documentation(revisions="<html>
  
</html>"));
    end thermalConductivity;
    
    redeclare function extends specificEntropy "Return specific entropy" 
    algorithm 
      s := 0;
      annotation (Documentation(revisions="<html>
  
</html>"));
    end specificEntropy;
    
    redeclare function extends specificHeatCapacityCp 
      "Return specific heat capacity at constant pressure" 
    algorithm 
      cp := 0;
      annotation (Documentation(revisions="<html>
  
</html>"));
    end specificHeatCapacityCp;
    
    redeclare function extends specificHeatCapacityCv 
      "Return specific heat capacity at constant volume" 
    algorithm 
      cv := 0;
      annotation (Documentation(revisions="<html>
  
</html>"));
    end specificHeatCapacityCv;
    
    redeclare function extends isentropicExponent "Return isentropic exponent" 
      extends Modelica.Icons.Function;
    algorithm 
       gamma := 0;
      annotation (Documentation(revisions="<html>
  
</html>"));
    end isentropicExponent;
    
    redeclare function extends velocityOfSound "Return velocity of sound" 
      extends Modelica.Icons.Function;
    algorithm 
      a := 0;
      annotation (Documentation(revisions="<html>
  
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
    extends Modelica.Icons.Library;
    
    // Constants to be set in Medium
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
    constant MassFraction reference_X[nX]= if nX == 0 then fill(0,nX) else fill(1/nX, nX) 
      "Default mass fractions of medium";
    constant AbsolutePressure p_default=101325 
      "Default value for pressure of medium (for initialization)";
    constant Temperature T_default = Modelica.SIunits.Conversions.from_degC(20) 
      "Default value for temperature of medium (for initialization)";
    constant SpecificEnthalpy h_default = specificEnthalpy_pTX(p_default, T_default, X_default) 
      "Default value for specific enthalpy of medium (for initialization)";
    constant MassFraction X_default[nX]=reference_X 
      "Default value for mass fractions of medium (for initialization)";
    
    final constant Integer nS=size(substanceNames, 1) "Number of substances"  annotation(Evaluate=true);
    final constant Integer nX=if nS == 1 then 0 else nS 
      "Number of mass fractions (= 0, if only one substance)" annotation(Evaluate=true);
    final constant Integer nXi=if fixedX then 0 else if reducedX then nS - 1 else nX 
      "Number of structurally independent mass fractions (see docu for details)"
     annotation(Evaluate=true);
    
    final constant Integer nC=size(extraPropertiesNames, 1) 
      "Number of extra (outside of standard mass-balance) transported properties"
     annotation(Evaluate=true);
    
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
    
    replaceable record BasePropertiesRecord 
      "Variables contained in every instance of BaseProperties" 
      extends Modelica.Icons.Record;
      AbsolutePressure p "Absolute pressure of medium";
      Density d "Density of medium";
      Temperature T "Temperature of medium";
      MassFraction[nX] X(start=reference_X) 
        "Mass fractions (= (component mass)/total mass  m_i/m)";
      MassFraction[nXi] Xi(start=reference_X[1:nXi]) 
        "Structurally independent mass fractions" annotation (Hide=true);
      SpecificEnthalpy h "Specific enthalpy of medium";
      SpecificInternalEnergy u "Specific internal energy of medium";
      SpecificHeatCapacity R "Gas constant (of mixture if applicable)";
      MolarMass MM "Molar mass (of mixture or single fluid)";
    end BasePropertiesRecord;
    
    replaceable partial model BaseProperties 
      "Base properties (p, d, T, h, u, R, MM and, if applicable, X) of a medium" 
      extends BasePropertiesRecord;
      ThermodynamicState state 
        "thermodynamic state variables for optional functions";
      parameter Boolean preferredMediumStates=false 
        "= true if StateSelect.prefer shall be used for the independent property variables of the medium"
        annotation (Hide=true, Evaluate=true, Dialog(tab="Advanced"));
      annotation (structurallyIncomplete);
      SI.Conversions.NonSIunits.Temperature_degC T_degC=
          Modelica.SIunits.Conversions.to_degC(T) 
        "Temperature of medium in [degC]";
      SI.Conversions.NonSIunits.Pressure_bar p_bar=
          Modelica.SIunits.Conversions.to_bar(p) 
        "Absolute pressure of medium in [bar]";
      annotation (Documentation(info="<html>
<p>
Model <b>BaseProperties</b> is a model within package <b>PartialMedium</b>
and contains the <b>declarations</b> of the minimum number of
variables that every medium model is supposed to support.
A specific medium inherits from model <b>BaseProperties</b> and provides
the equations for the basic properties. Note, that in package
PartialMedium the following constants are defined:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Type</b></td>
      <td><b>Name</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>String</td><td>mediumName</td>
      <td>Unique name of the medium (used to check whether two media in a model
          are the same)</td></tr>
  <tr><td>String</td><td>substanceNames</td>
      <td>Names of the mixture substances that are treated
          as independent.
          If medium consists of a single substance, set substanceNames=fill(\"\",0).
          If medium consists of n substances, provide either n-1 or n
          substance names, depending whether mass fractions
          PartialMedium.BaseProperties.X shall have
          dimension PartialMedium.nX = n-1 or PartialMedium.nX = n</td></tr>
  <tr><td>Boolean</td><td>incompressible</td>
      <td>= true, if density is constant; otherwise set it to false</td></tr>
</table>
<p>
In every medium <b>3+nX equations</b> have to be defined that
provide relations between the following <b>5+nX variables</b>, declared
in model BaseProperties, where nX is the number of independent
mass fractions defined in package PartialMedium:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Variable</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>T</td>
      <td>K</td>
      <td>temperature</td></tr>
  <tr><td>p</td>
      <td>Pa</td>
      <td>absolute pressure</td></tr>
  <tr><td>d</td>
      <td>kg/m^3</td>
      <td>density</td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>specific enthalpy</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>specific internal energy</td></tr>
  <tr><td>X[nX]</td>
      <td>kg/kg</td>
      <td>independent mass fractions m_i/m</td></tr>
</table>
<p>
In some components, such as \"Ambient\", explicit equations for
medium variables are provided as \"boundary conditions\".
For example, the \"Ambient\" component may define a temperature
T_ambient.
</html>"),   Icon(Rectangle(extent=[-100,100; 100,-100], style(fillColor=7)), Text(extent=
               [-152,164; 152,102], string="%name")));
    equation 
      Xi = X[1:nXi];
      if nX > 1 then
        if fixedX then
          X = reference_X;
        elseif reducedX then
          X[nX] = 1 - sum(Xi);
        end if;
        for i in 1:nX loop
          assert(X[i] >= -1.e-5 and X[i] <= 1 + 1.e-5, "Mass fraction X[" +
            String(i) + "] = " + String(X[i]) + "of substance " + substanceNames[
            i] + "\nof medium " + mediumName + " is not in the range 0..1");
        end for;
      end if;
      
      assert(p >= 0.0, "Pressure (= " + String(p) + " Pa) of medium \"" +
        mediumName + "\" is negative\n(Temperature = " + String(T) + " K)");
      
    end BaseProperties;
    
    replaceable partial function setState_pTX 
      "Return thermodynamic state as function of p, T and composition X or Xi" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:] "Mass fractions";
      output ThermodynamicState state;
    end setState_pTX;
    
    replaceable partial function setState_phX 
      "Return thermodynamic state as function of p, h and composition X or Xi" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:] "Mass fractions";
      output ThermodynamicState state;
    end setState_phX;
    
    replaceable partial function setState_psX 
      "Return thermodynamic state as function of p, s and composition X or Xi" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:] "Mass fractions";
      output ThermodynamicState state;
    end setState_psX;
    
    replaceable partial function setState_dTX 
      "Return thermodynamic state as function of d, T and composition X or Xi" 
      extends Modelica.Icons.Function;
      input Density d "density";
      input Temperature T "Temperature";
      input MassFraction X[:] "Mass fractions";
      output ThermodynamicState state;
    end setState_dTX;
    
    replaceable partial function dynamicViscosity "Return dynamic viscosity" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output DynamicViscosity eta "Dynamic viscosity";
    end dynamicViscosity;
    
    replaceable partial function thermalConductivity 
      "Return thermal conductivity" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output ThermalConductivity lambda "Thermal conductivity";
    end thermalConductivity;
    
    replaceable function prandtlNumber "Return the Prandtl number" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output PrandtlNumber Pr "Prandtl number";
    algorithm 
      Pr := dynamicViscosity(state)*specificHeatCapacityCp(state)/thermalConductivity(
        state);
    end prandtlNumber;
    
    replaceable partial function pressure "Return pressure" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output AbsolutePressure p "Pressure";
    end pressure;
    
    replaceable partial function temperature "Return temperature" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output Temperature T "Temperature";
    end temperature;
    
    replaceable partial function density "Return density" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output Density d "Density";
    end density;
    
    replaceable partial function specificEnthalpy "Return specific enthalpy" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output SpecificEnthalpy h "Specific enthalpy";
    end specificEnthalpy;
    
    replaceable partial function specificInternalEnergy 
      "Return specific internal energy" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output SpecificEnergy u "Specific internal energy";
    end specificInternalEnergy;
    
    replaceable partial function specificEntropy "Return specific entropy" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output SpecificEntropy s "Specific entropy";
    end specificEntropy;
    
    replaceable partial function specificGibbsEnergy 
      "Return specific Gibbs energy" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output SpecificEnergy g "Specific Gibbs energy";
    end specificGibbsEnergy;
    
    replaceable partial function specificHelmholtzEnergy 
      "Return specific Helmholtz energy" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output SpecificEnergy f "Specific Helmholtz energy";
    end specificHelmholtzEnergy;
    
    replaceable partial function specificHeatCapacityCp 
      "Return specific heat capacity at constant pressure" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output SpecificHeatCapacity cp 
        "Specific heat capacity at constant pressure";
    end specificHeatCapacityCp;
    
    function heatCapacity_cp = specificHeatCapacityCp 
      "alias for deprecated name";
    
    replaceable partial function specificHeatCapacityCv 
      "Return specific heat capacity at constant volume" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output SpecificHeatCapacity cv 
        "Specific heat capacity at constant volume";
    end specificHeatCapacityCv;
    
    function heatCapacity_cv = specificHeatCapacityCv 
      "alias for deprecated name";
    
    replaceable partial function isentropicExponent 
      "Return isentropic exponent" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output IsentropicExponent gamma "Isentropic exponent";
    end isentropicExponent;
    
    replaceable partial function isentropicEnthalpy 
      "Return isentropic enthalpy" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p_downstream "downstream pressure";
      input ThermodynamicState refState "reference state for entropy";
      output SpecificEnthalpy h_is "Isentropic enthalpy";
    end isentropicEnthalpy;
    
    replaceable partial function velocityOfSound "Return velocity of sound" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output VelocityOfSound a "Velocity of sound";
    end velocityOfSound;
    
    replaceable partial function isobaricExpansionCoefficient 
      "Return overall the isobaric expansion coefficient beta" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output IsobaricExpansionCoefficient beta "Isobaric expansion coefficient";
    end isobaricExpansionCoefficient;
    
    function beta = isobaricExpansionCoefficient 
      "alias for isobaricExpansionCoefficient for user convenience";
    
    replaceable partial function isothermalCompressibility 
      "Return overall the isothermal compressibility factor" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output SI.IsothermalCompressibility kappa "Isothermal compressibility";
    end isothermalCompressibility;
    
    function kappa = isothermalCompressibility 
      "alias of isothermalCompressibility for user convenience";
    
    // explicit derivative functions for finite element models
    replaceable partial function density_derp_h 
      "Return density derivative wrt pressure at const specific enthalpy" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output DerDensityByPressure ddph "Density derivative wrt pressure";
    end density_derp_h;
    
    replaceable partial function density_derh_p 
      "Return density derivative wrt specific enthalpy at constant pressure" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output DerDensityByEnthalpy ddhp 
        "Density derivative wrt specific enthalpy";
    end density_derh_p;
    
    replaceable partial function density_derp_T 
      "Return density derivative wrt pressure at const temperature" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output DerDensityByPressure ddpT "Density derivative wrt pressure";
    end density_derp_T;
    
    replaceable partial function density_derT_p 
      "Return density derivative wrt temperature at constant pressure" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output DerDensityByTemperature ddTp "Density derivative wrt temperature";
    end density_derT_p;
    
    replaceable partial function density_derX 
      "Return density derivative wrt mass fraction" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output Density[nX] dddX "Derivative of density wrt mass fraction";
    end density_derX;
    
    replaceable partial function molarMass 
      "Return the molar mass of the medium" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output MolarMass MM "Mixture molar mass";
    end molarMass;
    
    replaceable function specificEnthalpy_pTX 
      "Return specific enthalpy from p, T, and X or Xi" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:] "Mass fractions";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm 
      h := specificEnthalpy(setState_pTX(p,T,X));
    end specificEnthalpy_pTX;
    
    replaceable function temperature_phX 
      "Return temperature from p, h, and X or Xi" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:] "Mass fractions";
      output Temperature T "Temperature";
    algorithm 
      T := temperature(setState_phX(p,h,X));
    end temperature_phX;
    
    replaceable function density_phX "Return density from p, h, and X or Xi" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:] "Mass fractions";
      output Density d "Density";
    algorithm 
      d := density(setState_phX(p,h,X));
    end density_phX;
    
    replaceable function temperature_psX 
      "Return temperature from p,s, and X or Xi" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:] "Mass fractions";
      output Temperature T "Temperature";
    algorithm 
      T := temperature(setState_psX(p,s,X));
    end temperature_psX;
    
    replaceable function density_psX 
      "Return density from p, s, and X or Xi" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:] "Mass fractions";
      output Density d "Density";
    algorithm 
      d := density(setState_psX(p,s,X));
    end density_psX;
    
    replaceable function specificEnthalpy_psX 
      "Return specific enthalpy from p, s, and X or Xi" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:] "Mass fractions";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm 
      h := specificEnthalpy(setState_psX(p,s,X));
    end specificEnthalpy_psX;
    
    type AbsolutePressure = SI.AbsolutePressure (
        min=0,
        max=1.e8,
        nominal=1.e5,
        start=1.e5) "Absolute pressure with medium specific attributes";
    
    type Density = SI.Density (
        min=0,
        max=1.e5,
        nominal=1,
        start=1);
    type DynamicViscosity = SI.DynamicViscosity (
        min=0,
        max=1.e8,
        nominal=1.e-3,
        start=1.e-3);
    type EnthalpyFlowRate = Real (
        unit="J/(kg.s)",
        nominal=1000.0,
        min=-1.0e8,
        max=1.e8);
    type MassFlowRate = SI.MassFlowRate (
        quantity="MassFlowRate." + mediumName,
        min=-1.0e5,
        max=1.e5);
    type MassFraction = Real (
        quantity="MassFraction",
        final unit="kg/kg",
        min=0,
        max=1,
        nominal=0.1);
    type MoleFraction = Real (
        quantity="MoleFraction",
        final unit="mol/mol",
        min=0,
        max=1,
        nominal=0.1);
    type MolarMass = SI.MolarMass (
        min=0.001,
        max=0.25,
        nominal=0.032);
    type MolarVolume = SI.MolarVolume (
        min=1e-6,
        max=1.0e6,
        nominal=1.0);
    type IsentropicExponent = SI.RatioOfSpecificHeatCapacities (
        min=1,
        max=1.7,
        nominal=1.2,
        start=1.2);
    type SpecificEnergy = SI.SpecificEnergy (
        min=-1.0e8,
        max=1.e8,
        nominal=1.e6);
    type SpecificInternalEnergy = SpecificEnergy;
    type SpecificEnthalpy = SI.SpecificEnthalpy (
        min=-1.0e8,
        max=1.e8,
        nominal=1.e6);
    type SpecificEntropy = SI.SpecificEntropy (
        min=-1.e6,
        max=1.e6,
        nominal=1.e3);
    type SpecificHeatCapacity = SI.SpecificHeatCapacity (
        min=0,
        max=1.e6,
        nominal=1.e3,
        start=1.e3);
    type SurfaceTension = SI.SurfaceTension;
    type Temperature = SI.Temperature (
        min=1,
        max=1.e4,
        nominal=300,
        start=300);
    type ThermalConductivity = SI.ThermalConductivity (
        min=0,
        max=500,
        nominal=1,
        start=1);
    type PrandtlNumber = SI.PrandtlNumber (
        min=1e-3,
        max=1e5,
        nominal=1.0);
    type VelocityOfSound = SI.Velocity (
        min=0,
        max=1.e5,
        nominal=1000,
        start=1000);
    type ExtraProperty = Real (min=0.0, start=1.0) 
      "unspecified, mass-specific property transported by flow";
    type CumulativeExtraProperty = Real (min=0.0, start=1.0) 
      "conserved integral of unspecified, mass specific property";
    type ExtraPropertyFlowRate = Real 
      "flow rate of unspecified, mass-specific property";
    type IsobaricExpansionCoefficient = Real (
        min=1e-8,
        max=1.0e8,
        unit="1/K") "isobaric expansion coefficient";
    type DipoleMoment = Real (
        min=0.0,
        max=2.0,
        unit="debye",
        quantity="ElectricDipoleMoment");
    
    type DerDensityByPressure = SI.DerDensityByPressure;
    type DerDensityByEnthalpy = SI.DerDensityByEnthalpy;
    type DerEnthalpyByPressure = SI.DerEnthalpyByPressure;
    type DerDensityByTemperature = SI.DerDensityByTemperature;
    
    package Choices "Types, constants to define menu choices" 
      package Init 
        "Type, constants and menu choices to define initialization, as temporary solution until enumerations are available" 
        
        annotation (preferedView="text");
        
        extends Modelica.Icons.Library;
        constant Integer NoInit=1;
        constant Integer InitialStates=2;
        constant Integer SteadyState=3;
        constant Integer SteadyMass=4;
        type Temp 
          "Temporary type with choices for menus (until enumerations are available)" 
          
          extends Integer;
          annotation (Evaluate=true, choices(
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  NoInit "NoInit (no initialization)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  InitialStates "InitialStates (initialize medium states)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  SteadyState "SteadyState (initialize in steady state)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  SteadyMass 
                "SteadyMass (initialize density or pressure in steady state)"));
        end Temp;
      end Init;
      
      package ReferenceEnthalpy 
        "Type, constants and menu choices to define reference enthalpy, as temporary solution until enumerations are available" 
        
        annotation (preferedView="text");
        
        extends Modelica.Icons.Library;
        constant Integer ZeroAt0K=1;
        constant Integer ZeroAt25C=2;
        constant Integer UserDefined=3;
        type Temp 
          "Temporary type with choices for menus (until enumerations are available)" 
          
          extends Integer;
          annotation (Evaluate=true, choices(
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  ZeroAt0K 
                "The enthalpy is 0 at 0 K (default), if the enthalpy of formation is excluded",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  ZeroAt25C 
                "The enthalpy is 0 at 25 degC, if the enthalpy of formation is excluded",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  UserDefined 
                "The user-defined reference enthalpy is used at 293.15 K (25 degC)"));
          
        end Temp;
      end ReferenceEnthalpy;
      
      package ReferenceEntropy 
        "Type, constants and menu choices to define reference entropy, as temporary solution until enumerations are available" 
        
        annotation (preferedView="text");
        
        extends Modelica.Icons.Library;
        constant Integer ZeroAt0K=1;
        constant Integer ZeroAt0C=2;
        constant Integer UserDefined=3;
        type Temp 
          "Temporary type with choices for menus (until enumerations are available)" 
          
          extends Integer;
          annotation (Evaluate=true, choices(
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  ZeroAt0K "The entropy is 0 at 0 K (default)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  ZeroAt0C "The entropy is 0 at 0 degC",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  UserDefined 
                "The user-defined reference entropy is used at 293.15 K (25 degC)"));
          
        end Temp;
      end ReferenceEntropy;
      
      package pd 
        "Type, constants and menu choices to define whether p or d are known, as temporary solution until enumerations are available" 
        
        annotation (preferedView="text");
        
        extends Modelica.Icons.Library;
        constant Integer default=1;
        constant Integer p_known=2;
        constant Integer d_known=3;
        
        type Temp 
          "Temporary type with choices for menus (until enumerations are available)" 
          
          extends Integer;
          annotation (Evaluate=true, choices(
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.pd.default 
                "default (no boundary condition for p or d)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.pd.p_known 
                "p_known (pressure p is known)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.pd.d_known 
                "d_known (density d is known)"));
        end Temp;
      end pd;
      
      package Th 
        "Type, constants and menu choices to define whether T or h are known, as temporary solution until enumerations are available" 
        
        annotation (preferedView="text");
        
        extends Modelica.Icons.Library;
        constant Integer default=1;
        constant Integer T_known=2;
        constant Integer h_known=3;
        
        type Temp 
          "Temporary type with choices for menus (until enumerations are available)" 
          
          extends Integer;
          annotation (Evaluate=true, choices(
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Th.default 
                "default (no boundary condition for T or h)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Th.T_known 
                "T_known (temperature T is known)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Th.h_known 
                "h_known (specific enthalpy h is known)"));
        end Temp;
      end Th;
      
      package Explicit 
        "Type, constants and menu choices to define the explicitly given state variable inputs" 
        extends Modelica.Icons.Enumeration;
        
        constant Integer dT_explicit=0 "explicit in density and temperature";
        constant Integer ph_explicit=1 
          "explicit in pressure and specific enthalpy";
        constant Integer ps_explicit=2 
          "explicit in pressure and specific entropy";
        constant Integer pT_explicit=3 "explicit in pressure and temperature";
        
        type Temp 
          "Temporary type with choices for menus (until enumerations are available)" 
          extends Integer(min=0,max=3);
          annotation (Evaluate=true, choices(
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Explicit.dT_explicit 
                "explicit in d and T",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Explicit.ph_explicit 
                "explicit in p and h",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Explicit.ps_explicit 
                "explicit in p and s",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Explicit.pT_explicit 
                "explicit in p and s"));
        end Temp;
      end Explicit;
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
<a href=\"Modelica:Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.
</p>
</html>
", revisions="<html>
  
</html>"));
  end PartialMedium;
  
  partial package PartialPureSubstance 
    "base class for pure substances of one chemical substance" 
    extends PartialMedium;
    
    replaceable function setState_pT "Return thermodynamic state from p and T" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output ThermodynamicState state;
    algorithm 
      state := setState_pTX(p,T,fill(0,0));
    end setState_pT;
    
    replaceable function setState_ph "Return thermodynamic state from p and h" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output ThermodynamicState state;
    algorithm 
      state := setState_phX(p,h,fill(0, 0));
    end setState_ph;
    
    replaceable function setState_ps "Return thermodynamic state from p and s" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output ThermodynamicState state;
    algorithm 
      state := setState_psX(p,s,fill(0,0));
    end setState_ps;
    
    replaceable function setState_dT "Return thermodynamic state from d and T" 
      extends Modelica.Icons.Function;
      input Density d "density";
      input Temperature T "Temperature";
      output ThermodynamicState state;
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
      p := pressure(setState_pTX(d, T, fill(0,0)));
    end pressure_dT;
    
    replaceable function specificEnthalpy_dT 
      "Return specific enthalpy from d and T" 
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      output SpecificEnthalpy h "specific enthalpy";
    algorithm 
      h := specificEnthalpy(setState_pTX(d, T, fill(0,0)));
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
    
    replaceable function density_ps 
      "Return density from p and s" 
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
  end PartialPureSubstance;
  
  partial package PartialMixtureMedium 
    "base class for pure substances of several chemical substances" 
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
        "true if vapour pressure data, e.g. Antoine coefficents are known";
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
      "return the gas constant of the mixture (also for liquids)" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state";
      output SI.SpecificHeatCapacity R "mixture gas constant";
  end gasConstant;
    
    function moleToMassFractions "Compute mass fractions X from mole fractions" 
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
    end moleToMassFractions;
    
    function massToMoleFractions "Compute mole fractions from mass fractions X" 
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
    end massToMoleFractions;
    
  end PartialMixtureMedium;
  
  partial package PartialCondensingGases 
    "Base class for mixtures of condensing and non-condensing gases" 
    extends PartialMixtureMedium;
    
  replaceable partial function saturationPressure 
      "saturation pressure of condensing fluid" 
    extends Modelica.Icons.Function;
    input Temperature Tsat "saturation temperature";
    output AbsolutePressure psat "saturation pressure";
  end saturationPressure;
    
  replaceable partial function enthalpyOfVaporization 
      "vaporization enthalpy of condensing fluid" 
    extends Modelica.Icons.Function;
    input Temperature T "temperature";
    output SpecificEnthalpy r0 "vaporization enthalpy";
  end enthalpyOfVaporization;
    
  replaceable partial function enthalpyOfLiquid 
      "liquid enthalpy of condensing fluid" 
    extends Modelica.Icons.Function;
    input Temperature T "temperature";
    output SpecificEnthalpy h "liquid enthalpy";
  end enthalpyOfLiquid;
    
  replaceable partial function enthalpyOfGas 
      "enthalpy of non-condensing gas mixture" 
    extends Modelica.Icons.Function;
    input Temperature T "temperature";
    input MassFraction[:] X "vector of mass fractions";
    output SpecificEnthalpy h "liquid enthalpy";
  end enthalpyOfGas;
    
  replaceable partial function enthalpyOfCondensingGas 
      "enthalpy of condensing gas (most often steam)" 
    extends Modelica.Icons.Function;
    input Temperature T "temperature";
    output SpecificEnthalpy h "liquid enthalpy";
  end enthalpyOfCondensingGas;
    
  end PartialCondensingGases;
  
  partial package PartialTwoPhaseMedium 
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
          info="<html><body>
          <p>The minimum pressure mostly applies to the liquid state only.
          The minimum density is also arbitrary, but is reasonable for techical
          applications to limit iterations in non-linear systems. The limits in
          enthalpy and entropy are used as safeguards in inverse iterations.</p>
          </body></html>"));
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
        "true if vapour pressure data, e.g. Antoine coefficents are known";
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
      FixedPhase phase(min=0, max=2) 
        "phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g. interactive use";
  end ThermodynamicState;
    
    replaceable record SaturationProperties 
      extends Modelica.Icons.Record;
      AbsolutePressure psat "saturation pressure";
      Temperature Tsat "saturation temperature";
    end SaturationProperties;
    
    type FixedPhase = Integer(min = 1, max = 2) 
      "Integer between 1 and 2 for phase representation";
    
    replaceable partial function setDewState 
      "set the thermodynamic state on the dew line" 
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation point";
      input FixedPhase phase =  1 "phase: default is one phase";
      output ThermodynamicState state "complete thermodynamic state info";
    end setDewState;
    
    replaceable partial function setBubbleState 
      "set the thermodynamic state on the bubble line" 
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation point";
      input FixedPhase phase =  1 "phase: default is one phase";
      output ThermodynamicState state "complete thermodynamic state info";
    end setBubbleState;
    
    redeclare replaceable partial function extends setState_dTX 
      input FixedPhase phase=0 
        "2 for two-phase, 1 for one-phase, 0 if not known";
    end setState_dTX;
    
    redeclare replaceable partial function extends setState_phX 
      input FixedPhase phase=0 
        "2 for two-phase, 1 for one-phase, 0 if not known";
    end setState_phX;
    
    redeclare replaceable partial function extends setState_psX 
      input FixedPhase phase=0 
        "2 for two-phase, 1 for one-phase, 0 if not known";
    end setState_psX;
    
    redeclare replaceable partial function extends setState_pTX 
      input FixedPhase phase=0 
        "2 for two-phase, 1 for one-phase, 0 if not known";
    end setState_pTX;
    
    replaceable function setSat_T 
      "set saturation property record from temperature" 
      extends Modelica.Icons.Function;
      input Temperature T "temperature";
      output SaturationProperties sat "saturation property record";
    algorithm 
      sat.Tsat := T;
      sat.psat := saturationPressure(T);
    end setSat_T;
    
    replaceable function setSat_p 
      "set saturation property record from pressure" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "pressure";
      output SaturationProperties sat "saturation property record";
    algorithm 
      sat.psat := p;
      sat.Tsat := saturationTemperature(p);
    end setSat_p;
    
    replaceable partial function bubbleEnthalpy 
      "Returns bubble point specific enthalpy" 
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output SI.SpecificEnthalpy hl "boiling curve specific enthalpy";
    end bubbleEnthalpy;
    
      replaceable partial function dewEnthalpy 
      "Returns dew point specific enthalpy" 
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output SI.SpecificEnthalpy hv "dew curve specific enthalpy";
      end dewEnthalpy;
    
      replaceable partial function bubbleEntropy 
      "Returns bubble point specific entropy" 
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output SI.SpecificEntropy sl "boiling curve specific entropy";
      end bubbleEntropy;
    
      replaceable partial function dewEntropy 
      "Returns dew point specific entropy" 
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output SI.SpecificEntropy sv "dew curve specific entropy";
      end dewEntropy;
    
      replaceable partial function bubbleDensity "Returns bubble point density" 
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output Density dl "boiling curve density";
      end bubbleDensity;
    
      replaceable partial function dewDensity "Returns dew point density" 
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output Density dv "dew curve density";
      end dewDensity;
    
      replaceable partial function saturationPressure 
      "Returns saturation pressure" 
        extends Modelica.Icons.Function;
        input Temperature T "temperature";
        output AbsolutePressure p "saturation pressure";
      end saturationPressure;
    
      replaceable partial function saturationTemperature 
      "Returns saturation temperature" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "pressure";
        output Temperature T "saturation temperature";
      end saturationTemperature;
    
      replaceable partial function saturationTemperature_derp 
      "Returns derivatives of saturation temperature w.r.t pressure" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "pressure";
        output Real dTp "derivatives of saturation temperature w.r.t pressure";
      end saturationTemperature_derp;
    
    replaceable partial function surfaceTension 
      "Return surface tension sigma in the two phase region" 
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output SurfaceTension sigma 
        "Surface tension sigma in the two phase region";
    end surfaceTension;
    
      replaceable partial function dBubbleDensity_dPressure 
      "Returns bubble point density derivative" 
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output DerDensityByEnthalpy ddldp "boiling curve density derivative";
      end dBubbleDensity_dPressure;
    
      replaceable partial function dDewDensity_dPressure 
      "Returns dew point density derivative" 
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output DerDensityByEnthalpy ddvdp "saturated steam density derivative";
      end dDewDensity_dPressure;
    
      replaceable partial function dBubbleEnthalpy_dPressure 
      "Returns bubble point specific enthalpy derivative" 
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output DerEnthalpyByPressure dhldp 
        "boiling curve specific enthalpy derivative";
      end dBubbleEnthalpy_dPressure;
    
      replaceable partial function dDewEnthalpy_dPressure 
      "Returns dew point specific enthalpy derivative" 
        extends Modelica.Icons.Function;
      
        input SaturationProperties sat "saturation property record";
        output DerEnthalpyByPressure dhvdp 
        "saturated steam specific enthalpy derivative";
      end dDewEnthalpy_dPressure;
    
      redeclare replaceable function specificEnthalpy_pTX 
      "Compute specific enthalpy from pressure, temperature and mass fraction" 
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
      output ThermodynamicState state;
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
      output ThermodynamicState state;
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
      output ThermodynamicState state;
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
      output ThermodynamicState state;
    algorithm 
      state := setState_dTX(d,T,fill(0,0),phase);
    end setState_dT;
    
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
      p := pressure(setState_pTX(d, T, fill(0,0),phase));
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
      h := specificEnthalpy(setState_pTX(d, T, fill(0,0),phase));
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
    
    redeclare replaceable function density_ps 
      "Return density from p and s" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
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
    
    extends Interfaces.PartialPureSubstance(final singleState=true,final 
        reducedX =                                                                true);
    
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
    
    redeclare replaceable record extends ThermodynamicState 
      "thermodynamic state" 
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
    end ThermodynamicState;
    
    redeclare replaceable model extends BaseProperties(
            T(stateSelect=StateSelect.prefer)) "Base properties" 
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
</p>
</HTML>"));
    end BaseProperties;
    
    redeclare function setState_pTX 
      "Return thermodynamic state from p, T, and X or Xi" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:] = fill(0,0) "Mass fractions";
      output ThermodynamicState state;
    algorithm 
      state := ThermodynamicState(p=p,T=T);
    end setState_pTX;
    
    redeclare function setState_phX 
      "Return thermodynamic state from p, h, and X or Xi" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:] = fill(0,0) "Mass fractions";
      output ThermodynamicState state;
    algorithm 
      state := ThermodynamicState(p=p,T=T0+h/cp_const);
    end setState_phX;
    
    redeclare replaceable function setState_psX 
      "Return thermodynamic state from p, s, and X or Xi" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:] = fill(0,0) "Mass fractions";
      output ThermodynamicState state;
    algorithm 
      state := ThermodynamicState(p=p,T=Modelica.Math.exp(s/cp_const + Modelica.Math.log(reference_T))) 
        "here the incompressible limit is used, with cp as heat capacity";
    end setState_psX;
    
    redeclare function setState_dTX 
      "Return thermodynamic state from d, T, and X or Xi" 
      extends Modelica.Icons.Function;
      input Density d "density";
      input Temperature T "Temperature";
      input MassFraction X[:] = fill(0,0) "Mass fractions";
      output ThermodynamicState state;
    algorithm 
      assert(false,"pressure can not be computed from temperature and density for an incompressible fluid!");
    end setState_dTX;
    
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
    
    redeclare function extends velocityOfSound "Velocity of sound " 
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
    
  end PartialSimpleMedium;
  
  partial package PartialSimpleIdealGasMedium 
    "Medium model of Ideal gas with constant cp and cv. All other quantities, e.g. transport properties, are constant." 
    
    extends Interfaces.PartialPureSubstance(final singleState=false,final 
        reducedX =                                                                 true);
    
    import SI = Modelica.SIunits;
    constant SpecificHeatCapacity cp_const 
      "Constant specific heat capacity at constant pressure";
    constant SpecificHeatCapacity cv_const= cp_const/R_gas 
      "Constant specific heat capacity at constant volume";
    constant SpecificHeatCapacity R_gas "medium specific gas constant";
    constant MolarMass MM_const "Molar mass";
    constant DynamicViscosity eta_const "Constant dynamic viscosity";
    constant ThermalConductivity lambda_const "Constant thermal conductivity";
    constant Temperature T_min "Minimum temperature valid for medium model";
    constant Temperature T_max "Maximum temperature valid for medium model";
    constant Temperature T0= reference_T "Zero enthalpy temperature";
    
    redeclare replaceable record extends ThermodynamicState 
      "thermodynamic state" 
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
    end ThermodynamicState;
    
    redeclare replaceable model extends BaseProperties(
            T(stateSelect=StateSelect.prefer)) "Base properties" 
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
      input MassFraction X[:] = fill(0,0) "Mass fractions";
      output ThermodynamicState state;
    algorithm 
      state := ThermodynamicState(p=p,T=T);
    end setState_pTX;
    
    redeclare function setState_phX 
      "Return thermodynamic state from p, h, and X or Xi" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:] = fill(0,0) "Mass fractions";
      output ThermodynamicState state;
    algorithm 
      state := ThermodynamicState(p=p,T=T0+h/cp_const);
    end setState_phX;
    
    redeclare replaceable function setState_psX 
      "Return thermodynamic state from p, s, and X or Xi" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:] = fill(0,0) "Mass fractions";
      output ThermodynamicState state;
    algorithm 
      state := ThermodynamicState(p=p,T=Modelica.Math.exp(s/cp_const + Modelica.Math.log(reference_T))
                                  + R_gas*Modelica.Math.log(p/reference_p));
    end setState_psX;
    
    redeclare function setState_dTX 
      "Return thermodynamic state from d, T, and X or Xi" 
      extends Modelica.Icons.Function;
      input Density d "density";
      input Temperature T "Temperature";
      input MassFraction X[:] = fill(0,0) "Mass fractions";
      output ThermodynamicState state;
    algorithm 
      state := ThermodynamicState(p=d*R_gas*T,T=T);
    end setState_dTX;
    
    redeclare function extends pressure "return pressure of ideal gas" 
    algorithm 
      p := state.p;
    end pressure;
    
    redeclare function extends temperature "return temperature of ideal gas" 
    algorithm 
      T := state.T;
    end temperature;
    
    redeclare function extends density "return density of ideal gas" 
    algorithm 
      d := state.p/(R_gas*state.T);
    end density;
    
    redeclare function extends specificEnthalpy "Return specific enthalpy" 
        extends Modelica.Icons.Function;
    algorithm 
      h := cp_const*state.T;
    end specificEnthalpy;
    
    redeclare function extends specificInternalEnergy 
      "Return specific internal energy" 
      extends Modelica.Icons.Function;
    algorithm 
      u := cp_const*state.T - R_gas*state.T;
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
      g := cp_const*state.T - state.T*specificEntropy(state);
    end specificGibbsEnergy;
    
    redeclare function extends specificHelmholtzEnergy 
      "Return specific Helmholtz energy" 
      extends Modelica.Icons.Function;
    algorithm 
      f := cp_const*state.T - R_gas*state.T - state.T*specificEntropy(state);
    end specificHelmholtzEnergy;
    
    redeclare function extends dynamicViscosity 
      "Return dya_constnamic viscosity" 
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
    
    redeclare function extends velocityOfSound "Velocity of sound " 
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
    
  end PartialSimpleIdealGasMedium;
  
  partial package PartialTwoPhaseMediumWithCache 
    extends PartialTwoPhaseMedium;
    
    replaceable record TwoPhaseProps "intermediate data record" 
      extends Modelica.Icons.Record;
      Density d "density";
      Temperature T "temperature";
      FixedPhase phase "2 for two-phase, 1 for one-phase, 0 if not known";
      AbsolutePressure p "pressure";
      SpecificEntropy s "specific entropy";
      SpecificEnergy u "specific internal energy";
      SpecificHeatCapacity cv "specific heat capacity";
      SpecificEnthalpy h "specific enthalpy";
      SpecificHeatCapacity cp "specific heat capacity";
      SpecificEnergy g "specific Gibbs energy";
      SI.Velocity w "speed of sound";
      SI.RelativePressureCoefficient beta "isobaric expansion coefficient";
      SI.IsothermalCompressibility kappa "isothermal compressibility factor";
      MassFraction x "steam mass fraction";
    end TwoPhaseProps;
    
    redeclare replaceable function density_ph "Return density from p and h" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input FixedPhase phase=0 
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm 
      d := Utilities.d_props_ph(p, h, Utilities.twoPhaseProps_ph(p, h, phase));
    end density_ph;
  /*
  redeclare function extends density_ps 
  algorithm 
    d := Utilities.d_props_ps(p, s, Utilities.twoPhaseProps_ps(p, s, phase));
  end density_ps;
*/
    redeclare replaceable function density_pT "Return density from p and T" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input FixedPhase phase=0 
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Density d "Density";
    algorithm 
      d := Utilities.d_props_pT(p, T, Utilities.twoPhaseProps_pT(p, T));
    end density_pT;
    
    redeclare replaceable function pressure_dT "Return pressure from d and T" 
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input FixedPhase phase=0 
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output AbsolutePressure p "Pressure";
    algorithm 
      p := Utilities.p_props_dT(d, T, Utilities.twoPhaseProps_dT(d, T, phase));
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
      h := Utilities.h_props_dT(d, T, Utilities.twoPhaseProps_dT(d, T, phase));
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
      h := Utilities.h_props_ps(p, s, Utilities.twoPhaseProps_ps(p, s, phase));
    end specificEnthalpy_ps;
    
    redeclare replaceable function specificEnthalpy_pT 
      "Return specific enthalpy from p and T" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input FixedPhase phase=0 
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm 
      h := Utilities.h_props_pT(p, T, Utilities.twoPhaseProps_pT(p, T));
    end specificEnthalpy_pT;
    
    redeclare replaceable function temperature_ph 
      "Return temperature from p and h" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input FixedPhase phase=0 
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Temperature T "Temperature";
    algorithm 
      T := Utilities.T_props_ph(p, h, Utilities.twoPhaseProps_ph(p, h, phase));
    end temperature_ph;
    
    redeclare replaceable function temperature_ps 
      "Return temperature from p and s" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input FixedPhase phase=0 
        "2 for two-phase, 1 for one-phase, 0 if not known";
      output Temperature T "Temperature";
    algorithm 
      T := Utilities.T_props_ps(p, s, Utilities.twoPhaseProps_ps(p, s, phase));
    end temperature_ps;
    
    replaceable package Utilities 
      function phaseAssert "assert function for inlining" 
        input Boolean check "condition to check";
        output Real dummy "dummy output";
      algorithm 
        assert(check, "this function can not be called with two-phase input");
      end phaseAssert;
      
      replaceable partial function twoPhaseProps_dT 
        "intermediate property record for medium" 
        input Density d "density";
        input Temperature T "temperature";
        input FixedPhase phase=0 
          "2 for two-phase, 1 for one-phase, 0 if not known";
        output TwoPhaseProps aux "auxiliary record";
      end twoPhaseProps_dT;
      
      function phase_dT "phase as a function of density and temperature" 
        input Density d "density";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output FixedPhase phase 
          "2 for two-phase, 1 for one-phase, 0 if not known";
        annotation (Inline=false, LateInline=true);
      algorithm 
        phase := aux.phase;
      end phase_dT;
      
      function p_props_dT 
        input Density d "density";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output AbsolutePressure p "pressure";
        annotation (Inline=false, LateInline=true);
      algorithm 
        p := aux.p;
      end p_props_dT;
      
      function s_props_dT 
        input Density d "density";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificEntropy s "specific entropy";
        annotation (Inline=false, LateInline=true);
      algorithm 
        s := aux.s;
      end s_props_dT;
      
      function u_props_dT 
        input Density d "density";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificEnergy u "specific internal energy";
        annotation (Inline=false, LateInline=true);
      algorithm 
        u := aux.u;
      end u_props_dT;
      
      function cv_props_dT 
        
        input Density d "density";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificHeatCapacity cv "specific heat capacity";
        annotation (Inline=false, LateInline=true);
      algorithm 
        cv := aux.cv;
      end cv_props_dT;
      
      function h_props_dT 
        
        input Density d "density";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificEnthalpy h "specific enthalpy";
        annotation (Inline=false, LateInline=true);
      algorithm 
        h := aux.h;
      end h_props_dT;
      
      function cp_props_dT 
        
        input Density d "density";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificHeatCapacity cp "specific heat capacity";
        annotation (Inline=false, LateInline=true);
      algorithm 
        cp := aux.cp;
      end cp_props_dT;
      
      function g_props_dT 
        
        input Density d "density";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificEnergy g "specific Gibbs energy";
        annotation (Inline=false, LateInline=true);
      algorithm 
        g := aux.g;
      end g_props_dT;
      
      function w_props_dT 
        
        input Density d "density";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SI.Velocity w "velocity of sound";
        annotation (Inline=false, LateInline=true);
      algorithm 
        w := aux.w;
      end w_props_dT;
      
      function beta_props_dT 
        
        input Density d "density";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SI.RelativePressureCoefficient beta 
          "isobaric expansion coefficient";
        annotation (Inline=false, LateInline=true);
      algorithm 
        beta := aux.beta;
      end beta_props_dT;
      
      function kappa_props_dT 
        
        input Density d "density";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SI.IsothermalCompressibility kappa 
          "isothermal compressibility factor";
        annotation (Inline=false, LateInline=true);
      algorithm 
        kappa := aux.kappa;
      end kappa_props_dT;
      
      replaceable partial function twoPhaseProps_ph 
        "intermediate property record for medium" 
        
        input AbsolutePressure p "pressure";
        input SpecificEnthalpy h "specific enthalpy";
        input FixedPhase phase=0 
          "2 for two-phase, 1 for one-phase, 0 if not known";
        output TwoPhaseProps aux "auxiliary record";
      end twoPhaseProps_ph;
      
      function d_props_ph 
        
        input AbsolutePressure p "pressure";
        input SpecificEnthalpy h "specific enthalpy";
        input TwoPhaseProps aux "auxiliary record";
        output Density d "density";
        annotation (
          Inline=false,
          LateInline=true);
      /*
  annotation (
    derivative(noDerivative=aux) = d_ph_der,
    Inline=false,
    LateInline=true);
*/
      algorithm 
        d := aux.d;
      end d_props_ph;
      
      function T_props_ph 
        
        input AbsolutePressure p "pressure";
        input SpecificEnthalpy h "specific enthalpy";
        input TwoPhaseProps aux "auxiliary record";
        output Temperature T "temperature";
        annotation (Inline=false, LateInline=true);
      algorithm 
        T := aux.T;
      end T_props_ph;
      
      function phase_ph "phase as a function of pressure and specific enthalpy" 
        
        input AbsolutePressure p "pressure";
        input SpecificEnthalpy h "specific enthalpy";
        input TwoPhaseProps aux "auxiliary record";
        output FixedPhase phase 
          "2 for two-phase, 1 for one-phase, 0 if not known";
        annotation (Inline=false, LateInline=true);
      algorithm 
        phase := aux.phase;
      end phase_ph;
      
      function s_props_ph 
        
        input AbsolutePressure p "pressure";
        input SpecificEnthalpy h "specific enthalpy";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificEntropy s "specific entropy";
        annotation (Inline=false, LateInline=true);
      algorithm 
        s := aux.s;
      end s_props_ph;
      
      function u_props_ph 
        
        input AbsolutePressure p "pressure";
        input SpecificEnthalpy h "specific enthalpy";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificEnergy u "specific internal energy";
        annotation (Inline=false, LateInline=true);
      algorithm 
        u := aux.u;
      end u_props_ph;
      
      function cv_props_ph 
        
        input AbsolutePressure p "pressure";
        input SpecificEnthalpy h "specific enthalpy";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificHeatCapacity cv "specific heat capacity";
        annotation (Inline=false, LateInline=true);
      algorithm 
        cv := aux.cv;
      end cv_props_ph;
      
      function cp_props_ph 
        
        input AbsolutePressure p "pressure";
        input SpecificEnthalpy h "specific enthalpy";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificHeatCapacity cp "specific heat capacity";
        annotation (Inline=false, LateInline=true);
      algorithm 
        cp := aux.cp;
      end cp_props_ph;
      
      function g_props_ph 
        
        input AbsolutePressure p "pressure";
        input SpecificEnthalpy h "specific enthalpy";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificEnergy g "specific Gibbs energy";
        annotation (Inline=false, LateInline=true);
      algorithm 
        g := aux.g;
      end g_props_ph;
      
      function beta_props_ph 
        
        input AbsolutePressure p "pressure";
        input SpecificEnthalpy h "specific enthalpy";
        input TwoPhaseProps aux "auxiliary record";
        output SI.RelativePressureCoefficient beta 
          "isobaric expansion coefficient";
        annotation (Inline=false, LateInline=true);
      algorithm 
        beta := aux.beta;
      end beta_props_ph;
      
      function kappa_props_ph 
        
        input AbsolutePressure p "pressure";
        input SpecificEnthalpy h "specific enthalpy";
        input TwoPhaseProps aux "auxiliary record";
        output SI.IsothermalCompressibility kappa 
          "isothermal compressibility factor";
        annotation (Inline=false, LateInline=true);
      algorithm 
        kappa := aux.kappa;
      end kappa_props_ph;
      
      replaceable partial function twoPhaseProps_ps 
        "intermediate property record for medium" 
        
        input AbsolutePressure p "pressure";
        input SpecificEntropy s "specific entropy";
        input FixedPhase phase=0 
          "2 for two-phase, 1 for one-phase, 0 if not known";
        output TwoPhaseProps aux "auxiliary record";
      end twoPhaseProps_ps;
      
      function d_props_ps 
        
        input AbsolutePressure p "pressure";
        input SpecificEntropy s "specific entropy";
        input TwoPhaseProps aux "auxiliary record";
        output Density d "density";
        annotation (Inline=false, LateInline=true);
      algorithm 
        d := aux.d;
      end d_props_ps;
      
      function T_props_ps 
        
        input AbsolutePressure p "pressure";
        input SpecificEntropy s "specific entropy";
        input TwoPhaseProps aux "auxiliary record";
        output Temperature T "temperature";
        annotation (Inline=false, LateInline=true);
      algorithm 
        T := aux.T;
      end T_props_ps;
      
      function phase_ps "phase as a function of pressure and specific entropy" 
        
        input AbsolutePressure p "pressure";
        input SpecificEntropy s "specific entropy";
        input TwoPhaseProps aux "auxiliary record";
        output FixedPhase phase 
          "2 for two-phase, 1 for one-phase, 0 if not known";
        annotation (Inline=false, LateInline=true);
      algorithm 
        phase := aux.phase;
      end phase_ps;
      
      function u_props_ps 
        
        input AbsolutePressure p "pressure";
        input SpecificEntropy s "specific entropy";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificEnergy u "specific internal energy";
        annotation (Inline=false, LateInline=true);
      algorithm 
        u := aux.u;
      end u_props_ps;
      
      function cv_props_ps 
        
        input AbsolutePressure p "pressure";
        input SpecificEntropy s "specific entropy";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificHeatCapacity cv "specific heat capacity";
        annotation (Inline=false, LateInline=true);
      algorithm 
        cv := aux.cv;
      end cv_props_ps;
      
      function h_props_ps 
        
        input AbsolutePressure p "pressure";
        input SpecificEntropy s "specific entropy";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificEnthalpy h "specific enthalpy";
        annotation (Inline=false, LateInline=true);
      algorithm 
        h := aux.h;
      end h_props_ps;
      
      function cp_props_ps 
        
        input AbsolutePressure p "pressure";
        input SpecificEntropy s "specific entropy";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificHeatCapacity cp "specific heat capacity";
        annotation (Inline=false, LateInline=true);
      algorithm 
        cp := aux.cp;
      end cp_props_ps;
      
      function g_props_ps 
        
        input AbsolutePressure p "pressure";
        input SpecificEntropy s "specific entropy";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificEnergy g "specific Gibbs energy";
        annotation (Inline=false, LateInline=true);
      algorithm 
        g := aux.g;
      end g_props_ps;
      
      function beta_props_ps 
        
        input AbsolutePressure p "pressure";
        input SpecificEntropy s "specific entropy";
        input TwoPhaseProps aux "auxiliary record";
        output SI.RelativePressureCoefficient beta 
          "isobaric expansion coefficient";
        annotation (Inline=false, LateInline=true);
      algorithm 
        beta := aux.beta;
      end beta_props_ps;
      
      function kappa_props_ps 
        
        input AbsolutePressure p "pressure";
        input SpecificEntropy s "specific entropy";
        input TwoPhaseProps aux "auxiliary record";
        output SI.IsothermalCompressibility kappa 
          "isothermal compressibility factor";
        annotation (Inline=false, LateInline=true);
      algorithm 
        kappa := aux.kappa;
      end kappa_props_ps;
      
      replaceable partial function twoPhaseProps_pT 
        "intermediate property record for medium" 
        
        input AbsolutePressure p "pressure";
        input Temperature T "temperature";
        output TwoPhaseProps aux "auxiliary record";
      end twoPhaseProps_pT;
      
      function d_props_pT 
        
        input AbsolutePressure p "pressure";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output Density d "density";
        annotation (Inline=false, LateInline=true);
      algorithm 
        d := aux.d;
      end d_props_pT;
      
      function s_props_pT 
        
        input AbsolutePressure p "pressure";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificEntropy s "specific entropy";
        annotation (Inline=false, LateInline=true);
      algorithm 
        s := aux.s;
      end s_props_pT;
      
      function u_props_pT 
        
        input AbsolutePressure p "pressure";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificEnergy u "specific internal energy";
        annotation (Inline=false, LateInline=true);
      algorithm 
        u := aux.u;
      end u_props_pT;
      
      function cv_props_pT 
        
        input AbsolutePressure p "pressure";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificHeatCapacity cv "specific heat capacity";
        annotation (Inline=false, LateInline=true);
      algorithm 
        cv := aux.cv;
      end cv_props_pT;
      
      function h_props_pT 
        
        input AbsolutePressure p "pressure";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificEnthalpy h "specific enthalpy";
        annotation (Inline=false, LateInline=true);
      algorithm 
        h := aux.h;
      end h_props_pT;
      
      function cp_props_pT 
        
        input AbsolutePressure p "pressure";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificHeatCapacity cp "specific heat capacity";
        annotation (Inline=false, LateInline=true);
      algorithm 
        cp := aux.cp;
      end cp_props_pT;
      
      function g_props_pT 
        
        input AbsolutePressure p "pressure";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SpecificEnergy g "specific Gibbs energy";
        annotation (Inline=false, LateInline=true);
      algorithm 
        g := aux.g;
      end g_props_pT;
      
      function beta_props_pT 
        
        input AbsolutePressure p "pressure";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SI.RelativePressureCoefficient beta 
          "isobaric expansion coefficient";
        annotation (Inline=false, LateInline=true);
      algorithm 
        beta := aux.beta;
      end beta_props_pT;
      
      function kappa_props_pT 
        
        input AbsolutePressure p "pressure";
        input Temperature T "temperature";
        input TwoPhaseProps aux "auxiliary record";
        output SI.IsothermalCompressibility kappa 
          "isothermal compressibility factor";
        annotation (Inline=false, LateInline=true);
      algorithm 
        kappa := aux.kappa;
      end kappa_props_pT;
    end Utilities;
  end PartialTwoPhaseMediumWithCache;
end Interfaces;


package Common "data structures and fundamental functions for fluid properties" 
  
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
  extends Modelica.Icons.Library;
protected 
  type Rate = Real (final quantity="Rate", final unit="s-1");
  type MolarFlowRate = Real (final quantity="MolarFlowRate", final unit="mol/s");
  type MolarReactionRate = Real (final quantity="MolarReactionRate", final unit
        ="mol/(m3.s)");
  type MolarEnthalpy = Real (final quantity="MolarEnthalpy", final unit="J/mol");
  type DerDensityByEntropy = Real (final quantity="DerDensityByEntropy", final unit
        =    "kg2.K/(m3.J)");
  type DerEnergyByPressure = Real (final quantity="DerEnergyByPressure", final unit
        =    "J/Pa");
  type DerEnergyByMoles = Real (final quantity="DerEnergyByMoles", final unit=
          "J/mol");
  type DerEntropyByTemperature = Real (final quantity="DerEntropyByTemperature",
         final unit="J/K2");
  type DerEntropyByPressure = Real (final quantity="DerEntropyByPressure",
        final unit="J/(K.Pa)");
  type DerEntropyByMoles = Real (final quantity="DerEntropyByMoles", final unit
        ="J/(mol.K)");
  type DerPressureByDensity = Real (final quantity="DerPressureByDensity",
        final unit="Pa.m3/kg");
  type DerPressureBySpecificVolume = Real (final quantity=
          "DerPressureBySpecificVolume", final unit="Pa.kg/m3");
  type DerPressureByTemperature = Real (final quantity=
          "DerPressureByTemperature", final unit="Pa/K");
  type DerVolumeByTemperature = Real (final quantity="DerVolumeByTemperature",
        final unit="m3/K");
  type DerVolumeByPressure = Real (final quantity="DerVolumeByPressure", final unit
        =    "m3/Pa");
  type DerVolumeByMoles = Real (final quantity="DerVolumeByMoles", final unit=
          "m3/mol");
  type IsenthalpicExponent = Real (final quantity="IsenthalpicExponent", unit=
          "1");
  type IsentropicExponent = Real (final quantity="IsentropicExponent", unit="1");
  type IsobaricVolumeExpansionCoefficient = Real (final quantity=
          "IsobaricVolumeExpansionCoefficient", unit="1/K");
  type IsochoricPressureCoefficient = Real (final quantity=
          "IsochoricPressureCoefficient", unit="1/Pa");
  type IsothermalCompressibility = Real (final quantity=
          "IsothermalCompressibility", unit="kg/m^3");
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
      SI.MassFraction[n, nspecies] mass_x(
        min=MASSXMIN,
        max=MASSXMAX,
        nominal=MASSXNOM) "mass fraction";
      SI.MoleFraction[n, nspecies] mole_y(
        min=MOLEYMIN,
        max=MOLEYMAX,
        nominal=MOLEYNOM) "mole fraction";
      SI.Mass[n, nspecies] M_x(
        min=MMIN,
        max=MMAX,
        nominal=MNOM) "component mass";
      SI.MassFlowRate[n, nspecies] dM_x(
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
      SI.AmountOfSubstance[n, nspecies] Moles_z(
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
      SI.DerEnergyByPressure dupT 
        "derivative of inner energy by pressure at constant T";
      SI.DerEnergyByDensity dudT 
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
        "derivative of total enthalpy wrt component mass at constant T";
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
      SI.DerEnergyByPressure duph 
        "derivative of inner energy by pressure at constant enthalpy";
      Real duhp "derivative of inner energy by enthalpy at constant pressure";
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
      SI.DerEnergyByPressure dupT 
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
      SI.DerEnergyByDensity dudT 
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
    
      //     "derivatives of dimensionless Gibbs-function w.r.t dimensionless pressure and temperature"
    //     extends Modelica.Icons.Record;
    //     Real pi "dimensionless pressure";
    //     Real tau "dimensionless temperature";
    //     Real g "dimensionless Gibbs-function";
    //     Real gpi "derivative of g w.r.t. pi";
    //     Real gpipi "2nd derivative of g w.r.t. pi";
    //     Real gtau "derivative of g w.r.t. tau";
    //     Real gtautau "2nd derivative of g w.r.t tau";
    //     Real gtaupi "mixed derivative of g w.r.t. pi and tau";
    //   end GibbsDerivs;
    
    //   record HelmholtzDerivs
    
      //     "derivatives of dimensionless Helmholtz-function w.r.t dimensionless pressuredensity and temperature"
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
      Real vt "derivative of specific volume w.r.t. temperature";
      Real vp "derivative of specific volume w.r.t. pressure";
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
      Real vt "derivative of specific volume w.r.t. temperature";
      Real vp "derivative of specific volume w.r.t. pressure";
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
      Real vt "derivative of specific volume w.r.t. temperature";
      Real vp "derivative of specific volume w.r.t. pressure";
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
      
      pro.dudT := pro.cp + g.T*vt*vt/vp;
    end gibbsToProps_dT;
    
    function gibbsToProps_pT 
      "calulate property record for pressure and temperature as states from dimensionless Gibbs function" 
      
      extends Modelica.Icons.Function;
      input GibbsDerivs g "dimensionless derivatives of Gibbs function";
      output ThermoProperties_pT pro 
        "property record for pressure and temperature as dynamic states";
    protected 
      Real vt "derivative of specific volume w.r.t. temperature";
      Real vp "derivative of specific volume w.r.t. pressure";
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
      pv := -(f.d*f.d)/pd;
      
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
    algorithm 
      pro.d := f.d;
      pro.R := f.R;
      pro.s := f.R*(f.tau*f.ftau - f.f);
      pro.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
      pro.u := f.R*f.T*f.tau*f.ftau;
      pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      pv := -(f.d*f.d)/pd;
      
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
      pro.dupT := (f.d - f.T*pt)/(f.d*f.d*pd);
      pro.duTp := (-pro.cv*f.d*f.d*pd + pt*f.d - f.T*pt*pt)/(f.d*f.d*pd);
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
      pv := -1/(f.d*f.d)*f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
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
      Real dht "derivative of specific enthalpy w.r.t. temperature";
      Real dhd "derivative of specific enthalpy w.r.t. density";
      Real detph "thermodynamic determinant";
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
    Real dpT "derivative of saturation pressure wrt temperature";
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
    Real dTp "derivative of temperature wrt saturation pressure";
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
    DerPressureByTemperature pt "derivative of pressure wrt temperature";
    DerPressureByDensity pd "derivative of pressure wrt density";
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
    DerPressureByTemperature pt "derivative of pressure wrt temperature";
    DerPressureByDensity pd "derivative of pressure wrt density";
    Real vt "derivative of specific volume w.r.t. temperature";
    Real vp "derivative of specific volume w.r.t. pressure";
  end IF97PhaseBoundaryProperties;
  
  record GibbsDerivs 
    "derivatives of dimensionless Gibbs-function w.r.t dimensionless pressure and temperature" 
    
    extends Modelica.Icons.Record;
    SI.Pressure p "pressure";
    SI.Temperature T "temperature";
    SI.SpecificHeatCapacity R "specific heat capacity";
    Real pi "dimensionless pressure";
    Real tau "dimensionless temperature";
    Real g "dimensionless Gibbs-function";
    Real gpi "derivative of g w.r.t. pi";
    Real gpipi "2nd derivative of g w.r.t. pi";
    Real gtau "derivative of g w.r.t. tau";
    Real gtautau "2nd derivative of g w.r.t tau";
    Real gtaupi "mixed derivative of g w.r.t. pi and tau";
  end GibbsDerivs;
  
  record HelmholtzDerivs 
    "derivatives of dimensionless Helmholtz-function w.r.t dimensionless pressuredensity and temperature" 
    extends Modelica.Icons.Record;
    SI.Density d "density";
    SI.Temperature T "temperature";
    SI.SpecificHeatCapacity R "specific heat capacity";
    Real delta "dimensionless density";
    Real tau "dimensionless temperature";
    Real f "dimensionless Helmholtz-function";
    Real fdelta "derivative of f w.r.t. delta";
    Real fdeltadelta "2nd derivative of f w.r.t. delta";
    Real ftau "derivative of f w.r.t. tau";
    Real ftautau "2nd derivative of f w.r.t. tau";
    Real fdeltatau "mixed derivative of f w.r.t. delta and tau";
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
    DerPressureByTemperature pt "derivative of pressure wrt temperature";
    DerPressureByDensity pd "derivative of pressure wrt density";
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
    SI.SpecificHeatCapacity cp "heat capaccity at constant pressure";
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
    Real dfs=gamma*v*s + dus 
      "coefficient in Bridgmans table, see info for usage";
    Real dsf=-dfs "coefficient in Bridgmans table, see info for usage";
    Real dgs=gamma*v*s - v*cp/T 
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
    annotation (Documentation(info="
                <HTML>
                <p>
                <pre>
Important: the phase equilibrium conditions are not yet considered.
this means that bridgemans tables do not yet work in the two phase region
some derivatives are 0 or infinity anyways
Idea: don't use the values in Bridgmans table directly, all
derivatives are calculated as the quotient of two entries in the
table. The last letter indicates which variable is held constant in
taking the derivative. The second letters are the two variables
involved in the derivative and the first letter is alwys a d to remind
of differentiation.
Example 1: Get the derivative of specific entropy s wrt Temperature at
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
                </p>
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
    output SI.SpecificHeatCapacity cp "heat capaccity at constant pressure";
    output IsobaricVolumeExpansionCoefficient alpha 
      "isobaric volume expansion coefficient";
    // beta in Bejan
    output IsothermalCompressibility gamma "isothermal compressibility";
    // kappa in Bejan
  protected 
    Real vt "derivative of specific volume w.r.t. temperature";
    Real vp "derivative of specific volume w.r.t. pressure";
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
    output SI.SpecificHeatCapacity cp "heat capaccity at constant pressure";
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
    pv := -1/(f.d*f.d)*f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
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
    pv := -1/(f.d*f.d)*f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
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
  
 package OneNonLinearEquation 
    "Determine solution of a non-linear algebraic equation in one unknown without derivatives in a reliable and efficient way" 
   extends Modelica.Icons.Library;
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
complicated (this method is from Hans Olsson, Dynasim AB). A user has to
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
       Real a = x_min "Current best minimum interval value";
       Real b = x_max "Current best maximum interval value";
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
       fa :=f_nonlinear(x_min, pressure, X, f_nonlinear_data) - y_zero;
       fb :=f_nonlinear(x_max, pressure, X, f_nonlinear_data) - y_zero;
       fc := fb;
       if fa > 0.0 and fb > 0.0 or 
          fa < 0.0 and fb < 0.0 then
          error("The arguments x_min and x_max to OneNonLinearEquation.solve(..)\n" +
                "do not bracket the root of the single non-linear equation:\n" +
                "  x_min  = " + String(x_min) + "\n" +
                "  x_max  = " + String(x_max) + "\n" +
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
    
 end OneNonLinearEquation;
end Common;
end Media;
