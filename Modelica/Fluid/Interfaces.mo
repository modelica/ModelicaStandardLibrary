within Modelica.Fluid;
package Interfaces
  "Interfaces for steady state and unsteady, mixed-phase, multi-substance, incompressible and compressible flow"

  extends Modelica.Icons.InterfacesPackage;

  connector FluidPort
    "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)"

    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
      "Medium model" annotation (choicesAllMatching=true);

    flow Medium.MassFlowRate m_flow
      "Mass flow rate from the connection point into the component";
    Medium.AbsolutePressure p "Thermodynamic pressure in the connection point";
    stream Medium.SpecificEnthalpy h_outflow
      "Specific thermodynamic enthalpy close to the connection point if m_flow < 0";
    stream Medium.MassFraction Xi_outflow[Medium.nXi]
      "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0";
    stream Medium.ExtraProperty C_outflow[Medium.nC]
      "Properties c_i/m close to the connection point if m_flow < 0";
  end FluidPort;

  connector FluidPort_a "Generic fluid connector at design inlet"
    extends FluidPort;
    annotation (defaultComponentName="port_a",
                Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Ellipse(
            extent={{-40,40},{40,-40}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid), Text(extent={{-150,110},{150,50}},
              textString="%name")}),
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,127,255},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid), Ellipse(
            extent={{-100,100},{100,-100}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid)}));
  end FluidPort_a;

  connector FluidPort_b "Generic fluid connector at design outlet"
    extends FluidPort;
    annotation (defaultComponentName="port_b",
                Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(
            extent={{-40,40},{40,-40}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-30,30},{30,-30}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(extent={{-150,110},{150,50}}, textString="%name")}),
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={
          Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,127,255},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-100,100},{100,-100}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,80},{80,-80}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}));
  end FluidPort_b;

  connector FluidPorts_a
    "Fluid connector with filled, large icon to be used for vectors of FluidPorts (vector dimensions must be added after dragging)"
    extends FluidPort;
    annotation (defaultComponentName="ports_a",
                Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-50,-200},{50,200}},
          initialScale=0.2), graphics={
          Text(extent={{-75,130},{75,100}}, textString="%name"),
          Rectangle(
            extent={{25,-100},{-25,100}},
            lineColor={0,127,255}),
          Ellipse(
            extent={{-25,90},{25,40}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-25,25},{25,-25}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-25,-40},{25,-90}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid)}),
         Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-50,-200},{50,200}},
          initialScale=0.2), graphics={
          Rectangle(
            extent={{50,-200},{-50,200}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-50,180},{50,80}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-50,50},{50,-50}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-50,-80},{50,-180}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid)}));
  end FluidPorts_a;

  connector FluidPorts_b
    "Fluid connector with outlined, large icon to be used for vectors of FluidPorts (vector dimensions must be added after dragging)"
    extends FluidPort;
    annotation (defaultComponentName="ports_b",
                Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-50,-200},{50,200}},
          initialScale=0.2), graphics={
          Text(extent={{-75,130},{75,100}}, textString="%name"),
          Rectangle(
            extent={{-25,100},{25,-100}}),
          Ellipse(
            extent={{-25,90},{25,40}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-25,25},{25,-25}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-25,-40},{25,-90}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-15,-50},{15,-80}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-15,15},{15,-15}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-15,50},{15,80}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
         Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-50,-200},{50,200}},
          initialScale=0.2), graphics={
          Rectangle(
            extent={{-50,200},{50,-200}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-50,180},{50,80}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-50,50},{50,-50}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-50,-80},{50,-180}},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-30,30},{30,-30}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-30,100},{30,160}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-30,-100},{30,-160}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}));
  end FluidPorts_b;

  partial model PartialTwoPort "Partial component with two ports"
    import Modelica.Constants;
    outer Modelica.Fluid.System system "System wide properties";

    replaceable package Medium =
        Modelica.Media.Interfaces.PartialMedium "Medium in the component"
        annotation (choicesAllMatching = true);

    parameter Boolean allowFlowReversal = system.allowFlowReversal
      "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
      annotation(Dialog(tab="Assumptions"), Evaluate=true);

    Modelica.Fluid.Interfaces.FluidPort_a port_a(
                                  redeclare package Medium = Medium,
                       m_flow(min=if allowFlowReversal then -Constants.inf else 0))
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(
                                  redeclare package Medium = Medium,
                       m_flow(max=if allowFlowReversal then +Constants.inf else 0))
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{110,-10},{90,10}}), iconTransformation(extent={{110,-10},{90,10}})));
    // Model structure, e.g., used for visualization
  protected
    parameter Boolean port_a_exposesState = false
      "= true if port_a exposes the state of a fluid volume";
    parameter Boolean port_b_exposesState = false
      "= true if port_b.p exposes the state of a fluid volume";
    parameter Boolean showDesignFlowDirection = true
      "= false to hide the arrow in the model icon";

    annotation (
      Documentation(info="<html>
<p>
This partial model defines an interface for components with two ports.
The treatment of the design flow direction and of flow reversal are predefined based on the parameter <code><strong>allowFlowReversal</strong></code>.
The component may transport fluid and may have internal storage for a given fluid <code><strong>Medium</strong></code>.
</p>
<p>
An extending model providing direct access to internal storage of mass or energy through port_a or port_b
should redefine the protected parameters <code><strong>port_a_exposesState</strong></code> and <code><strong>port_b_exposesState</strong></code> appropriately.
This will be visualized at the port icons, in order to improve the understanding of fluid model diagrams.
</p>
</html>"),
      Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
          Polygon(
            points={{20,-70},{60,-85},{20,-100},{20,-70}},
            lineColor={0,128,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            visible=showDesignFlowDirection),
          Polygon(
            points={{20,-75},{50,-85},{20,-95},{20,-75}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            visible=allowFlowReversal),
          Line(
            points={{55,-85},{-60,-85}},
            color={0,128,255},
            visible=showDesignFlowDirection),
          Text(
            extent={{-149,-114},{151,-154}},
            lineColor={0,0,255},
            textString="%name"),
          Ellipse(
            extent={{-110,26},{-90,-24}},
            fillPattern=FillPattern.Solid,
            visible=port_a_exposesState),
          Ellipse(
            extent={{90,25},{110,-25}},
            fillPattern=FillPattern.Solid,
            visible=port_b_exposesState)}));
  end PartialTwoPort;

partial model PartialTwoPortTransport
    "Partial element transporting fluid between two ports without storage of mass or energy"

  extends PartialTwoPort(
    final port_a_exposesState=false,
    final port_b_exposesState=false);

  // Advanced
  // Note: value of dp_start shall be refined by derived model, basing on local dp_nominal
  parameter Medium.AbsolutePressure dp_start(min=-Modelica.Constants.inf) = 0.01*system.p_start
      "Guess value of dp = port_a.p - port_b.p"
    annotation(Dialog(tab = "Advanced"));
  parameter Medium.MassFlowRate m_flow_start = system.m_flow_start
      "Guess value of m_flow = port_a.m_flow"
    annotation(Dialog(tab = "Advanced"));
  // Note: value of m_flow_small shall be refined by derived model, basing on local m_flow_nominal
  parameter Medium.MassFlowRate m_flow_small = if system.use_eps_Re then system.eps_m_flow*system.m_flow_nominal else system.m_flow_small
      "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab = "Advanced"));

  // Diagnostics
  parameter Boolean show_T = true
      "= true, if temperatures at port_a and port_b are computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean show_V_flow = true
      "= true, if volume flow rate at inflowing port is computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));

  // Variables
  Medium.MassFlowRate m_flow(
     min=if allowFlowReversal then -Modelica.Constants.inf else 0,
     start = m_flow_start) "Mass flow rate in design flow direction";
  Modelica.SIunits.Pressure dp(start=dp_start)
      "Pressure difference between port_a and port_b (= port_a.p - port_b.p)";

  Modelica.SIunits.VolumeFlowRate V_flow=
      m_flow/Modelica.Fluid.Utilities.regStep(m_flow,
                  Medium.density(state_a),
                  Medium.density(state_b),
                  m_flow_small) if show_V_flow
      "Volume flow rate at inflowing port (positive when flow from port_a to port_b)";

  Medium.Temperature port_a_T=
      Modelica.Fluid.Utilities.regStep(port_a.m_flow,
                  Medium.temperature(state_a),
                  Medium.temperature(Medium.setState_phX(port_a.p, port_a.h_outflow, port_a.Xi_outflow)),
                  m_flow_small) if show_T
      "Temperature close to port_a, if show_T = true";
  Medium.Temperature port_b_T=
      Modelica.Fluid.Utilities.regStep(port_b.m_flow,
                  Medium.temperature(state_b),
                  Medium.temperature(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow)),
                  m_flow_small) if show_T
      "Temperature close to port_b, if show_T = true";
  protected
  Medium.ThermodynamicState state_a "state for medium inflowing through port_a";
  Medium.ThermodynamicState state_b "state for medium inflowing through port_b";
