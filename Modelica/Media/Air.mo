within Modelica.Media;
package Air "Medium models for air"
  extends Modelica.Icons.MaterialPropertiesPackage;

  package SimpleAir "Air: Simple dry air model (0..100 degC)"
    extends Interfaces.PartialSimpleIdealGasMedium(
      mediumName="SimpleAir",
      cp_const=1005.45,
      MM_const=0.0289651159,
      R_gas=Constants.R/0.0289651159,
      eta_const=1.82e-5,
      lambda_const=0.026,
      T_min=Cv.from_degC(0),
      T_max=Cv.from_degC(100),
      fluidConstants=airConstants,
      Temperature(min=Modelica.SIunits.Conversions.from_degC(0), max=
            Modelica.SIunits.Conversions.from_degC(100)));

    import Modelica.Constants;

    constant Modelica.Media.Interfaces.Types.Basic.FluidConstants[nS]
      airConstants={Modelica.Media.Interfaces.Types.Basic.FluidConstants(
          iupacName="simple air",
          casRegistryNumber="not a real substance",
          chemicalFormula="N2, O2",
          structureFormula="N2, O2",
          molarMass=Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM)}
      "constant data for the fluid";

    annotation (Documentation(info="<html>
                              <h4>Simple Ideal gas air model for low temperatures</h4>
                              <p>This model demonstrates how to use the PartialSimpleIdealGas base class to build a
                              simple ideal gas model with a limited temperature validity range.</p>
                              </html>"));
  end SimpleAir;

  package DryAirNasa "Air: Detailed dry air model as ideal gas (200..6000 K)"
    extends IdealGases.Common.SingleGasNasa(
      mediumName="Air",
      data=IdealGases.Common.SingleGasesData.Air,
      fluidConstants={IdealGases.Common.FluidData.N2});

    redeclare function dynamicViscosity
      "Simple polynomial for dry air (moisture influence small), valid from 73.15 K to 373.15 K"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output DynamicViscosity eta "Dynamic viscosity";
    algorithm
      eta := Incompressible.TableBased.Polynomials_Temp.evaluate({(-4.96717436974791E-011),
        5.06626785714286E-008,1.72937731092437E-005}, Cv.to_degC(state.T));
      annotation (Documentation(info="<html>
Dynamic viscosity is computed from temperature using a second order polynomial with a range of validity between 73 and 373 K.
</html>"));
    end dynamicViscosity;

    redeclare function thermalConductivity
      "Simple polynomial for dry air (moisture influence small), valid from 73.15 K to 373.15 K"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      input Integer method=1 "Dummy for compatibility reasons";
      output ThermalConductivity lambda "Thermal conductivity";
    algorithm
      lambda := Incompressible.TableBased.Polynomials_Temp.evaluate({(-4.8737307422969E-008),
        7.67803133753502E-005,0.0241814385504202}, Cv.to_degC(state.T));

      annotation (Documentation(info="<html>
Thermal conductivity is computed from temperature using a second order polynomial with a range of validity between 73 and 373 K.
</html>"));
    end thermalConductivity;

    annotation (Documentation(info="<html>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/Air.png\">
<p>
Ideal gas medium model for dry air based on the package <a href=\"modelica://Modelica.Media.IdealGases\">IdealGases</a> with additional functions for dynamic viscosity and thermal conductivity in a limited temperature range.
</p>
</html>"));
  end DryAirNasa;

  package RealGasAir "RealGasAir: Detailed dry air model (130 ... 2000 K)"
    extends Modelica.Icons.MaterialPropertiesPackage;
    import SI = Modelica.SIunits;

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
    package Air_dT
      "RealGasAir.Air_dT: Detailed dry air model (130 ... 2000 K) explicit in d and T"
      extends Modelica.Media.Air.RealGasAir.Air_Base(
        ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.dTX,
        final ph_explicit=false,
        final dT_explicit=true,
        final pT_explicit=false);

      annotation (Documentation(info="<html>
<h4>Usage</h4>
<p>
The package Air_dT can be used as any other medium model (see <a href=\"modelica://Modelica.Media.UsersGuide\">User's Guide of Media Library</a> for further information).
</p>
</html>"));
    end Air_dT;

    package Air_pT
      "RealGasAir.Air_pT: Detailed dry air model (130 ... 2000 K) explicit in p and T"
      extends Modelica.Media.Air.RealGasAir.Air_Base(
        ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pT,
        final ph_explicit=false,
        final dT_explicit=false,
        final pT_explicit=true);

      annotation (Documentation(info="<html>
<h4>Usage</h4>
<p>
The package Air_pT can be used as any other medium model (see <a href=\"modelica://Modelica.Media.UsersGuide\">User's Guide of Media Library</a> for further information).
</p>
</html>"));
    end Air_pT;

    package Air_ph
      "RealGasAir.Air_ph: Detailed dry air model (130 ... 2000 K) explicit in p and h"
      extends Modelica.Media.Air.RealGasAir.Air_Base(
        ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
        final ph_explicit=true,
        final dT_explicit=false,
        final pT_explicit=false);

      annotation (Documentation(info="<html>
<h4>Usage</h4>
<p>
The package Air_ph can be used as any other medium model (see <a href=\"modelica://Modelica.Media.UsersGuide\">User's Guide of Media Library</a> for further information).
</p>
</html>"));
    end Air_ph;

  public
    partial package Air_Base
      "Properties of dry air calculated using the equation of state by Lemmon et. al."

      extends Modelica.Media.Interfaces.PartialPureSubstance(
        mediumName="Air",
        substanceNames={"air"},
        singleState=false,
        SpecificEnthalpy(start=1.0e5, nominal=5.0e5),
        Density(start=1.0, nominal=1.2),
        AbsolutePressure(
          start=1e5,
          nominal=1e5,
          min=1.0,
          max=2000e6),
        Temperature(
          start=273.15,
          nominal=293.15,
          min=130,
          max=2000));

      redeclare record extends FluidConstants
        Temperature criticalTemperature "critical temperature";
        AbsolutePressure criticalPressure "critical pressure";
        MolarVolume criticalMolarVolume "critical molar Volume";
        Real acentricFactor "Pitzer acentric factor";
        //   Temperature triplePointTemperature "triple point temperature";
        //   AbsolutePressure triplePointPressure "triple point pressure";
        Temperature meltingPoint "melting point at 101325 Pa";
        Temperature normalBoilingPoint "normal boiling point (at 101325 Pa)";
        DipoleMoment dipoleMoment
          "dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
        Boolean hasCriticalData=true "true if critical data are known";
        Boolean hasIdealGasHeatCapacity=false
          "true if ideal gas heat capacity is available";
        Boolean hasDipoleMoment=false "true if a dipole moment known";
        Boolean hasFundamentalEquation=true "true if a fundamental equation";
        Boolean hasLiquidHeatCapacity=false
          "true if liquid heat capacity is available";
        Boolean hasSolidHeatCapacity=false
          "true if solid heat capacity is available";
        Boolean hasAccurateViscosityData=true
          "true if accurate data for a viscosity function is available";
        Boolean hasAccurateConductivityData=true
          "true if accurate data for thermal conductivity is available";
        Boolean hasVapourPressureCurve=false
          "true if vapour pressure data, e.g., Antoine coefficients are known";
        Boolean hasAcentricFactor=true
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

      constant FluidConstants airConstants(
        each chemicalFormula="N2+O2+Ar",
        each structureFormula="N2+O2+Ar",
        each casRegistryNumber="1",
        each iupacName="air",
        each molarMass=0.02896546,
        each criticalTemperature=132.5306,
        each criticalPressure=3.786e6,
        each criticalMolarVolume=0.02896546/342.68,
        each normalBoilingPoint=78.903,
        each meltingPoint=0,
        each acentricFactor=0.0335,
        each dipoleMoment=0.0);

      record Constants "Constants used in the model"
        final constant MolarHeatCapacity R_bar=8.31451;
        final constant SpecificHeatCapacity R=287.117;
        final constant MolarMass MM=28.9586E-003;
        final constant MolarDensity rhored=10447.7;
        final constant Temperature Tred=132.6312;
        final constant AbsolutePressure pred=3785020;
        constant SpecificEnthalpy h_off=1589557.62320524;
        constant SpecificEntropy s_off=6610.41237132543;
      end Constants;
      constant Boolean ph_explicit
        "true if explicit in pressure and specific enthalpy";
      constant Boolean dT_explicit
        "true if explicit in density and temperature";
      constant Boolean pT_explicit
        "true if explicit in pressure and temperature";

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
        MM = Constants.MM;
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
        R = Constants.R;
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
        d := Air_Utilities.rho_ph(p, h);
      end density_ph;

      redeclare function temperature_ph
        "Computes temperature as a function of pressure and specific enthalpy"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        output Temperature T "Temperature";
      algorithm
        T := Air_Utilities.T_ph(p, h);
      end temperature_ph;

      redeclare function temperature_ps
        "Compute temperature from pressure and specific enthalpy"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        output Temperature T "Temperature";
      algorithm
        T := Air_Utilities.T_ps(p, s);
      end temperature_ps;

      redeclare function density_ps
        "Computes density as a function of pressure and specific enthalpy"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        output Density d "density";
      algorithm
        d := Air_Utilities.rho_ps(p, s);
      end density_ps;

      redeclare function pressure_dT
        "Computes pressure as a function of density and temperature"
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        output AbsolutePressure p "Pressure";
      algorithm
        p := Air_Utilities.p_dT(d, T);
      end pressure_dT;

      redeclare function specificEnthalpy_dT
        "Computes specific enthalpy as a function of density and temperature"
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        output SpecificEnthalpy h "specific enthalpy";
      algorithm
        h := Air_Utilities.h_dT(d, T);
      end specificEnthalpy_dT;

      redeclare function specificEnthalpy_pT
        "Computes specific enthalpy as a function of pressure and temperature"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        output SpecificEnthalpy h "specific enthalpy";
      algorithm
        h := Air_Utilities.h_pT(p, T);
      end specificEnthalpy_pT;

      redeclare function specificEnthalpy_ps
        "Computes specific enthalpy as a function of pressure and temperature"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        output SpecificEnthalpy h "specific enthalpy";
      algorithm
        h := Air_Utilities.h_ps(p, s);
      end specificEnthalpy_ps;

      redeclare function density_pT
        "Computes density as a function of pressure and temperature"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        output Density d "Density";
      algorithm
        d := Air_Utilities.rho_pT(p, T);
      end density_pT;

      redeclare function extends dynamicViscosity
        "Return dynamic viscosity as a function of the thermodynamic state record"
      algorithm
        eta := Air_Utilities.dynamicViscosity(state);
      end dynamicViscosity;

      redeclare function extends thermalConductivity
        "Thermal conductivity of water"
      algorithm
        lambda := Air_Utilities.thermalConductivity(state);
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
          s := Air_Utilities.s_dT(state.d, state.T);
        elseif pT_explicit then
          s := Air_Utilities.s_pT(state.p, state.T);
        else
          s := Air_Utilities.s_ph(state.p, state.h);
        end if;
      end specificEntropy;

      redeclare function extends specificHeatCapacityCp
        "specific heat capacity at constant pressure of water"

      algorithm
        if dT_explicit then
          cp := Air_Utilities.cp_dT(state.d, state.T);
        elseif pT_explicit then
          cp := Air_Utilities.cp_pT(state.p, state.T);
        else
          cp := Air_Utilities.cp_ph(state.p, state.h);
        end if;
      end specificHeatCapacityCp;

      redeclare function extends specificHeatCapacityCv
        "specific heat capacity at constant volume of water"
      algorithm
        if dT_explicit then
          cv := Air_Utilities.cv_dT(state.d, state.T);
        elseif pT_explicit then
          cv := Air_Utilities.cv_pT(state.p, state.T);
        else
          cv := Air_Utilities.cv_ph(state.p, state.h);
        end if;
      end specificHeatCapacityCv;

      redeclare function extends isentropicExponent
        "Return isentropic exponent"
      algorithm
        if dT_explicit then
          gamma := Air_Utilities.isentropicExponent_dT(state.d, state.T);
        elseif pT_explicit then
          gamma := Air_Utilities.isentropicExponent_pT(state.p, state.T);
        else
          gamma := Air_Utilities.isentropicExponent_ph(state.p, state.h);
        end if;
      end isentropicExponent;

      redeclare function extends isothermalCompressibility
        "Isothermal compressibility of water"
      algorithm
        if dT_explicit then
          kappa := Air_Utilities.kappa_dT(state.d, state.T);
        elseif pT_explicit then
          kappa := Air_Utilities.kappa_pT(state.p, state.T);
        else
          kappa := Air_Utilities.kappa_ph(state.p, state.h);
        end if;
      end isothermalCompressibility;

      redeclare function extends isobaricExpansionCoefficient
        "isobaric expansion coefficient of water"
      algorithm
        if dT_explicit then
          beta := Air_Utilities.beta_dT(state.d, state.T);
        elseif pT_explicit then
          beta := Air_Utilities.beta_pT(state.p, state.T);
        else
          beta := Air_Utilities.beta_ph(state.p, state.h);
        end if;
      end isobaricExpansionCoefficient;

      redeclare function extends velocityOfSound
        "Return velocity of sound as a function of the thermodynamic state record"
      algorithm
        if dT_explicit then
          a := Air_Utilities.velocityOfSound_dT(state.d, state.T);
        elseif pT_explicit then
          a := Air_Utilities.velocityOfSound_pT(state.p, state.T);
        else
          a := Air_Utilities.velocityOfSound_ph(state.p, state.h);
        end if;
      end velocityOfSound;

      redeclare function extends density_derh_p
        "density derivative by specific enthalpy"
      algorithm
        ddhp := Air_Utilities.ddhp(state.p, state.h);
      end density_derh_p;

      redeclare function extends density_derp_h
        "density derivative by pressure"
      algorithm
        ddph := Air_Utilities.ddph(state.p, state.h);
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

      redeclare function extends isentropicEnthalpy
      algorithm
        h_is := specificEnthalpy_psX(
                p_downstream,
                specificEntropy(refState),
                reference_X);
      end isentropicEnthalpy;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-94,84},{94,40}},
              lineColor={127,191,255},
              textString="IF97"), Text(
              extent={{-94,20},{94,-24}},
              lineColor={127,191,255},
              textString="water")}), Documentation(info="<HTML>
<p>
This model calculates medium properties
for water in the <b>liquid</b>, <b>gas</b> and <b>two phase</b> regions
according to the IAPWS/IF97 standard, i.e., the accepted industrial standard
and best compromise between accuracy and computation time.
For more details see <a href=\"modelica://Modelica.Media.Water.IF97_Utilities\">
Modelica.Media.Water.IF97_Utilities</a>. Three variable pairs can be the
independent variables of the model:
</p>
<ol>
<li>Pressure <b>p</b> and specific enthalpy <b>h</b> are the most natural choice for general applications. This is the recommended choice for most general purpose applications, in particular for power plants.</li>
<li>Pressure <b>p</b> and temperature <b>T</b> are the most natural choice for applications where water is always in the same phase, both for liquid water and steam.</li>
<li>Density <b>d</b> and temperature <b>T</b> are explicit variables of the Helmholtz function in the near-critical region and can be the best choice for applications with super-critical or near-critial states.</li>
</ol>
<p>
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
      <td valign=\"top\">specific internal energy</td></tr>
  <tr><td valign=\"top\">d</td>
      <td valign=\"top\">kg/m^3</td>
      <td valign=\"top\">density</td></tr>
  <tr><td valign=\"top\">p</td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">pressure</td></tr>
  <tr><td valign=\"top\">h</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific enthalpy</td></tr>
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
<p>Many further properties can be computed. Using the well-known Bridgman's Tables, all first partial derivatives of the standard thermodynamic variables can be computed easily.</p>
</html>"));
    end Air_Base;

    package Air_Utilities
      "Low level and utility computation for high accuracy dry air properties"
      extends Modelica.Icons.Package;

      record iter = Inverses.accuracy;
      package Basic "Fundamental equation of state"
        extends Modelica.Icons.BasesPackage;

        constant Common.FundamentalConstants Constants(
          R_bar=8.31451,
          R=287.117,
          MM=28.9586E-003,
          rhored=10447.7,
          Tred=132.6312,
          pred=3785020,
          h_off=1589557.62320524,
          s_off=6610.41237132543);

        function Helmholtz "Helmholtz equation of state"
          extends Modelica.Icons.Function;
          input SI.Density d "density";
          input SI.Temperature T "temperature (K)";
          output Modelica.Media.Common.HelmholtzDerivs f
            "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";

        protected
          final constant Real[13] N_0={0.605719400E-007,-0.210274769E-004,-0.158860716E-003,
              -0.13841928076E002,0.17275266575E002,-0.195363420E-003,
              0.2490888032E001,0.791309509,0.212236768,0.197938904,
              0.2536365E002,0.1690741E002,0.8731279E002};
          final constant Real[19] N={0.118160747229,0.713116392079,-0.161824192067E001,
              0.714140178971E-001,-0.865421396646E-001,0.134211176704,
              0.112626704218E-001,-0.420533228842E-001,0.349008431982E-001,
              0.164957183186E-003,-0.101365037912,-0.173813690970,-0.472103183731E-001,
              -0.122523554253E-001,-0.146629609713,-0.316055879821E-001,
              0.233594806142E-003,0.148287891978E-001,-0.938782884667E-002};
          final constant Integer[19] i={1,1,1,2,3,3,4,4,4,6,1,3,5,6,1,3,11,1,3};
          final constant Real[19] j={0,0.33,1.01,0,0,0.15,0,0.2,0.35,1.35,1.6,
              0.8,0.95,1.25,3.6,6,3.25,3.5,15};
          final constant Integer[19] l={0,0,0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,3,3};

        algorithm
          f.d := d;
          f.T := T;
          f.R := Air_Utilities.Basic.Constants.R;
          //Reduced density
          f.delta := d/(Air_Utilities.Basic.Constants.MM*Air_Utilities.Basic.Constants.rhored);
          //Reciprocal reduced temperature
          f.tau := Air_Utilities.Basic.Constants.Tred/T;

          //Dimensionless Helmholtz equation
          f.f := 0;
          //Ideal-gas part
          for k in 1:5 loop
            f.f := f.f + N_0[k]*f.tau^(k - 4);
          end for;
          f.f := f.f + log(f.delta) + N_0[6]*f.tau*sqrt(f.tau) + N_0[7]*log(f.tau)
             + N_0[8]*log(1 - exp(-N_0[11]*f.tau)) + N_0[9]*log(1 - exp(-N_0[12]
            *f.tau)) + N_0[10]*log(2/3 + exp(N_0[13]*f.tau));
          //Residual part
          for k in 1:10 loop
            f.f := f.f + N[k]*f.delta^i[k]*f.tau^j[k];
          end for;
          for k in 11:19 loop
            f.f := f.f + N[k]*f.delta^i[k]*f.tau^j[k]*exp(-f.delta^l[k]);
          end for;

          //First derivative of f w.r.t. delta
          f.fdelta := 0;
          //Ideal-gas part
          f.fdelta := 1/f.delta;
          //Residual part
          for k in 1:10 loop
            f.fdelta := f.fdelta + i[k]*N[k]*f.delta^(i[k] - 1)*f.tau^j[k];
          end for;
          for k in 11:19 loop
            f.fdelta := f.fdelta + N[k]*f.delta^(i[k] - 1)*f.tau^j[k]*exp(-f.delta
              ^l[k])*(i[k] - l[k]*f.delta^l[k]);
          end for;

          //Second derivative of f w.r.t. delta
          f.fdeltadelta := 0;
          //Ideal-gas part
          f.fdeltadelta := -1/f.delta^2;
          //Residual part
          for k in 1:10 loop
            f.fdeltadelta := f.fdeltadelta + i[k]*(i[k] - 1)*N[k]*f.delta^(i[k]
               - 2)*f.tau^j[k];
          end for;
          for k in 11:19 loop
            f.fdeltadelta := f.fdeltadelta + N[k]*f.delta^(i[k] - 2)*f.tau^j[k]
              *exp(-f.delta^l[k])*((i[k] - l[k]*f.delta^l[k])*(i[k] - 1 - l[k]*
              f.delta^l[k]) - l[k]^2*f.delta^l[k]);
          end for;

          //First derivative of f w.r.t. tau
          f.ftau := 0;
          //Ideal-gas part
          for k in 1:5 loop
            f.ftau := f.ftau + (k - 4)*N_0[k]*f.tau^(k - 5);
          end for;
          f.ftau := f.ftau + 1.5*N_0[6]*sqrt(f.tau) + N_0[7]/f.tau + N_0[8]*N_0
            [11]/(exp(N_0[11]*f.tau) - 1) + N_0[9]*N_0[12]/(exp(N_0[12]*f.tau)
             - 1) + N_0[10]*N_0[13]/(2/3*exp(-N_0[13]*f.tau) + 1);
          //Residual part
          for k in 1:10 loop
            f.ftau := f.ftau + j[k]*N[k]*f.delta^i[k]*f.tau^(j[k] - 1);
          end for;
          for k in 11:19 loop
            f.ftau := f.ftau + j[k]*N[k]*f.delta^i[k]*f.tau^(j[k] - 1)*exp(-f.delta
              ^l[k]);
          end for;

          //Second derivative of f w.r.t. tau
          f.ftautau := 0;
          //Ideal-gas part
          for k in 1:3 loop
            f.ftautau := f.ftautau + (k - 4)*(k - 5)*N_0[k]*f.tau^(k - 6);
          end for;
          f.ftautau := f.ftautau + 0.75*N_0[6]/sqrt(f.tau) - N_0[7]/f.tau^2 -
            N_0[8]*N_0[11]^2*exp(N_0[11]*f.tau)/(exp(N_0[11]*f.tau) - 1)^2 -
            N_0[9]*N_0[12]^2*exp(N_0[12]*f.tau)/(exp(N_0[12]*f.tau) - 1)^2 + 2/
            3*N_0[10]*N_0[13]^2*exp(-N_0[13]*f.tau)/(2/3*exp(-N_0[13]*f.tau) +
            1)^2;
          //Residual part
          for k in 1:10 loop
            f.ftautau := f.ftautau + j[k]*(j[k] - 1)*N[k]*f.delta^i[k]*f.tau^(j[
              k] - 2);
          end for;
          for k in 11:19 loop
            f.ftautau := f.ftautau + j[k]*(j[k] - 1)*N[k]*f.delta^i[k]*f.tau^(j[
              k] - 2)*exp(-f.delta^l[k]);
          end for;

          //Mixed derivative of f w.r.t. delta and tau
          f.fdeltatau := 0;
          //Residual part (Ideal-gas part is zero)
          for k in 1:10 loop
            f.fdeltatau := f.fdeltatau + i[k]*j[k]*N[k]*f.delta^(i[k] - 1)*f.tau
              ^(j[k] - 1);
          end for;
          for k in 11:19 loop
            f.fdeltatau := f.fdeltatau + j[k]*N[k]*f.delta^(i[k] - 1)*f.tau^(j[
              k] - 1)*exp(-f.delta^l[k])*(i[k] - l[k]*f.delta^l[k]);
          end for;

        end Helmholtz;
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
          d := p/(Air_Utilities.Basic.Constants.R*T);

          while ((i < 100) and not found) loop
            f := Basic.Helmholtz(d, T);
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
          SI.Temperature Tguess "initial temperature";
          SI.Density dguess "initial density";
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
          // Stefan Wischhusen: better guess for high temperatures:
          T := h/1000 + 273.15;
          d := p/(Air_Base.Constants.R*T);
          i := 0;

          while ((i < 100) and not found) loop
            f := Basic.Helmholtz(d, T);
            nDerivs := Modelica.Media.Common.Helmholtz_ph(f);
            dh := nDerivs.h - Air_Base.Constants.h_off - h;
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
          SI.Temperature Tguess "initial temperature";
          SI.Density dguess "initial density";
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
          T := 273.15;
          d := p/(Air_Base.Constants.R*T);
          i := 0;

          while ((i < 100) and not found) loop
            f := Basic.Helmholtz(d, T);
            nDerivs := Modelica.Media.Common.Helmholtz_ps(f);
            ds := nDerivs.s - Air_Base.Constants.s_off - s;
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
          Real delta=d/(Air_Utilities.Basic.Constants.MM*Air_Utilities.Basic.Constants.rhored)
            "Reduced density";
          Real tau=Air_Utilities.Basic.Constants.Tred/T
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
            Modelica.Media.Incompressible.TableBased.Polynomials_Temp.evaluate(
            {b[5],b[4],b[3],b[2],b[1]}, log(T/103.3)));
          eta_0 := 0.0266958*sqrt(1000*Air_Utilities.Basic.Constants.MM*T)/(
            0.36^2*Omega);
          for i in 1:5 loop
            eta_r := eta_r + (Nvis[i]*(tau^tvis[i])*(delta^dvis[i])*exp(-
              gammavis[i]*(delta^lvis[i])));
          end for;
          eta := (eta_0 + eta_r)*1E-006;
        end eta_dT;

        function lambda_dT
          "Return thermal conductivity as a function of d and T"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          output SI.ThermalConductivity lambda "Thermal conductivity";

        protected
          Modelica.Media.Common.HelmholtzDerivs f
            "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
          SI.ThermalConductivity lambda_0=0 "Dilute gas thermal conductivity";
          SI.ThermalConductivity lambda_r=0
            "Residual fluid thermal conductivity";
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
          pddTref := Air_Utilities.Basic.Constants.R_bar*265.262*(1 + 2*f.delta
            *(f.fdelta - 1/f.delta) + f.delta^2*(f.fdeltadelta + 1/f.delta^2));
          xiref := Air_Utilities.Basic.Constants.pred*(d/Air_Utilities.Basic.Constants.MM)
            /Air_Utilities.Basic.Constants.rhored^2/pddTref;
          //calculating f at the given state
          f := Basic.Helmholtz(d, T);
          Omega := exp(
            Modelica.Media.Incompressible.TableBased.Polynomials_Temp.evaluate(
            {b[5],b[4],b[3],b[2],b[1]}, log(T/103.3)));
          //Ideal-gas part of dynamic viscosity
          eta_0 := 0.0266958*sqrt(1000*Air_Utilities.Basic.Constants.MM*T)/(
            0.36^2*Omega);
          //Ideal-gas part of thermal conductivity
          lambda_0 := Ncon[1]*eta_0 + Ncon[2]*f.tau^tcon[2] + Ncon[3]*f.tau^
            tcon[3];
          //Residual part of thermal conductivity
          for i in 4:9 loop
            lambda_r := lambda_r + Ncon[i]*f.tau^tcon[i]*f.delta^dcon[i]*exp(-
              gammacon[i]*f.delta^lcon[i]);
          end for;
          //Derivative of p w.r.t. d at constant temperature
          pddT := Air_Utilities.Basic.Constants.R*T*(1 + 2*f.delta*(f.fdelta -
            1/f.delta) + f.delta^2*(f.fdeltadelta + 1/f.delta^2));
          //chi_tilde at the given state
          xi := Air_Utilities.Basic.Constants.pred*(d/Air_Utilities.Basic.Constants.MM)
            /Air_Utilities.Basic.Constants.rhored^2/(pddT*Air_Utilities.Basic.Constants.MM);
          //Thermal conductivity critical enhancement
          xi := xi - xiref*265.262/T;
          if (xi <= 0) then
            lambda_c := 0;
          else
            xi := 0.11*(xi/0.055)^(0.63/1.2415);
            //Derivative of p w.r.t. T at constant p
            pdTp := Air_Utilities.Basic.Constants.R*d*(1 + f.delta*(f.fdelta -
              1/f.delta) - f.delta*f.tau*f.fdeltatau);
            //Specific isochoric heat capacity
            cv := Air_Utilities.Basic.Constants.R*(-f.tau*f.tau*f.ftautau);
            //Specific isobaric heat capacity
            cp := cv + T*pdTp*pdTp/(d*d*pddT);
            Omega_tilde := 2/Modelica.Constants.pi*((cp - cv)/cp*atan(xi/0.31)
               + cv/cp*xi/0.31);
            Omega_0_tilde := 2/Modelica.Constants.pi*(1 - exp(-1/((0.31/xi) + 1
              /3*(xi/0.31)^2*(Air_Utilities.Basic.Constants.rhored/(d/
              Air_Utilities.Basic.Constants.MM))^2)));
            lambda_c := d*cp*1.380658E-023*1.01*T/(6*Modelica.Constants.pi*xi*
              eta_dT(d, T))*(Omega_tilde - Omega_0_tilde)*1E012;
          end if;
          lambda := (lambda_0 + lambda_r + lambda_c)/1000;
        end lambda_dT;
      end Transport;

      function airBaseProp_ps "intermediate property record for air"
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
        aux.R := Air_Utilities.Basic.Constants.R;
        (aux.rho,aux.T) := Inverses.dTofps(
                p=p,
                s=s,
                delp=iter.delp,
                dels=iter.dels);
        f := Basic.Helmholtz(aux.rho, aux.T);
        aux.h := aux.R*aux.T*(f.tau*f.ftau + f.delta*f.fdelta) - Air_Utilities.Basic.Constants.h_off;
        aux.pd := aux.R*aux.T*f.delta*(2*f.fdelta + f.delta*f.fdeltadelta);
        aux.pt := aux.R*aux.rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
        aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
        aux.cp := aux.cv + aux.T*aux.pt*aux.pt/(aux.rho*aux.rho*aux.pd);
        aux.vp := -1/(aux.rho*aux.rho)*1/aux.pd;
        aux.vt := aux.pt/(aux.rho*aux.rho*aux.pd);
      end airBaseProp_ps;

      function rho_props_ps
        "density as function of pressure and specific entropy"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "pressure";
        input Modelica.SIunits.SpecificEntropy s "specific entropy";
        input Common.AuxiliaryProperties aux "auxiliary record";
        output Modelica.SIunits.Density rho "density";
      algorithm
        rho := aux.rho;
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
                Air_Utilities.airBaseProp_ps(p, s));
      end rho_ps;

      function T_props_ps
        "temperature as function of pressure and specific entropy"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "pressure";
        input Modelica.SIunits.SpecificEntropy s "specific entropy";
        input Common.AuxiliaryProperties aux "auxiliary record";
        output Modelica.SIunits.Temperature T "temperature";
      algorithm
        T := aux.T;
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
                Air_Utilities.airBaseProp_ps(p, s));
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
                Air_Utilities.airBaseProp_ps(p, s));
      end h_ps;

      function airBaseProp_ph "intermediate property record for air"
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
        aux.R := Air_Utilities.Basic.Constants.R;
        (aux.rho,aux.T) := Inverses.dTofph(
                p,
                h,
                delp=iter.delp,
                delh=iter.delh);
        f := Basic.Helmholtz(aux.rho, aux.T);
        aux.s := aux.R*(f.tau*f.ftau - f.f) - Air_Utilities.Basic.Constants.s_off;
        aux.pd := aux.R*aux.T*f.delta*(2*f.fdelta + f.delta*f.fdeltadelta);
        aux.pt := aux.R*aux.rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
        aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
        aux.cp := aux.cv + aux.T*aux.pt*aux.pt/(aux.rho*aux.rho*aux.pd);
        aux.vp := -1/(aux.rho*aux.rho)*1/aux.pd;
        aux.vt := aux.pt/(aux.rho*aux.rho*aux.pd);
      end airBaseProp_ph;

      function rho_props_ph
        "density as function of pressure and specific enthalpy"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "pressure";
        input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
        input Common.AuxiliaryProperties aux "auxiliary record";
        output Modelica.SIunits.Density rho "density";
      algorithm
        rho := aux.rho;
        annotation (
          derivative(noDerivative=aux) = rho_ph_der,
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
                Air_Utilities.airBaseProp_ph(p, h));
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
        rho_der := ((aux.rho*(aux.cv*aux.rho + aux.pt))/(aux.rho*aux.rho*aux.pd
          *aux.cv + aux.T*aux.pt*aux.pt))*p_der + (-aux.rho*aux.rho*aux.pt/(aux.rho
          *aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt))*h_der;
      end rho_ph_der;

      function T_props_ph
        "temperature as function of pressure and specific enthalpy"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "pressure";
        input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
        input Common.AuxiliaryProperties aux "auxiliary record";
        output Modelica.SIunits.Temperature T "temperature";
      algorithm
        T := aux.T;
        annotation (
          derivative(noDerivative=aux) = T_ph_der,
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
                Air_Utilities.airBaseProp_ph(p, h));
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
           + aux.T*aux.pt*aux.pt))*p_der + ((aux.rho*aux.rho*aux.pd)/(aux.rho*
          aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt))*h_der;
      end T_ph_der;

      function s_props_ph
        "specific entropy as function of pressure and specific enthalpy"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "pressure";
        input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
        input Common.AuxiliaryProperties aux "auxiliary record";
        output Modelica.SIunits.SpecificEntropy s "specific entropy";
      algorithm
        s := aux.s;
        annotation (
          derivative(noDerivative=aux) = s_ph_der,
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
                Air_Utilities.airBaseProp_ph(p, h));
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
        output Modelica.SIunits.SpecificHeatCapacity cv
          "specific heat capacity";
      algorithm
        cv := aux.cv;
        annotation (Inline=false, LateInline=true);
      end cv_props_ph;

      function cv_ph
        "specific heat capacity at constant volume as function of pressure and specific enthalpy"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "pressure";
        input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
        output Modelica.SIunits.SpecificHeatCapacity cv
          "specific heat capacity";
      algorithm
        cv := cv_props_ph(
                p,
                h,
                Air_Utilities.airBaseProp_ph(p, h));
      end cv_ph;

      function cp_props_ph
        "specific heat capacity at constant pressure as function of pressure and specific enthalpy"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "pressure";
        input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
        input Common.AuxiliaryProperties aux "auxiliary record";
        output Modelica.SIunits.SpecificHeatCapacity cp
          "specific heat capacity";
      algorithm
        cp := aux.cp;
        annotation (Inline=false, LateInline=true);
      end cp_props_ph;

      function cp_ph
        "specific heat capacity at constant pressure as function of pressure and specific enthalpy"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "pressure";
        input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
        output Modelica.SIunits.SpecificHeatCapacity cp
          "specific heat capacity";
      algorithm
        cp := cp_props_ph(
                p,
                h,
                Air_Utilities.airBaseProp_ph(p, h));
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
                Air_Utilities.airBaseProp_ph(p, h));
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
                Air_Utilities.airBaseProp_ph(p, h));
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
                Air_Utilities.airBaseProp_ph(p, h));
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
                Air_Utilities.airBaseProp_ph(p, h));
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
        ddph := ((aux.rho*(aux.cv*aux.rho + aux.pt))/(aux.rho*aux.rho*aux.pd*
          aux.cv + aux.T*aux.pt*aux.pt));
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
                Air_Utilities.airBaseProp_ph(p, h));
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
                Air_Utilities.airBaseProp_ph(p, h));
      end ddhp;

      function airBaseProp_pT
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
        aux.R := Air_Utilities.Basic.Constants.R;
        (aux.rho) := Inverses.dofpT(
                p=p,
                T=T,
                delp=iter.delp);
        f := Basic.Helmholtz(aux.rho, T);
        aux.h := aux.R*T*(f.tau*f.ftau + f.delta*f.fdelta) - Air_Utilities.Basic.Constants.h_off;
        aux.s := aux.R*(f.tau*f.ftau - f.f) - Air_Utilities.Basic.Constants.s_off;
        aux.pd := aux.R*T*f.delta*(2*f.fdelta + f.delta*f.fdeltadelta);
        aux.pt := aux.R*aux.rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
        aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
        aux.cp := aux.cv + aux.T*aux.pt*aux.pt/(aux.rho*aux.rho*aux.pd);
        aux.vp := -1/(aux.rho*aux.rho)*1/aux.pd;
        aux.vt := aux.pt/(aux.rho*aux.rho*aux.pd);
      end airBaseProp_pT;

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
                Air_Utilities.airBaseProp_pT(p, T));
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
                Air_Utilities.airBaseProp_pT(p, T));
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
        h_der := ((-aux.rho*aux.pd + T*aux.pt)/(aux.rho*aux.rho*aux.pd))*p_der
           + ((aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)/(aux.rho*
          aux.rho*aux.pd))*T_der;
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
                Air_Utilities.airBaseProp_pT(p, T));
      end s_pT;

      function cv_props_pT
        "specific heat capacity at constant volume as function of pressure and temperature"

        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "pressure";
        input Modelica.SIunits.Temperature T "temperature";
        input Common.AuxiliaryProperties aux "auxiliary record";
        output Modelica.SIunits.SpecificHeatCapacity cv
          "specific heat capacity";
      algorithm
        cv := aux.cv;
        annotation (Inline=false, LateInline=true);
      end cv_props_pT;

      function cv_pT
        "specific heat capacity at constant volume as function of pressure and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "pressure";
        input Modelica.SIunits.Temperature T "temperature";
        output Modelica.SIunits.SpecificHeatCapacity cv
          "specific heat capacity";
      algorithm
        cv := cv_props_pT(
                p,
                T,
                Air_Utilities.airBaseProp_pT(p, T));
      end cv_pT;

      function cp_props_pT
        "specific heat capacity at constant pressure as function of pressure and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "pressure";
        input Modelica.SIunits.Temperature T "temperature";
        input Common.AuxiliaryProperties aux "auxiliary record";
        output Modelica.SIunits.SpecificHeatCapacity cp
          "specific heat capacity";
      algorithm
        cp := aux.cp;
        annotation (Inline=false, LateInline=true);
      end cp_props_pT;

      function cp_pT
        "specific heat capacity at constant pressure as function of pressure and temperature"

        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "pressure";
        input Modelica.SIunits.Temperature T "temperature";
        output Modelica.SIunits.SpecificHeatCapacity cp
          "specific heat capacity";
      algorithm
        cp := cp_props_pT(
                p,
                T,
                Air_Utilities.airBaseProp_pT(p, T));
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
                Air_Utilities.airBaseProp_pT(p, T));
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
                Air_Utilities.airBaseProp_pT(p, T));
      end kappa_pT;

      function velocityOfSound_props_pT
        "speed of sound as function of pressure and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "pressure";
        input Modelica.SIunits.Temperature T "temperature";
        input Common.AuxiliaryProperties aux "auxiliary record";
        output Modelica.SIunits.Velocity a "speed of sound";
      algorithm
        a := sqrt(max(0, (aux.pd*aux.rho*aux.rho*aux.cv + aux.pt*aux.pt*aux.T)/
          (aux.rho*aux.rho*aux.cv)));
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
                Air_Utilities.airBaseProp_pT(p, T));
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
                Air_Utilities.airBaseProp_pT(p, T));
      end isentropicExponent_pT;

      function airBaseProp_dT
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
        aux.R := Air_Utilities.Basic.Constants.R;
        f := Basic.Helmholtz(d, T);
        aux.p := aux.R*d*T*f.delta*f.fdelta;
        aux.h := aux.R*T*(f.tau*f.ftau + f.delta*f.fdelta) - Air_Utilities.Basic.Constants.h_off;
        aux.s := aux.R*(f.tau*f.ftau - f.f) - Air_Utilities.Basic.Constants.s_off;
        aux.pd := aux.R*T*f.delta*(2*f.fdelta + f.delta*f.fdeltadelta);
        aux.pt := aux.R*d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
        aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
        aux.cp := aux.cv + aux.T*aux.pt*aux.pt/(d*d*aux.pd);
        aux.vp := -1/(aux.rho*aux.rho)*1/aux.pd;
        aux.vt := aux.pt/(aux.rho*aux.rho*aux.pd);
      end airBaseProp_dT;

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
                Air_Utilities.airBaseProp_dT(d, T));
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
        h_der := ((-d*aux.pd + T*aux.pt)/(d*d))*d_der + ((aux.cv*d + aux.pt)/d)
          *T_der;
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
                Air_Utilities.airBaseProp_dT(d, T));
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
                Air_Utilities.airBaseProp_dT(d, T));
      end s_dT;

      function cv_props_dT
        "specific heat capacity at constant volume as function of density and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Density d "density";
        input Modelica.SIunits.Temperature T "temperature";
        input Common.AuxiliaryProperties aux "auxiliary record";
        output Modelica.SIunits.SpecificHeatCapacity cv
          "specific heat capacity";
      algorithm
        cv := aux.cv;
        annotation (Inline=false, LateInline=true);
      end cv_props_dT;

      function cv_dT
        "specific heat capacity at constant volume as function of density and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Density d "density";
        input Modelica.SIunits.Temperature T "temperature";
        output Modelica.SIunits.SpecificHeatCapacity cv
          "specific heat capacity";
      algorithm
        cv := cv_props_dT(
                d,
                T,
                Air_Utilities.airBaseProp_dT(d, T));
      end cv_dT;

      function cp_props_dT
        "specific heat capacity at constant pressure as function of density and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Density d "density";
        input Modelica.SIunits.Temperature T "temperature";
        input Common.AuxiliaryProperties aux "auxiliary record";
        output Modelica.SIunits.SpecificHeatCapacity cp
          "specific heat capacity";
      algorithm
        cp := aux.cp;
        annotation (Inline=false, LateInline=true);
      end cp_props_dT;

      function cp_dT
        "specific heat capacity at constant pressure as function of density and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Density d "density";
        input Modelica.SIunits.Temperature T "temperature";
        output Modelica.SIunits.SpecificHeatCapacity cp
          "specific heat capacity";
      algorithm
        cp := cp_props_dT(
                d,
                T,
                Air_Utilities.airBaseProp_dT(d, T));
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
                Air_Utilities.airBaseProp_dT(d, T));
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
                Air_Utilities.airBaseProp_dT(d, T));
      end kappa_dT;

      function velocityOfSound_props_dT
        "speed of sound as function of density and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Density d "density";
        input Modelica.SIunits.Temperature T "temperature";
        input Common.AuxiliaryProperties aux "auxiliary record";
        output Modelica.SIunits.Velocity a "speed of sound";
      algorithm
        a := sqrt(max(0, ((aux.pd*aux.rho*aux.rho*aux.cv + aux.pt*aux.pt*aux.T)
          /(aux.rho*aux.rho*aux.cv))));
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
                Air_Utilities.airBaseProp_dT(d, T));
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
                Air_Utilities.airBaseProp_dT(d, T));
      end isentropicExponent_dT;

      function dynamicViscosity
        "Return dynamic viscosity as a function of the thermodynamic state record"
        extends Modelica.Icons.Function;
        input Air_Base.ThermodynamicState state "Thermodynamic state record";
        output SI.DynamicViscosity eta "Dynamic viscosity";
      algorithm
        eta := Transport.eta_dT(state.d, state.T);
      end dynamicViscosity;

      function thermalConductivity
        "Return thermal conductivity as a function of the thermodynamic state record"
        extends Modelica.Icons.Function;
        input Air_Base.ThermodynamicState state "Thermodynamic state record";
        output SI.ThermalConductivity lambda "Thermal conductivity";
      algorithm
        lambda := Transport.lambda_dT(state.d, state.T);
      end thermalConductivity;

    protected
      package ThermoFluidSpecial

        function air_ph
          "calculate the property record for dynamic simulation properties using p,h as states"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Pressure p "pressure";
          input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
          output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_ph
            pro "property record for dynamic simulation";
        protected
          Modelica.Media.Common.HelmholtzDerivs f
            "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
          Modelica.SIunits.Temperature T "temperature";
          Modelica.SIunits.Density d "density";
        algorithm
          (d,T) := Air_Utilities.Inverses.dTofph(
                    p=p,
                    h=h,
                    delp=1.0e-7,
                    delh=1.0e-6);
          f := Air_Utilities.Basic.Helmholtz(d, T);
          pro := Modelica.Media.Common.ThermoFluidSpecial.helmholtzToProps_ph(f);
        end air_ph;

        function air_dT
          "calculate property record for dynamic simulation properties using d and T as dynamic states"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Density d "density";
          input Modelica.SIunits.Temperature T "temperature";
          output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_dT
            pro "property record for dynamic simulation";
        protected
          Modelica.SIunits.Pressure p "pressure";
          Modelica.Media.Common.HelmholtzDerivs f
            "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
        algorithm
          f := Air_Utilities.Basic.Helmholtz(d, T);
          pro := Modelica.Media.Common.ThermoFluidSpecial.helmholtzToProps_dT(f);
        end air_dT;

        function air_pT
          "calculate property record for dynamic simulation properties using p and T as dynamic states"

          extends Modelica.Icons.Function;
          input Modelica.SIunits.Pressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature";
          output Modelica.Media.Common.ThermoFluidSpecial.ThermoProperties_pT
            pro "property record for dynamic simulation";
        protected
          Modelica.SIunits.Density d "density";
          Modelica.Media.Common.HelmholtzDerivs f
            "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
        algorithm
          d := Modelica.Media.Air.RealGasAir.Air_Utilities.Inverses.dofpT(
                    p=p,
                    T=T,
                    delp=1e-7);
          f := Air_Utilities.Basic.Helmholtz(d, T);
          pro := Modelica.Media.Common.ThermoFluidSpecial.helmholtzToProps_pT(f);
        end air_pT;
      end ThermoFluidSpecial;

      annotation (Documentation(info="<html>
</html>", revisions="<h4>Intermediate release notes during development</h4>
<p>Currenly the Events/noEvents switch is only implmented for p-h states. Only after testing that implmentation, it will be extended to dT.</p>"));
    end Air_Utilities;
    annotation (Documentation(info="<html>
<p>
Calculation of fluid properties of air in the fluid region of 130 Kelvin to 2000 Kelvin at pressures up to 2000 MPa. To use this package in your model, select <a href=\"modelica://Modelica.Media.Air.RealGasAir.Air_dT\">
Air_dT</a>, <a href=\"modelica://Modelica.Media.Air.RealGasAir.Air_pT\">
Air_pT</a> or <a href=\"modelica://Modelica.Media.Air.RealGasAir.Air_ph\">Air_ph</a> according to which variables you choose to determine your state.
</p>

<h4>Restriction</h4>
<p>
The functions provided by this package shall be used inside of the restricted limits according to the referenced literature.
</p>

<ul>
<li>
<b>p &le; 2000 MPa</b>
</li>
<li>
<b>130 K &le; T &le; 2000 K</b>
</li>
</ul>

<h4>References</h4>
<dl>
<dt>Lemmon, E. W., Jacobsen, R. T., Penoncello, S. G., Friend, D. G.:</dt>
<dd><b>Thermodynamic Properties of Air and Mixtures of Nitrogen, Argon,
and Oxygen From 60 to 2000 K at Pressures to 2000 MPa</b>. J. Phys. Chem. Ref. Data, Vol. 29, No. 3, 2000.
</dd>
<dt>Lemmon, E. W., Jacobsen, R. T.:</dt>
<dd><b>Viscosity and Thermal Conductivity Equations for
Nitrogen, Oxygen, Argon, and Air</b>. International Journal of Thermophysics, Vol. 25, No. 1, January 2004
</dd>
</dl>


<h4>Verification</h4>
<p>
The verification report for the development of this library is provided
<a href=\"modelica://Modelica/Resources/Documentation/Media/MoMoLib_VerificationResults_XRG.pdf\">here</a>.
</p>

<h4>Acknowledgment</h4>
<p>
This library was developed by XRG Simulation GmbH as part of the <a href=\"http://www.cleansky.eu/\">Clean Sky</a> JTI project (Project title: MoMoLib—Modelica Model Library Development for Media, Magnetic Systems and Wavelets; Project number: 296369; Theme: JTI-CS-2011-1-SGO-02-026: Modelica Model Library Development Part I). The partial financial support for the development of this library by the European Union is highly appreciated.
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
  end RealGasAir;

  package MoistAir "Air: Moist air model (190 ... 647 K)"
    extends Interfaces.PartialCondensingGases(
      mediumName="Moist air",
      substanceNames={"water","air"},
      final reducedX=true,
      final singleState=false,
      reference_X={0.01,0.99},
      fluidConstants={IdealGases.Common.FluidData.H2O,IdealGases.Common.FluidData.N2},
      Temperature(min=200, max=423.15));

    import Modelica.Media.IdealGases.Common.Functions;
    constant Integer Water=1
      "Index of water (in substanceNames, massFractions X, etc.)";
    constant Integer Air=2
      "Index of air (in substanceNames, massFractions X, etc.)";
    //     constant SI.Pressure psat_low=saturationPressureWithoutLimits(200.0);
    //     constant SI.Pressure psat_high=saturationPressureWithoutLimits(422.16);
    constant Real k_mair=steam.MM/dryair.MM "ratio of molar weights";

    constant IdealGases.Common.DataRecord dryair=IdealGases.Common.SingleGasesData.Air;
    constant IdealGases.Common.DataRecord steam=IdealGases.Common.SingleGasesData.H2O;
    constant SI.MolarMass[2] MMX={steam.MM,dryair.MM}
      "Molar masses of components";

    import Modelica.Media.Interfaces;
    import Modelica.Math;
    import Modelica.Constants;
    import Modelica.Media.IdealGases.Common.SingleGasNasa;
    import Modelica.Media.Interfaces.Choices.ReferenceEnthalpy;

    redeclare record extends ThermodynamicState
      "ThermodynamicState record for moist air"
    end ThermodynamicState;

    redeclare replaceable model extends BaseProperties(
      T(stateSelect=if preferredMediumStates then StateSelect.prefer else
            StateSelect.default),
      p(stateSelect=if preferredMediumStates then StateSelect.prefer else
            StateSelect.default),
      Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer
             else StateSelect.default),
      final standardOrderComponents=true) "Moist air base properties record"

      /* p, T, X = X[Water] are used as preferred states, since only then all
     other quantities can be computed in a recursive sequence.
     If other variables are selected as states, static state selection
     is no longer possible and non-linear algebraic equations occur.
      */
      MassFraction x_water "Mass of total water/mass of dry air";
      Real phi "Relative humidity";

    protected
      MassFraction X_liquid "Mass fraction of liquid or solid water";
      MassFraction X_steam "Mass fraction of steam water";
      MassFraction X_air "Mass fraction of air";
      MassFraction X_sat
        "Steam water mass fraction of saturation boundary in kg_water/kg_moistair";
      MassFraction x_sat
        "Steam water mass content of saturation boundary in kg_water/kg_dryair";
      AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
    equation
      assert(T >= 190 and T <= 647, "
Temperature T is not in the allowed range
190.0 K <= (T =" + String(T) + " K) <= 647.0 K
required from medium model \"" + mediumName + "\".");
      MM = 1/(Xi[Water]/MMX[Water] + (1.0 - Xi[Water])/MMX[Air]);

      p_steam_sat = min(saturationPressure(T), 0.999*p);
      X_sat = min(p_steam_sat*k_mair/max(100*Constants.eps, p - p_steam_sat)*(1
         - Xi[Water]), 1.0)
        "Water content at saturation with respect to actual water content";
      X_liquid = max(Xi[Water] - X_sat, 0.0);
      X_steam = Xi[Water] - X_liquid;
      X_air = 1 - Xi[Water];

      h = specificEnthalpy_pTX(
            p,
            T,
            Xi);
      R = dryair.R*(X_air/(1 - X_liquid)) + steam.R*X_steam/(1 - X_liquid);
      //
      u = h - R*T;
      d = p/(R*T);
      /* Note, u and d are computed under the assumption that the volume of the liquid
         water is negligible with respect to the volume of air and of steam
      */
      state.p = p;
      state.T = T;
      state.X = X;

      // these x are per unit mass of DRY air!
      x_sat = k_mair*p_steam_sat/max(100*Constants.eps, p - p_steam_sat);
      x_water = Xi[Water]/max(X_air, 100*Constants.eps);
      phi = p/p_steam_sat*Xi[Water]/(Xi[Water] + k_mair*X_air);
      annotation (Documentation(info="<html>
<p>This model computes thermodynamic properties of moist air from three independent (thermodynamic or/and numerical) state variables. Preferred numerical states are temperature T, pressure p and the reduced composition vector Xi, which contains the water mass fraction only. As an EOS the <b>ideal gas law</b> is used and associated restrictions apply. The model can also be used in the <b>fog region</b>, when moisture is present in its liquid state. However, it is assumed that the liquid water volume is negligible compared to that of the gas phase. Computation of thermal properties is based on property data of <a href=\"modelica://Modelica.Media.Air.DryAirNasa\"> dry air</a> and water (source: VDI-W&auml;rmeatlas), respectively. Besides the standard thermodynamic variables <b>absolute and relative humidity</b>, x_water and phi, respectively, are given by the model. Upper case X denotes absolute humidity with respect to mass of moist air while absolute humidity with respect to mass of dry air only is denoted by a lower case x throughout the model. See <a href=\"modelica://Modelica.Media.Air.MoistAir\">package description</a> for further information.</p>
</html>"));
    end BaseProperties;

    redeclare function setState_pTX
      "Return thermodynamic state as function of pressure p, temperature T and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state";
    algorithm
      state := if size(X, 1) == nX then ThermodynamicState(
            p=p,
            T=T,
            X=X) else ThermodynamicState(
            p=p,
            T=T,
            X=cat(
              1,
              X,
              {1 - sum(X)}));
      annotation (smoothOrder=2, Documentation(info="<html>
The <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state record</a> is computed from pressure p, temperature T and composition X.
</html>"));
    end setState_pTX;

    redeclare function setState_phX
      "Return thermodynamic state as function of pressure p, specific enthalpy h and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state";
    algorithm
      state := if size(X, 1) == nX then ThermodynamicState(
            p=p,
            T=T_phX(
              p,
              h,
              X),
            X=X) else ThermodynamicState(
            p=p,
            T=T_phX(
              p,
              h,
              X),
            X=cat(
              1,
              X,
              {1 - sum(X)}));
      annotation (smoothOrder=2, Documentation(info="<html>
The <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state record</a> is computed from pressure p, specific enthalpy h and composition X.
</html>"));
    end setState_phX;

    redeclare function setState_dTX
      "Return thermodynamic state as function of density d, temperature T and composition X"
      extends Modelica.Icons.Function;
      input Density d "density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state";
    algorithm
      state := if size(X, 1) == nX then ThermodynamicState(
            p=d*({steam.R,dryair.R}*X)*T,
            T=T,
            X=X) else ThermodynamicState(
            p=d*({steam.R,dryair.R}*cat(
              1,
              X,
              {1 - sum(X)}))*T,
            T=T,
            X=cat(
              1,
              X,
              {1 - sum(X)}));
      annotation (smoothOrder=2, Documentation(info="<html>
The <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state record</a> is computed from density d, temperature T and composition X.
</html>"));
    end setState_dTX;

    redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
    algorithm
      state := ThermodynamicState(
            p=Media.Common.smoothStep(
              x,
              state_a.p,
              state_b.p,
              x_small),
            T=Media.Common.smoothStep(
              x,
              state_a.T,
              state_b.T,
              x_small),
            X=Media.Common.smoothStep(
              x,
              state_a.X,
              state_b.X,
              x_small));
    end setSmoothState;

    function Xsaturation
      "Return absolute humidity per unit mass of moist air at saturation as a function of the thermodynamic state record"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction X_sat "Steam mass fraction of sat. boundary";
    algorithm
      X_sat := k_mair/(state.p/min(saturationPressure(state.T), 0.999*state.p)
         - 1 + k_mair);
      annotation (smoothOrder=2, Documentation(info="<html>
Absolute humidity per unit mass of moist air at saturation is computed from pressure and temperature in the state record. Note, that unlike X_sat in the BaseProperties model this mass fraction refers to mass of moist air at saturation.
</html>"));
    end Xsaturation;

    function xsaturation
      "Return absolute humidity per unit mass of dry air at saturation as a function of the thermodynamic state record"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction x_sat "Absolute humidity per unit mass of dry air";
    algorithm
      x_sat := k_mair*saturationPressure(state.T)/max(100*Constants.eps, state.p
         - saturationPressure(state.T));
      annotation (smoothOrder=2, Documentation(info="<html>
Absolute humidity per unit mass of dry air at saturation is computed from pressure and temperature in the thermodynamic state record.
</html>"));
    end xsaturation;

    function xsaturation_pT
      "Return absolute humidity per unit mass of dry air at saturation as a function of pressure p and temperature T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SI.Temperature T "Temperature";
      output MassFraction x_sat "Absolute humidity per unit mass of dry air";
    algorithm
      x_sat := k_mair*saturationPressure(T)/max(100*Constants.eps, p -
        saturationPressure(T));
      annotation (smoothOrder=2, Documentation(info="<html>
Absolute humidity per unit mass of dry air at saturation is computed from pressure and temperature.
</html>"));
    end xsaturation_pT;

    function massFraction_pTphi
      "Return steam mass fraction as a function of relative humidity phi and temperature T"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input Real phi "Relative humidity (0 ... 1.0)";
      output MassFraction X_steam "Absolute humidity, steam mass fraction";
    protected
      constant Real k=0.621964713077499 "Ratio of molar masses";
      AbsolutePressure psat=saturationPressure(T) "Saturation pressure";
    algorithm
      X_steam := phi*k/(k*phi + p/psat - phi);
      annotation (smoothOrder=2, Documentation(info="<html>
Absolute humidity per unit mass of moist air is computed from temperature, pressure and relative humidity.
</html>"));
    end massFraction_pTphi;

    function relativeHumidity_pTX
      "Return relative humidity as a function of pressure p, temperature T and composition X"
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.MassFraction[:] X "Composition";
      output Real phi "Relative humidity";
    protected
      SI.Pressure p_steam_sat "Saturation pressure";
      SI.MassFraction X_air "Dry air mass fraction";
    algorithm
      p_steam_sat := min(saturationPressure(T), 0.999*p);
      X_air := 1 - X[Water];
      phi := max(0.0, min(1.0, p/p_steam_sat*X[Water]/(X[Water] + k_mair*X_air)));
      annotation (smoothOrder=2, Documentation(info="<html>
Relative humidity is computed from pressure, temperature and composition with 1.0 as the upper limit at saturation. Water mass fraction is the first entry in the composition vector.
</html>"));
    end relativeHumidity_pTX;

    function relativeHumidity
      "Return relative humidity as a function of the thermodynamic state record"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state";
      output Real phi "Relative humidity";
    algorithm
      phi := relativeHumidity_pTX(
            state.p,
            state.T,
            state.X);
      annotation (smoothOrder=2, Documentation(info="<html>
Relative humidity is computed from the thermodynamic state record with 1.0 as the upper limit at saturation.
</html>"));
    end relativeHumidity;

    /*
    redeclare function setState_psX "Return thermodynamic state as function of p, s and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := if size(X,1) == nX then ThermodynamicState(p=p,T=T_psX(s,p,X),X=X)
        else ThermodynamicState(p=p,T=T_psX(p,s,X), X=cat(1,X,{1-sum(X)}));
    end setState_psX;
*/

    redeclare function extends gasConstant
      "Return ideal gas constant as a function from thermodynamic state, only valid for phi<1"

    algorithm
      R := dryair.R*(1 - state.X[Water]) + steam.R*state.X[Water];
      annotation (smoothOrder=2, Documentation(info="<html>
The ideal gas constant for moist air is computed from <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state</a> assuming that all water is in the gas phase.
</html>"));
    end gasConstant;

    function gasConstant_X
      "Return ideal gas constant as a function from composition X"
      extends Modelica.Icons.Function;
      input SI.MassFraction X[:] "Gas phase composition";
      output SI.SpecificHeatCapacity R "Ideal gas constant";
    algorithm
      R := dryair.R*(1 - X[Water]) + steam.R*X[Water];
      annotation (smoothOrder=2, Documentation(info="<html>
The ideal gas constant for moist air is computed from the gas phase composition. The first entry in composition vector X is the steam mass fraction of the gas phase.
</html>"));
    end gasConstant_X;

    function saturationPressureLiquid
      "Return saturation pressure of water as a function of temperature T in the range of 273.16 to 647.096 K"

      extends Modelica.Icons.Function;
      input SI.Temperature Tsat "saturation temperature";
      output SI.AbsolutePressure psat "saturation pressure";
    protected
      SI.Temperature Tcritical=647.096 "Critical temperature";
      SI.AbsolutePressure pcritical=22.064e6 "Critical pressure";
      Real r1=(1 - Tsat/Tcritical) "Common subexpression";
      Real a[:]={-7.85951783,1.84408259,-11.7866497,22.6807411,-15.9618719,
          1.80122502} "Coefficients a[:]";
      Real n[:]={1.0,1.5,3.0,3.5,4.0,7.5} "Coefficients n[:]";
    algorithm
      // Approach used here is based on Baehr: "Thermodynamik", 12th edition p.204ff, "Method of Wagner"
      psat := exp(((a[1]*r1^n[1] + a[2]*r1^n[2] + a[3]*r1^n[3] + a[4]*r1^n[4]
         + a[5]*r1^n[5] + a[6]*r1^n[6])*Tcritical)/Tsat)*pcritical;
      annotation (
        derivative=saturationPressureLiquid_der,
        Inline=false,
        smoothOrder=5,
        Documentation(info="<html>
<p>Saturation pressure of water above the triple point temperature is computed from temperature. </p>
<p>Source: A Saul, W Wagner: &quot;International equations for the saturation properties of ordinary water substance&quot;, equation 2.1 </p>
</html>"),
        Icon(graphics));
    end saturationPressureLiquid;

    function saturationPressureLiquid_der
      "Derivative function for 'saturationPressureLiquid'"

      extends Modelica.Icons.Function;
      input SI.Temperature Tsat "Saturation temperature";
      input Real dTsat(unit="K/s") "Saturation temperature derivative";
      output Real psat_der(unit="Pa/s") "Saturation pressure derivative";
    protected
      SI.Temperature Tcritical=647.096 "Critical temperature";
      SI.AbsolutePressure pcritical=22.064e6 "Critical pressure";
      Real r1=(1 - Tsat/Tcritical) "Common subexpression 1";
      Real r1_der=-1/Tcritical*dTsat "Derivative of common subexpression 1";
      Real a[:]={-7.85951783,1.84408259,-11.7866497,22.6807411,-15.9618719,
          1.80122502} "Coefficients a[:]";
      Real n[:]={1.0,1.5,3.0,3.5,4.0,7.5} "Coefficients n[:]";
      Real r2=(a[1]*r1^n[1] + a[2]*r1^n[2] + a[3]*r1^n[3] + a[4]*r1^n[4] + a[5]
          *r1^n[5] + a[6]*r1^n[6]) "Common subexpression 2";
    algorithm
      // Approach used here is based on Baehr: "Thermodynamik", 12th edition p.204ff, "Method of Wagner"
      //psat := exp(((a[1]*r1^n[1] + a[2]*r1^n[2] + a[3]*r1^n[3] + a[4]*r1^n[4] + a[5]*r1^n[5] + a[6]*r1^n[6])*Tcritical)/Tsat) * pcritical;
      psat_der := exp((r2*Tcritical)/Tsat)*pcritical*((a[1]*(r1^(n[1] - 1)*n[1]
        *r1_der) + a[2]*(r1^(n[2] - 1)*n[2]*r1_der) + a[3]*(r1^(n[3] - 1)*n[3]*
        r1_der) + a[4]*(r1^(n[4] - 1)*n[4]*r1_der) + a[5]*(r1^(n[5] - 1)*n[5]*
        r1_der) + a[6]*(r1^(n[6] - 1)*n[6]*r1_der))*Tcritical/Tsat - r2*
        Tcritical*dTsat/Tsat^2);
      annotation (
        Inline=false,
        smoothOrder=5,
        Documentation(info="<html>
<p>Saturation pressure of water above the triple point temperature is computed from temperature. </p>
<p>Source: A Saul, W Wagner: &quot;International equations for the saturation properties of ordinary water substance&quot;, equation 2.1 </p>
</html>"),
        Icon(graphics));
    end saturationPressureLiquid_der;

    function sublimationPressureIce
      "Return sublimation pressure of water as a function of temperature T between 190 and 273.16 K"

      extends Modelica.Icons.Function;
      input SI.Temperature Tsat "sublimation temperature";
      output SI.AbsolutePressure psat "sublimation pressure";
    protected
      SI.Temperature Ttriple=273.16 "Triple point temperature";
      SI.AbsolutePressure ptriple=611.657 "Triple point pressure";
      Real r1=Tsat/Ttriple "Common subexpression";
      Real a[:]={-13.9281690,34.7078238} "Coefficients a[:]";
      Real n[:]={-1.5,-1.25} "Coefficients n[:]";
    algorithm
      psat := exp(a[1] - a[1]*r1^n[1] + a[2] - a[2]*r1^n[2])*ptriple;
      annotation (
        Inline=false,
        smoothOrder=5,
        derivative=sublimationPressureIce_der,
        Documentation(info="<html>
<p>Sublimation pressure of water below the triple point temperature is computed from temperature.</p>
<p>Source: W Wagner, A Saul, A Pruss: &quot;International equations for the pressure along the melting and along the sublimation curve of ordinary water substance&quot;, equation 3.5</p>
</html>"),
        Icon(graphics));
    end sublimationPressureIce;

    function sublimationPressureIce_der
      "Derivative function for 'sublimationPressureIce'"

      extends Modelica.Icons.Function;
      input SI.Temperature Tsat "Sublimation temperature";
      input Real dTsat(unit="K/s") "Sublimation temperature derivative";
      output Real psat_der(unit="Pa/s") "Sublimation pressure derivative";
    protected
      SI.Temperature Ttriple=273.16 "Triple point temperature";
      SI.AbsolutePressure ptriple=611.657 "Triple point pressure";
      Real r1=Tsat/Ttriple "Common subexpression 1";
      Real r1_der=dTsat/Ttriple "Derivative of common subexpression 1";
      Real a[:]={-13.9281690,34.7078238} "Coefficients a[:]";
      Real n[:]={-1.5,-1.25} "Coefficients n[:]";
    algorithm
      //psat := exp(a[1] - a[1]*r1^n[1] + a[2] - a[2]*r1^n[2]) * ptriple;
      psat_der := exp(a[1] - a[1]*r1^n[1] + a[2] - a[2]*r1^n[2])*ptriple*(-(a[1]
        *(r1^(n[1] - 1)*n[1]*r1_der)) - (a[2]*(r1^(n[2] - 1)*n[2]*r1_der)));
      annotation (
        Inline=false,
        smoothOrder=5,
        Documentation(info="<html>
<p>Sublimation pressure of water below the triple point temperature is computed from temperature.</p>
<p>Source: W Wagner, A Saul, A Pruss: &quot;International equations for the pressure along the melting and along the sublimation curve of ordinary water substance&quot;, equation 3.5</p>
</html>"),
        Icon(graphics));
    end sublimationPressureIce_der;

    redeclare function extends saturationPressure
      "Return saturation pressure of water as a function of temperature T between 190 and 647.096 K"

    algorithm
      psat := Utilities.spliceFunction(
            saturationPressureLiquid(Tsat),
            sublimationPressureIce(Tsat),
            Tsat - 273.16,
            1.0);
      annotation (
        Inline=false,
        smoothOrder=5,
        derivative=saturationPressure_der,
        Documentation(info="<html>
Saturation pressure of water in the liquid and the solid region is computed using an Antoine-type correlation. It's range of validity is between 223.16 and 373.16 K. Outside of these limits a (less accurate) result is returned. Functions for the
<a href=\"modelica://Modelica.Media.Air.MoistAir.sublimationPressureIce\">solid</a> and the <a href=\"modelica://Modelica.Media.Air.MoistAir.saturationPressureLiquid\"> liquid</a> region, respectively, are combined using the first derivative continuous <a href=\"modelica://Modelica.Media.Air.MoistAir.Utilities.spliceFunction\">spliceFunction</a>.
</html>"));
    end saturationPressure;

    function saturationPressure_der
      "Derivative function for 'saturationPressure'"
      extends Modelica.Icons.Function;
      input Temperature Tsat "Saturation temperature";
      input Real dTsat(unit="K/s") "Time derivative of saturation temperature";
      output Real psat_der(unit="Pa/s") "Saturation pressure";

    algorithm
      /*psat := Utilities.spliceFunction(saturationPressureLiquid(Tsat),sublimationPressureIce(Tsat),Tsat-273.16,1.0);*/
      psat_der := Utilities.spliceFunction_der(
            saturationPressureLiquid(Tsat),
            sublimationPressureIce(Tsat),
            Tsat - 273.16,
            1.0,
            saturationPressureLiquid_der(Tsat=Tsat, dTsat=dTsat),
            sublimationPressureIce_der(Tsat=Tsat, dTsat=dTsat),
            dTsat,
            0);
      annotation (
        Inline=false,
        smoothOrder=5,
        Documentation(info="<html>
Derivative function of <a href=\"modelica://Modelica.Media.Air.MoistAir.saturationPressure\">saturationPressure</a>
</html>"));
    end saturationPressure_der;

    function saturationTemperature
      "Return saturation temperature of water as a function of (partial) pressure p"
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T_min=190 "Lower boundary of solution";
      input SI.Temperature T_max=647 "Upper boundary of solution";
      output SI.Temperature T "Saturation temperature";

    protected
      package Internal
        extends Modelica.Media.Common.OneNonLinearEquation;

        redeclare record extends f_nonlinear_Data
          // Define data to be passed to user function
        end f_nonlinear_Data;

        redeclare function extends f_nonlinear
        algorithm
          y := saturationPressure(x);
          // Compute the non-linear equation: y = f(x, Data)
        end f_nonlinear;

        // Dummy definition
        redeclare function extends solve
        end solve;
      end Internal;
    algorithm
      T := Internal.solve(
            p,
            T_min,
            T_max,
            f_nonlinear_data=Internal.f_nonlinear_Data());
      annotation (Documentation(info="<html>
 Computes saturation temperature from (partial) pressure via numerical inversion of the function <a href=\"modelica://Modelica.Media.Air.MoistAir.saturationPressure\">saturationPressure</a>. Therefore additional inputs are required (or the defaults are used) for upper and lower temperature bounds.
</html>"));
    end saturationTemperature;

    redeclare function extends enthalpyOfVaporization
      "Return enthalpy of vaporization of water as a function of temperature T, 273.16 to 647.096 K"

    protected
      Real Tcritical=647.096 "Critical temperature";
      Real dcritical=322 "Critical density";
      Real pcritical=22.064e6 "Critical pressure";
      Real n[:]={1,1.5,3,3.5,4,7.5} "Powers in equation (1)";
      Real a[:]={-7.85951783,1.84408259,-11.7866497,22.6807411,-15.9618719,
          1.80122502} "Coefficients in equation (1) of [1]";
      Real m[:]={1/3,2/3,5/3,16/3,43/3,110/3} "Powers in equation (2)";
      Real b[:]={1.99274064,1.09965342,-0.510839303,-1.75493479,-45.5170352,-6.74694450e5}
        "Coefficients in equation (2) of [1]";
      Real o[:]={2/6,4/6,8/6,18/6,37/6,71/6} "Powers in equation (3)";
      Real c[:]={-2.03150240,-2.68302940,-5.38626492,-17.2991605,-44.7586581,-63.9201063}
        "Coefficients in equation (3) of [1]";
      Real tau=1 - T/Tcritical "Temperature expression";
      Real r1=(a[1]*Tcritical*tau^n[1])/T + (a[2]*Tcritical*tau^n[2])/T + (a[3]
          *Tcritical*tau^n[3])/T + (a[4]*Tcritical*tau^n[4])/T + (a[5]*
          Tcritical*tau^n[5])/T + (a[6]*Tcritical*tau^n[6])/T "Expression 1";
      Real r2=a[1]*n[1]*tau^n[1] + a[2]*n[2]*tau^n[2] + a[3]*n[3]*tau^n[3] + a[
          4]*n[4]*tau^n[4] + a[5]*n[5]*tau^n[5] + a[6]*n[6]*tau^n[6]
        "Expression 2";
      Real dp=dcritical*(1 + b[1]*tau^m[1] + b[2]*tau^m[2] + b[3]*tau^m[3] + b[
          4]*tau^m[4] + b[5]*tau^m[5] + b[6]*tau^m[6])
        "Density of saturated liquid";
      Real dpp=dcritical*exp(c[1]*tau^o[1] + c[2]*tau^o[2] + c[3]*tau^o[3] + c[
          4]*tau^o[4] + c[5]*tau^o[5] + c[6]*tau^o[6])
        "Density of saturated vapor";
    algorithm
      r0 := -(((dp - dpp)*exp(r1)*pcritical*(r2 + r1*tau))/(dp*dpp*tau))
        "Difference of equations (7) and (6)";
      annotation (
        smoothOrder=2,
        Documentation(info="<html>
<p>Enthalpy of vaporization of water is computed from temperature in the region of 273.16 to 647.096 K.</p>
<p>Source: W Wagner, A Pruss: \"International equations for the saturation properties of ordinary water substance. Revised according to the international temperature scale of 1990\" (1993).</p>
</html>"),
        Icon(graphics));
    end enthalpyOfVaporization;

    function HeatCapacityOfWater
      "Return specific heat capacity of water (liquid only) as a function of temperature T"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      output SpecificHeatCapacity cp_fl "Specific heat capacity of liquid";
    algorithm
      cp_fl := 1e3*(4.2166 - (T - 273.15)*(0.0033166 + (T - 273.15)*(0.00010295
         - (T - 273.15)*(1.3819e-6 + (T - 273.15)*7.3221e-9))));
      annotation (Documentation(info="<html>
The specific heat capacity of water (liquid and solid) is calculated using a
                 polynomial approach and data from VDI-Waermeatlas 8. Edition (Db1)
</html>"), smoothOrder=2);
    end HeatCapacityOfWater;

    redeclare function extends enthalpyOfLiquid
      "Return enthalpy of liquid water as a function of temperature T(use enthalpyOfWater instead)"

    algorithm
      h := (T - 273.15)*1e3*(4.2166 - 0.5*(T - 273.15)*(0.0033166 + 0.333333*(T
         - 273.15)*(0.00010295 - 0.25*(T - 273.15)*(1.3819e-6 + 0.2*(T - 273.15)
        *7.3221e-9))));
      annotation (
        Inline=false,
        smoothOrder=5,
        Documentation(info="<html>
Specific enthalpy of liquid water is computed from temperature using a polynomial approach. Kept for compatibility reasons, better use <a href=\"modelica://Modelica.Media.Air.MoistAir.enthalpyOfWater\">enthalpyOfWater</a> instead.
</html>"));
    end enthalpyOfLiquid;

    redeclare function extends enthalpyOfGas
      "Return specific enthalpy of gas (air and steam) as a function of temperature T and composition X"

    algorithm
      h := Modelica.Media.IdealGases.Common.Functions.h_Tlow(
            data=steam,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=46479.819 + 2501014.5)*X[Water] +
        Modelica.Media.IdealGases.Common.Functions.h_Tlow(
            data=dryair,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=25104.684)*(1.0 - X[Water]);
      annotation (
        Inline=false,
        smoothOrder=5,
        Documentation(info="<html>
Specific enthalpy of moist air is computed from temperature, provided all water is in the gaseous state. The first entry in the composition vector X must be the mass fraction of steam. For a function that also covers the fog region please refer to <a href=\"modelica://Modelica.Media.Air.MoistAir.h_pTX\">h_pTX</a>.
</html>"));
    end enthalpyOfGas;

    redeclare function extends enthalpyOfCondensingGas
      "Return specific enthalpy of steam as a function of temperature T"

    algorithm
      h := Modelica.Media.IdealGases.Common.Functions.h_Tlow(
            data=steam,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=46479.819 + 2501014.5);
      annotation (
        Inline=false,
        smoothOrder=5,
        Documentation(info="<html>
Specific enthalpy of steam is computed from temperature.
</html>"));
    end enthalpyOfCondensingGas;

    redeclare function extends enthalpyOfNonCondensingGas
      "Return specific enthalpy of dry air as a function of temperature T"

    algorithm
      h := Modelica.Media.IdealGases.Common.Functions.h_Tlow(
            data=dryair,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=25104.684);
      annotation (
        Inline=false,
        smoothOrder=1,
        Documentation(info="<html>
Specific enthalpy of dry air is computed from temperature.
</html>"));
    end enthalpyOfNonCondensingGas;

    function enthalpyOfWater
      "Computes specific enthalpy of water (solid/liquid) near atmospheric pressure from temperature T"
      extends Modelica.Icons.Function;
      input SIunits.Temperature T "Temperature";
      output SIunits.SpecificEnthalpy h "Specific enthalpy of water";
    algorithm
      /*simple model assuming constant properties:
  heat capacity of liquid water:4200 J/kg
  heat capacity of solid water: 2050 J/kg
  enthalpy of fusion (liquid=>solid): 333000 J/kg*/

      h := Utilities.spliceFunction(
            4200*(T - 273.15),
            2050*(T - 273.15) - 333000,
            T - 273.16,
            0.1);
      annotation (derivative=enthalpyOfWater_der, Documentation(info="<html>
Specific enthalpy of water (liquid and solid) is computed from temperature using constant properties as follows:<br>
<ul>
<li>  heat capacity of liquid water:4200 J/kg
<li>  heat capacity of solid water: 2050 J/kg
<li>  enthalpy of fusion (liquid=>solid): 333000 J/kg
</ul>
Pressure is assumed to be around 1 bar. This function is usually used to determine the specific enthalpy of the liquid or solid fraction of moist air.
</html>"));
    end enthalpyOfWater;

    function enthalpyOfWater_der "Derivative function of enthalpyOfWater"
      extends Modelica.Icons.Function;
      input SIunits.Temperature T "Temperature";
      input Real dT(unit="K/s") "Time derivative of temperature";
      output Real dh(unit="J/(kg.s)") "Time derivative of specific enthalpy";
    algorithm
      /*simple model assuming constant properties:
  heat capacity of liquid water:4200 J/kg
  heat capacity of solid water: 2050 J/kg
  enthalpy of fusion (liquid=>solid): 333000 J/kg*/

      //h:=Utilities.spliceFunction(4200*(T-273.15),2050*(T-273.15)-333000,T-273.16,0.1);
      dh := Utilities.spliceFunction_der(
            4200*(T - 273.15),
            2050*(T - 273.15) - 333000,
            T - 273.16,
            0.1,
            4200*dT,
            2050*dT,
            dT,
            0);
      annotation (Documentation(info="<html>
Derivative function for <a href=\"modelica://Modelica.Media.Air.MoistAir.enthalpyOfWater\">enthalpyOfWater</a>.

</html>"));
    end enthalpyOfWater_der;

    redeclare function extends pressure
      "Returns pressure of ideal gas as a function of the thermodynamic state record"

    algorithm
      p := state.p;
      annotation (smoothOrder=2, Documentation(info="<html>
Pressure is returned from the thermodynamic state record input as a simple assignment.
</html>"));
    end pressure;

    redeclare function extends temperature
      "Return temperature of ideal gas as a function of the thermodynamic state record"

    algorithm
      T := state.T;
      annotation (smoothOrder=2, Documentation(info="<html>
Temperature is returned from the thermodynamic state record input as a simple assignment.
</html>"));
    end temperature;

    function T_phX
      "Return temperature as a function of pressure p, specific enthalpy h and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction[:] X "Mass fractions of composition";
      output Temperature T "Temperature";

    protected
      package Internal
        "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)"
        extends Modelica.Media.Common.OneNonLinearEquation;
        redeclare record extends f_nonlinear_Data
          "Data to be passed to non-linear function"
          extends Modelica.Media.IdealGases.Common.DataRecord;
        end f_nonlinear_Data;

        redeclare function extends f_nonlinear
        algorithm
          y := h_pTX(
                    p,
                    x,
                    X);
        end f_nonlinear;

        // Dummy definition has to be added for current Dymola
        redeclare function extends solve
        end solve;
      end Internal;

    algorithm
      T := Internal.solve(
            h,
            190,
            647,
            p,
            X[1:nXi],
            steam);
      annotation (Documentation(info="<html>
Temperature is computed from pressure, specific enthalpy and composition via numerical inversion of function <a href=\"modelica://Modelica.Media.Air.MoistAir.h_pTX\">h_pTX</a>.
</html>"));
    end T_phX;

    redeclare function extends density
      "Returns density of ideal gas as a function of the thermodynamic state record"

    algorithm
      d := state.p/(gasConstant(state)*state.T);
      annotation (smoothOrder=2, Documentation(info="<html>
Density is computed from pressure, temperature and composition in the thermodynamic state record applying the ideal gas law.
</html>"));
    end density;

    redeclare function extends specificEnthalpy
      "Return specific enthalpy of moist air as a function of the thermodynamic state record"

    algorithm
      h := h_pTX(
            state.p,
            state.T,
            state.X);
      annotation (smoothOrder=2, Documentation(info="<html>
Specific enthalpy of moist air is computed from the thermodynamic state record. The fog region is included for both, ice and liquid fog.
</html>"));
    end specificEnthalpy;

    function h_pTX
      "Return specific enthalpy of moist air as a function of pressure p, temperature T and composition X"
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.MassFraction X[:] "Mass fractions of moist air";
      output SI.SpecificEnthalpy h "Specific enthalpy at p, T, X";
    protected
      SI.AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
      SI.MassFraction X_sat "Absolute humidity per unit mass of moist air";
      SI.MassFraction X_liquid "mass fraction of liquid water";
      SI.MassFraction X_steam "mass fraction of steam water";
      SI.MassFraction X_air "mass fraction of air";
    algorithm
      p_steam_sat := saturationPressure(T);
      //p_steam_sat :=min(saturationPressure(T), 0.999*p);
      X_sat := min(p_steam_sat*k_mair/max(100*Constants.eps, p - p_steam_sat)*(
        1 - X[Water]), 1.0);
      X_liquid := max(X[Water] - X_sat, 0.0);
      X_steam := X[Water] - X_liquid;
      X_air := 1 - X[Water];
      /* h        := {SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=ReferenceEnthalpy.UserDefined, h_off=46479.819+2501014.5),
               SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=ReferenceEnthalpy.UserDefined, h_off=25104.684)}*
    {X_steam, X_air} + enthalpyOfLiquid(T)*X_liquid;*/
      h := {Modelica.Media.IdealGases.Common.Functions.h_Tlow(
            data=steam,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=46479.819 + 2501014.5),
        Modelica.Media.IdealGases.Common.Functions.h_Tlow(
            data=dryair,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=25104.684)}*{X_steam,X_air} + enthalpyOfWater(T)*X_liquid;
      annotation (
        derivative=h_pTX_der,
        Inline=false,
        Documentation(info="<html>
Specific enthalpy of moist air is computed from pressure, temperature and composition with X[1] as the total water mass fraction. The fog region is included for both, ice and liquid fog.
</html>"));
    end h_pTX;

    function h_pTX_der "Derivative function of h_pTX"
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.MassFraction X[:] "Mass fractions of moist air";
      input Real dp(unit="Pa/s") "Pressure derivative";
      input Real dT(unit="K/s") "Temperature derivative";
      input Real dX[:](each unit="1/s") "Composition derivative";
      output Real h_der(unit="J/(kg.s)") "Time derivative of specific enthalpy";
    protected
      SI.AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
      SI.MassFraction X_sat "Absolute humidity per unit mass of moist air";
      SI.MassFraction X_liquid "Mass fraction of liquid water";
      SI.MassFraction X_steam "Mass fraction of steam water";
      SI.MassFraction X_air "Mass fraction of air";
      SI.MassFraction x_sat
        "Absolute humidity per unit mass of dry air at saturation";
      Real dX_steam(unit="1/s") "Time derivative of steam mass fraction";
      Real dX_air(unit="1/s") "Time derivative of dry air mass fraction";
      Real dX_liq(unit="1/s")
        "Time derivative of liquid/solid water mass fraction";
      Real dps(unit="Pa/s") "Time derivative of saturation pressure";
      Real dx_sat(unit="1/s")
        "Time derivative of absolute humidity per unit mass of dry air";
    algorithm
      p_steam_sat := saturationPressure(T);
      x_sat := p_steam_sat*k_mair/max(100*Modelica.Constants.eps, p -
        p_steam_sat);
      X_sat := min(x_sat*(1 - X[Water]), 1.0);
      X_liquid := Utilities.smoothMax(
            X[Water] - X_sat,
            0.0,
            1e-5);
      X_steam := X[Water] - X_liquid;
      X_air := 1 - X[Water];

      dX_air := -dX[Water];
      dps := saturationPressure_der(Tsat=T, dTsat=dT);
      dx_sat := k_mair*(dps*(p - p_steam_sat) - p_steam_sat*(dp - dps))/(p -
        p_steam_sat)/(p - p_steam_sat);
      dX_liq := Utilities.smoothMax_der(
            X[Water] - X_sat,
            0.0,
            1e-5,
            (1 + x_sat)*dX[Water] - (1 - X[Water])*dx_sat,
            0,
            0);
      dX_steam := dX[Water] - dX_liq;

      h_der := X_steam*Modelica.Media.IdealGases.Common.Functions.h_Tlow_der(
            data=steam,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=46479.819 + 2501014.5,
            dT=dT) + dX_steam*Modelica.Media.IdealGases.Common.Functions.h_Tlow(
            data=steam,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=46479.819 + 2501014.5) + X_air*
        Modelica.Media.IdealGases.Common.Functions.h_Tlow_der(
            data=dryair,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=25104.684,
            dT=dT) + dX_air*Modelica.Media.IdealGases.Common.Functions.h_Tlow(
            data=dryair,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=25104.684) + X_liquid*enthalpyOfWater_der(T=T, dT=dT) +
        dX_liq*enthalpyOfWater(T);

      annotation (
        Inline=false,
        smoothOrder=1,
        Documentation(info="<html>
Derivative function for <a href=\"modelica://Modelica.Media.Air.MoistAir.h_pTX\">h_pTX</a>.
</html>"));
    end h_pTX_der;

    redeclare function extends isentropicExponent
      "Return isentropic exponent (only for gas fraction!)"
    algorithm
      gamma := specificHeatCapacityCp(state)/specificHeatCapacityCv(state);
    end isentropicExponent;

    function isentropicEnthalpyApproximation
      "Approximate calculation of h_is from upstream properties, downstream pressure, gas part only"
      extends Modelica.Icons.Function;
      input AbsolutePressure p2 "downstream pressure";
      input ThermodynamicState state "thermodynamic state at upstream location";
      output SpecificEnthalpy h_is "isentropic enthalpy";
    protected
      SpecificEnthalpy h "specific enthalpy at upstream location";
      IsentropicExponent gamma=isentropicExponent(state) "Isentropic exponent";
    protected
      MassFraction[nX] X "complete X-vector";
    algorithm
      X := state.X;
      //  X := if reducedX then cat(1,state.X,{1-sum(state.X)}) else state.X;
      h := {Modelica.Media.IdealGases.Common.Functions.h_Tlow(
            data=steam,
            T=state.T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=46479.819 + 2501014.5),
        Modelica.Media.IdealGases.Common.Functions.h_Tlow(
            data=dryair,
            T=state.T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=25104.684)}*X;

      h_is := h + gamma/(gamma - 1.0)*(state.T*gasConstant(state))*((p2/state.p)
        ^((gamma - 1)/gamma) - 1.0);
    end isentropicEnthalpyApproximation;

    redeclare function extends specificInternalEnergy
      "Return specific internal energy of moist air as a function of the thermodynamic state record"
      extends Modelica.Icons.Function;
      output SI.SpecificInternalEnergy u "Specific internal energy";
    algorithm
      u := specificInternalEnergy_pTX(
            state.p,
            state.T,
            state.X);

      annotation (smoothOrder=2, Documentation(info="<html>
Specific internal energy is determined from the thermodynamic state record, assuming that the liquid or solid water volume is negligible.
</html>"));
    end specificInternalEnergy;

    function specificInternalEnergy_pTX
      "Return specific internal energy of moist air as a function of pressure p, temperature T and composition X"
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.MassFraction X[:] "Mass fractions of moist air";
      output SI.SpecificInternalEnergy u "Specific internal energy";
    protected
      SI.AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
      SI.MassFraction X_liquid "Mass fraction of liquid water";
      SI.MassFraction X_steam "Mass fraction of steam water";
      SI.MassFraction X_air "Mass fraction of air";
      SI.MassFraction X_sat "Absolute humidity per unit mass of moist air";
      Real R_gas "Ideal gas constant";
    algorithm
      p_steam_sat := saturationPressure(T);
      X_sat := min(p_steam_sat*k_mair/max(100*Constants.eps, p - p_steam_sat)*(
        1 - X[Water]), 1.0);
      X_liquid := max(X[Water] - X_sat, 0.0);
      X_steam := X[Water] - X_liquid;
      X_air := 1 - X[Water];
      R_gas := dryair.R*X_air/(1 - X_liquid) + steam.R*X_steam/(1 - X_liquid);
      u := X_steam*Modelica.Media.IdealGases.Common.Functions.h_Tlow(
            data=steam,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=46479.819 + 2501014.5) + X_air*
        Modelica.Media.IdealGases.Common.Functions.h_Tlow(
            data=dryair,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=25104.684) + enthalpyOfWater(T)*X_liquid - R_gas*T;

      annotation (derivative=specificInternalEnergy_pTX_der, Documentation(info=
             "<html>
Specific internal energy is determined from pressure p, temperature T and composition X, assuming that the liquid or solid water volume is negligible.
</html>"));
    end specificInternalEnergy_pTX;

    function specificInternalEnergy_pTX_der
      "Derivative function for specificInternalEnergy_pTX"
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.MassFraction X[:] "Mass fractions of moist air";
      input Real dp(unit="Pa/s") "Pressure derivative";
      input Real dT(unit="K/s") "Temperature derivative";
      input Real dX[:](each unit="1/s") "Mass fraction derivatives";
      output Real u_der(unit="J/(kg.s)") "Specific internal energy derivative";
    protected
      SI.AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
      SI.MassFraction X_liquid "Mass fraction of liquid water";
      SI.MassFraction X_steam "Mass fraction of steam water";
      SI.MassFraction X_air "Mass fraction of air";
      SI.MassFraction X_sat "Absolute humidity per unit mass of moist air";
      SI.SpecificHeatCapacity R_gas "Ideal gas constant";

      SI.MassFraction x_sat
        "Absolute humidity per unit mass of dry air at saturation";
      Real dX_steam(unit="1/s") "Time derivative of steam mass fraction";
      Real dX_air(unit="1/s") "Time derivative of dry air mass fraction";
      Real dX_liq(unit="1/s")
        "Time derivative of liquid/solid water mass fraction";
      Real dps(unit="Pa/s") "Time derivative of saturation pressure";
      Real dx_sat(unit="1/s")
        "Time derivative of absolute humidity per unit mass of dry air";
      Real dR_gas(unit="J/(kg.K.s)") "Time derivative of ideal gas constant";
    algorithm
      p_steam_sat := saturationPressure(T);
      x_sat := p_steam_sat*k_mair/max(100*Modelica.Constants.eps, p -
        p_steam_sat);
      X_sat := min(x_sat*(1 - X[Water]), 1.0);
      X_liquid := Utilities.spliceFunction(
            X[Water] - X_sat,
            0.0,
            X[Water] - X_sat,
            1e-6);
      X_steam := X[Water] - X_liquid;
      X_air := 1 - X[Water];
      R_gas := steam.R*X_steam/(1 - X_liquid) + dryair.R*X_air/(1 - X_liquid);

      dX_air := -dX[Water];
      dps := saturationPressure_der(Tsat=T, dTsat=dT);
      dx_sat := k_mair*(dps*(p - p_steam_sat) - p_steam_sat*(dp - dps))/(p -
        p_steam_sat)/(p - p_steam_sat);
      dX_liq := Utilities.spliceFunction_der(
            X[Water] - X_sat,
            0.0,
            X[Water] - X_sat,
            1e-6,
            (1 + x_sat)*dX[Water] - (1 - X[Water])*dx_sat,
            0.0,
            (1 + x_sat)*dX[Water] - (1 - X[Water])*dx_sat,
            0.0);
      dX_steam := dX[Water] - dX_liq;
      dR_gas := (steam.R*(dX_steam*(1 - X_liquid) + dX_liq*X_steam) + dryair.R*
        (dX_air*(1 - X_liquid) + dX_liq*X_air))/(1 - X_liquid)/(1 - X_liquid);

      u_der := X_steam*Modelica.Media.IdealGases.Common.Functions.h_Tlow_der(
            data=steam,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=46479.819 + 2501014.5,
            dT=dT) + dX_steam*Modelica.Media.IdealGases.Common.Functions.h_Tlow(
            data=steam,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=46479.819 + 2501014.5) + X_air*
        Modelica.Media.IdealGases.Common.Functions.h_Tlow_der(
            data=dryair,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=25104.684,
            dT=dT) + dX_air*Modelica.Media.IdealGases.Common.Functions.h_Tlow(
            data=dryair,
            T=T,
            refChoice=ReferenceEnthalpy.UserDefined,
            h_off=25104.684) + X_liquid*enthalpyOfWater_der(T=T, dT=dT) +
        dX_liq*enthalpyOfWater(T) - dR_gas*T - R_gas*dT;
      annotation (Documentation(info="<html>
Derivative function for <a href=\"modelica://Modelica.Media.Air.MoistAir.specificInternalEnergy_pTX\">specificInternalEnergy_pTX</a>.
</html>"));
    end specificInternalEnergy_pTX_der;

    redeclare function extends specificEntropy
      "Return specific entropy from thermodynamic state record, only valid for phi<1"

    algorithm
      s := s_pTX(
            state.p,
            state.T,
            state.X);
      annotation (
        Inline=false,
        smoothOrder=2,
        Documentation(info="<html>
Specific entropy is calculated from the thermodynamic state record, assuming ideal gas behavior and including entropy of mixing. Liquid or solid water is not taken into account, the entire water content X[1] is assumed to be in the vapor state (relative humidity below 1.0).
</html>"));
    end specificEntropy;

    redeclare function extends specificGibbsEnergy
      "Return specific Gibbs energy as a function of the thermodynamic state record, only valid for phi<1"
      extends Modelica.Icons.Function;
    algorithm
      g := h_pTX(
            state.p,
            state.T,
            state.X) - state.T*specificEntropy(state);
      annotation (smoothOrder=2, Documentation(info="<html>
The Gibbs Energy is computed from the thermodynamic state record for moist air with a water content below saturation.
</html>"));
    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy
      "Return specific Helmholtz energy as a function of the thermodynamic state record, only valid for phi<1"
      extends Modelica.Icons.Function;
    algorithm
      f := h_pTX(
            state.p,
            state.T,
            state.X) - gasConstant(state)*state.T - state.T*specificEntropy(
        state);
      annotation (smoothOrder=2, Documentation(info="<html>
The Specific Helmholtz Energy is computed from the thermodynamic state record for moist air with a water content below saturation.
</html>"));
    end specificHelmholtzEnergy;

    redeclare function extends specificHeatCapacityCp
      "Return specific heat capacity at constant pressure as a function of the thermodynamic state record"

    protected
      Real dT(unit="s/K") = 1.0;
    algorithm
      cp := h_pTX_der(
            state.p,
            state.T,
            state.X,
            0.0,
            1.0,
            zeros(size(state.X, 1)))*dT "Definition of cp: dh/dT @ constant p";
      //      cp:= SingleGasNasa.cp_Tlow(dryair, state.T)*(1-state.X[Water])
      //        + SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water];
      annotation (
        Inline=false,
        smoothOrder=2,
        Documentation(info="<html>
The specific heat capacity at constant pressure <b>cp</b> is computed from temperature and composition for a mixture of steam (X[1]) and dry air. All water is assumed to be in the vapor state.
</html>"));
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv
      "Return specific heat capacity at constant volume as a function of the thermodynamic state record"

    algorithm
      cv := Modelica.Media.IdealGases.Common.Functions.cp_Tlow(dryair, state.T)
        *(1 - state.X[Water]) +
        Modelica.Media.IdealGases.Common.Functions.cp_Tlow(steam, state.T)*
        state.X[Water] - gasConstant(state);
      annotation (
        Inline=false,
        smoothOrder=2,
        Documentation(info="<html>
The specific heat capacity at constant density <b>cv</b> is computed from temperature and composition for a mixture of steam (X[1]) and dry air. All water is assumed to be in the vapor state.
</html>"));
    end specificHeatCapacityCv;

    redeclare function extends dynamicViscosity
      "Return dynamic viscosity as a function of the thermodynamic state record, valid from 123.15 K to 1273.15 K"

      import Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
    algorithm
      eta := 1e-6*Polynomials_Temp.evaluate({9.7391102886305869E-15,-3.1353724870333906E-11,
        4.3004876595642225E-08,-3.8228016291758240E-05,5.0427874367180762E-02,
        1.7239260139242528E+01}, Cv.to_degC(state.T));
      annotation (smoothOrder=2, Documentation(info="<html>
<p>Dynamic viscosity is computed from temperature using a simple polynomial for dry air. Range of validity is from 123.15 K to 1273.15 K. The influence of pressure and moisture is neglected. </p>
<p>Source: VDI Waermeatlas, 8th edition. </p>
</html>"));
    end dynamicViscosity;

    redeclare function extends thermalConductivity
      "Return thermal conductivity as a function of the thermodynamic state record, valid from 123.15 K to 1273.15 K"

      import Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
    algorithm
      lambda := 1e-3*Polynomials_Temp.evaluate({6.5691470817717812E-15,-3.4025961923050509E-11,
        5.3279284846303157E-08,-4.5340839289219472E-05,7.6129675309037664E-02,
        2.4169481088097051E+01}, Modelica.SIunits.Conversions.to_degC(state.T));
      annotation (smoothOrder=2, Documentation(info="<html>
<p>Thermal conductivity is computed from temperature using a simple polynomial for dry air. Range of validity is from 123.15 K to 1273.15 K. The influence of pressure and moisture is neglected. </p>
<p>Source: VDI Waermeatlas, 8th edition. </p>
</html>"));
    end thermalConductivity;

    package Utilities "utility functions"
      extends Modelica.Icons.Package;
      function spliceFunction "Spline interpolation of two functions"
        extends Modelica.Icons.Function;
        input Real pos "Returned value for x-deltax >= 0";
        input Real neg "Returned value for x+deltax <= 0";
        input Real x "Function argument";
        input Real deltax=1 "Region around x with spline interpolation";
        output Real out;
      protected
        Real scaledX;
        Real scaledX1;
        Real y;
      algorithm
        scaledX1 := x/deltax;
        scaledX := scaledX1*Modelica.Math.asin(1);
        if scaledX1 <= -0.999999999 then
          y := 0;
        elseif scaledX1 >= 0.999999999 then
          y := 1;
        else
          y := (Modelica.Math.tanh(Modelica.Math.tan(scaledX)) + 1)/2;
        end if;
        out := pos*y + (1 - y)*neg;
        annotation (derivative=spliceFunction_der);
      end spliceFunction;

      function spliceFunction_der "Derivative of spliceFunction"
        extends Modelica.Icons.Function;
        input Real pos;
        input Real neg;
        input Real x;
        input Real deltax=1;
        input Real dpos;
        input Real dneg;
        input Real dx;
        input Real ddeltax=0;
        output Real out;
      protected
        Real scaledX;
        Real scaledX1;
        Real dscaledX1;
        Real y;
      algorithm
        scaledX1 := x/deltax;
        scaledX := scaledX1*Modelica.Math.asin(1);
        dscaledX1 := (dx - scaledX1*ddeltax)/deltax;
        if scaledX1 <= -0.99999999999 then
          y := 0;
        elseif scaledX1 >= 0.9999999999 then
          y := 1;
        else
          y := (Modelica.Math.tanh(Modelica.Math.tan(scaledX)) + 1)/2;
        end if;
        out := dpos*y + (1 - y)*dneg;
        if (abs(scaledX1) < 1) then
          out := out + (pos - neg)*dscaledX1*Modelica.Math.asin(1)/2/(
            Modelica.Math.cosh(Modelica.Math.tan(scaledX))*Modelica.Math.cos(
            scaledX))^2;
        end if;
      end spliceFunction_der;

      function smoothMax
        extends Modelica.Icons.Function;
        import Modelica.Math;

        input Real x1 "First argument of smooth max operator";
        input Real x2 "Second argument of smooth max operator";
        input Real dx
          "Approximate difference between x1 and x2, below which regularization starts";
        output Real y "Result of smooth max operator";
      algorithm
        y := max(x1, x2) + Math.log((exp((4/dx)*(x1 - max(x1, x2)))) + (exp((4/
          dx)*(x2 - max(x1, x2)))))/(4/dx);
        annotation (smoothOrder=2, Documentation(info="<html>
<p>An implementation of Kreisselmeier Steinhauser smooth maximum</p>
</html>"));
      end smoothMax;

      function smoothMax_der
        extends Modelica.Icons.Function;

        import Modelica.Math.exp;
        import Modelica.Math.log;

        input Real x1 "First argument of smooth max operator";
        input Real x2 "Second argument of smooth max operator";
        input Real dx
          "Approximate difference between x1 and x2, below which regularization starts";
        input Real dx1;
        input Real dx2;
        input Real ddx;
        output Real dy "Derivative of smooth max operator";
      algorithm
        dy := (if x1 > x2 then dx1 else dx2) + 0.25*(((4*(dx1 - (if x1 > x2
           then dx1 else dx2))/dx - 4*(x1 - max(x1, x2))*ddx/dx^2)*exp(4*(x1 -
          max(x1, x2))/dx) + (4*(dx2 - (if x1 > x2 then dx1 else dx2))/dx - 4*(
          x2 - max(x1, x2))*ddx/dx^2)*exp(4*(x2 - max(x1, x2))/dx))*dx/(exp(4*(
          x1 - max(x1, x2))/dx) + exp(4*(x2 - max(x1, x2))/dx)) + log(exp(4*(x1
           - max(x1, x2))/dx) + exp(4*(x2 - max(x1, x2))/dx))*ddx);

        annotation (Documentation(info="<html>
<p>An implementation of Kreisselmeier Steinhauser smooth maximum</p>
</html>"));
      end smoothMax_der;
    end Utilities;

    model PsychrometricData "Produces plot data for psychrometric charts"
      extends Modelica.Icons.Example;
      package Medium = Modelica.Media.Air.MoistAir "Used medium package";
      parameter SIunits.Pressure p_const=1e5 "Pressure";
      parameter Integer n_T=11 "Number of isotherms";
      parameter SIunits.Temperature T_min=253.15 "Lowest isotherm";
      parameter SIunits.Temperature T_step=10
        "Temperature step between two isotherms";
      parameter Integer n_h=16
        "Number of lines with constant specific enthalpy";
      parameter SIunits.SpecificEnthalpy h_min=-20e3
        "Lowest line of constant enthalpy";
      parameter SIunits.SpecificEnthalpy h_step=1e4
        "Enthalpy step between two lines of constant enthalpy";
      parameter Integer n_phi=10
        "Number of lines with constant relative humidity";
      parameter Real phi_min=0.1 "Lowest line of constant humidity";
      parameter Real phi_step=0.1 "Step between two lines of constant humidity";
      parameter SIunits.MassFraction x_min=0.00
        "Minimum diagram absolute humidity";
      parameter SIunits.MassFraction x_max=0.03
        "Maximum diagram absolute humidity";
      parameter SIunits.Time t=1 "Simulation time";

      final parameter SIunits.Temperature[n_T] T_const={T_min - T_step + i*
          T_step for i in 1:n_T} "Constant temperatures";
      final parameter SIunits.SpecificEnthalpy[n_h] h_const={(i - 1)*h_step +
          h_min for i in 1:n_h} "Constant enthalpies";
      final parameter Real[n_phi] phi_const={(i - 1)*phi_step + phi_min for i in
              1:n_phi} "Constant relative humidities";
      final parameter Real diagSlope=Medium.enthalpyOfVaporization(273.15)
        "Rotation of diagram that zero degrees isotherm becomes horizontal outside the fog region";
      final parameter SIunits.MassFraction x_start=x_min
        "Initial absolute humidity in kg water/kg dry air";

      SIunits.MassFraction x(start=x_start)
        "Absolute humidity in kg water/kg dry air";
      SIunits.SpecificEnthalpy[n_T] hx_T "h_1+x for const T";
      SIunits.SpecificEnthalpy[n_h] hx_h(start=h_const) "Const h_1+x";
      SIunits.SpecificEnthalpy[n_phi] hx_phi "h_1+x for const phi";
      SIunits.SpecificEnthalpy[n_T] y_T "Chart enthalpy for const T";
      SIunits.SpecificEnthalpy[n_h] y_h "Chart enthalpy for const h";
      SIunits.SpecificEnthalpy[n_phi] y_phi "Chart enthalpy for const phi";
      Medium.BaseProperties[n_T] medium_T "Medium properties for const T";
      Medium.BaseProperties[n_phi] medium_phi "Medium properties for const phi";

    protected
      SIunits.Pressure[n_phi] ps_phi
        "Saturation pressure for constant-phi-lines";
      SIunits.Temperature[n_phi] T_phi(each start=290);
      Boolean[n_T] fog(start=fill(false, n_T))
        "Triggers events at intersection of isotherms with phi=1";
      SIunits.Pressure[n_T] pd "Steam partial pressure along isotherms";
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
        pd[i] = medium_T[i].Xi[1]*medium_T[i].MM/MMX[1]*p_const;
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

<img src=\"modelica://Modelica/Resources/Images/Media/Air/Mollier.png\">

<img src=\"modelica://Modelica/Resources/Images/Media/Air/PsycroChart.png\">

<p>
<b>Legend:</b> blue - constant specific enthalpy, red - constant temperature, black - constant relative humidity</p>

<p>The model provides data for lines of constant specific enthalpy, temperature and relative humidity in a Mollier Diagram or Psychrometric Chart as they were used for the figures above. For limitations and ranges of validity please refer to the <a href=\"modelica://Modelica.Media.Air.MoistAir\">MoistAir package description</a>. Absolute humidity <b>x</b> is increased with time in this model. The specific enthalpies adjusted for plotting are then obtained from:</p>
<ul>
<li><b>y_h</b>: constant specific enthalpy</li>
<li><b>y_T</b>: constant temperature</li>
<li><b>y_phi</b>: constant relative humidity</li>
</ul>
</html>"));
    end PsychrometricData;

    redeclare function extends velocityOfSound
    algorithm
      a := sqrt(isentropicExponent(state)*gasConstant(state)*temperature(state));
      annotation (Documentation(revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
</html>"));
    end velocityOfSound;

    redeclare function extends isobaricExpansionCoefficient

    algorithm
      beta := 1/temperature(state);
      annotation (Documentation(revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
</html>"));
    end isobaricExpansionCoefficient;

    redeclare function extends isothermalCompressibility

    algorithm
      kappa := 1/pressure(state);
      annotation (Documentation(revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
</html>"));
    end isothermalCompressibility;

    redeclare function extends density_derp_h

    algorithm
      ddph := 1/(gasConstant(state)*temperature(state));

      annotation (Documentation(revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
</html>"));
    end density_derp_h;

    redeclare function extends density_derh_p

    algorithm
      ddhp := -density(state)/(specificHeatCapacityCp(state)*temperature(state));
      annotation (Documentation(revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
</html>"));
    end density_derh_p;

    redeclare function extends density_derp_T

    algorithm
      ddpT := 1/(gasConstant(state)*temperature(state));

      annotation (Documentation(revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
</html>"));
    end density_derp_T;

    redeclare function extends density_derT_p

    algorithm
      ddTp := -density(state)/temperature(state);
      annotation (Documentation(revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
</html>"));
    end density_derT_p;

    redeclare function extends density_derX

    algorithm
      dddX[Water] := pressure(state)*(steam.R - dryair.R)/((steam.R - dryair.R)
        *state.X[Water]*temperature(state) + dryair.R*temperature(state))^2;
      dddX[Air] := pressure(state)*(dryair.R - steam.R)/((dryair.R - steam.R)*
        state.X[Air]*temperature(state) + steam.R*temperature(state))^2;

      annotation (Documentation(revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
</html>"));
    end density_derX;

    redeclare function extends molarMass
    algorithm
      MM := Modelica.Media.Air.MoistAir.gasConstant(state)/Modelica.Constants.R;
      annotation (Documentation(revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
</html>"));
    end molarMass;

    function T_psX
      "Return temperature as a function of pressure p, specific entropy s and composition X"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction[:] X "Mass fractions of composition";
      output Temperature T "Temperature";

    protected
      package Internal "Solve s(data,T) for T with given s"
        extends Modelica.Media.Common.OneNonLinearEquation;
        redeclare record extends f_nonlinear_Data
          "Data to be passed to non-linear function"
          extends Modelica.Media.IdealGases.Common.DataRecord;
        end f_nonlinear_Data;

        redeclare function extends f_nonlinear
        algorithm
          y := s_pTX(
                    p,
                    x,
                    X);
        end f_nonlinear;

        // Dummy definition has to be added for current Dymola
        redeclare function extends solve
        end solve;
      end Internal;

    algorithm
      T := Internal.solve(
            s,
            190,
            647,
            p,
            X[1:nX],
            steam);
      annotation (Documentation(info="<html>
Temperature is computed from pressure, specific entropy and composition via numerical inversion of function <a href=\"modelica://Modelica.Media.Air.MoistAir.specificEntropy\">specificEntropy</a>.
</html>", revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
</html>"));
    end T_psX;

    redeclare function extends setState_psX
    algorithm
      state := if size(X, 1) == nX then ThermodynamicState(
            p=p,
            T=T_psX(
              p,
              s,
              X),
            X=X) else ThermodynamicState(
            p=p,
            T=T_psX(
              p,
              s,
              X),
            X=cat(
              1,
              X,
              {1 - sum(X)}));
      annotation (smoothOrder=2, Documentation(info="<html>
The <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state record</a> is computed from pressure p, specific enthalpy h and composition X.
</html>", revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
</html>"));
    end setState_psX;

    function s_pTX
      "Return specific entropy of moist air as a function of pressure p, temperature T and composition X (only valid for phi<1)"
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.MassFraction X[:] "Mass fractions of moist air";
      output SI.SpecificEntropy s "Specific entropy at p, T, X";
    protected
      MoleFraction[2] Y=massToMoleFractions(X, {steam.MM,dryair.MM})
        "molar fraction";

    algorithm
      s := Modelica.Media.IdealGases.Common.Functions.s0_Tlow(dryair, T)*(1 - X[
        Water]) + Modelica.Media.IdealGases.Common.Functions.s0_Tlow(steam, T)*
        X[Water] - Modelica.Constants.R*(Utilities.smoothMax(
            X[Water]/MMX[Water]*Modelica.Math.log(max(Y[Water], Modelica.Constants.eps)
          *p/reference_p),
            0.0,
            1e-9) - Utilities.smoothMax(
            (1 - X[Water])/MMX[Air]*Modelica.Math.log(max(Y[Air], Modelica.Constants.eps)
          *p/reference_p),
            0.0,
            1e-9));
      annotation (
        derivative=s_pTX_der,
        Inline=false,
        Documentation(info="<html>
Specific entropy of moist air is computed from pressure, temperature and composition with X[1] as the total water mass fraction.
</html>", revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
</html>"),
        Icon(graphics={Text(
                  extent={{-100,100},{100,-100}},
                  lineColor={255,127,0},
                  textString="f")}));
    end s_pTX;

    function s_pTX_der
      "Return specific entropy of moist air as a function of pressure p, temperature T and composition X (only valid for phi<1)"
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.MassFraction X[:] "Mass fractions of moist air";
      input Real dp(unit="Pa/s") "derivative of pressure";
      input Real dT(unit="K/s") "derivative of temperature";
      input Real dX[nX](unit="1/s") "derivative of mass fractions";
      output Real ds(unit="J/(kg.K.s)") "Specific entropy at p, T, X";
    protected
      MoleFraction[2] Y=massToMoleFractions(X, {steam.MM,dryair.MM})
        "molar fraction";

    algorithm
      ds := Modelica.Media.IdealGases.Common.Functions.s0_Tlow_der(
            dryair,
            T,
            dT)*(1 - X[Water]) +
        Modelica.Media.IdealGases.Common.Functions.s0_Tlow_der(
            steam,
            T,
            dT)*X[Water] + Modelica.Media.IdealGases.Common.Functions.s0_Tlow(
        dryair, T)*dX[Air] + Modelica.Media.IdealGases.Common.Functions.s0_Tlow(
        steam, T)*dX[Water] - Modelica.Constants.R*(1/MMX[Water]*
        Utilities.smoothMax_der(
            X[Water]*Modelica.Math.log(max(Y[Water], Modelica.Constants.eps)*p/
          reference_p),
            0.0,
            1e-9,
            (Modelica.Math.log(max(Y[Water], Modelica.Constants.eps)*p/
          reference_p) + (X[Water]/Y[Water]*(X[Air]*MMX[Water]/(X[Air]*MMX[
          Water] + X[Water]*MMX[Air])^2)))*dX[Water] + X[Water]*reference_p/p*
          dp,
            0,
            0) - 1/MMX[Air]*Utilities.smoothMax_der(
            (1 - X[Water])*Modelica.Math.log(max(Y[Air], Modelica.Constants.eps)
          *p/reference_p),
            0.0,
            1e-9,
            (Modelica.Math.log(max(Y[Air], Modelica.Constants.eps)*p/
          reference_p) + (X[Air]/Y[Air]*(X[Water]*MMX[Air]/(X[Air]*MMX[Water]
           + X[Water]*MMX[Air])^2)))*dX[Air] + X[Air]*reference_p/p*dp,
            0,
            0));
      annotation (
        Inline=false,
        smoothOrder=1,
        Documentation(info="<html>
Specific entropy of moist air is computed from pressure, temperature and composition with X[1] as the total water mass fraction.
</html>", revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
</html>"),
        Icon(graphics={Text(
                  extent={{-100,100},{100,-100}},
                  lineColor={255,127,0},
                  textString="f")}));
    end s_pTX_der;

    redeclare function extends isentropicEnthalpy
      "isentropic enthalpy (only valid for phi<1)"
      extends Modelica.Icons.Function;
    algorithm
      h_is := Modelica.Media.Air.MoistAir.h_pTX(
            p_downstream,
            Modelica.Media.Air.MoistAir.T_psX(
              p_downstream,
              Modelica.Media.Air.MoistAir.specificEntropy(refState),
              refState.X),
            refState.X);

      annotation (Icon(graphics={Text(
                  extent={{-100,100},{100,-100}},
                  lineColor={255,127,0},
                  textString="f")}), Documentation(revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
</html>"));
    end isentropicEnthalpy;
    annotation (Documentation(info="<html>
<h4>Thermodynamic Model</h4>
<p>This package provides a full thermodynamic model of moist air including the fog region and temperatures below zero degC.
The governing assumptions in this model are:</p>
<ul>
<li>the perfect gas law applies</li>
<li>water volume other than that of steam is neglected</li></ul>
<p>All extensive properties are expressed in terms of the total mass in order to comply with other media in this library. However, for moist air it is rather common to express the absolute humidity in terms of mass of dry air only, which has advantages when working with charts. In addition, care must be taken, when working with mass fractions with respect to total mass, that all properties refer to the same water content when being used in mathematical operations (which is always the case if based on dry air only). Therefore two absolute humidities are computed in the <b>BaseProperties</b> model: <b>X</b> denotes the absolute humidity in terms of the total mass while <b>x</b> denotes the absolute humidity per unit mass of dry air. In addition, the relative humidity <b>phi</b> is also computed.</p>
<p>At the triple point temperature of water of 0.01 &deg;C or 273.16 K and a relative humidity greater than 1 fog may be present as liquid and as ice resulting in a specific enthalpy somewhere between those of the two isotherms for solid and liquid fog, respectively. For numerical reasons a coexisting mixture of 50% solid and 50% liquid fog is assumed in the fog region at the triple point in this model.</p>

<h4>Range of validity</h4>
<p>From the assumptions mentioned above it follows that the <b>pressure</b> should be in the region around <b>atmospheric</b> conditions or below (a few bars may still be fine though). Additionally a very high water content at low temperatures would yield incorrect densities, because the volume of the liquid or solid phase would not be negligible anymore. The model does not provide information on limits for water drop size in the fog region or transport information for the actual condensation or evaporation process in combination with surfaces. All excess water which is not in its vapour state is assumed to be still present in the air regarding its energy but not in terms of its spatial extent.<br><br>
The thermodynamic model may be used for <b>temperatures</b> ranging from <b>190 ... 647 K</b>. This holds for all functions unless otherwise stated in their description. However, although the model works at temperatures above the saturation temperature it is questionable to use the term \"relative humidity\" in this region. Please note, that although several functions compute pure water properties, they are designed to be used within the moist air medium model where properties are dominated by air and steam in their vapor states, and not for pure liquid water applications.</p>

<h4>Transport Properties</h4>
<p>Several additional functions that are not needed to describe the thermodynamic system, but are required to model transport processes, like heat and mass transfer, may be called. They usually neglect the moisture influence unless otherwise stated.</p>

<h4>Application</h4>
<p>The model's main area of application is all processes that involve moist air cooling under near atmospheric pressure with possible moisture condensation. This is the case in all domestic and industrial air conditioning applications. Another large domain of moist air applications covers all processes that deal with dehydration of bulk material using air as a transport medium. Engineering tasks involving moist air are often performed (or at least visualized) by using charts that contain all relevant thermodynamic data for a moist air system. These so called psychrometric charts can be generated from the medium properties in this package. The model <a href=\"modelica://Modelica.Media.Air.MoistAir.PsychrometricData\">PsychrometricData</a> may be used for this purpose in order to obtain data for figures like those below (the plotting itself is not part of the model though).</p>

<img src=\"modelica://Modelica/Resources/Images/Media/Air/Mollier.png\">

<img src=\"modelica://Modelica/Resources/Images/Media/Air/PsycroChart.png\">

<p>
<b>Legend:</b> blue - constant specific enthalpy, red - constant temperature, black - constant relative humidity</p>

</html>"));
  end MoistAir;

  package RealGasMoistAir
    "RealGasMoistAir: Detailed moist air model (143.15 ... 2000 K)"

    extends Modelica.Media.Interfaces.PartialRealCondensingGases(
      mediumName="Moist air",
      substanceNames={"Water","Air"},
      final fixedX=false,
      final reducedX=true,
      final singleState=false,
      reference_X={0.01,0.99},
      fluidConstants={Modelica.Media.Water.IAPWS95.Water95_Base.waterConstants,
          Modelica.Media.Air.RealGasAir.Air_Base.airConstants},
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX);

    constant Integer Water=1
      "Index of water (in substanceNames, massFractions X, etc.)";

    constant Integer Air=2
      "Index of air (in substanceNames, massFractions X, etc.)";

    constant Boolean useEnhancementFactor=false
      "Use the enhancement factor in the calculations";

    constant Boolean useDissociation=true
      "Take dissociation into account for high temperatures";

    constant Real k_mair=steam.MM/dryair.MM "ratio of molar weights";

    constant Common.FundamentalConstants dryair=Modelica.Media.Air.RealGasAir.Air_Utilities.Basic.Constants;
    constant Common.FundamentalConstants steam=Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Constants;
    constant SI.MolarMass[2] MMX={steam.MM,dryair.MM}
      "Molar masses of components";

    import Modelica.Media.Interfaces;
    import Modelica.Math;
    import SI = Modelica.SIunits;
    import Cv = Modelica.SIunits.Conversions;
    import Modelica.Constants;
    import Modelica.Media.IdealGases.Common.SingleGasNasa;

    redeclare record extends ThermodynamicState
      "ThermodynamicState record for moist air"
    end ThermodynamicState;

    redeclare replaceable model extends BaseProperties(
      T(stateSelect=if preferredMediumStates then StateSelect.prefer else
            StateSelect.default),
      p(stateSelect=if preferredMediumStates then StateSelect.prefer else
            StateSelect.default),
      Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer
             else StateSelect.default),
      final standardOrderComponents=true) "Moist air base properties record"

      MassFraction x_water "Mass of total water/mass of dry air";
      Real phi "Relative humidity";

    protected
      MassFraction X_liquid "Mass fraction of liquid or solid water";
      MassFraction X_steam "Mass fraction of steam water";
      MassFraction X_air "Mass fraction of air";
      MassFraction X_sat
        "Steam water mass fraction of saturation boundary in kg_water/kg_moistair";
      MassFraction x_sat
        "Steam water mass content of saturation boundary in kg_water/kg_dryair";
      AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
    equation
      assert(T >= 143.15 and T <= 2000,
        "Temperature T is not in the allowed range 143.15 K <= (T =" + String(T)
         + " K) <= 2000 K required from medium model \"" + mediumName + "\".");

      MM = 1/(Xi[Water]/MMX[Water] + (1.0 - Xi[Water])/MMX[Air]);

      p_steam_sat = Modelica.Media.Air.RealGasMoistAir.Utilities.pds_pT(p, T);
      X_sat = k_mair/(p/p_steam_sat - 1 + k_mair);
      X_liquid = Xi[Water] - X_sat;
      X_steam = Xi[Water] - X_liquid;
      X_air = 1 - Xi[Water];

      h = specificEnthalpy_pTX(
            p,
            T,
            Xi);
      R = dryair.R*(X_air/(1 - X_liquid)) + steam.R*X_steam/(1 - X_liquid);
      u = Modelica.Media.Air.RealGasMoistAir.Utilities.u_pTX(
            p,
            T,
            Xi);
      d = Modelica.Media.Air.RealGasMoistAir.Utilities.rho_pTX(
            p,
            T,
            Xi);
      state.p = p;
      state.T = T;
      state.X = X;

      // these x are per unit mass of DRY air!
      x_sat = k_mair*p_steam_sat/max(100*Constants.eps, p - p_steam_sat);
      x_water = Xi[Water]/max(X_air, 100*Constants.eps);
      phi = Modelica.Media.Air.RealGasMoistAir.Utilities.phi_pTX(
            p,
            T,
            Xi);

    end BaseProperties;

    redeclare function extends setState_pTX
      "Return thermodynamic state as function of pressure p, temperature T and composition X"
    algorithm
      state := if size(X, 1) == nX then ThermodynamicState(
            p=p,
            T=T,
            X=X) else ThermodynamicState(
            p=p,
            T=T,
            X=cat(
              1,
              X,
              {1 - sum(X)}));
    end setState_pTX;

    redeclare function extends setState_phX
      "Return thermodynamic state as function of pressure p, specific enthalpy h and composition X"
    algorithm
      state := if size(X, 1) == nX then ThermodynamicState(
            p=p,
            T=Modelica.Media.Air.RealGasMoistAir.Utilities.Inverses.T_phX(
              p,
              h,
              X),
            X=X) else ThermodynamicState(
            p=p,
            T=Modelica.Media.Air.RealGasMoistAir.Utilities.Inverses.T_phX(
              p,
              h,
              X),
            X=cat(
              1,
              X,
              {1 - sum(X)}));
    end setState_phX;

    redeclare function extends setState_psX
      "Return thermodynamic state as function of pressure p, specific enthalpy h and composition X"
    algorithm
      state := if size(X, 1) == nX then ThermodynamicState(
            p=p,
            T=Modelica.Media.Air.RealGasMoistAir.Utilities.Inverses.T_psX(
              p,
              s,
              X),
            X=X) else ThermodynamicState(
            p=p,
            T=Modelica.Media.Air.RealGasMoistAir.Utilities.Inverses.T_psX(
              p,
              s,
              X),
            X=cat(
              1,
              X,
              {1 - sum(X)}));
    end setState_psX;

    redeclare function extends setState_dTX
      "Return thermodynamic state as function of density d, temperature T and composition X"
    algorithm
      state := if size(X, 1) == nX then ThermodynamicState(
            p=Modelica.Media.Air.RealGasMoistAir.Utilities.Inverses.p_dTX(
              d,
              T,
              X),
            T=T,
            X=X) else ThermodynamicState(
            p=Modelica.Media.Air.RealGasMoistAir.Utilities.Inverses.p_dTX(
              d,
              T,
              X),
            T=T,
            X=cat(
              1,
              X,
              {1 - sum(X)}));
    end setState_dTX;

    redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
    algorithm
      state := ThermodynamicState(
            p=Modelica.Media.Common.smoothStep(
              x,
              state_a.p,
              state_b.p,
              x_small),
            T=Modelica.Media.Common.smoothStep(
              x,
              state_a.T,
              state_b.T,
              x_small),
            X=Modelica.Media.Common.smoothStep(
              x,
              state_a.X,
              state_b.X,
              x_small));
    end setSmoothState;

    function Xsaturation
      "Return absolute humitity per unit mass of moist air at saturation as a function of the thermodynamic state record"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction X_sat "Steam mass fraction of sat. boundary";
    protected
      MassFraction[:] X;
    algorithm
      X := massFractionSaturation(state);
      X_sat := X[1];
    end Xsaturation;

    function xsaturation
      "Return absolute humitity per unit mass of dry air at saturation as a function of the thermodynamic state record"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction x_sat "Absolute humidity per unit mass of dry air";
    algorithm
      x_sat := Modelica.Media.Air.RealGasMoistAir.Utilities.xws_pT(state.p,
        state.T);
      assert(x_sat > -1,
        "Calculation of absolute humidity is meaningless\nfor input pressure p = "
         + String(state.p) + " Pa and temperature T = " + String(state.T) +
        " K.");
    end xsaturation;

    redeclare function extends massFraction_pTphi
      "Return mass fractions as a function of pressure, temperature and relative humidity"
    protected
      Real pds;

    algorithm
      assert(phi < 1.0 and phi > 0, "Illegal input phi = " + String(phi) +
        ". Relative humidity is only defined in the range\n 0 <= phi <= 1.0.");
      pds := Modelica.Media.Air.RealGasMoistAir.Utilities.pds_pT(p, T);
      assert(pds > -1,
        "Calculation of mass fraction of steam is meaningless\nfor input pressure p = "
         + String(p) + " Pa and temperature T = " + String(T) + " K.");
      X := {phi*k_mair/(p/pds - phi),1 - phi*k_mair/(p/pds - phi)};
    end massFraction_pTphi;

    function massFractionWaterVapor "Return mass fraction of water vapor"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction X "mass fraction of water varpor";
    protected
      Real xw;
      Real xws;
    algorithm
      xw := state.X[1]/(1 - state.X[1]);
      xws := Utilities.xws_pT(state.p, state.T);
      X := if (xw <= xws) then xw/(1 + xw) else xws/(1 + xw);
    end massFractionWaterVapor;

    function massFractionWaterNonVapor
      "Return mass fraction of liquid and solid water"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction X "mass fraction of water varpor";
    protected
      Real xw;
      Real xws;
    algorithm
      xw := state.X[1]/(1 - state.X[1]);
      xws := Utilities.xws_pT(state.p, state.T);
      X := if (xw <= xws) then 0 else (xw - xws)/(1 + xw);
    end massFractionWaterNonVapor;

    redeclare function extends massFractionSaturation
      "Return saturation mass fractions"
    protected
      AbsolutePressure pds;
    algorithm
      pds := Utilities.pds_pT(state.p, state.T);
      Xsat := {k_mair/(state.p/pds - 1 + k_mair),(state.p/pds - 1)/(state.p/pds
         - 1 + k_mair)};
      assert(Xsat[1] > -1,
        "Calculation of saturation mass fraction is meaningless\nfor input pressure p = "
         + String(state.p) + " Pa and temperature T = " + String(state.T) +
        " K.");
    end massFractionSaturation;

    function massFractionSaturation_ppsat
      "Return mass fvraction at saturation boundary given pressure and saturation pressure"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "ambient pressure";
      input AbsolutePressure psat "saturation pressure";
      output MassFraction[:] X "mass fraction";
    algorithm
      X := {k_mair/(p/psat - 1 + k_mair),(p/psat - 1)/(p/psat - 1 + k_mair)};
    end massFractionSaturation_ppsat;

    function massFraction_waterContent
      "Return mass fractions as a function of pressure, temperature and absolute humidity in kg(water)/kg(dry air)"
      extends Modelica.Icons.Function;
      input Real xw "water content in kg(water)/kg(dry air)";
      output MassFraction[:] X "mass fractions";
    algorithm
      X := {xw/(1 + xw),1/(1 + xw)};
    end massFraction_waterContent;

    function waterContent_X
      "Return water content in kg(water)/kg(dry air) given mass fractions"
      extends Modelica.Icons.Function;
      input MassFraction[:] X "mass fractions";
      output Real xw "water content in kg(water)/kg(dry air)";
    algorithm
      xw := X[1]/(1 - X[1]);
    end waterContent_X;

    redeclare function extends relativeHumidity "Return relativ humidity"
    algorithm
      phi := Utilities.phi_pTX(
            state.p,
            state.T,
            state.X);
      assert(phi > -1,
        "Calculation of relative humidity is meaningless\nfor input pressure p = "
         + String(state.p) + " Pa and temperature T = " + String(state.T) +
        " K.");
    end relativeHumidity;

    redeclare function extends gasConstant
      "Return ideal gas constant as a function from thermodynamic state, only valid for phi<1"

    algorithm
      R := dryair.R*(1 - state.X[Water]) + steam.R*state.X[Water];
    end gasConstant;

    function saturationPressureLiquid
      "Return saturation pressure of water as a function of temperature T"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output AbsolutePressure psat "saturation pressure";
    algorithm
      psat := Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.psat(state.T);
    end saturationPressureLiquid;

    function sublimationPressureIce
      "Return sublimation pressure of water as a function of temperature T between 223.16 and 273.16 K"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output AbsolutePressure psat "sublimation pressure";
    algorithm
      psat := Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.psub(state.T);
    end sublimationPressureIce;

    redeclare function extends saturationPressure
      "Return saturation pressure of condensing fluid"
    algorithm
      psat := Utilities.pds_pT(state.p, state.T);
      assert(psat > -1,
        "Calculation of saturation pressure is meaningless\nfor input temperature T = "
         + String(state.T) + " K.");
    end saturationPressure;

    redeclare function extends saturationTemperature
      "Return saturation temperature of condensing fluid"
    protected
      partial function Tsat_res
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input SI.Pressure p "Pressure";

      algorithm
        y := Modelica.Media.Air.RealGasMoistAir.Utilities.pds_pT(p=p, T=u) - p;
      end Tsat_res;

    algorithm
      Tsat := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
            function Tsat_res(state.p),
            50.0,
            673.15,
            1e-9);
    end saturationTemperature;

    redeclare function extends enthalpyOfVaporization
      "Return enthalpy of vaporization of water"
    protected
      AbsolutePressure p_liq;
    algorithm
      p_liq := saturationPressureLiquid(state);
      r0 := Modelica.Media.Water.IF97_Utilities.hv_p(p_liq) -
        Modelica.Media.Water.IF97_Utilities.hl_p(p_liq);
    end enthalpyOfVaporization;

    redeclare function extends enthalpyOfLiquid
      "Return enthalpy of liquid water"
    protected
      Real xw;
      Real xws;
    algorithm
      xw := state.X[1]/(1 - state.X[1]);
      xws := Utilities.xws_pT(state.p, state.T);
      if ((xws > xw) and (state.T > 273.15)) then
        h := Modelica.Media.Water.IF97_Utilities.h_pT(
              state.p,
              state.T,
              region=1);
      else
        h := 0;
      end if;
    end enthalpyOfLiquid;

    redeclare function extends enthalpyOfGas
      "Return specific enthalpy of gas (air and steam)"
    protected
      Real xw;
      Real xws;
      Real pd;
      Real pl;

    algorithm
      pd := Utilities.pd_pTX(
            state.p,
            state.T,
            state.X);
      pl := state.p - pd;
      xw := state.X[1]/(1 - state.X[1]);
      xws := Utilities.xws_pT(state.p, state.T);
      if ((xw <= xws) or (xws == -1)) then
        h := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT(pl, state.T) + xw
          *Utilities.IF97_new.h_pT(pd, state.T);
      else
        if (state.T < 273.16) then
          h := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT(pl, state.T) +
            xws*Utilities.IF97_new.h_pT(pd, state.T);
        else
          h := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT(pl, state.T) +
            xws*Utilities.IF97_new.h_pT(pd, state.T);
        end if;
      end if;
      annotation (Inline=false, LateInline=true);
    end enthalpyOfGas;

    redeclare function extends enthalpyOfCondensingGas
      "Return specific enthalpy of steam"
    protected
      Real xw;
      Real pd;

    algorithm
      pd := Utilities.pd_pTX(
            state.p,
            state.T,
            state.X);
      xw := state.X[1]/(1 - state.X[1]);
      h := xw*Utilities.IF97_new.h_pT(pd, state.T);
      annotation (Inline=false, LateInline=true);
    end enthalpyOfCondensingGas;

    redeclare function extends enthalpyOfNonCondensingGas
      "Return specific enthalpy of dry air"

    algorithm
      h := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT(state.p, state.T);
    end enthalpyOfNonCondensingGas;

    function enthalpyOfDryAir = enthalpyOfNonCondensingGas
      "Return specific enthalpy of dry air";
    function enthalpyOfWater
      "Return specific enthalpy of water (solid + liquid + steam)"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SI.SpecificEnthalpy h "Specific enthalpy of water";
    algorithm
      h := specificEnthalpy(state) - enthalpyOfNonCondensingGas(state);
    end enthalpyOfWater;

    function enthalpyOfWaterVapor = enthalpyOfCondensingGas
      "Return specific enthalpy of steam";
    function enthalpyOfWaterNonVapor
      "Return enthalpy of liquid and solid water"
      extends Modelica.Icons.Function;
      input ThermodynamicState state "Thermodynamic state record";
      output SI.SpecificEnthalpy h "Specific enthalpy of water";
    algorithm
      h := enthalpyOfWater(state) - enthalpyOfWaterVapor(state);
    end enthalpyOfWaterNonVapor;

    redeclare function extends pressure
      "Returns pressure of ideal gas as a function of the thermodynamic state record"

    algorithm
      p := state.p;

    end pressure;

    redeclare function extends temperature
      "Return temperature of ideal gas as a function of the thermodynamic state record"

    algorithm
      T := state.T;

    end temperature;

    redeclare function extends density
      "Returns density as a function of the thermodynamic state record"

    algorithm
      d := Utilities.rho_pTX(
            state.p,
            state.T,
            state.X);

    end density;

    redeclare function extends specificEnthalpy
      "Return specific enthalpy of moist air as a function of the thermodynamic state record"

    algorithm
      h := Modelica.Media.Air.RealGasMoistAir.Utilities.h_pTX(
            state.p,
            state.T,
            state.X);

    end specificEnthalpy;

    redeclare function extends specificInternalEnergy
      "Return specific internal energy of moist air as a function of the thermodynamic state record"

    algorithm
      u := Utilities.u_pTX(
            state.p,
            state.T,
            state.X);

    end specificInternalEnergy;

    redeclare function extends specificEntropy
      "Return specific entropy from thermodynamic state record, only valid for phi<1"

    algorithm
      s := Utilities.s_pTX(
            state.p,
            state.T,
            state.X);

    end specificEntropy;

    redeclare function extends specificGibbsEnergy
      "Return specific Gibbs energy as a function of the thermodynamic state record, only valid for phi<1"
    algorithm
      g := Utilities.h_pTX(
            state.p,
            state.T,
            state.X) - state.T*Utilities.s_pTX(
            state.p,
            state.T,
            state.X);

    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy
      "Return specific Helmholtz energy as a function of the thermodynamic state record, only valid for phi<1"

    algorithm
      f := Utilities.u_pTX(
            state.p,
            state.T,
            state.X) - state.T*Utilities.s_pTX(
            state.p,
            state.T,
            state.X);

    end specificHelmholtzEnergy;

    redeclare function extends specificHeatCapacityCp
      "Return specific heat capacity at constant pressure as a function of the thermodynamic state record"

    algorithm
      cp := Utilities.cp_pTX(
            state.p,
            state.T,
            state.X);

    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv
      "Return specific heat capacity at constant volume as a function of the thermodynamic state record"

    algorithm
      cv := Utilities.cv_pTX(
            state.p,
            state.T,
            state.X);

    end specificHeatCapacityCv;

    redeclare function extends isentropicExponent "Return isentropic exponent"
    algorithm
      gamma := specificHeatCapacityCp(state)/specificHeatCapacityCv(state);
    end isentropicExponent;

    redeclare function extends isentropicEnthalpy "Return isentropic enthalpy"
    protected
      MassFraction[nX] X "complete X-vector";
    algorithm
      X := if reducedX then cat(
            1,
            refState.X,
            {1 - sum(refState.X)}) else refState.X;
      h_is := specificEnthalpy(setState_psX(
            p_downstream,
            specificEntropy(refState),
            X));
    end isentropicEnthalpy;

    redeclare function extends velocityOfSound "Return velocity of sound"
    algorithm
      a := sqrt(max(0, gasConstant(state)*state.T*specificHeatCapacityCp(state)
        /specificHeatCapacityCv(state)));
    end velocityOfSound;

    redeclare function extends molarMass "Return the molar mass of the medium"
    algorithm
      MM := 1/(state.X[1]*steam.MM + state.X[2]*dryair.MM);
    end molarMass;

    redeclare function extends dynamicViscosity
      "Return dynamic viscosity as a function of the thermodynamic state record, valid from 73.15 K to 373.15 K"
    algorithm
      eta := Utilities.Transport.eta_pTX(
            state.p,
            state.T,
            state.X);

    end dynamicViscosity;

    redeclare function extends thermalConductivity
      "Return thermal conductivity as a function of the thermodynamic state record, valid from 73.15 K to 373.15 K"
    algorithm
      lambda := Utilities.Transport.lambda_pTX(
            state.p,
            state.T,
            state.X);

    end thermalConductivity;

    package Utilities "Utilitiy package for moist air"
      extends Modelica.Icons.Package;

      final constant MoleFraction[4] MMX={18.015257E-003,28.01348E-003,
          31.9988E-003,39.948E-003};

      final constant Real[3] Xi_Air={0.7557,0.2316,0.0127};

      package Inverses "Compute inverse function"
        extends Modelica.Icons.BasesPackage;

        function T_phX
          "Return temperature as a function of pressure, specific enthalpy and mass fractions"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure p "Pressure";
          input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
          input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
            "Mass fractions";
          output Modelica.SIunits.Temperature T "Temperature";

        protected
          MassFraction[nX] Xfull=if size(X, 1) == nX then X else cat(
                      1,
                      X,
                      {1 - sum(X)});

          function T_phX_res
            extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
            input Modelica.SIunits.AbsolutePressure p "Pressure";
            input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
            input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
              "Mass fractions";
          algorithm
            y := Modelica.Media.Air.RealGasMoistAir.Utilities.h_pTX(
                        p=p,
                        T=u,
                        X=X) - h;
          end T_phX_res;

        algorithm
          T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
                    function T_phX_res(
                      p=p,
                      h=h,
                      X=Xfull),
                    173.15,
                    2000.0,
                    1e-9);
          annotation (inverse(h=Modelica.Media.Air.RealGasMoistAir.Utilities.h_pTX(
                          p=p,
                          T=T,
                          X=X)));
        end T_phX;

        function T_psX
          "Return temperature as function of pressure, specific entropy and mass fractions"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure p "Pressure";
          input Modelica.SIunits.SpecificEntropy s "specific entropy";
          input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
            "Mass fractions";
          output Modelica.SIunits.Temperature T "Temperature";

        protected
          MassFraction[nX] Xfull=if size(X, 1) == nX then X else cat(
                      1,
                      X,
                      {1 - sum(X)});

          function T_psX_res
            extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
            input Modelica.SIunits.AbsolutePressure p "Pressure";
            input Modelica.SIunits.SpecificEntropy s "specific entropy";
            input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
              "Mass fractions";
          algorithm
            y := Modelica.Media.Air.RealGasMoistAir.Utilities.s_pTX(
                        p=p,
                        T=u,
                        X=X) - s;
          end T_psX_res;

        algorithm
          T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
                    function T_psX_res(
                      p=p,
                      s=s,
                      X=Xfull),
                    173.15,
                    2000.0,
                    1e-9);
          annotation (inverse(s=Modelica.Media.Air.RealGasMoistAir.Utilities.s_pTX(
                          p=p,
                          T=T,
                          X=X)));
        end T_psX;

        function p_dTX
          "Return pressure as function of density, temperature and mass fractions"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Density d "Density";
          input Modelica.SIunits.Temperature T "Temperature";
          input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
            "Mass fractions";
          output Modelica.SIunits.AbsolutePressure p "Pressure";

        protected
          MassFraction[nX] Xfull=if size(X, 1) == nX then X else cat(
                      1,
                      X,
                      {1 - sum(X)});

          function p_dTX_res
            extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
            input Modelica.SIunits.Density d "Density";
            input Modelica.SIunits.Temperature T "Temperature";
            input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
              "Mass fractions";
          algorithm
            y := Modelica.Media.Air.RealGasMoistAir.Utilities.rho_pTX(
                        p=u,
                        T=T,
                        X=X) - d;
          end p_dTX_res;

        algorithm
          p := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
                    function p_dTX_res(
                      d=d,
                      T=T,
                      X=Xfull),
                    173.15,
                    2000.0,
                    1e-9);
          annotation (inverse(d=Modelica.Media.Air.RealGasMoistAir.Utilities.rho_pTX(
                          p=p,
                          T=T,
                          X=X)));
        end p_dTX;
      end Inverses;

      package Transport "Package for transport properties of moist air"
        extends Modelica.Icons.BasesPackage;

        record coef
          "Coefficients for polynomials used to calculate transport properties"
          extends Modelica.Icons.Record;
          Real sigma=2.52;
          Real epsilon=775;
          Real M=18.0152;
          Real R=0.46144;
          Real[5] w={0.69339511,-0.002597963,1.2864772,0.1576848,0.02543632};
          Real[5] a={0.4159259E+001,-0.1725577E-002,0.5702012E-005,-0.4596049E-008,
              0.1424309E-011};
        end coef;

        function eta_pTX "Dynamic viscosity"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure p "Pressure";
          input Modelica.SIunits.Temperature T "Temperature";
          input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
            "Mass fractions";
          output Modelica.SIunits.DynamicViscosity eta "Dynamic viscosity";

        protected
          Real ya;
          Real yd;
          Real yf;
          Real va;
          Real vd;
          Real vf;
          Real xw;
          Real xws;
          Real pd;
          Real pl;
          Real da;
          Real dd;
          Real df;
          Real Omega;
          Real Tred;
          Real etad;
          Modelica.Media.Air.RealGasMoistAir.Utilities.Transport.coef coef;

        algorithm
          xw := X[1]/(1 - X[1]);
          xws := Modelica.Media.Air.RealGasMoistAir.Utilities.xws_pT(p, T);
          pd := Modelica.Media.Air.RealGasMoistAir.Utilities.pd_pTX(
                    p,
                    T,
                    X);
          pl := p - pd;
          da := Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT(pl, T);
          if ((xw <= xws) or (xws == -1)) then
            if (T < 273.16) then
              dd := pd/(Modelica.Media.Air.RealGasMoistAir.steam.R*T);
              ya := da/(da + dd);
              yd := 1 - ya;
              Tred := T/coef.epsilon;
              Omega := coef.w[1] + coef.w[2]*Tred + coef.w[3]*Modelica.Math.exp(
                coef.w[4]*Tred)/(coef.w[5] + Tred);
              etad := 2.6695E-006*sqrt(T*coef.M)/(coef.sigma^2*Omega);
              eta := ya*
                Modelica.Media.Air.RealGasAir.Air_Utilities.Transport.eta_dT(da,
                T) + yd*etad;
            else
              dd :=
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.rho_pT(pd,
                T);
              ya := da/(da + dd);
              yd := 1 - ya;
              eta := ya*
                Modelica.Media.Air.RealGasAir.Air_Utilities.Transport.eta_dT(da,
                T) + yd*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.visc_dT(
                dd, T);
            end if;
          else
            if (T < 273.16) then
              dd := pd/(Modelica.Media.Air.RealGasMoistAir.steam.R*T);
              ya := da/(da + dd);
              yd := 1 - ya;
              Tred := T/coef.epsilon;
              Omega := coef.w[1] + coef.w[2]*Tred + coef.w[3]*Modelica.Math.exp(
                coef.w[4]*Tred)/(coef.w[5] + Tred);
              etad := 2.6695E-006*sqrt(T*coef.M)/(coef.sigma^2*Omega);
              eta := ya*
                Modelica.Media.Air.RealGasAir.Air_Utilities.Transport.eta_dT(da,
                T) + yd*etad;
            else
              dd :=
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.rho_pT(pd,
                T);
              df := Modelica.Media.Water.IF97_Utilities.rho_pT(p, T);
              yf := (xw - xws)/df/((1 + xws)/(da + dd) + (xw - xws)/df);
              ya := (1 - yf)/(1 + dd/da);
              yd := 1 - (ya + yf);
              eta := ya*
                Modelica.Media.Air.RealGasAir.Air_Utilities.Transport.eta_dT(da,
                T) + yd*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.visc_dT(
                dd, T) + yf*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.visc_dT(
                df, T);
            end if;
          end if;
        end eta_pTX;

        function lambda_pTX "Thermal conductivity"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure p "Pressure";
          input Modelica.SIunits.Temperature T "Temperature";
          input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
            "Mass fractions";
          output Modelica.SIunits.ThermalConductivity lambda
            "Thermal conductivity";

        protected
          Real ya;
          Real yd;
          Real yf;
          Real va;
          Real vd;
          Real vf;
          Real xw;
          Real xws;
          Real pd;
          Real pl;
          Real da;
          Real dd;
          Real df;
          Real Omega;
          Real Tred;
          Real cp;
          Real Eu;
          Real lambdad;
          Modelica.Media.Air.RealGasMoistAir.Utilities.Transport.coef coef;

        algorithm
          xw := X[1]/(1 - X[1]);
          xws := Modelica.Media.Air.RealGasMoistAir.Utilities.xws_pT(p, T);
          pd := Modelica.Media.Air.RealGasMoistAir.Utilities.pd_pTX(
                    p,
                    T,
                    X);
          pl := p - pd;
          da := Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT(pl, T);
          if ((xw <= xws) or (xws == -1)) then
            if (T < 273.16) then
              dd := pd/(Modelica.Media.Air.RealGasMoistAir.steam.R*T);
              ya := da/(da + dd);
              yd := 1 - ya;
              Tred := T/coef.epsilon;
              Omega := coef.w[1] + coef.w[2]*Tred + coef.w[3]*Modelica.Math.exp(
                coef.w[4]*Tred)/(coef.w[5] + Tred);
              cp := coef.a[1] + coef.a[2]*T + coef.a[3]*T^2 + coef.a[4]*T^3 +
                coef.a[5]*T^4;
              Eu := 0.35424*cp + 0.1144;
              Eu := 0;
              lambdad := 0.083232*sqrt(T/coef.M)/(coef.sigma^2*Omega)*Eu;
              lambda := ya*
                Modelica.Media.Air.RealGasAir.Air_Utilities.Transport.lambda_dT(
                da, T) + yd*lambdad;
            else
              dd :=
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.rho_pT(pd,
                T);
              ya := da/(da + dd);
              yd := 1 - ya;
              lambda := ya*
                Modelica.Media.Air.RealGasAir.Air_Utilities.Transport.lambda_dT(
                da, T) + yd*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.cond_dT(
                dd, T);
            end if;
          else
            if (T < 273.16) then
              dd := pd/(Modelica.Media.Air.RealGasMoistAir.steam.R*T);
              df := Modelica.Media.Water.IAPWS09.Ice09_Utilities.rho_pT(p, T);
              yf := (xw - xws)/df/((1 + xws)/(da + dd) + (xw - xws)/df);
              ya := (1 - yf)/(1 + dd/da);
              yd := 1 - (ya + yf);
              Tred := T/coef.epsilon;
              Omega := coef.w[1] + coef.w[2]*Tred + coef.w[3]*Modelica.Math.exp(
                coef.w[4]*Tred)/(coef.w[5] + Tred);
              cp := coef.a[1] + coef.a[2]*T + coef.a[3]*T^2 + coef.a[4]*T^3 +
                coef.a[5]*T^4;
              Eu := 0.35424*cp + 0.1144;
              lambdad := 0.083232*sqrt(T/coef.M)/(coef.sigma^2*Omega)*Eu;
              lambda := ya*
                Modelica.Media.Air.RealGasAir.Air_Utilities.Transport.lambda_dT(
                da, T) + yd*lambdad + yf*2.21;
            else
              dd :=
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.rho_pT(pd,
                T);
              df := Modelica.Media.Water.IF97_Utilities.rho_pT(p, T);
              yf := (xw - xws)/df/((1 + xws)/(da + dd) + (xw - xws)/df);
              ya := (1 - yf)/(1 + dd/da);
              yd := 1 - (ya + yf);
              lambda := ya*
                Modelica.Media.Air.RealGasAir.Air_Utilities.Transport.lambda_dT(
                da, T) + yd*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.cond_dT(
                dd, T) + yf*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.cond_dT(
                df, T);
            end if;
          end if;
        end lambda_pTX;
      end Transport;

      package VirialCoefficients
        "Virial and cross-virial coefficients of air and water"
        extends Modelica.Icons.BasesPackage;

        function Baa_dT "second molar virial coefficient of dry air"
          extends Modelica.Icons.Function;

          input Modelica.SIunits.Density d "Density";
          input Modelica.SIunits.Temperature T "Temperature";
          output Modelica.SIunits.MolarVolume baa "second virial coefficient";

        protected
          final constant Real[19] N={0.118160747229,0.713116392079,-0.161824192067E+001,
              0.714140178971E-001,-0.865421396646E-001,0.134211176704,
              0.112626704218E-001,-0.420533228842E-001,0.349008431982E-001,
              0.164957183186E-003,-0.101365037912,-0.173813690970,-0.472103183731E-001,
              -0.122523554253E-001,-0.146629609713,-0.316055879821E-001,
              0.233594806142E-003,0.148287891978E-001,-0.938782884667E-002};
          final constant Integer[19] i={1,1,1,2,3,3,4,4,4,6,1,3,5,6,1,3,11,1,3};
          final constant Real[19] j={0,0.33,1.01,0,0,0.15,0,0.2,0.35,1.35,1.6,
              0.8,0.95,1.25,3.6,6,3.25,3.5,15};
          Real tau=Modelica.Media.Air.RealGasAir.Air_Utilities.Basic.Constants.Tred
              /T;

        algorithm
          baa := 0;
          for k in 1:19 loop
            baa := if (i[k] == 1) then baa + N[k]*tau^j[k] else baa;
          end for;
          baa := 1/Modelica.Media.Air.RealGasAir.Air_Utilities.Basic.Constants.rhored
            *baa;

        end Baa_dT;

        function Baw_dT "second molar cross-virial coefficient"
          extends Modelica.Icons.Function;

          input Modelica.SIunits.Density d "Density";
          input Modelica.SIunits.Temperature T "Temperature";
          output Modelica.SIunits.MolarVolume baw
            "second cross-virial coefficient";

        protected
          final constant Real[3] a={0.665687E+002,-0.238834E+003,-0.176755E+003};
          final constant Real[3] b={-0.237,-1.048,-3.183};

          Real theta;

        algorithm
          baw := 0;
          theta := T/100;
          for k in 1:3 loop
            baw := baw + a[k]*theta^b[k];
          end for;
          baw := baw*1E-006;
        end Baw_dT;

        function Bww_dT "second molar virial coefficient of water"
          extends Modelica.Icons.Function;

          input Modelica.SIunits.Density d "Density";
          input Modelica.SIunits.Temperature T "Temperature";
          output Modelica.SIunits.MolarVolume bww "second virial coefficient";

        protected
          final constant Real[56] N={0.12533547935523E-001,
              0.78957634722828E+001,-0.87803203303561E+001,0.31802509345418,-0.26145533859358,
              -0.78199751687981E-002,0.88089493102134E-002,-0.66856572307965,
              0.20433810950965,-0.66212605039687E-004,-0.19232721156002,-0.25709043003438,
              0.16074868486251,-0.40092828925807E-001,0.39343422603254E-006,-0.75941377088144E-005,
              0.56250979351888E-003,-0.15608652257135E-004,
              0.11537996422951E-008,0.36582165144204E-006,-0.13251180074668E-011,
              -0.62639586912454E-009,-0.10793600908932,0.17611491008752E-001,
              0.22132295167546,-0.40247669763528,0.58083399985759,
              0.49969146990806E-002,-0.31358700712549E-001,-0.74315929710341,
              0.4780732991548,0.20527940895948E-001,-0.13636435110343,
              0.14180634400617E-001,0.83326504880713E-002,-0.29052336009585E-001,
              0.38615085574206E-001,-0.20393486513704E-001,-0.16554050063734E-002,
              0.19955571979541E-002,0.15870308324157E-003,-0.1638856834253E-004,
              0.43613615723811E-001,0.34994005463765E-001,-0.76788197844621E-001,
              0.22446277332006E-001,-0.62689710414685E-004,-0.55711118565645E-009,
              -0.19905718354408,0.31777497330738,-0.11841182425981,-0.31306260323435E+002,
              0.31546140237781E+002,-0.25213154341695E+004,-0.14874640856724,
              0.31806110878444};
          final constant Integer[51] c={0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,
              1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,3,3,4,6,6,6,6};
          final constant Integer[54] dd={1,1,1,2,2,3,4,1,1,1,2,2,3,4,4,5,7,9,10,
              11,13,15,1,2,2,2,3,4,4,4,5,6,6,7,9,9,9,9,9,10,10,12,3,4,4,5,14,3,
              6,6,6,3,3,3};
          final constant Real[54] t={-0.5,0.875,1.0,0.5,0.75,0.375,1.0,4.0,6.0,
              12.0,1.0,5.0,4.0,2.0,13.0,9.0,3.0,4.0,11.0,4.0,13.0,1.0,7.0,1.0,
              9.0,10.0,10.0,3.0,7.0,10.0,10.0,6.0,10.0,10.0,1.0,2.0,3.0,4.0,8.0,
              6.0,9.0,8.0,16.0,22.0,23.0,23.0,10.0,50.0,44.0,46.0,50.0,0.0,1.0,
              4.0};
          final constant Integer[54] alpha={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              20,20,20};
          final constant Real[56] beta={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,150,150,250,0.3,0.3};
          final constant Real[54] gamma={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.21,1.21,1.25};
          final constant Integer[54] epsilon={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,1,1,1};
          final constant Real[56] a={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,3.5,3.5};
          final constant Real[56] b={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.85,0.95};
          final constant Real[56] AA={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.32,0.32};
          final constant Real[56] BB={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.2};
          final constant Integer[56] CC={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,28,32};
          final constant Integer[56] DD={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,700,800};

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

          Real tau=Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Constants.Tred
              /T;

        algorithm
          bww := 0;
          theta55 := (1 - tau) + AA[55];
          theta56 := (1 - tau) + AA[56];
          psi55 := exp(-CC[55] - DD[55]*(tau - 1)^2);
          psi56 := exp(-CC[56] - DD[56]*(tau - 1)^2);
          Delta55 := theta55^2 + BB[55];
          Delta56 := theta56^2 + BB[56];
          Delta55delta := -(AA[55]*theta55*2/beta[55] + 2*BB[55]*a[55]);
          Delta56delta := -(AA[56]*theta56*2/beta[56] + 2*BB[56]*a[56]);
          Deltab55delta := b[55]*Delta55^(b[55] - 1)*Delta55delta;
          Deltab56delta := b[56]*Delta56^(b[56] - 1)*Delta56delta;
          psi55delta := 2*CC[55]*psi55;
          psi56delta := 2*CC[56]*psi56;

          for k in 1:7 loop
            bww := if (dd[k] == 1) then bww + N[k]*tau^t[k] else bww;
          end for;
          for k in 8:51 loop
            bww := if (dd[k] == 1) then bww + N[k]*tau^t[k]*dd[k] else bww;
          end for;
          for k in 52:54 loop
            bww := if (dd[k] == 1) then bww + N[k]*tau^t[k]*exp(-alpha[k]*
              epsilon[k]^2 - beta[k]*(tau - gamma[k])^2) else bww;
          end for;
          bww := (bww + N[55]*Delta55^b[55]*psi55 + N[56]*Delta56^b[56]*psi56)/
            Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Constants.rhored
            *Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Constants.MM;
        end Bww_dT;

        function Caaa_dT "third molar virial coefficient of dry air"
          extends Modelica.Icons.Function;

          input Modelica.SIunits.Density d "Density";
          input Modelica.SIunits.Temperature T "Temperature";
          output Modelica.SIunits.MolarVolume caaa "third virial coefficient";

        protected
          final constant Real[19] N={0.118160747229,0.713116392079,-0.161824192067E+001,
              0.714140178971E-001,-0.865421396646E-001,0.134211176704,
              0.112626704218E-001,-0.420533228842E-001,0.349008431982E-001,
              0.164957183186E-003,-0.101365037912,-0.173813690970,-0.472103183731E-001,
              -0.122523554253E-001,-0.146629609713,-0.316055879821E-001,
              0.233594806142E-003,0.148287891978E-001,-0.938782884667E-002};
          final constant Integer[19] i={1,1,1,2,3,3,4,4,4,6,1,3,5,6,1,3,11,1,3};
          final constant Real[19] j={0,0.33,1.01,0,0,0.15,0,0.2,0.35,1.35,1.6,
              0.8,0.95,1.25,3.6,6,3.25,3.5,15};
          final constant Integer[19] l={0,0,0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,3,3};
          Real tau=Modelica.Media.Air.RealGasAir.Air_Utilities.Basic.Constants.Tred
              /T;

        algorithm
          caaa := 0;
          for k in 1:10 loop
            caaa := if (i[k] == 2) then caaa + 2*N[k]*tau^j[k] else caaa;
          end for;
          for k in 11:19 loop
            caaa := if (i[k] == 2) then caaa + 2*N[k]*tau^j[k] elseif ((i[k]
               == 1) and (l[k] == 1)) then caaa - 2*N[k]*tau^j[k] else caaa;
          end for;
          caaa := 1/Modelica.Media.Air.RealGasAir.Air_Utilities.Basic.Constants.rhored
            ^2*caaa;
        end Caaa_dT;

        function Caaw_dT "third molar cross-virial coefficient"
          extends Modelica.Icons.Function;

          input Modelica.SIunits.Density d "Density";
          input Modelica.SIunits.Temperature T "Temperature";
          output Real caaw "third cross-virial coefficient";

        protected
          final constant Real[5] c={0.482737E+003,0.105678E+006,-0.656394E+008,
              0.294442E+011,-0.319317E+013};

          Real theta=T;

        algorithm
          caaw := 0;
          for k in 1:5 loop
            caaw := caaw + c[k]*theta^(1 - k);
          end for;
          caaw := caaw*1E-012;

        end Caaw_dT;

        function Caww_dT "third molar cross-virial coefficient"
          extends Modelica.Icons.Function;

          input Modelica.SIunits.Density d "Density";
          input Modelica.SIunits.Temperature T "Temperature";
          output Real caww "third cross-virial coefficient";

        protected
          final constant Real[4] dd={-0.1072887E+002,0.347804E+004,-0.383383E+006,
              0.33406E+008};

          Real theta=T;

        algorithm
          caww := 0;
          for k in 1:4 loop
            caww := caww + dd[k]*theta^(1 - k);
          end for;
          caww := -exp(caww)*1E-012;

        end Caww_dT;

        function Cwww_dT "third molar virial coefficient of water"
          extends Modelica.Icons.Function;

          input Modelica.SIunits.Density d "Density";
          input Modelica.SIunits.Temperature T "Temperature";
          output Modelica.SIunits.MolarVolume cwww "third virial coefficient";

        protected
          final constant Real[56] N={0.12533547935523E-001,
              0.78957634722828E+001,-0.87803203303561E+001,0.31802509345418,-0.26145533859358,
              -0.78199751687981E-002,0.88089493102134E-002,-0.66856572307965,
              0.20433810950965,-0.66212605039687E-004,-0.19232721156002,-0.25709043003438,
              0.16074868486251,-0.40092828925807E-001,0.39343422603254E-006,-0.75941377088144E-005,
              0.56250979351888E-003,-0.15608652257135E-004,
              0.11537996422951E-008,0.36582165144204E-006,-0.13251180074668E-011,
              -0.62639586912454E-009,-0.10793600908932,0.17611491008752E-001,
              0.22132295167546,-0.40247669763528,0.58083399985759,
              0.49969146990806E-002,-0.31358700712549E-001,-0.74315929710341,
              0.4780732991548,0.20527940895948E-001,-0.13636435110343,
              0.14180634400617E-001,0.83326504880713E-002,-0.29052336009585E-001,
              0.38615085574206E-001,-0.20393486513704E-001,-0.16554050063734E-002,
              0.19955571979541E-002,0.15870308324157E-003,-0.1638856834253E-004,
              0.43613615723811E-001,0.34994005463765E-001,-0.76788197844621E-001,
              0.22446277332006E-001,-0.62689710414685E-004,-0.55711118565645E-009,
              -0.19905718354408,0.31777497330738,-0.11841182425981,-0.31306260323435E+002,
              0.31546140237781E+002,-0.25213154341695E+004,-0.14874640856724,
              0.31806110878444};
          final constant Integer[51] c={0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,
              1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,3,3,4,6,6,6,6};
          final constant Integer[54] dd={1,1,1,2,2,3,4,1,1,1,2,2,3,4,4,5,7,9,10,
              11,13,15,1,2,2,2,3,4,4,4,5,6,6,7,9,9,9,9,9,10,10,12,3,4,4,5,14,3,
              6,6,6,3,3,3};
          final constant Real[54] t={-0.5,0.875,1.0,0.5,0.75,0.375,1.0,4.0,6.0,
              12.0,1.0,5.0,4.0,2.0,13.0,9.0,3.0,4.0,11.0,4.0,13.0,1.0,7.0,1.0,
              9.0,10.0,10.0,3.0,7.0,10.0,10.0,6.0,10.0,10.0,1.0,2.0,3.0,4.0,8.0,
              6.0,9.0,8.0,16.0,22.0,23.0,23.0,10.0,50.0,44.0,46.0,50.0,0.0,1.0,
              4.0};
          final constant Integer[54] alpha={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              20,20,20};
          final constant Real[56] beta={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,150,150,250,0.3,0.3};
          final constant Real[54] gamma={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.21,1.21,1.25};
          final constant Integer[54] epsilon={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,1,1,1};
          final constant Real[56] a={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,3.5,3.5};
          final constant Real[56] b={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.85,0.95};
          final constant Real[56] AA={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.32,0.32};
          final constant Real[56] BB={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
              0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.2};
          final constant Integer[56] CC={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,28,32};
          final constant Integer[56] DD={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,700,800};

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
          Real Delta55deltadelta=0;
          Real Delta56deltadelta=0;
          Real Deltab55deltadelta=0;
          Real Deltab56deltadelta=0;
          Real psi55deltadelta=0;
          Real psi56deltadelta=0;

          Real tau=Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Constants.Tred
              /T;

        algorithm
          cwww := 0;
          theta55 := (1 - tau) + AA[55];
          theta56 := (1 - tau) + AA[56];
          psi55 := exp(-CC[55] - DD[55]*(tau - 1)^2);
          psi56 := exp(-CC[56] - DD[56]*(tau - 1)^2);
          Delta55 := theta55^2 + BB[55];
          Delta56 := theta56^2 + BB[56];
          Delta55delta := -(AA[55]*theta55*2/beta[55] + 2*BB[55]*a[55]);
          Delta56delta := -(AA[56]*theta56*2/beta[56] + 2*BB[56]*a[56]);
          Deltab55delta := b[55]*Delta55^(b[55] - 1)*Delta55delta;
          Deltab56delta := b[56]*Delta56^(b[56] - 1)*Delta56delta;
          psi55delta := 2*CC[55]*psi55;
          psi56delta := 2*CC[56]*psi56;
          Delta55deltadelta := -Delta55delta + AA[55]^2*2/beta[55]^2 + AA[55]*
            theta55*4/beta[55]*(1/(2*beta[55]) - 1) + 4*BB[55]*a[55]*(a[55] - 1);
          Delta56deltadelta := -Delta56delta + AA[56]^2*2/beta[56]^2 + AA[56]*
            theta56*4/beta[56]*(1/(2*beta[56]) - 1) + 4*BB[56]*a[56]*(a[56] - 1);
          Deltab55deltadelta := b[55]*(Delta55^(b[55] - 1)*Delta55deltadelta +
            (b[55] - 1)*Delta55^(b[55] - 2)*Delta55delta^2);
          Deltab56deltadelta := b[56]*(Delta56^(b[56] - 1)*Delta56deltadelta +
            (b[56] - 1)*Delta56^(b[56] - 2)*Delta56delta^2);
          psi55deltadelta := (2*CC[55] - 1)*2*CC[55]*psi55;
          psi56deltadelta := (2*CC[56] - 1)*2*CC[56]*psi56;

          cwww := 0;
          for k in 1:7 loop
            cwww := if (dd[k] == 2) then cwww + 2*N[k]*tau^t[k] else cwww;
          end for;
          for k in 8:51 loop
            cwww := if (dd[k] == 2) then cwww + 2*N[k]*tau^t[k] elseif ((dd[k]
               == 1) and (c[k] == 1)) then cwww - 2*N[k]*tau^t[k] else cwww;
          end for;
          cwww := cwww + N[55]*(Delta55^b[55]*2*psi55delta + 2*Deltab55delta*
            psi55) + N[56]*(Delta56^b[56]*2*psi56delta + 2*Deltab56delta*psi56);
          cwww := Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Constants.MM
            ^2/Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Constants.rhored
            ^2*cwww*1E-006;
        end Cwww_dT;
      end VirialCoefficients;

      package ReactionIndices
        "Parameters and equations for determining reaction variables (dissociation VDI 4670)"
        extends Modelica.Icons.BasesPackage;

        final constant Real[6] AA={20413.2,1075.5,165.95,1491.75,3235.34,4.5542};
        final constant Modelica.SIunits.Temperature[6] BB={-33086.5,-30283.3,-19526.8,
            -27488.0,-30807.8,-10973.6};
        final constant Modelica.SIunits.MolarHeatCapacity[6] CC={-19.5,-65.2,-18.7,
            -3.6,-21.8,-5.6};
        final constant Modelica.SIunits.MolarInternalEnergy[6] DD={-1.15E+005,
            3.03E+005,5.72E+004,3.93E+005,1.5E+005,1.62E+004};
        final constant Real[6] EE(each unit="J.K/mol") = {9.483E+009,7.277E+009,
          3.136E+009,5.826E+009,7.659E+009,9.94E+008};
        final constant Modelica.SIunits.AbsolutePressure p0=101325
          "reference pressure";

        function U2 "Reaction index for formation of H2"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature";
          input Modelica.SIunits.MoleFraction[4] moleFraction "mole fractions";
          output Real u "reaction index for H2";
        algorithm
          u := AA[2]*moleFraction[1]/sqrt(moleFraction[3])*(p/p0)^(-0.5)*
            Modelica.Math.exp(BB[2]/T);
          annotation (
            derivative=U2_der,
            Inline=false,
            LateInline=true);
        end U2;

        function U3 "Reaction index for formation of OH"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature";
          input Modelica.SIunits.MoleFraction[4] moleFraction "mole fractions";
          output Real u "reaction index for OH";
        algorithm
          u := AA[3]*sqrt(moleFraction[1])*sqrt(sqrt(moleFraction[3]))*(p/p0)^(
            -0.25)*Modelica.Math.exp(BB[3]/T);
          annotation (
            derivative=U3_der,
            Inline=false,
            LateInline=true);
        end U3;

        function U4 "Reaction index for formation of H"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature";
          input Modelica.SIunits.MoleFraction[4] moleFraction "mole fractions";
          output Real u "reaction index for H";
        algorithm
          u := AA[4]*sqrt(U2(
                    p,
                    T,
                    moleFraction))*(p/p0)^(-0.5)*Modelica.Math.exp(BB[4]/T);
          annotation (
            derivative=U4_der,
            Inline=false,
            LateInline=true);
        end U4;

        function U5 "Reaction index for formation of O"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature";
          input Modelica.SIunits.MoleFraction[4] moleFraction "mole fractions";
          output Real u "reaction index for O";
        algorithm
          u := AA[5]*sqrt(moleFraction[3])*(p/p0)^(-0.5)*Modelica.Math.exp(BB[5]
            /T);
          annotation (
            derivative=U5_der,
            Inline=false,
            LateInline=true);
        end U5;

        function U6 "Reaction index for formation of NO"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature";
          input Modelica.SIunits.MoleFraction[4] moleFraction "mole fractions";
          output Real u "reaction index for NO";
        algorithm
          u := AA[6]*sqrt(moleFraction[2]*moleFraction[3])*Modelica.Math.exp(BB[
            6]/T);
          annotation (
            derivative=U6_der,
            Inline=false,
            LateInline=true);
        end U6;

        function V2 "Energy index for formation of H2"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Temperature T "temperature";
          output Modelica.SIunits.MolarHeatCapacity v "energy index for H2";
        algorithm
          v := CC[2] + DD[2]/T + EE[2]/T^2;
          annotation (
            derivative=V2_der,
            Inline=false,
            LateInline=true);
        end V2;

        function V3 "Energy index for formation of OH"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Temperature T "temperature";
          output Modelica.SIunits.MolarHeatCapacity v "energy index for OH";
        algorithm
          v := CC[3] + DD[3]/T + EE[3]/T^2;
          annotation (
            derivative=V3_der,
            Inline=false,
            LateInline=true);
        end V3;

        function V4 "Energy index for formation of H"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Temperature T "temperature";
          output Modelica.SIunits.MolarHeatCapacity v "energy index for H";
        algorithm
          v := CC[4] + DD[4]/T + EE[4]/T^2;
          annotation (
            derivative=V4_der,
            Inline=false,
            LateInline=true);
        end V4;

        function V5 "Energy index for formation of O"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Temperature T "temperature";
          output Modelica.SIunits.MolarHeatCapacity v "energy index for O";
        algorithm
          v := CC[5] + DD[5]/T + EE[5]/T^2;
          annotation (
            derivative=V5_der,
            Inline=false,
            LateInline=true);
        end V5;

        function V6 "Energy index for formation of NO"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Temperature T "temperature";
          output Modelica.SIunits.MolarHeatCapacity v "energy index for NO";
        algorithm
          v := CC[6] + DD[6]/T + EE[6]/T^2;
          annotation (
            derivative=V6_der,
            Inline=false,
            LateInline=true);
        end V6;

        function U2_der "Derivative reaction index for formation of H2"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature";
          input Modelica.SIunits.MoleFraction[4] moleFraction "mole fractions";
          input Real p_der "Derivative of pressure";
          input Real T_der "Derivative of temperature";
          input Real[4] moleFraction_der "Derivative of mole fractions";
          output Real u_der "Derivative of reaction index for H2";

        protected
          Real o[4];
        algorithm
          o[1] := AA[2]*sqrt(moleFraction[3])*(p/p0)^(-0.5)*Modelica.Math.exp(
            BB[2]/T);
          o[2] := -0.5*AA[2]*moleFraction[1]/(moleFraction[3])^1.5*(p/p0)^(-0.5)
            *Modelica.Math.exp(BB[2]/T);
          o[3] := -0.5*AA[2]*moleFraction[1]/sqrt(moleFraction[3])*sqrt(p0)*p^(
            -1.5)*Modelica.Math.exp(BB[2]/T);
          o[4] := -BB[2]*AA[2]*moleFraction[1]/sqrt(moleFraction[3])*(p/p0)^(-0.5)
            *Modelica.Math.exp(BB[2]/T)/T^2;
          u_der := o[1]*moleFraction_der[1] + o[2]*moleFraction_der[3] + o[3]*
            p_der + o[4]*T_der;

        end U2_der;

        function U3_der "Derivative of reaction index for formation of OH"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature";
          input Modelica.SIunits.MoleFraction[4] moleFraction "mole fractions";
          input Real p_der "Derivative of pressure";
          input Real T_der "Derivative of temperature";
          input Real[4] moleFraction_der "Derivative of mole fractions";
          output Real u_der "Derivative of reaction index for OH";
        protected
          Real o[4];
        algorithm
          o[1] := 0.5*AA[3]/sqrt(moleFraction[1])*sqrt(sqrt(moleFraction[3]))*(
            p/p0)^(-0.25)*Modelica.Math.exp(BB[3]/T);
          o[2] := 0.25*AA[3]*sqrt(moleFraction[1])/(moleFraction[3])^0.75*(p/p0)
            ^(-0.25)*Modelica.Math.exp(BB[3]/T);
          o[3] := -0.25*AA[3]*sqrt(moleFraction[1])*sqrt(sqrt(moleFraction[3]))
            *sqrt(sqrt(p0))*p^(-1.25)*Modelica.Math.exp(BB[3]/T);
          o[4] := BB[3]*AA[3]*moleFraction[1]/sqrt(sqrt(moleFraction[3]))*(p/p0)
            ^(-0.25)*Modelica.Math.exp(BB[3]/T)/T^2;
          u_der := o[1]*moleFraction_der[1] + o[2]*moleFraction_der[3] + o[3]*
            p_der + o[4]*T_der;

        end U3_der;

        function U4_der "Derivative of reaction index for formation of H"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature";
          input Modelica.SIunits.MoleFraction[4] moleFraction "mole fractions";
          input Real p_der "Derivative of pressure";
          input Real T_der "Derivative of temperature";
          input Real[4] moleFraction_der "Derivative of mole fractions";
          output Real u_der "Derivative of reaction index for H";
        protected
          Real o[3];
        algorithm
          o[1] := 0.5*AA[4]/sqrt(U2(
                    p,
                    T,
                    moleFraction))*U2_der(
                    p,
                    T,
                    moleFraction,
                    p_der,
                    T_der,
                    moleFraction_der)*(p/p0)^(-0.5)*Modelica.Math.exp(BB[4]/T);
          o[2] := -0.5*AA[4]*sqrt(U2(
                    p,
                    T,
                    moleFraction))*sqrt(p0)*p^(-1.5)*Modelica.Math.exp(BB[4]/T);
          o[3] := BB[4]*AA[4]*sqrt(U2(
                    p,
                    T,
                    moleFraction))*(p/p0)^(-0.5)*Modelica.Math.exp(BB[4]/T)/T^2;
          u_der := o[1] + o[2]*p_der + o[3]*T_der;

        end U4_der;

        function U5_der "Derivative of reaction index for formation of O"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature";
          input Modelica.SIunits.MoleFraction[4] moleFraction "mole fractions";
          input Real p_der "Derivative of pressure";
          input Real T_der "Derivative of temperature";
          input Real[4] moleFraction_der "Derivative of mole fractions";
          output Real u_der "Derivative of reaction index for O";
        protected
          Real o[3];
        algorithm
          o[1] := 0.5*AA[5]/sqrt(moleFraction[3])*(p/p0)^(-0.5)*
            Modelica.Math.exp(BB[5]/T);
          o[2] := -0.5*AA[5]*sqrt(moleFraction[3])*sqrt(p0)*p^(-1.5)*
            Modelica.Math.exp(BB[5]/T);
          o[3] := BB[5]*AA[5]*sqrt(moleFraction[3])*(p/p0)^(-0.5)*
            Modelica.Math.exp(BB[5]/T)/T^2;
          u_der := o[1]*moleFraction[3] + o[2]*p_der + o[3]*T_der;
        end U5_der;

        function U6_der "Derivative of reaction index for formation of NO"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature";
          input Modelica.SIunits.MoleFraction[4] moleFraction "mole fractions";
          input Real p_der "Derivative of pressure";
          input Real T_der "Derivative of temperature";
          input Real[4] moleFraction_der "Derivative of mole fractions";
          output Real u_der "Derivative of reaction index for NO";
        protected
          Real o[3];
        algorithm
          o[1] := 0.5*AA[6]/sqrt(moleFraction[2]*moleFraction[3])*moleFraction[
            3]*Modelica.Math.exp(BB[6]/T);
          o[2] := 0.5*AA[6]/sqrt(moleFraction[2]*moleFraction[3])*moleFraction[
            2]*Modelica.Math.exp(BB[6]/T);
          o[3] := BB[6]*AA[6]*sqrt(moleFraction[2]*moleFraction[3])*
            Modelica.Math.exp(BB[6]/T)/T^2;
          u_der := o[1]*moleFraction[2] + o[2]*moleFraction[3] + o[3]*T_der;
        end U6_der;

        function V2_der "Derivative of energy index for formation of H2"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Temperature T "temperature";
          input Real T_der "Derivative of temperature";
          output Real v_der "Derivative energy index for H2";
        algorithm
          v_der := (-DD[2]/T^2 - 2*EE[2]/T^3)*T_der;

        end V2_der;

        function V3_der "Derivative energy index for formation of OH"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Temperature T "temperature";
          input Real T_der "Derivative of temperature";
          output Real v_der "Derivative energy index for OH";
        algorithm
          v_der := (-DD[3]/T^2 - 2*EE[3]/T^3)*T_der;
        end V3_der;

        function V4_der "Derivative of energy index for formation of H"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Temperature T "temperature";
          input Real T_der "Derivative of temperature";
          output Real v_der "Derivative energy index for H";

        algorithm
          v_der := (-DD[4]/T^2 - 2*EE[4]/T^3)*T_der;
        end V4_der;

        function V5_der "Derivative of energy index for formation of O"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Temperature T "temperature";
          input Real T_der "Derivative of temperature";
          output Real v_der "Derivative energy index for O";
        algorithm
          v_der := (-DD[5]/T^2 - 2*EE[5]/T^3)*T_der;
        end V5_der;

        function V6_der "Derivative of energy index for formation of NO"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Temperature T "temperature";
          input Real T_der "Derivative of temperature";
          output Real v_der "Derivative energy index for NO";
        algorithm
          v_der := (-DD[6]/T^2 - 2*EE[6]/T^3)*T_der;
        end V6_der;
      end ReactionIndices;

      package IF97_new "workaround for IF97"
        extends Modelica.Icons.BasesPackage;

        final constant MolarMass molarMass=0.018015257;

        function g2 "Gibbs function for region 2: g(p,T)"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Pressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature (K)";
          output Modelica.Media.Common.GibbsDerivs g
            "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
        protected
          Real tau2 "dimensionless temperature";
          Real[55] o "vector of auxiliary variables";
        algorithm
          g.p := p;
          g.T := T;
          g.R := Modelica.Media.Water.IF97_Utilities.BaseIF97.data.RH2O;
          g.pi := p/Modelica.Media.Water.IF97_Utilities.BaseIF97.data.PSTAR2;
          g.tau := Modelica.Media.Water.IF97_Utilities.BaseIF97.data.TSTAR2/T;
          tau2 := -0.5 + g.tau;
          o[1] := tau2*tau2;
          o[2] := o[1]*tau2;
          o[3] := -0.050325278727930*o[2];
          o[4] := -0.057581259083432 + o[3];
          o[5] := o[4]*tau2;
          o[6] := -0.045996013696365 + o[5];
          o[7] := o[6]*tau2;
          o[8] := -0.0178348622923580 + o[7];
          o[9] := o[8]*tau2;
          o[10] := o[1]*o[1];
          o[11] := o[10]*o[10];
          o[12] := o[11]*o[11];
          o[13] := o[10]*o[11]*o[12]*tau2;
          o[14] := o[1]*o[10]*tau2;
          o[15] := o[10]*o[11]*tau2;
          o[16] := o[1]*o[12]*tau2;
          o[17] := o[1]*o[11]*tau2;
          o[18] := o[1]*o[10]*o[11];
          o[19] := o[10]*o[11]*o[12];
          o[20] := o[1]*o[10];
          o[21] := g.pi*g.pi;
          o[22] := o[21]*o[21];
          o[23] := o[21]*o[22];
          o[24] := o[10]*o[12]*tau2;
          o[25] := o[12]*o[12];
          o[26] := o[11]*o[12]*o[25]*tau2;
          o[27] := o[10]*o[12];
          o[28] := o[1]*o[10]*o[11]*tau2;
          o[29] := o[10]*o[12]*o[25]*tau2;
          o[30] := o[1]*o[10]*o[25]*tau2;
          o[31] := o[1]*o[11]*o[12];
          o[32] := o[1]*o[12];
          o[33] := g.tau*g.tau;
          o[34] := o[33]*o[33];
          o[35] := -0.000053349095828174*o[13];
          o[36] := -0.087594591301146 + o[35];
          o[37] := o[2]*o[36];
          o[38] := -0.0078785554486710 + o[37];
          o[39] := o[1]*o[38];
          o[40] := -0.00037897975032630 + o[39];
          o[41] := o[40]*tau2;
          o[42] := -0.000066065283340406 + o[41];
          o[43] := o[42]*tau2;
          o[44] := 5.7870447262208e-6*tau2;
          o[45] := -0.301951672367580*o[2];
          o[46] := -0.172743777250296 + o[45];
          o[47] := o[46]*tau2;
          o[48] := -0.091992027392730 + o[47];
          o[49] := o[48]*tau2;
          o[50] := o[1]*o[11];
          o[51] := o[10]*o[11];
          o[52] := o[11]*o[12]*o[25];
          o[53] := o[10]*o[12]*o[25];
          o[54] := o[1]*o[10]*o[25];
          o[55] := o[11]*o[12]*tau2;

          g.g := g.pi*(-0.00177317424732130 + o[9] + g.pi*(tau2*(-0.000033032641670203
             + (-0.000189489875163150 + o[1]*(-0.0039392777243355 + (-0.043797295650573
             - 0.0000266745479140870*o[13])*o[2]))*tau2) + g.pi*(
            2.04817376923090e-8 + (4.3870667284435e-7 + o[1]*(-0.000032277677238570
             + (-0.00150339245421480 - 0.040668253562649*o[13])*o[2]))*tau2 + g.pi
            *(g.pi*(2.29220763376610e-6*o[14] + g.pi*((-1.67147664510610e-11 +
            o[15]*(-0.00211714723213550 - 23.8957419341040*o[16]))*o[2] + g.pi*
            (-5.9059564324270e-18 + o[17]*(-1.26218088991010e-6 -
            0.038946842435739*o[18]) + g.pi*(o[11]*(1.12562113604590e-11 -
            8.2311340897998*o[19]) + g.pi*(1.98097128020880e-8*o[15] + g.pi*(o[
            10]*(1.04069652101740e-19 + (-1.02347470959290e-13 -
            1.00181793795110e-9*o[10])*o[20]) + o[23]*(o[13]*(-8.0882908646985e-11
             + 0.106930318794090*o[24]) + o[21]*(-0.33662250574171*o[26] + o[21]
            *(o[27]*(8.9185845355421e-25 + (3.06293168762320e-13 -
            4.2002467698208e-6*o[15])*o[28]) + g.pi*(-5.9056029685639e-26*o[24]
             + g.pi*(3.7826947613457e-6*o[29] + g.pi*(-1.27686089346810e-15*o[
            30] + o[31]*(7.3087610595061e-29 + o[18]*(5.5414715350778e-17 -
            9.4369707241210e-7*o[32]))*g.pi)))))))))))) + tau2*(-7.8847309559367e-10
             + (1.27907178522850e-8 + 4.8225372718507e-7*tau2)*tau2))))) + (-0.0056087911830200
             + g.tau*(0.071452738814550 + g.tau*(-0.40710498239280 + g.tau*(
            1.42408197144400 + g.tau*(-4.3839511194500 + g.tau*(-9.6927686002170
             + g.tau*(10.0866556801800 + (-0.284086326077200 +
            0.0212684635330700*g.tau)*g.tau) + Modelica.Math.log(g.pi)))))))/(o[
            34]*g.tau);

          g.gpi := (1.00000000000000 + g.pi*(-0.00177317424732130 + o[9] + g.pi
            *(o[43] + g.pi*(6.1445213076927e-8 + (1.31612001853305e-6 + o[1]*(-0.000096833031715710
             + (-0.0045101773626444 - 0.122004760687947*o[13])*o[2]))*tau2 + g.pi
            *(g.pi*(0.0000114610381688305*o[14] + g.pi*((-1.00288598706366e-10
             + o[15]*(-0.0127028833928130 - 143.374451604624*o[16]))*o[2] + g.pi
            *(-4.1341695026989e-17 + o[17]*(-8.8352662293707e-6 -
            0.272627897050173*o[18]) + g.pi*(o[11]*(9.0049690883672e-11 -
            65.849072718398*o[19]) + g.pi*(1.78287415218792e-7*o[15] + g.pi*(o[
            10]*(1.04069652101740e-18 + (-1.02347470959290e-12 -
            1.00181793795110e-8*o[10])*o[20]) + o[23]*(o[13]*(-1.29412653835176e-9
             + 1.71088510070544*o[24]) + o[21]*(-6.0592051033508*o[26] + o[21]*
            (o[27]*(1.78371690710842e-23 + (6.1258633752464e-12 -
            0.000084004935396416*o[15])*o[28]) + g.pi*(-1.24017662339842e-24*o[
            24] + g.pi*(0.000083219284749605*o[29] + g.pi*(-2.93678005497663e-14
            *o[30] + o[31]*(1.75410265428146e-27 + o[18]*(1.32995316841867e-15
             - 0.0000226487297378904*o[32]))*g.pi)))))))))))) + tau2*(-3.15389238237468e-9
             + (5.1162871409140e-8 + 1.92901490874028e-6*tau2)*tau2))))))/g.pi;

          g.gpipi := (-1.00000000000000 + o[21]*(o[43] + g.pi*(
            1.22890426153854e-7 + (2.63224003706610e-6 + o[1]*(-0.000193666063431420
             + (-0.0090203547252888 - 0.244009521375894*o[13])*o[2]))*tau2 + g.pi
            *(g.pi*(0.000045844152675322*o[14] + g.pi*((-5.0144299353183e-10 +
            o[15]*(-0.063514416964065 - 716.87225802312*o[16]))*o[2] + g.pi*(-2.48050170161934e-16
             + o[17]*(-0.000053011597376224 - 1.63576738230104*o[18]) + g.pi*(o[
            11]*(6.3034783618570e-10 - 460.94350902879*o[19]) + g.pi*(
            1.42629932175034e-6*o[15] + g.pi*(o[10]*(9.3662686891566e-18 + (-9.2112723863361e-12
             - 9.0163614415599e-8*o[10])*o[20]) + o[23]*(o[13]*(-1.94118980752764e-8
             + 25.6632765105816*o[24]) + o[21]*(-103.006486756963*o[26] + o[21]
            *(o[27]*(3.3890621235060e-22 + (1.16391404129682e-10 -
            0.00159609377253190*o[15])*o[28]) + g.pi*(-2.48035324679684e-23*o[
            24] + g.pi*(0.00174760497974171*o[29] + g.pi*(-6.4609161209486e-13*
            o[30] + o[31]*(4.0344361048474e-26 + o[18]*(3.05889228736295e-14 -
            0.00052092078397148*o[32]))*g.pi)))))))))))) + tau2*(-9.4616771471240e-9
             + (1.53488614227420e-7 + o[44])*tau2)))))/o[21];

          g.gtau := (0.0280439559151000 + g.tau*(-0.285810955258200 + g.tau*(
            1.22131494717840 + g.tau*(-2.84816394288800 + g.tau*(
            4.3839511194500 + o[33]*(10.0866556801800 + (-0.56817265215440 +
            0.063805390599210*g.tau)*g.tau))))))/(o[33]*o[34]) + g.pi*(-0.0178348622923580
             + o[49] + g.pi*(-0.000033032641670203 + (-0.00037897975032630 + o[
            1]*(-0.0157571108973420 + (-0.306581069554011 - 0.00096028372490713
            *o[13])*o[2]))*tau2 + g.pi*(4.3870667284435e-7 + o[1]*(-0.000096833031715710
             + (-0.0090203547252888 - 1.42338887469272*o[13])*o[2]) + g.pi*(-7.8847309559367e-10
             + g.pi*(0.0000160454534363627*o[20] + g.pi*(o[1]*(-5.0144299353183e-11
             + o[15]*(-0.033874355714168 - 836.35096769364*o[16])) + g.pi*((-0.0000138839897890111
             - 0.97367106089347*o[18])*o[50] + g.pi*(o[14]*(9.0049690883672e-11
             - 296.320827232793*o[19]) + g.pi*(2.57526266427144e-7*o[51] + g.pi
            *(o[2]*(4.1627860840696e-19 + (-1.02347470959290e-12 -
            1.40254511313154e-8*o[10])*o[20]) + o[23]*(o[19]*(-2.34560435076256e-9
             + 5.3465159397045*o[24]) + o[21]*(-19.1874828272775*o[52] + o[21]*
            (o[16]*(1.78371690710842e-23 + (1.07202609066812e-11 -
            0.000201611844951398*o[15])*o[28]) + g.pi*(-1.24017662339842e-24*o[
            27] + g.pi*(0.000200482822351322*o[53] + g.pi*(-4.9797574845256e-14
            *o[54] + (1.90027787547159e-27 + o[18]*(2.21658861403112e-15 -
            0.000054734430199902*o[32]))*o[55]*g.pi)))))))))))) + (
            2.55814357045700e-8 + 1.44676118155521e-6*tau2)*tau2))));

          g.gtautau := (-0.168263735490600 + g.tau*(1.42905477629100 + g.tau*(-4.8852597887136
             + g.tau*(8.5444918286640 + g.tau*(-8.7679022389000 + o[33]*(-0.56817265215440
             + 0.127610781198420*g.tau)*g.tau)))))/(o[33]*o[34]*g.tau) + g.pi*(
            -0.091992027392730 + (-0.34548755450059 - 1.50975836183790*o[2])*
            tau2 + g.pi*(-0.00037897975032630 + o[1]*(-0.047271332692026 + (-1.83948641732407
             - 0.033609930371750*o[13])*o[2]) + g.pi*((-0.000193666063431420 +
            (-0.045101773626444 - 48.395221739552*o[13])*o[2])*tau2 + g.pi*(
            2.55814357045700e-8 + 2.89352236311042e-6*tau2 + g.pi*(
            0.000096272720618176*o[10]*tau2 + g.pi*((-1.00288598706366e-10 + o[
            15]*(-0.50811533571252 - 28435.9329015838*o[16]))*tau2 + g.pi*(o[11]
            *(-0.000138839897890111 - 23.3681054614434*o[18])*tau2 + g.pi*((
            6.3034783618570e-10 - 10371.2289531477*o[19])*o[20] + g.pi*(
            3.09031519712573e-6*o[17] + g.pi*(o[1]*(1.24883582522088e-18 + (-9.2112723863361e-12
             - 1.82330864707100e-7*o[10])*o[20]) + o[23]*(o[1]*o[11]*o[12]*(-6.5676921821352e-8
             + 261.979281045521*o[24])*tau2 + o[21]*(-1074.49903832754*o[1]*o[
            10]*o[12]*o[25]*tau2 + o[21]*((3.3890621235060e-22 + (
            3.6448887082716e-10 - 0.0094757567127157*o[15])*o[28])*o[32] + g.pi
            *(-2.48035324679684e-23*o[16] + g.pi*(0.0104251067622687*o[1]*o[12]
            *o[25]*tau2 + g.pi*(o[11]*o[12]*(4.7506946886790e-26 + o[18]*(
            8.6446955947214e-14 - 0.00311986252139440*o[32]))*g.pi -
            1.89230784411972e-12*o[10]*o[25]*tau2))))))))))))))));

          g.gtaupi := -0.0178348622923580 + o[49] + g.pi*(-0.000066065283340406
             + (-0.00075795950065260 + o[1]*(-0.0315142217946840 + (-0.61316213910802
             - 0.00192056744981426*o[13])*o[2]))*tau2 + g.pi*(
            1.31612001853305e-6 + o[1]*(-0.000290499095147130 + (-0.0270610641758664
             - 4.2701666240781*o[13])*o[2]) + g.pi*(-3.15389238237468e-9 + g.pi
            *(0.000080227267181813*o[20] + g.pi*(o[1]*(-3.00865796119098e-10 +
            o[15]*(-0.203246134285008 - 5018.1058061618*o[16])) + g.pi*((-0.000097187928523078
             - 6.8156974262543*o[18])*o[50] + g.pi*(o[14]*(7.2039752706938e-10
             - 2370.56661786234*o[19]) + g.pi*(2.31773639784430e-6*o[51] + g.pi
            *(o[2]*(4.1627860840696e-18 + (-1.02347470959290e-11 -
            1.40254511313154e-7*o[10])*o[20]) + o[23]*(o[19]*(-3.7529669612201e-8
             + 85.544255035272*o[24]) + o[21]*(-345.37469089099*o[52] + o[21]*(
            o[16]*(3.5674338142168e-22 + (2.14405218133624e-10 -
            0.0040322368990280*o[15])*o[28]) + g.pi*(-2.60437090913668e-23*o[27]
             + g.pi*(0.0044106220917291*o[53] + g.pi*(-1.14534422144089e-12*o[
            54] + (4.5606669011318e-26 + o[18]*(5.3198126736747e-14 -
            0.00131362632479764*o[32]))*o[55]*g.pi)))))))))))) + (
            1.02325742818280e-7 + o[44])*tau2)));
        end g2;

        function h_pT
          "specific enthalpy as function or pressure and temperature"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Pressure p "pressure";
          input Modelica.SIunits.Temperature T "Temperature";
          input Integer region=0
            "if 0, region is unknown, otherwise known and this input";
          output Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";

        protected
          Modelica.Media.Common.GibbsDerivs g;

        algorithm
          g := Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.g2(p, T);
          h := g.R*T*g.tau*g.gtau;
          annotation (
            derivative(noDerivative=region) = h_pT_der,
            Inline=false,
            LateInline=true);
        end h_pT;

        function s_pT "temperature as function of pressure and temperature"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Pressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature";
          input Integer region=0
            "if 0, region is unknown, otherwise known and this input";
          output Modelica.SIunits.SpecificEntropy s "specific entropy";

        protected
          Modelica.Media.Common.GibbsDerivs g;

        algorithm
          g := Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.g2(p, T);
          s := g.R*(g.tau*g.gtau - g.g);
        end s_pT;

        function cp_pT
          "specific heat capacity at constant pressure as function of pressure and temperature"

          extends Modelica.Icons.Function;
          input Modelica.SIunits.Pressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature";
          input Integer region=0
            "if 0, region is unknown, otherwise known and this input";
          output Modelica.SIunits.SpecificHeatCapacity cp
            "specific heat capacity";

        protected
          Modelica.Media.Common.GibbsDerivs g;

        algorithm
          g := Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.g2(p, T);
          cp := -g.R*g.tau*g.tau*g.gtautau;
        end cp_pT;

        function cv_pT
          "specific heat capacity at constant volume as function of pressure and temperature"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Pressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature";
          input Integer region=0
            "if 0, region is unknown, otherwise known and this input";
          output Modelica.SIunits.SpecificHeatCapacity cv
            "specific heat capacity";

        protected
          Modelica.Media.Common.GibbsDerivs g;

        algorithm
          g := Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.g2(p, T);
          cv := g.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
             - g.tau*g.gtaupi)/g.gpipi));
        end cv_pT;

        function rho_pT "density as function or pressure and temperature"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Pressure p "pressure";
          input Modelica.SIunits.Temperature T "temperature";
          output Modelica.SIunits.Density rho "density";

        protected
          Modelica.Media.Common.GibbsDerivs g;

        algorithm
          g := Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.g2(p, T);
          rho := p/(g.R*T*g.pi*g.gpi);
          annotation (
            derivative=rho_pT_der,
            Inline=false,
            LateInline=true);
        end rho_pT;

        function rho_pT_der "derivative function of rho_pT"
          extends Modelica.Icons.Function;
          input SI.Pressure p "pressure";
          input SI.Temperature T "temperature";
          input Real p_der "derivative of pressure";
          input Real T_der "derivative of temperature";
          output Real rho_der "derivative of density";
        protected
          Modelica.Media.Common.GibbsDerivs g;
          SI.Density d;
          Real vp;
          Real vt;
        algorithm
          g := Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.g2(p, T);
          vt := g.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
          vp := g.R*T/(p*p)*g.pi*g.pi*g.gpipi;
          d := p/(g.R*T*g.pi*g.gpi);
          rho_der := (-d^2*vp)*p_der + (-d^2*vt)*T_der;
        end rho_pT_der;

        function visc_dT "dynamic viscosity eta(d,T), industrial formulation"
          extends Modelica.Icons.Function;
          input SI.Density d "density";
          input SI.Temperature T "temperature (K)";
          output SI.DynamicViscosity eta "dynamic viscosity";
        protected
          constant Real n0=1.0 "viscosity coefficient";
          constant Real n1=0.978197 "viscosity coefficient";
          constant Real n2=0.579829 "viscosity coefficient";
          constant Real n3=-0.202354 "viscosity coefficient";
          constant Real[42] nn=array(
                      0.5132047,
                      0.3205656,
                      0.0,
                      0.0,
                      -0.7782567,
                      0.1885447,
                      0.2151778,
                      0.7317883,
                      1.241044,
                      1.476783,
                      0.0,
                      0.0,
                      -0.2818107,
                      -1.070786,
                      -1.263184,
                      0.0,
                      0.0,
                      0.0,
                      0.1778064,
                      0.460504,
                      0.2340379,
                      -0.4924179,
                      0.0,
                      0.0,
                      -0.0417661,
                      0.0,
                      0.0,
                      0.1600435,
                      0.0,
                      0.0,
                      0.0,
                      -0.01578386,
                      0.0,
                      0.0,
                      0.0,
                      0.0,
                      0.0,
                      0.0,
                      0.0,
                      -0.003629481,
                      0.0,
                      0.0) "viscosity coefficients";
          constant SI.Density rhostar=317.763 "scaling density";
          constant SI.DynamicViscosity etastar=55.071e-6 "scaling viscosity";
          constant SI.Temperature tstar=647.226 "scaling temperature";
          Integer i "auxiliary variable";
          Integer j "auxiliary variable";
          Real delta "dimensionless density";
          Real deltam1 "dimensionless density";
          Real tau "dimensionless temperature";
          Real taum1 "dimensionless temperature";
          Real Psi0 "auxiliary variable";
          Real Psi1 "auxiliary variable";
          Real tfun "auxiliary variable";
          Real rhofun "auxiliary variable";
        algorithm
          delta := d/rhostar;
          deltam1 := delta - 1.0;
          tau := tstar/T;
          taum1 := tau - 1.0;
          Psi0 := 1/(n0 + (n1 + (n2 + n3*tau)*tau)*tau)/(tau^0.5);
          Psi1 := 0.0;
          tfun := 1.0;
          for i in 1:6 loop
            if (i <> 1) then
              tfun := tfun*taum1;
            end if;
            rhofun := 1.;
            for j in 0:6 loop
              if (j <> 0) then
                rhofun := rhofun*deltam1;
              end if;
              Psi1 := Psi1 + nn[i + j*6]*tfun*rhofun;
            end for;
          end for;
          eta := etastar*Psi0*Modelica.Math.exp(delta*Psi1);
        end visc_dT;

        function cond_dT "Thermal conductivity"
          extends Modelica.Icons.Function;
          input SI.Density d "density";
          input SI.Temperature T "temperature (K)";
          output SI.ThermalConductivity lambda "thermal conductivity";
        protected
          Integer region(min=1, max=5) "IF97 region, valid values:1,2,3, and 5";
          constant Real n0=1.0 "conductivity coefficient";
          constant Real n1=6.978267 "conductivity coefficient";
          constant Real n2=2.599096 "conductivity coefficient";
          constant Real n3=-0.998254 "conductivity coefficient";
          constant Real[30] nn=array(
                      1.3293046,
                      1.7018363,
                      5.2246158,
                      8.7127675,
                      -1.8525999,
                      -0.40452437,
                      -2.2156845,
                      -10.124111,
                      -9.5000611,
                      0.9340469,
                      0.2440949,
                      1.6511057,
                      4.9874687,
                      4.3786606,
                      0.0,
                      0.018660751,
                      -0.76736002,
                      -0.27297694,
                      -0.91783782,
                      0.0,
                      -0.12961068,
                      0.37283344,
                      -0.43083393,
                      0.0,
                      0.0,
                      0.044809953,
                      -0.1120316,
                      0.13333849,
                      0.0,
                      0.0) "conductivity coefficient";
          constant SI.ThermalConductivity lamstar=0.4945 "scaling conductivity";
          constant SI.Density rhostar=317.763 "scaling density";
          constant SI.Temperature tstar=647.226 "scaling temperature";
          constant SI.Pressure pstar=22.115e6 "scaling pressure";
          constant SI.DynamicViscosity etastar=55.071e-6 "scaling viscosity";
          Integer i "auxiliary variable";
          Integer j "auxiliary variable";
          Real delta "dimensionless density";
          Real tau "dimensionless temperature";
          Real deltam1 "dimensionless density";
          Real taum1 "dimensionless temperature";
          Real Lam0 "part of thermal conductivity";
          Real Lam1 "part of thermal conductivity";
          Real Lam2 "part of thermal conductivity";
          Real tfun "auxiliary variable";
          Real rhofun "auxiliary variable";
          Real dpitau "auxiliary variable";
          Real ddelpi "auxiliary variable";
          Real d2 "auxiliary variable";
          Modelica.Media.Common.GibbsDerivs g
            "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
          Modelica.Media.Common.HelmholtzDerivs f
            "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
          Real Tc=T - 273.15 "Celsius temperature for region check";
          Real Chi "symmetrized compressibility";
          // slightly different variables for industrial use
          constant SI.Density rhostar2=317.7 "Reference density";
          constant SI.Temperature Tstar2=647.25 "Reference temperature";
          constant SI.ThermalConductivity lambdastar=1
            "Reference thermal conductivity";
          parameter Real TREL=T/Tstar2 "Relative temperature";
          parameter Real rhoREL=d/rhostar2 "Relative density";
          Real lambdaREL "Relative thermal conductivity";
          Real deltaTREL "Relative temperature increment";
          constant Real[:] C={0.642857,-4.11717,-6.17937,0.00308976,0.0822994,
              10.0932};
          constant Real[:] dpar={0.0701309,0.0118520,0.00169937,-1.0200};
          constant Real[:] b={-0.397070,0.400302,1.060000};
          constant Real[:] B={-0.171587,2.392190};
          constant Real[:] a={0.0102811,0.0299621,0.0156146,-0.00422464};
          Real Q;
          Real S;
          Real lambdaREL2
            "function, part of the interpolating equation of the thermal conductivity";
          Real lambdaREL1
            "function, part of the interpolating equation of the thermal conductivity";
          Real lambdaREL0
            "function, part of the interpolating equation of the thermal conductivity";
        algorithm
          deltaTREL := abs(TREL - 1) + C[4];
          Q := 2 + C[5]/deltaTREL^(3/5);
          if TREL >= 1 then
            S := 1/deltaTREL;
          else
            S := C[6]/deltaTREL^(3/5);
          end if;
          lambdaREL2 := (dpar[1]/TREL^10 + dpar[2])*rhoREL^(9/5)*
            Modelica.Math.exp(C[1]*(1 - rhoREL^(14/5))) + dpar[3]*S*rhoREL^Q*
            Modelica.Math.exp((Q/(1 + Q))*(1 - rhoREL^(1 + Q))) + dpar[4]*
            Modelica.Math.exp(C[2]*TREL^(3/2) + C[3]/rhoREL^5);
          lambdaREL1 := b[1] + b[2]*rhoREL + b[3]*Modelica.Math.exp(B[1]*(
            rhoREL + B[2])^2);
          lambdaREL0 := TREL^(1/2)*sum(a[i]*TREL^(i - 1) for i in 1:4);
          lambdaREL := lambdaREL0 + lambdaREL1 + lambdaREL2;
          lambda := lambdaREL*lambdastar;
        end cond_dT;

        function h_pT_der "derivative function of h_pT"
          extends Modelica.Icons.Function;
          input SI.Pressure p "pressure";
          input SI.Temperature T "temperature";
          input Integer region=0
            "if 0, region is unknown, otherwise known and this input";
          input Real p_der "derivative of pressure";
          input Real T_der "derivative of temperature";
          output Real h_der "derivative of specific enthalpy";
        protected
          Modelica.Media.Common.GibbsDerivs g;
          SI.Density rho;
          Real vt;

        algorithm
          //region 2
          g := Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.g2(p, T);
          vt := g.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
          rho := max(p/(g.R*T*g.pi*g.gpi), 1e-9);
          h_der := (1/rho - T*vt)*p_der - g.R*g.tau*g.tau*g.gtautau*T_der;

        end h_pT_der;
      end IF97_new;

      function beta_H "Henry's law constant"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        output Real beta_H(unit="1/Pa") "Henry's law constant";

      protected
        Real[3] A={-9.67578,-9.44833,-8.40954};
        Real[3] B={4.72162,4.43822,4.29587};
        Real[3] C={11.70585,11.42005,10.52779};
        Real[3] psi={0.7812,0.2095,0.0093};

        Real[3] beta=fill(0, 3);
        Real Tr=T/647.096;
        Real tau=1 - Tr;

      algorithm
        if ((T < 273.15) or (T >
            Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Tsat(p))) then
          beta_H := 0;
        else
          for k in 1:3 loop
            beta[k] :=
              Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.psat(T)*exp(
              A[k]/Tr + B[k]*tau^(0.355)/Tr + C[k]*Tr^(-0.41)*exp(tau));
          end for;
          beta_H := 1/1.01325*(psi[1]/beta[1] + psi[2]/beta[2] + psi[3]/beta[3]);
        end if;
      end beta_H;

      function f_pT
        "Enhancement factor as function of pressure and temperature"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        output Real f "Vapor-pressure enhancement factor";

      protected
        function f_res
          extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
          input Modelica.SIunits.AbsolutePressure p "Pressure";
          input Modelica.SIunits.Temperature T "Temperature";

        protected
          Real x=u;
          Real p_ws=0;
          Real kappa_T=0;
          Real v_ws=0;
          Real beta_H=0;
          Real psi_ws=0;
          Real baa=0;
          Real baw=0;
          Real bww=0;
          Real caaa=0;
          Real caaw=0;
          Real caww=0;
          Real cwww=0;
          final constant Real R_bar=8.314472;

        algorithm
          //p_ws is the saturation pressure of water
          p_ws := if (T >= 273.16) then
            Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.psat(T) else
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.psub(T);

          //kappa_T is the isothermal compressibility
          if (p < p_ws) then
            kappa_T := 0;
          else
            kappa_T := if (T >= 273.16) then
              Modelica.Media.Water.IF97_Utilities.kappa_pT(p, T) else
              Modelica.Media.Water.IAPWS09.Ice09_Utilities.kappa_pT(p, T);
          end if;

          //v_ws is the molar volume of saturated water
          v_ws := if (T >= 273.16) then Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.molarMass
            /Modelica.Media.Water.IF97_Utilities.rho_pT(p, T) else Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Constants.MM
            /Modelica.Media.Water.IAPWS09.Ice09_Utilities.rho_pT(p, T);

          //beta_H is Henry's law constant
          beta_H := Modelica.Media.Air.RealGasMoistAir.Utilities.beta_H(p, T);

          //calculating the virial coefficients baa, baw, bww, caaa, caaw, caww, cwww
          baa :=
            Modelica.Media.Air.RealGasMoistAir.Utilities.VirialCoefficients.Baa_dT(
            0, T);
          baw :=
            Modelica.Media.Air.RealGasMoistAir.Utilities.VirialCoefficients.Baw_dT(
            0, T);
          bww :=
            Modelica.Media.Air.RealGasMoistAir.Utilities.VirialCoefficients.Bww_dT(
            0, T);
          caaa :=
            Modelica.Media.Air.RealGasMoistAir.Utilities.VirialCoefficients.Caaa_dT(
            0, T);
          caaw :=
            Modelica.Media.Air.RealGasMoistAir.Utilities.VirialCoefficients.Caaw_dT(
            0, T);
          caww :=
            Modelica.Media.Air.RealGasMoistAir.Utilities.VirialCoefficients.Caww_dT(
            0, T);
          cwww :=
            Modelica.Media.Air.RealGasMoistAir.Utilities.VirialCoefficients.Cwww_dT(
            0, T);

          y := ((1 + kappa_T*p_ws)*(p - p_ws) - kappa_T*(p^2 - p_ws^2)/2)/(
            R_bar*T)*v_ws + log(1 - beta_H*(1 - x*p_ws/p)*p) + (1 - x*p_ws/p)^2
            *p/(R_bar*T)*baa - 2*(1 - x*p_ws/p)^2*p/(R_bar*T)*baw - (p - p_ws
             - (1 - x*p_ws/p)^2*p)/(R_bar*T)*bww + (1 - x*p_ws/p)^3*p^2/(R_bar*
            T)^2*caaa + 3*(1 - x*p_ws/p)^2*(1 - 2*(1 - x*p_ws/p))*p^2/(2*(R_bar
            *T)^2)*caaw - 3*(1 - x*p_ws/p)^2*x*p_ws/p*p^2/(R_bar*T)^2*caww - ((
            3 - 2*x*p_ws/p)*(x*p_ws/p)^2*p^2 - p_ws^2)/(2*(R_bar*T)^2)*cwww - (
            1 - x*p_ws/p)^2*(-2 + 3*x*p_ws/p)*x*p_ws/p*p^2/(R_bar*T)^2*baa*bww
             - 2*(1 - x*p_ws/p)^3*(-1 + 3*x*p_ws/p)*p^2/(R_bar*T)^2*baa*baw + 6
            *(1 - x*p_ws/p)^2*(x*p_ws/p)^2*p^2/(R_bar*T)^2*bww*baw - 3*(1 - x*
            p_ws/p)^4*p^2/(2*(R_bar*T)^2)*baa^2 - 2*(1 - x*p_ws/p)^2*x*p_ws/p*(
            -2 + 3*x*p_ws/p)*p^2/(R_bar*T)^2*baw^2 - (p_ws^2 - (4 - 3*x*p_ws/p)
            *(x*p_ws/p)^3*p^2)/(2*(R_bar*T)^2)*bww^2 - log(x);
        end f_res;
        Real xmax;

      algorithm
        if ((useEnhancementFactor == false) or (T >=
            Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Tsat(p))) then
          f := 1;
        else
          xmax := if (T < 273.16) then 120.0 else 8.0;
          f := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
                  function f_res(p=p, T=T),
                  0.99999,
                  xmax,
                  1e-9);
        end if;
      end f_pT;

      function rho_pTX
        "return density as a function of pressure p, temperature T and composition X"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        output Modelica.SIunits.Density d "Density";

      protected
        Real pd;
        Real pl;
        Real xw;
        Real xws;

      algorithm
        if (X[1] == 0) then
          d := Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT(p, T);
        else
          xw := X[1]/(1 - X[1]);
          xws := xws_pT(p, T);
          pd := pd_pTX(
                  p,
                  T,
                  X);
          pl := p - pd;
          if ((xw <= xws) or (xws == -1)) then
            if (T < 273.16) then
              d := Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT(pl, T) +
                pd/(.Modelica.Media.Air.RealGasMoistAir.steam.R*T);
            else
              d := Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT(pl, T) +
                IF97_new.rho_pT(pd, T);
            end if;
          else
            if (T < 273.16) then
              d := (1 + xw)/((1 + xws)/(
                Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT(pl, T) + pd/
                (.Modelica.Media.Air.RealGasMoistAir.steam.R*T)) + (xw - xws)/
                Modelica.Media.Water.IAPWS09.Ice09_Utilities.rho_pT(p, T));
            else
              d := (1 + xw)/((1 + xws)/(
                Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT(pl, T) +
                IF97_new.rho_pT(pd, T)) + (xw - xws)/
                Modelica.Media.Water.IF97_Utilities.rho_pT(p, T));
            end if;
          end if;
        end if;
        annotation (
          derivative=rho_pTX_der,
          Inline=false,
          LateInline=true);
      end rho_pTX;

      function pds_pT "saturation partial pressure of steam"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.AbsolutePressure pds "Pressure";

      protected
        Real Tlim;

      algorithm
        if (T >= 273.16) then
          pds := Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.psat(T);
          Tlim := Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Tsat(p);
        else
          pds := Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.psub(T);
          Tlim := Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Tsub(p);
        end if;
        if (T <= Tlim) then
          pds := Modelica.Media.Air.RealGasMoistAir.Utilities.f_pT(p, T)*pds;
        else
          pds := -1;
        end if;
        annotation (
          derivative=pds_pT_der,
          Inline=false,
          LateInline=true);
      end pds_pT;

      function pd_pTX "partial pressure of steam"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        output Modelica.SIunits.AbsolutePressure pd "partial pressure";

      protected
        Real xw;
        Real xws;
        Real pds;

      algorithm
        if (X[1] == 0) then
          pd := 0;
        else
          xw := X[1]/(1 - X[1]);
          pds := Modelica.Media.Air.RealGasMoistAir.Utilities.pds_pT(p, T);
          pd := xw/(Modelica.Media.Air.RealGasMoistAir.k_mair + xw)*p;
          xws := Modelica.Media.Air.RealGasMoistAir.Utilities.xws_pT(p, T);
          pd := if ((xw <= xws) or (xws == -1)) then pd else pds;
        end if;
        annotation (
          derivative=pd_pTX_der,
          Inline=false,
          LateInline=true);
      end pd_pTX;

      function xws_pT "Humidity ration (absolute) of saturated humid air"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        output Real xws "absolute humidity ratio";

      protected
        Real pds;
        Real Tlim;

      algorithm
        pds := Modelica.Media.Air.RealGasMoistAir.Utilities.pds_pT(p, T);
        Tlim := if (T <= 273.16) then
          Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Tsub(p) else
          Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Tsat(p);
        xws := if (T <= Tlim) then Modelica.Media.Air.RealGasMoistAir.k_mair*
          pds/(p - pds) else -1;
        annotation (
          derivative=xws_pT_der,
          Inline=false,
          LateInline=true);
      end xws_pT;

      function phi_pTX "relative humidity"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        output Real phi "Relative humidity";

      protected
        Real xw;
        Real pd;
        Real pds;

      algorithm
        if (X[1] == 0) then
          phi := 0;
        else
          xw := X[1]/(1 - X[1]);
          if (T >= 273.16) then
            pds := Modelica.Media.Water.IF97_Utilities.BaseIF97.Basic.psat(T);
          else
            pds := Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.psub(T);
          end if;
          pds := Modelica.Media.Air.RealGasMoistAir.Utilities.f_pT(p, T)*pds;
          pd := xw/(Modelica.Media.Air.RealGasMoistAir.k_mair + xw)*p;
          if (pd <= pds) then
            phi := pd/pds;
          else
            phi := -1;
          end if;
        end if;
        annotation (Inline=false, LateInline=true);
      end phi_pTX;

      function cp_pTX "specific isobaric heat capacity"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        output Modelica.SIunits.SpecificHeatCapacity cp
          "specific heat capacity";

      protected
        Real xw;
        Real xws;
        Real pd;
        Real pl;

      algorithm
        if (X[1] == 0.0) then
          if (T >= 773.15) then
            cp := Modelica.Media.Air.RealGasAir.Air_Utilities.cp_pT(p, T) +
              Utilities.cp_dis_pTX(
                    p,
                    T,
                    X);
          else
            cp := Modelica.Media.Air.RealGasAir.Air_Utilities.cp_pT(p, T);
          end if;
        else
          pd := Modelica.Media.Air.RealGasMoistAir.Utilities.pd_pTX(
                  p,
                  T,
                  X);
          pl := p - pd;
          xw := X[1]/(1 - X[1]);
          xws := Modelica.Media.Air.RealGasMoistAir.Utilities.xws_pT(p, T);
          if ((xw <= xws) or (xws == -1)) then
            if (T >= 773.15) then
              cp := X[1]*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.cp_pT(pd,
                T) + X[2]*Modelica.Media.Air.RealGasAir.Air_Utilities.cp_pT(pl,
                T) + Modelica.Media.Air.RealGasMoistAir.Utilities.cp_dis_pTX(
                      p,
                      T,
                      X);
            else
              cp := X[1]*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.cp_pT(pd,
                T) + X[2]*Modelica.Media.Air.RealGasAir.Air_Utilities.cp_pT(pl,
                T);
            end if;
          else
            cp := -1;
          end if;
        end if;
        annotation (Inline=false, LateInline=true);
      end cp_pTX;

      function cv_pTX "specific isochoric heat capacity"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        output Modelica.SIunits.SpecificHeatCapacity cv
          "specific heat capacity";

      protected
        Real xw;
        Real xws;
        Real pd;
        Real pl;

      algorithm
        if (X[1] == 0) then
          cv := Modelica.Media.Air.RealGasAir.Air_Utilities.cv_pT(p, T);
        else
          pd := Modelica.Media.Air.RealGasMoistAir.Utilities.pd_pTX(
                  p,
                  T,
                  X);
          pl := p - pd;
          xw := X[1]/(1 - X[1]);
          xws := Modelica.Media.Air.RealGasMoistAir.Utilities.xws_pT(p, T);
          if ((xw <= xws) or (xws == -1)) then
            cv := X[1]*
              Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.cv_pT(pd, T)
               + X[2]*Modelica.Media.Air.RealGasAir.Air_Utilities.cv_pT(pl, T);
          else
            cv := -1;
          end if;
        end if;
        annotation (Inline=false, LateInline=true);
      end cv_pTX;

      function h_pTX "specific enthalpy of moist air"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        output Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";

      protected
        Real xw;
        Real xws;
        Real pd;
        Real pl;

      algorithm
        if (X[1] == 0) then
          h := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT(p, T);
        else
          pd := Modelica.Media.Air.RealGasMoistAir.Utilities.pd_pTX(
                  p,
                  T,
                  X);
          pl := p - pd;
          xw := X[1]/(1 - X[1]);
          xws := Modelica.Media.Air.RealGasMoistAir.Utilities.xws_pT(p, T);
          if ((xw <= xws) or (xws == -1)) then
            if (T >= 773.15) then
              h := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT(pl, T) + xw
                *Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT(pd,
                T) + (1 + xw)*
                Modelica.Media.Air.RealGasMoistAir.Utilities.h_dis_pTX(
                      p,
                      T,
                      X);
            else
              h := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT(pl, T) + xw
                *Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT(pd,
                T);
            end if;
          else
            if (T < 273.16) then
              h := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT(pl, T) +
                xws*Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT(
                pd, T) + (xw - xws)*
                Modelica.Media.Water.IAPWS09.Ice09_Utilities.h_pT(p, T);
            else
              h := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT(pl, T) +
                xws*Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT(
                pd, T) + (xw - xws)*Modelica.Media.Water.IF97_Utilities.h_pT(p,
                T);
            end if;
          end if;
          h := h/(1 + xw);
        end if;
        annotation (
          derivative=h_pTX_der,
          Inline=false,
          LateInline=true);
      end h_pTX;

      function h_dis_pTX
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "pressure";
        input Modelica.SIunits.Temperature T "temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        output Real u "reaction index";
      protected
        Real uges;
        Real invMMX[4] "inverses of molar weights";
        SI.MolarMass Mmix "molar mass of mixture";
        MassFraction[4] massFraction "Mass fractions of components";
        Modelica.SIunits.MoleFraction[4] Y
          "Mole fractions of individual components (H2O, N2, O2, Ar) of moist air";
      algorithm
        if (useDissociation == false) then
          u := 0;
        else
          massFraction := {X[1],X[2]*Xi_Air[1],X[2]*Xi_Air[2],X[2]*Xi_Air[3]};
          for i in 1:4 loop
            invMMX[i] := 1/MMX[i];
          end for;
          Mmix := 1/(massFraction*invMMX);
          for i in 1:4 loop
            Y[i] := Mmix*massFraction[i]/MMX[i];
          end for;
          uges := 1 +
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U2(
                  p,
                  T,
                  Y) +
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U3(
                  p,
                  T,
                  Y) +
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U4(
                  p,
                  T,
                  Y) +
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U5(
                  p,
                  T,
                  Y) +
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U6(
                  p,
                  T,
                  Y);
          u := -T^2*(
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U2(
                  p,
                  T,
                  Y)*
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.V2(T)/
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.BB[2]
             + Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U3(
                  p,
                  T,
                  Y)*
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.V3(T)/
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.BB[3]
             + Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U4(
                  p,
                  T,
                  Y)*
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.V4(T)/
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.BB[4]
             + Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U5(
                  p,
                  T,
                  Y)*
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.V5(T)/
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.BB[5]
             + Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U6(
                  p,
                  T,
                  Y)*
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.V6(T)/
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.BB[6])
            /uges*sum(massFraction[j]/MMX[j] for j in 1:4);
        end if;
      end h_dis_pTX;

      function s_pTX "specific entropy of moist air"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        output Modelica.SIunits.SpecificEntropy s "specific entropy";

      protected
        Real xw;
        Real xws;
        Real pd;
        Real pl;

      algorithm
        if (X[1] == 0) then
          s := Modelica.Media.Air.RealGasAir.Air_Utilities.s_pT(p, T);
        else
          pd := Modelica.Media.Air.RealGasMoistAir.Utilities.pd_pTX(
                  p,
                  T,
                  X);
          pl := p - pd;
          xw := X[1]/(1 - X[1]);
          xws := Modelica.Media.Air.RealGasMoistAir.Utilities.xws_pT(p, T);
          if ((xw <= xws) or (xws == -1)) then
            if (T >= 773.15) then
              s := Modelica.Media.Air.RealGasAir.Air_Utilities.s_pT(pl, T) + xw
                *Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.s_pT(pd,
                T) + (1 + xw)*
                Modelica.Media.Air.RealGasMoistAir.Utilities.s_dis_pTX(
                      p,
                      T,
                      X);
            else
              s := Modelica.Media.Air.RealGasAir.Air_Utilities.s_pT(pl, T) + xw
                *Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.s_pT(pd,
                T);
            end if;
          else
            if (T < 273.16) then
              s := Modelica.Media.Air.RealGasAir.Air_Utilities.s_pT(pl, T) +
                xws*Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.s_pT(
                pd, T) + (xw - xws)*
                Modelica.Media.Water.IAPWS09.Ice09_Utilities.s_pT(p, T);
            else
              s := Modelica.Media.Air.RealGasAir.Air_Utilities.s_pT(pl, T) +
                xws*Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.s_pT(
                pd, T) + (xw - xws)*Modelica.Media.Water.IF97_Utilities.s_pT(p,
                T);
            end if;
          end if;
          s := s/(1 + xw);
        end if;
        annotation (Inline=false, LateInline=true);
      end s_pTX;

      function u_pTX "internal energy"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        output Modelica.SIunits.SpecificEnergy u "specific entropy";

      algorithm
        u := Modelica.Media.Air.RealGasMoistAir.Utilities.h_pTX(
                p,
                T,
                X) - p/Modelica.Media.Air.RealGasMoistAir.Utilities.rho_pTX(
                p,
                T,
                X);
        annotation (
          derivative=u_pTX_der,
          Inline=false,
          LateInline=true);
      end u_pTX;

      function cp_dis_pTX
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "pressure";
        input Modelica.SIunits.Temperature T "temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        output Real u "reaction index";
      protected
        Real uges;
        Real invMMX[4] "inverses of molar weights";
        SI.MolarMass Mmix "molar mass of mixture";
        MassFraction[4] massFraction "Mass fractions of components";
        Modelica.SIunits.MoleFraction[4] Y
          "Mole fractions of individual components (H2O, N2, O2, Ar) of moist air";
      algorithm
        if (useDissociation == false) then
          u := 0;
        else
          massFraction := {X[1],X[2]*Xi_Air[1],X[2]*Xi_Air[2],X[2]*Xi_Air[3]};
          for i in 1:4 loop
            invMMX[i] := 1/MMX[i];
          end for;
          Mmix := 1/(massFraction*invMMX);
          for i in 1:4 loop
            Y[i] := Mmix*massFraction[i]/MMX[i];
          end for;
          uges := 1 +
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U2(
                  p,
                  T,
                  Y) +
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U3(
                  p,
                  T,
                  Y) +
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U4(
                  p,
                  T,
                  Y) +
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U5(
                  p,
                  T,
                  Y) +
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U6(
                  p,
                  T,
                  Y);
          u := (Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U2(
                  p,
                  T,
                  Y)*
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.V2(T)
             + Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U3(
                  p,
                  T,
                  Y)*
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.V3(T)
             + Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U4(
                  p,
                  T,
                  Y)*
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.V4(T)
             + Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U5(
                  p,
                  T,
                  Y)*
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.V5(T)
             + Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U6(
                  p,
                  T,
                  Y)*
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.V6(T))
            /uges*sum(massFraction[j]/MMX[j] for j in 1:4);
        end if;
      end cp_dis_pTX;

      function s_dis_pTX
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "pressure";
        input Modelica.SIunits.Temperature T "temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        output Real u "reaction index";
      protected
        Real uges;
        Real invMMX[4] "inverses of molar weights";
        SI.MolarMass Mmix "molar mass of mixture";
        MassFraction[4] massFraction "Mass fractions of components";
        Modelica.SIunits.MoleFraction[4] Y
          "Mole fractions of individual components (H2O, N2, O2, Ar) of moist air";
      algorithm
        if (useDissociation == false) then
          u := 0;
        else
          massFraction := {X[1],X[2]*Xi_Air[1],X[2]*Xi_Air[2],X[2]*Xi_Air[3]};
          for i in 1:4 loop
            invMMX[i] := 1/MMX[i];
          end for;
          Mmix := 1/(massFraction*invMMX);
          for i in 1:4 loop
            Y[i] := Mmix*massFraction[i]/MMX[i];
          end for;
          uges := 1 +
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U2(
                  p,
                  T,
                  Y) +
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U3(
                  p,
                  T,
                  Y) +
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U4(
                  p,
                  T,
                  Y) +
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U5(
                  p,
                  T,
                  Y) +
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U6(
                  p,
                  T,
                  Y);
          u := -T*(
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U2(
                  p,
                  T,
                  Y)*
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.V2(T)/
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.BB[2]
             + Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U3(
                  p,
                  T,
                  Y)*
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.V3(T)/
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.BB[3]
             + Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U4(
                  p,
                  T,
                  Y)*
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.V4(T)/
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.BB[4]
             + Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U5(
                  p,
                  T,
                  Y)*
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.V5(T)/
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.BB[5]
             + Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.U6(
                  p,
                  T,
                  Y)*
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.V6(T)/
            Modelica.Media.Air.RealGasMoistAir.Utilities.ReactionIndices.BB[6])
            /uges*sum(massFraction[j]/MMX[j] for j in 1:4);
        end if;
      end s_dis_pTX;

      function pd_pTX_der "derivative of partial pressure of steam"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        input Real p_der "Derivative of pressure";
        input Real T_der "Derivative of temperature";
        input Real X_der[:] "Derivative of mass fractions";
        output Real pd_der "Derivative of partial pressure";

      protected
        Real xw, xw_der;
        Real xws;
        Real pds, pds_der;

      algorithm
        if (X[1] == 0) then
          //pd := 0;
          pd_der := 0;
        else
          xw := X[1]/(1 - X[1]) "d(xw)/dt = d(xw)/dX[1] * dX[1]/dt";
          xw_der := (X_der[1]*(1 - X[1]) + X[1]*X_der[1])/(1 - X[1])^2;
          pds_der := Modelica.Media.Air.RealGasMoistAir.Utilities.pds_pT_der(
                  p,
                  T,
                  p_der,
                  T_der);
          //pd := xw/(Modelica.Media.Air.RealGasMoistAir.k_mair + xw)*p;
          pd_der := (xw_der*(Modelica.Media.Air.RealGasMoistAir.k_mair + xw) -
            xw*xw_der)*p + xw/(Modelica.Media.Air.RealGasMoistAir.k_mair + xw)*
            p_der;
          xws := Modelica.Media.Air.RealGasMoistAir.Utilities.xws_pT(p, T);
          pd_der := if ((xw <= xws) or (xws == -1)) then pd_der else pds_der;
        end if;
      end pd_pTX_der;

      function xws_pT_der
        "Derivative of humidity ration (absolute) of saturated humid air"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Real p_der "Derivative of pressure";
        input Real T_der "Derivative of temperature";
        output Real xws_der "Derivative of absolute humidity ratio";

      protected
        Real pds, pds_der;
        Real Tlim;

      algorithm
        pds := Modelica.Media.Air.RealGasMoistAir.Utilities.pds_pT(p, T);
        pds_der := Modelica.Media.Air.RealGasMoistAir.Utilities.pds_pT_der(
                p,
                T,
                p_der,
                T_der);
        Tlim := if (T <= 273.16) then
          Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Tsub(p) else
          Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Tsat(p);
        if (T <= Tlim) then
          xws_der := Modelica.Media.Air.RealGasMoistAir.k_mair*((pds_der*(p -
            pds) + pds*pds_der)/(p - pds)^2);
        else
          xws_der := 0;
        end if;
      end xws_pT_der;

      function pds_pT_der "Derivative of saturation partial pressure of steam"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Real p_der "Derivative of pressure";
        input Real T_der "Derivative of temperature";
        output Real pds_der "Derivative of pressure";

      protected
        Real Tlim;

      algorithm
        if (T >= 273.16) then
          pds_der :=
            Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.psat_der(T,
            T_der);
          Tlim := Modelica.Media.Water.IAPWS95.Water95_Utilities.Basic.Tsat(p);
        else
          pds_der :=
            Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.psub_der(T,
            T_der);
          Tlim := Modelica.Media.Water.IAPWS09.Ice09_Utilities.Basic.Tsub(p);
        end if;
        if (T <= Tlim) then
          pds_der := pds_der;
        else
          pds_der := 0;
        end if;
      end pds_pT_der;

      function rho_pTX_der
        "Derivative of density as a function of pressure p, temperature T and composition X"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        input Real p_der "Derivative of pressure";
        input Real T_der "Derivative of temperature";
        input Real X_der[:] "Derivative of mass fractions";
        output Real d_der "Derivative of density";

      protected
        Real pd, pd_der;
        Real pl, pl_der;
        Real xw, xw_der;
        Real xws, xws_der;
        Real o[5];

      algorithm
        if (X[1] == 0) then
          d_der := Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT_der(
                  p,
                  T,
                  Modelica.Media.Air.RealGasAir.Air_Utilities.airBaseProp_pT(p,
              T), p_der,
                  T_der);
        else
          xw := X[1]/(1 - X[1]);
          xw_der := (X_der[1])/(1 - X[1])^2;
          xws := xws_pT(p, T);
          xws_der := xws_pT_der(
                  p,
                  T,
                  p_der,
                  T_der);
          pd := pd_pTX(
                  p,
                  T,
                  X);
          pd_der := Modelica.Media.Air.RealGasMoistAir.Utilities.pd_pTX_der(
                  p,
                  T,
                  X,
                  p_der,
                  T_der,
                  X_der);
          pl := p - pd;
          pl_der := p_der - pd_der;
          if ((xw <= xws) or (xws == -1)) then
            if (T < 273.16) then
              d_der := Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT_der(
                      pl,
                      T,
                  Modelica.Media.Air.RealGasAir.Air_Utilities.airBaseProp_pT(pl,
                  T), pl_der,
                      T_der) + Modelica.Media.Air.RealGasMoistAir.steam.R*(
                pd_der*T - pd*T_der)/(Modelica.Media.Air.RealGasMoistAir.steam.R
                *T)^2;

            else
              d_der := Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT_der(
                      pl,
                      T,
                  Modelica.Media.Air.RealGasAir.Air_Utilities.airBaseProp_pT(pl,
                  T), pl_der,
                      T_der) + IF97_new.rho_pT_der(
                      pd,
                      T,
                      pd_der,
                      T_der);

            end if;
          else
            if (T < 273.16) then
              o[1] := Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT(pl, T);
              o[2] := Modelica.Media.Water.IAPWS09.Ice09_Utilities.rho_pT(p, T);
              o[3] := ((1 + xws)/(
                Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT(pl, T) + pd/
                (.Modelica.Media.Air.RealGasMoistAir.steam.R*T)) + (xw - xws)/
                Modelica.Media.Water.IAPWS09.Ice09_Utilities.rho_pT(p, T));
              o[4] := Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT_der(
                      pl,
                      T,
                  Modelica.Media.Air.RealGasAir.Air_Utilities.airBaseProp_pT(p,
                  T), p_der,
                      T_der);

              o[5] := (xws_der*o[1] - (1 + xws)*o[4])/o[1]^2 + (pd_der*T - pd*
                T_der)/Modelica.Media.Air.RealGasMoistAir.steam.R/T^2 + (xw_der
                *o[2] - xw*
                Modelica.Media.Water.IAPWS09.Ice09_Utilities.rho_pT_der(
                      p,
                      T,
                  Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_pT(
                  p, T),
                      p_der,
                      T_der))/o[2]^2 - (xws_der*o[2] - xws*
                Modelica.Media.Water.IAPWS09.Ice09_Utilities.rho_pT_der(
                      p,
                      T,
                  Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_pT(
                  p, T),
                      p_der,
                      T_der))/o[2]^2;

              d_der := (xw_der*o[3] - (1 + xw)*o[5])/o[3]^2;
              //         d := (1 + xw)/((1 + xws)/(MoMoLib.Air.Air_Utilities.rho_pT(pl, T) + pd/
              //           (.Modelica.Media.Air.RealGasMoistAir.steam.R*T)) + (xw - xws)/
              //           Modelica.Media.Water.IAPWS09.Ice09_Utilities.rho_pT(p, T));
            else
              o[1] := Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT(pl, T)
                 + IF97_new.rho_pT(pd, T);
              o[2] := Modelica.Media.Water.IF97_Utilities.rho_pT(p, T);
              o[3] := ((1 + xws)/(
                Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT(pl, T) +
                IF97_new.rho_pT(pd, T)) + (xw - xws)/
                Modelica.Media.Water.IF97_Utilities.rho_pT(p, T));
              o[4] := Modelica.Media.Air.RealGasAir.Air_Utilities.rho_pT_der(
                      pl,
                      T,
                  Modelica.Media.Air.RealGasAir.Air_Utilities.airBaseProp_pT(p,
                  T), p_der,
                      T_der) + IF97_new.rho_pT_der(
                      pd,
                      T,
                      pd_der,
                      T_der);

              o[5] := (xws_der*o[1] - (1 + xws)*o[4])/o[1]^2 + (xw_der*o[2] -
                xw*Modelica.Media.Water.IF97_Utilities.rho_pT_der(
                      p,
                      T,
                      Modelica.Media.Water.IF97_Utilities.waterBaseProp_pT(p, T),
                      p_der,
                      T_der))/o[2]^2 - (xws_der*o[2] - xws*
                Modelica.Media.Water.IF97_Utilities.rho_pT_der(
                      p,
                      T,
                      Modelica.Media.Water.IF97_Utilities.waterBaseProp_pT(p, T),
                      p_der,
                      T_der))/o[2]^2;
              d_der := (xw_der*o[3] - (1 + xw)*o[5])/o[3]^2;
            end if;
          end if;
        end if;
      end rho_pTX_der;

      function h_dis_pTX_der
        extends Modelica.Icons.Function;
        import Modelica.Media.Air.RealGasMoistAir.Utilities;
        input Modelica.SIunits.AbsolutePressure p "pressure";
        input Modelica.SIunits.Temperature T "temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        input Real p_der "Derivative of pressure";
        input Real T_der "Derivative of temperature";
        input Real X_der[:] "Derivative of mass fractions";
        output Real u_der "Derivative of reaction index";
      protected
        Real uges, uges_der, o[7], l;
        Real invMMX[4] "inverses of molar weights";
        SI.MolarMass Mmix "molar mass of mixture";
        Real Mmix_der "Derivative of molar mass of mixture";
        MassFraction[4] massFraction "Mass fractions of components";
        Real[4] massFraction_der "Derivative of mass fractions of components";
        Modelica.SIunits.MoleFraction[4] Y
          "Mole fractions of individual components (H2O, N2, O2, Ar) of moist air";
        Real[4] Y_der
          "Derivative of mole fractions of individual components (H2O, N2, O2, Ar) of moist air";

      algorithm
        if (useDissociation == false) then
          //u := 0;
          u_der := 0;
        else
          massFraction := {X[1],X[2]*Xi_Air[1],X[2]*Xi_Air[2],X[2]*Xi_Air[3]};
          massFraction_der := {X_der[1],X_der[2]*Xi_Air[1],X_der[2]*Xi_Air[2],
            X_der[2]*Xi_Air[3]};
          for i in 1:4 loop
            invMMX[i] := 1/MMX[i];
          end for;
          Mmix := 1/(massFraction*invMMX);
          Mmix_der := -1/(massFraction*invMMX)^2*massFraction_der*invMMX;
          for i in 1:4 loop
            Y[i] := Mmix*massFraction[i]/MMX[i];
            Y_der[i] := (Mmix_der*massFraction[i] + Mmix*massFraction_der[i])/
              MMX[i];
          end for;
          uges := 1 + Utilities.ReactionIndices.U2(
                  p,
                  T,
                  Y) + Utilities.ReactionIndices.U3(
                  p,
                  T,
                  Y) + Utilities.ReactionIndices.U4(
                  p,
                  T,
                  Y) + Utilities.ReactionIndices.U5(
                  p,
                  T,
                  Y) + Utilities.ReactionIndices.U6(
                  p,
                  T,
                  Y);
          uges_der := Utilities.ReactionIndices.U2_der(
                  p,
                  T,
                  Y,
                  p_der,
                  T_der,
                  Y_der) + Utilities.ReactionIndices.U3_der(
                  p,
                  T,
                  Y,
                  p_der,
                  T_der,
                  Y_der) + Utilities.ReactionIndices.U4_der(
                  p,
                  T,
                  Y,
                  p_der,
                  T_der,
                  Y_der) + Utilities.ReactionIndices.U5_der(
                  p,
                  T,
                  Y,
                  p_der,
                  T_der,
                  Y_der) + Utilities.ReactionIndices.U6_der(
                  p,
                  T,
                  Y,
                  p_der,
                  T_der,
                  Y_der);
          o[1] := (Utilities.ReactionIndices.U2_der(
                  p,
                  T,
                  Y,
                  p_der,
                  T_der,
                  Y_der)*Utilities.ReactionIndices.V2(T) +
            Utilities.ReactionIndices.U2(
                  p,
                  T,
                  Y)*Utilities.ReactionIndices.V2_der(T, T_der))/Utilities.ReactionIndices.BB[
            2];
          o[2] := (Utilities.ReactionIndices.U3_der(
                  p,
                  T,
                  Y,
                  p_der,
                  T_der,
                  Y_der)*Utilities.ReactionIndices.V3(T) +
            Utilities.ReactionIndices.U3(
                  p,
                  T,
                  Y)*Utilities.ReactionIndices.V3_der(T, T_der))/Utilities.ReactionIndices.BB[
            3];
          o[3] := (Utilities.ReactionIndices.U4_der(
                  p,
                  T,
                  Y,
                  p_der,
                  T_der,
                  Y_der)*Utilities.ReactionIndices.V4(T) +
            Utilities.ReactionIndices.U4(
                  p,
                  T,
                  Y)*Utilities.ReactionIndices.V4_der(T, T_der))/Utilities.ReactionIndices.BB[
            4];
          o[4] := (Utilities.ReactionIndices.U5_der(
                  p,
                  T,
                  Y,
                  p_der,
                  T_der,
                  Y_der)*Utilities.ReactionIndices.V5(T) +
            Utilities.ReactionIndices.U5(
                  p,
                  T,
                  Y)*Utilities.ReactionIndices.V5_der(T, T_der))/Utilities.ReactionIndices.BB[
            5];
          o[5] := (Utilities.ReactionIndices.U6_der(
                  p,
                  T,
                  Y,
                  p_der,
                  T_der,
                  Y_der)*Utilities.ReactionIndices.V6(T) +
            Utilities.ReactionIndices.U6(
                  p,
                  T,
                  Y)*Utilities.ReactionIndices.V6_der(T, T_der))/Utilities.ReactionIndices.BB[
            6];
          l := (Utilities.ReactionIndices.U2(
                  p,
                  T,
                  Y)*Utilities.ReactionIndices.V2(T)/Utilities.ReactionIndices.BB[
            2] + Utilities.ReactionIndices.U3(
                  p,
                  T,
                  Y)*Utilities.ReactionIndices.V3(T)/Utilities.ReactionIndices.BB[
            3] + Utilities.ReactionIndices.U4(
                  p,
                  T,
                  Y)*Utilities.ReactionIndices.V4(T)/Utilities.ReactionIndices.BB[
            4] + Utilities.ReactionIndices.U5(
                  p,
                  T,
                  Y)*Utilities.ReactionIndices.V5(T)/Utilities.ReactionIndices.BB[
            5] + Utilities.ReactionIndices.U6(
                  p,
                  T,
                  Y)*Utilities.ReactionIndices.V6(T)/Utilities.ReactionIndices.BB[
            6]);
          o[6] := -2*T*(Utilities.ReactionIndices.U2(
                  p,
                  T,
                  Y)*Utilities.ReactionIndices.V2(T)/Utilities.ReactionIndices.BB[
            2] + Utilities.ReactionIndices.U3(
                  p,
                  T,
                  Y)*Utilities.ReactionIndices.V3(T)/Utilities.ReactionIndices.BB[
            3] + Utilities.ReactionIndices.U4(
                  p,
                  T,
                  Y)*Utilities.ReactionIndices.V4(T)/Utilities.ReactionIndices.BB[
            4] + Utilities.ReactionIndices.U5(
                  p,
                  T,
                  Y)*Utilities.ReactionIndices.V5(T)/Utilities.ReactionIndices.BB[
            5] + Utilities.ReactionIndices.U6(
                  p,
                  T,
                  Y)*Utilities.ReactionIndices.V6(T)/Utilities.ReactionIndices.BB[
            6]) - T^2*sum(o[1:5]);
          o[7] := uges_der*sum(massFraction[j]/MMX[j] for j in 1:4) + uges*sum(
            massFraction_der[j]/MMX[j] for j in 1:4);
          u_der := (o[6]*(uges*sum(massFraction[j]/MMX[j] for j in 1:4)) - l*o[
            7])/(uges*sum(massFraction[j]/MMX[j] for j in 1:4))^2;

        end if;
      end h_dis_pTX_der;

      function h_pTX_der "derivative of specific enthalpy of moist air"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        input Real p_der "Derivative of pressure";
        input Real T_der "Derivative of temperature";
        input Real X_der[:] "Derivative of mass fractions";
        output Real h_der "derivative of specific enthalpy";

      protected
        Modelica.SIunits.SpecificEnthalpy h;
        Real xw, xw_der;
        Real xws, xws_der;
        Real pd, pd_der;
        Real pl, pl_der;

      algorithm
        if (X[1] == 0) then
          h_der := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT_der(
                  p,
                  T,
                  Modelica.Media.Air.RealGasAir.Air_Utilities.airBaseProp_pT(p,
              T), p_der,
                  T_der);
        else
          pd := Modelica.Media.Air.RealGasMoistAir.Utilities.pd_pTX(
                  p,
                  T,
                  X);
          pd_der := Modelica.Media.Air.RealGasMoistAir.Utilities.pd_pTX_der(
                  p,
                  T,
                  X,
                  p_der,
                  T_der,
                  X_der);
          pl := p - pd;
          pl_der := p_der - pd_der;
          xw := X[1]/(1 - X[1]);
          xw_der := (X_der[1])/(1 - X[1])^2;
          xws := Modelica.Media.Air.RealGasMoistAir.Utilities.xws_pT(p, T);
          xws_der := xws_pT_der(
                  p,
                  T,
                  p_der,
                  T_der);
          if ((xw <= xws) or (xws == -1)) then
            if (T >= 773.15) then
              h_der := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT_der(
                      pl,
                      T,
                  Modelica.Media.Air.RealGasAir.Air_Utilities.airBaseProp_pT(pl,
                  T), pl_der,
                      T_der) + xw_der*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT(pd,
                T) + xw*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT_der(
                      pd,
                      T,
                      0,
                      pd_der,
                      T_der) + xw_der*
                Modelica.Media.Air.RealGasMoistAir.Utilities.h_dis_pTX(
                      p,
                      T,
                      X) + xw*
                Modelica.Media.Air.RealGasMoistAir.Utilities.h_dis_pTX_der(
                      p,
                      T,
                      X,
                      p_der,
                      T_der,
                      X_der);

            else
              h_der := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT_der(
                      pl,
                      T,
                  Modelica.Media.Air.RealGasAir.Air_Utilities.airBaseProp_pT(pl,
                  T), pl_der,
                      T_der) + xw_der*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT(pd,
                T) + xw*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT_der(
                      pd,
                      T,
                      0,
                      pd_der,
                      T_der);

            end if;
          else
            if (T < 273.16) then
              h_der := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT_der(
                      pl,
                      T,
                  Modelica.Media.Air.RealGasAir.Air_Utilities.airBaseProp_pT(pl,
                  T), pl_der,
                      T_der) + xws_der*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT(pd,
                T) + xws*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT_der(
                      pd,
                      T,
                      0,
                      pd_der,
                      T_der) + xw_der*
                Modelica.Media.Water.IAPWS09.Ice09_Utilities.h_pT(p, T) + xw*
                Modelica.Media.Water.IAPWS09.Ice09_Utilities.h_pT_der(
                      p,
                      T,
                  Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_pT(
                  p, T),
                      p_der,
                      T_der) - xws_der*
                Modelica.Media.Water.IAPWS09.Ice09_Utilities.h_pT(p, T) - xws*
                Modelica.Media.Water.IAPWS09.Ice09_Utilities.h_pT_der(
                      p,
                      T,
                  Modelica.Media.Water.IAPWS09.Ice09_Utilities.ice09BaseProp_pT(
                  p, T),
                      p_der,
                      T_der);

            else
              h_der := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT_der(
                      pl,
                      T,
                  Modelica.Media.Air.RealGasAir.Air_Utilities.airBaseProp_pT(p,
                  T), pl_der,
                      T_der) + xws_der*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT(pd,
                T) + xws*
                Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT_der(
                      pd,
                      T,
                      0,
                      pd_der,
                      T_der) + xw_der*Modelica.Media.Water.IF97_Utilities.h_pT(
                p, T) + xw*Modelica.Media.Water.IF97_Utilities.h_pT_der(
                      p,
                      T,
                      Modelica.Media.Water.IF97_Utilities.waterBaseProp_pT(p, T),
                      p_der,
                      T_der) - xws_der*Modelica.Media.Water.IF97_Utilities.h_pT(
                p, T) - xws*Modelica.Media.Water.IF97_Utilities.h_pT_der(
                      p,
                      T,
                      Modelica.Media.Water.IF97_Utilities.waterBaseProp_pT(p, T),
                      p_der,
                      T_der);

            end if;
          end if;
          if ((xw <= xws) or (xws == -1)) then
            if (T >= 773.15) then
              h := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT(pl, T) + xw
                *Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT(pd,
                T) + (1 + xw)*
                Modelica.Media.Air.RealGasMoistAir.Utilities.h_dis_pTX(
                      p,
                      T,
                      X);
            else
              h := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT(pl, T) + xw
                *Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT(pd,
                T);
            end if;
          else
            if (T < 273.16) then
              h := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT(pl, T) +
                xws*Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT(
                pd, T) + (xw - xws)*
                Modelica.Media.Water.IAPWS09.Ice09_Utilities.h_pT(p, T);
            else
              h := Modelica.Media.Air.RealGasAir.Air_Utilities.h_pT(pl, T) +
                xws*Modelica.Media.Air.RealGasMoistAir.Utilities.IF97_new.h_pT(
                pd, T) + (xw - xws)*Modelica.Media.Water.IF97_Utilities.h_pT(p,
                T);
            end if;
          end if;
          h_der := (h_der*(1 + xw) - h*xw_der)/(1 + xw)^2;
        end if;
      end h_pTX_der;

      function u_pTX_der "derivative of internal energy"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.RealGasMoistAir.reference_X
          "Mass fractions";
        input Real p_der "Derivative of pressure";
        input Real T_der "Derivative of temperature";
        input Real X_der[:] "Derivative of mass fractions";
        output Real u_der "Derivative of specific entropy";

      algorithm
        u_der := Modelica.Media.Air.RealGasMoistAir.Utilities.h_pTX_der(
                p,
                T,
                X,
                p_der,
                T_der,
                X_der) - (p_der*
          Modelica.Media.Air.RealGasMoistAir.Utilities.rho_pTX(
                p,
                T,
                X) - p*Modelica.Media.Air.RealGasMoistAir.Utilities.rho_pTX_der(
                p,
                T,
                X,
                p_der,
                T_der,
                X_der))/Modelica.Media.Air.RealGasMoistAir.Utilities.rho_pTX(
                p,
                T,
                X)^2;
      end u_pTX_der;
    end Utilities;
    annotation (Documentation(info="<html>
<p>
Calculation of fluid properties for moist air in the region from 143.15 Kelvin to 2000 Kelvin at pressures up to 10 MPa. This model of moist air is based on
the diploma thesis of Hellriegel [10] with small modifications. Moist air is treated as an ideal mixture of the real fluids air and water.
</p>

<h4>Restriction</h4>
<p>
The functions provided by this package shall be used inside of the restricted limits according to the referenced literature.
</p>

<ul>
<li>
<b>611.2 Pa &le; p &le; 10 MPa</b>
</li>
<li>
<b>143.15 K &le; T &le; 2000 K</b>
</li>
</ul>

<h4>Usage</h4>
<p>
The package MoistAir can be used as any other medium model (see <a href=\"modelica://Modelica.Media.UsersGuide\">User's Guide of Media Library</a> for further information). The package defines two boolean constants <b>useEnhancementFactor</b> and <b>useDissociation</b>, which give the user fine grained control of the calculations.
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr>
<td valign=\"top\"><b>Constant</b></td>
<td valign=\"top\"><b>Default Value</b></td>
<td valign=\"top\"><b>Meaning</b></td>
</tr>
<tr>
<td valign=\"top\">useEnhancementFactor</td>
<td valign=\"top\">false</td>
<td valign=\"top\">The enhancement factor is used in the calculation of the saturation partial pressure of water in moist air. It is always very close to 1 except for high pressures (&gt;2 MPa) and low temperatures (&lt;233.15 K). For pressures less than 1 MPa this factor can be safely set to 1. Its calculation is very expensive, since it can only be calculated by an iterative method.</td>
</tr>
<tr>
<td valign=\"top\">useDissociation</td>
<td valign=\"top\">true</td>
<td valign=\"top\">The effect of dissociation is taken into account for temperatures greater than 773.15 K.</td>
</tr>
</table>

<h4>Calculation algorithms</h4>
<h5>Nomenclature</h5>
<table width=\"25%\">
<colgroup>
<col width=\"1*\">
<col width=\"2*\">
</colgroup>
<tr>
<td>p</td>
<td>Mixture pressure in Pa</td>
</tr>
<tr>
<td>T</td>
<td>Temperature in K</td>
</tr>
<tr>
<td>x<sub>w</sub></td>
<td>Absolutue humidity in kg(water)/kg(dry air)</td>
</tr>
<tr>
<td>x<sub>ws</sub></td>
<td>Absolutue humidity on saturation boundary in kg(water)/kg(dry air)</td>
</tr>
<tr>
<td>&phi;</td>
<td>Relative humidity (only defined for unsaturated humid air)</td>
</tr>
</table>

<h5>Unsaturated and saturated humid air (0 &le; x<sub>w</sub> &le; x<sub>ws</sub>)</h5>
<p>
Ideal mixture of dry air and steam
</p>

<ul>
<li>Dry air:
<ul>
<li>d,h,u,s,c<sub>p</sub> from [1]</li>
<li>&lambda;, &eta; from [2]</li>
</ul>
</li>

<li>Steam:
<ul>
<li>d,h,u,s,c<sub>p</sub> from [4]</li>
<li>&lambda;, &eta; for 273.15 K &le; T &le; 1073.15 K from [5] and [6]</li>
<li>&lambda;, &eta; for T &lt; 273.15 K or T &gt; 1073.15 K from [12]</li>
</ul>
</li>
</ul>

<h5>Supersaturated humid air (liquid fog and ice fog)</h5>
<p>
<b>Liquid fog (x<sub>w</sub> &gt; x<sub>wsw</sub>) and T &ge; 273.16 K</b>
</p>

<p>
Ideal mixture of saturated humid air and water
</p>

<ul>
<li>Saturated humid air (see above)</li>
<li>d,h,u,s of liquid droplets from [4]</li>
<li>c<sub>p</sub> is not defined</li>
<li>&lambda;, &eta; of liquid droplets from [5] and [6]</li>
</ul>

<p>
<b>Ice fog (x<sub>w</sub> &gt; x<sub>wsw</sub>) and T &lt; 273.16 K</b>
</p>

<p>
Ideal mixture of saturated humid air and ice
</p>

<ul>
<li>Saturated humid air (see above)</li>
<li>d,h,u,s of ice crystals from [7]</li>
<li>c<sub>p</sub> is not defined</li>
<li>&lambda; of ice as constant value</li>
<li>&eta; of ice is neglected</li>
</ul>


<h5>Saturation pressure of water in moist air</h5>
<p>
The saturation pressure p<sub>ds</sub> of water in moist air is calculated by p<sub>ds</sub> = f*p<sub>sat</sub>, where
</p>

<ul>
<li>f is the enhancement factor from [9] and [3]</li>
<li>p<sub>sat</sub> for T &ge; 273.16 K is the saturation pressure from [4]</li>
<li>p<sub>sat</sub> for T &lt; 273.16 K is the saturation pressure from [8]</li>
</ul>


<h5>Dissociation</h5>
<p>
For temperatures above 773.15 K effects of dissociation are taken into account. Dissociation is modeled according to [11].
For high temperatures the calculated values for moist air with 0 kg(water)/kg(dry air) (i.e. dry air) may differ from those
calculated by the package Modelica.Media.Air.RealGasAir, because there no dissociation is considered.
</p>

<h4>References</h4>
<dl>
<dd>[1] <b>Thermodynamic Properties of Air and Mixtures of Nitrogen, Argon,
and Oxygen From 60 to 2000 K at Pressures to 2000 MPa</b>. J. Phys. Chem. Ref. Data, Vol. 29, No. 3, 2000.
</dd>
<dd>[2] <b>Viscosity and Thermal Conductivity Equations for
Nitrogen, Oxygen, Argon, and Air</b>. International Journal of Thermophysics, Vol. 25, No. 1, January 2004
</dd>
<dd>[3] <b>Revised Release on the IAPWS Formulation 1995 for the Thermodynamic
Properties of Ordinary Water Substance for General and Scientific Use</b>. 2009 International Association for the Properties of Water and Steam.
</dd>
<dd>[4] <b>Revised Release on the IAPWS Industrial Formulation 1997
for the Thermodynamic Properties of Water and Steam</b>. 2007 International Association for the Properties of Water and Steam.
</dd>
<dd>[5] <b>Release on the IAPWS Formulation 2008 for the Viscosity of Ordinary Water Substance</b>. 2008 International Association for the Properties of Water and Steam
</dd>
<dd>[6] <b>Release on the IAPWS Formulation 2011 for the Thermal Conductivity of
Ordinary Water Substance</b>. 2011 International Association for the Properties of Water and Steam.
</dd>
<dd>[7] <b>Revised Release on the Equation of State 2006 for H2O Ice Ih</b>. 2009 International Association for the Properties of Water and Steam.
</dd>
<dd>[8] <b>Revised Release on the Pressure along the Melting and
Sublimation Curves of Ordinary Water Substance</b>. 2011 International Association for the Properties of Water and Steam.
</dd>
<dd>[9] <b>Determination of Thermodynamic and Transport Properties
of Humid Air for Power-Cycle Calculations</b>. 2009 PTB, Braunschweig, Germany.
</dd>
<dd>[10] <b>Berechnung der thermodynamischen Zustandsfunktionen von
feuchter Luft in energietechnischen Prozessmodellierungen</b>. 2001 Diplomarbeit, Zittau.
</dd>
<dd>[11] <b>Thermodynamische Stoffwerte von feuchter Luft und Verbrennungsgasen</b>. 2003 VDI-Richtlinie 4670.
</dd>
<dd>[12] <b>W&auml;rme&uuml;bertragung in Dampferzeugern und W&auml;rmetauschern</b>. 1985 FDBR-Fachbuchreihe, Bd. 2, Vulkan Verlag Essen.
</dd>
</dl>

<h4>References</h4>
<dl>
<dt>Lemmon, E. W., Jacobsen, R. T., Penoncello, S. G., Friend, D. G.:</dt>
<dd><b>Thermodynamic Properties of Air and Mixtures of Nitrogen, Argon,
and Oxygen From 60 to 2000 K at Pressures to 2000 MPa</b>. J. Phys. Chem. Ref. Data, Vol. 29, No. 3, 2000.
</dd>
<dt>Lemmon, E. W., Jacobsen, R. T.:</dt>
<dd><b>Viscosity and Thermal Conductivity Equations for
Nitrogen, Oxygen, Argon, and Air</b>. International Journal of Thermophysics, Vol. 25, No. 1, January 2004
</dd>
</dl>


<h4>Verification</h4>
<p>
The verification report for the development of this library is provided
<a href=\"modelica://Modelica/Resources/Documentation/Media/MoMoLib_VerificationResults_XRG.pdf\">here</a>.
</p>

<h4>Acknowledgment</h4>
<p>
This library was developed by XRG Simulation GmbH as part of the <a href=\"http://www.cleansky.eu/\">Clean Sky</a> JTI project (Project title: MoMoLib—Modelica Model Library Development for Media, Magnetic Systems and Wavelets; Project number: 296369; Theme: JTI-CS-2011-1-SGO-02-026: Modelica Model Library Development Part I). The partial financial support for the development of this library by the European Union is highly appreciated.
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
  end RealGasMoistAir;
  annotation (Documentation(info="<html>
  <p>This package contains different medium models for air:</p>
<ul>
<li><b>SimpleAir</b><br>
    Simple dry air medium in a limited temperature range.</li>
<li><b>DryAirNasa</b><br>
    Dry air as an ideal gas from Media.IdealGases.MixtureGases.Air.</li>
<li><b>MoistAir</b><br>
    Moist air as an ideal gas mixture of steam and dry air with fog below and above the triple point temperature.</li>
</ul>
</html>"));
end Air;
