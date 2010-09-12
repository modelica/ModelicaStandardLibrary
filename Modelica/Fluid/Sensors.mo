within Modelica.Fluid;
package Sensors
  "Ideal sensor components to extract signals from a fluid connector"
  extends Modelica.Icons.SensorsPackage;

  model Pressure "Ideal pressure sensor"
    extends Sensors.BaseClasses.PartialAbsoluteSensor;
    extends Modelica.Icons.RotationalSensor;
    Modelica.Blocks.Interfaces.RealOutput p(final quantity="Pressure",
                                            final unit="Pa",
                                            displayUnit="bar",
                                            min=0) "Pressure at port"
      annotation (Placement(transformation(extent={{100,-10},{120,10}},
            rotation=0)));
  equation
    p = port.p;
    annotation (
    Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
    Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{70,0},{100,0}}, color={0,0,127}),
          Line(points={{0,-70},{0,-100}}, color={0,127,255}),
          Text(
            extent={{-150,80},{150,120}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{151,-20},{57,-50}},
            lineColor={0,0,0},
            textString="p")}),
      Documentation(info="<HTML>
<p>
This component monitors the absolute pressure at its fluid port. The sensor is
ideal, i.e., it does not influence the fluid.
</p>
</HTML>
"));
  end Pressure;

  model Density "Ideal one port density sensor"
    extends Sensors.BaseClasses.PartialAbsoluteSensor;
    extends Modelica.Icons.RotationalSensor;
    Modelica.Blocks.Interfaces.RealOutput d(final quantity="Density",
                                            final unit="kg/m3",
                                            displayUnit="g/cm3",
                                            min=0) "Density in port medium"
      annotation (Placement(transformation(extent={{100,-10},{120,10}},
            rotation=0)));

  equation
    d = Medium.density(Medium.setState_phX(port.p, inStream(port.h_outflow), inStream(port.Xi_outflow)));
  annotation (defaultComponentName="density",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{0,-70},{0,-100}}, color={0,0,127}),
          Text(
            extent={{-150,80},{150,120}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{154,-31},{56,-61}},
            lineColor={0,0,0},
            textString="d"),
          Line(points={{70,0},{100,0}}, color={0,0,127})}),
    Documentation(info="<HTML>
<p>
This component monitors the density of the fluid passing its port.
The sensor is ideal, i.e., it does not influence the fluid.
</p>
<p>If using the one port sensor please read the <a href = Modelica.Fluid.Sensors>Information</a>  first.</p>

</HTML>
"));
  end Density;

  model DensityTwoPort "Ideal two port density sensor"
    extends Sensors.BaseClasses.PartialFlowSensor;
    extends Modelica.Icons.RotationalSensor;
    Modelica.Blocks.Interfaces.RealOutput d(final quantity="Density",
                                            final unit="kg/m3",
                                            displayUnit="g/cm3",
                                            min=0)
      "Density of the passing fluid"
      annotation (Placement(transformation(
          origin={0,110},
          extent={{10,-10},{-10,10}},
          rotation=270)));
    parameter Medium.MassFlowRate m_flow_small(min=0) = system.m_flow_small
      "For bi-directional flow, density is regularized in the region |m_flow| < m_flow_small (m_flow_small > 0 required)"
      annotation(Dialog(tab="Advanced"));
  protected
    Medium.Density rho_a_inflow "Density of inflowing fluid at port_a";
    Medium.Density rho_b_inflow
      "Density of inflowing fluid at port_b or rho_a_inflow, if uni-directional flow";
  equation
    if allowFlowReversal then
       rho_a_inflow = Medium.density(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
       rho_b_inflow = Medium.density(Medium.setState_phX(port_a.p, port_a.h_outflow, port_a.Xi_outflow));
       d = Modelica.Fluid.Utilities.regStep(port_a.m_flow, rho_a_inflow, rho_b_inflow, m_flow_small);
    else
       d = Medium.density(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
       rho_a_inflow = d;
       rho_b_inflow = d;
    end if;
  annotation (defaultComponentName="density",
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}},
          grid={1,1}),    graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}},
          grid={1,1}), graphics={
          Text(
            extent={{102,124},{6,95}},
            lineColor={0,0,0},
            textString="d"),
          Line(points={{0,100},{0,70}}, color={0,0,127}),
          Line(points={{-100,0},{-70,0}}, color={0,128,255}),
          Line(points={{70,0},{100,0}}, color={0,128,255})}),
    Documentation(info="<HTML>
<p>
This component monitors the density of the fluid flowing from port_a to port_b.
The sensor is ideal, i.e., it does not influence the fluid.
</p>
</HTML>
"));
  end DensityTwoPort;

  model Temperature "Ideal one port temperature sensor"
      extends Sensors.BaseClasses.PartialAbsoluteSensor;

    Modelica.Blocks.Interfaces.RealOutput T(final quantity="ThermodynamicTemperature",
                                            final unit = "K", displayUnit = "degC", min=0)
      "Temperature in port medium"
      annotation (Placement(transformation(extent={{60,-10},{80,10}}, rotation=
              0)));

  equation
    T = Medium.temperature(Medium.setState_phX(port.p, inStream(port.h_outflow), inStream(port.Xi_outflow)));
  annotation (defaultComponentName="temperature",
      Documentation(info="<HTML>
<p>
This component monitors the temperature of the fluid passing its port.
The sensor is ideal, i.e., it does not influence the fluid.
</p>
</HTML>
"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={
          Line(points={{0,-70},{0,-100}}, color={0,0,127}),
          Ellipse(
            extent={{-20,-98},{20,-60}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={191,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-12,40},{12,-68}},
            lineColor={191,0,0},
            fillColor={191,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-12,40},{-12,80},{-10,86},{-6,88},{0,90},{6,88},{10,86},{
                12,80},{12,40},{-12,40}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Line(
            points={{-12,40},{-12,-64}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{12,40},{12,-64}},
            color={0,0,0},
            thickness=0.5),
          Line(points={{-40,-20},{-12,-20}}, color={0,0,0}),
          Line(points={{-40,20},{-12,20}}, color={0,0,0}),
          Line(points={{-40,60},{-12,60}}, color={0,0,0}),
          Line(points={{12,0},{60,0}}, color={0,0,127})}),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Ellipse(
            extent={{-20,-88},{20,-50}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={191,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-12,50},{12,-58}},
            lineColor={191,0,0},
            fillColor={191,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-12,50},{-12,90},{-10,96},{-6,98},{0,100},{6,98},{10,96},{
                12,90},{12,50},{-12,50}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Line(
            points={{-12,50},{-12,-54}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{12,50},{12,-54}},
            color={0,0,0},
            thickness=0.5),
          Line(points={{-40,-10},{-12,-10}}, color={0,0,0}),
          Line(points={{-40,30},{-12,30}}, color={0,0,0}),
          Line(points={{-40,70},{-12,70}}, color={0,0,0}),
          Text(
            extent={{126,-30},{6,-60}},
            lineColor={0,0,0},
            textString="T"),
          Text(
            extent={{-150,110},{150,150}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{12,0},{60,0}}, color={0,0,127})}));
  end Temperature;

  model TemperatureTwoPort "Ideal two port temperature sensor"
    extends Sensors.BaseClasses.PartialFlowSensor;

    Modelica.Blocks.Interfaces.RealOutput T( final quantity="ThermodynamicTemperature",
                                             final unit="K",
                                             min = 0,
                                             displayUnit="degC")
      "Temperature of the passing fluid"
      annotation (Placement(transformation(
          origin={0,110},
          extent={{10,-10},{-10,10}},
          rotation=270)));
    parameter Medium.MassFlowRate m_flow_small(min=0) = system.m_flow_small
      "For bi-directional flow, temperature is regularized in the region |m_flow| < m_flow_small (m_flow_small > 0 required)"
      annotation(Dialog(tab="Advanced"));

  protected
    Medium.Temperature T_a_inflow "Temperature of inflowing fluid at port_a";
    Medium.Temperature T_b_inflow
      "Temperature of inflowing fluid at port_b or T_a_inflow, if uni-directional flow";
  equation
    if allowFlowReversal then
       T_a_inflow = Medium.temperature(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
       T_b_inflow = Medium.temperature(Medium.setState_phX(port_a.p, port_a.h_outflow, port_a.Xi_outflow));
       T = Modelica.Fluid.Utilities.regStep(port_a.m_flow, T_a_inflow, T_b_inflow, m_flow_small);
    else
       T = Medium.temperature(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
       T_a_inflow = T;
       T_b_inflow = T;
    end if;
  annotation (defaultComponentName="temperature",
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}},
          grid={1,1}),
            graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}},
          grid={1,1}), graphics={
          Line(points={{0,100},{0,50}}, color={0,0,127}),
          Line(points={{-92,0},{100,0}}, color={0,128,255}),
          Ellipse(
            extent={{-20,-68},{20,-30}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={191,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-12,50},{12,-34}},
            lineColor={191,0,0},
            fillColor={191,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-12,50},{-12,70},{-10,76},{-6,78},{0,80},{6,78},{10,76},{
                12,70},{12,50},{-12,50}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Line(
            points={{-12,50},{-12,-35}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{12,50},{12,-34}},
            color={0,0,0},
            thickness=0.5),
          Line(points={{-40,-10},{-12,-10}}, color={0,0,0}),
          Line(points={{-40,20},{-12,20}}, color={0,0,0}),
          Line(points={{-40,50},{-12,50}}, color={0,0,0}),
          Text(
            extent={{94,122},{0,92}},
            lineColor={0,0,0},
            textString="T")}),
    Documentation(info="<HTML>
<p>
This component monitors the temperature of the passing fluid.
The sensor is ideal, i.e., it does not influence the fluid.
</p>
</HTML>
"));
  end TemperatureTwoPort;

  model SpecificEnthalpy "Ideal one port specific enthalpy sensor"
    extends Sensors.BaseClasses.PartialAbsoluteSensor;
    extends Modelica.Icons.RotationalSensor;
    Modelica.Blocks.Interfaces.RealOutput h_out(final quantity="SpecificEnergy",
                                                final unit="J/kg")
      "Specific enthalpy in port medium"
      annotation (Placement(transformation(extent={{100,-10},{120,10}},
            rotation=0)));

  equation
    h_out = inStream(port.h_outflow);
  annotation (defaultComponentName="specificEnthalpy",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{0,-70},{0,-100}}, color={0,0,127}),
          Text(
            extent={{-150,80},{150,120}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{168,-30},{52,-60}},
            lineColor={0,0,0},
            textString="h"),
          Line(points={{70,0},{100,0}}, color={0,0,127})}),
    Documentation(info="<HTML>
<p>
This component monitors the specific enthalpy of the fluid passing its port.
The sensor is ideal, i.e., it does not influence the fluid.
</p>
</HTML>
"));
  end SpecificEnthalpy;

  model SpecificEnthalpyTwoPort
    "Ideal two port sensor for the specific enthalpy"
    extends Sensors.BaseClasses.PartialFlowSensor;
    extends Modelica.Icons.RotationalSensor;
    Modelica.Blocks.Interfaces.RealOutput h_out(final quantity="SpecificEnergy",
                                                final unit="J/kg")
      "Specific enthalpy of the passing fluid"
      annotation (Placement(transformation(
          origin={0,110},
          extent={{10,-10},{-10,10}},
          rotation=270)));

    parameter Medium.MassFlowRate m_flow_small(min=0) = system.m_flow_small
      "For bi-directional flow, specific enthalpy is regularized in the region |m_flow| < m_flow_small (m_flow_small > 0 required)"
      annotation(Dialog(tab="Advanced"));

  equation
    if allowFlowReversal then
       h_out = Modelica.Fluid.Utilities.regStep(port_a.m_flow, port_b.h_outflow, port_a.h_outflow, m_flow_small);
    else
       h_out = port_b.h_outflow;
    end if;
  annotation (defaultComponentName="specificEnthalpy",
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            extent={{102,120},{0,90}},
            lineColor={0,0,0},
            textString="h"),
          Line(points={{0,100},{0,70}}, color={0,0,127}),
          Line(points={{-100,0},{-70,0}}, color={0,128,255}),
          Line(points={{70,0},{100,0}}, color={0,128,255})}),
    Documentation(info="<HTML>
<p>
This component monitors the specific enthalpy of a passing fluid.
The sensor is ideal, i.e., it does not influence the fluid.
</p>
</HTML>
"));
  end SpecificEnthalpyTwoPort;

  model SpecificEntropy "Ideal one port specific entropy sensor"
    extends Sensors.BaseClasses.PartialAbsoluteSensor;
    extends Modelica.Icons.RotationalSensor;
    Modelica.Blocks.Interfaces.RealOutput s(final quantity="SpecificEntropy",
                                            final unit="J/(kg.K)")
      "Specific entropy in port medium"
      annotation (Placement(transformation(extent={{100,-10},{120,10}},
            rotation=0)));

  equation
    s = Medium.specificEntropy(Medium.setState_phX(port.p, inStream(port.h_outflow), inStream(port.Xi_outflow)));
  annotation (defaultComponentName="specificEntropy",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{0,-70},{0,-100}}, color={0,0,127}),
          Text(
            extent={{-150,80},{150,120}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{156,-24},{54,-54}},
            lineColor={0,0,0},
            textString="s"),
          Line(points={{70,0},{100,0}}, color={0,0,127})}),
    Documentation(info="<HTML>
<p>
This component monitors the specific entropy of the fluid passing its port.
The sensor is ideal, i.e., it does not influence the fluid.
</p>
</HTML>
"));
  end SpecificEntropy;

  model SpecificEntropyTwoPort "Ideal two port sensor for the specific entropy"
    extends Sensors.BaseClasses.PartialFlowSensor;
    extends Modelica.Icons.RotationalSensor;
    Modelica.Blocks.Interfaces.RealOutput s(final quantity="SpecificEntropy",
                                            final unit="J/(kg.K)")
      "Specific entropy of the passing fluid"
      annotation (Placement(transformation(
          origin={0,110},
          extent={{10,-10},{-10,10}},
          rotation=270)));
    parameter Medium.MassFlowRate m_flow_small(min=0) = system.m_flow_small
      "For bi-directional flow, specific entropy is regularized in the region |m_flow| < m_flow_small (m_flow_small > 0 required)"
      annotation(Dialog(tab="Advanced"));

  protected
    Medium.SpecificEntropy s_a_inflow
      "Specific entropy of inflowing fluid at port_a";
    Medium.SpecificEntropy s_b_inflow
      "Specific entropy of inflowing fluid at port_b or s_a_inflow, if uni-directional flow";
  equation
    if allowFlowReversal then
       s_a_inflow = Medium.specificEntropy(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
       s_b_inflow = Medium.specificEntropy(Medium.setState_phX(port_a.p, port_a.h_outflow, port_a.Xi_outflow));
       s = Modelica.Fluid.Utilities.regStep(port_a.m_flow, s_a_inflow, s_b_inflow, m_flow_small);
    else
       s = Medium.specificEntropy(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
       s_a_inflow = s;
       s_b_inflow = s;
    end if;
  annotation (defaultComponentName="specificEntropy",
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            extent={{120,120},{0,90}},
            lineColor={0,0,0},
            textString="s"),
          Line(points={{0,100},{0,70}}, color={0,0,127}),
          Line(points={{-100,0},{-70,0}}, color={0,128,255}),
          Line(points={{70,0},{100,0}}, color={0,128,255})}),
    Documentation(info="<HTML>
<p>
This component monitors the specific entropy of the passing fluid.
The sensor is ideal, i.e., it does not influence the fluid.
</p>
</HTML>
"));
  end SpecificEntropyTwoPort;

  model TraceSubstances "Ideal one port trace substances sensor"
    extends Sensors.BaseClasses.PartialAbsoluteSensor;
    extends Modelica.Icons.RotationalSensor;
    parameter String substanceName = "CO2" "Name of trace substance";

    Modelica.Blocks.Interfaces.RealOutput C "Trace substance in port medium"
      annotation (Placement(transformation(extent={{100,-10},{120,10}},
            rotation=0)));

  protected
    parameter Integer ind(fixed=false)
      "Index of species in vector of auxiliary substances";
    Medium.ExtraProperty CVec[Medium.nC](
        quantity=Medium.extraPropertiesNames)
      "Trace substances vector, needed because indexed argument for the operator inStream is not supported";
  initial algorithm
    ind:= -1;
    for i in 1:Medium.nC loop
      if ( Modelica.Utilities.Strings.isEqual(Medium.extraPropertiesNames[i], substanceName)) then
        ind := i;
      end if;
    end for;
    assert(ind > 0, "Trace substance '" + substanceName + "' is not present in medium '"
           + Medium.mediumName + "'.\n"
           + "Check sensor parameter and medium model.");
  equation
    CVec = inStream(port.C_outflow);
    C = CVec[ind];
  annotation (defaultComponentName="traceSubstance",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{0,-70},{0,-100}}, color={0,0,127}),
          Text(
            extent={{-150,80},{150,120}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{160,-30},{60,-60}},
            lineColor={0,0,0},
            textString="C"),
          Line(points={{70,0},{100,0}}, color={0,0,127})}),
    Documentation(info="<HTML>
<p>
This component monitors the trace substances contained in the fluid passing its port.
The sensor is ideal, i.e., it does not influence the fluid.
</p>
</HTML>
"));
  end TraceSubstances;

  model TraceSubstancesTwoPort "Ideal two port sensor for trace substance"
    extends Sensors.BaseClasses.PartialFlowSensor;
    extends Modelica.Icons.RotationalSensor;
    Modelica.Blocks.Interfaces.RealOutput C
      "Trace substance of the passing fluid"
      annotation (Placement(transformation(
          origin={0,110},
          extent={{10,-10},{-10,10}},
          rotation=270)));
    parameter String substanceName = "CO2" "Name of trace substance";
    parameter Medium.MassFlowRate m_flow_small(min=0) = system.m_flow_small
      "For bi-directional flow, trace substance is regularized in the region |m_flow| < m_flow_small (m_flow_small > 0 required)"
      annotation(Dialog(tab="Advanced"));

  protected
    parameter Integer ind(fixed=false)
      "Index of species in vector of auxiliary substances";
  initial algorithm
    ind:= -1;
    for i in 1:Medium.nC loop
      if ( Modelica.Utilities.Strings.isEqual(Medium.extraPropertiesNames[i], substanceName)) then
        ind := i;
      end if;
    end for;
    assert(ind > 0, "Trace substance '" + substanceName + "' is not present in medium '"
           + Medium.mediumName + "'.\n"
           + "Check sensor parameter and medium model.");
  equation
    if allowFlowReversal then
       C = Modelica.Fluid.Utilities.regStep(port_a.m_flow, port_b.C_outflow[ind], port_a.C_outflow[ind], m_flow_small);
    else
       C = port_b.C_outflow[ind];
    end if;
  annotation (defaultComponentName="traceSubstance",
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            extent={{82,122},{0,92}},
            lineColor={0,0,0},
            textString="C"),
          Line(points={{0,100},{0,70}}, color={0,0,127}),
          Line(points={{-100,0},{-70,0}}, color={0,128,255}),
          Line(points={{70,0},{100,0}}, color={0,128,255})}),
    Documentation(info="<HTML>
<p>
This component monitors the trace substance of the passing fluid.
The sensor is ideal, i.e., it does not influence the fluid.
</p>
</HTML>
"));
  end TraceSubstancesTwoPort;

  model MassFlowRate "Ideal sensor for mass flow rate"
    extends Sensors.BaseClasses.PartialFlowSensor;
    extends Modelica.Icons.RotationalSensor;
    Modelica.Blocks.Interfaces.RealOutput m_flow(quantity="MassFlowRate",
                                                 final unit="kg/s")
      "Mass flow rate from port_a to port_b" annotation (Placement(
          transformation(
          origin={0,110},
          extent={{10,-10},{-10,10}},
          rotation=270)));

  equation
    m_flow = port_a.m_flow;
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{70,0},{100,0}}, color={0,128,255}),
          Text(
            extent={{162,120},{2,90}},
            lineColor={0,0,0},
            textString="m_flow"),
          Line(points={{0,100},{0,70}}, color={0,0,127}),
          Line(points={{-100,0},{-70,0}}, color={0,128,255})}),
    Documentation(info="<HTML>
<p>
This component monitors the mass flow rate flowing from port_a to port_b.
The sensor is ideal, i.e., it does not influence the fluid.
</p>
</HTML>
"));
  end MassFlowRate;

  model VolumeFlowRate "Ideal sensor for volume flow rate"
    extends Sensors.BaseClasses.PartialFlowSensor;
    extends Modelica.Icons.RotationalSensor;
    Modelica.Blocks.Interfaces.RealOutput V_flow(final quantity="VolumeFlowRate",
                                                 final unit="m3/s")
      "Volume flow rate from port_a to port_b"
      annotation (Placement(transformation(
          origin={0,110},
          extent={{10,-10},{-10,10}},
          rotation=270)));
    parameter Medium.MassFlowRate m_flow_small(min=0) = system.m_flow_small
      "For bi-directional flow, density is regularized in the region |m_flow| < m_flow_small (m_flow_small > 0 required)"
      annotation(Dialog(tab="Advanced"));

  protected
    Medium.Density rho_a_inflow "Density of inflowing fluid at port_a";
    Medium.Density rho_b_inflow
      "Density of inflowing fluid at port_b or rho_a_inflow, if uni-directional flow";
    Medium.Density d "Density of the passing fluid";
  equation
    if allowFlowReversal then
       rho_a_inflow = Medium.density(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
       rho_b_inflow = Medium.density(Medium.setState_phX(port_a.p, port_a.h_outflow, port_a.Xi_outflow));
       d = Modelica.Fluid.Utilities.regStep(port_a.m_flow, rho_a_inflow, rho_b_inflow, m_flow_small);
    else
       d = Medium.density(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow));
       rho_a_inflow = d;
       rho_b_inflow = d;
    end if;
    V_flow = port_a.m_flow/d;
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            extent={{160,120},{0,90}},
            lineColor={0,0,0},
            textString="V_flow"),
          Line(points={{0,100},{0,70}}, color={0,0,127}),
          Line(points={{-100,0},{-70,0}}, color={0,128,255}),
          Line(points={{70,0},{100,0}}, color={0,128,255})}),
    Documentation(info="<HTML>
<p>
This component monitors the volume flow rate flowing from port_a to port_b.
The sensor is ideal, i.e., it does not influence the fluid.
</p>
</HTML>
"));
  end VolumeFlowRate;

  model RelativePressure "Ideal relative pressure sensor"
    extends Modelica.Icons.TranslationalSensor;
    replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the sensor"  annotation (
        choicesAllMatching = true);

    Modelica.Fluid.Interfaces.FluidPort_a port_a(m_flow(min=0),
                                  redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
            rotation=0)));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(m_flow(min=0),
                                  redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{110,-12},{90,8}}, rotation=
              0), iconTransformation(extent={{110,-10},{90,10}})));

    Modelica.Blocks.Interfaces.RealOutput p_rel(final quantity="Pressure",
                                                final unit="Pa",
                                                displayUnit="bar")
      "Relative pressure signal" annotation (Placement(transformation(
          origin={0,-90},
          extent={{10,-10},{-10,10}},
          rotation=90)));
  equation
    // Zero flow equations for connectors
    port_a.m_flow = 0;
    port_b.m_flow = 0;

    // No contribution of specific quantities
    port_a.h_outflow = 0;
    port_b.h_outflow = 0;
    port_a.Xi_outflow = zeros(Medium.nXi);
    port_b.Xi_outflow = zeros(Medium.nXi);
    port_a.C_outflow  = zeros(Medium.nC);
    port_b.C_outflow  = zeros(Medium.nC);

    // Relative pressure
    p_rel = port_a.p - port_b.p;
    annotation (
      Icon(graphics={
          Line(points={{-100,0},{-70,0}}, color={0,127,255}),
          Line(points={{70,0},{100,0}}, color={0,127,255}),
          Line(points={{0,-30},{0,-80}}, color={0,0,127}),
          Text(
            extent={{-150,40},{150,80}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{130,-70},{4,-100}},
            lineColor={0,0,0},
            textString="p_rel"),
          Line(
            points={{32,3},{-58,3}},
            color={0,128,255},
            smooth=Smooth.None),
          Polygon(
            points={{22,18},{62,3},{22,-12},{22,18}},
            lineColor={0,128,255},
            smooth=Smooth.None,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<HTML>
<p>
The relative pressure \"port_a.p - port_b.p\" is determined between
the two ports of this component and is provided as output signal. The
sensor should be connected in parallel with other equipment, no flow
through the sensor is allowed.
</p>
</HTML>
"));
  end RelativePressure;

  model RelativeTemperature "Ideal relative temperature sensor"
    extends Modelica.Icons.TranslationalSensor;
    replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the sensor"  annotation (
        choicesAllMatching = true);
    Modelica.Fluid.Interfaces.FluidPort_a port_a(m_flow(min=0),
                                  redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
            rotation=0)));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(m_flow(min=0),
                                  redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{110,-10},{90,10}}, rotation=
             0)));

    Modelica.Blocks.Interfaces.RealOutput T_rel(final quantity="ThermodynamicTemperature",
                                                final unit = "K", displayUnit = "degC", min=0)
      "Relative temperature signal"                                                                               annotation (Placement(
          transformation(
          origin={0,-90},
          extent={{10,-10},{-10,10}},
          rotation=90)));
  equation
    // Zero flow equations for connectors
    port_a.m_flow = 0;
    port_b.m_flow = 0;

    // No contribution of specific quantities
    port_a.h_outflow = 0;
    port_b.h_outflow = 0;
    port_a.Xi_outflow = zeros(Medium.nXi);
    port_b.Xi_outflow = zeros(Medium.nXi);
    port_a.C_outflow  = zeros(Medium.nC);
    port_b.C_outflow  = zeros(Medium.nC);

    // Relative temperature
    T_rel = Medium.temperature(Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow))) -
            Medium.temperature(Medium.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow)));
    annotation (
      Icon(graphics={
          Line(points={{-100,0},{-70,0}}, color={0,127,255}),
          Line(points={{70,0},{100,0}}, color={0,127,255}),
          Line(points={{0,-30},{0,-80}}, color={0,0,127}),
          Text(
            extent={{-150,40},{150,80}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{128,-70},{10,-100}},
            lineColor={0,0,0},
            textString="T_rel"),
          Line(
            points={{34,3},{-56,3}},
            color={0,128,255},
            smooth=Smooth.None),
          Polygon(
            points={{24,18},{64,3},{24,-12},{24,18}},
            lineColor={0,128,255},
            smooth=Smooth.None,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<HTML>
<p>
The relative temperature \"T(port_a) - T(port_b)\" is determined between
the two ports of this component and is provided as output signal. The
sensor should be connected in parallel with other equipment, no flow
through the sensor is allowed.
</p>
</HTML>
"));
  end RelativeTemperature;

/*
  model SpecificInternalEnergy "Ideal specific internal energy sensor"
    extends BaseClasses.Sensors.PartialSensor;
    extends Modelica.Icons.RotationalSensor;
    Medium.BaseProperties medium;
    Modelica.Blocks.Interfaces.RealOutput u(unit = "J/kg")
      "Specific internal energy in port medium" annotation (extent=[100,-10; 120,10]);

  annotation (
    Documentation(info="<HTML>
<p>
This component monitors the specific internal energy of the medium in the fluid port. The sensor is
ideal, i.e., it does not influence the fluid.
</p>
</HTML>
"));
  equation
    port.p   = medium.p;
    port.h   = medium.h;
    port.Xi = medium.Xi;
    u = medium.u;
  end SpecificInternalEnergy;

  model RelDensity "Ideal relative density sensor"
    extends Interfaces.PartialRelativeSensor;
    extends Modelica.Icons.TranslationalSensor;
    Medium.BaseProperties medium_a;
    Medium.BaseProperties medium_b;
    Modelica.Blocks.Interfaces.RealOutput rho_rel(redeclare type SignalType =
          SI.Density) "Relative density signal" annotation (extent=[-10, -80; 10, -100], rotation=90);
    annotation (
      Documentation(info="<HTML>
<p>
The relative density \"d(port_a) - d(port_b)\" is determined between
the two ports of this component and is provided as output signal.
</p>
</HTML>
"));
  equation
    port_a.p   = medium_a.p;
    port_a.h   = medium_a.h;
    port_a.Xi = medium_a.Xi;
    port_b.p   = medium_b.p;
    port_b.h   = medium_b.h;
    port_b.Xi = medium_b.Xi;

    rho_rel = medium_a.d - medium_b.d;
  end RelDensity;

  model RelTemperature "Ideal relative temperature sensor"
    extends Interfaces.PartialRelativeSensor;
    extends Modelica.Icons.TranslationalSensor;
    Medium.BaseProperties medium_a;
    Medium.BaseProperties medium_b;
    Modelica.Blocks.Interfaces.RealOutput T_rel(redeclare type SignalType =
          SI.Temperature) "Relative temperature signal" annotation (extent=[-10, -80; 10, -100], rotation=90);
    annotation (
      Documentation(info="<HTML>
<p>
The relative temperature \"T(port_a) - T(port_b)\" is determined between
the two ports of this component and is provided as output signal.
</p>
</HTML>
"));
  equation
    port_a.p   = medium_a.p;
    port_a.h   = medium_a.h;
    port_a.Xi = medium_a.Xi;
    port_b.p   = medium_b.p;
    port_b.h   = medium_b.h;
    port_b.Xi = medium_b.Xi;

    T_rel = medium_a.T - medium_b.T;
  end RelTemperature;

  model RelSpecificEnthalpy "Ideal relative specific enthalpy sensor"
    extends Interfaces.PartialRelativeSensor;
    extends Modelica.Icons.TranslationalSensor;
    Modelica.Blocks.Interfaces.RealOutput h_rel(redeclare type SignalType =
          SI.SpecificEnthalpy) "Relative specific enthalpy signal" annotation (extent=[-10, -80; 10, -100], rotation=90);
    annotation (
      Documentation(info="<HTML>
<p>
The relative specific enthalpy \"port_a.h - port_b.h\" is determined between
the two ports of this component and is provided as output signal.
</p>
</HTML>
"));
  equation
    h_rel = port_a.h - port_b.h;
  end RelSpecificEnthalpy;

  model RelSpecificInternalEnergy
    "Ideal relative specific internal energy sensor"
    extends Interfaces.PartialRelativeSensor;
    extends Modelica.Icons.TranslationalSensor;
    Medium.BaseProperties medium_a;
    Medium.BaseProperties medium_b;
    Modelica.Blocks.Interfaces.RealOutput u_rel(redeclare type SignalType =
          SI.SpecificEnergy) "Relative specific internal energy signal" annotation (extent=[-10, -80; 10, -100], rotation=90);
    annotation (
      Documentation(info="<HTML>
<p>
The relative specific internal energy \"u(port_a) - u(port_b)\" is determined between
the two ports of this component and is provided as output signal.
</p>
</HTML>
"));
  equation
    port_a.p   = medium_a.p;
    port_a.h   = medium_a.h;
    port_a.Xi = medium_a.Xi;
    port_b.p   = medium_b.p;
    port_b.h   = medium_b.h;
    port_b.Xi = medium_b.Xi;

    u_rel = medium_a.u - medium_b.u;
  end RelSpecificInternalEnergy;
*/

  package BaseClasses
    "Base classes used in the Sensors package (only of interest to build new component models)"
    extends Modelica.Icons.BasesPackage;

    partial model PartialAbsoluteSensor
      "Partial component to model a sensor that measures a potential variable"

      replaceable package Medium=Modelica.Media.Interfaces.PartialMedium
        "Medium in the sensor"
        annotation(choicesAllMatching=true);

      Modelica.Fluid.Interfaces.FluidPort_a port(redeclare package Medium=Medium, m_flow(min=0))
        annotation (Placement(transformation(
            origin={0,-100},
            extent={{-10,-10},{10,10}},
            rotation=90)));

    equation
      port.m_flow = 0;
      port.h_outflow = 0;
      port.Xi_outflow = zeros(Medium.nXi);
      port.C_outflow = zeros(Medium.nC);
      annotation (Documentation(info="<html>
<p>
Partial component to model an <b>absolute sensor</b>. Can be used for pressure sensor models.
Use for other properties such as temperature or density is discouraged, because the enthalpy at the connector can have different meanings, depending on the connection topology. Use <code>PartialFlowSensor</code> instead.
as signal.
</p>
</html>"),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics));
    end PartialAbsoluteSensor;

    partial model PartialFlowSensor
      "Partial component to model sensors that measure flow properties"
      extends Modelica.Fluid.Interfaces.PartialTwoPort;

    equation
      // mass balance
      0 = port_a.m_flow + port_b.m_flow;

      // momentum equation (no pressure loss)
      port_a.p = port_b.p;

      // isenthalpic state transformation (no storage and no loss of energy)
      port_a.h_outflow = inStream(port_b.h_outflow);
      port_b.h_outflow = inStream(port_a.h_outflow);

      port_a.Xi_outflow = inStream(port_b.Xi_outflow);
      port_b.Xi_outflow = inStream(port_a.Xi_outflow);

      port_a.C_outflow = inStream(port_b.C_outflow);
      port_b.C_outflow = inStream(port_a.C_outflow);
      annotation (Documentation(info="<html>
<p>
Partial component to model a <b>sensor</b> that measures any intensive properties
of a flow, e.g., to get temperature or density in the flow
between fluid connectors.<br>
The model includes zero-volume balance equations. Sensor models inheriting from
this partial class should add a medium instance to calculate the measured property.
</p>
</html>"),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics));
    end PartialFlowSensor;

  end BaseClasses;
  annotation (preferedView="info", Documentation(info="<html>
<p align = justify>
Package <b>Sensors</b> consists of idealized sensor components that
provide variables of a medium model and/or fluid ports as
output signals. These signals can be, e.g., further processed
with components of the Modelica.Blocks library.
Also more realistic sensor models can be built, by further
processing (e.g., by attaching block Modelica.Blocks.FirstOrder to
model the time constant of the sensor).
</p>

<p align = justify>For the thermodynamic state variables temperature, specific entalpy, specific entropy and density
the fluid library provides two different types of sensors: <b>regular one port</b> and <b>two port</b> sensors.</p>

<ul>
<li>
The <b>regular one port</b> sensors have the advantage of easy introduction and removal from a model, as no connections have to be broken.
A potential drawback is that the obtained value jumps as flow reverts.
</li>

<li> The <b>two port</b> sensors offer the advantages of an adjustable regularized step function around zero flow.
Moreover the obtained result is restricted to the value flowing into port_a if allowFlowReversal is false.</li>
</ul>

<p>
<a href=\"modelica://Modelica.Fluid.Examples.Explanatory.MeasuringTemperature\">Modelica.Fluid.Examples.Explanatory.MeasuringTemperature</a>
demonstrates the differences between one- and two-port sensor at hand of a
simple example.
</p>

</html>
",    revisions="<html>
<ul>
<li><i>22 Dec 2008</i>
    by R;uumldiger Franke<br>
    <ul>
    <li>flow sensors based on Interfaces.PartialTwoPort</li>
    <li>adapted docu to stream connectors, i.e., less need for two port sensors</li>
    </ul>
<li><i>4 Dec 2008</i>
    by Michael Wetter<br>
       included sensors for trace substance</li>
<li><i>31 Oct 2007</i>
    by Carsten Heinrich<br>
       updated sensor models, included one and two port sensors for thermodynamic state variables</li>
</ul>
</html>"));
end Sensors;
