within Modelica.Blocks.Logical;
block RSFlipFlop "A basic RS Flip Flop"
  extends Modelica.Blocks.Icons.PartialBooleanBlock;
  parameter Boolean Qini=false "Start value of Q at initial time";
  Modelica.Blocks.Interfaces.BooleanOutput Q annotation (Placement(
        transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput QI annotation (Placement(
        transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Logical.Nor nor annotation (Placement(transformation(extent=
           {{-20,20},{0,40}})));
  Modelica.Blocks.Logical.Nor nor1 annotation (Placement(transformation(
          extent={{-20,-20},{0,0}})));
  Modelica.Blocks.Logical.Pre pre(pre_u_start=not (Qini)) annotation (
      Placement(transformation(extent={{10,20},{30,40}})));
  Modelica.Blocks.Interfaces.BooleanInput S
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.BooleanInput R
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
equation
  connect(nor1.y, nor.u2) annotation (Line(points={{1,-10},{40,-10},{40,-40},
          {-60,-40},{-60,22},{-22,22}}, color={255,0,255}));
  connect(nor1.y, Q) annotation (Line(points={{1,-10},{60,-10},{60,60},{110,
          60}}, color={255,0,255}));
  connect(nor.y, pre.u)
    annotation (Line(points={{1,30},{8,30}}, color={255,0,255}));
  connect(pre.y, nor1.u1) annotation (Line(points={{31,30},{40,30},{40,10},{-40,
          10},{-40,-10},{-22,-10}}, color={255,0,255}));
  connect(pre.y, QI) annotation (Line(points={{31,30},{80,30},{80,-60},{110,-60}}, color={255,0,255}));
  connect(S, nor.u1) annotation (Line(
      points={{-120,60},{-40,60},{-40,30},{-22,30}}, color={255,0,255}));
  connect(R, nor1.u2) annotation (Line(
      points={{-120,-60},{-40,-60},{-40,-18},{-22,-18}}, color={255,0,255}));
annotation (
  Icon(graphics={
      Text(
        extent={{-60,-30},{-20,-90}},
        textString="R"),
      Text(
        extent={{-62,90},{-22,30}},
        textString="S"),
      Text(
        extent={{20,90},{60,30}},
        textString="Q"),
      Text(
        extent={{6,-30},{66,-90}},
        textString="Q!"),
      Ellipse(
        extent={{-73,54},{-87,68}},
        lineColor=DynamicSelect({235,235,235}, if S then {0,255,0} else {235,235,235}),
        fillColor=DynamicSelect({235,235,235}, if S then {0,255,0} else {235,235,235}),
        fillPattern=FillPattern.Solid),
      Ellipse(
        extent={{83,-53},{69,-67}},
        lineColor=DynamicSelect({235,235,235}, if QI then {0,255,0} else {235,235,235}),
        fillColor=DynamicSelect({235,235,235}, if QI then {0,255,0} else {235,235,235}),
        fillPattern=FillPattern.Solid),
      Ellipse(
        extent={{-71,-52},{-85,-66}},
        lineColor=DynamicSelect({235,235,235}, if R then {0,255,0} else {235,235,235}),
        fillColor=DynamicSelect({235,235,235}, if R then {0,255,0} else {235,235,235}),
        fillPattern=FillPattern.Solid),
      Ellipse(
        extent={{71,67},{85,53}},
        lineColor=DynamicSelect({235,235,235}, if Q then {0,255,0} else {235,235,235}),
        fillColor=DynamicSelect({235,235,235}, if Q then {0,255,0} else {235,235,235}),
        fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
The output <code>Q</code> is set by the input <code>S</code>, is reset by the input <code>R</code>, and keeps its value in between. <code>QI</code> is the inverse of <code>Q</code>.
</p>
</html>"));
end RSFlipFlop;
