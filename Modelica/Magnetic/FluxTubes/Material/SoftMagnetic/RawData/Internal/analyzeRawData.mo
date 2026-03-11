within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData.Internal;
function analyzeRawData "Analyze RawData and caclulate mu_r"
  extends Modelica.Icons.Function;
  import Modelica.Constants.mu_0;
  input Modelica.Units.SI.MagneticPolarization J[:] "Polarization";
  input Modelica.Units.SI.MagneticFieldStrength H[:] "Field strength";
  input Modelica.Units.SI.MagneticPolarization Jsat "Saturation polarization";
  input Modelica.Units.SI.MagneticFieldStrength Hsat "Field strength to achieve Jsat";
  output Modelica.Units.SI.RelativePermeability mu_r[size(J,1)] "Relative permeability";
algorithm
  assert(size(H,1)==size(J,1), "J and H arrays have to have the same length!");
  assert(H[1]>0 and J[1]>0, "J=0 and H=0 are not expected in the given arrays!");
  assert(H[end]<Hsat and J[end]<Jsat, "J=Jsat and H=Hsat are not expected in the given arrays!");
  for k in 2:size(J,1) - 1 loop
    assert(H[k]>H[k - 1], "H is expected with ascending order!");
  end for;
  mu_r :={1 + J[k]/(mu_0*H[k]) for k in 1:size(J, 1)};
  annotation (Documentation(info="<html>
<p>This helper functions checks</p>
<ul>
<li>whether the given arrays <code>J</code> and <code>H</code> have the same length.</li>
<li>whether the origin <code>(0, 0)</code> is not included in the given arrays.</li>
<li>whether saturation <code>(Hsat, Jsat)</code> is not included in the given arrays.</li>
<li>whether array <code>H</code> is of ascending order.</li>
</ul>
<p>and calculates relative permeability:</p>
<pre><code>
          J
&micro;<sub>r</sub> = 1 + ----
         &micro;<sub>0</sub>&sdot;H
</code></pre>
</html>"));
end analyzeRawData;
