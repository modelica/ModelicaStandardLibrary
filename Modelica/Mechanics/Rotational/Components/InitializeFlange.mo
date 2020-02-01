within Modelica.Mechanics.Rotational.Components;
model InitializeFlange
  "Initializes a flange with pre-defined angle, speed and angular acceleration (usually, this is reference data from a control bus)"
  extends Modelica.Blocks.Icons.Block;
  parameter Boolean use_phi_start=true
    "= true, if initial angle is defined by input phi_start, otherwise not initialized";
  parameter Boolean use_w_start=true
    "= true, if initial speed is defined by input w_start, otherwise not initialized";
  parameter Boolean use_a_start=true
    "= true, if initial angular acceleration is defined by input a_start, otherwise not initialized";

  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use flange angle and speed as states";

  Modelica.Blocks.Interfaces.RealInput phi_start(unit="rad") if use_phi_start
    "Initial angle of flange" annotation (Placement(transformation(extent={
            {-140,60},{-100,100}}), iconTransformation(extent={
            {-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput w_start(unit="rad/s") if use_w_start
    "Initial speed of flange" annotation (Placement(transformation(extent={
            {-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput a_start(unit="rad/s2") if use_a_start
    "Initial angular acceleration of flange" annotation (Placement(
        transformation(extent={{-140,-100},{-100,-60}}),
        iconTransformation(extent={{-140,-100},{-100,-60}})));
  Interfaces.Flange_b flange "Flange that is initialized" annotation (
      Placement(transformation(extent={{90,-10},{110,10}})));

  SI.Angle phi_flange(stateSelect=stateSelect) = flange.phi
    "Flange angle";
  SI.AngularVelocity w_flange(stateSelect=stateSelect) = der(
    phi_flange) "= der(phi_flange)";

protected
  encapsulated model Set_phi_start "Set phi_start"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput phi_start(unit="rad")
      "Start angle"
      annotation (HideResult=true, Placement(transformation(extent={{-140,-20},
              {-100,20}})));

    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
        Placement(transformation(extent={{90,-10},{110,10}})));
  initial equation
    flange.phi = phi_start;
  equation
    flange.tau = 0;

  end Set_phi_start;

  encapsulated model Set_w_start "Set w_start"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput w_start(unit="rad/s")
      "Start angular velocity"
      annotation (HideResult=true, Placement(transformation(extent={{-140,-20},
              {-100,20}})));

    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
        Placement(transformation(extent={{90,-10},{110,10}})));
  initial equation
    der(flange.phi) = w_start;
  equation
    flange.tau = 0;

  end Set_w_start;

  encapsulated model Set_a_start "Set a_start"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput a_start(unit="rad/s2")
      "Start angular acceleration" annotation (HideResult=true, Placement(
          transformation(extent={{-140,-20},{-100,20}})));

    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange(phi(
          stateSelect=StateSelect.avoid)) annotation (Placement(
          transformation(extent={{90,-10},{110,10}})));

    Modelica.Units.SI.AngularVelocity w=der(flange.phi)
      annotation (HideResult=true);
  initial equation
    der(w) = a_start;
  equation
    flange.tau = 0;
  end Set_a_start;

  encapsulated model Set_flange_tau "Set flange.tau to zero"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
        Placement(transformation(extent={{90,-10},{110,10}})));
  equation
    flange.tau = 0;
  end Set_flange_tau;
protected
  Set_phi_start set_phi_start if use_phi_start annotation (Placement(
        transformation(extent={{-20,70},{0,90}})));
  Set_w_start set_w_start if use_w_start annotation (Placement(
        transformation(extent={{-20,-10},{0,10}})));
  Set_a_start set_a_start if use_a_start annotation (Placement(
        transformation(extent={{-20,-90},{0,-70}})));
  Set_flange_tau set_flange_tau annotation (Placement(transformation(extent=
           {{96,-90},{76,-70}})));
equation
  connect(set_phi_start.phi_start, phi_start) annotation (Line(
      points={{-22,80},{-120,80}}, color={0,0,127}));
  connect(set_phi_start.flange, flange) annotation (Line(
      points={{0,80},{60,80},{60,0},{100,0}}));
  connect(set_w_start.flange, flange) annotation (Line(
      points={{0,0},{100,0}}));
  connect(set_w_start.w_start, w_start) annotation (Line(
      points={{-22,0},{-120,0}}, color={0,0,127}));
  connect(set_a_start.a_start, a_start) annotation (Line(
      points={{-22,-80},{-120,-80}}, color={0,0,127}));
  connect(set_a_start.flange, flange) annotation (Line(
      points={{0,-80},{60,-80},{60,0},{100,0}}));
  connect(set_flange_tau.flange, flange) annotation (Line(
      points={{76,-80},{60,-80},{60,0},{100,0}}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-94,94},{66,66}},
          textString="phi_start",
          textColor={128,128,128}),
        Text(
          extent={{-94,16},{60,-14}},
          textString="w_start",
          textColor={128,128,128}),
        Text(
          extent={{-92,-66},{60,-94}},
          textString="a_start",
          textColor={128,128,128})}),
    Documentation(info="<html>
<p>
This component is used to optionally initialize the angle, speed,
and/or angular acceleration of the flange to which this component
is connected. Via parameters use_phi_start, use_w_start, use_a_start
the corresponding input signals phi_start, w_start, a_start are conditionally
activated. If an input is activated, the corresponding flange property
is initialized with the input value at start time.
</p>

<p>
For example, if \"use_phi_start = true\", then flange.phi is initialized
with the value of the input signal \"phi_start\" at the start time.
</p>

<p>
Additionally, it is optionally possible to define the \"StateSelect\"
attribute of the flange angle and the flange speed via parameter
\"stateSelection\".
</p>

<p>
This component is especially useful when the initial values of a flange
shall be set according to reference signals of a controller that are
provided via a signal bus.
</p>
</html>"));
end InitializeFlange;
