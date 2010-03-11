within Modelica.Electrical.Analog.Examples;
model HeatingResistor "Heating resistor"
  extends Modelica.Icons.Example;
  Basic.HeatingResistor heatingResistor(
    R_ref=100,
    alpha=1e-3,
    T_ref=293.15)
                annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=-90,
        origin={-32,34})));
  Modelica.Electrical.Analog.Basic.Ground G
  annotation (Placement(transformation(extent={{-80,0},{-60,20}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(V=220, freqHz=1)
  annotation (Placement(transformation(
        origin={-70,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=
        50)
  annotation (Placement(transformation(
        origin={4,34},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Thermal.HeatTransfer.Celsius.FixedTemperature fixedTemperature(T=20)
    annotation (Placement(transformation(extent={{52,24},{32,44}})));
equation
  connect(SineVoltage1.n, G.p)
  annotation (Line(points={{-70,30},{-70,20}}, color={0,0,255}));
  connect(heatingResistor.heatPort, thermalConductor.port_a)
                                                          annotation (Line(
        points={{-22,34},{-6,34}},                    color={191,0,0}));

  connect(SineVoltage1.p, heatingResistor.p) annotation (Line(
      points={{-70,50},{-32,50},{-32,44}},
      color={0,0,255},
      smooth=Smooth.None));

  connect(G.p, heatingResistor.n) annotation (Line(
      points={{-70,20},{-32,20},{-32,24}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(thermalConductor.port_b, fixedTemperature.port) annotation (Line(
      points={{14,34},{32,34}},
      color={191,0,0},
      smooth=Smooth.None));
annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-94,102},{0,74}},
          textString="HeatingRectifier",
          lineColor={0,0,255})}),
                                Documentation(info="<html>
<p>This is a very simple circuit consisting of a voltage source and a resistor. The loss power in the resistor is transported to the environment via its heatPort.</p>
</html>"),  Documentation(info="<HTML>
<P>
The heating rectifier shows a heat flow always if the electrical capacitor is loaded.
</P>
<P>
Simulate until T=5 s.
</P>
<P>
Plot in separate windows:<br> <br>
SineVoltage1.v  and  Capacitor1.p.v <br>
HeatCapacitor1.port.T and HeatingDiode1.heatPort.T<br>
HeatingDiode1.heatPort.Q_flow<br>
</P>
<p><b>Release Notes:</b></p>
<ul>
<li><i>Mai 6, 2004   </i>
       by Christoph Clauss<br> realized<br>
       </li>
</ul>
</HTML>
"),
  experiment(
     StopTime=5));
end HeatingResistor;
