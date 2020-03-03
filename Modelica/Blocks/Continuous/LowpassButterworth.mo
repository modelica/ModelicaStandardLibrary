within Modelica.Blocks.Continuous;
block LowpassButterworth
  "Output the input signal filtered with a low pass Butterworth filter of any order"

  import Modelica.Blocks.Types.Init;
  import Modelica.Constants.pi;

  extends Modelica.Blocks.Interfaces.SISO;

  parameter Integer n(min=1) = 2 "Order of filter";
  parameter SI.Frequency f(start=1) "Cut-off frequency";
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                                                                    annotation(Evaluate=true,
      Dialog(group="Initialization"));
  parameter Real x1_start[m]=zeros(m)
    "Initial or guess values of states 1 (der(x1)=x2)"
    annotation (Dialog(group="Initialization"));
  parameter Real x2_start[m]=zeros(m) "Initial or guess values of states 2"
    annotation (Dialog(group="Initialization"));
  parameter Real xr_start=0.0
    "Initial or guess value of real pole for uneven order otherwise dummy"
    annotation (Dialog(group="Initialization"));
  parameter Real y_start=0.0
    "Initial value of output (states are initialized in steady state if possible)"
     annotation(Dialog(enable=initType == Init.InitialOutput, group=
          "Initialization"));

  output Real x1[m](start=x1_start)
    "states 1 of second order filters (der(x1) = x2)";
  output Real x2[m](start=x2_start) "states 2 of second order filters";
  output Real xr(start=xr_start)
    "state of real pole for uneven order otherwise dummy";
protected
  parameter Integer m=integer(n/2);
  parameter Boolean evenOrder = 2*m == n;
  parameter Real w=2*pi*f;
  Real z[m + 1];
  Real polereal[m];
  Real poleimag[m];
  Real realpol;
  Real k2[m];
  Real D[m];
  Real w0[m];
  Real k1;
  Real T;
initial equation
  if initType == Init.SteadyState then
    der(x1) = zeros(m);
    der(x2) = zeros(m);
    if not evenOrder then
      der(xr) = 0.0;
    end if;
  elseif initType == Init.InitialState then
    x1 = x1_start;
    x2 = x2_start;
    if not evenOrder then
      xr = xr_start;
    end if;
  elseif initType == Init.InitialOutput then
    y = y_start;
    der(x1) = zeros(m);
    if evenOrder then
      if m > 1 then
        der(x2[1:m-1]) = zeros(m-1);
      end if;
    else
      der(x1) = zeros(m);
    end if;
  end if;
equation
  k2 = ones(m);
  k1 = 1;
  z[1] = u;

  // calculate filter parameters
  for i in 1:m loop
    // poles of prototype lowpass
    polereal[i] = Modelica.Math.cos(pi/2 + pi/n*(i - 0.5));
    poleimag[i] = Modelica.Math.sin(pi/2 + pi/n*(i - 0.5));
    // scaling and calculation of second order filter coefficients
    w0[i] = (polereal[i]^2 + poleimag[i]^2)*w;
    D[i] = -polereal[i]/w0[i]*w;
  end for;
  realpol = 1*w;
  T = 1/realpol;

  // calculate second order filters
  for i in 1:m loop
    der(x1[i]) = x2[i];
    der(x2[i]) = k2[i]*w0[i]^2*z[i] - 2*D[i]*w0[i]*x2[i] - w0[i]^2*x1[i];
    z[i + 1] = x1[i];
  end for;

  // calculate first order filter if necessary
  if evenOrder then
    // even order
    xr = 0;
    y = z[m + 1];
  else
    // uneven order
    der(xr) = (k1*z[m + 1] - xr)/T;
    y = xr;
  end if;
  annotation (
    Icon(
        coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}}),
            graphics={
        Line(points={{-80.0,78.0},{-80.0,-90.0}},
            color={192,192,192}),
        Polygon(lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            points={{-79.5584,91.817},{-87.5584,69.817},{-71.5584,69.817},{-79.5584,91.817}}),
        Line(origin = {-1.939,-1.816},
            points = {{81.939,36.056},{65.362,36.056},{14.39,-26.199},{-29.966,113.485},{-65.374,-61.217},{-78.061,-78.184}},
            color = {0,0,127},
            smooth = Smooth.Bezier),
        Line(points={{-90.9779,-80.7697},{81.0221,-80.7697}},
            color={192,192,192}),
        Polygon(lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            points={{91.3375,-79.8233},{69.3375,-71.8233},{69.3375,-87.8233},{91.3375,-79.8233}}),
        Text(textColor={192,192,192},
            extent={{-45.1735,-68.0},{92.0,-11.47}},
            textString="LowpassButterworthFilter"),
        Text(extent={{8.0,-146.0},{8.0,-106.0}},
            textString="f=%f"),
        Text(textColor={192,192,192},
            extent={{-2.0,48.0},{94.0,94.0}},
            textString="%n")}),
    Documentation(info="<html>
<p>
This block defines the transfer function between the input u
and the output y as an n-th order low pass filter with <em>Butterworth</em>
characteristics and cut-off frequency f. It is implemented as
a series of second order filters and a first order filter.
Butterworth filters have the feature that the amplitude at the
cut-off frequency f is 1/sqrt(2) (= 3 dB), i.e., they are
always \"normalized\". Step responses of the Butterworth filter of
different orders are shown in the next figure:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/Butterworth.png\"
     alt=\"Butterworth.png\">
</p>

<p>
If transients at the simulation start shall be avoided, the filter
should be initialized in steady state (e.g., using option
initType=Modelica.Blocks.Types.Init.SteadyState).
</p>

</html>"));
end LowpassButterworth;
