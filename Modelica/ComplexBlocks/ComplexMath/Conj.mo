within Modelica.ComplexBlocks.ComplexMath;
block Conj "Output is equal to the conjugate complex input signal"

  extends Modelica.ComplexBlocks.Interfaces.ComplexSISO(final
      useConjugateInput=true);

equation
  y = uInternal;
  annotation (
    Documentation(info="<html>
<p>
This block computes output <code>y</code> as
<em>conjugate complex</em> input <code>u</code>.
</p>
<blockquote><pre>
y = Modelica.ComplexMath.conj(u)
</pre></blockquote>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(
              points={{-40,0},{40,0}},
              color={85,170,255}),
                               Line(
              points={{-40,0},{40,0}},
              color={85,170,255},
              rotation=60),Line(
              points={{-40,0},{40,0}},
              color={85,170,255},
              rotation=120)}));
end Conj;
