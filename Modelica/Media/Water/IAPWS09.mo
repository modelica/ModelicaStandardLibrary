within Modelica.Media.Water;
package IAPWS09 "Water: Ice model as described by IAPWS-09 (0 ... 273.16 K)"
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
    each normalBoilingPoint=373.124,
    each meltingPoint=273.15,
    each acentricFactor=0.344,
    each dipoleMoment=1.8,
    each hasCriticalData=true,
    each triplePointTemperature=273.16,
    each triplePointPressure=611.657);

protected
  type MolarHeatCapacity = SI.MolarHeatCapacity (min=0)
    "Type for molar heat capacity with medium specific attributes";

  type MolarDensity = Real (
      final quantity="MolarDensity",
      final unit="mol/m3",
      min=0);

  type IsothermalExpansionCoefficient = Real (min=0, unit="1");

public
  package Ice09_dT
    "Water: Ice model as described by IAPWS-09 (0 ... 273.16 K) explicit in d and T"
    extends Modelica.Media.Water.IAPWS09.Ice09_Base(
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.dTX,
      final ph_explicit=false,
      final dT_explicit=true,
      final pT_explicit=false);
  end Ice09_dT;

  package Ice09_pT
    "Water: Ice model as described by IAPWS-09 (0 ... 273.16 K) explicit in p and T"
    extends Modelica.Media.Water.IAPWS09.Ice09_Base(
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pT,
      final ph_explicit=false,
      final dT_explicit=false,
      final pT_explicit=true);
  end Ice09_pT;

public
  package Ice09_ph
    "Water: Ice model as described by IAPWS-09 (0 ... 273.16 K) explicit in p and h"
    extends Modelica.Media.Water.IAPWS09.Ice09_Base(
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
      final ph_explicit=true,
      final dT_explicit=false,
      final pT_explicit=false);
  end Ice09_ph;

