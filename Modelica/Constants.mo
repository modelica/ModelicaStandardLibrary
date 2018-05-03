within Modelica;
package Constants
  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)"

  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;

  extends Modelica.Icons.Package;

  // Mathematical constants
  final constant Real e=Modelica.Math.exp(1.0);
  final constant Real pi=2*Modelica.Math.asin(1.0); // 3.14159265358979;
  final constant Real D2R=pi/180 "Degree to Radian";
  final constant Real R2D=180/pi "Radian to Degree";
  final constant Real gamma=0.57721566490153286060
    "see http://en.wikipedia.org/wiki/Euler_constant";

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
  // (name, value, description from http://physics.nist.gov/cuu/Constants/index.html, data from 2014)
  final constant SI.Velocity c=299792458 "Speed of light in vacuum";
  final constant SI.Acceleration g_n=9.80665
    "Standard acceleration of gravity on earth";
  final constant Real G(final unit="m3/(kg.s2)") = 6.67408e-11
    "Newtonian constant of gravitation (previous value: 6.6742e-11)";
  final constant SI.FaradayConstant F = 9.648533289e4
    "Faraday constant, C/mol (previous value: 9.64853399e4)";
  final constant Real h(final unit="J.s") = 6.626070040e-34
    "Planck constant (previous value: 6.6260693e-34)";
  final constant Real k(final unit="J/K") = 1.38064852e-23
    "Boltzmann constant (previous value: 1.3806505e-23)";
  final constant Real R(final unit="J/(mol.K)") = 8.3144598
    "Molar gas constant (previous value: 8.314472)";
  final constant Real sigma(final unit="W/(m2.K4)") = 5.670367e-8
    "Stefan-Boltzmann constant (previous value: 5.670400e-8)";
  final constant Real N_A(final unit="1/mol") = 6.022140857e23
    "Avogadro constant (previous value: 6.0221415e23)";
  final constant Real mue_0(final unit="N/A2") = 4*pi*1.e-7 "Magnetic constant";
  final constant Real epsilon_0(final unit="F/m") = 1/(mue_0*c*c)
    "Electric constant";
  final constant Modelica.SIunits.ElectricCharge q = Modelica.Constants.F/Modelica.Constants.N_A
      "Elementary charge (electron charge without sign) = 1.602177e-19 C";
  final constant NonSI.Temperature_degC T_zero=-273.15
    "Absolute zero temperature";
  annotation (
    Documentation(info="<html>
<p>
This package provides often needed constants from mathematics, machine
dependent constants and constants from nature. The latter constants
(name, value, description) are from the following source:
</p>

<dl>
<dt>Peter J. Mohr, David B. Newell, and Barry N. Taylor:</dt>
<dd><strong>CODATA Recommended Values of the Fundamental Physical Constants: 2014</strong>.
<a href= \"http://dx.doi.org/10.5281/zenodo.22826\">http://dx.doi.org/10.5281/zenodo.22826</a>, 2015. See also <a href=
\"http://physics.nist.gov/cuu/Constants/index.html\">http://physics.nist.gov/cuu/Constants/index.html</a></dd>
</dl>

<p>CODATA is the Committee on Data for Science and Technology.</p>

<dl>
<dt><strong>Main Author:</strong></dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 We&szlig;ling<br>
    email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
</dl>

<p>
Copyright &copy; 1998-2018, Modelica Association and DLR.
</p>
<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>", revisions="<html>
<ul>
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
