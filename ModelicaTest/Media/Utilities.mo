package Utilities "Utility function and components used for the tests" 
  extends Modelica.Icons.Library;
function testMedia 
    "Test a set of media whether they simulate and have the expected structural properties" 
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
    (passed[i],staticStateSelection[i]) :=  hasStaticStateSelection(models[i]);
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
    
end testMedia;
  
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
  
  package DummyFunctionMedium 
    "Fictitious liquid mixture with function-computed properties - emulates externally supplied media models" 
    
    extends Modelica.Media.Interfaces.PartialMixtureMedium(
       mediumName="Fictitous Liquid Mixture",
       substanceNames={"Kryptene","Simulene","Hysteric Acid"},
       final singleState=true,
       final reducedX=true,
       reference_X={0.3, 0.3, 0.4},
       Temperature(start=300, nominal=300));
    
    constant Modelica.SIunits.Pressure p0=1e5 "Reference pressure";
    constant Modelica.SIunits.Temperature T0=293.15 "Reference temperature";
    constant Modelica.SIunits.SpecificHeatCapacity cp0[nX]={4000,2500,2000};
    constant Modelica.SIunits.Density rho0[nX]={1000,500,700};
    constant Modelica.SIunits.RelativePressureCoefficient myBeta[nX]={1e-3,3e-3,
        5e-3};
    constant Modelica.SIunits.SpecificEnthalpy h0[nX]=fill(0, nX);
    redeclare record ThermodynamicState 
      Modelica.SIunits.Pressure p;
      Modelica.SIunits.Temperature T;
      Modelica.SIunits.MassFraction X[nX];
    end ThermodynamicState;
    
    redeclare model extends BaseProperties(
      T(stateSelect=if preferredMediumStates then StateSelect.default else StateSelect.default),
      Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default)) 
    equation 
      d = f_density(T,X);
      h = f_enthalpy(T,Xi);
      u = h;
      R=1;
      state.p=p;
      state.T=T;
      state.X=X;
      MM=0.1;
    end BaseProperties;
    
    redeclare function setState_pTX 
      "Return thermodynamic state as function of p, T and composition X" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:] "Mass fractions";
      output ThermodynamicState state;
    protected 
      MassFraction[:] Xf = if size(X,1) == nX then X else cat(1,X,{1-sum(X)});
    algorithm 
      state := if size(X,1) == nX then ThermodynamicState(p=p,T=T, X=Xf) else 
             ThermodynamicState(p=p,T=T, X=Xf);
    end setState_pTX;
    
    redeclare function setState_phX 
      "Return thermodynamic state as function of p, h and composition X" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:] "Mass fractions";
      output ThermodynamicState state;
    protected 
      MassFraction[:] Xf = if size(X,1) == nX then X else cat(1,X,{1-sum(X)});
    algorithm 
      state := if size(X,1) == nX then ThermodynamicState(p=p,T=h/sum(cp0[i]*Xf[i] for i in 1:nX),X=X) else 
             ThermodynamicState(p=p,T=h/sum(cp0[i]*Xf[i] for i in 1:nX), X=Xf);
    end setState_phX;
    
    redeclare function extends specificEnthalpy 
      "Return specific heat capacity at constant pressure" 
    algorithm 
      h := sum(cp0[i]*state.X[i] for i in 1:nX)*state.T;
    end specificEnthalpy;
    
    redeclare function extends specificHeatCapacityCp 
      "Return specific heat capacity at constant pressure" 
    algorithm 
      cp := sum(cp0[i]*state.X[i] for i in 1:nX);
    end specificHeatCapacityCp;
    
    redeclare function extends specificHeatCapacityCv 
      "Return specific heat capacity at constant volume" 
    algorithm 
      cv := sum(cp0[i]*state.X[i] for i in 1:nX);
    end specificHeatCapacityCv;
    
    redeclare function extends density_derT_p 
      "density derivative by specific enthalpy at const pressure" 
    algorithm 
      ddTp:=sum(-rho0[i]*myBeta[i]/cp0[i]*state.X[i] for i in 1:nX);
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
        dX[i] := rho0[i]*(1-myBeta[i]*(state.T-T0));
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
      d := 1/sum(X[i]/(rho0[i]*(1-myBeta[i]*(T-T0))) for i in 1:nX);
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
      input Modelica.SIunits.MassFraction Xi[nXi];
      output Modelica.SIunits.SpecificEnthalpy h;
    protected 
      Modelica.SIunits.SpecificEnthalpy h_component[nX];
      annotation(derivative=f_enthalpy_der);
    algorithm 
      for i in 1:nX loop
        h_component[i] :=(cp0[i]*(T - T0) + h0[i]);
      end for;
      h:= sum(h_component[1:nX-1]*Xi)+ h_component[nX]*(1-sum(Xi));
    end f_enthalpy;
    
    function f_enthalpy_der 
      input Modelica.SIunits.Temperature T;
      input Modelica.SIunits.MassFraction Xi[nXi];
      input Real T_der;
      input Real Xi_der[nXi];
      output Modelica.SIunits.SpecificEnthalpy h_der;
      annotation(derivative=f_enthalpy_der);
    algorithm 
      h_der := sum((cp0[i]*(T-T0)+h0[i])*Xi_der[i] for i in 1:nX-1)+
               sum(cp0[i]*Xi[i]*T_der for i in 1:nX-1)+
                   (cp0[nX]*(T-T0)+h0[nX])*(1-sum(Xi_der)) +
                    cp0[nX]*(1-sum(Xi))*T_der;
    end f_enthalpy_der;
    
  end DummyFunctionMedium;
  
  model TestDummyFunctionMedium 
    "Test Modelica.Media.Examples.Tests.Components.DummyFunctionMedium" 
    extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
       redeclare package Medium = 
          ModelicaTest.Media.Utilities.DummyFunctionMedium);
  end TestDummyFunctionMedium;
end Utilities;
