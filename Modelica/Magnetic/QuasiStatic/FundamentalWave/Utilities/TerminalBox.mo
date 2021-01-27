within Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities;
model TerminalBox "Terminal box Y/D-connection"
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  parameter String terminalConnection(start="Y") "Choose \"Y\" for star or \"D\" for delta connection"
    annotation (choices(choice="Y" "Star connection", choice="D"
        "Delta connection"));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug
    plug_sp(final m=m) "To be connected with positive stator plug" annotation (Placement(
        transformation(extent={{50,-50},{70,-70}}),
        iconTransformation(extent={{50,-50},{70,-70}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug
    plug_sn(final m=m) "To be connected with negative stator plug" annotation (Placement(
        transformation(extent={{-70,-50},{-50,-70}}),
        iconTransformation(extent={{-70,-50},{-50,-70}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star star(final m=m) if (
    terminalConnection <> "D") annotation (Placement(transformation(
        origin={-70,-80},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Delta delta(final m=m) if (
    terminalConnection == "D")
    annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug
    plugSupply(final m=m) "To be connected with grid" annotation (Placement(transformation(
          extent={{-10,-30},{10,-50}}), iconTransformation(
          extent={{-10,-30},{10,-50}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin starpoint if (
    terminalConnection <> "D") "Star point" annotation (Placement(
        transformation(extent={{-110,-50},{-90,-30}}), iconTransformation(
          extent={{-110,-50},{-90,-30}})));
equation
  connect(star.plug_p, plug_sn) annotation (Line(
      points={{-60,-80},{-60,-60}}, color={85,170,255}));
  connect(delta.plug_n, plug_sn) annotation (Line(
      points={{-40,-60},{-40,-60},{-60,-60}}, color={85,170,255}));
  connect(delta.plug_p, plug_sp) annotation (Line(
      points={{-20,-60},{60,-60},{60,-60}}, color={85,170,255}));
  connect(plugSupply, plug_sp) annotation (Line(
      points={{0,-40},{0,-60},{60,-60}}, color={85,170,255}));
  connect(star.pin_n, starpoint) annotation (Line(
      points={{-80,-80},{-86,-80},{-86,-40},{-100,-40}},color={85,170,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Text(
              extent={{-40,-50},{40,-90}},
              textString="%terminalConnection"),Polygon(
              points={{-80,-40},{-80,-44},{-80,-80},{-40,-100},{40,-100},{
              80,-70},{80,-44},{76,-40},{-80,-40}},
              lineColor={95,95,95},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),    Text(
              extent={{-40,-50},{40,-90}},
              textString="%terminalConnection")}),
    Documentation(info="<html>
<p>
This model represents the internal connections of the terminal box of an electric machine.
The parameter <code>terminalConnection</code> is used to switch between star
(<code>terminalConnection = \"Y\"</code>) and delta (<code>terminalConnection = \"D\"</code>) connection.
The (single-phase) connector <code>starPoint</code> is only available if star connection is selected.
</p>
</html>"));
end TerminalBox;
