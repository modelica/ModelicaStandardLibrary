within Modelica.Electrical.Machines.Interfaces;
partial model PartialBasicDCMachine "Partial model for DC machine"
  parameter SI.Temperature TaOperational(start=293.15)
    "Operational armature temperature" annotation (Dialog(group=
          "Operational temperatures", enable=not useThermalPort));
  parameter SI.Voltage VaNominal(start=100)
    "Nominal armature voltage" annotation (Dialog(tab="Nominal parameters"));
  parameter SI.Current IaNominal(start=100)
    "Nominal armature current (>0..Motor, <0..Generator)"
    annotation (Dialog(tab="Nominal parameters"));
  parameter SI.AngularVelocity wNominal(displayUnit="rev/min",
      start=1425*2*pi/60) "Nominal speed"
    annotation (Dialog(tab="Nominal parameters"));
  parameter SI.Temperature TaNominal(start=293.15)
    "Nominal armature temperature"
    annotation (Dialog(tab="Nominal parameters"));
  parameter SI.Resistance Ra(start=0.05)
    "Armature resistance at TaRef"
    annotation (Dialog(tab="Armature"));
  parameter SI.Temperature TaRef(start=293.15)
    "Reference temperature of armature resistance"
    annotation (Dialog(tab="Armature"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20a(start=0)
    "Temperature coefficient of armature resistance"
    annotation (Dialog(tab="Armature"));
  parameter SI.Inductance La(start=0.0015)
    "Armature inductance"
    annotation (Dialog(tab="Armature"));
  extends PartialBasicMachine(
    Jr(start=0.15),
    frictionParameters(wRef=wNominal),
    friction(final useHeatPort=true));
  parameter Machines.Losses.CoreParameters coreParameters(
    final m=1,
    VRef=ViNominal,
    wRef=wNominal) "Armature core loss parameter record"
    annotation (Dialog(tab="Losses"));
  parameter Machines.Losses.StrayLoadParameters strayLoadParameters(IRef=
        IaNominal, wRef=wNominal) "Stray load loss parameter record"
    annotation (Dialog(tab="Losses"));
  parameter Machines.Losses.BrushParameters brushParameters(ILinear=0.01*
        IaNominal) "Brush loss parameter record"
    annotation (Dialog(tab="Losses"));
  replaceable output
    Machines.Interfaces.DCMachines.PartialPowerBalanceDCMachines powerBalance(
    final powerArmature=va*ia,
    final powerMechanical=wMechanical*tauShaft,
    final powerInertiaStator=inertiaStator.J*inertiaStator.a*inertiaStator.w,
    final powerInertiaRotor=inertiaRotor.J*inertiaRotor.a*inertiaRotor.w,
    final lossPowerArmature=ra.LossPower,
    final lossPowerCore=core.lossPower,
    final lossPowerStrayLoad=strayLoad.lossPower,
    final lossPowerFriction=friction.lossPower,
    final lossPowerBrush=brush.lossPower) "Power balance";

  output SI.Voltage va=pin_ap.v - pin_an.v "Armature voltage";
  output SI.Current ia(start=0) = pin_ap.i "Armature current";
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ap
    "Positive armature pin" annotation (Placement(transformation(extent={{
            50,110},{70,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_an
    "Negative armature pin" annotation (Placement(transformation(extent={{-70,
            110},{-50,90}})));
  Modelica.Electrical.Analog.Basic.Resistor ra(
    final R=Ra,
    final T_ref=TaRef,
    final alpha=Machines.Thermal.convertAlpha(alpha20a, TaRef),
    final useHeatPort=true) annotation (Placement(transformation(extent={{60,50},{40,
            70}})));
  Machines.BasicMachines.Components.InductorDC la(final L=La, final quasiStatic=
       quasiStatic)
    annotation (Placement(transformation(extent={{30,50},{10,70}})));
  Machines.Losses.DCMachines.Brush brush(final brushParameters=brushParameters,
      final useHeatPort=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,60})));
  Machines.Losses.DCMachines.Core core(final coreParameters=coreParameters,
      final useHeatPort=true)
    annotation (Placement(transformation(extent={{10,70},{-10,90}})));
  Machines.Losses.DCMachines.StrayLoad strayLoad(final strayLoadParameters=
        strayLoadParameters, final useHeatPort=true)
    annotation (Placement(transformation(extent={{90,50},{70,70}})));
  replaceable Machines.Interfaces.DCMachines.PartialThermalPortDCMachines thermalPort if
    useThermalPort
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  replaceable Machines.Interfaces.DCMachines.PartialThermalAmbientDCMachines thermalAmbient(final
      useTemperatureInputs=false, final Ta=TaOperational) if not useThermalPort
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-80})));
protected
  constant Real pi = Modelica.Constants.pi;
  constant Boolean quasiStatic=false "No electrical transients if true"
    annotation (Evaluate=true);
  parameter SI.Voltage ViNominal "Nominal induced Voltage";
  parameter SI.MagneticFlux psi_eNominal
    "Nominal magnetic flux";
  parameter Real turnsRatio=ViNominal/(wNominal*psi_eNominal)
    "Ratio of armature turns over number of turns of the excitation winding";
  replaceable Machines.Interfaces.DCMachines.PartialThermalPortDCMachines internalThermalPort
    annotation (Placement(transformation(extent={{-4,-84},{4,-76}})));
