within Modelica.Fluid;
package Valves "Components for the regulation and control of fluid flow"
    extends Modelica.Fluid.Icons.VariantLibrary;

    model ValveIncompressible "Valve for (almost) incompressible fluids"
      extends BaseClasses.PartialValve;
    import Modelica.Fluid.Types.CvTypes;

    initial equation
      if CvData == CvTypes.OpPoint then
          m_flow_nominal = valveCharacteristic(opening_nominal)*Av*sqrt(rho_nominal)*Utilities.regRoot(dp_nominal, dp_small)
        "Determination of Av by the operating point";
      end if;

    equation
      // m_flow = valveCharacteristic(opening)*Av*sqrt(d)*sqrt(dp);
      if checkValve then
        m_flow = valveCharacteristic(opening)*Av*sqrt(Medium.density(state_a))*
                      (if dp>=0 then Utilities.regRoot(dp, dp_small) else 0);
      elseif not allowFlowReversal then
        m_flow = valveCharacteristic(opening)*Av*sqrt(Medium.density(state_a))*
                      Utilities.regRoot(dp, dp_small);
      else
        m_flow = valveCharacteristic(opening)*Av*
          smooth(0, Utilities.regRoot(dp, dp_small)*(if dp>=0 then sqrt(Medium.density(state_a)) else sqrt(Medium.density(state_b))));
      end if;

    annotation (
    Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
    Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
    Documentation(info="<HTML>
<p>Valve model according to the IEC 534/ISA S.75 standards for valve sizing, incompressible fluids.
<p>This model assumes that the fluid has a low compressibility, which is always the case for liquids.
It can also be used with gases, provided that the pressure drop is lower than 0.2 times the absolute pressure at the inlet, so that the fluid density does not change much inside the valve.</p>
<p>If <tt>checkValve</tt> is false, the valve supports reverse flow, with a symmetric flow characteric curve. Otherwise, reverse flow is stopped (check valve behaviour).</p>

<p>
The treatment of parameters <b>Kv</b> and <b>Cv</b> is
explained in detail in the
<a href=\"Modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">Users Guide</a>.
</p>

</html>",
      revisions="<html>
<ul>
<li><i>2 Nov 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted from the ThermoPower library.</li>
</ul>
</html>"));
    end ValveIncompressible;

  model ValveVaporizing
    "Valve for possibly vaporizing (almost) incompressible fluids, accounts for choked flow conditions"
    import Modelica.Fluid.Types.CvTypes;
    extends BaseClasses.PartialValve(
      redeclare replaceable package Medium =
          Modelica.Media.Water.WaterIF97_ph                                    constrainedby
        Modelica.Media.Interfaces.PartialTwoPhaseMedium);
    parameter Real Fl_nominal=0.9 "Liquid pressure recovery factor";
    replaceable function FlCharacteristic =
        Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.one
      constrainedby
      Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.baseFun
      "Pressure recovery characteristic";
    Real Ff "Ff coefficient (see IEC/ISA standard)";
    Real Fl "Pressure recovery coefficient Fl (see IEC/ISA standard)";
    SI.Pressure dpEff "Effective pressure drop";
    Medium.Temperature T_in "Inlet temperature";
    Medium.AbsolutePressure p_sat "Saturation pressure";
    Medium.AbsolutePressure p_in "Inlet pressure";
    Medium.AbsolutePressure p_out "Outlet pressure";
  initial equation
    assert(not CvData == CvTypes.OpPoint, "OpPoint option not supported for vaporizing valve");
  equation
    p_in = port_a.p;
    p_out = port_b.p;
    T_in = Medium.temperature(state_a);
    p_sat = Medium.saturationPressure(T_in);
    Ff = 0.96 - 0.28*sqrt(p_sat/Medium.fluidConstants[1].criticalPressure);
    Fl = Fl_nominal*FlCharacteristic(opening);
    dpEff = if p_out < (1 - Fl^2)*p_in + Ff*Fl^2*p_sat then
              Fl^2*(p_in - Ff*p_sat) else dp
      "Effective pressure drop, accounting for possible choked conditions";
    // m_flow = valveCharacteristic(opening)*Av*sqrt(d)*sqrt(dpEff);
    if checkValve then
      m_flow = valveCharacteristic(opening)*Av*sqrt(Medium.density(state_a))*
                    (if dpEff>=0 then Utilities.regRoot(dpEff, dp_small) else 0);
    elseif not allowFlowReversal then
      m_flow = valveCharacteristic(opening)*Av*sqrt(Medium.density(state_a))*
                    Utilities.regRoot(dpEff, dp_small);
    else
       m_flow = valveCharacteristic(opening)*Av*
        smooth(0, Utilities.regRoot(dpEff, dp_small)*(if dpEff>=0 then sqrt(Medium.density(state_a)) else sqrt(Medium.density(state_b))));
    end if;

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}),
           graphics),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
              graphics),
      Documentation(info="<HTML>
<p>Valve model according to the IEC 534/ISA S.75 standards for valve sizing, incompressible fluid at the inlet, and possibly two-phase fluid at the outlet, including choked flow conditions. </p>
<p>The model operating range includes choked flow operation, which takes place for low outlet pressures due to flashing in the vena contracta; otherwise, non-choking conditions are assumed.
<p>This model requires a two-phase medium model, to describe the liquid and (possible) two-phase conditions.
<p>The default liquid pressure recovery coefficient <tt>Fl</tt> is constant and given by the parameter <tt>Fl_nominal</tt>. The relative change (per unit) of the recovery coefficient can be specified as a given function of the valve opening by replacing the <tt>FlCharacteristic</tt> function.
<p>If <tt>checkValve</tt> is false, the valve supports reverse flow, with a symmetric flow characteric curve. Otherwise, reverse flow is stopped (check valve behaviour).</p>

<p>
The treatment of parameters <b>Kv</b> and <b>Cv</b> is
explained in detail in the
<a href=\"Modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">Users Guide</a>.
</p>

</HTML>",
        revisions="<html>
<ul>
<li><i>2 Nov 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted from the ThermoPower library.</li>
</ul>
</html>"));
  end ValveVaporizing;

  model ValveCompressible
    "Valve for compressible fluids, accounts for choked flow conditions"
    extends BaseClasses.PartialValve;
    import Modelica.Fluid.Types.CvTypes;
    parameter Medium.AbsolutePressure p_nominal "Nominal inlet pressure"
    annotation(Dialog(group="Nominal operating point"));
    parameter Real Fxt_full=0.5 "Fk*xt critical ratio at full opening";
    replaceable function xtCharacteristic =
        Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.one
      constrainedby
      Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.baseFun
      "Critical ratio characteristic";
    Real Fxt;
    Real x "Pressure drop ratio";
    Real xs "Saturated pressure drop ratio";
    Real Y "Compressibility factor";
    Medium.AbsolutePressure p "Inlet pressure";
  protected
    parameter Real Fxt_nominal(fixed=false) "Nominal Fxt";
    parameter Real x_nominal(fixed=false) "Nominal pressure drop ratio";
    parameter Real xs_nominal(fixed=false)
      "Nominal saturated pressure drop ratio";
    parameter Real Y_nominal(fixed=false) "Nominal compressibility factor";

  initial equation
    if CvData == CvTypes.OpPoint then
      // Determination of Av by the nominal operating point conditions
      Fxt_nominal = Fxt_full*xtCharacteristic(opening_nominal);
      x_nominal = dp_nominal/p_nominal;
      xs_nominal = smooth(0, if x_nominal > Fxt_nominal then Fxt_nominal else x_nominal);
      Y_nominal = 1 - abs(xs_nominal)/(3*Fxt_nominal);
      m_flow_nominal = valveCharacteristic(opening_nominal)*Av*Y_nominal*sqrt(rho_nominal)*Utilities.regRoot(p_nominal*xs_nominal, dp_small);
    else
      // Dummy values
      Fxt_nominal = 0;
      x_nominal = 0;
      xs_nominal = 0;
      Y_nominal = 0;
    end if;

  equation
    p = noEvent(if dp>=0 then port_a.p else port_b.p);
    Fxt = Fxt_full*xtCharacteristic(opening);
    x = dp/p;
    xs = smooth(0, if x < -Fxt then -Fxt else if x > Fxt then Fxt else x);
    Y = 1 - abs(xs)/(3*Fxt);
    // m_flow = valveCharacteristic(opening)*Av*Y*sqrt(d)*sqrt(p*xs);
    if checkValve then
      m_flow = valveCharacteristic(opening)*Av*Y*sqrt(Medium.density(state_a))*
        (if xs>=0 then Utilities.regRoot(p*xs, dp_small) else 0);
    elseif not allowFlowReversal then
      m_flow = valveCharacteristic(opening)*Av*sqrt(Medium.density(state_a))*
                    Utilities.regRoot(p*xs, dp_small);
    else
      m_flow = valveCharacteristic(opening)*Av*Y*
        smooth(0, Utilities.regRoot(p*xs, dp_small)*(if xs>=0 then sqrt(Medium.density(state_a)) else sqrt(Medium.density(state_b))));
  /*
    m_flow = valveCharacteristic(opening)*Av*Y*
                  Modelica.Fluid.Utilities.regRoot2(p*xs, dp_small, Medium.density(state_a), Medium.density(state_b));
*/
    end if;

    annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}),
         graphics),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
            graphics),
    Documentation(info="<HTML>
<p>Valve model according to the IEC 534/ISA S.75 standards for valve sizing, compressible fluid, no phase change, also covering choked-flow conditions. </p>
<p>This model can be used with gases and vapours, with arbitrary pressure ratio between inlet and outlet.</p>

<p>The product Fk*xt is given by the parameter <tt>Fxt_full</tt>, and is assumed constant by default. The relative change (per unit) of the xt coefficient with the valve opening can be specified by replacing the <tt>xtCharacteristic</tt> function.
<p>If <tt>checkValve</tt> is false, the valve supports reverse flow, with a symmetric flow characteric curve. Otherwise, reverse flow is stopped (check valve behaviour).</p>

<p>
The treatment of parameters <b>Kv</b> and <b>Cv</b> is
explained in detail in the
<a href=\"Modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">Users Guide</a>.
</p>

</HTML>",
      revisions="<html>
<ul>
<li><i>2 Nov 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted from the ThermoPower library.</li>
</ul>
</html>"));
  end ValveCompressible;

  model ValveLinear "Valve for water/steam flows with linear pressure drop"
    extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;
    parameter SI.AbsolutePressure dp_nominal
      "Nominal pressure drop at full opening";
    parameter Medium.MassFlowRate m_flow_nominal
      "Nominal mass flowrate at full opening";
    final parameter Types.HydraulicConductance k = m_flow_nominal/dp_nominal
      "Hydraulic conductance at full opening";
    Modelica.Blocks.Interfaces.RealInput opening(min=0,max=1)
      "=1: completely open, =0: completely closed"
    annotation (Placement(transformation(
          origin={0,90},
          extent={{-20,-20},{20,20}},
          rotation=270), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,80})));

  equation
    m_flow = opening*k*dp;

    // Isenthalpic state transformation (no storage and no loss of energy)
    port_a.h_outflow = inStream(port_b.h_outflow);
    port_b.h_outflow = inStream(port_a.h_outflow);

  annotation (
    Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{0,50},{0,0}}, color={0,0,0}),
          Rectangle(
            extent={{-20,60},{20,50}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,50}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points=DynamicSelect({{-100,0},{100,-0},{100,0},{0,0},{-100,-0},{-100,
                0}}, {{-100,50*opening},{-100,50*opening},{100,-50*opening},{
                100,50*opening},{0,0},{-100,-50*opening},{-100,50*opening}}),
            fillColor={0,255,0},
            lineColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,
                50}}, lineColor={0,0,0})}),
    Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
    Documentation(info="<HTML>
<p>This very simple model provides a pressure drop which is proportional to the flowrate and to the <tt>opening</tt> input, without computing any fluid property. It can be used for testing purposes, when
a simple model of a variable pressure loss is needed.</p>
<p>A medium model must be nevertheless be specified, so that the fluid ports can be connected to other components using the same medium model.</p>
<p>The model is adiabatic (no heat losses to the ambient) and neglects changes in kinetic energy from the inlet to the outlet. </p>
</HTML>",
      revisions="<html>
<ul>
<li><i>2 Nov 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted from the ThermoPower library.</li>
</ul>
</html>"));
  end ValveLinear;

  model ValveDiscrete "Valve for water/steam flows with linear pressure drop"
    extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;
    parameter SI.Pressure dp_nominal "Nominal pressure drop at full opening=1";
    parameter Medium.MassFlowRate m_flow_nominal
      "Nominal mass flowrate at full opening=1";
    final parameter Types.HydraulicConductance k = m_flow_nominal/dp_nominal
      "Hydraulic conductance at full opening=1";
    Modelica.Blocks.Interfaces.BooleanInput open
    annotation (Placement(transformation(
          origin={0,80},
          extent={{-20,-20},{20,20}},
          rotation=270)));
    parameter Real opening_min(min=0)=0
      "Remaining opening if closed, causing small leakage flow";
  equation
    m_flow = if open then 1*k*dp else opening_min*k*dp;

    // Isenthalpic state transformation (no storage and no loss of energy)
    port_a.h_outflow = inStream(port_b.h_outflow);
    port_b.h_outflow = inStream(port_a.h_outflow);

  annotation (
    Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{0,50},{0,0}}, color={0,0,0}),
          Rectangle(
            extent={{-20,60},{20,50}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,50}},
            fillColor=DynamicSelect({255,255,255}, if open > 0.5 then {0,255,0}
                 else {255,255,255}),
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
    Documentation(info="<HTML>
<p>
This very simple model provides a (small) pressure drop which is proportional to the flowrate if the Boolean open signal is <b>true</b>. Otherwise, the mass flow rate is zero. If opening_min > 0, a small leakage mass flow rate occurs when open = <b>false</b>.
</p>
<p>This model can be used for simplified modelling of on-off valves, when it is not important to accurately describe the pressure loss when the valve is open. Although the medium model is not used to determine the pressure loss, it must be nevertheless be specified, so that the fluid ports can be connected to other components using the same medium model.</p>
<p>The model is adiabatic (no heat losses to the ambient) and neglects changes in kinetic energy from the inlet to the outlet. </p>
<p>
In a diagram animation, the valve is shown in \"green\", when
it is open.
</p>
</HTML>",
      revisions="<html>
<ul>
<li><i>Nov 2005</i>
    by Katja Poschlad (based on ValveLinear).</li>
</ul>
</html>"));

  end ValveDiscrete;

  package BaseClasses
    "Base classes used in the Valves package (only of interest to build new component models)"
    extends Modelica.Fluid.Icons.BaseClassLibrary;
    partial model PartialValve "Base model for valves"

      import Modelica.Fluid.Types.CvTypes;
      extends Modelica.Fluid.Interfaces.PartialTwoPortTransport(
        dp_start = dp_nominal,
        m_flow_start = m_flow_nominal,
        m_flow_small = system.m_flow_small);

      parameter CvTypes CvData=CvTypes.OpPoint "Selection of flow coefficient"
       annotation(Dialog(group = "Flow Coefficient"));
      parameter SI.Area Av(
        fixed=if CvData == CvTypes.Av then true else false,
        start=m_flow_nominal/(sqrt(rho_nominal*dp_nominal))*valveCharacteristic(
            opening_nominal)) = 0 "Av (metric) flow coefficient"
       annotation(Dialog(group = "Flow Coefficient",
                         enable = (CvData==Modelica.Fluid.Types.CvTypes.Av)));
      parameter Real Kv = 0 "Kv (metric) flow coefficient [m3/h]"
      annotation(Dialog(group = "Flow Coefficient",
                        enable = (CvData==CvTypes.Kv)));
      parameter Real Cv = 0 "Cv (US) flow coefficient [USG/min]"
      annotation(Dialog(group = "Flow Coefficient",
                        enable = (CvData==CvTypes.Cv)));
      parameter SI.Pressure dp_nominal "Nominal pressure drop"
      annotation(Dialog(group="Nominal operating point"));
      parameter Medium.MassFlowRate m_flow_nominal "Nominal mass flowrate"
      annotation(Dialog(group="Nominal operating point"));
      parameter Medium.Density rho_nominal=Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default)
        "Nominal inlet density"
      annotation(Dialog(group="Nominal operating point"));
      parameter Real opening_nominal=1 "Nominal opening"
      annotation(Dialog(group="Nominal operating point"));
      parameter Boolean checkValve=false "Reverse flow stopped"
        annotation(Dialog(tab="Assumptions"));

      replaceable function valveCharacteristic =
          Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.linear
        constrainedby
        Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.baseFun
        "Inherent flow characteristic"
        annotation(choicesAllMatching=true);

      parameter SI.Pressure dp_small=system.dp_small
        "Regularisation of zero flow"                 annotation(Dialog(tab="Advanced"));

      constant SI.Area Kv2Av = 27.7e-6 "Conversion factor";
      constant SI.Area Cv2Av = 24.0e-6 "Conversion factor";

      Modelica.Blocks.Interfaces.RealInput opening(min=0, max=1)
        "Valve position in the range 0-1"
                                       annotation (Placement(transformation(
            origin={0,90},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,80})));

    initial equation
      if CvData == CvTypes.Kv then
        Av = Kv*Kv2Av "Unit conversion";
      elseif CvData == CvTypes.Cv then
        Av = Cv*Cv2Av "Unit conversion";
      end if;

    equation
      // Isenthalpic state transformation (no storage and no loss of energy)
      port_a.h_outflow = inStream(port_b.h_outflow);
      port_b.h_outflow = inStream(port_a.h_outflow);

      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Line(points={{0,52},{0,0}}, color={0,0,0}),
            Rectangle(
              extent={{-20,60},{20,52}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,50}},

              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points=DynamicSelect({{-100,0},{100,-0},{100,0},{0,0},{-100,-0},{
                  -100,0}}, {{-100,50*opening},{-100,50*opening},{100,-50*
                  opening},{100,50*opening},{0,0},{-100,-50*opening},{-100,50*
                  opening}}),
              fillColor={0,255,0},
              lineColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,
                  50}}, lineColor={0,0,0})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
        Documentation(info="<HTML>
<p>This is the base model for the <tt>ValveIncompressible</tt>, <tt>ValveVaporizing</tt>, and <tt>ValveCompressible</tt> valve models. The model is based on the IEC 534 / ISA S.75 standards for valve sizing.</p>
<p>The model optionally supports reverse flow conditions (assuming symmetrical behaviour) or check valve operation, and has been suitably regularized, compared to the equations in the standard, in order to avoid numerical singularities around zero pressure drop operating conditions. </p>
<p>The model assumes adiabatic operation (no heat losses to the ambient); changes in kinetic energy
from inlet to outlet are neglected in the energy balance. </p>
<p><b>Modelling options</b></p>
<p>The following options are available to specify the valve flow coefficient in fully open conditions:
<ul><li><tt>CvData = Modelica.Fluid.Types.CvTypes.Av</tt>: the flow coefficient is given by the metric <tt>Av</tt> coefficient (m^2).
<li><tt>CvData = Modelica.Fluid.Types.CvTypes.Kv</tt>: the flow coefficient is given by the metric <tt>Kv</tt> coefficient (m^3/h).
<li><tt>CvData = Modelica.Fluid.Types.CvTypes.Cv</tt>: the flow coefficient is given by the US <tt>Cv</tt> coefficient (USG/min).
<li><tt>CvData = Modelica.Fluid.Types.CvTypes.OpPoint</tt>: the flow is computed from the nominal operating point specified by <tt>p_nominal</tt>, <tt>dp_nominal</tt>, <tt>m_flow_nominal</tt>, <tt>rho_nominal</tt>, <tt>opening_nominal</tt>.
</ul>
<p>The nominal pressure drop <tt>dp_nominal</tt> must always be specified; to avoid numerical singularities, the flow characteristic is modified for pressure drops less than <tt>b*dp_nominal</tt> (the default value is 1% of the nominal pressure drop). Increase this parameter if numerical problems occur in valves with very low pressure drops.
<p>If <tt>checkValve</tt> is true, then the flow is stopped when the outlet pressure is higher than the inlet pressure; otherwise, reverse flow takes place. Use this option only when neede, as it increases the numerical complexity of the problem.
<p>The valve opening characteristic <tt>valveCharacteristic</tt>, linear by default, can be replaced by any user-defined function. Quadratic and equal percentage with customizable rangeability are already provided by the library.
</p>

<p>
The treatment of parameters <b>Kv</b> and <b>Cv</b> is
explained in detail in the
<a href=\"Modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">Users Guide</a>.
</p>

</HTML>", revisions="<html>
<ul>
<li><i>2 Nov 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted from the ThermoPower library.</li>
</ul>
</html>"));

    end PartialValve;

  package ValveCharacteristics "Functions for valve characteristics"
    partial function baseFun "Base class for valve characteristics"
      extends Modelica.Icons.Function;
      input Real pos "Opening position (per unit)";
      output Real rc "Relative flow coefficient (per unit)";
    end baseFun;

    function linear "Linear characteristic"
      extends baseFun;
    algorithm
      rc := pos;
    end linear;

    function one "Constant characteristic"
      extends baseFun;
    algorithm
      rc := 1;
    end one;

    function quadratic "Quadratic characteristic"
      extends baseFun;
    algorithm
      rc := pos*pos;
    end quadratic;

    function equalPercentage "Equal percentage characteristic"
      extends baseFun;
      input Real rangeability = 20 "Rangeability";
      input Real delta = 0.01;
    algorithm
      rc := if pos > delta then rangeability^(pos-1) else
              pos/delta*rangeability^(delta-1);
      annotation (Documentation(info="<html>
This characteristic is such that the relative change of the flow coefficient is proportional to the change in the opening position:
<p> d(rc)/d(pos) = k d(pos).
<p> The constant k is expressed in terms of the rangeability, i.e. the ratio between the maximum and the minimum useful flow coefficient:
<p> rangeability = exp(k) = rc(1.0)/rc(0.0).
<p> The theoretical characteristic has a non-zero opening when pos = 0; the implemented characteristic is modified so that the valve closes linearly when pos &lt delta.
</html>"));
    end equalPercentage;

  end ValveCharacteristics;
  end BaseClasses;
  annotation (Documentation(info="<html>

</html>"));
end Valves;
