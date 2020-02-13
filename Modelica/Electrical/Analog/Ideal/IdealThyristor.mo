within Modelica.Electrical.Analog.Ideal;
model IdealThyristor "Ideal thyristor"
  extends Modelica.Electrical.Analog.Interfaces.IdealSemiconductor;
  Modelica.Blocks.Interfaces.BooleanInput fire annotation (Placement(
        transformation(
        origin={100,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,120})));
equation
  off = s < 0 or pre(off) and not fire;
  annotation (defaultComponentName="thyristor",
    Documentation(info="<html>
<p>
This is an ideal thyristor, for details see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSemiconductor\">IdealSemiconductor</a><br>
The thyristor is conducting if voltage &gt; Vknee AND fire = true.<br>
If fire gets false, the current has to fall below Vknee*Goff, then the thyristor gets locking.</p>
</html>",
        revisions="<html>
<ul>
<li><em>February 7, 2016   </em>
       by Anton Haumer<br> extending from partial IdealSemiconductor<br>
       </li>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>Mai 7, 2004   </em>
       by Christoph Clauss and Anton Haumer<br> Vknee added<br>
       </li>
<li><em>some years ago   </em>
       by Christoph Clauss<br> realized<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(
          visible=useHeatPort,
          points={{0,-100},{0,-20}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Line(points={{30,20},{60,50}}, color={0,0,255}),
        Line(
          points={{100,100},{100,90},{60,50}},
          color={255,0,255},
          pattern=LinePattern.Dash)}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
                                 Line(
            points={{20,10},{70,40}},
            thickness=0.5)}));
end IdealThyristor;
