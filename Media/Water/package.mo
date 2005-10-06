package Water "Medium models for water"
annotation (Documentation(info="<html>
<p>This package contains different medium models for water:</p>
<ul>
<li><b>ConstantPropertyLiquidWater</b><br>
    Simple liquid water medium (incompressible, constant data).</li>
<li><b>IdealSteam</b><br>
    Steam water medium as ideal gas from Media.IdealGases.SingleGases.H2O</li>
<li><b>WaterIF97 derived models</b><br>
    High precision water model according to the IAPWS/IF97 standard
    (liquid, steam, two phase region). Models with different independent
    variables are provided as well as models valid only
    for particular regions. The <b>WaterIF97_ph</b> model is valid
    in all regions and is the recommended one to use.</li>
</ul>
<h3>Overview of WaterIF97 derived water models</h3>
<p>
The WaterIF97 models calculate medium properties 
for water in the <b>liquid</b>, <b>gas</b> and <b>two phase</b> regions 
according to the IAPWS/IF97 standard, i.e., the accepted industrial standard
and best compromise between accuracy and computation time.
It has been part of the ThermoFluid Modelica library and been extended,
reorganized and documented to become part of the Modelica Standard library.</p>
<p>An important feature that distinguishes this implementation of the IF97 steam property standard
is that this implementation has been explicitly designed to work well in dynamic simulations. Computational
performance has been of high importance. This means that there often exist several ways to get the same result
from different functions if one of the functions is called often but can be optimized for that purpose.
</p>
<p>Three variable pairs can be the independent variables of the model:
</p>
<ol>
<li>Pressure <b>p</b> and specific enthalpy <b>h</b> are 
    the most natural choice for general applications. 
    This is the recommended choice for most general purpose 
    applications, in particular for power plants.</li>
<li>Pressure <b>p</b> and temperature <b>T</b> are the most natural 
    choice for applications where water is always in the same phase,
    both for liquid water and steam.</li>
<li>Density <b>d</b> and temperature <b>T</b> are explicit 
    variables of the Helmholtz function in the near-critical 
    region and can be the best choice for applications with 
    super-critical or near-critial states.</li>
</ol>
<p>
The following quantities are always computed in Medium.Baseproperties:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Variable</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>T</td>
      <td>K</td>
      <td>temperature</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>specific internal energy</b></td></tr>
  <tr><td>d</td>
      <td>kg/m^3</td>
      <td>density</td></tr>
  <tr><td>p</td>
      <td>Pa</td>
      <td>pressure</td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>specific enthalpy</b></td></tr>
</table>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the following functions:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Function call</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>Medium.dynamicViscosity(medium.state)</b></td>
      <td>Pa.s</td>
      <td>dynamic viscosity</td></tr>
  <tr><td>Medium.thermalConductivity(medium.state)</td>
      <td>W/(m.K)</td>
      <td>thermal conductivity</td></tr>
  <tr><td>Medium.prandtlNumber(medium.state)</td>
      <td>1</td>
      <td>Prandtl number</td></tr>
  <tr><td>Medium.entropy(medium.state)</td>
      <td>J/(kg.K)</td>
      <td>specific entropy</td></tr>
  <tr><td>Medium.heatCapacity_cp(medium.state)</td>
      <td>J/(kg.K)</td>
      <td>specific heat capacity at constant pressure</td></tr>
  <tr><td>Medium.heatCapacity_cv(medium.state)</td>
      <td>J/(kg.K)</td>
      <td>specific heat capacity at constant density</td></tr>
  <tr><td>Medium.isentropicExponent(medium.state)</td>
      <td>1</td>
      <td>isentropic exponent</td></tr>
  <tr><td>Medium.isentropicEnthalpy(pressure, medium.state)</td>
      <td>J/kg</td>
      <td>isentropic enthalpy</td></tr>
  <tr><td>Medium.velocityOfSound(medium.state)</td>
      <td>m/s</td>
      <td>velocity of sound</td></tr>
  <tr><td>Medium.isobaricExpansionCoefficient(medium.state)</td>
      <td>1/K</td>
      <td>isobaric expansion coefficient</td></tr>
  <tr><td>Medium.isothermalCompressibility(medium.state)</td>
      <td>1/Pa</td>
      <td>isothermal compressibility</td></tr>
  <tr><td>Medium.density_derp_h(medium.state)</td>
      <td>kg/(m3.Pa)</td>
      <td>derivative of density by pressure at constant enthalpy</td></tr>
  <tr><td>Medium.density_derh_p(medium.state)</td>
      <td>kg2/(m3.J)</td>
      <td>derivative of density by enthalpy at constant pressure</td></tr>
  <tr><td>Medium.density_derp_T(medium.state)</td>
      <td>kg/(m3.Pa)</td>
      <td>derivative of density by pressure at constant temperature</td></tr>
  <tr><td>Medium.density_derT_p(medium.state)</td>
      <td>kg/(m3.K)</td>
      <td>derivative of density by temperature at constant pressure</td></tr>
  <tr><td>Medium.density_derX(medium.state)</td>
      <td>kg/m3</td>
      <td>derivative of density by mass fraction</td></tr>
  <tr><td>Medium.molarMass(medium.state)</td>
      <td>kg/mol</td>
      <td>molar mass</td></tr>
</table>
<p>More details are given in
<a href=\"Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">
Modelica.Media.UsersGuide.MediumUsage.OptionalProperties</a>.
Many additional optional functions are defined to compute properties of 
saturated media, either liquid (bubble point) or vapour (dew point). 
The argument to such functions is a SaturationProperties record, which can be
set starting from either the saturation pressure or the saturation temperature.
With reference to a model defining a pressure p, a temperature T, and a 
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
<p>Details on usage and some examples are given in:
<a href=\"Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">
Modelica.Media.UsersGuide.MediumUsage.TwoPhase</a>.
</p>
<p>Many further properties can be computed. Using the well-known Bridgman's Tables,
all first partial derivatives of the standard thermodynamic variables can be computed easily.
</p>
<p>
The documentation of the IAPWS/IF97 steam properties can be freely 
distributed with computer implementations and are included here
(in directory Modelica\\help\\IF97documentation):
<ul>
<li><a href=\"IF97documentation/IF97.pdf\">IF97.pdf</a> The standards document for the main part of the IF97.</li>
<li><a href=\"IF97documentation/Back3.pdf\">Back3.pdf</a> The backwards equations for region 3.</li>
<li><a href=\"IF97documentation/crits.pdf\">crits.pdf</a> The critical point data.</li>
<li><a href=\"IF97documentation/meltsub.pdf\">meltsub.pdf</a> The melting- and sublimation line formulation (not implemented)</li>
<li><a href=\"IF97documentation/surf.pdf\">surf.pdf</a> The surface tension standard definition</li>
<li><a href=\"IF97documentation/thcond.pdf\">thcond.pdf</a> The thermal conductivity standard definition</li>
<li><a href=\"IF97documentation/visc.pdf\">visc.pdf</a> The viscosity standard definition</li>
</ul>
</html>"));

extends Modelica.Icons.Library;
  constant Interfaces.PartialMedium.FluidConstants[1] waterConstants(
     each chemicalFormula = "H2O",
     each structureFormula="H2O",
     each casRegistryNumber="7732-18-5",
     each iupacName="oxidane",
     each molarMass=0.018015268,
     each criticalTemperature=647.096,
     each criticalPressure=22064.0e3,
     each criticalMolarVolume=1/(322.0*0.018015268),
     each normalBoilingPoint=373.124,
     each meltingPoint=273.15,
     each triplePointTemperature=273.16,
     each triplePointPressure=611.657,
     each acentricFactor = 0.344,
     each dipoleMoment = 1.8,
     each hasCriticalData=true);

package ConstantPropertyLiquidWater 
  "Water: Simple liquid water medium (incompressible, constant data)" 
  
  import Cv = Modelica.SIunits.Conversions;
  extends Interfaces.PartialSimpleMedium(
     mediumName="SimpleLiquidWater",
     cp_const=4184,
     cv_const=4184,
     d_const=995.586,
     eta_const=1.e-3,
     lambda_const=0.598,
     a_const=1484,
     T_min=Cv.from_degC(-1),
     T_max=Cv.from_degC(130),
     T0=273.15,
     MM_const=0.018015268,
     fluidConstants = waterConstants);
  
  annotation (Icon(Text(
        extent=[-90, 88; 90, 18],
        string="liquid",
        style(
          color=0,
          fillColor=7,
          fillPattern=1)), Text(
        extent=[-90, -22; 90, -90],
        string="water",
        style(
          color=0,
          fillColor=7,
          fillPattern=1))), Diagram);
end ConstantPropertyLiquidWater;

package IdealSteam "Water: Steam as ideal gas from NASA source" 
  extends IdealGases.SingleGases.H2O(
  fluidConstants = waterConstants);
end IdealSteam;

package StandardWater = WaterIF97_ph 
  "Water using the IF97 standard, explicit in p and h. Recommended for most applications";

package StandardWaterOnePhase = WaterIF97_pT 
  "Water using the IF97 standard, explicit in p and T. Recommended for one-phase applications";

package WaterIF97OnePhase_ph 
  "Water using the IF97 standard, explicit in p and h, and only valid outside the two-phase dome" 
  extends WaterIF97_base(
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    final smoothModel=true,
    final onePhase=true);
end WaterIF97OnePhase_ph;

package WaterIF97_pT "Water using the IF97 standard, explicit in p and T" 
  extends WaterIF97_base(
    final ph_explicit=false,
    final dT_explicit=false,
    final pT_explicit=true,
    final smoothModel=true,
    final onePhase=true);
end WaterIF97_pT;

package WaterIF97_ph "Water using the IF97 standard, explicit in p and h" 
  extends WaterIF97_base(
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=false,
    onePhase=false);
end WaterIF97_ph;

partial package WaterIF97_base 
  "Water: Steam properties as defined by IAPWS/IF97 standard" 
  annotation (Icon(Text(
        extent=[-94, 84; 94, 40],
        style(color=71),
        string="IF97"), Text(
        extent=[-94, 20; 94, -24],
        style(color=71),
        string="water")), Documentation(info="<HTML>
<p>
This model calculates medium properties 
for water in the <b>liquid</b>, <b>gas</b> and <b>two phase</b> regions 
according to the IAPWS/IF97 standard, i.e., the accepted industrial standard
and best compromise between accuracy and computation time.
For more details see <a href=\"Modelica.Media.Water.IF97_Utilities\">
Modelica.Media.Water.IF97_Utilities</a>. Three variable pairs can be the 
independent variables of the model:
<ol>
<li>Pressure <b>p</b> and specific enthalpy <b>h</b> are the most natural choice for general applications. This is the recommended choice for most general purpose applications, in particular for power plants.</li>
<li>Pressure <b>p</b> and temperature <b>T</b> are the most natural choice for applications where water is always in the same phase, both for liquid water and steam.</li>
<li>Density <b>d</b> and temperature <b>T</b> are explicit variables of the Helmholtz function in the near-critical region and can be the best choice for applications with super-critical or near-critial states.</li>
</ol>
The following quantities are always computed:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Variable</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>T</td>
      <td>K</td>
      <td>temperature</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>specific internal energy</b></td></tr>
  <tr><td>d</td>
      <td>kg/m^3</td>
      <td>density</td></tr>
  <tr><td>p</td>
      <td>Pa</td>
      <td>pressure</td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>specific enthalpy</b></td></tr>
</table>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the functions listed in 
<a href=\"Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">
Modelica.Media.UsersGuide.MediumUsage.OptionalProperties</a> and in
<a href=\"Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">
Modelica.Media.UsersGuide.MediumUsage.TwoPhase</a>.
</p>
</p>
<p>Many further properties can be computed. Using the well-known Bridgman's Tables, all first partial derivatives of the standard thermodynamic variables can be computed easily.</p>
</HTML>
"));
  extends Interfaces.PartialTwoPhaseMedium(
     mediumName="WaterIF97",
     substanceNames={"water"},
     final reducedX=true,
     singleState=false,
     SpecificEnthalpy(start=1.0e5, nominal=5.0e5),
     Density(start=150, nominal=500),
     AbsolutePressure(start=50e5, nominal=10e5),
     Temperature(start=500, nominal=500),
     smoothModel=false,
     onePhase=false,
     fluidConstants = waterConstants);
  
  redeclare record extends ThermodynamicState "thermodynamic state" 
    SpecificEnthalpy h "specific enthalpy";
    Density d "density";
    Temperature T "temperature";
    AbsolutePressure p "pressure";
  end ThermodynamicState;
  
  constant Boolean ph_explicit 
    "true if explicit in pressure and specific enthalpy";
  constant Boolean dT_explicit "true if explicit in density and temperature";
  constant Boolean pT_explicit "true if explicit in pressure and temperature";
  
  redeclare replaceable model extends BaseProperties(
    h(stateSelect=if ph_explicit and preferredMediumStates then StateSelect.prefer else StateSelect.default),
    d(stateSelect=if dT_explicit and preferredMediumStates then StateSelect.prefer else StateSelect.default),
    T(stateSelect=if (pT_explicit or dT_explicit) and preferredMediumStates then StateSelect.prefer else StateSelect.default),
    p(stateSelect=if (pT_explicit or ph_explicit) and preferredMediumStates then StateSelect.prefer else StateSelect.default)) 
    "Base properties of water" 
    Integer phase(min=0, max=2, start=1,fixed=false) 
      "2 for two-phase, 1 for one-phase, 0 if not known";
    annotation (structurallyIncomplete);
    SaturationProperties sat(Tsat(start=300.0), psat(start=1.0e5)) 
      "saturation temperature and pressure";
  equation 
    MM = fluidConstants[1].molarMass;
    if smoothModel then
      if onePhase then
        phase = 1;
        if ph_explicit then
          assert(((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
    fluidConstants[1].criticalPressure),
   "With onePhase=true this model may only be called with one-phase states h < hl or h > hv!"
   + "(p = " + String(p) + ", h = " + String(h) + ")");
        else
   if dT_explicit then
     assert(not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T <
   fluidConstants[1].criticalTemperature),
     "With onePhase=true this model may only be called with one-phase states d > dl or d < dv!"
     + "(d = " + String(d) + ", T = " + String(T) + ")");
   else
     assert(true,"no events for pT-model");
   end if;
        end if;
      else
        phase = 0;
      end if;
    else
      if ph_explicit then
        phase = if ((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
          fluidConstants[1].criticalPressure) then 1 else 2;
      elseif dT_explicit then
        phase = if not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T
           < fluidConstants[1].criticalTemperature) then 1 else 2;
      else
        phase = 1;
        //this is for the one-phase only case pT
      end if;
    end if;
    if dT_explicit then
      p = p_dT(d, T, phase);
      h = h_dT(d, T, phase);
      sat.Tsat = T;
      sat.psat = saturationPressure(T);
    elseif ph_explicit then
      d = rho_ph(p, h, phase);
      T = T_ph(p, h, phase);
      sat.Tsat = saturationTemperature(p);
      sat.psat = p;
    else
      h = h_pT(p, T);
      d = rho_pT(p, T);
      sat.psat = p;
      sat.Tsat = saturationTemperature(p);
    end if;
    u = h - p/d;
    R = Modelica.Constants.R/fluidConstants[1].molarMass;
    h = state.h;
    p = state.p;
    T = state.T;
    d = state.d;
    phase = state.phase;
  end BaseProperties;
  
  redeclare function extends rho_ph 
    "compute density as a function of pressure and specific enthalpy" 
  algorithm 
    d := IF97_Utilities.rho_ph(p, h, phase);
  end rho_ph;
  
  redeclare function extends T_ph 
    "compute temperature as a function of pressure and specific enthalpy" 
  algorithm 
    T := IF97_Utilities.T_ph(p, h, phase);
  end T_ph;
  
  redeclare function extends p_dT 
    "compute pressure as a function of density and temperature" 
  algorithm 
    p := IF97_Utilities.p_dT(d, T, phase);
  end p_dT;
  
  redeclare function extends h_dT 
    "compute specific enthalpy as a function of density and temperature" 
  algorithm 
    h := IF97_Utilities.h_dT(d, T, phase);
  end h_dT;
  
  redeclare function extends h_pT 
    "compute specific enthalpy as a function of pressure and temperature" 
  algorithm 
    h := IF97_Utilities.h_pT(p, T);
  end h_pT;
  
  redeclare function extends rho_pT 
    "compute density as a function of pressure and temperature" 
  algorithm 
    d := IF97_Utilities.rho_pT(p, T);
  end rho_pT;
  
  redeclare function extends setDewState 
    "set the thermodynamic state on the dew line" 
  algorithm 
    state := ThermodynamicState(
       phase=  phase,
       p=  sat.psat,
       T=  sat.Tsat,
       h=  dewEnthalpy(sat),
       d=  dewDensity(sat));
  end setDewState;
  
  redeclare function extends setBubbleState 
    "set the thermodynamic state on the bubble line" 
  algorithm 
    state := ThermodynamicState(
       phase=  phase,
       p=  sat.psat,
       T=  sat.Tsat,
       h=  bubbleEnthalpy(sat),
       d=  bubbleDensity(sat));
  end setBubbleState;
  
  redeclare function extends dynamicViscosity "Dynamic viscosity of water" 
  algorithm 
    eta := IF97_Utilities.dynamicViscosity(state.d, state.T, state.p, state.
      phase);
  end dynamicViscosity;
  
  redeclare function extends thermalConductivity 
    "Thermal conductivity of water" 
  algorithm 
    lambda := IF97_Utilities.thermalConductivity(state.d, state.T, state.p,
      state.phase);
  end thermalConductivity;
  
  redeclare function extends surfaceTension 
    "Surface tension in two phase region of water" 
  algorithm 
    sigma := IF97_Utilities.surfaceTension(sat.Tsat);
  end surfaceTension;
  
  redeclare function extends entropy "specific entropy of water" 
  algorithm 
    if dT_explicit then
      s := IF97_Utilities.s_dT(state.d, state.T, state.phase);
    elseif pT_explicit then
      s := IF97_Utilities.s_pT(state.p, state.T);
    else
      s := IF97_Utilities.s_ph(state.p, state.h, state.phase);
    end if;
  end entropy;
  
  redeclare function extends heatCapacityCp 
    "specific heat capacity at constant pressure of water" 
      annotation (Documentation(info="<html><body>
                                <p>In the two phase region this function returns the interpolated heat capacity between the
                                liquid and vapour state heat capacities.</p>
                          </body><html>"));
  algorithm 
    if dT_explicit then
      cp := IF97_Utilities.cp_dT(state.d, state.T, state.phase);
    elseif pT_explicit then
      cp := IF97_Utilities.cp_pT(state.p, state.T);
    else
      cp := IF97_Utilities.cp_ph(state.p, state.h, state.phase);
    end if;
  end heatCapacityCp;
  
  redeclare function extends heatCapacityCv 
    "specific heat capacity at constant volume of water" 
  algorithm 
    if dT_explicit then
      cv := IF97_Utilities.cv_dT(state.d, state.T, state.phase);
    elseif pT_explicit then
      cv := IF97_Utilities.cv_pT(state.p, state.T);
    else
      cv := IF97_Utilities.cv_ph(state.p, state.h, state.phase);
    end if;
  end heatCapacityCv;
  
  redeclare function extends isentropicExponent "Return isentropic exponent" 
  algorithm 
    if dT_explicit then
      gamma := IF97_Utilities.isentropicExponent_dT(state.d, state.T, state.
        phase);
    elseif pT_explicit then
      gamma := IF97_Utilities.isentropicExponent_pT(state.p, state.T);
    else
      gamma := IF97_Utilities.isentropicExponent_ph(state.p, state.h, state.
        phase);
    end if;
  end isentropicExponent;
  
  redeclare function extends isothermalCompressibility 
    "Isothermal compressibility of water" 
  algorithm 
    if dT_explicit then
      kappa := IF97_Utilities.kappa_dT(state.d, state.T, state.phase);
    elseif pT_explicit then
      kappa := IF97_Utilities.kappa_pT(state.p, state.T);
    else
      kappa := IF97_Utilities.kappa_ph(state.p, state.h, state.phase);
    end if;
  end isothermalCompressibility;
  
  redeclare function extends isobaricExpansionCoefficient 
    "isobaric expansion coefficient of water" 
  algorithm 
    if dT_explicit then
      beta := IF97_Utilities.beta_dT(state.d, state.T, state.phase);
    elseif pT_explicit then
      beta := IF97_Utilities.beta_pT(state.p, state.T);
    else
      beta := IF97_Utilities.beta_ph(state.p, state.h, state.phase);
    end if;
  end isobaricExpansionCoefficient;
  
  redeclare function extends velocityOfSound 
  algorithm 
    if dT_explicit then
      a := IF97_Utilities.velocityOfSound_dT(state.d, state.T, state.phase);
    elseif pT_explicit then
      a := IF97_Utilities.velocityOfSound_pT(state.p, state.T);
    else
      a := IF97_Utilities.velocityOfSound_ph(state.p, state.h, state.phase);
    end if;
  end velocityOfSound;
  
  redeclare function extends isentropicEnthalpy "compute h(p,s)" 
  algorithm 
    h_is := IF97_Utilities.isentropicEnthalpy(p_downstream, entropy(
      refState), 0);
  end isentropicEnthalpy;
  
  redeclare function extends density_derh_p 
    "density derivative by specific enthalpy" 
  algorithm 
    ddhp := IF97_Utilities.ddhp(state.p, state.h, state.phase);
  end density_derh_p;
  
  redeclare function extends density_derp_h "density derivative by pressure" 
  algorithm 
    ddph := IF97_Utilities.ddph(state.p, state.h, state.phase);
  end density_derp_h;
  
  redeclare function extends bubbleEnthalpy 
    "boiling curve specific enthalpy of water" 
  algorithm 
    hl := IF97_Utilities.BaseIF97.Regions.hl_p(sat.psat);
  end bubbleEnthalpy;
  
  redeclare function extends dewEnthalpy "dew curve specific enthalpy of water" 
  algorithm 
    hv := IF97_Utilities.BaseIF97.Regions.hv_p(sat.psat);
  end dewEnthalpy;
  
  redeclare function extends bubbleEntropy 
    "boiling curve specific entropy of water" 
  algorithm 
    sl := IF97_Utilities.BaseIF97.Regions.sl_p(sat.psat);
  end bubbleEntropy;
  
  redeclare function extends dewEntropy "dew curve specific entropy of water" 
  algorithm 
    sv := IF97_Utilities.BaseIF97.Regions.sv_p(sat.psat);
  end dewEntropy;
  
  redeclare function extends bubbleDensity 
    "boiling curve specific density of water" 
  algorithm 
    if ph_explicit or pT_explicit then
      dl := IF97_Utilities.BaseIF97.Regions.rhol_p(sat.psat);
    else
      dl := IF97_Utilities.BaseIF97.Regions.rhol_T(sat.Tsat);
    end if;
  end bubbleDensity;
  
  redeclare function extends dewDensity "dew curve specific density of water" 
  algorithm 
    if ph_explicit or pT_explicit then
      dv := IF97_Utilities.BaseIF97.Regions.rhov_p(sat.psat);
    else
      dv := IF97_Utilities.BaseIF97.Regions.rhov_T(sat.Tsat);
    end if;
  end dewDensity;
  
  redeclare function extends saturationTemperature 
    "saturation temperature of water" 
  algorithm 
    T := IF97_Utilities.BaseIF97.Basic.tsat(p);
  end saturationTemperature;
  
  redeclare function extends saturationTemperature_derp 
    "derivative of saturation temperature w.r.t. pressure" 
  algorithm 
    dTp := IF97_Utilities.BaseIF97.Basic.dtsatofp(p);
  end saturationTemperature_derp;
  
  redeclare function extends saturationPressure "saturation pressure of water" 
  algorithm 
    p := IF97_Utilities.BaseIF97.Basic.psat(T);
  end saturationPressure;
  
  redeclare function extends dBubbleDensity_dPressure 
    "bubble point density derivative" 
  algorithm 
    ddldp := IF97_Utilities.BaseIF97.Regions.drhol_dp(sat.psat);
  end dBubbleDensity_dPressure;
  
  redeclare function extends dDewDensity_dPressure 
    "dew point density derivative" 
  algorithm 
    ddvdp := IF97_Utilities.BaseIF97.Regions.drhov_dp(sat.psat);
  end dDewDensity_dPressure;
  
  redeclare function extends dBubbleEnthalpy_dPressure 
    "bubble point specific enthalpy derivative" 
  algorithm 
    dhldp := IF97_Utilities.BaseIF97.Regions.dhl_dp(sat.psat);
  end dBubbleEnthalpy_dPressure;
  
  redeclare function extends dDewEnthalpy_dPressure 
    "dew point specific enthalpy derivative" 
  algorithm 
    dhvdp := IF97_Utilities.BaseIF97.Regions.dhv_dp(sat.psat);
  end dDewEnthalpy_dPressure;
  
end WaterIF97_base;

partial package WaterIF97_fixedregion 
  "Water: Steam properties as defined by IAPWS/IF97 standard" 
  annotation (Icon(Text(
        extent=[-94, 84; 94, 40],
        style(color=71),
        string="IF97"), Text(
        extent=[-94, 20; 94, -24],
        style(color=71),
        string="water")), Documentation(info="<HTML>
<p>
This model calculates medium properties 
for water in the <b>liquid</b>, <b>gas</b> and <b>two phase</b> regions 
according to the IAPWS/IF97 standard, i.e., the accepted industrial standard
and best compromise between accuracy and computation time.
For more details see <a href=\"Modelica.Media.Water.IF97_Utilities\">
Modelica.Media.Water.IF97_Utilities</a>. Three variable pairs can be the 
independent variables of the model:
<ol>
<li>Pressure <b>p</b> and specific enthalpy <b>h</b> are the most natural choice for general applications. This is the recommended choice for most general purpose applications, in particular for power plants.</li>
<li>Pressure <b>p</b> and temperature <b>T</b> are the most natural choice for applications where water is always in the same phase, both for liquid water and steam.</li>
<li>Density <b>d</b> and temperature <b>T</b> are explicit variables of the Helmholtz function in the near-critical region and can be the best choice for applications with super-critical or near-critial states.</li>
</ol>
The following quantities are always computed:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Variable</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>T</td>
      <td>K</td>
      <td>temperature</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>specific internal energy</b></td></tr>
  <tr><td>d</td>
      <td>kg/m^3</td>
      <td>density</td></tr>
  <tr><td>p</td>
      <td>Pa</td>
      <td>pressure</td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>specific enthalpy</b></td></tr>
</table>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the functions listed in 
<a href=\"Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">
Modelica.Media.UsersGuide.MediumUsage.OptionalProperties</a> and in
<a href=\"Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">
Modelica.Media.UsersGuide.MediumUsage.TwoPhase</a>.
</p>
</p>
<p>Many further properties can be computed. Using the well-known Bridgman's Tables, all first partial derivatives of the standard thermodynamic variables can be computed easily.
</p>
</HTML>
"));
  extends Interfaces.PartialTwoPhaseMedium(
     mediumName="WaterIF97",
     substanceNames={"water"},
     singleState=false,
     final reducedX=true,
     SpecificEnthalpy(start=1.0e5, nominal=5.0e5),
     Density(start=150, nominal=500),
     AbsolutePressure(start=50e5, nominal=10e5),
     Temperature(start=500, nominal=500),
     smoothModel=false,
     onePhase=false,
     fluidConstants = waterConstants);
  
  redeclare record extends ThermodynamicState "thermodynamic state" 
    SpecificEnthalpy h "specific enthalpy";
    Density d "density";
    Temperature T "temperature";
    AbsolutePressure p "pressure";
  end ThermodynamicState;
  
  constant Integer Region "region of IF97, if known";
  constant Boolean ph_explicit 
    "true if explicit in pressure and specific enthalpy";
  constant Boolean dT_explicit "true if explicit in density and temperature";
  constant Boolean pT_explicit "true if explicit in pressure and temperature";
  
  redeclare replaceable model extends BaseProperties(
    h(stateSelect=if ph_explicit then StateSelect.prefer else StateSelect.default),
    d(stateSelect=if dT_explicit then StateSelect.prefer else StateSelect.default),
    T(stateSelect=if (pT_explicit or dT_explicit) then StateSelect.prefer else StateSelect.default),
    p(stateSelect=if (pT_explicit or ph_explicit) then StateSelect.prefer else StateSelect.default)) 
    "Base properties of water" 
    Integer phase(min=0, max=2) 
      "2 for two-phase, 1 for one-phase, 0 if not known";
    annotation (structurallyIncomplete);
    SaturationProperties sat(Tsat(start=300.0), psat(start=1.0e5)) 
      "saturation temperature and pressure";
  equation 
    MM = fluidConstants[1].molarMass;
    if smoothModel then
      if onePhase then
        phase = 1;
        if ph_explicit then
          assert(((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
            fluidConstants[1].criticalPressure),
            "With onePhase=true this model may only be called with one-phase states h < hl or h > hv!");
        else
          assert(not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T <
            fluidConstants[1].criticalTemperature),
            "With onePhase=true this model may only be called with one-phase states d > dl or d < dv!");
        end if;
      else
        phase = 0;
      end if;
    else
      if ph_explicit then
        phase = if ((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
          fluidConstants[1].criticalPressure) then 1 else 2;
      elseif dT_explicit then
        phase = if not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T
           < fluidConstants[1].criticalTemperature) then 1 else 2;
      else
        phase = 1;
        //this is for the one-phase only case pT
      end if;
    end if;
    if dT_explicit then
      p = p_dT(d, T, phase, Region);
      h = h_dT(d, T, phase, Region);
      sat.Tsat = T;
      sat.psat = saturationPressure(T);
    elseif ph_explicit then
      d = rho_ph(p, h, phase, Region);
      T = T_ph(p, h, phase, Region);
      sat.Tsat = saturationTemperature(p);
      sat.psat = p;
    else
      h = h_pT(p, T, Region);
      d = rho_pT(p, T, Region);
      sat.psat = p;
      sat.Tsat = saturationTemperature(p);
    end if;
    u = h - p/d;
    R = Modelica.Constants.R/fluidConstants[1].molarMass;
    h = state.h;
    p = state.p;
    T = state.T;
    d = state.d;
    phase = state.phase;
  end BaseProperties;
  
  redeclare function extends rho_ph 
    "compute density as a function of pressure and specific enthalpy" 
    input Integer region=0 
      "if 0, region is unknown, otherwise known and this input";
  algorithm 
    d := IF97_Utilities.rho_ph(p, h, phase, region);
  end rho_ph;
  
  redeclare function extends T_ph 
    "compute temperature as a function of pressure and specific enthalpy" 
    input Integer region=0 
      "if 0, region is unknown, otherwise known and this input";
  algorithm 
    T := IF97_Utilities.T_ph(p, h, phase, region);
  end T_ph;
  
  redeclare function extends p_dT 
    "compute pressure as a function of density and temperature" 
    input Integer region=0 
      "if 0, region is unknown, otherwise known and this input";
  algorithm 
    p := IF97_Utilities.p_dT(d, T, phase, region);
  end p_dT;
  
  redeclare function extends h_dT 
    "compute specific enthalpy as a function of density and temperature" 
    input Integer region=0 
      "if 0, region is unknown, otherwise known and this input";
  algorithm 
    h := IF97_Utilities.h_dT(d, T, phase, region);
  end h_dT;
  
  redeclare function extends h_pT 
    "compute specific enthalpy as a function of pressure and temperature" 
    input Integer region=0 
      "if 0, region is unknown, otherwise known and this input";
  algorithm 
    h := IF97_Utilities.h_pT(p, T, region);
  end h_pT;
  
  redeclare function extends rho_pT 
    "compute density as a function of pressure and temperature" 
    input Integer region=0 
      "if 0, region is unknown, otherwise known and this input";
  algorithm 
    d := IF97_Utilities.rho_pT(p, T, region);
  end rho_pT;
  
  redeclare function extends setDewState 
    "set the thermodynamic state on the dew line" 
  algorithm 
    state.phase := phase;
    state.p := sat.psat;
    state.T := sat.Tsat;
    state.h := dewEnthalpy(sat);
    state.d := dewDensity(sat);
  end setDewState;
  
  redeclare function extends setBubbleState 
    "set the thermodynamic state on the bubble line" 
  algorithm 
    state.phase := phase;
    state.p := sat.psat;
    state.T := sat.Tsat;
    state.h := bubbleEnthalpy(sat);
    state.d := bubbleDensity(sat);
  end setBubbleState;
  
  redeclare function extends dynamicViscosity "Dynamic viscosity of water" 
  algorithm 
    eta := IF97_Utilities.dynamicViscosity(state.d, state.T, state.p, state.phase);
  end dynamicViscosity;
  
  redeclare function extends thermalConductivity 
    "Thermal conductivity of water" 
  algorithm 
    lambda := IF97_Utilities.thermalConductivity(state.d, state.T, state.p,
      state.phase);
  end thermalConductivity;
  
  redeclare function extends surfaceTension 
    "Surface tension in two phase region of water" 
  algorithm 
    sigma := IF97_Utilities.surfaceTension(sat.Tsat);
  end surfaceTension;
  
  redeclare function extends entropy "specific entropy of water" 
  algorithm 
    if dT_explicit then
      s := IF97_Utilities.s_dT(state.d, state.T, state.phase, Region);
    elseif pT_explicit then
      s := IF97_Utilities.s_pT(state.p, state.T, Region);
    else
      s := IF97_Utilities.s_ph(state.p, state.h, state.phase, Region);
    end if;
  end entropy;
  
  redeclare function extends heatCapacityCp 
    "specific heat capacity at constant pressure of water" 
  algorithm 
    if dT_explicit then
      cp := IF97_Utilities.cp_dT(state.d, state.T, Region);
    elseif pT_explicit then
      cp := IF97_Utilities.cp_pT(state.p, state.T, Region);
    else
      cp := IF97_Utilities.cp_ph(state.p, state.h, Region);
    end if;
  end heatCapacityCp;
  
  redeclare function extends heatCapacityCv 
    "specific heat capacity at constant volume of water" 
  algorithm 
    if dT_explicit then
      cv := IF97_Utilities.cv_dT(state.d, state.T, state.phase, Region);
    elseif pT_explicit then
      cv := IF97_Utilities.cv_pT(state.p, state.T, Region);
    else
      cv := IF97_Utilities.cv_ph(state.p, state.h, state.phase, Region);
    end if;
  end heatCapacityCv;
  
  redeclare function extends isentropicExponent "Return isentropic exponent" 
  algorithm 
    if dT_explicit then
      gamma := IF97_Utilities.isentropicExponent_dT(state.d, state.T,
          state.phase, Region);
    elseif pT_explicit then
      gamma := IF97_Utilities.isentropicExponent_pT(state.p, state.T, Region);
    else
      gamma := IF97_Utilities.isentropicExponent_ph(state.p, state.h,
          state.phase, Region);
    end if;
  end isentropicExponent;
  
  redeclare function extends isothermalCompressibility 
    "Isothermal compressibility of water" 
  algorithm 
    //    assert(state.phase <> 2, "isothermal compressibility can not be computed with 2-phase inputs!");
    if dT_explicit then
      kappa := IF97_Utilities.kappa_dT(state.d, state.T, state.phase, Region);
    elseif pT_explicit then
      kappa := IF97_Utilities.kappa_pT(state.p, state.T, Region);
    else
      kappa := IF97_Utilities.kappa_ph(state.p, state.h, state.phase, Region);
    end if;
  end isothermalCompressibility;
  
  redeclare function extends isobaricExpansionCoefficient 
    "isobaric expansion coefficient of water" 
  algorithm 
    //    assert(state.phase <> 2, "the isobaric expansion coefficient can not be computed with 2-phase inputs!");
    if dT_explicit then
      beta := IF97_Utilities.beta_dT(state.d, state.T, state.phase, Region);
    elseif pT_explicit then
      beta := IF97_Utilities.beta_pT(state.p, state.T, Region);
    else
      beta := IF97_Utilities.beta_ph(state.p, state.h, state.phase, Region);
    end if;
  end isobaricExpansionCoefficient;
  
  redeclare function extends velocityOfSound 
  algorithm 
    if dT_explicit then
      a := IF97_Utilities.velocityOfSound_dT(state.d, state.T, state.phase,
        Region);
    elseif pT_explicit then
      a := IF97_Utilities.velocityOfSound_pT(state.p, state.T, Region);
    else
      a := IF97_Utilities.velocityOfSound_ph(state.p, state.h, state.phase,
        Region);
    end if;
  end velocityOfSound;
  
  redeclare function extends isentropicEnthalpy "compute h(s,p)" 
  algorithm 
    h_is := IF97_Utilities.isentropicEnthalpy(p_downstream, entropy(
      refState), 0);
  end isentropicEnthalpy;
  
  redeclare function extends density_derh_p 
    "density derivative by specific enthalpy" 
  algorithm 
    ddhp := IF97_Utilities.ddhp(state.p, state.h, state.phase, Region);
  end density_derh_p;
  
  redeclare function extends density_derp_h "density derivative by pressure" 
  algorithm 
    ddph := IF97_Utilities.ddph(state.p, state.h, state.phase, Region);
  end density_derp_h;
  
  redeclare function extends bubbleEnthalpy 
    "boiling curve specific enthalpy of water" 
  algorithm 
    hl := IF97_Utilities.BaseIF97.Regions.hl_p(sat.psat);
  end bubbleEnthalpy;
  
  redeclare function extends dewEnthalpy "dew curve specific enthalpy of water" 
  algorithm 
    hv := IF97_Utilities.BaseIF97.Regions.hv_p(sat.psat);
  end dewEnthalpy;
  
  redeclare function extends bubbleEntropy 
    "boiling curve specific entropy of water" 
  algorithm 
    sl := IF97_Utilities.BaseIF97.Regions.sl_p(sat.psat);
  end bubbleEntropy;
  
  redeclare function extends dewEntropy "dew curve specific entropy of water" 
  algorithm 
    sv := IF97_Utilities.BaseIF97.Regions.sv_p(sat.psat);
  end dewEntropy;
  
  redeclare function extends bubbleDensity 
    "boiling curve specific density of water" 
  algorithm 
    if ph_explicit or pT_explicit then
      dl := IF97_Utilities.BaseIF97.Regions.rhol_p(sat.psat);
    else
      dl := IF97_Utilities.BaseIF97.Regions.rhol_T(sat.Tsat);
    end if;
  end bubbleDensity;
  
  redeclare function extends dewDensity "dew curve specific density of water" 
  algorithm 
    if ph_explicit or pT_explicit then
      dv := IF97_Utilities.BaseIF97.Regions.rhov_p(sat.psat);
    else
      dv := IF97_Utilities.BaseIF97.Regions.rhov_T(sat.Tsat);
    end if;
  end dewDensity;
  
  redeclare function extends saturationTemperature 
    "saturation temperature of water" 
  algorithm 
    T := IF97_Utilities.BaseIF97.Basic.tsat(p);
  end saturationTemperature;
  
  redeclare function extends saturationTemperature_derp 
    "derivative of saturation temperature w.r.t. pressure" 
  algorithm 
    dTp := IF97_Utilities.BaseIF97.Basic.dtsatofp(p);
  end saturationTemperature_derp;
  
  redeclare function extends saturationPressure "saturation pressure of water" 
  algorithm 
    p := IF97_Utilities.BaseIF97.Basic.psat(T);
  end saturationPressure;
  
  redeclare function extends dBubbleDensity_dPressure 
    "bubble point density derivative" 
  algorithm 
    ddldp := IF97_Utilities.BaseIF97.Regions.drhol_dp(sat.psat);
  end dBubbleDensity_dPressure;
  
  redeclare function extends dDewDensity_dPressure 
    "dew point density derivative" 
  algorithm 
    ddvdp := IF97_Utilities.BaseIF97.Regions.drhov_dp(sat.psat);
  end dDewDensity_dPressure;
  
  redeclare function extends dBubbleEnthalpy_dPressure 
    "bubble point specific enthalpy derivative" 
  algorithm 
    dhldp := IF97_Utilities.BaseIF97.Regions.dhl_dp(sat.psat);
  end dBubbleEnthalpy_dPressure;
  
  redeclare function extends dDewEnthalpy_dPressure 
    "dew point specific enthalpy derivative" 
  algorithm 
    dhvdp := IF97_Utilities.BaseIF97.Regions.dhv_dp(sat.psat);
  end dDewEnthalpy_dPressure;
  
end WaterIF97_fixedregion;

package WaterIF97_R1ph "region 1 (liquid) water according to IF97 standard" 
  extends WaterIF97_fixedregion(
    final Region=1,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=true);
end WaterIF97_R1ph;

package WaterIF97_R2ph "region 2 (steam) water according to IF97 standard" 
  extends WaterIF97_fixedregion(
    final Region=2,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=true);
end WaterIF97_R2ph;

package WaterIF97_R3ph "region 3 water according to IF97 standard" 
  extends WaterIF97_fixedregion(
    final Region=3,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=true);
end WaterIF97_R3ph;

package WaterIF97_R4ph "region 4 water according to IF97 standard" 
  extends WaterIF97_fixedregion(
    final Region=4,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=false);
end WaterIF97_R4ph;

package WaterIF97_R5ph "region 5 water according to IF97 standard" 
  extends WaterIF97_fixedregion(
    final Region=5,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=true);
end WaterIF97_R5ph;

package WaterIF97_R1pT "region 1 (liquid) water according to IF97 standard" 
  extends WaterIF97_fixedregion(
    final Region=1,
    final ph_explicit=false,
    final dT_explicit=false,
    final pT_explicit=true,
    smoothModel=true,
    onePhase=true);
end WaterIF97_R1pT;

package WaterIF97_R2pT "region 2 (steam) water according to IF97 standard" 
  extends WaterIF97_fixedregion(
    final Region=2,
    final ph_explicit=false,
    final dT_explicit=false,
    final pT_explicit=true,
    smoothModel=true,
    onePhase=true);
end WaterIF97_R2pT;
end Water;
