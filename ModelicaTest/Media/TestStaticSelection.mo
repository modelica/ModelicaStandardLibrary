package TestStaticSelection 
  "Test that media models are defined in such a way that static state selection is possible in balance volumes" 
function testStateSelectionForAllMedia 
    "Test all media of Modelica.Media whether they simulate and have static state selection" 
  extends Modelica.Icons.Function;
    import Modelica.Utilities.Streams.*;
    
// Models to be tested
/*
String models[:] = {"Modelica.Media.Examples.TestStaticSelection.Incompressible.Glycol47",
                    "Modelica.Media.Examples.TestStaticSelection.Incompressible.Essotherm650"};
*/
    
  protected 
String models[:] = {"Modelica.Media.Examples.TestStaticSelection.Air.SimpleAir",
                    "Modelica.Media.Examples.TestStaticSelection.Air.DryAirNasa",
                    "Modelica.Media.Examples.TestStaticSelection.Air.MoistAir",
                    "Modelica.Media.Examples.TestStaticSelection.IdealGases.Air",
                    "Modelica.Media.Examples.TestStaticSelection.IdealGases.SimpleNaturalGas",
                    "Modelica.Media.Examples.TestStaticSelection.Incompressible.Glycol47",
                    "Modelica.Media.Examples.TestStaticSelection.Incompressible.Essotherm650",
                    "Modelica.Media.Examples.TestStaticSelection.Water.ConstantLiquidWater",
                    "Modelica.Media.Examples.TestStaticSelection.Water.IdealSteam",
                    "Modelica.Media.Examples.TestStaticSelection.Water.WaterIF97OnePhase_ph",
                    "Modelica.Media.Examples.TestStaticSelection.Water.WaterIF97_pT",
                    "Modelica.Media.Examples.TestStaticSelection.Water.WaterIF97_ph",
                    "Modelica.Media.Examples.TestStaticSelection.TestDummyFunctionMedium"};
    
algorithm 
  testStateSelection(models);
end testStateSelectionForAllMedia;
  
function testStateSelection 
    import Modelica.Utilities.Streams.*;
    import Modelica.Utilities.Files.*;
    import Modelica.Utilities.System.*;
  extends Modelica.Icons.Function;
  input String models[:] "Full Modelica names of models that shall be testet";
    
// Models to be tested
  protected 
  Integer nTests = size(models,1);
  Boolean passed[nTests] = fill(false,nTests);
  Boolean staticStateSelection[nTests] = fill(true,nTests);
  Integer nDynamicStateSelections;
  Integer notPassed=0;
  Integer i;
  String workDirectory;
algorithm 
// Go one level up, if directory is a package directory
   workDirectory :=getWorkDirectory();
   if exist(workDirectory + "/package.mo") then
      setWorkDirectory("..");
      workDirectory :=getWorkDirectory();
      print("... work directory changed to: " + workDirectory);
   end if;
    
for i in 1:nTests loop
   print("... test " + models[i]);
   (passed[i], staticStateSelection[i]) := hasStaticStateSelection(models[i]);
   if passed[i] then
      passed[i] := simulateModel(models[i]);
   end if;
      
   if not passed[i] then
      notPassed := notPassed + 1;
   end if;
      
   if not staticStateSelection[i] then
      nDynamicStateSelections := nDynamicStateSelections + 1;
   end if;
end for;
    
if notPassed > 0 then
  print("\n... The following models did not simulate:");
  for i in 1:nTests loop
     if not passed[i] then
         print("   " + models[i]);
     end if;
  end for;
end if;
    
if nDynamicStateSelections > 0 then
  print("\n... The following models simulated but have dynamic state selection:");
  for i in 1:nTests loop
     if passed[i] and not staticStateSelection[i] then
         print("   " + models[i]);
     end if;
  end for;
end if;
    
if notPassed == 0 and nDynamicStateSelections == 0 then
  print("\n... All models simulated without error and have static state selection.");
end if;
    
end testStateSelection;
  extends Modelica.Icons.Library;
  
function translateModelWithLog "Translate model and return translation log" 
   extends Modelica.Icons.Function;
    import Modelica.Utilities.Files.*;
    import Modelica.Utilities.Streams.*;
    
   input String Model "Model to be translated";
   output Boolean success "= true if successful translation";
   output String log[:] "Translation log";
  protected 
  String logFileName;
  Boolean saveTranslationInCommandLog;
  Boolean save_LogStateSelection;
