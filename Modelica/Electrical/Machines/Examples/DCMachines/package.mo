within Modelica.Electrical.Machines.Examples;
package DCMachines "Test examples of DC machines"
  extends Modelica.Icons.ExamplesPackage;




  /*
  model DC_CompareCharacteristics
    "Test example: Compare torque-speed characteristic of DC motors"
    extends Modelica.Icons.Example;
    parameter Modelica.SIunits.Voltage Va=100 "Actual armature voltage";
    parameter Modelica.SIunits.Voltage Ve=100 "Actual excitation voltage";
    parameter Modelica.SIunits.AngularVelocity w0=Modelica.SIunits.Conversions.from_rpm(1500)
      "No-load speed";
    parameter Modelica.SIunits.Torque TLoad=63.66 "Nominal load torque";
    parameter Modelica.SIunits.Time tStart=0.5 "Start of load torque ramp";
    parameter Modelica.SIunits.Time tRamp=2.0 "Load torque ramp";
    parameter Modelica.SIunits.Inertia JLoad=0.15 "Load's moment of inertia";

    Machines.BasicMachines.DCMachines.DC_ElectricalExcited dcee(wMechanical(start=
           w0, fixed=true), ie(start=1, fixed=true))
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage armatureVoltage(V=Va)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                                                                     rotation=90,
          origin={-80,70})));
    Modelica.Electrical.Analog.Basic.Ground groundArmature
      annotation (Placement(transformation(
          origin={-80,40},
          extent={{-10,-10},{10,10}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage excitationVoltage(V=Ve)
      annotation (Placement(transformation(
          origin={-80,-50},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Electrical.Analog.Basic.Ground groundExcitation
      annotation (Placement(transformation(
          origin={-80,-80},
          extent={{-10,-10},{10,10}})));
    Modelica.Mechanics.Rotational.Components.Inertia loadInertia1(J=JLoad)
      annotation (Placement(transformation(extent={{10,-10},{30,10}})));
    Modelica.Mechanics.Rotational.Sources.Torque loadTorque1(useSupport=false)
      annotation (Placement(transformation(extent={{60,-10},{40,10}})));
    Modelica.Blocks.Sources.Ramp ramp(
      startTime=tStart,
      height=-TLoad,
      duration=tRamp,
      offset=0) annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  equation
    connect(loadInertia1.flange_b, loadTorque1.flange)
      annotation (Line(points={{30,0},{30,0},{40,0}}));
    connect(dcee.flange, loadInertia1.flange_a)
                                               annotation (Line(
        points={{0,0},{10,0}}));

    connect(ramp.y, loadTorque1.tau)
                                    annotation (Line(
        points={{79,0},{62,0}}, color={0,0,127}));
    connect(armatureVoltage.n, groundArmature.p) annotation (Line(
        points={{-80,60},{-80,50}}, color={0,0,255}));
    connect(excitationVoltage.n, groundExcitation.p) annotation (Line(
        points={{-80,-60},{-80,-70}}, color={0,0,255}));
    connect(armatureVoltage.p, dcee.pin_ap) annotation (Line(
        points={{-80,80},{-30,80},{-30,20},{-4,20},{-4,10}}, color={0,0,255}));
    connect(armatureVoltage.n, dcee.pin_an) annotation (Line(
        points={{-80,60},{-40,60},{-40,10},{-16,10}}, color={0,0,255}));
    connect(excitationVoltage.p, dcee.pin_ep) annotation (Line(
        points={{-80,-40},{-60,-40},{-60,6},{-20,6}}, color={0,0,255}));
    connect(excitationVoltage.n, dcee.pin_en) annotation (Line(
        points={{-80,-60},{-50,-60},{-50,-6},{-20,-6}}, color={0,0,255}));
    annotation (
      experiment(StopTime=3, Interval=0.001),
      Documentation(info="<html>
<strong>Test example: Compare characteristic of DC motors</strong><br>
The motors are started at no-load speed, then a load ramp is applied.<br>
Simulate for 3 seconds and plot (versus time):
<ul>
<li>dcxx.ia: armature current</li>
<li>dcxx.wMechanical: motor's speed</li>
<li>dcxx.tauElectrical: motor's torque</li>
</ul>
Default machine parameters are used.
</html>"));
  end DC_CompareCharacteristics;
*/



  annotation (Documentation(info="<html>
This package contains test examples of DC machines.
</html>"));
end DCMachines;
