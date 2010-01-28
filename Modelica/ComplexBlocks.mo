within Modelica;
package ComplexBlocks
  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)"
extends Modelica.Icons.Library2;

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

      partial block ComplexSO "Single Output continuous control block"
        extends Blocks.Interfaces.BlockIcon;
        ComplexOutput y "Connector of Complex output signal" 
          annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));
        annotation (Documentation(info="<html>
<p>
Block has one continuous Complex output signal.
</p>
</html>"));
      end ComplexSO;

      partial block ComplexMO "Multiple Output continuous control block"
        extends Blocks.Interfaces.BlockIcon;
        parameter Integer nout(min=1) = 1 "Number of outputs";
        ComplexOutput y[nout] "Connector of Complex output signals" 
          annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));
        annotation (Documentation(info="<html>
<p>
Block has one continuous Complex output signal vector.
</p>
</html>"));
      end ComplexMO;

      partial block ComplexSISO
      "Single Input Single Output continuous control block"
        extends Blocks.Interfaces.BlockIcon;
        ComplexInput u "Connector of Complex input signal" 
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
        ComplexOutput y "Connector of Complex output signal" 
          annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));
        annotation (Documentation(info="<html>
<p>
Block has one continuous Complex input and one continuous Complex output signal.
</p>
</html>"));
      end ComplexSISO;

      partial block ComplexSI2SO
      "2 Single Input / 1 Single Output continuous control block"
        extends Blocks.Interfaces.BlockIcon;
        ComplexInput u1 "Connector of Complex input signal 1" 
          annotation (Placement(transformation(extent={{-140,40},{-100,80}}, rotation=0)));
        ComplexInput u2 "Connector of Complex input signal 2" 
          annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}, rotation=0)));
        ComplexOutput y "Connector of Complex output signal" 
          annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));
        annotation (Documentation(info="<html>
<p>
Block has two continuous Complex input signals u1 and u2 and one
continuous Complex output signal y.
</p>
</html>"));
      end ComplexSI2SO;

      partial block ComplexSIMO
      "Single Input Multiple Output continuous control block"
        extends Blocks.Interfaces.BlockIcon;
        parameter Integer nout=1 "Number of outputs";
        ComplexInput u "Connector of Complex input signal" 
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
        ComplexOutput y[nout] "Connector of Complex output signals" 
          annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));
        annotation (Documentation(info="<html>
<p>
 Block has one continuous Complex input signal and a
vector of continuous Complex output signals.
</p>
</html>"));
      end ComplexSIMO;

      partial block ComplexMISO
      "Multiple Input Single Output continuous control block"
        extends Blocks.Interfaces.BlockIcon;
        parameter Integer nin=1 "Number of inputs";
        ComplexInput u[nin] "Connector of Complex input signals" 
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
        ComplexOutput y "Connector of Complex output signal" 
          annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));
        annotation (Documentation(info="<html>
<p>
Block has a vector of continuous Complex input signals and
one continuous Complex output signal.
</p>
</html>"));
      end ComplexMISO;

      partial block ComplexMIMO
      "Multiple Input Multiple Output continuous control block"
        extends Blocks.Interfaces.BlockIcon;
        parameter Integer nin=1 "Number of inputs";
        parameter Integer nout=1 "Number of outputs";
        ComplexInput u[nin] "Connector of Complex input signals" 
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
        ComplexOutput y[nout] "Connector of Complex output signals" 
          annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));
        annotation (Documentation(info="<html>
<p>
Block has a continuous Complex input vector and a continuous Complex output signal vector.
The signal sizes of the input and output vector may be different.
</p>
</html>"));
      end ComplexMIMO;

      partial block ComplexMIMOs
      "Multiple Input Multiple Output continuous control block with same number of inputs and outputs"
        extends Blocks.Interfaces.BlockIcon;
        parameter Integer n=1 "Number of inputs (= number of outputs)";
        ComplexInput u[n] "Connector of Complex input signals" 
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
        ComplexOutput y[n] "Connector of Complex output signals" 
          annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));
        annotation (Documentation(info="<html>
<p>
Block has a continuous Complex input vector and a continuous Complex output signal vector
where the signal sizes of the input and output vector are identical.
</p>
</html>"));
      end ComplexMIMOs;

      partial block ComplexMI2MO
      "2 Multiple Input / Multiple Output continuous control block"
        extends Blocks.Interfaces.BlockIcon;
        parameter Integer n=1 "Dimension of input and output vectors.";
        ComplexInput u1[n] "Connector 1 of Complex input signals" 
          annotation (Placement(transformation(extent={{-140,40},{-100,80}}, rotation=0)));
        ComplexInput u2[n] "Connector 2 of Complex input signals" 
          annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}, rotation=0)));
        ComplexOutput y[n] "Connector of Complex output signals" 
          annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));
        annotation (Documentation(info="<html>
<p>
Block has two continuous Complex input vectors u1 and u2 and one
continuous Complex output vector y.
All vectors have the same number of elements.
</p>
</html>"));
      end ComplexMI2MO;
  end Interfaces;
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
end ComplexBlocks;
