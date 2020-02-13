within Modelica.Electrical.Analog.Ideal;
model CloserWithArc "Ideal closing switch with simple arc model"
  extends Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc;
  Modelica.Blocks.Interfaces.BooleanInput control
    "true => p--n connected, false => switch open" annotation (Placement(
        transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  off = not control;
  annotation (defaultComponentName="switch",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{40,40},{32,14},{48,22},{40,0}}, color={255,0,0})}),
    Documentation(info="<html>
<p>
This model is an extension to the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealClosingSwitch\">IdealClosingSwitch</a>.
</p>
<p>
For details of the arc effect, see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc\">IdealSwitchWithArc</a>.
</p>
</html>",
        revisions="<html>
<ul>
<li><em>February 7, 2016   </em>
       by Anton Haumer<br> extending from partial IdealSwitchWithArc<br>
       </li>
<li><em>May, 2009   </em>
       by Anton Haumer<br> initially implemented<br>
       </li>
</ul>
</html>"));
end CloserWithArc;