algorithm 
  clearlog();
    
  // save log in command window
  saveTranslationInCommandLog := Advanced.TranslationInCommandLog;
  save_LogStateSelection      := LogStateSelection;
  Advanced.TranslationInCommandLog:=true;
  LogStateSelection := true;
    
  // Translate and read log file
  logFileName := temporaryFileName();
  success := translateModel(Model);
  savelog(logFileName);
  log := readFile(logFileName);
  remove(logFileName);
    
  // reset previous settings when entering the function
  Advanced.TranslationInCommandLog := saveTranslationInCommandLog;
  LogStateSelection := save_LogStateSelection;
end translateModelWithLog;
  
function hasStaticStateSelection 
    "Translates a model and checks whether a model has static or dynamic state selection" 
   extends Modelica.Icons.Function;
    import Modelica.Utilities.Strings.*;
    
   input String Model "model to be translated";
   output Boolean success "= true, if translation is successful";
   output Boolean staticStateSelection "= true, if static state selection";
  protected 
  String log[:];
algorithm 
 staticStateSelection := true;
 (success,log) := translateModelWithLog(Model);
 if success then
    for i in 1:size(log,1) loop
       if find(log[i], "dynamic state selection") > 0 then
          staticStateSelection :=false;
       end if;
    end for;
 end if;
end hasStaticStateSelection;
  
  model PartialTestModel "Basic test model that emulates a balance volume" 
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Example;
    
    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
      "Medium model";
    
  // The following variables are input data for this test
    SI.Volume V = 0.01 "Volume of control volume";
    Medium.MassFlowRate port_m_flow = 0 
      "total mass flow rate into the volume for compressible medium";
    Medium.MassFraction port_X[Medium.nX_i] = fill(1/Medium.nS, Medium.nX_i) 
      "independent mass fractions of substances";
    Medium.EnthalpyFlowRate port_H_flow = 0 
      "Enthalpie flow rate into the volume";
    
  // The following variables are computed by the provided equations
    
  // Variables for medium1 using intensive medium properties as states
    Medium.BaseProperties medium1(preferredMediumStates=true) "Medium model";
    Medium.MassFlowRate port_m_flow_used1 
      "Used mass flow rate (different for incompressible and compressible medium)";
    Medium.MassFlowRate port_mX_flow1[Medium.nX_i] = port_m_flow_used1*port_X 
      "Independent substance mass flow rates into the volume";
    SI.Mass M1(start=1) "Total mass";
    SI.Mass MX1[Medium.nX_i](each start=1/(Medium.nX)) 
      "Independent substance masses of component";
    SI.Energy U1 "Total internal energy";
    Integer nX =   Medium.nX;
    Integer nX_i = Medium.nX_i;
    
  // Variables for medium2 using masses as states
    package Medium2 = Medium "Medium model";
    Medium2.BaseProperties medium2(preferredMediumStates=true) "Medium model";
    Medium2.MassFlowRate port_m_flow_used2 
      "Used mass flow rate (different for incompressible and compressible medium)";
    Medium2.MassFlowRate port_mX_flow2[Medium2.nX_i] = port_m_flow_used2*port_X 
      "Substance mass flow rates into the volume";
    
    SI.Mass M2(start=1, stateSelect=StateSelect.prefer) "Total mass";
    SI.Mass MX2[Medium2.nX_i](each start=1/(Medium2.nX), each stateSelect=StateSelect.prefer) 
      "Independent substance masses of component";
    
    SI.Energy U2 "Total internal energy";
    
  equation 
  // Handle incompressible medium
     if Medium.singleState then
        // Pressure is determined by sources and pressure loss components
        medium1.p = 1e5;
        medium2.p = 1e5;
     else
        port_m_flow_used1 = port_m_flow;
        port_m_flow_used2 = port_m_flow;
     end if;
    
  // Balance equations for medium1 using intensive medium properties as states
    // Mass balance
       der(M1)  = port_m_flow_used1;
       der(MX1) = port_mX_flow1;
       M1  = V*medium1.d;
       MX1 = M1*medium1.X_i;
    
    // Energy balance
       U1 = M1*medium1.u;
       der(U1) = port_H_flow;
    
  // Balance equations for medium2 using masses as states
    // Mass balance
       der(M2)   = port_m_flow_used2;
       der(MX2)  = port_mX_flow2;
       medium2.d = M2/V;
       medium2.X_i = MX2/M2;
    
    // Energy balance
       U2 = M2*medium2.u;
       der(U2) = port_H_flow;
  end PartialTestModel;
  
