within Modelica.Electrical.Machines.BasicMachines.InductionMachines;
model IM_SlipRing "Induction machine with slipring rotor"
  extends Machines.Interfaces.PartialBasicInductionMachine(
    final idq_ss=airGap.i_ss,
    final idq_sr=airGap.i_sr,
    final idq_rs=airGap.i_rs,
    final idq_rr=airGap.i_rr,
    redeclare final Machines.Thermal.InductionMachines.ThermalAmbientIMS
      thermalAmbient(final Tr=TrOperational, final mr=m),
    redeclare final Machines.Interfaces.InductionMachines.ThermalPortIMS
      thermalPort(final mr=m),
    redeclare final Machines.Interfaces.InductionMachines.ThermalPortIMS
      internalThermalPort(final mr=m),
    redeclare final Machines.Interfaces.InductionMachines.PowerBalanceIMS
      powerBalance(
      final lossPowerRotorWinding=sum(rr.resistor.LossPower),
      final lossPowerRotorCore=rotorCore.lossPower,
      final lossPowerBrush=0,
      final powerRotor=Machines.SpacePhasors.Functions.activePower(vr, ir)),
    statorCore(final w=statorCoreParameters.wRef));

  Machines.BasicMachines.Components.AirGapS airGap(
    final p=p,
    final Lm=Lm,
    final m=m) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270)));
  parameter SI.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi
        *fsNominal)) "Stator main field inductance per phase"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Inductance Lrsigma(start=3*(1 - sqrt(1 -
        0.0667))/(2*pi*fsNominal))
    "Rotor stray inductance per phase w.r.t. rotor side"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Inductance Lrzero=Lrsigma
    "Rotor zero sequence inductance w.r.t. rotor side"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Resistance Rr(start=0.04)
    "Rotor resistance per phase at TRef w.r.t. rotor side"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature TrRef(start=293.15)
    "Reference temperature of rotor resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start=0)
    "Temperature coefficient of rotor resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Boolean useTurnsRatio(start=true)
    "Use turnsRatio or calculate from locked-rotor voltage?";
  parameter Real turnsRatio(final min=Modelica.Constants.small, start=1)
    "Effective number of stator turns / effective number of rotor turns"
    annotation (Dialog(enable=useTurnsRatio));
  parameter SI.Voltage VsNominal(start=100)
    "Nominal stator voltage per phase"
    annotation (Dialog(enable=not useTurnsRatio));
  parameter SI.Voltage VrLockedRotor(start=100*(2*pi*
        fsNominal*Lm)/sqrt(Rs^2 + (2*pi*fsNominal*(Lm + Lssigma))^2))
    "Locked-rotor voltage per phase"
    annotation (Dialog(enable=not useTurnsRatio));
  parameter SI.Temperature TrOperational(start=293.15)
    "Operational temperature of rotor resistance" annotation (Dialog(
        group="Operational temperatures", enable=not useThermalPort));
  parameter Machines.Losses.CoreParameters rotorCoreParameters(
    final m=3,
    PRef=0,
    VRef(start=1) = 1,
    wRef(start=1) = 1)
    "Rotor core loss parameter record; all parameters refer to rotor side"
    annotation (Dialog(tab="Losses"));
  output SI.Current i_0_r(stateSelect=StateSelect.prefer)=
       spacePhasorR.zero.i "Rotor zero-sequence current";
  output SI.Voltage vr[m]=plug_rp.pin.v - plug_rn.pin.v
    "Rotor instantaneous voltages";
  output SI.Current ir[m]=plug_rp.pin.i
    "Rotor instantaneous currents";
protected
  final parameter Real internalTurnsRatio=if useTurnsRatio then
      turnsRatio else VsNominal/VrLockedRotor*(2*pi*fsNominal*Lm)/sqrt(Rs
      ^2 + (2*pi*fsNominal*(Lm + Lssigma))^2);
public
  Machines.SpacePhasors.Components.SpacePhasor spacePhasorR(final turnsRatio=
        internalTurnsRatio) annotation (Placement(transformation(
        origin={-70,-50},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.Polyphase.Basic.Resistor rr(
    final m=m,
    final R=fill(Rr, m),
    final T_ref=fill(TrRef, m),
    final alpha=fill(Machines.Thermal.convertAlpha(alpha20r, TrRef), m),
    final useHeatPort=true,
    final T=fill(TrRef, m)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-80,40})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_rp(final m=
        m) "Positive rotor plug" annotation (Placement(transformation(
          extent={{-110,70},{-90,50}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_rn(final m=
        m) "Negative rotor plug" annotation (Placement(transformation(
          extent={{-110,-50},{-90,-70}})));
  Machines.BasicMachines.Components.Inductor lrsigma(final L=fill(
        internalTurnsRatio^2*Lrsigma, 2)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={20,-20})));
  Modelica.Electrical.Analog.Basic.Inductor lrzero(final L=
        internalTurnsRatio^2*Lrzero) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-50,-60})));
  Machines.Losses.InductionMachines.Core rotorCore(
    final coreParameters=rotorCoreParameters,
    final w=rotorCoreParameters.wRef,
    final useHeatPort=true,
    final turnsRatio=internalTurnsRatio) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,-30})));
