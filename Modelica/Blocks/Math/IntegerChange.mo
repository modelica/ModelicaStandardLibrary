within Modelica.Blocks.Math;
block IntegerChange "Indicates integer signal changing"
  extends Interfaces.IntegerSIBooleanSO;
equation
  y = change(u);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Text(
          extent={{-90,36},{90,-36}},
          textColor={160,160,164},
          textString="change()")}), Documentation(info="<html>
<p>
This block sets the Boolean output <strong>y</strong> to true, when the
Integer input <strong>u</strong> changes:
</p>
<blockquote><pre>
y = <strong>change</strong>( u );
</pre></blockquote>
</html>"));
end IntegerChange;
