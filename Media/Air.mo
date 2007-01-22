package Air "Media models for air" 
  
  package SimpleAir "Air: Simple dry air model (0..100 degC)" 
    
    extends Interfaces.PartialSimpleIdealGasMedium
      (mediumName="SimpleAir",
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
    
    constant FluidConstants[nS] fluidConstants =
      FluidConstants(iupacName={"simple air"},
                     casRegistryNumber={"not a real substance"},
                     chemicalFormula={"N2, O2"},
                     structureFormula={"N2, O2"},
                     molarMass=Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM) "constant data for the fluid";
        
    annotation (Documentation(info="<html>
                              <h2>Simple Ideal gas air model for low temperatures<h1>
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
      
      // this x_steam is water load / dry air!!!!!!!!!!!
      x_sat    = k_mair*p_steam_sat/max(100*Constants.eps,p - p_steam_sat);
      x_water = Xi[Water]/max(X_air,100*Constants.eps);
      phi = p/p_steam_sat*Xi[Water]/(Xi[Water] + k_mair*X_air);
    end BaseProperties;

    function Xsaturation "steam water mass fraction of saturation boundary in kg_water/kg_moistair"
      input ThermodynamicState state "shermodynamic state";
      output MassFraction X_sat "steam mass fraction of sat. boundary";
      protected
    algorithm
      X_sat := k_mair/(state.p/min(saturationPressure(state.T),0.999*state.p) - 1 + k_mair);
    end Xsaturation;
    
    function massFraction_pTphi "compute the steam mass fraction from relative humidity and T"
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input Real phi "relative humidity (0 ... 1.0)";
      output MassFraction X_steam "steam Mass fractions";
    protected
      constant Real k = 0.621964713077499 "ratio of molar masses";
      AbsolutePressure psat = saturationPressure(T) "saturation pressure";
    algorithm
      X_steam = phi*k/(k*phi+p/psat-phi);
    end massFraction_pTphi;
    
    redeclare function setState_pTX "Return thermodynamic state as function of p, T and composition X" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := if size(X,1) == nX then ThermodynamicState(p=p,T=T, X=X)
        else ThermodynamicState(p=p,T=T, X=cat(1,X,{1-sum(X)}));
    end setState_pTX;
    
    redeclare function setState_phX "Return thermodynamic state as function of p, h and composition X" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := if size(X,1) == nX then ThermodynamicState(p=p,T=T_phX(p,h,X),X=X)
        else ThermodynamicState(p=p,T=T_phX(p,h,X), X=cat(1,X,{1-sum(X)}));
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
    redeclare function setState_dTX "Return thermodynamic state as function of d, T and composition X" 
      extends Modelica.Icons.Function;
      input Density d "density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := if size(X,1) == nX then ThermodynamicState(p=d*({steam.R,dryair.R}*X)*T,T=T,X=X)
        else ThermodynamicState(p=d*({steam.R,dryair.R}*cat(1,X,{1-sum(X)}))*T,T=T, X=cat(1,X,{1-sum(X)}));
    end setState_dTX;
      
    redeclare function extends gasConstant "gas constnat: computation neglects liquid fraction"
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
     d := state.p/(gasConstant(state)*state.T);
   end density;

   redeclare function extends specificEntropy
     "return specific entropy (liquid part neglected, mixing entropy included)"  
       annotation(Inline=false,smoothOrder=5);
   protected
     MoleFraction[2] Y = massToMoleFractions(state.X,{steam.MM,dryair.MM}) "molar fraction";
   algorithm
     s := SingleGasNasa.s0_Tlow(dryair, state.T)*(1-state.X[Water])
       + SingleGasNasa.s0_Tlow(steam, state.T)*state.X[Water]
       - gasConstant(state)*Modelica.Math.log(state.p/reference_p)
       + sum(if Y[i] > Modelica.Constants.eps then -Y[i]*Modelica.Math.log(Y[i]) else 
                   Y[i] for i in 1:size(Y,1));;
   end specificEntropy;
   
   redeclare function extends specificHeatCapacityCp 
      "Return specific heat capacity at constant pressure" 
     annotation(Inline=false,smoothOrder=5);
  algorithm 
     cp:= SingleGasNasa.cp_Tlow(dryair, state.T)*(1-state.X[Water])
       + SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water];
  end specificHeatCapacityCp;
    
  redeclare function extends specificHeatCapacityCv 
      "Return specific heat capacity at constant volume" 
     annotation(Inline=false,smoothOrder=5);
  algorithm 
    cv:= SingleGasNasa.cp_Tlow(dryair, state.T)*(1-state.X[Water]) +
      SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water]
      - gasConstant(state);
  end specificHeatCapacityCv;
    
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
    input SI.MassFraction X[nX] "Mass fractions of moist air";
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
    h        := {SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5),
                 SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)}*
      {X_steam, X_air} + enthalpyOfLiquid(T)*X_liquid;
  end h_pTX;
    
  redeclare function extends specificEnthalpy
      "specific enthalpy"
  algorithm
    h := h_pTX(state.p, state.T, state.X);  
  end specificEnthalpy;
    
  redeclare function extends specificInternalEnergy "Return specific internal energy" 
    extends Modelica.Icons.Function;
  algorithm 
    u := h_pTX(state.p,state.T,state.X) - gasConstant(state)*state.T;
  end specificInternalEnergy;
  
  redeclare function extends specificGibbsEnergy "Return specific Gibbs energy" 
    extends Modelica.Icons.Function;
  algorithm 
    g := h_pTX(state.p,state.T,state.X) - state.T*specificEntropy(state);
  end specificGibbsEnergy;
  
  redeclare function extends specificHelmholtzEnergy "Return specific Helmholtz energy" 
    extends Modelica.Icons.Function;
  algorithm 
    f := h_pTX(state.p,state.T,state.X) - gasConstant(state)*state.T - state.T*specificEntropy(state);
  end specificHelmholtzEnergy;
  
  function T_phX 
    "Compute temperature from specific enthalpy and mass fraction" 
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
  
</html>"));
  end MoistAir;
  
  annotation (Documentation(info="<html>
  
</html>"));
end Air;
