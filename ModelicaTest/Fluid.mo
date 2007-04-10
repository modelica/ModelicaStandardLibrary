package Fluid "Test models for Modelica_Fluid" 
  function test_all_models 
    "Execute the tests to simulate all example and test models of library Modelica_Fluid" 
    extends Modelica.Icons.Function;
    
  // Names of example and test models that shall be simulated
  protected 
  String models[:] =  {"Modelica_Fluid.Examples.DrumBoiler.DrumBoilerSimulation",
                       "Modelica_Fluid.Examples.PumpingSystem",
                       "Modelica_Fluid.Examples.TestComponents.TestDistributedPipe",
                       "Modelica_Fluid.Examples.TestComponents.TestHeatExchanger",
                       "Modelica_Fluid.Examples.TestComponents.TestMixingVolumes",
                       "Modelica_Fluid.Examples.TestComponents.TestNewMixingVolume",
                       "Modelica_Fluid.Examples.TestComponents.TestPortVolumes",
                       "Modelica_Fluid.Examples.TestComponents.TestPressureDropDerivatives",
                       "Modelica_Fluid.Examples.TestComponents.TestRegFunctions",
                       "Modelica_Fluid.Examples.TestComponents.TestRegRoot2Derivatives",
                       "Modelica_Fluid.Examples.TestComponents.TestRegRootDerivative",
                       "Modelica_Fluid.Examples.TestComponents.TestRegSquare2Derivatives",
                       "Modelica_Fluid.Examples.TestComponents.TestSharpEdgedOrifice",
                       "Modelica_Fluid.Examples.TestComponents.TestShortPipe",
                       "Modelica_Fluid.Examples.TestComponents.TestShortPipeWithVolume",
                       "Modelica_Fluid.Examples.TestComponents.TestSimpleGenericOrifice",
                       "Modelica_Fluid.Examples.TestComponents.TestSplitter",
                       "Modelica_Fluid.Examples.TestComponents.TestSuddenExpansion",
                       "Modelica_Fluid.Examples.TestComponents.TestValveIncompressible",
                       "Modelica_Fluid.Examples.TestComponents.TestValvesReverse",
                       "Modelica_Fluid.Examples.TestComponents.TestWallFriction",
                       "Modelica_Fluid.Examples.TestComponents.TestWaterPump2",
                       "Modelica_Fluid.Examples.TestComponents.TestWaterPumpDefault",
                       "ModelicaTest.Fluid.TestVolumeAndPipeWithAllMedia.Using_SimpleAir",
                       "ModelicaTest.Fluid.TestVolumeAndPipeWithAllMedia.Using_DryAirNasa",
                       "ModelicaTest.Fluid.TestVolumeAndPipeWithAllMedia.Using_MoistAir",
                       "ModelicaTest.Fluid.TestVolumeAndPipeWithAllMedia.Using_SimpleNaturalGas",
                       "ModelicaTest.Fluid.TestVolumeAndPipeWithAllMedia.Using_Glycol47",
                       "ModelicaTest.Fluid.TestVolumeAndPipeWithAllMedia.Using_ConstantPropertyLiquidWater",
                       "ModelicaTest.Fluid.TestVolumeAndPipeWithAllMedia.Using_WaterIF97OnePhase_ph",
                       "ModelicaTest.Fluid.TestVolumeAndPipeWithAllMedia.Using_WaterIF97_pT",
                       "ModelicaTest.Fluid.TestVolumeAndPipeWithAllMedia.Using_WaterIF97_ph"};
    
  algorithm 
    ModelicaTest.UtilitiesForTesting.test_that_models_simulate(models);
  end test_all_models;
  
  package TestVolumeAndPipeWithAllMedia 
    "Test PortVolume and pipe component with all media classes" 
    
    model Using_SimpleAir 
      extends Modelica_Fluid.Examples.TestComponents.TestShortPipeWithVolume(
        redeclare package Medium = Modelica.Media.Air.SimpleAir);
    end Using_SimpleAir;
    
    model Using_DryAirNasa 
      extends Modelica_Fluid.Examples.TestComponents.TestShortPipeWithVolume(
        redeclare package Medium = Modelica.Media.Air.DryAirNasa);
    end Using_DryAirNasa;
    
    model Using_MoistAir 
      extends Modelica_Fluid.Examples.TestComponents.TestShortPipeWithVolume(
        redeclare package Medium = Modelica.Media.Air.MoistAir);
    end Using_MoistAir;
    
    model Using_SimpleNaturalGas 
      extends Modelica_Fluid.Examples.TestComponents.TestShortPipeWithVolume(
        redeclare package Medium = 
            Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas,
            volume(X_start=Medium.reference_X));
    end Using_SimpleNaturalGas;
    
    model Using_Glycol47 
      extends Modelica_Fluid.Examples.TestComponents.TestShortPipeWithVolume(
        redeclare package Medium = 
            Modelica.Media.Incompressible.Examples.Glycol47);
    end Using_Glycol47;
    
    model Using_ConstantPropertyLiquidWater 
      extends Modelica_Fluid.Examples.TestComponents.TestShortPipeWithVolume(
        redeclare package Medium = 
            Modelica.Media.Water.ConstantPropertyLiquidWater);
    end Using_ConstantPropertyLiquidWater;
    
    model Using_WaterIF97OnePhase_ph 
      extends Modelica_Fluid.Examples.TestComponents.TestShortPipeWithVolume(
        redeclare package Medium = Modelica.Media.Water.WaterIF97OnePhase_ph);
    end Using_WaterIF97OnePhase_ph;
    
    model Using_WaterIF97_pT 
      extends Modelica_Fluid.Examples.TestComponents.TestShortPipeWithVolume(
        redeclare package Medium = Modelica.Media.Water.WaterIF97_pT);
    end Using_WaterIF97_pT;
    
    model Using_WaterIF97_ph 
      extends Modelica_Fluid.Examples.TestComponents.TestShortPipeWithVolume(
        redeclare package Medium = Modelica.Media.Water.WaterIF97_ph);
    end Using_WaterIF97_ph;
  end TestVolumeAndPipeWithAllMedia;
  
  package OtherTestModels 
    model ThreeTanksWithPortVolume 
      "This model does not yet translate. Will be fixed" 
      import Modelica.SIunits.Conversions.*;
      extends Modelica.Icons.Example;
      annotation (
        Diagram,
        Coordsys(grid=[1, 1], component=[20, 20]),
        experiment(StopTime=5),
        Documentation(info="<html>
<p>
This example demonstrates the mixing of a single substance flow
between three tanks with different temperatures. The difference to
example \"ThreeTanksOneLiquid\" is that the port where the three
pipes are connected together contains a volume now, in order that
the mixing of the pipe flows is modelled more realistically.
</p>
</html>"));
      Modelica_Fluid.Components.Tank Tank1(
        area=1,
        T_start=from_degC(50),
        level_start=3,
        redeclare package Medium = 
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        initOption=Modelica_Fluid.Types.Init.InitialValues,
        pipeArea=0.01) 
        annotation (extent=[-90, 20; -70, 40]);
      Modelica_Fluid.Components.Tank Tank2(
        area=1,
        level_start=1,
        redeclare package Medium = 
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        initOption=Modelica_Fluid.Types.Init.InitialValues,
        T_start=from_degC(90),
        pipeArea=0.01) 
        annotation (extent=[-10, 20; 10, 40]);
      Modelica_Fluid.Components.PressureDropPipe shortPipe1(
        m_flow_nominal=2000,
        dp_nominal=from_bar(0.1),
        redeclare package Medium = 
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        frictionType=Modelica_Fluid.Types.FrictionTypes.ConstantLaminar) 
        annotation (extent=[-50, -40; -30, -20]);
      Modelica_Fluid.Components.Tank Tank3(
        area=1,
        T_start=from_degC(20),
        level_start=2,
        redeclare package Medium = 
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        initOption=Modelica_Fluid.Types.Init.InitialValues,
        pipeArea=0.01) "level(fixed=true)" 
        annotation (extent=[70,20; 90,40]);
      Modelica_Fluid.Components.PressureDropPipe shortPipe3(
        m_flow_nominal=2000,
        dp_nominal=from_bar(0.1),
        redeclare package Medium = 
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        frictionType=Modelica_Fluid.Types.FrictionTypes.ConstantLaminar) 
        annotation (extent=[29, -40; 49, -20]);
      Modelica_Fluid.Components.PressureDropPipe shortPipe2(
        m_flow_nominal=1000,
        dp_nominal=from_bar(0.1),
        redeclare package Medium = 
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        frictionType=Modelica_Fluid.Types.FrictionTypes.ConstantLaminar) 
        annotation (extent=[-10, -10; 10, 10], rotation=-90);
      Modelica_Fluid.Utilities.PortVolume junctionVolume(
        redeclare package Medium = 
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        V=1.e-4,
        T_start=from_degC(50.0),
        initOption=Modelica_Fluid.Types.Init.InitialValues) 
                                 annotation (extent=[-10, -40; 10, -20]);
      inner Modelica_Fluid.Components.FluidOptions fluidOptions 
        annotation (extent=[-100,-100; -80,-80]);
    equation 
      connect(Tank1.port, shortPipe1.port_a) 
        annotation (points=[-80,19; -80,-30; -50,-30],    style(color=69));
      connect(shortPipe3.port_b, Tank3.port) 
        annotation (points=[49,-30; 80,-30; 80,19],    style(color=69));
      connect(Tank2.port, shortPipe2.port_a) 
        annotation (points=[0,19; 0,10; -6.12303e-016,10],    style(color=69));
      connect(shortPipe2.port_b, junctionVolume.port) annotation (points=[
            6.12303e-016,-10; 0,-10; 0,-30],    style(color=69));
      connect(shortPipe1.port_b, junctionVolume.port) 
        annotation (points=[-30,-30; 0,-30],   style(color=69));
      connect(shortPipe3.port_a, junctionVolume.port) 
        annotation (points=[29,-30; 0,-30],   style(color=69));
    end ThreeTanksWithPortVolume;
    
    function plotRegRoot2 "Plot result of regRoot2 interpolation" 
      extends Modelica.Icons.Function;
      input Real x_small(min=0)=0.01 
        "approximation of function for |x| <= x_small";
      input Real k1(min=0)=1 "y = if x>=0 then sqrt(k1*x) else -sqrt(k2*|x|)";
      input Real k2(min=0)=1 "y = if x>=0 then sqrt(k1*x) else -sqrt(k2*|x|)";
      input Boolean use_yd0 = false "= true, if yd0 shall be used";
      input Real yd0(min=0)=1 "Desired derivative at x=0: dy/dx = yd0";
      input Integer id=0 "window id (0 means last)";
    protected 
      Integer n=500 "Number of points within x_small";
      Real x[:]=  -2*x_small:x_small/n:2*x_small;
      Real y[size(x,1), 2];
    algorithm 
      for i in 1:size(x,1) loop
         y[i,1] := if x[i] >= 0 then sqrt(k1*x[i]) else -sqrt(k2*abs(x[i]));
         y[i,2] := Modelica_Fluid.Utilities.regRoot2(
                      x[i], x_small, k1, k2, use_yd0, yd0);
      end for;
      
      plotArrays(x,y,title="x_small = " + String(x_small) +
                           ", k1 = " + String(k1) + ", k2 = " + String(k2) +
                           (if use_yd0 then ", yd0 = " + String(yd0) else " "),
                 legend={"y = sqrt(k*x)", "y = regRoot2(..)"},id=id);
    end plotRegRoot2;
    
    function plotRegSquare2 "Plot result of regSquare2 interpolation" 
      extends Modelica.Icons.Function;
      input Real x_small(min=0)=0.01 
        "approximation of function for |x| <= x_small";
      input Real k1(min=0)=1 "y = (if x>=0 then k1 else k2)*x*|x|";
      input Real k2(min=0)=1 "y = (if x>=0 then k1 else k2)*x*|x|";
      input Boolean use_yd0 = false "= true, if yd0 shall be used";
      input Real yd0(min=0)=1 "Desired derivative at x=0: dy/dx = yd0";
      input Integer id=0 "window id (0 means last)";
    protected 
      Integer n=500 "Number of points within x_small";
      Real x[:]=  -2*x_small:x_small/n:2*x_small;
      Real y[size(x,1), 2];
    algorithm 
      for i in 1:size(x,1) loop
         y[i,1] := (if x[i] >= 0 then k1 else -k2)*x[i]*x[i];
         y[i,2] := Modelica_Fluid.Utilities.regSquare2(
                      x[i], x_small, k1, k2, use_yd0, yd0);
      end for;
      
      plotArrays(x,y,title="x_small = " + String(x_small) +
                           ", k1 = " + String(k1) + ", k2 = " + String(k2) +
                           (if use_yd0 then ", yd0 = " + String(yd0) else " "),
                 legend={"y = k*x*|x|", "y = regSquare2(..)"},id=id);
    end plotRegSquare2;
    
    function testRegRoot2 
      "Test that Fluid.Utilities.regRoot2 is monotonically smooth" 
      extends Modelica.Icons.Function;
    algorithm 
      plotRegRoot2(0.01, 1, 1, id=1);
      plotRegRoot2(0.01, 100, 100, id=2);
      plotRegRoot2(0.01, 10, 1, id=3);
      plotRegRoot2(0.01, 1, 10, id=4);
      plotRegRoot2(0.01, 100, 1, id=5);
      plotRegRoot2(0.01, 1, 100, id=6);
      
    end testRegRoot2;
    
    function testRegSquare2 
      "Test that Fluid.Utilities.regSquare2 is monotonically smooth" 
      extends Modelica.Icons.Function;
    algorithm 
      plotRegSquare2(0.01, 1, 1, id=1);
      plotRegSquare2(0.01, 100, 100, id=2);
      plotRegSquare2(0.01, 10, 1, id=3);
      plotRegSquare2(0.01, 1, 10, id=4);
      plotRegSquare2(0.01, 100, 1, id=5);
      plotRegSquare2(0.01, 1, 100, id=6);
      
    end testRegSquare2;
  end OtherTestModels;
end Fluid;
