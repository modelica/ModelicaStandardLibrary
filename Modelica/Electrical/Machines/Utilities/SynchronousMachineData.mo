within Modelica.Electrical.Machines.Utilities;
record SynchronousMachineData
  "Computes machine parameter from usual datasheet"
  extends Modelica.Icons.Record;
  import Modelica.Constants.pi;
  parameter SI.ApparentPower SNominal(start=30E3)
    "Nominal apparent power";
  parameter SI.Voltage VsNominal(start=100)
    "Nominal stator voltage per phase";
  final parameter SI.Current IsNominal=SNominal/(3*VsNominal)
    "Nominal stator current per phase";
  final parameter SI.Impedance ZReference=VsNominal/IsNominal
    "Reference impedance";
  parameter SI.Frequency fsNominal(start=50)
    "Nominal stator frequency";
  final parameter SI.AngularVelocity omega=2*pi*fsNominal
    "Nominal angular frequency";
  parameter SI.Current IeOpenCircuit(start=10)
    "Open circuit excitation current @ nominal voltage and frequency";
  parameter Real effectiveStatorTurns=1 "Effective number of stator turns";
  final parameter Real turnsRatio=sqrt(2)*VsNominal/(omega*Lmd*
      IeOpenCircuit) "Stator current / excitation current";
  parameter Real x0(start=0.1)
    "Stator stray inductance per phase (approximately zero impedance) [pu]";
  parameter Real xd(start=1.6)
    "Synchronous reactance per phase, d-axis [pu]";
  parameter Real xq(start=1.6)
    "Synchronous reactance per phase, q-axis [pu]";
  parameter Real xdTransient(start=0.1375)
    "Transient reactance per phase, d-axis [pu]";
  parameter Real xdSubtransient(start=0.121428571)
    "Subtransient reactance per phase, d-axis [pu]";
  parameter Real xqSubtransient(start=0.148387097)
    "Subtransient reactance per phase, q-axis [pu]";
  parameter SI.Time Ta(start=0.014171268)
    "Armature time constant";
  parameter SI.Time Td0Transient(start=0.261177343)
    "Open circuit field time constant Td0'";
  parameter SI.Time Td0Subtransient(start=0.006963029)
    "Open circuit subtransient time constant Td0'', d-axis";
  parameter SI.Time Tq0Subtransient(start=0.123345081)
    "Open circuit subtransient time constant Tq0'', q-axis";
  parameter SI.Temperature TsSpecification(start=293.15)
    "Specification temperature of stator resistance"
    annotation (Dialog(tab="Material"));
  parameter SI.Temperature TsRef(start=293.15)
    "Reference temperature of stator resistance"
    annotation (Dialog(tab="Material"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20s(start=0)
    "Temperature coefficient of stator resistance at 20 degC"
    annotation (Dialog(tab="Material"));
  parameter SI.Temperature TrSpecification(start=293.15)
    "Specification temperature of (optional) damper cage"
    annotation (Dialog(tab="Material"));
  parameter SI.Temperature TrRef(start=293.15)
    "Reference temperature of damper resistances in d- and q-axis"
    annotation (Dialog(tab="Material"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start=0)
    "Temperature coefficient of damper resistances in d- and q-axis"
    annotation (Dialog(tab="Material"));
  parameter SI.Temperature TeSpecification(start=293.15)
    "Specification excitation temperature"
    annotation (Dialog(tab="Material"));
  parameter SI.Temperature TeRef(start=293.15)
    "Reference temperature of excitation resistance"
    annotation (Dialog(tab="Material"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(start=0)
    "Temperature coefficient of excitation resistance"
    annotation (Dialog(tab="Material"));
  final parameter Real xmd=xd - x0
    "Main field reactance per phase, d-axis [pu]";
  final parameter Real xmq=xq - x0
    "Main field reactance per phase, q-axis [pu]";
  final parameter Real xe=xmd^2/(xd - xdTransient)
    "Excitation reactance [pu]";
  final parameter Real xrd=xmd^2/(xdTransient - xdSubtransient)*(1 - (xmd/
      xe))^2 + xmd^2/xe "Damper reactance per phase, d-axis [pu]";
  final parameter Real xrq=xmq^2/(xq - xqSubtransient)
    "Damper reactance per phase, d-axis [pu]";
  final parameter Real rs=2/(1/xdSubtransient + 1/xqSubtransient)/(omega*Ta)
    "Stator resistance per phase at specification temperature [pu]";
  final parameter Real rrd=(xrd - xmd^2/xe)/(omega*Td0Subtransient)
    "Damper resistance per phase at specification temperature, d-axis [pu]";
  final parameter Real rrq=xrq/(omega*Tq0Subtransient)
    "Damper resistance per phase at specification temperature, q-axis [pu]";
  final parameter Real re=xe/(omega*Td0Transient)
    "Excitation resistance per phase at specification temperature [pu]";
  parameter SI.Resistance Rs=
      Machines.Thermal.convertResistance(
          rs*ZReference,
          TsSpecification,
          alpha20s,
          TsRef) "Stator resistance per phase at TRef"
    annotation (Dialog(tab="Result", enable=false));
  parameter SI.Inductance Lssigma=x0*ZReference/omega
    "Stator stray inductance per phase"
    annotation (Dialog(tab="Result", enable=false));
  parameter Real ratioCommonStatorLeakage(final min=0, final max=1)=1
    "Ratio of common stray inductance / total stray inductance of stator winding"
    annotation (Dialog(tab="Result"));
  parameter SI.Inductance Lmd=xmd*ZReference/omega
    "Main field inductance per phase in d-axis"
    annotation (Dialog(tab="Result", enable=false));
  parameter SI.Inductance Lmq=xmq*ZReference/omega
    "Main field inductance per phase in q-axis"
    annotation (Dialog(tab="Result", enable=false));
  parameter SI.Inductance Lrsigmad=(xrd - xmd)*ZReference/
      omega "Damper stray inductance in d-axis"
    annotation (Dialog(tab="Result", enable=false));
  parameter SI.Inductance Lrsigmaq=(xrq - xmq)*ZReference/
      omega "Damper stray inductance in q-axis"
    annotation (Dialog(tab="Result", enable=false));
  parameter SI.Resistance Rrd=
      Machines.Thermal.convertResistance(
          rrd*ZReference,
          TrSpecification,
          alpha20r,
          TrRef) "Damper resistance in d-axis at TRef"
    annotation (Dialog(tab="Result", enable=false));
  parameter SI.Resistance Rrq=
      Machines.Thermal.convertResistance(
          rrq*ZReference,
          TrSpecification,
          alpha20r,
          TrRef) "Damper resistance in q-axis at TRef"
    annotation (Dialog(tab="Result", enable=false));
  parameter SI.Resistance Re=3/2*turnsRatio^2*
      Machines.Thermal.convertResistance(
          re*ZReference,
          TeSpecification,
          alpha20e,
          TeRef) "Excitation resistance at TRef"
    annotation (Dialog(tab="Result", enable=false));
  parameter Real sigmae=1 - xmd/xe
    "Stray fraction of total excitation inductance"
    annotation (Dialog(tab="Result", enable=false));
  annotation (
    defaultComponentName="smeeData",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>The parameters of the
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">
synchronous machine model with electrical excitation (and damper)</a> are calculated from parameters
normally given in a technical description, according to the standard EN&nbsp;60034-4:2008&nbsp;Appendix&nbsp;C.</p>
</html>"));
end SynchronousMachineData;
