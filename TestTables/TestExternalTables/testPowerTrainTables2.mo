within TestExternalTables;
model testPowerTrainTables2
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
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{-8,70},{12,90}})));
  TestExternalTables.Blocks.Sources.Sine sine(freqHz=2) 
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{500,100}}),      graphics), Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{500,100}})),
    experiment(StopTime=1500),
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

  Modelica.Blocks.Sources.CombiTimeTable tableOld(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{-8,108},{12,128}})));

  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable1(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{-8,30},{12,50}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable2(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable3(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{-8,-50},{12,-30}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable4(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{32,70},{52,90}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable5(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{32,30},{52,50}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable6(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{32,-10},{52,10}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable7(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{32,-50},{52,-30}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable8(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{68,70},{88,90}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable9(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{68,30},{88,50}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable10(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{68,-10},{88,10}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable11(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{68,-50},{88,-30}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable12(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable13(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable14(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable15(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable16(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{140,70},{160,90}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable17(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{140,30},{160,50}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable18(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{140,-10},{160,10}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable19(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{140,-50},{160,-30}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable20(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{176,70},{196,90}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable21(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{176,30},{196,50}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable22(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{176,-10},{196,10}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable23(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{176,-50},{196,-30}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable24(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{208,70},{228,90}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable25(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{208,30},{228,50}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable26(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{208,-10},{228,10}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable27(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{208,-50},{228,-30}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable28(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{248,70},{268,90}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable29(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{248,30},{268,50}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable30(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{248,-10},{268,10}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable31(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{248,-50},{268,-30}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable32(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{284,70},{304,90}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable33(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{284,30},{304,50}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable34(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{284,-10},{304,10}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable35(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{284,-50},{304,-30}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable36(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{316,70},{336,90}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable37(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{316,30},{336,50}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable38(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{316,-10},{336,10}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable39(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{316,-50},{336,-30}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable40(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{356,70},{376,90}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable41(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{356,30},{376,50}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable42(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{356,-10},{376,10}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable43(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{356,-50},{376,-30}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable44(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{392,70},{412,90}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable45(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{392,30},{412,50}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable46(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{392,-10},{412,10}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable47(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{392,-50},{412,-30}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable48(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{426,72},{446,92}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable49(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{426,32},{446,52}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable50(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{426,-8},{446,12}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable51(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{426,-48},{446,-28}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable52(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{-8,-82},{12,-62}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable53(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{32,-82},{52,-62}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable54(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{68,-82},{88,-62}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable55(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{100,-82},{120,-62}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable56(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{140,-82},{160,-62}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable57(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{176,-82},{196,-62}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable58(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{208,-82},{228,-62}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable59(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{248,-82},{268,-62}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable60(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{284,-82},{304,-62}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable61(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{316,-82},{336,-62}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable62(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{356,-82},{376,-62}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable63(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{392,-82},{412,-62}})));
  TestExternalTables.Blocks.Sources.CombiTimeTable combiTimeTable64(
    tableOnFile=true,
    tableName="driveCycleData",
    fileName="EPA_CTY_FTP72.txt") 
    annotation (Placement(transformation(extent={{426,-80},{446,-60}})));

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
end testPowerTrainTables2;
