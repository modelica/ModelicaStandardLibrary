within Modelica.Thermal;
package FluidHeatFlow
  "Simple components for 1-dimensional incompressible thermo-fluid flow models"
  extends Modelica.Icons.Package;

  package UsersGuide "User's Guide"
    extends Modelica.Icons.Information;

    class Contact "Contact"
      extends Modelica.Icons.Contact;
      annotation (Documentation(info="<html>
<h4>Library officers</h4>

<p>
<strong>Anton Haumer</strong><br>
<a href=\"https://www.haumer.at\">Technical Consulting &amp; Electrical Engineering</a><br>
93049 Regensburg, Germany<br>
email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
</p>

<p>
<strong>Dr. Christian Kral</strong><br>
<a href=\"https://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
A-1060 Vienna, Austria<br>
email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a>
</p>

<h4>Acknowledgements</h4>

<p>
Copyright &copy; 1998-2018, Modelica Association, Anton Haumer, Christian Kral and AIT.
</p>

</html>"));
    end Contact;

    class ReleaseNotes "Release Notes"
      extends Modelica.Icons.ReleaseNotes;
      annotation (Documentation(info="<html>

  <h5>3.2.3, 2018-05-28 (Anton Haumer)</h5>
  <ul>
  <li> Fixed a bug in the IdealPump model</li>
  <li> Added a simple open tank model</li>
  <li> Added a simple piston/cylinder model</li>
  <li> Added some more media</li>
  <li> Added some more examples</li>
  </ul>

  <h5>3.2.2, 2010-06-25 (Christian Kral)</h5>
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
  <li> New parameter tapT defining Temperature of heatPort</li>
  </ul>

  <h5>1.5.0 2005-09-07 (Anton Haumer)</h5>
  <ul>
  <li> SemiLinear works fine</li>
  </ul>

  <h5>1.4.3 Beta 2005-06-20 (Anton Haumer)</h5>
  <ul>
  <li> Test of mixing / semiLinear</li>
  <li>New test example: OneMass</li>
  <li>New test example: TwoMass</li>
  </ul>

  <h5>1.4.2 Beta, 2005-06-18 (Anton Haumer)</h5>
  <ul>
  <li> New test example: ParallelPumpDropOut</li>
  </ul>

  <h5>1.4.0, 2005-06-13 (Anton Haumer)</h5>
  <ul>
  <li> Stable release</li>
  </ul>

  <h5>1.3.3 Beta, 2005-06-07 (Anton Haumer)</h5>
  <ul>
  <li> Corrected usage of simpleFlow</li>
  </ul>

  <h5>1.3.1 Beta, 2005/06/04 Anton Haumer</h5>
  <ul>
  <li>New example: PumpAndValve</li>
  <li>New example: PumpDropOut</li>
  </ul>

  <h5>1.3.0 Beta, 2005-06-02 (Anton Haumer)</h5>
  <ul>
  <li> Friction losses are fed to medium</li>
  </ul>

  <h5>1.2.0 Beta, 2005-02-18 (Anton Haumer)</h5>
  <ul>
  <li>Introduced geodetic height in Components.Pipes</li>
  <li>New models: Components.Valve, Sources.IdealPump</li>
  </ul>

  <h5>1.1.1, 2005-02-18 (Anton Haumer)</h5>
  <ul>
  <li>Corrected usage of cv and cp</li>
  </ul>

  <h5>1.1.0, 2005-02-15 (Anton Haumer)</h5>
  <ul>
  <li>Reorganisation of the package</li>
  </ul>

  <h5>1.0.0, 2005-02-01 (Anton Haumer)</h5>
  <ul>
  <li>First stable official release</li>
  </ul>

</html>"));
    end ReleaseNotes;

    annotation (DocumentationClass=true,
    Documentation(info="<html>
<p>
This library provides simple components for 1-dimensional incompressible thermo-fluid flow models.
</p>
</html>"));
  end UsersGuide;

  package Examples
    "Examples that demonstrate the usage of the FluidHeatFlow components"
    extends Modelica.Icons.ExamplesPackage;

    model SimpleCooling "Simple cooling circuit"
      extends Modelica.Icons.Example;

      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource=
        prescribedHeatFlow.port.T-TAmb "Source over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=prescribedHeatFlow.port.T-pipe.T_q
        "Source over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=pipe.dT
        "Coolant's temperature increase";
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
      Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true,
        constantVolumeFlow=1)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium,
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
      connect(heatFlow.y, prescribedHeatFlow.Q_flow) annotation (Line(points={
              {-39,-50},{-30,-50}}, color={0,0,255}));
      connect(convection.solid, prescribedHeatFlow.port) annotation (Line(
            points={{10,-40},{10,-50},{-10,-50}}, color={191,0,0}));
      connect(convection.solid, heatCapacitor.port) annotation (Line(points={
              {10,-40},{10,-50},{30,-50}}, color={191,0,0}));
      connect(pipe.heatPort, convection.fluid) annotation (Line(points={{10,
              -10},{10,-20}}, color={191,0,0}));
      connect(thermalConductance.y, convection.Gc)
                                   annotation (Line(points={{-9,-30},{0,-30}}, color={0,0,127}));
      connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
          points={{-39,20},{-30,20},{-30,10}}, color={0,0,127}));
    annotation (Documentation(info="<html>
<p>
1st test example: SimpleCooling
</p>
A prescribed heat source dissipates its heat through a thermal conductor to a coolant flow. The coolant flow is taken from an ambient and driven by a pump with prescribed mass flow.<br>
<strong>Results</strong>:<br>
<table>
<tr>
<td><strong>output</strong></td>
<td><strong>explanation</strong></td>
<td><strong>formula</strong></td>
<td><strong>actual steady-state value</strong></td>
</tr>
<tr>
<td>dTSource</td>
<td>Source over Ambient</td>
<td>dtCoolant + dtToPipe</td>
<td>20 K</td>
</tr>
<tr>
<td>dTtoPipe</td>
<td>Source over Coolant</td>
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
</html>"),        experiment(StopTime=1.0, Interval=0.001));
    end SimpleCooling;

    model ParallelCooling "Cooling circuit with parallel branches"
      extends Modelica.Icons.Example;

      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource1=
        prescribedHeatFlow1.port.T-TAmb "Source1 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe1=prescribedHeatFlow1.port.T-pipe1.T_q
        "Source1 over Coolant1";
      output Modelica.SIunits.TemperatureDifference dTCoolant1=pipe1.dT
        "Coolant1's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTSource2=
        prescribedHeatFlow2.port.T-TAmb "Source2 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe2=prescribedHeatFlow2.port.T-pipe2.T_q
        "Source2 over Coolant2";
      output Modelica.SIunits.TemperatureDifference dTCoolant2=pipe2.dT
        "Coolant2's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTmixedCoolant=ambient2.T_port-ambient1.T_port
        "mixed Coolant's temperature increase";
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
      Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true,
        constantVolumeFlow=1)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe1(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{0,-20},{20,0}})));
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe2(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{0,20},{20,0}})));
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe3(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true,
        useHeatPort=false)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium,
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
                                    annotation (Line(points={{-9,-40},{0,-40}}, color={0,0,127}));
      connect(pipe1.heatPort,convection1. fluid) annotation (Line(points={{10,-20},{
              10,-30}}, color={191,0,0}));
      connect(convection2.fluid,pipe2. heatPort) annotation (Line(points={{10,
              30},{10,20}}, color={191,0,0}));
      connect(convection2.solid,prescribedHeatFlow2. port) annotation (Line(
            points={{10,50},{10,60},{-10,60}}, color={191,0,0}));
      connect(convection2.solid,heatCapacitor2. port) annotation (Line(points={{10,50},
              {10,60},{28,60}}, color={191,0,0}));
      connect(convection1.solid,prescribedHeatFlow1. port) annotation (Line(
            points={{10,-50},{10,-60},{-10,-60}}, color={191,0,0}));
      connect(convection1.solid,heatCapacitor1. port) annotation (Line(points={{10,-50},
              {10,-60},{30,-60}}, color={191,0,0}));
      connect(pipe2.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,10},
              {30,10},{30,0},{40,0}},     color={255,0,0}));
      connect(pipe1.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,-10},
              {30,-10},{30,0},{40,0}},      color={255,0,0}));
      connect(pipe3.flowPort_b,ambient2. flowPort)
        annotation (Line(points={{60,0},{80,0}}, color={255,0,0}));
      connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
          points={{-39,20},{-30,20},{-30,10}}, color={0,0,127}));
    annotation (Documentation(info="<html>
<p>
2nd test example: ParallelCooling
</p>
Two prescribed heat sources dissipate their heat through thermal conductors to coolant flows. The coolant flow is taken from an ambient and driven by a pump with prescribed mass flow, then split into two coolant flows connected to the two heat sources, and afterwards merged. Splitting of coolant flows is determined by pressure drop characteristic of the two pipes.<br>
<strong>Results</strong>:<br>
<table>
<tr>
<td><strong>output</strong></td>
<td><strong>explanation</strong></td>
<td><strong>formula</strong></td>
<td><strong>actual steady-state value</strong></td>
</tr>
<tr>
<td>dTSource1</td>
<td>Source1 over Ambient</td>
<td>dTCoolant1 + dTtoPipe1</td>
<td>15 K</td>
</tr>
<tr>
<td>dTtoPipe1</td>
<td>Source1 over Coolant1</td>
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
<td>Source2 over Coolant2</td>
<td>Losses2 / ThermalConductor2.G</td>
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
</html>"),        experiment(StopTime=1.0, Interval=0.001));
    end ParallelCooling;

    model IndirectCooling "Indirect cooling circuit"
      extends Modelica.Icons.Example;
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium outerMedium=Modelica.Thermal.FluidHeatFlow.Media.Medium()
        "Outer medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium innerMedium=Modelica.Thermal.FluidHeatFlow.Media.Medium()
        "Inner medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource=
        prescribedHeatFlow.port.T-TAmb "Source over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=prescribedHeatFlow.port.T-pipe1.T_q
        "Source over inner Coolant";
      output Modelica.SIunits.TemperatureDifference dTinnerCoolant=pipe1.dT
        "inner Coolant's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTCooler=innerPipe.T_q-outerPipe.T_q
        "Cooler's temperature increase between inner and outer pipes";
      output Modelica.SIunits.TemperatureDifference dTouterCoolant=outerPipe.dT
        "outer Coolant's temperature increase";
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=outerMedium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{-60,60},{-80,80}})));
      Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow outerPump(
        medium=outerMedium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true,
        constantVolumeFlow=1)
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=outerMedium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{40,60},{60,80}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor
        thermalConductor(G=1)
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
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe1(
        medium=innerMedium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=1,
        V_flowNominal=2,
        h_g=0,
        T0fixed=true,
        useHeatPort=true,
        dpLaminar=1000,
        dpNominal=2000)
        annotation (Placement(transformation(extent={{20,-50},{0,-30}})));
      Modelica.Thermal.FluidHeatFlow.Sources.AbsolutePressure absolutePressure(p=10000, medium=innerMedium)
        annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
      Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow innerPump(
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
      Modelica.Thermal.FluidHeatFlow.Components.Pipe outerPipe(
        medium=outerMedium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{0,60},{20,80}})));
      Modelica.Thermal.FluidHeatFlow.Components.Pipe innerPipe(
        medium=innerMedium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true,
        useHeatPort=true)
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
      connect(innerPipe.flowPort_b, absolutePressure.flowPort) annotation (Line(
            points={{20,-20},{40,-20},{40,-30}}, color={255,0,0}));
      connect(outerPump.flowPort_b, outerPipe.flowPort_a)
        annotation (Line(points={{-20,70},{0,70}}, color={255,0,0}));
      connect(outerPipe.flowPort_b,ambient2. flowPort)
        annotation (Line(points={{20,70},{40,70}}, color={255,0,0}));
      connect(outerPipe.heatPort, outerConvection.fluid)
        annotation (Line(points={{10,60},{10,55},{10,50}}, color={191,0,0}));
      connect(outerConvection.solid, innerConvection.solid)
        annotation (Line(points={{10,30},{10,20},{10,20}}, color={191,0,0}));
      connect(innerConvection.fluid, innerPipe.heatPort)
        annotation (Line(points={{10,0},{10,-5},{10,-10}}, color={191,0,0}));
      connect(innerGc.y, innerConvection.Gc)
        annotation (Line(points={{-19,10},{-9.5,10},{-9.5,10},{0,10}}, color={0,0,127}));
      connect(outerGc.y, outerConvection.Gc)
        annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
      connect(outerVolumeFlow.y, outerPump.volumeFlow) annotation (Line(
          points={{-39,90},{-30,90},{-30,80}}, color={0,0,127}));
      connect(innerVolumeFlow.y, innerPump.volumeFlow) annotation (Line(
          points={{-39,-30},{-30,-30}}, color={0,0,127}));
    annotation (Documentation(info="<html>
<p>
3rd test example: IndirectCooling
</p>
A prescribed heat sources dissipates its heat through a thermal conductor to the inner coolant cycle. It is necessary to define the pressure level of the inner coolant cycle. The inner coolant cycle is coupled to the outer coolant flow through a thermal conductor.<br>
Inner coolant's temperature rise near the source is the same as temperature drop near the cooler.<br>
<strong>Results</strong>:<br>
<table>
<tr>
<td><strong>output</strong></td>
<td><strong>explanation</strong></td>
<td><strong>formula</strong></td>
<td><strong>actual steady-state value</strong></td>
</tr>
<tr>
<td>dTSource</td>
<td>Source over Ambient</td>
<td>dtouterCoolant + dtCooler + dTinnerCoolant + dtToPipe</td>
<td>40 K</td>
</tr>
<tr>
<td>dTtoPipe</td>
<td>Source over inner Coolant</td>
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
</html>"),        experiment(StopTime=1.5, Interval=0.001));
    end IndirectCooling;

    model PumpAndValve "Cooling circuit with pump and valve"
      extends Modelica.Icons.Example;
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource=
        prescribedHeatFlow.port.T-TAmb "Source over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=prescribedHeatFlow.port.T-pipe.T_q
        "Source over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=pipe.dT
        "Coolant's temperature increase";
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{-70,-10},{-90,10}})));
      Modelica.Thermal.FluidHeatFlow.Sources.IdealPump idealPump(
        medium=medium,
        m=0,
        T0=TAmb,
        V_flow0=2,
        wNominal(displayUnit="rad/s") = 1,
        dp0(displayUnit="Pa") = 2)
        annotation (Placement(transformation(extent={{-60,10},{-40,-10}})));
      Modelica.Thermal.FluidHeatFlow.Components.Valve valve(
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
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe(
        medium=medium,
        T0=TAmb,
        m=0.1,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
        C=0.1, T(start=TAmb, fixed=true))
        annotation (Placement(transformation(
            origin={40,-50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
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
        startTime=0.4) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.Ramp valveRamp(
        height=0.5,
        offset=0.5,
        duration=0.1,
        startTime=0.9) annotation (Placement(transformation(extent={{12,40},{-8,60}})));
    equation
      connect(pipe.flowPort_b, ambient2.flowPort)
        annotation (Line(points={{20,0},{40,0}}, color={255,0,0}));
      connect(heatFlow.y, prescribedHeatFlow.Q_flow) annotation (Line(points={
              {-39,-50},{-30,-50}}, color={0,0,255}));
      connect(convection.solid, prescribedHeatFlow.port) annotation (Line(
            points={{10,-40},{10,-50},{-10,-50}}, color={191,0,0}));
      connect(convection.solid, heatCapacitor.port) annotation (Line(points={
              {10,-40},{10,-50},{30,-50}}, color={191,0,0}));
      connect(pipe.heatPort, convection.fluid) annotation (Line(points={{10,
              -10},{10,-20}}, color={191,0,0}));
      connect(thermalConductance.y, convection.Gc)
        annotation (Line(points={{-9,-30},{0,-30}}, color={0,0,127}));
      connect(ambient1.flowPort, idealPump.flowPort_a)
        annotation (Line(points={{-70,0},{-60,0}}, color={255,0,0}));
      connect(idealPump.flowPort_b, valve.flowPort_a)
        annotation (Line(points={{-40,0},{-30,0}}, color={255,0,0}));
      connect(valve.flowPort_b, pipe.flowPort_a)
        annotation (Line(points={{-10,0},{0,0}}, color={255,0,0}));
      connect(speedRamp.y, speed.w_ref)
        annotation (Line(points={{-59,50},{-50,50},{-50,42}}, color={0,0,127}));
      connect(valveRamp.y, valve.y)
        annotation (Line(points={{-9,50},{-20,50},{-20,10}},color={0,0,127}));
      connect(speed.flange, idealPump.flange_a)
        annotation (Line(points={{-50,20},{-50,10}}));
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

    model PumpDropOut "Cooling circuit with drop out of pump"
      extends Modelica.Icons.Example;
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource=
        prescribedHeatFlow.port.T-TAmb "Source over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=prescribedHeatFlow.port.T-pipe.T_q
        "Source over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=pipe.dT
        "Coolant's temperature increase";
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
      Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true,
        constantVolumeFlow=1)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe(
        medium=medium,
        T0=TAmb,
        m=0.1,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
        C=0.1, T(start=TAmb, fixed=true))
        annotation (Placement(transformation(
            origin={40,-50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
        annotation (Placement(transformation(extent={{-30,-40},{-10,-60}})));
      Modelica.Thermal.FluidHeatFlow.Examples.Utilities.DoubleRamp volumeFlow
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
      connect(heatFlow.y, prescribedHeatFlow.Q_flow) annotation (Line(points={
              {-39,-50},{-30,-50}}, color={0,0,255}));
      connect(convection.solid, prescribedHeatFlow.port) annotation (Line(
            points={{10,-40},{10,-50},{-10,-50}}, color={191,0,0}));
      connect(convection.solid, heatCapacitor.port) annotation (Line(points={
              {10,-40},{10,-50},{30,-50}}, color={191,0,0}));
      connect(pipe.heatPort, convection.fluid) annotation (Line(points={{10,
              -10},{10,-20}}, color={191,0,0}));
      connect(thermalConductance.y, convection.Gc)
        annotation (Line(points={{-9,-30},{0,-30}}, color={0,0,127}));
      connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
          points={{-39,20},{-30,20},{-30,10}}, color={0,0,127}));
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
      "Cooling circuit with parallel branches and drop out of pump"
      extends Modelica.Icons.Example;
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource1=
        prescribedHeatFlow1.port.T-TAmb "Source1 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe1=prescribedHeatFlow1.port.T-pipe1.T_q
        "Source1 over Coolant1";
      output Modelica.SIunits.TemperatureDifference dTCoolant1=pipe1.dT
        "Coolant1's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTSource2=
        prescribedHeatFlow2.port.T-TAmb "Source2 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe2=prescribedHeatFlow2.port.T-pipe2.T_q
        "Source2 over Coolant2";
      output Modelica.SIunits.TemperatureDifference dTCoolant2=pipe2.dT
        "Coolant2's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTmixedCoolant=ambient2.T_port-ambient1.T_port
        "mixed Coolant's temperature increase";
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
      Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true,
        constantVolumeFlow=1)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe1(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{0,-20},{20,0}})));
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe2(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{0,20},{20,0}})));
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe3(
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
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium,
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
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow2
        annotation (Placement(transformation(
            origin={-20,60},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection2
        annotation (Placement(transformation(
            origin={10,40},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Thermal.FluidHeatFlow.Examples.Utilities.DoubleRamp volumeFlow
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
        annotation (Line(points={{-60,0},{-60,0},{-40,0}}, color={255,0,0}));
      connect(pump.flowPort_b, pipe1.flowPort_a)
        annotation (Line(points={{-20,0},{-10,0},{-10,-10},{0,-10}}, color={255,0,0}));
      connect(pump.flowPort_b, pipe2.flowPort_a)
        annotation (Line(points={{-20,0},{-10,0},{-10,10},{0,10}}, color={255,0,0}));
      connect(heatFlow2.y,prescribedHeatFlow2. Q_flow)
        annotation (Line(points={{-39,60},{-30,60}}, color={0,0,255}));
      connect(heatFlow1.y,prescribedHeatFlow1. Q_flow)
        annotation (Line(points={{-39,-60},{-30,-60}}, color={0,0,255}));
      connect(thermalConductance2.y, convection2.Gc)
        annotation (Line(points={{-9,40},{0,40}}, color={0,0,127}));
      connect(thermalConductance1.y, Convection1.Gc)
        annotation (Line(points={{-9,-40},{0,-40}}, color={0,0,127}));
      connect(pipe1.heatPort, Convection1.fluid) annotation (Line(points={{10,-20},{
              10,-25},{10,-30}}, color={191,0,0}));
      connect(convection2.fluid,pipe2. heatPort) annotation (Line(points={{10,30},{10,
              20}}, color={191,0,0}));
      connect(convection2.solid,prescribedHeatFlow2. port) annotation (Line(
            points={{10,50},{10,60},{-10,60}}, color={191,0,0}));
      connect(convection2.solid,heatCapacitor2. port) annotation (Line(points={{10,50},
              {10,60},{28,60}}, color={191,0,0}));
      connect(Convection1.solid,prescribedHeatFlow1. port) annotation (Line(
            points={{10,-50},{10,-60},{-10,-60}}, color={191,0,0}));
      connect(Convection1.solid,heatCapacitor1. port) annotation (Line(points={{10,-50},
              {10,-60},{30,-60}}, color={191,0,0}));
      connect(pipe2.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,10},{
              30,10},{30,0},{40,0}}, color={255,0,0}));
      connect(pipe1.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,
              -10},{30,-10},{30,0},{40,0}}, color={255,0,0}));
      connect(pipe3.flowPort_b,ambient2. flowPort)
        annotation (Line(points={{60,0},{80,0}}, color={255,0,0}));
      connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
          points={{-39,20},{-30,20},{-30,10}}, color={0,0,127}));
    annotation (Documentation(info="<html>
<p>
6th test example: ParallelPumpDropOut
</p>
Same as 2nd test example, but with a drop out of the pump:<br>
The pump is running for 0.2 s, then shut down (using a ramp of 0.2 s) for 0.2 s,
then started again (using a ramp of 0.2 s).
</html>"),        experiment(StopTime=2.0, Interval=0.001));
    end ParallelPumpDropOut;

    model OneMass "Cooling of one hot mass"
      extends Modelica.Icons.Example;
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      parameter Modelica.SIunits.Temperature TMass(displayUnit="degC")=313.15
        "Initial temperature of mass";
      output Modelica.SIunits.TemperatureDifference dTMass=
        heatCapacitor.port.T-TAmb "Mass over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=heatCapacitor.port.T-pipe.T_q
        "Mass over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=pipe.dT
        "Coolant's temperature increase";
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
      Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true,
        constantVolumeFlow=1)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
        C=0.1, T(start=TMass, fixed=true))
        annotation (Placement(transformation(
            origin={10,-60},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=1)
        annotation (Placement(transformation(
            origin={10,-30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Thermal.FluidHeatFlow.Examples.Utilities.DoubleRamp volumeFlow(
        offset=0,
        height_1=1,
        height_2=-2) annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
    equation
      connect(ambient1.flowPort, pump.flowPort_a)
        annotation (Line(points={{-60,0},{-40,0}}, color={255,0,0}));
      connect(pump.flowPort_b, pipe.flowPort_a)
        annotation (Line(points={{-20,0},{0,0}}, color={255,0,0}));
      connect(pipe.flowPort_b, ambient2.flowPort)
        annotation (Line(points={{20,0},{40,0}}, color={255,0,0}));
      connect(thermalConductor.port_a, heatCapacitor.port) annotation (Line(
            points={{10,-40},{10,-45},{10,-50}}, color={191,0,0}));
      connect(pipe.heatPort, thermalConductor.port_b)
        annotation (Line(points={{10,-10},{10,-20}}, color={191,0,0}));
      connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
          points={{-39,20},{-30,20},{-30,10}}, color={0,0,127}));
    annotation (Documentation(info="<html>
<p>
7th test example: OneMass
</p>
A thermal capacity is coupled with a coolant flow.
Different initial temperatures of thermal capacity and pipe's coolant get ambient's temperature,
the time behaviour depending on coolant flow.
</html>"),        experiment(StopTime=1.0, Interval=0.001));
    end OneMass;

    model TwoMass "Cooling of two hot masses"
      extends Modelica.Icons.Example;
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium()
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
      output Modelica.SIunits.TemperatureDifference dTtoPipe1=heatCapacitor1.port.T-pipe1.T_q
        "Mass1 over Coolant1";
      output Modelica.SIunits.TemperatureDifference dTCoolant1=pipe1.dT
        "Coolant1's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTMass2=
        heatCapacitor2.port.T-TAmb "Mass2 over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe2=heatCapacitor2.port.T-pipe2.T_q
        "Mass2 over Coolant2";
      output Modelica.SIunits.TemperatureDifference dTCoolant2=pipe2.dT
        "Coolant2's temperature increase";
      output Modelica.SIunits.TemperatureDifference dTmixedCoolant=ambient2.T_port-ambient1.T_port
        "mixed Coolant's temperature increase";
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
      Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true,
        constantVolumeFlow=1)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
       Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe1(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{0,-20},{20,0}})));
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe2(
        medium=medium,
        m=0.1,
        T0=TAmb,
        V_flowLaminar=0.1,
        dpLaminar(displayUnit="Pa") = 0.1,
        V_flowNominal=1,
        dpNominal(displayUnit="Pa") = 1,
        h_g=0,
        T0fixed=true,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{0,20},{20,0}})));
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe3(
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
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium,
        constantAmbientPressure=0)
        annotation (Placement(transformation(extent={{80,-10},{100,10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(
        C=0.1, T(start=TMass1, fixed=true))
        annotation (Placement(transformation(
            origin={10,-70},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor
        thermalConductor1(G=1)
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
        thermalConductor2(G=1)
        annotation (Placement(transformation(
            origin={10,40},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Thermal.FluidHeatFlow.Examples.Utilities.DoubleRamp volumeFlow(
        offset=0,
        height_1=1,
        height_2=-2) annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
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
            points={{10,60},{10,55},{10,50}}, color={191,0,0}));
      connect(thermalConductor2.port_b,pipe2. heatPort)
        annotation (Line(points={{10,30},{10,20}}, color={191,0,0}));
      connect(pipe1.heatPort,thermalConductor1. port_b) annotation (Line(points=
             {{10,-20},{10,-30}}, color={191,0,0}));
      connect(thermalConductor1.port_a, heatCapacitor1.port) annotation (Line(
            points={{10,-50},{10,-55},{10,-60}}, color={191,0,0}));
      connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
          points={{-39,20},{-30,20},{-30,10}}, color={0,0,127}));
    annotation (Documentation(info="<html>
<p>
8th test example: TwoMass
</p>
Two thermal capacities are coupled with two parallel coolant flow.
Different initial temperatures of thermal capacities and pipe's coolants get ambient's temperature,
the time behaviour depending on coolant flow.
</html>"),        experiment(StopTime=1.0, Interval=0.001));
    end TwoMass;

    model WaterPump "Water pumping station"
      extends Modelica.Icons.Example;
      import Modelica.Constants.pi;
      output Modelica.SIunits.VolumeFlowRate V_flow=volumeFlowSensor.y "Volume flow rate";
      output Modelica.SIunits.Pressure p(displayUnit="bar")=pressureSensor.y "Pressure at pump outlet";
      output Modelica.SIunits.AngularVelocity w(displayUnit="1/min")=multiSensor.w "Pump speed";
      output Modelica.SIunits.Torque tau=multiSensor.tau "Pump torque";
      output Modelica.SIunits.Power power=multiSensor.power "Pump power";
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        period=2,
        nperiod=1,
        offset=0,
        rising=0.6,
        width=0.6,
        falling=0.6,
        startTime=0.1,
        amplitude=1.2) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-70,-50})));
      Modelica.Blocks.Math.Gain gain(k=idealPump.wNominal)
        annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
      Modelica.Mechanics.Rotational.Sources.Speed speed(exact=true)
        annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
      Modelica.Mechanics.Rotational.Sensors.MultiSensor multiSensor(w(displayUnit="1/min"))
        annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        constantAmbientPressure=100000,
        constantAmbientTemperature=293.15)
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={50,-80})));
      Modelica.Thermal.FluidHeatFlow.Sources.IdealPump idealPump(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        m=0,
        V_flow0=0.18,
        T0=293.15,
        wNominal=104.71975511966,
        dp0=500000) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={50,-50})));
      Modelica.Thermal.FluidHeatFlow.Sensors.VolumeFlowSensor volumeFlowSensor(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water())
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={50,-20})));
      Modelica.Thermal.FluidHeatFlow.Sensors.PressureSensor pressureSensor(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water())
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={20,0})));
      Modelica.Thermal.FluidHeatFlow.Components.OneWayValve oneWayValve(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        m=0,
        frictionLoss=0,
        T0=293.15,
        V_flowNominal=0.18,
        dpForward=10000,
        dpNominal=500000,
        V_flowBackward=1e-6)
        annotation (Placement(
            transformation(
            extent={{10,10},{-10,-10}},
            rotation=270,
            origin={50,20})));
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe(
        m=0,
        V_flowLaminar=0.09,
        V_flowNominal=0.18,
        h_g=25,
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        T0=293.15,
        dpLaminar=10000,
        dpNominal=30000)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,50})));
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient2(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        constantAmbientPressure=100000,
        constantAmbientTemperature=293.15)
        annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=270,
            origin={50,82})));
    equation
      connect(idealPump.flowPort_a, ambient1.flowPort)
        annotation (Line(points={{50,-60},{50,-70}}, color={255,0,0}));
      connect(speed.flange, multiSensor.flange_a)
        annotation (Line(points={{0,-50},{10,-50}}));
      connect(oneWayValve.flowPort_a, volumeFlowSensor.flowPort_b)
        annotation (Line(points={{50,10},{50,-10}}, color={255,0,0}));
      connect(volumeFlowSensor.flowPort_a, idealPump.flowPort_b)
        annotation (Line(points={{50,-30},{50,-40}}, color={255,0,0}));
      connect(ambient2.flowPort, pipe.flowPort_b)
        annotation (Line(points={{50,72},{50,60}}, color={255,0,0}));
      connect(pipe.flowPort_a, oneWayValve.flowPort_b)
        annotation (Line(points={{50,40},{50,30}}, color={255,0,0}));
      connect(multiSensor.flange_b, idealPump.flange_a)
        annotation (Line(points={{30,-50},{40,-50}}));
      connect(oneWayValve.flowPort_a, pressureSensor.flowPort)
        annotation (Line(points={{50,10},{50,0},{30,0}}, color={255,0,0}));
      connect(gain.y, speed.w_ref)
        annotation (Line(points={{-29,-50},{-22,-50}}, color={0,0,127}));
      connect(trapezoid.y, gain.u)
        annotation (Line(points={{-59,-50},{-52,-50}}, color={0,0,127}));
      annotation (experiment(
          StopTime=2,
          Interval=0.001,
          Tolerance=1e-06), Documentation(
            info="<html>
<p>
There are two reservoirs at ambient pressure, the second one 25 m higher than the first one.
The ideal pump is driven by a speed source, starting from zero and going up to 1.2 times nominal speed.
To avoid water flowing back, the one way valve is used.
</p>
</html>"));
    end WaterPump;

    model TestOpenTank "Test the OpenTank model"
      extends Modelica.Icons.Example;
      output Modelica.SIunits.VolumeFlowRate V_flow=volumeFlow.V_flow "Volume flow rate to tank";
      output Modelica.SIunits.Length level=openTank.level "Level in tank";
      output Modelica.SIunits.Temperature T(displayUnit="degC")=openTank.TTank "Temperature in tank";
      Modelica.Thermal.FluidHeatFlow.Components.OpenTank openTank(
        ATank=1,
        hTank=1,
        useHeatPort=false,
        pAmbient=0,
        g=10,
        level(fixed=true, start=0.5),
        T0=313.15,
        T0fixed=true)
        annotation (Placement(transformation(extent={{-10,50},{10,70}})));
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient(
        constantAmbientPressure=0, constantAmbientTemperature=293.15)
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={0,-60})));
      Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow volumeFlow(
        m=0,
        useVolumeFlowInput=true,
        constantVolumeFlow=1,
        T0=293.15)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,0})));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
        table=[0,0; 0.5,0; 0.5,-1; 0.75, -1; 0.75,1; 1,1; 1,0; 1.5,0])
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    equation
      connect(combiTimeTable.y[1], volumeFlow.volumeFlow)
        annotation (Line(points={{-19,0},{-10,0}}, color={0,0,127}));
      connect(openTank.flowPort, volumeFlow.flowPort_b)
        annotation (Line(points={{0,50},{0,10}}, color={255,0,0}));
      connect(volumeFlow.flowPort_a, ambient.flowPort)
        annotation (Line(points={{0,-10},{0,-50}}, color={255,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=1.5),
        Documentation(info="<html>
<p>
First, the medium is pumped out of the tank (initial level = 0.5 m, T = 40&deg;C) to an (infinite) ambient (T = 20&deg;C):
</p>
<ul>
<li>The level of the medium in the tank decreases.</li>
<li>The temperature of the medium in the tank remains unchanged.</li>
</ul>
<p>
Subsequently the medium is pumped into the tank from an (infinite) ambient:
</p>
<ul>
<li>The level of the medium in the tank increases again.</li>
<li>The temperature of the medium in the tank decreases (mixing temperature).</li>
</ul>
</html>"));
    end TestOpenTank;

    model TwoTanks "Two connected open tanks"
      extends Modelica.Icons.Example;
      output Modelica.SIunits.VolumeFlowRate V_flow=pipe.V_flow "Volume flow rate tank 1 -> tank 2";
      output Modelica.SIunits.Length level1=openTank1.level "Level in tank 1";
      output Modelica.SIunits.Temperature T1(displayUnit="degC")=openTank1.TTank "Temperature in tank 1";
      output Modelica.SIunits.Length level2=openTank2.level "Level in tank 2";
      output Modelica.SIunits.Temperature T2(displayUnit="degC")=openTank2.TTank "Temperature in tank 2";
      Modelica.Thermal.FluidHeatFlow.Components.OpenTank openTank1(
        ATank=1,
        hTank=1,
        useHeatPort=false,
        g=10,
        level(fixed=true, start=0.9),
        T0=313.15,
        T0fixed=true,
        pAmbient=100000) annotation (Placement(transformation(extent={{-60,12},{-40,32}})));
      Modelica.Thermal.FluidHeatFlow.Components.OpenTank openTank2(
        ATank=1,
        hTank=1,
        useHeatPort=false,
        g=10,
        level(fixed=true, start=0.1),
        T0=293.15,
        T0fixed=true,
        pAmbient=100000) annotation (Placement(transformation(extent={{60,10},{40,30}})));
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe(
        m=0,
        h_g=0,
        T0=293.15,
        V_flowLaminar=2,
        dpLaminar=10,
        V_flowNominal=4,
        dpNominal=30) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(openTank1.flowPort, pipe.flowPort_a)
        annotation (Line(points={{-50,12},{-50,0},{-10,0}}, color={255,0,0}));
      connect(pipe.flowPort_b, openTank2.flowPort)
        annotation (Line(points={{10,0},{50,0},{50,10}}, color={255,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=1.5),
        Documentation(info="<html>
<p>
Two tanks are connected with a pipe:
</p>
<ul>
<li>Tank 1: initial level = 0.9 m, T = 40&deg;C</li>
<li>Tank 2: initial level = 0.1 m, T = 20&deg;C</li>
</ul>
<p>
Within 1.5 s (dependent on the flow resistance of the pipe) the level = 0.5 m in both tanks is the same, medium flows from tank 1 to tank 2.
The temperature of tank 1 remains unchanged, the temperature of tank 2 is increased.
</p>
</html>"));
    end TwoTanks;

    model TestCylinder "Two cylinder system"
      extends Modelica.Icons.Example;
      output Modelica.SIunits.Force f1=-10*cylinder1.f "10 x Force on piston 1";
      output Modelica.SIunits.Position s1=0.1*cylinder1.s "0.1 x Position of piston 1";
      output Modelica.SIunits.Position s2=cylinder2.s "Position of piston 2";
      output Modelica.SIunits.Force f2=-cylinder2.f "Force on piston 2";
      output Modelica.SIunits.Force f=springDamper.f "Force of springDamper";
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
        table=[0,0; 0.25,0; 0.25,-1; 0.5,-1; 0.5,0; 0.75,0])
        annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
      Modelica.Mechanics.Translational.Sources.Force force
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Modelica.Thermal.FluidHeatFlow.Components.Cylinder cylinder1(
        A=0.1,
        L=10,
        s(fixed=true, start=cylinder1.L/2),
        T0=313.15,
        T0fixed=true) annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={-20,0})));
      Modelica.Thermal.FluidHeatFlow.Components.Cylinder cylinder2(
        T(fixed=true),
        A=1,
        L=1,
        T0=313.15,
        T0fixed=true) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={10,0})));
      Modelica.Mechanics.Translational.Components.Mass mass(m=1)
        annotation (Placement(transformation(extent={{30,-10},{50,10}})));
      Modelica.Mechanics.Translational.Components.SpringDamper springDamper(
        s_rel0=cylinder2.L/2,
        c=100,
        s_rel(fixed=true, start=cylinder2.L/2),
        v_rel(fixed=true, start=0),
        d=10) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
      Modelica.Mechanics.Translational.Components.Fixed fixed
        annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    equation
      connect(cylinder1.flowPort, cylinder2.flowPort) annotation (Line(points={
              {-10,-1.33227e-15},{-4,-1.33227e-15},{-4,0},{0,0}}, color={255,0,0}));
      connect(force.flange, cylinder1.flange) annotation (Line(points={{-40,0},
              {-34,0},{-34,1.33227e-15},{-30,1.33227e-15}}, color={0,127,0}));
      connect(combiTimeTable.y[1], force.f)
        annotation (Line(points={{-69,0},{-62,0}}, color={0,0,127}));
      connect(cylinder2.flange, mass.flange_a)
        annotation (Line(points={{20,0},{30,0}}, color={0,127,0}));
      connect(springDamper.flange_b, mass.flange_b)
        annotation (Line(points={{60,0},{50,0}}, color={0,127,0}));
      connect(springDamper.flange_a, fixed.flange)
        annotation (Line(points={{80,0},{90,0}}, color={0,127,0}));
      annotation (Documentation(info="<html>
<p>
Test of a system with 2 cylinders (with same volume):
</p>
<ul>
<li>cylinder1: A = 0.1 m2, L=10. m, initial position of piston at s=L/2</li>
<li>cylinder2: A = 1.0 m2, L=1.0 m, initial position of piston at s=L/2</li>
</ul>
<p>
A force is applied that presses from 0.25 s to 0.50 s with 1 Nm on piston1.
Due to the ratio of areas 10:1
</p>
<ul>
<li>the force at piston2 is ten times the force at piston1</li>
<li>movement of piston1 is ten times the movement of piston2</li>
</ul>
<p>
At piston2 a mass is mounted which is moved and presses the springDamper.
When the force at piston1 is removed, the springDamper pushes back the mass and a damped oscillation occurs.
</p>
<p>
Note: Take care of the initial conditions. The unstretched spring length is cylinder2.L/2,
i.e. when piston2 is the middle of its cylinder the spring applies no force to the mass (and piston2).
</p>
</html>"),     experiment(StopTime=2, Interval=0.001));
    end TestCylinder;

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

        Modelica.Blocks.Math.Add add annotation (Placement(transformation(
                extent={{10,-10},{30,10}})));
        Modelica.Blocks.Sources.Ramp ramp1(
          final height=height_1,
          final duration=duration_1,
          final startTime=startTime,
          final offset=offset)
          annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
        Modelica.Blocks.Sources.Ramp ramp2(
          final height=height_2,
          final duration=duration_2,
          final startTime=startTime + duration_1 + interval,
          final offset=0)
          annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
      equation
        connect(ramp1.y, add.u1) annotation (Line(points={{-9,20},{0,20},{0,6},
                {8,6}}, color={0,0,127}));
        connect(ramp2.y, add.u2) annotation (Line(points={{-9,-20},{0,-20},{0,
                -6},{8,-6}}, color={0,0,127}));
        connect(add.y, y) annotation (Line(points={{31,0},{110,0}}, color={0,0,127}));
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
<p>This package contains utility components used for the test examples.</p>
</html>"));
    end Utilities;
  annotation (Documentation(info="<html>
<p>This package contains test examples:</p>

<ol>
<li>SimpleCooling: Heat is dissipated through a media flow</li>
<li>ParallelCooling: Two heat sources dissipate through merged media flows</li>
<li>IndirectCooling: Heat is dissipated through two cooling cycles</li>
<li>PumpAndValve: Demonstrate the usage of an IdealPump and a Valve</li>
<li>PumpDropOut: Demonstrate shutdown and restart of a pump</li>
<li>ParallelPumpDropOut: Demonstrate the shutdown and restart of a pump in a parallel circuit</li>
<li>OneMass: Cooling of a mass (thermal capacity) by a coolant flow</li>
<li>TwoMass: Cooling of two masses (thermal capacities) by two parallel coolant flows</li>
<li>WaterPump: Water pumping station</li>
<li>TestOpenTank: Test the <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Components.OpenTank\">OpenTank</a> model</li>
<li>TwoTanks: Two connected open tanks</li>
<li>TestCylinder: Test the <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Components.Cylinder\">Cylinder</a> model</li>
</ol>

</html>"));
  end Examples;

  package Components "Basic components (pipes, valves)"
    extends Modelica.Icons.Package;

    model Pipe "Pipe with optional heat exchange"
      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort;
      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.SimpleFriction;

      parameter Boolean useHeatPort = false "=true, if HeatPort is enabled"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Modelica.SIunits.Length h_g(start=0)
        "Geodetic height (height difference from flowPort_a to flowPort_b)";
      parameter Modelica.SIunits.Acceleration g(final min=0)=Modelica.Constants.g_n "Gravitation";
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(T=T_q, Q_flow=Q_flowHeatPort) if useHeatPort
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    protected
      Modelica.SIunits.HeatFlowRate Q_flowHeatPort "Heat flow at conditional heatPort";
    equation
      if not useHeatPort then
        Q_flowHeatPort=0;
      end if;
      // coupling with FrictionModel
      volumeFlow = V_flow;
      dp = pressureDrop + medium.rho*g*h_g;
      // energy exchange with medium
      Q_flow = Q_flowHeatPort + Q_friction;
    annotation (Documentation(info="<html>
<p>Pipe with optional heat exchange.</p>
<p>
Thermodynamic equations are defined by Partials.TwoPort.
Q_flow is defined by heatPort.Q_flow (useHeatPort=true) or zero (useHeatPort=false).</p>
<p>
<strong>Note:</strong> Setting parameter m (mass of medium within pipe) to zero
leads to neglect of temperature transient cv*m*der(T).
</p>
<p>
<strong>Note:</strong> Injecting heat into a pipe with zero mass flow causes
temperature rise defined by storing heat in medium's mass.
</p>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Rectangle(
              extent={{-90,20},{90,-20}},
              lineColor={255,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Polygon(visible=useHeatPort,
              points={{-10,-90},{-10,-40},{0,-20},{10,-40},{10,-90},{-10,-90}},
              lineColor={255,0,0}),           Text(extent={{-150,80},{150,40}},
              textString="%name",
              lineColor={0,0,255})}));
    end Pipe;

    model IsolatedPipe "Pipe without heat exchange"
      extends Modelica.Thermal.FluidHeatFlow.Components.Pipe(final useHeatPort=false);
      extends Modelica.Icons.ObsoleteModel;
    annotation (
        obsolete = "Obsolete model - use Modelica.Thermal.FluidHeatFlow.Components.Pipe(useHeatPort=false) instead",
        Documentation(info="<html>
<p>
This model simply extends from the <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Components.Pipe\">Pipe</a> model
with parameter useHeatPort = false and is kept for compatibility reasons. In the future, it will be removed.
</p>
</html>"));
    end IsolatedPipe;

    model HeatedPipe "Pipe with heat exchange"
      extends Modelica.Thermal.FluidHeatFlow.Components.Pipe(final useHeatPort=true);
      extends Modelica.Icons.ObsoleteModel;
    annotation (
        obsolete = "Obsolete model - use Modelica.Thermal.FluidHeatFlow.Components.Pipe(useHeatPort=true) instead",
        Documentation(info="<html>
<p>
This model simply extends from the <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Components.Pipe\">Pipe</a> model
with parameter useHeatPort = true and is kept for compatibility reasons. In the future, it will be removed.
</p>
</html>"));
    end HeatedPipe;

    model Valve "Simple valve"
      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort(m(start=0), final tapT=1);

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
      Modelica.Blocks.Interfaces.RealInput y annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,100})));
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
Standard characteristic Kv=<em>f </em>(y) is given at standard conditions (dp0, rho0),
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
            Polygon(
              points={{-90,10},{-60,10},{-60,60},{0,0},{60,60},{60,10},{90,10},
                  {90,-10},{60,-10},{60,-60},{0,0},{-60,-60},{-60,-10},{-90,-10},
                  {-90,10}},
              lineColor={255,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,80},{0,0}}, color={0,0,127}),
                                              Text(extent={{-150,-70},{150,-110}},
              textString="%name",
              lineColor={0,0,255})}));
    end Valve;

    model OpenTank "Model of a tank under ambient pressure"
      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.SinglePortBottom(final Exchange=true);

      parameter Modelica.SIunits.Area ATank(start=1) "Cross section of tank";
      parameter Modelica.SIunits.Length hTank(start=1) "Height of tank";
      parameter Modelica.SIunits.Pressure pAmbient(start=0) "Ambient pressure";
      parameter Modelica.SIunits.Acceleration g(final min=0)=Modelica.Constants.g_n "Gravitation";
      parameter Boolean useHeatPort = false "=true, if HeatPort is enabled"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      Modelica.SIunits.Mass m "Mass of medium in tank";
    protected
      Modelica.SIunits.Enthalpy H "Enthalpy of medium";
      Modelica.SIunits.HeatFlowRate Q_flow "Heat flow at the optional heatPort";
    public
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(final T=T, final Q_flow=Q_flow) if useHeatPort
        "Optional port for cooling or heating the medium in the tank"
        annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
            iconTransformation(extent={{-110,-110},{-90,-90}})));
      Modelica.Blocks.Interfaces.RealOutput level(quantity="Length", unit="m", start=0)
        "Level of medium in tank" annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={110,0})));
      Modelica.Blocks.Interfaces.RealOutput TTank(quantity="Temperature", unit="K", displayUnit="degC")
        "Temperature of medium in tank" annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={110,-60})));
    equation
      //output medium temperature
      TTank = T;
      //optional heating/cooling
      if not useHeatPort then
        Q_flow = 0;
      end if;
      //check level
      assert(level>=0, "Tank got empty!");
      assert(level<=hTank, "Tank got full!");
      //mass balance
      m = medium.rho*ATank*level;
      der(m) = flowPort.m_flow;
      //energy balance
      H = m*h;
      der(H) = flowPort.H_flow + Q_flow;
      //pressure at bottom
      flowPort.p = pAmbient + m*g/ATank;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Ellipse(
              extent={{-80,-60},{80,-100}},
              fillColor={170,170,255},
              fillPattern=FillPattern.Sphere),
            Rectangle(
              extent={{-80,0},{80,-80}},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={170,170,255}),
            Rectangle(
              extent={{-80,80},{80,0}},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={255,255,255}),
            Ellipse(
              extent={{-80,100},{80,60}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Sphere),
            Ellipse(
              extent={{-80,20},{80,-20}},
              fillColor={170,170,255},
              fillPattern=FillPattern.Sphere),
            Line(points={{100,0},{80,0}}, thickness=0.5),
            Line(points={{100,-60},{80,-60}},
                                            color={238,46,47},
              thickness=0.5),
            Ellipse(
              extent={{72,-56},{80,-64}},
              lineColor={238,46,47},
              lineThickness=0.5,
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Ellipse(visible=useHeatPort,
              extent={{-80,-74},{-68,-86}},
              lineColor={238,46,47},
              lineThickness=0.5,
              fillColor={170,170,255},
              fillPattern=FillPattern.Solid),
            Ellipse(visible=useHeatPort,
              extent={{-68,-78},{-56,-90}},
              lineColor={238,46,47},
              lineThickness=0.5,
              fillColor={170,170,255},
              fillPattern=FillPattern.Solid),
            Ellipse(visible=useHeatPort,
              extent={{-56,-82},{-44,-94}},
              lineColor={238,46,47},
              lineThickness=0.5,
              fillColor={170,170,255},
              fillPattern=FillPattern.Solid),
            Ellipse(visible=useHeatPort,
              extent={{-44,-84},{-32,-96}},
              lineColor={238,46,47},
              lineThickness=0.5,
              fillColor={170,170,255},
              fillPattern=FillPattern.Solid),
            Line(visible=useHeatPort,
              points={{-90,-100},{-56,-100},{-56,-88}},
              color={238,46,47},
              thickness=0.5)}),                  Diagram(coordinateSystem(
              preserveAspectRatio=false)),
        Documentation(info="<html>
<p>This is a simple model of an open tank with volume A*h. The level and the temperature of the medium are measured and provided as output.</p>
<p>Note: If the level of the medium reaches 0 (minimum) or h (maximum), an assertion is triggered.</p>
<p>Note: The flowPort is assumed to be at the bottom. Therefore the pressure at the flowPort is ambient pressure + level*rho*g.</p>
<ul>
<li>If the mass flow rate at the port goes into the tank the level increases and the mixing rule is applied to obtain the temperature change of the medium in the tank.</li>
<li>If the mass flow rate at the port goes out of the tank the level decreases,
the temperature of the outflowing medium is defined by the the temperature of the medium in the tank.</li>
</ul>
<p>
It is assumed that the medium in the tank has the same temperature over the whole volume, i.e. mixed thoroughly.
</p>
<p>
Via the optional heatPort the medium in the tank can be cooled or heated.
</p>
</html>"));
    end OpenTank;

    model Cylinder "Simple model of a piston in a cylinder"
      import Modelica.Constants.small;
      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.SinglePortLeft(final Exchange=true);

      parameter Modelica.SIunits.Area A "Cross section of cylinder/piston";
      parameter Modelica.SIunits.Length L "Length of cylinder";
      extends
        Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2(
         s(start=small));
      Modelica.SIunits.Force f=flange.f "Force at piston";
    protected
      Modelica.SIunits.Mass m "Mass of medium";
      Modelica.SIunits.Enthalpy H "Enthalpy of medium";
    equation
      assert(s>=small, getInstanceName()+": Piston hit bottom of cylinder!");
      assert(s<=L, getInstanceName()+":Piston hit top of cylinder!");
      flowPort.p*A = -f;
      m = medium.rho*A*s;
      der(m) = flowPort.m_flow;
      H = m*h;
      der(H)=flowPort.H_flow;
      annotation (Documentation(info="<html>
<p>This is a simple model of a piston in a cylinder:</p>
<p>The translational flange is connected to the piston, the cylinder has a flowPort at the bottom.</p>
<p>
The position of the piston within the cylinder goes from 0 at the bottom to L (length of the cylinder) at the top of the cylinder.
If the piston leaves the cylinder, an assertion is triggered.
</p>
<ul>
<li>A movement of the piston is coupled with volume flow through the flowPort.</li>
<li>The force at the piston is equal to pressure of the fluid times A (cross section of the piston).</li>
</ul>
<p>
The piston is considered without mass.
</p>
<p>
Note: Take care of the initial conditions. The position of the piston (relative to the support) should be in the range (0, L).
The position of the flange (as well as of the support, if useSupport=true) is influenced by connected components.
</p>
</html>"),
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={       Text(
              extent={{-150,140},{150,100}},
              lineColor={0,0,255},
              textString="%name"),
            Polygon(
              points={{-90,10},{-70,10},{-70,60},{70,60},{70,-60},{-70,-60},{-70,-10},
                  {-90,-10},{-90,10}},
              lineColor={255,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              lineThickness=0.5),
            Rectangle(
              extent={{-14,58},{68,-58}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-24,58},{-14,-58}},
              lineThickness=0.5,
              fillColor={192,192,192},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-14,10},{90,-10}},
              lineThickness=0.5,
              lineColor={0,127,0},
              fillColor={160,215,160},
              fillPattern=FillPattern.HorizontalCylinder),
            Line(points={{-10,-72},{70,-72}}),
            Polygon(
              points={{-40,-72},{-10,-62},{-10,-82},{-40,-72}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid)}));
    end Cylinder;

    model OneWayValve "Simple one-way valve"
      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort(m(start=0), final tapT=1);

      parameter Modelica.SIunits.VolumeFlowRate V_flowNominal(start=1) "Nominal volume flow rate (forward)";
      parameter Modelica.SIunits.Pressure dpForward(displayUnit="bar")=1e-6 "Pressure drop at nominal flow (forward)";
      parameter Modelica.SIunits.Pressure dpNominal(displayUnit="bar", start=1e5) "Nominal pressure (backward)";
      parameter Modelica.SIunits.VolumeFlowRate V_flowBackward(start=1E-6) "Leakage volume flow rate (backward)";
      parameter Real frictionLoss(min=0, max=1, start=0)
        "Part of friction losses fed to medium";
      Boolean backward(start=true) "State forward=false / backward=true";
    protected
      Real s(start=0, final unit="1")
        "Auxiliary variable for actual position on the valve characteristic";
      /* s < 0: backward, leakage flow
         s > 0: forward, small pressure drop */
      constant Modelica.SIunits.VolumeFlowRate unitVolumeFlowRate = 1;
      constant Modelica.SIunits.Pressure unitPressureDrop = 1;
    equation
      backward = s<0;
      dp     = (s*unitVolumeFlowRate)*(if backward then 1 else dpForward/V_flowNominal);
      V_flow = (s*unitPressureDrop)  *(if backward then V_flowBackward/dpNominal else 1);
      Q_flow = frictionLoss*V_flow*dp;
    annotation (Documentation(info="<html>
<p>Simple one-way valve, comparable to the electrical <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealDiode\">ideal diode</a> model.</p>
<ul>
<li>from flowPort_a to flowPort_b: small pressure drop, linearly dependent on volumeFlow</li>
<li>from flowPort_b to flowPort_a: small leakage flow, linearly dependent on pressure drop</li>
</ul>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Polygon(
              points={{-90,10},{-60,10},{-60,60},{0,0},{60,60},{60,10},{90,10},{90,-10},
                  {60,-10},{60,-60},{0,0},{-60,-60},{-60,-10},{-90,-10},{-90,10}},
              lineColor={255,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(extent={{-150,-70},{150,-110}},
              textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{-60,60},{60,-60},{50,-40},{40,-50},{60,-60}},
              thickness=0.5),
            Polygon(
              points={{50,-40},{60,-60},{40,-50},{50,-40}},
              fillPattern=FillPattern.Solid)}));
    end OneWayValve;
  annotation (Documentation(info="<html>
<p>This package contains components.</p>
<p>
Pressure drop is taken from partial model SimpleFriction.
Thermodynamic equations are defined in partial models (package Partials).
</p>
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
      annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
Record containing (constant) medium properties.
</html>"));
    end Medium;

    record Air_30degC "Medium: properties of air at 30 degC and 1 bar"
    extends Modelica.Thermal.FluidHeatFlow.Media.Medium(
      rho=1.149,
      cp=1007,
      cv= 720,
      lamda=0.0264,
      nue=16.3E-6);
      annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of air at 30&deg;C and 1 bar
</html>"));
    end Air_30degC;

    record Air_70degC "Medium: properties of air at 70 degC and 1 bar"
    extends Modelica.Thermal.FluidHeatFlow.Media.Medium(
      rho=1.015,
      cp=1010,
      cv= 723,
      lamda=0.0293,
      nue=20.3E-6);
      annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of air at 70&deg;C and 1 bar
</html>"));
    end Air_70degC;

    record Water_10degC "Medium: properties of water at 10 degC and 1 bar"
    extends Modelica.Thermal.FluidHeatFlow.Media.Medium(
      rho=999.7,
      cp=4192,
      cv=4192,
      lamda=0.588,
      nue=1.307E-6);
      annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of water at 10&deg;C and 1 bar
</html>"));
    end Water_10degC;

    record Water "Medium: properties of water at 30 degC and 1 bar"
    extends Modelica.Thermal.FluidHeatFlow.Media.Medium(
      rho=995.6,
      cp=4177,
      cv=4177,
      lamda=0.615,
      nue=0.8E-6);
      annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of water at 30&deg;C and 1 bar
</html>"));
    end Water;

    record Water_90degC "Medium: properties of water at 90 degC and 1 bar"
    extends Modelica.Thermal.FluidHeatFlow.Media.Medium(
      rho=965.3,
      cp=4205,
      cv=4205,
      lamda=0.676,
      nue=0.347E-6);
      annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of water at 90&deg;C and 1 bar
</html>"));
    end Water_90degC;

    record Gylcol20_20degC "Medium: properties of glycol:water 20:80 at 20 degC and 1 bar"
    extends Modelica.Thermal.FluidHeatFlow.Media.Medium(
        rho=1028,
        cp=3910,
        cv=3910,
        lamda=0.523,
        nue=1.69E-6);
      annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of glycol:water 20:80 (anti-freeze -8&deg;C) at 20&deg; and 1 bar
</html>"));
    end Gylcol20_20degC;

    record Gylcol50_20degC "Medium: properties of glycol:water 50:50 at 20 degC and 1 bar"
    extends Modelica.Thermal.FluidHeatFlow.Media.Medium(
        rho=1078,
        cp=3300,
        cv=3300,
        lamda=0.405,
        nue=3.98E-6);
      annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of glycol:water 50:50 (anti-freeze -40&deg;C) at 20&deg;C and 1 bar
</html>"));
    end Gylcol50_20degC;

    record MineralOil "Medium: properties of mineral oil at 60 degC and 1 bar"
    extends Modelica.Thermal.FluidHeatFlow.Media.Medium(
        rho=868,
        cp=2010,
        cv=2010,
        lamda=0.14,
        nue=81.8E-6);
      annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
  Medium: properties of mineral oil at 60&deg;C and 1 bar
</html>"));
    end MineralOil;
  annotation (Documentation(info="<html>
<p>This package contains definitions of medium properties.</p>
</html>"));
  end Media;

  package Sensors "Ideal sensors to measure port properties"
    extends Modelica.Icons.SensorsPackage;

    model PressureSensor "Absolute pressure sensor"

      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.AbsoluteSensor(y(unit="Pa", displayUnit="bar")
          "Absolute pressure as output signal");
    equation
      y = flowPort.p;
      annotation (
        Documentation(info="<html>
<p>The PressureSensor measures the absolute pressure.</p>
<p>Thermodynamic equations are defined by Partials.AbsoluteSensor.</p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
          graphics={Text(
              extent={{-30,-20},{30,-60}},
              textString="p")}));
    end PressureSensor;

    model TemperatureSensor "Absolute temperature sensor"

      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.AbsoluteSensor(y(unit="K")
          "Absolute temperature as output signal");
    equation
      medium.cp*y = flowPort.h;
    annotation (
        Documentation(info="<html>
<p>The TempreatureSensor measures the absolute temperature (Kelvin).</p>
<p>Thermodynamic equations are defined by Partials.AbsoluteSensor.</p>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(extent={{-30,-20},{30,-60}},
              textString="T")}));
    end TemperatureSensor;

    model RelPressureSensor "Pressure difference sensor"

      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.RelativeSensor(y(unit="Pa", displayUnit="bar")
          "Pressure difference as output signal");
    equation
      y = flowPort_a.p - flowPort_b.p;
    annotation (
        Documentation(info="<html>
<p>The RelPressureSensor measures the pressure drop between flowPort_a and flowPort_b.</p>
<p>Thermodynamic equations are defined by Partials.RelativeSensor.</p>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(extent={{-30,-20},{30,-60}},
              textString="dp")}));
    end RelPressureSensor;

    model RelTemperatureSensor "Temperature difference sensor"

      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.RelativeSensor(y(unit="K")
          "Temperature difference as output signal");
    equation
      medium.cp*y = flowPort_a.h - flowPort_b.h;
      annotation (
        Documentation(info="<html>
<p>The RelTemperatureSensor measures the temperature difference between flowPort_a and flowPort_b.</p>
<p>Thermodynamic equations are defined by Partials.RelativeSensor.</p>
<p>
<strong>Note:</strong> Connected flowPorts have the same temperature (mixing temperature)!
Since mixing my occur, the outlet temperature of a component may be different from the connector's temperature.
Outlet temperature is defined by variable T of the corresponding component.
</p>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(extent={{-30,-20},{30,-60}},
              textString="dT")}));
    end RelTemperatureSensor;

    model MassFlowSensor "Mass flow sensor"

      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.FlowSensor(y(unit="kg/s")
          "Mass flow as output signal");
    equation
      y = V_flow*medium.rho;
      annotation (
        Documentation(info="<html>
<p>The MassFlowSensor measures the mass flow rate.</p>
<p>Thermodynamic equations are defined by Partials.FlowSensor.</p>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(extent={{-30,-20},{30,-60}},
              textString="m")}));
    end MassFlowSensor;

    model VolumeFlowSensor "Volume flow sensor"

      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.FlowSensor(y(unit="m3/s")
          "Volume flow as output signal");
    equation
      y = V_flow;
      annotation (
        Documentation(info="<html>
<p>The VolumeFlowSensor measures the volume flow rate.</p>
<p>Thermodynamic equations are defined by Partials.FlowSensor.</p>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(extent={{-30,-20},{30,-60}},
              textString="V")}));
    end VolumeFlowSensor;

    model EnthalpyFlowSensor "Enthalpy flow sensor"

      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.FlowSensor(y(unit="W")
          "Enthalpy flow as output signal");
    equation
      y = flowPort_a.H_flow;
      annotation (
        Documentation(info="<html>
<p>The EnthalpyFlowSensor measures the enthalpy flow rate.</p>
<p>Thermodynamic equations are defined by Partials.FlowSensor.</p>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(extent={{-30,-20},{30,-60}},
              textString="H")}));
    end EnthalpyFlowSensor;
  annotation (Documentation(info="<html>
<p>This package contains sensors:</p>
<ul>
<li>PressureSensor: absolute pressure</li>
<li>TemperatureSensor: absolute temperature (Kelvin)</li>
<li>RelPressureSensor: pressure drop between flowPort_a and flowPort_b</li>
<li>RelTemperatureSensor: temperature difference between flowPort_a and flowPort_b</li>
<li>MassFlowSensor: measures mass flow rate</li>
<li>VolumeFlowSensor: measures volume flow rate</li>
<li>EnthalpyFlowSensor: measures enthalpy flow rate</li>
</ul>

<p>Some of the sensors do not need access to medium properties for measuring,
but it is necessary to define the medium in the connector (check of connections).
Thermodynamic equations are defined in partial models (package Interfaces.Partials).
All sensors are considered massless, they do not change mass flow or enthalpy flow.</p>

</html>"));
  end Sensors;

  package Sources "Ideal fluid sources, e.g., ambient, volume flow"
    extends Modelica.Icons.SourcesPackage;

    model Ambient "Ambient with constant properties"

      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.SinglePortLeft(final Exchange=true, final T0=293.15, final T0fixed=false);
      parameter Boolean usePressureInput=false
        "Enable / disable pressure input"
        annotation(Evaluate=true, choices(checkBox=true));
      parameter Modelica.SIunits.Pressure constantAmbientPressure(start=0)
        "Ambient pressure"
        annotation(Dialog(enable=not usePressureInput));
      parameter Boolean useTemperatureInput=false
        "Enable / disable temperature input"
        annotation(Evaluate=true, choices(checkBox=true));
      parameter Modelica.SIunits.Temperature constantAmbientTemperature(start=293.15, displayUnit="degC")
        "Ambient temperature"
        annotation(Dialog(enable=not useTemperatureInput));
      Modelica.Blocks.Interfaces.RealInput ambientPressure=pAmbient if usePressureInput
        annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={100,60}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={100,60})));
      Modelica.Blocks.Interfaces.RealInput ambientTemperature=TAmbient if useTemperatureInput
        annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={100,-60}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={100,-60})));
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
<p>(Infinite) ambient with constant pressure and temperature.</p>
<p>Thermodynamic equations are defined by Partials.Ambient.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Ellipse(
              extent={{-90,90},{90,-90}},
              lineColor={255,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{20,80},{80,20}},
              textString="p"), Text(
              extent={{20,-20},{80,-80}},
              textString="T")}));
    end Ambient;

    model AbsolutePressure "Defines absolute pressure level"
      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.SinglePortLeft(final Exchange=false, final T0=293.15, final T0fixed=false);
      parameter Modelica.SIunits.Pressure p(start=0) "Pressure ground";
    equation
      // defining pressure
      flowPort.p = p;
      // no no mass flow means no energy flow
      flowPort.H_flow = 0;
      annotation (
        Documentation(info="<html>
<p>AbsolutePressure to define pressure level of a closed cooling cycle.</p>
<p>Coolant's mass flow, temperature and enthalpy flow are not affected.</p>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={
           Ellipse(extent={{-90,90},{90,-90}},
              lineColor={255,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
    end AbsolutePressure;

    model VolumeFlow "Enforces constant volume flow"

      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort(final tapT=1);
      parameter Boolean useVolumeFlowInput=false
        "Enable / disable volume flow input"
        annotation(Evaluate=true, choices(checkBox=true));
      parameter Modelica.SIunits.VolumeFlowRate constantVolumeFlow(start=1)
        "Volume flow rate"
        annotation(Dialog(enable=not useVolumeFlowInput));
      Modelica.Blocks.Interfaces.RealInput volumeFlow=internalVolumeFlow if useVolumeFlowInput
        annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,100})));
    protected
      Modelica.SIunits.VolumeFlowRate internalVolumeFlow;
    equation
      if not useVolumeFlowInput then
        internalVolumeFlow = constantVolumeFlow;
      end if;
      Q_flow = 0;
      V_flow = internalVolumeFlow;
      annotation (
        Documentation(info="<html>
<p>Fan resp. pump with constant volume flow rate. Pressure increase is the response of the whole system.</p>
<p>Coolant's temperature and enthalpy flow are not affected.</p>
<p>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglect of temperature transient cv*m*der(T).
</p>
<p>Thermodynamic equations are defined by Partials.TwoPort.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Ellipse(
              extent={{-90,90},{90,-90}},
              lineColor={255,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-60,68},{90,10},{90,-10},{-60,-68},{-60,68}},
              lineColor={255,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-40,30},{20,-30}},
              textString="V"),                Text(
              extent={{-150,-140},{150,-100}},
              lineColor={0,0,255},
              textString="%name")}));
    end VolumeFlow;

    model PressureIncrease "Enforces constant pressure increase"

      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort(final tapT=1);
      parameter Boolean usePressureIncreaseInput=false
        "Enable / disable pressure increase input"
        annotation(Evaluate=true, choices(checkBox=true));
      parameter Modelica.SIunits.Pressure constantPressureIncrease(start=1)
        "Pressure increase"
        annotation(Dialog(enable=not usePressureIncreaseInput));
      Modelica.Blocks.Interfaces.RealInput pressureIncrease=internalPressureIncrease if usePressureIncreaseInput
        annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,100})));
    protected
      Modelica.SIunits.Pressure internalPressureIncrease;
    equation
      if not usePressureIncreaseInput then
        internalPressureIncrease = constantPressureIncrease;
      end if;
      Q_flow = 0;
      dp = -internalPressureIncrease;
      annotation (
        Documentation(info="<html>
<p>Fan resp. pump with constant pressure increase. Mass resp. volume flow is the response of the whole system.</p>
<p>Coolant's temperature and enthalpy flow are not affected.</p>
<p>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglect of temperature transient cv*m*der(T).
</p>
<p>Thermodynamic equations are defined by Partials.TwoPort.</p>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Ellipse(
              extent={{-90,90},{90,-90}},
              lineColor={255,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-60,68},{90,10},{90,-10},{-60,-68},{-60,68}},
              lineColor={0,0,255},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-40,30},{20,-30}},
              textString="dp"),               Text(
              extent={{-150,-100},{150,-140}},
              lineColor={0,0,255},
              textString="%name")}));
    end PressureIncrease;

    model IdealPump "Model of an ideal pump"

      extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort(final tapT=1);
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
        dp = -dp1*(1 - V_flow/V_flow1);
        flange_a.tau*w = -dp*V_flow;
      end if;
      // no energy exchange with medium
      Q_flow = 0;
    annotation (Documentation(info="<html>
<p>
Simple fan resp. pump where characteristic is dependent on shaft's speed, <br>
torque * speed = pressure increase * volume flow (without losses)<br>
Pressure increase versus volume flow is defined by a linear function,
from dp0(V_flow=0) to V_flow0(dp=0).<br>
The axis intersections vary with speed as follows:
</p>
<ul>
<li>dp prop. speed^2</li>
<li>V_flow prop. speed</li>
</ul>
<p>
Coolant's temperature and enthalpy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
Thermodynamic equations are defined by Partials.TwoPort.
</p>
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
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={175,175,175}),
            Polygon(
              points={{-60,68},{90,10},{90,-10},{-60,-68},{-60,68}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,0,255})}));
    end IdealPump;
  annotation (Documentation(info="<html>
<p>
This package contains different types of sources:
</p>
<ul>
<li>Ambient with constant or prescribed pressure and temperature</li>
<li>AbsolutePressure to define pressure level of a closed cooling cycle.</li>
<li>Constant and prescribed volume flow</li>
<li>Constant and prescribed pressure increase</li>
<li>Simple pump with mechanical flange</li>
</ul>
<p>
Thermodynamic equations are defined in partial models (package Interfaces.Partials).
All fans / pumps are considered without losses, they do not change enthalpy flow.
</p>
</html>"));
  end Sources;

  package Interfaces "Connectors and partial models"
    extends Modelica.Icons.InterfacesPackage;

    connector FlowPort "Connector flow port"

      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium "Medium in the connector";
      Modelica.SIunits.Pressure p;
      flow Modelica.SIunits.MassFlowRate m_flow;
      Modelica.SIunits.SpecificEnthalpy h;
      flow Modelica.SIunits.EnthalpyFlowRate H_flow;
    annotation (Documentation(info="<html>
Basic definition of the connector.<br>
<strong>Variables:</strong>
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

      extends Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort;
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

      extends Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort;
    annotation (Documentation(info="<html>
Same as FlowPort, but icon allows to differentiate direction of flow.
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Ellipse(extent={{-98,98},{98,-98}},
                lineColor={0,0,255})}), Diagram(coordinateSystem(
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
      extends Modelica.Icons.BasesPackage;

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
        if volumeFlow > +V_flowLaminar then
          pressureDrop = +dpLaminar/V_flowLaminar*volumeFlow + k*(volumeFlow - V_flowLaminar)^2;
        elseif volumeFlow < -V_flowLaminar then
          pressureDrop = +dpLaminar/V_flowLaminar*volumeFlow - k*(volumeFlow + V_flowLaminar)^2;
        else
          pressureDrop =  dpLaminar/V_flowLaminar*volumeFlow;
        end if;
        Q_friction = frictionLoss*volumeFlow*pressureDrop;
      annotation (Documentation(info="<html>
<p>
Definition of relationship between pressure drop and volume flow rate:
</p>
<ul>
<li>-V_flowLaminar &lt; VolumeFlow &lt; +V_flowLaminar: laminar, i.e., linear dependency of pressure drop on volume flow.</li>
<li>-V_flowLaminar &gt; VolumeFlow or VolumeFlow &lt; +V_flowLaminar: turbulent, i.e., quadratic dependency of pressure drop on volume flow.</li>
</ul>
<p>
Linear and quadratic dependency are coupled smoothly at V_flowLaminar / dpLaminar.
Quadratic dependency is defined by nominal volume flow and pressure drop (V_flowNominal / dpNominal).
See also sketch at diagram layer.
</p>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={
              Line(points={{-80,0},{80,0}}, color={0,0,255}),
              Line(points={{0,80},{0,-80}}, color={0,0,255}),
              Line(points={{-40,-20},{40,20}}, color={0,0,255}),
              Line(points={{40,20},{60,40},{70,60},{74,80}}, color={0,0,255}),
              Line(points={{-40,-20},{-60,-40},{-70,-60},{-74,-80}}, color={0,0,255}),
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
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium()
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
        Modelica.SIunits.VolumeFlowRate V_flow(start=0) "Volume flow a->b";
        Modelica.SIunits.HeatFlowRate Q_flow "Heat exchange with ambient";
        output Modelica.SIunits.Temperature T(start=T0, fixed=T0fixed)
          "Outlet temperature of medium";
        output Modelica.SIunits.Temperature T_a "Temperature at flowPort_a";
        output Modelica.SIunits.Temperature T_b "Temperature at flowPort_b";
        output Modelica.SIunits.TemperatureDifference dT
          "Temperature increase of coolant in flow direction";
        Modelica.SIunits.Temperature T_q
          "Temperature relevant for heat exchange with ambient";
      protected
        Modelica.SIunits.SpecificEnthalpy h(start=medium.cp*T0) "Medium's specific enthalpy";
      public
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium=medium)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium=medium)
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
<p>Partial model with two flowPorts.</p>
<p>Possible heat exchange with the ambient is defined by Q_flow; setting this = 0 means no energy exchange.</p>
<p>
Setting parameter m (mass of medium within pipe) to zero
leads to neglect of temperature transient cv*m*der(T).</p>
<p>Mixing rule is applied.</p>
<p>Parameter 0 &lt; tapT &lt; 1 defines temperature of heatPort between medium's inlet and outlet temperature.</p>
</html>"));
      end TwoPort;

      partial model SinglePortLeft
        "Partial model of a single port at the left"
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium() "Medium"
          annotation(choicesAllMatching=true);
        parameter Modelica.SIunits.Temperature T0(start=293.15, displayUnit="degC")
          "Initial temperature of medium";
        parameter Boolean T0fixed=false
          "Initial temperature guess value or fixed"
        annotation(choices(checkBox=true));
        output Modelica.SIunits.Temperature T_port "Temperature at flowPort_a";
        output Modelica.SIunits.Temperature T(start=T0, fixed=T0fixed) "Outlet temperature of medium";
        Interfaces.FlowPort_a flowPort(final medium=medium)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      protected
        constant Boolean Exchange=true "Exchange of medium via flowport"
          annotation(HideResult=true);
        Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy in the volume";
      equation
        T_port=flowPort.h/medium.cp;
        T=h/medium.cp;
        // mass flow -> ambient: mixing rule
        // mass flow <- ambient: energy flow defined by ambient's temperature
        if Exchange then
          flowPort.H_flow = semiLinear(flowPort.m_flow,flowPort.h,h);
        else
          h=flowPort.h;
        end if;
      annotation (Documentation(info="<html>
<p>
Partial model of single port at the left, defining the medium and the temperature at the port.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={       Text(
                extent={{-150,140},{150,100}},
                lineColor={0,0,255},
                textString="%name")}));
      end SinglePortLeft;

      partial model Ambient "Partial model of ambient"
        extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.SinglePortLeft(final Exchange=true, final T0=293.15);
        extends Icons.ObsoleteModel;
        annotation (obsolete = "Obsolete model - use SinglePortLeft instead",
        Documentation(info="<html>
<p>
This model simply extends from the <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.SinglePortLeft\">SinglePortLeft</a> model,
only adding an icon, and is kept for compatibility reasons. In the future, it will be removed.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={Ellipse(
                extent={{-90,90},{90,-90}},
                lineColor={255,0,0},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid)}));
      end Ambient;

      partial model SinglePortBottom
        "Partial model of a single port at the bottom"
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium() "Medium"
          annotation(choicesAllMatching=true);
        parameter Modelica.SIunits.Temperature T0(start=293.15, displayUnit="degC")
          "Initial temperature of medium";
        parameter Boolean T0fixed=false
          "Initial temperature guess value or fixed"
        annotation(choices(checkBox=true));
        output Modelica.SIunits.Temperature T_port "Temperature at flowPort_a";
        output Modelica.SIunits.Temperature T(start=T0, fixed=T0fixed) "Outlet temperature of medium";
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort(final medium=medium)
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      protected
        constant Boolean Exchange=true "Exchange of medium via flowport"
          annotation(HideResult=true);
        Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy in the volume";
      equation
        T_port=flowPort.h/medium.cp;
        T=h/medium.cp;
        // mass flow -> ambient: mixing rule
        // mass flow <- ambient: energy flow defined by ambient's temperature
        if Exchange then
          flowPort.H_flow = semiLinear(flowPort.m_flow,flowPort.h,h);
        else
          h=flowPort.h;
        end if;
      annotation (Documentation(info="<html>
<p>
Partial model of single port at the bottom, defining the medium and the temperature at the port.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={       Text(
                extent={{-150,140},{150,100}},
                lineColor={0,0,255},
                textString="%name")}));
      end SinglePortBottom;

      partial model AbsoluteSensor "Partial model of absolute sensor"
        extends Modelica.Icons.RotationalSensor;
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
          "Sensor's medium"
          annotation(choicesAllMatching=true);
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort(final medium=medium)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        // no mass exchange
        flowPort.m_flow = 0;
        // no energy exchange
        flowPort.H_flow = 0;
      annotation (Documentation(info="<html>
<p>Partial model for an absolute sensor (pressure/temperature).</p>
<p>Pressure, mass flow, temperature and enthalpy flow of medium are not affected.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Line(points={{-70,0},{-90,0}}),
              Line(points={{70,0},{100,0}})}));
      end AbsoluteSensor;

      partial model RelativeSensor "Partial model of relative sensor"
        extends Modelica.Icons.RotationalSensor;
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
          "Sensor's medium"
          annotation(choicesAllMatching=true);
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium=medium)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium=medium)
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
<p>Partial model for a relative sensor (pressure drop/temperature difference).</p>
<p>Pressure, mass flow, temperature and enthalpy flow of medium are not affected.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Line(points={{-70,0},{-90,0}}),
              Line(points={{70,0},{90,0}}),
              Line(points={{0,-100},{0,-70}}),
              Text(
                extent={{-150,100},{150,140}},
                textString="%name",
                lineColor={0,0,255})}));
      end RelativeSensor;

      partial model FlowSensor "Partial model of flow sensor"
        extends Modelica.Icons.RotationalSensor;
        extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort(final m=0, final T0=293.15, final T0fixed=false, final tapT=1);
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
<p>Partial model for a flow sensor (mass flow/heat flow).</p>
<p>Pressure, mass flow, temperature and enthalpy flow of medium are not affected, but mixing rule is applied.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Line(points={{-70,0},{-90,0}}),
              Line(points={{70,0},{90,0}}),
              Line(points={{0,-100},{0,-70}}),
              Text(
                extent={{-150,100},{150,140}},
                textString="%name",
                lineColor={0,0,255})}));
      end FlowSensor;
    annotation (Documentation(info="<html>
<p>
Package containing partial models from which all components (except Sources.AbsolutePressure) extend
instantiating the medium and containing the thermodynamic equation(s) with semiLinear.
</p>
</html>"));
    end Partials;
  annotation (Documentation(info="<html>
<p>This package contains connectors and partial models:</p>
<ul>
<li>FlowPort: basic definition of the connector.</li>
<li>FlowPort_a &amp; FlowPort_b: same as FlowPort with different icons to differentiate direction of flow</li>
<li>package Partials (defining basic thermodynamic equations)</li>
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
<strong>Variables used in connectors:</strong>
<ul>
<li>Pressure p</li>
<li>flow MassFlowRate m_flow</li>
<li>SpecificEnthalpy h</li>
<li>flow EnthalpyFlowRate H_flow</li>
</ul>
<p>EnthalpyFlowRate means the Enthalpy = cp<sub>constant</sub> * m * T that is carried by the medium's flow.</p>
<strong>Limitations and assumptions:</strong>
<ul>
<li>Splitting and mixing of coolant flows (media with the same cp) is possible.</li>
<li>Reversing the direction of flow is possible.</li>
<li>The medium is considered to be incompressible.</li>
<li>No mixtures of media is taken into consideration.</li>
<li>The medium may not change its phase.</li>
<li>Medium properties are kept constant.</li>
<li>Pressure changes are only due to pressure drop and geodetic height difference rho*g*h (if h > 0).</li>
<li>A user-defined part (0..1) of the friction losses (V_flow*dp) are fed to the medium.</li>
<li><strong>Note:</strong> Connected flowPorts have the same temperature (mixing temperature)!<br>
Since mixing may occur, the outlet temperature may be different from the connector's temperature.<br>
Outlet temperature is defined by variable T of the corresponding component.</li>
</ul>
<p>
Copyright &copy; 1998-2018, Modelica Association, Anton Haumer, Christian Kral and AIT.
</p>
<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
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
