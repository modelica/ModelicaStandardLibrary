within Modelica.Electrical.Machines.Utilities;
model DQToThreePhase "Transforms dq to three-phase"
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter Integer p "Number of pole pairs";
  parameter Boolean useRMS=true "If true, inputs dq are multiplied by sqrt(2)";
  extends Modelica.Blocks.Interfaces.MO(final nout=m);
  Modelica.Blocks.Interfaces.RealInput d "d-component"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput q "q-component"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput phi(unit="rad") "Rotor angle"
                                                       annotation (Placement(
        transformation(
        origin={0,-120},
        extent={{20,-20},{-20,20}},
        rotation=270)));
  Modelica.Blocks.Math.Gain toPeak_d(k=if useRMS then sqrt(2) else 1)
                                                annotation (Placement(
        transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Math.Gain toPeak_q(k=if useRMS then sqrt(2) else 1)
                                                annotation (Placement(
        transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Math.Gain toGamma(k=-p) annotation (Placement(
        transformation(
        origin={0,-50},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Machines.SpacePhasors.Blocks.Rotator rotator
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant i0(k=0) annotation (Placement(
        transformation(extent={{-10,50},{10,30}})));
  Machines.SpacePhasors.Blocks.FromSpacePhasor fromSpacePhasor(final m=m)
    annotation (Placement(transformation(extent={{40,10},{60,-10}})));
equation
  connect(q, toPeak_q.u)
    annotation (Line(points={{-120,-60},{-62,-60}}, color={0,0,127}));
  connect(phi, toGamma.u)
    annotation (Line(points={{0,-120},{0,-62}}, color={0,0,127}));
  connect(rotator.angle, toGamma.y)
    annotation (Line(points={{0,-12},{0,-39},{0,-39}}, color={0,0,127}));
  connect(rotator.y, fromSpacePhasor.u)
    annotation (Line(points={{11,0},{24,0},{38,0}}, color={0,0,127}));
  connect(toPeak_d.u, d)
    annotation (Line(points={{-62,60},{-120,60}}, color={0,0,127}));
  connect(toPeak_d.y, rotator.u[1]) annotation (Line(
      points={{-39,60},{-30,60},{-30,0},{-12,0}},   color={0,0,127}));
  connect(toPeak_q.y, rotator.u[2]) annotation (Line(
      points={{-39,-60},{-30,-60},{-30,0},{-12,0}}, color={0,0,127}));
  connect(i0.y, fromSpacePhasor.zero) annotation (Line(
      points={{11,40},{20,40},{20,8},{38,8}}, color={0,0,127}));
  connect(fromSpacePhasor.y, y) annotation (Line(
      points={{61,0},{110,0}}, color={0,0,127}));
  annotation (defaultComponentName="dqToThreePhase",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-100,70},{-60,50}},
          textColor={0,0,255},
          textString="d"),               Text(
          extent={{-100,-50},{-60,-70}},
          textColor={0,0,255},
          textString="q"),               Text(
          extent={{-20,-70},{20,-90}},
          textColor={0,0,255},
          textString="phi")}),    Documentation(info="<html>
<p>
Transforms dq currents or voltages to three-phase currents or voltages.
</p>
<p>
The desired d- and q-components of the space phasor in rotor fixed coordinate system are given by inputs <code>d</code> and <code>q</code>.
Using the given rotor position (input <code>phi</code>), the correct three-phase values (output <code>y[3]</code>) are calculated.
They can be used to feed a current source which in turn feeds an induction machine.
</p>
<p>
Inputs <code>d</code> and <code>q</code> can be given either as peak values (<code>useRMS=false</code>) or as RMS (<code>useRMS=true</code>).
The correction by factor &radic;2 is done automatically.
</p>
</html>"));
end DQToThreePhase;
