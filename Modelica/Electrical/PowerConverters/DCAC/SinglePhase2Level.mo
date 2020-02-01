within Modelica.Electrical.PowerConverters.DCAC;
model SinglePhase2Level "Single-phase DC to AC converter"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Resistance RonTransistor=1e-05
    "Transistor closed resistance";
  parameter SI.Conductance GoffTransistor=1e-05
    "Transistor opened conductance";
  parameter SI.Voltage VkneeTransistor=0
    "Transistor threshold voltage";
  parameter SI.Resistance RonDiode=1e-05
    "Diode closed resistance";
  parameter SI.Conductance GoffDiode=1e-05
    "Diode opened conductance";
  parameter SI.Voltage VkneeDiode=0 "Diode threshold voltage";
  // parameter Boolean useEnable "Enables enable signal connector";
  extends PowerConverters.Interfaces.DCAC.DCtwoPin;
  extends PowerConverters.Interfaces.DCAC.ACpin;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
       293.15);
  extends Interfaces.Enable.Enable2;
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistor_p(
    final Ron=RonTransistor,
    final Goff=GoffTransistor,
    final Vknee=VkneeTransistor,
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={30,20})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode_p(
    final Ron=RonDiode,
    final Goff=GoffDiode,
    final Vknee=VkneeDiode,
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,20})));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistor_n(
    final Ron=RonTransistor,
    final Goff=GoffTransistor,
    final Vknee=VkneeTransistor,
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={30,-20})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode_n(
    final Ron=RonDiode,
    final Goff=GoffDiode,
    final Vknee=VkneeDiode,
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,-20})));
equation
  if not useHeatPort then
    LossPower = transistor_p.LossPower + diode_n.LossPower + transistor_n.LossPower
       + diode_n.LossPower;
  end if;
  connect(transistor_p.p, dc_p) annotation (Line(
      points={{30,30},{50,30},{50,60},{-100,60},{-100,60}}, color={0,0,255}));
  connect(transistor_n.n, dc_n) annotation (Line(
      points={{30,-30},{50,-30},{50,-60},{-100,-60},{-100,-60}}, color={0,0,255}));
  connect(transistor_p.p, diode_p.n) annotation (Line(
      points={{30,30},{70,30}}, color={0,0,255}));
  connect(transistor_p.n, diode_p.p) annotation (Line(
      points={{30,10},{70,10}}, color={0,0,255}));
  connect(transistor_n.p, diode_n.n) annotation (Line(
      points={{30,-10},{70,-10}}, color={0,0,255}));
  connect(transistor_n.n, diode_n.p) annotation (Line(
      points={{30,-30},{70,-30}}, color={0,0,255}));
  connect(transistor_p.n, transistor_n.p) annotation (Line(
      points={{30,10},{50,10},{50,-10},{30,-10}}, color={0,0,255}));
  connect(ac, transistor_p.n) annotation (Line(
      points={{100,0},{50,0},{50,10},{30,10}}, color={0,0,255}));
  connect(transistor_p.heatPort, heatPort) annotation (Line(
      points={{40,20},{40,0},{0,0},{0,-100}}, color={191,0,0}));
  connect(transistor_n.heatPort, heatPort) annotation (Line(
      points={{40,-20},{40,-40},{0,-40},{0,-100}}, color={191,0,0}));
  connect(diode_p.heatPort, heatPort) annotation (Line(
      points={{80,20},{80,-40},{0,-40},{0,-100}}, color={191,0,0}));
  connect(diode_n.heatPort, heatPort) annotation (Line(
      points={{80,-20},{80,-40},{0,-40},{0,-100}}, color={191,0,0}));
  connect(andCondition_p.y, transistor_p.fire) annotation (Line(
      points={{-60,-69},{-60,10},{18,10}}, color={255,0,255}));
  connect(andCondition_n.y, transistor_n.fire) annotation (Line(
      points={{60,-69},{60,-50},{10,-50},{10,-30},{18,-30}}, color={255,0,255}));
  annotation (defaultComponentName="inverter",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Line(
          points={{-100,-100},{100,100}},
          color={0,0,127}),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-20,20},{-20,-20}},
          color={0,0,255}),
        Line(
          points={{-28,20},{-28,-20}},
          color={0,0,255}),
        Line(
          points={{-40,0},{-28,0}},
          color={0,0,255}),
        Line(
          points={{-20,4},{0,24},{0,40}},
          color={0,0,255}),
        Line(
          points={{-20,-4},{0,-24},{0,-40}},
          color={0,0,255}),
        Line(
          points={{-4,-20},{-10,-8},{-16,-14},{-4,-20}},
          color={0,0,255}),
        Line(
          points={{0,-24},{10,-24},{10,24},{0,24}},
          color={0,0,255}),
        Line(
          points={{0,8},{20,8}},
          color={0,0,255}),
        Line(
          points={{10,8},{0,-8},{20,-8},{10,8}},
          color={0,0,255}),
        Text(
          extent={{-100,70},{0,50}},
          textColor={0,0,255},
          textString="DC"),
        Text(
          extent={{0,-50},{100,-70}},
          textColor={0,0,255},
          textString="AC")}),
    Documentation(info="<html>
<p>
This is a single-phase two level inverter. The boolean signals <code>fire_p</code> and <code>fire_n</code> shall not be <code>true</code> at the same time to avoid DC bus short circuits. The inverter consists of two transistors and two anti parallel free wheeling diodes.
</p>

<p>
An example of a single-phase inverter with PWM voltage control is included in
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.DCAC.SinglePhaseTwoLevel\">Examples.DCAC.SinglePhaseTwoLevel</a>.
</p>
</html>"));
end SinglePhase2Level;
