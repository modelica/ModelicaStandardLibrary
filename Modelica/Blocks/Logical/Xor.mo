within Modelica.Blocks.Logical;
block Xor "Logical 'xor': y = u1 xor u2"
  extends Blocks.Interfaces.partialBooleanSI2SO;
equation
  y = not ((u1 and u2) or (not u1 and not u2));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Text(
          extent={{-90,40},{90,-40}},
          textString="xor")}), Documentation(info="<html>
<p>
The output is <strong>true</strong> if exactly one input is <strong>true</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
end Xor;
