package FluidHeatFlow 
  "Simple components for 1-dimensional incompressible thermo-fluid flow to model coolant flows" 
  extends Modelica.Icons.Library;
  annotation (
    version="1.1", versionDate="2005-02-15",
    preferedView="info",Documentation(info="<HTML>
<p>
This package contains very simple-to-use components to model coolant flows as needed to simulate cooling e.g. of electric machines:
<ul>
<li>Components: components like different types of pipe models</li>
<li>Examples: some test examples</li>
<li>Interfaces: definition of connectors and partial models 
(containing the core thermodynamic equations)</li>
<li>Media: definition of media properties</li>
<li>Sensors: various sensors for pressure, temperature, mass and volume flow, enthalpy flow</li>
<li>Sources: various flow sources</li>
</ul>
</p>
<p>
<b>Variables used in connectors:</b>
<ul>
<li>Pressure p</li>
<li>flow MassFlowRate m_flow</li>
<li>SpecificEnthalpy h</li>
<li>flow EnthalpyFlowRate H_flow</li>
</ul>
EnthalpyFlowRate means the Enthalpy = cp<sub>constant</sub> * m * T that is carried by the medium's flow.
</p>
<p>
<b>Limitations and assumptions:</b>
<ul>
<li>Splitting and mixing of coolant flows (media with the same cp) is possible.</li>
<li>Reversing the direction of flow is possible.</li>
<li>The medium is considered to be incompressible.</li>
<li>No mixtures of media is taken into consideration.</li>
<li>The medium may not change its phase.</li>
<li>Medium properties are kept constant.</li>
<li>Pressure changes are only due to pressure drop.</li>
<li><b>Note:</b> Connected flowPorts have the same temperature (mixing temperature)!<br>
Since mixing my occur, the outlet temperature may be different from the connector's temperature.<br> 
Outlet temperature is defined by variable T of the corresponding component.</li>
</ul>
</p>
<p>
<b>Further development:</b>
<ul>
<li>More advanced pumps resp. fans with mechanical flange</li>
<li>Additional components like tanks and valves (if needed)</li>
</ul>
</p>
<p>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <p>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </p>
  <p>
  Dr.Christian Kral & Markus Plainer<br>
  <a href=\"http://www.arsenal.ac.at/english/\">arsenal research</a><br>
  Business Unit Monitoring, Energy and Drive Technologies<br>
  A-1030 Vienna, Austria
  </p>
  </dd>
</dl>
</p>
</dl>
<p>
Copyright &copy; 1998-2005, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.0 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.1 2005/02/15 Anton Haumer<br>
       reorganisation of the package</li>
  </ul>
</HTML>
"));
  
  package Examples 
    extends Modelica.Icons.Library;
  annotation (Documentation(info="<HTML>
<p>
This package contains test examples:
<ul>
<li>SimpleCooling: heat is dissipated through a media flow</li>
<li>ParallelCooling: two heat sources dissipate through merged media flows</li>
<li>IndirectCooling: heat is disspated through two cooling cycles</li>
</ul>
</p>
<p>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <p>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </p>
  <p>
  Dr.Christian Kral & Markus Plainer<br>
  <a href=\"http://www.arsenal.ac.at/english/\">arsenal research</a><br>
  Business Unit Monitoring, Energy and Drive Technologies<br>
  A-1030 Vienna, Austria
  </p>
  </dd>
</dl>
</p>
</dl>
<p>
Copyright &copy; 1998-2005, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.0 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  </ul>
</HTML>
"));
    
    model SimpleCooling 
      extends Modelica.Icons.Example;
    annotation (Documentation(info="<HTML>
<p>
1st test example: SimpleCooling
</p>
<p>
A prescribed heat source dissipates its heat through a thermal conductor to a coolant flow. The coolant flow is taken from an ambient and driven by a pump with prescribed mass flow.<br>
<b>Results</b>:<br>
<table>
<tr>
<td><b>output</b></td>
<td><b>explanation</b></td>
<td><b>formula</b></td>
<td><b>actual steady-state value</b></td>
</tr>
<tr>
<td>dTSource</td>
<td>Source over Ambient</td>
<td>dtCoolant + dtToPipe</td>
<td>20 K</td>
</tr>
<tr>
<td>dTtoPipe</td>
<td>Source over average Coolant</td>
<td>Losses / ThermalConductor.G</td>
<td>10 K</td>
</tr>
<tr>
<td>dTCoolant</td>
<td>Coolant's temperature increase</td>
<td>Losses * cp * massFlow</td>
<td>10 K</td>
</tr>
</table>
</p>
</HTML>"), Diagram,
        experiment(StopTime=1.0),
        experimentSetupOutput);
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.CelsiusTemperature TAmb=20 
        "ambient temperature";
      output Modelica.SIunits.Temperature dTSource=
        PrescribedHeatFlow1.port.T-Modelica.SIunits.Conversions.from_degC(TAmb) 
        "Source over Ambient";
      output Modelica.SIunits.Temperature dTtoPipe=
        PrescribedHeatFlow1.port.T-Pipe1.heatPort.T 
        "Source over average Coolant";
      output Modelica.SIunits.Temperature dTCoolant=
        if Pipe1.V_flow>0 then Pipe1.T-Pipe1.T_a else Pipe1.T_b-Pipe1.T 
        "Coolant's temperature increase";
      Sources.Ambient Ambient1(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[-60,-10; -80,10]);
      Sources.PrescribedVolumeFlow Fan1(medium=medium, m=0) 
        annotation (extent=[-40,-10; -20,10]);
      Components.HeatedPipe Pipe1(
        medium=medium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[0,-10; 20,10]);
      Sources.Ambient Ambient2(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[40,-10; 60,10]);
      Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor1(
        T(start=Modelica.SIunits.Conversions.from_degC(TAmb)), C=0.1) 
        annotation (extent=[50,-60; 30,-40],  rotation=90);
      Modelica.Thermal.HeatTransfer.PrescribedHeatFlow PrescribedHeatFlow1 
        annotation (extent=[-30,-40; -10,-60],
                                            rotation=0);
      Modelica.Blocks.Sources.Constant VolumeFlow(k=1) 
        annotation (extent=[-60,10; -40,30]);
      Modelica.Blocks.Sources.Constant HeatFlow(k=10) 
        annotation (extent=[-60,-60; -40,-40]);
      Modelica.Thermal.HeatTransfer.Convection Convection1 
        annotation (extent=[0,-40; 20,-20], rotation=90);
      Modelica.Blocks.Sources.Constant G(k=1) 
        annotation (extent=[-30,-40; -10,-20]);
    equation 
      connect(Ambient1.flowPort, Fan1.flowPort_a) 
        annotation (points=[-60,0; -40,0],   style(color=1, rgbcolor={255,0,0}));
      connect(Fan1.flowPort_b, Pipe1.flowPort_a) 
        annotation (points=[-20,0; 0,0],   style(color=1, rgbcolor={255,0,0}));
      connect(Pipe1.flowPort_b, Ambient2.flowPort) 
        annotation (points=[20,0; 40,0],   style(color=1, rgbcolor={255,0,0}));
      connect(HeatFlow.y, PrescribedHeatFlow1.Q_flow) annotation (points=[-39,
            -50; -30,-50],   style(color=3, rgbcolor={0,0,255}));
      connect(VolumeFlow.y, Fan1.VolumeFlow) annotation (points=[-39,20; -30,20;
            -30,10], style(color=74, rgbcolor={0,0,127}));
      connect(Convection1.solid, PrescribedHeatFlow1.port) annotation (points=[
            10,-41; 10,-50; -10,-50], style(color=42, rgbcolor={191,0,0}));
      connect(Convection1.solid, HeatCapacitor1.port) annotation (points=[10,
            -41; 10,-50; 30,-50], style(color=42, rgbcolor={191,0,0}));
      connect(Pipe1.heatPort, Convection1.fluid) annotation (points=[10,-10; 10,
            -19], style(color=42, rgbcolor={191,0,0}));
      connect(G.y, Convection1.Gc) annotation (points=[-9,-30; 0,-30], style(
            color=74, rgbcolor={0,0,127}));
    end SimpleCooling;
    
    model ParallelCooling 
      extends Modelica.Icons.Example;
    annotation (Documentation(info="<HTML>
<p>
2nd test example: ParallelCooling
</p>
<p>
Two prescribed heat sources dissipate their heat through thermal conductors to coolant flows. The coolant flow is taken from an ambient and driven by a pump with prescribed mass flow, then splitted into two coolant flows connected to the two heat sources, and afterwards merged. Splitting of coolant flows is determined by pressure drop characteristic of the two pipes.<br>
<b>Results</b>:<br>
<table>
<tr>
<td><b>output</b></td>
<td><b>explanation</b></td>
<td><b>formula</b></td>
<td><b>actual steady-state value</b></td>
</tr>
<tr>
<td>dTSource1</td>
<td>Source1 over Ambient</td>
<td>dTCoolant1 + dTtoPipe1</td>
<td>15 K</td>
</tr>
<tr>
<td>dTtoPipe1</td>
<td>Source1 over average Coolant1</td>
<td>Losses1 / ThermalConductor1.G</td>
<td> 5 K</td>
</tr>
<tr>
<td>dTCoolant1</td>
<td>Coolant's temperature increase</td>
<td>Losses * cp * totalMassFlow/2</td>
<td>10 K</td>
</tr>
<tr>
<td>dTSource2</td>
<td>Source2 over Ambient</td>
<td>dTCoolant2 + dTtoPipe2</td>
<td>30 K</td>
</tr>
<tr>
<td>dTtoPipe2</td>
<td>Source1 over average Coolant1</td>
<td>Losses1 / ThermalConductor1.G</td>
<td>10 K</td>
</tr>
<tr>
<td>dTCoolant2</td>
<td>Coolant's temperature increase</td>
<td>Losses * cp * totalMassFlow/2</td>
<td>20 K</td>
</tr>
<tr>
<td>dTmixedCoolant</td>
<td>mixed Coolant's temperature increase</td>
<td>(dTCoolant1+dTCoolant2)/2</td>
<td>15 K</td>
</tr>
</table>
</p>
</HTML>"), Diagram,
        experiment(StopTime=1.0),
        experimentSetupOutput);
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.CelsiusTemperature TAmb=20 
        "ambient temperature";
      output Modelica.SIunits.Temperature dTSource1=
        PrescribedHeatFlow1.port.T-Modelica.SIunits.Conversions.from_degC(TAmb) 
        "Source1 over Ambient";
      output Modelica.SIunits.Temperature dTtoPipe1=
        PrescribedHeatFlow1.port.T-Pipe1.heatPort.T 
        "Source1 over average Coolant1";
      output Modelica.SIunits.Temperature dTCoolant1=
        if Pipe1.V_flow>0 then Pipe1.T-Pipe1.T_a else Pipe1.T_b-Pipe1.T 
        "Coolant1's temperature increase";
      output Modelica.SIunits.Temperature dTSource2=
        PrescribedHeatFlow2.port.T-Modelica.SIunits.Conversions.from_degC(TAmb) 
        "Source1 over Ambient";
      output Modelica.SIunits.Temperature dTtoPipe2=
        PrescribedHeatFlow2.port.T-Pipe2.heatPort.T 
        "Source2 over average Coolant2";
      output Modelica.SIunits.Temperature dTCoolant2=
        if Pipe2.V_flow>0 then Pipe2.T-Pipe2.T_a else Pipe2.T_b-Pipe2.T 
        "Coolant1's temperature increase";
      output Modelica.SIunits.Temperature dTmixedCoolant=
        if Ambient1.flowPort.m_flow<0 then Ambient2.T_port-Ambient1.T_port else 
                                           Ambient1.T_port-Ambient2.T_port 
        "mixed Coolant's temperature increase";
      Sources.Ambient Ambient1(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[-60,-10; -80,10]);
      Sources.PrescribedVolumeFlow Pump1(medium=medium, m=0) 
        annotation (extent=[-40,-10; -20,10]);
      Components.HeatedPipe Pipe1(
        medium=medium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[0,-20; 20,0]);
      Sources.Ambient Ambient2(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[40,-10; 60,10]);
      Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor1(
        T(start=Modelica.SIunits.Conversions.from_degC(TAmb)), C=0.1) 
        annotation (extent=[50,-70; 30,-50],  rotation=90);
      Modelica.Thermal.HeatTransfer.PrescribedHeatFlow PrescribedHeatFlow1 
        annotation (extent=[-10,-70; -30,-50], rotation=180);
      Components.HeatedPipe Pipe2(
        medium=medium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[0,20; 20,0]);
      Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor2(
        T(start=Modelica.SIunits.Conversions.from_degC(TAmb)), C=0.1) 
        annotation (extent=[48,70; 28,50],   rotation=90);
      Modelica.Thermal.HeatTransfer.PrescribedHeatFlow PrescribedHeatFlow2 
        annotation (extent=[-10,70; -30,50],rotation=180);
      Modelica.Blocks.Sources.Constant VolumeFlow(k=1) 
        annotation (extent=[-60,10; -40,30]);
      Modelica.Blocks.Sources.Constant HeatFlow1(k=5) 
        annotation (extent=[-60,-70; -40,-50]);
      Modelica.Blocks.Sources.Constant HeatFlow2(k=10) 
        annotation (extent=[-60,50; -40,70]);
      Modelica.Thermal.HeatTransfer.Convection Convection1 
        annotation (extent=[20,-30; 0,-50], rotation=-90);
      Modelica.Thermal.HeatTransfer.Convection Convection2 
        annotation (extent=[0,50; 20,30], rotation=90);
      Modelica.Blocks.Sources.Constant G1(k=1) 
        annotation (extent=[-30,-50; -10,-30]);
      Modelica.Blocks.Sources.Constant G2(k=1) 
        annotation (extent=[-30,30; -10,50]);
    equation 
      connect(Ambient1.flowPort, Pump1.flowPort_a) 
        annotation (points=[-60,0; -40,0], style(color=1, rgbcolor={255,0,0}));
      connect(Pump1.flowPort_b, Pipe1.flowPort_a) 
        annotation (points=[-20,0; -10,0; -10,-10; 0,-10],
        style(color=1, rgbcolor={255,0,0}));
      connect(Pipe1.flowPort_b, Ambient2.flowPort) 
        annotation (points=[20,-10; 30,-10; 30,0; 40,0],
        style(color=1, rgbcolor={255,0,0}));
      connect(Pump1.flowPort_b, Pipe2.flowPort_a) 
        annotation (points=[-20,0; -10,0; -10,10; 0,10], style(color=1, rgbcolor={255,0,0}));
      connect(Pipe2.flowPort_b, Ambient2.flowPort) 
        annotation (points=[20,10; 30,10; 30,0; 40,0], style(color=1, rgbcolor={255,0,0}));
      connect(HeatFlow2.y, PrescribedHeatFlow2.Q_flow) 
        annotation (points=[-39,60; -30,60], style(color=3, rgbcolor={0,0,255}));
      connect(HeatFlow1.y, PrescribedHeatFlow1.Q_flow) 
        annotation (points=[-39,-60; -30,-60], style(color=3, rgbcolor={0,0,255}));
      connect(VolumeFlow.y, Pump1.VolumeFlow) 
                                            annotation (points=[-39,20; -30,20;
            -30,10],
          style(color=74, rgbcolor={0,0,127}));
      connect(G2.y, Convection2.Gc) 
        annotation (points=[-9,40; 0,40], style(color=74, rgbcolor={0,0,127}));
      connect(G1.y, Convection1.Gc) annotation (points=[-9,-40; 0,-40], style(
            color=74, rgbcolor={0,0,127}));
      connect(Pipe1.heatPort, Convection1.fluid) annotation (points=[10,-20; 10,
            -29], style(color=42, rgbcolor={191,0,0}));
      connect(Convection2.fluid, Pipe2.heatPort) annotation (points=[10,29; 10,
            20], style(color=42, rgbcolor={191,0,0}));
      connect(Convection2.solid, PrescribedHeatFlow2.port) annotation (points=[
            10,51; 10,60; -10,60], style(color=42, rgbcolor={191,0,0}));
      connect(Convection2.solid, HeatCapacitor2.port) annotation (points=[10,51;
            10,60; 28,60], style(color=42, rgbcolor={191,0,0}));
      connect(Convection1.solid, PrescribedHeatFlow1.port) annotation (points=[
            10,-51; 10,-60; -10,-60], style(color=42, rgbcolor={191,0,0}));
      connect(Convection1.solid, HeatCapacitor1.port) annotation (points=[10,
            -51; 10,-60; 30,-60], style(color=42, rgbcolor={191,0,0}));
    end ParallelCooling;
    
    model IndirectCooling 
      extends Modelica.Icons.Example;
    annotation (Documentation(info="<HTML>
<p>
3rd test example: IndirectCooling
</p>
<p>
A prescribed heat sources dissipates its heat through a thermal conductor to the inner coolant cycle. It is necessary to define the pressure level of the inner coolant cycle. The inner coolant cycle is coupled to the outer coolant flow through a thermal conductor.<br>
Inner coolant's temperature rise near the source is the same as temperature drop near the cooler.<br>
<b>Results</b>:<br>
<table>
<tr>
<td><b>output</b></td>
<td><b>explanation</b></td>
<td><b>formula</b></td>
<td><b>actual steady-state value</b></td>
</tr>
<tr>
<td>dTSource</td>
<td>Source over Ambient</td>
<td>dtouterCoolant + dtCooler + dTinnerCoolant + dtToPipe</td>
<td>40 K</td>
</tr>
<tr>
<td>dTtoPipe</td>
<td>Source over average inner Coolant</td>
<td>Losses / ThermalConductor.G</td>
<td>10 K</td>
</tr>
<tr>
<td>dTinnerColant</td>
<td>inner Coolant's temperature increase</td>
<td>Losses * cp * innerMassFlow</td>
<td>10 K</td>
</tr>
<tr>
<td>dTCooler</td>
<td>Cooler's temperature rise between inner and outer pipes</td>
<td>Losses * (innerGc + outerGc)</td>
<td>10 K</td>
</tr>
<tr>
<td>dTouterColant</td>
<td>outer Coolant's temperature increase</td>
<td>Losses * cp * outerMassFlow</td>
<td>10 K</td>
</tr>
</table>
</p>
</HTML>"), Diagram,
        experiment(StopTime=1.5),
        experimentSetupOutput);
      parameter FluidHeatFlow.Media.Medium outerMedium=FluidHeatFlow.Media.Medium() 
        annotation(choicesAllMatching=true);
      parameter FluidHeatFlow.Media.Medium innerMedium=FluidHeatFlow.Media.Medium() 
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.CelsiusTemperature TAmb=20 
        "ambient temperature";
      output Modelica.SIunits.Temperature dTSource=
        PrescribedHeatFlow1.port.T-Modelica.SIunits.Conversions.from_degC(TAmb) 
        "Source over Ambient";
      output Modelica.SIunits.Temperature dTtoPipe=
        PrescribedHeatFlow1.port.T-Pipe1.heatPort.T 
        "Source over average inner Coolant";
      output Modelica.SIunits.Temperature dTinnerCoolant=
        if Pipe1.V_flow>0 then Pipe1.T-Pipe1.T_a else Pipe1.T_b-Pipe1.T 
        "inner Coolant's temperature increase";
      output Modelica.SIunits.Temperature dTCooler=
        innerPipe.heatPort.T-outerPipe.heatPort.T 
        "Cooler's temperature increase between inner and outer pipes";
      output Modelica.SIunits.Temperature dTouterCoolant=
        if Ambient1.flowPort.m_flow<0 then Ambient2.T_port-Ambient1.T_port else 
                                           Ambient1.T_port-Ambient2.T_port 
        "outer Coolant's temperature increase";
      Sources.Ambient Ambient1(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=outerMedium) annotation (extent=[-60,60; -80,80]);
      Sources.PrescribedVolumeFlow outerVolumeFlow1(medium=
            outerMedium, m=0) 
        annotation (extent=[-40,60; -20,80]);
      Sources.Ambient Ambient2(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=outerMedium) annotation (extent=[40,60; 60,80]);
      Modelica.Thermal.HeatTransfer.ThermalConductor ThermalConductor1(G=1) 
        annotation (extent=[0,-80; 20,-60], rotation=90);
      Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor1(
        T(start=Modelica.SIunits.Conversions.from_degC(TAmb)), C=0.05) 
        annotation (extent=[50,-100; 30,-80],  rotation=90);
      Modelica.Thermal.HeatTransfer.PrescribedHeatFlow PrescribedHeatFlow1 
        annotation (extent=[-10,-100; -30,-80],rotation=180);
      Components.HeatedPipe Pipe1(
        medium=innerMedium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb),
        V_flowLaminar=1,
        dpLaminar=1000,
        V_flowNominal=2,
        dpNominal=2000) 
        annotation (extent=[20,-50; 0,-30]);
      Sources.AbsolutePressure AbsolutePressure1(p=10000,
        medium=innerMedium) annotation (extent=[40,-40; 60,-20]);
      Sources.PrescribedVolumeFlow InnerVolumeFlow1(medium=
            innerMedium, m=0) 
        annotation (extent=[-30,-40; -10,-20],
                                             rotation=90);
      Modelica.Blocks.Sources.Constant HeatFlow(k=10) 
        annotation (extent=[-60,-100; -40,-80]);
      Modelica.Blocks.Sources.Constant outerVolumeFlow(k=1) 
        annotation (extent=[-60,80; -40,100]);
      Modelica.Blocks.Sources.Constant innerVolumeFlow(k=1) 
        annotation (extent=[-60,-40; -40,-20],
                                             rotation=0);
      Modelica.Blocks.Sources.Constant outerGc(k=2) 
        annotation (extent=[-40,30; -20,50]);
      Modelica.Blocks.Sources.Constant innerGc(k=2) 
        annotation (extent=[-40,20; -20,0]);
      Components.HeatedPipe outerPipe(
        medium=outerMedium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[0,60; 20,80]);
      Components.HeatedPipe innerPipe(
        medium=innerMedium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[0,-10; 20,-30]);
      Modelica.Thermal.HeatTransfer.Convection innerConvection 
        annotation (extent=[20,0; 0,20], rotation=-90);
      Modelica.Thermal.HeatTransfer.Convection outerConvection 
        annotation (extent=[20,50; 0,30], rotation=-90);
    equation 
      connect(Ambient1.flowPort,outerVolumeFlow1. flowPort_a) 
        annotation (points=[-60,70; -40,70], style(color=1, rgbcolor={255,0,0}));
      connect(PrescribedHeatFlow1.port, ThermalConductor1.port_a) 
        annotation (points=[-10,-90; 10,-90; 10,-81],
        style(color=42, rgbcolor={191,0,0}));
      connect(HeatCapacitor1.port, ThermalConductor1.port_a) 
        annotation (points=[30,-90; 10,-90; 10,-81], style(color=42, rgbcolor={191,0,0}));
      connect(Pipe1.heatPort, ThermalConductor1.port_b) 
        annotation (points=[10,-50; 10,-59], style(color=42, rgbcolor={191,0,0}));
      connect(Pipe1.flowPort_b, InnerVolumeFlow1.flowPort_a) 
        annotation (points=[0,-40; -20,-40],          style(color=1, rgbcolor={255,0,0}));
      connect(AbsolutePressure1.flowPort, Pipe1.flowPort_a) 
        annotation (points=[40,-30; 40,-40; 20,-40], style(color=1, rgbcolor={255,0,0}));
      connect(HeatFlow.y, PrescribedHeatFlow1.Q_flow) 
        annotation (points=[-39,-90; -30,-90], style(color=3, rgbcolor={0,0,255}));
      connect(outerVolumeFlow.y,outerVolumeFlow1. VolumeFlow) annotation (
          points=[-39,90; -30,90; -30,80], style(color=74, rgbcolor={0,0,127}));
      connect(innerVolumeFlow.y, InnerVolumeFlow1.VolumeFlow) annotation (
          points=[-39,-30; -30,-30],                                     style(
            color=74, rgbcolor={0,0,127}));
      connect(InnerVolumeFlow1.flowPort_b, innerPipe.flowPort_a) 
        annotation (points=[-20,-20; 0,-20], style(color=1, rgbcolor={255,0,0}));
      connect(innerPipe.flowPort_b, AbsolutePressure1.flowPort) annotation (points=
            [20,-20; 40,-20; 40,-30], style(color=1, rgbcolor={255,0,0}));
      connect(outerVolumeFlow1.flowPort_b, outerPipe.flowPort_a) 
        annotation (points=[-20,70; 0,70], style(color=1, rgbcolor={255,0,0}));
      connect(outerPipe.flowPort_b, Ambient2.flowPort) 
        annotation (points=[20,70; 40,70], style(color=1, rgbcolor={255,0,0}));
      connect(outerPipe.heatPort, outerConvection.fluid) 
        annotation (points=[10,60; 10,51], style(color=42, rgbcolor={191,0,0}));
      connect(outerConvection.solid, innerConvection.solid) 
        annotation (points=[10,29; 10,21], style(color=42, rgbcolor={191,0,0}));
      connect(innerConvection.fluid, innerPipe.heatPort) 
        annotation (points=[10,-1; 10,-10], style(color=42, rgbcolor={191,0,0}));
      connect(innerGc.y, innerConvection.Gc) 
        annotation (points=[-19,10; 0,10], style(color=74, rgbcolor={0,0,127}));
      connect(outerGc.y, outerConvection.Gc) 
        annotation (points=[-19,40; 0,40], style(color=74, rgbcolor={0,0,127}));
    end IndirectCooling;
  end Examples;
  
  package Components 
    extends Modelica.Icons.Library;
  annotation (Documentation(info="<HTML>
<p>
This package contains components:
<ul>
<li>pipe without heat exchange</li>
<li>pipe with heat exchange</li>
<ul>
</p>
<p>
Pressure drop is taken from partial model SimpleFriction.<br>
Thermodynamic equations are defined in partial models (package Partials).
</p>
<p>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <p>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </p>
  <p>
  Dr.Christian Kral & Markus Plainer<br>
  <a href=\"http://www.arsenal.ac.at/english/\">arsenal research</a><br>
  Business Unit Monitoring, Energy and Drive Technologies<br>
  A-1030 Vienna, Austria
  </p>
  </dd>
</dl>
</p>
</dl>
<p>
Copyright &copy; 1998-2005, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.0 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  </ul>
</HTML>
"));
    
    model IsolatedPipe 
    annotation (Documentation(info="<HTML>
<p>
Pipe without heat exchange.<br>
Thermodynamic equations are defined by Partials.TwoPortMass(Q_flow = 0).
</p>
<p>
<b>Note:</b> Setting parameter m (mass of medium within pipe) to zero
leads to neglection of temperature transient cp*m*der(T).
</p>
</HTML>"),
      Icon(Rectangle(extent=[-90, 20; 90, -20], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=3,
              rgbfillColor={0,0,255})),
              Text(extent=[-150,100; 150,40], string="%name")), Diagram);
      extends Interfaces.Partials.TwoPort;
      extends Interfaces.Partials.SimpleFriction;
    equation 
      // coupling with FrictionModel
      VolumeFlow = V_flow;
      pressureDrop = dp;
      // no energy exchange with medium
      Q_flow = 0;
    end IsolatedPipe;
    
    model HeatedPipe 
    annotation (Documentation(info="<HTML>
<p>
Pipe with heat exchange.<br>
Thermodynamic equations are defined by Partials.TwoPort.<br>
Q_flow is defined by heatPort.Q_flow.<br>
heatPort's temperature is defined between inlet and outlet temperature of the medium, 
using factor kT.
</p>
<p>
<b>Note:</b> Setting parameter m (mass of medium within pipe) to zero
leads to neglection of temperature transient cp*m*der(T).
</p>
<p>
<b>Note:</b> Injecting heat into a pipe with zero massflow causes 
temperature rise defined by storing heat in medium's mass.
</p>
</HTML>"),
      Icon(Rectangle(extent=[-90, 20; 90, -20], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=3,
              rgbfillColor={0,0,255})),
              Text(extent=[-150,100; 150,40], string="%name"),
              Polygon(points=[-10,-90; -10,-40; 0,-20; 10,
                -40; 10,-90; -10,-90], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=1,
              rgbfillColor={255,0,0},
              fillPattern=1))), Diagram);
      extends Interfaces.Partials.TwoPort;
      extends Interfaces.Partials.SimpleFriction;
      parameter Real kT(final min=0, final max=1) = 1 
        "heatPort's temperature between inlet and outlet";
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort 
        annotation (extent=[-10,-110; 10,-90]);
    equation 
      // coupling with FrictionModel
      VolumeFlow = V_flow;
      pressureDrop = dp;
      // energy exchange with medium
      Q_flow = heatPort.Q_flow;
      // defines heatPort's temperature between inlet and outlet of medium
      if V_flow > Modelica.Constants.small then
        heatPort.T = (1-kT)*T_a + kT*T;
      elseif V_flow < -Modelica.Constants.small then
        heatPort.T = (1-kT)*T_b + kT*T;
      else
        heatPort.T = T;
      end if;
    end HeatedPipe;
  end Components;
  
  package Interfaces 
    extends Modelica.Icons.Library;
  annotation (Documentation(info="<HTML>
<p>
This package contains connectors and partial models:
<ul>
<li>FlowPort: basic definition of the connector.</li>
<li>FlowPort_a & FlowPort_b: same as FlowPort with different icons to differentiate direction of flow</li>
<li>package Partials (defining basic thermodynamic equations)</li>
</ul>
</p>
<p>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <p>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </p>
  <p>
  Dr.Christian Kral & Markus Plainer<br>
  <a href=\"http://www.arsenal.ac.at/english/\">arsenal research</a><br>
  Business Unit Monitoring, Energy and Drive Technologies<br>
  A-1030 Vienna, Austria
  </p>
  </dd>
</dl>
</p>
</dl>
<p>
Copyright &copy; 1998-2005, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.0 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.1 2005/02/15 Anton Haumer<br>
       moved Partials into Interfaces</li>
  <li> 
  </ul>
</HTML>
"));
    
    connector FlowPort 
    annotation (Documentation(info="<HTML>
<p>
Basic definition of the connector.
</p>
<p>
<b>Variables:</b>
<ul>
<li>Pressure p</li>
<li>flow MassFlowRate m_flow</li>
<li>Specific Enthalpy h</li>
<li>flow EnthaplyFlowRate H_flow</li>
</ul>
</p>
<p>
<p>
If ports with different media are connected, the simulation is asserted due to the check of parameter.
</p>
</HTML>"));
      parameter FluidHeatFlow.Media.Medium medium;
      Modelica.SIunits.Pressure p;
      flow Modelica.SIunits.MassFlowRate m_flow;
      Modelica.SIunits.SpecificEnthalpy h;
      flow Modelica.SIunits.EnthalpyFlowRate H_flow;
    end FlowPort;
    
    connector FlowPort_a 
    annotation (Documentation(info="<HTML>
<p>
Same as FlowPort, but icon allows to differentiate direction of flow.
</p>
</HTML>"),
      Icon(Rectangle(extent=[-100, 100; 100, -100], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255})), Polygon(points=[0, 100; -100, 0; 0,
                 -100; 100, 0; 0, 100], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255}))),     Diagram(Rectangle(extent=[-100,
                100; 100, -100], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255})), Polygon(points=[0, 100; -100, 0; 0,
                 -100; 100, 0; 0, 100], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Text(
            extent=[-150,-110; 150,-170],
            style(color=3, rgbcolor={0,0,255}),
            string="%name")));
      extends FlowPort;
    end FlowPort_a;
    
    connector FlowPort_b 
    annotation (Documentation(info="<HTML>
<p>
Same as FlowPort, but icon allows to differentiate direction of flow.
</p>
</HTML>"),
      Icon(Rectangle(extent=[-100, 100; 100, -100], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255})), Polygon(points=[0, 100; -100, 0; 0,
                 -100; 100, 0; 0, 100], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=7,
              rgbfillColor={255,255,255}))), Diagram(Rectangle(extent=[-100,
                100; 100, -100], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255})), Polygon(points=[0, 100; -100, 0; 0,
                 -100; 100, 0; 0, 100], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=7,
              rgbfillColor={255,255,255})),
          Text(
            extent=[-150,-110; 150,-170],
            style(color=3, rgbcolor={0,0,255}),
            string="%name")));
      extends FlowPort;
    end FlowPort_b;
    
    package Partials 
      extends Modelica.Icons.Library;
    annotation (Documentation(info="<HTML>
<p>
This package contains partial models, defining in a very compact way the basic thermodynamic equations used by the different components.
</p>
<p>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <p>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </p>
  <p>
  Dr.Christian Kral & Markus Plainer<br>
  <a href=\"http://www.arsenal.ac.at/english/\">arsenal research</a><br>
  Business Unit Monitoring, Energy and Drive Technologies<br>
  A-1030 Vienna, Austria
  </p>
  </dd>
</dl>
</p>
</dl>
<p>
Copyright &copy; 1998-2005, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>",     revisions="<HTML>
  <ul>
  <li> v1.0 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.1 2005/02/15 Anton Haumer<br>
       moved Partials into Interfaces</li>
  </ul>
</HTML>
"));
      
      partial model SimpleFriction 
      annotation (Documentation(info="<HTML>
<p>
Definition of relationship between pressure drop and volume flow rate:
</p>
<p>
-V_flowLaminar &lt; VolumeFlow &lt; +V_flowLaminar: laminar i.e. linear dependency of pressure drop on volume flow.<br>
-V_flowLaminar &gt; VolumeFlow or VolumeFlow &lt; +V_flowLaminar: turbulent i.e. quadratic dependency of pressure drop on volume flow.<br>
Linear and quadratic dependency are coupled smoothly at V_flowLaminar / dpLaminar.<br>
Quadratic dependency is defined by nominal volume flow and pressure drop (V_flowNominal / dpNominal).<br>
See also sketch at diagram layer.
</p>
</HTML>"),
        Diagram(
            Line(points=[-80,0; 80,0],   style(color=3, rgbcolor={0,0,255})),
            Line(points=[0,80; 0,-80],   style(color=3, rgbcolor={0,0,255})),
            Line(points=[-40,-20; 40,20], style(color=3, rgbcolor={0,0,255})),
            Line(points=[40,20; 60,40; 70,60; 74,80], style(color=3, rgbcolor={0,
                    0,255})),
            Line(points=[-40,-20; -60,-40; -70,-60; -74,-80], style(color=3,
                  rgbcolor={0,0,255})),
            Line(points=[40,20; 40,0], style(color=3, rgbcolor={0,0,255})),
            Line(points=[60,40; 60,0], style(color=3, rgbcolor={0,0,255})),
            Line(points=[40,20; 0,20], style(color=3, rgbcolor={0,0,255})),
            Line(points=[60,40; 0,40], style(color=3, rgbcolor={0,0,255})),
            Text(
              extent=[18,0; 48,-20],
              style(color=3, rgbcolor={0,0,255}),
              string="V_flowLaminar"),
            Text(
              extent=[50,0; 80,-20],
              style(color=3, rgbcolor={0,0,255}),
              string="V_flowNominal"),
            Text(
              extent=[-30,30; -4,10],
              style(color=3, rgbcolor={0,0,255}),
              string="dpLaminar"),
            Text(
              extent=[-30,50; -4,30],
              style(color=3, rgbcolor={0,0,255}),
              string="dpNominal"),
            Text(
              extent=[0,20; 30,0],
              style(color=3, rgbcolor={0,0,255}),
              string="dp ~ V_flow"),
            Text(
              extent=[30,60; 60,40],
              style(color=3, rgbcolor={0,0,255}),
              string="dp ~ V_flow²")));
        parameter Modelica.SIunits.VolumeFlowRate V_flowLaminar(min=Modelica.Constants.small)=1 
          "|SimpleFriction|laminar volume flow";
        parameter Modelica.SIunits.Pressure dpLaminar=10000 
          "|SimpleFriction|laminar pressure drop";
        parameter Modelica.SIunits.VolumeFlowRate V_flowNominal=2 
          "|SimpleFriction|nominal volume flow";
        parameter Modelica.SIunits.Pressure dpNominal=20000 
          "|SimpleFriction|nominal pressure drop";
        Modelica.SIunits.Pressure pressureDrop;
        Modelica.SIunits.VolumeFlowRate VolumeFlow;
      protected 
        parameter Real k(fixed=false);
      initial algorithm 
        assert(V_flowNominal>V_flowLaminar,
          "SimpleFriction: V_flowNominal has to be > V_flowLaminar!");
        assert(dpNominal>=dpLaminar*V_flowNominal/V_flowLaminar,
          "SimpleFriction: dpNominal has to be > dpLaminar*V_flowNominal/V_flowLaminar!");
        k:=(dpNominal - dpLaminar/V_flowLaminar*V_flowNominal)/(V_flowNominal - V_flowLaminar)^2;
      equation 
        if     VolumeFlow > +V_flowLaminar then
          pressureDrop = +dpLaminar/V_flowLaminar*VolumeFlow + k*(VolumeFlow - V_flowLaminar)^2;
        elseif VolumeFlow < -V_flowLaminar then
          pressureDrop = +dpLaminar/V_flowLaminar*VolumeFlow - k*(VolumeFlow + V_flowLaminar)^2;
        else
          pressureDrop =  dpLaminar/V_flowLaminar*VolumeFlow;
        end if;
      end SimpleFriction;
      
      partial model TwoPort 
      annotation (Documentation(info="<HTML>
<p>
Partial model with two flowPorts.<br>
Possible heat exchange with the ambient is defined by Q_flow; setting this = 0 means no energy exchange.<br>
Setting parameter m (mass of medium within pipe) to zero
leads to neglection of temperature transient cp*m*der(T).<br>
Mixing rule is applied.
</p>
</HTML>"));
        parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
          annotation(choicesAllMatching=true);
        parameter Modelica.SIunits.Mass m=1 "mass of medium";
        parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20) 
          "initial temperature of medium" 
          annotation(Dialog(enable=m>Modelica.Constants.small));
        Modelica.SIunits.Pressure dp;
        Modelica.SIunits.VolumeFlowRate V_flow;
        Modelica.SIunits.Temperature T(start=T0) "outlet temperature of medium";
        Modelica.SIunits.HeatFlowRate Q_flow "heat exchange with ambient";
        output Modelica.SIunits.Temperature T_a=flowPort_a.h/medium.cp 
          "temperature at flowPort_a";
        output Modelica.SIunits.Temperature T_b=flowPort_b.h/medium.cp 
          "temperature at flowPort_b";
        Interfaces.FlowPort_a flowPort_a(final medium=medium) 
          annotation (extent=[-110, -10; -90, 10]);
        Interfaces.FlowPort_b flowPort_b(final medium=medium) 
          annotation (extent=[90, -10; 110, 10]);
      equation 
        // pressure drop a->b
        dp = flowPort_a.p - flowPort_b.p;
        // massflow a->b
        V_flow = flowPort_a.m_flow/medium.rho;
        // mass balance
        flowPort_a.m_flow + flowPort_b.m_flow = 0;
        // energy balance
        if m>Modelica.Constants.small then
          flowPort_a.H_flow + flowPort_b.H_flow + Q_flow = m*medium.cp*der(T);
        else
          flowPort_a.H_flow + flowPort_b.H_flow + Q_flow = 0;
        end if;
        // massflow a->b mixing rule at a, energy flow at b defined by medium's temperature
        // massflow b->a mixing rule at b, energy flow at a defined by medium's temperature
        flowPort_a.H_flow = medium.cp*semiLinear(flowPort_a.m_flow,T_a,T);
        flowPort_b.H_flow = medium.cp*semiLinear(flowPort_b.m_flow,T_b,T);
      end TwoPort;
      
      partial model AbsoluteSensor 
      annotation (Documentation(info="<HTML>
<p>
Partial model for an absolute sensor (pressure/temperature).<br>
Pressure, mass flow, temperature and energy flow of medium are not affected.
</p>
</HTML>"));
        parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
          annotation(choicesAllMatching=true);
        Interfaces.FlowPort_a flowPort(final medium=medium) 
          annotation (extent=[-110,-10; -90,10]);
        Modelica.Blocks.Interfaces.RealOutput y 
          annotation (extent=[100, -10; 120, 10]);
        annotation (Icon(
            Ellipse(extent=[-70, 70; 70, -70], style(color=0, fillColor=7)),
            Line(points=[0, 70; 0, 40], style(color=0)),
            Line(points=[22.9, 32.8; 40.2, 57.3], style(color=0)),
            Line(points=[-22.9, 32.8; -40.2, 57.3], style(color=0)),
            Line(points=[37.6, 13.7; 65.8, 23.9], style(color=0)),
            Line(points=[-37.6, 13.7; -65.8, 23.9], style(color=0)),
            Line(points=[0, 0; 9.02, 28.6], style(color=0)),
            Polygon(points=[-0.48, 31.6; 18, 26; 18, 57.2; -0.48, 31.6], style(
                color=0,
                fillColor=0,
                fillPattern=1)),
            Ellipse(extent=[-5, 5; 5, -5], style(
                color=0,
                gradient=0,
                fillColor=0,
                fillPattern=1)),
            Line(points=[-70, 0; -90, 0], style(color=0)),
            Line(points=[70, 0; 100, 0]),
            Text(
              extent=[-150,130; 150,70],
              style(color=3, rgbcolor={0,0,255}),
              string="%name")), Diagram);
      equation 
        // no mass exchange
        flowPort.m_flow = 0;
        // no energy exchange
        flowPort.H_flow = 0;
      end AbsoluteSensor;
      
      partial model RelativeSensor 
      annotation (Documentation(info="<HTML>
<p>
Partial model for a relative sensor (pressure drop/temperature difference).<br>
Pressure, mass flow, temperature and energy flow of medium are not affected.
</p>
</HTML>"));
        parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
          annotation(choicesAllMatching=true);
        Interfaces.FlowPort_a flowPort_a(final medium=medium) 
          annotation (extent=[-110,-10; -90,10]);
        Interfaces.FlowPort_b flowPort_b(final medium=medium) 
          annotation (extent=[90,-10; 110,10]);
        Modelica.Blocks.Interfaces.RealOutput y 
          annotation (extent=[-10,-100; 10,-120],  rotation=90);
        annotation (Icon(
            Ellipse(extent=[-70, 70; 70, -70], style(color=0, fillColor=7)),
            Line(points=[0, 70; 0, 40], style(color=0)),
            Line(points=[22.9, 32.8; 40.2, 57.3], style(color=0)),
            Line(points=[-22.9, 32.8; -40.2, 57.3], style(color=0)),
            Line(points=[37.6, 13.7; 65.8, 23.9], style(color=0)),
            Line(points=[-37.6, 13.7; -65.8, 23.9], style(color=0)),
            Line(points=[0, 0; 9.02, 28.6], style(color=0)),
            Polygon(points=[-0.48, 31.6; 18, 26; 18, 57.2; -0.48, 31.6], style(
                color=0,
                fillColor=0,
                fillPattern=1)),
            Ellipse(extent=[-5, 5; 5, -5], style(
                color=0,
                gradient=0,
                fillColor=0,
                fillPattern=1)),
            Line(points=[-70, 0; -90, 0], style(color=0)),
            Line(points=[70, 0; 90, 0], style(color=0)),
            Line(points=[0,-100; 0,-70]),
            Text(
              extent=[-150,130; 150,70],
              style(color=3, rgbcolor={0,0,255}),
              string="%name")), Diagram);
      equation 
        // no mass exchange
        flowPort_a.m_flow = 0;
        flowPort_b.m_flow = 0;
        // no energy exchange
        flowPort_a.H_flow = 0;
        flowPort_b.H_flow = 0;
      end RelativeSensor;
      
      partial model FlowSensor 
      annotation (Documentation(info="<HTML>
<p>
Partial model for a flow sensor (mass flow/heat flow).<br>
Pressure, mass flow, temperature and energy flow of medium are not affected, but mixing rules is applied if necessary.
</p>
</HTML>"));
        extends TwoPort(final m=0, final T0=0);
        Modelica.Blocks.Interfaces.RealOutput y 
          annotation (extent=[-10,-100; 10,-120],  rotation=90);
        annotation (Icon(
            Ellipse(extent=[-70, 70; 70, -70], style(color=0, fillColor=7)),
            Line(points=[0, 70; 0, 40], style(color=0)),
            Line(points=[22.9, 32.8; 40.2, 57.3], style(color=0)),
            Line(points=[-22.9, 32.8; -40.2, 57.3], style(color=0)),
            Line(points=[37.6, 13.7; 65.8, 23.9], style(color=0)),
            Line(points=[-37.6, 13.7; -65.8, 23.9], style(color=0)),
            Line(points=[0, 0; 9.02, 28.6], style(color=0)),
            Polygon(points=[-0.48, 31.6; 18, 26; 18, 57.2; -0.48, 31.6], style(
                color=0,
                fillColor=0,
                fillPattern=1)),
            Ellipse(extent=[-5, 5; 5, -5], style(
                color=0,
                gradient=0,
                fillColor=0,
                fillPattern=1)),
            Line(points=[-70, 0; -90, 0], style(color=0)),
            Line(points=[70, 0; 90, 0], style(color=0)),
            Line(points=[0,-100; 0,-70]),
            Text(
              extent=[-150,130; 150,70],
              style(color=3, rgbcolor={0,0,255}),
              string="%name")), Diagram);
      equation 
        // no pressure drop
        dp = 0;
        // no energy exchange
        Q_flow = 0;
      end FlowSensor;
    end Partials;
  end Interfaces;
  
  package Media 
  annotation (Documentation(info="<HTML>
<p>
This package contains definitions of medium properties.
</p>
<p>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <p>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </p>
  <p>
  Dr.Christian Kral & Markus Plainer<br>
  <a href=\"http://www.arsenal.ac.at/english/\">arsenal research</a><br>
  Business Unit Monitoring, Energy and Drive Technologies<br>
  A-1030 Vienna, Austria
  </p>
  </dd>
</dl>
</p>
</dl>
<p>
Copyright &copy; 1998-2005, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.0 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  </ul>
</HTML>
"));
    
    record Medium 
      extends Modelica.Icons.Record;
      parameter Modelica.SIunits.Density rho = 1 "density";
      parameter Modelica.SIunits.SpecificHeatCapacity cp = 1 
        "specific heat capacity at constant pressure";
      parameter Modelica.SIunits.ThermalConductivity lamda = 1 
        "thermal conductivity";
      parameter Modelica.SIunits.KinematicViscosity nue = 1 
        "kinematic viscosity";
    end Medium;
    
    record Air_30degC 
    extends Medium(
      rho=1.149,
      cp=1007,
      lamda=0.0264,
      nue=16.3E-6);
    end Air_30degC;
    
    record Air_70degC 
    extends Medium(
      rho=1.015,
      cp=1010,
      lamda=0.0293,
      nue=20.3E-6);
    end Air_70degC;
    
    record Water 
    extends Medium(
      rho=995.6,
      cp=4177,
      lamda=0.615,
      nue=0.8E-6);
    end Water;
  end Media;
  
  package Sensors 
    extends Modelica.Icons.Library;
  annotation (Documentation(info="<HTML>
<p>
This package contains sensors:
<ul>
<li>pSensor: absolute pressure</li>
<li>TSensor: absolute temperature (Kelvin)</li>
<li>dpSensor: pressure drop between flowPort_a and flowPort_b</li>
<li>dTSensor: temperature difference between flowPort_a and flowPort_b</li>
<li>m_flowSensor: measures mass flow rate</li>
<li>V_flowSensor: measures volume flow rate</li>
<li>H_flowSensor: measures enthalpy flow rate</li>
</ul>
</p>
<p>
Some of the sensors do not need access to medium properties for measuring, 
but it is necessary to define the medium in the connector (check of connections).<br>
Thermodynamic equations are defined in partial models (package Interfaces.Partials).<br>
All sensors are considered massless, they do not change mass flow or energy flow.
</p>
<p>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <p>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </p>
  <p>
  Dr.Christian Kral & Markus Plainer<br>
  <a href=\"http://www.arsenal.ac.at/english/\">arsenal research</a><br>
  Business Unit Monitoring, Energy and Drive Technologies<br>
  A-1030 Vienna, Austria
  </p>
  </dd>
</dl>
</p>
</dl>
<p>
Copyright &copy; 1998-2005, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.0 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  </ul>
</HTML>
"));
    
    model pSensor 
    annotation (Documentation(info="<HTML>
<p>
pSensor measures the absolute pressure.<br>
Thermodynamic equations are defined by Partials.AbsoluteSensor.
</p>
</HTML>"), Diagram);
      extends Interfaces.Partials.AbsoluteSensor(y(redeclare type SignalType = 
              Modelica.SIunits.Pressure));
    equation 
      y = flowPort.p;
      annotation(Icon(Text(
            extent=[-22,-20; 20,-60],
            style(color=3, rgbcolor={0,0,255}),
            string="p")), Diagram);
    end pSensor;
    
    model TSensor 
    annotation (Documentation(info="<HTML>
<p>
TSensor measures the absolute temperature (Kelvin).<br>
Thermodynamic equations are defined by Partials.AbsoluteSensor.
</p>
</HTML>"), Diagram);
      extends Interfaces.Partials.AbsoluteSensor(y(redeclare type SignalType = 
              Modelica.SIunits.Temperature));
    equation 
      medium.cp*y = flowPort.h;
      annotation(Icon(Text(
            extent=[-22,-20; 20,-60],
            style(color=3, rgbcolor={0,0,255}),
            string="T")));
    end TSensor;
    
    model dpSensor 
    annotation (Documentation(info="<HTML>
<p>
dpSensor measures the pressure drop between flowPort_a and flowPort_b.<br>
Thermodynamic equations are defined by Partials.RelativeSensor.
</p>
</HTML>"), Diagram);
      extends Interfaces.Partials.RelativeSensor(y(redeclare type SignalType = 
              Modelica.SIunits.Pressure));
    equation 
      y = flowPort_a.p - flowPort_b.p;
      annotation(Icon(Text(
            extent=[-22,-20; 20,-60],
            style(color=3, rgbcolor={0,0,255}),
            string="dp")));
    end dpSensor;
    
    model dTSensor 
    annotation (Documentation(info="<HTML>
<p>
dTSensor measures the temperature difference between flowPort_a and flowPort_b.<br>
Thermodynamic equations are defined by Partials.RelativeSensor.
</p>
</HTML>"), Diagram);
      extends Interfaces.Partials.RelativeSensor(y(redeclare type SignalType = 
              Modelica.SIunits.Temperature));
    equation 
      medium.cp*y = flowPort_a.h - flowPort_b.h;
      annotation(Icon(Text(
            extent=[-22,-20; 20,-60],
            style(color=3, rgbcolor={0,0,255}),
            string="dT")));
    end dTSensor;
    
    model m_flowSensor 
    annotation (Documentation(info="<HTML>
<p>
m_flowSensor measures the mass flow rate.<br>
Thermodynamic equations are defined by Partials.FlowSensor.
</p>
</HTML>"), Diagram);
      extends Interfaces.Partials.FlowSensor(y(redeclare type SignalType = 
              Modelica.SIunits.MassFlowRate));
    equation 
      y = V_flow*medium.rho;
      annotation(Icon(Text(
            extent=[-22,-20; 20,-60],
            style(color=3, rgbcolor={0,0,255}),
            string="m")));
    end m_flowSensor;
    
    model V_flowSensor 
    annotation (Documentation(info="<HTML>
<p>
V_flowSensor measures the volume flow rate.<br>
Thermodynamic equations are defined by Partials.FlowSensor.
</p>
</HTML>"), Diagram);
      extends Interfaces.Partials.FlowSensor(y(redeclare type SignalType = 
              Modelica.SIunits.VolumeFlowRate));
    equation 
      y = V_flow;
      annotation(Icon(Text(
            extent=[-22,-20; 20,-60],
            style(color=3, rgbcolor={0,0,255}),
            string="V")));
    end V_flowSensor;
    
    model H_flowSensor 
    annotation (Documentation(info="<HTML>
<p>
H_flowSensor measures the enthalpy flow rate.<br>
Thermodynamic equations are defined by Partials.FlowSensor.
</p>
</HTML>"),     Diagram);
      extends Interfaces.Partials.FlowSensor(y(redeclare type SignalType = 
              Modelica.SIunits.EnthalpyFlowRate));
    equation 
      y = flowPort_a.H_flow;
      annotation(Icon(Text(
            extent=[-22,-20; 20,-60],
            style(color=3, rgbcolor={0,0,255}),
            string="H")));
    end H_flowSensor;
  end Sensors;
  
  package Sources 
    extends Modelica.Icons.Library;
  annotation (Documentation(info="<HTML>
<p>
This package contains different types of sources:
<ul>
<li>Ambient with constant pressure and temperature</li>
<li>Ambient with prescribed pressure and temperature</li>
<li>AbsolutePressure to define pressure level of a closed cooling cycle.</li>
<li>Constant and prescribed volume flow</li>
<li>Constant and prescribed pressure increase flow</li>
<ul>
</p>
<p>
Thermodynamic equations are defined in partial models (package Interfaces.Partials).<br>
All fans / pumps are considered without losses, they do not change enthalpy flow.
</p>
<p>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <p>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </p>
  <p>
  Dr.Christian Kral & Markus Plainer<br>
  <a href=\"http://www.arsenal.ac.at/english/\">arsenal research</a><br>
  Business Unit Monitoring, Energy and Drive Technologies<br>
  A-1030 Vienna, Austria
  </p>
  </dd>
</dl>
</p>
</dl>
<p>
Copyright &copy; 1998-2005, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.0 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  </ul>
</HTML>
"));
    
    model Ambient 
    annotation (Documentation(info="<HTML>
<p>
(Infinite) ambient with constant pressure and temperature.
</p>
</HTML>"), Icon(
               Ellipse(extent=[-90,90; 90,-90], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Text(
            extent=[-150,150; 150,90],
            style(color=3, rgbcolor={0,0,255}),
            string="%name")));
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Pressure p_Ambient=100000;
      parameter Modelica.SIunits.Temperature T_Ambient=Modelica.SIunits.Conversions.from_degC(20);
      Modelica.SIunits.Temperature T;
      output Modelica.SIunits.Temperature T_port=flowPort.h/medium.cp;
    public 
      Interfaces.FlowPort_a flowPort(final medium=medium) 
        annotation (extent=[-110,-10; -90,10]);
    equation 
      flowPort.p = p_Ambient;
      T = T_Ambient;
      // massflow -> ambient: mixing rule
      // massflow <- ambient: energy flow defined by ambient's temperature
      flowPort.H_flow = medium.cp*semiLinear(flowPort.m_flow,T_port,T);
    end Ambient;
    
    model PrescribedAmbient 
    annotation (Documentation(info="<HTML>
<p>
(Infinite) ambient with prescribed pressure and temperature.
</p>
</HTML>"), Icon(
               Ellipse(extent=[-90,90; 90,-90], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Text(
            extent=[-150,150; 150,90],
            style(color=3, rgbcolor={0,0,255}),
            string="%name")),
        Diagram);
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
        annotation(choicesAllMatching=true);
      Modelica.SIunits.Temperature T;
      output Modelica.SIunits.Temperature T_port=flowPort.h/medium.cp;
    public 
      Interfaces.FlowPort_a flowPort(final medium=medium) 
        annotation (extent=[-110,-10; -90,10]);
      Modelica.Blocks.Interfaces.RealInput p_Ambient(redeclare type SignalType 
          = Modelica.SIunits.Pressure) 
        annotation (extent=[110, 60; 90, 80], rotation=0);
      Modelica.Blocks.Interfaces.RealInput T_Ambient(redeclare type SignalType 
          = Modelica.SIunits.Temperature) 
        annotation (extent=[110, -60; 90, -80], rotation=0);
    equation 
      flowPort.p = p_Ambient;
      T = T_Ambient;
      // massflow -> ambient: mixing rule
      // massflow <- ambient: energy flow defined by ambient's temperature
      flowPort.H_flow = medium.cp*semiLinear(flowPort.m_flow,T_port,T);
    end PrescribedAmbient;
    
    model AbsolutePressure 
    annotation (Documentation(info="<HTML>
<p>
AbsolutePressure to define pressure level of a closed cooling cycle. 
Coolant's mass flow, temperature and energy flow are not affected.<br>
</p>
</HTML>"),     Diagram,
        Icon(
          Text(
            extent=[-150,150; 150,90],
            style(color=3, rgbcolor={0,0,255}),
            string="%name"),
               Ellipse(extent=[-90,90; 90,-90], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255}))));
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Pressure p=100000 "pressure ground";
      annotation (Icon(Ellipse(extent=[-90,90; 90,-90], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255}))));
      Interfaces.FlowPort_a flowPort(final medium=medium) 
        annotation (extent=[-110,-10; -90,10]);
    equation 
      // defining pressure
      flowPort.p = p;
      // no energy exchange; no mass flow by default
      flowPort.H_flow = 0;
    end AbsolutePressure;
    
    model ConstantVolumeFlow 
    annotation (Documentation(info="<HTML>
<p>
Fan resp. pump with constant volume flow rate. Pressure increase is the response of the whole system. 
Coolant's temperature and energy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglection of temperature transient cp*m*der(T).<br>
Thermodynamic equations are defined by Partials.TwoPort.
</p>
</HTML>"), Icon(
           Ellipse(extent=[-90,90; 90,-90],   style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255})),
          Text(
            extent=[-150,-90; 150,-150],
            style(color=3, rgbcolor={0,0,255}),
            string="%name"),
          Polygon(points=[-60,68; 90,10; 90,-10; -60,-68; -60,68], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=3,
              rgbfillColor={0,0,255},
              fillPattern=1)),
                Text(
            extent=[-40,20; 0,-20],
            style(color=0, rgbcolor={0,0,0}),
            string="V")));
      extends Interfaces.Partials.TwoPort;
      parameter Modelica.SIunits.VolumeFlowRate VolumeFlow=1;
    equation 
      Q_flow = 0;
      V_flow = VolumeFlow;
    end ConstantVolumeFlow;
    
    model PrescribedVolumeFlow 
    annotation (Documentation(info="<HTML>
<p>
Fan resp. pump with prescribed volume flow rate. Pressure increase is the response of the whole system. 
Coolant's temperature and energy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglection of temperature transient cp*m*der(T).<br>
Thermodynamic equations are defined by Partials.TwoPort.
</p>
</HTML>"),
      Icon(Ellipse(extent=[-90,90; 90,-90],   style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255})),
          Text(
            extent=[-150,-90; 150,-150],
            style(color=3, rgbcolor={0,0,255}),
            string="%name"),
          Polygon(points=[-60,68; 90,10; 90,-10; -60,-68; -60,68], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=3,
              rgbfillColor={0,0,255},
              fillPattern=1)),
                Text(
            extent=[-40,20; 0,-20],
            style(color=0, rgbcolor={0,0,0}),
            string="V")),
        Diagram);
      extends Interfaces.Partials.TwoPort;
      Modelica.Blocks.Interfaces.RealInput VolumeFlow(redeclare type SignalType
          =            Modelica.SIunits.VolumeFlowRate) 
        annotation (extent=[-10,90; 10,110], rotation=-90);
    equation 
      Q_flow = 0;
      V_flow = VolumeFlow;
    end PrescribedVolumeFlow;
    
    model ConstantPressureIncrease 
    annotation (Documentation(info="<HTML>
<p>
Fan resp. pump with constant pressure increase. Mass resp. volume flow is the response of the whole system. 
Coolant's temperature and energy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglection of temperature transient cp*m*der(T).<br>
Thermodynamic equations are defined by Partials.TwoPort
</p>
</HTML>"),
      Icon(Ellipse(extent=[-90,90; 90,-90],   style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255})),
          Text(
            extent=[-150,-90; 150,-150],
            style(color=3, rgbcolor={0,0,255}),
            string="%name"),
          Polygon(points=[-60,68; 90,10; 90,-10; -60,-68; -60,68], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=1,
              rgbfillColor={255,0,0},
              fillPattern=1)),
                Text(
            extent=[-40,20; 0,-20],
            string="dp",
            style(color=0, rgbcolor={0,0,0}))));
      extends Interfaces.Partials.TwoPort;
      parameter Modelica.SIunits.Pressure PressureIncrease=1;
    equation 
      Q_flow = 0;
      dp = -PressureIncrease;
    end ConstantPressureIncrease;
    
    model PrescribedPressureIncrease 
    annotation (Documentation(info="<HTML>
<p>
Fan resp. pump with prescribed pressure increase. Mass resp. volume flow is the response of the whole system. 
Coolant's temperature and energy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglection of temperature transient cp*m*der(T).<br>
Thermodynamic equations are defined by Partials.TwoPort
</p>
</HTML>"),     Diagram,
        Icon(
           Ellipse(extent=[-90,90; 90,-90],   style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255})),
          Text(
            extent=[-150,-90; 150,-150],
            style(color=3, rgbcolor={0,0,255}),
            string="%name"),
          Polygon(points=[-60,68; 90,10; 90,-10; -60,-68; -60,68], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=1,
              rgbfillColor={255,0,0})),
                Text(
            extent=[-40,20; 0,-20],
            string="dp",
            style(color=0, rgbcolor={0,0,0}))));
      extends Interfaces.Partials.TwoPort;
      Modelica.Blocks.Interfaces.RealInput PressureIncrease(redeclare type 
          SignalType = Modelica.SIunits.Pressure) 
        annotation (extent=[-10,90; 10,110],    rotation=-90);
    equation 
      Q_flow = 0;
      dp = -PressureIncrease;
    end PrescribedPressureIncrease;
  end Sources;
end FluidHeatFlow;
