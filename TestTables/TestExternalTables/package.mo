within ;
package TestExternalTables 
  annotation (uses(Modelica(version="3.0")));


  model testCombiTimeTable
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),   graphics),
      experiment(StopTime=4),
      experimentSetupOutput);
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_old(smoothness=
          Modelica.Blocks.Types.Smoothness.LinearSegments, table=[0,0; 1,1; 2,4;
          2,6; 3,8; 4,9]) 
      annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
    Blocks.Sources.CombiTimeTable combiTimeTable_new(smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
        table=[0,0; 1,1; 2,4; 2,6; 3,8; 4,9]) 
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  end testCombiTimeTable;


  model testCombiTable1D
    Blocks.Tables.CombiTable1D tableNew(table=[0,0; 1,1; 2,4]) 
      annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
    Modelica.Blocks.Sources.Sine sine(amplitude=2, freqHz=2) 
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}),        graphics));
    Modelica.Blocks.Tables.CombiTable1D tableOld(table=[0,0; 1,1; 2,4]) 
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  equation
  connect(sine.y, tableNew.u[1])       annotation (Line(
        points={{-39,30},{-30,30},{-30,-10},{-22,-10}},
        color={0,0,127},
        smooth=Smooth.None));
  connect(sine.y, tableOld.u[1]) annotation (Line(
      points={{-39,30},{-22,30}},
      color={0,0,127},
      smooth=Smooth.None));
  end testCombiTable1D;


  model testCombiTable1Ds
    Modelica.Blocks.Sources.Sine sine(amplitude=2, freqHz=2) 
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}),        graphics));
    Blocks.Tables.CombiTable1Ds tableNew(table=[0,0; 1,1; 2,4]) 
      annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
    Modelica.Blocks.Tables.CombiTable1Ds tableOld(table=[0,0; 1,1; 2,4]) 
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  equation
  connect(sine.y, tableNew.u)        annotation (Line(
        points={{-39,30},{-30,30},{-30,-10},{-22,-10}},
        color={0,0,127},
        smooth=Smooth.None));
  connect(sine.y, tableOld.u) annotation (Line(
      points={{-39,30},{-22,30}},
      color={0,0,127},
      smooth=Smooth.None));
  end testCombiTable1Ds;


  model testCombiTable2D
    Modelica.Blocks.Sources.Sine sine1(amplitude=2, freqHz=2) 
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}),        graphics));
    Modelica.Blocks.Tables.CombiTable2D tableOld(table=[0,0,1,2; 0,0,0,0; 1,0,1,
        2; 2,0,2,2.5]) 
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    Modelica.Blocks.Sources.Sine sine2(
      amplitude=2,
      freqHz=2,
      phase=1.570796326794897) 
      annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
    Blocks.Tables.CombiTable2D tableNew(table=[0,0,1,2; 0,0,0,0; 1,0,1,2; 2,0,2,
        2.5]) 
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  equation
  connect(sine2.y, tableOld.u2)                annotation (Line(
        points={{-59,10},{-42,10},{-42,24},{-22,24}},
        color={0,0,127},
        smooth=Smooth.None));
  connect(sine1.y, tableOld.u1)                annotation (Line(
        points={{-59,50},{-40,50},{-40,36},{-22,36}},
        color={0,0,127},
        smooth=Smooth.None));
  connect(sine1.y, tableNew.u1)           annotation (Line(
        points={{-59,50},{-40,50},{-40,36},{-30,36},{-30,-24},{-22,-24}},
        color={0,0,127},
        smooth=Smooth.None));
  connect(sine2.y, tableNew.u2)           annotation (Line(
        points={{-59,10},{-42,10},{-42,-36},{-22,-36}},
        color={0,0,127},
        smooth=Smooth.None));
  end testCombiTable2D;

end TestExternalTables;
