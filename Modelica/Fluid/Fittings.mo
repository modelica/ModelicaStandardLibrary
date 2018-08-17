within Modelica.Fluid;
package Fittings
  "Adaptors for connections of fluid components and the regulation of fluid flow"
  package Bends "Flow models for bends"
    extends Modelica.Icons.VariantsPackage;
    model CurvedBend "Curved bend flow model"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Bend_i;
      extends Modelica.Fluid.Interfaces.PartialPressureLoss;

      parameter Modelica.Fluid.Fittings.BaseClasses.Bends.CurvedBend.Geometry geometry
        "Geometry of curved bend"
          annotation (Placement(transformation(extent={{-20,0},{0,20}})));

    protected
      parameter Medium.AbsolutePressure dp_small(min=0)=
                 Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP(
                    geometry,
                    Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var(
                      rho=Medium.density(state_dp_small),
                      eta=Medium.dynamicViscosity(state_dp_small)),
                    m_flow_small)
        "Default small pressure drop for regularization of laminar and zero flow (calculated from m_flow_small)";

    equation
      if allowFlowReversal then
         m_flow = Modelica.Fluid.Fittings.BaseClasses.Bends.CurvedBend.massFlowRate(
                    dp, geometry, d_a, d_b, eta_a, eta_b, dp_small, m_flow_small);
      else
         m_flow = Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW(
                    geometry,
                    Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var(rho=d_a, eta=eta_a), dp);
      end if;

      annotation (Documentation(info="<html>
<p>
This component models a <strong>curved bend</strong> in the overall flow regime for incompressible and single-phase fluid flow through circular cross sectional area considering surface roughness. It is expected that also compressible fluid flow can be handled up to about Ma = 0.3. It is assumed that neither mass nor energy is stored in this component.
In the model basically a function is called to compute the mass flow rate as a function
of pressure loss for a curved bend. Also the inverse of this function is defined, and a tool
might use this inverse function instead, in order to avoid the solution of a nonlinear equation.
</p>

<p>
The details of the model are described in the
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_curvedOverall\">documentation of the underlying function</a>.
</p>
</html>"));
    end CurvedBend;

    model EdgedBend "Edged bend flow model"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Bend_i;
      extends Modelica.Fluid.Interfaces.PartialPressureLoss;

      parameter Modelica.Fluid.Fittings.BaseClasses.Bends.EdgedBend.Geometry geometry
        "Geometry of curved bend"
          annotation (Placement(transformation(extent={{-20,0},{0,20}})));

    protected
      parameter Medium.AbsolutePressure dp_small(min=0)=
                 Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP(
                   Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con(
                       d_hyd=geometry.d_hyd,
                       delta=geometry.delta,
                       K=geometry.K),
                    Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var(
                      rho=Medium.density(state_dp_small),
                      eta=Medium.dynamicViscosity(state_dp_small)),
                    m_flow_small)
        "Default small pressure drop for regularization of laminar and zero flow (calculated from m_flow_small)";

    equation
      if allowFlowReversal then
         m_flow = Modelica.Fluid.Fittings.BaseClasses.Bends.EdgedBend.massFlowRate(
                    dp, geometry, d_a, d_b, eta_a, eta_b, dp_small, m_flow_small);
      else
         m_flow = Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW(
                   Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con(
                       d_hyd=geometry.d_hyd,
                       delta=geometry.delta,
                       K=geometry.K),
                    Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var(rho=d_a, eta=eta_a), dp);
      end if;

      annotation (Documentation(info="<html>
<p>
This component models an <strong>edged bend</strong> in the overall flow regime for incompressible and single-phase fluid flow through circular cross sectional area considering surface roughness. It is expected that also compressible fluid flow can be handled up to about Ma = 0.3. It is assumed that neither mass nor energy is stored in this component.
In the model basically a function is called to compute the mass flow rate as a function
of pressure loss for an edged bend. Also the inverse of this function is defined, and a tool
might use this inverse function instead, in order to avoid the solution of a nonlinear equation.
</p>

<p>
The details of the model are described in the
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_edgedOverall\">documentation of the underlying function</a>.
</p>

</html>"));
    end EdgedBend;
  end Bends;

  package Orifices "Flow models for orifices"
    extends Modelica.Icons.VariantsPackage;

    model ThickEdgedOrifice "Thicked edged orifice flow model"
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Orifice_i;
      extends Modelica.Fluid.Interfaces.PartialPressureLoss;

      parameter
        Modelica.Fluid.Fittings.BaseClasses.Orifices.ThickEdgedOrifice.Geometry
                                                                                geometry
        "Geometry of thick edged orifice"
          annotation (Placement(transformation(extent={{-20,0},{0,20}})),
          choices(
          choice=Modelica.Fluid.Fittings.BaseClasses.Orifices.ThickEdgedOrifice.Choices.circular(),
          choice=Modelica.Fluid.Fittings.BaseClasses.Orifices.ThickEdgedOrifice.Choices.rectangular(),
          choice=Modelica.Fluid.Fittings.BaseClasses.Orifices.ThickEdgedOrifice.Choices.general()));

    protected
      parameter Medium.AbsolutePressure dp_small(min=0)=
                 Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP(
                 Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con(
                       A_0=geometry.venaCrossArea,
                       A_1=geometry.crossArea,
                       C_0=geometry.venaPerimeter,
                       C_1=geometry.perimeter,
                       L=geometry.venaLength,
                       dp_smooth=1e-10),
                    Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var(
                      rho=Medium.density(state_dp_small),
                      eta=Medium.dynamicViscosity(state_dp_small)),
                    m_flow_small)
        "Default small pressure drop for regularization of laminar and zero flow (calculated from m_flow_small)";
    equation
      if allowFlowReversal then
         m_flow = Modelica.Fluid.Fittings.BaseClasses.Orifices.ThickEdgedOrifice.massFlowRate(
                    dp, geometry, d_a, d_b, eta_a, eta_b, dp_small, m_flow_small);
      else
         m_flow = Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW(
                     Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con(
                       A_0=geometry.venaCrossArea,
                       A_1=geometry.crossArea,
                       C_0=geometry.venaPerimeter,
                       C_1=geometry.perimeter,
                       L=geometry.venaLength,
                       dp_smooth=dp_small),
                    Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var(rho=d_a, eta=eta_a), dp);
      end if;

      annotation (Documentation(info="<html>
<p>
This component models a <strong>thick edged orifice</strong> with sharp corners in the overall flow regime for incompressible and single-phase fluid flow through an arbitrary shaped cross sectional area (square, circular, etc.) considering  influence of surface roughness. It is expected that also compressible fluid flow can be handled up to about Ma = 0.3. It is assumed that neither mass nor energy is stored in this component.
In the model basically a function is called to compute the mass flow rate as a function
of pressure loss for a thick edged orifice. Also the inverse of this function is defined, and a tool
might use this inverse function instead, in order to avoid the solution of a nonlinear equation.
</p>

<p>
The details of the model are described in the
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_thickEdgedOverall\">documentation of the underlying function</a>.
</p>

</html>"));
    end ThickEdgedOrifice;

  end Orifices;

  package GenericResistances "Flow models for generic resistances"
  extends Modelica.Icons.VariantsPackage;

    model VolumeFlowRate
      "Flow model for generic resistance parameterized with the volume flow rate"

      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.General_i;
      extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;

      parameter Real a(unit="(Pa.s2)/m6") "Coefficient for quadratic term"
        annotation(Dialog(group="dp = a*V_flow^2 + b*V_flow"));
      parameter Real b(unit="(Pa.s)/m3") "Coefficient for linear term"
        annotation(Dialog(group="dp = a*V_flow^2 + b*V_flow"));

    protected
      parameter Medium.ThermodynamicState state_dp_small=Medium.setState_pTX(
                           Medium.reference_p,
                           Medium.reference_T,
                           Medium.reference_X)
        "Medium state to compute dp_small";
      parameter Medium.AbsolutePressure dp_small(min=0)=
                 Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP(
                   Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_con(
                       a=a,
                       b=b,
                       dp_min=1e-10),
                    Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_var(
                      rho=Medium.density(state_dp_small)),
                    m_flow_small)
        "Default small pressure drop for regularization of laminar and zero flow (calculated from m_flow_small)";
      Medium.Density d_a
        "Density at port_a when fluid is flowing from port_a to port_b";
      Medium.Density d_b
        "If allowFlowReversal=true then Density at port_b when fluid is flowing from port_b to port_a else d_a";

    equation
      // Isenthalpic state transformation (no storage and no loss of energy)
      port_a.h_outflow = inStream(port_b.h_outflow);
      port_b.h_outflow = inStream(port_a.h_outflow);

      // Medium properties
      d_a = Medium.density(state_a);
      if allowFlowReversal then
        d_b = Medium.density(state_b);
      else
        d_b = d_a;
      end if;

      if allowFlowReversal then
         m_flow = Modelica.Fluid.Fittings.BaseClasses.GenericResistances.VolumeFlowRate.massFlowRate(
                    dp, a, b, d_a, d_b, dp_small, m_flow_small);
      else
         m_flow = Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW(
                   Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_con(
                       a=a,
                       b=b,
                       dp_min=dp_small),
                    Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_var(rho=d_a), dp);
      end if;

      annotation (Documentation(info="<html>
<p>
This component models a generic resistance parameterized
with the volume flow rate:
</p>

<pre>
    dp     = a*V_flow^2 + b*V_flow
    m_flow = rho*V_flow
</pre>

<p>
with
</p>

<table>
<tr><td><strong> a              </strong></td><td> as quadratic coefficient [Pa*s^2/m^6],</td></tr>
<tr><td><strong> b              </strong></td><td> as linear coefficient [Pa*s/m3],</td></tr>
<tr><td><strong> dp             </strong></td><td> as pressure loss [Pa],</td></tr>
<tr><td><strong> m_flow         </strong></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><strong> rho            </strong></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><strong> V_flow         </strong></td><td> as volume flow rate [m3/s].</td></tr>
</table>

<p>
The geometry parameters of energy devices necessary for the pressure loss calculations are often not exactly known. Therefore the modelling of the detailed pressure loss calculation has to be simplified. This components use a linear and a quadratic dependence of the pressure loss on the volume flow rate. It is assumed that neither mass nor energy is stored in this component.
In the model basically a function is called to compute the mass flow rate as a function
of pressure loss. Also the inverse of this function is defined, and a tool
might use this inverse function instead, in order to avoid the solution of a nonlinear equation.
</p>

<p>
The details of the model are described in the
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_volumeFlowRate\">documentation of the underlying function</a>.
</p>

</html>"));
    end VolumeFlowRate;
    annotation (Documentation(info="<html>
<p>
The geometry parameters of energy devices necessary for the pressure loss
calculations are often not exactly known. Therefore the modelling of the detailed
pressure loss calculation has to be simplified.
In this package components are present that provide different forms of
such approximations.
</p>
</html>"));
  end GenericResistances;

     extends Modelica.Icons.VariantsPackage;

model SimpleGenericOrifice
    "Simple generic orifice defined by pressure loss coefficient and diameter (only for flow from port_a to port_b)"

  extends Modelica.Fluid.Interfaces.PartialTwoPortTransport(
    dp_start = dp_nominal,
    m_flow_small = if system.use_eps_Re then system.eps_m_flow*m_flow_nominal else system.m_flow_small,
    m_flow(stateSelect = if momentumDynamics == Types.Dynamics.SteadyState then StateSelect.default
                         else StateSelect.prefer));

  extends Modelica.Fluid.Interfaces.PartialLumpedFlow(
    final pathLength = 0,
    final momentumDynamics = Types.Dynamics.SteadyState);

  parameter SI.Diameter diameter "Diameter of orifice";
  parameter Real zeta "Loss factor for flow of port_a -> port_b"
    annotation(Dialog(enable=use_zeta));
  parameter Boolean use_zeta = true
      "= false to obtain zeta from dp_nominal and m_flow_nominal";

  // Operational conditions
  parameter SI.MassFlowRate m_flow_nominal = if system.use_eps_Re then system.m_flow_nominal else 1e2*system.m_flow_small
      "Mass flow rate for dp_nominal"
    annotation(Dialog(group="Nominal operating point"));
  parameter SI.Pressure dp_nominal = if not system.use_eps_Re then 1e3 else
   BaseClasses.lossConstant_D_zeta(diameter, zeta)/Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default)*m_flow_nominal^2
      "Nominal pressure drop"
    annotation(Dialog(group="Nominal operating point"));

  parameter Boolean use_Re = system.use_eps_Re
      "= true, if turbulent region is defined by Re, otherwise by m_flow_small"
    annotation(Dialog(tab="Advanced"), Evaluate=true);

  parameter Boolean from_dp = true
      "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));

  protected
  parameter Medium.AbsolutePressure dp_small(min=0) = if system.use_eps_Re then dp_nominal/m_flow_nominal*m_flow_small else system.dp_small
      "Regularization of zero flow if |dp| < dp_small"
    annotation(Dialog(tab="Advanced", enable=not use_Re and from_dp));

  // Variables
  public
  Real zeta_nominal;
  Medium.Density d = 0.5*(Medium.density(state_a) + Medium.density(state_b));
  Modelica.SIunits.Pressure dp_fg(start=dp_start)
      "pressure loss due to friction and gravity";
  Modelica.SIunits.Area A_mean = Modelica.Constants.pi/4*diameter^2
      "mean cross flow area";

  constant SI.ReynoldsNumber Re_turbulent = 10000 "cf. sharpEdgedOrifice";
  SI.MassFlowRate m_flow_turbulent=if not use_Re then m_flow_small else
    max(m_flow_small,
        (Modelica.Constants.pi/8)*diameter*(Medium.dynamicViscosity(state_a) + Medium.dynamicViscosity(state_b))*Re_turbulent);
  SI.AbsolutePressure dp_turbulent=if not use_Re then dp_small else
    max(dp_small, BaseClasses.lossConstant_D_zeta(diameter, zeta_nominal)/d*m_flow_turbulent^2);
equation
  if use_zeta then
    zeta_nominal = zeta;
  else
    zeta_nominal = 2*A_mean^2*d*dp_nominal/m_flow_nominal^2;
  end if;

  Ib_flow = 0;
  F_p = A_mean*(Medium.pressure(state_b) - Medium.pressure(state_a));
  F_fg = A_mean*dp_fg;

  /*
   dp = 0.5*zeta*d*v*|v|
      = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
      = k/d * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
  */
  if from_dp then
    m_flow = homotopy(Utilities.regRoot2(
                         dp_fg,
                         dp_turbulent,
                         Medium.density(state_a)/BaseClasses.lossConstant_D_zeta(diameter, zeta_nominal),
                         Medium.density(state_b)/BaseClasses.lossConstant_D_zeta(diameter, zeta_nominal)),
                       m_flow_nominal*dp_fg/dp_nominal);
  else
    dp_fg = homotopy(Utilities.regSquare2(
                         m_flow,
                         m_flow_turbulent,
                         BaseClasses.lossConstant_D_zeta(diameter, zeta_nominal)/Medium.density(state_a),
                         BaseClasses.lossConstant_D_zeta(diameter, zeta_nominal)/Medium.density(state_b)),
                     dp_nominal*m_flow/m_flow_nominal);
  end if;

  // Isenthalpic state transformation (no storage and no loss of energy)
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);

  annotation (defaultComponentName="orifice",
    Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
          Line(
            points={{-60,-50},{-60,50},{60,-50},{60,50}},
            thickness=0.5),
          Line(points={{-60,0},{-100,0}}, color={0,127,255}),
          Line(points={{60,0},{100,0}}, color={0,127,255}),
          Text(
            extent={{-173,104},{175,62}},
            textString="zeta=%zeta")}),
    Documentation(info="<html>
<p>
This pressure drop component defines a
simple, generic orifice, where the loss factor &zeta; is provided
for one flow direction (e.g., from loss table of a book):
</p>

<pre>   &Delta;p = 0.5*&zeta;*&rho;*v*|v|
      = 8*&zeta;/(&pi;^2*D^4*&rho;) * m_flow*|m_flow|
</pre>

<p>
where
</p>
<ul>
<li> &Delta;p is the pressure drop: &Delta;p = port_a.p - port_b.p</li>
<li> D is the diameter of the orifice at the position where
     &zeta; is defined (either at port_a or port_b). If the orifice has not a
     circular cross section, D = 4*A/P, where A is the cross section
     area and P is the wetted perimeter.</li>
<li> &zeta; is the loss factor with respect to D
     that depends on the geometry of
     the orifice. In the turbulent flow regime, it is assumed that
     &zeta; is constant.<br>
     For small mass flow rates, the flow is laminar and is approximated
     by a polynomial that has a finite derivative for m_flow=0.</li>
<li> v is the mean velocity.</li>
<li> &rho; is the upstream density.</li>
</ul>

<p>
Since the pressure loss factor zeta is provided only for a mass flow
from port_a to port_b, the pressure loss is not correct when the
flow is reversing. If reversing flow only occurs in a short time interval,
this is most likely uncritical. If significant reversing flow
can appear, this component should not be used.
</p>
</html>"));
end SimpleGenericOrifice;

model SharpEdgedOrifice
    "Pressure drop due to sharp edged orifice (for both flow directions)"
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  extends BaseClasses.QuadraticTurbulent.BaseModel(final data=
          BaseClasses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice(
          diameter,
          leastDiameter,
          length,
          alpha));
  parameter SI.Length length "Length of orifice";
  parameter SI.Diameter diameter
      "Inner diameter of pipe (= same at port_a and port_b)";
  parameter SI.Diameter leastDiameter "Smallest diameter of orifice";
  parameter NonSI.Angle_deg alpha "Angle of orifice";
  annotation (defaultComponentName="orifice",
    Documentation(info="<html>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            extent={{-100,44},{100,-44}},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255}),
          Polygon(
            points={{-25,44},{-25,7},{35,37},{35,44},{-25,44}},
            fillPattern=FillPattern.Backward,
            fillColor={175,175,175}),
          Polygon(
            points={{-25,-7},{-25,-44},{35,-44},{35,-36},{-25,-7}},
            fillColor={175,175,175},
            fillPattern=FillPattern.Backward)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={
          Rectangle(
            extent={{-100,60},{100,-60}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-30,60},{-30,12},{30,50},{30,60},{-30,60}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
          Polygon(
            points={{-30,-10},{-30,-60},{30,-60},{30,-50},{-30,-10}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
          Line(
            points={{-82,-60},{-82,60}},
            color={0,0,255},
            arrow={Arrow.Filled,Arrow.Filled}),
          Text(
            extent={{-78,16},{-44,-8}},
            lineColor={0,0,255},
            textString="diameter"),
          Line(
            points={{-30,-10},{-30,12}},
            color={0,0,255},
            arrow={Arrow.Filled,Arrow.Filled}),
          Text(
            extent={{-24,14},{8,-10}},
            lineColor={0,0,255},
            textString="leastDiameter"),
          Text(
            extent={{-20,84},{18,70}},
            lineColor={0,0,255},
            textString="length"),
          Line(
            points={{30,68},{-30,68}},
            color={0,0,255},
            arrow={Arrow.Filled,Arrow.Filled}),
          Line(
            points={{16,40},{32,18},{36,-2},{34,-20},{20,-42}},
            color={0,0,255},
            arrow={Arrow.Filled,Arrow.Filled}),
          Text(
            extent={{38,8},{92,-6}},
            lineColor={0,0,255},
            textString="alpha")}));

end SharpEdgedOrifice;

model AbruptAdaptor
    "Pressure drop in pipe due to suddenly expanding or reducing area (for both flow directions)"
  extends BaseClasses.QuadraticTurbulent.BaseModelNonconstantCrossSectionArea(final data=
          BaseClasses.QuadraticTurbulent.LossFactorData.suddenExpansion(
          diameter_a, diameter_b));
  parameter SI.Diameter diameter_a "Inner diameter of pipe at port_a";
  parameter SI.Diameter diameter_b "Inner diameter of pipe at port_b";

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={
          Line(points={{0,40},{-100,40},{-100,-40},{0,-40},{0,-100},{100,-100},
                {100,100},{0,100},{0,40}}),
          Rectangle(
            extent={{-100,40},{0,-40}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{0,100},{100,-100}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{0,40},{-100,40},{-100,-40},{0,-40},{0,-100},{100,-100},
                {100,100},{0,100},{0,40}}),
          Line(
            points={{-60,-40},{-60,40}},
            color={0,0,255},
            arrow={Arrow.Filled,Arrow.Filled}),
          Text(
            extent={{-50,16},{-26,-10}},
            lineColor={0,0,255},
            textString="diameter_a"),
          Line(
            points={{34,-100},{34,100}},
            color={0,0,255},
            arrow={Arrow.Filled,Arrow.Filled}),
          Text(
            extent={{54,16},{78,-10}},
            lineColor={0,0,255},
            textString="diameter_b")}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={Rectangle(
            extent=DynamicSelect({{-100,22},{0,-22}}, {{-100,max(0.1, min(1,
                diameter_a/max(diameter_a, diameter_b)))*60},{0,-max(0.1, min(1,
                diameter_a/max(diameter_a, diameter_b)))*60}}),
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255}), Rectangle(
            extent=DynamicSelect({{0,60},{100,-60}}, {{0,max(0.1, min(1,
                diameter_b/max(diameter_a, diameter_b)))*60},{100,-max(0.1, min(
                1, diameter_b/max(diameter_a, diameter_b)))*60}}),
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255})}),
      Documentation(info="<html>

</html>"));
end AbruptAdaptor;

  model MultiPort
    "Multiply a port; useful if multiple connections shall be made to a port exposing a state"

    function positiveMax
      extends Modelica.Icons.Function;
      input Real x;
      output Real y;
    algorithm
      y :=max(x, 1e-10);
    end positiveMax;

    import Modelica.Constants;

    replaceable package Medium=Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching);

    // Ports
    parameter Integer nPorts_b=0
      "Number of outlet ports (mass is distributed evenly between the outlet ports"
      annotation(Dialog(connectorSizing=true));

    Modelica.Fluid.Interfaces.FluidPort_a port_a(
      redeclare package Medium=Medium)
      annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    Modelica.Fluid.Interfaces.FluidPorts_b ports_b[nPorts_b](
      redeclare each package Medium=Medium)
      annotation (Placement(transformation(extent={{30,40},{50,-40}})));

    Medium.MassFraction ports_b_Xi_inStream[nPorts_b,Medium.nXi]
      "inStream mass fractions at ports_b";
    Medium.ExtraProperty ports_b_C_inStream[nPorts_b,Medium.nC]
      "inStream extra properties at ports_b";

  equation
    // Only one connection allowed to a port to avoid unwanted ideal mixing
    for i in 1:nPorts_b loop
      assert(cardinality(ports_b[i]) <= 1,"
each ports_b[i] of boundary shall at most be connected to one component.
If two or more connections are present, ideal mixing takes
place with these connections, which is usually not the intention
of the modeller. Increase nPorts_b to add an additional port.
");
    end for;

    // mass and momentum balance
    0 = port_a.m_flow + sum(ports_b.m_flow);
    ports_b.p = fill(port_a.p, nPorts_b);

    // mixing at port_a
    port_a.h_outflow = sum({positiveMax(ports_b[j].m_flow)*inStream(ports_b[j].h_outflow) for j in 1:nPorts_b})
                         / sum({positiveMax(ports_b[j].m_flow) for j in 1:nPorts_b});
    for j in 1:nPorts_b loop
       // expose stream values from port_a to ports_b
       ports_b[j].h_outflow  = inStream(port_a.h_outflow);
       ports_b[j].Xi_outflow = inStream(port_a.Xi_outflow);
       ports_b[j].C_outflow  = inStream(port_a.C_outflow);

       ports_b_Xi_inStream[j,:] = inStream(ports_b[j].Xi_outflow);
       ports_b_C_inStream[j,:] = inStream(ports_b[j].C_outflow);
    end for;
    for i in 1:Medium.nXi loop
      port_a.Xi_outflow[i] = (positiveMax(ports_b.m_flow)*ports_b_Xi_inStream[:,i])
                           / sum(positiveMax(ports_b.m_flow));
    end for;
    for i in 1:Medium.nC loop
      port_a.C_outflow[i] = (positiveMax(ports_b.m_flow)*ports_b_C_inStream[:,i])
                           / sum(positiveMax(ports_b.m_flow));
    end for;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-40,
              -100},{40,100}}), graphics={
          Line(
            points={{-40,0},{40,0}},
            color={0,128,255},
            thickness=1),
          Line(
            points={{-40,0},{40,26}},
            color={0,128,255},
            thickness=1),
          Line(
            points={{-40,0},{40,-26}},
            color={0,128,255},
            thickness=1),
          Text(
            extent={{-150,100},{150,60}},
            lineColor={0,0,255},
            textString="%name")}),
                            Documentation(info="<html>
<p>
This model is useful if multiple connections shall be made to a port of a volume model exposing a state,
like a pipe with ModelStructure av_vb.
The mixing is shifted into the volume connected to port_a and the result is propagated back to each ports_b.
</p>
<p>
If multiple connections were directly made to the volume,
then ideal mixing would take place in the connection set, outside the volume. This is normally not intended.
</p>
</html>"));
  end MultiPort;

  model TeeJunctionIdeal
    "Splitting/joining component with static balances for an infinitesimal control volume"
    extends Modelica.Fluid.Fittings.BaseClasses.PartialTeeJunction;

  equation
    connect(port_1, port_2) annotation (Line(
        points={{-100,0},{100,0}}, color={0,127,255}));
    connect(port_1, port_3) annotation (Line(
        points={{-100,0},{0,0},{0,100}}, color={0,127,255}));
    annotation(Documentation(info="<html>
  This model is the simplest implementation for a splitting/joining component for
  three flows. Its use is not required. It just formulates the balance
  equations in the same way that the connect semantics would formulate them anyways.
  The main advantage of using this component is, that the user does not get
  confused when looking at the specific enthalpy at each port which might be confusing
  when not using a splitting/joining component. The reason for the confusion is that one examines the mixing
  enthalpy of the infinitesimal control volume introduced with the connect statement when
  looking at the specific enthalpy in the connector which
  might not be equal to the specific enthalpy at the port in the \"real world\".</html>"));
  end TeeJunctionIdeal;

  model TeeJunctionVolume
    "Splitting/joining component with static balances for a dynamic control volume"
    extends Modelica.Fluid.Fittings.BaseClasses.PartialTeeJunction;
    extends Modelica.Fluid.Interfaces.PartialLumpedVolume(
      final fluidVolume = V);

    parameter SI.Volume V "Mixing volume inside junction";

  equation
    // Only one connection allowed to a port to avoid unwanted ideal mixing
    assert(cardinality(port_1) <= 1,"
port_1 of volume can at most be connected to one component.
If two or more connections are present, ideal mixing takes
place with these connections which is usually not the intention
of the modeller.
");
    assert(cardinality(port_2) <= 1,"
port_2 of volume can at most be connected to one component.
If two or more connections are present, ideal mixing takes
place with these connections which is usually not the intention
of the modeller.
");
    assert(cardinality(port_3) <= 1,"
port_3 of volume can at most be connected to one component.
If two or more connections are present, ideal mixing takes
place with these connections which is usually not the intention
of the modeller.
");

    // Boundary conditions
    port_1.h_outflow = medium.h;
    port_2.h_outflow = medium.h;
    port_3.h_outflow = medium.h;

    port_1.Xi_outflow = medium.Xi;
    port_2.Xi_outflow = medium.Xi;
    port_3.Xi_outflow = medium.Xi;

    port_1.C_outflow = C;
    port_2.C_outflow = C;
    port_3.C_outflow = C;

    // Mass balances
    mb_flow = port_1.m_flow + port_2.m_flow + port_3.m_flow "Mass balance";
    mbXi_flow = port_1.m_flow*actualStream(port_1.Xi_outflow)
                + port_2.m_flow*actualStream(port_2.Xi_outflow)
                + port_3.m_flow*actualStream(port_3.Xi_outflow)
      "Component mass balances";

    mbC_flow  = port_1.m_flow*actualStream(port_1.C_outflow)
              + port_2.m_flow*actualStream(port_2.C_outflow)
              + port_3.m_flow*actualStream(port_3.C_outflow)
      "Trace substance mass balances";

    // Momentum balance (suitable for compressible media)
    port_1.p = medium.p;
    port_2.p = medium.p;
    port_3.p = medium.p;

    // Energy balance
    Hb_flow = port_1.m_flow*actualStream(port_1.h_outflow)
              + port_2.m_flow*actualStream(port_2.h_outflow)
              + port_3.m_flow*actualStream(port_3.h_outflow);
    Qb_flow = 0;
    Wb_flow = 0;

    annotation (Documentation(info="<html>
  This model introduces a mixing volume into a junction.
  This might be useful to examine the non-ideal mixing taking place in a real junction.</html>"),
  Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Ellipse(
            extent={{-9,10},{11,-10}},
            fillPattern=FillPattern.Solid)}));
  end TeeJunctionVolume;

  package BaseClasses
    "Base classes used in the Fittings package (only of interest to build new component models)"
    extends Modelica.Icons.BasesPackage;

    function lossConstant_D_zeta "Return the loss constant 8*zeta/(pi^2*D^4)"
          extends Modelica.Icons.Function;

      input SI.Diameter D "Diameter at port_a or port_b";
      input Real zeta
        "Constant pressure loss factor with respect to D (i.e., either port_a or port_b)";
      output Real k "Loss constant (= 8*zeta/(pi^2*D^4))";

    algorithm
      k :=8*zeta/(Modelica.Constants.pi*Modelica.Constants.pi*D*D*D*D);
      annotation (Documentation(info="<html>

</html>"));
    end lossConstant_D_zeta;

    package QuadraticTurbulent
      "Pressure loss components that are mainly defined by a quadratic turbulent regime with constant loss factor data"
      extends Modelica.Icons.Package;
     record LossFactorData
        "Data structure defining constant loss factor data for dp = zeta*rho*v*|v|/2 and functions providing the data for some loss types"

            extends Modelica.Icons.Record;

      SI.Diameter diameter_a "Diameter at port_a" annotation(Dialog);
      SI.Diameter diameter_b "Diameter at port_b" annotation(Dialog);
      Real zeta1 "Loss factor for flow port_a -> port_b" annotation(Dialog);
      Real zeta2 "Loss factor for flow port_b -> port_a" annotation(Dialog);
      SI.ReynoldsNumber Re_turbulent
          "Loss factors suited for Re >= Re_turbulent" annotation(Dialog);
      SI.Diameter D_Re "Diameter used to compute Re" annotation(Dialog);
      Boolean zeta1_at_a = true
          "dp = zeta1*(if zeta1_at_a then rho_a*v_a^2/2 else rho_b*v_b^2/2)"
                                                                        annotation(Dialog);
      Boolean zeta2_at_a = false
          "dp = -zeta2*(if zeta2_at_a then rho_a*v_a^2/2 else rho_b*v_b^2/2)"
                                                                         annotation(Dialog);
      Boolean zetaLaminarKnown = false
          "= true, if zeta = c0/Re in laminar region" annotation(Dialog);
      Real c0 = 1
          "zeta = c0/Re; dp = zeta*rho_Re*v_Re^2/2, Re=v_Re*D_Re*rho_Re/mu_Re)"
                                                                                        annotation(Dialog(enable=zetaLaminarKnown));

       encapsulated function wallFriction
          "Return pressure loss data due to friction in a straight pipe with walls of nonuniform roughness (not useful for smooth pipes, since zeta is no function of Re)"
          import
            Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData;
          import lg = Modelica.Math.log10;
          import SI = Modelica.SIunits;

         input SI.Length length "Length of pipe" annotation(Dialog);
         input SI.Diameter diameter "Inner diameter of pipe" annotation(Dialog);
         input SI.Length roughness(min=1e-10)
            "Absolute roughness of pipe (> 0 required, details see info layer)"
                                                                               annotation(Dialog);
         output LossFactorData data
            "Pressure loss factors for both flow directions";
        protected
         Real Delta = roughness/diameter "relative roughness";
       algorithm
         data.diameter_a          := diameter;
         data.diameter_b          := diameter;
         data.zeta1        := (length/diameter)/(2*lg(3.7 /Delta))^2;
         data.zeta2        := data.zeta1;
         data.Re_turbulent := 4000
            ">= 560/Delta flow does not depend on Re, but interpolation is bad";
         data.D_Re         := diameter;
         data.zeta1_at_a   := true;
         data.zeta2_at_a   := false;
         data.zetaLaminarKnown := true;
         data.c0               := 64*(length/diameter);
         annotation (Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}}), graphics={Rectangle(
                  extent={{-100,50},{100,-50}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
                                   Diagram(coordinateSystem(
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
                  lineColor={0,0,255},
                  textString="diameter"),
                Line(
                  points={{-100,74},{100,74}},
                  color={0,0,255},
                  arrow={Arrow.Filled,Arrow.Filled}),
                Text(
                  extent={{-34,92},{34,74}},
                  lineColor={0,0,255},
                  textString="length")}),
           Documentation(info="<html>
<p>
Friction in straight pipe with walls of nonuniform roughness
(commercial pipes) in the region that does not depend on the Reynolds-number
</p>
<p>
The loss factors are given for mass flow rates from
port_a to port_b as:
</p>
<pre>
  turbulent flow (Idelchik 1994, diagram 2-5, p. 117)
     zeta = (L/D)/(2*lg(3.7 / &Delta;))^2, for Re >= 560/&Delta;
&nbsp;
     for Re &ge; 560/&Delta; the loss factor does not depend on the
     Reynolds number. For Re &ge; 4000, the flow is turbulent,
     but depends both on &Delta; and slightly on Re.
&nbsp;
  laminar flow (Idelchik 1994, diagram 2-1, p. 110):
     zeta = 64*(L/D)/Re
</pre>
<p>
where
</p>
<ul>
<li> D is the inner pipe diameter</li>
<li> L is the length of the pipe</li>
<li> &Delta; = &delta;/D is the relative roughness where &delta; is
     the absolute \"roughness\", i.e., the averaged height of asperities in the pipe.
     (&delta; may change over time due to growth of surface asperities during
      service, see [Idelchik 1994, p. 85, Tables 2-1, 2-2]).</li>
</ul>

<p>
Since the LossFactorData record can only describe loss factors that depend
on geometry (but, e.g., not on the Reynolds number), only the region
with Re &ge; 560/&Delta; is described by this data. Still, the turbulent
region with the above zeta is defined to start at Re=4000, since otherwise
the approximation for Re &lt; 560/&Delta; is too bad.
</p>

<p>
The absolute roughness <font face=\"Symbol\">d</font> has usually to
be estimated. In <em>[Idelchik 1994, pp. 105-109,
Table 2-5; Miller 1990, p. 190, Table 8-1]</em> many examples are given.
As a short summary:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><strong>Smooth pipes</strong></td>
      <td>Drawn brass, copper, aluminium, glass, etc.</td>
      <td><font face=\"Symbol\">d</font> = 0.0025 mm</td>
  </tr>
  <tr><td rowspan=\"3\"><strong>Steel pipes</strong></td>
      <td>New smooth pipes</td>
      <td><font face=\"Symbol\">d</font> = 0.025 mm</td>
  </tr>
  <tr><td>Mortar lined, average finish</td>
      <td><font face=\"Symbol\">d</font> = 0.1 mm</td>
  </tr>
  <tr><td>Heavy rust</td>
      <td><font face=\"Symbol\">d</font> = 1 mm</td>
  </tr>
  <tr><td rowspan=\"3\"><strong>Concrete pipes</strong></td>
      <td>Steel forms, first class workmanship</td>
      <td><font face=\"Symbol\">d</font> = 0.025 mm</td>
  </tr>
  <tr><td>Steel forms, average workmanship</td>
      <td><font face=\"Symbol\">d</font> = 0.1 mm</td>
  </tr>
  <tr><td>Block linings</td>
      <td><font face=\"Symbol\">d</font> = 1 mm</td>
  </tr>
</table>
</html>"));
       end wallFriction;

       encapsulated function suddenExpansion
          "Return pressure loss data for sudden expansion or contraction in a pipe (for both flow directions)"
          import
            Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData;
          import SI = Modelica.SIunits;
         input SI.Diameter diameter_a "Inner diameter of pipe at port_a" annotation(Dialog);
         input SI.Diameter diameter_b "Inner diameter of pipe at port_b" annotation(Dialog);
         output LossFactorData data
            "Pressure loss factors for both flow directions";
        protected
         Real A_rel;
       algorithm
         data.diameter_a          := diameter_a;
         data.diameter_b          := diameter_b;
         data.Re_turbulent := 100;
         data.zetaLaminarKnown := true;
         data.c0 := 30;

         if diameter_a <= diameter_b then
            A_rel :=(diameter_a/diameter_b)^2;
            data.zeta1 :=(1 - A_rel)^2;
            data.zeta2 :=0.5*(1 - A_rel)^0.75;
            data.zeta1_at_a :=true;
            data.zeta2_at_a :=true;
            data.D_Re := diameter_a;
         else
            A_rel :=(diameter_b/diameter_a)^2;
            data.zeta1 :=0.5*(1 - A_rel)^0.75;
            data.zeta2 :=(1 - A_rel)^2;
            data.zeta1_at_a :=false;
            data.zeta2_at_a :=false;
            data.D_Re := diameter_b;
         end if;
         annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={
                Rectangle(
                  extent={{-100,40},{0,-40}},
                  lineColor={255,255,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{0,100},{100,-100}},
                  lineColor={255,255,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{0,40},{-100,40},{-100,-40},{0,-40},{0,-100},{100,
                      -100},{100,100},{0,100},{0,40}})}),
                                   Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                graphics={
                Line(points={{0,40},{-100,40},{-100,-40},{0,-40},{0,-100},{100,
                      -100},{100,100},{0,100},{0,40}}),
                Rectangle(
                  extent={{-100,40},{0,-40}},
                  lineColor={255,255,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{0,100},{100,-100}},
                  lineColor={255,255,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{0,40},{-100,40},{-100,-40},{0,-40},{0,-100},{100,
                      -100},{100,100},{0,100},{0,40}}),
                Line(
                  points={{-60,-40},{-60,40}},
                  color={0,0,255},
                  arrow={Arrow.Filled,Arrow.Filled}),
                Text(
                  extent={{-50,16},{-26,-10}},
                  lineColor={0,0,255},
                  textString="diameter_a"),
                Line(
                  points={{34,-100},{34,100}},
                  color={0,0,255},
                  arrow={Arrow.Filled,Arrow.Filled}),
                Text(
                  extent={{54,16},{78,-10}},
                  lineColor={0,0,255},
                  textString="diameter_b")}),
           Documentation(info="<html>
<p>
The loss factors are given for mass flow rates from
port_a to port_b as:
</p>
<pre>
   A_a &lt; A_b (Idelchik 1994, diagram 4-1, p. 208):
      zeta = dp/(rho_a*v_a^2/2)
           = (1 - A_a/A_b)^2 for Re_a &ge; 3.3e3 (turbulent flow)
      zeta = 30/Re           for Re_a &lt; 10    (laminar flow)
&nbsp;
   A_a &gt; A_b (Idelchik 1994, diagram 4-9, p. 216 and diagram 4-10, p. 217)
      zeta = dp/(rho_b*v_b^2/2)
           = 0.5*(1 - A_b/A_a)^0.75 for Re_b &ge; 1e4 (turbulent flow)
      zeta = 30/Re                  for Re_a &lt; 10  (laminar flow)
</pre>
</html>"));
       end suddenExpansion;

       encapsulated function sharpEdgedOrifice
          "Return pressure loss data for sharp edged orifice (for both flow directions)"
          import NonSI = Modelica.SIunits.Conversions.NonSIunits;
          import
            Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData;
          import SI = Modelica.SIunits;
          input SI.Diameter diameter
            "Inner diameter of pipe (= same at port_a and port_b)"
                                                                  annotation(Dialog);
          input SI.Diameter leastDiameter "Smallest diameter of orifice"
                                                                annotation(Dialog);
          input SI.Diameter length "Length of orifice"
                                                 annotation(Dialog);
          input NonSI.Angle_deg alpha "Angle of orifice"
                                                        annotation(Dialog);
          output LossFactorData data
            "Pressure loss factors for both flow directions";
        protected
          Real D_rel=leastDiameter/diameter;
          Real LD=length/leastDiameter;
          Real k=0.13 + 0.34*10^(-(3.4*LD + 88.4*LD^2.3));
       algorithm
          data.diameter_a := diameter;
          data.diameter_b := diameter;
          data.zeta1 := ((1 - D_rel) + 0.707*(1 - D_rel)^0.375)^2*(1/D_rel)^2;
          data.zeta2 := k*(1 - D_rel)^0.75 + (1 - D_rel)^2 + 2*sqrt(k*(1 -
            D_rel)^0.375) + (1 - D_rel);
          data.Re_turbulent := 1e4;
          data.D_Re := leastDiameter;
          data.zeta1_at_a := true;
          data.zeta2_at_a := false;
          data.zetaLaminarKnown := false;
          data.c0 := 0;
          annotation (
            Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={
                Rectangle(
                  extent={{-100,60},{100,-60}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-30,60},{-30,12},{30,50},{30,60},{-30,60}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Backward),
                Polygon(
                  points={{-30,-10},{-30,-60},{30,-60},{30,-50},{-30,-10}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Backward)}),
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={
                Rectangle(
                  extent={{-100,60},{100,-60}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-30,60},{-30,12},{30,50},{30,60},{-30,60}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Backward),
                Polygon(
                  points={{-30,-10},{-30,-60},{30,-60},{30,-50},{-30,-10}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Backward),
                Line(
                  points={{-82,-60},{-82,60}},
                  color={0,0,255},
                  arrow={Arrow.Filled,Arrow.Filled}),
                Text(
                  extent={{-78,16},{-44,-8}},
                  lineColor={0,0,255},
                  textString="diameter"),
                Line(
                  points={{-30,-10},{-30,12}},
                  color={0,0,255},
                  arrow={Arrow.Filled,Arrow.Filled}),
                Text(
                  extent={{-24,14},{8,-10}},
                  lineColor={0,0,255},
                  textString="leastDiameter"),
                Text(
                  extent={{-20,84},{18,70}},
                  lineColor={0,0,255},
                  textString="length"),
                Line(
                  points={{30,68},{-30,68}},
                  color={0,0,255},
                  arrow={Arrow.Filled,Arrow.Filled}),
                Line(
                  points={{16,40},{32,18},{36,-2},{34,-20},{20,-42}},
                  color={0,0,255},
                  arrow={Arrow.Filled,Arrow.Filled}),
                Text(
                  extent={{38,8},{92,-6}},
                  lineColor={0,0,255},
                  textString="alpha")}),
            Documentation(info="<html>
<p>
Loss factor for mass flow rate from port_a to port_b
(Idelchik 1994, diagram 4-14, p. 221):
</p>
<pre>
   zeta = [(1-A0/A1) + 0.707*(1-A0/A1)^0.375]^2*(A1/A0)^2
          for Re(A0) >= 1e5,  independent of alpha
</pre>
<p>
Loss factor for mass flow rate from port_b to port_a
(Idelchik 1994, diagram 4-13, p. 220, with A2=A1):
</p>
<pre>
   zeta = k*(1 - A0/A1)^0.75 + (1 - A0/A1)^2 + 2*sqrt(k*(1-A0/A1)^0.375) + (1- A0/A1)
          k  = 0.13 + 0.34*10^(-(3.4*LD+88.4*LD^2.3))
               (there is a typing error in the formula in diagram 4-13, the above
                equation corresponds to table (a) in diagram 4-12)
          LD = L/D0
          for Re(A0) >= 1e4, 40 deg &le; alpha &le; 60 deg
                             for other values of alpha, k is given as table
                             in diagram 3-7 (this is not yet included in the function)
</pre
</html>"));
       end sharpEdgedOrifice;

      annotation (preferredView="info", Documentation(info="<html>
<p>
This record defines the pressure loss factors of a pipe
segment (orifice, bending etc.) with a minimum amount of data.
If available, data should be provided for <strong>both flow directions</strong>,
i.e., flow from port_a to port_b and from port_b to port_a,
as well as for the <strong>laminar</strong> and the <strong>turbulent</strong> region.
It is also an option to provide the loss factor <strong>only</strong> for the
<strong>turbulent</strong> region for a flow from port_a to port_b.
</p>
<p>
The following equations are used:
</p>
<pre>   &Delta;p = 0.5*&zeta;*&rho;*v*|v|
      = 0.5*&zeta;/A^2 * (1/&rho;) * m_flow*|m_flow|
      = 8*&zeta;/(&pi;^2*D^4*&rho;) * m_flow*|m_flow|
        Re = |v|*D*&rho;/&mu;
</pre>
<table border=1 cellspacing=0 cellpadding=2>
<tr><td><strong>flow type</strong></td>
    <td><strong>&zeta;</strong> = </td>
    <td><strong>flow region</strong></td></tr>
<tr><td>turbulent</td>
    <td><strong>zeta1</strong> = const.</td>
    <td>Re &ge;  Re_turbulent, v &ge; 0</td></tr>
<tr><td></td>
    <td><strong>zeta2</strong> = const.</td>
    <td>Re &ge; Re_turbulent, v &lt; 0</td></tr>
<tr><td>laminar</td>
    <td><strong>c0</strong>/Re</td>
    <td>both flow directions, Re small; c0 = const.</td></tr>
</table>
<p>
where
</p>
<ul>
<li> &Delta;p is the pressure drop: &Delta;p = port_a.p - port_b.p</li>
<li> v is the mean velocity.</li>
<li> &rho; is the density.</li>
<li> &zeta; is the loss factor that depends on the geometry of
     the pipe. In the turbulent flow regime, it is assumed that
     &zeta; is constant and is given by \"zeta1\" and
     \"zeta2\" depending on the flow direction.<br>
     When the Reynolds number Re is below \"Re_turbulent\", the
     flow is laminar for small flow velocities. For higher
     velocities there is a transition region from
     laminar to turbulent flow. The loss factor for
     laminar flow at small velocities is defined by the often occurring
     approximation c0/Re. If c0 is different for the two
     flow directions, the mean value has to be used
     (c0 = (c0_ab + c0_ba)/2).</li>
<li> The equation \"&Delta;p = 0.5*&zeta;*&rho;*v*|v|\" is either with
     respect to port_a or to port_b, depending on the definition
     of the particular loss factor &zeta; (in some references loss
     factors are defined with respect to port_a, in other references
     with respect to port_b).</li>
<li> Re = |v|*D_Re*&rho;/&mu; = |m_flow|*D_Re/(A_Re*&mu;)
     is the Reynolds number at the smallest cross
     section area. This is often at port_a or at port_b, but can
     also be between the two ports. In the record, the diameter
     D_Re of this smallest cross section area has to be provided, as
     well, as Re_turbulent, the absolute value of the
     Reynolds number at which
     the turbulent flow starts. If Re_turbulent is different for
     the two flow directions, use the smaller value as Re_turbulent.</li>
<li> D is the diameter of the pipe. If the pipe has not a
     circular cross section, D = 4*A/P, where A is the cross section
     area and P is the wetted perimeter.</li>
<li> A is the cross section area with A = &pi;(D/2)^2.</li>
<li> &mu; is the dynamic viscosity.</li>
</ul>
<p>
The laminar and the transition region is usually of
not much technical interest because the operating point is
mostly in the turbulent regime. For simplification and for
numerical reasons, this whole region is described by two
polynomials of third order, one polynomial for m_flow &ge; 0
and one for m_flow &lt; 0. The polynomials start at
Re = |m_flow|*4/(&pi;*D_Re*&mu;), where D_Re is the
smallest diameter between port_a and port_b.
The common derivative
of the two polynomials at Re = 0 is
computed from the equation \"c0/Re\". Note, the pressure drop
equation above in the laminar region is always defined
with respect to the smallest diameter D_Re.
</p>
<p>
If no data for c0 is available, the derivative at Re = 0 is computed in such
a way, that the second derivatives of the two polynomials
are identical at Re = 0. The polynomials are constructed, such that
they smoothly touch the characteristic curves in the turbulent
regions. The whole characteristic is therefore <strong>continuous</strong>
and has a <strong>finite</strong>, <strong>continuous first derivative everywhere</strong>.
In some cases, the constructed polynomials would \"vibrate\". This is
avoided by reducing the derivative at Re=0 in such a way that
the polynomials are guaranteed to be monotonically increasing.
The used sufficient criteria for monotonicity follows from:
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <strong>Monotone piecewise cubic interpolation</strong>.
     SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246</dd>
</dl>
</html>"));
     end LossFactorData;

      function massFlowRate_dp
        "Return mass flow rate from constant loss factor data and pressure drop (m_flow = f(dp))"
              //import Modelica.Fluid.PressureLosses.BaseClasses.lossConstant_D_zeta;
        extends Modelica.Icons.Function;

        input SI.Pressure dp "Pressure drop (dp = port_a.p - port_b.p)";
        input SI.Density rho_a "Density at port_a";
        input SI.Density rho_b "Density at port_b";
        input LossFactorData data
          "Constant loss factors for both flow directions" annotation (
            choices(
            choice=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.wallFriction(),
            choice=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.suddenExpansion(),
            choice=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice()));
        input SI.AbsolutePressure dp_small = 1
          "Turbulent flow if |dp| >= dp_small";
        output SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";

      protected
        Real k1 = lossConstant_D_zeta(if data.zeta1_at_a then data.diameter_a else data.diameter_b,data.zeta1);
        Real k2 = lossConstant_D_zeta(if data.zeta2_at_a then data.diameter_a else data.diameter_b,data.zeta2);
      algorithm
        /*
   dp = 0.5*zeta*rho*v*|v|
      = 0.5*zeta*rho*1/(rho*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/rho * m_flow * |m_flow|
      = k/rho * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
  */
        m_flow :=Utilities.regRoot2(dp, dp_small, rho_a/k1, rho_b/k2);
        annotation (smoothOrder=1, Documentation(info="<html>
<p>
Compute mass flow rate from constant loss factor and pressure drop (m_flow = f(dp)).
For small pressure drops (dp &lt; dp_small), the characteristic is approximated by
a polynomial in order to have a finite derivative at zero mass flow rate.
</p>
</html>"));
      end massFlowRate_dp;

      function massFlowRate_dp_and_Re
        "Return mass flow rate from constant loss factor data, pressure drop and Re (m_flow = f(dp))"
              extends Modelica.Icons.Function;
        import Modelica.Constants.pi;
        input SI.Pressure dp "Pressure drop (dp = port_a.p - port_b.p)";
        input SI.Density rho_a "Density at port_a";
        input SI.Density rho_b "Density at port_b";
        input SI.DynamicViscosity mu_a "Dynamic viscosity at port_a";
        input SI.DynamicViscosity mu_b "Dynamic viscosity at port_b";
        input LossFactorData data
          "Constant loss factors for both flow directions" annotation (
            choices(
            choice=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.wallFriction(),
            choice=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.suddenExpansion(),
            choice=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice()));
        output SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";

      protected
        Real k0=2*data.c0/(pi*data.D_Re^3);
        Real k1 = lossConstant_D_zeta(if data.zeta1_at_a then data.diameter_a else data.diameter_b,data.zeta1);
        Real k2 = lossConstant_D_zeta(if data.zeta2_at_a then data.diameter_a else data.diameter_b,data.zeta2);
        Real yd0
          "Derivative of m_flow=m_flow(dp) at zero, if data.zetaLaminarKnown";
        SI.AbsolutePressure dp_turbulent
          "The turbulent region is: |dp| >= dp_turbulent";
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
         dp_turbulent :=(k1 + k2)/(rho_a + rho_b)*
                        ((mu_a + mu_b)*data.D_Re*pi/8)^2*data.Re_turbulent^2;
         yd0 :=if data.zetaLaminarKnown then
                  (rho_a + rho_b)/(k0*(mu_a + mu_b)) else 0;
         m_flow := Utilities.regRoot2(dp, dp_turbulent, rho_a/k1, rho_b/k2,
                                                     data.zetaLaminarKnown, yd0);
        annotation (smoothOrder=1, Documentation(info="<html>
<p>
Compute mass flow rate from constant loss factor and pressure drop (m_flow = f(dp)).
If the Reynolds-number Re &ge; data.Re_turbulent, the flow
is treated as a turbulent flow with constant loss factor zeta.
If the Reynolds-number Re &lt; data.Re_turbulent, the flow
is laminar and/or in a transition region between laminar and
turbulent. This region is approximated by two
polynomials of third order, one polynomial for m_flow &ge; 0
and one for m_flow &lt; 0.
The common derivative
of the two polynomials at Re = 0 is
computed from the equation \"data.c0/Re\".
</p>
<p>
If no data for c0 is available, the derivative at Re = 0 is computed in such
a way, that the second derivatives of the two polynomials
are identical at Re = 0. The polynomials are constructed, such that
they smoothly touch the characteristic curves in the turbulent
regions. The whole characteristic is therefore <strong>continuous</strong>
and has a <strong>finite</strong>, <strong>continuous first derivative everywhere</strong>.
In some cases, the constructed polynomials would \"vibrate\". This is
avoided by reducing the derivative at Re=0 in such a way that
the polynomials are guaranteed to be monotonically increasing.
The used sufficient criteria for monotonicity follows from:
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <strong>Monotone piecewise cubic interpolation</strong>.
     SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246</dd>
</dl>
</html>"));
      end massFlowRate_dp_and_Re;

      function pressureLoss_m_flow
        "Return pressure drop from constant loss factor and mass flow rate (dp = f(m_flow))"
              extends Modelica.Icons.Function;

        input SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";
        input SI.Density rho_a "Density at port_a";
        input SI.Density rho_b "Density at port_b";
        input LossFactorData data
          "Constant loss factors for both flow directions" annotation (
            choices(
            choice=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.wallFriction(),
            choice=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.suddenExpansion(),
            choice=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice()));
        input SI.MassFlowRate m_flow_small = 0.01
          "Turbulent flow if |m_flow| >= m_flow_small";
        output SI.Pressure dp "Pressure drop (dp = port_a.p - port_b.p)";

      protected
        Real k1 = lossConstant_D_zeta(if data.zeta1_at_a then data.diameter_a else data.diameter_b,data.zeta1);
        Real k2 = lossConstant_D_zeta(if data.zeta2_at_a then data.diameter_a else data.diameter_b,data.zeta2);
      algorithm
        /*
   dp = 0.5*zeta*rho*v*|v|
      = 0.5*zeta*rho*1/(rho*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/rho * m_flow * |m_flow|
      = k/rho * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
  */
        dp :=Utilities.regSquare2(m_flow, m_flow_small, k1/rho_a, k2/rho_b);
        annotation (smoothOrder=1, Documentation(info="<html>
<p>
Compute pressure drop from constant loss factor and mass flow rate (dp = f(m_flow)).
For small mass flow rates(|m_flow| &lt; m_flow_small), the characteristic is approximated by
a polynomial in order to have a finite derivative at zero mass flow rate.
</p>
</html>"));
      end pressureLoss_m_flow;

      function pressureLoss_m_flow_and_Re
        "Return pressure drop from constant loss factor, mass flow rate and Re (dp = f(m_flow))"
              extends Modelica.Icons.Function;
        import Modelica.Constants.pi;
        input SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";
        input SI.Density rho_a "Density at port_a";
        input SI.Density rho_b "Density at port_b";
        input SI.DynamicViscosity mu_a "Dynamic viscosity at port_a";
        input SI.DynamicViscosity mu_b "Dynamic viscosity at port_b";
        input LossFactorData data
          "Constant loss factors for both flow directions" annotation (
            choices(
            choice=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.wallFriction(),
            choice=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.suddenExpansion(),
            choice=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice()));
        output SI.Pressure dp "Pressure drop (dp = port_a.p - port_b.p)";

      protected
        Real k0 = 2*data.c0/(pi*data.D_Re^3);
        Real k1 = lossConstant_D_zeta(if data.zeta1_at_a then data.diameter_a else data.diameter_b,data.zeta1);
        Real k2 = lossConstant_D_zeta(if data.zeta2_at_a then data.diameter_a else data.diameter_b,data.zeta2);
        Real yd0
          "Derivative of dp = f(m_flow) at zero, if data.zetaLaminarKnown";
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
   If data.zetaLaminarKnown = false then mu_a and mu_b are potentially zero
   (because dummy values) and therefore the division is only performed
   if zetaLaminarKnown = true.
*/
        m_flow_turbulent :=(pi/8)*data.D_Re*(mu_a + mu_b)*data.Re_turbulent;
        yd0 :=if data.zetaLaminarKnown then k0*(mu_a + mu_b)/(rho_a + rho_b) else 0;
        dp :=Utilities.regSquare2(m_flow, m_flow_turbulent, k1/rho_a, k2/rho_b,
                                                 data.zetaLaminarKnown, yd0);
        annotation (smoothOrder=1, Documentation(info="<html>
<p>
Compute pressure drop from constant loss factor and mass flow rate (dp = f(m_flow)).
If the Reynolds-number Re &ge; data.Re_turbulent, the flow
is treated as a turbulent flow with constant loss factor zeta.
If the Reynolds-number Re &lt; data.Re_turbulent, the flow
is laminar and/or in a transition region between laminar and
turbulent. This region is approximated by two
polynomials of third order, one polynomial for m_flow &ge; 0
and one for m_flow &lt; 0.
The common derivative
of the two polynomials at Re = 0 is
computed from the equation \"data.c0/Re\".
</p>
<p>
If no data for c0 is available, the derivative at Re = 0 is computed in such
a way, that the second derivatives of the two polynomials
are identical at Re = 0. The polynomials are constructed, such that
they smoothly touch the characteristic curves in the turbulent
regions. The whole characteristic is therefore <strong>continuous</strong>
and has a <strong>finite</strong>, <strong>continuous first derivative everywhere</strong>.
In some cases, the constructed polynomials would \"vibrate\". This is
avoided by reducing the derivative at Re=0 in such a way that
the polynomials are guaranteed to be monotonically increasing.
The used sufficient criteria for monotonicity follows from:
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <strong>Monotone piecewise cubic interpolation</strong>.
     SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246</dd>
</dl>
</html>"));
      end pressureLoss_m_flow_and_Re;

      partial model BaseModel
        "Generic pressure drop component with constant turbulent loss factor data and without an icon"

        extends Modelica.Fluid.Interfaces.PartialTwoPortTransport(
          dp_start = dp_nominal,
          m_flow_small = if system.use_eps_Re then system.eps_m_flow*m_flow_nominal else system.m_flow_small,
          m_flow(stateSelect = if momentumDynamics == Types.Dynamics.SteadyState then StateSelect.default
                               else StateSelect.prefer));
        extends Modelica.Fluid.Interfaces.PartialLumpedFlow(
          final pathLength = 0,
          final momentumDynamics = Types.Dynamics.SteadyState);

        parameter LossFactorData data "Loss factor data";
        parameter Modelica.SIunits.MassFlowRate m_flow_nominal=if system.use_eps_Re then system.m_flow_nominal else 1e2*system.m_flow_small
          "Nominal mass flow rate"
          annotation(Dialog(group="Nominal operating point"));

        // Advanced
        parameter Boolean use_Re = system.use_eps_Re
          "= true, if turbulent region is defined by Re, otherwise by m_flow_small"
          annotation(Evaluate=true, Dialog(tab="Advanced"));
        parameter Boolean from_dp = true
          "= true, use m_flow = f(dp) else dp = f(m_flow)"
          annotation (Evaluate=true, Dialog(tab="Advanced"));
      protected
        parameter Medium.ThermodynamicState state_nominal=Medium.setState_pTX(
                             Medium.reference_p,
                             Medium.reference_T,
                             Medium.reference_X)
          "Medium state to compute nominal pressure drop";
        parameter Modelica.SIunits.Pressure dp_nominal=
          pressureLoss_m_flow(m_flow_nominal, Medium.density(state_nominal), Medium.density(state_nominal), data, m_flow_small)
          "Nominal pressure loss";
        parameter Medium.AbsolutePressure dp_small(min=0) = if system.use_eps_Re then dp_nominal/m_flow_nominal*m_flow_small else system.dp_small
          "Regularization of zero flow if |dp| < dp_small"
          annotation(Dialog(tab="Advanced", enable=not use_Re and from_dp));
        //parameter Medium.MassFlowRate m_flow_small = system.m_flow_small
        //  "Turbulent flow if |m_flow| >= m_flow_small"
        //  annotation(Dialog(tab = "Advanced", enable=not from_dp));

        // Diagnostics
      public
        parameter Boolean show_Re = false
          "= true, if Reynolds number is included for plotting"
           annotation (Evaluate=true, Dialog(tab="Advanced", group="Diagnostics"));
        SI.ReynoldsNumber Re = Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber_m_flow(
              m_flow,
              noEvent(if m_flow>0 then Medium.dynamicViscosity(state_a) else Medium.dynamicViscosity(state_b)),
              data.D_Re) if show_Re "Reynolds number at diameter data.D_Re";

        // Variables
        Modelica.SIunits.Pressure dp_fg
          "pressure loss due to friction and gravity";
        Modelica.SIunits.Area A_mean = Modelica.Constants.pi/4*(data.diameter_a^2+data.diameter_b^2)/2
          "mean cross flow area";

      equation
        Ib_flow = 0;
        F_p = A_mean*(Medium.pressure(state_b) - Medium.pressure(state_a));
        F_fg = A_mean*dp_fg;
        if from_dp then
           m_flow = homotopy(if use_Re then
                               massFlowRate_dp_and_Re(
                                 dp_fg, Medium.density(state_a), Medium.density(state_b),
                                 Medium.dynamicViscosity(state_a),
                                 Medium.dynamicViscosity(state_b),
                                 data) else
                               massFlowRate_dp(dp_fg, Medium.density(state_a), Medium.density(state_b), data, dp_small),
                             m_flow_nominal*dp_fg/dp_nominal);
        else
           dp_fg = homotopy(if use_Re then
                              pressureLoss_m_flow_and_Re(
                                m_flow, Medium.density(state_a), Medium.density(state_b),
                                Medium.dynamicViscosity(state_a),
                                Medium.dynamicViscosity(state_b),
                              data) else
                              pressureLoss_m_flow(m_flow, Medium.density(state_a), Medium.density(state_b), data, m_flow_small),
                            dp_nominal*m_flow/m_flow_nominal);
        end if;

        // Isenthalpic state transformation (no storage and no loss of energy)
        port_a.h_outflow = inStream(port_b.h_outflow);
        port_b.h_outflow = inStream(port_a.h_outflow);

        annotation (
          Documentation(info="<html>
<p>
This model computes the pressure loss of a pipe
segment (orifice, bending etc.) with a minimum amount of data
provided via parameter <strong>data</strong>.
If available, data should be provided for <strong>both flow directions</strong>,
i.e., flow from port_a to port_b and from port_b to port_a,
as well as for the <strong>laminar</strong> and the <strong>turbulent</strong> region.
It is also an option to provide the loss factor <strong>only</strong> for the
<strong>turbulent</strong> region for a flow from port_a to port_b.
</p>
<p>
The following equations are used:
</p>
<pre>   &Delta;p = 0.5*&zeta;*&rho;*v*|v|
      = 0.5*&zeta;/A^2 * (1/&rho;) * m_flow*|m_flow|
        Re = |v|*D*&rho;/&mu;
</pre>
<table border=1 cellspacing=0 cellpadding=2>
<tr><td><strong>flow type</strong></td>
    <td><strong>&zeta;</strong> = </td>
    <td><strong>flow region</strong></td></tr>
<tr><td>turbulent</td>
    <td><strong>zeta1</strong> = const.</td>
    <td>Re &ge;  Re_turbulent, v &ge; 0</td></tr>
<tr><td></td>
    <td><strong>zeta2</strong> = const.</td>
    <td>Re &ge; Re_turbulent, v &lt; 0</td></tr>
<tr><td>laminar</td>
    <td><strong>c0</strong>/Re</td>
    <td>both flow directions, Re small; c0 = const.</td></tr>
</table>
<p>
where
</p>
<ul>
<li> &Delta;p is the pressure drop: &Delta;p = port_a.p - port_b.p</li>
<li> v is the mean velocity.</li>
<li> &rho; is the density.</li>
<li> &zeta; is the loss factor that depends on the geometry of
     the pipe. In the turbulent flow regime, it is assumed that
     &zeta; is constant and is given by \"zeta1\" and
     \"zeta2\" depending on the flow direction.<br>
     When the Reynolds number Re is below \"Re_turbulent\", the
     flow is laminar for small flow velocities. For higher
     velocities there is a transition region from
     laminar to turbulent flow. The loss factor for
     laminar flow at small velocities is defined by the often occurring
     approximation c0/Re. If c0 is different for the two
     flow directions, the mean value has to be used
     (c0 = (c0_ab + c0_ba)/2).</li>
<li> The equation \"&Delta;p = 0.5*&zeta;*&rho;*v*|v|\" is either with
     respect to port_a or to port_b, depending on the definition
     of the particular loss factor &zeta; (in some references loss
     factors are defined with respect to port_a, in other references
     with respect to port_b).</li>
<li> Re = |v|*D_Re*&rho;/&mu; = |m_flow|*D_Re/(A_Re*&mu;)
     is the Reynolds number at the smallest cross
     section area. This is often at port_a or at port_b, but can
     also be between the two ports. In the record, the diameter
     D_Re of this smallest cross section area has to be provided, as
     well, as Re_turbulent, the absolute value of the
     Reynolds number at which
     the turbulent flow starts. If Re_turbulent is different for
     the two flow directions, use the smaller value as Re_turbulent.</li>
<li> D is the diameter of the pipe. If the pipe has not a
     circular cross section, D = 4*A/P, where A is the cross section
     area and P is the wetted perimeter.</li>
<li> A is the cross section area with A = &pi;(D/2)^2.</li>
<li> &mu; is the dynamic viscosity.</li>
</ul>
<p>
The laminar and the transition region is usually of
not much technical interest because the operating point is
mostly in the turbulent regime. For simplification and for
numerical reasons, this whole region is described by two
polynomials of third order, one polynomial for m_flow &ge; 0
and one for m_flow &lt; 0. The polynomials start at
Re = |m_flow|*4/(&pi;*D_Re*&mu;), where D_Re is the
smallest diameter between port_a and port_b.
The common derivative
of the two polynomials at Re = 0 is
computed from the equation \"c0/Re\". Note, the pressure drop
equation above in the laminar region is always defined
with respect to the smallest diameter D_Re.
</p>
<p>
If no data for c0 is available, the derivative at Re = 0 is computed in such
a way, that the second derivatives of the two polynomials
are identical at Re = 0. The polynomials are constructed, such that
they smoothly touch the characteristic curves in the turbulent
regions. The whole characteristic is therefore <strong>continuous</strong>
and has a <strong>finite</strong>, <strong>continuous first derivative everywhere</strong>.
In some cases, the constructed polynomials would \"vibrate\". This is
avoided by reducing the derivative at Re=0 in such a way that
the polynomials are guaranteed to be monotonically increasing.
The used sufficient criteria for monotonicity follows from:
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <strong>Monotone piecewise cubic interpolation</strong>.
     SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246</dd>
</dl>
</html>"));
      end BaseModel;

    model TestWallFriction
        "Pressure drop in pipe due to wall friction (only for test purposes; if needed use Pipes.StaticPipe instead)"
            extends BaseModel(final data=
              LossFactorData.wallFriction(
              length,
              diameter,
              roughness));
      parameter SI.Length length "Length of pipe";
      parameter SI.Diameter diameter "Inner diameter of pipe";
      parameter SI.Length roughness(min=1e-10)
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
                textString="quad. turbulent")}),
          Documentation(info="<html>

</html>"));
    end TestWallFriction;

      partial model BaseModelNonconstantCrossSectionArea
        "Generic pressure drop component with constant turbulent loss factor data and without an icon, for non-constant cross section area"

        extends Modelica.Fluid.Interfaces.PartialTwoPortTransport(
          final dp_start = dp_nominal,
          m_flow_small = if system.use_eps_Re then system.eps_m_flow*m_flow_nominal else system.m_flow_small,
          m_flow(stateSelect = if momentumDynamics == Types.Dynamics.SteadyState then StateSelect.default
                               else StateSelect.prefer));
        extends Modelica.Fluid.Interfaces.PartialLumpedFlow(
          final pathLength = 0,
          final momentumDynamics = Types.Dynamics.SteadyState);

        parameter LossFactorData data "Loss factor data";
        parameter Modelica.SIunits.MassFlowRate m_flow_nominal=if system.use_eps_Re then system.m_flow_nominal else 1e2*system.m_flow_small
          "Nominal mass flow rate"
          annotation(Dialog(group="Nominal operating point"));

        // Advanced
        /// Other settings than the final values are not yet implemented ///
        final parameter Boolean use_Re = false
          "= true, if turbulent region is defined by Re, otherwise by m_flow_small"
          annotation(Evaluate=true, Dialog(tab="Advanced"));
        final parameter Boolean from_dp = false
          "= true, use m_flow = f(dp) else dp = f(m_flow)"
          annotation (Evaluate=true, Dialog(tab="Advanced"));
        // End not yet implemented /////////////////////////////////////////
      protected
        parameter Medium.ThermodynamicState state_nominal=Medium.setState_pTX(
                             Medium.reference_p,
                             Medium.reference_T,
                             Medium.reference_X)
          "Medium state to compute nominal pressure drop" annotation(HideResult=true);
        parameter Modelica.SIunits.Pressure dp_nominal=
          pressureLoss_m_flow(m_flow_nominal, Medium.density(state_nominal), Medium.density(state_nominal), data, m_flow_small)
          "Nominal pressure loss";
        parameter Medium.AbsolutePressure dp_small(min=0) = if system.use_eps_Re then dp_nominal/m_flow_nominal*m_flow_small else system.dp_small
          "Regularization of zero flow if |dp| < dp_small"
          annotation(Dialog(tab="Advanced", enable=not use_Re and from_dp));
        //parameter Medium.MassFlowRate m_flow_small = system.m_flow_small
        //  "Turbulent flow if |m_flow| >= m_flow_small"
        //  annotation(Dialog(tab = "Advanced", enable=not from_dp));

        // Diagnostics
      public
        parameter Boolean show_Re = false
          "= true, if Reynolds number is included for plotting"
           annotation (Evaluate=true, Dialog(tab="Advanced", group="Diagnostics"));
        SI.ReynoldsNumber Re = Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber_m_flow(
              m_flow,
              noEvent(if m_flow>0 then Medium.dynamicViscosity(state_a) else Medium.dynamicViscosity(state_b)),
              data.D_Re) if show_Re "Reynolds number at diameter data.D_Re";
        parameter Boolean show_totalPressures = false
          "= true, if total pressures are included for plotting"
           annotation (Evaluate=true, Dialog(tab="Advanced", group="Diagnostics"));
        SI.AbsolutePressure p_total_a = port_a.p + 0.5 * m_flow^2 /((Modelica.Constants.pi/4 * data.diameter_a^2)^2 * noEvent(if port_a.m_flow > 0 then Medium.density(state_a) else Medium.density(state_b))) if
          show_totalPressures "Total pressure at port_a";
        SI.AbsolutePressure p_total_b = port_b.p + 0.5 * m_flow^2 /((Modelica.Constants.pi/4 * data.diameter_b^2)^2 * noEvent(if port_b.m_flow > 0 then Medium.density(state_b) else Medium.density(state_a))) if
          show_totalPressures "Total pressure at port_a";
        parameter Boolean show_portVelocities = false
          "= true, if port velocities are included for plotting"
           annotation (Evaluate=true, Dialog(tab="Advanced", group="Diagnostics"));
        SI.Velocity v_a = port_a.m_flow /(Modelica.Constants.pi/4 * data.diameter_a^2 * noEvent(if port_a.m_flow > 0 then Medium.density(state_a) else Medium.density(state_b))) if
          show_portVelocities "Fluid velocity into port_a";
        SI.Velocity v_b = port_b.m_flow /(Modelica.Constants.pi/4 * data.diameter_b^2 * noEvent(if port_b.m_flow > 0 then Medium.density(state_b) else Medium.density(state_a))) if
          show_portVelocities "Fluid velocity into port_b";

        // Variables
        Modelica.SIunits.Pressure dp_fg
          "pressure loss due to friction and gravity";
        Modelica.SIunits.Area A_mean = Modelica.Constants.pi/4*(data.diameter_a^2+data.diameter_b^2)/2
          "mean cross flow area";

        Medium.ThermodynamicState state_b_des
          "Thermodynamic state at port b for flow a -> b";
        Medium.ThermodynamicState state_a_nondes
          "Thermodynamic state at port a for flow a <- b";

      equation
        Ib_flow = 0;
        F_p = A_mean*(Medium.pressure(state_b) - Medium.pressure(state_a));
        F_fg = A_mean*dp_fg;
        if from_dp then
           m_flow = if use_Re then
                       massFlowRate_dp_and_Re(
                          dp_fg, Medium.density(state_a), Medium.density(state_b),
                          Medium.dynamicViscosity(state_a),
                          Medium.dynamicViscosity(state_b),
                          data) else
                       massFlowRate_dp(dp_fg, Medium.density(state_a), Medium.density(state_b), data, dp_small);
        else
           dp_fg = if use_Re then
                   pressureLoss_m_flow_and_Re(
                       m_flow, Medium.density(state_a), Medium.density(state_b),
                       Medium.dynamicViscosity(state_a),
                       Medium.dynamicViscosity(state_b),
                       data) else
                   pressureLoss_m_flow_totalPressure(m_flow,
                     Medium.density(state_a),
                     Medium.density(state_b_des),
                     Medium.density(state_b),
                     Medium.density(state_a_nondes),
                     data, m_flow_small);
        end if;

        // Isenthalpic state transformation (no storage and no loss of energy)
        port_a.h_outflow = inStream(port_b.h_outflow);
        port_b.h_outflow = inStream(port_a.h_outflow);

        // medium states for downstream properties, may want to change this neglecting the only difference from state_a, state_b, which is in pressure
        // This will remove the extra interaction variables
        state_b_des = Medium.setState_phX(port_b.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow));
        state_a_nondes = Medium.setState_phX(port_a.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow));

        annotation (
          Documentation(info="<html>
<p>
This model computes the pressure loss of a pipe
segment (orifice, bending etc.) with a minimum amount of data
provided via parameter <strong>data</strong>.
If available, data should be provided for <strong>both flow directions</strong>,
i.e., flow from port_a to port_b and from port_b to port_a,
as well as for the <strong>laminar</strong> and the <strong>turbulent</strong> region.
It is also an option to provide the loss factor <strong>only</strong> for the
<strong>turbulent</strong> region for a flow from port_a to port_b.
</p>
<p>
The following equations are used:
</p>
<pre>   &Delta;p = 0.5*&zeta;*&rho;*v*|v|
      = 0.5*&zeta;/A^2 * (1/&rho;) * m_flow*|m_flow|
        Re = |v|*D*&rho;/&mu;
</pre>
<table border=1 cellspacing=0 cellpadding=2>
<tr><td><strong>flow type</strong></td>
    <td><strong>&zeta;</strong> = </td>
    <td><strong>flow region</strong></td></tr>
<tr><td>turbulent</td>
    <td><strong>zeta1</strong> = const.</td>
    <td>Re &ge;  Re_turbulent, v &ge; 0</td></tr>
<tr><td></td>
    <td><strong>zeta2</strong> = const.</td>
    <td>Re &ge; Re_turbulent, v &lt; 0</td></tr>
<tr><td>laminar</td>
    <td><strong>c0</strong>/Re</td>
    <td>both flow directions, Re small; c0 = const.</td></tr>
</table>
<p>
where
</p>
<ul>
<li> &Delta;p is the pressure drop: &Delta;p = port_a.p - port_b.p</li>
<li> v is the mean velocity.</li>
<li> &rho; is the density.</li>
<li> &zeta; is the loss factor that depends on the geometry of
     the pipe. In the turbulent flow regime, it is assumed that
     &zeta; is constant and is given by \"zeta1\" and
     \"zeta2\" depending on the flow direction.<br>
     When the Reynolds number Re is below \"Re_turbulent\", the
     flow is laminar for small flow velocities. For higher
     velocities there is a transition region from
     laminar to turbulent flow. The loss factor for
     laminar flow at small velocities is defined by the often occurring
     approximation c0/Re. If c0 is different for the two
     flow directions, the mean value has to be used
     (c0 = (c0_ab + c0_ba)/2).</li>
<li> The equation \"&Delta;p = 0.5*&zeta;*&rho;*v*|v|\" is either with
     respect to port_a or to port_b, depending on the definition
     of the particular loss factor &zeta; (in some references loss
     factors are defined with respect to port_a, in other references
     with respect to port_b).</li>

<li> Re = |v|*D_Re*&rho;/&mu; = |m_flow|*D_Re/(A_Re*&mu;)
     is the Reynolds number at the smallest cross
     section area. This is often at port_a or at port_b, but can
     also be between the two ports. In the record, the diameter
     D_Re of this smallest cross section area has to be provided, as
     well, as Re_turbulent, the absolute value of the
     Reynolds number at which
     the turbulent flow starts. If Re_turbulent is different for
     the two flow directions, use the smaller value as Re_turbulent.</li>
<li> D is the diameter of the pipe. If the pipe has not a
     circular cross section, D = 4*A/P, where A is the cross section
     area and P is the wetted perimeter.</li>
<li> A is the cross section area with A = &pi;(D/2)^2.</li>
<li> &mu; is the dynamic viscosity.</li>
</ul>
<p>
The laminar and the transition region is usually of
not much technical interest because the operating point is
mostly in the turbulent regime. For simplification and for
numerical reasons, this whole region is described by two
polynomials of third order, one polynomial for m_flow &ge; 0
and one for m_flow &lt; 0. The polynomials start at
Re = |m_flow|*4/(&pi;*D_Re*&mu;), where D_Re is the
smallest diameter between port_a and port_b.
The common derivative
of the two polynomials at Re = 0 is
computed from the equation \"c0/Re\". Note, the pressure drop
equation above in the laminar region is always defined
with respect to the smallest diameter D_Re.
</p>
<p>
If no data for c0 is available, the derivative at Re = 0 is computed in such
a way, that the second derivatives of the two polynomials
are identical at Re = 0. The polynomials are constructed, such that
they smoothly touch the characteristic curves in the turbulent
regions. The whole characteristic is therefore <strong>continuous</strong>
and has a <strong>finite</strong>, <strong>continuous first derivative everywhere</strong>.
In some cases, the constructed polynomials would \"vibrate\". This is
avoided by reducing the derivative at Re=0 in such a way that
the polynomials are guaranteed to be monotonically increasing.
The used sufficient criteria for monotonicity follows from:
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <strong>Monotone piecewise cubic interpolation</strong>.
     SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246</dd>
</dl>
</html>"));
      end BaseModelNonconstantCrossSectionArea;

      function pressureLoss_m_flow_totalPressure
        "Return pressure drop from constant loss factor and mass flow rate (dp = f(m_flow))"
              extends Modelica.Icons.Function;

        input SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";
        input SI.Density rho_a_des
          "Density at port_a, mass flow in design direction a -> b";
        input SI.Density rho_b_des
          "Density at port_b, mass flow in design direction a -> b";
        input SI.Density rho_b_nondes
          "Density at port_b, mass flow against design direction a <- b";
        input SI.Density rho_a_nondes
          "Density at port_a, mass flow against design direction a <- b";
        input LossFactorData data
          "Constant loss factors for both flow directions" annotation (
            choices(
            choice=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.wallFriction(),
            choice=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.suddenExpansion(),
            choice=Modelica.Fluid.Fittings.BaseClasses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice()));
        input SI.MassFlowRate m_flow_small = 0.01
          "Turbulent flow if |m_flow| >= m_flow_small";
        output SI.Pressure dp "Pressure drop (dp = port_a.p - port_b.p)";

      protected
        SI.Area A_a = Modelica.Constants.pi * data.diameter_a^2/4
          "Cross section area at port_a";
        SI.Area A_b = Modelica.Constants.pi * data.diameter_b^2/4
          "Cross section area at port_b";
      algorithm
          dp := 1/2 * m_flow^2 *( if m_flow > 0 then
            data.zeta1/(if data.zeta1_at_a then rho_a_des    * A_a^2 else    rho_b_des * A_b^2) - 1/(rho_a_des    * A_a^2) + 1/(rho_b_des    * A_b^2) else
            -data.zeta2/(if data.zeta2_at_a then rho_a_nondes * A_a^2 else rho_b_nondes * A_b^2) - 1/(rho_a_nondes * A_a^2) + 1/(rho_b_nondes * A_b^2));
        annotation (smoothOrder=1, Documentation(info="<html>
<p>
Compute pressure drop from constant loss factor and mass flow rate (dp = f(m_flow)).
For small mass flow rates(|m_flow| &lt; m_flow_small), the characteristic is approximated by
a polynomial in order to have a finite derivative at zero mass flow rate.
</p>
</html>"));
      end pressureLoss_m_flow_totalPressure;
      annotation (Documentation(info="<html>
<p>
This library provides pressure loss factors of a pipe
segment (orifice, bending etc.) with a minimum amount of data.
If available, data can be provided for <strong>both flow directions</strong>,
i.e., flow from port_a to port_b and from port_b to port_a,
as well as for the <strong>laminar</strong> and the <strong>turbulent</strong> region.
It is also an option to provide the loss factor <strong>only</strong> for the
<strong>turbulent</strong> region for a flow from port_a to port_b.
Basically, the pressure drop is defined by the following
equation:
</p>
<pre>   &Delta;p = 0.5*&zeta;*&rho;*v*|v|
      = 0.5*&zeta;/A^2 * (1/&rho;) * m_flow*|m_flow|
      = 8*&zeta;/(&pi;^2*D^4*&rho;) * m_flow*|m_flow|
</pre>
<p>
where
</p>
<ul>
<li> &Delta;p is the pressure drop: &Delta;p = port_a.p - port_b.p</li>
<li> v is the mean velocity.</li>
<li> &rho; is the density.</li>
<li> &zeta; is the loss factor that depends on the geometry of
     the pipe. In the turbulent flow regime, it is assumed that
     &zeta; is constant and is given by \"zeta1\" and
     \"zeta2\" depending on the flow direction.</li>
<li> D is the diameter of the pipe segment. If this is not a
     circular cross section, D = 4*A/P, where A is the cross section
     area and P is the wetted perimeter.</li>
</ul>

</html>"));
    end QuadraticTurbulent;

    partial model PartialTeeJunction
      "Base class for a splitting/joining component with three ports"
      import Modelica.Fluid.Types;
      import Modelica.Fluid.Types.PortFlowDirection;

      replaceable package Medium=Modelica.Media.Interfaces.PartialMedium
        "Medium in the component"
        annotation (choicesAllMatching=true);

      Modelica.Fluid.Interfaces.FluidPort_a port_1(redeclare package Medium =
            Medium, m_flow(min=if (portFlowDirection_1 == PortFlowDirection.Entering) then
                    0.0 else -Modelica.Constants.inf, max=if (portFlowDirection_1
               == PortFlowDirection.Leaving) then 0.0 else Modelica.Constants.inf))
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_2(redeclare package Medium =
            Medium, m_flow(min=if (portFlowDirection_2 == PortFlowDirection.Entering) then
                    0.0 else -Modelica.Constants.inf, max=if (portFlowDirection_2
               == PortFlowDirection.Leaving) then 0.0 else Modelica.Constants.inf))
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_3(
        redeclare package Medium=Medium,
        m_flow(min=if (portFlowDirection_3==PortFlowDirection.Entering) then 0.0 else -Modelica.Constants.inf,
        max=if (portFlowDirection_3==PortFlowDirection.Leaving) then 0.0 else Modelica.Constants.inf))
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));

    protected
      parameter PortFlowDirection portFlowDirection_1=PortFlowDirection.Bidirectional
        "Flow direction for port_1"
       annotation(Dialog(tab="Advanced"));
      parameter PortFlowDirection portFlowDirection_2=PortFlowDirection.Bidirectional
        "Flow direction for port_2"
       annotation(Dialog(tab="Advanced"));
      parameter PortFlowDirection portFlowDirection_3=PortFlowDirection.Bidirectional
        "Flow direction for port_3"
       annotation(Dialog(tab="Advanced"));

      annotation(Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-100,44},{100,-44}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,127,255}),
            Text(
              extent={{-150,-89},{150,-129}},
              lineColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-44,100},{44,44}},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={0,127,255}),
            Rectangle(
              extent={{-22,82},{21,-4}},
              fillPattern=FillPattern.Solid,
              fillColor={0,128,255},
              pattern=LinePattern.None)}));
    end PartialTeeJunction;

    package Bends "Pressure loss functions for bends"
      extends Modelica.Icons.VariantsPackage;

      package CurvedBend "Pressure loss functions for curved bends"
          extends Modelica.Icons.Package;

      function massFlowRate
          "Return mass flow rate m_flow as function of pressure loss dp for a curved bend"
        extends Modelica.Icons.Function;
        input SI.Pressure dp "Pressure loss";
        input Geometry geometry "Geometry of bend";
        input SI.Density d_a
            "Density at port_a when fluid is flowing from port_a to port_b";
        input SI.Density d_b
            "Density at port_b when fluid is flowing from port_b to port_a";
        input SI.DynamicViscosity eta_a
            "Dynamic viscosity at port_a when fluid is flowing from port_a to port_b";
        input SI.DynamicViscosity eta_b
            "Dynamic viscosity at port_b when fluid is flowing from port_b to port_a";
        input SI.AbsolutePressure dp_small
            "Small pressure drop used for regularization if m_flow=f(...,dp_small,..,dp)";
        input SI.MassFlowRate m_flow_small
            "Small mass flow rate used for regularization if dp=f_inv(...,m_flow_small,m_flow)";
        output SI.MassFlowRate m_flow "Mass flow rate (= port_a.m_flow)";
      algorithm
         m_flow := Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW(
                     geometry,
                     Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var(
                         rho=Modelica.Fluid.Utilities.regStep(dp, d_a, d_b, dp_small),
                         eta=Modelica.Fluid.Utilities.regStep(dp, eta_a, eta_b, dp_small)),
                     dp);

         annotation(Inline=false, LateInline=true,
                    inverse(dp=Modelica.Fluid.Fittings.BaseClasses.Bends.CurvedBend.pressureLoss(
                                  m_flow, geometry, d_a, d_b, eta_a, eta_b, dp_small, m_flow_small)),
            Documentation(info="<html>
<p>
This function returns the mass flow rate m_flow as function of pressure loss dp for a curved bend.
The details of the function are described
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_curvedOverall\">here</a>.
</p>

<p>
The bend characteristic is valid for constant density and constant dynamic viscosity.
It can be approximately also used for compressible media. This is performed by providing
the upstream density and upstream dynamic viscosity. In order to be able to regularize density
and dynamic viscosity around zero mass flow rate, the two quantities have to be given if
fluid flows from port_a to port_b (d_a, eta_a) and if fluid flows from port_b to port_a
(d_b, eta_b).
</p>

</html>"));
      end massFlowRate;

      function pressureLoss
          "Return pressure loss dp as function of mass flow rate m_flow for a curved bend"
        extends Modelica.Icons.Function;

        input SI.MassFlowRate m_flow "Mass flow rate (= port_a.m_flow)";
        input Geometry geometry "Geometry of bend";
        input SI.Density d_a
            "Density at port_a when fluid is flowing from port_a to port_b";
        input SI.Density d_b
            "Density at port_b when fluid is flowing from port_b to port_a";
        input SI.DynamicViscosity eta_a
            "Dynamic viscosity at port_a when fluid is flowing from port_a to port_b";
        input SI.DynamicViscosity eta_b
            "Dynamic viscosity at port_b when fluid is flowing from port_b to port_a";
        input SI.AbsolutePressure dp_small
            "Small pressure drop used for regularization if m_flow=f(...,dp_small,..,dp)";
        input SI.MassFlowRate m_flow_small
            "Small mass flow rate used for regularization if dp=f_inv(...,m_flow_small,m_flow)";
        output SI.Pressure dp "Pressure loss";
      algorithm
         dp := Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP(
                     geometry,
                     Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var(
                         rho=Modelica.Fluid.Utilities.regStep(m_flow, d_a, d_b, m_flow_small),
                         eta=Modelica.Fluid.Utilities.regStep(m_flow, eta_a, eta_b, m_flow_small)),
                     m_flow);

         annotation(Inline=true, Documentation(info="<html>
<p>
This function returns the pressure loss dp as function of mass flow rate m_flow for a curved bend.
The details of the function are described
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_curvedOverall\">here</a>.
</p>

<p>
The bend characteristic is valid for constant density and constant dynamic viscosity.
It can be approximately also used for compressible media. This is performed by providing
the upstream density and upstream dynamic viscosity. In order to be able to regularize density
and dynamic viscosity around zero mass flow rate, the two quantities have to be given if
fluid flows from port_a to port_b (d_a, eta_a) and if fluid flows from port_b to port_a
(d_b, eta_b).
</p>
</html>"));
      end pressureLoss;

        record Geometry "Geometric data for a curved bend"
          extends Modelica.Icons.Record;

          SI.Diameter d_hyd "Hydraulic diameter"
            annotation (Dialog);
          SI.Radius R_0 "Curvature radius" annotation (Dialog);
          SI.Angle delta=1.5707963267949 "Angle of turning" annotation (Dialog);
          Modelica.Fluid.Types.Roughness K=2.5e-5
            "Absolute roughness, with a default for a smooth steel pipe"
            annotation (Dialog);
          annotation (Documentation(info="<html>
<p>
This record is used to define the geometric (constant) data of a curved bend.
The details of the record are described
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_curvedOverall\">here</a>.
</p>
</html>"));
        end Geometry;
        annotation (Documentation(info="<html>
<p>
This package contains utility functions and records
for the CurvedBend fitting component.
</p>

</html>"));
      end CurvedBend;

      package EdgedBend "Pressure loss functions for edged bends"
          extends Modelica.Icons.Package;

      function massFlowRate
          "Return mass flow rate m_flow as function of pressure loss dp for a curved bend"
        extends Modelica.Icons.Function;

        input SI.Pressure dp "Pressure loss";
        input Geometry geometry "Geometry of bend";
        input SI.Density d_a
            "Density at port_a when fluid is flowing from port_a to port_b";
        input SI.Density d_b
            "Density at port_b when fluid is flowing from port_b to port_a";
        input SI.DynamicViscosity eta_a
            "Dynamic viscosity at port_a when fluid is flowing from port_a to port_b";
        input SI.DynamicViscosity eta_b
            "Dynamic viscosity at port_b when fluid is flowing from port_b to port_a";
        input SI.AbsolutePressure dp_small
            "Small pressure drop used for regularization if m_flow=f(...,dp_small,..,dp)";
        input SI.MassFlowRate m_flow_small
            "Small mass flow rate used for regularization if dp=f_inv(...,m_flow_small,m_flow)";
        output SI.MassFlowRate m_flow "Mass flow rate (= port_a.m_flow)";
      algorithm
         m_flow := Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW(
                     Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con(
                         d_hyd=geometry.d_hyd,
                         delta=geometry.delta,
                         K=geometry.K),
                     Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var(
                         rho=Modelica.Fluid.Utilities.regStep(dp, d_a, d_b, dp_small),
                         eta=Modelica.Fluid.Utilities.regStep(dp, eta_a, eta_b, dp_small)),
                     dp);

         annotation(Inline=false, LateInline=true,
                    inverse(dp=Modelica.Fluid.Fittings.BaseClasses.Bends.EdgedBend.pressureLoss(
                                  m_flow, geometry, d_a, d_b, eta_a, eta_b, dp_small, m_flow_small)),
          Documentation(info="<html>
<p>
This function returns the mass flow rate m_flow as function of pressure loss dp for an edged bend.
The details of the function are described
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_edgedOverall\">here</a>.
</p>

<p>
The bend characteristic is valid for constant density and constant dynamic viscosity.
It can be approximately also used for compressible media. This is performed by providing
the upstream density and upstream dynamic viscosity. In order to be able to regularize density
and dynamic viscosity around zero mass flow rate, the two quantities have to be given if
fluid flows from port_a to port_b (d_a, eta_a) and if fluid flows from port_b to port_a
(d_b, eta_b).
</p>

</html>"));
      end massFlowRate;

      function pressureLoss
          "Return pressure loss dp as function of mass flow rate m_flow for a curved bend"
        extends Modelica.Icons.Function;

        input SI.MassFlowRate m_flow "Mass flow rate (= port_a.m_flow)";
        input Geometry geometry "Geometry of bend";
        input SI.Density d_a
            "Density at port_a when fluid is flowing from port_a to port_b";
        input SI.Density d_b
            "Density at port_b when fluid is flowing from port_b to port_a";
        input SI.DynamicViscosity eta_a
            "Dynamic viscosity at port_a when fluid is flowing from port_a to port_b";
        input SI.DynamicViscosity eta_b
            "Dynamic viscosity at port_b when fluid is flowing from port_b to port_a";
        input SI.AbsolutePressure dp_small
            "Small pressure drop used for regularization if m_flow=f(...,dp_small,..,dp)";
        input SI.MassFlowRate m_flow_small
            "Small mass flow rate used for regularization if dp=f_inv(...,m_flow_small,m_flow)";
        output SI.Pressure dp "Pressure loss";
      algorithm
         dp := Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP(
                     Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con(
                         d_hyd=geometry.d_hyd,
                         delta=geometry.delta,
                         K=geometry.K),
                     Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var(
                         rho=Modelica.Fluid.Utilities.regStep(m_flow, d_a, d_b, m_flow_small),
                         eta=Modelica.Fluid.Utilities.regStep(m_flow, eta_a, eta_b, m_flow_small)),
                     m_flow);

         annotation(Inline=true, Documentation(info="<html>
<p>
This function returns the pressure loss dp as function of mass flow rate m_flow for an edged bend.
The details of the function are described
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_edgedOverall\">here</a>.
</p>

<p>
The bend characteristic is valid for constant density and constant dynamic viscosity.
It can be approximately also used for compressible media. This is performed by providing
the upstream density and upstream dynamic viscosity. In order to be able to regularize density
and dynamic viscosity around zero mass flow rate, the two quantities have to be given if
fluid flows from port_a to port_b (d_a, eta_a) and if fluid flows from port_b to port_a
(d_b, eta_b).
</p>
</html>"));
      end pressureLoss;

        record Geometry "Geometric data for a curved bend"
          extends Modelica.Icons.Record;

          SI.Diameter d_hyd "Hydraulic diameter"
            annotation (Dialog);
          SI.Angle delta "Angle of turning" annotation (Dialog);
          Modelica.Fluid.Types.Roughness K=2.5e-5
            "Absolute roughness, with a default for a smooth steel pipe"
            annotation (Dialog);
          annotation (Documentation(info="<html>
<p>
This record is used to define the geometric (constant) data of an edged bend.
The details of the record are described
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_edgedOverall\">here</a>.
</p>
</html>"));
        end Geometry;
        annotation (Documentation(info="<html>
<p>
This package contains utility functions and records
for the EdgedBend fitting component.
</p>

</html>"));
      end EdgedBend;
    end Bends;

    package Orifices "Pressure loss functions for orifices"
        extends Modelica.Icons.VariantsPackage;
      package ThickEdgedOrifice
        "Pressure loss functions for thick edged orifices"
          extends Modelica.Icons.Package;

      function massFlowRate
          "Return mass flow rate m_flow as function of pressure loss dp for a thick edged orifice"
        extends Modelica.Icons.Function;

        input SI.Pressure dp "Pressure loss";
        input Geometry geometry "Geometry of bend";
        input SI.Density d_a
            "Density at port_a when fluid is flowing from port_a to port_b";
        input SI.Density d_b
            "Density at port_b when fluid is flowing from port_b to port_a";
        input SI.DynamicViscosity eta_a
            "Dynamic viscosity at port_a when fluid is flowing from port_a to port_b";
        input SI.DynamicViscosity eta_b
            "Dynamic viscosity at port_b when fluid is flowing from port_b to port_a";
        input SI.AbsolutePressure dp_small
            "Small pressure drop used for regularization if m_flow=f(...,dp_small,..,dp)";
        input SI.MassFlowRate m_flow_small
            "Small mass flow rate used for regularization if dp=f_inv(...,m_flow_small,m_flow)";
        output SI.MassFlowRate m_flow "Mass flow rate (= port_a.m_flow)";
      algorithm
         m_flow := Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW(
                     Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con(
                         A_0=geometry.venaCrossArea,
                         A_1=geometry.crossArea,
                         C_0=geometry.venaPerimeter,
                         C_1=geometry.perimeter,
                         L=geometry.venaLength,
                         dp_smooth=dp_small),
                     Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var(
                         rho=Modelica.Fluid.Utilities.regStep(dp, d_a, d_b, dp_small),
                         eta=Modelica.Fluid.Utilities.regStep(dp, eta_a, eta_b, dp_small)),
                     dp);
         annotation(Inline=false, LateInline=true,
                    inverse(dp=Modelica.Fluid.Fittings.BaseClasses.Orifices.ThickEdgedOrifice.pressureLoss(
                                  m_flow, geometry, d_a, d_b, eta_a, eta_b, dp_small, m_flow_small)),
            Documentation(info="<html>
<p>
This function returns the mass flow rate m_flow as function of pressure loss dp for a thick edged orifice.
The details of the function are described
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_thickEdgedOverall\">here</a>.
</p>

<p>
The orifice characteristic is valid for constant density and constant dynamic viscosity.
It can be approximately also used for compressible media. This is performed by providing
the upstream density and upstream dynamic viscosity. In order to be able to regularize density
and dynamic viscosity around zero mass flow rate, the two quantities have to be given if
fluid flows from port_a to port_b (d_a, eta_a) and if fluid flows from port_b to port_a
(d_b, eta_b).
</p>

</html>"));
      end massFlowRate;

      function pressureLoss
          "Return pressure loss dp as function of mass flow rate m_flow for a thick edged orifice"
        extends Modelica.Icons.Function;

        input SI.MassFlowRate m_flow "Mass flow rate (= port_a.m_flow)";
        input Geometry geometry "Geometry of bend";
        input SI.Density d_a
            "Density at port_a when fluid is flowing from port_a to port_b";
        input SI.Density d_b
            "Density at port_b when fluid is flowing from port_b to port_a";
        input SI.DynamicViscosity eta_a
            "Dynamic viscosity at port_a when fluid is flowing from port_a to port_b";
        input SI.DynamicViscosity eta_b
            "Dynamic viscosity at port_b when fluid is flowing from port_b to port_a";
        input SI.AbsolutePressure dp_small
            "Small pressure drop used for regularization if m_flow=f(...,dp_small,..,dp)";
        input SI.MassFlowRate m_flow_small
            "Small mass flow rate used for regularization if dp=f_inv(...,m_flow_small,m_flow)";
        output SI.Pressure dp "Pressure loss";
      algorithm
         dp := Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP(
                 Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con(
                         A_0=geometry.venaCrossArea,
                         A_1=geometry.crossArea,
                         C_0=geometry.venaPerimeter,
                         C_1=geometry.perimeter,
                         L=geometry.venaLength,
                         dp_smooth=dp_small),
                     Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var(
                         rho=Modelica.Fluid.Utilities.regStep(m_flow, d_a, d_b, m_flow_small),
                         eta=Modelica.Fluid.Utilities.regStep(m_flow, eta_a, eta_b, m_flow_small)),
                     m_flow);

         annotation(Inline=true, Documentation(info="<html>
<p>
This function returns the pressure loss dp as function of mass flow rate m_flow for a thick edged orifice.
The details of the function are described
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_thickEdgedOverall\">here</a>.
</p>

<p>
The orifice characteristic is valid for constant density and constant dynamic viscosity.
It can be approximately also used for compressible media. This is performed by providing
the upstream density and upstream dynamic viscosity. In order to be able to regularize density
and dynamic viscosity around zero mass flow rate, the two quantities have to be given if
fluid flows from port_a to port_b (d_a, eta_a) and if fluid flows from port_b to port_a
(d_b, eta_b).
</p>
</html>"));
      end pressureLoss;

        record Geometry "Geometric data for a thick edged orifice"
          extends Modelica.Icons.Record;

          SI.Area crossArea "Inner cross sectional area"
            annotation(Dialog);
          SI.Length perimeter "Inner perimeter"
            annotation(Dialog);

          SI.Area venaCrossArea "Cross sectional area of vena contraction"
            annotation(Dialog);
          SI.Length venaPerimeter "Perimeter of vena contraction"
            annotation(Dialog);
          SI.Length venaLength "Length of vena contraction"
            annotation (Dialog);

          annotation (Documentation(info="<html>
<p>
This record is used to define the geometric (constant) data of a thick edged orifice.
The details of the record are described
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_thickEdgedOverall\">here</a>.
</p>
</html>"));
        end Geometry;

      package Choices "Choices for Geometry"
        extends Modelica.Icons.Package;

        function circular "Circular cross section"
            import Modelica.Constants.pi;

          input SI.Diameter diameter "Inner diameter of circular orifice"
            annotation(Dialog);
          input SI.Diameter venaDiameter "Diameter of vena contraction"
            annotation(Dialog);
          input SI.Length venaLength "Length of vena contraction"
            annotation (Dialog);

           output ThickEdgedOrifice.Geometry geometry
              "Geometry of circular thick edged orifice";
        algorithm
           geometry.crossArea := diameter^2*pi/4;
           geometry.perimeter := pi*diameter;
           geometry.venaCrossArea := venaDiameter^2*pi/4;
           geometry.venaPerimeter := pi*venaDiameter;
           geometry.venaLength := venaLength;
          annotation (Icon(coordinateSystem(preserveAspectRatio=false,
                           extent={{-100,-100},{100,100}}), graphics={Ellipse(
                  extent={{-80,80},{80,-80}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
            Documentation(revisions="",
                info="<html>
<p>
Function that returns the ThickEdgedOrifice.Geometry for a circular
cross section of the orifice.
</p>
</html>"));
        end circular;

        function rectangular "Rectangular cross section"
            import Modelica.Constants.pi;

          input SI.Length width "Inner width of rectangular orifice"
            annotation(Dialog);
          input SI.Length height "Inner height of rectangular orifice"
            annotation(Dialog);
          input SI.Length venaWidth "Width of vena contraction"
            annotation(Dialog);
          input SI.Length venaHeight "Height of vena contraction"
            annotation(Dialog);
          input SI.Length venaLength "Length of vena contraction"
            annotation (Dialog);

           output ThickEdgedOrifice.Geometry geometry
              "Geometry of circular thick edged orifice";
        algorithm
           geometry.crossArea := width*height;
           geometry.perimeter := 2*width + 2*height;
           geometry.venaCrossArea := venaWidth*venaHeight;
           geometry.venaPerimeter := 2*venaWidth + 2*venaHeight;
           geometry.venaLength := venaLength;
          annotation (Icon(coordinateSystem(preserveAspectRatio=true,
                           extent={{-100,-100},{100,100}}), graphics={Rectangle(
                  extent={{-80,60},{80,-60}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
            Documentation(revisions="",
                info="<html>
<p>
Function that returns the ThickEdgedOrifice.Geometry for a rectangular
cross section of the orifice.
</p>
</html>"));
        end rectangular;

        function general "General cross section"
            import Modelica.Constants.pi;

          input SI.Area crossArea "Inner cross sectional area"
            annotation(Dialog);
          input SI.Length perimeter "Inner perimeter"
            annotation(Dialog);

          input SI.Area venaCrossArea
              "Cross sectional area of vena contraction"
            annotation(Dialog);
          input SI.Length venaPerimeter "Perimeter of vena contraction"
            annotation(Dialog);
          input SI.Length venaLength "Length of vena contraction"
            annotation (Dialog);

           output ThickEdgedOrifice.Geometry geometry
              "Geometry of circular thick edged orifice";
        algorithm
           geometry.crossArea := crossArea;
           geometry.perimeter := perimeter;
           geometry.venaCrossArea := venaCrossArea;
           geometry.venaPerimeter := venaPerimeter;
           geometry.venaLength := venaLength;
          annotation (Icon(coordinateSystem(preserveAspectRatio=false,
                           extent={{-100,-100},{100,100}}), graphics={
                                                 Polygon(
                  points={{-80,8},{0,80},{80,40},{20,-20},{40,-80},{-60,-80},{-80,8}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
            Documentation(revisions="",
                info="<html>
<p>
Function that returns the ThickEdgedOrifice.Geometry for a general
cross section of the orifice.
</p>
</html>"));
        end general;
          annotation (Documentation(info="<html>
<p>
Choices to compute the \"Geometry\" record for a ThickEdgedOrifice.
</p>
</html>"));
      end Choices;
        annotation (Documentation(info="<html>
<p>
This package contains utility functions and records
for the ThickEdgedOrifice fitting component.
</p>
</html>"));
      end ThickEdgedOrifice;
    end Orifices;

    package GenericResistances
      "Pressure loss functions for generic, geometry independent flow resistances"
        extends Modelica.Icons.VariantsPackage;
      package VolumeFlowRate
        "Pressure loss functions for generic resistances parameterized with the volume flow rate"
          extends Modelica.Icons.Package;

      function massFlowRate
          "Return mass flow rate m_flow as function of pressure loss dp for a curved bend"
        extends Modelica.Icons.Function;

        input SI.Pressure dp "Pressure loss";
        input Real a(unit="(Pa.s2)/m6")
            "Coefficient for quadratic term (dp = a*V_flow^2 + b*V_flow)";
        input Real b(unit="(Pa.s)/m3")
            "Coefficient for linear term (dp = a*V_flow^2 + b*V_flow)";
        input SI.Density d_a
            "Density at port_a when fluid is flowing from port_a to port_b";
        input SI.Density d_b
            "Density at port_b when fluid is flowing from port_b to port_a";
        input SI.AbsolutePressure dp_small
            "Small pressure drop used for regularization if m_flow=f(...,dp_small,..,dp)";
        input SI.MassFlowRate m_flow_small
            "Small mass flow rate used for regularization if dp=f_inv(...,m_flow_small,m_flow)";
        output SI.MassFlowRate m_flow "Mass flow rate (= port_a.m_flow)";
      algorithm
         m_flow := Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW(
                     Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_con(
                         a=a,
                         b=b,
                         dp_min=dp_small),
                     Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_var(
                         rho=Modelica.Fluid.Utilities.regStep(dp, d_a, d_b, dp_small)),
                     dp);

         annotation(LateInline=true,
                    inverse(dp=Modelica.Fluid.Fittings.BaseClasses.GenericResistances.VolumeFlowRate.pressureLoss(
                                  m_flow, a, b, d_a, d_b, dp_small, m_flow_small)),
          Documentation(info="<html>
<p>
This function returns the mass flow rate m_flow as function of pressure loss dp for an edged bend.
The details of the function are described
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_volumeFlowRate\">here</a>.
</p>

<p>
The bend characteristic is valid for constant density and constant dynamic viscosity.
It can be approximately also used for compressible media. This is performed by providing
the upstream density and upstream dynamic viscosity. In order to be able to regularize density
and dynamic viscosity around zero mass flow rate, the two quantities have to be given if
fluid flows from port_a to port_b (d_a, eta_a) and if fluid flows from port_b to port_a
(d_b, eta_b).
</p>

</html>"));
      end massFlowRate;

      function pressureLoss
          "Return pressure loss dp as function of mass flow rate m_flow for a curved bend"
        extends Modelica.Icons.Function;

        input SI.MassFlowRate m_flow "Mass flow rate (= port_a.m_flow)";
        input Real a(unit="(Pa.s2)/m6")
            "Coefficient for quadratic term (dp = a*V_flow^2 + b*V_flow)";
        input Real b(unit="(Pa.s)/m3")
            "Coefficient for linear term (dp = a*V_flow^2 + b*V_flow)";
        input SI.Density d_a
            "Density at port_a when fluid is flowing from port_a to port_b";
        input SI.Density d_b
            "Density at port_b when fluid is flowing from port_b to port_a";
        input SI.AbsolutePressure dp_small
            "Small pressure drop used for regularization if m_flow=f(...,dp_small,..,dp)";
        input SI.MassFlowRate m_flow_small
            "Small mass flow rate used for regularization if dp=f_inv(...,m_flow_small,m_flow)";
        output SI.Pressure dp "Pressure loss";
      algorithm
         dp := Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP(
                     Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_con(
                         a=a,
                         b=b,
                         dp_min=dp_small),
                     Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_var(
                         rho=Modelica.Fluid.Utilities.regStep(m_flow, d_a, d_b, m_flow_small)),
                     m_flow);

         annotation(Inline=true, Documentation(info="<html>
<p>
This function returns the pressure loss dp as function of mass flow rate m_flow for an edged bend.
The details of the function are described
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_volumeFlowRate\">here</a>.
</p>

<p>
The bend characteristic is valid for constant density and constant dynamic viscosity.
It can be approximately also used for compressible media. This is performed by providing
the upstream density and upstream dynamic viscosity. In order to be able to regularize density
and dynamic viscosity around zero mass flow rate, the two quantities have to be given if
fluid flows from port_a to port_b (d_a, eta_a) and if fluid flows from port_b to port_a
(d_b, eta_b).
</p>
</html>"));
      end pressureLoss;

        annotation (Documentation(info="<html>
<p>
This package contains utility functions
for the VolumeFlowRate fitting component.
</p>
</html>"));
      end VolumeFlowRate;
    end GenericResistances;
  end BaseClasses;
  annotation (Documentation(info="<html>
<p>
This sublibrary contains models and functions providing pressure
loss correlations. All models in this library have the property
that no mass and no energy is stored in the component. Therefore,
none of the models have a state.
</p>

<p>
All functions are continuous and have a finite, non-zero, smooth, first derivative.
The functions are all guaranteed to be strict monotonically increasing.
The mentioned properties guarantee that a unique inverse of every
function exists. Note, the usual quadratic pressure loss correlation
</p>

<ul>
<li> in the form m_flow = f(dp) has an infinite derivative at zero
     mass flow rate and is therefore problematic to use.</li>
<li> in the form dp = f(m_flow) has a zero derivative at zero mass flow rate
     and is therefore problematic to invert, since the inverse function has
     then an infinite derivative at zero mass flow rate.</li>
</ul>
<p>
The two mentioned problems are solved in this package by approximating
the characteristics around zero mass flow rates with appropriate
polynomials. The monotonicity is guaranteed using results from:
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <strong>Monotone piecewise cubic interpolation</strong>.
     SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246</dd>
</dl>

</html>", revisions="<html>
<ul>
<li><em>Jan. 3, 2006</em>
    by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
    New design and implementation based on previous iterations.</li>
</ul>
</html>"));
end Fittings;
