within Modelica.Electrical.PowerConverters.DCAC;
model Polyphase2Level "Polyphase DC to AC converter"
  extends Modelica.Blocks.Icons.Block;
  extends Interfaces.Enable.Enable2m;
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
  extends PowerConverters.Interfaces.DCAC.ACplug;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
       293.15);
  Modelica.Electrical.Polyphase.Ideal.IdealGTOThyristor transistor_p(
    final m=m,
    final Ron=fill(RonTransistor, m),
    final Goff=fill(GoffTransistor, m),
    final Vknee=fill(VkneeTransistor, m),
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={30,20})));
  Modelica.Electrical.Polyphase.Ideal.IdealDiode diode_p(
    final m=m,
    final Ron=fill(RonDiode, m),
    final Goff=fill(GoffDiode, m),
    final Vknee=fill(VkneeDiode, m),
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,20})));
  Modelica.Electrical.Polyphase.Basic.Star star_p(final m=m) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={50,50})));
  Modelica.Electrical.Polyphase.Ideal.IdealGTOThyristor transistor_n(
    final m=m,
    final Ron=fill(RonTransistor, m),
    final Goff=fill(GoffTransistor, m),
    final Vknee=fill(VkneeTransistor, m),
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={30,-20})));
  Modelica.Electrical.Polyphase.Ideal.IdealDiode diode_n(
    final m=m,
    final Ron=fill(RonDiode, m),
    final Goff=fill(GoffDiode, m),
    final Vknee=fill(VkneeDiode, m),
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,-20})));
  Modelica.Electrical.Polyphase.Basic.Star star_n(final m=m) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={50,-50})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermalCollector(final m=m) if useHeatPort
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
equation
  if not useHeatPort then
    LossPower = sum(transistor_p.idealGTOThyristor.LossPower) + sum(diode_n.idealDiode.LossPower)
       + sum(transistor_n.idealGTOThyristor.LossPower) + sum(diode_n.idealDiode.LossPower);
  end if;
  connect(transistor_p.plug_p, star_p.plug_p) annotation (Line(
      points={{30,30},{50,30},{50,40}}, color={0,0,255}));
  connect(star_p.plug_p, diode_p.plug_n) annotation (Line(
      points={{50,40},{50,30},{70,30}}, color={0,0,255}));
  connect(transistor_n.plug_n, star_n.plug_p) annotation (Line(
      points={{30,-30},{50,-30},{50,-40}}, color={0,0,255}));
  connect(star_n.plug_p, diode_n.plug_p) annotation (Line(
      points={{50,-40},{50,-30},{70,-30}}, color={0,0,255}));
  connect(transistor_p.plug_n, diode_p.plug_p) annotation (Line(
      points={{30,10},{70,10}}, color={0,0,255}));
  connect(transistor_n.plug_p, diode_n.plug_n) annotation (Line(
      points={{30,-10},{70,-10}}, color={0,0,255}));
  connect(star_n.pin_n, dc_n) annotation (Line(
      points={{50,-60},{50,-66},{-100,-66},{-100,-60}},  color={0,0,255}));
  connect(dc_p, star_p.pin_n) annotation (Line(
      points={{-100,60},{-100,70},{50,70},{50,60}},  color={0,0,255}));
  connect(transistor_p.plug_n, ac) annotation (Line(
      points={{30,10},{50,10},{50,0},{100,0}}, color={0,0,255}));
  connect(transistor_n.plug_p, ac) annotation (Line(
      points={{30,-10},{50,-10},{50,0},{100,0}}, color={0,0,255}));
  connect(heatPort, thermalCollector.port_b) annotation (Line(
      points={{0,-100},{0,-60}}, color={191,0,0}));
  connect(thermalCollector.port_a, transistor_n.heatPort) annotation (Line(
      points={{0,-40},{0,-36},{40,-36},{40,-20}}, color={191,0,0}));
  connect(diode_n.heatPort, thermalCollector.port_a) annotation (Line(
      points={{80,-20},{80,-36},{0,-36},{0,-40}}, color={191,0,0}));
  connect(transistor_p.heatPort, thermalCollector.port_a) annotation (Line(
      points={{40,20},{40,4},{0,4},{0,-40}}, color={191,0,0}));
  connect(diode_p.heatPort, thermalCollector.port_a) annotation (Line(
      points={{80,20},{80,4},{0,4},{0,-40}}, color={191,0,0}));
  connect(andCondition_p.y, transistor_p.fire) annotation (Line(
      points={{-60,-69},{-60,10},{18,10}}, color={255,0,255}));
  connect(andCondition_n.y, transistor_n.fire) annotation (Line(
      points={{60,-69},{60,-64},{16,-64},{16,-30},{18,-30}}, color={255,0,255}));
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
This is a polyphase two level inverter. The boolean signals <code>fire_p[k]</code> and <code>fire_n[k]</code> for any phase <code>k</code> shall not be <code>true</code> at the same time to avoid DC bus short circuits. The inverter consists of <code>2*m</code> transistors and two anti parallel free wheeling diodes, respectively, where <code>m</code> is the number of phases.
</p>
</html>"));
end Polyphase2Level;
