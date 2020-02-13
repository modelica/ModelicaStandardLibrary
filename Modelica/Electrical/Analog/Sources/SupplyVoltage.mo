within Modelica.Electrical.Analog.Sources;
model SupplyVoltage "Supply voltage (positive and negative)"
  parameter SI.Voltage Vps=+15 "Positive supply";
  parameter SI.Voltage Vns=-15 "Negative supply";
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin ground
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage positiveSupply(final V=
        Vps)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage negativeSupply(final V=-
        Vns) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(pin_p, positiveSupply.p) annotation (Line(
      points={{-100,0},{-60,0}}, color={0,0,255}));
  connect(negativeSupply.n, pin_n) annotation (Line(
      points={{60,0},{100,0}}, color={0,0,255}));
  connect(positiveSupply.n, ground) annotation (Line(
      points={{-40,0},{0,0}}, color={0,0,255}));
  connect(ground, negativeSupply.p) annotation (Line(
      points={{0,0},{40,0}}, color={0,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Line(
          points={{-60,40},{-60,-40}},
          color={0,0,255}),
        Line(
          points={{40,40},{40,-40}},
          color={0,0,255}),
        Line(
          points={{-40,20},{-40,-20}},
          color={0,0,255}),
        Line(
          points={{60,20},{60,-20}},
          color={0,0,255}),
        Line(
          points={{-90,0},{-60,0}},
          color={0,0,255}),
        Line(
          points={{60,0},{90,0}},
          color={0,0,255}),
        Text(
          extent={{-150,110},{150,70}},
          textColor={0,0,255},
          textString="%name"),
        Line(
          points={{-40,0},{-10,0}},
          color={0,0,255}),
        Line(
          points={{10,0},{40,0}},
          color={0,0,255}),
        Text(
          extent={{-100,40},{-80,20}},
          textColor={0,0,255},
          textString="+"),
        Text(
          extent={{80,40},{100,20}},
          textColor={0,0,255},
          textString="-"),
        Text(
          extent={{-10,40},{10,20}},
          textColor={0,0,255},
          textString="0")}),
    Documentation(info="<html>
                       <p>This is a simple model of a constant supply voltage with positive and negative supply, the potential between positive and negative supply is accessible.</p>
                       </html>"));
end SupplyVoltage;
