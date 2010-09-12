within Modelica.Fluid;
package Sources "Define fixed or prescribed boundary conditions"
  extends Modelica.Icons.SourcesPackage;
  model FixedBoundary "Boundary source component"
    extends Sources.BaseClasses.PartialSource;
    parameter Boolean use_p=true "select p or d"
      annotation (Evaluate = true,
                  Dialog(group = "Boundary pressure or Boundary density"));
    parameter Medium.AbsolutePressure p=Medium.p_default "Boundary pressure"
      annotation (Dialog(group = "Boundary pressure or Boundary density",
                         enable = use_p));
    parameter Medium.Density d=Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default)
      "Boundary density"
      annotation (Dialog(group = "Boundary pressure or Boundary density",
                         enable=not use_p));
    parameter Boolean use_T=true "select T or h"
      annotation (Evaluate = true,
                  Dialog(group = "Boundary temperature or Boundary specific enthalpy"));
    parameter Medium.Temperature T=Medium.T_default "Boundary temperature"
      annotation (Dialog(group = "Boundary temperature or Boundary specific enthalpy",
                         enable = use_T));
    parameter Medium.SpecificEnthalpy h=Medium.h_default
      "Boundary specific enthalpy"
      annotation (Dialog(group="Boundary temperature or Boundary specific enthalpy",
                  enable = not use_T));
    parameter Medium.MassFraction X[Medium.nX](
         quantity=Medium.substanceNames)=Medium.X_default
      "Boundary mass fractions m_i/m"
      annotation (Dialog(group = "Only for multi-substance flow", enable=Medium.nXi > 0));

    parameter Medium.ExtraProperty C[Medium.nC](
         quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
      "Boundary trace substances"
      annotation (Dialog(group = "Only for trace-substance flow", enable=Medium.nC > 0));

  equation
    Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames,
                                          Medium.singleState, use_p, X,
                                          "FixedBoundary");
    if use_p or Medium.singleState then
      medium.p = p;
    else
      medium.d = d;
    end if;
    if use_T then
      medium.T = T;
    else
      medium.h = h;
    end if;

    medium.Xi = X[1:Medium.nXi];

    ports.C_outflow = fill(C, nPorts);
    annotation (defaultComponentName="boundary",
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={0,127,255}), Text(
            extent={{-150,110},{150,150}},
            textString="%name",
            lineColor={0,0,255})}),
      Documentation(info="<html>
<p>
Model <b>FixedBoundary</b> defines constant values for boundary conditions:
</p>
<ul>
<li> Boundary pressure or boundary density.</li>
<li> Boundary temperature or boundary specific enthalpy.</li>
<li> Boundary composition (only for multi-substance or trace-substance flow).</li>
</ul>
<p>
Note, that boundary temperature, density, specific enthalpy,
mass fractions and trace substances have only an effect if the mass flow
is from the Boundary into the port. If mass is flowing from
the port into the boundary, the boundary definitions,
with exception of boundary pressure, do not have an effect.
</p>
</html>"));
  end FixedBoundary;

  model Boundary_pT
    "Boundary with prescribed pressure, temperature, composition and trace substances"
    extends Sources.BaseClasses.PartialSource;
    parameter Boolean use_p_in = false
      "Get the pressure from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_T_in= false
      "Get the temperature from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_X_in = false
      "Get the composition from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_C_in = false
      "Get the trace substances from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Medium.AbsolutePressure p = Medium.p_default
      "Fixed value of pressure"
      annotation (Evaluate = true,
                  Dialog(enable = not use_p_in));
    parameter Medium.Temperature T = Medium.T_default
      "Fixed value of temperature"
      annotation (Evaluate = true,
                  Dialog(enable = not use_T_in));
    parameter Medium.MassFraction X[Medium.nX] = Medium.X_default
      "Fixed value of composition"
      annotation (Evaluate = true,
                  Dialog(enable = (not use_X_in) and Medium.nXi > 0));
    parameter Medium.ExtraProperty C[Medium.nC](
         quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
      "Fixed values of trace substances"
      annotation (Evaluate=true,
                  Dialog(enable = (not use_C_in) and Medium.nC > 0));
    Modelica.Blocks.Interfaces.RealInput p_in if              use_p_in
      "Prescribed boundary pressure"
      annotation (Placement(transformation(extent={{-140,60},{-100,100}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput T_in if         use_T_in
      "Prescribed boundary temperature"
      annotation (Placement(transformation(extent={{-140,20},{-100,60}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput X_in[Medium.nX] if
                                                          use_X_in
      "Prescribed boundary composition"
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput C_in[Medium.nC] if
                                                          use_C_in
      "Prescribed boundary trace substances"
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}},
            rotation=0)));
  protected
    Modelica.Blocks.Interfaces.RealInput p_in_internal
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput T_in_internal
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput X_in_internal[Medium.nX]
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput C_in_internal[Medium.nC]
      "Needed to connect to conditional connector";
  equation
    Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames,
      Medium.singleState, true, X_in_internal, "Boundary_pT");
    connect(p_in, p_in_internal);
    connect(T_in, T_in_internal);
    connect(X_in, X_in_internal);
    connect(C_in, C_in_internal);
    if not use_p_in then
      p_in_internal = p;
    end if;
    if not use_T_in then
      T_in_internal = T;
    end if;
    if not use_X_in then
      X_in_internal = X;
    end if;
    if not use_C_in then
      C_in_internal = C;
    end if;
    medium.p = p_in_internal;
    medium.T = T_in_internal;
    medium.Xi = X_in_internal[1:Medium.nXi];

    ports.C_outflow = fill(C_in_internal, nPorts);
    annotation (defaultComponentName="boundary",
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={0,127,255}),
          Text(
            extent={{-150,120},{150,160}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=use_p_in,
            points={{-100,80},{-58,80}},
            color={0,0,255}),
          Line(
            visible=use_T_in,
            points={{-100,40},{-92,40}},
            color={0,0,255}),
          Line(
            visible=use_X_in,
            points={{-100,-40},{-92,-40}},
            color={0,0,255}),
          Line(
            visible=use_C_in,
            points={{-100,-80},{-60,-80}},
            color={0,0,255}),
          Text(
            visible=use_p_in,
            extent={{-152,134},{-68,94}},
            lineColor={0,0,0},
            textString="p"),
          Text(
            visible=use_X_in,
            extent={{-164,4},{-62,-36}},
            lineColor={0,0,0},
            textString="X"),
          Text(
            visible=use_C_in,
            extent={{-164,-90},{-62,-130}},
            lineColor={0,0,0},
            textString="C"),
          Text(
            visible=use_T_in,
            extent={{-162,34},{-60,-6}},
            lineColor={0,0,0},
            textString="T")}),
      Documentation(info="<html>
<p>
Defines prescribed values for boundary conditions:
</p>
<ul>
<li> Prescribed boundary pressure.</li>
<li> Prescribed boundary temperature.</li>
<li> Boundary composition (only for multi-substance or trace-substance flow).</li>
</ul>
<p>If <code>use_p_in</code> is false (default option), the <tt>p</tt> parameter
is used as boundary pressure, and the <code>p_in</code> input connector is disabled; if <tt>use_p_in</tt> is true, then the <tt>p</tt> parameter is ignored, and the value provided by the input connector is used instead.</p>
<p>The same thing goes for the temperature, composition and trace substances.</p>
<p>
Note, that boundary temperature,
mass fractions and trace substances have only an effect if the mass flow
is from the boundary into the port. If mass is flowing from
the port into the boundary, the boundary definitions,
with exception of boundary pressure, do not have an effect.
</p>
</html>"),
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics));
  end Boundary_pT;

  model Boundary_ph
    "Boundary with prescribed pressure, specific enthalpy, composition and trace substances"
    extends Sources.BaseClasses.PartialSource;
    parameter Boolean use_p_in = false
      "Get the pressure from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_h_in= false
      "Get the specific enthalpy from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_X_in = false
      "Get the composition from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_C_in = false
      "Get the trace substances from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Medium.AbsolutePressure p = Medium.p_default
      "Fixed value of pressure"
      annotation (Evaluate = true,
                  Dialog(enable = not use_p_in));
    parameter Medium.SpecificEnthalpy h = Medium.h_default
      "Fixed value of specific enthalpy"
      annotation (Evaluate = true,
                  Dialog(enable = not use_h_in));
    parameter Medium.MassFraction X[Medium.nX] = Medium.X_default
      "Fixed value of composition"
      annotation (Evaluate = true,
                  Dialog(enable = (not use_X_in) and Medium.nXi > 0));
    parameter Medium.ExtraProperty C[Medium.nC](
         quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
      "Fixed values of trace substances"
      annotation (Evaluate=true,
                  Dialog(enable = (not use_C_in) and Medium.nC > 0));
    Modelica.Blocks.Interfaces.RealInput p_in if              use_p_in
      "Prescribed boundary pressure"
      annotation (Placement(transformation(extent={{-140,60},{-100,100}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput h_in if              use_h_in
      "Prescribed boundary specific enthalpy"
      annotation (Placement(transformation(extent={{-140,20},{-100,60}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput X_in[Medium.nX] if
                                                          use_X_in
      "Prescribed boundary composition"
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput C_in[Medium.nC] if
                                                          use_C_in
      "Prescribed boundary trace substances"
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}},
            rotation=0)));
  protected
    Modelica.Blocks.Interfaces.RealInput p_in_internal
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput h_in_internal
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput X_in_internal[Medium.nX]
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput C_in_internal[Medium.nC]
      "Needed to connect to conditional connector";
  equation
    Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames,
      Medium.singleState, true, X_in_internal, "Boundary_ph");
    connect(p_in, p_in_internal);
    connect(h_in, h_in_internal);
    connect(X_in, X_in_internal);
    connect(C_in, C_in_internal);
    if not use_p_in then
      p_in_internal = p;
    end if;
    if not use_h_in then
      h_in_internal = h;
    end if;
    if not use_X_in then
      X_in_internal = X;
    end if;
    if not use_C_in then
      C_in_internal = C;
    end if;
    medium.p = p_in_internal;
    medium.h = h_in_internal;
    medium.Xi = X_in_internal[1:Medium.nXi];
    ports.C_outflow = fill(C_in_internal, nPorts);
    annotation (defaultComponentName="boundary",
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={0,127,255}),
          Text(
            extent={{-150,110},{150,150}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=use_p_in,
            points={{-100,80},{-60,80}},
            color={0,0,255}),
          Line(
            visible=use_h_in,
            points={{-100,40},{-92,40}},
            color={0,0,255}),
          Line(
            visible=use_X_in,
            points={{-100,-40},{-92,-40}},
            color={0,0,255}),
          Line(
            visible=use_C_in,
            points={{-100,-80},{-60,-80}},
            color={0,0,255}),
          Text(
            visible=use_p_in,
            extent={{-150,134},{-72,94}},
            lineColor={0,0,0},
            textString="p"),
          Text(
            visible=use_h_in,
            extent={{-166,34},{-64,-6}},
            lineColor={0,0,0},
            textString="h"),
          Text(
            visible=use_X_in,
            extent={{-164,4},{-62,-36}},
            lineColor={0,0,0},
            textString="X"),
          Text(
            visible=use_C_in,
            extent={{-164,-90},{-62,-130}},
            lineColor={0,0,0},
            textString="C")}),
      Documentation(info="<html>
<p>
Defines prescribed values for boundary conditions:
</p>
<ul>
<li> Prescribed boundary pressure.</li>
<li> Prescribed boundary temperature.</li>
<li> Boundary composition (only for multi-substance or trace-substance flow).</li>
</ul>
<p>If <code>use_p_in</code> is false (default option), the <tt>p</tt> parameter
is used as boundary pressure, and the <code>p_in</code> input connector is disabled; if <tt>use_p_in</tt> is true, then the <tt>p</tt> parameter is ignored, and the value provided by the input connector is used instead.</p>
<p>The same thing goes for the specific enthalpy and composition</p>
<p>
Note, that boundary temperature,
mass fractions and trace substances have only an effect if the mass flow
is from the boundary into the port. If mass is flowing from
the port into the boundary, the boundary definitions,
with exception of boundary pressure, do not have an effect.
</p>
</html>"));
  end Boundary_ph;

  model MassFlowSource_T
    "Ideal flow source that produces a prescribed mass flow with prescribed temperature, mass fraction and trace substances"
    extends Sources.BaseClasses.PartialSource;
    parameter Boolean use_m_flow_in = false
      "Get the mass flow rate from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_T_in= false
      "Get the temperature from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_X_in = false
      "Get the composition from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_C_in = false
      "Get the trace substances from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Medium.MassFlowRate m_flow = 0
      "Fixed mass flow rate going out of the fluid port"
      annotation (Evaluate = true,
                  Dialog(enable = not use_m_flow_in));
    parameter Medium.Temperature T = Medium.T_default
      "Fixed value of temperature"
      annotation (Evaluate = true,
                  Dialog(enable = not use_T_in));
    parameter Medium.MassFraction X[Medium.nX] = Medium.X_default
      "Fixed value of composition"
      annotation (Evaluate = true,
                  Dialog(enable = (not use_X_in) and Medium.nXi > 0));
    parameter Medium.ExtraProperty C[Medium.nC](
         quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
      "Fixed values of trace substances"
      annotation (Evaluate=true,
                  Dialog(enable = (not use_C_in) and Medium.nC > 0));
    Modelica.Blocks.Interfaces.RealInput m_flow_in if     use_m_flow_in
      "Prescribed mass flow rate"
      annotation (Placement(transformation(extent={{-120,60},{-80,100}},
            rotation=0), iconTransformation(extent={{-120,60},{-80,100}})));
    Modelica.Blocks.Interfaces.RealInput T_in if         use_T_in
      "Prescribed fluid temperature"
      annotation (Placement(transformation(extent={{-140,20},{-100,60}},
            rotation=0), iconTransformation(extent={{-140,20},{-100,60}})));
    Modelica.Blocks.Interfaces.RealInput X_in[Medium.nX] if
                                                          use_X_in
      "Prescribed fluid composition"
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput C_in[Medium.nC] if
                                                          use_C_in
      "Prescribed boundary trace substances"
      annotation (Placement(transformation(extent={{-120,-100},{-80,-60}},
            rotation=0)));
  protected
    Modelica.Blocks.Interfaces.RealInput m_flow_in_internal
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput T_in_internal
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput X_in_internal[Medium.nX]
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput C_in_internal[Medium.nC]
      "Needed to connect to conditional connector";
  equation
    Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames,
      Medium.singleState, true, X_in_internal, "MassFlowSource_T");
    connect(m_flow_in, m_flow_in_internal);
    connect(T_in, T_in_internal);
    connect(X_in, X_in_internal);
    connect(C_in, C_in_internal);
    if not use_m_flow_in then
      m_flow_in_internal = m_flow;
    end if;
    if not use_T_in then
      T_in_internal = T;
    end if;
    if not use_X_in then
      X_in_internal = X;
    end if;
    if not use_C_in then
      C_in_internal = C;
    end if;
    sum(ports.m_flow) = -m_flow_in_internal;
    medium.T = T_in_internal;
    medium.Xi = X_in_internal[1:Medium.nXi];
    ports.C_outflow = fill(C_in_internal, nPorts);
    annotation (defaultComponentName="boundary",
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{35,45},{100,-45}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255}),
          Ellipse(
            extent={{-100,80},{60,-80}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-60,70},{60,0},{-60,-68},{-60,70}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-54,32},{16,-30}},
            lineColor={255,0,0},
            textString="m"),
          Text(
            extent={{-150,130},{150,170}},
            textString="%name",
            lineColor={0,0,255}),
          Ellipse(
            extent={{-26,30},{-18,22}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            visible=use_m_flow_in,
            extent={{-185,132},{-45,100}},
            lineColor={0,0,0},
            textString="m_flow"),
          Text(
            visible=use_T_in,
            extent={{-111,71},{-71,37}},
            lineColor={0,0,0},
            textString="T"),
          Text(
            visible=use_X_in,
            extent={{-153,-44},{-33,-72}},
            lineColor={0,0,0},
            textString="X"),
          Text(
            visible=use_C_in,
            extent={{-155,-98},{-35,-126}},
            lineColor={0,0,0},
            textString="C")}),
      Window(
        x=0.45,
        y=0.01,
        width=0.44,
        height=0.65),
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      Documentation(info="<html>
<p>
Models an ideal flow source, with prescribed values of flow rate, temperature, composition and trace substances:
</p>
<ul>
<li> Prescribed mass flow rate.</li>
<li> Prescribed temperature.</li>
<li> Boundary composition (only for multi-substance or trace-substance flow).</li>
</ul>
<p>If <code>use_m_flow_in</code> is false (default option), the <tt>m_flow</tt> parameter
is used as boundary pressure, and the <code>m_flow_in</code> input connector is disabled; if <tt>use_m_flow_in</tt> is true, then the <tt>m_flow</tt> parameter is ignored, and the value provided by the input connector is used instead.</p>
<p>The same thing goes for the temperature and composition</p>
<p>
Note, that boundary temperature,
mass fractions and trace substances have only an effect if the mass flow
is from the boundary into the port. If mass is flowing from
the port into the boundary, the boundary definitions,
with exception of boundary flow rate, do not have an effect.
</p>
</html>"));
  end MassFlowSource_T;

  model MassFlowSource_h
    "Ideal flow source that produces a prescribed mass flow with prescribed specific enthalpy, mass fraction and trace substances"
    extends Sources.BaseClasses.PartialSource;
    parameter Boolean use_m_flow_in = false
      "Get the mass flow rate from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_h_in= false
      "Get the specific enthalpy from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_X_in = false
      "Get the composition from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_C_in = false
      "Get the trace substances from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Medium.MassFlowRate m_flow = 0
      "Fixed mass flow rate going out of the fluid port"
      annotation (Evaluate = true,
                  Dialog(enable = not use_m_flow_in));
    parameter Medium.SpecificEnthalpy h = Medium.h_default
      "Fixed value of specific enthalpy"
      annotation (Evaluate = true,
                  Dialog(enable = not use_h_in));
    parameter Medium.MassFraction X[Medium.nX] = Medium.X_default
      "Fixed value of composition"
      annotation (Evaluate = true,
                  Dialog(enable = (not use_X_in) and Medium.nXi > 0));
    parameter Medium.ExtraProperty C[Medium.nC](
         quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
      "Fixed values of trace substances"
      annotation (Evaluate=true,
                  Dialog(enable = (not use_C_in) and Medium.nC > 0));
    Modelica.Blocks.Interfaces.RealInput m_flow_in if     use_m_flow_in
      "Prescribed mass flow rate"
      annotation (Placement(transformation(extent={{-120,60},{-80,100}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput h_in if              use_h_in
      "Prescribed fluid specific enthalpy"
      annotation (Placement(transformation(extent={{-140,20},{-100,60}},
            rotation=0), iconTransformation(extent={{-140,20},{-100,60}})));
    Modelica.Blocks.Interfaces.RealInput X_in[Medium.nX] if
                                                          use_X_in
      "Prescribed fluid composition"
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealInput C_in[Medium.nC] if
                                                          use_C_in
      "Prescribed boundary trace substances"
      annotation (Placement(transformation(extent={{-120,-100},{-80,-60}},
            rotation=0), iconTransformation(extent={{-120,-100},{-80,-60}})));
  protected
    Modelica.Blocks.Interfaces.RealInput m_flow_in_internal
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput h_in_internal
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput X_in_internal[Medium.nX]
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput C_in_internal[Medium.nC]
      "Needed to connect to conditional connector";
  equation
    Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames,
      Medium.singleState, true, X_in_internal, "MassFlowSource_h");
    connect(m_flow_in, m_flow_in_internal);
    connect(h_in, h_in_internal);
    connect(X_in, X_in_internal);
    connect(C_in, C_in_internal);
    if not use_m_flow_in then
      m_flow_in_internal = m_flow;
    end if;
    if not use_h_in then
      h_in_internal = h;
    end if;
    if not use_X_in then
      X_in_internal = X;
    end if;
    if not use_C_in then
      C_in_internal = C;
    end if;
    sum(ports.m_flow) = -m_flow_in_internal;
    medium.h = h_in_internal;
    medium.Xi = X_in_internal[1:Medium.nXi];
    ports.C_outflow = fill(C_in_internal, nPorts);
    annotation (defaultComponentName="boundary",
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{36,45},{100,-45}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255}),
          Ellipse(
            extent={{-100,80},{60,-80}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-60,70},{60,0},{-60,-68},{-60,70}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-54,32},{16,-30}},
            lineColor={255,0,0},
            textString="m"),
          Ellipse(
            extent={{-26,30},{-18,22}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            visible=use_m_flow_in,
            extent={{-185,132},{-45,100}},
            lineColor={0,0,0},
            textString="m_flow"),
          Text(
            visible=use_h_in,
            extent={{-113,72},{-73,38}},
            lineColor={0,0,0},
            textString="h"),
          Text(
            visible=use_X_in,
            extent={{-153,-44},{-33,-72}},
            lineColor={0,0,0},
            textString="X"),
          Text(
            visible=use_X_in,
            extent={{-155,-98},{-35,-126}},
            lineColor={0,0,0},
            textString="C"),
          Text(
            extent={{-150,110},{150,150}},
            textString="%name",
            lineColor={0,0,255})}),
      Window(
        x=0.45,
        y=0.01,
        width=0.44,
        height=0.65),
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      Documentation(info="<html>
<p>
Models an ideal flow source, with prescribed values of flow rate, temperature and composition:
</p>
<ul>
<li> Prescribed mass flow rate.</li>
<li> Prescribed specific enthalpy.</li>
<li> Boundary composition (only for multi-substance or trace-substance flow).</li>
</ul>
<p>If <code>use_m_flow_in</code> is false (default option), the <tt>m_flow</tt> parameter
is used as boundary pressure, and the <code>m_flow_in</code> input connector is disabled; if <tt>use_m_flow_in</tt> is true, then the <tt>m_flow</tt> parameter is ignored, and the value provided by the input connector is used instead.</p>
<p>The same thing goes for the temperature and composition</p>
<p>
Note, that boundary temperature,
mass fractions and trace substances have only an effect if the mass flow
is from the boundary into the port. If mass is flowing from
the port into the boundary, the boundary definitions,
with exception of boundary flow rate, do not have an effect.
</p>
</html>"));
  end MassFlowSource_h;

  package BaseClasses
    "Base classes used in the Sources package (only of interest to build new component models)"
    extends Modelica.Icons.BasesPackage;
  partial model PartialSource
      "Partial component source with one fluid connector"
      import Modelica.Constants;

    parameter Integer nPorts=0 "Number of ports" annotation(Dialog(connectorSizing=true));

    replaceable package Medium =
        Modelica.Media.Interfaces.PartialMedium
        "Medium model within the source"
       annotation (choicesAllMatching=true);

    Medium.BaseProperties medium "Medium in the source";

    Interfaces.FluidPorts_b ports[nPorts](
                       redeclare each package Medium = Medium,
                       m_flow(each max=if flowDirection==Types.PortFlowDirection.Leaving then 0 else
                                       +Constants.inf,
                              each min=if flowDirection==Types.PortFlowDirection.Entering then 0 else
                                       -Constants.inf))
      annotation (Placement(transformation(extent={{90,40},{110,-40}})));
    protected
    parameter Types.PortFlowDirection flowDirection=
                     Types.PortFlowDirection.Bidirectional
        "Allowed flow direction"             annotation(Evaluate=true, Dialog(tab="Advanced"));
  equation
    // Only one connection allowed to a port to avoid unwanted ideal mixing
    for i in 1:nPorts loop
      assert(cardinality(ports[i]) <= 1,"
each ports[i] of boundary shall at most be connected to one component.
If two or more connections are present, ideal mixing takes
place with these connections, which is usually not the intention
of the modeller. Increase nPorts to add an additional port.
");

       ports[i].p          = medium.p;
       ports[i].h_outflow  = medium.h;
       // <Hot fix>
       // Normally, the following line should read
       //   ports[i].Xi_outflow = medium.Xi;
       // In some Modelica tools, this produces an error however. Instead of wating
       // for bug fixes for all tools, Modelica Association decided to include a
       // simple reformulation to avoid this problem.
       for j in 1:Medium.nXi loop
         ports[i].Xi_outflow[j] = medium.Xi[j];
       end for;
       // <//Hot fix>
    end for;

    annotation (defaultComponentName="boundary", Documentation(info="<html>
<p>
Partial component to model the <b>volume interface</b> of a <b>source</b>
component, such as a mass flow source. The essential
features are:
</p>
<ul>
<li> The pressure in the connection port (= ports.p) is identical to the
     pressure in the volume.</li>
<li> The outflow enthalpy rate (= port.h_outflow) and the composition of the
     substances (= port.Xi_outflow) are identical to the respective values in the volume.</li>
</ul>
</html>"),   Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                -100},{100,100}}),
                           graphics),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics));
  end PartialSource;
  end BaseClasses;
  annotation (Documentation(info="<html>
<p>
Package <b>Sources</b> contains generic sources for fluid connectors
to define fixed or prescribed ambient conditions.
</p>
</html>"));
end Sources;