package Air "Test models of library Modelica.Media.Air" 
    extends Modelica.Icons.Library;
    model SimpleAir "Test Modelica.Media.Air.SimpleAir" 
      extends ModelicaTest.Media.TestStaticSelection.PartialTestModel(
        redeclare package Medium = Modelica.Media.Air.SimpleAir,
        medium1(p(start=1e5, fixed=true), T(start=300, fixed=true)),
        medium2(p(start=1e5, fixed=true), T(start=300, fixed=true)));
    end SimpleAir;
    
    model DryAirNasa "Test Modelica.Media.Air.SimpleAir" 
      extends ModelicaTest.Media.TestStaticSelection.PartialTestModel(
        redeclare package Medium = Modelica.Media.Air.DryAirNasa,
        medium1(p(start=1e5, fixed=true), T(start=300, fixed=true)),
        medium2(p(start=1e5, fixed=true), T(start=300, fixed=true)));
    end DryAirNasa;
    
    model MoistAir "Test Modelica.Media.Air.SimpleAir" 
      extends ModelicaTest.Media.TestStaticSelection.PartialTestModel(
        redeclare package Medium = Modelica.Media.Air.MoistAir,
        medium1(
          p(start=1e5, fixed=true),
          T(start=300, fixed=true),
          X_i(each start=0.1, each fixed=true)),
        medium2(
          p(start=1e5, fixed=true),
          T(start=300, fixed=true),
          X_i(each start=0.1, each fixed=true)));
    end MoistAir;
