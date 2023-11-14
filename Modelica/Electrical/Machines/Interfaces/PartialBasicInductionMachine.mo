within Modelica.Electrical.Machines.Interfaces;
partial model PartialBasicInductionMachine
  "Partial model for induction machine"
  final parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter Integer p(min=1, start=2) "Number of pole pairs (Integer)";
  parameter SI.Frequency fsNominal(start=50)
    "Nominal frequency";
  parameter SI.Temperature TsOperational(start=293.15)
    "Operational temperature of stator resistance" annotation (Dialog(group=
         "Operational temperatures", enable=not useThermalPort));
  parameter SI.Resistance Rs(start=0.03*ZsRef)
    "Stator resistance per phase at TRef"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature TsRef(start=293.15)
    "Reference temperature of stator resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20s(start=0)
    "Temperature coefficient of stator resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Inductance Lszero=Lssigma
    "Stator zero sequence inductance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Inductance Lssigma(start=3*ZsRef*(1 - sqrt(1 -
        0.0667))/(2*pi*fsNominal)) "Stator stray inductance per phase"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  extends PartialBasicMachine(
    Jr(start=0.29),
    frictionParameters(wRef=2*pi*fsNominal/p),
    friction(final useHeatPort=true));
  parameter Machines.Losses.CoreParameters statorCoreParameters(
    final m=3,
    VRef(start=100),
    wRef=2*pi*fsNominal)
    "Stator core loss parameter record; all parameters refer to stator side"
    annotation (Dialog(tab="Losses"));
  parameter Machines.Losses.StrayLoadParameters strayLoadParameters(IRef(start=
          100), wRef=2*pi*fsNominal/p) "Stray load loss parameter record"
    annotation (Dialog(tab="Losses"));
  replaceable output
    Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines powerBalance(
    final powerStator=Machines.SpacePhasors.Functions.activePower(vs, is),
    final powerMechanical=wMechanical*tauShaft,
    final powerInertiaStator=inertiaStator.J*inertiaStator.a*inertiaStator.w,
    final powerInertiaRotor=inertiaRotor.J*inertiaRotor.a*inertiaRotor.w,
    final lossPowerStatorWinding=sum(rs.resistor.LossPower),
    final lossPowerStatorCore=statorCore.lossPower,
    final lossPowerStrayLoad=strayLoad.lossPower,
    final lossPowerFriction=friction.lossPower) "Power balance";

  output SI.Voltage vs[m]=plug_sp.pin.v - plug_sn.pin.v
    "Stator instantaneous voltages";
  output SI.Current is[m]=plug_sp.pin.i
    "Stator instantaneous currents";
  output SI.Current i_0_s(stateSelect=StateSelect.prefer)=
    spacePhasorS.zero.i "Stator zero-sequence current";
  // to be defined in model that extends from this partial (since airgap isn't included here)
  input SI.Current idq_ss[2]
    "Stator space phasor current / stator fixed frame";
  input SI.Current idq_sr[2](each stateSelect=StateSelect.prefer)
    "Stator space phasor current / rotor fixed frame";
  input SI.Current idq_rs[2]
    "Rotor space phasor current / stator fixed frame";
  input SI.Current idq_rr[2](each stateSelect=StateSelect.prefer)
    "Rotor space phasor current / rotor fixed frame";
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_sp(final m=m)
    "Positive stator plug" annotation (Placement(transformation(extent={{50,
            90},{70,110}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_sn(final m=m)
    "Negative stator plug" annotation (Placement(transformation(extent={{-70,
            90},{-50,110}})));
  Modelica.Electrical.Polyphase.Basic.Resistor rs(
    final m=m,
    final R=fill(Rs, m),
    final T_ref=fill(TsRef, m),
    final alpha=fill(Machines.Thermal.convertAlpha(alpha20s, TsRef), m),
    final useHeatPort=true,
    final T=fill(TsRef, m)) annotation (Placement(transformation(extent={{
            60,70},{40,90}})));
  Machines.BasicMachines.Components.Inductor lssigma(final L=fill(Lssigma, 2))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,20})));
  Modelica.Electrical.Analog.Basic.Inductor lszero(final L=Lszero)
    annotation (Placement(transformation(extent={{0,40},{-20,60}})));
  Machines.Losses.InductionMachines.Core statorCore(
    final coreParameters=statorCoreParameters,
    final useHeatPort=true,
    final turnsRatio=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,30})));
  Machines.SpacePhasors.Components.SpacePhasor spacePhasorS(final turnsRatio=1)
    annotation (Placement(transformation(
        origin={0,70},
        extent={{10,10},{-10,-10}},
        rotation=90)));
  Machines.Losses.InductionMachines.StrayLoad strayLoad(
    final strayLoadParameters=strayLoadParameters,
    final useHeatPort=true,
    final m=m) annotation (Placement(transformation(extent={{90,70},{70,90}})));
  replaceable
    Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines thermalPort(final m=m)
    if useThermalPort
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  replaceable
    Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines
    thermalAmbient(
    final useTemperatureInputs=false,
    final Ts=TsOperational,
    final m=m) if not useThermalPort annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-80})));
