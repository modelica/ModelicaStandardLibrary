within Modelica.Clocked.UsersGuide.ReleaseNotes;
class Version_0_91 "Version 0.91 (Sept. 20, 2012)"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>
<p>
First version of the library provided on the Modelica web page.
Changes with respect to version 0.9:
</p>

<ul>
<li> The library has been slightly restructured. </li>
<li> Documentation has been significantly enhanced
     (nearly all elements of the library are documented now).</li>
<li> Simple examples have been added for many
     blocks of the library in the new package
     <a href=\"modelica://Modelica.Clocked.Examples.Elementary\">Examples.Elementary</a>.
     These blocks have been used to generate the figures in the documentation of
     many blocks. Furthermore, they are used for testing these blocks.</li>
</ul>

<p>
The library has been tested with Dymola 2013 FD01:
</p>

<ul>
<li> \"Check\" with \"Pedantic = true\" is successful (so the library should be completely compatible
     to the Modelica 3.3 specification).</li>
<li> \"Check with Simulation\" is successful.</li>
<li> The tests have a class coverage of 100 %
     (that is every class of the library is utilized in at least
     one test).</li>
<li> The results of the test models have been either manually checked,
     or compared with results of the Modelica_LinearSystems.Controller or
     the Modelica.Blocks.Discrete library.</li>
</ul>

<p>
The library has also been tested with the MapleSim Standalone Modelica parser
(so also another Modelica tool deduces that the library is fully compliant to
Modelica).
</p>
</html>"));
end Version_0_91;