equation
  // medium states
  state_a = Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow));
  state_b = Medium.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow));

  // Pressure drop in design flow direction
  dp = port_a.p - port_b.p;

  // Design direction of mass flow rate
  m_flow = port_a.m_flow;
  assert(m_flow > -m_flow_small or allowFlowReversal, "Reversing flow occurs even though allowFlowReversal is false");

  // Mass balance (no storage)
  port_a.m_flow + port_b.m_flow = 0;

  // Transport of substances
  port_a.Xi_outflow = inStream(port_b.Xi_outflow);
  port_b.Xi_outflow = inStream(port_a.Xi_outflow);

  port_a.C_outflow = inStream(port_b.C_outflow);
  port_b.C_outflow = inStream(port_a.C_outflow);

  annotation (
    Documentation(info="<html>
<p>
This component transports fluid between its two ports, without storing mass or energy.
Energy may be exchanged with the environment though, e.g., in the form of work.
<code>PartialTwoPortTransport</code> is intended as base class for devices like orifices, valves and simple fluid machines.</p>
<p>
Three equations need to be added by an extending class using this component:
</p>
<ul>
<li>the momentum balance specifying the relationship between the pressure drop <code>dp</code> and the mass flow rate <code>m_flow</code>,</li>
<li><code>port_b.h_outflow</code> for flow in design direction, and</li>
<li><code>port_a.h_outflow</code> for flow in reverse direction.</li>
</ul>
<p>
Moreover appropriate values shall be assigned to the following parameters:
</p>
<ul>
<li><code>dp_start</code> for a guess of the pressure drop</li>
<li><code>m_flow_small</code> for regularization of zero flow.</li>
</ul>
</html>"));
end PartialTwoPortTransport;

  connector HeatPorts_a
    "HeatPort connector with filled, large icon to be used for vectors of HeatPorts (vector dimensions must be added after dragging)"
    extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort;
    annotation (defaultComponentName="heatPorts_a",
         Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-50},{200,50}},
          initialScale=0.2), graphics={
          Rectangle(
            extent={{-201,50},{200,-50}},
            lineColor={127,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-171,45},{-83,-45}},
            lineColor={127,0,0},
            fillColor={127,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-45,45},{43,-45}},
            lineColor={127,0,0},
            fillColor={127,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{82,45},{170,-45}},
            lineColor={127,0,0},
            fillColor={127,0,0},
            fillPattern=FillPattern.Solid)}));
  end HeatPorts_a;

  connector HeatPorts_b
    "HeatPort connector with filled, large icon to be used for vectors of HeatPorts (vector dimensions must be added after dragging)"
    extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort;
    annotation (defaultComponentName="heatPorts_b",
         Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-50},{200,50}},
          initialScale=0.2), graphics={
          Rectangle(
            extent={{-200,50},{200,-51}},
            lineColor={127,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-170,44},{-82,-46}},
            lineColor={127,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-44,46},{44,-44}},
            lineColor={127,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{82,45},{170,-45}},
            lineColor={127,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}));
  end HeatPorts_b;

  partial model PartialHeatTransfer "Common interface for heat transfer models"

    // Parameters
    replaceable package Medium=Modelica.Media.Interfaces.PartialMedium
      "Medium in the component"
      annotation(Dialog(tab="Internal Interface",enable=false));

    parameter Integer n=1 "Number of heat transfer segments"
      annotation(Dialog(tab="Internal Interface",enable=false), Evaluate=true);

    // Inputs provided to heat transfer model
    input Medium.ThermodynamicState[n] states
      "Thermodynamic states of flow segments";

    input SI.Area[n] surfaceAreas "Heat transfer areas";

    // Outputs defined by heat transfer model
    output SI.HeatFlowRate[n] Q_flows "Heat flow rates";

    // Parameters
    parameter Boolean use_k = false
      "= true to use k value for thermal isolation"
      annotation(Dialog(tab="Internal Interface",enable=false));
    parameter SI.CoefficientOfHeatTransfer k = 0
      "Heat transfer coefficient to ambient"
      annotation(Dialog(group="Ambient"),Evaluate=true);
    parameter SI.Temperature T_ambient = system.T_ambient "Ambient temperature"
      annotation(Dialog(group="Ambient"));
    outer Modelica.Fluid.System system "System wide properties";

    // Heat ports
    Modelica.Fluid.Interfaces.HeatPorts_a[n] heatPorts
      "Heat port to component boundary"
      annotation (Placement(transformation(extent={{-10,60},{10,80}}), iconTransformation(extent={{-20,60},{20,80}})));

    // Variables
    SI.Temperature[n] Ts = Medium.temperature(states)
      "Temperatures defined by fluid states";

  equation
    if use_k then
      Q_flows = heatPorts.Q_flow + {k*surfaceAreas[i]*(T_ambient - heatPorts[i].T) for i in 1:n};
    else
      Q_flows = heatPorts.Q_flow;
    end if;

    annotation (Documentation(info="<html>
<p>
This component is a common interface for heat transfer models. The heat flow rates <code>Q_flows[n]</code> through the boundaries of n flow segments
are obtained as function of the thermodynamic <code>states</code> of the flow segments for a given fluid <code>Medium</code>,
the <code>surfaceAreas[n]</code> and the boundary temperatures <code>heatPorts[n].T</code>.
</p>
<p>
The heat loss coefficient <code>k</code> can be used to model a thermal isolation between <code>heatPorts.T</code> and <code>T_ambient</code>.</p>
<p>
An extending model implementing this interface needs to define one equation: the relation between the predefined fluid temperatures <code>Ts[n]</code>,
the boundary temperatures <code>heatPorts[n].T</code>, and the heat flow rates <code>Q_flows[n]</code>.
</p>
</html>"));
  end PartialHeatTransfer;

    partial model PartialLumpedVolume
    "Lumped volume with mass and energy balance"
    import Modelica.Fluid.Types;
    import Modelica.Fluid.Types.Dynamics;
    import Modelica.Media.Interfaces.Choices.IndependentVariables;

      outer Modelica.Fluid.System system "System properties";
      replaceable package Medium =
        Modelica.Media.Interfaces.PartialMedium "Medium in the component"
          annotation (choicesAllMatching = true);

      // Inputs provided to the volume model
      input SI.Volume fluidVolume "Volume";

      // Assumptions
      parameter Types.Dynamics energyDynamics=system.energyDynamics
      "Formulation of energy balance"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
      parameter Types.Dynamics massDynamics=system.massDynamics
      "Formulation of mass balance"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
      final parameter Types.Dynamics substanceDynamics=massDynamics
      "Formulation of substance balance"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
      final parameter Types.Dynamics traceDynamics=massDynamics
      "Formulation of trace substance balance"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));

      // Initialization
      parameter Medium.AbsolutePressure p_start = system.p_start
      "Start value of pressure"
        annotation(Dialog(tab = "Initialization"));
      parameter Boolean use_T_start = true
      "= true, use T_start, otherwise h_start"
        annotation(Dialog(tab = "Initialization"), Evaluate=true);
      parameter Medium.Temperature T_start=
        if use_T_start then system.T_start else Medium.temperature_phX(p_start,h_start,X_start)
      "Start value of temperature"
        annotation(Dialog(tab = "Initialization", enable = use_T_start));
      parameter Medium.SpecificEnthalpy h_start=
        if use_T_start then Medium.specificEnthalpy_pTX(p_start, T_start, X_start) else Medium.h_default
      "Start value of specific enthalpy"
        annotation(Dialog(tab = "Initialization", enable = not use_T_start));
      parameter Medium.MassFraction X_start[Medium.nX] = Medium.X_default
      "Start value of mass fractions m_i/m"
        annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
      parameter Medium.ExtraProperty C_start[Medium.nC](
           quantity=Medium.extraPropertiesNames) = Medium.C_default
      "Start value of trace substances"
        annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));

      Medium.BaseProperties medium(
        preferredMediumStates=true,
        p(start=p_start),
        h(start=h_start),
        T(start=T_start),
        Xi(start=X_start[1:Medium.nXi]));
      SI.Energy U "Internal energy of fluid";
      SI.Mass m "Mass of fluid";
      SI.Mass[Medium.nXi] mXi "Masses of independent components in the fluid";
      SI.Mass[Medium.nC] mC "Masses of trace substances in the fluid";
      // C need to be added here because unlike for Xi, which has medium.Xi,
      // there is no variable medium.C
      Medium.ExtraProperty C[Medium.nC] "Trace substance mixture content";

      // variables that need to be defined by an extending class
      SI.MassFlowRate mb_flow "Mass flows across boundaries";
      SI.MassFlowRate[Medium.nXi] mbXi_flow
      "Substance mass flows across boundaries";
      Medium.ExtraPropertyFlowRate[Medium.nC] mbC_flow
      "Trace substance mass flows across boundaries";
      SI.EnthalpyFlowRate Hb_flow
      "Enthalpy flow across boundaries or energy source/sink";
      SI.HeatFlowRate Qb_flow
      "Heat flow across boundaries or energy source/sink";
      SI.Power Wb_flow "Work flow across boundaries or source term";
  protected
      parameter Boolean initialize_p = not Medium.singleState
      "= true to set up initial equations for pressure";
      Real[Medium.nC] mC_scaled(min=fill(Modelica.Constants.eps, Medium.nC))
      "Scaled masses of trace substances in the fluid";
    equation
      assert(not (energyDynamics<>Dynamics.SteadyState and massDynamics==Dynamics.SteadyState) or Medium.singleState,
             "Bad combination of dynamics options and Medium not conserving mass if fluidVolume is fixed.");

      // Total quantities
      m = fluidVolume*medium.d;
      mXi = m*medium.Xi;
      U = m*medium.u;
      mC = m*C;

      // Energy and mass balances
      if energyDynamics == Dynamics.SteadyState then
        0 = Hb_flow + Qb_flow + Wb_flow;
      else
        der(U) = Hb_flow + Qb_flow + Wb_flow;
      end if;

      if massDynamics == Dynamics.SteadyState then
        0 = mb_flow;
      else
        der(m) = mb_flow;
      end if;

      if substanceDynamics == Dynamics.SteadyState then
        zeros(Medium.nXi) = mbXi_flow;
      else
        der(mXi) = mbXi_flow;
      end if;

      if traceDynamics == Dynamics.SteadyState then
        zeros(Medium.nC)  = mbC_flow;
      else
        der(mC_scaled) = mbC_flow./Medium.C_nominal;
      end if;
        mC = mC_scaled.*Medium.C_nominal;

    initial equation
      // initialization of balances
      if energyDynamics == Dynamics.FixedInitial then
        /*
    if use_T_start then
      medium.T = T_start;
    else
      medium.h = h_start;
    end if;
    */
        if Medium.ThermoStates == IndependentVariables.ph or
           Medium.ThermoStates == IndependentVariables.phX then
           medium.h = h_start;
        else
           medium.T = T_start;
        end if;
      elseif energyDynamics == Dynamics.SteadyStateInitial then
        /*
    if use_T_start then
      der(medium.T) = 0;
    else
      der(medium.h) = 0;
    end if;
    */
        if Medium.ThermoStates == IndependentVariables.ph or
           Medium.ThermoStates == IndependentVariables.phX then
           der(medium.h) = 0;
        else
           der(medium.T) = 0;
        end if;
      end if;

      if massDynamics == Dynamics.FixedInitial then
        if initialize_p then
          medium.p = p_start;
        end if;
      elseif massDynamics == Dynamics.SteadyStateInitial then
        if initialize_p then
          der(medium.p) = 0;
        end if;
      end if;

      if substanceDynamics == Dynamics.FixedInitial then
        medium.Xi = X_start[1:Medium.nXi];
      elseif substanceDynamics == Dynamics.SteadyStateInitial then
        der(medium.Xi) = zeros(Medium.nXi);
      end if;

      if traceDynamics == Dynamics.FixedInitial then
        mC_scaled = m*C_start[1:Medium.nC]./Medium.C_nominal;
      elseif traceDynamics == Dynamics.SteadyStateInitial then
        der(mC_scaled) = zeros(Medium.nC);
      end if;

      annotation (
        Documentation(info="<html>
<p>
Interface and base class for an ideally mixed fluid volume with the ability to store mass and energy.
The following boundary flow and source terms are part of the energy balance and must be specified in an extending class:
</p>
<ul>
<li><code><strong>Qb_flow</strong></code>, e.g., convective or latent heat flow rate across segment boundary, and</li>
<li><code><strong>Wb_flow</strong></code>, work term, e.g., p*der(fluidVolume) if the volume is not constant.</li>
</ul>
<p>
The component volume <code><strong>fluidVolume</strong></code> is an input that needs to be set in the extending class to complete the model.
</p>
<p>
Further source terms must be defined by an extending class for fluid flow across the segment boundary:
</p>
<ul>
<li><code><strong>Hb_flow</strong></code>, enthalpy flow,</li>
<li><code><strong>mb_flow</strong></code>, mass flow,</li>
<li><code><strong>mbXi_flow</strong></code>, substance mass flow, and</li>
<li><code><strong>mbC_flow</strong></code>, trace substance mass flow.</li>
</ul>
</html>"));
    end PartialLumpedVolume;

      partial model PartialLumpedFlow
    "Base class for a lumped momentum balance"

        outer Modelica.Fluid.System system "System properties";

        replaceable package Medium =
          Modelica.Media.Interfaces.PartialMedium "Medium in the component";

        parameter Boolean allowFlowReversal = system.allowFlowReversal
      "= true to allow flow reversal, false restricts to design direction (m_flow >= 0)"
          annotation(Dialog(tab="Assumptions"), Evaluate=true);

        // Inputs provided to the flow model
        input SI.Length pathLength "Length flow path";

        // Variables defined by the flow model
        Medium.MassFlowRate m_flow(
           min=if allowFlowReversal then -Modelica.Constants.inf else 0,
           start = m_flow_start,
           stateSelect = if momentumDynamics == Types.Dynamics.SteadyState then StateSelect.default else
                                     StateSelect.prefer)
      "mass flow rates between states";

        // Parameters
        parameter Modelica.Fluid.Types.Dynamics momentumDynamics=system.momentumDynamics
      "Formulation of momentum balance"
          annotation(Dialog(tab="Assumptions", group="Dynamics"), Evaluate=true);

        parameter Medium.MassFlowRate m_flow_start=system.m_flow_start
      "Start value of mass flow rates"
          annotation(Dialog(tab="Initialization"));

        // Total quantities
        SI.Momentum I "Momenta of flow segments";

        // Source terms and forces to be defined by an extending model (zero if not used)
        SI.Force Ib_flow "Flow of momentum across boundaries";
        SI.Force F_p "Pressure force";
        SI.Force F_fg "Friction and gravity force";

      equation
        // Total quantities
        I = m_flow*pathLength;

        // Momentum balances
        if momentumDynamics == Types.Dynamics.SteadyState then
          0 = Ib_flow - F_p - F_fg;
        else
          der(I) = Ib_flow - F_p - F_fg;
        end if;

      initial equation
        if momentumDynamics == Types.Dynamics.FixedInitial then
          m_flow = m_flow_start;
        elseif momentumDynamics == Types.Dynamics.SteadyStateInitial then
          der(m_flow) = 0;
        end if;

        annotation (
           Documentation(info="<html>
<p>
Interface and base class for a momentum balance, defining the mass flow rate <code><strong>m_flow</strong></code>
of a given <code>Medium</code> in a flow model.
</p>
<p>
The following boundary flow and force terms are part of the momentum balance and must be specified in an extending model (to zero if not considered):
</p>
<ul>
<li><code><strong>Ib_flow</strong></code>, the flow of momentum across model boundaries,</li>
<li><code><strong>F_p[m]</strong></code>, pressure force, and</li>
<li><code><strong>F_fg[m]</strong></code>, friction and gravity forces.</li>
</ul>
<p>
The length of the flow path <code><strong>pathLength</strong></code> is an input that needs to be set in an extending class to complete the model.
</p>
</html>"));
      end PartialLumpedFlow;

partial model PartialDistributedVolume
    "Base class for distributed volume models"
    import Modelica.Fluid.Types;
    import Modelica.Fluid.Types.Dynamics;
    import Modelica.Media.Interfaces.Choices.IndependentVariables;
  outer Modelica.Fluid.System system "System properties";

  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);

  // Discretization
  parameter Integer n=2 "Number of discrete volumes";

  // Inputs provided to the volume model
  input SI.Volume[n] fluidVolumes
      "Discretized volume, determine in inheriting class";

  // Assumptions
  parameter Types.Dynamics energyDynamics=system.energyDynamics
      "Formulation of energy balances"
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  parameter Types.Dynamics massDynamics=system.massDynamics
      "Formulation of mass balances"
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  final parameter Types.Dynamics substanceDynamics=massDynamics
      "Formulation of substance balances"
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  final parameter Types.Dynamics traceDynamics=massDynamics
      "Formulation of trace substance balances"
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));

  //Initialization
  parameter Medium.AbsolutePressure p_a_start=system.p_start
      "Start value of pressure at port a"
    annotation(Dialog(tab = "Initialization"));
  parameter Medium.AbsolutePressure p_b_start=p_a_start
      "Start value of pressure at port b"
    annotation(Dialog(tab = "Initialization"));
  final parameter Medium.AbsolutePressure[n] ps_start=if n > 1 then linspace(
        p_a_start, p_b_start, n) else {(p_a_start + p_b_start)/2}
      "Start value of pressure";

  parameter Boolean use_T_start=true "Use T_start if true, otherwise h_start"
     annotation(Evaluate=true, Dialog(tab = "Initialization"));

  parameter Medium.Temperature T_start=if use_T_start then system.T_start else
              Medium.temperature_phX(
        (p_a_start + p_b_start)/2,
        h_start,
        X_start) "Start value of temperature"
    annotation(Evaluate=true, Dialog(tab = "Initialization", enable = use_T_start));
  parameter Medium.SpecificEnthalpy h_start=if use_T_start then
        Medium.specificEnthalpy_pTX(
        (p_a_start + p_b_start)/2,
        T_start,
        X_start) else Medium.h_default "Start value of specific enthalpy"
    annotation(Evaluate=true, Dialog(tab = "Initialization", enable = not use_T_start));
  parameter Medium.MassFraction X_start[Medium.nX] = Medium.X_default
      "Start value of mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
  parameter Medium.ExtraProperty C_start[Medium.nC](
       quantity=Medium.extraPropertiesNames) = Medium.C_default
      "Start value of trace substances"
    annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));

  // Total quantities
  SI.Energy[n] Us "Internal energy of fluid";
  SI.Mass[n] ms "Fluid mass";
  SI.Mass[n,Medium.nXi] mXis "Substance mass";
  SI.Mass[n,Medium.nC] mCs "Trace substance mass";
  // C need to be added here because unlike for Xi, which has medium[:].Xi,
  // there is no variable medium[:].C
  SI.Mass[n,Medium.nC] mCs_scaled "Scaled trace substance mass";
  Medium.ExtraProperty Cs[n, Medium.nC] "Trace substance mixture content";

  Medium.BaseProperties[n] mediums(
    each preferredMediumStates=true,
    p(start=ps_start),
    each h(start=h_start),
    each T(start=T_start),
    each Xi(start=X_start[1:Medium.nXi]));

  //Source terms, have to be defined by an extending model (to zero if not used)
  Medium.MassFlowRate[n] mb_flows "Mass flow rate, source or sink";
  Medium.MassFlowRate[n,Medium.nXi] mbXi_flows
      "Independent mass flow rates, source or sink";
  Medium.ExtraPropertyFlowRate[n,Medium.nC] mbC_flows
      "Trace substance mass flow rates, source or sink";
  SI.EnthalpyFlowRate[n] Hb_flows "Enthalpy flow rate, source or sink";
  SI.HeatFlowRate[n] Qb_flows "Heat flow rate, source or sink";
  SI.Power[n] Wb_flows "Mechanical power, p*der(V) etc.";

  protected
  parameter Boolean initialize_p = not Medium.singleState
      "= true to set up initial equations for pressure";

