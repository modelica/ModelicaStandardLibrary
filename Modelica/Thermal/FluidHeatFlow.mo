within Modelica.Thermal;


package FluidHeatFlow
  "Simple components for 1-dimensional incompressible thermo-fluid flow models"
  extends Modelica.Icons.Library2;
  // illegal use of top-level annotation removed:
  // version="1.6.6", versionDate="2007-11-12",

  package Examples
    "Examples that demonstrate the usage of the FluidHeatFlow components"
    extends Modelica.Icons.Library2;

    model SimpleCooling "Example: simple cooling circuit"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(__Dymola_choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource=
        prescribedHeatFlow.port.T-TAmb "Source over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=prescribedHeatFlow.port.T-pipe.heatPort.T
        "Source over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=pipe.dT
        "Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}},
              rotation=0)));
      Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}},
              rotation=0)));
      FluidHeatFlow.Components.HeatedPipe pipe(
        medium=medium,
        m=0.1,
        T0=TAmb)
        annotation (Placement(transformation(extent={{0,-10},{20,10}}, rotation=
               0)));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium)
        annotation (Placement(transformation(extent={{40,-10},{60,10}},
              rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
        T(start=TAmb), C=0.1)
        annotation (Placement(transformation(
            origin={40,-50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow
        annotation (Placement(transformation(extent={{-30,-40},{-10,-60}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant volumeFlow(k=1)
        annotation (Placement(transformation(extent={{-60,10},{-40,30}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant heatFlow(k=10)
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}},
              rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection
        annotation (Placement(transformation(
            origin={10,-30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant thermalConductance(k=1)
        annotation (Placement(transformation(extent={{-30,-40},{-10,-20}},
              rotation=0)));
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
          color={0,0,127},
          smooth=Smooth.None));
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
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics),
        experiment(StopTime=1.0));
    end SimpleCooling;

    model ParallelCooling "Example: coolig circuit with parallel branches"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(__Dymola_choicesAllMatching=true);
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
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}},
              rotation=0)));
      Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}},
              rotation=0)));
      FluidHeatFlow.Components.HeatedPipe pipe1(
        medium=medium,
        m=0.1,
        T0=TAmb)
        annotation (Placement(transformation(extent={{0,-20},{20,0}}, rotation=
                0)));
      FluidHeatFlow.Components.HeatedPipe pipe2(
        medium=medium,
        m=0.1,
        T0=TAmb)
        annotation (Placement(transformation(extent={{0,20},{20,0}}, rotation=0)));
      FluidHeatFlow.Components.IsolatedPipe pipe3(
        medium=medium,
        m=0.1,
        T0=TAmb)
        annotation (Placement(transformation(extent={{40,-10},{60,10}},
              rotation=0)));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium)
        annotation (Placement(transformation(extent={{80,-10},{100,10}},
              rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(
        T(start=TAmb), C=0.1)
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
        T(start=TAmb), C=0.1)
        annotation (Placement(transformation(
            origin={38,60},
            extent={{10,-10},{-10,10}},
            rotation=90)));
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
        annotation (Placement(transformation(extent={{-60,10},{-40,30}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant heatFlow1(k=5)
        annotation (Placement(transformation(extent={{-60,-70},{-40,-50}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant heatFlow2(k=10)
        annotation (Placement(transformation(extent={{-60,50},{-40,70}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant thermalConductance1(k=1)
        annotation (Placement(transformation(extent={{-30,-50},{-10,-30}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant thermalConductance2(k=1)
        annotation (Placement(transformation(extent={{-30,30},{-10,50}},
              rotation=0)));
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
      connect(pipe1.heatPort,convection1. fluid) annotation (Line(points={{10,-20},
              {10,-30},{10,-30}},               color={191,0,0}));
      connect(convection2.fluid,pipe2. heatPort) annotation (Line(points={{10,
              30},{10,20}}, color={191,0,0}));
      connect(convection2.solid,prescribedHeatFlow2. port) annotation (Line(
            points={{10,50},{10,60},{-10,60}}, color={191,0,0}));
      connect(convection2.solid,heatCapacitor2. port) annotation (Line(points={
              {10,50},{10,60},{48,60}}, color={191,0,0}));
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
          color={0,0,127},
          smooth=Smooth.None));
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
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics),
        experiment(StopTime=1.0));
    end ParallelCooling;

    model IndirectCooling "Example: indirect cooling circuit"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium outerMedium=FluidHeatFlow.Media.Medium()
        "Outer medium"
        annotation(__Dymola_choicesAllMatching=true);
      parameter FluidHeatFlow.Media.Medium innerMedium=FluidHeatFlow.Media.Medium()
        "Inner medium"
        annotation(__Dymola_choicesAllMatching=true);
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
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=outerMedium)
                            annotation (Placement(transformation(extent={{-60,
                60},{-80,80}}, rotation=0)));
      Sources.VolumeFlow outerPump(
        medium=outerMedium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true)
        annotation (Placement(transformation(extent={{-40,60},{-20,80}},
              rotation=0)));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=outerMedium)
                            annotation (Placement(transformation(extent={{40,60},
                {60,80}}, rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor
        thermalConductor(                                                        G=1)
        annotation (Placement(transformation(
            origin={10,-70},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
        T(start=TAmb), C=0.05)
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
        dpLaminar=1000,
        V_flowNominal=2,
        dpNominal=2000)
        annotation (Placement(transformation(extent={{20,-50},{0,-30}},
              rotation=0)));
      FluidHeatFlow.Sources.AbsolutePressure absolutePressure(p=10000, medium=innerMedium)
                            annotation (Placement(transformation(extent={{40,
                -40},{60,-20}}, rotation=0)));
      Sources.VolumeFlow innerPump(
        medium=innerMedium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true)
        annotation (Placement(transformation(
            origin={-20,-30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant heatFlow(k=10)
        annotation (Placement(transformation(extent={{-60,-100},{-40,-80}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant outerVolumeFlow(k=1)
        annotation (Placement(transformation(extent={{-60,80},{-40,100}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant innerVolumeFlow(k=1)
        annotation (Placement(transformation(extent={{-60,-40},{-40,-20}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant outerGc(k=2)
        annotation (Placement(transformation(extent={{-40,30},{-20,50}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant innerGc(k=2)
        annotation (Placement(transformation(extent={{-40,20},{-20,0}},
              rotation=0)));
      FluidHeatFlow.Components.HeatedPipe outerPipe(
        medium=outerMedium,
        m=0.1,
        T0=TAmb)
        annotation (Placement(transformation(extent={{0,60},{20,80}}, rotation=
                0)));
      FluidHeatFlow.Components.HeatedPipe innerPipe(
        medium=innerMedium,
        m=0.1,
        T0=TAmb)
        annotation (Placement(transformation(extent={{0,-10},{20,-30}},
              rotation=0)));
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
        annotation (Line(points={{10,60},{10,55},{10,50},{10,50}}, color={191,0,
              0}));
      connect(outerConvection.solid, innerConvection.solid)
        annotation (Line(points={{10,30},{10,20},{10,20}},
                       color={191,0,0}));
      connect(innerConvection.fluid, innerPipe.heatPort)
        annotation (Line(points={{10,0},{10,-5},{10,-5},{10,-10}}, color={191,0,
              0}));
      connect(innerGc.y, innerConvection.Gc)
        annotation (Line(points={{-19,10},{-9.5,10},{-9.5,10},{0,10}}, color={0,
              0,127}));
      connect(outerGc.y, outerConvection.Gc)
        annotation (Line(points={{-19,40},{0,40}},  color={0,0,127}));
      connect(outerVolumeFlow.y, outerPump.volumeFlow) annotation (Line(
          points={{-39,90},{-30,90},{-30,80}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(innerVolumeFlow.y, innerPump.volumeFlow) annotation (Line(
          points={{-39,-30},{-30,-30}},
          color={0,0,127},
          smooth=Smooth.None));
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
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics),
        experiment(StopTime=1.5));
    end IndirectCooling;

    model PumpAndValve "Example: cooling circuit with pump and valve"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(__Dymola_choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource=
        prescribedHeatFlow.port.T-TAmb "Source over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=prescribedHeatFlow.port.T-pipe.heatPort.T
        "Source over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=pipe.dT
        "Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium)
        annotation (Placement(transformation(extent={{-70,-10},{-90,10}},
              rotation=0)));
      FluidHeatFlow.Sources.IdealPump idealPump(
        medium=medium,
        m=0,
        T0=TAmb)
        annotation (Placement(transformation(extent={{-60,10},{-40,-10}},
              rotation=0)));
      FluidHeatFlow.Components.Valve valve(
        medium=medium,
        T0=TAmb,
        LinearCharacteristic=false)
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}},
              rotation=0)));
      FluidHeatFlow.Components.HeatedPipe pipe(
        medium=medium,
        T0=TAmb,
        m=0.1)
        annotation (Placement(transformation(extent={{0,-10},{20,10}}, rotation=
               0)));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium)
        annotation (Placement(transformation(extent={{40,-10},{60,10}},
              rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
        T(start=TAmb), C=0.1)
        annotation (Placement(transformation(
            origin={40,-50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow
        annotation (Placement(transformation(extent={{-30,-40},{-10,-60}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant heatFlow(k=10)
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}},
              rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection
        annotation (Placement(transformation(
            origin={10,-30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant thermalConductance(k=1)
        annotation (Placement(transformation(extent={{-30,-40},{-10,-20}},
              rotation=0)));
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
                -60,60}}, rotation=0)));
      Modelica.Blocks.Sources.Ramp valveRamp(
        height=0.5,
        offset=0.5,
        duration=0.1,
        startTime=0.9) annotation (Placement(transformation(extent={{12,40},{-8,
                60}}, rotation=0)));
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
          points={{-50,20},{-50,10}},
          color={0,0,0},
          smooth=Smooth.None));
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
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics),
        experiment(StopTime=2));
    end PumpAndValve;

    model PumpDropOut "Example: cooling circuit with drop out of pump"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(__Dymola_choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      output Modelica.SIunits.TemperatureDifference dTSource=
        prescribedHeatFlow.port.T-TAmb "Source over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=prescribedHeatFlow.port.T-pipe.heatPort.T
        "Source over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=pipe.dT
        "Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}},
              rotation=0)));
      Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}},
              rotation=0)));
      FluidHeatFlow.Components.HeatedPipe pipe(
        medium=medium,
        T0=TAmb,
        m=0.1)
        annotation (Placement(transformation(extent={{0,-10},{20,10}}, rotation=
               0)));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium)
        annotation (Placement(transformation(extent={{40,-10},{60,10}},
              rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
        T(start=TAmb), C=0.1)
        annotation (Placement(transformation(
            origin={40,-50},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow
        annotation (Placement(transformation(extent={{-30,-40},{-10,-60}},
              rotation=0)));
      Utilities.DoubleRamp volumeFlow
        annotation (Placement(transformation(extent={{-60,10},{-40,30}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant heatFlow(k=10)
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}},
              rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection
        annotation (Placement(transformation(
            origin={10,-30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Sources.Constant thermalConductance(k=1)
        annotation (Placement(transformation(extent={{-30,-40},{-10,-20}},
              rotation=0)));
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
          color={0,0,127},
          smooth=Smooth.None));
    annotation (Documentation(info="<HTML>
<p>
5th test example: PumpDropOut
</p>
Same as 1st test example, but with a drop out of the pump:<br>
The pump is running for 0.2 s, then shut down (using a ramp of 0.2 s) for 0.2 s,
then started again (using a ramp of 0.2 s).
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics),
        experiment(StopTime=2));
    end PumpDropOut;

    model ParallelPumpDropOut
      "Example: cooling circuit with parallel branches and drop out of pump"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(__Dymola_choicesAllMatching=true);
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
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}},
              rotation=0)));
      Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}},
              rotation=0)));
      FluidHeatFlow.Components.HeatedPipe pipe1(
        medium=medium,
        m=0.1,
        T0=TAmb)
        annotation (Placement(transformation(extent={{0,-20},{20,0}}, rotation=
                0)));
      FluidHeatFlow.Components.HeatedPipe pipe2(
        medium=medium,
        m=0.1,
        T0=TAmb)
        annotation (Placement(transformation(extent={{0,20},{20,0}}, rotation=0)));
      FluidHeatFlow.Components.IsolatedPipe pipe3(
        medium=medium,
        T0=TAmb,
        m=0.1)
        annotation (Placement(transformation(extent={{40,-10},{60,10}},
              rotation=0)));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium)
        annotation (Placement(transformation(extent={{80,-10},{100,10}},
              rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(
        T(start=TAmb), C=0.1)
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
        T(start=TAmb), C=0.1)
        annotation (Placement(transformation(
            origin={38,60},
            extent={{10,-10},{-10,10}},
            rotation=90)));
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
        annotation (Placement(transformation(extent={{-60,10},{-40,30}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant heatFlow1(k=5)
        annotation (Placement(transformation(extent={{-60,-70},{-40,-50}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant heatFlow2(k=10)
        annotation (Placement(transformation(extent={{-60,50},{-40,70}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant thermalConductance1(k=1)
        annotation (Placement(transformation(extent={{-30,-50},{-10,-30}},
              rotation=0)));
      Modelica.Blocks.Sources.Constant thermalConductance2(k=1)
        annotation (Placement(transformation(extent={{-30,30},{-10,50}},
              rotation=0)));
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
      connect(thermalConductance1.y, Convection1.Gc)
                                    annotation (Line(points={{-9,-40},{0,-40}},
            color={0,0,127}));
      connect(pipe1.heatPort, Convection1.fluid) annotation (Line(points={{10,-20},
              {10,-25},{10,-30},{10,-30}},      color={191,0,0}));
      connect(convection2.fluid,pipe2. heatPort) annotation (Line(points={{10,
              30},{10,20}}, color={191,0,0}));
      connect(convection2.solid,prescribedHeatFlow2. port) annotation (Line(
            points={{10,50},{10,60},{-10,60}}, color={191,0,0}));
      connect(convection2.solid,heatCapacitor2. port) annotation (Line(points={
              {10,50},{10,60},{48,60}}, color={191,0,0}));
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
          color={0,0,127},
          smooth=Smooth.None));
    annotation (Documentation(info="<HTML>
<p>
6th test example: ParallelPumpDropOut
</p>
Same as 2nd test example, but with a drop out of the pump:<br>
The pump is running for 0.2 s, then shut down (using a ramp of 0.2 s) for 0.2 s,
then started again (using a ramp of 0.2 s).
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics),
        experiment(StopTime=2));
    end ParallelPumpDropOut;

    model OneMass "Example: ccoling of one hot mass"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(__Dymola_choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      parameter Modelica.SIunits.Temperature TMass(displayUnit="degC")=313.15
        "Inital temperature of mass";
      output Modelica.SIunits.TemperatureDifference dTMass=
        heatCapacitor.port.T-TAmb "Mass over Ambient";
      output Modelica.SIunits.TemperatureDifference dTtoPipe=heatCapacitor.port.T-pipe.heatPort.T
        "Mass over Coolant";
      output Modelica.SIunits.TemperatureDifference dTCoolant=pipe.dT
        "Coolant's temperature increase";
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}},
              rotation=0)));
      Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}},
              rotation=0)));
      FluidHeatFlow.Components.HeatedPipe pipe(
        medium=medium,
        m=0.1,
        T0=TAmb)
        annotation (Placement(transformation(extent={{0,-10},{20,10}}, rotation=
               0)));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium)
        annotation (Placement(transformation(extent={{40,-10},{60,10}},
              rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
        C=0.1, T(start=TMass))
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
                30}}, rotation=0)));
    equation
      connect(ambient1.flowPort, pump.flowPort_a)
        annotation (Line(points={{-60,0},{-40,0}}, color={255,0,0}));
      connect(pump.flowPort_b, pipe.flowPort_a)
        annotation (Line(points={{-20,0},{0,0}}, color={255,0,0}));
      connect(pipe.flowPort_b, ambient2.flowPort)
        annotation (Line(points={{20,0},{40,0}}, color={255,0,0}));
      connect(thermalConductor.port_a, heatCapacitor.port)   annotation (Line(
            points={{10,-40},{10,-45},{10,-50},{10,-50}}, color={191,0,0}));
      connect(pipe.heatPort, thermalConductor.port_b)
        annotation (Line(points={{10,-10},{10,-20}}, color={191,0,0}));
      connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
          points={{-39,20},{-30,20},{-30,10}},
          color={0,0,127},
          smooth=Smooth.None));
    annotation (Documentation(info="<HTML>
<p>
7th test example: OneMass
</p>
A thermal capacity is coupled with a coolant flow.
Different inital temperatures of thermal capacity and pipe's coolant get ambient's temperature,
the time behaviour depending on coolant flow.
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics),
        experiment(StopTime=1.0));
    end OneMass;

    model TwoMass "Example: cooling of two hot masses"
      extends Modelica.Icons.Example;
      parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
        "Cooling medium"
        annotation(__Dymola_choicesAllMatching=true);
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC")=293.15
        "Ambient temperature";
      parameter Modelica.SIunits.Temperature TMass1(displayUnit="degC")=313.15
        "Inital temperature of mass1";
      parameter Modelica.SIunits.Temperature TMass2(displayUnit="degC")=333.15
        "Inital temperature of mass2";
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
      FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature=TAmb, medium=medium)
        annotation (Placement(transformation(extent={{-60,-10},{-80,10}},
              rotation=0)));
      Sources.VolumeFlow pump(
        medium=medium,
        m=0,
        T0=TAmb,
        useVolumeFlowInput=true)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}},
              rotation=0)));
      FluidHeatFlow.Components.HeatedPipe pipe1(
        medium=medium,
        m=0.1,
        T0=TAmb)
        annotation (Placement(transformation(extent={{0,-20},{20,0}}, rotation=
                0)));
      FluidHeatFlow.Components.HeatedPipe pipe2(
        medium=medium,
        m=0.1,
        T0=TAmb)
        annotation (Placement(transformation(extent={{0,20},{20,0}}, rotation=0)));
      FluidHeatFlow.Components.IsolatedPipe pipe3(
        medium=medium,
        m=0.1,
        T0=TAmb)
        annotation (Placement(transformation(extent={{40,-10},{60,10}},
              rotation=0)));
      FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature=TAmb, medium=medium)
        annotation (Placement(transformation(extent={{80,-10},{100,10}},
              rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(
        C=0.1, T(start=TMass1))
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
        C=0.1, T(start=TMass2))
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
                30}}, rotation=0)));
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
            points={{10,60},{10,55},{10,55},{10,50}}, color={191,0,0}));
      connect(thermalConductor2.port_b,pipe2. heatPort)
        annotation (Line(points={{10,30},{10,20}}, color={191,0,0}));
      connect(pipe1.heatPort,thermalConductor1. port_b) annotation (Line(points=
             {{10,-20},{10,-30}}, color={191,0,0}));
      connect(thermalConductor1.port_a, heatCapacitor1.port) annotation (Line(
            points={{10,-50},{10,-55},{10,-60},{10,-60}}, color={191,0,0}));
      connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
          points={{-39,20},{-30,20},{-30,10}},
          color={0,0,127},
          smooth=Smooth.None));
    annotation (Documentation(info="<HTML>
<p>
8th test example: TwoMass
</p>
Two thermal capacities are coupled with two parallel coolant flow.
Different inital temperatures of thermal capacities and pipe's coolants get ambient's temperature,
the time behaviour depending on coolant flow.
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics),
        experiment(StopTime=1.0));
    end TwoMass;

    package Utilities "Utility models for examples"
      extends Modelica.Icons.Library;

      model DoubleRamp "Ramp going up and down"
        extends Modelica.Blocks.Interfaces.SO;
        parameter Real offset(start=1) "Offset of ramps";
        parameter Modelica.SIunits.Time startTime(start=0.2)
          "StartTime of 1st ramp";
        parameter Modelica.SIunits.Time interval(start=0.2)
          "Interval between end of 1st and beginning of 2nd ramp";
        parameter Real height_1(start=-1) "Height of ramp"
          annotation(Dialog(group="Ramp 1"));
        parameter Modelica.SIunits.Time duration_1(min=Modelica.Constants.small, start=0.2)
          "Duration of ramp"
          annotation(Dialog(group="Ramp 1"));
        parameter Real height_2(start=1) "Height of ramp"
          annotation(Dialog(group="Ramp 2"));
        parameter Modelica.SIunits.Time duration_2(min=Modelica.Constants.small, start=0.2)
          "Duration of ramp"
          annotation(Dialog(group="Ramp 2"));

        Modelica.Blocks.Math.Add add  annotation (Placement(transformation(
                extent={{10,-10},{30,10}}, rotation=0)));
        Modelica.Blocks.Sources.Ramp ramp1(
          final height=height_1,
          final duration=duration_1,
          final startTime=startTime,
          final offset=offset)
                         annotation (Placement(transformation(extent={{-30,10},
                  {-10,30}}, rotation=0)));
        Modelica.Blocks.Sources.Ramp ramp2(
          final height=height_2,
          final duration=duration_2,
          final startTime=startTime + duration_1 + interval,
          final offset=0)
          annotation (Placement(transformation(extent={{-30,-30},{-10,-10}},
                rotation=0)));
      equation
        connect(ramp1.y, add.u1)  annotation (Line(points={{-9,20},{0,20},{0,6},
                {8,6}}, color={0,0,127}));
        connect(ramp2.y, add.u2)  annotation (Line(points={{-9,-20},{0,-20},{0,
                -6},{8,-6}}, color={0,0,127}));
        connect(add.y, y)  annotation (Line(points={{31,0},{110,0}}, color={0,0,
                127}));
        annotation (
          Documentation(info="<HTML>
Block generating the sum of two ramps.
</HTML>"),Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
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
                points={{-80,-60},{-50,-60},{-30,60},{10,60},{30,-20},{70,-20}},

                color={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid)}));
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
  Dr.Christian Kral<br>
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2009, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b>
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.41 Beta 2005/06/17 Anton Haumer<br>
       first used</li>
  </ul>
</HTML>"));
    end Utilities;
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
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </p>
  <p>
  Dr.Christian Kral<br>
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2009, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b>
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
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
"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Ellipse(extent={{-60,10},{40,-90}}, lineColor={
                135,135,135}), Polygon(
            points={{-30,-12},{-30,-68},{28,-40},{-30,-12}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid)}));
  end Examples;

  package Components "Basic components (pipes, valves)"
    extends Modelica.Icons.Library2;

    model IsolatedPipe "Pipe without heat exchange"

      extends Interfaces.Partials.TwoPort(final tapT=1);
      extends Interfaces.Partials.SimpleFriction;
      parameter Modelica.SIunits.Length h_g(start=0)
        "Geodetic height (heigth difference from flowPort_a to flowPort_b)";
    equation
      // coupling with FrictionModel
      volumeFlow = V_flow;
      dp = pressureDrop + medium.rho*Modelica.Constants.g_n*h_g;
      // no energy exchange with medium
      Q_flow = Q_friction;
    annotation (Documentation(info="<HTML>
Pipe without heat exchange.<br>
Thermodynamic equations are defined by Partials.TwoPortMass(Q_flow = 0).<br>
<b>Note:</b> Setting parameter m (mass of medium within pipe) to zero
leads to neglection of temperature transient cv*m*der(T).
</HTML>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={Rectangle(
              extent={{-90,20},{90,-20}},
              lineColor={255,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid), Text(extent={{-150,100},{150,40}},
                textString="%name")}),                          Diagram(
            coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}),                                                 graphics));
    end IsolatedPipe;

    model HeatedPipe "Pipe with heat exchange"

      extends Interfaces.Partials.TwoPort;
      extends Interfaces.Partials.SimpleFriction;
      parameter Modelica.SIunits.Length h_g(start=0)
        "Geodetic height (heigth difference from flowPort_a to flowPort_b)";
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
              rotation=0)));
    equation
      // coupling with FrictionModel
      volumeFlow = V_flow;
      dp = pressureDrop + medium.rho*Modelica.Constants.g_n*h_g;
      // energy exchange with medium
      Q_flow = heatPort.Q_flow + Q_friction;
      // defines heatPort's temperature
      heatPort.T = T_q;
    annotation (Documentation(info="<HTML>
Pipe with heat exchange.<br>
Thermodynamic equations are defined by Partials.TwoPort.<br>
Q_flow is defined by heatPort.Q_flow.<br>
<b>Note:</b> Setting parameter m (mass of medium within pipe) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
<b>Note:</b> Injecting heat into a pipe with zero massflow causes
temperature rise defined by storing heat in medium's mass.
</HTML>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Rectangle(
              extent={{-90,20},{90,-20}},
              lineColor={255,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{-150,100},{150,40}}, textString="%name"),
            Polygon(points={{-10,-90},{-10,-40},{0,-20},{10,-40},{10,-90},{-10,
                  -90}}, lineColor={255,0,0})}),
                                Diagram(coordinateSystem(preserveAspectRatio=false,
                       extent={{-100,-100},{100,100}}),
                                        graphics));
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
            Line(points={{0,80},{0,0}}, color={0,0,127})}),
                                Diagram(coordinateSystem(preserveAspectRatio=false,
                       extent={{-100,-100},{100,100}}),
                                        graphics));
    end Valve;
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
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </p>
  <p>
  Dr.Christian Kral<br>
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2009, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b>
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
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
"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{-56,10},{-56,-90},{-6,-40},{44,10},{44,-90},{-56,10}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-16,10},{4,10},{-6,-10},{-16,10}},
            lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid),
          Line(points={{-6,-10},{-6,-40},{-6,-38}}, color={0,0,127})}));
  end Components;

  package Media "Medium properties"
    extends Modelica.Icons.Library2;

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
  annotation (Documentation(info="<HTML>
This package contains definitions of medium properties.<br>
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
  Dr.Christian Kral<br>
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2009, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b>
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.11 2005/02/18 Anton Haumer<br>
       corrected usage of cv and cp</li>
  </ul>
</HTML>
"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            extent={{-80,8},{60,-88}},
            lineColor={0,0,127},
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-10,8},{-10,-88},{-10,-88}}, color={0,0,127}),
          Line(points={{-80,-24},{60,-24}}, color={0,0,127}),
          Line(points={{-80,-56},{60,-56}}, color={0,0,127})}));
  end Media;

  package Sources "Ideal fluid sources, e.g., ambient, volume flow"
    extends Modelica.Icons.Library2;

    model Ambient "Ambient with constant properties"

      extends Interfaces.Partials.Ambient;
      parameter Boolean usePressureInput=false
        "enable / disable pressure input"
        annotation(Evaluate=true);
      parameter Modelica.SIunits.Pressure constantAmbientPressure(start=0)
        "Ambient pressure"
        annotation(Dialog(enable=not usePressureInput));
      parameter Boolean useTemperatureInput=false
        "enable / disable temperature input"
        annotation(Evaluate=true);
      parameter Modelica.SIunits.Temperature constantAmbientTemperature(start=293.15, displayUnit="degC")
        "Ambient temperature"
        annotation(Dialog(enable=not useTemperatureInput));
      Modelica.Blocks.Interfaces.RealInput ambientPressure if usePressureInput
        annotation (Placement(transformation(extent={{110,60},{90,80}},
              rotation=0)));
      Modelica.Blocks.Interfaces.RealInput ambientTemperature if useTemperatureInput
        annotation (Placement(transformation(extent={{110,-60},{90,-80}},
              rotation=0)));
    protected
      Modelica.Blocks.Sources.Constant constPressure(final k=
            constantAmbientPressure) if not usePressureInput
        annotation (Placement(transformation(extent={{100,40},{80,60}})));
      Modelica.Blocks.Interfaces.RealInput pAmbient
        annotation (Placement(transformation(extent={{62,58},{58,62}})));
      Modelica.Blocks.Sources.Constant constTemperature(final k=
            constantAmbientTemperature) if not useTemperatureInput
        annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
      Modelica.Blocks.Interfaces.RealInput TAmbient
        annotation (Placement(transformation(extent={{62,-62},{58,-58}})));
    equation
      flowPort.p = pAmbient;
      T = TAmbient;
      connect(ambientPressure, pAmbient) annotation (Line(
          points={{100,70},{60,70},{60,60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(ambientTemperature, TAmbient) annotation (Line(
          points={{100,-70},{60,-70},{60,-60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(constPressure.y, pAmbient) annotation (Line(
          points={{79,50},{60,50},{60,60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(constTemperature.y, TAmbient) annotation (Line(
          points={{79,-50},{60,-50},{60,-60}},
          color={0,0,127},
          smooth=Smooth.None));
    annotation (Documentation(info="<HTML>
(Infinite) ambient with constant pressure and temperature.<br>
Thermodynamic equations are defined by Partials.Ambient.
</HTML>"),     Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
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
        annotation(__Dymola_choicesAllMatching=true);
      parameter Modelica.SIunits.Pressure p(start=0) "Pressure ground";
      Interfaces.FlowPort_a flowPort(final medium=medium)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));
    equation
      // defining pressure
      flowPort.p = p;
      // no energy exchange; no mass flow by default
      flowPort.H_flow = 0;
    annotation (Documentation(info="<HTML>
AbsolutePressure to define pressure level of a closed cooling cycle.
Coolant's mass flow, temperature and enthalpy flow are not affected.<br>
</HTML>"),     Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),
                       graphics),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Text(
              extent={{-150,150},{150,90}},
              lineColor={0,0,255},
              textString="%name"), Ellipse(
              extent={{-90,90},{90,-90}},
              lineColor={255,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                  Icon(Ellipse(extent=[-90,90; 90,-90], style(
              color=1,
              rgbcolor={255,0,0},
              fillColor=7,
              rgbfillColor={255,255,255}))));
    end AbsolutePressure;

    model VolumeFlow "Enforces constant volume flow"

      extends Interfaces.Partials.TwoPort(final tapT=1);
      parameter Boolean useVolumeFlowInput=false
        "enable / disable volume flow input"
        annotation(Evaluate=true);
      parameter Modelica.SIunits.VolumeFlowRate constantVolumeFlow(start=1)
        "Volume flow rate"
        annotation(Dialog(enable=not useVolumeFlowInput));
      Modelica.Blocks.Interfaces.RealInput volumeFlow if useVolumeFlowInput
        annotation (Placement(transformation(
            origin={0,100},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    protected
      Modelica.Blocks.Sources.Constant constVolumeFlow(final k=constantVolumeFlow) if
           not useVolumeFlowInput
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={30,90})));
      Modelica.Blocks.Interfaces.RealInput internalVolumeFlow annotation (Placement(
            transformation(
            extent={{-2,-2},{2,2}},
            rotation=270,
            origin={0,60})));
    equation
      Q_flow = 0;
      V_flow = internalVolumeFlow;
      connect(volumeFlow, internalVolumeFlow) annotation (Line(
          points={{0,100},{0,60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(constVolumeFlow.y, internalVolumeFlow) annotation (Line(
          points={{30,79},{30,60},{0,60}},
          color={0,0,127},
          smooth=Smooth.None));
    annotation (Documentation(info="<HTML>
Fan resp. pump with constant volume flow rate. Pressure increase is the response of the whole system.
Coolant's temperature and enthalpy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
Thermodynamic equations are defined by Partials.TwoPort.
</HTML>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
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
              textString="V")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                        graphics));
    end VolumeFlow;

    model PressureIncrease "Enforces constant pressure increase"

      extends Interfaces.Partials.TwoPort(final tapT=1);
      parameter Boolean usePressureIncreaseInput=false
        "enable / disable pressure increase input"
        annotation(Evaluate=true);
      parameter Modelica.SIunits.Pressure constantPressureIncrease(start=1)
        "Pressure increase"
        annotation(Dialog(enable=not usePressureIncreaseInput));
      Modelica.Blocks.Interfaces.RealInput pressureIncrease if usePressureIncreaseInput
        annotation (Placement(transformation(
            origin={0,100},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    protected
      Modelica.Blocks.Sources.Constant constPressureIncrease(final k=
            constantPressureIncrease) if not usePressureIncreaseInput
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={30,90})));
      Modelica.Blocks.Interfaces.RealInput internalPressureIncrease
        annotation (Placement(
            transformation(
            extent={{-2,-2},{2,2}},
            rotation=270,
            origin={0,60})));
    equation
      Q_flow = 0;
      dp = -internalPressureIncrease;
      connect(pressureIncrease, internalPressureIncrease)
          annotation (Line(
          points={{0,100},{0,60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(constPressureIncrease.y, internalPressureIncrease)
          annotation (Line(
          points={{30,79},{30,60},{0,60}},
          color={0,0,127},
          smooth=Smooth.None));
    annotation (Documentation(info="<HTML>
Fan resp. pump with constant pressure increase. Mass resp. volume flow is the response of the whole system.
Coolant's temperature and enthalpy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
Thermodynamic equations are defined by Partials.TwoPort.
</HTML>"),
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
              textString="dp")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                        graphics));
    end PressureIncrease;

    model IdealPump "Model of an ideal pump"

      extends Interfaces.Partials.TwoPort(final tapT=1);
      parameter Modelica.SIunits.AngularVelocity wNominal(start=1, displayUnit="1/min")
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
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
              rotation=0)));
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
</HTML>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
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
              fillColor={0,0,255})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics));
    end IdealPump;
  annotation (Documentation(info="<HTML>
This package contains different types of sources:
<ul>
<li>Ambient with constant or prescribed pressure and temperature</li>
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
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </p>
  <p>
  Dr.Christian Kral<br>
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2009, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b>
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.20 Beta 2005/02/18 Anton Haumer<br>
       <i>new model: IdealPump</i></li>
  </ul>
</HTML>
"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Ellipse(extent={{-60,10},{40,-90}}, lineColor={
                255,0,0}), Polygon(points={{-40,0},{-40,-80},{38,-50},{38,-30},
                {-40,0}}, lineColor={0,0,255})}));
  end Sources;

  package Sensors "Ideal sensors to measure port properties"
    extends Modelica.Icons.Library2;

    model PressureSensor "Absolute pressure sensor"

      extends Interfaces.Partials.AbsoluteSensor;
    equation
      y = flowPort.p;
    annotation (Documentation(info="<HTML>
pSensor measures the absolute pressure.<br>
Thermodynamic equations are defined by Partials.AbsoluteSensor.
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),
                   graphics),
                 Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-22,-20},{20,-60}},
              lineColor={0,0,255},
              textString="p")}),
                          Diagram);
    end PressureSensor;

    model TemperatureSensor "Absolute temperature sensor"

      extends Interfaces.Partials.AbsoluteSensor;
    equation
      medium.cp*y = flowPort.h;
    annotation (Documentation(info="<HTML>
TSensor measures the absolute temperature (Kelvin).<br>
Thermodynamic equations are defined by Partials.AbsoluteSensor.
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),
                   graphics),
                 Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-22,-20},{20,-60}},
              lineColor={0,0,255},
              textString="T")}));
    end TemperatureSensor;

    model RelPressureSensor "Pressure difference sensor"

      extends Interfaces.Partials.RelativeSensor;
    equation
      y = flowPort_a.p - flowPort_b.p;
    annotation (Documentation(info="<HTML>
dpSensor measures the pressure drop between flowPort_a and flowPort_b.<br>
Thermodynamic equations are defined by Partials.RelativeSensor.
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),
                   graphics),
                 Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-22,-20},{20,-60}},
              lineColor={0,0,255},
              textString="dp")}));
    end RelPressureSensor;

    model RelTemperatureSensor "Temperature difference sensor"

      extends Interfaces.Partials.RelativeSensor;
    equation
      medium.cp*y = flowPort_a.h - flowPort_b.h;
    annotation (Documentation(info="<HTML>
dTSensor measures the temperature difference between flowPort_a and flowPort_b.<br>
Thermodynamic equations are defined by Partials.RelativeSensor.<br>
<b>Note:</b> Connected flowPorts have the same temperature (mixing temperature)!<br>
Since mixing my occur, the outlet temperature of a component may be different from the connector's temperature.<br>
Outlet temperature is defined by variable T of the corresponding component.
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),
                   graphics),
                 Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-22,-20},{20,-60}},
              lineColor={0,0,255},
              textString="dT")}));
    end RelTemperatureSensor;

    model MassFlowSensor "Mass flow sensor"

      extends Interfaces.Partials.FlowSensor;
    equation
      y = V_flow*medium.rho;
    annotation (Documentation(info="<HTML>
m_flowSensor measures the mass flow rate.<br>
Thermodynamic equations are defined by Partials.FlowSensor.
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),
                   graphics),
                 Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-22,-20},{20,-60}},
              lineColor={0,0,255},
              textString="m")}));
    end MassFlowSensor;

    model VolumeFlowSensor "Volume flow sensor"

      extends Interfaces.Partials.FlowSensor;
    equation
      y = V_flow;
    annotation (Documentation(info="<HTML>
V_flowSensor measures the volume flow rate.<br>
Thermodynamic equations are defined by Partials.FlowSensor.
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),
                   graphics),
                 Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-22,-20},{20,-60}},
              lineColor={0,0,255},
              textString="V")}));
    end VolumeFlowSensor;

    model EnthalpyFlowSensor "Enthapy flow sensor"

      extends Interfaces.Partials.FlowSensor;
    equation
      y = flowPort_a.H_flow;
    annotation (Documentation(info="<HTML>
H_flowSensor measures the enthalpy flow rate.<br>
Thermodynamic equations are defined by Partials.FlowSensor.
</HTML>"),     Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),
                       graphics),
                 Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-22,-20},{20,-60}},
              lineColor={0,0,255},
              textString="H")}));
    end EnthalpyFlowSensor;
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
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </p>
  <p>
  Dr.Christian Kral<br>
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2009, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b>
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
</p>
</HTML>", revisions="<HTML>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  </ul>
</HTML>
"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Ellipse(
            extent={{-60,10},{40,-90}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-10,7},{-10,-10}}, color={0,0,0}),
          Line(points={{-50,-16},{-36,-25}}, color={0,0,0}),
          Line(points={{30,-15},{16,-25}}, color={0,0,0}),
          Line(points={{-35,0},{-25,-14}}, color={0,0,0}),
          Line(points={{15,0},{5,-14}}, color={0,0,0}),
          Ellipse(
            extent={{-15,-35},{-5,-45}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-10,-40},{-6,-26}}, color={0,0,0}),
          Polygon(
            points={{-12,-24},{-0.5,-27},{2,1.5},{-12,-24}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}));
  end Sensors;

  package Interfaces "Connectors and partial models"
    extends Modelica.Icons.Library2;

    connector FlowPort "conector flow port"

      parameter FluidHeatFlow.Media.Medium medium "Medium in the connector";
      Modelica.SIunits.Pressure p;
      flow Modelica.SIunits.MassFlowRate m_flow;
      Modelica.SIunits.SpecificEnthalpy h;
      flow Modelica.SIunits.EnthalpyFlowRate H_flow;
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
    end FlowPort;

    connector FlowPort_a "Filled flow port (used upstream)"

      extends FlowPort;
    annotation (Documentation(info="<HTML>
Same as FlowPort, but icon allows to differentiate direction of flow.
</HTML>"),
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
    annotation (Documentation(info="<HTML>
Same as FlowPort, but icon allows to differentiate direction of flow.
</HTML>"),
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
      extends Modelica.Icons.Library;

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
      annotation (Documentation(info="<HTML>
Definition of relationship between pressure drop and volume flow rate:<br>
-V_flowLaminar &lt; VolumeFlow &lt; +V_flowLaminar: laminar i.e. linear dependency of pressure drop on volume flow.<br>
-V_flowLaminar &gt; VolumeFlow or VolumeFlow &lt; +V_flowLaminar: turbulent i.e. quadratic dependency of pressure drop on volume flow.<br>
Linear and quadratic dependency are coupled smoothly at V_flowLaminar / dpLaminar.<br>
Quadratic dependency is defined by nominal volume flow and pressure drop (V_flowNominal / dpNominal).<br>
See also sketch at diagram layer.
</HTML>"),
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
                textString="dp ~ V_flow²")}));
      end SimpleFriction;

      partial model TwoPort "Partial model of two port"

        parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
          "Medium in the component"
          annotation(__Dymola_choicesAllMatching=true);
        parameter Modelica.SIunits.Mass m(start=1) "Mass of medium";
        parameter Modelica.SIunits.Temperature T0(start=293.15, displayUnit="degC")
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
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
                rotation=0)));
        Interfaces.FlowPort_b flowPort_b(final medium=medium)
          annotation (Placement(transformation(extent={{90,-10},{110,10}},
                rotation=0)));
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
      annotation (Documentation(info="<HTML>
Partial model with two flowPorts.<br>
Possible heat exchange with the ambient is defined by Q_flow; setting this = 0 means no energy exchange.<br>
Setting parameter m (mass of medium within pipe) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
Mixing rule is applied.<br>
Parameter 0 &lt; tapT &lt; 1 defines temperature of heatPort between medium's inlet and outlet temperature.
</HTML>"));
      end TwoPort;

      partial model Ambient "Partial model of ambient"

        parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
          "Ambient medium"
          annotation(__Dymola_choicesAllMatching=true);
        output Modelica.SIunits.Temperature T "Outlet temperature of medium";
        output Modelica.SIunits.Temperature T_port=flowPort.h/medium.cp
          "Temperature at flowPort_a";
      protected
        Modelica.SIunits.SpecificEnthalpy h = medium.cp*T;
      public
        Interfaces.FlowPort_a flowPort(final medium=medium)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
                rotation=0)));
      equation
        // massflow -> ambient: mixing rule
        // massflow <- ambient: energy flow defined by ambient's temperature
        flowPort.H_flow = semiLinear(flowPort.m_flow,flowPort.h,h);
      annotation (Documentation(info="<HTML>
<p>
Partial model of (Infinite) ambient, defines pressure and temperature.
</p>
</HTML>"),   Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
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

        parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
          "Sensor's medium"
          annotation(__Dymola_choicesAllMatching=true);
        Interfaces.FlowPort_a flowPort(final medium=medium)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
                rotation=0)));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{100,-10},{120,10}},
                rotation=0)));
      equation
        // no mass exchange
        flowPort.m_flow = 0;
        // no energy exchange
        flowPort.H_flow = 0;
      annotation (Documentation(info="<HTML>
Partial model for an absolute sensor (pressure/temperature).<br>
Pressure, mass flow, temperature and enthalpy flow of medium are not affected.
</HTML>"),          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Ellipse(
                extent={{-70,70},{70,-70}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{0,70},{0,40}}, color={0,0,0}),
              Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
              Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),
              Line(points={{37.6,13.7},{65.8,23.9}}, color={0,0,0}),
              Line(points={{-37.6,13.7},{-65.8,23.9}}, color={0,0,0}),
              Line(points={{0,0},{9.02,28.6}}, color={0,0,0}),
              Polygon(
                points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-5,5},{5,-5}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Line(points={{-70,0},{-90,0}}, color={0,0,0}),
              Line(points={{70,0},{100,0}}),
              Text(
                extent={{-150,130},{150,70}},
                lineColor={0,0,255},
                textString="%name")}),
                                Diagram(coordinateSystem(preserveAspectRatio=true,
                         extent={{-100,-100},{100,100}}),
                                        graphics));
      end AbsoluteSensor;

      partial model RelativeSensor "Partial model of relative sensor"

        parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium()
          "Sensor's medium"
          annotation(__Dymola_choicesAllMatching=true);
        Interfaces.FlowPort_a flowPort_a(final medium=medium)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
                rotation=0)));
        Interfaces.FlowPort_b flowPort_b(final medium=medium)
          annotation (Placement(transformation(extent={{90,-10},{110,10}},
                rotation=0)));
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
      annotation (Documentation(info="<HTML>
Partial model for a relative sensor (pressure drop/temperature difference).<br>
Pressure, mass flow, temperature and enthalpy flow of medium are not affected.
</HTML>"),          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Ellipse(
                extent={{-70,70},{70,-70}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{0,70},{0,40}}, color={0,0,0}),
              Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
              Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),
              Line(points={{37.6,13.7},{65.8,23.9}}, color={0,0,0}),
              Line(points={{-37.6,13.7},{-65.8,23.9}}, color={0,0,0}),
              Line(points={{0,0},{9.02,28.6}}, color={0,0,0}),
              Polygon(
                points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-5,5},{5,-5}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Line(points={{-70,0},{-90,0}}, color={0,0,0}),
              Line(points={{70,0},{90,0}}, color={0,0,0}),
              Line(points={{0,-100},{0,-70}}),
              Text(
                extent={{-150,130},{150,70}},
                lineColor={0,0,255},
                textString="%name")}),
                                Diagram(coordinateSystem(preserveAspectRatio=true,
                         extent={{-100,-100},{100,100}}),
                                        graphics));
      end RelativeSensor;

      partial model FlowSensor "Partial model of flow sensor"

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
      annotation (Documentation(info="<HTML>
Partial model for a flow sensor (mass flow/heat flow).<br>
Pressure, mass flow, temperature and enthalpy flow of medium are not affected, but mixing rule is applied.
</HTML>"),          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Ellipse(
                extent={{-70,70},{70,-70}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{0,70},{0,40}}, color={0,0,0}),
              Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
              Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),
              Line(points={{37.6,13.7},{65.8,23.9}}, color={0,0,0}),
              Line(points={{-37.6,13.7},{-65.8,23.9}}, color={0,0,0}),
              Line(points={{0,0},{9.02,28.6}}, color={0,0,0}),
              Polygon(
                points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-5,5},{5,-5}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Line(points={{-70,0},{-90,0}}, color={0,0,0}),
              Line(points={{70,0},{90,0}}, color={0,0,0}),
              Line(points={{0,-100},{0,-70}}),
              Text(
                extent={{-150,130},{150,70}},
                lineColor={0,0,255},
                textString="%name")}),
                                Diagram(coordinateSystem(preserveAspectRatio=false,
                         extent={{-100,-100},{100,100}}),
                                        graphics));
      end FlowSensor;
    annotation (Documentation(info="<HTML>
This package contains partial models, defining in a very compact way the basic thermodynamic equations used by the different components.<br>
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
  Dr.Christian Kral<br>
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2009, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b>
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
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
    end Partials;
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
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </p>
  <p>
  Dr.Christian Kral<br>
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2009, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b>
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
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
"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Rectangle(extent={{-60,10},{40,-90}}, lineColor
              ={255,0,0}), Ellipse(
            extent={{-58,8},{38,-88}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid)}));
  end Interfaces;
  annotation (
    Documentation(info="<HTML>
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
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </p>
  <p>
  Dr.Christian Kral<br>
  &Ouml;sterreichisches Forschungs- und Pr&uuml;fzentrum Arsenal Ges.m.b.H.<br>
  <a href=\"http://www.arsenal.ac.at/\">arsenal research</a><br>
  Giefinggasse 2<br>
  A-1210 Vienna, Austria
  </p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2009, Modelica Association, Anton Haumer and arsenal research.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b>
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
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
  <li> v1.6.4 2007/08/24 Anton Haumer<br>
       removed redeclare type SignalType</li>
  <li> v1.6.5 2007/08/26 Anton Haumer<br>
       fixed unit bug in SimpleFriction</li>
  <li> v1.6.6 2007/11/13 Anton Haumer<br>
       replaced all nonSIunits<br>
       some renaming to be more concise</li>
  </ul>
</HTML>
"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Polygon(
          points={{-80,10},{-60,-10},{-80,-30},{-20,-30},{0,-10},{-20,10},{-80,
              10}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,-90},{-20,-70},{0,-90},{0,-50},{-20,-30},{-40,-50},{-40,
              -90}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,10},{0,-10},{-20,-30},{40,-30},{60,-10},{40,10},{-20,10}},

          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid)}));
end FluidHeatFlow;
