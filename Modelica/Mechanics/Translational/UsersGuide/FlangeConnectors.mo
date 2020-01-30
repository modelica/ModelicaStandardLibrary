within Modelica.Mechanics.Translational.UsersGuide;
class FlangeConnectors "Flange Connectors"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
A flange is described by the connector class
<strong><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.Flange_a\">Flange_a</a></strong>
or <strong><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.Flange_b\">Flange_b</a></strong>.
As already noted in section <a href=\"modelica://Modelica.Mechanics.Translational.UsersGuide.Overview\">Overview</a>,
the two connector
classes are completely identical. There is only a difference in the icons,
in order to easier identify a flange variable in a diagram.
Both connector classes contain the following variables:
</p>
<blockquote><pre>
SI.Position   s &quot;Absolute position of flange&quot;;
<strong>flow</strong> SI.Force f &quot;Cut force directed into flange&quot;;
</pre></blockquote>

<p>
If needed, the velocity <code>v</code> and the
acceleration <code>a</code> of a flange connector can be
determined by differentiation of the flange position <code>s</code>:
</p>
<blockquote><pre>
v = <strong>der</strong>(s);    a = <strong>der</strong>(v);
</pre></blockquote>
</html>"));

end FlangeConnectors;
