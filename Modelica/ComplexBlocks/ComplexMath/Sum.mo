within Modelica.ComplexBlocks.ComplexMath;
block Sum "Output the sum of the elements of the input vector"
  extends Interfaces.ComplexMISO;
  parameter Complex k[nin]=fill(Complex(1, 0), nin)
    "Optional: sum coefficients";
equation
  y = k*uInternal;
  annotation (
    defaultComponentName="sum1",
    Documentation(info="<html>
<p>
This blocks computes output <code>y</code> as
<em>sum</em> of the elements of the input signal vector
<code>u</code>:
</p>
<blockquote><pre>
y = u[1] + u[2] + ...;
</pre></blockquote>
<p>
Example:
</p>
<blockquote><pre>
  parameter:   nin = 3;

results in the following equations:

  y = u[1] + u[2] + u[3];
</pre></blockquote>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(
              points={{26,42},{-34,42},{6,2},{-34,-38},{26,-38}}, color={85,
              170,255})}));
end Sum;
