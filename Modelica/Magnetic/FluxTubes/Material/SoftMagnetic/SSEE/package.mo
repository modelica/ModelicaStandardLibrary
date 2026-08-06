within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic;
package SSEE "Smoothing Splines with Exponential Extrapolation"
  extends Modelica.Icons.MaterialPropertiesPackage;
  import Modelica.Units.SI;

  annotation (preferredView="info", Documentation(info="<html>
<p>The parameter records contain the following data:</p>
<p>Common parameters:</p>
<ul>
<li>specific losses <code>vRef</code></li>
<li>at specified flux density <code>BRef</code></li>
<li>and frequency <code>fRef</code></li>
<li>density <code>dens</code></li>
<li>initial relative permeability <code>mu_ri</code></li>
</ul>
<p>Parameters for Exponential Extrapolation:
<code>J(H) = JD[k0] + (Jsat - JD[k0])*(1 - exp(-(H - HD(k0))/Hpar))</code><p>
<ul>
<li>Index in raw data where exponential extrapolation starts <code>k0</code></li>
<li>Parameter in exponential function <code>Hpar</code></li>
<li>Field strength where saturation is nearly reached <code>Hsat</code></li>
<li>Saturation polarization <code>Jsat</code></li>
</ul>
<p>Homotopy borders for mixing Smoothing Splines with Exponential Extrapolation:<p>
<ul>
<li>Field strength where mixing starts <code>hH1</code></li>
<li>Field strength where mixing ends   <code>hH2</code></li>
</ul>
<p>For <code>H&lt;hH1</code> pure spline interpolation is used. 
   For <code>H&gt;hH2</code> pure exponential extrapolation is used. 
   In the region between both are mixed, linearly dependent on <code>H</code>.</p>
<p>Number of raw data nodes = 1 + number of spline coefficients <code>N</code>.<p>
<p>Parameters for Spline interpolation: 
<code>J(H) = c0[k] + c1[k]*(H - HD[k]) + c2[k]*(H - HD[k])^2 + c3[k]*(H - HD[k])^3</code><p>
<ul>
<li>coefficients for 3<sup>rd</sup> power <code>c3</code></li>
<li>coefficients for 2<sup>nd</sup> power <code>c2</code></li>
<li>coefficients for 1<sup>st</sup> power <code>c1</code></li>
<li>constant coefficients <code>c0</code></li>
</ul>
<p>Raw Data nodes:<p>
<ul>
<li>field strength array <code>HD</code></li>
<li>polarization  array  <code>JD</code></li>
</ul>
<p>
Measured data were provided by <a href=\"https://www.voestalpine.com/isovac/Downloads/Datenblaetter\">VoestAlpine</a>. 
Many thanks to that company for allowing us to use this data!
</p>
<p>Note:</p>
<ul>
<li>The origin <code>(0, 0)</code> has to be included as first node in the arrays.</li>
<li>The arrays have to be specified in ascending order.</li>
<li>The arrays are only specified for positive field strength, it is assumed that the characteristic is point symmetric to the origin.</li>
</ul>
</html>"));
end SSEE;
