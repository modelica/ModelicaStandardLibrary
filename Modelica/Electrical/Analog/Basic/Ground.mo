within Modelica.Electrical.Analog.Basic;
model Ground "Ground node"

  Interfaces.Pin p annotation (Placement(transformation(
        origin={0,100},
        extent={{10,-10},{-10,10}},
        rotation=270)));
equation
  p.v = 0;
  annotation (
    Documentation(info="<html>
<p>Ground of an electrical circuit. The potential at the ground node is zero. Every electrical circuit has to contain at least one ground object.</p>
</html>",
        revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{-60,50},{60,50}}, color={0,0,255}),
        Line(points={{-40,30},{40,30}}, color={0,0,255}),
        Line(points={{-20,10},{20,10}}, color={0,0,255}),
        Line(points={{0,90},{0,50}}, color={0,0,255}),
        Text(
          extent={{-150,-10},{150,-50}},
          textString="%name",
          textColor={0,0,255})}));
end Ground;
