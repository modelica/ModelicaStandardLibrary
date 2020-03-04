within Modelica.Blocks.Discrete;
block StateSpace "Discrete State Space block"
  parameter Real A[:, size(A, 1)]=[1, 0; 0, 1]
    "Matrix A of state space model";
  parameter Real B[size(A, 1), :]=[1; 1] "Matrix B of state space model";
  parameter Real C[:, size(A, 1)]=[1, 1] "Matrix C of state space model";
  parameter Real D[size(C, 1), size(B, 2)]=zeros(size(C, 1), size(B, 2))
    "Matrix D of state space model";

  extends Interfaces.DiscreteMIMO(final nin=size(B, 2), final nout=size(C, 1));
  output Real x[size(A, 1)] "State vector";

equation
  when sampleTrigger then
    x = A*pre(x) + B*u;
    y = C*pre(x) + D*u;
  end when;
  annotation (
    Documentation(info="<html>
<p>
The <strong>discrete state space</strong> block defines the relation
between the input u and the output y in state space form:
</p>
<blockquote><pre>
x = A * pre(x) + B * u
y = C * pre(x) + D * u
</pre></blockquote>
<p>
where pre(x) is the value of the discrete state x at
the previous sample time instant.
The input is a vector of length nu, the output is a vector
of length ny and nx is the number of states. Accordingly
</p>
<blockquote><pre>
A has the dimension: A(nx,nx),
B has the dimension: B(nx,nu),
C has the dimension: C(ny,nx),
D has the dimension: D(ny,nu)
</pre></blockquote>
<p>
Example:
</p>
<blockquote><pre>
parameter: A = [0.12, 2;3, 1.5]
parameter: B = [2, 7;3, 1]
parameter: C = [0.1, 2]
parameter: D = zeros(ny,nu)

results in the following equations:
  [x[1]]   [0.12  2.00] [pre(x[1])]   [2.0  7.0] [u[1]]
  [    ] = [          ]*[         ] + [        ]*[    ]
  [x[2]]   [3.00  1.50] [pre(x[2])]   [0.1  2.0] [u[2]]
                             [pre(x[1])]            [u[1]]
       y[1]   = [0.1  2.0] * [         ] + [0  0] * [    ]
                             [pre(x[2])]            [u[2]]
</pre></blockquote>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-90,15},{-15,90}},
          textString="A",
          textColor={0,0,127}),
        Text(
          extent={{15,15},{90,90}},
          textString="B",
          textColor={0,0,127}),
        Text(
          extent={{-52,28},{54,-20}},
          textString="z",
          textColor={0,0,127}),
        Text(
          extent={{-90,-15},{-15,-90}},
          textString="C",
          textColor={0,0,127}),
        Text(
          extent={{15,-15},{90,-90}},
          textString="D",
          textColor={0,0,127})}));
end StateSpace;
