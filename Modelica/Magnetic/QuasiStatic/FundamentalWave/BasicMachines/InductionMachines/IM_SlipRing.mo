within Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines;
model IM_SlipRing "Induction machine with slip ring rotor"
  parameter Integer mr(min=3) = m "Number of rotor phases" annotation(Evaluate=true);
  extends BaseClasses.Machine(
    Rs(start=0.03),
    Lssigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal)),
    final L0(d=2.0*Lm/m/effectiveStatorTurns^2, q=2.0*Lm/m/
          effectiveStatorTurns^2),
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
      final powerRotor=
          Modelica.Electrical.QuasiStatic.Polyphase.Functions.activePower(
                                                                 vr,
          ir)));

  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug
    plug_rn(final m=mr) "Negative plug of rotor" annotation (Placement(
        transformation(extent={{-110,-50},{-90,-70}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug
    plug_rp(final m=mr) "Positive plug of rotor" annotation (Placement(
        transformation(extent={{-110,70},{-90,50}})));
  parameter SI.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi
        *fsNominal)) "Stator main field inductance per phase" annotation (
     Dialog(tab="Nominal resistances and inductances", groupImage=
          "modelica://Modelica/Resources/Images/Electrical/Machines/IMS.png"));
  parameter SI.Inductance Lrsigma(start=3*(1 - sqrt(1 -
        0.0667))/(2*pi*fsNominal))
    "Rotor leakage inductance per phase w.r.t. rotor side"
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
  output SI.ComplexVoltage vr[mr]=plug_rp.pin.v - plug_rn.pin.v
    "Complex rotor voltage";
  SI.Voltage abs_vr[mr]=Modelica.ComplexMath.abs(vr)
    "Magnitude of complex rotor voltage";
  SI.Angle arg_vr[mr]=Modelica.ComplexMath.arg(vr)
    "Argument of complex rotor voltage";

  output SI.ComplexCurrent ir[mr]=plug_rp.pin.i
    "Complex rotor current";
  SI.Current abs_ir[mr]=Modelica.ComplexMath.abs(ir)
    "Magnitude of complex rotor current";
  SI.Angle arg_ir[mr]=Modelica.ComplexMath.arg(ir)
    "Argument of complex rotor current";

  SI.ActivePower Pr[mr]={Modelica.ComplexMath.real(vr[k]*
      Modelica.ComplexMath.conj(ir[k])) for k in 1:mr}
    "Active rotor power";
  SI.ActivePower Pr_total=sum(Pr)
    "Total active rotor power";
  SI.ReactivePower Qr[mr]={Modelica.ComplexMath.imag(vr[k]*
      Modelica.ComplexMath.conj(ir[k])) for k in 1:mr}
    "Reactive rotor power";
  SI.ReactivePower Qr_total=sum(Qr)
    "Total reactive rotor power";
  SI.ApparentPower Sr[mr]={Modelica.ComplexMath.abs(vr[k]
      *Modelica.ComplexMath.conj(ir[k])) for k in 1:mr}
    "Magnitude of complex rotor apparent power";
  SI.ApparentPower Sr_total=sqrt(Pr_total^2 + Qr_total^2)
    "Magnitude of total complex rotor apparent power";
  Real pfr[m]={cos(Modelica.ComplexMath.arg(Complex(Pr[k], Qr[k]))) for k in
          1:m} "Rotor power factor";

protected
  final parameter Real internalTurnsRatio=if useTurnsRatio then
      TurnsRatio else VsNominal/VrLockedRotor*(2*pi*fsNominal*Lm)/sqrt(Rs
      ^2 + (2*pi*fsNominal*(Lm + Lssigma))^2);
public
  Components.SymmetricPolyphaseWinding rotor(
    final Lsigma=Lrsigma,
    final effectiveTurns=effectiveStatorTurns/internalTurnsRatio,
    final useHeatPort=true,
    final RRef=Rr,
    final TRef=TrRef,
    final TOperational=TrOperational,
    final GcRef=rotorCoreParameters.GcRef,
    final m=mr,
    final alpha20=alpha20r)
    "Symmetric rotor winding including resistances, zero and stray inductances and zero core losses"
    annotation (Placement(transformation(
        origin={0,-40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  connect(rotor.plug_n, plug_rn) annotation (Line(points={{10,-50},{10,-60},
          {-100,-60}}, color={85,170,255}));
  connect(rotor.heatPortCore, internalThermalPort.heatPortRotorCore)
    annotation (Line(
      points={{10,-36},{20,-36},{20,-80},{-39.6,-80},{-39.6,-90.8}}, color={191,0,0}));
  connect(rotor.heatPortWinding, internalThermalPort.heatPortRotorWinding)
    annotation (Line(
      points={{10,-44},{20,-44},{20,-80},{-40,-80},{-40,-90}}, color={191,0,0}));
  connect(plug_rp, rotor.plug_p) annotation (Line(
      points={{-100,60},{-80,60},{-80,-50},{-10,-50}}, color={85,170,255}));
  connect(airGap.port_rn, rotor.port_p) annotation (Line(
      points={{-10,-10},{-10,-30}}, color={255,170,85}));
  connect(airGap.port_rp, rotor.port_n) annotation (Line(
      points={{10,-10},{10,-30}}, color={255,170,85}));
  annotation (
    defaultComponentName="ims",
    Icon(graphics={Line(points={{-100,50},{-100,20},{-60,20}}, color={85,170,255}),
               Line(points={{-100,-50},{-100,-20},{-60,-20}},
            color={85,170,255})}),
    Documentation(info="<html>
<p>
Resistances and stray inductances of the machine always refer to either stator or rotor. The symmetry of the stator, rotor and supply are assumed. The number of stator and rotor phases may be different. The machine models take the following loss effects into account:
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
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage\">
IM_SquirrelCage</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing\">
Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage\">
Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage</a>,
</p>
</html>"));
end IM_SlipRing;
