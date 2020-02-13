within Modelica.Electrical.Analog.Ideal;
model OpenerWithArc "Ideal opening switch with simple arc model"
  extends Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc;
  Modelica.Blocks.Interfaces.BooleanInput control
    "false => p--n connected, true => switch open" annotation (Placement(
        transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  off = control;
  annotation (defaultComponentName="switch",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{40,20},{40,0}}, color={0,0,255}),
        Line(points={{40,40},{32,30},{48,26},{40,20}}, color={255,0,0})}),
    Documentation(info="<html>
<p>
This model is an extension to the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch\">IdealOpeningSwitch</a>.
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
<li><em>June, 2009   </em>
       by Christoph Clauss<br> adapted to OpenerWithArc<br>
       </li>
<li><em>May, 2009   </em>
       by Anton Haumer<br> CloserWithArc initially implemented<br>
       </li>
</ul>
</html>"));
end OpenerWithArc;
