within Modelica.Magnetic.FundamentalWave.Machines.Components;
model SymmetricMultiPhaseCageWinding "Symmetrical rotor cage"

  import Modelica.Constants.pi;

  extends Interfaces.PartialTwoPortElementary;

  parameter Integer m = 3 "Number of phases";
  parameter Modelica.SIunits.Resistance R "Cage resistance";
  parameter Modelica.SIunits.Inductance Lsigma "Cage stray inductance";
  parameter Real effectiveTurns = 1 "Effective number of turns";

  Modelica.SIunits.Current i[m] "Cage currents";

  Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
    winding(
    final m=m,
    final windingAngle={2*pi*(k - 1)/m for k in 1:m},
    final effectiveTurns=fill(effectiveTurns, m)) "Symmetric winding" 
    annotation (Placement(transformation(
        origin={0,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.MultiPhase.Basic.Inductor strayInductor(
    final m=m,
    final L=fill(Lsigma, m)) 
    annotation (Placement(transformation(
        origin={-20,-30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.MultiPhase.Basic.Resistor resistor(
    final m=m,
    final R=fill(R, m)) 
    annotation (Placement(transformation(
        origin={-20,-70},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.MultiPhase.Basic.Star star(
    final m=m) 
    annotation (Placement(transformation(extent={{30,-90},{50,-70}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(
        origin={70,-80},
        extent={{-10,10},{10,-10}},
        rotation=270)));

initial equation
  i = zeros(m);

equation

  i = resistor.i;

  connect(port_p, winding.port_p)                            annotation (Line(
        points={{-100,0},{-55,0},{-55,0},{-10,0}},
                         color={255,128,0}));
  connect(winding.port_n, port_n)                            annotation (Line(
        points={{10,0},{58,0},{58,0},{100,0}},
                         color={255,128,0}));
  connect(ground.p,star. pin_n) annotation (Line(points={{60,-80},{50,-80}},
        color={0,0,255}));
  connect(strayInductor.plug_n, resistor.plug_p) 
                                     annotation (Line(points={{-20,-40},{-20,
          -60}}, color={0,0,255}));
  connect(strayInductor.plug_p, winding.plug_p) annotation (Line(
      points={{-20,-20},{-10,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor.plug_n, winding.plug_n) annotation (Line(
      points={{-20,-80},{20,-80},{20,-20},{10,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(star.plug_p, winding.plug_n) annotation (Line(
      points={{30,-80},{20,-80},{20,-20},{10,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
                       Icon(graphics={
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,76},{20,36}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{28,46},{68,6}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{28,-8},{68,-48}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,-36},{20,-76}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-68,-6},{-28,-46}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-66,50},{-26,10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,0},{-100,0}}, color={255,128,0}),
        Line(points={{100,0},{80,0}}, color={255,128,0}),
        Text(
          extent={{0,100},{0,140}},
          lineColor={0,0,255},
          textString =                         "%name")}),
    Documentation(info="<html>
<p>
<img src=\"../Images/Magnetic/FundamentalWave/Machines/Components/rotorcage.png\">
</p>
<p>
The symmetric rotor cage model of this library does not consist of rotor bars and end rings. Instead the symmetric cage is modeled by an equivalent symmetrical winding. The rotor cage model consists of 
<img src=\"../Images/Magnetic/FundamentalWave/m.png\"> phases. If the cage is modeled by equivalent stator winding parameters, the number of effective turns, <img src=\"../Images/Magnetic/FundamentalWave/effectiveTurns.png\">, has to be chosen equivalent to the effective number of stator turns.
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SymmetricMultiPhaseWinding\">SymmetricMultiPhaseWinding</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SaliencyCageWinding\">SaliencyCageWinding</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
</p>
</html>"));
end SymmetricMultiPhaseCageWinding;
