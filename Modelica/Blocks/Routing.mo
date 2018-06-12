within Modelica.Blocks;
package Routing "Library of blocks to combine and extract signals"
  extends Modelica.Icons.Package;

  block Replicator "Signal replicator"
    extends Modelica.Blocks.Interfaces.SIMO;
  equation
    y = fill(u, nout);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-100,0},{-6,0}}, color={0,0,127}),
          Line(points={{100,0},{10,0}}, color={0,0,127}),
          Line(points={{0,0},{100,10}}, color={0,0,127}),
          Line(points={{0,0},{100,-10}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
This block replicates the input signal to an array of <code>nout</code> identical output signals.
</p>
</html>"));
  end Replicator;

  block IntegerReplicator "Integer signal replicator"
    extends Modelica.Blocks.Icons.IntegerBlock;
    parameter Integer nout=1 "Number of outputs";
    Modelica.Blocks.Interfaces.IntegerInput u
      "Connector of Integer input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.IntegerOutput y[nout]
      "Connector of Integer output signals"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation

    y = fill(u, nout);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-100,0},{-6,0}}, color={255,127,0}),
          Line(points={{100,0},{10,0}}, color={255,127,0}),
          Line(points={{0,0},{100,10}}, color={255,127,0}),
          Line(points={{0,0},{100,-10}}, color={255,127,0}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={255,127,0},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
This block replicates the Integer input signal to an array of <code>nout</code> identical Integer output signals.
</p>
</html>"));
  end IntegerReplicator;

  block BooleanReplicator "Boolean signal replicator"
    extends Modelica.Blocks.Icons.BooleanBlock;
    parameter Integer nout=1 "Number of outputs";
    Modelica.Blocks.Interfaces.BooleanInput u
      "Connector of Boolean input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.BooleanOutput y[nout]
      "Connector of Boolean output signals"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation

    y = fill(u, nout);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-100,0},{-6,0}}, color={255,0,255}),
          Line(points={{100,0},{10,0}}, color={255,0,255}),
          Line(points={{0,0},{100,10}}, color={255,0,255}),
          Line(points={{0,0},{100,-10}}, color={255,0,255}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={255,0,255},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
This block replicates the Boolean input signal to an array of <code>nout</code> identical Boolean output signals.
</p>
</html>"));
  end BooleanReplicator;

block ExtractSignal "Extract signals from an input signal vector"
  extends Modelica.Blocks.Interfaces.MIMO;
  parameter Integer extract[nout]=1:nout "Extracting vector";

equation
  for i in 1:nout loop
    y[i] = u[extract[i]];

  end for;
  annotation (
    Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-90,51},{-50,-49}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Rectangle(
            extent={{50,50},{90,-50}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Polygon(
            points={{-94.4104,1.90792},{-94.4104,-2.09208},{-90.4104,-0.0920762},
                {-94.4104,1.90792}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-72,2},{-60.1395,12.907},{-49.1395,12.907}}, color={0,0,127}),
          Line(points={{-73,4},{-59,40},{-49,40}}, color={0,0,127}),
          Line(points={{-113,0},{-76.0373,-0.0180176}}, color={0,0,127}),
          Ellipse(
            extent={{-81.0437,4.59255},{-71.0437,-4.90745}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-73,-5},{-60,-40},{-49,-40}}, color={0,0,127}),
          Line(points={{-72,-2},{-60.0698,-12.907},{-49.0698,-12.907}}, color={
                0,0,127}),
          Polygon(
            points={{-48.8808,-11},{-48.8808,-15},{-44.8808,-13},{-48.8808,-11}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-46,13},{-35,13},{35,-30},{45,-30}}, color={0,0,127}),
          Line(points={{-45,40},{-35,40},{35,0},{44,0}}, color={0,0,127}),
          Line(points={{-45,-40},{-34,-40},{35,30},{44,30}}, color={0,0,127}),
          Polygon(
            points={{-49,42},{-49,38},{-45,40},{-49,42}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Polygon(
            points={{-48.8728,-38.0295},{-48.8728,-42.0295},{-44.8728,-40.0295},
                {-48.8728,-38.0295}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Polygon(
            points={{-48.9983,14.8801},{-48.9983,10.8801},{-44.9983,12.8801},{-48.9983,
                14.8801}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Ellipse(
            extent={{69.3052,4.12743},{79.3052,-5.37257}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{80,0},{100,0}}, color={0,0,127}),
          Polygon(
            points={{43.1618,32.3085},{43.1618,28.3085},{47.1618,30.3085},{
                43.1618,32.3085}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Polygon(
            points={{43.2575,1.80443},{43.2575,-2.19557},{47.2575,-0.195573},{
                43.2575,1.80443}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Polygon(
            points={{43.8805,-28.1745},{43.8805,-32.1745},{47.8805,-30.1745},{
                43.8805,-28.1745}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{48,0},{70,0}}, color={0,0,127}),
          Line(points={{47,30},{60,30},{73,3}}, color={0,0,127}),
          Line(points={{49,-30},{60,-30},{74,-4}}, color={0,0,127}),
          Text(
            extent={{-150,-150},{150,-110}},
            textString="extract=%extract")}),
    Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-90,50},{-50,-50}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{50,50},{90,-50}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-94.4104,1.90792},{-94.4104,-2.09208},{-90.4104,-0.0920762},
                {-94.4104,1.90792}},
            lineColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-72,2},{-60.1395,12.907},{-49.1395,12.907}}, color={0,0,255}),
          Line(points={{-73,4},{-59,40},{-49,40}}, color={0,0,255}),
          Line(points={{-112,0},{-75.0373,-0.0180176}}, color={0,0,255}),
          Ellipse(
            extent={{-80.0437,4.59255},{-70.0437,-4.90745}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-73,-5},{-60,-40},{-49,-40}}, color={0,0,255}),
          Line(points={{-72,-2},{-60.0698,-12.907},{-49.0698,-12.907}}, color={
                0,0,255}),
          Polygon(
            points={{-48.8808,-11},{-48.8808,-15},{-44.8808,-13},{-48.8808,-11}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-46,13},{-35,13},{35,-30},{45,-30}}, color={0,0,255}),
          Line(points={{-45,40},{-35,40},{35,0},{44,0}}, color={0,0,255}),
          Line(points={{-45,-40},{-34,-40},{35,30},{44,30}}, color={0,0,255}),
          Polygon(
            points={{-49,42},{-49,38},{-45,40},{-49,42}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-48.8728,-38.0295},{-48.8728,-42.0295},{-44.8728,-40.0295},
                {-48.8728,-38.0295}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-48.9983,14.8801},{-48.9983,10.8801},{-44.9983,12.8801},{-48.9983,
                14.8801}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{70.3052,4.12743},{80.3052,-5.37257}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Line(points={{80,0},{105,0}}, color={0,0,255}),
          Polygon(
            points={{44.1618,32.3085},{44.1618,28.3085},{48.1618,30.3085},{
                44.1618,32.3085}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{44.2575,1.80443},{44.2575,-2.19557},{48.2575,-0.195573},{
                44.2575,1.80443}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{44.8805,-28.1745},{44.8805,-32.1745},{48.8805,-30.1745},{
                44.8805,-28.1745}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Line(points={{48,0},{70,0}}, color={0,0,255}),
          Line(points={{47,30},{60,30},{73,3}}, color={0,0,255}),
          Line(points={{49,-30},{60,-30},{74,-4}}, color={0,0,255}),
          Rectangle(extent={{-100,80},{100,-81}}, lineColor={0,0,255})}),
    Documentation(info="<html>
<p>Extract signals from the input connector and transfer them
to the output connector.</p>
<p>The extracting scheme is given by the integer vector 'extract'.
This vector specifies, which input signals are taken and in which
order they are transferred to the output vector. Note, that the
dimension of 'extract' has to match the number of outputs.
Additionally, the dimensions of the input connector signals and
the output connector signals have to be explicitly defined via the
parameters 'nin' and 'nout'.</p>
<p>Example:</p>
<pre>     nin = 7 \"Number of inputs\";
     nout = 4 \"Number of outputs\";
     extract[nout] = {6,3,3,2} \"Extracting vector\";
</pre>
<p>extracts four output signals (nout=4) from the seven elements of the
input vector (nin=7):</p>
<pre>   output no. 1 is set equal to input no. 6
   output no. 2 is set equal to input no. 3
   output no. 3 is set equal to input no. 3
   output no. 4 is set equal to input no. 2
</pre>
</html>"));
end ExtractSignal;

block Extractor
    "Extract scalar signal out of signal vector dependent on IntegerRealInput index"

  extends Modelica.Blocks.Interfaces.MISO;

  parameter Boolean allowOutOfRange=false "Index may be out of range";
  parameter Real outOfRangeValue=1e10 "Output signal if index is out of range";

  Modelica.Blocks.Interfaces.IntegerInput index annotation (Placement(
          transformation(
          origin={0,-120},
          extent={{-20,-20},{20,20}},
          rotation=90)));
  protected
  Real k[nin];
equation

  when {initial(),change(index)} then

    for i in 1:nin loop
      k[i] = if index == i then 1 else 0;

    end for;

  end when;

  y = if not allowOutOfRange or index > 0 and index <= nin then
              k*u else outOfRangeValue;
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-80,50},{-40,-50}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-84.4104,1.9079},{-84.4104,-2.09208},{-80.4104,-0.09208},{
                -84.4104,1.9079}},
            lineColor={0,0,127},
            fillPattern=FillPattern.Solid),
          Line(points={{-62,2},{-50.1395,12.907},{-39.1395,12.907}}, color={0,0,127}),
          Line(points={{-63,4},{-49,40},{-39,40}}, color={0,0,127}),
          Line(points={{-102,0},{-65.0373,-0.01802}}, color={0,0,127}),
          Ellipse(
            extent={{-70.0437,4.5925},{-60.0437,-4.90745}},
            lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid),
          Line(points={{-63,-5},{-50,-40},{-39,-40}}, color={0,0,127}),
          Line(points={{-62,-2},{-50.0698,-12.907},{-39.0698,-12.907}}, color={
                0,0,127}),
          Polygon(
            points={{-38.8808,-11},{-38.8808,-15},{-34.8808,-13},{-38.8808,-11}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-39,42},{-39,38},{-35,40},{-39,42}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-38.8728,-38.0295},{-38.8728,-42.0295},{-34.8728,-40.0295},
                {-38.8728,-38.0295}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-38.9983,14.8801},{-38.9983,10.8801},{-34.9983,12.8801},{-38.9983,
                14.8801}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-30,50},{30,-50}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{100,0},{0,0}}, color={0,0,127}),
          Line(points={{0,2},{0,-104}}, color={255,128,0}),
          Line(points={{-35,40},{-20,40}}, color={0,0,127}),
          Line(points={{-35,13},{-20,13}}, color={0,0,127}),
          Line(points={{-35,-13},{-20,-13}}, color={0,0,127}),
          Line(points={{-35,-40},{-20,-40}}, color={0,0,127}),
          Polygon(points={{0,0},{-20,13},{-20,13},{0,0},{0,0}}, lineColor={0,0,
                127}),
          Ellipse(
            extent={{-6,6},{6,-6}},
            lineColor={255,128,0},
            fillColor={255,128,0},
            fillPattern=FillPattern.Solid)}),
                            Documentation(info="<html>
<p>This block extracts a scalar output signal out the
vector of input signals dependent on the Integer
value of the additional u index:</p>
<pre>    y = u [ index ] ;
</pre>
<p>where index is an additional Integer input signal.</p>
</html>"));
end Extractor;

  block Multiplex "Multiplexer block for arbitrary number of input connectors"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n(min=0)=0 "Dimension of input signal connector" annotation(Dialog(connectorSizing=true), HideResult=true);
    Modelica.Blocks.Interfaces.RealVectorInput u[n]
      "Connector of Real input signals" annotation(Placement(transformation(extent={{-120,70},{-80,-70}})));
    Modelica.Blocks.Interfaces.RealOutput y[n+0]
      "Connector of Real output signals" annotation(Placement(transformation(extent={{100,-10},{120,10}})));

    equation
      y = u;
    annotation(
      defaultComponentName="mux",
      Documentation(info="<html>
<p>
The output connector is the <strong>concatenation</strong> of the input connectors.
</p>
</html>"),
      Icon(
        coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
        graphics={
          Line(points={{8,0},{102,0}}, color={0,0,127}),
          Line(points={{-100,70},{-60,70},{-4,4}}, color={0,0,127}),
          Line(points={{-100,0},{-12,0}}, color={0,0,127}),
          Line(points={{-100,-70},{-60,-70},{-4,-4}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-100,0},{-6,0}}, color={0,0,127}),
          Text(
            extent={{-140,-90},{150,-50}},
            textString="n=%n")}),
      Diagram(
        coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
        graphics={
          Line(points={{8,0},{102,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-100,0},{-6,0}},color={0,0,127})}));
  end Multiplex;

  block Multiplex2 "Multiplexer block for two input connectors"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1=1 "Dimension of input signal connector 1";
    parameter Integer n2=1 "Dimension of input signal connector 2";
    Modelica.Blocks.Interfaces.RealInput u1[n1]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-140,40},{-100,80}})));
    Modelica.Blocks.Interfaces.RealInput u2[n2]
      "Connector of Real input signals 2" annotation (Placement(transformation(
            extent={{-140,-80},{-100,-40}})));
    Modelica.Blocks.Interfaces.RealOutput y[n1 + n2]
      "Connector of Real output signals" annotation (Placement(transformation(
            extent={{100,-10},{120,10}})));

  equation
    [y] = [u1; u2];
    annotation (
      Documentation(info="<html>
<p>
The output connector is the <strong>concatenation</strong> of the two input connectors.
Note, that the dimensions of the input connector signals have to be
explicitly defined via parameters n1 and n2.
</p>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{8,0},{102,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-100,60},{-60,60},{0,0}}, color={0,0,127}),
          Line(points={{-100,-60},{-60,-60},{0,0}}, color={0,0,127})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-100,60},{-60,60},{0,0}}, color={0,0,127}),
          Line(points={{-100,-60},{-60,-60},{0,0}}, color={0,0,127}),
          Line(points={{8,0},{102,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127})}));
  end Multiplex2;

  block Multiplex3 "Multiplexer block for three input connectors"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1=1 "Dimension of input signal connector 1";
    parameter Integer n2=1 "Dimension of input signal connector 2";
    parameter Integer n3=1 "Dimension of input signal connector 3";
    Modelica.Blocks.Interfaces.RealInput u1[n1]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-140,50},{-100,90}})));
    Modelica.Blocks.Interfaces.RealInput u2[n2]
      "Connector of Real input signals 2" annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealInput u3[n3]
      "Connector of Real input signals 3" annotation (Placement(transformation(
            extent={{-140,-90},{-100,-50}})));
    Modelica.Blocks.Interfaces.RealOutput y[n1 + n2 + n3]
      "Connector of Real output signals" annotation (Placement(transformation(
            extent={{100,-10},{120,10}})));

  equation
    [y] = [u1; u2; u3];
    annotation (
      Documentation(info="<html>
<p>
The output connector is the <strong>concatenation</strong> of the three input connectors.
Note, that the dimensions of the input connector signals have to be
explicitly defined via parameters n1, n2 and n3.</p>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{8,0},{102,0}}, color={0,0,127}),
          Line(points={{-100,70},{-60,70},{0,0}}, color={0,0,127}),
          Line(points={{-100,0},{-12,0}}, color={0,0,127}),
          Line(points={{-100,-70},{-60,-70},{0,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-100,70},{-60,70},{0,0}}, color={0,0,127}),
          Line(points={{-100,-70},{-60,-70},{0,0}}, color={0,0,127}),
          Line(points={{8,0},{102,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-100,0},{-12,0}}, color={0,0,127})}));
  end Multiplex3;

  block Multiplex4 "Multiplexer block for four input connectors"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1=1 "Dimension of input signal connector 1";
    parameter Integer n2=1 "Dimension of input signal connector 2";
    parameter Integer n3=1 "Dimension of input signal connector 3";
    parameter Integer n4=1 "Dimension of input signal connector 4";
    Modelica.Blocks.Interfaces.RealInput u1[n1]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-140,70},{-100,110}})));
    Modelica.Blocks.Interfaces.RealInput u2[n2]
      "Connector of Real input signals 2" annotation (Placement(transformation(
            extent={{-140,10},{-100,50}})));
    Modelica.Blocks.Interfaces.RealInput u3[n3]
      "Connector of Real input signals 3" annotation (Placement(transformation(
            extent={{-140,-50},{-100,-10}})));
    Modelica.Blocks.Interfaces.RealInput u4[n4]
      "Connector of Real input signals 4" annotation (Placement(transformation(
            extent={{-140,-110},{-100,-70}})));
    Modelica.Blocks.Interfaces.RealOutput y[n1 + n2 + n3 + n4]
      "Connector of Real output signals" annotation (Placement(transformation(
            extent={{100,-10},{120,10}})));

  equation
    [y] = [u1; u2; u3; u4];
    annotation (
      Documentation(info="<html>
<p>
The output connector is the <strong>concatenation</strong> of the four input connectors.
Note, that the dimensions of the input connector signals have to be
explicitly defined via parameters n1, n2, n3 and n4.
</p>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{8,0},{102,0}}, color={0,0,127}),
          Line(points={{-100,90},{-60,90},{-3,4}}, color={0,0,127}),
          Line(points={{-100,30},{-60,30},{0,0}}, color={0,0,127}),
          Line(points={{-100,-30},{-60,-30},{0,0}}, color={0,0,127}),
          Line(points={{-100,-90},{-60,-90},{-5,-6}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-100,90},{-60,90},{0,0}}, color={0,0,127}),
          Line(points={{-100,-90},{-60,-90},{0,0}}, color={0,0,127}),
          Line(points={{8,0},{102,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-100,30},{-60,30},{0,0}}, color={0,0,127}),
          Line(points={{-100,-30},{-59,-30},{0,0}}, color={0,0,127})}));
  end Multiplex4;

  block Multiplex5 "Multiplexer block for five input connectors"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1=1 "Dimension of input signal connector 1";
    parameter Integer n2=1 "Dimension of input signal connector 2";
    parameter Integer n3=1 "Dimension of input signal connector 3";
    parameter Integer n4=1 "Dimension of input signal connector 4";
    parameter Integer n5=1 "Dimension of input signal connector 5";
    Modelica.Blocks.Interfaces.RealInput u1[n1]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-140,80},{-100,120}})));
    Modelica.Blocks.Interfaces.RealInput u2[n2]
      "Connector of Real input signals 2" annotation (Placement(transformation(
            extent={{-140,30},{-100,70}})));
    Modelica.Blocks.Interfaces.RealInput u3[n3]
      "Connector of Real input signals 3" annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealInput u4[n4]
      "Connector of Real input signals 4" annotation (Placement(transformation(
            extent={{-140,-70},{-100,-30}})));
    Modelica.Blocks.Interfaces.RealInput u5[n5]
      "Connector of Real input signals 5" annotation (Placement(transformation(
            extent={{-140,-120},{-100,-80}})));
    Modelica.Blocks.Interfaces.RealOutput y[n1 + n2 + n3 + n4 + n5]
      "Connector of Real output signals" annotation (Placement(transformation(
            extent={{100,-10},{120,10}})));

  equation
    [y] = [u1; u2; u3; u4; u5];
    annotation (
      Documentation(info="<html>
<p>
The output connector is the <strong>concatenation</strong> of the five input connectors.
Note, that the dimensions of the input connector signals have to be
explicitly defined via parameters n1, n2, n3, n4 and n5.
</p>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{8,0},{102,0}}, color={0,0,127}),
          Line(points={{-100,100},{-60,100},{0,0}}, color={0,0,127}),
          Line(points={{-100,50},{-60,50},{-4,0}}, color={0,0,127}),
          Line(points={{-100,0},{-7,0}}, color={0,0,127}),
          Line(points={{-100,-50},{-60,-50},{-4,0}}, color={0,0,127}),
          Line(points={{-100,-100},{-60,-100},{0,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-100,100},{-60,100},{0,0}}, color={0,0,127}),
          Line(points={{-100,-100},{-60,-100},{0,0}}, color={0,0,127}),
          Line(points={{8,0},{102,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-100,50},{-60,50},{-4,0}}, color={0,0,127}),
          Line(points={{-100,0},{-7,0}}, color={0,0,127}),
          Line(points={{-100,-50},{-60,-50},{-4,0}}, color={0,0,127})}));
  end Multiplex5;

  block Multiplex6 "Multiplexer block for six input connectors"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1=1 "Dimension of input signal connector 1";
    parameter Integer n2=1 "Dimension of input signal connector 2";
    parameter Integer n3=1 "Dimension of input signal connector 3";
    parameter Integer n4=1 "Dimension of input signal connector 4";
    parameter Integer n5=1 "Dimension of input signal connector 5";
    parameter Integer n6=1 "Dimension of input signal connector 6";
    Modelica.Blocks.Interfaces.RealInput u1[n1]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-124,73},{-100,97}})));
    Modelica.Blocks.Interfaces.RealInput u2[n2]
      "Connector of Real input signals 2" annotation (Placement(transformation(
            extent={{-124,39},{-100,63}})));
    Modelica.Blocks.Interfaces.RealInput u3[n3]
      "Connector of Real input signals 3" annotation (Placement(transformation(
            extent={{-124,5},{-100,29}})));

    Modelica.Blocks.Interfaces.RealInput u4[n4]
      "Connector of Real input signals 4" annotation (Placement(transformation(
            extent={{-124,-29},{-100,-5}})));
    Modelica.Blocks.Interfaces.RealInput u5[n5]
      "Connector of Real input signals 5" annotation (Placement(transformation(
            extent={{-124,-63},{-100,-39}})));
    Modelica.Blocks.Interfaces.RealInput u6[n6]
      "Connector of Real input signals 6" annotation (Placement(transformation(
            extent={{-124,-97},{-100,-73}})));
    Modelica.Blocks.Interfaces.RealOutput y[n1 + n2 + n3 + n4 + n5 + n6]
      "Connector of Real output signals" annotation (Placement(transformation(
            extent={{100,-10},{120,10}})));

  equation
    [y] = [u1; u2; u3; u4; u5; u6];
    annotation (
      Documentation(info="<html>
<p>
The output connector is the <strong>concatenation</strong> of the six input connectors.
Note, that the dimensions of the input connector signals have to be
explicitly defined via parameters n1, n2, n3, n4, n5 and n6.
</p>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{8,0},{102,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-100,85},{-60,85},{-3,10}}, color={0,0,127}),
          Line(points={{-100,51},{-60,51},{-7,6}}, color={0,0,127}),
          Line(points={{-100,-17},{-60,-17},{-10,-2}}, color={0,0,127}),
          Line(points={{-100,17},{-60,17},{-10,2}}, color={0,0,127}),
          Line(points={{-100,-51},{-60,-51},{-7,-6}}, color={0,0,127}),
          Line(points={{-100,-85},{-60,-85},{-3,-10}}, color={0,0,127})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-100,85},{-60,85},{-3,10}}, color={0,0,127}),
          Line(points={{-100,-85},{-60,-85},{-3,-10}}, color={0,0,127}),
          Line(points={{8,0},{102,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-100,51},{-60,51},{-7,6}}, color={0,0,127}),
          Line(points={{-100,-51},{-60,-51},{-7,-6}}, color={0,0,127}),
          Line(points={{-100,17},{-60,17},{-10,2}}, color={0,0,127}),
          Line(points={{-100,-17},{-60,-17},{-10,-2}}, color={0,0,127})}));
  end Multiplex6;

  block DeMultiplex "DeMultiplexer block for arbitrary number of output connectors"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n(min=0)=0 "Dimension of output signal connector" annotation(Dialog(connectorSizing=true), HideResult=true);
    Modelica.Blocks.Interfaces.RealInput u[n+0]
      "Connector of Real input signals" annotation(Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealVectorOutput y[n]
      "Connector of Real output signals"annotation(Placement(transformation(extent={{80,70},{120,-70}})));

    equation
      y = u;
    annotation(
      defaultComponentName="demux",
      Documentation(info="<html>
<p>
The input connector is <strong>split</strong> up into output connectors.
</p>
</html>"),
      Icon(
        coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
        graphics={
          Line(points={{8,0},{102,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-100,0},{-6,0}}, color={0,0,127}),
          Line(points={{100,70},{60,70},{4,4}}, color={0,0,127}),
          Line(points={{0,0},{100,0}}, color={0,0,127}),
          Line(points={{100,-70},{60,-70},{4,-4}}, color={0,0,127}),
          Text(
            extent={{-140,-90},{150,-50}},
            textString="n=%n")}),
      Diagram(
        coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
        graphics={
          Line(points={{8,0},{102,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-100,0},{-6,0}},color={0,0,127})}));
  end DeMultiplex;

  block DeMultiplex2 "DeMultiplexer block for two output connectors"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1=1 "Dimension of output signal connector 1";
    parameter Integer n2=1 "Dimension of output signal connector 2";
    Modelica.Blocks.Interfaces.RealInput u[n1 + n2]
      "Connector of Real input signals" annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y1[n1]
      "Connector of Real output signals 1" annotation (Placement(transformation(
            extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.RealOutput y2[n2]
      "Connector of Real output signals 2" annotation (Placement(transformation(
            extent={{100,-70},{120,-50}})));

  equation
    [u] = [y1; y2];
    annotation (
      Documentation(info="<html>
<p>
The input connector is <strong>split</strong> up into two output connectors.
Note, that the dimensions of the output connector signals have to be
explicitly defined via parameters n1 and n2.
</p>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
        graphics={
          Line(points={{100,60},{60,60},{0,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{100,-60},{60,-60},{0,0}}, color={0,0,127}),
          Line(points={{-100,0},{-6,0}}, color={0,0,127})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{100,60},{60,60},{0,0}}, color={0,0,127}),
          Line(points={{100,-60},{60,-60},{0,0}}, color={0,0,127}),
          Line(points={{-100,0},{-6,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127})}));
  end DeMultiplex2;

  block DeMultiplex3 "DeMultiplexer block for three output connectors"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1=1 "Dimension of output signal connector 1";
    parameter Integer n2=1 "Dimension of output signal connector 2";
    parameter Integer n3=1 "Dimension of output signal connector 3";
    Modelica.Blocks.Interfaces.RealInput u[n1 + n2 + n3]
      "Connector of Real input signals" annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y1[n1]
      "Connector of Real output signals 1" annotation (Placement(transformation(
            extent={{100,60},{120,80}})));
    Modelica.Blocks.Interfaces.RealOutput y2[n2]
      "Connector of Real output signals 2" annotation (Placement(transformation(
            extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealOutput y3[n3]
      "Connector of Real output signals 3" annotation (Placement(transformation(
            extent={{100,-80},{120,-60}})));

  equation
    [u] = [y1; y2; y3];
    annotation (
      Documentation(info="<html>
<p>
The input connector is <strong>split</strong> into three output connectors.
Note, that the dimensions of the output connector signals have to be
explicitly defined via parameters n1, n2 and n3.
</p>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-100,0},{-6,0}}, color={0,0,127}),
          Line(points={{100,70},{60,70},{0,0}}, color={0,0,127}),
          Line(points={{0,0},{100,0}}, color={0,0,127}),
          Line(points={{100,-70},{60,-70},{0,0}}, color={0,0,127})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{100,70},{60,70},{0,0}}, color={0,0,127}),
          Line(points={{100,-70},{60,-70},{0,0}}, color={0,0,127}),
          Line(points={{-100,0},{-6,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{0,0},{100,0}}, color={0,0,127})}));
  end DeMultiplex3;

  block DeMultiplex4 "DeMultiplexer block for four output connectors"

    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1=1 "Dimension of output signal connector 1";
    parameter Integer n2=1 "Dimension of output signal connector 2";
    parameter Integer n3=1 "Dimension of output signal connector 3";
    parameter Integer n4=1 "Dimension of output signal connector 4";
    Modelica.Blocks.Interfaces.RealInput u[n1 + n2 + n3 + n4]
      "Connector of Real input signals" annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y1[n1]
      "Connector of Real output signals 1" annotation (Placement(transformation(
            extent={{100,80},{120,100}})));
    Modelica.Blocks.Interfaces.RealOutput y2[n2]
      "Connector of Real output signals 2" annotation (Placement(transformation(
            extent={{100,20},{120,40}})));
    Modelica.Blocks.Interfaces.RealOutput y3[n3]
      "Connector of Real output signals 3" annotation (Placement(transformation(
            extent={{100,-40},{120,-20}})));
    Modelica.Blocks.Interfaces.RealOutput y4[n4]
      "Connector of Real output signals 4" annotation (Placement(transformation(
            extent={{100,-100},{120,-80}})));

  equation
    [u] = [y1; y2; y3; y4];
    annotation (
      Documentation(info="<html>
<p>
The input connector is <strong>split</strong> into four output connectors.
Note, that the dimensions of the output connector signals have to be
explicitly defined via parameters n1, n2, n3 and n4.</p>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-100,0},{-6,0}}, color={0,0,127}),
          Line(points={{100,90},{60,90},{0,0}}, color={0,0,127}),
          Line(points={{100,30},{60,30},{0,0}}, color={0,0,127}),
          Line(points={{100,-30},{60,-30},{0,0}}, color={0,0,127}),
          Line(points={{100,-90},{60,-90},{0,0}}, color={0,0,127})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{100,90},{60,90},{0,0}}, color={0,0,127}),
          Line(points={{100,-90},{60,-90},{0,0}}, color={0,0,127}),
          Line(points={{-100,0},{-6,0}}, color={0,0,127}),
          Line(points={{100,30},{60,30},{0,0}}, color={0,0,127}),
          Line(points={{100,-30},{60,-30},{0,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127})}));
  end DeMultiplex4;

  block DeMultiplex5 "DeMultiplexer block for five output connectors"

    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1=1 "Dimension of output signal connector 1";
    parameter Integer n2=1 "Dimension of output signal connector 2";
    parameter Integer n3=1 "Dimension of output signal connector 3";
    parameter Integer n4=1 "Dimension of output signal connector 4";
    parameter Integer n5=1 "Dimension of output signal connector 5";
    Modelica.Blocks.Interfaces.RealInput u[n1 + n2 + n3 + n4 + n5]
      "Connector of Real input signals" annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y1[n1]
      "Connector of Real output signals 1" annotation (Placement(transformation(
            extent={{100,70},{120,90}})));
    Modelica.Blocks.Interfaces.RealOutput y2[n2]
      "Connector of Real output signals 2" annotation (Placement(transformation(
            extent={{100,30},{120,50}})));
    Modelica.Blocks.Interfaces.RealOutput y3[n3]
      "Connector of Real output signals 3" annotation (Placement(transformation(
            extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealOutput y4[n4]
      "Connector of Real output signals 4" annotation (Placement(transformation(
            extent={{100,-50},{120,-30}})));
    Modelica.Blocks.Interfaces.RealOutput y5[n5]
      "Connector of Real output signals 5" annotation (Placement(transformation(
            extent={{100,-90},{120,-70}})));

  equation
    [u] = [y1; y2; y3; y4; y5];
    annotation (
      Documentation(info="<html>
<p>
The input connector is <strong>split</strong> into five output connectors.
Note, that the dimensions of the output connector signals have to be
explicitly defined via parameters n1, n2, n3, n4 and n5.</p>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-100,0},{-6,0}}, color={0,0,127}),
          Line(points={{100,80},{60,80},{0,0}}, color={0,0,127}),
          Line(points={{100,40},{60,40},{8,4}}, color={0,0,127}),
          Line(points={{100,0},{10,0}}, color={0,0,127}),
          Line(points={{100,-40},{60,-40},{8,-4}}, color={0,0,127}),
          Line(points={{100,-80},{60,-80},{0,0}}, color={0,0,127})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{100,80},{60,80},{0,0}}, color={0,0,127}),
          Line(points={{100,-80},{60,-80},{0,0}},  color={0,0,127}),
          Line(points={{-100,0},{-6,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{100,40},{60,40},{8,4}}, color={0,0,127}),
          Line(points={{100,0},{10,0}}, color={0,0,127}),
          Line(points={{100,-40},{60,-40},{8,-4}}, color={0,0,127})}));
  end DeMultiplex5;

  block DeMultiplex6 "DeMultiplexer block for six output connectors"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n1=1 "Dimension of output signal connector 1";
    parameter Integer n2=1 "Dimension of output signal connector 2";
    parameter Integer n3=1 "Dimension of output signal connector 3";
    parameter Integer n4=1 "Dimension of output signal connector 4";
    parameter Integer n5=1 "Dimension of output signal connector 5";
    parameter Integer n6=1 "Dimension of output signal connector 6";
    Modelica.Blocks.Interfaces.RealInput u[n1 + n2 + n3 + n4 + n5 + n6]
      "Connector of Real input signals" annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y1[n1]
      "Connector of Real output signals 1" annotation (Placement(transformation(
            extent={{100,80},{120,100}})));
    Modelica.Blocks.Interfaces.RealOutput y2[n2]
      "Connector of Real output signals 2" annotation (Placement(transformation(
            extent={{100,44},{120,64}})));
    Modelica.Blocks.Interfaces.RealOutput y3[n3]
      "Connector of Real output signals 3" annotation (Placement(transformation(
            extent={{100,8},{120,28}})));
    Modelica.Blocks.Interfaces.RealOutput y4[n4]
      "Connector of Real output signals 4" annotation (Placement(transformation(
            extent={{100,-28},{120,-8}})));
    Modelica.Blocks.Interfaces.RealOutput y5[n5]
      "Connector of Real output signals 5" annotation (Placement(transformation(
            extent={{100,-64},{120,-44}})));
    Modelica.Blocks.Interfaces.RealOutput y6[n6]
      "Connector of Real output signals 6" annotation (Placement(transformation(
            extent={{100,-100},{120,-80}})));

  equation
    [u] = [y1; y2; y3; y4; y5; y6];
    annotation (
      Documentation(info="<html>
<p>
The input connector is <strong>split</strong> into six output connectors.
Note, that the dimensions of the output connector signals have to be
explicitly defined via parameters n1, n2, n3, n4, n5 and n6.</p>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-100,0},{-6,0}}, color={0,0,127}),
          Line(points={{100,90},{60,90},{0,4}}, color={0,0,127}),
          Line(points={{100,54},{60,54},{8,6}}, color={0,0,127}),
          Line(points={{100,18},{60,18},{10,2}}, color={0,0,127}),
          Line(points={{100,-18},{60,-18},{10,-2}}, color={0,0,127}),
          Line(points={{100,-54},{60,-54},{8,-6}}, color={0,0,127}),
          Line(points={{100,-90},{60,-90},{0,-4}}, color={0,0,127})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{100,90},{60,90},{0,4}}, color={0,0,127}),
          Line(points={{100,-90},{60,-90},{0,-4}}, color={0,0,127}),
          Line(points={{-100,0},{-6,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{100,54},{60,54},{8,6}}, color={0,0,127}),
          Line(points={{100,-54},{60,-54},{8,-6}}, color={0,0,127}),
          Line(points={{100,18},{60,18},{10,2}}, color={0,0,127}),
          Line(points={{100,-18},{60,-18},{10,-2}}, color={0,0,127})}));
  end DeMultiplex6;

  model RealPassThrough "Pass a Real signal through without modification"
    extends Modelica.Blocks.Interfaces.SISO;
  equation
    y = u;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Line(points={{-100,0},{100,0}},
              color={0,0,127})}),
                      Documentation(info="<html>
<p>
Passes a Real signal through without modification.  Enables signals to be read out of one bus, have their name changed and be sent back to a bus.
</p>
</html>"));
  end RealPassThrough;

  model IntegerPassThrough "Pass a Integer signal through without modification"
    extends Modelica.Blocks.Icons.IntegerBlock;

    Modelica.Blocks.Interfaces.IntegerInput u "Input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.IntegerOutput y "Output signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    y = u;

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Line(points={{-100,0},{100,0}},
              color={255,128,0})}),
                      Documentation(info="<html>
<p>Passes a Integer signal through without modification.  Enables signals to be read out of one bus, have their name changed and be sent back to a bus.</p>
</html>"));
  end IntegerPassThrough;

  model BooleanPassThrough "Pass a Boolean signal through without modification"
    extends Modelica.Blocks.Interfaces.BooleanSISO;
  equation
    y = u;
    annotation (Documentation(info="<html>
<p>Passes a Boolean signal through without modification.  Enables signals to be read out of one bus, have their name changed and be sent back to a bus.</p>
</html>"),
      Icon(
        coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}}),
            graphics={
        Line(
          points={{-100.0,0.0},{100.0,0.0}},
          color={255,0,255})}));
  end BooleanPassThrough;
  annotation (Documentation(info="<html>
<p>
This package contains blocks to combine and extract signals.
</p>
</html>"), Icon(graphics={
        Line(points={{-90,0},{4,0}}, color={95,95,95}),
        Line(points={{88,65},{48,65},{-8,0}}, color={95,95,95}),
        Line(points={{-8,0},{93,0}}, color={95,95,95}),
        Line(points={{87,-65},{48,-65},{-8,0}}, color={95,95,95})}));
end Routing;
