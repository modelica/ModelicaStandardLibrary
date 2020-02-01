within Modelica.Electrical.Polyphase.Basic;
model VariableCapacitor
  "Ideal linear electrical capacitors with variable capacitance"
  extends Interfaces.TwoPlug;
  parameter SI.Capacitance Cmin[m]=fill(Modelica.Constants.eps,
      m) "Minimum capacitance";
  Modelica.Blocks.Interfaces.RealInput C[m](each unit="F") annotation (
      Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.VariableCapacitor variableCapacitor[m](
      final Cmin=Cmin) annotation (Placement(transformation(extent={{-10,-10},
            {10,10}})));
equation
  connect(variableCapacitor.p, plug_p.pin)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(variableCapacitor.n, plug_n.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(C, variableCapacitor.C)
    annotation (Line(points={{0,120},{0,56},{0,12}}, color={0,0,255}));
  annotation (defaultComponentName="capacitor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(points={{-90,0},{-6,0}}, color={0,0,255}),
        Line(points={{6,0},{90,0}}, color={0,0,255}),
        Line(points={{-6,28},{-6,-28}}, color={0,0,255}),
        Line(points={{6,28},{6,-28}}, color={0,0,255}),
        Text(
          extent={{-150,-80},{150,-40}},
          textString="m=%m"),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}),
                              Documentation(info="<html>
<p>
Contains m variable capacitors (Modelica.Electrical.Analog.Basic.VariableCapacitor)
</p>
<p>
It is required that each C_Port.signal &ge; 0, otherwise an
assertion is raised. To avoid a variable index system,<br>
C = Cmin, if 0 &le; C_Port.signal &lt; Cmin, where
Cmin is a parameter with default value Modelica.Constants.eps.
</p>
</html>"));
end VariableCapacitor;
