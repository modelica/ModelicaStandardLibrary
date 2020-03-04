within Modelica.Blocks.Logical;
block TerminateSimulation "Terminate simulation if condition is fulfilled"

  Modelica.Blocks.Interfaces.BooleanOutput condition=false
    "Terminate simulation when condition becomes true" annotation (Dialog,
      Placement(transformation(extent={{200,-10},{220,10}})));
  parameter String terminationText="... End condition reached"
    "Text that will be displayed when simulation is terminated";

equation
  when condition then
    terminate(terminationText);
  end when;
  annotation (Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-200,-20},{200,20}},
        initialScale=0.2),
        graphics={
      Rectangle(fillColor={235,235,235},
        fillPattern=FillPattern.Solid,
        lineThickness=5,
        borderPattern=BorderPattern.Raised,
        extent={{-200,-20},{200,20}}),
      Text(extent={{-166,-15},{194,15}},
        textString="%condition"),
      Rectangle(fillColor={161,35,41},
        fillPattern=FillPattern.Solid,
        borderPattern=BorderPattern.Raised,
        extent={{-194,-14},{-168,14}}),
      Text(textColor={0,0,255},
        extent={{-200,22},{200,46}},
        textString="%name")}), Documentation(info="<html>
<p>
In the parameter menu, a <strong>time varying</strong> expression can be defined
via variable <strong>condition</strong>, for example \"condition = x &lt; 0\",
where \"x\" is a variable that is declared in the model in which the
\"TerminateSimulation\" block is present.
If this expression becomes <strong>true</strong>,
the simulation is (successfully) terminated. A termination message
explaining the reason for the termination can be given via
parameter \"terminationText\".
</p>

</html>"));
end TerminateSimulation;
