within Modelica.Magnetic.FundamentalWave.Machines.Components;
model SymmetricMultiPhaseWinding
  "Symmetric winding model coupling electrical and magnetic domain"

  Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(
    final m=m) "Positive plug" 
    annotation (Placement(transformation(
        origin={-100,100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(
    final m=m) "Negative plug" 
    annotation (Placement(transformation(
        origin={-100,-100},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort port_n
    "Negative complex magnetic port" 
    annotation (Placement(transformation(extent={{90,-110},{110,-90}}, rotation=
           0)));
  Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort port_p
    "Positive complex magnetic port" 
    annotation (Placement(transformation(extent={{90,90},{110,110}}, rotation=0)));

  parameter Integer m =  3 "Number of phases";
  parameter Modelica.SIunits.Resistance R "Winding resistance per phase";
  parameter Modelica.SIunits.Inductance Lsigma
    "Winding stray inductance per phase";
  parameter Real effectiveTurns = 1 "Effective number of turns per phase";

  Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
    electroMagneticConverter(
    final m=m,
    final effectiveTurns=fill(effectiveTurns, m),
    final windingAngle=Modelica.Magnetic.FundamentalWave.Machines.Functions.symmetricWindingAngle(
                                                                  m)) 
    annotation (Placement(transformation(extent={{-12,-10},{8,10}}, rotation=0)));
  Modelica.Electrical.MultiPhase.Basic.Inductor strayInductor(
    final m=m,
    final L=fill(Lsigma, m)) 
    annotation (Placement(transformation(
        origin={-10,30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.MultiPhase.Basic.Resistor resistor(
    final m=m,
    final R=fill(R, m)) 
    annotation (Placement(transformation(
        origin={-10,70},
        extent={{-10,10},{10,-10}},
        rotation=270)));

equation
  connect(plug_p, resistor.plug_p) 
    annotation (Line(points={{-100,100},{-10,100},{-10,80}}, color={0,0,255}));
  connect(resistor.plug_n, strayInductor.plug_p) 
    annotation (Line(points={{-10,60},{-10,55},{-10,40},{-10,40}},
                color={0,0,255}));
  connect(strayInductor.plug_n, electroMagneticConverter.plug_p) 
    annotation (Line(points={{-10,20},{-10,10},{-12,10}}, color={0,0,255}));
  connect(electroMagneticConverter.plug_n, plug_n) 
    annotation (Line(points={{-12,-10},{-12,-100},{-100,-100}}, color={0,0,255}));
  connect(electroMagneticConverter.port_p, port_p) 
    annotation (Line(points={{8,10},{8,100},{100,100}}, color={255,128,0}));
  connect(electroMagneticConverter.port_n, port_n) 
    annotation (Line(points={{8,-10},{8,-100},{100,-100}}, color={255,128,0}));
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
<p>
The symmetrical multi phase winding consists of a symmetrical winding 
<a href=\"Modelica://Modelica.Electrical.MultiPhase.Basic.Resistor\">resistor</a>, a symmetrical 
<a href=\"Modelica://Modelica.Electrical.MultiPhase.Basic.Inductor\">stray inductor</a> and a symmetrical 
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter\">multi phase electro magnetic coupling</a>. 
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SymmetricMultiPhaseCageWinding\">
   SymmetricMultiPhaseCageWinding</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SaliencyCageWinding\">
   SaliencyCageWinding</a>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
</p>
</html>"));
end SymmetricMultiPhaseWinding;
