within ModelicaTest.Fluid;
package BaseClasses "Specific models used for testing"
  extends Modelica.Icons.BasesPackage;

  model GenericStaticHead "Models two ports at different heights"

    extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;

    // Static head
    parameter SI.Length height_ab "Height(port_b) - Height(port_a)"
        annotation(Dialog(group="Static head"));

    // Pressure loss
    replaceable model PressureLoss =
      Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow
      constrainedby Modelica.Fluid.Interfaces.PartialDistributedFlow
      "Pressure loss model"
        annotation(Dialog(group="Pressure loss"), choicesAllMatching=true);

    PressureLoss pressureLoss(
        redeclare final package Medium = Medium,
        final n=2,
        states = {state_a, state_b},
        vs={port_a.m_flow/Medium.density(pressureLoss.states[1])/pressureLoss.crossAreas[1],
            -port_b.m_flow/Medium.density(pressureLoss.states[2])/pressureLoss.crossAreas[2]},
        final momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        final allowFlowReversal=allowFlowReversal,
        dheights = {height_ab},
        dp_nominal = 1,
        m_flow_nominal = 1,
        m_flow_start = m_flow_start,
        p_a_start = system.p_start + 0.5*dp_start,
        p_b_start = system.p_start - 0.5*dp_start,
        nParallel = 1,
        pathLengths = {0},
        crossAreas=fill(Modelica.Constants.pi/4*2.54e-2^2, 2),
        dimensions=fill(2.54e-2, 2),
        roughnesses=fill(2.5e-5, 2));

  equation
    m_flow = pressureLoss.m_flows[1];

    // Energy balance, considering change of potential energy
    port_a.h_outflow = inStream(port_b.h_outflow) + system.g*height_ab;
    port_b.h_outflow = inStream(port_a.h_outflow) - system.g*height_ab;

    annotation (defaultComponentName="staticHead",
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={Rectangle(
            extent={{-100,60},{100,-60}},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255})}),        Documentation(info="<html>
<p>
This component is intended for early designs and later replacement by more detailed models.
It describes the static head due to the height difference between its two ports.
</p>
<p>
Per default a small regularization with a linear pressure loss of 1Pa per 1kg/s is configured.
The regularization can be changed for the PressureLoss model.
</p>
</html>", revisions="<html>
<ul>
<li><em>8 Dec 2008</em>
    by R&uuml;diger Franke:<br>
       Introduce small nominal pressure loss for regularization</li>
<li><em>31 Oct 2007</em>
    by <a href=\"mailto:jonas@modelon.se\">Jonas Eborn</a>:<br>
       Changed to flow-direction dependent density</li>
<li><em>2 Nov 2005</em>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Added to Modelica.Fluid</li>
</ul>
</html>"));
  end GenericStaticHead;

  model LumpedPipe "Example for a composite pipe model"

    // extending PartialStraightPipe
    extends Modelica.Fluid.Pipes.BaseClasses.PartialStraightPipe;

    // Assumptions
    parameter Modelica.Fluid.Types.Dynamics energyDynamics=system.energyDynamics
      "Formulation of energy balance"
      annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
    parameter Modelica.Fluid.Types.Dynamics massDynamics=system.massDynamics
      "Formulation of mass balance"
      annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));

    // Initialization
    parameter Medium.AbsolutePressure p_a_start=system.p_start
      "Start value of pressure at port a"
      annotation(Dialog(tab = "Initialization"));
    parameter Medium.AbsolutePressure p_b_start=p_a_start
      "Start value of pressure at port b"
      annotation(Dialog(tab = "Initialization"));

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
    parameter Medium.MassFraction X_start[Medium.nX]=Medium.X_default
      "Start value of mass fractions m_i/m"
      annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
    parameter Medium.ExtraProperty C_start[Medium.nC](
         quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
      "Start value of trace substances"
      annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));

    parameter Medium.MassFlowRate m_flow_start = system.m_flow_start
      "Start value for mass flow rate"
       annotation(Evaluate=true, Dialog(tab = "Initialization"));

    // Wall heat transfer
    parameter Boolean use_HeatTransfer = false
      "= true to use the HeatTransfer model"
        annotation (Dialog(tab="Assumptions", group="Heat transfer"));
    replaceable model HeatTransfer =
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer
      constrainedby
      Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.PartialVesselHeatTransfer
      "Wall heat transfer"
        annotation (Dialog(tab="Assumptions", group="Heat transfer",enable=use_HeatTransfer),choicesAllMatching=true);
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if use_HeatTransfer
      annotation (Placement(transformation(extent={{-10,44},{10,64}}), iconTransformation(extent={{-10,35},{10,55}})));

    Modelica.Fluid.Pipes.StaticPipe staticPipe1(
      redeclare package Medium = Medium,
      allowFlowReversal=allowFlowReversal,
      nParallel=nParallel,
      length=length/2,
      roughness=roughness,
      diameter=diameter,
      perimeter=perimeter,
      crossArea=crossArea,
      height_ab=height_ab/2,
      m_flow_start=m_flow_start,
      redeclare final model FlowModel = FlowModel)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Modelica.Fluid.Vessels.ClosedVolume volume(
      redeclare package Medium = Medium,
      redeclare model HeatTransfer = HeatTransfer,
      heatTransfer(surfaceAreas={perimeter*length}),
      energyDynamics=energyDynamics,
      massDynamics=massDynamics,
      p_start=(p_a_start+p_b_start)/2,
      use_T_start=use_T_start,
      T_start=T_start,
      h_start=h_start,
      X_start=X_start,
      C_start=C_start,
      V=V,
      nPorts=2,
      use_portsData=false,
      use_HeatTransfer=use_HeatTransfer)
      annotation (Placement(transformation(extent={{-10,10},{10,30}})));
    Modelica.Fluid.Pipes.StaticPipe staticPipe2(
      redeclare package Medium = Medium,
      allowFlowReversal=allowFlowReversal,
      nParallel=nParallel,
      length=length/2,
      roughness=roughness,
      diameter=diameter,
      perimeter=perimeter,
      crossArea=crossArea,
      height_ab=height_ab/2,
      m_flow_start=m_flow_start,
      redeclare final model FlowModel = FlowModel)   annotation (Placement(transformation(extent={{40,-10},
              {60,10}})));

  equation
    connect(staticPipe1.port_a, port_a)
      annotation (Line(points={{-60,0},{-80,0},{-100,0}}, color={0,127,255}));
    connect(staticPipe2.port_b, port_b)
      annotation (Line(points={{60,0},{80,0},{100,0}}, color={0,127,255}));
    connect(staticPipe1.port_b, volume.ports[1])   annotation (Line(
        points={{-40,0},{-2,0},{-2,10}}, color={0,127,255}));
    connect(staticPipe2.port_a, volume.ports[2])   annotation (Line(
        points={{40,0},{2,0},{2,10}}, color={0,127,255}));
    connect(heatPort, volume.heatPort) annotation (Line(
        points={{0,54},{0,40},{-20,40},{-20,20},{-10,20}}, color={191,0,0}));
    annotation (defaultComponentName="pipe",Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
          graphics={Ellipse(
            extent={{-10,10},{10,-10}},
            fillPattern=FillPattern.Solid)}),Documentation(info="<html>
<p>
Simple pipe model consisting of one volume,
wall friction (with different friction correlations)
and gravity effect. This model is mostly used to demonstrate how
to build up more detailed models from the basic components.
Note, if the \"heatPort\" is not connected, then the pipe
is totally insulated (= no thermal flow from the fluid to the
pipe wall/environment).
</p>
</html>"));
  end LumpedPipe;

  model WallFriction
    "Pressure drop in pipe due to wall friction (only for test purposes; if needed use Pipes.StaticPipe instead)"
    extends Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.BaseModel(final data=
      Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.wallFriction(
      length,
      diameter,
      roughness));
    parameter SI.Length length "Length of pipe";
    parameter SI.Diameter diameter "Inner diameter of pipe";
    parameter Modelica.Fluid.Types.Roughness roughness(min=1e-10)
        "Absolute roughness of pipe (> 0 required, details see info layer)";
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,80},{150,120}},
              textString="%name"),
            Rectangle(
              extent={{-100,60},{100,-60}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{-100,34},{100,-36}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,127,255}),
            Text(
              extent={{-134,-66},{130,-92}},
              textString="quad.turbulent")}),
        Documentation(info="<html>
</html>"));
  end WallFriction;

  model WallFrictionAndGravity
    "Pressure loss in pipe due to wall friction and gravity (only for test purposes; if needed use Pipes.StaticPipe instead)"
    extends Modelica.Fluid.Interfaces.PartialTwoPortTransport(
      dp_start = dp_fric_nominal + system.g*height_ab*rho_nominal,
      m_flow_small = if system.use_eps_Re then system.eps_m_flow*m_flow_nominal else system.m_flow_small);

    replaceable package WallFriction = Modelica.Fluid.Pipes.BaseClasses.WallFriction.QuadraticTurbulent
      constrainedby Modelica.Fluid.Pipes.BaseClasses.WallFriction.PartialWallFriction
      "Characteristic of wall friction" annotation(choicesAllMatching=true);

    parameter SI.Length length "Length of pipe";
    parameter SI.Diameter diameter "Inner (hydraulic) diameter of pipe";
    parameter SI.Area crossArea=Modelica.Constants.pi*diameter*diameter/4
      "Inner cross section area";
    parameter SI.Length height_ab = 0.0 "Height(port_b) - Height(port_a)" annotation(Evaluate=true);
    parameter Modelica.Fluid.Types.Roughness roughness = 2.5e-5
      "Absolute roughness of pipe (default = smooth steel pipe)"
      annotation(Dialog(enable=WallFriction.use_roughness));

    parameter SI.MassFlowRate m_flow_nominal=if system.use_eps_Re then system.m_flow_nominal else 1e2*system.m_flow_small
      "Nominal mass flow rate"
      annotation(Dialog(group="Nominal operating point"));

    parameter Boolean use_nominal = false
      "= true, if mu_nominal and rho_nominal are used, otherwise computed from medium" annotation(Evaluate=true);
    parameter SI.DynamicViscosity mu_nominal = Medium.dynamicViscosity(
      Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))
      "Nominal dynamic viscosity (e.g., mu_liquidWater = 1e-3, mu_air = 1.8e-5)" annotation(Dialog(enable=use_nominal));
    parameter SI.Density rho_nominal = Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default)
      "Nominal density (e.g., rho_liquidWater = 995, rho_air = 1.2)" annotation(Dialog(enable=use_nominal));

    parameter Boolean show_Re = false
      "= true, if Reynolds number is included for plotting"
       annotation (Evaluate=true, Dialog(tab="Advanced"));
    parameter Boolean from_dp=true
      "= true, use m_flow = f(dp), otherwise dp = f(m_flow)"
      annotation (Evaluate=true, Dialog(tab="Advanced"));
  protected
    parameter Medium.AbsolutePressure dp_fric_nominal(min=0)=
      WallFriction.pressureLoss_m_flow(
        m_flow_nominal,
        rho_nominal,
        rho_nominal,
        mu_nominal,
        mu_nominal,
        length,
        diameter,
        crossArea,
        roughness,
        m_flow_small)
      "Nominal pressure loss (excluding static head)";
    parameter Medium.AbsolutePressure dp_small(min=0) = if system.use_eps_Re then dp_fric_nominal/m_flow_nominal*m_flow_small else system.dp_small
      "Within regularization if |dp| < dp_small (may be wider for large discontinuities in static head)"
      annotation(Dialog(tab="Advanced", enable=from_dp and WallFriction.use_dp_small));

  public
    SI.ReynoldsNumber Re = Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber_m_flow(
      m_flow, noEvent(if m_flow>0 then mu_a else mu_b), diameter) if show_Re "Reynolds number of pipe flow";

  protected
    SI.DynamicViscosity mu_a = if not WallFriction.use_mu then 1e-10 else
                                (if use_nominal then mu_nominal else Medium.dynamicViscosity(state_a));
    SI.DynamicViscosity mu_b = if not WallFriction.use_mu then 1e-10 else
                                (if use_nominal then mu_nominal else Medium.dynamicViscosity(state_b));
    SI.Density rho_a = if use_nominal then rho_nominal else Medium.density(state_a);
    SI.Density rho_b = if use_nominal then rho_nominal else Medium.density(state_b);

    Real g_times_height_ab(final unit="m2/s2") = system.g*height_ab
      "Gravity times height_ab = dp_grav/d";

    // Currently not in use (means to widen the regularization domain in case of large difference in static head)
    final parameter Boolean use_x_small_staticHead = false
      "Use dp_/m_flow_small_staticHead only if static head actually exists" annotation(Evaluate=true);
                                                           /*abs(height_ab)>0*/
    SI.AbsolutePressure dp_small_staticHead = noEvent(max(dp_small, 0.015*abs(g_times_height_ab*(rho_a-rho_b))))
      "Heuristic for large discontinuities in static head";
    SI.MassFlowRate m_flow_small_staticHead = noEvent(max(m_flow_small, (-5.55e-7*(rho_a+rho_b)/2+5.5e-4)*abs(g_times_height_ab*(rho_a-rho_b))))
      "Heuristic for large discontinuities in static head";

  equation
    if from_dp and not WallFriction.dp_is_zero then
      m_flow = WallFriction.massFlowRate_dp_staticHead(dp, rho_a, rho_b, mu_a, mu_b, length, diameter,
        g_times_height_ab, crossArea, roughness, if use_x_small_staticHead then dp_small_staticHead else dp_small);
    else
      dp = WallFriction.pressureLoss_m_flow_staticHead(m_flow, rho_a, rho_b, mu_a, mu_b, length, diameter,
        g_times_height_ab, crossArea, roughness, if use_x_small_staticHead then m_flow_small_staticHead else m_flow_small);
    end if;

    // Energy balance, considering change of potential energy
    port_a.h_outflow = inStream(port_b.h_outflow) + system.g*height_ab;
    port_b.h_outflow = inStream(port_a.h_outflow) - system.g*height_ab;

    annotation (defaultComponentName="pipeFriction",Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,60},{100,-60}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,44},{100,-45}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Text(
          extent={{-150,80},{150,120}},
          textColor={0,0,255},
          textString="%name")}), Documentation(info="<html>
<p>
This model describes pressure losses due to <strong>wall friction</strong> in a pipe
and due to gravity.
It is assumed that no mass or energy is stored in the pipe.
Correlations of different complexity and validity can be
selected via the replaceable package <strong>WallFriction</strong> (see parameter menu below).
The details of the pipe wall friction model are described in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a>.
Basically, different variants of the equation
</p>

<blockquote><pre>
dp = &lambda;(Re,&Delta;)*(L/D)*&rho;*v*|v|/2
</pre></blockquote>

<p>
are used, where the friction loss factor &lambda; is shown
in the next figure:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Pipes/BaseClasses/PipeFriction1.png\"
     alt=\"PipeFriction1.png\">
</div>

<p>
By default, the correlations are computed with media data
at the actual time instant.
In order to reduce non-linear equation systems, parameter
<strong>use_nominal</strong> provides the option
to compute the correlations with constant media values
at the desired operating point. This might speed-up the
simulation and/or might give a more robust simulation.
</p>
</html>"),Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,64},{100,-64}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
          Rectangle(
            extent={{-100,50},{100,-49}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-60,-49},{-60,50}},
            color={0,0,255},
            arrow={Arrow.Filled,Arrow.Filled}),
          Text(
            extent={{-50,16},{6,-10}},
            textColor={0,0,255},
            textString="diameter"),
          Line(
            points={{-100,74},{100,74}},
            color={0,0,255},
            arrow={Arrow.Filled,Arrow.Filled}),
          Text(
            extent={{-34,92},{34,74}},
            textColor={0,0,255},
            textString="length")}));
  end WallFrictionAndGravity;
end BaseClasses;
