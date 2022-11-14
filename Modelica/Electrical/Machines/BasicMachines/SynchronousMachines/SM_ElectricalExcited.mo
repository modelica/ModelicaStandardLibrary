within Modelica.Electrical.Machines.BasicMachines.SynchronousMachines;
model SM_ElectricalExcited
  "Electrical excited synchronous machine with damper cage"
  extends Machines.Interfaces.PartialBasicInductionMachine(
    Lssigma(start=0.1*ZsRef/(2*pi*fsNominal)),
    final idq_ss=airGap.i_ss,
    final idq_sr=airGap.i_sr,
    final idq_rs=airGap.i_rs,
    final idq_rr=airGap.i_rr,
    redeclare final Machines.Thermal.SynchronousMachines.ThermalAmbientSMEE
      thermalAmbient(
      final useDamperCage=useDamperCage,
      final Te=TeOperational,
      final Tr=TrOperational),
    redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMEE
      thermalPort(final useDamperCage=useDamperCage),
    redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMEE
      internalThermalPort(final useDamperCage=useDamperCage),
    redeclare final Machines.Interfaces.InductionMachines.PowerBalanceSMEE
      powerBalance(
      final lossPowerRotorWinding=damperCageLossPower,
      final powerExcitation=ve*ie,
      final lossPowerExcitation=re.LossPower,
      final lossPowerBrush=brush.lossPower,
      final lossPowerRotorCore=0),
    statorCore(final w=statorCoreParameters.wRef));
  Modelica.Blocks.Interfaces.RealOutput ir[2](
    start=zeros(2),
    each final quantity="ElectricCurrent",
    each final unit="A") if useDamperCage "Damper cage currents"
    annotation (Placement(visible=false),Dialog(showStartAttribute=true));
  Modelica.Blocks.Interfaces.RealOutput idq_dr[2](
    each stateSelect=StateSelect.prefer,
    each final quantity="ElectricCurrent",
    each final unit="A") if useDamperCage
    "Damper space phasor current / rotor fixed frame"
    annotation (Placement(visible=false));
  Machines.BasicMachines.Components.AirGapR airGap(
    final p=p,
    final Lmd=Lmd,
    final Lmq=Lmq,
    final m=m) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270)));
  parameter SI.Temperature TrOperational(start=293.15)
    "Operational temperature of (optional) damper cage" annotation (
      Dialog(group="Operational temperatures", enable=not useThermalPort
           and useDamperCage));
  parameter SI.Inductance Lmd(start=1.5*ZsRef/(2*pi*fsNominal))
    "Stator main field inductance per phase in d-axis"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Inductance Lmq(start=1.5*ZsRef/(2*pi*fsNominal))
    "Stator main field inductance per phase in q-axis"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Boolean useDamperCage(start=true)
    "Enable / disable damper cage" annotation (Evaluate=true, Dialog(tab=
          "Nominal resistances and inductances", group="Damper cage"));
  parameter SI.Inductance Lrsigmad(start=0.05*ZsRef/(2*pi*
        fsNominal)) "Damper stray inductance in d-axis" annotation (
      Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Inductance Lrsigmaq=Lrsigmad
    "Damper stray inductance in q-axis" annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Resistance Rrd(start=0.04*ZsRef)
    "Damper resistance in d-axis at TRef" annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Resistance Rrq=Rrd
    "Damper resistance in q-axis at TRef" annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Temperature TrRef(start=293.15)
    "Reference temperature of damper resistances in d- and q-axis"
    annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start=0)
    "Temperature coefficient of damper resistances in d- and q-axis"
    annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter SI.Voltage VsNominal(start=100)
    "Nominal stator RMS voltage per phase"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Current IeOpenCircuit(start=10)
    "Open circuit excitation current @ nominal voltage and frequency"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Resistance Re(start=2.5)
    "Excitation resistance at TRef" annotation (Dialog(tab="Excitation"));
  parameter SI.Temperature TeRef(start=293.15)
    "Reference temperature of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(start=0)
    "Temperature coefficient of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter Real sigmae(
    min=0,
    max=0.99,
    start=0.025) "Stray fraction of total excitation inductance"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Temperature TeOperational(start=293.15)
    "Operational excitation temperature" annotation (Dialog(group=
          "Operational temperatures", enable=not useThermalPort));
  parameter Machines.Losses.BrushParameters brushParameters
    "Brush loss parameter record" annotation (Dialog(tab="Losses"));
  output SI.Voltage ve=pin_ep.v - pin_en.v
    "Excitation voltage";
  output SI.Current ie=pin_ep.i "Excitation current";
  Machines.BasicMachines.Components.DamperCage damperCage(
    final Lrsigmad=Lrsigmad,
    final Lrsigmaq=Lrsigmaq,
    final Rrd=Rrd,
    final Rrq=Rrq,
    final T_ref=TrRef,
    final alpha=Machines.Thermal.convertAlpha(alpha20r, TrRef),
    final useHeatPort=true) if useDamperCage annotation (Placement(
        transformation(
        origin={0,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Machines.BasicMachines.Components.ElectricalExcitation electricalExcitation(final
      turnsRatio=turnsRatio) annotation (Placement(transformation(
        origin={-70,-50},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Resistor re(
    final R=Re,
    final T_ref=TeRef,
    final alpha=Machines.Thermal.convertAlpha(alpha20e, TeRef),
    final useHeatPort=true) annotation (Placement(transformation(
        origin={-80,10},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Inductor lesigma(final L=Lesigma)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-80,-20})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
    "Positive excitation pin" annotation (Placement(transformation(extent=
           {{-110,70},{-90,50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
    "Negative excitation pin" annotation (Placement(transformation(extent=
           {{-90,-50},{-110,-70}})));
  Machines.Losses.DCMachines.Brush brush(final brushParameters=brushParameters,
      final useHeatPort=true) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-80,40})));
protected
  final parameter Real turnsRatio=sqrt(2)*VsNominal/(2*pi*fsNominal*Lmd*
      IeOpenCircuit) "Stator current / excitation current";
  final parameter SI.Inductance Lesigma=Lmd*turnsRatio^2*3/
      2*sigmae/(1 - sigmae);
  Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
      quantity="Power", final unit="W") "Damper losses";
equation
  connect(ir, damperCage.i);
  connect(idq_dr, damperCage.i);
  connect(damperCageLossPower, damperCage.lossPower);
  if not useDamperCage then
    damperCageLossPower = 0;
  end if;
  connect(airGap.spacePhasor_r, damperCage.spacePhasor_r)
    annotation (Line(points={{10,-10},{10,-30}}, color={0,0,255}));
  connect(airGap.spacePhasor_r, electricalExcitation.spacePhasor_r)
    annotation (Line(points={{10,-10},{10,-10},{10,-20},{-60,-20},{-60,-40}}, color={0,0,255}));
  connect(electricalExcitation.pin_en, pin_en) annotation (Line(
      points={{-80,-60},{-100,-60}}, color={0,0,255}));
  connect(pin_ep, brush.p) annotation (Line(
      points={{-100,60},{-80,60},{-80,50}}, color={0,0,255}));
  connect(brush.n, re.p) annotation (Line(
      points={{-80,30},{-80,20}}, color={0,0,255}));
  connect(re.n, lesigma.p) annotation (Line(
      points={{-80,0},{-80,-10}}, color={0,0,255}));
  connect(lesigma.n, electricalExcitation.pin_ep) annotation (Line(
      points={{-80,-30},{-80,-40}}, color={0,0,255}));
  connect(lssigma.spacePhasor_b, airGap.spacePhasor_s) annotation (Line(
      points={{20,10},{10,10}}, color={0,0,255}));
  connect(brush.heatPort, internalThermalPort.heatPortBrush) annotation (
      Line(
      points={{-70,50},{-60,50},{-60,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
  connect(re.heatPort, internalThermalPort.heatPortExcitation)
    annotation (Line(
      points={{-70,10},{-60,10},{-60,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
  connect(airGap.flange, inertiaRotor.flange_a) annotation (Line(
      points={{10,0},{70,0}}));
  connect(airGap.support, internalSupport) annotation (Line(
      points={{-10,0},{-26,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));

  connect(damperCage.heatPort, internalThermalPort.heatPortRotorWinding)
    annotation (Line(
      points={{-10,-40},{-10,-80},{0,-80},{0,-80}}, color={191,0,0}));
  annotation (
    defaultComponentName="smee",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255}),
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
<p><strong>Model of a three-phase electrical excited synchronous machine with damper cage.</strong><br>
Resistance and stray inductance of stator is modeled directly in stator phases, then using space phasor transformation and a rotor-fixed <em>AirGap</em> model. Resistance and stray inductance of rotor's squirrel cage is modeled in two axis of the rotor-fixed coordinate system. Electrical excitation is modelled by converting excitation current and voltage to d-axis space phasors. The machine models take the following loss effects into account:
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

<p>Whether a damper cage is present or not, can be selected with Boolean parameter useDamperCage (default = true).
<br><strong>Default values for machine's parameters (a realistic example) are:</strong><br></p>
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
<td>no-load excitation current<br>
    @ nominal voltage and frequency</td>
<td>10</td><td>A DC</td>
</tr>
<tr>
<td>warm excitation resistance</td>
<td>2.5</td><td>Ohm</td>
</tr>
<tr>
<td>nominal current per phase</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>nominal apparent power</td>
<td>-30000</td><td>VA</td>
</tr>
<tr>
<td>power factor</td>
<td>-1.0</td><td>ind./cap.</td>
</tr>
<tr>
<td>nominal excitation current</td>
<td>19</td><td>A</td>
</tr>
<tr>
<td>efficiency w/o excitation</td>
<td>97.1</td><td>%</td>
</tr>
<tr>
<td>nominal torque</td>
<td>-196.7</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1500</td><td>rpm</td>
</tr>
<tr>
<td>nominal rotor angle</td>
<td>-57.23</td><td>degree</td>
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
<td>stator reactance Xd</td>
<td>1.6</td><td>Ohm per phase in d-axis</td>
</tr>
<tr>
<td>giving Kc</td>
<td>0.625</td><td> </td>
</tr>
<tr>
<td>stator reactance Xq</td>
<td>1.6</td><td>Ohm per phase in q-axis</td>
</tr>
<tr>
<td>stator stray reactance Xss</td>
<td>0.1</td><td>Ohm per phase</td>
</tr>
<tr>
<td>damper resistance in d-axis</td>
<td>0.04</td><td>Ohm at reference temperature</td>
</tr>
<tr>
<td>damper resistance in q-axis</td>
<td>same as d-axis</td><td> </td>
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
<td>damper stray reactance in d-axis XDds</td>
<td>0.05</td><td>Ohm</td>
</tr>
<tr>
<td>damper stray reactance in q-axis XDqs</td>
<td>same as d-axis</td><td> </td>
</tr>
<tr>
<td>excitation resistance</td>
<td>2.5</td><td>Ohm at reference temperature</td>
</tr>
<tr>
<td>reference temperature TeRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20e </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>excitation stray inductance</td>
<td>2.5</td><td>% of total excitation inductance</td>
</tr>
<tr>
<td>stator operational temperature TsOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>damper operational temperature TrOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>excitation operational temperature TeOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>These values give the following inductances:</td>
<td> </td><td> </td>
</tr>
<tr>
<td>main field inductance in d-axis</td>
<td>(Xd - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>main field inductance in q-axis</td>
<td>(Xq - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>stator stray inductance per phase</td>
<td>Xss/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>damper stray inductance in d-axis</td>
<td>XDds/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>damper stray inductance in q-axis</td>
<td>XDqs/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</html>"));
end SM_ElectricalExcited;
