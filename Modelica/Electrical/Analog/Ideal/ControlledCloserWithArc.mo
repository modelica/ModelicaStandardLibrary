within Modelica.Electrical.Analog.Ideal;
model ControlledCloserWithArc
  "Controlled ideal electrical closer with simple arc model"
  parameter SI.Voltage level=0.5 "Switch level";
  extends Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc;
  Modelica.Electrical.Analog.Interfaces.Pin control
    "Control pin: control.v > level switch closed, otherwise switch open"
    annotation (Placement(transformation(
        origin={0,100},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  off = control.v < level;
  control.i = 0;
  annotation (defaultComponentName="switch",
    Documentation(info="<html>
<p>
This model is an extension to the <a href=\"modelica:/Modelica.Electrical.Analog.Ideal.ControlledIdealClosingSwitch\">ControlledIdealClosingSwitch</a>.
</p>
<p>
For details of the arc effect, see partial model <a href=\"modelica:/Modelica.Electrical.Analog.Interfaces.IdealSwitchWithArc\">IdealSwitchWithArc</a>.
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
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{40,40},{34,16},{48,24},{40,0}}, color={255,0,0})}));
end ControlledCloserWithArc;
