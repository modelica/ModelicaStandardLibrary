within Modelica.Magnetic.FundamentalWave.BasicMachines.Components;
model SymmetricPolyphaseCageWinding "Symmetrical rotor cage"
  import Modelica.Constants.pi;
  extends Magnetic.FundamentalWave.Interfaces.TwoPortExtended;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter Boolean useHeatPort=false
    "Enable / disable (=fixed temperatures) thermal port"
    annotation (Evaluate=true);
  parameter SI.Resistance RRef
    "Winding resistance per phase at TRef";
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
  parameter SI.Inductance Lsigma "Cage stray inductance";
  parameter Real effectiveTurns=1 "Effective number of turns";
  final parameter Integer nBase=Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m)
    "Number of base systems";
  SI.Current i[m]=electroMagneticConverter.i
    "Cage currents";
  Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter electroMagneticConverter(
    final m=m,
    final effectiveTurns=fill(effectiveTurns, m),
    final orientation=
        Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m))
    "Symmetric winding" annotation (Placement(transformation(
        origin={0,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor(
    final useHeatPort=useHeatPort,
    final m=m,
    final R=fill(RRef, m),
    final T_ref=fill(TRef, m),
    final alpha=fill(alphaRef, m),
    final T=fill(TOperational, m)) annotation (Placement(transformation(
        origin={-20,-50},
        extent={{10,10},{-10,-10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=nBase)
                                                            annotation (
      Placement(transformation(extent={{50,-30},{70,-10}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={90,-20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding if
    useHeatPort "Heat ports of winding resistor"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(final m=m)
    if useHeatPort "Connector of thermal rotor resistance heat ports"
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  Magnetic.FundamentalWave.Components.Reluctance strayReluctance(final R_m(d=m*
          effectiveTurns^2/2/Lsigma, q=m*effectiveTurns^2/2/Lsigma))
    "Stray reluctance equivalent to ideally coupled stray inductances"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={0,
            20})));
  Modelica.Electrical.Polyphase.Basic.MultiStar multiStar(final m=m)
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
equation
  connect(port_p, electroMagneticConverter.port_p)
    annotation (Line(points={{-100,0},{-10,0}}, color={255,128,0}));
  connect(electroMagneticConverter.port_n, port_n) annotation (Line(
        points={{10,0},{100,0}}, color={255,
          128,0}));
  connect(ground.p, star.pin_n) annotation (Line(points={{80,-20},{70,-20}}, color={0,0,255}));
  connect(thermalCollector.port_a, resistor.heatPort) annotation (Line(
      points={{-40,-70},{-40,-70},{-40,-50},{-30,-50}}, color={191,0,0}));
  connect(thermalCollector.port_b, heatPortWinding) annotation (Line(
      points={{-40,-90},{-40,-100},{0,-100}}, color={191,0,0}));
  connect(strayReluctance.port_p, port_p) annotation (Line(
      points={{-10,20},{-30,20},{-30,0},{-100,0}}, color={255,128,0}));
  connect(strayReluctance.port_n, port_n) annotation (Line(
      points={{10,20},{30,20},{30,0},{100,0}}, color={255,128,0}));
  connect(electroMagneticConverter.plug_p, resistor.plug_p) annotation (
      Line(
      points={{-10,-20},{-20,-20},{-20,-40}}, color={0,0,255}));
  connect(electroMagneticConverter.plug_n, multiStar.plug_p)
    annotation (Line(points={{10,-20},{15,-20},{20,-20}}, color={0,0,255}));
  connect(multiStar.starpoints, star.plug_p)
    annotation (Line(points={{40,-20},{45,-20},{50,-20}}, color={0,0,255}));
  connect(resistor.plug_n, multiStar.plug_p)
    annotation (Line(points={{-20,-60},{20,-60},{20,-20}}, color={0,0,255}));
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
        Line(points={{-80,0},{-100,0}}, color={255,128,0}),
        Line(points={{100,0},{80,0}}, color={255,128,0}),
          Text(
              extent={{-150,100},{150,140}},
              textColor={0,0,255},
              textString="%name")}),
    Documentation(info="<html>
<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Machines/Components/rotorcage.png\">
</div>
<p>
The symmetric rotor cage model of this library does not consist of rotor bars and end rings. Instead the symmetric cage is modeled by an equivalent symmetrical winding. The rotor cage model consists of
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\"> phases. If the cage is modeled by equivalent stator winding parameters, the number of effective turns, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns.png\">, has to be chosen equivalent to the effective number of stator turns.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding\">SymmetricPolyphaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding\">SaliencyCageWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
</p>
</html>"));
end SymmetricPolyphaseCageWinding;
