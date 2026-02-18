within Modelica.Magnetic.FluxTubes.UsersGuide;
model Approximation "Approximation formulae"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<p>
In literature a lot of functions have been discussed for approximation of magnetization characteristics: 
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Fischer1956] Fischer and Moser</a><br> 
In the FluxTubes library it is possible to choose between different approximation functions.<br>
Originally, the formula of <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro00] Roschke</a> has been implemented:
</p>
<pre><code>
            &micro;<sub>ri</sub> - 1 + c<sub>a</sub>&sdot;B<sub>N</sub>
&micro;<sub>r</sub>(B) = 1 + ---------------
            1 + c<sub>b</sub>&sdot;B<sub>N</sub> + B<sub>N</sub><sup>n</sup>
     |B|
B<sub>N</sub> = -----
     B<sub>&micro;Max</sub>
</code></pre>
<p>
<code>B<sub>&micro;Max</sub></code> is the flux density where the maximum of <code>&micro;<sub>r</sub></code> appears.<br>
<code>&micro;<sub>ri</sub></code> is the relative permeability at the origin.<br>
The other parameters <code>c<sub>a</sub>, c<sub>b</sub>, n</code> have to be determined to achieve a best fit of given data.<br>
Note, this formula takes into account the rise of the relative permeability <code>&micro;<sub>r</sub></code> to a maximum at B<sub>&micro;Max</sub>.
</p>
<p>
Additionally, the formula of <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Macfadyen1973] Macfadyen et al</a> has been implemented:
</p>
<pre><code>
               n
J(H) = &sdot;sign(H)&sdot;&sum; J<sub>k</sub>&sdot;(1 - e<sup>-|H|/H<sub>k</sub></sup>) - &micro;<sub>0</sub>&sdot;&chi;<sub>C</sub>&sdot;H&sdot;e<sup>-|H|/H<sub>C</sub></sup>.
               k=1
J<sub>k</sub> = &micro;<sub>0</sub>&sdot;&chi;<sub>k</sub>&sdot;H<sub>k</sub>
</code></pre>
<p>
The terms with index <code>C</code> were added to the original formula to achieve the rise of the relative permeability <code>&micro;<sub>r</sub></code> to a maximum.
</p>
<p>
The parameters <code>{H<sub>k</sub>, J<sub>k</sub>} for k in 1:n</code> have to be determined to achieve a best fit of given data under the following constraints:
</p>
<pre><code>
      n
J<sub>sat</sub> = &sum; J<sub>k</sub>
      k=1
         n
&micro;<sub>ri</sub> = 1 + &sum; &chi;<sub>k</sub>  - &chi;<sub>C</sub>
         k=1
</code></pre>
<p>
Additonally, it is possible to implement an interpolation based on <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData\">raw data</a> instead of using approximation functions.
Be careful regarding the interpolation method, it could reveal undesired curvature between the nodes.
</p>
</html>"));
end Approximation;
