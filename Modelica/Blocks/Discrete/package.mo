within Modelica.Blocks;
package Discrete "Library of discrete input/output blocks with fixed sample period"

  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
This package contains <strong>discrete control blocks</strong>
with <strong>fixed sample period</strong>.
Every component of this package is structured in the following way:
</p>
<ol>
<li> A component has <strong>continuous real</strong> input and output signals.</li>
<li> The <strong>input</strong> signals are <strong>sampled</strong> by the given sample period
     defined via parameter <strong>samplePeriod</strong>.
     The first sample instant is defined by parameter <strong>startTime</strong>.</li>
<li> The <strong>output</strong> signals are computed from the sampled input signals.</li>
</ol>
<p>
A <strong>sampled data system</strong> may consist of components of package <strong>Discrete</strong>
and of every other purely <strong>algebraic</strong> input/output block, such
as the components of packages <strong>Modelica.Blocks.Math</strong>,
<strong>Modelica.Blocks.Nonlinear</strong> or <strong>Modelica.Blocks.Sources</strong>.
</p>

</html>", revisions="<html>
<ul>
<li><em>October 21, 2002</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New components TriggeredSampler and TriggeredMax added.</li>
<li><em>June 18, 2000</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized based on a corresponding library of Dieter Moormann and
       Hilding Elmqvist.</li>
</ul>
</html>"), Icon(graphics={
        Line(points={{-88,0},{-45,0}}, color={95,95,95}),
        Ellipse(
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-45,-10},{-25,10}}),
        Line(points={{-35,0},{24,52}}, color={95,95,95}),
        Ellipse(
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{25,-10},{45,10}}),
        Line(points={{45,0},{82,0}}, color={95,95,95})}));
end Discrete;
