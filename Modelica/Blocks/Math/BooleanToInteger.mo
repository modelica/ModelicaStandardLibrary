within Modelica.Blocks.Math;
block BooleanToInteger "Convert Boolean to Integer signal"
  extends Interfaces.partialBooleanSI;
  parameter Integer integerTrue=1 "Output signal for true Boolean input";
  parameter Integer integerFalse=0 "Output signal for false Boolean input";

  Blocks.Interfaces.IntegerOutput y "Connector of Integer output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

equation
  y = if u then integerTrue else integerFalse;
  annotation (Documentation(info="<html>
<p>
This block computes the output <strong>y</strong>
as <em>Integer equivalent</em> of the Boolean input <strong>u</strong>:
</p>
<blockquote><pre>
y = <strong>if</strong> u <strong>then</strong> integerTrue <strong>else</strong> integerFalse;
</pre></blockquote>
<p>where <strong>u</strong> is of Boolean and <strong>y</strong> of Integer type,
and <strong>integerTrue</strong> and <strong>integerFalse</strong> are parameters.
</p>
</html>"),
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-86,92},{-6,10}},
          textColor={255,0,255},
          textString="B"),
        Polygon(
          points={{-12,-46},{-32,-26},{-32,-36},{-64,-36},{-64,-56},{-32,-56},
              {-32,-66},{-12,-46}},
          lineColor={255,170,85},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{8,-4},{92,-94}},
          textColor={255,170,85},
          textString="I")}));
end BooleanToInteger;