end Air;
  
  package IdealGases "Test models of library Modelica.Media.IdealGases" 
    extends Modelica.Icons.Library;
    
    model Air "Test single gas Modelica.Media.IdealGases.SingleGases.Air" 
      extends ModelicaTest.Media.TestStaticSelection.PartialTestModel(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.Air,
        medium1(p(start=1e5, fixed=true), T(start=300, fixed=true)),
        medium2(p(start=1e5, fixed=true), T(start=300, fixed=true)));
    end Air;
    
    model SimpleNaturalGas 
      "Test mixture gas Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas" 
      extends ModelicaTest.Media.TestStaticSelection.PartialTestModel(
        redeclare package Medium = 
            Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas,
        medium1(
          p(start=1e5, fixed=true),
          T(start=300, fixed=true),
          X_i(each start=1/Medium.nX, each fixed=true)),
        medium2(
          p(start=1e5, fixed=true),
          T(start=300, fixed=true),
          X_i(each start=1/Medium.nX, each fixed=true)));
    end SimpleNaturalGas;
    
  end IdealGases;
  
  package Incompressible "Test models of library Modelica.Media.Incompressible" 
    extends Modelica.Icons.Library;
    model Glycol47 "Test Modelica.Media.Air.SimpleAir" 
      extends ModelicaTest.Media.TestStaticSelection.PartialTestModel(
        redeclare package Medium = 
            Modelica.Media.Incompressible.Examples.Glycol47,
        medium1(p(start=1e5), T(start=300, fixed=true)),
        medium2(p(start=1e5), T(start=300, fixed=true)));
    end Glycol47;
    
    model Glycol47_old "Test Modelica.Media.Air.SimpleAir" 
      extends ModelicaTest.Media.TestStaticSelection.PartialTestModel(
        redeclare package Medium = 
            Modelica.Media.Incompressible.Examples.Glycol47_old,
        medium1(p(start=1e5), T(start=300, fixed=true)),
        medium2(p(start=1e5), T(start=300, fixed=true)));
    end Glycol47_old;
    
    model Essotherm650 "Test Modelica.Media.Air.SimpleAir" 
      extends ModelicaTest.Media.TestStaticSelection.PartialTestModel(
        redeclare package Medium = 
            Modelica.Media.Incompressible.Examples.Essotherm650,
        medium1(p(start=1e5), T(start=300, fixed=true)),
        medium2(p(start=1e5), T(start=300, fixed=true)));
    end Essotherm650;
  end Incompressible;
  
  package Water "Test models of library Modelica.Media.Water" 
    extends Modelica.Icons.Library;
    model ConstantLiquidWater "Test Modelica.Media.Air.SimpleAir" 
      extends ModelicaTest.Media.TestStaticSelection.PartialTestModel(
        redeclare package Medium = 
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        medium1(p(start=1e5, fixed=true), T(start=300, fixed=true)),
        medium2(p(start=1e5, fixed=true), T(start=300, fixed=true)));
    end ConstantLiquidWater;
    
    model IdealSteam "Test Modelica.Media.Air.SimpleAir" 
      extends ModelicaTest.Media.TestStaticSelection.PartialTestModel(
        redeclare package Medium = Modelica.Media.Water.IdealSteam,
        medium1(p(start=1e5, fixed=true), T(start=300, fixed=true)),
        medium2(p(start=1e5, fixed=true), T(start=300, fixed=true)));
    end IdealSteam;
    
    model WaterIF97OnePhase_ph "Test Modelica.Media.Air.SimpleAir" 
      extends ModelicaTest.Media.TestStaticSelection.PartialTestModel(
        redeclare package Medium = Modelica.Media.Water.WaterIF97OnePhase_ph,
        medium1(p(start=1e5, fixed=true), T(start=300, fixed=true)),
        medium2(p(start=1e5, fixed=true), T(start=300, fixed=true)));
    end WaterIF97OnePhase_ph;
    
    model WaterIF97_pT "Test Modelica.Media.Air.SimpleAir" 
      extends ModelicaTest.Media.TestStaticSelection.PartialTestModel(
        redeclare package Medium = Modelica.Media.Water.WaterIF97_pT,
        medium1(p(start=1e5, fixed=true), T(start=300, fixed=true)),
        medium2(p(start=1e5, fixed=true), T(start=300, fixed=true)));
    end WaterIF97_pT;
    
    model WaterIF97_ph "Test Modelica.Media.Air.SimpleAir" 
      extends ModelicaTest.Media.TestStaticSelection.PartialTestModel(
        redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
        medium1(p(start=1e5, fixed=true), T(start=300, fixed=true)),
        medium2(p(start=1e5, fixed=true), T(start=300, fixed=true)));
    end WaterIF97_ph;
    /*      
      model WaterIF97_dT "Test Modelica.Media.Air.SimpleAir" 
        extends Modelica.Media.Examples.TestStaticSelection.PartialTestModel(
           redeclare package Medium = 
              Modelica.Media.Water.WaterIF97_dT,
           medium1(d(start=1000), p(start=1e5, fixed=true), T(start=300,fixed=true)),
           medium2(d(start=1000), p(start=1e5, fixed=true), T(start=300,fixed=true)));
      end WaterIF97_dT;
*/
  end Water;
  
  package DummyFunctionMedium 
    "Fictitious liquid mixture with function-computed properties - emulates externally supplied media models" 
    
    extends Modelica.Media.Interfaces.PartialMixtureMedium(
       mediumName="Fictitous Liquid Mixture",
       substanceNames={"Kryptene","Simulene","Hysteric Acid"},
       final singleState=true,
       final reducedX=false,
       reference_X={0.3,0.3,0.4},
       SpecificEnthalpy(start=1.0e5, nominal=5.0e5),
       Density(start=1000, nominal=1000),
       AbsolutePressure(start=50e5, nominal=10e5),
       Temperature(start=300, nominal=300));
    
    constant Modelica.SIunits.Pressure p0=1e5 "Reference pressure";
    constant Modelica.SIunits.Temperature T0=293.15 "Reference temperature";
    constant Modelica.SIunits.SpecificHeatCapacity cp0[nX_i]={4000,2500,2000};
    constant Modelica.SIunits.Density rho0[nX_i]={1000,500,700};
    constant Modelica.SIunits.RelativePressureCoefficient beta[nX_i]={1e-3,3e-3,
        5e-3};
    constant Modelica.SIunits.SpecificEnthalpy h0[nX_i]=fill(0, nX_i);
    redeclare record extends ThermodynamicState 
      Modelica.SIunits.Temperature T(start=300);
      Modelica.SIunits.MassFraction X[nX];
    end ThermodynamicState;
    
    redeclare model extends BaseProperties(
        T(stateSelect=StateSelect.prefer),
        p(stateSelect=StateSelect.prefer),
        X_i(stateSelect=StateSelect.prefer)) 
    equation 
      d = f_density(T, X);
      h = f_enthalpy(T, X_i);
      u = h;
      R=1;
      state.p=p;
      state.T=T;
      state.X=X;
      MM=0.1;
    end BaseProperties;
    
    redeclare function extends heatCapacity_cp 
      "Return specific heat capacity at constant pressure" 
    algorithm 
      cp := sum(cp0[i]*state.X[i] for i in 1:nX);
    end heatCapacity_cp;
    
    redeclare function extends heatCapacity_cv 
      "Return specific heat capacity at constant volume" 
    algorithm 
      cv := sum(cp0[i]*state.X[i] for i in 1:nX);
    end heatCapacity_cv;
    
    redeclare function extends density_derT_p 
      "density derivative by specific enthalpy at const pressure" 
    algorithm 
      ddTp:=sum(-rho0[i]*beta[i]/cp0[i]*state.X[i] for i in 1:nX);
    end density_derT_p;
    
    redeclare function extends density_derp_T 
      "density derivative by pressure at const specific enthalpy" 
    algorithm 
      ddpT:=0;
    end density_derp_T;
    
    redeclare function extends density_derX 
      "density derivative by pressure at const specific enthalpy" 
    protected 
      Modelica.SIunits.Density dX[nX];
      Modelica.SIunits.Density d;
    algorithm 
      for i in 1:nX loop
        dX[i] := rho0[i]*(1-beta[i]*(state.T-T0));
      end for;
      d :=1/sum(state.X[i]/dX[i] for i in 1:nX);
      for i in 1:nX loop
        dddX[i]:=-d^2/dX[i];
      end for;
    end density_derX;
    
    function f_density 
      annotation(derivative=f_density_der);
      input Modelica.SIunits.Temperature T;
      input Modelica.SIunits.MassFraction X[nX];
      output Modelica.SIunits.Density d;
    algorithm 
      d := 1/sum(X[i]/(rho0[i]*(1-beta[i]*(T-T0))) for i in 1:nX);
    end f_density;
    
    function f_density_der 
      input Modelica.SIunits.Temperature T;
      input Modelica.SIunits.MassFraction X[nX];
      input Real T_der;
      input Real X_der[nX];
      output Modelica.SIunits.Density d_der;
    protected 
                ThermodynamicState state;
    algorithm 
      state.T:=T;
      state.X:=X;
      state.p:=1e5;
      d_der := density_derT_p(state)*T_der+density_derX(state)*X_der;
    end f_density_der;
    
    function f_enthalpy 
      input Modelica.SIunits.Temperature T;
      input Modelica.SIunits.MassFraction X_i[nX_i];
      output Modelica.SIunits.SpecificEnthalpy h;
    protected 
      Modelica.SIunits.SpecificEnthalpy h_component[nX];
      annotation(derivative=f_enthalpy_der);
    algorithm 
      for i in 1:nX loop
        h_component[i] :=(cp0[i]*(T - T0) + h0[i]);
      end for;
      h:= sum(h_component[1:nX_i]*X_i)+ h_component[nX]*(1-sum(X_i));
    end f_enthalpy;
    
    function f_enthalpy_der 
      input Modelica.SIunits.Temperature T;
      input Modelica.SIunits.MassFraction X_i[nX_i];
      input Real T_der;
      input Real X_i_der[nX_i];
      output Modelica.SIunits.SpecificEnthalpy h_der;
      annotation(derivative=f_enthalpy_der);
    algorithm 
      h_der := sum((cp0[i]*(T-T0)+h0[i])*X_i_der[i] for i in 1:nX-1)+
               sum(cp0[i]*X_i[i]*T_der for i in 1:nX-1)+
                   (cp0[nX]*(T-T0)+h0[nX])*(1-sum(X_i_der)) +
                    cp0[nX]*(1-sum(X_i))*T_der;
    end f_enthalpy_der;
    
    //       function f_enthalpy 
    //         input Modelica.SIunits.Temperature T;
    //         input Modelica.SIunits.MassFraction X[nX];
    //         output Modelica.SIunits.SpecificEnthalpy h;
    //       protected 
    //         SI.SpecificEnthalpy h_component[nX];
    //         annotation(derivative=f_enthalpy_der);
    //       algorithm 
    //         for i in 1:nX loop
    //           h_component[i] :=(cp0[i]*(T - T0) + h0[i]);
    //         end for;
    //         h:= h_component[1:nX]*X;
    //       end f_enthalpy;
    
    //       function f_enthalpy_der 
    //         input Modelica.SIunits.Temperature T;
    //         input Modelica.SIunits.MassFraction X[nX];
    //         input Real T_der;
    //         input Real X_der[nX];
    //         output Modelica.SIunits.SpecificEnthalpy h_der;
    //         annotation(derivative=f_enthalpy_der);
    //       algorithm 
    //         h_der := sum((cp0[i]*(T-T0)+h0[i])*X_der[i] for i in 1:nX)+
    //                  sum(cp0[i]*X[i]*T_der for i in 1:nX);
    //       end f_enthalpy_der;
    
  end DummyFunctionMedium;
  
  model TestDummyFunctionMedium "Test Modelica.Media.Air.SimpleAir" 
    extends ModelicaTest.Media.TestStaticSelection.PartialTestModel(
      redeclare package Medium = DummyFunctionMedium,
      medium1(
        p(start=1e5, fixed=true),
        T(start=300, fixed=true),
        X_i(each fixed=true)),
      medium2(
        p(start=1e5, fixed=true),
        T(start=300, fixed=true),
        X_i(each fixed=true)));
  end TestDummyFunctionMedium;
  
end TestStaticSelection;
