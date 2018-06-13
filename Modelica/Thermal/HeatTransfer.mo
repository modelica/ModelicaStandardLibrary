within Modelica.Thermal;
package HeatTransfer
  "Library of 1-dimensional heat transfer with lumped elements"
  extends Modelica.Icons.Package;
  package Examples
    "Example models to demonstrate the usage of package Modelica.Thermal.HeatTransfer"
    extends Modelica.Icons.ExamplesPackage;

    model TwoMasses "Simple conduction demo"
      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Temperature T_final_K(fixed=false)
        "Projected final temperature";
      HeatTransfer.Components.HeatCapacitor mass1(
                                       C=15, T(start=373.15, fixed=true))
        annotation (Placement(transformation(extent={{-100,20},{-40,80}})));
      HeatTransfer.Components.HeatCapacitor mass2(
                                       C=15, T(start=273.15, fixed=true))
                                                                    annotation (Placement(
            transformation(extent={{40,20},{100,80}})));
      HeatTransfer.Components.ThermalConductor conduction(
                                               G=10) annotation (Placement(
            transformation(extent={{-30,-20},{30,40}})));
      HeatTransfer.Celsius.TemperatureSensor Tsensor1 annotation (Placement(
            transformation(extent={{-60,-80},{-20,-40}})));
      HeatTransfer.Celsius.TemperatureSensor Tsensor2 annotation (Placement(
            transformation(extent={{60,-80},{20,-40}})));
    equation
      connect(mass1.port, conduction.port_a) annotation (Line(points={{-70,20},
              {-70,10},{-30,10}}, color={191,0,0}));
      connect(conduction.port_b, mass2.port) annotation (Line(points={{30,10},{
              70,10},{70,20}}, color={191,0,0}));
      connect(mass1.port, Tsensor1.port) annotation (Line(points={{-70,20},{-70,
              -60},{-60,-60}}, color={191,0,0}));
      connect(mass2.port, Tsensor2.port) annotation (Line(points={{70,20},{70,
              -60},{60,-60}}, color={191,0,0}));
    initial equation
      T_final_K = (mass1.T*mass1.C + mass2.T*mass2.C)/(mass1.C + mass2.C);
      annotation (Documentation(info="<html>
<p>
This example demonstrates the thermal response of two masses connected by
a conducting element. The two masses have the same heat capacity but different
initial temperatures (T1=100 [degC], T2= 0 [degC]). The mass with the higher
temperature will cool off while the mass with the lower temperature heats up.
They will each asymptotically approach the calculated temperature <strong>T_final_K</strong>
(<strong>T_final_degC</strong>) that results from dividing the total initial energy in the system by the sum
of the heat capacities of each element.
</p>
<p>
Simulate for 5 s and plot the variables<br>
mass1.T, mass2.T, T_final_K or<br>
Tsensor1.T, Tsensor2.T, T_final_degC
</p>
</html>"),
        experiment(StopTime=1.0, Interval=0.001));
    end TwoMasses;

    model ControlledTemperature "Control temperature of a resistor"
      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC") = 293.15
        "Ambient Temperature";
      parameter Modelica.SIunits.TemperatureDifference TDif = 2
        "Error in Temperature";
      output Modelica.SIunits.Temperature TRes(displayUnit="degC") = heatingResistor.T_heatPort
        "Resulting Temperature";
      Modelica.Electrical.Analog.Basic.Ground ground
                                  annotation (Placement(transformation(extent={
                {-100,-100},{-80,-80}})));
      Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=10)
                                                            annotation (Placement(
            transformation(
            origin={-90,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      HeatTransfer.Components.HeatCapacitor heatCapacitor(
                                               C=1, T(start=TAmb, fixed=true))
        annotation (Placement(transformation(extent={{0,-60},{20,-80}})));
      Modelica.Electrical.Analog.Basic.HeatingResistor heatingResistor(
        R_ref=10,
        T_ref=293.15,
        alpha=1/255) annotation (Placement(transformation(
            origin={-30,-50},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      HeatTransfer.Sources.FixedTemperature fixedTemperature(
                                                     T=TAmb)
        annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
      HeatTransfer.Celsius.TemperatureSensor temperatureSensor annotation (Placement(
            transformation(
            origin={10,-30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      HeatTransfer.Components.ThermalConductor thermalConductor(
                                                     G=0.1) annotation (Placement(
            transformation(extent={{40,-60},{60,-40}})));
      Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch idealSwitch
            annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
      Modelica.Blocks.Sources.Ramp ramp(
        height=25,
        duration=6,
        offset=25,
        startTime=2) annotation (Placement(transformation(extent={{40,0},{20,20}})));
      Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=TDif)
        annotation (Placement(transformation(extent={{0,-20},{-20,0}})));
      Modelica.Blocks.Logical.Not logicalNot
                                       annotation (Placement(transformation(
              extent={{-30,-20},{-50,0}})));
    equation
      connect(constantVoltage.n, heatingResistor.n) annotation (Line(points={{-90,-60},
              {-30,-60}}, color={0,0,255}));
      connect(constantVoltage.n, ground.p) annotation (Line(points={{-90,-60},
              {-90,-80}}, color={0,0,255}));
      connect(heatingResistor.heatPort, thermalConductor.port_a) annotation (Line(
            points={{-20,-50},{40,-50}}, color={191,0,0}));
      connect(thermalConductor.port_b, fixedTemperature.port) annotation (Line(
            points={{60,-50},{80,-50}}, color={191,0,0}));
      connect(heatingResistor.heatPort, temperatureSensor.port) annotation (Line(
            points={{-20,-50},{10,-50},{10,-40}}, color={191,0,0}));
      connect(heatingResistor.heatPort, heatCapacitor.port) annotation (Line(
            points={{-20,-50},{10,-50},{10,-60}}, color={191,0,0}));
      connect(constantVoltage.p, idealSwitch.p) annotation (Line(points={{-90,
              -40},{-70,-40}}, color={0,0,255}));
      connect(idealSwitch.n, heatingResistor.p) annotation (Line(points={{-50,-40},
              {-30,-40}}, color={0,0,255}));
      connect(ramp.y, onOffController.reference) annotation (Line(points={{19,
              10},{10,10},{10,-4},{2,-4}}, color={0,0,127}));
      connect(temperatureSensor.T, onOffController.u) annotation (Line(points=
             {{10,-20},{10,-16},{2,-16}}, color={0,0,127}));
      connect(onOffController.y, logicalNot.u)
                                          annotation (Line(points={{-21,-10},{
              -28,-10}}, color={255,0,255}));
      connect(logicalNot.y, idealSwitch.control)
                                            annotation (Line(points={{-51,-10},
              {-60,-10},{-60,-33}}, color={255,0,255}));
      annotation (Documentation(info="<html>
<p>
A constant voltage of 10 V is applied to a
temperature dependent resistor of 10*(1+(T-20C)/(235+20C)) Ohms,
whose losses v**2/r are dissipated via a
thermal conductance of 0.1 W/K to ambient temperature 20 degree C.
The resistor is assumed to have a thermal capacity of 1 J/K,
having ambient temperature at the beginning of the experiment.
The temperature of this heating resistor is held by an OnOff-controller
at reference temperature within a given bandwidth +/- 1 K
by switching on and off the voltage source.
The reference temperature starts at 25 degree C
and rises between t = 2 and 8 seconds linear to 50 degree C.
An appropriate simulating time would be 10 seconds.
</p>
</html>"),        experiment(StopTime=10, Interval=0.001));
    end ControlledTemperature;

    model Motor "Second order thermal model of a motor"
      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Temperature TAmb(displayUnit="degC") = 293.15
        "Ambient temperature";

      Modelica.Blocks.Sources.CombiTimeTable lossTable(extrapolation=Modelica.
            Blocks.Types.Extrapolation.Periodic, smoothness=Modelica.Blocks.
            Types.Smoothness.ConstantSegments, table=[0,100,500; 360,1000,500;
            600,100,500]) annotation (Placement(transformation(
            origin={-40,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      HeatTransfer.Sources.PrescribedHeatFlow windingLosses(T_ref=368.15,
        alpha=3.03E-3) annotation (Placement(
            transformation(
            origin={-80,10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      HeatTransfer.Components.HeatCapacitor winding(C=2500, T(start=TAmb, fixed=true))
                  annotation (Placement(
            transformation(extent={{-90,-20},{-70,-40}})));
      HeatTransfer.Celsius.TemperatureSensor Twinding
                                                     annotation (Placement(
            transformation(
            origin={-60,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      HeatTransfer.Components.ThermalConductor winding2core(G=10)
                                            annotation (Placement(
            transformation(extent={{-50,-20},{-30,0}})));
      HeatTransfer.Sources.PrescribedHeatFlow coreLosses
                                             annotation (Placement(
            transformation(
            origin={0,10},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      HeatTransfer.Components.HeatCapacitor core(C=25000, T(start=TAmb, fixed=true)) annotation (Placement(
            transformation(extent={{-10,-20},{10,-40}})));
      HeatTransfer.Celsius.TemperatureSensor Tcore annotation (Placement(
            transformation(
            origin={-20,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.Constant convectionConstant(k=25)
        annotation (Placement(transformation(
            origin={40,30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      HeatTransfer.Components.Convection convection
                                         annotation (Placement(transformation(
              extent={{30,-20},{50,0}})));
      HeatTransfer.Sources.FixedTemperature environment(T=TAmb) annotation (Placement(
            transformation(
            origin={80,-10},
            extent={{-10,-10},{10,10}},
            rotation=180)));
    equation
      connect(windingLosses.port, winding.port) annotation (Line(points={{-80,0},
              {-80,-20}}, color={191,0,0}));
      connect(coreLosses.port, core.port) annotation (Line(points={{0,0},{0,
              -10},{0,-20}}, color={191,0,
              0}));
      connect(winding.port, winding2core.port_a)
                                       annotation (Line(points={{-80,-20},{-80,
              -10},{-50,-10}}, color={191,0,0}));
      connect(winding2core.port_b, core.port)
                                    annotation (Line(points={{-30,-10},{0,-10},
              {0,-20}}, color={191,0,0}));
      connect(winding.port, Twinding.port) annotation (Line(points={{-80,-20},
              {-80,-10},{-60,-10},{-60,-40}}, color={191,0,0}));
      connect(core.port, Tcore.port) annotation (Line(points={{0,-20},{0,-10},
              {-20,-10},{-20,-40}}, color={191,0,0}));
      connect(winding2core.port_b, convection.solid)
                                          annotation (Line(points={{-30,-10},{
              30,-10}}, color={191,0,0}));
      connect(convection.fluid, environment.port) annotation (Line(points={{50,-10},
              {60,-10},{70,-10}}, color={191,0,0}));
      connect(convectionConstant.y, convection.Gc)
        annotation (Line(points={{40,19},{40,0}}, color={0,0,127}));
      connect(lossTable.y[1], windingLosses.Q_flow) annotation (Line(points={{-40,59},
              {-40,40},{-80,40},{-80,20}}, color={0,0,127}));
      connect(lossTable.y[2], coreLosses.Q_flow) annotation (Line(points={{-40,59},
              {-40,40},{0,40},{0,20}}, color={0,0,
              127}));
      annotation (Documentation(info="<html>
<p>
This example contains a simple second order thermal model of a motor.
The periodic power losses are described by table \"lossTable\":
</p>
<table>
<tr><td>time</td><td>winding losses</td><td>core losses</td></tr>
<tr><td>   0</td><td>           100</td><td>        500</td></tr>
<tr><td> 360</td><td>           100</td><td>        500</td></tr>
<tr><td> 360</td><td>          1000</td><td>        500</td></tr>
<tr><td> 600</td><td>          1000</td><td>        500</td></tr>
</table>
<p>
Since constant speed is assumed, the core losses keep constant
whereas the winding losses are low for 6 minutes (no-load) and high for 4 minutes (over load).
</p>
<p>
The winding losses are corrected by (1 + alpha*(T - T_ref)) because the winding's resistance is temperature dependent whereas the core losses are kept constant (alpha = 0).
</p>
<p>
The power dissipation to the environment is approximated by heat flow through
a thermal conductance between winding and core,
partially storage of the heat in the winding's heat capacity
as well as the core's heat capacity and finally by forced convection to the environment.<br>
Since constant speed is assumed, the convective conductance keeps constant.<br>
Using Modelica.Thermal.FluidHeatFlow it would be possible to model the coolant air flow, too
(instead of simple dissipation to a constant ambient's temperature).
</p>
<p>
Simulate for 7200 s; plot Twinding.T and Tcore.T.
</p>
</html>"),
        experiment(StopTime=7200, Interval=0.01));
    end Motor;

    model GenerationOfFMUs
      "Example to demonstrate variants to generate FMUs (Functional Mock-up Units)"
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Sine sine1(freqHz=2, amplitude=1000)
        annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
      Modelica.Thermal.HeatTransfer.Examples.Utilities.DirectCapacity
        directCapacity(C=1.1)
        annotation (Placement(transformation(extent={{0,40},{20,60}})));
      Modelica.Thermal.HeatTransfer.Examples.Utilities.InverseCapacity
        inverseCapacity(C=2.2)
        annotation (Placement(transformation(extent={{40,40},{60,60}})));
      Modelica.Thermal.HeatTransfer.Examples.Utilities.Conduction conductor(G=
            10)
        annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor capacitor3a(C=1.1, T(fixed=true, start=293.15))
        annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlow3
        annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
      Modelica.Thermal.HeatTransfer.Components.GeneralHeatFlowToTemperatureAdaptor
        heatFlowToTemperature3a(use_pder=false)
        annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor capacitor3b(C=2.2, T(fixed=true, start=293.15))
        annotation (Placement(transformation(extent={{70,-70},{90,-50}})));
      Modelica.Thermal.HeatTransfer.Components.GeneralHeatFlowToTemperatureAdaptor
        heatFlowToTemperature3b(use_pder=false)
        annotation (Placement(transformation(extent={{70,-80},{50,-60}})));
    equation
      connect(sine1.y, directCapacity.Q_flowDrive)
        annotation (Line(points={{-79,50},{-2,50}}, color={0,0,127}));
      connect(directCapacity.T, inverseCapacity.T)
        annotation (Line(points={{21,58},{38,58}}, color={0,0,127}));
      connect(inverseCapacity.Q_flow, directCapacity.Q_flow)
        annotation (Line(points={{39,42},{22,42}}, color={0,0,127}));
      connect(heatFlowToTemperature3a.f, conductor.Q_flow1)
        annotation (Line(points={{3,-78},{19,-78}}, color={0,0,127}));
      connect(conductor.Q_flow2,heatFlowToTemperature3b. f)
        annotation (Line(points={{41,-78},{57,-78}}, color={0,0,127}));
      connect(heatFlowToTemperature3a.p, conductor.T1)
        annotation (Line(points={{3,-62},{18,-62}}, color={0,0,127}));
      connect(conductor.T2,heatFlowToTemperature3b. p)
        annotation (Line(points={{42,-62},{57,-62}}, color={0,0,127}));
      connect(sine1.y, heatFlow3.Q_flow) annotation (Line(points={{-79,50},{-70,50},
              {-70,-70},{-60,-70}}, color={0,0,127}));
      connect(heatFlow3.port, capacitor3a.port)
        annotation (Line(points={{-40,-70},{-20,-70}}, color={191,0,0}));
      connect(capacitor3a.port,heatFlowToTemperature3a. heatPort)
        annotation (Line(points={{-20,-70},{-2,-70}}, color={191,0,0}));
      connect(heatFlowToTemperature3b.heatPort, capacitor3b.port)
        annotation (Line(points={{62,-70},{80,-70}}, color={191,0,0}));
      connect(directCapacity.derT, inverseCapacity.derT) annotation (Line(points={{21,
              53},{28.5,53},{28.5,53},{38,53}}, color={0,0,127}));
      annotation (experiment(StopTime=1, Interval=0.001), Documentation(info="<html>
<p>
This example demonstrates how to generate an input/output block (e.g. in form of an
FMU - <a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>) from various HeatTransfer components.
The goal is to export such an input/output block from Modelica and import
it in another modeling environment. The essential issue is that before
exporting it must be known in which way the component is utilized in the
target environment. Depending on the target usage, different flange variables
need to be in the interface with either input or output causality.
Note, this example model can be used to test the FMU export/import of a Modelica tool.
Just export the components marked in the icons as \"toFMU\" as FMUs and import
them back. The models should then still work and give the same results as a
pure Modelica model.
</p>

<p>
<strong>Connecting two masses</strong><br>
The upper part (DirectCapacity, InverseCapacity)
demonstrates how to export two heat capacitors and connect them
together in a target system. This requires that one of the capacitors
(here: DirectCapacity)
is defined to have states and the temperature and
derivative of temperature are provided in the interface.
The other capacitor (here: InverseCapacity) requires heat flow according
to the provided input temperature and derivative of temperature.
</p>

<p>
<strong>Connecting a conduction element that needs only temperature</strong><br>
The lower part (Conductor) demonstrates how to export a conduction element
that needs only temperatures for its conduction law and connect this
conduction law in a target system between two capacitors.
</p>
</html>"));
    end GenerationOfFMUs;

    package Utilities "Utility classes used by the Example models"
      extends Modelica.Icons.UtilitiesPackage;

      model DirectCapacity
        "Input/output block of a direct heatCapacity model"
        extends Modelica.Blocks.Icons.Block;
        parameter Modelica.SIunits.HeatCapacity C(min=0)=1 "HeatCapacity";
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=C, T(
              fixed=true, start=293.15))
          annotation (Placement(transformation(extent={{-20,0},{0,20}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow forceSource
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
        Modelica.Blocks.Interfaces.RealInput Q_flowDrive(unit="W")
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Thermal.HeatTransfer.Components.GeneralHeatFlowToTemperatureAdaptor
          heatFlowToTemperature(use_pder=true)
          annotation (Placement(transformation(extent={{12,-10},{28,10}})));
        Modelica.Blocks.Interfaces.RealOutput T(unit="K", displayUnit="degC")
          "Heat capacity changes temperature T due to heat flow Q_flow"
          annotation (Placement(transformation(extent={{100,70},{120,90}})));
        Modelica.Blocks.Interfaces.RealOutput derT(unit="K/s")
          "Heat capacity changes temperature T due to heat flow Q_flow"
          annotation (Placement(transformation(extent={{100,20},{120,40}})));
        Modelica.Blocks.Interfaces.RealInput Q_flow(unit="W")
          "Heat flow to the heat capacity"
          annotation (Placement(transformation(extent={{140,-100},{100,-60}})));
      equation
        connect(heatFlowToTemperature.f, Q_flow) annotation (Line(points={{22.4,-8},{60,
                -8},{60,-80},{120,-80}}, color={0,0,127}));
        connect(heatFlowToTemperature.p, T) annotation (Line(points={{22.4,8},{60,8},{
                60,80},{110,80}}, color={0,0,127}));
        connect(heatFlowToTemperature.pder, derT) annotation (Line(points={{22.4,5},{80,
                5},{80,30},{110,30}}, color={0,0,127}));
        connect(heatCapacitor.port,heatFlowToTemperature. heatPort)
          annotation (Line(points={{-10,0},{18.4,0}}, color={191,0,0}));
        connect(Q_flowDrive, forceSource.Q_flow)
          annotation (Line(points={{-120,0},{-50,0}}, color={0,0,127}));
        connect(heatCapacitor.port, forceSource.port)
          annotation (Line(points={{-10,0},{-30,0}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Text(
                      extent={{-84,-58},{24,-90}},
                      lineColor={135,135,135},
                      textString="to FMU"),Text(
                      extent={{8,96},{92,66}},
                      horizontalAlignment=TextAlignment.Right,
                textString="T"),                               Text(
                      extent={{10,46},{94,16}},
                      horizontalAlignment=TextAlignment.Right,
                textString="dT"),     Text(
                      extent={{-150,-110},{150,-140}},
                textString="C=%C"),      Bitmap(extent={{-96,-42},{64,54}},
                  fileName="modelica://Modelica/Resources/Images/Thermal/HeatTransfer/DirectCapacity.png"),
                Text( extent={{10,-60},{94,-90}},
                      horizontalAlignment=TextAlignment.Right,
                textString="Q_flow")}));
      end DirectCapacity;

      model InverseCapacity
        "Input/output block of an inverse heatCapacity model"
        extends Modelica.Blocks.Icons.Block;
        parameter Modelica.SIunits.HeatCapacity C(min=0)=1 "HeatCapacity";
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor mass(C=C, T(fixed=true, start=293.15))
                         annotation (Placement(transformation(extent={{-10,0},{10,20}})));
        Modelica.Thermal.HeatTransfer.Components.GeneralTemperatureToHeatFlowAdaptor
          temperatureToHeatFlow
          annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
        Modelica.Blocks.Interfaces.RealInput T(unit="K", displayUnit="degC")
          "Temperature to drive the heatCapacity"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealInput derT(unit="K/s")
          "Temperature to drive the heatCapacity"
          annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
        Modelica.Blocks.Interfaces.RealOutput Q_flow(unit="W")
          "Heat flow needed to drive the heatPort according to T, derT"
          annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
      equation

        connect(temperatureToHeatFlow.f, Q_flow) annotation (Line(points={{-23,-8},{-60,
                -8},{-60,-80},{-110,-80}}, color={0,0,127}));
        connect(temperatureToHeatFlow.p, T) annotation (Line(points={{-23,8},{-60,8},{
                -60,80},{-120,80}}, color={0,0,127}));
        connect(temperatureToHeatFlow.pder, derT) annotation (Line(points={{-23,5},{-80,
                5},{-80,30},{-120,30}}, color={0,0,127}));
        connect(temperatureToHeatFlow.heatPort, mass.port)
          annotation (Line(points={{-18,0},{0,0}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Text(
                      extent={{0,-62},{96,-94}},
                      lineColor={135,135,135},
                      textString="to FMU"),Text(
                      extent={{-94,96},{-10,66}},
                      horizontalAlignment=TextAlignment.Left,
                textString="T"),        Text(
                      extent={{-94,46},{-10,16}},
                      horizontalAlignment=TextAlignment.Left,
                textString="dT"),     Text(
                      extent={{-150,-110},{150,-140}},
                textString="C=%C"),      Bitmap(extent={{-58,-42},{98,48}},
                  fileName="modelica://Modelica/Resources/Images/Thermal/HeatTransfer/InverseCapacity.png"),
                Text( extent={{-90,-64},{-6,-94}},
                      horizontalAlignment=TextAlignment.Left,
                textString="Q_flow")}));
      end InverseCapacity;

      model Conduction "Input/output block of a conduction model"
        extends Modelica.Blocks.Icons.Block;
        parameter Modelica.SIunits.ThermalConductance G=1 "Thermal conductance";
        Modelica.Thermal.HeatTransfer.Components.GeneralTemperatureToHeatFlowAdaptor
          temperatureToHeatFlow1(use_pder=false)
          annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
        Modelica.Blocks.Interfaces.RealInput T1(unit="K", displayUnit="degC")
          "Temperature of left heatPort of conduction element"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealOutput Q_flow1(unit="W")
          "Heat flow generated by the conduction element"
          annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=G)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Interfaces.RealInput T2(unit="K", displayUnit="degC")
          "Temperature of right heatPort of conduction element"
          annotation (Placement(transformation(extent={{140,60},{100,100}})));
        Modelica.Blocks.Interfaces.RealOutput Q_flow2(unit="W")
          "Heat flow generated by the conduction element"
          annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
        Modelica.Thermal.HeatTransfer.Components.GeneralTemperatureToHeatFlowAdaptor
          temperatureToHeatFlow2(use_pder=false)
          annotation (Placement(transformation(extent={{30,-10},{10,10}})));
      equation

        connect(Q_flow1,temperatureToHeatFlow1. f) annotation (Line(points={{-110,-80},
                {-60,-80},{-60,-8},{-23,-8}}, color={0,0,127}));
        connect(temperatureToHeatFlow2.f, Q_flow2) annotation (Line(points={{23,-8},{60,
                -8},{60,-80},{110,-80}}, color={0,0,127}));
        connect(temperatureToHeatFlow1.p, T1) annotation (Line(points={{-23,8},{-60,8},
                {-60,80},{-120,80}}, color={0,0,127}));
        connect(temperatureToHeatFlow2.p, T2) annotation (Line(points={{23,8},{60,8},{
                60,80},{120,80}}, color={0,0,127}));
        connect(temperatureToHeatFlow1.heatPort, thermalConductor.port_a)
          annotation (Line(points={{-18,0},{-10,0}}, color={191,0,0}));
        connect(thermalConductor.port_b,temperatureToHeatFlow2. heatPort)
          annotation (Line(points={{10,0},{18,0}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Text(
                      extent={{-48,-36},{48,-68}},
                      lineColor={135,135,135},
                      textString="to FMU"),Text(
                      extent={{-94,96},{-10,66}},
                      horizontalAlignment=TextAlignment.Left,
                textString="T1"),        Text(
                      extent={{-150,-114},{150,-144}},
                textString="G=%G"),      Bitmap(extent={{-88,-36},{92,56}},
                  fileName="modelica://Modelica/Resources/Images/Thermal/HeatTransfer/Conductor.png"),
                Text( extent={{12,96},{96,66}},
                      horizontalAlignment=TextAlignment.Right,
                textString="T2"),        Text(
                      extent={{16,-62},{100,-92}},
                      horizontalAlignment=TextAlignment.Right,
                textString="Q_flow2"),   Text(
                      extent={{-100,-64},{-16,-94}},
                      horizontalAlignment=TextAlignment.Left,
                textString="Q_flow1")}));
      end Conduction;

      annotation (Documentation(info="<html>
<p>Utility models and functions used in the Examples</p>
</html>"));
    end Utilities;
    annotation (Documentation(info="<html>

</html>"));
  end Examples;

  package Components "Lumped thermal components"
  extends Modelica.Icons.Package;

    model HeatCapacitor "Lumped thermal element storing heat"
      parameter Modelica.SIunits.HeatCapacity C
        "Heat capacity of element (= cp*m)";
      Modelica.SIunits.Temperature T(start=293.15, displayUnit="degC")
        "Temperature of element";
      Modelica.SIunits.TemperatureSlope der_T(start=0)
        "Time derivative of temperature (= der(T))";
      Interfaces.HeatPort_a port annotation (Placement(transformation(
            origin={0,-100},
            extent={{-10,-10},{10,10}},
            rotation=90)));
    equation
      T = port.T;
      der_T = der(T);
      C*der(T) = port.Q_flow;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,110},{150,70}},
              textString="%name",
              lineColor={0,0,255}),
            Polygon(
              points={{0,67},{-20,63},{-40,57},{-52,43},{-58,35},{-68,25},{-72,
                  13},{-76,-1},{-78,-15},{-76,-31},{-76,-43},{-76,-53},{-70,-65},
                  {-64,-73},{-48,-77},{-30,-83},{-18,-83},{-2,-85},{8,-89},{22,
                  -89},{32,-87},{42,-81},{54,-75},{56,-73},{66,-61},{68,-53},{
                  70,-51},{72,-35},{76,-21},{78,-13},{78,3},{74,15},{66,25},{54,
                  33},{44,41},{36,57},{26,65},{0,67}},
              lineColor={160,160,164},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-58,35},{-68,25},{-72,13},{-76,-1},{-78,-15},{-76,-31},{
                  -76,-43},{-76,-53},{-70,-65},{-64,-73},{-48,-77},{-30,-83},{-18,
                  -83},{-2,-85},{8,-89},{22,-89},{32,-87},{42,-81},{54,-75},{42,
                  -77},{40,-77},{30,-79},{20,-81},{18,-81},{10,-81},{2,-77},{-12,
                  -73},{-22,-73},{-30,-71},{-40,-65},{-50,-55},{-56,-43},{-58,-35},
                  {-58,-25},{-60,-13},{-60,-5},{-60,7},{-58,17},{-56,19},{-52,
                  27},{-48,35},{-44,45},{-40,57},{-58,35}},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-69,7},{71,-24}},
              textString="%C")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Polygon(
              points={{0,67},{-20,63},{-40,57},{-52,43},{-58,35},{-68,25},{-72,
                  13},{-76,-1},{-78,-15},{-76,-31},{-76,-43},{-76,-53},{-70,-65},
                  {-64,-73},{-48,-77},{-30,-83},{-18,-83},{-2,-85},{8,-89},{22,
                  -89},{32,-87},{42,-81},{54,-75},{56,-73},{66,-61},{68,-53},{
                  70,-51},{72,-35},{76,-21},{78,-13},{78,3},{74,15},{66,25},{54,
                  33},{44,41},{36,57},{26,65},{0,67}},
              lineColor={160,160,164},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-58,35},{-68,25},{-72,13},{-76,-1},{-78,-15},{-76,-31},{
                  -76,-43},{-76,-53},{-70,-65},{-64,-73},{-48,-77},{-30,-83},{-18,
                  -83},{-2,-85},{8,-89},{22,-89},{32,-87},{42,-81},{54,-75},{42,
                  -77},{40,-77},{30,-79},{20,-81},{18,-81},{10,-81},{2,-77},{-12,
                  -73},{-22,-73},{-30,-71},{-40,-65},{-50,-55},{-56,-43},{-58,-35},
                  {-58,-25},{-60,-13},{-60,-5},{-60,7},{-58,17},{-56,19},{-52,
                  27},{-48,35},{-44,45},{-40,57},{-58,35}},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-6,-1},{6,-12}},
              lineColor={255,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{11,13},{50,-25}},
              textString="T"),
            Line(points={{0,-12},{0,-96}}, color={255,0,0})}),
        Documentation(info="<html>
<p>
This is a generic model for the heat capacity of a material.
No specific geometry is assumed beyond a total volume with
uniform temperature for the entire volume.
Furthermore, it is assumed that the heat capacity
is constant (independent of temperature).
</p>
<p>
The temperature T [Kelvin] of this component is a <strong>state</strong>.
A default of T = 25 degree Celsius (= SIunits.Conversions.from_degC(25))
is used as start value for initialization.
This usually means that at start of integration the temperature of this
component is 25 degrees Celsius. You may, of course, define a different
temperature as start value for initialization. Alternatively, it is possible
to set parameter <strong>steadyStateStart</strong> to <strong>true</strong>. In this case
the additional equation '<strong>der</strong>(T) = 0' is used during
initialization, i.e., the temperature T is computed in such a way that
the component starts in <strong>steady state</strong>. This is useful in cases,
where one would like to start simulation in a suitable operating
point without being forced to integrate for a long time to arrive
at this point.
</p>
<p>
Note, that parameter <strong>steadyStateStart</strong> is not available in
the parameter menu of the simulation window, because its value
is utilized during translation to generate quite different
equations depending on its setting. Therefore, the value of this
parameter can only be changed before translating the model.
</p>
<p>
This component may be used for complicated geometries where
the heat capacity C is determined my measurements. If the component
consists mainly of one type of material, the <strong>mass m</strong> of the
component may be measured or calculated and multiplied with the
<strong>specific heat capacity cp</strong> of the component material to
compute C:
</p>
<pre>
   C = cp*m.
   Typical values for cp at 20 degC in J/(kg.K):
      aluminium   896
      concrete    840
      copper      383
      iron        452
      silver      235
      steel       420 ... 500 (V2A)
      wood       2500
</pre>
</html>"));
    end HeatCapacitor;

    model ThermalConductor
      "Lumped thermal element transporting heat without storing it"
      extends Interfaces.Element1D;
      parameter Modelica.SIunits.ThermalConductance G
        "Constant thermal conductance of material";

    equation
      Q_flow = G*dT;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-90,70},{90,-70}},
              pattern=LinePattern.None,
              fillColor={192,192,192},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-90,70},{-90,-70}},
              thickness=0.5),
            Line(
              points={{90,70},{90,-70}},
              thickness=0.5),
            Text(
              extent={{-150,115},{150,75}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-75},{150,-105}},
              textString="G=%G")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Line(
              points={{-80,0},{80,0}},
              color={255,0,0},
              thickness=0.5,
              arrow={Arrow.None,Arrow.Filled}),
            Text(
              extent={{-100,-20},{100,-40}},
              lineColor={255,0,0},
              textString="Q_flow"),
            Text(
              extent={{-100,40},{100,20}},
              textString="dT = port_a.T - port_b.T")}),
        Documentation(info="<html>
<p>
This is a model for transport of heat without storing it; see also:
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalResistor\">ThermalResistor</a>.
It may be used for complicated geometries where
the thermal conductance G (= inverse of thermal resistance)
is determined by measurements and is assumed to be constant
over the range of operations. If the component consists mainly of
one type of material and a regular geometry, it may be calculated,
e.g., with one of the following equations:
</p>
<ul>
<li><p>
    Conductance for a <strong>box</strong> geometry under the assumption
    that heat flows along the box length:</p>
    <pre>
    G = k*A/L
    k: Thermal conductivity (material constant)
    A: Area of box
    L: Length of box
    </pre>
    </li>
<li><p>
    Conductance for a <strong>cylindrical</strong> geometry under the assumption
    that heat flows from the inside to the outside radius
    of the cylinder:</p>
    <pre>
    G = 2*pi*k*L/log(r_out/r_in)
    pi   : Modelica.Constants.pi
    k    : Thermal conductivity (material constant)
    L    : Length of cylinder
    log  : Modelica.Math.log;
    r_out: Outer radius of cylinder
    r_in : Inner radius of cylinder
    </pre>
    </li>
</ul>
<pre>
    Typical values for k at 20 degC in W/(m.K):
      aluminium   220
      concrete      1
      copper      384
      iron         74
      silver      407
      steel        45 .. 15 (V2A)
      wood         0.1 ... 0.2
</pre>
</html>"));
    end ThermalConductor;

    model ThermalResistor
      "Lumped thermal element transporting heat without storing it"
      extends Interfaces.Element1D;
      parameter Modelica.SIunits.ThermalResistance R
        "Constant thermal resistance of material";

    equation
      dT = R*Q_flow;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-90,70},{90,-70}},
              pattern=LinePattern.None,
              fillColor={192,192,192},
              fillPattern=FillPattern.Forward),
            Line(
              points={{-90,70},{-90,-70}},
              thickness=0.5),
            Line(
              points={{90,70},{90,-70}},
              thickness=0.5),
            Text(
              extent={{-150,115},{150,75}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-75},{150,-105}},
              textString="R=%R")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Line(
              points={{-80,0},{80,0}},
              color={255,0,0},
              thickness=0.5,
              arrow={Arrow.None,Arrow.Filled}),
            Text(
              extent={{-100,-20},{100,-40}},
              lineColor={255,0,0},
              textString="Q_flow"),
            Text(
              extent={{-100,40},{100,20}},
              textString="dT = port_a.T - port_b.T")}),
        Documentation(info="<html>
<p>
This is a model for transport of heat without storing it, same as the
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">ThermalConductor</a>
but using the thermal resistance instead of the thermal conductance as a parameter.
This is advantageous for series connections of ThermalResistors,
especially if it shall be allowed that a ThermalResistance is defined to be zero (i.e. no temperature difference).
</p>
</html>"));
    end ThermalResistor;

    model Convection
      "Lumped thermal element for heat convection (Q_flow = Gc*dT)"
      Modelica.SIunits.HeatFlowRate Q_flow "Heat flow rate from solid -> fluid";
      Modelica.SIunits.TemperatureDifference dT "= solid.T - fluid.T";
      Modelica.Blocks.Interfaces.RealInput Gc(unit="W/K")
        "Signal representing the convective thermal conductance in [W/K]"
        annotation (Placement(transformation(
            origin={0,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Interfaces.HeatPort_a solid annotation (Placement(transformation(extent={{
                -110,-10},{-90,10}})));
      Interfaces.HeatPort_b fluid annotation (Placement(transformation(extent={{
                90,-10},{110,10}})));
    equation
      dT = solid.T - fluid.T;
      solid.Q_flow = Q_flow;
      fluid.Q_flow = -Q_flow;
      Q_flow = Gc*dT;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-62,80},{98,-80}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-90,80},{-60,-80}},
              fillColor={192,192,192},
              fillPattern=FillPattern.Backward),
            Text(
              extent={{-150,-90},{150,-130}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{100,0},{100,0}}, color={0,127,255}),
            Line(points={{-60,20},{76,20}}, color={191,0,0}),
            Line(points={{-60,-20},{76,-20}}, color={191,0,0}),
            Line(points={{-34,80},{-34,-80}}, color={0,127,255}),
            Line(points={{6,80},{6,-80}}, color={0,127,255}),
            Line(points={{40,80},{40,-80}}, color={0,127,255}),
            Line(points={{76,80},{76,-80}}, color={0,127,255}),
            Line(points={{-34,-80},{-44,-60}}, color={0,127,255}),
            Line(points={{-34,-80},{-24,-60}}, color={0,127,255}),
            Line(points={{6,-80},{-4,-60}}, color={0,127,255}),
            Line(points={{6,-80},{16,-60}}, color={0,127,255}),
            Line(points={{40,-80},{30,-60}}, color={0,127,255}),
            Line(points={{40,-80},{50,-60}}, color={0,127,255}),
            Line(points={{76,-80},{66,-60}}, color={0,127,255}),
            Line(points={{76,-80},{86,-60}}, color={0,127,255}),
            Line(points={{56,-30},{76,-20}}, color={191,0,0}),
            Line(points={{56,-10},{76,-20}}, color={191,0,0}),
            Line(points={{56,10},{76,20}}, color={191,0,0}),
            Line(points={{56,30},{76,20}}, color={191,0,0}),
            Text(
              extent={{22,124},{92,98}},
              textString="Gc")}),
        Documentation(info="<html>
<p>
This is a model of linear heat convection, e.g., the heat transfer between a plate and the surrounding air; see also:
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor\">ConvectiveResistor</a>.
It may be used for complicated solid geometries and fluid flow over the solid by determining the
convective thermal conductance Gc by measurements. The basic constitutive equation for convection is
</p>
<pre>
   Q_flow = Gc*(solid.T - fluid.T);
   Q_flow: Heat flow rate from connector 'solid' (e.g., a plate)
      to connector 'fluid' (e.g., the surrounding air)
</pre>
<p>
Gc = G.signal[1] is an input signal to the component, since Gc is
nearly never constant in practice. For example, Gc may be a function
of the speed of a cooling fan. For simple situations,
Gc may be <em>calculated</em> according to
</p>
<pre>
   Gc = A*h
   A: Convection area (e.g., perimeter*length of a box)
   h: Heat transfer coefficient
</pre>
<p>
where the heat transfer coefficient h is calculated
from properties of the fluid flowing over the solid. Examples:
</p>
<p>
<strong>Machines cooled by air</strong> (empirical, very rough approximation according
to R. Fischer: Elektrische Maschinen, 10th edition, Hanser-Verlag 1999,
p. 378):
</p>
<pre>
    h = 7.8*v^0.78 [W/(m2.K)] (forced convection)
      = 12         [W/(m2.K)] (free convection)
    where
      v: Air velocity in [m/s]
</pre>
<p><strong>Laminar</strong> flow with constant velocity of a fluid along a
<strong>flat plate</strong> where the heat flow rate from the plate
to the fluid (= solid.Q_flow) is kept constant
(according to J.P.Holman: Heat Transfer, 8th edition,
McGraw-Hill, 1997, p.270):
</p>
<pre>
   h  = Nu*k/x;
   Nu = 0.453*Re^(1/2)*Pr^(1/3);
   where
      h  : Heat transfer coefficient
      Nu : = h*x/k       (Nusselt number)
      Re : = v*x*rho/mue (Reynolds number)
      Pr : = cp*mue/k    (Prandtl number)
      v  : Absolute velocity of fluid
      x  : distance from leading edge of flat plate
      rho: density of fluid (material constant
      mue: dynamic viscosity of fluid (material constant)
      cp : specific heat capacity of fluid (material constant)
      k  : thermal conductivity of fluid (material constant)
   and the equation for h holds, provided
      Re &lt; 5e5 and 0.6 &lt; Pr &lt; 50
</pre>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Rectangle(
              extent={{-90,80},{-60,-80}},
              fillColor={192,192,192},
              fillPattern=FillPattern.Backward),
            Line(points={{100,0},{100,0}}, color={0,127,255}),
            Line(points={{100,0},{100,0}}, color={0,127,255}),
            Line(points={{100,0},{100,0}}, color={0,127,255}),
            Text(
              extent={{-40,40},{80,20}},
              lineColor={255,0,0},
              textString="Q_flow"),
            Line(points={{-60,20},{76,20}}, color={191,0,0}),
            Line(points={{-60,-20},{76,-20}}, color={191,0,0}),
            Line(points={{-34,80},{-34,-80}}, color={0,127,255}),
            Line(points={{6,80},{6,-80}}, color={0,127,255}),
            Line(points={{40,80},{40,-80}}, color={0,127,255}),
            Line(points={{76,80},{76,-80}}, color={0,127,255}),
            Line(points={{-34,-80},{-44,-60}}, color={0,127,255}),
            Line(points={{-34,-80},{-24,-60}}, color={0,127,255}),
            Line(points={{6,-80},{-4,-60}}, color={0,127,255}),
            Line(points={{6,-80},{16,-60}}, color={0,127,255}),
            Line(points={{40,-80},{30,-60}}, color={0,127,255}),
            Line(points={{40,-80},{50,-60}}, color={0,127,255}),
            Line(points={{76,-80},{66,-60}}, color={0,127,255}),
            Line(points={{76,-80},{86,-60}}, color={0,127,255}),
            Line(points={{56,-30},{76,-20}}, color={191,0,0}),
            Line(points={{56,-10},{76,-20}}, color={191,0,0}),
            Line(points={{56,10},{76,20}}, color={191,0,0}),
            Line(points={{56,30},{76,20}}, color={191,0,0})}));
    end Convection;

    model ConvectiveResistor
      "Lumped thermal element for heat convection (dT = Rc*Q_flow)"
      Modelica.SIunits.HeatFlowRate Q_flow "Heat flow rate from solid -> fluid";
      Modelica.SIunits.TemperatureDifference dT "= solid.T - fluid.T";
      Modelica.Blocks.Interfaces.RealInput Rc(unit="K/W")
        "Signal representing the convective thermal resistance in [K/W]"
        annotation (Placement(transformation(
            origin={0,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Interfaces.HeatPort_a solid annotation (Placement(transformation(extent={{
                -110,-10},{-90,10}})));
      Interfaces.HeatPort_b fluid annotation (Placement(transformation(extent={{
                90,-10},{110,10}})));
    equation
      dT = solid.T - fluid.T;
      solid.Q_flow = Q_flow;
      fluid.Q_flow = -Q_flow;
      dT = Rc*Q_flow;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-62,80},{98,-80}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-90,80},{-60,-80}},
              fillColor={192,192,192},
              fillPattern=FillPattern.Forward),
            Text(
              extent={{-150,-90},{150,-130}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{100,0},{100,0}}, color={0,127,255}),
            Line(points={{-60,20},{76,20}}, color={191,0,0}),
            Line(points={{-60,-20},{76,-20}}, color={191,0,0}),
            Line(points={{-34,80},{-34,-80}}, color={0,127,255}),
            Line(points={{6,80},{6,-80}}, color={0,127,255}),
            Line(points={{40,80},{40,-80}}, color={0,127,255}),
            Line(points={{76,80},{76,-80}}, color={0,127,255}),
            Line(points={{-34,-80},{-44,-60}}, color={0,127,255}),
            Line(points={{-34,-80},{-24,-60}}, color={0,127,255}),
            Line(points={{6,-80},{-4,-60}}, color={0,127,255}),
            Line(points={{6,-80},{16,-60}}, color={0,127,255}),
            Line(points={{40,-80},{30,-60}}, color={0,127,255}),
            Line(points={{40,-80},{50,-60}}, color={0,127,255}),
            Line(points={{76,-80},{66,-60}}, color={0,127,255}),
            Line(points={{76,-80},{86,-60}}, color={0,127,255}),
            Line(points={{56,-30},{76,-20}}, color={191,0,0}),
            Line(points={{56,-10},{76,-20}}, color={191,0,0}),
            Line(points={{56,10},{76,20}}, color={191,0,0}),
            Line(points={{56,30},{76,20}}, color={191,0,0}),
            Text(
              extent={{22,124},{92,98}},
              textString="Rc")}),
        Documentation(info="<html>
<p>
This is a model of linear heat convection, e.g., the heat transfer between a plate and the surrounding air; same as the
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.Convection\">Convection</a> component
but using the convective resistance instead of the convective conductance as an input.
This is advantageous for series connections of ConvectiveResistors,
especially if it shall be allowed that a convective resistance is defined to be zero (i.e. no temperature difference).
</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Rectangle(
              extent={{-90,80},{-60,-80}},
              fillColor={192,192,192},
              fillPattern=FillPattern.Forward),
            Line(points={{100,0},{100,0}}, color={0,127,255}),
            Line(points={{100,0},{100,0}}, color={0,127,255}),
            Line(points={{100,0},{100,0}}, color={0,127,255}),
            Text(
              extent={{-40,40},{80,20}},
              lineColor={255,0,0},
              textString="Q_flow"),
            Line(points={{-60,20},{76,20}}, color={191,0,0}),
            Line(points={{-60,-20},{76,-20}}, color={191,0,0}),
            Line(points={{-34,80},{-34,-80}}, color={0,127,255}),
            Line(points={{6,80},{6,-80}}, color={0,127,255}),
            Line(points={{40,80},{40,-80}}, color={0,127,255}),
            Line(points={{76,80},{76,-80}}, color={0,127,255}),
            Line(points={{-34,-80},{-44,-60}}, color={0,127,255}),
            Line(points={{-34,-80},{-24,-60}}, color={0,127,255}),
            Line(points={{6,-80},{-4,-60}}, color={0,127,255}),
            Line(points={{6,-80},{16,-60}}, color={0,127,255}),
            Line(points={{40,-80},{30,-60}}, color={0,127,255}),
            Line(points={{40,-80},{50,-60}}, color={0,127,255}),
            Line(points={{76,-80},{66,-60}}, color={0,127,255}),
            Line(points={{76,-80},{86,-60}}, color={0,127,255}),
            Line(points={{56,-30},{76,-20}}, color={191,0,0}),
            Line(points={{56,-10},{76,-20}}, color={191,0,0}),
            Line(points={{56,10},{76,20}}, color={191,0,0}),
            Line(points={{56,30},{76,20}}, color={191,0,0})}));
    end ConvectiveResistor;

    model BodyRadiation "Lumped thermal element for radiation heat transfer"
      extends Interfaces.Element1D;
      parameter Real Gr(unit="m2")
        "Net radiation conductance between two surfaces (see docu)";
    equation
      Q_flow = Gr*Modelica.Constants.sigma*(port_a.T^4 - port_b.T^4);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{50,80},{90,-80}},
              fillColor={192,192,192},
              fillPattern=FillPattern.Backward),
            Rectangle(
              extent={{-90,80},{-50,-80}},
              fillColor={192,192,192},
              fillPattern=FillPattern.Backward),
            Line(points={{-36,10},{36,10}}, color={191,0,0}),
            Line(points={{-36,10},{-26,16}}, color={191,0,0}),
            Line(points={{-36,10},{-26,4}}, color={191,0,0}),
            Line(points={{-36,-10},{36,-10}}, color={191,0,0}),
            Line(points={{26,-16},{36,-10}}, color={191,0,0}),
            Line(points={{26,-4},{36,-10}}, color={191,0,0}),
            Line(points={{-36,-30},{36,-30}}, color={191,0,0}),
            Line(points={{-36,-30},{-26,-24}}, color={191,0,0}),
            Line(points={{-36,-30},{-26,-36}}, color={191,0,0}),
            Line(points={{-36,30},{36,30}}, color={191,0,0}),
            Line(points={{26,24},{36,30}}, color={191,0,0}),
            Line(points={{26,36},{36,30}}, color={191,0,0}),
            Text(
              extent={{-150,125},{150,85}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-90},{150,-120}},
              textString="Gr=%Gr"),
            Rectangle(
              extent={{-50,80},{-44,-80}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{45,80},{50,-80}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
This is a model describing the thermal radiation, i.e., electromagnetic
radiation emitted between two bodies as a result of their temperatures.
The following constitutive equation is used:
</p>
<pre>
    Q_flow = Gr*sigma*(port_a.T^4 - port_b.T^4);
</pre>
<p>
where Gr is the radiation conductance and sigma is the Stefan-Boltzmann
constant (= Modelica.Constants.sigma). Gr may be determined by
measurements and is assumed to be constant over the range of operations.
</p>
<p>
For simple cases, Gr may be analytically computed. The analytical
equations use epsilon, the emission value of a body which is in the
range 0..1. Epsilon=1, if the body absorbs all radiation (= black body).
Epsilon=0, if the body reflects all radiation and does not absorb any.
</p>
<pre>
   Typical values for epsilon:
   aluminium, polished    0.04
   copper, polished       0.04
   gold, polished         0.02
   paper                  0.09
   rubber                 0.95
   silver, polished       0.02
   wood                   0.85..0.9
</pre>
<p><strong>Analytical Equations for Gr</strong></p>
<p>
<strong>Small convex object in large enclosure</strong>
(e.g., a hot machine in a room):
</p>
<pre>
    Gr = e*A
    where
       e: Emission value of object (0..1)
       A: Surface area of object where radiation
          heat transfer takes place
</pre>
<p><strong>Two parallel plates</strong>:</p>
<pre>
    Gr = A/(1/e1 + 1/e2 - 1)
    where
       e1: Emission value of plate1 (0..1)
       e2: Emission value of plate2 (0..1)
       A : Area of plate1 (= area of plate2)
</pre>
<p><strong>Two long cylinders in each other</strong>, where radiation takes
place from the inner to the outer cylinder):
</p>
<pre>
    Gr = 2*pi*r1*L/(1/e1 + (1/e2 - 1)*(r1/r2))
    where
       pi: = Modelica.Constants.pi
       r1: Radius of inner cylinder
       r2: Radius of outer cylinder
       L : Length of the two cylinders
       e1: Emission value of inner cylinder (0..1)
       e2: Emission value of outer cylinder (0..1)
</pre>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-90,80},{-56,-80}},
              fillColor={192,192,192},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-56,80},{-56,-80}},
              thickness=1),
            Line(
              points={{50,80},{50,-80}},
              thickness=1),
            Rectangle(
              extent={{50,80},{90,-80}},
              fillColor={192,192,192},
              fillPattern=FillPattern.Backward),
            Line(points={{-40,10},{40,10}}, color={191,0,0}),
            Line(points={{-40,10},{-30,16}}, color={191,0,0}),
            Line(points={{-40,10},{-30,4}}, color={191,0,0}),
            Line(points={{-40,-10},{40,-10}}, color={191,0,0}),
            Line(points={{30,-16},{40,-10}}, color={191,0,0}),
            Line(points={{30,-4},{40,-10}}, color={191,0,0}),
            Line(points={{-40,-30},{40,-30}}, color={191,0,0}),
            Line(points={{-40,-30},{-30,-24}}, color={191,0,0}),
            Line(points={{-40,-30},{-30,-36}}, color={191,0,0}),
            Line(points={{-40,30},{40,30}}, color={191,0,0}),
            Line(points={{30,24},{40,30}}, color={191,0,0}),
            Line(points={{30,36},{40,30}}, color={191,0,0})}));
    end BodyRadiation;

    model ThermalCollector "Collects m heat flows"
      parameter Integer m(min=1)=3 "Number of collected heat flows";
      Interfaces.HeatPort_a port_a[m]
        annotation (Placement(transformation(extent={{-10,110},{10,90}})));
      Interfaces.HeatPort_b port_b
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

    equation
      port_b.Q_flow + sum(port_a.Q_flow) = 0;
      port_a.T = fill(port_b.T, m);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,-30},{150,-70}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,80},{150,50}},
              textString="m=%m"),
            Line(
              points={{0,90},{0,40}},
              color={181,0,0}),
            Rectangle(
              extent={{-60,40},{60,30}},
              lineColor={181,0,0},
              fillColor={181,0,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-60,30},{0,-30},{0,-90}},
              color={181,0,0}),
            Line(
              points={{0,-30},{-20,30}},
              color={181,0,0}),
            Line(
              points={{0,-30},{20,30}},
              color={181,0,0}),
            Line(
              points={{0,-30},{60,30}},
              color={181,0,0})}),
        Documentation(info="<html>
<p>
This is a model to collect the heat flows from <em>m</em> heatports to one single heatport.
</p>
</html>"));
    end ThermalCollector;

    model GeneralHeatFlowToTemperatureAdaptor
      "Signal adaptor for a HeatTransfer port with temperature and derivative of temperature as outputs and heat flow as input (especially useful for FMUs)"
      extends Modelica.Blocks.Interfaces.Adaptors.FlowToPotentialAdaptor(
        final Name_p="T",
        final Name_pder="dT",
        final Name_pder2="d2T",
        final Name_f="Q",
        final Name_fder="der(Q)",
        final Name_fder2="der2(Q)",
        final use_pder2=false,
        final use_fder=false,
        final use_fder2=false,
        p(unit="K", displayUnit="degC"),
        final pder(unit="K/s"),
        final pder2(unit="K/s2"),
        final f(unit="W"),
        final fder(unit="W/s"),
        final fder2(unit="W/s2"));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
    equation
      y = heatPort.T "output = potential = temperature";
      u = heatPort.Q_flow "input = flow = heat flow";
      annotation (defaultComponentName="heatFlowToTemperatureAdaptor",
        Documentation(info="<html>
<p>
Adaptor between a heatport connector and a signal representation of the flange.
This component is used to provide a pure signal interface around a HeatTransfer model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>).
Examples of the usage of this adaptor are provided in
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Examples.GenerationOfFMUs\">HeatTransfer.Examples.GenerationOfFMUs</a>.
This adaptor has heatflow as input and temperature and derivative of temperature as output signals.
</p>
</html>"),
        Icon(graphics={
                Rectangle(
              extent={{-20,100},{20,-100}},
              lineColor={191,0,0},
              radius=10,
              lineThickness=0.5)}));
    end GeneralHeatFlowToTemperatureAdaptor;

    model GeneralTemperatureToHeatFlowAdaptor
      "Signal adaptor for a HeatTransfer port with heat flow as output and temperature and derivative of temperature as input (especially useful for FMUs)"
      extends Modelica.Blocks.Interfaces.Adaptors.PotentialToFlowAdaptor(
        final Name_p="T",
        final Name_pder="dT",
        final Name_pder2="d2T",
        final Name_f="Q",
        final Name_fder="der(Q)",
        final Name_fder2="der2(Q)",
        final use_pder2=false,
        final use_fder=false,
        final use_fder2=false,
        p(unit="K", displayUnit="degC"),
        final pder(unit="K/s"),
        final pder2(unit="K/s2"),
        final f(unit="W"),
        final fder(unit="W/s"),
        final fder2(unit="W/s2"));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort annotation (
          Placement(transformation(extent={{10,-10},{30,10}}), iconTransformation(
              extent={{10,-10},{30,10}})));
    equation
      y = heatPort.Q_flow "output = flow = heat flow";
      u = heatPort.T "input = potential = temperature";
      annotation (defaultComponentName="temperatureToHeatFlowAdaptor",
        Documentation(info="<html>
<p>
Adaptor between a heatport connector and a signal representation of the flange.
This component is used to provide a pure signal interface around a HeatTransfer model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>).
Examples of the usage of this adaptor are provided in
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Examples.GenerationOfFMUs\">HeatTransfer.Examples.GenerationOfFMUs</a>.
This adaptor has temperature and derivative of temperature as input signals and heatflow as output signal.
</p>
<p>
Note, the input signals must be consistent to each other
(derT=der(T)).
</p>
</html>"),
        Icon(graphics={
                Rectangle(
              extent={{-20,100},{20,-100}},
              lineColor={191,0,0},
              radius=10,
              lineThickness=0.5)}));
    end GeneralTemperatureToHeatFlowAdaptor;
    annotation (Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={
      Rectangle(
        origin = {12,40},
        fillColor = {192,192,192},
        fillPattern = FillPattern.Backward,
        extent = {{-100,-100},{-70,18}}),
      Line(
        origin = {12,40},
        points = {{-44,16},{-44,-100}},
        color = {0,127,255}),
      Line(
        origin = {12,40},
        points = {{-4,16},{-4,-100}},
        color = {0,127,255}),
      Line(
        origin = {12,40},
        points = {{30,18},{30,-100}},
        color = {0,127,255}),
      Line(
        origin = {12,40},
        points = {{66,18},{66,-100}},
        color = {0,127,255}),
      Line(
        origin = {12,40},
        points = {{66,-100},{76,-80}},
        color = {0,127,255}),
      Line(
        origin = {12,40},
        points = {{66,-100},{56,-80}},
        color = {0,127,255}),
      Line(
        origin = {12,40},
        points = {{30,-100},{40,-80}},
        color = {0,127,255}),
      Line(
        origin = {12,40},
        points = {{30,-100},{20,-80}},
        color = {0,127,255}),
      Line(
        origin = {12,40},
        points = {{-4,-100},{6,-80}},
        color = {0,127,255}),
      Line(
        origin = {12,40},
        points = {{-4,-100},{-14,-80}},
        color = {0,127,255}),
      Line(
        origin = {12,40},
        points = {{-44,-100},{-34,-80}},
        color = {0,127,255}),
      Line(
        origin = {12,40},
        points = {{-44,-100},{-54,-80}},
        color = {0,127,255}),
      Line(
        origin = {12,40},
        points = {{-70,-60},{66,-60}},
        color = {191,0,0}),
      Line(
        origin = {12,40},
        points = {{46,-70},{66,-60}},
        color = {191,0,0}),
      Line(
        origin = {12,40},
        points = {{46,-50},{66,-60}},
        color = {191,0,0}),
      Line(
        origin = {12,40},
        points = {{46,-30},{66,-20}},
        color = {191,0,0}),
      Line(
        origin = {12,40},
        points = {{46,-10},{66,-20}},
        color = {191,0,0}),
      Line(
        origin = {12,40},
        points = {{-70,-20},{66,-20}},
        color = {191,0,0})}), Documentation(
          info="<html>

</html>"));
  end Components;

  package Sensors "Thermal sensors"
    extends Modelica.Icons.SensorsPackage;

    model TemperatureSensor "Absolute temperature sensor in Kelvin"

      Modelica.Blocks.Interfaces.RealOutput T(unit="K")
        "Absolute temperature as output signal"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Interfaces.HeatPort_a port annotation (Placement(transformation(extent={{
                -110,-10},{-90,10}})));
    equation
      T = port.T;
      port.Q_flow = 0;
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(
              extent={{-20,-98},{20,-60}},
              lineThickness=0.5,
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-12,40},{12,-68}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{12,0},{90,0}}, color={0,0,255}),
            Line(points={{-94,0},{-14,0}}, color={191,0,0}),
            Polygon(
              points={{-12,40},{-12,80},{-10,86},{-6,88},{0,90},{6,88},{10,86},{
                  12,80},{12,40},{-12,40}},
              lineThickness=0.5),
            Line(
              points={{-12,40},{-12,-64}},
              thickness=0.5),
            Line(
              points={{12,40},{12,-64}},
              thickness=0.5),
            Line(points={{-40,-20},{-12,-20}}),
            Line(points={{-40,20},{-12,20}}),
            Line(points={{-40,60},{-12,60}}),
            Text(
              extent={{102,-28},{60,-78}},
              textString="K")}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(
              extent={{-20,-98},{20,-60}},
              lineThickness=0.5,
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-12,40},{12,-68}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{12,0},{90,0}}, color={0,0,255}),
            Line(points={{-90,0},{-12,0}}, color={191,0,0}),
            Polygon(
              points={{-12,40},{-12,80},{-10,86},{-6,88},{0,90},{6,88},{10,86},
                  {12,80},{12,40},{-12,40}},
              lineThickness=0.5),
            Line(
              points={{-12,40},{-12,-64}},
              thickness=0.5),
            Line(
              points={{12,40},{12,-64}},
              thickness=0.5),
            Line(points={{-40,-20},{-12,-20}}),
            Line(points={{-40,20},{-12,20}}),
            Line(points={{-40,60},{-12,60}}),
            Text(
              extent={{126,-20},{26,-120}},
              textString="K"),
            Text(
              extent={{-150,130},{150,90}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
This is an ideal absolute temperature sensor which returns
the temperature of the connected port in Kelvin as an output
signal.  The sensor itself has no thermal interaction with
whatever it is connected to.  Furthermore, no
thermocouple-like lags are associated with this
sensor model.
</p>
</html>"));
    end TemperatureSensor;

    model RelTemperatureSensor "Relative Temperature sensor"
      extends Modelica.Icons.TranslationalSensor;
      Interfaces.HeatPort_a port_a annotation (Placement(transformation(extent={{
                -110,-10},{-90,10}})));
      Interfaces.HeatPort_b port_b annotation (Placement(transformation(extent={{
                90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.RealOutput T_rel(unit="K", displayUnit="K")
        "Relative temperature as output signal"
        annotation (Placement(transformation(
            origin={0,-90},
            extent={{10,-10},{-10,10}},
            rotation=90)));
    equation
      T_rel = port_a.T - port_b.T;
      0 = port_a.Q_flow;
      0 = port_b.Q_flow;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-90,0},{-70,0},{-70,0}}, color={191,0,0}),
            Line(points={{-90,0},{-70,0},{-70,0}}, color={191,0,0}),
            Line(points={{70,0},{90,0},{90,0}}, color={191,0,0}),
            Line(points={{0,-30},{0,-80}}, color={0,0,255}),
            Text(
              extent={{-150,80},{150,40}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{92,-62},{34,-122}},
              textString="K")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-90,0},{-70,0},{-70,0}}, color={191,0,0}),
            Line(points={{-98,0},{-70,0},{-70,0}}, color={191,0,0}),
            Line(points={{70,0},{94,0},{94,0}}, color={191,0,0}),
            Line(points={{0,-30},{0,-80}}, color={0,0,255}),
            Text(
              extent={{64,-74},{32,-102}},
              textString="K")}),
        Documentation(info="<html>
<p>
The relative temperature \"port_a.T - port_b.T\" is determined between
the two ports of this component and is provided as output signal in Kelvin.
</p>
</html>"));
    end RelTemperatureSensor;

    model HeatFlowSensor "Heat flow rate sensor"
      extends Modelica.Icons.RotationalSensor;
      Modelica.Blocks.Interfaces.RealOutput Q_flow(unit="W")
        "Heat flow from port_a to port_b as output signal" annotation (Placement(
            transformation(
            origin={0,-100},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Interfaces.HeatPort_a port_a annotation (Placement(transformation(extent={{
                -110,-10},{-90,10}})));
      Interfaces.HeatPort_b port_b annotation (Placement(transformation(extent={{
                90,-10},{110,10}})));
    equation
      port_a.T = port_b.T;
      port_a.Q_flow + port_b.Q_flow = 0;
      Q_flow = port_a.Q_flow;
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-70,0},{-95,0}}, color={191,0,0}),
            Line(points={{0,-70},{0,-90}}, color={0,0,127}),
            Line(points={{94,0},{69,0}}, color={191,0,0})}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{5,-86},{116,-110}},
              textString="Q_flow"),
            Line(points={{-70,0},{-90,0}}, color={191,0,0}),
            Line(points={{69,0},{90,0}}, color={191,0,0}),
            Line(points={{0,-70},{0,-90}}, color={0,0,127}),
            Text(
              extent={{-150,125},{150,85}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
This model is capable of monitoring the heat flow rate flowing through
this component. The sensed value of heat flow rate is the amount that
passes through this sensor while keeping the temperature drop across the
sensor zero.  This is an ideal model so it does not absorb any energy
and it has no direct effect on the thermal response of a system it is included in.
The output signal is positive, if the heat flows from port_a to port_b.
</p>
</html>"));
    end HeatFlowSensor;

    model ConditionalFixedHeatFlowSensor
      "HeatFlowSensor, conditional fixed Temperature"
      extends Modelica.Icons.RotationalSensor;
      parameter Boolean useFixedTemperature(start=false)
        "Fixed Temperature if true"
        annotation(Evaluate=true);
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(final T(
            displayUnit="K") = 293.15) if useFixedTemperature
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,-30})));
      Modelica.Blocks.Interfaces.RealOutput Q_flow(unit="W")
        "Heat flow from port_a to port_b as output signal" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-100})));
    equation
      connect(heatFlowSensor.port_b, port_b) annotation (Line(
          points={{10,0},{100,0}}, color={191,0,0}));
      connect(port_a, heatFlowSensor.port_a) annotation (Line(
          points={{-100,0},{-10,0}}, color={191,0,0}));
      connect(fixedTemperature.port, heatFlowSensor.port_a) annotation (Line(
          points={{-50,-20},{-50,0},{-10,0}}, color={191,0,0}));
      connect(heatFlowSensor.Q_flow, Q_flow) annotation (Line(
          points={{0,-10},{0,-100}},color={0,0,127}));
      annotation (defaultComponentName="heatFlowSensor",
        Icon(graphics={
          Rectangle(
            lineColor = {255,0,0},
            fillColor = {255,0,0},
            fillPattern = FillPattern.HorizontalCylinder,
            extent = {{-90,-10},{-70,10}}),
          Rectangle(
            lineColor = {255,0,0},
            fillColor = {255,0,0},
            fillPattern = FillPattern.HorizontalCylinder,
            extent={{70,-10},{90,10}}),
          Text(
            lineColor = {0,0,255},
            extent = {{-150,85},{150,125}},
            textString = "%name"),
          Line(points = {{0,-70},{0,-90}}, color = {0,0,127})},
            coordinateSystem(extent = {{-100,-100},{100,100}},
              preserveAspectRatio = true)),
        Documentation(info="<html>
<p>
If useFixedTemperature = false, this sensor acts just as a normal
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor\">HeatFlowSensor</a>.
</p>
<p>
If useFixedTemperature = true, it is assumed that the connections to both heatPorts of this sensor are conditionally removed;
in this case, the measured Q_flow is reported = 0 automatically.
To avoid a singular equation system, the temperature of the sensor is set to 293.15 K.
</p>
</html>"));
    end ConditionalFixedHeatFlowSensor;
    annotation (Documentation(info="<html>

</html>"));
  end Sensors;

  package Sources "Thermal sources"
  extends Modelica.Icons.SourcesPackage;

    model FixedTemperature "Fixed temperature boundary condition in Kelvin"

      parameter Modelica.SIunits.Temperature T "Fixed temperature at port";
      Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90,
                -10},{110,10}})));
    equation
      port.T = T;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-110},{150,-140}},
              textString="T=%T"),
            Rectangle(
              extent={{-100,100},{100,-100}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Text(
              extent={{0,0},{-100,-100}},
              textString="K"),
            Line(
              points={{-52,0},{56,0}},
              color={191,0,0},
              thickness=0.5),
            Polygon(
              points={{50,-20},{50,20},{90,0},{50,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
This model defines a fixed temperature T at its port in Kelvin,
i.e., it defines a fixed temperature as a boundary condition.
</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-101}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-52,0},{56,0}},
              color={191,0,0},
              thickness=0.5),
            Text(
              extent={{0,0},{-100,-100}},
              textString="K"),
            Polygon(
              points={{52,-20},{52,20},{90,0},{52,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}));
    end FixedTemperature;

    model PrescribedTemperature
      "Variable temperature boundary condition in Kelvin"

      Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90,
                -10},{110,10}})));
      Modelica.Blocks.Interfaces.RealInput T(unit="K") annotation (Placement(transformation(
              extent={{-140,-20},{-100,20}})));
    equation
      port.T = T;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-102,0},{64,0}},
              color={191,0,0},
              thickness=0.5),
            Text(
              extent={{0,0},{-100,-100}},
              textString="K"),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Polygon(
              points={{50,-20},{50,20},{90,0},{50,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
This model represents a variable temperature boundary condition.
The temperature in [K] is given as input signal <strong>T</strong>
to the model. The effect is that an instance of this model acts as
an infinite reservoir able to absorb or generate as much energy
as required to keep the temperature at the specified value.
</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Text(
              extent={{0,0},{-100,-100}},
              textString="K"),
            Line(
              points={{-102,0},{64,0}},
              color={191,0,0},
              thickness=0.5),
            Polygon(
              points={{52,-20},{52,20},{90,0},{52,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}));
    end PrescribedTemperature;

    model FixedHeatFlow "Fixed heat flow boundary condition"
      parameter Modelica.SIunits.HeatFlowRate Q_flow
        "Fixed heat flow rate at port";
      parameter Modelica.SIunits.Temperature T_ref=293.15
        "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
        "Temperature coefficient of heat flow rate";
      Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90,
                -10},{110,10}})));
    equation
      port.Q_flow = -Q_flow*(1 + alpha*(port.T - T_ref));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,100},{150,60}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-55},{150,-85}},
              textString="Q_flow=%Q_flow"),
            Line(
              points={{-100,-20},{48,-20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{-100,20},{46,20}},
              color={191,0,0},
              thickness=0.5),
            Polygon(
              points={{40,0},{40,40},{70,20},{40,0}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{40,-40},{40,0},{70,-20},{40,-40}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{70,40},{90,-40}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{-100,40},{0,-36}},
              textString="Q_flow=const."),
            Line(
              points={{-48,-20},{60,-20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{-48,20},{60,20}},
              color={191,0,0},
              thickness=0.5),
            Polygon(
              points={{60,0},{60,40},{90,20},{60,0}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{60,-40},{60,0},{90,-20},{60,-40}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
This model allows a specified amount of heat flow rate to be \"injected\"
into a thermal system at a given port.  The constant amount of heat
flow rate Q_flow is given as a parameter. The heat flows into the
component to which the component FixedHeatFlow is connected,
if parameter Q_flow is positive.
</p>
<p>
If parameter alpha is &lt;&gt; 0, the heat flow is multiplied by (1 + alpha*(port.T - T_ref))
in order to simulate temperature dependent losses (which are given with respect to reference temperature T_ref).
</p>
</html>"));
    end FixedHeatFlow;

    model PrescribedHeatFlow "Prescribed heat flow boundary condition"
      parameter Modelica.SIunits.Temperature T_ref=293.15
        "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
        "Temperature coefficient of heat flow rate";
      Modelica.Blocks.Interfaces.RealInput Q_flow(unit="W")
            annotation (Placement(transformation(
            origin={-100,0},
            extent={{20,-20},{-20,20}},
            rotation=180)));
      Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90,
                -10},{110,10}})));
    equation
      port.Q_flow = -Q_flow*(1 + alpha*(port.T - T_ref));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Line(
              points={{-60,-20},{40,-20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{-60,20},{40,20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{-80,0},{-60,-20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{-80,0},{-60,20}},
              color={191,0,0},
              thickness=0.5),
            Polygon(
              points={{40,0},{40,40},{70,20},{40,0}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{40,-40},{40,0},{70,-20},{40,-40}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{70,40},{90,-40}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,100},{150,60}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
This model allows a specified amount of heat flow rate to be \"injected\"
into a thermal system at a given port.  The amount of heat
is given by the input signal Q_flow into the model. The heat flows into the
component to which the component PrescribedHeatFlow is connected,
if the input signal is positive.
</p>
<p>
If parameter alpha is &lt;&gt; 0, the heat flow is multiplied by (1 + alpha*(port.T - T_ref))
in order to simulate temperature dependent losses (which are given with respect to reference temperature T_ref).
</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Line(
              points={{-60,-20},{68,-20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{-60,20},{68,20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{-80,0},{-60,-20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{-80,0},{-60,20}},
              color={191,0,0},
              thickness=0.5),
            Polygon(
              points={{60,0},{60,40},{90,20},{60,0}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{60,-40},{60,0},{90,-20},{60,-40}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}));
    end PrescribedHeatFlow;
    annotation (Documentation(info="<html>

</html>"));
  end Sources;

  package Celsius "Components with Celsius input and/or output"

    extends Modelica.Icons.VariantsPackage;

    model ToKelvin "Conversion block from degCelsius to Kelvin"

      Modelica.Blocks.Interfaces.RealInput Celsius(unit="degC")
         annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput Kelvin(unit="K")
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      Kelvin = Modelica.SIunits.Conversions.from_degC(Celsius);
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Ellipse(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-40,-50},{-99,-99}},
              textString="degC"),
            Text(
              extent={{100,-47},{44,-100}},
              textString="K"),
            Line(points={{-100,0},{-40,0}}, color={0,0,255}),
            Line(points={{41,0},{100,0}}, color={0,0,255})}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{124,-38},{52,-94}},
              textString="K"),
            Text(
              extent={{-62,-38},{-141,-97}},
              textString="degC"),
            Line(points={{-41,0},{-100,0}}, color={0,0,255}),
            Line(points={{100,0},{40,0}}, color={0,0,255}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
This component converts an input signal from Celsius to Kelvin
and provide is as output signal.
</p>
</html>"));
    end ToKelvin;

    model FromKelvin "Conversion from Kelvin to degCelsius"

      Modelica.Blocks.Interfaces.RealInput Kelvin(unit="K")
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput Celsius(unit="degC")
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      Celsius = Modelica.SIunits.Conversions.to_degC(Kelvin);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Ellipse(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-72,-46},{-152,-108}},
              textString="K"),
            Text(
              extent={{122,-48},{38,-109}},
              textString="degC"),
            Line(points={{-40,0},{-100,0}}, color={0,0,255}),
            Line(points={{40,0},{100,0}}, color={0,0,255})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Ellipse(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-42,-41},{-101,-98}},
              textString="K"),
            Text(
              extent={{100,-40},{30,-100}},
              textString="degC"),
            Line(points={{-100,0},{-40,0}}, color={0,0,255}),
            Line(points={{40,0},{100,0}}, color={0,0,255})}),
        Documentation(info="<html>
<p>
This component converts an input signal from Kelvin to Celsius
and provides is as output signal.
</p>
</html>"));
    end FromKelvin;

    model FixedTemperature
      "Fixed temperature boundary condition in degree Celsius"
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T
        "Fixed Temperature at the port";
      Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{
                90,-10},{110,10}})));
    equation
      port.T = Modelica.SIunits.Conversions.from_degC(T);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Rectangle(
              extent={{-100,100},{100,-100}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Text(
              extent={{0,0},{-100,-100}},
              textString="degC"),
            Polygon(
              points={{52,-20},{52,20},{90,0},{52,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,-110},{150,-140}},
              textString="T=%T"),
            Line(
              points={{-42,0},{66,0}},
              color={191,0,0},
              thickness=0.5)}),
        Documentation(info="<html>
<p>
This model defines a fixed temperature T at its port in [degC],
i.e., it defines a fixed temperature as a boundary condition.
</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-42,0},{66,0}},
              color={191,0,0},
              thickness=0.5),
            Text(
              extent={{0,0},{-100,-100}},
              textString="degC"),
            Polygon(
              points={{52,-20},{52,20},{90,0},{52,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}));
    end FixedTemperature;

    model PrescribedTemperature
      "Variable temperature boundary condition in degCelsius"

      Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{
                90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.RealInput T(unit="degC") annotation (Placement(
            transformation(extent={{-140,-20},{-100,20}})));
    equation
      port.T = Modelica.SIunits.Conversions.from_degC(T);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-102,0},{64,0}},
              color={191,0,0},
              thickness=0.5),
            Text(
              extent={{0,0},{-100,-100}},
              textString="degC"),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{-102,0},{64,0}},
              color={191,0,0},
              thickness=0.5),
            Polygon(
              points={{52,-20},{52,20},{90,0},{52,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
This model represents a variable temperature boundary condition
The temperature value in [degC] is given by the input signal
to the model. The effect is that an instance of this model acts as
an infinite reservoir able to absorb or generate as much energy
as required to keep the temperature at the specified value.
</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-102,0},{64,0}},
              color={191,0,0},
              thickness=0.5),
            Text(
              extent={{0,0},{-100,-100}},
              textString="degC"),
            Polygon(
              points={{52,-20},{52,20},{90,0},{52,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}));
    end PrescribedTemperature;

    model TemperatureSensor "Absolute temperature sensor in degCelsius"

      Modelica.Blocks.Interfaces.RealOutput T(unit="degC")
        "Absolute temperature in degree Celsius as output signal"
        annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Interfaces.HeatPort_a port annotation (Placement(transformation(extent={{
                -110,-10},{-90,10}})));
    equation
      T = Modelica.SIunits.Conversions.to_degC(port.T);
      port.Q_flow = 0;
      annotation (defaultComponentName="temperatureSensor",
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Ellipse(
              extent={{-20,-98},{20,-60}},
              lineThickness=0.5,
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-12,40},{12,-68}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{12,0},{90,0}}, color={0,0,255}),
            Line(points={{-94,0},{-12,0}}, color={191,0,0}),
            Polygon(
              points={{-12,40},{-12,80},{-10,86},{-6,88},{0,90},{6,88},{10,86},
                  {12,80},{12,40},{-12,40}},
              lineThickness=0.5),
            Line(
              points={{-12,40},{-12,-64}},
              thickness=0.5),
            Line(
              points={{12,40},{12,-64}},
              thickness=0.5),
            Line(points={{-40,-20},{-12,-20}}),
            Line(points={{-40,20},{-12,20}}),
            Line(points={{-40,60},{-12,60}}),
            Text(
              extent={{102,-22},{60,-74}},
              textString="degC")}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(
              extent={{-20,-98},{20,-60}},
              lineThickness=0.5,
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-12,40},{12,-68}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{12,0},{90,0}}, color={0,0,255}),
            Line(points={{-90,0},{-12,0}}, color={191,0,0}),
            Polygon(
              points={{-12,40},{-12,80},{-10,86},{-6,88},{0,90},{6,88},{10,86},
                  {12,80},{12,40},{-12,40}},
              lineThickness=0.5),
            Line(
              points={{-12,40},{-12,-64}},
              thickness=0.5),
            Line(
              points={{12,40},{12,-64}},
              thickness=0.5),
            Line(points={{-40,-20},{-12,-20}}),
            Line(points={{-40,20},{-12,20}}),
            Line(points={{-40,60},{-12,60}}),
            Text(
              extent={{150,-22},{30,-92}},
              textString="degC"),
            Text(
              extent={{-150,135},{150,95}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
This is an ideal absolute temperature sensor which returns
the temperature of the connected port in Celsius as an output
signal.  The sensor itself has no thermal interaction with
whatever it is connected to.  Furthermore, no
thermocouple-like lags are associated with this
sensor model.
</p>
</html>"));
    end TemperatureSensor;
    annotation (Documentation(info="<html>
<p>
The components of this package are provided for the convenience of
people working mostly with Celsius units, since all models
in package HeatTransfer are based on Kelvin units.
</p>
<p>
Note, that in package SIunits.Conversions, functions are provided
to convert between the units Kelvin, degree Celsius, degree Fahrenheit,
and degree Rankine. These functions allow, e.g., a direct conversion
of units at all places where Kelvin is required as parameter.
Example:
</p>
<pre>
    <strong>import</strong> SIunits.Conversions.*;
    Modelica.Thermal.HeatTransfer.HeatCapacitor C(T0 = from_degC(20));
</pre>
</html>"));
  end Celsius;

  package Fahrenheit "Components with Fahrenheit input and/or output"

    extends Modelica.Icons.VariantsPackage;

    model ToKelvin "Conversion block from degFahrenheit to Kelvin"

      Modelica.Blocks.Interfaces.RealInput Fahrenheit(unit="degF") annotation (Placement(
            transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput Kelvin(unit="K")
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      Kelvin = Modelica.SIunits.Conversions.from_degF(Fahrenheit);
      annotation (
        Diagram(graphics={
            Ellipse(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-40,-50},{-99,-99}},
              textString="degF"),
            Text(
              extent={{100,-47},{44,-100}},
              textString="K"),
            Line(points={{-100,0},{-40,0}}, color={0,0,255}),
            Line(points={{41,0},{100,0}}, color={0,0,255})}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{130,-42},{38,-94}},
              textString="K"),
            Line(points={{-41,0},{-100,0}}, color={0,0,255}),
            Line(points={{100,0},{40,0}}, color={0,0,255}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-42,-44},{-153,-91}},
              textString="degF")}),
        Documentation(info="<html>
<p>
This component converts a input signal from degree Fahrenheit to Kelvin
and provides is as output signal.
</p>
</html>"));
    end ToKelvin;

    model FromKelvin "Conversion from Kelvin to degFahrenheit"
      parameter Integer n=1 "Only kept for backwards compatibility (parameter is not used in the model and will be removed in a future version)" annotation(Dialog(enable=false));
      Modelica.Blocks.Interfaces.RealInput Kelvin(unit="K")
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput Fahrenheit(unit="degF")
     annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      Fahrenheit = Modelica.SIunits.Conversions.to_degF(Kelvin);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Ellipse(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-60,-52},{-144,-96}},
              textString="K"),
            Line(points={{-40,0},{-100,0}}, color={0,0,255}),
            Line(points={{40,0},{100,0}}, color={0,0,255}),
            Text(
              extent={{138,-52},{27,-99}},
              textString="degF")}),
        Diagram(graphics={
            Ellipse(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-42,-41},{-101,-98}},
              textString="K"),
            Text(
              extent={{100,-40},{30,-100}},
              textString="degF"),
            Line(points={{-100,0},{-40,0}}, color={0,0,255}),
            Line(points={{40,0},{100,0}}, color={0,0,255})}),
        Documentation(info="<html>
<p>
This component converts all input signals from Kelvin to Fahrenheit
and provides them as output signals.
</p>
</html>"));
    end FromKelvin;

    model FixedTemperature
      "Fixed temperature boundary condition in degFahrenheit"
      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degF T
        "Fixed Temperature at the port";
      Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{
                90,-10},{110,10}})));
    equation
      port.T = Modelica.SIunits.Conversions.from_degF(T);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Rectangle(
              extent={{-100,100},{100,-100}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Text(
              extent={{0,0},{-100,-100}},
              textString="degF"),
            Polygon(
              points={{52,-20},{52,20},{90,0},{52,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,-110},{150,-140}},
              textString="T=%T"),
            Line(
              points={{-42,0},{66,0}},
              color={191,0,0},
              thickness=0.5)}),
        Documentation(info="<html>
<p>
This model defines a fixed temperature T at its port in [degF],
i.e., it defines a fixed temperature as a boundary condition.
</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-42,0},{66,0}},
              color={191,0,0},
              thickness=0.5),
            Text(
              extent={{0,0},{-100,-100}},
              textString="degF"),
            Polygon(
              points={{52,-20},{52,20},{90,0},{52,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}));
    end FixedTemperature;

    model PrescribedTemperature
      "Variable temperature boundary condition in degFahrenheit"

      Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{
                90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.RealInput T(unit="degF")
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    equation
      port.T = Modelica.SIunits.Conversions.from_degF(T);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-102,0},{64,0}},
              color={191,0,0},
              thickness=0.5),
            Text(
              extent={{0,0},{-100,-100}},
              textString="degF"),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{-102,0},{64,0}},
              color={191,0,0},
              thickness=0.5),
            Polygon(
              points={{52,-20},{52,20},{90,0},{52,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
This model represents a variable temperature boundary condition
The temperature value in [degF] is given by the input signal
to the model. The effect is that an instance of this model acts as
an infinite reservoir able to absorb or generate as much energy
as required to keep the temperature at the specified value.
</p>
</html>"), Diagram(graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-102,0},{64,0}},
              color={191,0,0},
              thickness=0.5),
            Text(
              extent={{0,0},{-100,-100}},
              textString="degF"),
            Polygon(
              points={{52,-20},{52,20},{90,0},{52,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}));
    end PrescribedTemperature;

    model TemperatureSensor "Absolute temperature sensor in degFahrenheit"

      Modelica.Blocks.Interfaces.RealOutput T annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Interfaces.HeatPort_a port annotation (Placement(transformation(extent={{
                -110,-10},{-90,10}})));
    equation
      T = Modelica.SIunits.Conversions.to_degF(port.T);
      port.Q_flow = 0;
      annotation (
        Diagram(graphics={
            Ellipse(
              extent={{-20,-98},{20,-60}},
              lineThickness=0.5,
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-12,40},{12,-68}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{12,0},{90,0}}, color={0,0,255}),
            Line(points={{-94,0},{-12,0}}, color={191,0,0}),
            Polygon(
              points={{-12,40},{-12,80},{-10,86},{-6,88},{0,90},{6,88},{10,86},
                  {12,80},{12,40},{-12,40}},
              lineThickness=0.5),
            Line(
              points={{-12,40},{-12,-64}},
              thickness=0.5),
            Line(
              points={{12,40},{12,-64}},
              thickness=0.5),
            Line(points={{-40,-20},{-12,-20}}),
            Line(points={{-40,20},{-12,20}}),
            Line(points={{-40,60},{-12,60}}),
            Text(
              extent={{102,-22},{60,-74}},
              textString="degF")}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(
              extent={{-20,-98},{20,-60}},
              lineThickness=0.5,
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-12,40},{12,-68}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{12,0},{90,0}}, color={0,0,255}),
            Line(points={{-90,0},{-12,0}}, color={191,0,0}),
            Polygon(
              points={{-12,40},{-12,80},{-10,86},{-6,88},{0,90},{6,88},{10,86},
                  {12,80},{12,40},{-12,40}},
              lineThickness=0.5),
            Line(
              points={{-12,40},{-12,-64}},
              thickness=0.5),
            Line(
              points={{12,40},{12,-64}},
              thickness=0.5),
            Line(points={{-40,-20},{-12,-20}}),
            Line(points={{-40,20},{-12,20}}),
            Line(points={{-40,60},{-12,60}}),
            Text(
              extent={{150,-22},{30,-92}},
              textString="degF"),
            Text(
              extent={{-150,135},{150,95}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
This is an ideal absolute temperature sensor which returns
the temperature of the connected port in Fahrenheit as an output
signal.  The sensor itself has no thermal interaction with
whatever it is connected to.  Furthermore, no
thermocouple-like lags are associated with this
sensor model.
</p>
</html>"));
    end TemperatureSensor;
    annotation (Documentation(info="<html>
<p>
The components of this package are provided for the convenience of
people working mostly with Fahrenheit units, since all models
in package HeatTransfer are based on Kelvin units.
</p>
<p>
Note, that in package SIunits.Conversions, functions are provided
to convert between the units Kelvin, degree Celsius, degree Fahrenheit
and degree Rankine. These functions allow, e.g., a direct conversion
of units at all places where Kelvin is required as parameter.
Example:
</p>
<pre>
    <strong>import</strong> SIunits.Conversions.*;
    Modelica.Thermal.HeatTransfer.HeatCapacitor C(T0 = from_degF(70));
</pre>
</html>"));
  end Fahrenheit;

  package Rankine "Components with Rankine input and/or output"

    extends Modelica.Icons.VariantsPackage;

    model ToKelvin "Conversion block from degRankine to Kelvin"
      parameter Integer n=1 "Only kept for backwards compatibility (parameter is not used in the model and will be removed in a future version)" annotation(Dialog(enable=false));
      Modelica.Blocks.Interfaces.RealInput Rankine(unit="degRk")
       annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput Kelvin(unit="K")
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      Kelvin = Modelica.SIunits.Conversions.from_degRk(Rankine);
      annotation (
        Diagram(graphics={
            Ellipse(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-40,-50},{-99,-99}},
              textString="degRk"),
            Text(
              extent={{100,-47},{44,-100}},
              textString="K"),
            Line(points={{-100,0},{-40,0}}, color={0,0,255}),
            Line(points={{41,0},{100,0}}, color={0,0,255})}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{140,-38},{56,-94}},
              textString="K"),
            Text(
              extent={{-44,-42},{-155,-89}},
              textString="degRk"),
            Line(points={{-41,0},{-100,0}}, color={0,0,255}),
            Line(points={{100,0},{40,0}}, color={0,0,255}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
This component converts all input signals from degree Rankine to Kelvin
and provides them as output signals.
</p>
</html>"));
    end ToKelvin;

    model FromKelvin "Conversion from Kelvin to degRankine"
      parameter Integer n=1 "Only kept for backwards compatibility (parameter is not used in the model and will be removed in a future version)" annotation(Dialog(enable=false));
      Modelica.Blocks.Interfaces.RealInput Kelvin(unit="K")
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput Rankine(unit="degRk")
         annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      Rankine = Modelica.SIunits.Conversions.to_degRk(Kelvin);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Ellipse(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-54,-38},{-162,-90}},
              textString="K"),
            Text(
              extent={{142,-48},{26,-91}},
              textString="degRk"),
            Line(points={{-40,0},{-100,0}}, color={0,0,255}),
            Line(points={{40,0},{100,0}}, color={0,0,255})}),
        Diagram(graphics={
            Ellipse(
              extent={{-40,40},{40,-40}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-42,-41},{-101,-98}},
              textString="K"),
            Text(
              extent={{100,-40},{30,-100}},
              textString="degRk"),
            Line(points={{-100,0},{-40,0}}, color={0,0,255}),
            Line(points={{40,0},{100,0}}, color={0,0,255})}),
        Documentation(info="<html>
<p>
This component converts all input signals from Kelvin to Rankine
and provides them as output signals.
</p>
</html>"));
    end FromKelvin;

    model FixedTemperature "Fixed temperature boundary condition in degRankine"

      parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degRk T
        "Fixed Temperature at the port";
      Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{
                90,-10},{110,10}})));
    equation
      port.T = Modelica.SIunits.Conversions.from_degRk(T);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-118,165},{122,105}},
              textString="%name",
              lineColor={0,0,255}),
            Rectangle(
              extent={{-100,100},{100,-100}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Text(
              extent={{48,-22},{-100,-86}},
              textString="degRk"),
            Polygon(
              points={{52,-20},{52,20},{90,0},{52,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,-110},{150,-150}},
              textString="T=%T"),
            Line(
              points={{-42,0},{66,0}},
              color={191,0,0},
              thickness=0.5)}),
        Documentation(info="<html>
<p>
This model defines a fixed temperature T at its port in degree Rankine,
[degRk], i.e., it defines a fixed temperature as a boundary condition.
</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-42,0},{66,0}},
              color={191,0,0},
              thickness=0.5),
            Text(
              extent={{0,0},{-100,-100}},
              textString="degRk"),
            Polygon(
              points={{52,-20},{52,20},{90,0},{52,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}));
    end FixedTemperature;

    model PrescribedTemperature
      "Variable temperature boundary condition in degRankine"

      Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{
                90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.RealInput T(unit="degRk")
         annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    equation
      port.T = Modelica.SIunits.Conversions.from_degRk(T);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-102,0},{64,0}},
              color={191,0,0},
              thickness=0.5),
            Text(
              extent={{56,-34},{-100,-100}},
              textString="degRk"),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{-102,0},{64,0}},
              color={191,0,0},
              thickness=0.5),
            Polygon(
              points={{52,-20},{52,20},{90,0},{52,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
This model represents a variable temperature boundary condition
The temperature value in degree Rankine, [degRk] is given by the input signal
to the model. The effect is that an instance of this model acts as
an infinite reservoir able to absorb or generate as much energy
as required to keep the temperature at the specified value.
</p>
</html>"), Diagram(graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              pattern=LinePattern.None,
              fillColor={159,159,223},
              fillPattern=FillPattern.Backward),
            Line(
              points={{-102,0},{64,0}},
              color={191,0,0},
              thickness=0.5),
            Text(
              extent={{0,0},{-100,-100}},
              textString="degRk"),
            Polygon(
              points={{52,-20},{52,20},{90,0},{52,-20}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}));
    end PrescribedTemperature;

    model TemperatureSensor "Absolute temperature sensor in degRankine"

      Modelica.Blocks.Interfaces.RealOutput T annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Interfaces.HeatPort_a port annotation (Placement(transformation(extent={{
                -110,-10},{-90,10}})));
    equation
      T = Modelica.SIunits.Conversions.to_degRk(port.T);
      port.Q_flow = 0;
      annotation (
        Diagram(graphics={
            Ellipse(
              extent={{-20,-98},{20,-60}},
              lineThickness=0.5,
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-12,40},{12,-68}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{12,0},{90,0}}, color={0,0,255}),
            Line(points={{-94,0},{-12,0}}, color={191,0,0}),
            Polygon(
              points={{-12,40},{-12,80},{-10,86},{-6,88},{0,90},{6,88},{10,86},
                  {12,80},{12,40},{-12,40}},
              lineThickness=0.5),
            Line(
              points={{-12,40},{-12,-64}},
              thickness=0.5),
            Line(
              points={{12,40},{12,-64}},
              thickness=0.5),
            Line(points={{-40,-20},{-12,-20}}),
            Line(points={{-40,20},{-12,20}}),
            Line(points={{-40,60},{-12,60}}),
            Text(
              extent={{102,-22},{60,-74}},
              textString="degRk")}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(
              extent={{-20,-98},{20,-60}},
              lineThickness=0.5,
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-12,40},{12,-68}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{12,0},{90,0}}, color={0,0,255}),
            Line(points={{-90,0},{-12,0}}, color={191,0,0}),
            Polygon(
              points={{-12,40},{-12,80},{-10,86},{-6,88},{0,90},{6,88},{10,86},
                  {12,80},{12,40},{-12,40}},
              lineThickness=0.5),
            Line(
              points={{-12,40},{-12,-64}},
              thickness=0.5),
            Line(
              points={{12,40},{12,-64}},
              thickness=0.5),
            Line(points={{-40,-20},{-12,-20}}),
            Line(points={{-40,20},{-12,20}}),
            Line(points={{-40,60},{-12,60}}),
            Text(
              extent={{144,-34},{32,-82}},
              textString="degRk"),
            Text(
              extent={{-150,135},{150,95}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
This is an ideal absolute temperature sensor which returns
the temperature of the connected port in Rankine as an output
signal.  The sensor itself has no thermal interaction with
whatever it is connected to.  Furthermore, no
thermocouple-like lags are associated with this
sensor model.
</p>
</html>"));
    end TemperatureSensor;
    annotation (Documentation(info="<html>
<p>
The components of this package are provided for the convenience of
people working mostly with Rankine units, since all models
in package HeatTransfer are based on Kelvin units.
</p>
<p>
Note, that in package SIunits.Conversions, functions are provided
to convert between the units Kelvin, degree Celsius, degree Fahrenheit
and degree Rankine. These functions allow, e.g., a direct conversion
of units at all places where Kelvin is required as parameter.
Example:
</p>
<pre>
    <strong>import</strong> SIunits.Conversions.*;
    Modelica.Thermal.HeatTransfer.HeatCapacitor C(T0 = from_degRk(500));
</pre>
</html>"));
  end Rankine;

  package Interfaces "Connectors and partial models"

    extends Modelica.Icons.InterfacesPackage;

    partial connector HeatPort "Thermal port for 1-dim. heat transfer"
      Modelica.SIunits.Temperature T "Port temperature";
      flow Modelica.SIunits.HeatFlowRate Q_flow
        "Heat flow rate (positive if flowing from outside into the component)";
      annotation (Documentation(info="<html>

</html>"));
    end HeatPort;

    connector HeatPort_a
      "Thermal port for 1-dim. heat transfer (filled rectangular icon)"

      extends HeatPort;

      annotation(defaultComponentName = "port_a",
        Documentation(info="<html>
<p>This connector is used for 1-dimensional heat flow between components.
The variables in the connector are:</p>
<pre>
   T       Temperature in [Kelvin].
   Q_flow  Heat flow rate in [Watt].
</pre>
<p>According to the Modelica sign convention, a <strong>positive</strong> heat flow
rate <strong>Q_flow</strong> is considered to flow <strong>into</strong> a component. This
convention has to be used whenever this connector is used in a model
class.</p>
<p>Note, that the two connector classes <strong>HeatPort_a</strong> and
<strong>HeatPort_b</strong> are identical with the only exception of the different
<strong>icon layout</strong>.</p></html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Rectangle(
              extent={{-50,50},{50,-50}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-120,120},{100,60}},
              lineColor={191,0,0},
              textString="%name")}));
    end HeatPort_a;

    connector HeatPort_b
      "Thermal port for 1-dim. heat transfer (unfilled rectangular icon)"

      extends HeatPort;

      annotation(defaultComponentName = "port_b",
        Documentation(info="<html>
<p>This connector is used for 1-dimensional heat flow between components.
The variables in the connector are:</p>
<pre>
   T       Temperature in [Kelvin].
   Q_flow  Heat flow rate in [Watt].
</pre>
<p>According to the Modelica sign convention, a <strong>positive</strong> heat flow
rate <strong>Q_flow</strong> is considered to flow <strong>into</strong> a component. This
convention has to be used whenever this connector is used in a model
class.</p>
<p>Note, that the two connector classes <strong>HeatPort_a</strong> and
<strong>HeatPort_b</strong> are identical with the only exception of the different
<strong>icon layout</strong>.</p></html>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Rectangle(
              extent={{-50,50},{50,-50}},
              lineColor={191,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-100,120},{120,60}},
              lineColor={191,0,0},
              textString="%name")}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={191,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
    end HeatPort_b;

    partial model Element1D
      "Partial heat transfer element with two HeatPort connectors that does not store energy"

      Modelica.SIunits.HeatFlowRate Q_flow
        "Heat flow rate from port_a -> port_b";
      Modelica.SIunits.TemperatureDifference dT "port_a.T - port_b.T";
    public
      HeatPort_a port_a annotation (Placement(transformation(extent={{-110,-10},
                {-90,10}})));
      HeatPort_b port_b annotation (Placement(transformation(extent={{90,-10},{
                110,10}})));
    equation
      dT = port_a.T - port_b.T;
      port_a.Q_flow = Q_flow;
      port_b.Q_flow = -Q_flow;
      annotation (Documentation(info="<html>
<p>
This partial model contains the basic connectors and variables to
allow heat transfer models to be created that <strong>do not store energy</strong>,
This model defines and includes equations for the temperature
drop across the element, <strong>dT</strong>, and the heat flow rate
through the element from port_a to port_b, <strong>Q_flow</strong>.
</p>
<p>
By extending this model, it is possible to write simple
constitutive equations for many types of heat transfer components.
</p>
</html>"));
    end Element1D;

    partial model PartialElementaryConditionalHeatPort
      "Partial model to include a conditional HeatPort in order to dissipate losses, used for textual modeling, i.e., for elementary models"
      parameter Boolean useHeatPort = false "=true, if heatPort is enabled"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Modelica.SIunits.Temperature T=293.15
        "Fixed device temperature if useHeatPort = false"
        annotation(Dialog(enable=not useHeatPort));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(
        final T=TheatPort,
        final Q_flow=-lossPower) if useHeatPort
        "Optional port to which dissipated losses are transported in form of heat"
        annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
         iconTransformation(extent={{-110,-110},{-90,-90}})));
      Modelica.SIunits.Power lossPower
        "Loss power leaving component via heatPort (> 0, if heat is flowing out of component)";
      Modelica.SIunits.Temperature TheatPort "Temperature of heatPort";
    equation
      if not useHeatPort then
         TheatPort = T;
      end if;
      annotation (Documentation(info="<html>
<p>
This partial model provides a conditional heat port for dissipating losses.
</p>
<ul>
<li>If <strong>useHeatPort</strong> is set to <strong>false</strong> (default), no heat port is available, and the thermal loss power is dissipated internally.
In this case, the parameter <strong>T</strong> specifies the fixed device temperature (the default for T = 20&deg;C)</li>
<li>If <strong>useHeatPort</strong> is set to <strong>true</strong>, the heat port is available.</li>
</ul>
<p>
If this model is used, the loss power has to be provided by an equation in the model which inherits from PartialElementaryConditionalHeatPort model
(<strong>lossPower = ...</strong>). The device temperature <strong>TheatPort</strong> can be used to describe the influence of the device temperature on the model behaviour.
</p>
</html>"));
    end PartialElementaryConditionalHeatPort;

    partial model PartialElementaryConditionalHeatPortWithoutT
      "Partial model to include a conditional HeatPort in order to dissipate losses, used for textual modeling, i.e., for elementary models"
      parameter Boolean useHeatPort = false "=true, if heatPort is enabled"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(
        final Q_flow=-lossPower) if useHeatPort
        "Optional port to which dissipated losses are transported in form of heat"
        annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
         iconTransformation(extent={{-110,-110},{-90,-90}})));
      Modelica.SIunits.Power lossPower
        "Loss power leaving component via heatPort (> 0, if heat is flowing out of component)";
      annotation (Documentation(info="<html>
<p>
This partial model provides a conditional heat port for dissipating losses.
</p>
<ul>
<li>If <strong>useHeatPort</strong> is set to <strong>false</strong> (default), no heat port is available, and the thermal loss power is dissipated internally.</li>
<li>If <strong>useHeatPort</strong> is set to <strong>true</strong>, the heat port is available and must be connected from the outside.</li>
</ul>
<p>
If this model is used, the loss power has to be provided by an equation in the model which inherits from the PartialElementaryConditionalHeatPortWithoutT model
(<strong>lossPower = ...</strong>).
</p>

<p>
Note, this partial model is used in cases, where heatPort.T (that is the device temperature) is not utilized in the model. If this is desired, inherit instead from partial model
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort\">PartialElementaryConditionalHeatPort</a>.
</p>
</html>"));
    end PartialElementaryConditionalHeatPortWithoutT;

    partial model PartialConditionalHeatPort
      "Partial model to include a conditional HeatPort in order to dissipate losses, used for graphical modeling, i.e., for building models by drag-and-drop"
      parameter Boolean useHeatPort = false "=true, if HeatPort is enabled"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Modelica.SIunits.Temperature T=293.15
        "Fixed device temperature if useHeatPort = false"
        annotation(Dialog(enable=not useHeatPort));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
        "Optional port to which dissipated losses are transported in form of heat"
        annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
            iconTransformation(extent={{-110,-110},{-90,-90}})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(final T=T) if not useHeatPort
        annotation (Placement(transformation(extent={{-60,-90},{-80,-70}})));
    protected
      HeatPort_a internalHeatPort
        annotation (Placement(transformation(extent={{-104,-84},{-96,-76}})));
    equation
      connect(heatPort, internalHeatPort) annotation (Line(
          points={{-100,-100},{-100,-80}}, color={191,0,0}));
      connect(fixedTemperature.port, internalHeatPort) annotation (Line(
          points={{-80,-80},{-100,-80}}, color={191,0,0}));
      annotation (Documentation(info="<html>
<p>
This partial model provides a conditional heat port for dissipating losses.
</p>
<ul>
<li>If <strong>useHeatPort</strong> is set to <strong>false</strong> (default), no heat port is available, and the thermal loss power is dissipated internally.
In this case, the parameter <strong>T</strong> specifies the fixed device temperature (the default for T = 20&deg;C)</li>
<li>If <strong>useHeatPort</strong> is set to <strong>true</strong>, the heat port is available.</li>
</ul>
<p>
If this model is used, the <strong>internalHeatPort</strong> has to be connected in the model which inherits from PartialElementaryConditionalHeatPort model.
The device temperature <strong>internalHeatPort.T</strong> can be used to describe the influence of the device temperature on the model behaviour.
</p>
</html>"));
    end PartialConditionalHeatPort;
    annotation (Documentation(info="<html>

</html>"));
  end Interfaces;
  annotation (
     Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={
      Polygon(
        origin = {13.758,27.517},
        lineColor = {128,128,128},
        fillColor = {192,192,192},
        fillPattern = FillPattern.Solid,
        points = {{-54,-6},{-61,-7},{-75,-15},{-79,-24},{-80,-34},{-78,-42},{-73,-49},{-64,-51},{-57,-51},{-47,-50},{-41,-43},{-38,-35},{-40,-27},{-40,-20},{-42,-13},{-47,-7},{-54,-5},{-54,-6}}),
    Polygon(
        origin = {13.758,27.517},
        fillColor = {160,160,164},
        fillPattern = FillPattern.Solid,
        points = {{-75,-15},{-79,-25},{-80,-34},{-78,-42},{-72,-49},{-64,-51},{-57,-51},{-47,-50},{-57,-47},{-65,-45},{-71,-40},{-74,-33},{-76,-23},{-75,-15},{-75,-15}}),
      Polygon(
        origin = {13.758,27.517},
        lineColor = {160,160,164},
        fillColor = {192,192,192},
        fillPattern = FillPattern.Solid,
        points = {{39,-6},{32,-7},{18,-15},{14,-24},{13,-34},{15,-42},{20,-49},{29,-51},{36,-51},{46,-50},{52,-43},{55,-35},{53,-27},{53,-20},{51,-13},{46,-7},{39,-5},{39,-6}}),
      Polygon(
        origin = {13.758,27.517},
        fillColor = {160,160,164},
        fillPattern = FillPattern.Solid,
        points = {{18,-15},{14,-25},{13,-34},{15,-42},{21,-49},{29,-51},{36,-51},{46,-50},{36,-47},{28,-45},{22,-40},{19,-33},{17,-23},{18,-15},{18,-15}}),
      Polygon(
        origin = {13.758,27.517},
        lineColor = {191,0,0},
        fillColor = {191,0,0},
        fillPattern = FillPattern.Solid,
        points = {{-9,-23},{-9,-10},{18,-17},{-9,-23}}),
      Line(
        origin = {13.758,27.517},
        points = {{-41,-17},{-9,-17}},
        color = {191,0,0},
        thickness = 0.5),
      Line(
        origin = {13.758,27.517},
        points = {{-17,-40},{15,-40}},
        color = {191,0,0},
        thickness = 0.5),
      Polygon(
        origin = {13.758,27.517},
        lineColor = {191,0,0},
        fillColor = {191,0,0},
        fillPattern = FillPattern.Solid,
        points = {{-17,-46},{-17,-34},{-40,-40},{-17,-46}})}),
                            Documentation(info="<html>
<p>
This package contains components to model <strong>1-dimensional heat transfer</strong>
with lumped elements. This allows especially to model heat transfer in
machines provided the parameters of the lumped elements, such as
the heat capacity of a part, can be determined by measurements
(due to the complex geometries and many materials used in machines,
calculating the lumped element parameters from some basic analytic
formulas is usually not possible).
</p>
<p>
Example models how to use this library are given in subpackage <strong>Examples</strong>.<br>
For a first simple example, see <strong>Examples.TwoMasses</strong> where two masses
with different initial temperatures are getting in contact to each
other and arriving after some time at a common temperature.<br>
<strong>Examples.ControlledTemperature</strong> shows how to hold a temperature
within desired limits by switching on and off an electric resistor.<br>
A more realistic example is provided in <strong>Examples.Motor</strong> where the
heating of an electrical motor is modelled, see the following screen shot
of this example:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Thermal/HeatTransfer/driveWithHeatTransfer.png\" alt=\"driveWithHeatTransfer\">
</p>

<p>
The <strong>filled</strong> and <strong>non-filled red squares</strong> at the left and
right side of a component represent <strong>thermal ports</strong> (connector HeatPort).
Drawing a line between such squares means that they are thermally connected.
The variables of a HeatPort connector are the temperature <strong>T</strong> at the port
and the heat flow rate <strong>Q_flow</strong> flowing into the component (if Q_flow is positive,
the heat flows into the element, otherwise it flows out of the element):
</p>
<pre>   Modelica.SIunits.Temperature  T  \"absolute temperature at port in Kelvin\";
   Modelica.SIunits.HeatFlowRate Q_flow  \"flow rate at the port in Watt\";
</pre>
<p>
Note, that all temperatures of this package, including initial conditions,
are given in Kelvin. For convenience, in subpackages <strong>HeatTransfer.Celsius</strong>,
 <strong>HeatTransfer.Fahrenheit</strong> and <strong>HeatTransfer.Rankine</strong> components are provided such that source and
sensor information is available in degree Celsius, degree Fahrenheit, or degree Rankine,
respectively. Additionally, in package <strong>SIunits.Conversions</strong> conversion
functions between the units Kelvin and Celsius, Fahrenheit, Rankine are
provided. These functions may be used in the following way:
</p>
<pre>  <strong>import</strong> SI=Modelica.SIunits;
  <strong>import</strong> Modelica.SIunits.Conversions.*;
     ...
  <strong>parameter</strong> SI.Temperature T = from_degC(25);  // convert 25 degree Celsius to Kelvin
</pre>

<p>
There are several other components available, such as AxialConduction (discretized PDE in
axial direction), which have been temporarily removed from this library. The reason is that
these components reference material properties, such as thermal conductivity, and currently
the Modelica design group is discussing a general scheme to describe material properties.
</p>
<p>
For technical details in the design of this library, see the following reference:<br>
<strong>Michael Tiller (2001)</strong>: <a href=\"http://www.amazon.de\">
Introduction to Physical Modeling with Modelica</a>.
Kluwer Academic Publishers Boston.
</p>
<p>
<strong>Acknowledgements:</strong><br>
Several helpful remarks from the following persons are acknowledged:
John Batteh, Ford Motors, Dearborn, U.S.A;
<a href=\"https://www.haumer.at/\">Anton Haumer</a>, Technical Consulting &amp; Electrical Engineering, Germany;
Ludwig Marvan, VA TECH ELIN EBG Elektronik GmbH, Wien, Austria;
Hans Olsson, Dassault Syst&egrave;mes AB, Sweden;
Hubertus Tummescheit, Lund Institute of Technology, Lund, Sweden.
</p>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <p>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg, Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
</p>
  </dd>
</dl>
<p><strong>Copyright &copy; 2001-2018, Modelica Association, Michael Tiller and DLR.</strong></p>

<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>", revisions="<html>
<ul>
<li><em>July 15, 2002</em>
       by Michael Tiller, <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Nikolaus Sch&uuml;rmann:<br>
       Implemented.
</li>
<li><em>June 13, 2005</em>
       by <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
       Refined placing of connectors (cosmetic).<br>
       Refined all Examples; removed Examples.FrequencyInverter, introducing Examples.Motor<br>
       Introduced temperature dependent correction (1 + alpha*(T - T_ref)) in Fixed/PrescribedHeatFlow<br>
</li>
  <li> v1.1.1 2007/11/13 Anton Haumer<br>
       components moved to sub-packages</li>
  <li> v1.2.0 2009/08/26 Anton Haumer<br>
       added component ThermalCollector</li>

</ul>
</html>"));
end HeatTransfer;
