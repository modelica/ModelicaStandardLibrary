within Modelica.Electrical.Machines.BasicMachines.Components;
model CompoundDCExcitation "Compound excitation = shunt + series"
  parameter Real excitationTurnsRatio
    "Ratio of series excitation turns over shunt excitation turns";
  SI.Voltage v=pin_p.v - pin_n.v;
  SI.Current i=pin_p.i;
  SI.Voltage ve=pin_ep.v - pin_en.v;
  SI.Current ie=pin_ep.i;
  SI.Voltage vse=pin_sep.v - pin_sen.v;
  SI.Current ise=pin_sep.i;
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
    "Positive pin to airgap"
    annotation (Placement(transformation(extent={{90,110},{110,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
    "Negative pin to airgap"
    annotation (Placement(transformation(extent={{-110,110},{-90,90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
    "Positive pin to shunt excitation"
    annotation (Placement(transformation(extent={{90,-108},{110,-88}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
    "Negative pin to shunt excitation"
    annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_sep
    "Positive pin to series excitation"
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_sen
    "Negative pin to series excitation" annotation (Placement(
        transformation(extent={{-110,-110},{-90,-90}})));
equation
  //current balances
  pin_p.i + pin_n.i = 0;
  pin_ep.i + pin_en.i = 0;
  pin_sep.i + pin_sen.i = 0;
  //compound currents
  -i = ie + excitationTurnsRatio*ise;
  //induced voltages
  ve = v;
  vse = v*excitationTurnsRatio;
  annotation (defaultComponentName="excitation",
    Icon(graphics={Polygon(
                points={{-60,-40},{-40,-40},{0,4},{40,-40},{60,-40},{10,
            20},{10,60},{20,60},{0,80},{-20,60},{-10,60},{-10,20},{-60,-40}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),Text(
                extent={{-80,-40},{-40,-80}},
                textColor={0,0,255},
                textString="S"),Text(
                extent={{40,-40},{80,-80}},
                textColor={0,0,255},
                textString="E")}), Documentation(info="<html>
Model to compound the shunt excitation current and the series excitation current to the total excitation current w.r.t. shunt excitation.
This model is intended to be placed between shunt and series excitation pins and the airgap;
the connection to airgap has to be grounded at one point.
</html>"));
end CompoundDCExcitation;
