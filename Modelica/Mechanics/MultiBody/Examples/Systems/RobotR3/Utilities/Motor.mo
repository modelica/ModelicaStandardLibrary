within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
model Motor "Motor model including current controller of r3 motors"
  extends Electrical.Machines.Icons.Machine;
  parameter SI.Inertia J(min=0)=0.0013 "Moment of inertia of motor";
  parameter Real k=1.1616 "Gain of motor";
  parameter Real w=4590 "Time constant of motor";
  parameter Real D=0.6 "Damping constant of motor";
  parameter SI.AngularVelocity w_max=315 "Maximum speed of motor";
  parameter SI.Current i_max=9 "Maximum current of motor";

  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_motor
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage Vs
    annotation (Placement(transformation(
        origin={-80,-40},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Ideal.IdealOpAmp power
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Modelica.Electrical.Analog.Ideal.IdealOpAmp diff
    annotation (Placement(transformation(extent={{-60,34},{-40,54}})));
  Electrical.Analog.Basic.RotationalEMF emf(k=k, useSupport=false)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Electrical.Analog.Basic.Inductor La(L=(250/(2*D*w)))
    annotation (Placement(transformation(
        origin={80,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor Ra(R=250)
    annotation (Placement(transformation(
        origin={80,60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor Rd2(R=100)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-10})));
  Modelica.Electrical.Analog.Basic.Capacitor C(C=0.004*D/w)
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Modelica.Electrical.Analog.Ideal.IdealOpAmp OpI
    annotation (Placement(transformation(extent={{0,34},{20,54}})));
  Modelica.Electrical.Analog.Basic.Resistor Ri(R=10)
    annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
  Modelica.Electrical.Analog.Basic.Resistor Rd1(R=100)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Electrical.Analog.Basic.Resistor Rp1(R=200)
    annotation (Placement(transformation(extent={{41,82},{56,98}})));
  Modelica.Electrical.Analog.Basic.Resistor Rp2(R=50)
    annotation (Placement(transformation(
        origin={20,90},
        extent={{-8,-8},{8,8}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Resistor Rd4(R=100)
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage hall2
    annotation (Placement(transformation(
        origin={-60,-40},
        extent={{10,10},{-10,-10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Resistor Rd3(R=100)
    annotation (Placement(transformation(
        origin={-60,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Ground g1
    annotation (Placement(transformation(extent={{-90,-74},{-70,-54}})));
  Modelica.Electrical.Analog.Basic.Ground g2
    annotation (Placement(transformation(extent={{-70,-74},{-50,-54}})));
  Modelica.Electrical.Analog.Basic.Ground g3
    annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor hall1
    annotation (Placement(transformation(
        origin={20,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground g4
    annotation (Placement(transformation(extent={{10,-74},{30,-54}})));
  Modelica.Electrical.Analog.Basic.Ground g5
    annotation (Placement(transformation(
        origin={-6,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor phi
    annotation (Placement(transformation(
        origin={80,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed
    annotation (Placement(transformation(
        origin={50,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia Jmotor(
                                               J=J)
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities.AxisControlBus axisControlBus annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  Blocks.Math.Gain convert1(k(unit="V/A")=1)
                            annotation (Placement(transformation(extent={{-24,-46},{-36,-34}})));
  Blocks.Math.Gain convert2(k(unit="V/A")=1)
                            annotation (Placement(transformation(extent={{-64,-97},{-76,-85}})));
initial equation
  // initialize motor in steady state
  der(C.v) = 0;
  der(La.i) = 0;

equation
  connect(La.n, emf.p) annotation (Line(points={{80,20},{40,20},{40,10}}, color={0,0,255}));
  connect(Ra.n, La.p) annotation (Line(points={{80,50},{80,40}}));
  connect(Rd2.n, diff.n1) annotation (Line(points={{-80,0},{-80,50},{-60,50}}, color={0,0,255}));
  connect(C.n, OpI.p2) annotation (Line(points={{20,70},{30,70},{30,44},{20,44}}, color={0,0,255}));
  connect(OpI.p2, power.p1) annotation (Line(points={{20,44},{30,44},{30,54},{40,54}}, color={0,0,255}));
  connect(Vs.p, Rd2.p) annotation (Line(points={{-80,-30},{-80,-20}}, color={0,0,255}));
  connect(diff.n1, Rd1.p)
    annotation (Line(points={{-60,50},{-80,50},{-80,70},{-60,70}}, color={0,0,255}));
  connect(Rd1.n, diff.p2) annotation (Line(points={{-40,70},{-30,70},{-30,44},{-40,44}}, color={0,0,255}));
  connect(diff.p2, Ri.p) annotation (Line(points={{-40,44},{-30,44},{-30,60}}, color={0,0,255}));
  connect(Ri.n, OpI.n1) annotation (Line(points={{-10,60},{-10,50},{0,50}}, color={0,0,255}));
  connect(OpI.n1, C.p) annotation (Line(points={{0,50},{-10,50},{-10,70},{0,70}}, color={0,0,255}));
  connect(power.n1, Rp1.p)
    annotation (Line(points={{40,66},{35,66},{35,90},{41,90}}, color={0,0,255}));
  connect(power.p2, Rp1.n) annotation (Line(points={{60,60},{60,90},{56,90}}, color={0,0,255}));
  connect(Rp1.p, Rp2.p) annotation (Line(points={{41,90},{28,90}}));
  connect(power.p2, Ra.p)
    annotation (Line(points={{60,60},{60,80},{80,80},{80,70}}, color={0,0,255}));
  connect(Rd3.p, hall2.p) annotation (Line(points={{-60,-20},{-60,-30}}, color={0,0,255}));
  connect(Rd3.n, diff.p1) annotation (Line(points={{-60,0},{-60,38}}, color={0,0,255}));
  connect(Rd3.n, Rd4.p) annotation (Line(points={{-60,0},{-60,10},{-50,10}}, color={0,0,255}));
  connect(Vs.n, g1.p) annotation (Line(points={{-80,-50},{-80,-54}}, color={0,0,255}));
  connect(g2.p, hall2.n) annotation (Line(points={{-60,-54},{-60,-50}}));
  connect(Rd4.n, g3.p) annotation (Line(points={{-30,10},{-20,10},{-20,0}}, color={0,0,255}));
  connect(g3.p, OpI.p1) annotation (Line(points={{-20,0},{-20,30},{0,30},{0,38}}, color={0,0,255}));
  connect(g5.p, Rp2.n)
    annotation (Line(points={{4,90},{12,90}}));
  connect(emf.n, hall1.p)
    annotation (Line(points={{40,-10},{40,-20},{20,-20},{20,-30}}, color={0,0,255}));
  connect(hall1.n, g4.p) annotation (Line(points={{20,-50},{20,-54}}));
  connect(emf.flange, phi.flange)
    annotation (Line(points={{50,0},{60,0},{60,-30},{80,-30}}));
  connect(emf.flange, speed.flange)
    annotation (Line(points={{50,0},{60,0},{60,-30},{50,-30}}));
  connect(OpI.n2, power.n2)
    annotation (Line(points={{10,34},{10,30},{50,30},{50,50}}, color={0,0,255}));
  connect(OpI.p1, OpI.n2) annotation (Line(points={{0,38},{0,30},{10,30},{10,34}}, color={0,0,255}));
  connect(OpI.p1, diff.n2) annotation (Line(points={{0,38},{0,30},{-50,30},{-50,34}}, color={0,0,255}));
  connect(Jmotor.flange_b, flange_motor)
    annotation (Line(
      points={{90,0},{100,0}},
      color={128,128,128},
      thickness=0.5));
  connect(phi.phi, axisControlBus.motorAngle)
    annotation (Line(points={{80,-51},{80,-99.9},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,-3},{6,-3}}));
  connect(speed.w, axisControlBus.motorSpeed)
    annotation (Line(points={{50,-51},{50,-98},{0.1,-98},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,-3},{6,-3}}));
  connect(hall1.i, axisControlBus.current)
    annotation (Line(points={{9,-40},{0,-40},{0,-100},{0.1,-100},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=2,
      extent={{0,3},{0,3}}));
  connect(hall1.i, convert1.u) annotation (Line(points={{9,-40},{-22.8,-40}}, color={0,0,127}));
  connect(convert1.y, hall2.v) annotation (Line(points={{-36.6,-40},{-48,-40}},
                 color={0,0,127}));
  connect(convert2.u, axisControlBus.current_ref)
    annotation (Line(points={{-62.8,-91},{-50,-91},{-50,-100},{0.1,-100},{0.1,-99.9}},
                                                                  color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
  connect(convert2.y, Vs.v) annotation (Line(points={{-76.6,-91},{-100,-91},{-100,-40},{-92,-40}},
                             color={0,0,127}));
  connect(emf.flange, Jmotor.flange_a) annotation (Line(
      points={{50,0},{70,0}}));
  annotation (
    Documentation(info="<html>
<p>
Default values are given for the motor of joint 1.
The input of the motor is the desired current
(the actual current is proportional to the torque
produced by the motor).
</p>
</html>"),
       Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-150,110},{150,70}},
          textString="%name",
          textColor={0,0,255})}));
end Motor;
