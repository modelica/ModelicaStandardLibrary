within Modelica.Electrical.Machines.Utilities;
model SwitchYD "Y-D-switch"
  parameter Integer m=3 "Number of phases";
  parameter SIunits.Resistance Ron=1e-5 "Closed switch resistance";
  parameter SIunits.Conductance Goff=1e-5 "Opened switch conductance";
  parameter SIunits.Time delayTime(final min=0)=0 "Time delay";
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plugSupply(final m=
       m) "To grid" annotation (Placement(transformation(extent={{-10,90},{
            10,110}})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_sp(final m=m)
    "To positive stator plug" annotation (Placement(transformation(extent={
            {50,-90},{70,-110}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_sn(final m=m)
    "To negative stator plug" annotation (Placement(transformation(extent={
            {-70,-90},{-50,-110}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{20,-50},{40,-30}})));
  Modelica.Electrical.Polyphase.Basic.Delta delta(final m=m) annotation (
      Placement(transformation(extent={{40,-80},{20,-60}})));
  Polyphase.Ideal.IdealClosingSwitch idealCloser(
    final m=m,
    Ron=fill(Ron, m),
    Goff=fill(Goff, m))
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Blocks.Interfaces.BooleanInput control[m] annotation (Placement(
        transformation(extent={{-120,0},{-100,20}}), iconTransformation(extent={{-140,-20},{-100,20}})));
  Polyphase.Ideal.IdealOpeningSwitch idealOpener(
    final m=m,
    Ron=fill(Ron, m),
    Goff=fill(Goff, m))
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Blocks.Logical.LogicalDelay logicalDelay[m](delayTime=fill(delayTime, m))
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
equation
  connect(delta.plug_p, plugSupply) annotation (Line(points={{40,-70},{60,-70},
          {60,100},{0,100}}, color={0,0,255}));
  connect(delta.plug_p, plug_sp) annotation (Line(points={{40,-70},{60,-70},
          {60,-100}}, color={0,0,255}));
  connect(idealCloser.plug_p, plug_sn) annotation (Line(points={{-10,-70},{-60,-70},
          {-60,-100}}, color={0,0,255}));
  connect(idealCloser.plug_n, delta.plug_n)
    annotation (Line(points={{10,-70},{20,-70}}, color={0,0,255}));
  connect(idealOpener.plug_p, plug_sn)
    annotation (Line(points={{-60,-40},{-60,-100}}, color={0,0,255}));
  connect(idealOpener.plug_n, star.plug_p)
    annotation (Line(points={{-40,-40},{20,-40}}, color={0,0,255}));
  connect(control, logicalDelay.u)
    annotation (Line(points={{-110,10},{-82,10}}, color={255,0,255}));
  connect(logicalDelay.y1, idealOpener.control)
    annotation (Line(points={{-59,16},{-50,16},{-50,-28}}, color={255,0,255}));
  connect(logicalDelay.y2, idealCloser.control)
    annotation (Line(points={{-59,4},{0,4},{0,-58}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Line(
          points={{20,22},{40,12},{60,22},{40,12},{40,-10}},
          color={0,0,255}),
        Ellipse(
          extent={{-64,-16},{-56,-24}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-4,4},{4,-4}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-4,-36},{4,-44}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-2,-20},{-56,-20}}, color={0,0,255}),
        Line(points={{40,-62},{20,-30},{60,-30},{40,-62}}, color={0,0,255}),
        Line(points={{0,90},{0,88},{0,80},{80,80},{80,78},{80,-40},{60,-40}}, color={0,0,255}),
        Line(points={{4,0},{20,0}}, color={0,0,255}),
        Line(points={{4,-40},{20,-40}}, color={0,0,255}),
        Line(points={{-60,-24},{-60,-90}}, color={0,0,255}),
        Line(
          points={{-100,0},{-30,0},{-30,-20}},
          color={255,0,255},
          pattern=LinePattern.Dash),
        Line(points={{60,-90},{60,-40}}, color={0,0,255})}),
                            Documentation(info="<html>
Simple Star-Delta-switch.<br>
If <em>control</em> is false, plug_sp and plug_sn are star connected and plug_sp connected to the supply plug.<br>
If <em>control</em> is true, plug_sp and plug_sn are delta connected and they are connected to the supply plug.<br>
Note there is a delay between opening star connection and closing delta connection, respectively opening delta connection and closing star connection.
</html>"));
end SwitchYD;
