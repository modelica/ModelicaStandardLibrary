within Modelica.Electrical.Analog.Ideal;
model ControlledIdealOpeningSwitch "Controlled ideal electrical opener"
  parameter SI.Voltage level=0.5 "Switch level";
  extends Modelica.Electrical.Analog.Interfaces.IdealSwitch;
  Modelica.Electrical.Analog.Interfaces.Pin control
    "Control pin: control.v > level switch open, otherwise p--n connected"
    annotation (Placement(transformation(
        origin={0,100},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  off = control.v > level;
  control.i = 0;
  annotation (defaultComponentName="switch",
    Documentation(info="<html>
<p>
The switching behaviour of the controlled  ideal opening switch is controlled by the control pin: off = control.v &gt; level<br>
For further details, see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitch\">IdealSwitch</a>.
</p>
</html>",
        revisions="<html>
<ul>
<li><em>February 7, 2016   </em>
       by Anton Haumer<br> extending from partial IdealSwitch<br>
       </li>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{40,20},{40,0}}, color={0,0,255}),
        Line(
          visible=useHeatPort,
          points={{0,-100},{0,25}},
          color={127,0,0},
          pattern=LinePattern.Dot)}));
end ControlledIdealOpeningSwitch;
