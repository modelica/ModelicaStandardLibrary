within Modelica.Fluid;
package Dissipation
  "Functions for convective heat transfer and pressure loss characteristics"
    extends Modelica.Icons.Package;
  import PI = Modelica.Constants.pi;
  import REC = Modelica.Fluid.Dissipation.Utilities.Records;
  import SI = Modelica.SIunits;
  import TYP = Modelica.Fluid.Dissipation.Utilities.Types;

  package UsersGuide "User's guide"
    extends Modelica.Icons.Information;
    class GettingStarted "Getting Started"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
The <b> Fluid.Dissipation </b> library provides convective heat transfer and pressure loss
(HTPL) correlations for a broad range of energy devices to build up thermohydraulic
energy systems.
</p>
<p>
This section introduces an implementation method for the integration of the provided HTPL
functions by Fluid.Dissipation into own application models. Additionally you can find
ready-to-use application models integrated into Modelica.Fluid as thermohydraulic
framework <a href=\"modelica://Fluid.Dissipation.Examples.Applications.PressureLoss\"> (see
application examples)</a>.<br />
In the following the implementation method is described in 5 steps for a straight pipe as
example. Generally the implementation method can be used for all HTPL correlations
throughout the library in the same manner.
</p>

<h4><font color=\"#EF9B13\">Step 1: Use/Create model with missing pressure loss correlation
</font></h4>
<p>
All thermohydraulic systems using pressure loss calculations can be modelled for an <b>
incompressible case </b>, where the pressure loss (DP) is calculated in dependence of a
known mass flow rate (m_flow)

<pre>
   DP = f(m_flow,...)
</pre>

or a <b> compressible case </b> , where the mass flow rate (M_FLOW) is calculated in
dependence of a known pressure loss (dp)

<pre>
   M_FLOW = f(dp,...).
</pre>
<p>
In both cases one target variable (DP for the compressible or M_FLOW for the
incompressible case) is calculated as a function of the corresponding input variable
(m_flow or dp respectively). Both functions for these cases can be found in the library
for the pressure loss device of interest enlarged with a corresponding underscore
describing its intended use (functionname_MFLOW for compressible or functionname_DP for
incompressible calculation).
</p>
To create a simplified thermohydraulic model, the pressure loss (dp) and the mass flow
rate (M_FLOW) have to be defined as unknown variables and only a functional correlation
between them is still missing. Here the implementation for the compressible case of a
flow model will be explained as example.
<pre>
   model straightPipe
    //compressible case M_FLOW = f(dp)
     Modelica.SIunits.Pressure dp \"Input pressure loss\";
     Modelica.SIunits.MassFlowRate M_FLOW \"Output mass flow rate\";
   end straightPipe

   equation
  end straightPipe
</pre>
</p>

<h4><font color=\"#EF9B13\">Step 2: Choose pressure loss <b> function </b> of interest
</font></h4>
<p>
The HTPL correlations are modelled with functions for several devices. The pressure loss
of a straight pipe to be modelled can be found by browsing through the <b>
Fluid.Dissipation </b> library and looking up the function of interest, here:
<pre>
   Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW
</pre>
This HTPL correlation for the compressible case of a straight pipe have to be dragged and
dropped in the equation section of the <b> equation layer </b> of the model in Step 1.
<pre>
   model straightPipe
    //compressible case M_FLOW = f(dp)
     Modelica.SIunits.Pressure dp \"Input pressure loss\";
     Modelica.SIunits.MassFlowRate M_FLOW \"Output mass flow rate\";

    equation
    Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_<b>MFLOW</b>
   end straightPipe
</pre>

<h4><font color=\"#EF9B13\">Step 3: Choose corresponding pressure loss <b> records </b>
</font></h4>
The chosen function in Step 2 still needs its corresponding input values provided by
records. These input records are spitted into one for input parameters (e.g., for
geometry) and one for input variables (e.g., for fluid properties). The name of these
input records are identical with the corresponding function but with the extension <b>
_IN_con </b> for parameters and <b> _IN_var </b> for variables as input. These
corresponding input record for the chosen function have to be dragged and dropped on the
<b> diagram layer </b> of the model in Step 1.
<pre>
  Input parameter record:
Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall<b>_IN_con</b> IN_con
  Input variable record:
Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall<b>_IN_var</b> IN_var
</pre>

Now the equation layer of the model in Step 1 should look similar to the following
(without comments and annotation):
<pre>
  model straightPipe
   ...
   //records
   Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con <b>IN_con</b>;
   Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var <b>IN_var</b>;

   equation
   Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW
  end straightPipe
</pre>

<h4><font color=\"#EF9B13\">Step 4: Build function-record construction</font> </h4>
Now the input record have to be assigned to the chosen function in the equation layer.
The resulting function-record implementation for the compressible case looks like the
following:
<pre>
model straightPipe
   ...
  equation
  //compressible case
  M_FLOW = Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW(IN_con,IN_var,dp);
end straightPipe
</pre>

Here the compressible case for the unknown mass flow rate (M_FLOW) is calculated by the
known pressure difference (dp) out of the interfaces of the thermohydraulic framework and
the input records (IN_con,IN_var) provide data like geometry and fluid properties for
example.

<h4><font color=\"#EF9B13\">Step 5: Assign record variables </font></h4>
In the last step the variables of the input records for the function have to be assigned.
The assignment of the record variables can either be done directly in the record on the
diagram layer or in the equation layer.
The assignment of the input record in the equation layer results into the following
model:
<pre>
model straightPipe
 ...
//compressible fluid flow
  //input record

Fluid.Dissipation.Examples.Applications.PressureLoss.BaseClasses.StraightPipe.Overall.Pres
sureLossInput_con
    IN_con(
    d_hyd=d_hyd,
    L=L,
    roughness=roughness,
    K=K);

Fluid.Dissipation.Examples.Applications.PressureLoss.BaseClasses.StraightPipe.Overall.Pres
sureLossInput_var
    IN_var(
    eta=eta,
    rho=rho);
 ...
end straight Pipe;
</pre>
<p>
If the implementation of a HTPL correlation is done in an existing application model, the
unknown variables out of Step 1 (M_FLOW and dp for compressible or DP and m_flow for
incompressible case) have to be adjusted to the model variables (typically the interface
variables). The implementation of HTPL correlation into <b> Modelica.Fluid </b> can be
found for <a href=\"modelica://Fluid.Dissipation.Examples.TestCases.PressureLoss\"> flow
models of several devices</a>.
</p>
 </html>"));
    end GettingStarted;

    class ReleaseNotes "Release notes"
      extends Modelica.Icons.ReleaseNotes;

      annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Version 1.0 Beta 4-6, 2010-01-12</font></h4>

<p>
Fluid.Dissipation was improved for the release as follows:
</p>

<ul>
<li> Changed structure for input records of all heat transfer and pressure loss
functions:
<ul>
        <li> Reduced amount of input records for compressible and incompressible
functions as well as for their combinational one to improve usability of library.
        </li>
        <li> Splitting input records of one function into one with parameters (e.g., for
geometry) and one with variables (e.g., fluid properties) to ease work of IDE-solver.
        </li>
</ul>
<li>
</li>
<li> Improved Modelica.Fluid application models for available heat transfer and pressure
loss functions:
<ul>
        <li> Flattened inheritance with one base flow model for all energy devices.
        </li>
        <li> Implemented smooth state of fluid density and dynamic viscosity for reverse
flow.
        </li>
</ul>
</li>
<li> Adaption of complete library due to structure change.
</ul>

<h4><font color=\"#008000\">Version 1.0 Beta 3, 2009-07-03</font></h4>

<p>
Fluid.Dissipation was improved for the release as follows:
</p>

<ul>
<li> Changed flow models structure: <br>
Now that a future feature for the automatic choice of using either a mass flow rate
(compressible case) or a pressure loss (incompressible case) function for calculation is
supported if implemented by IDE. Due to that no manual selection of a compressible or
incompressible calculation in the Modelica.Fluid flow models is possible anymore.
Therefore nonlinear equations will be created from the Modelica.Fluid flow models, if the
future feature is not supported and the mass flow rate is known at a fluid port instead
of the pressure loss.
</li>
<li> Changed structure and amount of records used as input for function calls due to
changed structure of flow model.
</li>
<li> Changed structure of function calls due to changed structure of flow model.
</li>
<li> Finished validation of all available heat transfer and pressure loss functions.
</li>
<li> Included scripts for verification of all available heat transfer and pressure loss
functions.
</li>
</ul>

<h4><font color=\"#008000\">Version 1.0 Beta 2, 2009-04-22</font></h4>

<p>
Fluid.Dissipation was improved for the release as follows:
</p>

<ul>
<li> Support of analytical Jacobians at inverse calculation of heat transfer and pressure
loss functions.
</li>
<li> Included Modelica.Fluid application models for available heat transfer and pressure
loss functions.
</li>
<li> Adaption of complete library to Modelica Standard nomenclature.
</ul>

<h4><font color=\"#008000\">Version 1.0 Beta 1, 2008-10-08</font></h4>

Initial release of Fluid.Dissipation.

</html>"));
    end ReleaseNotes;
    annotation (__Dymola_DocumentationClass=true);
  end UsersGuide;

  package HeatTransfer "Package for calculation of heat transfer"
  extends Modelica.Icons.VariantsPackage;
    package Channel
    extends Modelica.Icons.VariantsPackage;

      function kc_evenGapLaminar
        "Mean heat transfer coefficient of even gap | laminar flow regime | considering boundary layer development | heat transfer at ONE or BOTH sides | identical and constant wall temperatures"

        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 6-10

        //icon
        extends Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.Gap1_d;

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_con
          IN_con "Input record for function kc_evenGapLaminar"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_var
          IN_var "Input record for function kc_evenGapLaminar"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results"
          annotation (Dialog(group="Output"));

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap;

        Real MIN=Modelica.Constants.eps;

        Real laminar=2200 "Maximum Reynolds number of laminar flow regime";

        SI.Area A_cross=IN_con.s*IN_con.h "Cross sectional area of gap";
        SI.Diameter d_hyd=2*IN_con.s "Hydraulic diameter";

        Real prandtlMax=if IN_con.target == TYP.UndevOne then 10 else if IN_con.target
             == TYP.UndevBoth then 1000 else 0 "Maximum Prandtl number";
        Real prandtlMin=if IN_con.target == TYP.UndevOne or IN_con.target == TYP.UndevBoth then
                  0.1 else 0 "Minimum Prandtl number";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity in gap";

        //failure status
        Real fstatus[2] "Check of expected boundary conditions";

        //Documentation
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
        Re := max(1, abs(IN_var.rho*velocity*d_hyd/max(MIN, IN_var.eta)));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC(IN_con,
          IN_var);
        Nu := kc*d_hyd/max(MIN, IN_var.lambda);

        //failure status
        fstatus[1] := if Re > laminar then 1 else 0;
        fstatus[2] := if IN_con.target == TYP.UndevOne or IN_con.target == TYP.UndevBoth then
                if Pr > prandtlMax or Pr < prandtlMin then 1 else 0 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for a laminar fluid flow through an even gap at different fluid flow and heat transfer situations.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> laminar regime (Reynolds number &le; 2200)
<li> developed fluid flow</li>
   <ul>
   <li> heat transfer from one side of the gap (target=1)
   <li> heat transfer from both sides of the gap (target=2)
   </ul>
<li> undeveloped fluid flow
   <ul>
   <li> heat transfer from one side of the gap (target=3)
       <ul>
       <li> Prandtl number 0.1 &le; Pr &le; 10 </li>
       </ul>
   <li> heat transfer from both sides of the gap (target=4)
   <ul>
       <li> Prandtl number 0.1 &le; Pr &le; 1000
       </ul>
   </ul>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/pic_gap.png\">


<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc</b> for an even gap is calculated through the corresponding Nusselt number <b> Nu_lam</b> according to <i>[VDI 2002, p. Gb 7, eq. 43]</i> :

<pre>
    Nu_lam = [(Nu_1)^3 + (Nu_2)^3 + (Nu_3)^3]^(1/3)
</pre>

<p>
with the corresponding mean convective heat transfer coefficient <b> kc </b> :
</p>

<p>
<pre>
    kc =  Nu_lam * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> cp                      </b></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><b> d_hyd = 2*s             </b></td><td> as hydraulic diameter of gap [m],</td></tr>
<tr><td><b> eta                     </b></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><b> h                       </b></td><td> as height of cross sectional area in gap [m],</td></tr>
<tr><td><b> kc                      </b></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><b> lambda                  </b></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><b> L                       </b></td><td> as overflowed length of gap (normal to cross sectional area) [m] ,</td></tr>
<tr><td><b> Nu_lam                  </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda      </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> rho                     </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> s                       </b></td><td> as distance between parallel plates of cross sectional area [m],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta    </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> v                       </b></td><td> as mean velocity in gap [m/s].</td></tr>
</table>
</p>

The summands for the mean Nusselt number <b> Nu_lam </b> at a chosen fluid flow and heat transfer situation are calculated as follows:
<ul>
<li> developed fluid flow
   <ul>
   <li> heat transfer from one side of the gap (target=1)
        <ul>
            <li> Nu_1 = 4.861
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3)
            <li> Nu_3 = 0
        </ul>
   <li> heat transfer from both sides of the gap (target=2)
        <ul>
            <li> Nu_1 = 7.541
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3)
            <li> Nu_3 = 0
        </ul>
   </ul>
<li> undeveloped fluid flow
   <ul>
   <li> heat transfer from one side of the gap (target=3)
        <ul>
            <li> Nu_1 = 4.861
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3)
            <li> Nu_3 = [2/(1+22*Pr)]^(1/6)*(Re*Pr*d_hyd/L)^(1/2)
        </ul>
   <li> heat transfer from both sides of the gap (target=4)
        <ul>
            <li> Nu_1 = 7.541
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3)
            <li> Nu_3 = [2/(1+22*Pr)]^(1/6)*(Re*Pr*d_hyd/L)^(1/2)
        </ul>
   </ul>
</ul>

<p>
Note that the fluid properties shall be calculated with an arithmetic mean temperature out of the fluid flow temperatures at the entrance and the exit of the gap.
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu_lam </b> representing the mean convective heat transfer coefficient <b> kc </b> in dependence of
the chosen fluid flow and heat transfer situations (targets) is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/fig_channel_kc_evenGapLaminar.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Bejan,A.:</dt>
    <dd><b>Heat transfer handbook</b>.
    Wiley, 2003.</dd>
<dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_evenGapLaminar;

      function kc_evenGapLaminar_KC
        "Mean heat transfer coefficient of even gap | laminar flow regime | considering boundary layer development | heat transfer at ONE or BOTH sides | identical and constant wall temperatures"

        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 6-10

        //icon
        extends Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.Gap1_d;

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_con
          IN_con "Input record for function kc_evenGapLaminar_KC"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_var
          IN_var "Input record for function kc_evenGapLaminar_KC"
          annotation (Dialog(group="Variable inputs"));
        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Output for function kc_evenGapLaminar_KC";

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap;

        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=max(MIN, IN_con.s*IN_con.h)
          "Cross sectional area of gap";
        SI.Diameter d_hyd=2*IN_con.s "Hydraulic diameter";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity in gap";
        SI.ReynoldsNumber Re=max(1, IN_var.rho*velocity*d_hyd/max(MIN, IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        //variables for mean Nusselt number
        //SOURCE: p.Gb 7, eq. 36/37
        SI.NusseltNumber Nu_1=if IN_con.target == TYP.DevOne or IN_con.target == TYP.UndevOne then
                  4.861 else if IN_con.target == TYP.DevBoth or IN_con.target == TYP.UndevBoth then
                  7.541 else 0 "First Nusselt number";
        //SOURCE: p.Gb 7, eq. 38
        SI.NusseltNumber Nu_2=1.841*(Re*Pr*d_hyd/(max(IN_con.L, MIN)))^(1/3)
          "Second Nusselt number";
        //SOURCE: p.Gb 7, eq. 42
        SI.NusseltNumber Nu_3=if IN_con.target == TYP.UndevOne or IN_con.target ==
            TYP.UndevBoth then (2/(1 + 22*Pr))^(1/6)*(Re*Pr*d_hyd/(max(IN_con.L, MIN)))
            ^(0.5) else 0 "Third mean Nusselt number";
        SI.NusseltNumber Nu=((Nu_1)^3 + (Nu_2)^3 + (Nu_3)^3)^(1/3);

        //Documentation
      algorithm
        kc := Nu*((IN_var.lambda/max(MIN, d_hyd)));
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for a laminar fluid flow through an even gap at different fluid flow and heat transfer situations.
</p>

<p>
Generally this  function is numerically best used for the calculation of the mean convective heat transfer coefficient <b> kc </b> at known mass flow rate.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> laminar regime (Reynolds number &le; 2200) </li>
<li> developed fluid flow</li>
   <ul>
   <li> heat transfer from one side of the gap (target=1) <(li>
   <li> heat transfer from both sides of the gap (target=2) <(li>
   </ul>
<li> undeveloped fluid flow</li>
   <ul>
   <li> heat transfer from one side of the gap (target=3) <(li>
       <ul>
       <li> Prandtl number 0.1 &le; Pr &le; 10 </li>
       </ul>
   <li> heat transfer from both sides of the gap (target=4) <(li>
   <ul>
       <li> Prandtl number 0.1 &le; Pr &le; 1000 </li>
       </ul>
   </ul>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/pic_gap.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc</b> for an even gap is calculated through the corresponding Nusselt number <b> Nu_lam</b> according to <i>[VDI 2002, p. Gb 7, eq. 43]</i> :

<pre>
    Nu_lam = [(Nu_1)^3 + (Nu_2)^3 + (Nu_3)^3]^(1/3)
</pre>

<p>
with the corresponding mean convective heat transfer coefficient <b> kc </b> :
</p>

<p>
<pre>
    kc =  Nu_lam * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> cp                      </b></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><b> d_hyd = 2*s             </b></td><td> as hydraulic diameter of gap [m],</td></tr>
<tr><td><b> eta                     </b></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><b> h                       </b></td><td> as height of cross sectional area in gap [m],</td></tr>
<tr><td><b> kc                      </b></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><b> lambda                  </b></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><b> L                       </b></td><td> as overflowed length of gap (normal to cross sectional area) [m] ,</td></tr>
<tr><td><b> Nu_lam                  </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda      </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> rho                     </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> s                       </b></td><td> as distance between parallel plates of cross sectional area [m],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta    </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> v                       </b></td><td> as mean velocity in gap [m/s].</td></tr>
</table>
</p>

The summands for the mean Nusselt number <b> Nu_lam </b> at a chosen fluid flow and heat transfer situation are calculated as follows:
<ul>
<li> developed fluid flow</li>
   <ul>
   <li> heat transfer from one side of the gap (target=1) <(li>
        <ul>
            <li> Nu_1 = 4.861 </li>
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3) </li>
            <li> Nu_3 = 0 </li>
        </ul>
   <li> heat transfer from both sides of the gap (target=2) <(li>
        <ul>
            <li> Nu_1 = 7.541 </li>
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3) </li>
            <li> Nu_3 = 0 </li>
        </ul>
   </ul>
<li> undeveloped fluid flow</li>
   <ul>
   <li> heat transfer from one side of the gap (target=3) <(li>
        <ul>
            <li> Nu_1 = 4.861 </li>
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3) </li>
            <li> Nu_3 = [2/(1+22*Pr)]^(1/6)*(Re*Pr*d_hyd/L)^(1/2) </li>
        </ul>
   <li> heat transfer from both sides of the gap (target=4) <(li>
        <ul>
            <li> Nu_1 = 7.541 </li>
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3) </li>
            <li> Nu_3 = [2/(1+22*Pr)]^(1/6)*(Re*Pr*d_hyd/L)^(1/2) </li>
        </ul>
   </ul>
</ul>
<p>
Note that the fluid flow properties shall be calculated with an arithmetic mean temperature out of the fluid flow temperatures at the entrance and the exit of the gap.
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu_lam </b> representing the mean convective heat transfer coefficient <b> kc </b> in dependence of
the chosen fluid flow and heat transfer situations (targets) is shown in the figure below.
Here the figures are calculated for an (unintended) inverse calculation, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <b> kc </b>.
</p>

<ul>
   <li> Target 1: Developed fluid flow and heat transfer from one side of the gap </li>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/fig_channel_kc_evenGapLaminar_target1_KC.png\">
</ul>

<ul>
   <li> Target 2: Developed fluid flow and heat transfer from both sides of the gap </li>
<p>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/fig_channel_kc_evenGapLaminar_target2_KC.png\">
</p>
</ul>

<ul>
  <li> Target 3: Undeveloped fluid flow and heat transfer from one side of the gap </li>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/fig_channel_kc_evenGapLaminar_target3_KC.png\">
</ul>

<ul>
 <li> Target 4: Undeveloped fluid flow and heat transfer from both sides of the gap </li>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/fig_channel_kc_evenGapLaminar_target4_KC.png\">
</ul>

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar\">kc_evenGapLaminar</a> is also valid for this inverse calculation due to using the same functions.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Bejan,A.:</dt>
    <dd><b>Heat transfer handbook</b>.
    Wiley, 2003.</dd>
<dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_evenGapLaminar_KC;

      record kc_evenGapLaminar_IN_con
        "Input record for function kc_evenGapLaminar and kc_evenGapLaminar_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar\"> kc_evenGapLaminar </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC\"> kc_evenGapLaminar_KC </a>.
</html>"));
      end kc_evenGapLaminar_IN_con;

      record kc_evenGapLaminar_IN_var
        "Input record for function kc_evenGapLaminar and kc_evenGapLaminar_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar\"> kc_evenGapLaminar </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC\"> kc_evenGapLaminar_KC </a>.
</html>"));
      end kc_evenGapLaminar_IN_var;

      function kc_evenGapOverall
        "Mean heat transfer coefficient of even gap | overall flow regime | considering boundary layer development | heat transfer at ONE or BOTH sides | identical and constant wall temperatures | surface roughness"

        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 6-10

        //icon
        extends Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.Gap1_d;

        import SI = Modelica.SIunits;
        import MIN = Modelica.Constants.eps;
        // import SMOOTH = Modelica.Fluid.Dissipation.Utilities.Functions.Stepsmoother;

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con
          IN_con "Input record for function kc_evenGapOverall"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var
          IN_var "Input record for function kc_evenGapOverall"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results"
          annotation (Dialog(group="Output"));

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap;

        Real MIN=Modelica.Constants.eps;

        Real laminar=2200 "Maximum Reynolds number for laminar regime";
        Real turbulent=1e4 "Minimum Reynolds number for turbulent regime";

        SI.Area A_cross=IN_con.s*IN_con.h "Cross sectional area of gap";
        SI.Diameter d_hyd=2*IN_con.s "Hydraulic diameter";

        Real prandtlMax=if IN_con.target == TYP.UndevOne then 10 else if IN_con.target
             == TYP.UndevBoth then 1000 else 0 "Maximum Prandtl number";
        Real prandtlMin=if IN_con.target == TYP.UndevOne or IN_con.target == TYP.UndevBoth then
                  0.1 else 0 "Minimum Prandtl number";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity in gap";

        //failure status
        Real fstatus[2] "Check of expected boundary conditions";

        //Documentation
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
        Re := max(1e-3, abs(IN_var.rho*velocity*d_hyd/max(MIN, IN_var.eta)));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_KC(IN_con, IN_var);
        Nu := kc*d_hyd/max(MIN, IN_var.lambda);

        //failure status
        fstatus[1] := if IN_con.target == TYP.UndevOne or IN_con.target == TYP.UndevBoth then
                if Pr > prandtlMax or Pr < prandtlMin then 1 else 0 else 0;
        fstatus[2] := if d_hyd/IN_con.L > 1.0 then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;

        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for an overall fluid flow through an even gap at different fluid flow and heat transfer situations.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> developed fluid flow
   <ul>
   <li> heat transfer from one side of the gap (target=1)
   <li> heat transfer from both sides of the gap (target=2)
   </ul>
<li> undeveloped fluid flow
   <ul>
   <li> heat transfer from one side of the gap (target=3)
       <ul>
       <li> Prandtl number 0.1 &le; Pr &le; 10
       </ul>
   <li> heat transfer from both sides of the gap (target=4)
   <ul>
       <li> Prandtl number 0.1 &le; Pr &le; 1000
       </ul>
   </ul>
<li> turbulent regime always calculated for developed fluid flow and heat transfer from both sides of the gap (target=2)
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/pic_gap.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc</b> for an even gap is calculated through the corresponding Nusselt number <b> Nu </b> according to <i>[VDI 2002, p. Gb 6-7]</i> :

<pre>
    Nu_lam = [(Nu_1)^3 + (Nu_2)^3 + (Nu_3)^3]^(1/3),
    Nu_turb =(zeta/8)*Re*Pr/{1+12.7*[zeta/8]^(0.5)*[Pr^(2/3) -1]}*{1+[d_hyd/L]^(2/3)},
    Nu = f(Nu_lam,Nu_turb)
</pre>

<p>
with the corresponding mean convective heat transfer coefficient <b> kc </b> :
</p>

<p>
<pre>
    kc =  Nu * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> cp                      </b></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><b> d_hyd = 2*s             </b></td><td> as hydraulic diameter of gap [m],</td></tr>
<tr><td><b> eta                     </b></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><b> h                       </b></td><td> as height of cross sectional area in gap [m],</td></tr>
<tr><td><b> kc                      </b></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><b> lambda                  </b></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><b> L                       </b></td><td> as overflowed length of gap (normal to cross sectional area) [m] ,</td></tr>
<tr><td><b> Nu_lam                  </b></td><td> as mean Nusselt number for laminar regime [-], </td></tr>
<tr><td><b> Nu_turb                 </b></td><td> as mean Nusselt number for turbulent regime [-], </td></tr>
<tr><td><b> Nu                      </b></td><td> as mean Nusselt number for overall regime [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda      </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> rho                     </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> s                       </b></td><td> as distance between parallel plates of cross sectional area [m],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta    </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> v                       </b></td><td> as mean velocity in gap [m/s].</td></tr>
</table>
</p>

The summands for the mean Nusselt number in the laminar regime <b> Nu_lam </b> at a chosen fluid flow and heat transfer situation are calculated as follows:
<ul>
<li> developed fluid flow
   <ul>
   <li> heat transfer from one side of the gap (target=1)
        <ul>
            <li> Nu_1 = 4.861 </li>
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3) </li>
            <li> Nu_3 = 0 </li>
        </ul>
   <li> heat transfer from both sides of the gap (target=2)
        <ul>
            <li> Nu_1 = 7.541 </li>
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3) </li>
            <li> Nu_3 = 0 </li>
        </ul>
   </ul>
<li> undeveloped fluid flow
   <ul>
   <li> heat transfer from one side of the gap (target=3)
        <ul>
            <li> Nu_1 = 4.861
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3)
            <li> Nu_3 = [2/(1+22*Pr)]^(1/6)*(Re*Pr*d_hyd/L)^(1/2)
        </ul>
   <li> heat transfer from both sides of the gap (target=4)
        <ul>
            <li> Nu_1 = 7.541 </li>
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3) </li>
            <li> Nu_3 = [2/(1+22*Pr)]^(1/6)*(Re*Pr*d_hyd/L)^(1/2)
        </ul>
   </ul>
</ul>

<p>
The Nusselt number in the turbulent regime <b> Nu_turb </b> is calculated according to <i> Gnielinski in [VDI 2002, p. Gb 7, sec. 2.4]</i>
</p>
<pre>
    Nu_turb =(zeta/8)*Re*Pr/{1+12.7*[zeta/8]^(0.5)*[Pr^(2/3) -1]}*{1+[d_hyd/L]^(2/3)}
</pre>

<p>
where the pressure loss coefficient <b> zeta </b> according to <i> Konakov in [VDI 2002, p. Ga 5, eq. 27]</i> is determined by
</p>

<p>
<pre>
    zeta =  1/[1.8*log10(Re) - 1.5]^2.
</pre>
</p>

<p>
Note that the fluid flow properties shall be calculated with an arithmetic mean temperature out of the fluid flow temperatures at the entrance and the exit of the gap.
</p>

<p>
Note that the heat transfer in the turbulent regime of a gap for a developed fluid flow and heat transfer from both sides of the gap (target = 2) can be calculated with the correlations of a straight pipe. In doing so the hydraulic diameter of the gap (d_hyd = 2*s) has to be used for the heat transfer correlation instead of the hydraulic diameter of the straight pipe. All calculations of different targets use this assumption for the turbulent regime.
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>

The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> for Prandtl numbers of different fluids in dependence of
the chosen fluid flow and heat transfer situations (targets) is shown in the figures below.
</p>

<ul>
   <li> Target 1: Developed fluid flow and heat transfer from one side of the gap
   <li> Target 2: Developed fluid flow and heat transfer from both sides of the gap
   <li> Target 3: Undeveloped fluid flow and heat transfer from one side of the gap
   <li> Target 4: Undeveloped fluid flow and heat transfer from both sides of the gap

The verification for all targets is shown in the following figure w.r.t. the reference:

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/fig_channel_kc_evenGapOverall.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Bejan,A.:</dt>
    <dd><b>Heat transfer handbook</b>.
    Wiley, 2003.</dd>
<dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_evenGapOverall;

      function kc_evenGapOverall_KC
        "Mean heat transfer coefficient of even gap | overall flow regime | considering boundary layer development | heat transfer at ONE or BOTH sides | identical and constant wall temperatures | surface roughness"

        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 6-10

        //icon
        extends Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.Gap1_d;

        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con
          IN_con "Input record for function kc_evenGapOverall_KC"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var
          IN_var "Input record for function kc_evenGapOverall_KC"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Output for function kc_evenGapOverall_KC";

      protected
        Real MIN=Modelica.Constants.eps;

        Real laminar=2200 "Maximum Reynolds number for laminar regime";
        Real turbulent=1e4 "Minimum Reynolds number for turbulent regime";

        SI.Area A_cross=max(MIN, IN_con.s*IN_con.h)
          "Cross sectional area of gap";
        SI.Diameter d_hyd=2*IN_con.s "Hydraulic diameter";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity in gap";
        SI.ReynoldsNumber Re=max(1, IN_var.rho*velocity*d_hyd/max(MIN, IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        //Documentation
      algorithm
        kc := SMOOTH(
                laminar,
                turbulent,
                Re)*Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC(
          IN_con, IN_var) + SMOOTH(
                turbulent,
                laminar,
                Re)*Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_KC(
          IN_con, IN_var);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for an overall fluid flow through an even gap at different fluid flow and heat transfer situations.
</p>

<p>
Generally this function is numerically best used for the calculation of the mean convective heat transfer coefficient <b> kc </b> at known mass flow rate.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> developed fluid flow</li>
   <ul>
   <li> heat transfer from one side of the gap (target=1) <(li>
   <li> heat transfer from both sides of the gap (target=2) <(li>
   </ul>
<li> undeveloped fluid flow</li>
   <ul>
   <li> heat transfer from one side of the gap (target=3) <(li>
       <ul>
       <li> Prandtl number 0.1 &le; Pr &le; 10 </li>
       </ul>
   <li> heat transfer from both sides of the gap (target=4) <(li>
   <ul>
       <li> Prandtl number 0.1 &le; Pr &le; 1000 </li>
       </ul>
   </ul>
<li> turbulent regime always calculated for developed fluid flow and heat transfer from both sides of the gap (target=2)</li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/pic_gap.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc</b> for an even gap is calculated through the corresponding Nusselt number <b> Nu </b> according to <i>[VDI 2002, p. Gb 6-7]</i> :

<pre>
    Nu_lam = [(Nu_1)^3 + (Nu_2)^3 + (Nu_3)^3]^(1/3),
    Nu_turb =(zeta/8)*Re*Pr/{1+12.7*[zeta/8]^(0.5)*[Pr^(2/3) -1]}*{1+[d_hyd/L]^(2/3)},
    Nu = f(Nu_lam,Nu_turb)
</pre>

<p>
with the corresponding mean convective heat transfer coefficient <b> kc </b> :
</p>

<p>
<pre>
    kc =  Nu * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> cp                      </b></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><b> d_hyd = 2*s             </b></td><td> as hydraulic diameter of gap [m],</td></tr>
<tr><td><b> eta                     </b></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><b> h                       </b></td><td> as height of cross sectional area in gap [m],</td></tr>
<tr><td><b> kc                      </b></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><b> lambda                  </b></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><b> L                       </b></td><td> as overflowed length of gap (normal to cross sectional area) [m] ,</td></tr>
<tr><td><b> Nu_lam                  </b></td><td> as mean Nusselt number for laminar regime [-], </td></tr>
<tr><td><b> Nu_turb                 </b></td><td> as mean Nusselt number for turbulent regime [-], </td></tr>
<tr><td><b> Nu                      </b></td><td> as mean Nusselt number for overall regime [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda      </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> rho                     </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> s                       </b></td><td> as distance between parallel plates of cross sectional area [m],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta    </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> v                       </b></td><td> as mean velocity in gap [m/s].</td></tr>
</table>
</p>

The summands for the mean Nusselt number in the laminar regime <b> Nu_lam </b> at a chosen fluid flow and heat transfer situation are calculated as follows:
<ul>
<li> developed fluid flow</li>
   <ul>
   <li> heat transfer from one side of the gap (target=1) <(li>
        <ul>
            <li> Nu_1 = 4.861 </li>
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3) </li>
            <li> Nu_3 = 0 </li>
        </ul>
   <li> heat transfer from both sides of the gap (target=2) <(li>
        <ul>
            <li> Nu_1 = 7.541 </li>
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3) </li>
            <li> Nu_3 = 0 </li>
        </ul>
   </ul>
<li> undeveloped fluid flow</li>
   <ul>
   <li> heat transfer from one side of the gap (target=3) <(li>
        <ul>
            <li> Nu_1 = 4.861 </li>
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3) </li>
            <li> Nu_3 = [2/(1+22*Pr)]^(1/6)*(Re*Pr*d_hyd/L)^(1/2) </li>
        </ul>
   <li> heat transfer from both sides of the gap (target=4) <(li>
        <ul>
            <li> Nu_1 = 7.541 </li>
            <li> Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3) </li>
            <li> Nu_3 = [2/(1+22*Pr)]^(1/6)*(Re*Pr*d_hyd/L)^(1/2) </li>
        </ul>
   </ul>
</ul>

<p>
The Nusselt number in the turbulent regime <b> Nu_turb </b> is calculated according to <i> Gnielinski in [VDI 2002, p. Gb 7, sec. 2.4]</i>
</p>
<pre>
    Nu_turb =(zeta/8)*Re*Pr/{1+12.7*[zeta/8]^(0.5)*[Pr^(2/3) -1]}*{1+[d_hyd/L]^(2/3)}
</pre>

<p>
where the pressure loss coefficient <b> zeta </b> according to <i> Konakov in [VDI 2002, p. Ga 5, eq. 27]</i> is determined by
</p>

<p>
<pre>
    zeta =  1/[1.8*log10(Re) - 1.5]^2.
</pre>
</p>

<p>
Note that the fluid flow properties shall be calculated with an arithmetic mean temperature out of the fluid flow temperatures at the entrance and the exit of the gap.
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>

The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> for Prandtl numbers of different fluids in dependence of
the chosen fluid flow and heat transfer situations (targets) is shown in the figures below. Here the figures are calculated for an (unintended) inverse calculation, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <b> kc </b>.
</p>

<ul>
   <li> Target 1: Developed fluid flow and heat transfer from one side of the gap </li>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/fig_channel_kc_evenGapOverall_target1_KC.png\">
</ul>

<ul>
   <li> Target 2: Developed fluid flow and heat transfer from both sides of the gap </li>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/fig_channel_kc_evenGapOverall_target2_KC.png\">
</ul>

<ul>
  <li> Target 3: Undeveloped fluid flow and heat transfer from one side of the gap </li>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/fig_channel_kc_evenGapOverall_target3_KC.png\">
</ul>

<ul>
 <li> Target 4: Undeveloped fluid flow and heat transfer from both sides of the gap </li>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/fig_channel_kc_evenGapOverall_target4_KC.png\">
</ul>

<p>
Note that the heat transfer in the turbulent regime of a gap for a developed fluid flow and heat transfer from both sides of the gap (target = 2) can be calculated with the correlations of a straight pipe. In doing so the hydraulic diameter of the gap (d_hyd = 2*s) has to be used for the heat transfer correlation instead of the hydraulic diameter of the straight pipe. All calculations of different targets use this assumption for the turbulent regime.
</p>

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall\">kc_evenGapOverall</a> is also valid for this inverse calculation due to using the same functions.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_evenGapOverall_KC;

      record kc_evenGapOverall_IN_con
        "Input record for function kc_evenGapOverall and kc_evenGapOverall_KC"

        //even gap variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.EvenGap;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall\"> kc_evenGapOverall </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_KC\"> kc_evenGapOverall_KC </a>.
</html>"));
      end kc_evenGapOverall_IN_con;

      record kc_evenGapOverall_IN_var
        "Input record for function kc_evenGapOverall and kc_evenGapOverall_KC"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;

        //input variable (mass flow rate)
        SI.MassFlowRate m_flow annotation (Dialog(group="Input"));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall\"> kc_evenGapOverall </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_KC\"> kc_evenGapOverall_KC </a>.
</html>"));
      end kc_evenGapOverall_IN_var;

      function kc_evenGapTurbulent
        "Mean heat transfer coefficient of even gap | turbulent flow regime | developed fluid flow | heat transfer at BOTH sides | identical and constant wall temperatures"

        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 7

        //icon
        extends Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.Gap1_d;

        import SI = Modelica.SIunits;
        import MIN = Modelica.Constants.eps;

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_IN_con
          IN_con "Input record for function kc_evenGapTurbulent"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_IN_var
          IN_var "Input record for function kc_evenGapTurbulent"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results"
          annotation (Dialog(group="Output"));

      protected
        Real MIN=Modelica.Constants.eps;

        Real prandtlMax=100 "Maximum Prandtl number";
        Real prandtlMin=0.6 "Minimum Prandtl number";
        Real turbulentMax=1e6
          "Maximum Reynolds number for turbulent flow regime";
        Real turbulentMin=3e4
          "Minimum Reynolds number for turbulent flow regime";

        SI.Area A_cross=max(MIN, IN_con.s*IN_con.h)
          "Cross sectional area of gap";
        SI.Diameter d_hyd=2*IN_con.s "Hydraulic diameter";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity in gap";

        //failure status
        Real fstatus[3] "check of expected boundary conditions";

        //Documentation
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
        Re := max(1, abs(IN_var.rho*velocity*d_hyd/max(MIN, IN_var.eta)));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_KC(IN_con,
          IN_var);
        Nu := kc*d_hyd/max(MIN, IN_var.lambda);

        //failure status
        fstatus[1] := if Re > turbulentMax or Re < turbulentMin then 1 else 0;
        fstatus[2] := if Pr > prandtlMax or Pr < prandtlMin then 1 else 0;
        fstatus[3] := if d_hyd/max(MIN, IN_con.L) > 1.0 then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for a developed turbulent fluid flow through an even gap at heat transfer from both sides.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> identical and constant wall tempertures
<li> hydraulic diameter per gap lenght (d_hyd / L) &le; 1
<li> 0.5 &le; Prandtl number Pr &le; 100) </li>
<li> turbulent regime (3e4 &le; Reynolds number &le; 1e6)
<li> developed fluid flow</li>
<li> heat transfer from both sides of the gap (Target = 2)
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/pic_gap.png\">


<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc</b> for an even gap is calculated through the corresponding Nusselt number <b> Nu_turb</b> according to <i> Gnielinski in [VDI 2002, p. Gb 7, sec. 2.4]</i>

<pre>
    Nu_turb =(zeta/8)*Re*Pr/{1+12.7*[zeta/8]^(0.5)*[Pr^(2/3) -1]}*{1+[d_hyd/L]^(2/3)}
</pre>

<p>
where the pressure loss coefficient <b> zeta </b> according to <i> Konakov in [VDI 2002, p. Ga 5, eq. 27]</i> is determined by
</p>

<p>
<pre>
    zeta =  1/[1.8*log10(Re) - 1.5]^2
</pre>
</p>

<p>
resulting to the corresponding mean convective heat transfer coefficient <b> kc </b>
</p>

<p>
<pre>
    kc =  Nu_turb * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> cp                      </b></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><b> d_hyd = 2*s             </b></td><td> as hydraulic diameter of gap [m],</td></tr>
<tr><td><b> eta                     </b></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><b> h                       </b></td><td> as height of cross sectional area in gap [m],</td></tr>
<tr><td><b> kc                      </b></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><b> lambda                  </b></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><b> L                       </b></td><td> as overflowed length of gap (normal to cross sectional area) [m] ,</td></tr>
<tr><td><b> Nu_turb                 </b></td><td> as mean Nusselt number for turbulent regime [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda      </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> rho                     </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> s                       </b></td><td> as distance between parallel plates of cross sectional area [m],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta    </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> v                       </b></td><td> as mean velocity in gap [m/s],</td></tr>
<tr><td><b> zeta                    </b></td><td> as pressure loss coefficient [-].</td></tr>
</table>
</p>
<p>
Note that the fluid flow properties shall be calculated with an arithmetic mean temperature out of the fluid flow temperatures at the entrance and the exit of the gap.
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu_turb </b> representing the mean convective heat transfer coefficient <b> kc </b> in dependence of
the chosen fluid flow and heat transfer situations (targets) is shown in the figure below.
</p>

<ul>
   <li> Target 2: Developed fluid flow and heat transfer from both sides of the gap
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/fig_channel_kc_evenGapTurbulent.png\">
</ul>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_evenGapTurbulent;

      function kc_evenGapTurbulent_KC
        "Mean heat transfer coefficient of even gap | turbulent flow regime | developed fluid flow | heat transfer at BOTH sides | identical and constant wall temperatures"

        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 7

        //icon
        extends Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.Gap1_d;

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_IN_con
          IN_con "Input record for function kc_evenGapTurbulent_KC"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_IN_var
          IN_var "Input record for function kc_evenGapTurbulent_KC"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Output for function kc_evenGapTurbulentRoughness_KC";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=max(MIN, IN_con.s*IN_con.h)
          "Cross sectional area of gap";
        SI.Diameter d_hyd=2*IN_con.s "Hydraulic diameter";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity in gap";
        SI.ReynoldsNumber Re=max(2.6, IN_var.rho*velocity*d_hyd/max(MIN, IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        //SOURCE: p.Ga 5, eq. 27
        Real zeta=1/max(MIN, 1.8*Modelica.Math.log10(abs(Re)) - 1.5)^2
          "Pressure loss coefficient";

        //SOURCE: p.Gb 5, eq. 26
        //assumption according to Gb 7, sec. 2.4
        SI.NusseltNumber Nu=abs((zeta/8)*Re*Pr/(1 + 12.7*(zeta/8)^0.5*(Pr^(2/3) - 1))
            *(1 + (d_hyd/max(MIN, IN_con.L))^(2/3)));

        //Documentation
      algorithm
        kc := Nu*(IN_var.lambda/max(MIN, d_hyd));

        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for a developed turbulent fluid flow through an even gap at heat transfer from both sides.
</p>

<p>
Generally this function is numerically best used for the calculation of the mean convective heat transfer coefficient <b> kc </b> at known mass flow rate.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> identical and constant wall tempertures</li>
<li> hydraulic diameter per gap lenght (d_hyd / L) &le; 1</li>
<li> 0.5 &le; Prandtl number Pr &le; 100) </li>
<li> turbulent regime (3e4 &le; Reynolds number &le; 1e6) </li>
<li> developed fluid flow</li>
<li> heat transfer from both sides of the gap (Target = 2) <(li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/pic_gap.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc</b> for an even gap is calculated through the corresponding Nusselt number <b> Nu_turb</b> according to <i> Gnielinski in [VDI 2002, p. Gb 7, sec. 2.4]</i>

<pre>
    Nu_turb =(zeta/8)*Re*Pr/{1+12.7*[zeta/8]^(0.5)*[Pr^(2/3) -1]}*{1+[d_hyd/L]^(2/3)}
</pre>

<p>
where the pressure loss coefficient <b> zeta </b> according to <i> Konakov in [VDI 2002, p. Ga 5, eq. 27]</i> is determined by
</p>

<p>
<pre>
    zeta =  1/[1.8*log10(Re) - 1.5]^2
</pre>
</p>

<p>
resulting to the corresponding mean convective heat transfer coefficient <b> kc </b>
</p>

<p>
<pre>
    kc =  Nu_turb * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> cp                      </b></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><b> d_hyd = 2*s             </b></td><td> as hydraulic diameter of gap [m],</td></tr>
<tr><td><b> eta                     </b></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><b> h                       </b></td><td> as height of cross sectional area in gap [m],</td></tr>
<tr><td><b> kc                      </b></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><b> lambda                  </b></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><b> L                       </b></td><td> as overflowed length of gap (normal to cross sectional area) [m] ,</td></tr>
<tr><td><b> Nu_turb                 </b></td><td> as mean Nusselt number for turbulent regime [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda      </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> rho                     </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> s                       </b></td><td> as distance between parallel plates of cross sectional area [m],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta    </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> v                       </b></td><td> as mean velocity in gap [m/s],</td></tr>
<tr><td><b> zeta                    </b></td><td> as pressure loss coefficient [-].</td></tr>
</table>
</p>
<p>
Note that the fluid flow properties shall be calculated with an arithmetic mean temperature out of the fluid flow temperatures at the entrance and the exit of the gap.
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu_turb </b> representing the mean convective heat transfer coefficient <b> kc </b> at developed turbulent fluid flow and heat transfer from both sides of the gap for Prandtl numbers of different fluids (Target = 2) is shown in the figure below. Here the figures are calculated for an (unintended) inverse calculation, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <b> kc </b>.
</p>

<ul>
   <li> Target 2: Developed fluid flow and heat transfer from both sides of the gap <(li>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/fig_channel_kc_evenGapTurbulent.png\">
</ul>

Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulentRoughness\">kc_evenGapTurbulentRoughness</a> is also valid for this inverse calculation due to using the same functions.

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Elmquist,H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>

<dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_evenGapTurbulent_KC;

      record kc_evenGapTurbulent_IN_con
        "Input record for function kc_evenGapTurbulentRoughness and kc_evenGapTurbulentRoughness_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con(
            final target=2);

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent\"> kc_evenGapTurbulent </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_KC\"> kc_evenGapTurbulent_KC </a>.
</html>"));
      end kc_evenGapTurbulent_IN_con;

      record kc_evenGapTurbulent_IN_var
        "Input record for function kc_evenGapTurbulentRoughness and kc_evenGapTurbulentRoughness_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent\"> kc_evenGapTurbulent </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_KC\"> kc_evenGapTurbulent_KC </a>.
</html>"));
      end kc_evenGapTurbulent_IN_var;
    end Channel;

    package General
    extends Modelica.Icons.VariantsPackage;

      function kc_approxForcedConvection
        "Mean convective heat transfer coefficient for forced convection | approximation | turbulent regime | hydrodynamically developed fluid flow"

        //SOURCE: A Bejan and A.D. Kraus. Heat Transfer handbook.John Wiley & Sons, 2nd edition, 2003. (p.424 ff)
        //Notation of equations according to SOURCE

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_con
          IN_con "Input record for function kc_approxForcedConvection"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_var
          IN_var "Input record for function kc_approxForcedConvection"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results"
          annotation (Dialog(group="Output"));

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.kc_general;

        Real MIN=Modelica.Constants.eps;

        Real prandtlMax[3]={120,16700,500} "Maximum Prandtl number";
        Real prandtlMin[3]={0.7,0.7,1.5} "Minimum Prandtl number";
        Real reynoldsMax[3]={1.24e5,1e6,1e6} "Maximum Reynolds number";
        Real reynoldsMin[3]={2500,1e4,3e3} "Minimum Reynolds number";

        SI.Diameter d_hyd=max(MIN, 4*IN_con.A_cross/max(MIN, IN_con.perimeter))
          "Hydraulic diameter";

        //failure status
        Real fstatus[2] "Check of expected boundary conditions";

      algorithm
        Pr := Modelica.Fluid.Dissipation.Utilities.Functions.General.PrandtlNumber(
                IN_var.cp,
                IN_var.eta,
                IN_var.lambda);
        Re := max(1, Modelica.Fluid.Dissipation.Utilities.Functions.General.ReynoldsNumber(
                IN_con.A_cross,
                IN_con.perimeter,
                IN_var.rho,
                IN_var.eta,
                abs(IN_var.m_flow))) "Reynolds number";
        kc := Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_KC(
          IN_con, IN_var);
        Nu := kc*d_hyd/max(MIN, IN_var.lambda);

        //failure status
        fstatus[1] := if IN_con.target == TYP.Rough then if Pr > prandtlMax[1] or Pr
           < prandtlMin[1] then 1 else 0 else if IN_con.target == TYP.Middle then if
          Pr > prandtlMax[2] or Pr < prandtlMin[2] then 1 else 0 else if IN_con.target
           == TYP.Finest then if Pr > prandtlMax[3] or Pr < prandtlMin[3] then 1 else
                0 else 0;
        fstatus[2] := if IN_con.target == TYP.Rough then if Re > reynoldsMax[1] or Re
           < reynoldsMin[1] then 1 else 0 else if IN_con.target == TYP.Middle then
          if Re > reynoldsMax[2] or Re < reynoldsMin[2] then 1 else 0 else if IN_con.target
           == TYP.Finest then if Re > reynoldsMax[3] or Re < reynoldsMin[3] then 1 else
                0 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;

        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Approximate calculation of the mean convective heat transfer coefficient <b> kc </b> for forced convection with a fully developed fluid flow in a turbulent regime.
</p>

</p>
A detailled documentation for this convective heat transfer calculation can be found in its underlying function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_KC\">kc_approxForcedConvection_KC</a>.

Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled.
</p>
</html>"));
      end kc_approxForcedConvection;

      function kc_approxForcedConvection_KC
        "Mean convective heat transfer coefficient for forced convection | approximation | turbulent regime | hydrodynamically developed fluid flow"

        //SOURCE: A Bejan and A.D. Kraus. Heat Transfer handbook.John Wiley & Sons, 2nd edition, 2003. (p.424 ff)
        //Notation of equations according to SOURCE

        //type =

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_con
          IN_con "Input record for function kc_approxForcedConvection_KC"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_var
          IN_var "Input record for function kc_approxForcedConvection_KC"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Output for function kc_approxForcedConvection_KC";

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.kc_general;

        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=max(MIN, 4*IN_con.A_cross/max(MIN, IN_con.perimeter))
          "Hydraulic diameter";

        SI.PrandtlNumber Pr=max(MIN, abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda)))
          "Prandtl number";
        SI.ReynoldsNumber Re=max(1, 4*abs(IN_var.m_flow)/max(MIN, IN_con.perimeter*
            IN_var.eta)) "Reynolds number";

      algorithm
        kc := IN_var.lambda/d_hyd*(if IN_con.target == TYP.Rough then 0.023*Re^(4/5)*
          Pr^IN_con.exp_Pr else if IN_con.target == TYP.Middle then 0.023*Re^(4/5)*Pr
          ^(1/3)*(IN_var.eta/IN_var.eta_wall)^0.14 else if IN_con.target == 3 and Pr
           <= 1.5 then 0.0214*max(1, abs(Re^0.8 - 100))*Pr^0.4 else if IN_con.target
           == TYP.Finest then 0.012*max(1, abs(Re^0.87 - 280))*Pr^0.4 else 0);

        //Documentation
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Approximate calculation of the mean convective heat transfer coefficient <b> kc </b> for forced convection with a fully developed fluid flow in a turbulent regime.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> Constant wall temperature <b> or </b> constant heat flux
<li> Turbulent regime (Reynolds number 2500 &lt; Re &lt; 1e6)
<li> Prandtl number 0.5 &le; Pr &le; 500
</ul>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc </b> is approximated through different Nusselt number <b> Nu </b> correlations out of <i>[Bejan 2003, p. 424 ff]</i>. <br>
Roughest approximation according to Dittus/Boelter (1930):
<pre>
    Nu_1 = 0.023 * Re^(4/5) * Pr^(exp_Pr)
</pre>

Middle approximation according to Sieder/Tate (1936) considering the temperature dependence of the fluid properties:
<pre>
    Nu_2 = 0.023 * Re^(4/5) * Pr^(1/3) * (eta/eta_wall)^(0.14)
</pre>

Finest approximation according to Gnielinski (1976):
<pre>
    Nu_3 = 0.0214 * [Re^(0.8) - 100] * Pr^(0.4) for Pr &le; 1.5
         = 0.012 * [Re^(0.87) - 280] * Pr^(0.4) for Pr &gt; 1.5
</pre>

<p>
The mean convective heat transfer coefficient <b> kc </b> is calculated by:
</p
<p>
<pre>
    kc =  Nu * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> eta                          </b></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><b> eta_wall                     </b></td><td> as dynamic viscosity of fluid at wall temperature [Pa.s],</td></tr>
<tr><td><b> exp_Pr                       </b></td><td> as exponent for Prandtl number w.r.t. Dittus/Boelter (0.4 for heating or 0.3 for cooling) [-],</td></tr>
<tr><td><b> kc                           </b></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><b> lambda                       </b></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><b> d_hyd                        </b></td><td> as hydraulic diameter [m],</td></tr>
<tr><td><b> Nu_1/2/3                     </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr                           </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re                           </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>

The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> for Prandtl numbers of different fluids is shown in the figure below. <br>
<b>Dittus/Boelter</b> (Target = 1)

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/general/fig_kc_approxForcedConvection_T1.png\">

<b>Sieder/Tate</b> (Target = 2)

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/general/fig_kc_approxForcedConvection_T2.png\">

<b>Gnielinski</b> (Target = 3)

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/general/fig_kc_approxForcedConvection_T3.png\">


Note that all fluid properties shall be calculated with the mean temperature of the fluid between the entrance and the outlet of the generic device.

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Bejan,A.:</dt>
    <dd><b>Heat transfer handbook</b>.
    Wiley, 2003.</dd>
</dl>

</html>"));
      end kc_approxForcedConvection_KC;

      record kc_approxForcedConvection_IN_con
        "Input record for function approxForcedConvection and approxForcedConvection_KC"

        //generic variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.General            annotation (
            Dialog(group="Generic variables"));
        parameter Real exp_Pr=0.4
          "Exponent for Prandtl number w.r.t. Dittus/Boelter | 0.4 for heating | 0.3 for cooling"
          annotation (Dialog(group="Generic variables",enable=if target == 1 then
                true else false));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection\"> kc_approxForcedConvection </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_KC\"> kc_approxForcedConvection_KC </a>.
</html>"));
      end kc_approxForcedConvection_IN_con;

      record kc_approxForcedConvection_IN_var
        "Input record for function approxForcedConvection and approxForcedConvection_KC"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties
          annotation (Dialog(group="Fluid properties"));
        SI.DynamicViscosity eta_wall=1e-3
          "Dynamic viscosity of fluid at wall temperature" annotation (Dialog(group=
                "Fluid properties", enable=if target == 2 then true else false));

        //input variable (mass flow rate)
        SI.MassFlowRate m_flow annotation (Dialog(group="Input"));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection\"> kc_approxForcedConvection </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_KC\"> kc_approxForcedConvection_KC </a>.
</html>"));
      end kc_approxForcedConvection_IN_var;
    end General;

    package HeatExchanger
    extends Modelica.Icons.VariantsPackage;

      function kc_flatTube

        //SOURCE: A.M. Jacobi, Y. Park, D. Tafti, X. Zhang. AN ASSESSMENT OF THE STATE OF THE ART, AND POTENTIAL DESIGN IMPROVEMENTS, FOR FLAT-TUBE HEAT EXCHANGERS IN AIR CONDITIONING AND REFRIGERATION APPLICATIONS - PHASE I

        //icon

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_con
          IN_con "Input record for function kc_flatTube"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_var
          IN_var "Input record for function kc_flatTube"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results"
          annotation (Dialog(group="Output"));

      protected
        type TYP =
            Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_flatTubes;

        SI.Area A_c=if IN_con.geometry == TYP.LouverFin then IN_con.A_fr*((IN_con.F_l
             - IN_con.delta_f)*(IN_con.F_p - IN_con.delta_f)/((IN_con.F_l + IN_con.D_m)
            *IN_con.F_p)) else if IN_con.geometry == TYP.RectangularFin then IN_con.A_fr
            *(h*s/((h + t + IN_con.D_m)*(s + t))) else 0
          "Minimum flow cross-sectional area";
        SI.Length h=if IN_con.geometry == TYP.RectangularFin then IN_con.D_h*(1 +
            IN_con.alpha)/(2*IN_con.alpha) else 0 "Free flow height";
        SI.Length l=if IN_con.geometry == TYP.RectangularFin then t/IN_con.delta else
                  0 "Fin length";
        SI.Length s=if IN_con.geometry == TYP.RectangularFin then h*IN_con.alpha else
                  0 "Lateral fin spacing (free flow width)";
        SI.Length t=if IN_con.geometry == TYP.RectangularFin then s*IN_con.gamma else
                  0 "Fin thickness";
      algorithm
        kc := Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_KC(IN_con,
          IN_var);
        Pr := abs(IN_var.eta*IN_var.cp/IN_var.lambda);

        if IN_con.geometry == TYP.LouverFin then
          Re := max(1e-3, abs(IN_var.m_flow)*IN_con.L_p/(IN_var.eta*A_c));
          Nu := max(1e-3, kc*IN_con.L_p/IN_var.lambda);
        elseif IN_con.geometry == TYP.RectangularFin then
          Re := max(1e-3, abs(IN_var.m_flow)*IN_con.D_h/(IN_var.eta*A_c));
          Nu := max(1e-3, kc*IN_con.D_h/IN_var.lambda);
        end if;

        failureStatus := if IN_con.geometry == TYP.LouverFin then if Re < 100 or Re
           > 3000 then 1 else 0 else if IN_con.geometry == TYP.RectangularFin then
          if Re < 300 or Re > 5000 then 1 else 0 else 0;

        annotation (smoothOrder=5, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for the air-side heat transfer of heat exchangers with flat tubes and several fin geometries.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> According to the kind of fin geometry the calculation is valid in a range of <b> Re</b> from 100 to 5000. </li>
<li> medium = air </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/heatExchanger/pic_flatTube.png\", width=850>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc </b> for heat exchanger is calculated through the corresponding Coulburn factor <b> j </b>:

<pre>
    j = f(geometry, Re)
</pre>

<p>
with the resulting mean convective heat transfer coefficient <b> kc </b>
</p>

<p>
<pre>
    kc =  j * Re_L_p * Pr^(1/3) * lambda / L_p (Louver fin)
</pre>
</p>

 <p>
or
</p>

<p>
<pre>
    kc =  j * Re_D_h * Pr^(1/3) * lambda / D_h (Rectangular offset strip fin)
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> D_h                        </b></td><td> as hydraulic diameter [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L_p                        </b></td><td> as louver pitch [m],</td></tr>
<tr><td><b> Nu_D_h = kc*D_h/lambda     </b></td><td> as mean Nusselt number based on hydraulic diameter [-], </td></tr>
<tr><td><b> Nu_L_p = kc*L_p/lambda     </b></td><td> as mean Nusselt number based on louver pitch [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re_D_h = rho*v*D_h/eta     </b></td><td> as Reynolds number based on hydraulic diameter [-],</td></tr>
<tr><td><b> Re_L_p = rho*v*L_p/eta     </b></td><td> as Reynolds number based on louver pitch [-],</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> is shown below for different fin geometries at similar dimensions.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/heatExchanger/fig_flatTube_kc.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>Y.-J. CHANG and C.-C. WANG:</dt>
    <dd><b>A generalized heat transfer correlation for louver fin geometry</b>.
    In International Journal of Heat and Mass Transfer, volume 40, No. 3,  pages 533-544, 1997.</dd>
 <dt>Y.-J. CHANG and C.-C. WANG:</dt>
    <dd><b>Air Side Performance of Brazed Aluminium Heat Exchangers</b>.
    In Journal of Enhanced Heat Transfer, volume 3, No. 1,  pages 15-28, 1996.</dd>
 <dt>R.-M. Manglik, A.-E. Bergles:</dt>
    <dd><b>Heat Transfer and Pressure Drop Correlations for the Rectangular Offset Strip Fin Compact Heat Exchanger</b>.
    In Experimental Thermal and Fluid Science, volume 10, pages 171-180, 1995.</dd>
</dl>

</html>
"));
      end kc_flatTube;

      function kc_flatTube_KC

        //SOURCE: A.M. Jacobi, Y. Park, D. Tafti, X. Zhang. AN ASSESSMENT OF THE STATE OF THE ART, AND POTENTIAL DESIGN IMPROVEMENTS, FOR FLAT-TUBE HEAT EXCHANGERS IN AIR CONDITIONING AND REFRIGERATION APPLICATIONS - PHASE I

        //icon

        // import SMOOTH = Modelica.Fluid.Dissipation.Utilities.Functions.Stepsmoother;

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_con
          IN_con "Input record for function kc_flatTube_KC"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_var
          IN_var "Input record for function kc_flatTube_KC"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Output for function kc_flatTubePlateFin_KC";

      protected
        type TYP =
            Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_flatTubes;

        Real MIN=Modelica.Constants.eps;
        Real Phi=IN_con.Phi*180/PI "Louver angle";

        SI.ReynoldsNumber Re_Dh=max(1e-3, abs(IN_var.m_flow)*IN_con.D_h/(IN_var.eta*
            A_c)) "Reynolds number based on hydraulic diameter";
        SI.ReynoldsNumber Re_Lp=max(1e-3, abs(IN_var.m_flow)*IN_con.L_p/(IN_var.eta*
            A_c)) "Reynolds number based on louver pitch";
        SI.PrandtlNumber Pr=IN_var.eta*IN_var.cp/IN_var.lambda "Prandtl number";
        Real j "Colburn j faktor";

        SI.Area A_c=if IN_con.geometry == TYP.LouverFin then IN_con.A_fr*((IN_con.F_l
             - IN_con.delta_f)*(IN_con.F_p - IN_con.delta_f)/((IN_con.F_l + IN_con.D_m)
            *IN_con.F_p)) else if IN_con.geometry == TYP.RectangularFin then IN_con.A_fr
            *(h*s/((h + t + IN_con.D_m)*(s + t))) else 0
          "Minimum flow cross-sectional area";
        SI.Length h=if IN_con.geometry == TYP.RectangularFin then IN_con.D_h*(1 +
            IN_con.alpha)/(2*IN_con.alpha) else 0 "Free flow height";
        SI.Length l=if IN_con.geometry == TYP.RectangularFin then t/IN_con.delta else
                  0 "Fin length";
        SI.Length s=if IN_con.geometry == TYP.RectangularFin then h*IN_con.alpha else
                  0 "Lateral fin spacing (free flow width)";
        SI.Length t=if IN_con.geometry == TYP.RectangularFin then s*IN_con.gamma else
                  0 "Fin thickness";

      algorithm
        if IN_con.geometry == TYP.LouverFin then
          j := Re_Lp^(-0.49)*(Phi/90)^0.27*(IN_con.F_p/IN_con.L_p)^(-0.14)*(IN_con.F_l
            /IN_con.L_p)^(-0.29)*(IN_con.T_d/IN_con.L_p)^(-0.23)*(IN_con.L_l/IN_con.L_p)
            ^0.68*(IN_con.T_p/IN_con.L_p)^(-0.28)*(IN_con.delta_f/IN_con.L_p)^(-0.05);
          kc := j*(Re_Lp*Pr^(1/3)*IN_var.lambda/IN_con.L_p);

        elseif IN_con.geometry == TYP.RectangularFin then
          j := 0.6522*Re_Dh^(-0.5403)*(s/h)^(-0.1541)*(t/l)^0.1499*(t/s)^(-0.0678)*(1
             + 5.269e-5*Re_Dh^1.340*(s/h)^0.504*(t/l)^0.456*(t/s)^(-1.055))^0.1;
          kc := j*(Re_Dh*Pr^(1/3)*IN_var.lambda/IN_con.D_h);

        else

        end if;

        annotation (smoothOrder=5, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for the air-side heat transfer of heat exchangers with flat tubes and several fin geometries.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> According to the kind of fin geometry the calculation is valid in a range of <b> Re</b> from 100 to 5000. </li>
<li> medium = air </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/heatExchanger/pic_flatTube.png\", width=850>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc </b> for heat exchanger is calculated through the corresponding Coulburn factor <b> j </b>:

<pre>
    j = f(geometry, Re)
</pre>

<p>
with the resulting mean convective heat transfer coefficient <b> kc </b>
</p>

<p>
<pre>
    kc =  j * Re_L_p * Pr^(1/3) * lambda / L_p (Louver fin)
</pre>
</p>

 <p>
or
</p>

<p>
<pre>
    kc =  j * Re_D_h * Pr^(1/3) * lambda / D_h (Rectangular offset strip fin)
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> D_h                        </b></td><td> as hydraulic diameter [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L_p                        </b></td><td> as louver pitch [m],</td></tr>
<tr><td><b> Nu_D_h = kc*D_h/lambda     </b></td><td> as mean Nusselt number based on hydraulic diameter [-], </td></tr>
<tr><td><b> Nu_L_p = kc*L_p/lambda     </b></td><td> as mean Nusselt number based on louver pitch [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re_D_h = rho*v*D_h/eta     </b></td><td> as Reynolds number based on hydraulic diameter [-],</td></tr>
<tr><td><b> Re_L_p = rho*v*L_p/eta     </b></td><td> as Reynolds number based on louver pitch [-],</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>

The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> for the several fin geometries is shown in the figure below. Here the figures are calculated for an (unintended) inverse calculation, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <b> kc </b>.

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/heatExchanger/fig_flatTube_kc_KC.png\">

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube\"> kc_flatTube </a> is also valid for this inverse calculation due to using the same functions.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>Y.-J. CHANG and C.-C. WANG:</dt>
    <dd><b>A generalized heat transfer correlation for louver fin geometry</b>.
    In International Journal of Heat and Mass Transfer, volume 40, No. 3,  pages 533-544, 1997.</dd>
 <dt>Y.-J. CHANG and C.-C. WANG:</dt>
    <dd><b>Air Side Performance of Brazed Aluminium Heat Exchangers</b>.
    In Journal of Enhanced Heat Transfer, volume 3, No. 1,  pages 15-28, 1996.</dd>
 <dt>R.-M. Manglik, A.-E. Bergles:</dt>
    <dd><b>Heat Transfer and Pressure Drop Correlations for the Rectangular Offset Strip Fin Compact Heat Exchanger</b>.
    In Experimental Thermal and Fluid Science, volume 10, pages 171-180, 1995.</dd>
</dl>

</html>
"));
      end kc_flatTube_KC;

      record kc_flatTube_IN_con
        "Input record for function kc_heatExchanger and kc_heatExchanger_KC"
        extends Modelica.Icons.Record;

      protected
        type TYP =
            Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_flatTubes;

      public
        Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_flatTubes
          geometry =                                                              Dissipation.Utilities.Types.HTXGeometry_flatTubes.LouverFin
          "Choice of fin geometry" annotation (Dialog(group="HeatExchanger"));

        SI.Area A_fr=0 "Frontal area" annotation (Dialog(group="HeatExchanger"));
        SI.Length D_h=0 "Hydraulic diameter" annotation (Dialog(group="HeatExchanger",
              enable=if geometry == 2 then true else false));
        SI.Length D_m=0 "Major tube diameter for flat tube"
          annotation (Dialog(group="HeatExchanger"));
        SI.Length F_l=0 "Fin length" annotation (Dialog(group="HeatExchanger", enable=
               if geometry == 1 then true else false));
        SI.Length F_p=0 "Fin pitch, fin spacing + fin thickness" annotation (Dialog(
              group="HeatExchanger", enable=if geometry == 1 then true else false));
        SI.Length L_l=0 "Louver length" annotation (Dialog(group="HeatExchanger",
              enable=if geometry == 1 then true else false));
        SI.Length L_p=0 "Louver pitch" annotation (Dialog(group="HeatExchanger",
              enable=if geometry == 1 then true else false));
        SI.Length T_d=0 "Tube depth" annotation (Dialog(group="HeatExchanger", enable=
               if geometry == 1 then true else false));
        SI.Length T_p=0 "Tube pitch" annotation (Dialog(group="HeatExchanger", enable=
               if geometry == 1 then true else false));

        Real alpha=0 "Lateral fin spacing (s) / free flow height (h)" annotation (
            Dialog(group="HeatExchanger", enable=if geometry == 2 then true else
                false));
        Real gamma=0 "Fin thickness (t) / lateral fin spacing (s)" annotation (Dialog(
              group="HeatExchanger", enable=if geometry == 2 then true else false));
        Real delta=0 "Fin thickness (t) / Fin length (l)" annotation (Dialog(group=
                "HeatExchanger", enable=if geometry == 2 then true else false));
        SI.Length delta_f=0 "Fin thickness" annotation (Dialog(group="HeatExchanger",
              enable=if geometry == 1 then true else false));
        SI.Angle Phi=0 "Louver angle" annotation (Dialog(group="HeatExchanger",
              enable=if geometry == 1 then true else false));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube\"> kc_flatTube </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_KC\"> kc_flatTube_KC </a>.
</html>"));

      end kc_flatTube_IN_con;

      record kc_flatTube_IN_var
        "Input record for function kc_heatExchanger and kc_heatExchanger_KC"
        extends Modelica.Icons.Record;

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;

        //input variable (mass flow rate)
        SI.MassFlowRate m_flow annotation (Dialog(group="Input"));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube\"> kc_flatTube </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_KC\"> kc_flatTube_KC </a>.
</html>"));

      end kc_flatTube_IN_var;

      function kc_roundTube

        //SOURCE: A.M. Jacobi, Y. Park, D. Tafti, X. Zhang. AN ASSESSMENT OF THE STATE OF THE ART, AND POTENTIAL DESIGN IMPROVEMENTS, FOR FLAT-TUBE HEAT EXCHANGERS IN AIR CONDITIONING AND REFRIGERATION APPLICATIONS - PHASE I

        //icon

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_con
          IN_con "Input record for function kc_roundTube"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_var
          IN_var "Input record for function kc_roundTube"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results"
          annotation (Dialog(group="Output"));

      protected
        type TYP =
            Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_roundTubes;

        SI.Area A_c=IN_con.A_fr*((IN_con.F_p*IN_con.P_t - IN_con.F_p*IN_con.D_c - (
            IN_con.P_t - IN_con.D_c)*IN_con.delta_f)/(IN_con.F_p*IN_con.P_t))
          "Minimum flow cross-sectional area";
        SI.Area A_tot=if IN_con.geometry == TYP.LouverFin then IN_con.A_fr*((IN_con.N
            *PI*IN_con.D_c*(IN_con.F_p - IN_con.delta_f) + 2*(IN_con.P_t*IN_con.L -
            IN_con.N*PI*IN_con.D_c^2/4))/(IN_con.P_t*IN_con.F_p)) else 0
          "Total heat transfer area";
        SI.Length D_h=if IN_con.geometry == TYP.LouverFin then 4*A_c*IN_con.L/A_tot else
                  0 "Hydraulic diameter";

        /*SI.Length D_h=
    if IN_con.geometry==2 then
      4*A_c/(IN_con.A_fr*(2*(IN_con.P_t-IN_con.D_c+IN_con.F_p)/(IN_con.F_p*(IN_con.P_t-IN_con.D_c)))) else
      0 "Hydraulic diameter";*/

      algorithm
        kc := Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_KC(IN_con,
          IN_var);
        Pr := abs(IN_var.eta*IN_var.cp/IN_var.lambda);

        if IN_con.geometry == TYP.PlainFin or IN_con.geometry == TYP.LouverFin or
            IN_con.geometry == TYP.SlitFin or IN_con.geometry == TYP.WavyFin then
          Re := max(1e-3, abs(IN_var.m_flow)*IN_con.D_c/(IN_var.eta*A_c));
          Nu := max(1e-3, kc*IN_con.D_c/IN_var.lambda);
        end if;

        failureStatus := if IN_con.geometry == TYP.PlainFin then if Re < 300 or Re >
          8000 then 1 else 0 else if IN_con.geometry == TYP.LouverFin then if Re <
          300 or Re > 7000 then 1 else 0 else if IN_con.geometry == TYP.SlitFin then
          if Re < 400 or Re > 7000 then 1 else 0 else if IN_con.geometry == TYP.WavyFin then
                if Re < 350 or Re > 7000 then 1 else 0 else 0;

        annotation (smoothOrder=5, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for the air-side heat transfer of heat exchangers with round tubes and several fin geometries.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> According to the kind of fin geometry the calculation is valid in a range of <b> Re</b> from 300 to 8000. </li>
<li> medium = air </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/heatExchanger/pic_roundTube.png\", width=850>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc </b> for heat exchanger is calculated through the corresponding Coulburn factor <b> j </b>:

<pre>
    j = f(geometry, Re)
</pre>

<p>
with the resulting mean convective heat transfer coefficient <b> kc </b>
</p>

<p>
<pre>
    kc =  j * Re * Pr^(1/3) * lambda / D_c
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> D_c                        </b></td><td> as fin collar diameter [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> Nu = kc*D_c/lambda         </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*D_c/eta         </b></td><td> as Reynolds number [-],</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> is shown below for different fin geometries at similar dimensions.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/heatExchanger/fig_roundTube_kc.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>C.-C. Wang, C.-T. Chang:</dt>
    <dd><b>Heat and mass transfer for plate fin-and-tube heat exchangers, with and without hydrophilic coating</b>.
    In International Journal of Heat and Mass Transfer, volume 41, pages 3109-3120, 1998.</dd>
 <dt>C.-C. Wang, C.-J. Lee, C.-T. Chang, S.-P. Lina:</dt>
    <dd><b>Heat transfer and friction correlation for compact louvered fin-and-tube heat exchangers</b>.
    In International Journal of Heat and Mass Transfer, volume 42, pages 1945-1956, 1999.</dd>
 <dt>C.-C. Wang, W.-H. Tao, C.-J. Chang:</dt>
    <dd><b>An investigation of the airside performance of the slit fin-and-tube heat exchangers</b>.
    In International Journal of Refrigeration, volume 22, pages 595-603, 1999.</dd>
 <dt>C.-C. Wang, W.-L. Fu, C.-T. Chang:</dt>
    <dd><b>Heat Transfer and Friction Characteristics of Typical Wavy Fin-and-Tube Heat Exchangers</b>.
    In Experimental Thermal and Fluid Science, volume 14, pages 174-186, 1997.</dd>
</dl>

</html>
"));
      end kc_roundTube;

      function kc_roundTube_KC

        //SOURCE: A.M. Jacobi, Y. Park, D. Tafti, X. Zhang. AN ASSESSMENT OF THE STATE OF THE ART, AND POTENTIAL DESIGN IMPROVEMENTS, FOR FLAT-TUBE HEAT EXCHANGERS IN AIR CONDITIONING AND REFRIGERATION APPLICATIONS - PHASE I

        //icon

        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_con
          IN_con "Input record for function kc_roundTube_KC"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_var
          IN_var "Input record for function kc_roundTube_KC"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Output for function kc_roundTube_KC";

      protected
        type TYP =
            Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_roundTubes;

        Real MIN=Modelica.Constants.eps;

        SI.ReynoldsNumber Re_Dc=max(1e-3, abs(IN_var.m_flow)*IN_con.D_c/(IN_var.eta*
            A_c)) "Reynolds number based on fin collar diameter";
        SI.PrandtlNumber Pr=IN_var.eta*IN_var.cp/IN_var.lambda "Prandtl number";
        Real j "Colburn j faktor";

        SI.Area A_c=IN_con.A_fr*((IN_con.F_p*IN_con.P_t - IN_con.F_p*IN_con.D_c - (
            IN_con.P_t - IN_con.D_c)*IN_con.delta_f)/(IN_con.F_p*IN_con.P_t))
          "Minimum flow cross-sectional area";
        SI.Area A_tot=if IN_con.geometry == TYP.LouverFin then IN_con.A_fr*((IN_con.N
            *PI*IN_con.D_c*(IN_con.F_p - IN_con.delta_f) + 2*(IN_con.P_t*IN_con.L -
            IN_con.N*PI*IN_con.D_c^2/4))/(IN_con.P_t*IN_con.F_p)) else 0
          "Total heat transfer area";
        SI.Length D_h=if IN_con.geometry == TYP.LouverFin then 4*A_c*IN_con.L/A_tot else
                  0 "Hydraulic diameter";

        /*SI.Length D_h=
    if IN_con.geometry==2 then
      4*A_c/(IN_con.A_fr*(2*(IN_con.P_t-IN_con.D_c+IN_con.F_p-IN_con.delta_f)/(IN_con.F_p*IN_con.P_t))) else
      0 "Hydraulic diameter";*/

        Real J1=0 "Exponent for computation of Colburn j faktor";
        Real J2=0 "Exponent for computation of Colburn j faktor";
        Real J3=0 "Exponent for computation of Colburn j faktor";
        Real J4=0 "Exponent for computation of Colburn j faktor";
        Real J5=0 "Exponent for computation of Colburn j faktor";
        Real J6=0 "Exponent for computation of Colburn j faktor";
        Real J7=0 "Exponent for computation of Colburn j faktor";
        Real J8=0 "Exponent for computation of Colburn j faktor";

      algorithm
        if IN_con.geometry == TYP.PlainFin then
          j := 0.991*(2.24*Re_Dc^(-0.092)*(IN_con.N/4)^(-0.031))^(0.607*(4 - IN_con.N))
            *(0.14*Re_Dc^(-0.328)*(IN_con.P_t/IN_con.P_l)^(-0.502)*(IN_con.F_p/IN_con.D_c)
            ^(0.0312))*(2.55*(IN_con.P_l/IN_con.D_c)^(-1.28));
          kc := j*(Re_Dc*Pr^(1/3)*IN_var.lambda/IN_con.D_c);

        elseif IN_con.geometry == TYP.LouverFin then
          if Re_Dc < 900 then
            J1 := -0.991 - 0.1055*(IN_con.P_l/IN_con.P_t)^3.1*ln(IN_con.L_h/IN_con.L_p);
            J2 := -0.7344 + 2.1059*IN_con.N^0.55/(ln(Re_Dc) - 3.2);
            J3 := 0.08485*(IN_con.P_l/IN_con.P_t)^(-4.4)*IN_con.N^(-0.68);
            J4 := -0.1741*ln(IN_con.N);
            j := 14.3117*Re_Dc^J1*(IN_con.F_p/IN_con.D_c)^J2*(IN_con.L_h/IN_con.L_p)^
              J3*(IN_con.F_p/IN_con.P_l)^J4*(IN_con.P_l/IN_con.P_t)^(-1.724);
          elseif Re_Dc > 1100 then
            J5 := -0.6027 + 0.02593*(IN_con.P_l/D_h)^0.52*IN_con.N^(-0.5)*ln(IN_con.L_h
              /IN_con.L_p);
            J6 := -0.4776 + 0.40774*IN_con.N^0.7/(ln(Re_Dc) - 4.4);
            J7 := -0.58655*(IN_con.F_p/D_h)^2.3*(IN_con.P_l/IN_con.P_t)^(-1.6)*IN_con.N
              ^(-0.65);
            J8 := 0.0814*(ln(Re_Dc) - 3);
            j := 1.1373*Re_Dc^J5*(IN_con.F_p/IN_con.P_l)^J6*(IN_con.L_h/IN_con.L_p)^
              J7*(IN_con.P_l/IN_con.P_t)^J8*IN_con.N^0.3545;
          else
            J1 := -0.991 - 0.1055*(IN_con.P_l/IN_con.P_t)^3.1*ln(IN_con.L_h/IN_con.L_p);
            J2 := -0.7344 + 2.1059*IN_con.N^0.55/(ln(Re_Dc) - 3.2);
            J3 := 0.08485*(IN_con.P_l/IN_con.P_t)^(-4.4)*IN_con.N^(-0.68);
            J4 := -0.1741*ln(IN_con.N);
            J5 := -0.6027 + 0.02593*(IN_con.P_l/D_h)^0.52*IN_con.N^(-0.5)*ln(IN_con.L_h
              /IN_con.L_p);
            J6 := -0.4776 + 0.40774*IN_con.N^0.7/(ln(Re_Dc) - 4.4);
            J7 := -0.58655*(IN_con.F_p/D_h)^2.3*(IN_con.P_l/IN_con.P_t)^(-1.6)*IN_con.N
              ^(-0.65);
            J8 := 0.0814*(ln(Re_Dc) - 3);
            j := SMOOTH(
              900,
              1100,
              Re_Dc)*(14.3117*Re_Dc^J1*(IN_con.F_p/IN_con.D_c)^J2*(IN_con.L_h/IN_con.L_p)
              ^J3*(IN_con.F_p/IN_con.P_l)^J4*(IN_con.P_l/IN_con.P_t)^(-1.724)) +
              SMOOTH(
              1100,
              900,
              Re_Dc)*(1.1373*Re_Dc^J5*(IN_con.F_p/IN_con.P_l)^J6*(IN_con.L_h/IN_con.L_p)
              ^J7*(IN_con.P_l/IN_con.P_t)^J8*IN_con.N^0.3545);
          end if;
          kc := SMOOTH(
            100,
            0,
            Re_Dc)*j*(Re_Dc*Pr^(1/3)*IN_var.lambda/IN_con.D_c);

        elseif IN_con.geometry == TYP.SlitFin then
          J1 := -0.674 + 0.1316*IN_con.N/ln(Re_Dc) - 0.3769*IN_con.F_p/IN_con.D_c -
            1.8857*IN_con.N/Re_Dc;
          J2 := -0.0178 + 0.996*IN_con.N/ln(Re_Dc) + 26.7*IN_con.N/Re_Dc;
          J3 := 1.865 + 1244.03*IN_con.F_p/(Re_Dc*IN_con.D_c) - 14.37/ln(Re_Dc);
          j := 1.6409*Re_Dc^J1*(IN_con.S_p/IN_con.S_h)^1.16*(IN_con.P_t/IN_con.P_l)^
            1.37*(IN_con.F_p/IN_con.D_c)^J2*IN_con.N^J3;
          kc := j*(Re_Dc*Pr^(1/3)*IN_var.lambda/IN_con.D_c);

        elseif IN_con.geometry == TYP.WavyFin then
          if Re_Dc < exp(2.921) then
            j := 1.201/(ln(exp(2.921)^(A_c/IN_con.A_fr)))^2.921;
            kc := j*(exp(2.921)*Pr^(1/3)*IN_var.lambda/IN_con.D_c);
          else
            j := 1.201/((ln(Re_Dc^(A_c/IN_con.A_fr)))^2.921);
            kc := j*(Re_Dc*Pr^(1/3)*IN_var.lambda/IN_con.D_c);
          end if;

        else

        end if;

        annotation (smoothOrder=5, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for the air-side heat transfer of heat exchangers with round tubes and several fin geometries.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> According to the kind of fin geometry the calculation is valid in a range of <b> Re</b> from 300 to 8000. </li>
<li> medium = air </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/heatExchanger/pic_roundTube.png\", width=800>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc </b> for heat exchanger is calculated through the corresponding Coulburn factor <b> j </b>:

<pre>
    j = f(geometry, Re)
</pre>

<p>
with the resulting mean convective heat transfer coefficient <b> kc </b>
</p>

<p>
<pre>
    kc =  j * Re * Pr^(1/3) * lambda / D_c
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> D_c                        </b></td><td> as fin collar diameter [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> Nu = kc*D_c/lambda         </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*D_c/eta         </b></td><td> as Reynolds number [-],</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> for the plain and wavy fin heat exchanger is shown in the figure below. Here the figures are calculated for an (unintended) inverse calculation, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <b> kc </b>. The calculation for the louver and slit fin are too complex for inverting.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/heatExchanger/fig_roundTube_kc_KC.png\">

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube\"> kc_roundTube </a> is also valid for this inverse calculation due to using the same functions.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>C.-C. Wang, C.-T. Chang:</dt>
    <dd><b>Heat and mass transfer for plate fin-and-tube heat exchangers, with and without hydrophilic coating</b>.
    In International Journal of Heat and Mass Transfer, volume 41, pages 3109-3120, 1998.</dd>
 <dt>C.-C. Wang, C.-J. Lee, C.-T. Chang, S.-P. Lina:</dt>
    <dd><b>Heat transfer and friction correlation for compact louvered fin-and-tube heat exchangers</b>.
    In International Journal of Heat and Mass Transfer, volume 42, pages 1945-1956, 1999.</dd>
 <dt>C.-C. Wang, W.-H. Tao, C.-J. Chang:</dt>
    <dd><b>An investigation of the airside performance of the slit fin-and-tube heat exchangers</b>.
    In International Journal of Refrigeration, volume 22, pages 595-603, 1999.</dd>
 <dt>C.-C. Wang, W.-L. Fu, C.-T. Chang:</dt>
    <dd><b>Heat Transfer and Friction Characteristics of Typical Wavy Fin-and-Tube Heat Exchangers</b>.
    In Experimental Thermal and Fluid Science, volume 14, pages 174-186, 1997.</dd>
</dl>

</html>
"));
      end kc_roundTube_KC;

      record kc_roundTube_IN_con
        "Input record for function kc_roundTube and kc_roundTube_KC"
        extends Modelica.Icons.Record;

        Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_roundTubes
          geometry =                                                               Dissipation.Utilities.Types.HTXGeometry_roundTubes.PlainFin
          "Choice of fin geometry" annotation (Dialog(group="HeatExchanger"));

        SI.Area A_fr=0 "Frontal area" annotation (Dialog(group="HeatExchanger"));
        SI.Length D_c=0 "Fin collar diameter"
          annotation (Dialog(group="HeatExchanger"));
        SI.Length F_p=0 "Fin pitch, fin spacing + fin thickness"
          annotation (Dialog(group="HeatExchanger"));
        SI.Length L=0 "Heat exchanger length" annotation (Dialog(group=
                "HeatExchanger", enable=if geometry == 2 then true else false));
        SI.Length L_h=0 "Louver height" annotation (Dialog(group="HeatExchanger",
              enable=if geometry == 2 then true else false));
        SI.Length L_p=0 "Louver pitch" annotation (Dialog(group="HeatExchanger",
              enable=if geometry == 2 then true else false));
        Integer N=0 "Number of tube rows" annotation (Dialog(group="HeatExchanger",
              enable=if geometry == 1 or geometry == 2 or geometry == 3 then true else
                      false));
        SI.Length P_d=0 "Pattern depth of wavy fin, wave height" annotation (Dialog(
              group="HeatExchanger", enable=if geometry == 4 then true else false));
        SI.Length P_l=0 "Longitudinal tube pitch" annotation (Dialog(group=
                "HeatExchanger", enable=if geometry == 1 or geometry == 2 or geometry
                 == 3 then true else false));
        SI.Length P_t=0 "Transverse tube pitch"
          annotation (Dialog(group="HeatExchanger"));
        SI.Length S_h=0 "Slit height" annotation (Dialog(group="HeatExchanger",
              enable=if geometry == 3 then true else false));
        SI.Length S_p=0 "Slit pitch" annotation (Dialog(group="HeatExchanger", enable=
               if geometry == 3 then true else false));
        SI.Length X_f=0 "Half wave length of wavy fin" annotation (Dialog(group=
                "HeatExchanger", enable=if geometry == 4 then true else false));

        SI.Length delta_f=0 "Fin thickness" annotation (Dialog(group="HeatExchanger"));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube\"> kc_roundTube </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_KC\"> kc_roundTube_KC </a>.
</html>"));

      end kc_roundTube_IN_con;

      record kc_roundTube_IN_var
        "Input record for function kc_roundTube and kc_roundTube_KC"
        extends Modelica.Icons.Record;

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;

        //input variable (mass flow rate)
        SI.MassFlowRate m_flow annotation (Dialog(group="Input"));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube\"> kc_roundTube </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_KC\"> kc_roundTube_KC </a>.
</html>"));

      end kc_roundTube_IN_var;
    end HeatExchanger;

    package HelicalPipe
    extends Modelica.Icons.VariantsPackage;

      function kc_laminar
        "Mean heat transfer coefficient of helical pipe | laminar flow regime"

        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //Notation of equations according to SOURCE

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.HelicalPipe1_d;

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_con
          IN_con "Input record for function kc_laminar"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_var
          IN_var "Input record for function kc_laminar"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results"
          annotation (Dialog(group="Output"));

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=IN_con.d_hyd "Hydraulic diameter";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Circular cross sectional area";
        SI.Diameter d_s=IN_con.L/(IN_con.n_nt*PI) "Mean coil diameter";
        SI.Diameter d_w=sqrt(max(MIN, (d_s^2 - (IN_con.h/PI)^2)))
          "Mean helical pipe diameter";
        SI.Diameter d_coil=max(d_w, d_w*(1 + (IN_con.h/(PI*d_w))^2))
          "Mean curvature diameter of helical pipe";
        SI.ReynoldsNumber Re_crit=2300*(1 + 8.6*(IN_con.d_hyd/d_coil)^0.45)
          "Critical Reynolds number";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity";

        //failure status
        Real fstatus[1] "Check of expected boundary conditions";

        //Documentation
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
        Re := max(1, abs(IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta)));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_KC(IN_con, IN_var);
        Nu := kc*IN_con.d_hyd/max(MIN, IN_var.lambda);

        //failure status
        fstatus[1] := if Re > Re_crit then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for a helical pipe in the laminar flow regime.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> laminar regime (Reynolds number &le; critical Reynolds number <b> Re_crit</b>) </li>
<li> neglect influence of heat transfer direction (heating/cooling) according to <i>Sieder and Tate </i> </li>
</ul>

The critical Reynolds number <b> Re_crit </b> in a helical pipe depends on its mean curvature diameter <b> d_coil </b>. The smaller the mean curvature diameter of the helical pipe, the earlier the turbulent regime will start due to vortexes out of higher centrifugal forces.

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/pic_helicalPipe.png\">


<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc </b> for helical pipes is calculated through the corresponding Nusselt number <b> Nu </b> according to <i>[VDI 2002, p. Gc 2, eq. 5]</i> :

<pre>
    Nu = 3.66 + 0.08*[1 + 0.8*(d_hyd/d_coil)^0.9]*Re^m*Pr^(1/3)
</pre>

<p>
with the exponent <b> m </b> for the Reynolds number
</p>

<p>
<pre>
    m = 0.5 + 0.2903*(d_hyd/d_coil)^0.194
</pre>
</p>

<p>
and the resulting mean convective heat transfer coefficient <b> kc </b>
</p>

<p>
<pre>
    kc =  Nu * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_mean                     </b></td><td> as mean diameter of helical pipe [m],</td></tr>
<tr><td><b> d_coil = f(geometry)       </b></td><td> as mean curvature diameter of helical pipe [m],</td></tr>
<tr><td><b> d_hyd                      </b></td><td> as hydraulic diameter of the helical pipe [m],</td></tr>
<tr><td><b> h                          </b></td><td> as slope of helical pipe [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L                          </b></td><td> as total length of helical pipe [m],</td></tr>
<tr><td><b> Nu = kc*d_hyd/lambda       </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta       </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> Re_crit = f(geometry)      </b></td><td> as critical Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> is shown below for different numbers of turns <b> n_nt </b> at constant total length of the helical pipe.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/fig_helicalPipe_kc_laminar.png\">

<p>
The convective heat transfer of a helical pipe is enhanced compared to a straight pipe due to occurring turbulences resulting out of centrifugal forces. The higher the number of turns, the better is the convective heat transfer for the same length of a pipe.
</p>

<p>
Note that the ratio of hydraulic diameter to total length of helical pipe <b> d_hyd/L </b> has no remarkable influence on the coefficient of heat transfer <b> kc </b>.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>GNIELINSKI, V.:</dt>
    <dd><b>Heat transfer and pressure drop in helically coiled tubes.</b>.
    In 8th International Heat Transfer Conference, volume 6, pages 2847-2854, Washington,1986. Hemisphere.</dd>
</dl>

</html>
"));
      end kc_laminar;

      function kc_laminar_KC
        "Mean heat transfer coefficient of helical pipe | hydrodynamically developed laminar flow regime"

        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //Notation of equations according to SOURCE

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.HelicalPipe1_d;

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_con
          IN_con "Input record for function kc_laminar_KC"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_var
          IN_var "Input record for function kc_laminar_KC"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Output for function kc_laminar_KC";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=IN_con.d_hyd "Hydraulic diameter";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Circular cross sectional area";
        SI.Diameter d_s=IN_con.L/(IN_con.n_nt*PI) "Mean coil diameter";
        SI.Diameter d_w=sqrt(max(MIN, (d_s^2 - (IN_con.h/PI)^2)))
          "Mean helical pipe diameter";
        SI.Diameter d_coil=max(d_w, d_w*(1 + (IN_con.h/(PI*d_w))^2))
          "Mean curvature diameter of helical pipe";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity";
        SI.ReynoldsNumber Re=max(1, IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        Real m=0.5 + 0.2903*(IN_con.d_hyd/d_coil)^0.194
          "Exponent for actual Reynolds number";

        //Documentation
      algorithm
        kc := (IN_var.lambda/IN_con.d_hyd)*(3.66 + 0.08*(1 + 0.8*(IN_con.d_hyd/d_coil)
          ^0.9)*Re^(m)*Pr^(1/3));
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for a helical pipe in the laminar flow regime.
</p>

<p>
Generally this function is numerically best used for the calculation of the mean convective heat transfer coefficient <b> kc </b> at known mass flow rate.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> laminar regime (Reynolds number &le; critical Reynolds number <b> Re_crit</b>) </li>
<li> neglect influence of heat transfer direction (heating/cooling) according to <i>Sieder and Tate </i> </li>
</ul>

The critical Reynolds number <b> Re_crit </b> in a helical pipe depends on its mean curvature diameter <b> d_coil </b>. The smaller the mean curvature diameter of the helical pipe, the earlier the turbulent regime will start due to vortexes out of higher centrifugal forces.

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/pic_helicalPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc </b> for helical pipes is calculated through the corresponding Nusselt number <b> Nu </b> according to <i>[VDI 2002, p. Gc 2, eq. 5]</i> :

<pre>
    Nu = 3.66 + 0.08*[1 + 0.8*(d_hyd/d_coil,m)^0.9]*Re^m*Pr^(1/3)
</pre>

<p>
with the exponent <b> m </b> for the Reynolds number
</p>

<p>
<pre>
    m = 0.5 + 0.2903*(d_hyd/d_coil)^0.194
</pre>
</p>

<p>
and the resulting mean convective heat transfer coefficient <b> kc </b>
</p>

<p>
<pre>
    kc =  Nu * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_mean                     </b></td><td> as mean diameter of helical pipe [m],</td></tr>
<tr><td><b> d_coil = f(geometry)       </b></td><td> as mean curvature diameter of helical pipe [m],</td></tr>
<tr><td><b> d_hyd                      </b></td><td> as hydraulic diameter of the helical pipe [m],</td></tr>
<tr><td><b> h                          </b></td><td> as slope of helical pipe [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L                          </b></td><td> as total length of helical pipe [m],</td></tr>
<tr><td><b> Nu = kc*d_hyd/lambda       </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta       </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> Re_crit = f(geometry)      </b></td><td> as critical Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> is shown below for different numbers of turns <b> n_nt </b> at constant total length of the helical pipe.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/fig_helicalPipe_kc_laminar_KC_cpr.png\">

<p>
The convective heat transfer of a helical pipe is enhanced compared to a straight pipe due to occurring turbulences resulting out of centrifugal forces. The higher the number of turns, the better is the convective heat transfer for the same length of a pipe. Therefore there have to be a higher mass flow rate for lower number of turns to achieve the same Nusselt number <b> Nu </b> at inverse calculation.
</p>

<p>
The dependence of the mean Nusselt number <b> Nu </b> on fluid properties is shown for different Prandtl numbers <b> Pr </b> in the following figure.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/fig_helicalPipe_kc_laminar_KC_cnt.png\">

<p>
Note that a minimum mean Nusselt number <b> Nu </b> is necessary for a successful inverse
calculation. A Nusselt number as input shall not be below an asymptotic Nusselt number for
mass flow rates going to zero (see figure in <a
href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar\"> kc_laminar </a>). There will be no convergence in inverse calculation for the unknown mass flow rate
if a Nusselt number is below the minimum Nusselt number due to mathematical feasibility.
</p>

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar\">kc_laminar </a> is also valid for this inverse calculation due to using the same functions.
</p>

<p>
Note that the ratio of hydraulic diameter to total length of helical pipe <b> d_hyd/L </b> has no remarkable influence on the coefficient of heat transfer <b> kc </b>.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>GNIELINSKI, V.:</dt>
    <dd><b>Heat transfer and pressure drop in helically coiled tubes.</b>.
    In 8th International Heat Transfer Conference, volume 6, pages 2847?2854, Washington,1986. Hemisphere.</dd>
</dl>

</html>
"));
      end kc_laminar_KC;

      record kc_laminar_IN_con
        "Input record for function kc_laminar and kc_laminar_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar\"> kc_laminar </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_KC\"> kc_laminar_KC </a>.
</html>"));
      end kc_laminar_IN_con;

      record kc_laminar_IN_var
        "Input record for function kc_laminar and kc_laminar_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar\"> kc_laminar </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_KC\"> kc_laminar_KC </a>.
</html>"));
      end kc_laminar_IN_var;

      function kc_overall
        "Mean heat transfer coefficient of helical pipe | overall flow regime"

        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //Notation of equations according to SOURCE

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.HelicalPipe1_d;

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con
          IN_con "Input record for function kc_overall"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var
          IN_var "Input record for function kc_overall"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results"
          annotation (Dialog(group="Output"));

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Cross sectional area";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity";

        //Documentation
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
        Re := max(MIN, IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_KC(IN_con, IN_var);
        Nu := kc*IN_con.d_hyd/max(MIN, IN_var.lambda);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> of a helical pipe in a hydrodynamically developed overall flow regime.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> hydrodynamically developed fluid flow </li>
<li> neglect influence of heat transfer direction (heating/cooling) according to <i> Sieder and Tate </i> </li>
</ul>

The critical Reynolds number <b> Re_crit </b> in a helical pipe depends on its mean curvature diameter. The smaller the mean curvature diameter of the helical pipe <b> d_coil</b>, the earlier the turbulent regime will start due to vortexes out of higher centrifugal forces.

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/pic_helicalPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
<b> Laminar regime:</b>
The mean convective heat transfer coefficient <b> kc </b> for helical pipes in the laminar regime is calculated through the corresponding Nusselt number <b> Nu </b> according to <i>[VDI 2002, p. Gc 2, eq. 5]</i> :

<pre>
    Nu = 3.66 + 0.08*[1 + 0.8*(d_hyd/d_coil)^0.9]*Re^m*Pr^(1/3)
</pre>

<p>
with the exponent <b> m </b> for the Reynolds number
</p>

<p>
<pre>
    m = 0.5 + 0.2903*(d_hyd/d_coil)^0.194.
</pre>
</p>

<p>
The <b> transition regime </b> (2e3 &le; Reynolds number &le; 1e4) is calculated via a smoothing interpolation function.
<p>

<p>
<b> Turbulent regime: </b>
The mean convective heat transfer coefficient <b> kc </b> for helical pipes in the turbulent regime is calculated through the corresponding Nusselt number <b> Nu </b> according to <i>[VDI 2002, p. Ga 2, eq. 6]</i> :

<pre>
    Nu = (zeta_TOT/8)*Re*Pr/{1 + 12.7*(zeta_TOT/8)^0.5*[Pr^(2/3)-1]},
</pre>

<p>
where the influence of the pressure loss on the heat transfer calculation is considered through
</p>

<p>
<pre>
    zeta_TOT = 0.3164*Re^(-0.25) + 0.03*(d_hyd/d_coil)^(0.5).
</pre>
</p>
<p>
The resulting mean convective heat transfer coefficient <b> kc </b> is calculated through:
</p>

<p>
<pre>
    kc =  Nu * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_mean                     </b></td><td> as mean diameter of helical pipe [m],</td></tr>
<tr><td><b> d_coil = f(geometry)       </b></td><td> as mean curvature diameter of helical pipe [m],</td></tr>
<tr><td><b> d_hyd                      </b></td><td> as hydraulic diameter of the helical pipe [m],</td></tr>
<tr><td><b> h                          </b></td><td> as slope of helical pipe [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L                          </b></td><td> as total length of helical pipe [m],</td></tr>
<tr><td><b> Nu = kc*d_hyd/lambda       </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta       </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> Re_crit = f(geometry)      </b></td><td> as critical Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> is shown below for different numbers of turns <b> n_nt </b> at constant total length of the helical pipe.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/fig_helicalPipe_kc_overall.png\">

<p>
The convective heat transfer of a helical pipe is enhanced compared to a straight pipe due to occurring turbulences resulting out of centrifugal forces. The higher the number of turns, the better is the convective heat transfer for the same length of a pipe.
</p>

<p>
Note that the ratio of hydraulic diameter to total length of helical pipe <b> d_hyd/L </b> has no remarkable influence on the coefficient of heat transfer <b> kc </b>.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>GNIELINSKI, V.:</dt>
    <dd><b>Heat transfer and pressure drop in helically coiled tubes.</b>.
    In 8th International Heat Transfer Conference, volume 6, pages 2847?2854, Washington,1986. Hemisphere.</dd>
</dl>
</html>

"));
      end kc_overall;

      function kc_overall_KC
        "Mean heat transfer coefficient of helical pipe | overall flow regime"

        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //Notation of equations according to SOURCE

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.HelicalPipe1_d;

        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con
          IN_con "Input record for function kc_overall_KC"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var
          IN_var "Input record for function kc_overall_KC"
          annotation (Dialog(group="Variable inputs"));
        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Output for function kc_overall_KC";

      protected
        Real MIN=Modelica.Constants.eps;
        Real laminar=2e3 "Maximum Reynolds number for laminar regime";
        Real turbulent=2.2e4 "Minimum Reynolds number for turbulent regime";

        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Cross sectional area";
        SI.Diameter d_s=max(1e-6, IN_con.L/(IN_con.n_nt*PI))
          "Mean coil diameter";
        SI.Diameter d_w=sqrt(max(MIN, abs(d_s^2 - (IN_con.h/PI)^2)))
          "Mean helical pipe diameter";
        SI.Diameter d_coil=d_w*(1 + (IN_con.h/(PI*d_w))^2)
          "Mean curvature diameter of helical pipe";
        SI.ReynoldsNumber Re_crit=min(4e3, 2300*(1 + 8.6*(IN_con.d_hyd/d_coil)^0.45))
          "Critical Reynolds number";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity";
        SI.ReynoldsNumber Re=max(1e-3, IN_var.rho*velocity*IN_con.d_hyd/max(MIN,
            IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        //Documentation
      algorithm
        kc := SMOOTH(
                Re_crit,
                turbulent,
                Re)*Dissipation.HeatTransfer.HelicalPipe.kc_laminar_KC(IN_con,
          IN_var) + SMOOTH(
                turbulent,
                Re_crit,
                Re)*Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_KC(IN_con,
          IN_var);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> of a helical pipe in a hydrodynamically developed overall flow regime.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> hydrodynamically developed fluid flow </li>
<li> neglect influence of heat transfer direction (heating/cooling) according to <i> Sieder and Tate </i> </li>
</ul>

<p>
The critical Reynolds number <b> Re_crit </b> in a helical pipe depends on its mean curvature diameter. The smaller the mean curvature diameter of the helical pipe <b> d_coil</b>, the earlier the turbulent regime will start due to vortexes out of higher centrifugal forces.</p>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/pic_helicalPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
<b> Laminar regime:</b>
The mean convective heat transfer coefficient <b> kc </b> for helical pipes in the laminar regime is calculated through the corresponding Nusselt number <b> Nu </b> according to <i>[VDI 2002, p. Gc 2, eq. 5]</i> :

<pre>
    Nu = 3.66 + 0.08*[1 + 0.8*(d_hyd/d_coil)^0.9]*Re^m*Pr^(1/3)
</pre>

<p>
with the exponent <b> m </b> for the Reynolds number
</p>

<p>
<pre>
    m = 0.5 + 0.2903*(d_hyd/d_coil)^0.194.
</pre>
</p>

<p>
The <b> transition regime </b> (2e3 &le; Reynolds number &le; 1e4) is calculated via a smoothing interpolation function.
<p>

<p>
<b> Turbulent regime: </b>
The mean convective heat transfer coefficient <b> kc </b> for helical pipes in the turbulent regime is calculated through the corresponding Nusselt number <b> Nu </b> according to <i>[VDI 2002, p. Ga 2, eq. 6]</i> :

<pre>
    Nu = (zeta_TOT/8)*Re*Pr/{1 + 12.7*(zeta_TOT/8)^0.5*[Pr^(2/3)-1]},
</pre>

<p>
where the influence of the pressure loss on the heat transfer calculation is considered through
</p>

<p>
<pre>
    zeta_TOT = 0.3164*Re^(-0.25) + 0.03*(d_hyd/d_coil)^(0.5).
</pre>
</p>
<p>
The resulting mean convective heat transfer coefficient <b> kc </b> is calculated through:
</p>

<p>
<pre>
    kc =  Nu * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_mean                     </b></td><td> as mean diameter of helical pipe [m],</td></tr>
<tr><td><b> d_coil = f(geometry)       </b></td><td> as mean curvature diameter of helical pipe [m],</td></tr>
<tr><td><b> d_hyd                      </b></td><td> as hydraulic diameter of the helical pipe [m],</td></tr>
<tr><td><b> h                          </b></td><td> as slope of helical pipe [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L                          </b></td><td> as total length of helical pipe [m],</td></tr>
<tr><td><b> Nu = kc*d_hyd/lambda       </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta       </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> Re_crit = f(geometry)      </b></td><td> as critical Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> is shown below for different numbers of turns <b> n_nt </b> at constant total length of the helical pipe.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/fig_helicalPipe_kc_overall_KC_cpr.png\">

<p>
The convective heat transfer of a helical pipe is enhanced compared to a straight pipe due to occurring turbulences resulting out of centrifugal forces. The higher the number of turns, the better is the convective heat transfer for the same length of a pipe. Therefore there have to be a higher mass flow rate for lower number of turns to achieve the same Nusselt number <b> Nu </b> at inverse calculation.
</p>

<p>
The dependence of the mean Nusselt number <b> Nu </b> on fluid properties is shown for different Prandtl numbers <b> Pr </b> in the following figure.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/fig_helicalPipe_kc_overall_KC_cnt.png\">

<p>
Note that a minimum mean Nusselt number <b> Nu </b> is necessary for a successful inverse
calculation. A Nusselt number as input shall not be below an asymptotic Nusselt number for
mass flow rates going to zero (see figure in <a
href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall\"> kc_overall </a>). There will be no convergence in inverse calculation for the unknown mass flow rate
if a Nusselt number is below the minimum Nusselt number due to mathematical feasibility.
</p>

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall\">kc_overall </a> is also valid for this inverse calculation due to using the same functions.
</p>

<p>
Note that the ratio of hydraulic diameter to total length of helical pipe <b> d_hyd/L </b> has no remarkable influence on the coefficient of heat transfer <b> kc </b>.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>GNIELINSKI, V.:</dt>
    <dd><b>Heat transfer and pressure drop in helically coiled tubes.</b>.
    In 8th International Heat Transfer Conference, volume 6, pages 2847?2854, Washington,1986. Hemisphere.</dd>
</dl>
</html>

"));
      end kc_overall_KC;

      record kc_overall_IN_con
        "Input record for function kc_overall and kc_overall_KC"

        //helical pipe variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.HelicalPipe;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall\"> kc_overall </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_KC\"> kc_overall_KC </a>.
</html>"));
      end kc_overall_IN_con;

      record kc_overall_IN_var
        "Input record for function kc_overall and kc_overall_KC"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;

        //input variable (mass flow rate)
        SI.MassFlowRate m_flow annotation (Dialog(group="Input"));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall\"> kc_overall </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_KC\"> kc_overall_KC </a>.
</html>"));
      end kc_overall_IN_var;

      function kc_turbulent
        "Mean heat transfer coefficient of helical pipe | hydrodynamically developed turbulent flow regime"

        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //Notation of equations according to SOURCE

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.HelicalPipe1_d;

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_con
          IN_con "Input record for function  kc_turbulent"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_var
          IN_var "Input record for function  kc_turbulent"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results"
          annotation (Dialog(group="Output"));

      protected
        Real MIN=Modelica.Constants.eps;

        Real turbulent=2.2e4 "Minimum Reynolds number for turbulent regime";

        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Cross sectional area";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity";

        //failure status
        Real fstatus[1] "Check of expected boundary conditions";

        //Documentation
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/IN_var.lambda);
        Re := max(1e-3, abs(IN_var.rho*velocity*IN_con.d_hyd/IN_var.eta));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_KC(IN_con, IN_var);
        Nu := kc*IN_con.d_hyd/max(MIN, IN_var.lambda);

        //failure status
        fstatus[1] := if Re < turbulent then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> of a helical pipe for turbulent flow regime.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> turbulent regime (Reynolds number &ge; critical Reynolds number <b> Re_crit </b>) </li>
<li> neglect influence of heat transfer direction (heating/cooling) according to <i> Sieder and Tate </i> </li>
</ul>

The critical Reynolds number <b> Re_crit </b> in a helical pipe depends on its mean curvature diameter. The smaller the mean curvature diameter of the helical pipe <b> d_mean </b>, the earlier the turbulent regime will start due to vortexes out of higher centrifugal forces.

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/pic_helicalPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc </b> for helical pipes is calculated through the corresponding Nusselt number <b> Nu </b> according to <i>[VDI 2002, p. Ga 2, eq. 6]</i> :

<pre>
    Nu = (zeta_TOT/8)*Re*Pr/{1 + 12.7*(zeta_TOT/8)^0.5*[Pr^(2/3)-1]},
</pre>

<p>
where the influence of the pressure loss on the heat transfer calculation is considered through
</p>

<p>
<pre>
    zeta_TOT = 0.3164*Re^(-0.25) + 0.03*(d_hyd/d_coil)^(0.5) and
</pre>
</p>

<p>
and the resulting mean convective heat transfer coefficient <b> kc </b>
</p>

<p>
<pre>
    kc =  Nu * lambda / d_hyd
</pre>
</p>
<p>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_mean                     </b></td><td> as mean diameter of helical pipe [m],</td></tr>
<tr><td><b> d_coil = f(geometry)       </b></td><td> as mean curvature diameter of helical pipe [m],</td></tr>
<tr><td><b> d_hyd                      </b></td><td> as hydraulic diameter of the helical pipe [m],</td></tr>
<tr><td><b> h                          </b></td><td> as slope of helical pipe [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L                          </b></td><td> as total length of helical pipe [m],</td></tr>
<tr><td><b> Nu = kc*d_hyd/lambda       </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta       </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> Re_crit = f(geometry)      </b></td><td> as critical Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> is shown below for different numbers of turns <b> n_nt </b> at constant total length of the helical pipe.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/fig_helicalPipe_kc_turbulent.png\">

<p>
The convective heat transfer of a helical pipe is enhanced compared to a straight pipe due to occurring turbulences resulting out of centrifugal forces. The higher the number of turns, the better is the convective heat transfer for the same length of a pipe.
</p>

<p>
Note that the ratio of hydraulic diameter to total length of helical pipe <b> d_hyd/L </b> has no remarkable influence on the coefficient of heat transfer <b> kc </b>.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>GNIELINSKI, V.:</dt>
    <dd><b>Heat transfer and pressure drop in helically coiled tubes.</b>.
    In 8th International Heat Transfer Conference, volume 6, pages 2847?2854, Washington,1986. Hemisphere.</dd>
</dl>
</html>

"));
      end kc_turbulent;

      function kc_turbulent_KC
        "Mean heat transfer coefficient of helical pipe | hydrodynamically developed turbulent flow regime"

        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //Notation of equations according to SOURCE

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.HelicalPipe1_d;

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_con
          IN_con "Input record for function kc_turbulent_KC"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_var
          IN_var "Input record for function kc_turbulent_KC"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Output for function kc_turbulent_KC";

      protected
        Real MIN=Modelica.Constants.eps;
        Real turbulent=2.2e4 "Minimum Reynolds number for turbulent regime";

        SI.Diameter d_hyd=IN_con.d_hyd "Hydraulic diameter";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Circular cross sectional area";
        SI.Diameter d_s=IN_con.L/(IN_con.n_nt*PI) "Mean coil diameter";
        SI.Diameter d_w=sqrt(max(MIN, (d_s^2 - (IN_con.h/PI)^2)))
          "Mean helical pipe diameter";
        SI.Diameter d_coil=max(d_w, d_w*(1 + (IN_con.h/(PI*d_w))^2))
          "Mean curvature diameter of helical pipe";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity";
        SI.ReynoldsNumber Re=max(1e-3, IN_var.rho*velocity*IN_con.d_hyd/max(MIN,
            IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        Real zeta_TOT=0.3164*max(turbulent, Re)^(-0.25) + 0.03*sqrt(IN_con.d_hyd/
            d_coil) "Pressure loss coefficient";

        //Documentation
      algorithm
        kc := (IN_var.lambda/IN_con.d_hyd)*(zeta_TOT/8)*Re*Pr/(1 + 12.7*sqrt(zeta_TOT
          /8)*(Pr^(2/3) - 1));
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> of a helical pipe for turbulent flow regime.
</p>

<p>
Generally this function is numerically best used for the calculation of the mean convective heat transfer coefficient <b> kc </b> at known mass flow rate.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> turbulent regime (Reynolds number &ge; critical Reynolds number <b> Re_crit </b>) </li>
<li> neglect influence of heat transfer direction (heating/cooling) according to <i> Sieder and Tate </i> </li>
</ul>

<p>
The critical Reynolds number <b> Re_crit </b> in a helical pipe depends on its mean curvature diameter. The smaller the mean curvature diameter of the helical pipe <b> d_mean </b>, the earlier the turbulent regime will start due to vortexes out of higher centrifugal forces.
</p>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/pic_helicalPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc </b> for helical pipes is calculated through the corresponding Nusselt number <b> Nu </b> according to <i>[VDI 2002, p. Ga 2, eq. 6]</i> :

<pre>
    Nu = (zeta_TOT/8)*Re*Pr/{1 + 12.7*(zeta_TOT/8)^0.5*[Pr^(2/3)-1]},
</pre>

<p>
where the influence of the pressure loss on the heat transfer calculation is considered through
</p>

<p>
<pre>
    zeta_TOT = 0.3164*Re^(-0.25) + 0.03*(d_hyd/d_coil)^(0.5) and
</pre>
</p>

<p>
and the resulting mean convective heat transfer coefficient <b> kc </b>
</p>

<p>
<pre>
    kc =  Nu * lambda / d_hyd
</pre>
</p>
<p>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_mean                     </b></td><td> as mean diameter of helical pipe [m],</td></tr>
<tr><td><b> d_coil = f(geometry)       </b></td><td> as mean curvature diameter of helical pipe [m],</td></tr>
<tr><td><b> d_hyd                      </b></td><td> as hydraulic diameter of the helical pipe [m],</td></tr>
<tr><td><b> h                          </b></td><td> as slope of helical pipe [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L                          </b></td><td> as total length of helical pipe [m],</td></tr>
<tr><td><b> Nu = kc*d_hyd/lambda       </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta       </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> Re_crit = f(geometry)      </b></td><td> as critical Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> is shown below for different numbers of turns <b> n_nt </b> at constant total length of the helical pipe.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/fig_helicalPipe_kc_turbulent_KC_cpr.png\">

<p>
The convective heat transfer of a helical pipe is enhanced compared to a straight pipe due to occurring turbulences resulting out of centrifugal forces. The higher the number of turns, the better is the convective heat transfer for the same length of a pipe. Therefore there have to be a higher mass flow rate for lower number of turns to achieve the same Nusselt number <b> Nu </b> at inverse calculation.
</p>

<p>
The dependence of the mean Nusselt number <b> Nu </b> on fluid properties is shown for different Prandtl numbers <b> Pr </b> in the following figure.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/fig_helicalPipe_kc_turbulent_KC_cnt.png\">

<p>
Note that a minimum mean Nusselt number <b> Nu </b> is necessary for a successful inverse
calculation. A Nusselt number as input shall not be below an asymptotic Nusselt number for
mass flow rates going to zero (see figure in <a
href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar\"> kc_laminar </a>). There will be no convergence in inverse calculation for the unknown mass flow rate
if a Nusselt number is below the minimum Nusselt number due to mathematical feasibility.
</p>

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent\">kc_turbulent </a> is also valid for this inverse calculation due to using the same functions.
</p>

<p>
Note that the ratio of hydraulic diameter to total length of helical pipe <b> d_hyd/L </b> has no remarkable influence on the coefficient of heat transfer <b> kc </b>.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>GNIELINSKI, V.:</dt>
    <dd><b>Heat transfer and pressure drop in helically coiled tubes.</b>.
    In 8th International Heat Transfer Conference, volume 6, pages 2847?2854, Washington,1986. Hemisphere.</dd>
</dl>
</html>

"));
      end kc_turbulent_KC;

      record kc_turbulent_IN_con "Input record for function kc_turbulent"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent\">  kc_turbulent </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_KC\">  kc_turbulent_KC </a>.
</html>"));
      end kc_turbulent_IN_con;

      record kc_turbulent_IN_var "Input record for function kc_turbulent"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent\">  kc_turbulent </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_KC\">  kc_turbulent_KC </a>.
</html>"));
      end kc_turbulent_IN_var;
    end HelicalPipe;

    package Plate
    extends Modelica.Icons.VariantsPackage;

      function kc_laminar
        "Mean heat transfer coefficient of plate | laminar regime"

        //SOURCE: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //Notation of equations according to SOURCE

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.Plate1_d;

        //input records
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_IN_con
          IN_con "Input record for function kc_laminar"
          annotation (Dialog(group="Constant inputs"));
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_IN_var
          IN_var "Input record for function kc_laminar"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results"
          annotation (Dialog(group="Output"));

      protected
        Real MIN=Modelica.Constants.eps;

        Real laminar=1e5 "Maximum Reynolds number of laminar flow regime";
        Real prandtlMax=2000 "Maximum Prandtl number";
        Real prandtlMin=0.6 "Minimum Prandtl number";

        //failure status
        Real fstatus[2] "Check of expected boundary conditions";

        //Documentation
      algorithm
        Pr := IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda);
        Re := max(1e-3, abs(IN_var.rho*IN_var.velocity*IN_con.L/max(MIN, IN_var.eta)));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_KC(IN_con, IN_var);
        Nu := kc*IN_con.L/max(MIN, IN_var.lambda);

        //failure status
        fstatus[1] := if Re > laminar then 1 else 0;
        fstatus[2] := if Pr > prandtlMax or Pr < prandtlMin then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for a laminar fluid flow over an even surface.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> laminar regime (Reynolds number &le; 1e5)
<li> Prandtl number 0.6 &le; Pr &le; 2000
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/plate/pic_plate.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc</b> for flat plate is calculated through the corresponding Nusselt number <b> Nu_lam</b> according to <i>[VDI 2002, p. Gd 1, eq. 1]</i> :

<pre>
    Nu_lam = 0.664 * Re^(0.5) * (Pr)^(1/3)
</pre>

<p>
and the corresponding mean convective heat transfer coefficient <b> kc </b> :
</p>

<p>
<pre>
    kc =  Nu_lam * lambda / L
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> cp                 </b></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><b> eta                </b></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><b> kc                 </b></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><b> lambda         </b></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><b> L              </b></td><td> as length of plate [m],</td></tr>
<tr><td><b> Nu_lam                  </b></td><td> as mean Nusselt number for laminar regime [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda           </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> rho          </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> Re = rho*v*L/eta    </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu </b> in the laminar regime representing the mean convective heat transfer coefficient <b> kc </b> for Prandtl numbers of different fluids is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/plate/fig_plate_kc_laminar.png\" width=\"600\">

Note that this function is best used in the laminar regime up to a Reynolds number <b> Re </b> smaller than 2300. There is a deviation w.r.t. literature due to the neglect of the turbulence influence in the transition regime even though this function is used inside its cited restrictions for a higher Reynolds number. The function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_mean_overall\">  kc_mean_overall </a> is recommended for the simulation of a Reynolds number higher than 2300.

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_laminar;

      function kc_laminar_KC
        "Mean heat transfer coefficient of plate | laminar regime"

        //SOURCE: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //Notation of equations according to SOURCE

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.Plate1_d;

        //input records
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_IN_con
          IN_con "Input record for function kc_laminar_KC"
          annotation (Dialog(group="Constant inputs"));
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_IN_var
          IN_var "Input record for function kc_laminar_KC"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Output for function kc_laminar_KC";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Length L=max(MIN, IN_con.L);

        SI.SpecificHeatCapacityAtConstantPressure cp=IN_var.cp;
        SI.DynamicViscosity eta=max(MIN, IN_var.eta);
        SI.ThermalConductivity lambda=max(MIN, IN_var.lambda);
        SI.Density rho=IN_var.rho;

        SI.Velocity velocity=abs(IN_var.velocity) "Mean velocity";
        SI.ReynoldsNumber Re=max(1e-3, rho*velocity*L/eta);
        SI.PrandtlNumber Pr=eta*cp/lambda;

        //Documentation
      algorithm
        kc := (lambda/L)*(0.664*abs(Re)^0.5*Pr^(1/3));
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for a laminar fluid flow over an even surface.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> laminar regime (Reynolds number &le; 5e5) </li>
<li> Prandtl number 0.6 &le; Pr &le; 2000 </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/plate/pic_plate.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc</b> for flat plate is calculated through the corresponding Nusselt number <b> Nu_lam</b> according to <i>[VDI 2002, p. Gd 1, eq. 1]</i> :

<pre>
    Nu_lam = 0.664 * Re^(0.5) * (Pr)^(1/3)
</pre>

<p>
and the corresponding mean convective heat transfer coefficient <b> kc </b> :
</p>

<p>
<pre>
    kc =  Nu_lam * lambda / L
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> cp          </b></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><b> eta          </b></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><b> kc          </b></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><b> lambda         </b></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><b> L              </b></td><td> as length of plate [m],</td></tr>
<tr><td><b> Nu_lam          </b></td><td> as mean Nusselt number in laminar regime [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda           </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> rho          </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> Re = v*rho*L/eta    </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number for the laminar regime <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> for Prandtl numbers of different fluids is shown in the figure below. Here the figures are calculated for an (unintended) inverse calculation, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <b> kc </b>.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/plate/fig_plate_kc_mean_laminar_KC.png\">

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar\"> kc_laminar </a> is also valid for this inverse calculation due to using the same functions.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Elmquist,H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>

<dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_laminar_KC;

      record kc_laminar_IN_con
        "Input record for function kc_laminar and kc_laminar_KC"

        extends Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_con;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar\">  kc_laminar </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_KC\">  kc_laminar_KC </a>.
</html>"));
      end kc_laminar_IN_con;

      record kc_laminar_IN_var
        "Input record for function kc_laminar and kc_laminar_KC"

        extends Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_var;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar\">  kc_laminar </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_KC\">  kc_laminar_KC </a>.
</html>"));
      end kc_laminar_IN_var;

      function kc_overall
        "Mean heat transfer coefficient of even plate | overall regime | constant wall temperature"

        //SOURCE: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //Notation of equations according to SOURCE

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.Plate1_d;

        //input records
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_con
          IN_con "Input record for function kc_overall"
          annotation (Dialog(group="Constant inputs"));
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_var
          IN_var "Input record for function kc_overall"
          annotation (Dialog(group="Variable inputs"));
        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results"
          annotation (Dialog(group="Output"));

      protected
        Real MIN=Modelica.Constants.eps;

        Real prandtlMax=2000 "Maximum Prandtl number";
        Real prandtlMin=0.6 "Minimum Prandtl number";
        Real reynoldsMax=1e7 "Maximum Reynolds number";
        Real reynoldsMin=1e1 "Minimum Reynolds number";

        //failure status
        Real fstatus[2] "Check of expected boundary conditions";

        //Documentation
      algorithm
        Pr := IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda);
        Re := max(1e-3, abs(IN_var.rho*IN_var.velocity*IN_con.L/max(MIN, IN_var.eta)));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_KC(IN_con, IN_var);
        Nu := kc*IN_con.L/max(MIN, IN_var.lambda);

        //failure status
        fstatus[1] := if Re > reynoldsMax or Re < reynoldsMin then 1 else 0;
        fstatus[2] := if Pr > prandtlMax or Pr < prandtlMin then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for an overall fluid flow over an even surface.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> constant wall temperature
<li> overall regime (Reynolds number 1e1 &lt; Re &lt; 1e7)
<li> Prandtl number 0.6 &le; Pr &le; 2000
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/plate/pic_plate.png\">


<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc</b> for flat plate is calculated through the corresponding Nusselt number <b> Nu_lam</b> according to <i>[VDI 2002, p. Gd 1, eq. 1]</i> :

<pre>
    Nu_lam = 0.664 * Re^(0.5) * (Pr)^(1/3)
</pre>

For turbulent flows the corresponding Nusselt number <b> Nu_turb</b> is calculated according to <i>[VDI 2002, p. Gd 1, eq. 2]</i> :

<pre>
    Nu_turb = (0.037 * Re^0.8 * Pr) / (1 + 2.443/Re^0.1 * (Pr^(2/3)-1))
</pre>

<p>
The overall mean convective heat transfer coefficient <b> kc </b> is calculated by:
</p>

<p>
<pre>
    kc =  sqrt(Nu_lam^2 + Nu_turb^2) * lambda / L
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> cp                           </b></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><b> eta                          </b></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><b> kc                           </b></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><b> lambda                       </b></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><b> L                            </b></td><td> as length of plate [m],</td></tr>
<tr><td><b> Nu_lam                  </b></td><td> as mean Nusselt number for laminar regime [-], </td></tr>
<tr><td><b> Nu_turb                 </b></td><td> as mean Nusselt number for turbulent regime [-], </td></tr>
<tr><td><b> Nu = kc*L/lambda             </b></td><td> as mean Nusselt number for overall regime [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda           </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> rho                          </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> Re = rho*v*L/eta             </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu = sqrt(Nu_lam^2 + Nu_turb^2) </b> representing the mean convective heat transfer coefficient <b> kc </b> for Prandtl numbers of different fluids is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/plate/fig_plate_kc_overall.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_overall;

      function kc_overall_KC
        "Mean heat transfer coefficient of even plate | overall regime | constant wall temperature"

        //SOURCE: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //Notation of equations according to SOURCE

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.Plate1_d;

        //input records
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_con
          IN_con "Input record for function kc_overall_KC"
          annotation (Dialog(group="Constant inputs"));
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_var
          IN_var "Input record for function kc_overall_KC"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Output for function kc_overall_KC";

      protected
        SI.CoefficientOfHeatTransfer kc_lam=
            Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_KC(     IN_con, IN_var);
        SI.CoefficientOfHeatTransfer kc_turb=
            Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_KC(     IN_con, IN_var);

        //Documentation
      algorithm
        kc := sqrt((kc_lam)^2 + (kc_turb)^2);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for an overall fluid flow over an even surface.
</p>

<p>
Generally this function is numerically best used for the calculation of the mean convective heat transfer coefficient <b> kc </b> at known fluid velocity.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> constant wall temperature </li>
<li> overall regime (Reynolds number 1e1 &lt; Re &lt; 1e7) </li>
<li> Prandtl number 0.6 &le; Pr &le; 2000 </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/plate/pic_plate.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc</b> for flat plate is calculated through the corresponding Nusselt number <b> Nu_lam</b> according to <i>[VDI 2002, p. Gd 1, eq. 1]</i> :

<pre>
    Nu_lam = 0.664 * Re^(0.5) * (Pr)^(1/3)
</pre>

For turbulent flows the corresponding Nusselt number <b> Nu_turb</b> is calculated according to <i>[VDI 2002, p. Gd 1, eq. 2]</i> :

<pre>
    Nu_turb = (0.037 * Re^0.8 * Pr) / (1 + 2.443/Re^0.1 * (Pr^(2/3)-1))
</pre>

<p>
The overall mean convective heat transfer coefficient <b> kc </b> is calculated by:
</p>

<p>
<pre>
    kc =  sqrt(Nu_lam^2 + Nu_turb^2) * lambda / L
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> cp                      </b></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><b> eta                     </b></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><b> kc                      </b></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><b> lambda                  </b></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><b> L                       </b></td><td> as length of plate [m],</td></tr>
<tr><td><b> Nu_lam                  </b></td><td> as mean Nusselt number for laminar regime [-], </td></tr>
<tr><td><b> Nu_turb                 </b></td><td> as mean Nusselt number for turbulent regime [-], </td></tr>
<tr><td><b> Nu = kc*L/lambda        </b></td><td> as mean Nusselt number for overall regime [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda      </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> rho                     </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> Re = rho*v*L/eta        </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu = sqrt(Nu_lam^2 + Nu_turb^2) </b> representing the mean convective heat transfer coefficient <b> kc </b> for Prandtl numbers of different fluids is shown in the figure below.
Here the figures are calculated for an (unintended) inverse calculation, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <b> kc </b>.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/plate/fig_plate_kc_mean_overall_KC.png\">

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall\"> kc_overall </a> is also valid for this inverse calculation due to using the same functions.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Elmquist,H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>

<dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_overall_KC;

      record kc_overall_IN_con
        "Input record for function kc_overall and function kc_overall_KC"

        //plate variables
        extends Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.Plate;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall\"> kc_overall </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_KC\"> kc_overall_KC </a>.
</html>"));
      end kc_overall_IN_con;

      record kc_overall_IN_var
        "Input record for function kc_overall and function kc_overall_KC"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;

        //input variable (fluid flow velocity)
        Modelica.SIunits.Velocity velocity annotation (Dialog(group="Input"));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall\"> kc_overall </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_KC\"> kc_overall_KC </a>.
</html>"));
      end kc_overall_IN_var;

      function kc_turbulent
        "Mean heat transfer coefficient of even plate | turbulent regime | constant wall temperature"

        //SOURCE: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //Notation of equations according to SOURCE

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.Plate1_d;

        //input records
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_IN_con
          IN_con "Input record for function kc_turbulent"
          annotation (Dialog(group="Constant inputs"));
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_IN_var
          IN_var "Input record for function kc_turbulent"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results"
          annotation (Dialog(group="Output"));

      protected
        Real MIN=Modelica.Constants.eps;

        Real prandtlMax=2000 "Maximum Prandtl number";
        Real prandtlMin=0.6 "Minimum Prandtl number";
        Real reynoldsMax=1e7 "Maximum Reynolds number";
        Real reynoldsMin=5e5 "Minimum Reynolds number";

        //failure status
        Real fstatus[2] "Check of expected boundary conditions";

        //Documentation
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
        Re := max(1e-3, abs(IN_var.rho*IN_var.velocity*IN_con.L/max(MIN, IN_var.eta)));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_KC(IN_con, IN_var);
        Nu := kc*IN_con.L/max(MIN, IN_var.lambda);

        //failure status
        fstatus[1] := if Re > reynoldsMax or Re < reynoldsMin then 1 else 0;
        fstatus[2] := if Pr > prandtlMax or Pr < prandtlMin then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for a hydrodynamically developed turbulent fluid flow over an even surface.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> constant wall temperature
<li> turbulent regime (Reynolds number 5e5 &lt; Re &lt; 1e7)
<li> Prandtl number 0.6 &le; Pr &le; 2000
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/plate/pic_plate.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc</b> for flat plate is calculated through the corresponding Nusselt number <b> Nu_turb</b> according to <i>[VDI 2002, p. Gd 1, eq. 2]</i> :

<pre>
    Nu_turb = (0.037 * Re^0.8 * Pr) / (1 + 2.443/Re^0.1 * (Pr^(2/3)-1))
</pre>

<p>
and the corresponding mean convective heat transfer coefficient <b> kc </b> :
</p>

<p>
<pre>
    kc =  Nu_turb * lambda / L
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> cp          </b></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><b> eta          </b></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><b> kc          </b></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><b> lambda         </b></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><b> L              </b></td><td> as length of plate [m],</td></tr>
<tr><td><b> Nu_turb                 </b></td><td> as mean Nusselt number for turbulent regime [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda           </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> rho          </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> Re = v*rho*L/eta    </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number in turbulent regime <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> for Prandtl numbers of different fluids is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/plate/fig_plate_kc_turbulent.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>

<dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_turbulent;

      function kc_turbulent_KC
        "Mean heat transfer coefficient of even plate | turbulent regime | constant wall temperature"

        //SOURCE: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //Notation of equations according to SOURCE

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.HeatTransfer.Plate1_d;

        //input records
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_IN_con
          IN_con "Input record for function kc_turbulent_KC"
          annotation (Dialog(group="Constant inputs"));
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_IN_var
          IN_var "Input record for function kc_turbulent_KC"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Output for function kc_turbulent_KC";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Length L=max(MIN, IN_con.L);

        SI.SpecificHeatCapacityAtConstantPressure cp=IN_var.cp;
        SI.DynamicViscosity eta=IN_var.eta;
        SI.ThermalConductivity lambda=max(MIN, IN_var.lambda);
        SI.Density rho=IN_var.rho;

        SI.Velocity velocity=abs(IN_var.velocity) "Mean velocity";
        SI.ReynoldsNumber Re=max(1e-3, abs(rho*velocity*L/eta));
        SI.PrandtlNumber Pr=abs(eta*cp/lambda);

        //Documentation
      algorithm
        kc := abs((lambda/L))*(0.037*Re^0.8*Pr)/(1 + 2.443/(max(Re^0.1, 1e-6))*(Pr^(2
          /3) - 1));
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <b> kc </b> for a hydrodynamically developed turbulent fluid flow over an even surface.
</p>

<p>
Generally this function is numerically best used for the calculation of the mean convective heat transfer coefficient <b> kc </b> at known fluid velocity.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> constant wall temperature </li>
<li> turbulent regime (Reynolds number 5e5 &lt; Re &lt; 1e7) </li>
<li> Prandtl number 0.6 &le; Pr &le; 2000 </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/plate/pic_plate.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc</b> for flat plate is calculated through the corresponding Nusselt number <b> Nu_turb</b> according to <i>[VDI 2002, p. Gd 1, eq. 2]</i> :

<pre>
    Nu_turb = (0.037 * Re^0.8 * Pr) / (1 + 2.443/Re^0.1 * (Pr^(2/3)-1))
</pre>

<p>
and the corresponding mean convective heat transfer coefficient <b> kc </b> :
</p>

<p>
<pre>
    kc =  Nu_turb * lambda / L
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> cp                           </b></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><b> eta                          </b></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><b> kc                           </b></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><b> lambda                       </b></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><b> L                            </b></td><td> as length of plate [m],</td></tr>
<tr><td><b> Nu_turb                 </b></td><td> as mean Nusselt number for turbulent regime [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda           </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> rho                          </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> Re = v*rho*L/eta             </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> for Prandtl numbers of different fluids is shown in the figure below.
Here the figures are calculated for an (unintended) inverse calculation, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <b> kc </b>.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/plate/fig_plate_kc_mean_turbulent_KC.png\">

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent\"> kc_turbulent </a> is also valid for this inverse calculation due to using the same functions.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Elmquist,H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>

<dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_turbulent_KC;

      record kc_turbulent_IN_con
        "Input record for function kc_turbulent and kc_turbulent_KC"

        extends Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_con;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent\">  kc_turbulent </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_KC\">  kc_turbulent_KC </a>.
</html>"));
      end kc_turbulent_IN_con;

      record kc_turbulent_IN_var
        "Input record for function kc_turbulent and kc_turbulent_KC"

        extends Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_var;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent\">  kc_turbulent </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_KC\">  kc_turbulent_KC </a>.
</html>"));
      end kc_turbulent_IN_var;
    end Plate;

    package StraightPipe
    extends Modelica.Icons.VariantsPackage;

      function kc_laminar
        "Mean heat transfer coefficient of straight pipe | uniform wall temperature or uniform heat flux | hydrodynamically developed or undeveloped laminar flow regime"

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_con
          IN_con "Input record for function kc_laminar"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_var
          IN_var "Input record for function kc_laminar"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results"
          annotation (Dialog(group="Output"));

      protected
        Real MIN=Modelica.Constants.eps;

        Real laminar=2e3 "Maximum Reynolds number of laminar flow regime";
        Real prandtlMax=1000 "Maximum Prandtl number";
        Real prandtlMin=0.6 "Minimum Prandtl number";

        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Cross sectional area";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity";

        //failure status
        Real fstatus[2] "check of expected boundary conditions";

        //Documentation
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
        Re := max(1e-3, IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_KC(IN_con, IN_var);
        Nu := kc*IN_con.d_hyd/max(MIN, IN_var.lambda);

        //failure status
        fstatus[1] := if Re > laminar then 1 else 0;
        fstatus[2] := if Pr > prandtlMax or Pr < prandtlMin then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of mean convective heat transfer coefficient <b> kc </b> of a straight pipe at an uniform wall temperature <b> or </b> uniform heat flux <b>and</b> for a hydrodynamically developed <b>or</b> undeveloped laminar fluid flow.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> circular cross sectional area
<li> uniform wall temperature (UWT) <b> or </b> uniform heat flux (UHF)
<li> hydrodynamically developed fluid flow (DFF) <b> or </b> hydrodynamically undeveloped fluid flow (UFF)
<li> 0.6 &le; Prandtl number &le; 1000
<li> laminar regime (Reynolds number &le; 2000)
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_straightPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc </b> of a straight pipe in the laminar regime can be calculated for the following four heat transfer boundary conditions through its corresponding Nusselt number <b> Nu </b>:

<p>
<b> Uniform wall temperature in developed fluid flow (heatTransferBoundary = 1)</b> according to <i>[VDI 2002, p. Ga 2, eq. 6]</i> :
</p>

<pre>
    Nu_TD = [3.66^3 + 0.7^3 + {1.615*(Re*Pr*d_hyd/L)^1/3 - 0.7}^3]^1/3
</pre>

<p>
<b> Uniform heat flux in developed fluid flow (heatTransferBoundary == 2)</b> according to <i>[VDI 2002, p. Ga 4, eq. 19]</i> :
</p>

<pre>
    Nu_qD = [4.364^3 + 0.6^3 + {1.953*(Re*Pr*d_hyd/L)^1/3 - 0.6}^3]^1/3
</pre>

<p>
<b> Uniform wall temperature in undeveloped fluid flow (heatTransferBoundary = 3)</b> according to <i>[VDI 2002, p. Ga 2, eq. 12]</i> :
</p>

<pre>
    Nu_TU = [3.66^3 + 0.7^3 + {1.615*(Re*Pr*d_hyd/L)^1/3 - 0.7}^3 + {(2/[1+22*Pr])^1/6*(Re*Pr*d_hyd/L)^0.5}^3]^1/3
</pre>

<p>
<b> Uniform heat flux in developed fluid flow (heatTransferBoundary == 4)</b> according to <i>[VDI 2002, p. Ga 5, eq. 25]</i> :
</p>

<pre>
    Nu_qU = [4.364^3 + 0.6^3 + {1.953*(Re*Pr*d_hyd/L)^1/3 - 0.6}^3 + {0.924*Pr^1/3*[Re*d_hyd/L]^0.5}^3]^1/3.
</pre>

<p>
The corresponding mean convective heat transfer coefficient <b> kc </b> is determined w.r.t. the chosen heat transfer boundary by:
</p>

<p>
<pre>
    kc =  Nu * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_hyd                    </b></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><b> kc                       </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                   </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L                        </b></td><td> as length of straight pipe [m],</td></tr>
<tr><td><b> Nu = kc*d_hyd/lambda     </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda       </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta     </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> v                        </b></td><td> as mean velocity [m/s].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> depending on four different heat transfer boundary conditions is shown in the figures below.

<p>
This verification has been done with the fluid properties of Water (Prandtl number Pr = 7) and a diameter to pipe length fraction of 0.1.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/fig_straightPipe_kc_laminar.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>Bejan,A.:</dt>
    <dd><b>Heat transfer handbook</b>.
    Wiley, 2003.</dd>
 <dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_laminar;

      function kc_laminar_KC
        "Mean heat transfer coefficient of straight pipe | uniform wall temperature or uniform heat flux | hydrodynamically developed or undeveloped laminar flow regime"

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_con
          IN_con "Input record for function kc_laminar_KC"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_var
          IN_var "Input record for function kc_laminar_KC"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Output for function kc_laminar_KC";

      protected
        type TYP =
            Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary;

        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Circular cross sectional area";

        Real Nu0=if IN_con.target == TYP.UWTuDFF or IN_con.target == TYP.UWTuUFF then
                  0.7 else if IN_con.target == TYP.UHFuDFF or IN_con.target == TYP.UHFuUFF then
                  0.6 else 0 "Help variable for mean Nusselt number";
        Real Nu1=if IN_con.target == TYP.UWTuDFF or IN_con.target == TYP.UWTuUFF then
                  3.66 else if IN_con.target == TYP.UHFuDFF or IN_con.target == TYP.UHFuUFF then
                  4.364 else 0 "Help variable for mean Nusselt number";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity";
        SI.ReynoldsNumber Re=max(1e-3, IN_var.rho*velocity*IN_con.d_hyd/max(MIN,
            IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        SI.NusseltNumber Nu2=if IN_con.target == TYP.UWTuDFF or IN_con.target == TYP.UWTuUFF then
                  1.615*(Re*Pr*IN_con.d_hyd/IN_con.L)^(1/3) else if IN_con.target ==
            TYP.UHFuDFF or IN_con.target == TYP.UHFuUFF then 1.953*(Re*Pr*IN_con.d_hyd
            /IN_con.L)^(1/3) else 0 "Help variable for mean Nusselt number";
        SI.NusseltNumber Nu3=if IN_con.target == TYP.UWTuUFF then (2/(1 + 22*Pr))^(1/
            6)*(Re*Pr*IN_con.d_hyd/IN_con.L)^0.5 else if IN_con.target == TYP.UHFuUFF then
                  1.953*(Re*Pr*IN_con.d_hyd/IN_con.L)^(1/3) else 0
          "Help variable for mean Nusselt number";

        SI.NusseltNumber Nu=(Nu1^3 + Nu0^3 + (Nu2 - Nu0)^3 + Nu3^3)^(1/3)
          "Mean Nusselt number";

        //Documentation
      algorithm
        kc := Nu*IN_var.lambda/max(MIN, IN_con.d_hyd);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of mean convective heat transfer coefficient <b> kc </b> of a straight pipe at an uniform wall temperature <b> or </b> uniform heat flux <b>and</b> for a hydrodynamically developed <b>or</b> undeveloped laminar fluid flow
</p>

<p>
Generally this function is numerically best used for the calculation of the mean convective heat transfer coefficient <b> kc </b> at known mass flow rate.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> circular cross sectional area </li>
<li> uniform wall temperature (UWT) <b> or </b> uniform heat flux (UHF) </li>
<li> hydrodynamically developed fluid flow (DFF) <b> or </b> hydrodynamically undeveloped fluid flow (UFF) </li>
<li> 0.6 &le; Prandtl number &le; 1000 </li>
<li> laminar regime (Reynolds number &le; 2000) </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_straightPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mean convective heat transfer coefficient <b> kc </b> of a straight pipe in the laminar regime can be calculated for the following four heat transfer boundary conditions through its corresponding Nusselt number <b> Nu </b>:

<p>
<b> Uniform wall temperature in developed fluid flow (heatTransferBoundary = 1)</b> according to <i>[VDI 2002, p. Ga 2, eq. 6]</i> :
</p>

<pre>
    Nu_TD = [3.66^3 + 0.7^3 + {1.615*(Re*Pr*d_hyd/L)^1/3 - 0.7}^3]^1/3
</pre>

<p>
<b> Uniform heat flux in developed fluid flow (heatTransferBoundary == 2)</b> according to <i>[VDI 2002, p. Ga 4, eq. 19]</i> :
</p>

<pre>
    Nu_qD = [4.364^3 + 0.6^3 + {1.953*(Re*Pr*d_hyd/L)^1/3 - 0.6}^3]^1/3
</pre>

<p>
<b> Uniform wall temperature in undeveloped fluid flow (heatTransferBoundary = 3)</b> according to <i>[VDI 2002, p. Ga 2, eq. 12]</i> :
</p>

<pre>
    Nu_TU = [3.66^3 + 0.7^3 + {1.615*(Re*Pr*d_hyd/L)^1/3 - 0.7}^3 + {(2/[1+22*Pr])^1/6*(Re*Pr*d_hyd/L)^0.5}^3]^1/3
</pre>

<p>
<b> Uniform heat flux in developed fluid flow (heatTransferBoundary == 4)</b> according to <i>[VDI 2002, p. Ga 5, eq. 25]</i> :
</p>

<pre>
    Nu_qU = [4.364^3 + 0.6^3 + {1.953*(Re*Pr*d_hyd/L)^1/3 - 0.6}^3 + {0.924*Pr^1/3*[Re*d_hyd/L]^0.5}^3]^1/3.
</pre>

<p>
The corresponding mean convective heat transfer coefficient <b> kc </b> is determined w.r.t. the chosen heat transfer boundary by:
</p>

<p>
<pre>
    kc =  Nu * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_hyd                    </b></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><b> kc                       </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                   </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L                        </b></td><td> as length of straight pipe [m],</td></tr>
<tr><td><b> Nu = kc*d_hyd/lambda     </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda       </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta     </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> v                        </b></td><td> as mean velocity [m/s].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> is shown for Prandtl numbers of different fluids in the figures below. Here an inverse calculation of the mass flow rate <b> m_flow </b> out of a given mean Nusselt number <b> Nu </b> is shown. Note that an inverse calculation is not possible below a specific Nusselt number Nu (here Nu is about 5) due to an asymtotic behaviour for mass flow rates going to zero.

<p>
<b> Uniform wall temperature in developed fluid flow (heatTransferBoundary = 1)</b> :
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/fig_straightPipe_kc_laminar_UWTwithDFF_KC.png\">

<p>
<b> Uniform heat flux in developed fluid flow (heatTransferBoundary = 2)</b>  :
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/fig_straightPipe_kc_laminar_UHFwithDFF_KC.png\">

<p>
<b> Uniform wall temperature in undeveloped fluid flow (heatTransferBoundary = 3)</b> :
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/fig_straightPipe_kc_laminar_UWTwithUFF_KC.png\" width=600>

<p>
<b> Uniform heat flux in developed fluid flow (heatTransferBoundary = 4)</b> :
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/fig_straightPipe_kc_laminar_UHFwithUFF_KC.png\" width=600>

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar\"> kc_laminar </a> is also valid for this inverse calculation due to using the same functions.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>Bejan,A.:</dt>
    <dd><b>Heat transfer handbook</b>.
    Wiley, 2003.</dd>
 <dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_laminar_KC;

      record kc_laminar_IN_con
        "Input record for function kc_laminar and kc_laminar_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_con(      final
            roughness=1);

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar\"> kc_laminar </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_KC\"> kc_laminar_KC </a>.
</html>"));
      end kc_laminar_IN_con;

      record kc_laminar_IN_var
        "Input record for function kc_laminar and kc_laminar_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar\"> kc_laminar </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_KC\"> kc_laminar_KC </a>.
</html>"));
      end kc_laminar_IN_var;

      function kc_overall
        "Mean heat transfer coefficient of straight pipe | uniform wall temperature or uniform heat flux | hydrodynamically developed or undeveloped overall flow regime| pressure loss dependence"

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_con
          IN_con "Input record for function kc_overall"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var
          IN_var "Input record for function kc_overall"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results"
          annotation (Dialog(group="Output"));

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.Roughness;

        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Cross sectional area";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity";

        //failure status
        Real fstatus[3] "Check of expected boundary conditions";

        //Documentation
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
        Re := max(1e-3, IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC(IN_con, IN_var);
        Nu := kc*IN_con.d_hyd/max(MIN, IN_var.lambda);

        //failure status
        if IN_con.roughness == TYP.Neglected then
          if Re < 2e4 or Re > 1e6 then
            fstatus[1] := 1;
          else
            fstatus[1] := 0;
          end if;
        elseif IN_con.roughness == TYP.Considered then
          if Re < 1e4 or Re > 1e6 then
            fstatus[1] := 1;
          else
            fstatus[1] := 0;
          end if;
        else
          assert(true, "No choice of roughness is selected");
        end if;
        fstatus[2] := if Pr < 0.6 or Pr > 1e3 then 1 else 0;
        fstatus[3] := if IN_con.d_hyd/max(MIN, IN_con.L) > 1 then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of mean convective heat transfer coefficient <b> kc </b> of a straight pipe at an uniform wall temperature <b> or </b> uniform heat flux <b> and </b> for a hydrodynamically developed <b>or</b> undeveloped overall fluid flow with neglect <b> or </b> consideration of pressure loss influence.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> circular cross sectional area </li>
<li> uniform wall temperature (UWT) <b> or </b> uniform heat flux (UHF) </li>
<li> hydrodynamically developed fluid flow </li>
<li> hydraulic diameter / length &le; 1 </li>
<li> 0.6 &le; Prandtl number &le; 1000 </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_straightPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
<p>
<b> Laminar regime:</b>
The mean convective heat transfer coefficient <b> kc </b> of a straight pipe in the laminar regime can be calculated for the following four heat transfer boundary conditions through its corresponding Nusselt number <b> Nu </b>:

<p>
<b> Uniform wall temperature in developed fluid flow (heatTransferBoundary = 1)</b> according to <i>[VDI 2002, p. Ga 2, eq. 6]</i> :
</p>

<pre>
    Nu_TD = [3.66^3 + 0.7^3 + {1.615*(Re*Pr*d_hyd/L)^1/3 - 0.7}^3]^1/3
</pre>

<p>
<b> Uniform heat flux in developed fluid flow (heatTransferBoundary = 2)</b> according to <i>[VDI 2002, p. Ga 4, eq. 19]</i> :
</p>

<pre>
    Nu_qD = [4.364^3 + 0.6^3 + {1.953*(Re*Pr*d_hyd/L)^1/3 - 0.6}^3]^1/3
</pre>

<p>
<b> Uniform wall temperature in undeveloped fluid flow (heatTransferBoundary = 3)</b> according to <i>[VDI 2002, p. Ga 2, eq. 12]</i> :
</p>

<pre>
    Nu_TU = [3.66^3 + 0.7^3 + {1.615*(Re*Pr*d_hyd/L)^1/3 - 0.7}^3 + {(2/[1+22*Pr])^1/6*(Re*Pr*d_hyd/L)^0.5}^3]^1/3
</pre>

<p>
<b> Uniform heat flux in developed fluid flow (heatTransferBoundary = 4)</b> according to <i>[VDI 2002, p. Ga 5, eq. 25]</i> :
</p>

<pre>
    Nu_qU = [4.364^3 + 0.6^3 + {1.953*(Re*Pr*d_hyd/L)^1/3 - 0.6}^3 + {0.924*Pr^1/3*[Re*d_hyd/L]^0.5}^3]^1/3.
</pre>

<p>
The <b> transition regime </b> (2e3 &le; Reynolds number &le; 1e4) is calculated via a smoothing interpolation function.
</p>

<p>
<b> Turbulent regime: </b>
<b>Neglect pressure loss influence (roughness == 1):</b>
</p>

The mean convective heat transfer coefficient <b> kc </b> for smooth straight pipes is calculated through its corresponding Nusselt number <b> Nu </b> according to <i> [Dittus and Boelter in Bejan 2003, p. 424, eq. 5.76]</i>

<pre>
    Nu = 0.023 * Re^(4/5) * Pr^(1/3).
</pre>

<p>
<b>Consider pressure loss influence (roughness == 2):</b>
</p>

<p>
The mean convective heat transfer coefficient <b> kc </b> for rough straight pipes is calculated through its corresponding Nusselt number <b> Nu </b> according to <i>[Gnielinski in VDI 2002, p. Ga 5, eq. 26]</i>
</p>

<pre>
    Nu = (zeta/8)*Re*Pr/(1 + 12.7*(zeta/8)^0.5*(Pr^(2/3)-1))*(1+(d_hyd/L)^(2/3)),
</pre>

<p>
where the influence of the pressure loss on the heat transfer calculation is considered through
</p>

<p>
<pre>
    zeta =  (1.8*log10(Re)-1.5)^-2.
</pre>
</p>

<p>
The corresponding mean convective heat transfer coefficient <b> kc </b> results to
</p>
<p>
<pre>

    kc =  Nu * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_hyd                      </b></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L                          </b></td><td> as length of straight pipe [m],</td></tr>
<tr><td><b> Nu = kc*d_hyd/lambda       </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta       </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> v                          </b></td><td> as mean velocity [m/s],</td></tr>
<tr><td><b> zeta                       </b></td><td> as pressure loss coefficient [-]. </td></tr>
</table>
</p>

<p>
Note that there is no significant difference for the calculation of the mean Nusselt number <b> Nu </b> at a uniform wall temperature (UWT) or a uniform heat flux (UHF) as heat transfer boundary in the turbulent regime (Bejan 2003, p.303).
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> is shown for the fluid properties of Water (Prandtl number Pr = 7) and a diameter to pipe length fraction of 0.1 in the figure below.
</p>

<p>
The following verification considers pressure loss influence (roughness =2).
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/fig_straightPipe_kc_overall.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>Bejan,A.:</dt>
    <dd><b>Heat transfer handbook</b>.
    Wiley, 2003.</dd>
 <dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_overall;

      function kc_overall_KC
        "Mean heat transfer coefficient of straight pipe | uniform wall temperature or uniform heat flux | hydrodynamically developed or undeveloped overall flow regime| pressure loss dependence"

        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_con
          IN_con "Input record for function kc_overall_KC"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var
          IN_var "Input record for function kc_overall_KC"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Output for function kc_overall_KC";

      protected
        Real MIN=Modelica.Constants.eps;
        Real laminar=2200 "Maximum Reynolds number for laminar regime";
        Real turbulent=1e4 "Minimum Reynolds number for turbulent regime";

        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Cross sectional area";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity";
        SI.ReynoldsNumber Re=max(1e-3, IN_var.rho*velocity*IN_con.d_hyd/max(MIN,
            IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        //Documentation
      algorithm
        kc := SMOOTH(
                laminar,
                turbulent,
                Re)*Dissipation.HeatTransfer.StraightPipe.kc_laminar_KC(IN_con,
          IN_var) + SMOOTH(
                turbulent,
                laminar,
                Re)*Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC(
          IN_con, IN_var);

        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of mean convective heat transfer coefficient <b> kc </b> of a straight pipe at an uniform wall temperature <b> or </b> uniform heat flux <b> and </b> for a hydrodynamically developed <b>or</b> undeveloped overall fluid flow with neglect <b> or </b> consideration of pressure loss influence.
</p>

<p>
Generally this function is numerically best used for the calculation of the mean convective heat transfer coefficient <b> kc </b> at known mass flow rate.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> circular cross sectional area </li>
<li> uniform wall temperature (UWT) <b> or </b> uniform heat flux (UHF) </li>
<li> hydrodynamically developed fluid flow </li>
<li> hydraulic diameter / length &le; 1 </li>
<li> 0.6 &le; Prandtl number &le; 1000 </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_straightPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
<p>
<b> Laminar regime:</b>
The mean convective heat transfer coefficient <b> kc </b> of a straight pipe in the laminar regime can be calculated for the following four heat transfer boundary conditions through its corresponding Nusselt number <b> Nu </b>:

<p>
<b> Uniform wall temperature in developed fluid flow (heatTransferBoundary = 1)</b> according to <i>[VDI 2002, p. Ga 2, eq. 6]</i> :
</p>

<pre>
    Nu_TD = [3.66^3 + 0.7^3 + {1.615*(Re*Pr*d_hyd/L)^1/3 - 0.7}^3]^1/3
</pre>

<p>
<b> Uniform heat flux in developed fluid flow (heatTransferBoundary = 2)</b> according to <i>[VDI 2002, p. Ga 4, eq. 19]</i> :
</p>

<pre>
    Nu_qD = [4.364^3 + 0.6^3 + {1.953*(Re*Pr*d_hyd/L)^1/3 - 0.6}^3]^1/3
</pre>

<p>
<b> Uniform wall temperature in undeveloped fluid flow (heatTransferBoundary = 3)</b> according to <i>[VDI 2002, p. Ga 2, eq. 12]</i> :
</p>

<pre>
    Nu_TU = [3.66^3 + 0.7^3 + {1.615*(Re*Pr*d_hyd/L)^1/3 - 0.7}^3 + {(2/[1+22*Pr])^1/6*(Re*Pr*d_hyd/L)^0.5}^3]^1/3
</pre>

<p>
<b> Uniform heat flux in developed fluid flow (heatTransferBoundary = 4)</b> according to <i>[VDI 2002, p. Ga 5, eq. 25]</i> :
</p>

<pre>
    Nu_qU = [4.364^3 + 0.6^3 + {1.953*(Re*Pr*d_hyd/L)^1/3 - 0.6}^3 + {0.924*Pr^1/3*[Re*d_hyd/L]^0.5}^3]^1/3.
</pre>

<p>
<p>
The <b> transition regime </b> (2e3 &le; Reynolds number &le; 1e4) is calculated via a smoothing interpolation function.
<p>
<p>
<b> Turbulent regime: </b>
<p>
<b>Neglect pressure loss influence (roughness == 1):</b>
</p>

The mean convective heat transfer coefficient <b> kc </b> for smooth straight pipes is calculated through its corresponding Nusselt number <b> Nu </b> according to <i> [Dittus and Boelter in Bejan 2003, p. 424, eq. 5.76]</i>

<pre>
    Nu = 0.023 * Re^(4/5) * Pr^(1/3).
</pre>

<p>
<b>Consider pressure loss influence (roughness == 2):</b>
</p>

<p>
The mean convective heat transfer coefficient <b> kc </b> for rough straight pipes is calculated through its corresponding Nusselt number <b> Nu </b> according to <i>[Gnielinski in VDI 2002, p. Ga 5, eq. 26]</i>
</p>

<pre>
    Nu = (zeta/8)*Re*Pr/(1 + 12.7*(zeta/8)^0.5*(Pr^(2/3)-1))*(1+(d_hyd/L)^(2/3)),
</pre>

<p>
where the influence of the pressure loss on the heat transfer calculation is considered through
</p>

<p>
<pre>
    zeta =  (1.8*log10(Re)-1.5)^-2.
</pre>
</p>

<p>
The corresponding mean convective heat transfer coefficient <b> kc </b> results to
</p>
<p>
<pre>

    kc =  Nu * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_hyd                      </b></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L                          </b></td><td> as length of straight pipe [m],</td></tr>
<tr><td><b> Nu = kc*d_hyd/lambda       </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta       </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> v                          </b></td><td> as mean velocity [m/s],</td></tr>
<tr><td><b> zeta                       </b></td><td> as pressure loss coefficient [-]. </td></tr>
</table>
</p>

<p>
Note that there is no significant difference for the calculation of the mean Nusselt number <b> Nu </b> at a uniform wall temperature (UWT) or a uniform heat flux (UHF) as heat transfer boundary in the turbulent regime (Bejan 2003, p.303).
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> is shown for Prandtl numbers of different fluids in the figures below. Here an inverse calculation of the mass flow rate <b> m_flow </b> out of a given mean Nusselt number <b> Nu </b> is shown.

<p>
The following verification considers pressure loss influence (roughness =2).
</p>

<p>
<b> Uniform wall temperature in developed fluid flow (heatTransferBoundary = 1)</b> :
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/fig_straightPipe_kc_overall_UWTwithDFF_KC.png\">

<p>
<b> Uniform heat flux in developed fluid flow (heatTransferBoundary = 2)</b>  :
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/fig_straightPipe_kc_overall_UHFwithDFF_KC.png\">

<p>
<b> Uniform wall temperature in undeveloped fluid flow (heatTransferBoundary = 3)</b> :
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/fig_straightPipe_kc_overall_UWTwithUFF_KC.png\" width=600>

<p>
<b> Uniform heat flux in developed fluid flow (heatTransferBoundary = 4)</b> :
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/fig_straightPipe_kc_overall_UHFwithUFF_KC.png\" width=600>

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall\"> kc_overall </a> is also valid for this inverse calculation due to using the same functions.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>Bejan,A.:</dt>
    <dd><b>Heat transfer handbook</b>.
    Wiley, 2003.</dd>
 <dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_overall_KC;

      record kc_overall_IN_con
        "Input record for function kc_overall and kc_overall_KC"

        //straight pipe variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.StraightPipe(      final K=
             0);

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall\"> kc_overall </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC\"> kc_overall_KC </a>.
</html>"));
      end kc_overall_IN_con;

      record kc_overall_IN_var
        "Input record for function kc_overall and kc_overall_KC"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;

        //input variable (mass flow rate)
        SI.MassFlowRate m_flow annotation (Dialog(group="Input"));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall\"> kc_overall </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC\"> kc_overall_KC </a>.
</html>"));
      end kc_overall_IN_var;

      function kc_turbulent
        "Mean heat transfer coefficient of straight pipe | hydrodynamically developed turbulent flow regime | pressure loss dependence"

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_con
          IN_con "Input record for function kc_turbulent"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_var
          IN_var "Input record for function kc_turbulent"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results"
          annotation (Dialog(group="Output"));

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.Roughness;

        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Cross sectional area";

        SI.Velocity velocity=abs(IN_var.m_flow)/(IN_var.rho*A_cross)
          "Mean velocity";

        //failure status
        Real fstatus[3] "check of expected boundary conditions";

        //Documentation
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
        Re := max(1e-3, IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC(IN_con, IN_var);
        Nu := kc*IN_con.d_hyd/max(MIN, IN_var.lambda);

        //failure status
        if IN_con.roughness == TYP.Neglected then
          if Re < 2e4 or Re > 1e6 then
            fstatus[1] := 1;
          else
            fstatus[1] := 0;
          end if;
        elseif IN_con.roughness == TYP.Considered then
          if Re < 1e4 or Re > 1e6 then
            fstatus[1] := 1;
          else
            fstatus[1] := 0;
          end if;
        else
          assert(true, "No choice of roughness is selected");
        end if;
        fstatus[2] := if Pr <= 0.6 or Pr >= 1e3 then 1 else 0;
        fstatus[3] := if IN_con.d_hyd/max(MIN, IN_con.L) > 1 then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of mean convective heat transfer coefficient <b> kc </b> of a straight pipe for a hydrodynamically developed turbulent fluid flow at uniform wall temperature <b> or </b> uniform heat flux with neglecting <b> or </b> considering of pressure loss influence.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> circular cross sectional area </li>
<li> hydrodynamically developed fluid flow </li>
<li> hydraulic diameter / length &le; 1 </li>
<li> 0.6 &le; Prandtl number &le; 1000 </li>
<li> turbulent flow regime (1e4 &le; Reynolds number &le; 1e6) </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_straightPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
<p>
<b>Neglect pressure loss influence (roughness == 1):</b>
</p>

The mean convective heat transfer coefficient <b> kc </b> for smooth straight pipes is calculated through its corresponding Nusselt number <b> Nu </b> according to <i> [Dittus and Boelter in Bejan 2003, p. 424, eq. 5.76]</i>

<pre>
    Nu = 0.023 * Re^(4/5) * Pr^(1/3).
</pre>

<p>
<b>Consider pressure loss influence (roughness == 2):</b>
</p>

<p>
The mean convective heat transfer coefficient <b> kc </b> for rough straight pipes is calculated through its corresponding Nusselt number <b> Nu </b> according to <i>[Gnielinski in VDI 2002, p. Ga 5, eq. 26]</i>
</p>

<pre>
    Nu = (zeta/8)*Re*Pr/(1 + 12.7*(zeta/8)^0.5*(Pr^(2/3)-1))*(1+(d_hyd/L)^(2/3)),
</pre>

<p>
where the influence of the pressure loss on the heat transfer calculation is considered through
</p>

<p>
<pre>
    zeta =  (1.8*log10(Re)-1.5)^-2.
</pre>
</p>

<p>
The mean convective heat transfer coefficient <b> kc </b> in dependence of the chosen calculation (neglecting or considering of pressure loss influence) results into:
</p>

<p>
<pre>
    kc =  Nu * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_hyd                      </b></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L                          </b></td><td> as length of straight pipe [m],</td></tr>
<tr><td><b> Nu = kc*d_hyd/lambda       </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta       </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> v                          </b></td><td> as mean velocity [m/s],</td></tr>
<tr><td><b> zeta                       </b></td><td> as pressure loss coefficient [-]. </td></tr>
</table>
</p>

<p>
Note that there is no significant difference for the calculation of the mean Nusselt number <b> Nu </b> at a uniform wall temperature (UWT) or a uniform heat flux (UHF) as heat transfer boundary in the turbulent regime (Bejan 2003, p.303).
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> for Prandtl numbers of different fluids is shown in the figures below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/fig_straightPipe_kc_turbulent.png\">

<p>
Note that the higher the Prandtl number <b> Pr </b> there is a higher difference in Nusselt numbers <b> Nu </b> comparing the neglect and consideration of pressure loss.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
  <dt>Bejan,A.:</dt>
    <dd><b>Heat transfer handbook</b>.
    Wiley, 2003.</dd>
 <dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_turbulent;

      function kc_turbulent_KC
        "Mean heat transfer coefficient of straight pipe | hydrodynamically developed turbulent flow regime | pressure loss dependence"

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_con
          IN_con "Input record for function kc_turbulent_KC"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_var
          IN_var "Input record for function kc_turbulent_KC"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Output for function kc_turbulent_KC";

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.Roughness;

        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Circular cross sectional area";

        SI.Velocity velocity=abs(IN_var.m_flow)/(IN_var.rho*A_cross)
          "Mean velocity";
        SI.ReynoldsNumber Re=max(2.6, IN_var.rho*velocity*IN_con.d_hyd/IN_var.eta);
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/IN_var.lambda);

        Real zeta=abs(1/max(MIN, 1.8*Modelica.Math.log10(abs(Re)) - 1.5)^2)
          "Pressure loss coefficient";

        //Documentation
      algorithm
        kc := if IN_con.roughness == TYP.Neglected then abs(IN_var.lambda/IN_con.d_hyd)
          *0.023*Re^0.8*Pr^(1/3) else if IN_con.roughness == TYP.Considered then abs(
          IN_var.lambda/IN_con.d_hyd)*(abs(zeta)/8)*abs(Re)*abs(Pr)/(1 + 12.7*(abs(
          zeta)/8)^0.5*(abs(Pr)^(2/3) - 1))*(1 + (IN_con.d_hyd/IN_con.L)^(2/3)) else
          0;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of mean convective heat transfer coefficient <b> kc </b> of a straight pipe for a hydrodynamically developed turbulent fluid flow at uniform wall temperature <b> or </b> uniform heat flux with neglecting <b> or </b> considering of pressure loss influence.
</p>

<p>
Generally this function is numerically best used for the calculation of the mean convective heat transfer coefficient <b> kc </b> at known mass flow rate.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
<ul>
<li> circular cross sectional area </li>
<li> hydrodynamically developed fluid flow </li>
<li> hydraulic diameter / length &le; 1 </li>
<li> 0.6 &le; Prandtl number &le; 1000 </li>
<li> turbulent flow regime (1e4 &le; Reynolds number &le; 1e6) </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_straightPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
<p>
<b>Neglect pressure loss influence (roughness == 1):</b>
</p>

The mean convective heat transfer coefficient <b> kc </b> for smooth straight pipes is calculated through its corresponding Nusselt number <b> Nu </b> according to <i> [Dittus and Boelter in Bejan 2003, p. 424, eq. 5.76]</i>

<pre>
    Nu = 0.023 * Re^(4/5) * Pr^(1/3).
</pre>

<p>
<b>Consider pressure loss influence (roughness == 2):</b>
</p>

<p>
The mean convective heat transfer coefficient <b> kc </b> for rough straight pipes is calculated through its corresponding Nusselt number <b> Nu </b> according to <i>[Gnielinski in VDI 2002, p. Ga 5, eq. 26]</i>
</p>

<pre>
    Nu = (zeta/8)*Re*Pr/(1 + 12.7*(zeta/8)^0.5*(Pr^(2/3)-1))*(1+(d_hyd/L)^(2/3)),
</pre>

<p>
where the influence of the pressure loss on the heat transfer calculation is considered through
</p>

<p>
<pre>
    zeta =  (1.8*log10(Re)-1.5)^-2.
</pre>
</p>

<p>
The mean convective heat transfer coefficient <b> kc </b> in dependence of the chosen calculation (neglecting or considering of pressure loss influence) results into:
</p>

<p>
<pre>
    kc =  Nu * lambda / d_hyd
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_hyd                      </b></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><b> kc                         </b></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> lambda                     </b></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><b> L                          </b></td><td> as length of straight pipe [m],</td></tr>
<tr><td><b> Nu = kc*d_hyd/lambda       </b></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><b> Pr = eta*cp/lambda         </b></td><td> as Prandtl number [-],</td></tr>
<tr><td><b> Re = rho*v*d_hyd/eta       </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> v                          </b></td><td> as mean velocity [m/s],</td></tr>
<tr><td><b> zeta                       </b></td><td> as pressure loss coefficient [-]. </td></tr>
</table>
</p>

<p>
Note that there is no significant difference for the calculation of the mean Nusselt number <b> Nu </b> at a uniform wall temperature (UWT) or a uniform heat flux (UHF) as heat transfer boundary in the turbulent regime (Bejan 2003, p.303).
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
The mean Nusselt number <b> Nu </b> representing the mean convective heat transfer coefficient <b> kc </b> is shown for Prandtl numbers of different fluids in the figures below. Here an inverse calculation of the mass flow rate <b> m_flow </b> out of a given mean Nusselt number <b> Nu </b> is shown.

<p>
<b>Neglecting pressure loss influence (roughness == 1):</b>
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/fig_kc_turbulent_KC_wopl.png\">

<p>
<b>Considering pressure loss influence (roughness == 2):</b>
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/fig_kc_turbulent_KC_wipl.png\">

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent\"> kc_turbulent </a> is also valid for this inverse calculation due to using the same functions.
</p>

<p>
Note that the higher the Prandtl number <b> Pr </b> there is a higher difference in Nusselt numbers <b> Nu </b> comparing the neglect and consideration of pressure loss.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
  <dt>Bejan,A.:</dt>
    <dd><b>Heat transfer handbook</b>.
    Wiley, 2003.</dd>
 <dt>Elmquist,H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>
 <dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>
"));
      end kc_turbulent_KC;

      record kc_turbulent_IN_con
        "Input record for function kc_turbulent and kc_turbulent_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_con(      final
            target=Dissipation.Utilities.Types.HeatTransferBoundary.UWTuDFF);

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent\">kc_turbulent </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC\">kc_turbulent_KC </a>.
</html>"));
      end kc_turbulent_IN_con;

      record kc_turbulent_IN_var
        "Input record for function kc_turbulent and kc_turbulent_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent\">kc_turbulent </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC\">kc_turbulent_KC </a>.
</html>"));
      end kc_turbulent_IN_var;

      function kc_twoPhaseOverall_KC
        "Local two phase heat transfer coefficient of straight pipe | horizontal or vertical boiling | horizontal condensation"

        //SOURCE_1: Bejan,A.: HEAT TRANSFER HANDBOOK, Wiley, 2003.
        //SOURCE_2: Gungor, K.E. and R.H.S. Winterton: A general correlation for flow boiling in tubes and annuli, Int.J. Heat Mass Transfer, Vol.29, p.351-358, 1986.

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC_IN_con
          IN_con annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC_IN_var
          IN_var annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Local two phase heat transfer coefficient";

      protected
        Real MIN=Modelica.Constants.eps;

        //Documentation
      algorithm
        kc := if IN_con.target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor then
          Modelica.Fluid.Dissipation.Utilities.Functions.HeatTransfer.TwoPhase.kc_twoPhase_boilingHorizontal_KC(
          IN_con, IN_var) else if IN_con.target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer then
          Modelica.Fluid.Dissipation.Utilities.Functions.HeatTransfer.TwoPhase.kc_twoPhase_boilingVertical_KC(
          IN_con, IN_var) else if IN_con.target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.CondHor then
          Modelica.Fluid.Dissipation.Utilities.Functions.HeatTransfer.TwoPhase.kc_twoPhase_condensationHorizontal_KC(
          IN_con, IN_var) else MIN;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>Calculation of local <b>two phase</b> heat transfer coefficient <b>kc_2ph </b>for (horizontal/vertical) <b>boiling</b> or (horizontal) <b>condensation</b> for an overall flow regime.</p>

<p><h4><font color=\"#ef9b13\">Restriction</font></h4></p>
<p>
<ul>
  <li>circular cross sectional area </li>
  <li>no subcooled boiling </li>
  <li>film condensation </li>
</ul>
</p>

<p><h4><font color=\"#ef9b13\">Geometry </font></h4></p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_straightPipe.png\">

<p><b><font style=\"color: #ef9b13; \">Calculation</font></b></p>
<p><b>Boiling in a horizontal pipe (target = 1):</b></p>
<p>
The local two phase heat transfer coefficient <b> kc_2ph </b> during boiling in a <b>horizontal</b> straight pipe for an overall regime is calculated according to <i>[Gungor/Winterton 1986, p.354, eq. 2]</i> :
</p>
<p>
<pre>
    kc_2ph = E_fc*E_fc_hor*kc_fc+S_nb+S_nb_hor*kc_nb
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> Bo</b>=qdot_A/(mdot_A*dh_lv)  </td><td> as boiling number [-],</td></tr>
<tr><td><b> dh_lv                         </b></td><td> as evaporation enthalpy [J/kg],</td></tr>
<tr><td><b> E_fc</b>=f(Bo,Fr_l,X_tt)      </td><td> as forced convection enhancement factor [-],</td></tr>
<tr><td><b> E_fc_hor</b> =f(Fr_l)         </td><td> as forced convection enhancement factor for horizontal straight pipes [-],</td></tr>
<tr><td><b> Fr_l                          </b></td><td> as Froude number assuming total mass flow rate flowing as liquid [-],</td></tr>
<tr><td><b> kc_2ph                        </b></td><td> as local two phase heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> kc_fc                         </b></td><td> as heat transfer coefficient considering forced convection [W/(m2K)],</td></tr>
<tr><td><b> kc_nb                         </b></td><td> as heat transfer coefficient considering nucleate boiling [W/(m2K)],</td></tr>
<tr><td><b> mdot_A                        </b></td><td> as total mass flow rate density [kg/(m2s)],</td></tr>
<tr><td><b> qdot_A                        </b></td><td> as heat flow rate density [W/m2],</td></tr>
<tr><td><b> Re_l                          </b></td><td> as Reynolds number assuming liquid mass flow rate flowing alone [-],</td></tr>
<tr><td><b> S_nb</b> =f(E_fc,Re_l)        </td><td> as suppression factor of nucleate boiling [-],</td></tr>
<tr><td><b> S_nb_hor</b> =f(Fr_l)         </td><td> as suppression factor of nucleate boiling for horizontal straight pipes [-],</td></tr>
<tr><td><b> x_flow                        </b></td><td> as mass flow rate quality [-],</td></tr>
<tr><td><b> X_tt</b> = f(x_flow)          </td><td> as Martinelli parameter [-].</td></tr>
</table>
</p>

<p><b>Boiling in a vertical pipe (target = 2):</b></p>
<p>
The local two phase heat transfer coefficient <b> kc_2ph </b> during boiling in a <b>vertical</b> straight pipe for an overall regime is calculated out of the correlations for boiling in a horizontal straight pipe, where the horizontal correction factors <b> E_fc_hor,S_nb_hor</b> are unity.
</p>
<p>
Please note that the correlations named above are not valid for subcooled boiling due to a different driving temperature for nucleate boiling and forced convection. At subcooled boiling there is no enhancement factor (no vapour generation) but the suppression factor remains effective.
</p>

<p><b>Condensation in a horizontal pipe (target = 3):</b></p>
<p>
The local two phase heat transfer coefficient <b> kc_2ph </b> during condensation in a <b>horizontal</b> straight pipe for an overall regime is calculated according to <i>[Shah 1979, p.548, eq. 8]</i> :
</p>
<p>
<pre>
  kc_2ph = kc_1ph*[(1 - x_flow)^0.8 + 3.8*x_flow^0.76*(1 - x_flow)^0.04/p_red^0.38]
</pre>
</p>

<p>
where the convective heat transfer coefficient <b> kc_1ph </b> assuming the total mass flow rate is flowing as liquid according to <i>[Shah 1979, p.548, eq. 5]</i> :
</p>

<p>
<pre>
  kc_1ph = 0.023*Re_l^0.8*Pr_l^0.4*lambda_l/d_hyd
 </pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_hyd                        </b></td><td> as hydraulic diameter [m],</td></tr>
<tr><td><b> kc_2ph                       </b></td><td> as local two phase heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><b> kc_1ph                       </b></td><td> as convective heat transfer coefficient assuming total mass flow rate is flowing as liquid [W/(m2K)],</td></tr>
<tr><td><b> lambda_l                     </b></td><td> as thermal conductivity of fluid  [W/(mK)],</td></tr>
<tr><td><b> pressure                     </b></td><td> as thermodynamic pressure of fluid [Pa],</td></tr>
<tr><td><b> p_crit                       </b></td><td> as critical pressure of fluid [Pa],</td></tr>
<tr><td><b> p_red</b> = pressure/p_crit  </td><td> as reduced pressure [-],</td></tr>
<tr><td><b> Pr_l                         </b></td><td> as Prandtl number assuming [-],</td></tr>
<tr><td><b> Re_l                         </b></td><td> as Reynolds number assuming <b>total</b> mass flow rate is flowing as liquid [-],</td></tr>
<tr><td><b> x_flow                       </b></td><td> as mass flow rate quality [-],</td></tr>
</table>
</p>

<p><h4><font color=\"#ef9b13\">Verification</font></h4></p>
<p>The local two phase heat transfer coefficient <b>kc_2ph </b> during for horizontal and vertical boiling as well as for horizontal condensation is shown for a straight pipe in the figures below.</p>

<p><b>Boiling in a horizontal pipe (target = 1):</b></p>
<p>
Here the validation of the two phase heat transfer coefficient is shown for boiling in a horizontal straight pipe.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/fig_kc_twoPhaseOverall_KC_4.png\"/>

<p>The two phase heat transfer coefficient (<b>kc_2ph </b>) w.r.t. <i>Gungor/Winterton</i> is shown in dependence of the mass flow rate quality (<b>x_flow </b>) for different mass flow rate densities (<b>mdot_A </b>). The validation has been done with measurement results from <i>Kattan/Thome</i> for R134a as medium.</p>
<p>
The two phase heat transfer coefficient increases with increasing mass flow rate quality up to a maximum value. After that there is a rapid decrease of (<b>kc_2ph </b>) with increasing (<b>x_flow </b>). This can be explained with a partial dryout of the pipe wall for a high mass flow rate quality.
</p>

<p><b>Condensation in a horizontal pipe (target = 3):</b></p>
<p>
Here the validation of the two phase heat transfer coefficient is shown for condensation in a horizontal straight pipe.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/fig_kc_twoPhaseOverall_KC_2.png\"/>

<p>The two phase heat transfer coefficient (<b>kc_2ph </b>) w.r.t. <i>Shah</i> is shown in dependence of the mass flow rate quality (<b>x_flow </b>) for different mass flow rate densities (<b>mdot_A </b>). The validation has been done with measurement results from <i>Dobson/Chato</i> for R134a as medium.</p>

<p><b><font style=\"color: #ef9b13; \">References</font></b></p>
<dl><dt>Bejan,A.: </dt>
        <dd><b>Heat transfer handbook</b>. Wiley, 2003. </dd>
    <dt>M.K. Dobson and J.C. Chato: </dt>
        <dd><b>Condensation in smooth horizontal tubes</b>. Journal of HeatTransfer, Vol.120, p.193-213, 1998. </dd>
    <dt>Gungor, K.E. and R.H.S. Winterton: </dt>
        <dd><b>A general correlation for flow boiling in tubes and annuli</b>, Int.J. Heat Mass Transfer, Vol.29, p.351-358, 1986. </dd>
    <dt>N. Kattan and J.R. Thome: </dt>
        <dd><b>Flow boiling in horizontal pipes: Part 2 - new heat transfer data for five refrigerants.</b>. Journal of Heat Transfer, Vol.120. p.148-155, 1998. </dd>
    <dt>Shah, M.M.: </dt>
<dd><b>A general correlation for heat transfer during film condensation inside pipes</b>. Int. J. Heat Mass Transfer, Vol.22, p.547-556, 1979.</dd>
</dl></html>

"));
      end kc_twoPhaseOverall_KC;

      record kc_twoPhaseOverall_KC_IN_con
        "Input record for function kc_twoPhaseOverall_KC"

        extends
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_con;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC\"> kc_twoPhaseOverall_KC </a>.
</html>"));
      end kc_twoPhaseOverall_KC_IN_con;

      record kc_twoPhaseOverall_KC_IN_var
        "Input record for function kc_twoPhaseOverall_KC"

        extends
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_var;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC\"> kc_twoPhaseOverall_KC </a>.
</html>"));
      end kc_twoPhaseOverall_KC_IN_var;
    end StraightPipe;
  end HeatTransfer;

  package PressureLoss "Package for calculation of pressure loss"
  extends Modelica.Icons.VariantsPackage;

    package Bend "Package for pressure loss calculation of bends"
    extends Modelica.Icons.VariantsPackage;

      function dp_curvedOverall_DP
        "Pressure loss of curved bend | calculate pressure loss | overall flow regime | surface roughness"

        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //SOURCE_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //SOURCE_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Lac 6 (Verification)
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Bend;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_con
          IN_con "Input record for function dp_curvedOverall_DP"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var
          IN_var "Input record for function dp_curvedOverall_DP"
          annotation (Dialog(group="Variable inputs"));
        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //output variables
        output SI.Pressure DP "Output for function dp_curvedOverall_DP";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=max(MIN, IN_con.d_hyd) "Hydraulic diameter";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Circular cross sectional area";
        Real frac_RD=max(MIN, IN_con.R_0/d_hyd) "Relative curvature radius";
        Real k=max(MIN, abs(IN_con.K)/d_hyd) "Relative roughness";
        Real delta=IN_con.delta*180/PI "Angle of turning";
        SI.Length L=IN_con.delta*IN_con.R_0 "Length of flow path";

        //SOURCE_1: p.336, sec.15: definition of flow regime boundaries
        SI.ReynoldsNumber Re_min=1 "Minium Reynolds number";
        SI.ReynoldsNumber Re_lam_max=6.5e3
          "Maximum Reynolds number for laminar regime (6.5e3)";
        SI.ReynoldsNumber Re_turb_min=4e4
          "Minimum Reynolds number for turbulent regime (4e4)";
        SI.ReynoldsNumber Re_turb_max=3e5
          "Maximum Reynolds number for turbulent regime (3e5)";
        SI.ReynoldsNumber Re_turb_const=1e6
          "Reynolds number for independence on pressure loss coefficient (1e6)";

        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(1e2, 754*Modelica.Math.exp(
            if k <= 0.007 then 0.0065/0.007 else 0.0065/k)))
          "Start of transition regime for increasing Reynolds number (leaving laminar regime)";

        //SOURCE_1: p.357, diag. 6-1: coefficients for local resistance coefficient [zeta_LOC]:
        //IN_con.R_0/IN_con.d_hyd <= 3
        Real A1=if delta <= 70 then 0.9*sin(delta*PI/180) else if delta >= 100 then
            0.7 + 0.35*delta/90 else 1.0
          "Coefficient considering effect for angle of turning on zeta_LOC";
        Real A2=if frac_RD > 2.0 then 6e2 else if frac_RD <= 2.0 and frac_RD >= 0.7 then
                  (if frac_RD > 1.0 then 1e3 else if frac_RD <= 1.0 and frac_RD > 0.7 then
                  3e3 else 6e3) else 4e3
          "Coefficient considering laminar regime on zeta_LOC";
        Real B1=if frac_RD >= 1.0 then 0.21*(frac_RD)^(-0.5) else 0.21*(frac_RD)^(-2.5)
          "Coefficient considering relative curvature radius (R_0/d_hyd) on zeta_LOC";
        Real C1=1.0
          "Considering relative elongation of cross sectional area on zeta_LOC (here: circular cross sectional area)";
        TYP.LocalResistanceCoefficient zeta_LOC_sharp_turb=max(MIN, A1*B1*C1)
          "Local resistance coefficient for turbulent regime (Re > Re_turb_max)";

        SI.ReynoldsNumber Re=max(Re_min, 4*abs(m_flow)/(PI*IN_con.d_hyd*IN_var.eta))
          "Reynolds number";

        //mass flow rate boundaries for w.r.t flow regimes
        SI.MassFlowRate m_flow_smooth=Re_min*PI*IN_con.d_hyd*IN_var.eta/4;

        //SOURCE_1: p.357, diag. 6-1, sec. 2 / p.336, sec. 15 (turbulent regime + hydraulically rough):
        //IN_con.R_0/IN_con.d_hyd < 3
        Real C_Re=if frac_RD > 0.7 then 11.5/Re^0.19 else if frac_RD <= 0.7 and
            frac_RD >= 0.55 then 5.45/Re^0.131 else 1 + 4400/Re
          "Correction factor for hydraulically rough turbulent regime (Re_turb_min < Re < Re_turb_max)";

        //SOURCE_1: p.357, diag. 6-1
        //IN_con.R_0/IN_con.d_hyd < 3
        TYP.LocalResistanceCoefficient zeta_LOC_sharp=if Re < Re_lam_leave then A2/Re
             + zeta_LOC_sharp_turb else if Re < Re_turb_min then SMOOTH(
            Re_lam_leave,
            Re_turb_min,
            Re)*(A2/max(Re_lam_leave, Re) + zeta_LOC_sharp_turb) + SMOOTH(
            Re_turb_min,
            Re_lam_leave,
            Re)*(C_Re*zeta_LOC_sharp_turb) else if Re < Re_turb_max then SMOOTH(
            Re_turb_min,
            Re_turb_max,
            Re)*(C_Re*zeta_LOC_sharp_turb) + SMOOTH(
            Re_turb_max,
            Re_turb_min,
            Re)*zeta_LOC_sharp_turb else zeta_LOC_sharp_turb
          "Local resistance coefficient for R_0/d_hyd < 3";

        TYP.LocalResistanceCoefficient zeta_LOC=zeta_LOC_sharp
          "Local resistance coefficient";

        //SOURCE_2: p.191, eq. 8.4: considering surface roughness
        //restriction of lambda_FRI at maximum Reynolds number Re=1e6 (SOURCE_2: p.207, sec. 9.2.4)
        TYP.DarcyFrictionFactor lambda_FRI_rough=0.25/(Modelica.Math.log10(k/(3.7*
            IN_con.d_hyd) + 5.74/min(1e6, max(Re_lam_leave, Re))^0.9))^2
          "Darcy friction factor considering surface roughness";

        //SOURCE_2: p.207, sec. 9.2.4: correction factors CF w.r.t.surface roughness
        Real CF_fri=1+SMOOTH(
            Re_lam_max,
            Re_lam_leave,
            Re)*min(1.4, (lambda_FRI_rough*L/d_hyd/zeta_LOC)) + SMOOTH(
            Re_lam_leave,
            Re_lam_max,
            Re) "Correction factor for surface roughness";

        TYP.PressureLossCoefficient zeta_TOT=max(1, CF_fri)*zeta_LOC
          "Pressure loss coefficient";

        //Documentation

      algorithm
        DP := zeta_TOT*(IN_var.rho/2)*
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
          m_flow,
          m_flow_smooth,
          2)/max(MIN, (IN_var.rho*A_cross)^2);
        annotation (
          smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
          inverse(m_flow=FD.dp_curvedOverall_MFLOW(
                IN_con,
                IN_var,
                DP)),
          Documentation(info="<html>
<p>Calculation of pressure loss in curved bends at overall flow regime for incompressible and single-phase fluid flow through circular cross sectional area considering surface roughness. </p>
<p>This function can be used to calculate both the pressure loss at known mass flow rate <b>or </b>mass flow rate at known pressure loss within one function in dependence of the known variable (dp or m_flow). </p>
<p>Generally this function is numerically best used for the <b>incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW\">dp_curvedOverall_MFLOW</a> is numerically best used for the <b>compressible case </b>if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. </p>
<p><h4><font color=\"#ef9b13\">Restriction</font></h4></p>
<p>This function shall be used inside of the restricted limits according to the referenced literature. </p>
<p><ul>
<li><h4>circular cross sectional area </h4></li>
<li><b>0.5 &le; curvature radius / diameter &le; 3 </b><i>[Idelchik 2006, p. 357, diag. 6-1] </i></li>
<li><b>length of bend along curved axis / diameter &ge; 10 </b><i>[Idelchik 2006, p. 357, diag. 6-1] </i></li>
<li><b>angle of curvature smaller than 180&deg; (delta &le; 180) </b><i>[Idelchik 2006, p. 357, diag. 6-1] </i></li>
</ul></p>
<p><b><font style=\"color: #ef9b13; \">Geometry</font></b> </p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/pic_circularBend.png\"/>

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
<li><b>Laminar regime (Re &le; Re_lam_leave)</b>: </li>
<pre>      zeta_LOC = A2/Re + A1*B1*C1</pre>
<li><b>Transition regime (Re_lam_leave &le; 4e4)</b> This calculation is done using a smoothing function interpolating between the laminar and the first turbulent flow regime. </li>
<li><b>Turbulent regime (4e4 &le; 3e5) with dependence </b>of local resistance coefficient on Reynolds number: </li>
<pre>      zeta_LOC = k_Re * (A1*B1*C1)</pre>
<p>where <b>k_Re</b> depends on the relative curvature radius <b>R_0/d_hyd </b></p>
<pre>
      k_Re = 1 + 4400/Re              for 0.50 &LT; r/d_hyd &LT; 0.55
      k_Re = 5.45/Re^(0.118)          for 0.55 &le; r/d_hyd &LT; 0.70
      k_Re = 11.5/Re^(0.19)           for 0.70 &le; r/d_hyd &LT; 3.00</pre>
<li><b>Turbulent regime (Re &ge; 3e5) with independence </b>of local resistance coefficient on Reynolds number </li>
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
<p>The pressure loss coefficient <b>zeta_TOT </b>of a curved bend including pressure loss due to friction is determined by its local resistance coefficient <b>zeta_LOC </b>multiplied with a correction factor <b>CF </b>for surface roughness according to <i>[Miller, p. 209, eq. 9.4]:</i> </p>
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
<p>Note that the beginning of the laminar regime cannot be beneath <b>Re &le; 1e2 </b>. </p>
<p><b><font style=\"color: #ef9b13; \">Verification</font></b> </p>
<p>The pressure loss coefficient <b>zeta_TOT </b>of a curved bend in dependence of the Reynolds number <b>Re </b>for different relative curvature radii <b>R_0/d_hyd </b>and different angles of turning <b>delta </b>is shown in the figures below. </p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/fig_bend_dp_curvedOverall_DPvsMFLOW.png\"/>

<p>There are deviations of the pressure loss coefficient <b>zeta_TOT </b>comparing different references. Usually these deviations in the transition regime have to be accepted due to an uncertainty for the determination of comparable boundary conditions in the different references. Nevertheless these calculations cover the usual range of pressure loss coefficients for a curved bend. The pressure loss coefficient <b>zeta_TOT </b>for the same geometry can be adjusted via variing the average height of surface asperities <b>K </b>for calibration. </p>
<p><b>Incompressible case </b>[Pressure loss = f(m_flow)]: </p>
<p>The pressure loss in dependence of the mass flow rate of water is shown for different relative curvature radii: </p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/fig_bend_dp_curvedOverall_DPvsMFLOWwrtRD.png\"/>

<p>The pressure loss in dependence of the mass flow rate of water is shown for different angles of turning: </p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/fig_bend_dp_curvedOverall_DPvsMFLOWwrtDelta.png\"/>

<p>Note that there is a small deviation between the compressible and incompressible calculation due to the lack of a direct analytical invertibility. </p>
<p><b><font style=\"color: #ef9b13; \">References</font></b> </p>
<dl>
<dt>Elmquist,H., M.Otter and S.E. Cellier: </dt>
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
      end dp_curvedOverall_DP;

      function dp_curvedOverall_MFLOW
        "Pressure loss of curved bend | calculate mass flow rate | overall flow regime | surface roughness"

        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //SOURCE_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //SOURCE_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Lac 6 (Verification)
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Bend;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_con
          IN_con "Input record for function dp_curvedOverall_MFLOW"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var
          IN_var "Input record for function dp_curvedOverall_MFLOW"
          annotation (Dialog(group="Variable inputs"));
        input SI.Pressure dp "Pressure loss" annotation (Dialog(group="Input"));

        //output variables
        output SI.MassFlowRate M_FLOW
          "Output for function dp_curvedOverall_MFLOW";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=max(MIN, IN_con.d_hyd) "Hydraulic diameter";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Circular cross sectional area";
        Real frac_RD=max(MIN, IN_con.R_0/d_hyd) "Relative curvature radius";
        Real k=max(MIN, abs(IN_con.K)/d_hyd) "Relative roughness";
        Real delta=IN_con.delta*180/PI "Angle of turning";
        SI.Length L=IN_con.delta*IN_con.R_0 "Length of flow path";

        //SOURCE_1: p.336, sec.15: definition of flow regime boundaries
        SI.ReynoldsNumber Re_min=1 "Minium Reynolds number";
        SI.ReynoldsNumber Re_lam_max=6.5e3
          "Maximum Reynolds number for laminar regime (6.5e3)";
        SI.ReynoldsNumber Re_turb_min=4e4
          "Minimum Reynolds number for turbulent regime (4e4)";
        SI.ReynoldsNumber Re_turb_max=3e5
          "Maximum Reynolds number for turbulent regime (3e5)";
        SI.ReynoldsNumber Re_turb_const=1e6
          "Reynolds number for independence on pressure loss coefficient (1e6)";

        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(1e2, 754*Modelica.Math.exp(
            if k <= 0.007 then 0.0065/0.007 else 0.0065/k)))
          "Start of transition regime for increasing Reynolds number (leaving laminar regime)";

        //SOURCE_1: p.357, diag. 6-1: coefficients for local resistance coefficient [zeta_LOC]:
        //IN_con.R_0/IN_con.d_hyd <= 3
        Real A1=if delta <= 70 then 0.9*sin(delta/180*PI) else if delta >= 100 then
            0.7 + 0.35*delta/90 else 1.0
          "Coefficient considering effect for angle of turning on zeta_LOC";
        Real A2=if frac_RD > 2.0 then 6e2 else if frac_RD <= 2.0 and frac_RD >= 0.7 then
                  (if frac_RD > 1.0 then 1e3 else if frac_RD <= 1.0 and frac_RD > 0.7 then
                  3e3 else 6e3) else 4e3
          "Coefficient considering laminar regime on zeta_LOC";
        Real B1=if frac_RD >= 1.0 then 0.21*(frac_RD)^(-0.5) else 0.21*(frac_RD)^(-2.5)
          "Coefficient considering relative curvature radius (R_0/d_hyd) on zeta_LOC";
        Real C1=1.0
          "Considering relative elongation of cross sectional area on zeta_LOC (here: circular cross sectional area)";
        TYP.LocalResistanceCoefficient zeta_LOC_sharp_turb=max(MIN, A1*B1*C1)
          "Local resistance coefficient for turbulent regime (Re > Re_turb_max)";

        //SOURCE_1: p.357, diag. 6-1: pressure loss boundaries for w.r.t flow regimes
        //IN_con.R_0/d_hyd <=3
        SI.AbsolutePressure dp_lam_max=(zeta_LOC_sharp_turb + A2/Re_lam_leave)*IN_var.rho
            /2*(Re_lam_leave*IN_var.eta/(IN_var.rho*d_hyd))^2
          "Maximum pressure loss for laminar regime";
        SI.AbsolutePressure dp_turb_min=zeta_LOC_sharp_turb*(if frac_RD > 0.7 then
            11.5/Re_turb_min^0.19 else if frac_RD <= 0.7 and frac_RD >= 0.55 then
            5.45/Re_turb_min^0.131 else 1 + 4400/Re_turb_min)*IN_var.rho/2*(
            Re_turb_min*IN_var.eta/(IN_var.rho*d_hyd))^2
          "Minimum pressure loss for turbulent regime";
        SI.AbsolutePressure dp_turb_max=zeta_LOC_sharp_turb*(if frac_RD > 0.7 then
            11.5/Re_turb_max^0.19 else if frac_RD <= 0.7 and frac_RD >= 0.55 then
            5.45/Re_turb_max^0.131 else 1 + 4400/Re_turb_max)*IN_var.rho/2*(
            Re_turb_max*IN_var.eta/(IN_var.rho*d_hyd))^2
          "Maximum pressure loss for turbulent regime";
        SI.AbsolutePressure dp_turb_const=zeta_LOC_sharp_turb*IN_var.rho/2*(
            Re_turb_const*IN_var.eta/(IN_var.rho*d_hyd))^2
          "Pressure loss for independence of Reynolds number on pressure loss coefficient";

        //SOURCE_1: p.357, diag. 6-1: mean velocities for assumed flow regime
        //IN_con.R_0/d_hyd <=3
        SI.Velocity v_lam=(-A2/2*IN_var.eta + 0.5*sqrt(max(MIN, (A2*IN_var.eta)^2 + 8
            *zeta_LOC_sharp_turb*abs(dp)*IN_var.rho*d_hyd^2)))/zeta_LOC_sharp_turb/
            IN_var.rho/d_hyd
          "Mean velocity in laminar regime (Re < Re_lam_leave)";
        SI.Velocity v_tra=(-A2/2*IN_var.eta + 0.5*sqrt(max(MIN, (A2*IN_var.eta)^2 + 8
            *zeta_LOC_sharp_turb*abs(dp_lam_max)*IN_var.rho*d_hyd^2)))/
            zeta_LOC_sharp_turb/IN_var.rho/d_hyd
          "Mean velocity in transition regime (Re_lam_leave < Re_turb_min)";
        SI.Velocity v_turb=if frac_RD > 0.7 then (max(MIN, abs(dp))/(IN_var.rho/2*
            11.5*zeta_LOC_sharp_turb)*(IN_var.rho*IN_con.d_hyd/max(MIN, IN_var.eta))^
            0.19)^(1/(2 - 0.19)) else if frac_RD > 0.55 and frac_RD < 0.7 then (max(
            MIN, abs(dp))/(IN_var.rho/2*5.45*zeta_LOC_sharp_turb)*(IN_var.rho*IN_con.d_hyd
            /max(MIN, IN_var.eta))^0.131)^(1/(2 - 0.131)) else -2200/(IN_var.rho*
            IN_con.d_hyd/IN_var.eta) + ((-2200/(IN_var.rho*IN_con.d_hyd/max(MIN,
            IN_var.eta)))^2 + 2*abs(max(MIN, dp))/max(MIN, IN_var.rho))^0.5
          "Mean velocity in turbulent regime with dependence on pressure loss coefficient (Re_turb_min < Re < Re_turb_max)";
        SI.Velocity v_turb_const=sqrt(max(MIN, 2*abs(dp)/(IN_var.rho*
            zeta_LOC_sharp_turb)))
          "Mean velocity in turbulent regime with independence on pressure loss coefficient (Re > Re_turb_max)";

        //mean velocity under smooth conditions w.r.t flow regime
        SI.Velocity v_smooth=if dp < dp_lam_max then v_lam else if dp < dp_turb_min then
                  SMOOTH(
            dp_lam_max,
            dp_turb_min,
            dp)*v_lam + SMOOTH(
            dp_turb_min,
            dp_lam_max,
            dp)*v_turb else if dp < dp_turb_max then v_turb else SMOOTH(
            dp_turb_max,
            dp_turb_const,
            dp)*v_turb + SMOOTH(
            dp_turb_const,
            dp_turb_max,
            dp)*v_turb_const
          "Mean velocity under smooth conditions for R_0/d_hyd < 3";

        SI.ReynoldsNumber Re_smooth=max(Re_min, IN_var.rho*v_smooth*d_hyd/IN_var.eta)
          "Reynolds number under smooth conditions";

        //SOURCE_2: p.191, eq. 8.4: considering surface roughness
        //restriction of lambda_FRI at maximum Reynolds number Re=1e6 (SOURCE_2: p.207, sec. 9.2.4)
        TYP.DarcyFrictionFactor lambda_FRI_rough=0.25/(Modelica.Math.log10(k/(3.7*
            IN_con.d_hyd) + 5.74/min(1e6, max(Re_lam_leave, Re_smooth))^0.9))^2
          "Darcy friction factor considering surface roughness";
        TYP.DarcyFrictionFactor lambda_FRI_smooth=0.25/(Modelica.Math.log10(5.74/max(
            Re_lam_leave, Re_smooth)^0.9))^2
          "Darcy friction factor neglecting surface roughness";

        //SOURCE_2: p.207, sec. 9.2.4: correction factors CF w.r.t.surface roughness
        Real CF_3=1+SMOOTH(
            6e3,
            1e3,
            Re_smooth)*min(1.4, (lambda_FRI_rough*L/d_hyd/zeta_LOC_sharp_turb)) + SMOOTH(
            1e3,
            6e3,
            Re_smooth) "Correction factor for surface roughness";

        SI.Velocity velocity=v_smooth/max(1, CF_3)^(0.5)
          "Corrected velocity considering surface roughness";

        //Documentation

      algorithm
        M_FLOW := sign(dp)*IN_var.rho*A_cross*abs(velocity);

        annotation (
          smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
          inverse(dp=FD.dp_curvedOverall_DP(
                IN_con,
                IN_var,
                M_FLOW)),
          Documentation(info="<html>
<p>
Calculation of pressure loss in curved bends at overall flow regime for incompressible and single-phase fluid flow through circular cross sectional area considering surface roughness.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this function is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP\">dp_curvedOverall_DP</a> is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used inside of the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> circular cross sectional area </b>
 </li>
 <li>
      <b> 0.5 &le; curvature radius / diameter &le; 3 </b> <i>[Idelchik 2006, p. 357, diag. 6-1] </i>
 </li>
 <li>
      <b> length of bend along curved axis / diameter &ge; 10 </b> <i>[Idelchik 2006, p. 357, diag. 6-1] </i>
 </li>
  <li>
      <b> angle of curvature smaller than 180° (delta &le; 180) </b> <i>[Idelchik 2006, p. 357, diag. 6-1] </i>
 </li>
</ul>

<p>
<h4><font color=\"#EF9B13\">Geometry</font></h4>
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/pic_circularBend.png\"/>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The pressure loss <b> dp </b> for curved bends is determined by:
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

<b> Curved bends with relative curvature radius R_0/d_hyd &le; 3 </b> according to <i>[Idelchik 2006, p. 357, diag. 6-1]</i>
<p>
The pressure loss of curved bends is similar to its calculation in straight pipes. There are tree different flow regimes observed (laminar,transition,turbulent). The turbulent regime is further separated into sections with a dependence or independence of the local resistance coefficient (<b>zeta_LOC </b>) on Reynolds number. The local resistance coefficient (<b>zeta_LOC</b>) of a curved bend is calculated in dependence of the flow regime as follows:
</p>
<ul>
  <li> <b>Laminar regime (Re &le; Re_lam_leave)</b>:
     <br><br>
     <pre>
      zeta_LOC = A2/Re + A1*B1*C1
     </pre>
  <li> <b>Transition regime (Re_lam_leave &le; 4e4)</b>
        This calculation is done using a smoothing function interpolating between the laminar and the first turbulent flow regime.
  <li> <b>Turbulent regime (4e4 &le; 3e5) with dependence </b> of local resistance coefficient on Reynolds number:
     <br><br>
     <pre>
      zeta_LOC = k_Re * (A1*B1*C1)
     </pre>
       where <b>k_Re</b> depends on the relative curvature radius <b> R_0/d_hyd </b>
     <pre>
      k_Re = 1 + 4400/Re              for 0.50 &lt; r/d_hyd &lt; 0.55
      k_Re = 5.45/Re^(0.118)          for 0.55 &le; r/d_hyd &lt; 0.70
      k_Re = 11.5/Re^(0.19)           for 0.70 &le; r/d_hyd &lt; 3.00
     </pre>
  <li> <b>Turbulent regime (Re &ge; 3e5) with independence </b> of local resistance coefficient on Reynolds number
     <br><br>
     <pre>
      zeta_LOC = A1*B1*C1
     </pre>
</ul>

<p>
with
</p>

<p>
<table>
<tr><td><b> A1            </b></td><td> as coefficient considering effect of angle of turning (delta) [-],</td></tr>
<tr><td><b> A2            </b></td><td> as coefficient considering effect for laminar regime [-],</td></tr>
<tr><td><b> B1            </b></td><td> as coefficient considering effect of relative curvature radius (R_0/d_hyd) [-],</td></tr>
<tr><td><b> C1=1          </b></td><td> as coefficient considering relative elongation of cross sectional area (here: circular cross sectional area) [-],</td></tr>
<tr><td><b> k_Re          </b></td><td> as coefficient considering influence of laminar regime in transition regime [-],</td></tr>
<tr><td><b> Re            </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<p>The pressure loss coefficient <b>zeta_TOT </b>of a curved bend including pressure loss due to friction is determined by its local resistance coefficient <b>zeta_LOC </b>multiplied with a correction factor <b>CF </b>for surface roughness according to <i>[Miller, p. 209, eq. 9.4]:</i> </p>
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
Note that the beginning of the laminar regime cannot be beneath <b> Re &le; 1e2 </b>.
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The pressure loss coefficient <b> zeta_TOT </b> of a curved bend in dependence of the Reynolds number <b> Re </b> for different relative curvature radii <b> R_0/d_hyd </b> and different angles of turning <b> delta </b> is shown in the figures below.

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/fig_bend_dp_curvedOverall_DPvsMFLOW.png\">

<p>
There are deviations of the pressure loss coefficient <b> zeta_TOT </b> comparing different references. Usually these deviations in the transition regime have to be accepted due to an uncertainty for the determination of comparable boundary conditions in the different references. Nevertheless these calculations cover the usual range of pressure loss coefficients for a curved bend. The pressure loss coefficient <b> zeta_TOT </b> for the same geometry can be adjusted via variing the average height of surface asperities <b> K </b> for calibration.
</p>

<p>
<b> Compressible case </b> [Mass flow rate = f(dp)]:
</p>
<p>
The mass flow rate in dependence of the pressure loss of water of water is shown for different relative curvature radii:
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/fig_bend_dp_curvedOverall_DPvsMFLOWwrtRD.png\">

<p>
The mass flow rate in dependence of the pressure loss of water is shown for different angles of turning:
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/fig_bend_dp_curvedOverall_DPvsMFLOWwrtDelta.png\">

<p>
Note that there is a small deviation between the compressible and incompressible calculation due to the lack of a direct analytical invertibility.
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
      end dp_curvedOverall_MFLOW;

      record dp_curvedOverall_IN_con
        "Input record for function dp_curvedOverall, dp_curvedOverall_DP and dp_curvedOverall_MFLOW"

        //bend variables
        extends Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.Bend;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall\"> dp_curvedOverall </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP\"> dp_curvedOverall_DP </a>
and <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW\"> dp_curvedOverall_MFLOW </a>.
</html>"));
      end dp_curvedOverall_IN_con;

      record dp_curvedOverall_IN_var
        "Input record for function dp_curvedOverall, dp_curvedOverall_DP and dp_curvedOverall_MFLOW"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall\"> dp_curvedOverall </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP\"> dp_curvedOverall_DP </a>
and <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW\"> dp_curvedOverall_MFLOW </a>.
</html>"));
      end dp_curvedOverall_IN_var;

      function dp_edgedOverall_DP
        "Pressure loss of edged bend | calculate pressure loss | overall flow regime | surface roughness"

        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //SOURCE_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //SOURCE_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Lac 6 (Verification)
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Bend;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.BendEdged_d;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con
          IN_con "Input record for function dp_edgedOverall_DP"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var
          IN_var "Input record for function dp_edgedOverall_DP"
          annotation (Dialog(group="Variable inputs"));
        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //output variables
        output SI.Pressure DP "Output for function dp_edgedOverall_DP";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=max(MIN, IN_con.d_hyd) "Hydraulic diameter";
        SI.Area A_cross=PI*d_hyd^2/4 "Circular cross sectional area";
        Real k=max(MIN, abs(IN_con.K)/IN_con.d_hyd) "Relative roughness";
        Real delta=IN_con.delta*180/PI "Angle of turning";

        //definition of flow regime boundaries
        //SOURCE_2: p.207, sec. 9.2.4
        //SOURCE_3: p.Lac 6, fig. 16
        SI.ReynoldsNumber Re_min=1 "Minium Reynolds number";
        SI.ReynoldsNumber Re_lam_min=1e3
          "Minimum Reynolds number for laminar regime (1e2)";
        SI.ReynoldsNumber Re_lam_max=4e4
          "Maximum Reynolds number for laminar regime (1e3)";
        SI.ReynoldsNumber Re_turb_min=1e5
          "Minimum Reynolds number for turbulent regime (1e5)";
        SI.ReynoldsNumber Re_turb_max=3e5
          "Maximum Reynolds number for turbulent regime (2e5)";
        SI.ReynoldsNumber Re_turb_const=1e6
          "Reynolds number for independence on pressure loss coefficient (1e6)";

        //SOURCE_1: p. 81, sec. 2-2-21: start of transition regime
        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754*
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k)))
          "Start of transition regime for increasing Reynolds number (leaving laminar regime)";

        //SOURCE_1: p.366, diag. 6-7
        Real A=0.95 + 33.5/max(MIN, delta)
          "Coefficient considering effect of angle of turning on zeta_LOC";
        Real C1=1
          "Considering relative elongation of cross sectional area on zeta_LOC (here: circular cross sectional area)";

        //SOURCE_1: p.366, diag. 6-7
        TYP.LocalResistanceCoefficient zeta_LOC=max(MIN, 0.95*sin(PI/180*delta/2)^2
             + 2.05*sin(PI/180*delta/2)^4) "Local resistance coefficient";

        //SOURCE_1: p.344, sec. 39/29: Correction w.r.t. effect of Reynolds number in laminar regime
        Real B=0.0292*(delta)^2 + 1.1995*delta
          "Coefficient considering effect of Reynolds number in laminar regime";
        Real exp=1 "Exponent for Reynolds number correction in laminar regime";

        Real v_min=Re_min*IN_var.eta/(IN_var.rho*d_hyd)
          "Minimum mean velocity for linear interpolation";

        SI.Velocity velocity=m_flow/(IN_var.rho*A_cross) "Mean velocity";
        SI.ReynoldsNumber Re=max(Re_min, IN_var.rho*abs(velocity)*d_hyd/IN_var.eta)
          "Reynolds number";

        //SOURCE_2: p.191, eq. 8.4: considering surface roughness
        //restriction of lambda_FRI at maximum Reynolds number Re=1e6 (SOURCE_2: p.207, sec. 9.2.4)
        TYP.DarcyFrictionFactor lambda_FRI_rough=0.25/(Modelica.Math.log10(k/(3.7*
            IN_con.d_hyd) + 5.74/min(Re_turb_const, max(Re_lam_leave, Re))^0.9))^2
          "Darcy friction factor considering surface roughness";
        TYP.DarcyFrictionFactor lambda_FRI_smooth=0.25/(Modelica.Math.log10(5.74/min(
            Re_turb_const, max(Re_lam_leave, Re))^0.9))^2
          "Darcy friction factor neglecting surface roughness";

        //SOURCE_2: p.207, sec. 9.2.4: correction factors CF w.r.t.surface roughness
        //SOURCE_2: p.214, sec. 9.4.2: no correction w.r.t. surface roughness for angle of turning >= 45°
        Real CF_fri=if delta <= 45 then max(1, min(1.4, (lambda_FRI_rough/
            lambda_FRI_smooth))) else 1
          "Correction factor for surface roughness";

        //SOURCE_2: p.208, diag. 9.3: Correction w.r.t. effect of Reynolds number
        Real CF_Re=SMOOTH(
            Re_min,
            Re_lam_leave,
            Re)*B/Re^exp + SMOOTH(
            Re_lam_leave,
            Re_min,
            Re) "Correction factor for Reynolds number";

        TYP.PressureLossCoefficient zeta_TOT=A*C1*zeta_LOC*CF_fri*CF_Re
          "Pressure loss coefficient";

        //Documentation

      algorithm
        DP := zeta_TOT*(IN_var.rho/2)*
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                velocity,
                v_min,
                2);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(m_flow=FD.dp_edgedOverall_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of pressure loss in edged bends with sharp corners at overall flow regime for incompressible and single-phase fluid flow through circular cross sectional area considering surface roughness.
</p>

There are larger pressure losses in an edged bend compared to a curved bend under the same conditions. The effect of a sharp corner in an edged bend on the pressure loss is much larger than the influence of surface roughness.

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this function is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW\">dp_edgedOverall_MFLOW</a> is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
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
      <b> 0° &le; angle of turning &le; 180° </b> <i>[Idelchik 2006, p. 338, sec. 19] </i>
 </li>
 <li>
      <b> length of edged bend along edged axis / diameter &ge; 10 </b> <i>[Idelchik 2006, p. 366, diag. 6-7] </i>
 </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry</font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/pic_edgedBend.png\">

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
Note that the Darcy friction factor for a smooth surface <b> lambda_FRI_smooth </b> is calculated with the previous equation and an absolute roughness of <b> K = 0 </b>. Additionally no influence of surface roughness is considered for angles of turning equal or smaller than 45° according to <i>[Miller 1984, p. 214, eq. 9.4.2]</i>.
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

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/fig_bend_dp_edgedOverall_ZETAvsRE.png\">

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
      <b> dependent turbulent regime on Reynolds number </b> for 2e3 &le; Re &le; 1e5
 <li>
      <b> independent turbulent regime of Reynolds number </b> for Re &ge; 1e5
</ul>
</p>

<p>
<b> Incompressible case </b> [Pressure loss = f(m_flow)]:
</p>
<p>
The pressure loss in dependence of the mass flow rate of water is shown for different angles of turning:
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/fig_bend_dp_edgedOverall_DPvsMFLOWwrtDelta.png\">

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
      end dp_edgedOverall_DP;

      function dp_edgedOverall_MFLOW
        "Pressure loss of edged bend | calculate mass flow rate | overall flow regime | surface roughness"

        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //SOURCE_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //SOURCE_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Lac 6 (Verification)
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Bend;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.BendEdged_d;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con
          IN_con "Input record for function dp_edgedOverall_MFLOW"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var
          IN_var "Input record for function dp_edgedOverall_MFLOW"
          annotation (Dialog(group="Variable inputs"));
        input SI.Pressure dp "Pressure loss" annotation (Dialog(group="Input"));

        //output variables
        output SI.MassFlowRate M_FLOW
          "Output for function dp_edgedOverall_MFLOW";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=IN_con.d_hyd "Hydraulic diameter";
        SI.Area A_cross=PI*d_hyd^2/4 "Circular cross sectional area";
        Real k=max(MIN, abs(IN_con.K)/IN_con.d_hyd) "Relative roughness";
        Real delta=IN_con.delta*180/PI "Angle of turning";

        //definition of flow regime boundaries
        //SOURCE_2: p.207, sec. 9.2.4
        //SOURCE_3: p.Lac 6, fig. 16
        SI.ReynoldsNumber Re_min=1 "Minium Reynolds number";
        SI.ReynoldsNumber Re_lam_min=1e3
          "Minimum Reynolds number for laminar regime (1e2)";
        SI.ReynoldsNumber Re_lam_max=4e4
          "Maximum Reynolds number for laminar regime (1e3)";
        SI.ReynoldsNumber Re_turb_min=1e5
          "Minimum Reynolds number for turbulent regime (1e5)";
        SI.ReynoldsNumber Re_turb_max=3e5
          "Maximum Reynolds number for turbulent regime (2e5)";
        SI.ReynoldsNumber Re_turb_const=1e6
          "Reynolds number for independence on pressure loss coefficient (1e6)";

        //SOURCE_1: p. 81, sec. 2-2-21: start of transition regime
        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754*
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k)))
          "Start of transition regime for increasing Reynolds number (leaving laminar regime)";

        //SOURCE_1: p.366, diag. 6-7
        Real A=0.95 + 33.5/max(MIN, delta)
          "Coefficient considering effect of angle of turning on zeta_LOC";
        Real C1=1
          "Considering relative elongation of cross sectional area on zeta_LOC (here: circular cross sectional area)";

        //SOURCE_1: p.366, diag. 6-7
        TYP.LocalResistanceCoefficient zeta_LOC=max(MIN, 0.95*sin(PI/180*delta/2)^2
             + 2.05*sin(PI/180*delta/2)^4) "Local resistance coefficient";

        //SOURCE_1: p.344, sec. 39/29: Correction w.r.t. effect of Reynolds number in laminar regime
        Real B=0.0292*(delta)^2 + 1.1995*delta
          "Coefficient considering effect of Reynolds number on zeta_TOT";
        Real exp=1 "Exponent for Reynolds number correction in laminar regime";
        Real pow=(2 - exp) "pressure loss = f(mass flow rate^pow)";

        SI.Pressure dp_min=1
          "Linear smoothing of mass flow rate for decreasing pressure loss";
        SI.Velocity v_lam=Re_lam_leave*IN_var.eta/(IN_var.rho*d_hyd)
          "Maximum mean velocity in laminar regime (Re < Re_lam_leave)";
        Real dp_lam=A*C1*zeta_LOC*(B/2)*(d_hyd/IN_var.eta)^(-exp)*IN_var.rho^(1 - exp)
            *v_lam^(pow)
          "Maximum pressure loss in laminar regime (Re < Re_lam_leave)";

        //mean velocity under smooth conditions w.r.t. flow regime
        SI.Velocity v_smooth=if abs(dp) > dp_lam then (2*abs(dp))^0.5*(A*C1*zeta_LOC*
            IN_var.rho)^(-0.5) else (2*(d_hyd/IN_var.eta)^exp/(A*C1*zeta_LOC*B*(
            IN_var.rho)^(1 - exp)))^(1/pow)*
            Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
            abs(dp),
            dp_min,
            1/pow) "Mean velocity under smooth conditions";

        SI.ReynoldsNumber Re_smooth=max(Re_min, IN_var.rho*v_smooth*d_hyd/IN_var.eta)
          "Reynolds number under smooth conditions";

        //SOURCE_2: p.191, eq. 8.4: considering surface roughness
        //restriction of lambda_FRI at maximum Reynolds number Re=1e6 (SOURCE_2: p.207, sec. 9.2.4)
        TYP.DarcyFrictionFactor lambda_FRI_rough=0.25/(Modelica.Math.log10(k/(3.7*
            IN_con.d_hyd) + 5.74/min(Re_turb_const, max(Re_lam_leave, Re_smooth))^0.9))
            ^2 "Darcy friction factor considering surface roughness";
        TYP.DarcyFrictionFactor lambda_FRI_smooth=0.25/(Modelica.Math.log10(5.74/min(
            Re_turb_const, max(Re_lam_leave, Re_smooth))^0.9))^2
          "Darcy friction factor neglecting surface roughness";

        //SOURCE_2: p.207, sec. 9.2.4: correction factors CF w.r.t.surface roughness
        //SOURCE_2: p.214, sec. 9.4.2: no correction w.r.t. surface roughness for angle of turning >= 45°
        Real CF_fri=if delta <= 45 then max(1, min(1.4, (lambda_FRI_rough/
            lambda_FRI_smooth))) else 1
          "Correction factor for surface roughness";

        SI.Velocity velocity=v_smooth/max(1, CF_fri)^(0.5)
          "Corrected velocity considering surface roughness";

        //Documentation

      algorithm
        M_FLOW := sign(dp)*IN_var.rho*A_cross*velocity;

        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(dp=FD.dp_edgedOverall_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of pressure loss in edged bends with sharp corners at overall flow regime for incompressible and single-phase fluid flow through circular cross sectional area considering surface roughness.
</p>

<p>
There are larger pressure losses in an edged bend compared to a curved bend under the same conditions. The effect of a sharp corner in an edged bend on the pressure loss is much larger than the influence of surface roughness.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this function is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP\">dp_edgedOverall_DP</a> is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.
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
      <b> 0° &le; angle of turning &le; 180° </b> <i>[Idelchik 2006, p. 338, sec. 19] </i>
 </li>
 <li>
      <b> length of edged bend along edged axis / diameter &ge; 10 </b> <i>[Idelchik 2006, p. 366, diag. 6-7] </i>
 </li>
</ul>

<h4><font color=\"#EF9B13\">Geometry</font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/pic_edgedBend.png\">

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
Note that the Darcy friction factor for a smooth surface <b> lambda_FRI_smooth </b> is calculated with the previous equation and an absolute roughness of <b> K = 0 </b>. Additionally no influence of surface roughness is considered for angles of turning equal or smaller than 45° according to <i>[Miller 1984, p. 214, eq. 9.4.2]</i>.
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

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/fig_bend_dp_edgedOverall_ZETAvsRE.png\">

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
      <b> dependent turbulent regime on Reynolds number </b> for 2e3 &le; Re &le; 1e5
 <li>
      <b> independent turbulent regime of Reynolds number </b> for Re &ge; 1e5
</ul>
</p>

<p>
<b> Compressible case </b> [Mass flow rate = f(dp)]:
</p>
<p>
The mass flow rate in dependence of the pressure loss of water is shown for different angles of turning:
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/fig_bend_dp_edgedOverall_MFLOWvsDPwrtDelta.png\">

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
      end dp_edgedOverall_MFLOW;

      record dp_edgedOverall_IN_con
        "Input record for function dp_edgedOverall, dp_edgedOverall_DP and  dp_edgedOverall_MFLOW"

        //bend variables
        extends Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.Bend(final R_0=0);

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the  pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall\"> dp_edgedOverall </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP\"> dp_edgedOverall_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW\"> dp_edgedOverall_MFLOW </a>.
</html>"));
      end dp_edgedOverall_IN_con;

      record dp_edgedOverall_IN_var
        "Input record for function dp_edgedOverall, dp_edgedOverall_DP and  dp_edgedOverall_MFLOW"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;
        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the  pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall\"> dp_edgedOverall </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP\"> dp_edgedOverall_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW\"> dp_edgedOverall_MFLOW </a>.
</html>"));
      end dp_edgedOverall_IN_var;
    end Bend;

    package Channel "Package for pressure loss calculation of channels"
    extends Modelica.Icons.VariantsPackage;

      function dp_internalFlowOverall_DP
        "Pressure loss of internal flow | calculate pressure loss | overall flow regime | surface roughness | several geometries"

        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //SOURCE_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 1978.
        //SOURCE_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Channel;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Channel_d;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_IN_con
          IN_con "Input record for function dp_internalFlowOverall_DP"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_IN_var
          IN_var "Input record for function dp_internalFlowOverall_DP"
          annotation (Dialog(group="Variable inputs"));
        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //output variables
        output SI.Pressure DP "Output for function dp_internalFlowOverall_DP";

      protected
        type TYP =
            Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow;

        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=max(MIN, if IN_con.geometry == TYP.Annular then (PI/4)*((
            IN_con.D_ann)^2 - (IN_con.d_ann)^2) else if IN_con.geometry == TYP.Circular then
                  PI/4*(IN_con.d_cir)^2 else if IN_con.geometry == TYP.Elliptical then
                  PI*IN_con.a_ell*IN_con.b_ell else if IN_con.geometry == TYP.Rectangular then
                  IN_con.a_rec*IN_con.b_rec else if IN_con.geometry == TYP.Isosceles then
                  0.5*(IN_con.a_tri*IN_con.h_tri) else 0)
          "Cross sectional area";
        SI.Length perimeter=max(MIN, if IN_con.geometry == TYP.Annular then PI*(
            IN_con.D_ann + IN_con.d_ann) else if IN_con.geometry == TYP.Circular then
                  PI*IN_con.d_cir else if IN_con.geometry == TYP.Elliptical then PI*(
            IN_con.a_ell + IN_con.b_ell) else if IN_con.geometry == TYP.Rectangular then
                  2*(IN_con.a_rec + IN_con.b_rec) else if IN_con.geometry == TYP.Isosceles then
                  IN_con.a_tri + 2*((IN_con.h_tri)^2 + (IN_con.a_tri/2)^2)^0.5 else 0)
          "Perimeter";
        SI.Diameter d_hyd=4*A_cross/perimeter "Hydraulic diameter";
        Real beta=IN_con.beta*180/PI "Top angle";

        //SOURCE_2: p.138, sec 8.5
        Real Dd_ann=min(max(MIN, IN_con.d_ann), IN_con.D_ann)/max(MIN, max(IN_con.d_ann,
            IN_con.D_ann))
          "Ratio of small to large diameter of annular geometry";
        Real CF_ann=98.7378*Dd_ann^0.0589
          "Correction factor for annular geometry";
        Real ab_rec=min(IN_con.a_rec, IN_con.b_rec)/max(MIN, max(IN_con.a_rec, IN_con.b_rec))
          "Aspect ratio of rectangular geometry";
        Real CF_rec=-59.85*(ab_rec)^3 + 148.67*(ab_rec)^2 - 128.1*(ab_rec) + 96.1
          "Correction factor for rectangular geometry";
        Real ab_ell=min(IN_con.a_ell, IN_con.b_ell)/max(MIN, max(IN_con.a_ell, IN_con.b_ell))
          "Ratio of small to large length of annular geometry";
        Real CF_ell=-169.2211*(ab_ell)^4 + 260.9028*(ab_ell)^3 - 113.7890*(ab_ell)^2
             + 9.2588*(ab_ell)^1 + 78.7124
          "Correction factor for elliptical geometry";
        Real CF_tri=-0.0013*(min(90, beta))^2 + 0.1577*(min(90, beta)) + 48.5575
          "Correction factor for triangular geometry";
        Real CF_lam=if IN_con.geometry == TYP.Annular then CF_ann else if IN_con.geometry
             == TYP.Circular then 64 else if IN_con.geometry == TYP.Elliptical then
            CF_ell else if IN_con.geometry == TYP.Rectangular then CF_rec else if
            IN_con.geometry == TYP.Isosceles then CF_tri else 0
          "Correction factor for laminar flow";

        //SOURCE_1: p.81, fig. 2-3, sec 21-22: definition of flow regime boundaries
        Real k=max(MIN, abs(IN_con.K)/d_hyd) "Relative roughness";
        SI.ReynoldsNumber Re_lam_min=1e3
          "Minimum Reynolds number for laminar regime";
        SI.ReynoldsNumber Re_lam_max=2090*(1/max(0.007, k))^0.0635
          "Maximum Reynolds number for laminar regime";
        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754*
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k)))
          "Start of transition regime for increasing Reynolds number (leaving laminar regime)";

        //Adapted mass flow rate for function dp_turbulent of a straight pipe
        SI.MassFlowRate m_flow_turb=m_flow*(PI/4*d_hyd^2)/A_cross
          "Mass flow rate for turbulent calculation";
        SI.Velocity velocity=m_flow/(IN_var.rho*A_cross)
          "Velocity of internal flow";
        SI.ReynoldsNumber Re=IN_var.rho*abs(velocity)*d_hyd/IN_var.eta;

      protected
        Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con
          IN_2_con(
          final roughness=IN_con.roughness,
          final d_hyd=d_hyd,
          final K=IN_con.K,
          final L=IN_con.L) "Input record for turbulent regime"
          annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
        Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var
          IN_2_var(                                                                     final eta=
                IN_var.eta, final rho=IN_var.rho)
          "Input record for turbulent regime"
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

        //Documentation

      algorithm
        DP := SMOOTH(
                Re_lam_min,
                Re_lam_max,
                Re)*(CF_lam/2)*IN_con.L/d_hyd^2*velocity*IN_var.eta + SMOOTH(
                Re_lam_max,
                Re_lam_min,
                Re)*Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP(
                IN_2_con,
                IN_2_var,
                m_flow_turb);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(m_flow=FD.dp_internalFlowOverall_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of pressure loss for an internal flow through different geometries at overall flow regime for incompressible and single-phase fluid flow considering surface roughness.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this function is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_MFLOW\">dp_internalFlowOverall_MFLOW</a> is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used inside of the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> developed fluid flow </b>
 </li>
</ul>

<p>
<h4><font color=\"#EF9B13\">Geometry</font></h4>
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/channel/pic-pLchannel.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The pressure loss <b> dp </b> for channels is determined by:
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

<p>
<b> Channels with different shape of its cross sectional area are calculated </b> according to <i>[Miller 1978, p. 138, fig. 8.5-8-6]</i>
</p>

<p>
The pressure loss of these channels is similar to its calculation in straight pipes. There are three different flow regimes observed (laminar,transition,turbulent). The pressure loss coefficient (<b>zeta_TOT</b>) of a channel is calculated in dependence of the flow regime as follows:
</p>
<ul>
  <li> <b>Laminar regime (Re &le; Re_lam_leave)</b>:
     <br><br>
     <pre>
      zeta_TOT = CF_lam/Re * (L/d_hyd)
     </pre>
  <li> <b>Transition regime (Re_lam_leave &le; 4e4)</b>
        This calculation is done using a smoothing function interpolating between the laminar and the turbulent flow regime.
  <li> <b>Turbulent regime (Re &ge; 4e3)</b>:<br>
        The turbulent regime can be calculated with the pressure loss correlations for a straight pipe with the hydraulic diameter of the chosen geometry instead of the internal diameter of a straight pipe according to <i>[VDI 2002, p. Lab 4, sec. 2.1]</i> . The documentation of turbulent fluid flow for a straight pipe is shown in <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent\">dp_turbulent</a>.
</ul>

<p>
with
</p>

<p>
<table>
<tr><td><b> CF_lam        </b></td><td> as correction factor considering the geometry for laminar regime [-],</td></tr>
<tr><td><b> L             </b></td><td> as length of geometry perpendicular to cross sectional area [m],</td></tr>
<tr><td><b> d_hyd         </b></td><td> as hydraulic diameter of geometry [m],</td></tr>
<tr><td><b> Re            </b></td><td> as Reynolds number [-],</td></tr>
<tr><td><b> zeta_TOT      </b></td><td> as pressure loss coefficient [-].</td></tr>
</table>
</p>

<p>
Note that the beginning of the laminar regime depends on the chosen surface roughness of the channel and cannot be beneath <b>Re &le; 1e3</b>.
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The Darcy friction factor (<b>lambda_FRI</b>) of a channel with different shapes of its cross sectional area are shown in dependence of the Reynolds number (<b>Re</b>) in the figures below.

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/channel/fig_channel_dp_internalFlowOverall_lambdaVsRe.png\">

The Darcy friction factor (<b>lambda_FRI</b>) for different geometries has been obtained at the same hydraulic diameter and the same mean velocity of the internal flow. Note that there is no difference of the Darcy friction factor in the turbulent regime if using the same hydraulic diameter for all geometries. Roughness can be considered but it is not used for this validation.

<h4><font color=\"#EF9B13\">References</font></h4>
<dt>Miller,D.S.:</dt>
    <dd><b>Internal flow systems</b>.
    Volume 5th of BHRA Fluid Engineering Series.BHRA Fluid Engineering, 1978.
<dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>
</html>
"));
      end dp_internalFlowOverall_DP;

      function dp_internalFlowOverall_MFLOW
        "Pressure loss of internal flow | calculate mass flow rate | overall flow regime | surface roughness | several geometries"

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Channel;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Channel_d;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_IN_con
          IN_con "Input record for function dp_internalFlowOverall_MFLOW"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_IN_var
          IN_var "Input record for function dp_internalFlowOverall_MFLOW"
          annotation (Dialog(group="Variable inputs"));
        input SI.Pressure dp "Pressure loss" annotation (Dialog(group="Input"));

        //output variables
        output SI.MassFlowRate M_FLOW "Output of function dp_overall_MFLOW";

      protected
        type TYP1 =
            Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow;
        type TYP2 = Modelica.Fluid.Dissipation.Utilities.Types.Roughness;

        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=max(MIN, if IN_con.geometry == TYP1.Annular then (PI/4)*((
            IN_con.D_ann)^2 - (IN_con.d_ann)^2) else if IN_con.geometry == TYP1.Circular then
                  PI/4*(IN_con.d_cir)^2 else if IN_con.geometry == TYP1.Elliptical then
                  PI*IN_con.a_ell*IN_con.b_ell else if IN_con.geometry == TYP1.Rectangular then
                  IN_con.a_rec*IN_con.b_rec else if IN_con.geometry == TYP1.Isosceles then
                  0.5*(IN_con.a_tri*IN_con.h_tri) else 0)
          "Cross sectional area";
        SI.Length perimeter=max(MIN, if IN_con.geometry == TYP1.Annular then PI*(
            IN_con.D_ann + IN_con.d_ann) else if IN_con.geometry == TYP1.Circular then
                  PI*IN_con.d_cir else if IN_con.geometry == TYP1.Elliptical then PI*
            (IN_con.a_ell + IN_con.b_ell) else if IN_con.geometry == TYP1.Rectangular then
                  2*(IN_con.a_rec + IN_con.b_rec) else if IN_con.geometry == TYP1.Isosceles then
                  IN_con.a_tri + 2*((IN_con.h_tri)^2 + (IN_con.a_tri/2)^2)^0.5 else 0)
          "Perimeter";
        SI.Diameter d_hyd=4*A_cross/perimeter "Hydraulic diameter";
        Real beta=IN_con.beta*180/PI "Top angle";

        //SOURCE_2: p.138, sec 8.5
        Real Dd_ann=min(max(MIN, IN_con.d_ann), IN_con.D_ann)/max(MIN, max(IN_con.d_ann,
            IN_con.D_ann))
          "Ratio of small to large diameter of annular geometry";
        Real CF_ann=98.7378*Dd_ann^0.0589
          "Correction factor for annular geometry";
        Real ab_rec=min(IN_con.a_rec, IN_con.b_rec)/max(MIN, max(IN_con.a_rec, IN_con.b_rec))
          "Aspect ratio of rectangular geometry";
        Real CF_rec=-59.85*(ab_rec)^3 + 148.67*(ab_rec)^2 - 128.1*(ab_rec) + 96.1
          "Correction factor for rectangular geometry";
        Real ab_ell=min(IN_con.a_ell, IN_con.b_ell)/max(MIN, max(IN_con.a_ell, IN_con.b_ell))
          "Ratio of small to large length of annular geometry";
        Real CF_ell=-169.2211*(ab_ell)^4 + 260.9028*(ab_ell)^3 - 113.7890*(ab_ell)^2
             + 9.2588*(ab_ell)^1 + 78.7124
          "Correction factor for elliptical geometry";
        Real CF_tri=-0.0013*(min(90, beta))^2 + 0.1577*(min(90, beta)) + 48.5575
          "Correction factor for triangular geometry";
        Real CF_lam=if IN_con.geometry == TYP1.Annular then CF_ann else if IN_con.geometry
             == TYP1.Circular then 64 else if IN_con.geometry == TYP1.Elliptical then
                  CF_ell else if IN_con.geometry == TYP1.Rectangular then CF_rec else
                  if IN_con.geometry == TYP1.Isosceles then CF_tri else 0
          "Correction factor for laminar flow";

        //SOURCE_1: p.81, fig. 2-3, sec 21-22: definition of flow regime boundaries
        Real k=max(MIN, abs(IN_con.K)/d_hyd) "Relative roughness";
        SI.ReynoldsNumber Re_lam_min=1e3
          "Minimum Reynolds number for laminar regime";
        SI.ReynoldsNumber Re_lam_max=2090*(1/max(0.007, k))^0.0635
          "Maximum Reynolds number for laminar regime";
        SI.ReynoldsNumber Re_turb_min=4e3
          "Minimum Reynolds number for turbulent regime";

        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754*
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k)))
          "Start of transition regime for increasing Reynolds number (leaving laminar regime)";

        //determining darcy friction factor out of pressure loss calulation for straight pipe:
        //dp = lambda_FRI*L/d_hyd*(rho/2)*velocity^2 and assuming lambda_FRI == lambda_FRI_calc/Re^2
        TYP.DarcyFrictionFactor lambda_FRI_calc=2*abs(dp)*d_hyd^3*IN_var.rho/(IN_con.L
            *IN_var.eta^2) "Adapted Darcy friction factor";

        //SOURCE_3: p.Lab 1, eq. 5: determine Re assuming laminar regime
        SI.ReynoldsNumber Re_lam=lambda_FRI_calc/CF_lam
          "Reynolds number assuming laminar regime";

        //SOURCE_3: p.Lab 2, eq. 10: determine Re assuming turbulent regime (Colebrook-White)
        SI.ReynoldsNumber Re_turb=if IN_con.roughness == TYP2.Neglected then (max(MIN,
            lambda_FRI_calc)/0.3164)^(1/1.75) else -2*sqrt(max(lambda_FRI_calc, MIN))
            *Modelica.Math.log10(2.51/sqrt(max(lambda_FRI_calc, MIN)) + k/3.7)
          "Reynolds number assuming turbulent regime";

        //determine actual flow regime
        SI.ReynoldsNumber Re_check=if Re_lam < Re_lam_leave then Re_lam else Re_turb;
        //determine Re for transition regime
        SI.ReynoldsNumber Re_trans=if Re_lam >= Re_lam_leave then
            Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_DP(
            Re_check,
            Re_lam_leave,
            Re_turb_min,
            k,
            lambda_FRI_calc) else 0;
        //determine actual Re
        SI.ReynoldsNumber Re=if Re_lam < Re_lam_leave then Re_lam else if Re_turb >
            Re_turb_min then Re_turb else Re_trans;

        Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con
          IN_2_con(
          final roughness=IN_con.roughness,
          final d_hyd=d_hyd,
          final K=IN_con.K,
          final L=IN_con.L) "Input record for turbulent regime"
          annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
        Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var
          IN_2_var(                                                                     final eta=
                IN_var.eta, final rho=IN_var.rho)
          "Input record for turbulent regime"
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

        //Documentation

      algorithm
        M_FLOW := SMOOTH(
                Re_lam_min,
                Re_turb,
                Re)*IN_var.rho*A_cross*(dp*(2/CF_lam)*(d_hyd^2/IN_con.L)*(1/
          IN_var.eta)) + SMOOTH(
                Re_turb,
                Re_lam_min,
                Re)*(A_cross/((PI/4)*d_hyd^2))*
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW(
                IN_2_con,
                IN_2_var,
                dp);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(dp=FD.dp_internalFlowOverall_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of pressure loss for an internal flow through different geometries at overall flow regime for incompressible and single-phase fluid flow considering surface roughness.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this function is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_DP\">dp_internalFlowOverall_DP</a> is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used inside of the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> developed fluid flow </b>
 </li>
</ul>

<p>
<h4><font color=\"#EF9B13\">Geometry</font></h4>
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/channel/pic-pLchannel.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The pressure loss calculation for internal fluid flow in different geometries is further documented <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_DP\">dp_internalFlowOverall_DP</a>.
</html>"));
      end dp_internalFlowOverall_MFLOW;

      record dp_internalFlowOverall_IN_con
        "Input record for function dp_internalFlowOverall"

        //channel variables
        Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=Dissipation.Utilities.Types.Roughness.Considered
          "Choice of considering surface roughness"
          annotation (Dialog(group="Channel"));
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.Geometry;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall\"> dp_internalFlowOverall </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_DP\"> dp_internalFlowOverall_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_MFLOW\"> dp_internalFlowOverall_MFLOW </a>.
</html>"));
      end dp_internalFlowOverall_IN_con;

      record dp_internalFlowOverall_IN_var
        "Input record for function dp_internalFlowOverall"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall\"> dp_internalFlowOverall </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_DP\"> dp_internalFlowOverall_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_MFLOW\"> dp_internalFlowOverall_MFLOW </a>.
</html>"));
      end dp_internalFlowOverall_IN_var;
    end Channel;

    package General "Package for generic pressure loss calculations"
    extends Modelica.Icons.VariantsPackage;

      function dp_idealGas_DP
        "Generic pressure loss | calculate pressure loss | ideal gas | mean density"

        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_IN_con
          IN_con "Input record for function dp_idealGas_DP"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_IN_var
          IN_var "Input record for function dp_idealGas_DP"
          annotation (Dialog(group="Variable inputs"));
        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //output variables
        output SI.Pressure DP "Output for function dp_idealGas_DP";

      protected
        Real Km_internal=IN_con.Km "Coefficient for pressure loss";

        SI.Density rho_internal=IN_var.p_m/(IN_con.R_s*IN_var.T_m)
          "Mean density";
        SI.VolumeFlowRate V_flow=m_flow/rho_internal "Volume flow rate [m3/s]";
        SI.VolumeFlowRate V_flow_min=(IN_con.R_s/Km_internal)^(1/IN_con.exp)*
            rho_internal^(1/IN_con.exp - 1)*IN_con.dp_smooth^(1/IN_con.exp)
          "Start of approximation for decreasing volume flow rate";

        //Documentation

      algorithm
        DP := (Km_internal/IN_con.R_s)*(rho_internal)^(IN_con.exp - 1)*
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                V_flow,
                V_flow_min,
                IN_con.exp);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(m_flow=FD.dp_idealGas_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss for an <b> ideal gas </b> using mean density.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_MFLOW\">dp_idealGas_MFLOW</a> is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used inside of the restricted limits according to the referenced literature.
<ul>
 <li>
    <b> ideal gas </b>
 </li>
 <li>
    mean density of ideal gas
 </li>
</ul>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
<p>
The geometry parameters of energy devices necessary for the pressure loss calculations are often not exactly known.
Therefore the modelling of the detailed pressure loss calculation has to be simplified.
</p>

The pressure loss <b> dp </b> for the incompressible case [Pressure loss = f(m_flow)] is determined by:
<pre>
    dp = (Km/R_s)*(rho_m)^(IN.exp - 1)*V_flow^exp, Eq.1 with [dp] = Pa, [V_flow = m_flow / rho_m] = m^3/s
</pre>

<p>
for the underlying base equation using ideal gas law as follows:
</p>
<pre>
    dp^2 = p_2^2 - p_1^2 = Km*m_flow^exp*(T_2 + T_1)
    dp   = p_2 - p_1     = Km*m_flow^exp*T_m/p_m, Eq.2 with [dp] = Pa, [m_flow] = kg/s
</pre>

<p>
so that the coefficient <b> Km </b> is calculated out of Eq.2:
</p>

</p>
<pre>
    Km = dp*R_s*rho_m / m_flow^exp , [Km] = [Pa^2/{(kg/s)^exp*K}]
</pre>

where the mean density <b> rho_m </b> is calculated according to the ideal gas law out of an arithmetic mean pressure and temperature:
</p>
<pre>
   rho_m = p_m / (R_s*T_m) , p_m = (p_1 + p_2)/2 and T_m = (T_1 + T_2)/2.
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> exp                    </b></td><td> as exponent of pressure loss law [-],</td></tr>
<tr><td><b> dp                     </b></td><td> as pressure loss [Pa],</td></tr>
<tr><td><b> Km                     </b></td><td> as coefficient w.r.t. mass flow rate! [Km] = [Pa^2/{(kg/s)^exp*K}],</td></tr>
<tr><td><b> m_flow                 </b></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><b> p_m = (p_2 + p_1)/2    </b></td><td> as mean pressure of ideal gas [Pa],</td></tr>
<tr><td><b> T_m = (T_2 + T_1)/2    </b></td><td> as mean temperature of ideal gas [K],</td></tr>
<tr><td><b> rho_m = p_m/(R_s*T_m)  </b></td><td> as mean density of ideal gas [kg/m3],</td></tr>
<tr><td><b> R_s                    </b></td><td> as specific gas constant of ideal gas [J/(kgK)],</td></tr>
<tr><td><b> V_flow                 </b></td><td> as volume flow rate of ideal gas [m^3/s].</td></tr>
</table>
</p>

<p>
Furthermore the coefficient <b> Km </b> can be defined more detailled w.r.t. the definition of pressure loss if <b> Km </b> is not given as (e.g., measured) value. Generally pressure loss can be calculated due to local losses <b> Km,LOC </b> or frictional losses <b> Km,FRI </b>.
</p>
<p>
Pressure loss due to local losses gives the following definition of <b> Km </b>:
</p>
<pre>
    dp        = zeta_LOC * (rho_m/2)*velocity^2 is leading to
      Km,LOC  = (8/&Pi^2)*R_s*zeta_LOC/(d_hyd)^4, considering the cross sectional area of pipes.
</pre>

<p>
and pressure loss due to friction is leading to
</p>
<pre>
    dp        = lambda_FRI*L/d_hyd * (rho_m/2)*velocity^2
      Km,FRI  = (8/&Pi^2)*R_s*lambda_FRI*L/(d_hyd)^5, considering the cross sectional area of pipes.
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> dp                    </b></td><td> as pressure loss [Pa],</td></tr>
<tr><td><b> d_hyd                 </b></td><td> as hydraulic diameter of pipe [m],</td></tr>
<tr><td><b> Km,i                  </b></td><td> as coefficients w.r.t. mass flow rate! [Km] = [Pa^2/{(kg/s)^exp*K}],</td></tr>
<tr><td><b> lambda_FRI            </b></td><td> as darcy friction factor [-],</td></tr>
<tr><td><b> L                     </b></td><td> as length of pipe [m],</td></tr>
<tr><td><b> rho_m = p_m/(R_s*T_m) </b></td><td> as mean density of ideal gas [kg/m3],</td></tr>
<tr><td><b> velocity              </b></td><td> as mean velocity [m/s],</td></tr>
<tr><td><b> zeta_LOC              </b></td><td> as local resistance coefficient [-].</td></tr>
</table>
</p>

Note that the variables of this function are delivered in SI units so that the coefficient Km shall be given in SI units too.

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
<b> Incompressible case </b> [Pressure loss = f(m_flow)]:
</p>
The generic pressure loss <b> dp </b> for different coefficients <b> Km </b> as parameter is shown in dependence of the mass flow rate <b> m_flow </b> in the figure below.

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/general/fig_general_dp_idealGas_DPvsMFLOW.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Elmquist, H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>
</dl>
</html>"));
      end dp_idealGas_DP;

      function dp_idealGas_MFLOW
        "Generic pressure loss | calculate mass flow rate | ideal gas | mean density"

        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_IN_con
          IN_con "Input record for function dp_idealGas_MFLOW"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_IN_var
          IN_var "Input record for function dp_idealGas_MFLOW"
          annotation (Dialog(group="Variable inputs"));
        input SI.Pressure dp "Pressure loss" annotation (Dialog(group="Input"));

        //output variables
        output SI.MassFlowRate M_FLOW "Output for function dp_idealGas_MFLOW";

      protected
        Real Km_internal=IN_con.Km "Coefficient for pressure loss";

        SI.Density rho_internal=IN_var.p_m/(IN_con.R_s*IN_var.T_m)
          "Mean density";

        //Documentation

      algorithm
        M_FLOW := (IN_con.R_s/Km_internal)^(1/IN_con.exp)*(rho_internal)^(1/
          IN_con.exp)*Dissipation.Utilities.Functions.General.SmoothPower(
                dp,
                IN_con.dp_smooth,
                1/IN_con.exp);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(dp=FD.dp_idealGas_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss for an <b> ideal gas </b> using mean density.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_DP\">dp_idealGas_DP</a> is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used inside of the restricted limits according to the referenced literature.
<ul>
 <li>
    <b> ideal gas </b>
 </li>
 <li>
    mean density of ideal gas
 </li>
</ul>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
<p>
The geometry parameters of energy devices necessary for the pressure loss calculations are often not exactly known.
Therefore the modelling of the detailed pressure loss calculation has to be simplified.
</p>

The pressure loss <b> dp </b> for the compressible case [Mass flow rate = f(dp)] is determined by (Eq.1):
<pre>
    m_flow := (R_s/Km)^(1/exp)*(rho_m)^(1/exp)*dp^(1/exp)
</pre>

<p>
for the underlying base equation using ideal gas law as follows:
</p>
<pre>
    dp^2 = p_2^2 - p_1^2 = Km*m_flow^exp*(T_2 + T_1)
    dp   = p_2 - p_1     = Km*m_flow^exp*T_m/p_m, Eq.2 with [dp] = Pa, [m_flow] = kg/s
</pre>

<p>
so that the coefficient <b> Km </b> is calculated out of Eq.2:
</p>

</p>
<pre>
    Km = dp*R_s*rho_m / m_flow^exp , [Km] = [Pa^2/{(kg/s)^exp*K}]
</pre>

where the mean density <b> rho_m </b> is calculated according to the ideal gas law out of an arithmetic mean pressure and temperature:
</p>
<pre>
   rho_m = p_m / (R_s*T_m) , p_m = (p_1 + p_2)/2 and T_m = (T_1 + T_2)/2.
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> exp                    </b></td><td> as exponent of pressure loss law [-],</td></tr>
<tr><td><b> dp                     </b></td><td> as pressure loss [Pa],</td></tr>
<tr><td><b> Km                     </b></td><td> as coefficient w.r.t. mass flow rate! [Km] = [Pa^2/{(kg/s)^exp*K}],</td></tr>
<tr><td><b> m_flow                 </b></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><b> p_m = (p_2 + p_1)/2    </b></td><td> as mean pressure of ideal gas [Pa],</td></tr>
<tr><td><b> T_m = (T_2 + T_1)/2    </b></td><td> as mean temperature of ideal gas [K],</td></tr>
<tr><td><b> rho_m = p_m/(R_s*T_m)  </b></td><td> as mean density of ideal gas [kg/m3],</td></tr>
<tr><td><b> R_s                    </b></td><td> as specific gas constant of ideal gas [J/(kgK)],</td></tr>
<tr><td><b> V_flow                 </b></td><td> as volume flow rate of ideal gas [m^3/s].</td></tr>
</table>
</p>

<p>
Furthermore the coefficient <b> Km </b> can be defined more detailled w.r.t. the definition of pressure loss if <b> Km </b> is not given as (e.g., measured) value. Generally pressure loss can be calculated due to local losses <b> Km,LOC </b> or frictional losses <b> Km,FRI </b>.
</p>
<p>
Pressure loss due to local losses gives the following definition of <b> Km </b>:
</p>
<pre>
    dp        = zeta_LOC * (rho_m/2)*velocity^2 is leading to
      Km,LOC  = (8/&Pi^2)*R_s*zeta_LOC/(d_hyd)^4, considering the cross sectional area of pipes.
</pre>

<p>
and pressure loss due to friction is leading to
</p>
<pre>
    dp        = lambda_FRI*L/d_hyd * (rho_m/2)*velocity^2
      Km,FRI  = (8/&Pi^2)*R_s*lambda_FRI*L/(d_hyd)^5, considering the cross sectional area of pipes.
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> dp                    </b></td><td> as pressure loss [Pa],</td></tr>
<tr><td><b> d_hyd                 </b></td><td> as hydraulic diameter of pipe [m],</td></tr>
<tr><td><b> Km,i                  </b></td><td> as coefficients w.r.t. mass flow rate! [Km] = [Pa^2/{(kg/s)^exp*K}],</td></tr>
<tr><td><b> lambda_FRI            </b></td><td> as darcy friction factor [-],</td></tr>
<tr><td><b> L                     </b></td><td> as length of pipe [m],</td></tr>
<tr><td><b> rho_m = p_m/(R_s*T_m) </b></td><td> as mean density of ideal gas [kg/m3],</td></tr>
<tr><td><b> velocity              </b></td><td> as mean velocity [m/s],</td></tr>
<tr><td><b> zeta_LOC              </b></td><td> as local resistance coefficient [-].</td></tr>
</table>
</p>

Note that the variables of this function are delivered in SI units so that the coefficient Km shall be given in SI units too.

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
<b> Compressible case </b> [Mass flow rate = f(dp)]:
</p>
<p>
The mass flow rate <b> m_flow </b> for different coefficients <b> Km </b> as parameter is shown in dependence of its pressure loss <b> dp </b> in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/general/fig_general_dp_idealGas_MFLOWvsDP.png\">

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_DP\">dp_idealGas_DP</a> is also valid for this inverse calculation due to using the same functions.</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Elmquist, H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>
</dl>
</html>"));
      end dp_idealGas_MFLOW;

      record dp_idealGas_IN_con
        "Input record for function dp_idealGas, dp_idealGas_DP and dp_idealGas_MFLOW"

        //generic variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.IdealGas_con;

        //linearisation
        SI.Pressure dp_smooth(min=Modelica.Constants.eps) = 1
          "Start linearisation for smaller pressure loss"
          annotation (Dialog(group="Linearisation"));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas\"> dp_idealGas </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_DP\"> dp_idealGas_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_MFLOW\"> dp_idealGas_MFLOW </a>.
</html>"));

      end dp_idealGas_IN_con;

      record dp_idealGas_IN_var
        "Input record for function dp_idealGas, dp_idealGas_DP and dp_idealGas_MFLOW"

        //generic variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.IdealGas_var;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas\"> dp_idealGas </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_DP\"> dp_idealGas_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_MFLOW\"> dp_idealGas_MFLOW </a>.
</html>"));

      end dp_idealGas_IN_var;

      function dp_nominalDensityViscosity_DP
        "Generic pressure loss | calculate mass flow rate | nominal operation point | pressure loss law (exponent) | density and dynamic viscosity dependence"

        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_IN_con
          IN_con "Input record for function dp_nominalDensityViscosity_DP"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_IN_var
          IN_var "Input record for function dp_nominalDensityViscosity_DP"
          annotation (Dialog(group="Variable inputs"));
        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //output variables
        output SI.Pressure DP
          "Output for function dp_nominalDensityViscosity_DP";

      protected
        SI.MassFlowRate m_flow_smooth=(max(1, 0.01*IN_con.dp_nom)*IN_var.rho/IN_con.rho_nom
            *(1/IN_var.eta*IN_con.eta_nom)^(IN_con.exp_eta)*(1/IN_con.m_flow_nom))^(1
            /IN_con.exp) "Start of approximation for decreasing mass flow rate";

        //Documentation

      algorithm
        DP := if IN_con.exp > 1.0 or IN_con.exp < 1.0 then
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                m_flow,
                m_flow_smooth,
                IN_con.exp)*(IN_var.eta/IN_con.eta_nom)^IN_con.exp_eta*IN_con.rho_nom
          /IN_var.rho*IN_con.dp_nom*(1/IN_con.m_flow_nom)^(IN_con.exp) else
          m_flow/IN_con.m_flow_nom*(IN_var.eta/IN_con.eta_nom)^IN_con.exp_eta*
          IN_con.rho_nom/IN_var.rho*IN_con.dp_nom;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(m_flow=FD.dp_nominalDensityViscosity_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of nominal fluid variables (e.g., nominal density, nominal dynamic viscosity) at an operation point via interpolation.
This generic function considers the pressure loss law via a pressure loss exponent and the influence of density and dynamic viscosity on pressure loss.
The function can be used to calculate pressure loss at known mass flow rate <b> or </b>  mass flow rate at known pressure loss.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_MFLOW\">dp_nominalDensityViscosity_MFLOW</a> is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
<p>
The geometry parameters of energy devices necessary for the pressure loss calculations are often not exactly known.
Therefore the modelling of the detailed pressure loss calculation has to be simplified.
This function uses nominal variables (e.g., nominal pressure loss) at a known operation point of the energy device to interpolate the actual pressure loss according to a pressure loss law (exponent).
</p>

The generic pressure loss <b> dp </b> is determined for:
<ul>
 <li>
 compressible case [Mass flow rate = f(dp)]:
  <pre>
   m_flow = m_flow_nom*[(dp/dp_nom)*(rho/rho_nom)]^(1/exp)*(eta_nom/eta)^(exp_eta/exp)
   </pre>
 </li>
 <li>
 incompressible case [Pressure loss = f(m_flow)]:
  <pre>
   dp = dp_nom*(m_flow/m_flow_nom)^exp*(rho_nom/rho)*(eta/eta_nom)^exp_eta
   </pre>
  </li>
</ul>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> dp             </b></td><td> as pressure loss [Pa],</td></tr>
<tr><td><b> dp_nom         </b></td><td> as nominal pressure loss [Pa],</td></tr>
<tr><td><b> eta            </b></td><td> as dynamic viscosity of fluid [kg/(ms)].</td></tr>
<tr><td><b> eta_nom        </b></td><td> as nominal dynamic viscosity of fluid [kg/(ms)].</td></tr>
<tr><td><b> m_flow         </b></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><b> m_flow_nom     </b></td><td> as nominal mass flow rate [kg/s],</td></tr>
<tr><td><b> exp            </b></td><td> as exponent of pressure loss calculation [-],</td></tr>
<tr><td><b> exp_eta        </b></td><td> as exponent of dynamic viscosity dependence [-],</td></tr>
<tr><td><b> rho            </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> rho_nom        </b></td><td> as nominal fluid density [kg/m3].</td></tr>
</table>
</p>

To avoid numerical difficulties this pressure loss function is linear smoothed for
<ul>
 <li>
 small mass flow rates, where
 <pre>
  m_flow &le; (0.01*rho/rho_nom*(1/eta*eta_nom)^(exp_eta))^(1/exp) and
  </pre>
 </li>
 <li> small pressure losses, where
 <pre>
 dp &le; 0.01*dp_nom)
 </pre>
 </li>
</ul>

Note that the density (rho) and dynamic viscosity (eta) of the fluid are defined through the defintion of the kinematic viscosity (nue).
<pre>
    nue = eta / rho
</pre>
Therefore if you set both the exponent of dynamic viscosity (exp_eta == 1) and additionally a relation of density and dynamic viscosity there will be no difference for varying densities because the dynamic viscosities will vary in the same manner.

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
<b> Incompressible case </b> [Pressure loss = f(m_flow)]:
</p>
The generic pressure loss <b> DP </b> in dependence of the mass flow rate <b> m_flow </b> with different fluid densities and dynamic viscosity dependence as parameters is shown for a turbulent pressure loss regime (exp == 2) in the figure below.

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/general/fig_general_dp_nominalDensityViscosity_DPvsMFLOW.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Elmquist, H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>
<dt>Wischhusen, S.:</dt>
    <dd><b>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</b>.
    PhD thesis, Technische Universität Hamburg-Harburg, 2005.</dd>
</dl>

</html>
"));
      end dp_nominalDensityViscosity_DP;

      function dp_nominalDensityViscosity_MFLOW
        "Generic pressure loss | calculate M_FLOW (compressible) | nominal operation point | pressure loss law (exponent) | density and dynamic viscosity dependence"

        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_IN_con
          IN_con "Input record for function dp_nominalDensityViscosity_MFLOW"
          annotation (Dialog(group="Constant inputs"));

        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_IN_var
          IN_var "Input record for function dp_nominalDensityViscosity_MFLOW"
          annotation (Dialog(group="Variable inputs"));

        input SI.Pressure dp "Pressure loss" annotation (Dialog(group="Input"));

        //output variables
        output SI.MassFlowRate M_FLOW
          "Output for function dp_nominalDensityViscosity_MFLOW";

        //Documentation

      algorithm
        M_FLOW := if IN_con.exp > 1.0 or IN_con.exp < 1.0 then
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                dp,
                0.01*IN_con.dp_nom,
                1/IN_con.exp)*(IN_con.eta_nom/IN_var.eta)^(IN_con.exp_eta/
          IN_con.exp)*(1/IN_con.dp_nom*IN_var.rho/IN_con.rho_nom)^(1/IN_con.exp)
          *IN_con.m_flow_nom else dp/IN_con.dp_nom*(IN_con.eta_nom/IN_var.eta)^
          (IN_con.exp_eta)*IN_var.rho/IN_con.rho_nom*IN_con.m_flow_nom;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(dp=FD.dp_nominalDensityViscosity_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of nominal fluid variables (e.g., nominal density, nominal dynamic viscosity) at an operation point via interpolation.
This generic function considers the pressure loss law via a pressure loss exponent and the influence of density and dynamic viscosity on pressure loss.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_DP\">dp_genericDensityViscosity_DP</a> is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
<p>
The geometry parameters of energy devices necessary for the pressure loss calculations are often not exactly known.
Therefore the modelling of the detailed pressure loss calculation has to be simplified.
This function uses nominal variables (e.g., nominal pressure loss) at a known operation point of the energy device to interpolate the actual pressure loss according to a pressure loss law (exponent).
</p>

The generic pressure loss <b> dp </b> is determined for:
<ul>
 <li>
 compressible case [Mass flow rate = f(dp)]:
  <pre>
   m_flow = m_flow_nom*[(dp/dp_nom)*(rho/rho_nom)]^(1/exp)*(eta_nom/eta)^(exp_eta/exp)
   </pre>
 </li>
 <li>
 incompressible case [Pressure loss = f(m_flow)]:
  <pre>
   dp = dp_nom*(m_flow/m_flow_nom)^exp*(rho_nom/rho)*(eta/eta_nom)^exp_eta
   </pre>
  </li>
</ul>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> dp             </b></td><td> as actual pressure loss [Pa],</td></tr>
<tr><td><b> dp_nom         </b></td><td> as nominal pressure loss [Pa],</td></tr>
<tr><td><b> eta            </b></td><td> as actual dynamic viscosity of fluid [kg/(ms)],</td></tr>
<tr><td><b> eta_nom        </b></td><td> as nominal dynamic viscosity of fluid [kg/(ms)],</td></tr>
<tr><td><b> exp            </b></td><td> as exponent of pressure loss calculation [-],</td></tr>
<tr><td><b> exp_eta        </b></td><td> as exponent of dynamic viscosity dependence [-],</td></tr>
<tr><td><b> m_flow         </b></td><td> as actual mass flow rate [kg/s],</td></tr>
<tr><td><b> m_flow_nom     </b></td><td> as nominal mass flow rate [kg/s],</td></tr>
<tr><td><b> rho            </b></td><td> as actual fluid density [kg/m3],</td></tr>
<tr><td><b> rho_nom        </b></td><td> as nominal fluid density [kg/m3].</td></tr>
</table>
</p>

To avoid numerical difficulties this pressure loss function is linear smoothed for
<ul>
 <li>
 small mass flow rates, where
 <pre>
  m_flow &le; (0.01*rho/rho_nom*(1/eta*eta_nom)^(exp_eta))^(1/exp) and
  </pre>
 </li>
 <li> small pressure losses, where
 <pre>
 dp &le; 0.01*dp_nom)
 </pre>
 </li>
</ul>
Note that the density (rho) and dynamic viscosity (eta) of the fluid are defined through the defintion of the kinematic viscosity (nue).
<pre>
    nue = eta / rho
</pre>
Therefore if you set both the exponent of dynamic viscosity (exp_eta == 1) and additionally a relation of density and dynamic viscosity there will be no difference for varying densities because the dynamic viscosities will vary in the same manner.

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
<b> Compressible case </b> [Mass flow rate = f(dp)]:
</p>

The generic mass flow rate <b> M_FLOW </b> in dependence of the pressure loss <b> dp </b> at different fluid densities and dynamic viscosity as parameters is shown for a turbulent pressure loss regime (exp == 2) in the figure below.

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/general/fig_general_dp_nominalDensityViscosity_MFLOWvsDP.png\">

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_DP\">dp_nominalDensityViscosity_DP</a> is also valid for this inverse calculation due to using the same functions.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>Elmquist, H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>
 <dt>Wischhusen, S.:</dt>
    <dd><b>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</b>.
    PhD thesis, Technische Universität Hamburg-Harburg, 2005.</dd>
</dl>
</html>
"));
      end dp_nominalDensityViscosity_MFLOW;

      record dp_nominalDensityViscosity_IN_con
        "Output record for function dp_nominalDensityViscosity, dp_nominalDensityViscosity_DP and dp_nominalDensityViscosity_MFLOW"

        //generic variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.NominalDensityViscosity;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity\"> dp_nominalDensityViscosity </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_DP\"> dp_nominalDensityViscosity_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_MFLOW\"> dp_nominalDensityViscosity_MFLOW </a>.
</html>"));
      end dp_nominalDensityViscosity_IN_con;

      record dp_nominalDensityViscosity_IN_var
        "Output record for function dp_nominalDensityViscosity, dp_nominalDensityViscosity_DP and dp_nominalDensityViscosity_MFLOW"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity\"> dp_nominalDensityViscosity </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_DP\"> dp_nominalDensityViscosity_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_MFLOW\"> dp_nominalDensityViscosity_MFLOW </a>.
</html>"));
      end dp_nominalDensityViscosity_IN_var;

      function dp_nominalPressureLossLawDensity_DP
        "Generic pressure loss | calculate pressure loss | nominal operation point | pressure loss law (coefficient and exponent) | density dependence"

        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_con
          IN_con
          "Input record for function dp_nominalPressureLossLawDensity_DP"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_var
          IN_var
          "Input record for function dp_nominalPressureLossLawDensity_DP"
          annotation (Dialog(group="Variable inputs"));
        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //output variables
        output SI.Pressure DP
          "Output for function dp_nominalPressureLossLawDensity_yesAJac_DP";

      protected
        Real exp_density=if IN_con.target ==Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate then
                  1 - IN_con.exp else 1
          "Exponent of density fraction (rho/rho_nom)";
        SI.MassFlowRate m_flow_nom=if IN_con.target ==Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate then
                  IN_con.m_flow_nom else IN_var.rho*IN_con.V_flow_nom
          "Nominal mean flow velocity at operation point";

        SI.MassFlowRate m_flow_linear=(0.01*(IN_con.zeta_TOT_nom/IN_var.zeta_TOT)*(
            IN_con.rho_nom/IN_var.rho)^(exp_density)*(IN_con.A_cross/IN_con.A_cross_nom)
            ^(IN_con.exp)*IN_con.m_flow_nom)^(1/IN_con.exp)
          "Start of approximation for decreasing mass flow rate";

        //Documentation

      algorithm
        DP := if IN_con.exp > 1.0 or IN_con.exp < 1.0 then
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                m_flow,
                m_flow_linear,
                IN_con.exp)*IN_con.dp_nom*(IN_var.zeta_TOT/IN_con.zeta_TOT_nom)
          *(IN_var.rho/IN_con.rho_nom)^(exp_density)*(IN_con.A_cross_nom/IN_con.A_cross)
          ^(IN_con.exp)*(1/IN_con.m_flow_nom)^(IN_con.exp) else IN_con.dp_nom*(
          IN_var.zeta_TOT/IN_con.zeta_TOT_nom)*(IN_var.rho/IN_con.rho_nom)^(
          exp_density)*(IN_con.A_cross_nom/IN_con.A_cross)^(1)*(m_flow/IN_con.m_flow_nom)
          ^(1);

        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(m_flow=FD.dp_nominalPressureLossLawDensity_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of nominal fluid variables (e.g., nominal density) via interpolation from an operation point.
This generic function considers the pressure loss law via a nominal pressure loss (dp_nom), a pressure loss coefficient (zeta_TOT) and a pressure loss law exponent (exp) as well as the influence of density on pressure loss.
The function can be used to calculate pressure loss at known mass flow rate <b> or </b>  mass flow rate at known pressure loss.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW\">dp_nominalPressureLossLawDensity_MFLOW</a> is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
<p>
The geometry parameters of energy devices necessary for the pressure loss calculations are often not exactly known.
Therefore the modelling of the detailed pressure loss calculation have to be simplified.
This function uses nominal variables (e.g., nominal pressure loss) at a known operation point of the energy device to interpolate the actual pressure loss according to a pressure loss law (exponent).
</p>

In the following the pressure loss <b> dp </b> is generally determined from a known operation point via a law of similarity:
<pre>
   dp/dp_nom = (zeta_TOT/zeta_TOT_nom)*(rho/rho_nom)*(v/v_nom)^exp
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> dp             </b></td><td> as pressure loss [Pa],</td></tr>
<tr><td><b> dp_nom         </b></td><td> as nominal pressure loss [Pa],</td></tr>
<tr><td><b> m_flow         </b></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><b> m_flow_nom     </b></td><td> as nominal mass flow rate [kg/s],</td></tr>
<tr><td><b> exp            </b></td><td> as exponent of pressure loss calculation [-],</td></tr>
<tr><td><b> rho            </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> rho_nom        </b></td><td> as nominal fluid density [kg/m3],</td></tr>
<tr><td><b> v              </b></td><td> as mean flow velocity [m/s],</td></tr>
<tr><td><b> v_nom          </b></td><td> as nominal mean flow velocity [m/s],</td></tr>
<tr><td><b> zeta_TOT       </b></td><td> as pressure loss coefficient [-],</td></tr>
<tr><td><b> zeta_TOT_nom   </b></td><td> as nominal pressure loss coefficient [-].</td></tr>
</table>
</p>

The fraction of mean flow velocities (v/v_nom) can be calculated through its corresponding <b> mass flow rates </b>, densities and cross sectional areas:
<pre>
   v/v_nom = (m_flow/m_flow_nom)*(A_cross_nom/A_cross)*(rho_nom/rho)
</pre>

<p>
<b> or </b> through its corresponding <b> volume flow rates </b>, densities and cross sectional areas:
</p>

<pre>
    v/v_nom = (V_flow/V_flow_nom)*(A_cross_nom/A_cross).
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> A_cross        </b></td><td> as cross sectional area [m2],</td></tr>
<tr><td><b> A_cross_nom    </b></td><td> as nominal cross sectional area [m2],</td></tr>
<tr><td><b> rho            </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> rho_nom        </b></td><td> as nominal fluid density [kg/m3],</td></tr>
<tr><td><b> v              </b></td><td> as mean flow velocity [m/s],</td></tr>
<tr><td><b> v_nom          </b></td><td> as nominal mean flow velocity [m/s],</td></tr>
<tr><td><b> V_flow         </b></td><td> as volume flow rate [m3/s],</td></tr>
<tr><td><b> V_flow_nom     </b></td><td> as nominal volume flow rate [m3/s].</td></tr>
</table>
</p>

Here the <b> incompressible case </b> [Pressure loss = f(m_flow)] calculates the unknown pressure loss out of a given mass flow rate:
<p>
<pre>
   dp = dp_nom*(zeta_TOT/zeta_TOT_nom)*(rho/rho_nom)^(exp_density)*(A_cross_nom/A_cross)^(exp)*(m_flow/m_flow_nom)^(exp)
</pre>
</p>

<p>
where the exponent for the fraction of densities is determined w.r.t. the chosen nominal mass flow rate or nominal volume flow rate to:
</p>

<p>
<pre>
  exp_density = if NominalMassFlowRate == 1 then 1-exp else 1
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> NominalMassFlowRate    </b></td><td> as reference of pressure loss law (mass flow rate of volume flow rate),</td></tr>
<tr><td><b> exp                    </b></td><td> as exponent of pressure loss calculation [-],</td></tr>
<tr><td><b> exp_density            </b></td><td> as exponent for density [-].</td></tr>
</table>
</p>

To avoid numerical difficulties this pressure loss function is linear smoothed for small mass flow rates, with
<p>
<pre>
   m_flow &le [0.01*(zeta_TOT_nom/zeta_TOT)*(rho_nom/rho)^(exp_density)*(A_cross/A_cross_nom)^(exp)*m_flow_nom]^(1/exp);
</pre>
</p>

<p>
Note that the input and output arguments for functions throughout this library always use mass flow rates. Here you can choose <b> NominalMassFlowRate == 1 </b> for using a nominal mass flow rate or <b> NominalMassFlowRate == 2 </b> for using a nominal volume flow rate. The output argument will always be a mass flow rate for further use as flow model in a thermo-hydraulic framework.
</p>

<p>
Note that the pressure loss coefficients (zeta_TOT,zeta_TOT_nom) refer to its mean flow velocities (v,v_nom) in the pressure loss law to obtain its corresponding pressure loss.
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<b> Incompressible case </b> [Pressure loss = f(m_flow)]:
</p>
The generic pressure loss <b> DP </b> in dependence of the mass flow rate <b> m_flow </b> with different fluid densities as parameter is shown for a turbulent pressure loss regime (exp == 2) in the figure below.

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/general/fig_general_dp_nominalPressureLosslawDensity_DPvsMFLOW.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Elmquist, H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>
<dt>Wischhusen, S.:</dt>
    <dd><b>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</b>.
    PhD thesis, Technische Universität Hamburg-Harburg, 2005.</dd>
</dl>

</html>"));
      end dp_nominalPressureLossLawDensity_DP;

      function dp_nominalPressureLossLawDensity_MFLOW
        "Generic pressure loss | calculate mass flow rate | nominal operation point | pressure loss law (coefficient and exponent) | density dependence"

        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_con
          IN_con
          "Input record for function dp_nominalPressureLossLawDensity_MFLOW"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_var
          IN_var
          "Input record for function dp_nominalPressureLossLawDensity_MFLOW"
          annotation (Dialog(group="Variable inputs"));
        input SI.Pressure dp "Pressure loss" annotation (Dialog(group="Input"));

        //output variables
        output SI.MassFlowRate M_FLOW
          "Output for function dp_nominalPressurelosslawDensity_MFLOW";

      protected
        Real exp_density=if IN_con.target ==Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate then
                  1 - IN_con.exp else 1
          "Exponent of density fraction (rho/rho_nom)";
        SI.MassFlowRate m_flow_nom=if IN_con.target ==Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate then
                  IN_con.m_flow_nom else IN_var.rho*IN_con.V_flow_nom
          "Nominal mean flow velocity at operation point";

        //Documentation

      algorithm
        M_FLOW := if IN_con.exp > 1.0 or IN_con.exp < 1.0 then
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                dp,
                0.01*IN_con.dp_nom,
                1/IN_con.exp)*IN_con.m_flow_nom*(IN_con.A_cross/IN_con.A_cross_nom)
          *(IN_con.rho_nom/IN_var.rho)^(exp_density/IN_con.exp)*((1/IN_con.dp_nom)
          *(IN_con.zeta_TOT_nom/IN_var.zeta_TOT))^(1/IN_con.exp) else IN_con.m_flow_nom
          *(IN_con.A_cross/IN_con.A_cross_nom)*(IN_con.rho_nom/IN_var.rho)^(
          exp_density/1)*((dp/IN_con.dp_nom)*(IN_con.zeta_TOT_nom/IN_var.zeta_TOT))
          ^(1/1);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(dp=FD.dp_nominalPressureLossLawDensity_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of nominal fluid variables (e.g., nominal density) via interpolation from an operation point.
This generic function considers the pressure loss law via a nominal pressure loss (dp_nom), a pressure loss coefficient (zeta_TOT) and a pressure loss law exponent (exp) as well as the influence of density on pressure loss.
The function can be used to calculate pressure loss at known mass flow rate <b> or </b>  mass flow rate at known pressure loss.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP\">dp_nominalPressurelosslawDensity_DP</a> is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
<p>
The geometry parameters of energy devices necessary for the pressure loss calculations are often not exactly known.
Therefore the modelling of the detailed pressure loss calculation have to be simplified.
This function uses nominal variables (e.g., nominal pressure loss) at a known operation point of the energy device to interpolate the actual pressure loss according to a pressure loss law (exponent).
</p>

In the following the pressure loss <b> dp </b> is generally determined from a known operation point via a law of similarity:
<pre>
   dp/dp_nom = (zeta_TOT/zeta_TOT_nom)*(rho/rho_nom)*(v/v_nom)^exp
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> dp             </b></td><td> as pressure loss [Pa],</td></tr>
<tr><td><b> dp_nom         </b></td><td> as nominal pressure loss [Pa],</td></tr>
<tr><td><b> m_flow         </b></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><b> m_flow_nom     </b></td><td> as nominal mass flow rate [kg/s],</td></tr>
<tr><td><b> exp            </b></td><td> as exponent of pressure loss calculation [-],</td></tr>
<tr><td><b> rho            </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> rho_nom        </b></td><td> as nominal fluid density [kg/m3],</td></tr>
<tr><td><b> v              </b></td><td> as mean flow velocity [m/s],</td></tr>
<tr><td><b> v_nom          </b></td><td> as nominal mean flow velocity [m/s],</td></tr>
<tr><td><b> zeta_TOT       </b></td><td> as pressure loss coefficient [-],</td></tr>
<tr><td><b> zeta_TOT_nom   </b></td><td> as nominal pressure loss coefficient [-].</td></tr>
</table>
</p>

The fraction of mean flow velocities (v/v_nom) can be calculated through its corresponding <b> mass flow rates </b>, densities and cross sectional areas:
<pre>
   v/v_nom = (m_flow/m_flow_nom)*(A_cross_nom/A_cross)*(rho_nom/rho)
</pre>

<p>
<b> or </b> through its corresponding <b> volume flow rates </b>, densities and cross sectional areas:
</p>

<pre>
    v/v_nom = (V_flow/V_flow_nom)*(A_cross_nom/A_cross).
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> A_cross        </b></td><td> as cross sectional area [m2],</td></tr>
<tr><td><b> A_cross_nom    </b></td><td> as nominal cross sectional area [m2],</td></tr>
<tr><td><b> rho            </b></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><b> rho_nom        </b></td><td> as nominal fluid density [kg/m3],</td></tr>
<tr><td><b> v              </b></td><td> as mean flow velocity [m/s],</td></tr>
<tr><td><b> v_nom          </b></td><td> as nominal mean flow velocity [m/s],</td></tr>
<tr><td><b> V_flow         </b></td><td> as volume flow rate [m3/s],</td></tr>
<tr><td><b> V_flow_nom     </b></td><td> as nominal volume flow rate [m3/s].</td></tr>
</table>
</p>

Here the <b> compressible case </b> [Mass flow rate = f(dp)] determines the unknown mass flow rate out of a given pressure loss:
<p>
<pre>
   m_flow = m_flow_nom*(A_cross/A_cross_nom)*(rho_nom/rho)^(exp_density/exp)*[(dp/dp_nom)*(zeta_TOT_nom/zeta_TOT)]^(1/exp);
</pre>
</p>

<p>
where the exponent for the fraction of densities is determined w.r.t. the chosen nominal mass flow rate or nominal volume flow rate to:
</p>

<p>
<pre>
  exp_density = if NominalMassFlowRate == 1 then 1-exp else 1
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> NominalMassFlowRate    </b></td><td> as reference for pressure loss law (mass flow rate of volume flow rate),</td></tr>
<tr><td><b> exp                    </b></td><td> as exponent of pressure loss calculation [-],</td></tr>
<tr><td><b> exp_density            </b></td><td> as exponent for density [-].</td></tr>
</table>
</p>

To avoid numerical difficulties this pressure loss function is linear smoothed for small pressure losses, with
<p>
<pre>
   dp &le; 0.01*dp_nom
</pre>
</p>

<p>
Note that the input and output arguments for functions throughout this library always use mass flow rates. Here you can choose <b> NominalMassFlowRate == 1 </b> for using a nominal mass flow rate or <b> NominalMassFlowRate == 2 </b> for using a nominal volume flow rate. The output argument will always be a mass flow rate for further use as flow model in a thermo-hydraulic framework.
</p>

<p>
Note that the pressure loss coefficients (zeta_TOT,zeta_TOT_nom) refer to its mean flow velocities (v,v_nom) in the pressure loss law to obtain its corresponding pressure loss.
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
<b> Compressible case </b> [Mass flow rate = f(dp)]:
</p>

The generic mass flow rate <b> M_FLOW </b> in dependence of the pressure loss <b> dp </b> is shown for a turbulent pressure loss regime (exp == 2) in the figure below.

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/general/fig_general_dp_nominalPressureLossLawDensity_MFLOWvsDP.png\">

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP\">dp_nominalPressureLossLawDensity_DP</a> is also valid for this inverse calculation due to using the same functions.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Elmquist, H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>
<dt>Wischhusen, S.:</dt>
    <dd><b>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</b>.
    PhD thesis, Technische Universität Hamburg-Harburg, 2005.</dd>
</dl>

</html>"));
      end dp_nominalPressureLossLawDensity_MFLOW;

      record dp_nominalPressureLossLawDensity_IN_con
        "Input record for function dp_nominalPressureLossLawDensity, dp_nominalPressureLossLawDensity_DP and dp_nominalPressureLossLawDensity_MFLOW"

        //generic variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.NominalPressureLossLawDensity_con;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity\"> dp_nominalPressureLosslawDensity </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP\"> dp_nominalPressureLosslawDensity_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW\"> dp_nominalPressureLosslawDensity_MFLOW </a>.
</html>"));
      end dp_nominalPressureLossLawDensity_IN_con;

      record dp_nominalPressureLossLawDensity_IN_var
        "Input record for function dp_nominalPressureLossLawDensity, dp_nominalPressureLossLawDensity_DP and dp_nominalPressureLossLawDensity_MFLOW"

        //generic variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.NominalPressureLossLawDensity_var;

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss(
          final eta=0);

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity\"> dp_nominalPressureLosslawDensity </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP\"> dp_nominalPressureLosslawDensity_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW\"> dp_nominalPressureLosslawDensity_MFLOW </a>.
</html>"));
      end dp_nominalPressureLossLawDensity_IN_var;

      function dp_pressureLossCoefficient_DP
        "Generic pressure loss | calculate pressure loss | pressure loss coefficient (zeta_TOT)"

        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_IN_con
          IN_con "Input record for dp_pressureLossCoefficient_DP"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_IN_var
          IN_var "Input record for dp_pressureLossCoefficient_DP"
          annotation (Dialog(group="Variable inputs"));
        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //output variables
        output SI.Pressure DP
          "Output for function dp_pressureLossCoefficient_DP";

        //Documentation

      algorithm
        DP := 0.5*IN_var.zeta_TOT*
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                m_flow,
                (IN_con.dp_smooth/(0.5*IN_var.zeta_TOT*IN_var.rho))^0.5*IN_var.rho
            *IN_con.A_cross,
                2)/(IN_var.rho*(IN_con.A_cross)^2);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(m_flow=FD.dp_pressureLossCoefficient_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of a pressure loss coefficient.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_MFLOW\">dp_pressureLossCoefficient_MFLOW</a> is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The generic pressure loss <b> dp </b> is determined by:
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
<tr><td><b> dp             </b></td><td> as pressure loss [Pa],</td></tr>
<tr><td><b> rho            </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> velocity       </b></td><td> as mean velocity [m/s],</td></tr>
<tr><td><b> zeta_TOT       </b></td><td> as pressure loss coefficient [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
<b> Incompressible case </b> [Pressure loss = f(m_flow)]:
</p>
The pressure loss <b> DP </b> in dependence of the mass flow rate <b> m_flow </b> for a constant pressure loss coefficient <b> zeta_TOT </b> is shown in the figure below.

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/general/fig_general_dp_pressureLossCoefficient_DPvsMFLOW.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>Elmquist, H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>
 <dt>Wischhusen, S.:</dt>
    <dd><b>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</b>.
    PhD thesis, Technische Universität Hamburg-Harburg, 2005.</dd>
</dl>
</html>"));
      end dp_pressureLossCoefficient_DP;

      function dp_pressureLossCoefficient_MFLOW
        "Generic pressure loss | calculate mass flow rate | pressure loss coefficient (zeta_TOT)"

        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_IN_con
          IN_con "Input record for function dp_pressureLossCoefficient_MFLOW"
          annotation (Dialog(group="Constant inputs"));

        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_IN_var
          IN_var "Input record for function dp_pressureLossCoefficient_MFLOW"
          annotation (Dialog(group="Variable inputs"));
        input SI.Pressure dp "Pressure loss" annotation (Dialog(group="Input"));

        //output variables
        output SI.MassFlowRate M_FLOW
          "Output for function dp_pressureLossCoefficientt_MFLOW";

        //Documentation

      algorithm
        M_FLOW := IN_var.rho*IN_con.A_cross*
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                dp,
                IN_con.dp_smooth,
                0.5)/(0.5*IN_var.zeta_TOT*IN_var.rho)^0.5;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(dp=dp_pressureLossCoefficient_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of  a pressure loss coefficient.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_DP\">dp_pressureLossCoefficient_DP</a> is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mass flow rate <b> m_flow </b> is determined by:
<p>
<pre>
    m_flow = rho*A_cross*(dp/(zeta_TOT *(rho/2))^0.5
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> A_cross        </b></td><td> as cross sectional area [m2],</td></tr>
<tr><td><b> dp             </b></td><td> as pressure loss [Pa],</td></tr>
<tr><td><b> rho            </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> m_flow         </b></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><b> zeta_TOT       </b></td><td> as pressure loss coefficient [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
<b> Compressible case </b> [Mass flow rate = f(dp)]:
</p>
The mass flow rate <b> M_FLOW </b> in dependence of the pressure loss <b> dp </b> for a constant pressure loss coefficient <b> zeta_TOT </b> is shown in the figure below.

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/general/fig_general_dp_pressureLossCoefficient_MFLOWvsDP.png\">

Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_DP\">dp_pressureLossCoefficient_DP</a> is also valid for this inverse calculation due to using the same functions.

Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_DP\">dp_pressureLossCoefficient_DP</a> is also valid for this inverse calculation due to using the same functions.

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>Elmquist, H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>
 <dt>Wischhusen, S.:</dt>
    <dd><b>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</b>.
    PhD thesis, Technische Universität Hamburg-Harburg, 2005.</dd>
</dl>
</html>
"));
      end dp_pressureLossCoefficient_MFLOW;

      record dp_pressureLossCoefficient_IN_con
        "Input record for function dp_pressureLossCoefficient, dp_pressureLossCoefficient_DP and dp_pressureLossCoefficient_MFLOW"
        extends Modelica.Icons.Record;

        //generic variables
        SI.Area A_cross=Modelica.Constants.pi*0.1^2/4 "Cross sectional area"
          annotation (Dialog(group="Generic variables"));

        //linearisation
        SI.Pressure dp_smooth=1
          "Start linearisation for decreasing pressure loss"
          annotation (Dialog(group="Linearisation"));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient\"> dp_pressureLossCoefficient </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_DP\"> dp_pressureLossCoefficient_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_MFLOW\"> dp_pressureLossCoefficient_MFLOW </a>.
</html>"));
      end dp_pressureLossCoefficient_IN_con;

      record dp_pressureLossCoefficient_IN_var
        "Input record for function dp_pressureLossCoefficient, dp_pressureLossCoefficient_DP and dp_pressureLossCoefficient_MFLOW"
        extends Modelica.Icons.Record;

        //generic variables
        TYP.PressureLossCoefficient zeta_TOT=0.02*1/0.1
          "Pressure loss coefficient"
          annotation (Dialog(group="Generic variables"));

        //fluid property variables
        SI.Density rho=1e3 "Density of fluid"
          annotation (Dialog(group="FluidProperties"));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient\"> dp_pressureLossCoefficient </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_DP\"> dp_pressureLossCoefficient_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_MFLOW\"> dp_pressureLossCoefficient_MFLOW </a>.
</html>"));
      end dp_pressureLossCoefficient_IN_var;

      function dp_volumeFlowRate_DP
        "Generic pressure loss | calculate pressure loss | quadratic function (dp=a*V_flow^2 + b*V_flow)"

        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_con
          IN_con "Input record for function dp_volumeFlowRate_DP"
          annotation (Dialog(group="Constant inputs"));

        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_var
          IN_var "Input record for function dp_volumeFlowRate_DP"
          annotation (Dialog(group="Variable inputs"));
        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //output variables
        output SI.Pressure DP "Output for function dp_volumeFlowRate_DP";

      protected
        Real a=max(Modelica.Constants.eps, abs(IN_con.a));
        Real b=max(Modelica.Constants.eps, abs(IN_con.b));

        SI.VolumeFlowRate V_flow=m_flow/max(Modelica.Constants.eps, IN_var.rho)
          "Volume flow rate";
        SI.Pressure dp_min=IN_con.dp_min
          "Start of approximation for decreasing pressure loss";
        SI.VolumeFlowRate V_flow_smooth=if IN_con.a > 0 then -(b/(2*a) + ((-b/(2*a))^
            2 + dp_min/a)^0.5) else dp_min/b
          "Start of approximation for decreasing volume flow rate";

        //Documentation

      algorithm
        DP := a*Dissipation.Utilities.Functions.General.SmoothPower(
                V_flow,
                V_flow_smooth,
                2) + b*V_flow;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(m_flow=FD.dp_volumeFlowRate_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss with linear or quadratic dependence on volume flow rate.
The function can be used to calculate pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW\">dp_volumeFlowRate_MFLOW</a> is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
<p>
The geometry parameters of energy devices necessary for the pressure loss calculations are often not exactly known.
Therefore the modelling of the detailed pressure loss calculation has to be simplified. This function uses as
quadratic dependence of the pressure loss on the volume flow rate.
</p>

The pressure loss <b> dp </b> for the incompressible case [Pressure loss = f(m_flow)] is determined to <i> [see Wischhusen] </i>:
<pre>
    dp = a*V_flow^2 + b*V_flow
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> a              </b></td><td> as quadratic coefficient [Pa*s^2/m^6],</td></tr>
<tr><td><b> b              </b></td><td> as linear coefficient [Pa*s/m3],</td></tr>
<tr><td><b> dp             </b></td><td> as pressure loss [Pa],</td></tr>
<tr><td><b> m_flow         </b></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><b> rho            </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> V_flow         </b></td><td> as volume flow rate [m3/s].</td></tr>
</table>
</p>

Note that the coefficients <b> a,b </b> have to be positive values so that there will be a positive (linear or quadratic) pressure loss for a given positive volume flow rate.

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
<b> Incompressible case </b> [Pressure loss = f(m_flow)]:
</p>
The generic pressure loss <b> dp </b> for different coefficients <b> a </b> as parameter is shown in dependence of the volume flow rate <b> V_flow </b> in the figure below.

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/general/fig_general_dp_volumeFlowRate_DPvsMFLOW.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Elmquist, H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>
<dt>Wischhusen, S.:</dt>
    <dd><b>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</b>.
    PhD thesis, Technische Universität Hamburg-Harburg, 2005.</dd>
</dl>
</html>"));
      end dp_volumeFlowRate_DP;

      function dp_volumeFlowRate_MFLOW
        "Generic pressure loss | calculate mass flow rate | quadratic function (dp=a*V_flow^2 + b*V_flow)"

        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_con
          IN_con "Input record for function dp_volumeFlowRate_MFLOW"
          annotation (Dialog(group="Constant inputs"));

        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_var
          IN_var "Input record for function dp_volumeFlowRate_MFLOW"
          annotation (Dialog(group="Variable inputs"));
        input SI.Pressure dp "Pressure loss" annotation (Dialog(group="Input"));

        //output variables
        output SI.MassFlowRate M_FLOW
          "Output for function dp_volumeFlowRate_MFLOW";

      protected
        Real a=max(Modelica.Constants.eps, abs(IN_con.a));
        Real b=max(Modelica.Constants.eps, abs(IN_con.b));

        SI.Pressure dp_min=IN_con.dp_min
          "Start of approximation for decreasing pressure loss";

        //Documentation

      algorithm
        M_FLOW := IN_var.rho*(-b/(2*a) +
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                (b/(2*a))^2 + (1/a)*dp,
                (b/(2*a))^2 + (1/a)*dp_min,
                0.5));
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(dp=FD.dp_volumeFlowRate_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss with linear or quadratic dependence on volume flow rate.
The function can be used to calculate pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP\">dp_volumeFlowRate_DP</a> is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
<p>
The geometry parameters of energy devices necessary for the pressure loss calculations are often not exactly known.
Therefore the modelling of the detailed pressure loss calculation has to be simplified. This function uses as
quadratic dependence of the pressure loss on the volume flow rate.
</p>

The mass flow rate <b> m_flow </b> for the compressible case [Mass flow rate = f(dp)] is determined to <i> [see Wischhusen] </i>:
<pre>
 m_flow:= rho*[-b/(2a) + {[b/(2a)]^2 + dp/a}^0.5] ;
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> a              </b></td><td> as quadratic coefficient [Pa*s^2/m^6],</td></tr>
<tr><td><b> b              </b></td><td> as linear coefficient [Pa*s/m3],</td></tr>
<tr><td><b> dp             </b></td><td> as pressure loss [Pa],</td></tr>
<tr><td><b> m_flow         </b></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><b> rho            </b></td><td> as density of fluid [kg/m3].</td></tr>
</table>
</p>

Note that the coefficients <b> a,b </b> have to be positive values so that there will be a positive (linear or quadratic) pressure loss at positive volume flow rate and vice versa.

<h4><font color=\"#EF9B13\">Verification</font></h4>
<b> Compressible case </b> [Mass flow rate = f(dp)]:
The generic pressure loss <b> dp </b> for different coefficients <b> a </b> as parameter is shown in dependence of the volume flow rate <b> V_flow </b> in the figure below.

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/general/fig_general_dp_volumeFlowRate_MFLOWvsDP.png\">

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP\">dp_volumeFlowRate_DP</a> is also valid for this inverse calculation due to using the same functions.</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Elmquist, H., M.Otter and S.E. Cellier:</dt>
    <dd><b>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</b>.
    In Proceedings of European Simulation MultiConference, Praque, 1995.</dd>
<dt>Wischhusen, S.:</dt>
    <dd><b>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</b>.
    PhD thesis, Technische Universität Hamburg-Harburg, 2005.</dd>
</dl>
</html>
"));
      end dp_volumeFlowRate_MFLOW;

      record dp_volumeFlowRate_IN_con
        "Input record for function dp_volumeFlowRate, dp_volumeFlowRate_DP and dp_volumeFlowRate_MFLOW"

        //generic variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.QuadraticVFLOW;

        SI.Pressure dp_min=0.1
          "Start of approximation for decreasing pressure loss";

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate\"> dp_volumeFlowRate </a>,
 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP\"> dp_volumeFlowRate_DP </a> and
 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW\"> dp_volumeFlowRate_MFLOW </a>.
</html>"));

      end dp_volumeFlowRate_IN_con;

      record dp_volumeFlowRate_IN_var
        "Input record for function dp_volumeFlowRate, dp_volumeFlowRate_DP and dp_volumeFlowRate_MFLOW"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss(
          final eta=0);

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate\"> dp_volumeFlowRate </a>,
 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP\"> dp_volumeFlowRate_DP </a> and
 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW\"> dp_volumeFlowRate_MFLOW </a>.
</html>"));

      end dp_volumeFlowRate_IN_var;
    end General;

    package HeatExchanger
      "Package for pressure loss calculation of heat exchangers"
    extends Modelica.Icons.VariantsPackage;

    annotation (preferedView="info", Documentation(info="<html>
Note that the intention is to enhance the Fluid.Dissipation library by editing this package in future.
</html>"));
    end HeatExchanger;

    package Junction "Package for pressure loss calculation of junctions"
    extends Modelica.Icons.VariantsPackage;

    annotation (preferedView="info", Documentation(info="<html>
Note that the intention is to enhance the Fluid.Dissipation library by editing this package in future.
</html>"));
    end Junction;

    package Orifice "Package for pressure loss calculation of orifices"
    extends Modelica.Icons.VariantsPackage;

      function dp_suddenChange_DP
        "Pressure loss of orifice with sudden change in cross sectional area | calculate pressure loss | turbulent flow regime | smooth surface | arbitrary cross sectional area | without buffles | sharp edge"

        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Orifice;

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.OrificeSuddenChangeSection_d;

        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_IN_con
          IN_con "Input record for function dp_suddenChange_DP"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_IN_var
          IN_var "Input record for function dp_suddenChange_DP"
          annotation (Dialog(group="Variable inputs"));
        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //output variables
        output SI.Pressure DP "Output for function dp_suddenChange_DP";

      protected
        Real MIN=Modelica.Constants.eps;
        SI.ReynoldsNumber Re_min=1
          "Minimum Reynolds number for linear smoothing";
        //restriction of local resistance coefficient zeta_LOC >> numerical improvement
        TYP.LocalResistanceCoefficient zeta_LOC_min=1e-3
          "Minimal local resistance coefficient";

        SI.Area A_1=max(MIN, min(IN_con.A_1, IN_con.A_2))
          "Small cross sectional area of orifice";
        SI.Area A_2=max(MIN, max(IN_con.A_1, IN_con.A_2))
          "Large cross sectional area of orifice";
        SI.Length C_1=max(MIN, min(IN_con.C_1, IN_con.C_2))
          "Perimeter of small cross sectional area of orifice";
        SI.Length C_2=max(MIN, max(IN_con.C_1, IN_con.C_2))
          "perimeter of large cross sectional area of orifice";
        SI.Diameter d_hyd=4*A_1/C_1
          "Hydraulic diameter of small cross sectional area of orifice";

        //sudden expansion  :  SOURCE_1, section 4, diagram 4-1, page 208
        //assumption of Re >= 3.3e3 for sudden expansion
        TYP.LocalResistanceCoefficient zeta_LOC_exp=max(zeta_LOC_min, (1 - A_1/A_2)^2);

        //sudden contraction:  SOURCE_1, section 4, diagram 4-9, page 216 / 217
        //assumption of Re >= 1.0e4 for sudden contraction
        TYP.LocalResistanceCoefficient zeta_LOC_con=max(zeta_LOC_min, 0.5*(1 - A_1/
            A_2)^0.75);

        SI.Velocity velocity_1=m_flow/(IN_var.rho*A_1)
          "Mean velocity in smaller cross sectional area";

        //determine Reynolds number for small cross sectional area of orifice
        SI.ReynoldsNumber Re=IN_var.rho*d_hyd*velocity_1/IN_var.eta;

        //actual local resistance coefficient
        TYP.LocalResistanceCoefficient zeta_LOC=zeta_LOC_exp*SMOOTH(
            Re_min,
            0,
            Re) + zeta_LOC_con*SMOOTH(
            -Re_min,
            0,
            Re) + zeta_LOC_min*SMOOTH(
            0,
            Re_min,
            abs(Re));

        //Documentation

      algorithm
        DP := zeta_LOC*IN_var.rho/2*(IN_var.eta/IN_var.rho/d_hyd)^2*
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                Re,
                Re_min,
                2);

        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(m_flow=FD.dp_suddenChange_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of the local pressure loss at a sudden change of the cross sectional areas (sudden expansion or sudden contraction) with sharp corners at turbulent flow regime for incompressible and single-phase fluid flow through arbitrary shaped cross sectional area (square, circular, etc.) considering a smooth surface. The flow direction determines the type of the transition. In case of the design flow a sudden expansion will be considered. At flow reversal a sudden contraction will be considered.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_MFLOW\">dp_suddenChange_MFLOW</a> is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
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

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/pic_suddenChangeSection.png\">

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

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/fig_orifice_suddenChangeExpansion.png\">

The local resistance coefficient <b> zeta_LOC </b> of a sudden contraction in dependence of the cross sectional area ratio <b> A_1/A_2 </b> is shown in the figure below.

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/fig_orifice_suddenChangeContraction.png\">

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
      end dp_suddenChange_DP;

      function dp_suddenChange_MFLOW
        "Pressure loss of orifice with sudden change in cross sectional area | calculate mass flow rate | turbulent flow regime | smooth surface | arbitrary cross sectional area | without buffles | sharp edge"

        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Orifice;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.OrificeSuddenChangeSection_d;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_IN_con
          IN_con "Input record for function dp_suddenChange_MFLOW"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_IN_var
          IN_var "Input record for function dp_suddenChange_MFLOW"
          annotation (Dialog(group="Variable inputs"));
        input SI.Pressure dp "Pressure loss" annotation (Dialog(group="Input"));

        //output variables
        output SI.MassFlowRate M_FLOW
          "Output for function dp_suddenChange_MFLOW";

      protected
        Real MIN=Modelica.Constants.eps;
        SI.Pressure dp_min=1 "Pressure loss for linear smoothing";
        //restriction of local resistance coefficient zeta_LOC >> numerical improvement
        TYP.LocalResistanceCoefficient zeta_LOC_min=1e-3
          "Minimal local resistance coefficient";

        SI.Area A_1=max(MIN, min(IN_con.A_1, IN_con.A_2))
          "Small cross sectional area of orifice";
        SI.Area A_2=max(MIN, max(IN_con.A_1, IN_con.A_2))
          "Large cross sectional area of orifice";

        //sudden expansion  :  SOURCE_1, section 4, diagram 4-1, page 208
        //assumption of Re >= 3.3e3 for sudden expansion
        TYP.LocalResistanceCoefficient zeta_LOC_exp=max(zeta_LOC_min, (1 - A_1/A_2)^2);

        //sudden contraction:  SOURCE_1, section 4, diagram 4-9, page 216 / 217
        //assumption of Re >= 1.0e4 for sudden contraction
        TYP.LocalResistanceCoefficient zeta_LOC_con=max(zeta_LOC_min, 0.5*(1 - A_1/
            A_2)^0.75);

        //actual local resistance coefficient
        TYP.LocalResistanceCoefficient zeta_LOC=max(zeta_LOC_min, zeta_LOC_exp*SMOOTH(
            dp_min,
            0,
            dp) + zeta_LOC_con*SMOOTH(
            -dp_min,
            0,
            dp)) + zeta_LOC_min*SMOOTH(
            0,
            dp_min,
            abs(dp));

        //Documentation

      algorithm
        M_FLOW := IN_var.rho*A_1*
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                dp,
                dp_min,
                0.5)*(max(MIN, 2/(IN_var.rho*zeta_LOC)))^0.5;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(dp=FD.dp_suddenChange_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of the local pressure loss at a sudden change of the cross sectional areas (sudden expansion or sudden contraction) with sharp corners at turbulent flow regime for incompressible and single-phase fluid flow through arbitrary shaped cross sectional area (square, circular, etc.) considering a smooth surface. The flow direction determines the type of the transition. In case of the design flow a sudden expansion will be considered. At flow reversal a sudden contraction will be considered.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_DP\">dp_suddenChange_DP</a> is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used within the restricted limits according to the referenced literature.
<ul>
 <li>
      <b>Smooth surface</b>
 <li>
      <b>Turbulent flow regime</b>
 <li>
      <b>Reynolds number for sudden expansion Re &gt; 3.3e3 </b> <i>[Idelchik 2006, p. 208, diag. 4-1] </i>
 <li>
      <b>Reynolds number for sudden contraction Re &gt; 1e4 </b> <i>[Idelchik 2006, p. 216-217, diag. 4-9] </i>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/pic_suddenChangeSection.png\">

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

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/fig_orifice_suddenChangeExpansion.png\">
<p>
The local resistance coefficient <b> zeta_LOC </b> of a sudden contraction in dependence of the cross sectional area ratio <b> A_1/A_2 </b> is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/fig_orifice_suddenChangeContraction.png\">

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
      end dp_suddenChange_MFLOW;

      record dp_suddenChange_IN_con
        "Input record for function dp_suddenChange, dp_suddenChange_DP and dp_suddenChange_MFLOW"

        //orifice variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.Orifice(
          final A_0=0,
          final C_0=0,
          final K=0,
          final L=0);

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss functions <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange\"> dp_suddenChange </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_DP\"> dp_suddenChange_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_MFLOW\"> dp_suddenChange_MFLOW </a>.
</html>"));
      end dp_suddenChange_IN_con;

      record dp_suddenChange_IN_var
        "Input record for function dp_suddenChange, dp_suddenChange_DP and dp_suddenChange_MFLOW"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss functions <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange\"> dp_suddenChange </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_DP\"> dp_suddenChange_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_MFLOW\"> dp_suddenChange_MFLOW </a>.
</html>"));
      end dp_suddenChange_IN_var;

      function dp_thickEdgedOverall_DP
        "Pressure loss of thick and sharp edged orifice | calculate pressure loss | overall flow regime | constant influence of friction  | arbitrary cross sectional area"

        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Orifice;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.OrificeThickEdged_d;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con
          IN_con "Input record for function dp_thickEdgedOverall_DP"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var
          IN_var "Input record for function dp_thickEdgedOverall_DP"
          annotation (Dialog(group="Variable inputs"));

        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //output variables
        output SI.Pressure DP "Output for function dp_thickEdgedOverall_DP";

      protected
        Real MIN=Modelica.Constants.eps;

        TYP.DarcyFrictionFactor lambda_FRI=0.02
          "Assumption for darcy friction factor in vena contraction according to SOURCE_1";
        SI.ReynoldsNumber Re_min=1;
        SI.ReynoldsNumber Re_lim=1e3
          "Limitation for laminar regime if dp is target";

        SI.Area A_0=IN_con.A_0 "Cross sectional area of vena contraction";
        SI.Area A_1=IN_con.A_1
          "Cross sectional area of large cross sectional area";
        SI.Diameter d_hyd_0=max(MIN, 4*A_0/IN_con.C_0)
          "Hydraulic diameter of vena contraction";
        SI.Diameter d_hyd_1=max(MIN, 4*A_1/IN_con.C_1)
          "Hydraulic diameter of large cross sectional area";
        SI.Length l=IN_con.L "Length of vena contraction";
        SI.Length l_bar=IN_con.L/d_hyd_0;

        //SOURCE_1, section 4, diagram 4-15, page 222:
        Real phi=0.25 + 0.535*min(l_bar, 2.4)^8/(0.05 + min(l_bar, 2.4)^8);
        Real tau=(max(2.4 - l_bar, 0))*10^(-phi);

        TYP.PressureLossCoefficient zeta_TOT_1=max(MIN, (0.5*(1 - A_0/A_1)^0.75 + tau
            *(1 - A_0/A_1)^1.375 + (1 - A_0/A_1)^2 + lambda_FRI*l/d_hyd_0)*(A_1/A_0)^
            2)
          "Pressure loss coefficient w.r.t. to flow velocity in large cross sectional area";
        SI.Velocity v_0=m_flow/(IN_var.rho*A_0)
          "Mean velocity in vena contraction";
        SI.ReynoldsNumber Re=IN_var.rho*v_0*d_hyd_0/max(MIN, IN_var.eta)
          "Reynolds number in vena contraction";

        //Documentation

      algorithm
        DP := zeta_TOT_1*IN_var.rho/2*(IN_var.eta/IN_var.rho/d_hyd_1)^2*
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                Re,
                Re_min,
                2)*(d_hyd_1/d_hyd_0*A_0/A_1)^2;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(m_flow=FD.dp_thickEdgedOverall_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of pressure loss in thick edged orifices with sharp corners at overall flow regime for incompressible and single-phase fluid flow through an arbitrary shaped cross sectional area (square, circular, etc.) considering constant influence of surface roughness.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW\">dp_thickEdgedOverall_MFLOW</a> is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
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

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/pic_thickEdged.png\">

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

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/fig_orifice_thickEdgedOverall_ZETAvsLENGHT.png\">

<p>
<b> Incompressible case </b> [Pressure loss = f(m_flow)]:
</p>
The pressure loss <b> DP </b> of an thick edged orifice in dependence of the mass flow rate <b> m_flow </b> of water for different ratios <b>A_0/A_1</b> (where <b> A_0 </b> = 0.001 m^2) is shown in the figure below.

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/fig_orifice_thickEdgedOverall_DPvsMFLOW.png\">

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
      end dp_thickEdgedOverall_DP;

      function dp_thickEdgedOverall_MFLOW
        "Pressure loss of thick and sharp edged orifice | calculate mass flow rate | overall flow regime | constant influence of friction  | arbitrary cross sectional area"

        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Orifice;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.OrificeThickEdged_d;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con
          IN_con "Input record for function dp_thickEdgedOverall_MFLOW"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var
          IN_var "Input record for function dp_thickEdgedOverall_MFLOW"
          annotation (Dialog(group="Variable inputs"));

        input SI.Pressure dp "Pressure loss" annotation (Dialog(group="Input"));

        //output variables
        output SI.MassFlowRate M_FLOW
          "Output for function dp_thickEdgedOverall_MFLOW";

      protected
        Real MIN=Modelica.Constants.eps;
        TYP.DarcyFrictionFactor lambda_FRI=0.02
          "Assumption for darcy friction factor in vena contraction according to SOURCE_1";
        SI.ReynoldsNumber Re_lim=1e3
          "Limitation for laminar regime if dp is target";

        SI.Area A_0=IN_con.A_0 "Cross sectional area of vena contraction";
        SI.Area A_1=IN_con.A_1 "Large cross sectional area";
        SI.Diameter d_hyd_0=max(MIN, 4*A_0/IN_con.C_0)
          "Hydraulic diameter of vena contraction";
        SI.Diameter d_hyd_1=max(MIN, 4*A_1/IN_con.C_1)
          "Hydraulic diameter of large cross sectional area";
        SI.Length l=IN_con.L "Length of vena contraction";
        SI.Length l_bar=IN_con.L/d_hyd_0;

        //SOURCE_1, section 4, diagram 4-15, page 222:
        Real phi=0.25 + 0.535*min(l_bar, 2.4)^8/(0.05 + min(l_bar, 2.4)^8);
        Real tau=(max(2.4 - l_bar, 0))*10^(-phi);

        TYP.PressureLossCoefficient zeta_TOT_1=max(MIN, (0.5*(1 - A_0/A_1)^0.75 + tau
            *(1 - A_0/A_1)^1.375 + (1 - A_0/A_1)^2 + lambda_FRI*l/d_hyd_0)*(A_1/A_0)^
            2)
          "Pressure loss coefficient w.r.t. to flow velocity in large cross sectional area";

        //Documentation

      algorithm
        M_FLOW := IN_var.rho*A_1*
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                dp,
                IN_con.dp_smooth,
                0.5)/(0.5*IN_var.rho*zeta_TOT_1)^0.5;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(dp=FD.dp_thickEdgedOverall_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of pressure loss in thick edged orifices with sharp corners at overall flow regime for incompressible and single-phase fluid flow through an arbitrary shaped cross sectional area (square, circular, etc.) considering constant influence of surface roughness.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> compressible case </b>, where the pressure loss (dp) is known (out of pressures as state variable) in the used model and the corresponding mass flow rate (M_FLOW) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP\">dp_thickEdgedOverall_DP</a> is numerically best used for the <b> incompressible case </b> if the mass flow rate (m_flow) is known (as state variable) and the pressure loss (DP) has to be calculated.
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

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/pic_thickEdged.png\">

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

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/fig_orifice_thickEdgedOverall_ZETAvsLENGHT.png\">

<p>
<b> Compressible case </b> [Mass flow rate = f(dp)]:
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/fig_orifice_thickEdgedOverall_MFLOWvsDP.png\">

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
      end dp_thickEdgedOverall_MFLOW;

      record dp_thickEdgedOverall_IN_con
        "Input record for function dp_thickEdgedOverall, dp_thickEdgedOverall_DP and dp_thickEdgedOverall_MFLOW"

        //orifice variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.Orifice(
          final A_2=A_1,
          final K=0,
          final C_2=C_1);

        //linearisation
        SI.Pressure dp_smooth(min=Modelica.Constants.eps) = 1
          "Start linearisation for decreasing pressure loss"
          annotation (Dialog(group="Linearisation"));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss functions <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall\"> dp_thickEdgedOverall </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP\"> dp_thickEdgedOverall_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW\"> dp_thickEdgedOverall_MFLOW </a>.
</html>"));
      end dp_thickEdgedOverall_IN_con;

      record dp_thickEdgedOverall_IN_var
        "Input record for function dp_thickEdgedOverall, dp_thickEdgedOverall_DP and dp_thickEdgedOverall_MFLOW"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss functions <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall\"> dp_thickEdgedOverall </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP\"> dp_thickEdgedOverall_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW\"> dp_thickEdgedOverall_MFLOW </a>.
</html>"));
      end dp_thickEdgedOverall_IN_var;
    end Orifice;

    package StraightPipe
      "Package for pressure loss calculation of straight pipes"
    extends Modelica.Icons.VariantsPackage;

      function dp_laminar_DP
        "Pressure loss of straight pipe | calculate pressure loss| laminar flow regime (Hagen-Poiseuille)"

        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.

        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.StraightPipe_d;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_con
          IN_con "Input record for function dp_laminar_DP"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_var
          IN_var "Input record for function dp_laminar_DP"
          annotation (Dialog(group="Variable inputs"));
        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //output variables
        output SI.Pressure DP "Output for function dp_laminar_DP";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=IN_con.d_hyd "Hydraulic diameter";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Circular cross sectional area";

        SI.Velocity velocity=m_flow/max(MIN, IN_var.rho*A_cross)
          "Mean velocity";

        //Documentation

      algorithm
        DP := 32*IN_var.eta*velocity*IN_con.L/d_hyd^2;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(m_flow=FD.dp_laminar_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <b> laminar </b> flow regime of an incompressible and single-phase fluid flow only.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW\">dp_laminar_MFLOW</a> is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used inside of the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> circular cross sectional area </b>
 <li>
      <b> laminar flow regime (Reynolds number Re &le 2000) <i>[VDI-W&auml;rmeatlas 2002, p. Lab, eq. 3] </i> </b>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_straightPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The pressure loss <b> dp </b> for straight pipes is determined by:
<p>
<pre>
dp = lambda_FRI * (L/d_hyd) * (rho/2) * velocity^2
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-].</td></tr>
<tr><td><b> L              </b></td><td> as length of straight pipe [m],</td></tr>
<tr><td><b> d_hyd          </b></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><b> rho            </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> velocity       </b></td><td> as mean velocity [m/s].</td></tr>
</table>
</p>

The darcy friction factor <b> lambda_FRI </b> of straight pipes for the laminar flow regime is calculated by <b> Hagen-Poiseuilles </b> law according to <i>[Idelchik 2006, p. 77, eq. 2-3]</i> as follows:
<ul>
 <li>
     <b> Laminar flow regime </b> is restricted to a Reynolds number <b> Re </b> &le; 2000</li> and calculated through:
     <pre>

     lambda_FRI = 64/Re
     </pre>

     <p>
     with
  </p>

     <p>
     <table>
     <tr><td><b> lambda_FRI     </b></td><td> as darcy friction factor [-],</td></tr>
     <tr><td><b> Re             </b></td><td> as Reynolds number [-].</td></tr>
     </table>
  </p>

 </li>
</ul>

<p>
The darcy friction factor <b> lambda_FRI </b> in the laminar regime is independent
of the surface roughness <b> K </b> as long as the relative roughness <b> k = surface rouhgness/hydraulic diameter </b> is smaller than 0.007.
A higher relative roughness <b> k </b> than 0.007 leads to an earlier leaving of the laminar regime to the transition regime at some value of Reynolds number <b> Re_lam_leave </b>. This earlier leaving is not modelled here because only laminar fluid flow is considered.
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The darcy friction factor <b> lambda_FRI </b> in dependence of Reynolds number is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/fig_straightPipe_laminar_lambdavsRe_ver.png\">

<p>
The pressure loss <b> dp </b> for the laminar regime in dependence of the mass flow rate of water is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/fig_straightPipe_dp_laminar_DPvsMFLOW.png\">

<p>
Note that this pressure loss function shall not be used for the modelling outside of the laminar flow regime at <b> Re </b> &gt; 2000</li> even though it could be used for that.
</p>

<p>
If the whole flow
regime shall be modelled, the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall\">dp_overall</a> can be used.
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
 <dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>
</html>
"));
      end dp_laminar_DP;

      function dp_laminar_MFLOW
        "Pressure loss of straight pipe | calculate mass flow rate | laminar flow regime (Hagen-Poiseuille)"

        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.

        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.StraightPipe_d;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_con
          IN_con "Input record for function dp_laminar_MFLOW"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_var
          IN_var "Input record for function dp_laminar_MFLOW"
          annotation (Dialog(group="Variable inputs"));
        input SI.Pressure dp "Pressure loss" annotation (Dialog(group="Input"));

        //output variables
        output SI.MassFlowRate M_FLOW "Output for function dp_laminar_MFLOW";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=max(MIN, IN_con.d_hyd) "Hydraulic diameter";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Circular cross sectional area";

        //Documentation

      algorithm
        M_FLOW := IN_var.rho*A_cross*(dp*d_hyd^2/(32*IN_var.eta*IN_con.L));
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(dp=FD.dp_laminar_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <b> laminar </b> flow regime of an incompressible and single-phase fluid flow only.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> compressible case </b>, where the pressure loss (dp) is known (out of pressures as state variable) in the used model and the corresponding mass flow rate (M_FLOW) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_DP\">dp_laminar_DP</a> is numerically best used for the <b> incompressible case </b> if the mass flow rate (m_flow) is known (as state variable) and the pressure loss (DP) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used inside of the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> circular cross sectional area </b>
 <li>
      <b> laminar flow regime (Reynolds number Re &le 2000) <i>[VDI-W&auml;rmeatlas 2002, p. Lab, eq. 3] </i> </b>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_straightPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The pressure loss <b> dp </b> for straight pipes is determined by:
<p>
<pre>
dp = lambda_FRI * (L/d_hyd) * (rho/2) * velocity^2
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-].</td></tr>
<tr><td><b> L              </b></td><td> as length of straight pipe [m],</td></tr>
<tr><td><b> d_hyd          </b></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><b> rho            </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> velocity       </b></td><td> as mean velocity [m/s].</td></tr>
</table>
</p>

The darcy friction factor <b> lambda_FRI </b> of straight pipes for the laminar flow regime is calculated by <b> Hagen-Poiseuilles </b> law according to <i>[Idelchik 2006, p. 77, eq. 2-3]</i> as follows:
<ul>
 <li>
     <b> Laminar flow regime </b> is restricted to a Reynolds number <b> Re </b> &le; 2000</li> and calculated through:
     <pre>

     lambda_FRI = 64/Re
     </pre>

     <p>
     with
  </p>

     <p>
     <table>
     <tr><td><b> Re     </b></td><td> as Reynolds number [-].</td></tr>
     </table>
  </p>

 </li>
</ul>

<p>
The darcy friction factor <b> lambda_FRI </b> in the laminar regime is independent
of the surface roughness <b> K </b> as long as the relative roughness <b> k = surface rouhgness/hydraulic diameter </b> is smaller than 0.007.
A higher relative roughness <b> k </b> than 0.007 leads to an earlier leaving of the laminar regime to the transition regime at some value of Reynolds number <b> Re_lam_leave </b>. This earlier leaving is not modelled here because only laminar fluid flow is considered.
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The darcy friction factor <b> lambda_FRI </b> in dependence of Reynolds number is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/fig_straightPipe_laminar_lambdavsRe_ver.png\">

<p>
The mass flow rate for the laminar regime in dependence of the pressure loss of water is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/fig_straightPipe_dp_laminar_MFLOWvsDP.png\">

<p>
Note that this pressure loss function shall not be used for the modelling outside of the laminar flow regime at <b> Re </b> &gt; 2000</li> even though it could be used for that.
</p>

<p>
If the whole flow
regime shall be modelled, the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall\">dp_overall</a> can be used.
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
 <dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>
</html>
"));
      end dp_laminar_MFLOW;

      record dp_laminar_IN_con
        "Input record for function dp_laminar, dp_laminar_DP and dp_laminar_MFLOW"

        extends
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con(      final
            roughness=1, final K=0);

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar\"> dp_laminar </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_DP\"> dp_laminar_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW\"> dp_laminar_MFLOW </a>.
</html>"));

      end dp_laminar_IN_con;

      record dp_laminar_IN_var
        "Input record for function dp_laminar, dp_laminar_DP and dp_laminar_MFLOW"

        extends
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar\"> dp_laminar </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_DP\"> dp_laminar_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW\"> dp_laminar_MFLOW </a>.
</html>"));

      end dp_laminar_IN_var;

      function dp_overall_DP
        "Pressure loss of straight pipe | calculate pressure loss | overall flow regime | surface roughness"

        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.StraightPipe_d;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con
          IN_con "Input record for function dp_overall_DP"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var
          IN_var "Input record for function dp_overall_DP"
          annotation (Dialog(group="Variable inputs"));
        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //output variables
        output SI.Pressure DP "Output for function dp_overall_DP";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=max(MIN, IN_con.d_hyd) "Hydraulic diameter";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Circular cross sectional area";
        Real k=max(MIN, abs(IN_con.K)/IN_con.d_hyd) "Relative roughness";
        SI.Length perimeter=PI*IN_con.d_hyd "Perimeter";

        //SOURCE_1: p.81, fig. 2-3, sec 21-22: definition of flow regime boundaries
        SI.ReynoldsNumber Re_lam_min=1e3
          "Minimum Reynolds number for laminar regime";
        SI.ReynoldsNumber Re_lam_max=2090*(1/max(0.007, k))^0.0635
          "Maximum Reynolds number for laminar regime";
        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754*
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k)))
          "Start of transition regime for increasing Reynolds number (leaving laminar regime)";

        SI.ReynoldsNumber Re=
            Modelica.Fluid.Dissipation.Utilities.Functions.General.ReynoldsNumber(
            A_cross,
            perimeter,
            IN_var.rho,
            IN_var.eta,
            m_flow);

        //Documentation

      algorithm
        DP := SMOOTH(
                Re_lam_min,
                Re_lam_max,
                Re)*Dissipation.PressureLoss.StraightPipe.dp_laminar_DP(
                IN_con,
                IN_var,
                m_flow) + SMOOTH(
                Re_lam_max,
                Re_lam_min,
                Re)*Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP(
                IN_con,
                IN_var,
                m_flow);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(m_flow=FD.dp_overall_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <b> overall </b> flow regime of an incompressible and single-phase fluid flow only considering surface roughness.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW\">dp_overall_MFLOW</a> is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used within the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> circular cross sectional area </b>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_straightPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The pressure loss <b> dp </b> for straight pipes is determined by:
<p>
<pre>
dp = lambda_FRI * (L/d_hyd) * (rho/2) * velocity^2
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-],</td></tr>
<tr><td><b> L              </b></td><td> as length of straight pipe [m],</td></tr>
<tr><td><b> d_hyd          </b></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><b> rho            </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> velocity       </b></td><td> as mean velocity [m/s].</td></tr>
</table>
</p>

<p>
The darcy friction factor <b> lambda_FRI </b> for straight pipes is calculated depending on the fluid flow regime (with corresponding Reynolds number <b>Re</b>) and the absolute surface roughness <b> K </b>.
</p>

<b> Laminar regime </b> is calculated for <b> Re </b> &le; 2000</li> by the Hagen-Poiseuille law according to <i>[Idelchik 2006, p. 77, eq. 2-3]</i>
<pre>
    lambda_FRI = 64/Re
</pre>

<p>
The darcy friction factor <b> lambda_FRI </b> in the laminar regime is independent of the surface roughness <b> k </b> as long as the relative roughness <b> k </b> is smaller than 0.007. A greater relative roughness <b> k </b> than 0.007 is leading to an earlier leaving of the Hagen-Poiseuille law at some value of Reynolds number <b> Re_lam_leave </b>. The leaving of the laminar regime in dependence of the relative roughness <b> k </b> is calculated according to <i>[Samoilenko in Idelchik 2006, p. 81, sect. 2-1-21]</i> as:
</p>
<pre>
    Re_lam_leave = 754*exp(if k &le; 0.007 then 0.93 else 0.0065/k)
</pre>

<p>
<b> Transition regime </b> is calculated for <b> 2000 &lt; <b> Re </b> &le; 4000 </b> by a cubic interpolation between the equations of the laminar and turbulent flow regime. Different cubic
interpolation equations for the calculation of either pressure loss <b> dp </b> or mass flow rate <b> m_flow </b> results in a deviation of the darcy friction factor <b> lambda_FRI </b> through the
transition regime. This deviation can be neglected due to the uncertainty in determination of the fluid flow in the transition regime.
</p>

<p>
<b> Turbulent regime </b> can be calculated for a smooth surface (Blasius law) <b> or </b> a rough surface (Colebrook-White law):
</p>

<p>
<b> Smooth surface (roughness =1) </b> w.r.t. <b> Blasius </b> law in the turbulent regime according to <i>[Idelchik 2006, p. 77, sec. 15]</i>:
</p>
<pre>
    lambda_FRI = 0.3164*Re^(-0.25)
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-].</td></tr>
<tr><td><b> Re             </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<p>
Note that the Darcy friction factor <b> lambda_FRI </b> for smooth straight pipes in the turbulent regime is independent
of the surface roughness <b> K </b> .
</p>

<p>
<b> Rough surface (roughness =2) </b> w.r.t. <b> Colebrook-White </b> law in the turbulent regime according to <i>[Miller 1984, p. 191, eq. 8.4]</i>:
</p>
<pre>
    lambda_FRI = 0.25/{lg[k/(3.7*d_hyd) + 5.74/(Re)^0.9]}^2
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_hyd          </b></td><td> as hydraulic diameter [-],</td></tr>
<tr><td><b> k= K/d_hyd     </b></td><td> as relative roughness [-],</td></tr>
<tr><td><b> K              </b></td><td> as roughness (average height of surface asperities [m],</td></tr>
<tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-],</td></tr>
<tr><td><b> Re             </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The Darcy friction factor <b> lambda_FRI </b> in dependence of Reynolds number for different values of relative roughness <b> k </b> is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/fig_straightPipe_dp_overall_lambdavsRe_ver.png\">

<p>
The pressure loss <b> dp </b> for the turbulent regime in dependence of the mass flow rate of water is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/fig_straightPipe_dp_overall_DPvsMFLOW.png\">

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
</html>"));
      end dp_overall_DP;

      function dp_overall_MFLOW
        "Pressure loss of straight pipe | calculate mass flow rate | overall flow regime | surface roughness"

        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.StraightPipe_d;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con
          IN_con "Input record for function dp_overall_MFLOW"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var
          IN_var "Input record for function dp_overall_MFLOW"
          annotation (Dialog(group="Variable inputs"));
        input SI.Pressure dp "Pressure loss" annotation (Dialog(group="Input"));

        //output variables
        output SI.MassFlowRate M_FLOW "Output of function dp_overall_MFLOW";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=max(MIN, IN_con.d_hyd) "Hydraulic diameter";
        SI.Area A_cross=max(MIN, PI*IN_con.d_hyd^2/4)
          "Circular cross sectional area";
        Real k=max(MIN, abs(IN_con.K)/IN_con.d_hyd) "Relative roughness";

        //SOURCE_1: p.81, fig. 2-3, sec 21-22: definition of flow regime boundaries
        SI.ReynoldsNumber Re_lam_min=1e3
          "Minimum Reynolds number for laminar regime";
        SI.ReynoldsNumber Re_lam_max=2090*(1/max(0.007, k))^0.0635
          "Maximum Reynolds number for laminar regime";
        SI.ReynoldsNumber Re_turb_min=4e3
          "Minimum Reynolds number for turbulent regime";

        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754*
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k)))
          "Start of transition regime for increasing Reynolds number (leaving laminar regime)";

        //determining darcy friction factor out of pressure loss calulation for straight pipe:
        //dp = lambda_FRI*L/d_hyd*(rho/2)*velocity^2 and assuming lambda_FRI == lambda_FRI_calc/Re^2
        TYP.DarcyFrictionFactor lambda_FRI_calc=2*abs(dp)*d_hyd^3*IN_var.rho/(IN_con.L
            *IN_var.eta^2) "Adapted Darcy friction factor";

        //SOURCE_3: p.Lab 1, eq. 5: determine Re assuming laminar regime (Blasius)
        SI.ReynoldsNumber Re_lam=lambda_FRI_calc/64
          "Reynolds number assuming laminar regime";

        //SOURCE_3: p.Lab 2, eq. 10: determine Re assuming turbulent regime (Colebrook-White)
        SI.ReynoldsNumber Re_turb=if IN_con.roughness == 1 then (max(MIN,
            lambda_FRI_calc)/0.3164)^(1/1.75) else -2*sqrt(max(lambda_FRI_calc, MIN))
            *Modelica.Math.log10(2.51/sqrt(max(lambda_FRI_calc, MIN)) + k/3.7)
          "Reynolds number assuming turbulent regime";

        //determine actual flow regime
        SI.ReynoldsNumber Re_check=if Re_lam < Re_lam_leave then Re_lam else Re_turb;
        //determine Re for transition regime
        SI.ReynoldsNumber Re_trans=if Re_lam >= Re_lam_leave then
            Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_DP(
            Re_check,
            Re_lam_leave,
            Re_turb_min,
            k,
            lambda_FRI_calc) else 0;
        //determine actual Re
        SI.ReynoldsNumber Re=if Re_lam < Re_lam_leave then Re_lam else if Re_turb >
            Re_turb_min then Re_turb else Re_trans;

        //Documentation

      algorithm
        M_FLOW := SMOOTH(
                Re_lam_min,
                Re_turb,
                Re)*Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW(
                IN_con,
                IN_var,
                dp) + SMOOTH(
                Re_turb,
                Re_lam_min,
                Re)*Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW(
                IN_con,
                IN_var,
                dp);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(dp=FD.dp_overall_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <b> overall </b> flow regime of an incompressible and single-phase fluid flow only considering surface roughness.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> compressible case </b>, where the pressure loss (dp) is known (out of pressures as state variable) in the used model and the corresponding mass flow rate (M_FLOW) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_DP\">dp_overall_DP</a> is numerically best used for the <b> incompressible case </b> if the mass flow rate (m_flow) is known (as state variable) and the pressure loss (DP) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used within the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> circular cross sectional area </b>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_straightPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The pressure loss <b> dp </b> for straight pipes is determined by:
<p>
<pre>
dp = lambda_FRI * (L/d_hyd) * (rho/2) * velocity^2
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-],</td></tr>
<tr><td><b> L              </b></td><td> as length of straight pipe [m],</td></tr>
<tr><td><b> d_hyd          </b></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><b> rho            </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> velocity       </b></td><td> as mean velocity [m/s].</td></tr>
</table>
</p>

<p>
The darcy friction factor <b> lambda_FRI </b> for straight pipes is calculated depending on the fluid flow regime (with corresponding Reynolds number <b>Re</b>) and the absolute surface roughness <b> K </b>.
</p>

<b> Laminar regime </b> is calculated for <b> Re </b> &le; 2000</li> by the Hagen-Poiseuille law according to <i>[Idelchik 2006, p. 77, eq. 2-3]</i>
<pre>
    lambda_FRI = 64/Re
</pre>

<p>
The darcy friction factor <b> lambda_FRI </b> in the laminar regime is independent of the surface roughness <b> k </b> as long as the relative roughness <b> k </b> is smaller than 0.007. A greater relative roughness <b> k </b> than 0.007 is leading to an earlier leaving of the Hagen-Poiseuille law at some value of Reynolds number <b> Re_lam_leave </b>. The leaving of the laminar regime in dependence of the relative roughness <b> k </b> is calculated according to <i>[Samoilenko in Idelchik 2006, p. 81, sect. 2-1-21]</i> as:
</p>
<pre>
    Re_lam_leave = 754*exp(if k &le; 0.007 then 0.93 else 0.0065/k)
</pre>

<p>
<b> Transition regime </b> is calculated for <b> 2000 &lt; <b> Re </b> &le; 4000 </b> by a cubic interpolation between the equations of the laminar and turbulent flow regime. Different cubic
interpolation equations for the calculation of either pressure loss <b> dp </b> or mass flow rate <b> m_flow </b> results in a deviation of the darcy friction factor <b> lambda_FRI </b> through the
transition regime. This deviation can be neglected due to the uncertainty in determination of the fluid flow in the transition regime.
</p>

<p>
<b> Turbulent regime </b> can be calculated for a smooth surface (Blasius law) <b> or </b> a rough surface (Colebrook-White law):
</p>

<p>
<b> Smooth surface (roughness =1) </b> w.r.t. <b> Blasius </b> law in the turbulent regime according to <i>[Idelchik 2006, p. 77, sec. 15]</i>:
</p>
<pre>
    lambda_FRI = 0.3164*Re^(-0.25)
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-].</td></tr>
<tr><td><b> Re             </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<p>
Note that the Darcy friction factor <b> lambda_FRI </b> for smooth straight pipes in the turbulent regime is independent
of the surface roughness <b> K </b> .
</p>

<p>
<b> Rough surface (roughness =2) </b> w.r.t. <b> Colebrook-White </b> law in the turbulent regime according to <i>[Miller 1984, p. 191, eq. 8.4]</i>:
</p>
<pre>
    lambda_FRI = 0.25/{lg[k/(3.7*d_hyd) + 5.74/(Re)^0.9]}^2
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_hyd          </b></td><td> as hydraulic diameter [-],</td></tr>
<tr><td><b> k= K/d_hyd     </b></td><td> as relative roughness [-],</td></tr>
<tr><td><b> K              </b></td><td> as roughness (average height of surface asperities [m].</td></tr>
<tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-],</td></tr>
<tr><td><b> Re             </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The Darcy friction factor <b> lambda_FRI </b> in dependence of Reynolds number for different values of relative roughness <b> k </b> is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/fig_straightPipe_dp_overall_lambdavsRe_ver.png\">

<p>
The mass flow rate <b> m_flow </b> for the turbulent regime in dependence of the pressure loss of water is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/fig_straightPipe_dp_overall_MFLOWvsDP.png\">

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
      end dp_overall_MFLOW;

      record dp_overall_IN_con
        "Input record for function dp_overall, dp_overall_DP and dp_overall_MFLOW"

        Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=Dissipation.Utilities.Types.Roughness.Neglected
          "Choice of considering surface roughness"
          annotation (Dialog(group="Straight pipe"));

        //straight pipe variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.StraightPipe;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall\"> dp_overall </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_DP\"> dp_overall_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW\"> dp_overall_MFLOW </a>.
</html>"));

      end dp_overall_IN_con;

      record dp_overall_IN_var
        "Input record for function dp_overall, dp_overall_DP and dp_overall_MFLOW"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall\"> dp_overall </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_DP\"> dp_overall_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW\"> dp_overall_MFLOW </a>.
</html>"));

      end dp_overall_IN_var;

      function dp_turbulent_DP
        "Pressure loss of straight pipe | calculate pressure loss | turbulent flow regime | surface roughness"

        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //SOURCE_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //SOURCE_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002.

        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.StraightPipe_d;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_con
          IN_con "Input record for function dp_turbulent_DP"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_var
          IN_var "Input record for function dp_turbulent_DP"
          annotation (Dialog(group="Variable inputs"));
        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //output variables
        output SI.Pressure DP "Output for function dp_turbulent_DP";

      protected
        type TYP1 = Modelica.Fluid.Dissipation.Utilities.Types.Roughness;

        Real MIN=Modelica.Constants.eps;

        SI.ReynoldsNumber Re_min=1;
        SI.Velocity v_min=Re_min*IN_var.eta/(IN_var.rho*IN_con.d_hyd);

        SI.Diameter d_hyd=IN_con.d_hyd "Hydraulic diameter";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Circular cross sectional area";
        Real k=max(MIN, abs(IN_con.K)/IN_con.d_hyd) "Relative roughness";

        //SOURCE_1: p.81, fig. 2-3, sec 21-22: definition of flow regime boundaries
        SI.ReynoldsNumber Re_lam_min=1e3
          "Minimum Reynolds number for laminar regime";
        SI.ReynoldsNumber Re_lam_max=2090*(1/max(0.007, k))^0.0635
          "Maximum Reynolds number for laminar regime";
        SI.ReynoldsNumber Re_turb_min=4e3
          "Minimum Reynolds number for turbulent regime";

        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754*
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k)))
          "Start of transition regime for increasing Reynolds number (leaving laminar regime)";

        SI.Velocity velocity=m_flow/(IN_var.rho*A_cross) "Mean velocity";
        SI.ReynoldsNumber Re=max(Re_min, IN_var.rho*abs(velocity)*d_hyd/IN_var.eta);

        //SOURCE_2: p.191, eq. 8.4: determining darcy friction factor
        //assuming lambda_FRI == lambda_FRI_calc/Re^2
        TYP.DarcyFrictionFactor lambda_FRI_smooth=0.3164*Re^(1.75)
          "Darcy friction factor neglecting surface roughness (Blasius)";
        //here with lambda_FRI_rough == lambda_FRI*Re^2
        TYP.DarcyFrictionFactor lambda_FRI_rough=0.25*(max(Re, Re_lam_leave)/
            Modelica.Math.log10(k/3.7 + 5.74/max(Re, Re_lam_leave)^0.9))^2
          "Darcy friction factor considering surface roughness";
        TYP.DarcyFrictionFactor lambda_FRI=if IN_con.roughness == TYP1.Neglected then
                  lambda_FRI_smooth else lambda_FRI_rough
          "Darcy friction factor";
        TYP.DarcyFrictionFactor lambda_FRI_calc=if Re < Re_lam_leave then 64/Re else
            if Re > Re_turb_min then lambda_FRI/Re^2 else
            Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_MFLOW(
            Re,
            Re_lam_leave,
            Re_turb_min,
            k)/Re^2 "Darcy friction factor";

        TYP.PressureLossCoefficient zeta_TOT=lambda_FRI_calc*IN_con.L/d_hyd
          "Pressure loss coefficient";

        //Documentation

      algorithm
        DP := zeta_TOT*(IN_var.rho/2)*
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                velocity,
                v_min,
                2);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(m_flow=FD.dp_turbulent_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <b> turbulent </b> flow regime of an incompressible and single-phase fluid flow only considering surface roughness.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW\">dp_turbulent_MFLOW</a> is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used within the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> circular cross sectional area </b>
 <li>
      <b> turbulent flow regime (Reynolds number Re &ge 4e3) <i>[VDI-W&auml;rmeatlas 2002, p. Lab 3, fig. 1] </i> </b>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_straightPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The pressure loss <b> dp </b> for straight pipes is determined by:
<p>
<pre>
dp = lambda_FRI * (L/d_hyd) * (rho/2) * velocity^2
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-].</td></tr>
<tr><td><b> L              </b></td><td> as length of straight pipe [m],</td></tr>
<tr><td><b> d_hyd          </b></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><b> rho            </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> velocity       </b></td><td> as mean velocity [m/s].</td></tr>
</table>
</p>

<p>
The Darcy friction factor <b> lambda_FRI </b> for a straight pipe in the turbulent regime can be calculated for a smooth surface (Blasius law) <b> or </b> a rough surface (Colebrook-White law).
</p>

<p>
<b> Smooth surface (roughness =1) </b> w.r.t. <b> Blasius </b> law in the turbulent regime according to <i>[Idelchik 2006, p. 77, sec. 15]</i>:
</p>
<pre>
    lambda_FRI = 0.3164*Re^(-0.25)
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-].</td></tr>
<tr><td><b> Re             </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<p>
Note that the Darcy friction factor <b> lambda_FRI </b> for smooth straight pipes in the turbulent regime is independent
of the surface roughness <b> K </b> .
</p>

<p>
<b> Rough surface (roughness =2) </b> w.r.t. <b> Colebrook-White </b> law in the turbulent regime according to <i>[Miller 1984, p. 191, eq. 8.4]</i>:
</p>
<pre>
    lambda_FRI = 0.25/{lg[k/(3.7*d_hyd) + 5.74/(Re)^0.9]}^2
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_hyd          </b></td><td> as hydraulic diameter [-],</td></tr>
<tr><td><b> k= K/d_hyd     </b></td><td> as relative roughness [-],</td></tr>
<tr><td><b> K              </b></td><td> as roughness (average height of surface asperities [m].</td></tr>
<tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-],</td></tr>
<tr><td><b> Re             </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The Darcy friction factor <b> lambda_FRI </b> in dependence of Reynolds number for different values of relative roughness <b> k </b> is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/fig_straightPipe_turbulent.png\">

<p>
Note that this pressure loss function shall not be used for the modelling outside of the turbulent flow regime at <b> Re </b> &lt; 4e3 even though it could be used for that.
</p>

</p>
If the overall flow regime shall be modelled, the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall\">dp_overall</a> can be used.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>Idelchik,I.E.:</dt>
    <dd><b>Handbook of hydraulic resistance</b>.
    Jaico Publishing House,Mumbai,3rd edition, 2006.</dd>
 <dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>
</html>"));
      end dp_turbulent_DP;

      function dp_turbulent_MFLOW
        "Pressure loss of straight pipe | calculate mass flow rate | turbulent flow regime | surface roughness"

        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //SOURCE_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //SOURCE_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002.

        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.StraightPipe_d;
        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_con
          IN_con "Input record for function dp_turbulent_MFLOW"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_var
          IN_var "Input record for function dp_turbulent_MFLOW"
          annotation (Dialog(group="Variable inputs"));
        input SI.Pressure dp "Pressure loss" annotation (Dialog(group="Input"));

        //output variables
        output SI.MassFlowRate M_FLOW "Mass flow rate";

      protected
        type TYP1 = Modelica.Fluid.Dissipation.Utilities.Types.Roughness;

        Real MIN=Modelica.Constants.eps;
        SI.ReynoldsNumber Re_min=1;

        SI.Diameter d_hyd=max(MIN, IN_con.d_hyd) "Hydraulic diameter";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Circular cross sectional area";
        Real k=max(MIN, abs(IN_con.K)/IN_con.d_hyd) "Relative roughness";

        //SOURCE_1: p.81, fig. 2-3, sec 21-22: definition of flow regime boundaries
        SI.ReynoldsNumber Re_lam_min=1e3
          "Minimum Reynolds number for laminar regime";
        SI.ReynoldsNumber Re_lam_max=2090*(1/max(0.007, k))^0.0635
          "Maximum Reynolds number for laminar regime";
        SI.ReynoldsNumber Re_turb_min=4e3
          "Minimum Reynolds number for turbulent regime";

        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754*
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k)))
          "Start of transition regime for increasing Reynolds number (leaving laminar regime)";

        //determining darcy friction factor out of pressure loss calulation for straight pipe:
        //dp = lambda_FRI*L/d_hyd*(rho/2)*velocity^2 and assuming lambda_FRI == lambda_FRI_calc/Re^2
        TYP.DarcyFrictionFactor lambda_FRI_calc=2*abs(dp)*d_hyd^3*IN_var.rho/(IN_con.L
            *IN_var.eta^2) "Adapted Darcy friction factor";

        //SOURCE_3: p.Lab 1, eq. 5: determine Re assuming laminar regime (Hagen-Poiseuille)
        SI.ReynoldsNumber Re_lam=lambda_FRI_calc/64
          "Reynolds number assuming laminar regime";

        //SOURCE_3: p.Lab 2, eq. 10: determine Re assuming turbulent regime (Colebrook-White)
        SI.ReynoldsNumber Re_turb=if IN_con.roughness == TYP1.Neglected then (max(MIN,
            lambda_FRI_calc)/0.3164)^(1/1.75) else -2*sqrt(max(lambda_FRI_calc, MIN))
            *Modelica.Math.log10(2.51/sqrt(max(lambda_FRI_calc, MIN)) + k/3.7)
          "Reynolds number assuming turbulent regime";

        //determine actual flow regime
        SI.ReynoldsNumber Re_check=if Re_lam < Re_lam_leave then Re_lam else Re_turb;
        //determine Re for transition regime
        SI.ReynoldsNumber Re_trans=if Re_lam >= Re_lam_leave then
            Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_DP(
            Re_check,
            Re_lam_leave,
            Re_turb_min,
            k,
            lambda_FRI_calc) else 0;
        //determine actual Re
        SI.ReynoldsNumber Re=if Re_lam < Re_lam_leave then Re_lam else if Re_turb >
            Re_turb_min then Re_turb else Re_trans;

        //determine velocity
        SI.Velocity velocity=(if dp >= 0 then Re else -Re)*IN_var.eta/(IN_var.rho*
            d_hyd) "Mean velocity";

        //Documentation

      algorithm
        M_FLOW := IN_var.rho*A_cross*velocity;
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(dp=FD.dp_turbulent_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <b> turbulent </b> flow regime of an incompressible and single-phase fluid flow only considering surface roughness.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this function is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP\">dp_turbulent_DP</a> is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used within the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> circular cross sectional area </b>
 <li>
      <b> turbulent flow regime (Reynolds number Re &ge 4e3) <i>[VDI-W&auml;rmeatlas 2002, p. Lab 3, fig. 1] </i> </b>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_straightPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The pressure loss <b> dp </b> for straight pipes is determined by:
<p>
<pre>
dp = lambda_FRI * (L/d_hyd) * (rho/2) * velocity^2
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-].</td></tr>
<tr><td><b> L              </b></td><td> as length of straight pipe [m],</td></tr>
<tr><td><b> d_hyd          </b></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><b> rho            </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> velocity       </b></td><td> as mean velocity [m/s].</td></tr>
</table>
</p>

<p>
The Darcy friction factor <b> lambda_FRI </b> for a straight pipe in the turbulent regime can be calculated for a smooth surface (Blasius law) <b> or </b> a rough surface (Colebrook-White law).
</p>

<p>
<b> Smooth surface (roughness =1) </b> w.r.t. <b> Blasius </b> law in the turbulent regime according to <i>[Idelchik 2006, p. 77, sec. 15]</i>:
</p>
<pre>
    lambda_FRI = 0.3164*Re^(-0.25)
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-].</td></tr>
<tr><td><b> Re             </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<p>
Note that the Darcy friction factor <b> lambda_FRI </b> for smooth straight pipes in the turbulent regime is independent
of the surface roughness <b> K </b> .
</p>

<p>
<b> Rough surface (roughness =2) </b> w.r.t. <b> Colebrook-White </b> law in the turbulent regime according to <i>[Miller 1984, p. 191, eq. 8.4]</i>:
</p>
<pre>
    lambda_FRI = 0.25/{lg[k/(3.7*d_hyd) + 5.74/(Re)^0.9]}^2
</pre>

<p>
with
</p>

<p>
<table>
<tr><td><b> d_hyd          </b></td><td> as hydraulic diameter [-],</td></tr>
<tr><td><b> k= K/d_hyd     </b></td><td> as relative roughness [-],</td></tr>
<tr><td><b> K              </b></td><td> as roughness (average height of surface asperities [m].</td></tr>
<tr><td><b> lambda_FRI     </b></td><td> as Darcy friction factor [-],</td></tr>
<tr><td><b> Re             </b></td><td> as Reynolds number [-].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The Darcy friction factor <b> lambda_FRI </b> in dependence of Reynolds number for different values of relative roughness <b> k </b> is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/fig_straightPipe_turbulent.png\">

<p>
Note that this pressure loss function shall not be used for the modelling outside of the turbulent flow regime at <b> Re </b> &lt; 4e3 even though it could be used for that.
</p>

</p>
If the overall flow regime shall be modelled, the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall\">dp_overall</a> can be used.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>Idelchik,I.E.:</dt>
    <dd><b>Handbook of hydraulic resistance</b>.
    Jaico Publishing House,Mumbai,3rd edition, 2006.</dd>
 <dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>
</html>
"));
      end dp_turbulent_MFLOW;

      record dp_turbulent_IN_con
        "Input record for function dp_turbulent, function dp_turbulent_DP and dp_turbulent_MFLOW"

        extends
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent\"> dp_turbulent </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP\"> dp_turbulent_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW\"> dp_turbulent_MFLOW </a>.
</html>"));
      end dp_turbulent_IN_con;

      record dp_turbulent_IN_var
        "Input record for function function dp_turbulent, dp_turbulent_DP and dp_turbulent_MFLOW"

        extends
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var;

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent\"> dp_turbulent </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP\"> dp_turbulent_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW\"> dp_turbulent_MFLOW </a>.
</html>"));
      end dp_turbulent_IN_var;

      function dp_twoPhaseOverall_DP
        "Pressure loss of straight pipe for two phase flow | calculate (frictional, momentum, geodetic) pressure loss"

        //SOURCE_1: Friedel,L.:IMPROVED FRICTION PRESSURE DROP CORRELATIONS FOR HORIZONTAL AND VERTICAL TWO PHASE PIPE FLOW, 3R International, Vol. 18, Issue 7, pp. 485-491, 1979
        //SOURCE_2: Chisholm,D.:PRESSURE GRADIENTS DUE TO FRICTION DURING THE FLOW OF EVAPORATING TWO-PHASE MIXTURES IN SMOOTH TUBES AND CHANNELS, Int. J. Heat Mass Transfer, Vol. 16, pp. 347-358, Pergamon Press 1973
        //SOURCE_3: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.
        //SOURCE 4: J.M. Jensen and H. Tummescheit. Moving boundary models for dynamic simulations of two-phase flows. In Proceedings of the 2nd International Modelica Conference, pp. 235-244, Oberpfaffenhofen, Germany, 2002. The Modelica Association.
        //SOURCE_5: Thome, J.R., Engineering Data Book 3, Swiss Federal Institute of Technology Lausanne (EPFL), 2009.

        //icon
        extends
          Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.StraightPipe_d;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_IN_con
          IN_con "Input record for function dp_twoPhaseOverall_DP"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_IN_var
          IN_var "Input record for function dp_twoPhaseOverall_DP"
          annotation (Dialog(group="Variable inputs"));
        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //output variables
        output SI.Pressure DP "Two phase pressure loss";

      protected
        type TYP =
            Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseFrictionalPressureLoss;

        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=max(MIN, IN_con.A_cross) "Cross sectional area";
        SI.Diameter d_hyd=max(MIN, 4*A_cross/max(MIN, IN_con.perimeter))
          "Hydraulic diameter";

        Real mdot_A=abs(m_flow)/A_cross "Mass flux";
        Real xflowEnd=min(1, max(0, abs(IN_var.x_flow_end)))
          "Mass flow rate quality at end of length";
        Real xflowSta=min(1, max(0, abs(IN_var.x_flow_sta)))
          "Mass flow rate quality at start of length";
        Real x_flow=(xflowEnd + xflowSta)/2
          "Mean mass flow rate quality over length";

        //SOURCE_5: p.17-1 to 17-5, sec. 17.1 to 17.2: Considering cross sectional void fraction [epsilon=A_g/(A_g+A_l)]
        Real epsilon=
            Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.VoidFraction(
            IN_con.voidFractionApproach,
            true,
            IN_var.rho_g,
            IN_var.rho_l,
            x_flow) "Void fraction";

        //SOURCE_1: Considering frictional pressure loss w.r.t. to correlation of Friedel
        //SOURCE_2: Considering frictional pressrue loss w.r.t. to correlation of Chisholm
        SI.Pressure DP_fric=if IN_con.frictionalPressureLoss == TYP.Friedel then
            Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.dp_twoPhaseFriedel_DP(
            IN_con,
            IN_var,
            m_flow) else if IN_con.frictionalPressureLoss == TYP.Chisholm then
            Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.dp_twoPhaseChisholm_DP(
            IN_con,
            IN_var,
            m_flow) else 0 "Frictional pressure loss";

        //SOURCE_3: p.Lba 4, eq. 22: Considering momentum pressure loss assuming heterogeneous approach for two phase flow
        //Evaporation >> positive momentum pressure loss (assumed vice versa at condenstation)
        SI.Pressure DP_mom=if IN_con.momentumPressureLoss then
            Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.dp_twoPhaseMomentum_DP(
            IN_con.voidFractionApproach,
            IN_con.massFlowRateCorrection,
            IN_con.A_cross,
            IN_con.perimeter,
            IN_var.rho_g,
            IN_var.rho_l,
            IN_var.x_flow_end,
            IN_var.x_flow_sta,
            abs(m_flow)) else 0 "Momentum pressure loss";

        //SOURCE_3: p.Lbb 1, eq. 4: Considering geodetic pressure loss assuming constant void fraction for flow length
        SI.Pressure DP_geo=if IN_con.geodeticPressureLoss then
            Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.dp_twoPhaseGeodetic_DP(
            IN_con.voidFractionApproach,
            true,
            IN_con.length,
            IN_con.phi,
            IN_var.rho_g,
            IN_var.rho_l,
            IN_var.x_flow) else 0 "Geodetic pressure loss";

        //Documentation
      algorithm
        DP := DP_fric + DP_mom + DP_geo;

        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of pressure loss for <b>two phase flow</b> in a horizontal <b>or</b> vertical straight pipe for an overall flow regime considering frictional, momentum and geodetic pressure loss.
</p>

<p>
Generally the pressure loss for two phase flow in a horizontal or a vertical straight pipe can be calculated for the following fluid flow regimes:
<p>
<p>
<b>Horizontal fluid flow</b> [(a) bubble flow, (b) stratified flow, (c) wavy flow, (d) slug flow, (e) annular flow]:
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_twoPhaseFlowRegimes_horizontal.png\">

<p>
<b>Vertical fluid flow</b> [(a) bubble flow, (b) plug slug flow, (c) foam flow, (d) annular streak flow, (e) annular flow]:
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_twoPhaseFlowRegimes_vertical.png\">


<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used within the restricted limits according to the referenced literature.
<ul>
 <li> <b> circular cross sectional area </b>
 <li> <b> neglecting of surface roughness </b> </li>
 <li> <b> horizontal flow or vertical upflow </b> </li>
 <li> <b> usage of mass flow rate quality (see Calculation) </b> </li>
 <li> <b> two phase pressure loss for mean constant mass flow rate quality (x_flow) over (increment) length </b> </li>
 <li> <b> usage of two phase pressure loss function for discretisation at boiling or condensation considering variable mass flow rate quality </b></li>
</ul>

<h4><font color=\"#EF9B13\">Geometry </font></h4>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/pic_straightPipe.png\">

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The two phase pressure loss <b> dp_2ph </b> of straight pipes is determined by:
<p>
<pre>
dp_2ph = dp_fri + dp_mom + dp_geo
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> dp_fri        </b></td><td> as frictional pressure loss [Pa],</td></tr>
<tr><td><b> dp_mom        </b></td><td> as momentum pressure loss [Pa],</td></tr>
<tr><td><b> dp_geo        </b></td><td> as geodetic pressure loss [Pa].</td></tr>
</table>
</p>

<p>
<b>Definition of quality for two phase flow</b>:
</p>
<p>
Different definitions of the quality exist for two phase flow. Static quality, mass flow rate quality and thermodynamic quality can be used to describe the fraction of gas and liquid in two phase flow.
Here the mass flow rate quality <b>(x_flow)</b> is used to describe two phase flow as follows:
</p>

<p>
<pre>
x_flow = mdot_g/(mdot_g+mdot_l)
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> x_flow        </b></td><td> as mass flow rate quality [-],</td></tr>
<tr><td><b> mdot_g        </b></td><td> as gaseous mass flow rate [kg/s],</td></tr>
<tr><td><b> mdot_l        </b></td><td> as liquid mass flow rate [kg/s].</td></tr>
</table>
</p>

<p>
Note that mass flow rate quality <b>(x_flow)</b> is only equal to the static quality, if a difference between the velocity of gas and liquid phase is neglected (homogeneous approach).
Additionally the thermodynamic quality is only equal to the mass flow rate quality <b>(x_flow)</b> in the two phase regime for thermodynamic equilibrium of the phases.
</p>

<p>
<b>Frictional pressure loss</b>:
</p>

<p>
The frictional pressure loss <b>dp_fri</b> of a straight pipe is calculated either by the correlation of <b>Friedel</b> (frictionalPressureLoss==Friedel) or by the correlation of <b>Chisholm</b> (frictionalPressureLoss==Chisholm).
Both correlations can be used for the above named two phase flow regimes.
The two phase frictional pressure loss results from a frictional pressure loss assuming one phase liquid fluid flow and a two phase multiplier taking into account the effects of two phase flow:
</p>
<pre>
dp_fri = dp_1ph*phi_i
</pre>
</p>
<p>
with
</p>

<p>
<table>
<tr><td><b> dp_1ph  </b></td><td> as frictional pressure loss assuming one phase liquid fluid flow [Pa],</td></tr>
<tr><td><b> phi_i   </b></td><td> as two phase multiplier [-].</td></tr>
</table>
</p>

<p>
The liquid frictional pressure loss is calculated with the <b>total mass flow rate</b> assumed to flow as liquid.
</p>

<p>
The correlations of Friedel and Chisholm differ in their calculation of the two phase multiplier:
</p>
</p>
<pre>
phi_friedel = (1 - x_flow)^2 + x_flow^2*(rho_l/rho_g)*(lambda_g/lambda_l)
            + 3.43*x_flow^0.685*(1 - x_flow)^0.24*(rho_l/rho_g)^0.8*(eta_g/eta_l)^0.22*(1 - eta_g/eta_l)^0.89*(1/Fr_l^(0.048))*(1/We_l^(0.0334))
</pre>
<pre>
phi_chisholm = 1 + (gamma^2 - 1)*(B*x_flow^((2 - n_exp)/2)*(1 - x_flow)^((2 -n_exp)/2) + x_flow^(2 - n_exp))
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> B              </b></td><td> as Lockhart-Martinelli coefficient [-],</td></tr>
<tr><td><b> eta_l          </b></td><td> as dynamic viscosity of the liquid phase [Pas],</td></tr>
<tr><td><b> eta_g          </b></td><td> as dynamic viscosity of the gaseous phase [Pas],</td></tr>
<tr><td><b> gamma          </b></td><td> as physical property coefficient [-],</td></tr>
<tr><td><b> n_exp</b> =0.2     </td><td> as exponent in Chisholm correlation [-],</td></tr>
<tr><td><b> phi_i          </b></td><td> as two phase multiplier [-],</td></tr>
<tr><td><b> rho_l          </b></td><td> as density of the liquid phase [kg/m3],</td></tr>
<tr><td><b> rho_g          </b></td><td> as density of the gaseous phase [kg/m3],</td></tr>
<tr><td><b> Re_l           </b></td><td> as Reynolds number of the liquid phase [-],</td></tr>
<tr><td><b> Re_g           </b></td><td> as Reynolds number of the gaseous phase [-],</td></tr>
<tr><td><b> Fr_l           </b></td><td> as Froude number of the liquid phase [-],</td></tr>
<tr><td><b> We_l           </b></td><td> as Weber number of the liquid phase [-],</td></tr>
<tr><td><b> x_flow         </b></td><td> as mass flow rate quality [-].</td></tr>
</table>
</p>

<p>
Note that the (mean constant) mass flow rate quality <b>(x_flow)</b> used for frictional pressure loss is calculated as arithmetic mean value out of the mass flow rate quality at the end and at the start of the straight pipe length.
</p>

<p>
<b>Momentum pressure loss</b>:
</p>
<p>
The momentum pressure loss <b> dp_mom </b> can be considered (momentumPressureLoss = true) for a homogeneous or heterogeneous two phase flow depending on the approach used for the void fraction <b>(epsilon)</b>.
At evaporation the liquid phase having a slow velocity has to be accelerated to the higher velocity of the gas. The difference in static pressure at the outlet and the inlet causes a positive momentum pressure loss at evaporation (assumed vice versa for condensation).
The momentum pressure loss occurs for a changing mass flow rate quality due to condensation or evaporation according to <i>[VDI 2006, p.Lba 4, eq. 22]</i> :
<p>
<pre>
dp_mom = mdot_A^2*[[((1-x_flow)^2/(rho_l*(1-epsilon)) + x_flow^2/(rho_g*epsilon))]_out - [((1-x_flow)^2/(rho_l*(1-epsilon)) + x_flow^2/(rho_g*epsilon))]_in]
</pre>
</p>
<p>
with
</p>

<p>
<table>
<tr><td><b> mdot_A         </b></td><td> as total mass flow rate density [kg/(m2s)],</td></tr>
<tr><td><b> epsilon        </b></td><td> as void fraction [-],</td></tr>
<tr><td><b> rho_l          </b></td><td> as density of the liquid phase [kg/m3],</td></tr>
<tr><td><b> rho_g          </b></td><td> as density of the gaseous phase [kg/m3],</td></tr>
<tr><td><b> x_flow         </b></td><td> as mass flow rate quality [-].</td></tr>
</table>
</p>

<p>
Note that a momentum pressure loss is only considered for a variable mass flow rate quality <b>(x_flow)</b> during evaporation or condensation. Momentum pressure loss does not occur under adiabatic conditions for a corresponding constant mass flow rate quality (evaporation due to pressure loss is not considered).
</p>

<p>
<b>Void fraction approach</b>:
</p>
<p>
The void fraction is one of the most important parameter used to characterise two phase flow. There are several analytical and empirical approaches according to <i>[Thome, J.R]</i> :
</p>
<ul>
 <li>    <b> homogeneous approach </b> </li>
 <li>     <b> momentum flux approach (heterogeneous model) </b></li>
 <li>     <b> Kinetic energy flow approach by Zivi (heterogeneous model) </b></li>
 <li>     <b> Empirical momentum flux approach by Chisholm (heterogeneous model) </b></li>
</ul>
<p>
These approaches for the void fraction <b>epsilon</b> imply a correlation for the slip ratio. The slip ratio is defined as ratio of the velocity from the gaseous phase to the liquid phase at two phase flow.
The effects of different fluid flow velocities of the phases on two phase pressure loss can be considered with the slip ratio in the heterogeneous approaches. The slip ratio for the homogeneous approach is unity, so that there is no difference in the velocities of the two phases (e.g., usable for bubble flow).
</p>

<p>
<b>Geodetic pressure loss</b>:
</p>
<p>
The geodetic pressure loss <b>dp_geo</b> can be considered (geodeticPressureLoss=true) for two phase flow according to <i>[VDI 2006, p.Lbb 1, eq. 4]</i> :
<p>
<pre>
dp_geo = (epsilon*rho_g +(1-epsilon)*rho_l)*g*L*sin(phi)
</pre>
</p>
<p>
with
</p>

<p>
<table>
<tr><td><b> epsilon        </b></td><td> as void fraction [-],</td></tr>
<tr><td><b> rho_l          </b></td><td> as density of the liquid phase [kg/m3],</td></tr>
<tr><td><b> rho_g          </b></td><td> as density of the gaseous phase [kg/m3],</td></tr>
<tr><td><b> g              </b></td><td> as acceleration of gravity [m/s2],</td></tr>
<tr><td><b> L              </b></td><td> as length of straight pipe [m],</td></tr>
<tr><td><b> phi            </b></td><td> as angle to horizontal [rad].</td></tr>
</table>
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The two phase pressure loss for a horizontal pipe calculated by the correlation of <i> Friedel </i> neglecting momentum and geodetic pressure loss is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/fig_dp_twoPhaseOverall_1.png\">

<p>
The two phase pressure loss for a horizontal pipe calculated by the correlation of <i> Chisholm </i> neglecting momentum and geodetic pressure loss is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/fig_dp_twoPhaseOverall_4.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Chisholm,D.:</dt>
    <dd><b>Pressure gradients due to friction during the flow of evaporating two-phase mixtures in smooth tubes and channels</b>.
    Volume 16th of International Journal of Heat and Mass Transfer, 1973.</dd>
 <dt>Friedel,L.:</dt>
    <dd><b>IMPROVED FRICTION PRESSURE DROP CORRELATIONS FOR HORIZONTAL AND VERTICAL TWO PHASE PIPE FLOW</b>.3R International, Vol. 18, Issue 7, pp. 485-491, 1979.
 <dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 10th edition, 2006.</dd>
<dt>J.M. Jensen and H. Tummescheit:</dt>
    <dd><b>Moving boundary models for dynamic simulations of two-phase flows</b>.
    In Proceedings of the 2nd International Modelica Conference, pages 235?244, Oberpfaffenhofen, Germany, 2002. The Modelica Association.</dd>
<dt>Thome, J.R.:</dt>
    <dd><b>Engineering Data Book 3</b>.Swiss Federal Institute of Technology Lausanne (EPFL), 2009.</dd>
</dl>
</html>
"));
      end dp_twoPhaseOverall_DP;

      record dp_twoPhaseOverall_IN_con
        "Input record for function dp_twoPhaseOverall_DP"

        //choices
        Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseFrictionalPressureLoss
          frictionalPressureLoss=Dissipation.Utilities.Types.TwoPhaseFrictionalPressureLoss.Friedel
          "Choice of frictional pressure loss approach"
          annotation (Dialog(group="Choices"));
        Modelica.Fluid.Dissipation.Utilities.Types.Roughness
          voidFractionApproach =                                                  Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous
          "Choice of void fraction approach" annotation (Dialog(group="Choices"));

        Boolean momentumPressureLoss=false "Considering momentum pressure loss"
          annotation (Dialog(group="Choices"));
        Boolean massFlowRateCorrection=false
          "Consider heterogeneous mass flow rate correction" annotation (Dialog(group=
               "Choices", enable=if momentumPressureLoss then true else false));
        Boolean geodeticPressureLoss=false "Considering geodetic pressure loss"
          annotation (Dialog(group="Choices"));

        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_con;
        SI.Angle phi=0 "Tilt angle to horizontal"
          annotation (Dialog(group="Geometry"));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_DP\"> dp_twoPhaseOverall_DP </a>.
</html>"));

      end dp_twoPhaseOverall_IN_con;

      record dp_twoPhaseOverall_IN_var
        "Input record for function dp_twoPhaseOverall_DP"

        Real x_flow_end=0 "Mass flow rate quality at end of length"
          annotation (Dialog(group="Fluid properties"));
        Real x_flow_sta=0 "Mass flow rate quality at start of length"
          annotation (Dialog(group="Fluid properties"));
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_var(      final
            x_flow=(x_flow_end + x_flow_sta)/2);

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_DP\"> dp_twoPhaseOverall_DP </a>.
</html>"));

      end dp_twoPhaseOverall_IN_var;
    end StraightPipe;

    package Valve "Package for pressure loss calculation of valves"
    extends Modelica.Icons.VariantsPackage;

      function dp_severalGeometryOverall_DP
        "Pressure loss of valve | calculate pressure loss | several geometries | overall flow regime"

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Valve;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;
        import TYP = Modelica.Fluid.Dissipation.Utilities.Types;

        //icon
        extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Valve_d;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_con
          IN_con "Input record for function dp_severalGeometryOverall_DP"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_var
          IN_var "Input record for function dp_severalGeometryOverall_DP"
          annotation (Dialog(group="Variable inputs"));
        input SI.MassFlowRate m_flow "Mass flow rate"
          annotation (Dialog(group="Input"));

        //output variables
        output SI.Pressure DP "Pressure loss";

      protected
        type TYP1 =
            Modelica.Fluid.Dissipation.Utilities.Types.ValveCoefficient;
        type TYP2 = Modelica.Fluid.Dissipation.Utilities.Types.ValveGeometry;

        Real MIN=Modelica.Constants.eps;

        SI.Area Av=if IN_con.valveCoefficient == TYP1.AV then IN_con.Av else if
            IN_con.valveCoefficient == TYP1.KV then IN_con.Kv*27.7e-6 else if IN_con.valveCoefficient
             == TYP1.CV then IN_con.Cv*24e-6 else if IN_con.valveCoefficient == TYP1.OP then
                  IN_con.m_flow_nominal/max(MIN, IN_con.opening_nominal*(IN_con.rho_nominal
            *IN_con.dp_nominal)^0.5) else MIN
          "Av (metric) flow coefficient [Av]=m^2";

        TYP.PressureLossCoefficient zeta_bal=SMOOTH(
            0.05,
            0,
            IN_var.opening)*10^(-3.8397*IN_var.opening + 2.9449) + SMOOTH(
            0,
            0.05,
            IN_var.opening)*IN_con.zeta_TOT_max "Ball valves";
        TYP.PressureLossCoefficient zeta_dia=SMOOTH(
            0.05,
            0,
            IN_var.opening)*10^(2.2596*exp(-1.8816*IN_var.opening)) + SMOOTH(
            0,
            0.05,
            IN_var.opening)*IN_con.zeta_TOT_max "Diaphragm valves";
        TYP.PressureLossCoefficient zeta_but=SMOOTH(
            0.05,
            0,
            IN_var.opening)*619.81*exp(-7.3211*IN_var.opening) + SMOOTH(
            0,
            0.05,
            IN_var.opening)*IN_con.zeta_TOT_max "Butterfly valves";
        TYP.PressureLossCoefficient zeta_gat=SMOOTH(
            0.05,
            0,
            IN_var.opening)*51.45*exp(-6.046*IN_var.opening) + SMOOTH(
            0,
            0.05,
            IN_var.opening)*IN_con.zeta_TOT_max "Gate valves";
        TYP.PressureLossCoefficient zeta_slu=SMOOTH(
            0.05,
            0,
            IN_var.opening)*248.89*exp(-7.8265*IN_var.opening) + SMOOTH(
            0,
            0.05,
            IN_var.opening)*IN_con.zeta_TOT_max "Sluice valves";

        TYP.PressureLossCoefficient zeta_TOT=if IN_con.geometry == TYP2.Ball then
            zeta_bal else if IN_con.geometry == TYP2.Diaphragm then zeta_dia else if
            IN_con.geometry == TYP2.Butterfly then zeta_but else if IN_con.geometry
             == TYP2.Gate then zeta_gat else if IN_con.geometry == TYP2.Sluice then
            zeta_slu else 0 "Pressure loss coefficient of chosen valve";

        Real valveCharacteristic=(2/min(IN_con.zeta_TOT_max, max(MIN, max(IN_con.zeta_TOT_min,
            abs(zeta_TOT)))))^0.5
          "Valve characteristic considering opening of chosen valve";

        SI.MassFlowRate m_flow_small=valveCharacteristic*Av*(IN_var.rho)^0.5*(IN_con.dp_small)
            ^0.5 "Mass flow rate at linearisation";

        //Documentation

      algorithm
        DP := 1/((valveCharacteristic*Av)^2*IN_var.rho)*
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                m_flow,
                m_flow_small,
                2);

        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(m_flow=FD.dp_severalGeometryOverall_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of pressure loss for a valve with different geometries at overall flow regime for incompressible and single-phase fluid flow in dependence of its opening.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this function is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW\">dp_severalGeometryOverall_MFLOW</a> is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used inside of the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> developed fluid flow </b>
 </li>
 <li>
      <b> ball valve </b>
 </li>
 <li>
      <b> diaphragm valve </b>
 </li>
 <li>
      <b> butterfly valve </b>
 </li>
 <li>
      <b> gate valve </b>
 </li>
 <li>
      <b> sluice valve </b>
 </li>
</ul>

<p>
<h4><font color=\"#EF9B13\">Geometry</font></h4>
</p>
Wide variations in valve geometry are possible and a manufacturer will not necessarily maintain geometric similarity between valves of the same type but of different size. Here pressure loss can be estimated for the following types of a valve:
<ul>
 <li>
      <b> ball valve </b>
 </li>
 <li>
      <b> diaphragm valve </b>
 </li>
 <li>
      <b> butterfly valve </b>
 </li>
 <li>
      <b> gate valve </b>
 </li>
 <li>
      <b> sluice valve </b>
 </li>
</ul>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The pressure loss <b> dp </b> for valves is determined by:
<p>
<pre>
    dp = (zeta_TOT/2) * rho * velocity^2
    dp = 1/(valveCharacteristic^2)* rho * velocity^2
    dp = 1/(valveCharacteristic^2 * Av^2 * rho) *(m_flow)^2
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> rho                        </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> Av                         </b></td><td> as (metric) flow coefficient (cross sectional area) [m^2],</td></tr>
<tr><td><b> m_flow                     </b></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><b> valveCharacteristic        </b></td><td> as coefficient of a valve in dependence of its opening [-],</td></tr>
<tr><td><b> velocity                   </b></td><td> as mean velocity [m/s],</td></tr>
<tr><td><b> zeta_TOT                   </b></td><td> as pressure loss coefficient [-].</td></tr>
</table>
</p>

<p>
The <b>valveCharacteristic</b> is determined out of a correlation for the pressure loss coefficient (<b>zeta_TOT</b>) in dependence of its opening. The reason for introducing an additional variable
<b>valveCharacteristic</b> is a different definition of the following pressure loss correlations of valves.
</p>

<ul>
  <li> Using coefficient Av with [Av]=m^2 and [V_flow]=m^3/s, [dp]=Pa:
     <br>
     <pre>
      V_flow = Av * (dp/rho)^0.5
     </pre>
  <li> Using coefficient Kv with [Kv]=m^3/(h*bar^0.5) and [V_flow]=m^3/h, [dp]=bar :
     <br>
     <pre>
      V_flow = Kv * [dp/(rho/rho0)]^0.5
     </pre>
  <li> Using coefficient Cv with [Cv]=USG/(min*psi^0.5) and [V_flow]=USG/min, [dp]=psi :
     <br>
     <pre>
      V_flow = Cv * [dp/(rho/rho0)]^0.5
     </pre>
</ul>
The different flow coefficients <b>Kv and Cv</b> are often given in manufacturer data instead of <b>Av</b> to describe pressure loss of valves. Here a geometry of a valve can be chosen and the specific manufacturer data for the flow coefficients can be used. Then values for given <b>Kv and Cv</b> are converted into <b>Av</b> used in pressure loss calculation
(see <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">User's Guide</a> for detailed discussion).

The pressure loss coefficient (<b>zeta_TOT</b>) for several geometries of valves is calculated according to <i>[Miller 1978, sec. 14.6, p. 270ff]</i> :
<ul>
  <li> <b>Ball valve</b>:
     <br>
     <pre>
      zeta_TOT = 10^(-3.8397 * opening + 2.9449)
     </pre>
  <li> <b>Diaphragm valve</b>
      <br>
     <pre>
      zeta_TOT = 10^[2.2596*exp(-1.8816 * opening)]
     </pre>
 <li> <b>Butterfly valve</b>
      <br>
     <pre>
     zeta_TOT = 619.81*exp(-7.3211*opening)
     </pre>
 <li> <b>Gate valve</b>
      <br>
     <pre>
     zeta_TOT = 51.45*exp(-6.046*opening)
     </pre>
 <li> <b>Sluice valve</b>
      <br>
     <pre>
     zeta_TOT = 248.89*exp(-7.8265*opening)
     </pre>
</ul>
<p>
with
</p>
<p>
<table>
<tr><td><b> opening       </b></td><td> as amount of opening of a valve from 0% to 100% [-],</td></tr>
<tr><td><b> zeta_TOT      </b></td><td> as pressure loss coefficient [-].</td></tr>
</table>
</p>

<p>
Note that the pressure loss coefficients for an overall fluid flow are obtained out of the turbulent regime.
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The pressure loss coefficient (<b>zeta_TOT</b>) of a valve with different geometries are shown in dependence of the <b>opening</b> in the figure below.

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/valve/fig_valve_dp_severalGeometryOverall_zetaVsOpening.png\">

<p>
Note that the pressure loss coefficients (<b>zeta_TOT</b>) are numerically optimised for very small openings (opening &le; 5%). At openings smaller than 5% the pressure loss coefficient is smoothly set
to a maximum value (<b>zeta_TOT_max</b>) to be adjusted as parameter. Therefore a very small leakage mass flow rate can be adjusted for a given pressure difference at almost closed valves. A very small
leakage mass flow rate can often be neglected in system simulation with valves, whereas the numerical behaviour of the simulation is improved.
</p>
<p>
The pressure loss of different valves at a constant opening of 50% in dependence of mass flow rate is shown in the figure below.
<p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/valve/fig_valve_dp_severalGeometryOverall_DPvsMFLOW.png\">


<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Miller,D.S.:</dt>
    <dd><b>Internal flow systems</b>.
    Volume 5th of BHRA Fluid Engineering Series.BHRA Fluid Engineering, 1978.
</dl>
</html>
"),                 Documentation(info="<html>
<p>
Calculation of pressure loss for a valve with different geometries at overall flow regime for incompressible and single-phase fluid flow in dependence of its opening.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this function is numerically best used for the <b> incompressible case </b>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW\">dp_severalGeometryOverall_MFLOW</a> is numerically best used for the <b> compressible case </b> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used inside of the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> developed fluid flow </b>
 </li>
 <li>
      <b> ball valve or diaphragm valve </b>
 </li>
</ul>

<p>
<h4><font color=\"#EF9B13\">Geometry</font></h4>
</p>
Wide variations in valve geometry are possible and a manufacturer will not necessarily maintain geometric similarity between valves of the same type but of different size. Here pressure loss can be calculated for a ball valve or a diaphragm valve as geometry.

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The pressure loss <b> dp </b> for valves is determined by:
<p>
<pre>
    dp = (zeta_TOT/2) * rho * velocity^2
    dp = 1/(valveCharacteristic^2)* rho * velocity^2
    dp = 1/(valveCharacteristic^2 * Av^2 * rho) *(m_flow)^2
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> rho                        </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> Av                         </b></td><td> as (metric) flow coefficient (cross sectional area) [m^2],</td></tr>
<tr><td><b> m_flow                     </b></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><b> valveCharacteristic        </b></td><td> as coefficient of a valve in dependence of its opening [-],</td></tr>
<tr><td><b> velocity                   </b></td><td> as mean velocity [m/s],</td></tr>
<tr><td><b> zeta_TOT                   </b></td><td> as pressure loss coefficient [-].</td></tr>
</table>
</p>

<p>
The <b>valveCharacteristic</b> is determined out of a correlation for the pressure loss coefficient (<b>zeta_TOT</b>) in dependence of its opening. The reason for introducing an additional variable
<b>valveCharacteristic</b> is a different definition of the following pressure loss correlations of valves.
</p>

<ul>
  <li> Using coefficient Av with [Av]=m^2 and [V_flow]=m^3/s, [dp]=Pa:
     <br>
     <pre>
      V_flow = Av * (dp/rho)^0.5
     </pre>
  <li> Using coefficient Kv with [Kv]=m^3/(h*bar^0.5) and [V_flow]=m^3/h, [dp]=bar :
     <br>
     <pre>
      V_flow = Kv * [dp/(rho/rho0)]^0.5
     </pre>
  <li> Using coefficient Cv with [Cv]=USG/(min*psi^0.5) and [V_flow]=USG/min, [dp]=psi :
     <br>
     <pre>
      V_flow = Cv * [dp/(rho/rho0)]^0.5
     </pre>
</ul>
The different flow coefficients <b>Kv and Cv</b> are often given in manufacturer data instead of <b>Av</b> to describe pressure loss of valves. Here a geometry of a valve can be chosen and the specific manufacturer data for the flow coefficients can be used. Then values for given <b>Kv and Cv</b> are converted into <b>Av</b> used in pressure loss calculation
(see <a href=\"modelica://Modelica_Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">User's Guide</a> for detailed discussion).

The pressure loss coefficient (<b>zeta_TOT</b>) for several geometries of valves is calculated according to <i>[Miller 1978, sec. 14.6, p. 270ff]</i> :
<ul>
  <li> <b>Ball valve</b>:
     <br>
     <pre>
      zeta_TOT = 10^(-3.8397 * opening + 2.9449)
     </pre>
  <li> <b>Diaphragm valve</b>
      <br>
     <pre>
      zeta_TOT = 10^[2.2596*exp(-1.8816 * opening)]
     </pre>
</ul>
<p>
with
</p>
<p>
<table>
<tr><td><b> opening       </b></td><td> as amount of opening of a valve from 0% to 100% [-],</td></tr>
<tr><td><b> zeta_TOT      </b></td><td> as pressure loss coefficient [-].</td></tr>
</table>
</p>

<p>
Note that the pressure loss coefficients for an overall fluid flow are obtained out of the turbulent regime.
</p>

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The pressure loss coefficient (<b>zeta_TOT</b>) of a valve with different geometries are shown in dependence of the <b>opening</b> in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/valve/fig_valve_dp_severalGeometryOverall_zetaVsOpening.png\">

<p>
Note that the pressure loss coefficients (<b>zeta_TOT</b>) are numerically optimised for very small openings (opening &le; 5%). At openings smaller than 5% the pressure loss coefficient is smoothly set
to a maximum value (<b>zeta_TOT_max</b>) to be adjusted as parameter. Therefore a very small leakage mass flow rate can be adjusted for a given pressure difference at almost closed valves. A very small
leakage mass flow rate can often be neglected in system simulation with valves, whereas the numerical behaviour of the simulation is improved.
</p>
<p>
The pressure loss of different valves at a constant opening of 50% in dependence of mass flow rate is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/valve/fig_valve_dp_severalGeometryOverall_DPvsMFLOW.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dt>Miller,D.S.:</dt>
    <dd><b>Internal flow systems</b>.
    Volume 5th of BHRA Fluid Engineering Series.BHRA Fluid Engineering, 1978.
</dl>
</html>
"));
      end dp_severalGeometryOverall_DP;

      function dp_severalGeometryOverall_MFLOW
        "Pressure loss of valve | calculate mass flow rate | several geometries | overall flow regime"

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Valve;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;
        import TYP = Modelica.Fluid.Dissipation.Utilities.Types;

        //icon
        extends Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.Valve_d;

        //input records
        input
          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_con
          IN_con "Input record for function dp_severalGeometryOverall_MFLOW"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_var
          IN_var "Input record for function dp_severalGeometryOverall_MFLOW"
          annotation (Dialog(group="Variable inputs"));
        input SI.Pressure dp "Pressure loss" annotation (Dialog(group="Input"));

        //output variables
        output SI.MassFlowRate M_FLOW "Mass flow rate";

      protected
        type TYP1 =
            Modelica.Fluid.Dissipation.Utilities.Types.ValveCoefficient;
        type TYP2 = Modelica.Fluid.Dissipation.Utilities.Types.ValveGeometry;

        Real MIN=Modelica.Constants.eps;

        SI.Area Av=if IN_con.valveCoefficient == TYP1.AV then IN_con.Av else if
            IN_con.valveCoefficient == TYP1.KV then IN_con.Kv*27.7e-6 else if IN_con.valveCoefficient
             == TYP1.CV then IN_con.Cv*24e-6 else if IN_con.valveCoefficient == TYP1.OP then
                  IN_con.m_flow_nominal/max(MIN, IN_con.opening_nominal*(IN_con.rho_nominal
            *IN_con.dp_nominal)^0.5) else MIN
          "Av (metric) flow coefficient [Av]=m^2";

        TYP.PressureLossCoefficient zeta_bal=SMOOTH(
            0.05,
            0,
            IN_var.opening)*10^(-3.8397*IN_var.opening + 2.9449) + SMOOTH(
            0,
            0.05,
            IN_var.opening)*IN_con.zeta_TOT_max "Ball valves";
        TYP.PressureLossCoefficient zeta_dia=SMOOTH(
            0.05,
            0,
            IN_var.opening)*10^(2.2596*exp(-1.8816*IN_var.opening)) + SMOOTH(
            0,
            0.05,
            IN_var.opening)*IN_con.zeta_TOT_max "Diaphragm valves";
        TYP.PressureLossCoefficient zeta_but=SMOOTH(
            0.05,
            0,
            IN_var.opening)*619.81*exp(-7.3211*IN_var.opening) + SMOOTH(
            0,
            0.05,
            IN_var.opening)*IN_con.zeta_TOT_max "Butterfly valves";
        TYP.PressureLossCoefficient zeta_gat=SMOOTH(
            0.05,
            0,
            IN_var.opening)*51.45*exp(-6.046*IN_var.opening) + SMOOTH(
            0,
            0.05,
            IN_var.opening)*IN_con.zeta_TOT_max "Gate valves";
        TYP.PressureLossCoefficient zeta_slu=SMOOTH(
            0.05,
            0,
            IN_var.opening)*248.89*exp(-7.8265*IN_var.opening) + SMOOTH(
            0,
            0.05,
            IN_var.opening)*IN_con.zeta_TOT_max "Sluice valves";

        TYP.PressureLossCoefficient zeta_TOT=if IN_con.geometry == TYP2.Ball then
            zeta_bal else if IN_con.geometry == TYP2.Diaphragm then zeta_dia else if
            IN_con.geometry == TYP2.Butterfly then zeta_but else if IN_con.geometry
             == TYP2.Gate then zeta_gat else if IN_con.geometry == TYP2.Sluice then
            zeta_slu else 0 "Pressure loss coefficient of chosen valve";

        Real valveCharacteristic=(2/min(IN_con.zeta_TOT_max, max(MIN, max(IN_con.zeta_TOT_min,
            abs(zeta_TOT)))))^0.5
          "Valve characteristic considering opening of chosen valve";

        //Documentation

      algorithm
        M_FLOW := valveCharacteristic*Av*(IN_var.rho)^0.5*
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                dp,
                IN_con.dp_small,
                0.5);
        annotation (smoothOrder(__Dymola_normallyConstant=IN_con) = 2,
                    inverse(dp=FD.dp_severalGeometryOverall_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of pressure loss for a valve with different geometries at overall flow regime for incompressible and single-phase fluid flow in dependence of its opening.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> compressible case </b>, where the pressure loss (dp) is known (out of pressures as state variable) in the used model and the corresponding mass flow rate (M_FLOW) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP\">dp_severalGeometryOverall_DP</a> is numerically best used for the <b> incompressible case </b> if the mass flow rate (m_flow) is known (as state variable) and the pressure loss (DP) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used inside of the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> developed fluid flow </b>
 </li>
 <li>
      <b> ball valve </b>
 </li>
 <li>
      <b> diaphragm valve </b>
 </li>
 <li>
      <b> butterfly valve </b>
 </li>
 <li>
      <b> gate valve </b>
 </li>
 <li>
      <b> sluice valve </b>
 </li>
</ul>

<p>
<h4><font color=\"#EF9B13\">Geometry</font></h4>
</p>
Wide variations in valve geometry are possible and a manufacturer will not necessarily maintain geometric similarity between valves of the same type but of different size. Here pressure loss can be estimated for the following types of a valve:
<ul>
 <li>
      <b> ball valve </b>
 </li>
 <li>
      <b> diaphragm valve </b>
 </li>
 <li>
      <b> butterfly valve </b>
 </li>
 <li>
      <b> gate valve </b>
 </li>
 <li>
      <b> sluice valve </b>
 </li>
</ul>

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mass flow rate <b> m_flow </b> for valves out of pressure loss is determined by:
<p>
<pre>
    m_flow = [rho * dp * Av^2 / (zeta_TOT/2]^0.5
    m_flow = (2/zeta_TOT)^0.5 * Av * (rho * dp)^0.5
    m_flow = valveCharacteristic * Av * (rho * dp)^0.5
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> rho                        </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> Av                         </b></td><td> as (metric) flow coefficient (cross sectional area) [m^2],</td></tr>
<tr><td><b> m_flow                     </b></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><b> valveCharacteristic        </b></td><td> as coefficient of a valve in dependence of its opening [-],</td></tr>
<tr><td><b> velocity                   </b></td><td> as mean velocity [m/s],</td></tr>
<tr><td><b> zeta_TOT                   </b></td><td> as pressure loss coefficient [-].</td></tr>
</table>
</p>

<p>
The <b>valveCharacteristic</b> is determined out of a correlation for the pressure loss coefficient (<b>zeta_TOT</b>) in dependence of its opening. The reason for introducing an additional variable
<b>valveCharacteristic</b> is a different definition of the following pressure loss correlations of valves.
</p>

The pressure loss calculation for valves of several geometries is further documented <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP\">dp_severalGeometryOverall_DP</a>.

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The pressure loss coefficient (<b>zeta_TOT</b>) of a valve with different geometries are shown in dependence of the <b>opening</b> in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/valve/fig_valve_dp_severalGeometryOverall_zetaVsOpening.png\">

<p>
Note that the pressure loss coefficients (<b>zeta_TOT</b>) are numerically optimised for very small openings (opening &le; 5%). At openings smaller than 5% the pressure loss coefficient is smoothly set
to a maximum value (<b>zeta_TOT_max</b>) to be adjusted as parameter. Therefore a very small leakage mass flow rate can be adjusted for a given pressure difference at almost closed valves. A very small
leakage mass flow rate can often be neglected in system simulation with valves, whereas the numerical behaviour of the simulation is improved.
</p>
<p>
The mass flow rate of different valves at a constant opening of 50% in dependence of pressure loss is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/valve/fig_valve_dp_severalGeometryOverall_MFLOWvsDP.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Miller,D.S.:</dt>
    <dd><b>Internal flow systems</b>.
    Volume 5th of BHRA Fluid Engineering Series.BHRA Fluid Engineering, 1978.
</dl>
</html>
"),                 Documentation(info="<html>
<p>
Calculation of pressure loss for a valve with different geometries at overall flow regime for incompressible and single-phase fluid flow in dependence of its opening.
</p>

<p>
This function can be used to calculate both the pressure loss at known mass flow rate <b> or </b> mass flow rate at known pressure loss within one function in dependence of the known
variable (dp or m_flow).
</p>

<p>
Generally this  function is numerically best used for the <b> compressible case </b>, where the pressure loss (dp) is known (out of pressures as state variable) in the used model and the corresponding mass flow rate (M_FLOW) has to be calculated. On the other hand the  function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP\">dp_severalGeometryOverall_DP</a> is numerically best used for the <b> incompressible case </b> if the mass flow rate (m_flow) is known (as state variable) and the pressure loss (DP) has to be calculated.
</p>

<h4><font color=\"#EF9B13\">Restriction</font></h4>
This function shall be used inside of the restricted limits according to the referenced literature.
<ul>
 <li>
      <b> developed fluid flow </b>
 </li>
 <li>
      <b> ball valve or diaphragm valve </b>
 </li>
</ul>

<p>
<h4><font color=\"#EF9B13\">Geometry</font></h4>
</p>
Wide variations in valve geometry are possible and a manufacturer will not necessarily maintain geometric similarity between valves of the same type but of different size. Here pressure loss can be calculated for a ball valve or a diaphragm valve as geometry.

<h4><font color=\"#EF9B13\">Calculation</font></h4>
The mass flow rate <b> m_flow </b> for valves out of pressure loss is determined by:
<p>
<pre>
    m_flow = [rho * dp * Av^2 / (zeta_TOT/2]^0.5
    m_flow = (2/zeta_TOT)^0.5 * Av * (rho * dp)^0.5
    m_flow = valveCharacteristic * Av * (rho * dp)^0.5
</pre>
</p>

<p>
with
</p>

<p>
<table>
<tr><td><b> rho                        </b></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><b> Av                         </b></td><td> as (metric) flow coefficient (cross sectional area) [m^2],</td></tr>
<tr><td><b> m_flow                     </b></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><b> valveCharacteristic        </b></td><td> as coefficient of a valve in dependence of its opening [-],</td></tr>
<tr><td><b> velocity                   </b></td><td> as mean velocity [m/s],</td></tr>
<tr><td><b> zeta_TOT                   </b></td><td> as pressure loss coefficient [-].</td></tr>
</table>
</p>

<p>
The <b>valveCharacteristic</b> is determined out of a correlation for the pressure loss coefficient (<b>zeta_TOT</b>) in dependence of its opening. The reason for introducing an additional variable
<b>valveCharacteristic</b> is a different definition of the following pressure loss correlations of valves.
</p>

The pressure loss calculation for valves of several geometries is further documented <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP\">dp_severalGeometryOverall_DP</a>.

<h4><font color=\"#EF9B13\">Verification</font></h4>
<p>
The pressure loss coefficient (<b>zeta_TOT</b>) of a valve with different geometries are shown in dependence of the <b>opening</b> in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/valve/fig_valve_dp_severalGeometryOverall_zetaVsOpening.png\">

<p>
Note that the pressure loss coefficients (<b>zeta_TOT</b>) are numerically optimised for very small openings (opening &le; 5%). At openings smaller than 5% the pressure loss coefficient is smoothly set
to a maximum value (<b>zeta_TOT_max</b>) to be adjusted as parameter. Therefore a very small leakage mass flow rate can be adjusted for a given pressure difference at almost closed valves. A very small
leakage mass flow rate can often be neglected in system simulation with valves, whereas the numerical behaviour of the simulation is improved.
</p>
<p>
The mass flow rate of different valves at a constant opening of 50% in dependence of pressure loss is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/valve/fig_valve_dp_severalGeometryOverall_MFLOWvsDP.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dt>Miller,D.S.:</dt>
    <dd><b>Internal flow systems</b>.
    Volume 5th of BHRA Fluid Engineering Series.BHRA Fluid Engineering, 1978.
</dl>
</html>
"));
      end dp_severalGeometryOverall_MFLOW;

      record dp_severalGeometryOverall_IN_con
        "Input record for function dp_severalGeometryOverall, dp_severalGeometryOverall_DP and dp_severalGeometryOverall_MFLOW"

        extends Modelica.Icons.Record;

        Modelica.Fluid.Dissipation.Utilities.Types.ValveGeometry geometry=Dissipation.Utilities.Types.ValveGeometry.Ball
          "Choice of geometry for valve" annotation (Dialog(group="Valve"));
        Modelica.Fluid.Dissipation.Utilities.Types.ValveCoefficient
          valveCoefficient=
            Modelica.Fluid.Dissipation.Utilities.Types.ValveCoefficient.AV
          "Choice of valve coefficient" annotation (Dialog(group="Valve"));

        //valve variables
        Real Av=PI*0.1^2/4 "Av (metric) flow coefficient [Av]=m^2" annotation (Dialog(
              group="Valve", enable=if valveCoefficient == 1 then true else false));
        Real Kv=Av/27.7e-6 "Kv (metric) flow coefficient [Kv]=m^3/h" annotation (
            Dialog(group="Valve", enable=if valveCoefficient == 2 then true else
                false));
        Real Cv=Av/24.6e-6 "Cv (US) flow coefficient [Cv]=USG/min" annotation (Dialog(
              group="Valve", enable=if valveCoefficient == 3 then true else false));
        SI.Pressure dp_nominal=1e3 "Nominal pressure loss" annotation (Dialog(group=
                "Valve", enable=if valveCoefficient == 4 then true else false));
        SI.MassFlowRate m_flow_nominal=opening_nominal*Av*(rho_nominal*dp_nominal)^
            0.5 "Nominal mass flow rate" annotation (Dialog(group="Valve", enable=if
                valveCoefficient == 4 then true else false));
        SI.Density rho_nominal=1e3 "Nominal inlet density" annotation (Dialog(group=
                "Valve", enable=if valveCoefficient == 4 then true else false));
        Real opening_nominal=0.5 "Nominal opening" annotation (Dialog(group="Valve",
              enable=if valveCoefficient == 4 then true else false));
        Real zeta_TOT_min=1e-3
          "Minimal pressure loss coefficient at full opening"
          annotation (Dialog(group="Valve"));
        Real zeta_TOT_max=1e8
          "Maximum pressure loss coefficient at closed opening"
          annotation (Dialog(group="Valve"));

        //numerical aspects
        SI.Pressure dp_small=0.01*dp_nominal
          "Linearisation for a pressure loss smaller then dp_small"
          annotation (Dialog(group="Linearisation"));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall\"> dp_severalGeometryOverall </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP\"> dp_severalGeometryOverall_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW\"> dp_severalGeometryOverall_MFLOW </a>.
</html>"));
      end dp_severalGeometryOverall_IN_con;

      record dp_severalGeometryOverall_IN_var
        "Input record for function dp_severalGeometryOverall, dp_severalGeometryOverall_DP and dp_severalGeometryOverall_MFLOW"

        extends Modelica.Icons.Record;

        //valve variables
        Real opening=1 "Opening of valve | 0==closed and 1== fully openend"
          annotation (Dialog(group="Valve"));

        //fluid property variables
        SI.DynamicViscosity eta=1e-3 "Dynamic viscosity of fluid"
          annotation (Dialog(group="Fluid properties"));
        SI.Density rho=1e3 "Density of fluid"
          annotation (Dialog(group="Fluid properties"));

        annotation (Documentation(info="<html>
This record is used as <b> input record </b> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall\"> dp_severalGeometryOverall </a>,
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP\"> dp_severalGeometryOverall_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW\"> dp_severalGeometryOverall_MFLOW </a>.
</html>"));
      end dp_severalGeometryOverall_IN_var;
    end Valve;
  end PressureLoss;

  package Utilities "Package for utilities (should not be used directly)"
  extends Modelica.Icons.Package;
    package Functions "Package for utility functions"
    extends Modelica.Icons.Package;

      package PressureLoss "Package for utility pressure loss functions"
        extends Modelica.Icons.Package;

        package TwoPhase
          "Package with utility functions to compute two phase pressure loss characteristics"
          extends Modelica.Icons.Package;

          function dp_twoPhaseChisholm_DP
            "Frictional pressure loss of straight pipe for two phase flow according to Chisholm correlation | calculate pressure loss | overall flow regime"

            //SOURCE_1: Chisholm,D.:PRESSURE GRADIENTS DUE TO FRICTION DURING THE FLOW OF EVAPORATING TWO-PHASE MIXTURES IN SMOOTH TUBES AND CHANNELS, Int. J. Heat Mass Transfer, Vol. 16, pp. 347-358, Pergamon Press 1973

            //icon
            extends
              Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.StraightPipe_d;

            //records
            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_con
              IN_con
              annotation (Dialog(group="Constant inputs"));
            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_var
              IN_var
              annotation (Dialog(group="Variable inputs"));
            input SI.MassFlowRate m_flow "Mass flow rate"
              annotation (Dialog(group="Input"));

            output SI.Pressure DP "Output for function dp_twoPhaseChisholm_DP";

          protected
            Real MIN=Modelica.Constants.eps;

            Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con
              IN_con_1ph(
              final roughness=Dissipation.Utilities.Types.Roughness.Neglected,
              final d_hyd=4*abs(IN_con.A_cross)/max(MIN, abs(IN_con.perimeter)),
              final K=0,
              final L=abs(IN_con.length));

            Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var
              IN_var_1ph(
                final eta=IN_var.eta_l, final rho=IN_var.rho_l);

          algorithm
            DP := Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_DP(
                        IN_con_1ph,
                        IN_var_1ph,
                        m_flow)*(
              Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.TwoPhaseMultiplierChisholm(
                        IN_con,
                        IN_var,
                        m_flow));

          end dp_twoPhaseChisholm_DP;

          function dp_twoPhaseFriedel_DP
            "Frictional pressure loss of straight pipe for two phase flow according to Friedel correlation | calculate pressure loss| overall flow regime"

            //SOURCE_1: Friedel,L.:IMPROVED FRICTION PRESSURE DROP CORRELATIONS FOR HORIZONTAL AND VERTICAL TWO PHASE PIPE FLOW, 3R International, Vol. 18, Issue 7, pp. 485-491, 1979
            //SOURCE_2: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.

            //icon
            extends
              Modelica.Fluid.Dissipation.Utilities.Icons.PressureLoss.StraightPipe_d;

            import SMOOTH =
              Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;
            import SMOOTH2 =
              Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower;

            //records
            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_con
              IN_con
              annotation (Dialog(group="Constant inputs"));
            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_var
              IN_var
              annotation (Dialog(group="Variable inputs"));
            input SI.MassFlowRate m_flow "Mass flow rate"
              annotation (Dialog(group="Input"));

            output SI.Pressure DP "Output for function dp_twoPhaseFriedel_DP";

          protected
            Real MIN=Modelica.Constants.eps;

            SI.Area A_cross=max(MIN, IN_con.A_cross) "Cross sectional area";
            SI.Diameter d_hyd=max(MIN, 4*A_cross/max(MIN, IN_con.perimeter))
              "Hydraulic diameter";

            Real mdot_A=abs(m_flow)/A_cross "Mass flux";
            SI.ReynoldsNumber Re_liq=max(1, mdot_A*d_hyd/max(MIN, IN_var.eta_l))
              "Reynolds number assuming (total) mass flux flowing as liquid";
            SI.ReynoldsNumber Re_lam_leave=1055
              "Maximum Reynolds number for laminar regime (1055)";
            SI.ReynoldsNumber Re_turb=1100
              "Minimum Reynolds number for turbulent regime (1100)";
            SI.ReynoldsNumber Re_smooth=m_flow/A_cross*d_hyd/max(MIN, abs(IN_var.eta_l))
              "Reynolds number for smoothing";
            TYP.DarcyFrictionFactor lambda_FRI_lam=64/Re_liq
              "Darcy friction factor for laminar regime";
            TYP.DarcyFrictionFactor lambda_FRI_turb=(0.86859*Modelica.Math.log(max(1, (
                Re_liq/max(MIN, (1.964*Modelica.Math.log(Re_liq) - 3.8215))))))^(-2)
              "Darcy friction factor for turbulent regime";
            TYP.DarcyFrictionFactor lambda_FRI=lambda_FRI_lam*SMOOTH(
                Re_lam_leave,
                Re_turb,
                Re_liq) + lambda_FRI_turb*SMOOTH(
                Re_turb,
                Re_lam_leave,
                Re_liq);
            TYP.PressureLossCoefficient zeta_FRI=lambda_FRI*IN_con.length/d_hyd
              "Pressure loss coefficient";
            SI.Pressure DP_liq=zeta_FRI*mdot_A^2/(2*max(MIN, IN_var.rho_l))
              "Frictional pressure loss assuming (total) mass flux flowing as liquid";

          algorithm
            DP := SMOOTH2(
                        Re_smooth,
                        1,
                        0)*DP_liq*(
              Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.TwoPhaseMultiplierFriedel(
                        IN_con,
                        IN_var,
                        m_flow));

          end dp_twoPhaseFriedel_DP;

          function dp_twoPhaseGeodetic_DP
            "Geodetic pressure loss of straight pipe for two phase flow | calculate pressure loss"

            //SOURCE_1: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.

            import PI = Modelica.Constants.pi;

            input
              Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach
              voidFractionApproach=Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous
              "Choice of void fraction approach";

            input Boolean crossSectionalAveraged=true
              "true == cross sectional averaged void fraction | false == volumetric"
              annotation (Dialog);

            //geometry
            input SI.Length length=1 "Length in fluid flow direction"
              annotation (Dialog(group="Geometry"));
            input SI.Angle phi=0 "Tilt angle to horizontal"
              annotation (Dialog(group="Geometry"));

            //fluid properties
            input SI.Density rho_g(min=Modelica.Constants.eps) = 1.1220
              "Density of gaseous phase" annotation (Dialog(group="Fluid properties"));
            input SI.Density rho_l(min=Modelica.Constants.eps) = 943.11
              "Density of liquid phase" annotation (Dialog(group="Fluid properties"));
            input Real x_flow(
              min=0,
              max=1) = 0 "Mass flow rate quality"
              annotation (Dialog(group="Fluid properties"));

            output SI.Pressure DP_geo "Geodetic pressure loss";

          protected
            Real xflow=min(1, max(0, abs(x_flow))) "Mass flow rate quality";
            Real eps=
                Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.VoidFraction(
                voidFractionApproach,
                crossSectionalAveraged,
                rho_g,
                rho_l,
                xflow) "Void fraction";

          algorithm
            //SOURCE_1: p.Lbb 1, eq. 4: Considering geodetic pressure loss assuming constant void fraction for flow length
            DP_geo := (eps*rho_g + (1 - eps)*rho_l)*9.81*length*sin(min(PI/2, max(0, abs(
              phi))));

          end dp_twoPhaseGeodetic_DP;

          function dp_twoPhaseMomentum_DP
            "Momentum pressure loss of straight pipe for two phase flow | calculate pressure loss"

            //SOURCE_1: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.
            //SOURCE_2: Thome, J.R., Engineering Data Book 3, Swiss Federal Institute of Technology Lausanne (EPFL), 2009.
            //SOURCE 3: J.M. Jensen and H. Tummescheit. Moving boundary models for dynamic simulations of two-phase flows. In Proceedings of the 2nd International Modelica Conference, pp. 235-244, Oberpfaffenhofen, Germany, 2002. The Modelica Association.

            import PI = Modelica.Constants.pi;
            import MIN = Modelica.Constants.eps;
            import SMOOTH =
              Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower;

            //choices
            input Modelica.Fluid.Dissipation.Utilities.Types.Roughness
              voidFractionApproach=
                Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous
              "Choice of void fraction approach" annotation (Dialog(group="Choices"));

            //SOURCE_3: p.52, eq. 4.6: heterogenous effects on momentum pressure loss considered through corrected mass flow rate
            input Boolean massFlowRateCorrection=false
              "Consider heterogeneous mass flow rate correction"
              annotation (Dialog(group="Choices"));

            //geometry
            input Real A_cross(min=Modelica.Constants.eps) = PI*0.1^2/4
              "Cross sectional area" annotation (Dialog(group="Geometry"));
            input SI.Length perimeter(min=Modelica.Constants.eps) = PI*0.1
              "Perimeter"
              annotation (Dialog(group="Geometry"));

            //fluid properties
            input SI.Density rho_g(min=Modelica.Constants.eps) = 1.1220
              "Density of gas"
              annotation (Dialog(group="Fluid properties"));
            input SI.Density rho_l(min=Modelica.Constants.eps) = 943.11
              "Density of liquid" annotation (Dialog(group="Fluid properties"));
            input Real x_flow_end(
              min=0,
              max=1) = 0 "Mass flow rate quality at end of length"
              annotation (Dialog(group="Fluid properties"));
            input Real x_flow_sta(
              min=0,
              max=1) = 0 "Mass flow rate quality at start of length"
              annotation (Dialog(group="Fluid properties"));

            input SI.MassFlowRate m_flow "Mass flow rate"
              annotation (Dialog(group="Input"));

            output SI.Pressure DP_mom "Momentum pressure loss";

          protected
            Real MIN=Modelica.Constants.eps;

            SI.Area Across=max(MIN, A_cross) "Cross sectional area";
            SI.Diameter d_hyd=max(MIN, 4*A_cross/max(MIN, perimeter))
              "Hydraulic diameter";

            Real mdot_A=abs(m_flow)/Across "Mass flux";
            Real xflowEnd=min(1, max(0, abs(x_flow_end)))
              "Mass flow rate quality at end of length";
            Real xflowSta=min(1, max(0, abs(x_flow_sta)))
              "Mass flow rate quality at start of length";
            Real xflowMean=(xflowEnd + xflowSta)/2
              "Mean mass flow rate quality over length";

            Real delta_xflow=xflowEnd - xflowSta
              "Difference of mass flow rate quality between end and start of length (pos >> evaporation, neg >> condensation";

            //SOURCE_2: Considering void fraction approaches
            Real eps_end=
                Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.VoidFraction(
                voidFractionApproach,
                true,
                rho_g,
                rho_l,
                xflowEnd) "Void fraction at end of length";
            Real eps_sta=
                Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.VoidFraction(
                voidFractionApproach,
                true,
                rho_g,
                rho_l,
                xflowSta) "Void fraction at start of length";

            //SOURCE_2: p.17-6, eq. 17.3.3: Considering mean two phase density at end and start of length
            SI.Density rho_end=
                Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.TwoPhaseDensity(
                voidFractionApproach,
                massFlowRateCorrection,
                rho_g,
                rho_l,
                eps_end,
                xflowEnd) "Mean two phase density at end of lenght";
            SI.Density rho_sta=
                Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.TwoPhaseDensity(
                voidFractionApproach,
                massFlowRateCorrection,
                rho_g,
                rho_l,
                eps_sta,
                xflowSta) "Mean two phase density at start of lenght";

            SI.Velocity meanVelEnd=abs(m_flow)/max(MIN, rho_end*A_cross)
              "Mean velocity of two phase flow at end of length";
            SI.Velocity meanVelSta=abs(m_flow)/max(MIN, rho_sta*A_cross)
              "Mean velocity of two phase flow at start of length";

            //SOURCE 3: p.15, eq. 2.26: Considering velocity difference for heterogeneous approach using slip ratio
            Real SR=Dissipation.Utilities.Functions.PressureLoss.TwoPhase.SlipRatio(
                voidFractionApproach,
                rho_g,
                rho_l,
                xflowMean) "Slip ratio for velocity void fraction approach";
            SI.Velocity deltaVelEnd=meanVelEnd*(SR - 1)/(xflowEnd*(SR - 1) + 1)
              "Velocity difference of two phases at end of length";
            SI.Velocity deltaVelSta=meanVelSta*(SR - 1)/(xflowSta*(SR - 1) + 1)
              "Velocity difference of two phases at start of length";

            //SOURCE 3: p.52, eq. 4.6: Considering of corrected mass flow rate for heterogenous approach
            SI.MassFlowRate mdotCorEnd=xflowEnd*(1 - xflowEnd)*rho_end*deltaVelEnd*Across
              "Correction mass flow rate at end of length";
            SI.MassFlowRate mdotCorSta=xflowSta*(1 - xflowSta)*rho_sta*deltaVelSta*Across
              "Correction mass flow rate at start of length";

            //SOURCE 3: p.53, eq. 4.13: Calculation of heterogeneous approach with correction of mass flow rate for considering velocity difference between fluid phases
            SI.Pressure dp_mom_cor=SMOOTH(
                delta_xflow,
                0.05,
                0)*abs(mdot_A*meanVelEnd + mdotCorEnd*deltaVelEnd/Across) - abs(mdot_A*
                meanVelEnd + mdotCorEnd*deltaVelEnd/Across)
              "Momentum pressure loss using mass flow rate correction";

          algorithm
            //SOURCE_1: p.Lba 4, eq. 22: Considering momentum pressure loss assuming heterogeneous approach for two phase flow
            //Momentum pressure loss occurs for a changing mass flow rate quality due to condensation or evaporation
            //At evaporation the liquid phase with a slow velocity has to be accelerated to the higher velocity of the gas
            //The difference in static pressure at the outlet and the inlet causes a positiv momentum pressure loss at evaporation (assumed vice versa for condensation)
            DP_mom := if massFlowRateCorrection then dp_mom_cor else mdot_A^2*SMOOTH(
              delta_xflow,
              0.05,
              0)*abs(1/max(MIN, rho_end) - 1/max(MIN, rho_sta));

          end dp_twoPhaseMomentum_DP;

          function TwoPhaseMultiplierFriedel
            "Calculation of two phase multiplier according to Friedel | constant mass flow rate quality | horizontal flow | vertical upflow and downflow"

            //SOURCE_1: Friedel,L.:IMPROVED FRICTION PRESSURE DROP CORRELATIONS FOR HORIZONTAL AND VERTICAL TWO PHASE PIPE FLOW, 3R International, Vol. 18, Issue 7, pp. 485-491, 1979
            //SOURCE_2: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.

            import Modelica.Math.log;
            import SMOOTH =
              Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_con
              IN_con
              annotation (Dialog(group="Constant inputs"));
            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_var
              IN_var(
                final sigma=0) annotation (Dialog(group="Variable inputs"));
            input SI.MassFlowRate m_flow "Mass flow rate"
              annotation (Dialog(group="Input"));

            output Real phi "Two phase multiplier w.r.t. Friedel";

          protected
            Real MIN=Modelica.Constants.eps;

            SI.Area A_cross=max(MIN, IN_con.A_cross) "Cross sectional area";
            SI.Diameter d_hyd=max(MIN, 4*A_cross/max(MIN, IN_con.perimeter))
              "Hydraulic diameter";

            //SOURCE_2: p.Lba 4, sec. 3.3: Correlation based on constant mass flow rate quality (x_flow) for increment (dx)
            //Pressure loss for total length (e.g., L=n*dx) can be achieved by discretisation
            Real mdot_A=abs(m_flow)/A_cross "Mass flux";
            Real x_flow=max(0, min(1, abs(IN_var.x_flow)))
              "Mass flow rate quality";

            //SOURCE_1: p.490 (Appendix): Characteristic numbers based on total mass flow rate flowing as liquid
            SI.FroudeNumber Fr_l=max(MIN, mdot_A^2/max(MIN, 9.81*IN_var.rho_l^2*d_hyd))
              "Froude number based on liquid flow";
            SI.ReynoldsNumber Re_g=max(1, mdot_A*d_hyd/max(MIN, IN_var.eta_g))
              "Reynolds number based on gas flow";
            SI.ReynoldsNumber Re_l=max(1, mdot_A*d_hyd/max(MIN, IN_var.eta_l))
              "Reynolds number based on liquid flow";
            SI.WeberNumber We_l=max(MIN, mdot_A^2*d_hyd/max(MIN, IN_var.sigma*IN_var.rho_l))
              "Weber number based on liquid flow";

            //SOURCE_1: p.490 (Appendix): Smoothing for sudden change from assumed laminar to assumed turbulent regime (numerical improvement at Re=1055)
            SI.ReynoldsNumber Re_lam_max=1025
              "Maximum Reynolds number assuming laminar regime";
            SI.ReynoldsNumber Re_turb_min=1075
              "Minimum Reynolds number assuming turbulent regime";

            //SOURCE_2: p.Lbb 2, eq. 9-10: Considering influence of Reynolds number on Darcy friction factor for smooth straight pipes
            //Correlation based on neglection of surface roughness
            //Correlation based on assumption that total mass flow rate is flowing as gas
            TYP.DarcyFrictionFactor lambda_lam_g=64/Re_g
              "Darcy friction factor of gas for assumed laminar regime";
            TYP.DarcyFrictionFactor lambda_turb_g=1/max(MIN, 0.86859*log(max(1, Re_g/max(
                MIN, 1.964*log(Re_g) - 3.8215))))^(2)
              "Darcy friction factor of gas for assumed turbulent regime";
            TYP.DarcyFrictionFactor lambda_g=lambda_lam_g*SMOOTH(
                Re_lam_max,
                Re_turb_min,
                Re_g) + lambda_turb_g*SMOOTH(
                Re_turb_min,
                Re_lam_max,
                Re_g) "Darcy friction factor of gas for overall regime";
            //Correlation based on assumption that total mass flow rate is flowing as liquid
            TYP.DarcyFrictionFactor lambda_lam_l=64/Re_l
              "Darcy friction factor of liquid for assumed laminar regime";
            TYP.DarcyFrictionFactor lambda_turb_l=1/max(MIN, 0.86859*log(max(1, Re_l/max(
                MIN, 1.964*log(Re_l) - 3.8215))))^(2)
              "Darcy friction factor of liquid for assumed turbulent regime";
            TYP.DarcyFrictionFactor lambda_l=lambda_lam_l*SMOOTH(
                Re_lam_max,
                Re_turb_min,
                Re_l) + lambda_turb_l*SMOOTH(
                Re_turb_min,
                Re_lam_max,
                Re_l) "Darcy friction factor of liquid for overall regime";

            Real A=(1 - x_flow)^2 + x_flow^2*(IN_var.rho_l/max(MIN, IN_var.rho_g))*(
                lambda_g/max(MIN, lambda_l)) "Summand for two phase multiplier";

            //SOURCE_1: p.490 (Appendix): Two phase multiplier for vertical downflow for future usage
            Real phi_vdo=A + 38.5*x_flow^0.76*(1 - x_flow)^0.314*(IN_var.rho_l/max(MIN,
                IN_var.rho_g))^0.86*(IN_var.eta_g/max(MIN, IN_var.eta_l))^0.73*(1 -
                IN_var.eta_g/max(MIN, IN_var.eta_l))^6.84*(1/Fr_l^(0.0001))*(1/We_l^(
                0.087));

            //SOURCE_1: p.490 (Appendix): Two phase multiplier for horizontal and vertical upflow (failure in SOURCE_2)
            Real phi_vup=A + 3.43*x_flow^0.685*(1 - x_flow)^0.24*(IN_var.rho_l/max(MIN,
                IN_var.rho_g))^0.8*(IN_var.eta_g/max(MIN, IN_var.eta_l))^0.22*(1 - IN_var.eta_g
                /max(MIN, IN_var.eta_l))^0.89*(1/Fr_l^(0.048))*(1/We_l^(0.0334));

          algorithm
            phi := phi_vup;
          end TwoPhaseMultiplierFriedel;

          function TwoPhaseMultiplierChisholm
            "Calculation of two phase multiplier according to Chisholm | constant mass flow rate quality"

            //SOURCE_1: Chisholm,D.:PRESSURE GRADIENTS DUE TO FRICTION DURING THE FLOW OF EVAPORATING TWO-PHASE MIXTURES IN SMOOTH TUBES AND CHANNELS, Int. J. Heat Mass Transfer, Vol. 16, pp. 347-358, Pergamon Press 1973
            //SOURCE_2: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.

            import SMOOTH =
              Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_con
              IN_con
              annotation (Dialog(group="Constant inputs"));
            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_var
              IN_var
              annotation (Dialog(group="Variable inputs"));
            input SI.MassFlowRate m_flow "Mass flow rate"
              annotation (Dialog(group="Input"));

            output Real phi "Two phase multiplier w.r.t. Chisholm";

          protected
            Real MIN=Modelica.Constants.eps;

            SI.Area A_cross=max(MIN, IN_con.A_cross) "Cross sectional area";
            SI.Diameter d_hyd=max(MIN, 4*A_cross/max(MIN, IN_con.perimeter))
              "Hydraulic diameter";

            Real mdot_A=abs(m_flow)/A_cross "Mass flux";
            Real x_flow=max(0, min(1, abs(IN_var.x_flow)))
              "Mass flow rate quality";

            //SOURCE_1: p.357, Appendix 1: Considering Darcy friction factor (lambda_FRI) of smooth pipes for overall flow regime
            Real n_exp=0.2 "Exponent for Reynolds number (lambda_FRI= A/Re^n)";

            //SOURCE_1: p.349, eq. 21: Considering effect of physical properties (failure in SOURCE_2)
            Real gamma=max(1, abs(IN_var.rho_l/max(MIN, IN_var.rho_g))^0.5*(IN_var.eta_g/
                max(MIN, IN_var.eta_l))^(n_exp/2));

            //SOURCE: p. 353, tab. 2: Considering effect of mass flux on two phase multiplier
            Real B_gamma_1=SMOOTH(
                450,
                550,
                mdot_A)*4.8 + SMOOTH(
                550,
                450,
                mdot_A)*2400/max(MIN, mdot_A) - SMOOTH(
                1950,
                1850,
                mdot_A)*2400/max(MIN, mdot_A) + SMOOTH(
                1950,
                1850,
                mdot_A)*55/max(MIN, mdot_A^0.5)
              "Coefficient B for gamma <= 9.5";
            Real B_gamma_2=SMOOTH(
                550,
                650,
                mdot_A)*520/max(1, max(9.5, gamma)*mdot_A^0.5) + SMOOTH(
                650,
                550,
                mdot_A)*21/max(9.5, gamma)
              "Coefficient B for 9.5 <= gamma <= 28";
            Real B_gamma=SMOOTH(
                9.0,
                10,
                gamma)*B_gamma_1 + SMOOTH(
                10,
                9.0,
                gamma)*B_gamma_2 - SMOOTH(
                28.5,
                27.7,
                gamma)*B_gamma_2 + SMOOTH(
                28.5,
                27.5,
                gamma)*15000/max(MIN, gamma^2*mdot_A^0.5)
              "Coefficient B for gamma";

            //SOURCE_1: p. 350, eq. 24/26: Considering two phase multiplier w.r.t. Chisholm
          algorithm
            phi := 1 + (gamma^2 - 1)*(B_gamma*x_flow^((2 - n_exp)/2)*(1 - x_flow)^((2 -
              n_exp)/2) + x_flow^(2 - n_exp));
          end TwoPhaseMultiplierChisholm;

          function TwoPhaseDensity
            "Calculation of mean density for two phase flow"

            //SOURCE_1: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.
            input Modelica.Fluid.Dissipation.Utilities.Types.Roughness
              voidFractionApproach=
                Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous
              "Choice of void fraction approach" annotation (Dialog(group="Choices"));

            //SOURCE_3: p.52, eq. 4.6: heterogenous effects on momentum pressure loss considered through corrected mass flow rate
            input Boolean massFlowRateCorrection=false
              "Consider heterogeneous mass flow rate correction"
              annotation (Dialog(group="Choices"));

            input SI.Density rho_g(min=Modelica.Constants.eps)
              "Density of gaseous phase"
              annotation (Dialog);
            input SI.Density rho_l(min=Modelica.Constants.eps)
              "Density of liquid phase"
              annotation (Dialog);
            input Real epsilon_A(min=0,max=1)
              "Void fraction (cross sectional averaged)"
              annotation (Dialog(enable=not (twoPhaseDensityApproach == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseDensityApproach.Homogeneous)));
            input Real x_flow(min=0,max=1) "Mass flow rate quality" annotation (Dialog);

            output SI.Density rho_2ph "Mean density of two phase flow";
          protected
            Real MIN=Modelica.Constants.eps;

            Real epsilonA=min(1, max(0, abs(epsilon_A)))
              "Void fraction (cross sectional averaged)";
            Real xflow=min(1, max(0, abs(x_flow))) "Mass flow rate quality";

            //SOURCE_1: p.Lba 3, eq. 17: Mean two phase density assuming homogeneous approach
            SI.Density rho_hom=1/max(MIN, x_flow/max(MIN, rho_g) + (1 - x_flow)/max(MIN,
                rho_l));
            //SOURCE_1: p.Lbb 7, tab. 2: Mean two phase density assuming momentum flux approach
            SI.Density rho_mom=1/max(MIN, (x_flow)^2/max(MIN, rho_g*epsilonA) + (1 -
                x_flow)^2/max(MIN, rho_l*(1 - epsilonA)));
            //SOURCE_1: p.Lbb 7, tab. 2: Mean two phase density assuming kinetic energy flow approach from Zivi (corrected formula!)
            SI.Density rho_kin=1/max(MIN, rho_hom*(x_flow^3/max(MIN, rho_g^2*epsilonA^2)
                 + (1 - x_flow)^3/max(MIN, rho_l^2*(1 - epsilonA)^2)));

          algorithm
            rho_2ph := if massFlowRateCorrection then rho_hom else if
              voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous then
                    rho_hom else if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Momentum then
                    rho_mom else if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Energy then
                    rho_kin else MIN;

            annotation (Documentation(info="<html>
<p>
The gaseous and the liquid part of a fluid in a two phase flow are often discontinuously distributed. This complex behaviour is simplified for engineering calculations. The two phase flow of different fluid flow situations (e.g., bubble or stratified flow) is modelled as if the gaseous and the liquid phase are continuously distributed.
</p>

<p>
A <b> mean density </b> assuming a continuous distribution out of a discontinuous two phase fluid flow situation can be calculated with a <b> homogeneous or a heterogeneous approach </b> (see <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_DP\">dp_twoPhaseOverall_DP</a>).

The following <b> modelling approaches </b> can be used to calculate the mean density of two phase flow:
<ul>
<li>        <b> homogeneous density </b> (homogeneous approach) </li>
<li>         <b> momentum flux density </b> (heterogeneous approach) </li>
<li>         <b> kinetic energy flow density </b> (heterogeneous approach) </li>
</ul>
</p>

<p>
The heterogeneous approaches are analytically derived by minimising the momentum flux or the kinetic energy flow assuming implicitly that the two-phase flow will tend towards the minimum of this quantity.
</p>

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
 <dt>VDI:</dt>
    <dd><b>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</b>.
    Springer Verlag, 10th edition, 2006.</dd>
</dl>
</html>"));
          end TwoPhaseDensity;

          function VoidFraction
            "Calculation of (cross sectional) void fraction for two phase flow"

            //SOURCE_1: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.
            //SOURCE_2: Thome, J.R., Engineering Data Book 3, Swiss Federal Institute of Technology Lausanne (EPFL), 2009.

            input
              Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach
              voidFractionApproach=Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous
              "Choice of void fraction approach" annotation (Dialog(group="Choices"));

            input Boolean crossSectionalAveraged=true
              "true == cross sectional averaged void fraction | false == volumetric"
              annotation (Dialog);

            input SI.Density rho_g(min=Modelica.Constants.eps) = 1.1220
              "Density of gaseous phase" annotation (Dialog);
            input SI.Density rho_l(min=Modelica.Constants.eps) = 943.11
              "Density of liquid phase" annotation (Dialog);
            input Real x_flow(
              min=0,
              max=1) = 0 "Mass flow rate quality" annotation (Dialog);

            output Real epsilon "Void fraction";
            output Real slipRatio "Slip ratio";

          protected
            Real MIN=Modelica.Constants.eps;

            Real xflow=min(1, max(0, abs(x_flow))) "Mass flow rate quality";

            Real SR=Dissipation.Utilities.Functions.PressureLoss.TwoPhase.SlipRatio(
                voidFractionApproach,
                rho_g,
                rho_l,
                xflow) "Slip ratio for void fraction approach";

            //SOURCE_2: p.17-5, eq. 17.2.5: (Heterogeneous) cross sectional void fraction [epsilon_A=A_g/(A_g+A_l)]
            Real epsilon_A=rho_l*x_flow/max(MIN, rho_l*x_flow + rho_g*(1 - x_flow)*SR);

          algorithm
            epsilon := if crossSectionalAveraged then epsilon_A else epsilon_A/((1/max(
              MIN, SR))*(1 - epsilon_A) + epsilon_A);
            slipRatio := SR;
          end VoidFraction;

          function SlipRatio "Calculation of (analytical/empirical) slip ratio"

            //SOURCE_1: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.
            //SOURCE_2: Thome, J.R., Engineering Data Book 3, Swiss Federal Institute of Technology Lausanne (EPFL), 2009.
            //SOURCE 3: J.M. Jensen and H. Tummescheit. Moving boundary models for dynamic simulations of two-phase flows. In Proceedings of the 2nd International Modelica Conference, pp. 235-244, Oberpfaffenhofen, Germany, 2002. The Modelica Association.

            input
              Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach
              voidFractionApproach=Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous
              "Choice of void fraction approach" annotation (Dialog(group="Choices"));

            input SI.Density rho_g(min=Modelica.Constants.eps) = 1.1220
              "Density of gaseous phase" annotation (Dialog);
            input SI.Density rho_l(min=Modelica.Constants.eps) = 943.11
              "Density of liquid phase" annotation (Dialog);
            input Real x_flow=0 "Mass flow rate quality" annotation (Dialog);

            output Real SR "Slip ratio";

          protected
            Real MIN=Modelica.Constants.eps;

            //SOURCE_1: p.Lba 3, sec. 3.2
            Real SR_hom=1 "Slip ratio w.r.t. homogeneous approach";
            //SOURCE_1: p.17-6, eq. 17.3.4
            Real SR_mom=abs(rho_l/max(MIN, rho_g))^0.5
              "Slip ratio w.r.t. momentum flux approach (heterogeneous)";
            //SOURCE_1: p.17-6, eq. 17.3.13
            Real SR_kin=abs(rho_l/max(MIN, rho_g))^(1/3)
              "Slip ratio w.r.t. kinetic energy flow approach from Zivi (heterogeneous)";
            //SOURCE_1: p.17-6, eq. 17.3.13
            Real SR_chi=(1 - x_flow*(1 - abs(rho_l)/max(MIN, abs(rho_g))))^0.5
              "Empirical slip ratio w.r.t. momentum flux approach from Chisholm (heterogeneous)";

          algorithm
            SR := if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous then
                    SR_hom else if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Momentum then
                    SR_mom else if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Energy then
                    SR_kin else if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Chisholm then
                    SR_chi else 1;
          end SlipRatio;
        end TwoPhase;
      end PressureLoss;

      package HeatTransfer "Package for utility heat transfer functions"
        extends Modelica.Icons.Package;

        package TwoPhase
          "Package with utility functions to compute two phase heat transfer characteristics"
          extends Modelica.Icons.Package;

          function kc_twoPhase_condensationHorizontal_KC
            "Local two phase heat transfer coefficient of straight pipe | horizontal condensation"

            //SOURCE_1: M.M. Shah. A general correlation for heat transfer during film condensation inside pipes.Int. J. Heat Mass Transfer, Vol.22, p.547-556, 1979.

            //records
            input
              Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_con
              IN_con annotation (Dialog(group="Constant inputs"));
            input
              Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_var
              IN_var annotation (Dialog(group="Variable inputs"));

            output SI.CoefficientOfHeatTransfer kc
              "Local two phase heat transfer coefficient";

          protected
            Real MIN=Modelica.Constants.eps;

            SI.Area A_cross=max(MIN, IN_con.A_cross) "Cross sectional area";
            SI.Diameter d_hyd=max(MIN, 4*A_cross/max(MIN, IN_con.perimeter))
              "Hydraulic diameter";

            Real x_flow=max(0, min(1, abs(IN_var.x_flow)))
              "Mass flow rate quality";
            Real p_red=max(MIN, abs(IN_var.pressure)/max(MIN, abs(IN_con.p_crit)))
              "Reduced pressure";

            SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho_l*A_cross)
              "Mean velocity";
            SI.ReynoldsNumber Re_l=max(1, IN_var.rho_l*velocity*d_hyd/max(MIN, IN_var.eta_l))
              "Reynolds number assuming (total) mass flux flowing as liquid";
            SI.PrandtlNumber Pr_l=abs(IN_var.eta_l*IN_var.cp_l/max(MIN, IN_var.lambda_l))
              "Prandtl number assuming (total) mass flux flowing as liquid";

            //SOURCE_1: p.548, eq. 8: Considering two phase multiplier for condensation w.r.t. Shah
            SI.CoefficientOfHeatTransfer kc_1ph=0.023*Re_l^0.8*Pr_l^0.4*IN_var.lambda_l
                /d_hyd;

          algorithm
            kc := kc_1ph*((1 - x_flow)^0.8 + 3.8*x_flow^0.76*(1 - x_flow)^0.04/p_red^
              0.38);
            annotation (smoothOrder=5);
          end kc_twoPhase_condensationHorizontal_KC;

          function kc_twoPhase_boilingVertical_KC
            "Local two phase heat transfer coefficient of straight pipe | vertical boiling"

            //SOURCE_1: Bejan,A.: HEAT TRANSFER HANDBOOK, Wiley, 2003.
            //SOURCE_2: Gungor, K.E. and R.H.S. Winterton: A general correlation for flow boiling in tubes and annuli, Int.J. Heat Mass Transfer, Vol.29, p.351-358, 1986.

            //records
            input
              Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_con
              IN_con annotation (Dialog(group="Constant inputs"));
            input
              Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_var
              IN_var annotation (Dialog(group="Variable inputs"));

            output SI.CoefficientOfHeatTransfer kc
              "Local two phase heat transfer coefficient";

          protected
            Real MIN=Modelica.Constants.eps;

            SI.Area A_cross=max(MIN, IN_con.A_cross) "Cross sectional area";
            SI.Diameter d_hyd=max(MIN, 4*A_cross/max(MIN, IN_con.perimeter))
              "Hydraulic diameter";

            Real mdot_A=abs(IN_var.m_flow)/A_cross "Mass flux";
            Real x_flow=max(0, min(1, abs(IN_var.x_flow)))
              "Mass flow rate quality";
            Real p_red=max(MIN, abs(IN_var.pressure)/max(MIN, abs(IN_con.p_crit)))
              "Reduced pressure";

            //SOURCE_1: p.674, sec. 9.8.3: Considering nucleate and convective boiling w.r.t. equation of Gungor-Winterton
            SI.MassFlowRate mdot_l=abs(IN_var.m_flow)*(1 - x_flow)
              "Mass flow rate of liquid only";
            SI.Velocity velocity_l=mdot_l/max(MIN, IN_var.rho_l*A_cross)
              "Mean velocity assuming liquid mass flow rate flows alone";
            SI.ReynoldsNumber Re_l=max(1, IN_var.rho_l*velocity_l*d_hyd/max(MIN, IN_var.eta_l))
              "Reynolds number assuming liquid mass flow rate flows alone";
            SI.PrandtlNumber Pr_l=abs(IN_var.eta_l*IN_var.cp_l/max(MIN, IN_var.lambda_l))
              "Prandtl number assuming liquid mass flow rate flows alone";

            //SOURCE_1: p.674, eq. 9.98: Considering effect of heat flux on nucleate boiling with Boiling number
            //Boiling number (Bo) is defined as ratio of actual heat flux to maximum heat flux necessary for complete evaporation of liquid
            Real Bo=abs(IN_var.qdot_A)/(max(MIN, mdot_A*IN_var.dh_lg))
              "Boiling number";
            //SOURCE_1: p.673, eq. 9.94: Considering of Martinelli parameter w.r.t. equation of Chen
            Real X_tt=abs(((1 - x_flow)/max(MIN, x_flow))^0.9*(IN_var.rho_g/max(MIN,
                IN_var.rho_l))^0.5*(IN_var.eta_l/max(MIN, IN_var.eta_g))^0.1)
              "Martinelli parameter";

            //SOURCE_1: p.675, eq. 9.105: Considering of convection enhancement factor w.r.t. equation of of Gungor-Winterton
            Real E_fc=1 + 24000*Bo^1.16 + 1.37*(1/max(MIN, X_tt))^0.86
              "Enhancement factor for forced convection";
            //SOURCE_1: p.675, eq. 9.105: Considering of boiling suppression factor w.r.t. equation of of Gungor-Winterton
            Real S_nb=1/max(MIN, 1 + 1.15e-6*E_fc^2*Re_l^1.17)
              "Suppression factor for nucleate boiling";

            //SOURCE_1: p.672, eq. 9.91: Considering effect of forced convective boiling ew.r.t. equation of Dittus-Boelter
            SI.CoefficientOfHeatTransfer kc_fc=0.023*Re_l^0.8*Pr_l^0.4*(IN_var.lambda_l
                /d_hyd)
              "Convective heat transfer coefficient assuming liquid mass flow rate only";
            //SOURCE_1: p.675, eq. 9.107: Considering effect of nucleate boiling w.r.t. equation of Cooper
            SI.CoefficientOfHeatTransfer kc_nb=55*p_red^0.12*(1/max(MIN,
                Modelica.Math.log10(1/p_red))^0.55)*(1/max(MIN, IN_con.MM)^0.5)*IN_var.qdot_A
                ^0.67 "Nucleate boiling heat transfer coefficient";

            //SOURCE_2: p.354, sec. final equations: Calculation of two phase heat transfer coefficient for vertical pipes w.r.t. equation of Gungor-Winterton
          algorithm
            kc := E_fc*kc_fc + S_nb*kc_nb;
            annotation (smoothOrder=5);
          end kc_twoPhase_boilingVertical_KC;

          function kc_twoPhase_boilingHorizontal_KC
            "Local two phase heat transfer coefficient of straight pipe | horizontal boiling"

            //SOURCE_1: Bejan,A.: HEAT TRANSFER HANDBOOK, Wiley, 2003.
            //SOURCE_2: Gungor, K.E. and R.H.S. Winterton: A general correlation for flow boiling in tubes and annuli, Int.J. Heat Mass Transfer, Vol.29, p.351-358, 1986.

            import SMOOTH =
              Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

            //records
            input
              Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_con
              IN_con annotation (Dialog(group="Constant inputs"));
            input
              Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_var
              IN_var annotation (Dialog(group="Variable inputs"));

            output SI.CoefficientOfHeatTransfer kc
              "Local two phase heat transfer coefficient";

          protected
            Real MIN=Modelica.Constants.eps;

            SI.Area A_cross=max(MIN, IN_con.A_cross) "Cross sectional area";
            SI.Diameter d_hyd=max(MIN, 4*A_cross/max(MIN, IN_con.perimeter))
              "Hydraulic diameter";

            Real mdot_A=abs(IN_var.m_flow)/A_cross "Mass flux";
            Real x_flow=max(0, min(1, abs(IN_var.x_flow)))
              "Mass flow rate quality";
            Real p_red=max(MIN, abs(IN_var.pressure)/max(MIN, abs(IN_con.p_crit)))
              "Reduced pressure";

            //SOURCE_1: p.674, sec. 9.8.3: Considering nucleate and convective boiling w.r.t. equation of Gungor-Winterton
            SI.MassFlowRate mdot_l=abs(IN_var.m_flow)*(1 - x_flow)
              "Mass flow rate of liquid only";
            SI.Velocity velocity_l=mdot_l/max(MIN, IN_var.rho_l*A_cross)
              "Mean velocity assuming liquid mass flow rate flows alone";
            SI.ReynoldsNumber Re_l=max(1, IN_var.rho_l*velocity_l*d_hyd/max(MIN, IN_var.eta_l))
              "Reynolds number assuming liquid mass flow rate flows alone";
            SI.PrandtlNumber Pr_l=abs(IN_var.eta_l*IN_var.cp_l/max(MIN, IN_var.lambda_l))
              "Prandtl number assuming liquid mass flow rate flows alone";
            //SOURCE_1: p.352, sec. Nomenclature: Considering effect of stratification w.r.t. Froude number
            SI.FroudeNumber Fr_l=abs(mdot_A^2/max(MIN, IN_var.rho_l^2*9.81*d_hyd))
              "Froude number assuming (total) mass flux flowing as liquid";

            //SOURCE_1: p.674, eq. 9.98: Considering effect of heat flux on nucleate boiling with Boiling number
            //Boiling number (Bo) is defined as ratio of actual heat flux to maximum heat flux necessary for complete evaporation of liquid
            Real Bo=abs(IN_var.qdot_A)/(max(MIN, mdot_A*IN_var.dh_lg))
              "Boiling number";
            //SOURCE_1: p.673, eq. 9.94: Considering of Martinelli parameter w.r.t. equation of Chen
            Real X_tt=abs(((1 - x_flow)/max(MIN, x_flow))^0.9*(IN_var.rho_g/max(MIN,
                IN_var.rho_l))^0.5*(IN_var.eta_l/max(MIN, IN_var.eta_g))^0.1)
              "Martinelli parameter";

            //SOURCE_1: p.675, eq. 9.105: Considering of convection enhancement factor w.r.t. equation of Gungor-Winterton
            Real E_fc=1 + 24000*Bo^1.16 + 1.37*(1/max(MIN, X_tt))^0.86
              "Enhancement factor for forced convetion";
            //SOURCE_1: p.675, eq. 9.105: Considering of boiling suppression factor w.r.t. equation of Gungor-Winterton
            Real S_nb=1/max(MIN, 1 + 1.15e-6*E_fc^2*Re_l^1.17)
              "Suppression factor for nucleate boiling";
            //SOURCE_1: p.680, eq. 9.123: Considering correction of convection enhancement factor for horizontal pipes
            Real E_fc_hor=SMOOTH(
                  0.049,
                  0.051,
                  Fr_l)*Fr_l^max(0, abs(0.1 - 2*Fr_l)) + SMOOTH(
                  0.051,
                  0.049,
                  Fr_l)
              "Correction of enhancement factor for forced convection in horizontal pipes";
            //SOURCE_1: p.680, eq. 9.124: Considering correction of boiling suppression factor for horizontal pipes
            Real S_nb_hor=SMOOTH(
                  0.049,
                  0.051,
                  Fr_l)*Fr_l^0.5 + SMOOTH(
                  0.051,
                  0.049,
                  Fr_l)
              "Correction of suppression factor for nucleate boiling in horizontal pipes";

            //SOURCE_1: p.672, eq. 9.91: Considering effect of forced convective boiling ew.r.t. equation of Dittus-Boelter
            SI.CoefficientOfHeatTransfer kc_fc=0.023*Re_l^0.8*Pr_l^0.4*(IN_var.lambda_l
                /d_hyd)
              "Convective heat transfer coefficient assuming liquid mass flow rate only";
            //SOURCE_1: p.675, eq. 9.107: Considering effect of nucleate boiling w.r.t. equation of Cooper
            SI.CoefficientOfHeatTransfer kc_nb=55*p_red^0.12*(1/max(MIN,
                Modelica.Math.log10(1/p_red))^0.55)*(1/max(MIN, IN_con.MM^0.5))*abs(
                IN_var.qdot_A)^0.67
              "Nucleate boiling heat transfer coefficient";

            //SOURCE_2: p.354, sec. final equations: Calculation of two phase heat transfer coefficient for horizontal pipes w.r.t. equation of Gungor-Winterton
          algorithm
            kc := E_fc*E_fc_hor*kc_fc + S_nb*S_nb_hor*kc_nb;
            annotation (smoothOrder=5);
          end kc_twoPhase_boilingHorizontal_KC;

        end TwoPhase;
      end HeatTransfer;

      package General
        extends Modelica.Icons.Package;

        function CubicInterpolation_DP
          import Modelica.Math;
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
          Real dx=Math.log10(lambda2/lambda2_1);

        algorithm
          Re := Re1*(lambda2/lambda2_1)^(1 + dx*(c2 + dx*c3));
          annotation (smoothOrder=1,
                      smoothOrder=5);
        end CubicInterpolation_DP;

        function CubicInterpolation_MFLOW
          import Modelica.Math;
          input SI.ReynoldsNumber Re;
          input SI.ReynoldsNumber Re1;
          input SI.ReynoldsNumber Re2;
          input Real Delta;
          output Real lambda2;
          // point lg(lambda2(Re1)) with derivative at lg(Re1)
        protected
          Real x1=Math.log10(Re1);
          Real y1=Math.log10(64*Re1);
          Real yd1=1;

          // Point lg(lambda2(Re2)) with derivative at lg(Re2)
          Real aux1=(0.5/Math.log(10))*5.74*0.9;
          Real aux2=Delta/3.7 + 5.74/Re2^0.9;
          Real aux3=Math.log10(aux2);
          Real L2=0.25*(Re2/aux3)^2;
          Real aux4=2.51/sqrt(L2) + 0.27*Delta;
          Real aux5=-2*sqrt(L2)*Math.log10(aux4);
          Real x2=Math.log10(Re2);
          Real y2=Math.log10(L2);
          Real yd2=2 + 4*aux1/(aux2*aux3*(Re2)^0.9);

          // Constants: Cubic polynomial between lg(Re1) and lg(Re2)
          Real diff_x=x2 - x1;
          Real m=(y2 - y1)/diff_x;
          Real c2=(3*m - 2*yd1 - yd2)/diff_x;
          Real c3=(yd1 + yd2 - 2*m)/(diff_x*diff_x);
          Real dx=Math.log10(Re/Re1);

        algorithm
          lambda2 := 64*Re1*(Re/Re1)^(1 + dx*(c2 + dx*c3));
          annotation (smoothOrder=1,
                      smoothOrder=5);
        end CubicInterpolation_MFLOW;

        function LambertW
          "Closed approximation of lambert's w function for solving f(x) = x exp(x) for x"
          input Real y "f(x)";
          output Real x "W(y)";
        protected
          Real xl;

        algorithm
          if (y <= 500.0) then
            xl := Modelica.Math.log(y + 1.0);
            x := 0.665*(1 + 0.0195*xl)*xl + 0.04;
          else
            xl := 0;
            x := Modelica.Math.log(y - 4.0) - (1.0 - 1.0/Modelica.Math.log(y))*
              Modelica.Math.log(Modelica.Math.log(y));
          end if;

          assert(y > -1/Modelica.Math.exp(1),
            "Lambert-w-function is only valid for inputs y > -1/Modelica.Math.exp(1)!");

          annotation (smoothOrder=5,
                      Documentation(info="<html>

<p>
This function calculates an approximation of the <b> inverse </b> for

<center>
<pre>
f(x) = y = x * exp( x )
</pre>
</center>

within &infin; > y > -1/e.  The relative deviation of this approximation for lambert's w function <b>x = W(y)</b> is diplayed in the following graph.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/utilities/LambertW_deviation.png\">

<p>
For y > 10 and higher values the relative deviation is smaller 2%.
</p>

</html>"));
        end LambertW;

        function LambertWIter
          "Iterative form of lambert's w function for solving f(x) = x exp(x) for x"
          input Real y "f(x)";
          output Real x "W(y)";
          output Integer iter;
        protected
          Real w;
          Real prec=1e-12;
          Real c1;
          Real c2;
          Real dw;
          Real w1;
          /*Real wTimesExpW;
  Real wPlusOneTimesExpW;*/
          Real dev;
          Integer i;

        algorithm
          w := if y > 0.1 then Modelica.Fluid.Dissipation.Utilities.Functions.General.LambertW(
            y) else sqrt(5.43656*max(y, -1/Modelica.Math.exp(1)) + 2) - 1;
          dev := 1;
          i := 0;
          while prec < dev and i < 100 loop
            /*wTimesExpW := w*Modelica.Math.exp(w);
                wPlusOneTimesExpW := (w+1)*Modelica.Math.exp(w);
                w := w-(wTimesExpW-y)/(wPlusOneTimesExpW-(w+2)*(wTimesExpW-y)/(2*w+2));
                dev := abs((y-wTimesExpW)/wPlusOneTimesExpW);
                i := i+1;*/

            c1 := Modelica.Math.exp(w);
            c2 := w*c1 - y;
            w1 := if w <> 1 then w + 1 else w;
            dw := c2/(c1*w1 - ((w + 2)*c2/(2*w1)));
            w := w - dw;
            //dev := abs(dw)/(2+abs(w));
            dev := abs((y - w*c1)/(w + 1)*c1);
            i := i + 1;
          end while;
          x := w;
          iter := i;

          annotation (smoothOrder=5,
                      Documentation(info="<html>

<p>
This function calculates an approximation of the <b> inverse </b> for

<center>
<pre>
f(x) = y = x * exp( x )
</pre>
</center>

within &infin; > y > -1/e. Please note, that for negative inputs <b>two</b> solutions exists. The function currently delivers the result x = -1 ... 0 for that particular range.
</p>

</html>"));
        end LambertWIter;

        function PrandtlNumber "calculation of Prandtl number"

          import SI = Modelica.SIunits;
          import MIN = Modelica.Constants.eps;

          //fluid properties
          input SI.SpecificHeatCapacityAtConstantPressure cp
            "specific heat capacity of fluid at constant pressure";
          input SI.DynamicViscosity eta "dynamic viscosity of fluid";
          input SI.ThermalConductivity lambda "thermal conductivity of fluid";

          output SI.PrandtlNumber Pr "Prandtl number";

        algorithm
          Pr := eta*cp/max(MIN, lambda);
          annotation (smoothOrder=1);
        end PrandtlNumber;

        function ReynoldsNumber "calculation of Reynolds number"

          import SI = Modelica.SIunits;
          import MIN = Modelica.Constants.eps;

          //geometry
          input SI.Area A_cross "Cross sectional area";
          input SI.Length perimeter "Wetted perimeter";

          //fluid properties
          input SI.Density rho "Density of fluid";
          input SI.DynamicViscosity eta "Dynamic viscosity of fluid";

          input SI.MassFlowRate m_flow "Mass flow rate";

          output SI.ReynoldsNumber Re "Reynolds number";
          output SI.Velocity velocity "Mean velocity";

        protected
          SI.Diameter d_hyd=4*A_cross/max(MIN, perimeter) "Hydraulic diameter";

        algorithm
          Re := 4*abs(m_flow)/max(MIN, (perimeter*eta));
          velocity := m_flow/max(MIN, (rho*A_cross));
          annotation (smoothOrder=1);
        end ReynoldsNumber;

        function SmoothPower
          "Limiting the derivative of function y = if x>=0 then x^pow else -(-x)^pow"
          extends Modelica.Icons.Function;
          input Real x "input variable";
          input Real deltax "range for interpolation";
          input Real pow "exponent for x";
          output Real y "output variable";
        protected
          Real adeltax=abs(deltax);
          Real C3=(pow - 1)/2*adeltax^(pow - 3);
          Real C1=(3 - pow)/2*adeltax^(pow - 1);

        algorithm
          y := if x >= adeltax then x^pow else if x <= -adeltax then -(-x)^pow else (C1
             + C3*x*x)*x;
          annotation (derivative=SmoothPower_der,
            Documentation(info="<html>
<p>
The function is used to limit the derivative of the following function at x=0:
</p>
<pre>
   y = <b>if</b> x &ge; 0 <b>then</b> x<sup><b>pow</b></sup> <b>else</b> -(-x)<sup><b>pow</b></sup>;  // pow &gt; 0
</pre>
<p>
by approximating the function in the range -<b>deltax</b>&lt; x &lt; <b>deltax</b>
with a third order polynomial that has the same derivative at <b>abs</b>(x)=deltax, as the
function above.
</p>

<h4><font color=\"#EF9B13\">Example </font></h4>
<p>
In the picture below the input x is increased from -1 to 1. The range of interpolation is defined by the same range. Displayed is the output of the function SmoothPower compared to <br>
<pre>
y=x*|x|
</pre>
<br>
For |x| &gt; 1 both functions return identical results.
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/utilities/SmoothPower.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>ThermoFluid Library</dt>
    <dd><b><a href=\"http://sourceforge.net/projects/thermofluid/\"> http://sourceforge.net/projects/thermofluid/</b>.</dd>

</html>"));
        end SmoothPower;

        function SmoothPower_der "The derivative of function SmoothPower"
          extends Modelica.Icons.Function;
          input Real x "input variable";
          input Real deltax "range of interpolation";
          input Real pow "exponent for x";
          input Real dx "derivative of x";
          input Real ddeltax "derivative of deltax";
          input Real dpow "derivative of pow";
          output Real dy "derivative of SmoothPower";
        protected
          Real C3;
          Real C1;
          Real adeltax;

        algorithm
          adeltax := abs(deltax);
          if noEvent(x >= adeltax) then
            dy := dx*pow*x^(pow - 1);
          elseif noEvent(x <= -adeltax) then
            dy := -dx*pow*(-x)^(pow - 1);
          else
            C3 := (pow - 1)/2*adeltax^(pow - 3);
            C1 := (3 - pow)/2*adeltax^(pow - 1);
            dy := (C1 + 3*C3*x*x)*dx;
          end if;
        end SmoothPower_der;

        function Stepsmoother "Continuous interpolation for x "

          extends Modelica.Icons.Function;
          input Real func "input value for that result = 100%";
          input Real nofunc "input value for that result = 0%";
          input Real x "input variable for continuous interpolation";
          output Real result "output value";

        protected
          Real m=Modelica.Constants.pi/(func - nofunc);
          Real b=-Modelica.Constants.pi/2 - m*nofunc;
          Real r_1=tan(m*x + b);

        algorithm
          result := if x >= 0.999999*(func - nofunc) + nofunc and func > nofunc or x
             <= 0.999999*(func - nofunc) + nofunc and nofunc > func then 1 else if x
             <= 0.000001*(func - nofunc) + nofunc and func > nofunc or x >= 0.000001*(
            func - nofunc) + nofunc and nofunc > func then 0 else ((0.5*(exp(r_1) - exp(
            -r_1))/(0.5*(exp(r_1) + exp(-r_1))) + 1)/2);
          annotation (
            derivative=Stepsmoother_der,
            Coordsys(
              extent=[-100, -100; 100, 100],
              grid=[2, 2],
              component=[20, 20]),
            Window(
              x=0.01,
              y=0.09,
              width=0.66,
              height=0.6),
            Documentation(info="<html>
<p>
The function is used for continuous fading of variable inputs within a defined range. It allows a differentiable and smooth transition between function outputs, e.g., laminar and turbulent pressure drop or correlations for certain ranges.
</p>
<h4><font color=\"#EF9B13\">Function </font></h4>
<p>
The tanh-function is used, since it provides an existing derivative and the derivative is zero at the borders [<b>nofunc</b>, <b>func</b>] of the interpolation domain (smooth derivative for transitions).<br>
<br>
In order to work correctly, the internal interpolation range in terms of the external arbitrary input <b> x </b> needs to be scaled such that:
<pre>
f(func)   = 0.5 &pi;
f(nofunc) = -0.5 &pi;
</pre>
</p>
<h4><font color=\"#EF9B13\">Example </font></h4>
<p>
In the picture below the input x is increased from 0 to 1. The range of interpolation is defined by:

<ul>
<li> func = 0.75</li>
<li> nofunc = 0.25</li>
</ul>
</p>

<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/utilities/Stepsmoother.png\">

<h4><font color=\"#EF9B13\">References</font></h4>
<dl>
<dt>Wischhusen, St.</dt>
    <dd><b>Simulation von K&auml;ltemaschinen-Prozessen mit MODELICA / DYMOLA</b>.
    Diploma thesis, Hamburg University of Technology, Institute of Thermofluiddynamics, 2000.</dd>
</dl></html>"),  smoothOrder=5);
        end Stepsmoother;

        function Stepsmoother_der "Derivative of function Stepsmoother"

          extends Modelica.Icons.Function;
          input Real func "input for that result = 100%";
          input Real nofunc "input for that result = 0%";
          input Real x "input for interpolation";
          input Real dfunc "derivative of func";
          input Real dnofunc "derivative of nofunc";
          input Real dx "derivative of x";
          output Real dresult;

        protected
          Real m=Modelica.Constants.pi/(func - nofunc);
          Real b=-Modelica.Constants.pi/2 - m*nofunc;

        algorithm
          dresult := if x >= 0.999*(func - nofunc) + nofunc and func > nofunc or x <=
            0.999*(func - nofunc) + nofunc and nofunc > func or x <= 0.001*(func -
            nofunc) + nofunc and func > nofunc or x >= 0.001*(func - nofunc) + nofunc
             and nofunc > func then 0 else (1 - Modelica.Math.tanh(Modelica.Math.tan(m*
            x + b))^2)*(1 + Modelica.Math.tan(m*x + b)^2)*m*dx;
          annotation (smoothOrder=5);
        end Stepsmoother_der;
      end General;
    end Functions;

    package Icons "Icons for Fluid.Dissipation and Fluid.Fittings libraries"
    extends Modelica.Icons.Package;

      package HeatTransfer "Icons for heat tranfer calculation"
      extends Modelica.Icons.Package;

        partial model Gap1_d "Geometry figure for gap"

          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                Rectangle(
                  extent={{-100,-40},{60,-60}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  lineThickness=1),
                Polygon(
                  points={{60,-40},{60,-60},{100,-20},{100,0},{60,-40}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  smooth=Smooth.None,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Rectangle(
                  extent={{-100,40},{60,20}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  lineThickness=1),
                Polygon(
                  points={{60,40},{60,20},{100,60},{100,80},{60,40}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  smooth=Smooth.None,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Polygon(
                  points={{100,60},{100,0},{60,0},{60,20},{100,60}},
                  lineThickness=1,
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None,
                  lineColor={0,0,0}),
                Polygon(
                  points={{-100,-40},{-100,20},{60,20},{60,0},{-60,0},{-100,-40}},
                  lineThickness=1,
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None,
                  lineColor={0,0,0}),
                Polygon(
                  points={{-100,40},{-60,80},{100,80},{60,40},{-100,40}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  smooth=Smooth.None,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Line(
                  points={{-100,20},{60,20},{100,60}},
                  thickness=1,
                  smooth=Smooth.None,
                  color={0,0,0}),
                Line(
                  points={{-100,-40},{60,-40},{100,0}},
                  thickness=1,
                  smooth=Smooth.None),
                Line(
                  points={{20,80},{-20,40}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  thickness=0.5),
                Rectangle(
                  extent={{-4,66},{4,56}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineThickness=1,
                  pattern=LinePattern.None),
                Text(
                  extent={{-10,66},{10,54}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="h"),
                Line(
                  points={{60,-66},{-100,-66}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  thickness=0.5),
                Rectangle(
                  extent={{-22,-62},{-14,-72}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineThickness=1,
                  pattern=LinePattern.None),
                Text(
                  extent={{-28,-62},{-8,-74}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="L"),
                Polygon(
                  points={{-100,-40},{-60,0},{100,0},{60,-40},{-100,-40}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  smooth=Smooth.None,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Line(
                  points={{-80,20},{-80,-40}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  thickness=0.5),
                Rectangle(
                  extent={{-84,-4},{-76,-14}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-90,-2},{-70,-14}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="s"),
                Line(
                  points={{26,-10},{-24,-10}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.None},
                  thickness=1),
                Rectangle(
                  extent={{-4,-4},{4,-14}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineThickness=1,
                  pattern=LinePattern.None),
                Text(
                  extent={{-10,-2},{10,-14}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="v"),
                Ellipse(
                  extent={{78,52},{82,48}},
                  pattern=LinePattern.None,
                  lineThickness=0.5,
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Ellipse(
                  extent={{78,-28},{82,-32}},
                  pattern=LinePattern.None,
                  lineThickness=0.5,
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Line(
                  points={{80,-28},{80,48}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  thickness=0.5),
                Rectangle(
                  extent={{76,16},{84,6}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineThickness=1,
                  pattern=LinePattern.None),
                Text(
                  extent={{70,16},{90,4}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="T_wall"),
                Text(
                  extent={{-30,36},{-10,24}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="wall 1"),
                Text(
                  extent={{-30,-44},{-10,-56}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="wall 2")}));

        end Gap1_d;

        partial model HelicalPipe1_d "Geometry figure for helical pipe"

          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                Line(
                  points={{-60,82},{-60,-84}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  pattern=LinePattern.Dash),
                Line(
                  points={{-62,-26},{60,-36}},
                  pattern=LinePattern.None,
                  thickness=1,
                  smooth=Smooth.None),
                Line(
                  points={{-62,24},{60,14}},
                  pattern=LinePattern.None,
                  thickness=1,
                  smooth=Smooth.None),
                Line(
                  points={{-60,-16},{62,-26}},
                  pattern=LinePattern.None,
                  thickness=1,
                  smooth=Smooth.None),
                Line(
                  points={{-60,34},{62,24}},
                  pattern=LinePattern.None,
                  thickness=1,
                  smooth=Smooth.None),
                Ellipse(
                  extent={{38,64},{78,24}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{38,14},{78,-26}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{-78,24},{-38,-16}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{-78,-26},{-38,-66}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Polygon(
                  points={{-60,-26},{60,-36},{60,-76},{-60,-66},{-60,-26}},
                  lineThickness=0.5,
                  smooth=Smooth.None,
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  pattern=LinePattern.None),
                Line(
                  points={{-60,-46},{60,-56}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  pattern=LinePattern.Dash),
                Polygon(
                  points={{-60,24},{60,14},{60,-26},{-60,-16},{-60,24}},
                  lineThickness=0.5,
                  smooth=Smooth.None,
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  pattern=LinePattern.None),
                Line(
                  points={{-60,4},{60,-6}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  pattern=LinePattern.Dash),
                Ellipse(
                  extent={{40,-36},{80,-76}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Polygon(
                  points={{-62,74},{58,64},{58,24},{-62,34},{-62,74}},
                  lineThickness=0.5,
                  smooth=Smooth.None,
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  pattern=LinePattern.None),
                Line(
                  points={{-60,54},{60,44}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  pattern=LinePattern.Dash),
                Ellipse(
                  extent={{-80,74},{-40,34}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Polygon(
                  points={{-60,24},{60,64},{60,24},{-60,-16},{-60,24}},
                  lineThickness=0.5,
                  smooth=Smooth.None,
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  pattern=LinePattern.None),
                Line(
                  points={{8,28},{-8,22}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.None,Arrow.Filled},
                  thickness=1),
                Line(
                  points={{12,-24},{-4,-30}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.None,Arrow.Filled},
                  thickness=1),
                Polygon(
                  points={{-60,-26},{60,14},{60,-26},{-60,-66},{-60,-26}},
                  lineThickness=0.5,
                  smooth=Smooth.None,
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  pattern=LinePattern.None),
                Line(
                  points={{60,24},{-60,-16}},
                  smooth=Smooth.None,
                  color={0,0,0},
                  thickness=0.5),
                Line(
                  points={{60,14},{-60,-26}},
                  thickness=0.5,
                  smooth=Smooth.None),
                Line(
                  points={{60,-26},{-60,-66}},
                  thickness=0.5,
                  smooth=Smooth.None,
                  color={0,0,0}),
                Line(
                  points={{-60,74},{60,64}},
                  thickness=0.5,
                  smooth=Smooth.None),
                Line(
                  points={{-60,24},{60,64}},
                  thickness=0.5,
                  smooth=Smooth.None,
                  color={0,0,0}),
                Line(
                  points={{-60,-66},{60,-76}},
                  thickness=0.5,
                  smooth=Smooth.None),
                Line(
                  points={{10,-22},{-6,-28}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.None,Arrow.Filled},
                  thickness=1),
                Ellipse(
                  extent={{46,-42},{74,-70}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-74,68},{-46,40}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-74,78},{-46,78}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled}),
                Line(
                  points={{2,3},{-14,3}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.None,Arrow.Filled},
                  thickness=1,
                  origin={-38,55},
                  rotation=180),
                Line(
                  points={{0,82},{0,-86}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  pattern=LinePattern.DashDot),
                Line(
                  points={{60,-32},{60,-82}},
                  thickness=0.5,
                  smooth=Smooth.None,
                  color={0,0,0},
                  pattern=LinePattern.DashDot),
                Line(
                  points={{-60,-82},{60,-82}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled}),
                Rectangle(
                  extent={{-18,-76},{18,-88}},
                  fillPattern=FillPattern.Solid,
                  fillColor={255,255,255},
                  lineThickness=0.5,
                  pattern=LinePattern.None),
                Text(
                  extent={{-14,-76},{12,-86}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None,
                  textString="d_mean"),
                Line(
                  points={{46,-56},{88,-56}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  pattern=LinePattern.DashDot),
                Line(
                  points={{60,18},{60,-30}},
                  thickness=0.5,
                  smooth=Smooth.None,
                  color={0,0,0},
                  pattern=LinePattern.DashDot),
                Line(
                  points={{46,-6},{88,-6}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  pattern=LinePattern.DashDot),
                Line(
                  points={{84,-6},{84,-56}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled}),
                Rectangle(
                  extent={{74,-24},{98,-36}},
                  fillPattern=FillPattern.Solid,
                  fillColor={255,255,255},
                  lineThickness=0.5,
                  pattern=LinePattern.None),
                Line(
                  points={{-74,82},{-74,52}},
                  thickness=0.5,
                  smooth=Smooth.None,
                  color={0,0,0},
                  pattern=LinePattern.DashDot),
                Line(
                  points={{-46,82},{-46,52}},
                  thickness=0.5,
                  smooth=Smooth.None,
                  color={0,0,0},
                  pattern=LinePattern.DashDot),
                Text(
                  extent={{72,-26},{98,-36}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="h"),
                Rectangle(
                  extent={{-68,84},{-50,76}},
                  fillPattern=FillPattern.Solid,
                  fillColor={255,255,255},
                  lineThickness=0.5,
                  pattern=LinePattern.None),
                Text(
                  extent={{-72,86},{-50,78}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="d_hyd"),
                Rectangle(
                  extent={{-36,56},{-30,48}},
                  fillPattern=FillPattern.Solid,
                  fillColor={255,255,255},
                  lineThickness=0.5,
                  pattern=LinePattern.None),
                Line(
                  points={{-40,54},{-40,50}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=1),
                Text(
                  extent={{-44,56},{-22,48}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="L")}));
        end HelicalPipe1_d;

        partial model Plate1_d "Geometry figure 1 for plate"

          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                Rectangle(
                  extent={{-100,10},{100,-10}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170}),
                Line(
                  points={{-100,-20},{100,-20}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled}),
                Text(
                  extent={{-14,-20},{12,-30}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="L"),
                Line(
                  points={{-20,16},{20,16}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.None,Arrow.Filled}),
                Text(
                  extent={{-14,26},{12,16}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="velocity")}));
        end Plate1_d;

        partial model Plate2_d "Geometry figure 2 for plate"

          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                    {100,100}}), graphics), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Rectangle(
                  extent={{-100,-20},{60,-40}},
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  lineThickness=0.5,
                  lineColor={0,0,0}),Polygon(
                  points={{-100,-20},{-60,20},{100,20},{60,-20},{-100,-20}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward,
                  lineThickness=0.5),Polygon(
                  points={{60,-20},{60,-40},{100,0},{100,20},{60,-20}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  smooth=Smooth.None,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),Line(
                  points={{-20,0},{20,0}},
                  thickness=1,
                  smooth=Smooth.None,
                  color={0,0,0},
                  arrow={Arrow.None,Arrow.Filled}),Text(
                  extent={{-14,10},{12,0}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="v"),Line(
                  points={{-100,-48},{60,-48}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled}),Rectangle(
                  extent={{-26,-44},{-18,-54}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineThickness=1,
                  pattern=LinePattern.None),Text(
                  extent={{-34,-44},{-8,-54}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="L")}));
        end Plate2_d;

        partial model Channel_i "Icon for heat transfer in a channel"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,100},{100,-100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/channel/icon_channel.png")}));
        end Channel_i;

        partial model General_i "Icon for general heat transfer component"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,100},{100,-100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/general/icon_general.png")}));
        end General_i;

        partial model HeatExchanger_i
          "Icon for heat transfer of a heat exchanger"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,100},{100,-100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/heatExchanger/icon_heatExchanger.png")}));
        end HeatExchanger_i;

        partial model HelicalPipe_i "Icon for heat transfer in a helical pipe"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,100},{100,-100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/helicalPipe/icon_helicalPipe.png")}));
        end HelicalPipe_i;

        partial model Plate_i "Icon for heat transfer of a plate"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,100},{100,-100}},
                    fileName="modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/plate/icon_plate.png")}));
        end Plate_i;

        partial model StraightPipe_i
          "Icon for heat transfer of a straight pipe"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,100},{100,-100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/FluidDissipation/heatTransfer/straightPipe/icon_straightPipe.png")}));

        end StraightPipe_i;
      end HeatTransfer;

      package PressureLoss "Icons for pressure loss calculation"
      extends Modelica.Icons.Package;

        partial model BendEdged_d "Geometry figure of edged bend"

          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                Rectangle(
                  extent={{-100,10},{0,-20}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Polygon(
                  points={{0,10},{100,-48},{100,-80},{0,-20},{0,10}},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Ellipse(
                  extent={{-6,16},{8,2}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{0,40},{100,-20},{100,-48},{0,10},{0,40}},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Rectangle(
                  extent={{-100,40},{0,10}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Polygon(
                  points={{-100,-40},{-100,-20},{0,-20},{0,-40},{-100,-40}},
                  smooth=Smooth.None,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward,
                  lineColor={0,0,0}),
                Polygon(
                  points={{0,-40},{0,-20},{100,-80},{100,-100},{0,-40}},
                  smooth=Smooth.None,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward,
                  lineColor={0,0,0}),
                Polygon(
                  points={{0,40},{0,60},{100,0},{100,-20},{0,40}},
                  smooth=Smooth.None,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward,
                  lineColor={0,0,0}),
                Polygon(
                  points={{-100,40},{-100,60},{0,60},{0,40},{-100,40}},
                  smooth=Smooth.None,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward,
                  lineColor={0,0,0}),
                Line(
                  points={{0,10},{100,-48}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  arrow={Arrow.None,Arrow.Filled},
                  thickness=0.5),
                Line(
                  points={{-100,10},{0,10}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  arrow={Arrow.Filled,Arrow.None}),
                Line(
                  points={{-78,40},{-78,-20}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled}),
                Rectangle(
                  extent={{-90,32},{-62,18}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-90,30},{-64,20}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="d_hyd"),
                Text(
                  extent={{-10,20},{16,10}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="delta"),
                Rectangle(
                  extent={{-54,18},{-44,2}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-58,14},{-40,4}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="L"),
                Ellipse(
                  extent={{-2,6},{0,4}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-2,4},{2,10}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None)}));

        end BendEdged_d;

        partial model Channel_d "Geometry figure for channel"

          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                Line(
                  points={{-92,80},{-60,80}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot),
                Ellipse(
                  extent={{20,80},{-20,40}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{80,74},{40,46}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{14,74},{-14,46}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{0,74},{0,46}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled}),
                Rectangle(
                  extent={{-10,66},{10,56}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-9,66},{9,56}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textString="d_cir"),
                Ellipse(
                  extent={{-40,80},{-80,40}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),
                Ellipse(
                  extent={{-46,74},{-74,46}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Line(
                  points={{0,14},{0,-14}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={-60,36},
                  rotation=90),
                Line(
                  points={{-92,40},{-60,40}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot),
                Line(
                  points={{-90,80},{-90,40}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled}),
                Rectangle(
                  extent={{-98,64},{-82,54}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-99,65},{-81,55}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textString="D_ann"),
                Line(
                  points={{-16,0},{16,0}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={-74,46},
                  rotation=270),
                Line(
                  points={{-16,0},{16,0}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={-46,46},
                  rotation=90),
                Rectangle(
                  extent={{-68,38},{-52,28}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-69,39},{-51,29}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textString="d_ann"),
                Ellipse(
                  extent={{78,72},{42,48}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-22,0},{22,0}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={60,60},
                  rotation=90),
                Line(
                  points={{6.12325e-016,4},{0,-14}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={46,42},
                  rotation=90),
                Rectangle(
                  extent={{46,46},{55,39}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{46,46},{55,39}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textString="a_ell"),
                Line(
                  points={{-2.71927e-032,4.4409e-016},{22,0}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={42,38},
                  rotation=90),
                Line(
                  points={{60,72},{92,72}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot),
                Line(
                  points={{38,60},{92,60}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot),
                Line(
                  points={{6.12325e-016,4},{0,-8}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={88,68},
                  rotation=360),
                Rectangle(
                  extent={{82,68},{94,65}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{83,69},{95,63}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textString="b_ell"),
                Rectangle(
                  extent={{-60,24},{-20,-6}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward,
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-56,20},{-24,-2}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Line(
                  points={{-16,0},{16,0}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={-56,-2},
                  rotation=270),
                Line(
                  points={{-16,0},{16,0}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={-24,-2},
                  rotation=270),
                Line(
                  points={{0,14},{2.4493e-016,-18}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={-42,-14},
                  rotation=90),
                Rectangle(
                  extent={{-50,-10},{-30,-20}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-48,-9},{-31,-18}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textString="a_rec"),
                Line(
                  points={{-16,0},{16,0}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={-31,20},
                  rotation=360),
                Line(
                  points={{-16,0},{16,0}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={-31,-2},
                  rotation=360),
                Line(
                  points={{2.44929e-016,12},{-1.07621e-016,-10}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={-16,10},
                  rotation=180),
                Rectangle(
                  extent={{-19,15},{0,3}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-18,13},{-1,4}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textString="b_rec"),
                Polygon(
                  points={{20,-10},{40,30},{60,-10},{20,-10}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  smooth=Smooth.None,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Polygon(
                  points={{26,-6},{40,22},{54,-6},{26,-6}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-16,0},{-4,-1.40092e-015}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={26,-22},
                  rotation=270),
                Line(
                  points={{0,20},{-7.3479e-016,-8}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={46,-16},
                  rotation=90),
                Line(
                  points={{-16,0},{-4,-1.40092e-015}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={54,-22},
                  rotation=270),
                Line(
                  points={{-16,0},{12,0}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={56,22},
                  rotation=360),
                Line(
                  points={{-16,0},{12,0}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={56,-6},
                  rotation=360),
                Line(
                  points={{0,20},{-7.3479e-016,-8}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={64,14},
                  rotation=180),
                Rectangle(
                  extent={{55,15},{74,3}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{56,13},{73,4}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textString="h_tri"),
                Rectangle(
                  extent={{31,-11},{50,-23}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{32,-11},{49,-20}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textString="a_tri"),
                Line(
                  points={{36,14},{38,12},{42,12},{44,14}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None),
                Line(
                  points={{-12,-2},{-7.3479e-016,-8}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.None},
                  origin={40,24},
                  rotation=360),
                Text(
                  extent={{12,27},{29,18}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textString="beta")}));

        end Channel_d;

        partial model OrificeSuddenChangeSection_d
          "Geometry figure for orifice with sudden change of cross sectional area"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                Rectangle(
                  extent={{-100,60},{100,-60}},
                  lineColor={0,0,0},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Backward),
                Rectangle(
                  extent={{-100,20},{0,-20}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{0,40},{100,-42}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Text(
                  extent={{-80,88},{86,76}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="sudden expansion"),
                Text(
                  extent={{-82,-76},{86,-88}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="sudden contraction"),
                Line(
                  points={{-20,0},{20,0}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.None,Arrow.Filled},
                  origin={0,-72},
                  rotation=180),
                Line(
                  points={{-20,0},{20,0}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={-48,0},
                  rotation=90),
                Line(
                  points={{-62,-7.7932e-015},{20,0}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={52,20},
                  rotation=90),
                Rectangle(
                  extent={{42,6},{62,-8}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{38,4},{64,-6}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="A_2"),
                Rectangle(
                  extent={{-58,6},{-38,-8}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-62,4},{-36,-6}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="A_1"),
                Rectangle(
                  extent={{0,20},{0,-20}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-44,10},{40,2}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="design flow direction"),
                Line(
                  points={{-24,-4},{16,-4}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.None,Arrow.Filled}),
                Line(
                  points={{-20,70},{20,70}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.None,Arrow.Filled})}));

        end OrificeSuddenChangeSection_d;

        partial model OrificeThickEdged_d
          "Geometry figure for orifice with thick edged vena contraction"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                Rectangle(
                  extent={{-100,60},{100,-60}},
                  lineColor={0,0,0},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Backward),
                Rectangle(
                  extent={{-40,20},{40,-20}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{40,40},{100,-42}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Line(
                  points={{-20,0},{20,0}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={-48,0},
                  rotation=90),
                Line(
                  points={{-62,-7.7932e-015},{20,0}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={70,20},
                  rotation=90),
                Rectangle(
                  extent={{60,6},{80,-8}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{56,4},{82,-6}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="A_1"),
                Rectangle(
                  extent={{0,20},{0,-20}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Line(
                  points={{-40,-32},{40,-32}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled}),
                Rectangle(
                  extent={{-100,40},{-40,-42}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Line(
                  points={{-62,-7.7932e-015},{20,0}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={-70,20},
                  rotation=90),
                Rectangle(
                  extent={{-80,6},{-60,-8}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-84,4},{-58,-6}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="A_1"),
                Line(
                  points={{-42,-2.05161e-015},{-2,4.88624e-016}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={0,22},
                  rotation=90),
                Rectangle(
                  extent={{-2,6},{18,-8}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-14,4},{12,-6}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="A_0"),
                Rectangle(
                  extent={{-44,20},{-40,-20}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Rectangle(
                  extent={{40,20},{44,-20}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Rectangle(
                  extent={{-4,-28},{4,-38}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-12,-28},{14,-38}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="L")}));
        end OrificeThickEdged_d;

        partial model StraightPipe_d "Geometry figure for straight pipe"

          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                Ellipse(
                  extent={{98,46},{62,-54}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170}),
                Polygon(
                  points={{-80,-54},{-80,46},{80,46},{80,-54},{-80,-54}},
                  smooth=Smooth.None,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward,
                  lineThickness=0.5,
                  pattern=LinePattern.None),
                Line(
                  points={{-80,52},{80,52}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5,
                  arrow={Arrow.Filled,Arrow.Filled}),
                Rectangle(
                  extent={{-4,58},{6,48}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-8,58},{10,48}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="L"),
                Ellipse(
                  extent={{90,26},{70,-34}},
                  lineColor={0,0,0},
                  pattern=LinePattern.Dash,
                  lineThickness=0.5),
                Line(
                  points={{0,26},{0,-34}},
                  color={0,0,0},
                  thickness=0.5,
                  smooth=Smooth.None,
                  arrow={Arrow.Filled,Arrow.Filled}),
                Rectangle(
                  extent={{-6,-74},{10,-86}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Ellipse(
                  extent={{-62,46},{-98,-54}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{-70,26},{-90,-34}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),
                Line(
                  points={{-80,46},{80,46}},
                  pattern=LinePattern.None,
                  thickness=0.5,
                  smooth=Smooth.None),
                Line(
                  points={{-80,-54},{80,-54}},
                  pattern=LinePattern.None,
                  thickness=0.5,
                  smooth=Smooth.None),
                Line(
                  points={{-80,26},{80,26}},
                  pattern=LinePattern.Dash,
                  thickness=0.5,
                  smooth=Smooth.None,
                  color={0,0,0}),
                Line(
                  points={{-80,-34},{80,-34}},
                  thickness=0.5,
                  smooth=Smooth.None,
                  color={0,0,0},
                  pattern=LinePattern.Dash),
                Line(
                  points={{-62,-4},{98,-4}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5),
                Rectangle(
                  extent={{-12,2},{10,-8}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-14,2},{12,-8}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textString="d_hyd")}));

        end StraightPipe_d;

        partial model Valve_d "Icon for valve"

          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics), Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                Rectangle(
                  extent={{-6,-74},{10,-86}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Line(points={{-60,0},{-100,0}}, color={0,127,255}),
                Polygon(
                  points={{-60,50},{-60,-50},{60,-50},{60,50},{-60,50}},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Line(points={{60,0},{100,0}}, color={0,127,255}),
                Line(
                  points={{-60,50},{-60,-50},{60,50},{60,-50},{-60,50}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5)}));

        end Valve_d;

        model FlowModel "Icon for flow model in Modelica.Fluid applications"

          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics={
                Polygon(
                  points={{-60,50},{-60,-50},{60,-50},{60,50},{-60,50}},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Line(points={{-60,0},{-100,0}}, color={0,127,255}),
                Line(
                  points={{-60,50},{-60,-50},{60,50},{60,-50},{-60,50}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5),
                Line(points={{60,0},{100,0}}, color={0,127,255})}));
        end FlowModel;

        partial model Bend_i "Icon for bend"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,100},{100,-100}},
                    fileName="modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/bend/icon_bend.png")}));
        end Bend_i;

        partial model Channel_i "Icon for channel"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,100},{100,-100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/channel/icon_channel.png")}));
        end Channel_i;

        partial model General_i "Icon for general pressure drop"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,100},{100,-100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/general/icon_general.png")}));
        end General_i;

        partial model HeatExchanger_i

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={Bitmap(extent={{-100,100},{100,-100}},
                  fileName=
                  "modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/heatExchanger/icon_heatExchanger.png")}));
        end HeatExchanger_i;

        partial model Orifice_i "Icon for orifice"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,100},{100,-100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/orifice/icon_orifice.png")}));
        end Orifice_i;

        partial model StraightPipe_i "Icon for straight pipe"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,100},{100,-100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/straightPipe/icon_StraightPipe.png")}));
        end StraightPipe_i;

        partial model Valve_i "Icon for valve"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,100},{100,-100}},
                    fileName="modelica://Modelica/Resources/Images/FluidDissipation/pressureLoss/Valve/icon_Valve.png")}));
        end Valve_i;
      end PressureLoss;

    end Icons;

    package Records "Package for base records"
    extends Modelica.Icons.Package;
      package General
        extends Modelica.Icons.Package;
        record PressureLoss
          "Base record for fluid properties for pressure loss"
          extends Modelica.Icons.Record;

          SI.DynamicViscosity eta "Dynamic viscosity of fluid"
            annotation (Dialog(group="Fluid properties"));
          SI.Density rho "Density of fluid"
            annotation (Dialog(group="Fluid properties"));
        end PressureLoss;

        record FluidProperties "Base record for fluid properties"
          extends Modelica.Icons.Record;

          SI.SpecificHeatCapacityAtConstantPressure cp=4.19e3
            "Specific heat capacity of fluid at constant pressure"
            annotation (Dialog(group="Fluid properties"));

          SI.DynamicViscosity eta=1e-3 "Dynamic viscosity of fluid"
            annotation (Dialog(group="Fluid properties"));

          SI.ThermalConductivity lambda=0.58 "Thermal conductivity of fluid"
            annotation (Dialog(group="Fluid properties"));

          SI.Density rho=1e3 "Density of fluid"
            annotation (Dialog(group="Fluid properties"));
        end FluidProperties;

        record IdealGas_con
          "Base record for generic pressure loss function | ideal gas | mean density"
          extends Modelica.Icons.Record;

          Real exp=2 "Exponent of pressure loss law"
            annotation (Dialog(group="Generic variables"));
          SI.SpecificHeatCapacity R_s=287 "Specific gas constant of ideal gas"
            annotation (Dialog(group="Fluid properties"));
          Real Km=6824.86
            "Coefficient for pressure loss law [(Pa)^2/{(kg/s)^exp*K}]"
            annotation (Dialog(group="Generic variables"));

        end IdealGas_con;

        record IdealGas_var
          "Base record for generic pressure loss function | ideal gas | mean density"
          extends Modelica.Icons.Record;

          SI.Density rho_m=1.189 "Mean density of ideal gas"
            annotation (Dialog(group="Fluid properties", enable=useMeanDensity));
          SI.Temp_K T_m=(293 + 293)/2 "Mean temperature of ideal gas"
            annotation (Dialog(group="Fluid properties", enable=not (useMeanDensity)));
          SI.Pressure p_m=(1e5 + 1e5)/2 "Mean pressure of ideal gas"
            annotation (Dialog(group="Fluid properties", enable=not (useMeanDensity)));

        end IdealGas_var;

        record NominalDensityViscosity
          "Base record for generic pressure loss function"

          extends Modelica.Icons.Record;

          SI.Pressure dp_nom=2
            "Nominal pressure loss (at nominal values of mass flow rate and density)"
            annotation (Dialog(group="Generic variables"));
          Real exp=2 "Exponent of pressure loss law"
            annotation (Dialog(group="Generic variables"));
          SI.MassFlowRate m_flow_nom=1
            "Nominal mass flow rate (at nominal values of pressure loss and density)"
            annotation (Dialog(group="Generic variables"));
          SI.Density rho_nom=1e3
            "Nominal density (at nominal values of mass flow rate and pressure loss)"
            annotation (Dialog(group="Generic variables"));
          Real exp_eta=1 "Exponent for dynamic viscosity dependence"
            annotation (Dialog(group="Generic variables"));
          SI.DynamicViscosity eta_nom=1e-3
            "Dynamic viscosity at nominal pressure loss"
            annotation (Dialog(group="Generic variables"));

        end NominalDensityViscosity;

        record NominalPressureLossLawDensity_con
          "Base record for generic pressure loss function"

          extends Modelica.Icons.Record;

          //NominalMassFlowRate
          Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate
            target =                                                             Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate
            "1 == use nominal mass flow rate | 2 == use nominal volume flow rate"
            annotation (Dialog(group="Generic variables"));

          SI.Area A_cross=A_cross_nom "Cross sectional area"
            annotation (Dialog(group="Generic variables"));
          SI.Area A_cross_nom=Modelica.Constants.pi*0.1^2/4
            "Nominal cross sectional area"
            annotation (Dialog(group="Generic variables"));

          SI.Pressure dp_nom=2
            "Nominal pressure loss (at nominal values of mass flow rate and density)"
            annotation (Dialog(group="Generic variables"));
          SI.MassFlowRate m_flow_nom=1
            "Nominal mass flow rate (at nominal values of pressure loss and density)"
            annotation (Dialog(group="Generic variables",enable=target ==
                  Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate));
          Real exp=2 "Exponent of pressure loss law"
            annotation (Dialog(group="Generic variables"));

          SI.VolumeFlowRate V_flow_nom=m_flow_nom/rho_nom
            "Nominal volume flow rate (at nominal values of pressure loss and density)"
            annotation (Dialog(group="Generic variables",enable=target ==
                  Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate.VolumeFlowRate));
          SI.Density rho_nom=1e3
            "Nominal density (at nominal values of mass flow rate and pressure loss)"
            annotation (Dialog(group="Generic variables"));

          Types.PressureLossCoefficient zeta_TOT_nom=0.02*1/0.1
            "Nominal pressure loss coefficient (for nominal values)"
            annotation (Dialog(group="Generic variables"));

        end NominalPressureLossLawDensity_con;

        record NominalPressureLossLawDensity_var
          "Base record for generic pressure loss function"

          extends Modelica.Icons.Record;

          TYP.PressureLossCoefficient zeta_TOT=0.2 "Pressure loss coefficient"
            annotation (Dialog(group="Generic variables"));

        end NominalPressureLossLawDensity_var;

        record QuadraticVFLOW
          "Base record for generic pressure loss function | quadratic function (dp=a*Vdot^2 + b*Vdot)"

          extends Modelica.Icons.Record;

          Real a(unit="(Pa.s2)/m6") = 15 "Coefficient for quadratic term"
            annotation (Dialog(group="Generic variables"));
          Real b(unit="(Pa.s)/m3") = 0 "Coefficient for linear term"
            annotation (Dialog(group="Generic variables"));

        end QuadraticVFLOW;

        record TwoPhaseFlow_con "Base record for two phase Flow"
          extends Modelica.Icons.Record;

          SI.Area A_cross=PI*0.1^2/4 "Cross sectional area"
            annotation (Dialog(group="Geometry"));
          SI.Length perimeter=PI*0.1 "Wettet perimeter"
            annotation (Dialog(group="Geometry"));
          SI.Length length=1 "Length in fluid flow direction"
            annotation (Dialog(group="Geometry"));

        end TwoPhaseFlow_con;

        record TwoPhaseFlow_var "Base record for two phase flow"
          extends Modelica.Icons.Record;

          SI.Density rho_g=1.1220 "Density of gas"
            annotation (Dialog(group="Fluid properties"));
          SI.Density rho_l=943.11 "Density of liquid"
            annotation (Dialog(group="Fluid properties"));
          SI.DynamicViscosity eta_g=12.96e-6 "Dynamic viscosity of gas"
            annotation (Dialog(group="Fluid properties"));
          SI.DynamicViscosity eta_l=232.1e-6 "Dynamic viscosity of liquid"
            annotation (Dialog(group="Fluid properties"));
          SI.SurfaceTension sigma=54.97e-3 "Surface tension"
            annotation (Dialog(group="Fluid properties"));

          //input variables
          Real x_flow=0 "Mean mass flow rate quality over length"
            annotation (Dialog(group="Input"));
        end TwoPhaseFlow_var;

        record IdealGas
          "Base record for generic pressure loss function | ideal gas | mean density"
          extends Modelica.Icons.Record;

          parameter Real exp(min=Modelica.Constants.eps) = 2
            "Exponent of pressure loss law"
            annotation (Dialog(group="Generic variables"));
          parameter SI.SpecificHeatCapacity R_s(min=1) = 287
            "Specific gas constant of ideal gas"
            annotation (Dialog(group="Fluid properties"));

          Real Km(min=Modelica.Constants.eps) = R_s*(2e3)/((10)^exp/rho_m)
            "Coefficient for pressure loss law [(Pa)^2/{(kg/s)^exp*K}]"
            annotation (Dialog(group="Generic variables"));
          SI.Density rho_m=p_m/(R_s*T_m) "Mean density of ideal gas"
            annotation (Dialog(group="Fluid properties", enable=useMeanDensity));
          SI.Temp_K T_m=(293 + 293)/2 "Mean temperature of ideal gas"
            annotation (Dialog(group="Fluid properties", enable=not (useMeanDensity)));
          SI.Pressure p_m=(1e5 + 1e5)/2 "Mean pressure of ideal gas"
            annotation (Dialog(group="Fluid properties", enable=not (useMeanDensity)));

        end IdealGas;

        record NominalPressureLossLawDensity
          "Base record for generic pressure loss function"

          extends Modelica.Icons.Record;

          //NominalMassFlowRate
          Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate
            target =                                                             Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate
            "1 == use nominal mass flow rate | 2 == use nominal volume flow rate"
            annotation (Dialog(group="Generic variables"));

          parameter SI.Area A_cross=A_cross_nom "Cross sectional area"
            annotation (Dialog(group="Generic variables"));
          parameter SI.Area A_cross_nom=Modelica.Constants.pi*0.1^2/4
            "Nominal cross sectional area"
            annotation (Dialog(group="Generic variables"));

          parameter SI.Pressure dp_nom(min=Modelica.Constants.eps) = 2
            "Nominal pressure loss (at nominal values of mass flow rate and density)"
            annotation (Dialog(group="Generic variables"));
          parameter SI.MassFlowRate m_flow_nom(min=Modelica.Constants.eps) = 1
            "Nominal mass flow rate (at nominal values of pressure loss and density)"
            annotation (Dialog(group="Generic variables",enable=target ==
                  Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate));
          parameter Real exp(min=Modelica.Constants.eps) = 2
            "Exponent of pressure loss law"
            annotation (Dialog(group="Generic variables"));

          SI.VolumeFlowRate V_flow_nom(min=Modelica.Constants.eps) = m_flow_nom/rho_nom
            "Nominal volume flow rate (at nominal values of pressure loss and density)"
            annotation (Dialog(group="Generic variables",enable=not (target ==
                  Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate)));
          SI.Density rho_nom(min=Modelica.Constants.eps) = 1e3
            "Nominal density (at nominal values of mass flow rate and pressure loss)"
            annotation (Dialog(group="Generic variables"));

          Types.PressureLossCoefficient zeta_TOT=zeta_TOT_nom
            "Pressure loss coefficient" annotation (Dialog(group="Generic variables"));
          parameter Types.PressureLossCoefficient zeta_TOT_nom=0.02*1/0.1
            "Nominal pressure loss coefficient (for nominal values)"
            annotation (Dialog(group="Generic variables"));

        end NominalPressureLossLawDensity;

        record TwoPhaseFlow "base record for two phase Flow"
          extends Modelica.Icons.Record;

          SI.Density rho_l=958 "Density of liquid"
            annotation (Dialog(group="Fluid properties"));
          SI.Density rho_g=0.6 "Density of gas" annotation (Dialog(group=
                  "Fluid properties", enable=if KC == 1 or KC == 2 then true else false));
          SI.DynamicViscosity eta_l=282e-6 "Dynamic viscosity of liquid"
            annotation (Dialog(group="Fluid properties"));
          SI.DynamicViscosity eta_g=12.7e-6 "Dynamic viscosity of gas" annotation (
              Dialog(group="Fluid properties", enable=if KC == 1 or KC == 2 then true else
                        false));
          SI.MassFraction x=0.5 "Vapour fraction"
            annotation (Dialog(group="Fluid properties"));
          SI.SurfaceTension sigma=59e-3 "Surface Tension" annotation (Dialog(group=
                  "Fluid properties", enable=if DP_fric == 1 then true else false));
          Real n=0.25 "Exponent in Blasius equation (0.2-0.25)" annotation (Dialog(
                group="others", enable=if DP_fric == 2 then true else false));
        end TwoPhaseFlow;
      end General;

      package HeatTransfer
        extends Modelica.Icons.Package;
        record EvenGap "Input for even gap"
          extends Modelica.Icons.Record;

          //choices
          Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap target=Dissipation.Utilities.Types.kc_evenGap.DevBoth
            "Target variable of calculation" annotation (Dialog(group="Even gap"));

          SI.Length h=0.1 "Height of cross sectional area"
            annotation (Dialog(group="Even gap"));
          SI.Length s=0.05
            "Distance between parallel plates in cross sectional area"
            annotation (Dialog(group="Even gap"));
          SI.Length L=1 "Overflowed length of gap" annotation (Dialog(group="Even gap"));
        end EvenGap;

        record General "Input for generic correlation"
          extends Modelica.Icons.Record;

          //choices
          Modelica.Fluid.Dissipation.Utilities.Types.kc_general target=Dissipation.Utilities.Types.kc_general.Finest
            "Target correlation" annotation (Dialog(group="Generic variables"));

          //geometry
          SI.Area A_cross=Modelica.Constants.pi*0.1^2/4 "Cross sectional area"
            annotation (Dialog(group="Generic variables"));
          SI.Length perimeter=Modelica.Constants.pi*0.1 "Wetted perimeter"
            annotation (Dialog(group="Generic variables"));
        end General;

        record HelicalPipe "Input for helical pipe"
          extends Modelica.Icons.Record;

          Real n_nt=1 "Total number of turns" annotation (Dialog(group="HelicalPipe"));
          SI.Diameter d_hyd=0.1 "Hydraulic diameter"
            annotation (Dialog(group="HelicalPipe"));
          SI.Length h=0.01 "Distance between turns"
            annotation (Dialog(group="HelicalPipe"));
          SI.Length L=1 "Total length of helical pipe"
            annotation (Dialog(group="HelicalPipe"));

        end HelicalPipe;

        record Plate "Input for plate"
          extends Modelica.Icons.Record;

          SI.Length L=1 "Length of plate" annotation (Dialog(group="Plate"));

        end Plate;

        record StraightPipe "Input for straight pipe"
          extends Modelica.Icons.Record;

          //choices
          Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary
            target =                                                             Dissipation.Utilities.Types.HeatTransferBoundary.UWTuDFF
            "Choice of heat transfer boundary condition"
            annotation (Dialog(group="Choices"));
          Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=Dissipation.Utilities.Types.Roughness.Considered
            "Choice of considering surface roughness"
            annotation (Dialog(group="Choices"));

          SI.Diameter d_hyd=0.1 "Hydraulic diameter"
            annotation (Dialog(group="Straight pipe"));
          SI.Length K=0 "Roughness (average height of surface asperities)" annotation (
              Dialog(group="Straight pipe", enable=roughness == Modelica.Fluid.Dissipation.Utilities.Types.Roughness.considered));
          SI.Length L=1 "Length" annotation (Dialog(group="Straight pipe"));
        end StraightPipe;

        record TwoPhaseFlowHT_IN_con
          "Base record for two phase heat transfer coefficient"
          extends Modelica.Icons.Record;

          //choices
          Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget
            target=
              Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor
            "Choice of (horizontal/vertical) boiling or (horizontal) condensation in pipe"
            annotation (Dialog(group="Choices"));

          SI.Area A_cross=Modelica.Constants.pi*0.1^2/4 "Cross sectional area"
            annotation (Dialog(group="Geometry"));
          SI.Length perimeter=Modelica.Constants.pi*0.1 "Wettet perimeter"
            annotation (Dialog(group="Geometry"));

          SI.MolarMass MM=18.02 "Molar mass of fluid" annotation (Dialog(group=
                  "Fluid properties", enable=if target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor
                   or target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer then
                        true else false));
          SI.Pressure p_crit=220.89e5 "Critical pressure of fluid"
            annotation (Dialog(group="Fluid properties"));

        end TwoPhaseFlowHT_IN_con;

        record TwoPhaseFlowHT_IN_var
          "Base record for two phase heat transfer coefficient"
          extends Modelica.Icons.Record;

          //choices
          Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget
            target=
              Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor
            "Choice of (horizontal/vertical) boiling or (horizontal) condensation in pipe"
            annotation (Dialog(group="Choices"));

          //fluid properties
          SI.SpecificHeatCapacityAtConstantPressure cp_l=4.19e3
            "Specific heat capacity of liquid"
            annotation (Dialog(group="Fluid properties"));
          SI.ThermalConductivity lambda_l=0.58 "Thermal conductivity of liquid"
            annotation (Dialog(group="Fluid properties"));
          SI.Density rho_g=1.1220 "Density of gas" annotation (Dialog(group=
                  "Fluid properties", enable=if target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor
                   or target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer then
                        true else false));
          SI.Density rho_l=943.11 "Density of liquid"
            annotation (Dialog(group="Fluid properties"));
          SI.DynamicViscosity eta_g=12.96e-6 "Dynamic viscosity of gas" annotation (
              Dialog(group="Fluid properties", enable=if target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor
                   or target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer then
                        true else false));
          SI.DynamicViscosity eta_l=232.1e-6 "Dynamic viscosity of liquid"
            annotation (Dialog(group="Fluid properties"));

          SI.Pressure pressure=2e5 "Mean pressure of fluid"
            annotation (Dialog(group="Fluid properties"));
          SI.SpecificEnthalpy dh_lg=2202.08e3 "Evaporation enthalpy of fluid"
            annotation (Dialog(group="Fluid properties", enable=if target ==
                  Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor
                   or target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer then
                        true else false));

          //input variables
          SI.MassFlowRate m_flow "Mass flow rate" annotation (Dialog(group="Input"));
          SI.HeatFlux qdot_A=0 "Heat flux at boiling" annotation (Dialog(group="Input",
                enable=if target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor
                   or target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer then
                        true else false));

          Real x_flow=0 "Mass flow rate quality" annotation (Dialog(group="Input"));
        end TwoPhaseFlowHT_IN_var;
      end HeatTransfer;

      package PressureLoss
        extends Modelica.Icons.Package;

        record Bend "Input for bend"
          extends Modelica.Icons.Record;

        /*
  Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=Dissipation.Utilities.Types.Roughness.Considered
    "Choice of considering surface roughness" annotation (Dialog(group="Bend"));
*/
          SI.Diameter d_hyd(min=Modelica.Constants.eps) = 0.1
            "Hydraulic diameter"
            annotation (Dialog(group="Bend"));
          SI.Radius R_0=0.5*d_hyd "Curvature radius" annotation (Dialog(group="Bend"));
          SI.Angle delta=90*PI/180 "Angle of turning" annotation (Dialog(group="Bend"));
          SI.Length K=0
            "Roughness (absolute average height of surface asperities)"             annotation (Dialog(group="Bend"));

        /*
  SI.Length L=10*d_hyd "Length of bend along axis"
    annotation (Dialog(group="Bend"));
*/

        end Bend;

        record Geometry "Input for several geometries of internal flow"
          extends Modelica.Icons.Record;

          Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow
            geometry=
              Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Circular
            "Choice of geometry for internal flow" annotation (Dialog(group="Channel"));

          SI.Length K=0 "Roughness (average height of surface asperities)"
            annotation (Dialog(group="Channel"));
          SI.Length L=1 "Length" annotation (Dialog(group="Channel"));

          //geometry variables
          //annular(1)
          SI.Diameter d_ann=d_cir "Small diameter" annotation (Dialog(group=
                  "Annular cross sectional area", enable=geometry == Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.annular));
          SI.Diameter D_ann=2*d_ann "Large diameter" annotation (Dialog(group=
                  "Annular cross sectional area", enable=geometry == Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.annular));
          //circular(2)
          SI.Diameter d_cir=0.1 "Internal diameter" annotation (Dialog(group=
                  "Circular cross sectional area", enable=geometry == Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.circular));
          //elliptical(3)
          SI.Length a_ell=(3/4)*d_cir "Half length of long base line" annotation (
              Dialog(group="Elliptical cross sectional area", enable=geometry ==
                  Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.elliptical));
          SI.Length b_ell=0.5*a_ell "Half length of short base line" annotation (Dialog(
                group="Elliptical cross sectional area", enable=geometry ==
                  Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.elliptical));
          //rectangular(4)
          SI.Length a_rec=d_cir "Horizontal length" annotation (Dialog(group=
                  "Rectangular cross sectional area", enable=geometry ==
                  Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.rectangular));
          SI.Length b_rec=a_rec "Vertical length" annotation (Dialog(group=
                  "Rectangular cross sectional area", enable=geometry ==
                  Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.rectangular));
          //triangular(5)
          SI.Length a_tri=d_cir*(1 + 2^0.5) "Length of base line" annotation (Dialog(
                group="Rectangular cross sectional area", enable=geometry ==
                  Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.rectangular));
          SI.Length h_tri=0.5*a_tri
            "Heigth to top angle perpendicular to base line"
            annotation (Dialog(group="Triangle cross sectional area", enable=geometry
                   == Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.isosceles));
          SI.Angle beta=90*PI/180 "Top angle" annotation (Dialog(group=
                  "Triangle cross sectional area", enable=geometry == Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.isosceles));
        end Geometry;

        record Orifice "Input for orifice"

          extends Modelica.Icons.Record;

          SI.Area A_0=0.1*A_1 "Cross sectional area of vena contraction"
            annotation (Dialog(group="Orifice"));
          SI.Area A_1=PI*0.01^2/4 "Small cross sectional area of orifice"
            annotation (Dialog(group="Orifice"));
          SI.Area A_2=A_1 "Large cross sectional area of orifice"
            annotation (Dialog(group="Orifice"));
          SI.Length C_0=0.1*C_1 "Perimeter of vena contraction"
            annotation (Dialog(group="Orifice"));
          SI.Length C_1=PI*0.01 "Small perimeter of orifice"
            annotation (Dialog(group="Orifice"));
          SI.Length C_2=C_1 "Large perimeter of orifice"
            annotation (Dialog(group="Orifice"));
          SI.Length K=0 "roughness == average height of surface asperities"
            annotation (Dialog(group="Orifice"));
          SI.Length L=1e-3 "Length of vena contraction"
            annotation (Dialog(group="Orifice"));
        end Orifice;

        record PressureLossInput "Input for pressure loss calculation"
          extends Modelica.Icons.Record;

          //target variables
          Modelica.Fluid.Dissipation.Utilities.Types.PressureLossTarget target=Dissipation.Utilities.Types.PressureLossTarget.PressureLoss
            "Target variable of calculation" annotation (Dialog(group="Input"));

          SI.Pressure dp=0 "Pressure loss" annotation (Dialog(group="Input", enable=
                  target == Modelica.Fluid.Dissipation.Utilities.Types.PressureLossTarget.pressureLoss));
          SI.MassFlowRate m_flow=0 "Mass flow rate" annotation (Dialog(group="Input",
                enable=target == Modelica.Fluid.Dissipation.Utilities.Types.PressureLossTarget.massFlowRate));

        end PressureLossInput;

        record StraightPipe "Input for straight pipe"

          extends Modelica.Icons.Record;

          SI.Diameter d_hyd=0.1 "Hydraulic diameter"
            annotation (Dialog(group="Straight pipe"));
          SI.Length K=0 "Roughness (average height of surface asperities)"
            annotation (Dialog(group="Straight pipe"));
          SI.Length L=1 "Length" annotation (Dialog(group="Straight pipe"));
        end StraightPipe;

        record Tjunction "Input for T-junction"
          extends Modelica.Icons.Record;

          //T-junction variables
          Boolean united_converging_crossection=true
            "true == A_cross_total = 2*A_cross_branch | false == A_cross_total > 2*A_cross_branch"
            annotation (Dialog(group="T-junction"));
          Boolean velocity_reference_branches=true
            "true == pressure loss coefficents w.r.t. velocity in each passage | false == w.r.t. velocity in total passage"
            annotation (Dialog(group="T-junction"));

          Integer alpha=90 "Angle of branching" annotation (Dialog(group="T-junction"));

          SI.Diameter d_hyd[3]=ones(3)*0.1
            "Hydraulic diameter of passages [side,straight,total]"
            annotation (Dialog(group="T-junction"));

          //restrictions
          SI.MassFlowRate m_flow_min=1e-3
            "Restriction for smoothing at reverse fluid flow"
            annotation (Dialog(group="Restrictions"));
          SI.Velocity v_max=2e2 "Restriction for maximum fluid flow velocity"
            annotation (Dialog(group="Restrictions"));
          Real zeta_TOT_max=1e3
            "Restriction for maximum value of pressure loss coefficient"
            annotation (Dialog(group="Restrictions"));
        end Tjunction;

        record Diffuser "Input for diffuser"
          extends Modelica.Icons.Record;

          SI.Angle alpha=PI*45/180 "Diffuser diverging angle"
            annotation (Dialog(group="Diffuser"));

          SI.Area A_1=PI*0.01^2/4
            "Small constant cross sectional area before diffuser section"
            annotation (Dialog(group="Diffuser"));
          SI.Area A_2=2*A_1
            "Large constant cross sectional area after diffuser section"
            annotation (Dialog(group="Diffuser"));
          SI.Length C_1=PI*0.01 "Small perimeter before diffuser section"
            annotation (Dialog(group="Diffuser"));
          SI.Length C_2=2*C_1 "Large perimeter after diffuser section"
            annotation (Dialog(group="Diffuser"));
          SI.Length L_1=0.1 "Length of straight pipe before diffuser section"
            annotation (Dialog(group="Diffuser"));
          SI.Length L_2=L_1 "Length of straight pipe after diffuser section"
            annotation (Dialog(group="Diffuser"));
          SI.Length L_d=L_1
            "Lenght of diffuser section (parallel to bulk fluid flow)"
            annotation (Dialog(group="Diffuser"));

          //numerical aspects
          SI.Pressure dp_small=1
            "Linearisation for a pressure loss smaller then dp_small"
            annotation (Dialog(group="Numerical aspects"));
          Real zeta_TOT_min=1e-3
            "Minimal pressure loss coefficient for infinite Reynolds number"
            annotation (Dialog(group="Numerical aspects"));
          Real zeta_TOT_max=1e8
            "Maximum pressure loss coefficient for Reynolds number approaching zero"
            annotation (Dialog(group="Numerical aspects"));
        end Diffuser;
      end PressureLoss;
    end Records;

    package Types "Package for types"
    extends Modelica.Icons.Package;
      type DarcyFrictionFactor = Modelica.Icons.TypeReal (
          final quantity=
              "Darcy friction factor | lambda_fri = zeta_fri / (length/diameter)",
          final unit="1",
          min=0,
          max=1111);
      type FrictionalResistanceCoefficient = Modelica.Icons.TypeReal (
          final quantity="Frictional resistance coefficient | zeta_fri",
          final unit="1",
          min=0,
          max=1111);
      type LocalResistanceCoefficient = Modelica.Icons.TypeReal (
          final quantity="Local resistance coefficient | zeta_loc",
          final unit="1",
          min=0,
          max=1111);
      type PressureLossCoefficient = Modelica.Icons.TypeReal (
          final quantity="Pressure loss coefficient | zeta_tot = zeta_loc + zeta_fri",
          final unit="1",
          min=0,
          max=1111);
      type TwoPhaseFrictionalPressureLoss = enumeration(
          Friedel "Friedel correlation for frictional pressure loss",
          Chisholm "Chisholm correlation for frictional pressure loss");
      type Roughness = enumeration(
          Neglected "Neglect surface roughness",
          Considered "Consider surface roughness");
      type TwoPhaseHeatTransferTarget = enumeration(
          BoilHor "Boiling horizontal",
          BoilVer "Boiling vertical",
          CondHor "Condensation horizontal");
      type PressureLossTarget = enumeration(
          PressureLoss "Calculate pressure loss from mass flow rate",
          MassFlowRate "Calculate mass flow rate from pressure loss");
      type GeometryOfInternalFlow = enumeration(
          Annular "Annular geometry",
          Circular "Circular geometry",
          Elliptical "Elliptical geometry",
          Rectangular "Rectangular geometry",
          Isosceles "Isosceles triangular geometry");
      type kc_evenGap = enumeration(
          DevOne
            "Hydrodynamically DEVELOPED laminar flow regime AND heat transfer at ONE side",

          DevBoth
            "Hydrodynamically DEVELOPED laminar flow regime AND heat transfer at BOTH sides",

          UndevOne
            "Hydrodynamic and thermal START of laminar flow regime AND heat transfer at ONE side",

          UndevBoth
            "Hydrodynamic and thermal START of laminar flow regime AND heat transfer at BOTH side");

      type kc_general = enumeration(
          Rough "Roughest approximation w.r.t. Dittus/Boelter (1930)",
          Middle "Middle approximation w.r.t. Sieder/Tate (1936)",
          Finest "Finest approximation w.r.t. Gnielinski (1976)");
      type HeatTransferBoundary = enumeration(
          UWTuDFF "Uniform wall temperature in developed fluid flow (UWT+DFF)",

          UHFuDFF "Uniform heat flux in developed fluid flow (UHF+DFF)",
          UWTuUFF
            "Uniform wall temperature in undeveloped fluid flow (UWT+UFF)",
          UHFuUFF "Uniform heat flux in undeveloped fluid flow (UHF+UFF)");

      type MassOrVolumeFlowRate = enumeration(
          MassFlowRate "Mass flow rate",
          VolumeFlowRate "Volume flow rate");
      type VoidFractionApproach = enumeration(
          Homogeneous "Homogeneous approach",
          Momentum "Analytical momentum flux approach (heterogeneous)",
          Energy " Kinetic energy flow approach w.r.t. Zivi (heterogeneous)",
          Chisholm
            "Empirical momentum flux approach w.r.t. Chisholm (heterogeneous)");

      type OrificeGeometry = enumeration(
          SharpEdged "Sharp edged shape of orifice inlet",
          ThickEdged "Thick edged shape of orifice inlet",
          TiltedEdged "Tilted edged shape of orifice inlet",
          RoundedEdged "Rounded edged shape of orifice inlet");
      type ValveGeometry = enumeration(
          Ball "Ball valve",
          Diaphragm "Diaphragm valve",
          Butterfly "Butterfly valve",
          Gate "Gate valve",
          Sluice "Sluice valve");
      type ValveCoefficient = enumeration(
          AV "Av (metric) flow coefficient",
          KV "Kv (metric) flow coefficient",
          CV "Cv (US) flow coefficient",
          OP "Av defined by operating point");
      type FluidFlowRegime = enumeration(
          Laminar "Laminar fluid flow regime",
          Overall "Overall fluid flow regime",
          Turbulent "Turbulent fluid flow regime");
      type HTXGeometry_flatTubes = enumeration(
          LouverFin "Louver fin",
          RectangularFin "Rectangular offset strip fin");
      type HTXGeometry_roundTubes = enumeration(
          PlainFin "Plain fin",
          LouverFin "Louver fin",
          SlitFin "Slit fin",
          WavyFin "Wavy fin (Herringbone wavy fin)");

    end Types;
  end Utilities;
annotation (
  preferedView="info",
  classOrder={"UsersGuide","Examples","HeatTransfer","PressureLoss","Utilities"},
  Documentation(info="<html>
<img src=\"modelica://Modelica/Resources/Images/FluidDissipation/FD2.png\">


<h2> <font color=\"#EF9B13\"> Library description </font></h2>

This library contains <b>convective heat transfer</b> and  <b>pressure loss</b> functions written in
Modelica&reg;. Generally the pressure loss calculations are based on incompressible fluids and total pressure difference. For devices with non changing cross sectional area, the calculated total pressure loss is equal to the static pressure difference. Geodetic pressure loss is not considered throughout the library. The functions supplied may be used separately.<br>
<br>
The library is a non-commercial product of XRG Simulation GmbH. It makes use of external,
non-commercial models supplied by Modelica Standard Library. In order to work correctly,
ensure that this library is always loaded with <b> Modelica Standard Library version
3.1</b> especially to be able to use Modelica.Fluid applications.<br>

<h2> <font color=\"#EF9B13\"> Acknowledgements </font></h2>
The following people contributed to the Fluid.Dissipation library (alphabetical list):
J&ouml;rg Eiden, Ole Engel, Nina Peci, Sven Rutkowski, Thorben Vahlenkamp, Stefan
Wischhusen.

<p>
The development of the Fluid.Dissipation library is founded within the ITEA research
project EuroSysLib-D by German Federal Ministry of Education and Research (promotional
reference 01IS07022B). The project is started in October 2007 and will end in March 2010.
</p>

<h2> <font color=\"#EF9B13\"> Licence condition </font></h2>
<p>
<b>Licensed by XRG-Simulation GmbH under the Modelica License 2</b><br>
Copyright &copy; 2007-2010, XRG Simulation GmbH.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

<h2> <font color=\"#EF9B13\"> Contact </font></h2>

XRG Simulation GmbH<br>
Harburger Schlossstrasse 6-12<br>
21079 Hamburg<br>
Germany<br>
<br>
<a href=mailto:info@xrg-simulation.de>info@xrg-simulation.de</a> </html>

"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics));
end Dissipation;