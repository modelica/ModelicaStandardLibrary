package Water "Medium models for water"
extends Modelica.Icons.Library;
  constant Interfaces.PartialMedium.FluidConstants waterConstants(
      chemicalFormula =                                                           "H2O",
          structureFormula="H2O",
          casRegistryNumber="7732-18-5",
          iupacName="oxidane",
          molarMass=0.018015268,
          criticalTemperature=647.096,
          criticalPressure=22064.0e3,
          criticalMolarVolume=1/(322.0*0.018015268),
          normalBoilingPoint=373.124,
          meltingPoint=273.15,
          triplePointTemperature=273.16,
          triplePointPressure=611.657,
          acentricFactor = 0.0,
          dipoleMoment = 0.0,
          hasCriticalData=true);


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
      MM_const=0.018015268);
  constant FluidConstants fluidConstants = waterConstants;
  
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
/*
package WaterIF97_dT "Water using the IF97 standard, explicit in d and T" 
  extends WaterIF97_base(
    final ph_explicit=false,
    final dT_explicit=true,
    final pT_explicit=false,
    smoothModel=false,
    onePhase=false);
end WaterIF97_dT;
*/

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
For more details see <a href=\"Modelica:Modelica.Media.Water.IF97_Utilities\">
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
one of the functions listed in the following table
(for more details, see 
<a href=\"Modelica:Modelica.Media.Tutorial.MediumUsage.OptionalProperties\">
Modelica.Media.Tutorial.Medium usage.Optional properties</a>).
In the table it is assumed that there are declarations of the
form:
<pre>
   <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium;
   Medium.BaseProperties medium;
</pre>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Variable</b></td>
      <td><b>Function call</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>s</td>
      <td>= Medium.specificEntropy(medium)</b></td>
      <td>J/(kg.K)</td>
      <td>specific entropy</td></tr>
  <tr><td>cp</td>
      <td>= Medium.heatCapacity_cp(medium)</b></td>
      <td>J/(kg.K)</td>
      <td>heat capacity at constant pressure</td></tr>
  <tr><td>cv</td>
      <td>= Medium.cv(medium)</b></td>
      <td>J/(kg.K)</td>
      <td>heat capacity at constant volume</td></tr>
  <tr><td>eta</td>
      <td>= Medium.dynamicViscosity(medium)</b></td>
      <td>Pa.s</td>
      <td>dynamic viscosity</td></tr>
  <tr><td>lambda</td>
      <td>= Medium.thermalConductivity(medium)</td>
      <td>W/(m.K)</td>
      <td>thermal conductivity</td></tr>
  <tr><td>sigma</td>
      <td>= Medium.surfaceTension(medium)</td>
      <td>N/m</td>
      <td>surface tension</td></tr>
