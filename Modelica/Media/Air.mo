within Modelica.Media;
package Air "Medium models for air"

  package SimpleAir "Air: Simple dry air model (0..100 degC)"

    extends Interfaces.PartialSimpleIdealGasMedium(
       mediumName="SimpleAir",
       cp_const=1005.45,
       MM_const=0.0289651159,
       R_gas=Constants.R/0.0289651159,
       eta_const=1.82e-5,
       lambda_const=0.026,
       T_min=Cv.from_degC(0),
       T_max=Cv.from_degC(100));

    import SI = Modelica.SIunits;
    import Cv = Modelica.SIunits.Conversions;
    import Modelica.Constants;

    constant FluidConstants[nS] fluidConstants=
      FluidConstants(iupacName={"simple air"},
                     casRegistryNumber={"not a real substance"},
                     chemicalFormula={"N2, O2"},
                     structureFormula={"N2, O2"},
                     molarMass=Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM)
      "constant data for the fluid";

    annotation (Documentation(info="<html>
                              <h4>Simple Ideal gas air model for low temperatures</h4>
                              <p>This model demonstrats how to use the PartialSimpleIdealGas base class to build a
                              simple ideal gas model with a limited temperature validity range.</p>
                              </html>"));
  end SimpleAir;

  package DryAirNasa "Air: Detailed dry air model as ideal gas (200..6000 K)"
    extends IdealGases.Common.SingleGasNasa(
     mediumName="Air",
     data=IdealGases.Common.SingleGasesData.Air,
     fluidConstants={IdealGases.Common.FluidData.N2});

    import Cv = Modelica.SIunits.Conversions;

  redeclare function dynamicViscosity
      "Simple polynomial for dry air (moisture influence small), valid from 73.15 K to 373.15 K"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output DynamicViscosity eta "Dynamic viscosity";
  algorithm
    eta := Incompressible.TableBased.Polynomials_Temp.evaluate({(-4.96717436974791E-011), 5.06626785714286E-008, 1.72937731092437E-005}, Cv.to_degC(state.T));
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
      lambda := Incompressible.TableBased.Polynomials_Temp.evaluate({(-4.8737307422969E-008), 7.67803133753502E-005, 0.0241814385504202},Cv.to_degC(state.T));

      annotation (Documentation(info="<html>
Thermal conductivity is computed from temperature using a second order polynomial with a range of validity between 73 and 373 K.
</html>"));
    end thermalConductivity;

    annotation ( Documentation(info="<HTML>
      <IMG SRC=\"../Images/Media/IdealGases/SingleGases/Air.png\"></HTML>"),
                Documentation(info="<html>
Ideal gas medium model for dry air based on the package <a href=Modelica://Modelica.Media.IdealGases>IdealGases</a> with additional functions for dynamic viscosity and thermal conductivity in a limited temperature range.
</html>"));
  end DryAirNasa;

  package MoistAir "Air: Moist air model (240 ... 400 K)"
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
    constant SI.MolarMass[2] MMX = {steam.MM,dryair.MM}
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
      T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
      p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
      Xi(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
      redeclare final constant Boolean standardOrderComponents=true)
      "Moist air base properties record"

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
      assert(T >= 200.0 and T <= 423.15, "
Temperature T is not in the allowed range
200.0 K <= (T =" + String(T) + " K) <= 423.15 K
required from medium model \""       + mediumName + "\".");
      MM = 1/(Xi[Water]/MMX[Water]+(1.0-Xi[Water])/MMX[Air]);

      p_steam_sat = min(saturationPressure(T),0.999*p);
      X_sat = min(p_steam_sat * k_mair/max(100*Constants.eps, p - p_steam_sat)*(1 - Xi[Water]), 1.0)
        "Water content at saturation with respect to actual water content";
      X_liquid = max(Xi[Water] - X_sat, 0.0);
      X_steam  = Xi[Water]-X_liquid;
      X_air    = 1-Xi[Water];

      h = specificEnthalpy_pTX(p,T,Xi);
      R = dryair.R*(X_air/(1 - X_liquid)) + steam.R*X_steam/(1 - X_liquid);
      //
      u = h - R*T;
      d = p/(R*T);
      /* Note, u and d are computed under the assumption that the volume of the liquid
         water is neglible with respect to the volume of air and of steam
      */
      state.p = p;
      state.T = T;
      state.X = X;

      // these x are per unit mass of DRY air!
      x_sat    = k_mair*p_steam_sat/max(100*Constants.eps,p - p_steam_sat);
      x_water = Xi[Water]/max(X_air,100*Constants.eps);
      phi = p/p_steam_sat*Xi[Water]/(Xi[Water] + k_mair*X_air);
      annotation(Documentation(info="<html>
This model computes thermodynamic properties of moist air from three independent (thermodynamic or/and numerical) state variables. Preferred numerical states are temperature T, pressure p and the reduced composition vector Xi, which contains the water mass fraction only. As an EOS the <b>ideal gas law</b> is used and associated restrictions apply. The model can also be used in the <b>fog region</b>, when moisture is present in its liquid state. However, it is assumed that the liquid water volume is negligible compared to that of the gas phase. Computation of thermal properties is based on property data of <a href=Modelica://Modelica.Media.Air.DryAirNasa> dry air</a> and water (source: VDI-W&auml;rmeatlas), respectively. Besides the standard thermodynamic variables <b>absolute and relative humidity</b>, x_water and phi, respectively, are given by the model. Upper case X denotes absolute humidity with respect to mass of moist air while absolute humidity with respect to mass of dry air only is denoted by a lower case x throughout the model. See <a href=Modelica://Modelica.Media.Air.MoistAir>package description</a> for further information.
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
      state := if size(X,1) == nX then ThermodynamicState(p=p,T=T, X=X) else
             ThermodynamicState(p=p,T=T, X=cat(1,X,{1-sum(X)}));
      annotation(smoothOrder=2,
                  Documentation(info="<html>
The <a href=Modelica://Modelica.Media.Air.MoistAir.ThermodynamicState>thermodynamic state record</a> is computed from pressure p, temperature T and composition X.
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
      state := if size(X,1) == nX then ThermodynamicState(p=p,T=T_phX(p,h,X),X=X) else
             ThermodynamicState(p=p,T=T_phX(p,h,X), X=cat(1,X,{1-sum(X)}));
      annotation(smoothOrder=2,
                  Documentation(info="<html>
The <a href=Modelica://Modelica.Media.Air.MoistAir.ThermodynamicState>thermodynamic state record</a> is computed from pressure p, specific enthalpy h and composition X.
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
      state := if size(X,1) == nX then ThermodynamicState(p=d*({steam.R,dryair.R}*X)*T,T=T,X=X) else
             ThermodynamicState(p=d*({steam.R,dryair.R}*cat(1,X,{1-sum(X)}))*T,T=T, X=cat(1,X,{1-sum(X)}));
      annotation(smoothOrder=2,
                  Documentation(info="<html>
The <a href=Modelica://Modelica.Media.Air.MoistAir.ThermodynamicState>thermodynamic state record</a> is computed from density d, temperature T and composition X.
</html>"));
    end setState_dTX;

  redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
  algorithm
    state := ThermodynamicState(p=Media.Common.smoothStep(x, state_a.p, state_b.p, x_small),
                                T=Media.Common.smoothStep(x, state_a.T, state_b.T, x_small),
                                X=Media.Common.smoothStep(x, state_a.X, state_b.X, x_small));
  end setSmoothState;

    function Xsaturation
      "Return absolute humitity per unit mass of moist air at saturation as a function of the thermodynamic state record"
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction X_sat "Steam mass fraction of sat. boundary";
    algorithm
      X_sat := k_mair/(state.p/min(saturationPressure(state.T),0.999*state.p) - 1 + k_mair);
      annotation(smoothOrder=2,
                  Documentation(info="<html>
Absolute humidity per unit mass of moist air at saturation is computed from pressure and temperature in the state record. Note, that unlike X_sat in the BaseProperties model this mass fraction refers to mass of moist air at saturation.
</html>"));
    end Xsaturation;

    function xsaturation
      "Return absolute humitity per unit mass of dry air at saturation as a function of the thermodynamic state record"
      input ThermodynamicState state "Thermodynamic state record";
      output MassFraction x_sat "Absolute humidity per unit mass of dry air";
    algorithm
      x_sat:=k_mair*saturationPressure(state.T)/max(100*Constants.eps,state.p - saturationPressure(state.T));
      annotation(smoothOrder=2,
                  Documentation(info="<html>
Absolute humidity per unit mass of dry air at saturation is computed from pressure and temperature in the thermodynamic state record.
</html>"));
    end xsaturation;

    function xsaturation_pT
      "Return absolute humitity per unit mass of dry air at saturation as a function of pressure p and temperature T"
      input AbsolutePressure p "Pressure";
      input SI.Temperature T "Temperature";
      output MassFraction x_sat "Absolute humidity per unit mass of dry air";
    algorithm
      x_sat:=k_mair*saturationPressure(T)/max(100*Constants.eps,p - saturationPressure(T));
      annotation(smoothOrder=2,
                  Documentation(info="<html>
Absolute humidity per unit mass of dry air at saturation is computed from pressure and temperature.
</html>"));
    end xsaturation_pT;

    function massFraction_pTphi
      "Return steam mass fraction as a function of relative humidity phi and temperature T"
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input Real phi "Relative humidity (0 ... 1.0)";
      output MassFraction X_steam "Absolute humidity, steam mass fraction";
    protected
      constant Real k = 0.621964713077499 "Ratio of molar masses";
      AbsolutePressure psat = saturationPressure(T) "Saturation pressure";
    algorithm
      X_steam := phi*k/(k*phi+p/psat-phi);
      annotation(smoothOrder=2,
                  Documentation(info="<html>
Absolute humidity per unit mass of moist air is computed from temperature, pressure and relative humidity.
</html>"));
    end massFraction_pTphi;

    function relativeHumidity_pTX
      "Return relative humidity as a function of pressure p, temperature T and composition X"
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.MassFraction[:] X "Composition";
      output Real phi "Relative humidity";
    protected
      SI.Pressure p_steam_sat "Saturation pressure";
      SI.MassFraction X_air "Dry air mass fraction";
    algorithm
      p_steam_sat :=min(saturationPressure(T), 0.999*p);
      X_air    :=1 - X[Water];
      phi :=max(0.0,min(1.0, p/p_steam_sat*X[Water]/(X[Water] + k_mair*X_air)));
      annotation(smoothOrder=2,
                  Documentation(info="<html>
Relative humidity is computed from pressure, temperature and composition with 1.0 as the upper limit at saturation. Water mass fraction is the first entry in the composition vector.
</html>"));
    end relativeHumidity_pTX;

    function relativeHumidity
      "Return relative humidity as a function of the thermodynamic state record"
      input ThermodynamicState state "Thermodynamic state";
      output Real phi "Relative humidity";
    algorithm
      phi:=relativeHumidity_pTX(state.p, state.T, state.X);
      annotation(smoothOrder=2,
                  Documentation(info="<html>
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
      R := dryair.R*(1-state.X[Water]) + steam.R*state.X[Water];
      annotation(smoothOrder=2,
                  Documentation(info="<html>
The ideal gas constant for moist air is computed from <a href=Modelica://Modelica.Media.Air.MoistAir.ThermodynamicState>thermodynamic state</a> assuming that all water is in the gas phase.
</html>"));
    end gasConstant;

    function gasConstant_X
      "Return ideal gas constant as a function from composition X"
      input SI.MassFraction X[:] "Gas phase composition";
      output SI.SpecificHeatCapacity R "Ideal gas constant";
    algorithm
      R := dryair.R*(1-X[Water]) + steam.R*X[Water];
      annotation(smoothOrder=2,
                  Documentation(info="<html>
The ideal gas constant for moist air is computed from the gas phase composition. The first entry in composition vector X is the steam mass fraction of the gas phase.
</html>"));
    end gasConstant_X;

    function saturationPressureLiquid
      "Return saturation pressure of water as a function of temperature T in the range of 273.16 to 373.16 K"

      extends Modelica.Icons.Function;
      input SI.Temperature Tsat "saturation temperature";
      output SI.AbsolutePressure psat "saturation pressure";
    algorithm
      psat := 611.657*Math.exp(17.2799 - 4102.99/(Tsat - 35.719));
      annotation(Inline=false,smoothOrder=5,derivative=saturationPressureLiquid_der,
        Documentation(info="<html>
Saturation pressure of water above the triple point temperature is computed from temperature. It's range of validity is between
273.16 and 373.16 K. Outside these limits a less accurate result is returned.
</html>"));
    end saturationPressureLiquid;

    function saturationPressureLiquid_der
      "Time derivative of saturationPressureLiquid"

      extends Modelica.Icons.Function;
      input SI.Temperature Tsat "Saturation temperature";
      input Real dTsat(unit="K/s") "Saturation temperature derivative";
      output Real psat_der(unit="Pa/s") "Saturation pressure";
    algorithm
    /*psat := 611.657*Math.exp(17.2799 - 4102.99/(Tsat - 35.719));*/
      psat_der:=611.657*Math.exp(17.2799 - 4102.99/(Tsat - 35.719))*4102.99*dTsat/(Tsat - 35.719)/(Tsat - 35.719);

      annotation(Inline=false,smoothOrder=5,
        Documentation(info="<html>
Derivative function of <a href=Modelica://Modelica.Media.Air.MoistAir.saturationPressureLiquid>saturationPressureLiquid</a>
</html>"));
    end saturationPressureLiquid_der;

    function sublimationPressureIce
      "Return sublimation pressure of water as a function of temperature T between 223.16 and 273.16 K"

      extends Modelica.Icons.Function;
      input SI.Temperature Tsat "sublimation temperature";
      output SI.AbsolutePressure psat "sublimation pressure";
    algorithm
      psat := 611.657*Math.exp(22.5159*(1.0 - 273.16/Tsat));
      annotation(Inline=false,smoothOrder=5,derivative=sublimationPressureIce_der,
        Documentation(info="<html>
Sublimation pressure of water below the triple point temperature is computed from temperature. It's range of validity is between
 223.16 and 273.16 K. Outside of these limits a less accurate result is returned.
</html>"));
    end sublimationPressureIce;

    function sublimationPressureIce_der
      "Derivative function for 'sublimationPressureIce'"

      extends Modelica.Icons.Function;
      input SI.Temperature Tsat "Sublimation temperature";
      input Real dTsat(unit="K/s") "Time derivative of sublimation temperature";
      output Real psat_der(unit="Pa/s") "Sublimation pressure";
    algorithm
      /*psat := 611.657*Math.exp(22.5159*(1.0 - 273.16/Tsat));*/
      psat_der:=611.657*Math.exp(22.5159*(1.0 - 273.16/Tsat))*22.5159*273.16*dTsat/Tsat/Tsat;
      annotation(Inline=false,smoothOrder=5,
        Documentation(info="<html>
Derivative function of <a href=Modelica://Modelica.Media.Air.MoistAir.sublimationPressureIce>saturationPressureIce</a>
</html>"));
    end sublimationPressureIce_der;

    redeclare function extends saturationPressure
      "Return saturation pressure of water as a function of temperature T between 223.16 and 373.16 K"

    algorithm
      psat := Utilities.spliceFunction(saturationPressureLiquid(Tsat),sublimationPressureIce(Tsat),Tsat-273.16,1.0);
      annotation(Inline=false,smoothOrder=5,derivative=saturationPressure_der,
        Documentation(info="<html>
Saturation pressure of water in the liquid and the solid region is computed using an Antoine-type correlation. It's range of validity is between 223.16 and 373.16 K. Outside of these limits a (less accurate) result is returned. Functions for the
<a href=Modelica://Modelica.Media.Air.MoistAir.sublimationPressureIce>solid</a> and the <a href=\"Modelica://Modelica.Media.Air.MoistAir.saturationPressureLiquid\"> liquid</a> region, respectively, are combined using the first derivative continuous <a href=Modelica://Modelica.Media.Air.MoistAir.Utilities.spliceFunction>spliceFunction</a>.
</html>"));
    end saturationPressure;

    function saturationPressure_der
      "Derivative function for 'saturationPressure'"
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
      annotation(Inline=false,smoothOrder=5,
        Documentation(info="<html>
Derivative function of <a href=Modelica://Modelica.Media.Air.MoistAir.saturationPressure>saturationPressure</a>
</html>"));
    end saturationPressure_der;

    function saturationTemperature
      "Return saturation temperature of water as a function of (partial) pressure p"

      input SI.Pressure p "Pressure";
      input SI.Temperature T_min=200 "Lower boundary of solution";
      input SI.Temperature T_max=400 "Upper boundary of solution";
      output SI.Temperature T "Saturation temperature";

    protected
    package Internal
       extends Modelica.Media.Common.OneNonLinearEquation;

     redeclare record extends f_nonlinear_Data
       // Define data to be passed to user function
     end f_nonlinear_Data;

     redeclare function extends f_nonlinear
     algorithm
        y:=saturationPressure(x);
      // Compute the non-linear equation: y = f(x, Data)
     end f_nonlinear;

     // Dummy definition
     redeclare function extends solve
     end solve;
    end Internal;
    algorithm
      T:=Internal.solve(p, T_min, T_max);
      annotation (Documentation(info="<html>
 Computes saturation temperature from (partial) pressure via numerical inversion of the function <a href=Modelica://Modelica.Media.Air.MoistAir.saturationPressure>saturationPressure</a>. Therefore additional inputs are required (or the defaults are used) for upper and lower temperature bounds.
</html>"));
    end saturationTemperature;

   redeclare function extends enthalpyOfVaporization
      "Return enthalpy of vaporization of water as a function of temperature T, 0 - 130 degC"

   algorithm
    /*r0 := 1e3*(2501.0145 - (T - 273.15)*(2.3853 + (T - 273.15)*(0.002969 - (T
      - 273.15)*(7.5293e-5 + (T - 273.15)*4.6084e-7))));*/
   //katrin: replaced by linear correlation, simpler and more accurate in the entire region
   //source VDI-Waermeatlas, linear inter- and extrapolation between values for 0.01°C and 40°C.
   r0:=(2405900-2500500)/(40-0)*(T-273.16)+2500500;
     annotation(smoothOrder=2,
                  Documentation(info="<html>
Enthalpy of vaporization of water is computed from temperature in the region of 0 to 130 °C.
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
</html>"),       smoothOrder=2);
    end HeatCapacityOfWater;

   redeclare function extends enthalpyOfLiquid
      "Return enthalpy of liquid water as a function of temperature T(use enthalpyOfWater instead)"

   algorithm
     h := (T - 273.15)*1e3*(4.2166 - 0.5*(T - 273.15)*(0.0033166 + 0.333333*(T - 273.15)*(0.00010295
        - 0.25*(T - 273.15)*(1.3819e-6 + 0.2*(T - 273.15)*7.3221e-9))));
     annotation(Inline=false,smoothOrder=5,
        Documentation(info="<html>
Specific enthalpy of liquid water is computed from temperature using a polynomial approach. Kept for compatibility reasons, better use <a href=Modelica://Modelica.Media.Air.MoistAir.enthalpyOfWater>enthalpyOfWater</a> instead.
</html>"));
   end enthalpyOfLiquid;

   redeclare function extends enthalpyOfGas
      "Return specific enthalpy of gas (air and steam) as a function of temperature T and composition X"

   algorithm
     h := SingleGasNasa.h_Tlow(data=steam, T=T, refChoice=3, h_off=46479.819+2501014.5)*X[Water]
          + SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)*(1.0-X[Water]);
     annotation(Inline=false,smoothOrder=5,
        Documentation(info="<html>
Specific enthalpy of moist air is computed from temperature, provided all water is in the gaseous state. The first entry in the composition vector X must be the mass fraction of steam. For a function that also covers the fog region please refer to <a href=Modelica://Modelica.Media.Air.MoistAir.h_pTX>h_pTX</a>.
</html>"));
   end enthalpyOfGas;

   redeclare function extends enthalpyOfCondensingGas
      "Return specific enthalpy of steam as a function of temperature T"

   algorithm
     h := SingleGasNasa.h_Tlow(data=steam, T=T, refChoice=3, h_off=46479.819+2501014.5);
     annotation(Inline=false,smoothOrder=5,
        Documentation(info="<html>
Specific enthalpy of steam is computed from temperature.
</html>"));
   end enthalpyOfCondensingGas;

   redeclare function extends enthalpyOfNonCondensingGas
      "Return specific enthalpy of dry air as a function of temperature T"

   algorithm
     h := SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684);
     annotation(Inline=false,smoothOrder=1,
        Documentation(info="<html>
Specific enthalpy of dry air is computed from temperature.
</html>"));
   end enthalpyOfNonCondensingGas;

  function enthalpyOfWater
      "Computes specific enthalpy of water (solid/liquid) near atmospheric pressure from temperature T"
    input SIunits.Temperature T "Temperature";
    output SIunits.SpecificEnthalpy h "Specific enthalpy of water";
  algorithm
  /*simple model assuming constant properties:
  heat capacity of liquid water:4200 J/kg
  heat capacity of solid water: 2050 J/kg
  enthalpy of fusion (liquid=>solid): 333000 J/kg*/

    h:=Utilities.spliceFunction(4200*(T-273.15),2050*(T-273.15)-333000,T-273.16,0.1);
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
    input SIunits.Temperature T "Temperature";
    input Real dT(unit="K/s") "Time derivative of temperature";
    output Real dh(unit="J/(kg.s)") "Time derivative of specific enthalpy";
  algorithm
  /*simple model assuming constant properties:
  heat capacity of liquid water:4200 J/kg
  heat capacity of solid water: 2050 J/kg
  enthalpy of fusion (liquid=>solid): 333000 J/kg*/

    //h:=Utilities.spliceFunction(4200*(T-273.15),2050*(T-273.15)-333000,T-273.16,0.1);
    dh:=Utilities.spliceFunction_der(4200*(T-273.15),2050*(T-273.15)-333000,T-273.16,0.1,4200*dT,2050*dT,dT,0);
      annotation (Documentation(info="<html>
Derivative function for <a href=Modelica://Modelica.Media.Air.MoistAir.enthalpyOfWater>enthalpyOfWater</a>.

</html>"));
  end enthalpyOfWater_der;

   redeclare function extends pressure
      "Returns pressure of ideal gas as a function of the thermodynamic state record"

   algorithm
    p := state.p;
     annotation(smoothOrder=2,
                  Documentation(info="<html>
Pressure is returned from the thermodynamic state record input as a simple assignment.
</html>"));
   end pressure;

   redeclare function extends temperature
      "Return temperature of ideal gas as a function of the thermodynamic state record"

   algorithm
     T := state.T;
     annotation(smoothOrder=2,
                  Documentation(info="<html>
Temperature is returned from the thermodynamic state record input as a simple assignment.
</html>"));
   end temperature;

  function T_phX
      "Return temperature as a function of pressure p, specific enthalpy h and composition X"
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
        y := h_pTX(p,x,X);
    end f_nonlinear;

    // Dummy definition has to be added for current Dymola
    redeclare function extends solve
    end solve;
  end Internal;

  algorithm
    T := Internal.solve(h, 240, 400, p, X[1:nXi], steam);
      annotation (Documentation(info="<html>
Temperature is computed from pressure, specific enthalpy and composition via numerical inversion of function <a href=Modelica://Modelica.Media.Air.MoistAir.h_pTX>h_pTX</a>.
</html>"));
  end T_phX;

   redeclare function extends density
      "Returns density of ideal gas as a function of the thermodynamic state record"

   algorithm
     d := state.p/(gasConstant(state)*state.T);
     annotation(smoothOrder=2,
                  Documentation(info="<html>
Density is computed from pressure, temperature and composition in the thermodynamic state record applying the ideal gas law.
</html>"));
   end density;

  redeclare function extends specificEnthalpy
      "Return specific enthalpy of moist air as a function of the thermodynamic state record"

  algorithm
    h := h_pTX(state.p, state.T, state.X);
    annotation(smoothOrder=2,
                  Documentation(info="<html>
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
    p_steam_sat :=saturationPressure(T);
    //p_steam_sat :=min(saturationPressure(T), 0.999*p);
    X_sat:=min(p_steam_sat*k_mair/max(100*Constants.eps, p - p_steam_sat)*(1 - X[
      Water]), 1.0);
    X_liquid :=max(X[Water] - X_sat, 0.0);
    X_steam  :=X[Water] - X_liquid;
    X_air    :=1 - X[Water];
   /* h        := {SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5),
               SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)}*
    {X_steam, X_air} + enthalpyOfLiquid(T)*X_liquid;*/
     h        := {SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5),
                 SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)}*
      {X_steam, X_air} + enthalpyOfWater(T)*X_liquid;
    annotation(derivative=h_pTX_der, Inline=false,
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
    Real dX_steam(unit="1/s") "Time deriveative of steam mass fraction";
    Real dX_air(unit="1/s") "Time derivative of dry air mass fraction";
    Real dX_liq(unit="1/s")
        "Time derivative of liquid/solid water mass fraction";
    Real dps(unit="Pa/s") "Time derivative of saturation pressure";
    Real dx_sat(unit="1/s")
        "Time derivative of abolute humidity per unit mass of dry air";
  algorithm
    p_steam_sat :=saturationPressure(T);
    x_sat:=p_steam_sat*k_mair/max(100*Modelica.Constants.eps, p - p_steam_sat);
    X_sat:=min(x_sat*(1 - X[Water]), 1.0);
    X_liquid :=Utilities.spliceFunction(X[Water] - X_sat, 0.0, X[Water] - X_sat,1e-6);
    X_steam  :=X[Water] - X_liquid;
    X_air    :=1 - X[Water];

    dX_air:=-dX[Water];
    dps:=saturationPressure_der(Tsat=T, dTsat=dT);
    dx_sat:=k_mair*(dps*(p-p_steam_sat)-p_steam_sat*(dp-dps))/(p-p_steam_sat)/(p-p_steam_sat);
    dX_liq:=Utilities.spliceFunction_der(X[Water] - X_sat, 0.0, X[Water] - X_sat,1e-6,(1+x_sat)*dX[Water]-(1-X[Water])*dx_sat,0.0,(1+x_sat)*dX[Water]-(1-X[Water])*dx_sat,0.0);
    //dX_liq:=if X[Water]>=X_sat then (1+x_sat)*dX[Water]-(1-X[Water])*dx_sat else 0;
    dX_steam:=dX[Water]-dX_liq;

    h_der:= X_steam*Modelica.Media.IdealGases.Common.SingleGasNasa.h_Tlow_der(data=steam, T=T, refChoice=3, h_off=46479.819+2501014.5, dT=dT)+
            dX_steam*Modelica.Media.IdealGases.Common.SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5) +
            X_air*Modelica.Media.IdealGases.Common.SingleGasNasa.h_Tlow_der(data=dryair, T=T, refChoice=3, h_off=25104.684, dT=dT) +
            dX_air*Modelica.Media.IdealGases.Common.SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684) +
            X_liquid*enthalpyOfWater_der(T=T, dT=dT) +
            dX_liq*enthalpyOfWater(T);

    annotation(Inline=false,smoothOrder=1,
        Documentation(info="<html>
Derivative function for <a href=Modelica://Modelica.Media.Air.MoistAir.h_pTX>h_pTX</a>.
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
    IsentropicExponent gamma =  isentropicExponent(state) "Isentropic exponent";
    protected
    MassFraction[nX] X "complete X-vector";
  algorithm
    X := if reducedX then cat(1,state.X,{1-sum(state.X)}) else state.X;
    h := {SingleGasNasa.h_Tlow(data=steam,  T=state.T, refChoice=3, h_off=46479.819+2501014.5),
        SingleGasNasa.h_Tlow(data=dryair, T=state.T, refChoice=3, h_off=25104.684)}*X;

    h_is := h + gamma/(gamma - 1.0)*(state.T*gasConstant(state))*
      ((p2/state.p)^((gamma - 1)/gamma) - 1.0);
  end isentropicEnthalpyApproximation;

  redeclare function extends specificInternalEnergy
      "Return specific internal energy of moist air as a function of the thermodynamic state record"
    extends Modelica.Icons.Function;
    output SI.SpecificInternalEnergy u "Specific internal energy";
  algorithm
     u := specificInternalEnergy_pTX(state.p,state.T,state.X);

    annotation(smoothOrder=2,
                  Documentation(info="<html>
Specific internal energy is determined from the thermodynamic state record, assuming that the liquid or solid water volume is negligible.
</html>"));
  end specificInternalEnergy;

  function specificInternalEnergy_pTX
      "Return specific internal energy of moist air as a function of pressure p, temperature T and composition X"
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
    p_steam_sat :=saturationPressure(T);
    X_sat:=min(p_steam_sat*k_mair/max(100*Constants.eps, p - p_steam_sat)*(1 - X[
      Water]), 1.0);
    X_liquid :=max(X[Water] - X_sat, 0.0);
    X_steam  :=X[Water] - X_liquid;
    X_air    :=1 - X[Water];
    R_gas:= dryair.R*X_air/(1-X_liquid)+steam.R* X_steam/(1-X_liquid);
    u       := X_steam*SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5)+
               X_air*SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)
               + enthalpyOfWater(T)*X_liquid-R_gas*T;

      annotation (derivative=specificInternalEnergy_pTX_der, Documentation(info="<html>
Specific internal energy is determined from pressure p, temperature T and composition X, assuming that the liquid or solid water volume is negligible.
</html>"));
  end specificInternalEnergy_pTX;

  function specificInternalEnergy_pTX_der
      "Derivative function for specificInternalEnergy_pTX"
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
    Real dX_steam(unit="1/s") "Time deriveative of steam mass fraction";
    Real dX_air(unit="1/s") "Time derivative of dry air mass fraction";
    Real dX_liq(unit="1/s")
        "Time derivative of liquid/solid water mass fraction";
    Real dps(unit="Pa/s") "Time derivative of saturation pressure";
    Real dx_sat(unit="1/s")
        "Time derivative of abolute humidity per unit mass of dry air";
    Real dR_gas(unit="J/(kg.K.s)") "Time derivative of ideal gas constant";
  algorithm
    p_steam_sat :=saturationPressure(T);
    x_sat:=p_steam_sat*k_mair/max(100*Modelica.Constants.eps, p - p_steam_sat);
    X_sat:=min(x_sat*(1 - X[Water]), 1.0);
    X_liquid :=Utilities.spliceFunction(X[Water] - X_sat, 0.0, X[Water] - X_sat,1e-6);
    X_steam  :=X[Water] - X_liquid;
    X_air    :=1 - X[Water];
    R_gas:= steam.R*X_steam/(1-X_liquid)+dryair.R* X_air/(1-X_liquid);

    dX_air:=-dX[Water];
    dps:=saturationPressure_der(Tsat=T, dTsat=dT);
    dx_sat:=k_mair*(dps*(p-p_steam_sat)-p_steam_sat*(dp-dps))/(p-p_steam_sat)/(p-p_steam_sat);
    dX_liq:=Utilities.spliceFunction_der(X[Water] - X_sat, 0.0, X[Water] - X_sat,1e-6,(1+x_sat)*dX[Water]-(1-X[Water])*dx_sat,0.0,(1+x_sat)*dX[Water]-(1-X[Water])*dx_sat,0.0);
    dX_steam:=dX[Water]-dX_liq;
    dR_gas:=(steam.R*(dX_steam*(1-X_liquid)+dX_liq*X_steam)+dryair.R*(dX_air*(1-X_liquid)+dX_liq*X_air))/(1-X_liquid)/(1-X_liquid);

    u_der:=X_steam*SingleGasNasa.h_Tlow_der(data=steam, T=T, refChoice=3, h_off=46479.819+2501014.5, dT=dT)+
           dX_steam*SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5) +
           X_air*SingleGasNasa.h_Tlow_der(data=dryair, T=T, refChoice=3, h_off=25104.684, dT=dT) +
           dX_air*SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684) +
           X_liquid*enthalpyOfWater_der(T=T, dT=dT) +
           dX_liq*enthalpyOfWater(T) - dR_gas*T-R_gas*dT;
      annotation (Documentation(info="<html>
Derivative function for <a href=Modelica://Modelica.Media.Air.MoistAir.specificInternalEnergy_pTX>specificInternalEnergy_pTX</a>.
</html>"));
  end specificInternalEnergy_pTX_der;

   redeclare function extends specificEntropy
      "Return specific entropy from thermodynamic state record, only valid for phi<1"

    protected
      MoleFraction[2] Y = massToMoleFractions(state.X,{steam.MM,dryair.MM})
        "molar fraction";
   algorithm
     s:=SingleGasNasa.s0_Tlow(dryair, state.T)*(1-state.X[Water])
       + SingleGasNasa.s0_Tlow(steam, state.T)*state.X[Water]
       - (state.X[Water]*Modelica.Constants.R/MMX[Water]*(if state.X[Water]<Modelica.Constants.eps then state.X[Water] else Modelica.Math.log(Y[Water]*state.p/reference_p))
         + (1-state.X[Water])*Modelica.Constants.R/MMX[Air]*(if (1-state.X[Water])<Modelica.Constants.eps then (1-state.X[Water]) else Modelica.Math.log(Y[Air]*state.p/reference_p)));
       annotation(Inline=false,smoothOrder=2,
        Documentation(info="<html>
Specific entropy is calculated from the thermodynamic state record, assuming ideal gas behavior and including entropy of mixing. Liquid or solid water is not taken into account, the entire water content X[1] is assumed to be in the vapor state (relative humidity below 1.0).
</html>"));
   end specificEntropy;

  redeclare function extends specificGibbsEnergy
      "Return specific Gibbs energy as a function of the thermodynamic state record, only valid for phi<1"
    extends Modelica.Icons.Function;
  algorithm
    g := h_pTX(state.p,state.T,state.X) - state.T*specificEntropy(state);
    annotation(smoothOrder=2,
                  Documentation(info="<html>
The Gibbs Energy is computed from the thermodynamic state record for moist air with a water content below saturation.
</html>"));
  end specificGibbsEnergy;

  redeclare function extends specificHelmholtzEnergy
      "Return specific Helmholtz energy as a function of the thermodynamic state record, only valid for phi<1"
    extends Modelica.Icons.Function;
  algorithm
    f := h_pTX(state.p,state.T,state.X) - gasConstant(state)*state.T - state.T*specificEntropy(state);
    annotation(smoothOrder=2,
                  Documentation(info="<html>
The Specific Helmholtz Energy is computed from the thermodynamic state record for moist air with a water content below saturation.
</html>"));
  end specificHelmholtzEnergy;

   redeclare function extends specificHeatCapacityCp
      "Return specific heat capacity at constant pressure as a function of the thermodynamic state record"

    protected
     Real dT(unit="s/K") = 1.0;
   algorithm
     cp := h_pTX_der(state.p,state.T,state.X, 0.0, 1.0, zeros(size(state.X,1)))*dT
        "Definition of cp: dh/dT @ constant p";
     //      cp:= SingleGasNasa.cp_Tlow(dryair, state.T)*(1-state.X[Water])
     //        + SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water];
     annotation(Inline=false,smoothOrder=2,
        Documentation(info="<html>
The specific heat capacity at constant pressure <b>cp</b> is computed from temperature and composition for a mixture of steam (X[1]) and dry air. All water is assumed to be in the vapor state.
</html>"));
   end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv
      "Return specific heat capacity at constant volume as a function of the thermodynamic state record"

  algorithm
    cv:= SingleGasNasa.cp_Tlow(dryair, state.T)*(1-state.X[Water]) +
      SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water]
      - gasConstant(state);
     annotation(Inline=false,smoothOrder=2,
        Documentation(info="<html>
The specific heat capacity at constant density <b>cv</b> is computed from temperature and composition for a mixture of steam (X[1]) and dry air. All water is assumed to be in the vapor state.
</html>"));
  end specificHeatCapacityCv;

  redeclare function extends dynamicViscosity
      "Return dynamic viscosity as a function of the thermodynamic state record, valid from 73.15 K to 373.15 K"

      import Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
  algorithm
    eta := Polynomials_Temp.evaluate({(-4.96717436974791E-011), 5.06626785714286E-008, 1.72937731092437E-005},
         Cv.to_degC(state.T));
    annotation(smoothOrder=2,
                  Documentation(info="<html>
Dynamic viscosity is computed from temperature using a simple polynomial for dry air, assuming that moisture influence is small. Range of  validity is from 73.15 K to 373.15 K.
</html>"));
  end dynamicViscosity;

  redeclare function extends thermalConductivity
      "Return thermal conductivity as a function of the thermodynamic state record, valid from 73.15 K to 373.15 K"

      import Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
  algorithm
    lambda := Polynomials_Temp.evaluate({(-4.8737307422969E-008), 7.67803133753502E-005, 0.0241814385504202},
     Cv.to_degC(state.T));
    annotation(smoothOrder=2,
                  Documentation(info="<html>
Thermal conductivity is computed from temperature using a simple polynomial for dry air, assuming that moisture influence is small. Range of  validity is from 73.15 K to 373.15 K.
</html>"));
  end thermalConductivity;

    package Utilities "utility functions"
      function spliceFunction "Spline interpolation of two functions"
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

      final parameter SIunits.Temperature[n_T] T_const={T_min - T_step + i*T_step for i in
              1:n_T} "Constant temperatures";
      final parameter SIunits.SpecificEnthalpy[n_h] h_const={(i-1)*h_step+h_min for i in 1:n_h}
        "Constant enthalpies";
      final parameter Real[n_phi] phi_const={(i-1)*phi_step+phi_min for i in 1:n_phi}
        "Constant relative humidities";
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
        medium_T[i].T=T_const[i];
        medium_T[i].p=p_const;
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
        medium_phi[i].p=p_const;
        ps_phi[i] = p_const*x/phi_const[i]/(Medium.k_mair + x);
        T_phi[i] = if x < 5e-6 then 200 else Medium.saturationTemperature(
          ps_phi[i]);
        medium_phi[i].T = T_phi[i];
        medium_phi[i].Xi = {x/(1 + x)};
        hx_phi[i] = medium_phi[i].h*(medium_phi[i].x_water + 1);
        y_phi[i] = hx_phi[i] - diagSlope*x;
      end for;

      annotation (experiment(StopTime=1), Documentation(info="<html>
<p>This model produces psychrometric data from the moist air model in this library to be plotted in charts. The two most common chart varieties are the Mollier Diagram and the Psycrometric Chart. The first is widely used in some European countries while the second is more common in the Anglo-American world. Specific enthalpy is plotted over absolute humidity in the Mollier Diagram, it is the other way round in the Psychrometric Chart.<br>
It must be noted that the relationship of both axis variables is not right-angled, the absolute humidity follows a slope which equals the enthalpy of vaporization at 0°C. For better reading and in oder to reduce the fog region the humidity axis is rotated to obtain a right-angled plot. Both charts usually contain additional information as isochores or auxiliary scales for e.g. heat ratios. Those information are omitted in this model and the charts below. Other important features of psychrometric chart data are that all mass specific variables (like absolute humidity, specific enthalpy etc.) are expressed in terms of kg dry air and that their baseline of 0 enthalpy is found at 0°C and zero humidity. </p>

<p><img src=\"../../Modelica/Images/Media/Air/Mollier.png\">
<img src=\"../../Modelica/Images/Media/Air/PsycroChart.png\"></p>
<p>
<b>Legend:</b> blue - constant specific enthalpy, red - constant temperature, black - constant relative humidity</p>

<p>The model provides data for lines of constant specific enthalpy, temperature and relative humidity in a Mollier Diagram or Psychrometric Chart as they were used for the figures above. For limitations and ranges of validity please refer to the <a href=Modelica://Modelica.Media.Air.MoistAir>MoistAir package description</a>. Absolute humidity <b>x</b> is increased with time in this model. The specific enthalpies adjusted for plotting are then obtained from:</p>
<ul>
<li><b>y_h</b>: constant specific enthalpy</li>
<li><b>y_T</b>: constant temperature</li>
<li><b>y_phi</b>: constant relative humidity</li>
</ul>
</html>"));
    end PsychrometricData;

    annotation (Documentation(info="<html>
<h4>Thermodynamic Model</h4>
<p>This package provides a full thermodynamic model of moist air including the fog region and temperatures below zero degC.
The governing assumptions in this model are:</p>
<ul>
<li>the perfect gas law applies</li>
<li>water volume other than that of steam is neglected</li></ul>
<p>All extensive properties are expressed in terms of the total mass in order to comply with other media in this libary. However, for moist air it is rather common to express the absolute humidity in terms of mass of dry air only, which has advantages when working with charts. In addition, care must be taken, when working with mass fractions with respect to total mass, that all properties refer to the same water content when being used in mathematical operations (which is always the case if based on dry air only). Therefore two absolute humidities are computed in the <b>BaseProperties</b> model: <b>X</b> denotes the absolute humidity in terms of the total mass while <b>x</b> denotes the absolute humitity per unit mass of dry air. In addition, the relative humidity <b>phi</b> is also computed.</p>
<p>At the triple point temperature of water of 0.01°C or 273.16 K and a relative humidity greater than 1 fog may be present as liquid and as ice resulting in a specific enthalpy somewhere between those of the two isotherms for solid and liquid fog, respectively. For numerical reasons a coexisting mixture of 50% solid and 50% liquid fog is assumed in the fog region at the triple point in this model.

<h4>Range of validity</h4>
<p>From the assumptions mentioned above it follows that the <b>pressure</b> should be in the region around <b>atmospheric</b> conditions or below (a few bars may still be fine though). Additionally a very high water content at low temperatures would yield incorrect densities, because the volume of the liquid or solid phase would not be negligible anymore. The model does not provide information on limits for water drop size in the fog region or transport information for the actual condensation or evaporation process in combination with surfaces. All excess water which is not in its vapour state is assumed to be still present in the air regarding its energy but not in terms of its spatial extent.<br><br>
The thermodynamic model may be used for <b>temperatures</b> ranging from <b>240 - 400 K</b>. This holds for all functions unless otherwise stated in their description. However, although the model works at temperatures above the saturation temperature it is questionable to use the term \"relative humidity\" in this region. Please note, that although several functions compute pure water properties, they are designed to be used within the moist air medium model where properties are dominated by air and steam in their vapor states, and not for pure liquid water applications.</p>

<h4>Transport Properties</h4>
<p>Several additional functions that are not needed to describe the thermodynamic system, but are required to model transport processes, like heat and mass transfer, may be called. They usually neglect the moisture influence unless otherwise stated.</p>

<h4>Application</h4>
<p>The model's main area of application is all processes that involve moist air cooling under near atmospheric pressure with possible moisture condensation. This is the case in all domestic and industrial air conditioning applications. Another large domain of moist air applications covers all processes that deal with dehydration of bulk material using air as a transport medium. Engineering tasks involving moist air are often performed (or at least visualized) by using charts that contain all relevant thermodynamic data for a moist air system. These so called psychrometric charts can be generated from the medium properties in this package. The model <a href=\"Modelica://Modelica.Media.Air.MoistAir.PsychrometricData\">PsychrometricData</a> may be used for this purpose in order to obtain data for figures like those below (the plotting itself is not part of the model though).</p>

<p><img src=\"../../Modelica/Images/Media/Air/Mollier.png\">
<img src=\"../../Modelica/Images/Media/Air/PsycroChart.png\"></p>
<p>
<b>Legend:</b> blue - constant specific enthalpy, red - constant temperature, black - constant relative humidity</p>

</html>"));
  end MoistAir;

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
