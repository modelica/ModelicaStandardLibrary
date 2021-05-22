within Modelica;
package Constants
  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)"

  extends Modelica.Icons.Package;
  import Modelica.Units.SI;
  import Modelica.Units.NonSI;

  // Mathematical constants
  final constant Real e=Modelica.Math.exp(1.0);
  final constant Real pi=2*Modelica.Math.asin(1.0); // 3.14159265358979;
  final constant Real D2R=pi/180 "Degree to Radian";
  final constant Real R2D=180/pi "Radian to Degree";
  final constant Real gamma=0.57721566490153286061
    "See http://en.wikipedia.org/wiki/Euler_constant";

  // Machine dependent constants
  final constant Real eps=ModelicaServices.Machine.eps
    "Biggest number such that 1.0 + eps = 1.0";
  final constant Real small=ModelicaServices.Machine.small
    "Smallest number such that small and -small are representable on the machine";
  final constant Real inf=ModelicaServices.Machine.inf
    "Biggest Real number such that inf and -inf are representable on the machine";
  final constant Integer Integer_inf=ModelicaServices.Machine.Integer_inf
    "Biggest Integer number such that Integer_inf and -Integer_inf are representable on the machine";

  // Constants of nature
  // (name, value, description from https://www.bipm.org/en/CGPM/db/26/1/, effective from May 20, 2019)
  // The values for c, q, h, k, N_A are exact and part of the basis of the SI-system
  // Note that the elementary charge uses the common alternate name q since e was taken.
  // The values for F, R, sigma, T_zero, epsilon_0 are also exact.
  // The value for mu_0 can now be expressed as 2*alpha*h/(q^2*c),
  // where alpha is the experimental fine-structure constant,
  // and the value is from https://physics.nist.gov/cuu/pdf/wall_2018.pdf
  final constant SI.Velocity c=299792458 "Speed of light in vacuum";
  final constant SI.Acceleration g_n=9.80665
    "Standard acceleration of gravity on earth";
  final constant Real G(final unit="m3/(kg.s2)") = 6.67430e-11
    "Newtonian constant of gravitation";
  final constant SI.ElectricCharge q = 1.602176634e-19 "Elementary charge";
  final constant SI.FaradayConstant F = q*N_A
    "Faraday constant, C/mol";
  final constant Real h(final unit="J.s") = 6.62607015e-34
    "Planck constant";
  final constant Real k(final unit="J/K") = 1.380649e-23
    "Boltzmann constant";
  final constant Real R(final unit="J/(mol.K)") = k*N_A
    "Molar gas constant";
  final constant Real sigma(final unit="W/(m2.K4)") = 2*pi^5*k^4/(15*h^3*c^2)
    "Stefan-Boltzmann constant ";
  final constant Real N_A(final unit="1/mol") = 6.02214076e23
    "Avogadro constant";
  final constant SI.Permeability mu_0 = 4*pi*1.00000000055e-7 "Magnetic constant";
  final constant Real epsilon_0(final unit="F/m") = 1/(mu_0*c*c)
    "Electric constant";
  final constant NonSI.Temperature_degC T_zero=-273.15
    "Absolute zero temperature";
  annotation (
    Documentation(info="<html>
<p>
This package provides often needed constants from mathematics, machine
dependent constants and constants from nature. The latter constants
(name, value, description) are from the following source (based on the second source):
</p>
<dl>
<dt>Michael Stock, Richard Davis, Estefan&iacute;a de Mirand&eacute;s and Martin J T Milton:</dt>
<dd><strong>The revision of the SI-the result of three decades of progress in metrology</strong> in Metrologia, Volume 56, Number 2.
<a href= \"https://iopscience.iop.org/article/10.1088/1681-7575/ab0013/pdf\">https://iopscience.iop.org/article/10.1088/1681-7575/ab0013/pdf</a>, 2019.
</dd>
</dl>
<dl>
<dt>D B Newell, F Cabiati, J Fischer, K Fujii, S G Karshenboim, H S Margolis , E de Mirand&eacute;s, P J Mohr, F Nez, K Pachucki, T J Quinn, B N Taylor, M Wang, B M Wood and Z Zhang:</dt>
<dd><strong>The CODATA 2017 values of h, e, k, and NA for the revision of the SI</strong> in Metrologia, Volume 55, Number 1.
<a href= \"https://iopscience.iop.org/article/10.1088/1681-7575/aa950a/pdf\">https://iopscience.iop.org/article/10.1088/1681-7575/aa950a/pdf</a>, 2017.
</dd>
</dl>
<p>BIPM is Bureau International des Poids et Mesures (they publish the SI-standard).</p>
<p>CODATA is the Committee on Data for Science and Technology.</p>

<dl>
<dt><strong>Main Author:</strong></dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft- und Raumfahrt (DLR)<br>
    Institut f&uuml;r Systemdynamik und Regelungstechnik (SR)<br>
    M&uuml;nchener Straße 20<br>
    D-82234 We&szlig;ling<br>
    Germany<br>
    email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
</dl>

<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>", revisions="<html>
<ul>
<li><em>Dec 4, 2019</em>
       by Thomas Beutlich:<br>
       Constant G updated according to 2018 CODATA value.</li>
<li><em>Mar 25, 2019</em>
       by Hans Olsson:<br>
       Constants updated according to 2017 CODATA values and new SI-standard.</li>
<li><em>Nov 4, 2015</em>
       by Thomas Beutlich:<br>
       Constants updated according to 2014 CODATA values.</li>
<li><em>Nov 8, 2004</em>
       by Christian Schweiger:<br>
       Constants updated according to 2002 CODATA values.</li>
<li><em>Dec 9, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Constants updated according to 1998 CODATA values. Using names, values
       and description text from this source. Included magnetic and
       electric constant.</li>
<li><em>Sep 18, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Constants eps, inf, small introduced.</li>
<li><em>Nov 15, 1997</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
</html>"),
    Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
      Polygon(
        origin={-9.2597,25.6673},
        fillColor={102,102,102},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{48.017,11.336},{48.017,11.336},{10.766,11.336},{-25.684,10.95},{-34.944,-15.111},{-34.944,-15.111},{-32.298,-15.244},{-32.298,-15.244},{-22.112,0.168},{11.292,0.234},{48.267,-0.097},{48.267,-0.097}},
        smooth=Smooth.Bezier),
      Polygon(
        origin={-19.9923,-8.3993},
        fillColor={102,102,102},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{3.239,37.343},{3.305,37.343},{-0.399,2.683},{-16.936,-20.071},{-7.808,-28.604},{6.811,-22.519},{9.986,37.145},{9.986,37.145}},
        smooth=Smooth.Bezier),
      Polygon(
        origin={23.753,-11.5422},
        fillColor={102,102,102},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{-10.873,41.478},{-10.873,41.478},{-14.048,-4.162},{-9.352,-24.8},{7.912,-24.469},{16.247,0.27},{16.247,0.27},{13.336,0.071},{13.336,0.071},{7.515,-9.983},{-3.134,-7.271},{-2.671,41.214},{-2.671,41.214}},
        smooth=Smooth.Bezier)}));
end Constants;
