within Modelica.Thermal;


package FluidHeatFlow 
  "Simple components for 1-dimensional incompressible thermo-fluid flow models" 
  extends Modelica.Icons.Library2;
  annotation (
    version="1.6.3a", versionDate="2007-10-08",
    preferedView="info",Documentation(info="<HTML>
This package contains very simple-to-use components to model coolant flows as needed to simulate cooling e.g. of electric machines:
<ul>
<li>Components: components like different types of pipe models</li>
<li>Examples: some test examples</li>
<li>Interfaces: definition of connectors and partial models 
(containing the core thermodynamic equations)</li>
<li>Media: definition of media properties</li>
<li>Sensors: various sensors for pressure, temperature, volume and enthalpy flow</li>
<li>Sources: various flow sources</li>
</ul>
<b>Variables used in connectors:</b>
<ul>
<li>Pressure p</li>
<li>flow MassFlowRate m_flow</li>
<li>SpecificEnthalpy h</li>
<li>flow EnthalpyFlowRate H_flow</li>
</ul>
EnthalpyFlowRate means the Enthalpy = cp<sub>constant</sub> * m * T that is carried by the medium's flow.<br><br>
<b>Limitations and assumptions:</b>
<ul>
<li>Splitting and mixing of coolant flows (media with the same cp) is possible.</li>
<li>Reversing the direction of flow is possible.</li>
<li>The medium is considered to be incompressible.</li>
<li>No mixtures of media is taken into consideration.</li>
<li>The medium may not change its phase.</li>
<li>Medium properties are kept constant.</li>
<li>Pressure changes are only due to pressure drop and geodetic height differnence rho*g*h (if h > 0).</li>
<li>A user-defined part (0..1) of the friction losses (V_flow*dp) are fed to the medium.</li>
<li><b>Note:</b> Connected flowPorts have the same temperature (mixing temperature)!<br>
Since mixing may occur, the outlet temperature may be different from the connector's temperature.<br> 
Outlet temperature is defined by variable T of the corresponding component.</li>
</ul>
<b>Further development:</b>
<ul>
<li>Additional components like tanks (if needed)</li>
</ul>
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
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2007, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.10 2005/02/15 Anton Haumer<br>
       reorganisation of the package</li>
  <li> v1.11 2005/02/18 Anton Haumer<br>
       corrected usage of cv and cp</li>
  <li> v1.20 Beta 2005/02/18 Anton Haumer<br>
       introduced geodetic height in Components.Pipes<br>
       <i>new models: Components.Valve, Sources.IdealPump</i></li>
  <li> v1.30 Beta 2005/06/02 Anton Haumer<br>
       friction losses are fed to medium</li>
  <li> v1.31 Beta 2005/06/04 Anton Haumer<br>
       <i>new example: PumpAndValve</i><br>
       <i>new example: PumpDropOut</i></li>
  <li> v1.33 Beta 2005/06/07 Anton Haumer<br>
       corrected usage of simpleFlow</li>
  <li> v1.40 2005/06/13 Anton Haumer<br>
       stable release</li>
  <li> v1.42 Beta 2005/06/18 Anton Haumer<br>
       <i>new test example: ParallelPumpDropOut</i></li>
  <li> v1.43 Beta 2005/06/20 Anton Haumer<br>
       Test of mixing / semiLinear<br>
       <i>new test example: OneMass</i><br>
       <i>new test example: TwoMass</i></li>
  <li> v1.50 2005/09/07 Anton Haumer<br>
       semiLinear works fine</li>
  <li> v1.60 2007/01/23 Anton Haumer<br>
       new parameter tapT defining Temperature of heatPort </li>
  <li> v1.6.1 2007/08/12 Anton Haumer<br>
       improved documentation<br>
       removed type TemperatureDifference since this is defined in Modelica.SIunits</li>
  <li> v1.6.2 2007/08/20 Anton Haumer<br>
       improved documentation</li>
  <li> v1.6.3 2007/08/21 Anton Haumer<br>
       improved documentation</li>
  <li> v1.6.3a 2007/10/08 Anton Haumer<br>
       changes to avoid unit conflicts</li>
  </ul>
</HTML>
"), Icon(
      Polygon(points=[-80,10; -60,-10; -80,-30; -20,-30; 0,-10; -20,10; -80,10],
          style(
          color=69,
          rgbcolor={0,128,255},
          fillColor=69,
          rgbfillColor={0,128,255})),
      Polygon(points=[-40,-90; -20,-70; 0,-90; 0,-50; -20,-30; -40,-50; -40,-90],
          style(
          color=1,
          rgbcolor={255,0,0},
          fillColor=1,
          rgbfillColor={255,0,0},
          fillPattern=1)),
      Polygon(points=[-20,10; 0,-10; -20,-30; 40,-30; 60,-10; 40,10; -20,10],
                                                                          style(
          color=45,
          rgbcolor={255,128,0},
          fillColor=45,
          rgbfillColor={255,128,0}))));
  
  package Examples 
    "Examples that demonstrate the usage of the FluidHeatFlow components" 
    extends Modelica.Icons.Library2;
  annotation (Documentation(info="<HTML>
This package contains test examples:
<ul>
<li>1.SimpleCooling: heat is dissipated through a media flow</li>
<li>2.ParallelCooling: two heat sources dissipate through merged media flows</li>
<li>3.IndirectCooling: heat is disspated through two cooling cycles</li>
<li>4.PumpAndValve: demonstrates usage of an IdealPump and a Valve</li>
<li>5.PumpDropOut: demonstrates shutdown and restart of a pump</li>
<li>6.ParallelPumpDropOut: demonstrates shutdown and restart of a pump in a parallel circuit</li>
<li>7.OneMass: cooling of a mass (thermal capacity) by a coolant flow</li>
<li>8.TwoMass: cooling of two masses (thermal capacities) by two parallel coolant flows</li>
</ul>
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
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2007, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.31 Beta 2005/06/04 Anton Haumer<br>
       <i>new example: PumpAndValve</i><br>
       <i>new example: PumpDropOut</i></li>
  <li> v1.42 Beta 2005/06/18 Anton Haumer<br>
       <i>new test example: ParallelPumpDropOut</i></li>
  <li> v1.43 Beta 2005/06/20 Anton Haumer<br>
       Test of mixing / semiLinear<br>
       <i>new test example: OneMass</i><br>
       <i>new test example: TwoMass</i></li>
  </ul>
</HTML>
"), Icon(Ellipse(extent=[-60,10; 40,-90], style(color=10, rgbcolor={135,135,135})),
          Polygon(points=[-30,-12; -30,-68; 28,-40; -30,-12], style(
            color=10,
            rgbcolor={135,135,135},
            fillColor=10,
            rgbfillColor={135,135,135},
            fillPattern=1))));
    
    model SimpleCooling "Example: simple cooling circuit" 
      extends Modelica.Icons.Example;
    annotation (Documentation(info="<HTML>
<p>
1st test example: SimpleCooling
</p>
A prescribed heat source dissipates its heat through a thermal conductor to a coolant flow. The coolant flow is taken from an ambient and driven by a pump with prescribed mass flow.<br>
<b>Results</b>:<br>
<table>
<tr>
<td valign=\"top\"><b>output</b></td>
<td valign=\"top\"><b>explanation</b></td>
<td valign=\"top\"><b>formula</b></td>
<td valign=\"top\"><b>actual steady-state value</b></td>
</tr>
<tr>
<td valign=\"top\">dTSource</td>
<td valign=\"top\">Source over Ambient</td>
<td valign=\"top\">dtCoolant + dtToPipe</td>
<td valign=\"top\">20 K</td>
</tr>
<tr>
<td valign=\"top\">dTtoPipe</td>
<td valign=\"top\">Source over Coolant</td>
<td valign=\"top\">Losses / ThermalConductor.G</td>
<td valign=\"top\">10 K</td>
</tr>
<tr>
<td valign=\"top\">dTCoolant</td>
<td valign=\"top\">Coolant's temperature increase</td>
<td valign=\"top\">Losses * cp * massFlow</td>
<td valign=\"top\">10 K</td>
</tr>
</table>
</HTML>"), Diagram,
        experiment(StopTime=1.0),
        experimentSetupOutput);
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
        "Cooling medium" 
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TAmb=20 
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource=
        PrescribedHeatFlow1.port.T-Modelica.SIunits.Conversions.from_degC(TAmb) 
        "Source over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=PrescribedHeatFlow1.port.T-Pipe1.heatPort.T 
        "Source over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=Pipe1.dT 
        "Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient Ambient1(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[-60,-10; -80,10]);
      FluidHeatFlow.Sources.PrescribedVolumeFlow Pump1(
        medium=medium,
        m=0,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[-40,-10; -20,10]);
      FluidHeatFlow.Components.HeatedPipe Pipe1(
        medium=medium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[0,-10; 20,10]);
      FluidHeatFlow.Sources.Ambient Ambient2(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
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
      connect(Ambient1.flowPort, Pump1.flowPort_a) 
        annotation (points=[-60,0; -40,0],   style(color=1, rgbcolor={255,0,0}));
      connect(Pump1.flowPort_b, Pipe1.flowPort_a) 
        annotation (points=[-20,0; 0,0],   style(color=1, rgbcolor={255,0,0}));
      connect(Pipe1.flowPort_b, Ambient2.flowPort) 
        annotation (points=[20,0; 40,0],   style(color=1, rgbcolor={255,0,0}));
      connect(HeatFlow.y, PrescribedHeatFlow1.Q_flow) annotation (points=[-39,
            -50; -30,-50],   style(color=3, rgbcolor={0,0,255}));
      connect(VolumeFlow.y, Pump1.VolumeFlow) 
                                             annotation (points=[-39,20; -30,20;
            -30,10], style(color=74, rgbcolor={0,0,127}));
      connect(Convection1.solid, PrescribedHeatFlow1.port) annotation (points=[10,-40;
            10,-50; -10,-50],         style(color=42, rgbcolor={191,0,0}));
      connect(Convection1.solid, HeatCapacitor1.port) annotation (points=[10,-40;
            10,-50; 30,-50],      style(color=42, rgbcolor={191,0,0}));
      connect(Pipe1.heatPort, Convection1.fluid) annotation (points=[10,-10; 10,
            -20], style(color=42, rgbcolor={191,0,0}));
      connect(G.y, Convection1.Gc) annotation (points=[-9,-30; 0,-30], style(
            color=74, rgbcolor={0,0,127}));
    end SimpleCooling;
    
    model ParallelCooling "Example: coolig circuit with parallel branches" 
      extends Modelica.Icons.Example;
    annotation (Documentation(info="<HTML>
<p>
2nd test example: ParallelCooling
</p>
Two prescribed heat sources dissipate their heat through thermal conductors to coolant flows. The coolant flow is taken from an ambient and driven by a pump with prescribed mass flow, then splitted into two coolant flows connected to the two heat sources, and afterwards merged. Splitting of coolant flows is determined by pressure drop characteristic of the two pipes.<br>
<b>Results</b>:<br>
<table>
<tr>
<td valign=\"top\"><b>output</b></td>
<td valign=\"top\"><b>explanation</b></td>
<td valign=\"top\"><b>formula</b></td>
<td valign=\"top\"><b>actual steady-state value</b></td>
</tr>
<tr>
<td valign=\"top\">dTSource1</td>
<td valign=\"top\">Source1 over Ambient</td>
<td valign=\"top\">dTCoolant1 + dTtoPipe1</td>
<td valign=\"top\">15 K</td>
</tr>
<tr>
<td valign=\"top\">dTtoPipe1</td>
<td valign=\"top\">Source1 over Coolant1</td>
<td valign=\"top\">Losses1 / ThermalConductor1.G</td>
<td valign=\"top\"> 5 K</td>
</tr>
<tr>
<td valign=\"top\">dTCoolant1</td>
<td valign=\"top\">Coolant's temperature increase</td>
<td valign=\"top\">Losses * cp * totalMassFlow/2</td>
<td valign=\"top\">10 K</td>
</tr>
<tr>
<td valign=\"top\">dTSource2</td>
<td valign=\"top\">Source2 over Ambient</td>
<td valign=\"top\">dTCoolant2 + dTtoPipe2</td>
<td valign=\"top\">30 K</td>
</tr>
<tr>
<td valign=\"top\">dTtoPipe2</td>
<td valign=\"top\">Source2 over Coolant2</td>
<td valign=\"top\">Losses2 / ThermalConductor2.G</td>
<td valign=\"top\">10 K</td>
</tr>
<tr>
<td valign=\"top\">dTCoolant2</td>
<td valign=\"top\">Coolant's temperature increase</td>
<td valign=\"top\">Losses * cp * totalMassFlow/2</td>
<td valign=\"top\">20 K</td>
</tr>
<tr>
<td valign=\"top\">dTmixedCoolant</td>
<td valign=\"top\">mixed Coolant's temperature increase</td>
<td valign=\"top\">(dTCoolant1+dTCoolant2)/2</td>
<td valign=\"top\">15 K</td>
</tr>
</table>
</HTML>"), Diagram,
        experiment(StopTime=1.0),
        experimentSetupOutput);
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
        "Cooling medium" 
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TAmb=20 
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource1=
        PrescribedHeatFlow1.port.T-Modelica.SIunits.Conversions.from_degC(TAmb) 
        "Source1 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe1=PrescribedHeatFlow1.port.T-Pipe1.heatPort.T 
        "Source1 over Coolant1";
      output Modelica.SIunits.TemperatureDifference dTCoolant1=Pipe1.dT 
        "Coolant1's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTSource2=
        PrescribedHeatFlow2.port.T-Modelica.SIunits.Conversions.from_degC(TAmb) 
        "Source2 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe2=PrescribedHeatFlow2.port.T-Pipe2.heatPort.T 
        "Source2 over Coolant2";
      output Modelica.SIunits.TemperatureDifference dTCoolant2=Pipe2.dT 
        "Coolant2's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTmixedCoolant=Ambient2.T_port-Ambient1.T_port 
        "mixed Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient Ambient1(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[-60,-10; -80,10]);
      FluidHeatFlow.Sources.PrescribedVolumeFlow Pump1(medium=medium, m=0,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[-40,-10; -20,10]);
      FluidHeatFlow.Components.HeatedPipe Pipe1(
        medium=medium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[0,-20; 20,0]);
      FluidHeatFlow.Components.HeatedPipe Pipe2(
        medium=medium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[0,20; 20,0]);
      FluidHeatFlow.Components.IsolatedPipe Pipe3(
        medium=medium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[40,-10; 60,10]);
      FluidHeatFlow.Sources.Ambient Ambient2(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[80,-10; 100,10]);
      Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor1(
        T(start=Modelica.SIunits.Conversions.from_degC(TAmb)), C=0.1) 
        annotation (extent=[50,-70; 30,-50],  rotation=90);
      Modelica.Thermal.HeatTransfer.PrescribedHeatFlow PrescribedHeatFlow1 
        annotation (extent=[-10,-70; -30,-50], rotation=180);
      Modelica.Thermal.HeatTransfer.Convection Convection1 
        annotation (extent=[20,-30; 0,-50], rotation=-90);
      Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor2(
        T(start=Modelica.SIunits.Conversions.from_degC(TAmb)), C=0.1) 
        annotation (extent=[48,70; 28,50],   rotation=90);
      Modelica.Thermal.HeatTransfer.PrescribedHeatFlow PrescribedHeatFlow2 
        annotation (extent=[-10,70; -30,50],rotation=180);
      Modelica.Thermal.HeatTransfer.Convection Convection2 
        annotation (extent=[0,50; 20,30], rotation=90);
      Modelica.Blocks.Sources.Constant VolumeFlow(k=1) 
        annotation (extent=[-60,10; -40,30]);
      Modelica.Blocks.Sources.Constant HeatFlow1(k=5) 
        annotation (extent=[-60,-70; -40,-50]);
      Modelica.Blocks.Sources.Constant HeatFlow2(k=10) 
        annotation (extent=[-60,50; -40,70]);
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
      connect(Pump1.flowPort_b, Pipe2.flowPort_a) 
        annotation (points=[-20,0; -10,0; -10,10; 0,10], style(color=1, rgbcolor={255,0,0}));
      connect(HeatFlow2.y, PrescribedHeatFlow2.Q_flow) 
        annotation (points=[-39,60; -30,60], style(color=3, rgbcolor={0,0,255}));
      connect(HeatFlow1.y, PrescribedHeatFlow1.Q_flow) 
        annotation (points=[-39,-60; -30,-60], style(color=3, rgbcolor={0,0,255}));
      connect(VolumeFlow.y, Pump1.VolumeFlow) 
        annotation (points=[-39,20; -30,20; -30,10], style(color=74, rgbcolor={0,0,127}));
      connect(G2.y, Convection2.Gc) 
        annotation (points=[-9,40; 0,40], style(color=74, rgbcolor={0,0,127}));
      connect(G1.y, Convection1.Gc) annotation (points=[-9,-40; 0,-40], style(
            color=74, rgbcolor={0,0,127}));
      connect(Pipe1.heatPort, Convection1.fluid) annotation (points=[10,-20; 10,
            -30], style(color=42, rgbcolor={191,0,0}));
      connect(Convection2.fluid, Pipe2.heatPort) annotation (points=[10,30; 10,
            20], style(color=42, rgbcolor={191,0,0}));
      connect(Convection2.solid, PrescribedHeatFlow2.port) annotation (points=[10,50;
            10,60; -10,60],        style(color=42, rgbcolor={191,0,0}));
      connect(Convection2.solid, HeatCapacitor2.port) annotation (points=[10,50;
            10,60; 28,60], style(color=42, rgbcolor={191,0,0}));
      connect(Convection1.solid, PrescribedHeatFlow1.port) annotation (points=[10,-50;
            10,-60; -10,-60],         style(color=42, rgbcolor={191,0,0}));
      connect(Convection1.solid, HeatCapacitor1.port) annotation (points=[10,-50;
            10,-60; 30,-60],      style(color=42, rgbcolor={191,0,0}));
      connect(Pipe2.flowPort_b, Pipe3.flowPort_a) annotation (points=[20,10; 30,10;
            30,0; 40,0], style(color=1, rgbcolor={255,0,0}));
      connect(Pipe1.flowPort_b, Pipe3.flowPort_a) annotation (points=[20,-10; 30,
            -10; 30,0; 40,0], style(color=1, rgbcolor={255,0,0}));
      connect(Pipe3.flowPort_b, Ambient2.flowPort) 
        annotation (points=[60,0; 80,0], style(color=1, rgbcolor={255,0,0}));
    end ParallelCooling;
    
    model IndirectCooling "Example: indirect cooling circuit" 
      extends Modelica.Icons.Example;
    annotation (Documentation(info="<HTML>
<p>
3rd test example: IndirectCooling
</p>
A prescribed heat sources dissipates its heat through a thermal conductor to the inner coolant cycle. It is necessary to define the pressure level of the inner coolant cycle. The inner coolant cycle is coupled to the outer coolant flow through a thermal conductor.<br>
Inner coolant's temperature rise near the source is the same as temperature drop near the cooler.<br>
<b>Results</b>:<br>
<table>
<tr>
<td valign=\"top\"><b>output</b></td>
<td valign=\"top\"><b>explanation</b></td>
<td valign=\"top\"><b>formula</b></td>
<td valign=\"top\"><b>actual steady-state value</b></td>
</tr>
<tr>
<td valign=\"top\">dTSource</td>
<td valign=\"top\">Source over Ambient</td>
<td valign=\"top\">dtouterCoolant + dtCooler + dTinnerCoolant + dtToPipe</td>
<td valign=\"top\">40 K</td>
</tr>
<tr>
<td valign=\"top\">dTtoPipe</td>
<td valign=\"top\">Source over inner Coolant</td>
<td valign=\"top\">Losses / ThermalConductor.G</td>
<td valign=\"top\">10 K</td>
</tr>
<tr>
<td valign=\"top\">dTinnerColant</td>
<td valign=\"top\">inner Coolant's temperature increase</td>
<td valign=\"top\">Losses * cp * innerMassFlow</td>
<td valign=\"top\">10 K</td>
</tr>
<tr>
<td valign=\"top\">dTCooler</td>
<td valign=\"top\">Cooler's temperature rise between inner and outer pipes</td>
<td valign=\"top\">Losses * (innerGc + outerGc)</td>
<td valign=\"top\">10 K</td>
</tr>
<tr>
<td valign=\"top\">dTouterColant</td>
<td valign=\"top\">outer Coolant's temperature increase</td>
<td valign=\"top\">Losses * cp * outerMassFlow</td>
<td valign=\"top\">10 K</td>
</tr>
</table>
</HTML>"), Diagram,
        experiment(StopTime=1.5),
        experimentSetupOutput);
      parameter FluidHeatFlow.Media.Medium outerMedium=FluidHeatFlow.Media.Medium() 
        "Outer medium" 
        annotation(choicesAllMatching=true);
      parameter FluidHeatFlow.Media.Medium innerMedium=FluidHeatFlow.Media.Medium() 
        "Inner medium" 
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TAmb=20 
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource=
        PrescribedHeatFlow1.port.T-Modelica.SIunits.Conversions.from_degC(TAmb) 
        "Source over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=PrescribedHeatFlow1.port.T-Pipe1.heatPort.T 
        "Source over inner Coolant";
      output Modelica.SIunits.TemperatureDifference dTinnerCoolant=Pipe1.dT 
        "inner Coolant's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTCooler=innerPipe.heatPort.T-outerPipe.heatPort.T 
        "Cooler's temperature increase between inner and outer pipes";
      output Modelica.SIunits.TemperatureDifference dTouterCoolant=outerPipe.dT 
        "outer Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient Ambient1(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=outerMedium) annotation (extent=[-60,60; -80,80]);
      FluidHeatFlow.Sources.PrescribedVolumeFlow outerPump(
        medium=outerMedium,
        m=0,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[-40,60; -20,80]);
      FluidHeatFlow.Sources.Ambient Ambient2(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=outerMedium) annotation (extent=[40,60; 60,80]);
      Modelica.Thermal.HeatTransfer.ThermalConductor ThermalConductor1(G=1) 
        annotation (extent=[0,-80; 20,-60], rotation=90);
      Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor1(
        T(start=Modelica.SIunits.Conversions.from_degC(TAmb)), C=0.05) 
        annotation (extent=[50,-100; 30,-80],  rotation=90);
      Modelica.Thermal.HeatTransfer.PrescribedHeatFlow PrescribedHeatFlow1 
        annotation (extent=[-10,-100; -30,-80],rotation=180);
      FluidHeatFlow.Components.HeatedPipe Pipe1(
        medium=innerMedium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb),
        V_flowLaminar=1,
        dpLaminar=1000,
        V_flowNominal=2,
        dpNominal=2000) 
        annotation (extent=[20,-50; 0,-30]);
      FluidHeatFlow.Sources.AbsolutePressure AbsolutePressure1(p=10000,
        medium=innerMedium) annotation (extent=[40,-40; 60,-20]);
      FluidHeatFlow.Sources.PrescribedVolumeFlow innerPump(
        medium=innerMedium,
        m=0,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
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
      FluidHeatFlow.Components.HeatedPipe outerPipe(
        medium=outerMedium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[0,60; 20,80]);
      FluidHeatFlow.Components.HeatedPipe innerPipe(
        medium=innerMedium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[0,-10; 20,-30]);
      Modelica.Thermal.HeatTransfer.Convection innerConvection 
        annotation (extent=[20,0; 0,20], rotation=-90);
      Modelica.Thermal.HeatTransfer.Convection outerConvection 
        annotation (extent=[20,50; 0,30], rotation=-90);
    equation 
      connect(Ambient1.flowPort, outerPump.flowPort_a) 
        annotation (points=[-60,70; -40,70], style(color=1, rgbcolor={255,0,0}));
      connect(PrescribedHeatFlow1.port, ThermalConductor1.port_a) 
        annotation (points=[-10,-90; 10,-90; 10,-80],
        style(color=42, rgbcolor={191,0,0}));
      connect(HeatCapacitor1.port, ThermalConductor1.port_a) 
        annotation (points=[30,-90; 10,-90; 10,-80], style(color=42, rgbcolor={191,0,0}));
      connect(Pipe1.heatPort, ThermalConductor1.port_b) 
        annotation (points=[10,-50; 10,-60], style(color=42, rgbcolor={191,0,0}));
      connect(Pipe1.flowPort_b, innerPump.flowPort_a) 
        annotation (points=[0,-40; -20,-40],          style(color=1, rgbcolor={255,0,0}));
      connect(AbsolutePressure1.flowPort, Pipe1.flowPort_a) 
        annotation (points=[40,-30; 40,-40; 20,-40], style(color=1, rgbcolor={255,0,0}));
      connect(HeatFlow.y, PrescribedHeatFlow1.Q_flow) 
        annotation (points=[-39,-90; -30,-90], style(color=3, rgbcolor={0,0,255}));
      connect(outerVolumeFlow.y, outerPump.VolumeFlow)        annotation (
          points=[-39,90; -30,90; -30,80], style(color=74, rgbcolor={0,0,127}));
      connect(innerVolumeFlow.y, innerPump.VolumeFlow)        annotation (
          points=[-39,-30; -30,-30],                                     style(
            color=74, rgbcolor={0,0,127}));
      connect(innerPump.flowPort_b, innerPipe.flowPort_a) 
        annotation (points=[-20,-20; 0,-20], style(color=1, rgbcolor={255,0,0}));
      connect(innerPipe.flowPort_b, AbsolutePressure1.flowPort) annotation (points=
            [20,-20; 40,-20; 40,-30], style(color=1, rgbcolor={255,0,0}));
      connect(outerPump.flowPort_b, outerPipe.flowPort_a) 
        annotation (points=[-20,70; 0,70], style(color=1, rgbcolor={255,0,0}));
      connect(outerPipe.flowPort_b, Ambient2.flowPort) 
        annotation (points=[20,70; 40,70], style(color=1, rgbcolor={255,0,0}));
      connect(outerPipe.heatPort, outerConvection.fluid) 
        annotation (points=[10,60; 10,50], style(color=42, rgbcolor={191,0,0}));
      connect(outerConvection.solid, innerConvection.solid) 
        annotation (points=[10,30; 10,20], style(color=42, rgbcolor={191,0,0}));
      connect(innerConvection.fluid, innerPipe.heatPort) 
        annotation (points=[10,0; 10,-10],  style(color=42, rgbcolor={191,0,0}));
      connect(innerGc.y, innerConvection.Gc) 
        annotation (points=[-19,10; 0,10], style(color=74, rgbcolor={0,0,127}));
      connect(outerGc.y, outerConvection.Gc) 
        annotation (points=[-19,40; 0,40], style(color=74, rgbcolor={0,0,127}));
    end IndirectCooling;
    
    model PumpAndValve "Example: cooling circuit with pump and valve" 
      extends Modelica.Icons.Example;
    annotation (Documentation(info="<HTML>
<p>
4th test example: PumpAndValve
</p>
The pump is running with half speed for 0.4 s, 
afterwards with full speed (using a ramp of 0.1 s).<br> 
The valve is half open for 0.9 s, afterwards full open (using a ramp of 0.1 s).<br>
You may try to:
<ul>
<li>drive the pump with variable speed and let the valve full open 
    to regulate the volume flow rate of coolant</li>
<li>drive the pump with constant speed and throttle the valve 
    to regulate the volume flow rate of coolant</li>
</ul>
</HTML>"), Diagram,
        experiment(StopTime=2),
        experimentSetupOutput);
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
        "Cooling medium" 
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TAmb=20 
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource=
        PrescribedHeatFlow1.port.T-Modelica.SIunits.Conversions.from_degC(TAmb) 
        "Source over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=PrescribedHeatFlow1.port.T-Pipe1.heatPort.T 
        "Source over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=Pipe1.dT 
        "Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient Ambient1(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[-70,-10; -90,10]);
      FluidHeatFlow.Sources.IdealPump IdealPump1(
        medium=medium,
        m=0,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[-60,10; -40,-10]);
      FluidHeatFlow.Components.Valve Valve1(
        medium=medium,
        m=0,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb),
        LinearCharacteristic=false) 
        annotation (extent=[-30,-10; -10,10]);
      FluidHeatFlow.Components.HeatedPipe Pipe1(
        medium=medium,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb),
        m=0.1) 
        annotation (extent=[0,-10; 20,10]);
      FluidHeatFlow.Sources.Ambient Ambient2(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[40,-10; 60,10]);
      Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor1(
        T(start=Modelica.SIunits.Conversions.from_degC(TAmb)), C=0.1) 
        annotation (extent=[50,-60; 30,-40],  rotation=90);
      Modelica.Thermal.HeatTransfer.PrescribedHeatFlow PrescribedHeatFlow1 
        annotation (extent=[-30,-40; -10,-60],rotation=0);
      Modelica.Blocks.Sources.Constant HeatFlow(k=10) 
        annotation (extent=[-60,-60; -40,-40]);
      Modelica.Thermal.HeatTransfer.Convection Convection1 
        annotation (extent=[0,-40; 20,-20], rotation=90);
      Modelica.Blocks.Sources.Constant G(k=1) 
        annotation (extent=[-30,-40; -10,-20]);
      Modelica.Mechanics.Rotational.Speed Speed1(exact=true) 
        annotation (extent=[-60,20; -40,40], rotation=-90);
      Modelica.Blocks.Sources.Ramp speedRamp(
        height=0.5,
        offset=0.5,
        duration=0.1,
        startTime=0.4) annotation (extent=[-80,40; -60,60]);
      Modelica.Blocks.Sources.Ramp valveRamp(
        height=0.5,
        offset=0.5,
        duration=0.1,
        startTime=0.9) annotation (extent=[12,40; -8,60]);
    equation 
      connect(Pipe1.flowPort_b, Ambient2.flowPort) 
        annotation (points=[20,0; 40,0],   style(color=1, rgbcolor={255,0,0}));
      connect(HeatFlow.y, PrescribedHeatFlow1.Q_flow) annotation (points=[-39,
            -50; -30,-50],   style(color=3, rgbcolor={0,0,255}));
      connect(Convection1.solid, PrescribedHeatFlow1.port) annotation (points=[10,-40;
            10,-50; -10,-50],         style(color=42, rgbcolor={191,0,0}));
      connect(Convection1.solid, HeatCapacitor1.port) annotation (points=[10,-40;
            10,-50; 30,-50],      style(color=42, rgbcolor={191,0,0}));
      connect(Pipe1.heatPort, Convection1.fluid) annotation (points=[10,-10; 10,
            -20], style(color=42, rgbcolor={191,0,0}));
      connect(G.y, Convection1.Gc) annotation (points=[-9,-30; 0,-30], style(
            color=74, rgbcolor={0,0,127}));
      connect(Ambient1.flowPort, IdealPump1.flowPort_a) 
        annotation (points=[-70,0; -60,0], style(color=1, rgbcolor={255,0,0}));
      connect(IdealPump1.flowPort_b, Valve1.flowPort_a) 
        annotation (points=[-40,0; -30,0], style(color=1, rgbcolor={255,0,0}));
      connect(Valve1.flowPort_b, Pipe1.flowPort_a) 
        annotation (points=[-10,0; 0,0],style(color=1, rgbcolor={255,0,0}));
      connect(Speed1.flange_b, IdealPump1.flange_a) 
        annotation (points=[-50,20; -50,10], style(color=0, rgbcolor={0,0,0}));
      connect(speedRamp.y, Speed1.w_ref) 
                                     annotation (points=[-59,50; -50,50; -50,42],
          style(color=74, rgbcolor={0,0,127}));
      connect(valveRamp.y, Valve1.y) 
                                 annotation (points=[-9,50; -20,50; -20,9],
                                                                        style(
            color=74, rgbcolor={0,0,127}));
    end PumpAndValve;
    
    model PumpDropOut "Example: cooling circuit with drop out of pump" 
      extends Modelica.Icons.Example;
    annotation (Documentation(info="<HTML>
<p>
5th test example: PumpDropOut
</p>
Same as 1st test example, but with a drop out of the pump:<br>
The pump is running for 0.2 s, then shut down (using a ramp of 0.2 s) for 0.2 s, 
then started again (using a ramp of 0.2 s).
</HTML>"), Diagram,
        experiment(StopTime=2),
        experimentSetupOutput);
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
        "Cooling medium" 
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TAmb=20 
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource=
        PrescribedHeatFlow1.port.T-Modelica.SIunits.Conversions.from_degC(TAmb) 
        "Source over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=PrescribedHeatFlow1.port.T-Pipe1.heatPort.T 
        "Source over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=Pipe1.dT 
        "Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient Ambient1(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[-60,-10; -80,10]);
      FluidHeatFlow.Sources.PrescribedVolumeFlow Pump1(
        medium=medium,
        m=0,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[-40,-10; -20,10]);
      FluidHeatFlow.Components.HeatedPipe Pipe1(
        medium=medium,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb),
        m=0.1) 
        annotation (extent=[0,-10; 20,10]);
      FluidHeatFlow.Sources.Ambient Ambient2(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[40,-10; 60,10]);
      Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor1(
        T(start=Modelica.SIunits.Conversions.from_degC(TAmb)), C=0.1) 
        annotation (extent=[50,-60; 30,-40],  rotation=90);
      Modelica.Thermal.HeatTransfer.PrescribedHeatFlow PrescribedHeatFlow1 
        annotation (extent=[-30,-40; -10,-60], rotation=0);
      Utilities.DoubleRamp VolumeFlow 
        annotation (extent=[-60,10; -40,30]);
      Modelica.Blocks.Sources.Constant HeatFlow(k=10) 
        annotation (extent=[-60,-60; -40,-40]);
      Modelica.Thermal.HeatTransfer.Convection Convection1 
        annotation (extent=[0,-40; 20,-20], rotation=90);
      Modelica.Blocks.Sources.Constant G(k=1) 
        annotation (extent=[-30,-40; -10,-20]);
    equation 
      connect(Ambient1.flowPort, Pump1.flowPort_a) 
        annotation (points=[-60,0; -40,0],   style(color=1, rgbcolor={255,0,0}));
      connect(Pump1.flowPort_b, Pipe1.flowPort_a) 
        annotation (points=[-20,0; 0,0],   style(color=1, rgbcolor={255,0,0}));
      connect(Pipe1.flowPort_b, Ambient2.flowPort) 
        annotation (points=[20,0; 40,0],   style(color=1, rgbcolor={255,0,0}));
      connect(HeatFlow.y, PrescribedHeatFlow1.Q_flow) annotation (points=[-39,
            -50; -30,-50],   style(color=3, rgbcolor={0,0,255}));
      connect(Convection1.solid, PrescribedHeatFlow1.port) annotation (points=[10,-40;
            10,-50; -10,-50],         style(color=42, rgbcolor={191,0,0}));
      connect(Convection1.solid, HeatCapacitor1.port) annotation (points=[10,-40;
            10,-50; 30,-50],      style(color=42, rgbcolor={191,0,0}));
      connect(Pipe1.heatPort, Convection1.fluid) annotation (points=[10,-10; 10,
            -20], style(color=42, rgbcolor={191,0,0}));
      connect(G.y, Convection1.Gc) annotation (points=[-9,-30; 0,-30], style(
            color=74, rgbcolor={0,0,127}));
      connect(VolumeFlow.y, Pump1.VolumeFlow) annotation (points=[-39,20; -30,
            20; -30,10], style(
          color=74,
          rgbcolor={0,0,127},
          fillColor=0,
          rgbfillColor={0,0,0},
          fillPattern=1));
    end PumpDropOut;
    
    model ParallelPumpDropOut 
      "Example: cooling circuit with parallel branches and drop out of pump" 
      extends Modelica.Icons.Example;
    annotation (Documentation(info="<HTML>
<p>
6th test example: ParallelPumpDropOut
</p>
Same as 2nd test example, but with a drop out of the pump:<br>
The pump is running for 0.2 s, then shut down (using a ramp of 0.2 s) for 0.2 s, 
then started again (using a ramp of 0.2 s).
</HTML>"), Diagram,
        experiment(StopTime=2, Algorithm="Lsodar"),
        experimentSetupOutput);
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
        "Cooling medium" 
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TAmb=20 
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource1=
        PrescribedHeatFlow1.port.T-Modelica.SIunits.Conversions.from_degC(TAmb) 
        "Source1 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe1=PrescribedHeatFlow1.port.T-Pipe1.heatPort.T 
        "Source1 over Coolant1";
      output Modelica.SIunits.TemperatureDifference dTCoolant1=Pipe1.dT 
        "Coolant1's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTSource2=
        PrescribedHeatFlow2.port.T-Modelica.SIunits.Conversions.from_degC(TAmb) 
        "Source2 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe2=PrescribedHeatFlow2.port.T-Pipe2.heatPort.T 
        "Source2 over Coolant2";
      output Modelica.SIunits.TemperatureDifference dTCoolant2=Pipe2.dT 
        "Coolant2's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTmixedCoolant=Ambient2.T_port-Ambient1.T_port 
        "mixed Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient Ambient1(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[-60,-10; -80,10]);
      FluidHeatFlow.Sources.PrescribedVolumeFlow Pump1(medium=medium, m=0,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[-40,-10; -20,10]);
      FluidHeatFlow.Components.HeatedPipe Pipe1(
        medium=medium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[0,-20; 20,0]);
      FluidHeatFlow.Components.HeatedPipe Pipe2(
        medium=medium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[0,20; 20,0]);
      FluidHeatFlow.Components.IsolatedPipe Pipe3(
        medium=medium,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb),
        m=0.1) 
        annotation (extent=[40,-10; 60,10]);
      FluidHeatFlow.Sources.Ambient Ambient2(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[80,-10; 100,10]);
      Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor1(
        T(start=Modelica.SIunits.Conversions.from_degC(TAmb)), C=0.1) 
        annotation (extent=[50,-70; 30,-50],  rotation=90);
      Modelica.Thermal.HeatTransfer.PrescribedHeatFlow PrescribedHeatFlow1 
        annotation (extent=[-10,-70; -30,-50], rotation=180);
      Modelica.Thermal.HeatTransfer.Convection Convection1 
        annotation (extent=[20,-30; 0,-50], rotation=-90);
      Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor2(
        T(start=Modelica.SIunits.Conversions.from_degC(TAmb)), C=0.1) 
        annotation (extent=[48,70; 28,50],   rotation=90);
      Modelica.Thermal.HeatTransfer.PrescribedHeatFlow PrescribedHeatFlow2 
        annotation (extent=[-10,70; -30,50],rotation=180);
      Modelica.Thermal.HeatTransfer.Convection Convection2 
        annotation (extent=[0,50; 20,30], rotation=90);
      Utilities.DoubleRamp VolumeFlow 
        annotation (extent=[-60,10; -40,30]);
      Modelica.Blocks.Sources.Constant HeatFlow1(k=5) 
        annotation (extent=[-60,-70; -40,-50]);
      Modelica.Blocks.Sources.Constant HeatFlow2(k=10) 
        annotation (extent=[-60,50; -40,70]);
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
      connect(Pump1.flowPort_b, Pipe2.flowPort_a) 
        annotation (points=[-20,0; -10,0; -10,10; 0,10], style(color=1, rgbcolor={255,0,0}));
      connect(HeatFlow2.y, PrescribedHeatFlow2.Q_flow) 
        annotation (points=[-39,60; -30,60], style(color=3, rgbcolor={0,0,255}));
      connect(HeatFlow1.y, PrescribedHeatFlow1.Q_flow) 
        annotation (points=[-39,-60; -30,-60], style(color=3, rgbcolor={0,0,255}));
      connect(G2.y, Convection2.Gc) 
        annotation (points=[-9,40; 0,40], style(color=74, rgbcolor={0,0,127}));
      connect(G1.y, Convection1.Gc) annotation (points=[-9,-40; 0,-40], style(
            color=74, rgbcolor={0,0,127}));
      connect(Pipe1.heatPort, Convection1.fluid) annotation (points=[10,-20; 10,
            -30], style(color=42, rgbcolor={191,0,0}));
      connect(Convection2.fluid, Pipe2.heatPort) annotation (points=[10,30; 10,
            20], style(color=42, rgbcolor={191,0,0}));
      connect(Convection2.solid, PrescribedHeatFlow2.port) annotation (points=[10,50;
            10,60; -10,60],        style(color=42, rgbcolor={191,0,0}));
      connect(Convection2.solid, HeatCapacitor2.port) annotation (points=[10,50;
            10,60; 28,60], style(color=42, rgbcolor={191,0,0}));
      connect(Convection1.solid, PrescribedHeatFlow1.port) annotation (points=[10,-50;
            10,-60; -10,-60],         style(color=42, rgbcolor={191,0,0}));
      connect(Convection1.solid, HeatCapacitor1.port) annotation (points=[10,-50;
            10,-60; 30,-60],      style(color=42, rgbcolor={191,0,0}));
      connect(Pipe2.flowPort_b, Pipe3.flowPort_a) annotation (points=[20,10; 30,10;
            30,0; 40,0], style(color=1, rgbcolor={255,0,0}));
      connect(Pipe1.flowPort_b, Pipe3.flowPort_a) annotation (points=[20,-10; 30,
            -10; 30,0; 40,0], style(color=1, rgbcolor={255,0,0}));
      connect(Pipe3.flowPort_b, Ambient2.flowPort) 
        annotation (points=[60,0; 80,0], style(color=1, rgbcolor={255,0,0}));
      connect(VolumeFlow.y, Pump1.VolumeFlow) annotation (points=[-39,20; -30,20;
            -30,10], style(color=74, rgbcolor={0,0,127}));
    end ParallelPumpDropOut;
    
    model OneMass "Example: ccoling of one hot mass" 
      extends Modelica.Icons.Example;
    annotation (Documentation(info="<HTML>
<p>
7th test example: OneMass
</p>
A thermal capacity is coupled with a coolant flow. 
Different inital temperatures of thermal capacity and pipe's coolant get ambient's temperature, 
the time behaviour depending on coolant flow.
</HTML>"), Diagram,
        experiment(StopTime=1.0),
        experimentSetupOutput);
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
        "Cooling medium" 
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TAmb=20 
        "Ambient temperature";
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TMass=40 
        "Inital temperature of mass";
      output Modelica.SIunits.TemperatureDifference dTMass=
        HeatCapacitor1.port.T-Modelica.SIunits.Conversions.from_degC(TAmb) 
        "Mass over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=HeatCapacitor1.port.T-Pipe1.heatPort.T 
        "Mass over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=Pipe1.dT 
        "Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient Ambient1(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[-60,-10; -80,10]);
      FluidHeatFlow.Sources.PrescribedVolumeFlow Pump1(
        medium=medium,
        m=0,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[-40,-10; -20,10]);
      FluidHeatFlow.Components.HeatedPipe Pipe1(
        medium=medium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[0,-10; 20,10]);
      FluidHeatFlow.Sources.Ambient Ambient2(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[40,-10; 60,10]);
      Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor1(
        C=0.1, T(start=Modelica.SIunits.Conversions.from_degC(TMass))) 
        annotation (extent=[20,-70; 0,-50],   rotation=180);
      Modelica.Thermal.HeatTransfer.ThermalConductor ThermalConductor1(G=1) 
        annotation (extent=[0,-40; 20,-20], rotation=90);
      Utilities.DoubleRamp DoubleRamp1(
        offset=0,
        height_1=1,
        height_2=-2) annotation (extent=[-60,10; -40,30]);
    equation 
      connect(Ambient1.flowPort, Pump1.flowPort_a) 
        annotation (points=[-60,0; -40,0],   style(color=1, rgbcolor={255,0,0}));
      connect(Pump1.flowPort_b, Pipe1.flowPort_a) 
        annotation (points=[-20,0; 0,0],   style(color=1, rgbcolor={255,0,0}));
      connect(Pipe1.flowPort_b, Ambient2.flowPort) 
        annotation (points=[20,0; 40,0],   style(color=1, rgbcolor={255,0,0}));
      connect(ThermalConductor1.port_a, HeatCapacitor1.port) annotation (points=[10,-40;
            10,-40; 10,-50; 10,-50],        style(color=42, rgbcolor={191,0,0}));
      connect(Pipe1.heatPort, ThermalConductor1.port_b) 
        annotation (points=[10,-10; 10,-20], style(color=42, rgbcolor={191,0,0}));
      connect(DoubleRamp1.y, Pump1.VolumeFlow) annotation (points=[-39,20; -30,20;
            -30,10], style(color=74, rgbcolor={0,0,127}));
    end OneMass;
    
    model TwoMass "Example: cooling of two hot masses" 
      extends Modelica.Icons.Example;
    annotation (Documentation(info="<HTML>
<p>
8th test example: TwoMass
</p>
Two thermal capacities are coupled with two parallel coolant flow. 
Different inital temperatures of thermal capacities and pipe's coolants get ambient's temperature, 
the time behaviour depending on coolant flow.
</HTML>"), Diagram,
        experiment(StopTime=1.0),
        experimentSetupOutput);
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
        "Cooling medium" 
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TAmb=20 
        "Ambient temperature";
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TMass1
        =                                                                       40 
        "Inital temperature of mass1";
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TMass2
        =                                                                       60 
        "Inital temperature of mass2";
      output Modelica.SIunits.TemperatureDifference dTMass1=
        HeatCapacitor1.port.T-Modelica.SIunits.Conversions.from_degC(TAmb) 
        "Mass1 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe1=HeatCapacitor1.port.T-Pipe1.heatPort.T 
        "Mass1 over Coolant1";
      output Modelica.SIunits.TemperatureDifference dTCoolant1=Pipe1.dT 
        "Coolant1's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTMass2=
        HeatCapacitor2.port.T-Modelica.SIunits.Conversions.from_degC(TAmb) 
        "Mass2 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe2=HeatCapacitor2.port.T-Pipe2.heatPort.T 
        "Mass2 over Coolant2";
      output Modelica.SIunits.TemperatureDifference dTCoolant2=Pipe2.dT 
        "Coolant2's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTmixedCoolant=Ambient2.T_port-Ambient1.T_port 
        "mixed Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient Ambient1(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[-60,-10; -80,10]);
      FluidHeatFlow.Sources.PrescribedVolumeFlow Pump1(medium=medium, m=0,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[-40,-10; -20,10]);
      FluidHeatFlow.Components.HeatedPipe Pipe1(
        medium=medium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[0,-20; 20,0]);
      FluidHeatFlow.Components.HeatedPipe Pipe2(
        medium=medium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[0,20; 20,0]);
      FluidHeatFlow.Components.IsolatedPipe Pipe3(
        medium=medium,
        m=0.1,
        T0=Modelica.SIunits.Conversions.from_degC(TAmb)) 
        annotation (extent=[40,-10; 60,10]);
      FluidHeatFlow.Sources.Ambient Ambient2(T_Ambient=Modelica.SIunits.Conversions.from_degC(TAmb),
        medium=medium) 
        annotation (extent=[80,-10; 100,10]);
      Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor1(
                                                               C=0.1, T(start=
              Modelica.SIunits.Conversions.from_degC(TMass1))) 
        annotation (extent=[20,-80; 0,-60],   rotation=180);
      Modelica.Thermal.HeatTransfer.ThermalConductor ThermalConductor1(G=1) 
        annotation (extent=[0,-50; 20,-30], rotation=90);
      Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor2(
                                                               C=0.1, T(start=
              Modelica.SIunits.Conversions.from_degC(TMass2))) 
        annotation (extent=[20,80; 0,60],    rotation=180);
      Modelica.Thermal.HeatTransfer.ThermalConductor ThermalConductor2(G=1) 
        annotation (extent=[0,50; 20,30],   rotation=90);
      Utilities.DoubleRamp DoubleRamp1(
        offset=0,
        height_1=1,
        height_2=-2) annotation (extent=[-60,10; -40,30]);
    equation 
      connect(Ambient1.flowPort, Pump1.flowPort_a) 
        annotation (points=[-60,0; -40,0], style(color=1, rgbcolor={255,0,0}));
      connect(Pump1.flowPort_b, Pipe1.flowPort_a) 
        annotation (points=[-20,0; -10,0; -10,-10; 0,-10],
        style(color=1, rgbcolor={255,0,0}));
      connect(Pump1.flowPort_b, Pipe2.flowPort_a) 
        annotation (points=[-20,0; -10,0; -10,10; 0,10], style(color=1, rgbcolor={255,0,0}));
      connect(Pipe2.flowPort_b, Pipe3.flowPort_a) annotation (points=[20,10; 30,10;
            30,0; 40,0], style(color=1, rgbcolor={255,0,0}));
      connect(Pipe1.flowPort_b, Pipe3.flowPort_a) annotation (points=[20,-10; 30,
            -10; 30,0; 40,0], style(color=1, rgbcolor={255,0,0}));
      connect(Pipe3.flowPort_b, Ambient2.flowPort) 
        annotation (points=[60,0; 80,0], style(color=1, rgbcolor={255,0,0}));
      connect(HeatCapacitor2.port, ThermalConductor2.port_a) annotation (points=[10,60;
            10,55.5; 10,50; 10,50],   style(color=42, rgbcolor={191,0,0}));
      connect(ThermalConductor2.port_b, Pipe2.heatPort) 
        annotation (points=[10,30; 10,20], style(color=42, rgbcolor={191,0,0}));
      connect(Pipe1.heatPort, ThermalConductor1.port_b) annotation (points=[10,-20;
            10,-30],         style(color=42, rgbcolor={191,0,0}));
      connect(ThermalConductor1.port_a, HeatCapacitor1.port) annotation (points=[10,-50;
            10,-50; 10,-60; 10,-60],
                                  style(color=42, rgbcolor={191,0,0}));
      connect(DoubleRamp1.y, Pump1.VolumeFlow) annotation (points=[-39,20; -30,
            20; -30,10], style(color=74, rgbcolor={0,0,127}));
    end TwoMass;
    
    package Utilities "Utility models for examples" 
      extends Modelica.Icons.Library;
      annotation (Documentation(info="<html>
This package contains utility components used for the test examples.<br>
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
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2007, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.41 Beta 2005/06/17 Anton Haumer<br>
       first used</li>
  </ul>
</HTML>"));
      
      model DoubleRamp "Ramp going up and down" 
        extends Modelica.Blocks.Interfaces.SO;
        parameter Real offset=1 "Offset of ramps";
        parameter Modelica.SIunits.Time startTime=0.2 "StartTime of 1st ramp";
        parameter Modelica.SIunits.Time interval=0.2 
          "Interval between end of 1st and beginning of 2nd ramp";
        parameter Real height_1=-1 "Height of ramp" 
          annotation(Dialog(group="Ramp 1"));
        parameter Modelica.SIunits.Time duration_1(min=Modelica.Constants.small) = 0.2 
          "Duration of ramp" 
          annotation(Dialog(group="Ramp 1"));
        parameter Real height_2=1 "Height of ramp" 
          annotation(Dialog(group="Ramp 2"));
        parameter Modelica.SIunits.Time duration_2(min=Modelica.Constants.small) = 0.2 
          "Duration of ramp" 
          annotation(Dialog(group="Ramp 2"));
        annotation (
          Documentation(info="<HTML>
Block generating the sum of two ramps.
</HTML>"),Diagram,
          Icon(
            Line(points=[-80,68; -80,-80],   style(color=8)),
            Polygon(points=[-80,90; -88,68; -72,68; -80,90],     style(color=8,
                   fillColor=8)),
            Line(points=[-90,-70; 82,-70],   style(color=8)),
            Polygon(points=[90,-70; 68,-62; 68,-78; 90,-70],     style(
                color=8,
                fillColor=8,
                fillPattern=1)),
               Line(points=[-80,-60; -50,-60; -30,60; 10,60; 30,-20; 70,-20],
                style(
                color=0,
                rgbcolor={0,0,0},
                fillColor=0,
                rgbfillColor={0,0,0}))));
        Modelica.Blocks.Math.Add Add1 annotation (extent=[10,-10; 30,10]);
        Modelica.Blocks.Sources.Ramp Ramp1(
          final height=height_1,
          final duration=duration_1,
          final startTime=startTime,
          final offset=offset) 
                         annotation (extent=[-30,10; -10,30]);
        Modelica.Blocks.Sources.Ramp Ramp2(
          final height=height_2,
          final duration=duration_2,
          final startTime=startTime + duration_1 + interval,
          final offset=0) 
          annotation (extent=[-30,-30; -10,-10]);
      equation 
        connect(Ramp1.y,Add1. u1) annotation (points=[-9,20; 0,20; 0,6; 8,6],
                   style(color=74, rgbcolor={0,0,127}));
        connect(Ramp2.y,Add1. u2) annotation (points=[-9,-20; 0,-20; 0,-6; 8,-6],
                   style(color=74, rgbcolor={0,0,127}));
        connect(Add1.y, y) annotation (points=[31,0; 110,0], style(color=74,
              rgbcolor={0,0,127}));
      end DoubleRamp;
    end Utilities;
  end Examples;
  
  package Components "Basic components (pipes, valves)" 
    extends Modelica.Icons.Library2;
  annotation (Documentation(info="<HTML>
This package contains components:
<ul>
<li>pipe without heat exchange</li>
<li>pipe with heat exchange</li>
<li>valve (simple controlled valve)</li>
</ul>
Pressure drop is taken from partial model SimpleFriction.<br>
Thermodynamic equations are defined in partial models (package Partials).<br>
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
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2007, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.20 Beta 2005/02/18 Anton Haumer<br>
       introduced geodetic height in Components.Pipes<br>
       <i>new models: Components.Valve</i></li>
  <li> v1.30 Beta 2005/06/02 Anton Haumer<br>
       friction losses are fed to medium</li>
  </ul>
</HTML>
"), Icon(
        Polygon(points=[-56,10; -56,-90; -6,-40; 44,10; 44,-90; -56,10], style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=69,
            rgbfillColor={0,128,255},
            fillPattern=1)),
        Polygon(points=[-16,10; 4,10; -6,-10; -16,10], style(
            color=74,
            rgbcolor={0,0,127},
            fillColor=74,
            rgbfillColor={0,0,127},
            fillPattern=1)),
        Line(points=[-6,-10; -6,-40; -6,-38], style(
            color=74,
            rgbcolor={0,0,127},
            fillColor=3,
            rgbfillColor={0,0,255},
            fillPattern=1))));
    
    model IsolatedPipe "Pipe without heat exchange" 
      
    annotation (Documentation(info="<HTML>
Pipe without heat exchange.<br>
Thermodynamic equations are defined by Partials.TwoPortMass(Q_flow = 0).<br>
<b>Note:</b> Setting parameter m (mass of medium within pipe) to zero
leads to neglection of temperature transient cv*m*der(T).
</HTML>"),
      Icon(Rectangle(extent=[-90, 20; 90, -20], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=3,
              rgbfillColor={0,0,255})),
              Text(extent=[-150,100; 150,40], string="%name")), Diagram);
      extends Interfaces.Partials.TwoPort(final tapT=1);
      extends Interfaces.Partials.SimpleFriction;
      parameter Modelica.SIunits.Length h_g=0 
        "Geodetic height (heigth difference from flowPort_a to flowPort_b)";
    equation 
      // coupling with FrictionModel
      VolumeFlow = V_flow;
      dp = pressureDrop + medium.rho*Modelica.Constants.g_n*h_g;
      // no energy exchange with medium
      Q_flow = Q_friction;
    end IsolatedPipe;
    
    model HeatedPipe "Pipe with heat exchange" 
      
    annotation (Documentation(info="<HTML>
Pipe with heat exchange.<br>
Thermodynamic equations are defined by Partials.TwoPort.<br>
Q_flow is defined by heatPort.Q_flow.<br>
<b>Note:</b> Setting parameter m (mass of medium within pipe) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
<b>Note:</b> Injecting heat into a pipe with zero massflow causes 
temperature rise defined by storing heat in medium's mass.
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
      parameter Modelica.SIunits.Length h_g=0 
        "Geodetic height (heigth difference from flowPort_a to flowPort_b)";
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort 
        annotation (extent=[-10,-110; 10,-90]);
    equation 
      // coupling with FrictionModel
      VolumeFlow = V_flow;
      dp = pressureDrop + medium.rho*Modelica.Constants.g_n*h_g;
      // energy exchange with medium
      Q_flow = heatPort.Q_flow + Q_friction;
      // defines heatPort's temperature
      heatPort.T = T_q;
    end HeatedPipe;
    
    model Valve "Simple valve" 
      
    annotation (Documentation(info="<HTML>
Simple controlled valve.<br>
Standard characteristic Kv=<i>f </i>(y) is given at standard conditions (dp0, rho0),<br> 
<tt>
<ul>
<li>either linear : Kv/Kv1 = Kv0/Kv1 + (1-Kv0/Kv1) * y/Y1</li>
<li>or exponential: Kv/Kv1 = Kv0/Kv1 * exp[ln(Kv1/Kv0) * y/Y1]</li>
</ul>
where:
<ul>
<li>Kv0 ... min. flow @ y = 0</li>
<li>Y1 .... max. valve opening</li>
<li>Kv1 ... max. flow @ y = Y1</li>
</ul>
</tt>
Flow resistance under real conditions is calculated by<br>
<tt>V_flow**2 * rho / dp = Kv(y)**2 * rho0 / dp0</tt>
</HTML>"),
      Icon(   Text(extent=[-150,-60; 150,-120], string="%name"),
          Polygon(points=[-90,10; -60,10; -60,60; 0,0; 60,60; 60,10; 90,10; 90,-10;
                60,-10; 60,-60; 0,0; -60,-60; -60,-10; -90,-10; -90,10], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Line(points=[0,80; 0,0], style(
              color=74,
              rgbcolor={0,0,127},
              fillColor=3,
              rgbfillColor={0,0,255},
              fillPattern=1))), Diagram);
      extends Interfaces.Partials.TwoPort(m=0, final tapT=1);
      parameter Boolean LinearCharacteristic=true "Type of characteristic" 
        annotation(Dialog(group="Standard characteristic"), choices(choice=true "Linear", choice=false 
            "Exponential"));
      parameter Real y1(min=small)=1 "Max. valve opening" 
        annotation(Dialog(group="Standard characteristic"));
      parameter Modelica.SIunits.VolumeFlowRate Kv1(min=small)=1 
        "Max. flow @ y = y1" 
        annotation(Dialog(group="Standard characteristic"));
      parameter Real kv0(min=small,max=1-small)=0.01 
        "Leakage flow / max.flow @ y = 0" 
        annotation(Dialog(group="Standard characteristic"));
      parameter Modelica.SIunits.Pressure dp0=1 "Standard pressure drop" 
        annotation(Dialog(group="Standard characteristic"));
      parameter Modelica.SIunits.Density rho0 = 10 "Standard medium's density" 
        annotation(Dialog(group="Standard characteristic"));
      parameter Real frictionLoss(min=0, max=1) = 0 
        "Part of friction losses fed to medium";
    protected 
      constant Modelica.SIunits.VolumeFlowRate unitVolumeFlowRate = 1;
      constant Real small = Modelica.Constants.small;
      constant Modelica.SIunits.VolumeFlowRate smallVolumeFlowRate = eps*unitVolumeFlowRate;
      constant Real eps = Modelica.Constants.eps;
      Real yLim = max(min(y,y1),0) "Limited valve opening";
      Modelica.SIunits.VolumeFlowRate Kv "Standard flow rate";
    public 
      Modelica.Blocks.Interfaces.RealInput y 
        annotation (extent=[-10,80; 10,100], rotation=-90);
    initial algorithm 
      assert(y1>small, "Valve characteristic: y1 has to be > 0 !");
      assert(Kv1>smallVolumeFlowRate, "Valve characteristic: Kv1 has to be > 0 !");
      assert(kv0>small, "Valve characteristic: kv0 has to be > 0 !");
      assert(kv0<1-eps, "Valve characteristic: kv0 has to be < 1 !");
    equation 
      // evaluate standard characteristic
      Kv/Kv1 = if LinearCharacteristic then (kv0 + (1-kv0)*yLim/y1) else kv0*exp(ln(1/kv0)*yLim/y1);
      // pressure drop under real conditions
      dp/dp0 = medium.rho/rho0*(V_flow/Kv)*abs(V_flow/Kv);
      // no energy exchange with medium
      Q_flow = frictionLoss*V_flow*dp;
    end Valve;
  end Components;
  
  package Interfaces "Connectors and partial models" 
    extends Modelica.Icons.Library2;
  annotation (Documentation(info="<HTML>
This package contains connectors and partial models:
<ul>
<li>FlowPort: basic definition of the connector.</li>
<li>FlowPort_a & FlowPort_b: same as FlowPort with different icons to differentiate direction of flow</li>
<li>package Partials (defining basic thermodynamic equations)</li>
</ul>
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
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2007, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.10 2005/02/15 Anton Haumer<br>
       moved Partials into Interfaces</li>
  <li> v1.11 2005/02/18 Anton Haumer<br>
       corrected usage of cv and cp</li>
  <li> v1.30 Beta 2005/06/02 Anton Haumer<br>
       friction losses are fed to medium</li>
  <li> v1.33 Beta 2005/06/07 Anton Haumer<br>
       corrected usage of simpleFlow</li>
  <li> v1.43 Beta 2005/06/20 Anton Haumer<br>
       Test of mixing / semiLinear</li>
  <li> v1.50 2005/09/07 Anton Haumer<br>
       semiLinear works fine</li>
  </ul>
</HTML>
"), Icon(Rectangle(extent=[-60,10; 40,-90], style(color=1, rgbcolor={255,0,0})),
          Ellipse(extent=[-58,8; 38,-88],  style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=3,
            rgbfillColor={0,0,255},
            fillPattern=1))));
    
    connector FlowPort "conector flow port" 
      
    annotation (Documentation(info="<HTML>
Basic definition of the connector.<br>
<b>Variables:</b>
<ul>
<li>Pressure p</li>
<li>flow MassFlowRate m_flow</li>
<li>Specific Enthalpy h</li>
<li>flow EnthaplyFlowRate H_flow</li>
</ul>
If ports with different media are connected, the simulation is asserted due to the check of parameter.
</HTML>"));
      parameter FluidHeatFlow.Media.Medium medium "Medium in the connector";
      Modelica.SIunits.Pressure p;
      flow Modelica.SIunits.MassFlowRate m_flow;
      Modelica.SIunits.SpecificEnthalpy h;
      flow Modelica.SIunits.EnthalpyFlowRate H_flow;
    end FlowPort;
    
    connector FlowPort_a "Filled flow port (used upstream)" 
      
    annotation (Documentation(info="<HTML>
Same as FlowPort, but icon allows to differentiate direction of flow.
</HTML>"),
      Icon(Rectangle(extent=[-100, 100; 100, -100], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255})), Ellipse(extent=[-98,98; 98,-98],
              style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255}))),     Diagram(Rectangle(extent=[-50,50;
                50,-50],         style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255})), Ellipse(extent=[-48,48; 48,-48],
              style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255})),
                                Text(
            extent=[-100,110; 100,50],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))));
      extends FlowPort;
    end FlowPort_a;
    
    connector FlowPort_b "Hollow flow port (used downstream)" 
      
    annotation (Documentation(info="<HTML>
Same as FlowPort, but icon allows to differentiate direction of flow.
</HTML>"),
      Icon(Rectangle(extent=[-100,100; 100,-100],   style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255})), Ellipse(extent=[-98,98; 98,-98],
              style(color=3, rgbcolor={0,0,255}))),
                                             Diagram(Rectangle(extent=[-50,50;
                50,-50],         style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255})), Ellipse(extent=[-48,48; 48,-48],
              style(color=3, rgbcolor={0,0,255})),
                                Text(
            extent=[-100,110; 100,50],
            string="%name",
            style(color=3, rgbcolor={0,0,255}))));
      extends FlowPort;
    end FlowPort_b;
    
    package Partials "Partial models" 
      extends Modelica.Icons.Library;
    annotation (Documentation(info="<HTML>
This package contains partial models, defining in a very compact way the basic thermodynamic equations used by the different components.<br>
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
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2007, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>",revisions="<HTML>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.10 2005/02/15 Anton Haumer<br>
       moved Partials into Interfaces</li>
  <li> v1.11 2005/02/18 Anton Haumer<br>
       corrected usage of cv and cp</li>
  <li> v1.30 Beta 2005/06/02 Anton Haumer<br>
       friction losses are fed to medium</li>
  <li> v1.31 Beta 2005/06/04 Anton Haumer<br>
       searching solution for problems @ m_flow=0</li>
  <li> v1.33 Beta 2005/06/07 Anton Haumer<br>
       corrected usage of simpleFlow</li>
  <li> v1.43 Beta 2005/06/20 Anton Haumer<br>
       Test of mixing / semiLinear</li>
  <li> v1.50 2005/09/07 Anton Haumer<br>
       semiLinear works fine<br>
       removed test-version of semiLinear</li>
  <li> v1.60 2007/01/23 Anton Haumer<br>
       new parameter tapT defining Temperature of heatPort</li>
  </ul>
</HTML>
"));
      
      partial model SimpleFriction "Simple friction model" 
        
      annotation (Documentation(info="<HTML>
Definition of relationship between pressure drop and volume flow rate:<br>
-V_flowLaminar &lt; VolumeFlow &lt; +V_flowLaminar: laminar i.e. linear dependency of pressure drop on volume flow.<br>
-V_flowLaminar &gt; VolumeFlow or VolumeFlow &lt; +V_flowLaminar: turbulent i.e. quadratic dependency of pressure drop on volume flow.<br>
Linear and quadratic dependency are coupled smoothly at V_flowLaminar / dpLaminar.<br>
Quadratic dependency is defined by nominal volume flow and pressure drop (V_flowNominal / dpNominal).<br>
See also sketch at diagram layer.
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
        parameter Modelica.SIunits.VolumeFlowRate V_flowLaminar(min=Modelica.Constants.small)=0.1 
          "Laminar volume flow" 
          annotation(Dialog(group="Simple Friction"));
        parameter Modelica.SIunits.Pressure dpLaminar=0.1 
          "Laminar pressure drop" 
          annotation(Dialog(group="Simple Friction"));
        parameter Modelica.SIunits.VolumeFlowRate V_flowNominal=1 
          "Nominal volume flow" 
          annotation(Dialog(group="Simple Friction"));
        parameter Modelica.SIunits.Pressure dpNominal=1 "Nominal pressure drop"
          annotation(Dialog(group="Simple Friction"));
        parameter Real frictionLoss(min=0, max=1) = 0 
          "Part of friction losses fed to medium" 
          annotation(Dialog(group="Simple Friction"));
        Modelica.SIunits.Pressure pressureDrop;
        Modelica.SIunits.VolumeFlowRate VolumeFlow;
        Modelica.SIunits.Power Q_friction;
      protected 
        parameter Modelica.SIunits.Pressure dpNomMin=dpLaminar/V_flowLaminar*V_flowNominal;
        parameter Real k(final unit="Pa.s2/m6", fixed=false);
      initial algorithm 
        assert(V_flowNominal>V_flowLaminar,
          "SimpleFriction: V_flowNominal has to be > V_flowLaminar!");
        assert(dpNominal>=dpNomMin,
          "SimpleFriction: dpNominal has to be > dpLaminar/V_flowLaminar*V_flowNominal!");
        k:=(dpNominal - dpNomMin)/(V_flowNominal - V_flowLaminar)^2;
      equation 
        if     VolumeFlow > +V_flowLaminar then
          pressureDrop = +dpLaminar/V_flowLaminar*VolumeFlow + k*(VolumeFlow - V_flowLaminar)^2;
        elseif VolumeFlow < -V_flowLaminar then
          pressureDrop = +dpLaminar/V_flowLaminar*VolumeFlow - k*(VolumeFlow + V_flowLaminar)^2;
        else
          pressureDrop =  dpLaminar/V_flowLaminar*VolumeFlow;
        end if;
        Q_friction = frictionLoss*VolumeFlow*pressureDrop;
      end SimpleFriction;
      
      partial model TwoPort "Partial model of two port" 
        
      annotation (Documentation(info="<HTML>
Partial model with two flowPorts.<br>
Possible heat exchange with the ambient is defined by Q_flow; setting this = 0 means no energy exchange.<br>
Setting parameter m (mass of medium within pipe) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
Mixing rule is applied.<br>
Parameter 0 &lt; tapT &lt; 1 defines temperature of heatPort between medium's inlet and outlet temperature.
</HTML>"));
        parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
          "Medium in the component" 
          annotation(choicesAllMatching=true);
        parameter Modelica.SIunits.Mass m=1 "Mass of medium";
        parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20) 
          "Initial temperature of medium" 
          annotation(Dialog(enable=m>Modelica.Constants.small));
        parameter Real tapT(final min=0, final max=1)=1 
          "Defines temperature of heatPort between inlet and outlet temperature";
        Modelica.SIunits.Pressure dp=flowPort_a.p - flowPort_b.p 
          "Pressure drop a->b";
        Modelica.SIunits.VolumeFlowRate V_flow=flowPort_a.m_flow/medium.rho 
          "Volume flow a->b";
        Modelica.SIunits.HeatFlowRate Q_flow "Heat exchange with ambient";
        output Modelica.SIunits.Temperature T(start=T0) 
          "Outlet temperature of medium";
        output Modelica.SIunits.Temperature T_a=flowPort_a.h/medium.cp 
          "Temperature at flowPort_a";
        output Modelica.SIunits.Temperature T_b=flowPort_b.h/medium.cp 
          "Temperature at flowPort_b";
        output Modelica.SIunits.TemperatureDifference dT=if noEvent(V_flow>=0) then T-T_a else T_b-T 
          "Temperature increase of coolant in flow direction";
      protected 
        Modelica.SIunits.SpecificEnthalpy h = medium.cp*T 
          "Medium's specific enthalpy";
        Modelica.SIunits.Temperature T_q = T  - noEvent(sign(V_flow))*(1 - tapT)*dT 
          "Temperature relevant for heat exchange with ambient";
      public 
        Interfaces.FlowPort_a flowPort_a(final medium=medium) 
          annotation (extent=[-110, -10; -90, 10]);
        Interfaces.FlowPort_b flowPort_b(final medium=medium) 
          annotation (extent=[90, -10; 110, 10]);
      equation 
        // mass balance
        flowPort_a.m_flow + flowPort_b.m_flow = 0;
        // energy balance
        if m>Modelica.Constants.small then
          flowPort_a.H_flow + flowPort_b.H_flow + Q_flow = m*medium.cv*der(T);
        else
          flowPort_a.H_flow + flowPort_b.H_flow + Q_flow = 0;
        end if;
        // massflow a->b mixing rule at a, energy flow at b defined by medium's temperature
        // massflow b->a mixing rule at b, energy flow at a defined by medium's temperature
        flowPort_a.H_flow = semiLinear(flowPort_a.m_flow,flowPort_a.h,h);
        flowPort_b.H_flow = semiLinear(flowPort_b.m_flow,flowPort_b.h,h);
      end TwoPort;
      
      partial model Ambient "Partial model of ambient" 
        
      annotation (Documentation(info="<HTML>
<p>
Partial model of (Infinite) ambient, defines pressure and temperature.
</p>
</HTML>"),   Icon(
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
          "Ambient's medium" 
          annotation(choicesAllMatching=true);
        output Modelica.SIunits.Temperature T "Outlet temperature of medium";
        output Modelica.SIunits.Temperature T_port=flowPort.h/medium.cp 
          "Temperature at flowPort_a";
      protected 
        Modelica.SIunits.SpecificEnthalpy h = medium.cp*T;
      public 
        Interfaces.FlowPort_a flowPort(final medium=medium) 
          annotation (extent=[-110,-10; -90,10]);
      equation 
        // massflow -> ambient: mixing rule
        // massflow <- ambient: energy flow defined by ambient's temperature
        flowPort.H_flow = semiLinear(flowPort.m_flow,flowPort.h,h);
      end Ambient;
      
      partial model AbsoluteSensor "Partial model of absolute sensor" 
        
      annotation (Documentation(info="<HTML>
Partial model for an absolute sensor (pressure/temperature).<br>
Pressure, mass flow, temperature and enthalpy flow of medium are not affected.
</HTML>"));
        parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
          "Sensor's medium" 
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
      
      partial model RelativeSensor "Partial model of relative sensor" 
        
      annotation (Documentation(info="<HTML>
Partial model for a relative sensor (pressure drop/temperature difference).<br>
Pressure, mass flow, temperature and enthalpy flow of medium are not affected.
</HTML>"));
        parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
          "Sensor's medium" 
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
      
      partial model FlowSensor "Partial model of flow sensor" 
        
      annotation (Documentation(info="<HTML>
Partial model for a flow sensor (mass flow/heat flow).<br>
Pressure, mass flow, temperature and enthalpy flow of medium are not affected, but mixing rule is applied.
</HTML>"));
        extends TwoPort(final m=0, final T0=0, final tapT=1);
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
  
  package Media "Medium properties" 
    extends Modelica.Icons.Library2;
  annotation (Documentation(info="<HTML>
This package contains definitions of medium properties.<br>
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
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2007, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.11 2005/02/18 Anton Haumer<br>
       corrected usage of cv and cp</li>
  </ul>
</HTML>
"), Icon(
        Rectangle(extent=[-80,8; 60,-88],  style(
            color=74,
            rgbcolor={0,0,127},
            fillColor=71,
            rgbfillColor={85,170,255})),
        Line(points=[-10,8; -10,-88; -10,-88],  style(
            color=74,
            rgbcolor={0,0,127},
            fillPattern=1)),
        Line(points=[-80,-24; 60,-24], style(
            color=74,
            rgbcolor={0,0,127},
            fillPattern=1)),
        Line(points=[-80,-56; 60,-56], style(
            color=74,
            rgbcolor={0,0,127},
            fillPattern=1))));
    
    record Medium "Record containing media properties" 
      extends Modelica.Icons.Record;
      parameter Modelica.SIunits.Density rho = 1 "Density";
      parameter Modelica.SIunits.SpecificHeatCapacity cp = 1 
        "Specific heat capacity at constant pressure";
      parameter Modelica.SIunits.SpecificHeatCapacity cv = 1 
        "Specific heat capacity at constant volume";
      parameter Modelica.SIunits.ThermalConductivity lamda = 1 
        "Thermal conductivity";
      parameter Modelica.SIunits.KinematicViscosity nue = 1 
        "kinematic viscosity";
      annotation (Documentation(info="<html>
Record containing (constant) medium properties.
</html>"));
    end Medium;
    
    record Air_30degC "Medium: propeties of air at 30 degC" 
    extends Medium(
      rho=1.149,
      cp=1007,
      cv= 720,
      lamda=0.0264,
      nue=16.3E-6);
      annotation (Documentation(info="<html>
Medium: propeties of air at 30 degC
</html>"));
    end Air_30degC;
    
    record Air_70degC "Medium: propeties of air at 70 degC" 
    extends Medium(
      rho=1.015,
      cp=1010,
      cv= 723,
      lamda=0.0293,
      nue=20.3E-6);
      annotation (Documentation(info="<html>
Medium: propeties of air at 70 degC
</html>"));
    end Air_70degC;
    
    record Water "Medium: propeties of water" 
    extends Medium(
      rho=995.6,
      cp=4177,
      cv=4177,
      lamda=0.615,
      nue=0.8E-6);
      annotation (Documentation(info="<html>
Medium: propeties of water
</html>"));
    end Water;
  end Media;
  
  package Sensors "Ideal sensors to measure port properties" 
    extends Modelica.Icons.Library2;
  annotation (Documentation(info="<HTML>
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
Some of the sensors do not need access to medium properties for measuring, 
but it is necessary to define the medium in the connector (check of connections).<br>
Thermodynamic equations are defined in partial models (package Interfaces.Partials).<br>
All sensors are considered massless, they do not change mass flow or enthalpy flow.<br>
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
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2007, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  </ul>
</HTML>
"), Icon(
        Ellipse(extent=[-60,10; 40,-90], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=7,
            rgbfillColor={255,255,255})),
        Line(points=[-10,7; -10,-10],
                                  style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Line(points=[-50,-16; -36,-25],
                                      style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Line(points=[30,-15; 16,-25],
                                    style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Line(points=[-35,0; -25,-14], style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Line(points=[15,0; 5,-14],  style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Ellipse(extent=[-15,-35; -5,-45],
                                       style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-10,-40; -6,-26],  style(color=0)),
        Polygon(points=[-12,-24; -0.5,-27; 2,1.5; -12,-24],          style(
            color=0,
            fillColor=0,
            fillPattern=1))));
    
    model pSensor "Absolute pressure sensor" 
      
    annotation (Documentation(info="<HTML>
pSensor measures the absolute pressure.<br>
Thermodynamic equations are defined by Partials.AbsoluteSensor.
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
    
    model TSensor "Absolute temperature sensor" 
      
    annotation (Documentation(info="<HTML>
TSensor measures the absolute temperature (Kelvin).<br>
Thermodynamic equations are defined by Partials.AbsoluteSensor.
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
    
    model dpSensor "Pressure difference sensor" 
      
    annotation (Documentation(info="<HTML>
dpSensor measures the pressure drop between flowPort_a and flowPort_b.<br>
Thermodynamic equations are defined by Partials.RelativeSensor.
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
    
    model dTSensor "Temperature difference sensor" 
      
    annotation (Documentation(info="<HTML>
dTSensor measures the temperature difference between flowPort_a and flowPort_b.<br>
Thermodynamic equations are defined by Partials.RelativeSensor.<br>
<b>Note:</b> Connected flowPorts have the same temperature (mixing temperature)!<br>
Since mixing my occur, the outlet temperature of a component may be different from the connector's temperature.<br> 
Outlet temperature is defined by variable T of the corresponding component.
</HTML>"), Diagram);
      extends Interfaces.Partials.RelativeSensor(y(redeclare type SignalType = 
              Modelica.SIunits.TemperatureDifference));
    equation 
      medium.cp*y = flowPort_a.h - flowPort_b.h;
      annotation(Icon(Text(
            extent=[-22,-20; 20,-60],
            style(color=3, rgbcolor={0,0,255}),
            string="dT")));
    end dTSensor;
    
    model m_flowSensor "Mass flow sensor" 
      
    annotation (Documentation(info="<HTML>
m_flowSensor measures the mass flow rate.<br>
Thermodynamic equations are defined by Partials.FlowSensor.
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
    
    model V_flowSensor "Volume flow sensor" 
      
    annotation (Documentation(info="<HTML>
V_flowSensor measures the volume flow rate.<br>
Thermodynamic equations are defined by Partials.FlowSensor.
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
    
    model H_flowSensor "Enthapy flow sensor" 
      
    annotation (Documentation(info="<HTML>
H_flowSensor measures the enthalpy flow rate.<br>
Thermodynamic equations are defined by Partials.FlowSensor.
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
  
  package Sources "Ideal fluid sources, e.g., ambient, volume flow" 
    extends Modelica.Icons.Library2;
  annotation (Documentation(info="<HTML>
This package contains different types of sources:
<ul>
<li>Ambient with constant pressure and temperature</li>
<li>Ambient with prescribed pressure and temperature</li>
<li>AbsolutePressure to define pressure level of a closed cooling cycle.</li>
<li>Constant and prescribed volume flow</li>
<li>Constant and prescribed pressure increase</li>
<li>Simple pump with mechanical flange</li>
</ul>
Thermodynamic equations are defined in partial models (package Interfaces.Partials).<br>
All fans / pumps are considered without losses, they do not change enthalpy flow.<br>
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
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2007, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.20 Beta 2005/02/18 Anton Haumer<br>
       <i>new model: IdealPump</i></li>
  </ul>
</HTML>
"), Icon(Ellipse(extent=[-60,10; 40,-90], style(color=1, rgbcolor={255,0,0})),
          Polygon(points=[-40,0; -40,-80; 38,-50; 38,-30; -40,0], style(
            color=3,
            rgbcolor={0,0,255},
            fillPattern=1))));
    
    model Ambient "Ambient with constant properties" 
      
    annotation (Documentation(info="<HTML>
(Infinite) ambient with constant pressure and temperature.<br>
Thermodynamic equations are defined by Partials.Ambient. 
</HTML>"));
      extends Interfaces.Partials.Ambient;
      parameter Modelica.SIunits.Pressure p_Ambient=0 "Ambient's pressure";
      parameter Modelica.SIunits.Temperature T_Ambient=Modelica.SIunits.Conversions.from_degC(20) 
        "Ambient's temperature";
    equation 
      flowPort.p = p_Ambient;
      T = T_Ambient;
    end Ambient;
    
    model PrescribedAmbient "Ambient with prescirbed properties" 
      
    annotation (Documentation(info="<HTML>
(Infinite) ambient with prescribed pressure and temperature.<br>
Thermodynamic equations are defined by Partials.Ambient. 
</HTML>"));
      extends Interfaces.Partials.Ambient;
      Modelica.Blocks.Interfaces.RealInput p_Ambient(redeclare type SignalType 
          = Modelica.SIunits.Pressure) 
        annotation (extent=[110, 60; 90, 80], rotation=0);
      Modelica.Blocks.Interfaces.RealInput T_Ambient(redeclare type SignalType 
          = Modelica.SIunits.Temperature) 
        annotation (extent=[110, -60; 90, -80], rotation=0);
    equation 
      flowPort.p = p_Ambient;
      T = T_Ambient;
    end PrescribedAmbient;
    
    model AbsolutePressure "Defines absolute pressure level" 
      
    annotation (Documentation(info="<HTML>
AbsolutePressure to define pressure level of a closed cooling cycle. 
Coolant's mass flow, temperature and enthalpy flow are not affected.<br>
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
        "Medium" 
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Pressure p=0 "Pressure ground";
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
    
    model ConstantVolumeFlow "Enforces constant volume flow" 
      
    annotation (Documentation(info="<HTML>
Fan resp. pump with constant volume flow rate. Pressure increase is the response of the whole system. 
Coolant's temperature and enthalpy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
Thermodynamic equations are defined by Partials.TwoPort.
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
      extends Interfaces.Partials.TwoPort(final tapT=1);
      parameter Modelica.SIunits.VolumeFlowRate VolumeFlow=1 "Volume flow rate";
    equation 
      Q_flow = 0;
      V_flow = VolumeFlow;
    end ConstantVolumeFlow;
    
    model PrescribedVolumeFlow "Enforces prescribed volume flow" 
      
    annotation (Documentation(info="<HTML>
Fan resp. pump with prescribed volume flow rate. Pressure increase is the response of the whole system. 
Coolant's temperature and enthalpy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
Thermodynamic equations are defined by Partials.TwoPort.
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
      extends Interfaces.Partials.TwoPort(final tapT=1);
      Modelica.Blocks.Interfaces.RealInput VolumeFlow(redeclare type SignalType
          =            Modelica.SIunits.VolumeFlowRate) 
        annotation (extent=[-10,90; 10,110], rotation=-90);
    equation 
      Q_flow = 0;
      V_flow = VolumeFlow;
    end PrescribedVolumeFlow;
    
    model ConstantPressureIncrease "Enforces constant pressure increase" 
      
    annotation (Documentation(info="<HTML>
Fan resp. pump with constant pressure increase. Mass resp. volume flow is the response of the whole system. 
Coolant's temperature and enthalpy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
Thermodynamic equations are defined by Partials.TwoPort.
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
      extends Interfaces.Partials.TwoPort(final tapT=1);
      parameter Modelica.SIunits.Pressure PressureIncrease=1 
        "Pressure increase";
    equation 
      Q_flow = 0;
      dp = -PressureIncrease;
    end ConstantPressureIncrease;
    
    model PrescribedPressureIncrease "Enforces prescribed pressure increase" 
      
    annotation (Documentation(info="<HTML>
Fan resp. pump with prescribed pressure increase. Mass resp. volume flow is the response of the whole system. 
Coolant's temperature and enthalpy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
Thermodynamic equations are defined by Partials.TwoPort.
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
      extends Interfaces.Partials.TwoPort(final tapT=1);
      Modelica.Blocks.Interfaces.RealInput PressureIncrease(redeclare type 
          SignalType = Modelica.SIunits.Pressure) 
        annotation (extent=[-10,90; 10,110],    rotation=-90);
    equation 
      Q_flow = 0;
      dp = -PressureIncrease;
    end PrescribedPressureIncrease;
    
    model IdealPump "Model of an ideal pump" 
      
    annotation (Documentation(info="<HTML>
Simple fan resp. pump where characteristic is dependent on shaft's speed, <br>
torque * speed = pressure increase * volume flow (without losses)<br>
Pressure increase versus volume flow is defined by a linear function, 
from dp0(V_flow=0) to V_flow0(dp=0).<br>
The axis intersections vary with speed as follows:
<ul>
<li>dp prop. speed^2</li>
<li>V_flow prop. speed</li>
</ul>
Coolant's temperature and enthalpy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
Thermodynamic equations are defined by Partials.TwoPort.
</HTML>"), Icon(
           Ellipse(extent=[-90,90; 90,-90],   style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255})),
          Text(
            extent=[-150,150; 150,90],
            style(color=3, rgbcolor={0,0,255}),
            string="%name"),
          Rectangle(extent=[-10,-40; 10,-100], style(
              color=10,
              rgbcolor={135,135,135},
              gradient=1,
              fillColor=9,
              rgbfillColor={175,175,175})),
          Polygon(points=[-60,68; 90,10; 90,-10; -60,-68; -60,68], style(
              color=1,
              rgbcolor={255,0,0},
              gradient=2,
              fillColor=3,
              rgbfillColor={0,0,255}))),
        Diagram);
      extends Interfaces.Partials.TwoPort(final tapT=1);
      parameter Modelica.SIunits.AngularVelocity w_Nominal=1 "Nominal speed" 
          annotation(Dialog(group="Pump characteristic"));
      parameter Modelica.SIunits.Pressure dp0=2 
        "Max. pressure increase @ V_flow=0" 
          annotation(Dialog(group="Pump characteristic"));
      parameter Modelica.SIunits.VolumeFlowRate V_flow0=2 
        "Max. volume flow rate @ dp=0" 
          annotation(Dialog(group="Pump characteristic"));
      Modelica.SIunits.AngularVelocity w=der(flange_a.phi) "Speed";
    protected 
      Modelica.SIunits.Pressure dp1;
      Modelica.SIunits.VolumeFlowRate V_flow1;
    public 
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
        annotation (extent=[-10,-110; 10,-90]);
    equation 
      // pump characteristic
      dp1 = dp0*sign(w/w_Nominal)*(w/w_Nominal)^2;
      V_flow1 = V_flow0*(w/w_Nominal);
      if noEvent(abs(w)<Modelica.Constants.small) then
        dp = 0;
        flange_a.tau = 0;
      else
        dp = -dp1*(1-noEvent(abs(V_flow/V_flow1)));
        flange_a.tau*w = -dp*V_flow;
      end if;
      // no energy exchange with medium
      Q_flow = 0;
    end IdealPump;
  end Sources;
end FluidHeatFlow;
