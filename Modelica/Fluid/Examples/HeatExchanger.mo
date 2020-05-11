within Modelica.Fluid.Examples;
package HeatExchanger "Demo of a heat exchanger model"
  extends Modelica.Icons.ExamplesPackage;

  model HeatExchangerSimulation "Simulation for the heat exchanger model"

  extends Modelica.Icons.Example;

  //replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;
  replaceable package Medium = Modelica.Media.Water.StandardWaterOnePhase;
  //package Medium = Modelica.Media.Incompressible.Examples.Essotherm650;
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX HEX(
      c_wall=500,
      use_T_start=true,
      nNodes=20,
      m_flow_start_1=0.2,
      m_flow_start_2=0.2,
      k_wall=100,
      s_wall=0.005,
      crossArea_1=4.5e-4,
      crossArea_2=4.5e-4,
      perimeter_1=0.075,
      perimeter_2=0.075,
      rho_wall=900,
      redeclare package Medium_1 =
          Medium,
      redeclare package Medium_2 =
          Medium,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer
          (alpha0=1000),
      length=20,
      area_h_1=0.075*20,
      area_h_2=0.075*20,
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=2000),
      Twall_start=300,
      dT=10,
      T_start_1=304,
      T_start_2=300) annotation (Placement(transformation(extent={{
              -26,-14},{34,46}})));

    Modelica.Fluid.Sources.Boundary_pT ambient2(nPorts=1,
      p=1e5,
      T=280,
      redeclare package Medium = Medium) annotation (Placement(
          transformation(extent={{82,-28},{62,-8}})));
    Modelica.Fluid.Sources.Boundary_pT ambient1(nPorts=1,
      p=1e5,
      T=300,
      redeclare package Medium = Medium) annotation (Placement(
          transformation(extent={{82,24},{62,44}})));
    Modelica.Fluid.Sources.MassFlowSource_T massFlowRate2(nPorts=1,
      m_flow=0.2,
      T=360,
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      use_T_in=false,
      use_X_in=false)
                  annotation (Placement(transformation(extent={{-66,24},{-46,44}})));
    Modelica.Fluid.Sources.MassFlowSource_T massFlowRate1(nPorts=1,
      redeclare package Medium = Medium,
      m_flow=0.2,
      T=300) annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));
    Modelica.Blocks.Sources.Ramp Ramp1(
      startTime=50,
      duration=5,
      height=0.4,
      offset=-0.2) annotation (Placement(transformation(extent={{-98,24},{-78,
              44}})));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
        use_eps_Re=true) annotation (Placement(transformation(extent=
              {{60,70},{80,90}})));
  equation
    connect(massFlowRate1.ports[1], HEX.port_a1) annotation (Line(points={
            {-46,0},{-40,0},{-40,15.4},{-29,15.4}}, color={0,127,255}));
    connect(HEX.port_b1, ambient1.ports[1]) annotation (Line(points={{37,
            15.4},{48.5,15.4},{48.5,34},{62,34}}, color={0,127,255}));
    connect(Ramp1.y, massFlowRate2.m_flow_in) annotation (Line(points={{-77,34},
            {-74,34},{-74,42},{-66,42}}, color={0,0,127}));
    connect(massFlowRate2.ports[1], HEX.port_b2)
                                             annotation (Line(
        points={{-46,34},{-40,34},{-40,29.8},{-29,29.8}}, color={0,127,255}));
    connect(HEX.port_a2, ambient2.ports[1])
                                        annotation (Line(
        points={{37,2.2},{42,2},{50,2},{50,-18},{62,-18}}, color={0,127,255}));
    annotation (experiment(StopTime=200, Tolerance=
            1e-005),
      Documentation(info="<html>
<p>The simulation start in steady state with counterflow operation. At time t = 50, the mass flow rate on the secondary circuit is changed to a negative value in 5 seconds. After a transient, the heat exchanger operates in co-current flow.</p>
<div><img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/HeatExchanger/HeatExchanger.png\" alt=\"HeatExchanger.png\"/></div>
</html>"));
  end HeatExchangerSimulation;

  package BaseClasses "Additional models for heat exchangers"
    extends Modelica.Icons.BasesPackage;

    model BasicHX "Simple heat exchanger model"
      outer Modelica.Fluid.System system "System properties";
      //General
      parameter SI.Length length(min=0) "Length of flow path for both fluids";
      parameter Integer nNodes(min=1) = 2 "Spatial segmentation";
      parameter Modelica.Fluid.Types.ModelStructure modelStructure_1=Types.ModelStructure.av_vb
        "Determines whether flow or volume models are present at the ports"
        annotation(Evaluate=true, Dialog(tab="General",group="Fluid 1"));
      parameter Modelica.Fluid.Types.ModelStructure modelStructure_2=Types.ModelStructure.av_vb
        "Determines whether flow or volume models are present at the ports"
        annotation(Evaluate=true, Dialog(tab="General",group="Fluid 2"));
      replaceable package Medium_1 = Modelica.Media.Water.StandardWater constrainedby
        Modelica.Media.Interfaces.PartialMedium "Fluid 1"
                                                        annotation(choicesAllMatching, Dialog(tab="General",group="Fluid 1"));
      replaceable package Medium_2 = Modelica.Media.Water.StandardWater constrainedby
        Modelica.Media.Interfaces.PartialMedium "Fluid 2"
                                                        annotation(choicesAllMatching,Dialog(tab="General", group="Fluid 2"));
      parameter SI.Area crossArea_1 "Cross sectional area" annotation(Dialog(tab="General",group="Fluid 1"));
      parameter SI.Area crossArea_2 "Cross sectional area" annotation(Dialog(tab="General",group="Fluid 2"));
      parameter SI.Length perimeter_1 "Flow channel perimeter" annotation(Dialog(tab="General",group="Fluid 1"));
      parameter SI.Length perimeter_2 "Flow channel perimeter" annotation(Dialog(tab="General",group="Fluid 2"));
      final parameter Boolean use_HeatTransfer = true
        "= true to use the HeatTransfer_1/_2 model";

      // Heat transfer
      replaceable model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer
        constrainedby
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer
        "Heat transfer model" annotation(choicesAllMatching, Dialog(tab="General", group="Fluid 1", enable=use_HeatTransfer));

      replaceable model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer
        constrainedby
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer
        "Heat transfer model" annotation(choicesAllMatching, Dialog(tab="General", group="Fluid 2", enable=use_HeatTransfer));

      parameter SI.Area area_h_1 "Heat transfer area" annotation(Dialog(tab="General",group="Fluid 1"));
      parameter SI.Area area_h_2 "Heat transfer area" annotation(Dialog(tab="General",group="Fluid 2"));
     //Wall
      parameter SI.Length s_wall(min=0) "Wall thickness"
        annotation (Dialog(group="Wall properties"));
      parameter SI.ThermalConductivity k_wall
        "Thermal conductivity of wall material"
        annotation (Dialog(group="Wall properties"));
      parameter SI.SpecificHeatCapacity c_wall
        "Specific heat capacity of wall material"
        annotation(Dialog(tab="General", group="Wall properties"));
      parameter SI.Density rho_wall "Density of wall material"
        annotation(Dialog(tab="General", group="Wall properties"));
      final parameter SI.Area area_h=(area_h_1 + area_h_2)/2
        "Heat transfer area";
      final parameter SI.Mass m_wall=rho_wall*area_h*s_wall "Wall mass";

      // Assumptions
      parameter Boolean allowFlowReversal = system.allowFlowReversal
        "Allow flow reversal, false restricts to design direction (port_a -> port_b)"
        annotation(Dialog(tab="Assumptions"), Evaluate=true);
      parameter Modelica.Fluid.Types.Dynamics energyDynamics=system.energyDynamics
        "Formulation of energy balance"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
      parameter Modelica.Fluid.Types.Dynamics massDynamics=system.massDynamics
        "Formulation of mass balance"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
      parameter Modelica.Fluid.Types.Dynamics momentumDynamics=system.momentumDynamics
        "Formulation of momentum balance, if pressureLoss options available"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));

      //Initialization pipe 1
      parameter SI.Temperature Twall_start "Start value of wall temperature"
                                                                            annotation(Dialog(tab="Initialization", group="Wall"));
      parameter SI.TemperatureDifference dT "Start value for pipe_1.T - pipe_2.T"
        annotation (Dialog(tab="Initialization", group="Wall"));
      parameter Boolean use_T_start=true
        "Use T_start if true, otherwise h_start"
        annotation(Evaluate=true, Dialog(tab = "Initialization"));
      parameter Medium_1.AbsolutePressure p_a_start1=Medium_1.p_default
        "Start value of pressure"
        annotation(Dialog(tab = "Initialization", group = "Fluid 1"));
      parameter Medium_1.AbsolutePressure p_b_start1=Medium_1.p_default
        "Start value of pressure"
        annotation(Dialog(tab = "Initialization", group = "Fluid 1"));
      parameter Medium_1.Temperature T_start_1=if use_T_start then Medium_1.
          T_default else Medium_1.temperature_phX(
            (p_a_start1 + p_b_start1)/2,
            h_start_1,
            X_start_1) "Start value of temperature"
        annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid 1", enable = use_T_start));
      parameter Medium_1.SpecificEnthalpy h_start_1=if use_T_start then Medium_1.specificEnthalpy_pTX(
            (p_a_start1 + p_b_start1)/2,
            T_start_1,
            X_start_1) else Medium_1.h_default
        "Start value of specific enthalpy"
        annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid 1", enable = not use_T_start));
      parameter Medium_1.MassFraction X_start_1[Medium_1.nX]=Medium_1.X_default
        "Start value of mass fractions m_i/m"
        annotation (Dialog(tab="Initialization", group = "Fluid 1", enable=(Medium_1.nXi > 0)));
      parameter Medium_1.MassFlowRate m_flow_start_1 = system.m_flow_start
        "Start value of mass flow rate" annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid 1"));
      //Initialization pipe 2

      parameter Medium_2.AbsolutePressure p_a_start2=Medium_2.p_default
        "Start value of pressure"
        annotation(Dialog(tab = "Initialization", group = "Fluid 2"));
      parameter Medium_2.AbsolutePressure p_b_start2=Medium_2.p_default
        "Start value of pressure"
        annotation(Dialog(tab = "Initialization", group = "Fluid 2"));
      parameter Medium_2.Temperature T_start_2=if use_T_start then Medium_2.
          T_default else Medium_2.temperature_phX(
            (p_a_start2 + p_b_start2)/2,
            h_start_2,
            X_start_2) "Start value of temperature"
        annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid 2", enable = use_T_start));
      parameter Medium_2.SpecificEnthalpy h_start_2=if use_T_start then Medium_2.specificEnthalpy_pTX(
            (p_a_start2 + p_b_start2)/2,
            T_start_2,
            X_start_2) else Medium_2.h_default
        "Start value of specific enthalpy"
        annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid 2", enable = not use_T_start));
      parameter Medium_2.MassFraction X_start_2[Medium_2.nX]=Medium_2.X_default
        "Start value of mass fractions m_i/m"
        annotation (Dialog(tab="Initialization", group = "Fluid 2", enable=Medium_2.nXi>0));
      parameter Medium_2.MassFlowRate m_flow_start_2 = system.m_flow_start
        "Start value of mass flow rate" annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid 2"));

      //Pressure drop and heat transfer
      replaceable model FlowModel_1 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow
        constrainedby
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
        "Characteristic of wall friction" annotation(choicesAllMatching, Dialog(tab="General", group="Fluid 1"));
      replaceable model FlowModel_2 =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow
        constrainedby
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
        "Characteristic of wall friction" annotation(choicesAllMatching, Dialog(tab="General", group="Fluid 2"));
      parameter Modelica.Fluid.Types.Roughness roughness_1=2.5e-5
        "Absolute roughness of pipe (default = smooth steel pipe)" annotation(Dialog(tab="General", group="Fluid 1"));
      parameter Modelica.Fluid.Types.Roughness roughness_2=2.5e-5
        "Absolute roughness of pipe (default = smooth steel pipe)" annotation(Dialog(tab="General", group="Fluid 2"));

      //Display variables
      SI.HeatFlowRate Q_flow_1 "Total heat flow rate of pipe 1";
      SI.HeatFlowRate Q_flow_2 "Total heat flow rate of pipe 2";

      BaseClasses.WallConstProps wall(
        rho_wall=rho_wall,
        c_wall=c_wall,
        T_start=Twall_start,
        k_wall=k_wall,
        dT=dT,
        s=s_wall,
        energyDynamics=energyDynamics,
        n=nNodes,
        area_h=area_h)
        annotation (Placement(transformation(extent={{-29,-23},{9,35}})));

      Pipes.DynamicPipe pipe_1(
        redeclare final package Medium = Medium_1,
        final isCircular=false,
        final diameter=0,
        final nNodes=nNodes,
        final allowFlowReversal=allowFlowReversal,
        final energyDynamics=energyDynamics,
        final massDynamics=massDynamics,
        final momentumDynamics=momentumDynamics,
        final length=length,
        final use_HeatTransfer=use_HeatTransfer,
        redeclare final model HeatTransfer = HeatTransfer_1,
        final use_T_start=use_T_start,
        final T_start=T_start_1,
        final h_start=h_start_1,
        final X_start=X_start_1,
        final m_flow_start=m_flow_start_1,
        final perimeter=perimeter_1,
        final crossArea=crossArea_1,
        final p_a_start=p_a_start1,
        final p_b_start=p_b_start1,
        final roughness=roughness_1,
        redeclare final model FlowModel = FlowModel_1,
        final modelStructure=modelStructure_1) annotation (Placement(transformation(extent={{-40,-80},
                {20,-20}})));

      Pipes.DynamicPipe pipe_2(
        redeclare final package Medium = Medium_2,
        final nNodes=nNodes,
        final allowFlowReversal=allowFlowReversal,
        final energyDynamics=energyDynamics,
        final massDynamics=massDynamics,
        final momentumDynamics=momentumDynamics,
        final length=length,
        final isCircular=false,
        final diameter=0,
        final use_HeatTransfer=use_HeatTransfer,
        redeclare final model HeatTransfer = HeatTransfer_2,
        final use_T_start=use_T_start,
        final T_start=T_start_2,
        final h_start=h_start_2,
        final X_start=X_start_2,
        final m_flow_start=m_flow_start_2,
        final perimeter=perimeter_2,
        final crossArea=crossArea_2,
        final p_a_start=p_a_start2,
        final p_b_start=p_b_start2,
        final roughness=roughness_2,
        redeclare final model FlowModel = FlowModel_2,
        final modelStructure=modelStructure_2)
                  annotation (Placement(transformation(extent={{20,88},{-40,28}})));

      Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare final package
          Medium =
            Medium_1) annotation (Placement(transformation(extent={{100,-12},{120,
                8}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare final package
          Medium =
            Medium_1) annotation (Placement(transformation(extent={{-120,-12},{
                -100,8}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare final package
          Medium =
            Medium_2) annotation (Placement(transformation(extent={{-120,36},{
                -100,56}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare final package
          Medium =
            Medium_2) annotation (Placement(transformation(extent={{100,-56},{120,
                -36}})));

    equation
      Q_flow_1 = sum(pipe_1.heatTransfer.Q_flows);
      Q_flow_2 = sum(pipe_2.heatTransfer.Q_flows);
      connect(pipe_2.port_b, port_b2) annotation (Line(
          points={{-40,58},{-76,58},{-76,46},{-110,46}},
          color={0,127,255},
          thickness=0.5));
      connect(pipe_1.port_b, port_b1) annotation (Line(
          points={{20,-50},{42,-50},{42,-2},{110,-2}},
          color={0,127,255},
          thickness=0.5));
      connect(pipe_1.port_a, port_a1) annotation (Line(
          points={{-40,-50},{-75.3,-50},{-75.3,-2},{-110,-2}},
          color={0,127,255},
          thickness=0.5));
      connect(pipe_2.port_a, port_a2) annotation (Line(
          points={{20,58},{65,58},{65,-46},{110,-46}},
          color={0,127,255},
          thickness=0.5));
      connect(wall.heatPort_b, pipe_1.heatPorts) annotation (Line(
          points={{-10,-8.5},{-10,-36.8},{-9.7,-36.8}}, color={191,0,0}));
      connect(pipe_2.heatPorts[nNodes:-1:1], wall.heatPort_a[1:nNodes])
        annotation (Line(
          points={{-10.3,44.8},{-10.3,31.7},{-10,31.7},{-10,20.5}}, color={127,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-100,-26},{100,-30}},
              fillColor={95,95,95},
              fillPattern=FillPattern.Forward),
            Rectangle(
              extent={{-100,30},{100,26}},
              fillColor={95,95,95},
              fillPattern=FillPattern.Forward),
            Rectangle(
              extent={{-100,60},{100,30}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,63,125}),
            Rectangle(
              extent={{-100,-30},{100,-60}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,63,125}),
            Rectangle(
              extent={{-100,26},{100,-26}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,128,255}),
            Text(
              extent={{-150,110},{150,70}},
              textColor={0,0,255},
              textString="%name"),
            Line(
              points={{30,-85},{-60,-85}},
              color={0,128,255}),
            Polygon(
              points={{20,-70},{60,-85},{20,-100},{20,-70}},
              lineColor={0,128,255},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{30,77},{-60,77}},
              color={0,128,255}),
            Polygon(
              points={{-50,92},{-90,77},{-50,62},{-50,92}},
              lineColor={0,128,255},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>Simple model of a heat exchanger consisting of two pipes and one wall in between.
For both fluids geometry parameters, such as heat transfer area and cross section as well as heat transfer and pressure drop correlations may be chosen.
The flow scheme may be concurrent or counterflow, defined by the respective flow directions of the fluids entering the component.
The design flow direction with positive m_flow variables is counterflow.</p>
</html>"));
    end BasicHX;

    model WallConstProps
      "Pipe wall with capacitance, assuming 1D heat conduction and constant material properties"
      parameter Integer n(min=1)=1
        "Segmentation perpendicular to heat conduction";
    //Geometry
      parameter SI.Length s "Wall thickness";
      parameter SI.Area area_h "Heat transfer area";
    //Material properties
      parameter SI.Density rho_wall "Density of wall material";
      parameter SI.SpecificHeatCapacity c_wall
        "Specific heat capacity of wall material";
      parameter SI.ThermalConductivity k_wall
        "Thermal conductivity of wall material";
      parameter SI.Mass[n] m=fill(rho_wall*area_h*s/n,n)
        "Distribution of wall mass";
    //Initialization
      outer Modelica.Fluid.System system;
      parameter Modelica.Fluid.Types.Dynamics energyDynamics=system.energyDynamics
        "Formulation of energy balance"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
      parameter SI.Temperature T_start "Wall temperature start value";
      parameter SI.Temperature dT "Start value for port_b.T - port_a.T";
    //Temperatures
      SI.Temperature[n] Tb(each start=T_start+0.5*dT);
      SI.Temperature[n] Ta(each start=T_start-0.5*dT);
      SI.Temperature[n] T(start=ones(n)*T_start, each stateSelect=StateSelect.prefer)
        "Wall temperature";
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[n] heatPort_a
        "Thermal port"
        annotation (Placement(transformation(extent={{-20,40},{20,60}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[n] heatPort_b
        "Thermal port"
        annotation (Placement(transformation(extent={{-20,-40},{20,-60}})));

    initial equation
      if energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial then
        der(T) = zeros(n);
      elseif energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial then
        T = ones(n)*T_start;
      end if;
    equation
      for i in 1:n loop
       assert(m[i]>0, "Wall has negative dimensions");
       if energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState then
         0 = heatPort_a[i].Q_flow + heatPort_b[i].Q_flow;
       else
         c_wall*m[i]*der(T[i]) = heatPort_a[i].Q_flow + heatPort_b[i].Q_flow;
       end if;
       heatPort_a[i].Q_flow=2*k_wall/s*(Ta[i]-T[i])*area_h/n;
       heatPort_b[i].Q_flow=2*k_wall/s*(Tb[i]-T[i])*area_h/n;
      end for;
      Ta=heatPort_a.T;
      Tb=heatPort_b.T;
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-100,40},{100,-40}},
              fillColor={95,95,95},
              fillPattern=FillPattern.Forward), Text(
              extent={{-82,18},{76,-18}},
              textString="%name")}),
                                Documentation(revisions="<html>
<ul>
<li><em>04 Mar 2006</em>
    by Katrin Pr&ouml;l&szlig;:<br>
       Model added to the Fluid library</li>
</ul>
</html>",     info="<html>
Simple model of circular (or any other closed shape) wall to be used for pipe (or duct) models. Heat conduction is regarded one dimensional, capacitance is lumped at the arithmetic mean temperature. The spatial discretization (parameter <code>n</code>) is meant to correspond to a connected fluid model discretization.
</html>"));
    end WallConstProps;
  end BaseClasses;
end HeatExchanger;
