within Modelica.Mechanics.Rotational.Components;
model AngleToTorqueAdaptor
  "Signal adaptor for a Rotational flange with torque as output and angle, speed, and optionally acceleration as inputs (especially useful for FMUs)"
  parameter Boolean use_w=true
    "= true, enable the input connector w (angular velocity)" annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  parameter Boolean use_a=true
    "= true, enable the input connector a (angular acceleration)"
    annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
      Placement(transformation(extent={{56,-10},{76,10}}),
        iconTransformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Interfaces.RealInput phi(unit="rad")
    "Angle to drive the flange" annotation (Placement(transformation(extent=
           {{-80,60},{-40,100}}), iconTransformation(extent={{-40,70},{-20,90}})));
  Modelica.Blocks.Interfaces.RealInput w(unit="rad/s") if use_w or use_a
    "Speed to drive the flange (w=der(phi) required)" annotation (
      Placement(transformation(extent={{-80,10},{-40,50}}),
        iconTransformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Interfaces.RealInput a(unit="rad/s2") if use_a
    "Angular acceleration to drive the flange (a = der(w) required)"
    annotation (Placement(transformation(extent={{-80,-50},{-40,-10}}),
        iconTransformation(extent={{-40,10},{-20,30}})));
  Modelica.Blocks.Interfaces.RealOutput tau(unit="N.m")
    "Torque needed to drive the flange according to phi, w, a" annotation (
      Placement(transformation(extent={{-40,-90},{-60,-70}}),
        iconTransformation(extent={{-20,-90},{-40,-70}})));

protected
  Modelica.Mechanics.Rotational.Sources.Move move if use_a
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3 if use_a
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor
    annotation (Placement(transformation(extent={{36,-10},{56,10}})));

  Modelica.Blocks.Routing.Multiplex2 multiplex2 if use_w and not use_a
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Move_phi move_phi if not use_w and not use_a
    annotation (Placement(transformation(extent={{10,70},{30,90}})));
  Move_w move_w if use_w and not use_a
    annotation (Placement(transformation(extent={{10,40},{30,60}})));

  model Move_phi "Forced movement of a flange according to an angle signal"
    extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;

    Modelica.Blocks.Interfaces.RealInput phi(
      final quantity="Angle",
      final unit="rad",
      displayUnit="deg") "Rotation angle of flange with respect to support"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  equation
    phi = flange.phi - phi_support;
    annotation (Documentation(info="<html>
<p>
Flange <strong>flange</strong> is <strong>forced</strong> to move relative to flange support with a predefined motion
according to the input signal u
</p>
<blockquote><pre>
u[1]: angle of flange
u[2]: angular velocity of flange
</pre></blockquote>
<p>
The user has to guarantee that the input signals are consistent to each other,
i.e., that u[2] is the derivative of u[1].
</p>
<p>
The input signals can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>
</html>"),
       Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Text(
                  extent={{-80,-60},{-80,-100}},
                  textString="phi"),Rectangle(
                  extent={{-100,20},{100,-20}},
                  lineColor={64,64,64},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={192,192,192}),Line(points={{-30,-32},{30,-32}}),Line(points={{0,52},{0,32}}),Line(
            points={{-29,32},{30,32}}),Line(points={{0,-32},
            {0,-100}}),Line(points={{30,-42},{20,-52}}),Line(points={{30,-32},{10,-52}}),
            Line(points={{20,-32},{0,-52}}),Line(points={{10,
            -32},{-10,-52}}),Line(points={{0,-32},{-20,-52}}),Line(points={{-10,-32},{-30,-52}}),
            Line(points={{-20,-32},{-30,-42}}),Text(
                  extent={{-150,100},{150,60}},
                  textString="%name",
                  textColor={0,0,255})}));
  end Move_phi;

  model Move_w
    "Forced movement of a flange according to an angle and speed signal"
    extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;

    SI.Angle phi
      "Rotation angle of flange with respect to support";
    Modelica.Blocks.Interfaces.RealInput u[2]
      "Angle and angular velocity of flange with respect to support as input signals"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  protected
    function position
      extends Modelica.Icons.Function;
      input Real q_qd[2] "Required values for position and speed";
      input Real dummy
        "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
      output Real q;
    algorithm
      q := q_qd[1];
      annotation (derivative(noDerivative=q_qd) = position_der,
          InlineAfterIndexReduction=true);
    end position;

    function position_der
      extends Modelica.Icons.Function;
      input Real q_qd[2] "Required values for position and speed";
      input Real dummy
        "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
      input Real dummy_der;
      output Real qd;
    algorithm
      qd := q_qd[2];
    end position_der;
  equation
    phi = flange.phi - phi_support;
    phi = position(u, time);
    annotation (Documentation(info="<html>
<p>
Flange <strong>flange</strong> is <strong>forced</strong> to move relative to flange support with a predefined motion
according to the input signals:
</p>
<blockquote><pre>
u[1]: angle of flange
u[2]: angular velocity of flange
</pre></blockquote>
<p>
The user has to guarantee that the input signals are consistent to each other,
i.e., that u[2] is the derivative of u[1].
</p>
<p>
The input signals can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>
</html>"),
       Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Text(
                  extent={{-80,-60},{-80,-100}},
                  textString="phi,w"),Rectangle(
                  extent={{-100,20},{100,-20}},
                  lineColor={64,64,64},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={192,192,192}),Line(points={{-30,-32},{30,-32}}),Line(points={{0,52},{0,32}}),Line(
            points={{-29,32},{30,32}}),Line(points={{0,-32},
            {0,-100}}),Line(points={{30,-42},{20,-52}}),Line(points={{30,-32},{10,-52}}),
            Line(points={{20,-32},{0,-52}}),Line(points={{10,
            -32},{-10,-52}}),Line(points={{0,-32},{-20,-52}}),Line(points={{-10,-32},{-30,-52}}),
            Line(points={{-20,-32},{-30,-42}}),Text(
                  extent={{-150,100},{150,60}},
                  textString="%name",
                  textColor={0,0,255})}));
  end Move_w;
equation
  connect(multiplex3.y, move.u) annotation (Line(
      points={{1,0},{8,0}},
      color={0,0,127}));
  connect(phi, multiplex3.u1[1]) annotation (Line(
      points={{-60,80},{-32,80},{-32,7},{-22,7}},
      color={0,0,127}));
  connect(w, multiplex3.u2[1]) annotation (Line(
      points={{-60,30},{-36,30},{-36,0},{-22,0}},
      color={0,0,127}));
  connect(a, multiplex3.u3[1]) annotation (Line(
      points={{-60,-30},{-32,-30},{-32,-7},{-22,-7}},
      color={0,0,127}));
  connect(flange, torqueSensor.flange_b) annotation (Line(
      points={{66,0},{56,0}}));
  connect(move.flange, torqueSensor.flange_a) annotation (Line(
      points={{30,0},{36,0}}));
  connect(torqueSensor.tau, tau) annotation (Line(
      points={{38,-11},{38,-80},{-50,-80}},
      color={0,0,127}));
  connect(multiplex2.y, move_w.u) annotation (Line(
      points={{1,50},{8,50}},
      color={0,0,127}));
  connect(phi, multiplex2.u1[1]) annotation (Line(
      points={{-60,80},{-46,80},{-46,80},{-32,80},{-32,56},{-22,56}},
      color={0,0,127}));
  connect(w, multiplex2.u2[1]) annotation (Line(
      points={{-60,30},{-28,30},{-28,44},{-22,44}},
      color={0,0,127}));
  connect(move_w.flange, torqueSensor.flange_a) annotation (Line(
      points={{30,50},{36,50},{36,0}}));
  connect(phi, move_phi.phi) annotation (Line(
      points={{-60,80},{8,80}},
      color={0,0,127}));
  connect(move_phi.flange, torqueSensor.flange_a) annotation (Line(
      points={{30,80},{36,80},{36,0}}));
  annotation (defaultComponentName="angleToTorqueAdaptor",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(
          extent={{-20,100},{20,-100}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          radius=10),
        Rectangle(
          extent={{-20,100},{20,-100}},
          lineColor={95,95,95},
          radius=10,
          lineThickness=0.5),
        Text(
          extent={{-20,92},{20,70}},
          fillPattern=FillPattern.Solid,
          textString="phi"),
        Text(
          visible=use_w or use_a,
          extent={{-20,62},{20,40}},
          fillPattern=FillPattern.Solid,
          textString="w"),
        Text(
          visible=use_a,
          extent={{-20,32},{20,10}},
          fillPattern=FillPattern.Solid,
          textString="a"),
        Text(
          extent={{-20,-68},{20,-90}},
          fillPattern=FillPattern.Solid,
          textString="tau"),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
Adaptor between a flange connector and a signal representation of the flange.
This component is used to provide a pure signal interface around a Rotational model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>).
Examples of the usage of this adaptor are provided in
<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.GenerationOfFMUs\">Rotational.Examples.GenerationOfFMUs</a>.
This adaptor has angle, angular velocity and angular acceleration as input signals and
torque as output signal. Note, the input signals must be consistent to each other
(w=der(phi), a=der(w)).
</p>
</html>"));
end AngleToTorqueAdaptor;
