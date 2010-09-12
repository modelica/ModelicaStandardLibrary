within Modelica.Fluid.Examples;
package TraceSubstances "Library demonstrating the usage of trace substances"
  extends Modelica.Icons.ExamplesPackage;
  model RoomCO2 "Demonstrates a room volume with CO2 accumulation"
    extends Modelica.Icons.Example;
    package Medium=Modelica.Media.Air.MoistAir(extraPropertiesNames={"CO2"},
                                               C_nominal={1.519E-3});
    Modelica.Blocks.Sources.Constant C(k=0.3*1.519E-3)
      "substance concentration, raising to 1000 PPM CO2"
      annotation (Placement(transformation(extent={{-94,-28},{-74,-8}})));
    Sources.FixedBoundary boundary4(nPorts=1,redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{80,-20},{60,0}})));
    Sensors.TraceSubstances traceVolume(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{0,20},{20,40}})));
    inner System system              annotation (Placement(transformation(extent={{52,36},
              {72,56}},          rotation=0)));
    Sources.MassFlowSource_T boundary1(
      use_C_in=true,
      m_flow=100/1.2/3600*5,
      redeclare package Medium = Medium,
      nPorts=2,
      X=Medium.X_default)
      annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
    Modelica.Fluid.Vessels.ClosedVolume volume(
      C_start={1.519E-3},
      V=100,
      redeclare package Medium = Medium,
      nPorts=2,
      X_start={0.015,0.085},
      massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      use_portsData=false)
                annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    Modelica.Fluid.Pipes.StaticPipe pipe(
      redeclare package Medium = Medium,
      length=1,
      diameter=0.15,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow (
           show_Res=true))
      annotation (Placement(transformation(extent={{20,-20},{40,0}})));
    Sensors.TraceSubstances traceSource(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  equation
    connect(C.y, boundary1.C_in[1]) annotation (Line(
        points={{-73,-18},{-60,-18}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(pipe.port_b, boundary4.ports[1])         annotation (Line(
        points={{40,-10},{60,-10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(volume.ports[2], pipe.port_a)         annotation (Line(
        points={{-8,0},{-6,0},{-6,-10},{20,-10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(traceVolume.port, pipe.port_a)                  annotation (Line(
        points={{10,20},{10,-10},{20,-10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(boundary1.ports[1], volume.ports[1]) annotation (Line(
        points={{-40,-8},{-12,-8},{-12,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(boundary1.ports[2], traceSource.port)          annotation (Line(
        points={{-40,-12},{-30,-12},{-30,20}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics),
      experiment(StopTime=3600),
      Documentation(info="<html>

<p>
This example consists of a volume with a carbon dioxide concentration that corresponds to
1.519E-3 kg/kg, which is equal to 1000 PPM.
There is a fresh air stream with a carbon dioxide concentration of about 300 PPM.
The fresh air stream is such that the air exchange rate is about 5 air changes per hour.
After 1 hour of ventilation, the volume's carbon dioxide concentration is close to the
concentration of the fresh air.
</p>
<p>
The nominal value for the trace substance is set to <code>C_nominal={1.519E-3}</code>.
This scales the residual equations that are used by the solver to the right order
of magnitude.
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/RoomCO2.png\" border=\"1\">
</html>"),
      __Dymola_Commands(file(ensureSimulated=true)=
          "modelica://Modelica/Resources/Scripts/Dymola/Fluid/RoomCO2/plotConcentrations.mos"
          "plot concentrations"));
  end RoomCO2;

  model RoomCO2WithControls "Demonstrates a room volume with CO2 controls"
    extends Modelica.Icons.Example;
    package Medium=Modelica.Media.Air.MoistAir(extraPropertiesNames={"CO2"},
                                               C_nominal={1.519E-3});
    Modelica.Blocks.Sources.Constant CAtm(k=0.3*1.519E-3)
      "Atmospheric trace substance concentration, corresponding to 300 PPM CO2"
      annotation (Placement(transformation(extent={{-100,-46},{-80,-26}})));
    Sources.FixedBoundary boundary4(nPorts=1,redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{92,-40},{72,-20}})));
    Sensors.TraceSubstances traceVolume(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{20,0},{40,20}})));
    inner System system              annotation (Placement(transformation(extent={{70,70},
              {90,90}},          rotation=0)));
    Sources.MassFlowSource_T freshAir(
      use_C_in=true,
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      nPorts=2)
      annotation (Placement(transformation(extent={{-70,-38},{-50,-18}})));
    Modelica.Fluid.Vessels.ClosedVolume volume(
      C_start={1.519E-3},
      V=100,
      redeclare package Medium = Medium,
      massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      use_portsData=false,
      nPorts=4) annotation (Placement(transformation(extent={{0,-20},{20,0}})));
    Pipes.DynamicPipe ductOut(
      redeclare package Medium = Medium,
      length=1,
      diameter=0.15,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow (
            show_Res=true)) "Outlet duct"
      annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
    Sensors.TraceSubstances traceDuctIn(redeclare package Medium = Medium)
      "Trace substance at duct inlet"
      annotation (Placement(transformation(extent={{-54,0},{-34,20}})));
    Sources.MassFlowSource_T peopleSource(
      m_flow=100/1.2/3600*5,
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      use_C_in=false,
      C={100},
      nPorts=1) "CO2 emitted by room occupants."
      annotation (Placement(transformation(extent={{-38,-98},{-18,-78}})));
    Modelica.Blocks.Sources.CombiTimeTable NumberOfPeople(table=[0,0; 9*3600,0;
          9*3600,10; 11*3600,10; 11*3600,2; 13*3600,2; 13*3600,15; 15*3600,15;
          15*3600,5; 18*3600,5; 18*3600,0; 24*3600,0])
      "Time table for number of people in the room"
      annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
    Modelica.Blocks.Math.Gain gain(k=8.18E-6/100)
      "CO2 mass flow rate, released per 100 person (there is another 100 factor in peopleSource)"
      annotation (Placement(transformation(extent={{-68,-90},{-48,-70}})));
    Modelica.Blocks.Math.Gain gain1(k=-100*1.2/3600*5)
      "Nominal fresh air flow rate (for u=1)"
      annotation (Placement(transformation(extent={{0,40},{20,60}})));
    Modelica.Blocks.Math.Gain gainSensor(k=1/1.519E-3)
      "Gain to normalize CO2 measurement signal. y=1 corresponds to 1000 PPM"
      annotation (Placement(transformation(extent={{60,0},{80,20}})));
    Modelica.Blocks.Sources.Constant CO2Set(k=1) "Normalized CO2 set point"
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Modelica.Blocks.Continuous.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=0,
      yMin=-1,
      Ti=10,
      k=10)   annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    Pipes.DynamicPipe ductIn(
      redeclare package Medium = Medium,
      length=1,
      diameter=0.15,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow (
            show_Res=true)) "Inlet duct"
      annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
    Sensors.TraceSubstances traceDuctOut(redeclare package Medium = Medium)
      "Trace substance at duct outlet"
      annotation (Placement(transformation(extent={{-14,0},{6,20}})));
  equation
    connect(CAtm.y, freshAir.C_in[1])
                                    annotation (Line(
        points={{-79,-36},{-70,-36}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(ductOut.port_b, boundary4.ports[1])      annotation (Line(
        points={{60,-30},{72,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(NumberOfPeople.y[1], gain.u) annotation (Line(
        points={{-79,-80},{-70,-80}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain.y, peopleSource.m_flow_in) annotation (Line(
        points={{-47,-80},{-38,-80}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(traceVolume.C, gainSensor.u)     annotation (Line(
        points={{41,10},{58,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(CO2Set.y, PID.u_s) annotation (Line(
        points={{-59,50},{-42,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gainSensor.y, PID.u_m)
                              annotation (Line(
        points={{81,10},{90,10},{90,30},{-30,30},{-30,38}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(PID.y, gain1.u) annotation (Line(
        points={{-19,50},{-2,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain1.y, freshAir.m_flow_in)  annotation (Line(
        points={{21,50},{30,50},{30,70},{-88,70},{-88,-20},{-70,-20}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(ductIn.port_b, volume.ports[1]) annotation (Line(
        points={{-10,-30},{7,-30},{7,-20}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(peopleSource.ports[1], volume.ports[2]) annotation (Line(
        points={{-18,-88},{9,-88},{9,-20}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(volume.ports[3], ductOut.port_a) annotation (Line(
        points={{11,-20},{12,-20},{12,-30},{40,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(volume.ports[4], traceVolume.port) annotation (Line(
        points={{13,-20},{12,-20},{12,-26},{30,-26},{30,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(freshAir.ports[1], traceDuctIn.port) annotation (Line(
        points={{-50,-26},{-44,-26},{-44,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(ductIn.port_a, freshAir.ports[2]) annotation (Line(
        points={{-30,-30},{-50,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(traceDuctOut.port, ductIn.port_b) annotation (Line(
        points={{-4,0},{-4,-30},{-10,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics),
      experiment(StopTime=86400, Tolerance=1e-006),
      __Dymola_Commands(file(ensureSimulated=true)="modelica://Modelica/Resources/Scripts/Dymola/Fluid/RoomCO2WithControls/plotStatesWithControl.mos"
          "plot states and controls"),
      Documentation(info="<html>
<p>
This example illustrates a room volume with a CO2 source and a fresh air supply with feedback
control.
The CO2 emission rate is proportional to the room occupancy, which is defined by a schedule.
The fresh air flow rate is controlled such that the room CO2
concentration does not exceed <code>1000 PPM (=1.519E-3 kg/kg)</code>.
The fresh air has a CO2 concentration of <code>300 PPM</code> which corresponds to a typical
CO2 concentration in the outside air.
</p>

<p>
The CO2 emission from the occupants is implemented as a mass flow source.
Depending on the activity and size, a person emits about <code>8.18E-6 kg/s</code> CO2. In the model,
this value is multiplied by the number of occupants.
Since the mass flow rate associate with the CO2 source model contributes to the volume's energy balance,
this mass flow rate should be kept small. Thus, in the source model, we set the
CO2 concentration to <code>C={100} kg/kg</code>, and scaled the mass flow rate using
</p>

<pre>
  m_flow = 1/100 * nPeo * 8.18E-6 kg/(s*person)
</pre>

<p>
where <code>nPeo</code> is the number of people in the room.
This results in a mass flow rate that is about 5 orders of magnitudes smaller than the supply air flow rate,
and hence its contribution to the volume's energy balance is negligible.
</p>
<p>
The nominal value for the trace substance is set to <code>C_nominal={1.519E-3}</code>.
This scales the residual equations that are used by the solver to the right order
of magnitude.
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/RoomCO2WithControls.png\" border=\"1\">
</html>"));
  end RoomCO2WithControls;
end TraceSubstances;