equation
  assert(ViNominal > Modelica.Constants.eps,
    "VaNominal has to be > (Ra[+Rse])*IaNominal");
  connect(la.p, ra.n)
    annotation (Line(points={{30,60},{40,60}}, color={0,0,255}));
  connect(brush.n, pin_an) annotation (Line(
      points={{-30,60},{-60,60},{-60,100}}, color={0,0,255}));
  connect(pin_ap, strayLoad.p) annotation (Line(
      points={{60,100},{90,100},{90,60}}, color={0,0,255}));
  connect(strayLoad.n, ra.p) annotation (Line(
      points={{70,60},{60,60}}, color={0,0,255}));
  connect(strayLoad.support, internalSupport) annotation (Line(
      points={{80,50},{80,30},{60,30},{60,-100}}));
  connect(la.p, core.p) annotation (Line(
      points={{30,60},{30,80},{10,80}}, color={0,0,255}));
  connect(core.n, brush.p) annotation (Line(
      points={{-10,80},{-10,60}}, color={0,0,255}));
  connect(core.heatPort, internalThermalPort.heatPortCore) annotation (Line(
      points={{10,70},{10,40},{50,40},{50,-79.2},{0.4,-79.2}}, color={191,0,0}));
  connect(brush.heatPort, internalThermalPort.heatPortBrush) annotation (
      Line(
      points={{-10,50},{-10,40},{50,40},{50,-78.4},{0,-78.4}}, color={191,0,0}));
  connect(strayLoad.heatPort, internalThermalPort.heatPortStrayLoad)
    annotation (Line(
      points={{90,50},{90,40},{50,40},{50,-80},{0.4,-80}}, color={191,0,0}));
  connect(friction.heatPort, internalThermalPort.heatPortFriction)
    annotation (Line(
      points={{80,-50},{50,-50},{50,-80.8},{0.4,-80.8}}, color={191,0,0}));
  connect(ra.heatPort, internalThermalPort.heatPortArmature) annotation (
      Line(
      points={{50,50},{50,-79.2},{-0.4,-79.2}}, color={191,0,0}));
  connect(inertiaRotor.flange_b, strayLoad.flange) annotation (Line(
      points={{90,0},{92,0},{92,30},{100,30},{100,70},{80,70}}));
  connect(thermalAmbient.thermalPort, internalThermalPort) annotation (Line(
        points={{-20,-80},{-12,-80},{0,-80}}, color={191,0,0}));
  connect(internalThermalPort, thermalPort)
    annotation (Line(points={{0,-80},{0,-100}}, color={191,0,0}));
  annotation (Documentation(info="<html>
Partial model for DC machine models.
</html>"),
       Icon(graphics={Line(points={{-40,70},{-60,70},{-60,90}}, color={0,0,255}),
               Line(points={{40,70},{60,70},{60,90}}, color={0,0,255})}));
end PartialBasicDCMachine;
