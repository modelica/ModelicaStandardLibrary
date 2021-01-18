package ModelicaTestConversion5
  extends Modelica.Icons.ExamplesPackage;
  package Utilities
    extends Modelica.Icons.ExamplesPackage;
    model Issue3247 "Conversion test for #3247"
      extends Modelica.Icons.Example;
      Integer ms;
      Integer sec;
      Integer min;
      Integer hour;
      Integer day;
      Integer mon;
      Integer year;
    equation
      (ms, sec, min, hour, day, mon, year) = Modelica.Utilities.System.getTime();
      annotation(experiment(StopTime=1), Documentation(info="<html>
<p>
Conversion test for <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/3247\">#3247</a>.
</p>
</html>"));
    end Issue3247;
  end Utilities;
  annotation(uses(Modelica(version="4.0.0"), Complex(version="4.0.0")), Documentation(info="<html>
<p>
This library provides models and functions to test the MSL v5.0.0 conversion script \"ConvertModelica_from_4.0.0_to_5.0.0.mos\"
for conversion of Modelica libraries using MSL v4.0.0 to MSL v5.0.0. These models are not meant to be meaningful otherwise.
</p>

<p>
Copyright &copy; 2021, Modelica Association and contributors
</p>

<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>"));
end ModelicaTestConversion5;
