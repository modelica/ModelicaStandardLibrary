within Modelica.ComplexBlocks.ComplexMath;
block RealToComplex "Converts Cartesian representation to complex"
  extends Modelica.ComplexBlocks.Interfaces.ComplexSO;
  Blocks.Interfaces.RealInput re annotation (Placement(transformation(
          extent={{-140,40},{-100,80}}),iconTransformation(extent={{-140,40},{-100,80}})));
  Blocks.Interfaces.RealInput im annotation (Placement(transformation(
          extent={{-140,-80},{-100,-40}}),iconTransformation(extent={{-140,
            -80},{-100,-40}})));
equation
  y = Complex(re, im);
  annotation (Icon(graphics={Text(
              extent={{-100,80},{-20,40}},
              textColor={0,0,127},
              textString="re"),Text(
              extent={{-100,-40},{-20,-80}},
              textColor={0,0,127},
              textString="im"),Polygon(
              points={{20,0},{0,20},{0,10},{-30,10},{-30,-10},{0,-10},{0,-20},
            {20,0}},
              lineColor={0,128,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),Text(
              extent={{20,60},{100,-60}},
              textColor={85,170,255},
          textString="C")}),     Documentation(info="<html>
<p>Converts the Real inputs <em>re</em> (real part) and <em>im</em> (imaginary part) to the Complex output <em>y</em>.</p>
</html>"));
end RealToComplex;
