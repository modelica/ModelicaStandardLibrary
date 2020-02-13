within Modelica.Electrical.Analog.Sources;
model ConstantCurrent "Source for constant current"
  parameter SI.Current I(start=1) "Value of constant current";
  extends Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Icons.CurrentSource;
equation
  i = I;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Text(
          extent={{-150,-100},{150,-60}},
          textString="I=%I")}),
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>The ConstantCurrent source is a simple source for an ideal constant current which is provided by a parameter. There is no internal resistance modeled. No further effects are modeled. Especially, the current flow will never end.</p>
</html>"));
end ConstantCurrent;
