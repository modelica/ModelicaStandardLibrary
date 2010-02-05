within Modelica.Magnetic.FundamentalWave.Machines.Components;
model SinglePhaseWinding
  "Symmetric winding model coupling electrical and magnetic domain"

  Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort port_n
    "Negative complex magnetic port" 
    annotation (Placement(transformation(extent={{90,-110},{110,-90}}, rotation=
           0)));
  Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort port_p
    "Positive complex magnetic port" 
    annotation (Placement(transformation(extent={{90,90},{110,110}}, rotation=0)));

  parameter Modelica.SIunits.Resistance R
    "Winding reference resistance per phase";
  parameter Modelica.SIunits.Inductance Lsigma
    "Winding stray inductance per phase";
  parameter Real effectiveTurns = 1 "Effective number of turns per phase";
  parameter Modelica.SIunits.Angle windingAngle "Angle of the winding axis";

  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "Positive pin" 
    annotation (Placement(transformation(
        origin={-100,100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative pin" 
    annotation (Placement(transformation(
        origin={-100,-100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Inductor strayInductor(final L=Lsigma) 
    annotation (Placement(transformation(
        origin={-10,30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(final R=R) 
    annotation (Placement(transformation(
        origin={-10,70},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter
    electroMagneticConverter(
    final effectiveTurns=effectiveTurns,
    final windingAngle=windingAngle) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
equation
  connect(pin_p, resistor.p) 
    annotation (Line(points={{-100,100},{-10,100},{-10,80}}, color={0,0,255}));
  connect(resistor.n, strayInductor.p) 
    annotation (Line(points={{-10,60},{-10,50},{-10,40},{-10,40}}, color={0,0,
          255}));
  connect(strayInductor.n, electroMagneticConverter.pin_p) 
    annotation (Line(points={{-10,20},{-10,15},{-10,10},{-10,10}}, color={0,0,
          255}));
  connect(electroMagneticConverter.pin_n, pin_n) 
    annotation (Line(points={{-10,-10},{-10,-100},{-100,-100}}, color={0,0,255}));
  connect(electroMagneticConverter.port_p, port_p) 
    annotation (Line(points={{10,10},{10,100},{100,100}}, color={255,128,0}));
  connect(electroMagneticConverter.port_n, port_n) 
    annotation (Line(points={{10,-10},{10,-100},{100,-100}}, color={255,128,0}));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{100,-100},{94,-100},{84,-98},{76,-94},{64,-86},{50,-72},{
              42,-58},{36,-40},{30,-18},{30,0},{30,18},{34,36},{46,66},{62,84},
              {78,96},{90,100},{100,100}}, color={255,128,0}),
        Line(points={{40,60},{-100,60},{-100,100}}, color={0,0,255}),
        Line(points={{40,-60},{-100,-60},{-100,-98}}, color={0,0,255}),
        Line(points={{40,60},{100,20},{40,-20},{0,-20},{-40,0},{0,20},{40,20},{
              100,-20},{40,-60}}, color={0,0,255}),
        Text(
          extent={{0,160},{0,120}},
          lineColor={0,0,255},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid,
          textString=
               "%name")}),  Diagram(graphics),
  Documentation(info="<html>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SymmetricMultiPhaseWinding\">SymmetricMultiPhaseWinding</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SymmetricMultiPhaseCageWinding\">
   SymmetricMultiPhaseCageWinding</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SaliencyCageWinding\">
   SaliencyCageWinding</a>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
</p>
</html>"));
end SinglePhaseWinding;
