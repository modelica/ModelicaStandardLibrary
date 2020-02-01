within Modelica.Electrical.Machines.BasicMachines.Components;
model ElectricalExcitation "Electrical excitation"
  parameter Real turnsRatio(start=1)
    "Ratio stator current / excitation current";
  SI.Current ie "Excitation current";
  SI.Voltage ve "Excitation voltage";
  Machines.Interfaces.SpacePhasor spacePhasor_r
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep annotation (
      Placement(transformation(extent={{90,110},{110,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_en annotation (
      Placement(transformation(extent={{110,-110},{90,-90}})));
equation
  pin_ep.i + pin_en.i = 0;
  ie = +pin_ep.i;
  ve = pin_ep.v - pin_en.v;
  spacePhasor_r.i_ = {-ie*turnsRatio,0};
  ve = spacePhasor_r.v_[1]*turnsRatio*3/2;
  annotation (defaultComponentName="excitation",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
                                    Polygon(
                points={{-90,100},{-70,106},{-70,94},{-90,100}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),Ellipse(extent={{-70,40},{
          10,-40}}, lineColor={0,0,255}),Ellipse(extent={{-10,40},{70,-40}},
          lineColor={0,0,255}),Line(points={{-30,0},{-54,32},{-50,20},{-44,
          26},{-54,32}}, color={0,0,255}),Line(points={{-30,0},{-54,-32},
          {-50,-20},{-44,-26},{-54,-32}}, color={0,0,255}),Line(points={{
          -54,32},{-54,100},{-70,100}}, color={0,0,255}),Line(points={{90,
          100},{30,100},{30,40}}, color={0,0,255}),Line(points={{30,-40},
          {30,-100},{90,-100}}, color={0,0,255}),           Text(
                extent={{-150,-148},{150,-110}},
                textColor={0,0,255},
                textString="%name")}),              Documentation(info="<html>
Model of an electrical excitation, converting excitation to space phasor.
</html>"));
end ElectricalExcitation;
