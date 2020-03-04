within Modelica.Blocks.Math;
block MinMax "Output the minimum and the maximum element of the input vector"
  extends Modelica.Blocks.Icons.Block;
  parameter Integer nu(min=0) = 0 "Number of input connections"
    annotation (Dialog(connectorSizing=true), HideResult=true);
  Modelica.Blocks.Interfaces.RealVectorInput u[nu]
    annotation (Placement(transformation(extent={{-120,70},{-80,-70}})));
  Modelica.Blocks.Interfaces.RealOutput yMax annotation (Placement(
        transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput yMin annotation (Placement(
        transformation(extent={{100,-70},{120,-50}})));
equation
  yMax = max(u);
  yMin = min(u);
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-12,80},{100,40}},
          textString="yMax"), Text(
          extent={{-10,-40},{100,-80}},
          textString="yMin")}), Documentation(info="<html>
<p>
Determines the minimum and maximum element of the input vector and
provide both values as output.
</p>
</html>"));
end MinMax;
