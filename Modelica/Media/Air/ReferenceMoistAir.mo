within Modelica.Media.Air;
package ReferenceMoistAir
  "ReferenceMoistAir: Detailed moist air model (143.15 ... 2000 K)"

  extends Modelica.Media.Interfaces.PartialRealCondensingGases(
    mediumName="Moist air",
    substanceNames={"Water","Air"},
    final fixedX=false,
    final reducedX=true,
    final singleState=false,
    reference_X={0.01,0.99},
    fluidConstants={Utilities.Water95_Utilities.waterConstants,Modelica.Media.Air.ReferenceAir.airConstants},
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX);

  constant Integer Water=1
    "Index of water (in substanceNames, massFractions X, etc.)";

  constant Integer Air=2
    "Index of air (in substanceNames, massFractions X, etc.)";

  constant Boolean useEnhancementFactor=false
    "Use the enhancement factor in the calculations";

  constant Boolean useDissociation=true
    "Take dissociation into account for high temperatures";

  constant Real k_mair=steam.MM/dryair.MM "Ratio of molar weights";

  constant Common.FundamentalConstants dryair=ReferenceAir.Air_Utilities.Basic.Constants;
  constant Common.FundamentalConstants steam=Utilities.Water95_Utilities.Constants;
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
    Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer else
          StateSelect.default),
    final standardOrderComponents=true) "Moist air base properties record"

    Real x_water "Mass of total water/mass of dry air";
    Real phi "Relative humidity";

  protected
    MassFraction X_liquid "Mass fraction of liquid or solid water";
    MassFraction X_steam "Mass fraction of steam water";
    MassFraction X_air "Mass fraction of air";
    MassFraction X_sat
      "Steam water mass fraction of saturation boundary in kg_water/kg_moistair";
    Real x_sat
      "Steam water mass content of saturation boundary in kg_water/kg_dryair";
    AbsolutePressure p_steam_sat "partial saturation pressure of steam";
  equation
    assert(T >= 143.15 and T <= 2000,
      "Temperature T is not in the allowed range 143.15 K <= (T =" + String(T)
       + " K) <= 2000 K required from medium model \"" + mediumName + "\".");

    MM = 1/(Xi[Water]/MMX[Water] + (1.0 - Xi[Water])/MMX[Air]);

    p_steam_sat = Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT(p, T);
    X_sat = Modelica.Media.Air.ReferenceMoistAir.Xsaturation(state);
    X_liquid = max(Xi[Water] - X_sat, 0.0);
    X_steam = Xi[Water] - X_liquid;
    X_air = 1 - Xi[Water];

    h = specificEnthalpy_pTX(
        p,
        T,
        Xi);
    R = dryair.R*(X_air/(1 - X_liquid)) + steam.R*X_steam/(1 - X_liquid);
    u = Modelica.Media.Air.ReferenceMoistAir.Utilities.u_pTX(
        p,
        T,
        Xi);
    d = Modelica.Media.Air.ReferenceMoistAir.Utilities.rho_pTX(
        p,
        T,
        Xi);
    state.p = p;
    state.T = T;
    state.X = X;

    // these x are per unit mass of DRY air!
    x_sat = Modelica.Media.Air.ReferenceMoistAir.xsaturation(state);
    x_water = Modelica.Media.Air.ReferenceMoistAir.waterContent_X(state.X);
    phi = Modelica.Media.Air.ReferenceMoistAir.Utilities.phi_pTX(
        p,
        T,
        Xi);

    annotation (Documentation(revisions="<html>
2017-04-13 Stefan Wischhusen: Resolved a problem for high saturation pressures and temperatures.
</html>"));
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
        T=Modelica.Media.Air.ReferenceMoistAir.Utilities.Inverses.T_phX(
          p,
          h,
          X),
        X=X) else ThermodynamicState(
        p=p,
        T=Modelica.Media.Air.ReferenceMoistAir.Utilities.Inverses.T_phX(
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
        T=Modelica.Media.Air.ReferenceMoistAir.Utilities.Inverses.T_psX(
          p,
          s,
          X),
        X=X) else ThermodynamicState(
        p=p,
        T=Modelica.Media.Air.ReferenceMoistAir.Utilities.Inverses.T_psX(
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
        p=Modelica.Media.Air.ReferenceMoistAir.Utilities.Inverses.p_dTX(
          d,
          T,
          X),
        T=T,
        X=X) else ThermodynamicState(
        p=Modelica.Media.Air.ReferenceMoistAir.Utilities.Inverses.p_dTX(
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
    x_sat := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(state.p,
      state.T);
    assert(x_sat > -1,
      "Calculation of absolute humidity is meaningless\nfor input pressure p = "
       + String(state.p) + " Pa and temperature T = " + String(state.T) + " K.");
  end xsaturation;

  redeclare function extends massFraction_pTphi
    "Return mass fractions as a function of pressure, temperature and relative humidity"
  protected
    Real pds;

  algorithm
    assert(phi < 1.0 and phi > 0, "Illegal input phi = " + String(phi) +
      ". Relative humidity is only defined in the range\n 0 <= phi <= 1.0.");
    pds := Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT(p, T);
    assert(pds > -1,
      "Calculation of mass fraction of steam is meaningless\nfor input pressure p = "
       + String(p) + " Pa and temperature T = " + String(T) + " K.");
    X := {phi*k_mair/(p/pds - phi),1 - phi*k_mair/(p/pds - phi)};
  end massFraction_pTphi;

  function massFractionWaterVapor "Return mass fraction of water vapor"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output MassFraction X "Mass fraction of water vapor";
  protected
    Real xw;
    Real xws;
  algorithm
    xw := state.X[1]/max(100*Modelica.Constants.eps, (1 - state.X[1]));
    xws := Utilities.xws_pT(state.p, state.T);
    X := if (xw <= xws) then xw/(1 + xw) else xws/(1 + xw);
    annotation (Documentation(revisions="<html>
2017-04-13 Stefan Wischhusen: Guard introduced against division by zero.
</html>"));
  end massFractionWaterVapor;

  function massFractionWaterNonVapor
    "Return mass fraction of liquid and solid water"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output MassFraction X "Mass fraction of water varpor";
  protected
    Real xw;
    Real xws;
  algorithm
    xw := state.X[1]/max(100*Modelica.Constants.eps, (1 - state.X[1]));
    xws := Utilities.xws_pT(state.p, state.T);
    X := if (xw <= xws) then 0 else (xw - xws)/(1 + xw);
    annotation (Documentation(revisions="<html>
2017-04-13 Stefan Wischhusen: Guard introduced against division by zero.
</html>"));
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
       + String(state.p) + " Pa and temperature T = " + String(state.T) + " K.");
  end massFractionSaturation;

  function massFractionSaturation_ppsat
    "Return mass fvraction at saturation boundary given pressure and saturation pressure"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Ambient pressure";
    input AbsolutePressure psat "Saturation pressure";
    output MassFraction[:] X "Mass fraction";
  algorithm
    X := {k_mair/(p/psat - 1 + k_mair),(p/psat - 1)/(p/psat - 1 + k_mair)};
  end massFractionSaturation_ppsat;

  function massFraction_waterContent
    "Return mass fractions as a function of pressure, temperature and absolute humidity in kg(water)/kg(dry air)"
    extends Modelica.Icons.Function;
    input Real xw "Water content in kg(water)/kg(dry air)";
    output MassFraction[:] X "Mass fractions";
  algorithm
    X := {xw/(1 + xw),1/(1 + xw)};
  end massFraction_waterContent;

  function waterContent_X
    "Return water content in kg(water)/kg(dry air) given mass fractions"
    extends Modelica.Icons.Function;
    input MassFraction[:] X "Mass fractions";
    output Real xw "Water content in kg(water)/kg(dry air)";
  algorithm
    xw := X[1]/max(100*Modelica.Constants.eps, (1 - X[1]));
    annotation (Documentation(revisions="<html>
2017-04-13 Stefan Wischhusen: Guard introduced against division by zero.
</html>"));
  end waterContent_X;

  redeclare function extends relativeHumidity "Return relative humidity"
  algorithm
    phi := Utilities.phi_pTX(
        state.p,
        state.T,
        state.X);
    assert(phi > -1,
      "Calculation of relative humidity is meaningless\nfor input pressure p = "
       + String(state.p) + " Pa and temperature T = " + String(state.T) + " K.");
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
    output AbsolutePressure psat "Saturation pressure";
  algorithm
    psat :=
      Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
      state.T);
  end saturationPressureLiquid;

  function sublimationPressureIce
    "Return sublimation pressure of water as a function of temperature T between 223.16 and 273.16 K"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output AbsolutePressure psat "Sublimation pressure";
  algorithm
    psat :=
      Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.psub(
      state.T);
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
      y := Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT(p=p, T=u) - p;
    end Tsat_res;

  algorithm
    Tsat := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
        function Tsat_res(p=state.p),
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

  redeclare function extends enthalpyOfLiquid "Return enthalpy of liquid water"
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
      h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, state.T) + xw
        *Utilities.IF97_new.h_pT(pd, state.T);
    else
      if (state.T < 273.16) then
        h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, state.T) +
          xws*Utilities.IF97_new.h_pT(pd, state.T);
      else
        h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, state.T) +
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
    h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(state.p, state.T);
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
  function enthalpyOfWaterNonVapor "Return enthalpy of liquid and solid water"
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
    h := Modelica.Media.Air.ReferenceMoistAir.Utilities.h_pTX(
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
    MassFraction[nX] X "Complete X-vector";
  algorithm
    /*X := if reducedX then cat(
      1,
      refState.X,
      {1 - sum(refState.X)}) else refState.X;*/
    X := refState.X;
    h_is := specificEnthalpy(setState_psX(
        p_downstream,
        specificEntropy(refState),
        X));
    annotation (Documentation(revisions="<html>
2013-07-18 Stefan Wischhusen: Changed internal calculation of X.
</html>"));
  end isentropicEnthalpy;

  redeclare function extends velocityOfSound "Return velocity of sound"
  algorithm
    a := sqrt(max(0, gasConstant(state)*state.T*specificHeatCapacityCp(state)/
      specificHeatCapacityCv(state)));
  end velocityOfSound;

  redeclare function extends molarMass "Return the molar mass of the medium"
  algorithm
    MM := 1/(state.X[1]/steam.MM + state.X[2]/dryair.MM);
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

  package Utilities "Utility package for moist air"
    extends Modelica.Icons.UtilitiesPackage;

    final constant MoleFraction[4] MMX={18.015257E-003,28.01348E-003,
        31.9988E-003,39.948E-003};

    final constant Real[3] Xi_Air={0.7557,0.2316,0.0127};

    package Inverses "Compute inverse function"
      extends Modelica.Icons.BasesPackage;

      function T_phX
        "Return temperature as a function of pressure, specific enthalpy and mass fractions"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
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
          input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
            "Mass fractions";
        algorithm
          y := Modelica.Media.Air.ReferenceMoistAir.Utilities.h_pTX(
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
        annotation (inverse(h=
                Modelica.Media.Air.ReferenceMoistAir.Utilities.h_pTX(
                      p=p,
                      T=T,
                      X=X)));
      end T_phX;

      function T_psX
        "Return temperature as function of pressure, specific entropy and mass fractions"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.SpecificEntropy s "Specific entropy";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
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
          input Modelica.SIunits.SpecificEntropy s "Specific entropy";
          input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
            "Mass fractions";
        algorithm
          y := Modelica.Media.Air.ReferenceMoistAir.Utilities.s_pTX(
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
        annotation (inverse(s=
                Modelica.Media.Air.ReferenceMoistAir.Utilities.s_pTX(
                      p=p,
                      T=T,
                      X=X)));
      end T_psX;

      function p_dTX
        "Return pressure as function of density, temperature and mass fractions"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Density d "Density";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
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
          input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
            "Mass fractions";
        algorithm
          y := Modelica.Media.Air.ReferenceMoistAir.Utilities.rho_pTX(
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
                611.2,
                1e7,
                1e-9);
        annotation (inverse(d=
                Modelica.Media.Air.ReferenceMoistAir.Utilities.rho_pTX(
                      p=p,
                      T=T,
                      X=X)), Documentation(revisions="<html>
2013-07-18 Stefan Wischhusen: Corrected inverse interval of pressure to complete range of medium model.
</html>"));
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
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
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
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Transport.coef coef;

      algorithm
        xw := X[1]/(1 - X[1]);
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        pd := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX(
                p,
                T,
                X);
        pl := p - pd;
        da := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T);
        if ((xw <= xws) or (xws == -1)) then
          if (T < 273.16) then
            dd := pd/(Modelica.Media.Air.ReferenceMoistAir.steam.R*T);
            ya := da/(da + dd);
            yd := 1 - ya;
            Tred := T/coef.epsilon;
            Omega := coef.w[1] + coef.w[2]*Tred + coef.w[3]*Modelica.Math.exp(
              coef.w[4]*Tred)/(coef.w[5] + Tred);
            etad := 2.6695E-006*sqrt(T*coef.M)/(coef.sigma^2*Omega);
            eta := ya*
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.eta_dT(da,
              T) + yd*etad;
          else
            dd :=
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.rho_pT(pd,
              T);
            ya := da/(da + dd);
            yd := 1 - ya;
            eta := ya*
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.eta_dT(da,
              T) + yd*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.visc_dT(
              dd, T);
          end if;
        else
          if (T < 273.16) then
            dd := pd/(Modelica.Media.Air.ReferenceMoistAir.steam.R*T);
            ya := da/(da + dd);
            yd := 1 - ya;
            Tred := T/coef.epsilon;
            Omega := coef.w[1] + coef.w[2]*Tred + coef.w[3]*Modelica.Math.exp(
              coef.w[4]*Tred)/(coef.w[5] + Tred);
            etad := 2.6695E-006*sqrt(T*coef.M)/(coef.sigma^2*Omega);
            eta := ya*
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.eta_dT(da,
              T) + yd*etad;
          else
            dd :=
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.rho_pT(pd,
              T);
            df := Modelica.Media.Water.IF97_Utilities.rho_pT(p, T);
            yf := (xw - xws)/df/((1 + xws)/(da + dd) + (xw - xws)/df);
            ya := (1 - yf)/(1 + dd/da);
            yd := 1 - (ya + yf);
            eta := ya*
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.eta_dT(da,
              T) + yd*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.visc_dT(
              dd, T) + yf*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.visc_dT(
              df, T);
          end if;
        end if;
      end eta_pTX;

      function lambda_pTX "Thermal conductivity"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
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
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Transport.coef coef;

      algorithm
        xw := X[1]/(1 - X[1]);
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        pd := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX(
                p,
                T,
                X);
        pl := p - pd;
        da := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T);
        if ((xw <= xws) or (xws == -1)) then
          if (T < 273.16) then
            dd := pd/(Modelica.Media.Air.ReferenceMoistAir.steam.R*T);
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
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.lambda_dT(
              da, T) + yd*lambdad;
          else
            dd :=
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.rho_pT(pd,
              T);
            ya := da/(da + dd);
            yd := 1 - ya;
            lambda := ya*
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.lambda_dT(
              da, T) + yd*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.cond_dT(
              dd, T);
          end if;
        else
          if (T < 273.16) then
            dd := pd/(Modelica.Media.Air.ReferenceMoistAir.steam.R*T);
            df :=
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.rho_pT(
              p, T);
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
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.lambda_dT(
              da, T) + yd*lambdad + yf*2.21;
          else
            dd :=
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.rho_pT(pd,
              T);
            df := Modelica.Media.Water.IF97_Utilities.rho_pT(p, T);
            yf := (xw - xws)/df/((1 + xws)/(da + dd) + (xw - xws)/df);
            ya := (1 - yf)/(1 + dd/da);
            yd := 1 - (ya + yf);
            lambda := ya*
              Modelica.Media.Air.ReferenceAir.Air_Utilities.Transport.lambda_dT(
              da, T) + yd*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.cond_dT(
              dd, T) + yf*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.cond_dT(
              df, T);
          end if;
        end if;
      end lambda_pTX;
    end Transport;

    package VirialCoefficients
      "Virial and cross-virial coefficients of air and water"
      extends Modelica.Icons.BasesPackage;

      function Baa_dT "Second molar virial coefficient of dry air"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.Density d "Density";
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.MolarVolume baa "Second virial coefficient";

      protected
        final constant Real[19] N={0.118160747229,0.713116392079,-0.161824192067E+001,
            0.714140178971E-001,-0.865421396646E-001,0.134211176704,
            0.112626704218E-001,-0.420533228842E-001,0.349008431982E-001,
            0.164957183186E-003,-0.101365037912,-0.173813690970,-0.472103183731E-001,
            -0.122523554253E-001,-0.146629609713,-0.316055879821E-001,
            0.233594806142E-003,0.148287891978E-001,-0.938782884667E-002};
        final constant Integer[19] i={1,1,1,2,3,3,4,4,4,6,1,3,5,6,1,3,11,1,3};
        final constant Real[19] j={0,0.33,1.01,0,0,0.15,0,0.2,0.35,1.35,1.6,0.8,
            0.95,1.25,3.6,6,3.25,3.5,15};
        Real tau=ReferenceAir.Air_Utilities.Basic.Constants.Tred/T;

      algorithm
        baa := 0;
        for k in 1:19 loop
          baa := if (i[k] == 1) then baa + N[k]*tau^j[k] else baa;
        end for;
        baa := 1/ReferenceAir.Air_Utilities.Basic.Constants.rhored*baa;

      end Baa_dT;

      function Baw_dT "Second molar cross-virial coefficient"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.Density d "Density";
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.MolarVolume baw
          "Second cross-virial coefficient";

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

      function Bww_dT "Second molar virial coefficient of water"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.Density d "Density";
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.MolarVolume bww "Second virial coefficient";

      protected
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

        Real tau=Water95_Utilities.Constants.Tred/T;

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
          bww := if (dd[k] == 1) then bww + N[k]*tau^t[k]*exp(-alpha[k]*epsilon[
            k]^2 - beta[k]*(tau - gamma[k])^2) else bww;
        end for;
        bww := (bww + N[55]*Delta55^b[55]*psi55 + N[56]*Delta56^b[56]*psi56)/
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Constants.rhored
          *Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Constants.MM;
      end Bww_dT;

      function Caaa_dT "Third molar virial coefficient of dry air"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.Density d "Density";
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.MolarVolume caaa "Third virial coefficient";

      protected
        final constant Real[19] N={0.118160747229,0.713116392079,-0.161824192067E+001,
            0.714140178971E-001,-0.865421396646E-001,0.134211176704,
            0.112626704218E-001,-0.420533228842E-001,0.349008431982E-001,
            0.164957183186E-003,-0.101365037912,-0.173813690970,-0.472103183731E-001,
            -0.122523554253E-001,-0.146629609713,-0.316055879821E-001,
            0.233594806142E-003,0.148287891978E-001,-0.938782884667E-002};
        final constant Integer[19] i={1,1,1,2,3,3,4,4,4,6,1,3,5,6,1,3,11,1,3};
        final constant Real[19] j={0,0.33,1.01,0,0,0.15,0,0.2,0.35,1.35,1.6,0.8,
            0.95,1.25,3.6,6,3.25,3.5,15};
        final constant Integer[19] l={0,0,0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,3,3};
        Real tau=ReferenceAir.Air_Utilities.Basic.Constants.Tred/T;

      algorithm
        caaa := 0;
        for k in 1:10 loop
          caaa := if (i[k] == 2) then caaa + 2*N[k]*tau^j[k] else caaa;
        end for;
        for k in 11:19 loop
          caaa := if (i[k] == 2) then caaa + 2*N[k]*tau^j[k] elseif ((i[k] == 1)
             and (l[k] == 1)) then caaa - 2*N[k]*tau^j[k] else caaa;
        end for;
        caaa := 1/ReferenceAir.Air_Utilities.Basic.Constants.rhored^2*caaa;
      end Caaa_dT;

      function Caaw_dT "Third molar cross-virial coefficient"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.Density d "Density";
        input Modelica.SIunits.Temperature T "Temperature";
        output Real caaw "Third cross-virial coefficient";

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

      function Caww_dT "Third molar cross-virial coefficient"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.Density d "Density";
        input Modelica.SIunits.Temperature T "Temperature";
        output Real caww "Third cross-virial coefficient";

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

      function Cwww_dT "Third molar virial coefficient of water"
        extends Modelica.Icons.Function;

        input Modelica.SIunits.Density d "Density";
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.MolarVolume cwww "Third virial coefficient";

      protected
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

        Real tau=Water95_Utilities.Constants.Tred/T;

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
        Deltab55deltadelta := b[55]*(Delta55^(b[55] - 1)*Delta55deltadelta + (b[
          55] - 1)*Delta55^(b[55] - 2)*Delta55delta^2);
        Deltab56deltadelta := b[56]*(Delta56^(b[56] - 1)*Delta56deltadelta + (b[
          56] - 1)*Delta56^(b[56] - 2)*Delta56delta^2);
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
        cwww := Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Constants.MM
          ^2/Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Constants.rhored
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
        "Reference pressure";

      function U2 "Reaction index for formation of H2"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MoleFraction[4] moleFraction "Mole fractions";
        output Real u "Reaction index for H2";
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
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MoleFraction[4] moleFraction "Mole fractions";
        output Real u "Reaction index for OH";
      algorithm
        u := AA[3]*sqrt(moleFraction[1])*sqrt(sqrt(moleFraction[3]))*(p/p0)^(-0.25)
          *Modelica.Math.exp(BB[3]/T);
        annotation (
          derivative=U3_der,
          Inline=false,
          LateInline=true);
      end U3;

      function U4 "Reaction index for formation of H"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MoleFraction[4] moleFraction "Mole fractions";
        output Real u "Reaction index for H";
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
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MoleFraction[4] moleFraction "Mole fractions";
        output Real u "Reaction index for O";
      algorithm
        u := AA[5]*sqrt(moleFraction[3])*(p/p0)^(-0.5)*Modelica.Math.exp(BB[5]/
          T);
        annotation (
          derivative=U5_der,
          Inline=false,
          LateInline=true);
      end U5;

      function U6 "Reaction index for formation of NO"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MoleFraction[4] moleFraction "Mole fractions";
        output Real u "Reaction index for NO";
      algorithm
        u := AA[6]*sqrt(moleFraction[2]*moleFraction[3])*Modelica.Math.exp(BB[6]
          /T);
        annotation (
          derivative=U6_der,
          Inline=false,
          LateInline=true);
      end U6;

      function V2 "Energy index for formation of H2"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.MolarHeatCapacity v "Energy index for H2";
      algorithm
        v := CC[2] + DD[2]/T + EE[2]/T^2;
        annotation (
          derivative=V2_der,
          Inline=false,
          LateInline=true);
      end V2;

      function V3 "Energy index for formation of OH"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.MolarHeatCapacity v "Energy index for OH";
      algorithm
        v := CC[3] + DD[3]/T + EE[3]/T^2;
        annotation (
          derivative=V3_der,
          Inline=false,
          LateInline=true);
      end V3;

      function V4 "Energy index for formation of H"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.MolarHeatCapacity v "Energy index for H";
      algorithm
        v := CC[4] + DD[4]/T + EE[4]/T^2;
        annotation (
          derivative=V4_der,
          Inline=false,
          LateInline=true);
      end V4;

      function V5 "Energy index for formation of O"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.MolarHeatCapacity v "Energy index for O";
      algorithm
        v := CC[5] + DD[5]/T + EE[5]/T^2;
        annotation (
          derivative=V5_der,
          Inline=false,
          LateInline=true);
      end V5;

      function V6 "Energy index for formation of NO"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.MolarHeatCapacity v "Energy index for NO";
      algorithm
        v := CC[6] + DD[6]/T + EE[6]/T^2;
        annotation (
          derivative=V6_der,
          Inline=false,
          LateInline=true);
      end V6;

      function U2_der "Derivative reaction index for formation of H2"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MoleFraction[4] moleFraction "Mole fractions";
        input Real p_der "Derivative of pressure";
        input Real T_der "Derivative of temperature";
        input Real[4] moleFraction_der "Derivative of mole fractions";
        output Real u_der "Derivative of reaction index for H2";

      protected
        Real o[4];
      algorithm
        o[1] := AA[2]*sqrt(moleFraction[3])*(p/p0)^(-0.5)*Modelica.Math.exp(BB[
          2]/T);
        o[2] := -0.5*AA[2]*moleFraction[1]/(moleFraction[3])^1.5*(p/p0)^(-0.5)*
          Modelica.Math.exp(BB[2]/T);
        o[3] := -0.5*AA[2]*moleFraction[1]/sqrt(moleFraction[3])*sqrt(p0)*p^(-1.5)
          *Modelica.Math.exp(BB[2]/T);
        o[4] := -BB[2]*AA[2]*moleFraction[1]/sqrt(moleFraction[3])*(p/p0)^(-0.5)
          *Modelica.Math.exp(BB[2]/T)/T^2;
        u_der := o[1]*moleFraction_der[1] + o[2]*moleFraction_der[3] + o[3]*
          p_der + o[4]*T_der;

      end U2_der;

      function U3_der "Derivative of reaction index for formation of OH"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MoleFraction[4] moleFraction "Mole fractions";
        input Real p_der "Derivative of pressure";
        input Real T_der "Derivative of temperature";
        input Real[4] moleFraction_der "Derivative of mole fractions";
        output Real u_der "Derivative of reaction index for OH";
      protected
        Real o[4];
      algorithm
        o[1] := 0.5*AA[3]/sqrt(moleFraction[1])*sqrt(sqrt(moleFraction[3]))*(p/
          p0)^(-0.25)*Modelica.Math.exp(BB[3]/T);
        o[2] := 0.25*AA[3]*sqrt(moleFraction[1])/(moleFraction[3])^0.75*(p/p0)^
          (-0.25)*Modelica.Math.exp(BB[3]/T);
        o[3] := -0.25*AA[3]*sqrt(moleFraction[1])*sqrt(sqrt(moleFraction[3]))*
          sqrt(sqrt(p0))*p^(-1.25)*Modelica.Math.exp(BB[3]/T);
        o[4] := BB[3]*AA[3]*moleFraction[1]/sqrt(sqrt(moleFraction[3]))*(p/p0)^
          (-0.25)*Modelica.Math.exp(BB[3]/T)/T^2;
        u_der := o[1]*moleFraction_der[1] + o[2]*moleFraction_der[3] + o[3]*
          p_der + o[4]*T_der;

      end U3_der;

      function U4_der "Derivative of reaction index for formation of H"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MoleFraction[4] moleFraction "Mole fractions";
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
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MoleFraction[4] moleFraction "Mole fractions";
        input Real p_der "Derivative of pressure";
        input Real T_der "Derivative of temperature";
        input Real[4] moleFraction_der "Derivative of mole fractions";
        output Real u_der "Derivative of reaction index for O";
      protected
        Real o[3];
      algorithm
        o[1] := 0.5*AA[5]/sqrt(moleFraction[3])*(p/p0)^(-0.5)*Modelica.Math.exp(
          BB[5]/T);
        o[2] := -0.5*AA[5]*sqrt(moleFraction[3])*sqrt(p0)*p^(-1.5)*
          Modelica.Math.exp(BB[5]/T);
        o[3] := BB[5]*AA[5]*sqrt(moleFraction[3])*(p/p0)^(-0.5)*
          Modelica.Math.exp(BB[5]/T)/T^2;
        u_der := o[1]*moleFraction[3] + o[2]*p_der + o[3]*T_der;
      end U5_der;

      function U6_der "Derivative of reaction index for formation of NO"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MoleFraction[4] moleFraction "Mole fractions";
        input Real p_der "Derivative of pressure";
        input Real T_der "Derivative of temperature";
        input Real[4] moleFraction_der "Derivative of mole fractions";
        output Real u_der "Derivative of reaction index for NO";
      protected
        Real o[3];
      algorithm
        o[1] := 0.5*AA[6]/sqrt(moleFraction[2]*moleFraction[3])*moleFraction[3]
          *Modelica.Math.exp(BB[6]/T);
        o[2] := 0.5*AA[6]/sqrt(moleFraction[2]*moleFraction[3])*moleFraction[2]
          *Modelica.Math.exp(BB[6]/T);
        o[3] := BB[6]*AA[6]*sqrt(moleFraction[2]*moleFraction[3])*
          Modelica.Math.exp(BB[6]/T)/T^2;
        u_der := o[1]*moleFraction[2] + o[2]*moleFraction[3] + o[3]*T_der;
      end U6_der;

      function V2_der "Derivative of energy index for formation of H2"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Temperature T "Temperature";
        input Real T_der "Derivative of temperature";
        output Real v_der "Derivative energy index for H2";
      algorithm
        v_der := (-DD[2]/T^2 - 2*EE[2]/T^3)*T_der;

      end V2_der;

      function V3_der "Derivative energy index for formation of OH"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Temperature T "Temperature";
        input Real T_der "Derivative of temperature";
        output Real v_der "Derivative energy index for OH";
      algorithm
        v_der := (-DD[3]/T^2 - 2*EE[3]/T^3)*T_der;
      end V3_der;

      function V4_der "Derivative of energy index for formation of H"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Temperature T "Temperature";
        input Real T_der "Derivative of temperature";
        output Real v_der "Derivative energy index for H";

      algorithm
        v_der := (-DD[4]/T^2 - 2*EE[4]/T^3)*T_der;
      end V4_der;

      function V5_der "Derivative of energy index for formation of O"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Temperature T "Temperature";
        input Real T_der "Derivative of temperature";
        output Real v_der "Derivative energy index for O";
      algorithm
        v_der := (-DD[5]/T^2 - 2*EE[5]/T^3)*T_der;
      end V5_der;

      function V6_der "Derivative of energy index for formation of NO"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Temperature T "Temperature";
        input Real T_der "Derivative of temperature";
        output Real v_der "Derivative energy index for NO";
      algorithm
        v_der := (-DD[6]/T^2 - 2*EE[6]/T^3)*T_der;
      end V6_der;
    end ReactionIndices;

    package IF97_new "Workaround for IF97"
      extends Modelica.Icons.BasesPackage;

      final constant MolarMass molarMass=0.018015257;

      function g2 "Gibbs function for region 2: g(p,T)"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature (K)";
        output Modelica.Media.Common.GibbsDerivs g
          "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
      protected
        Real tau2 "Dimensionless temperature";
        Real[55] o "Vector of auxiliary variables";
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
          *(g.pi*(2.29220763376610e-6*o[14] + g.pi*((-1.67147664510610e-11 + o[
          15]*(-0.00211714723213550 - 23.8957419341040*o[16]))*o[2] + g.pi*(-5.9059564324270e-18
           + o[17]*(-1.26218088991010e-6 - 0.038946842435739*o[18]) + g.pi*(o[
          11]*(1.12562113604590e-11 - 8.2311340897998*o[19]) + g.pi*(
          1.98097128020880e-8*o[15] + g.pi*(o[10]*(1.04069652101740e-19 + (-1.02347470959290e-13
           - 1.00181793795110e-9*o[10])*o[20]) + o[23]*(o[13]*(-8.0882908646985e-11
           + 0.106930318794090*o[24]) + o[21]*(-0.33662250574171*o[26] + o[21]*
          (o[27]*(8.9185845355421e-25 + (3.06293168762320e-13 -
          4.2002467698208e-6*o[15])*o[28]) + g.pi*(-5.9056029685639e-26*o[24]
           + g.pi*(3.7826947613457e-6*o[29] + g.pi*(-1.27686089346810e-15*o[30]
           + o[31]*(7.3087610595061e-29 + o[18]*(5.5414715350778e-17 -
          9.4369707241210e-7*o[32]))*g.pi)))))))))))) + tau2*(-7.8847309559367e-10
           + (1.27907178522850e-8 + 4.8225372718507e-7*tau2)*tau2))))) + (-0.0056087911830200
           + g.tau*(0.071452738814550 + g.tau*(-0.40710498239280 + g.tau*(
          1.42408197144400 + g.tau*(-4.3839511194500 + g.tau*(-9.6927686002170
           + g.tau*(10.0866556801800 + (-0.284086326077200 + 0.0212684635330700
          *g.tau)*g.tau) + Modelica.Math.log(g.pi)))))))/(o[34]*g.tau);

        g.gpi := (1.00000000000000 + g.pi*(-0.00177317424732130 + o[9] + g.pi*(
          o[43] + g.pi*(6.1445213076927e-8 + (1.31612001853305e-6 + o[1]*(-0.000096833031715710
           + (-0.0045101773626444 - 0.122004760687947*o[13])*o[2]))*tau2 + g.pi
          *(g.pi*(0.0000114610381688305*o[14] + g.pi*((-1.00288598706366e-10 +
          o[15]*(-0.0127028833928130 - 143.374451604624*o[16]))*o[2] + g.pi*(-4.1341695026989e-17
           + o[17]*(-8.8352662293707e-6 - 0.272627897050173*o[18]) + g.pi*(o[11]
          *(9.0049690883672e-11 - 65.849072718398*o[19]) + g.pi*(
          1.78287415218792e-7*o[15] + g.pi*(o[10]*(1.04069652101740e-18 + (-1.02347470959290e-12
           - 1.00181793795110e-8*o[10])*o[20]) + o[23]*(o[13]*(-1.29412653835176e-9
           + 1.71088510070544*o[24]) + o[21]*(-6.0592051033508*o[26] + o[21]*(o[
          27]*(1.78371690710842e-23 + (6.1258633752464e-12 -
          0.000084004935396416*o[15])*o[28]) + g.pi*(-1.24017662339842e-24*o[24]
           + g.pi*(0.000083219284749605*o[29] + g.pi*(-2.93678005497663e-14*o[
          30] + o[31]*(1.75410265428146e-27 + o[18]*(1.32995316841867e-15 -
          0.0000226487297378904*o[32]))*g.pi)))))))))))) + tau2*(-3.15389238237468e-9
           + (5.1162871409140e-8 + 1.92901490874028e-6*tau2)*tau2))))))/g.pi;

        g.gpipi := (-1.00000000000000 + o[21]*(o[43] + g.pi*(
          1.22890426153854e-7 + (2.63224003706610e-6 + o[1]*(-0.000193666063431420
           + (-0.0090203547252888 - 0.244009521375894*o[13])*o[2]))*tau2 + g.pi
          *(g.pi*(0.000045844152675322*o[14] + g.pi*((-5.0144299353183e-10 + o[
          15]*(-0.063514416964065 - 716.87225802312*o[16]))*o[2] + g.pi*(-2.48050170161934e-16
           + o[17]*(-0.000053011597376224 - 1.63576738230104*o[18]) + g.pi*(o[
          11]*(6.3034783618570e-10 - 460.94350902879*o[19]) + g.pi*(
          1.42629932175034e-6*o[15] + g.pi*(o[10]*(9.3662686891566e-18 + (-9.2112723863361e-12
           - 9.0163614415599e-8*o[10])*o[20]) + o[23]*(o[13]*(-1.94118980752764e-8
           + 25.6632765105816*o[24]) + o[21]*(-103.006486756963*o[26] + o[21]*(
          o[27]*(3.3890621235060e-22 + (1.16391404129682e-10 -
          0.00159609377253190*o[15])*o[28]) + g.pi*(-2.48035324679684e-23*o[24]
           + g.pi*(0.00174760497974171*o[29] + g.pi*(-6.4609161209486e-13*o[30]
           + o[31]*(4.0344361048474e-26 + o[18]*(3.05889228736295e-14 -
          0.00052092078397148*o[32]))*g.pi)))))))))))) + tau2*(-9.4616771471240e-9
           + (1.53488614227420e-7 + o[44])*tau2)))))/o[21];

        g.gtau := (0.0280439559151000 + g.tau*(-0.285810955258200 + g.tau*(
          1.22131494717840 + g.tau*(-2.84816394288800 + g.tau*(4.3839511194500
           + o[33]*(10.0866556801800 + (-0.56817265215440 + 0.063805390599210*g.tau)
          *g.tau))))))/(o[33]*o[34]) + g.pi*(-0.0178348622923580 + o[49] + g.pi
          *(-0.000033032641670203 + (-0.00037897975032630 + o[1]*(-0.0157571108973420
           + (-0.306581069554011 - 0.00096028372490713*o[13])*o[2]))*tau2 + g.pi
          *(4.3870667284435e-7 + o[1]*(-0.000096833031715710 + (-0.0090203547252888
           - 1.42338887469272*o[13])*o[2]) + g.pi*(-7.8847309559367e-10 + g.pi*
          (0.0000160454534363627*o[20] + g.pi*(o[1]*(-5.0144299353183e-11 + o[
          15]*(-0.033874355714168 - 836.35096769364*o[16])) + g.pi*((-0.0000138839897890111
           - 0.97367106089347*o[18])*o[50] + g.pi*(o[14]*(9.0049690883672e-11
           - 296.320827232793*o[19]) + g.pi*(2.57526266427144e-7*o[51] + g.pi*(
          o[2]*(4.1627860840696e-19 + (-1.02347470959290e-12 -
          1.40254511313154e-8*o[10])*o[20]) + o[23]*(o[19]*(-2.34560435076256e-9
           + 5.3465159397045*o[24]) + o[21]*(-19.1874828272775*o[52] + o[21]*(o[
          16]*(1.78371690710842e-23 + (1.07202609066812e-11 -
          0.000201611844951398*o[15])*o[28]) + g.pi*(-1.24017662339842e-24*o[27]
           + g.pi*(0.000200482822351322*o[53] + g.pi*(-4.9797574845256e-14*o[54]
           + (1.90027787547159e-27 + o[18]*(2.21658861403112e-15 -
          0.000054734430199902*o[32]))*o[55]*g.pi)))))))))))) + (
          2.55814357045700e-8 + 1.44676118155521e-6*tau2)*tau2))));

        g.gtautau := (-0.168263735490600 + g.tau*(1.42905477629100 + g.tau*(-4.8852597887136
           + g.tau*(8.5444918286640 + g.tau*(-8.7679022389000 + o[33]*(-0.56817265215440
           + 0.127610781198420*g.tau)*g.tau)))))/(o[33]*o[34]*g.tau) + g.pi*(-0.091992027392730
           + (-0.34548755450059 - 1.50975836183790*o[2])*tau2 + g.pi*(-0.00037897975032630
           + o[1]*(-0.047271332692026 + (-1.83948641732407 - 0.033609930371750*
          o[13])*o[2]) + g.pi*((-0.000193666063431420 + (-0.045101773626444 -
          48.395221739552*o[13])*o[2])*tau2 + g.pi*(2.55814357045700e-8 +
          2.89352236311042e-6*tau2 + g.pi*(0.000096272720618176*o[10]*tau2 + g.pi
          *((-1.00288598706366e-10 + o[15]*(-0.50811533571252 -
          28435.9329015838*o[16]))*tau2 + g.pi*(o[11]*(-0.000138839897890111 -
          23.3681054614434*o[18])*tau2 + g.pi*((6.3034783618570e-10 -
          10371.2289531477*o[19])*o[20] + g.pi*(3.09031519712573e-6*o[17] + g.pi
          *(o[1]*(1.24883582522088e-18 + (-9.2112723863361e-12 -
          1.82330864707100e-7*o[10])*o[20]) + o[23]*(o[1]*o[11]*o[12]*(-6.5676921821352e-8
           + 261.979281045521*o[24])*tau2 + o[21]*(-1074.49903832754*o[1]*o[10]
          *o[12]*o[25]*tau2 + o[21]*((3.3890621235060e-22 + (
          3.6448887082716e-10 - 0.0094757567127157*o[15])*o[28])*o[32] + g.pi*(
          -2.48035324679684e-23*o[16] + g.pi*(0.0104251067622687*o[1]*o[12]*o[
          25]*tau2 + g.pi*(o[11]*o[12]*(4.7506946886790e-26 + o[18]*(
          8.6446955947214e-14 - 0.00311986252139440*o[32]))*g.pi -
          1.89230784411972e-12*o[10]*o[25]*tau2))))))))))))))));

        g.gtaupi := -0.0178348622923580 + o[49] + g.pi*(-0.000066065283340406
           + (-0.00075795950065260 + o[1]*(-0.0315142217946840 + (-0.61316213910802
           - 0.00192056744981426*o[13])*o[2]))*tau2 + g.pi*(1.31612001853305e-6
           + o[1]*(-0.000290499095147130 + (-0.0270610641758664 -
          4.2701666240781*o[13])*o[2]) + g.pi*(-3.15389238237468e-9 + g.pi*(
          0.000080227267181813*o[20] + g.pi*(o[1]*(-3.00865796119098e-10 + o[15]
          *(-0.203246134285008 - 5018.1058061618*o[16])) + g.pi*((-0.000097187928523078
           - 6.8156974262543*o[18])*o[50] + g.pi*(o[14]*(7.2039752706938e-10 -
          2370.56661786234*o[19]) + g.pi*(2.31773639784430e-6*o[51] + g.pi*(o[2]
          *(4.1627860840696e-18 + (-1.02347470959290e-11 - 1.40254511313154e-7*
          o[10])*o[20]) + o[23]*(o[19]*(-3.7529669612201e-8 + 85.544255035272*o[
          24]) + o[21]*(-345.37469089099*o[52] + o[21]*(o[16]*(
          3.5674338142168e-22 + (2.14405218133624e-10 - 0.0040322368990280*o[15])
          *o[28]) + g.pi*(-2.60437090913668e-23*o[27] + g.pi*(
          0.0044106220917291*o[53] + g.pi*(-1.14534422144089e-12*o[54] + (
          4.5606669011318e-26 + o[18]*(5.3198126736747e-14 -
          0.00131362632479764*o[32]))*o[55]*g.pi)))))))))))) + (
          1.02325742818280e-7 + o[44])*tau2)));
      end g2;

      function h_pT "Specific enthalpy as function or pressure and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Integer region=0
          "If 0, region is unknown, otherwise known and this input";
        output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";

      protected
        Modelica.Media.Common.GibbsDerivs g;

      algorithm
        g := Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.g2(p, T);
        h := g.R*T*g.tau*g.gtau;
        annotation (
          derivative(noDerivative=region) = h_pT_der,
          Inline=false,
          LateInline=true);
      end h_pT;

      function s_pT "Temperature as function of pressure and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Integer region=0
          "If 0, region is unknown, otherwise known and this input";
        output Modelica.SIunits.SpecificEntropy s "Specific entropy";

      protected
        Modelica.Media.Common.GibbsDerivs g;

      algorithm
        g := Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.g2(p, T);
        s := g.R*(g.tau*g.gtau - g.g);
      end s_pT;

      function cp_pT
        "Specific heat capacity at constant pressure as function of pressure and temperature"

        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Integer region=0
          "If 0, region is unknown, otherwise known and this input";
        output Modelica.SIunits.SpecificHeatCapacity cp
          "Specific heat capacity";

      protected
        Modelica.Media.Common.GibbsDerivs g;

      algorithm
        g := Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.g2(p, T);
        cp := -g.R*g.tau*g.tau*g.gtautau;
      end cp_pT;

      function cv_pT
        "Specific heat capacity at constant volume as function of pressure and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Integer region=0
          "If 0, region is unknown, otherwise known and this input";
        output Modelica.SIunits.SpecificHeatCapacity cv
          "Specific heat capacity";

      protected
        Modelica.Media.Common.GibbsDerivs g;

      algorithm
        g := Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.g2(p, T);
        cv := g.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi -
          g.tau*g.gtaupi)/g.gpipi));
      end cv_pT;

      function rho_pT "Density as function or pressure and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.Density rho "Density";

      protected
        Modelica.Media.Common.GibbsDerivs g;

      algorithm
        g := Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.g2(p, T);
        rho := p/(g.R*T*g.pi*g.gpi);
        annotation (
          derivative=rho_pT_der,
          Inline=false,
          LateInline=true);
      end rho_pT;

      function rho_pT_der "Derivative function of rho_pT"
        extends Modelica.Icons.Function;
        input SI.Pressure p "Pressure";
        input SI.Temperature T "Temperature";
        input Real p_der "Derivative of pressure";
        input Real T_der "Derivative of temperature";
        output Real rho_der "Derivative of density";
      protected
        Modelica.Media.Common.GibbsDerivs g;
        SI.Density d;
        Real vp;
        Real vt;
      algorithm
        g := Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.g2(p, T);
        vt := g.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
        vp := g.R*T/(p*p)*g.pi*g.pi*g.gpipi;
        d := p/(g.R*T*g.pi*g.gpi);
        rho_der := (-d^2*vp)*p_der + (-d^2*vt)*T_der;
      end rho_pT_der;

      function visc_dT "Dynamic viscosity eta(d,T), industrial formulation"
        extends Modelica.Icons.Function;
        input SI.Density d "Density";
        input SI.Temperature T "Temperature (K)";
        output SI.DynamicViscosity eta "Dynamic viscosity";
      protected
        constant Real n0=1.0 "Viscosity coefficient";
        constant Real n1=0.978197 "Viscosity coefficient";
        constant Real n2=0.579829 "Viscosity coefficient";
        constant Real n3=-0.202354 "Viscosity coefficient";
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
                  0.0) "Viscosity coefficients";
        constant SI.Density rhostar=317.763 "Scaling density";
        constant SI.DynamicViscosity etastar=55.071e-6 "Scaling viscosity";
        constant SI.Temperature tstar=647.226 "Scaling temperature";
        Integer i "Auxiliary variable";
        Integer j "Auxiliary variable";
        Real delta "Dimensionless density";
        Real deltam1 "Dimensionless density";
        Real tau "Dimensionless temperature";
        Real taum1 "Dimensionless temperature";
        Real Psi0 "Auxiliary variable";
        Real Psi1 "Auxiliary variable";
        Real tfun "Auxiliary variable";
        Real rhofun "Auxiliary variable";
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
        input SI.Density d "Density";
        input SI.Temperature T "Temperature (K)";
        output SI.ThermalConductivity lambda "Thermal conductivity";
      protected
        Integer region(min=1, max=5) "IF97 region, valid values:1,2,3, and 5";
        constant Real n0=1.0 "Conductivity coefficient";
        constant Real n1=6.978267 "Conductivity coefficient";
        constant Real n2=2.599096 "Conductivity coefficient";
        constant Real n3=-0.998254 "Conductivity coefficient";
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
                  0.0) "Conductivity coefficient";
        constant SI.ThermalConductivity lamstar=0.4945 "Scaling conductivity";
        constant SI.Density rhostar=317.763 "Scaling density";
        constant SI.Temperature tstar=647.226 "Scaling temperature";
        constant SI.Pressure pstar=22.115e6 "Scaling pressure";
        constant SI.DynamicViscosity etastar=55.071e-6 "Scaling viscosity";
        Integer i "Auxiliary variable";
        Integer j "Auxiliary variable";
        Real delta "Dimensionless density";
        Real tau "Dimensionless temperature";
        Real deltam1 "Dimensionless density";
        Real taum1 "Dimensionless temperature";
        Real Lam0 "Part of thermal conductivity";
        Real Lam1 "Part of thermal conductivity";
        Real Lam2 "Part of thermal conductivity";
        Real tfun "Auxiliary variable";
        Real rhofun "Auxiliary variable";
        Real dpitau "Auxiliary variable";
        Real ddelpi "Auxiliary variable";
        Real d2 "Auxiliary variable";
        Modelica.Media.Common.GibbsDerivs g
          "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
        Modelica.Media.Common.HelmholtzDerivs f
          "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
        Real Tc=T - 273.15 "Celsius temperature for region check";
        Real Chi "Symmetrized compressibility";
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
          "Function, part of the interpolating equation of the thermal conductivity";
        Real lambdaREL1
          "Function, part of the interpolating equation of the thermal conductivity";
        Real lambdaREL0
          "Function, part of the interpolating equation of the thermal conductivity";
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
        lambdaREL1 := b[1] + b[2]*rhoREL + b[3]*Modelica.Math.exp(B[1]*(rhoREL
           + B[2])^2);
        lambdaREL0 := TREL^(1/2)*sum(a[i]*TREL^(i - 1) for i in 1:4);
        lambdaREL := lambdaREL0 + lambdaREL1 + lambdaREL2;
        lambda := lambdaREL*lambdastar;
      end cond_dT;

      function h_pT_der "Derivative function of h_pT"
        extends Modelica.Icons.Function;
        input SI.Pressure p "Pressure";
        input SI.Temperature T "Temperature";
        input Integer region=0
          "If 0, region is unknown, otherwise known and this input";
        input Real p_der "Derivative of pressure";
        input Real T_der "Derivative of temperature";
        output Real h_der "Derivative of specific enthalpy";
      protected
        Modelica.Media.Common.GibbsDerivs g;
        SI.Density rho;
        Real vt;

      algorithm
        //region 2
        g := Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.g2(p, T);
        vt := g.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
        rho := max(p/(g.R*T*g.pi*g.gpi), 1e-9);
        h_der := (1/rho - T*vt)*p_der - g.R*g.tau*g.tau*g.gtautau*T_der;

      end h_pT_der;
    end IF97_new;

    package Water95_Utilities
      "Utility functions from IAPWS95 required for air temperatures below 273.15 K"
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

      constant Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants
        waterConstants(
        chemicalFormula="H2O",
        structureFormula="H2O",
        casRegistryNumber="7732-18-5",
        iupacName="oxidane",
        molarMass=0.018015268,
        criticalTemperature=647.096,
        criticalPressure=22064.0e3,
        criticalMolarVolume=1/322.0*0.018015268,
        triplePointTemperature=273.16,
        triplePointPressure=611.657,
        normalBoilingPoint=373.124,
        meltingPoint=273.15,
        acentricFactor=0.344,
        dipoleMoment=1.8,
        hasCriticalData=true,
        hasIdealGasHeatCapacity=false,
        hasDipoleMoment=true,
        hasFundamentalEquation=true,
        hasLiquidHeatCapacity=true,
        hasSolidHeatCapacity=false,
        hasAccurateViscosityData=true,
        hasAccurateConductivityData=true,
        hasVapourPressureCurve=false,
        hasAcentricFactor=true,
        HCRIT0=0.0,
        SCRIT0=0.0,
        deltah=0.0,
        deltas=0.0);

      function psat "Saturation pressure"
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

      function Tsat "Saturation temperature"
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

      function psat_der "Saturation pressure"
        extends Modelica.Icons.Function;

        input SI.Temperature T "Temperature";
        input Real T_der "Derivative of temperature";
        output Real p_der "Derivative of pressure w.r.t. temperature";

      protected
        Real theta_s,        theta_s_der;
        Real A,        A_der;
        Real B,        B_der;
        Real C,        C_der,        o_der[3];
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

      function Tsat_der "Derivative of saturation temperature"
        extends Modelica.Icons.Function;

        input SI.AbsolutePressure p "Pressure";
        input Real p_der "Pressure derivative";
        output Real T_der "Temperature derivative";

      protected
        Real beta,        beta_der;
        Real D,        D_der;
        Real E,        E_der;
        Real F,        F_der;
        Real G,        G_der;
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
    end Water95_Utilities;

    package Ice09_Utilities
      "Utility functions from IAPWS09 required for ice in air"
      extends Modelica.Icons.BasesPackage;

      package Basic "Fundamental equation of state"
        extends Modelica.Icons.BasesPackage;

        record IceConstants
          extends Common.FundamentalConstants;
          Modelica.SIunits.AbsolutePressure p0;
        end IceConstants;

      protected
        record MyComplex "Complex number with function"
          extends Modelica.Icons.Record;
          Real re "Real part of complex number" annotation (Dialog);
          Real im "Imaginary part of complex number" annotation (Dialog);
        end MyComplex;

        package MyComplexF
          extends Modelica.Icons.FunctionsPackage;
          function toReal "Extract Real part from Complex number"
            extends Modelica.Icons.Function;
            input MyComplex c "Complex number";
            output Real result=c.re "Real number";
          algorithm

            annotation (Inline=true, Documentation(info="<html>
<p>This function returns the real part of a complex number.</p>
</html>"));
          end toReal;

          function '-' "Subtract two complex numbers"
            extends Modelica.Icons.Function;
            input MyComplex c1 "Complex number 1";
            input MyComplex c2 "Complex number 2";
            output MyComplex c3 "= c1 - c2";
          algorithm
            c3 := MyComplex(c1.re - c2.re, c1.im - c2.im);
            annotation (Inline=true,Documentation(info="<html>
<p>This function returns the difference of two given Complex numbers.</p>
</html>"));
          end '-';

          function '*' "Multiplication"
            extends Modelica.Icons.Function;
            input MyComplex c1 "Complex number 1";
            input MyComplex c2 "Complex number 2";
            output MyComplex c3 "= c1*c2";
          algorithm
            c3 := MyComplex(c1.re*c2.re - c1.im*c2.im, c1.re*c2.im + c1.im*c2.re);

            annotation (Inline=true, Documentation(info="<html>
<p>This function returns the product of two given Complex numbers.</p>
</html>"));
          end '*';

          function '+' "Add two complex numbers"
            extends Modelica.Icons.Function;
            input MyComplex c1 "Complex number 1";
            input MyComplex c2 "Complex number 2";
            output MyComplex c3 "= c1 + c2";
          algorithm
            c3 := MyComplex(c1.re + c2.re, c1.im + c2.im);
            annotation (Inline=true,Documentation(info="<html>
<p>This function returns the sum of two given Complex numbers.</p>
</html>"));
          end '+';

          function '/' "Divide two complex numbers"
            extends Modelica.Icons.Function;
            input MyComplex c1 "Complex number 1";
            input MyComplex c2 "Complex number 2";
            output MyComplex c3 "= c1/c2";
          algorithm
            c3 := MyComplex((+c1.re*c2.re + c1.im*c2.im)/(c2.re*c2.re + c2.im*
              c2.im), (-c1.re*c2.im + c1.im*c2.re)/(c2.re*c2.re + c2.im*c2.im));
            annotation (Inline=true,Documentation(info="<html>
<p>This function returns the quotient of two given Complex numbers.</p>
</html>"));
          end '/';

          function '^' "Complex power of complex number"
            extends Modelica.Icons.Function;
            input MyComplex c1 "Complex number";
            input MyComplex c2 "Complex exponent";
            output MyComplex c3 "= c1^c2";
          protected
            Real lnz=0.5*log(c1.re*c1.re + c1.im*c1.im);
            Real phi=atan2(c1.im, c1.re);
            Real re=lnz*c2.re - phi*c2.im;
            Real im=lnz*c2.im + phi*c2.re;
          algorithm
            c3 := MyComplex(exp(re)*cos(im), exp(re)*sin(im));
            annotation (Inline=true,Documentation(info="<html>
<p>This function returns the given Complex numbers c1 to the power of the Complex number c2.</p>
</html>"));
          end '^';

          function 'log' "Logarithm of complex number"
            extends Modelica.Icons.Function;
            import Modelica.Math.atan3;
            input MyComplex c1 "Complex number";
            output MyComplex c2 "= log(c1)";
          protected
            Real phi=atan3(
                          c1.im,
                          c1.re,
                          0);
          algorithm
            c2 := MyComplex(log((c1.re^2 + c1.im^2)^0.5), phi);
            annotation (Inline=true,Documentation(info="<html>
<p>This function returns the Complex natural logarithm of the Complex input.</p>
</html>"));
          end 'log';
        end MyComplexF;
      public
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
            "Gibbs function and derivatives w.r.t. T and p";

        protected
          final constant Real[5] g_0={-0.632020233449497E+006,0.655022213658955,
              -0.189369929326131E-007,0.339746123271053E-014,-0.556464869058991E-021}
            "Coefficients of EOS";
          final constant Real s_0=-0.332733756492168E+004 "Coefficient of EOS";
          final MyComplex[2] t={MyComplex(0.368017112855051E-001,
              0.510878114959572E-001),MyComplex(0.337315741065416,
              0.335449415919309)} "Coefficients of EOS";
          final constant MyComplex r_1=MyComplex(0.447050716285388E+002,
              0.656876847463481E+002) "Coefficients of EOS";
          final MyComplex[3] r_2={MyComplex(-0.725974574329220E+002, -0.781008427112870E+002),
              MyComplex(-0.557107698030123E-004, 0.464578634580806E-004),
              MyComplex(0.234801409215913E-010, -0.285651142904972E-010)}
            "Coefficients of EOS";
          final Real pi0=Constants.p0/Constants.pred "Reduced pressure";

          //temporary variables needed for calculation
          Real g0=0.0 "Help variable";
          Real g0p=0.0 "Help variable";
          Real g0pp=0.0 "Help variable";
          MyComplex r2 "Help variable";
          MyComplex r2p "Help variable";
          MyComplex r2pp "Help variable";
          MyComplex o[12] "Help variable";

        algorithm
          g.p := p;
          g.T := T;
          g.R := Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.R;

          //Reduced pressure
          g.pi := g.p/Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.pred;
          //Reduced temperature
          g.theta := g.T/Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.Tred;

          //calculate temporary values
          //0^0 may result in an error, so we have to use a workaround
          g0 := g_0[1];
          for k in 2:5 loop
            g0 := g0 + g_0[k]*(g.pi - pi0)^(k - 1);
          end for;
          r2 := r_2[1];
          for k in 2:3 loop
            r2 := MyComplexF.'+'(r2, MyComplexF.'*'(r_2[k], MyComplex((g.pi - pi0)
              ^(k - 1), 0)));
          end for;

          //First derivative of g0 w.r.t. pi
          g0p := g_0[2]/Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.pred;
          for k in 3:5 loop
            g0p := g0p + g_0[k]*(k - 1)/Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.pred
              *(g.pi - pi0)^(k - 2);
          end for;
          //First derivative of r2 w.r.t. pi
          r2p := MyComplexF.'+'(MyComplexF.'/'(r_2[2], MyComplex(Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.
             pred, 0)), MyComplexF.'*'(MyComplexF.'/'(r_2[3], MyComplex(Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.
             pred/2, 0)), MyComplex(g.pi - pi0, 0)));
          //Second derivative of g0 w.r.t. pi
          g0pp := g_0[3]*2/Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.pred
            ^2;
          for k in 4:5 loop
            g0pp := g0pp + g_0[k]*(k - 1)*(k - 2)/Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.pred
              ^2*(g.pi - pi0)^(k - 3);
          end for;
          //Second derivative of g0 w.r.t. pi
          r2pp := MyComplexF.'*'(r_2[3], MyComplex(2/Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.pred
            ^2, 0));

          o[1] := MyComplexF.'*'(MyComplexF.'-'(t[1], MyComplex(g.theta, 0)),
            MyComplexF.'log'(MyComplexF.'-'(t[1], MyComplex(g.theta, 0))));
          o[2] := MyComplexF.'*'(MyComplexF.'+'(t[1], MyComplex(g.theta, 0)),
            MyComplexF.'log'(MyComplexF.'+'(t[1], MyComplex(g.theta, 0))));
          o[3] := MyComplexF.'*'(MyComplexF.'-'(t[2], MyComplex(g.theta, 0)),
            MyComplexF.'log'(MyComplexF.'-'(t[2], MyComplex(g.theta, 0))));
          o[4] := MyComplexF.'*'(MyComplexF.'+'(t[2], MyComplex(g.theta, 0)),
            MyComplexF.'log'(MyComplexF.'+'(t[2], MyComplex(g.theta, 0))));
          o[5] := MyComplexF.'*'(MyComplexF.'*'(MyComplex(2, 0), t[1]),
            MyComplexF.'log'(t[1]));
          o[6] := MyComplexF.'*'(MyComplexF.'*'(MyComplex(2, 0), t[2]),
            MyComplexF.'log'(t[2]));
          o[7] := MyComplexF.'/'(MyComplex(g.theta^2, 0), t[1]);
          o[8] := MyComplexF.'/'(MyComplex(g.theta^2, 0), t[2]);
          o[9] := MyComplexF.'-'(MyComplexF.'-'(MyComplexF.'+'(o[1], o[2]), o[5]),
            o[7]);
          o[10] := MyComplexF.'-'(MyComplexF.'-'(MyComplexF.'+'(o[3], o[4]), o[6]),
            o[8]);

          //   //Gibbs equation
          //   g.g := g0 - s_0*Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.Tred
          //     *g.theta + Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.Tred
          //     *GibbsComplex.fromReal(r_1*((t[1] - g.theta)*GibbsComplexMath.log(t[1] - g.theta)
          //      + (t[1] + g.theta)*GibbsComplexMath.log(t[1] + g.theta) - 2*t[1]*
          //     GibbsComplexMath.log(t[1]) - g.theta^2/t[1]) + r2*((t[2] - g.theta)*
          //     GibbsComplexMath.log(t[2] - g.theta) + (t[2] + g.theta)*
          //     GibbsComplexMath.log(t[2] + g.theta) - 2*t[2]*GibbsComplexMath.log(t[2]) -
          //     g.theta^2/t[2]));

          //   //Gibbs equation
          g.g := g0 - s_0*Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.Tred
            *g.theta + Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.Tred
            *MyComplexF.toReal(MyComplexF.'+'(MyComplexF.'*'(r_1, o[9]),
            MyComplexF.'*'(r2, o[10])));

          // //First derivative of g w.r.t. p
          // g.gp := g0p + MoMoLib.Water.IAPWS09.Ice09_Utilities.Basic.Constants.Tred*
          //   ComplexMath.real(r2p*((t[2] - g.theta)*ComplexMath.log(t[2] - g.theta) + (t[
          //   2] + g.theta)*ComplexMath.log(t[2] + g.theta) - 2*t[2]*ComplexMath.log(t[2])
          //    - g.theta^2/t[2]));

          // //First derivative of g w.r.t. p
          g.gp := g0p + Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.Tred
            *MyComplexF.toReal(MyComplexF.'*'(r2p, o[10]));

          //   //Second derivative of g w.r.t. p
          //   g.gpp := g0pp + Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.Tred
          //     *GibbsComplex.fromReal(r2pp*((t[2] - g.theta)*GibbsComplexMath.log(t[2] - g.theta)
          //      + (t[2] + g.theta)*GibbsComplexMath.log(t[2] + g.theta) - 2*t[2]*
          //     GibbsComplexMath.log(t[2]) - g.theta^2/t[2]));

          // //Second derivative of g w.r.t. p
          g.gpp := g0pp + Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.Tred
            *MyComplexF.toReal(MyComplexF.'*'(r2pp, o[10]));

          //   //First derivative of g w.r.t. T
          //   g.gT := -s_0 + GibbsComplex.fromReal(r_1*(
          //      + GibbsComplexMath.log(t[1] + g.theta) - 2*g.theta/t[1] -GibbsComplexMath.log(t[1] - g.theta)) + r2*(-
          //     GibbsComplexMath.log(t[2] - g.theta) + GibbsComplexMath.log(t[2] + g.theta) -
          //     2*g.theta/t[2]));

          o[11] := MyComplexF.'-'(MyComplexF.'-'(MyComplexF.'log'(MyComplexF.'+'(t[
            1], MyComplex(g.theta, 0))), MyComplexF.'/'(MyComplex(2*g.theta, 0),
            t[1])), MyComplexF.'log'(MyComplexF.'-'(t[1], MyComplex(g.theta, 0))));

          o[12] := MyComplexF.'-'(MyComplexF.'-'(MyComplexF.'log'(MyComplexF.'+'(t[
            2], MyComplex(g.theta, 0))), MyComplexF.'log'(MyComplexF.'-'(t[2],
            MyComplex(g.theta, 0)))), MyComplexF.'/'(MyComplex(2*g.theta, 0), t[
            2]));

          //   //First derivative of g w.r.t. T
          g.gT := -s_0 + MyComplexF.toReal(MyComplexF.'+'(MyComplexF.'*'(r_1, o[11]),
            MyComplexF.'*'(r2, o[12])));

          //   //Second derivative of g w.r.t. T
          //   g.gTT := 1/Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.Tred
          //     *GibbsComplex.fromReal(r_1*(1/(t[1] - g.theta) + 1/(t[1] + g.theta) - 2/t[1])
          //      + r2*(1/(t[2] - g.theta) + 1/(t[2] + g.theta) - 2/t[2]));

          //   //Second derivative of g w.r.t. T
          g.gTT := 1/Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.Tred
            *MyComplexF.toReal(MyComplexF.'+'(MyComplexF.'*'(r_1, MyComplexF.'-'(
            MyComplexF.'+'(MyComplexF.'/'(MyComplex(1, 0), MyComplexF.'-'(t[1],
            MyComplex(g.theta, 0))), MyComplexF.'/'(MyComplex(1, 0),
            MyComplexF.'+'(t[1], MyComplex(g.theta, 0)))), MyComplexF.'/'(
            MyComplex(2, 0), t[1]))), MyComplexF.'*'(r2, MyComplexF.'-'(
            MyComplexF.'+'(MyComplexF.'/'(MyComplex(1, 0), MyComplexF.'-'(t[2],
            MyComplex(g.theta, 0))), MyComplexF.'/'(MyComplex(1, 0),
            MyComplexF.'+'(t[2], MyComplex(g.theta, 0)))), MyComplexF.'/'(
            MyComplex(2, 0), t[2])))));

          //  //Mixed derivative of g w.r.t. T and p
          // g.gTp := ComplexMath.real(r2p*(-ComplexMath.log(t[2] - g.theta) +
          //   ComplexMath.log(t[2] + g.theta) - 2*g.theta/t[2]));

          //  //Mixed derivative of g w.r.t. T and p
          g.gTp := MyComplexF.toReal(MyComplexF.'*'(r2p, MyComplexF.'-'(
            MyComplexF.'log'(MyComplexF.'+'(t[2], MyComplex(g.theta, 0))),
            MyComplexF.'+'(MyComplexF.'/'(MyComplex(2*g.theta, 0), t[2]),
            MyComplexF.'log'(MyComplexF.'-'(t[2], MyComplex(g.theta, 0)))))));

        end Gibbs;

        function psub "Sublimation pressure"
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
          theta := T/Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.Tred;

          for k in 1:3 loop
            sum := sum + a[k]*theta^b[k];
          end for;

          p_sub := exp(sum/theta)*Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.pred;
          annotation (
            derivative=psub_der,
            Inline=false,
            LateInline=true);
        end psub;

        function Tsub "Sublimation temperature"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure p "Pressure";
          output Modelica.SIunits.Temperature T_sub "Temperature";

        protected
          function Tsub_res
            extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
            input Modelica.SIunits.AbsolutePressure p "Pressure";

          algorithm
            y :=
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.psub(
              u) - p;

          end Tsub_res;

        algorithm
          T_sub := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
                    function Tsub_res(p=p),
                    143.15,
                    2000.0,
                    1e-9);
        end Tsub;

        function psub_der "Derivative of sublimation pressure"
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
          theta := T/Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.Tred;
          theta_der := 1/Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.Tred;

          for k in 1:3 loop
            sum := sum + a[k]*theta^b[k];
            sum_der := sum_der + a[k]*b[k]*theta^(b[k] - 1)*theta_der;
          end for;

          p_sub_der := (sum_der*theta - sum*theta_der)/theta^2*exp(sum/theta)*
            Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.pred
            *T_der;

        end psub_der;

      end Basic;

      function ice09BaseProp_pT
        "Intermediate property record for water (p and T preferred states)"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        output Common.AuxiliaryProperties aux "Auxiliary record";
      protected
        Common.GibbsDerivs2 g "Gibbs function and derivatives w.r.t. p and T";
      algorithm
        aux.p := p;
        aux.T := T;
        aux.R := Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.R;
        g := Basic.Gibbs(aux.p, T);
        aux.rho := 1/g.gp;
        aux.h := g.g - g.T*g.gT - Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.h_off;
        aux.s := -g.gT - Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.s_off;
        aux.cp := -g.T*g.gTT;
        aux.cv := aux.cp - g.T/g.gpp*g.gTp^2;
        aux.vt := 1/aux.rho*g.gTp/g.gp;
        aux.vp := 1/aux.rho*g.gpp/g.gp;
        aux.pd := -1/(aux.rho*aux.rho*aux.vp);
        aux.pt := -aux.vt/aux.vp;
      end ice09BaseProp_pT;

      function rho_props_pT "Density as function or pressure and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Common.AuxiliaryProperties aux "Auxiliary record";
        output Modelica.SIunits.Density rho "Density";
      algorithm
        rho := aux.rho;
        annotation (
          derivative(noDerivative=aux) = rho_pT_der,
          Inline=false,
          LateInline=true);
      end rho_props_pT;

      function rho_pT "Density as function or pressure and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.Density rho "Density";
      algorithm
        rho := rho_props_pT(
                p,
                T,
            Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
            p, T));

      end rho_pT;

      function rho_pT_der "Derivative function of rho_pT"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Common.AuxiliaryProperties aux "Auxiliary record";
        input Real p_der "Derivative of pressure";
        input Real T_der "Derivative of temperature";
        output Real rho_der "Derivative of density";
      algorithm
        rho_der := (-aux.rho*aux.rho*aux.vp)*p_der + (-aux.rho*aux.rho*aux.vt)*
          T_der;
      end rho_pT_der;

      function h_props_pT
        "Specific enthalpy as function or pressure and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Common.AuxiliaryProperties aux "Auxiliary record";
        output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := aux.h;
        annotation (
          derivative(noDerivative=aux) = h_pT_der,
          Inline=false,
          LateInline=true);
      end h_props_pT;

      function h_pT "Specific enthalpy as function or pressure and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := h_props_pT(
                p,
                T,
            Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
            p, T));

      end h_pT;

      function h_pT_der "Derivative function of h_pT"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Common.AuxiliaryProperties aux "Auxiliary record";
        input Real p_der "Derivative of pressure";
        input Real T_der "Derivative of temperature";
        output Real h_der "Derivative of specific enthalpy";
      algorithm
        h_der := (1/aux.rho - aux.T*aux.vt)*p_der + aux.cp*T_der;
      end h_pT_der;

      function s_props_pT
        "Specific entropy as function of pressure and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Common.AuxiliaryProperties aux "Auxiliary record";
        output Modelica.SIunits.SpecificEntropy s "Specific entropy";
      algorithm
        s := aux.s;
        annotation (Inline=false, LateInline=true);
      end s_props_pT;

      function s_pT "Temperature as function of pressure and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.SpecificEntropy s "Specific entropy";
      algorithm
        s := s_props_pT(
                p,
                T,
            Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
            p, T));

      end s_pT;

      function kappa_props_pT
        "Isothermal compressibility factor as function of pressure and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        input Common.AuxiliaryProperties aux "Auxiliary record";
        output Modelica.SIunits.IsothermalCompressibility kappa
          "Isothermal compressibility factor";
      algorithm
        kappa := -aux.vp*aux.rho;
        annotation (Inline=false, LateInline=true);
      end kappa_props_pT;

      function kappa_pT
        "Isothermal compressibility factor as function of pressure and temperature"
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Pressure p "Pressure";
        input Modelica.SIunits.Temperature T "Temperature";
        output Modelica.SIunits.IsothermalCompressibility kappa
          "Isothermal compressibility factor";
      algorithm
        kappa := kappa_props_pT(
                p,
                T,
            Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
            p, T));

      end kappa_pT;

    end Ice09_Utilities;

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
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Tsat(
          p))) then
        beta_H := 0;
      else
        for k in 1:3 loop
          beta[k] :=
            Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
            T)*exp(A[k]/Tr + B[k]*tau^(0.355)/Tr + C[k]*Tr^(-0.41)*exp(tau));
        end for;
        beta_H := 1/1.01325*(psi[1]/beta[1] + psi[2]/beta[2] + psi[3]/beta[3]);
      end if;
    end beta_H;

    function f_pT "Enhancement factor as function of pressure and temperature"
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
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
          T) else
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.psub(
          T);

        //kappa_T is the isothermal compressibility
        if (p < p_ws) then
          kappa_T := 0;
        else
          kappa_T := if (T >= 273.16) then
            Modelica.Media.Water.IF97_Utilities.kappa_pT(p, T) else
            Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.kappa_pT(
            p, T);
        end if;

        //v_ws is the molar volume of saturated water
        v_ws := if (T >= 273.16) then Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.molarMass
          /Modelica.Media.Water.IF97_Utilities.rho_pT(p, T) else Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Constants.
           MM/
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.rho_pT(
          p, T);

        //beta_H is Henry's law constant
        beta_H := Modelica.Media.Air.ReferenceMoistAir.Utilities.beta_H(p, T);

        //calculating the virial coefficients baa, baw, bww, caaa, caaw, caww, cwww
        baa :=
          Modelica.Media.Air.ReferenceMoistAir.Utilities.VirialCoefficients.Baa_dT(
          0, T);
        baw :=
          Modelica.Media.Air.ReferenceMoistAir.Utilities.VirialCoefficients.Baw_dT(
          0, T);
        bww :=
          Modelica.Media.Air.ReferenceMoistAir.Utilities.VirialCoefficients.Bww_dT(
          0, T);
        caaa :=
          Modelica.Media.Air.ReferenceMoistAir.Utilities.VirialCoefficients.Caaa_dT(
          0, T);
        caaw :=
          Modelica.Media.Air.ReferenceMoistAir.Utilities.VirialCoefficients.Caaw_dT(
          0, T);
        caww :=
          Modelica.Media.Air.ReferenceMoistAir.Utilities.VirialCoefficients.Caww_dT(
          0, T);
        cwww :=
          Modelica.Media.Air.ReferenceMoistAir.Utilities.VirialCoefficients.Cwww_dT(
          0, T);

        y := ((1 + kappa_T*p_ws)*(p - p_ws) - kappa_T*(p^2 - p_ws^2)/2)/(R_bar*
          T)*v_ws + log(1 - beta_H*(1 - x*p_ws/p)*p) + (1 - x*p_ws/p)^2*p/(
          R_bar*T)*baa - 2*(1 - x*p_ws/p)^2*p/(R_bar*T)*baw - (p - p_ws - (1 -
          x*p_ws/p)^2*p)/(R_bar*T)*bww + (1 - x*p_ws/p)^3*p^2/(R_bar*T)^2*caaa
           + 3*(1 - x*p_ws/p)^2*(1 - 2*(1 - x*p_ws/p))*p^2/(2*(R_bar*T)^2)*caaw
           - 3*(1 - x*p_ws/p)^2*x*p_ws/p*p^2/(R_bar*T)^2*caww - ((3 - 2*x*p_ws/
          p)*(x*p_ws/p)^2*p^2 - p_ws^2)/(2*(R_bar*T)^2)*cwww - (1 - x*p_ws/p)^2
          *(-2 + 3*x*p_ws/p)*x*p_ws/p*p^2/(R_bar*T)^2*baa*bww - 2*(1 - x*p_ws/p)
          ^3*(-1 + 3*x*p_ws/p)*p^2/(R_bar*T)^2*baa*baw + 6*(1 - x*p_ws/p)^2*(x*
          p_ws/p)^2*p^2/(R_bar*T)^2*bww*baw - 3*(1 - x*p_ws/p)^4*p^2/(2*(R_bar*
          T)^2)*baa^2 - 2*(1 - x*p_ws/p)^2*x*p_ws/p*(-2 + 3*x*p_ws/p)*p^2/(
          R_bar*T)^2*baw^2 - (p_ws^2 - (4 - 3*x*p_ws/p)*(x*p_ws/p)^3*p^2)/(2*(
          R_bar*T)^2)*bww^2 - log(x);
      end f_res;
      Real xmax;

    algorithm
      if ((useEnhancementFactor == false) or (T >=
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Tsat(
          p))) then
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
      "Return density as a function of pressure p, temperature T and composition X"
      extends Modelica.Icons.Function;

      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
        "Mass fractions";
      output Modelica.SIunits.Density d "Density";

    protected
      Real pd;
      Real pl;
      Real xw;
      Real xws;

    algorithm
      if (X[1] == 0) then
        d := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(p, T);
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
            d := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T) +
              pd/(.Modelica.Media.Air.ReferenceMoistAir.steam.R*T);
          else
            d := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T) +
              IF97_new.rho_pT(pd, T);
          end if;
        else
          if (T < 273.16) then
            d := (1 + xw)/((1 + xws)/(
              Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T) + pd/
              (.Modelica.Media.Air.ReferenceMoistAir.steam.R*T)) + (xw - xws)/
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.rho_pT(
              p, T));
          else
            d := (1 + xw)/((1 + xws)/(
              Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T) +
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

    function pds_pT "Saturation partial pressure of steam"
      extends Modelica.Icons.Function;

      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      output Modelica.SIunits.AbsolutePressure pds "Pressure";

    protected
      Real Tlim;

    algorithm
      if (T >= 273.16) then
        pds :=
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
          T);
        Tlim :=
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Tsat(
          p);
      else
        pds :=
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.psub(
          T);
        Tlim :=
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Tsub(
          p);
      end if;
      if (T <= Tlim) then
        pds := Modelica.Media.Air.ReferenceMoistAir.Utilities.f_pT(p, T)*pds;
      else
        // pds := -1;
        pds := p;
      end if;
      annotation (
        derivative=pds_pT_der,
        Inline=false,
        LateInline=true,
        Documentation(revisions="<html>
2017-04-13 Stefan Wischhusen: Partial steam pressure cannot become higher than absolute pressure p.
</html>"));
    end pds_pT;

    function pd_pTX "partial pressure of steam"
      extends Modelica.Icons.Function;

      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
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
        pds := Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT(p, T);
        pd := xw/(Modelica.Media.Air.ReferenceMoistAir.k_mair + xw)*p;
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        pd := if ((xw <= xws) or (xws == -1)) then pd else pds;
      end if;
      annotation (
        derivative=pd_pTX_der,
        Inline=false,
        LateInline=true);
    end pd_pTX;

    function xws_pT "Humidity ratio (absolute) of saturated humid air"
      extends Modelica.Icons.Function;

      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      output Real xws "Absolute humidity ratio";

    protected
      Real pds;
      Real Tlim;

    algorithm
      pds := Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT(p, T);
      Tlim := if (T <= 273.16) then
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Tsub(
        p) else
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Tsat(p);
    //   xws := if (T <= Tlim) then Modelica.Media.Air.ReferenceMoistAir.k_mair*
    //     pds/(p - pds) else -1;
      xws := if (pds < p) then pds*Modelica.Media.Air.ReferenceMoistAir.k_mair/(p - pds) else Modelica.Constants.inf;
      annotation (
        derivative=xws_pT_der,
        Inline=false,
        LateInline=true,
        Documentation(revisions="<html>
2017-04-13 Stefan Wischhusen: New formula for xws.
</html>"));
    end xws_pT;

    function phi_pTX "Relative humidity"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
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
          pds :=
            Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.psub(
            T);
        end if;
        pds := Modelica.Media.Air.ReferenceMoistAir.Utilities.f_pT(p, T)*pds;
        pd := xw/(Modelica.Media.Air.ReferenceMoistAir.k_mair + xw)*p;
    //     if (pd <= pds) then
    //       phi := pd/pds;
    //     else
    //       phi := -1;
    //     end if;
        phi := pd/max(100*Modelica.Constants.eps, pds);
      end if;

      annotation(Inline=false, LateInline=true,
        Documentation(revisions="<html>
2017-04-13 Stefan Wischhusen: New calculation for phi.
</html>"));
    end phi_pTX;

    function cp_pTX "Specific isobaric heat capacity"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
        "Mass fractions";
      output Modelica.SIunits.SpecificHeatCapacity cp "Specific heat capacity";

    protected
      Real xw;
      Real xws;
      Real pd;
      Real pl;

    algorithm
      if (X[1] == 0.0) then
        if (T >= 773.15) then
          cp := Modelica.Media.Air.ReferenceAir.Air_Utilities.cp_pT(p, T) +
            Utilities.cp_dis_pTX(
                p,
                T,
                X);
        else
          cp := Modelica.Media.Air.ReferenceAir.Air_Utilities.cp_pT(p, T);
        end if;
      else
        pd := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX(
              p,
              T,
              X);
        pl := p - pd;
        xw := X[1]/(1 - X[1]);
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        if ((xw <= xws) or (xws == -1)) then
          if (T >= 773.15) then
            cp := X[1]*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.cp_pT(pd,
              T) + X[2]*Modelica.Media.Air.ReferenceAir.Air_Utilities.cp_pT(pl,
              T) + Modelica.Media.Air.ReferenceMoistAir.Utilities.cp_dis_pTX(
                  p,
                  T,
                  X);
          else
            cp := X[1]*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.cp_pT(pd,
              T) + X[2]*Modelica.Media.Air.ReferenceAir.Air_Utilities.cp_pT(pl,
              T);
          end if;
        else
          cp := -1;
        end if;
      end if;
      annotation (Inline=false, LateInline=true);
    end cp_pTX;

    function cv_pTX "Specific isochoric heat capacity"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
        "Mass fractions";
      output Modelica.SIunits.SpecificHeatCapacity cv "Specific heat capacity";

    protected
      Real xw;
      Real xws;
      Real pd;
      Real pl;

    algorithm
      if (X[1] == 0) then
        cv := Modelica.Media.Air.ReferenceAir.Air_Utilities.cv_pT(p, T);
      else
        pd := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX(
              p,
              T,
              X);
        pl := p - pd;
        xw := X[1]/(1 - X[1]);
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        if ((xw <= xws) or (xws == -1)) then
          cv := X[1]*
            Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.cv_pT(pd, T)
             + X[2]*Modelica.Media.Air.ReferenceAir.Air_Utilities.cv_pT(pl, T);
        else
          cv := -1;
        end if;
      end if;
      annotation (Inline=false, LateInline=true);
    end cv_pTX;

    function h_pTX "Specific enthalpy of moist air"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
        "Mass fractions";
      output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";

    protected
      Real xw;
      Real xws;
      Real pd;
      Real pl;

    algorithm
      if (X[1] == 0) then
        h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(p, T);
      else
        pd := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX(
              p,
              T,
              X);
        pl := p - pd;
        xw := X[1]/(1 - X[1]);
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        if ((xw <= xws) or (xws == -1)) then
          if (T >= 773.15) then
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) + xw
              *Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd,
              T) + (1 + xw)*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.h_dis_pTX(
                  p,
                  T,
                  X);
          else
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) + xw
              *Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd,
              T);
          end if;
        else
          if (T < 273.16) then
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) +
              xws*Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(
              pd, T) + (xw - xws)*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.h_pT(
              p, T);
          else
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) +
              xws*Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(
              pd, T) + (xw - xws)*Modelica.Media.Water.IF97_Utilities.h_pT(p, T);
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
      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
        "Mass fractions";
      output Real u "Reaction index";
    protected
      Real uges;
      Real invMMX[4] "Inverses of molar weights";
      SI.MolarMass Mmix "Molar mass of mixture";
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
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U2(
              p,
              T,
              Y) +
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U3(
              p,
              T,
              Y) +
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U4(
              p,
              T,
              Y) +
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U5(
              p,
              T,
              Y) +
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U6(
              p,
              T,
              Y);
        u := -T^2*(
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U2(
              p,
              T,
              Y)*
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V2(T)/
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[2]
           + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U3(
              p,
              T,
              Y)*
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V3(T)/
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[3]
           + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U4(
              p,
              T,
              Y)*
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V4(T)/
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[4]
           + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U5(
              p,
              T,
              Y)*
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V5(T)/
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[5]
           + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U6(
              p,
              T,
              Y)*
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V6(T)/
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[6])
          /uges*sum(massFraction[j]/MMX[j] for j in 1:4);
      end if;
    end h_dis_pTX;

    function s_pTX "Specific entropy of moist air"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
        "Mass fractions";
      output Modelica.SIunits.SpecificEntropy s "Specific entropy";

    protected
      Real xw;
      Real xws;
      Real pd;
      Real pl;

    algorithm
      if (X[1] == 0) then
        s := Modelica.Media.Air.ReferenceAir.Air_Utilities.s_pT(p, T);
      else
        pd := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX(
              p,
              T,
              X);
        pl := p - pd;
        xw := X[1]/(1 - X[1]);
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        if ((xw <= xws) or (xws == -1)) then
          if (T >= 773.15) then
            s := Modelica.Media.Air.ReferenceAir.Air_Utilities.s_pT(pl, T) + xw
              *Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.s_pT(pd,
              T) + (1 + xw)*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.s_dis_pTX(
                  p,
                  T,
                  X);
          else
            s := Modelica.Media.Air.ReferenceAir.Air_Utilities.s_pT(pl, T) + xw
              *Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.s_pT(pd,
              T);
          end if;
        else
          if (T < 273.16) then
            s := Modelica.Media.Air.ReferenceAir.Air_Utilities.s_pT(pl, T) +
              xws*Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.s_pT(
              pd, T) + (xw - xws)*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.s_pT(
              p, T);
          else
            s := Modelica.Media.Air.ReferenceAir.Air_Utilities.s_pT(pl, T) +
              xws*Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.s_pT(
              pd, T) + (xw - xws)*Modelica.Media.Water.IF97_Utilities.s_pT(p, T);
          end if;
        end if;
        s := s/(1 + xw);
      end if;
      annotation (Inline=false, LateInline=true);
    end s_pTX;

    function u_pTX "Internal energy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
        "Mass fractions";
      output Modelica.SIunits.SpecificEnergy u "Specific entropy";

    algorithm
      u := Modelica.Media.Air.ReferenceMoistAir.Utilities.h_pTX(
            p,
            T,
            X) - p/Modelica.Media.Air.ReferenceMoistAir.Utilities.rho_pTX(
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
      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
        "Mass fractions";
      output Real u "Reaction index";
    protected
      Real uges;
      Real invMMX[4] "Inverses of molar weights";
      SI.MolarMass Mmix "Molar mass of mixture";
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
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U2(
              p,
              T,
              Y) +
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U3(
              p,
              T,
              Y) +
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U4(
              p,
              T,
              Y) +
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U5(
              p,
              T,
              Y) +
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U6(
              p,
              T,
              Y);
        u := (Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U2(
              p,
              T,
              Y)*
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V2(T)
           + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U3(
              p,
              T,
              Y)*
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V3(T)
           + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U4(
              p,
              T,
              Y)*
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V4(T)
           + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U5(
              p,
              T,
              Y)*
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V5(T)
           + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U6(
              p,
              T,
              Y)*
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V6(T))
          /uges*sum(massFraction[j]/MMX[j] for j in 1:4);
      end if;
    end cp_dis_pTX;

    function s_dis_pTX
      extends Modelica.Icons.Function;
      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
        "Mass fractions";
      output Real u "Reaction index";
    protected
      Real uges;
      Real invMMX[4] "Inverses of molar weights";
      SI.MolarMass Mmix "Molar mass of mixture";
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
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U2(
              p,
              T,
              Y) +
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U3(
              p,
              T,
              Y) +
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U4(
              p,
              T,
              Y) +
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U5(
              p,
              T,
              Y) +
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U6(
              p,
              T,
              Y);
        u := -T*(
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U2(
              p,
              T,
              Y)*
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V2(T)/
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[2]
           + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U3(
              p,
              T,
              Y)*
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V3(T)/
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[3]
           + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U4(
              p,
              T,
              Y)*
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V4(T)/
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[4]
           + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U5(
              p,
              T,
              Y)*
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V5(T)/
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[5]
           + Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.U6(
              p,
              T,
              Y)*
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.V6(T)/
          Modelica.Media.Air.ReferenceMoistAir.Utilities.ReactionIndices.BB[6])
          /uges*sum(massFraction[j]/MMX[j] for j in 1:4);
      end if;
    end s_dis_pTX;

    function pd_pTX_der "Derivative of partial pressure of steam"
      extends Modelica.Icons.Function;

      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
        "Mass fractions";
      input Real p_der "Derivative of pressure";
      input Real T_der "Derivative of temperature";
      input Real X_der[:] "Derivative of mass fractions";
      output Real pd_der "Derivative of partial pressure";

    protected
      Real xw,      xw_der;
      Real xws;
      Real pds,      pds_der;

    algorithm
      if (X[1] == 0) then
        //pd := 0;
        pd_der := 0;
      else
        xw := X[1]/(1 - X[1]) "d(xw)/dt = d(xw)/dX[1] * dX[1]/dt";
        xw_der := (X_der[1]*(1 - X[1]) + X[1]*X_der[1])/(1 - X[1])^2;
        pds_der := Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT_der(
              p,
              T,
              p_der,
              T_der);
        //pd := xw/(Modelica.Media.Air.ReferenceMoistAir.k_mair + xw)*p;
        pd_der := (xw_der*(Modelica.Media.Air.ReferenceMoistAir.k_mair + xw) -
          xw*xw_der)*p + xw/(Modelica.Media.Air.ReferenceMoistAir.k_mair + xw)*
          p_der;
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        pd_der := if (xw <= xws) then pd_der else pds_der;
      end if;
      annotation (Documentation(revisions="<html>
2017-04-13 Stefan Wischhusen: Changed derivative function.
</html>"));
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
      Real pds,      pds_der;
      Real Tlim;

    algorithm
      pds := Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT(p, T);
      pds_der := Modelica.Media.Air.ReferenceMoistAir.Utilities.pds_pT_der(
            p,
            T,
            p_der,
            T_der);
      Tlim := if (T <= 273.16) then
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Tsub(
        p) else
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Tsat(p);
      if (pds < p) then
        xws_der := Modelica.Media.Air.ReferenceMoistAir.k_mair*((pds_der*(p -
          pds) + pds*pds_der)/(p - pds)^2);
      else
        xws_der := 0;
      end if;
      annotation (Documentation(revisions="<html>
2017-04-13 Stefan Wischhusen: Changed derivative function.
</html>"));
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
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat_der(
          T, T_der);
        Tlim :=
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.Tsat(
          p);
      else
        pds_der :=
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.psub_der(
          T, T_der);
        Tlim :=
          Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.Basic.Tsub(
          p);
      end if;
      if (T <= Tlim) then
        pds_der := pds_der;
      else
        pds_der := p_der;
      end if;
      annotation (Documentation(revisions="<html>
2017-04-13 Stefan Wischhusen: Changed derivative if pds=p.
</html>"));
    end pds_pT_der;

    function rho_pTX_der
      "Derivative of density as a function of pressure p, temperature T and composition X"
      extends Modelica.Icons.Function;

      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
        "Mass fractions";
      input Real p_der "Derivative of pressure";
      input Real T_der "Derivative of temperature";
      input Real X_der[:] "Derivative of mass fractions";
      output Real d_der "Derivative of density";

    protected
      Real pd,      pd_der;
      Real pl,      pl_der;
      Real xw,      xw_der;
      Real xws,      xws_der;
      Real o[5];

    algorithm
      if (X[1] == 0) then
        d_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT_der(
              p,
              T,
              Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(p, T),
              p_der,
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
        pd_der := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX_der(
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
            d_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT_der(
                  pl,
                  T,
                  Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
                pl, T),
                  pl_der,
                  T_der) + Modelica.Media.Air.ReferenceMoistAir.steam.R*(pd_der
              *T - pd*T_der)/(Modelica.Media.Air.ReferenceMoistAir.steam.R*T)^2;

          else
            d_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT_der(
                  pl,
                  T,
                  Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
                pl, T),
                  pl_der,
                  T_der) + IF97_new.rho_pT_der(
                  pd,
                  T,
                  pd_der,
                  T_der);

          end if;
        else
          if (T < 273.16) then
            o[1] := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T);
            o[2] :=
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.rho_pT(
              p, T);
            o[3] := ((1 + xws)/(
              Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T) + pd/
              (.Modelica.Media.Air.ReferenceMoistAir.steam.R*T)) + (xw - xws)/
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.rho_pT(
              p, T));
            o[4] := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT_der(
                  pl,
                  T,
                  Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
                p, T),
                  p_der,
                  T_der);

            o[5] := (xws_der*o[1] - (1 + xws)*o[4])/o[1]^2 + (pd_der*T - pd*
              T_der)/Modelica.Media.Air.ReferenceMoistAir.steam.R/T^2 + (xw_der
              *o[2] - xw*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.rho_pT_der(
                  p,
                  T,
                Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
                p, T),
                  p_der,
                  T_der))/o[2]^2 - (xws_der*o[2] - xws*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.rho_pT_der(
                  p,
                  T,
                Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
                p, T),
                  p_der,
                  T_der))/o[2]^2;

            d_der := (xw_der*o[3] - (1 + xw)*o[5])/o[3]^2;

          else
            o[1] := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T)
               + IF97_new.rho_pT(pd, T);
            o[2] := Modelica.Media.Water.IF97_Utilities.rho_pT(p, T);
            o[3] := ((1 + xws)/(
              Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT(pl, T) +
              IF97_new.rho_pT(pd, T)) + (xw - xws)/
              Modelica.Media.Water.IF97_Utilities.rho_pT(p, T));
            o[4] := Modelica.Media.Air.ReferenceAir.Air_Utilities.rho_pT_der(
                  pl,
                  T,
                  Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
                p, T),
                  p_der,
                  T_der) + IF97_new.rho_pT_der(
                  pd,
                  T,
                  pd_der,
                  T_der);

            o[5] := (xws_der*o[1] - (1 + xws)*o[4])/o[1]^2 + (xw_der*o[2] - xw*
              Modelica.Media.Water.IF97_Utilities.rho_pT_der(
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
      import Modelica.Media.Air.ReferenceMoistAir.Utilities;
      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
        "Mass fractions";
      input Real p_der "Derivative of pressure";
      input Real T_der "Derivative of temperature";
      input Real X_der[:] "Derivative of mass fractions";
      output Real u_der "Derivative of reaction index";
    protected
      Real uges,      uges_der,      o[7],      l;
      Real invMMX[4] "Inverses of molar weights";
      SI.MolarMass Mmix "Molar mass of mixture";
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
          Y_der[i] := (Mmix_der*massFraction[i] + Mmix*massFraction_der[i])/MMX[
            i];
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
              Y)*Utilities.ReactionIndices.V2(T)/Utilities.ReactionIndices.BB[2]
           + Utilities.ReactionIndices.U3(
              p,
              T,
              Y)*Utilities.ReactionIndices.V3(T)/Utilities.ReactionIndices.BB[3]
           + Utilities.ReactionIndices.U4(
              p,
              T,
              Y)*Utilities.ReactionIndices.V4(T)/Utilities.ReactionIndices.BB[4]
           + Utilities.ReactionIndices.U5(
              p,
              T,
              Y)*Utilities.ReactionIndices.V5(T)/Utilities.ReactionIndices.BB[5]
           + Utilities.ReactionIndices.U6(
              p,
              T,
              Y)*Utilities.ReactionIndices.V6(T)/Utilities.ReactionIndices.BB[6]);
        o[6] := -2*T*(Utilities.ReactionIndices.U2(
              p,
              T,
              Y)*Utilities.ReactionIndices.V2(T)/Utilities.ReactionIndices.BB[2]
           + Utilities.ReactionIndices.U3(
              p,
              T,
              Y)*Utilities.ReactionIndices.V3(T)/Utilities.ReactionIndices.BB[3]
           + Utilities.ReactionIndices.U4(
              p,
              T,
              Y)*Utilities.ReactionIndices.V4(T)/Utilities.ReactionIndices.BB[4]
           + Utilities.ReactionIndices.U5(
              p,
              T,
              Y)*Utilities.ReactionIndices.V5(T)/Utilities.ReactionIndices.BB[5]
           + Utilities.ReactionIndices.U6(
              p,
              T,
              Y)*Utilities.ReactionIndices.V6(T)/Utilities.ReactionIndices.BB[6])
           - T^2*sum(o[1:5]);
        o[7] := uges_der*sum(massFraction[j]/MMX[j] for j in 1:4) + uges*sum(
          massFraction_der[j]/MMX[j] for j in 1:4);
        u_der := (o[6]*(uges*sum(massFraction[j]/MMX[j] for j in 1:4)) - l*o[7])
          /(uges*sum(massFraction[j]/MMX[j] for j in 1:4))^2;

      end if;
    end h_dis_pTX_der;

    function h_pTX_der "Derivative of specific enthalpy of moist air"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
        "Mass fractions";
      input Real p_der "Derivative of pressure";
      input Real T_der "Derivative of temperature";
      input Real X_der[:] "Derivative of mass fractions";
      output Real h_der "Derivative of specific enthalpy";

    protected
      Modelica.SIunits.SpecificEnthalpy h;
      Real xw,      xw_der;
      Real xws,      xws_der;
      Real pd,      pd_der;
      Real pl,      pl_der;

    algorithm
      if (X[1] == 0) then
        h_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT_der(
              p,
              T,
              Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(p, T),
              p_der,
              T_der);
      else
        pd := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX(
              p,
              T,
              X);
        pd_der := Modelica.Media.Air.ReferenceMoistAir.Utilities.pd_pTX_der(
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
        xws := Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p, T);
        xws_der := xws_pT_der(
              p,
              T,
              p_der,
              T_der);
        if ((xw <= xws) or (xws == -1)) then
          if (T >= 773.15) then
            h_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT_der(
                  pl,
                  T,
                  Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
                pl, T),
                  pl_der,
                  T_der) + xw_der*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd,
              T) + xw*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT_der(
                  pd,
                  T,
                  0,
                  pd_der,
                  T_der) + xw_der*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.h_dis_pTX(
                  p,
                  T,
                  X) + xw*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.h_dis_pTX_der(
                  p,
                  T,
                  X,
                  p_der,
                  T_der,
                  X_der);

          else
            h_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT_der(
                  pl,
                  T,
                  Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
                pl, T),
                  pl_der,
                  T_der) + xw_der*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd,
              T) + xw*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT_der(
                  pd,
                  T,
                  0,
                  pd_der,
                  T_der);

          end if;
        else
          if (T < 273.16) then
            h_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT_der(
                  pl,
                  T,
                  Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
                pl, T),
                  pl_der,
                  T_der) + xws_der*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd,
              T) + xws*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT_der(
                  pd,
                  T,
                  0,
                  pd_der,
                  T_der) + xw_der*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.h_pT(
              p, T) + xw*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.h_pT_der(
                  p,
                  T,
                Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
                p, T),
                  p_der,
                  T_der) - xws_der*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.h_pT(
              p, T) - xws*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.h_pT_der(
                  p,
                  T,
                Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.ice09BaseProp_pT(
                p, T),
                  p_der,
                  T_der);

          else
            h_der := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT_der(
                  pl,
                  T,
                  Modelica.Media.Air.ReferenceAir.Air_Utilities.airBaseProp_pT(
                p, T),
                  pl_der,
                  T_der) + xws_der*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd,
              T) + xws*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT_der(
                  pd,
                  T,
                  0,
                  pd_der,
                  T_der) + xw_der*Modelica.Media.Water.IF97_Utilities.h_pT(p, T)
               + xw*Modelica.Media.Water.IF97_Utilities.h_pT_der(
                  p,
                  T,
                  Modelica.Media.Water.IF97_Utilities.waterBaseProp_pT(p, T),
                  p_der,
                  T_der) - xws_der*Modelica.Media.Water.IF97_Utilities.h_pT(p,
              T) - xws*Modelica.Media.Water.IF97_Utilities.h_pT_der(
                  p,
                  T,
                  Modelica.Media.Water.IF97_Utilities.waterBaseProp_pT(p, T),
                  p_der,
                  T_der);

          end if;
        end if;
        if ((xw <= xws) or (xws == -1)) then
          if (T >= 773.15) then
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) + xw
              *Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd,
              T) + (1 + xw)*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.h_dis_pTX(
                  p,
                  T,
                  X);
          else
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) + xw
              *Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(pd,
              T);
          end if;
        else
          if (T < 273.16) then
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) +
              xws*Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(
              pd, T) + (xw - xws)*
              Modelica.Media.Air.ReferenceMoistAir.Utilities.Ice09_Utilities.h_pT(
              p, T);
          else
            h := Modelica.Media.Air.ReferenceAir.Air_Utilities.h_pT(pl, T) +
              xws*Modelica.Media.Air.ReferenceMoistAir.Utilities.IF97_new.h_pT(
              pd, T) + (xw - xws)*Modelica.Media.Water.IF97_Utilities.h_pT(p, T);
          end if;
        end if;
        h_der := (h_der*(1 + xw) - h*xw_der)/(1 + xw)^2;
      end if;
    end h_pTX_der;

    function u_pTX_der "Derivative of internal energy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.AbsolutePressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:]=Modelica.Media.Air.ReferenceMoistAir.reference_X
        "Mass fractions";
      input Real p_der "Derivative of pressure";
      input Real T_der "Derivative of temperature";
      input Real X_der[:] "Derivative of mass fractions";
      output Real u_der "Derivative of specific entropy";

    algorithm
      u_der := Modelica.Media.Air.ReferenceMoistAir.Utilities.h_pTX_der(
            p,
            T,
            X,
            p_der,
            T_der,
            X_der) - (p_der*
        Modelica.Media.Air.ReferenceMoistAir.Utilities.rho_pTX(
            p,
            T,
            X) - p*Modelica.Media.Air.ReferenceMoistAir.Utilities.rho_pTX_der(
            p,
            T,
            X,
            p_der,
            T_der,
            X_der))/Modelica.Media.Air.ReferenceMoistAir.Utilities.rho_pTX(
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
<strong>611.2 Pa &le; p &le; 10 MPa</strong>
</li>
<li>
<strong>143.15 K &le; T &le; 2000 K</strong>
</li>
</ul>

<h4>Usage</h4>
<p>
The package MoistAir can be used as any other medium model (see <a href=\"modelica://Modelica.Media.UsersGuide\">User's Guide of Media Library</a> for further information). The package defines two boolean constants <strong>useEnhancementFactor</strong> and <strong>useDissociation</strong>, which give the user fine grained control of the calculations.
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr>
<td><strong>Constant</strong></td>
<td><strong>Default Value</strong></td>
<td><strong>Meaning</strong></td>
</tr>
<tr>
<td>useEnhancementFactor</td>
<td>false</td>
<td>The enhancement factor is used in the calculation of the saturation partial pressure of water in moist air. It is always very close to 1 except for high pressures (&gt;2 MPa) and low temperatures (&lt;233.15 K). For pressures less than 1 MPa this factor can be safely set to 1. Its calculation is very expensive, since it can only be calculated by an iterative method.</td>
</tr>
<tr>
<td>useDissociation</td>
<td>true</td>
<td>The effect of dissociation is taken into account for temperatures greater than 773.15 K.</td>
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
<strong>Liquid fog (x<sub>w</sub> &gt; x<sub>wsw</sub>) and T &ge; 273.16 K</strong>
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
<strong>Ice fog (x<sub>w</sub> &gt; x<sub>wsw</sub>) and T &lt; 273.16 K</strong>
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
calculated by the package Modelica.Media.Air.ReferenceAir, because there no dissociation is considered.
</p>

<h4>References</h4>
<dl>
<dd>[1] <strong>Thermodynamic Properties of Air and Mixtures of Nitrogen, Argon,
and Oxygen From 60 to 2000 K at Pressures to 2000 MPa</strong>. J. Phys. Chem. Ref. Data, Vol. 29, No. 3, 2000.
</dd>
<dd>[2] <strong>Viscosity and Thermal Conductivity Equations for
Nitrogen, Oxygen, Argon, and Air</strong>. International Journal of Thermophysics, Vol. 25, No. 1, January 2004
</dd>
<dd>[3] <strong>Revised Release on the IAPWS Formulation 1995 for the Thermodynamic
Properties of Ordinary Water Substance for General and Scientific Use</strong>. 2009 International Association for the Properties of Water and Steam.
</dd>
<dd>[4] <strong>Revised Release on the IAPWS Industrial Formulation 1997
for the Thermodynamic Properties of Water and Steam</strong>. 2007 International Association for the Properties of Water and Steam.
</dd>
<dd>[5] <strong>Release on the IAPWS Formulation 2008 for the Viscosity of Ordinary Water Substance</strong>. 2008 International Association for the Properties of Water and Steam
</dd>
<dd>[6] <strong>Release on the IAPWS Formulation 2011 for the Thermal Conductivity of
Ordinary Water Substance</strong>. 2011 International Association for the Properties of Water and Steam.
</dd>
<dd>[7] <strong>Revised Release on the Equation of State 2006 for H2O Ice Ih</strong>. 2009 International Association for the Properties of Water and Steam.
</dd>
<dd>[8] <strong>Revised Release on the Pressure along the Melting and
Sublimation Curves of Ordinary Water Substance</strong>. 2011 International Association for the Properties of Water and Steam.
</dd>
<dd>[9] <strong>Determination of Thermodynamic and Transport Properties
of Humid Air for Power-Cycle Calculations</strong>. 2009 PTB, Braunschweig, Germany.
</dd>
<dd>[10] <strong>Berechnung der thermodynamischen Zustandsfunktionen von
feuchter Luft in energietechnischen Prozessmodellierungen</strong>. 2001 Diplomarbeit, Zittau.
</dd>
<dd>[11] <strong>Thermodynamische Stoffwerte von feuchter Luft und Verbrennungsgasen</strong>. 2003 VDI-Richtlinie 4670.
</dd>
<dd>[12] <strong>W&auml;rme&uuml;bertragung in Dampferzeugern und W&auml;rmetauschern</strong>. 1985 FDBR-Fachbuchreihe, Bd. 2, Vulkan Verlag Essen.
</dd>
</dl>

<h4>References</h4>
<dl>
<dt>Lemmon, E. W., Jacobsen, R. T., Penoncello, S. G., Friend, D. G.:</dt>
<dd><strong>Thermodynamic Properties of Air and Mixtures of Nitrogen, Argon,
and Oxygen From 60 to 2000 K at Pressures to 2000 MPa</strong>. J. Phys. Chem. Ref. Data, Vol. 29, No. 3, 2000.
</dd>
<dt>Lemmon, E. W., Jacobsen, R. T.:</dt>
<dd><strong>Viscosity and Thermal Conductivity Equations for
Nitrogen, Oxygen, Argon, and Air</strong>. International Journal of Thermophysics, Vol. 25, No. 1, January 2004
</dd>
</dl>


<h4>Verification</h4>
<p>
The verification report for the development of this library is provided
<a href=\"modelica://Modelica/Resources/Documentation/Media/MoMoLib_VerificationResults_XRG.pdf\">here</a>.
</p>

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
<h4> Copyright &copy; 2013-2018, XRG Simulation GmbH </h4>
</html>"));
end ReferenceMoistAir;
