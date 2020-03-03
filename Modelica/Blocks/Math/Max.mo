within Modelica.Blocks.Math;
block Max "Pass through the largest signal"
  extends Interfaces.SI2SO;
equation
  y = max(u1, u2);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Text(
          extent={{-90,36},{90,-36}},
          textColor={160,160,164},
          textString="max()")}), Documentation(info="<html>
<p>
This block computes the output <strong>y</strong> as <em>maximum</em>
of the two Real inputs <strong>u1</strong> and <strong>u2</strong>:
</p>
<blockquote><pre>
y = <strong>max</strong> ( u1 , u2 );
</pre></blockquote>
</html>"));
end Max;
