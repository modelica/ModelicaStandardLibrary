within Modelica.Blocks.Examples;
model PID_Controller
  "Demonstrates the usage of a Continuous.LimPID controller"
  extends Modelica.Icons.Example;
  parameter SI.Angle driveAngle=1.570796326794897
    "Reference distance to move";
  Modelica.Blocks.Continuous.LimPID PI(
    k=100,
    Ti=0.1,
    yMax=12,
    Ni=0.1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Td=0.1) annotation (Placement(transformation(extent={{-56,-20},{-36,0}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(
    phi(fixed=true, start=0),
    J=1,
    a(fixed=true, start=0)) annotation (Placement(transformation(extent={{2,-20},
            {22,0}})));

  Modelica.Mechanics.Rotational.Sources.Torque torque annotation (Placement(
        transformation(extent={{-25,-20},{-5,0}})));
  Modelica.Mechanics.Rotational.Components.SpringDamper spring(
    c=1e4,
    d=100,
    stateSelect=StateSelect.prefer,
    w_rel(fixed=true)) annotation (Placement(transformation(extent={{32,-20},
            {52,0}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=2) annotation (
      Placement(transformation(extent={{60,-20},{80,0}})));
  Modelica.Blocks.Sources.KinematicPTP kinematicPTP(
    startTime=0.5,
    deltaq={driveAngle},
    qd_max={1},
    qdd_max={1}) annotation (Placement(transformation(extent={{-92,20},{-72,
            40}})));
  Modelica.Blocks.Continuous.Integrator integrator(initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{-63,20},{-43,40}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
      Placement(transformation(extent={{22,-50},{2,-30}})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque loadTorque(
      tau_constant=10, useSupport=false) annotation (Placement(transformation(
          extent={{98,-15},{88,-5}})));
initial equation
  der(spring.w_rel) = 0;

equation
  connect(spring.flange_b, inertia2.flange_a)
    annotation (Line(points={{52,-10},{60,-10}}));
  connect(inertia1.flange_b, spring.flange_a)
    annotation (Line(points={{22,-10},{32,-10}}));
  connect(torque.flange, inertia1.flange_a)
    annotation (Line(points={{-5,-10},{2,-10}}));
  connect(kinematicPTP.y[1], integrator.u)
    annotation (Line(points={{-71,30},{-65,30}}, color={0,0,127}));
  connect(speedSensor.flange, inertia1.flange_b)
    annotation (Line(points={{22,-40},{22,-10}}));
  connect(loadTorque.flange, inertia2.flange_b)
    annotation (Line(points={{88,-10},{80,-10}}));
  connect(PI.y, torque.tau)
    annotation (Line(points={{-35,-10},{-27,-10}}, color={0,0,127}));
  connect(speedSensor.w, PI.u_m)
    annotation (Line(points={{1,-40},{-46,-40},{-46,-22}}, color={0,0,127}));
  connect(integrator.y, PI.u_s) annotation (Line(points={{-42,30},{-37,30},{-37,
          11},{-67,11},{-67,-10},{-58,-10}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(extent={{-99,48},{-32,8}}, lineColor={255,0,0}),
        Text(
          extent={{-98,59},{-31,51}},
          textColor={255,0,0},
          textString="reference speed generation"),
        Text(
          extent={{-98,-46},{-60,-52}},
          textColor={255,0,0},
          textString="PI controller"),
        Line(
          points={{-76,-44},{-57,-23}},
          color={255,0,0},
          arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{-25,6},{99,-50}}, lineColor={255,0,0}),
        Text(
          extent={{4,14},{71,7}},
          textColor={255,0,0},
          textString="plant (simple drive train)")}),
    experiment(StopTime=4),
    Documentation(info="<html>

<p>
This is a simple drive train controlled by a PID controller:
</p>

<ul>
<li> The two blocks \"kinematic_PTP\" and \"integrator\" are used to generate
     the reference speed (= constant acceleration phase, constant speed phase,
     constant deceleration phase until inertia is at rest). To check
     whether the system starts in steady state, the reference speed is
     zero until time = 0.5 s and then follows the sketched trajectory.</li>

<li> The block \"PI\" is an instance of \"Blocks.Continuous.LimPID\" which is
     a PID controller where several practical important aspects, such as
     anti-windup-compensation has been added. In this case, the control block
     is used as PI controller.</li>

<li> The output of the controller is a torque that drives a motor inertia
     \"inertia1\". Via a compliant spring/damper component, the load
     inertia \"inertia2\" is attached. A constant external torque of 10 Nm
     is acting on the load inertia.</li>
</ul>

<p>
The PI controller is initialized in steady state (initType=SteadyState)
and the drive shall also be initialized in steady state.
However, it is not possible to initialize \"inertia1\" in SteadyState, because
\"der(inertia1.phi)=inertia1.w=0\" is an input to the PI controller that
defines that the derivative of the integrator state is zero (= the same
condition that was already defined by option SteadyState of the PI controller).
Furthermore, one initial condition is missing, because the absolute position
of inertia1 or inertia2 is not defined. The solution shown in this examples is
to initialize the angle and the angular acceleration of \"inertia1\".
</p>

<p>
In the following figure, results of a typical simulation are shown:
</p>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/PID_controller.png\"
     alt=\"PID_controller.png\"><br>

<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/PID_controller2.png\"
     alt=\"PID_controller2.png\">

<p>
In the upper figure the reference speed (= integrator.y) and
the actual speed (= inertia1.w) are shown. As can be seen,
the system initializes in steady state, since no transients
are present. The inertia follows the reference speed quite good
until the end of the constant speed phase. Then there is a deviation.
In the lower figure the reason can be seen: The output of the
controller (PI.y) is in its limits. The anti-windup compensation
works reasonably, since the input to the limiter (PI.limiter.u)
is forced back to its limit after a transient phase.
</p>

</html>"));
end PID_Controller;
