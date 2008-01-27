within TestExternalTables;
model testPowerTrainTables1
  TestExternalTables.Blocks.Tables.CombiTable1D table1(
    tableOnFile=true,
    tableName="torqueConverter",
    fileName="Gearbox4.txt") 
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  TestExternalTables.Blocks.Tables.CombiTable2D table2(
    tableOnFile=true,
    tableName="bearingFriction",
    fileName="Gearbox4.txt") 
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  TestExternalTables.Blocks.Sources.Sine sine(freqHz=2) 
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{500,100}}),      graphics), Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{500,100}})),
    experiment(StopTime=4),
    experimentSetupOutput);
  TestExternalTables.Blocks.Tables.CombiTable1D table3(
    tableOnFile=true,
    tableName="torqueConverter",
    fileName="Gearbox4.txt") 
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  TestExternalTables.Blocks.Tables.CombiTable1D table4(
    tableOnFile=true,
    tableName="torqueConverter",
    fileName="Gearbox4.txt") 
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  TestExternalTables.Blocks.Tables.CombiTable1D table5(
    tableOnFile=true,
    tableName="torqueConverter",
    fileName="Gearbox4.txt") 
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  TestExternalTables.Blocks.Tables.CombiTable2D table6(
    tableOnFile=true,
    tableName="bearingFriction",
    fileName="Gearbox4.txt") 
    annotation (Placement(transformation(extent={{-40,-92},{-20,-72}})));

  Modelica.Blocks.Tables.CombiTable1D table1Old(
    tableOnFile=true,
    tableName="torqueConverter",
    fileName="Gearbox4.txt") 
    annotation (Placement(transformation(extent={{34,-16},{54,4}})));
  Modelica.Blocks.Tables.CombiTable2D table2Old(
    tableOnFile=true,
    tableName="bearingFriction",
    fileName="Gearbox4.txt") 
    annotation (Placement(transformation(extent={{24,-62},{44,-42}})));
equation
  connect(sine.y, table1.u[1]) annotation (Line(
      points={{-59,-10},{-42,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sine.y, table2.u1) annotation (Line(
      points={{-59,-10},{-54,-10},{-54,-44},{-42,-44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sine.y, table2.u2) annotation (Line(
      points={{-59,-10},{-54,-10},{-54,-56},{-42,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sine.y, table3.u[1]) annotation (Line(
      points={{-59,-10},{-54,-10},{-54,20},{-42,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sine.y, table4.u[1]) annotation (Line(
      points={{-59,-10},{-54,-10},{-54,50},{-42,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sine.y, table5.u[1]) annotation (Line(
      points={{-59,-10},{-54,-10},{-54,80},{-42,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(table6.u1, sine.y) annotation (Line(
      points={{-42,-76},{-54,-76},{-54,-10},{-59,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(table6.u2, sine.y) annotation (Line(
      points={{-42,-88},{-54,-88},{-54,-10},{-59,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sine.y, table1Old.u[1]) annotation (Line(
      points={{-59,-10},{-12.5,-10},{-12.5,-6},{32,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sine.y, table2Old.u1) annotation (Line(
      points={{-59,-10},{6,-10},{6,-46},{22,-46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sine.y, table2Old.u2) annotation (Line(
      points={{-59,-10},{-18,-10},{-18,-58},{22,-58}},
      color={0,0,127},
      smooth=Smooth.None));
end testPowerTrainTables1;
