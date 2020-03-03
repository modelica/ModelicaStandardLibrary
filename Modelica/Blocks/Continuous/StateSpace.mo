within Modelica.Blocks.Continuous;
block StateSpace "Linear state space system"
  import Modelica.Blocks.Types.Init;
  parameter Real A[:, size(A, 1)]=[1, 0; 0, 1]
    "Matrix A of state space model (e.g., A=[1, 0; 0, 1])";
  parameter Real B[size(A, 1), :]=[1; 1]
    "Matrix B of state space model (e.g., B=[1; 1])";
  parameter Real C[:, size(A, 1)]=[1, 1]
    "Matrix C of state space model (e.g., C=[1, 1])";
  parameter Real D[size(C, 1), size(B, 2)]=zeros(size(C, 1), size(B, 2))
    "Matrix D of state space model";
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                                                                    annotation(Evaluate=true,
      Dialog(group="Initialization"));
  parameter Real x_start[nx]=zeros(nx) "Initial or guess values of states"
    annotation (Dialog(group="Initialization"));
  parameter Real y_start[ny]=zeros(ny)
    "Initial values of outputs (remaining states are in steady state if possible)"
    annotation(Dialog(enable=initType == Init.InitialOutput, group=
          "Initialization"));

  extends Interfaces.MIMO(final nin=size(B, 2), final nout=size(C, 1));
  output Real x[size(A, 1)](start=x_start) "State vector";

protected
  parameter Integer nx = size(A, 1) "number of states";
  parameter Integer ny = size(C, 1) "number of outputs";
initial equation
  if initType == Init.SteadyState then
    der(x) = zeros(nx);
  elseif initType == Init.InitialState then
    x = x_start;
  elseif initType == Init.InitialOutput then
    x = Modelica.Math.Matrices.equalityLeastSquares(A, -B*u, C, y_start - D*u);
  end if;
equation
  der(x) = A*x + B*u;
  y = C*x + D*u;
  annotation (
    Documentation(info="<html>
<p>
The State Space block defines the relation
between the input u and the output
y in state space form:
</p>
<blockquote><pre>
der(x) = A * x + B * u
    y  = C * x + D * u
</pre></blockquote>
<p>
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
  [der(x[1])]   [0.12  2.00] [x[1]]   [2.0  7.0] [u[1]]
  [         ] = [          ]*[    ] + [        ]*[    ]
  [der(x[2])]   [3.00  1.50] [x[2]]   [0.1  2.0] [u[2]]
                             [x[1]]            [u[1]]
       y[1]   = [0.1  2.0] * [    ] + [0  0] * [    ]
                             [x[2]]            [u[2]]
</pre></blockquote>
</html>"),
         Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100,-100},{100,100}}),
      graphics={
    Text(extent={{-90,10},{-10,90}},
      textString="A",
      textColor={0,0,127}),
    Text(extent={{10,10},{90,90}},
      textString="B",
      textColor={0,0,127}),
    Text(extent={{-90,-10},{-10,-90}},
      textString="C",
      textColor={0,0,127}),
    Text(extent={{10,-10},{90,-90}},
      textString="D",
      textColor={0,0,127}),
    Line(points={{0,-90},{0,90}},
      color={192,192,192}),
    Line(points={{-90,0},{90,0}},
      color={192,192,192})}));
end StateSpace;
