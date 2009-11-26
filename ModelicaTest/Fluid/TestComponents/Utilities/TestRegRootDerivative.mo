within ModelicaTest.Fluid.TestComponents.Utilities;
model TestRegRootDerivative
  "Demonstrate that regRoot cannot be differentiated in a typical pressure drop equation (model fails during simulation)"
  extends Modelica.Icons.Example;
  parameter Real x_small = 0.01;
  Real x;
  Real y;
  Real yd;
  Real k1;
  Real k2;
equation
  x = time - 1;
  k1 = 1 + 0.1*time;
  k2 = 2 + 0.2*time;

  y = (if x >= 0 then k1 else k2)*Modelica.Fluid.Utilities.regRoot(x,x_small);
  yd = 0 "model does not translate if y=0 is replaced by y=der(y)";
  annotation (experiment(StopTime=2, NumberOfIntervals=5000),
                                      experimentSetupOutput,
    Documentation(info="<html>
<p>
This test model demonstrates that the regRoot(..) function cannot
be differentiated, if multiplied with a discontinuous factor as it
is usual for pressure drop components where upstream properties
are used. In such a case, the regRoot2(..) function should be used.
In order to test this behaviour, change the line \"yd=0\" to \"yd = der(y)\".
</p>
</html>"));
end TestRegRootDerivative;
