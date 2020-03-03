within Modelica.Blocks.Math;
block InverseBlockConstraints
  "Construct inverse model by requiring that two inputs and two outputs are identical"

  Modelica.Blocks.Interfaces.RealInput u1 "Input signal 1 (u1 = u2)"
    annotation (Placement(transformation(extent={{-240,-20},{-200,20}}), iconTransformation(extent={{-240,-20},{-200,20}})));
  Modelica.Blocks.Interfaces.RealInput u2 "Input signal 2 (u1 = u2)"
    annotation (Placement(transformation(extent={{-140,-20},{-180,20}}), iconTransformation(extent={{-140,-20},{-180,20}})));
  Modelica.Blocks.Interfaces.RealOutput y1 "Output signal 1 (y1 = y2)"
    annotation (Placement(transformation(extent={{200,-10},{220,10}}), iconTransformation(extent={{200,-10},{220,10}})));
  Modelica.Blocks.Interfaces.RealOutput y2 "Output signal 2 (y1 = y2)"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        origin={170,0}), iconTransformation(extent={{180,-10},{160,10}})));

equation
  u1 = u2;
  y1 = y2;
  annotation (
    defaultConnectionStructurallyInconsistent=true,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-120},{200,
            120}}), graphics={
        Line(
          points={{180,0},{200,0}},
          color={0,0,127}),
        Line(
          points={{-200,0},{-180,0}},
          color={0,0,127}),
        Rectangle(extent={{-190,120},{190,-120}}, lineColor={135,135,135})}),
    Documentation(info="<html>
<p>
Exchange input and output signals of a block, i.e., the previous
block inputs become block outputs and the previous block outputs become
block inputs. This block is used to construct inverse models.
Its usage is demonstrated in example:
<a href=\"modelica://Modelica.Blocks.Examples.InverseModel\">Modelica.Blocks.Examples.InverseModel</a>.
</p>

<p>
Note, if a block shall be inverted that has several input and output blocks,
then this can be easily achieved by using a vector of InverseBlockConstraints
instances:
</p>

<blockquote><pre>
InverseBlockConstraint invert[3];  // Block to be inverted has 3 input signals
</pre></blockquote>
</html>"));
end InverseBlockConstraints;
