within Modelica.Fluid.Examples;
package DrumBoiler
  "Drum boiler example, see Franke, Rode, Krueger: On-line Optimization of Drum Boiler Startup, 3rd International Modelica Conference, Linkoping, 2003"

  model DrumBoiler
    "Complete drum boiler model, including evaporator and supplementary components"
     extends Modelica.Icons.Example;
    import Modelica.SIunits.Conversions.*;

    Modelica.Fluid.Examples.DrumBoiler.BaseClasses.EquilibriumDrumBoiler
      evaporator(
      m_D=300e3,
      cp_D=500,
      V_t=100,
      V_l_start=67,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      p_start=100000)     annotation (Placement(transformation(extent={{-46,-30},
              {-26,-10}}, rotation=0)));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow furnace
      annotation (Placement(transformation(
          origin={-36,-53},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Fluid.Sources.FixedBoundary sink(nPorts=1, p=from_bar(0.5),
      redeclare package Medium = Modelica.Media.Water.StandardWaterOnePhase,
      T=500)
      annotation (Placement(transformation(
          origin={90,-20},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    Modelica.Fluid.Sensors.MassFlowRate massFlowRate(           redeclare
        package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(
          origin={30,-20},
          extent={{10,10},{-10,-10}},
          rotation=180)));
    Modelica.Fluid.Sensors.Temperature temperature(    redeclare package Medium
        = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(
          origin={-3,-1},
          extent={{10,10},{-10,-10}},
          rotation=180)));
    Modelica.Fluid.Sensors.Pressure pressure(           redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{10,14},{30,34}}, rotation=0)));
    Modelica.Blocks.Continuous.PI controller(T=120, k=10)
      annotation (Placement(transformation(extent={{-51,23},{-65,37}}, rotation=
             0)));
    Modelica.Fluid.Sources.MassFlowSource_h pump(nPorts=1,
                                             h=5e5, redeclare package Medium =
          Modelica.Media.Water.StandardWater,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{-80,-30},{-60,-10}},
            rotation=0)));
    Modelica.Blocks.Math.Feedback feedback
      annotation (Placement(transformation(extent={{-26,20},{-46,40}}, rotation=
             0)));
    Modelica.Blocks.Sources.Constant levelSetPoint(k=67)
      annotation (Placement(transformation(extent={{-43,50},{-30,63}}, rotation=
             0)));
    Modelica.Blocks.Interfaces.RealOutput T_S
      annotation (Placement(transformation(extent={{100,56},{108,64}}, rotation=
             0)));
    Modelica.Blocks.Interfaces.RealOutput p_S
      annotation (Placement(transformation(extent={{100,20},{108,28}}, rotation=
             0)));
    Modelica.Blocks.Interfaces.RealOutput qm_S
      annotation (Placement(transformation(extent={{100,-4},{108,4}}, rotation=
              0)));
    Modelica.Blocks.Interfaces.RealOutput V_l
      annotation (Placement(transformation(extent={{100,88},{108,96}}, rotation=
             0)));
  public
    Modelica.Blocks.Math.Gain MW2W(k=1e6)
      annotation (Placement(transformation(extent={{-60,-75.5},{-50,-64.5}},
            rotation=0)));
    Modelica.Blocks.Math.Gain Pa2bar(k=1e-5) annotation (Placement(
          transformation(extent={{37,19},{47,29}}, rotation=0)));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin K2degC
      annotation (Placement(transformation(extent={{38,55},{48,65}}, rotation=0)));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMin=0, uMax=500)
      annotation (Placement(transformation(
          origin={-78,30},
          extent={{-7,-7},{7,7}},
          rotation=180)));
    Modelica.Fluid.Valves.ValveLinear SteamValve(                  redeclare
        package Medium =
          Modelica.Media.Water.StandardWater,
      dp_nominal=9000000,
      m_flow_nominal=180)
      annotation (Placement(transformation(extent={{50,-10},{70,-30}}, rotation=
             0)));

    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
    Modelica.Blocks.Sources.TimeTable q_F_Tab(table=[0, 0; 3600, 400; 7210,
          400]) annotation (Placement(transformation(extent={{-90,-80},{-70,-60}},
            rotation=0)));
    Modelica.Blocks.Sources.TimeTable Y_Valve_Tab(table=[0,0; 900,1; 7210,1])
               annotation (Placement(transformation(extent={{20,-80},{40,-60}},
            rotation=0)));
  equation
    connect(furnace.port, evaporator.heatPort)
      annotation (Line(points={{-36,-43},{-36,-30}}, color={191,0,0}));
    connect(controller.u,feedback.y)
      annotation (Line(points={{-49.6,30},{-45,30}}, color={0,0,127}));
    connect(feedback.u2,      evaporator.V)
      annotation (Line(points={{-36,22},{-36,-9},{-26,-9}}, color={0,0,127}));
    connect(levelSetPoint.y,feedback.u1)             annotation (Line(points={{
            -29.35,56.5},{-22,56.5},{-22,30},{-28,30}}, color={0,0,127}));
    connect(massFlowRate.m_flow, qm_S)
      annotation (Line(points={{30,-9},{30,0},{104,0}}, color={0,0,127}));
    connect(evaporator.V, V_l)
      annotation (Line(points={{-26,-9},{-26,11},{-15,11},{-15,92},{104,92}},
          color={0,0,127}));
    connect(MW2W.y,furnace.Q_flow)       annotation (Line(points={{-49.5,-70},{
            -36,-70},{-36,-63}}, color={0,0,127}));
    connect(pressure.p, Pa2bar.u)
      annotation (Line(points={{31,24},{36,24}}, color={0,0,127}));
    connect(Pa2bar.y, p_S)
      annotation (Line(points={{47.5,24},{104,24}}, color={0,0,127}));
    connect(K2degC.Celsius, T_S) annotation (Line(points={{48.5,60},{104,60}},
          color={0,0,127}));
    connect(controller.y, limiter.u) annotation (Line(points={{-65.7,30},{-69.6,
            30}}, color={0,0,127}));
    connect(limiter.y, pump.m_flow_in) annotation (Line(points={{-85.7,30},{-90,
            30},{-90,-12},{-80,-12}},   color={0,0,127}));
    connect(temperature.T, K2degC.Kelvin) annotation (Line(points={{4,-1},{4,-1},
            {10,-1},{10,60},{37,60}},
                              color={0,0,127}));
    connect(pressure.port, massFlowRate.port_a) annotation (Line(points={{20,14},
            {20,-20}}, color={0,127,255}));
    connect(pump.ports[1], evaporator.port_a) annotation (Line(points={{-60,-20},
            {-46,-20}}, color={0,127,255}));
    connect(massFlowRate.port_b, SteamValve.port_a) annotation (Line(points={{
            40,-20},{50,-20}}, color={0,127,255}));
    connect(SteamValve.port_b, sink.ports[1]) annotation (Line(points={{70,-20},{75,
            -20},{80,-20}},          color={0,127,255}));
    connect(evaporator.port_b, massFlowRate.port_a) annotation (Line(points={{
            -26,-20},{20,-20}}, color={0,127,255}));
    connect(temperature.port, massFlowRate.port_a) annotation (Line(
        points={{-3,-11},{-3,-20},{20,-20}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(q_F_Tab.y, MW2W.u) annotation (Line(
        points={{-69,-70},{-61,-70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Y_Valve_Tab.y, SteamValve.opening) annotation (Line(
        points={{41,-70},{60,-70},{60,-28}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-151,165},{138,102}},
            lineColor={0,0,255},
            textString="%name"),
          Text(
            extent={{-79,67},{67,21}},
            lineColor={0,0,0},
            textString="drum"),
          Text(
            extent={{-90,-14},{88,-64}},
            lineColor={0,0,0},
            textString="boiler")}),
      experiment(StopTime=5400),
      Documentation(info="<html>
<p align=\"center\">
<img src=\"../Images/Fluid/Examples/DrumBoiler.png\" border=\"1\">
</p>
</html>"));
  end DrumBoiler;

  package BaseClasses "Additional components for drum boiler example"
    extends Modelica.Fluid.Icons.BaseClassLibrary;

    model EquilibriumDrumBoiler
      "Simple Evaporator with two states, see Astroem, Bell: Drum-boiler dynamics, Automatica 36, 2000, pp.363-378"
      extends Modelica.Fluid.Interfaces.PartialTwoPort(
        final port_a_exposesState=true,
        final port_b_exposesState=true,
        redeclare replaceable package Medium =
            Modelica.Media.Water.StandardWater
            constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium);
      import Modelica.SIunits.Conversions.*;
      import Modelica.Constants;
      import Modelica.Fluid.Types;

      parameter SI.Mass m_D "mass of surrounding drum metal";
      parameter Medium.SpecificHeatCapacity cp_D
        "specific heat capacity of drum metal";
      parameter SI.Volume V_t "total volume inside drum";
      parameter Medium.AbsolutePressure p_start=system.p_start
        "Start value of pressure"
      annotation(Dialog(tab = "Initialization"));
      parameter SI.Volume V_l_start=V_t/2
        "Start value of liquid volumeStart value of volume"
      annotation(Dialog(tab = "Initialization"));

      // Assumptions
      parameter Boolean allowFlowReversal = system.allowFlowReversal
        "allow flow reversal, false restricts to design direction (port_a -> port_b)"
        annotation(Dialog(tab="Assumptions"), Evaluate=true);
      parameter Types.Dynamics energyDynamics=system.energyDynamics
        "Formulation of energy balance"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
      parameter Types.Dynamics massDynamics=system.massDynamics
        "Formulation of mass balance"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}}, rotation=
               0)));
      Modelica.Blocks.Interfaces.RealOutput V "liquid volume"
      annotation (Placement(transformation(
            origin={100,110},
            extent={{-10,-10},{10,10}},
            rotation=90)));

      Medium.SaturationProperties sat
        "State vector to compute saturation properties";
      Medium.AbsolutePressure p(start=p_start, stateSelect=StateSelect.prefer)
        "pressure inside drum boiler";
      Medium.Temperature T "temperature inside drum boiler";
      SI.Volume V_v "volume of vapour phase";
      SI.Volume V_l(start=V_l_start, stateSelect=StateSelect.prefer)
        "volumes of liquid phase";
      Medium.SpecificEnthalpy h_v=Medium.dewEnthalpy(sat)
        "specific enthalpy of vapour";
      Medium.SpecificEnthalpy h_l=Medium.bubbleEnthalpy(sat)
        "specific enthalpy of liquid";
      Medium.Density rho_v=Medium.dewDensity(sat) "density in vapour phase";
      Medium.Density rho_l=Medium.bubbleDensity(sat) "density in liquid phase";
      SI.Mass m "total mass of drum boiler";
      SI.Energy U "internal energy";
      Medium.Temperature T_D=heatPort.T "temperature of drum";
      SI.HeatFlowRate q_F=heatPort.Q_flow "heat flow rate from furnace";
      Medium.SpecificEnthalpy h_W=inStream(port_a.h_outflow)
        "Feed water enthalpy (specific enthalpy close to feedwater port when mass flows in to the boiler)";
      Medium.SpecificEnthalpy h_S=inStream(port_b.h_outflow)
        "steam enthalpy (specific enthalpy close to steam port when mass flows in to the boiler)";
      SI.MassFlowRate qm_W=port_a.m_flow "feed water mass flow rate";
      SI.MassFlowRate qm_S=port_b.m_flow "steam mass flow rate";
    /*outer Modelica.Fluid.Components.FluidOptions fluidOptions
    "Global default options";*/
    equation
    // balance equations
      m = rho_v*V_v + rho_l*V_l + m_D "Total mass";
      U = rho_v*V_v*h_v + rho_l*V_l*h_l - p*V_t + m_D*cp_D*T_D "Total energy";
      if massDynamics == Types.Dynamics.SteadyState then
        0 = qm_W + qm_S "Steady state mass balance";
      else
        der(m) = qm_W + qm_S "Dynamic mass balance";
      end if;
      if energyDynamics == Types.Dynamics.SteadyState then
        0 = q_F + port_a.m_flow*actualStream(port_a.h_outflow)
                + port_b.m_flow*actualStream(port_b.h_outflow)
          "Steady state energy balance";
      else
        der(U) = q_F
                + port_a.m_flow*actualStream(port_a.h_outflow)
                + port_b.m_flow*actualStream(port_b.h_outflow)
          "Dynamic energy balance";
      end if;
      V_t = V_l + V_v;

    // Properties of saturated liquid and steam
      sat.psat = p;
      sat.Tsat = T;
      sat.Tsat = Medium.saturationTemperature(p);

    // ideal heat transfer between metal and water
      T_D = T;

    // boundary conditions at the ports
      port_a.p = p;
      port_a.h_outflow = h_l;
      port_b.p = p;
      port_b.h_outflow = h_v;

    // liquid volume
      V = V_l;

    // Check that two-phase equilibrium is actually possible
      assert(p < Medium.fluidConstants[1].criticalPressure - 10000,
        "Evaporator model requires subcritical pressure");
    initial equation
    // Initial conditions
      // Note: p represents the energy as it is constrained by T_sat
      if energyDynamics == Types.Dynamics.FixedInitial then
        p = p_start;
      elseif energyDynamics == Types.Dynamics.SteadyStateInitial then
        der(p) = 0;
      end if;

      if massDynamics == Types.Dynamics.FixedInitial then
        V_l = V_l_start;
      elseif energyDynamics == Types.Dynamics.SteadyStateInitial then
        der(V_l) = 0;
      end if;

      annotation (
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Rectangle(
              extent={{-100,64},{100,-64}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Backward,
              fillColor={135,135,135}),
            Rectangle(
              extent={{-100,44},{100,-44}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,127,255}),
            Ellipse(
              extent={{18,0},{48,-29}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-1,29},{29,0}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{43,31},{73,2}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-31,1},{-1,-28}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{50,15},{80,-14}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-72,25},{-42,-4}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{71,-11},{101,-40}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{72,28},{102,-1}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{71,40},{101,11}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,70},{150,110}},
              lineColor={0,0,255},
              textString="%name"),
            Line(points={{0,-64},{0,-100}}, color={191,0,0}),
            Line(points={{100,100},{100,60}}, color={0,0,127}),
            Ellipse(
              extent={{58,-11},{88,-40}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{71,1},{101,-28}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(revisions="<html>
<ul>
<li><i>Dec 2008</i>
    by R&uuml;diger Franke:<br>
     Adapt initialization to new Types.Dynamics</li>
<li><i>2 Nov 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
     Initialization options fixed</li>
<li><i>6 Sep 2005</i><br>
    Model by Ruediger Franke<br>
    See Franke, Rode, Krueger: On-line Optimization of Drum Boiler Startup, 3rd International Modelica Conference, Linkoping, 2003.<br>
    Modified after the 45th Design Meeting</li>
</ul>
</html>",     info="<html>
Model of a simple evaporator with two states. The model assumes two-phase equilibrium inside the component; saturated steam goes out of the steam outlet.
<p>
References: Astroem, Bell: Drum-boiler dynamics, Automatica 36, 2000, pp.363-378
</html>"));
    end EquilibriumDrumBoiler;
  end BaseClasses;
end DrumBoiler;
