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
            lineColor={0,0,0},
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
<li><i>8 Dec 2008</i>
    by Ruediger Franke:<br>
       Introduce small nominal pressure loss for regularization</li>
<li><i>31 Oct 2007</i>
    by <a href=\"mailto:jonas@modelon.se\">Jonas Eborn</a>:<br>
       Changed to flow-direction dependent density</li>
<li><i>2 Nov 2005</i>
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
      annotation (Placement(transformation(extent={{-10,44},{10,64}}, rotation=
              0), iconTransformation(extent={{-10,35},{10,55}})));

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
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}},
            rotation=0)));
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
      annotation (Placement(transformation(extent={{-10,10},{10,30}},  rotation=
             0)));
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
              {60,10}},          rotation=0)));

  equation
    connect(staticPipe1.port_a, port_a)
      annotation (Line(points={{-60,0},{-80,0},{-100,0}},
                                                  color={0,127,255}));
    connect(staticPipe2.port_b, port_b)
      annotation (Line(points={{60,0},{80,0},{100,0}},
                                                color={0,127,255}));
    connect(staticPipe1.port_b, volume.ports[1])   annotation (Line(
        points={{-40,0},{-2,0},{-2,10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(staticPipe2.port_a, volume.ports[2])   annotation (Line(
        points={{40,0},{2,0},{2,10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(heatPort, volume.heatPort) annotation (Line(
        points={{0,54},{0,40},{-20,40},{-20,20},{-10,20}},
        color={191,0,0},
        smooth=Smooth.None));
    annotation (defaultComponentName="pipe",Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
          graphics={Ellipse(
            extent={{-10,10},{10,-10}},
            lineColor={0,0,0},
            fillColor={0,0,0},
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

  model TwoVolumes
    "Two volumes containing an ideal gas with a zero dp connection, MSL-based"

    Modelica.Fluid.Vessels.ClosedVolume V1(
      use_portsData=false,
      V=1,
      nPorts=2,
      redeclare package Medium = Modelica.Media.Air.DryAirNasa)
      annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
    Modelica.Fluid.Vessels.ClosedVolume V2(
      use_portsData=false,
      V=1,
      nPorts=2,
      redeclare package Medium = Modelica.Media.Air.DryAirNasa)
      annotation (Placement(transformation(extent={{-12,0},{8,20}})));
    Modelica.Fluid.Sources.MassFlowSource_T source(
      nPorts=1,
      redeclare package Medium = Modelica.Media.Air.DryAirNasa,
      m_flow=0.01)
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
    Modelica.Fluid.Sources.FixedBoundary sink(
      redeclare package Medium = Modelica.Media.Air.DryAirNasa,
      T(displayUnit="K") = 300,
      nPorts=1,
      p=1000) annotation (Placement(transformation(extent={{80,-20},{60,0}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{60,60},{80,80}})));
    Modelica.Fluid.Valves.ValveLinear valveLinear(
      redeclare package Medium = Modelica.Media.Air.DryAirNasa,
      dp_nominal=100000,
      m_flow_nominal=0.01)
      annotation (Placement(transformation(extent={{20,-20},{40,0}})));
    Modelica.Blocks.Sources.RealExpression one(y=1)
      annotation (Placement(transformation(extent={{2,24},{22,44}})));
  equation
    connect(source.ports[1], V1.ports[1]) annotation (Line(
        points={{-60,-10},{-40,-10},{-40,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(V1.ports[2], V2.ports[1]) annotation (Line(
        points={{-36,0},{-36,-10},{-4,-10},{-4,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(V2.ports[2], valveLinear.port_a) annotation (Line(
        points={{0,0},{0,-10},{20,-10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(valveLinear.port_b, sink.ports[1]) annotation (Line(
        points={{40,-10},{60,-10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(one.y, valveLinear.opening) annotation (Line(
        points={{23,34},{30,34},{30,-2}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end TwoVolumes;

  model TwoVolumesEquations
    "Two volumes containing an ideal gas with a zero dp connection, equation-based"
    Real M1(stateSelect = StateSelect.avoid),
         M2(stateSelect = StateSelect.avoid),
         E1(stateSelect = StateSelect.avoid),
         E2(stateSelect = StateSelect.avoid),
         p1(stateSelect = StateSelect.prefer),
         p2(stateSelect = StateSelect.prefer),
         T1(stateSelect = StateSelect.prefer),
         T2(stateSelect = StateSelect.prefer),
         w0, w1, w2, h1, h2;
    parameter Real V = 1;
    parameter Real R = 400;
    parameter Real cp = 1000;
    parameter Real cv = cp-R;
    parameter Real h0 = cp*300;
    parameter Real Kv = 1e-7;
  equation
    der(M1) = w0 - w1;
    der(E1) = w0*h0 - w1*h1;
    der(M2) = w1 - w2;
    der(E2) = w1*h1 - w2*h2;
    M1 = V*p1/(R*T1);
    M2 = V*p2/(R*T2);
    E1 = M1*cv*T1;
    E2 = M2*cv*T2;
    h1 = cp*T1;
    h2 = cp*T2;
    w0 = 0.01;
    w2 = Kv*p2;
    p1 = p2;
  end TwoVolumesEquations;
end BaseClasses;
