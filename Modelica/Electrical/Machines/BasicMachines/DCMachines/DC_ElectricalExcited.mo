within Modelica.Electrical.Machines.BasicMachines.DCMachines;
model DC_ElectricalExcited
  "Electrical shunt/separate excited linear DC machine"
  extends Machines.Interfaces.PartialBasicDCMachine(
    final ViNominal=VaNominal - Machines.Thermal.convertResistance(
        Ra,
        TaRef,
        alpha20a,
        TaNominal)*IaNominal - Machines.Losses.DCMachines.brushVoltageDrop(
        brushParameters, IaNominal),
    final psi_eNominal=Lme*IeNominal,
    redeclare final Machines.Thermal.DCMachines.ThermalAmbientDCEE
      thermalAmbient(final Te=TeOperational),
    redeclare final Machines.Interfaces.DCMachines.ThermalPortDCEE thermalPort,

    redeclare final Machines.Interfaces.DCMachines.ThermalPortDCEE
      internalThermalPort,
    redeclare final Machines.Interfaces.DCMachines.PowerBalanceDCEE
      powerBalance(final powerExcitation=ve*ie, final lossPowerExcitation=re.LossPower),

    core(final w=airGapDC.w));
  parameter SI.Current IeNominal(start=1)
    "Nominal excitation current" annotation (Dialog(tab="Excitation"));
  parameter SI.Resistance Re(start=100)
    "Field excitation resistance at TeRef"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Temperature TeRef(start=293.15)
    "Reference temperature of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(start=0)
    "Temperature coefficient of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Inductance Le(start=1)
    "Total field excitation inductance"
    annotation (Dialog(tab="Excitation"));
  parameter Real sigmae(
    min=0,
    max=0.99,
    start=0) "Stray fraction of total excitation inductance"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Temperature TeOperational(start=293.15)
    "Operational (shunt) excitation temperature" annotation (Dialog(group=
         "Operational temperatures", enable=not useThermalPort));
  output SI.Voltage ve=pin_ep.v - pin_en.v
    "Field excitation voltage";
  output SI.Current ie(start=0) = pin_ep.i
    "Field excitation current";
  Machines.BasicMachines.Components.AirGapDC airGapDC(
    final turnsRatio=turnsRatio,
    final Le=Lme,
    final quasiStatic=quasiStatic) annotation (Placement(transformation(extent=
            {{-10,-10},{10,10}}, rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Machines.BasicMachines.Components.CompoundDCExcitation compoundDCExcitation(final
      excitationTurnsRatio=1)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Electrical.Analog.Basic.Ground groundSE
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Modelica.Electrical.Analog.Basic.Resistor re(
    final R=Re,
    final T_ref=TeRef,
    final alpha=Machines.Thermal.convertAlpha(alpha20e, TeRef),
    final useHeatPort=true) annotation (Placement(transformation(
        origin={-80,50},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Machines.BasicMachines.Components.InductorDC lesigma(final L=Lesigma, final
      quasiStatic=quasiStatic) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,20})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
    "Positive excitation pin" annotation (Placement(transformation(extent=
           {{-110,70},{-90,50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
    "Negative excitation pin" annotation (Placement(transformation(extent=
           {{-90,-50},{-110,-70}})));
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
      points={{10,0},{35,0},{35,0},{70,0}}));
  connect(re.p, pin_ep) annotation (Line(
      points={{-80,60},{-100,60}}, color={0,0,255}));
  connect(re.n, lesigma.p) annotation (Line(
      points={{-80,40},{-80,30}}, color={0,0,255}));
  connect(ground.p, airGapDC.pin_en) annotation (Line(
      points={{-20,-10},{-10,-10}}, color={0,0,255}));
  connect(airGapDC.pin_en, compoundDCExcitation.pin_n) annotation (Line(
      points={{-10,-10},{-10,-10}}, color={0,0,255}));
  connect(airGapDC.pin_ep, compoundDCExcitation.pin_p) annotation (Line(
      points={{10,-10},{10,-10}}, color={0,0,255}));
  connect(groundSE.p, compoundDCExcitation.pin_sen) annotation (Line(
      points={{-20,-30},{-10,-30}}, color={0,0,255}));
  connect(pin_en, compoundDCExcitation.pin_en) annotation (Line(
      points={{-100,-60},{2,-60},{2,-30}}, color={0,0,255}));
  connect(compoundDCExcitation.pin_ep, lesigma.n) annotation (Line(
      points={{10,-29.8},{10,-40},{-80,-40},{-80,10}}, color={0,0,255}));
  connect(airGapDC.pin_an, brush.p) annotation (Line(
      points={{-10,10},{-10,60}}, color={0,0,255}));
  connect(re.heatPort, internalThermalPort.heatPortExcitation)
    annotation (Line(
      points={{-70,50},{-60,50},{-60,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
  annotation (
    defaultComponentName="dcee",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-130,-4},{-129,1},{-125,5},{-120,6},{-115,5},{-111,
              1},{-110,-4}}, color={0,0,255}),
        Line(points={{-110,-4},{-109,1},{-105,5},{-100,6},{-95,5},{-91,1},
              {-90,-4}}, color={0,0,255}),
        Line(points={{-90,-4},{-89,1},{-85,5},{-80,6},{-75,5},{-71,1},{-70,
              -4}}, color={0,0,255}),
        Line(points={{-100,-50},{-100,-20},{-70,-20},{-70,-2}}, color={0,0,255}),
        Line(points={{-100,50},{-100,20},{-130,20},{-130,-4}}, color={0,0,
              255})}),
    Documentation(info="<html>
<p><strong>Model of a DC Machine with electrical shunt or separate excitation.</strong><br>
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
Shunt or separate excitation is defined by the user's external circuit.
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
<td>1425</td><td>rpm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>9.5</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>95.0</td><td>% only armature</td>
</tr>
<tr>
<td>efficiency</td>
<td>94.06</td><td>% including excitation</td>
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
<td>nominal excitation voltage</td>
<td>100</td><td>V</td>
</tr>
<tr>
<td>nominal excitation current</td>
<td>1</td><td>A</td>
</tr>
<tr>
<td>excitation resistance</td>
<td>100</td><td>Ohm at reference temperature</td>
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
<td>excitation inductance</td>
<td>1</td><td>H</td>
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
<td>armature operational temperature TaOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>(shunt) excitation operational temperature TeOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
</table>
Armature resistance resp. inductance include resistance resp. inductance of commutating pole winding and
compensation winding, if present.<br>
Armature current does not cover excitation current of a shunt excitation; in this case total current drawn from the grid = armature current + excitation current.
</html>"));
end DC_ElectricalExcited;
