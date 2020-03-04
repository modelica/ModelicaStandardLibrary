within Modelica.Blocks.Continuous.Internal.Filter.coefficients;
function bandStop
    "Return band stop filter coefficients at given cut-off frequency"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Function;

  input Real cr_in[:] "Coefficients of real poles";
  input Real c0_in[:]
      "Coefficients of s^0 term if conjugate complex pole";
  input Real c1_in[size(c0_in,1)]
      "Coefficients of s^1 term if conjugate complex pole";
  input SI.Frequency f_min
      "Band of band stop filter is f_min (A=-3db) .. f_max (A=-3db)";
  input SI.Frequency f_max "Upper band frequency";

  output Real cr[0] "Coefficient of real pole";
  output Real c0[size(cr_in,1) + 2*size(c0_in,1)]
      "Coefficients of s^0 term if conjugate complex pole";
  output Real c1[size(cr_in,1) + 2*size(c0_in,1)]
      "Coefficients of s^1 term if conjugate complex pole";
protected
  SI.Frequency f0 = sqrt(f_min*f_max);
  SI.AngularVelocity w_cut=2*pi*f0
      "Cut-off angular frequency";
  Real w_band = (f_max - f_min) / f0;
  Real w_cut2=w_cut*w_cut;
  Real c;
  Real ww;
  Real alpha;
  Integer j;
algorithm
  assert(f_min > 0 and f_min < f_max, "Band frequencies f_min and f_max are wrong");

    /* The band pass filter is derived from the low pass filter by
       the transformation new(s) = (s + 1/s)/w   (w = w_band = (f_max - f_min)/sqrt(f_max*f_min) )

       1/(s + cr)         -> 1/((s/w + 1/s/w) + cr)
                             = w*s / (s^2 + cr*w*s + 1)

       1/(s^2 + c1*s + c0) -> 1/( (s+1/s)^2/w^2 + c1*(s + 1/s)/w + c0 )
                              = 1 /( ( s^2 + 1/s^2 + 2)/w^2 + (s + 1/s)*c1/w + c0 )
                              = w^2*s^2 / (s^4 + 2*s^2 + 1 + (s^3 + s)*c1*w + c0*w^2*s^2)
                              = w^2*s^2 / (s^4 + c1*w*s^3 + (2+c0*w^2)*s^2 + c1*w*s + 1)

                              Assume the following description with PT2:
                              = w^2*s^2 /( (s^2 + s*(c/alpha) + 1/alpha^2)*
                                           (s^2 + s*(c*alpha) + alpha^2) )
                              = w^2*s^2 / ( s^4 + c*(alpha + 1/alpha)*s^3
                                                + (alpha^2 + 1/alpha^2 + c^2)*s^2
                                                + c*(alpha + 1/alpha)*s + 1 )

                              and therefore:
                                c*(alpha + 1/alpha) = c1*w       -> c = c1*w / (alpha + 1/alpha)
                                                                      = c1*w*alpha/(1+alpha^2)
                                alpha^2 + 1/alpha^2 + c^2 = 2+c0*w^2 -> equation to determine alpha
                                alpha^4 + 1 + c1^2*w^2*alpha^4/(1+alpha^2)^2 = (2+c0*w^2)*alpha^2
                                or z = alpha^2
                                z^2 + c^1^2*w^2*z^2/(1+z)^2 - (2+c0*w^2)*z + 1 = 0

       The band stop filter is derived from the low pass filter by
       the transformation new(s) = w/( (s + 1/s) )   (w = w_band = (f_max - f_min)/sqrt(f_max*f_min) )

       cr/(s + cr)         -> 1/(( w/(s + 1/s) ) + cr)
                              = (s^2 + 1) / (s^2 + (w/cr)*s + 1)

       c0/(s^2 + c1*s + c0) -> c0/( w^2/(s + 1/s)^2 + c1*w/(s + 1/s) + c0 )
                               = c0*(s^2 + 1)^2 / (s^4 + c1*w*s^3/c0 + (2+w^2/b)*s^2 + c1*w*s/c0 + 1)

                               Assume the following description with PT2:
                               = c0*(s^2 + 1)^2 / ( (s^2 + s*(c/alpha) + 1/alpha^2)*
                                                    (s^2 + s*(c*alpha) + alpha^2) )
                               = c0*(s^2 + 1)^2 / (  s^4 + c*(alpha + 1/alpha)*s^3
                                                         + (alpha^2 + 1/alpha^2 + c^2)*s^2
                                                         + c*(alpha + 1/alpha)*p + 1 )

                            and therefore:
                              c*(alpha + 1/alpha) = c1*w/b         -> c = c1*w/(c0*(alpha + 1/alpha))
                              alpha^2 + 1/alpha^2 + c^2 = 2+w^2/c0 -> equation to determine alpha
                              alpha^4 + 1 + (c1*w/c0*alpha^2)^2/(1+alpha^2)^2 = (2+w^2/c0)*alpha^2
                              or z = alpha^2
                              z^2 + (c1*w/c0*z)^2/(1+z)^2 - (2+w^2/c0)*z + 1 = 0

                            same as:  ww = w/c0
                              z^2 + (c1*ww*z)^2/(1+z)^2 - (2+c0*ww)*z + 1 = 0  -> same equation as for BandPass

     Afterwards, change filter coefficients according to transformation new(s) = s/w_cut
        c0*(s^2+1)(s^2 + c1*s + c0)  -> c0*((s/w)^2 + 1) / ((s/w)^2 + c1*(s/w) + c0 =
                                        c0/w^2*(s^2 + w^2) / (s^2 + (c1*w)*s + (c0*w^2))/w^2) =
                                        (s^2 + c0*w^2) / (s^2 + (c1*w)*s + (c0*w^2))
    */
    for i in 1:size(cr_in,1) loop
       c1[i] := w_cut*w_band/cr_in[i];
       c0[i] := w_cut2;
    end for;

    for i in 1:size(c1_in,1) loop
       ww      := w_band/c0_in[i];
      alpha :=
        Modelica.Blocks.Continuous.Internal.Filter.Utilities.bandPassAlpha(
              c1_in[i],
              c0_in[i],
              ww);
       c       := c1_in[i]*ww / (alpha + 1/alpha);
       j       := size(cr_in,1) + 2*i - 1;
       c1[j]   := w_cut*c/alpha;
       c1[j+1] := w_cut*c*alpha;
       c0[j]   := w_cut2/alpha^2;
       c0[j+1] := w_cut2*alpha^2;
    end for;

end bandStop;
