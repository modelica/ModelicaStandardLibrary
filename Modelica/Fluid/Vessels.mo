within Modelica.Fluid;
package Vessels "Devices for storing fluid"
   extends Modelica.Fluid.Icons.VariantLibrary;

    model ClosedVolume
    "Volume of fixed size, closed to the ambient, with inlet/outlet ports"
    import Modelica.Constants.pi;

      // Mass and energy balance, ports
      extends Modelica.Fluid.Vessels.BaseClasses.PartialLumpedVessel(
        final fluidVolume = V,
        vesselArea = pi*(3/4*V)^(2/3),
        heatTransfer(surfaceAreas={4*pi*(3/4*V/pi)^(2/3)}));

      parameter SI.Volume V "Volume";

    equation
      Wb_flow = 0;
      for i in 1:nPorts loop
        vessel_ps_static[i] = medium.p;
      end for;

      annotation (defaultComponentName="volume",
        Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}), graphics={Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={170,213,255}), Text(
            extent={{-150,12},{150,-18}},
            lineColor={0,0,0},
            textString="V=%V")}),
      Documentation(info="<html>
<p>
Ideally mixed volume of constant size with two fluid ports and one medium model.
The flow properties are computed from the upstream quantities, pressures are equal in both nodes and the medium model if <code>use_portsData=false</code>.
Heat transfer through a thermal port is possible, it equals zero if the port remains unconnected.
A spherical shape is assumed for the heat transfer area, with V=4/3*pi*r^3, A=4*pi*r^2.
Ideal heat transfer is assumed per default; the thermal port temperature is equal to the medium temperature.
</p>
<p>
If <code>use_portsData=true</code>, the port pressures represent the pressures just after the outlet (or just before the inlet) in the attached pipe.
The hydraulic resistances <tt>portsData.zeta_in</tt> and <tt>portsData.zeta_out</tt> determine the dissipative pressure drop between volume and port depending on
the direction of mass flow. See <a href=\"Modelica://Modelica.Fluid.Vessels.BaseClasses.VesselPortsData\">VesselPortsData</a> and <i>[Idelchik, Handbook of Hydraulic Resistance, 2004]</i>.
</p>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}),
              graphics));
    end ClosedVolume;

model OpenTank "Simple tank with inlet/outlet ports"
    import Modelica.Constants.pi;

  // Tank properties
  SI.Height level(stateSelect=StateSelect.prefer, start=max(level_start, Modelica.Constants.eps))
      "Level height of tank";
  SI.Volume V(stateSelect=StateSelect.never) "Actual tank volume";

  // Tank geometry
  parameter SI.Height height "Height of tank";
  parameter SI.Area crossArea "Area of tank";

  // Ambient
  parameter Medium.AbsolutePressure p_ambient=system.p_ambient
      "Tank surface pressure"
    annotation(Dialog(tab = "Assumptions", group = "Ambient"));
  parameter Medium.Temperature T_ambient=system.T_ambient
      "Tank surface Temperature"
    annotation(Dialog(tab = "Assumptions", group = "Ambient"));

  // Initialization
  parameter SI.Height level_start(min=0) = 0.5*height
      "Start value of tank level"
    annotation(Dialog(tab="Initialization"));

  // Mass and energy balance, ports
  extends Modelica.Fluid.Vessels.BaseClasses.PartialLumpedVessel(
    final fluidVolume = V,
    final fluidLevel = level,
    final fluidLevel_max = height,
    final vesselArea = crossArea,
    heatTransfer(surfaceAreas={crossArea+2*sqrt(crossArea*pi)*level}),
    final initialize_p = false,
    final p_start = p_ambient);

equation
  // Total quantities
  V = crossArea*level "Volume of fluid";
  medium.p = p_ambient;

  // Source termsEnergy balance
  if Medium.singleState or energyDynamics == Types.Dynamics.SteadyState then
    Wb_flow = 0
        "Mechanical work is neglected, since also neglected in medium model (otherwise unphysical small temperature change, if tank level changes)";
  else
    Wb_flow = -p_ambient*der(V);
  end if;

  //Determine port properties
  for i in 1:nPorts loop
    vessel_ps_static[i] = max(0, level - portsData_height[i])*system.g*medium.d + p_ambient;
  end for;

