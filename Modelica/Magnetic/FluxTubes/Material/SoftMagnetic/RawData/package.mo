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
<li>specific losses at reference frequency and <code>B = 1.5 T</code></li>
<li>saturation polarization</li>
<li>magnetic field strength where saturation polarization is reached with desired accuracy</li>
<li>magnetization table <code>H(J)</code> taken from manufacturer's datasheet</li>
</ul>
<p>
The dataset <code>[H, J, mu_r]</code> is expanded by saturation <code>{Hsat, Jsat, 1}</code>, adding the origin <code>{0, 0, mu_ri}</code> and mirrored at the origin, 
so the result can be used for interpolation.
</p>
<p>
Additional parameters are calculated:
</p>
<ul>
<li>Relative permeability <code>mu_r(H)</code></li>
<li>Initial relative permeability <code>mu_ri</code>: linear extrapolation from the first two points to <code>H=0</code></li>
<li>Maximum relative permeability <code>mu_riMax</code></li>
<li>The index of maximum relative permeability <code>iMax</code></li>
</ul>
</html>"));
end RawData;
