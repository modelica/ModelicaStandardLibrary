function testAllMedia 
  "Test all media of Modelica.Media whether they simulate and have the expected structural properties" 
  extends Modelica.Icons.Function;
  import Modelica.Utilities.Streams.*;
  
// Models to be tested
protected 
String models[:] =  {"Modelica.Media.Examples.Tests.MediaTestModels.Air.SimpleAir",
                     "Modelica.Media.Examples.Tests.MediaTestModels.Air.DryAirNasa",
                     "Modelica.Media.Examples.Tests.MediaTestModels.Air.MoistAir",
                     "Modelica.Media.Examples.Tests.MediaTestModels.IdealGases.Air",
                     "Modelica.Media.Examples.Tests.MediaTestModels.IdealGases.SimpleNaturalGas",
                     "Modelica.Media.Examples.Tests.MediaTestModels.Incompressible.Glycol47",
                     "Modelica.Media.Examples.Tests.MediaTestModels.Incompressible.Essotherm650",
                     "Modelica.Media.Examples.Tests.MediaTestModels.Water.ConstantPropertyLiquidWater",
                     "Modelica.Media.Examples.Tests.MediaTestModels.Water.IdealSteam",
                     "Modelica.Media.Examples.Tests.MediaTestModels.Water.WaterIF97OnePhase_ph",
                     "Modelica.Media.Examples.Tests.MediaTestModels.Water.WaterIF97_pT",
                     "Modelica.Media.Examples.Tests.MediaTestModels.Water.WaterIF97_ph",
                     "ModelicaTest.Media.Utilities.TestDummyFunctionMedium"};
  //                        "Modelica.Media.Examples.Tests.MediaTestModels.Water.WaterIF97_dT",
algorithm 
  ModelicaTest.Media.Utilities.testMedia(models);
end testAllMedia;
