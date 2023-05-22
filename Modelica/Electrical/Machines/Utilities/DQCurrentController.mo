within Modelica.Electrical.Machines.Utilities;
model DQCurrentController
  "Current controller in dq coordinate system"
  import Modelica.Constants.pi;
  constant Integer m=3 "Number of phases";
  parameter Integer p "Number of pole pairs";
  parameter Boolean useRMS=true "If true, inputs dq are multiplied by sqrt(2)";
  parameter SI.Frequency fsNominal "Nominal frequency";
  parameter SI.Voltage VsOpenCircuit
    "Open circuit RMS voltage per phase @ fsNominal";
  parameter SI.Resistance Rs "Stator resistance per phase";
  parameter SI.Inductance Ld "Inductance in d-axis";
  parameter SI.Inductance Lq "Inductance in q-axis";
  //Decoupling
  parameter Boolean decoupling=false "Use decoupling network";
  final parameter SI.MagneticFlux psiM=sqrt(2)*VsOpenCircuit/
      (2*pi*fsNominal) "Approximation of magnetic flux linkage";
  SI.AngularVelocity omega=p*der(phi);
  SI.Voltage Vd=sqrt(2)*(Rs*id - omega*Lq*iq);
  SI.Voltage Vq=sqrt(2)*(Rs*iq + omega*Ld*id) + omega*psiM;
  extends Modelica.Blocks.Interfaces.MO(final nout=m);
  Modelica.Blocks.Interfaces.RealInput id "Reference of d-current"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput iq "Reference of q-current"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput phi(unit="rad") "Rotor angle"
    annotation (Placement(
        transformation(
        origin={60,-120},
        extent={{20,-20},{-20,20}},
        rotation=270)));
  Modelica.Blocks.Interfaces.RealInput iActual[m](each unit="A")
    "Measured three-phase currents" annotation (Placement(
        transformation(
        origin={-60,-120},
        extent={{20,-20},{-20,20}},
        rotation=270)));
  Machines.Utilities.FromDQ fromDQ(final p=p, final m=m)
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Machines.Utilities.ToDQ toDQ(final p=p, final m=m) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-80})));
  Modelica.Blocks.Math.Gain toPeak_d(final k=if useRMS then sqrt(2) else 1)
                                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-70,60})));
  Modelica.Blocks.Math.Gain toPeak_q(final k=if useRMS then sqrt(2) else 1)
                                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-70,0})));
  Modelica.Blocks.Math.Feedback feedback_d
    annotation (Placement(transformation(extent={{-38,50},{-18,70}})));
  Modelica.Blocks.Math.Feedback feedback_q
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Continuous.PI PI_d(
    final k=unitResistance/Rs,
    final T=Ld/Rs,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Continuous.PI PI_q(
    final k=unitResistance/Rs,
    final T=Lq/Rs,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Add add[2](final k1=fill(+1, 2), final k2=fill(if
        decoupling then +1 else 0, 2))
    annotation (Placement(transformation(extent={{32,-10},{52,10}})));
  Modelica.Blocks.Sources.RealExpression deCoupling[2](y={Vd,Vq})
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
protected
  constant SI.Resistance unitResistance=1
    annotation (HideResult=true);
equation
  connect(fromDQ.y, y) annotation (Line(
      points={{91,0},{110,0}}, color={0,0,127}));
  connect(phi, fromDQ.phi) annotation (Line(
      points={{60,-120},{60,-80},{80,-80},{80,-12}}, color={0,0,127}));
  connect(iActual, toDQ.u) annotation (Line(
      points={{-60,-120},{-60,-92}}, color={0,0,127}));
  connect(phi, toDQ.phi) annotation (Line(
      points={{60,-120},{60,-80},{-48,-80}}, color={0,0,127}));
  connect(toPeak_d.u, id)
    annotation (Line(points={{-82,60},{-120,60}}, color={0,0,127}));
  connect(toPeak_q.u, iq) annotation (Line(points={{-82,0},{-90,0},{-90,-60},{-120,
          -60}}, color={0,0,127}));
  connect(toPeak_q.y, feedback_q.u1) annotation (Line(
      points={{-59,0},{-38,0}}, color={0,0,127}));
  connect(toPeak_d.y, feedback_d.u1) annotation (Line(
      points={{-59,60},{-36,60}}, color={0,0,127}));
  connect(feedback_d.y, PI_d.u) annotation (Line(
      points={{-19,60},{-12,60}}, color={0,0,127}));
  connect(feedback_q.y, PI_q.u) annotation (Line(
      points={{-21,0},{-12,0}}, color={0,0,127}));
  connect(toDQ.y[1], feedback_d.u2) annotation (Line(
      points={{-60,-69},{-60,-60},{-50,-60},{-50,40},{-28,40},{-28,52}},     color={0,0,127}));

  connect(toDQ.y[2], feedback_q.u2) annotation (Line(
      points={{-60,-69},{-60,-60},{-50,-60},{-50,-20},{-30,-20},{-30,-8}},     color={0,0,127}));

  connect(add.y, fromDQ.u) annotation (Line(
      points={{53,0},{68,0}}, color={0,0,127}));
  connect(PI_d.y, add[1].u1) annotation (Line(
      points={{11,60},{20,60},{20,6},{30,6}}, color={0,0,127}));
  connect(PI_q.y, add[2].u1) annotation (Line(
      points={{11,0},{20,0},{20,6},{30,6}}, color={0,0,127}));
  connect(deCoupling.y, add.u2) annotation (Line(
      points={{11,-30},{20,-30},{20,-6},{30,-6}}, color={0,0,127}));
  annotation (defaultComponentName="dqCurrentController",
                                  Documentation(info="<html>
<p>
Simple Current controller
</p>
<p>
The desired d- and q-component of the space phasor current in rotor fixed coordinate system are given by inputs <code>id</code> and <code>iq</code>.
Using the given rotor position (input <code>phi</code>), the actual three-phase currents are measured and transformed to the d-q coordinate system.
Two PI-controllers determine the necessary d- and q- voltages, which are transformed back to three-phase (output <code>y[3]</code>).
They can be used to feed a voltage source which in turn feeds a permanent magnet synchronous machine.
</p>
<p>
Inputs <code>d</code> and <code>q</code> can be given either as peak values (<code>useRMS=false</code>) or as RMS (<code>useRMS=true</code>).
The correction by factor &radic;2 is done automatically.
The measured currents <code>iActual[m]</code> are assumed to be instantaneous values.
</p>
<p>
Note: No care is taken for current or voltage limiting, as well as for field weakening.
</p>
</html>"),
    Icon(graphics={                      Text(
          extent={{-100,70},{-60,50}},
          textColor={0,0,255},
          textString="id"),              Text(
          extent={{-100,-50},{-60,-70}},
          textColor={0,0,255},
          textString="iq"),              Text(
          extent={{42,-70},{82,-90}},
          textColor={0,0,255},
          textString="phi")}));
end DQCurrentController;
