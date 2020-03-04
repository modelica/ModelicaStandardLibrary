within Modelica.Blocks.Logical;
block Change
  "Output y is true, if the input u has a rising or falling edge (y = change(u))"

  parameter Boolean pre_u_start=false "Start value of pre(u) at initial time";
  extends Blocks.Interfaces.partialBooleanSISO;

initial equation
  pre(u) = pre_u_start;
equation
  y = change(u);
  annotation (
    defaultComponentName="change1",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-90,40},{90,-40}},
          textString="change")}),
    Documentation(info="<html>
<p>
The output is <strong>true</strong> if the Boolean input has either a rising edge
from <strong>false</strong> to <strong>true</strong> or a falling edge from
<strong>true</strong> to <strong>false</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
end Change;
