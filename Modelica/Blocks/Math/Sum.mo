within Modelica.Blocks.Math;
block Sum "Output the sum of the elements of the input vector"
  extends Interfaces.MISO;
  parameter Real k[nin]=ones(nin) "Optional: sum coefficients";
equation
  y = k*u;
  annotation (
    defaultComponentName="sum1",
    Documentation(info="<html>
<p>
This blocks computes output <strong>y</strong> as
<em>sum</em> of the elements of the input signal vector
<strong>u</strong>:
</p>
<blockquote><pre>
<strong>y</strong> = <strong>u</strong>[1] + <strong>u</strong>[2] + ...;
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
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Line(
          points={{26,42},{-34,42},{6,2},{-34,-38},{26,-38}})}));
end Sum;
