within TestExternalTables;
model testCombiTimeTable2
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics),
    experiment(StopTime=1500),
    experimentSetupOutput);
  Modelica.Blocks.Sources.CombiTimeTable tableOld(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Blocks.Sources.CombiTimeTable tableNew(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
end testCombiTimeTable2;
