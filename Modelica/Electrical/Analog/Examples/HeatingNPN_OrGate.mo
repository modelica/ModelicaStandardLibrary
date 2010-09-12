within Modelica.Electrical.Analog.Examples;
model HeatingNPN_OrGate "Heating NPN Or Gate"
  extends Modelica.Icons.Example;
  constant Modelica.SIunits.Capacitance CapVal=0;
  constant Modelica.SIunits.Time tauVal=0;

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor HeatCapacitor1(C=0.1)
  annotation (Placement(transformation(
        origin={76,-84},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor TC1(G=0.01)
  annotation (Placement(transformation(
        origin={90,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor TC2(G=0.01)
  annotation (Placement(transformation(
        origin={60,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  Modelica.Electrical.Analog.Sources.RampVoltage V(V=6, duration=5)
  annotation (Placement(transformation(
        origin={90,38},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.TrapezoidVoltage V1(
    V=6,
    startTime=55,
    rising=5,
    width=15,
    falling=5,
    period=50,
    nperiod=10)
              annotation (Placement(transformation(
        origin={-90,18},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.TrapezoidVoltage V2(
    V=6,
    startTime=65,
    rising=5,
    width=15,
    falling=5,
    period=50,
    nperiod=10)
              annotation (Placement(transformation(
        origin={-50,-42},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor R1(R=1800)
  annotation (Placement(transformation(extent={{-90,48},{-70,68}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R2(R=1800)
  annotation (Placement(transformation(extent={{-36,-22},{-16,-2}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor RI(R=40)
  annotation (Placement(transformation(extent={{60,58},{80,78}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground Gnd
  annotation (Placement(transformation(extent={{80,0},{100,20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground Gnd1
  annotation (Placement(transformation(extent={{-100,-22},{-80,-2}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground Gnd2
  annotation (Placement(transformation(extent={{-60,-82},{-40,-62}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground Gnd3
  annotation (Placement(transformation(extent={{-10,16},{10,36}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground Gnd4
  annotation (Placement(transformation(extent={{30,-52},{50,-32}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Capacitor C1(C=CapVal)
  annotation (Placement(transformation(
        origin={-70,38},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor C2(C=CapVal)
  annotation (Placement(transformation(
        origin={60,42},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor C3(C=CapVal)
  annotation (Placement(transformation(
        origin={-16,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground Gnd5
  annotation (Placement(transformation(extent={{-26,-76},{-6,-56}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground Gnd6
  annotation (Placement(transformation(extent={{50,6},{70,26}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground Gnd7
  annotation (Placement(transformation(extent={{-80,2},{-60,22}}, rotation=0)));
  Semiconductors.HeatingNPN T1(
    Bf=100,
    Br=1,
    Is=1.e-14,
    Vak=0,
    Tauf=tauVal,
    Taur=tauVal,
    Ccs=CapVal,
    Cje=CapVal,
    Cjc=CapVal,
    Phie=1,
    Me=0.5,
    Phic=1,
    Mc=0.5,
    Gbc=1.e-12,
    Gbe=1.e-12,
    EMax=40,
    vt_t(start=0.01, fixed=false),
    useHeatPort=true)
           annotation (Placement(transformation(extent={{-20,48},{0,68}},
          rotation=0)));
  Semiconductors.HeatingNPN T2(
    Bf=100,
    Br=1,
    Is=1.e-14,
    Vak=0,
    Tauf=tauVal,
    Taur=tauVal,
    Ccs=CapVal,
    Cje=CapVal,
    Cjc=CapVal,
    Phie=1,
    Me=0.5,
    Phic=1,
    Mc=0.5,
    Gbc=1.e-12,
    Gbe=1.e-12,
    EMax=40,
    vt_t(start=0.01, fixed=false),
    useHeatPort=true)
           annotation (Placement(transformation(extent={{20,-22},{40,-2}},
          rotation=0)));
equation
  connect(Gnd1.p, V1.n)
                      annotation (Line(points={{-90,-2},{-90,8}}, color={0,0,255}));
  connect(V1.p, R1.p)
                    annotation (Line(points={{-90,28},{-90,58}}, color={0,0,255}));
  connect(RI.n, V.p)
                   annotation (Line(points={{80,68},{90,68},{90,48}}, color={0,0,
          255}));
  connect(Gnd.p, V.n)
                    annotation (Line(points={{90,20},{90,28}}, color={0,0,255}));
  connect(V2.p, R2.p)
  annotation (Line(points={{-50,-32},{-50,-12},{-36,-12}}, color={0,0,255}));
  connect(Gnd2.p, V2.n)
                      annotation (Line(points={{-50,-62},{-50,-52}}, color={0,0,
          255}));
  connect(Gnd7.p, C1.n)
                      annotation (Line(points={{-70,22},{-70,28}}, color={0,0,255}));
  connect(C2.p, RI.p)
                    annotation (Line(points={{60,52},{60,68}}, color={0,0,255}));
  connect(Gnd6.p, C2.n)
                      annotation (Line(points={{60,26},{60,32}}, color={0,0,255}));
  connect(C3.p, R2.n)
  annotation (Line(points={{-16,-30},{-16,-21},{-16,-12}}, color={0,0,255}));
  connect(C1.p, R1.n)
                    annotation (Line(points={{-70,48},{-70,58}}, color={0,0,255}));
  connect(Gnd5.p, C3.n)
  annotation (Line(points={{-16,-56},{-16,-50},{-16,-50}}, color={0,0,255}));
  connect(T1.B, R1.n)
  annotation (Line(points={{-20,58},{-70,58}}, color={0,0,255}));
  connect(T1.E, Gnd3.p)
  annotation (Line(points={{0,53},{0,48.75},{1.05471e-015,48.75},{1.05471e-015,44.5},
          {0,44.5},{0,36}},                color={0,0,255}));
  connect(RI.p, T1.C)
                    annotation (Line(points={{60,68},{30,68},{30,63},{0,63}},
        color={0,0,255}));
  connect(T2.B, R2.n)
  annotation (Line(points={{20,-12},{-16,-12}}, color={0,0,255}));
  connect(T2.E, Gnd4.p)
  annotation (Line(points={{40,-17},{40,-32}}, color={0,0,255}));
  connect(T2.C, RI.p)
  annotation (Line(points={{40,-7},{40,68},{60,68}}, color={0,0,255}));
  connect(TC1.port_b, HeatCapacitor1.port)
                                         annotation (Line(points={{90,-60},{84,
          -60},{84,-74},{76,-74}}, color={191,0,0}));
  connect(TC2.port_b, HeatCapacitor1.port)
                                         annotation (Line(points={{60,-60},{68,
          -60},{68,-74},{76,-74}}, color={191,0,0}));
  connect(TC2.port_a, T2.heatPort)
  annotation (Line(points={{60,-40},{60,-22},{30,-22}}, color={191,0,0}));
  connect(TC1.port_a, T1.heatPort)
                                 annotation (Line(points={{90,-40},{90,2},{-10,
          2},{-10,48}}, color={191,0,0}));
annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-100,100},{-6,72}},
          textString="Heating \"NPN or\" Gate",
          lineColor={0,0,255})}),    Documentation(info="<html>
<p>The heating &QUOT;NPN or&QUOT; gate shows a heat flow always if a transistor is leading.</p>
<p>Simulate until T=200 s.</p>
<p>Plot in separate windows:</p><p>V1.v and V2.v and C2.v</p><p>HeatCapacitor1.port.T and T1.heatPort.T and T2.heatPort.T</p><p>T1.heatPort.Q_flow and T2.heatPort.Q_flow</p>
</html>",
   revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>Mai 6, 2004   </i>
       by Christoph Clauss<br> realized<br>
       </li>
</ul>
</html>"),  Documentation(info="<HTML>
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
T1.heatPort.Q_flow and T2.heatPort.Q_flow<br>
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
end HeatingNPN_OrGate;
