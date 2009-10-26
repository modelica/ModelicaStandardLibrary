within Modelica.Media;
package Water "Medium models for water"


extends Modelica.Icons.Library;
  constant Interfaces.PartialTwoPhaseMedium.FluidConstants[1] waterConstants(
     each chemicalFormula = "H2O",
     each structureFormula="H2O",
     each casRegistryNumber="7732-18-5",
     each iupacName="oxidane",
     each molarMass=0.018015268,
     each criticalTemperature=647.096,
     each criticalPressure=22064.0e3,
     each criticalMolarVolume=1/322.0*0.018015268,
     each normalBoilingPoint=373.124,
     each meltingPoint=273.15,
     each triplePointTemperature=273.16,
     each triplePointPressure=611.657,
     each acentricFactor = 0.344,
     each dipoleMoment = 1.8,
     each hasCriticalData=true);

  constant Interfaces.PartialMedium.FluidConstants[1] simpleWaterConstants(
     each chemicalFormula = "H2O",
     each structureFormula="H2O",
     each casRegistryNumber="7732-18-5",
     each iupacName="oxidane",
     each molarMass=0.018015268);


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
     fluidConstants = simpleWaterConstants);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-90,88},{90,18}},
          lineColor={0,0,0},
          textString="liquid"), Text(
          extent={{-90,-22},{90,-90}},
          lineColor={0,0,0},
          textString="water")}),
                            Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                    graphics),
    Documentation(info="<html>

</html>"));
end ConstantPropertyLiquidWater;


package IdealSteam "Water: Steam as ideal gas from NASA source"
  extends IdealGases.SingleGases.H2O(
  fluidConstants = waterConstants);
  annotation (Documentation(info="<html>

</html>"));
end IdealSteam;


package StandardWater = WaterIF97_ph
  "Water using the IF97 standard, explicit in p and h. Recommended for most applications";


package StandardWaterOnePhase = WaterIF97_pT
  "Water using the IF97 standard, explicit in p and T. Recommended for one-phase applications";


package WaterIF97OnePhase_ph
  "Water using the IF97 standard, explicit in p and h, and only valid outside the two-phase dome"
  extends WaterIF97_base(
    ThermoStates = Choices.IndependentVariables.ph,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    final smoothModel=true,
    final onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97OnePhase_ph;


package WaterIF97_pT "Water using the IF97 standard, explicit in p and T"
  extends WaterIF97_base(
    ThermoStates = Choices.IndependentVariables.pT,
    final ph_explicit=false,
    final dT_explicit=false,
    final pT_explicit=true,
    final smoothModel=true,
    final onePhase=true);
end WaterIF97_pT;


package WaterIF97_ph "Water using the IF97 standard, explicit in p and h"
  extends WaterIF97_base(
    ThermoStates = Choices.IndependentVariables.ph,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=false,
    onePhase=false);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_ph;


partial package WaterIF97_base
  "Water: Steam properties as defined by IAPWS/IF97 standard"

  extends Interfaces.PartialTwoPhaseMedium(
     mediumName="WaterIF97",
     substanceNames={"water"},
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
      p = pressure_dT(d, T, phase);
      h = specificEnthalpy_dT(d, T, phase);
      sat.Tsat = T;
      sat.psat = saturationPressure(T);
    elseif ph_explicit then
      d = density_ph(p, h, phase);
      T = temperature_ph(p, h, phase);
      sat.Tsat = saturationTemperature(p);
      sat.psat = p;
    else
      h = specificEnthalpy_pT(p, T);
      d = density_pT(p, T);
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

  redeclare function density_ph
    "Computes density as a function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Density";
  algorithm
    d := IF97_Utilities.rho_ph(p, h, phase);
  end density_ph;

  redeclare function temperature_ph
    "Computes temperature as a function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Temperature T "Temperature";
  algorithm
    T := IF97_Utilities.T_ph(p, h, phase);
  end temperature_ph;

  redeclare function temperature_ps
    "Compute temperature from pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Temperature T "Temperature";
  algorithm
    T := IF97_Utilities.T_ps(p, s, phase);
  end temperature_ps;

  redeclare function density_ps
    "Computes density as a function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "density";
  algorithm
    d := IF97_Utilities.rho_ps(p, s, phase);
  end density_ps;

  redeclare function pressure_dT
    "Computes pressure as a function of density and temperature"
    extends Modelica.Icons.Function;
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output AbsolutePressure p "Pressure";
  algorithm
    p := IF97_Utilities.p_dT(d, T, phase);
  end pressure_dT;

  redeclare function specificEnthalpy_dT
    "Computes specific enthalpy as a function of density and temperature"
    extends Modelica.Icons.Function;
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := IF97_Utilities.h_dT(d, T, phase);
  end specificEnthalpy_dT;

  redeclare function specificEnthalpy_pT
    "Computes specific enthalpy as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := IF97_Utilities.h_pT(p, T);
  end specificEnthalpy_pT;

  redeclare function specificEnthalpy_ps
    "Computes specific enthalpy as a function of pressure and temperature"
      extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := IF97_Utilities.h_ps(p, s, phase);
  end specificEnthalpy_ps;

  redeclare function density_pT
    "Computes density as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Density";
  algorithm
    d := IF97_Utilities.rho_pT(p, T);
  end density_pT;

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
    d := state.d;
  end density;

  redeclare function extends specificEnthalpy "Return specific enthalpy"
    extends Modelica.Icons.Function;
  algorithm
    h := state.h;
  end specificEnthalpy;

  redeclare function extends specificInternalEnergy
    "Return specific internal energy"
    extends Modelica.Icons.Function;
  algorithm
    u := state.h  - state.p/state.d;
  end specificInternalEnergy;

  redeclare function extends specificGibbsEnergy "Return specific Gibbs energy"
    extends Modelica.Icons.Function;
  algorithm
    g := state.h - state.T*specificEntropy(state);
  end specificGibbsEnergy;

  redeclare function extends specificHelmholtzEnergy
    "Return specific Helmholtz energy"
    extends Modelica.Icons.Function;
  algorithm
    f := state.h - state.p/state.d - state.T*specificEntropy(state);
  end specificHelmholtzEnergy;

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

  redeclare function extends specificHeatCapacityCp
    "specific heat capacity at constant pressure of water"

  algorithm
    if dT_explicit then
      cp := IF97_Utilities.cp_dT(state.d, state.T, state.phase);
    elseif pT_explicit then
      cp := IF97_Utilities.cp_pT(state.p, state.T);
    else
      cp := IF97_Utilities.cp_ph(state.p, state.h, state.phase);
    end if;
      annotation (Documentation(info="<html>
                                <p>In the two phase region this function returns the interpolated heat capacity between the
                                liquid and vapour state heat capacities.</p>
                          <html>"));
  end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv
    "specific heat capacity at constant volume of water"
  algorithm
    if dT_explicit then
      cv := IF97_Utilities.cv_dT(state.d, state.T, state.phase);
    elseif pT_explicit then
      cv := IF97_Utilities.cv_pT(state.p, state.T);
    else
      cv := IF97_Utilities.cv_ph(state.p, state.h, state.phase);
    end if;
  end specificHeatCapacityCv;

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
    "Return velocity of sound as a function of the thermodynamic state record"
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

  redeclare function extends setState_dTX
    "Return thermodynamic state of water as function of d and T"
  algorithm
    state := ThermodynamicState(
      d=d,
      T=T,
      phase=0,
      h=specificEnthalpy_dT(d,T),
      p=pressure_dT(d,T));
  end setState_dTX;

  redeclare function extends setState_phX
    "Return thermodynamic state of water as function of p and h"
  algorithm
    state := ThermodynamicState(
      d=density_ph(p,h),
      T=temperature_ph(p,h),
      phase=0,
      h=h,
      p=p);
  end setState_phX;

  redeclare function extends setState_psX
    "Return thermodynamic state of water as function of p and s"
  algorithm
    state := ThermodynamicState(
      d=density_ps(p,s),
      T=temperature_ps(p,s),
      phase=0,
      h=specificEnthalpy_ps(p,s),
      p=p);
  end setState_psX;

  redeclare function extends setState_pTX
    "Return thermodynamic state of water as function of p and T"
  algorithm
    state := ThermodynamicState(
      d=density_pT(p,T),
      T=T,
      phase=1,
      h=specificEnthalpy_pT(p,T),
      p=p);
  end setState_pTX;

      redeclare function extends setSmoothState
    "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
        import Modelica.Media.Common.smoothStep;
      algorithm
        state :=ThermodynamicState(
          p=smoothStep(x, state_a.p, state_b.p, x_small),
          h=smoothStep(x, state_a.h, state_b.h, x_small),
          d=density_ph(smoothStep(x, state_a.p, state_b.p, x_small),
                       smoothStep(x, state_a.h, state_b.h, x_small)),
          T=temperature_ph(smoothStep(x, state_a.p, state_b.p, x_small),
                           smoothStep(x, state_a.h, state_b.h, x_small)),
          phase=0);
      end setSmoothState;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-94,84},{94,40}},
          lineColor={127,191,255},
          textString="IF97"), Text(
          extent={{-94,20},{94,-24}},
          lineColor={127,191,255},
          textString="water")}),
                          Documentation(info="<HTML>
<p>
This model calculates medium properties
for water in the <b>liquid</b>, <b>gas</b> and <b>two phase</b> regions
according to the IAPWS/IF97 standard, i.e., the accepted industrial standard
and best compromise between accuracy and computation time.
For more details see <a href=\"Modelica://Modelica.Media.Water.IF97_Utilities\">
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
  <tr><td valign=\"top\"><b>Variable</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">T</td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">temperature</td></tr>
  <tr><td valign=\"top\">u</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific internal energy</b></td></tr>
  <tr><td valign=\"top\">d</td>
      <td valign=\"top\">kg/m^3</td>
      <td valign=\"top\">density</td></tr>
  <tr><td valign=\"top\">p</td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">pressure</td></tr>
  <tr><td valign=\"top\">h</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific enthalpy</b></td></tr>
</table>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the functions listed in
<a href=\"Modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">
Modelica.Media.UsersGuide.MediumUsage.OptionalProperties</a> and in
<a href=\"Modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">
Modelica.Media.UsersGuide.MediumUsage.TwoPhase</a>.
</p>
</p>
<p>Many further properties can be computed. Using the well-known Bridgman's Tables, all first partial derivatives of the standard thermodynamic variables can be computed easily.</p>
</HTML>
"));
end WaterIF97_base;


partial package WaterIF97_fixedregion
  "Water: Steam properties as defined by IAPWS/IF97 standard"

  extends Interfaces.PartialTwoPhaseMedium(
     mediumName="WaterIF97",
     substanceNames={"water"},
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
      p = pressure_dT(d, T, phase, Region);
      h = specificEnthalpy_dT(d, T, phase, Region);
      sat.Tsat = T;
      sat.psat = saturationPressure(T);
    elseif ph_explicit then
      d = density_ph(p, h, phase, Region);
      T = temperature_ph(p, h, phase, Region);
      sat.Tsat = saturationTemperature(p);
      sat.psat = p;
    else
      h = specificEnthalpy_pT(p, T, Region);
      d = density_pT(p, T, Region);
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

  redeclare function density_ph
    "Computes density as a function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=0
      "if 0, region is unknown, otherwise known and this input";
    output Density d "Density";
  algorithm
    d := IF97_Utilities.rho_ph(p, h, phase, region);
  end density_ph;

  redeclare function temperature_ph
    "Computes temperature as a function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=0
      "if 0, region is unknown, otherwise known and this input";
    output Temperature T "Temperature";
  algorithm
    T := IF97_Utilities.T_ph(p, h, phase, region);
  end temperature_ph;

  redeclare function temperature_ps
    "Compute temperature from pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=0
      "if 0, region is unknown, otherwise known and this input";
    output Temperature T "Temperature";
  algorithm
    T := IF97_Utilities.T_ps(p, s, phase,region);
  end temperature_ps;

  redeclare function density_ps
    "Computes density as a function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=0
      "if 0, region is unknown, otherwise known and this input";
    output Density d "density";
  algorithm
    d := IF97_Utilities.rho_ps(p, s, phase, region);
  end density_ps;

  redeclare function pressure_dT
    "Computes pressure as a function of density and temperature"
    extends Modelica.Icons.Function;
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=0
      "if 0, region is unknown, otherwise known and this input";
    output AbsolutePressure p "Pressure";
  algorithm
    p := IF97_Utilities.p_dT(d, T, phase, region);
  end pressure_dT;

  redeclare function specificEnthalpy_dT
    "Computes specific enthalpy as a function of density and temperature"
    extends Modelica.Icons.Function;
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=0
      "if 0, region is unknown, otherwise known and this input";
    output SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := IF97_Utilities.h_dT(d, T, phase, region);
  end specificEnthalpy_dT;

  redeclare function specificEnthalpy_pT
    "Computes specific enthalpy as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=0
      "if 0, region is unknown, otherwise known and this input";
    output SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := IF97_Utilities.h_pT(p, T, region);
  end specificEnthalpy_pT;

  redeclare function specificEnthalpy_ps
    "Computes specific enthalpy as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=0
      "if 0, region is unknown, otherwise known and this input";
    output SpecificEnthalpy h "specific enthalpy";
  algorithm
    h := IF97_Utilities.h_ps(p, s, phase, region);
  end specificEnthalpy_ps;

  redeclare function density_pT
    "Computes density as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=0
      "if 0, region is unknown, otherwise known and this input";
    output Density d "Density";
  algorithm
    d := IF97_Utilities.rho_pT(p, T, region);
  end density_pT;

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
    d := state.d;
  end density;

  redeclare function extends specificEnthalpy "Return specific enthalpy"
    extends Modelica.Icons.Function;
  algorithm
    h := state.h;
  end specificEnthalpy;

  redeclare function extends specificInternalEnergy
    "Return specific internal energy"
    extends Modelica.Icons.Function;
  algorithm
    u := state.h  - state.p/state.d;
  end specificInternalEnergy;

  redeclare function extends specificGibbsEnergy "Return specific Gibbs energy"
    extends Modelica.Icons.Function;
  algorithm
    g := state.h - state.T*specificEntropy(state);
  end specificGibbsEnergy;

  redeclare function extends specificHelmholtzEnergy
    "Return specific Helmholtz energy"
    extends Modelica.Icons.Function;
  algorithm
    f := state.h - state.p/state.d - state.T*specificEntropy(state);
  end specificHelmholtzEnergy;

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

  redeclare function extends specificHeatCapacityCp
    "specific heat capacity at constant pressure of water"
  algorithm
    if dT_explicit then
      cp := IF97_Utilities.cp_dT(state.d, state.T, Region);
    elseif pT_explicit then
      cp := IF97_Utilities.cp_pT(state.p, state.T, Region);
    else
      cp := IF97_Utilities.cp_ph(state.p, state.h, Region);
    end if;
  end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv
    "specific heat capacity at constant volume of water"
  algorithm
    if dT_explicit then
      cv := IF97_Utilities.cv_dT(state.d, state.T, state.phase, Region);
    elseif pT_explicit then
      cv := IF97_Utilities.cv_pT(state.p, state.T, Region);
    else
      cv := IF97_Utilities.cv_ph(state.p, state.h, state.phase, Region);
    end if;
  end specificHeatCapacityCv;

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
    "Return velocity of sound as a function of the thermodynamic state record"
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

  redeclare function extends setState_dTX
    "Return thermodynamic state of water as function of d, T, and optional region"
    input Integer region=0
      "if 0, region is unknown, otherwise known and this input";
  algorithm
    state := ThermodynamicState(
      d=d,
      T=T,
      phase= if region == 0 then IF97_Utilities.phase_dT(d,T) else if region == 4 then 2 else 1,
      h=specificEnthalpy_dT(d,T,region=region),
      p=pressure_dT(d,T,region=region));
  end setState_dTX;

  redeclare function extends setState_phX
    "Return thermodynamic state of water as function of p, h, and optional region"
    input Integer region=0
      "if 0, region is unknown, otherwise known and this input";
  algorithm
    state := ThermodynamicState(
      d=density_ph(p,h,region=region),
      T=temperature_ph(p,h,region=region),
      phase=if region == 0 then IF97_Utilities.phase_ph(p,h) else if region == 4 then 2 else 1,
      h=h,
      p=p);
  end setState_phX;

  redeclare function extends setState_psX
    "Return thermodynamic state of water as function of p, s, and optional region"
    input Integer region=0
      "if 0, region is unknown, otherwise known and this input";
  algorithm
    state := ThermodynamicState(
      d=density_ps(p,s,region=region),
      T=temperature_ps(p,s,region=region),
      phase=IF97_Utilities.phase_ps(p,s),
      h=specificEnthalpy_ps(p,s,region=region),
      p=p);
  end setState_psX;

  redeclare function extends setState_pTX
    "Return thermodynamic state of water as function of p, T, and optional region"
    input Integer region=0
      "if 0, region is unknown, otherwise known and this input";
  algorithm
    state := ThermodynamicState(
      d=density_pT(p,T,region=region),
      T=T,
      phase=1,
      h=specificEnthalpy_pT(p,T,region=region),
      p=p);
  end setState_pTX;

      redeclare function extends setSmoothState
    "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
        import Modelica.Media.Common.smoothStep;
      algorithm
        state :=ThermodynamicState(
          p=smoothStep(x, state_a.p, state_b.p, x_small),
          h=smoothStep(x, state_a.h, state_b.h, x_small),
          d=density_ph(smoothStep(x, state_a.p, state_b.p, x_small),
                       smoothStep(x, state_a.h, state_b.h, x_small)),
          T=temperature_ph(smoothStep(x, state_a.p, state_b.p, x_small),
                           smoothStep(x, state_a.h, state_b.h, x_small)),
          phase=0);
      end setSmoothState;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-94,84},{94,40}},
          lineColor={127,191,255},
          textString="IF97"), Text(
          extent={{-94,20},{94,-24}},
          lineColor={127,191,255},
          textString="water")}),
                          Documentation(info="<HTML>
<p>
This model calculates medium properties
for water in the <b>liquid</b>, <b>gas</b> and <b>two phase</b> regions
according to the IAPWS/IF97 standard, i.e., the accepted industrial standard
and best compromise between accuracy and computation time.
For more details see <a href=\"Modelica://Modelica.Media.Water.IF97_Utilities\">
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
  <tr><td valign=\"top\"><b>Variable</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">T</td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">temperature</td></tr>
  <tr><td valign=\"top\">u</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific internal energy</b></td></tr>
  <tr><td valign=\"top\">d</td>
      <td valign=\"top\">kg/m^3</td>
      <td valign=\"top\">density</td></tr>
  <tr><td valign=\"top\">p</td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">pressure</td></tr>
  <tr><td valign=\"top\">h</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific enthalpy</b></td></tr>
</table>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the functions listed in
<a href=\"Modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">
Modelica.Media.UsersGuide.MediumUsage.OptionalProperties</a> and in
<a href=\"Modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">
Modelica.Media.UsersGuide.MediumUsage.TwoPhase</a>.
</p>
</p>
<p>Many further properties can be computed. Using the well-known Bridgman's Tables, all first partial derivatives of the standard thermodynamic variables can be computed easily.
</p>
</HTML>
"));
end WaterIF97_fixedregion;


package WaterIF97_R1ph "region 1 (liquid) water according to IF97 standard"
  extends WaterIF97_fixedregion(
    ThermoStates = Choices.IndependentVariables.ph,
    final Region=1,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R1ph;


package WaterIF97_R2ph "region 2 (steam) water according to IF97 standard"
  extends WaterIF97_fixedregion(
    ThermoStates = Choices.IndependentVariables.ph,
    final Region=2,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R2ph;


package WaterIF97_R3ph "region 3 water according to IF97 standard"
  extends WaterIF97_fixedregion(
    final Region=3,
    ThermoStates = Choices.IndependentVariables.ph,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R3ph;


package WaterIF97_R4ph "region 4 water according to IF97 standard"
  extends WaterIF97_fixedregion(
    final Region=4,
    ThermoStates = Choices.IndependentVariables.ph,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=false);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R4ph;


package WaterIF97_R5ph "region 5 water according to IF97 standard"
  extends WaterIF97_fixedregion(
    ThermoStates = Choices.IndependentVariables.ph,
    final Region=5,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R5ph;


package WaterIF97_R1pT "region 1 (liquid) water according to IF97 standard"
  extends WaterIF97_fixedregion(
    ThermoStates = Choices.IndependentVariables.pT,
    final Region=1,
    final ph_explicit=false,
    final dT_explicit=false,
    final pT_explicit=true,
    smoothModel=true,
    onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R1pT;


package WaterIF97_R2pT "region 2 (steam) water according to IF97 standard"
  extends WaterIF97_fixedregion(
    ThermoStates = Choices.IndependentVariables.pT,
    final Region=2,
    final ph_explicit=false,
    final dT_explicit=false,
    final pT_explicit=true,
    smoothModel=true,
    onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R2pT;


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
<h4>Overview of WaterIF97 derived water models</h4>
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
  <tr><td valign=\"top\"><b>Variable</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">T</td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">temperature</td></tr>
  <tr><td valign=\"top\">u</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific internal energy</b></td></tr>
  <tr><td valign=\"top\">d</td>
      <td valign=\"top\">kg/m^3</td>
      <td valign=\"top\">density</td></tr>
  <tr><td valign=\"top\">p</td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">pressure</td></tr>
  <tr><td valign=\"top\">h</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific enthalpy</b></td></tr>
</table>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the following functions:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Function call</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">Medium.dynamicViscosity(medium.state)</b></td>
      <td valign=\"top\">Pa.s</td>
      <td valign=\"top\">dynamic viscosity</td></tr>
  <tr><td valign=\"top\">Medium.thermalConductivity(medium.state)</td>
      <td valign=\"top\">W/(m.K)</td>
      <td valign=\"top\">thermal conductivity</td></tr>
  <tr><td valign=\"top\">Medium.prandtlNumber(medium.state)</td>
      <td valign=\"top\">1</td>
      <td valign=\"top\">Prandtl number</td></tr>
  <tr><td valign=\"top\">Medium.specificEntropy(medium.state)</td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">specific entropy</td></tr>
  <tr><td valign=\"top\">Medium.heatCapacity_cp(medium.state)</td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">specific heat capacity at constant pressure</td></tr>
  <tr><td valign=\"top\">Medium.heatCapacity_cv(medium.state)</td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">specific heat capacity at constant density</td></tr>
  <tr><td valign=\"top\">Medium.isentropicExponent(medium.state)</td>
      <td valign=\"top\">1</td>
      <td valign=\"top\">isentropic exponent</td></tr>
  <tr><td valign=\"top\">Medium.isentropicEnthalpy(pressure, medium.state)</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">isentropic enthalpy</td></tr>
  <tr><td valign=\"top\">Medium.velocityOfSound(medium.state)</td>
      <td valign=\"top\">m/s</td>
      <td valign=\"top\">velocity of sound</td></tr>
  <tr><td valign=\"top\">Medium.isobaricExpansionCoefficient(medium.state)</td>
      <td valign=\"top\">1/K</td>
      <td valign=\"top\">isobaric expansion coefficient</td></tr>
  <tr><td valign=\"top\">Medium.isothermalCompressibility(medium.state)</td>
      <td valign=\"top\">1/Pa</td>
      <td valign=\"top\">isothermal compressibility</td></tr>
  <tr><td valign=\"top\">Medium.density_derp_h(medium.state)</td>
      <td valign=\"top\">kg/(m3.Pa)</td>
      <td valign=\"top\">derivative of density by pressure at constant enthalpy</td></tr>
  <tr><td valign=\"top\">Medium.density_derh_p(medium.state)</td>
      <td valign=\"top\">kg2/(m3.J)</td>
      <td valign=\"top\">derivative of density by enthalpy at constant pressure</td></tr>
  <tr><td valign=\"top\">Medium.density_derp_T(medium.state)</td>
      <td valign=\"top\">kg/(m3.Pa)</td>
      <td valign=\"top\">derivative of density by pressure at constant temperature</td></tr>
  <tr><td valign=\"top\">Medium.density_derT_p(medium.state)</td>
      <td valign=\"top\">kg/(m3.K)</td>
      <td valign=\"top\">derivative of density by temperature at constant pressure</td></tr>
  <tr><td valign=\"top\">Medium.density_derX(medium.state)</td>
      <td valign=\"top\">kg/m3</td>
      <td valign=\"top\">derivative of density by mass fraction</td></tr>
  <tr><td valign=\"top\">Medium.molarMass(medium.state)</td>
      <td valign=\"top\">kg/mol</td>
      <td valign=\"top\">molar mass</td></tr>
</table>
<p>More details are given in
<a href=\"Modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">
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

<p>Details on usage and some examples are given in:
<a href=\"Modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">
Modelica.Media.UsersGuide.MediumUsage.TwoPhase</a>.
</p>

<p>Many further properties can be computed. Using the well-known Bridgman's Tables,
all first partial derivatives of the standard thermodynamic variables can be computed easily.
</p>
<p>
The documentation of the IAPWS/IF97 steam properties can be freely
distributed with computer implementations and are included here
(in directory Modelica\\help\\Documentation\\IF97documentation):
<ul>
<li><a href=\"Documentation/IF97documentation/IF97.pdf\">IF97.pdf</a> The standards document for the main part of the IF97.</li>
<li><a href=\"Documentation/IF97documentation/Back3.pdf\">Back3.pdf</a> The backwards equations for region 3.</li>
<li><a href=\"Documentation/IF97documentation/crits.pdf\">crits.pdf</a> The critical point data.</li>
<li><a href=\"Documentation/IF97documentation/meltsub.pdf\">meltsub.pdf</a> The melting- and sublimation line formulation (not implemented)</li>
<li><a href=\"Documentation/IF97documentation/surf.pdf\">surf.pdf</a> The surface tension standard definition</li>
<li><a href=\"Documentation/IF97documentation/thcond.pdf\">thcond.pdf</a> The thermal conductivity standard definition</li>
<li><a href=\"Documentation/IF97documentation/visc.pdf\">visc.pdf</a> The viscosity standard definition</li>
</ul>
</html>"));
end Water;
