within Modelica.Media.Air;
package MoistAir "Air: Moist air model (190 ... 647 K)"
  extends Interfaces.PartialCondensingGases(
    mediumName="Moist air",
    substanceNames={"water","air"},
    final reducedX=true,
    final singleState=false,
    reference_X={0.01,0.99},
    fluidConstants={IdealGases.Common.FluidData.H2O,IdealGases.Common.FluidData.N2},
    Temperature(min=190, max=647));

  import Modelica.Media.IdealGases.Common.Functions;
  constant Integer Water=1
    "Index of water (in substanceNames, massFractions X, etc.)";
  constant Integer Air=2
    "Index of air (in substanceNames, massFractions X, etc.)";
  //     constant SI.Pressure psat_low=saturationPressureWithoutLimits(200.0);
  //     constant SI.Pressure psat_high=saturationPressureWithoutLimits(422.16);
  constant Real k_mair=steam.MM/dryair.MM "Ratio of molar weights";

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
190.0 K <= (T ="
               + String(T) + " K) <= 647.0 K
required from medium model \""
                             + mediumName + "\".");
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
    R_s = dryair.R_s*(X_air/(1 - X_liquid)) + steam.R_s*X_steam/(1 - X_liquid);
    //
    u = h - R_s*T;
    d = p/(R_s*T);
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
<p>This model computes thermodynamic properties of moist air from three independent (thermodynamic or/and numerical) state variables. Preferred numerical states are temperature T, pressure p and the reduced composition vector Xi, which contains the water mass fraction only. As an EOS the <strong>ideal gas law</strong> is used and associated restrictions apply. The model can also be used in the <strong>fog region</strong>, when moisture is present in its liquid state. However, it is assumed that the liquid water volume is negligible compared to that of the gas phase. Computation of thermal properties is based on property data of <a href=\"modelica://Modelica.Media.Air.DryAirNasa\"> dry air</a> and water (source: VDI-W&auml;rmeatlas), respectively. Besides the standard thermodynamic variables <strong>absolute and relative humidity</strong>, x_water and phi, respectively, are given by the model. Upper case X denotes absolute humidity with respect to mass of moist air while absolute humidity with respect to mass of dry air only is denoted by a lower case x throughout the model. See <a href=\"modelica://Modelica.Media.Air.MoistAir\">package description</a> for further information.</p>
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
    input Density d "Density";
    input Temperature T "Temperature";
    input MassFraction X[:]=reference_X "Mass fractions";
    output ThermodynamicState state "Thermodynamic state";
  algorithm
    state := if size(X, 1) == nX then ThermodynamicState(
          p=d*({steam.R_s,dryair.R_s}*X)*T,
          T=T,
          X=X) else ThermodynamicState(
          p=d*({steam.R_s,dryair.R_s}*cat(
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
    R_s := dryair.R_s*(1 - state.X[Water]) + steam.R_s*state.X[Water];
    annotation (smoothOrder=2, Documentation(info="<html>
The ideal gas constant for moist air is computed from <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state</a> assuming that all water is in the gas phase.
</html>"));
  end gasConstant;

  function gasConstant_X
    "Return ideal gas constant as a function from composition X"
    extends Modelica.Icons.Function;
    input SI.MassFraction X[:] "Gas phase composition";
    output SI.SpecificHeatCapacity R_s "Ideal gas constant";
  algorithm
    R_s := dryair.R_s*(1 - X[Water]) + steam.R_s*X[Water];
    annotation (smoothOrder=2, Documentation(info="<html>
The ideal gas constant for moist air is computed from the gas phase composition. The first entry in composition vector X is the steam mass fraction of the gas phase.
</html>"));
  end gasConstant_X;

  function saturationPressureLiquid
    "Return saturation pressure of water as a function of temperature T in the range of 273.16 to 647.096 K"

    extends Modelica.Icons.Function;
    input SI.Temperature Tsat "Saturation temperature";
    output SI.AbsolutePressure psat "Saturation pressure";
  protected
    SI.Temperature Tcritical=647.096 "Critical temperature";
    SI.AbsolutePressure pcritical=22.064e6 "Critical pressure";
    Real r1=(1 - Tsat/Tcritical) "Common subexpression";
    Real a[:]={-7.85951783,1.84408259,-11.7866497,22.6807411,-15.9618719,
        1.80122502} "Coefficients a[:]";
    Real n[:]={1.0,1.5,3.0,3.5,4.0,7.5} "Coefficients n[:]";
  algorithm
    psat := exp(((a[1]*r1^n[1] + a[2]*r1^n[2] + a[3]*r1^n[3] + a[4]*r1^n[4]
       + a[5]*r1^n[5] + a[6]*r1^n[6])*Tcritical)/Tsat)*pcritical;
    annotation (
      derivative=saturationPressureLiquid_der,
      Inline=false,
      smoothOrder=5,
      Documentation(info="<html>
<p>Saturation pressure of water above the triple point temperature is computed from temperature.</p>
<p>Source: A Saul, W Wagner: &quot;International equations for the saturation properties of ordinary water substance&quot;, equation 2.1</p>
</html>"));
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
<p>Saturation pressure of water above the triple point temperature is computed from temperature.</p>
<p>Source: A Saul, W Wagner: &quot;International equations for the saturation properties of ordinary water substance&quot;, equation 2.1</p>
</html>"));
  end saturationPressureLiquid_der;

  function sublimationPressureIce
    "Return sublimation pressure of water as a function of temperature T between 190 and 273.16 K"

    extends Modelica.Icons.Function;
    input SI.Temperature Tsat "Sublimation temperature";
    output SI.AbsolutePressure psat "Sublimation pressure";
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
</html>"));
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
</html>"));
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
Saturation pressure of water in the liquid and the solid region is computed using correlations. Functions for the
<a href=\"modelica://Modelica.Media.Air.MoistAir.sublimationPressureIce\">solid</a> and the <a href=\"modelica://Modelica.Media.Air.MoistAir.saturationPressureLiquid\"> liquid</a> region, respectively, are combined using the first derivative continuous <a href=\"modelica://Modelica.Media.Air.MoistAir.Utilities.spliceFunction\">spliceFunction</a>. This functions range of validity is from 190 to 647.096 K. For more information on the type of correlation used, see the documentation of the linked functions.
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
    function f_nonlinear "Solve p(T) for T with given p"
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input SI.Pressure p "Pressure";
    algorithm
      y := saturationPressure(Tsat=u) - p;
    end f_nonlinear;

  algorithm
    T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
      function f_nonlinear(p=p), T_min, T_max);
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
</html>"));
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
</html>"),
         smoothOrder=2);
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
    input SI.Temperature T "Temperature";
    output SI.SpecificEnthalpy h "Specific enthalpy of water";
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
<li>heat capacity of liquid water:4200 J/kg</li>
<li>heat capacity of solid water: 2050 J/kg</li>
<li>enthalpy of fusion (liquid=>solid): 333000 J/kg</li>
</ul>
Pressure is assumed to be around 1 bar. This function is usually used to determine the specific enthalpy of the liquid or solid fraction of moist air.
</html>"));
  end enthalpyOfWater;

  function enthalpyOfWater_der "Derivative function of enthalpyOfWater"
    extends Modelica.Icons.Function;
    input SI.Temperature T "Temperature";
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
    function f_nonlinear "Solve h_pTX(p,T,X) for T with given h"
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction[:] X "Mass fractions of composition";
    algorithm
      y := h_pTX(p=p, T=u, X=X) - h;
    end f_nonlinear;

  algorithm
    T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
      function f_nonlinear(p=p, h=h, X=X[1:nXi]), 190, 647);
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
    SI.MassFraction X_liquid "Mass fraction of liquid water";
    SI.MassFraction X_steam "Mass fraction of steam water";
    SI.MassFraction X_air "Mass fraction of air";
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
    input AbsolutePressure p2 "Downstream pressure";
    input ThermodynamicState state "Thermodynamic state at upstream location";
    output SpecificEnthalpy h_is "Isentropic enthalpy";
  protected
    SpecificEnthalpy h "Specific enthalpy at upstream location";
    IsentropicExponent gamma=isentropicExponent(state) "Isentropic exponent";
  protected
    MassFraction[nX] X "Complete X-vector";
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
    SI.SpecificHeatCapacity R_gas "Ideal gas constant";
  algorithm
    p_steam_sat := saturationPressure(T);
    X_sat := min(p_steam_sat*k_mair/max(100*Constants.eps, p - p_steam_sat)*(
      1 - X[Water]), 1.0);
    X_liquid := max(X[Water] - X_sat, 0.0);
    X_steam := X[Water] - X_liquid;
    X_air := 1 - X[Water];
    R_gas := dryair.R_s*X_air/(1 - X_liquid) + steam.R_s*X_steam/(1 - X_liquid);
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
    R_gas := steam.R_s*X_steam/(1 - X_liquid) + dryair.R_s*X_air/(1 - X_liquid);

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
    dR_gas := (steam.R_s*(dX_steam*(1 - X_liquid) + dX_liq*X_steam) + dryair.R_s*
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
The specific heat capacity at constant pressure <strong>cp</strong> is computed from temperature and composition for a mixture of steam (X[1]) and dry air. All water is assumed to be in the vapor state.
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
The specific heat capacity at constant density <strong>cv</strong> is computed from temperature and composition for a mixture of steam (X[1]) and dry air. All water is assumed to be in the vapor state.
</html>"));
  end specificHeatCapacityCv;

redeclare function extends dynamicViscosity
    "Return dynamic viscosity as a function of the thermodynamic state record, valid from 123.15 K to 1273.15 K"

  import Modelica.Math.Polynomials;
algorithm
  eta := 1e-6*Polynomials.evaluateWithRange(
      {9.7391102886305869E-15,-3.1353724870333906E-11,4.3004876595642225E-08,
      -3.8228016291758240E-05,5.0427874367180762E-02,1.7239260139242528E+01},
      Cv.to_degC(123.15),
      Cv.to_degC(1273.15),
      Cv.to_degC(state.T));
  annotation (smoothOrder=2, Documentation(info="<html>
<p>Dynamic viscosity is computed from temperature using a simple polynomial for dry air. Range of validity is from 123.15 K to 1273.15 K. The influence of pressure and moisture is neglected.</p>
<p>Source: VDI Waermeatlas, 8th edition.</p>
</html>"));
end dynamicViscosity;

redeclare function extends thermalConductivity
    "Return thermal conductivity as a function of the thermodynamic state record, valid from 123.15 K to 1273.15 K"
  import Modelica.Math.Polynomials;
algorithm
  lambda := 1e-3*Polynomials.evaluateWithRange(
      {6.5691470817717812E-15,-3.4025961923050509E-11,5.3279284846303157E-08,
      -4.5340839289219472E-05,7.6129675309037664E-02,2.4169481088097051E+01},
      Cv.to_degC(123.15),
      Cv.to_degC(1273.15),
      Cv.to_degC(state.T));

  annotation (smoothOrder=2, Documentation(info="<html>
<p>Thermal conductivity is computed from temperature using a simple polynomial for dry air. Range of validity is from 123.15 K to 1273.15 K. The influence of pressure and moisture is neglected.</p>
<p>Source: VDI Waermeatlas, 8th edition.</p>
</html>"));
end thermalConductivity;

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
    dddX[Water] := - pressure(state)*(steam.R_s - dryair.R_s)/(((steam.R_s - dryair.R_s)
      *state.X[Water] + dryair.R_s)^2*temperature(state));
    dddX[Air] := - pressure(state)*(dryair.R_s - steam.R_s)/((steam.R_s + (dryair.R_s - steam.R_s)*
      state.X[Air])^2*temperature(state));

    annotation (Documentation(revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
<p>2019-05-14        Stefan Wischhusen: Corrected derivatives.</p>
</html>"));
  end density_derX;

  redeclare function extends molarMass
  algorithm
    MM := Modelica.Constants.R/Modelica.Media.Air.MoistAir.gasConstant(state);
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
    function f_nonlinear "Solve s_pTX(p,T,X) for T with given s"
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction[:] X "Mass fractions of composition";
    algorithm
      y := s_pTX(p=p, T=u, X=X) - s;
    end f_nonlinear;

  algorithm
    T := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
      function f_nonlinear(p=p, s=s, X=X[1:nX]), 190, 647);
    annotation (Documentation(info="<html>
Temperature is computed from pressure, specific entropy and composition via numerical inversion of function <a href=\"modelica://Modelica.Media.Air.MoistAir.s_pTX\">s_pTX</a>.
</html>",
        revisions="<html>
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
</html>",
        revisions="<html>
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
      "Molar fraction";

  algorithm
    s:= Modelica.Media.IdealGases.Common.Functions.s0_Tlow(dryair, T)*(1 - X[Water])
    + Modelica.Media.IdealGases.Common.Functions.s0_Tlow(steam, T)*X[Water]
    - Modelica.Constants.R*(Utilities.smoothMax(X[Water]/MMX[Water],0.0,1e-9)*Modelica.Math.log(max(Y[Water], Modelica.Constants.eps)*p/reference_p)
    + Utilities.smoothMax((1 - X[Water])/MMX[Air],0.0,1e-9)*Modelica.Math.log(max(Y[Air], Modelica.Constants.eps)*p/reference_p));
    annotation (
      derivative=s_pTX_der,
      Inline=false,
      Documentation(info="<html>
Specific entropy of moist air is computed from pressure, temperature and composition with X[1] as the total water mass fraction.
</html>",
        revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
<p>2019-05-14        Stefan Wischhusen: Corrected calculation.</p>
<p>2019-09-10        Stefan Wischhusen: Corrected pressure influence (p &lt; p_ref).</p>
</html>"),
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            textColor={255,127,0},
            textString="f")}));
  end s_pTX;

  function s_pTX_der
    "Return specific entropy of moist air as a function of pressure p, temperature T and composition X (only valid for phi<1)"
    extends Modelica.Icons.Function;
    input SI.Pressure p "Pressure";
    input SI.Temperature T "Temperature";
    input SI.MassFraction X[:] "Mass fractions of moist air";
    input Real dp(unit="Pa/s") "Derivative of pressure";
    input Real dT(unit="K/s") "Derivative of temperature";
    input Real dX[nX](each unit="1/s") "Derivative of mass fractions";
    output Real ds(unit="J/(kg.K.s)") "Specific entropy at p, T, X";
  protected
    MoleFraction[2] Y=massToMoleFractions(X, {steam.MM,dryair.MM})
      "Molar fraction";
    MolarMass MM "Molar mass";

  algorithm
    MM := MMX[Water]*MMX[Air]/(X[Water]*MMX[Air] + X[Air]*MMX[Water]);

    ds := IdealGases.Common.Functions.s0_Tlow_der(
      dryair,
      T,
      dT)*(1 - X[Water]) + IdealGases.Common.Functions.s0_Tlow_der(
      steam,
      T,
      dT)*X[Water] + Modelica.Media.IdealGases.Common.Functions.s0_Tlow(dryair, T)*dX[Air] + Modelica.Media.IdealGases.Common.Functions.s0_Tlow(steam, T)*dX[Water] - Modelica.Constants.R*(1/MMX[Water]*(Utilities.smoothMax_der(
      X[Water],
      0.0,
      1e-9,
      dX[Water],
      0.0,
      0.0)*(Modelica.Math.log(max(Y[Water], Modelica.Constants.eps)*p/reference_p) + MM/MMX[Air]) + dp/p*Utilities.smoothMax(
      X[Water],
      0.0,
      1e-9)) + 1/MMX[Air]*(Utilities.smoothMax_der(
      X[Air],
      0.0,
      1e-9,
      dX[Air],
      0.0,
      0.0)*(Modelica.Math.log(max(Y[Air], Modelica.Constants.eps)*p/reference_p) + MM/MMX[Water]) + dp/p*Utilities.smoothMax(
      X[Air],
      0.0,
      1e-9)));

    annotation (
      Inline=false,
      smoothOrder=1,
      Documentation(info="<html>
Specific entropy of moist air is computed from pressure, temperature and composition with X[1] as the total water mass fraction.
</html>",
        revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
<p>2019-05-14        Stefan Wischhusen: Corrected calculation.</p>
<p>2019-09-10        Stefan Wischhusen: Corrected pressure influence (p &lt; p_ref).</p>
</html>"),
      Icon(graphics={Text(
            extent={{-100,100},{100,-100}},
            textColor={255,127,0},
            textString="f")}));
  end s_pTX_der;

  redeclare function extends isentropicEnthalpy
    "Isentropic enthalpy (only valid for phi<1)"
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
            textColor={255,127,0},
            textString="f")}), Documentation(revisions="<html>
<p>2012-01-12        Stefan Wischhusen: Initial Release.</p>
</html>"));
  end isentropicEnthalpy;

  package Utilities "Utility functions"
    extends Modelica.Icons.UtilitiesPackage;
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

  annotation (Documentation(info="<html>
<h4>Thermodynamic Model</h4>
<p>This package provides a full thermodynamic model of moist air including the fog region and temperatures below zero degC.
The governing assumptions in this model are:</p>
<ul>
<li>the perfect gas law applies</li>
<li>water volume other than that of steam is neglected</li></ul>
<p>All extensive properties are expressed in terms of the total mass in order to comply with other media in this library. However, for moist air it is rather common to express the absolute humidity in terms of mass of dry air only, which has advantages when working with charts. In addition, care must be taken, when working with mass fractions with respect to total mass, that all properties refer to the same water content when being used in mathematical operations (which is always the case if based on dry air only). Therefore two absolute humidities are computed in the <strong>BaseProperties</strong> model: <strong>X</strong> denotes the absolute humidity in terms of the total mass while <strong>x</strong> denotes the absolute humidity per unit mass of dry air. In addition, the relative humidity <strong>phi</strong> is also computed.</p>
<p>At the triple point temperature of water of 0.01 &deg;C or 273.16 K and a relative humidity greater than 1 fog may be present as liquid and as ice resulting in a specific enthalpy somewhere between those of the two isotherms for solid and liquid fog, respectively. For numerical reasons a coexisting mixture of 50% solid and 50% liquid fog is assumed in the fog region at the triple point in this model.</p>

<h4>Range of validity</h4>
<p>From the assumptions mentioned above it follows that the <strong>pressure</strong> should be in the region around <strong>atmospheric</strong> conditions or below (a few bars may still be fine though). Additionally a very high water content at low temperatures would yield incorrect densities, because the volume of the liquid or solid phase would not be negligible anymore. The model does not provide information on limits for water drop size in the fog region or transport information for the actual condensation or evaporation process in combination with surfaces. All excess water which is not in its vapour state is assumed to be still present in the air regarding its energy but not in terms of its spatial extent.<br><br>
The thermodynamic model may be used for <strong>temperatures</strong> ranging from <strong>190 ... 647 K</strong>. This holds for all functions unless otherwise stated in their description. However, although the model works at temperatures above the saturation temperature it is questionable to use the term \"relative humidity\" in this region. Please note, that although several functions compute pure water properties, they are designed to be used within the moist air medium model where properties are dominated by air and steam in their vapor states, and not for pure liquid water applications.</p>

<h4>Transport Properties</h4>
<p>Several additional functions that are not needed to describe the thermodynamic system, but are required to model transport processes, like heat and mass transfer, may be called. They usually neglect the moisture influence unless otherwise stated.</p>

<h4>Application</h4>
<p>The model's main area of application is all processes that involve moist air cooling under near atmospheric pressure with possible moisture condensation. This is the case in all domestic and industrial air conditioning applications. Another large domain of moist air applications covers all processes that deal with dehydration of bulk material using air as a transport medium. Engineering tasks involving moist air are often performed (or at least visualized) by using charts that contain all relevant thermodynamic data for a moist air system. These so called psychrometric charts can be generated from the medium properties in this package. The model <a href=\"modelica://Modelica.Media.Examples.PsychrometricData\">PsychrometricData</a> may be used for this purpose in order to obtain data for figures like those below (the plotting itself is not part of the model though).</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Media/Air/Mollier.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Media/Air/PsycroChart.png\">
</div>

<p>
<strong>Legend:</strong> blue - constant specific enthalpy, red - constant temperature, black - constant relative humidity</p>

</html>"));
end MoistAir;
