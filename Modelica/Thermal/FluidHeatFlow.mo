within Modelica.Thermal;


package FluidHeatFlow
  "Simple components for 1-dimensional incompressible thermo-fluid flow models"
  extends Modelica.Icons.Package;

  package UsersGuide "User's Guide"
    extends Modelica.Icons.Information;

    class Contact "Contact"
      extends Modelica.Icons.Contact;
      annotation (Documentation(info="<html>
<h4>Contact</h4>

<p>
Anton Haumer<br>
<a href=\"http://www.haumer.at\">Technical Consulting &amp; Electrical Engineering</a><br>
3423 St. Andrae-Woerdern, Austria<br>
email: <a HREF=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a><br>
</p>

<p>
  Dr. Christian Kral<br>
  <a href=\"http://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
  A-1060 Vienna, Austria<br>
  email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a>
</p>

<h4>Acknowledgements</h4>

<p>
Copyright &copy; 1998-2016, Modelica Association, Anton Haumer, Christian Kral and AIT.
</p>

</html>"));
    end Contact;

    class ReleaseNotes "Release Notes"
      extends Modelica.Icons.ReleaseNotes;
      annotation (Documentation(info="<html>

  <h5>3.2.2, 2010-06-25</h5>
  <ul>
  <li> Added users guide package including contact and release notes</li>
  </ul>

  <h5>1.6.7, 2010-06-25 (Christian Kral)</h5>
  <ul>
  <li>Changed company name of Arsenal Research to AIT</li>
  </ul>

  <h5>1.6.6, 2007-11-13 (Anton Haumer)</h5>
  <ul>
  <li> Replaced all nonSIunits</li>
  <li> Some renaming to be more concise</li>
  </ul>

  <h5>1.6.5, 2007-08-26 (Anton Haumer)</h5>
  <ul>
  <li> Fixed unit bug in SimpleFriction</li>
  </ul>

  <h5>1.6.4, 2007-08-24 (Anton Haumer)</h5>
  <ul>
  <li> Removed redeclare type SignalType</li>
  </ul>

  <h5>1.6.3, 2007-08-21 (Anton Haumer)</h5>
  <ul>
  <li> Improved documentation</li>
  </ul>

  <h5>1.6.2, 2007-08-20 (Anton Haumer)</h5>
  <ul>
  <li> Improved documentation</li>
  </ul>

  <h5>1.6.1, 2007-08-12 (Anton Haumer)</h5>
  <ul>
  <li> Improved documentation</li>
  <li> Removed type TemperatureDifference since this is defined in Modelica.SIunits</li>
  </ul>

  <h5>1.60, 2007-01-23 (Anton Haumer)</h5>
  <ul>
  <li> New parameter tapT defining Temperature of heatPort </li>
  </ul>

  <h5>1.50 2005-09-07 (Anton Haumer)</h5>
  <ul>
  <li> SemiLinear works fine</li>
  </ul>

  <h5>1.43 Beta 2005-06-20 (Anton Haumer)</h5>
  <ul>
  <li> Test of mixing / semiLinear</li>
  <li>New test example: OneMass</li
       <li>New test example: TwoMass</li>
  </ul>

  <h5>1.42 Beta, 2005-06-18 (Anton Haumer)</h5>
  <ul>
  <li> New test example: ParallelPumpDropOut</i></li>
  </ul>

  <h5>1.40, 2005-06-13 (Anton Haumer)</h5>
  <ul>
  <li> Stable release</li>
  </ul>

  <h5>1.33 Beta, 2005-06-07 (Anton Haumer)</h5>
  <ul>
  <li> Corrected usage of simpleFlow</li>
  </ul>

  <h5>1.31 Beta, 2005/06/04 Anton Haumer</h5>
  <ul>
  <li>New example: PumpAndValve</li>
  <li>New example: PumpDropOut</li>
  </ul>

  <h5>1.30 Beta, 2005-06-02 (Anton Haumer)</h5>
  <ul>
  <li> Friction losses are fed to medium</li>
  </ul>

  <h5>1.20 Beta, 2005-02-18 (Anton Haumer)</h5>
  <ul>
  <li>Introduced geodetic height in Components.Pipes</li>
  <li>New models: Components.Valve, Sources.IdealPump</li>
  </ul>

  <h5>1.11, 2005-02-18 (Anton Haumer)</h5>
  <ul>
  <li>Corrected usage of cv and cp</li>
  </ul>

  <h5>1.10, 2005-02-15 (Anton Haumer)</h5>
  <ul>
  <li>Reorganisation of the package</li>
  </ul>

  <h5>1.00, 2005-02-01 (Anton Haumer)</h5>
  <ul>
  <li>First stable official release</li>
  </ul>

</html>"));
    end ReleaseNotes;

    annotation (Documentation(info="<html>
<p>
This library provides simple components for 1-dimensional incompressible thermo-fluid flow models.
</p>
</html>"));
  end UsersGuide;

  package Examples
    "Examples that demonstrate the usage of the FluidHeatFlow components"
    extends Modelica.Icons.ExamplesPackage;

    model SimpleCooling "Example: simple cooling circuit"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource=
        prescribedHeatFlow.port.T-TAmb "Source over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=prescribedHeatFlow.port.T-pipe.heatPort.T
        "Source over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=pipe.dT
        "Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
      Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true,
        constantVolumeFlow=1)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      FluidHeatFlow.Components.HeatedPipe pipe(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true)
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
                       C=0.1, T(start=TAmb, fixed=true))
        annotation (Placement(transformation(
            origin={40,-50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow
        annotation (Placement(transformation(extent={{-30,-40},{-10,-60}})));
      Modelica.Blocks.Sources.Constant volumeFlow(k=1)
        annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
      Modelica.Blocks.Sources.Constant heatFlow(k=10)
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
      Modelica.Thermal.HeatTransfer.Components.Convection convection
        annotation (Placement(transformation(
            origin={10,-30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant thermalConductance(k=1)
        annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
    equation
      connect(ambient1.flowPort, pump.flowPort_a)
        annotation (Line(points={{-60,0},{-40,0}}, color={255,0,0}));
      connect(pump.flowPort_b, pipe.flowPort_a)
        annotation (Line(points={{-20,0},{0,0}}, color={255,0,0}));
      connect(pipe.flowPort_b, ambient2.flowPort)
        annotation (Line(points={{20,0},{40,0}}, color={255,0,0}));
      connect(heatFlow.y, prescribedHeatFlow.Q_flow)  annotation (Line(points={
              {-39,-50},{-30,-50}}, color={0,0,255}));
      connect(convection.solid, prescribedHeatFlow.port)   annotation (Line(
            points={{10,-40},{10,-50},{-10,-50}}, color={191,0,0}));
      connect(convection.solid, heatCapacitor.port)   annotation (Line(points={
              {10,-40},{10,-50},{30,-50}}, color={191,0,0}));
      connect(pipe.heatPort, convection.fluid)   annotation (Line(points={{10,
              -10},{10,-20}}, color={191,0,0}));
      connect(thermalConductance.y, convection.Gc)
                                   annotation (Line(points={{-9,-30},{0,-30}},
            color={0,0,127}));
      connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
          points={{-39,20},{-30,20},{-30,10}},
          color={0,0,127}));
    annotation (Documentation(info="<html>
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
</html>"),        experiment(StopTime=1.0, Interval=0.001));
    end SimpleCooling;

    model ParallelCooling "Example: cooling circuit with parallel branches"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource1=
        prescribedHeatFlow1.port.T-TAmb "Source1 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe1=prescribedHeatFlow1.port.T-pipe1.heatPort.T
        "Source1 over Coolant1";
      output Modelica.SIunits.TemperatureDifference dTCoolant1=pipe1.dT
        "Coolant1's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTSource2=
        prescribedHeatFlow2.port.T-TAmb "Source2 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe2=prescribedHeatFlow2.port.T-pipe2.heatPort.T
        "Source2 over Coolant2";
      output Modelica.SIunits.TemperatureDifference dTCoolant2=pipe2.dT
        "Coolant2's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTmixedCoolant=ambient2.T_port-ambient1.T_port
        "mixed Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
      Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true,
        constantVolumeFlow=1)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      FluidHeatFlow.Components.HeatedPipe pipe1(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        V_flow(start=0),
        T0fixed=true)
        annotation (Placement(transformation(extent={{0,-20},{20,0}})));
      FluidHeatFlow.Components.HeatedPipe pipe2(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        V_flow(start=0),
        T0fixed=true)
        annotation (Placement(transformation(extent={{0,20},{20,0}})));
      FluidHeatFlow.Components.IsolatedPipe pipe3(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{80,-10},{100,10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(
                       C=0.1, T(start=TAmb, fixed=true))
        annotation (Placement(transformation(
            origin={40,-60},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow1
        annotation (Placement(transformation(
            origin={-20,-60},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection1
        annotation (Placement(transformation(
            origin={10,-40},
            extent={{10,10},{-10,-10}},
            rotation=270)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor2(
                       C=0.1, T(start=TAmb, fixed=true))
        annotation (Placement(transformation(
            origin={38,60},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow2
        annotation (Placement(transformation(
            origin={-20,60},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection2
        annotation (Placement(transformation(
            origin={10,40},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant volumeFlow(k=1)
        annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
      Modelica.Blocks.Sources.Constant heatFlow1(k=5)
        annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
      Modelica.Blocks.Sources.Constant heatFlow2(k=10)
        annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
      Modelica.Blocks.Sources.Constant thermalConductance1(k=1)
        annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
      Modelica.Blocks.Sources.Constant thermalConductance2(k=1)
        annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
    equation
      connect(ambient1.flowPort, pump.flowPort_a)
        annotation (Line(points={{-60,0},{-40,0}}, color={255,0,0}));
      connect(pump.flowPort_b, pipe1.flowPort_a)
        annotation (Line(points={{-20,0},{-10,0},{-10,-10},{0,-10}}, color={255,
              0,0}));
      connect(pump.flowPort_b, pipe2.flowPort_a)
        annotation (Line(points={{-20,0},{-10,0},{-10,10},{0,10}}, color={255,0,
              0}));
      connect(heatFlow2.y,prescribedHeatFlow2. Q_flow)
        annotation (Line(points={{-39,60},{-30,60}}, color={0,0,255}));
      connect(heatFlow1.y,prescribedHeatFlow1. Q_flow)
        annotation (Line(points={{-39,-60},{-30,-60}}, color={0,0,255}));
      connect(thermalConductance2.y, convection2.Gc)
        annotation (Line(points={{-9,40},{0,40}}, color={0,0,127}));
      connect(thermalConductance1.y, convection1.Gc)
                                    annotation (Line(points={{-9,-40},{0,-40}},
            color={0,0,127}));
      connect(pipe1.heatPort,convection1. fluid) annotation (Line(points={{10,-20},{
              10,-30}},                         color={191,0,0}));
      connect(convection2.fluid,pipe2. heatPort) annotation (Line(points={{10,
              30},{10,20}}, color={191,0,0}));
      connect(convection2.solid,prescribedHeatFlow2. port) annotation (Line(
            points={{10,50},{10,60},{-10,60}}, color={191,0,0}));
      connect(convection2.solid,heatCapacitor2. port) annotation (Line(points={{10,50},
              {10,60},{28,60}},         color={191,0,0}));
      connect(convection1.solid,prescribedHeatFlow1. port) annotation (Line(
            points={{10,-50},{10,-60},{-10,-60}}, color={191,0,0}));
      connect(convection1.solid,heatCapacitor1. port) annotation (Line(points={{10,-50},
              {10,-60},{30,-60}},          color={191,0,0}));
      connect(pipe2.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,
              10},{30,10},{30,0},{40,0}}, color={255,0,0}));
      connect(pipe1.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,
              -10},{30,-10},{30,0},{40,0}}, color={255,0,0}));
      connect(pipe3.flowPort_b,ambient2. flowPort)
        annotation (Line(points={{60,0},{80,0}}, color={255,0,0}));
      connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
          points={{-39,20},{-30,20},{-30,10}},
          color={0,0,127}));
    annotation (Documentation(info="<html>
<p>
2nd test example: ParallelCooling
</p>
Two prescribed heat sources dissipate their heat through thermal conductors to coolant flows. The coolant flow is taken from an ambient and driven by a pump with prescribed mass flow, then split into two coolant flows connected to the two heat sources, and afterwards merged. Splitting of coolant flows is determined by pressure drop characteristic of the two pipes.<br>
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
</html>"),        experiment(StopTime=1.0, Interval=0.001));
    end ParallelCooling;

    model IndirectCooling "Example: indirect cooling circuit"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium outerMedium=FluidHeatFlow.Media.Medium()
        "Outer medium"
        annotation(choicesAllMatching=true);
      parameter FluidHeatFlow.Media.Medium innerMedium=FluidHeatFlow.Media.Medium()
        "Inner medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource=
        prescribedHeatFlow.port.T-TAmb "Source over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=prescribedHeatFlow.port.T-pipe1.heatPort.T
        "Source over inner Coolant";
      output Modelica.SIunits.TemperatureDifference dTinnerCoolant=pipe1.dT
        "inner Coolant's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTCooler=innerPipe.heatPort.T-outerPipe.heatPort.T
        "Cooler's temperature increase between inner and outer pipes";
      output Modelica.SIunits.TemperatureDifference dTouterCoolant=outerPipe.dT
        "outer Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=outerMedium,
        constantAmbientPressure=0)
                            annotation (Placement(transformation(extent={{-60,
                60},{-80,80}})));
      Sources.VolumeFlow outerPump(
        medium=outerMedium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true,
        constantVolumeFlow=1)
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=outerMedium,
        constantAmbientPressure=0)
                            annotation (Placement(transformation(extent={{40,60},
                {60,80}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor
        thermalConductor(                                                        G=1)
        annotation (Placement(transformation(
            origin={10,-70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
                       C=0.05, T(start=TAmb, fixed=true))
        annotation (Placement(transformation(
            origin={40,-90},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow
        annotation (Placement(transformation(
            origin={-20,-90},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      FluidHeatFlow.Components.HeatedPipe pipe1(
        medium=innerMedium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=1,
        V_flowNominal=2,
        h_g=0,
        T0fixed=true,
        dpLaminar=1000,
        dpNominal=2000)
        annotation (Placement(transformation(extent={{20,-50},{0,-30}})));
      FluidHeatFlow.Sources.AbsolutePressure absolutePressure(p=10000, medium=innerMedium)
                            annotation (Placement(transformation(extent={{40,
                -40},{60,-20}})));
      Sources.VolumeFlow innerPump(
        medium=innerMedium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true,
        constantVolumeFlow=1)
        annotation (Placement(transformation(
            origin={-20,-30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant heatFlow(k=10)
        annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
      Modelica.Blocks.Sources.Constant outerVolumeFlow(k=1)
        annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
      Modelica.Blocks.Sources.Constant innerVolumeFlow(k=1)
        annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
      Modelica.Blocks.Sources.Constant outerGc(k=2)
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Modelica.Blocks.Sources.Constant innerGc(k=2)
        annotation (Placement(transformation(extent={{-40,20},{-20,0}})));
      FluidHeatFlow.Components.HeatedPipe outerPipe(
        medium=outerMedium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true)
        annotation (Placement(transformation(extent={{0,60},{20,80}})));
      FluidHeatFlow.Components.HeatedPipe innerPipe(
        medium=innerMedium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true)
        annotation (Placement(transformation(extent={{0,-10},{20,-30}})));
      Modelica.Thermal.HeatTransfer.Components.Convection innerConvection
        annotation (Placement(transformation(
            origin={10,10},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Thermal.HeatTransfer.Components.Convection outerConvection
        annotation (Placement(transformation(
            origin={10,40},
            extent={{10,10},{-10,-10}},
            rotation=270)));
    equation
      connect(ambient1.flowPort, outerPump.flowPort_a)
        annotation (Line(points={{-60,70},{-40,70}}, color={255,0,0}));
      connect(prescribedHeatFlow.port, thermalConductor.port_a)
        annotation (Line(points={{-10,-90},{10,-90},{10,-80}}, color={191,0,0}));
      connect(heatCapacitor.port, thermalConductor.port_a)
        annotation (Line(points={{30,-90},{10,-90},{10,-80}}, color={191,0,0}));
      connect(pipe1.heatPort, thermalConductor.port_b)
        annotation (Line(points={{10,-50},{10,-60}}, color={191,0,0}));
      connect(pipe1.flowPort_b, innerPump.flowPort_a)
        annotation (Line(points={{0,-40},{-20,-40}}, color={255,0,0}));
      connect(absolutePressure.flowPort, pipe1.flowPort_a)
        annotation (Line(points={{40,-30},{40,-40},{20,-40}}, color={255,0,0}));
      connect(heatFlow.y, prescribedHeatFlow.Q_flow)
        annotation (Line(points={{-39,-90},{-30,-90}}, color={0,0,255}));
      connect(innerPump.flowPort_b, innerPipe.flowPort_a)
        annotation (Line(points={{-20,-20},{0,-20}}, color={255,0,0}));
      connect(innerPipe.flowPort_b, absolutePressure.flowPort)  annotation (Line(
            points={{20,-20},{40,-20},{40,-30}}, color={255,0,0}));
      connect(outerPump.flowPort_b, outerPipe.flowPort_a)
        annotation (Line(points={{-20,70},{0,70}}, color={255,0,0}));
      connect(outerPipe.flowPort_b,ambient2. flowPort)
        annotation (Line(points={{20,70},{40,70}}, color={255,0,0}));
      connect(outerPipe.heatPort, outerConvection.fluid)
        annotation (Line(points={{10,60},{10,55},{10,50}},         color={191,0,
              0}));
      connect(outerConvection.solid, innerConvection.solid)
        annotation (Line(points={{10,30},{10,20},{10,20}},
                       color={191,0,0}));
      connect(innerConvection.fluid, innerPipe.heatPort)
        annotation (Line(points={{10,0},{10,-5},{10,-10}},         color={191,0,
              0}));
      connect(innerGc.y, innerConvection.Gc)
        annotation (Line(points={{-19,10},{-9.5,10},{-9.5,10},{0,10}}, color={0,
              0,127}));
      connect(outerGc.y, outerConvection.Gc)
        annotation (Line(points={{-19,40},{0,40}},  color={0,0,127}));
      connect(outerVolumeFlow.y, outerPump.volumeFlow) annotation (Line(
          points={{-39,90},{-30,90},{-30,80}},
          color={0,0,127}));
      connect(innerVolumeFlow.y, innerPump.volumeFlow) annotation (Line(
          points={{-39,-30},{-30,-30}},
          color={0,0,127}));
    annotation (Documentation(info="<html>
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
</html>"),        experiment(StopTime=1.5, Interval=0.001));
    end IndirectCooling;

    model PumpAndValve "Example: cooling circuit with pump and valve"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource=
        prescribedHeatFlow.port.T-TAmb "Source over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=prescribedHeatFlow.port.T-pipe.heatPort.T
        "Source over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=pipe.dT
        "Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{-70,-10},{-90,10}})));
      FluidHeatFlow.Sources.IdealPump idealPump(
        medium=medium,
        m=0,
        T0=TAmb,
        V_flow0=2,
        V_flow(start=0),
        wNominal(displayUnit="rad/s") = 1,
        dp0(displayUnit="Pa") = 2)
        annotation (Placement(transformation(extent={{-60,10},{-40,-10}})));
      FluidHeatFlow.Components.Valve valve(
        medium=medium,
        m=0,
        T0=TAmb,
        LinearCharacteristic=false,
        y1=1,
        Kv1=1,
        kv0=0.01,
        dp0(displayUnit="Pa") = 1,
        rho0=10,
        frictionLoss=0)
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
      FluidHeatFlow.Components.HeatedPipe pipe(
        medium=medium,
        T0=TAmb,
        m=0.1,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true)
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
                       C=0.1, T(start=TAmb, fixed=true))
        annotation (Placement(transformation(
            origin={40,-50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow
        annotation (Placement(transformation(extent={{-30,-40},{-10,-60}})));
      Modelica.Blocks.Sources.Constant heatFlow(k=10)
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
      Modelica.Thermal.HeatTransfer.Components.Convection convection
        annotation (Placement(transformation(
            origin={10,-30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant thermalConductance(k=1)
        annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
      Modelica.Mechanics.Rotational.Sources.Speed speed(exact=true, useSupport=
            false)
        annotation (Placement(transformation(
            origin={-50,30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.Ramp speedRamp(
        height=0.5,
        offset=0.5,
        duration=0.1,
        startTime=0.4) annotation (Placement(transformation(extent={{-80,40},{
                -60,60}})));
      Modelica.Blocks.Sources.Ramp valveRamp(
        height=0.5,
        offset=0.5,
        duration=0.1,
        startTime=0.9) annotation (Placement(transformation(extent={{12,40},{-8,
                60}})));
    equation
      connect(pipe.flowPort_b, ambient2.flowPort)
        annotation (Line(points={{20,0},{40,0}}, color={255,0,0}));
      connect(heatFlow.y, prescribedHeatFlow.Q_flow)  annotation (Line(points={
              {-39,-50},{-30,-50}}, color={0,0,255}));
      connect(convection.solid, prescribedHeatFlow.port)   annotation (Line(
            points={{10,-40},{10,-50},{-10,-50}}, color={191,0,0}));
      connect(convection.solid, heatCapacitor.port)   annotation (Line(points={
              {10,-40},{10,-50},{30,-50}}, color={191,0,0}));
      connect(pipe.heatPort, convection.fluid)   annotation (Line(points={{10,
              -10},{10,-20}}, color={191,0,0}));
      connect(thermalConductance.y, convection.Gc)
                                   annotation (Line(points={{-9,-30},{0,-30}},
            color={0,0,127}));
      connect(ambient1.flowPort, idealPump.flowPort_a)
        annotation (Line(points={{-70,0},{-60,0}}, color={255,0,0}));
      connect(idealPump.flowPort_b, valve.flowPort_a)
        annotation (Line(points={{-40,0},{-30,0}}, color={255,0,0}));
      connect(valve.flowPort_b, pipe.flowPort_a)
        annotation (Line(points={{-10,0},{0,0}}, color={255,0,0}));
      connect(speedRamp.y, speed.w_ref)
                                     annotation (Line(points={{-59,50},{-50,50},
              {-50,42}}, color={0,0,127}));
      connect(valveRamp.y, valve.y)
                                 annotation (Line(points={{-9,50},{-20,50},{-20,
              9}}, color={0,0,127}));
      connect(speed.flange, idealPump.flange_a) annotation (Line(
          points={{-50,20},{-50,10}}));
    annotation (Documentation(info="<html>
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
</html>"),        experiment(StopTime=2.0, Interval=0.001));
    end PumpAndValve;

    model PumpDropOut "Example: cooling circuit with drop out of pump"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource=
        prescribedHeatFlow.port.T-TAmb "Source over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=prescribedHeatFlow.port.T-pipe.heatPort.T
        "Source over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=pipe.dT
        "Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
      Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true,
        constantVolumeFlow=1)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      FluidHeatFlow.Components.HeatedPipe pipe(
        medium=medium,
        T0=TAmb,
        m=0.1,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true)
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
                       C=0.1, T(start=TAmb, fixed=true))
        annotation (Placement(transformation(
            origin={40,-50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow
        annotation (Placement(transformation(extent={{-30,-40},{-10,-60}})));
      Utilities.DoubleRamp volumeFlow
        annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
      Modelica.Blocks.Sources.Constant heatFlow(k=10)
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
      Modelica.Thermal.HeatTransfer.Components.Convection convection
        annotation (Placement(transformation(
            origin={10,-30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant thermalConductance(k=1)
        annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
    equation
      connect(ambient1.flowPort, pump.flowPort_a)
        annotation (Line(points={{-60,0},{-40,0}}, color={255,0,0}));
      connect(pump.flowPort_b, pipe.flowPort_a)
        annotation (Line(points={{-20,0},{0,0}}, color={255,0,0}));
      connect(pipe.flowPort_b, ambient2.flowPort)
        annotation (Line(points={{20,0},{40,0}}, color={255,0,0}));
      connect(heatFlow.y, prescribedHeatFlow.Q_flow)  annotation (Line(points={
              {-39,-50},{-30,-50}}, color={0,0,255}));
      connect(convection.solid, prescribedHeatFlow.port)   annotation (Line(
            points={{10,-40},{10,-50},{-10,-50}}, color={191,0,0}));
      connect(convection.solid, heatCapacitor.port)   annotation (Line(points={
              {10,-40},{10,-50},{30,-50}}, color={191,0,0}));
      connect(pipe.heatPort, convection.fluid)   annotation (Line(points={{10,
              -10},{10,-20}}, color={191,0,0}));
      connect(thermalConductance.y, convection.Gc)
                                   annotation (Line(points={{-9,-30},{0,-30}},
            color={0,0,127}));
      connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
          points={{-39,20},{-30,20},{-30,10}},
          color={0,0,127}));
    annotation (Documentation(info="<html>
<p>
5th test example: PumpDropOut
</p>
Same as 1st test example, but with a drop out of the pump:<br>
The pump is running for 0.2 s, then shut down (using a ramp of 0.2 s) for 0.2 s,
then started again (using a ramp of 0.2 s).
</html>"),        experiment(StopTime=2.0, Interval=0.001));
    end PumpDropOut;

    model ParallelPumpDropOut
      "Example: cooling circuit with parallel branches and drop out of pump"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource1=
        prescribedHeatFlow1.port.T-TAmb "Source1 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe1=prescribedHeatFlow1.port.T-pipe1.heatPort.T
        "Source1 over Coolant1";
      output Modelica.SIunits.TemperatureDifference dTCoolant1=pipe1.dT
        "Coolant1's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTSource2=
        prescribedHeatFlow2.port.T-TAmb "Source2 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe2=prescribedHeatFlow2.port.T-pipe2.heatPort.T
        "Source2 over Coolant2";
      output Modelica.SIunits.TemperatureDifference dTCoolant2=pipe2.dT
        "Coolant2's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTmixedCoolant=ambient2.T_port-ambient1.T_port
        "mixed Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
      Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true,
        constantVolumeFlow=1)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      FluidHeatFlow.Components.HeatedPipe pipe1(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        V_flow(start=0),
        T0fixed=true)
        annotation (Placement(transformation(extent={{0,-20},{20,0}})));
      FluidHeatFlow.Components.HeatedPipe pipe2(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        V_flow(start=0),
        T0fixed=true)
        annotation (Placement(transformation(extent={{0,20},{20,0}})));
      FluidHeatFlow.Components.IsolatedPipe pipe3(
        medium=medium,
        T0=TAmb,
        m=0.1,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{80,-10},{100,10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(
                       C=0.1, T(start=TAmb, fixed=true))
        annotation (Placement(transformation(
            origin={40,-60},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow1
        annotation (Placement(transformation(
            origin={-20,-60},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Thermal.HeatTransfer.Components.Convection Convection1
        annotation (Placement(transformation(
            origin={10,-40},
            extent={{10,10},{-10,-10}},
            rotation=270)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor2(
                       C=0.1, T(start=TAmb, fixed=true))
        annotation (Placement(transformation(
            origin={38,60},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow2
        annotation (Placement(transformation(
            origin={-20,60},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection2
        annotation (Placement(transformation(
            origin={10,40},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Utilities.DoubleRamp volumeFlow
        annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
      Modelica.Blocks.Sources.Constant heatFlow1(k=5)
        annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
      Modelica.Blocks.Sources.Constant heatFlow2(k=10)
        annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
      Modelica.Blocks.Sources.Constant thermalConductance1(k=1)
        annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
      Modelica.Blocks.Sources.Constant thermalConductance2(k=1)
        annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
    equation
      connect(ambient1.flowPort, pump.flowPort_a)
        annotation (Line(points={{-60,0},{-60,0},{-40,0}},
                                                   color={255,0,0}));
      connect(pump.flowPort_b, pipe1.flowPort_a)
        annotation (Line(points={{-20,0},{-10,0},{-10,-10},{0,-10}}, color={255,
              0,0}));
      connect(pump.flowPort_b, pipe2.flowPort_a)
        annotation (Line(points={{-20,0},{-10,0},{-10,10},{0,10}}, color={255,0,
              0}));
      connect(heatFlow2.y,prescribedHeatFlow2. Q_flow)
        annotation (Line(points={{-39,60},{-30,60}}, color={0,0,255}));
      connect(heatFlow1.y,prescribedHeatFlow1. Q_flow)
        annotation (Line(points={{-39,-60},{-30,-60}}, color={0,0,255}));
      connect(thermalConductance2.y, convection2.Gc)
        annotation (Line(points={{-9,40},{0,40}}, color={0,0,127}));
      connect(thermalConductance1.y, Convection1.Gc)
                                    annotation (Line(points={{-9,-40},{0,-40}},
            color={0,0,127}));
      connect(pipe1.heatPort, Convection1.fluid) annotation (Line(points={{10,-20},{
              10,-25},{10,-30}},                color={191,0,0}));
      connect(convection2.fluid,pipe2. heatPort) annotation (Line(points={{10,
              30},{10,20}}, color={191,0,0}));
      connect(convection2.solid,prescribedHeatFlow2. port) annotation (Line(
            points={{10,50},{10,60},{-10,60}}, color={191,0,0}));
      connect(convection2.solid,heatCapacitor2. port) annotation (Line(points={{10,50},
              {10,60},{28,60}},         color={191,0,0}));
      connect(Convection1.solid,prescribedHeatFlow1. port) annotation (Line(
            points={{10,-50},{10,-60},{-10,-60}}, color={191,0,0}));
      connect(Convection1.solid,heatCapacitor1. port) annotation (Line(points={{10,-50},
              {10,-60},{30,-60}},          color={191,0,0}));
      connect(pipe2.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,
              10},{30,10},{30,0},{40,0}}, color={255,0,0}));
      connect(pipe1.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,
              -10},{30,-10},{30,0},{40,0}}, color={255,0,0}));
      connect(pipe3.flowPort_b,ambient2. flowPort)
        annotation (Line(points={{60,0},{80,0}}, color={255,0,0}));
      connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
          points={{-39,20},{-30,20},{-30,10}},
          color={0,0,127}));
    annotation (Documentation(info="<html>
<p>
6th test example: ParallelPumpDropOut
</p>
Same as 2nd test example, but with a drop out of the pump:<br>
The pump is running for 0.2 s, then shut down (using a ramp of 0.2 s) for 0.2 s,
then started again (using a ramp of 0.2 s).
</html>"),        experiment(StopTime=2.0, Interval=0.001));
    end ParallelPumpDropOut;

    model OneMass "Example: cooling of one hot mass"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      parameter Modelica.SIunits.Temperature TMass(displayUnit="degC")=313.15
        "Initial temperature of mass";
      output Modelica.SIunits.TemperatureDifference dTMass=
        heatCapacitor.port.T-TAmb "Mass over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=heatCapacitor.port.T-pipe.heatPort.T
        "Mass over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=pipe.dT
        "Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
      Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true,
        constantVolumeFlow=1)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      FluidHeatFlow.Components.HeatedPipe pipe(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true)
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
        C=0.1, T(start=TMass, fixed=true))
        annotation (Placement(transformation(
            origin={10,-60},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor
        thermalConductor(                                                        G=1)
        annotation (Placement(transformation(
            origin={10,-30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Utilities.DoubleRamp volumeFlow(
        offset=0,
        height_1=1,
        height_2=-2) annotation (Placement(transformation(extent={{-60,10},{-40,
                30}})));
    equation
      connect(ambient1.flowPort, pump.flowPort_a)
        annotation (Line(points={{-60,0},{-40,0}}, color={255,0,0}));
      connect(pump.flowPort_b, pipe.flowPort_a)
        annotation (Line(points={{-20,0},{0,0}}, color={255,0,0}));
      connect(pipe.flowPort_b, ambient2.flowPort)
        annotation (Line(points={{20,0},{40,0}}, color={255,0,0}));
      connect(thermalConductor.port_a, heatCapacitor.port)   annotation (Line(
            points={{10,-40},{10,-45},{10,-50}},          color={191,0,0}));
      connect(pipe.heatPort, thermalConductor.port_b)
        annotation (Line(points={{10,-10},{10,-20}}, color={191,0,0}));
      connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
          points={{-39,20},{-30,20},{-30,10}},
          color={0,0,127}));
    annotation (Documentation(info="<html>
<p>
7th test example: OneMass
</p>
A thermal capacity is coupled with a coolant flow.
Different initial temperatures of thermal capacity and pipe's coolant get ambient's temperature,
the time behaviour depending on coolant flow.
</html>"),        experiment(StopTime=1.0, Interval=0.001));
    end OneMass;

    model TwoMass "Example: cooling of two hot masses"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      parameter Modelica.SIunits.Temperature TMass1(displayUnit="degC")=313.15
        "Initial temperature of mass1";
      parameter Modelica.SIunits.Temperature TMass2(displayUnit="degC")=333.15
        "Initial temperature of mass2";
      output Modelica.SIunits.TemperatureDifference dTMass1=
        heatCapacitor1.port.T-TAmb "Mass1 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe1=heatCapacitor1.port.T-pipe1.heatPort.T
        "Mass1 over Coolant1";
      output Modelica.SIunits.TemperatureDifference dTCoolant1=pipe1.dT
        "Coolant1's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTMass2=
        heatCapacitor2.port.T-TAmb "Mass2 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe2=heatCapacitor2.port.T-pipe2.heatPort.T
        "Mass2 over Coolant2";
      output Modelica.SIunits.TemperatureDifference dTCoolant2=pipe2.dT
        "Coolant2's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTmixedCoolant=ambient2.T_port-ambient1.T_port
        "mixed Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
      Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true,
        constantVolumeFlow=1)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      FluidHeatFlow.Components.HeatedPipe pipe1(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flow(start=0),
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true)
        annotation (Placement(transformation(extent={{0,-20},{20,0}})));
      FluidHeatFlow.Components.HeatedPipe pipe2(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flow(start=0),
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true)
        annotation (Placement(transformation(extent={{0,20},{20,0}})));
      FluidHeatFlow.Components.IsolatedPipe pipe3(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{80,-10},{100,10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(
        C=0.1, T(start=TMass1, fixed=true))
        annotation (Placement(transformation(
            origin={10,-70},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor
        thermalConductor1(                                                        G=1)
        annotation (Placement(transformation(
            origin={10,-40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor2(
        C=0.1, T(start=TMass2, fixed=true))
        annotation (Placement(transformation(
            origin={10,70},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor
        thermalConductor2(                                                        G=1)
        annotation (Placement(transformation(
            origin={10,40},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Utilities.DoubleRamp volumeFlow(
        offset=0,
        height_1=1,
        height_2=-2) annotation (Placement(transformation(extent={{-60,10},{-40,
                30}})));
    equation
      connect(ambient1.flowPort, pump.flowPort_a)
        annotation (Line(points={{-60,0},{-40,0}}, color={255,0,0}));
      connect(pump.flowPort_b, pipe1.flowPort_a)
        annotation (Line(points={{-20,0},{-10,0},{-10,-10},{0,-10}}, color={255,
              0,0}));
      connect(pump.flowPort_b, pipe2.flowPort_a)
        annotation (Line(points={{-20,0},{-10,0},{-10,10},{0,10}}, color={255,0,
              0}));
      connect(pipe2.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,
              10},{30,10},{30,0},{40,0}}, color={255,0,0}));
      connect(pipe1.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,
              -10},{30,-10},{30,0},{40,0}}, color={255,0,0}));
      connect(pipe3.flowPort_b,ambient2. flowPort)
        annotation (Line(points={{60,0},{80,0}}, color={255,0,0}));
      connect(heatCapacitor2.port,thermalConductor2. port_a) annotation (Line(
            points={{10,60},{10,55},{10,50}},         color={191,0,0}));
      connect(thermalConductor2.port_b,pipe2. heatPort)
        annotation (Line(points={{10,30},{10,20}}, color={191,0,0}));
      connect(pipe1.heatPort,thermalConductor1. port_b) annotation (Line(points=
             {{10,-20},{10,-30}}, color={191,0,0}));
      connect(thermalConductor1.port_a, heatCapacitor1.port) annotation (Line(
            points={{10,-50},{10,-55},{10,-60}},          color={191,0,0}));
      connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
          points={{-39,20},{-30,20},{-30,10}},
          color={0,0,127}));
    annotation (Documentation(info="<html>
<p>
8th test example: TwoMass
</p>
Two thermal capacities are coupled with two parallel coolant flow.
Different initial temperatures of thermal capacities and pipe's coolants get ambient's temperature,
the time behaviour depending on coolant flow.
</html>"),        experiment(StopTime=1.0, Interval=0.001));
    end TwoMass;

    package Utilities "Utility models for examples"
      extends Modelica.Icons.UtilitiesPackage;

      model DoubleRamp "Ramp going up and down"
        extends Modelica.Blocks.Interfaces.SO;
        parameter Real offset=1 "Offset of ramps";
        parameter Modelica.SIunits.Time startTime=0.2 "StartTime of 1st ramp";
        parameter Modelica.SIunits.Time interval=0.2
          "Interval between end of 1st and beginning of 2nd ramp";
        parameter Real height_1=-1 "Height of ramp"
          annotation(Dialog(group="Ramp 1"));
        parameter Modelica.SIunits.Time duration_1(min=Modelica.Constants.small)=0.2
          "Duration of ramp"
          annotation(Dialog(group="Ramp 1"));
        parameter Real height_2=1 "Height of ramp"
          annotation(Dialog(group="Ramp 2"));
        parameter Modelica.SIunits.Time duration_2(min=Modelica.Constants.small)=0.2
          "Duration of ramp"
          annotation(Dialog(group="Ramp 2"));

        Modelica.Blocks.Math.Add add  annotation (Placement(transformation(
                extent={{10,-10},{30,10}})));
        Modelica.Blocks.Sources.Ramp ramp1(
          final height=height_1,
          final duration=duration_1,
          final startTime=startTime,
          final offset=offset)
                         annotation (Placement(transformation(extent={{-30,10},
                  {-10,30}})));
        Modelica.Blocks.Sources.Ramp ramp2(
          final height=height_2,
          final duration=duration_2,
          final startTime=startTime + duration_1 + interval,
          final offset=0)
          annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
      equation
        connect(ramp1.y, add.u1)  annotation (Line(points={{-9,20},{0,20},{0,6},
                {8,6}}, color={0,0,127}));
        connect(ramp2.y, add.u2)  annotation (Line(points={{-9,-20},{0,-20},{0,
                -6},{8,-6}}, color={0,0,127}));
        connect(add.y, y)  annotation (Line(points={{31,0},{110,0}}, color={0,0,
                127}));
        annotation (
          Documentation(info="<html>
Block generating the sum of two ramps.
</html>"),Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics={Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
              Polygon(
                points={{-80,90},{-88,68},{-72,68},{-80,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
              Polygon(
                points={{90,-70},{68,-62},{68,-78},{90,-70}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-80,-60},{-50,-60},{-30,60},{10,60},{30,-20},{70,-20}})}));
      end DoubleRamp;
      annotation (Documentation(info="<html>
This package contains utility components used for the test examples.<br>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <p>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
</p>
  <p>
  Dr. Christian Kral<br>
  <a href=\"http://www.ait.ac.at/\">Austrian Institute of Technology, AIT</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
</p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2016, Modelica Association, Anton Haumer and Austrian Institute of Technology, AIT.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>", revisions="<html>
  <ul>
  <li> v1.41 Beta 2005/06/17 Anton Haumer<br>
       first used</li>
  </ul>
</html>"));
    end Utilities;
  annotation (Documentation(info="<html>
<p>This package contains test examples:</p>

<ol>
<li>SimpleCooling: heat is dissipated through a media flow</li>
<li>ParallelCooling: two heat sources dissipate through merged media flows</li>
<li>IndirectCooling: heat is dissipated through two cooling cycles</li>
<li>PumpAndValve: demonstrates usage of an IdealPump and a Valve</li>
<li>PumpDropOut: demonstrates shutdown and restart of a pump</li>
<li>ParallelPumpDropOut: demonstrates shutdown and restart of a pump in a parallel circuit</li>
<li>OneMass: cooling of a mass (thermal capacity) by a coolant flow</li>
<li>TwoMass: cooling of two masses (thermal capacities) by two parallel coolant flows</li>
</ol>

</html>", revisions="<html>
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
</html>"));
  end Examples;

  package Components "Basic components (pipes, valves)"
    extends Modelica.Icons.Package;

    model IsolatedPipe "Pipe without heat exchange"

      extends Interfaces.Partials.TwoPort(final tapT=1);
      extends Interfaces.Partials.SimpleFriction;
      parameter Modelica.SIunits.Length h_g(start=0)
        "Geodetic height (height difference from flowPort_a to flowPort_b)";
    equation
      // coupling with FrictionModel
      volumeFlow = V_flow;
      dp = pressureDrop + medium.rho*Modelica.Constants.g_n*h_g;
      // no energy exchange with medium
      Q_flow = Q_friction;
    annotation (Documentation(info="<html>
Pipe without heat exchange.<br>
Thermodynamic equations are defined by Partials.TwoPortMass(Q_flow = 0).<br>
<b>Note:</b> Setting parameter m (mass of medium within pipe) to zero
leads to neglection of temperature transient cv*m*der(T).
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={Rectangle(
              extent={{-90,20},{90,-20}},
              lineColor={255,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid), Text(extent={{-150,100},{150,40}},
                textString="%name")}));
    end IsolatedPipe;

    model HeatedPipe "Pipe with heat exchange"

      extends Interfaces.Partials.TwoPort;
      extends Interfaces.Partials.SimpleFriction;
      parameter Modelica.SIunits.Length h_g(start=0)
        "Geodetic height (height difference from flowPort_a to flowPort_b)";
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    equation
      // coupling with FrictionModel
      volumeFlow = V_flow;
      dp = pressureDrop + medium.rho*Modelica.Constants.g_n*h_g;
      // energy exchange with medium
      Q_flow = heatPort.Q_flow + Q_friction;
      // defines heatPort's temperature
      heatPort.T = T_q;
    annotation (Documentation(info="<html>
Pipe with heat exchange.<br>
Thermodynamic equations are defined by Partials.TwoPort.<br>
Q_flow is defined by heatPort.Q_flow.<br>
<b>Note:</b> Setting parameter m (mass of medium within pipe) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
<b>Note:</b> Injecting heat into a pipe with zero mass flow causes
temperature rise defined by storing heat in medium's mass.
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Rectangle(
              extent={{-90,20},{90,-20}},
              lineColor={255,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{-150,100},{150,40}}, textString="%name"),
            Polygon(
              points={{-10,-90},{-10,-40},{0,-20},{10,-40},{10,-90},{-10,-90}},
              lineColor={255,0,0})}));
    end HeatedPipe;

    model Valve "Simple valve"

      extends Interfaces.Partials.TwoPort(m(start=0), final tapT=1);
      parameter Boolean LinearCharacteristic(start=true)
        "Type of characteristic"
        annotation(Dialog(group="Standard characteristic"), choices(choice=true "Linear", choice=false
            "Exponential"));
      parameter Real y1(min=small, start=1) "Max. valve opening"
        annotation(Dialog(group="Standard characteristic"));
      parameter Modelica.SIunits.VolumeFlowRate Kv1(min=small, start=1)
        "Max. flow @ y = y1"
        annotation(Dialog(group="Standard characteristic"));
      parameter Real kv0(min=small,max=1-small, start=0.01)
        "Leakage flow / max.flow @ y = 0"
        annotation(Dialog(group="Standard characteristic"));
      parameter Modelica.SIunits.Pressure dp0(start=1) "Standard pressure drop"
        annotation(Dialog(group="Standard characteristic"));
      parameter Modelica.SIunits.Density rho0(start=10)
        "Standard medium's density"
        annotation(Dialog(group="Standard characteristic"));
      parameter Real frictionLoss(min=0, max=1, start=0)
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
        annotation (Placement(transformation(
            origin={0,90},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    initial algorithm
      assert(y1>small, "Valve characteristic: y1 has to be > 0 !");
      assert(Kv1>smallVolumeFlowRate, "Valve characteristic: Kv1 has to be > 0 !");
      assert(kv0>small, "Valve characteristic: kv0 has to be > 0 !");
      assert(kv0<1-eps, "Valve characteristic: kv0 has to be < 1 !");
    equation
      // evaluate standard characteristic
      Kv/Kv1 = if LinearCharacteristic then (kv0 + (1-kv0)*yLim/y1) else kv0*exp(Modelica.Math.log(1/kv0)*yLim/y1);
      // pressure drop under real conditions
      dp/dp0 = medium.rho/rho0*(V_flow/Kv)*abs(V_flow/Kv);
      // no energy exchange with medium
      Q_flow = frictionLoss*V_flow*dp;
    annotation (Documentation(info="<html>
<p>Simple controlled valve.</p>
<p>
Standard characteristic Kv=<i>f </i>(y) is given at standard conditions (dp0, rho0),
</p>
<ul>
<li>either linear :<code> Kv/Kv1 = Kv0/Kv1 + (1-Kv0/Kv1) * y/Y1</code></li>
<li>or exponential:<code> Kv/Kv1 = Kv0/Kv1 * exp[log(Kv1/Kv0) * y/Y1]</code></li>
</ul>
<p>
where:
</p>
<ul>
<li><code>Kv0 ... min. flow @ y = 0</code></li>
<li><code>Y1 .... max. valve opening</code></li>
<li><code>Kv1 ... max. flow @ y = Y1</code></li>
</ul>
<p>
Flow resistance under real conditions is calculated by
</p>
<blockquote><pre>
V_flow**2 * rho / dp = Kv(y)**2 * rho0 / dp0
</pre></blockquote>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Text(extent={{-150,-60},{150,-120}}, textString="%name"),
            Polygon(
              points={{-90,10},{-60,10},{-60,60},{0,0},{60,60},{60,10},{90,10},
                  {90,-10},{60,-10},{60,-60},{0,0},{-60,-60},{-60,-10},{-90,-10},
                  {-90,10}},
              lineColor={255,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,80},{0,0}}, color={0,0,127})}));
    end Valve;
  annotation (Documentation(info="<html>
<p>This package contains components:</p>
<ul>
<li>pipe without heat exchange</li>
<li>pipe with heat exchange</li>
<li>valve (simple controlled valve)</li>
</ul>
<p>
Pressure drop is taken from partial model SimpleFriction.
Thermodynamic equations are defined in partial models (package Partials).</p>

</html>", revisions="<html>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.20 Beta 2005/02/18 Anton Haumer<br>
       introduced geodetic height in Components.Pipes<br>
       <i>new models: Components.Valve</i></li>
  <li> v1.30 Beta 2005/06/02 Anton Haumer<br>
       friction losses are fed to medium</li>
  </ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={
      Polygon(
        origin = {6,40},
        lineColor = {0,0,255},
        fillColor = {0,128,255},
        fillPattern = FillPattern.Solid,
        points = {{-56,10},{-56,-90},{-6,-40},{44,10},{44,-90},{-56,10}}),
      Polygon(
        origin = {6,40},
        lineColor = {0,0,127},
        fillColor = {0,0,127},
        fillPattern = FillPattern.Solid,
        points = {{-16,10},{4,10},{-6,-10},{-16,10}}),
      Line(
        origin = {6,40},
        points = {{-6,-10},{-6,-40},{-6,-38}},
        color = {0,0,127})}));
  end Components;

  package Media "Medium properties"
    extends Modelica.Icons.MaterialPropertiesPackage;

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
        "Kinematic viscosity";
      annotation (Documentation(info="<html>
Record containing (constant) medium properties.
</html>"));
    end Medium;

    record Air_30degC "Medium: properties of air at 30 degC"
    extends Medium(
      rho=1.149,
      cp=1007,
      cv= 720,
      lamda=0.0264,
      nue=16.3E-6);
      annotation (Documentation(info="<html>
Medium: properties of air at 30 degC
</html>"));
    end Air_30degC;

    record Air_70degC "Medium: properties of air at 70 degC"
    extends Medium(
      rho=1.015,
      cp=1010,
      cv= 723,
      lamda=0.0293,
      nue=20.3E-6);
      annotation (Documentation(info="<html>
Medium: properties of air at 70 degC
</html>"));
    end Air_70degC;

    record Water "Medium: properties of water"
    extends Medium(
      rho=995.6,
      cp=4177,
      cv=4177,
      lamda=0.615,
      nue=0.8E-6);
      annotation (Documentation(info="<html>
Medium: properties of water
</html>"));
    end Water;
  annotation (Documentation(info="<html>
<p>This package contains definitions of medium properties.</p>

</html>", revisions="<html>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.11 2005/02/18 Anton Haumer<br>
       corrected usage of cv and cp</li>
  </ul>
</html>"));
  end Media;

  package Sensors "Ideal sensors to measure port properties"
    extends Modelica.Icons.SensorsPackage;

    model PressureSensor "Absolute pressure sensor"

      extends Interfaces.Partials.AbsoluteSensor(y(unit="Pa", displayUnit="bar")
          "Absolute pressure as output signal");
    equation
      y = flowPort.p;
    annotation (Documentation(info="<html>
pSensor measures the absolute pressure.<br>
Thermodynamic equations are defined by Partials.AbsoluteSensor.
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
          graphics={Text(
              extent={{-22,-20},{20,-60}},
              lineColor={0,0,255},
              textString="p")}));
    end PressureSensor;

    model TemperatureSensor "Absolute temperature sensor"

      extends Interfaces.Partials.AbsoluteSensor(y(unit="K")
          "Absolute temperature as output signal");
    equation
      medium.cp*y = flowPort.h;
    annotation (Documentation(info="<html>
TSensor measures the absolute temperature (Kelvin).<br>
Thermodynamic equations are defined by Partials.AbsoluteSensor.
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(extent={{-22,-20},{20,-60}},
              lineColor={0,0,255},
              textString="T")}));
    end TemperatureSensor;

    model RelPressureSensor "Pressure difference sensor"

      extends Interfaces.Partials.RelativeSensor(y(unit="Pa", displayUnit="bar")
          "Pressure difference as output signal");
    equation
      y = flowPort_a.p - flowPort_b.p;
    annotation (Documentation(info="<html>
dpSensor measures the pressure drop between flowPort_a and flowPort_b.<br>
Thermodynamic equations are defined by Partials.RelativeSensor.
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(extent={{-22,-20},{20,-60}},
              lineColor={0,0,255},
              textString="dp")}));
    end RelPressureSensor;

    model RelTemperatureSensor "Temperature difference sensor"

      extends Interfaces.Partials.RelativeSensor(y(unit="K")
          "Temperature difference as output signal");
    equation
      medium.cp*y = flowPort_a.h - flowPort_b.h;
    annotation (Documentation(info="<html>
dTSensor measures the temperature difference between flowPort_a and flowPort_b.<br>
Thermodynamic equations are defined by Partials.RelativeSensor.<br>
<b>Note:</b> Connected flowPorts have the same temperature (mixing temperature)!<br>
Since mixing my occur, the outlet temperature of a component may be different from the connector's temperature.<br>
Outlet temperature is defined by variable T of the corresponding component.
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(extent={{-22,-20},{20,-60}},
              lineColor={0,0,255},
              textString="dT")}));
    end RelTemperatureSensor;

    model MassFlowSensor "Mass flow sensor"

      extends Interfaces.Partials.FlowSensor(y(unit="kg/s")
          "Mass flow as output signal");
    equation
      y = V_flow*medium.rho;
    annotation (Documentation(info="<html>
m_flowSensor measures the mass flow rate.<br>
Thermodynamic equations are defined by Partials.FlowSensor.
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(extent={{-22,-20},{20,-60}},
              lineColor={0,0,255},
              textString="m")}));
    end MassFlowSensor;

    model VolumeFlowSensor "Volume flow sensor"

      extends Interfaces.Partials.FlowSensor(y(unit="m3/s")
          "Volume flow as output signal");
    equation
      y = V_flow;
    annotation (Documentation(info="<html>
V_flowSensor measures the volume flow rate.<br>
Thermodynamic equations are defined by Partials.FlowSensor.
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(extent={{-22,-20},{20,-60}},
              lineColor={0,0,255},
              textString="V")}));
    end VolumeFlowSensor;

    model EnthalpyFlowSensor "Enthalpy flow sensor"

      extends Interfaces.Partials.FlowSensor(y(unit="W")
          "Enthalpy flow as output signal");
    equation
      y = flowPort_a.H_flow;
    annotation (Documentation(info="<html>
H_flowSensor measures the enthalpy flow rate.<br>
Thermodynamic equations are defined by Partials.FlowSensor.
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(extent={{-22,-20},{20,-60}},
              lineColor={0,0,255},
              textString="H")}));
    end EnthalpyFlowSensor;
  annotation (Documentation(info="<html>
<p>This package contains sensors:</p>
<ul>
<li>pSensor: absolute pressure</li>
<li>TSensor: absolute temperature (Kelvin)</li>
<li>dpSensor: pressure drop between flowPort_a and flowPort_b</li>
<li>dTSensor: temperature difference between flowPort_a and flowPort_b</li>
<li>m_flowSensor: measures mass flow rate</li>
<li>V_flowSensor: measures volume flow rate</li>
<li>H_flowSensor: measures enthalpy flow rate</li>
</ul>

<p>Some of the sensors do not need access to medium properties for measuring,
but it is necessary to define the medium in the connector (check of connections).
Thermodynamic equations are defined in partial models (package Interfaces.Partials).
All sensors are considered massless, they do not change mass flow or enthalpy flow.</p>

</html>", revisions="<html>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  </ul>
</html>"));
  end Sensors;

  package Sources "Ideal fluid sources, e.g., ambient, volume flow"
    extends Modelica.Icons.SourcesPackage;

    model Ambient "Ambient with constant properties"

      extends Interfaces.Partials.Ambient;
      parameter Boolean usePressureInput=false
        "Enable / disable pressure input"
        annotation(Evaluate=true);
      parameter Modelica.SIunits.Pressure constantAmbientPressure(start=0)
        "Ambient pressure"
        annotation(Dialog(enable=not usePressureInput));
      parameter Boolean useTemperatureInput=false
        "Enable / disable temperature input"
        annotation(Evaluate=true);
      parameter Modelica.SIunits.Temperature constantAmbientTemperature(start=293.15, displayUnit="degC")
        "Ambient temperature"
        annotation(Dialog(enable=not useTemperatureInput));
      Modelica.Blocks.Interfaces.RealInput ambientPressure=pAmbient if usePressureInput
        annotation (Placement(transformation(extent={{110,60},{90,80}})));
      Modelica.Blocks.Interfaces.RealInput ambientTemperature=TAmbient if useTemperatureInput
        annotation (Placement(transformation(extent={{110,-60},{90,-80}})));
    protected
      Modelica.SIunits.Pressure pAmbient;
      Modelica.SIunits.Temperature TAmbient;
    equation
      if not usePressureInput then
        pAmbient = constantAmbientPressure;
      end if;
      if not useTemperatureInput then
        TAmbient = constantAmbientTemperature;
      end if;
      flowPort.p = pAmbient;
      T = TAmbient;
    annotation (Documentation(info="<html>
(Infinite) ambient with constant pressure and temperature.<br>
Thermodynamic equations are defined by Partials.Ambient.
</html>"),        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Text(
              extent={{20,80},{80,20}},
              lineColor={0,0,0},
              textString="p"), Text(
              extent={{20,-20},{80,-80}},
              lineColor={0,0,0},
              textString="T")}));
    end Ambient;

    model AbsolutePressure "Defines absolute pressure level"

      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
        "medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Pressure p(start=0) "Pressure ground";
      Interfaces.FlowPort_a flowPort(final medium=medium)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    equation
      // defining pressure
      flowPort.p = p;
      // no energy exchange; no mass flow by default
      flowPort.H_flow = 0;
    annotation (Documentation(info="<html>
AbsolutePressure to define pressure level of a closed cooling cycle.
Coolant's mass flow, temperature and enthalpy flow are not affected.<br>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(extent={{-150,150},{150,90}},
              lineColor={0,0,255},
              textString="%name"),
           Ellipse(extent={{-90,90},{90,-90}},
              lineColor={255,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
    end AbsolutePressure;

    model VolumeFlow "Enforces constant volume flow"

      extends Interfaces.Partials.TwoPort(final tapT=1);
      parameter Boolean useVolumeFlowInput=false
        "Enable / disable volume flow input"
        annotation(Evaluate=true);
      parameter Modelica.SIunits.VolumeFlowRate constantVolumeFlow(start=1)
        "Volume flow rate"
        annotation(Dialog(enable=not useVolumeFlowInput));
      Modelica.Blocks.Interfaces.RealInput volumeFlow=internalVolumeFlow if useVolumeFlowInput
        annotation (Placement(transformation(
            origin={0,100},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    protected
      Modelica.SIunits.VolumeFlowRate internalVolumeFlow;
    equation
      if not useVolumeFlowInput then
        internalVolumeFlow = constantVolumeFlow;
      end if;
      Q_flow = 0;
      V_flow = internalVolumeFlow;
    annotation (Documentation(info="<html>
Fan resp. pump with constant volume flow rate. Pressure increase is the response of the whole system.
Coolant's temperature and enthalpy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
Thermodynamic equations are defined by Partials.TwoPort.
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Ellipse(
              extent={{-90,90},{90,-90}},
              lineColor={255,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,-90},{150,-150}},
              lineColor={0,0,255},
              textString="%name"),
            Polygon(
              points={{-60,68},{90,10},{90,-10},{-60,-68},{-60,68}},
              lineColor={255,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-40,20},{0,-20}},
              lineColor={0,0,0},
              textString="V")}));
    end VolumeFlow;

    model PressureIncrease "Enforces constant pressure increase"

      extends Interfaces.Partials.TwoPort(final tapT=1);
      parameter Boolean usePressureIncreaseInput=false
        "Enable / disable pressure increase input"
        annotation(Evaluate=true);
      parameter Modelica.SIunits.Pressure constantPressureIncrease(start=1)
        "Pressure increase"
        annotation(Dialog(enable=not usePressureIncreaseInput));
      Modelica.Blocks.Interfaces.RealInput pressureIncrease=internalPressureIncrease if usePressureIncreaseInput
        annotation (Placement(transformation(
            origin={0,100},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    protected
      Modelica.SIunits.Pressure internalPressureIncrease;
    equation
      if not usePressureIncreaseInput then
        internalPressureIncrease = constantPressureIncrease;
      end if;
      Q_flow = 0;
      dp = -internalPressureIncrease;
    annotation (Documentation(info="<html>
Fan resp. pump with constant pressure increase. Mass resp. volume flow is the response of the whole system.
Coolant's temperature and enthalpy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
Thermodynamic equations are defined by Partials.TwoPort.
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Ellipse(
              extent={{-90,90},{90,-90}},
              lineColor={255,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,-90},{150,-150}},
              lineColor={0,0,255},
              textString="%name"),
            Polygon(
              points={{-60,68},{90,10},{90,-10},{-60,-68},{-60,68}},
              lineColor={0,0,255},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-40,20},{0,-20}},
              lineColor={0,0,0},
              textString="dp")}));
    end PressureIncrease;

    model IdealPump "Model of an ideal pump"

      extends Interfaces.Partials.TwoPort(final tapT=1);
      parameter Modelica.SIunits.AngularVelocity wNominal(start=1, displayUnit="rev/min")
        "Nominal speed"
          annotation(Dialog(group="Pump characteristic"));
      parameter Modelica.SIunits.Pressure dp0(start=2)
        "Max. pressure increase @ V_flow=0"
          annotation(Dialog(group="Pump characteristic"));
      parameter Modelica.SIunits.VolumeFlowRate V_flow0(start=2)
        "Max. volume flow rate @ dp=0"
          annotation(Dialog(group="Pump characteristic"));
      Modelica.SIunits.AngularVelocity w=der(flange_a.phi) "Speed";
    protected
      Modelica.SIunits.Pressure dp1;
      Modelica.SIunits.VolumeFlowRate V_flow1;
    public
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    equation
      // pump characteristic
      dp1 = dp0*sign(w/wNominal)*(w/wNominal)^2;
      V_flow1 = V_flow0*(w/wNominal);
      if noEvent(abs(w)<Modelica.Constants.small) then
        dp = 0;
        flange_a.tau = 0;
      else
        dp = -dp1*(1-noEvent(abs(V_flow/V_flow1)));
        flange_a.tau*w = -dp*V_flow;
      end if;
      // no energy exchange with medium
      Q_flow = 0;
    annotation (Documentation(info="<html>
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
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Ellipse(
              extent={{-90,90},{90,-90}},
              lineColor={255,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,150},{150,90}},
              lineColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-10,-40},{10,-100}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={175,175,175}),
            Polygon(
              points={{-60,68},{90,10},{90,-10},{-60,-68},{-60,68}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,0,255})}));
    end IdealPump;
  annotation (Documentation(info="<html>
This package contains different types of sources:
<ul>
<li>Ambient with constant or prescribed pressure and temperature</li>
<li>AbsolutePressure to define pressure level of a closed cooling cycle.</li>
<li>Constant and prescribed volume flow</li>
<li>Constant and prescribed pressure increase</li>
<li>Simple pump with mechanical flange</li>
</ul>
<p>Thermodynamic equations are defined in partial models (package Interfaces.Partials).
All fans / pumps are considered without losses, they do not change enthalpy flow.</p>

</html>", revisions="<html>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.20 Beta 2005/02/18 Anton Haumer<br>
       <i>new model: IdealPump</i></li>
  </ul>
</html>"));
  end Sources;

  package Interfaces "Connectors and partial models"
    extends Modelica.Icons.InterfacesPackage;

    connector FlowPort "Connector flow port"

      parameter FluidHeatFlow.Media.Medium medium "Medium in the connector";
      Modelica.SIunits.Pressure p;
      flow Modelica.SIunits.MassFlowRate m_flow;
      Modelica.SIunits.SpecificEnthalpy h;
      flow Modelica.SIunits.EnthalpyFlowRate H_flow;
    annotation (Documentation(info="<html>
Basic definition of the connector.<br>
<b>Variables:</b>
<ul>
<li>Pressure p</li>
<li>flow MassFlowRate m_flow</li>
<li>Specific Enthalpy h</li>
<li>flow EnthaplyFlowRate H_flow</li>
</ul>
If ports with different media are connected, the simulation is asserted due to the check of parameter.
</html>"));
    end FlowPort;

    connector FlowPort_a "Filled flow port (used upstream)"

      extends FlowPort;
    annotation (Documentation(info="<html>
Same as FlowPort, but icon allows to differentiate direction of flow.
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Ellipse(
              extent={{-98,98},{98,-98}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
                                             Diagram(coordinateSystem(
              preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics={
            Rectangle(
              extent={{-50,50},{50,-50}},
              lineColor={255,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-48,48},{48,-48}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-100,110},{100,50}},
              lineColor={0,0,255},
              textString="%name")}));
    end FlowPort_a;

    connector FlowPort_b "Hollow flow port (used downstream)"

      extends FlowPort;
    annotation (Documentation(info="<html>
Same as FlowPort, but icon allows to differentiate direction of flow.
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Ellipse(extent={{-98,98},{98,-98}},
                lineColor={0,0,255})}),      Diagram(coordinateSystem(
              preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
            graphics={
            Rectangle(
              extent={{-50,50},{50,-50}},
              lineColor={255,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(extent={{-48,48},{48,-48}}, lineColor={0,0,255}),
            Text(
              extent={{-100,110},{100,50}},
              lineColor={0,0,255},
              textString="%name")}));
    end FlowPort_b;

    package Partials "Partial models"
      extends Modelica.Icons.Package;

      partial model SimpleFriction "Simple friction model"

        parameter Modelica.SIunits.VolumeFlowRate V_flowLaminar(min=Modelica.Constants.small, start=0.1)
          "Laminar volume flow"
          annotation(Dialog(group="Simple Friction"));
        parameter Modelica.SIunits.Pressure dpLaminar(start=0.1)
          "Laminar pressure drop"
          annotation(Dialog(group="Simple Friction"));
        parameter Modelica.SIunits.VolumeFlowRate V_flowNominal(start=1)
          "Nominal volume flow"
          annotation(Dialog(group="Simple Friction"));
        parameter Modelica.SIunits.Pressure dpNominal(start=1)
          "Nominal pressure drop"
          annotation(Dialog(group="Simple Friction"));
        parameter Real frictionLoss(min=0, max=1) = 0
          "Part of friction losses fed to medium"
          annotation(Dialog(group="Simple Friction"));
        Modelica.SIunits.Pressure pressureDrop;
        Modelica.SIunits.VolumeFlowRate volumeFlow;
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
        if     volumeFlow > +V_flowLaminar then
          pressureDrop = +dpLaminar/V_flowLaminar*volumeFlow + k*(volumeFlow - V_flowLaminar)^2;
        elseif volumeFlow < -V_flowLaminar then
          pressureDrop = +dpLaminar/V_flowLaminar*volumeFlow - k*(volumeFlow + V_flowLaminar)^2;
        else
          pressureDrop =  dpLaminar/V_flowLaminar*volumeFlow;
        end if;
        Q_friction = frictionLoss*volumeFlow*pressureDrop;
      annotation (Documentation(info="<html>
Definition of relationship between pressure drop and volume flow rate:<br>
-V_flowLaminar &lt; VolumeFlow &lt; +V_flowLaminar: laminar i.e., linear dependency of pressure drop on volume flow.<br>
-V_flowLaminar &gt; VolumeFlow or VolumeFlow &lt; +V_flowLaminar: turbulent i.e., quadratic dependency of pressure drop on volume flow.<br>
Linear and quadratic dependency are coupled smoothly at V_flowLaminar / dpLaminar.<br>
Quadratic dependency is defined by nominal volume flow and pressure drop (V_flowNominal / dpNominal).<br>
See also sketch at diagram layer.
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={
              Line(points={{-80,0},{80,0}}, color={0,0,255}),
              Line(points={{0,80},{0,-80}}, color={0,0,255}),
              Line(points={{-40,-20},{40,20}}, color={0,0,255}),
              Line(points={{40,20},{60,40},{70,60},{74,80}}, color={0,0,255}),
              Line(points={{-40,-20},{-60,-40},{-70,-60},{-74,-80}}, color={0,0,
                    255}),
              Line(points={{40,20},{40,0}}, color={0,0,255}),
              Line(points={{60,40},{60,0}}, color={0,0,255}),
              Line(points={{40,20},{0,20}}, color={0,0,255}),
              Line(points={{60,40},{0,40}}, color={0,0,255}),
              Text(
                extent={{18,0},{48,-20}},
                lineColor={0,0,255},
                textString="V_flowLaminar"),
              Text(
                extent={{50,0},{80,-20}},
                lineColor={0,0,255},
                textString="V_flowNominal"),
              Text(
                extent={{-30,30},{-4,10}},
                lineColor={0,0,255},
                textString="dpLaminar"),
              Text(
                extent={{-30,50},{-4,30}},
                lineColor={0,0,255},
                textString="dpNominal"),
              Text(
                extent={{0,20},{30,0}},
                lineColor={0,0,255},
                textString="dp ~ V_flow"),
              Text(
                extent={{30,60},{60,40}},
                lineColor={0,0,255},
                textString="dp ~ V_flow^2")}));
      end SimpleFriction;

      partial model TwoPort "Partial model of two port"

        parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
          "Medium in the component"
          annotation(choicesAllMatching=true);
        parameter Modelica.SIunits.Mass m(start=1) "Mass of medium";
        parameter Modelica.SIunits.Temperature T0(start=293.15, displayUnit="degC")
          "Initial temperature of medium"
          annotation(Dialog(enable=m>Modelica.Constants.small));
        parameter Boolean T0fixed=false
          "Initial temperature guess value or fixed"
        annotation(choices(checkBox=true),Dialog(enable=m>Modelica.Constants.small));
        parameter Real tapT(final min=0, final max=1)=1
          "Defines temperature of heatPort between inlet and outlet temperature";
        Modelica.SIunits.Pressure dp "Pressure drop a->b";
        Modelica.SIunits.VolumeFlowRate V_flow "Volume flow a->b";
        Modelica.SIunits.HeatFlowRate Q_flow "Heat exchange with ambient";
        output Modelica.SIunits.Temperature T(start=T0, fixed=T0fixed)
          "Outlet temperature of medium";
        output Modelica.SIunits.Temperature T_a "Temperature at flowPort_a";
        output Modelica.SIunits.Temperature T_b "Temperature at flowPort_b";
        output Modelica.SIunits.TemperatureDifference dT
          "Temperature increase of coolant in flow direction";
      protected
        Modelica.SIunits.SpecificEnthalpy h "Medium's specific enthalpy";
        Modelica.SIunits.Temperature T_q
          "Temperature relevant for heat exchange with ambient";
      public
        Interfaces.FlowPort_a flowPort_a(final medium=medium)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Interfaces.FlowPort_b flowPort_b(final medium=medium)
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      equation
        dp=flowPort_a.p - flowPort_b.p;
        V_flow=flowPort_a.m_flow/medium.rho;
        T_a=flowPort_a.h/medium.cp;
        T_b=flowPort_b.h/medium.cp;
        dT=if noEvent(V_flow>=0) then T-T_a else T_b-T;
        h = medium.cp*T;
        T_q = T  - noEvent(sign(V_flow))*(1 - tapT)*dT;
        // mass balance
        flowPort_a.m_flow + flowPort_b.m_flow = 0;
        // energy balance
        if m>Modelica.Constants.small then
          flowPort_a.H_flow + flowPort_b.H_flow + Q_flow = m*medium.cv*der(T);
        else
          flowPort_a.H_flow + flowPort_b.H_flow + Q_flow = 0;
        end if;
        // mass flow a->b mixing rule at a, energy flow at b defined by medium's temperature
        // mass flow b->a mixing rule at b, energy flow at a defined by medium's temperature
        flowPort_a.H_flow = semiLinear(flowPort_a.m_flow,flowPort_a.h,h);
        flowPort_b.H_flow = semiLinear(flowPort_b.m_flow,flowPort_b.h,h);
      annotation (Documentation(info="<html>
Partial model with two flowPorts.<br>
Possible heat exchange with the ambient is defined by Q_flow; setting this = 0 means no energy exchange.<br>
Setting parameter m (mass of medium within pipe) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
Mixing rule is applied.<br>
Parameter 0 &lt; tapT &lt; 1 defines temperature of heatPort between medium's inlet and outlet temperature.
</html>"));
      end TwoPort;

      partial model Ambient "Partial model of ambient"

        parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
          "Ambient medium"
          annotation(choicesAllMatching=true);
        output Modelica.SIunits.Temperature T "Outlet temperature of medium";
        output Modelica.SIunits.Temperature T_port "Temperature at flowPort_a";
      protected
        Modelica.SIunits.SpecificEnthalpy h;
      public
        Interfaces.FlowPort_a flowPort(final medium=medium)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      equation
        T_port=flowPort.h/medium.cp;
        h = medium.cp*T;
        // mass flow -> ambient: mixing rule
        // mass flow <- ambient: energy flow defined by ambient's temperature
        flowPort.H_flow = semiLinear(flowPort.m_flow,flowPort.h,h);
      annotation (Documentation(info="<html>
<p>
Partial model of (Infinite) ambient, defines pressure and temperature.
</p>
</html>"),   Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={Ellipse(
                extent={{-90,90},{90,-90}},
                lineColor={255,0,0},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid), Text(
                extent={{-150,150},{150,90}},
                lineColor={0,0,255},
                textString="%name")}));
      end Ambient;

      partial model AbsoluteSensor "Partial model of absolute sensor"
        extends Modelica.Icons.RotationalSensor;

        parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
          "Sensor's medium"
          annotation(choicesAllMatching=true);
        Interfaces.FlowPort_a flowPort(final medium=medium)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        // no mass exchange
        flowPort.m_flow = 0;
        // no energy exchange
        flowPort.H_flow = 0;
      annotation (Documentation(info="<html>
Partial model for an absolute sensor (pressure/temperature).<br>
Pressure, mass flow, temperature and enthalpy flow of medium are not affected.
</html>"),          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Line(points={{-70,0},{-90,0}}),
              Line(points={{70,0},{100,0}}),
              Text(
                extent={{-150,130},{150,70}},
                lineColor={0,0,255},
                textString="%name")}));
      end AbsoluteSensor;

      partial model RelativeSensor "Partial model of relative sensor"
        extends Modelica.Icons.RotationalSensor;

        parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
          "Sensor's medium"
          annotation(choicesAllMatching=true);
        Interfaces.FlowPort_a flowPort_a(final medium=medium)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Interfaces.FlowPort_b flowPort_b(final medium=medium)
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(
              origin={0,-110},
              extent={{10,-10},{-10,10}},
              rotation=90)));
      equation
        // no mass exchange
        flowPort_a.m_flow = 0;
        flowPort_b.m_flow = 0;
        // no energy exchange
        flowPort_a.H_flow = 0;
        flowPort_b.H_flow = 0;
      annotation (Documentation(info="<html>
Partial model for a relative sensor (pressure drop/temperature difference).<br>
Pressure, mass flow, temperature and enthalpy flow of medium are not affected.
</html>"),          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Line(points={{-70,0},{-90,0}}),
              Line(points={{70,0},{90,0}}),
              Line(points={{0,-100},{0,-70}}),
              Text(
                extent={{-150,130},{150,70}},
                lineColor={0,0,255},
                textString="%name")}));
      end RelativeSensor;

      partial model FlowSensor "Partial model of flow sensor"
        extends Modelica.Icons.RotationalSensor;
        extends TwoPort(final m=0, final T0=0, final tapT=1);
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(
              origin={0,-110},
              extent={{10,-10},{-10,10}},
              rotation=90)));
      equation
        // no pressure drop
        dp = 0;
        // no energy exchange
        Q_flow = 0;
      annotation (Documentation(info="<html>
Partial model for a flow sensor (mass flow/heat flow).<br>
Pressure, mass flow, temperature and enthalpy flow of medium are not affected, but mixing rule is applied.
</html>"),          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Line(points={{-70,0},{-90,0}}),
              Line(points={{70,0},{90,0}}),
              Line(points={{0,-100},{0,-70}}),
              Text(
                extent={{-150,130},{150,70}},
                lineColor={0,0,255},
                textString="%name")}));
      end FlowSensor;
    annotation (Documentation(info="<html>

</html>",revisions="<html>
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
</html>"));
    end Partials;
  annotation (Documentation(info="<html>
<p>This package contains connectors and partial models:</p>
<ul>
<li>FlowPort: basic definition of the connector.</li>
<li>FlowPort_a &amp; FlowPort_b: same as FlowPort with different icons to differentiate direction of flow</li>
<li>package Partials (defining basic thermodynamic equations)</li>
</ul>

</html>", revisions="<html>
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
</html>"));
  end Interfaces;
  annotation (
    Documentation(info="<html>
<p>This package contains very simple-to-use components to model coolant flows as needed to simulate cooling e.g., of electric machines:</p>
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
<p>EnthalpyFlowRate means the Enthalpy = cp<sub>constant</sub> * m * T that is carried by the medium's flow.</p>
<b>Limitations and assumptions:</b>
<ul>
<li>Splitting and mixing of coolant flows (media with the same cp) is possible.</li>
<li>Reversing the direction of flow is possible.</li>
<li>The medium is considered to be incompressible.</li>
<li>No mixtures of media is taken into consideration.</li>
<li>The medium may not change its phase.</li>
<li>Medium properties are kept constant.</li>
<li>Pressure changes are only due to pressure drop and geodetic height difference rho*g*h (if h > 0).</li>
<li>A user-defined part (0..1) of the friction losses (V_flow*dp) are fed to the medium.</li>
<li><b>Note:</b> Connected flowPorts have the same temperature (mixing temperature)!<br>
Since mixing may occur, the outlet temperature may be different from the connector's temperature.<br>
Outlet temperature is defined by variable T of the corresponding component.</li>
</ul>
<b>Further development:</b>
<ul>
<li>Additional components like tanks (if needed)</li>
</ul>

<p>
Copyright &copy; 1998-2016, Modelica Association, Anton Haumer, Christian Kral and AIT.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>", revisions="<html>

</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={
      Polygon(
        origin = {11.533,37.938},
        lineColor = {0,128,255},
        fillColor = {0,128,255},
        fillPattern = FillPattern.Solid,
        points = {{-80,10},{-60,-10},{-80,-30},{-20,-30},{0,-10},{-20,10},{-80,10}}),
      Polygon(
        origin = {11.533,37.938},
        lineColor = {255,0,0},
        fillColor = {255,0,0},
        fillPattern = FillPattern.Solid,
        points = {{-40,-90},{-20,-70},{0,-90},{0,-50},{-20,-30},{-40,-50},{-40,-90}}),
      Polygon(
        origin = {11.533,37.938},
        lineColor = {255,128,0},
        fillColor = {255,128,0},
        fillPattern = FillPattern.Solid,
        points = {{-20,10},{0,-10},{-20,-30},{40,-30},{60,-10},{40,10},{-20,10}})}));
end FluidHeatFlow;
