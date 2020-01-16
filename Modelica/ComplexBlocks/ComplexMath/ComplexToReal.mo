within Modelica.ComplexBlocks.ComplexMath;
block ComplexToReal "Converts complex to Cartesian representation"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  Blocks.Interfaces.RealOutput re annotation (Placement(transformation(
          extent={{100,40},{140,80}}), iconTransformation(extent={{100,40},
            {140,80}})));
  Blocks.Interfaces.RealOutput im annotation (Placement(transformation(
          extent={{100,-80},{140,-40}}), iconTransformation(extent={{100,-80},
            {140,-40}})));
  Interfaces.ComplexInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  parameter Boolean useConjugateInput=false
    "If true, input is processed conjugate complex";
equation
  re = u.re;
  im = (if useConjugateInput then -u.im else u.im);
  annotation (Icon(graphics={Text(
              extent={{20,80},{100,40}},
              textColor={0,0,127},
              textString="re"),Text(
              extent={{20,-40},{100,-80}},
              textColor={0,0,127},
              textString="im"),Polygon(
              points={{40,0},{20,20},{20,10},{-10,10},{-10,-10},{20,-10},{
            20,-20},{40,0}},
              lineColor={0,128,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),Text(
              extent={{-100,60},{-20,-60}},
              textColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid,
          textString="C")}),     Documentation(info="<html>
<p>Converts the Complex input <em>u</em> to the Real outputs <em>re</em> (real part) and <em>im</em> (imaginary part).</p>
</html>"));
end ComplexToReal;
