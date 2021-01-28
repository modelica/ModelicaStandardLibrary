within Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines;
model SM_ElectricalExcited
  "Electrical excited synchronous machine with optional damper cage"
  extends BaseClasses.Machine(
    Rs(start=0.03),
    Lssigma(start=0.1/(2*pi*fsNominal)),
    final L0(d=2.0*Lmd/m/effectiveStatorTurns^2, q=2.0*Lmq/m/
          effectiveStatorTurns^2),
    redeclare final
      Modelica.Electrical.Machines.Thermal.SynchronousMachines.ThermalAmbientSMEE
      thermalAmbient(
      final useDamperCage=useDamperCage,
      final Te=TeOperational,
      final Tr=TrOperational),
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMEE
      thermalPort(final useDamperCage=useDamperCage),
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMEE
      internalThermalPort(final useDamperCage=useDamperCage),
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceSMEE
      powerBalance(
      final lossPowerRotorWinding=damperCageLossPower,
      final powerExcitation=0,
      final lossPowerExcitation=excitation.resistor.LossPower,
      final lossPowerBrush=brush.lossPower,
      final lossPowerRotorCore=0));
  // Main field parameters
  parameter SI.Inductance Lmd(start=1.5/(2*pi*fsNominal))
    "Stator main field inductance per phase, d-axis" annotation (Dialog(
        tab="Nominal resistances and inductances", groupImage=
          "modelica://Modelica/Resources/Images/Electrical/Machines/SMEE.png"));
  parameter SI.Inductance Lmq(start=1.5/(2*pi*fsNominal))
    "Stator main field inductance per phase, q-axis"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  // Rotor cage parameters
  parameter Boolean useDamperCage(start=true)
    "Enable/disable damper cage" annotation (Dialog(tab=
          "Nominal resistances and inductances", group="Damper cage"));
  parameter SI.Inductance Lrsigmad(start=0.05/(2*pi*
        fsNominal))
    "Rotor damper cage leakage inductance, d-axis, w.r.t. stator side" annotation (
      Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Inductance Lrsigmaq=Lrsigmad
    "Rotor damper cage leakage inductance, q-axis, w.r.t. stator side" annotation (
      Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Resistance Rrd(start=0.04)
    "Rotor damper cage resistance, d-axis, w.r.t. stator side" annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Resistance Rrq=Rrd
    "Rotor damper cage resistance, q-axis, w.r.t. stator side" annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Temperature TrRef(start=293.15)
    "Reference temperature of damper resistances in d- and q-axis"
    annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20r(start=0)
    "Temperature coefficient of damper resistances in d- and q-axis"
    annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  // Operational temperatures
  parameter SI.Temperature TrOperational(start=293.15)
    "Operational temperature of (optional) damper cage" annotation (
      Dialog(group="Operational temperatures", enable=not useThermalPort
           and useDamperCage));
  parameter SI.Temperature TeOperational(start=293.15)
    "Operational excitation temperature" annotation (Dialog(group=
          "Operational temperatures", enable=not useThermalPort));
  // Excitation parameters
  parameter SI.Voltage VsNominal(start=100)
    "Nominal stator voltage" annotation (Dialog(tab="Excitation"));
  parameter SI.Current IeOpenCircuit(start=10)
    "Open circuit excitation current @ nominal voltage and frequency"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Resistance Re(start=2.5)
    "Warm excitation resistance" annotation (Dialog(tab="Excitation"));
  parameter SI.Temperature TeRef(start=293.15)
    "Reference temperature of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20e(start=0) "Temperature coefficient of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter Modelica.Electrical.Machines.Losses.BrushParameters
    brushParameters "Brush loss parameter record"
    annotation (Dialog(tab="Losses"));
  output SI.Voltage ve=pin_ep.v - pin_en.v
    "Excitation voltage";
  output SI.Current ie=pin_ep.i "Excitation current";
  // Rotor cage components
  Modelica.ComplexBlocks.Interfaces.ComplexOutput ir[2] if useDamperCage
    "Damper cage currents"
  annotation (Placement(visible=false));
  FundamentalWave.Components.Short short if not useDamperCage
    "Magnetic connection in case the damper cage is not present"
    annotation (Placement(transformation(
        origin={10,-40},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  // Excitation components
  FundamentalWave.BasicMachines.Components.SaliencyCageWinding rotorCage(
    final Lsigma(d=Lrsigmad, q=Lrsigmaq),
    final useHeatPort=true,
    final TRef=TrRef,
    final TOperational=TrOperational,
    final RRef(d=Rrd, q=Rrq),
    final alpha20=alpha20r,
    final effectiveTurns=sqrt(m/2.0)*effectiveStatorTurns) if
    useDamperCage
    "Symmetric rotor cage winding including resistances and stray inductances"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-40})));
  // Excitation components
  Components.QuasiStaticAnalogWinding excitation(
    final RRef=Re,
    final TRef=TeRef,
    final effectiveTurns=effectiveStatorTurns*turnsRatio*m/2,
    final useHeatPort=true,
    final TOperational=TeOperational,
    final alpha20=alpha20e)
    "Excitation winding including resistance and stray inductance"
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Modelica.Electrical.Machines.Losses.DCMachines.Brush brush(final
      brushParameters=brushParameters, final useHeatPort=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-80,40})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
    "Positive pin of excitation" annotation (Placement(transformation(
          extent={{-110,70},{-90,50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
    "Negative pin of excitation" annotation (Placement(transformation(
          extent={{-90,-50},{-110,-70}})));
protected
  final parameter Real turnsRatio=sqrt(2)*VsNominal/(2*pi*fsNominal*Lmd*
      IeOpenCircuit) "Stator current / excitation current";
  Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
      quantity="Power", final unit="W") "Damper losses";
equation
  connect(ir, rotorCage.i);
  connect(damperCageLossPower, rotorCage.lossPower);
  if not useDamperCage then
    damperCageLossPower = 0;
  end if;
  connect(airGap.port_rn, excitation.port_p) annotation (Line(
      points={{-10,-10},{-10,-30}}, color={255,170,85}));
  connect(excitation.heatPortWinding, internalThermalPort.heatPortExcitation)
    annotation (Line(
      points={{-20,-50},{-20,-80},{-40,-80},{-40,-90}}, color={191,0,0}));
  connect(airGap.port_rp, rotorCage.port_n) annotation (Line(
      points={{10,-10},{10,-30},{30,-30}}, color={255,170,85}));
  connect(short.port_n, airGap.port_rp) annotation (Line(
      points={{10,-30},{10,-10}}, color={255,170,85}));
  connect(rotorCage.port_p, excitation.port_n) annotation (Line(
      points={{30,-50},{-10,-50}}, color={255,170,85}));
  connect(short.port_p, excitation.port_n) annotation (Line(
      points={{10,-50},{-10,-50}}, color={255,170,85}));
  connect(rotorCage.heatPortWinding, internalThermalPort.heatPortRotorWinding)
    annotation (Line(
      points={{40,-40},{40,-80},{-40,-80},{-40,-90}},          color={191,0,0}));
  connect(pin_ep, brush.p) annotation (Line(
      points={{-100,60},{-80,60},{-80,50}}, color={0,0,255}));
  connect(brush.heatPort, internalThermalPort.heatPortBrush) annotation (
      Line(
      points={{-70,50},{-40,50},{-40,-90}}, color={191,0,0}));
  connect(excitation.pin_n, pin_en) annotation (Line(
      points={{-30,-50},{-80,-50},{-80,-60},{-100,-60}}, color={0,0,255}));
  connect(excitation.pin_p, brush.n) annotation (Line(
      points={{-30,-30},{-80,-30},{-80,30}}, color={0,0,255}));
  annotation (
    defaultComponentName="smee",
    Icon(graphics={
        Ellipse(extent={{-134,34},{-66,-34}}, lineColor={85,170,255}),
        Line(points={{-100,50},{-100,20},{-130,20},{-130,-4}}, color={0,0,255}),
        Line(points={{-130,-4},{-129,1},{-125,5},{-120,6},{-115,5},{-111,
              1},{-110,-4}}, color={0,0,255}),
        Line(points={{-110,-4},{-109,1},{-105,5},{-100,6},{-95,5},{-91,1},
              {-90,-4}}, color={0,0,255}),
        Line(points={{-90,-4},{-89,1},{-85,5},{-80,6},{-75,5},{-71,1},{-70,
              -4}}, color={0,0,255}),
        Line(points={{-100,-50},{-100,-20},{-70,-20},{-70,-2}}, color={0,
              0,255})}),
    Documentation(info="<html>
<p>
Resistances and stray inductances of the machine refer to an <code>m</code>-phase stator. The symmetry of the stator and the supply are assumed. For rotor asymmetries can be taken into account by different resistances and stray inductances in the d- and q-axis. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>heat losses in the temperature dependent excitation winding resistance</li>
<li>optional, when enabled: heat losses in the temperature dependent damper cage resistances</li>
<li>brush losses in the excitation circuit</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">
SM_PermanentMagnet</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor\">
SM_ReluctanceRotor</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">
Magnetic.FundamentalWave.BasicMachines.SM_PermanentMagnet</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">
Magnetic.FundamentalWave.BasicMachines.SM_ElectricalExcited</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor\">
Magnetic.FundamentalWave.BasicMachines.SM_ReluctanceRotor</a>,
</p>
</html>"));
end SM_ElectricalExcited;
