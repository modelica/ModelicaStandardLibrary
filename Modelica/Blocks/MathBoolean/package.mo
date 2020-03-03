within Modelica.Blocks;
package MathBoolean "Library of Boolean mathematical functions as input/output blocks"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
This package contains basic <strong>mathematical operations</strong>
on <strong>Boolean</strong> signals.
</p>

<p>
The new features are:
</p>

<ul>
<li> If useful, blocks may have an arbitrary number of inputs (e.g., \"And\" block with 2,3,4,...
     Boolean inputs). This is based on the \"connectorSizing\" annotation which
     allows a tool to conveniently handle vectors of connectors.</li>

<li> The blocks are smaller in size, so that the diagram area is better
     utilized for trivial blocks such as \"And\" or \"Or\".</li>

</ul>

</html>"), Icon(graphics={Line(points={{-80,-16},{-4,-16},{-4,28},{38,28},{38,
              -16},{66,-16}}, color={255,0,255})}));
end MathBoolean;
