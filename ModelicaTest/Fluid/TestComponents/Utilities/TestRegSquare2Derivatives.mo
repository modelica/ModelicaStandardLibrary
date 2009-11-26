within ModelicaTest.Fluid.TestComponents.Utilities;
model TestRegSquare2Derivatives "Test whether regSquare2 can be differentiated"
  extends Modelica.Icons.Example;
  parameter Real x_small = 0.1;
  parameter Real k1a = 1;
  parameter Real k1b = 0.2;
  parameter Real k2a = 2;
  parameter Real k2b = 0.2;
  Real x;
  Real y;
  Real yd;
  Real ydd;
  Real k1;
  Real k2;
  Real y2;
  Real y2d;
  Real y2dd;
equation
  x = time - 1;

  k1 = k1a + k1b*time;
  k2 = k2a + k2b*time;

  /*
  k1=1;
  k2=3;
  */

  y = Modelica.Fluid.Utilities.regSquare2(x,x_small, k1, k2);
  yd = der(y);
  ydd = der(yd);

  y2 = Modelica.Fluid.Utilities.regSquare2(x,x_small, k1, k2, true, 0.02);
  y2d = der(y2);
  y2dd = der(y2d);
  annotation (experiment(StopTime=2, NumberOfIntervals=5000),
                                      experimentSetupOutput);
end TestRegSquare2Derivatives;
