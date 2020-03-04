within Modelica.Blocks.Logical;
block Edge "Output y is true, if the input u has a rising edge (y = edge(u))"

  parameter Boolean pre_u_start=false "Start value of pre(u) at initial time";
  extends Blocks.Interfaces.partialBooleanSISO;

initial equation
  pre(u) = pre_u_start;
equation
  y = edge(u);
  annotation (
    defaultComponentName="edge1",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-90,40},{90,-40}},
          textString="edge")}),
    Documentation(info="<html>
<p>
The output is <strong>true</strong> if the Boolean input has a rising edge
from <strong>false</strong> to <strong>true</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
end Edge;
