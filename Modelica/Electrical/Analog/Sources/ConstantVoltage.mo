within Modelica.Electrical.Analog.Sources;
model ConstantVoltage "Source for constant voltage"
  parameter SI.Voltage V(start=1) "Value of constant voltage";
  extends Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Icons.VoltageSource;
equation
  v = V;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Text(
          extent={{-150,-110},{150,-70}},
          textString="V=%V")}),
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>The ConstantVoltage source is a simple source for an ideal constant voltage which is provided by a parameter. There is no internal resistance modeled. If it is used instead of a battery model it is not very realistic: This battery will never be unloaded.</p>
</html>"));
end ConstantVoltage;
