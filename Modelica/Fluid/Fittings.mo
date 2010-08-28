within Modelica.Fluid;
package Fittings
  "Adaptors for connections of fluid components and the regulation of fluid flow"
  package Bends "Flow models for bends"
    extends Modelica.Icons.VariantsPackage;
    model CurvedBend "Curved bend flow model"
      extends Modelica.Fluid.Fittings.BaseClasses.PartialPressureLoss;
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Bend_i;
      import Modelica.Fluid.Dissipation.PressureLoss.Bend;
      parameter Bend.dp_curvedOverall_IN_con geometry "Geometry of curved bend"
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

    /*
  Bend.dp_curvedOverall_IN_var
    properties(final eta=eta, final rho=rho) "Properties of medium"
    annotation (Placement(transformation(extent={{-46,20},{-26,40}})));
*/
    protected
      parameter Medium.AbsolutePressure dp_small= Bend.dp_curvedOverall_DP(
                    geometry, Bend.dp_curvedOverall_IN_var(
                      rho=Medium.density(Medium.setState_pTX(
                           Medium.reference_p,
                           Medium.reference_T,
                           Medium.reference_X)),
                      eta=Medium.dynamicViscosity(Medium.setState_pTX(
                           Medium.reference_p,
                           Medium.reference_T,
                           Medium.reference_X))),
                    m_flow_small)
        "Default small pressure drop for regularization of laminar and zero flow (calculated from m_flow_small)";

    partial function dp_curvedOverall_fixedInterface
       input Bend.dp_curvedOverall_IN_con geometry "Geometry of bend";
       input Medium.ThermodynamicState state_a
          "State for medium inflowing through port_a";
       input Medium.ThermodynamicState state_b
          "State for medium inflowing through port_b";
       input SI.AbsolutePressure dp_small;
       input SI.MassFlowRate m_flow_small;
    end dp_curvedOverall_fixedInterface;

    function dp_curvedOverall_MFLOW
      extends dp_curvedOverall_fixedInterface;
      input SI.Pressure dp "Pressure drop";
      output SI.MassFlowRate m_flow "Mass flow rate";
    algorithm
       m_flow := Bend.dp_curvedOverall_MFLOW(
                   geometry,
                   Bend.dp_curvedOverall_IN_var(
                       rho=Medium.density(Medium.setSmoothState(dp, state_a, state_b, dp_small)),
                       eta=Medium.dynamicViscosity(Medium.setSmoothState(dp, state_a, state_b, dp_small))),
                   dp);

       annotation(Inline=false, LateInline=true,
                  inverse(dp=dp_curvedOverall_DP(
                                geometry, state_a, state_b, dp_small, m_flow_small, m_flow)));
    end dp_curvedOverall_MFLOW;

    function dp_curvedOverall_DP
       extends dp_curvedOverall_fixedInterface;
       input SI.MassFlowRate m_flow "Mass flow rate";
       output SI.Pressure dp "Pressure drop";
    algorithm
       dp := Bend.dp_curvedOverall_DP(
                   geometry,
                   Bend.dp_curvedOverall_IN_var(
                       rho=Medium.density(Medium.setSmoothState(m_flow, state_a, state_b, m_flow_small)),
                       eta=Medium.dynamicViscosity(Medium.setSmoothState(m_flow, state_a, state_b, m_flow_small))),
                   m_flow);
    end dp_curvedOverall_DP;

    equation
      if use_nominal then
         m_flow = Bend.dp_curvedOverall_MFLOW(
                    geometry, Bend.dp_curvedOverall_IN_var(rho=rho_nominal, eta=eta_nominal), dp);
      elseif not allowFlowReversal then
         m_flow = Bend.dp_curvedOverall_MFLOW(
                    geometry, Bend.dp_curvedOverall_IN_var(
                                rho=Medium.density(state_a),
                                eta=Medium.dynamicViscosity(state_a)), dp);
      else
         m_flow = dp_curvedOverall_MFLOW(
                    geometry, state_a, state_b, dp_small, m_flow_small, dp);
      end if;

      annotation (Documentation(info="<html>
<p>
This component models the pressure loss in curved bends at overall flow regime for incompressible and single-phase fluid flow through circular cross sectional area considering surface roughness. In the model neither mass nor energy is stored.
</p>


<p><h4><font color=\"#ef9b13\">Restriction</font></h4></p>
<p>This function shall be used inside of the restricted limits according to the referenced literature. </p>
<p><ul>
<li><h4>circular cross sectional area </h4></li>
<li><b>0.5 &le; curvature radius / diameter &le; 3 </b><i>[Idelchik 2006, p. 357, diag. 6-1] </i></li>
<li><b>length of bend along curved axis / diameter &ge; 10 </b><i>[Idelchik 2006, p. 357, diag. 6-1] </i></li>
<li><b>angle of curvature smaller than 180&deg; (delta &le; 180) </b><i>[Idelchik 2006, p. 357, diag. 6-1] </i></li>
</ul></p>
<p><b><font style=\"color: #ef9b13; \">Geometry</font></b> </p>
<p><img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/pic_circularBend.png\"/> </p>
<p><h4><font color=\"#ef9b13\">Calculation</font></h4></p>
<p>The pressure loss <b>dp </b>for curved bends is determined by: </p>
<pre>dp = zeta_TOT * (rho/2) * velocity^2 </pre>
<p>with </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p><h4>rho </h4></p></td>
<td><p>as density of fluid [kg/m3],</p></td>
</tr>
<tr>
<td><p><h4>velocity </h4></p></td>
<td><p>as mean velocity [m/s],</p></td>
</tr>
<tr>
<td><p><h4>zeta_TOT </h4></p></td>
<td><p>as pressure loss coefficient [-].</p></td>
</tr>
</table>
<p><br/><b>Curved bends with relative curvature radius R_0/d_hyd &le; 3 </b>according to <i>[Idelchik 2006, p. 357, diag. 6-1]</i> </p>
<p>The pressure loss of curved bends is similar to its calculation in straight pipes. There are tree different flow regimes observed (laminar,transition,turbulent). The turbulent regime is further separated into sections with a dependence or independence of the local resistance coefficient (<b>zeta_LOC </b>) on Reynolds number. The local resistance coefficient (<b>zeta_LOC</b>) of a curved bend is calculated in dependence of the flow regime as follows: </p>
<p><ul>
<li><b>Laminar regime (Re &le; Re_lam_leave)</b>: <br/><br/></li>
<pre>      zeta_LOC = A2/Re + A1*B1*C1</pre>
<li><b>Transition regime (Re_lam_leave &le; 4e4)</b> This calculation is done using a smoothing function interpolating between the laminar and the first turbulent flow regime. </li>
<li><b>Turbulent regime (4e4 &le; 3e5) with dependence </b>of local resistance coefficient on Reynolds number: <br/><br/></li>
<pre>      zeta_LOC = k_Re * (A1*B1*C1)</pre>
<p>where <b>k_Re</b> depends on the relative curvature radius <b>R_0/d_hyd </b></p>
<pre>
      k_Re = 1 + 4400/Re              for 0.50 &LT; r/d_hyd &LT; 0.55
      k_Re = 5.45/Re^(0.118)          for 0.55 &le; r/d_hyd &LT; 0.70
      k_Re = 11.5/Re^(0.19)           for 0.70 &le; r/d_hyd &LT; 3.00</pre>
<li><b>Turbulent regime (Re &ge; 3e5) with independence </b>of local resistance coefficient on Reynolds number <br/><br/></li>
</ul></p>
<pre>      zeta_LOC = A1*B1*C1</pre>
<p>with </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p><h4>A1 </h4></p></td>
<td><p>as coefficient considering effect of angle of turning (delta) [-],</p></td>
</tr>
<tr>
<td><p><h4>A2 </h4></p></td>
<td><p>as coefficient considering effect for laminar regime [-],</p></td>
</tr>
<tr>
<td><p><h4>B1 </h4></p></td>
<td><p>as coefficient considering effect of relative curvature radius (R_0/d_hyd) [-],</p></td>
</tr>
<tr>
<td><p><h4>C1=1 </h4></p></td>
<td><p>as coefficient considering relative elongation of cross sectional area (here: circular cross sectional area) [-],</p></td>
</tr>
<tr>
<td><p><h4>k_Re </h4></p></td>
<td><p>as coefficient considering influence of laminar regime in transition regime [-],</p></td>
</tr>
<tr>
<td><p><h4>Re </h4></p></td>
<td><p>as Reynolds number [-].</p></td>
</tr>
</table>
<p><br/><br/>The pressure loss coefficient <b>zeta_TOT </b>of a curved bend including pressure loss due to friction is determined by its local resistance coefficient <b>zeta_LOC </b>multiplied with a correction factor <b>CF </b>for surface roughness according to <i>[Miller, p. 209, eq. 9.4]:</i> </p>
<pre>    zeta_TOT = CF*zeta_LOC </pre>
<p>where the correction factor <b>CF </b>is determined from the darcy friction factor of a straight pipe having the bend flow path length </p>
<pre>    CF = 1 + (lambda_FRI_rough * pi * delta/d_hyd) / zeta_LOC</pre>
<p>and the darcy friction factors <b>lambda_FRI_rough </b>is calculated with an approximated Colebrook-White law according to <i>[Miller, p. 191, eq. 8.4]:</i> </p>
<pre>    lambda_FRI_rough = 0.25*(lg(K/(3.7*d_hyd) + 5.74/Re^0.9))^-2</pre>
<p>with </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p><h4>delta </h4></p></td>
<td><p>as curvature radiant [rad],</p></td>
</tr>
<tr>
<td><p><h4>d_hyd </h4></p></td>
<td><p>as hydraulic diameter [m],</p></td>
</tr>
<tr>
<td><p><h4>K </h4></p></td>
<td><p>as absolute roughness (average height of surface asperities) [m],</p></td>
</tr>
<tr>
<td><p><h4>lambda_FRI_rough </h4></p></td>
<td><p>as darcy friction factor[-],</p></td>
</tr>
<tr>
<td><p><h4>Re </h4></p></td>
<td><p>as Reynolds number [m],</p></td>
</tr>
<tr>
<td><p><h4>zeta_LOC </h4></p></td>
<td><p>as local resistance coefficient [-],</p></td>
</tr>
<tr>
<td><p><h4>zeta_TOT </h4></p></td>
<td><p>as pressure loss coefficient [-].</p></td>
</tr>
</table>
<p><br/>The correction for surface roughness through <b>CF </b>is used only in the turbulent regime, where the fluid flow is influenced by surface asperities not covered by a laminar boundary layer. The turbulent regime starts at <b>Re &ge; 4e4 </b>according to <i>[Idelchik 2006, p. 336, sec. 15]</i>. There is no correction due to roughness in the laminar regime up to <b>Re &le; 6.5e3 </b>according to <i>[Idelchik 2006, p. 336, sec. 15]</i>. </p>
<p>Nevertheless the transition point from the laminar to the transition regime is shifted to smaller Reynolds numbers for an increasing absolute roughness. This effect is considered according to <i>[Samoilenko in Idelchik 2006, p. 81, sec. 2-1-21]</i> as: </p>
<pre>    Re_lam_leave = 754*exp(if k &le; 0.007 then 0.0065/0.007 else 0.0065/k)</pre>
<p>with </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p><h4>k = K /d_hyd </h4></p></td>
<td><p>as relative roughness [-],</p></td>
</tr>
<tr>
<td><p><h4>Re_lam_leave </h4></p></td>
<td><p>as Reynolds number for leaving laminar regime [-].</p></td>
</tr>
</table>
<p><br/><br/>Note that the beginning of the laminar regime cannot be beneath <b>Re &le; 1e2 </b>. </p>
<p><b><font style=\"color: #ef9b13; \">Verification</font></b> </p>
<p>The pressure loss coefficient <b>zeta_TOT </b>of a curved bend in dependence of the Reynolds number <b>Re </b>for different relative curvature radii <b>R_0/d_hyd </b>and different angles of turning <b>delta </b>is shown in the figures below. </p>
<p><img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/fig_bend_dp_curvedOverall_DPvsMFLOW.png\"/> </p>
<p>There are deviations of the pressure loss coefficient <b>zeta_TOT </b>comparing different references. Usually these deviations in the transition regime have to be accepted due to an uncertainty for the determination of comparable boundary conditions in the different references. Nevertheless these calculations cover the usual range of pressure loss coefficients for a curved bend. The pressure loss coefficient <b>zeta_TOT </b>for the same geometry can be adjusted via variing the average height of surface asperities <b>K </b>for calibration. </p>
<p><b>Incompressible case </b>[Pressure loss = f(m_flow)]: </p>
<p>The pressure loss in dependence of the mass flow rate of water is shown for different relative curvature radii: </p>
<p><img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/fig_bend_dp_curvedOverall_DPvsMFLOWwrtRD.png\"/> </p>
<p>The pressure loss in dependence of the mass flow rate of water is shown for different angles of turning: </p>
<p><img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/fig_bend_dp_curvedOverall_DPvsMFLOWwrtDelta.png\"/> </p>
<p>Note that there is a small deviation between the compressible and incompressible calculation due to the lack of a direct analytical invertibility. </p>
<p><b><font style=\"color: #ef9b13; \">References</font></b> </p>
<dl><dt>Elmquist,H., M.Otter and S.E. Cellier: </dt>
<dd><b>Inline integration: A new mixed symbolic / numeric approach for solving differential-algebraic equation systems.</b>. In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>
<dt>Idelchik,I.E.: </dt>
<dd><b>Handbook of hydraulic resistance</b>. Jaico Publishing House,Mumbai,3rd edition, 2006.</dd>
<dt>Miller,D.S.: </dt>
<dd><b>Internal flow systems</b>. volume 5th of BHRA Fluid Engineering Series.BHRA Fluid Engineering, 1984. </dd>
<dt>Samoilenko,L.A.: </dt>
<dd><b>Investigation of the hydraulic resistance of pipelines in the zone of transition from laminar into turbulent motion</b>. PhD thesis, Leningrad State University, 1968.</dd>
<dt>VDI: </dt>
<dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>. Springer Verlag, 9th edition, 2002. </dd>
</dl></html>"));
    end CurvedBend;

    model EdgedBend "Edged bend flow model"
      extends Modelica.Fluid.Fittings.BaseClasses.PartialPressureLoss;
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Bend_i;
      import Modelica.Fluid.Dissipation.PressureLoss.Bend;
      parameter Bend.dp_edgedOverall_IN_con geometry "Geometry of edged bend"
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

    /*
  Bend.dp_edgedOverall_IN_var
    properties(final eta=eta, final rho=rho) "Properties of medium"
    annotation (Placement(transformation(extent={{-46,20},{-26,40}})));
*/
    protected
      parameter Medium.AbsolutePressure dp_small= Bend.dp_edgedOverall_DP(
                    geometry, Bend.dp_edgedOverall_IN_var(
                      rho=Medium.density(Medium.setState_pTX(
                           Medium.reference_p,
                           Medium.reference_T,
                           Medium.reference_X)),
                      eta=Medium.dynamicViscosity(Medium.setState_pTX(
                           Medium.reference_p,
                           Medium.reference_T,
                           Medium.reference_X))),
                    m_flow_small)
        "Default small pressure drop for regularization of laminar and zero flow (calculated from m_flow_small)";

    partial function dp_edgedOverall_fixedInterface
       input Bend.dp_edgedOverall_IN_con geometry "Geometry of bend";
       input Medium.ThermodynamicState state_a
          "State for medium inflowing through port_a";
       input Medium.ThermodynamicState state_b
          "State for medium inflowing through port_b";
       input SI.AbsolutePressure dp_small;
       input SI.MassFlowRate m_flow_small;
    end dp_edgedOverall_fixedInterface;

    function dp_edgedOverall_MFLOW
      extends dp_edgedOverall_fixedInterface;
      input SI.Pressure dp "Pressure drop";
      output SI.MassFlowRate m_flow "Mass flow rate";
    algorithm
       m_flow := Bend.dp_edgedOverall_MFLOW(
                   geometry,
                   Bend.dp_edgedOverall_IN_var(
                       rho=Medium.density(Medium.setSmoothState(dp, state_a, state_b, dp_small)),
                       eta=Medium.dynamicViscosity(Medium.setSmoothState(dp, state_a, state_b, dp_small))),
                   dp);

       annotation(Inline=false, LateInline=true,
                  inverse(dp=dp_edgedOverall_DP(
                                geometry, state_a, state_b, dp_small, m_flow_small, m_flow)));
    end dp_edgedOverall_MFLOW;

    function dp_edgedOverall_DP
       extends dp_edgedOverall_fixedInterface;
       input SI.MassFlowRate m_flow "Mass flow rate";
       output SI.Pressure dp "Pressure drop";
    algorithm
       dp := Bend.dp_edgedOverall_DP(
                   geometry,
                   Bend.dp_edgedOverall_IN_var(
                       rho=Medium.density(Medium.setSmoothState(m_flow, state_a, state_b, m_flow_small)),
                       eta=Medium.dynamicViscosity(Medium.setSmoothState(m_flow, state_a, state_b, m_flow_small))),
                   m_flow);
    end dp_edgedOverall_DP;

    equation
      if use_nominal then
         m_flow = Bend.dp_edgedOverall_MFLOW(
                    geometry, Bend.dp_edgedOverall_IN_var(rho=rho_nominal, eta=eta_nominal), dp);
      elseif not allowFlowReversal then
         m_flow = Bend.dp_edgedOverall_MFLOW(
                    geometry, Bend.dp_edgedOverall_IN_var(
                                rho=Medium.density(state_a),
                                eta=Medium.dynamicViscosity(state_a)), dp);
      else
         m_flow = dp_edgedOverall_MFLOW(
                    geometry, state_a, state_b, dp_small, m_flow_small, dp);
      end if;

      annotation (Documentation(info="<html>
<p>
This component models the pressure loss in edged bends with sharp corners at overall flow regime for incompressible and single-phase fluid flow through circular cross sectional area considering surface roughness. In the model neither mass nor energy is stored.
</p>

<p>
There are larger pressure losses in an edged bend compared to a curved bend under the same conditions. The effect of a sharp corner in an edged bend on the pressure loss is much larger than the influence of surface roughness.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used inside of the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> circular cross sectional area </b> <i>[Idelchik 2006, p. 366, diag. 6-7] </i>
 </li>
 <li>
      <b> edged bend with sharp corners at turning </b> <i>[Idelchik 2006, p. 366, diag. 6-7] </i>
 </li>
 <li>
      <b> 0&deg; &le; angle of turning &le; 180&deg; </b> <i>[Idelchik 2006, p. 338, sec. 19] </i>
 </li>
 <li>
      <b> length of edged bend along edged axis / diameter &ge; 10 </b> <i>[Idelchik 2006, p. 366, diag. 6-7] </i>
 </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry</font></h4>
<p>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/pic_edgedBend.png\">
</p>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The pressure loss <b> dp </b> for edged bends is determined by:
<p>
<pre>
    dp = zeta_TOT * (rho/2) * velocity^2
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> rho            </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> velocity       </b></td><td> as mean velocity [m/s],</td></tr>
<tr><td><b> zeta_TOT       </b></td><td> as pressure loss coefficient [-].</td></tr>
</table>
</p>

The pressure loss coefficient <b> zeta_TOT </b> of an edged bend can be calculated for different angles of turning <b> delta </b> by:
<p>
<pre>
    zeta_TOT = A * C1 * zeta_LOC * CF_Fri* CF_Re <i>[Idelchik 2006, p. 366, diag. 6-7] </i> and <i>[Miller 1984, p. 149, sec. 9.4]</i>
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> A              </b></td><td> as coefficient considering effect for angle of turning [-],</td></tr>
<tr><td><b> C1             </b></td><td> as coefficient considering relative elongation of cross sectional area (here: circular cross sectional area) [-],</td></tr>
<tr><td><b> CF_Fri         </b></td><td> as correction factor considering surface roughness [-],</td></tr>
<tr><td><b> CF_Re          </b></td><td> as correction factor considering Reynolds number [-],</td></tr>
<tr><td><b> delta          </b></td><td> as angle of turning [deg].</td></tr>
</table>
</p>

The correction factor <b> CF_Fri </b> regarding the influence of surface roughness is determined as ratio of the Darcy friction factor for rough surfaces to smooth surfaces according to <i>[Miller, p. 207, eq. 9.3]:</i>
</p>
<pre>
    CF_Fri = lambda_FRI_rough / lambda_FRI_smooth
</pre>

<p>
and the Darcy friction factors <b> lambda_FRI </b> are calculated with an approximated Colebrook-White law according to <i>[Miller, p. 191, eq. 8.4]:</i>
</p>
<pre>
    lambda_FRI = 0.25*(lg(K/(3.7*d_hyd) + 5.74/Re^0.9))^-2
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_hyd              </b></td><td> as hydraulic diameter [m],</td></tr>
<tr><td><b> K                  </b></td><td> as absolute roughness (average height of surface asperities) [m],</td></tr>
<tr><td><b> lambda_FRI         </b></td><td> as Darcy friction factor[-],</td></tr>
<tr><td><b> Re                 </b></td><td> as Reynolds number [m],</td></tr>
<tr><td><b> zeta_TOT           </b></td><td> as pressure loss coefficient [-].</td></tr>
</table>
</p>

<p>
Note that the Darcy friction factor for a smooth surface <b> lambda_FRI_smooth </b> is calculated with the previous equation and an absolute roughness of <b> K = 0 </b>. Additionally no influence of surface roughness is considered for angles of turning equal or smaller than 45&deg; according to <i>[Miller 1984, p. 214, eq. 9.4.2]</i>.
</p>

<p>
The correction for surface roughness through <b> CF_Fri </b> is used only in the turbulent regime, where the fluid flow is influenced by surface asperities not covered by a laminar boundary layer. Here the correction according to friction starts at <b> Re &ge; Re_lam_leave </b> according to <i>[Idelchik 2006, p. 336, sec. 15]</i>. Here the end of the laminar regime is restricted to a Reynolds number smaller than 2e3 w.r.t. <i>[VDI, p. Lac 6, fig. 16]</i>.
</p>

<p>
Nevertheless the transition point from the laminar to the transition regime is shifted to smaller Reynolds numbers for an increasing absolute roughness. This effect is considered according to <i>[Samoilenko in Idelchik 2006, p. 81, sec. 2-1-21]</i> as:
<pre>
    Re_lam_leave = 754*exp(if k &le; 0.007 then 0.0065/0.007 else 0.0065/k)
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> k = K /d_hyd       </b></td><td> as relative roughness [-],</td></tr>
<tr><td><b> Re_lam_leave       </b></td><td> as Reynolds number for leaving laminar regime [-].</td></tr>
</table>
</p>

<p>
Note that the beginning of the laminar regime cannot be beneath <b> Re &le; 1e2 </b> according to <i>[VDI 2002, p. Lac 6, fig. 16]</i>
</p>

<p>
In addition the influence or decreasing Reynolds numbers <b> Re </b> on the pressure loss coefficient <b> zeta_TOT </b> in the laminar regime is considered through a second correction factor <b> CF_Re </b> according to <i>[Miller 1984, p. 149, sec. 9.4]</i> and <i>[Idelchik 2006, p. 340, sec. 28]</i> by:
</p>

<p>
<pre>
CF_Re = B/Re^exp for Re &le; Re_lam_leave
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> B = f(Geometry)  </b></td><td> as coefficient considering effect of Reynolds number in laminar regime [-],</td></tr>
<tr><td><b> exp              </b></td><td> as exponent for Reynolds number in laminar regime [-],</td></tr>
<tr><td><b> Re               </b></td><td> as Reynolds number [-], </td></tr>
<tr><td><b> Re_lam_leave     </b></td><td> as Reynolds number for leaving laminar regime [-].</td></tr>
</table>
</p>

<p>
Note that the coefficient <b> B </b> considers the influence of the angle of turning <b> delta </b> on the pressure loss coefficient <b> zeta_TOT </b> in the laminar regime according to <i>[Idelchik 2006, p. 340, sec. 28]</i>.
</p>

<p>
Note that the correction of the pressure loss coefficient <b> zeta_TOT </b> is influenced by the correction factor <b> CF_Re </b> only for decreasing Reynolds numbers <b> Re </b> out of the turbulent fluid flow regime at <b> Re &le; Re_lam_leave </b> into transition and laminar fluid flow regime.
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The pressure loss coefficient <b> zeta_TOT </b> of a edged bend in dependence of the Reynolds number <b> Re </b> for different angles of turning <b> delta </b> is shown in the figures below.
<p>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/fig_bend_dp_edgedOverall_ZETAvsRE.png\">
</p>

<p>
Pressure loss calculation of edged bends is complex and there are large differences in literature data. Nevertheless these calculations cover the usual range of pressure loss coefficients for an edged bend.
</p>

<p>
The validation of the pressure loss coefficient for an edged bends shows four possible flow regimes:
<ul>
 <li>
      <b> laminar regime </b> for Re &le; 4e2
 <li>
      <b> transition regime </b> for 4e2 &le; Re &le; 2e3
 <li>
      <b> dependent turbulent regime on Reynolds number for 2e3 &le; Re &le; 1e5
 <li>
      <b> independent turbulent regime of Reynolds number for Re &ge; 1e5
</ul>
</p>

<p>
<b> Incompressible case </b> [Pressure loss = f(m_flow)]:
</p>
<p>
The pressure loss in dependence of the mass flow rate of water is shown for different angles of turning:
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/fig_bend_dp_edgedOverall_DPvsMFLOWwrtDelta.png\">
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Idelchik,I.E.:</dt>
    <dd><b>Handbook of hydraulic resistance</b>.
    Jaico Publishing House,Mumbai,3rd edition, 2006.</dd>
<dt>Miller,D.S.:</dt>
    <dd><b>Internal flow systems</b>.
    volume 5th of BHRA Fluid Engineering Series.BHRA Fluid Engineering, 1984.
 <dt>Samoilenko,L.A.:</dt>
    <dd><b>Investigation of the hydraulic resistance of pipelines in the
        zone of transition from laminar into turbulent motion</b>.
        PhD thesis, Leningrad State University, 1968.</dd>
<dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>
</html>
"));
    end EdgedBend;
  end Bends;

  package Orifices "Flow models for orifices"
    extends Modelica.Icons.VariantsPackage;

    model ThickEdgedOrifice "Thicked edged orifice flow model"
      extends Modelica.Fluid.Fittings.BaseClasses.PartialPressureLoss;
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Orifice_i;
      import Modelica.Fluid.Dissipation.PressureLoss.Orifice;
      parameter Orifice.dp_thickEdgedOverall_IN_con geometry
        "Geometry of curved bend"
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

    /*
  Orifice.dp_thickEdgedOverall_IN_var
    properties(final eta=eta, final rho=rho) "Properties of medium"
    annotation (Placement(transformation(extent={{-46,20},{-26,40}})));
*/
    protected
      parameter Medium.AbsolutePressure dp_small= Orifice.dp_thickEdgedOverall_DP(
                    geometry, Orifice.dp_thickEdgedOverall_IN_var(
                      rho=Medium.density(Medium.setState_pTX(
                           Medium.reference_p,
                           Medium.reference_T,
                           Medium.reference_X)),
                      eta=Medium.dynamicViscosity(Medium.setState_pTX(
                           Medium.reference_p,
                           Medium.reference_T,
                           Medium.reference_X))),
                    m_flow_small)
        "Default small pressure drop for regularization of laminar and zero flow (calculated from m_flow_small)";

    partial function dp_thickEdgedOverall_fixedInterface
       input Orifice.dp_thickEdgedOverall_IN_con geometry "Geometry of bend";
       input Medium.ThermodynamicState state_a
          "State for medium inflowing through port_a";
       input Medium.ThermodynamicState state_b
          "State for medium inflowing through port_b";
       input SI.AbsolutePressure dp_small;
       input SI.MassFlowRate m_flow_small;
    end dp_thickEdgedOverall_fixedInterface;

    function dp_thickEdgedOverall_MFLOW
      extends dp_thickEdgedOverall_fixedInterface;
      input SI.Pressure dp "Pressure drop";
      output SI.MassFlowRate m_flow "Mass flow rate";
    algorithm
       m_flow := Orifice.dp_thickEdgedOverall_MFLOW(
                   geometry,
                   Orifice.dp_thickEdgedOverall_IN_var(
                       rho=Medium.density(Medium.setSmoothState(dp, state_a, state_b, dp_small)),
                       eta=Medium.dynamicViscosity(Medium.setSmoothState(dp, state_a, state_b, dp_small))),
                   dp);

       annotation(Inline=false, LateInline=true,
                  inverse(dp=dp_thickEdgedOverall_DP(
                                geometry, state_a, state_b, dp_small, m_flow_small, m_flow)));
    end dp_thickEdgedOverall_MFLOW;

    function dp_thickEdgedOverall_DP
       extends dp_thickEdgedOverall_fixedInterface;
       input SI.MassFlowRate m_flow "Mass flow rate";
       output SI.Pressure dp "Pressure drop";
    algorithm
       dp := Orifice.dp_thickEdgedOverall_DP(
                   geometry,
                   Orifice.dp_thickEdgedOverall_IN_var(
                       rho=Medium.density(Medium.setSmoothState(m_flow, state_a, state_b, m_flow_small)),
                       eta=Medium.dynamicViscosity(Medium.setSmoothState(m_flow, state_a, state_b, m_flow_small))),
                   m_flow);
    end dp_thickEdgedOverall_DP;

    equation
      if use_nominal then
         m_flow = Orifice.dp_thickEdgedOverall_MFLOW(
                    geometry, Orifice.dp_thickEdgedOverall_IN_var(rho=rho_nominal, eta=eta_nominal), dp);
      elseif not allowFlowReversal then
         m_flow = Orifice.dp_thickEdgedOverall_MFLOW(
                    geometry, Orifice.dp_thickEdgedOverall_IN_var(
                                rho=Medium.density(state_a),
                                eta=Medium.dynamicViscosity(state_a)), dp);
      else
         m_flow = dp_thickEdgedOverall_MFLOW(
                    geometry, state_a, state_b, dp_small, m_flow_small, dp);
      end if;

      annotation (Documentation(info="<html>
<p>
This component models the pressure loss in thick edged orifices with sharp corners at overall flow regime for incompressible and single-phase fluid flow through an arbitrary shaped cross sectional area (square, circular, etc.) considering constant influence of surface roughness. In the model neither mass nor energy is stored.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used within the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> Reynolds number (for vena contraction) Re &gt 1e3 </b> <i>[Idelchik 2006, p. 222, diag. 4-15] </i>
 <li>
      <b> Relative length of vena contraction (L/d_hyd_0) &gt 0.015 </b> <i>[Idelchik 2006, p. 222, diag. 4-15] </i>
 <li>
      <b> Darcy friction factor lambda_FRI = 0.02 </b> <i>[Idelchik 2006, p. 222, sec. 4-15] </i>
</ul>

<h4><font color=\"#EF9B13\">Geometry</font></h4>
<p>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/pic_thickEdged.png\">
</p>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The pressure loss <b> dp </b> for a thick edged orifice is determined by:
<p>
<pre>
dp = zeta_TOT * (rho/2) * (velocity_1)^2
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> rho            </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> velocity_1     </b></td><td> as mean velocity in large cross sectional area [m/s],</td></tr>
<tr><td><b> zeta_TOT       </b></td><td> as pressure loss coefficient [-].</td></tr>
</table>
</p>

The pressure loss coefficient <b> zeta_TOT </b> of a thick edged orifice can be calculated for different cross sectional areas <b> A_0 </b> and relative length of orifice <b> l_bar </b>=L/d_hyd_0 by:
<p>
<pre>
zeta_TOT = (0.5*(1 - A_0/A_1)^0.75 + tau*(1 - A_0/A_1)^1.375 + (1 - A_0/A_1)^2 + lambda_FRI*l_bar)*(A_1/A_0)^2 <i>[Idelchik 2006, p. 222, diag. 4-15] </i>
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> A_0       </b></td><td> cross sectional area of vena contraction [m2],</td></tr>
<tr><td><b> A_1       </b></td><td> large cross sectional area of orifice [m2],</td></tr>
<tr><td><b> d_hyd_0   </b></td><td> hydraulic diameter of vena contraction [m],</td></tr>
<tr><td><b> lambda_FRI</b></td><td> as constant Darcy friction factor [-],</td></tr>
<tr><td><b> l_bar     </b></td><td> relative length of orifice [-],</td></tr>
<tr><td><b> L         </b></td><td> length of vena contraction [m],</td></tr>
<tr><td><b> tau       </b></td><td> geometry parameter [-].</td></tr>
</table>
</p>

<p>
The geometry factor <b> tau </b> is determined by <i>[Idelchik 2006, p. 219, diag. 4-12]</i>:
</p>

<p>
<pre>
tau = (2.4 - l_bar)*10^(-phi)
phi = 0.25 + 0.535*l_bar^8 / (0.05 + l_bar^8) .
</pre>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
The pressure loss coefficient <b> zeta_TOT </b> of a thick edged orifice in dependence of a relative length <b>(l_bar = L /d_hyd)</b> with different ratios of cross sectional areas <b> A_0/A_1 </b> is shown in the figure below.
<p>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/fig_orifice_thickEdgedOverall_ZETAvsLENGHT.png\">
</p>

<p>
<b> Incompressible case </b> [Pressure loss = f(m_flow)]:
</p>
The pressure loss <b> DP </b> of an thick edged orifice in dependence of the mass flow rate <b> m_flow </b> of water for different ratios <b>A_0/A_1</b> (where <b> A_0 </b> = 0.001 m^2) is shown in the figure below.
<p>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/fig_orifice_thickEdgedOverall_DPvsMFLOW.png\">
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>Elmquist,H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>
<dt>Idelchik,I.E.:</dt>
    <dd><b>Handbook of hydraulic resistance</b>.
    Jaico Publishing House,Mumbai,3rd edition, 2006.</dd>
</dl>
</html>
"));
    end ThickEdgedOrifice;

    model SuddenChangeOrifice "Sudden section change orifice flow model"
      extends Modelica.Fluid.Fittings.BaseClasses.PartialPressureLoss;
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Orifice_i;
      import Modelica.Fluid.Dissipation.PressureLoss.Orifice;
      parameter Orifice.dp_suddenChange_IN_con geometry
        "Geometry of sudden section change orifice"
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

    /*
  Orifice.dp_suddenChange_IN_var
    properties(final eta=eta, final rho=rho) "Properties of medium"
    annotation (Placement(transformation(extent={{-46,20},{-26,40}})));
*/
    protected
      parameter Medium.AbsolutePressure dp_small= Orifice.dp_suddenChange_DP(
                    geometry, Orifice.dp_suddenChange_IN_var(
                      rho=Medium.density(Medium.setState_pTX(
                           Medium.reference_p,
                           Medium.reference_T,
                           Medium.reference_X)),
                      eta=Medium.dynamicViscosity(Medium.setState_pTX(
                           Medium.reference_p,
                           Medium.reference_T,
                           Medium.reference_X))),
                    m_flow_small)
        "Default small pressure drop for regularization of laminar and zero flow (calculated from m_flow_small)";

    partial function dp_suddenChange_fixedInterface
       input Orifice.dp_suddenChange_IN_con geometry "Geometry of bend";
       input Medium.ThermodynamicState state_a
          "State for medium inflowing through port_a";
       input Medium.ThermodynamicState state_b
          "State for medium inflowing through port_b";
       input SI.AbsolutePressure dp_small;
       input SI.MassFlowRate m_flow_small;
    end dp_suddenChange_fixedInterface;

    function dp_suddenChange_MFLOW
      extends dp_suddenChange_fixedInterface;
      input SI.Pressure dp "Pressure drop";
      output SI.MassFlowRate m_flow "Mass flow rate";
    algorithm
       m_flow := Orifice.dp_suddenChange_MFLOW(
                   geometry,
                   Orifice.dp_suddenChange_IN_var(
                       rho=Medium.density(Medium.setSmoothState(dp, state_a, state_b, dp_small)),
                       eta=Medium.dynamicViscosity(Medium.setSmoothState(dp, state_a, state_b, dp_small))),
                   dp);

       annotation(Inline=false, LateInline=true,
                  inverse(dp=dp_suddenChange_DP(
                                geometry, state_a, state_b, dp_small, m_flow_small, m_flow)));
    end dp_suddenChange_MFLOW;

    function dp_suddenChange_DP
       extends dp_suddenChange_fixedInterface;
       input SI.MassFlowRate m_flow "Mass flow rate";
       output SI.Pressure dp "Pressure drop";
    algorithm
       dp := Orifice.dp_suddenChange_DP(
                   geometry,
                   Orifice.dp_suddenChange_IN_var(
                       rho=Medium.density(Medium.setSmoothState(m_flow, state_a, state_b, m_flow_small)),
                       eta=Medium.dynamicViscosity(Medium.setSmoothState(m_flow, state_a, state_b, m_flow_small))),
                   m_flow);
    end dp_suddenChange_DP;

    equation
      if use_nominal then
         m_flow = Orifice.dp_suddenChange_MFLOW(
                    geometry, Orifice.dp_suddenChange_IN_var(rho=rho_nominal, eta=eta_nominal), dp);
      elseif not allowFlowReversal then
         m_flow = Orifice.dp_suddenChange_MFLOW(
                    geometry, Orifice.dp_suddenChange_IN_var(
                                rho=Medium.density(state_a),
                                eta=Medium.dynamicViscosity(state_a)), dp);
      else
         m_flow = dp_suddenChange_MFLOW(
                    geometry, state_a, state_b, dp_small, m_flow_small, dp);
      end if;

      annotation (Documentation(info="<html>
<p>
This component models local pressure loss at a sudden change of the cross sectional areas (sudden expansion or sudden contraction) with sharp corners at turbulent flow regime for incompressible and single-phase fluid flow through arbitrary shaped cross sectional area (square, circular, etc.) considering a smooth surface. The flow direction determines the type of the transition. In case of the design flow a sudden expansion will be considered. At flow reversal a sudden contraction will be considered. In the model neither mass nor energy is stored.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used within the restricted limits according to the referenced literature.
<ul>
 <li>
      <b>Smooth surface</b>
 <li>
      <b>Turbulent flow regime</b>
 <li>
      <b>Reynolds number for sudden expansion Re &gt 3.3e3 </b> <i>[Idelchik 2006, p. 208, diag. 4-1] </i>
 <li>
      <b>Reynolds number for sudden contraction Re &gt 1e4 </b> <i>[Idelchik 2006, p. 216-217, diag. 4-9] </i>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>
<p>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/pic_suddenChangeSection.png\">
</p>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The local pressure loss <b> dp </b> is generally determinated by:
<p>
<pre>
dp = 0.5 * zeta_LOC * rho * |v_1|*v_1
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> rho              </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> v_1             </b></td><td> as average flow velocity in small cross sectional area [m/s].</td></tr>
<tr><td><b> zeta_LOC         </b></td><td> as local resistance coefficient [-],</td></tr>
</table>
</p>

The local resistance coefficient <b> zeta_LOC </b> of a sudden expansion can be calculated for different ratios of cross sectional areas by:
<p>
<pre>
zeta_LOC = (1 - A_1/A_2)^2  <i>[Idelchik 2006, p. 208, diag. 4-1] </i>
</pre>
</p>


and for sudden contraction:
<p>
<pre>
zeta_LOC = 0.5*(1 - A_1/A_2)^0.75  <i>[Idelchik 2006, p. 216-217, diag. 4-9] </i>
</pre>
</p>


<p>
with
</p>

<p>
<table>
<tr><td><b> A_1       </b></td><td> small cross sectional area [m^2],</td></tr>
<tr><td><b> A_2       </b></td><td> large cross sectional area [m^2]</td></tr>.

</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
The local resistance coefficient <b> zeta_LOC </b> of a sudden expansion in dependence of the cross sectional area ratio <b> A_1/A_2 </b> is shown in the figure below.
<p>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/fig_orifice_suddenChangeExpansion.png\">
</p>

The local resistance coefficient <b> zeta_LOC </b> of a sudden contraction in dependence of the cross sectional area ratio <b> A_1/A_2 </b> is shown in the figure below.
<p>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/fig_orifice_suddenChangeContraction.png\">
</p>


<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Elmquist, H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>

<dt>Idelchik,I.E.:</dt>
    <dd><b>Handbook of hydraulic resistance</b>.
    Jaico Publishing House,Mumbai,3rd edition, 2006.</dd>
</dl>
</html>
"));
    end SuddenChangeOrifice;
  end Orifices;

  package GenericResistances
    "Static geometry independent flow resistance components "
  extends Modelica.Icons.VariantsPackage;

    model NominalDensityViscosity
      "Component model for geometry independent flow resistance parameterized with nominal density and nominal viscosity"
        extends Modelica.Fluid.Fittings.BaseClasses.PartialPressureLoss;
      import Modelica.Fluid.Dissipation.PressureLoss.General;
      parameter General.dp_nominalDensityViscosity_IN_con coefficients annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

      //icon
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.General_i;

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium in the component" annotation (choicesAllMatching=true);

    protected
      parameter Medium.AbsolutePressure dp_small= General.dp_nominalDensityViscosity_DP(
                    coefficients, General.dp_nominalDensityViscosity_IN_var(
                    rho=Medium.density(Medium.setState_pTX(
                           Medium.reference_p,
                           Medium.reference_T,
                           Medium.reference_X)),
                      eta=Medium.dynamicViscosity(Medium.setState_pTX(
                           Medium.reference_p,
                           Medium.reference_T,
                           Medium.reference_X))), m_flow_small)
        "Default small pressure drop for regularization of laminar and zero flow (calculated from m_flow_small)";

    partial function dp_nominalDensityViscosity_fixedInterface
       input General.dp_nominalDensityViscosity_IN_con coefficients
          "Parameterization";
       input Medium.ThermodynamicState state_a
          "State for medium inflowing through port_a";
       input Medium.ThermodynamicState state_b
          "State for medium inflowing through port_b";
       input SI.AbsolutePressure dp_small;
       input SI.MassFlowRate m_flow_small;
    end dp_nominalDensityViscosity_fixedInterface;

    function dp_nominalDensityViscosity_MFLOW
      extends dp_nominalDensityViscosity_fixedInterface;
      input SI.Pressure dp "Pressure drop";
      output SI.MassFlowRate m_flow "Mass flow rate";
    algorithm
       m_flow := General.dp_nominalDensityViscosity_MFLOW(
                   coefficients,
                   General.dp_nominalDensityViscosity_IN_var(
                       rho=Medium.density(Medium.setSmoothState(dp, state_a, state_b, dp_small)),
                       eta=Medium.dynamicViscosity(Medium.setSmoothState(dp, state_a, state_b, dp_small))),
                   dp);

       annotation(Inline=false, LateInline=true,
                  inverse(dp=dp_nominalDensityViscosity_DP(
                                coefficients, state_a, state_b, dp_small, m_flow_small, m_flow)));
    end dp_nominalDensityViscosity_MFLOW;

    function dp_nominalDensityViscosity_DP
       extends dp_nominalDensityViscosity_fixedInterface;
       input SI.MassFlowRate m_flow "Mass flow rate";
       output SI.Pressure dp "Pressure drop";
    algorithm
       dp := General.dp_nominalDensityViscosity_DP(
                   coefficients,
                   General.dp_nominalDensityViscosity_IN_var(
                       rho=Medium.density(Medium.setSmoothState(m_flow, state_a, state_b, m_flow_small)),
                       eta=Medium.dynamicViscosity(Medium.setSmoothState(m_flow, state_a, state_b, m_flow_small))),
                   m_flow);
    end dp_nominalDensityViscosity_DP;

    equation
      if use_nominal then
         m_flow = General.dp_nominalDensityViscosity_MFLOW(
                    coefficients, General.dp_nominalDensityViscosity_IN_var(rho=rho_nominal, eta=eta_nominal), dp);
      elseif not allowFlowReversal then
         m_flow = General.dp_nominalDensityViscosity_MFLOW(
                    coefficients, General.dp_nominalDensityViscosity_IN_var(
                                rho=Medium.density(state_a),
                                eta=Medium.dynamicViscosity(state_a)), dp);
      else
         m_flow = dp_nominalDensityViscosity_MFLOW(
                    coefficients, state_a, state_b, dp_small, m_flow_small, dp);
      end if;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-150,92},{150,52}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255},
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
                true, extent={{-100,-100},{100,100}}), graphics),
        Documentation(info="<html>
<p>This component models dissipative pressure loss from a nominal operating point with given density and viscosity, using the functions <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_DP\">dp_nominalDensityViscosity_DP</a> and <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_MFLOW\">dp_nominalDensityViscosity_MFLOW</a>, respectively. Neither mass nor energy is stored in the model. </p>
</html>"));
    end NominalDensityViscosity;

    model NominalVolumeFlowRate "Component model for geometry independent flow resistance parameterized with nominal volume flow rate and
  characterictic dependency"
        extends Modelica.Fluid.Fittings.BaseClasses.PartialPressureLoss;
      import Modelica.Fluid.Dissipation.PressureLoss.General;
      parameter General.dp_volumeFlowRate_IN_con coefficients annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

      //icon
      extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.General_i;

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium in the component" annotation (choicesAllMatching=true);

    protected
      parameter Medium.AbsolutePressure dp_small= General.dp_volumeFlowRate_DP(
                    coefficients, General.dp_volumeFlowRate_IN_var(
                    rho=Medium.density(Medium.setState_pTX(
                           Medium.reference_p,
                           Medium.reference_T,
                           Medium.reference_X))), m_flow_small)
        "Default small pressure drop for regularization of laminar and zero flow (calculated from m_flow_small)";

    partial function dp_volumeFlowRate_fixedInterface
       input General.dp_volumeFlowRate_IN_con coefficients "Parameterization";
       input Medium.ThermodynamicState state_a
          "State for medium inflowing through port_a";
       input Medium.ThermodynamicState state_b
          "State for medium inflowing through port_b";
       input SI.AbsolutePressure dp_small;
       input SI.MassFlowRate m_flow_small;
    end dp_volumeFlowRate_fixedInterface;

    function dp_volumeFlowRate_MFLOW
      extends dp_volumeFlowRate_fixedInterface;
      input SI.Pressure dp "Pressure drop";
      output SI.MassFlowRate m_flow "Mass flow rate";
    algorithm
       m_flow := General.dp_volumeFlowRate_MFLOW(
                   coefficients,
                   General.dp_volumeFlowRate_IN_var(
                       rho=Medium.density(Medium.setSmoothState(dp, state_a, state_b, dp_small))),
                   dp);

       annotation(Inline=false, LateInline=true,
                  inverse(dp=dp_volumeFlowRate_DP(
                                coefficients, state_a, state_b, dp_small, m_flow_small, m_flow)));
    end dp_volumeFlowRate_MFLOW;

    function dp_volumeFlowRate_DP
       extends dp_volumeFlowRate_fixedInterface;
       input SI.MassFlowRate m_flow "Mass flow rate";
       output SI.Pressure dp "Pressure drop";
    algorithm
       dp := General.dp_volumeFlowRate_DP(
                   coefficients,
                   General.dp_volumeFlowRate_IN_var(
                       rho=Medium.density(Medium.setSmoothState(m_flow, state_a, state_b, m_flow_small))),
                   m_flow);
    end dp_volumeFlowRate_DP;

    equation
      if use_nominal then
         m_flow = General.dp_volumeFlowRate_MFLOW(
                    coefficients, General.dp_volumeFlowRate_IN_var(rho=rho_nominal), dp);
      elseif not allowFlowReversal then
         m_flow = General.dp_volumeFlowRate_MFLOW(
                    coefficients, General.dp_volumeFlowRate_IN_var(
                                rho=Medium.density(state_a)), dp);
      else
         m_flow = dp_volumeFlowRate_MFLOW(
                    coefficients, state_a, state_b, dp_small, m_flow_small, dp);
      end if;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-150,92},{150,52}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255},
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
                true, extent={{-100,-100},{100,100}}), graphics),
        Documentation(info="<html>
<p>This component models dissipative pressure loss from a nominal operating point given as , using the functions <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP\">dp_volumeFlowRate_DP</a> and <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW\">dp_volumeFlowRate_MFLOW</a>, respectively. Neither mass nor energy is stored in the model. </p>
</html>"));
    end NominalVolumeFlowRate;
  end GenericResistances;

     extends Modelica.Icons.VariantsPackage;

model SimpleGenericOrifice
    "Simple generic orifice defined by pressure loss coefficient and diameter (only for flow from port_a to port_b)"

  extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;

  extends Modelica.Fluid.Interfaces.PartialLumpedFlow(
    final pathLength = 0,
    final momentumDynamics = Types.Dynamics.SteadyState);

  parameter SI.Diameter diameter "Diameter of orifice";
  parameter Real zeta "Loss factor for flow of port_a -> port_b"
    annotation(Dialog(enable=use_zeta));
  parameter Boolean use_zeta = true
      "= false to obtain zeta from dp_nominal and m_flow_nominal";

  // Operational conditions
  parameter SI.AbsolutePressure dp_nominal = 1e3 "Nominal pressure drop";
  parameter SI.MassFlowRate m_flow_nominal = 1 "Mass flow rate for dp_nominal";

  parameter Boolean from_dp = true
      "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Medium.AbsolutePressure dp_small = system.dp_small
      "Turbulent flow if |dp| >= dp_small"
    annotation(Dialog(tab="Advanced", enable=from_dp));

  // Variables
  Real zeta_nominal(start = zeta);
  Medium.Density d = 0.5*(Medium.density(state_a) + Medium.density(state_b));
  Modelica.SIunits.Pressure dp_fg(start=dp_start)
      "pressure loss due to friction and gravity";
  Modelica.SIunits.Area A_mean = Modelica.Constants.pi/4*diameter^2
      "mean cross flow area";

equation
  if use_zeta then
    zeta_nominal = zeta;
  else
    dp_nominal = BaseClasses.lossConstant_D_zeta(diameter, zeta_nominal)/d*m_flow_nominal^2;
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
    m_flow = Utilities.regRoot2(
        dp_fg,
        dp_small,
        Medium.density(state_a)/BaseClasses.lossConstant_D_zeta(diameter, zeta_nominal),
        Medium.density(state_b)/BaseClasses.lossConstant_D_zeta(diameter, zeta_nominal));
  else
    dp_fg = Utilities.regSquare2(
        m_flow,
        m_flow_small,
        BaseClasses.lossConstant_D_zeta(diameter, zeta_nominal)/Medium.density(state_a),
        BaseClasses.lossConstant_D_zeta(diameter, zeta_nominal)/Medium.density(state_b));
  end if;

  // Isenthalpic state transformation (no storage and no loss of energy)
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);

  annotation (defaultComponentName="orifice",
    Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
    Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(
            points={{-60,-50},{-60,50},{60,-50},{60,50}},
            color={0,0,0},
            thickness=0.5),
          Line(points={{-60,0},{-100,0}}, color={0,127,255}),
          Line(points={{60,0},{100,0}}, color={0,127,255}),
          Text(
            extent={{-173,104},{175,62}},
            lineColor={0,0,0},
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
              100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,44},{100,-44}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255}),
          Polygon(
            points={{-25,44},{-25,7},{35,37},{35,44},{-25,44}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Backward,
            fillColor={175,175,175}),
          Polygon(
            points={{-25,-7},{-25,-44},{35,-44},{35,-36},{-25,-7}},
            lineColor={0,0,0},
            fillColor={175,175,175},
            fillPattern=FillPattern.Backward)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,60},{100,-60}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-30,60},{-30,12},{30,50},{30,60},{-30,60}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
          Polygon(
            points={{-30,-10},{-30,-60},{30,-60},{30,-50},{-30,-10}},
            lineColor={0,0,0},
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
              100,100}},
          grid={1,1}), graphics={
          Line(points={{0,40},{-100,40},{-100,-40},{0,-40},{0,-100},{100,-100},
                {100,100},{0,100},{0,40}}, color={0,0,0}),
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
                {100,100},{0,100},{0,40}}, color={0,0,0}),
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
              100}},
          grid={1,1}), graphics={Rectangle(
            extent=DynamicSelect({{-100,22},{0,-22}}, {{-100,max(0.1, min(1,
                diameter_a/max(diameter_a, diameter_b)))*60},{0,-max(0.1, min(1,
                diameter_a/max(diameter_a, diameter_b)))*60}}),
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255}), Rectangle(
            extent=DynamicSelect({{0,60},{100,-60}}, {{0,max(0.1, min(1,
                diameter_b/max(diameter_a, diameter_b)))*60},{100,-max(0.1, min(
                1, diameter_b/max(diameter_a, diameter_b)))*60}}),
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255})}),
      Documentation(info="<html>

</html>"));
end AbruptAdaptor;

  model MultiPort
    "Multiply a port; useful if multiple connections shall be made to a port exposing a state"

    function positiveMax
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
      annotation (Placement(transformation(extent={{-50,-10},{-30,10}},
            rotation=0)));
    Modelica.Fluid.Interfaces.FluidPorts_b ports_b[nPorts_b](
      redeclare each package Medium=Medium)
      annotation (Placement(transformation(extent={{30,40},{50,-40}},
                                  rotation=0)));

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
The mixing is shifted into the volume connected to port_a and the result is propageted back to each ports_b.
</p>
<p>
If multiple connections were directly made to the volume,
then ideal mixing would take place in the connection set, outside the volume. This is normally not intended.
</p>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-40,-100},{
              40,100}}),
              graphics));
  end MultiPort;

  model TeeJunctionIdeal
    "Splitting/joining component with static balances for an infinitesimal control volume"
    extends Modelica.Fluid.Fittings.BaseClasses.PartialTeeJunction;

  equation
    connect(port_1, port_2) annotation (Line(
        points={{-100,0},{100,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(port_1, port_3) annotation (Line(
        points={{-100,0},{0,0},{0,100}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation(Documentation(info="<html>
  This model is the simplest implementation for a splitting/joining component for
  three flows. Its use is not required. It just formulates the balance
  equations in the same way that the connect symmantics would formulate them anyways.
  The main advantage of using this component is, that the user does not get
  confused when looking at the specific enthalpy at each port which might be confusing
  when not using a splitting/joining component. The reason for the confusion is that one exmanins the mixing
  enthalpy of the infinitesimal control volume introduced with the connect statement when
  looking at the specific enthalpy in the connector which
  might not be equal to the specific enthalpy at the port in the \"real world\".</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics));
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
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Ellipse(
            extent={{-9,10},{11,-10}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics));
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
     record LossFactorData
        "Data structure defining constant loss factor data for dp = zeta*rho*v*|v|/2 and functions providing the data for some loss types"

            extends Modelica.Icons.Record;

      SI.Diameter diameter_a "Diameter at port_a" annotation(Dialog);
      SI.Diameter diameter_b "Diameter at port_b" annotation(Dialog);
      Real zeta1 "Loss factor for flow port_a -> port_b" annotation(Dialog);
      Real zeta2 "Loss factor for flow port_b -> port_a" annotation(Dialog);
      SI.ReynoldsNumber Re_turbulent
          "Loss factors suited for Re >= Re_turbulent"                            annotation(Dialog);
      SI.Diameter D_Re "Diameter used to compute Re" annotation(Dialog);
      Boolean zeta1_at_a = true
          "dp = zeta1*(if zeta1_at_a then rho_a*v_a^2/2 else rho_b*v_b^2/2)"
                                                                        annotation(Dialog);
      Boolean zeta2_at_a = false
          "dp = -zeta2*(if zeta2_at_a then rho_a*v_a^2/2 else rho_b*v_b^2/2)"
                                                                         annotation(Dialog);
      Boolean zetaLaminarKnown = false
          "= true, if zeta = c0/Re in laminar region"                              annotation(Dialog);
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
                extent={{-100,-100},{100,100}},
                grid={1,1}), graphics={Rectangle(
                  extent={{-100,50},{100,-50}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
                                   Diagram(coordinateSystem(
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
  laminar flow (Idelchick 1994, diagram 2-1, p. 110):
     zeta = 64*(L/D)/Re
</pre>
<p>
where
</p>
<ul>
<li> D is the inner pipe diameter</li>
<li> L is the lenght of the pipe</li>
<li> &Delta; = &delta;/D is the relative roughness where &delta; is
     the absolute \"roughness\", i.e., the averaged height of asperities in the pipe.
     (&delta; may change over time due to growth of surface asperities during
      service, see [Idelchick 1994, p. 85, Tables 2-1, 2-2]).</li>
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
be estimated. In <i>[Idelchik 1994, pp. 105-109,
Table 2-5; Miller 1990, p. 190, Table 8-1]</i> many examples are given.
As a short summary:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Smooth pipes</b></td>
      <td>Drawn brass, coper, aluminium, glass, etc.</td>
      <td><font face=\"Symbol\">d</font> = 0.0025 mm</td>
  </tr>
  <tr><td rowspan=\"3\"><b>Steel pipes</b></td>
      <td>New smooth pipes</td>
      <td><font face=\"Symbol\">d</font> = 0.025 mm</td>
  </tr>
  <tr><td>Mortar lined, average finish</td>
      <td><font face=\"Symbol\">d</font> = 0.1 mm</td>
  </tr>
  <tr><td>Heavy rust</td>
      <td><font face=\"Symbol\">d</font> = 1 mm</td>
  </tr>
  <tr><td rowspan=\"3\"><b>Concrete pipes</b></td>
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
                      -100},{100,100},{0,100},{0,40}}, color={0,0,0})}),
                                   Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                graphics={
                Line(points={{0,40},{-100,40},{-100,-40},{0,-40},{0,-100},{100,
                      -100},{100,100},{0,100},{0,40}}, color={0,0,0}),
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
                      -100},{100,100},{0,100},{0,40}}, color={0,0,0}),
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
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-30,60},{-30,12},{30,50},{30,60},{-30,60}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Backward),
                Polygon(
                  points={{-30,-10},{-30,-60},{30,-60},{30,-50},{-30,-10}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Backward)}),
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={
                Rectangle(
                  extent={{-100,60},{100,-60}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-30,60},{-30,12},{30,50},{30,60},{-30,60}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Backward),
                Polygon(
                  points={{-30,-10},{-30,-60},{30,-60},{30,-50},{-30,-10}},
                  lineColor={0,0,0},
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

      annotation (preferedView="info", Documentation(info="<html>
<p>
This record defines the pressure loss factors of a pipe
segment (orifice, bending etc.) with a minimum amount of data.
If available, data should be provided for <b>both flow directions</b>,
i.e., flow from port_a to port_b and from port_b to port_a,
as well as for the <b>laminar</b> and the <b>turbulent</b> region.
It is also an option to provide the loss factor <b>only</b> for the
<b>turbulent</b> region for a flow from port_a to port_b.
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
<tr><td><b>flow type</b></td>
    <td><b>&zeta;</b> = </td>
    <td><b>flow region</b></td></tr>
<tr><td>turbulent</td>
    <td><b>zeta1</b> = const.</td>
    <td>Re &ge;  Re_turbulent, v &ge; 0</td></tr>
<tr><td></td>
    <td><b>zeta2</b> = const.</td>
    <td>Re &ge; Re_turbulent, v &lt; 0</td></tr>
<tr><td>laminar</td>
    <td><b>c0</b>/Re</td>
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
     laminar flow at small velocities is defined by the often occuring
     approximation c0/Re. If c0 is different for the two
     flow directions, the mean value has to be used
     (c0 = (c0_ab + c0_ba)/2).<li>
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
<li> A is the cross section area with A = &pi;(D/2)^2.
<li> &mu; is the dynamic viscosity.</li>
</ul>
<p>
The laminar and the transition region is usually of
not much technical interest because the operating point is
mostly in the turbulent regime. For simplification and for
numercial reasons, this whole region is described by two
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
regions. The whole characteristic is therefore <b>continuous</b>
and has a <b>finite</b>, <b>continuous first derivative everywhere</b>.
In some cases, the constructed polynomials would \"vibrate\". This is
avoided by reducing the derivative at Re=0 in such a way that
the polynomials are guaranteed to be monotonically increasing.
The used sufficient criteria for monotonicity follows from:
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <b>Monotone piecewise cubic interpolation</b>.
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
            choice=Modelica.Fluid.Fittings.Utilities.QuadraticTurbulent.LossFactorData.wallFriction(),
            choice=Modelica.Fluid.Fittings.Utilities.QuadraticTurbulent.LossFactorData.suddenExpansion(),
            choice=Modelica.Fluid.Fittings.Utilities.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice()));
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

        input SI.Pressure dp "Pressure drop (dp = port_a.p - port_b.p)";
        input SI.Density rho_a "Density at port_a";
        input SI.Density rho_b "Density at port_b";
        input SI.DynamicViscosity mu_a "Dynamic viscosity at port_a";
        input SI.DynamicViscosity mu_b "Dynamic viscosity at port_b";
        input LossFactorData data
          "Constant loss factors for both flow directions" annotation (
            choices(
            choice=BaseClasses.PressureLosses.QuadraticTurbulent.LossFactorData.wallFriction(),
            choice=BaseClasses.PressureLosses.QuadraticTurbulent.LossFactorData.suddenExpansion(),
            choice=BaseClasses.PressureLosses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice()));
        output SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";

      protected
        constant Real pi=Modelica.Constants.pi;
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
regions. The whole characteristic is therefore <b>continuous</b>
and has a <b>finite</b>, <b>continuous first derivative everywhere</b>.
In some cases, the constructed polynomials would \"vibrate\". This is
avoided by reducing the derivative at Re=0 in such a way that
the polynomials are guaranteed to be monotonically increasing.
The used sufficient criteria for monotonicity follows from:
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <b>Monotone piecewise cubic interpolation</b>.
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
            choice=BaseClasses.PressureLosses.QuadraticTurbulent.LossFactorData.wallFriction(),
            choice=BaseClasses.PressureLosses.QuadraticTurbulent.LossFactorData.suddenExpansion(),
            choice=BaseClasses.PressureLosses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice()));
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

        input SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";
        input SI.Density rho_a "Density at port_a";
        input SI.Density rho_b "Density at port_b";
        input SI.DynamicViscosity mu_a "Dynamic viscosity at port_a";
        input SI.DynamicViscosity mu_b "Dynamic viscosity at port_b";
        input LossFactorData data
          "Constant loss factors for both flow directions" annotation (
            choices(
            choice=BaseClasses.PressureLosses.QuadraticTurbulent.LossFactorData.wallFriction(),
            choice=BaseClasses.PressureLosses.QuadraticTurbulent.LossFactorData.suddenExpansion(),
            choice=BaseClasses.PressureLosses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice()));
        output SI.Pressure dp "Pressure drop (dp = port_a.p - port_b.p)";

      protected
        constant Real pi=Modelica.Constants.pi;
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
regions. The whole characteristic is therefore <b>continuous</b>
and has a <b>finite</b>, <b>continuous first derivative everywhere</b>.
In some cases, the constructed polynomials would \"vibrate\". This is
avoided by reducing the derivative at Re=0 in such a way that
the polynomials are guaranteed to be monotonically increasing.
The used sufficient criteria for monotonicity follows from:
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <b>Monotone piecewise cubic interpolation</b>.
     SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246</dd>
</dl>
</html>"));
      end pressureLoss_m_flow_and_Re;

      partial model BaseModel
        "Generic pressure drop component with constant turbulent loss factor data and without an icon"

        extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;
        extends Modelica.Fluid.Interfaces.PartialLumpedFlow(
          final pathLength = 0,
          final momentumDynamics = Types.Dynamics.SteadyState);

        parameter LossFactorData data "Loss factor data";

        // Advanced
        parameter Boolean from_dp = true
          "= true, use m_flow = f(dp) else dp = f(m_flow)"
          annotation (Evaluate=true, Dialog(tab="Advanced"));
        parameter Boolean use_Re = false
          "= true, if turbulent region is defined by Re, otherwise by dp_small or m_flow_small"
          annotation(Evaluate=true, Dialog(tab="Advanced"));
        parameter Medium.AbsolutePressure dp_small = system.dp_small
          "Turbulent flow if |dp| >= dp_small"
          annotation(Dialog(tab="Advanced", enable=not use_Re and from_dp));
        parameter Medium.MassFlowRate m_flow_small = system.m_flow_small
          "Turbulent flow if |m_flow| >= m_flow_small"
          annotation(Dialog(tab = "Advanced", enable=not from_dp));

        // Diagnostics
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
                   pressureLoss_m_flow(m_flow, Medium.density(state_a), Medium.density(state_b), data, m_flow_small);
        end if;

        // Isenthalpic state transformation (no storage and no loss of energy)
        port_a.h_outflow = inStream(port_b.h_outflow);
        port_b.h_outflow = inStream(port_a.h_outflow);

        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}),
               graphics),
          Documentation(info="<html>
<p>
This model computes the pressure loss of a pipe
segment (orifice, bending etc.) with a minimum amount of data
provided via parameter <b>data</b>.
If available, data should be provided for <b>both flow directions</b>,
i.e., flow from port_a to port_b and from port_b to port_a,
as well as for the <b>laminar</b> and the <b>turbulent</b> region.
It is also an option to provide the loss factor <b>only</b> for the
<b>turbulent</b> region for a flow from port_a to port_b.
</p>
<p>
The following equations are used:
</p>
<pre>   &Delta;p = 0.5*&zeta;*&rho;*v*|v|
      = 0.5*&zeta;/A^2 * (1/&rho;) * m_flow*|m_flow|
        Re = |v|*D*&rho;/&mu;
</pre>
<table border=1 cellspacing=0 cellpadding=2>
<tr><td><b>flow type</b></td>
    <td><b>&zeta;</b> = </td>
    <td><b>flow region</b></td></tr>
<tr><td>turbulent</td>
    <td><b>zeta1</b> = const.</td>
    <td>Re &ge;  Re_turbulent, v &ge; 0</td></tr>
<tr><td></td>
    <td><b>zeta2</b> = const.</td>
    <td>Re &ge; Re_turbulent, v &lt; 0</td></tr>
<tr><td>laminar</td>
    <td><b>c0</b>/Re</td>
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
     laminar flow at small velocities is defined by the often occuring
     approximation c0/Re. If c0 is different for the two
     flow directions, the mean value has to be used
     (c0 = (c0_ab + c0_ba)/2).<li>
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
<li> A is the cross section area with A = &pi;(D/2)^2.
<li> &mu; is the dynamic viscosity.</li>
</ul>
<p>
The laminar and the transition region is usually of
not much technical interest because the operating point is
mostly in the turbulent regime. For simplification and for
numercial reasons, this whole region is described by two
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
regions. The whole characteristic is therefore <b>continuous</b>
and has a <b>finite</b>, <b>continuous first derivative everywhere</b>.
In some cases, the constructed polynomials would \"vibrate\". This is
avoided by reducing the derivative at Re=0 in such a way that
the polynomials are guaranteed to be monotonically increasing.
The used sufficient criteria for monotonicity follows from:
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <b>Monotone piecewise cubic interpolation</b>.
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
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}),
                graphics),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                  100,100}}), graphics={
              Text(
                extent={{-150,80},{150,120}},
                lineColor={0,0,0},
                textString="%name"),
              Rectangle(
                extent={{-100,60},{100,-60}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={192,192,192}),
              Rectangle(
                extent={{-100,34},{100,-36}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={0,127,255}),
              Text(
                extent={{-134,-66},{130,-92}},
                lineColor={0,0,0},
                textString="quad. turbulent")}),
          Documentation(info="<html>

</html>"));
    end TestWallFriction;

      partial model BaseModelNonconstantCrossSectionArea
        "Generic pressure drop component with constant turbulent loss factor data and without an icon, for non-constant cross section area"

        extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;
        extends Modelica.Fluid.Interfaces.PartialLumpedFlow(
          final pathLength = 0,
          final momentumDynamics = Types.Dynamics.SteadyState);

        parameter LossFactorData data "Loss factor data";

        // Advanced
        /// Other settings than the final values are not yet implemented ///
        final parameter Boolean from_dp = false
          "= true, use m_flow = f(dp) else dp = f(m_flow)"
          annotation (Evaluate=true, Dialog(tab="Advanced"));
        final parameter Boolean use_Re = false
          "= true, if turbulent region is defined by Re, otherwise by dp_small or m_flow_small"
          annotation(Evaluate=true, Dialog(tab="Advanced"));
        // End not yet implemented /////////////////////////////////////////
        parameter Medium.AbsolutePressure dp_small = system.dp_small
          "Turbulent flow if |dp| >= dp_small"
          annotation(Dialog(tab="Advanced", enable=not use_Re and from_dp));
        parameter Medium.MassFlowRate m_flow_small = system.m_flow_small
          "Turbulent flow if |m_flow| >= m_flow_small"
          annotation(Dialog(tab = "Advanced", enable=not from_dp));

        // Diagnostics
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
        // This will remove the extra interation variables
        state_b_des = Medium.setState_phX(port_b.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow));
        state_a_nondes = Medium.setState_phX(port_a.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow));

        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                  graphics),
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}),
               graphics),
          Documentation(info="<html>
<p>
This model computes the pressure loss of a pipe
segment (orifice, bending etc.) with a minimum amount of data
provided via parameter <b>data</b>.
If available, data should be provided for <b>both flow directions</b>,
i.e., flow from port_a to port_b and from port_b to port_a,
as well as for the <b>laminar</b> and the <b>turbulent</b> region.
It is also an option to provide the loss factor <b>only</b> for the
<b>turbulent</b> region for a flow from port_a to port_b.
</p>
<p>
The following equations are used:
</p>
<pre>   &Delta;p = 0.5*&zeta;*&rho;*v*|v|
      = 0.5*&zeta;/A^2 * (1/&rho;) * m_flow*|m_flow|
        Re = |v|*D*&rho;/&mu;
</pre>
<table border=1 cellspacing=0 cellpadding=2>
<tr><td><b>flow type</b></td>
    <td><b>&zeta;</b> = </td>
    <td><b>flow region</b></td></tr>
<tr><td>turbulent</td>
    <td><b>zeta1</b> = const.</td>
    <td>Re &ge;  Re_turbulent, v &ge; 0</td></tr>
<tr><td></td>
    <td><b>zeta2</b> = const.</td>
    <td>Re &ge; Re_turbulent, v &lt; 0</td></tr>
<tr><td>laminar</td>
    <td><b>c0</b>/Re</td>
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
     laminar flow at small velocities is defined by the often occuring
     approximation c0/Re. If c0 is different for the two
     flow directions, the mean value has to be used
     (c0 = (c0_ab + c0_ba)/2).<li>
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
<li> A is the cross section area with A = &pi;(D/2)^2.
<li> &mu; is the dynamic viscosity.</li>
</ul>
<p>
The laminar and the transition region is usually of
not much technical interest because the operating point is
mostly in the turbulent regime. For simplification and for
numercial reasons, this whole region is described by two
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
regions. The whole characteristic is therefore <b>continuous</b>
and has a <b>finite</b>, <b>continuous first derivative everywhere</b>.
In some cases, the constructed polynomials would \"vibrate\". This is
avoided by reducing the derivative at Re=0 in such a way that
the polynomials are guaranteed to be monotonically increasing.
The used sufficient criteria for monotonicity follows from:
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <b>Monotone piecewise cubic interpolation</b>.
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
            choice=BaseClasses.PressureLosses.QuadraticTurbulent.LossFactorData.wallFriction(),
            choice=BaseClasses.PressureLosses.QuadraticTurbulent.LossFactorData.suddenExpansion(),
            choice=BaseClasses.PressureLosses.QuadraticTurbulent.LossFactorData.sharpEdgedOrifice()));
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
If available, data can be provided for <b>both flow directions</b>,
i.e., flow from port_a to port_b and from port_b to port_a,
as well as for the <b>laminar</b> and the <b>turbulent</b> region.
It is also an option to provide the loss factor <b>only</b> for the
<b>turbulent</b> region for a flow from port_a to port_b.
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
     \"zeta2\" depending on the flow direction.<li>
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
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));
      Modelica.Fluid.Interfaces.FluidPort_b port_2(redeclare package Medium =
            Medium, m_flow(min=if (portFlowDirection_2 == PortFlowDirection.Entering) then
                    0.0 else -Modelica.Constants.inf, max=if (portFlowDirection_2
               == PortFlowDirection.Leaving) then 0.0 else Modelica.Constants.inf))
        annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=
               0)));
      Modelica.Fluid.Interfaces.FluidPort_a port_3(
        redeclare package Medium=Medium,
        m_flow(min=if (portFlowDirection_3==PortFlowDirection.Entering) then 0.0 else -Modelica.Constants.inf,
        max=if (portFlowDirection_3==PortFlowDirection.Leaving) then 0.0 else Modelica.Constants.inf))
        annotation (Placement(transformation(extent={{-10,90},{10,110}}, rotation=
               0)));

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
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Rectangle(
              extent={{-100,44},{100,-44}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,127,255}),
            Text(
              extent={{-150,-89},{150,-129}},
              lineColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-44,100},{44,44}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={0,127,255}),
            Rectangle(
              extent={{-22,82},{21,-4}},
              fillPattern=FillPattern.Solid,
              fillColor={0,128,255},
              pattern=LinePattern.None,
              lineColor={0,0,0})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics));
    end PartialTeeJunction;

    partial model PartialPressureLoss
      "Base flow model for pressure loss functions"
      import SI = Modelica.SIunits;

      //interfaces
      extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;

      //fluid properties
      parameter Boolean use_nominal=false
        "= true, if eta_nominal and rho_nominal are used, otherwise computed from medium"
        annotation (Evaluate=true, Dialog(group="Fluid properties"));
      parameter SI.DynamicViscosity eta_nominal=Medium.dynamicViscosity(
          Medium.setState_pTX(
          Medium.p_default,
          Medium.T_default,
          Medium.X_default))
        "Nominal dynamic viscosity (e.g., eta_liquidWater = 1e-3, eta_air = 1.8e-5)"
        annotation (Dialog(enable=use_nominal, group="Fluid properties"));
      parameter SI.Density rho_nominal=Medium.density_pTX(
          Medium.p_default,
          Medium.T_default,
          Medium.X_default)
        "Nominal density (e.g., d_liquidWater = 995, d_air = 1.2)"
        annotation (Dialog(enable=use_nominal, group="Fluid properties"));

    /*
  Medium.ThermodynamicState state
    "Upstream medium state for computation of pressure loss characteristics (smoothed around zero flow with state_a and state_b)";
  SI.Density rho
    "Upstream density (smoothed around zero flow with state_a and state_b)";
  SI.DynamicViscosity eta
    "Upstream dynamic viscosity (smoothed around zero flow with state_a and state_b)";
*/
    equation
      //isenthalpic state transformation (no storage and no loss of energy)
      port_a.h_outflow = inStream(port_b.h_outflow);
      port_b.h_outflow = inStream(port_a.h_outflow);

      // Upstream properties for pressure loss characteristic calculation

    /*
  if allowFlowReversal then
    if from_dp then
      state = Medium.setSmoothState(
        dp,
        state_a,
        state_b,
        dp_small);
    else
      state = Medium.setSmoothState(
        m_flow,
        state_a,
        state_b,
        m_flow_small);
    end if;
  else
    state = state_a;
  end if;

  if use_nominal then
     rho = rho_nominal;
     eta = eta_nominal;
  else
     rho = Medium.density(state);
     eta = Medium.dynamicViscosity(state);
  end if;
*/

      annotation (Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics));
    end PartialPressureLoss;

  end BaseClasses;
  annotation (Documentation(info="<html>

</html>"),    Documentation(info="<html>
<p>
This sublibrary contains models and functions providing pressure
loss correlations. All models in this library have the property
that no mass and no energy is stored in the component. Therefore,
none of the models has a state. The basic correlations are implemented
with functions of sublibrary
<a href=\"modelica://Modelica.Fluid.PressureLosses.Utilities\">PressureLosses.Utilities</a>
These functions might also be directly called
(e.g., in another component implementation).
</p>

<p>
All functions are continuous and have a finite, non-zero, smooth, first derivative.
The functions are all guaranteed to be strict monontonically increasing.
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
<dd> <b>Monotone piecewise cubic interpolation</b>.
     SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246</dd>
</dl>

</html>", revisions="<html>
<ul>
<li><i>Jan. 3, 2006</i>
    by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
    New design and implementation based on previous iterations.</li>
</ul>
</html>"));
end Fittings;
