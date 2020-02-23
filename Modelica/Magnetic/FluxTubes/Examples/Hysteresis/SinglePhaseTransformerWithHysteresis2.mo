within Modelica.Magnetic.FluxTubes.Examples.Hysteresis;
model SinglePhaseTransformerWithHysteresis2
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Ground el_ground1
    annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=0.05) annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage(f=
       400, V=6) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-60,20})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R=2) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={40,40})));
  Modelica.Electrical.Analog.Basic.Ground el_ground2
    annotation (Placement(transformation(extent={{30,-20},{50,0}})));
  Components.Transformer1PhaseWithHysteresis transformer(
    mat=FluxTubes.Material.HysteresisEverettParameter.M330_50A(),
    MagRelFixed=true,
    I1Fixed=true,
    EddyCurrents=false,
    HFixed=false) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
initial equation
  transformer.core.derHstat = 0.0;
equation
  connect(SineVoltage.p, resistor1.p) annotation (Line(points={{-60,30},{-60,40},{-50,40}}, color={0,0,255}));
  connect(SineVoltage.n, el_ground1.p) annotation (Line(points={{-60,10},{-60,0},{-40,0}},color={0,0,255}));
  connect(resistor2.n, el_ground2.p) annotation (Line(points={{50,40},{60,40},{60,0},{40,0}}, color={0,0,255}));
  connect(resistor1.n, transformer.p1) annotation (Line(points={{-30,40},{-20,40},{-20,30},{-10,30}}, color={0,0,255}));
  connect(transformer.n1, el_ground1.p) annotation (Line(points={{-10,10},{-20,10},{-20,0},{-40,0}}, color={0,0,255}));
  connect(transformer.p2, resistor2.p) annotation (Line(points={{10,30},{10,30},{20,30},{20,40},{30,40}}, color={0,0,255}));
  connect(transformer.n2, el_ground2.p) annotation (Line(points={{10,10},{10,12},{20,12},{20,0},{40,0}}, color={0,0,255}));
  annotation (experiment(StartTime=0, StopTime=0.1, Interval=2e-5, Tolerance=1e-004), Documentation(info="<html>
<p>
A simple model of an single-phase transformer (similar to <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis.SinglePhaseTransformerWithHysteresis1\">SinglePhaseTransformerWithHysteresis1</a> but with separate transformer model: <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis.Components.Transformer1PhaseWithHysteresis\">Transformer1PhaseWithHysteresis</a>). Use the simulation settings:
</p>
<ul>
  <li>Stop time: 0.1 s</li>
  <li>Number of intervals: 5000.</li>
</ul>
<p>
The figure shows the magnetic hysteresis in the transformer core. In (a) the consideration of the eddy currents is switched off, in (b) it is enabled.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/SinglePhaseTransformerWithHysteresis2/plot1.png\" hspace=\"10\" vspace=\"10\">
    </td>
  </tr>
</table>

</html>"));
end SinglePhaseTransformerWithHysteresis2;
