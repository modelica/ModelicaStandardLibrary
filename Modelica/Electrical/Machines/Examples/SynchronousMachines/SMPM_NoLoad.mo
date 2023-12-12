within Modelica.Electrical.Machines.Examples.SynchronousMachines;
model SMPM_NoLoad "SMPM at no-load"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "Number of phases";
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
    smpmData(useDamperCage=false) "Synchronous machine data"
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpm(
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    Rs=smpmData.Rs,
    TsRef=smpmData.TsRef,
    Lszero=smpmData.Lszero,
    Lssigma=smpmData.Lssigma,
    Jr=smpmData.Jr,
    VsOpenCircuit=smpmData.VsOpenCircuit,
    Lmd=smpmData.Lmd,
    Lmq=smpmData.Lmq,
    useDamperCage=smpmData.useDamperCage,
    Lrsigmad=smpmData.Lrsigmad,
    Lrsigmaq=smpmData.Lrsigmaq,
    Rrd=smpmData.Rrd,
    Rrq=smpmData.Rrq,
    TrRef=smpmData.TrRef,
    frictionParameters=smpmData.frictionParameters,
    statorCoreParameters=smpmData.statorCoreParameters,
    strayLoadParameters=smpmData.strayLoadParameters,
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
    TsOperational=293.15,
    alpha20s=smpmData.alpha20s,
    phiMechanical(fixed=true, start=(pi + 0*2*pi/m)/smpmData.p),
    TrOperational=293.15,
    alpha20r=smpmData.alpha20r)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
      terminalConnection="Y", m=m)
    annotation (Placement(transformation(extent={{-10,6},{10,26}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Electrical.Polyphase.Sensors.PotentialSensor potentialSensor(m=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,30})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.ToSpacePhasor toSpacePhasor(m=m)
    annotation (Placement(transformation(extent={{10,40},{30,60}})));
  SpacePhasors.Blocks.ToPolar toPolar
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Blocks.Math.Gain toDeg(k=180/pi)
    annotation (Placement(transformation(extent={{70,40},{90,60}})));
  Sensors.HallSensor hallSensor(p=smpmData.p) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        origin={40,-30})));
  Mechanics.Rotational.Sources.Speed                  speed(exact=true, phi(
        fixed=false))
    annotation (Placement(transformation(extent={{50,-10},{30,10}})));

  Blocks.Sources.Ramp ramp(
    height=4*pi*smpmData.fsNominal/smpmData.p,
    duration=0.16,
    offset=-2*pi*smpmData.fsNominal/smpmData.p,
    startTime=0.08)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
equation
  connect(terminalBox.plug_sn, smpm.plug_sn)
    annotation (Line(points={{-6,10},{-6,10}}, color={0,0,255}));
  connect(terminalBox.plug_sp, smpm.plug_sp)
    annotation (Line(points={{6,10},{6,10}}, color={0,0,255}));
  connect(ground.p, terminalBox.starpoint)
    annotation (Line(points={{-20,10},{-20,12},{-10,12}},color={0,0,255}));
  connect(potentialSensor.plug_p, terminalBox.plugSupply)
    annotation (Line(points={{0,20},{0,12}}, color={0,0,255}));
  connect(potentialSensor.phi, toSpacePhasor.u) annotation (Line(points={{0,
          41},{0,50},{8,50}}, color={0,0,127}));
  connect(speed.flange, smpm.flange) annotation (Line(points={{30,0},{10,0}}));
  connect(smpm.flange, hallSensor.flange)
    annotation (Line(points={{10,0},{20,0},{20,-30},{30,-30}}));
  connect(toSpacePhasor.y, toPolar.u)
    annotation (Line(points={{31,50},{38,50}}, color={0,0,127}));
  connect(toPolar.y[2], toDeg.u)
    annotation (Line(points={{61,50},{68,50}}, color={0,0,127}));
  connect(ramp.y, speed.w_ref)
    annotation (Line(points={{69,0},{52,0}}, color={0,0,127}));
  annotation (experiment(StopTime=0.32,
        Interval=0.0001),
    Documentation(info="<html>
<p>
Synchronous machine with permanent magnets at no-load, driven with linear time dependent speed.
</p>
<p>
You may check the terminal voltage (shown by the length of the space phasor) and the frequency.
</p>
<p>
Additionally, you may check the phase shift of the stator voltages with respect to the mechanical shaft angle:
</p>
<ul>
<li>If the shaft angle starts at (pi + 0*pi/3)/p, the flux linkage through phase 1 is at the maximum and therefore this phase voltage starts at 0.</li>
<li>If the shaft angle starts at (pi + 2*pi/3)/p, the flux linkage through phase 2 is at the maximum and therefore this phase voltage starts at 0.</li>
<li>If the shaft angle starts at (pi + 4*pi/3)/p, the flux linkage through phase 3 is at the maximum and therefore this phase voltage starts at 0.</li>
</ul>
<p>Note that the angle of the voltage space phasor is pi/2 behind the angle of the hall sensor,
i.e. after a rotation of the shaft by pi/2/p the flux linkage of phase 1 is zero and the induced voltage a maximum.
</p>
</html>"));
end SMPM_NoLoad;
