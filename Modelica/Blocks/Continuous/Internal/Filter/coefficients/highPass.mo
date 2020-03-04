within Modelica.Blocks.Continuous.Internal.Filter.coefficients;
function highPass
    "Return high pass filter coefficients at given cut-off frequency"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Function;

  input Real cr_in[:] "Coefficients of real poles";
  input Real c0_in[:]
      "Coefficients of s^0 term if conjugate complex pole";
  input Real c1_in[size(c0_in,1)]
      "Coefficients of s^1 term if conjugate complex pole";
  input SI.Frequency f_cut "Cut-off frequency";

  output Real cr[size(cr_in,1)] "Coefficient of real pole";
  output Real c0[size(c0_in,1)]
      "Coefficients of s^0 term if conjugate complex pole";
  output Real c1[size(c0_in,1)]
      "Coefficients of s^1 term if conjugate complex pole";

protected
  SI.AngularVelocity w_cut=2*pi*f_cut
      "Cut-off angular frequency";
  Real w_cut2=w_cut*w_cut;

algorithm
  assert(f_cut > 0, "Cut-off frequency f_cut must be positive");

  /* Change filter coefficients according to transformation: new(s) = 1/s
        1/(s + cr)          -> 1/(1/s + cr)                = (1/cr)*s / (s + (1/cr))
        1/(s^2 + c1*s + c0) -> 1/((1/s)^2 + c1*(1/s) + c0) = (1/c0)*s^2 / (s^2 + (c1/c0)*s + 1/c0)

     Check whether transformed roots are also conjugate complex:
        c0 - c1^2/4 > 0  -> (1/c0) - (c1/c0)^2 / 4
                            = (c0 - c1^2/4) / c0^2 > 0
        It is therefore guaranteed that the roots remain conjugate complex

     Change filter coefficients according to transformation new(s) = s/w_cut
        s + 1/cr                -> (s/w) + 1/cr                   = (s + w/cr)/w
        s^2 + (c1/c0)*s + 1/c0  -> (s/w)^2 + (c1/c0)*(s/w) + 1/c0 = (s^2 + (w*c1/c0)*s + (w^2/c0))/w^2
  */
  for i in 1:size(cr_in,1) loop
     cr[i] := w_cut/cr_in[i];
  end for;

  for i in 1:size(c0_in,1) loop
     c0[i] := w_cut2/c0_in[i];
     c1[i] := w_cut*c1_in[i]/c0_in[i];
  end for;

end highPass;
