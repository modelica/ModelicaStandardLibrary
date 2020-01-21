within Modelica.Electrical.Machines.Losses;
model Friction "Model of angular velocity dependent friction losses"
  extends Machines.Interfaces.FlangeSupport;
  parameter FrictionParameters frictionParameters
    "Friction loss parameters";
  extends
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
equation
  if (frictionParameters.PRef <= 0) then
    tau = 0;
  else
    tau = -(if noEvent(abs(w)>frictionParameters.wLinear) then
      frictionParameters.tauRef*sign(w)*(abs(w)/frictionParameters.wRef)^frictionParameters.power_w else
      frictionParameters.tauLinear*w/frictionParameters.wLinear);
  end if;
  lossPower = -tau*w;
  annotation (Icon(graphics={
        Ellipse(
          extent={{-60,60},{60,-60}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-50,50},{50,-50}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-12,50},{8,30}},
          fillPattern=FillPattern.Sphere,
          fillColor={135,135,135}),
        Ellipse(
          extent={{-10,-30},{10,-50}},
          fillPattern=FillPattern.Sphere,
          fillColor={135,135,135}),
        Ellipse(
          extent={{24,-10},{44,-30}},
          fillPattern=FillPattern.Sphere,
          fillColor={135,135,135}),
        Ellipse(
          extent={{22,34},{42,14}},
          fillPattern=FillPattern.Sphere,
          fillColor={135,135,135}),
        Ellipse(
          extent={{-44,30},{-24,10}},
          fillPattern=FillPattern.Sphere,
          fillColor={135,135,135}),
        Ellipse(
          extent={{-44,-12},{-24,-32}},
          fillPattern=FillPattern.Sphere,
          fillColor={135,135,135}),
        Ellipse(
          extent={{-30,30},{30,-30}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,20},{20,-20}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          visible=useHeatPort,
          points={{-40,0},{-100,0},{-100,-90}},
          color={255,0,0}),
        Line(
          points={{0,90},{0,0}},
          color={95,95,95}),
        Line(
          points={{0,-60},{0,-90}},
          color={95,95,95}),
        Text(
          extent={{-150,90},{150,60}},
          textColor={0,0,255},
          textString="%name")}), Documentation(info="<html>
<p>
The friction losses are considered by the equations
</p>
<blockquote><pre>
  tau / tauRef = (+w / wRef) ^ power_w    for w &gt; +wLinear
- tau / tauRef = (-w / wRef) ^ power_w    for w &lt; -wLinear
</pre></blockquote>
<p>
with
</p>
<blockquote><pre>
tauRef * wRef = PRef
</pre></blockquote>
<p>
being the friction torque at the reference angular velocity
<code>wRef</code>. The exponent <code>power_w</code> is
approximately 1.5 for axial ventilation and approximately 2.0 for radial ventilation.
</p>
<p>
For stability reasons the friction torque <code>tau</code> is approximated by a linear curve
</p>
<blockquote><pre>
tau / tauLinear = w / wLinear
</pre></blockquote>
<p>
with
</p>
<blockquote><pre>
tauLinear = tauRef*(wLinear/wRef) ^ power_w
</pre></blockquote>
<p>
in the range <code> -wLinear &le; w &le; wLinear</code> with <code>wLinear = 0.001 * wRef</code>. The relationship of torque
and angular velocity is depicted in Fig. 1
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"1\">
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/frictiontorque.png\"
                alt=\"frictiontorque.png\"> </td>
  </tr>
  <tr><td> <strong> Fig. 1: </strong>Friction loss torque versus angular velocity for <code>power_w = 2</code></td>
  </tr>
</table>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.FrictionParameters\">FrictionParameters</a>
</p>
<p>
If it is desired to neglect friction losses, set <code>frictionParameters.PRef = 0</code> (this is the default).
</p>
</html>"));
end Friction;
