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
  // (name, value, description from http://www.bipm.org/utils/common/pdf/si-brochure-draft-2016b.pdf, data from 2016)
  // The values for c, q, h, k, N_A are exact and part of the basis of the SI-system
  // Note that the elementary charge uses the common alternate name q since e was taken.
  // The values for F, R, sigma, mue_0, epsilson_0, T_zero are also exact.
  final constant SI.Velocity c=299792458 "Speed of light in vacuum";
  final constant SI.Acceleration g_n=9.80665
    "Standard acceleration of gravity on earth";
  final constant Real G(final unit="m3/(kg.s2)") = 6.67408e-11
    "Newtonian constant of gravitation (previous value: 6.6742e-11)";
  final constant SI.ElectricCharge q = 1.6021766208e-19 "elementary charge";
  final constant SI.FaradayConstant F = q*N_A
    "Faraday constant, C/mol (previous value: 9.64853399e4)";
  final constant Real h(final unit="J.s") = 6.626070040e-34
    "Planck constant (previous value: 6.6260693e-34)";
  final constant Real k(final unit="J/K") = 1.38064852e-23
    "Boltzmann constant (previous value: 1.3806505e-23)";
  final constant Real R(final unit="J/(mol.K)") = k*N_A
    "Molar gas constant (previous value: 8.314472)";
  final constant Real sigma(final unit="W/(m2.K4)") = 2*pi^5*k^4/(15*h^3*c^2)
    "Stefan-Boltzmann constant (previous value: 5.670400e-8)";
  final constant Real N_A(final unit="1/mol") = 6.022140857e23
    "Avogadro constant (previous value: 6.0221415e23)";
  final constant Real mue_0(final unit="N/A2") = 4*pi*1.e-7 "Magnetic constant";
  final constant Real epsilon_0(final unit="F/m") = 1/(mue_0*c*c)
    "Electric constant";
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
<dd><b>CODATA Recommended Values of the Fundamental Physical Constants: 2014</b>.
<a href= \"http://dx.doi.org/10.5281/zenodo.22826\">http://dx.doi.org/10.5281/zenodo.22826</a>, 2015. See also <a href=
\"http://physics.nist.gov/cuu/Constants/index.html\">http://physics.nist.gov/cuu/Constants/index.html</a></dd>
</dl>

<p>CODATA is the Committee on Data for Science and Technology.</p>

<dl>
<dt><b>Main Author:</b></dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 We&szlig;ling<br>
    email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
</dl>

<p>
Copyright &copy; 1998-2016, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>", revisions="<html>
<ul>
<li><i>Nov 4, 2015</i>
       by Thomas Beutlich:<br>
       Constants updated according to 2014 CODATA values.</li>
<li><i>Nov 8, 2004</i>
       by Christian Schweiger:<br>
       Constants updated according to 2002 CODATA values.</li>
<li><i>Dec 9, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Constants updated according to 1998 CODATA values. Using names, values
       and description text from this source. Included magnetic and
       electric constant.</li>
<li><i>Sep 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Constants eps, inf, small introduced.</li>
<li><i>Nov 15, 1997</i>
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
