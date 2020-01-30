within Modelica.Electrical.Machines.BasicMachines.DCMachines;
model DC_PermanentMagnet "Permanent magnet DC machine"
  extends Machines.Interfaces.PartialBasicDCMachine(
    final ViNominal=VaNominal - Machines.Thermal.convertResistance(
        Ra,
        TaRef,
        alpha20a,
        TaNominal)*IaNominal - Machines.Losses.DCMachines.brushVoltageDrop(
        brushParameters, IaNominal),
    final psi_eNominal=Lme*IeNominal,
    redeclare final Machines.Thermal.DCMachines.ThermalAmbientDCPM
      thermalAmbient(final Tpm=TpmOperational),
    redeclare final Machines.Interfaces.DCMachines.ThermalPortDCPM thermalPort,

    redeclare final Machines.Interfaces.DCMachines.ThermalPortDCPM
      internalThermalPort,
    redeclare final Machines.Interfaces.DCMachines.PowerBalanceDCPM
      powerBalance(final lossPowerPermanentMagnet=0),
    core(final w=airGapDC.w));
  final parameter SI.Temperature TpmOperational=293.15
    "Operational temperature of permanent magnet"
    annotation (Dialog(group="Operational temperatures"));
  Machines.BasicMachines.Components.AirGapDC airGapDC(
    final turnsRatio=turnsRatio,
    final Le=Lme,
    final quasiStatic=quasiStatic) annotation (Placement(transformation(extent=
            {{-10,-10},{10,10}}, rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground eGround annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-30})));
  Modelica.Electrical.Analog.Sources.ConstantCurrent ie(I=IeNominal)
    annotation (Placement(transformation(
        origin={0,-40},
        extent={{-10,-10},{10,10}})));
protected
  constant SI.Inductance Lme=1
    "Field excitation inductance";
  constant SI.Current IeNominal=1
    "Equivalent excitation current";
equation
  connect(eGround.p, ie.p) annotation (Line(points={{-10,-30},{-10,-30},{
          -10,-40}}, color={0,0,255}));
  connect(airGapDC.pin_ep, ie.n)
    annotation (Line(points={{10,-10},{10,-40}}, color={0,0,255}));
  connect(airGapDC.pin_en, eGround.p) annotation (Line(points={{-10,-10},
          {-10,-20},{-10,-30}}, color={0,0,255}));
  connect(airGapDC.pin_ap, la.n) annotation (Line(
      points={{10,10},{10,60}}, color={0,0,255}));
  connect(airGapDC.support, internalSupport) annotation (Line(
      points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
  connect(airGapDC.flange, inertiaRotor.flange_a) annotation (Line(
      points={{10,0},{36,0},{36,0},{70,0}}));
  connect(airGapDC.pin_an, brush.p) annotation (Line(
      points={{-10,10},{-10,60}}, color={0,0,255}));
  annotation (
    defaultComponentName="dcpm",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
          extent={{-130,10},{-100,-10}},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-100,10},{-70,-10}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p><strong>Model of a DC Machine with permanent magnets.</strong><br>
Armature resistance and inductance are modeled directly after the armature pins, then using a <em>AirGapDC</em> model. Permanent magnet excitation is modelled by a constant equivalent excitation current feeding AirGapDC. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent armature winding resistance</li>
<li>brush losses in the armature circuit</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<p>No saturation is modelled.
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
<td>nominal speed</td>
<td>1425</td><td>rpm</td>
</tr>
<tr>
<td>nominal torque</td>
<td>63.66</td><td>Nm</td>
</tr>
<tr>
<td>nominal mechanical output</td>
<td>9.5</td><td>kW</td>
</tr>
<tr>
<td>efficiency</td>
<td>95.0</td><td>%</td>
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
<td>armature nominal temperature TaNominal</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>armature operational temperature TaOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
</table>
Armature resistance resp. inductance include resistance resp. inductance of commutating pole winding and compensation winding, if present.
</html>"));
end DC_PermanentMagnet;
