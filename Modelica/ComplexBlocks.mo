within Modelica;
package ComplexBlocks
  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)"
extends Modelica.Icons.Library2;

  annotation (Icon(graphics={
      Rectangle(extent={{-32,-6},{16,-35}}, lineColor={0,0,0}),
      Polygon(
        points={{-32,-21},{-46,-17},{-46,-25},{-32,-21}},
        lineColor={0,0,0},
        fillColor={0,0,0},
        fillPattern=FillPattern.Solid),
      Line(points={{-32,-72},{-64,-72},{-64,-21},{-32,-21}}, color={0,0,0}),
      Rectangle(extent={{-32,-56},{16,-85}}, lineColor={0,0,0}),
      Polygon(
        points={{16,-71},{29,-67},{29,-74},{16,-71}},
        lineColor={0,0,0},
        fillColor={0,0,0},
        fillPattern=FillPattern.Solid),
      Line(points={{16,-20},{49,-20},{49,-71},{16,-71}}, color={0,0,0})}));
  package Interfaces
    "Library of connectors and partial models for input/output blocks"
    extends Modelica.Icons.Library;

  connector ComplexInput = input Real "'input Complex' as connector" 
    annotation (defaultComponentName="u",
    Icon(graphics={Polygon(
            points={{-100,100},{100,0},{-100,-100},{-100,100}},
            lineColor={0,127,0},
            fillColor={0,127,0},
            fillPattern=FillPattern.Solid)},
         coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, initialScale=0.2)),
    Diagram(coordinateSystem(
          preserveAspectRatio=true, initialScale=0.2,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Polygon(
            points={{0,50},{100,0},{0,-50},{0,50}},
            lineColor={0,127,0},
            fillColor={0,127,0},
            fillPattern=FillPattern.Solid), Text(
            extent={{-10,85},{-10,60}},
            lineColor={0,0,127},
            textString="%name")}),
      Documentation(info="<html>
<p>
Connector with one input signal of type Complex.
</p>
</html>"));

  connector ComplexOutput = output Complex "'output Complex' as connector" 
    annotation (defaultComponentName="y",
    Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Polygon(
            points={{-100,100},{100,0},{-100,-100},{-100,100}},
            lineColor={0,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Polygon(
            points={{-100,50},{0,0},{-100,-50},{-100,50}},
            lineColor={0,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{30,110},{30,60}},
            lineColor={0,0,127},
            textString="%name")}),
      Documentation(info="<html>
<p>
Connector with one output signal of type Complex.
</p>
</html>"));
  end Interfaces;
end ComplexBlocks;
