within Modelica.Blocks.Continuous;
block TransferFunction "Linear transfer function"
  import Modelica.Blocks.Types.Init;
  extends Interfaces.SISO;

  parameter Real b[:]={1}
    "Numerator coefficients of transfer function (e.g., 2*s+3 is specified as {2,3})";
  parameter Real a[:]={1}
    "Denominator coefficients of transfer function (e.g., 5*s+6 is specified as {5,6})";
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                     annotation(Evaluate=true, Dialog(group=
          "Initialization"));
  parameter Real x_start[size(a, 1) - 1]=zeros(nx)
    "Initial or guess values of states"
    annotation (Dialog(group="Initialization"));
  parameter Real y_start=0
    "Initial value of output (derivatives of y are zero up to nx-1-th derivative)"
    annotation(Dialog(enable=initType == Init.InitialOutput, group=
          "Initialization"));
  output Real x[size(a, 1) - 1](start=x_start)
    "State of transfer function from controller canonical form";
protected
  parameter Integer na=size(a, 1) "Size of Denominator of transfer function.";
  parameter Integer nb=size(b, 1) "Size of Numerator of transfer function.";
  parameter Integer nx=size(a, 1) - 1;
  parameter Real bb[:] = vector([zeros(max(0,na-nb),1);b]);
  parameter Real d = bb[1]/a[1];
  parameter Real a_end = if a[end] > 100*Modelica.Constants.eps*sqrt(a*a) then a[end] else 1.0;
  Real x_scaled[size(x,1)] "Scaled vector x";

initial equation
  if initType == Init.SteadyState then
    der(x_scaled) = zeros(nx);
  elseif initType == Init.InitialState then
    x_scaled = x_start*a_end;
  elseif initType == Init.InitialOutput then
    y = y_start;
    der(x_scaled[2:nx]) = zeros(nx-1);
  end if;
equation
  assert(size(b,1) <= size(a,1), "Transfer function is not proper");
  if nx == 0 then
     y = d*u;
  else
     der(x_scaled[1])    = (-a[2:na]*x_scaled + a_end*u)/a[1];
     der(x_scaled[2:nx]) = x_scaled[1:nx-1];
     y = ((bb[2:na] - d*a[2:na])*x_scaled)/a_end + d*u;
     x = x_scaled/a_end;
  end if;
  annotation (
    Documentation(info="<html>
<p>
This block defines the transfer function between the input
u and the output y
as (nb = dimension of b, na = dimension of a):
</p>
<blockquote><pre>
        b[1]*s^[nb-1] + b[2]*s^[nb-2] + ... + b[nb]
y(s) = --------------------------------------------- * u(s)
        a[1]*s^[na-1] + a[2]*s^[na-2] + ... + a[na]
</pre></blockquote>
<p>
State variables <strong>x</strong> are defined according to <strong>controller canonical</strong>
form. Internally, vector <strong>x</strong> is scaled to improve the numerics (the states in versions before version 3.0 of the Modelica Standard Library have been not scaled). This scaling is
not visible from the outside of this block because the non-scaled vector <strong>x</strong>
is provided as output signal and the start value is with respect to the non-scaled
vector <strong>x</strong>.
Initial values of the states <strong>x</strong> can be set via parameter <strong>x_start</strong>.
</p>

<p>
Example:
</p>
<blockquote><pre>
TransferFunction g(b = {2,4}, a = {1,3});
</pre></blockquote>
<p>
results in the following transfer function:
</p>
<blockquote><pre>
     2*s + 4
y = --------- * u
      s + 3
</pre></blockquote>
</html>"),
    Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Line(points={{-80.0,0.0},{80.0,0.0}},
          color={0,0,127}),
      Text(textColor={0,0,127},
        extent={{-90.0,10.0},{90.0,90.0}},
        textString="b(s)"),
      Text(textColor={0,0,127},
        extent={{-90.0,-90.0},{90.0,-10.0}},
        textString="a(s)")}));
end TransferFunction;
