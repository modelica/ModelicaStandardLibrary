within Modelica.Fluid;
package Machines
  "Devices for converting between energy held in a fluid and mechanical energy"
  extends Modelica.Fluid.Icons.VariantLibrary;
  model SweptVolume
    "varying cylindric volume depending on the postition of the piston"
    import Modelica.Constants.pi;

    parameter SI.Area pistonCrossArea "cross sectional area of pistion";
    parameter SI.Volume clearance "remaining volume at zero piston stroke";

    SI.Volume V "fluid volume";

    // Mass and energy balance, ports
    extends Modelica.Fluid.Vessels.BaseClasses.PartialLumpedVessel(
      final fluidVolume = V,
      heatTransfer(surfaceAreas={pistonCrossArea+2*sqrt(pistonCrossArea*pi)*(flange.s+clearance/pistonCrossArea)}));

    Modelica.Mechanics.Translational.Interfaces.Flange_b flange
      "translation flange for piston" annotation (Placement(transformation(
            extent={{-10,90},{10,110}},   rotation=0)));

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

    annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
              -100},{100,100}}),
                        graphics),
                         Icon(coordinateSystem(preserveAspectRatio=true,
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
            smooth=Smooth.None,
            fillColor={135,135,135},
            fillPattern=FillPattern.Backward),
          Polygon(
            points={{48,60},{52,60},{52,-34},{48,-34},{48,60}},
            lineColor={95,95,95},
            smooth=Smooth.None,
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
            smooth=Smooth.None,
            fillColor={135,135,135},
            fillPattern=FillPattern.Backward),
          Line(
            visible=use_HeatTransfer,
            points={{-100,0},{-52,0}},
            smooth=Smooth.None,
            color={198,0,0})}),
      Documentation(info="<html>
<p> Mixing volume with varying size. The size of the volume is given by:</p>
<ul>
  <li>cross sectional piston area</li>
  <li>piston stroke given by the flange position s</li>
  <li>clearance (volume at flang position = 0)</li>
</ul>
<p>Losses are neglected. The shaft power is completely converted into mechanical work on the fluid. </p>

<p> The flange position has to be equal or greater than zero. Otherwise the simulation stops. The force of the flange results from the pressure difference between medium and ambient pressure and the cross sectional piston area. For using the component, a top level instance of the ambient model with the inner attribute is needed.</p>
<p> The pressure at both fluid ports equals the medium pressure in the volume. No suction nor discharge valve is included in the model.</p>
<p>The thermal port is directly connected to the medium. The temperature of the thermal port equals the medium temperature. The heat capacity of the cylinder and the piston are not includes in the model.</p>
</html>",
        revisions="<html>
<ul>
<li><i>29 Oct 2007</i>
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
    annotation (Placement(transformation(extent={{-10,90},{10,110}},
                                                                   rotation=0)));
  equation
    phi = shaft.phi;
    omega = der(phi);
    N = Modelica.SIunits.Conversions.to_rpm(omega);
    W_single = omega*shaft.tau;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Rectangle(
            extent={{-10,100},{10,78}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={95,95,95})}),
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}),
            graphics),
    Documentation(info="<HTML>
<p>This model describes a centrifugal pump (or a group of <tt>nParallel</tt> pumps) with a mechanical rotational connector for the shaft, to be used when the pump drive has to be modelled explicitly. In the case of <tt>nParallel</tt> pumps, the mechanical connector is relative to a single pump.
<p>The model extends <tt>PartialPump</tt>
 </HTML>",
       revisions="<html>
<ul>
<li><i>31 Oct 2005</i>
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
      Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}), graphics),
      Documentation(info="<HTML>
<p>
This model describes a centrifugal pump (or a group of <tt>nParallel</tt> pumps)
with ideally controlled mass flow rate or pressure.
</p>
<p>
Nominal values are used to predefine an exemplary pump characteristics and to define the operation of the pump.
The input connectors <tt>m_flow_set</tt> or <tt>p_set</tt> can optionally be enabled to provide time varying set points.
</p>
<p>
Use this model if the pump characteristics is of secondary interest.
The actual characteristics can be configured later on for the appropriate rotational speed N.
Then the model can be replaced with a Pump with rotational shaft or with a PrescribedPump.
</p>
</HTML>",
        revisions="<html>
<ul>
<li><i>15 Dec 2008</i>
    by Ruediger Franke</a>:<br>
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
    Modelica.Blocks.Interfaces.RealInput N_in(unit="1/min") if use_N_in
      "Prescribed rotational speed"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,100}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,100})));

  protected
    Modelica.Blocks.Interfaces.RealInput N_in_internal(unit="1/min")
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
      Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}), graphics),
      Documentation(info="<HTML>
<p>This model describes a centrifugal pump (or a group of <tt>nParallel</tt> pumps) with prescribed speed, either fixed or provided by an external signal.
<p>The model extends <tt>PartialPump</tt>
<p>If the <tt>N_in</tt> input connector is wired, it provides rotational speed of the pumps (rpm); otherwise, a constant rotational speed equal to <tt>n_const</tt> (which can be different from <tt>N_nominal</tt>) is assumed.</p>
</HTML>",
        revisions="<html>
<ul>
<li><i>31 Oct 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Model added to the Fluid library</li>
</ul>
</html>"));
  end PrescribedPump;

  package BaseClasses
    "Base classes used in the Machines package (only of interest to build new component models)"
    extends Modelica.Fluid.Icons.BaseClassLibrary;

  partial model PartialPump "Base model for centrifugal pumps"
      import Modelica.SIunits.Conversions.NonSIunits.*;
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
    parameter Medium.MassFlowRate m_flow_start = 1
        "Guess value of m_flow = port_a.m_flow"
      annotation(Dialog(tab = "Initialization"));

    // Characteristics
    parameter Integer nParallel(min=1) = 1 "Number of pumps in parallel"
      annotation(Dialog(group="Characteristics"));
    replaceable function flowCharacteristic =
        PumpCharacteristics.baseFlow
        "Head vs. V_flow characteristic at nominal speed and density"
      annotation(Dialog(group="Characteristics"), choicesAllMatching=true);
    parameter AngularVelocity_rpm N_nominal
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

    // Heat transfer through boundary, e.g. to add a housing
    parameter Boolean use_HeatTransfer = false
        "= true to use a HeatTransfer model, e.g. for a housing"
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
    SI.VolumeFlowRate V_flow = m_flow/rho "Volume flow rate (total)";
    SI.VolumeFlowRate V_flow_single(start = m_flow_start/rho_nominal/nParallel) = V_flow/nParallel
        "Volume flow rate (single pump)";
    AngularVelocity_rpm N(start = N_nominal) "Shaft rotational speed";
    SI.Power W_single "Power Consumption (single pump)";
    SI.Power W_total = W_single*nParallel "Power Consumption (total)";
    Real eta "Global Efficiency";
    Real s(start = m_flow_start)
        "Curvilinear abscissa for the flow curve in parametric form (either mass flow rate or head)";

    // Diagnostics
    parameter Boolean show_NPSHa = false
        "= true to compute Net Positive Suction Head available"
      annotation(Dialog(tab="Advanced", group="Diagnostics"));
    Medium.ThermodynamicState state_a=
      Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow)) if
         show_NPSHa "state for medium inflowing through port_a";
    Medium.Density rho_in = Medium.density(state_a) if show_NPSHa
        "Liquid density at the inlet port_a";
    SI.Length NPSHa=NPSPa/(rho_in*system.g) if show_NPSHa
        "Net Positive Suction Head available";
    SI.Pressure NPSPa=assertPositiveDifference(port_a.p, Medium.saturationPressure(Medium.temperature(state_a)),
                                               "Cavitation occurs at the pump inlet") if show_NPSHa
        "Net Positive Suction Pressure available";
    SI.Pressure NPDPa=assertPositiveDifference(port_b.p, Medium.saturationPressure(medium.T),
                                               "Cavitation occurs in the pump") if show_NPSHa
        "Net Positive Discharge Pressure available";
    protected
    constant SI.Height unitHead = 1;
    constant SI.MassFlowRate unitMassFlowRate = 1;

  equation
    // Flow equations
    if not checkValve then
      // Regular flow characteristics without check valve
      head = (N/N_nominal)^2*flowCharacteristic(V_flow_single*(N_nominal/N));
      s = 0;
    elseif s > 0 then
      // Flow characteristics when check valve is open
      head = (N/N_nominal)^2*flowCharacteristic(V_flow_single*(N_nominal/N));
      V_flow_single = s*unitMassFlowRate/rho;
    else
      // Flow characteristics when check valve is closed
      head = (N/N_nominal)^2*flowCharacteristic(0) - s*unitHead;
      V_flow_single = 0;
    end if;

    // Power consumption
    if use_powerCharacteristic then
      W_single = (N/N_nominal)^3*(rho/rho_nominal)*powerCharacteristic(V_flow_single*(N_nominal/N));
      eta = dp_pump*V_flow_single/W_single;
    else
      eta = efficiencyCharacteristic(V_flow_single*(N_nominal/N));
      W_single = dp_pump*V_flow_single/eta;
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
        points={{40,-34},{40,-60}},
        color={127,0,0},
        smooth=Smooth.None));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
                100}}), graphics={
            Rectangle(
              extent={{-100,46},{100,-46}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Polygon(
              points={{-48,-60},{-72,-100},{72,-100},{48,-60},{-48,-60}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder),
            Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={0,100,199}),
            Polygon(
              points={{-28,30},{-28,-30},{50,-2},{-28,30}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={255,255,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
                100,100}}),
              graphics),
      Documentation(info="<HTML>
<p>This is the base model for pumps.
<p>The model describes a centrifugal pump, or a group of <tt>nParallel</tt> identical pumps. The pump model is based on the theory of kinematic similarity: the pump characteristics are given for nominal operating conditions (rotational speed and fluid density), and then adapted to actual operating condition, according to the similarity equations.

<p><b>Pump characteristics</b></p>
<p> The nominal hydraulic characteristic (head vs. volume flow rate) is given by the the replaceable function <tt>flowCharacteristic</tt>.
<p> The pump energy balance can be specified in two alternative ways:
<ul>
<li><tt>use_powerCharacteristic = false</tt> (default option): the replaceable function <tt>efficiencyCharacteristic</tt> (efficiency vs. volume flow rate in nominal conditions) is used to determine the efficiency, and then the power consumption.
    The default is a constant efficiency of 0.8.</li>
<li><tt>use_powerCharacteristic = true</tt>: the replaceable function <tt>powerCharacteristic</tt> (power consumption vs. volume flow rate in nominal conditions) is used to determine the power consumption, and then the efficiency.
    Use <tt>powerCharacteristic</tt> to specify a non-zero power consumption for zero flow rate.
</ul>
<p>
Several functions are provided in the package <tt>PumpCharacteristics</tt> to specify the characteristics as a function of some operating points at nominal conditions.
<p>Depending on the value of the <tt>checkValve</tt> parameter, the model either supports reverse flow conditions, or includes a built-in check valve to avoid flow reversal.
</p>
<p>It is possible to take into account the heat capacity of the fluid inside the pump by specifying its volume <tt>V</tt>;
this is necessary to avoid singularities in the computation of the outlet enthalpy in case of zero flow rate.
If zero flow rate conditions are always avoided, this dynamic effect can be neglected by leaving the default value <tt>V = 0</tt>, thus avoiding a fast state variable in the model.
</p>

<p><b>Dynamics options</b></p>
<p>
Steady-state mass and energy balances are assumed per default, neglecting the holdup of fluid in the pump.
Dynamic mass and energy balance can be used by setting the corresponding dynamic parameters.
This might be desirable if the pump is assembled together with valves before port_a and behind port_b.
If both valves are closed, then the fluid is useful to define the thermodynamic state and in particular the absolute pressure in the pump.
Note that the <tt>flowCharacteristic</tt> only specifies a pressure difference.
</p>

<p><b>Heat transfer</b></p>
<p>
The boolean paramter <tt>use_HeatTransfer</tt> can be set to true if heat exchanged with the environment
should be taken into account or to model a housing. This might be desirable if a pump with realistic
<tt>powerCharacteristic</tt> for zero flow operates while a valve prevents fluid flow.
</p>

<p><b>Diagnostics of Cavitation</b></p>
<p>The boolean parameter show_NPSHa can set true to compute the Net Positive Suction Head available and check for cavitation,
provided a two-phase medium model is used.
</p>
</HTML>",
        revisions="<html>
<ul>
<li><i>Dec 2008</i>
    by R&uuml;diger Franke:<br>
    <ul>
    <li>Replaced simplified mass and energy balances with rigorous formulation (base class PartialLumpedVolume)</li>
    <li>Introduced optional HeatTransfer model defining Qb_flow</li>
    <li>Enabled events when the checkValve is operating to support the opening of a discrete valve before port_a</li>
    </ul></li>
<li><i>31 Oct 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Model added to the Fluid library</li>
</ul>
</html>"));

  end PartialPump;

  package PumpCharacteristics "Functions for pump characteristics"
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
      // Flow equation: head = q*c[1] + c[2];
      head := c[1] + V_flow*c[2];
    end linearFlow;

    function quadraticFlow "Quadratic flow characteristic"
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
    algorithm
      // Flow equation: head  = c[1] + V_flow*c[2] + V_flow^2*c[3];
      head := c[1] + V_flow*c[2] + V_flow^2*c[3];
    end quadraticFlow;

    function polynomialFlow "Polynomial flow characteristic"
      extends baseFlow;
      input SI.VolumeFlowRate V_flow_nominal[:]
          "Volume flow rate for N operating points (single pump)"
                                                                annotation(Dialog);
      input SI.Height head_nominal[:] "Pump head for N operating points" annotation(Dialog);
      protected
      Integer N = size(V_flow_nominal,1) "Number of nominal operating points";
      Real V_flow_nominal_pow[N,N] = {{V_flow_nominal[i]^(j-1) for j in 1:N} for i in 1:N}
          "Rows: different operating points; columns: increasing powers";
      /* Linear system to determine the coefficients (example N=3):
  head_nominal[1] = c[1] + V_flow_nominal[1]*c[2] + V_flow_nominal[1]^2*c[3];
  head_nominal[2] = c[1] + V_flow_nominal[2]*c[2] + V_flow_nominal[2]^2*c[3];
  head_nominal[3] = c[1] + V_flow_nominal[3]*c[2] + V_flow_nominal[3]^2*c[3];
  */
      Real c[N] = Modelica.Math.Matrices.solve(V_flow_nominal_pow,head_nominal)
          "Coefficients of polynomial head curve";
    algorithm
      // Flow equation (example N=3): head  = c[1] + V_flow*c[2] + V_flow^2*c[3];
      // Note: the implementation is numerically efficient only for low values of Na
      head := sum(V_flow^(i-1)*c[i] for i in 1:N);
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
      input SI.Power W_nominal[2] "Power consumption for two operating points"   annotation(Dialog);
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
          "Power consumption for three operating points"                         annotation(Dialog);
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

  end BaseClasses;
  annotation (Documentation(info="<html>

</html>"));
end Machines;
