within Modelica.Electrical.Machines.Utilities;
model MultiTerminalBox "Terminal box Y/D-connection"
  parameter Integer m(min=1) = 3 "Number of phases" annotation(Evaluate=true);
  final parameter Integer mSystems=
      Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(
      m) "Number of symmetric base systems";
  final parameter Integer mBasic=integer(m/mSystems) "Number of phases of basic system";
  parameter String terminalConnection(start="Y") "Choose \"Y\" for star or \"D\" for delta connection"
    annotation (choices(choice="Y" "Star connection", choice="D"
        "Delta connection"));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_sp(final m=m)
    "To be connected with positive stator plug" annotation (Placement(transformation(extent={{50,-50},
            {70,-70}}), iconTransformation(extent={{
            50,-50},{70,-70}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_sn(final m=m)
    "To be connected with negative stator plug" annotation (Placement(transformation(extent={{-70,-50},
            {-50,-70}}), iconTransformation(extent={
            {-70,-50},{-50,-70}})));
  Polyphase.Basic.MultiStar multiStar(final m=m) if (terminalConnection
     <> "D") annotation (Placement(transformation(
        origin={-70,-80},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Polyphase.Basic.MultiDelta multiDelta(final m=m) if (terminalConnection
     == "D") annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plugSupply(final m=
       m) "To be connected with grid" annotation (Placement(transformation(extent={{-10,-30},
            {10,-50}}), iconTransformation(extent={{-10,-30},{
            10,-50}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug starpoint(final m=
        mSystems) if (terminalConnection <> "D") "Star point" annotation (Placement(
        transformation(extent={{-110,-50},{-90,-30}}),
        iconTransformation(extent={{-110,-50},{-90,-30}})));
equation
  connect(plug_sn, multiStar.plug_p)
    annotation (Line(points={{-60,-60},{-60,-80}}, color={0,0,255}));
  connect(plug_sn, multiDelta.plug_n) annotation (Line(points={{-60,-60},{
          -40,-60},{-40,-60}}, color={0,0,255}));
  connect(multiDelta.plug_p, plug_sp) annotation (Line(points={{-20,-60},{
          60,-60},{60,-60}}, color={0,0,255}));
  connect(plug_sp, plugSupply) annotation (Line(points={{60,-60},{0,-60},{0,
          -40}}, color={0,0,255}));
  connect(starpoint, multiStar.starpoints) annotation (Line(
      points={{-100,-40},{-86,-40},{-86,-80},{-80,-80}},color={0,0,255}));
  annotation (defaultComponentName="terminalBox",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Polygon(
          points={{-74,-40},{-80,-46},{-80,-80},{-40,-100},{40,-100},{80,-70},{80,-44},{76,-40},{-74,-40}},
          lineColor={95,95,95},
          fillColor={135,135,135},
          fillPattern=FillPattern.CrossDiag), Text(
          extent={{-40,-50},{40,-90}},
          textString="%terminalConnection")}),
    Documentation(info="<html>
<p>
This model represents the internal connections of the terminal box of an electric machine.
The parameter <code>terminalConnection</code> is used to switch between star
(<code>terminalConnection = \"Y\"</code>) and delta (<code>terminalConnection = \"D\"</code>) connection.
The star point is a plug with
<code>mSystem = Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m)</code> phases,
representing the star points of each base system; see
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase\">Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase</a>.
</p>
</html>"));
end MultiTerminalBox;
