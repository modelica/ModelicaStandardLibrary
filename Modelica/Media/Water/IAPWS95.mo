within Modelica.Media.Water;
package IAPWS95
  "Water: Water model as described by IAPWS-95 (273.15 ... 1273 K)"
  extends Modelica.Icons.MaterialPropertiesPackage;
  import SI = Modelica.SIunits;

  constant Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants
    waterConstants(
    each chemicalFormula="H2O",
    each structureFormula="H2O",
    each casRegistryNumber="7732-18-5",
    each iupacName="oxidane",
    each molarMass=0.018015268,
    each criticalTemperature=647.096,
    each criticalPressure=22064.0e3,
    each criticalMolarVolume=1/322.0*0.018015268,
    each triplePointTemperature=273.16,
    each triplePointPressure=611.657,
    each normalBoilingPoint=373.124,
    each meltingPoint=273.15,
    each acentricFactor=0.344,
    each dipoleMoment=1.8,
    each hasCriticalData=true,
    each hasIdealGasHeatCapacity=false,
    each hasDipoleMoment=true,
    each hasFundamentalEquation=true,
    each hasLiquidHeatCapacity=true,
    each hasSolidHeatCapacity=false,
    each hasAccurateViscosityData=true,
    each hasAccurateConductivityData=true,
    each hasVapourPressureCurve=false,
    each hasAcentricFactor=true,
    each HCRIT0=0.0,
    each SCRIT0=0.0,
    each deltah=0.0,
    each deltas=0.0);

protected
  type MolarHeatCapacity = SI.MolarHeatCapacity (
      min=0,
      max=3.e5,
      nominal=3.e1,
      start=3.e1)
    "Type for molar heat capacity with medium specific attributes";

  type MolarDensity = Real (
      final quantity="MolarDensity",
      final unit="mol/m3",
      min=0);

  type IsothermalExpansionCoefficient = Real (
      min=0,
      max=1e8,
      unit="1");

public
  package Water95_pT
    "Water: Water model as described by IAPWS-95 (273.15 ... 1273 K) explicit in p and T"
    extends Modelica.Media.Water.IAPWS95.Water95_Base(
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pT,
      final ph_explicit=false,
      final dT_explicit=false,
      final pT_explicit=true);
  end Water95_pT;

public
  package Water95_dT
    "Water: Water model as described by IAPWS-95 (273.15 ... 1273 K) explicit in d and T"
    extends Modelica.Media.Water.IAPWS95.Water95_Base(
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.dTX,
      final ph_explicit=false,
      final dT_explicit=true,
      final pT_explicit=false);
  end Water95_dT;

public
  package Water95_ph
    "Water: Water model as described by IAPWS-95 (273.15 ... 1273 K) explicit in p and h"
    extends Modelica.Media.Water.IAPWS95.Water95_Base(
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
      final ph_explicit=true,
      final dT_explicit=false,
      final pT_explicit=false);
  end Water95_ph;

