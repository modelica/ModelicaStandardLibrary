within ModelicaTest.Fluid.TestComponents.Machines;
model TestLinearPower
  extends Modelica.Icons.Example;
  Modelica.Units.SI.Power p;
equation
  p = Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.linearPower(V_flow_nominal={1,2}, W_nominal={3,5}, V_flow=11);
  assert(abs(p - 23) < 1e-9, "Error in linearPower");
annotation(experiment(StopTime=1));
end TestLinearPower;