equation
  assert(not (energyDynamics<>Dynamics.SteadyState and massDynamics==Dynamics.SteadyState) or Medium.singleState,
         "Bad combination of dynamics options and Medium not conserving mass if fluidVolumes are fixed.");

  // Total quantities
  for i in 1:n loop
    ms[i] =fluidVolumes[i]*mediums[i].d;
    mXis[i, :] = ms[i]*mediums[i].Xi;
    mCs[i, :]  = ms[i]*Cs[i, :];
    Us[i] = ms[i]*mediums[i].u;
  end for;

  // Energy and mass balances
  if energyDynamics == Dynamics.SteadyState then
    for i in 1:n loop
      0 = Hb_flows[i] + Wb_flows[i] + Qb_flows[i];
    end for;
  else
    for i in 1:n loop
      der(Us[i]) = Hb_flows[i] + Wb_flows[i] + Qb_flows[i];
    end for;
  end if;
  if massDynamics == Dynamics.SteadyState then
    for i in 1:n loop
      0 = mb_flows[i];
    end for;
  else
    for i in 1:n loop
      der(ms[i]) = mb_flows[i];
    end for;
  end if;
  if substanceDynamics == Dynamics.SteadyState then
    for i in 1:n loop
      zeros(Medium.nXi) = mbXi_flows[i, :];
    end for;
  else
    for i in 1:n loop
      der(mXis[i, :]) = mbXi_flows[i, :];
    end for;
  end if;
  if traceDynamics == Dynamics.SteadyState then
    for i in 1:n loop
      zeros(Medium.nC)  = mbC_flows[i, :];
    end for;
  else
    for i in 1:n loop
      der(mCs_scaled[i, :])  = mbC_flows[i, :]./Medium.C_nominal;
      mCs[i, :] = mCs_scaled[i, :].*Medium.C_nominal;
    end for;
  end if;

