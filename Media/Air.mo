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
    
    redeclare function extends heatCapacity_cp 
      "Specific heat capacity at constant pressure of dry air" 
    algorithm 
      cp := cp_air;
    end heatCapacity_cp;
    
  end SimpleAir;
  
  package DryAirNasa "Air: Detailed dry air model as ideal gas (200..6000 K)" 
    extends IdealGases.SingleGases.Air(fluidConstants={IdealGases.Common.FluidData.N2});
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
    constant SI.Pressure psat_low=saturationPressureWithoutLimits(272.15);
    constant SI.Pressure psat_high=saturationPressureWithoutLimits(373.16);
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
      assert(T >= 272.15 and T <= 423.15, "
Temperature T is not in the allowed range
273.15 K <= (T =" + String(T) + " K) <= 423.15 K
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
    
    function saturationPressureWithoutLimits 
      "saturation curve valid for 273.15 <= T <= 373.16. Outside of these limits a (wrong) result is returned" 
      extends Modelica.Icons.Function;
      input SI.Temperature Tsat "saturation temperature";
      output SI.AbsolutePressure psat "saturation pressure";
    algorithm 
      psat := 611.657*Math.exp(17.2799 - 4102.99/(Tsat - 35.719));
    end saturationPressureWithoutLimits;
    
    redeclare function extends saturationPressure 
      "saturation curve valid for 273.15 <= T <= 373.16" 
      annotation (InlineNoEvent=false);
    algorithm 
      psat := max(psat_low,min(psat_high,saturationPressureWithoutLimits(Tsat)));
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
   algorithm 
     h := (T - 273.15)*1e3*(4.2166 - 0.5*(T - 273.15)*(0.0033166 + 0.333*(T - 273.15)*(0.00010295
        - 0.25*(T - 273.15)*(1.3819e-6 + 0.2*(T - 273.15)*7.3221e-9))));
   end enthalpyOfLiquid;
    
   redeclare function extends enthalpyOfGas 
   algorithm 
     h := SingleGasNasa.h_Tlow(data=steam, T=T, refChoice=3, h_off=46479.819+2501014.5)*X[Water]
          + SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)*(1.0-X[Water]);
   end enthalpyOfGas;
    
   redeclare function extends enthalpyOfCondensingGas 
   algorithm 
     h := SingleGasNasa.h_Tlow(data=steam, T=T, refChoice=3, h_off=46479.819+2501014.5);
   end enthalpyOfCondensingGas;
    
  redeclare function extends heatCapacity_cp 
      "Return specific heat capacity at constant pressure" 
  algorithm 
    cp:= SingleGasNasa.cp_Tlow(dryair, state.T)*(1-state.X[Water]) + SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water];
  end heatCapacity_cp;
    
  redeclare function extends heatCapacity_cv 
      "Return specific heat capacity at constant volume" 
  algorithm 
    cv:= SingleGasNasa.cp_Tlow(dryair, state.T)*(1-state.X[Water]) + SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water]
      - gasConstant(state);
  end heatCapacity_cv;
    
    function h_pTX 
      "Compute specific enthalpy from pressure, temperature and mass fraction" 
      extends Modelica.Icons.Function;
      input SI.Pressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.MassFraction Xi[nXi] "Independent mass fractions of most air";
      output SI.SpecificEnthalpy h "Specific enthalpy at p, T, Xi";
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
  end MoistAir;
  
end Air;
