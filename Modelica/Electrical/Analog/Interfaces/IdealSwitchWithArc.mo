within Modelica.Electrical.Analog.Interfaces;
partial model IdealSwitchWithArc "Ideal switch with simple arc model"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter SI.Resistance Ron=1E-5 "Closed switch resistance";
  parameter SI.Conductance Goff=1E-5
    "Opened switch conductance";
  parameter SI.Voltage V0(start=30) "Initial arc voltage";
  parameter SI.VoltageSlope dVdt(start=10E3)
    "Arc voltage slope";
  parameter SI.Voltage Vmax(start=60) "Max. arc voltage";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
  Boolean off(start=true) "Indicates off-state (but maybe not quenched)";
protected
  Boolean quenched(start=true, fixed=true)
    "Indicating quenched arc (if switch is off)";
  discrete SI.Time tSwitch(start=-Modelica.Constants.inf, fixed=true)
    "Last switch off time instant";
equation
  when edge(off) then
    tSwitch = time;
  end when;
  quenched = off and (abs(i) <= abs(v)*Goff or pre(quenched));
  if off then
    if quenched then
      i = Goff*v;
    else
      v = min(Vmax, V0 + dVdt*(time - tSwitch))*sign(i);
    end if;
  else
    v = Ron*i;
  end if;
  LossPower = v*i;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
        Line(points={{-90,0},{-44,0}}, color={0,0,255}),
        Line(points={{-37,2},{40,40}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}),
    Diagram(graphics={Line(points={{-60,60},{-60,-60},{60,-60}}, color={0,0,255}),
          Line(points={{-60,-60},{-40,-60},{-40,-40},{-20,40},{40,40}}),Text(
            extent={{30,-60},{50,-70}},
            textString="time"),Text(
            extent={{-60,60},{-20,50}},
            textString="voltage"),Text(
            extent={{-60,-30},{-40,-40}},
            textString="V0"),Text(
            extent={{-50,40},{-30,30}},
            textString="Vmax"),Text(
            extent={{-40,10},{-20,0}},
            textString="dVdt"),Polygon(
            points={{-60,60},{-62,52},{-58,52},{-60,60}},
            fillPattern=FillPattern.Solid),Polygon(
            points={{60,-60},{54,-58},{54,-62},{60,-60}},
            fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This model is an extension to the <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSwitch\">IdealSwitch</a>.
</p>
<p>
The basic model interrupts the current through the switch in an infinitesimal time span.
If an inductive circuit is connected, the voltage across the switch is limited only by numerics.
In order to give a better idea for the voltage across the switch, a simple arc model is added:
</p>
<p>
When the Boolean variable <code>off</code> signals to open the switch, a voltage across the opened switch is impressed.
This voltage starts with <code>V0</code> (simulating the voltage drop of the arc roots), then rising with slope <code>dVdt</code>
(simulating the rising voltage of an extending arc) until a maximum voltage <code>Vmax</code> is reached.
</p>
<blockquote><pre>
     | voltage
Vmax |      +-----
     |     /
     |    /
V0   |   +
     |   |
     +---+-------- time
</pre></blockquote>
<p>
This arc voltage tends to lower the current following through the switch; it depends on the connected circuit, when the arc is quenched.
Once the arc is quenched, i.e., the current flowing through the switch gets zero, the equation for the off-state is activated
<code>i=Goff*v</code>.
</p>
<p>
When the Boolean variable <code>off</code> signals to close the switch again, the switch is closed immediately,
i.e., the equation for the on-state is activated <code>v=Ron*i</code>.
</p>
<p>
Please note: In an AC circuit, at least the arc quenches when the next natural zero-crossing of the current occurs.
In a DC circuit, the arc will not quench if the arc voltage is not sufficient that a zero-crossing of the current occurs.
<br><br>
<strong>Please note:</strong>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <strong>not</strong> modelled. The parameters are not temperature dependent.
</p>
</html>",
        revisions="<html>
<ul>
<li><em>June, 2009   </em>
       by Christoph Clauss<br> adapted to OpenerWithArc<br>
       </li>
<li><em>May, 2009   </em>
       by Anton Haumer<br> CloserWithArc initially implemented<br>
       </li>
</ul>
</html>"));
end IdealSwitchWithArc;
