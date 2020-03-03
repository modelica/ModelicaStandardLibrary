within Modelica.Blocks.Math;
block BooleanChange "Indicates Boolean signal changing"
  extends Interfaces.BooleanSISO;
equation
  y = change(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Text(
          extent={{-90,36},{90,-36}},
          textColor={160,160,164},
          textString="change()")}), Documentation(info="<html>
<p>
This block sets the Boolean output <strong>y</strong> to true, when the
Boolean input <strong>u</strong> shows a <em>rising or falling edge</em>,
i.e., when the signal changes:
</p>
<blockquote><pre>
y = <strong>change</strong>( u );
</pre></blockquote>
</html>"));
end BooleanChange;
