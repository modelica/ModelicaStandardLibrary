within Modelica.Mechanics.Rotational.UsersGuide;
class FlangeConnectors "Flange Connectors"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
A flange is described by the connector class
<strong><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.Flange_a\">Flange_a</a></strong>
or <strong><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.Flange_b\">Flange_b</a></strong>.
As already noted in section <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.Overview\">Overview</a>,
the two connector
classes are completely identical. There is only a difference in the icons,
in order to easier identify a flange variable in a diagram.
Both connector classes contain the following variables:
</p>
<blockquote><pre>
SI.Angle       phi  &quot;Absolute rotation angle of flange&quot;;
<strong>flow</strong> SI.Torque tau  &quot;Cut torque in the flange&quot;;
</pre></blockquote>

<p>
If needed, the angular velocity <code>w</code> and the
angular acceleration <code>a</code> of a flange connector can be
determined by differentiation of the flange angle <code>phi</code>:
</p>
<blockquote><pre>
w = <strong>der</strong>(phi);    a = <strong>der</strong>(w);
</pre></blockquote>
</html>"));

end FlangeConnectors;