protected
  final parameter SI.Impedance ZsRef = 1 "Reference phase impedance based on nominal voltage 100 V and nominal current 100 A; per phase";
  constant Real pi = Modelica.Constants.pi;
  replaceable
    Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines internalThermalPort(final m=m)
    annotation (Placement(transformation(extent={{-4,-84},{4,-76}})));
equation
  connect(spacePhasorS.plug_n, plug_sn) annotation (Line(
      points={{-10,80},{-60,80},{-60,100}}, color={0,0,255}));
  connect(strayLoad.plug_n, rs.plug_p) annotation (Line(
      points={{70,80},{60,80}}, color={0,0,255}));
  connect(strayLoad.plug_p, plug_sp) annotation (Line(
      points={{90,80},{90,100},{60,100}}, color={0,0,255}));
  connect(strayLoad.support, internalSupport) annotation (Line(
      points={{80,70},{80,50},{60,50},{60,-100}}));
  connect(spacePhasorS.plug_p, rs.plug_n) annotation (Line(
      points={{10,80},{40,80}}, color={0,0,255}));
  connect(spacePhasorS.zero, lszero.p) annotation (Line(
      points={{0,60},{0,50}}, color={0,0,255}));
  connect(lszero.n, spacePhasorS.ground) annotation (Line(
      points={{-20,50},{-20,60},{-10,60}}, color={0,0,255}));
  connect(spacePhasorS.spacePhasor, lssigma.spacePhasor_a) annotation (Line(
      points={{10,60},{20,60},{20,30}}, color={0,0,255}));
  connect(statorCore.spacePhasor, lssigma.spacePhasor_a) annotation (Line(
      points={{10,30},{20,30}}, color={0,0,255}));
  connect(statorCore.heatPort, internalThermalPort.heatPortStatorCore)
    annotation (Line(
      points={{10,40},{50,40},{50,-79.2},{0.4,-79.2}}, color={191,0,0}));
  connect(strayLoad.heatPort, internalThermalPort.heatPortStrayLoad)
    annotation (Line(
      points={{90,70},{90,60},{50,60},{50,-80},{0.4,-80}}, color={191,0,0}));
  connect(rs.heatPort, internalThermalPort.heatPortStatorWinding)
    annotation (Line(
      points={{50,70},{50,-79.2},{-0.4,-79.2}}, color={191,0,0}));
  connect(friction.heatPort, internalThermalPort.heatPortFriction)
    annotation (Line(
      points={{80,-50},{50,-50},{50,-81.6},{0,-81.6}}, color={191,0,0}));
  connect(strayLoad.flange, inertiaRotor.flange_b) annotation (Line(
      points={{80,90},{100,90},{100,40},{90,40},{90,0}}));
  connect(internalThermalPort, thermalPort)
    annotation (Line(points={{0,-80},{0,-80},{0,-100}}, color={191,0,0}));
  connect(thermalAmbient.thermalPort, internalThermalPort) annotation (Line(
        points={{-20,-80},{-12,-80},{0,-80}}, color={191,0,0}));
  annotation (Documentation(info="<html>
Partial model for induction machine models
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}),graphics={Line(points={{-50,100},{-20,100},{-20,70}},
            color={0,0,255}), Line(points={{50,100},{20,100},{20,70}},
            color={0,0,255})}));
end PartialBasicInductionMachine;
