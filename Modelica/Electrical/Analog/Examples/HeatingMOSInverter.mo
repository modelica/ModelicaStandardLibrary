model HeatingMOSInverter "Heating MOS Inverter" 
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Ground G 
  annotation (extent=[-80, -40; -60, -20]);
  Modelica.Electrical.Analog.Sources.SineVoltage Sin(V=5) 
  annotation (extent=[-80, -10; -60, 10], rotation=270);
  
annotation (Diagram(Text(extent=[-100, 100; -6, 72], string=
          "Heating MOS Inverter")));
  Modelica.Electrical.Analog.Basic.Capacitor Capacitor1(C=0.00001) 
  annotation (extent=[20, 0; 40, 20], rotation=270);
  Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor1(C=0.01) 
  annotation (extent=[60, -70; 80, -50], rotation=270);
  Modelica.Thermal.HeatTransfer.ThermalConductor TC1(G=0.01) 
  annotation (extent=[0, -50; 20, -30], rotation=0);
  Semiconductors.HeatingPMOS H_PMOS 
  annotation (extent=[-40, 40; -20, 60]);
  Semiconductors.HeatingNMOS H_NMOS 
  annotation (extent=[-40, 0; -20, 20]);
  Modelica.Electrical.Analog.Sources.RampVoltage V(V=5, duration=1.e-2) 
  annotation (extent=[40, 40; 60, 60], rotation=270);
  Modelica.Thermal.HeatTransfer.ThermalConductor TC2(G=0.01) 
  annotation (extent=[0, -90; 20, -70], rotation=0);
  Modelica.Thermal.HeatTransfer.FixedTemperature FixedTemperature1(T=
        300) 
           annotation(extent=[78,-38; 98,-18], rotation=180);
  Modelica.Thermal.HeatTransfer.ThermalConductor TC3(G=0.01) 
  annotation (extent=[46,-40; 66,-20],  rotation=0);
equation 
  connect(Sin.n, G.p) 
  annotation (points=[-70, -10; -70, -20], style(color=3));
  connect(Capacitor1.n, G.p) 
  annotation (points=[30,0; 30,-20; -70,-20],    style(color=3));
  
annotation (Documentation(info="<HTML>
<P>
The heating MOS inverter shows a heat flow always if a transistor is leading.
</P>
<P>
Simulate until T=5 s.
</P>
<P>
Plot in separate windows:<br> <br>
Sin.p.v  and  Capacitor1.p.v <br>
HeatCapacitor1.port.T and H_PMOS.heatPort.T and H_NMOS.heatPort.T<br>
H_PMOS.heatPort.Q_dot and H_NMOS.heatPort.Q_dot<br>
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
  connect(H_NMOS.G, H_PMOS.G) 
  annotation (points=[-40, 5; -40, 45], style(color=3));
  connect(H_NMOS.G, Sin.p) 
  annotation (points=[-40, 5; -40, 10; -70, 10], style(color=3));
  connect(H_PMOS.S, H_NMOS.D) 
  annotation (points=[-20, 45; -20, 15], style(color=3));
  connect(H_NMOS.D, Capacitor1.p) 
  annotation (points=[-20,15; -20,20; 30,20],    style(color=3));
  connect(H_NMOS.B, H_NMOS.S) 
  annotation (points=[-20, 10; -20, 5], style(color=3));
  connect(H_NMOS.S, G.p) 
  annotation (points=[-20, 5; -20, -20; -70, -20], style(color=3));
  connect(H_PMOS.B, H_PMOS.D) 
  annotation (points=[-20, 50; -20, 55], style(color=3));
  connect(V.p, H_PMOS.D) 
  annotation (points=[50, 60; -20, 60; -20, 55], style(color=3));
  connect(V.n, G.p) 
  annotation (points=[50, 40; 50, -20; -70, -20], style(color=3));
  connect(TC1.port_b, HeatCapacitor1.port) 
                                         annotation (points=[21, -40;
       40, -40; 40, -60; 60, -60], style(color=42));
  connect(TC2.port_b, HeatCapacitor1.port) 
                                         annotation (points=[21, -80;
       40, -80; 40, -60; 60, -60], style(color=42));
  connect(TC1.port_a, H_PMOS.heatPort) 
                                     annotation (points=[-1, -40; -10,
       -40; -10, 40; -30, 40], style(color=42));
  connect(TC2.port_a, H_NMOS.heatPort) 
  annotation (points=[-1, -80; -30, -80; -30, 0], style(color=42));
  connect(TC3.port_b, FixedTemperature1.port) 
                                            annotation(points=[67,-30; 70,
      -30; 70,-28; 77,-28], style(color=42, rgbcolor={191,0,0}));
  connect(TC3.port_a, HeatCapacitor1.port) 
                                         annotation(points=[45,-30;
      52,-30; 52,-60; 60,-60], style(color=42, rgbcolor={191,0,0}));
end HeatingMOSInverter;