initial equation
  if massDynamics == Types.Dynamics.FixedInitial then
    level = level_start;
  elseif massDynamics == Types.Dynamics.SteadyStateInitial then
    der(level) = 0;
  end if;

    annotation (defaultComponentName="tank",
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1},
          initialScale=0.2), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.VerticalCylinder),
          Rectangle(
            extent=DynamicSelect({{-100,-100},{100,10}}, {{-100,-100},{100,(-100
                 + 200*level/height)}}),
            lineColor={0,0,0},
            fillColor={85,170,255},
            fillPattern=FillPattern.VerticalCylinder),
          Line(points={{-100,100},{-100,-100},{100,-100},{100,100}}, color={0,0,
                0}),
          Text(
            extent={{-95,60},{95,40}},
            lineColor={0,0,0},
            textString="level ="),
          Text(
            extent={{-95,-24},{95,-44}},
            lineColor={0,0,0},
            textString=DynamicSelect("%level_start", realString(
                level,
                1,
                2)))}),
      Documentation(info="<HTML>
<p>
Model of a tank that is open to the ambient at the fixed pressure
<tt>p_ambient</tt>.
</p>
<p>
The vector of connectors <b>ports</b> represents fluid ports at configurable heights, relative to the bottom of tank.
Fluid can flow either out of or in to each port.
</p>
The following assumptions are made:
<ul>
<li>The tank is filled with a single or multiple-substance medium having a density higher than the density of the ambient medium.</li>
<li>The fluid has uniform density, temperature and mass fractions</li>
<li>No liquid is leaving the tank through the open top; the simulation breaks with an assertion if the liquid level growths over the height.</li>
</ul>
<p>
The port pressures represent the pressures just after the outlet (or just before the inlet) in the attached pipe.
The hydraulic resistances <tt>portsData.zeta_in</tt> and <tt>portsData.zeta_out</tt> determine the dissipative pressure drop between tank and port depending on
the direction of mass flow. See <a href=\"Modelica://Modelica.Fluid.Vessels.BaseClasses.VesselPortsData\">VesselPortsData</a> and <i>[Idelchik, Handbook of Hydraulic Resistance, 2004]</i>.
</p>
<p>
With the setting <tt>use_portsData=false</tt>, the port pressure represents the static head
at the height of the respective port.
The relationship between pressure drop and mass flow rate at the port must then be provided by connected components;
Heights of ports as well as kinetic and potential energy of fluid enering or leaving are not taken into account anymore.
</p>
</HTML>", revisions="<html>
<ul>
<li><i>Dec. 12, 2008</i> by Ruediger Franke: move port definitions
   to BaseClasses.PartialLumpedVessel; also use energy and mass balance from common base class</li>
<li><i>Dec. 8, 2008</i> by Michael Wetter (LBNL):<br>
Implemented trace substances.</li>
<li><i>Jan. 6, 2006</i> by Katja Poschlad, Manuel Remelhe (AST Uni Dortmund),
   Martin Otter (DLR):<br>
   Implementation based on former tank model.</li>
<li><i>Oct. 29, 2007</i> by Carsten Heinrich (ILK Dresden):<br>
Adapted to the new fluid library interfaces:
<ul> <li>FluidPorts_b is used instead of FluidPort_b (due to it is defined as an array of ports)</li>
    <li>Port name changed from port to ports</li></ul>Updated documentation.</li>
<li><i>Apr. 25, 2006</i> by Katrin Pr&ouml;l&szlig; (TUHH):<br>
Limitation to bottom ports only, added inlet and outlet loss factors.</li>
</ul>
</html>"),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1},
          initialScale=0.2), graphics));
