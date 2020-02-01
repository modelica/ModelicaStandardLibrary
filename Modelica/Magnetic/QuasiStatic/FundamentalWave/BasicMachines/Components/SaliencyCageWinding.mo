within Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components;
model SaliencyCageWinding "Rotor cage with saliency in d- and q-axis"
  extends Magnetic.QuasiStatic.FundamentalWave.Interfaces.TwoPortExtended;
  parameter Boolean useHeatPort=false
    "Enable / disable (=fixed temperatures) thermal port"
    annotation (Evaluate=true);
  parameter Magnetic.FundamentalWave.Types.SalientResistance RRef(d(start=1), q(
        start=1)) "Salient cage resistance";
  parameter SI.Temperature TRef(start=293.15)
    "Reference temperature of winding";
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20(start=0) "Temperature coefficient of winding at 20 degC";
  final parameter SI.LinearTemperatureCoefficient alphaRef=
      Modelica.Electrical.Machines.Thermal.convertAlpha(
            alpha20,
            TRef,
            293.15) "Temperature coefficient of winding at reference temperature";
  parameter SI.Temperature TOperational(start=293.15)
    "Operational temperature of winding"
    annotation (Dialog(enable=not useHeatPort));
  parameter Magnetic.FundamentalWave.Types.SalientInductance Lsigma(d(start=1),
      q(start=1)) "Salient cage stray inductance";
  parameter Real effectiveTurns=1 "Effective number of turns";
  Modelica.ComplexBlocks.Interfaces.ComplexOutput i[2]=
      electroMagneticConverter.i "Cage currents";
  Modelica.Blocks.Interfaces.RealOutput lossPower(
    final quantity="Power",
    final unit="W") = sum(resistor.resistor.LossPower) "Damper losses";
  Magnetic.QuasiStatic.FundamentalWave.Components.PolyphaseElectroMagneticConverter
    electroMagneticConverter(final m=2, final effectiveTurns=effectiveTurns)
    annotation (Placement(transformation(
        origin={0,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor resistor(
    final useHeatPort=useHeatPort,
    final m=2,
    final T_ref=fill(TRef, 2),
    final T=fill(TOperational, 2),
    R_ref={RRef.d,RRef.q},
    alpha_ref=fill(alphaRef, 2)) annotation (Placement(transformation(
        origin={-20,-50},
        extent={{10,10},{-10,-10}},
        rotation=90)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star star(final m=
        2) annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground ground
    annotation (Placement(transformation(
        origin={60,-20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding if
    useHeatPort "Heat ports of winding resistor"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermalCollector(final m=2) if useHeatPort
    "Connector of thermal rotor resistance heat ports"
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  Magnetic.QuasiStatic.FundamentalWave.Components.Reluctance strayReluctance(final R_m(
        d=effectiveTurns^2/Lsigma.d, q=effectiveTurns^2/Lsigma.q))
    "Stray reluctance equivalent to ideally coupled stray inductances"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={0,
            20})));
equation
  connect(thermalCollector.port_b, heatPortWinding) annotation (Line(
      points={{-40,-90},{-40,-100},{0,-100}}, color={191,0,0}));
  connect(resistor.heatPort, thermalCollector.port_a) annotation (Line(
      points={{-30,-50},{-40,-50},{-40,-70}}, color={191,0,0}));
  connect(port_p, electroMagneticConverter.port_p) annotation (Line(
      points={{-100,0},{-10,0}}, color={255,170,85}));
  connect(electroMagneticConverter.port_n, port_n) annotation (Line(
      points={{10,0},{100,0}}, color={255,170,85}));
  connect(star.pin_n, ground.pin) annotation (Line(
      points={{40,-20},{44,-20},{50,-20}}, color={85,170,255}));
  connect(strayReluctance.port_p, port_p) annotation (Line(
      points={{-10,20},{-30,20},{-30,0},{-100,0}}, color={255,170,85}));
  connect(strayReluctance.port_n, port_n) annotation (Line(
      points={{10,20},{30,20},{30,0},{100,0}}, color={255,170,85}));
  connect(electroMagneticConverter.plug_p, resistor.plug_p) annotation (
      Line(points={{-10,-20},{-20,-20},{-20,-40}}, color={85,170,255}));
  connect(electroMagneticConverter.plug_n, star.plug_p) annotation (Line(
        points={{10,-20},{15,-20},{20,-20}}, color={85,170,255}));
  connect(star.plug_p, resistor.plug_n) annotation (Line(points={{20,-20},
          {20,-60},{-20,-60}}, color={85,170,255}));
  annotation (defaultComponentName="cage",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Ellipse(
          extent={{-80,80},{80,-80}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,76},{20,36}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{28,46},{68,6}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{28,-8},{68,-48}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,-36},{20,-76}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-68,-6},{-28,-46}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-66,50},{-26,10}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,0},{-100,0}}, color={255,170,85}),
        Line(points={{100,0},{80,0}}, color={255,170,85}),
        Text(
          extent={{150,140},{-150,100}},
          textColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>

<p>
The salient cage model is a two axis model with two phases. The electromagnetic coupling therefore is also two phase coupling model. The angles of the two orientations are 0 and <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/pi_over_2.png\">. This way an asymmetrical rotor cage with different resistances and stray inductances in d- and q-axis can be modeled.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseCageWinding\">
SymmetricPolyphaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseCageWinding\">
Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseCageWinding</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">
Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap</a>
</p>
</html>"));
end SaliencyCageWinding;
