package Air "Media models for air"

  package SimpleAir "Air: Simple dry air model (0..100 degC)"

    extends Interfaces.PartialMedium(
       mediumName="SimpleAir",
       final reducedX=true,
       final singleState=false,
       fluidConstants={IdealGases.Common.FluidData.N2});

    import SI = Modelica.SIunits;
    import Cv = Modelica.SIunits.Conversions;
    import Modelica.Constants;

    constant SI.MolarMass MM_air=0.0289651159 "Molar mass of air";
    constant SI.SpecificHeatCapacity R_air=Constants.R/MM_air
      "Gas constant of dry air";
    constant SI.SpecificHeatCapacity cp_air=1005.45
      "Specific heat capacity of dry air";
    constant SI.Temperature T_min=Cv.from_degC(0)
      "Minimum temperature valid for medium model";
    constant SI.Temperature T_max=Cv.from_degC(100)
      "Maximum temperature valid for medium model";

    redeclare replaceable record extends ThermodynamicState
      "thermodynamic state"
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
    end ThermodynamicState;

    redeclare model extends BaseProperties(
       T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
       p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default))
      "Base properties of dry air medium"
    equation
      assert(T >= T_min and T <= T_max, "Temperature T (= " + String(T) + " K) is not
in the allowed range (" + String(T_min) + " K <= T <= " + String(T_max)
         + " K) required from medium model \"" + mediumName + "\".");

      h = cp_air*T_degC;
      u = h - R_air*T;
      d = p/(R_air*T);
      R = R_air;
      state.T = T;
      state.p = p;
      MM = MM_air;
      annotation (Icon(Text(
            extent=[-86, 62; 82, 6],
            style(color=0),
            string="air"), Text(
            extent=[-94, -28; 100, -66],
            style(color=10),
            string=" 0..100°C")));
    end BaseProperties;

    redeclare function extends dynamicViscosity "Dynamic viscosity of dry air"
    algorithm
      eta := 1.82e-5;
    end dynamicViscosity;

    redeclare function extends thermalConductivity "thermal conductivity of dry air"
    algorithm
      lambda := 0.026;
    end thermalConductivity;

    redeclare function extends heatCapacity_cp
      "Specific heat capacity at constant pressure of dry air"
    algorithm
      cp := cp_air;
    end heatCapacity_cp;

  end SimpleAir;

  package DryAirNasa "Air: Detailed dry air model as ideal gas (200..6000 K)"
    extends IdealGases.SingleGases.Air(fluidConstants={IdealGases.Common.FluidData.N2});
    import Cv = Modelica.SIunits.Conversions;

  redeclare function dynamicViscosity "simple polynomial for dry air (moisture influence small), valid from 73.15 K to 373.15 K"
    extends Modelica.Icons.Function;
    input ThermodynamicState state;
    output DynamicViscosity eta "Dynamic viscosity";
  algorithm
    eta := Incompressible.TableBased.Polynomials_Temp.evaluate({(-4.96717436974791E-011), 5.06626785714286E-008, 1.72937731092437E-005}, Cv.to_degC(state.T));
  end dynamicViscosity;

    redeclare function thermalConductivity "simple polynomial for dry air (moisture influence small), valid from 73.15 K to 373.15 K"
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      input Integer method=1 "1: Eucken Method, 2: Modified Eucken Method";
      output ThermalConductivity lambda "Thermal conductivity";
    algorithm
      lambda := Incompressible.TableBased.Polynomials_Temp.evaluate({(-4.8737307422969E-008), 7.67803133753502E-005, 0.0241814385504202},Cv.to_degC(state.T));
    end thermalConductivity;

  end DryAirNasa;

  package MoistAir "Air: Moist air model (fog but no ice, 0..150 degC)"
    extends Interfaces.PartialCondensingGases(
       mediumName="Moist air",
       substanceNames={"water", "air"},
       final reducedX=true,
       final singleState=false,
       reference_X={0.01,0.99},
       fluidConstants = {IdealGases.Common.FluidData.H2O,IdealGases.Common.FluidData.N2});

    constant Integer Water=1
      "Index of water (in substanceNames, massFractions X, etc.)";
    constant Integer Air=2
      "Index of air (in substanceNames, massFractions X, etc.)";
//     constant SI.Pressure psat_low=saturationPressureWithoutLimits(200.0);
//     constant SI.Pressure psat_high=saturationPressureWithoutLimits(422.16);
    constant Real k_mair =  steam.MM/dryair.MM "ratio of molar weights";

    constant IdealGases.Common.DataRecord dryair = IdealGases.Common.SingleGasesData.Air;
    constant IdealGases.Common.DataRecord steam = IdealGases.Common.SingleGasesData.H2O;

    import Modelica.Media.Interfaces;
    import Modelica.Math;
    import SI = Modelica.SIunits;
    import Cv = Modelica.SIunits.Conversions;
    import Modelica.Constants;
    import Modelica.Media.IdealGases.Common.SingleGasNasa;

    redeclare replaceable model extends BaseProperties(
      T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
      p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
      Xi(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default))

      /* p, T, X = X[Water] are used as preferred states, since only then all
     other quantities can be computed in a recursive sequence.
     If other variables are selected as states, static state selection
     is no longer possible and non-linear algebraic equations occur.
      */
      MassFraction x_water "mass of total water/mass of dry air";
      Real phi "relative humidity";
      annotation(structurallyIncomplete);

    protected
      constant SI.MolarMass[2] MMX = {steam.MM,dryair.MM}
        "molar masses of components";

      MassFraction X_liquid "mass fraction of liquid water";
      MassFraction X_steam "mass fraction of steam water";
      MassFraction X_air "mass fraction of air";
      MassFraction x_sat "steam water mass fraction of saturation boundary";

      // SpecificEnthalpy h_component[2];
      AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
    equation
      assert(T >= 200.0 and T <= 423.15, "
Temperature T is not in the allowed range
200.0 K <= (T =" + String(T) + " K) <= 423.15 K
required from medium model \""       + mediumName + "\".");
      MM = 1/(Xi[Water]/MMX[Water]+(1.0-Xi[Water])/MMX[Air]);

      p_steam_sat = saturationPressure(T);
      x_sat    = k_mair*p_steam_sat/(p - p_steam_sat);
      X_liquid = max(Xi[Water] - x_sat/(1+x_sat), 0.0);
      X_steam  = Xi[Water]-X_liquid;
      X_air    = 1-Xi[Water];

      // h_component = {SingleGasNasa.h_Tlow(data=steam, T=T, refChoice=3, h_off=46479.819+2501014.5),
      //                SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)};
      //offset adjusts enthalpy to zero at 0°C plus enthalpy of evaporation in case of steam
      // h = h_component *{X_steam, X_air} + enthalpyOfLiquid(T)*X_liquid;

      h = h_pTX(p,T,Xi);
      R = dryair.R*X_air + steam.R*X_steam;
      u = h - R*T;
      d = p/(R*T);
      /* Note, u and d are computed under the assumption that the volume of the liquid
         water is neglible with respect to the volume of air and of steam
      */

      state.p = p;
      state.T = T;
      state.X = X;

      // this x_steam is water load / dry air!!!!!!!!!!!
      x_water = Xi[Water]/max(X_air,100*Constants.eps);
      phi = p/p_steam_sat*Xi[Water]/(Xi[Water] + k_mair*X_air);
    end BaseProperties;

    redeclare function extends gasConstant
    algorithm
      R := dryair.R*(1-state.X[Water]) + steam.R*state.X[Water];
    end gasConstant;

    function saturationPressureLiquid
      "saturation curve valid for 273.16 <= T <= 373.16. Outside of these limits a (less accurate) result is returned"
      extends Modelica.Icons.Function;
      input SI.Temperature Tsat "saturation temperature";
      output SI.AbsolutePressure psat "saturation pressure";
      annotation(Inline=false,smoothOrder=5);
    algorithm
      psat := 611.657*Math.exp(17.2799 - 4102.99/(Tsat - 35.719));
    end saturationPressureLiquid;

    function sublimationPressureIce
      "saturation curve valid for 223.16 <= T <= 273.16. Outside of these limits a (less accurate) result is returned"
      extends Modelica.Icons.Function;
      input SI.Temperature Tsat "sublimation temperature";
      output SI.AbsolutePressure psat "sublimation pressure";
      annotation(Inline=false,smoothOrder=5);
    algorithm
      psat := 611.657*Math.exp(22.5159*(1.0 - 273.16/Tsat));
    end sublimationPressureIce;

    redeclare function extends saturationPressure
      "saturation curve valid for 223.16 <= T <= 373.16 (and slightly outside with less accuracy)"
      annotation(Inline=false,smoothOrder=5);
    algorithm
      psat := Utilities.spliceFunction(saturationPressureLiquid(Tsat),sublimationPressureIce(Tsat),Tsat-273.16,1.0);
    end saturationPressure;

//     function saturationPressureWithoutLimits_der "derivative of saturation pressure"
//       input SI.Temperature Tsat "saturation temperature";
//       input Real dT_sat "derivative of saturation temperature";
//       output Real dpsat "saturation pressure derivative";
//     algorithm
//       dpsat := 2509622.55443*dT_sat*Math.exp(17.2799-4102.99/(Tsat-35.719))/
// 	(Tsat-35.719)^2;
//     end saturationPressureWithoutLimits_der;

//     function saturationPressure_der "derivative of saturation pressure"
//       input SI.Temperature Tsat "saturation temperature";
//       input Real dT_sat "derivative of saturation temperature";
//       output Real dpsat "saturation pressure derivative";
//     algorithm
//       dpsat := if T > 224.15 and T < 422.15 then
// 	2509622.55443*dT_sat*Math.exp(17.2799-4102.99/(Tsat-35.719))/
// 	(Tsat-35.719)^2 else 0.0;
//     end saturationPressure_der;

//     model testpsat
//       Real T1(start = 220.0);
//       Real p1,p2,p3, p4;
//     equation
//       der(T1) = 100.0;
//       p1 = sublimationPressureIce(T1);
//       p2 = saturationPressureLiquid(T1);
//       p3 = if T1 < 273.16 then sublimationPressureIce(T1) else saturationPressureLiquid(T1);
//       p4 = saturationPressure(T1);
//     end testpsat;

   redeclare function extends enthalpyOfVaporization
      "enthalpy of vaporization of water"
   algorithm
    r0 := 1e3*(2501.0145 - (T - 273.15)*(2.3853 + (T - 273.15)*(0.002969 - (T
         - 273.15)*(7.5293e-5 + (T - 273.15)*4.6084e-7))));
   end enthalpyOfVaporization;

    function HeatCapacityOfWater
      "specific heat capacity of water (liquid only)"
      extends Modelica.Icons.Function;
      input Temperature T;
      output SpecificHeatCapacity cp_fl;
      annotation (Documentation(info="specific heat capacity of water (liquid and solid);
                 polynomial calculated by data from VDI-Waermeatlas 8. Edition (Db1)"));
    algorithm
      cp_fl := 1e3*(4.2166 - (T - 273.15)*(0.0033166 + (T - 273.15)*(0.00010295
         - (T - 273.15)*(1.3819e-6 + (T - 273.15)*7.3221e-9))));
    end HeatCapacityOfWater;

   redeclare function extends enthalpyOfLiquid
     annotation(Inline=false,smoothOrder=5);
   algorithm
     h := (T - 273.15)*1e3*(4.2166 - 0.5*(T - 273.15)*(0.0033166 + 0.333333*(T - 273.15)*(0.00010295
        - 0.25*(T - 273.15)*(1.3819e-6 + 0.2*(T - 273.15)*7.3221e-9))));
   end enthalpyOfLiquid;

   redeclare function extends enthalpyOfGas
     annotation(Inline=false,smoothOrder=5);
   algorithm
     h := SingleGasNasa.h_Tlow(data=steam, T=T, refChoice=3, h_off=46479.819+2501014.5)*X[Water]
          + SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)*(1.0-X[Water]);
   end enthalpyOfGas;

   redeclare function extends enthalpyOfCondensingGas
     annotation(Inline=false,smoothOrder=5);
   algorithm
     h := SingleGasNasa.h_Tlow(data=steam, T=T, refChoice=3, h_off=46479.819+2501014.5);
   end enthalpyOfCondensingGas;

  redeclare function extends heatCapacity_cp
      "Return specific heat capacity at constant pressure"
     annotation(Inline=false,smoothOrder=5);
  algorithm
    cp:= SingleGasNasa.cp_Tlow(dryair, state.T)*(1-state.X[Water]) + SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water];
  end heatCapacity_cp;

  redeclare function extends heatCapacity_cv
      "Return specific heat capacity at constant volume"
     annotation(Inline=false,smoothOrder=5);
  algorithm
    cv:= SingleGasNasa.cp_Tlow(dryair, state.T)*(1-state.X[Water]) +
      SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water]
      - gasConstant(state);
  end heatCapacity_cv;

  redeclare function extends dynamicViscosity
      "simple polynomial for dry air (moisture influence small), valid from 73.15 K to 373.15 K"
      import Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
    algorithm
    eta := Polynomials_Temp.evaluate({(-4.96717436974791E-011), 5.06626785714286E-008, 1.72937731092437E-005},
				     Cv.to_degC(state.T));
  end dynamicViscosity;

  redeclare function extends thermalConductivity
      "simple polynomial for dry air (moisture influence small), valid from 73.15 K to 373.15 K"
      import Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
    algorithm
    lambda := Polynomials_Temp.evaluate({(-4.8737307422969E-008), 7.67803133753502E-005, 0.0241814385504202},
					Cv.to_degC(state.T));
    end thermalConductivity;

    function h_pTX
      "Compute specific enthalpy from pressure, temperature and mass fraction"
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.MassFraction Xi[nXi] "Independent mass fractions of moist air";
      output SI.SpecificEnthalpy h "Specific enthalpy at p, T, Xi";
     annotation(Inline=false,smoothOrder=1);
    protected
      SI.AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
      SI.MassFraction x_sat "steam water mass fraction of saturation boundary";
      SI.MassFraction X_liquid "mass fraction of liquid water";
      SI.MassFraction X_steam "mass fraction of steam water";
      SI.MassFraction X_air "mass fraction of air";
    algorithm
      p_steam_sat :=saturationPressure(T);
      x_sat    :=k_mair*p_steam_sat/(p - p_steam_sat);
      X_liquid :=max(Xi[Water] - x_sat/(1 + x_sat), 0.0);
      X_steam  :=Xi[Water] - X_liquid;
      X_air    :=1 - Xi[Water];
      h        := {SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5),
                   SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)}*
                  {X_steam, X_air} + enthalpyOfLiquid(T)*X_liquid;
    end h_pTX;

    package Utilities "utility functions"
  function spliceFunction
    input Real pos;
    input Real neg;
    input Real x;
    input Real deltax=1;
    output Real out;
    annotation (derivative=spliceFunction_der);
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
  end spliceFunction;

  function spliceFunction_der
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

    end Utilities;

