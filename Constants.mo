package Constants "Mathematical constants and constants of nature" 
  
  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  
  extends Modelica.Icons.Library2;
  
  // Mathematical constants
  constant Real e=Modelica.Math.exp(1.0);
  constant Real pi=2*Modelica.Math.asin(1.0);
  // 3.14159265358979;
  constant Real D2R=pi/180 "Degree to Radian";
  constant Real R2D=180/pi "Radian to Degree";
  
  // Machine dependent constants
  // (the definition is a temporary fix since not adapted to the
  // machine where the Modelica translator is running)
  constant Real eps=1.e-15 "Biggest number such that 1.0 + eps = 1.0";
  constant Real small=1.e-60 
    "Smallest number such that small and -small are representable on the machine";
  constant Real inf=1.e+60 
    "Biggest Real number such that inf and -inf are representable on the machine";
  constant Integer Integer_inf=2147483647 
    "Biggest Integer number such that Integer_inf and -Integer_inf are representable on the machine";
  
  // Constants of nature
  // (name, value, description from http://physics.nist.gov/cuu/Constants/)
  constant SI.Velocity c=299792458 "Speed of light in vacuum";
  constant SI.Acceleration g_n=9.80665 
    "Standard acceleration of gravity on earth";
  constant Real G(final unit="m3/(kg.s2)") = 6.673e-11 
    "Newtonian constant of gravitation";
  constant Real h(final unit="J.s") = 6.62606876e-34 "Planck constant";
  constant Real k(final unit="J/K") = 1.3806503e-23 "Boltzmann constant";
  constant Real R(final unit="J/(mol.K)") = 8.314472 "Molar gas constant";
  constant Real sigma(final unit="W/(m2.K4)") = 5.670400e-8 
    "Stefan-Boltzmann constant";
  constant Real N_A(final unit="1/mol") = 6.02214199e23 "Avogadro constant";
  constant Real mue_0(final unit="N/A2") = 4*pi*1.e-7 "Magnetic constant";
  constant Real epsilon_0(final unit="F/m") = 1/(mue_0*c*c) "Electric constant";
  constant NonSI.Temperature_degC T_zero=-273.15 "Absolute zero temperature";
  
  // For compatibility with previous versions (do not use in new models)
  constant Real E=e;
  constant Real PI=pi;
  constant Real EPS=eps;
  constant Real SMALL=small;
  constant Real INF=inf;
  constant Real INTEGER_INF=Integer_inf;
  constant Real C=c;
  constant Real H=h;
  constant Real K=k;
  constant Real R0=R;
  constant Real SIGMA=sigma;
  constant Real G_EARTH=g_n;
  constant Real T_ZERO=T_zero;
  
  annotation(
    Documentation(info="<html>
<p>
This package provides often needed constants from mathematics, machine
dependent constants and constants from nature. The latter constants
(name, value, description) are from the following source:
</p>

<dl>
<dt>Peter J. Mohr and Barry N. Taylor (1999):
<dd><b>CODATA Recommended Values of the Fundamental Physical Constants: 1998</b>.
       Journal of Physical and Chemical Reference Data, Vol. 28, No. 6, 1999 and
       Reviews of Modern Physics, Vol. 72, No. 2, 2000. See also
       <a href=\"http://physics.nist.gov/cuu/Constants/\">
                 http://physics.nist.gov/cuu/Constants/</a>
</dl>
<br>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<br>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Dec. 9, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Constants updated according to 1998 CODATA values. Using names, values
       and description text from this source. Included magnetic and
       electric constant.</li>
<li><i>Sept. 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Constants EPS, INF, SMALL introduced.</li>
<li><i>Nov 15, 1997</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
<br>


<p><b>Copyright &copy; 1999-2002, Modelica Association and DLR.</b></p>

<p><i>
The Modelica package is free software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"), Window(
      x=0.16,
      y=0.01,
      width=0.65,
      height=0.81,
      library=1,
      autolayout=1),
    Invisible=true,
    Icon(
      Line(points=[-34, -38; 12, -38], style(color=0, thickness=2)),
      Line(points=[-20, -38; -24, -48; -28, -56; -34, -64], style(color=0,
            thickness=2)),
      Line(points=[-2, -38; 2, -46; 8, -56; 14, -64], style(color=0, thickness=
              2))),
    Diagram(
      Rectangle(extent=[200, 162; 380, 312], style(fillColor=30, fillPattern=1)),
      Polygon(points=[200, 312; 220, 332; 400, 332; 380, 312; 200, 312], style(
            fillColor=30, fillPattern=1)),
      Polygon(points=[400, 332; 400, 182; 380, 162; 380, 312; 400, 332], style(
            fillColor=30, fillPattern=1)),
      Text(
        extent=[210, 302; 370, 272],
        string="Library",
        style(
          color=9,
          fillColor=0,
          fillPattern=1)),
      Line(points=[266, 224; 312, 224], style(color=0, thickness=4)),
      Line(points=[280, 224; 276, 214; 272, 206; 266, 198], style(color=0,
            thickness=4)),
      Line(points=[298, 224; 302, 216; 308, 206; 314, 198], style(color=0,
            thickness=4)),
      Text(
        extent=[152, 412; 458, 334],
        string="Modelica.Constants",
        style(color=1))));
end Constants;
