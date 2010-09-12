within Modelica.Fluid;
package Pipes "Devices for conveying fluid"
    extends Modelica.Icons.VariantsPackage;

  model StaticPipe "Basic pipe flow model without storage of mass or energy"

    // extending PartialStraightPipe
    extends Modelica.Fluid.Pipes.BaseClasses.PartialStraightPipe;

    // Initialization
    parameter Medium.AbsolutePressure p_a_start=system.p_start
      "Start value of pressure at port a"
      annotation(Dialog(tab = "Initialization"));
    parameter Medium.AbsolutePressure p_b_start=p_a_start
      "Start value of pressure at port b"
      annotation(Dialog(tab = "Initialization"));
    parameter Medium.MassFlowRate m_flow_start = system.m_flow_start
      "Start value for mass flow rate"
       annotation(Evaluate=true, Dialog(tab = "Initialization"));

    FlowModel flowModel(
            redeclare final package Medium = Medium,
            final n=2,
            states={Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow)),
                   Medium.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow))},
            vs={port_a.m_flow/Medium.density(flowModel.states[1])/flowModel.crossAreas[1],
                -port_b.m_flow/Medium.density(flowModel.states[2])/flowModel.crossAreas[2]}/nParallel,
            final momentumDynamics=Types.Dynamics.SteadyState,
            final allowFlowReversal=allowFlowReversal,
            final p_a_start=p_a_start,
            final p_b_start=p_b_start,
            final m_flow_start=m_flow_start,
            final nParallel=nParallel,
            final pathLengths={length},
            final crossAreas={crossArea, crossArea},
            final dimensions={4*crossArea/perimeter, 4*crossArea/perimeter},
            final roughnesses={roughness, roughness},
            final dheights={height_ab},
            final g=system.g) "Flow model"
       annotation (Placement(transformation(extent={{-38,-18},{38,18}},rotation=0)));
  equation
    // Mass balance
    port_a.m_flow = flowModel.m_flows[1];
    0 = port_a.m_flow + port_b.m_flow;
    port_a.Xi_outflow = inStream(port_b.Xi_outflow);
    port_b.Xi_outflow = inStream(port_a.Xi_outflow);
    port_a.C_outflow = inStream(port_b.C_outflow);
    port_b.C_outflow = inStream(port_a.C_outflow);

    // Energy balance, considering change of potential energy
    // Wb_flow = v*A*dpdx + v*F_fric
    //         = m_flow/d/A * (A*dpdx + A*pressureLoss.dp_fg - F_grav)
    //         = m_flow/d/A * (-A*g*height_ab*d)
    //         = -m_flow*g*height_ab
    port_b.h_outflow = inStream(port_a.h_outflow) - system.g*height_ab;
    port_a.h_outflow = inStream(port_b.h_outflow) + system.g*height_ab;

    annotation (defaultComponentName="pipe",
  Documentation(info="<html>
<p>Model of a straight pipe with constant cross section and with steady-state mass, momentum and energy balances, i.e., the model does not store mass or energy.
There exist two thermodynamic states, one at each fluid port. The momentum balance is formulated for the two states, taking into account
momentum flows, friction and gravity. The same result can be obtained by using <a href=\"modelica://Modelica.Fluid.Pipes.DynamicPipe\">DynamicPipe</a> with
steady-state dynamic settings. The intended use is to provide simple connections of vessels or other devices with storage, as it is done in:
<ul>
<li><a href=\"modelica://Modelica.Fluid.Examples.Tanks.EmptyTanks\">Examples.Tanks.EmptyTanks</a></li>
<li><a href=\"modelica://Modelica.Fluid.Examples.InverseParameterization\">Examples.InverseParameterization</a></li>.
</ul>

<h4>Numerical Issues</h4>
With the stream connectors the thermodynamic states on the ports are generally defined by models with storage or by sources placed upstream and downstream of the static pipe.
Other non storage components in the flow path may yield to state transformation. Note that this generally leads to nonlinear equation systems if multiple static pipes,
or other flow models without storage, are directly connected.
<br><br><br><br>

</p>
</html>"),
  Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}),                 graphics));
  end StaticPipe;

  model DynamicPipe "Dynamic pipe model with storage of mass and energy"

    import Modelica.Fluid.Types.ModelStructure;

    // extending PartialStraightPipe
    extends Modelica.Fluid.Pipes.BaseClasses.PartialStraightPipe(
      final port_a_exposesState = (modelStructure == ModelStructure.av_b) or (modelStructure == ModelStructure.av_vb),
      final port_b_exposesState = (modelStructure == ModelStructure.a_vb) or (modelStructure == ModelStructure.av_vb));

    // extending PartialTwoPortFlow
    extends BaseClasses.PartialTwoPortFlow(
      final lengths=if n == 1 then
                        {length} else
                    if modelStructure == ModelStructure.av_vb then
                        cat(1, {length/(n-1)/2}, fill(length/(n-1), n-2), {length/(n-1)/2}) else
                    if modelStructure == ModelStructure.av_b then
                        cat(1, {length/n/2}, fill(length*(1-1/n/2)/(n-1), n-1)) else
                    if modelStructure == ModelStructure.a_vb then
                        cat(1, fill(length*(1-1/n/2)/(n-1), n-1), {length/n/2}) else
                        fill(length/n, n),
      final crossAreas=fill(crossArea, n),
      final dimensions=fill(4*crossArea/perimeter, n),
      final roughnesses=fill(roughness, n),
      final dheights=height_ab*dxs);

    // Wall heat transfer
    parameter Boolean use_HeatTransfer = false
      "= true to use the HeatTransfer model"
        annotation (Dialog(tab="Assumptions", group="Heat transfer"));
    replaceable model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer
      constrainedby
      Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer
      "Wall heat transfer"
        annotation (Dialog(tab="Assumptions", group="Heat transfer",enable=use_HeatTransfer),choicesAllMatching=true);
    Interfaces.HeatPorts_a[nNodes] heatPorts if use_HeatTransfer
      annotation (Placement(transformation(extent={{-10,45},{10,65}}), iconTransformation(extent={{-30,36},
              {32,52}})));

    HeatTransfer heatTransfer(
      redeclare each final package Medium = Medium,
      final n=n,
      final nParallel=nParallel,
      final surfaceAreas=perimeter*lengths,
      final lengths=lengths,
      final dimensions=dimensions,
      final roughnesses=roughnesses,
      final states=mediums.state,
      final vs = vs,
      final use_k = use_HeatTransfer) "Heat transfer model"
        annotation (Placement(transformation(extent={{-36,19},{-14,41}}, rotation=0)));
    final parameter Real[n] dxs = lengths/sum(lengths);
  equation
    Qb_flows = heatTransfer.Q_flows;
    // Wb_flow = v*A*dpdx + v*F_fric
    //         = v*A*dpdx + v*A*flowModel.dp_fg - v*A*dp_grav
    if n == 1 or useLumpedPressure then
      Wb_flows = dxs * ((vs*dxs)*(crossAreas*dxs)*((port_b.p - port_a.p) + sum(flowModel.dps_fg) - system.g*(dheights*mediums.d)))*nParallel;
    else
      if modelStructure == ModelStructure.av_vb or modelStructure == ModelStructure.av_b then
        Wb_flows[2:n-1] = {vs[i]*crossAreas[i]*((mediums[i+1].p - mediums[i-1].p)/2 + (flowModel.dps_fg[i-1]+flowModel.dps_fg[i])/2 - system.g*dheights[i]*mediums[i].d) for i in 2:n-1}*nParallel;
      else
        Wb_flows[2:n-1] = {vs[i]*crossAreas[i]*((mediums[i+1].p - mediums[i-1].p)/2 + (flowModel.dps_fg[i]+flowModel.dps_fg[i+1])/2 - system.g*dheights[i]*mediums[i].d) for i in 2:n-1}*nParallel;
      end if;
      if modelStructure == ModelStructure.av_vb then
        Wb_flows[1] = vs[1]*crossAreas[1]*((mediums[2].p - mediums[1].p)/2 + flowModel.dps_fg[1]/2 - system.g*dheights[1]*mediums[1].d)*nParallel;
        Wb_flows[n] = vs[n]*crossAreas[n]*((mediums[n].p - mediums[n-1].p)/2 + flowModel.dps_fg[n-1]/2 - system.g*dheights[n]*mediums[n].d)*nParallel;
      elseif modelStructure == ModelStructure.av_b then
        Wb_flows[1] = vs[1]*crossAreas[1]*((mediums[2].p - mediums[1].p)/2 + flowModel.dps_fg[1]/2 - system.g*dheights[1]*mediums[1].d)*nParallel;
        Wb_flows[n] = vs[n]*crossAreas[n]*((port_b.p - mediums[n-1].p)/1.5 + flowModel.dps_fg[n-1]/2+flowModel.dps_fg[n] - system.g*dheights[n]*mediums[n].d)*nParallel;
      elseif modelStructure == ModelStructure.a_vb then
        Wb_flows[1] = vs[1]*crossAreas[1]*((mediums[2].p - port_a.p)/1.5 + flowModel.dps_fg[1]+flowModel.dps_fg[2]/2 - system.g*dheights[1]*mediums[1].d)*nParallel;
        Wb_flows[n] = vs[n]*crossAreas[n]*((mediums[n].p - mediums[n-1].p)/2 + flowModel.dps_fg[n]/2 - system.g*dheights[n]*mediums[n].d)*nParallel;
      elseif modelStructure == ModelStructure.a_v_b then
        Wb_flows[1] = vs[1]*crossAreas[1]*((mediums[2].p - port_a.p)/1.5 + flowModel.dps_fg[1]+flowModel.dps_fg[2]/2 - system.g*dheights[1]*mediums[1].d)*nParallel;
        Wb_flows[n] = vs[n]*crossAreas[n]*((port_b.p - mediums[n-1].p)/1.5 + flowModel.dps_fg[n]/2+flowModel.dps_fg[n+1] - system.g*dheights[n]*mediums[n].d)*nParallel;
      else
        assert(true, "Unknown model structure");
      end if;
    end if;

    connect(heatPorts, heatTransfer.heatPorts)
      annotation (Line(points={{0,55},{0,54},{-24,54},{-24,37.7},{-25,37.7}},
                                               color={191,0,0}));
    annotation (defaultComponentName="pipe",
  Documentation(info="<html>
<p>Model of a straight pipe with distributed mass, energy and momentum balances.
It provides the complete balance equations for one-dimensional fluid flow as formulated in
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.BalanceEquations\">UsersGuide.ComponentDefinition.BalanceEquations</a>.
</p>
<p>
The partial differential equations are treated with the finite volume method and a staggered grid scheme for momentum balances.
The pipe is split into nNodes equally spaced segments along the flow path. The default value is nNodes=2.
This results in two lumped mass and energy balances and one lumped momentum balance across the dynamic pipe.
</p>
<p>
Note that this generally leads to high-index DAEs for pressure states if dynamic pipes are directly connected to each other,
or generally to models with storage exposing a thermodynamic state through the port. This may not be valid
if the dynamic pipe is connected to a model with non-differentiable pressure, like a Sources.Boundary_pT with prescribed jumping pressure.
The <b><code>modelStructure</code></b> can be configured as appropriate in such situations,
in order to place a momentum balance between a pressure state of the pipe and a non-differentiable boundary condition.
</p>
<p>
The default <b><code>modelStructure</code></b> is <tt>av_vb</tt> (see Advanced tab).
The simplest possible alternative symetric configuration, avoiding potential high-index DAEs at the cost of the potential introduction
of nonlinear equation systems, is obtained with the setting <code>nNodes=1, modelStructure=a_v_b</code>.
Depending on the configured model structure, the first and the last pipe segment,
or the flow path length of the first and the last momentum balance, are of half size.
See the documentation of the base class
<a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.PartialTwoPortFlow\">Pipes.BaseClasses.PartialTwoPortFlow</a>,
also covering asymmetric configurations.
</p>
<p>
The <b><code>HeatTransfer</code></b> component specifies the source term <tt>Qb_flows</tt> of the energy balance.
The default component uses a constant coefficient for the heat transfer between the bulk flow and the segment boundaries exposed through the <code>heatPorts</code>.
The <code>HeatTransfer</code> model is replaceable and can be exchanged with any model extended from
<a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer\">BaseClasses.HeatTransfer.PartialFlowHeatTransfer</a>.
</p>
<p>
The intended use is for complex networks of pipes and other flow devices, like valves. See e.g.
<ul>
<li><a href=\"modelica://Modelica.Fluid.Examples.BranchingDynamicPipes\">Examples.BranchingDynamicPipes</a>, or </li>
<li><a href=\"modelica://Modelica.Fluid.Examples.IncompressibleFluidNetwork\">Examples.IncompressibleFluidNetwork</a>.</li>
</ul>
</p>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,44},{100,-44}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255}),
          Ellipse(
            extent={{-72,10},{-52,-10}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{50,10},{70,-10}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
  Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
              100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,60},{100,50}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
          Rectangle(
            extent={{-100,-50},{100,-60}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
          Line(
            points={{100,45},{100,50}},
            arrow={Arrow.None,Arrow.Filled},
            color={0,0,0},
            pattern=LinePattern.Dot),
          Line(
            points={{0,45},{0,50}},
            arrow={Arrow.None,Arrow.Filled},
            color={0,0,0},
            pattern=LinePattern.Dot),
          Line(
            points={{100,-45},{100,-50}},
            arrow={Arrow.None,Arrow.Filled},
            color={0,0,0},
            pattern=LinePattern.Dot),
          Line(
            points={{0,-45},{0,-50}},
            arrow={Arrow.None,Arrow.Filled},
            color={0,0,0},
            pattern=LinePattern.Dot),
          Line(
            points={{-50,60},{-50,50}},
            smooth=Smooth.None,
            color={0,0,0},
            pattern=LinePattern.Dot),
          Line(
            points={{50,60},{50,50}},
            smooth=Smooth.None,
            color={0,0,0},
            pattern=LinePattern.Dot),
          Line(
            points={{0,-50},{0,-60}},
            smooth=Smooth.None,
            color={0,0,0},
            pattern=LinePattern.Dot)}));
  end DynamicPipe;

  package BaseClasses
    "Base classes used in the Pipes package (only of interest to build new component models)"
    extends Modelica.Icons.BasesPackage;

    partial model PartialStraightPipe "Base class for straight pipe models"
      extends Modelica.Fluid.Interfaces.PartialTwoPort;

      // Geometry

      // Note: define nParallel as Real to support inverse calculations
      parameter Real nParallel(min=1)=1 "Number of identical parallel pipes"
        annotation(Dialog(group="Geometry"));
      parameter SI.Length length "Length"
        annotation(Dialog(tab="General", group="Geometry"));
      parameter Boolean isCircular=true
        "= true if cross sectional area is circular"
        annotation (Evaluate, Dialog(tab="General", group="Geometry"));
      parameter SI.Diameter diameter "Diameter of circular pipe"
        annotation(Dialog(group="Geometry", enable=isCircular));
      parameter SI.Area crossArea=Modelica.Constants.pi*diameter*diameter/4
        "Inner cross section area"
        annotation(Dialog(tab="General", group="Geometry", enable=not isCircular));
      parameter SI.Length perimeter=Modelica.Constants.pi*diameter
        "Inner perimeter"
        annotation(Dialog(tab="General", group="Geometry", enable=not isCircular));
      parameter SI.Height roughness=2.5e-5
        "Average height of surface asperities (default: smooth steel pipe)"
          annotation(Dialog(group="Geometry"));
      final parameter SI.Volume V=crossArea*length*nParallel "volume size";

      // Static head
      parameter SI.Length height_ab=0 "Height(port_b) - Height(port_a)"
          annotation(Dialog(group="Static head"));

      // Pressure loss
      replaceable model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow
        constrainedby
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
        "Wall friction, gravity, momentum flow"
          annotation(Dialog(group="Pressure loss"), choicesAllMatching=true);

    equation
      assert(length >= height_ab, "Parameter length must be greater or equal height_ab.");

      annotation (defaultComponentName="pipe",Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Rectangle(
              extent={{-100,40},{100,-40}},
              fillPattern=FillPattern.Solid,
              fillColor={95,95,95},
              pattern=LinePattern.None), Rectangle(
              extent={{-100,44},{100,-44}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,127,255})}),        Documentation(info="<html>
<p>
Base class for one dimensional flow models. It specializes a PartialTwoPort with a parameter interface and icon graphics.
</p>
</html>"),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics));
    end PartialStraightPipe;

    partial model PartialTwoPortFlow "Base class for distributed flow models"

      import Modelica.Fluid.Types.ModelStructure;

      // extending PartialTwoPort
      extends Modelica.Fluid.Interfaces.PartialTwoPort(
        final port_a_exposesState = (modelStructure == ModelStructure.av_b) or (modelStructure == ModelStructure.av_vb),
        final port_b_exposesState = (modelStructure == ModelStructure.a_vb) or (modelStructure == ModelStructure.av_vb));

      // distributed volume model
      extends Modelica.Fluid.Interfaces.PartialDistributedVolume(
        final n = nNodes,
        final fluidVolumes = {crossAreas[i]*lengths[i] for i in 1:n}*nParallel);

      // Geometry parameters
      parameter Real nParallel(min=1)=1
        "Number of identical parallel flow devices"
        annotation(Dialog(group="Geometry"));
      parameter SI.Length[n] lengths "lengths of flow segments"
        annotation(Dialog(group="Geometry"));
      parameter SI.Area[n] crossAreas "cross flow areas of flow segments"
        annotation(Dialog(group="Geometry"));
      parameter SI.Length[n] dimensions "hydraulic diameters of flow segments"
        annotation(Dialog(group="Geometry"));
      parameter SI.Height[n] roughnesses
        "Average heights of surface asperities"
        annotation(Dialog(group="Geometry"));

      // Static head
      parameter SI.Length[n] dheights=zeros(n)
        "Differences in heigths of flow segments"
          annotation(Dialog(group="Static head"), Evaluate=true);

      // Assumptions
      parameter Types.Dynamics momentumDynamics=system.momentumDynamics
        "Formulation of momentum balances"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));

      // Initialization
      parameter Medium.MassFlowRate m_flow_start = system.m_flow_start
        "Start value for mass flow rate"
         annotation(Evaluate=true, Dialog(tab = "Initialization"));

      // Discretization
      parameter Integer nNodes(min=1)=2 "Number of discrete flow volumes"
        annotation(Dialog(tab="Advanced"),Evaluate=true);

      parameter Types.ModelStructure modelStructure=Types.ModelStructure.av_vb
        "Determines whether flow or volume models are present at the ports"
        annotation(Dialog(tab="Advanced"), Evaluate=true);

      parameter Boolean useLumpedPressure=false
        "=true to lump pressure states together"
        annotation(Dialog(tab="Advanced"),Evaluate=true);
      final parameter Integer nFM=if useLumpedPressure then nFMLumped else nFMDistributed
        "number of flow models in flowModel";
      final parameter Integer nFMDistributed=if modelStructure==Types.ModelStructure.a_v_b then n+1 else if (modelStructure==Types.ModelStructure.a_vb or modelStructure==Types.ModelStructure.av_b) then n else n-1;
      final parameter Integer nFMLumped=if modelStructure==Types.ModelStructure.a_v_b then 2 else 1;
      final parameter Integer iLumped=integer(n/2)+1
        "Index of control volume with representative state if useLumpedPressure"
        annotation(Evaluate=true);

      // Advanced model options
      parameter Boolean useInnerPortProperties=false
        "=true to take port properties for flow models from internal control volumes"
        annotation(Dialog(tab="Advanced"),Evaluate=true);
      Medium.ThermodynamicState state_a
        "state defined by volume outside port_a";
      Medium.ThermodynamicState state_b
        "state defined by volume outside port_b";
      Medium.ThermodynamicState[nFM+1] statesFM
        "state vector for flowModel model";

      // Pressure loss model
      replaceable model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow
        constrainedby
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
        "Wall friction, gravity, momentum flow"
          annotation(Dialog(group="Pressure loss"), choicesAllMatching=true);
      FlowModel flowModel(
              redeclare final package Medium = Medium,
              final n=nFM+1,
              final states=statesFM,
              final vs=vsFM,
              final momentumDynamics=momentumDynamics,
              final allowFlowReversal=allowFlowReversal,
              final p_a_start=p_a_start,
              final p_b_start=p_b_start,
              final m_flow_start=m_flow_start,
              final nParallel=nParallel,
              final pathLengths=pathLengths,
              final crossAreas=crossAreasFM,
              final dimensions=dimensionsFM,
              final roughnesses=roughnessesFM,
              final dheights=dheightsFM,
              final g=system.g) "Flow model"
         annotation (Placement(transformation(extent={{-77,-38},{75,-20}},rotation=0)));

      // Flow quantities
      Medium.MassFlowRate[n+1] m_flows(
         each min=if allowFlowReversal then -Modelica.Constants.inf else 0,
         each start=m_flow_start)
        "Mass flow rates of fluid across segment boundaries";
      Medium.MassFlowRate[n+1, Medium.nXi] mXi_flows
        "Independent mass flow rates across segment boundaries";
      Medium.MassFlowRate[n+1, Medium.nC] mC_flows
        "Trace substance mass flow rates across segment boundaries";
      Medium.EnthalpyFlowRate[n+1] H_flows
        "Enthalpy flow rates of fluid across segment boundaries";

      SI.Velocity[n] vs = {0.5*(m_flows[i] + m_flows[i+1])/mediums[i].d/crossAreas[i] for i in 1:n}/nParallel
        "mean velocities in flow segments";

      // Model structure dependent flow geometry
    protected
      SI.Length[nFM] pathLengths "Lengths along flow path";
      SI.Length[nFM] dheightsFM "Differences in heights between flow segments";
      SI.Area[nFM+1] crossAreasFM "Cross flow areas of flow segments";
      SI.Velocity[nFM+1] vsFM "Mean velocities in flow segments";
      SI.Length[nFM+1] dimensionsFM "Hydraulic diameters of flow segments";
      SI.Height[nFM+1] roughnessesFM "Average heights of surface asperities";

    equation
      assert(nNodes > 1 or modelStructure <> ModelStructure.av_vb,
         "nNodes needs to be at least 2 for modelStructure av_vb, as flow model disappears otherwise!");
      // staggered grid discretization of geometry for flowModel, depending on modelStructure
      if useLumpedPressure then
        if modelStructure <> ModelStructure.a_v_b then
          pathLengths[1] = sum(lengths);
          dheightsFM[1] = sum(dheights);
          if n == 1 then
            crossAreasFM[1:2] = {crossAreas[1], crossAreas[1]};
            dimensionsFM[1:2] = {dimensions[1], dimensions[1]};
            roughnessesFM[1:2] = {roughnesses[1], roughnesses[1]};
          else // n > 1
            crossAreasFM[1:2] = {sum(crossAreas[1:iLumped-1])/(iLumped-1), sum(crossAreas[iLumped:n])/(n-iLumped+1)};
            dimensionsFM[1:2] = {sum(dimensions[1:iLumped-1])/(iLumped-1), sum(dimensions[iLumped:n])/(n-iLumped+1)};
            roughnessesFM[1:2] = {sum(roughnesses[1:iLumped-1])/(iLumped-1), sum(roughnesses[iLumped:n])/(n-iLumped+1)};
          end if;
        else
          if n == 1 then
            pathLengths[1:2] = {lengths[1]/2, lengths[1]/2};
            dheightsFM[1:2] = {dheights[1]/2, dheights[1]/2};
            crossAreasFM[1:3] = {crossAreas[1], crossAreas[1], crossAreas[1]};
            dimensionsFM[1:3] = {dimensions[1], dimensions[1], dimensions[1]};
            roughnessesFM[1:3] = {roughnesses[1], roughnesses[1], roughnesses[1]};
          else // n > 1
            pathLengths[1:2] = {sum(lengths[1:iLumped-1]), sum(lengths[iLumped:n])};
            dheightsFM[1:2] = {sum(dheights[1:iLumped-1]), sum(dheights[iLumped:n])};
            crossAreasFM[1:3] = {sum(crossAreas[1:iLumped-1])/(iLumped-1), sum(crossAreas)/n, sum(crossAreas[iLumped:n])/(n-iLumped+1)};
            dimensionsFM[1:3] = {sum(dimensions[1:iLumped-1])/(iLumped-1), sum(dimensions)/n, sum(dimensions[iLumped:n])/(n-iLumped+1)};
            roughnessesFM[1:3] = {sum(roughnesses[1:iLumped-1])/(iLumped-1), sum(roughnesses)/n, sum(roughnesses[iLumped:n])/(n-iLumped+1)};
          end if;
        end if;
      else
        if modelStructure == ModelStructure.av_vb then
          //nFM = n-1;
          if n == 2 then
            pathLengths[1] = lengths[1] + lengths[2];
            dheightsFM[1] = dheights[1] + dheights[2];
          else
            pathLengths[1:n-1] = cat(1, {lengths[1] + 0.5*lengths[2]}, 0.5*(lengths[2:n-2] + lengths[3:n-1]), {0.5*lengths[n-1] + lengths[n]});
            dheightsFM[1:n-1] = cat(1, {dheights[1] + 0.5*dheights[2]}, 0.5*(dheights[2:n-2] + dheights[3:n-1]), {0.5*dheights[n-1] + dheights[n]});
          end if;
          crossAreasFM[1:n] = crossAreas;
          dimensionsFM[1:n] = dimensions;
          roughnessesFM[1:n] = roughnesses;
        elseif modelStructure == ModelStructure.av_b then
          //nFM = n
          pathLengths[1:n] = lengths;
          dheightsFM[1:n] = dheights;
          crossAreasFM[1:n+1] = cat(1, crossAreas[1:n], {crossAreas[n]});
          dimensionsFM[1:n+1] = cat(1, dimensions[1:n], {dimensions[n]});
          roughnessesFM[1:n+1] = cat(1, roughnesses[1:n], {roughnesses[n]});
        elseif modelStructure == ModelStructure.a_vb then
          //nFM = n
          pathLengths[1:n] = lengths;
          dheightsFM[1:n] = dheights;
          crossAreasFM[1:n+1] = cat(1, {crossAreas[1]}, crossAreas[1:n]);
          dimensionsFM[1:n+1] = cat(1, {dimensions[1]}, dimensions[1:n]);
          roughnessesFM[1:n+1] = cat(1, {roughnesses[1]}, roughnesses[1:n]);
        elseif modelStructure == ModelStructure.a_v_b then
          //nFM = n+1;
          pathLengths[1:n+1] = cat(1, {0.5*lengths[1]}, 0.5*(lengths[1:n-1] + lengths[2:n]), {0.5*lengths[n]});
          dheightsFM[1:n+1] = cat(1, {0.5*dheights[1]}, 0.5*(dheights[1:n-1] + dheights[2:n]), {0.5*dheights[n]});
          crossAreasFM[1:n+2] = cat(1, {crossAreas[1]}, crossAreas[1:n], {crossAreas[n]});
          dimensionsFM[1:n+2] = cat(1, {dimensions[1]}, dimensions[1:n], {dimensions[n]});
          roughnessesFM[1:n+2] = cat(1, {roughnesses[1]}, roughnesses[1:n], {roughnesses[n]});
        else
          assert(true, "Unknown model structure");
        end if;
      end if;

      // Source/sink terms for mass and energy balances
      for i in 1:n loop
        mb_flows[i] = m_flows[i] - m_flows[i + 1];
        mbXi_flows[i, :] = mXi_flows[i, :] - mXi_flows[i + 1, :];
        mbC_flows[i, :]  = mC_flows[i, :]  - mC_flows[i + 1, :];
        Hb_flows[i] = H_flows[i] - H_flows[i + 1];
      end for;

      // Distributed flow quantities, upwind discretization
      for i in 2:n loop
        H_flows[i] = semiLinear(m_flows[i], mediums[i - 1].h, mediums[i].h);
        mXi_flows[i, :] = semiLinear(m_flows[i], mediums[i - 1].Xi, mediums[i].Xi);
        mC_flows[i, :]  = semiLinear(m_flows[i], Cs[i - 1, :],         Cs[i, :]);
      end for;
      H_flows[1] = semiLinear(port_a.m_flow, inStream(port_a.h_outflow), mediums[1].h);
      H_flows[n + 1] = -semiLinear(port_b.m_flow, inStream(port_b.h_outflow), mediums[n].h);
      mXi_flows[1, :] = semiLinear(port_a.m_flow, inStream(port_a.Xi_outflow), mediums[1].Xi);
      mXi_flows[n + 1, :] = -semiLinear(port_b.m_flow, inStream(port_b.Xi_outflow), mediums[n].Xi);
      mC_flows[1, :] = semiLinear(port_a.m_flow, inStream(port_a.C_outflow), Cs[1, :]);
      mC_flows[n + 1, :] = -semiLinear(port_b.m_flow, inStream(port_b.C_outflow), Cs[n, :]);

      // Boundary conditions
      port_a.m_flow    = m_flows[1];
      port_b.m_flow    = -m_flows[n + 1];
      port_a.h_outflow = mediums[1].h;
      port_b.h_outflow = mediums[n].h;
      port_a.Xi_outflow = mediums[1].Xi;
      port_b.Xi_outflow = mediums[n].Xi;
      port_a.C_outflow = Cs[1, :];
      port_b.C_outflow = Cs[n, :];
      // The two equations below are not correct if C is stored in volumes.
      // C should be treated the same way as Xi.
      //port_a.C_outflow = inStream(port_b.C_outflow);
      //port_b.C_outflow = inStream(port_a.C_outflow);

      if useInnerPortProperties and n > 0 then
        state_a = Medium.setState_phX(port_a.p, mediums[1].h, mediums[1].Xi);
        state_b = Medium.setState_phX(port_b.p, mediums[n].h, mediums[n].Xi);
      else
        state_a = Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow));
        state_b = Medium.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow));
      end if;

      // staggered grid discretization for flowModel, depending on modelStructure
      if useLumpedPressure then
        if modelStructure <> ModelStructure.av_vb then
          // all pressures are equal
          fill(mediums[1].p, n-1) = mediums[2:n].p;
        elseif n > 2 then
          // need two pressures
          fill(mediums[1].p, iLumped-2) = mediums[2:iLumped-1].p;
          fill(mediums[n].p, n-iLumped) = mediums[iLumped:n-1].p;
        end if;
        if modelStructure == ModelStructure.av_vb then
          port_a.p = mediums[1].p;
          statesFM[1] = mediums[1].state;
          m_flows[iLumped] = flowModel.m_flows[1];
          statesFM[2] = mediums[n].state;
          port_b.p = mediums[n].p;
        elseif modelStructure == ModelStructure.av_b then
          port_a.p = mediums[1].p;
          statesFM[1] = mediums[iLumped].state;
          statesFM[2] = state_b;
          m_flows[n+1] = flowModel.m_flows[1];
        elseif modelStructure == ModelStructure.a_vb then
          m_flows[1] = flowModel.m_flows[1];
          statesFM[1] = state_a;
          statesFM[2] = mediums[iLumped].state;
          port_b.p = mediums[n].p;
        elseif modelStructure == ModelStructure.a_v_b then
          m_flows[1] = flowModel.m_flows[1];
          statesFM[1] = state_a;
          statesFM[2] = mediums[iLumped].state;
          statesFM[3] = state_b;
          m_flows[n+1] = flowModel.m_flows[2];
        else
          assert(true, "Unknown model structure");
        end if;
        if modelStructure <> ModelStructure.a_v_b then
          vsFM[1] = vs[1:iLumped-1]*lengths[1:iLumped-1]/sum(lengths[1:iLumped-1]);
          vsFM[2] = vs[iLumped:n]*lengths[iLumped:n]/sum(lengths[iLumped:n]);
        else
          vsFM[1] = vs[1:iLumped-1]*lengths[1:iLumped-1]/sum(lengths[1:iLumped-1]);
          vsFM[2] = vs[2:n-1]*lengths[2:n-1]/sum(lengths[2:n-1]);
          vsFM[3] = vs[iLumped:n]*lengths[iLumped:n]/sum(lengths[iLumped:n]);
        end if;
      else
        if modelStructure == ModelStructure.av_vb then
          //nFM = n-1
          statesFM[1:n] = mediums[1:n].state;
          m_flows[2:n] = flowModel.m_flows[1:n-1];
          vsFM[1:n] = vs;
          port_a.p = mediums[1].p;
          port_b.p = mediums[n].p;
        elseif modelStructure == ModelStructure.av_b then
          //nFM = n
          statesFM[1:n] = mediums[1:n].state;
          statesFM[n+1] = state_b;
          m_flows[2:n+1] = flowModel.m_flows[1:n];
          vsFM[1:n] = vs;
          vsFM[n+1] = m_flows[n+1]/Medium.density(state_b)/crossAreas[n]/nParallel;
          port_a.p = mediums[1].p;
        elseif modelStructure == ModelStructure.a_vb then
          //nFM = n
          statesFM[1] = state_a;
          statesFM[2:n+1] = mediums[1:n].state;
          m_flows[1:n] = flowModel.m_flows[1:n];
          vsFM[1] = m_flows[1]/Medium.density(state_a)/crossAreas[1]/nParallel;
          vsFM[2:n+1] = vs;
          port_b.p = mediums[n].p;
        elseif modelStructure == ModelStructure.a_v_b then
          //nFM = n+1
          statesFM[1] = state_a;
          statesFM[2:n+1] = mediums[1:n].state;
          statesFM[n+2] = state_b;
          m_flows[1:n+1] = flowModel.m_flows[1:n+1];
          vsFM[1] = m_flows[1]/Medium.density(state_a)/crossAreas[1]/nParallel;
          vsFM[2:n+1] = vs;
          vsFM[n+2] = m_flows[n+1]/Medium.density(state_b)/crossAreas[n]/nParallel;
        else
          assert(true, "Unknown model structure");
        end if;
      end if;

      annotation (defaultComponentName="pipe",
    Documentation(info="<html>
<p>Base class for distributed flow models. The total volume is split into nNodes segments along the flow path.
The default value is nNodes=2.
</p>
<p><b>Mass and Energy balances</b></p>
The mass and energy balances are inherited from <a href=\"modelica://Modelica.Fluid.Interfaces.PartialDistributedVolume\">Interfaces.PartialDistributedVolume</a>.
One total mass and one energy balance is formed across each segment according to the finite volume approach.
Substance mass balances are added if the medium contains more than one component.
<p>
An extending model needs to define the geometry and the difference in heights between the flow segments (static head).
Moreover it needs to define two vectors of source terms for the distributed energy balance:
<ul>
<li><code><b>Qb_flows[nNodes]</b></code>, the heat flow source terms, e.g., conductive heat flows across segment boundaries, and</li>
<li><code><b>Wb_flows[nNodes]</b></code>, the work source terms.</li>
</ul>
</p>

<p><b>Momentum balance</b></p>
The momentum balance is determined by the <b><code>FlowModel</code></b> component, which can be replaced with any model extended from
<a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel\">BaseClasses.FlowModels.PartialStaggeredFlowModel</a>.
The default setting is <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow\">DetailedPipeFlow</a>.
This considers
<ul>
<li>pressure drop due to friction and other dissipative losses, and</li>
<li>gravity effects for non-horizontal devices.</li>
<li>variation of flow velocity along the flow path,
which occur due to changes in the cross sectional area or the fluid density, provided that <code>flowModel.use_Ib_flows</code> is true.
</ul>

<p><b>Model Structure</b></p>
The momentum balances are formulated across the segment boundaries along the flow path according to the staggered grid approach.
The configurable <b><code>modelStructure</code></b> determines the formulation of the boundary conditions at <tt>port_a</tt> and <tt>port_b</tt>.
The options include (default: av_vb):
<ul>
<li><code>av_vb</code>: Symmetric setting with nNodes-1 momentum balances between nNodes flow segments.
    The ports <code>port_a</code> and <tt>port_b</tt> expose the first and the last thermodynamic state, respectively.
    Connecting two or more flow devices therefore may result in high-index DAEs for the pressures of connected flow segments.
<li><code>a_v_b</code>: Alternative symmetric setting with nNodes+1 momentum balances across nNodes flow segments.
    Half momentum balances are placed between <code>port_a</code> and the first flow segment as well as between the last flow segment and <tt>port_b</tt>.
    Connecting two or more flow devices therefore results in algebraic pressures at the ports.
    The specification of good start values for the port pressures is essential for the solution of large nonlinear equation systems.</li>
<li><code>av_b</code>: Unsymmetric setting with nNodes momentum balances, one between nth volume and <tt>port_b</tt>, potential pressure state at <tt>port_a</tt></li>
<li><code>a_vb</code>: Unsymmetric setting with nNodes momentum balance, one between first volume and <tt>port_a</tt>, potential pressure state at <tt>port_b</tt></li>
</ul></p>

When connecting two components, e.g., two pipes, the momentum balance across the connection point reduces to
</p>
<pre>pipe1.port_b.p = pipe2.port_a.p</pre>
<p>
This is only true if the flow velocity remains the same on each side of the connection.
Consider using a fitting for any significant change in diameter or fluid density, if the resulting effects,
such as change in kinetic energy, cannot be neglected.
This also allows for taking into account friction losses with respect to the actual geometry of the connection point.
</p>

</html>",
        revisions="<html>
<ul>
<li><i>5 Dec 2008</i>
    by Michael Wetter:<br>
       Modified mass balance for trace substances. With the new formulation, the trace substances masses <code>mC</code> are stored
       in the same way as the species <code>mXi</code>.</li>
<li><i>Dec 2008</i>
    by R&uuml;diger Franke:<br>
       Derived model from original DistributedPipe models
    <ul>
    <li>moved mass and energy balances to PartialDistributedVolume</li>
    <li>introduced replaceable pressure loss models</li>
    <li>combined all model structures and lumped pressure into one model</li>
    <li>new ModelStructure av_vb, replacing former avb</li>
    </ul></li>
<li><i>04 Mar 2006</i>
    by Katrin Pr&ouml;l&szlig;:<br>
       Model added to the Fluid library</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
                100}},
            grid={1,1}), graphics={Ellipse(
              extent={{-72,10},{-52,-10}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid), Ellipse(
              extent={{50,10},{70,-10}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
                100,100}},
            grid={1,1}), graphics={
            Polygon(
              points={{-100,-50},{-100,50},{100,60},{100,-60},{-100,-50}},
              smooth=Smooth.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Polygon(
              points={{-50,-52},{-50,52},{50,58},{50,-58},{-50,-52}},
              smooth=Smooth.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Line(
              points={{-100,-50},{-100,50}},
              arrow={Arrow.Filled,Arrow.Filled},
              color={0,0,0},
              pattern=LinePattern.Dot),
            Text(
              extent={{-99,36},{-69,30}},
              lineColor={0,0,255},
              textString="crossAreas[1]",
              pattern=LinePattern.None),
            Line(
              points={{-100,70},{-50,70}},
              arrow={Arrow.Filled,Arrow.Filled},
              color={0,0,0},
              pattern=LinePattern.Dot),
            Text(
              extent={{0,36},{40,30}},
              lineColor={0,0,255},
              textString="crossAreas[2:n-1]",
              pattern=LinePattern.None),
            Line(
              points={{100,-60},{100,60}},
              arrow={Arrow.Filled,Arrow.Filled},
              color={0,0,0},
              pattern=LinePattern.Dot),
            Text(
              extent={{100.5,36},{130.5,30}},
              lineColor={0,0,255},
              textString="crossAreas[n]",
              pattern=LinePattern.None),
            Line(
              points={{-50,52},{-50,-53}},
              smooth=Smooth.None,
              color={0,0,0},
              pattern=LinePattern.Dash),
            Line(
              points={{50,57},{50,-58}},
              smooth=Smooth.None,
              color={0,0,0},
              pattern=LinePattern.Dash),
            Line(
              points={{50,70},{100,70}},
              arrow={Arrow.Filled,Arrow.Filled},
              color={0,0,0},
              pattern=LinePattern.Dot),
            Line(
              points={{-50,70},{50,70}},
              arrow={Arrow.Filled,Arrow.Filled},
              color={0,0,0},
              pattern=LinePattern.Dot),
            Text(
              extent={{-30,77},{30,71}},
              lineColor={0,0,255},
              textString="lengths[2:n-1]",
              pattern=LinePattern.None),
            Line(
              points={{-100,-70},{0,-70}},
              arrow={Arrow.None,Arrow.Filled},
              color={0,0,0}),
            Text(
              extent={{-80,-63},{-20,-69}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="flowModel.dps_fg[1]"),
            Line(
              points={{0,-70},{100,-70}},
              arrow={Arrow.None,Arrow.Filled},
              color={0,0,0}),
            Text(
              extent={{20.5,-63},{80,-69}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="flowModel.dps_fg[2:n-1]"),
            Line(
              points={{-95,0},{-5,0}},
              arrow={Arrow.None,Arrow.Filled},
              color={0,0,0}),
            Text(
              extent={{-49,7},{-19,1}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="m_flows[2]"),
            Line(
              points={{5,0},{95,0}},
              arrow={Arrow.None,Arrow.Filled},
              color={0,0,0}),
            Text(
              extent={{17,7},{47,1}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="m_flows[3:n]"),
            Line(
              points={{-150,0},{-105,0}},
              arrow={Arrow.None,Arrow.Filled},
              color={0,0,0}),
            Line(
              points={{105,0},{150,0}},
              arrow={Arrow.None,Arrow.Filled},
              color={0,0,0}),
            Text(
              extent={{-140,7},{-110,1}},
              lineColor={0,0,255},
              textString="m_flows[1]",
              pattern=LinePattern.None),
            Text(
              extent={{111,7},{141,1}},
              lineColor={0,0,255},
              textString="m_flows[n+1]",
              pattern=LinePattern.None),
            Text(
              extent={{35,-92},{100,-98}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="(ModelStructure av_vb, n=3)"),
            Line(
              points={{-100,-50},{-100,-86}},
              smooth=Smooth.None,
              color={0,0,0},
              pattern=LinePattern.Dot),
            Line(
              points={{0,-55},{0,-86}},
              smooth=Smooth.None,
              color={0,0,0},
              pattern=LinePattern.Dot),
            Line(
              points={{100,-60},{100,-86}},
              smooth=Smooth.None,
              color={0,0,0},
              pattern=LinePattern.Dot),
            Ellipse(
              extent={{-5,5},{5,-5}},
              pattern=LinePattern.None,
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{3,-4},{33,-10}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="states[2:n-1]"),
            Ellipse(
              extent={{95,5},{105,-5}},
              pattern=LinePattern.None,
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{104,-4},{124,-10}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="states[n]"),
            Ellipse(
              extent={{-105,5},{-95,-5}},
              pattern=LinePattern.None,
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-96,-4},{-76,-10}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="states[1]"),
            Text(
              extent={{-99.5,30},{-69.5,24}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="dimensions[1]"),
            Text(
              extent={{-0.5,30},{40,24}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="dimensions[2:n-1]"),
            Text(
              extent={{100.5,30},{130.5,24}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="dimensions[n]"),
            Line(
              points={{-50,73},{-50,52}},
              smooth=Smooth.None,
              color={0,0,0},
              pattern=LinePattern.Dot),
            Line(
              points={{50,73},{50,57}},
              smooth=Smooth.None,
              color={0,0,0},
              pattern=LinePattern.Dot),
            Line(
              points={{-100,50},{100,60}},
              smooth=Smooth.None,
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-100,-50},{100,-60}},
              smooth=Smooth.None,
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-100,73},{-100,50}},
              smooth=Smooth.None,
              color={0,0,0},
              pattern=LinePattern.Dot),
            Line(
              points={{100,73},{100,60}},
              smooth=Smooth.None,
              color={0,0,0},
              pattern=LinePattern.Dot),
            Line(
              points={{0,-55},{0,55}},
              arrow={Arrow.Filled,Arrow.Filled},
              color={0,0,0},
              pattern=LinePattern.Dot),
            Line(
              points={{-50,11},{50,11}},
              arrow={Arrow.None,Arrow.Filled},
              color={0,0,0}),
            Text(
              extent={{5,18},{25,12}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="vs[2:n-1]"),
            Text(
              extent={{-80,18},{-70,12}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="vs[1]"),
            Line(
              points={{-100,11},{-50,11}},
              arrow={Arrow.None,Arrow.Filled},
              color={0,0,0}),
            Text(
              extent={{70,18},{80,12}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="vs[n]"),
            Line(
              points={{50,11},{100,11}},
              arrow={Arrow.None,Arrow.Filled},
              color={0,0,0}),
            Text(
              extent={{-80,-75},{-20,-81}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="flowModel.pathLengths[1]"),
            Line(
              points={{-100,-82},{0,-82}},
              arrow={Arrow.Filled,Arrow.Filled},
              color={0,0,0}),
            Line(
              points={{0,-82},{100,-82}},
              arrow={Arrow.Filled,Arrow.Filled},
              color={0,0,0}),
            Text(
              extent={{15,-75},{85,-81}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="flowModel.pathLengths[2:n-1]"),
            Text(
              extent={{-100,77},{-50,71}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="lengths[1]"),
            Text(
              extent={{50,77},{100,71}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              textString="lengths[n]")}));
    end PartialTwoPortFlow;

    package FlowModels
      "Flow models for pipes, including wall friction, static head and momentum flow"
      extends Modelica.Icons.Package;
          partial model PartialStaggeredFlowModel
        "Base class for momentum balances in flow models"

            //
            // Internal interface
            // (not exposed to GUI; needs to be hard coded when using this model
            //
            replaceable package Medium =
              Modelica.Media.Interfaces.PartialMedium "Medium in the component"
                annotation(Dialog(tab="Internal Interface",enable=false));

            parameter Integer n=2 "Number of discrete flow volumes"
              annotation(Dialog(tab="Internal Interface",enable=false));

            // Inputs
            input Medium.ThermodynamicState[n] states
          "Thermodynamic states along design flow";
            input Modelica.SIunits.Velocity[n] vs
          "Mean velocities of fluid flow";

            // Geometry parameters and inputs
            parameter Real nParallel
          "number of identical parallel flow devices"
               annotation(Dialog(tab="Internal Interface",enable=false,group="Geometry"));

            input SI.Area[n] crossAreas
          "Cross flow areas at segment boundaries";
            input SI.Length[n] dimensions
          "Characteristic dimensions for fluid flow (diameters for pipe flow)";
            input SI.Height[n] roughnesses
          "Average height of surface asperities";

            // Static head
            input SI.Length[n-1] dheights
          "Height(states[2:n]) - Height(states[1:n-1])";

            parameter SI.Acceleration g=system.g
          "Constant gravity acceleration"
              annotation(Dialog(tab="Internal Interface",enable=false,group="Static head"));

            // Assumptions
            parameter Boolean allowFlowReversal=system.allowFlowReversal
          "= true to allow flow reversal, false restricts to design direction (states[1] -> states[n+1])"
              annotation(Dialog(tab="Internal Interface",enable=false,group="Assumptions"), Evaluate=true);
            parameter Modelica.Fluid.Types.Dynamics momentumDynamics=system.momentumDynamics
          "Formulation of momentum balance"
              annotation(Dialog(tab="Internal Interface",enable=false,group = "Assumptions"), Evaluate=true);

            // Initialization
            parameter Medium.MassFlowRate m_flow_start=system.m_flow_start
          "Start value of mass flow rates"
              annotation(Dialog(tab="Internal Interface",enable=false,group = "Initialization"));
            parameter Medium.AbsolutePressure p_a_start
          "Start value for p[1] at design inflow"
              annotation(Dialog(tab="Internal Interface",enable=false,group = "Initialization"));
            parameter Medium.AbsolutePressure p_b_start
          "Start value for p[n+1] at design outflow"
              annotation(Dialog(tab="Internal Interface",enable=false,group = "Initialization"));

            //
            // Implementation of momentum balance
            //
            extends Modelica.Fluid.Interfaces.PartialDistributedFlow(
                       final m = n-1);

            // Advanced parameters
            parameter Boolean useUpstreamScheme = true
          "= false to average upstream and downstream properties across flow segments"
               annotation(Dialog(group="Advanced"), Evaluate=true);

            parameter Boolean use_Ib_flows = momentumDynamics <> Types.Dynamics.SteadyState
          "= true to consider differences in flow of momentum through boundaries"
               annotation(Dialog(group="Advanced"), Evaluate=true);

            // Variables
            SI.Density[n] rhos = if use_rho_nominal then fill(rho_nominal, n) else Medium.density(states);
            SI.Density[n-1] rhos_act "Actual density per segment";

            SI.DynamicViscosity[n] mus = if use_mu_nominal then fill(mu_nominal, n) else Medium.dynamicViscosity(states);
            SI.DynamicViscosity[n-1] mus_act "Actual viscosity per segment";

            // Variables
            Modelica.SIunits.Pressure[n-1] dps_fg(each start = (p_a_start - p_b_start)/(n-1))
          "pressure drop between states";

            // Reynolds Number
            parameter SI.ReynoldsNumber Re_turbulent = 4000
          "Start of turbulent regime, depending on type of flow device";
            parameter Boolean show_Res = false
          "= true, if Reynolds numbers are included for plotting"
               annotation (Evaluate=true, Dialog(group="Diagnostics"));
            SI.ReynoldsNumber[n] Res=Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(
                vs,
                rhos,
                mus,
                dimensions) if show_Res "Reynolds numbers";
            Medium.MassFlowRate[n-1] m_flows_turbulent=
                {nParallel*(Modelica.Constants.pi/4)*0.5*(dimensions[i] + dimensions[i+1])*mus_act[i]*Re_turbulent for i in 1:n-1} if
                   show_Res "Start of turbulent flow";
      protected
            parameter Boolean use_rho_nominal = false
          "= true, if rho_nominal is used, otherwise computed from medium"
               annotation(Dialog(group="Advanced"), Evaluate=true);
            parameter SI.Density rho_nominal = Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default)
          "Nominal density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
              annotation(Dialog(group="Advanced", enable=use_rho_nominal));

            parameter Boolean use_mu_nominal = false
          "= true, if mu_nominal is used, otherwise computed from medium"
               annotation(Dialog(group="Advanced"), Evaluate=true);
            parameter SI.DynamicViscosity mu_nominal = Medium.dynamicViscosity(
                                                           Medium.setState_pTX(
                                                               Medium.p_default, Medium.T_default, Medium.X_default))
          "Nominal dynamic viscosity (e.g., mu_liquidWater = 1e-3, mu_air = 1.8e-5)"
              annotation(Dialog(group="Advanced", enable=use_mu_nominal));

          equation
            if not allowFlowReversal then
              rhos_act = rhos[1:n-1];
              mus_act = mus[1:n-1];
            elseif not useUpstreamScheme then
              rhos_act = 0.5*(rhos[1:n-1] + rhos[2:n]);
              mus_act = 0.5*(mus[1:n-1] + mus[2:n]);
            else
              for i in 1:n-1 loop
                rhos_act[i] = noEvent(if m_flows[i] > 0 then rhos[i] else rhos[i+1]);
                mus_act[i] = noEvent(if m_flows[i] > 0 then mus[i] else mus[i+1]);
              end for;
            end if;

            if use_Ib_flows then
              Ib_flows = {rhos[i]*vs[i]*vs[i]*crossAreas[i] - rhos[i+1]*vs[i+1]*vs[i+1]*crossAreas[i+1] for i in 1:n-1};
              // alternatively use densities rhos_act of actual streams, together with mass flow rates,
              // not conserving momentum if fluid density changes between flow segments:
              //Ib_flows = {((rhos[i]*vs[i])^2*crossAreas[i] - (rhos[i+1]*vs[i+1])^2*crossAreas[i+1])/rhos_act[i] for i in 1:n-1};
            else
              Ib_flows = zeros(n-1);
            end if;

            Fs_p = nParallel*{0.5*(crossAreas[i]+crossAreas[i+1])*(Medium.pressure(states[i+1])-Medium.pressure(states[i])) for i in 1:n-1};

            // Note: the equation is written for dps_fg instead of Fs_fg to help the translator
            dps_fg = {Fs_fg[i]/nParallel*2/(crossAreas[i]+crossAreas[i+1]) for i in 1:n-1};

            annotation (Documentation(info="<html>
<p>
This paratial model defines a common interface for <code>m=n-1</code> flow models between <tt>n</tt> device segments.
The flow models provide a steady-state or dynamic momentum balance using an upwind discretization scheme per default.
Extending models must add pressure loss terms for friction and gravity.
</p>
<p>
The fluid is specified in the interface with the thermodynamic <code>states[n]</code> for a given <tt>Medium</tt> model.
The geometry is specified with the <code>pathLengths[n-1]</code> between the device segments as well as
with the <code>crossAreas[n]</code> and the <tt>roughnesses[n]</tt> of the device segments.
Moreover the fluid flow is characterized for different types of devices by the characteristic <code>dimensions[n]</code>
and the average velocities <code>vs[n]</code> of fluid flow in the device segments.
See <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber\">Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber</a>
for examplary definitions.
</p>
<p>
The parameter <code>Re_turbulent</code> can be specified for the least mass flow rate of the turbulent regime.
It defaults to 4000, which is appropriate for pipe flow.
The <code>m_flows_turbulent[n-1]</code> resulting from <tt>Re_turbulent</tt> can optionally be calculated together with the Reynolds numbers
<code>Res[n]</code> of the device segments (<tt>show_Res=true</tt>).
</p>
<p>
Using the thermodynamic states[n] of the device segments, the densities rhos[n] and the dynamic viscosities mus[n]
of the segments as well as the actual densities rhos_act[n-1] and the actual viscosities mus_act[n-1] of the flows are predefined
in this base model. Note that no events are raised on flow reversal. This needs to be treated by an extending model,
e.g., with numerical smoothing or by raising events as appropriate.
</p>
</html>"),     Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Line(
                points={{-80,-50},{-80,50},{80,-50},{80,50}},
                color={0,0,255},
                smooth=Smooth.None,
                thickness=1), Text(
                extent={{-40,-50},{40,-90}},
                lineColor={0,0,0},
                textString="%name")}));
          end PartialStaggeredFlowModel;

      model NominalLaminarFlow
        "NominalLaminarFlow: Linear pressure loss for nominal values"
        extends
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel(
           use_mu_nominal=not show_Res);

        // Operational conditions
        parameter SI.AbsolutePressure dp_nominal "Nominal pressure loss";
        parameter SI.MassFlowRate m_flow_nominal
          "Mass flow rate for dp_nominal";

        // Inverse parameterization assuming pipe flow and WallFriction.Laminar
        // Laminar.massFlowRate_dp:
        //   m_flow = dp*pi*diameter^4*d/(128*length*mu);
        SI.Length[n-1] pathLengths_nominal=
          {(dp_nominal/(n-1)-g*dheights[i])*Modelica.Constants.pi*((dimensions[i]+dimensions[i+1])/2)^4*rhos_act[i]/(128*mus_act[i])/
           (m_flow_nominal/nParallel) for i in 1:n-1} if show_Res;

      equation
        // linear pressure loss
        if  not allowFlowReversal or use_rho_nominal or not useUpstreamScheme then
          dps_fg = {g*dheights[i]*rhos_act[i] for i in 1:n-1} + dp_nominal/(n-1)/m_flow_nominal*m_flows;
        else
          dps_fg = {g*dheights[i]*(if m_flows[i] > 0 then rhos[i] else rhos[i+1]) for i in 1:n-1} + dp_nominal/(n-1)/m_flow_nominal*m_flows;
        end if;

        annotation (Documentation(info="<html>
<p>
This model defines a simple lineaer pressure loss assuming laminar flow for
specified <code>dp_nominal</code> and <tt>m_flow_nominal</tt>.
</p>
<p>
Select <code>show_Res = true</code> to analyze the actual flow and the lengths of a pipe that would fulfill the
specified nominal values for given geometry parameters <code>crossAreas</code>, <tt>dimensions</tt> and <tt>roughnesses</tt>.
</p>
</html>"));
      end NominalLaminarFlow;

          partial model PartialGenericPipeFlow
        "GenericPipeFlow: Pipe flow pressure loss and gravity with replaceable WallFriction package"
            extends
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel(
           final Re_turbulent=4000);

            replaceable package WallFriction =
              Modelica.Fluid.Pipes.BaseClasses.WallFriction.Detailed
                constrainedby
          Modelica.Fluid.Pipes.BaseClasses.WallFriction.PartialWallFriction
          "Wall friction model"
                annotation(Dialog(group="Wall friction"), choicesAllMatching=true,__Dymola_editButton=false);

            input SI.Length[n-1] pathLengths_internal
          "pathLengths used internally; to be defined by extending class";

            // Parameters
            parameter SI.AbsolutePressure dp_nominal
          "Nominal pressure loss (for nominal models)";
            parameter SI.MassFlowRate m_flow_nominal
          "Mass flow rate for dp_nominal (for nominal models)";
            parameter Boolean from_dp = momentumDynamics >= Types.Dynamics.SteadyStateInitial
          " = true, use m_flow = f(dp), otherwise dp = f(m_flow)"
              annotation (Evaluate=true);
            parameter SI.AbsolutePressure dp_small = system.dp_small
          "Within regularization if |dp| < dp_small (may be wider for large discontinuities in static head)"
              annotation(Dialog(enable=from_dp and WallFriction.use_dp_small));
            parameter SI.MassFlowRate m_flow_small = system.m_flow_small
          "Within regularization if |m_flows| < m_flow_small (may be wider for large discontinuities in static head)"
              annotation(Dialog(enable=not from_dp and WallFriction.use_m_flow_small));

            final parameter Boolean constantPressureLossCoefficient=
               use_rho_nominal and (use_mu_nominal or not WallFriction.use_mu)
          "= true if the pressure loss does not depend on fluid states"
               annotation(Evaluate=true);
            final parameter Boolean continuousFlowReversal=
               (not useUpstreamScheme)
               or constantPressureLossCoefficient
               or not allowFlowReversal
          "= true if the pressure loss is continuous around zero flow"
               annotation(Evaluate=true);

            SI.Length[n-1] diameters = 0.5*(dimensions[1:n-1] + dimensions[2:n])
          "mean diameters between segments";

          equation
            for i in 1:n-1 loop
              assert(m_flows[i] > -m_flow_small or allowFlowReversal, "Reverting flow occurs even though allowFlowReversal is false");
            end for;

            if continuousFlowReversal then
              // simple regularization
              if from_dp and not WallFriction.dp_is_zero then
                m_flows = WallFriction.massFlowRate_dp(
                  dps_fg - {g*dheights[i]*rhos_act[i] for i in 1:n-1},
                  rhos_act,
                  rhos_act,
                  mus_act,
                  mus_act,
                  pathLengths_internal,
                  diameters,
                  (roughnesses[1:n-1]+roughnesses[2:n])/2,
                  dp_small)*nParallel;
              else
                dps_fg = WallFriction.pressureLoss_m_flow(
                  m_flows/nParallel,
                  rhos_act,
                  rhos_act,
                  mus_act,
                  mus_act,
                  pathLengths_internal,
                  diameters,
                  (roughnesses[1:n-1]+roughnesses[2:n])/2,
                  m_flow_small/nParallel) + {g*dheights[i]*rhos_act[i] for i in 1:n-1};
              end if;
            else
              // regularization for discontinuous flow reversal and static head
              if from_dp and not WallFriction.dp_is_zero then
                m_flows = WallFriction.massFlowRate_dp_staticHead(
                  dps_fg,
                  rhos[1:n-1],
                  rhos[2:n],
                  mus[1:n-1],
                  mus[2:n],
                  pathLengths_internal,
                  diameters,
                  g*dheights,
                  (roughnesses[1:n-1]+roughnesses[2:n])/2,
                  dp_small/n)*nParallel;
              else
                dps_fg = WallFriction.pressureLoss_m_flow_staticHead(
                  m_flows/nParallel,
                  rhos[1:n-1],
                  rhos[2:n],
                  mus[1:n-1],
                  mus[2:n],
                  pathLengths_internal,
                  diameters,
                  g*dheights,
                  (roughnesses[1:n-1]+roughnesses[2:n])/2,
                  m_flow_small/nParallel);
              end if;
            end if;

              annotation (Documentation(info="<html>
<p>
This model describes pressure losses due to <b>wall friction</b> in a pipe
and due to <b>gravity</b>.
Correlations of different complexity and validity can be
seleted via the replaceable package <b>WallFriction</b> (see parameter menu below).
The details of the pipe wall friction model are described in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a>.
Basically, different variants of the equation
</p>

<pre>
   dp = &lambda;(Re,<font face=\"Symbol\">D</font>)*(L/D)*&rho;*v*|v|/2.
</pre>

<p>

By default, the correlations are computed with media data at the actual time instant.
In order to reduce non-linear equation systems, the parameters
<b>use_mu_nominal</b> and <b>use_rho_nominal</b> provide the option
to compute the correlations with constant media values
at the desired operating point. This might speed-up the
simulation and/or might give a more robust simulation.
</p>
</html>"),    Diagram(coordinateSystem(
                  preserveAspectRatio=false,
                  extent={{-100,-100},{100,100}},
                  grid={1,1}), graphics={
              Rectangle(
                extent={{-100,64},{100,-64}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Backward),
              Rectangle(
                extent={{-100,50},{100,-49}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-60,-49},{-60,50}},
                color={0,0,255},
                arrow={Arrow.Filled,Arrow.Filled}),
              Text(
                extent={{-50,16},{6,-10}},
                lineColor={0,0,255},
                textString="diameters"),
              Line(
                points={{-100,74},{100,74}},
                color={0,0,255},
                arrow={Arrow.Filled,Arrow.Filled}),
              Text(
                extent={{-32,93},{32,74}},
                lineColor={0,0,255},
                textString="pathLengths")}));
          end PartialGenericPipeFlow;

          model NominalTurbulentPipeFlow
        "NominalTurbulentPipeFlow: Quadratic turbulent pressure loss for nominal values"
            extends
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialGenericPipeFlow(
          redeclare package WallFriction =
              Modelica.Fluid.Pipes.BaseClasses.WallFriction.QuadraticTurbulent,
          use_mu_nominal=not show_Res,
          pathLengths_internal=pathLengths_nominal,
          useUpstreamScheme=false);

        import Modelica.Constants.pi;

            // variables for nominal pressure loss
            SI.Length[n-1] pathLengths_nominal
          "pathLengths resulting from nominal pressure loss and geometry";
            Real[n-1] ks_inv "coefficient for quadratic flow";
            Real[n-1] zetas "coefficient for quadratic flow";

            // Reynolds Number
            Medium.AbsolutePressure[n-1] dps_fg_turbulent=
                {(mus_act[i]*diameters[i]*pi/4)^2*Re_turbulent^2/(ks_inv[i]*rhos_act[i]) for i in 1:n-1} if
                   show_Res "Start of turbulent flow";

          equation
            // Inverse parameterization for WallFriction.QuadraticTurbulent
            // Note: the code should be shared with the WallFriction.QuadraticTurbulent model,
            //       but this required a re-design of the WallFriction interfaces ...
            //   zeta = (length_nominal/diameter)/(2*Math.log10(3.7 /(roughness/diameter)))^2;
            //   k_inv = (pi*diameter*diameter)^2/(8*zeta);
            //   k = rho*k_inv "Factor in m_flow = sqrt(k*dp)";
            for i in 1:n-1 loop
              ks_inv[i] = (m_flow_nominal/nParallel)^2/((dp_nominal/(n-1)-g*dheights[i]*rhos_act[i]))/rhos_act[i];
              zetas[i] = (pi*diameters[i]*diameters[i])^2/(8*ks_inv[i]);
              pathLengths_nominal[i] =
                zetas[i]*diameters[i]*(2*Modelica.Math.log10(3.7 /((roughnesses[i]+roughnesses[i+1])/2/diameters[i])))^2;
            end for;

            annotation (Documentation(info="<html>
<p>
This model defines the pressure loss assuming turbulent flow for
specified <code>dp_nominal</code> and <tt>m_flow_nominal</tt>.
It takes into account the fluid density of each flow segment and
obtaines appropriate <code>pathLengths_nominal</code> values
for an inverse parameterization of the
<a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow\">
          TurbulentPipeFlow</a>
model. Per default the upstream and downstream densities are averaged with the setting <code>useUpstreamScheme = false</code>,
in order to avoid discontinuous <code>pathLengths_nominal</code> values in the case of flow reversal.
</p>
<p>
The geometry parameters <code>crossAreas</code>, <tt>diameters</tt> and <tt>roughnesses</tt> do
not effect simulation results of this nominal pressure loss model.
As the geometry is specified however, the optionally calculated Reynolds number as well as
<code>m_flows_turbulent</code> and <tt>dps_fg_turbulent</tt> become meaningful
and can be related to <code>m_flow_small</code> and <tt>dp_small</tt>.
</p>
<p>
<b>Optional Variables if show_Res</b>
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Type</b></th><th><b>Name</b></th><th><b>Description</b></th></tr>
<tr><td>ReynoldsNumber</td><td>Res[n]</td>
    <td>Reynolds numbers of pipe flow per flow segment</td></tr>
<tr><td>MassFlowRate</td><td>m_flows_turbulent[n-1]</td>
    <td>mass flow rates at start of turbulent region for Re_turbulent=4000</td></tr>
<tr><td>AbsolutePressure</td><td>dps_fg_turbulent[n-1]</td>
    <td>pressure losses due to friction and gravity corresponding to m_flows_turbulent</td></tr>
</table>
</html>", revisions="<html>
<ul>
<li><i>6 Dec 2008</i>
    by Ruediger Franke</a>:<br>
       Model added to the Fluid library</li>
</ul>
</html>"));
          end NominalTurbulentPipeFlow;

          model TurbulentPipeFlow
        "TurbulentPipeFlow: Pipe wall friction in the quadratic turbulent regime (simple characteristic, mu not used)"
           extends
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialGenericPipeFlow(
          redeclare package WallFriction =
              Modelica.Fluid.Pipes.BaseClasses.WallFriction.QuadraticTurbulent,
          use_mu_nominal=not show_Res,
          pathLengths_internal=pathLengths,
          dp_nominal=1e3*dp_small,
          m_flow_nominal=1e2*m_flow_small);

            annotation (Documentation(info="<html>
<p>
This model defines only the quadratic turbulent regime of wall friction:
dp = k*m_flow*|m_flow|, where \"k\" depends on density and the roughness
of the pipe and is not a function of the Reynolds number.
This relationship is only valid for large Reynolds numbers.
The turbulent pressure loss correlation might be useful to optimize models that are only facing turbular flow.
</p>

</html>"));
          end TurbulentPipeFlow;

          model DetailedPipeFlow
        "DetailedPipeFlow: Pipe wall friction in the laminar and turbulent regime (detailed characteristic)"
           extends
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialGenericPipeFlow(
          redeclare package WallFriction =
              Modelica.Fluid.Pipes.BaseClasses.WallFriction.Detailed,
          pathLengths_internal=pathLengths,
          dp_nominal=1e3*dp_small,
          m_flow_nominal=1e2*m_flow_small);

              annotation (Documentation(info="<html>
<p>
This component defines the complete regime of wall friction.
The details are described in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a>.
The functional relationship of the friction loss factor &lambda; is
displayed in the next figure. Function massFlowRate_dp() defines the \"red curve\"
(\"Swamee and Jain\"), where as function pressureLoss_m_flow() defines the
\"blue curve\" (\"Colebrook-White\"). The two functions are inverses from
each other and give slightly different results in the transition region
between Re = 1500 .. 4000, in order to get explicit equations without
solving a non-linear equation.
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/PipeFriction1.png\">

<p>
Additionally to wall friction, this component properly implements static
head. With respect to the latter, two cases can be distinguished. In the case
shown next, the change of elevation with the path from a to b has the opposite
sign of the change of density.</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/PipeFrictionStaticHead_case-a.PNG\">

<p>
In the case illustrated second, the change of elevation with the path from a to
b has the same sign of the change of density.</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/PipeFrictionStaticHead_case-b.PNG\">

</html>"),    Diagram(coordinateSystem(
                  preserveAspectRatio=false,
                  extent={{-100,-100},{100,100}},
                  grid={1,1}), graphics={
              Rectangle(
                extent={{-100,64},{100,-64}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Backward),
              Rectangle(
                extent={{-100,50},{100,-49}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-60,-49},{-60,50}},
                color={0,0,255},
                arrow={Arrow.Filled,Arrow.Filled}),
              Text(
                extent={{-50,16},{6,-10}},
                lineColor={0,0,255},
                textString="diameters"),
              Line(
                points={{-100,74},{100,74}},
                color={0,0,255},
                arrow={Arrow.Filled,Arrow.Filled})}));
          end DetailedPipeFlow;

    end FlowModels;

  package HeatTransfer "Heat transfer for flow models"
    extends Modelica.Icons.Package;
    partial model PartialFlowHeatTransfer
        "base class for any pipe heat transfer correlation"
      extends Modelica.Fluid.Interfaces.PartialHeatTransfer;

      // Additional inputs provided to flow heat transfer model
      input SI.Velocity[n] vs "Mean velocities of fluid flow in segments";

      // Geometry parameters and inputs for flow heat transfer
      parameter Real nParallel "number of identical parallel flow devices"
         annotation(Dialog(tab="Internal Interface",enable=false,group="Geometry"));
      input SI.Length[n] lengths "Lengths along flow path";
      input SI.Length[n] dimensions
          "Characteristic dimensions for fluid flow (diameter for pipe flow)";
      input SI.Height[n] roughnesses "Average heights of surface asperities";

      annotation (Documentation(info="<html>
Base class for heat transfer models of flow devices.
<p>
The geometry is specified in the interface with the <code>surfaceAreas[n]</code>, the <tt>roughnesses[n]</tt>
and the lengths[n] along the flow path.
Moreover the fluid flow is characterized for different types of devices by the characteristic <code>dimensions[n+1]</code>
and the average velocities <code>vs[n+1]</code> of fluid flow.
See <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber\">Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber</a>
for examplary definitions.
</p>
</html>"),Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                  {100,100}}), graphics={Rectangle(
                extent={{-80,60},{80,-60}},
                pattern=LinePattern.None,
                lineColor={0,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.HorizontalCylinder), Text(
                extent={{-40,22},{38,-18}},
                lineColor={0,0,0},
                textString="%name")}));
    end PartialFlowHeatTransfer;

    model IdealFlowHeatTransfer
        "IdealHeatTransfer: Ideal heat transfer without thermal resistance"
      extends PartialFlowHeatTransfer;
    equation
      Ts = heatPorts.T;
      annotation(Documentation(info="<html>
Ideal heat transfer without thermal resistance.
</html>"));
    end IdealFlowHeatTransfer;

    model ConstantFlowHeatTransfer
        "ConstantHeatTransfer: Constant heat transfer coefficient"
      extends PartialFlowHeatTransfer;
      parameter SI.CoefficientOfHeatTransfer alpha0 "heat transfer coefficient";
    equation
      Q_flows = {alpha0*surfaceAreas[i]*(heatPorts[i].T - Ts[i])*nParallel for i in 1:n};
      annotation(Documentation(info="<html>
Simple heat transfer correlation with constant heat transfer coefficient, used as default component in <a distributed pipe models.
</html>"));
    end ConstantFlowHeatTransfer;

    partial model PartialPipeFlowHeatTransfer
        "Base class for pipe heat transfer correlation in terms of Nusselt number heat transfer in a circular pipe for laminar and turbulent one-phase flow"
      extends PartialFlowHeatTransfer;
      parameter SI.CoefficientOfHeatTransfer alpha0=100
          "guess value for heat transfer coefficients";
      SI.CoefficientOfHeatTransfer[n] alphas(each start=alpha0)
          "CoefficientOfHeatTransfer";
      Real[n] Res "Reynolds numbers";
      Real[n] Prs "Prandtl numbers";
      Real[n] Nus "Nusselt numbers";
      Medium.Density[n] ds "Densities";
      Medium.DynamicViscosity[n] mus "Dynamic viscosities";
      Medium.ThermalConductivity[n] lambdas "Thermal conductivity";
      SI.Length[n] diameters = dimensions "Hydraulic diameters for pipe flow";
    equation
      ds=Medium.density(states);
      mus=Medium.dynamicViscosity(states);
      lambdas=Medium.thermalConductivity(states);
      Prs = Medium.prandtlNumber(states);
      Res = CharacteristicNumbers.ReynoldsNumber(vs, ds, mus, diameters);
      Nus = CharacteristicNumbers.NusseltNumber(alphas, diameters, lambdas);
      Q_flows={alphas[i]*surfaceAreas[i]*(heatPorts[i].T - Ts[i])*nParallel for i in 1:n};
        annotation (Documentation(info="<html>
Base class for heat transfer models that are expressed in terms of the Nusselt number and which can be used in distributed pipe models.
</html>"));
    end PartialPipeFlowHeatTransfer;

    model LocalPipeFlowHeatTransfer
        "LocalPipeFlowHeatTransfer: Laminar and turbulent forced convection in pipes, local coefficients"
      extends PartialPipeFlowHeatTransfer;
      protected
      Real[n] Nus_turb "Nusselt number for turbulent flow";
      Real[n] Nus_lam "Nusselt number for laminar flow";
      Real Nu_1;
      Real[n] Nus_2;
      Real[n] Xis;
    equation
      Nu_1=3.66;
      for i in 1:n loop
       Nus_turb[i]=smooth(0,(Xis[i]/8)*abs(Res[i])*Prs[i]/(1+12.7*(Xis[i]/8)^0.5*(Prs[i]^(2/3)-1))*(1+1/3*(diameters[i]/lengths[i]/(if vs[i]>=0 then (i-0.5) else (n-i+0.5)))^(2/3)));
       Xis[i]=(1.8*Modelica.Math.log10(max(1e-10,Res[i]))-1.5)^(-2);
       Nus_lam[i]=(Nu_1^3+0.7^3+(Nus_2[i]-0.7)^3)^(1/3);
       Nus_2[i]=smooth(0,1.077*(abs(Res[i])*Prs[i]*diameters[i]/lengths[i]/(if vs[i]>=0 then (i-0.5) else (n-i+0.5)))^(1/3));
       Nus[i]=spliceFunction(Nus_turb[i], Nus_lam[i], Res[i]-6150, 3850);
      end for;
      annotation (Documentation(info="<html>
Heat transfer model for laminar and turbulent flow in pipes. Range of validity:
<ul>
<li>fully developed pipe flow</li>
<li>forced convection</li>
<li>one phase Newtonian fluid</li>
<li>(spatial) constant wall temperature in the laminar region</li>
<li>0 &le; Re &le; 1e6, 0.6 &le; Pr &le; 100, d/L &le; 1</li>
<li>The correlation holds for non-circular pipes only in the turbulent region. Use diameter=4*crossArea/perimeter as characteristic length.</li>
</ul>
The correlation takes into account the spatial position along the pipe flow, which changes discontinuously at flow reversal. However, the heat transfer coefficient itself is continuous around zero flow rate, but not its derivative.
<h4><font color=\"#008000\">References</font></h4>

<dl><dt>Verein Deutscher Ingenieure (1997):</dt>
    <dd><b>VDI W&auml;rmeatlas</b>.
         Springer Verlag, Ed. 8, 1997.</dd>
</dl>
</html>"));
    end LocalPipeFlowHeatTransfer;
    annotation (Documentation(info="<html>
Heat transfer correlations for pipe models
</html>"));
  end HeatTransfer;

    package CharacteristicNumbers "Functions to compute characteristic numbers"
      extends Modelica.Icons.Package;
      function ReynoldsNumber "Return Reynolds number from v, rho, mu, D"
        input SI.Velocity v "Mean velocity of fluid flow";
        input SI.Density rho "Fluid density";
        input SI.DynamicViscosity mu "Dynamic (absolute) viscosity";
        input SI.Length D
          "Characteristic dimension (hydraulic diameter of pipes)";
        output SI.ReynoldsNumber Re "Reynolds number";
      algorithm
        Re := abs(v)*rho*D/mu;
        annotation (Documentation(info="<html>
<p>
Calculation of Reynolds Number
<pre>
   Re = |v|&rho;D/&mu;
</pre>
a measure of the relationship between inertial forces (v&rho;) and viscous forces (D/&mu;).
</p>
<p>
The following table gives examples for the characteristic dimension D and the velocity v for different fluid flow devices:
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Device Type</b></th><th><b>Characteristic Dimension D</b></th><th><b>Velocity v</b></th></tr>
<tr><td>Circular Pipe</td><td>diameter</td>
    <td>m_flow/&rho;/crossArea</td></tr>
<tr><td>Rectangular Duct</td><td>4*crossArea/perimeter</td>
    <td>m_flow/&rho;/crossArea</td></tr>
<tr><td>Wide Duct</td><td>distance between narrow, parallel walls</td>
    <td>m_flow/&rho;/crossArea</td></tr>
<tr><td>Packed Bed</td><td>diameterOfSpericalParticles/(1-fluidFractionOfTotalVolume)</td>
    <td>m_flow/&rho;/crossArea (without particles)</td></tr>
<tr><td>Device with rotating agitator</td><td>diameterOfRotor</td>
    <td>RotationalSpeed*diameterOfRotor</td></tr>
</table>
</html>"));
      end ReynoldsNumber;

      function ReynoldsNumber_m_flow
        "Return Reynolds number from m_flow, mu, D, A"
        input SI.MassFlowRate m_flow "Mass flow rate";
        input SI.DynamicViscosity mu "Dynamic viscosity";
        input SI.Length D
          "Characteristic dimension (hydraulic diameter of pipes or orifices)";
        input SI.Area A = Modelica.Constants.pi/4*D*D
          "Cross sectional area of fluid flow";
        output SI.ReynoldsNumber Re "Reynolds number";
      algorithm
        Re := abs(m_flow)*D/A/mu;
        annotation (Documentation(info="<html>Simplified calculation of Reynolds Number for flow through pipes or orifices;
              using the mass flow rate <code>m_flow</code> instead of the velocity <tt>v</tt> to express inertial forces.
<pre>
  Re = |m_flow|*diameter/A/&mu;
with
  m_flow = v*&rho;*A
</pre>
See also <a href=\"modelica://Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber\">
          Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber</a>.
</html>"));
      end ReynoldsNumber_m_flow;

      function NusseltNumber "Return Nusselt number"
        input SI.CoefficientOfHeatTransfer alpha "Coefficient of heat transfer";
        input SI.Length D "Characteristic dimension";
        input SI.ThermalConductivity lambda "Thermal conductivity";
        output SI.NusseltNumber Nu "Nusselt number";
      algorithm
        Nu := alpha*D/lambda;
        annotation (Documentation(info="Nusselt number Nu = alpha*D/lambda"));
      end NusseltNumber;
    end CharacteristicNumbers;

    package WallFriction
      "Different variants for pressure drops due to pipe wall friction"
      extends Modelica.Icons.Package;
      partial package PartialWallFriction
        "Partial wall friction characteristic (base package of all wall friction characteristics)"
        extends Modelica.Icons.Package;

      // Constants to be set in subpackages
        constant Boolean use_mu = true
          "= true, if mu_a/mu_b are used in function, otherwise value is not used";
        constant Boolean use_roughness = true
          "= true, if roughness is used in function, otherwise value is not used";
        constant Boolean use_dp_small = true
          "= true, if dp_small is used in function, otherwise value is not used";
        constant Boolean use_m_flow_small = true
          "= true, if m_flow_small is used in function, otherwise value is not used";
        constant Boolean dp_is_zero = false
          "= true, if no wall friction is present, i.e., dp = 0 (function massFlowRate_dp() cannot be used)";

      // pressure loss characteristic functions
        replaceable partial function massFlowRate_dp
          "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction"
          extends Modelica.Icons.Function;

          input SI.Pressure dp "Pressure loss (dp = port_a.p - port_b.p)";
          input SI.Density rho_a "Density at port_a";
          input SI.Density rho_b "Density at port_b";
          input SI.DynamicViscosity mu_a
            "Dynamic viscosity at port_a (dummy if use_mu = false)";
          input SI.DynamicViscosity mu_b
            "Dynamic viscosity at port_b (dummy if use_mu = false)";
          input SI.Length length "Length of pipe";
          input SI.Diameter diameter "Inner (hydraulic) diameter of pipe";
          input SI.Length roughness(min=0) = 2.5e-5
            "Absolute roughness of pipe, with a default for a smooth steel pipe (dummy if use_roughness = false)";
          input SI.AbsolutePressure dp_small = 1
            "Turbulent flow if |dp| >= dp_small (dummy if use_dp_small = false)";

          output SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";
        annotation (Documentation(info="<html>

</html>"));
        end massFlowRate_dp;

        replaceable partial function massFlowRate_dp_staticHead
          "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction and static head"
          extends Modelica.Icons.Function;

          input SI.Pressure dp "Pressure loss (dp = port_a.p - port_b.p)";
          input SI.Density rho_a "Density at port_a";
          input SI.Density rho_b "Density at port_b";
          input SI.DynamicViscosity mu_a
            "Dynamic viscosity at port_a (dummy if use_mu = false)";
          input SI.DynamicViscosity mu_b
            "Dynamic viscosity at port_b (dummy if use_mu = false)";
          input SI.Length length "Length of pipe";
          input SI.Diameter diameter "Inner (hydraulic) diameter of pipe";
          input Real g_times_height_ab
            "Gravity times (Height(port_b) - Height(port_a))";
          input SI.Length roughness(min=0) = 2.5e-5
            "Absolute roughness of pipe, with a default for a smooth steel pipe (dummy if use_roughness = false)";
          input SI.AbsolutePressure dp_small=1
            "Turbulent flow if |dp| >= dp_small (dummy if use_dp_small = false)";

          output SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";
          annotation (Documentation(info="<html>

</html>"));
        end massFlowRate_dp_staticHead;

        replaceable partial function pressureLoss_m_flow
          "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction"
          extends Modelica.Icons.Function;

          input SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";
          input SI.Density rho_a "Density at port_a";
          input SI.Density rho_b "Density at port_b";
          input SI.DynamicViscosity mu_a
            "Dynamic viscosity at port_a (dummy if use_mu = false)";
          input SI.DynamicViscosity mu_b
            "Dynamic viscosity at port_b (dummy if use_mu = false)";
          input SI.Length length "Length of pipe";
          input SI.Diameter diameter "Inner (hydraulic) diameter of pipe";
          input SI.Length roughness(min=0) = 2.5e-5
            "Absolute roughness of pipe, with a default for a smooth steel pipe (dummy if use_roughness = false)";
          input SI.MassFlowRate m_flow_small = 0.01
            "Turbulent flow if |m_flow| >= m_flow_small (dummy if use_m_flow_small = false)";
          output SI.Pressure dp "Pressure loss (dp = port_a.p - port_b.p)";

        annotation (Documentation(info="<html>

</html>"));
        end pressureLoss_m_flow;

        replaceable partial function pressureLoss_m_flow_staticHead
          "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction and static head"
                  extends Modelica.Icons.Function;

          input SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";
          input SI.Density rho_a "Density at port_a";
          input SI.Density rho_b "Density at port_b";
          input SI.DynamicViscosity mu_a
            "Dynamic viscosity at port_a (dummy if use_mu = false)";
          input SI.DynamicViscosity mu_b
            "Dynamic viscosity at port_b (dummy if use_mu = false)";
          input SI.Length length "Length of pipe";
          input SI.Diameter diameter "Inner (hydraulic) diameter of pipe";
          input Real g_times_height_ab
            "Gravity times (Height(port_b) - Height(port_a))";
          input SI.Length roughness(min=0) = 2.5e-5
            "Absolute roughness of pipe, with a default for a smooth steel pipe (dummy if use_roughness = false)";
          input SI.MassFlowRate m_flow_small = 0.01
            "Turbulent flow if |m_flow| >= m_flow_small (dummy if use_m_flow_small = false)";
          output SI.Pressure dp "Pressure loss (dp = port_a.p - port_b.p)";

        annotation (Documentation(info="<html>

</html>"));
        end pressureLoss_m_flow_staticHead;
        annotation (Documentation(info="<html>

</html>"));
      end PartialWallFriction;

      package NoFriction "No pipe wall friction, no static head"
        extends Modelica.Icons.Package;

        extends PartialWallFriction(
                  final use_mu = false,
                  final use_roughness = false,
                  final use_dp_small = false,
                  final use_m_flow_small = false,
                  final dp_is_zero = true);

        redeclare function extends massFlowRate_dp
          "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction"

        algorithm
          assert(false, "function massFlowRate_dp (option: from_dp=true)
cannot be used for WallFriction.NoFriction. Use instead
function pressureLoss_m_flow (option: from_dp=false)");
          annotation (Documentation(info="<html>

</html>"));
        end massFlowRate_dp;

        redeclare function extends pressureLoss_m_flow
          "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction"

        algorithm
          dp := 0;
          annotation (Documentation(info="<html>

</html>"));
        end pressureLoss_m_flow;

        redeclare function extends massFlowRate_dp_staticHead
          "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction and static head"

        algorithm
          assert(false, "function massFlowRate_dp (option: from_dp=true)
cannot be used for WallFriction.NoFriction. Use instead
function pressureLoss_m_flow (option: from_dp=false)");
          annotation (Documentation(info="<html>

</html>"));
        end massFlowRate_dp_staticHead;

        redeclare function extends pressureLoss_m_flow_staticHead
          "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction and static head"

        /* To include only static head:
protected
  Real dp_grav_a = g_times_height_ab*rho_a
    "Static head if mass flows in design direction (a to b)";
  Real dp_grav_b = g_times_height_ab*rho_b
    "Static head if mass flows against design direction (b to a)";
*/
        algorithm
        //  dp := Utilities.regStep(m_flow, dp_grav_a, dp_grav_a, m_flow_small);
          dp := 0;
          assert(abs(g_times_height_ab) < Modelica.Constants.small,
           "WallFriction.NoFriction does not consider static head and cannot be used with height_ab<>0!");
          annotation (Documentation(info="<html>

</html>"));
        end pressureLoss_m_flow_staticHead;
        annotation (Documentation(info="<html>
<p>
This component sets the pressure loss due to wall friction
to zero, i.e., it allows to switch off pipe wall friction.
</p>
</html>"));
      end NoFriction;

      package Laminar
        "Pipe wall friction in the laminar regime (linear correlation)"

        extends PartialWallFriction(
                  final use_mu = true,
                  final use_roughness = false,
                  final use_dp_small = false,
                  final use_m_flow_small = false);

        redeclare function extends massFlowRate_dp
          "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction"

        algorithm
          m_flow :=dp*Modelica.Constants.pi*diameter^4*(rho_a + rho_b)/(128*length*(mu_a + mu_b));
          annotation (Documentation(info="<html>

</html>"));
        end massFlowRate_dp;

        redeclare function extends pressureLoss_m_flow
          "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction"

        algorithm
          dp := m_flow*128*length*(mu_a + mu_b)/(Modelica.Constants.pi*diameter^4*(rho_a + rho_b));
          annotation (Documentation(info="<html>

</html>"));
        end pressureLoss_m_flow;

        redeclare function extends massFlowRate_dp_staticHead
          "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction and static head"

        protected
          Real k0inv = Modelica.Constants.pi*diameter^4/(128*length)
            "Constant factor";

          Real dp_grav_a = g_times_height_ab*rho_a
            "Static head if mass flows in design direction (a to b)";
          Real dp_grav_b = g_times_height_ab*rho_b
            "Static head if mass flows against design direction (b to a)";

          Real dm_flow_ddp_fric_a = k0inv*rho_a/mu_a
            "Slope of mass flow rate over dp if flow in design direction (a to b)";
          Real dm_flow_ddp_fric_b = k0inv*rho_b/mu_b
            "Slope of mass flow rate over dp if flow against design direction (b to a)";

          Real dp_a=max(dp_grav_a,dp_grav_b)+dp_small
            "Upper end of regularization domain of the m_flow(dp) relation";
          Real dp_b=min(dp_grav_a,dp_grav_b)-dp_small
            "Lower end of regularization domain of the m_flow(dp) relation";

          SI.MassFlowRate m_flow_a
            "Value at upper end of regularization domain";
          SI.MassFlowRate m_flow_b
            "Value at lower end of regularization domain";

          // Properly define zero mass flow conditions
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b)/2;
          Real dm_flow_ddp_fric_zero;
        algorithm
        /*
  dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
     = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
     = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
     = 2*c0/(pi*D_Re^3) * mu/d * m_flow
     = k0 * mu/d * m_flow
  k0 = 2*c0/(pi*D_Re^3)
*/

          if dp>=dp_a then
            // Positive flow outside regularization
            m_flow := dm_flow_ddp_fric_a*(dp-dp_grav_a);
          elseif dp<=dp_b then
            // Negative flow outside regularization
            m_flow := dm_flow_ddp_fric_b*(dp-dp_grav_b);
          else
            m_flow_a := dm_flow_ddp_fric_a*(dp_a - dp_grav_a);
            m_flow_b := dm_flow_ddp_fric_b*(dp_b - dp_grav_b);

            // Include a properly defined zero mass flow point
            // Obtain a suitable slope from the linear section slope c (value of m_flow is overwritten later)
            (m_flow, dm_flow_ddp_fric_zero) := Utilities.regFun3(dp_zero, dp_b, dp_a, m_flow_b, m_flow_a, dm_flow_ddp_fric_b, dm_flow_ddp_fric_a);
            // Do regularization
            if dp>dp_zero then
              m_flow := Utilities.regFun3(dp, dp_zero, dp_a, m_flow_zero, m_flow_a, dm_flow_ddp_fric_zero, dm_flow_ddp_fric_a);
            else
              m_flow := Utilities.regFun3(dp, dp_b, dp_zero, m_flow_b, m_flow_zero, dm_flow_ddp_fric_b, dm_flow_ddp_fric_zero);
            end if;
          end if;
        /*
  m_flow := if dp<dp_b then dm_flow_ddp_b*(dp-dp_grav_b) else
              (if dp>dp_a then dm_flow_ddp_a*(dp-dp_grav_a) else
                Modelica.Fluid.Utilities.regFun3(dp, dp_b, dp_a, dm_flow_ddp_b*(dp_b - dp_grav_b), dm_flow_ddp_a*(dp_a - dp_grav_a), dm_flow_ddp_b, dm_flow_ddp_a));
*/
          annotation (Documentation(info="<html>

</html>"));
        end massFlowRate_dp_staticHead;

        redeclare function extends pressureLoss_m_flow_staticHead
          "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction and static head"

        protected
          Real k0 = 128*length/(Modelica.Constants.pi*diameter^4)
            "Constant factor";

          Real dp_grav_a = g_times_height_ab*rho_a
            "Static head if mass flows in design direction (a to b)";
          Real dp_grav_b = g_times_height_ab*rho_b
            "Static head if mass flows against design direction (b to a)";

          Real ddp_dm_flow_a = k0*mu_a/rho_a
            "Slope of dp over mass flow rate if flow in design direction (a to b)";
          Real ddp_dm_flow_b = k0*mu_b/rho_b
            "Slope of dp over mass flow rate if flow against design direction (b to a)";

          Real m_flow_a=if dp_grav_a >= dp_grav_b then m_flow_small else m_flow_small + (dp_grav_b-dp_grav_a)/ddp_dm_flow_a
            "Upper end of regularization domain of the dp(m_flow) relation";
          Real m_flow_b=if dp_grav_a >= dp_grav_b then -m_flow_small else -m_flow_small - (dp_grav_b - dp_grav_a)/ddp_dm_flow_b
            "Lower end of regularization domain of the dp(m_flow) relation";

          SI.Pressure dp_a "Value at upper end of regularization domain";
          SI.Pressure dp_b "Value at lower end of regularization domain";

          // Properly define zero mass flow conditions
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b)/2;
          Real ddp_dm_flow_zero;
        algorithm
        /*
  dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
     = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
     = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
     = 2*c0/(pi*D_Re^3) * mu/d * m_flow
     = k0 * mu/d * m_flow
  k0 = 2*c0/(pi*D_Re^3)
*/

          if m_flow>=m_flow_a then
            // Positive flow outside regularization
            dp := (ddp_dm_flow_a*m_flow + dp_grav_a);
          elseif m_flow<=m_flow_b then
            // Negative flow outside regularization
            dp := (ddp_dm_flow_b*m_flow + dp_grav_b);
          else
            // Regularization parameters
            dp_a := ddp_dm_flow_a*m_flow_a + dp_grav_a;
            dp_b := ddp_dm_flow_b*m_flow_b + dp_grav_b;
            // Include a properly defined zero mass flow point
            // Obtain a suitable slope from the linear section slope c (value of dp is overwritten later)
            (dp, ddp_dm_flow_zero) := Utilities.regFun3(m_flow_zero, m_flow_b, m_flow_a, dp_b, dp_a, ddp_dm_flow_b, ddp_dm_flow_a);
            // Do regularization
            if m_flow>m_flow_zero then
              dp := Utilities.regFun3(m_flow, m_flow_zero, m_flow_a, dp_zero, dp_a, ddp_dm_flow_zero, ddp_dm_flow_a);
            else
              dp := Utilities.regFun3(m_flow, m_flow_b, m_flow_zero, dp_b, dp_zero, ddp_dm_flow_b, ddp_dm_flow_zero);
            end if;
          end if;
          annotation (Documentation(info="<html>

</html>"));
        end pressureLoss_m_flow_staticHead;
        annotation (Documentation(info="<html>
<p>
This component defines only the laminar region of wall friction:
dp = k*m_flow, where \"k\" depends on density and dynamic viscosity.
The roughness of the wall does not have an influence on the laminar
flow and therefore argument roughness is ignored.
Since this is a linear relationship, the occuring systems of equations
are usually much simpler (e.g., either linear instead of non-linear).
By using nominal values for density and dynamic viscosity, the
systems of equations can still further be reduced.
</p>

<p>
In <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a> the complete friction regime is illustrated.
This component describes only the <b>Hagen-Poiseuille</b> equation.
</p>
<br>

</html>"));
      end Laminar;

      package QuadraticTurbulent
        "Pipe wall friction in the quadratic turbulent regime (simple characteristic, mu not used)"

        extends PartialWallFriction(
                  final use_mu = false,
                  final use_roughness = true,
                  final use_dp_small = true,
                  final use_m_flow_small = true);

        redeclare function extends massFlowRate_dp
          "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction"
          import Modelica.Math;
        protected
          constant Real pi = Modelica.Constants.pi;
          Real zeta;
          Real k_inv;
        algorithm
          /*
   dp = 0.5*zeta*d*v*|v|
      = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
      = k/d * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
  */
          assert(roughness > 1.e-10,
                 "roughness > 0 required for quadratic turbulent wall friction characteristic");
          zeta  := (length/diameter)/(2*Math.log10(3.7 /(roughness/diameter)))^2;
          k_inv := (pi*diameter*diameter)^2/(8*zeta);
          m_flow := Modelica.Fluid.Utilities.regRoot2(dp, dp_small, rho_a*k_inv, rho_b*k_inv);
          annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
        end massFlowRate_dp;

        redeclare function extends pressureLoss_m_flow
          "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction"
          import Modelica.Math;

        protected
          constant Real pi = Modelica.Constants.pi;
          Real zeta;
          Real k;
        algorithm
          /*
   dp = 0.5*zeta*d*v*|v|
      = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
      = k/d * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
  */
          assert(roughness > 1.e-10,
                 "roughness > 0 required for quadratic turbulent wall friction characteristic");
          zeta := (length/diameter)/(2*Math.log10(3.7 /(roughness/diameter)))^2;
          k    := 8*zeta/(pi*diameter*diameter)^2;
          dp   := Modelica.Fluid.Utilities.regSquare2(m_flow, m_flow_small, k/rho_a, k/rho_b);
          annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
        end pressureLoss_m_flow;

        redeclare function extends massFlowRate_dp_staticHead
          "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction and static head"
          import Modelica.Math;
        protected
          constant Real pi = Modelica.Constants.pi;
          Real zeta = (length/diameter)/(2*Math.log10(3.7 /(roughness/diameter)))^2;
          Real k_inv = (pi*diameter*diameter)^2/(8*zeta);

          SI.Pressure dp_grav_a = g_times_height_ab*rho_a
            "Static head if mass flows in design direction (a to b)";
          SI.Pressure dp_grav_b = g_times_height_ab*rho_b
            "Static head if mass flows against design direction (b to a)";

          Real k1 = rho_a*k_inv "Factor in m_flow =  sqrt(k1*(dp-dp_grav_a))";
          Real k2 = rho_b*k_inv "Factor in m_flow = -sqrt(k2*|dp-dp_grav_b|)";

          Real dp_a=max(dp_grav_a,dp_grav_b)+dp_small
            "Upper end of regularization domain of the m_flow(dp) relation";
          Real dp_b=min(dp_grav_a,dp_grav_b)-dp_small
            "Lower end of regularization domain of the m_flow(dp) relation";

          SI.MassFlowRate m_flow_a
            "Value at upper end of regularization domain";
          SI.MassFlowRate m_flow_b
            "Value at lower end of regularization domain";

          SI.MassFlowRate dm_flow_ddp_fric_a
            "Derivative at upper end of regularization domain";
          SI.MassFlowRate dm_flow_ddp_fric_b
            "Derivative at lower end of regularization domain";

          // Properly define zero mass flow conditions
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b)/2;
          Real dm_flow_ddp_fric_zero;
        algorithm
          /*
   dp = 0.5*zeta*d*v*|v|
      = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
      = k/d * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
  */
          assert(roughness > 1.e-10,
                 "roughness > 0 required for quadratic turbulent wall friction characteristic");

          if dp>=dp_a then
            // Positive flow outside regularization
            m_flow := sqrt(k1*(dp-dp_grav_a));
          elseif dp<=dp_b then
            // Negative flow outside regularization
            m_flow := -sqrt(k2*abs(dp-dp_grav_b));
          else
            m_flow_a := sqrt(k1*(dp_a - dp_grav_a));
            m_flow_b := -sqrt(k2*abs(dp_b - dp_grav_b));

            dm_flow_ddp_fric_a := k1/(2*sqrt(k1*(dp_a - dp_grav_a)));
            dm_flow_ddp_fric_b := k2/(2*sqrt(k2*abs(dp_b - dp_grav_b)));
        /*  dm_flow_ddp_fric_a := if abs(dp_a - dp_grav_a)>0 then k1/(2*sqrt(k1*(dp_a - dp_grav_a))) else  Modelica.Constants.inf);
    dm_flow_ddp_fric_b := if abs(dp_b - dp_grav_b)>0 then k2/(2*sqrt(k2*abs(dp_b - dp_grav_b))) else Modelica.Constants.inf; */

            // Include a properly defined zero mass flow point
            // Obtain a suitable slope from the linear section slope c (value of m_flow is overwritten later)
            (m_flow, dm_flow_ddp_fric_zero) := Utilities.regFun3(dp_zero, dp_b, dp_a, m_flow_b, m_flow_a, dm_flow_ddp_fric_b, dm_flow_ddp_fric_a);
            // Do regularization
            if dp>dp_zero then
              m_flow := Utilities.regFun3(dp, dp_zero, dp_a, m_flow_zero, m_flow_a, dm_flow_ddp_fric_zero, dm_flow_ddp_fric_a);
            else
              m_flow := Utilities.regFun3(dp, dp_b, dp_zero, m_flow_b, m_flow_zero, dm_flow_ddp_fric_b, dm_flow_ddp_fric_zero);
            end if;
          end if;
          annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
        end massFlowRate_dp_staticHead;

        redeclare function extends pressureLoss_m_flow_staticHead
          "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction and static head"
          import Modelica.Math;
        protected
          constant Real pi = Modelica.Constants.pi;
          Real zeta = (length/diameter)/(2*Math.log10(3.7 /(roughness/diameter)))^2;
          Real k = 8*zeta/(pi*diameter*diameter)^2;

          SI.Pressure dp_grav_a = g_times_height_ab*rho_a
            "Static head if mass flows in design direction (a to b)";
          SI.Pressure dp_grav_b = g_times_height_ab*rho_b
            "Static head if mass flows against design direction (b to a)";

          Real k1 = k/rho_a "If m_flow >= 0 then dp = k1*m_flow^2 + dp_grav_a";
          Real k2 = k/rho_b "If m_flow < 0 then dp = -k2*m_flow^2 + dp_grav_b";

          Real m_flow_a=if dp_grav_a >= dp_grav_b then m_flow_small else m_flow_small + sqrt((dp_grav_b - dp_grav_a)/k1)
            "Upper end of regularization domain of the dp(m_flow) relation";
          Real m_flow_b=if dp_grav_a >= dp_grav_b then -m_flow_small else -m_flow_small - sqrt((dp_grav_b - dp_grav_a)/k2)
            "Lower end of regularization domain of the dp(m_flow) relation";

          SI.Pressure dp_a "Value at upper end of regularization domain";
          SI.Pressure dp_b "Value at lower end of regularization domain";

          Real ddp_dm_flow_a
            "Derivative of pressure drop with mass flow rate at m_flow_a";
          Real ddp_dm_flow_b
            "Derivative of pressure drop with mass flow rate at m_flow_b";

          // Properly define zero mass flow conditions
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b)/2;
          Real ddp_dm_flow_zero;

        algorithm
          /*
   dp = 0.5*zeta*d*v*|v|
      = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
      = k/d * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
  */
          assert(roughness > 1.e-10,
                 "roughness > 0 required for quadratic turbulent wall friction characteristic");

          if m_flow>=m_flow_a then
            // Positive flow outside regularization
            dp := (k1*m_flow^2 + dp_grav_a);
          elseif m_flow<=m_flow_b then
            // Negative flow outside regularization
            dp := (-k2*m_flow^2 + dp_grav_b);
          else
            // Regularization parameters
            dp_a := k1*m_flow_a^2 + dp_grav_a;
            ddp_dm_flow_a := 2*k1*m_flow_a;
            dp_b := -k2*m_flow_b^2 + dp_grav_b;
            ddp_dm_flow_b := -2*k2*m_flow_b;
            // Include a properly defined zero mass flow point
            // Obtain a suitable slope from the linear section slope c (value of dp is overwritten later)
            (dp, ddp_dm_flow_zero) := Utilities.regFun3(m_flow_zero, m_flow_b, m_flow_a, dp_b, dp_a, ddp_dm_flow_b, ddp_dm_flow_a);
            // Do regularization
            if m_flow>m_flow_zero then
              dp := Utilities.regFun3(m_flow, m_flow_zero, m_flow_a, dp_zero, dp_a, ddp_dm_flow_zero, ddp_dm_flow_a);
            else
              dp := Utilities.regFun3(m_flow, m_flow_b, m_flow_zero, dp_b, dp_zero, ddp_dm_flow_b, ddp_dm_flow_zero);
            end if;
          end if;

          annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
        end pressureLoss_m_flow_staticHead;
        annotation (Documentation(info="<html>
<p>
This component defines only the quadratic turbulent regime of wall friction:
dp = k*m_flow*|m_flow|, where \"k\" depends on density and the roughness
of the pipe and is no longer a function of the Reynolds number.
This relationship is only valid for large Reynolds numbers.
</p>

<p>
In <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a> the complete friction regime is illustrated.
This component describes only the asymptotic behaviour for large
Reynolds numbers, i.e., the values at the right ordinate where
&lambda; is constant.
</p>
<br>

</html>"));
      end QuadraticTurbulent;

      package LaminarAndQuadraticTurbulent
        "Pipe wall friction in the laminar and quadratic turbulent regime (simple characteristic)"

        extends PartialWallFriction(
                  final use_mu = true,
                  final use_roughness = true,
                  final use_dp_small = true,
                  final use_m_flow_small = true);

        import ln = Modelica.Math.log "Logarithm, base e";
        import Modelica.Math.log10 "Logarithm, base 10";
        import Modelica.Math.exp "Exponential function";
        import Modelica.Constants.pi;

        redeclare function extends massFlowRate_dp
          "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction"
          import Modelica.Math;
        protected
          constant Real pi=Modelica.Constants.pi;
          constant Real Re_turbulent = 4000 "Start of turbulent regime";
          Real zeta;
          Real k0;
          Real k_inv;
          Real yd0 "Derivative of m_flow=m_flow(dp) at zero";
          SI.AbsolutePressure dp_turbulent;
        algorithm
        /*
Turbulent region:
   Re = m_flow*(4/pi)/(D_Re*mu)
   dp = 0.5*zeta*rho*v*|v|
      = 0.5*zeta*rho*1/(rho*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/rho * m_flow * |m_flow|
      = k/rho * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
   m_flow_turbulent = (pi/4)*D_Re*mu*Re_turbulent
   dp_turbulent     =  k/rho *(D_Re*mu*pi/4)^2 * Re_turbulent^2

   The start of the turbulent region is computed with mean values
   of dynamic viscosity mu and density rho. Otherwise, one has
   to introduce different "delta" values for both flow directions.
   In order to simplify the approach, only one delta is used.

Laminar region:
   dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
      = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
      = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
      = 2*c0/(pi*D_Re^3) * mu/rho * m_flow
      = k0 * mu/rho * m_flow
   k0 = 2*c0/(pi*D_Re^3)

   In order that the derivative of dp=f(m_flow) is continuous
   at m_flow=0, the mean values of mu and d are used in the
   laminar region: mu/rho = (mu_a + mu_b)/(rho_a + rho_b)
   If data.zetaLaminarKnown = false then mu_a and mu_b are potentially zero
   (because dummy values) and therefore the division is only performed
   if zetaLaminarKnown = true.
*/
          assert(roughness > 1.e-10,
                 "roughness > 0 required for quadratic turbulent wall friction characteristic");
          zeta   := (length/diameter)/(2*Math.log10(3.7 /(roughness/diameter)))^2;
          k0     := 128*length/(pi*diameter^4);
          k_inv  := (pi*diameter*diameter)^2/(8*zeta);
          yd0    := (rho_a + rho_b)/(k0*(mu_a + mu_b));
          dp_turbulent := ((mu_a + mu_b)*diameter*pi/8)^2*Re_turbulent^2/(k_inv*(rho_a+rho_b)/2);
          m_flow := Modelica.Fluid.Utilities.regRoot2(dp, dp_turbulent, rho_a*k_inv, rho_b*k_inv,
                                                      use_yd0=true, yd0=yd0);
          annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
        end massFlowRate_dp;

        redeclare function extends pressureLoss_m_flow
          "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction"
          import Modelica.Math;

        protected
          constant Real pi=Modelica.Constants.pi;
          constant Real Re_turbulent = 4000 "Start of turbulent regime";
          Real zeta;
          Real k0;
          Real k;
          Real yd0 "Derivative of dp = f(m_flow) at zero";
          SI.MassFlowRate m_flow_turbulent
            "The turbulent region is: |m_flow| >= m_flow_turbulent";

        algorithm
        /*
Turbulent region:
   Re = m_flow*(4/pi)/(D_Re*mu)
   dp = 0.5*zeta*rho*v*|v|
      = 0.5*zeta*rho*1/(rho*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/rho * m_flow * |m_flow|
      = k/rho * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
   m_flow_turbulent = (pi/4)*D_Re*mu*Re_turbulent
   dp_turbulent     =  k/rho *(D_Re*mu*pi/4)^2 * Re_turbulent^2

   The start of the turbulent region is computed with mean values
   of dynamic viscosity mu and density rho. Otherwise, one has
   to introduce different "delta" values for both flow directions.
   In order to simplify the approach, only one delta is used.

Laminar region:
   dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
      = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
      = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
      = 2*c0/(pi*D_Re^3) * mu/rho * m_flow
      = k0 * mu/rho * m_flow
   k0 = 2*c0/(pi*D_Re^3)

   In order that the derivative of dp=f(m_flow) is continuous
   at m_flow=0, the mean values of mu and d are used in the
   laminar region: mu/rho = (mu_a + mu_b)/(rho_a + rho_b)
*/
          assert(roughness > 1.e-10,
                 "roughness > 0 required for quadratic turbulent wall friction characteristic");
          zeta := (length/diameter)/(2*Math.log10(3.7 /(roughness/diameter)))^2;
          k0   := 128*length/(pi*diameter^4);
          k    := 8*zeta/(pi*diameter*diameter)^2;
          yd0  := k0*(mu_a + mu_b)/(rho_a + rho_b);
          m_flow_turbulent :=(pi/8)*diameter*(mu_a + mu_b)*Re_turbulent;
          dp :=Modelica.Fluid.Utilities.regSquare2(m_flow, m_flow_turbulent, k/rho_a, k/rho_b,
                                                   use_yd0=true, yd0=yd0);
          annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
        end pressureLoss_m_flow;

        redeclare function extends massFlowRate_dp_staticHead
          "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction and static head"
          import Modelica.Math;

        protected
          Real Delta = roughness/diameter "Relative roughness";
          SI.ReynoldsNumber Re1 = 745*exp(if Delta <= 0.0065 then 1 else 0.0065/Delta)
            "Boundary between laminar regime and transition";
          constant SI.ReynoldsNumber Re2 = 4000
            "Boundary between transition and turbulent regime";

          SI.Pressure dp_a
            "Upper end of regularization domain of the m_flow(dp) relation";
          SI.Pressure dp_b
            "Lower end of regularization domain of the m_flow(dp) relation";

          SI.MassFlowRate m_flow_a
            "Value at upper end of regularization domain";
          SI.MassFlowRate m_flow_b
            "Value at lower end of regularization domain";

          SI.MassFlowRate dm_flow_ddp_fric_a
            "Derivative at upper end of regularization domain";
          SI.MassFlowRate dm_flow_ddp_fric_b
            "Derivative at lower end of regularization domain";

          SI.Pressure dp_grav_a = g_times_height_ab*rho_a
            "Static head if mass flows in design direction (a to b)";
          SI.Pressure dp_grav_b = g_times_height_ab*rho_b
            "Static head if mass flows against design direction (b to a)";

          // Properly define zero mass flow conditions
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b)/2;
          Real dm_flow_ddp_fric_zero;
        algorithm
          assert(roughness > 1.e-10,
            "roughness > 0 required for quadratic turbulent wall friction characteristic");

          dp_a := max(dp_grav_a, dp_grav_b)+dp_small;
          dp_b := min(dp_grav_a, dp_grav_b)-dp_small;

          if dp>=dp_a then
            // Positive flow outside regularization
            m_flow := Internal.m_flow_of_dp_fric(dp - dp_grav_a, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta);
          elseif dp<=dp_b then
            // Negative flow outside regularization
            m_flow := Internal.m_flow_of_dp_fric(dp-dp_grav_b, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta);
          else
            // Regularization parameters
            (m_flow_a, dm_flow_ddp_fric_a) := Internal.m_flow_of_dp_fric(dp_a-dp_grav_a, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta);
            (m_flow_b, dm_flow_ddp_fric_b) := Internal.m_flow_of_dp_fric(dp_b-dp_grav_b, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta);
            // Include a properly defined zero mass flow point
            // Obtain a suitable slope from the linear section slope c (value of m_flow is overwritten later)
            (m_flow, dm_flow_ddp_fric_zero) := Utilities.regFun3(dp_zero, dp_b, dp_a, m_flow_b, m_flow_a, dm_flow_ddp_fric_b, dm_flow_ddp_fric_a);
            // Do regularization
            if dp>dp_zero then
              m_flow := Utilities.regFun3(dp, dp_zero, dp_a, m_flow_zero, m_flow_a, dm_flow_ddp_fric_zero, dm_flow_ddp_fric_a);
            else
              m_flow := Utilities.regFun3(dp, dp_b, dp_zero, m_flow_b, m_flow_zero, dm_flow_ddp_fric_b, dm_flow_ddp_fric_zero);
            end if;
          end if;
          annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
        end massFlowRate_dp_staticHead;

        redeclare function extends pressureLoss_m_flow_staticHead
          "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction and static head"
          import Modelica.Math;

        protected
          Real Delta = roughness/diameter "Relative roughness";
          SI.ReynoldsNumber Re1 = 745*exp(if Delta <= 0.0065 then 1 else 0.0065/Delta)
            "Boundary between laminar regime and transition";
          constant SI.ReynoldsNumber Re2 = 4000
            "Boundary between transition and turbulent regime";

          SI.MassFlowRate m_flow_a
            "Upper end of regularization domain of the dp(m_flow) relation";
          SI.MassFlowRate m_flow_b
            "Lower end of regularization domain of the dp(m_flow) relation";

          SI.Pressure dp_a "Value at upper end of regularization domain";
          SI.Pressure dp_b "Value at lower end of regularization domain";

          SI.Pressure dp_grav_a = g_times_height_ab*rho_a
            "Static head if mass flows in design direction (a to b)";
          SI.Pressure dp_grav_b = g_times_height_ab*rho_b
            "Static head if mass flows against design direction (b to a)";

          Real ddp_dm_flow_a
            "Derivative of pressure drop with mass flow rate at m_flow_a";
          Real ddp_dm_flow_b
            "Derivative of pressure drop with mass flow rate at m_flow_b";

          // Properly define zero mass flow conditions
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b)/2;
          Real ddp_dm_flow_zero;

        algorithm
          assert(roughness > 1.e-10,
            "roughness > 0 required for quadratic turbulent wall friction characteristic");

          m_flow_a := if dp_grav_a<dp_grav_b then
            Internal.m_flow_of_dp_fric(dp_grav_b - dp_grav_a, rho_a, rho_b, mu_a, mu_b, length, diameter,  Re1, Re2, Delta)+m_flow_small else
            m_flow_small;
          m_flow_b := if dp_grav_a<dp_grav_b then
            Internal.m_flow_of_dp_fric(dp_grav_a - dp_grav_b, rho_a, rho_b, mu_a, mu_b, length, diameter,  Re1, Re2, Delta)-m_flow_small else
            -m_flow_small;

          if m_flow>=m_flow_a then
            // Positive flow outside regularization
            dp := Internal.dp_fric_of_m_flow(m_flow, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta) + dp_grav_a;
          elseif m_flow<=m_flow_b then
            // Negative flow outside regularization
            dp := Internal.dp_fric_of_m_flow(m_flow, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta) + dp_grav_b;
          else
            // Regularization parameters
            (dp_a, ddp_dm_flow_a) := Internal.dp_fric_of_m_flow(m_flow_a, rho_a, rho_b, mu_a, mu_b, length, diameter,  Re1, Re2, Delta);
            dp_a := dp_a + dp_grav_a "Adding dp_grav to dp_fric to get dp";
            (dp_b, ddp_dm_flow_b) := Internal.dp_fric_of_m_flow(m_flow_b, rho_a, rho_b, mu_a, mu_b, length, diameter,  Re1, Re2, Delta);
            dp_b := dp_b + dp_grav_b "Adding dp_grav to dp_fric to get dp";
            // Include a properly defined zero mass flow point
            // Obtain a suitable slope from the linear section slope c (value of dp is overwritten later)
            (dp, ddp_dm_flow_zero) := Utilities.regFun3(m_flow_zero, m_flow_b, m_flow_a, dp_b, dp_a, ddp_dm_flow_b, ddp_dm_flow_a);
            // Do regularization
            if m_flow>m_flow_zero then
              dp := Utilities.regFun3(m_flow, m_flow_zero, m_flow_a, dp_zero, dp_a, ddp_dm_flow_zero, ddp_dm_flow_a);
            else
              dp := Utilities.regFun3(m_flow, m_flow_b, m_flow_zero, dp_b, dp_zero, ddp_dm_flow_b, ddp_dm_flow_zero);
            end if;
          end if;
          annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
        end pressureLoss_m_flow_staticHead;

        package Internal
          "Functions to calculate mass flow rate from friction pressure drop and vice versa"
          function m_flow_of_dp_fric
            "Calculate mass flow rate as function of pressure drop due to friction"

            input SI.Pressure dp_fric
              "Pressure loss due to friction (dp = port_a.p - port_b.p)";
            input SI.Density rho_a "Density at port_a";
            input SI.Density rho_b "Density at port_b";
            input SI.DynamicViscosity mu_a
              "Dynamic viscosity at port_a (dummy if use_mu = false)";
            input SI.DynamicViscosity mu_b
              "Dynamic viscosity at port_b (dummy if use_mu = false)";
            input SI.Length length "Length of pipe";
            input SI.Diameter diameter "Inner (hydraulic) diameter of pipe";
            input SI.ReynoldsNumber Re1
              "Boundary between laminar regime and transition";
            input SI.ReynoldsNumber Re2
              "Boundary between transition and turbulent regime";
            input Real Delta "Relative roughness";
            output SI.MassFlowRate m_flow
              "Mass flow rate from port_a to port_b";
            output Real dm_flow_ddp_fric
              "Derivative of mass flow rate with dp_fric";
          protected
            SI.DynamicViscosity mu "Upstream viscosity";
            SI.Density rho "Upstream density";

            Real zeta;
            Real k0;
            Real k_inv;
            Real dm_flow_ddp_laminar
              "Derivative of m_flow=m_flow(dp) in laminar regime";
            SI.AbsolutePressure dp_fric_turbulent
              "The turbulent region is: |dp_fric| >= dp_fric_turbulent, simple quadratic correlation";
            SI.AbsolutePressure dp_fric_laminar
              "The laminar region is: |dp_fric| <= dp_fric_laminar";
          algorithm
          /*
Turbulent region:
   Re = m_flow*(4/pi)/(D_Re*mu)
   dp = 0.5*zeta*rho*v*|v|
      = 0.5*zeta*rho*1/(rho*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/rho * m_flow * |m_flow|
      = k/rho * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
   dp_fric_turbulent     =  k/rho *(D_Re*mu*pi/4)^2 * Re_turbulent^2

Laminar region:
   dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
      = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
      = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
      = 2*c0/(pi*D_Re^3) * mu/rho * m_flow
      = k0 * mu/rho * m_flow
   k0 = 2*c0/(pi*D_Re^3)
*/
            // Determine upstream density and upstream viscosity
            if dp_fric >= 0 then
              rho := rho_a;
              mu  := mu_a;
            else
              rho := rho_b;
              mu  := mu_b;
            end if;
            // Quadratic turbulent
            zeta := (length/diameter)/(2*log10(3.7/(Delta)))^2;
            k_inv := (pi*diameter*diameter)^2/(8*zeta);
            dp_fric_turbulent := sign(dp_fric)*(mu*diameter*pi/4)^2*Re2^2/(k_inv*rho);

            // Laminar
            k0 := 128*length/(pi*diameter^4);
            dm_flow_ddp_laminar := rho/(k0*mu);
            dp_fric_laminar := sign(dp_fric)*pi*k0*mu^2/rho*diameter/4*Re1;

            if abs(dp_fric) > abs(dp_fric_turbulent) then
              m_flow := sign(dp_fric)*sqrt(rho*k_inv*abs(dp_fric));
              dm_flow_ddp_fric := 0.5*rho*k_inv*(rho*k_inv*abs(dp_fric))^(-0.5);
            elseif abs(dp_fric) < abs(dp_fric_laminar) then
              m_flow := dm_flow_ddp_laminar*dp_fric;
              dm_flow_ddp_fric := dm_flow_ddp_laminar;
            else
              // Preliminary testing seems to indicate that the log-log transform is not required here
              (m_flow,dm_flow_ddp_fric) := Utilities.cubicHermite_withDerivative(
                dp_fric, dp_fric_laminar, dp_fric_turbulent, dm_flow_ddp_laminar*dp_fric_laminar,
                sign(dp_fric_turbulent)*sqrt(rho*k_inv*abs(dp_fric_turbulent)), dm_flow_ddp_laminar,
                if abs(dp_fric_turbulent)>0 then 0.5*rho*k_inv*(rho*k_inv*abs(dp_fric_turbulent))^(-0.5) else Modelica.Constants.inf);
            end if;
            annotation (smoothOrder=1);
          end m_flow_of_dp_fric;

          function dp_fric_of_m_flow
            "Calculate pressure drop due to friction as function of mass flow rate"

            input SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";
            input SI.Density rho_a "Density at port_a";
            input SI.Density rho_b "Density at port_b";
            input SI.DynamicViscosity mu_a
              "Dynamic viscosity at port_a (dummy if use_mu = false)";
            input SI.DynamicViscosity mu_b
              "Dynamic viscosity at port_b (dummy if use_mu = false)";
            input SI.Length length "Length of pipe";
            input SI.Diameter diameter "Inner (hydraulic) diameter of pipe";
            input SI.ReynoldsNumber Re1
              "Boundary between laminar regime and transition";
            input SI.ReynoldsNumber Re2
              "Boundary between transition and turbulent regime";
            input Real Delta "Relative roughness";
            output SI.Pressure dp_fric
              "Pressure loss due to friction (dp_fric = port_a.p - port_b.p - dp_grav)";
            output Real ddp_fric_dm_flow
              "Derivative of pressure drop with mass flow rate";
          protected
            SI.DynamicViscosity mu "Upstream viscosity";
            SI.Density rho "Upstream density";
            Real zeta;
            Real k0;
            Real k;
            Real ddp_fric_dm_flow_laminar
              "Derivative of dp_fric = f(m_flow) at zero";
            SI.MassFlowRate m_flow_turbulent
              "The turbulent region is: |m_flow| >= m_flow_turbulent";
            SI.MassFlowRate m_flow_laminar
              "The laminar region is: |m_flow| <= m_flow_laminar";
          algorithm
          /*
Turbulent region:
   Re = m_flow*(4/pi)/(D_Re*mu)
   dp = 0.5*zeta*rho*v*|v|
      = 0.5*zeta*rho*1/(rho*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/rho * m_flow * |m_flow|
      = k/rho * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
   m_flow_turbulent = (pi/4)*D_Re*mu*Re_turbulent

Laminar region:
   dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
      = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*mu)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
      = 0.5 * c0*(pi/4)*(D_Re*mu) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
      = 2*c0/(pi*D_Re^3) * mu/rho * m_flow
      = k0 * mu/rho * m_flow
   k0 = 2*c0/(pi*D_Re^3)
*/
            // Determine upstream density and upstream viscosity
            if m_flow >= 0 then
              rho := rho_a;
              mu  := mu_a;
            else
              rho := rho_b;
              mu  := mu_b;
            end if;

            // Turbulent
            zeta := (length/diameter)/(2*log10(3.7/(Delta)))^2;
            k := 8*zeta/(pi*diameter*diameter)^2;
            m_flow_turbulent := sign(m_flow)*(pi/4)*diameter*mu*Re2;

            // Laminar
            k0 := 128*length/(pi*diameter^4);
            ddp_fric_dm_flow_laminar := k0*mu/rho;
            m_flow_laminar := sign(m_flow)*(pi/4)*diameter*mu*Re1;

            if abs(m_flow) > abs(m_flow_turbulent) then
              dp_fric := k/rho*m_flow*abs(m_flow);
              ddp_fric_dm_flow := 2*k/rho*abs(m_flow);
            elseif abs(m_flow) < abs(m_flow_laminar) then
              dp_fric := ddp_fric_dm_flow_laminar*m_flow;
              ddp_fric_dm_flow := ddp_fric_dm_flow_laminar;
            else
              // Preliminary testing seems to indicate that the log-log transform is not required here
              (dp_fric,ddp_fric_dm_flow) := Utilities.cubicHermite_withDerivative(
                m_flow, m_flow_laminar, m_flow_turbulent, ddp_fric_dm_flow_laminar*m_flow_laminar,
                k/rho*m_flow_turbulent*abs(m_flow_turbulent), ddp_fric_dm_flow_laminar, 2*k/rho*abs(m_flow_turbulent));
            end if;
            annotation (smoothOrder=1);
          end dp_fric_of_m_flow;
        end Internal;
        annotation (Documentation(info="<html>
<p>
This component defines the quadratic turbulent regime of wall friction:
dp = k*m_flow*|m_flow|, where \"k\" depends on density and the roughness
of the pipe and is no longer a function of the Reynolds number.
This relationship is only valid for large Reynolds numbers.
At Re=4000, a polynomial is constructed that approaches
the constant &lambda; (for large Reynolds-numbers) at Re=4000
smoothly and has a derivative at zero mass flow rate that is
identical to laminar wall friction.
</p>
</html>"));
      end LaminarAndQuadraticTurbulent;

      package Detailed
        "Pipe wall friction in the whole regime (detailed characteristic)"

        extends PartialWallFriction(
                  final use_mu = true,
                  final use_roughness = true,
                  final use_dp_small = true,
                  final use_m_flow_small = true);

        import ln = Modelica.Math.log "Logarithm, base e";
        import Modelica.Math.log10 "Logarithm, base 10";
        import Modelica.Math.exp "Exponential function";
        import Modelica.Constants.pi;

        redeclare function extends massFlowRate_dp
          "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction"
          import Modelica.Math;
        protected
          constant Real pi = Modelica.Constants.pi;
          Real Delta = roughness/diameter "Relative roughness";
          SI.ReynoldsNumber Re1 = (745*Math.exp(if Delta <= 0.0065 then 1 else 0.0065/Delta))^0.97
            "Re leaving laminar curve";
          SI.ReynoldsNumber Re2 = 4000 "Re entering turbulent curve";
          SI.DynamicViscosity mu "Upstream viscosity";
          SI.Density rho "Upstream density";
          SI.ReynoldsNumber Re "Reynolds number";
          Real lambda2 "Modified friction coefficient (= lambda*Re^2)";

          function interpolateInRegion2
             input Real Re_turbulent;
             input SI.ReynoldsNumber Re1;
             input SI.ReynoldsNumber Re2;
             input Real Delta;
             input Real lambda2;
             output SI.ReynoldsNumber Re;
            // point lg(lambda2(Re1)) with derivative at lg(Re1)
          protected
            Real x1=Math.log10(64*Re1);
            Real y1=Math.log10(Re1);
            Real yd1=1;

            // Point lg(lambda2(Re2)) with derivative at lg(Re2)
            Real aux1=(0.5/Math.log(10))*5.74*0.9;
            Real aux2=Delta/3.7 + 5.74/Re2^0.9;
            Real aux3=Math.log10(aux2);
            Real L2=0.25*(Re2/aux3)^2;
            Real aux4=2.51/sqrt(L2) + 0.27*Delta;
            Real aux5=-2*sqrt(L2)*Math.log10(aux4);
            Real x2=Math.log10(L2);
            Real y2=Math.log10(aux5);
            Real yd2=0.5 + (2.51/Math.log(10))/(aux5*aux4);

            // Constants: Cubic polynomial between lg(Re1) and lg(Re2)
            Real diff_x=x2 - x1;
            Real m=(y2 - y1)/diff_x;
            Real c2=(3*m - 2*yd1 - yd2)/diff_x;
            Real c3=(yd1 + yd2 - 2*m)/(diff_x*diff_x);
            Real lambda2_1=64*Re1;
            Real dx;
          algorithm
             dx := Math.log10(lambda2/lambda2_1);
             Re := Re1*(lambda2/lambda2_1)^(1 + dx*(c2 + dx*c3));
             annotation(smoothOrder=1);
          end interpolateInRegion2;

        algorithm
          // Determine upstream density, upstream viscosity, and lambda2
          rho     := if dp >= 0 then rho_a else rho_b;
          mu      := if dp >= 0 then mu_a else mu_b;
          lambda2 := abs(dp)*2*diameter^3*rho/(length*mu*mu);

          // Determine Re under the assumption of laminar flow
          Re := lambda2/64;

          // Modify Re, if turbulent flow
          if Re > Re1 then
             Re :=-2*sqrt(lambda2)*Math.log10(2.51/sqrt(lambda2) + 0.27*Delta);
             if Re < Re2 then
                Re := interpolateInRegion2(Re, Re1, Re2, Delta, lambda2);
             end if;
          end if;

          // Determine mass flow rate
          m_flow := (pi*diameter/4)*mu*(if dp >= 0 then Re else -Re);
                  annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
        end massFlowRate_dp;

        redeclare function extends pressureLoss_m_flow
          "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction"
          import Modelica.Math;
        protected
          constant Real pi = Modelica.Constants.pi;
          Real Delta = roughness/diameter "Relative roughness";
          SI.ReynoldsNumber Re1 = 745*Math.exp(if Delta <= 0.0065 then 1 else 0.0065/Delta)
            "Re leaving laminar curve";
          SI.ReynoldsNumber Re2 = 4000 "Re entering turbulent curve";
          SI.DynamicViscosity mu "Upstream viscosity";
          SI.Density rho "Upstream density";
          SI.ReynoldsNumber Re "Reynolds number";
          Real lambda2 "Modified friction coefficient (= lambda*Re^2)";

          function interpolateInRegion2
             input SI.ReynoldsNumber Re;
             input SI.ReynoldsNumber Re1;
             input SI.ReynoldsNumber Re2;
             input Real Delta;
             output Real lambda2;
            // point lg(lambda2(Re1)) with derivative at lg(Re1)
          protected
            Real x1 = Math.log10(Re1);
            Real y1 = Math.log10(64*Re1);
            Real yd1=1;

            // Point lg(lambda2(Re2)) with derivative at lg(Re2)
            Real aux1=(0.5/Math.log(10))*5.74*0.9;
            Real aux2=Delta/3.7 + 5.74/Re2^0.9;
            Real aux3=Math.log10(aux2);
            Real L2=0.25*(Re2/aux3)^2;
            Real aux4=2.51/sqrt(L2) + 0.27*Delta;
            Real aux5=-2*sqrt(L2)*Math.log10(aux4);
            Real x2 =  Math.log10(Re2);
            Real y2 =  Math.log10(L2);
            Real yd2 = 2 + 4*aux1/(aux2*aux3*(Re2)^0.9);

            // Constants: Cubic polynomial between lg(Re1) and lg(Re2)
            Real diff_x=x2 - x1;
            Real m=(y2 - y1)/diff_x;
            Real c2=(3*m - 2*yd1 - yd2)/diff_x;
            Real c3=(yd1 + yd2 - 2*m)/(diff_x*diff_x);
            Real dx;
          algorithm
             dx := Math.log10(Re/Re1);
             lambda2 := 64*Re1*(Re/Re1)^(1 + dx*(c2 + dx*c3));
             annotation(smoothOrder=1);
          end interpolateInRegion2;
        algorithm
          // Determine upstream density and upstream viscosity
          rho     :=if m_flow >= 0 then rho_a else rho_b;
          mu      :=if m_flow >= 0 then mu_a else mu_b;

          // Determine Re, lambda2 and pressure drop
          Re :=(4/pi)*abs(m_flow)/(diameter*mu);
          lambda2 := if Re <= Re1 then 64*Re else
                    (if Re >= Re2 then 0.25*(Re/Math.log10(Delta/3.7 + 5.74/Re^0.9))^2 else
                     interpolateInRegion2(Re, Re1, Re2, Delta));
          dp :=length*mu*mu/(2*rho*diameter*diameter*diameter)*
               (if m_flow >= 0 then lambda2 else -lambda2);
                  annotation (smoothOrder=1, Documentation(info="<html>

</html>"));
        end pressureLoss_m_flow;

        redeclare function extends massFlowRate_dp_staticHead
          "Return mass flow rate m_flow as function of pressure loss dp, i.e., m_flow = f(dp), due to wall friction and static head"

        protected
          Real Delta = roughness/diameter "Relative roughness";
          SI.ReynoldsNumber Re "Reynolds number";
          SI.ReynoldsNumber Re1 = (745*exp(if Delta <= 0.0065 then 1 else 0.0065/Delta))^0.97
            "Boundary between laminar regime and transition";
          constant SI.ReynoldsNumber Re2 = 4000
            "Boundary between transition and turbulent regime";
          SI.Pressure dp_a
            "Upper end of regularization domain of the m_flow(dp) relation";
          SI.Pressure dp_b
            "Lower end of regularization domain of the m_flow(dp) relation";
          SI.MassFlowRate m_flow_a
            "Value at upper end of regularization domain";
          SI.MassFlowRate m_flow_b
            "Value at lower end of regularization domain";

          SI.MassFlowRate dm_flow_ddp_fric_a
            "Derivative at upper end of regularization domain";
          SI.MassFlowRate dm_flow_ddp_fric_b
            "Derivative at lower end of regularization domain";

          SI.Pressure dp_grav_a = g_times_height_ab*rho_a
            "Static head if mass flows in design direction (a to b)";
          SI.Pressure dp_grav_b = g_times_height_ab*rho_b
            "Static head if mass flows against design direction (b to a)";

          // Properly define zero mass flow conditions
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b)/2;
          Real dm_flow_ddp_fric_zero;

        algorithm
          dp_a := max(dp_grav_a, dp_grav_b)+dp_small;
          dp_b := min(dp_grav_a, dp_grav_b)-dp_small;

          if dp>=dp_a then
            // Positive flow outside regularization
            m_flow := Internal.m_flow_of_dp_fric(dp-dp_grav_a, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta);
          elseif dp<=dp_b then
            // Negative flow outside regularization
            m_flow := Internal.m_flow_of_dp_fric(dp-dp_grav_b, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta);
          else
            // Regularization parameters
            (m_flow_a, dm_flow_ddp_fric_a) := Internal.m_flow_of_dp_fric(dp_a-dp_grav_a, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta);
            (m_flow_b, dm_flow_ddp_fric_b) := Internal.m_flow_of_dp_fric(dp_b-dp_grav_b, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta);
            // Include a properly defined zero mass flow point
            // Obtain a suitable slope from the linear section slope c (value of m_flow is overwritten later)
            (m_flow, dm_flow_ddp_fric_zero) := Utilities.regFun3(dp_zero, dp_b, dp_a, m_flow_b, m_flow_a, dm_flow_ddp_fric_b, dm_flow_ddp_fric_a);
            // Do regularization
            if dp>dp_zero then
              m_flow := Utilities.regFun3(dp, dp_zero, dp_a, m_flow_zero, m_flow_a, dm_flow_ddp_fric_zero, dm_flow_ddp_fric_a);
            else
              m_flow := Utilities.regFun3(dp, dp_b, dp_zero, m_flow_b, m_flow_zero, dm_flow_ddp_fric_b, dm_flow_ddp_fric_zero);
            end if;
          end if;
          annotation (smoothOrder=1);
        end massFlowRate_dp_staticHead;

        redeclare function extends pressureLoss_m_flow_staticHead
          "Return pressure loss dp as function of mass flow rate m_flow, i.e., dp = f(m_flow), due to wall friction and static head"

        protected
          Real Delta = roughness/diameter "Relative roughness";
          SI.ReynoldsNumber Re1 = 745*exp(if Delta <= 0.0065 then 1 else 0.0065/Delta)
            "Boundary between laminar regime and transition";
          constant SI.ReynoldsNumber Re2 = 4000
            "Boundary between transition and turbulent regime";

          SI.MassFlowRate m_flow_a
            "Upper end of regularization domain of the dp(m_flow) relation";
          SI.MassFlowRate m_flow_b
            "Lower end of regularization domain of the dp(m_flow) relation";

          SI.Pressure dp_a "Value at upper end of regularization domain";
          SI.Pressure dp_b "Value at lower end of regularization domain";

          SI.Pressure dp_grav_a = g_times_height_ab*rho_a
            "Static head if mass flows in design direction (a to b)";
          SI.Pressure dp_grav_b = g_times_height_ab*rho_b
            "Static head if mass flows against design direction (b to a)";

          Real ddp_dm_flow_a
            "Derivative of pressure drop with mass flow rate at m_flow_a";
          Real ddp_dm_flow_b
            "Derivative of pressure drop with mass flow rate at m_flow_b";

          // Properly define zero mass flow conditions
          SI.MassFlowRate m_flow_zero = 0;
          SI.Pressure dp_zero = (dp_grav_a + dp_grav_b)/2;
          Real ddp_dm_flow_zero;

        algorithm
          m_flow_a := if dp_grav_a<dp_grav_b then
            Internal.m_flow_of_dp_fric(dp_grav_b - dp_grav_a, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta)+m_flow_small else
            m_flow_small;
          m_flow_b := if dp_grav_a<dp_grav_b then
            Internal.m_flow_of_dp_fric(dp_grav_a - dp_grav_b, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta)-m_flow_small else
            -m_flow_small;

          if m_flow>=m_flow_a then
            // Positive flow outside regularization
            dp := Internal.dp_fric_of_m_flow(m_flow, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta) + dp_grav_a;
          elseif m_flow<=m_flow_b then
            // Negative flow outside regularization
            dp := Internal.dp_fric_of_m_flow(m_flow, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta) + dp_grav_b;
          else
            // Regularization parameters
            (dp_a, ddp_dm_flow_a) := Internal.dp_fric_of_m_flow(m_flow_a, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta);
            dp_a := dp_a + dp_grav_a "Adding dp_grav to dp_fric to get dp";
            (dp_b, ddp_dm_flow_b) := Internal.dp_fric_of_m_flow(m_flow_b, rho_a, rho_b, mu_a, mu_b, length, diameter, Re1, Re2, Delta);
            dp_b := dp_b + dp_grav_b "Adding dp_grav to dp_fric to get dp";
            // Include a properly defined zero mass flow point
            // Obtain a suitable slope from the linear section slope c (value of dp is overwritten later)
            (dp, ddp_dm_flow_zero) := Utilities.regFun3(m_flow_zero, m_flow_b, m_flow_a, dp_b, dp_a, ddp_dm_flow_b, ddp_dm_flow_a);
            // Do regularization
            if m_flow>m_flow_zero then
              dp := Utilities.regFun3(m_flow, m_flow_zero, m_flow_a, dp_zero, dp_a, ddp_dm_flow_zero, ddp_dm_flow_a);
            else
              dp := Utilities.regFun3(m_flow, m_flow_b, m_flow_zero, dp_b, dp_zero, ddp_dm_flow_b, ddp_dm_flow_zero);
            end if;
          end if;
          annotation (smoothOrder=1);
        end pressureLoss_m_flow_staticHead;

      package Internal
          "Functions to calculate mass flow rate from friction pressure drop and vice versa"
        function m_flow_of_dp_fric
            "Calculate mass flow rate as function of pressure drop due to friction"

          input SI.Pressure dp_fric
              "Pressure loss due to friction (dp = port_a.p - port_b.p)";
          input SI.Density rho_a "Density at port_a";
          input SI.Density rho_b "Density at port_b";
          input SI.DynamicViscosity mu_a
              "Dynamic viscosity at port_a (dummy if use_mu = false)";
          input SI.DynamicViscosity mu_b
              "Dynamic viscosity at port_b (dummy if use_mu = false)";
          input SI.Length length "Length of pipe";
          input SI.Diameter diameter "Inner (hydraulic) diameter of pipe";
          input SI.ReynoldsNumber Re1
              "Boundary between laminar regime and transition";
          input SI.ReynoldsNumber Re2
              "Boundary between transition and turbulent regime";
          input Real Delta "Relative roughness";
          output SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";
          output Real dm_flow_ddp_fric
              "Derivative of mass flow rate with dp_fric";

          protected
          function interpolateInRegion2_withDerivative
              "Interpolation in log-log space using a cubic Hermite polynomial, where x=log10(lambda2), y=log10(Re)"

            input Real lambda2 "Known independent variable";
            input SI.ReynoldsNumber Re1
                "Boundary between laminar regime and transition";
            input SI.ReynoldsNumber Re2
                "Boundary between transition and turbulent regime";
            input Real Delta "Relative roughness";
            input SI.Pressure dp_fric
                "Pressure loss due to friction (dp = port_a.p - port_b.p)";
            output SI.ReynoldsNumber Re "Unknown return variable";
            output Real dRe_ddp "Derivative of return value";
            // point lg(lambda2(Re1)) with derivative at lg(Re1)
            protected
            Real x1=log10(64*Re1);
            Real y1=log10(Re1);
            Real y1d=1;

            // Point lg(lambda2(Re2)) with derivative at lg(Re2)
            Real aux2=Delta/3.7 + 5.74/Re2^0.9;
            Real aux3=log10(aux2);
            Real L2=0.25*(Re2/aux3)^2;
            Real aux4=2.51/sqrt(L2) + 0.27*Delta;
            Real aux5=-2*sqrt(L2)*log10(aux4);
            Real x2=log10(L2);
            Real y2=log10(aux5);
            Real y2d=0.5 + (2.51/ln(10))/(aux5*aux4);

            // Point of interest in transformed space
            Real x=log10(lambda2);
            Real y;
            Real dy_dx "Derivative in transformed space";
          algorithm
            // Interpolation
            (y, dy_dx) := Utilities.cubicHermite_withDerivative(x, x1, x2, y1, y2, y1d, y2d);

            // Return value
            Re := 10^y;

            // Derivative of return value
            dRe_ddp := Re/abs(dp_fric)*dy_dx;
            annotation (smoothOrder=1);
          end interpolateInRegion2_withDerivative;

          SI.DynamicViscosity mu "Upstream viscosity";
          SI.Density rho "Upstream density";
          Real lambda2 "Modified friction coefficient (= lambda*Re^2)";
          SI.ReynoldsNumber Re "Reynolds number";
          Real dRe_ddp "dRe/ddp";
          Real aux1;
          Real aux2;

        algorithm
          // Determine upstream density and upstream viscosity
          if dp_fric >= 0 then
            rho := rho_a;
            mu  := mu_a;
          else
            rho := rho_b;
            mu  := mu_b;
          end if;

          // Positive mass flow rate
          lambda2 := abs(dp_fric)*2*diameter^3*rho/(length*mu*mu)
              "Known as lambda2=f(dp)";

          aux1:=(2*diameter^3*rho)/(length*mu^2);

          // Determine Re and dRe/ddp under the assumption of laminar flow
          Re := lambda2/64 "Hagen-Poiseuille";
          dRe_ddp := aux1/64 "Hagen-Poiseuille";

          // Modify Re, if turbulent flow
          if Re > Re1 then
            Re :=-2*sqrt(lambda2)*log10(2.51/sqrt(lambda2) + 0.27*Delta)
                "Colebrook-White";
            aux2 := sqrt(aux1*abs(dp_fric));
            dRe_ddp := 1/ln(10)*(-2*ln(2.51/aux2+0.27*Delta)*aux1/(2*aux2)+2*2.51/(2*abs(dp_fric)*(2.51/aux2+0.27*Delta)));
            if Re < Re2 then
              (Re, dRe_ddp) := interpolateInRegion2_withDerivative(lambda2, Re1, Re2, Delta, dp_fric);
            end if;
          end if;

          // Determine mass flow rate
          m_flow := (pi*diameter/4)*mu*(if dp_fric >= 0 then Re else -Re);
          // Determine derivative of mass flow rate with dp_fric
          dm_flow_ddp_fric := (pi*diameter*mu)/4*dRe_ddp;
          annotation(smoothOrder=1);
        end m_flow_of_dp_fric;

        function dp_fric_of_m_flow
            "Calculate pressure drop due to friction as function of mass flow rate"

          input SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";
          input SI.Density rho_a "Density at port_a";
          input SI.Density rho_b "Density at port_b";
          input SI.DynamicViscosity mu_a
              "Dynamic viscosity at port_a (dummy if use_mu = false)";
          input SI.DynamicViscosity mu_b
              "Dynamic viscosity at port_b (dummy if use_mu = false)";
          input SI.Length length "Length of pipe";
          input SI.Diameter diameter "Inner (hydraulic) diameter of pipe";
          input SI.ReynoldsNumber Re1
              "Boundary between laminar regime and transition";
          input SI.ReynoldsNumber Re2
              "Boundary between transition and turbulent regime";
          input Real Delta "Relative roughness";
          output SI.Pressure dp_fric
              "Pressure loss due to friction (dp_fric = port_a.p - port_b.p - dp_grav)";
          output Real ddp_fric_dm_flow
              "Derivative of pressure drop with mass flow rate";

          protected
          function interpolateInRegion2
              "Interpolation in log-log space using a cubic Hermite polynomial, where x=log10(Re), y=log10(lambda2)"

            input SI.ReynoldsNumber Re "Known independent variable";
            input SI.ReynoldsNumber Re1
                "Boundary between laminar regime and transition";
            input SI.ReynoldsNumber Re2
                "Boundary between transition and turbulent regime";
            input Real Delta "Relative roughness";
            input SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";
            output Real lambda2 "Unknown return value";
            output Real dlambda2_dm_flow "Derivative of return value";
            // point lg(lambda2(Re1)) with derivative at lg(Re1)
            protected
            Real x1 = log10(Re1);
            Real y1 = log10(64*Re1);
            Real y1d = 1;

            // Point lg(lambda2(Re2)) with derivative at lg(Re2)
            Real aux2 = Delta/3.7 + 5.74/Re2^0.9;
            Real aux3 = log10(aux2);
            Real L2 = 0.25*(Re2/aux3)^2;
            Real x2 = log10(Re2);
            Real y2 = log10(L2);
            Real y2d = 2+(2*5.74*0.9)/(ln(aux2)*Re2^0.9*aux2);

            // Point of interest in transformed space
            Real x=log10(Re);
            Real y;
            Real dy_dx "Derivative in transformed space";
          algorithm
            // Interpolation
            (y, dy_dx) := Utilities.cubicHermite_withDerivative(x, x1, x2, y1, y2, y1d, y2d);

            // Return value
            lambda2 := 10^y;

            // Derivative of return value
            dlambda2_dm_flow := lambda2/abs(m_flow)*dy_dx;
            annotation(smoothOrder=1);
          end interpolateInRegion2;

          SI.DynamicViscosity mu "Upstream viscosity";
          SI.Density rho "Upstream density";
          SI.ReynoldsNumber Re "Reynolds number";
          Real lambda2 "Modified friction coefficient (= lambda*Re^2)";
          Real dlambda2_dm_flow "dlambda2/dm_flow";
          Real aux1;
          Real aux2;

        algorithm
          // Determine upstream density and upstream viscosity
          if m_flow >= 0 then
            rho := rho_a;
            mu  := mu_a;
          else
            rho := rho_b;
            mu  := mu_b;
          end if;

          // Determine Reynolds number
          Re :=(4/pi)*abs(m_flow)/(diameter*mu);

          aux1 := 4/(pi*diameter*mu);

          // Use correlation for lambda2 depending on actual conditions
          if Re <= Re1 then
            lambda2 := 64*Re "Hagen-Poiseuille";
            dlambda2_dm_flow := 64*aux1 "Hagen-Poiseuille";
          elseif Re >= Re2 then
            lambda2 := 0.25*(Re/log10(Delta/3.7 + 5.74/Re^0.9))^2 "Swamee-Jain";
            aux2 := Delta/3.7+5.74/((aux1*abs(m_flow))^0.9);
            dlambda2_dm_flow := 0.5*aux1*Re*ln(10)^2*(1/(ln(aux2)^2)+(5.74*0.9)/(ln(aux2)^3*Re^0.9*aux2))
                "Swamee-Jain";
          else
            (lambda2, dlambda2_dm_flow) := interpolateInRegion2(Re, Re1, Re2, Delta, m_flow);
          end if;

          // Compute pressure drop from lambda2
          dp_fric :=length*mu*mu/(2*rho*diameter*diameter*diameter)*
               (if m_flow >= 0 then lambda2 else -lambda2);

          // Compute derivative from dlambda2/dm_flow
          ddp_fric_dm_flow := (length*mu^2)/(2*diameter^3*rho)*dlambda2_dm_flow;
          annotation(smoothOrder=1);
        end dp_fric_of_m_flow;
      end Internal;
        annotation (Documentation(info="<html>
<p>
This component defines the complete regime of wall friction.
The details are described in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a>.
The functional relationship of the friction loss factor &lambda; is
displayed in the next figure. Function massFlowRate_dp() defines the \"red curve\"
(\"Swamee and Jain\"), where as function pressureLoss_m_flow() defines the
\"blue curve\" (\"Colebrook-White\"). The two functions are inverses from
each other and give slightly different results in the transition region
between Re = 1500 .. 4000, in order to get explicit equations without
solving a non-linear equation.
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/PipeFriction1.png\">

<p>
Additionally to wall friction, this component properly implements static
head. With respect to the latter, two cases can be distinguished. In the case
shown next, the change of elevation with the path from a to b has the opposite
sign of the change of density.</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/PipeFrictionStaticHead_case-a.PNG\">

<p>
In the case illustrated second, the change of elevation with the path from a to
b has the same sign of the change of density.</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/PipeFrictionStaticHead_case-b.PNG\">

</html>"));
      end Detailed;

      model TestWallFrictionAndGravity
        "Pressure loss in pipe due to wall friction and gravity (only for test purposes; if needed use Pipes.StaticPipe instead)"
        extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;

        replaceable package WallFriction =
          Modelica.Fluid.Pipes.BaseClasses.WallFriction.QuadraticTurbulent
          constrainedby
          Modelica.Fluid.Pipes.BaseClasses.WallFriction.PartialWallFriction
          "Characteristic of wall friction"  annotation(choicesAllMatching=true);

        parameter SI.Length length "Length of pipe";
        parameter SI.Diameter diameter "Inner (hydraulic) diameter of pipe";
        parameter SI.Length height_ab = 0.0 "Height(port_b) - Height(port_a)"
                                                                           annotation(Evaluate=true);
        parameter SI.Length roughness(min=0) = 2.5e-5
          "Absolute roughness of pipe (default = smooth steel pipe)"
            annotation(Dialog(enable=WallFriction.use_roughness));

        parameter Boolean use_nominal = false
          "= true, if mu_nominal and rho_nominal are used, otherwise computed from medium"
                                                                                                        annotation(Evaluate=true);
        parameter SI.DynamicViscosity mu_nominal = Medium.dynamicViscosity(
                                                       Medium.setState_pTX(
                                                           Medium.p_default, Medium.T_default, Medium.X_default))
          "Nominal dynamic viscosity (e.g., mu_liquidWater = 1e-3, mu_air = 1.8e-5)"
                                                                                  annotation(Dialog(enable=use_nominal));
        parameter SI.Density rho_nominal = Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default)
          "Nominal density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
                                                                   annotation(Dialog(enable=use_nominal));

        parameter Boolean show_Re = false
          "= true, if Reynolds number is included for plotting"
           annotation (Evaluate=true, Dialog(tab="Advanced"));
        parameter Boolean from_dp=true
          " = true, use m_flow = f(dp), otherwise dp = f(m_flow)"
          annotation (Evaluate=true, Dialog(tab="Advanced"));
        parameter SI.AbsolutePressure dp_small = system.dp_small
          "Within regularization if |dp| < dp_small (may be wider for large discontinuities in static head)"
          annotation(Dialog(tab="Advanced", enable=from_dp and WallFriction.use_dp_small));
        SI.ReynoldsNumber Re = Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber_m_flow(
                                                               m_flow, noEvent(if m_flow>0 then mu_a else mu_b), diameter) if
             show_Re "Reynolds number of pipe flow";

      protected
        SI.DynamicViscosity mu_a = if not WallFriction.use_mu then 1.e-10 else
                                    (if use_nominal then mu_nominal else Medium.dynamicViscosity(state_a));
        SI.DynamicViscosity mu_b = if not WallFriction.use_mu then 1.e-10 else
                                    (if use_nominal then mu_nominal else Medium.dynamicViscosity(state_b));
        SI.Density rho_a = if use_nominal then rho_nominal else Medium.density(state_a);
        SI.Density rho_b = if use_nominal then rho_nominal else Medium.density(state_b);

        Real g_times_height_ab(final unit="m2/s2") = system.g*height_ab
          "Gravitiy times height_ab = dp_grav/d";

        // Currently not in use (means to widen the regularization domain in case of large difference in static head)
        final parameter Boolean use_x_small_staticHead = false
          "Use dp_/m_flow_small_staticHead only if static head actually exists"
                                                                                annotation(Evaluate=true);
                                                               /*abs(height_ab)>0*/
        SI.AbsolutePressure dp_small_staticHead = noEvent(max(dp_small, 0.015*abs(g_times_height_ab*(rho_a-rho_b))))
          "Heuristic for large discontinuities in static head";
        SI.MassFlowRate m_flow_small_staticHead = noEvent(max(m_flow_small, (-5.55e-7*(rho_a+rho_b)/2+5.5e-4)*abs(g_times_height_ab*(rho_a-rho_b))))
          "Heuristic for large discontinuities in static head";

      equation
        if from_dp and not WallFriction.dp_is_zero then
          m_flow = WallFriction.massFlowRate_dp_staticHead(dp, rho_a, rho_b, mu_a, mu_b, length, diameter,
            g_times_height_ab, roughness, if use_x_small_staticHead then dp_small_staticHead else dp_small);
        else
          dp = WallFriction.pressureLoss_m_flow_staticHead(m_flow, rho_a, rho_b, mu_a, mu_b, length, diameter,
            g_times_height_ab, roughness, if use_x_small_staticHead then m_flow_small_staticHead else m_flow_small);
        end if;

        // Energy balance, considering change of potential energy
        port_a.h_outflow = inStream(port_b.h_outflow) + system.g*height_ab;
        port_b.h_outflow = inStream(port_a.h_outflow) - system.g*height_ab;

          annotation (defaultComponentName="pipeFriction",Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
              Rectangle(
                extent={{-100,60},{100,-60}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={192,192,192}),
              Rectangle(
                extent={{-100,44},{100,-45}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={0,127,255}),
              Text(
                extent={{-150,80},{150,120}},
                lineColor={0,0,255},
                textString="%name")}),           Documentation(info="<html>
<p>
This model describes pressure losses due to <b>wall friction</b> in a pipe
and due to gravity.
It is assumed that no mass or energy is stored in the pipe.
Correlations of different complexity and validity can be
seleted via the replaceable package <b>WallFriction</b> (see parameter menu below).
The details of the pipe wall friction model are described in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a>.
Basically, different variants of the equation
</p>

<pre>
   dp = &lambda;(Re,<font face=\"Symbol\">D</font>)*(L/D)*&rho;*v*|v|/2
</pre>

<p>
are used, where the friction loss factor &lambda; is shown
in the next figure:
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/PipeFriction1.png\">

<p>
By default, the correlations are computed with media data
at the actual time instant.
In order to reduce non-linear equation systems, parameter
<b>use_nominal</b> provides the option
to compute the correlations with constant media values
at the desired operating point. This might speed-up the
simulation and/or might give a more robust simulation.
</p>
</html>"),Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
              Rectangle(
                extent={{-100,64},{100,-64}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Backward),
              Rectangle(
                extent={{-100,50},{100,-49}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-60,-49},{-60,50}},
                color={0,0,255},
                arrow={Arrow.Filled,Arrow.Filled}),
              Text(
                extent={{-50,16},{6,-10}},
                lineColor={0,0,255},
                textString="diameter"),
              Line(
                points={{-100,74},{100,74}},
                color={0,0,255},
                arrow={Arrow.Filled,Arrow.Filled}),
              Text(
                extent={{-34,92},{34,74}},
                lineColor={0,0,255},
                textString="length")}));
      end TestWallFrictionAndGravity;
      annotation (Documentation(info="<html>
<p>
This package provides functions to compute
pressure losses due to <b>wall friction</b> in a pipe.
Every correlation is defined by a package that is derived
by inheritance from the package WallFriction.PartialWallFriction.
The details of the underlying pipe wall friction model are described in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a>.
Basically, different variants of the equation
</p>

<pre>
   dp = &lambda;(Re,<font face=\"Symbol\">D</font>)*(L/D)*&rho;*v*|v|/2
</pre>

<p>
are used, where the friction loss factor &lambda; is shown
in the next figure:
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/PipeFriction1.png\">

</html>"));
    end WallFriction;
  end BaseClasses;
  annotation (Documentation(info="<html>

</html>"));

end Pipes;
