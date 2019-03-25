within Modelica.Media;
package Water "Medium models for water"


extends Modelica.Icons.VariantsPackage;

import Modelica.Media.Water.ConstantPropertyLiquidWater.simpleWaterConstants;

constant Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants[1]
  waterConstants(
  each chemicalFormula="H2O",
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
  each acentricFactor=0.344,
  each dipoleMoment=1.8,
  each hasCriticalData=true);


package IdealSteam "Water: Steam as ideal gas from NASA source"

  extends IdealGases.SingleGases.H2O;
  annotation (Documentation(info="<html>

</html>"));
end IdealSteam;


package ConstantPropertyLiquidWater
  "Water: Simple liquid water medium (incompressible, constant data)"

  //   redeclare record extends FluidConstants
  //   end FluidConstants;

  constant Modelica.Media.Interfaces.Types.Basic.FluidConstants[1]
    simpleWaterConstants(
    each chemicalFormula="H2O",
    each structureFormula="H2O",
    each casRegistryNumber="7732-18-5",
    each iupacName="oxidane",
    each molarMass=0.018015268);

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
    fluidConstants=simpleWaterConstants);

  annotation (Documentation(info="<html>

</html>"));
end ConstantPropertyLiquidWater;


package StandardWater = WaterIF97_ph
  "Water using the IF97 standard, explicit in p and h. Recommended for most applications";


package StandardWaterOnePhase = WaterIF97_pT
  "Water using the IF97 standard, explicit in p and T. Recommended for one-phase applications";


package WaterIF97OnePhase_ph
  "Water using the IF97 standard, explicit in p and h, and only valid outside the two-phase dome"
  extends WaterIF97_base(
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
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
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pT,
    final ph_explicit=false,
    final dT_explicit=false,
    final pT_explicit=true,
    final smoothModel=true,
    final onePhase=true);
end WaterIF97_pT;


package WaterIF97_ph "Water using the IF97 standard, explicit in p and h"
  extends WaterIF97_base(
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
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
    AbsolutePressure(
      start=50e5,
      nominal=10e5,
      min=611.657,
      max=100e6),
    Temperature(
      start=500,
      nominal=500,
      min=273.15,
      max=2273.15),
    smoothModel=false,
    onePhase=false,
    fluidConstants=waterConstants);

  redeclare record extends ThermodynamicState "Thermodynamic state"
    SpecificEnthalpy h "Specific enthalpy";
    Density d "Density";
    Temperature T "Temperature";
    AbsolutePressure p "Pressure";
  end ThermodynamicState;

  constant Integer Region = 0 "Region of IF97, if known, zero otherwise";
  constant Boolean ph_explicit
    "True if explicit in pressure and specific enthalpy";
  constant Boolean dT_explicit "True if explicit in density and temperature";
  constant Boolean pT_explicit "True if explicit in pressure and temperature";

  redeclare replaceable model extends BaseProperties(
    h(stateSelect=if ph_explicit and preferredMediumStates then StateSelect.prefer
           else StateSelect.default),
    d(stateSelect=if dT_explicit and preferredMediumStates then StateSelect.prefer
           else StateSelect.default),
    T(stateSelect=if (pT_explicit or dT_explicit) and preferredMediumStates
           then StateSelect.prefer else StateSelect.default),
    p(stateSelect=if (pT_explicit or ph_explicit) and preferredMediumStates
           then StateSelect.prefer else StateSelect.default))
    "Base properties of water"
    Integer phase(
      min=0,
      max=2,
      start=1,
      fixed=false) "2 for two-phase, 1 for one-phase, 0 if not known";
  equation
    MM = fluidConstants[1].molarMass;
    if Region > 0 then // Fixed region
      phase = (if Region == 4 then 2 else 1);
    elseif smoothModel then
      if onePhase then
        phase = 1;
        if ph_explicit then
          assert(((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
            fluidConstants[1].criticalPressure),
            "With onePhase=true this model may only be called with one-phase states h < hl or h > hv!"
             + "(p = " + String(p) + ", h = " + String(h) + ")");
        else
          if dT_explicit then
            assert(not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T
               < fluidConstants[1].criticalTemperature),
              "With onePhase=true this model may only be called with one-phase states d > dl or d < dv!"
               + "(d = " + String(d) + ", T = " + String(T) + ")");
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
      p = pressure_dT(
            d,
            T,
            phase,
            Region);
      h = specificEnthalpy_dT(
            d,
            T,
            phase,
            Region);
      sat.Tsat = T;
      sat.psat = saturationPressure(T);
    elseif ph_explicit then
      d = density_ph(
            p,
            h,
            phase,
            Region);
      T = temperature_ph(
            p,
            h,
            phase,
            Region);
      sat.Tsat = saturationTemperature(p);
      sat.psat = p;
    else
      h = specificEnthalpy_pT(
            p,
            T,
            Region);
      d = density_pT(
            p,
            T,
            Region);
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
    input Integer region=Region
      "If 0, region is unknown, otherwise known and this input";
    output Density d "Density";
  algorithm
    d := IF97_Utilities.rho_ph(
          p,
          h,
          phase,
          region);
    annotation (Inline=true);
  end density_ph;

  redeclare function temperature_ph
    "Computes temperature as a function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=Region
      "If 0, region is unknown, otherwise known and this input";
    output Temperature T "Temperature";
  algorithm
    T := IF97_Utilities.T_ph(
          p,
          h,
          phase,
          region);
    annotation (Inline=true);
  end temperature_ph;

  redeclare function temperature_ps
    "Compute temperature from pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=Region
      "If 0, region is unknown, otherwise known and this input";
    output Temperature T "Temperature";
  algorithm
    T := IF97_Utilities.T_ps(
          p,
          s,
          phase,
          region);
    annotation (Inline=true);
  end temperature_ps;

  redeclare function density_ps
    "Computes density as a function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=Region
      "If 0, region is unknown, otherwise known and this input";
    output Density d "Density";
  algorithm
    d := IF97_Utilities.rho_ps(
          p,
          s,
          phase,
          region);
    annotation (Inline=true);
  end density_ps;

  redeclare function pressure_dT
    "Computes pressure as a function of density and temperature"
    extends Modelica.Icons.Function;
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=Region
      "If 0, region is unknown, otherwise known and this input";
    output AbsolutePressure p "Pressure";
  algorithm
    p := IF97_Utilities.p_dT(
          d,
          T,
          phase,
          region);
    annotation (Inline=true);
  end pressure_dT;

  redeclare function specificEnthalpy_dT
    "Computes specific enthalpy as a function of density and temperature"
    extends Modelica.Icons.Function;
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=Region
      "If 0, region is unknown, otherwise known and this input";
    output SpecificEnthalpy h "Specific enthalpy";
  algorithm
    h := IF97_Utilities.h_dT(
          d,
          T,
          phase,
          region);
    annotation (Inline=true);
  end specificEnthalpy_dT;

  redeclare function specificEnthalpy_pT
    "Computes specific enthalpy as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=Region
      "If 0, region is unknown, otherwise known and this input";
    output SpecificEnthalpy h "Specific enthalpy";
  algorithm
    h := IF97_Utilities.h_pT(
          p,
          T,
          region);
    annotation (Inline=true);
  end specificEnthalpy_pT;

  redeclare function specificEnthalpy_ps
    "Computes specific enthalpy as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=Region
      "If 0, region is unknown, otherwise known and this input";
    output SpecificEnthalpy h "Specific enthalpy";
  algorithm
    h := IF97_Utilities.h_ps(
          p,
          s,
          phase,
          region);
    annotation (Inline=true);
  end specificEnthalpy_ps;

  redeclare function density_pT
    "Computes density as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Integer region=Region
      "If 0, region is unknown, otherwise known and this input";
    output Density d "Density";
  algorithm
    d := IF97_Utilities.rho_pT(
          p,
          T,
          region);
    annotation (Inline=true);
  end density_pT;

  redeclare function extends setDewState
    "Set the thermodynamic state on the dew line"
  algorithm
    state := ThermodynamicState(
          phase=phase,
          p=sat.psat,
          T=sat.Tsat,
          h=dewEnthalpy(sat),
          d=dewDensity(sat));
    annotation (Inline=true);
  end setDewState;

  redeclare function extends setBubbleState
    "Set the thermodynamic state on the bubble line"
  algorithm
    state := ThermodynamicState(
          phase=phase,
          p=sat.psat,
          T=sat.Tsat,
          h=bubbleEnthalpy(sat),
          d=bubbleDensity(sat));
    annotation (Inline=true);
  end setBubbleState;

  redeclare function extends dynamicViscosity "Dynamic viscosity of water"
  algorithm
    eta := IF97_Utilities.dynamicViscosity(
          state.d,
          state.T,
          state.p,
          state.phase);
    annotation (Inline=true);
  end dynamicViscosity;

  redeclare function extends thermalConductivity
    "Thermal conductivity of water"
  algorithm
    lambda := IF97_Utilities.thermalConductivity(
          state.d,
          state.T,
          state.p,
          state.phase);
    annotation (Inline=true);
  end thermalConductivity;

  redeclare function extends surfaceTension
    "Surface tension in two phase region of water"
  algorithm
    sigma := IF97_Utilities.surfaceTension(sat.Tsat);
    annotation (Inline=true);
  end surfaceTension;

  redeclare function extends pressure "Return pressure of ideal gas"
  algorithm
    p := state.p;
    annotation (Inline=true);
  end pressure;

  redeclare function extends temperature "Return temperature of ideal gas"
  algorithm
    T := state.T;
    annotation (Inline=true);
  end temperature;

  redeclare function extends density "Return density of ideal gas"
  algorithm
    d := state.d;
    annotation (Inline=true);
  end density;

  redeclare function extends specificEnthalpy "Return specific enthalpy"
    extends Modelica.Icons.Function;
  algorithm
    h := state.h;
    annotation (Inline=true);
  end specificEnthalpy;

  redeclare function extends specificInternalEnergy
    "Return specific internal energy"
    extends Modelica.Icons.Function;
  algorithm
    u := state.h - state.p/state.d;
    annotation (Inline=true);
  end specificInternalEnergy;

  redeclare function extends specificGibbsEnergy "Return specific Gibbs energy"
    extends Modelica.Icons.Function;
  algorithm
    g := state.h - state.T*specificEntropy(state);
    annotation (Inline=true);
  end specificGibbsEnergy;

  redeclare function extends specificHelmholtzEnergy
    "Return specific Helmholtz energy"
    extends Modelica.Icons.Function;
  algorithm
    f := state.h - state.p/state.d - state.T*specificEntropy(state);
    annotation (Inline=true);
  end specificHelmholtzEnergy;

  redeclare function extends specificEntropy "Specific entropy of water"
  algorithm
    s := if dT_explicit then IF97_Utilities.s_dT(
          state.d,
          state.T,
          state.phase,
          Region) else if pT_explicit then IF97_Utilities.s_pT(
          state.p,
          state.T,
          Region) else IF97_Utilities.s_ph(
          state.p,
          state.h,
          state.phase,
          Region);
    annotation (Inline=true);
  end specificEntropy;

  redeclare function extends specificHeatCapacityCp
    "Specific heat capacity at constant pressure of water"
  algorithm
    cp := if dT_explicit then IF97_Utilities.cp_dT(
          state.d,
          state.T,
          Region) else if pT_explicit then IF97_Utilities.cp_pT(
          state.p,
          state.T,
          Region) else IF97_Utilities.cp_ph(
          state.p,
          state.h,
          Region);
    annotation (Inline=true);
  end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv
    "Specific heat capacity at constant volume of water"
  algorithm
    cv := if dT_explicit then IF97_Utilities.cv_dT(
          state.d,
          state.T,
          state.phase,
          Region) else if pT_explicit then IF97_Utilities.cv_pT(
          state.p,
          state.T,
          Region) else IF97_Utilities.cv_ph(
          state.p,
          state.h,
          state.phase,
          Region);
    annotation (Inline=true);
  end specificHeatCapacityCv;

  redeclare function extends isentropicExponent "Return isentropic exponent"
  algorithm
    gamma := if dT_explicit then IF97_Utilities.isentropicExponent_dT(
          state.d,
          state.T,
          state.phase,
          Region) else if pT_explicit then IF97_Utilities.isentropicExponent_pT(
          state.p,
          state.T,
          Region) else IF97_Utilities.isentropicExponent_ph(
          state.p,
          state.h,
          state.phase,
          Region);
    annotation (Inline=true);
  end isentropicExponent;

  redeclare function extends isothermalCompressibility
    "Isothermal compressibility of water"
  algorithm
    //    assert(state.phase <> 2, "Isothermal compressibility can not be computed with 2-phase inputs!");
    kappa := if dT_explicit then IF97_Utilities.kappa_dT(
          state.d,
          state.T,
          state.phase,
          Region) else if pT_explicit then IF97_Utilities.kappa_pT(
          state.p,
          state.T,
          Region) else IF97_Utilities.kappa_ph(
          state.p,
          state.h,
          state.phase,
          Region);
    annotation (Inline=true);
  end isothermalCompressibility;

  redeclare function extends isobaricExpansionCoefficient
    "Isobaric expansion coefficient of water"
  algorithm
    //    assert(state.phase <> 2, "The isobaric expansion coefficient can not be computed with 2-phase inputs!");
    beta := if dT_explicit then IF97_Utilities.beta_dT(
          state.d,
          state.T,
          state.phase,
          Region) else if pT_explicit then IF97_Utilities.beta_pT(
          state.p,
          state.T,
          Region) else IF97_Utilities.beta_ph(
          state.p,
          state.h,
          state.phase,
          Region);
    annotation (Inline=true);
  end isobaricExpansionCoefficient;

  redeclare function extends velocityOfSound
    "Return velocity of sound as a function of the thermodynamic state record"
  algorithm
    a := if dT_explicit then IF97_Utilities.velocityOfSound_dT(
          state.d,
          state.T,
          state.phase,
          Region) else if pT_explicit then IF97_Utilities.velocityOfSound_pT(
          state.p,
          state.T,
          Region) else IF97_Utilities.velocityOfSound_ph(
          state.p,
          state.h,
          state.phase,
          Region);
    annotation (Inline=true);
  end velocityOfSound;

  redeclare function extends isentropicEnthalpy "Compute h(s,p)"
  algorithm
    h_is := IF97_Utilities.isentropicEnthalpy(
          p_downstream,
          specificEntropy(refState),
          0);
    annotation (Inline=true);
  end isentropicEnthalpy;

  redeclare function extends density_derh_p
    "Density derivative by specific enthalpy"
  algorithm
    ddhp := IF97_Utilities.ddhp(
          state.p,
          state.h,
          state.phase,
          Region);
    annotation (Inline=true);
  end density_derh_p;

  redeclare function extends density_derp_h "Density derivative by pressure"
  algorithm
    ddph := IF97_Utilities.ddph(
          state.p,
          state.h,
          state.phase,
          Region);
    annotation (Inline=true);
  end density_derp_h;

  //   redeclare function extends density_derT_p
  //     "Density derivative by temperature"
  //   algorithm
  //     ddTp := IF97_Utilities.ddTp(state.p, state.h, state.phase);
  //   end density_derT_p;
  //
  //   redeclare function extends density_derp_T
  //     "Density derivative by pressure"
  //   algorithm
  //     ddpT := IF97_Utilities.ddpT(state.p, state.h, state.phase);
  //   end density_derp_T;

  redeclare function extends bubbleEnthalpy
    "Boiling curve specific enthalpy of water"
  algorithm
    hl := IF97_Utilities.BaseIF97.Regions.hl_p(sat.psat);
    annotation (Inline=true);
  end bubbleEnthalpy;

  redeclare function extends dewEnthalpy "Dew curve specific enthalpy of water"
  algorithm
    hv := IF97_Utilities.BaseIF97.Regions.hv_p(sat.psat);
    annotation (Inline=true);
  end dewEnthalpy;

  redeclare function extends bubbleEntropy
    "Boiling curve specific entropy of water"
  algorithm
    sl := IF97_Utilities.BaseIF97.Regions.sl_p(sat.psat);
    annotation (Inline=true);
  end bubbleEntropy;

  redeclare function extends dewEntropy "Dew curve specific entropy of water"
  algorithm
    sv := IF97_Utilities.BaseIF97.Regions.sv_p(sat.psat);
    annotation (Inline=true);
  end dewEntropy;

  redeclare function extends bubbleDensity
    "Boiling curve specific density of water"
  algorithm
    dl := if ph_explicit or pT_explicit then
      IF97_Utilities.BaseIF97.Regions.rhol_p(sat.psat) else
      IF97_Utilities.BaseIF97.Regions.rhol_T(sat.Tsat);
    annotation (Inline=true);
  end bubbleDensity;

  redeclare function extends dewDensity "Dew curve specific density of water"
  algorithm
    dv := if ph_explicit or pT_explicit then
      IF97_Utilities.BaseIF97.Regions.rhov_p(sat.psat) else
      IF97_Utilities.BaseIF97.Regions.rhov_T(sat.Tsat);
    annotation (Inline=true);
  end dewDensity;

  redeclare function extends saturationTemperature
    "Saturation temperature of water"
  algorithm
    T := IF97_Utilities.BaseIF97.Basic.tsat(p);
    annotation (Inline=true);
  end saturationTemperature;

  redeclare function extends saturationTemperature_derp
    "Derivative of saturation temperature w.r.t. pressure"
  algorithm
    dTp := IF97_Utilities.BaseIF97.Basic.dtsatofp(p);
    annotation (Inline=true);
  end saturationTemperature_derp;

  redeclare function extends saturationPressure "Saturation pressure of water"
  algorithm
    p := IF97_Utilities.BaseIF97.Basic.psat(T);
    annotation (Inline=true);
  end saturationPressure;

  redeclare function extends dBubbleDensity_dPressure
    "Bubble point density derivative"
  algorithm
    ddldp := IF97_Utilities.BaseIF97.Regions.drhol_dp(sat.psat);
    annotation (Inline=true);
  end dBubbleDensity_dPressure;

  redeclare function extends dDewDensity_dPressure
    "Dew point density derivative"
  algorithm
    ddvdp := IF97_Utilities.BaseIF97.Regions.drhov_dp(sat.psat);
    annotation (Inline=true);
  end dDewDensity_dPressure;

  redeclare function extends dBubbleEnthalpy_dPressure
    "Bubble point specific enthalpy derivative"
  algorithm
    dhldp := IF97_Utilities.BaseIF97.Regions.dhl_dp(sat.psat);
    annotation (Inline=true);
  end dBubbleEnthalpy_dPressure;

  redeclare function extends dDewEnthalpy_dPressure
    "Dew point specific enthalpy derivative"
  algorithm
    dhvdp := IF97_Utilities.BaseIF97.Regions.dhv_dp(sat.psat);
    annotation (Inline=true);
  end dDewEnthalpy_dPressure;

  redeclare function extends setState_dTX
    "Return thermodynamic state of water as function of d, T, and optional region"
    input Integer region=Region
      "If 0, region is unknown, otherwise known and this input";
  algorithm
    state := ThermodynamicState(
          d=d,
          T=T,
          phase=if region == 0 then 0 else if
        region == 4 then 2 else 1,
          h=specificEnthalpy_dT(
            d,
            T,
            region=region),
          p=pressure_dT(
            d,
            T,
            region=region));
    annotation (Inline=true);
  end setState_dTX;

  redeclare function extends setState_phX
    "Return thermodynamic state of water as function of p, h, and optional region"
    input Integer region=Region
      "If 0, region is unknown, otherwise known and this input";
  algorithm
    state := ThermodynamicState(
          d=density_ph(
            p,
            h,
            region=region),
          T=temperature_ph(
            p,
            h,
            region=region),
          phase=if region == 0 then 0 else if region==4 then 2 else 1,
          h=h,
          p=p);
    annotation (Inline=true);
  end setState_phX;

  redeclare function extends setState_psX
    "Return thermodynamic state of water as function of p, s, and optional region"
    input Integer region=Region
      "If 0, region is unknown, otherwise known and this input";
  algorithm
    state := ThermodynamicState(
          d=density_ps(
            p,
            s,
            region=region),
          T=temperature_ps(
            p,
            s,
            region=region),
          phase=if region == 0 then 0 else if region==4 then 2 else 1,
          h=specificEnthalpy_ps(
            p,
            s,
            region=region),
          p=p);
    annotation (Inline=true);
  end setState_psX;

  redeclare function extends setState_pTX
    "Return thermodynamic state of water as function of p, T, and optional region"
    input Integer region=Region
      "If 0, region is unknown, otherwise known and this input";
  algorithm
    state := ThermodynamicState(
          d=density_pT(
            p,
            T,
            region=region),
          T=T,
          phase=1,
          h=specificEnthalpy_pT(
            p,
            T,
            region=region),
          p=p);
    annotation (Inline=true);
  end setState_pTX;

  redeclare function extends setSmoothState
    "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
    import Modelica.Media.Common.smoothStep;
  algorithm
    state := ThermodynamicState(
          p=smoothStep(
            x,
            state_a.p,
            state_b.p,
            x_small),
          h=smoothStep(
            x,
            state_a.h,
            state_b.h,
            x_small),
          d=density_ph(smoothStep(
            x,
            state_a.p,
            state_b.p,
            x_small), smoothStep(
            x,
            state_a.h,
            state_b.h,
            x_small)),
          T=temperature_ph(smoothStep(
            x,
            state_a.p,
            state_b.p,
            x_small), smoothStep(
            x,
            state_a.h,
            state_b.h,
            x_small)),
          phase=0);
    annotation (Inline=true);
  end setSmoothState;
  annotation (Documentation(info="<html>
<p>
This model calculates medium properties
for water in the <strong>liquid</strong>, <strong>gas</strong> and <strong>two phase</strong> regions
according to the IAPWS/IF97 standard, i.e., the accepted industrial standard
and best compromise between accuracy and computation time.
For more details see <a href=\"modelica://Modelica.Media.Water.IF97_Utilities\">
Modelica.Media.Water.IF97_Utilities</a>. Three variable pairs can be the
independent variables of the model:
</p>
<ol>
<li>Pressure <strong>p</strong> and specific enthalpy <strong>h</strong> are the most natural choice for general applications. This is the recommended choice for most general purpose applications, in particular for power plants.</li>
<li>Pressure <strong>p</strong> and temperature <strong>T</strong> are the most natural choice for applications where water is always in the same phase, both for liquid water and steam.</li>
<li>Density <strong>d</strong> and temperature <strong>T</strong> are explicit variables of the Helmholtz function in the near-critical region and can be the best choice for applications with super-critical or near-critical states.</li>
</ol>
<p>
The following quantities are always computed:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><strong>Variable</strong></td>
      <td><strong>Unit</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>T</td>
      <td>K</td>
      <td>temperature</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>specific internal energy</td></tr>
  <tr><td>d</td>
      <td>kg/m^3</td>
      <td>density</td></tr>
  <tr><td>p</td>
      <td>Pa</td>
      <td>pressure</td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>specific enthalpy</td></tr>
</table>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the functions listed in
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">
Modelica.Media.UsersGuide.MediumUsage.OptionalProperties</a> and in
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">
Modelica.Media.UsersGuide.MediumUsage.TwoPhase</a>.
</p>
<p>Many further properties can be computed. Using the well-known Bridgman's Tables, all first partial derivatives of the standard thermodynamic variables can be computed easily.
</p>
</html>"));
end WaterIF97_base;


partial package WaterIF97_fixedregion
  "Water: Steam properties as defined by IAPWS/IF97 standard, fixed region"
  extends WaterIF97_base(Region(min=1)=1);
end WaterIF97_fixedregion;


package WaterIF97_R4ph "Region 4 water according to IF97 standard"
  extends WaterIF97_fixedregion(
    final Region=4,
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=false);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R4ph;


package WaterIF97_R5ph "Region 5 water according to IF97 standard"
  extends WaterIF97_fixedregion(
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
    final Region=5,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R5ph;


package WaterIF97_R1pT "Region 1 (liquid) water according to IF97 standard"
  extends WaterIF97_fixedregion(
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pT,
    final Region=1,
    final ph_explicit=false,
    final dT_explicit=false,
    final pT_explicit=true,
    smoothModel=true,
    onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R1pT;


package WaterIF97_R2pT "Region 2 (steam) water according to IF97 standard"
  extends WaterIF97_fixedregion(
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pT,
    final Region=2,
    final ph_explicit=false,
    final dT_explicit=false,
    final pT_explicit=true,
    smoothModel=true,
    onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R2pT;


package WaterIF97_R1ph "Region 1 (liquid) water according to IF97 standard"
  extends WaterIF97_fixedregion(
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
    final Region=1,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R1ph;


package WaterIF97_R2ph "Region 2 (steam) water according to IF97 standard"
  extends WaterIF97_fixedregion(
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
    final Region=2,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R2ph;


package WaterIF97_R3ph "Region 3 water according to IF97 standard"
  extends WaterIF97_fixedregion(
    final Region=3,
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R3ph;


annotation (Documentation(info="<html>
<p>This package contains different medium models for water:</p>
<ul>
<li><strong>ConstantPropertyLiquidWater</strong><br>
    Simple liquid water medium (incompressible, constant data).</li>
<li><strong>IdealSteam</strong><br>
    Steam water medium as ideal gas from Media.IdealGases.SingleGases.H2O</li>
<li><strong>WaterIF97 derived models</strong><br>
    High precision water model according to the IAPWS/IF97 standard
    (liquid, steam, two phase region). Models with different independent
    variables are provided as well as models valid only
    for particular regions. The <strong>WaterIF97_ph</strong> model is valid
    in all regions and is the recommended one to use.</li>
</ul>
<h4>Overview of WaterIF97 derived water models</h4>
<p>
The WaterIF97 models calculate medium properties
for water in the <strong>liquid</strong>, <strong>gas</strong> and <strong>two phase</strong> regions
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
<li>Pressure <strong>p</strong> and specific enthalpy <strong>h</strong> are
    the most natural choice for general applications.
    This is the recommended choice for most general purpose
    applications, in particular for power plants.</li>
<li>Pressure <strong>p</strong> and temperature <strong>T</strong> are the most natural
    choice for applications where water is always in the same phase,
    both for liquid water and steam.</li>
<li>Density <strong>d</strong> and temperature <strong>T</strong> are explicit
    variables of the Helmholtz function in the near-critical
    region and can be the best choice for applications with
    super-critical or near-critical states.</li>
</ol>
<p>
The following quantities are always computed in Medium.BaseProperties:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><strong>Variable</strong></td>
      <td><strong>Unit</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>T</td>
      <td>K</td>
      <td>temperature</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>specific internal energy</td></tr>
  <tr><td>d</td>
      <td>kg/m^3</td>
      <td>density</td></tr>
  <tr><td>p</td>
      <td>Pa</td>
      <td>pressure</td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>specific enthalpy</td></tr>
</table>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the following functions:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><strong>Function call</strong></td>
      <td><strong>Unit</strong></td>
      <td><strong>Description</strong></td></tr>
  <tr><td>Medium.dynamicViscosity(medium.state)</td>
      <td>Pa.s</td>
      <td>dynamic viscosity</td></tr>
  <tr><td>Medium.thermalConductivity(medium.state)</td>
      <td>W/(m.K)</td>
      <td>thermal conductivity</td></tr>
  <tr><td>Medium.prandtlNumber(medium.state)</td>
      <td>1</td>
      <td>Prandtl number</td></tr>
  <tr><td>Medium.specificEntropy(medium.state)</td>
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
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">
Modelica.Media.UsersGuide.MediumUsage.OptionalProperties</a>.

Many additional optional functions are defined to compute properties of
saturated media, either liquid (bubble point) or vapour (dew point).
The argument to such functions is a SaturationProperties record, which can be
set starting from either the saturation pressure or the saturation temperature.
With reference to a model defining a pressure p, a temperature T, and a
SaturationProperties record sat, the following functions are provided:
</p>
<table border=1 cellspacing=0 cellpadding=2>
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
<p>Details on usage and some examples are given in:
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">
Modelica.Media.UsersGuide.MediumUsage.TwoPhase</a>.
</p>
<p>Many further properties can be computed. Using the well-known Bridgman's Tables,
all first partial derivatives of the standard thermodynamic variables can be computed easily.
</p>
<p>
The documentation of the IAPWS/IF97 steam properties can be freely
distributed with computer implementations and are included here
(in directory Modelica/Resources/Documentation/Media/Water/IF97documentation):
</p>
<ul>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a> The standards document for the main part of the IF97.</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/Back3.pdf\">Back3.pdf</a> The backwards equations for region 3.</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/crits.pdf\">crits.pdf</a> The critical point data.</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/meltsub.pdf\">meltsub.pdf</a> The melting- and sublimation line formulation (not implemented)</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/surf.pdf\">surf.pdf</a> The surface tension standard definition</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/thcond.pdf\">thcond.pdf</a> The thermal conductivity standard definition</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/visc.pdf\">visc.pdf</a> The viscosity standard definition</li>
</ul>
</html>"));
end Water;
