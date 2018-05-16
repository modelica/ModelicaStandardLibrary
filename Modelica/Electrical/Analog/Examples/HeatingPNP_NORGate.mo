within Modelica.Electrical.Analog.Examples;
model HeatingPNP_NORGate "Heating PNP NOR Gate"
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Capacitance CapVal=0 annotation (Evaluate=true);
  parameter Modelica.SIunits.Time tauVal=0 annotation (Evaluate=true);

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
        rotation=90)));
  Modelica.Electrical.Analog.Sources.TrapezoidVoltage V1(
    startTime=55,
    rising=5,
    width=15,
    falling=5,
    period=50,
    nperiod=10,
    V=-6)     annotation (Placement(transformation(
        origin={-90,18},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.TrapezoidVoltage V2(
    startTime=65,
    rising=5,
    width=15,
    falling=5,
    period=50,
    nperiod=10,
    V=-6)     annotation (Placement(transformation(
        origin={-50,-42},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor R1(R=1800)
  annotation (Placement(transformation(extent={{-90,48},{-70,68}})));
  Modelica.Electrical.Analog.Basic.Resistor R2(R=1800)
  annotation (Placement(transformation(extent={{-36,-22},{-16,-2}})));
  Modelica.Electrical.Analog.Basic.Resistor RI(R=40)
  annotation (Placement(transformation(extent={{60,58},{80,78}})));
  Modelica.Electrical.Analog.Basic.Ground Gnd
  annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Modelica.Electrical.Analog.Basic.Ground Gnd2
  annotation (Placement(transformation(extent={{-60,-82},{-40,-62}})));
  Modelica.Electrical.Analog.Basic.Ground Gnd3
  annotation (Placement(transformation(extent={{-10,16},{10,36}})));
  Modelica.Electrical.Analog.Basic.Ground Gnd4
  annotation (Placement(transformation(extent={{30,-52},{50,-32}})));
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
  annotation (Placement(transformation(extent={{-26,-76},{-6,-56}})));
  Modelica.Electrical.Analog.Basic.Ground Gnd6
  annotation (Placement(transformation(extent={{50,6},{70,26}})));
  Modelica.Electrical.Analog.Basic.Ground Gnd7
  annotation (Placement(transformation(extent={{-80,2},{-60,22}})));
  Modelica.Electrical.Analog.Semiconductors.HeatingPNP T1(
    Bf=100,
    Br=1,
    Is=1e-14,
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
    Gbc=1e-12,
    Gbe=1e-12,
    EMax=40,
    vt_t(start=0.01, fixed=false),
    useHeatPort=true)
    annotation (Placement(transformation(extent={{-20,48},{0,68}})));
  Modelica.Electrical.Analog.Semiconductors.HeatingPNP T2(
    Bf=100,
    Br=1,
    Is=1e-14,
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
    Gbc=1e-12,
    Gbe=1e-12,
    EMax=40,
    vt_t(start=0.01, fixed=false),
    useHeatPort=true)
    annotation (Placement(transformation(extent={{20,-22},{40,-2}})));
  Modelica.Electrical.Analog.Basic.Ground Gnd1
  annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
initial equation
  HeatCapacitor1.T= 293.15;

equation
  connect(Gnd7.p, C1.n)
                      annotation (Line(points={{-70,22},{-70,28}}, color={0,0,255}));
  connect(C3.p, R2.n)
  annotation (Line(points={{-16,-30},{-16,-21},{-16,-12}}, color={0,0,255}));
  connect(C1.p, R1.n)
                    annotation (Line(points={{-70,48},{-70,58}}, color={0,0,255}));
  connect(Gnd5.p, C3.n)
  annotation (Line(points={{-16,-56},{-16,-50}}, color={0,0,255}));
  connect(T1.B, R1.n)
  annotation (Line(points={{-20,58},{-70,58}}, color={0,0,255}));
  connect(T1.E, Gnd3.p)
  annotation (Line(points={{0,52},{0,52},{0,44.5},{0,36}},    color={0,0,255}));
  connect(RI.p, T1.C)
                    annotation (Line(points={{60,68},{30,68},{30,64},{0,64}}, color={0,0,255}));
  connect(T2.B, R2.n)
  annotation (Line(points={{20,-12},{-16,-12}}, color={0,0,255}));
  connect(T2.E, Gnd4.p)
  annotation (Line(points={{40,-18},{40,-32}}, color={0,0,255}));
  connect(T2.C, RI.p)
  annotation (Line(points={{40,-6},{40,68},{60,68}}, color={0,0,255}));
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
  connect(V.n, RI.n)
    annotation (Line(points={{90,48},{90,68},{80,68}}, color={0,0,255}));
  connect(Gnd.p, V.p)
    annotation (Line(points={{90,20},{90,28}}, color={0,0,255}));
  connect(V1.p, R1.p)
    annotation (Line(points={{-90,28},{-90,58}}, color={0,0,255}));
  connect(V1.n, Gnd1.p)
    annotation (Line(points={{-90,8},{-90,0},{-90,0}}, color={0,0,255}));
  connect(V2.p, R2.p)
    annotation (Line(points={{-50,-32},{-50,-12},{-36,-12}}, color={0,0,255}));
  connect(V2.n, Gnd2.p)
    annotation (Line(points={{-50,-52},{-50,-62}}, color={0,0,255}));
  connect(C2.p, RI.p)
    annotation (Line(points={{60,52},{60,68}}, color={0,0,255}));
  connect(C2.n, Gnd6.p)
    annotation (Line(points={{60,32},{60,26}}, color={0,0,255}));
annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-98,100},{-4,72}},
          lineColor={0,0,255},
          textString="Heating \"PNP NOR\" Gate")}),
                                  Documentation(info="<html>
<p>The heating &quot;PNP NOR&quot; gate shows a heat flow always if a transistor is conducting.</p>
<p>Simulate until T=200 s. Plot V1.v and V2.v and C2.v to see the NOR-functionality. High potential is -6V which means logic &quot;true&quot;. Low potential is 0V which means logic &quot;false&quot;.</p>
<p>To see which transistor is conducting one can have a look at the temperatures T1.heatPort.T and T2.heatPort.T and the heat flows T1.heatPort.Q_flow and T2.heatPort.Q_flow of the heatports of the transistors T1 and T2.</p>
<p>They are different from zero if the transistor is conducting.</p>
</html>",
   revisions="<html>
<h4>Release Notes:</h4>
<ul>
<li><em>May 02, 2018</em> by Kristin Majetta and Christoph Clauss<br>realized<br></li>
</ul>
</html>"), experiment(StopTime=200));
end HeatingPNP_NORGate;