end OpenTank;

  package BaseClasses
    "Base classes used in the Vessels package (only of interest to build new component models)"
    extends Modelica.Fluid.Icons.BaseClassLibrary;

      partial model PartialLumpedVessel
      "Lumped volume with a vector of fluid ports and replaceable heat transfer model"
        extends Modelica.Fluid.Interfaces.PartialLumpedVolume;

        // Port definitions
        parameter Integer nPorts=0 "Number of ports"
          annotation(Evaluate=true, Dialog(__Dymola_connectorSizing=true, tab="General",group="Ports"));
        VesselFluidPorts_b ports[nPorts](redeclare each package Medium = Medium)
        "Fluid inlets and outlets"
          annotation (Placement(transformation(extent={{-40,-10},{40,10}},
            origin={0,-100})));

        // Port properties
        parameter Boolean use_portsData=true
        "= false to neglect pressure loss and kinetic energy"
          annotation(Evaluate=true, Dialog(tab="General",group="Ports"));
        parameter Modelica.Fluid.Vessels.BaseClasses.VesselPortsData[nPorts]
        portsData if   use_portsData "Data of inlet/outlet ports"
          annotation(Dialog(tab="General",group="Ports",enable= use_portsData));

        parameter SI.MassFlowRate m_flow_small(min=0) = system.m_flow_small
        "Regularization range at zero mass flow rate"
          annotation(Dialog(tab="Advanced", group="Port properties", enable=stiffCharacteristicForEmptyPort));
      /*
  parameter Medium.AbsolutePressure dp_small = system.dp_small
    "Turbulent flow if |dp| >= dp_small (regularization of zero flow)"
    annotation(Dialog(tab="Advanced",group="Ports"));
*/
        Medium.EnthalpyFlowRate ports_H_flow[nPorts];
        Medium.MassFlowRate ports_mXi_flow[nPorts,Medium.nXi];
        Medium.MassFlowRate[Medium.nXi] sum_ports_mXi_flow
        "Substance mass flows through ports";
        Medium.ExtraPropertyFlowRate ports_mC_flow[nPorts,Medium.nC];
        Medium.ExtraPropertyFlowRate[Medium.nC] sum_ports_mC_flow
        "Trace substance mass flows through ports";

        // Heat transfer through boundary
        parameter Boolean use_HeatTransfer = false
        "= true to use the HeatTransfer model"
            annotation (Dialog(tab="Assumptions", group="Heat transfer"));
        replaceable model HeatTransfer =
            Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer
          constrainedby
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.PartialVesselHeatTransfer
        "Wall heat transfer"
            annotation (Dialog(tab="Assumptions", group="Heat transfer",enable=use_HeatTransfer),choicesAllMatching=true);
        HeatTransfer heatTransfer(
          redeclare final package Medium = Medium,
          final n=1,
          final states = {medium.state},
          final use_k = use_HeatTransfer)
            annotation (Placement(transformation(
              extent={{-10,-10},{30,30}},
              rotation=90,
              origin={-50,-10})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if use_HeatTransfer
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

        // Conservation of kinetic energy
        Medium.Density[nPorts] portDensities
        "densites of the fluid at the device boudary";
        SI.Velocity[nPorts] portVelocities
        "velocities of fluid flow at device boundary";
        SI.EnergyFlowRate[nPorts] ports_E_flow
        "flow of kinetic and potential energy at device boundary";

        // Note: should use fluidLevel_start - portsData.height
        Real[nPorts] s(each start = fluidLevel_max)
        "curve parameters for port flows vs. port pressures; for further details see, Modelica Tutorial: Ideal switching devices";
        Real[nPorts] ports_penetration
        "penetration of port with fluid, depending on fluid level and port diameter";

        // treatment of pressure losses at ports
        SI.Area[nPorts] portAreas = {Modelica.Constants.pi/4*portsData_diameter[i]^2 for i in 1:nPorts};
        Medium.AbsolutePressure[nPorts] vessel_ps_static
        "static pressures inside the vessel at the height of the corresponding ports, zero flow velocity";
    protected
        input SI.Height fluidLevel = 0
        "level of fluid in the vessel for treating heights of ports";
        parameter SI.Height fluidLevel_max = 1
        "maximum level of fluid in the vessel";
        parameter SI.Area vesselArea = Modelica.Constants.inf
        "Area of the vessel used to relate to cross flow area of ports";

        // Treatment of use_portsData=false to neglect portsData and to not require its specification either in this case.
        // Remove portsData conditionally if use_portsData=false. Simplify their use in model equations by always
        // providing portsData_diameter and portsData_height, independend of the use_portsData setting.
        // Note: this moreover serves as work-around if a tool does not support a zero sized portsData record.
        Modelica.Blocks.Interfaces.RealInput[nPorts]
        portsData_diameter_internal =                                              portsData.diameter if use_portsData and nPorts > 0;
        Modelica.Blocks.Interfaces.RealInput[nPorts] portsData_height_internal = portsData.height if use_portsData and nPorts > 0;
        Modelica.Blocks.Interfaces.RealInput[nPorts] portsData_zeta_in_internal = portsData.zeta_in if use_portsData and nPorts > 0;
        Modelica.Blocks.Interfaces.RealInput[nPorts]
        portsData_zeta_out_internal =                                              portsData.zeta_out if use_portsData and nPorts > 0;
        Modelica.Blocks.Interfaces.RealInput[nPorts] portsData_diameter;
        Modelica.Blocks.Interfaces.RealInput[nPorts] portsData_height;
        Modelica.Blocks.Interfaces.RealInput[nPorts] portsData_zeta_in;
        Modelica.Blocks.Interfaces.RealInput[nPorts] portsData_zeta_out;

      equation
        mb_flow = sum(ports.m_flow);
        mbXi_flow = sum_ports_mXi_flow;
        mbC_flow  = sum_ports_mC_flow;
        Hb_flow = sum(ports_H_flow) + sum(ports_E_flow);
        Qb_flow = heatTransfer.Q_flows[1];

        // Only one connection allowed to a port to avoid unwanted ideal mixing
        for i in 1:nPorts loop
          assert(cardinality(ports[i]) <= 1,"
each ports[i] of volume can at most be connected to one component.
If two or more connections are present, ideal mixing takes
place with these connections, which is usually not the intention
of the modeller. Increase nPorts to add an additional port.
");
        end for;
        // Check for correct solution
        assert(fluidLevel <= fluidLevel_max, "Vessel is overflowing (fluidLevel > fluidLevel_max = " + String(fluidLevel) + ")");
        assert(fluidLevel > -1e-6*fluidLevel_max, "Fluid level (= " + String(fluidLevel) + ") is below zero meaning that the solution failed.");

        // Boundary conditions

        // treatment of conditional portsData
        connect(portsData_diameter, portsData_diameter_internal);
        connect(portsData_height, portsData_height_internal);
        connect(portsData_zeta_in, portsData_zeta_in_internal);
        connect(portsData_zeta_out, portsData_zeta_out_internal);
        if not use_portsData then
          portsData_diameter = zeros(nPorts);
          portsData_height = zeros(nPorts);
          portsData_zeta_in = zeros(nPorts);
          portsData_zeta_out = zeros(nPorts);
        end if;

        // actual definition of port variables
        for i in 1:nPorts loop
          if use_portsData then
            // dp = 0.5*zeta*d*v*|v|
            // Note: assume vessel_ps_static for portDensities to avoid algebraic loops for ports.p
            portDensities[i] = noEvent(Medium.density(Medium.setState_phX(vessel_ps_static[i], actualStream(ports[i].h_outflow), actualStream(ports[i].Xi_outflow))));
            portVelocities[i] = smooth(0, ports[i].m_flow/portAreas[i]/portDensities[i]);
            // Note: the penetration should not go too close to zero as this would prevent a vessel from running empty
            ports_penetration[i] = Utilities.regStep(fluidLevel - portsData_height[i] - 0.1*portsData_diameter[i], 1, 1e-3, 0.1*portsData_diameter[i]);
          else
            // an infinite port diameter is assumed
            portDensities[i] = medium.d;
            portVelocities[i] = 0;
            ports_penetration[i] = 1;
          end if;
          // fluid flow through ports
          if fluidLevel >= portsData_height[i] then
            // regular operation: fluidLevel is above ports[i]
            // Note: >= covers default values of zero as well
            if use_portsData then
              /* Without regularization
        ports[i].p = vessel_ps_static[i] + 0.5*ports[i].m_flow^2/portAreas[i]^2
                      * noEvent(if ports[i].m_flow>0 then zeta_in[i]/portDensities[i] else -zeta_out[i]/medium.d);
        */

              ports[i].p = vessel_ps_static[i] + (0.5/portAreas[i]^2*Utilities.regSquare2(ports[i].m_flow, m_flow_small,
                                           (portsData_zeta_in[i] - 1 + portAreas[i]^2/vesselArea^2)/portDensities[i]*ports_penetration[i],
                                           (portsData_zeta_out[i] + 1 - portAreas[i]^2/vesselArea^2)/medium.d/ports_penetration[i]));
              /*
        // alternative formulation m_flow=f(dp); not allowing the ideal portsData_zeta_in[i]=1 though
        ports[i].m_flow = smooth(2, portAreas[i]*Utilities.regRoot2(ports[i].p - vessel_ps_static[i], dp_small,
                                     2*portDensities[i]/portsData_zeta_in[i],
                                     2*medium.d/portsData_zeta_out[i]));
        */
            else
              ports[i].p = vessel_ps_static[i];
            end if;
            s[i] = fluidLevel - portsData_height[i];
          elseif s[i] > 0 or portsData_height[i] >= fluidLevel_max then
            // ports[i] is above fluidLevel and has inflow
            ports[i].p = vessel_ps_static[i];
            s[i] = ports[i].m_flow;
          else
            // ports[i] is above fluidLevel, preventing outflow
            ports[i].m_flow = 0;
            s[i] = (ports[i].p - vessel_ps_static[i])/Medium.p_default*(portsData_height[i] - fluidLevel);
          end if;

          ports[i].h_outflow  = medium.h;
          ports[i].Xi_outflow = medium.Xi;
          ports[i].C_outflow  = C;

          ports_H_flow[i] = ports[i].m_flow * actualStream(ports[i].h_outflow)
          "Enthalpy flow";
          ports_E_flow[i] = ports[i].m_flow*(0.5*portVelocities[i]*portVelocities[i] + system.g*portsData_height[i])
          "Flow of kinetic and potential energy";
          ports_mXi_flow[i,:] = ports[i].m_flow * actualStream(ports[i].Xi_outflow)
          "Component mass flow";
          ports_mC_flow[i,:]  = ports[i].m_flow * actualStream(ports[i].C_outflow)
          "Trace substance mass flow";
        end for;

        for i in 1:Medium.nXi loop
          sum_ports_mXi_flow[i] = sum(ports_mXi_flow[:,i]);
        end for;

        for i in 1:Medium.nC loop
          sum_ports_mC_flow[i]  = sum(ports_mC_flow[:,i]);
        end for;

        connect(heatPort, heatTransfer.heatPorts[1]) annotation (Line(
            points={{-100,0},{-87,0},{-87,8.88178e-016},{-74,8.88178e-016}},
            color={191,0,0},
            smooth=Smooth.None));
       annotation (
        Documentation(info="<html>
<p>
This base class extends PartialLumpedVolume with a vector of fluid ports and a replaceable wall HeatTransfer model.
<p>
The following modeling assumption are made:
<ul>
<li>homogenous medium, i.e. phase seperation is not taken into account,</li>
<li>no kinetic energy in the fluid, i.e. kinetic energy dissipates into the internal energy,</li>
<li>pressure loss definitions at vessel ports assume incompressible fluid,</li>
<li>outflow of ambient media is prevented at each port assuming check valve behavior.
    If <tt> fluidlevel &lt; portsData_height[i] </tt>and &nbsp; <tt> ports[i].p &lt; vessel_ps_static[i]</tt> massflow at the port is set to 0.</li>
</ul>
</p>
Each port has a (hydraulic) diameter and a height above the bottom of the vessel, which can be configured using the &nbsp;<b><tt>portsData</tt></b> record.
Alternatively the impact of port geometries can be neglected with <tt>use_portsData=false</tt>. This might be useful for early
design studies. Note that this means to assume an infinite port diameter at the bottom of the vessel.
Pressure drops and heights of the ports as well as kinetic and potential energy fluid entering or leaving the vessel are neglected then.
<p>
The following variables need to be defined by an extending model:
<ul>
<li><tt>input fluidVolume</tt>, the volume of the fluid in the vessel,</li>
<li><tt>vessel_ps_static[nPorts]</tt>, the static pressures inside the vessel at the height of the corresponding ports, at zero flow velocity, and</li>
<li><tt>Wb_flow</tt>, work term of the energy balance, e.g. p*der(V) if the volume is not constant or stirrer power.</li>
</ul>
An extending model should define:
<ul>
<li><tt>parameter vesselArea</tt> (default: Modelica.Constants.inf m2), the area of the vessel, to be related to cross flow areas of the ports for the consideration of dynamic pressure effects.</li>
</ul>
Optionally the fluid level may vary in the vessel, which effects the flow through the ports at configurable <tt>portsData_height[nPorts]</tt>.
This is why an extending model with varying fluid level needs to define:
<ul>
<li><tt>input fluidLevel (default: 0m)</tt>, the level the fluid in the vessel, and</li>
<li><tt>parameter fluidLevel_max (default: 1m)</tt>, the maximum level that must not be exceeded. Ports at or above fluidLevel_max can only receive inflow.</li>
</ul>
An extending model should not access the <tt>portsData</tt> record defined in the configuration dialog,
as an access to <tt>portsData</tt> may fail for <tt>use_portsData=false</tt> or <tt>nPorts=0</tt>.
Instead the predefined variables
<ul>
<li><tt>portsData_diameter[nPorts]</tt></li>,
<li><tt>portsData_height[nPorts]</tt></li>,
<li><tt>portsData_zeta_in[nPorts]</tt></li>, and
<li><tt>portsData_zeta_out[nPorts]</tt></li>
</ul>
should be used if these values are needed.
</p>
</html>",       revisions="<html>
<ul>
<li><i>Jan. 2009</i> by R&uuml;diger Franke: extended with
   <ul><li>portsData record and threat configurable port heights,</li>
       <li>consideration of kinetic and potential energy of fluid entering or leaving in energy balance</li>
   </ul>
</li>
<li><i>Dec. 2008</i> by R&uuml;diger Franke: derived from OpenTank, in order to make general use of configurable port diameters</i>
</ul>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),
                graphics),
          Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{-150,110},{150,150}},
              textString="%name",
              lineColor={0,0,255})}));

      end PartialLumpedVessel;

  package HeatTransfer "HeatTransfer models for vessels"

    partial model PartialVesselHeatTransfer
        "Base class for vessel heat transfer models"
      extends Modelica.Fluid.Interfaces.PartialHeatTransfer;

      annotation(Documentation(info="<html>
Base class for vessel heat transfer models.
</html>"),Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                  {100,100}}), graphics={Ellipse(
                extent={{-60,64},{60,-56}},
                lineColor={0,0,0},
                fillPattern=FillPattern.Sphere,
                fillColor={232,0,0}), Text(
                extent={{-38,26},{40,-14}},
                lineColor={0,0,0},
                textString="%name")}));
    end PartialVesselHeatTransfer;

    model IdealHeatTransfer
        "IdealHeatTransfer: Ideal heat transfer without thermal resistance"
      extends PartialVesselHeatTransfer;

    equation
      Ts = heatPorts.T;

      annotation(Documentation(info="<html>
Ideal heat transfer without thermal resistance.
</html>"));
    end IdealHeatTransfer;

    model ConstantHeatTransfer
        "ConstantHeatTransfer: Constant heat transfer coefficient"
      extends PartialVesselHeatTransfer;
      parameter SI.CoefficientOfHeatTransfer alpha0
          "constant heat transfer coefficient";

    equation
      Q_flows = {(alpha0+k)*surfaceAreas[i]*(heatPorts[i].T - Ts[i]) for i in 1:n};

      annotation(Documentation(info="<html>
Simple heat transfer correlation with constant heat transfer coefficient.
</html>"));
    end ConstantHeatTransfer;
    annotation (Documentation(info="<html>
Heat transfer correlations for pipe models
</html>"));

  end HeatTransfer;

    record VesselPortsData "Data to describe inlet/outlet ports at vessels:
    diameter -- Inner (hydraulic) diameter of inlet/outlet port
    height -- Height over the bottom of the vessel
    zeta_out -- Hydraulic resistance out of vessel, default 0.5 for small diameter mounted flush with the wall
    zeta_in -- Hydraulic resistance into vessel, default 1.04 for small diameter mounted flush with the wall"
          extends Modelica.Icons.Record;
      parameter SI.Diameter diameter
        "Inner (hydraulic) diameter of inlet/outlet port";
      parameter SI.Height height = 0 "Height over the bottom of the vessel";
      parameter Real zeta_out(min=0)=0.5
        "Hydraulic resistance out of vessel, default 0.5 for small diameter mounted flush with the wall";
      parameter Real zeta_in(min=0)=1.04
        "Hydraulic resistance into vessel, default 1.04 for small diameter mounted flush with the wall";
      annotation (preferredView="info", Documentation(info="<html>
<h4><font color=\"#008000\" >Vessel Port Data</font></h4>
<p>
This record describes the <b>ports</b> of a <b>vessel</b>. The variables in it are mostly self-explanatory (see list below); only the &zeta;
loss factors are discussed further. All data is quoted from Idelchik (1994).
</p>

<h4><font color=\"#008000\">Outlet Coefficients</font></h4>

<p>
If a <b>straight pipe with constant cross section is mounted flush with the wall</b>, its outlet pressure loss coefficient will be <code>&zeta; = 0.5</code> (Idelchik, p. 160, Diagram 3-1, paragraph 2).
</p>
<p>
If a <b>straight pipe with constant cross section is mounted into a vessel such that the entrance into it is at a distance</b> <code>b</code> from the wall (inside) the following table can be used. Herein, &delta; is the tube wall thickness (Idelchik, p. 160, Diagram 3-1, paragraph 1).
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Pressure loss coefficients for outlets, entrance at a distance from wall</caption>
  <tr>
    <td></td> <td>   </td><th colspan=\"5\" align=\"center\"> b / D_hyd  </th>
  </tr>
  <tr>
    <td></td> <td>   </td><th> 0.000 </th><th> 0.005 </th><th> 0.020 </th><th> 0.100 </th><th> 0.500-&#8734; </th>
  </tr>
  <tr>
     <th rowspan=\"5\" valign=\"middle\">&delta; / D_hyd</th> <th> 0.000 </th><td> 0.50 </td><td> 0.63  </td><td> 0.73  </td><td> 0.86  </td><td>      1.00     </td>
  </tr>
  <tr>
              <th> 0.008 </th><td> 0.50 </td><td> 0.55  </td><td> 0.62  </td><td> 0.74  </td><td>      0.88     </td>
  </tr>
  <tr>
              <th> 0.016 </th><td> 0.50 </td><td> 0.51  </td><td> 0.55  </td><td> 0.64  </td><td>      0.77     </td>
  </tr>
  <tr>
              <th> 0.024 </th><td> 0.50 </td><td> 0.50  </td><td> 0.52  </td><td> 0.58  </td><td>      0.68     </td>
  </tr>
  <tr>
              <th> 0.040 </th><td> 0.50 </td><td> 0.50  </td><td> 0.51  </td><td> 0.51  </td><td>      0.54     </td>
  </tr>
</table>

<p>
If a <b>straight pipe with a circular bellmouth inlet (collector) without baffle is mounted flush with the wall</b> then its pressure loss coefficient can be established from the following table. Herein, r is the radius of the bellmouth inlet surface (Idelchik, p. 164 f., Diagram 3-4, paragraph b)
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Pressure loss coefficients for outlets, bellmouth flush with wall</caption>
  <tr>
    <td></td> <th colspan=\"6\" align=\"center\"> r / D_hyd  </th>
  </tr>
  <tr>
    <td></td> <th> 0.01 </th><th> 0.03 </th><th> 0.05 </th><th> 0.08 </th><th> 0.16 </th><th>&ge;0.20</th>
  </tr>
  <tr>
     <th>&zeta;</th> <td> 0.44 </td><td> 0.31 </td><td> 0.22  </td><td> 0.15  </td><td> 0.06  </td><td>      0.03     </td>
  </tr>
</table>

<p>
If a <b>straight pipe with a circular bellmouth inlet (collector) without baffle is mounted at a distance from a wall</b> then its pressure loss coefficient can be established from the following table. Herein, r is the radius of the bellmouth inlet surface (Idelchik, p. 164 f., Diagram 3-4, paragraph a)
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Pressure loss coefficients for outlets, bellmouth at a distance of wall</caption>
  <tr>
    <td></td> <th colspan=\"6\" align=\"center\"> r / D_hyd  </th>
  </tr>
  <tr>
    <td></td> <th> 0.01 </th><th> 0.03 </th><th> 0.05 </th><th> 0.08 </th><th> 0.16 </th><th>&ge;0.20</th>
  </tr>
  <tr>
     <th>&zeta;</th> <td> 0.87 </td><td> 0.61 </td><td> 0.40  </td><td> 0.20  </td><td> 0.06  </td><td>      0.03     </td>
  </tr>
</table>



<h4><font color=\"#008000\">Inlet Coefficients</font></h4>

<p>
If a <b>straight pipe with constant circular cross section is mounted flush with the wall</b>, its vessel inlet pressure loss coefficient will be according to the following table (Idelchik, p. 209 f., Diagram 4-2 with <code>A_port/A_vessel = 0</code> and Idelchik, p. 640, Diagram 11-1, graph a). According to the text, <code>m = 9</code> is appropriate for fully developed turbulent flow.
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Pressure loss coefficients for inlets, circular tube flush with wall</caption>
  <tr>
    <td></td> <th colspan=\"6\" align=\"center\"> m  </th>
  </tr>
  <tr>
    <td></td> <th> 1.0 </th><th> 2.0 </th><th> 3.0 </th><th> 4.0 </th><th> 7.0 </th><th>9.0</th>
  </tr>
  <tr>
     <th>&zeta;</th> <td> 2.70 </td><td> 1.50 </td><td> 1.25  </td><td> 1.15  </td><td> 1.06  </td><td>      1.04     </td>
  </tr>
</table>

<p>
For larger port diameters, relative to the area of the vessel, the inlet pressure loss coefficient will be according to the following table (Idelchik, p. 209 f., Diagram 4-2 with <code>m = 7</code>).
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Pressure loss coefficients for inlets, circular tube flush with wall</caption>
  <tr>
    <td></td> <th colspan=\"6\" align=\"center\"> A_port / A_vessel  </th>
  </tr>
  <tr>
    <td></td> <th> 0.0 </th><th> 0.1 </th><th> 0.2 </th><th> 0.4 </th><th> 0.6 </th><th>0.8</th>
  </tr>
  <tr>
     <th>&zeta;</th> <td> 1.04 </td><td> 0.84 </td><td> 0.67  </td><td> 0.39  </td><td> 0.18  </td><td>      0.06     </td>
  </tr>
</table>


<h4><font color=\"#008000\">References</font></h4>

<dl><dt>Idelchik I.E. (1994):</dt>
    <dd><a href=\"http://www.bookfinder.com/dir/i/Handbook_of_Hydraulic_Resistance/0849399084/\"><b>Handbook
        of Hydraulic Resistance</b></a>. 3rd edition, Begell House, ISBN
        0-8493-9908-4</dd>
</dl>
</html>"));
    end VesselPortsData;

    connector VesselFluidPorts_a
      "Fluid connector with filled, large icon to be used for horizontally aligned vectors of FluidPorts (vector dimensions must be added after dragging)"
      extends Interfaces.FluidPort;
      annotation (defaultComponentName="ports_b",
                  Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-50,-200},{50,200}},
            grid={1,1},
            initialScale=0.2), graphics={
            Text(extent={{-75,130},{75,100}}, textString="%name"),
            Rectangle(extent={{-25,100},{25,-100}}, lineColor={0,0,0}),
            Ellipse(
              extent={{-22,100},{-10,-100}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-6,100},{6,-100}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{10,100},{22,-100}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid)}),
           Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-50,-200},{50,200}},
            grid={1,1},
            initialScale=0.2), graphics={
            Rectangle(
              extent={{-50,200},{50,-200}},
              lineColor={0,127,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-44,200},{-20,-200}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-12,200},{12,-200}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{20,200},{44,-200}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid)}));
    end VesselFluidPorts_a;

    connector VesselFluidPorts_b
      "Fluid connector with outlined, large icon to be used for horizontally aligned vectors of FluidPorts (vector dimensions must be added after dragging)"
      extends Interfaces.FluidPort;
      annotation (defaultComponentName="ports_b",
                  Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-50,-200},{50,200}},
            grid={1,1},
            initialScale=0.2), graphics={
            Text(extent={{-75,130},{75,100}}, textString="%name"),
            Rectangle(extent={{-25,100},{25,-100}}, lineColor={0,0,0}),
            Ellipse(
              extent={{-22,100},{-10,-100}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-20,-69},{-12,69}},
              lineColor={0,127,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-6,100},{6,-100}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{10,100},{22,-100}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-4,-69},{4,69}},
              lineColor={0,127,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{12,-69},{20,69}},
              lineColor={0,127,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
           Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-50,-200},{50,200}},
            grid={1,1},
            initialScale=0.2), graphics={
            Rectangle(
              extent={{-50,200},{50,-200}},
              lineColor={0,127,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-44,200},{-20,-200}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-12,200},{12,-200}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{20,200},{44,-200}},
              lineColor={0,0,0},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-39,-118.5},{-25,113}},
              lineColor={0,127,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-7,-118.5},{7,113}},
              lineColor={0,127,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{25,-117.5},{39,114}},
              lineColor={0,127,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
    end VesselFluidPorts_b;
  end BaseClasses;
  annotation (Documentation(info="<html>

</html>"));
end Vessels;
