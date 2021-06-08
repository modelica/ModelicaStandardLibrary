within Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines;
model IM_SlipRing "Induction machine with slip ring rotor"
  parameter Integer mr(min=3) = m "Number of rotor phases" annotation(Evaluate=true);
  extends Magnetic.FundamentalWave.BaseClasses.Machine(
    is(start=zeros(m)),
    Rs(start=0.03),
    Lssigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal)),
    final L0(d=2.0*Lm/m/effectiveStatorTurns^2, q=2.0*Lm/m/effectiveStatorTurns
          ^2),
    redeclare final
      Modelica.Electrical.Machines.Thermal.InductionMachines.ThermalAmbientIMS
      thermalAmbient(final Tr=TrOperational, final mr=mr),
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortIMS
      thermalPort(final mr=mr),
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortIMS
      internalThermalPort(final mr=mr),
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceIMS
      powerBalance(
      final lossPowerRotorWinding=sum(rotor.resistor.resistor.LossPower),
      final lossPowerRotorCore=rotor.core.lossPower,
      final lossPowerBrush=0,
      final powerRotor=Modelica.Electrical.Polyphase.Functions.activePower(vr,
          ir)));

  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_rn(final m=
        mr) "Negative plug of rotor" annotation (Placement(transformation(
          extent={{-110,-50},{-90,-70}})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_rp(final m=
        mr) "Positive plug of rotor" annotation (Placement(transformation(
          extent={{-110,70},{-90,50}})));
  parameter SI.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi
        *fsNominal)) "Stator main field inductance" annotation (Dialog(
        tab="Nominal resistances and inductances", groupImage=
          "modelica://Modelica/Resources/Images/Electrical/Machines/IMS.png"));
  parameter SI.Inductance Lrsigma(start=3*(1 - sqrt(1 -
        0.0667))/(2*pi*fsNominal))
    "Rotor leakage inductance w.r.t. rotor side"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Real ratioCommonRotorLeakage(final min=0, final max=1)=1
    "Ratio of common stray inductance / total stray inductance of rotor winding"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Inductance Lrzero=Lrsigma
    "Rotor zero inductance w.r.t. rotor side"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Resistance Rr(start=0.04)
    "Rotor resistance per phase w.r.t. rotor side"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature TrRef(start=293.15)
    "Reference temperature of rotor resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20r(start=0)
    "Temperature coefficient of rotor resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature TrOperational(start=293.15)
    "Operational temperature of rotor resistance" annotation (Dialog(
        group="Operational temperatures", enable=not useThermalPort));
  parameter Boolean useTurnsRatio(start=true)
    "Use TurnsRatio or calculate from locked-rotor voltage?";
  parameter Real TurnsRatio(final min=Modelica.Constants.small, start=1)
    "Effective number of stator turns / effective number of rotor turns"
    annotation (Dialog(enable=useTurnsRatio));
  parameter SI.Voltage VsNominal(start=100)
    "Nominal stator voltage per phase"
    annotation (Dialog(enable=not useTurnsRatio));
  parameter SI.Voltage VrLockedRotor(start=100*(2*pi*
        fsNominal*Lm)/sqrt(Rs^2 + (2*pi*fsNominal*(Lm + Lssigma))^2))
    "Locked rotor voltage per phase"
    annotation (Dialog(enable=not useTurnsRatio));
  parameter Modelica.Electrical.Machines.Losses.CoreParameters
    rotorCoreParameters(
    final m=3,
    PRef=0,
    VRef(start=1) = 1,
    wRef(start=1) = 1)
    "Rotor core loss parameter record, all quantities refer to rotor side"
    annotation (Dialog(tab="Losses"));
  output SI.Voltage vr[mr]=plug_rp.pin.v - plug_rn.pin.v
    "Rotor instantaneous voltages";
  output SI.Current ir[mr]=plug_rp.pin.i
    "Rotor instantaneous currents";
protected
  final parameter Real internalTurnsRatio=if useTurnsRatio then
      TurnsRatio else VsNominal/VrLockedRotor*(2*pi*fsNominal*Lm)/sqrt(Rs
      ^2 + (2*pi*fsNominal*(Lm + Lssigma))^2);
public
  Components.SymmetricPolyphaseWinding rotor(
    final Lsigma=Lrsigma,
    final ratioCommonLeakage=ratioCommonRotorLeakage,
    final effectiveTurns=effectiveStatorTurns/internalTurnsRatio,
    final useHeatPort=true,
    final RRef=Rr,
    final TRef=TrRef,
    final TOperational=TrOperational,
    final Lzero=Lrsigma,
    final GcRef=rotorCoreParameters.GcRef,
    final m=mr,
    final alpha20=alpha20r)
    "Symmetric rotor winding including resistances, zero and stray inductances and zero core losses"
    annotation (Placement(transformation(
        origin={0,-40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  /* previously used: state selection, now commented
  FundamentalWave.Interfaces.StateSelector stateSelectorR(
    final m=m,
    final xi=ir,
    final gamma=0) "State selection of rotor currents"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,0})));
  */
equation
  connect(rotor.plug_n, plug_rn) annotation (Line(points={{10,-50},{10,-60},
          {-100,-60}}, color={0,0,255}));
  connect(rotor.heatPortCore, internalThermalPort.heatPortRotorCore)
    annotation (Line(
      points={{10,-36},{16,-36},{16,-36},{20,-36},{20,-80},{-39.6,-80},{-39.6,-90.8}},
                 color={191,0,0}));

  connect(rotor.heatPortWinding, internalThermalPort.heatPortRotorWinding)
    annotation (Line(
      points={{10,-44},{20,-44},{20,-80},{-40,-80},{-40,-90}}, color={191,0,0}));
  connect(plug_rp, rotor.plug_p) annotation (Line(
      points={{-100,60},{-80,60},{-80,-50},{-10,-50}}, color={0,0,255}));
  connect(airGap.port_rn, rotor.port_p) annotation (Line(
      points={{-10,-10},{-10,-30}}, color={255,128,0}));
  connect(airGap.port_rp, rotor.port_n) annotation (Line(
      points={{10,-10},{10,-30}}, color={255,128,0}));
  annotation (
    defaultComponentName="ims",
    Icon(graphics={Line(points={{-100,50},{-100,20},{-60,20}}, color={0,0,255}),
               Line(points={{-100,-50},{-100,-20},{-60,-20}}, color=
             {0,0,255})}),
    Documentation(info="<html>
<p>
Resistances and stray inductances of the machine always refer to either stator or rotor. The symmetry of the stator and rotor is assumed. The number of stator and rotor phases may be different. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>heat losses in the temperature dependent rotor winding resistances</li>
<li>friction losses</li>
<li>stator and rotor core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage\">IM_SquirrelCage</a>,
</p>
</html>"));
end IM_SlipRing;
