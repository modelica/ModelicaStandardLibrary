within Modelica.Fluid;
package Machines
  "Devices for converting between energy held in a fluid and mechanical energy"
  extends Modelica.Icons.VariantsPackage;
  model SweptVolume
    "varying cylindric volume depending on the position of the piston"
    import Modelica.Constants.pi;

    parameter SI.Area pistonCrossArea "Cross sectional area of piston";
    parameter SI.Volume clearance "Remaining volume at zero piston stroke";

    SI.Volume V "fluid volume";

    // Mass and energy balance, ports
    extends Modelica.Fluid.Vessels.BaseClasses.PartialLumpedVessel(
      final fluidVolume = V,
      heatTransfer(surfaceAreas={pistonCrossArea+2*sqrt(pistonCrossArea*pi)*(flange.s+clearance/pistonCrossArea)}));

    Modelica.Mechanics.Translational.Interfaces.Flange_b flange
      "translation flange for piston" annotation (Placement(transformation(
            extent={{-10,90},{10,110}})));

  equation
    assert(flange.s >= 0, "Piston stroke (given by flange.s) must not be smaller than zero!");

    // volume size
    V = clearance + flange.s * pistonCrossArea;

    0 = flange.f + (medium.p - system.p_ambient) * pistonCrossArea;

    // energy balances
    Wb_flow = medium.p * pistonCrossArea * (-der(flange.s));

    // definition of port pressures
    for i in 1:nPorts loop
      vessel_ps_static[i] = medium.p;
    end for;

    annotation (Icon(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-50,36},{50,-90}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            lineThickness=1,
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-52,62},{-48,62},{-48,-30},{-52,-30},{-52,62}},
            lineColor={95,95,95},
            fillColor={135,135,135},
            fillPattern=FillPattern.Backward),
          Polygon(
            points={{48,60},{52,60},{52,-34},{48,-34},{48,60}},
            lineColor={95,95,95},
            fillColor={135,135,135},
            fillPattern=FillPattern.Backward),
          Rectangle(
            extent={{-48,40},{48,30}},
            lineColor={95,95,95},
            fillColor={135,135,135},
            fillPattern=FillPattern.Forward),
          Rectangle(
            extent={{-6,92},{6,40}},
            lineColor={95,95,95},
            fillColor={135,135,135},
            fillPattern=FillPattern.Forward),
          Polygon(
            points={{-48,-90},{48,-90},{48,70},{52,70},{52,-94},{-52,-94},{-52,
                70},{-48,70},{-48,-90}},
            lineColor={95,95,95},
            fillColor={135,135,135},
            fillPattern=FillPattern.Backward),
          Line(
            visible=use_HeatTransfer,
            points={{-100,0},{-52,0}},
            color={198,0,0})}),
      Documentation(info="<html>
<p> Mixing volume with varying size. The size of the volume is given by:</p>
<ul>
  <li>cross sectional piston area</li>
  <li>piston stroke given by the flange position s</li>
  <li>clearance (volume at flange position = 0)</li>
</ul>
<p>Losses are neglected. The shaft power is completely converted into mechanical work on the fluid.</p>

<p> The flange position has to be equal or greater than zero. Otherwise the simulation stops. The force of the flange results from the pressure difference between medium and ambient pressure and the cross sectional piston area. For using the component, a top level instance of the ambient model with the inner attribute is needed.</p>
<p> The pressure at both fluid ports equals the medium pressure in the volume. No suction nor discharge valve is included in the model.</p>
<p>The thermal port is directly connected to the medium. The temperature of the thermal port equals the medium temperature. The heat capacity of the cylinder and the piston are not includes in the model.</p>
</html>",
        revisions="<html>
<ul>
<li><em>29 Oct 2007</em>
    by Carsten Heinrich:<br>
       Model added to the Fluid library</li>
</ul>
</html>"));
  end SweptVolume;

  model Pump "Centrifugal pump with mechanical connector for the shaft"
    extends Modelica.Fluid.Machines.BaseClasses.PartialPump;
    SI.Angle phi "Shaft angle";
    SI.AngularVelocity omega "Shaft angular velocity";
    Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  equation
    phi = shaft.phi;
    omega = der(phi);
    N = Modelica.SIunits.Conversions.to_rpm(omega);
    W_single = omega*shaft.tau;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Rectangle(
            extent={{-10,100},{10,78}},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={95,95,95})}),
    Documentation(info="<html>
<p>This model describes a centrifugal pump (or a group of <code>nParallel</code> pumps) with a mechanical rotational connector for the shaft, to be used when the pump drive has to be modelled explicitly. In the case of <code>nParallel</code> pumps, the mechanical connector is relative to a single pump.</p>
<p>The model extends <code>PartialPump</code></p>
 </html>",
       revisions="<html>
<ul>
<li><em>31 Oct 2005</em>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Model added to the Fluid library</li>
</ul>
</html>"));
  end Pump;

  model ControlledPump
    "Centrifugal pump with ideally controlled mass flow rate"
    import Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm;
    extends Modelica.Fluid.Machines.BaseClasses.PartialPump(
      N_nominal=1500,
      N(start=N_nominal),
      redeclare replaceable function flowCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow
          ( V_flow_nominal={0, V_flow_op, 1.5*V_flow_op},
            head_nominal={2*head_op, head_op, 0}));

    // nominal values
    parameter Medium.AbsolutePressure p_a_nominal
      "Nominal inlet pressure for predefined pump characteristics";
    parameter Medium.AbsolutePressure p_b_nominal
      "Nominal outlet pressure, fixed if not control_m_flow and not use_p_set";
    parameter Medium.MassFlowRate m_flow_nominal
      "Nominal mass flow rate, fixed if control_m_flow and not use_m_flow_set";

    // what to control
    parameter Boolean control_m_flow = true
      "= false to control outlet pressure port_b.p instead of m_flow"
      annotation(Evaluate = true);
    parameter Boolean use_m_flow_set = false
      "= true to use input signal m_flow_set instead of m_flow_nominal"
      annotation (Dialog(enable = control_m_flow));
    parameter Boolean use_p_set = false
      "= true to use input signal p_set instead of p_b_nominal"
      annotation (Dialog(enable = not control_m_flow));

    // exemplary characteristics
    final parameter SI.VolumeFlowRate V_flow_op = m_flow_nominal/rho_nominal
      "operational volume flow rate according to nominal values";
    final parameter SI.Height head_op = (p_b_nominal-p_a_nominal)/(rho_nominal*g)
      "operational pump head according to nominal values";

    Modelica.Blocks.Interfaces.RealInput m_flow_set if use_m_flow_set
      "Prescribed mass flow rate"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={-50,82})));
    Modelica.Blocks.Interfaces.RealInput p_set if use_p_set
      "Prescribed outlet pressure"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={50,82})));

  protected
    Modelica.Blocks.Interfaces.RealInput m_flow_set_internal
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput p_set_internal
      "Needed to connect to conditional connector";
  equation
    // Ideal control
    if control_m_flow then
      m_flow = m_flow_set_internal;
    else
      dp_pump = p_set_internal - port_a.p;
    end if;

    // Internal connector value when use_m_flow_set = false
    if not use_m_flow_set then
      m_flow_set_internal = m_flow_nominal;
    end if;
    if not use_p_set then
      p_set_internal = p_b_nominal;
    end if;
    connect(m_flow_set, m_flow_set_internal);
    connect(p_set, p_set_internal);

    annotation (defaultComponentName="pump",
      Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
              100}}), graphics={Text(
            visible=use_p_set,
            extent={{82,108},{176,92}},
            textString="p_set"), Text(
            visible=use_m_flow_set,
            extent={{-20,108},{170,92}},
            textString="m_flow_set")}),
      Documentation(info="<html>
<p>
This model describes a centrifugal pump (or a group of <code>nParallel</code> pumps)
with ideally controlled mass flow rate or pressure.
</p>
<p>
Nominal values are used to predefine an exemplary pump characteristics and to define the operation of the pump.
The input connectors <code>m_flow_set</code> or <code>p_set</code> can optionally be enabled to provide time varying set points.
</p>
<p>
Use this model if the pump characteristics is of secondary interest.
The actual characteristics can be configured later on for the appropriate rotational speed N.
Then the model can be replaced with a Pump with rotational shaft or with a PrescribedPump.
</p>
</html>",
        revisions="<html>
<ul>
<li><em>15 Dec 2008</em>
    by R&uuml;diger Franke:<br />
       Model added to the Fluid library</li>
</ul>
</html>"));
  end ControlledPump;

  model PrescribedPump "Centrifugal pump with ideally controlled speed"
    extends Modelica.Fluid.Machines.BaseClasses.PartialPump;
    parameter Boolean use_N_in = false
      "Get the rotational speed from the input connector";
    parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm
      N_const =                                                                     N_nominal
      "Constant rotational speed" annotation(Dialog(enable = not use_N_in));
    Modelica.Blocks.Interfaces.RealInput N_in(unit="rev/min") if use_N_in
      "Prescribed rotational speed"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,100}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,100})));

  protected
    Modelica.Blocks.Interfaces.RealInput N_in_internal(unit="rev/min")
      "Needed to connect to conditional connector";
  equation
    // Connect statement active only if use_p_in = true
    connect(N_in, N_in_internal);
    // Internal connector value when use_p_in = false
    if not use_N_in then
      N_in_internal = N_const;
    end if;
    // Set N with a lower limit to avoid singularities at zero speed
    N = max(N_in_internal,1e-3) "Rotational speed";

    annotation (defaultComponentName="pump",
      Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
              100}}), graphics={Text(
            visible=use_N_in,
            extent={{14,98},{178,82}},
            textString="N_in [rpm]")}),
      Documentation(info="<html>
<p>This model describes a centrifugal pump (or a group of <code>nParallel</code> pumps) with prescribed speed, either fixed or provided by an external signal.</p>
<p>The model extends <code>PartialPump</code></p>
<p>If the <code>N_in</code> input connector is wired, it provides rotational speed of the pumps (rpm); otherwise, a constant rotational speed equal to <code>n_const</code> (which can be different from <code>N_nominal</code>) is assumed.</p>
</html>",
        revisions="<html>
<ul>
<li><em>31 Oct 2005</em>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Model added to the Fluid library</li>
</ul>
</html>"));
  end PrescribedPump;

  package BaseClasses
    "Base classes used in the Machines package (only of interest to build new component models)"
    extends Modelica.Icons.BasesPackage;

  partial model PartialPump "Base model for centrifugal pumps"
      import NonSI = Modelica.SIunits.Conversions.NonSIunits;
      import Modelica.Constants;

    extends Modelica.Fluid.Interfaces.PartialTwoPort(
      port_b_exposesState = energyDynamics<>Types.Dynamics.SteadyState or massDynamics<>Types.Dynamics.SteadyState,
      port_a(
        p(start=p_a_start),
        m_flow(start = m_flow_start,
               min = if allowFlowReversal and not checkValve then -Constants.inf else 0)),
      port_b(
        p(start=p_b_start),
        m_flow(start = -m_flow_start,
               max = if allowFlowReversal and not checkValve then +Constants.inf else 0)));

    // Initialization
    parameter Medium.AbsolutePressure p_a_start=system.p_start
        "Guess value for inlet pressure"
      annotation(Dialog(tab="Initialization"));
    parameter Medium.AbsolutePressure p_b_start=p_a_start
        "Guess value for outlet pressure"
      annotation(Dialog(tab="Initialization"));
    parameter Medium.MassFlowRate m_flow_start = system.m_flow_start
        "Guess value of m_flow = port_a.m_flow"
      annotation(Dialog(tab = "Initialization"));
    final parameter SI.VolumeFlowRate V_flow_single_init = m_flow_start/rho_nominal/nParallel
        "Used for simplified initialization model";
    final parameter SI.Height delta_head_init = flowCharacteristic(V_flow_single_init)-flowCharacteristic(0)
        "Used for simplified initialization model";

    // Characteristic curves
    parameter Integer nParallel(min=1) = 1 "Number of pumps in parallel"
      annotation(Dialog(group="Characteristics"));
    replaceable function flowCharacteristic =
        PumpCharacteristics.baseFlow
        "Head vs. V_flow characteristic at nominal speed and density"
      annotation(Dialog(group="Characteristics"), choicesAllMatching=true);
    parameter NonSI.AngularVelocity_rpm N_nominal
        "Nominal rotational speed for flow characteristic"
      annotation(Dialog(group="Characteristics"));
    parameter Medium.Density rho_nominal = Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default)
        "Nominal fluid density for characteristic"
      annotation(Dialog(group="Characteristics"));
    parameter Boolean use_powerCharacteristic = false
        "Use powerCharacteristic (vs. efficiencyCharacteristic)"
       annotation(Evaluate=true,Dialog(group="Characteristics"));
    replaceable function powerCharacteristic =
          PumpCharacteristics.quadraticPower (
         V_flow_nominal={0,0,0},W_nominal={0,0,0})
        "Power consumption vs. V_flow at nominal speed and density"
      annotation(Dialog(group="Characteristics", enable = use_powerCharacteristic),
                 choicesAllMatching=true);
    replaceable function efficiencyCharacteristic =
      PumpCharacteristics.constantEfficiency(eta_nominal = 0.8) constrainedby
        PumpCharacteristics.baseEfficiency
        "Efficiency vs. V_flow at nominal speed and density"
      annotation(Dialog(group="Characteristics",enable = not use_powerCharacteristic),
                 choicesAllMatching=true);

    // Assumptions
    parameter Boolean checkValve=false "= true to prevent reverse flow"
      annotation(Dialog(tab="Assumptions"), Evaluate=true);

    parameter SI.Volume V = 0 "Volume inside the pump"
      annotation(Dialog(tab="Assumptions"),Evaluate=true);

    // Energy and mass balance
    extends Modelica.Fluid.Interfaces.PartialLumpedVolume(
        final fluidVolume = V,
        energyDynamics = Types.Dynamics.SteadyState,
        massDynamics = Types.Dynamics.SteadyState,
        final p_start = p_b_start);

    // Heat transfer through boundary, e.g., to add a housing
    parameter Boolean use_HeatTransfer = false
        "= true to use a HeatTransfer model, e.g., for a housing"
        annotation (Dialog(tab="Assumptions",group="Heat transfer"));
    replaceable model HeatTransfer =
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer
      constrainedby
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.PartialVesselHeatTransfer
        "Wall heat transfer"
        annotation (Dialog(tab="Assumptions",group="Heat transfer",enable=use_HeatTransfer),choicesAllMatching=true);
    HeatTransfer heatTransfer(
      redeclare final package Medium = Medium,
      final n=1,
      surfaceAreas={4*Modelica.Constants.pi*(3/4*V/Modelica.Constants.pi)^(2/3)},
      final states = {medium.state},
      final use_k = use_HeatTransfer)
        annotation (Placement(transformation(
          extent={{-10,-10},{30,30}},
          rotation=180,
          origin={50,-10})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if use_HeatTransfer
      annotation (Placement(transformation(extent={{30,-70},{50,-50}})));

    // Variables
    final parameter SI.Acceleration g=system.g;
    Medium.Density rho = medium.d;
    SI.Pressure dp_pump = port_b.p - port_a.p "Pressure increase";
    SI.Height head = dp_pump/(rho*g) "Pump head";
    SI.MassFlowRate m_flow = port_a.m_flow "Mass flow rate (total)";
    SI.MassFlowRate m_flow_single = m_flow/nParallel
        "Mass flow rate (single pump)";
    SI.VolumeFlowRate V_flow "Volume flow rate (total)";
    SI.VolumeFlowRate V_flow_single(start = m_flow_start/rho_nominal/nParallel)
        "Volume flow rate (single pump)";
    NonSI.AngularVelocity_rpm N(start = N_nominal) "Shaft rotational speed";
    SI.Power W_single "Power Consumption (single pump)";
    SI.Power W_total = W_single*nParallel "Power Consumption (total)";
    Real eta "Global Efficiency";
    final constant Medium.MassFlowRate unit_m_flow=1 annotation (HideResult=true);
    Real s(start = m_flow_start/unit_m_flow)
        "Curvilinear abscissa for the flow curve in parametric form (either mass flow rate or head)";

    // Diagnostics
    replaceable model Monitoring =
      Modelica.Fluid.Machines.BaseClasses.PumpMonitoring.PumpMonitoringBase
      constrainedby
        Modelica.Fluid.Machines.BaseClasses.PumpMonitoring.PumpMonitoringBase
        "Optional pump monitoring"
        annotation(Dialog(tab="Advanced", group="Diagnostics"), choicesAllMatching=true);
    final parameter Boolean show_NPSHa = false
        "obsolete -- remove modifier and specify Monitoring for NPSH instead"
      annotation(Dialog(tab="Advanced", group="Obsolete"));
    Monitoring monitoring(
            redeclare final package Medium = Medium,
            final state_in = Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow)),
            final state = medium.state) "Monitoring model"
       annotation (Placement(transformation(extent={{-64,-42},{-20,0}})));
    protected
    constant SI.Height unitHead = 1;
    constant SI.MassFlowRate unitMassFlowRate = 1;

  equation
    // Flow equations
     V_flow = homotopy(m_flow/rho,
                       m_flow/rho_nominal);
     V_flow_single = V_flow/nParallel;
    if not checkValve then
      // Regular flow characteristics without check valve
      head = homotopy((N/N_nominal)^2*flowCharacteristic(V_flow_single*N_nominal/N),
                       N/N_nominal*(flowCharacteristic(0)+V_flow_single*noEvent(if abs(V_flow_single_init)>0 then delta_head_init/V_flow_single_init else 0)));
      s = 0;
    else
      // Flow characteristics when check valve is open
      head = homotopy(if s > 0 then (N/N_nominal)^2*flowCharacteristic(V_flow_single*N_nominal/N)
                               else (N/N_nominal)^2*flowCharacteristic(0) - s*unitHead,
                      N/N_nominal*(flowCharacteristic(0)+V_flow_single*noEvent(if abs(V_flow_single_init)>0 then delta_head_init/V_flow_single_init else 0)));
      V_flow_single = homotopy(if s > 0 then s*unitMassFlowRate/rho else 0,
                               s*unitMassFlowRate/rho_nominal);
    end if;
    // Power consumption
    if use_powerCharacteristic then
      W_single = homotopy((N/N_nominal)^3*(rho/rho_nominal)*powerCharacteristic(V_flow_single*N_nominal/N),
                          N/N_nominal*V_flow_single/V_flow_single_init*powerCharacteristic(V_flow_single_init));
      eta = dp_pump*V_flow_single/W_single;
    else
      eta = homotopy(efficiencyCharacteristic(V_flow_single*(N_nominal/N)),
                     efficiencyCharacteristic(V_flow_single_init));
      W_single = homotopy(dp_pump*V_flow_single/eta,
                          dp_pump*V_flow_single_init/eta);
    end if;

    // Energy balance
    Wb_flow = W_total;
    Qb_flow = heatTransfer.Q_flows[1];
    Hb_flow = port_a.m_flow*actualStream(port_a.h_outflow) +
              port_b.m_flow*actualStream(port_b.h_outflow);

    // Ports
    port_a.h_outflow = medium.h;
    port_b.h_outflow = medium.h;
    port_b.p = medium.p
        "outlet pressure is equal to medium pressure, which includes Wb_flow";

    // Mass balance
    mb_flow = port_a.m_flow + port_b.m_flow;

    mbXi_flow = port_a.m_flow*actualStream(port_a.Xi_outflow) +
                port_b.m_flow*actualStream(port_b.Xi_outflow);
    port_a.Xi_outflow = medium.Xi;
    port_b.Xi_outflow = medium.Xi;

    mbC_flow = port_a.m_flow*actualStream(port_a.C_outflow) +
               port_b.m_flow*actualStream(port_b.C_outflow);
    port_a.C_outflow = C;
    port_b.C_outflow = C;

    connect(heatTransfer.heatPorts[1], heatPort) annotation (Line(
        points={{40,-34},{40,-60}}, color={127,0,0}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
                100}}), graphics={
            Rectangle(
              extent={{-100,46},{100,-46}},
              fillColor={0,127,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Polygon(
              points={{-48,-60},{-72,-100},{72,-100},{48,-60},{-48,-60}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillPattern=FillPattern.VerticalCylinder),
            Ellipse(
              extent={{-80,80},{80,-80}},
              fillPattern=FillPattern.Sphere,
              fillColor={0,100,199}),
            Polygon(
              points={{-28,30},{-28,-30},{50,-2},{-28,30}},
              pattern=LinePattern.None,
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={255,255,255})}),
      Documentation(info="<html>
<p>This is the base model for pumps.</p>
<p>The model describes a centrifugal pump, or a group of <code>nParallel</code> identical pumps. The pump model is based on the theory of kinematic similarity: the pump characteristics are given for nominal operating conditions (rotational speed and fluid density), and then adapted to actual operating condition, according to the similarity equations.</p>

<p><strong>Pump characteristics</strong></p>
<p> The nominal hydraulic characteristic (head vs. volume flow rate) is given by the replaceable function <code>flowCharacteristic</code>.</p>
<p> The pump energy balance can be specified in two alternative ways:</p>
<ul>
<li><code>use_powerCharacteristic = false</code> (default option): the replaceable function <code>efficiencyCharacteristic</code> (efficiency vs. volume flow rate in nominal conditions) is used to determine the efficiency, and then the power consumption.
    The default is a constant efficiency of 0.8.</li>
<li><code>use_powerCharacteristic = true</code>: the replaceable function <code>powerCharacteristic</code> (power consumption vs. volume flow rate in nominal conditions) is used to determine the power consumption, and then the efficiency.
    Use <code>powerCharacteristic</code> to specify a non-zero power consumption for zero flow rate.</li>
</ul>
<p>
Several functions are provided in the package <code>PumpCharacteristics</code> to specify the characteristics as a function of some operating points at nominal conditions.
</p>
<p>Depending on the value of the <code>checkValve</code> parameter, the model either supports reverse flow conditions, or includes a built-in check valve to avoid flow reversal.
</p>
<p>It is possible to take into account the mass and energy storage of the fluid inside the pump by specifying its volume <code>V</code>, and by selecting appropriate dynamic mass and energy balance assumptions (see below);
this is recommended to avoid singularities in the computation of the outlet enthalpy in case of zero flow rate.
If zero flow rate conditions are always avoided, this dynamic effect can be neglected by leaving the default value <code>V = 0</code>, thus avoiding fast state variables in the model.
</p>

<p><strong>Dynamics options</strong></p>
<p>
Steady-state mass and energy balances are assumed per default, neglecting the holdup of fluid in the pump; this configuration works well if the flow rate is always positive.
Dynamic mass and energy balance can be used by setting the corresponding dynamic parameters. This is recommended to avoid singularities at zero or reversing mass flow rate. If the initial conditions imply non-zero mass flow rate, it is possible to use the <code>SteadyStateInitial</code> condition, otherwise it is recommended to use <code>FixedInitial</code> in order to avoid undetermined initial conditions.
</p>

<p><strong>Heat transfer</strong></p>
<p>
The Boolean parameter <code>use_HeatTransfer</code> can be set to true if heat exchanged with the environment
should be taken into account or to model a housing. This might be desirable if a pump with realistic
<code>powerCharacteristic</code> for zero flow operates while a valve prevents fluid flow.
</p>

<p><strong>Diagnostics of Cavitation</strong></p>
<p>The replaceable Monitoring submodel can be configured to PumpMonitoringNPSH,
in order to compute the Net Positive Suction Head available and check for cavitation,
provided a two-phase medium model is used (see Advanced tab).
</p>
</html>",
        revisions="<html>
<ul>
<li><em>8 Jan 2013</em>
    by R&uuml;diger Franke:<br>
    moved NPSH diagnostics from PartialPump to replaceable sub-model PumpMonitoring.PumpMonitoringNPSH (see ticket #646)</li>
<li><em>Dec 2008</em>
    by R&uuml;diger Franke:<br>
    <ul>
    <li>Replaced simplified mass and energy balances with rigorous formulation (base class PartialLumpedVolume)</li>
    <li>Introduced optional HeatTransfer model defining Qb_flow</li>
    <li>Enabled events when the checkValve is operating to support the opening of a discrete valve before port_a</li>
    </ul></li>
<li><em>31 Oct 2005</em>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Model added to the Fluid library</li>
</ul>
</html>"));
  end PartialPump;

  package PumpCharacteristics "Functions for pump characteristics"
    extends Modelica.Icons.Package;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;

    partial function baseFlow "Base class for pump flow characteristics"
      extends Modelica.Icons.Function;
      input SI.VolumeFlowRate V_flow "Volumetric flow rate";
      output SI.Height head "Pump head";
    end baseFlow;

    partial function basePower
        "Base class for pump power consumption characteristics"
      extends Modelica.Icons.Function;
      input SI.VolumeFlowRate V_flow "Volumetric flow rate";
      output SI.Power consumption "Power consumption";
    end basePower;

    partial function baseEfficiency "Base class for efficiency characteristics"
      extends Modelica.Icons.Function;
      input SI.VolumeFlowRate V_flow "Volumetric flow rate";
      output Real eta "Efficiency";
    end baseEfficiency;

    function linearFlow "Linear flow characteristic"
      extends baseFlow;
      input SI.VolumeFlowRate V_flow_nominal[2]
          "Volume flow rate for two operating points (single pump)"
                                                                  annotation(Dialog);
      input SI.Height head_nominal[2] "Pump head for two operating points" annotation(Dialog);
      /* Linear system to determine the coefficients:
  head_nominal[1] = c[1] + V_flow_nominal[1]*c[2];
  head_nominal[2] = c[1] + V_flow_nominal[2]*c[2];
  */
      protected
      Real c[2] = Modelica.Math.Matrices.solve([ones(2),V_flow_nominal],head_nominal)
          "Coefficients of linear head curve";
    algorithm
      assert(c[2] <= -Modelica.Constants.small,
             "Wrong pump curve -- head_nominal must be monotonically decreasing with increasing V_flow_nominal",
             level=AssertionLevel.warning);
      // Flow equation: head = q*c[1] + c[2];
      head := c[1] + V_flow*c[2];
    end linearFlow;

    function quadraticFlow
        "Quadratic flow characteristic, including linear extrapolation"
      extends baseFlow;
      input SI.VolumeFlowRate V_flow_nominal[3]
          "Volume flow rate for three operating points (single pump)"
                                                                    annotation(Dialog);
      input SI.Height head_nominal[3] "Pump head for three operating points" annotation(Dialog);
      protected
      Real V_flow_nominal2[3] = {V_flow_nominal[1]^2,V_flow_nominal[2]^2, V_flow_nominal[3]^2}
          "Squared nominal flow rates";
      /* Linear system to determine the coefficients:
  head_nominal[1] = c[1] + V_flow_nominal[1]*c[2] + V_flow_nominal[1]^2*c[3];
  head_nominal[2] = c[1] + V_flow_nominal[2]*c[2] + V_flow_nominal[2]^2*c[3];
  head_nominal[3] = c[1] + V_flow_nominal[3]*c[2] + V_flow_nominal[3]^2*c[3];
  */
      Real c[3] = Modelica.Math.Matrices.solve([ones(3), V_flow_nominal, V_flow_nominal2],head_nominal)
          "Coefficients of quadratic head curve";
      SI.VolumeFlowRate V_flow_min = min(V_flow_nominal);
      SI.VolumeFlowRate V_flow_max = max(V_flow_nominal);
    algorithm
      assert(max(c[2].+2*c[3]*V_flow_nominal) <= -Modelica.Constants.small,
             "Wrong pump curve -- head_nominal must be monotonically decreasing with increasing V_flow_nominal",
             level=AssertionLevel.warning);
      if V_flow < V_flow_min then
        head := max(head_nominal) + (V_flow-V_flow_min)*(c[2]+2*c[3]*V_flow_min);
      elseif V_flow > V_flow_max then
        head := min(head_nominal) + (V_flow-V_flow_max)*(c[2]+2*c[3]*V_flow_max);
      else
        // Flow equation: head  = c[1] + V_flow*c[2] + V_flow^2*c[3];
        head := c[1] + V_flow*(c[2] + V_flow*c[3]);
      end if;

      annotation(Documentation(revisions="<html>
<ul>
<li><em>Jan 2013</em>
    by R&uuml;diger Franke:<br>
    Extended with linear extrapolation outside specified points</li>
</ul>
</html>"));
    end quadraticFlow;

    function polynomialFlow
        "Polynomial flow characteristic, including linear extrapolation"
      extends baseFlow;
      input SI.VolumeFlowRate V_flow_nominal[:]
          "Volume flow rate for N operating points (single pump)"
                                                                annotation(Dialog);
      input SI.Height head_nominal[:] "Pump head for N operating points" annotation(Dialog);
      protected
      Integer N = size(V_flow_nominal,1) "Number of nominal operating points";
      Real V_flow_nominal_pow[N,N] = {{if j > 1 then V_flow_nominal[i]^(j-1) else 1 for j in 1:N} for i in 1:N}
          "Rows: different operating points; columns: increasing powers";
      /* Linear system to determine the coefficients (example N=3):
  head_nominal[1] = c[1] + V_flow_nominal[1]*c[2] + V_flow_nominal[1]^2*c[3];
  head_nominal[2] = c[1] + V_flow_nominal[2]*c[2] + V_flow_nominal[2]^2*c[3];
  head_nominal[3] = c[1] + V_flow_nominal[3]*c[2] + V_flow_nominal[3]^2*c[3];
  */
      Real c[size(V_flow_nominal,1)] = Modelica.Math.Matrices.solve(V_flow_nominal_pow,head_nominal)
          "Coefficients of polynomial head curve";
      SI.VolumeFlowRate V_flow_min = min(V_flow_nominal);
      SI.VolumeFlowRate V_flow_max = max(V_flow_nominal);
      Real max_dhdV = c[2] + max(sum((i-1)*V_flow_nominal.^(i-2)*c[i] for i in 3:N));
      Real poly;
    algorithm
      assert(max_dhdV <= -Modelica.Constants.small,
             "Wrong pump curve -- head_nominal must be monotonically decreasing with increasing V_flow_nominal",
             level=AssertionLevel.warning);
      if V_flow < V_flow_min then
        //head := max(head_nominal) + (V_flow-V_flow_min)*(c[2]+sum((i-1)*V_flow_min^(i-2)*c[i] for i in 3:N));
        poly := c[N]*(N-1);
        for i in 1:N-2 loop
          poly := V_flow_min*poly + c[N-i]*(N-i-1);
        end for;
        head := max(head_nominal) + (V_flow-V_flow_min)*poly;
      elseif V_flow > V_flow_max then
        //head := min(head_nominal) + (V_flow-V_flow_max)*(c[2]+sum((i-1)*V_flow_max^(i-2)*c[i] for i in 3:N));
        poly := c[N]*(N-1);
        for i in 1:N-2 loop
          poly := V_flow_max*poly + c[N-i]*(N-i-1);
        end for;
        head := min(head_nominal) + (V_flow-V_flow_max)*poly;
      else
        // Flow equation (example N=3): head  = c[1] + V_flow*c[2] + V_flow^2*c[3];
        // Note: the implementation is numerically efficient only for low values of Na
        //head := sum(V_flow^(i-1)*c[i] for i in 1:N);
        poly := c[N];
        for i in 1:N-1 loop
          poly := V_flow*poly + c[N-i];
         end for;
        head := poly;
      end if;

      annotation(Documentation(revisions="<html>
<ul>
<li><em>Jan 2013</em>
    by R&uuml;diger Franke:<br>
    Extended with linear extrapolation outside specified points and reformulated polynomial evaluation</li>
</ul>
</html>"));
    end polynomialFlow;

    function constantEfficiency "Constant efficiency characteristic"
       extends baseEfficiency;
       input Real eta_nominal "Nominal efficiency" annotation(Dialog);
    algorithm
      eta := eta_nominal;
    end constantEfficiency;

    function linearPower "Linear power consumption characteristic"
      extends basePower;
      input SI.VolumeFlowRate V_flow_nominal[2]
          "Volume flow rate for two operating points (single pump)" annotation(Dialog);
      input SI.Power W_nominal[2] "Power consumption for two operating points" annotation(Dialog);
      /* Linear system to determine the coefficients:
  W_nominal[1] = c[1] + V_flow_nominal[1]*c[2];
  W_nominal[2] = c[1] + V_flow_nominal[2]*c[2];
  */
      protected
      Real c[2] = Modelica.Math.Matrices.solve([ones(3),V_flow_nominal],W_nominal)
          "Coefficients of linear power consumption curve";
    algorithm
      consumption := c[1] + V_flow*c[2];
    end linearPower;

    function quadraticPower "Quadratic power consumption characteristic"
      extends basePower;
      input SI.VolumeFlowRate V_flow_nominal[3]
          "Volume flow rate for three operating points (single pump)"
                                                                    annotation(Dialog);
      input SI.Power W_nominal[3]
          "Power consumption for three operating points" annotation(Dialog);
      protected
      Real V_flow_nominal2[3] = {V_flow_nominal[1]^2,V_flow_nominal[2]^2, V_flow_nominal[3]^2}
          "Squared nominal flow rates";
      /* Linear system to determine the coefficients:
  W_nominal[1] = c[1] + V_flow_nominal[1]*c[2] + V_flow_nominal[1]^2*c[3];
  W_nominal[2] = c[1] + V_flow_nominal[2]*c[2] + V_flow_nominal[2]^2*c[3];
  W_nominal[3] = c[1] + V_flow_nominal[3]*c[2] + V_flow_nominal[3]^2*c[3];
  */
      Real c[3] = Modelica.Math.Matrices.solve([ones(3),V_flow_nominal,V_flow_nominal2],W_nominal)
          "Coefficients of quadratic power consumption curve";
    algorithm
      consumption := c[1] + V_flow*c[2] + V_flow^2*c[3];
    end quadraticPower;

  end PumpCharacteristics;

    package PumpMonitoring "Monitoring of pump operation"
      extends Modelica.Icons.Package;
      model PumpMonitoringBase "Interface for pump monitoring"
        outer Modelica.Fluid.System system "System wide properties";
        //
        // Internal interface
        // (not exposed to GUI; needs to be hard coded when using this model
        //
        replaceable package Medium =
          Modelica.Media.Interfaces.PartialMedium "Medium in the component"
            annotation(Dialog(tab="Internal Interface",enable=false));

        // Inputs
        input Medium.ThermodynamicState state_in
          "Thermodynamic state of inflow";
        input Medium.ThermodynamicState state "Thermodynamic state in the pump";

      end PumpMonitoringBase;

      model PumpMonitoringNPSH "Monitor Net Positive Suction Head (NPSH)"
        extends PumpMonitoringBase(redeclare replaceable package Medium =
          Modelica.Media.Interfaces.PartialTwoPhaseMedium);
        Medium.Density rho_in = Medium.density(state_in)
          "Liquid density at the inlet port_a";
        SI.Length NPSHa=NPSPa/(rho_in*system.g)
          "Net Positive Suction Head available";
        SI.Pressure NPSPa=assertPositiveDifference(Medium.pressure(state_in), Medium.saturationPressure(Medium.temperature(state_in)),
                                                   "Cavitation occurs at the pump inlet")
          "Net Positive Suction Pressure available";
        SI.Pressure NPDPa=assertPositiveDifference(Medium.pressure(state), Medium.saturationPressure(Medium.temperature(state)),
                                                   "Cavitation occurs in the pump")
          "Net Positive Discharge Pressure available";
      end PumpMonitoringNPSH;

      function assertPositiveDifference
        extends Modelica.Icons.Function;
        input SI.Pressure p;
        input SI.Pressure p_sat;
        input String message;
        output SI.Pressure dp;
      algorithm
        dp := p - p_sat;
        assert(p >= p_sat, message);
      end assertPositiveDifference;
    end PumpMonitoring;
  end BaseClasses;
  annotation (Documentation(info="<html>

</html>"));
end Machines;
