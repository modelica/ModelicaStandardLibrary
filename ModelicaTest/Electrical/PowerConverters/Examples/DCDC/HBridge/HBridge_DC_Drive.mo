within ModelicaTest.Electrical.PowerConverters.Examples.DCDC.HBridge;
model HBridge_DC_Drive "H bridge DC/DC converter with DC drive"
  extends Modelica.Electrical.PowerConverters.Examples.DCDC.HBridge.HBridge_DC_Drive;
  annotation (
    experiment(
      StopTime=4.10,
      Interval=0.0002,
      Tolerance=1e-06),
     TestCase(shouldPass = true,
      __ModelicaAssociation(Comparison(timeWindows={TimeWindow(4.00, 4.10)}))));
end HBridge_DC_Drive;
