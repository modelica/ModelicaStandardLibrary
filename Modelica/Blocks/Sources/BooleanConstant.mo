within Modelica.Blocks.Sources;
block BooleanConstant "Generate constant signal of type Boolean"
  parameter Boolean k=true "Constant output value"
  annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/BooleanConstant.png"));
  extends Interfaces.partialBooleanSource;

equation
  y = k;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Line(points={{-80,0},{80,0}}),
          Text(
          extent={{-150,-140},{150,-110}},
          textString="%k")}),
      Documentation(info="<html>
<p>
The Boolean output y is a constant signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanConstant.png\"
     alt=\"BooleanConstant.png\">
</p>
</html>"));
end BooleanConstant;
