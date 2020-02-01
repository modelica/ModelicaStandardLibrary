within Modelica.Electrical.Machines.BasicMachines.DCMachines;
model DC_SeriesExcited "Series excited linear DC machine"
  extends Machines.Interfaces.PartialBasicDCMachine(
    wNominal(start=1410*2*pi/60),
    final ViNominal=VaNominal - (Machines.Thermal.convertResistance(
        Ra,
        TaRef,
        alpha20a,
        TaNominal) + Machines.Thermal.convertResistance(
        Re,
        TeRef,
        alpha20e,
        TeNominal))*IaNominal - Machines.Losses.DCMachines.brushVoltageDrop(
        brushParameters, IaNominal),
    final psi_eNominal=Lme*abs(IaNominal),
    redeclare final Machines.Thermal.DCMachines.ThermalAmbientDCSE
      thermalAmbient(final Tse=TeOperational),
    redeclare final Machines.Interfaces.DCMachines.ThermalPortDCSE thermalPort,

    redeclare final Machines.Interfaces.DCMachines.ThermalPortDCSE
      internalThermalPort,
    redeclare final Machines.Interfaces.DCMachines.PowerBalanceDCSE
      powerBalance(final powerSeriesExcitation=ve*ie, final
        lossPowerSeriesExcitation=re.LossPower),
    core(final w=airGapDC.w));
  parameter SI.Resistance Re(start=0.01)
    "Series excitation resistance at TeRef"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Temperature TeRef(start=293.15)
    "Reference temperature of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(start=0)
    "Temperature coefficient of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Inductance Le(start=0.0005)
    "Total field excitation inductance"
    annotation (Dialog(tab="Excitation"));
  parameter Real sigmae(
    min=0,
    max=0.99,
    start=0) "Stray fraction of total excitation inductance"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Temperature TeNominal(start=293.15)
    "Nominal series excitation temperature"
    annotation (Dialog(tab="Nominal parameters"));
  parameter SI.Temperature TeOperational(start=293.15)
    "Operational series excitation temperature" annotation (Dialog(group=
          "Operational temperatures", enable=not useThermalPort));
  output SI.Voltage ve=pin_ep.v - pin_en.v
    "Field excitation voltage";
  output SI.Current ie=pin_ep.i "Field excitation current";
  Machines.BasicMachines.Components.AirGapDC airGapDC(
    final turnsRatio=turnsRatio,
    final Le=Lme,
    final quasiStatic=quasiStatic) annotation (Placement(transformation(extent=
            {{-10,-10},{10,10}}, rotation=270)));
  Machines.BasicMachines.Components.CompoundDCExcitation compoundDCExcitation(final
      excitationTurnsRatio=1)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Modelica.Electrical.Analog.Basic.Ground groundE
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Electrical.Analog.Basic.Resistor re(
    final R=Re,
    final T_ref=TeRef,
    final alpha=Machines.Thermal.convertAlpha(alpha20e, TeRef),
    final useHeatPort=true) annotation (Placement(transformation(
        origin={-80,50},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Machines.BasicMachines.Components.InductorDC lesigma(final L=Lesigma, final
      quasiStatic=quasiStatic) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,20})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
    "Positive series excitation pin" annotation (Placement(transformation(
          extent={{-110,70},{-90,50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
    "Negative series excitation pin" annotation (Placement(transformation(
          extent={{-90,-50},{-110,-70}})));
protected
  final parameter SI.Inductance Lme=Le*(1 - sigmae)
    "Main part of excitation inductance";
  final parameter SI.Inductance Lesigma=Le*sigmae
    "Stray part of excitation inductance" annotation (Evaluate=true);
equation
  connect(airGapDC.pin_ap, la.n) annotation (Line(
      points={{10,10},{10,60}}, color={0,0,255}));
  connect(airGapDC.support, internalSupport) annotation (Line(
      points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
  connect(airGapDC.flange, inertiaRotor.flange_a) annotation (Line(
      points={{10,0},{70,0},{70,0}}));
  connect(pin_ep, re.p) annotation (Line(
      points={{-100,60},{-80,60}}, color={0,0,255}));
  connect(re.n, lesigma.p) annotation (Line(
      points={{-80,40},{-80,30}}, color={0,0,255}));
  connect(airGapDC.pin_en, compoundDCExcitation.pin_n) annotation (Line(
      points={{-10,-10},{-10,-10}}, color={0,0,255}));
  connect(compoundDCExcitation.pin_p, airGapDC.pin_ep) annotation (Line(
      points={{10,-10},{10,-10}}, color={0,0,255}));
  connect(airGapDC.pin_en, ground.p) annotation (Line(
      points={{-10,-10},{-20,-10}}, color={0,0,255}));
  connect(compoundDCExcitation.pin_sen, pin_en) annotation (Line(
      points={{-10,-30},{-10,-60},{-100,-60}}, color={0,0,255}));
  connect(compoundDCExcitation.pin_sep, lesigma.n) annotation (Line(
      points={{-2,-30},{-2,-40},{-80,-40},{-80,10}}, color={0,0,255}));
  connect(compoundDCExcitation.pin_en, groundE.p) annotation (Line(
      points={{2,-30},{2,-40},{10,-40}}, color={0,0,255}));
  connect(airGapDC.pin_an, brush.p) annotation (Line(
      points={{-10,10},{-10,60}}, color={0,0,255}));
  connect(re.heatPort, internalThermalPort.heatPortSeriesExcitation)
    annotation (Line(
      points={{-70,50},{-60,50},{-60,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
  annotation (
    defaultComponentName="dcse",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-100,-10},{-105,-9},{-109,-5},{-110,0},{-109,5},{-105,
              9},{-100,10}}, color={0,0,255}),
        Line(points={{-100,-30},{-105,-29},{-109,-25},{-110,-20},{-109,-15},
              {-105,-11},{-100,-10}}, color={0,0,255}),
        Line(points={{-100,10},{-105,11},{-109,15},{-110,20},{-109,25},{-105,
              29},{-100,30}}, color={0,0,255}),
        Line(points={{-100,50},{-100,30}}, color={0,0,255}),
        Line(points={{-100,-30},{-100,-50}}, color={0,0,255})}),
    Documentation(info="<html>
<p><strong>Model of a DC Machine with series excitation.</strong><br>
Armature resistance and inductance are modeled directly after the armature pins, then using a <em>AirGapDC</em> model.<br>
The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent armature winding resistance</li>
<li>heat losses in the temperature dependent excitation winding resistance</li>
<li>brush losses in the armature circuit</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<p>No saturation is modelled.<br>
Series excitation has to be connected by the user's external circuit.
<br><strong>Default values for machine's parameters (a realistic example) are:</strong><br></p>
<table>
<tr>
<td>stator's moment of inertia</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>rotor's moment of inertia</td>
<td>0.15</td><td>kg.m2</td>
</tr>
<tr>
<td>nominal armature voltage</td>
<td>100</td><td>V</td>
</tr>
<tr>
<td>nominal armature current</td>
<td>100</td><td>A</td>
</tr>
<tr>
<td>nominal torque</td>
<td>63.66</td><td>Nm</td>
</tr>
<tr>
<td>nominal speed</td>
<td>1410</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>9.4</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>94.0</td><td>% only armature</td>
</tr>
<tr>
<td>armature resistance</td>
<td>0.05</td><td>Ohm at reference temperature</td>
</tr>
<tr>
<td>reference temperature TaRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20a </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>armature inductance</td>
<td>0.0015</td><td>H</td>
</tr>
<tr>
<td>excitation resistance</td>
<td>0.01</td><td>Ohm at reference temperature</td>
</tr>
<tr>
<td>reference temperature TeRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>temperature coefficient alpha20e</td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>excitation inductance</td>
<td>0.0005</td><td>H</td>
</tr>
<tr>
<td>stray part of excitation inductance</td>
<td>0</td><td> </td>
</tr>
<tr>
<td>armature nominal temperature TaNominal</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>series excitation nominal temperature TeNominal</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>armature operational temperature TaOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>series excitation operational temperature TeOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
</table>
Armature resistance resp. inductance include resistance resp. inductance of commutating pole winding and
compensation winding, if present.<br>
Parameter nominal armature voltage includes voltage drop of series excitation;<br>
but for output the voltage is split into:<br>
va = armature voltage without voltage drop of series excitation<br>
ve = voltage drop of series excitation
</html>"));
end DC_SeriesExcited;