/* Flattened Modelica model:

function Modelica.Media.Air.MoistAir.h_pTX:der
  input Real p;
  input Real T;
  input Real Xi[size({"water", "air"}, 1)-1];
protected
  Real h;
  Real p_steam_sat;
  Real x_sat;
  Real X_liquid;
  Real X_steam;
  Real X_air;
  constant String _GlobalScope.dryair.name;
  constant Real _GlobalScope.dryair.MM;
  constant Real _GlobalScope.dryair.Hf;
  constant Real _GlobalScope.dryair.H0;
  constant Real _GlobalScope.dryair.Tlimit;
  constant Real _GlobalScope.dryair.alow[7];
  constant Real _GlobalScope.dryair.blow[2];
  constant Real _GlobalScope.dryair.ahigh[7];
  constant Real _GlobalScope.dryair.bhigh[2];
  constant Real _GlobalScope.dryair.R;
  constant String _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Air.name
     := "Air";
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM
     := 0.0289651159;
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Air.Hf
     := (-4333.83385840345);
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Air.H0
     := 298609.680343105;
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Air.Tlimit
     := 1000;
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Air.alow
    [7] := {10099.5016, (-196.827561), 5.00915511, (-0.00576101373),
    1.06685993E-005, (-7.94029797E-009), 2.18523191E-012};
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Air.blow
    [2] := {(-176.796731), (-3.921504225)};
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Air.ahigh
    [7] := {241521.443, (-1257.8746), 5.14455867, (-0.000213854179),
    7.06522784E-008, (-1.07148349E-011), 6.57780015E-016};
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Air.bhigh
    [2] := {6462.26319, (-8.147411905)};
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Air.R
     := 287.051224952979;
  constant String _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.name
     := "H2O";
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
     := 0.01801528;
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.Hf
     := (-13423382.8172529);
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.H0
     := 549760.647628014;
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.Tlimit
     := 1000;
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.alow
    [7] := {(-39479.6083), 575.573102, 0.931782653, 0.00722271286, (
    -7.34255737E-006), 4.95504349E-009, (-1.336933246E-012)};
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.blow
    [2] := {(-33039.7431), 17.24205775};
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.ahigh
    [7] := {1034972.096, (-2412.698562), 4.64611078, 0.002291998307, (
    -6.83683048E-007), 9.42646893E-011, (-4.82238053E-015)};
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.bhigh
    [2] := {(-13842.86509), (-7.97814851)};
  constant Real _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O.R
     := 461.523329085088;
  constant String _GlobalScope.steam.name;
  constant Real _GlobalScope.steam.MM;
  constant Real _GlobalScope.steam.Hf;
  constant Real _GlobalScope.steam.H0;
  constant Real _GlobalScope.steam.Tlimit;
  constant Real _GlobalScope.steam.alow[7];
  constant Real _GlobalScope.steam.blow[2];
  constant Real _GlobalScope.steam.ahigh[7];
  constant Real _GlobalScope.steam.bhigh[2];
  constant Real _GlobalScope.steam.R;
public
  input Real p_der;
  input Real T_der;
  input Real Xi_der[size({"water", "air"}, 1)-1];
  output Real h_der;
protected
  Real p_steam_sat_der;
  Real x_sat_der;
  Real X_liquid_der;
  Real X_steam_der;
  Real X_air_der;
  public
algorithm
  p_steam_sat_der := saturationPressure_Unique'"0753C608"':der(T, T_der);
  p_steam_sat := saturationPressure_Unique'"0753C608"'(T);
  x_sat_der := _GlobalScope.steam.MM*p_steam_sat_der/_GlobalScope.dryair.MM/(p-
    p_steam_sat)-_GlobalScope.steam.MM*p_steam_sat*(p_der-p_steam_sat_der)/
    _GlobalScope.dryair.MM/(p-p_steam_sat)^2;
  x_sat := _GlobalScope.steam.MM*p_steam_sat/_GlobalScope.dryair.MM/(p-
    p_steam_sat);
  X_liquid_der := if noEvent(Xi[1]-x_sat/(1+x_sat) > 0) then Xi_der[1]-x_sat_der
    /(1+x_sat)+x_sat*x_sat_der/(1+x_sat)^2 else 0;
  X_liquid := max(Xi[1]-x_sat/(1+x_sat), 0);
  X_steam_der := Xi_der[1]-X_liquid_der;
  X_steam := Xi[1]-X_liquid;
  X_air_der :=  -Xi_der[1];
  X_air := 1-Xi[1];
  h_der := {Modelica.Media.IdealGases.Common.SingleGasNasa.h_Tlow:der(
    _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O, T, true, 3,
     2547494.319, T_der, 0), Modelica.Media.IdealGases.Common.SingleGasNasa.h_Tlow:der
    (_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Air, T, true,
     3, 25104.684, T_der, 0)}*{X_steam, X_air}+{Modelica.Media.IdealGases.Common.SingleGasNasa.h_Tlow
    (_GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.H2O, T, true,
     3, 2547494.319), Modelica.Media.IdealGases.Common.SingleGasNasa.h_Tlow(
    _GlobalScope.Modelica.Media.IdealGases.Common.SingleGasesData.Air, T, true, 3,
     25104.684)}*{X_steam_der, X_air_der}+enthalpyOfLiquid_Unique'"0753C388"':der
    (T, T_der)*X_liquid+enthalpyOfLiquid_Unique'"0753C388"'(T)*X_liquid_der;
end Modelica.Media.Air.MoistAir.h_pTX:der;

    function h_pTX_der "derivative function for h_pTX"
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.MassFraction Xi[nXi] "Independent mass fractions of most air";
      input Real dp "Pressure";
      input Real dT "Temperature";
      input Real dXi[nXi] "Independent mass fractions of moist air";
      output Real dh "derivative of specific enthalpy at p, T, Xi";
    protected
      SI.AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
      Real p_steam_sat_der "derivative of saturation pressure of steam";
      SI.MassFraction x_sat "steam water mass fraction of saturation boundary";
      SI.MassFraction X_liquid "mass fraction of liquid water";
      SI.MassFraction X_steam "mass fraction of steam water";
      SI.MassFraction X_air "mass fraction of air";
      Real dh_T "derivative of h w.r.t. T";
      Real dh_p "derivative of h w.r.t. p";
      Real dh_Xi "derivative of h w.r.t. Xi";
      Real dX_liquid "change of liquid content with Xi";
      Real dX_steam "change of steam content with Xi";
      Real dX_air "change of air content with Xi";
      Boolean condensing "true if condensing conditions";
    algorithm
      p_steam_sat :=saturationPressure(T);
      x_sat    :=k_mair*p_steam_sat/(p - p_steam_sat);
      condensing := x_sat/(1 + x_sat) > Xi[Water];
      X_liquid :=max(Xi[Water] - x_sat/(1 + x_sat), 0.0);
      X_steam  :=Xi[Water] - X_liquid;
      X_air    :=1 - Xi[Water];
      dX_liquid := if condensing then 1.0 else 0.0;
      dX_steam :=  if condensing then 0.0 else 1.0;
      dX_air := -1.0;
      dh_T := {SingleGasNasa.cp_Tlow(data=steam,  T=T), SingleGasNasa.cp_Tlow(data=dryair, T=T)}
	       *{X_steam, X_air} + HeatCapacityOfWater(T)*X_liquid +  enthalpyOfLiquid(T)*YYYYY(dX_li_T/dT);
      dh_p := {SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5),
		SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)}*{dX_steam_dp, dX_air_dp}
	+ enthalpyOfLiquid(T)*dX_liquid_dp;
      dh_Xi := {SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5),
		SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)}*{dX_steam, dX_air}
	+ enthalpyOfLiquid(T)*dX_liquid;
      dh := dh_T*dT + dh_p*dp + dh_Xi*dXi;
    end h_pTX_der;
*/
  end MoistAir;

end Air;
