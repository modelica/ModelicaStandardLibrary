model HeatingNPN_OrGate "Heating NPN Or Gate" 
  extends Modelica.Icons.Example;
  constant Real CapVal=0;
  
annotation (Diagram(Text(extent=[-100, 100; -6, 72], string=
          "Heating NPN Nand Gate")));
  Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor1(C=0.1) 
  annotation (extent=[66, -94; 86, -74], rotation=180);
  Modelica.Thermal.HeatTransfer.ThermalConductor TC1(G=0.01) 
  annotation (extent=[80, -60; 100, -40], rotation=270);
  Modelica.Thermal.HeatTransfer.ThermalConductor TC2(G=0.01) 
  annotation (extent=[50, -60; 70, -40], rotation=270);
  
annotation (Documentation(info="<HTML>
<P>
The heating NPN nand gate shows a heat flow always if a transistor is leading.
</P>
<P>
Simulate until T=200 s.
</P>
<P>
Plot in separate windows:<br> <br>
V1.v and V2.v and C2.v <br>
HeatCapacitor1.port.T and T1.heatPort.T and T2.heatPort.T<br>
T1.heatPort.Q_dot and T2.heatPort.Q_dot<br>
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
     StopTime=200));
  Modelica.Electrical.Analog.Sources.RampVoltage V(V=6, duration=5) 
  annotation (extent=[80, 28; 100, 48], rotation=270);
  Modelica.Electrical.Analog.Sources.TrapezoidVoltage V1(
    V=6,
    startTime=55,
    rising=5,
    width=15,
    falling=5,
    period=50,
    nperiod=10) 
              annotation (extent=[-100, 8; -80, 28], rotation=270);
  Modelica.Electrical.Analog.Sources.TrapezoidVoltage V2(
    V=6,
    startTime=65,
    rising=5,
    width=15,
    falling=5,
    period=50,
    nperiod=10) 
              annotation (extent=[-60, -52; -40, -32], rotation=270);
  Modelica.Electrical.Analog.Basic.Resistor R1(R=1800) 
  annotation (extent=[-90, 48; -70, 68]);
  Modelica.Electrical.Analog.Basic.Resistor R2(R=1800) 
  annotation (extent=[-36, -22; -16, -2]);
  Modelica.Electrical.Analog.Basic.Resistor RI(R=40) 
  annotation (extent=[60, 58; 80, 78]);
  Modelica.Electrical.Analog.Basic.Ground Gnd 
  annotation (extent=[80, 0; 100, 20]);
  Modelica.Electrical.Analog.Basic.Ground Gnd1 
  annotation (extent=[-100, -22; -80, -2]);
  Modelica.Electrical.Analog.Basic.Ground Gnd2 
  annotation (extent=[-60, -82; -40, -62]);
  Modelica.Electrical.Analog.Basic.Ground Gnd3 
  annotation (extent=[-10, 16; 10, 36]);
  Modelica.Electrical.Analog.Basic.Ground Gnd4 
  annotation (extent=[30, -52; 50, -32]);
  Modelica.Electrical.Analog.Basic.Capacitor C1(C=CapVal) 
  annotation (extent=[-80, 28; -60, 48], rotation=270);
  Modelica.Electrical.Analog.Basic.Capacitor C2(C=CapVal) 
  annotation (extent=[50, 32; 70, 52], rotation=270);
  Modelica.Electrical.Analog.Basic.Capacitor C3(C=CapVal) 
  annotation (extent=[-26, -50; -6, -30], rotation=270);
  Modelica.Electrical.Analog.Basic.Ground Gnd5 
  annotation (extent=[-26, -76; -6, -56]);
  Modelica.Electrical.Analog.Basic.Ground Gnd6 
  annotation (extent=[50, 6; 70, 26]);
  Modelica.Electrical.Analog.Basic.Ground Gnd7 
  annotation (extent=[-80, 2; -60, 22]);
  Semiconductors.HeatingNPN T1(
    Bf=100,
    Br=1,
    Is=1.e-14,
    Vak=0,
    Tauf=0,
    Taur=0,
    Ccs=CapVal,
    Cje=CapVal,
    Cjc=CapVal,
    Phie=1,
    Me=0.5,
    Phic=1,
    Mc=0.5,
    Gbc=1.e-12,
    Gbe=1.e-12,
    EMax=40) 
           annotation (extent=[-20, 48; 0, 68]);
  Semiconductors.HeatingNPN T2(
    Bf=100,
    Br=1,
    Is=1.e-14,
    Vak=0,
    Tauf=0,
    Taur=0,
    Ccs=CapVal,
    Cje=CapVal,
    Cjc=CapVal,
    Phie=1,
    Me=0.5,
    Phic=1,
    Mc=0.5,
    Gbc=1.e-12,
    Gbe=1.e-12,
    EMax=40) 
           annotation (extent=[20, -22; 40, -2]);
equation 
  connect(Gnd1.p, V1.n) 
                      annotation (points=[-90, -2; -90, 8]);
  connect(V1.p, R1.p) 
                    annotation (points=[-90, 28; -90, 58]);
  connect(RI.n, V.p) 
                   annotation (points=[80, 68; 90, 68; 90, 48]);
  connect(Gnd.p, V.n) 
                    annotation (points=[90, 20; 90, 28]);
  connect(V2.p, R2.p) 
  annotation (points=[-50, -32; -50, -12; -36, -12]);
  connect(Gnd2.p, V2.n) 
                      annotation (points=[-50, -62; -50, -52]);
  connect(Gnd7.p, C1.n) 
                      annotation (points=[-70, 22; -70, 28]);
  connect(C2.p, RI.p) 
                    annotation (points=[60, 52; 60, 68]);
  connect(Gnd6.p, C2.n) 
                      annotation (points=[60, 26; 60, 32]);
  connect(C3.p, R2.n) 
  annotation (points=[-16,-30; -16,-21; -16,-21; -16,-12]);
  connect(C1.p, R1.n) 
                    annotation (points=[-70, 48; -70, 58]);
  connect(Gnd5.p, C3.n) 
  annotation (points=[-16,-56; -16,-53; -16,-50; -16,-50]);
  connect(T1.B, R1.n) 
  annotation (points=[-20, 58; -70, 58], style(color=3));
  connect(T1.E, Gnd3.p) 
  annotation (points=[0, 53; 0, 36], style(color=3));
  connect(RI.p, T1.C) 
                    annotation (points=[60, 68; 30, 68; 30, 63; 0, 63],
     style(color=3));
  connect(T2.B, R2.n) 
  annotation (points=[20, -12; -16, -12], style(color=3));
  connect(T2.E, Gnd4.p) 
  annotation (points=[40, -17; 40, -32], style(color=3));
  connect(T2.C, RI.p) 
  annotation (points=[40, -7; 40, 68; 60, 68], style(color=3));
  connect(TC1.port_b, HeatCapacitor1.port) 
                                         annotation (points=[90, -61;
       84, -61; 84, -74; 76, -74], style(color=42));
  connect(TC2.port_b, HeatCapacitor1.port) 
                                         annotation (points=[60, -61;
       68, -61; 68, -74; 76, -74], style(color=42));
  connect(TC2.port_a, T2.heatPort) 
  annotation (points=[60, -39; 60, -22; 30, -22], style(color=42));
  connect(TC1.port_a, T1.heatPort) 
                                 annotation (points=[90, -39; 90, 2;
      -10, 2; -10, 48], style(color=42));
end HeatingNPN_OrGate;
