within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic;
package RawData "Records with measurents or datasheet"
  extends Modelica.Icons.RecordsPackage;
  import Modelica.Magnetic.FluxTubes.Types.SpecificPower;

  annotation (Documentation(info="<html>
<p>
This raw data records cover the following information:
</p>
<ul>
<li>density</li>
<li>specific losses at 2 different frequencies and <code>B = 1.5 T</code></li>
<li>saturation polarization</li>
<li>magnetic field strength where saturation polarization is reached with desired accuracy</li>
<li>magnetization table <code>H(J)</code> taken from manufacturer's datasheet</li>
</ul>
<p>
The dataset <code>[H, J, mu_r] is expanded by saturation <code>{Hsat, Jsat, 1}</code>, adding the origin <code>{0, 0, mu_ri}</code> and mirrored at the origin.<br> 
For interpolation, use <code>smoothness = MonotoneContinuousDerivative</code> and <code>extrapolation = HoldLastPoint</code>.
</p>
<p>
Assuming the maximum relative permeability is included in the measurements, additional parameters are calculated:
</p>
<ul>
<li>Ratio of hysteresis losses with respect to the total core losses at 1.5 T and f1</li>
<li>Relative permeability <code>mu_r(H)</code></li>
<li>Initial relative permeability <code>mu_ri</code>: linear extrapolation from the first two points to <code>H=0</code></li>
<li>Maximum relative permeability <code>mu_riMax</code></li>
<li>Alternative initial relative permeability <code>mu_ra</code>: linear extrapolation from right of the maximum to <code>H=0</code>
    using the function <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData.Functions.exMax\">exMax</a> (extrapolation from maximum)</li>
</ul>
<p>
The separation of hysteresis and eddy current losses is done according to the formula of Jordan (<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Jordan1924]</a>):
</p>
<pre><code>
P = v<sub>Ref</sub>&sdot;m&sdot;[ratioHysteresis&sdot;(f/f<sub>Ref</sub>) + (1 - ratioHysteresis)&sdot;(f/f<sub>Ref</sub>)<sup>2</sup>]&sdot;(B/B<sub>Ref</sub>)<sup>2</sup>
</code></pre>
<p>
<code>v<sub>Ref</sub></code> are the total specific losses at reference frequency <code>f<sub>Ref</sub></code> and reference peak flux density <code>f<sub>Ref</sub></code> (usually 1.5 T).
</p>
</html>"));
end RawData;
