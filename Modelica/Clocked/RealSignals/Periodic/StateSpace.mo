within Modelica.Clocked.RealSignals.Periodic;
block StateSpace "Discrete-time State Space block"
  parameter Real A[:, size(A, 1)] "Matrix A of state space model";
  parameter Real B[size(A, 1), :] "Matrix B of state space model";
  parameter Real C[:, size(A, 1)] "Matrix C of state space model";
  parameter Real D[size(C, 1), size(B, 2)]=zeros(size(C, 1), size(B, 2))
    "Matrix D of state space model";
  extends Clocked.RealSignals.Interfaces.PartialClockedMIMO(final nin=size(
        B, 2), final nout=size(C, 1));
  output Real x[size(A, 1)](each start=0.0) "State vector";

equation
  when Clock() then
    x = A*previous(x) + B*u;
    y = C*previous(x) + D*u;
  end when;
  annotation (
    Documentation(info="<html>
<p>
This block defines the state space representation of a discrete-time block
with input vector u, output vector y and state vector x:
</p>
<blockquote><pre>
x = A * previous(x) + B * u
y = C * previous(x) + D * u
</pre></blockquote>
<p>
where previous(x) is the value of the clocked state x at
the previous clock tick.
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
  [x[1]]   [0.12  2.00] [previous(x[1])]   [2.0  7.0] [u[1]]
  [    ] = [          ]*[              ] + [        ]*[    ]
  [x[2]]   [3.00  1.50] [previous(x[2])]   [0.1  2.0] [u[2]]

                        [previous(x[1])]            [u[1]]
  y[1]   = [0.1  2.0] * [              ] + [0  0] * [    ]
                        [previous(x[2])]            [u[2]]
</pre></blockquote>
</html>", revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>August 13, 2012</em>
    by <a href=\"http://www.dlr.de/rm/\">Bernhard Thiele</a>:<br>
    Used the code from Blocks.Discrete.StateSpace and converted it into
    the Modelica 3.3 clocked equation style.</li>
</ul>
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
          textColor={0,0,127})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
        Text(
          extent={{-54,50},{52,-10}},
          textString="zx=Ax+Bu"),
        Text(
          extent={{-56,14},{54,-50}},
          textString="  y=Cx+Du"),
        Line(points={{-102,0},{-60,0}}, color={0,0,255}),
        Line(points={{60,0},{100,0}}, color={0,0,255})}));
end StateSpace;
