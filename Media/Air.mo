package Air "Media models for air" 
  
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
                              <h2>Simple Ideal gas air model for low temperatures</h2>
                              <p>This model demonstrats how to use the PartialSimpleIdealGas base class to build a
                              simple ideal gas model with a limited temperature validity range.</p>
                              </html>"));
  end SimpleAir;
  
  package DryAirNasa "Air: Detailed dry air model as ideal gas (200..6000 K)" 
    extends IdealGases.SingleGases.Air(fluidConstants={IdealGases.Common.FluidData.N2});
    import Cv = Modelica.SIunits.Conversions;
    
  redeclare function dynamicViscosity 
      "simple polynomial for dry air (moisture influence small), valid from 73.15 K to 373.15 K" 
    extends Modelica.Icons.Function;
    input ThermodynamicState state;
    output DynamicViscosity eta "Dynamic viscosity";
  algorithm 
    eta := Incompressible.TableBased.Polynomials_Temp.evaluate({(-4.96717436974791E-011), 5.06626785714286E-008, 1.72937731092437E-005}, Cv.to_degC(state.T));
  end dynamicViscosity;
    
    redeclare function thermalConductivity 
      "simple polynomial for dry air (moisture influence small), valid from 73.15 K to 373.15 K" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      input Integer method=1 "1: Eucken Method, 2: Modified Eucken Method";
      output ThermalConductivity lambda "Thermal conductivity";
    algorithm 
      lambda := Incompressible.TableBased.Polynomials_Temp.evaluate({(-4.8737307422969E-008), 7.67803133753502E-005, 0.0241814385504202},Cv.to_degC(state.T));
    end thermalConductivity;
    
    annotation (Documentation(info="<html>
  
</html>"));
  end DryAirNasa;
  
  package MoistAir "Air: Moist air model" 
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
      MassFraction X_sat 
        "steam water mass fraction of saturation boundary in kg_water/kg_moistair";
      MassFraction x_sat 
        "steam water mass content of saturation boundary in kg_water/kg_dryair";
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
      R = dryair.R*(1 - X_steam/(1 - X_liquid)) + steam.R*X_steam/(1 - X_liquid);
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
    end BaseProperties;
    
    function Xsaturation 
      "Steam water mass fraction of saturation boundary in kg_water/kg_moistair" 
      input ThermodynamicState state "shermodynamic state";
      output MassFraction X_sat "steam mass fraction of sat. boundary";
    algorithm 
      X_sat := k_mair/(state.p/min(saturationPressure(state.T),0.999*state.p) - 1 + k_mair);
    end Xsaturation;
    
    function massFraction_pTphi 
      "Compute the steam mass fraction from relative humidity and T" 
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input Real phi "relative humidity (0 ... 1.0)";
      output MassFraction X_steam "steam Mass fractions";
    protected 
      constant Real k = 0.621964713077499 "ratio of molar masses";
      AbsolutePressure psat = saturationPressure(T) "saturation pressure";
    algorithm 
      X_steam := phi*k/(k*phi+p/psat-phi);
    end massFraction_pTphi;
    
    redeclare function setState_pTX 
      "Return thermodynamic state as function of p, T and composition X" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm 
      state := if size(X,1) == nX then ThermodynamicState(p=p,T=T, X=X) else 
             ThermodynamicState(p=p,T=T, X=cat(1,X,{1-sum(X)}));
    end setState_pTX;
    
    redeclare function setState_phX 
      "Return thermodynamic state as function of p, h and composition X" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm 
      state := if size(X,1) == nX then ThermodynamicState(p=p,T=T_phX(p,h,X),X=X) else 
             ThermodynamicState(p=p,T=T_phX(p,h,X), X=cat(1,X,{1-sum(X)}));
    end setState_phX;
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
    redeclare function setState_dTX 
      "Return thermodynamic state as function of d, T and composition X" 
      extends Modelica.Icons.Function;
      input Density d "density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm 
      state := if size(X,1) == nX then ThermodynamicState(p=d*({steam.R,dryair.R}*X)*T,T=T,X=X) else 
             ThermodynamicState(p=d*({steam.R,dryair.R}*cat(1,X,{1-sum(X)}))*T,T=T, X=cat(1,X,{1-sum(X)}));
    end setState_dTX;
    
    redeclare function extends gasConstant 
      "Gas constnat: computation neglects liquid fraction" 
    algorithm 
      R := dryair.R*(1-state.X[Water]) + steam.R*state.X[Water];
    end gasConstant;
    
    function saturationPressureLiquid 
      "Saturation curve valid for 273.16 <= T <= 373.16. Outside of these limits a (less accurate) result is returned" 
      extends Modelica.Icons.Function;
      input SI.Temperature Tsat "saturation temperature";
      output SI.AbsolutePressure psat "saturation pressure";
      annotation(Inline=false,smoothOrder=5);
    algorithm 
      psat := 611.657*Math.exp(17.2799 - 4102.99/(Tsat - 35.719));
    end saturationPressureLiquid;
    
    function sublimationPressureIce 
      "Saturation curve valid for 223.16 <= T <= 273.16. Outside of these limits a (less accurate) result is returned" 
      extends Modelica.Icons.Function;
      input SI.Temperature Tsat "sublimation temperature";
      output SI.AbsolutePressure psat "sublimation pressure";
      annotation(Inline=false,smoothOrder=5);
    algorithm 
      psat := 611.657*Math.exp(22.5159*(1.0 - 273.16/Tsat));
    end sublimationPressureIce;
    
    redeclare function extends saturationPressure 
      "Saturation curve valid for 223.16 <= T <= 373.16 (and slightly outside with less accuracy)" 
      
      annotation(Inline=false,smoothOrder=5);
    algorithm 
      psat := Utilities.spliceFunction(saturationPressureLiquid(Tsat),sublimationPressureIce(Tsat),Tsat-273.16,1.0);
    end saturationPressure;
    
    function saturationTemperature 
      "Computes saturation temperature from (partial) pressure via numerical inversion of the function 'saturationPressure'" 
      input SI.Pressure p "pressure";
      input SI.Temperature T_min=200 "lower boundary of solution";
      input SI.Temperature T_max=400 "upper boundary of solution";
      output SI.Temperature T "temperature";
      
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
    end saturationTemperature;
    
   redeclare function extends enthalpyOfVaporization 
      "Enthalpy of vaporization of water, 0 - 130 degC" 
   algorithm 
    /*r0 := 1e3*(2501.0145 - (T - 273.15)*(2.3853 + (T - 273.15)*(0.002969 - (T
      - 273.15)*(7.5293e-5 + (T - 273.15)*4.6084e-7))));*/
   //katrin: replaced by linear correlation, simpler and more accurate in the entire region
   //source VDI-Waermeatlas, linear inter- and extrapolation between values for 0.01°C and 40°C.
   r0:=(2405900-2500500)/(40-0)*(T-273.16)+2500500;
   end enthalpyOfVaporization;
    
    function HeatCapacityOfWater 
      "Specific heat capacity of water (liquid only)" 
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
      "Computes enthalpy of liquid water from temperature (use enthalpyOfWater instead" 
      
     annotation(Inline=false,smoothOrder=5);
   algorithm 
     h := (T - 273.15)*1e3*(4.2166 - 0.5*(T - 273.15)*(0.0033166 + 0.333333*(T - 273.15)*(0.00010295
        - 0.25*(T - 273.15)*(1.3819e-6 + 0.2*(T - 273.15)*7.3221e-9))));
   end enthalpyOfLiquid;
    
   redeclare function extends enthalpyOfGas 
      "Computes specific enthalpy of gas (air and steam) from temperature and composition" 
      
     annotation(Inline=false,smoothOrder=5);
   algorithm 
     h := SingleGasNasa.h_Tlow(data=steam, T=T, refChoice=3, h_off=46479.819+2501014.5)*X[Water]
          + SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)*(1.0-X[Water]);
   end enthalpyOfGas;
    
   redeclare function extends enthalpyOfCondensingGas 
      "Computes specific enthalpy of steam from temperature" 
     annotation(Inline=false,smoothOrder=5);
   algorithm 
     h := SingleGasNasa.h_Tlow(data=steam, T=T, refChoice=3, h_off=46479.819+2501014.5);
   end enthalpyOfCondensingGas;
    
  function enthalpyOfWater 
      "Computes specific enthalpy of water (solid/liquid) near atmospheric pressure from temperature" 
    input SIunits.Temperature T;
    output SIunits.SpecificEnthalpy h;
  annotation (derivative=enthalpyOfWater_der);
  algorithm 
  /*simple model assuming constant properties:
  heat capacity of liquid water:4200 J/kg
  heat capacity of solid water: 2050 J/kg
  enthalpy of fusion (liquid=>solid): 333000 J/kg*/
      
    h:=Utilities.spliceFunction(4200*(T-273.15),2050*(T-273.15)-333000,T-273.16,0.1);
  end enthalpyOfWater;
    
   redeclare function extends pressure "Returns pressure of ideal gas" 
   algorithm 
    p := state.p;
   end pressure;
    
   redeclare function extends temperature "Return temperature of ideal gas" 
   algorithm 
     T := state.T;
   end temperature;
    
   redeclare function extends density "Returns density of ideal gas" 
   algorithm 
     d := state.p/(gasConstant(state)*state.T);
   end density;
    
   redeclare function extends specificEntropy 
      "Return specific entropy (liquid part neglected, mixing entropy included)" 
       annotation(Inline=false,smoothOrder=5);
    protected 
     MoleFraction[2] Y = massToMoleFractions(state.X,{steam.MM,dryair.MM}) 
        "molar fraction";
   algorithm 
     s := SingleGasNasa.s0_Tlow(dryair, state.T)*(1-state.X[Water])
       + SingleGasNasa.s0_Tlow(steam, state.T)*state.X[Water]
       - gasConstant(state)*Modelica.Math.log(state.p/reference_p)
       + sum(if Y[i] > Modelica.Constants.eps then -Y[i]*Modelica.Math.log(Y[i]) else 
                   Y[i] for i in 1:size(Y,1));
   end specificEntropy;
    
   redeclare function extends specificHeatCapacityCp 
      "Returns specific heat capacity at constant pressure" 
     annotation(Inline=false,smoothOrder=5);
   algorithm 
     cp:= SingleGasNasa.cp_Tlow(dryair, state.T)*(1-state.X[Water])
       + SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water];
   end specificHeatCapacityCp;
    
  redeclare function extends specificHeatCapacityCv 
      "Returns specific heat capacity at constant volume" 
     annotation(Inline=false,smoothOrder=5);
  algorithm 
    cv:= SingleGasNasa.cp_Tlow(dryair, state.T)*(1-state.X[Water]) +
      SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water]
      - gasConstant(state);
  end specificHeatCapacityCv;
    
  redeclare function extends dynamicViscosity 
      "Simple polynomial for dry air (moisture influence small), valid from 73.15 K to 373.15 K" 
      import Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
  algorithm 
    eta := Polynomials_Temp.evaluate({(-4.96717436974791E-011), 5.06626785714286E-008, 1.72937731092437E-005},
         Cv.to_degC(state.T));
  end dynamicViscosity;
    
  redeclare function extends thermalConductivity 
      "Simple polynomial for dry air (moisture influence small), valid from 73.15 K to 373.15 K" 
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
    input SI.MassFraction X[:] "Mass fractions of moist air";
    output SI.SpecificEnthalpy h "Specific enthalpy at p, T, X";
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
    X_liquid :=max(X[Water] - x_sat/(1 + x_sat), 0.0);
    X_steam  :=X[Water] - X_liquid;
    X_air    :=1 - X[Water];
   /* h        := {SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5),
               SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)}*
    {X_steam, X_air} + enthalpyOfLiquid(T)*X_liquid;*/
     h        := {SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5),
                 SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)}*
      {X_steam, X_air} + enthalpyOfWater(T)*X_liquid;
  end h_pTX;
    
  redeclare function extends specificEnthalpy "specific enthalpy" 
  algorithm 
    h := h_pTX(state.p, state.T, state.X);
  end specificEnthalpy;
    
  redeclare function extends specificInternalEnergy 
      "Return specific internal energy" 
    extends Modelica.Icons.Function;
  algorithm 
    u := h_pTX(state.p,state.T,state.X) - gasConstant(state)*state.T;
  end specificInternalEnergy;
    
  redeclare function extends specificGibbsEnergy "Return specific Gibbs energy" 
    extends Modelica.Icons.Function;
  algorithm 
    g := h_pTX(state.p,state.T,state.X) - state.T*specificEntropy(state);
  end specificGibbsEnergy;
    
  redeclare function extends specificHelmholtzEnergy 
      "Return specific Helmholtz energy" 
    extends Modelica.Icons.Function;
  algorithm 
    f := h_pTX(state.p,state.T,state.X) - gasConstant(state)*state.T - state.T*specificEntropy(state);
  end specificHelmholtzEnergy;
    
  function T_phX "Compute temperature from specific enthalpy and mass fraction" 
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "specific enthalpy";
    input MassFraction[:] X "mass fractions of composition";
    output Temperature T "temperature";
      
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
    T := Internal.solve(h, 200, 6000, p, X[1:nXi], steam);
  end T_phX;
    
  function enthalpyOfWater_der 
      "Computes specific enthalpy of water (solid/liquid) near atmospheric pressure from temperature" 
    input SIunits.Temperature T;
    input SIunits.Temperature dT;
    output SIunits.SpecificEnthalpy dh;
  algorithm 
  /*simple model assuming constant properties:
  heat capacity of liquid water:4200 J/kg
  heat capacity of solid water: 2050 J/kg
  enthalpy of fusion (liquid=>solid): 333000 J/kg*/
      
    //h:=Utilities.spliceFunction(4200*(T-273.15),2050*(T-273.15)-333000,T-273.16,0.1);
    dh:=Utilities.spliceFunction_der(4200*(T-273.15),2050*(T-273.15)-333000,T-273.16,0.1,4200*dT,2050*dT,dT,0);
  end enthalpyOfWater_der;

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
    
    annotation (Documentation(info="<html>
  <h3><font color=\"#008000\" size=5>Moist Air Medium Package</font></h3>
<h4><font color=\"#008000\" size=4>Thermodynamic Model</font></h4>
<p>This package provides a full thermodynamic model of moist air including the fog region and temperatures below zero degC.
The governing assumptions in this model are:</p>
<ul>
<li>the perfect gas law applies</li>
<li>water volume other than that of steam is neglected</li></ul>
<p>All extensive properties are expressed in terms of the total mass in order to comply with other media in this libary. However, it is rather common to express the absolute humidity in terms of mass of dry air only, which has advantages when working with charts. Therefore two absolute humidities are computed in the <b>BaseProperties</b> model: <b>X</b> denotes the absolute humidity in terms of the total mass while <b>x</b> denotes the absolute humitity per unit mass of dry air. In addition, the relative humidity <b>phi</b> is also computed.</p>
<p>At the triple point temperature of water of 0.01°C or 273.16 K and a relative humidity greater than 1 fog may be present as liquid and as ice resulting in a specific enthalpy somewhere between those of the two isotherms for solid and liquid fog, respectively. For numerical reasons in this model a coexisting mixture of 50% solid and 50% liquid fog is assumed in the fog region at the triple point.

<h4><font color=\"#008000\" size=4>Range of validity</font></h4>
<p>From the assumptions mentioned above it follows that the <b>pressure</b> should be in the region around <b>atmospheric</b> conditions or below (a few bars may still be fine though). Additionally a very high water content at low temperatures would yield incorrect densities, because the volume of the liquid or solid phase would not be negligible anymore. The model does not provide any information on limits for water drop size in the fog region or transport information for the actual condensation or evaporation process in combination with surfaces. All excess water which is not in its vapour state is assumed to be still present in the air regarding its energy but not in terms of its spatial extent.<br><br>
The thermodynamic model may be used for <b>temperatures</b> ranging from <b>240 - 400 K</b>. This holds for all functions unless otherwise stated in their description. However, although the model works at temperatures above the saturation temperature it is questionable to use the term \"relative humidity\" in this region.</p>

<h4><font color=\"#008000\" size=4>Transport Properties</font></h4>
<p>Several additional functions that are not needed to describe the thermodynamic system, but are required to model transport processes, like heat and mass transfer, may be called. They usually neglect the moisture influence unless otherwise stated.</p>
  
<h4><font color=\"#008000\" size=4>Application</font></h4>
<p>The model's main area of application is all processes that involve moist air cooling under near atmospheric pressure with possible moisture condensation. This is the case in all domestic and industrial air conditioning applications. Another large domain of moist air applications covers all processes that deal with the dehydration of bulk material using air as the transport medium. Engineering tasks involving moist air are often performed (or at least visualized) by using charts that contain all relevant thermodynamic data for a moist air system. These so called psychrometric charts can be generated from the medium properties in this package. The model <a href=\"Modelica://Modelica.Media.Air.MoistAir.PsychrometricData\">PsychrometricData</a> may be used for this purpose in order to obtain data for figures like those below (the plotting itself is not part of the model though).</p>

<p><img src=\"../../Modelica/Images/Media/Air/Mollier.png\">
<img src=\"../../Modelica/Images/Media/Air/PsycroChart.png\"></p>
<p>
<b>Legend:</b> blue - constant specific enthalpy, red - constant temperature, black - constant relative humidity</p>

</html>"));
    model PsychrometricData "produces plot data for psychrometric charts" 
      extends Modelica.Icons.Example;
      package Medium = Modelica.Media.Air.MoistAir;
      parameter SIunits.Pressure p_const=1e5 "pressure";
      parameter Integer n_T=11 "number of isotherms";
      parameter SIunits.Temperature T_min=253.15 "lowest isotherm";
      parameter SIunits.Temperature T_step=10 
        "temperature step between two isotherms";
      parameter Integer n_h=16 
        "number of lines with constant specific enthalpy";
      parameter SIunits.SpecificEnthalpy h_min=-20e3 
        "lowest line of constant enthalpy";
      parameter SIunits.SpecificEnthalpy h_step=1e4 
        "enthalpy step between two lines of constant enthalpy";
      parameter Integer n_phi=10 
        "number of lines with constant relative humidity";
      parameter Real phi_min=0.1 "lowest line of constant humidity";
      parameter Real phi_step=0.1 "step between two lines of constant humidity";
      parameter SIunits.MassFraction x_min=0.00 
        "minimum diagram absolute humidity";
      parameter SIunits.MassFraction x_max=0.03 
        "maximum diagram absolute humidity";
      parameter SIunits.Time t=1 "simulation time";
      
      final parameter SIunits.Temperature[n_T] T_const={T_min - T_step + i*T_step for i in 
              1:n_T};
      final parameter SIunits.SpecificEnthalpy[n_h] h_const={(i-1)*h_step+h_min for i in 1:n_h};
      final parameter Real[n_phi] phi_const={(i-1)*phi_step+phi_min for i in 1:n_phi};
      final parameter Real diagSlope=Medium.enthalpyOfVaporization(273.15) 
        "rotation of diagram that zero degrees isotherm becomes horizontal outside the fog region";
      final parameter SIunits.MassFraction x_start=x_min 
        "initial absolute humidity in kg water/kg dry air";
      
      SIunits.MassFraction x(start=x_start) 
        "absolute humidity in kg water/kg dry air";
      SIunits.SpecificEnthalpy[n_T] hx_T "h_1+x for const T";
      SIunits.SpecificEnthalpy[n_h] hx_h(start=h_const) "const h_1+x";
      SIunits.SpecificEnthalpy[n_phi] hx_phi "h_1+x for const phi";
      SIunits.SpecificEnthalpy[n_T] y_T "chart enthalpy for const T";
      SIunits.SpecificEnthalpy[n_h] y_h "chart enthalpy for const h";
      SIunits.SpecificEnthalpy[n_phi] y_phi "chart enthalpy for const phi";
      Medium.BaseProperties[n_T] medium_T "medium properties for const T";
      Medium.BaseProperties[n_phi] medium_phi "medium properties for const phi";
      
    protected 
      SIunits.Pressure[n_phi] ps_phi 
        "saturation pressure for constant-phi-lines";
      SIunits.Temperature[n_phi] T_phi(each start=290);
      Boolean[n_T] fog(start=fill(false, n_T)) 
        "triggers events at intersection of isotherms with phi=1";
      SIunits.Pressure[n_T] pd "steam partial pressure along isotherms";
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
        pd[i] = medium_T[i].Xi[1]*medium_T[i].MM/medium_T[i].MMX[1]*p_const;
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

<p>The model provides data for lines of constant specific enthalpy, temperature and relative humidity in a Mollier Diagram or Psychrometric Chart as they were used for the figures above. For limitations and ranges of validity please refer to the MoistAir package description. Absolute humidity <b>x</b> is increased with time in this model. The specific enthalpies adjusted for plotting are then obtained from:</p>
<ul>
<li><b>y_h</b>: constant specific enthalpy</li>
<li><b>y_T</b>: constant temperature</li>
<li><b>y_phi</b>: constant relative humidity</li>
</ul>
</html>"));
    end PsychrometricData;
  end MoistAir;
  
  annotation (Documentation(info="<html>
  
</html>"));
end Air;