public
  partial package Water95_Base
    "Properties of water calculated using the equation of state as given by IAPWS-95"

    extends Modelica.Media.Interfaces.PartialPureSubstance(
      mediumName="WaterIF95",
      substanceNames={"water"},
      singleState=false,
      SpecificEnthalpy(start=1.0e5, nominal=5.0e5),
      Density(start=150, nominal=500),
      AbsolutePressure(start=50e5, nominal=10e5),
      Temperature(start=500, nominal=500));

    constant Boolean ph_explicit
      "true if explicit in pressure and specific enthalpy";
    constant Boolean dT_explicit "true if explicit in density and temperature";
    constant Boolean pT_explicit "true if explicit in pressure and temperature";

    redeclare record extends ThermodynamicState "thermodynamic state"
      SpecificEnthalpy h "specific enthalpy";
      Density d "density";
      Temperature T "temperature";
      AbsolutePressure p "pressure";
    end ThermodynamicState;

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

    equation
      MM = Water95_Utilities.Basic.Constants.MM;
      if dT_explicit then
        p = pressure_dT(d, T);
        h = specificEnthalpy_dT(d, T);
      elseif ph_explicit then
        d = density_ph(p, h);
        T = temperature_ph(p, h);
      else
        h = specificEnthalpy_pT(p, T);
        d = density_pT(p, T);
      end if;
      u = h - p/d;
      R = Water95_Utilities.Basic.Constants.R;
      h = state.h;
      p = state.p;
      T = state.T;
      d = state.d;
    end BaseProperties;

    redeclare function density_ph
      "Computes density as a function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output Density d "Density";
    algorithm
      d := Modelica.Media.Water.IAPWS95.Water95_Utilities.rho_ph(p, h);
    end density_ph;

    redeclare function temperature_ph
      "Computes temperature as a function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output Temperature T "Temperature";
    algorithm
      T := Modelica.Media.Water.IAPWS95.Water95_Utilities.T_ph(p, h);
    end temperature_ph;

    redeclare function temperature_ps
      "Compute temperature from pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output Temperature T "Temperature";
    algorithm
      T := Modelica.Media.Water.IAPWS95.Water95_Utilities.T_ps(p, s);
    end temperature_ps;

    redeclare function density_ps
      "Computes density as a function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output Density d "density";
    algorithm
      d := Modelica.Media.Water.IAPWS95.Water95_Utilities.rho_ps(p, s);
    end density_ps;

    redeclare function pressure_dT
      "Computes pressure as a function of density and temperature"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      output AbsolutePressure p "Pressure";
    algorithm
      p := Modelica.Media.Water.IAPWS95.Water95_Utilities.p_dT(d, T);
    end pressure_dT;

    redeclare function specificEnthalpy_dT
      "Computes specific enthalpy as a function of density and temperature"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      output SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := Modelica.Media.Water.IAPWS95.Water95_Utilities.h_dT(d, T);
    end specificEnthalpy_dT;

    redeclare function specificEnthalpy_pT
      "Computes specific enthalpy as a function of pressure and temperature"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := Modelica.Media.Water.IAPWS95.Water95_Utilities.h_pT(p, T);
    end specificEnthalpy_pT;

    redeclare function specificEnthalpy_ps
      "Computes specific enthalpy as a function of pressure and temperature"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := Modelica.Media.Water.IAPWS95.Water95_Utilities.h_ps(p, s);
    end specificEnthalpy_ps;

    redeclare function density_pT
      "Computes density as a function of pressure and temperature"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output Density d "Density";
    algorithm
      d := Modelica.Media.Water.IAPWS95.Water95_Utilities.rho_pT(p, T);
    end density_pT;

    redeclare function extends dynamicViscosity
      "Return dynamic viscosity as a function of the thermodynamic state record"
    algorithm
      eta := Modelica.Media.Water.IAPWS95.Water95_Utilities.dynamicViscosity(
        state);
    end dynamicViscosity;

    redeclare function extends thermalConductivity
      "Thermal conductivity of water"
    algorithm
      lambda :=
        Modelica.Media.Water.IAPWS95.Water95_Utilities.thermalConductivity(
        state);
    end thermalConductivity;

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
    algorithm
      h := state.h;
    end specificEnthalpy;

    redeclare function extends specificInternalEnergy
      "Return specific internal energy"
    algorithm
      u := state.h - state.p/state.d;
    end specificInternalEnergy;

    redeclare function extends specificGibbsEnergy
      "Return specific Gibbs energy"
    algorithm
      g := state.h - state.T*specificEntropy(state);
    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy
      "Return specific Helmholtz energy"
    algorithm
      f := state.h - state.p/state.d - state.T*specificEntropy(state);
    end specificHelmholtzEnergy;

    redeclare function extends specificEntropy "specific entropy of water"
    algorithm
      if dT_explicit then
        s := Modelica.Media.Water.IAPWS95.Water95_Utilities.s_dT(state.d, state.T);
      elseif pT_explicit then
        s := Modelica.Media.Water.IAPWS95.Water95_Utilities.s_pT(state.p, state.T);
      else
        s := Modelica.Media.Water.IAPWS95.Water95_Utilities.s_ph(state.p, state.h);
      end if;
    end specificEntropy;

    redeclare function extends specificHeatCapacityCp
      "specific heat capacity at constant pressure of water"

    algorithm
      if dT_explicit then
        cp := Modelica.Media.Water.IAPWS95.Water95_Utilities.cp_dT(state.d,
          state.T);
      elseif pT_explicit then
        cp := Modelica.Media.Water.IAPWS95.Water95_Utilities.cp_pT(state.p,
          state.T);
      else
        cp := Modelica.Media.Water.IAPWS95.Water95_Utilities.cp_ph(state.p,
          state.h);
      end if;
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv
      "specific heat capacity at constant volume of water"
    algorithm
      if dT_explicit then
        cv := Modelica.Media.Water.IAPWS95.Water95_Utilities.cv_dT(state.d,
          state.T);
      elseif pT_explicit then
        cv := Modelica.Media.Water.IAPWS95.Water95_Utilities.cv_pT(state.p,
          state.T);
      else
        cv := Modelica.Media.Water.IAPWS95.Water95_Utilities.cv_ph(state.p,
          state.h);
      end if;
    end specificHeatCapacityCv;

    redeclare function extends isentropicExponent "Return isentropic exponent"
    algorithm
      if dT_explicit then
        gamma :=
          Modelica.Media.Water.IAPWS95.Water95_Utilities.isentropicExponent_dT(
          state.d, state.T);
      elseif pT_explicit then
        gamma :=
          Modelica.Media.Water.IAPWS95.Water95_Utilities.isentropicExponent_pT(
          state.p, state.T);
      else
        gamma :=
          Modelica.Media.Water.IAPWS95.Water95_Utilities.isentropicExponent_ph(
          state.p, state.h);
      end if;
    end isentropicExponent;

    redeclare function extends isothermalCompressibility
      "Isothermal compressibility of water"
    algorithm
      if dT_explicit then
        kappa := Modelica.Media.Water.IAPWS95.Water95_Utilities.kappa_dT(state.d,
          state.T);
      elseif pT_explicit then
        kappa := Modelica.Media.Water.IAPWS95.Water95_Utilities.kappa_pT(state.p,
          state.T);
      else
        kappa := Modelica.Media.Water.IAPWS95.Water95_Utilities.kappa_ph(state.p,
          state.h);
      end if;
    end isothermalCompressibility;

    redeclare function extends isobaricExpansionCoefficient
      "isobaric expansion coefficient of water"
    algorithm
      if dT_explicit then
        beta := Modelica.Media.Water.IAPWS95.Water95_Utilities.beta_dT(state.d,
          state.T);
      elseif pT_explicit then
        beta := Modelica.Media.Water.IAPWS95.Water95_Utilities.beta_pT(state.p,
          state.T);
      else
        beta := Modelica.Media.Water.IAPWS95.Water95_Utilities.beta_ph(state.p,
          state.h);
      end if;
    end isobaricExpansionCoefficient;

    redeclare function extends velocityOfSound
      "Return velocity of sound as a function of the thermodynamic state record"
    algorithm
      if dT_explicit then
        a := Modelica.Media.Water.IAPWS95.Water95_Utilities.velocityOfSound_dT(
          state.d, state.T);
      elseif pT_explicit then
        a := Modelica.Media.Water.IAPWS95.Water95_Utilities.velocityOfSound_pT(
          state.p, state.T);
      else
        a := Modelica.Media.Water.IAPWS95.Water95_Utilities.velocityOfSound_ph(
          state.p, state.h);
      end if;
    end velocityOfSound;

    redeclare function extends density_derh_p
      "density derivative by specific enthalpy"
    algorithm
      ddhp := Modelica.Media.Water.IAPWS95.Water95_Utilities.ddhp(state.p,
        state.h);
    end density_derh_p;

    redeclare function extends density_derp_h "density derivative by pressure"
    algorithm
      ddph := Modelica.Media.Water.IAPWS95.Water95_Utilities.ddph(state.p,
        state.h);
    end density_derp_h;

    //   redeclare function extends density_derT_p
    //     "density derivative by temperature"
    //   algorithm
    //     ddTp := IF97_Utilities.ddTp(state.p, state.h, state.phase);
    //   end density_derT_p;
    //
    //   redeclare function extends density_derp_T
    //     "density derivative by pressure"
    //   algorithm
    //     ddpT := IF97_Utilities.ddpT(state.p, state.h, state.phase);
    //   end density_derp_T;

    redeclare function extends setState_dTX
      "Return thermodynamic state of water as function of d and T"
    algorithm
      state := ThermodynamicState(
            d=d,
            T=T,
            h=specificEnthalpy_dT(d, T),
            p=pressure_dT(d, T));
    end setState_dTX;

    redeclare function extends setState_phX
      "Return thermodynamic state of water as function of p and h"
    algorithm
      state := ThermodynamicState(
            d=density_ph(p, h),
            T=temperature_ph(p, h),
            h=h,
            p=p);
    end setState_phX;

    redeclare function extends setState_psX
      "Return thermodynamic state of water as function of p and s"
    algorithm
      state := ThermodynamicState(
            d=density_ps(p, s),
            T=temperature_ps(p, s),
            h=specificEnthalpy_ps(p, s),
            p=p);
    end setState_psX;

    redeclare function extends setState_pTX
      "Return thermodynamic state of water as function of p and T"
    algorithm
      state := ThermodynamicState(
            d=density_pT(p, T),
            T=T,
            h=specificEnthalpy_pT(p, T),
            p=p);
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
              x_small)));
    end setSmoothState;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Text(
            extent={{-94,84},{94,40}},
            lineColor={127,191,255},
            textString="IF97"), Text(
            extent={{-94,20},{94,-24}},
            lineColor={127,191,255},
            textString="water")}), Documentation(info="<html>
</html>"));
  end Water95_Base;

  package Water95_Utilities
    "Low level and utility computation for high accuracy water properties"
    extends Modelica.Icons.Package;

    record iter = Inverses.accuracy;
    package Basic "Fundamental equation of state"
      extends Modelica.Icons.BasesPackage;

      constant Common.FundamentalConstants Constants(
        R_bar=8.314371,
        R=461.51805,
        MM=18.015268E-003,
        rhored=322,
        Tred=647.096,
        pred=22064000,
        h_off=0.0,
        s_off=0.0);

      function Helmholtz "Helmholtz equation of state"
        extends Modelica.Icons.Function;
        input SI.Density d "density";
        input SI.Temperature T "temperature (K)";
        output Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";

      protected
        final constant Real[8] N_0={-8.3204464837497,6.6832105275932,3.00632,
            0.012436,0.97315,1.2795,0.96956,0.24873};
        final constant Real[8] gamma_0={0,0,0,1.28728967,3.53734222,7.74073708,
            9.24437796,27.5075105};
        final constant Real[56] N={0.12533547935523E-001,0.78957634722828E+001,
            -0.87803203303561E+001,0.31802509345418,-0.26145533859358,-0.78199751687981E-002,
            0.88089493102134E-002,-0.66856572307965,0.20433810950965,-0.66212605039687E-004,
            -0.19232721156002,-0.25709043003438,0.16074868486251,-0.40092828925807E-001,
            0.39343422603254E-006,-0.75941377088144E-005,0.56250979351888E-003,
            -0.15608652257135E-004,0.11537996422951E-008,0.36582165144204E-006,
            -0.13251180074668E-011,-0.62639586912454E-009,-0.10793600908932,
            0.17611491008752E-001,0.22132295167546,-0.40247669763528,
            0.58083399985759,0.49969146990806E-002,-0.31358700712549E-001,-0.74315929710341,
            0.4780732991548,0.20527940895948E-001,-0.13636435110343,
            0.14180634400617E-001,0.83326504880713E-002,-0.29052336009585E-001,
            0.38615085574206E-001,-0.20393486513704E-001,-0.16554050063734E-002,
            0.19955571979541E-002,0.15870308324157E-003,-0.1638856834253E-004,
            0.43613615723811E-001,0.34994005463765E-001,-0.76788197844621E-001,
            0.22446277332006E-001,-0.62689710414685E-004,-0.55711118565645E-009,
            -0.19905718354408,0.31777497330738,-0.11841182425981,-0.31306260323435E+002,
            0.31546140237781E+002,-0.25213154341695E+004,-0.14874640856724,
            0.31806110878444};
        final constant Integer[51] c={0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
            1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,3,3,4,6,6,6,6};
        final constant Integer[54] dd={1,1,1,2,2,3,4,1,1,1,2,2,3,4,4,5,7,9,10,
            11,13,15,1,2,2,2,3,4,4,4,5,6,6,7,9,9,9,9,9,10,10,12,3,4,4,5,14,3,6,
            6,6,3,3,3};
        final constant Real[54] t={-0.5,0.875,1.0,0.5,0.75,0.375,1.0,4.0,6.0,
            12.0,1.0,5.0,4.0,2.0,13.0,9.0,3.0,4.0,11.0,4.0,13.0,1.0,7.0,1.0,9.0,
            10.0,10.0,3.0,7.0,10.0,10.0,6.0,10.0,10.0,1.0,2.0,3.0,4.0,8.0,6.0,
            9.0,8.0,16.0,22.0,23.0,23.0,10.0,50.0,44.0,46.0,50.0,0.0,1.0,4.0};
        final constant Integer[54] alpha={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20,
            20,20};
        final constant Real[56] beta={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,150,150,250,0.3,0.3};
        final constant Real[54] gamma={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.21,1.21,1.25};
        final constant Integer[54] epsilon={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
            1,1};
        final constant Real[56] a={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,3.5,3.5};
        final constant Real[56] b={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.85,0.95};
        final constant Real[56] AA={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.32,0.32};
        final constant Real[56] BB={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
            0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.2};
        final constant Integer[56] CC={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
            28,32};
        final constant Integer[56] DD={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
            700,800};
        //auxilliary variables used to store temporary results
        Real Delta55=0;
        Real Delta56=0;
        Real theta55=0;
        Real theta56=0;
        Real psi55=0;
        Real psi56=0;
        Real Delta55delta=0;
        Real Delta56delta=0;
        Real Deltab55delta=0;
        Real Deltab56delta=0;
        Real psi55delta=0;
        Real psi56delta=0;
        Real Delta55tau=0;
        Real Delta56tau=0;
        Real Deltab55tau=0;
        Real Deltab56tau=0;
        Real psi55tau=0;
        Real psi56tau=0;
        Real Delta55deltadelta=0;
        Real Delta56deltadelta=0;
        Real Deltab55deltadelta=0;
        Real Deltab56deltadelta=0;
        Real psi55deltadelta=0;
        Real psi56deltadelta=0;
        Real Delta55tautau=0;
        Real Delta56tautau=0;
        Real Deltab55tautau=0;
        Real Deltab56tautau=0;
        Real psi55tautau=0;
        Real psi56tautau=0;
        Real Delta55deltatau;
        Real Delta56deltatau;
        Real Deltab55deltatau;
        Real Deltab56deltatau;
        Real psi55deltatau;
        Real psi56deltatau;

      algorithm
        f.d := d;
        f.T := T;
        f.R := Water95_Utilities.Basic.Constants.R;
        //Reduced density
        f.delta := d/Water95_Utilities.Basic.Constants.rhored;
        //Reciprocal reduced temperature
        f.tau := Water95_Utilities.Basic.Constants.Tred/T;

        //calculate auxilliary values
        theta55 := (1 - f.tau) + AA[55]*((f.delta - 1)^2)^(1/(2*beta[55]));
        theta56 := (1 - f.tau) + AA[56]*((f.delta - 1)^2)^(1/(2*beta[56]));
        psi55 := exp(-CC[55]*(f.delta - 1)^2 - DD[55]*(f.tau - 1)^2);
        psi56 := exp(-CC[56]*(f.delta - 1)^2 - DD[56]*(f.tau - 1)^2);
        Delta55 := theta55^2 + BB[55]*((f.delta - 1)^2)^a[55];
        Delta56 := theta56^2 + BB[56]*((f.delta - 1)^2)^a[56];
        //and many derivatives
        //First derivative of Delta[55,56] w.r.t. delta
        Delta55delta := (f.delta - 1)*(AA[55]*theta55*2/beta[55]*((f.delta - 1)
          ^2)^(1/(2*beta[55]) - 1) + 2*BB[55]*a[55]*((f.delta - 1)^2)^(a[55] -
          1));
        Delta56delta := (f.delta - 1)*(AA[56]*theta56*2/beta[56]*((f.delta - 1)
          ^2)^(1/(2*beta[56]) - 1) + 2*BB[56]*a[56]*((f.delta - 1)^2)^(a[56] -
          1));
        //First derivative of Deltab[55,56] w.r.t. delta
        Deltab55delta := b[55]*Delta55^(b[55] - 1)*Delta55delta;
        Deltab56delta := b[56]*Delta56^(b[56] - 1)*Delta56delta;
        //First derivative of psi[55,56] w.r.t. delta
        psi55delta := -2*CC[55]*(f.delta - 1)*psi55;
        psi56delta := -2*CC[56]*(f.delta - 1)*psi56;
        //First derivative of Delta[55,56] w.r.t. tau
        Delta55tau := -2*((1 - f.tau) + AA[55]*((f.delta - 1)^2)^(1/(2*beta[55])));
        Delta56tau := -2*((1 - f.tau) + AA[56]*((f.delta - 1)^2)^(1/(2*beta[56])));
        //First derivative of Deltab[55,56] w.r.t. tau
        Deltab55tau := -2*theta55*b[55]*Delta55^(b[55] - 1);
        Deltab56tau := -2*theta56*b[56]*Delta56^(b[56] - 1);
        //First derivative of psi[55,56] w.r.t. tau
        psi55tau := -2*DD[55]*(f.tau - 1)*psi55;
        psi56tau := -2*DD[56]*(f.tau - 1)*psi56;
        //Second derivative of Delta[55,56] w.r.t. delta
        Delta55deltadelta := 1/(f.delta - 1)*Delta55delta + (f.delta - 1)^2*(AA[
          55]^2*2/beta[55]^2*(((f.delta - 1)^2)^(1/(2*beta[55]) - 1))^2 + AA[55]
          *theta55*4/beta[55]*(1/(2*beta[55]) - 1)*((f.delta - 1)^2)^(1/(2*beta[
          55]) - 2) + 4*BB[55]*a[55]*(a[55] - 1)*((f.delta - 1)^2)^(a[55] - 2));
        Delta56deltadelta := 1/(f.delta - 1)*Delta56delta + (f.delta - 1)^2*(AA[
          56]^2*2/beta[56]^2*(((f.delta - 1)^2)^(1/(2*beta[56]) - 1))^2 + AA[56]
          *theta56*4/beta[56]*(1/(2*beta[56]) - 1)*((f.delta - 1)^2)^(1/(2*beta[
          56]) - 2) + 4*BB[56]*a[56]*(a[56] - 1)*((f.delta - 1)^2)^(a[56] - 2));
        //Second derivative of Deltab[55,56] w.r.t. delta
        Deltab55deltadelta := b[55]*(Delta55^(b[55] - 1)*Delta55deltadelta + (b[
          55] - 1)*Delta55^(b[55] - 2)*Delta55delta^2);
        Deltab56deltadelta := b[56]*(Delta56^(b[56] - 1)*Delta56deltadelta + (b[
          56] - 1)*Delta56^(b[56] - 2)*Delta56delta^2);
        //Second derivative of psi[55,56] w.r.t. delta
        psi55deltadelta := (2*CC[55]*(f.delta - 1)^2 - 1)*2*CC[55]*psi55;
        psi56deltadelta := (2*CC[56]*(f.delta - 1)^2 - 1)*2*CC[56]*psi56;
        //Second derivative of Delta[55,56] w.r.t. tau
        Delta55tautau := 2;
        Delta56tautau := 2;
        //Second derivative of Deltab[55,56] w.r.t. tau
        Deltab55tautau := 2*b[55]*Delta55^(b[55] - 1) + 4*theta55^2*b[55]*(b[55]
           - 1)*Delta55^(b[55] - 2);
        Deltab56tautau := 2*b[56]*Delta55^(b[56] - 1) + 4*theta56^2*b[56]*(b[56]
           - 1)*Delta56^(b[56] - 2);
        //Second derivative of psi[55,56] w.r.t. tau
        psi55tautau := (2*DD[55]*(f.tau - 1)^2 - 1)*2*DD[55]*psi55;
        psi56tautau := (2*DD[56]*(f.tau - 1)^2 - 1)*2*DD[56]*psi56;
        //Mixed derivative of Delta[55,56] w.r.t. delta and tau
        Delta55deltatau := -(f.delta - 1)*AA[55]*2/beta[55]*((f.delta - 1)^2)^(
          1/(2*beta[55]) - 1);
        Delta56deltatau := -(f.delta - 1)*AA[56]*2/beta[56]*((f.delta - 1)^2)^(
          1/(2*beta[56]) - 1);
        //Mixed derivative of Deltab[55,56] w.r.t. delta and tau
        Deltab55deltatau := -AA[55]*b[55]*2/beta[55]*Delta55^(b[55] - 1)*(f.delta
           - 1)*((f.delta - 1)^2)^(1/(2*beta[55]) - 1) - 2*theta55*b[55]*(b[55]
           - 1)*Delta55^(b[55] - 2)*Delta55delta;
        Deltab56deltatau := -AA[56]*b[56]*2/beta[56]*Delta56^(b[56] - 1)*(f.delta
           - 1)*((f.delta - 1)^2)^(1/(2*beta[56]) - 1) - 2*theta56*b[56]*(b[56]
           - 1)*Delta56^(b[56] - 2)*Delta56delta;
        //Mixed derivative of psi[55,56] w.r.t. delta and tau
        psi55deltatau := 4*CC[55]*DD[55]*(f.delta - 1)*(f.tau - 1)*psi55;
        psi56deltatau := 4*CC[56]*DD[56]*(f.delta - 1)*(f.tau - 1)*psi56;

        //Dimensionless Helmholtz equation
        f.f := 0;
        //Ideal-gas part
        f.f := log(f.delta) + N_0[1] + N_0[2]*f.tau + N_0[3]*log(f.tau);
        for k in 4:8 loop
          f.f := f.f + N_0[k]*log(1 - exp(-gamma_0[k]*f.tau));
        end for;
        //Residual part
        for k in 1:7 loop
          f.f := f.f + N[k]*f.delta^dd[k]*f.tau^t[k];
        end for;
        for k in 8:51 loop
          f.f := f.f + N[k]*f.delta^dd[k]*f.tau^t[k]*exp(-f.delta^c[k]);
        end for;
        for k in 52:54 loop
          f.f := f.f + N[k]*f.delta^dd[k]*f.tau^t[k]*exp(-alpha[k]*(f.delta -
            epsilon[k])^2 - beta[k]*(f.tau - gamma[k])^2);
        end for;
        f.f := f.f + f.delta*(N[55]*Delta55^b[55]*psi55 + N[56]*Delta56^b[56]*
          psi56);

        //First derivative of f w.r.t. delta
        f.fdelta := 0;
        //Ideal-gas part
        f.fdelta := 1/f.delta;
        //Residual part
        for k in 1:7 loop
          f.fdelta := f.fdelta + N[k]*dd[k]*f.delta^(dd[k] - 1)*f.tau^t[k];
        end for;
        for k in 8:51 loop
          f.fdelta := f.fdelta + N[k]*exp(-f.delta^c[k])*(f.delta^(dd[k] - 1)*f.tau
            ^t[k]*(dd[k] - c[k]*f.delta^c[k]));
        end for;
        for k in 52:54 loop
          f.fdelta := f.fdelta + N[k]*f.delta^dd[k]*f.tau^t[k]*exp(-alpha[k]*(f.delta
             - epsilon[k])^2 - beta[k]*(f.tau - gamma[k])^2)*(dd[k]/f.delta - 2
            *alpha[k]*(f.delta - epsilon[k]));
        end for;
        f.fdelta := f.fdelta + N[55]*(Delta55^b[55]*(psi55 + f.delta*psi55delta)
           + Deltab55delta*f.delta*psi55) + N[56]*(Delta56^b[56]*(psi56 + f.delta
          *psi56delta) + Deltab56delta*f.delta*psi56);

        //Second derivative of f w.r.t. delta
        f.fdeltadelta := 0;
        //Ideal-gas part
        f.fdeltadelta := -1/f.delta^2;
        //Residual part
        for k in 1:7 loop
          f.fdeltadelta := f.fdeltadelta + N[k]*dd[k]*(dd[k] - 1)*f.delta^(dd[k]
             - 2)*f.tau^t[k];
        end for;
        for k in 8:51 loop
          f.fdeltadelta := f.fdeltadelta + N[k]*exp(-f.delta^c[k])*(f.delta^(dd[
            k] - 2)*f.tau^t[k]*((dd[k] - c[k]*f.delta^c[k])*(dd[k] - 1 - c[k]*f.delta
            ^c[k]) - c[k]^2*f.delta^c[k]));
        end for;
        for k in 52:54 loop
          f.fdeltadelta := f.fdeltadelta + N[k]*f.tau^t[k]*exp(-alpha[k]*(f.delta
             - epsilon[k])^2 - beta[k]*(f.tau - gamma[k])^2)*(-2*alpha[k]*f.delta
            ^dd[k] + 4*alpha[k]^2*f.delta^dd[k]*(f.delta - epsilon[k])^2 - 4*dd[
            k]*alpha[k]*f.delta^(dd[k] - 1)*(f.delta - epsilon[k]) + dd[k]*(dd[
            k] - 1)*f.delta^(dd[k] - 2));
        end for;
        f.fdeltadelta := f.fdeltadelta + N[55]*(Delta55^b[55]*(2*psi55delta + f.delta
          *psi55deltadelta) + 2*Deltab55delta*(psi55 + f.delta*psi55delta) +
          Deltab55deltadelta*f.delta*psi55) + N[56]*(Delta56^b[56]*(2*
          psi56delta + f.delta*psi56deltadelta) + 2*Deltab56delta*(psi56 + f.delta
          *psi56delta) + Deltab56deltadelta*f.delta*psi56);

        //First derivative of f w.r.t. tau
        f.ftau := 0;
        //Ideal-gas part
        f.ftau := N_0[2] + N_0[3]/f.tau;
        for k in 4:8 loop
          f.ftau := f.ftau + N_0[k]*gamma_0[k]/(exp(gamma_0[k]*f.tau) - 1);
        end for;
        //Residual part
        for k in 1:7 loop
          f.ftau := f.ftau + N[k]*t[k]*f.delta^dd[k]*f.tau^(t[k] - 1);
        end for;
        for k in 8:51 loop
          f.ftau := f.ftau + N[k]*t[k]*f.delta^dd[k]*f.tau^(t[k] - 1)*exp(-f.delta
            ^c[k]);
        end for;
        for k in 52:54 loop
          f.ftau := f.ftau + N[k]*f.delta^dd[k]*f.tau^t[k]*exp(-alpha[k]*(f.delta
             - epsilon[k])^2 - beta[k]*(f.tau - gamma[k])^2)*(t[k]/f.tau - 2*
            beta[k]*(f.tau - gamma[k]));
        end for;
        f.ftau := f.ftau + f.delta*(N[55]*(Deltab55tau*psi55 + Delta55^b[55]*
          psi55tau) + N[56]*(Deltab56tau*psi56 + Delta56^b[56]*psi56tau));

        //Second derivative of f w.r.t. tau
        f.ftautau := 0;
        //Ideal-gas part
        f.ftautau := -N_0[3]/f.tau^2;
        for k in 4:8 loop
          f.ftautau := f.ftautau - N_0[k]*gamma_0[k]^2*exp(gamma_0[k]*f.tau)/(
            exp(gamma_0[k]*f.tau) - 1)^2;
        end for;
        //Residual part
        for k in 1:7 loop
          f.ftautau := f.ftautau + N[k]*t[k]*(t[k] - 1)*f.delta^dd[k]*f.tau^(t[
            k] - 2);
        end for;
        for k in 8:51 loop
          f.ftautau := f.ftautau + N[k]*t[k]*(t[k] - 1)*f.delta^dd[k]*f.tau^(t[
            k] - 2)*exp(-f.delta^c[k]);
        end for;
        for k in 52:54 loop
          f.ftautau := f.ftautau + N[k]*f.delta^dd[k]*f.tau^t[k]*exp(-alpha[k]*
            (f.delta - epsilon[k])^2 - beta[k]*(f.tau - gamma[k])^2)*((t[k]/f.tau
             - 2*beta[k]*(f.tau - gamma[k]))^2 - t[k]/f.tau^2 - 2*beta[k]);
        end for;
        f.ftautau := f.ftautau + f.delta*(N[55]*(Deltab55tautau*psi55 + 2*
          Deltab55tau*psi55tau + Delta55^b[55]*psi55tautau) + N[56]*(
          Deltab56tautau*psi56 + 2*Deltab56tau*psi56tau + Delta56^b[56]*
          psi56tautau));

        //Mixed derivative of f w.r.t. delta and tau
        f.fdeltatau := 0;
        //Residual part (Ideal-gas part is zero)
        for k in 1:7 loop
          f.fdeltatau := f.fdeltatau + N[k]*dd[k]*t[k]*f.delta^(dd[k] - 1)*f.tau
            ^(t[k] - 1);
        end for;
        for k in 8:51 loop
          f.fdeltatau := f.fdeltatau + N[k]*t[k]*f.delta^(dd[k] - 1)*f.tau^(t[k]
             - 1)*(dd[k] - c[k]*f.delta^c[k])*exp(-f.delta^c[k]);
        end for;
        for k in 52:54 loop
          f.fdeltatau := f.fdeltatau + N[k]*f.delta^dd[k]*f.tau^t[k]*exp(-alpha[
            k]*(f.delta - epsilon[k])^2 - beta[k]*(f.tau - gamma[k])^2)*(dd[k]/
            f.delta - 2*alpha[k]*(f.delta - epsilon[k]))*(t[k]/f.tau - 2*beta[k]
            *(f.tau - gamma[k]));
        end for;
        f.fdeltatau := f.fdeltatau + N[55]*(Delta55^b[55]*(psi55delta + f.delta
          *psi55deltatau) + f.delta*Deltab55delta*psi55tau + Deltab55tau*(psi55
           + f.delta*psi55delta) + Deltab55deltatau*f.delta*psi55) + N[56]*(
          Delta56^b[56]*(psi56delta + f.delta*psi56deltatau) + f.delta*
          Deltab56delta*psi56tau + Deltab56tau*(psi56 + f.delta*psi56delta) +
          Deltab56deltatau*f.delta*psi56);

      end Helmholtz;

      function psat "saturation pressure"
        extends Modelica.Icons.Function;

        input SI.Temperature T "Temperature";
        output SI.AbsolutePressure p "Pressure";

      protected
        Real theta_s;
        Real A;
        Real B;
        Real C;
        final constant Real[10] n={0.11670521452767E+004,-0.72421316703206E+006,
            -0.17073846940092E+002,0.1202082470247E+005,-0.32325550322333E+007,
            0.1491510861353E+002,-0.48232657361591E+004,0.40511340542057E+006,-0.23855557567849,
            0.65017534844798E+003};
      algorithm
        theta_s := min(T, 553) + n[9]/(min(T, 553) - n[10]);
        A := theta_s^2 + n[1]*theta_s + n[2];
        B := n[3]*theta_s^2 + n[4]*theta_s + n[5];
        C := n[6]*theta_s^2 + n[7]*theta_s + n[8];
        p := (2*C/(-B + sqrt(B^2 - 4*A*C)))^4*1E+006;
        annotation (
          derivative=psat_der,
          Inline=false,
          LateInline=true);
      end psat;

      function Tsat "saturation temperature"
        extends Modelica.Icons.Function;

        input SI.AbsolutePressure p "Pressure";
        output SI.Temperature T "Temperature";

      protected
        Real beta;
        Real D;
        Real E;
        Real F;
        Real G;
        final constant Real[10] n={0.11670521452767E+004,-0.72421316703206E+006,
            -0.17073846940092E+002,0.1202082470247E+005,-0.32325550322333E+007,
            0.1491510861353E+002,-0.48232657361591E+004,0.40511340542057E+006,-0.23855557567849,
            0.65017534844798E+003};

      algorithm
        beta := (p*1E-006)^0.25;
        E := beta^2 + n[3]*beta + n[6];
        F := n[1]*beta^2 + n[4]*beta + n[7];
        G := n[2]*beta^2 + n[5]*beta + n[8];
        D := 2*G/(-F - sqrt(F^2 - 4*E*G));
        T := (n[10] + D - sqrt((n[10] + D)^2 - 4*(n[9] + n[10]*D)))/2;
        annotation (
          derivative=Tsat_der,
          Inline=false,
          LateInline=true);
      end Tsat;

      function psat_der "saturation pressure"
        extends Modelica.Icons.Function;

        input SI.Temperature T "Temperature";
        input Real T_der "derivative of temperature";
        output Real p_der "derivative of pressure w.r.t. temperature";

      protected
        Real theta_s, theta_s_der;
        Real A, A_der;
        Real B, B_der;
        Real C, C_der, o_der[3];
        final constant Real[10] n={0.11670521452767E+004,-0.72421316703206E+006,
            -0.17073846940092E+002,0.1202082470247E+005,-0.32325550322333E+007,
            0.1491510861353E+002,-0.48232657361591E+004,0.40511340542057E+006,-0.23855557567849,
            0.65017534844798E+003};
      algorithm
        theta_s := min(T, 553) + n[9]/(min(T, 553) - n[10]);
        theta_s_der := (1 - n[9]/(min(T, 553) - n[10])^2);

        A := theta_s^2 + n[1]*theta_s + n[2];
        B := n[3]*theta_s^2 + n[4]*theta_s + n[5];
        C := n[6]*theta_s^2 + n[7]*theta_s + n[8];
        A_der := 2*theta_s*theta_s_der + n[1]*theta_s_der;
        B_der := 2*n[3]*theta_s*theta_s_der + n[4]*theta_s_der;
        C_der := 2*n[6]*theta_s*theta_s_der + n[7]*theta_s_der;
        o_der[1] := 2*B*B_der - 4*(A*C_der + A_der*C);
        o_der[2] := -B_der + 0.5/sqrt(B^2 - 4*A*C)*o_der[1];
        o_der[3] := ((2*C_der*(-B + sqrt(B^2 - 4*A*C))) - 2*C*o_der[2])/(-B +
          sqrt(B^2 - 4*A*C))^2;

        p_der := 4*((2*C/(-B + sqrt(B^2 - 4*A*C))))^3*o_der[3]*1E+006*T_der;

      end psat_der;

      function Tsat_der "derivative of saturation temperature"
        extends Modelica.Icons.Function;

        input SI.AbsolutePressure p "Pressure";
        input Real p_der "Pressure derivative";
        output Real T_der "Temperature derivative";

      protected
        Real beta, beta_der;
        Real D, D_der;
        Real E, E_der;
        Real F, F_der;
        Real G, G_der;
        Real o_der[2];
        final constant Real[10] n={0.11670521452767E+004,-0.72421316703206E+006,
            -0.17073846940092E+002,0.1202082470247E+005,-0.32325550322333E+007,
            0.1491510861353E+002,-0.48232657361591E+004,0.40511340542057E+006,-0.23855557567849,
            0.65017534844798E+003};

      algorithm
        beta := (p*1E-006)^0.25;
        beta_der := 0.25/(p*1E-006)^0.75*1E-006;
        E := beta^2 + n[3]*beta + n[6];
        E_der := 2*beta*beta_der + n[3];
        F := n[1]*beta^2 + n[4]*beta + n[7];
        F_der := 2*n[1]*beta*beta_der + n[4];
        G := n[2]*beta^2 + n[5]*beta + n[8];
        G_der := 2*n[2]*beta*beta_der + n[5];
        D := 2*G/(-F - sqrt(F^2 - 4*E*G));
        o_der[1] := 2*F*F_der - 4*(E*G_der + E_der*G);
        o_der[2] := -F_der - 0.5/sqrt(F^2 - 4*E*G)*o_der[1];
        D_der := ((2*G_der*(-F - sqrt(F^2 - 4*E*G))) - 2*G*o_der[2])/(-F - sqrt(
          F^2 - 4*E*G))^2;
        T_der := (D_der - 0.5/sqrt((n[10] + D)^2 - 4*(n[9] + n[10]*D))*(2*D*
          D_der - 2*n[10]*D_der))/2*p_der;
      end Tsat_der;
    end Basic;

    package Inverses "Inverse function"
      extends Modelica.Icons.BasesPackage;

      record accuracy "Accuracy of the iterations"
        extends Modelica.Icons.Record;
        constant Real delp=1E-001 "Accuracy of p";
        constant Real delh=1E-009 "Accuracy of h";
        constant Real dels=1E-006 "Accuracy of s";
      end accuracy;

      function dofpT "Compute d for given p and T"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.Temperature T "temperature (K)";
        input SI.Pressure delp "iteration converged if (p-pre(p) < delp)";
        output SI.Density d "density";

      protected
        Integer i=0 "loop counter";
        Real dp "pressure difference";
        SI.Density deld "density step";
        Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
        Modelica.Media.Common.NewtonDerivatives_pT nDerivs
          "derivatives needed in Newton iteration";
        Boolean found=false "flag for iteration success";

      algorithm
        d := Modelica.Media.Water.IF97_Utilities.rho_pT(p, T);

        while ((i < 1000) and not found) loop
          f := Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Helmholtz(d,
            T);
          nDerivs := Modelica.Media.Common.Helmholtz_pT(f);
          dp := nDerivs.p - p;
          if (abs(dp) <= delp) then
            found := true;
          end if;
          deld := dp/nDerivs.pd;
          d := d - deld;
          i := i + 1;
        end while;
      end dofpT;

      function dTofph "Return d and T as a function of p and h"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEnthalpy h "specific enthalpy";
        input SI.Pressure delp "iteration accuracy";
        input SI.SpecificEnthalpy delh "iteration accuracy";
        output SI.Density d "density";
        output SI.Temperature T "temperature (K)";

      protected
        Integer i "iteration counter";
        Real dh "Newton-error in h-direction";
        Real dp "Newton-error in p-direction";
        Real det "determinant of directional derivatives";
        Real deld "Newton-step in d-direction";
        Real delt "Newton-step in T-direction";
        Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
        Modelica.Media.Common.NewtonDerivatives_ph nDerivs
          "derivatives needed in Newton iteration";
        Boolean found=false "flag for iteration success";

      algorithm
        T := Modelica.Media.Water.IF97_Utilities.T_ph(p, h);
        d := Modelica.Media.Water.IF97_Utilities.rho_ph(p, h);
        i := 0;

        while ((i < 100) and not found) loop
          f := Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Helmholtz(d,
            T);
          nDerivs := Modelica.Media.Common.Helmholtz_ph(f);
          dh := nDerivs.h - Water95_Utilities.Basic.Constants.h_off - h;
          dp := nDerivs.p - p;
          if ((abs(dh) <= delh) and (abs(dp) <= delp)) then
            found := true;
          end if;
          det := nDerivs.ht*nDerivs.pd - nDerivs.pt*nDerivs.hd;
          delt := (nDerivs.pd*dh - nDerivs.hd*dp)/det;
          deld := (nDerivs.ht*dp - nDerivs.pt*dh)/det;
          T := T - delt;
          d := d - deld;
          i := i + 1;

        end while;
      end dTofph;

      function dTofps "Return d and T as a function of p and s"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEntropy s "specific entropy";
        input SI.Pressure delp "iteration accuracy";
        input SI.SpecificEntropy dels "iteration accuracy";
        output SI.Density d "density";
        output SI.Temperature T "temperature (K)";

      protected
        Integer i "iteration counter";
        Real ds "Newton-error in s-direction";
        Real dp "Newton-error in p-direction";
        Real det "determinant of directional derivatives";
        Real deld "Newton-step in d-direction";
        Real delt "Newton-step in T-direction";
        Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
        Modelica.Media.Common.NewtonDerivatives_ps nDerivs
          "derivatives needed in Newton iteration";
        Boolean found=false "flag for iteration success";

      algorithm
        T := Modelica.Media.Water.IF97_Utilities.T_ps(p, s);
        d := Modelica.Media.Water.IF97_Utilities.rho_ps(p, s);
        i := 0;

        while ((i < 100) and not found) loop
          f := Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Helmholtz(d,
            T);
          nDerivs := Modelica.Media.Common.Helmholtz_ps(f);
          ds := nDerivs.s - Water95_Utilities.Basic.Constants.s_off - s;
          dp := nDerivs.p - p;
          if ((abs(ds) <= dels) and (abs(dp) <= delp)) then
            found := true;
          end if;
          det := nDerivs.st*nDerivs.pd - nDerivs.pt*nDerivs.sd;
          delt := (nDerivs.pd*ds - nDerivs.sd*dp)/det;
          deld := (nDerivs.st*dp - nDerivs.pt*ds)/det;
          T := T - delt;
          d := d - deld;
          i := i + 1;
        end while;
      end dTofps;
    end Inverses;

    package Transport "Transport properties for air"
      extends Modelica.Icons.BasesPackage;

      function eta_dT "Return dynamic viscosity as a function of d and T"
        extends Modelica.Icons.Function;
        input SI.Density d "Density";
        input SI.Temperature T "Temperature";
        output SI.DynamicViscosity eta "Dynamic viscosity";

      protected
        Real delta=d/(Water95_Utilities.Basic.Constants.MM*Water95_Utilities.Basic.Constants.rhored)
          "Reduced density";
        Real tau=Water95_Utilities.Basic.Constants.Tred/T
          "Reciprocal reduced temperature";
        Real Omega "Collision integral";
        SI.DynamicViscosity eta_0=0 "Dilute gas viscosity";
        SI.DynamicViscosity eta_r=0 "Residual fluid viscosity";
        final constant Real[5] b={0.431,-0.4623,0.08406,0.005341,-0.00331};
        final constant Real[5] Nvis={10.72,1.122,0.002019,-8.876,-0.02916};
        final constant Real[5] tvis={0.2,0.05,2.4,0.6,3.6};
        final constant Integer[5] dvis={1,4,9,1,8};
        final constant Integer[5] lvis={0,0,0,1,1};
        final constant Integer[5] gammavis={0,0,0,1,1};

      algorithm
        Omega := exp(
          Modelica.Media.Incompressible.TableBased.Polynomials_Temp.evaluate({b[
          5],b[4],b[3],b[2],b[1]}, log(T/103.3)));
        eta_0 := 0.0266958*sqrt(1000*Water95_Utilities.Basic.Constants.MM*T)/(
          0.36^2*Omega);
        for i in 1:5 loop
          eta_r := eta_r + (Nvis[i]*(tau^tvis[i])*(delta^dvis[i])*exp(-gammavis[
            i]*(delta^lvis[i])));
        end for;
        eta := (eta_0 + eta_r)*1E-006;
      end eta_dT;

      function lambda_dT "Return thermal conductivity as a function of d and T"
        extends Modelica.Icons.Function;
        input SI.Density d "Density";
        input SI.Temperature T "Temperature";
        output SI.ThermalConductivity lambda "Thermal conductivity";

      protected
        Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
        SI.ThermalConductivity lambda_0=0 "Dilute gas thermal conductivity";
        SI.ThermalConductivity lambda_r=0 "Residual fluid thermal conductivity";
        SI.ThermalConductivity lambda_c=0
          "Thermal conductivity critical enhancement";
        Real Omega "Collision integral";
        SI.DynamicViscosity eta_0=0 "Dilute gas viscosity";
        Real pddT;
        Real pddTref;
        Real pdTp;
        Real xi;
        Real xiref;
        Real Omega_tilde;
        Real Omega_0_tilde;
        Real cv;
        Real cp;
        final constant Real[5] b={0.431,-0.4623,0.08406,0.005341,-0.00331};
        final constant Real[9] Ncon={1.308,1.405,-1.036,8.743,14.76,-16.62,
            3.793,-6.142,-0.3778};
        final constant Real[9] tcon={0.0,-1.1,-0.3,0.1,0.0,0.5,2.7,0.3,1.3};
        final constant Integer[9] dcon={0,0,0,1,2,3,7,7,11};
        final constant Integer[9] lcon={0,0,0,0,0,2,2,2,2};
        final constant Integer[9] gammacon={0,0,0,0,0,1,1,1,1};

      algorithm
        //chi_tilde in at the reference temperature 265.262
        f := Basic.Helmholtz(d, 265.262);
        pddTref := Water95_Utilities.Basic.Constants.R_bar*265.262*(1 + 2*f.delta
          *(f.fdelta - 1/f.delta) + f.delta^2*(f.fdeltadelta + 1/f.delta^2));
        xiref := Water95_Utilities.Basic.Constants.pred*(d/Water95_Utilities.Basic.Constants.MM)
          /Water95_Utilities.Basic.Constants.rhored^2/pddTref;
        //calculating f at the given state
        f := Basic.Helmholtz(d, T);
        Omega := exp(
          Modelica.Media.Incompressible.TableBased.Polynomials_Temp.evaluate({b[
          5],b[4],b[3],b[2],b[1]}, log(T/103.3)));
        //Ideal-gas part of dynamic viscosity
        eta_0 := 0.0266958*sqrt(1000*Water95_Utilities.Basic.Constants.MM*T)/(
          0.36^2*Omega);
        //Ideal-gas part of thermal conductivity
        lambda_0 := Ncon[1]*eta_0 + Ncon[2]*f.tau^tcon[2] + Ncon[3]*f.tau^tcon[
          3];
        //Residual part of thermal conductivity
        for i in 4:9 loop
          lambda_r := lambda_r + Ncon[i]*f.tau^tcon[i]*f.delta^dcon[i]*exp(-
            gammacon[i]*f.delta^lcon[i]);
        end for;
        //Derivative of p w.r.t. d at constant temperature
        pddT := Water95_Utilities.Basic.Constants.R*T*(1 + 2*f.delta*(f.fdelta
           - 1/f.delta) + f.delta^2*(f.fdeltadelta + 1/f.delta^2));
        //chi_tilde at the given state
        xi := Water95_Utilities.Basic.Constants.pred*(d/Water95_Utilities.Basic.Constants.MM)
          /Water95_Utilities.Basic.Constants.rhored^2/(pddT*Water95_Utilities.Basic.Constants.MM);
        //Thermal conductivity critical enhancement
        xi := xi - xiref*265.262/T;
        if (xi <= 0) then
          lambda_c := 0;
        else
          xi := 0.11*(xi/0.055)^(0.63/1.2415);
          //Derivative of p w.r.t. T at constant p
          pdTp := Water95_Utilities.Basic.Constants.R*d*(1 + f.delta*(f.fdelta
             - 1/f.delta) - f.delta*f.tau*f.fdeltatau);
          //Specific isochoric heat capacity
          cv := Water95_Utilities.Basic.Constants.R*(-f.tau*f.tau*f.ftautau);
          //Specific isobaric heat capacity
          cp := cv + T*pdTp*pdTp/(d*d*pddT);
          Omega_tilde := 2/Modelica.Constants.pi*((cp - cv)/cp*atan(xi/0.31) +
            cv/cp*xi/0.31);
          Omega_0_tilde := 2/Modelica.Constants.pi*(1 - exp(-1/((0.31/xi) + 1/3
            *(xi/0.31)^2*(Water95_Utilities.Basic.Constants.rhored/(d/
            Water95_Utilities.Basic.Constants.MM))^2)));
          lambda_c := d*cp*1.380658E-023*1.01*T/(6*Modelica.Constants.pi*xi*
            eta_dT(d, T))*(Omega_tilde - Omega_0_tilde)*1E012;
        end if;
        lambda := (lambda_0 + lambda_r + lambda_c)/1000;
      end lambda_dT;
    end Transport;

    function water95BaseProp_ps "intermediate property record for air"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEntropy s "specific entropy";
      output Common.AuxiliaryProperties aux "auxiliary record";
    protected
      Modelica.Media.Common.HelmholtzDerivs f
        "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
    algorithm
      aux.p := p;
      aux.s := s;
      aux.R := Water95_Utilities.Basic.Constants.R;
      (aux.rho,aux.T) := Inverses.dTofps(
            p=p,
            s=s,
            delp=iter.delp,
            dels=iter.dels);
      f := Basic.Helmholtz(aux.rho, aux.T);
      aux.h := aux.R*aux.T*(f.tau*f.ftau + f.delta*f.fdelta) -
        Water95_Utilities.Basic.Constants.h_off;
      aux.pd := aux.R*aux.T*f.delta*(2*f.fdelta + f.delta*f.fdeltadelta);
      aux.pt := aux.R*aux.rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
      aux.cp := aux.cv + aux.T*aux.pt*aux.pt/(aux.rho*aux.rho*aux.pd);
      aux.vp := -1/(aux.rho*aux.rho)*1/aux.pd;
      aux.vt := aux.pt/(aux.rho*aux.rho*aux.pd);
    end water95BaseProp_ps;

    function rho_props_ps
      "density as function of pressure and specific entropy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEntropy s "specific entropy";
      input Common.AuxiliaryProperties properties "auxiliary record";
      output Modelica.SIunits.Density rho "density";
    algorithm
      rho := properties.rho;
      annotation (Inline=false, LateInline=true);
    end rho_props_ps;

    function rho_ps "density as function of pressure and specific entropy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEntropy s "specific entropy";
      output Modelica.SIunits.Density rho "density";
    algorithm
      rho := rho_props_ps(
            p,
            s,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_ps(p,
          s));

    end rho_ps;

    function T_props_ps
      "temperature as function of pressure and specific entropy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEntropy s "specific entropy";
      input Common.AuxiliaryProperties properties "auxiliary record";
      output Modelica.SIunits.Temperature T "temperature";
    algorithm
      T := properties.T;
      annotation (Inline=false, LateInline=true);
    end T_props_ps;

    function T_ps "temperature as function of pressure and specific entropy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEntropy s "specific entropy";
      output Modelica.SIunits.Temperature T "Temperature";
    algorithm
      T := T_props_ps(
            p,
            s,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_ps(p,
          s));

    end T_ps;

    function h_props_ps
      "specific enthalpy as function or pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEntropy s "specific entropy";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := aux.h;
      annotation (Inline=false, LateInline=true);
    end h_props_ps;

    function h_ps "specific enthalpy as function or pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEntropy s "specific entropy";
      output Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := h_props_ps(
            p,
            s,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_ps(p,
          s));

    end h_ps;

    function water95BaseProp_ph "intermediate property record for air"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      output Common.AuxiliaryProperties aux "auxiliary record";
    protected
      Modelica.Media.Common.HelmholtzDerivs f
        "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
      Integer error "error flag for inverse iterations";
    algorithm
      aux.p := p;
      aux.h := h;
      aux.R := Water95_Utilities.Basic.Constants.R;
      (aux.rho,aux.T) := Inverses.dTofph(
            p,
            h,
            delp=iter.delp,
            delh=iter.delh);
      f := Basic.Helmholtz(aux.rho, aux.T);
      aux.s := aux.R*(f.tau*f.ftau - f.f) - Water95_Utilities.Basic.Constants.s_off;
      aux.pd := aux.R*aux.T*f.delta*(2*f.fdelta + f.delta*f.fdeltadelta);
      aux.pt := aux.R*aux.rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
      aux.cp := aux.cv + aux.T*aux.pt*aux.pt/(aux.rho*aux.rho*aux.pd);
      aux.vp := -1/(aux.rho*aux.rho)*1/aux.pd;
      aux.vt := aux.pt/(aux.rho*aux.rho*aux.pd);
    end water95BaseProp_ph;

    function rho_props_ph
      "density as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties properties "auxiliary record";
      output Modelica.SIunits.Density rho "density";
    algorithm
      rho := properties.rho;
      annotation (
        derivative(noDerivative=properties) = rho_ph_der,
        Inline=false,
        LateInline=true);
    end rho_props_ph;

    function rho_ph "density as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      output Modelica.SIunits.Density rho "density";
    algorithm
      rho := rho_props_ph(
            p,
            h,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_ph(p,
          h));

    end rho_ph;

    function rho_ph_der "derivative function of rho_ph"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties aux "auxiliary record";
      input Real p_der "derivative of pressure";
      input Real h_der "derivative of specific enthalpy";
      output Real rho_der "derivative of density";
    algorithm
      rho_der := ((aux.rho*(aux.cv*aux.rho + aux.pt))/(aux.rho*aux.rho*aux.pd*
        aux.cv + aux.T*aux.pt*aux.pt))*p_der + (-aux.rho*aux.rho*aux.pt/(aux.rho
        *aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt))*h_der;
    end rho_ph_der;

    function T_props_ph
      "temperature as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties properties "auxiliary record";
      output Modelica.SIunits.Temperature T "temperature";
    algorithm
      T := properties.T;
      annotation (
        derivative(noDerivative=properties) = T_ph_der,
        Inline=false,
        LateInline=true);
    end T_props_ph;

    function T_ph "temperature as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      output Modelica.SIunits.Temperature T "Temperature";
    algorithm
      T := T_props_ph(
            p,
            h,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_ph(p,
          h));

    end T_ph;

    function T_ph_der "derivative function of T_ph"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties aux "auxiliary record";
      input Real p_der "derivative of pressure";
      input Real h_der "derivative of specific enthalpy";
      output Real T_der "derivative of temperature";
    algorithm
      T_der := ((-aux.rho*aux.pd + aux.T*aux.pt)/(aux.rho*aux.rho*aux.pd*aux.cv
         + aux.T*aux.pt*aux.pt))*p_der + ((aux.rho*aux.rho*aux.pd)/(aux.rho*aux.rho
        *aux.pd*aux.cv + aux.T*aux.pt*aux.pt))*h_der;
    end T_ph_der;

    function s_props_ph
      "specific entropy as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties properties "auxiliary record";
      output Modelica.SIunits.SpecificEntropy s "specific entropy";
    algorithm
      s := properties.s;
      annotation (
        derivative(noDerivative=properties) = s_ph_der,
        Inline=false,
        LateInline=true);
    end s_props_ph;

    function s_ph
      "specific entropy as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      output Modelica.SIunits.SpecificEntropy s "specific entropy";
    algorithm
      s := s_props_ph(
            p,
            h,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_ph(p,
          h));

    end s_ph;

    function s_ph_der
      "specific entropy as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties aux "auxiliary record";
      input Real p_der "derivative of pressure";
      input Real h_der "derivative of specific enthalpy";
      output Real s_der "derivative of entropy";
    algorithm
      s_der := -1/(aux.rho*aux.T)*p_der + 1/aux.T*h_der;
    end s_ph_der;

    function cv_props_ph
      "specific heat capacity at constant volume as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.SpecificHeatCapacity cv "specific heat capacity";
    algorithm
      cv := aux.cv;
      annotation (Inline=false, LateInline=true);
    end cv_props_ph;

    function cv_ph
      "specific heat capacity at constant volume as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      output Modelica.SIunits.SpecificHeatCapacity cv "specific heat capacity";
    algorithm
      cv := cv_props_ph(
            p,
            h,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_ph(p,
          h));

    end cv_ph;

    function cp_props_ph
      "specific heat capacity at constant pressure as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.SpecificHeatCapacity cp "specific heat capacity";
    algorithm
      cp := aux.cp;
      annotation (Inline=false, LateInline=true);
    end cp_props_ph;

    function cp_ph
      "specific heat capacity at constant pressure as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      output Modelica.SIunits.SpecificHeatCapacity cp "specific heat capacity";
    algorithm
      cp := cp_props_ph(
            p,
            h,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_ph(p,
          h));

    end cp_ph;

    function beta_props_ph
      "isobaric expansion coefficient as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.RelativePressureCoefficient beta
        "isobaric expansion coefficient";
    algorithm
      beta := aux.pt/(aux.rho*aux.pd);
      annotation (Inline=false, LateInline=true);
    end beta_props_ph;

    function beta_ph
      "isobaric expansion coefficient as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      output Modelica.SIunits.RelativePressureCoefficient beta
        "isobaric expansion coefficient";
    algorithm
      beta := beta_props_ph(
            p,
            h,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_ph(p,
          h));

    end beta_ph;

    function kappa_props_ph
      "isothermal compressibility factor as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.IsothermalCompressibility kappa
        "isothermal compressibility factor";
    algorithm
      kappa := 1/(aux.rho*aux.pd);
      annotation (Inline=false, LateInline=true);
    end kappa_props_ph;

    function kappa_ph
      "isothermal compressibility factor as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      output Modelica.SIunits.IsothermalCompressibility kappa
        "isothermal compressibility factor";
    algorithm
      kappa := kappa_props_ph(
            p,
            h,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_ph(p,
          h));

    end kappa_ph;

    function velocityOfSound_props_ph
      "speed of sound as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.Velocity a "speed of sound";
    algorithm
      a := sqrt(max(0, aux.pd + aux.pt*aux.pt*aux.T/(aux.rho*aux.rho*aux.cv)));
      annotation (Inline=false, LateInline=true);
    end velocityOfSound_props_ph;

    function velocityOfSound_ph
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      output Modelica.SIunits.Velocity a "speed of sound";
    algorithm
      a := velocityOfSound_props_ph(
            p,
            h,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_ph(p,
          h));

    end velocityOfSound_ph;

    function isentropicExponent_props_ph
      "isentropic exponent as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Real gamma "isentropic exponent";
    algorithm
      gamma := 1/(aux.rho*p)*((aux.pd*aux.cv*aux.rho*aux.rho + aux.pt*aux.pt*
        aux.T)/(aux.cv));
      annotation (Inline=false, LateInline=true);
    end isentropicExponent_props_ph;

    function isentropicExponent_ph
      "isentropic exponent as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      output Real gamma "isentropic exponent";
    algorithm
      gamma := isentropicExponent_props_ph(
            p,
            h,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_ph(p,
          h));

      annotation (Inline=false, LateInline=true);
    end isentropicExponent_ph;

    function ddph_props "density derivative by pressure"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.DerDensityByPressure ddph
        "density derivative by pressure";
    algorithm
      ddph := ((aux.rho*(aux.cv*aux.rho + aux.pt))/(aux.rho*aux.rho*aux.pd*aux.cv
         + aux.T*aux.pt*aux.pt));
      annotation (Inline=false, LateInline=true);
    end ddph_props;

    function ddph "density derivative by pressure"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      output Modelica.SIunits.DerDensityByPressure ddph
        "density derivative by pressure";
    algorithm
      ddph := ddph_props(
            p,
            h,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_ph(p,
          h));

    end ddph;

    function ddhp_props "density derivative by specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.DerDensityByEnthalpy ddhp
        "density derivative by specific enthalpy";
    algorithm
      ddhp := -aux.rho*aux.rho*aux.pt/(aux.rho*aux.rho*aux.pd*aux.cv + aux.T*
        aux.pt*aux.pt);
      annotation (Inline=false, LateInline=true);
    end ddhp_props;

    function ddhp "density derivative by specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      output Modelica.SIunits.DerDensityByEnthalpy ddhp
        "density derivative by specific enthalpy";
    algorithm
      ddhp := ddhp_props(
            p,
            h,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_ph(p,
          h));

    end ddhp;

    function water95BaseProp_pT
      "intermediate property record for air (p and T prefered states)"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      output Common.AuxiliaryProperties aux "auxiliary record";
    protected
      Modelica.Media.Common.HelmholtzDerivs f
        "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
    algorithm
      aux.p := p;
      aux.T := T;
      aux.R := Water95_Utilities.Basic.Constants.R;
      aux.rho := Modelica.Media.Water.IAPWS95.Water95_Utilities.Inverses.dofpT(
            p=p,
            T=T,
            delp=iter.delp);
      f := Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Helmholtz(aux.rho,
        T);
      aux.h := aux.R*T*(f.tau*f.ftau + f.delta*f.fdelta) - Water95_Utilities.Basic.Constants.h_off;
      aux.s := aux.R*(f.tau*f.ftau - f.f) - Water95_Utilities.Basic.Constants.s_off;
      aux.pd := aux.R*T*f.delta*(2*f.fdelta + f.delta*f.fdeltadelta);
      aux.pt := aux.R*aux.rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
      aux.cp := aux.cv + aux.T*aux.pt*aux.pt/(aux.rho*aux.rho*aux.pd);
      aux.vp := -1/(aux.rho*aux.rho)*1/aux.pd;
      aux.vt := aux.pt/(aux.rho*aux.rho*aux.pd);
    end water95BaseProp_pT;

    function rho_props_pT "density as function or pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.Density rho "density";
    algorithm
      rho := aux.rho;
      annotation (
        derivative(noDerivative=aux) = rho_pT_der,
        Inline=false,
        LateInline=true);
    end rho_props_pT;

    function rho_pT "density as function or pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      output Modelica.SIunits.Density rho "density";
    algorithm
      rho := rho_props_pT(
            p,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_pT(p,
          T));

    end rho_pT;

    function rho_pT_der "derivative function of rho_pT"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      input Real p_der "derivative of pressure";
      input Real T_der "derivative of temperature";
      output Real rho_der "derivative of density";
    algorithm
      rho_der := (1/aux.pd)*p_der - (aux.pt/aux.pd)*T_der;
    end rho_pT_der;

    function h_props_pT
      "specific enthalpy as function or pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := aux.h;
      annotation (
        derivative(noDerivative=aux) = h_pT_der,
        Inline=false,
        LateInline=true);
    end h_props_pT;

    function h_pT "specific enthalpy as function or pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      output Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := h_props_pT(
            p,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_pT(p,
          T));

    end h_pT;

    function h_pT_der "derivative function of h_pT"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      input Real p_der "derivative of pressure";
      input Real T_der "derivative of temperature";
      output Real h_der "derivative of specific enthalpy";
    algorithm
      h_der := ((-aux.rho*aux.pd + T*aux.pt)/(aux.rho*aux.rho*aux.pd))*p_der +
        ((aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)/(aux.rho*aux.rho
        *aux.pd))*T_der;
    end h_pT_der;

    function s_props_pT
      "specific entropy as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.SpecificEntropy s "specific entropy";
    algorithm
      s := aux.s;
      annotation (Inline=false, LateInline=true);
    end s_props_pT;

    function s_pT "temperature as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      output Modelica.SIunits.SpecificEntropy s "specific entropy";
    algorithm
      s := s_props_pT(
            p,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_pT(p,
          T));

    end s_pT;

    function cv_props_pT
      "specific heat capacity at constant volume as function of pressure and temperature"

      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.SpecificHeatCapacity cv "specific heat capacity";
    algorithm
      cv := aux.cv;
      annotation (Inline=false, LateInline=true);
    end cv_props_pT;

    function cv_pT
      "specific heat capacity at constant volume as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      output Modelica.SIunits.SpecificHeatCapacity cv "specific heat capacity";
    algorithm
      cv := cv_props_pT(
            p,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_pT(p,
          T));

    end cv_pT;

    function cp_props_pT
      "specific heat capacity at constant pressure as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.SpecificHeatCapacity cp "specific heat capacity";
    algorithm
      cp := aux.cp;
      annotation (Inline=false, LateInline=true);
    end cp_props_pT;

    function cp_pT
      "specific heat capacity at constant pressure as function of pressure and temperature"

      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      output Modelica.SIunits.SpecificHeatCapacity cp "specific heat capacity";
    algorithm
      cp := cp_props_pT(
            p,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_pT(p,
          T));

    end cp_pT;

    function beta_props_pT
      "isobaric expansion coefficient as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.RelativePressureCoefficient beta
        "isobaric expansion coefficient";
    algorithm
      beta := aux.pt/(aux.rho*aux.pd);
      annotation (Inline=false, LateInline=true);
    end beta_props_pT;

    function beta_pT
      "isobaric expansion coefficient as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      output Modelica.SIunits.RelativePressureCoefficient beta
        "isobaric expansion coefficient";
    algorithm
      beta := beta_props_pT(
            p,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_pT(p,
          T));

    end beta_pT;

    function kappa_props_pT
      "isothermal compressibility factor as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.IsothermalCompressibility kappa
        "isothermal compressibility factor";
    algorithm
      kappa := 1/(aux.rho*aux.pd);
      annotation (Inline=false, LateInline=true);
    end kappa_props_pT;

    function kappa_pT
      "isothermal compressibility factor as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      output Modelica.SIunits.IsothermalCompressibility kappa
        "isothermal compressibility factor";
    algorithm
      kappa := kappa_props_pT(
            p,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_pT(p,
          T));

    end kappa_pT;

    function velocityOfSound_props_pT
      "speed of sound as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.Velocity a "speed of sound";
    algorithm
      a := sqrt(max(0, (aux.pd*aux.rho*aux.rho*aux.cv + aux.pt*aux.pt*aux.T)/(
        aux.rho*aux.rho*aux.cv)));
      annotation (Inline=false, LateInline=true);
    end velocityOfSound_props_pT;

    function velocityOfSound_pT
      "speed of sound as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      output Modelica.SIunits.Velocity a "speed of sound";
    algorithm
      a := velocityOfSound_props_pT(
            p,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_pT(p,
          T));

    end velocityOfSound_pT;

    function isentropicExponent_props_pT
      "isentropic exponent as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Real gamma "isentropic exponent";
    algorithm
      gamma := 1/(aux.rho*p)*((aux.pd*aux.cv*aux.rho*aux.rho + aux.pt*aux.pt*
        aux.T)/(aux.cv));
      annotation (Inline=false, LateInline=true);
    end isentropicExponent_props_pT;

    function isentropicExponent_pT
      "isentropic exponent as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      output Real gamma "isentropic exponent";
    algorithm
      gamma := isentropicExponent_props_pT(
            p,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_pT(p,
          T));

    end isentropicExponent_pT;

    function water95BaseProp_dT
      "intermediate property record for air (d and T prefered states)"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      output Common.AuxiliaryProperties aux "auxiliary record";
    protected
      Modelica.Media.Common.HelmholtzDerivs f
        "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
    algorithm
      aux.rho := d;
      aux.T := T;
      aux.R := Water95_Utilities.Basic.Constants.R;
      f := Basic.Helmholtz(d, T);
      aux.p := aux.R*d*T*f.delta*f.fdelta;
      aux.h := aux.R*T*(f.tau*f.ftau + f.delta*f.fdelta) - Water95_Utilities.Basic.Constants.h_off;
      aux.s := aux.R*(f.tau*f.ftau - f.f) - Water95_Utilities.Basic.Constants.s_off;
      aux.pd := aux.R*T*f.delta*(2*f.fdelta + f.delta*f.fdeltadelta);
      aux.pt := aux.R*d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
      aux.cp := aux.cv + aux.T*aux.pt*aux.pt/(d*d*aux.pd);
      aux.vp := -1/(aux.rho*aux.rho)*1/aux.pd;
      aux.vt := aux.pt/(aux.rho*aux.rho*aux.pd);
    end water95BaseProp_dT;

    function h_props_dT
      "specific enthalpy as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "Temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := aux.h;
      annotation (
        derivative(noDerivative=aux) = h_dT_der,
        Inline=false,
        LateInline=true);
    end h_props_dT;

    function h_dT "specific enthalpy as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "Temperature";
      output Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := h_props_dT(
            d,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_dT(d,
          T));

    end h_dT;

    function h_dT_der "derivative function of h_dT"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      input Real d_der "derivative of density";
      input Real T_der "derivative of temperature";
      output Real h_der "derivative of specific enthalpy";
    algorithm
      h_der := ((-d*aux.pd + T*aux.pt)/(d*d))*d_der + ((aux.cv*d + aux.pt)/d)*
        T_der;
    end h_dT_der;

    function p_props_dT "pressure as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "Temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.Pressure p "pressure";
    algorithm
      p := aux.p;
      annotation (
        derivative(noDerivative=aux) = p_dT_der,
        Inline=false,
        LateInline=true);
    end p_props_dT;

    function p_dT "pressure as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "Temperature";
      output Modelica.SIunits.Pressure p "pressure";
    algorithm
      p := p_props_dT(
            d,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_dT(d,
          T));

    end p_dT;

    function p_dT_der "derivative function of p_dT"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      input Real d_der "derivative of density";
      input Real T_der "derivative of temperature";
      output Real p_der "derivative of pressure";
    algorithm
      p_der := aux.pd*d_der + aux.pt*T_der;
    end p_dT_der;

    function s_props_dT
      "specific entropy as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "Temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.SpecificEntropy s "specific entropy";
    algorithm
      s := aux.s;
      annotation (Inline=false, LateInline=true);
    end s_props_dT;

    function s_dT "temperature as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "Temperature";
      output Modelica.SIunits.SpecificEntropy s "specific entropy";
    algorithm
      s := s_props_dT(
            d,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_dT(d,
          T));

    end s_dT;

    function cv_props_dT
      "specific heat capacity at constant volume as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.SpecificHeatCapacity cv "specific heat capacity";
    algorithm
      cv := aux.cv;
      annotation (Inline=false, LateInline=true);
    end cv_props_dT;

    function cv_dT
      "specific heat capacity at constant volume as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      output Modelica.SIunits.SpecificHeatCapacity cv "specific heat capacity";
    algorithm
      cv := cv_props_dT(
            d,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_dT(d,
          T));

    end cv_dT;

    function cp_props_dT
      "specific heat capacity at constant pressure as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.SpecificHeatCapacity cp "specific heat capacity";
    algorithm
      cp := aux.cp;
      annotation (Inline=false, LateInline=true);
    end cp_props_dT;

    function cp_dT
      "specific heat capacity at constant pressure as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      output Modelica.SIunits.SpecificHeatCapacity cp "specific heat capacity";
    algorithm
      cp := cp_props_dT(
            d,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_dT(d,
          T));

    end cp_dT;

    function beta_props_dT
      "isobaric expansion coefficient as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.RelativePressureCoefficient beta
        "isobaric expansion coefficient";
    algorithm
      beta := aux.pt/(aux.rho*aux.pd);
      annotation (Inline=false, LateInline=true);
    end beta_props_dT;

    function beta_dT
      "isobaric expansion coefficient as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      output Modelica.SIunits.RelativePressureCoefficient beta
        "isobaric expansion coefficient";
    algorithm
      beta := beta_props_dT(
            d,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_dT(d,
          T));

    end beta_dT;

    function kappa_props_dT
      "isothermal compressibility factor as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.IsothermalCompressibility kappa
        "isothermal compressibility factor";
    algorithm
      kappa := 1/(aux.rho*aux.pd);
      annotation (Inline=false, LateInline=true);
    end kappa_props_dT;

    function kappa_dT
      "isothermal compressibility factor as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      output Modelica.SIunits.IsothermalCompressibility kappa
        "isothermal compressibility factor";
    algorithm
      kappa := kappa_props_dT(
            d,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_dT(d,
          T));

    end kappa_dT;

    function velocityOfSound_props_dT
      "speed of sound as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.Velocity a "speed of sound";
    algorithm
      a := sqrt(max(0, ((aux.pd*aux.rho*aux.rho*aux.cv + aux.pt*aux.pt*aux.T)/(
        aux.rho*aux.rho*aux.cv))));
      annotation (Inline=false, LateInline=true);
    end velocityOfSound_props_dT;

    function velocityOfSound_dT
      "speed of sound as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      output Modelica.SIunits.Velocity a "speed of sound";
    algorithm
      a := velocityOfSound_props_dT(
            d,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_dT(d,
          T));

    end velocityOfSound_dT;

    function isentropicExponent_props_dT
      "isentropic exponent as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Real gamma "isentropic exponent";
    algorithm
      gamma := 1/(aux.rho*aux.p)*((aux.pd*aux.cv*aux.rho*aux.rho + aux.pt*aux.pt
        *aux.T)/(aux.cv));
      annotation (Inline=false, LateInline=true);
    end isentropicExponent_props_dT;

    function isentropicExponent_dT
      "isentropic exponent as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      output Real gamma "isentropic exponent";
    algorithm
      gamma := isentropicExponent_props_dT(
            d,
            T,
            Modelica.Media.Water.IAPWS95.Water95_Utilities.water95BaseProp_dT(d,
          T));

    end isentropicExponent_dT;

    function dynamicViscosity
      "Return dynamic viscosity as a function of the thermodynamic state record"
      extends Modelica.Icons.Function;
      input Modelica.Media.Water.IAPWS95.Water95_Base.ThermodynamicState state
        "Thermodynamic state record";
      output SI.DynamicViscosity eta "Dynamic viscosity";
    algorithm
      eta := Transport.eta_dT(state.d, state.T);
    end dynamicViscosity;

    function thermalConductivity
      "Return thermal conductivity as a function of the thermodynamic state record"
      extends Modelica.Icons.Function;
      input Modelica.Media.Water.IAPWS95.Water95_Base.ThermodynamicState state
        "Thermodynamic state record";
      output SI.ThermalConductivity lambda "Thermal conductivity";
    algorithm
      lambda := Transport.lambda_dT(state.d, state.T);
    end thermalConductivity;

  protected
    package ThermoFluidSpecial

      function water95_ph
        "calculate the property record for dynamic simulation properties using p,h as states"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "pressure";
        input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
        output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_ph pro
          "property record for dynamic simulation";
      protected
        Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
        Modelica.SIunits.Temperature T "temperature";
        Modelica.SIunits.Density d "density";
      algorithm
        (d,T) := Inverses.dTofph(
                p=p,
                h=h,
                delp=1.0e-7,
                delh=1.0e-6);
        f := Basic.Helmholtz(d, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.helmholtzToProps_ph(f);
      end water95_ph;

      function water95_dT
        "calculate property record for dynamic simulation properties using d and T as dynamic states"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Density d "density";
        input Modelica.SIunits.Temperature T "temperature";
        output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_dT pro
          "property record for dynamic simulation";
      protected
        Modelica.SIunits.Pressure p "pressure";
        Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
      algorithm
        f := Basic.Helmholtz(d, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.helmholtzToProps_dT(f);
      end water95_dT;

      function water95_pT
        "calculate property record for dynamic simulation properties using p and T as dynamic states"

        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "pressure";
        input Modelica.SIunits.Temperature T "temperature";
        output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_pT pro
          "property record for dynamic simulation";
      protected
        Modelica.SIunits.Density d "density";
        Modelica.Media.Common.HelmholtzDerivs f
          "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
      algorithm
        d := Modelica.Media.Water.IAPWS95.Water95_Utilities.Inverses.dofpT(
                p=p,
                T=T,
                delp=1e-7);
        f := Basic.Helmholtz(d, T);
        pro := Modelica.Media.Common.ThermoFluidSpecial.helmholtzToProps_pT(f);
      end water95_pT;
    end ThermoFluidSpecial;

    annotation (Documentation(info="<html>
</html>", revisions="<h4>Intermediate release notes during development</h4>
<p>Currenly the Events/noEvents switch is only implmented for p-h states. Only after testing that implmentation, it will be extended to dT.</p>"));
  end Water95_Utilities;
  annotation (Documentation(info="<html>
<p>
Calculation of fluid properties for water in the fluid region from the melting-pressure curve to 1273 Kelvin at pressures up to 1000 MPa. The lowest temperature
on the melting-pressure curve is 251.165 K at 208.566 MPa. This package does not implement the two phase region!
</p>

<h4>Restriction</h4>
<p>
The functions provided by this package shall be used inside of the restricted limits according to the referenced literature.
</p>

<ul>
<li>
<b>p &le; 1000 MPa</b>
</li>
<li>
<b>251.165 K &le; T &le; 1273 K</b>
</li>
</ul>

<h4>References</h4>
<dl>
<dd><b>Revised Release on the IAPWS Formulation 1995 for the Thermodynamic
Properties of Ordinary Water Substance for General and Scientific Use</b>. 2009 International Association for the Properties of Water and Steam.
</dd>
<dd><b>Release on the IAPWS Formulation 2008 for the Viscosity of Ordinary Water Substance</b>. 2008 International Association for the Properties of Water and Steam
</dd>
<dd><b>Release on the IAPWS Formulation 2011 for the Thermal Conductivity of
Ordinary Water Substance</b>. 2011 International Association for the Properties of Water and Steam.
</dd>
</dl>

<h4>Acknowledgment</h4>
<p>
This library was developed by XRG Simulation GmbH as part of the <a href=\"http://www.cleansky.eu/\">Clean Sky</a> JTI project (Project title: MoMoLib-Modelica Model Library Development for Media, Magnetic Systems and Wavelets; Project number: 296369; Theme: JTI-CS-2011-1-SGO-02-026: Modelica Model Library Development Part I). The partial financial support for the development of this library by the European Union is highly appreciated.
</p>

<p>
Some parts of this library refer to the ThermoFluid library developed at Lund University (<a href=\"http://thermofluid.sourceforge.net/\">http://thermofluid.sourceforge.net</a>).
</p>

<h4>Disclaimer</h4>
<p>
In no event will XRG Simulation GmbH be liable for any direct, indirect, incidental, special, exemplary, or consequential damages, arising in any way out of the use of this software, even if advised of the possibility of such damage.
</p>
<h4> Copyright (C) 2013, XRG Simulation GmbH </h4>
</html>"));
end IAPWS95;
