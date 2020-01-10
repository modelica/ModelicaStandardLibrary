within Modelica.Electrical.Machines.Examples.Transformers;
model IMC_Transformer
  "Test example: InductionMachineSquirrelCage transformer starting"
  extends Machines.Examples.InductionMachines.IMC_Transformer;
  annotation (experiment(StopTime=2.5, Interval=1E-4, Tolerance=1E-6), Documentation(
        info="<html>
<strong>Test example: Induction machine with squirrel cage - transformer starting</strong><br>
At start time tStart1 three-phase voltage is supplied to the induction machine with squirrel cage via the transformer;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed;
at start time tStart2 the machine is fed directly from the voltage source, finally reaching nominal speed.<br>
Simulate for 2.5 seconds and plot (versus time):
<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <em>IM_SquirrelCage</em> are used.
</html>"));
end IMC_Transformer;
