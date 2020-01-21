within Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities;
model MultiTerminalBox "Terminal box Y/D-connection"
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  final parameter Integer mSystems=
      Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(
                                                                  m) "Number of symmetric base systems";
  final parameter Integer mBasic=integer(m/mSystems) "Number of phases of basic system" annotation(Evaluate=true);
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
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.MultiStar multiStar(final m=m)
    if (terminalConnection <> "D") annotation (Placement(transformation(
        origin={-70,-80},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.MultiDelta multiDelta(final m=m)
    if (terminalConnection == "D")
    annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug
    plugSupply(final m=m) "To be connected with grid" annotation (Placement(transformation(
          extent={{-10,-30},{10,-50}}), iconTransformation(
          extent={{-10,-30},{10,-50}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug
    starpoint(final m=mSystems) if (terminalConnection <> "D") "Star point" annotation (
      Placement(transformation(extent={{-110,-50},{-90,-30}}),
        iconTransformation(extent={{-110,-50},{-90,-30}})));
equation
  connect(multiStar.plug_p, plug_sn) annotation (Line(
      points={{-60,-80},{-60,-60}}, color={85,170,255}));
  connect(starpoint, multiStar.starpoints) annotation (Line(
      points={{-100,-40},{-86,-40},{-86,-80},{-80,-80}},color={85,170,255}));
  connect(multiDelta.plug_n, plug_sn) annotation (Line(
      points={{-40,-60},{-40,-60},{-60,-60}}, color={85,170,255}));
  connect(multiDelta.plug_p, plug_sp) annotation (Line(
      points={{-20,-60},{60,-60},{60,-60}}, color={85,170,255}));
  connect(plugSupply, plug_sp) annotation (Line(
      points={{0,-40},{0,-60},{60,-60}}, color={85,170,255}));
  annotation (defaultComponentName="terminalBox",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Polygon(
              points={{-74,-40},{-80,-46},{-80,-80},{-40,-100},{40,-100},{
              80,-70},{80,-44},{76,-40},{-74,-40}},
              lineColor={95,95,95},
              fillColor={135,135,135},
              fillPattern=FillPattern.CrossDiag),Text(
              extent={{-40,-50},{40,-90}},
              textString="%terminalConnection")}),
    Documentation(info="<html>
<p>
This model represents the internal connections of the terminal box of an electric machine.
The parameter <code>terminalConnection</code> is used to switch between star
(<code>terminalConnection = \"Y\"</code>) and delta (<code>terminalConnection = \"D\"</code>) connection.
</p>

<p>The connector <code>starPoint</code> is only available if star connection is selected.
This connector is a plug with
<code>mSystem = Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m)</code> phases,
representing the star points of each base system; see
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase\">Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase</a>.
</p>
</html>"));
end MultiTerminalBox;
