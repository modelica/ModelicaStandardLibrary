within Modelica.ComplexBlocks.Routing;
block Extractor
  "Extract scalar signal out of signal vector dependent on IntegerRealInput index"

  extends Modelica.ComplexBlocks.Interfaces.ComplexMISO;

  parameter Boolean allowOutOfRange=false "Index may be out of range";
  parameter Complex outOfRangeValue=Complex(1e10,0) "Output signal if index is out of range";

  Modelica.Blocks.Interfaces.IntegerInput index annotation (Placement(
          transformation(
          origin={0,-120},
          extent={{-20,-20},{20,20}},
          rotation=90)));
protected
  Complex k[nin];
equation

  when {initial(),change(index)} then

    for i in 1:nin loop
      k[i] = if index == i then Complex(1,0) else Complex(0,0);

    end for;

  end when;

  y = if not allowOutOfRange or index > 0 and index <= nin then
              k*u else outOfRangeValue;
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-80,50},{-40,-50}},
            lineColor={85,170,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-84.4104,1.9079},{-84.4104,-2.09208},{-80.4104,-0.09208},{
                -84.4104,1.9079}},
            lineColor={85,170,255},
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-62,2},{-50.1395,12.907},{-39.1395,12.907}}, color={85,
                170,255}),
          Line(points={{-63,4},{-49,40},{-39,40}}, color={85,170,255}),
          Line(points={{-102,0},{-65.0373,-0.01802}}, color={85,170,255}),
          Ellipse(
            extent={{-70.0437,4.5925},{-60.0437,-4.90745}},
            lineColor={85,170,255},
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-63,-5},{-50,-40},{-39,-40}}, color={85,170,255}),
          Line(points={{-62,-2},{-50.0698,-12.907},{-39.0698,-12.907}}, color={85,
                170,255}),
          Polygon(
            points={{-38.8808,-11},{-38.8808,-15},{-34.8808,-13},{-38.8808,-11}},
            lineColor={85,170,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-39,42},{-39,38},{-35,40},{-39,42}},
            lineColor={85,170,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-38.8728,-38.0295},{-38.8728,-42.0295},{-34.8728,-40.0295},
                {-38.8728,-38.0295}},
            lineColor={85,170,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-38.9983,14.8801},{-38.9983,10.8801},{-34.9983,12.8801},{-38.9983,
                14.8801}},
            lineColor={85,170,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-30,50},{30,-50}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={85,170,255}),
          Line(points={{100,0},{0,0}}, color={85,170,255}),
          Line(points={{0,2},{0,-104}}, color={255,128,0}),
          Line(points={{-35,40},{-20,40}}, color={85,170,255}),
          Line(points={{-35,13},{-20,13}}, color={85,170,255}),
          Line(points={{-35,-13},{-20,-13}}, color={85,170,255}),
          Line(points={{-35,-40},{-20,-40}}, color={85,170,255}),
          Polygon(points={{0,0},{-20,13},{-20,13},{0,0},{0,0}}, lineColor={85,
                170,255}),
          Ellipse(
            extent={{-6,6},{6,-6}},
            lineColor={255,128,0},
            fillColor={255,128,0},
            fillPattern=FillPattern.Solid)}),
                            Documentation(info="<html>
<p>This block extracts a scalar output signal out the
vector of input signals dependent on the Integer
value of the additional u index:</p>
<blockquote><pre>
y = u [ index ] ;
</pre></blockquote>
<p>where index is an additional Integer input signal.</p>
</html>"));
end Extractor;
