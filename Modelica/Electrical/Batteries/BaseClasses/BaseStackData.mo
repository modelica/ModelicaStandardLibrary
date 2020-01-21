within Modelica.Electrical.Batteries.BaseClasses;
record BaseStackData "Parameters for stacks including degradation"
  extends Modelica.Electrical.Batteries.Icons.BaseStackRecord;
  import Modelica.Math.BooleanVectors.anyTrue;
  parameter Integer Ns(final min=1) "Number of series connected cells";
  parameter Integer Np(final min=1) "Number of parallel connected cells";
  parameter Integer kDegraded[:,2]={{0,0}} "Indices of degraded cells [series index, parallel index]";
  replaceable parameter Modelica.Electrical.Batteries.ParameterRecords.CellData cellDataOriginal
    "Original cell data"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  replaceable parameter Modelica.Electrical.Batteries.ParameterRecords.CellData cellDataDegraded "Degraded cell data"
    annotation(Placement(transformation(extent={{20,-10},{40,10}})));
  replaceable parameter Modelica.Electrical.Batteries.ParameterRecords.CellData cellData[Ns, Np]=
    {{if anyTrue({ks==kDegraded[i,1] and kp==kDegraded[i,2] for i in 1:size(kDegraded,1)}) then
      cellDataDegraded else cellDataOriginal for kp in 1:Np} for ks in 1:Ns}
    "Matrix of cell data"
    annotation(Dialog(group="Result", enable=false), Placement(transformation(extent={{-10,-30},{10,-10}})));
  annotation(defaultComponentPrefixes="parameter", Documentation(info="<html>
  <p>This record contains the base cell data definition of original and degraded cell data.</p>
</html>"));
end BaseStackData;
