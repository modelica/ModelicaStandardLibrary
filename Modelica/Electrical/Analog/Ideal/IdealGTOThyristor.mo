within Modelica.Electrical.Analog.Ideal;
model IdealGTOThyristor "Ideal GTO thyristor"
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
  off = s < 0 or not fire;
  annotation (defaultComponentName="gto",
    Documentation(info="<html>
<p>
This is an ideal GTO thyristor or switching transistor, for details see partial model <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSemiconductor\">IdealSemiconductor</a><br>
The GTO thyristor is conducting if voltage &gt; Vknee AND fire = true.<br>
Otherwise, the GTO thyristor is locking.
</p>
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
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{48,52},{64,36}}, color={0,0,255}),
        Line(
          visible=useHeatPort,
          points={{0,-100},{0,-20}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Polygon(
          points={{42,45},{42,38},{49,38},{42,45}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),
        Polygon(
          points={{46,33},{53,33},{53,26},{46,33}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),
        Line(points={{30,10},{60,40}}, color={0,0,255}),
        Line(points={{30,26},{52,48}}, color={0,0,255}),
        Line(
          points={{100,100},{100,88},{62,50}},
          color={255,0,255},
          pattern=LinePattern.Dash),
        Line(
          points={{58,44}},
          color={255,0,255},
          pattern=LinePattern.Dash),
        Line(points={{62,50},{56,44}}, color={0,0,255})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
                                 Line(
            points={{20,10},{70,40}},
            thickness=0.5)}));
end IdealGTOThyristor;
