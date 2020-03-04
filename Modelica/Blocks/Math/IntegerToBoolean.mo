within Modelica.Blocks.Math;
block IntegerToBoolean "Convert Integer to Boolean signal"

  Blocks.Interfaces.IntegerInput u "Connector of Integer input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  extends Interfaces.partialBooleanSO;
  parameter Integer threshold=1
    "Output signal y is true, if input u >= threshold";

equation
  y = u >= threshold;
  annotation (Documentation(info="<html>
<p>
This block computes the Boolean output <strong>y</strong>
from the Integer input <strong>u</strong> by the equation:
</p>

<blockquote><pre>
y = u &ge; threshold;
</pre></blockquote>

<p>
where <strong>threshold</strong> is a parameter.
</p>
</html>"),
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-86,92},{-6,10}},
          textColor={255,128,0},
          textString="I"),
        Polygon(
          points={{-12,-46},{-32,-26},{-32,-36},{-64,-36},{-64,-56},{-32,-56},
              {-32,-66},{-12,-46}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{8,-4},{92,-94}},
          textColor={255,0,255},
          textString="B")}));
end IntegerToBoolean;
