within Modelica.Mechanics.Translational.Components;
model InitializeFlange
  "Initializes a flange with pre-defined position, speed and acceleration (usually, this is reference data from a control bus)"
  extends Modelica.Blocks.Icons.Block;
  parameter Boolean use_s_start=true
    "= true, if initial position is defined by input s_start, otherwise not initialized";
  parameter Boolean use_v_start=true
    "= true, if initial speed is defined by input v_start, otherwise not initialized";
  parameter Boolean use_a_start=true
    "= true, if initial acceleration is defined by input a_start, otherwise not initialized";

  parameter StateSelect stateSelect=StateSelect.default
    "Priority to use flange angle and speed as states";

  Modelica.Blocks.Interfaces.RealInput s_start(unit="m") if use_s_start
    "Initial position of flange" annotation (Placement(transformation(
          extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput v_start(unit="m/s") if use_v_start
    "Initial speed of flange" annotation (Placement(transformation(extent={
            {-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput a_start(unit="m/s2") if use_a_start
    "Initial angular acceleration of flange" annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}})));
  Interfaces.Flange_b flange "Flange that is initialized" annotation (
      Placement(transformation(extent={{90,-10},{110,10}})));

  SI.Position s_flange(stateSelect=stateSelect) = flange.s
    "Flange position";
  SI.Velocity v_flange(stateSelect=stateSelect) = der(
    s_flange) "= der(s_flange)";

protected
  encapsulated model Set_s_start "Set s_start"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput s_start(unit="m") "Start position"
      annotation (HideResult=true, Placement(transformation(extent={{-140,-20},
              {-100,20}})));

    Modelica.Mechanics.Translational.Interfaces.Flange_b flange annotation (
       Placement(transformation(extent={{90,-10},{110,10}})));
  initial equation
    flange.s = s_start;
  equation
    flange.f = 0;

  end Set_s_start;

  encapsulated model Set_v_start "Set v_start"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput v_start(unit="m/s")
      "Start velocity" annotation (HideResult=true, Placement(
          transformation(extent={{-140,-20},{-100,20}})));

    Modelica.Mechanics.Translational.Interfaces.Flange_b flange annotation (
       Placement(transformation(extent={{90,-10},{110,10}})));
  initial equation
    der(flange.s) = v_start;
  equation
    flange.f = 0;

  end Set_v_start;

  encapsulated model Set_a_start "Set a_start"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput a_start(unit="m/s2")
      "Start acceleration" annotation (HideResult=true, Placement(
          transformation(extent={{-140,-20},{-100,20}})));

    Modelica.Mechanics.Translational.Interfaces.Flange_b flange(s(
          stateSelect=StateSelect.avoid)) annotation (Placement(
          transformation(extent={{90,-10},{110,10}})));
    Modelica.Units.SI.Velocity v=der(flange.s) annotation (HideResult=true);
  initial equation
    der(v) = a_start;
  equation
    flange.f = 0;

  end Set_a_start;

  encapsulated model Set_flange_f "Set flange_f to zero"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange annotation (
       Placement(transformation(extent={{90,-10},{110,10}})));
  equation
    flange.f = 0;
  end Set_flange_f;
protected
  Set_s_start set_s_start if use_s_start annotation (Placement(
        transformation(extent={{-20,50},{0,70}})));
  Set_v_start set_v_start if use_v_start annotation (Placement(
        transformation(extent={{-20,-10},{0,10}})));
  Set_a_start set_a_start if use_a_start annotation (Placement(
        transformation(extent={{-20,-70},{0,-50}})));
  Set_flange_f set_flange_f annotation (Placement(transformation(extent={{
            20,-100},{40,-80}})));
equation
  connect(set_s_start.flange, flange) annotation (Line(
      points={{0,60},{60,60},{60,0},{100,0}}));
  connect(set_v_start.flange, flange) annotation (Line(
      points={{0,0},{100,0}}));
  connect(set_a_start.flange, flange) annotation (Line(
      points={{0,-60},{60,-60},{60,0},{100,0}}));
  connect(set_flange_f.flange, flange) annotation (Line(
      points={{40,-90},{60,-90},{60,0},{100,0}}));
  connect(s_start, set_s_start.s_start) annotation (Line(
      points={{-120,60},{-22,60}}, color={0,0,127}));
  connect(v_start, set_v_start.v_start) annotation (Line(
      points={{-120,0},{-22,0}}, color={0,0,127}));
  connect(a_start, set_a_start.a_start) annotation (Line(
      points={{-120,-60},{-22,-60}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{-94,74},{68,46}},
              textString="s_start"),Text(
              extent={{-94,16},{70,-14}},
              textString="v_start"),Text(
              extent={{-94,-46},{66,-74}},
              textString="a_start")}), Documentation(info="<html>
<p>
This component is used to optionally initialize the position, speed,
and/or acceleration of the flange to which this component
is connected. Via parameters use_s_start, use_v_start, use_a_start
the corresponding input signals s_start, v_start, a_start are conditionally
activated. If an input is activated, the corresponding flange property
is initialized with the input value at start time.
</p>

<p>
For example, if \"use_s_start = true\", then flange.s is initialized
with the value of the input signal \"s_start\" at the start time.
</p>

<p>
Additionally, it is optionally possible to define the \"StateSelect\"
attribute of the flange position and the flange speed via parameter
\"stateSelection\".
</p>

<p>
This component is especially useful when the initial values of a flange
shall be set according to reference signals of a controller that are
provided via a signal bus.
</p>

</html>"));
end InitializeFlange;
