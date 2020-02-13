within Modelica.Electrical.Analog.Ideal;
model IdealClosingSwitch "Ideal electrical closer"
  extends Modelica.Electrical.Analog.Interfaces.IdealSwitch;
  Modelica.Blocks.Interfaces.BooleanInput control
    "true => p--n connected, false => switch open" annotation (Placement(
        transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  off = not control;
  annotation (defaultComponentName="switch",
    Documentation(info="<html>
<p>
The switching behaviour of the ideal closing switch is controlled by the input signal control: off = not control.<br>
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
        Line(
          visible=useHeatPort,
          points={{0,-100},{0,25}},
          color={127,0,0},
          pattern=LinePattern.Dot)}));
end IdealClosingSwitch;
