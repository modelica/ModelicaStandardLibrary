within Modelica.Blocks.Continuous;
block PID "PID-controller in additive description form"
  import Modelica.Blocks.Types.Init;
  extends Interfaces.SISO;

  parameter Real k(unit="1")=1 "Gain";
  parameter SI.Time Ti(min=Modelica.Constants.small, start=0.5)
    "Time Constant of Integrator";
  parameter SI.Time Td(min=0, start=0.1)
    "Time Constant of Derivative block";
  parameter Real Nd(min=Modelica.Constants.small) = 10
    "The higher Nd, the more ideal the derivative block";
  parameter Init initType= Init.InitialState
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                     annotation(Evaluate=true,
      Dialog(group="Initialization"));
  parameter Real xi_start=0
    "Initial or guess value for integrator output (= integrator state)"
    annotation (Dialog(group="Initialization"));
  parameter Real xd_start=0
    "Initial or guess value for state of derivative block"
    annotation (Dialog(group="Initialization"));
  parameter Real y_start=0 "Initial value of output"
    annotation(Dialog(enable=initType == Init.InitialOutput, group=
          "Initialization"));
  constant SI.Time unitTime=1 annotation(HideResult=true);

  Blocks.Math.Gain P(k=1) "Proportional part of PID controller"
    annotation (Placement(transformation(extent={{-60,60},{-20,100}})));
  Blocks.Continuous.Integrator I(k=unitTime/Ti, y_start=xi_start,
    initType=if initType==Init.SteadyState then
                Init.SteadyState else
             if initType==Init.InitialState then
                Init.InitialState else Init.NoInit)
    "Integral part of PID controller"
    annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
  Blocks.Continuous.Derivative D(k=Td/unitTime, T=max([Td/Nd, 100*Modelica.
        Constants.eps]), x_start=xd_start,
    initType=if initType==Init.SteadyState or
                initType==Init.InitialOutput then Init.SteadyState else
             if initType==Init.InitialState then Init.InitialState else
                Init.NoInit) "Derivative part of PID controller"
    annotation (Placement(transformation(extent={{-60,-100},{-20,-60}})));
  Blocks.Math.Gain Gain(k=k) "Gain of PID controller"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Blocks.Math.Add3 Add annotation (Placement(transformation(extent={{20,-10},
            {40,10}})));
initial equation
  if initType==Init.InitialOutput then
     y = y_start;
  end if;

equation
  connect(u, P.u) annotation (Line(points={{-120,0},{-80,0},{-80,80},{-64,80}}, color={0,0,127}));
  connect(u, I.u)
    annotation (Line(points={{-120,0},{-64,0}}, color={0,0,127}));
  connect(u, D.u) annotation (Line(points={{-120,0},{-80,0},{-80,-80},{-64,-80}},
                 color={0,0,127}));
  connect(P.y, Add.u1) annotation (Line(points={{-18,80},{0,80},{0,8},{18,8}}, color={0,0,127}));
  connect(I.y, Add.u2)
    annotation (Line(points={{-18,0},{18,0}}, color={0,0,127}));
  connect(D.y, Add.u3) annotation (Line(points={{-18,-80},{0,-80},{0,-8},{18,-8}},
                color={0,0,127}));
  connect(Add.y, Gain.u)
    annotation (Line(points={{41,0},{58,0}}, color={0,0,127}));
  connect(Gain.y, y)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  annotation (defaultComponentName="PID",
    Icon(
        coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}}),
            graphics={
        Line(points={{-80.0,78.0},{-80.0,-90.0}},
            color={192,192,192}),
      Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
      Line(points={{-90.0,-80.0},{82.0,-80.0}},
          color={192,192,192}),
      Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}}),
      Line(points = {{-80,-80},{-80,-20},{60,80}}, color = {0,0,127}),
      Text(textColor={192,192,192},
          extent={{-20.0,-60.0},{80.0,-20.0}},
          textString="PID"),
      Text(extent={{-150.0,-150.0},{150.0,-110.0}},
          textString="Ti=%Ti")}),
    Documentation(info="<html>
<p>
This is the text-book version of a PID-controller.
For a more practically useful PID-controller, use
block LimPID.
</p>

<p>
The PID block can be initialized in different
ways controlled by parameter <strong>initType</strong>. The possible
values of initType are defined in
<a href=\"modelica://Modelica.Blocks.Types.Init\">Modelica.Blocks.Types.Init</a>.
</p>

<p>
Based on the setting of initType, the integrator (I) and derivative (D)
blocks inside the PID controller are initialized according to the following table:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>initType</strong></td>
      <td><strong>I.initType</strong></td>
      <td><strong>D.initType</strong></td></tr>

  <tr><td><strong>NoInit</strong></td>
      <td>NoInit</td>
      <td>NoInit</td></tr>

  <tr><td><strong>SteadyState</strong></td>
      <td>SteadyState</td>
      <td>SteadyState</td></tr>

  <tr><td><strong>InitialState</strong></td>
      <td>InitialState</td>
      <td>InitialState</td></tr>

  <tr><td><strong>InitialOutput</strong><br>
          and initial equation: y = y_start</td>
      <td>NoInit</td>
      <td>SteadyState</td></tr>
</table>

<p>
In many cases, the most useful initial condition is
<strong>SteadyState</strong> because initial transients are then no longer
present. If initType = Init.SteadyState, then in some
cases difficulties might occur. The reason is the
equation of the integrator:
</p>

<blockquote><pre>
<strong>der</strong>(y) = k*u;
</pre></blockquote>

<p>
The steady state equation \"der(x)=0\" leads to the condition that the input u to the
integrator is zero. If the input u is already (directly or indirectly) defined
by another initial condition, then the initialization problem is <strong>singular</strong>
(has none or infinitely many solutions). This situation occurs often
for mechanical systems, where, e.g., u = desiredSpeed - measuredSpeed and
since speed is both a state and a derivative, it is natural to
initialize it with zero. As sketched this is, however, not possible.
The solution is to not initialize u or the variable that is used
to compute u by an algebraic equation.
</p>

</html>"));
end PID;
