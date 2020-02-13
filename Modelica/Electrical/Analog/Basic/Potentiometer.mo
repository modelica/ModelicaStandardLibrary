within Modelica.Electrical.Analog.Basic;
model Potentiometer "Adjustable resistor"
  parameter SI.Resistance R(start=1)
    "Resistance at temperature T_ref";
  parameter SI.Temperature T_ref=293.15 "Reference temperature";
  parameter SI.LinearTemperatureCoefficient alpha=0
    "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(T_heatPort - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  parameter Boolean useRinput=false "Use input for 0<r<1 (else constant)"
    annotation (
    Evaluate=true,
    HideResult=true,
    Dialog(group="potentiometer"));
  parameter Real rConstant(
    final min=0,
    final max=1) = 0.5 "Contact between n (r=0) and p (r=1)"
    annotation (Dialog(group="potentiometer", enable=not useRinput));
  SI.Resistance Rp
    "Actual resistance between pin_p and contact";
  SI.Resistance Rn
    "Actual resistance between contact and pin_n";
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin contact annotation (
      Placement(transformation(extent={{90,-110},{110,-90}}),
        iconTransformation(extent={{90,-110},{110,-90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput r if useRinput annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,-120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,-120})));
protected
  Modelica.Blocks.Sources.Constant rConst(final k=rConstant) if not useRinput
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,-50})));
  Modelica.Blocks.Interfaces.RealInput rInt
    annotation (Placement(transformation(extent={{-84,-84},{-76,-76}})));
equation
  pin_p.i + pin_n.i + contact.i = 0;
  Rp = R*(1 + alpha*(T_heatPort - T_ref))*(1 - min(1, max(0, rInt)));
  Rn = R*(1 + alpha*(T_heatPort - T_ref))*min(1, max(0, rInt));
  pin_p.v - contact.v = Rp*pin_p.i;
  pin_n.v - contact.v = Rn*pin_n.i;
  LossPower = (pin_p.v - contact.v)*pin_p.i + (pin_n.v - contact.v)*pin_n.i;
  connect(rInt, r) annotation (Line(
      points={{-80,-80},{-100,-80},{-100,-120}}, color={0,0,127}));
  connect(rInt, rConst.y) annotation (Line(
      points={{-80,-80},{-90,-80},{-90,-61}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-70,30},{70,-30}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-90,0},{-70,0}},
          color={0,0,255}),
        Line(
          points={{70,0},{90,0}},
          color={0,0,255}),
        Line(
          visible=useHeatPort,
          points={{0,-100},{0,-30}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{0,40},{0,-40},{100,-80},{100,-90}},
          color={0,0,255}),
        Line(
          visible=useRinput,
          points={{-100,-90},{-100,-80},{0,-40}},
          color={0,0,255},
          pattern=LinePattern.Dot),
        Line(
          visible=useHeatPort,
          points={{0,-90},{0,-40}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Polygon(
          points={{0,-30},{-4,-40},{4,-40},{0,-30}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
                       <p>This models a potentiometer where the sliding contact is placed between pin_n (r = 0) and pin_p (r = 1), dependent on either the parameter rConstant or the signal input r.</p>
                       <p>The total resistance R is temperature dependent.</p>
                       </html>"));
end Potentiometer;