public
  partial package Ice09_Base
    "Properties of ice calculated using the equation of state as given by IAPWS-09"

    extends Modelica.Media.Interfaces.PartialPureSubstance(
      mediumName="Ice",
      substanceNames={"ice09"},
      singleState=false,
      SpecificEnthalpy(start=-380, nominal=-333),
      Density(start=920.0, nominal=916),
      AbsolutePressure(
        start=1e5,
        nominal=1e5,
        min=0.0,
        max=210e6),
      Temperature(
        start=253.15,
        nominal=273.15,
        min=0.0,
        max=273.16));

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
      MM = Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.MM;
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
      R = Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.R;
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
      d := Modelica.Media.Water.IAPWS09.Ice09_Utilities.rho_ph(p, h);
    end density_ph;

    redeclare function temperature_ph
      "Computes temperature as a function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      output Temperature T "Temperature";
    algorithm
      T := Modelica.Media.Water.IAPWS09.Ice09_Utilities.T_ph(p, h);
    end temperature_ph;

    redeclare function temperature_ps
      "Compute temperature from pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output Temperature T "Temperature";
    algorithm
      T := Modelica.Media.Water.IAPWS09.Ice09_Utilities.T_ps(p, s);
    end temperature_ps;

    redeclare function density_ps
      "Computes density as a function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output Density d "density";
    algorithm
      d := Modelica.Media.Water.IAPWS09.Ice09_Utilities.rho_ps(p, s);
    end density_ps;

    redeclare function pressure_dT
      "Computes pressure as a function of density and temperature"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      output AbsolutePressure p "Pressure";
    algorithm
      p := Modelica.Media.Water.IAPWS09.Ice09_Utilities.p_dT(d, T);
    end pressure_dT;

    redeclare function specificEnthalpy_dT
      "Computes specific enthalpy as a function of density and temperature"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      output SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := Modelica.Media.Water.IAPWS09.Ice09_Utilities.h_dT(d, T);
    end specificEnthalpy_dT;

    redeclare function specificEnthalpy_pT
      "Computes specific enthalpy as a function of pressure and temperature"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := Modelica.Media.Water.IAPWS09.Ice09_Utilities.h_pT(p, T);
    end specificEnthalpy_pT;

    redeclare function specificEnthalpy_ps
      "Computes specific enthalpy as a function of pressure and temperature"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      output SpecificEnthalpy h "specific enthalpy";
    algorithm
      h := Modelica.Media.Water.IAPWS09.Ice09_Utilities.h_ps(p, s);
    end specificEnthalpy_ps;

    redeclare function density_pT
      "Computes density as a function of pressure and temperature"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      output Density d "Density";
    algorithm
      d := Modelica.Media.Water.IAPWS09.Ice09_Utilities.rho_pT(p, T);
    end density_pT;

    redeclare function extends dynamicViscosity
      "Return dynamic viscosity as a function of the thermodynamic state record"
    algorithm
      eta := Modelica.Media.Water.IAPWS09.Ice09_Utilities.dynamicViscosity(
        state);
    end dynamicViscosity;

    redeclare function extends thermalConductivity
      "Thermal conductivity of water"
    algorithm
      lambda :=
        Modelica.Media.Water.IAPWS09.Ice09_Utilities.thermalConductivity(state);
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
        s := Modelica.Media.Water.IAPWS09.Ice09_Utilities.s_dT(state.d, state.T);
      elseif pT_explicit then
        s := Modelica.Media.Water.IAPWS09.Ice09_Utilities.s_pT(state.p, state.T);
      else
        s := Modelica.Media.Water.IAPWS09.Ice09_Utilities.s_ph(state.p, state.h);
      end if;
    end specificEntropy;

    redeclare function extends specificHeatCapacityCp
      "specific heat capacity at constant pressure of water"

    algorithm
      if dT_explicit then
        cp := Modelica.Media.Water.IAPWS09.Ice09_Utilities.cp_dT(state.d, state.T);
      elseif pT_explicit then
        cp := Modelica.Media.Water.IAPWS09.Ice09_Utilities.cp_pT(state.p, state.T);
      else
        cp := Modelica.Media.Water.IAPWS09.Ice09_Utilities.cp_ph(state.p, state.h);
      end if;
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv
      "specific heat capacity at constant volume of water"
    algorithm
      if dT_explicit then
        cv := Modelica.Media.Water.IAPWS09.Ice09_Utilities.cv_dT(state.d, state.T);
      elseif pT_explicit then
        cv := Modelica.Media.Water.IAPWS09.Ice09_Utilities.cv_pT(state.p, state.T);
      else
        cv := Modelica.Media.Water.IAPWS09.Ice09_Utilities.cv_ph(state.p, state.h);
      end if;
    end specificHeatCapacityCv;

    redeclare function extends isentropicExponent "Return isentropic exponent"
    algorithm
      if dT_explicit then
        gamma :=
          Modelica.Media.Water.IAPWS09.Ice09_Utilities.isentropicExponent_dT(
          state.d, state.T);
      elseif pT_explicit then
        gamma :=
          Modelica.Media.Water.IAPWS09.Ice09_Utilities.isentropicExponent_pT(
          state.p, state.T);
      else
        gamma :=
          Modelica.Media.Water.IAPWS09.Ice09_Utilities.isentropicExponent_ph(
          state.p, state.h);
      end if;
    end isentropicExponent;

    redeclare function extends isothermalCompressibility
      "Isothermal compressibility of water"
    algorithm
      if dT_explicit then
        kappa := Modelica.Media.Water.IAPWS09.Ice09_Utilities.kappa_dT(state.d,
          state.T);
      elseif pT_explicit then
        kappa := Modelica.Media.Water.IAPWS09.Ice09_Utilities.kappa_pT(state.p,
          state.T);
      else
        kappa := Modelica.Media.Water.IAPWS09.Ice09_Utilities.kappa_ph(state.p,
          state.h);
      end if;
    end isothermalCompressibility;

    redeclare function extends isobaricExpansionCoefficient
      "isobaric expansion coefficient of water"
    algorithm
      if dT_explicit then
        beta := Modelica.Media.Water.IAPWS09.Ice09_Utilities.beta_dT(state.d,
          state.T);
      elseif pT_explicit then
        beta := Modelica.Media.Water.IAPWS09.Ice09_Utilities.beta_pT(state.p,
          state.T);
      else
        beta := Modelica.Media.Water.IAPWS09.Ice09_Utilities.beta_ph(state.p,
          state.h);
      end if;
    end isobaricExpansionCoefficient;

    redeclare function extends velocityOfSound
      "Return velocity of sound as a function of the thermodynamic state record"
    algorithm
      if dT_explicit then
        a := Modelica.Media.Water.IAPWS09.Ice09_Utilities.velocityOfSound_dT(
          state.d, state.T);
      elseif pT_explicit then
        a := Modelica.Media.Water.IAPWS09.Ice09_Utilities.velocityOfSound_pT(
          state.p, state.T);
      else
        a := Modelica.Media.Water.IAPWS09.Ice09_Utilities.velocityOfSound_ph(
          state.p, state.h);
      end if;
    end velocityOfSound;

    redeclare function extends density_derh_p
      "density derivative by specific enthalpy"
    algorithm
      ddhp := Modelica.Media.Water.IAPWS09.Ice09_Utilities.ddhp(state.p, state.h);
    end density_derh_p;

    redeclare function extends density_derp_h "density derivative by pressure"
    algorithm
      ddph := Modelica.Media.Water.IAPWS09.Ice09_Utilities.ddph(state.p, state.h);
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

    function sublimationPressure "Compute the sublimation pressure"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output AbsolutePressure psub "Sublimation pressure";

    algorithm
      psub := Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.psub(T);

    end sublimationPressure;

    function meltingPressure "Compute the melting pressure"
      extends Modelica.Icons.Function;

      input Temperature T "Temperature";
      output AbsolutePressure pmelt "Melting pressure";

    algorithm
      pmelt := Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.pmelt(T);

    end meltingPressure;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Text(
            extent={{-94,84},{94,40}},
            lineColor={127,191,255},
            textString="IF97"), Text(
            extent={{-94,20},{94,-24}},
            lineColor={127,191,255},
            textString="water")}), Documentation(info="<html>
</html>"));
  end Ice09_Base;

  package Ice09_Utilities
    "Low level and utility computation for high accuracy ice properties"
    extends Modelica.Icons.Package;

    record iter = Inverses.accuracy;
    package Basic "Fundamental equation of state"
      extends Modelica.Icons.BasesPackage;

      record IceConstants
        extends Common.FundamentalConstants;
        Modelica.SIunits.AbsolutePressure p0;
      end IceConstants;
      constant IceConstants Constants(
        R_bar=8.314472,
        R=461.52364,
        MM=18.015268E-003,
        rhored=1.0,
        Tred=273.16,
        pred=611.657,
        p0=101325,
        h_off=0.0,
        s_off=0.0);

      function Gibbs "Gibbs equation of state"
        extends Modelica.Icons.Function;
        input SI.AbsolutePressure p "Absolute pressure";
        input SI.Temperature T "Temperature";
        output Common.GibbsDerivs2 g
          "Gibbs function and dervatives w.r.t. T and p";

        import Modelica.ComplexMath;

      protected
        final constant Real[5] g_0={-0.632020233449497E+006,0.655022213658955,-0.189369929326131E-007,
            0.339746123271053E-014,-0.556464869058991E-021};
        final constant Real s_0=-0.332733756492168E+004;
        final Complex[2] t={Complex(0.368017112855051E-001,
            0.510878114959572E-001),Complex(0.337315741065416,
            0.335449415919309)};
        final constant Complex r_1=Complex(0.447050716285388E+002,
            0.656876847463481E+002);
        final Complex[3] r_2={Complex(-0.725974574329220E+002, -0.781008427112870E+002),
            Complex(-0.557107698030123E-004, 0.464578634580806E-004),Complex(
            0.234801409215913E-010, -0.285651142904972E-010)};
        final Real pi0=Ice09_Utilities.Basic.Constants.p0/Ice09_Utilities.Basic.Constants.pred;

        //temporary variables needed for calculation
        Real g0=0.0;
        Real g0p=0.0;
        Real g0pp=0.0;
        Complex r2=Complex(0.0, 0.0);
        Complex r2p=Complex(0.0, 0.0);
        Complex r2pp=Complex(0.0, 0.0);

      algorithm
        g.p := p;
        g.T := T;
        g.R := Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.R;

        //Reduced pressure
        g.pi := g.p/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.pred;
        //Reduced temperature
        g.theta := g.T/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.Tred;

        //calculate temporary values
        //0^0 may result in an error, so we have to use a workaround
        g0 := g_0[1];
        for k in 2:5 loop
          g0 := g0 + g_0[k]*(g.pi - pi0)^(k - 1);
        end for;
        r2 := r_2[1];
        for k in 2:3 loop
          r2 := r2 + r_2[k]*(g.pi - pi0)^(k - 1);
        end for;

        //First derivative of g0 w.r.t. pi
        g0p := g_0[2]/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.pred;
        for k in 3:5 loop
          g0p := g0p + g_0[k]*(k - 1)/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.pred
            *(g.pi - pi0)^(k - 2);
        end for;
        //First derivative of r2 w.r.t. pi
        r2p := r_2[2]/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.pred
           + r_2[3]*2/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.pred
          *(g.pi - pi0);
        //Second derivative of g0 w.r.t. pi
        g0pp := g_0[3]*2/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.pred
          ^2;
        for k in 4:5 loop
          g0pp := g0pp + g_0[k]*(k - 1)*(k - 2)/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.pred
            ^2*(g.pi - pi0)^(k - 3);
        end for;
        //Second derivative of g0 w.r.t. pi
        r2pp := r_2[3]*2/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.pred
          ^2;

        //Gibbs equation
        g.g := g0 - s_0*Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.Tred
          *g.theta + Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.Tred
          *ComplexMath.real(r_1*((t[1] - g.theta)*ComplexMath.log(t[1] - g.theta)
           + (t[1] + g.theta)*ComplexMath.log(t[1] + g.theta) - 2*t[1]*
          ComplexMath.log(t[1]) - g.theta^2/t[1]) + r2*((t[2] - g.theta)*
          ComplexMath.log(t[2] - g.theta) + (t[2] + g.theta)*ComplexMath.log(t[
          2] + g.theta) - 2*t[2]*ComplexMath.log(t[2]) - g.theta^2/t[2]));

        //First derivative of g w.r.t. p
        g.gp := g0p + Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.Tred
          *ComplexMath.real(r2p*((t[2] - g.theta)*ComplexMath.log(t[2] - g.theta)
           + (t[2] + g.theta)*ComplexMath.log(t[2] + g.theta) - 2*t[2]*
          ComplexMath.log(t[2]) - g.theta^2/t[2]));

        //Second derivative of g w.r.t. p
        g.gpp := g0pp + Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.Tred
          *ComplexMath.real(r2pp*((t[2] - g.theta)*ComplexMath.log(t[2] - g.theta)
           + (t[2] + g.theta)*ComplexMath.log(t[2] + g.theta) - 2*t[2]*
          ComplexMath.log(t[2]) - g.theta^2/t[2]));

        //First derivative of g w.r.t. T
        g.gT := -s_0 + ComplexMath.real(r_1*(-ComplexMath.log(t[1] - g.theta)
           + ComplexMath.log(t[1] + g.theta) - 2*g.theta/t[1]) + r2*(-
          ComplexMath.log(t[2] - g.theta) + ComplexMath.log(t[2] + g.theta) - 2
          *g.theta/t[2]));

        //Second derivative of g w.r.t. T
        g.gTT := 1/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.Tred
          *ComplexMath.real(r_1*(1/(t[1] - g.theta) + 1/(t[1] + g.theta) - 2/t[
          1]) + r2*(1/(t[2] - g.theta) + 1/(t[2] + g.theta) - 2/t[2]));

        //Mixed derivative of g w.r.t. T and p
        g.gTp := ComplexMath.real(r2p*(-ComplexMath.log(t[2] - g.theta) +
          ComplexMath.log(t[2] + g.theta) - 2*g.theta/t[2]));

      end Gibbs;

      function psub "sublimation pressure"
        extends Modelica.Icons.Function;

        input SI.Temperature T "Temperature";
        output SI.AbsolutePressure p_sub "Pressure";

      protected
        final constant Real[3] a={-0.212144006E+002,0.273203819E+002,-0.610598130E+001};
        final constant Real[3] b={0.333333333E-002,0.120666667E+001,
            0.170333333E+001};
        Real theta=0;
        Real sum=0;

      algorithm
        /*assert(T >= 50 and T < 273.16, "IAPWS-95 medium function psub: input temperature T = "
     + String(T) + " K\n" + "must be in the range 50 <= T < 273.16 K.");*/
        theta := T/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.Tred;

        for k in 1:3 loop
          sum := sum + a[k]*theta^b[k];
        end for;

        p_sub := exp(sum/theta)*Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.pred;
        annotation (
          derivative=psub_der,
          Inline=false,
          LateInline=true);
      end psub;

      function pmelt "melting pressure"
        extends Modelica.Icons.Function;

        input SI.Temperature T "Temperature";
        output SI.AbsolutePressure p_melt "Pressure";

      protected
        final constant Real[3] a={0.119539337E+007,0.808183159E+005,
            0.333826860E+004};
        final constant Real[3] b={0.3E+001,0.2575E+002,0.103750E+003};
        Real theta=0;
        Real sum=0;

      algorithm
        theta := T/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.Tred;

        for k in 1:3 loop
          sum := sum + a[k]*(1 - theta^b[k]);
        end for;

        p_melt := (1 + sum)*Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.pred;
        annotation (
          derivative=pmelt_der,
          Inline=false,
          LateInline=true);
      end pmelt;

      function Tsub "sublimation temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        output Modelica.SIunits.Temperature T_sub "Temperature";

      protected
        function Tsub_res
          extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
          input Modelica.SIunits.AbsolutePressure p "Pressure";

        algorithm
          y := Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.psub(u) - p;

        end Tsub_res;

      algorithm
        T_sub := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
                function Tsub_res(p=p),
                143.15,
                2000.0,
                1e-9);
      end Tsub;

      function psub_der "derivative of sublimation pressure"
        extends Modelica.Icons.Function;

        input SI.Temperature T "Temperature";
        input Real T_der "Derivative of temperature";
        output Real p_sub_der "Derivative of pressure";

      protected
        final constant Real[3] a={-0.212144006E+002,0.273203819E+002,-0.610598130E+001};
        final constant Real[3] b={0.333333333E-002,0.120666667E+001,
            0.170333333E+001};
        Real theta;
        Real theta_der;
        Real sum=0;
        Real sum_der=0;

      algorithm
        /*assert(T >= 50 and T < 273.16, "IAPWS-95 medium function psub: input temperature T = "
     + String(T) + " K\n" + "must be in the range 50 <= T < 273.16 K.");*/
        theta := T/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.Tred;
        theta_der := 1/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.Tred;

        for k in 1:3 loop
          sum := sum + a[k]*theta^b[k];
          sum_der := sum_der + a[k]*b[k]*theta^(b[k] - 1)*theta_der;
        end for;

        p_sub_der := (sum_der*theta - sum*theta_der)/theta^2*exp(sum/theta)*
          Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.pred*
          T_der;

      end psub_der;

      function pmelt_der "derivative of melting pressure"
        extends Modelica.Icons.Function;

        input SI.Temperature T "Temperature";
        input Real T_der "Temperature";
        output Real p_melt_der "Derivative of pressure";

      protected
        final constant Real[3] a={0.119539337E+007,0.808183159E+005,
            0.333826860E+004};
        final constant Real[3] b={0.3E+001,0.2575E+002,0.103750E+003};
        Real theta;
        Real theta_der;
        Real sum=0;
        Real sum_der=0;

      algorithm
        theta := T/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.Tred;
        theta_der := 1/Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.Tred;

        for k in 1:3 loop
          sum := sum + a[k]*(1 - theta^b[k]);
          sum_der := sum_der - a[k]*b[k]*theta^(b[k] - 1)*theta_der;
        end for;

        p_melt_der := sum_der*Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.pred
          *T_der;

      end pmelt_der;
    end Basic;

    package Inverses "Inverse function"
      extends Modelica.Icons.BasesPackage;

      record accuracy "Accuracy of the iterations"
        extends Modelica.Icons.Record;
        constant Real deld=1E-006 "Accuracy of p";
        constant Real delh=1E-006 "Accuracy of h";
        constant Real dels=1E-006 "Accuracy of s";
      end accuracy;

      function Tofph "Return T as a function of p and h"
        extends Modelica.Icons.Function;
        input SI.Pressure p "pressure";
        input SI.SpecificEnthalpy h "specific enthalpy";
        input SI.SpecificEnthalpy delh "iteration accuracy";
        output SI.Temperature T "temperature (K)";

      protected
        Integer i=0 "loop counter";
        Real dh "enthalpy difference";
        Real delT "temperature step";
        Common.GibbsDerivs2 g "dimensionless Gibbs function and dervatives";
        Modelica.Media.Common.NewtonDerivatives_ph nDerivs
          "derivatives needed in Newton iteration";
        Boolean found=false "flag for iteration success";

      algorithm
        T := 253.15;

        while ((i < 1000) and not found) loop
          g := Basic.Gibbs(p, T);
          nDerivs := Common.Gibbs2_ph(g);
          dh := nDerivs.h - Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.h_off
             - h;
          if (abs(dh) <= delh) then
            found := true;
          end if;
          delT := dh/nDerivs.ht;
          T := T - delT;
          i := i + 1;
        end while;
      end Tofph;

      function pofdT "Return p as a function of d and T"
        extends Modelica.Icons.Function;
        input SI.Density d "density";
        input SI.Temperature T "temperature";
        input SI.Density deld "iteration accuracy";
        output SI.Pressure p "pressure";

      protected
        Integer i=0 "loop counter";
        SI.SpecificVolume v "specific volume";
        SI.SpecificVolume dv "specific volume difference";
        SI.Density dd "density difference";
        Real delp "pressure step";
        Common.GibbsDerivs2 g "dimensionless Gibbs function and dervatives";
        Common.NewtonDerivatives_dT nDerivs
          "derivatives needed in Newton iteration";
        Boolean found=false "flag for iteration success";

      algorithm
        p := Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.R*T*d;
        v := 1/d;

        while ((i < 1000) and not found) loop
          g := Basic.Gibbs(p, T);
          nDerivs := Common.Gibbs2_dT(g);
          dv := nDerivs.v - v;
          dd := 1/nDerivs.v - d;
          if (abs(dd) <= deld) then
            found := true;
          end if;
          delp := dv/nDerivs.vp;
          p := p - delp;
          i := i + 1;
        end while;
      end pofdT;

      function Tofps "Return T as a function of p and s"
        extends Modelica.Icons.Function;
        input SI.Pressure p "Pressure";
        input SI.SpecificEntropy s "Specific entropy";
        input Real dels "Accuracy of s";
        output SI.Temperature T "Temperature";

      protected
        Integer i=0 "loop counter";
        Real ds "entropy difference";
        Real delT "temperature step";
        Common.GibbsDerivs2 g "dimensionless Gibbs function and dervatives";
        Modelica.Media.Common.NewtonDerivatives_ps nDerivs
          "derivatives needed in Newton iteration";
        Boolean found=false "flag for iteration success";

      algorithm
        T := 253.15;

        while ((i < 1000) and not found) loop
          g := Basic.Gibbs(p, T);
          nDerivs := Common.Gibbs2_ps(g);
          ds := nDerivs.s - Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.s_off
             - s;
          if (abs(ds) <= dels) then
            found := true;
          end if;
          delT := ds/nDerivs.st;
          T := T - delT;
          i := i + 1;
        end while;
      end Tofps;
    end Inverses;

    package Transport "Transport properties for air"
      extends Modelica.Icons.BasesPackage;

      function eta_pT "Return dynamic viscosity as a function of p and T"
        extends Modelica.Icons.Function;
        input SI.Pressure p "Pressure";
        input SI.Temperature T "Temperature";
        output SI.DynamicViscosity eta "Dynamic viscosity";

      algorithm
        eta := 0;
      end eta_pT;

      function lambda_pT "Return thermal conductivity as a function of p and T"
        extends Modelica.Icons.Function;
        input SI.Pressure p "Pressure";
        input SI.Temperature T "Temperature";
        output SI.ThermalConductivity lambda "Thermal conductivity";

      algorithm
        lambda := 0;
      end lambda_pT;
    end Transport;

    function ice09BaseProp_ps "intermediate property record for water"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEntropy s "specific entropy";
      output Common.AuxiliaryProperties aux "auxiliary record";
    protected
      Common.GibbsDerivs2 g "Gibbs funcion and dervatives w.r.t. p and T";
    algorithm
      aux.p := p;
      aux.s := s;
      aux.R := Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.R;
      aux.T := Inverses.Tofps(
            p=p,
            s=s,
            dels=iter.dels);
      g := Basic.Gibbs(aux.p, aux.T);
      aux.rho := 1/g.gp;
      aux.h := g.g - g.T*g.gT - Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.h_off;
      aux.cp := -g.T*g.gTT;
      aux.cv := aux.cp - g.T/g.gpp*g.gTp^2;
      aux.vt := 1/aux.rho*g.gTp/g.gp;
      aux.vp := 1/aux.rho*g.gpp/g.gp;
      aux.pd := -1/(aux.rho*aux.rho*aux.vp);
      aux.pt := -aux.vt/aux.vp;
    end ice09BaseProp_ps;

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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_ps(p, s));

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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_ps(p, s));

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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_ps(p, s));

    end h_ps;

    function ice09BaseProp_ph "intermediate property record for water"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      output Common.AuxiliaryProperties aux "auxiliary record";
    protected
      Common.GibbsDerivs2 g "dimensionless Gibbs funcion and dervatives";
      Integer error "error flag for inverse iterations";
    algorithm
      aux.p := p;
      aux.h := h;
      aux.R := Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.R;
      aux.T := Inverses.Tofph(
            p,
            h,
            delh=iter.delh);
      g := Basic.Gibbs(aux.p, aux.T);
      aux.rho := 1/g.gp;
      aux.s := -g.gT - Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.s_off;
      aux.cp := -g.T*g.gTT;
      aux.cv := aux.cp - g.T/g.gpp*g.gTp^2;
      aux.vt := 1/aux.rho*g.gTp/g.gp;
      aux.vp := 1/aux.rho*g.gpp/g.gp;
      aux.pd := -1/(aux.rho*aux.rho*aux.vp);
      aux.pt := -aux.vt/aux.vp;
    end ice09BaseProp_ph;

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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_ph(p, h));

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
      rho_der := (-aux.rho*aux.rho*(aux.vp*aux.cp - aux.vt/aux.rho + aux.T*aux.vt
        *aux.vt)/aux.cp)*p_der + (-aux.rho*aux.rho*aux.vt/(aux.cp))*h_der;
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_ph(p, h));

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
      T_der := ((-1/aux.rho + aux.T*aux.vt)/aux.cp)*p_der + (1/aux.cp)*h_der;
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_ph(p, h));

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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_ph(p, h));

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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_ph(p, h));

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
      beta := aux.vt*aux.rho;
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_ph(p, h));

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
      kappa := -aux.vp*aux.rho;
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_ph(p, h));

    end kappa_ph;

    function velocityOfSound_props_ph
      "speed of sound as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.Velocity a "speed of sound";
    algorithm
      a := sqrt(max(0, -aux.cp/(aux.rho*aux.rho*(aux.vp*aux.cp + aux.vt*aux.vt*
        aux.T))));
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_ph(p, h));

    end velocityOfSound_ph;

    function isentropicExponent_props_ph
      "isentropic exponent as function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Real gamma "isentropic exponent";
    algorithm
      gamma := -1/(aux.rho*aux.p)*aux.cp/(aux.vp*aux.cp + aux.vt*aux.vt*aux.T);
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_ph(p, h));

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
      ddph := (-aux.rho*aux.rho*(aux.vp*aux.cp - aux.vt/aux.rho + aux.T*aux.vt*
        aux.vt)/aux.cp);
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_ph(p, h));

    end ddph;

    function ddhp_props "density derivative by specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.DerDensityByEnthalpy ddhp
        "density derivative by specific enthalpy";
    algorithm
      ddhp := -aux.rho*aux.rho*aux.vt/(aux.cp);
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_ph(p, h));

    end ddhp;

    function ice09BaseProp_pT
      "intermediate property record for water (p and T prefered states)"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      output Common.AuxiliaryProperties aux "auxiliary record";
    protected
      Common.GibbsDerivs2 g "Gibbs funcion and dervatives w.r.t. p and T";
    algorithm
      aux.p := p;
      aux.T := T;
      aux.R := Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.R;
      g := Basic.Gibbs(aux.p, T);
      aux.rho := 1/g.gp;
      aux.h := g.g - g.T*g.gT - Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.h_off;
      aux.s := -g.gT - Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.s_off;
      aux.cp := -g.T*g.gTT;
      aux.cv := aux.cp - g.T/g.gpp*g.gTp^2;
      aux.vt := 1/aux.rho*g.gTp/g.gp;
      aux.vp := 1/aux.rho*g.gpp/g.gp;
      aux.pd := -1/(aux.rho*aux.rho*aux.vp);
      aux.pt := -aux.vt/aux.vp;
    end ice09BaseProp_pT;

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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_pT(p, T));

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
      rho_der := (-aux.rho*aux.rho*aux.vp)*p_der + (-aux.rho*aux.rho*aux.vt)*
        T_der;
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_pT(p, T));

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
      h_der := (1/aux.rho - aux.T*aux.vt)*p_der + aux.cp*T_der;
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_pT(p, T));

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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_pT(p, T));

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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_pT(p, T));

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
      beta := aux.vt*aux.rho;
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_pT(p, T));

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
      kappa := -aux.vp*aux.rho;
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_pT(p, T));

    end kappa_pT;

    function velocityOfSound_props_pT
      "speed of sound as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.Velocity a "speed of sound";
    algorithm
      a := sqrt(max(0, -aux.cp/(aux.rho*aux.rho*(aux.vp*aux.cp + aux.vt*aux.vt*
        aux.T))));
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_pT(p, T));

    end velocityOfSound_pT;

    function isentropicExponent_props_pT
      "isentropic exponent as function of pressure and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "pressure";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Real gamma "isentropic exponent";
    algorithm
      gamma := -1/(aux.rho*aux.p)*aux.cp/(aux.vp*aux.cp + aux.vt*aux.vt*aux.T);
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_pT(p, T));

    end isentropicExponent_pT;

    function ice09BaseProp_dT "intermediate property record for water"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      output Common.AuxiliaryProperties aux "auxiliary record";
    protected
      Common.GibbsDerivs2 g "dimensionless Gibbs funcion and dervatives";
    algorithm
      aux.rho := d;
      aux.T := T;
      aux.R := Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.R;
      aux.p := Inverses.pofdT(
            d,
            T,
            deld=iter.deld);
      g := Basic.Gibbs(aux.p, T);
      aux.h := g.g - g.T*g.gT - Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.h_off;
      aux.s := -g.gT - Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.s_off;
      aux.cp := -g.T*g.gTT;
      aux.cv := aux.cp - g.T/g.gpp*g.gTp^2;
      aux.vt := 1/aux.rho*g.gTp/g.gp;
      aux.vp := 1/aux.rho*g.gpp/g.gp;
      aux.pd := -1/(aux.rho*aux.rho*aux.vp);
      aux.pt := -aux.vt/aux.vp;
    end ice09BaseProp_dT;

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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_dT(d, T));

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
      h_der := (-(-1/d + T*aux.vt)/(d*d*aux.vp))*d_der + ((aux.vp*aux.cp - aux.vt
        /d + T*aux.vt*aux.vt)/aux.vp)*T_der;
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_dT(d, T));

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
      p_der := (-1/(d*d*aux.vp))*d_der + (-aux.vt/aux.vp)*T_der;
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_dT(d, T));

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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_dT(d, T));

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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_dT(d, T));

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
      beta := aux.vt*aux.rho;
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_dT(d, T));

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
      kappa := -aux.vp*aux.rho;
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_dT(d, T));

    end kappa_dT;

    function velocityOfSound_props_dT
      "speed of sound as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Modelica.SIunits.Velocity a "speed of sound";
    algorithm
      a := sqrt(max(0, -aux.cp/(aux.rho*aux.rho*(aux.vp*aux.cp + aux.vt*aux.vt*
        aux.T))));
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_dT(d, T));

    end velocityOfSound_dT;

    function isentropicExponent_props_dT
      "isentropic exponent as function of density and temperature"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Density d "density";
      input Modelica.SIunits.Temperature T "temperature";
      input Common.AuxiliaryProperties aux "auxiliary record";
      output Real gamma "isentropic exponent";
    algorithm
      gamma := -1/(aux.rho*aux.p)*aux.cp/(aux.vp*aux.cp + aux.vt*aux.vt*aux.T);
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
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_dT(d, T));

    end isentropicExponent_dT;

    function dynamicViscosity
      "Return dynamic viscosity as a function of the thermodynamic state record"
      extends Modelica.Icons.Function;
      input Modelica.Media.Water.IAPWS09.Ice09_Base.ThermodynamicState state
        "Thermodynamic state record";
      output SI.DynamicViscosity eta "Dynamic viscosity";
    algorithm
      eta := Modelica.Media.Water.IAPWS09.Ice09_Utilities.Transport.eta_pT(
        state.p, state.T);
    end dynamicViscosity;

    function thermalConductivity
      "Return thermal conductivity as a function of the thermodynamic state record"
      extends Modelica.Icons.Function;
      input Modelica.Media.Water.IAPWS09.Ice09_Base.ThermodynamicState state
        "Thermodynamic state record";
      output SI.ThermalConductivity lambda "Thermal conductivity";
    algorithm
      lambda :=
        Modelica.Media.Water.IAPWS09.Ice09_Utilities.Transport.lambda_pT(state.p,
        state.T);
    end thermalConductivity;
    annotation (Documentation(info="<html>
</html>", revisions="<h4>Intermediate release notes during development</h4>
<p>Currenly the Events/noEvents switch is only implmented for p-h states. Only after testing that implmentation, it will be extended to dT.</p>"));
  end Ice09_Utilities;
  annotation (Documentation(info="<html>
<p>Calculation of fluid properties for ice in the region from 0 Kelvin to 273.16 Kelvin at pressures up to 210 MPa.
</p>

<h4>Restriction</h4>
<p>
The functions provided by this package shall be used inside of the restricted limits according to the referenced literature.
</p>

<ul>
<li>
<b>0 &le; p &le; 210 MPa</b>
</li>
<li>
<b>0 K &le; T &le; 273.16 K</b>
</li>
</ul>

<h4>References</h4>
<dl>
<dd><b>Revised Release on the Equation of State 2006 for H2O Ice Ih</b>. 2009 International Association for the Properties of Water and Steam.
</dd>
<dd><b>Revised Release on the Pressure along the Melting and
Sublimation Curves of Ordinary Water Substance</b>. 2011 International Association for the Properties of Water and Steam
</dd>
</dl>

<h4>Acknowledgment</h4>
<p>
This library was developed by XRG Simulation GmbH as part of the <a href=\"http://www.cleansky.eu/\">Clean Sky</a> JTI project (Project title: MoMoLib-Modelica Model Library Development for Media, Magnetic Systems and Wavelets; Project number: 296369; Theme: JTI-CS-2011-1-SGO-02-026: Modelica Model Library Development Part I). The partial financial support for the development of this library by the European Union is highly appreciated.
</p>

<p>
Some parts of this library refer to the ThermoFluid library developed
by Jonas Eborn, Hubertus Tummescheit, and Falko Jens Wagner
(<a href=\"http://thermofluid.sourceforge.net/\">http://thermofluid.sourceforge.net</a>).
</p>

<h4>Disclaimer</h4>
<p>
In no event will XRG Simulation GmbH be liable for any direct, indirect, incidental, special, exemplary, or consequential damages, arising in any way out of the use of this software, even if advised of the possibility of such damage.
</p>
<h4> Copyright (C) 2013, XRG Simulation GmbH </h4>
</html>"));
end IAPWS09;
