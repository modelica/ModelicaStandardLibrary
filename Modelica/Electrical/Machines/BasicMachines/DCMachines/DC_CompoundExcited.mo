within Modelica.Electrical.Machines.BasicMachines.DCMachines;
model DC_CompoundExcited "Compound excited linear DC machine"
  extends Machines.Interfaces.PartialBasicDCMachine(
    wNominal(start=1410*2*pi/60),
    final ViNominal=VaNominal - (Machines.Thermal.convertResistance(
        Ra,
        TaRef,
        alpha20a,
        TaNominal) + Machines.Thermal.convertResistance(
        Res,
        TeRef,
        alpha20e,
        TeNominal))*IaNominal - Machines.Losses.DCMachines.brushVoltageDrop(brushParameters, IaNominal),
    final psi_eNominal=Lme*IeNominal + excitationTurnsRatio*Lme*abs(IaNominal),
    redeclare final Machines.Thermal.DCMachines.ThermalAmbientDCCE thermalAmbient(Te=TeOperational,
        final Tse=TeOperational),
    redeclare final Machines.Interfaces.DCMachines.ThermalPortDCCE thermalPort,
    redeclare final Machines.Interfaces.DCMachines.ThermalPortDCCE internalThermalPort,
    redeclare final Machines.Interfaces.DCMachines.PowerBalanceDCCE powerBalance(
      final powerShuntExcitation=vee*iee,
      final lossPowerShuntExcitation=ree.LossPower,
      final powerSeriesExcitation=ves*ies,
      final lossPowerSeriesExcitation=res.LossPower),
    core(final w=airGapDC.w));

  parameter SI.Current IeNominal(start=1)
    "Nominal shunt excitation current" annotation (Dialog(tab="Excitation"));
  parameter SI.Resistance Res(start=0.01) "Series excitation resistance at TeRef"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Resistance Ree(start=100) "Shunt excitation resistance at TeRef"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Temperature TeRef(start=293.15) "Reference temperature of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(start=0)
    "Temperature coefficient of excitation resistance" annotation (Dialog(tab="Excitation"));
  parameter SI.Inductance Le(start=1) "Total field excitation inductance"
    annotation (Dialog(tab="Excitation"));
  parameter Real sigmae(
    min=0,
    max=0.99,
    start=0) "Stray fraction of total excitation inductance"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Temperature TeNominal(start=293.15) "Nominal series excitation temperature"
    annotation (Dialog(tab="Nominal parameters"));
  parameter SI.Temperature TeOperational(start=293.15) "Operational series excitation temperature"
    annotation (Dialog(group="Operational temperatures", enable=not useThermalPort));
  parameter Real excitationTurnsRatio(start=-0.005) "Ratio of series excitation turns over shunt excitation turns"
    annotation (Dialog(tab="Excitation"));
  parameter Boolean considerSaturation=true "Consider saturation of excitation inductance"
    annotation (Dialog(tab="Excitation", group="Saturation"), choices(checkBox=true));
  parameter SI.Inductance Lzer=Le*10 "Inductance near current=0"
    annotation (Dialog(
      tab="Excitation",
      group="Saturation",
      enable=considerSaturation));
  parameter SI.Inductance Linf=Le/10 "Inductance at large currents"
    annotation (Dialog(
      tab="Excitation",
      group="Saturation",
      enable=considerSaturation));
  output SI.Voltage vee=pin_eep.v - pin_en.v "Field shunt excitation voltage";
  output SI.Voltage ves=pin_esp.v - pin_en.v "Field series excitation voltage";
  output SI.Current iee=pin_eep.i "Field shunt excitation current";
  output SI.Current ies=pin_esp.i "Field series excitation current";
  Machines.BasicMachines.Components.AirGapDC airGapDC(
    final turnsRatio=turnsRatio,
    considerSaturation=considerSaturation,
    final Le=Lme,
    final quasiStatic=quasiStatic,
    Inom=IeNominal,
    Lnom=Lme,
    Lzer=Lzer*(1 - sigmae),
    Linf=Linf*(1 - sigmae))        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270)));
  Machines.BasicMachines.Components.CompoundDCExcitation compoundDCExcitation(final excitationTurnsRatio=
        excitationTurnsRatio) annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Modelica.Electrical.Analog.Basic.Resistor res(
    final R=Res,
    final T_ref=TeRef,
    final alpha=Machines.Thermal.convertAlpha(alpha20e, TeRef),
    final useHeatPort=true)
    annotation (Placement(transformation(
        origin={-80,50},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Machines.BasicMachines.Components.InductorDC lesigmas(final L=Lesigma*excitationTurnsRatio,
      final quasiStatic=quasiStatic)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,20})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_esp "Positive series excitation pin"
    annotation (Placement(transformation(extent={{-110,70},{-90,50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
    "Negative series excitation pin" annotation (Placement(transformation(
          extent={{-90,10},{-110,-10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_eep "Positive series excitation pin"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-70}})));
  Modelica.Electrical.Analog.Basic.Resistor ree(
    final R=Ree,
    final T_ref=TeRef,
    final alpha=Machines.Thermal.convertAlpha(alpha20e, TeRef),
    final useHeatPort=true)
    annotation (Placement(transformation(
        origin={-80,-60},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  Machines.BasicMachines.Components.InductorDC lesigmae(final L=Lesigma, final quasiStatic=quasiStatic)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-56,-60})));
protected
  final parameter SI.Inductance Lme=Le*(1 - sigmae) "Main part of excitation inductance";
  final parameter SI.Inductance Lesigma=Le*sigmae "Stray part of excitation inductance" annotation (Evaluate=true);
equation
  connect(airGapDC.pin_ap, la.n) annotation (Line(
      points={{10,10},{10,60}}, color={0,0,255}));
  connect(airGapDC.support, internalSupport) annotation (Line(
      points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
  connect(airGapDC.flange, inertiaRotor.flange_a) annotation (Line(
      points={{10,0},{70,0},{70,0}}));
  connect(pin_esp, res.p) annotation (Line(points={{-100,60},{-80,60}}, color={0,0,255}));
  connect(res.n, lesigmas.p) annotation (Line(points={{-80,40},{-80,30}}, color={0,0,255}));
  connect(airGapDC.pin_en, compoundDCExcitation.pin_n) annotation (Line(
      points={{-10,-10},{-10,-10}}, color={0,0,255}));
  connect(compoundDCExcitation.pin_p, airGapDC.pin_ep) annotation (Line(
      points={{10,-10},{10,-10}}, color={0,0,255}));
  connect(airGapDC.pin_en, ground.p) annotation (Line(
      points={{-10,-10},{-20,-10}}, color={0,0,255}));
  connect(compoundDCExcitation.pin_sen, pin_en) annotation (Line(
      points={{-10,-30},{-60,-30},{-60,0},{-100,0}},
                                               color={0,0,255}));
  connect(compoundDCExcitation.pin_sep, lesigmas.n)
    annotation (Line(points={{-2,-30},{-2,-40},{-80,-40},{-80,10}}, color={0,0,255}));
  connect(airGapDC.pin_an, brush.p) annotation (Line(
      points={{-10,10},{-10,60}}, color={0,0,255}));
  connect(res.heatPort, internalThermalPort.heatPortSeriesExcitation)
    annotation (Line(points={{-70,50},{-60,50},{-60,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
  connect(compoundDCExcitation.pin_sen, compoundDCExcitation.pin_en)
    annotation (Line(points={{-10,-30},{-10,-36},{2,-36},{2,-30}}, color={0,0,255}));
  connect(pin_eep, ree.p) annotation (Line(points={{-100,-60},{-90,-60}}, color={0,0,255}));
  connect(ree.n, lesigmae.p) annotation (Line(points={{-70,-60},{-66,-60}}, color={0,0,255}));
  connect(lesigmae.n, compoundDCExcitation.pin_ep) annotation (Line(points={{-46,-60},{10,-60},{10,-29.8}}, color={0,0,255}));
  connect(ree.heatPort, internalThermalPort.heatPortShuntExcitation)
    annotation (Line(points={{-80,-50},{-80,-44},{50,-44},{50,-80},{0,-80}}, color={191,0,0}));
  annotation (
    defaultComponentName="dcse",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-100,10},{-105,11},{-109,15},{-110,20},{-109,25},{-105,29},{-100,30}},
                             color={0,0,255}),
        Line(points={{-100,30},{-105,31},{-109,35},{-110,40},{-109,45},{-105,49},{-100,50}},
                              color={0,0,255}),
        Line(points={{-130,-34},{-129,-29},{-125,-25},{-120,-24},{-115,-25},{-111,-29},{-110,-34}},
                             color={0,0,255}),
        Line(points={{-110,-34},{-109,-29},{-105,-25},{-100,-24},{-95,-25},{-91,-29},{-90,-34}},
                         color={0,0,255}),
        Line(points={{-90,-34},{-89,-29},{-85,-25},{-80,-24},{-75,-25},{-71,-29},{-70,-34}},
                    color={0,0,255}),
        Line(points={{-100,-50},{-100,-40},{-70,-40},{-70,-32}},color={0,0,255}),
        Line(points={{-100,-10},{-100,-20},{-130,-20},{-130,-34}},
                                                               color={0,0,
              255})}),
    Documentation(info="<html>
<p><strong>Model of a DC Machine with compound excitation.</strong><br>
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

<p>Saturation is modelled <em>AirGapDC</em> model.<br>
Compound excitation has to be connected by the user's external circuit.
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
end DC_CompoundExcited;
