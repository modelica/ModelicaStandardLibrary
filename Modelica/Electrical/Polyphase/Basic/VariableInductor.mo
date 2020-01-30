within Modelica.Electrical.Polyphase.Basic;
model VariableInductor
  "Ideal linear electrical inductors with variable inductance"
  extends Interfaces.TwoPlug;
  parameter SI.Inductance Lmin[m]=fill(Modelica.Constants.eps,
      m) "Minimum inductance";
  Modelica.Blocks.Interfaces.RealInput L[m](each unit="H") annotation (
      Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Electrical.Analog.Basic.VariableInductor variableInductor[m](
      final Lmin=Lmin) annotation (Placement(transformation(extent={{-10,-10},
            {10,10}})));

equation
  connect(variableInductor.p, plug_p.pin)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(variableInductor.n, plug_n.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(L, variableInductor.L)
    annotation (Line(points={{0,120},{0,56},{0,12}}, color={0,0,255}));
  annotation (defaultComponentName="inductor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{-90,0},{-60,0}}, color={0,0,255}),
        Line(points={{60,0},{90,0}}, color={0,0,255}),
        Line(
          points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Text(
          extent={{-150,-80},{150,-40}},
          textString="m=%m"),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}), Documentation(info="<html>
<p>
Contains m variable inductors (Modelica.Electrical.Analog.Basic.VariableInductor)
</p>
<p>
It is required that each L_Port.signal &ge; 0, otherwise an
assertion is raised. To avoid a variable index system,<br>
L = Lmin, if 0 &le; L_Port.signal &lt; Lmin, where
Lmin is a parameter with default value Modelica.Constants.eps.
</p>
</html>"));
end VariableInductor;
