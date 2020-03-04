within Modelica.Blocks.Logical;
block Nand "Logical 'nand': y = not (u1 and u2)"
  extends Blocks.Interfaces.partialBooleanSI2SO;
equation
  y = not (u1 and u2);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Text(
          extent={{-90,40},{90,-40}},
          textString="nand")}), Documentation(info="<html>
<p>
The output is <strong>true</strong> if at least one input is <strong>false</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
end Nand;
