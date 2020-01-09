within Modelica.Electrical.PowerConverters.ACAC;
model SinglePhaseTriac "Triode for alternating current"
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  Modelica.SIunits.Current i=p.i "Current flowing from pin p to pin n";
  parameter Modelica.SIunits.Resistance Ron(final min=0)=1e-5
    "Forward state-on differential resistance (closed resistance)";
  parameter Modelica.SIunits.Conductance Goff(final min=0)=1e-5
    "Backward state-off conductance (opened conductance)";
  parameter Modelica.SIunits.Voltage Vknee(final min=0)=0 "Forward threshold voltage";
  parameter Boolean useHeatPort = false "= true, if heatPort is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Modelica.SIunits.Temperature T=293.15
    "Fixed device temperature if useHeatPort = false"
    annotation(Dialog(enable=not useHeatPort));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
    "Conditional heat port"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.BooleanInput fire1 annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.BooleanInput fire2 annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor1(
    final Ron=Ron,
    final Goff=Goff,
    final Vknee=Vknee,
    final useHeatPort=useHeatPort,
    final T=T,
    off(fixed=true))
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor2(
    final Ron=Ron,
    final Goff=Goff,
    final Vknee=Vknee,
    final useHeatPort=useHeatPort,
    final T=T,
    off(fixed=true)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-40})));
equation
  connect(fire1, thyristor1.fire) annotation (Line(points={{-60,-120},{-60,60},{
          10,60},{10,52}}, color={255,0,255}));
  connect(fire2, thyristor2.fire) annotation (Line(points={{60,-120},{60,-60},{-10,
          -60},{-10,-52}}, color={255,0,255}));
  connect(thyristor1.heatPort, heatPort) annotation (Line(points={{0,30},{-20,30},
          {-20,-80},{0,-80},{0,-100}}, color={191,0,0}));
  connect(heatPort, thyristor2.heatPort) annotation (Line(points={{0,-100},{0,-80},
          {20,-80},{20,-30},{0,-30}}, color={191,0,0}));
  connect(p, thyristor1.p)
    annotation (Line(points={{-100,0},{-10,0},{-10,40}}, color={0,0,255}));
  connect(p, thyristor2.n)
    annotation (Line(points={{-100,0},{-10,0},{-10,-40}}, color={0,0,255}));
  connect(n, thyristor1.n)
    annotation (Line(points={{100,0},{10,0},{10,40}}, color={0,0,255}));
  connect(n, thyristor2.p)
    annotation (Line(points={{100,0},{10,0},{10,-40}}, color={0,0,255}));
  annotation (defaultComponentName="triac",
    Icon(graphics={
        Text(
          extent={{-150,110},{150,70}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{-40,70},{-40,-70}}, color={0,0,255}),
        Line(points={{40,70},{40,-72}}, color={0,0,255}),
        Polygon(points={{-40,70},{40,30},{-40,-10},{-40,70}},lineColor={0,0,
              255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(points={{40,8},{-40,-32},{40,-72},{40,8}},   lineColor={0,0,
              255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,0},{-90,0}}, color={0,0,255}),
        Line(points={{90,0},{40,0}}, color={0,0,255}),
        Line(points={{-60,-100},{-60,-10},{-40,0}}, color={0,0,255}),
        Line(points={{60,-100},{60,-10},{40,0}}, color={0,0,255}),
        Line(
          points={{-10,-5},{10,5},{10,5}},
          color={0,0,255},
          origin={50,-3},
          rotation=180),
        Line(
          points={{-10,-5},{10,5},{10,5}},
          color={0,0,255},
          origin={50,-7},
          rotation=180),
        Line(
          points={{-10,5},{10,-5},{10,-5}},
          color={0,0,255},
          origin={-50,-7},
          rotation=180),
        Line(
          points={{-10,5},{10,-5},{10,-5}},
          color={0,0,255},
          origin={-50,-3},
          rotation=180)}),
      Documentation(info="<html>
<p>
Simplified model of a triode for alternating current, built from two antiparallel thyristors. 
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
<li><code>fire1=false</code> and <code>fire2=true </code>: gate current &lt; 0, fire <code>thyristor2</code></li>
<li><code>fire1=true </code> and <code>fire2=true </code>: forbidden</li>
</ul>
</html>"));
end SinglePhaseTriac;
