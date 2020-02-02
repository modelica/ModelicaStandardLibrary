within Modelica.Magnetic.FundamentalWave.Interfaces;
model StateSelector
  "Transform instantaneous values to space phasors and select states"
  import Modelica.Constants.pi;
  parameter Integer m(min=3) = 3 "Number of phases" annotation(Evaluate=true);
  input Real xi[m](each stateSelect=StateSelect.avoid)
    "Instantaneous values" annotation (Dialog);
  input SI.Angle gamma "Angle of rotation" annotation (Dialog);
  parameter StateSelect x0StateSelect=StateSelect.prefer
    "Priority to use zero systems as states";
  parameter StateSelect xrStateSelect=StateSelect.prefer
    "Priority to use space phasors w.r.t. rotating frame as states";
  Real x0(stateSelect=x0StateSelect) = 1/sqrt(m)*sum(xi) "Zero system";
  Real x00(stateSelect=x0StateSelect) = 1/sqrt(m)*sum({xi[2*l - 1] - xi[2*l]
    for l in 1:integer(m/2)}) if m == 2*integer(m/2)
    "Second zero system, if present (mp even)";
  final parameter Integer np=integer((m - 1)/2) "Number of space phasors";
  Complex xf[np](each re(stateSelect=StateSelect.avoid), each im(
        stateSelect=StateSelect.avoid)) "Space phasors w.r.t. fixed frame";
  Complex xr[np](each re(stateSelect=xrStateSelect), each im(stateSelect=
          xrStateSelect)) "Space phasors w.r.t. rotating frame";
equation
  //space phasor transformations
  for k in 1:np loop
    xf[k].re = 1/sqrt(m)*sum({cos(k*(l - 1)*2*pi/m)*xi[l] for l in 1:m});
    xf[k].im = 1/sqrt(m)*sum({sin(k*(l - 1)*2*pi/m)*xi[l] for l in 1:m});
    xr[k] = xf[k]*Modelica.ComplexMath.conj(Modelica.ComplexMath.exp(
      Complex(0, gamma)));
  end for;
  annotation (Documentation(info="<html>
<p>
Transforms instantaneous values into space phasors and zero system currents,
rotates space phasors and sets stateSelect modifiers in order to choose states w.r.t. rotating frame,
i.e., with small derivatives.
</p>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Ellipse(
              extent={{-60,60},{60,-60}},
              lineColor={170,213,255},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid),Text(
              extent={{-60,60},{60,-60}},
              textString="S",
              textColor={0,0,255}), Text(
              extent={{0,-60},{0,-100}},
              textColor={0,0,255},
              textString="%name")}));
end StateSelector;
