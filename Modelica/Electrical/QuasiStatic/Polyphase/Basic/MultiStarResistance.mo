within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model MultiStarResistance "Resistance connection of star points"
  parameter Integer m(final min=3) = 3 "Number of phases" annotation(Evaluate=true);
  final parameter Integer mBasic=
      Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(
      m) "Number of symmetric base systems";
  parameter SI.Resistance R=1e6
    "Insulation resistance between base systems";
  Interfaces.PositivePlug plug(m=m)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  MultiStar multiStar(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-50,0})));
  Resistor resistor(m=mBasic, final R_ref=fill(R, mBasic)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}})));
  Star star(m=mBasic) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={50,0})));
  SinglePhase.Interfaces.NegativePin pin annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={100,0})));
equation
  connect(plug, multiStar.plug_p) annotation (Line(
      points={{-100,0},{-60,0}}, color={85,170,255}));
  connect(multiStar.starpoints, resistor.plug_p) annotation (Line(
      points={{-40,0},{-10,0}}, color={85,170,255}));
  connect(resistor.plug_n, star.plug_p) annotation (Line(
      points={{10,0},{40,0}}, color={85,170,255}));
  connect(star.pin_n, pin) annotation (Line(
      points={{60,0},{100,0}}, color={85,170,255}));
  annotation (defaultComponentName="multiStar",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Line(
              points={{-40,40},{0,0},{40,40},{0,0},{0,-40}},
              color={85,170,255},
              origin={-60,0},
              rotation=90),Rectangle(
              extent={{-10,20},{10,-20}},
              lineColor={85,170,255},
              rotation=90),Line(
              points={{-40,40},{0,0},{40,40},{0,0},{0,-40}},
              color={85,170,255},
              origin={60,0},
              rotation=90),
        Text(
          extent={{-150,70},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-110},{150,-70}},
          textString="R=%R")}),
    Documentation(info="<html>
<p>
Multi star points are connected by resistors. This model is required to operate polyphase systems with even phase numbers to avoid ideal connections of start points of base systems; see
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase\">polyphase guidelines</a>.
</p>
</html>"));
end MultiStarResistance;
