within Modelica.Blocks.Math;
block Edge "Indicates rising edge of Boolean signal"
  extends Interfaces.BooleanSISO;
equation
  y = edge(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Text(
          extent={{-90,36},{90,-36}},
          textColor={160,160,164},
          textString="edge()")}), Documentation(info="<html>
<p>
This block sets the Boolean output <strong>y</strong> to true,
when the Boolean input <strong>u</strong> shows a <em>rising edge</em>:
</p>
<blockquote><pre>
y = <strong>edge</strong>( u );
</pre></blockquote>
</html>"));
end Edge;
