within Modelica.Blocks.Continuous.Internal.Filter.coefficients;
function lowPass
    "Return low pass filter coefficients at given cut-off frequency"
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

  /* Change filter coefficients according to transformation new(s) = s/w_cut
     s + cr           -> (s/w) + cr              = (s + w*cr)/w
     s^2 + c1*s + c0  -> (s/w)^2 + c1*(s/w) + c0 = (s^2 + (c1*w)*s + (c0*w^2))/w^2
  */
  cr := w_cut*cr_in;
  c1 := w_cut*c1_in;
  c0 := w_cut2*c0_in;

end lowPass;
