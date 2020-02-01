within Modelica.Electrical.PowerConverters.ACAC;
model PolyphaseTriac "Triodes for alternating current"
  extends Modelica.Electrical.Polyphase.Interfaces.TwoPlug;
  parameter SI.Resistance Ron(final min=0)=1e-5
    "Forward state-on differential resistance (closed resistance)";
  parameter SI.Conductance Goff(final min=0)=1e-5
    "Backward state-off conductance (opened conductance)";
  parameter SI.Voltage Vknee(final min=0)=0 "Forward threshold voltage";
  extends Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort(final mh=m);
  Modelica.Blocks.Interfaces.BooleanInput fire1[m] annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.BooleanInput fire2[m] annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Modelica.Electrical.Polyphase.Basic.PlugToPins_p plugToPins_p(final m=m)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPins_n plugToPins_n(final m=m)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  SinglePhaseTriac triac[m](each useHeatPort=useHeatPort)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(plug_p, plugToPins_p.plug_p)
    annotation (Line(points={{-100,0},{-82,0}}, color={0,0,255}));
  connect(plugToPins_n.plug_n, plug_n)
    annotation (Line(points={{82,0},{100,0}},               color={0,0,255}));
  connect(triac.heatPort, heatPort)
    annotation (Line(points={{0,-10},{0,-100}}, color={191,0,0}));
  connect(fire1, triac.fire1) annotation (Line(points={{-60,-120},{-60,-20},{-6,
          -20},{-6,-12}}, color={255,0,255}));
  connect(fire2, triac.fire2) annotation (Line(points={{60,-120},{60,-20},{6,-20},
          {6,-12}}, color={255,0,255}));
  connect(plugToPins_p.pin_p, triac.p)
    annotation (Line(points={{-78,0},{-10,0}}, color={0,0,255}));
  connect(triac.n, plugToPins_n.pin_n)
    annotation (Line(points={{10,0},{78,0}}, color={0,0,255}));
  annotation (defaultComponentName="triac",
    Icon(graphics={
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-60,-100},{-60,-40},{-40,-30}},
                                                    color={255,0,255}),
        Line(points={{60,-100},{60,20},{40,30}}, color={255,0,255}),
        Line(points={{-40,-70},{-40,70}}, color={0,0,255}),
        Line(points={{40,-72},{40,70}}, color={0,0,255}),
        Polygon(points={{-40,-70},{40,-30},{-40,10},{-40,-70}},
                                                             lineColor={0,0,
              255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(points={{40,-10},{-40,30},{40,70},{40,-10}}, lineColor={0,0,
              255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,0},{-90,0}}, color={0,0,255}),
        Line(points={{90,0},{40,0}}, color={0,0,255})}),
      Documentation(info="<html>
<p>
Simplified model of <code>m</code>
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.SinglePhaseTriac\">triodes for alternating current</a>, each built from two antiparallel thyristors.
<code>thyristor1</code> has to be fired during the positive halfwave of the voltage.
<code>thyristor2</code> has to be fired during the negative halfwave of the voltage.
</p>
<p>
Note: A real triac is fired in positive direction (<code>thyristor1</code>) by a positive gate current and in negative direction (<code>thyristor2</code>) by a negative gate current.
The triac goes in blocking condition when the current falls to zero.
</p>
<p>
This behaviour is simulated by the two firing gates <code>fire1</code> and <code>fire2</code>:
</p>
<ul>
<li><code>fire1=false</code> and <code>fire2=false</code>: gate current = 0, stay in blocking condition</li>
<li><code>fire1=true </code> and <code>fire2=false</code>: gate current &gt; 0, fire <code>thyristor1</code></li>
<li><code>fire1=false</code> and <code>fire2=true</code>: gate current &lt; 0, fire <code>thyristor2</code></li>
<li><code>fire1=true </code> and <code>fire2=true</code>: forbidden</li>
</ul>
</html>"));
end PolyphaseTriac;
