within Modelica.Electrical.Machines.BasicMachines;
package QuasiStaticDCMachines "Models of quasi-static DC machines"
  extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(info="<html>
<p>
This package contains quasi-static models of DC machines;
these models are fully compatible with the
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines\">transient machine models of DC machines</a>;
the only difference is that electrical transients are neglected.
</p>
<h4>Note</h4>
<p>
Quasi-static DC machine models are basically different from quasi-static induction machine models:
Quasi-static DC machine models neglect electrical transients, i.e., setting <code>der(i) = 0</code>,
whereas quasi-static induction machine models are based on time phasor theory,
see <a href=\"modelica://Modelica.Electrical.QuasiStatic\">QuasiStatic Library</a>,
where e.g., <code>L*der(i)</code> is replaced by <code>j*omega*L*(I_re+j*I_im)</code>.
</p>
</html>",
      revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
  <ul>
  <li> v2.3.0 2010/02/16 Anton Haumer<br>
       first implementation</li>
  </ul>
</html>"));
end QuasiStaticDCMachines;