initial equation
  // initialization of balances
  if energyDynamics == Dynamics.FixedInitial then
    /*
    if use_T_start then
      mediums.T = fill(T_start, n);
    else
      mediums.h = fill(h_start, n);
    end if;
    */
    if Medium.ThermoStates == IndependentVariables.ph or
       Medium.ThermoStates == IndependentVariables.phX then
       mediums.h = fill(h_start, n);
    else
       mediums.T = fill(T_start, n);
    end if;

  elseif energyDynamics == Dynamics.SteadyStateInitial then
    /*
    if use_T_start then
      der(mediums.T) = zeros(n);
    else
      der(mediums.h) = zeros(n);
    end if;
    */
    if Medium.ThermoStates == IndependentVariables.ph or
       Medium.ThermoStates == IndependentVariables.phX then
       der(mediums.h) = zeros(n);
    else
       der(mediums.T) = zeros(n);
    end if;
  end if;

  if massDynamics == Dynamics.FixedInitial then
    if initialize_p then
      mediums.p = ps_start;
    end if;
  elseif massDynamics == Dynamics.SteadyStateInitial then
    if initialize_p then
      der(mediums.p) = zeros(n);
    end if;
  end if;

  if substanceDynamics == Dynamics.FixedInitial then
    mediums.Xi = fill(X_start[1:Medium.nXi], n);
  elseif substanceDynamics == Dynamics.SteadyStateInitial then
    for i in 1:n loop
      der(mediums[i].Xi) = zeros(Medium.nXi);
    end for;
  end if;

  if traceDynamics == Dynamics.FixedInitial then
    Cs = fill(C_start[1:Medium.nC], n);
  elseif traceDynamics == Dynamics.SteadyStateInitial then
    for i in 1:n loop
      der(mCs[i,:])      = zeros(Medium.nC);
    end for;
  end if;

   annotation (Documentation(info="<html>
<p>
Interface and base class for <code><strong>n</strong></code> ideally mixed fluid volumes with the ability to store mass and energy.
It is intended to model a one-dimensional spatial discretization of fluid flow according to the finite volume method.
The following boundary flow and source terms are part of the energy balance and must be specified in an extending class:
</p>
<ul>
<li><code><strong>Qb_flows[n]</strong></code>, heat flow term, e.g., conductive heat flows across segment boundaries, and</li>
<li><code><strong>Wb_flows[n]</strong></code>, work term.</li>
</ul>
<p>
The component volumes <code><strong>fluidVolumes[n]</strong></code> are an input that needs to be set in an extending class to complete the model.
</p>
<p>
Further source terms must be defined by an extending class for fluid flow across the segment boundary:
</p>
<ul>
<li><code><strong>Hb_flows[n]</strong></code>, enthalpy flow,</li>
<li><code><strong>mb_flows[n]</strong></code>, mass flow,</li>
<li><code><strong>mbXi_flows[n]</strong></code>, substance mass flow, and</li>
<li><code><strong>mbC_flows[n]</strong></code>, trace substance mass flow.</li>
</ul>
</html>"));
end PartialDistributedVolume;

      partial model PartialDistributedFlow
    "Base class for a distributed momentum balance"

        outer Modelica.Fluid.System system "System properties";

        replaceable package Medium =
          Modelica.Media.Interfaces.PartialMedium "Medium in the component";

        parameter Boolean allowFlowReversal = system.allowFlowReversal
      "= true to allow flow reversal, false restricts to design direction (m_flows >= zeros(m))"
          annotation(Dialog(tab="Assumptions"), Evaluate=true);

        // Discretization
        parameter Integer m=1 "Number of flow segments";

        // Inputs provided to the flow model
        input SI.Length[m] pathLengths "Lengths along flow path";

        // Variables defined by momentum model
        Medium.MassFlowRate[m] m_flows(
           each min=if allowFlowReversal then -Modelica.Constants.inf else 0,
           each start = m_flow_start,
           each stateSelect = if momentumDynamics == Types.Dynamics.SteadyState then StateSelect.default else
                                     StateSelect.prefer)
      "mass flow rates between states";

        // Parameters
        parameter Modelica.Fluid.Types.Dynamics momentumDynamics=system.momentumDynamics
      "Formulation of momentum balance"
          annotation(Dialog(tab="Assumptions", group="Dynamics"), Evaluate=true);

        parameter Medium.MassFlowRate m_flow_start=system.m_flow_start
      "Start value of mass flow rates"
          annotation(Dialog(tab="Initialization"));

        // Total quantities
        SI.Momentum[m] Is "Momenta of flow segments";

        // Source terms and forces to be defined by an extending model (zero if not used)
        SI.Force[m] Ib_flows "Flow of momentum across boundaries";
        SI.Force[m] Fs_p "Pressure forces";
        SI.Force[m] Fs_fg "Friction and gravity forces";

      equation
        // Total quantities
        Is = {m_flows[i]*pathLengths[i] for i in 1:m};

        // Momentum balances
        if momentumDynamics == Types.Dynamics.SteadyState then
          zeros(m) = Ib_flows - Fs_p - Fs_fg;
        else
          der(Is) = Ib_flows - Fs_p - Fs_fg;
        end if;

      initial equation
        if momentumDynamics == Types.Dynamics.FixedInitial then
          m_flows = fill(m_flow_start, m);
        elseif momentumDynamics == Types.Dynamics.SteadyStateInitial then
          der(m_flows) = zeros(m);
        end if;

        annotation (
           Documentation(info="<html>
<p>
Interface and base class for <code><strong>m</strong></code> momentum balances, defining the mass flow rates <code><strong>m_flows[m]</strong></code>
of a given <code>Medium</code> in <code><strong>m</strong></code> flow segments.
</p>
<p>
The following boundary flow and force terms are part of the momentum balances and must be specified in an extending model (to zero if not considered):
</p>
<ul>
<li><code><strong>Ib_flows[m]</strong></code>, the flows of momentum across segment boundaries,</li>
<li><code><strong>Fs_p[m]</strong></code>, pressure forces, and</li>
<li><code><strong>Fs_fg[m]</strong></code>, friction and gravity forces.</li>
</ul>
<p>
The lengths along the flow path <code><strong>pathLengths[m]</strong></code> are an input that needs to be set in an extending class to complete the model.
</p>
</html>"));
      end PartialDistributedFlow;

  partial model PartialPressureLoss
    "Base flow model for pressure loss functions with the same area at port_a and at port_b"
    extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;
  protected
    parameter Medium.ThermodynamicState state_dp_small=Medium.setState_pTX(
                         Medium.reference_p,
                         Medium.reference_T,
                         Medium.reference_X) "Medium state to compute dp_small";
    Medium.Density d_a
      "Density at port_a when fluid is flowing from port_a to port_b";
    Medium.Density d_b
      "If allowFlowReversal=true then Density at port_b when fluid is flowing from port_b to port_a else d_a";
    Medium.DynamicViscosity eta_a
      "Dynamic viscosity at port_a when fluid is flowing from port_a to port_b";
    Medium.DynamicViscosity eta_b
      "If allowFlowReversal=true then Dynamic viscosity at port_b when fluid is flowing from port_b to port_a else eta_a";
  equation
    // Isenthalpic state transformation (no storage and no loss of energy)
    port_a.h_outflow = inStream(port_b.h_outflow);
    port_b.h_outflow = inStream(port_a.h_outflow);

    // Medium properties
    d_a   = Medium.density(state_a);
    eta_a = Medium.dynamicViscosity(state_a);
    if allowFlowReversal then
      d_b   = Medium.density(state_b);
      eta_b = Medium.dynamicViscosity(state_b);
    else
      d_b   = d_a;
      eta_b = eta_a;
    end if;

  end PartialPressureLoss;

  annotation (Documentation(info="<html>

</html>", revisions="<html>
<ul>
<li><em>June 9th, 2008</em>
       by Michael Sielemann: Introduced stream keyword after decision at 57th Design Meeting (Lund).</li>
<li><em>May 30, 2007</em>
       by Christoph Richter: moved everything back to its original position in Modelica.Fluid.</li>
<li><em>Apr. 20, 2007</em>
       by Christoph Richter: moved parts of the original package from Modelica.Fluid
       to the development branch of Modelica 2.2.2.</li>
<li><em>Nov. 2, 2005</em>
       by Francesco Casella: restructured after 45th Design Meeting.</li>
<li><em>Nov. 20-21, 2002</em>
       by Hilding Elmqvist, Mike Tiller, Allan Watson, John Batteh, Chuck Newman,
       Jonas Eborn: Improved at the 32nd Modelica Design Meeting.
<li><em>Nov. 11, 2002</em>
       by Hilding Elmqvist, Martin Otter: improved version.</li>
<li><em>Nov. 6, 2002</em>
       by Hilding Elmqvist: first version.</li>
<li><em>Aug. 11, 2002</em>
       by Martin Otter: Improved according to discussion with Hilding
       Elmqvist and Hubertus Tummescheit.<br>
       The PortVicinity model is manually
       expanded in the base models.<br>
       The Volume used for components is renamed
       PartialComponentVolume.<br>
       A new volume model \"Fluid.Components.PortVolume\"
       introduced that has the medium properties of the port to which it is
       connected.<br>
       Fluid.Interfaces.PartialTwoPortTransport is a component
       for elementary two port transport elements, whereas PartialTwoPort
       is a component for a container component.</li>
</ul>
</html>"));

end Interfaces;
