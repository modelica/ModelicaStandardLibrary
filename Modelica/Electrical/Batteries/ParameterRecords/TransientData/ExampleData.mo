within Modelica.Electrical.Batteries.ParameterRecords.TransientData;
record ExampleData "Example parameters of a transient battery cell"
  extends Modelica.Electrical.Batteries.ParameterRecords.TransientData.CellData(
    CellType="Example data",
    useLinearSOCDependency=false,
    OCVmax=4.2,
    OCVmin=2.5,
    SOCmax=1,
    SOCmin=0,
    OCV_SOC=[0.00,0.595; 0.01,0.656; 0.02,0.688; 0.03,0.714; 0.04,0.737; 0.05,
        0.744; 0.06,0.750; 0.07,0.754; 0.08,0.756; 0.09,0.758; 0.10,0.761; 0.15,
        0.774; 0.20,0.786; 0.25,0.795; 0.30,0.804; 0.35,0.811; 0.40,0.818; 0.45,
        0.826; 0.50,0.835; 0.55,0.843; 0.60,0.855; 0.65,0.871; 0.70,0.888; 0.75,
        0.905; 0.80,0.926; 0.85,0.943; 0.90,0.964; 0.95,0.980; 1.00,1.00],
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    nRC=2,
    rcData={
      Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData(R=0.2*Ri, C=60/(0.2*Ri)),
      Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData(R=0.1*Ri, C=10/(0.1*Ri))});
  annotation(defaultComponentPrefixes="parameter", Documentation(info="<html>
  <p>This is an example for an OCV versus SOC characteristic</p>
</html>"));
end ExampleData;
