within Modelica.Electrical.Polyphase.Basic;
model MultiStarResistance "Resistance connection of star points"
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  parameter Integer m(final min=2) = 3 "Number of phases" annotation(Evaluate=true);
  final parameter Integer mBasic=numberOfSymmetricBaseSystems(m) "Number of symmetric base systems";
  parameter SI.Resistance R=1e6 "Insulation resistance between base systems";
  Polyphase.Interfaces.PositivePlug plug(m=m)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Polyphase.Basic.MultiStar multiStar(m=m) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}}, origin={-50,0})));
  Polyphase.Basic.Resistor resistor(m=mBasic, R=fill(R, mBasic))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Polyphase.Basic.Star star(m=mBasic) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}}, origin={50,0})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={100,0})));
equation
  connect(plug, multiStar.plug_p) annotation (Line(
      points={{-100,0},{-100,0},{-60,0},{-60,0}}, color={0,0,255}));
  connect(multiStar.starpoints, resistor.plug_p) annotation (Line(
      points={{-40,0},{-40,0},{-10,0}}, color={0,0,255}));
  connect(resistor.plug_n, star.plug_p) annotation (Line(
      points={{10,0},{10,0},{34,0},{34,0},{40,0},{40,0}}, color={0,0,255}));
  connect(star.pin_n, pin) annotation (Line(
      points={{60,0},{60,0},{98,0},{98,0},{100,0},{100,
          0}}, color={0,0,255}));
  annotation (defaultComponentName="multiStar",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Line(
          points={{-40,40},{0,0},{40,40},{0,0},{0,-40}},
          color={0,0,255},
          origin={-60,0},
          rotation=90),
        Rectangle(
          extent={{-10,20},{10,-20}},
          lineColor={0,0,255},
          rotation=90),
        Line(
          points={{-40,40},{0,0},{40,40},{0,0},{0,-40}},
          color={0,0,255},
          origin={60,0},
          rotation=90),
        Text(
          extent={{-150,-90},{150,-50}},
          textString="R=%R"),
        Text(
          extent={{-150,60},{150,100}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
Multi star points are connected by resistors. This model is required to operate polyphase systems with even phase numbers to avoid ideal connections of start points of base systems; see
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase\">polyphase guidelines</a>.
</p>
</html>"));
end MultiStarResistance;