</table>
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
     onePhase=false);
  
  constant FluidConstants fluidConstants = waterConstants;
  
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
    MM = fluidConstants.molarMass;
    if smoothModel then
      if onePhase then
        phase = 1;
        if ph_explicit then
          assert(((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
    fluidConstants.criticalPressure),
   "With onePhase=true this model may only be called with one-phase states h < hl or h > hv!"
   + "(p = " + String(p) + ", h = " + String(h) + ")");
        else
   if dT_explicit then
     assert(not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T <
   fluidConstants.criticalTemperature),
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
          fluidConstants.criticalPressure) then 1 else 2;
      elseif dT_explicit then
        phase = if not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T
           < fluidConstants.criticalTemperature) then 1 else 2;
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
    R = Modelica.Constants.R/fluidConstants.molarMass;
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
  
  redeclare function extends specificEntropy "specific entropy of water" 
  algorithm 
    if dT_explicit then
      s := IF97_Utilities.s_dT(state.d, state.T, state.phase);
    elseif pT_explicit then
      s := IF97_Utilities.s_pT(state.p, state.T);
    else
      s := IF97_Utilities.s_ph(state.p, state.h, state.phase);
    end if;
  end specificEntropy;
  
  redeclare function extends heatCapacity_cp 
    "specific heat capacity at constant pressure of water" 
  algorithm 
    //    assert(state.phase <> 2, "heat capacity at constant pressure can not be computed with 2-phase inputs!");
    if dT_explicit then
      cp := IF97_Utilities.cp_dT(state.d, state.T);
    elseif pT_explicit then
      cp := IF97_Utilities.cp_pT(state.p, state.T);
    else
      cp := IF97_Utilities.cp_ph(state.p, state.h);
    end if;
  end heatCapacity_cp;
  
  redeclare function extends heatCapacity_cv 
    "specific heat capacity at constant volume of water" 
  algorithm 
    if dT_explicit then
      cv := IF97_Utilities.cv_dT(state.d, state.T, state.phase);
    elseif pT_explicit then
      cv := IF97_Utilities.cv_pT(state.p, state.T);
    else
      cv := IF97_Utilities.cv_ph(state.p, state.h, state.phase);
    end if;
  end heatCapacity_cv;
  
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
    //    assert(state.phase <> 2, "isothermal compressibility can not be computed with 2-phase inputs!");
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
    //    assert(state.phase <> 2, "the isobaric expansion coefficient can not be computed with 2-phase inputs!");
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
  
  redeclare function extends isentropicEnthalpy "compute h(s,p)" 
  algorithm 
    h_is := IF97_Utilities.isentropicEnthalpy(p_downstream, specificEntropy(
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
For more details see <a href=\"Modelica:Modelica.Media.Water.IF97_Utilities\">
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
one of the functions listed in the following table
(for more details, see 
<a href=\"Modelica:Modelica.Media.Tutorial.MediumUsage.OptionalProperties\">
Modelica.Media.Tutorial.Medium usage.Optional properties</a>).
In the table it is assumed that there are declarations of the
form:
<pre>
   <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium;
   Medium.BaseProperties medium;
</pre>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Variable</b></td>
      <td><b>Function call</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>s</td>
      <td>= Medium.specificEntropy(medium)</b></td>
      <td>J/(kg.K)</td>
      <td>specific entropy</td></tr>
  <tr><td>cp</td>
      <td>= Medium.heatCapacity_cp(medium)</b></td>
      <td>J/(kg.K)</td>
      <td>heat capacity at constant pressure</td></tr>
  <tr><td>cv</td>
      <td>= Medium.cv(medium)</b></td>
      <td>J/(kg.K)</td>
      <td>heat capacity at constant volume</td></tr>
  <tr><td>eta</td>
      <td>= Medium.dynamicViscosity(medium)</b></td>
      <td>Pa.s</td>
      <td>dynamic viscosity</td></tr>
  <tr><td>lambda</td>
      <td>= Medium.thermalConductivity(medium)</td>
      <td>W/(m.K)</td>
      <td>thermal conductivity</td></tr>
  <tr><td>sigma</td>
      <td>= Medium.surfaceTension(medium)</td>
      <td>N/m</td>
      <td>surface tension</td></tr>
</table>
<p>Many further properties can be computed. Using the well-known Bridgman's Tables, all first partial derivatives of the standard thermodynamic variables can be computed easily.</p>
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
    onePhase=false);
  
  redeclare record extends ThermodynamicState "thermodynamic state" 
    SpecificEnthalpy h "specific enthalpy";
    Density d "density";
    Temperature T "temperature";
    AbsolutePressure p "pressure";
  end ThermodynamicState;
  
  constant FluidConstants fluidConstants = waterConstants;
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
    MM = fluidConstants.molarMass;
    if smoothModel then
      if onePhase then
        phase = 1;
        if ph_explicit then
          assert(((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
            fluidConstants.criticalPressure),
            "With onePhase=true this model may only be called with one-phase states h < hl or h > hv!");
        else
          assert(not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T <
            fluidConstants.criticalTemperature),
            "With onePhase=true this model may only be called with one-phase states d > dl or d < dv!");
        end if;
      else
        phase = 0;
      end if;
    else
      if ph_explicit then
        phase = if ((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
          fluidConstants.criticalPressure) then 1 else 2;
      elseif dT_explicit then
        phase = if not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T
           < fluidConstants.criticalTemperature) then 1 else 2;
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
    R = Modelica.Constants.R/fluidConstants.molarMass;
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
  
  redeclare function extends specificEntropy "specific entropy of water" 
  algorithm 
    if dT_explicit then
      s := IF97_Utilities.s_dT(state.d, state.T, state.phase, Region);
    elseif pT_explicit then
      s := IF97_Utilities.s_pT(state.p, state.T, Region);
    else
      s := IF97_Utilities.s_ph(state.p, state.h, state.phase, Region);
    end if;
  end specificEntropy;
  
  redeclare function extends heatCapacity_cp 
    "specific heat capacity at constant pressure of water" 
  algorithm 
    if dT_explicit then
      cp := IF97_Utilities.cp_dT(state.d, state.T, Region);
    elseif pT_explicit then
      cp := IF97_Utilities.cp_pT(state.p, state.T, Region);
    else
      cp := IF97_Utilities.cp_ph(state.p, state.h, Region);
    end if;
  end heatCapacity_cp;
  
  redeclare function extends heatCapacity_cv 
    "specific heat capacity at constant volume of water" 
  algorithm 
    if dT_explicit then
      cv := IF97_Utilities.cv_dT(state.d, state.T, state.phase, Region);
    elseif pT_explicit then
      cv := IF97_Utilities.cv_pT(state.p, state.T, Region);
    else
      cv := IF97_Utilities.cv_ph(state.p, state.h, state.phase, Region);
    end if;
  end heatCapacity_cv;
  
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
    h_is := IF97_Utilities.isentropicEnthalpy(p_downstream, specificEntropy(
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
