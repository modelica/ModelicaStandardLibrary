within Modelica.Blocks.Math;
block MatrixGain
  "Output the product of a gain matrix with the input signal vector"

  parameter Real K[:, :]=[1, 0; 0, 1]
    "Gain matrix which is multiplied with the input";
  extends Interfaces.MIMO(final nin=size(K, 2), final nout=size(K, 1));
equation
  y = K*u;
  annotation (
    Documentation(info="<html>
<p>
This blocks computes output vector <strong>y</strong> as <em>product</em> of the
gain matrix <strong>K</strong> with the input signal vector <strong>u</strong>:
</p>
<blockquote><pre>
<strong>y</strong> = <strong>K</strong> * <strong>u</strong>;
</pre></blockquote>
<p>
Example:
</p>
<blockquote><pre>
parameter: <strong>K</strong> = [0.12 2; 3 1.5]

results in the following equations:

  | y[1] |     | 0.12  2.00 |   | u[1] |
  |      |  =  |            | * |      |
  | y[2] |     | 3.00  1.50 |   | u[2] |
</pre></blockquote>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-90,-60},{90,60}},
          textColor={160,160,164},
          textString="*K")}));
end MatrixGain;
