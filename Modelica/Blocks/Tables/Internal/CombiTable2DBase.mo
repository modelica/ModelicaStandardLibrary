within Modelica.Blocks.Tables.Internal;
partial block CombiTable2DBase "Base class for variants of table look-up in two dimensions"
  parameter Boolean tableOnFile=false
    "= true, if table is defined on file or in function usertab"
    annotation (Dialog(group="Table data definition"));
  parameter Real table[:, :] = fill(0.0, 0, 2)
    "Table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0, 0; 0, 1])"
    annotation (Dialog(group="Table data definition",enable=not tableOnFile));
  parameter String tableName="NoName"
    "Table name on file or in function usertab (see docu)"
    annotation (Dialog(group="Table data definition",enable=tableOnFile));
  parameter String fileName="NoName" "File where matrix is stored"
    annotation (Dialog(
      group="Table data definition",
      enable=tableOnFile,
      loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
          caption="Open file in which table is present")));
  parameter Boolean verboseRead=true
    "= true, if info message that file is loading is to be printed"
    annotation (Dialog(group="Table data definition",enable=tableOnFile));
  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation"
    annotation (Dialog(group="Table data interpretation"));
  parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints
    "Extrapolation of data outside the definition range"
    annotation (Dialog(group="Table data interpretation"));
  parameter Boolean verboseExtrapolation=false
    "= true, if warning messages are to be printed if table input is outside the definition range"
    annotation (Dialog(group="Table data interpretation", enable=extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
  final parameter Real u_min[2]=getTable2DAbscissaUmin(tableID)
    "Minimum abscissa value defined in table";
  final parameter Real u_max[2]=getTable2DAbscissaUmax(tableID)
    "Maximum abscissa value defined in table";
protected
    parameter Modelica.Blocks.Types.ExternalCombiTable2D tableID=
      Modelica.Blocks.Types.ExternalCombiTable2D(
        if tableOnFile then tableName else "NoName",
        if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
        table,
        smoothness,
        extrapolation,
        if tableOnFile then verboseRead else false) "External table object";
equation
    if tableOnFile then
      assert(tableName <> "NoName",
        "tableOnFile = true and no table name given");
    else
      assert(size(table, 1) > 0 and size(table, 2) > 0,
        "tableOnFile = false and parameter table is an empty matrix");
    end if;
  annotation(Icon(
  coordinateSystem(preserveAspectRatio=true,
    extent={{-100.0,-100.0},{100.0,100.0}}),
    graphics={
  Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
  Line(points={{0.0,40.0},{0.0,-40.0}}),
  Line(points={{-60.0,40.0},{-30.0,20.0}}),
  Line(points={{-30.0,40.0},{-60.0,20.0}}),
  Rectangle(origin={2.3077,-0.0},
    fillColor={255,215,136},
    fillPattern=FillPattern.Solid,
    extent={{-62.3077,0.0},{-32.3077,20.0}}),
  Rectangle(origin={2.3077,-0.0},
    fillColor={255,215,136},
    fillPattern=FillPattern.Solid,
    extent={{-62.3077,-20.0},{-32.3077,0.0}}),
  Rectangle(origin={2.3077,-0.0},
    fillColor={255,215,136},
    fillPattern=FillPattern.Solid,
    extent={{-62.3077,-40.0},{-32.3077,-20.0}}),
  Rectangle(fillColor={255,215,136},
    fillPattern=FillPattern.Solid,
    extent={{-30.0,20.0},{0.0,40.0}}),
  Rectangle(fillColor={255,215,136},
    fillPattern=FillPattern.Solid,
    extent={{0.0,20.0},{30.0,40.0}}),
  Rectangle(origin={-2.3077,-0.0},
    fillColor={255,215,136},
    fillPattern=FillPattern.Solid,
    extent={{32.3077,20.0},{62.3077,40.0}})}));
end CombiTable2DBase;
