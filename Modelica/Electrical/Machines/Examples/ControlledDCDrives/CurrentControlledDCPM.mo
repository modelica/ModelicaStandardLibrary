within Modelica.Electrical.Machines.Examples.ControlledDCDrives;
model CurrentControlledDCPM
  "Current controlled DC PM drive with H-bridge from battery"
  extends Utilities.PartialControlledDCPM;
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    loadTorque(
    tau_nominal=-driveData.tauNominal,
    TorqueDirection=false,
    w_nominal=driveData.motorData.wNominal)
    annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
  Modelica.Blocks.Sources.Step step(
    offset=0,
    startTime=0.2,
    height=driveData.tauNominal) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-110,-10})));
equation
  connect(loadInertia.flange_b, loadTorque.flange)
    annotation (Line(points={{70,-40},{80,-40}}));
  connect(step.y, tau2i.u)
    annotation (Line(points={{-99,-10},{-82,-10}},
                                                 color={0,0,127}));
  annotation (experiment(StopTime=2, Interval=0.0001), Documentation(info="<html>
<p>This model demonstrates how a current controller for a DC PM drive works.</p>
<p>
The current controller is parameterized according to the absolute optimum.
</p>
<p>At time=0.2 s a reference torque step is applied, causing the drive to accelerate until motor torque and load torque are at an equilibrium.</p>
<p>
Further reading:
<a href=\"modelica://Modelica/Resources/Documentation/Electrical/Machines/DriveControl.pdf\">Tutorial at the Modelica Conference 2017</a>
</p>
</html>"),
    Diagram(coordinateSystem(extent={{-200,-100},{100,100}})));
end CurrentControlledDCPM;
