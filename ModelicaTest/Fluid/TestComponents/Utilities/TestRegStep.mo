within ModelicaTest.Fluid.TestComponents.Utilities;
model TestRegStep "Test regStep function"
  extends Modelica.Icons.Example;
  import Modelica.Fluid.Utilities.*;
  parameter Real x_small=0.5;
  Real x=time - 0.6;
  Real yRegStep = Modelica.Fluid.Utilities.regStep(x,1,0.5,x_small);
  Real yRegStep_der;
equation
  yRegStep_der = der(yRegStep);
  annotation (experiment(StopTime=1.3), experimentSetupOutput);
end TestRegStep;