equation
  connect(lssigma.spacePhasor_b, airGap.spacePhasor_s) annotation (Line(
      points={{20,10},{10,10}}, color={0,0,255}));
  connect(lrsigma.spacePhasor_b, airGap.spacePhasor_r) annotation (Line(
      points={{20,-10},{10,-10}}, color={0,0,255}));
  connect(rr.plug_n, spacePhasorR.plug_p) annotation (Line(
      points={{-80,30},{-80,-40}}, color={0,0,255}));
  connect(spacePhasorR.plug_n, plug_rn) annotation (Line(
      points={{-80,-60},{-100,-60}}, color={0,0,255}));
  connect(spacePhasorR.zero, lrzero.p) annotation (Line(
      points={{-60,-50},{-50,-50}}, color={0,0,255}));
  connect(spacePhasorR.ground, lrzero.n) annotation (Line(
      points={{-60,-60},{-60,-70},{-50,-70}}, color={0,0,255}));
  connect(spacePhasorR.spacePhasor, lrsigma.spacePhasor_a) annotation (
      Line(
      points={{-60,-40},{-20,-40},{-20,-50},{20,-50},{20,-30}}, color={0,0,255}));
  connect(rotorCore.spacePhasor, lrsigma.spacePhasor_a) annotation (Line(
      points={{10,-30},{20,-30}}, color={0,0,255}));
  connect(rotorCore.heatPort, internalThermalPort.heatPortRotorCore)
    annotation (Line(
      points={{10,-40},{0.4,-40},{0.4,-80.8}}, color={191,0,0}));
  connect(rr.heatPort, internalThermalPort.heatPortRotorWinding)
    annotation (Line(
      points={{-70,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
  connect(plug_rp, rr.plug_p) annotation (Line(
      points={{-100,60},{-80,60},{-80,50}}, color={0,0,255}));
  connect(airGap.flange, inertiaRotor.flange_a) annotation (Line(
      points={{10,0},{70,0}}));
  connect(fixed.flange, internalSupport) annotation (Line(
      points={{50,-100},{60,-100}}));
  connect(internalSupport, airGap.support) annotation (Line(
      points={{60,-100},{60,-90},{-40,-90},{-40,0},{-10,0}}));
  annotation (
    defaultComponentName="ims",
    Documentation(info="<html>
<p><strong>Model of a three-phase induction machine with slipring rotor.</strong><br>
Resistance and stray inductance of stator and rotor are modeled directly in stator respectively rotor phases, then using space phasor transformation and a stator-fixed <em>AirGap</em> model. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>heat losses in the temperature dependent rotor winding resistances</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<p><strong>Default values for machine's parameters (a realistic example) are:</strong><br></p>
<table>
<tr>
<td>number of pole pairs p</td>
<td>2</td><td> </td>
</tr>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal frequency fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>nominal voltage per phase</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>nominal current per phase</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>nominal torque</td>
<td>161.4</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1440.45</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>24.346</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>92.7</td><td>%</td>
</tr>
<tr>
<td>power factor</td>
<td>0.875</td><td> </td>
</tr>
<tr>
<td>stator resistance</td>
<td>0.03</td><td>Ohm per phase at reference temperature</td>
</tr>
<tr>
<td>reference temperature TsRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20s </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>rotor resistance</td>
<td>0.04</td><td>Ohm per phase at reference temperature</td>
</tr>
<tr>
<td>reference temperature TrRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20r </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>stator reactance Xs</td>
<td>3</td><td>Ohm per phase</td>
</tr>
<tr>
<td>rotor reactance Xr</td>
<td>3</td><td>Ohm per phase</td>
</tr>
<tr>
<td>total stray coefficient sigma</td>
<td>0.0667</td><td> </td>
</tr>
<tr>
<td>turnsRatio</td>
<td>1</td><td>effective ratio of stator and rotor current</td>
</tr>
<tr>
<td>stator operational temperature TsOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>rotor operational temperature TrOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>These values give the following inductances:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>stator stray inductance per phase</td>
<td>Xs * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>rotor stray inductance</td>
<td>Xr * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance per phase</td>
<td>sqrt(Xs*Xr * (1-sigma))/(2*pi*f)</td><td> </td>
</tr>
</table>
<p>
Parameter turnsRatio could be obtained from the following relationship
at standstill with open rotor circuit at nominal voltage and nominal frequency,<br>
using the locked-rotor voltage VR, no-load stator current I0 and powerfactor PF0:<br>
turnsRatio * <u>V</u><sub>R</sub> = <u>V</u><sub>s</sub> - (R<sub>s</sub> + j X<sub>s,sigma</sub>) <u>I</u><sub>0</sub>
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{-100,50},{-100,20},{-60,
              20}}, color={0,0,255}), Line(points={{-100,-50},{-100,-20},
              {-60,-20}}, color={0,0,255})}));
end IM_SlipRing;
