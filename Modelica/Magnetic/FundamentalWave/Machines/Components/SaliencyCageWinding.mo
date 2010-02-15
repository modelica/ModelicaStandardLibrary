within Modelica.Magnetic.FundamentalWave.Machines.Components;
model SaliencyCageWinding "Rotor cage with saliency in d- and q-axis"
  extends Interfaces.PartialTwoPortElementary;

  parameter Modelica.Magnetic.FundamentalWave.Types.SalientResistance R(
    d(start=1), q(start=1)) "Salient cage resistance";
  parameter Modelica.Magnetic.FundamentalWave.Types.SalientInductance Lsigma(
    d(start=1), q(start=1)) "Salient cage stray inductance";
  parameter Real effectiveTurns = 1 "Effective number of turns";

  Modelica.Magnetic.FundamentalWave.Types.SalientCurrent i "Cage current";

  Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
    winding(
    final m=2,
    final windingAngle={0,Modelica.Constants.pi/2},
    final effectiveTurns=fill(effectiveTurns, 2)) "Symmetric winding" 
    annotation (Placement(transformation(
        origin={0,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.MultiPhase.Basic.Inductor strayInductor(
    final m=2,
    final L={Lsigma.d,Lsigma.q}) 
    annotation (Placement(transformation(
        origin={-20,-30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.MultiPhase.Basic.Resistor resistor(
    final m=2,
    final R={R.d,R.q}) 
    annotation (Placement(transformation(
        origin={-20,-70},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.MultiPhase.Basic.Star star(
    final m=2) 
    annotation (Placement(transformation(extent={{28,-90},{48,-70}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(
        origin={70,-80},
        extent={{-10,10},{10,-10}},
        rotation=270)));

initial equation
  i = Modelica.Magnetic.FundamentalWave.Types.Salient(
      0, 0);
equation
  i.d = resistor.i[1];
  i.q = resistor.i[2];

  connect(port_p, winding.port_p)                            annotation (Line(
        points={{-100,0},{-55,0},{-55,0},{-10,0}},
                         color={255,128,0}));
  connect(winding.port_n, port_n)                            annotation (Line(
        points={{10,0},{58,0},{58,0},{100,0}},
                         color={255,128,0}));
  connect(ground.p,star. pin_n) annotation (Line(points={{60,-80},{48,-80}},
        color={0,0,255}));
  connect(strayInductor.plug_n, resistor.plug_p) 
                                     annotation (Line(points={{-20,-40},{-20,
          -60}}, color={0,0,255}));
  connect(winding.plug_n, resistor.plug_n) annotation (Line(
      points={{10,-20},{20,-20},{20,-80},{-20,-80}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(star.plug_p, winding.plug_n) annotation (Line(
      points={{28,-80},{20,-80},{20,-20},{10,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(strayInductor.plug_p, winding.plug_p) annotation (Line(
      points={{-20,-20},{-10,-20}},
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
The salient cage model is a two axis model with two phases. The electro magnetic coupling therefore is also two phase coupling model. The angles of the two winding axis are 0 and <img src=\"../Images/Magnetic/FundamentalWave/pi_over_2.png\">. This way an asymmetrical rotor cage with different resistances and stray inductances in d- and q-axis can be modeled.
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SymmetricMultiPhaseWinding\">SymmetricMultiPhaseWinding</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.SymmetricMultiPhaseCageWinding\">
   SymmetricMultiPhaseCageWinding</a>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Machines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
</p>
</html>"));
end SaliencyCageWinding;
