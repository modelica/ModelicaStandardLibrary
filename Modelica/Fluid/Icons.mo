within Modelica_Fluid;
package Icons "Library of resuable icons"
  extends Modelica.Icons.Library;
  partial class VariantLibrary
    "Icon for a library that contains several variants of one component"

    annotation (             Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-40,-40},{100,100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-70,-70},{70,70}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,-100},{40,40}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-125,158},{115,103}},
            lineColor={255,0,0},
            textString="%name")}));
  end VariantLibrary;

  partial package BaseClassLibrary "Icon for library"

    annotation (             Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,-100},{80,50}},
            lineColor={175,175,175},
            fillColor={235,255,253},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
            lineColor={175,175,175},
            fillColor={235,255,253},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
            lineColor={175,175,175},
            fillColor={235,255,253},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-94,15},{73,-16}},
            lineColor={0,0,255},
            textString="Library of"),
          Text(
            extent={{-120,122},{120,73}},
            lineColor={255,0,0},
            textString="%name"),
          Text(
            extent={{-92,-44},{73,-72}},
            lineColor={0,0,255},
            textString="Base classes")}));
  end BaseClassLibrary;

  partial class ObsoleteFunction "Icon for an interal function"

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Text(
            extent={{-140,162},{136,102}},
            textString="%name",
            lineColor={0,0,255}),
          Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={255,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-100,100},{100,-100}},
            lineColor={255,0,0},
            textString="f")}),
                      Documentation(info="<html>
<p>
This icon is designed for a <b>function</b>
</p>
</html>"));

  end ObsoleteFunction;
  annotation (Documentation(info="<html>
 
</html>"));
end Icons;
