within ModelicaTest.Fluid.TestComponents.Utilities;
model TestRegRoot2ZeroDerivative
  "Test whether regRoot2 can be differentiated with a zero derivative (like in incompressible valve"
  extends Modelica.Icons.Example;
  parameter Real x_small = 0.01;

  Real x;

  Real y1;
  Real y1d;
  Real y1dd;

  Real y2;
  Real y2d;
  Real y2dd;

  Real y3;
  Real y3d;
  Real y3dd;

  Real y4;
  Real y4d;
  Real y4dd;
equation
  x = time - 1;

  y1 = Modelica.Fluid.Utilities.regRoot2(x, x_small, 1.0, 0.0, true, 0.0);
  y1d = der(y1);
  y1dd = der(y1d);

  y2 = Modelica.Fluid.Utilities.regRoot2(x, x_small, 0.0, 1.0, true, 0.0);
  y2d = der(y2);
  y2dd = der(y2d);

  y3 = Modelica.Fluid.Utilities.regRoot2(x, x_small, 0.0, 0.0, true, 0.0);
  y3d = der(y3);
  y3dd = der(y3d);

  y4 = Modelica.Fluid.Utilities.regRoot2(x, x_small, 1.0, 0.0);
  y4d = der(y4);
  y4dd = der(y4d);

  annotation (experiment(StopTime=2, NumberOfIntervals=5000));
end TestRegRoot2ZeroDerivative;
