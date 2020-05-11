within Modelica.Fluid;
package Dissipation
  "Functions for convective heat transfer and pressure loss characteristics"
    extends Modelica.Icons.BasesPackage;
  import PI = Modelica.Constants.pi;
  import REC = Modelica.Fluid.Dissipation.Utilities.Records;
  import TYP = Modelica.Fluid.Dissipation.Utilities.Types;

  package UsersGuide "User's guide"
    extends Modelica.Icons.Information;
    class GettingStarted "Getting Started"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
The <strong>Fluid.Dissipation</strong> library provides convective heat transfer and pressure loss
(HTPL) correlations for a broad range of energy devices to build up thermohydraulic
energy systems.
</p>
<p>
This section introduces an implementation method for the integration of the provided HTPL
functions by Fluid.Dissipation into own application models. Additionally you can find
ready-to-use application models integrated into Modelica.Fluid as thermohydraulic
framework <a href=\"modelica://Modelica.Fluid.Fittings\"> (see
package Fittings)</a>.<br />
In the following the implementation method is described in 5 steps for a straight pipe as
example. Generally the implementation method can be used for all HTPL correlations
throughout the library in the same manner.
</p>

<h4>Step 1: Use/Create model with missing pressure loss correlation</h4>

<p>
All thermohydraulic systems using pressure loss calculations can be modelled for an <strong>
incompressible case</strong>, where the pressure loss (DP) is calculated in dependence of a
known mass flow rate (m_flow)
</p>
<blockquote><pre>
DP = f(m_flow,...)
</pre></blockquote>
<p>
or a <strong>compressible case</strong>, where the mass flow rate (M_FLOW) is calculated in
dependence of a known pressure loss (dp)
</p>
<blockquote><pre>
M_FLOW = f(dp,...).
</pre></blockquote>
<p>
In both cases one target variable (DP for the compressible or M_FLOW for the
incompressible case) is calculated as a function of the corresponding input variable
(m_flow or dp respectively). Both functions for these cases can be found in the library
for the pressure loss device of interest enlarged with a corresponding underscore
describing its intended use (functionname_MFLOW for compressible or functionname_DP for
incompressible calculation).
</p>
<p>
To create a simplified thermohydraulic model, the pressure loss (dp) and the mass flow
rate (M_FLOW) have to be defined as unknown variables and only a functional correlation
between them is still missing. Here the implementation for the compressible case of a
flow model will be explained as example.
</p>
<blockquote><pre>
 model straightPipe
  //compressible case M_FLOW = f(dp)
   SI.Pressure dp \"Input pressure loss\";
   SI.MassFlowRate M_FLOW \"Output mass flow rate\";
 end straightPipe

 equation
end straightPipe
</pre></blockquote>

<h4>Step 2: Choose pressure loss <strong>function</strong> of interest</h4>

<p>
The HTPL correlations are modelled with functions for several devices. The pressure loss
of a straight pipe to be modelled can be found by browsing through the <strong>
Fluid.Dissipation</strong> library and looking up the function of interest, here:
</p>
<blockquote><pre>
Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW
</pre></blockquote>

<p>
This HTPL correlation for the compressible case of a straight pipe have to be dragged and
dropped in the equation section of the <strong>equation layer</strong> of the model in Step 1.
</p>
<blockquote><pre>
model straightPipe
  //compressible case M_FLOW = f(dp)
  SI.Pressure dp \"Input pressure loss\";
  SI.MassFlowRate M_FLOW \"Output mass flow rate\";

equation
  Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_<strong>MFLOW</strong>
end straightPipe
</pre></blockquote>

<h4>Step 3: Choose corresponding pressure loss <strong>records</strong>
</h4>
<p>
The chosen function in Step 2 still needs its corresponding input values provided by
records. These input records are split into one for input parameters (e.g., for
geometry) and one for input variables (e.g., for fluid properties). The name of these
input records are identical with the corresponding function but with the extension <strong>
_IN_con</strong> for parameters and <strong>_IN_var</strong> for variables as input. These
corresponding input record for the chosen function have to be dragged and dropped on the
<strong>diagram layer</strong> of the model in Step 1.
</p>
<blockquote><pre>
  Input parameter record:
Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall<strong>_IN_con</strong> IN_con
  Input variable record:
Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall<strong>_IN_var</strong> IN_var
</pre></blockquote>
<p>
Now the equation layer of the model in Step 1 should look similar to the following
(without comments and annotation):
</p>
<blockquote><pre>
model straightPipe
  ...
  //records
  Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con <strong>IN_con</strong>;
  Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var <strong>IN_var</strong>;

equation
  Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW
end straightPipe
</pre></blockquote>

<h4>Step 4: Build function-record construction </h4>
<p>
Now the input record have to be assigned to the chosen function in the equation layer.
The resulting function-record implementation for the compressible case looks like the
following:
</p>
<blockquote><pre>
model straightPipe
   ...
  equation
  //compressible case
  M_FLOW = Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW(IN_con,IN_var,dp);
end straightPipe
</pre></blockquote>

<p>
Here the compressible case for the unknown mass flow rate (M_FLOW) is calculated by the
known pressure difference (dp) out of the interfaces of the thermohydraulic framework and
the input records (IN_con,IN_var) provide data like geometry and fluid properties for
example.
</p>
<h4>Step 5: Assign record variables </h4>
<p>
In the last step the variables of the input records for the function have to be assigned.
The assignment of the record variables can either be done directly in the record on the
diagram layer or in the equation layer.
The assignment of the input record in the equation layer results into the following
model:
</p>
<blockquote><pre>
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
</pre></blockquote>

<p>
If the implementation of a HTPL correlation is done in an existing application model, the
unknown variables out of Step 1 (M_FLOW and dp for compressible or DP and m_flow for
incompressible case) have to be adjusted to the model variables (typically the interface
variables). The implementation of HTPL correlation into <strong>Modelica.Fluid</strong> can be
found for <a href=\"modelica://Modelica.Fluid.Fittings\"> flow
models of several devices</a>.
</p>
 </html>"));
    end GettingStarted;

    class ReleaseNotes "Release notes"
      extends Modelica.Icons.ReleaseNotes;

      annotation (Documentation(info="<html>
<h4>Version 1.0 Beta 4-6, 2010-01-12</h4>

<p>
Fluid.Dissipation was improved for the release as follows:
</p>

<ul>
  <li>Changed structure for input records of all heat transfer and pressure loss
functions:
    <ul>
      <li>Reduced amount of input records for compressible and incompressible functions as well as for their combinational one to improve usability of library.</li>
      <li>Splitting input records of one function into one with parameters (e.g., for geometry) and one with variables (e.g., fluid properties) to ease work of IDE-solver.</li>
    </ul>
  </li>
  <li>Improved Modelica.Fluid application models for available heat transfer and pressure
loss functions:
  <ul>
    <li>Flattened inheritance with one base flow model for all energy devices.</li>
    <li>Implemented smooth state of fluid density and dynamic viscosity for reverse flow.</li>
  </ul>
  </li>
<li>Adaption of complete library due to structure change.</li>
</ul>

<h4>Version 1.0 Beta 3, 2009-07-03</h4>

<p>
Fluid.Dissipation was improved for the release as follows:
</p>

<ul>
<li>Changed flow models structure:<br>
Now that a future feature for the automatic choice of using either a mass flow rate (compressible case) or a pressure loss (incompressible case) function for calculation is supported if implemented by IDE. Due to that no manual selection of a compressible or incompressible calculation in the Modelica.Fluid flow models is possible anymore. Therefore nonlinear equations will be created from the Modelica.Fluid flow models, if the future feature is not supported and the mass flow rate is known at a fluid port instead of the pressure loss.
</li>
<li>Changed structure and amount of records used as input for function calls due to
changed structure of flow model.
</li>
<li>Changed structure of function calls due to changed structure of flow model.
</li>
<li>Finished validation of all available heat transfer and pressure loss functions.
</li>
<li>Included scripts for verification of all available heat transfer and pressure loss functions.
</li>
</ul>

<h4>Version 1.0 Beta 2, 2009-04-22</h4>

<p>
Fluid.Dissipation was improved for the release as follows:
</p>

<ul>
<li>Support of analytical Jacobians at inverse calculation of heat transfer and pressure loss functions.
</li>
<li>Included Modelica.Fluid application models for available heat transfer and pressure loss functions.
</li>
<li>Adaption of complete library to Modelica Standard nomenclature.</li>
</ul>

<h4>Version 1.0 Beta 1, 2008-10-08</h4>

Initial release of Fluid.Dissipation.

</html>"));
    end ReleaseNotes;

  class Contact "Contact"
    extends Modelica.Icons.Contact;
      annotation (Documentation(info="<html>
<h4>Library officer and co-author</h4>

<p>
<strong>Stefan Wischhusen</strong><br>
    XRG Simulation GmbH<br>
    Hamburg, Germany<br>
    email: <a href=\"mailto:wischhusen@xrg-simulation.de\">wischhusen@xrg-simulation.de</a>
</p>

<h4>Acknowledgements</h4>

<p>
The following people contributed to the Modelica.Fluid.Dissipation library (alphabetical list):
J&ouml;rg Eiden, Ole Engel, Nina Peci, Sven Rutkowski, Thorben Vahlenkamp, Stefan
Wischhusen.
</p>
<p>
The development of the Modelica.Fluid.Dissipation library was founded within the ITEA research
project EuroSysLib-D by German Federal Ministry of Education and Research (promotional
reference 01IS07022B). The project was started in October 2007 and ended in June 2010.
</p>
</html>"));
  end Contact;
    annotation (DocumentationClass=true, Documentation(info="<html>
<p>The User's Guide contains the following sub-sections:
</p>
<ul>
<li><a href=\"modelica://Modelica.Fluid.Dissipation.UsersGuide.GettingStarted\">Getting Started</a></li>
<li><a href=\"modelica://Modelica.Fluid.Dissipation.UsersGuide.ReleaseNotes\">Release notes</a></li>
<li><a href=\"modelica://Modelica.Fluid.Dissipation.UsersGuide.Contact\">Contact information</a></li>
</ul>
</html>"));
  end UsersGuide;

  package HeatTransfer "Package for calculation of heat transfer"
  extends Modelica.Icons.VariantsPackage;
    package Channel
    extends Modelica.Icons.VariantsPackage;

      function kc_evenGapLaminar
        "Mean heat transfer coefficient of even gap | laminar flow regime | considering boundary layer development | heat transfer at ONE or BOTH sides | identical and constant wall temperatures"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 6-10

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
        output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
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
      annotation(Inline=false, Documentation(info="<html>
<p>Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a laminar fluid flow through an even gap at different fluid flow and heat transfer situations. Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapLaminar\">See more information.</a></p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_evenGapLaminar;

      function kc_evenGapLaminar_KC
        "Mean heat transfer coefficient of even gap | laminar flow regime | considering boundary layer development | heat transfer at ONE or BOTH sides | identical and constant wall temperatures"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 6-10

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
        SI.ReynoldsNumber Re=(IN_var.rho*velocity*d_hyd/max(MIN, IN_var.eta));
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
        annotation(Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a laminar fluid flow through an even gap at different fluid flow and heat transfer situations.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapLaminar\">See more information.</a>
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_evenGapLaminar_KC;

      record kc_evenGapLaminar_IN_con
        "Input record for function kc_evenGapLaminar and kc_evenGapLaminar_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con;

        annotation (Documentation(info="<html>
<p>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar\"> kc_evenGapLaminar</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC\"> kc_evenGapLaminar_KC</a>.</p>
</html>"));
      end kc_evenGapLaminar_IN_con;

      record kc_evenGapLaminar_IN_var
        "Input record for function kc_evenGapLaminar and kc_evenGapLaminar_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var;

        annotation (Documentation(info="<html>
<p>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar\"> kc_evenGapLaminar</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC\"> kc_evenGapLaminar_KC</a>.</p>
</html>"));
      end kc_evenGapLaminar_IN_var;

      function kc_evenGapOverall
        "Mean heat transfer coefficient of even gap | overall flow regime | considering boundary layer development | heat transfer at ONE or BOTH sides | identical and constant wall temperatures | surface roughness"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 6-10

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
        output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
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

      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
            Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for an overall fluid flow through an even gap at different fluid flow and heat transfer situations. Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapOverall\">See more information.</a>
</p>
</html>"));
      end kc_evenGapOverall;

      function kc_evenGapOverall_KC
        "Mean heat transfer coefficient of even gap | overall flow regime | considering boundary layer development | heat transfer at ONE or BOTH sides | identical and constant wall temperatures | surface roughness"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 6-10

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
        SI.ReynoldsNumber Re=(IN_var.rho*velocity*d_hyd/max(MIN, IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        kc_evenGapTurbulent_IN_con IN_con_turb(h=IN_con.h,s=IN_con.s,L=IN_con.L);
      algorithm
        kc := SMOOTH(
                laminar,
                turbulent,
                Re)*Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC(
          IN_con, IN_var) + SMOOTH(
                turbulent,
                laminar,
                Re)*Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_KC(IN_con_turb,
          IN_var);
      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for an overall fluid flow through an even gap at different fluid flow and heat transfer situations. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapOverall\">See more information.</a>
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_evenGapOverall_KC;

      record kc_evenGapOverall_IN_con
        "Input record for function kc_evenGapOverall and kc_evenGapOverall_KC"

              //even gap variables
              extends
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.EvenGap;

              annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall\"> kc_evenGapOverall</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_KC\"> kc_evenGapOverall_KC</a>.
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
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall\"> kc_evenGapOverall</a> and
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_KC\"> kc_evenGapOverall_KC</a>.
</html>"));
      end kc_evenGapOverall_IN_var;

      function kc_evenGapTurbulent
        "Mean heat transfer coefficient of even gap | turbulent flow regime | developed fluid flow | heat transfer at BOTH sides | identical and constant wall temperatures"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 7

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
        output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
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
        Real fstatus[3] "Check of expected boundary conditions";

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
      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a developed turbulent fluid flow through an even gap at heat transfer from both sides. Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapTurbulent\">See more information.</a>
</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_evenGapTurbulent;

      function kc_evenGapTurbulent_KC
        "Mean heat transfer coefficient of even gap | turbulent flow regime | developed fluid flow | heat transfer at BOTH sides | identical and constant wall temperatures"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 7

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
          "Output for function kc_evenGapTurbulent_KC";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=max(MIN, IN_con.s*IN_con.h)
          "Cross sectional area of gap";
        SI.Diameter d_hyd=2*IN_con.s "Hydraulic diameter";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity in gap";
        SI.ReynoldsNumber Re=max(MIN,(IN_var.rho*velocity*d_hyd/max(MIN, IN_var.eta)));
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

      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a developed turbulent fluid flow through an even gap at heat transfer from both sides. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapTurbulent\">See more information.</a>
</p>
</html>",       revisions="<html>
<p>2016-04-12 Stefan Wischhusen: Limited Re to very small value (Modelica.Constant.eps).</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_evenGapTurbulent_KC;

      record kc_evenGapTurbulent_IN_con
        "Input record for function kc_evenGapTurbulent and kc_evenGapTurbulent_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con(
            final target=Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap.DevBoth);

        annotation (Documentation(info="<html>
<p>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent\"> kc_evenGapTurbulent</a> and
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_KC\"> kc_evenGapTurbulent_KC</a>.
</p>
</html>"));
      end kc_evenGapTurbulent_IN_con;

      record kc_evenGapTurbulent_IN_var
        "Input record for function kc_evenGapTurbulent and kc_evenGapTurbulent_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var;

        annotation (Documentation(info="<html>
<p>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent\"> kc_evenGapTurbulent</a> and
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_KC\"> kc_evenGapTurbulent_KC</a>.
</p>
</html>"));
      end kc_evenGapTurbulent_IN_var;
    annotation (preferredView="info", Documentation(info="<html>
<h4>Even gap</h4>
<h5>Laminar flow</h5>
<p>Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a laminar fluid flow through an even gap at different fluid flow and heat transfer situations. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapLaminar\">See more information.</a></p>

<h5>Turbulent flow</h5>
<p>Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a laminar fluid flow through an even gap at different fluid flow and heat transfer situations. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapTurbulent\">See more information.</a></p>

<h5>Overall flow</h5>
<p>Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a laminar fluid flow through an even gap at different fluid flow and heat transfer situations. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapOverall\">See more information.</a></p>
</html>"));
    end Channel;

    package General
    extends Modelica.Icons.VariantsPackage;
      function kc_approxForcedConvection
        "Mean convective heat transfer coefficient for forced convection | approximation | turbulent regime | hydrodynamically developed fluid flow"
        extends Modelica.Icons.Function;
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
        output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
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

      annotation (Inline=false, Documentation(info="<html>
<p>
Approximate calculation of the mean convective heat transfer coefficient <strong>kc</strong> for forced convection with a fully developed fluid flow in a turbulent regime.
</p>

<p>
A detailed documentation for this convective heat transfer calculation can be found in its underlying function
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_KC\">kc_approxForcedConvection_KC</a> .
Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled.  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.General.kc_approxForcedConvection\">See more information</a> .
</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_approxForcedConvection;

      function kc_approxForcedConvection_KC
        "Mean convective heat transfer coefficient for forced convection | approximation | turbulent regime | hydrodynamically developed fluid flow"
        extends Modelica.Icons.Function;
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
        SI.ReynoldsNumber Re=(4*abs(IN_var.m_flow)/max(MIN, IN_con.perimeter*
            IN_var.eta)) "Reynolds number";

      algorithm
        kc := IN_var.lambda/d_hyd*(if IN_con.target == TYP.Rough then 0.023*Re^(4/5)*
          Pr^IN_con.exp_Pr else if IN_con.target == TYP.Middle then 0.023*Re^(4/5)*Pr
          ^(1/3)*(IN_var.eta/IN_var.eta_wall)^0.14 else if IN_con.target == TYP.Finest and Pr
           <= 1.5 then 0.0214*max(1, abs(Re^0.8 - 100))*Pr^0.4 else if IN_con.target
           == TYP.Finest then 0.012*max(1, abs(Re^0.87 - 280))*Pr^0.4 else 0);

        //Documentation

      annotation (Inline=false, Documentation(info="<html>
<p>
Approximate calculation of the mean convective heat transfer coefficient <strong>kc</strong> for forced convection with a fully developed fluid flow in a turbulent regime.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.General.kc_approxForcedConvection\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_approxForcedConvection_KC;

      record kc_approxForcedConvection_IN_con
        "Input record for function kc_approxForcedConvection and kc_approxForcedConvection_KC"
        //generic variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.General;
        parameter Real exp_Pr=0.4
      "Exponent for Prandtl number w.r.t. Dittus/Boelter | 0.4 for heating | 0.3 for cooling"
      annotation (Dialog(group="Generic variables",enable=target == Modelica.Fluid.Dissipation.Utilities.Types.kc_general.Rough));

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection\"> kc_approxForcedConvection</a> and
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_KC\"> kc_approxForcedConvection_KC</a>.
</html>", revisions="<html>
2016-06-06 Stefan Wischhusen: Corrected enable in dialog.
</html>"));
      end kc_approxForcedConvection_IN_con;

      record kc_approxForcedConvection_IN_var
        "Input record for function kc_approxForcedConvection and kc_approxForcedConvection_KC"
        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;
        SI.DynamicViscosity eta_wall
          "Dynamic viscosity of fluid at wall temperature" annotation (Dialog(group=
                "Fluid properties", enable= target == 2));

        //input variable (mass flow rate)
        SI.MassFlowRate m_flow annotation (Dialog(group="Input"));

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection\"> kc_approxForcedConvection</a> and
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_KC\"> kc_approxForcedConvection_KC</a>.
</html>"));
      end kc_approxForcedConvection_IN_var;
    annotation (preferredView="info", Documentation(info="<html>
<h4>General heat transfer</h4>
<h5>Approximated forced convection</h5>
<p>Approximate calculation of the mean convective heat transfer coefficient <strong>kc</strong> for forced convection with a fully developed fluid flow in a turbulent regime. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.General.kc_approxForcedConvection\">See more information.</a></p>
</html>"));
    end General;

    package HeatExchanger
    extends Modelica.Icons.VariantsPackage;
      function kc_flatTube
        extends Modelica.Icons.Function;
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
        output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
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
          Re := abs(IN_var.m_flow)*IN_con.L_p/(IN_var.eta*A_c);
          Nu := max(1e-3, kc*IN_con.L_p/IN_var.lambda);
        elseif IN_con.geometry == TYP.RectangularFin then
          Re := abs(IN_var.m_flow)*IN_con.D_h/(IN_var.eta*A_c);
          Nu := max(1e-3, kc*IN_con.D_h/IN_var.lambda);
        end if;

        failureStatus := if IN_con.geometry == TYP.LouverFin then if Re < 100 or Re
           > 3000 then 1 else 0 else if IN_con.geometry == TYP.RectangularFin then
          if Re < 300 or Re > 5000 then 1 else 0 else 0;

      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for the air-side heat transfer of heat exchangers with flat tubes and several fin geometries. Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HeatExchanger.kc_flatTube\">See more information</a> .
</p>

</html>",       revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_flatTube;

      function kc_flatTube_KC
        extends Modelica.Icons.Function;
        //SOURCE: A.M. Jacobi, Y. Park, D. Tafti, X. Zhang. AN ASSESSMENT OF THE STATE OF THE ART, AND POTENTIAL DESIGN IMPROVEMENTS, FOR FLAT-TUBE HEAT EXCHANGERS IN AIR CONDITIONING AND REFRIGERATION APPLICATIONS - PHASE I

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

        SI.ReynoldsNumber Re_Dh=max(MIN, (abs(IN_var.m_flow)*IN_con.D_h/(IN_var.eta*
            A_c))) "Reynolds number based on hydraulic diameter";
        SI.ReynoldsNumber Re_Lp=max(MIN, (abs(IN_var.m_flow)*IN_con.L_p/(IN_var.eta*
            A_c))) "Reynolds number based on louver pitch";
        SI.PrandtlNumber Pr=IN_var.eta*IN_var.cp/IN_var.lambda "Prandtl number";
        Real j "Colburn j factor";

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

      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for the air-side heat transfer of heat exchangers with flat tubes and several fin geometries.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HeatExchanger.kc_flatTube\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-12 Stefan Wischhusen: Limited Re_Dh und Re_Lp to very small value (Modelica.Constant.eps).</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_flatTube_KC;

      record kc_flatTube_IN_con
        "Input record for function kc_flatTube and kc_flatTube_KC"
        extends Modelica.Icons.Record;

        Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_flatTubes
          geometry = Dissipation.Utilities.Types.HTXGeometry_flatTubes.LouverFin
          "Choice of fin geometry" annotation (Dialog(group="Heat exchanger"));

        SI.Area A_fr=0 "Frontal area" annotation (Dialog(group="Heat exchanger"));
        SI.Length D_h=0 "Hydraulic diameter" annotation (Dialog(group="Heat exchanger",
              enable= geometry == 2));
        SI.Length D_m=0 "Major tube diameter for flat tube"
          annotation (Dialog(group="Heat exchanger"));
        SI.Length F_l=0 "Fin length" annotation (Dialog(group="Heat exchanger", enable=
               geometry == 1));
        SI.Length F_p=0 "Fin pitch, fin spacing + fin thickness" annotation (Dialog(
              group="Heat exchanger", enable= geometry == 1));
        SI.Length L_l=0 "Louver length" annotation (Dialog(group="Heat exchanger",
              enable= geometry == 1));
        SI.Length L_p=0 "Louver pitch" annotation (Dialog(group="Heat exchanger",
              enable= geometry == 1));
        SI.Length T_d=0 "Tube depth" annotation (Dialog(group="Heat exchanger", enable=
               geometry == 1));
        SI.Length T_p=0 "Tube pitch" annotation (Dialog(group="Heat exchanger", enable=
               geometry == 1));

        Real alpha=0 "Lateral fin spacing (s) / free flow height (h)" annotation (
            Dialog(group="Heat exchanger", enable= geometry == 2));
        Real gamma=0 "Fin thickness (t) / lateral fin spacing (s)" annotation (Dialog(
              group="Heat exchanger", enable= geometry == 2));
        Real delta=0 "Fin thickness (t) / Fin length (l)" annotation (Dialog(group=
                "Heat exchanger", enable= geometry == 2));
        SI.Length delta_f=0 "Fin thickness" annotation (Dialog(group="Heat exchanger",
              enable= geometry == 1));
        SI.Angle Phi=0 "Louver angle" annotation (Dialog(group="Heat exchanger",
              enable= geometry == 1));

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube\"> kc_flatTube</a> and
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_KC\"> kc_flatTube_KC</a>.
</html>"));

      end kc_flatTube_IN_con;

      record kc_flatTube_IN_var
        "Input record for function kc_flatTube and kc_flatTube_KC"
        extends Modelica.Icons.Record;

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;

        //input variable (mass flow rate)
        SI.MassFlowRate m_flow annotation (Dialog(group="Input"));

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube\"> kc_flatTube</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_KC\"> kc_flatTube_KC</a>.
</html>"));

      end kc_flatTube_IN_var;

      function kc_roundTube
        extends Modelica.Icons.Function;
        //SOURCE: A.M. Jacobi, Y. Park, D. Tafti, X. Zhang. AN ASSESSMENT OF THE STATE OF THE ART, AND POTENTIAL DESIGN IMPROVEMENTS, FOR FLAT-TUBE HEAT EXCHANGERS IN AIR CONDITIONING AND REFRIGERATION APPLICATIONS - PHASE I

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
        output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
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
          Re := abs(IN_var.m_flow)*IN_con.D_c/(IN_var.eta*A_c);
          Nu := max(1e-3, kc*IN_con.D_c/IN_var.lambda);
        end if;

        failureStatus := if IN_con.geometry == TYP.PlainFin then if Re < 300 or Re >
          8000 then 1 else 0 else if IN_con.geometry == TYP.LouverFin then if Re <
          300 or Re > 7000 then 1 else 0 else if IN_con.geometry == TYP.SlitFin then
          if Re < 400 or Re > 7000 then 1 else 0 else if IN_con.geometry == TYP.WavyFin then
                if Re < 350 or Re > 7000 then 1 else 0 else 0;

      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for the air-side heat transfer of heat exchangers with round tubes and several fin geometries. Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HeatExchanger.kc_roundTube\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_roundTube;

      function kc_roundTube_KC
        extends Modelica.Icons.Function;
        //SOURCE: A.M. Jacobi, Y. Park, D. Tafti, X. Zhang. AN ASSESSMENT OF THE STATE OF THE ART, AND POTENTIAL DESIGN IMPROVEMENTS, FOR FLAT-TUBE HEAT EXCHANGERS IN AIR CONDITIONING AND REFRIGERATION APPLICATIONS - PHASE I

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

        SI.ReynoldsNumber Re_Dc=max(MIN, (abs(IN_var.m_flow)*IN_con.D_c/(IN_var.eta*
            A_c))) "Reynolds number based on fin collar diameter";

        SI.ReynoldsNumber Re_i "Reynolds number at transition to linearized calculation for wavy fins";

        SI.PrandtlNumber Pr=IN_var.eta*IN_var.cp/IN_var.lambda "Prandtl number";
        Real j "Colburn j factor";

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

        Real J1=0 "Exponent for computation of Colburn j factor";
        Real J2=0 "Exponent for computation of Colburn j factor";
        Real J3=0 "Exponent for computation of Colburn j factor";
        Real J4=0 "Exponent for computation of Colburn j factor";
        Real J5=0 "Exponent for computation of Colburn j factor";
        Real J6=0 "Exponent for computation of Colburn j factor";
        Real J7=0 "Exponent for computation of Colburn j factor";
        Real J8=0 "Exponent for computation of Colburn j factor";

      algorithm
        if IN_con.geometry == TYP.PlainFin then
          j := 0.991*(2.24*Re_Dc^(-0.092)*(IN_con.N/4)^(-0.031))^(0.607*(4 - IN_con.N))
            *(0.14*Re_Dc^(-0.328)*(IN_con.P_t/IN_con.P_l)^(-0.502)*(IN_con.F_p/IN_con.D_c)
            ^(0.0312))*(2.55*(IN_con.P_l/IN_con.D_c)^(-1.28));
          kc := j*(Re_Dc*Pr^(1/3)*IN_var.lambda/IN_con.D_c);

        elseif IN_con.geometry == TYP.LouverFin then
          if Re_Dc < 900 then
            J1 := -0.991 - 0.1055*(IN_con.P_l/IN_con.P_t)^3.1*log(IN_con.L_h/IN_con.L_p);
            J2 := -0.7344 + 2.1059*IN_con.N^0.55/(log(Re_Dc) - 3.2);
            J3 := 0.08485*(IN_con.P_l/IN_con.P_t)^(-4.4)*IN_con.N^(-0.68);
            J4 := -0.1741*log(IN_con.N);
            j := 14.3117*Re_Dc^J1*(IN_con.F_p/IN_con.D_c)^J2*(IN_con.L_h/IN_con.L_p)^
              J3*(IN_con.F_p/IN_con.P_l)^J4*(IN_con.P_l/IN_con.P_t)^(-1.724);
          elseif Re_Dc > 1100 then
            J5 := -0.6027 + 0.02593*(IN_con.P_l/D_h)^0.52*IN_con.N^(-0.5)*log(IN_con.L_h
              /IN_con.L_p);
            J6 := -0.4776 + 0.40774*IN_con.N^0.7/(log(Re_Dc) - 4.4);
            J7 := -0.58655*(IN_con.F_p/D_h)^2.3*(IN_con.P_l/IN_con.P_t)^(-1.6)*IN_con.N
              ^(-0.65);
            J8 := 0.0814*(log(Re_Dc) - 3);
            j := 1.1373*Re_Dc^J5*(IN_con.F_p/IN_con.P_l)^J6*(IN_con.L_h/IN_con.L_p)^
              J7*(IN_con.P_l/IN_con.P_t)^J8*IN_con.N^0.3545;
          else
            J1 := -0.991 - 0.1055*(IN_con.P_l/IN_con.P_t)^3.1*log(IN_con.L_h/IN_con.L_p);
            J2 := -0.7344 + 2.1059*IN_con.N^0.55/(log(Re_Dc) - 3.2);
            J3 := 0.08485*(IN_con.P_l/IN_con.P_t)^(-4.4)*IN_con.N^(-0.68);
            J4 := -0.1741*log(IN_con.N);
            J5 := -0.6027 + 0.02593*(IN_con.P_l/D_h)^0.52*IN_con.N^(-0.5)*log(IN_con.L_h
              /IN_con.L_p);
            J6 := -0.4776 + 0.40774*IN_con.N^0.7/(log(Re_Dc) - 4.4);
            J7 := -0.58655*(IN_con.F_p/D_h)^2.3*(IN_con.P_l/IN_con.P_t)^(-1.6)*IN_con.N
              ^(-0.65);
            J8 := 0.0814*(log(Re_Dc) - 3);
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
          J1 := -0.674 + 0.1316*IN_con.N/log(Re_Dc) - 0.3769*IN_con.F_p/IN_con.D_c -
            1.8857*IN_con.N/Re_Dc;
          J2 := -0.0178 + 0.996*IN_con.N/log(Re_Dc) + 26.7*IN_con.N/Re_Dc;
          J3 := 1.865 + 1244.03*IN_con.F_p/(Re_Dc*IN_con.D_c) - 14.37/log(Re_Dc);
          j := 1.6409*Re_Dc^J1*(IN_con.S_p/IN_con.S_h)^1.16*(IN_con.P_t/IN_con.P_l)^
            1.37*(IN_con.F_p/IN_con.D_c)^J2*IN_con.N^J3;
          kc := j*(Re_Dc*Pr^(1/3)*IN_var.lambda/IN_con.D_c);

        elseif IN_con.geometry == TYP.WavyFin then
          Re_i := 2*exp(2.921)^(1/(A_c/IN_con.A_fr)); // 2 * turning point of the not linearized kc calculation
          if Re_Dc > Re_i then
            // original calculation
            j := 1.201/((Modelica.Math.log(Re_Dc^(A_c/IN_con.A_fr)))^2.921);
          else
            // linearized calculation to avoid increasing of kc for low Reynolds numbers and division by zero for Re = 1
            j := (Re_Dc-Re_i)*(-1.201*2.921*(A_c/IN_con.A_fr)/((Modelica.Math.log(Re_i^(A_c/IN_con.A_fr)))^3.921*Re_i)) + 1.201/((Modelica.Math.log(Re_i^(A_c/IN_con.A_fr)))^2.921);
          end if;
          kc := j*(Re_Dc*Pr^(1/3)*IN_var.lambda/IN_con.D_c);

        else

        end if;

      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for the air-side heat transfer of heat exchangers with round tubes and several fin geometries.<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HeatExchanger.kc_roundTube\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Sven Rutkowski: Removed singularity for Re at zero mass flow rate through linearized function in wavy fin correlation.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_roundTube_KC;

      record kc_roundTube_IN_con
        "Input record for function kc_roundTube and kc_roundTube_KC"
        extends Modelica.Icons.Record;

        Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_roundTubes
          geometry = Dissipation.Utilities.Types.HTXGeometry_roundTubes.PlainFin
          "Choice of fin geometry" annotation (Dialog(group="Heat exchanger"));

        SI.Area A_fr=0 "Frontal area" annotation (Dialog(group="Heat exchanger"));
        SI.Length D_c=0 "Fin collar diameter"
          annotation (Dialog(group="Heat exchanger"));
        SI.Length F_p=0 "Fin pitch, fin spacing + fin thickness"
          annotation (Dialog(group="Heat exchanger"));
        SI.Length L=0 "Heat exchanger length" annotation (Dialog(group=
                "Heat exchanger", enable= geometry == 2));
        SI.Length L_h=0 "Louver height" annotation (Dialog(group="Heat exchanger",
              enable= geometry == 2));
        SI.Length L_p=0 "Louver pitch" annotation (Dialog(group="Heat exchanger",
              enable= geometry == 2));
        Integer N=0 "Number of tube rows" annotation (Dialog(group="Heat exchanger",
              enable= (geometry == 1 or geometry == 2 or geometry == 3)));
        SI.Length P_d=0 "Pattern depth of wavy fin, wave height" annotation (Dialog(
              group="Heat exchanger", enable= geometry == 4));
        SI.Length P_l=0 "Longitudinal tube pitch" annotation (Dialog(group=
                "Heat exchanger", enable= (geometry == 1 or geometry == 2 or geometry == 3)));
        SI.Length P_t=0 "Transverse tube pitch"
          annotation (Dialog(group="Heat exchanger"));
        SI.Length S_h=0 "Slit height" annotation (Dialog(group="Heat exchanger",
              enable= geometry == 3));
        SI.Length S_p=0 "Slit pitch" annotation (Dialog(group="Heat exchanger", enable=
               geometry == 3));
        SI.Length X_f=0 "Half wave length of wavy fin" annotation (Dialog(group=
                "Heat exchanger", enable= geometry == 4));

        SI.Length delta_f=0 "Fin thickness" annotation (Dialog(group="Heat exchanger"));

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube\"> kc_roundTube</a> and
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_KC\"> kc_roundTube_KC</a>.
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
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube\"> kc_roundTube</a> and
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_KC\"> kc_roundTube_KC</a>.
</html>"));

      end kc_roundTube_IN_var;
    annotation (preferredView="info", Documentation(info="<html>
<h4>Heat exchanger</h4>
<h5>Flat tube heat exchanger</h5>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for the air-side heat transfer of heat exchangers with flat tubes and several fin geometries.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HeatExchanger.kc_flatTube\">See more information</a> .
</p>

<h5>Round tube heat exchanger</h5>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for the air-side heat transfer of heat exchangers with round tubes and several fin geometries.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HeatExchanger.kc_roundTube\">See more information</a> .
</p>
</html>"));
    end HeatExchanger;

    package HelicalPipe
    extends Modelica.Icons.VariantsPackage;
      function kc_laminar
        "Mean heat transfer coefficient of helical pipe | laminar flow regime"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //Notation of equations according to SOURCE

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
        output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
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
        Re := abs(IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta));
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
        annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a helical pipe in the laminar flow regime. Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_laminar\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_laminar;

      function kc_laminar_KC
        "Mean heat transfer coefficient of helical pipe | hydrodynamically developed laminar flow regime"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //Notation of equations according to SOURCE

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
        SI.ReynoldsNumber Re=(IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        Real m=0.5 + 0.2903*(IN_con.d_hyd/d_coil)^0.194
          "Exponent for actual Reynolds number";

        //Documentation
      algorithm
        kc := (IN_var.lambda/IN_con.d_hyd)*(3.66 + 0.08*(1 + 0.8*(IN_con.d_hyd/d_coil)
          ^0.9)*Re^(m)*Pr^(1/3));
      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a helical pipe in the laminar flow regime.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_laminar\">See more information</a> .
</p>
</html>", revisions="<html>
<blockquote><pre>2016-04-12 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate. </pre></blockquote>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_laminar_KC;

      record kc_laminar_IN_con
        "Input record for function kc_laminar and kc_laminar_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con;

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar\"> kc_laminar</a> and
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_KC\"> kc_laminar_KC</a>.
</html>"));
      end kc_laminar_IN_con;

      record kc_laminar_IN_var
        "Input record for function kc_laminar and kc_laminar_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var;

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar\"> kc_laminar</a> and
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_KC\"> kc_laminar_KC</a>.
</html>"));
      end kc_laminar_IN_var;

      function kc_overall
        "Mean heat transfer coefficient of helical pipe | overall flow regime"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //Notation of equations according to SOURCE

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
        output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
          annotation (Dialog(group="Output"));

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Cross sectional area";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity";

        //Documentation
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
        Re := (IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_KC(IN_con, IN_var);
        Nu := kc*IN_con.d_hyd/max(MIN, IN_var.lambda);

        failureStatus := 0;
      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> of a helical pipe in a hydrodynamically developed laminar and turbulent flow regime. Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_overall\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_overall;

      function kc_overall_KC
        "Mean heat transfer coefficient of helical pipe | overall flow regime"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //Notation of equations according to SOURCE

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
        SI.ReynoldsNumber Re=(IN_var.rho*velocity*IN_con.d_hyd/max(MIN,
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
      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> of a helical pipe in a hydrodynamically developed laminar and turbulent flow regime.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_overall\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_overall_KC;

      record kc_overall_IN_con
        "Input record for function kc_overall and kc_overall_KC"

        //helical pipe variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.HelicalPipe;

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall\"> kc_overall</a> and
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_KC\"> kc_overall_KC</a>.
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
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall\"> kc_overall</a> and
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_KC\"> kc_overall_KC</a>.
</html>"));
      end kc_overall_IN_var;

      function kc_turbulent
        "Mean heat transfer coefficient of helical pipe | hydrodynamically developed turbulent flow regime"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //Notation of equations according to SOURCE

        //input records
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_con
          IN_con "Input record for function kc_turbulent"
          annotation (Dialog(group="Constant inputs"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_var
          IN_var "Input record for function kc_turbulent"
          annotation (Dialog(group="Variable inputs"));

        //output variables
        output SI.CoefficientOfHeatTransfer kc
          "Convective heat transfer coefficient"
          annotation (Dialog(group="Output"));
        output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
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
        Re := abs(IN_var.rho*velocity*IN_con.d_hyd/IN_var.eta);
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
      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> of a helical pipe for turbulent flow regime. Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_turbulent\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_turbulent;

      function kc_turbulent_KC
        "Mean heat transfer coefficient of helical pipe | hydrodynamically developed turbulent flow regime"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //Notation of equations according to SOURCE

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
        SI.ReynoldsNumber Re=(IN_var.rho*velocity*IN_con.d_hyd/max(MIN,
            IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        Real zeta_TOT=0.3164*max(turbulent, Re)^(-0.25) + 0.03*sqrt(IN_con.d_hyd/
            d_coil) "Pressure loss coefficient";

        //Documentation
      algorithm
        kc := (IN_var.lambda/IN_con.d_hyd)*(zeta_TOT/8)*Re*Pr/(1 + 12.7*sqrt(zeta_TOT
          /8)*(Pr^(2/3) - 1));
      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> of a helical pipe for turbulent flow regime.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_turbulent\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_turbulent_KC;

      record kc_turbulent_IN_con
        "Input record for function kc_turbulent and kc_turbulent_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con;

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent\">  kc_turbulent</a> and
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_KC\">  kc_turbulent_KC</a>.
</html>"));
      end kc_turbulent_IN_con;

      record kc_turbulent_IN_var
        "Input record for function kc_turbulent and kc_turbulent_KC"

        extends
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var;

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent\">  kc_turbulent</a> and
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_KC\">  kc_turbulent_KC</a>.
</html>"));
      end kc_turbulent_IN_var;
    annotation (preferredView="info", Documentation(info="<html>
<h4>Helical pipe</h4>
<h5>Laminar flow</h5>
<p>Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a helical pipe in the laminar flow regime.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_laminar\">See more information</a>.</p>

<h5>Turbulent flow</h5>
<p>Calculation of the mean convective heat transfer coefficient <strong>kc</strong> of a helical pipe for turbulent flow regime.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_turbulent\">See more information</a>.</p>

<h5>Overall flow</h5>
<p>Calculation of the mean convective heat transfer coefficient <strong>kc</strong> of a helical pipe in a hydrodynamically developed laminar and turbulent flow regime.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_overall\">See more information</a>.</p>
</html>"));
    end HelicalPipe;

    package Plate
    extends Modelica.Icons.VariantsPackage;

      function kc_laminar
        "Mean heat transfer coefficient of plate | laminar regime"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //Notation of equations according to SOURCE

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
        output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
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
        Re := abs(IN_var.rho*IN_var.velocity*IN_con.L/max(MIN, IN_var.eta));
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
      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a laminar fluid flow over an even surface. Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_laminar\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_laminar;

      function kc_laminar_KC
        "Mean heat transfer coefficient of plate | laminar regime"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //Notation of equations according to SOURCE

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
        SI.ReynoldsNumber Re=(rho*velocity*L/eta);
        SI.PrandtlNumber Pr=eta*cp/lambda;

        //Documentation
      algorithm
        kc := (lambda/L)*(0.664*abs(Re)^0.5*Pr^(1/3));
      annotation (Inline=true, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a laminar fluid flow over an even surface.
Generally this function is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known fluid velocity.
 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_laminar\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_laminar_KC;

      record kc_laminar_IN_con
        "Input record for function kc_laminar and kc_laminar_KC"
        extends Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_con;

      annotation (Documentation(info="<html>
<p>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar\">  kc_laminar</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_KC\">  kc_laminar_KC</a>.
</p>
</html>"));
      end kc_laminar_IN_con;

      record kc_laminar_IN_var
        "Input record for function kc_laminar and kc_laminar_KC"
        extends Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_var;

      annotation (Documentation(info="<html>
<p>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar\">  kc_laminar</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_KC\">  kc_laminar_KC</a>.
</p>
</html>"));
      end kc_laminar_IN_var;

      function kc_overall
        "Mean heat transfer coefficient of even plate | overall regime | constant wall temperature"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //Notation of equations according to SOURCE

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
        output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
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
        Re := abs(IN_var.rho*IN_var.velocity*IN_con.L/max(MIN, IN_var.eta));
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
      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a laminar or turbulent fluid flow over an even surface. Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled.  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_overall\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_overall;

      function kc_overall_KC
        "Mean heat transfer coefficient of even plate | overall regime | constant wall temperature"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //Notation of equations according to SOURCE

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
      annotation (Inline=true, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a laminar or turbulent fluid flow over an even surface.
Generally this function is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known fluid velocity.
 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_overall\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_overall_KC;

      record kc_overall_IN_con
        "Input record for function kc_overall and function kc_overall_KC"
        //plate variables
        extends Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.Plate;

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall\"> kc_overall</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_KC\"> kc_overall_KC</a>.
</html>"));
      end kc_overall_IN_con;

      record kc_overall_IN_var
        "Input record for function kc_overall and function kc_overall_KC"
        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;

        //input variable (fluid flow velocity)
        SI.Velocity velocity annotation (Dialog(group="Input"));

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall\"> kc_overall</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_KC\"> kc_overall_KC</a>.
</html>"));
      end kc_overall_IN_var;

      function kc_turbulent
        "Mean heat transfer coefficient of even plate | turbulent regime | constant wall temperature"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //Notation of equations according to SOURCE

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
        output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
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
        Re := abs(IN_var.rho*IN_var.velocity*IN_con.L/max(MIN, IN_var.eta));
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
      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a hydrodynamically developed turbulent fluid flow over an even surface. Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled.  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_turbulent\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_turbulent;

      function kc_turbulent_KC
        "Mean heat transfer coefficient of even plate | turbulent regime | constant wall temperature"
        extends Modelica.Icons.Function;
        //SOURCE: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //Notation of equations according to SOURCE

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
        SI.ReynoldsNumber Re=abs(rho*velocity*L/eta);
        SI.PrandtlNumber Pr=abs(eta*cp/lambda);

        //Documentation
      algorithm
        kc := abs((lambda/L))*(0.037*Re^0.8*Pr)/(1 + 2.443/(max(Re^0.1, 1e-6))*(Pr^(2
          /3) - 1));
      annotation (Inline=true, Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a hydrodynamically developed turbulent fluid flow over an even surface.
Generally this function is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known fluid velocity.
 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_turbulent\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_turbulent_KC;

      record kc_turbulent_IN_con
        "Input record for function kc_turbulent and kc_turbulent_KC"
        extends Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_con;

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent\">  kc_turbulent</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_KC\">  kc_turbulent_KC</a>.
</html>"));
      end kc_turbulent_IN_con;

      record kc_turbulent_IN_var
        "Input record for function kc_turbulent and kc_turbulent_KC"
        extends Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_var;

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent\">  kc_turbulent</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_KC\">  kc_turbulent_KC</a>.
</html>"));
      end kc_turbulent_IN_var;
      annotation (preferredView="info", Documentation(info="<html>
<h4>Even plate</h4>
<h5>Laminar flow</h5>
<p>Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a laminar fluid flow over an even surface. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_laminar\">See more information</a> .</p>

<h5>Turbulent flow</h5>
<p>Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a hydrodynamically developed turbulent fluid flow over an even surface. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_turbulent\">See more information</a>.</p>

<h5>Overall flow</h5>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for an laminar and turbulent fluid flow over an even surface. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_overall\">See more information</a>.
</p>
</html>"));
    end Plate;

    package StraightPipe
    extends Modelica.Icons.VariantsPackage;

      function kc_laminar
        "Mean heat transfer coefficient of straight pipe | uniform wall temperature or uniform heat flux | hydrodynamically developed or undeveloped laminar flow regime"
        extends Modelica.Icons.Function;
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
        output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
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
        Real fstatus[2] "Check of expected boundary conditions";

        //Documentation
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
        Re := (IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta));
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
      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of mean convective heat transfer coefficient <strong>kc</strong> of a straight pipe at an uniform wall temperature <strong>or</strong> uniform heat flux <strong>and</strong> for a hydrodynamically developed <strong>or</strong> undeveloped laminar fluid flow. Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled.  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_laminar\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_laminar;

      function kc_laminar_KC
        "Mean heat transfer coefficient of straight pipe | uniform wall temperature or uniform heat flux | hydrodynamically developed or undeveloped laminar flow regime"
        extends Modelica.Icons.Function;
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
        SI.ReynoldsNumber Re=(IN_var.rho*velocity*IN_con.d_hyd/max(MIN,
            IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        SI.NusseltNumber Nu2=if IN_con.target == TYP.UWTuDFF or IN_con.target == TYP.UWTuUFF then
                  1.615*(Re*Pr*IN_con.d_hyd/IN_con.L)^(1/3) else if IN_con.target ==
            TYP.UHFuDFF or IN_con.target == TYP.UHFuUFF then 1.953*(Re*Pr*IN_con.d_hyd
            /IN_con.L)^(1/3) else 0 "Help variable for mean Nusselt number";
        SI.NusseltNumber Nu3=if IN_con.target == TYP.UWTuUFF then (2/(1 + 22*Pr))^(1/
            6)*(Re*Pr*IN_con.d_hyd/IN_con.L)^0.5 else if IN_con.target == TYP.UHFuUFF then
                  0.924*(Pr^(1/3))*(Re*IN_con.d_hyd/IN_con.L)^(1/2) else 0
          "Help variable for mean Nusselt number";

        SI.NusseltNumber Nu=(Nu1^3 + Nu0^3 + (Nu2 - Nu0)^3 + Nu3^3)^(1/3)
          "Mean Nusselt number";

        //Documentation
      algorithm
        kc := Nu*IN_var.lambda/max(MIN, IN_con.d_hyd);
      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of mean convective heat transfer coefficient <strong>kc</strong> of a straight pipe at an uniform wall temperature <strong>or</strong> uniform heat flux <strong>and</strong> for a hydrodynamically developed <strong>or</strong> undeveloped laminar fluid flow. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_laminar\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2014-08-05 Stefan Wischhusen: Corrected term for Uniform heat flux in developed fluid flow (Nu3).</p>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_laminar_KC;

      record kc_laminar_IN_con
        "Input record for function kc_laminar and kc_laminar_KC"
        extends Utilities.Records.HeatTransfer.StraightPipe;

          //choices
        Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary target=Dissipation.Utilities.Types.HeatTransferBoundary.UWTuDFF
          "Choice of heat transfer boundary condition"
          annotation (Dialog(group="Choices"));

      annotation (Documentation(info="<html>
<p>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar\"> kc_laminar</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_KC\"> kc_laminar_KC</a>.
</p>
</html>"));
      end kc_laminar_IN_con;

      record kc_laminar_IN_var
        "Input record for function kc_laminar and kc_laminar_KC"
        extends
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var;

      annotation (Documentation(info="<html>
<p>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar\"> kc_laminar</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_KC\"> kc_laminar_KC</a>.
</p>
</html>"));
      end kc_laminar_IN_var;

      function kc_overall
        "Mean heat transfer coefficient of straight pipe | uniform wall temperature or uniform heat flux | hydrodynamically developed or undeveloped overall flow regime| pressure loss dependence"
        extends Modelica.Icons.Function;
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
        output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
          annotation (Dialog(group="Output"));

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.Roughness;

        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Cross sectional area";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross)
          "Mean velocity";

        //failure status
        Real fstatus[3] "Check of expected boundary conditions";

      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
        Re := (IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta));
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
          assert(false, "No choice of roughness is selected");
        end if;
        fstatus[2] := if Pr < 0.6 or Pr > 1e3 then 1 else 0;
        fstatus[3] := if IN_con.d_hyd/max(MIN, IN_con.L) > 1 then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of mean convective heat transfer coefficient <strong>kc</strong> of a straight pipe at an uniform wall temperature <strong>or</strong> uniform heat flux <strong>and</strong> for a hydrodynamically developed <strong>or</strong> undeveloped overall fluid flow with neglect <strong>or</strong> consideration of pressure loss influence. Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_overall\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_overall;

      function kc_overall_KC
        "Mean heat transfer coefficient of straight pipe | uniform wall temperature or uniform heat flux | hydrodynamically developed or undeveloped overall flow regime| pressure loss dependence"
        extends Modelica.Icons.Function;
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
        SI.ReynoldsNumber Re=(IN_var.rho*velocity*IN_con.d_hyd/max(MIN,
            IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        kc_turbulent_IN_con IN_con_turb(d_hyd=IN_con.d_hyd, L= IN_con.L, roughness = IN_con.roughness, K=IN_con.K);
        kc_laminar_IN_con IN_con_lam(d_hyd=IN_con.d_hyd, L= IN_con.L, target=IN_con.target);

      algorithm
        kc := SMOOTH(
                laminar,
                turbulent,
                Re)*Dissipation.HeatTransfer.StraightPipe.kc_laminar_KC(IN_con_lam,
          IN_var) + SMOOTH(
                turbulent,
                laminar,
                Re)*Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC(IN_con_turb,
          IN_var);

      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of mean convective heat transfer coefficient <strong>kc</strong> of a straight pipe at an uniform wall temperature <strong>or</strong> uniform heat flux <strong>and</strong> for a hydrodynamically developed <strong>or</strong> undeveloped overall fluid flow with neglect <strong>or</strong> consideration of pressure loss influence.<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_overall\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_overall_KC;

      record kc_overall_IN_con
        "Input record for function kc_overall and kc_overall_KC"

          //choices
        Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary target=Dissipation.Utilities.Types.HeatTransferBoundary.UWTuDFF
          "Choice of heat transfer boundary condition"
          annotation (Dialog(group="Choices"));

        extends kc_turbulent_IN_con;

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall\"> kc_overall</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC\"> kc_overall_KC</a>.
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
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall\"> kc_overall</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC\"> kc_overall_KC</a>.
</html>"));
      end kc_overall_IN_var;

      function kc_turbulent
        "Mean heat transfer coefficient of straight pipe | hydrodynamically developed turbulent flow regime | pressure loss dependence"
        extends Modelica.Icons.Function;
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
        output SI.PrandtlNumber Pr "Prandtl number" annotation (Dialog(group="Output"));
        output SI.ReynoldsNumber Re "Reynolds number"
          annotation (Dialog(group="Output"));
        output SI.NusseltNumber Nu "Nusselt number"
          annotation (Dialog(group="Output"));
        output Real failureStatus
          "0== boundary conditions fulfilled | 1== failure >> check if still meaningful results"
          annotation (Dialog(group="Output"));

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.Roughness;

        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Cross sectional area";

        SI.Velocity velocity=abs(IN_var.m_flow)/(IN_var.rho*A_cross)
          "Mean velocity";

        //failure status
        Real fstatus[3] "Check of expected boundary conditions";

        //Documentation
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
        Re := (IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta));
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
          assert(false, "No choice of roughness is selected");
        end if;
        fstatus[2] := if Pr <= 0.6 or Pr >= 1e3 then 1 else 0;
        fstatus[3] := if IN_con.d_hyd/max(MIN, IN_con.L) > 1 then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of mean convective heat transfer coefficient <strong>kc</strong> of a straight pipe for a hydrodynamically developed turbulent fluid flow at uniform wall temperature <strong>or</strong> uniform heat flux with neglecting <strong>or</strong> considering of pressure loss influence. Note that additionally a failure status is observed in this function to check if the intended boundary conditions are fulfilled.  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_turbulent\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_turbulent;

      function kc_turbulent_KC
        "Mean heat transfer coefficient of straight pipe | hydrodynamically developed turbulent flow regime | pressure loss dependence"
        extends Modelica.Icons.Function;
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
        SI.ReynoldsNumber Re=max(MIN,(IN_var.rho*velocity*IN_con.d_hyd/IN_var.eta));
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
      annotation (Inline=false, Documentation(info="<html>
<p>
Calculation of mean convective heat transfer coefficient <strong>kc</strong> of a straight pipe for a hydrodynamically developed turbulent fluid flow at uniform wall temperature <strong>or</strong> uniform heat flux with neglecting <strong>or</strong> considering of pressure loss influence. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_turbulent\">See more information</a> .
</p>
</html>", revisions="<html>
<p>2016-04-12 Stefan Wischhusen: Limited Re to very small value (Modelica.Constant.eps).</p>
</html>"), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_turbulent_KC;

      record kc_turbulent_IN_con
        "Input record for function kc_turbulent and kc_turbulent_KC"
        extends Utilities.Records.HeatTransfer.StraightPipe;

        Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=Dissipation.Utilities.Types.Roughness.Considered
          "Choice of considering surface roughness"
          annotation (Dialog(group="Choices"));

        SI.Length K=0 "Roughness (average height of surface asperities)" annotation (
            Dialog(group="Straight pipe", enable=roughness == Modelica.Fluid.Dissipation.Utilities.Types.Roughness.Considered));

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent\">kc_turbulent</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC\">kc_turbulent_KC</a>.
</html>"));
      end kc_turbulent_IN_con;

      record kc_turbulent_IN_var
        "Input record for function kc_turbulent and kc_turbulent_KC"
        extends
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var;

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent\">kc_turbulent</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC\">kc_turbulent_KC</a>.
</html>"));
      end kc_turbulent_IN_var;

      function kc_twoPhaseOverall_KC
        "Local two phase heat transfer coefficient of straight pipe | horizontal or vertical boiling | horizontal condensation"
        extends Modelica.Icons.Function;
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
      annotation(Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
            Documentation(info=
                      "<html>
<p>Calculation of local <strong>two phase</strong> heat transfer coefficient <strong>kc_2ph</strong> for (horizontal/vertical) <strong>boiling</strong> or (horizontal) <strong>condensation</strong> for an overall flow regime. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_twoPhaseOverall\">See more information</a> .</p>
</html>", revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"));
      end kc_twoPhaseOverall_KC;

      record kc_twoPhaseOverall_KC_IN_con
        "Input record for function kc_twoPhaseOverall_KC"
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_con;

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC\"> kc_twoPhaseOverall_KC</a>.
</html>"));
      end kc_twoPhaseOverall_KC_IN_con;

      record kc_twoPhaseOverall_KC_IN_var
        "Input record for function kc_twoPhaseOverall_KC"
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_var;

      annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the heat transfer function <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC\"> kc_twoPhaseOverall_KC</a>.
</html>"));
      end kc_twoPhaseOverall_KC_IN_var;
      annotation (preferredView="info", Documentation(info="<html>
<h4>Straight pipe</h4>
<h5>Laminar flow</h5>
<p>Calculation of mean convective heat transfer coefficient <strong>kc</strong> of a straight pipe at an uniform wall temperature <strong>or</strong> uniform heat flux <strong>and</strong> for a hydrodynamically developed <strong>or</strong> undeveloped laminar fluid flow. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_laminar\">See more information</a>.</p>

<h5>Turbulent flow</h5>
<p>Calculation of mean convective heat transfer coefficient <strong>kc</strong> of a straight pipe for a hydrodynamically developed turbulent fluid flow at uniform wall temperature <strong>or</strong> <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_twoPhaseOverall\">See more information</a>.</p>
</html>"));
    end StraightPipe;
  annotation(preferredView="info");
  end HeatTransfer;

  package PressureLoss "Package for calculation of pressure loss"
  extends Modelica.Icons.VariantsPackage;

    package Bend "Package for pressure loss calculation of bends"
    extends Modelica.Icons.VariantsPackage;

      function dp_curvedOverall_DP
        "Pressure loss of curved bend | calculate pressure loss | overall flow regime | surface roughness"
        extends Modelica.Icons.Function;
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
        SI.ReynoldsNumber Re_min=1 "Minimum Reynolds number";
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
        Real A2=if frac_RD > 2.0 then 6e2 else if frac_RD <= 2.0 and frac_RD > 0.55 then
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

        //mass flow rate boundaries for w.r.t. flow regimes
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
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
          inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW(
                IN_con,
                IN_var,
                DP)),
          Documentation(info="<html>
<p>Calculation of pressure loss in curved bends at overall flow regime for incompressible and single-phase fluid flow through circular cross sectional area considering surface roughness.</p>

<p>Generally this function is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW\">dp_curvedOverall_MFLOW</a> is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_curvedOverall\">See more information</a>.</p>
</html>", revisions="<html>
2014-12-12 Stefan Wischhusen: Factor A2 corrected for R/D > 0.55-0.7. The factor is now 6e3 instead of 4e3.<br>
</html>"));
      end dp_curvedOverall_DP;

      function dp_curvedOverall_MFLOW
        "Pressure loss of curved bend | calculate mass flow rate | overall flow regime | surface roughness"
        extends Modelica.Icons.Function;
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
        SI.ReynoldsNumber Re_min=1 "Minimum Reynolds number";
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
        Real A2=if frac_RD > 2.0 then 6e2 else if frac_RD <= 2.0 and frac_RD > 0.55 then
                  (if frac_RD > 1.0 then 1e3 else if frac_RD <= 1.0 and frac_RD > 0.7 then
                  3e3 else 6e3) else 4e3
          "Coefficient considering laminar regime on zeta_LOC";
        Real B1=if frac_RD >= 1.0 then 0.21*(frac_RD)^(-0.5) else 0.21*(frac_RD)^(-2.5)
          "Coefficient considering relative curvature radius (R_0/d_hyd) on zeta_LOC";
        Real C1=1.0
          "Considering relative elongation of cross sectional area on zeta_LOC (here: circular cross sectional area)";
        TYP.LocalResistanceCoefficient zeta_LOC_sharp_turb=max(MIN, A1*B1*C1)
          "Local resistance coefficient for turbulent regime (Re > Re_turb_max)";

        //SOURCE_1: p.357, diag. 6-1: pressure loss boundaries for w.r.t. flow regimes
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
        SI.Velocity v_lam=if 1e7*sqrt(abs(zeta_LOC_sharp_turb*abs(dp)*IN_var.rho*
            d_hyd^2)) < abs(A2*IN_var.eta) then 2*abs(dp)*d_hyd/A2/IN_var.eta else (-
            A2/2*IN_var.eta + 0.5*sqrt(max(MIN, (A2*IN_var.eta)^2 + 8*
            zeta_LOC_sharp_turb*abs(dp)*IN_var.rho*d_hyd^2)))/zeta_LOC_sharp_turb/
            IN_var.rho/d_hyd
          "Mean velocity in laminar regime (Re < Re_lam_leave)";
        SI.Velocity v_tra=if 1e7*sqrt(abs(zeta_LOC_sharp_turb*abs(dp_lam_max)*IN_var.rho
            *d_hyd^2)) < abs(A2*IN_var.eta) then 2*abs(dp_lam_max)*d_hyd/A2/IN_var.eta
             else (-A2/2*IN_var.eta + 0.5*sqrt(max(MIN, (A2*IN_var.eta)^2 + 8*
            zeta_LOC_sharp_turb*abs(dp_lam_max)*IN_var.rho*d_hyd^2)))/
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

        //mean velocity under smooth conditions w.r.t. flow regime
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

      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
          inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP(
                IN_con,
                IN_var,
                M_FLOW)),
          Documentation(info="<html>
<p>
Calculation of pressure loss in curved bends at overall flow regime for incompressible and single-phase fluid flow through circular cross sectional area considering surface roughness.
</p>

<p>
Generally this function is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP\">dp_curvedOverall_DP</a> is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_curvedOverall\">See more information</a> .</p>
</html>", revisions="<html>
2014-12-01 Stefan Wischhusen: Introduced an expansion in variables v_lam and v_tra for numerical improvement at close to zero flows.<br>
2014-12-12 Stefan Wischhusen: Factor A2 corrected for R/D > 0.55-0.7. The factor is now 6e3 instead of 4e3.<br>
</html>"));
      end dp_curvedOverall_MFLOW;

      record dp_curvedOverall_IN_con
        "Input record for function dp_curvedOverall_DP and dp_curvedOverall_MFLOW"

        //bend variables
        extends Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.Bend;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP\"> dp_curvedOverall_DP </a>
and <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW\"> dp_curvedOverall_MFLOW </a>.
</html>"));
      end dp_curvedOverall_IN_con;

      record dp_curvedOverall_IN_var
        "Input record for function dp_curvedOverall_DP and dp_curvedOverall_MFLOW"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP\"> dp_curvedOverall_DP </a>
and <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW\"> dp_curvedOverall_MFLOW </a>.
</html>"));
      end dp_curvedOverall_IN_var;

      function dp_edgedOverall_DP
        "Pressure loss of edged bend | calculate pressure loss | overall flow regime | surface roughness"
        extends Modelica.Icons.Function;
        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //SOURCE_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //SOURCE_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Lac 6 (Verification)
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Bend;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

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
        SI.ReynoldsNumber Re_min=1 "Minimum Reynolds number";
        SI.ReynoldsNumber Re_lam_min=5e2
          "Start of transition regime for roughness contribution";
        SI.ReynoldsNumber Re_lam_max=1e4
          "End of transition regime for roughness contribution";
        SI.ReynoldsNumber Re_turb_min=1e5
          "Minimum Reynolds number for Reynolds-dependent transition regime";
        SI.ReynoldsNumber Re_turb_max=2e5
          "Maximum Reynolds number for Reynolds-dependent transition regime (k_Re=1)";
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

        //SOURCE_1: p.365: Correction w.r.t. effect of Reynolds number in laminar regime
        Real B=24.8
          "Coefficient considering effect of Reynolds number on zeta_TOT";
        Real exp=0.263
          "Exponent for Reynolds number correction in laminar regime";

        Real v_min=Re_min*IN_var.eta/(IN_var.rho*d_hyd)
          "Minimum mean velocity for linear interpolation";

        SI.Velocity velocity=m_flow/(IN_var.rho*A_cross) "Mean velocity";
        SI.ReynoldsNumber Re=max(Re_min, IN_var.rho*abs(velocity)*d_hyd/IN_var.eta)
          "Reynolds number";

        //SOURCE_2: p.191, eq. 8.4: considering surface roughness
        TYP.DarcyFrictionFactor lambda_FRI_rough=0.25/(Modelica.Math.log10(k/(3.7*
            IN_con.d_hyd) + 5.74/max(Re_lam_min, Re)^0.9))
            ^2 "Darcy friction factor considering surface roughness";
        TYP.DarcyFrictionFactor lambda_FRI_smooth=0.25/(Modelica.Math.log10(5.74/max(Re_lam_min, Re)^0.9))^2
          "Darcy friction factor neglecting surface roughness";

        //SOURCE_3: Lac 6, Figure 18
        Real CF_fri= SMOOTH(Re_lam_leave, Re_lam_min, Re)*max(1, min(1.4, (lambda_FRI_rough/
            lambda_FRI_smooth))) + SMOOTH(Re_lam_min, Re_lam_leave, Re)
          "Correction factor for surface roughness";

        //SOURCE_2: p.208, diag. 9.3: Correction w.r.t. effect of Reynolds number
        Real CF_Re=SMOOTH(
            Re_turb_min,
            Re_turb_max,
            Re)*B/Re^exp + SMOOTH(
            Re_turb_max,
            Re_turb_min,
            Re) "Correction factor for Reynolds number";

        TYP.PressureLossCoefficient zeta_TOT=A*C1*zeta_LOC*CF_Re*CF_fri
          "Pressure loss coefficient";

      algorithm
        DP := zeta_TOT*(IN_var.rho/2)*
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                velocity,
                v_min,
                2);
       annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of pressure loss in edged bends with sharp corners at overall flow regime for incompressible and single-phase fluid flow through circular cross sectional area considering surface roughness.
</p>

<p>
There are larger pressure losses in an edged bend compared to a curved bend under the same conditions. The effect of a sharp corner in an edged bend on the pressure loss is much larger than the influence of surface roughness.
</p>

<p>
Generally this function is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW\">dp_edgedOverall_MFLOW</a> is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_edgedOverall\">See more information</a> .</p>
</html>"));
      end dp_edgedOverall_DP;

      function dp_edgedOverall_MFLOW
        "Pressure loss of edged bend | calculate mass flow rate | overall flow regime | surface roughness"
        extends Modelica.Icons.Function;
        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //SOURCE_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //SOURCE_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Lac 6 (Verification)
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Bend;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

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
        SI.ReynoldsNumber Re_min=1 "Minimum Reynolds number";
        SI.ReynoldsNumber Re_lam_min=500
          "Start of transition regime for roughness contribution";
        SI.ReynoldsNumber Re_lam_max=1e4
          "End of transition regime for roughness contribution";
        SI.ReynoldsNumber Re_turb_min=1e5
          "Minimum Reynolds number for Reynolds-dependent transition regime";
        SI.ReynoldsNumber Re_turb_max=2e5
          "Maximum Reynolds number for Reynolds-dependent transition regime (k_Re=1)";
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

        //SOURCE_1: p.365: Correction w.r.t. effect of Reynolds number
        Real B=24.8
          "Coefficient considering effect of Reynolds number on zeta_TOT";
        Real exp=0.263 "Exponent for Reynolds number correction";
        Real pow=(2 - exp) "Pressure loss = f(mass flow rate^pow)";
      //   Real k_Re = B/(max(MIN, velocity)*IN_con.d_hyd*IN_var.rho)^exp*IN_var.eta^exp;

        SI.Velocity v_min = Re_min*IN_var.eta/(IN_var.rho*d_hyd)
          "Minimum mean velocity for regularization";

        SI.Pressure dp_min=A*C1*zeta_LOC*(B/2)*(d_hyd/IN_var.eta)^(-exp)*IN_var.rho^(1 - exp)
            *v_min^(pow)
          "Linear smoothing of mass flow rate for decreasing pressure loss";

        SI.Velocity v_lam_min = Re_lam_min*IN_var.eta/(IN_var.rho*d_hyd)
          "Mean velocity for starting of transition to roughness regime";
        SI.Velocity v_lam_leave = Re_lam_leave*IN_var.eta/(IN_var.rho*d_hyd)
          "Mean velocity for end of transition to roughness regime";

        SI.Pressure dp_lam_min=A*C1*zeta_LOC*(B/2)*(d_hyd/IN_var.eta)^(-exp)*IN_var.rho^(1 - exp)
            *v_lam_min^(pow)
          "Pressure loss for starting of transition to roughness regime";

        TYP.DarcyFrictionFactor lambda_lam_leave_rough=0.25/(Modelica.Math.log10(k/(3.7*
            IN_con.d_hyd) + 5.74/Re_lam_leave^0.9))^2
          "Darcy friction factor considering surface roughness at Re_lem_leave";
        TYP.DarcyFrictionFactor lambda_lam_leave_smooth=0.25/(Modelica.Math.log10(5.74/Re_lam_leave^0.9))^2
          "Darcy friction factor neglecting surface roughness at Re_lam_leave";

        SI.Pressure dp_lam_leave=A*C1*zeta_LOC*(B/2)*max(1, min(1.4, (lambda_lam_leave_rough/
            lambda_lam_leave_smooth)))*(d_hyd/IN_var.eta)^(-exp)*IN_var.rho^(1 - exp)
            *v_lam_leave^(pow)
          "Pressure loss at end of transition to surface roughness regime";

        TYP.DarcyFrictionFactor lambda_turb_min_rough=0.25/(Modelica.Math.log10(k/(3.7*
            IN_con.d_hyd) + 5.74/Re_turb_min^0.9))^2
          "Darcy friction factor considering surface roughness at starting transition to constant turbulent regime";
        TYP.DarcyFrictionFactor lambda_turb_min_smooth=0.25/(Modelica.Math.log10(5.74/Re_turb_min^0.9))^2
          "Darcy friction factor neglecting surface roughness at starting transition to constant turbulent regime";

        TYP.DarcyFrictionFactor lambda_turb_max_rough=0.25/(Modelica.Math.log10(k/(3.7*
            IN_con.d_hyd) + 5.74/Re_turb_max^0.9))^2
          "Darcy friction factor considering surface roughness at starting transition to constant turbulent regime";
        TYP.DarcyFrictionFactor lambda_turb_max_smooth=0.25/(Modelica.Math.log10(5.74/Re_turb_max^0.9))^2
          "Darcy friction factor neglecting surface roughness at starting transition to constant turbulent regime";

        SI.Velocity v_turb_min = Re_turb_min*IN_var.eta/(IN_var.rho*d_hyd)
          "Mean velocity for starting of transition to constant turbulent regime";

        SI.Velocity v_turb_max = Re_turb_max*IN_var.eta/(IN_var.rho*d_hyd)
          "Mean velocity for end of transition to constant turbulent regime";

        SI.Pressure dp_turb_min=A*C1*zeta_LOC*(B/2)*max(1, min(1.4, (lambda_turb_min_rough/
            lambda_turb_min_smooth)))*(d_hyd/IN_var.eta)^(-exp)*IN_var.rho^(1 - exp)
            *v_turb_min^(pow)
          "Pressure loss at starting of transition to constant turbulent regime";

        SI.Pressure dp_turb_max=A*C1*zeta_LOC*max(1, min(1.4, (lambda_turb_max_rough/
            lambda_turb_max_smooth)))*IN_var.rho/2*v_turb_max^2
          "Pressure loss at end of transition to constant turbulent regime";

        SI.Velocity v_turb=(A*C1*zeta_LOC*IN_var.rho/2)^(-0.5)*
            Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
            abs(dp),
            dp_min,
            0.5) "Mean velocity under turbulent conditions";

        SI.Velocity v_lam=(2*(d_hyd/IN_var.eta)^exp/(A*C1*zeta_LOC*B*(IN_var.rho)^(1 - exp)))^(1/pow)*
            Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
            abs(dp),
            dp_min,
            1/pow) "Mean velocity under laminar conditions";

        //mean velocity under smooth conditions w.r.t. flow regime
        SI.Velocity v_smooth=if abs(dp) > dp_turb_max then v_turb
            else if abs(dp) < dp_turb_min then v_lam
            else SMOOTH(
            dp_turb_max,
            dp_turb_min,
            abs(dp))*v_turb + SMOOTH(
            dp_turb_min,
            dp_turb_max,
            abs(dp))*v_lam "Mean velocity under smooth conditions";

        SI.ReynoldsNumber Re_smooth=max(Re_min, IN_var.rho*v_smooth*d_hyd/IN_var.eta)
          "Reynolds number under smooth conditions";

        //SOURCE_2: p.191, eq. 8.4: considering surface roughness
        TYP.DarcyFrictionFactor lambda_FRI_rough=0.25/(Modelica.Math.log10(k/(3.7*
            IN_con.d_hyd) + 5.74/max(Re_lam_min, Re_smooth)^0.9))
            ^2 "Darcy friction factor considering surface roughness";
        TYP.DarcyFrictionFactor lambda_FRI_smooth=0.25/(Modelica.Math.log10(5.74/max(Re_lam_min, Re_smooth)^0.9))^2
          "Darcy friction factor neglecting surface roughness";

        //SOURCE_3: Lac 6, Figure 18
        Real CF_fri= SMOOTH(dp_lam_leave, dp_lam_min, abs(dp))*max(1, min(1.4, (lambda_FRI_rough/
            lambda_FRI_smooth))) + SMOOTH(dp_lam_min, dp_lam_leave, abs(dp))
          "Correction factor for surface roughness";

        SI.Velocity velocity=v_smooth/max(1, CF_fri)^(0.5)
          "Corrected velocity considering surface roughness";

      algorithm
          M_FLOW := sign(dp)*IN_var.rho*A_cross*velocity;

      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP(
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
Generally this function is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP\">dp_edgedOverall_DP</a> is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_edgedOverall\">See more information</a> .</p>
</html>", revisions="<html>
2014-12-02 Stefan Wischhusen: Changed transition regimes for laminar to highly turbulent domain.
</html>"));
      end dp_edgedOverall_MFLOW;

      record dp_edgedOverall_IN_con
        "Input record for function dp_edgedOverall_DP and dp_edgedOverall_MFLOW"

        //edged bend variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.EdgedBend;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP\"> dp_edgedOverall_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW\"> dp_edgedOverall_MFLOW </a>.
</html>"));
      end dp_edgedOverall_IN_con;

      record dp_edgedOverall_IN_var
        "Input record for function dp_edgedOverall_DP and dp_edgedOverall_MFLOW"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;
        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP\"> dp_edgedOverall_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW\"> dp_edgedOverall_MFLOW </a>.
</html>"));
      end dp_edgedOverall_IN_var;
      annotation (preferredView="info", Documentation(info="<html>
<h4>Bend</h4>
<h5>Curved bend overall flow</h5>
<p>Calculation of pressure loss in curved bends at overall flow regime for incompressible and single-phase fluid flow through circular cross sectional area considering surface roughness.  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_curvedOverall\">See more information</a>.</p>

<h5>Edged bend overall flow</h5>
<p>
Calculation of pressure loss in edged bends with sharp corners at overall flow regime for incompressible and single-phase fluid flow through circular cross sectional area considering surface roughness.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_edgedOverall\">See more information</a> .</p>

</html>"));
    end Bend;

    package Channel "Package for pressure loss calculation of channels"
    extends Modelica.Icons.VariantsPackage;

      function dp_internalFlowOverall_DP
        "Pressure loss of internal flow | calculate pressure loss | overall flow regime | surface roughness | several geometries"
        extends Modelica.Icons.Function;
        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //SOURCE_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 1978.
        //SOURCE_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Channel;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

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
      annotation(Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of pressure loss for an internal flow through different geometries at overall flow regime for incompressible and single-phase fluid flow considering surface roughness.
</p>

<p>
Generally this function is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_MFLOW\">dp_internalFlowOverall_MFLOW</a> is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Channel.dp_internalFlowOverall\">See more information</a>.
</p>
</html>"));
      end dp_internalFlowOverall_DP;

      function dp_internalFlowOverall_MFLOW
        "Pressure loss of internal flow | calculate mass flow rate | overall flow regime | surface roughness | several geometries"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.Channel;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

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

        //determining Darcy friction factor out of pressure loss calculation for straight pipe:
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
            Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_Re(
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
      annotation(Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of pressure loss for an internal flow through different geometries at overall flow regime for incompressible and single-phase fluid flow considering surface roughness.
</p>

<p>
Generally this function is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_DP\">dp_internalFlowOverall_DP</a> is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.</p>

<p>
The pressure loss calculation for internal fluid flow in different geometries is further documented  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Channel.dp_internalFlowOverall\">here</a>.
</p>
</html>"));
      end dp_internalFlowOverall_MFLOW;

      record dp_internalFlowOverall_IN_con
        "Input record for function dp_internalFlowOverall_DP and dp_internalFlowOverall_MFLOW"

        //channel variables
        Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=Dissipation.Utilities.Types.Roughness.Considered
          "Choice of considering surface roughness"
          annotation (Dialog(group="Channel"));
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.Geometry;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_DP\"> dp_internalFlowOverall_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_MFLOW\"> dp_internalFlowOverall_MFLOW</a>.
</html>"));
      end dp_internalFlowOverall_IN_con;

      record dp_internalFlowOverall_IN_var
        "Input record for function dp_internalFlowOverall_DP and dp_internalFlowOverall_MFLOW"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_DP\"> dp_internalFlowOverall_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_MFLOW\"> dp_internalFlowOverall_MFLOW</a>.
</html>"));
      end dp_internalFlowOverall_IN_var;
      annotation (preferredView="info", Documentation(info="<html>
<h4>Channel</h4>
<h5>Internal overall flow</h5>
<p>
Calculation of pressure loss for an internal flow through different geometries at laminar and turbulent flow regime considering surface roughness.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Channel.dp_internalFlowOverall\">See more information</a>.
</p>
</html>"));
    end Channel;

    package General "Package for generic pressure loss calculations"
    extends Modelica.Icons.VariantsPackage;

      function dp_idealGas_DP
        "Generic pressure loss | calculate pressure loss | ideal gas | mean density"
        extends Modelica.Icons.Function;
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
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss for an <strong>ideal gas</strong> using mean density.
</p>

<p>
Generally this function is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_MFLOW\">dp_idealGas_MFLOW</a> is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_idealGas\">See more information</a>.
</p>
</html>"));
      end dp_idealGas_DP;

      function dp_idealGas_MFLOW
        "Generic pressure loss | calculate mass flow rate | ideal gas | mean density"
        extends Modelica.Icons.Function;
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
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss for an <strong>ideal gas</strong> using mean density.
</p>

<p>
Generally this function is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_DP\">dp_idealGas_DP</a> is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_idealGas\">See more information</a>.
</p>
</html>"));
      end dp_idealGas_MFLOW;

      record dp_idealGas_IN_con
        "Input record for function dp_idealGas_DP and dp_idealGas_MFLOW"

        //generic variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.IdealGas_con;

        //linearisation
        SI.Pressure dp_smooth(min=Modelica.Constants.eps) = 1
          "Start linearisation for smaller pressure loss"
          annotation (Dialog(group="Linearisation"));

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_DP\"> dp_idealGas_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_MFLOW\"> dp_idealGas_MFLOW </a>.
</html>"));

      end dp_idealGas_IN_con;

      record dp_idealGas_IN_var
        "Input record for function dp_idealGas_DP and dp_idealGas_MFLOW"

        //generic variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.IdealGas_var;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_DP\"> dp_idealGas_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_MFLOW\"> dp_idealGas_MFLOW</a>.
</html>"));

      end dp_idealGas_IN_var;

      function dp_nominalDensityViscosity_DP
        "Generic pressure loss | calculate mass flow rate | nominal operation point | pressure loss law (exponent) | density and dynamic viscosity dependence"
        extends Modelica.Icons.Function;
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
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of nominal fluid variables (e.g., nominal density, nominal dynamic viscosity) at an operation point via interpolation.
This generic function considers the pressure loss law via a pressure loss exponent and the influence of density and dynamic viscosity on pressure loss.
</p>

<p>
Generally this function is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_MFLOW\">dp_nominalDensityViscosity_MFLOW</a> is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_nominalDensityViscosity\">See more information</a>.
</p>
</html>"));
      end dp_nominalDensityViscosity_DP;

      function dp_nominalDensityViscosity_MFLOW
        "Generic pressure loss | calculate M_FLOW (compressible) | nominal operation point | pressure loss law (exponent) | density and dynamic viscosity dependence"
        extends Modelica.Icons.Function;
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
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of nominal fluid variables (e.g., nominal density, nominal dynamic viscosity) at an operation point via interpolation.
This generic function considers the pressure loss law via a pressure loss exponent and the influence of density and dynamic viscosity on pressure loss.
</p>

<p>
Generally this function is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_DP\">dp_genericDensityViscosity_DP</a> is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_nominalDensityViscosity\">See more information</a>.
</p>
</html>"));
      end dp_nominalDensityViscosity_MFLOW;

      record dp_nominalDensityViscosity_IN_con
        "Output record for function dp_nominalDensityViscosity_DP and dp_nominalDensityViscosity_MFLOW"

        //generic variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.NominalDensityViscosity;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_DP\"> dp_nominalDensityViscosity_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_MFLOW\"> dp_nominalDensityViscosity_MFLOW</a>.
</html>"));
      end dp_nominalDensityViscosity_IN_con;

      record dp_nominalDensityViscosity_IN_var
        "Output record for function dp_nominalDensityViscosity_DP and dp_nominalDensityViscosity_MFLOW"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_DP\"> dp_nominalDensityViscosity_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_MFLOW\"> dp_nominalDensityViscosity_MFLOW</a>.
</html>"));
      end dp_nominalDensityViscosity_IN_var;

      function dp_nominalPressureLossLawDensity_DP
        "Generic pressure loss | calculate pressure loss | nominal operation point | pressure loss law (coefficient and exponent) | density dependence"
        extends Modelica.Icons.Function;
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

      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of nominal fluid variables (e.g., nominal density) via interpolation from an operation point.
This generic function considers the pressure loss law via a nominal pressure loss (dp_nom), a pressure loss coefficient (zeta_TOT) and a pressure loss law exponent (exp) as well as the influence of density on pressure loss.
</p>

<p>
Generally this function is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW\">dp_nominalPressureLossLawDensity_MFLOW</a> is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_nominalPressureLossLawDensity\">See more information</a>.
</p>
</html>"));
      end dp_nominalPressureLossLawDensity_DP;

      function dp_nominalPressureLossLawDensity_MFLOW
        "Generic pressure loss | calculate mass flow rate | nominal operation point | pressure loss law (coefficient and exponent) | density dependence"
        extends Modelica.Icons.Function;
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
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of nominal fluid variables (e.g., nominal density) via interpolation from an operation point.
This generic function considers the pressure loss law via a nominal pressure loss (dp_nom), a pressure loss coefficient (zeta_TOT) and a pressure loss law exponent (exp) as well as the influence of density on pressure loss.
</p>

<p>
Generally this function is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP\">dp_nominalPressurelosslawDensity_DP</a> is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_nominalPressureLossLawDensity\">See more information</a>.
</p>
</html>"));
      end dp_nominalPressureLossLawDensity_MFLOW;

      record dp_nominalPressureLossLawDensity_IN_con
        "Input record for function dp_nominalPressureLossLawDensity_DP and dp_nominalPressureLossLawDensity_MFLOW"

        //generic variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.NominalPressureLossLawDensity_con;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP\"> dp_nominalPressureLosslawDensity_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW\"> dp_nominalPressureLosslawDensity_MFLOW</a>.
</html>"));
      end dp_nominalPressureLossLawDensity_IN_con;

      record dp_nominalPressureLossLawDensity_IN_var
        "Input record for function dp_nominalPressureLossLawDensity_DP and dp_nominalPressureLossLawDensity_MFLOW"

        //generic variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.NominalPressureLossLawDensity_var;

        //fluid property variables
        SI.Density rho "Density of fluid"
          annotation (Dialog(group="Fluid properties"));

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP\"> dp_nominalPressureLosslawDensity_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW\"> dp_nominalPressureLosslawDensity_MFLOW</a>.
</html>"));
      end dp_nominalPressureLossLawDensity_IN_var;

      function dp_pressureLossCoefficient_DP
        "Generic pressure loss | calculate pressure loss | pressure loss coefficient (zeta_TOT)"
        extends Modelica.Icons.Function;
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
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of a pressure loss coefficient.
</p>

<p>
Generally this function is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_MFLOW\">dp_pressureLossCoefficient_MFLOW</a> is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_pressureLossCoefficient\">See more information</a>.
</p>
</html>"));
      end dp_pressureLossCoefficient_DP;

      function dp_pressureLossCoefficient_MFLOW
        "Generic pressure loss | calculate mass flow rate | pressure loss coefficient (zeta_TOT)"
        extends Modelica.Icons.Function;
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
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of a pressure loss coefficient.
</p>

<p>
Generally this function is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_DP\">dp_pressureLossCoefficient_DP</a> is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_pressureLossCoefficient\">See more information</a>.
</p>
</html>"));
      end dp_pressureLossCoefficient_MFLOW;

      record dp_pressureLossCoefficient_IN_con
        "Input record for function dp_pressureLossCoefficient_DP and dp_pressureLossCoefficient_MFLOW"
        extends Modelica.Icons.Record;

        //generic variables
        SI.Area A_cross=Modelica.Constants.pi*0.1^2/4 "Cross sectional area"
          annotation (Dialog(group="Generic variables"));

        //linearisation
        SI.Pressure dp_smooth=1
          "Start linearisation for decreasing pressure loss"
          annotation (Dialog(group="Linearisation"));

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_DP\"> dp_pressureLossCoefficient_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_MFLOW\"> dp_pressureLossCoefficient_MFLOW</a>.
</html>"));
      end dp_pressureLossCoefficient_IN_con;

      record dp_pressureLossCoefficient_IN_var
        "Input record for function dp_pressureLossCoefficient_DP and dp_pressureLossCoefficient_MFLOW"
        extends Modelica.Icons.Record;

        //generic variables
        TYP.PressureLossCoefficient zeta_TOT=0.02*1/0.1
          "Pressure loss coefficient"
          annotation (Dialog(group="Generic variables"));

        //fluid property variables
        SI.Density rho "Density of fluid"
          annotation (Dialog(group="FluidProperties"));

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_DP\"> dp_pressureLossCoefficient_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_MFLOW\"> dp_pressureLossCoefficient_MFLOW</a>.
</html>"));
      end dp_pressureLossCoefficient_IN_var;

      function dp_volumeFlowRate_DP
        "Generic pressure loss | calculate pressure loss | quadratic function (dp=a*V_flow^2 + b*V_flow)"
        extends Modelica.Icons.Function;
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
        Real a=abs(IN_con.a);
        Real b=abs(IN_con.b);

        SI.VolumeFlowRate V_flow=m_flow/max(Modelica.Constants.eps, IN_var.rho)
          "Volume flow rate";
        SI.Pressure dp_min=max(Modelica.Constants.eps, abs(IN_con.dp_min))
          "Start of approximation for decreasing pressure loss";
        SI.VolumeFlowRate V_flow_smooth=if a > 0 and b <= 0 then (dp_min/a)^0.5 else 0
          "Start of approximation for decreasing volume flow rate";

        //Documentation

      algorithm
        assert(a+b>0, "Please provide non-zero factors for either a or b of function dp=a*V_flow^2 + b*V_flow");

        // Please note the function is reqularized for zero flow with the parameter b if b>0.

        DP := a*(if a>0 and b<=0 then Dissipation.Utilities.Functions.General.SmoothPower(
                V_flow,
                V_flow_smooth,
                2) elseif a>0 and b>0 then V_flow*abs(V_flow) else 0) + b*V_flow;
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss with linear and/or quadratic dependence on volume flow rate. <strong>Please note that the sum of a and b has to be greater zero</strong>.
The function can be used to calculate pressure loss at known mass flow rate <strong>or</strong> mass flow rate at known pressure loss.
</p>

<p>
Generally this function is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW\">dp_volumeFlowRate_MFLOW</a> is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_volumeFlowRate\">See more information</a>.
</p>
</html>", revisions="<html>
2018-11-21 Stefan Wischhusen: Fixed problem for linear case (a=0 and b>0) and obsolete regularization for a>0 and b>0.
</html>"));
      end dp_volumeFlowRate_DP;

      function dp_volumeFlowRate_MFLOW
        "Generic pressure loss | calculate mass flow rate | quadratic function (dp=a*V_flow^2 + b*V_flow)"
        extends Modelica.Icons.Function;
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
        Real a=abs(IN_con.a);
        Real b=abs(IN_con.b);

        SI.Pressure dp_min=max(Modelica.Constants.eps, abs(IN_con.dp_min))
          "Start of approximation for decreasing pressure loss";

        //Documentation

      algorithm
        assert(a+b>0, "Please provide non-zero factors for either a or b of function dp=a*V_flow^2 + b*V_flow");

        // Please note the function is reqularized for zero flow with the parameter b if b>0.

        M_FLOW := IN_var.rho*(if a>0 and b<=0 then
                Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                (1/a)*dp,
                (1/a)*dp_min,
                0.5)
                elseif a>0 and b>0 then
                sign(dp)*(-b/(2*a) + sqrt((b/(2*a))^2 + (1/a)*abs(dp)))
                else b*dp);
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of a generic pressure loss with linear or quadratic dependence on volume flow rate. <strong>Please note that the sum of a and b has to be greater zero</strong>.
The function can be used to calculate pressure loss at known mass flow rate <strong>or</strong> mass flow rate at known pressure loss.
</p>

<p>
Generally this function is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP\">dp_volumeFlowRate_DP</a> is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_volumeFlowRate\">See more information</a>.
</p>
</html>",       revisions="<html>
2018-11-21 Stefan Wischhusen: Fixed problem for linear case (a=0 and b>0) and obsolete regularization for a>0 and b>0.
</html>"));
      end dp_volumeFlowRate_MFLOW;

      record dp_volumeFlowRate_IN_con
        "Input record for function dp_volumeFlowRate_DP and dp_volumeFlowRate_MFLOW"

        //generic variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.QuadraticVFLOW;

        SI.Pressure dp_min=0.1
          "Start of approximation for decreasing pressure loss (only used for b=0)";

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP\"> dp_volumeFlowRate_DP</a> and
 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW\"> dp_volumeFlowRate_MFLOW</a>.
</html>"));

      end dp_volumeFlowRate_IN_con;

      record dp_volumeFlowRate_IN_var
        "Input record for function dp_volumeFlowRate_DP and dp_volumeFlowRate_MFLOW"
        extends Modelica.Icons.Record;

        SI.Density rho "Density of fluid"
          annotation (Dialog(group="Fluid properties"));
        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP\"> dp_volumeFlowRate_DP</a> and
 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW\"> dp_volumeFlowRate_MFLOW</a>.
</html>"));

      end dp_volumeFlowRate_IN_var;
      annotation (preferredView="info", Documentation(info="<html>
<h4>General</h4>
<h5>General pressure loss for ideal gas</h5>
<p>
Calculation of a generic pressure loss for an <strong>ideal gas</strong> using mean density.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_idealGas\">See more information</a>.
</p>

<h5>Generic pressure loss depending on density and viscosity </h5>
<p>
Calculation of a generic pressure loss in dependence of nominal fluid variables (e.g., nominal density, nominal dynamic viscosity) at an operation point via interpolation.
This generic function considers the pressure loss law via a pressure loss exponent and the influence of density and dynamic viscosity on pressure loss.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_nominalDensityViscosity\">See more information</a>.
</p>

<h5>Generic pressure loss depending on density</h5>
<p>
Calculation of a generic pressure loss in dependence of nominal fluid variables (e.g., nominal density) via interpolation from an operation point.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_nominalPressureLossLawDensity\">See more information</a>.
</p>

<h5>Generic pressure loss depending on pressure loss coefficient</h5>
<p>
Calculation of a generic pressure loss in dependence of a pressure loss coefficient.
 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_pressureLossCoefficient\">See more information</a>.
</p>

<h5>Generic pressure loss depending on volume flow rate</h5>
<p>
Calculation of a generic pressure loss with linear or quadratic dependence on volume flow rate.
 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_volumeFlowRate\">See more information</a>.
</p>
</html>"));
    end General;

    package Orifice "Package for pressure loss calculation of orifices"
    extends Modelica.Icons.VariantsPackage;

      function dp_suddenChange_DP
        "Pressure loss of orifice with sudden change in cross sectional area | calculate pressure loss | turbulent flow regime | smooth surface | arbitrary cross sectional area | without baffles | sharp edge"
        extends Modelica.Icons.Function;
        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Orifice;

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
          "Perimeter of large cross sectional area of orifice";
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

      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of the local pressure loss at a sudden change of the cross sectional areas (sudden expansion or sudden contraction) with sharp corners at turbulent flow regime for incompressible and single-phase fluid flow through arbitrary shaped cross sectional area (square, circular, etc.) considering a smooth surface. The flow direction determines the type of the transition. In case of the design flow a sudden expansion will be considered. At flow reversal a sudden contraction will be considered.
</p>

<p>
Generally this function is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_MFLOW\">dp_suddenChange_MFLOW</a> is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_suddenChange\">See more information</a>.
</p>
</html>"));
      end dp_suddenChange_DP;

      function dp_suddenChange_MFLOW
        "Pressure loss of orifice with sudden change in cross sectional area | calculate mass flow rate | turbulent flow regime | smooth surface | arbitrary cross sectional area | without baffles | sharp edge"
        extends Modelica.Icons.Function;
        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Orifice;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

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
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of the local pressure loss at a sudden change of the cross sectional areas (sudden expansion or sudden contraction) with sharp corners at turbulent flow regime for incompressible and single-phase fluid flow through arbitrary shaped cross sectional area (square, circular, etc.) considering a smooth surface. The flow direction determines the type of the transition. In case of the design flow a sudden expansion will be considered. At flow reversal a sudden contraction will be considered.
</p>

<p>
Generally this function is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_DP\">dp_suddenChange_DP</a> is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_suddenChange\">See more information</a>.
</p>
</html>"));
      end dp_suddenChange_MFLOW;

      record dp_suddenChange_IN_con
        "Input record for function dp_suddenChange_DP and dp_suddenChange_MFLOW"

        //orifice variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.SuddenChange;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss functions
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_DP\"> dp_suddenChange_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_MFLOW\"> dp_suddenChange_MFLOW</a>.
</html>"));
      end dp_suddenChange_IN_con;

      record dp_suddenChange_IN_var
        "Input record for function dp_suddenChange_DP and dp_suddenChange_MFLOW"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss functions
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_DP\"> dp_suddenChange_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_MFLOW\"> dp_suddenChange_MFLOW</a>.
</html>"));
      end dp_suddenChange_IN_var;

      function dp_thickEdgedOverall_DP
        "Pressure loss of thick and sharp edged orifice | calculate pressure loss | overall flow regime | constant influence of friction  | arbitrary cross sectional area"
        extends Modelica.Icons.Function;
        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Orifice;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

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
          "Assumption for Darcy friction factor in vena contraction according to SOURCE_1";
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
        Real l_bar=IN_con.L/d_hyd_0;

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
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of pressure loss in thick edged orifices with sharp corners at overall flow regime for incompressible and single-phase fluid flow through an arbitrary shaped cross sectional area (square, circular, etc.) considering constant influence of surface roughness.
</p>

<p>
Generally this function is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW\">dp_thickEdgedOverall_MFLOW</a> is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_thickEdgedOverall\">See more information</a>.
</p>
</html>"));
      end dp_thickEdgedOverall_DP;

      function dp_thickEdgedOverall_MFLOW
        "Pressure loss of thick and sharp edged orifice | calculate mass flow rate | overall flow regime | constant influence of friction  | arbitrary cross sectional area"
        extends Modelica.Icons.Function;
        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //Notation of equations according to SOURCES

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Orifice;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

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
          "Assumption for Darcy friction factor in vena contraction according to SOURCE_1";
        SI.ReynoldsNumber Re_lim=1e3
          "Limitation for laminar regime if dp is target";

        SI.Area A_0=IN_con.A_0 "Cross sectional area of vena contraction";
        SI.Area A_1=IN_con.A_1 "Large cross sectional area";
        SI.Diameter d_hyd_0=max(MIN, 4*A_0/IN_con.C_0)
          "Hydraulic diameter of vena contraction";
        SI.Diameter d_hyd_1=max(MIN, 4*A_1/IN_con.C_1)
          "Hydraulic diameter of large cross sectional area";
        SI.Length l=IN_con.L "Length of vena contraction";
        Real l_bar=IN_con.L/d_hyd_0;

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
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of pressure loss in thick edged orifices with sharp corners at overall flow regime for incompressible and single-phase fluid flow through an arbitrary shaped cross sectional area (square, circular, etc.) considering constant influence of surface roughness.
</p>

<p>
Generally this function is numerically best used for the <strong>compressible case</strong>, where the pressure loss (dp) is known (out of pressures as state variable) in the used model and the corresponding mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP\">dp_thickEdgedOverall_DP</a> is numerically best used for the <strong>incompressible case</strong> if the mass flow rate (m_flow) is known (as state variable) and the pressure loss (DP) has to be calculated.  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_thickEdgedOverall\">See more information</a>.
</p>
</html>"));
      end dp_thickEdgedOverall_MFLOW;

      record dp_thickEdgedOverall_IN_con
        "Input record for function dp_thickEdgedOverall_DP and dp_thickEdgedOverall_MFLOW"

        //orifice variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.Orifice;

        //linearisation
        SI.Pressure dp_smooth(min=Modelica.Constants.eps) = 1
          "Start linearisation for decreasing pressure loss"
          annotation (Dialog(group="Linearisation"));

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss functions
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP\"> dp_thickEdgedOverall_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW\"> dp_thickEdgedOverall_MFLOW</a>.
</html>"));
      end dp_thickEdgedOverall_IN_con;

      record dp_thickEdgedOverall_IN_var
        "Input record for function dp_thickEdgedOverall_DP and dp_thickEdgedOverall_MFLOW"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss functions
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP\"> dp_thickEdgedOverall_DP </a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW\"> dp_thickEdgedOverall_MFLOW </a>.
</html>"));
      end dp_thickEdgedOverall_IN_var;
      annotation (preferredView="info", Documentation(info="<html>
<h4>Orifice</h4>
<h5>Sudden change</h5>
<p>
Calculation of the local pressure loss at a sudden change of the cross sectional areas (sudden expansion or sudden contraction) with sharp corners at turbulent flow regime for incompressible and single-phase fluid flow through arbitrary shaped cross sectional area (square, circular, etc.) considering a smooth surface.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_suddenChange\">See more information</a>.
</p>

<h5>Thick edged orifice</h5>
<p>
Calculation of pressure loss in thick edged orifices with sharp corners at overall flow regime for incompressible and single-phase fluid flow through an arbitrary shaped cross sectional area (square, circular, etc.) considering constant influence of surface roughness.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_thickEdgedOverall\">See more information</a>.
</p>
</html>"));
    end Orifice;

    package StraightPipe
      "Package for pressure loss calculation of straight pipes"
    extends Modelica.Icons.VariantsPackage;

      function dp_laminar_DP
        "Pressure loss of straight pipe | calculate pressure loss| laminar flow regime (Hagen-Poiseuille)"
        extends Modelica.Icons.Function;
        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.

        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;

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
      annotation(Inline=true, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <strong>laminar</strong> flow regime of an incompressible and single-phase fluid flow only.
</p>

<p>
Generally this function is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW\">dp_laminar_MFLOW</a> is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.   <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_laminar\">See more information</a>.
</p>
</html>"));
      end dp_laminar_DP;

      function dp_laminar_MFLOW
        "Pressure loss of straight pipe | calculate mass flow rate | laminar flow regime (Hagen-Poiseuille)"
        extends Modelica.Icons.Function;
        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.

        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;

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
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <strong>laminar</strong> flow regime of an incompressible and single-phase fluid flow only.
</p>

<p>
Generally this function is numerically best used for the <strong>compressible case</strong>, where the pressure loss (dp) is known (out of pressures as state variable) in the used model and the corresponding mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_DP\">dp_laminar_DP</a> is numerically best used for the <strong>incompressible case</strong> if the mass flow rate (m_flow) is known (as state variable) and the pressure loss (DP) has to be calculated.   <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_laminar\">See more information</a>.
</p>
</html>"));
      end dp_laminar_MFLOW;

      record dp_laminar_IN_con
        "Input record for function dp_laminar_DP and dp_laminar_MFLOW"
        extends Utilities.Records.PressureLoss.StraightPipe;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_DP\"> dp_laminar_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW\"> dp_laminar_MFLOW</a>.
</html>"));

      end dp_laminar_IN_con;

      record dp_laminar_IN_var
        "Input record for function dp_laminar_DP and dp_laminar_MFLOW"

        extends
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_DP\"> dp_laminar_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW\"> dp_laminar_MFLOW</a>.
</html>"));

      end dp_laminar_IN_var;

      function dp_overall_DP
        "Pressure loss of straight pipe | calculate pressure loss | overall flow regime | surface roughness"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

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

        dp_laminar_IN_con IN_con_lam(d_hyd=IN_con.d_hyd, L= IN_con.L);
      algorithm
        DP := SMOOTH(
                Re_lam_min,
                Re_lam_max,
                Re)*Dissipation.PressureLoss.StraightPipe.dp_laminar_DP(
                IN_con_lam,
                IN_var,
                m_flow) + SMOOTH(
                Re_lam_max,
                Re_lam_min,
                Re)*Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP(
                IN_con,
                IN_var,
                m_flow);
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <strong>overall</strong> flow regime of an incompressible and single-phase fluid flow only considering surface roughness.
</p>

<p>
Generally this function is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW\">dp_overall_MFLOW</a> is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.   <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_overall\">See more information</a>.
</p>
</html>"));
      end dp_overall_DP;

      function dp_overall_MFLOW
        "Pressure loss of straight pipe | calculate mass flow rate | overall flow regime | surface roughness"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;
        import Modelica.Fluid.Dissipation.Utilities.Types.Roughness;

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

        //determining Darcy friction factor out of pressure loss calculation for straight pipe:
        //dp = lambda_FRI*L/d_hyd*(rho/2)*velocity^2 and assuming lambda_FRI == lambda_FRI_calc/Re^2
        TYP.DarcyFrictionFactor lambda_FRI_calc=2*abs(dp)*d_hyd^3*IN_var.rho/(IN_con.L
            *IN_var.eta^2) "Adapted Darcy friction factor";

        //SOURCE_3: p.Lab 1, eq. 5: determine Re assuming laminar regime (Blasius)
        SI.ReynoldsNumber Re_lam=lambda_FRI_calc/64
          "Reynolds number assuming laminar regime";

        //SOURCE_3: p.Lab 2, eq. 10: determine Re assuming turbulent regime (Colebrook-White)
        SI.ReynoldsNumber Re_turb=if IN_con.roughness == Roughness.Neglected then (max(MIN,
            lambda_FRI_calc)/0.3164)^(1/1.75) else -2*sqrt(max(lambda_FRI_calc, MIN))
            *Modelica.Math.log10(2.51/sqrt(max(lambda_FRI_calc, MIN)) + k/3.7)
          "Reynolds number assuming turbulent regime";

        //determine actual flow regime
        SI.ReynoldsNumber Re_check=if Re_lam < Re_lam_leave then Re_lam else Re_turb;
        //determine Re for transition regime
        SI.ReynoldsNumber Re_trans=if Re_lam >= Re_lam_leave then
            Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_Re(
            Re_check,
            Re_lam_leave,
            Re_turb_min,
            k,
            lambda_FRI_calc) else 0;
        //determine actual Re
        SI.ReynoldsNumber Re=if Re_lam < Re_lam_leave then Re_lam else if Re_turb >
            Re_turb_min then Re_turb else Re_trans;

        dp_laminar_IN_con IN_con_lam(d_hyd=IN_con.d_hyd, L= IN_con.L);

      algorithm
        M_FLOW := SMOOTH(
                Re_lam_min,
                Re_turb,
                Re)*Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW(
                IN_con_lam,
                IN_var,
                dp) + SMOOTH(
                Re_turb,
                Re_lam_min,
                Re)*Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW(
                IN_con,
                IN_var,
                dp);
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <strong>overall</strong> flow regime of an incompressible and single-phase fluid flow only considering surface roughness.
</p>

<p>
Generally this function is numerically best used for the <strong>compressible case</strong>, where the pressure loss (dp) is known (out of pressures as state variable) in the used model and the corresponding mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_DP\">dp_overall_DP</a> is numerically best used for the <strong>incompressible case</strong> if the mass flow rate (m_flow) is known (as state variable) and the pressure loss (DP) has to be calculated.   <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_overall\">See more information</a>.
</p>
</html>"));
      end dp_overall_MFLOW;

      record dp_overall_IN_con
        "Input record for function dp_overall_DP and dp_overall_MFLOW"

        //straight pipe variables
        extends dp_turbulent_IN_con;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_DP\"> dp_overall_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW\"> dp_overall_MFLOW</a>.
</html>"));

      end dp_overall_IN_con;

      record dp_overall_IN_var
        "Input record for function dp_overall_DP and dp_overall_MFLOW"

        //fluid property variables
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_DP\"> dp_overall_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW\"> dp_overall_MFLOW</a>.
</html>"));

      end dp_overall_IN_var;

      function dp_turbulent_DP
        "Pressure loss of straight pipe | calculate pressure loss | turbulent flow regime | surface roughness"
        extends Modelica.Icons.Function;
        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //SOURCE_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //SOURCE_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002.
        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;

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

        //SOURCE_2: p.191, eq. 8.4: determining Darcy friction factor
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
            Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_lambda(
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
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <strong>turbulent</strong> flow regime of an incompressible and single-phase fluid flow only considering surface roughness.
</p>

<p>
Generally this function is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW\">dp_turbulent_MFLOW</a> is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated.   <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_turbulent\">See more information</a>.
</p>
</html>"));
      end dp_turbulent_DP;

      function dp_turbulent_MFLOW
        "Pressure loss of straight pipe | calculate mass flow rate | turbulent flow regime | surface roughness"
        extends Modelica.Icons.Function;
        //SOURCE_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //SOURCE_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //SOURCE_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002.

        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;

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

        //determining Darcy friction factor out of pressure loss calculation for straight pipe:
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
            Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_Re(
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
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <strong>turbulent</strong> flow regime of an incompressible and single-phase fluid flow only considering surface roughness.
</p>

<p>
Generally this function is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP\">dp_turbulent_DP</a> is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated.   <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_turbulent\">See more information</a>.
</p>
</html>"));
      end dp_turbulent_MFLOW;

      record dp_turbulent_IN_con
        "Input record for function dp_turbulent_DP and dp_turbulent_MFLOW"

        Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=Dissipation.Utilities.Types.Roughness.Neglected
          "Choice of considering surface roughness"
          annotation (Dialog(group="Straight pipe"));

        extends Utilities.Records.PressureLoss.StraightPipe;

          SI.Length K=0 "Roughness (average height of surface asperities)"
          annotation (Dialog(group="Straight pipe"));

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP\"> dp_turbulent_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW\"> dp_turbulent_MFLOW</a>.
</html>"));
      end dp_turbulent_IN_con;

      record dp_turbulent_IN_var
        "Input record for function dp_turbulent_DP and dp_turbulent_MFLOW"

        extends
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var;

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP\"> dp_turbulent_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW\"> dp_turbulent_MFLOW</a>.
</html>"));
      end dp_turbulent_IN_var;

      function dp_twoPhaseOverall_DP
        "Pressure loss of straight pipe for two phase flow | calculate (frictional, momentum, geodetic) pressure loss"
        extends Modelica.Icons.Function;
        //SOURCE_1: Friedel,L.:IMPROVED FRICTION PRESSURE DROP CORRELATIONS FOR HORIZONTAL AND VERTICAL TWO PHASE PIPE FLOW, 3R International, Vol. 18, Issue 7, pp. 485-491, 1979
        //SOURCE_2: Chisholm,D.:PRESSURE GRADIENTS DUE TO FRICTION DURING THE FLOW OF EVAPORATING TWO-PHASE MIXTURES IN SMOOTH TUBES AND CHANNELS, Int. J. Heat Mass Transfer, Vol. 16, pp. 347-358, Pergamon Press 1973
        //SOURCE_3: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.
        //SOURCE 4: J.M. Jensen and H. Tummescheit. Moving boundary models for dynamic simulations of two-phase flows. In Proceedings of the 2nd International Modelica Conference, pp. 235-244, Oberpfaffenhofen, Germany, 2002. The Modelica Association.
        //SOURCE_5: Thome, J.R., Engineering Data Book 3, Swiss Federal Institute of Technology Lausanne (EPFL), 2009.

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
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseFrictionalPressureLoss;

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
        //SOURCE_2: Considering frictional pressure loss w.r.t. to correlation of Chisholm
        SI.Pressure DP_fric=if IN_con.frictionalPressureLoss == TYP.Friedel then
          Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.dp_twoPhaseFriedel_DP(
            Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_con(A_cross=IN_con.A_cross, perimeter=IN_con.perimeter, length=IN_con.length),
            Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_var(rho_g=IN_var.rho_g, rho_l=IN_var.rho_l, eta_g=IN_var.eta_g, eta_l=IN_var.eta_l, sigma=IN_var.sigma, x_flow=IN_var.x_flow),
            m_flow) else if IN_con.frictionalPressureLoss == TYP.Chisholm then
          Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.dp_twoPhaseChisholm_DP(
            Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_con(A_cross=IN_con.A_cross, perimeter=IN_con.perimeter, length=IN_con.length),
            Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_var(rho_g=IN_var.rho_g, rho_l=IN_var.rho_l, eta_g=IN_var.eta_g, eta_l=IN_var.eta_l, sigma=IN_var.sigma, x_flow=IN_var.x_flow),
            m_flow) else 0 "Frictional pressure loss";

        //SOURCE_3: p.Lba 4, eq. 22: Considering momentum pressure loss assuming heterogeneous approach for two phase flow
        //Evaporation >> positive momentum pressure loss (assumed vice versa at condensation)
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

      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    Documentation(info="<html>
<p>
Calculation of pressure loss for <strong>two phase flow</strong> in a horizontal <strong>or</strong> vertical straight pipe for an overall flow regime considering frictional, momentum and geodetic pressure loss.
</p>

<p>
Generally the pressure loss for two phase flow in a horizontal or a vertical straight pipe can be calculated for the following fluid flow regimes:
</p>
<p>
<strong>Horizontal fluid flow</strong> [(a) bubble flow, (b) stratified flow, (c) wavy flow, (d) slug flow, (e) annular flow]:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/StraightPipe/twoPhaseFlowRegimes_horizontal.png\" alt=\"twoPhaseFlowRegimes_horizontal\"/>
</div>

<p>
<strong>Vertical fluid flow</strong> [(a) bubble flow, (b) plug slug flow, (c) foam flow, (d) annular streak flow, (e) annular flow]:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/StraightPipe/twoPhaseFlowRegimes_vertical.png\" alt=\"twoPhaseFlowRegimes_vertical\"/>
</div>

<p>
 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_twoPhaseOverall\">See more information</a>.
</p>
</html>"));
      end dp_twoPhaseOverall_DP;

      record dp_twoPhaseOverall_IN_con
        "Input record for function dp_twoPhaseOverall_DP"

        //choices
        Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseFrictionalPressureLoss
          frictionalPressureLoss=Dissipation.Utilities.Types.TwoPhaseFrictionalPressureLoss.Friedel
          "Choice of frictional pressure loss approach"
          annotation (Dialog(group="Choices"));
        Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach
          voidFractionApproach = Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous
          "Choice of void fraction approach" annotation (Dialog(group="Choices"));

        Boolean momentumPressureLoss=false "Considering momentum pressure loss"
          annotation (Dialog(group="Choices"));
        Boolean massFlowRateCorrection=false
          "Consider heterogeneous mass flow rate correction" annotation (Dialog(group=
               "Choices", enable= momentumPressureLoss));
        Boolean geodeticPressureLoss=false "Considering geodetic pressure loss"
          annotation (Dialog(group="Choices"));

        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_con;
        SI.Angle phi=0 "Tilt angle to horizontal"
          annotation (Dialog(group="Geometry"));

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_DP\"> dp_twoPhaseOverall_DP</a>.
</html>"));

      end dp_twoPhaseOverall_IN_con;

      record dp_twoPhaseOverall_IN_var
        "Input record for function dp_twoPhaseOverall_DP"

        Real x_flow_end=0 "Mass flow rate quality at end of length"
          annotation (Dialog(group="Fluid properties"));
        Real x_flow_sta=0 "Mass flow rate quality at start of length"
          annotation (Dialog(group="Fluid properties"));
        extends
          Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_var(final
            x_flow=(x_flow_end + x_flow_sta)/2);

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_DP\"> dp_twoPhaseOverall_DP</a>.
</html>"));

      end dp_twoPhaseOverall_IN_var;
      annotation (preferredView="info", Documentation(info="<html>
<h4>Straight Pipe</h4>
<h5>Laminar flow</h5>
<p>
Calculation of pressure loss in a straight pipe for <strong>laminar</strong> flow regime of single-phase fluid flow only.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_laminar\">See more information</a>.
</p>

<h5>Turbulent flow</h5>
<p>
Calculation of pressure loss in a straight pipe for <strong>turbulent</strong> flow regime of single-phase fluid flow only considering surface roughness.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_turbulent\">See more information</a>.
</p>

<h5>Overall flow</h5>
<p>
Calculation of pressure loss in a straight pipe for <strong>laminar or turbulent</strong> flow regime of single-phase fluid flow only considering surface roughness.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_overall\">See more information</a>.
</p>

<h5>Two phase overall flow</h5>
<p>
Calculation of pressure loss for <strong>two phase flow</strong> in a horizontal <strong>or</strong> vertical straight pipe for an overall flow regime considering frictional, momentum and geodetic pressure loss.
 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_twoPhaseOverall\">See more information</a>.
</p>
</html>"));
    end StraightPipe;

    package Valve "Package for pressure loss calculation of valves"
    extends Modelica.Icons.VariantsPackage;

      function dp_severalGeometryOverall_DP
        "Pressure loss of valve | calculate pressure loss | several geometries | overall flow regime"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.Valve;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;
        import TYP = Modelica.Fluid.Dissipation.Utilities.Types;

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

      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW(
                IN_con,
                IN_var,
                DP)), Documentation(info="<html>
<p>
Calculation of pressure loss for a valve with different geometries at overall flow regime for incompressible and single-phase fluid flow in dependence of its opening.
</p>

<p>
Generally this function is numerically best used for the <strong>incompressible case</strong>, where the mass flow rate (m_flow) is known (as state variable) in the used model and the corresponding pressure loss (DP) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW\">dp_severalGeometryOverall_MFLOW</a> is numerically best used for the <strong>compressible case</strong> if the pressure loss (dp) is known (out of pressures as state variable) and the mass flow rate (M_FLOW) has to be calculated. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Valve.dp_severalGeometryOverall\">See more information</a>.
</p>
</html>"));
      end dp_severalGeometryOverall_DP;

      function dp_severalGeometryOverall_MFLOW
        "Pressure loss of valve | calculate mass flow rate | several geometries | overall flow regime"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.Valve;
        import SMOOTH =
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;
        import TYP = Modelica.Fluid.Dissipation.Utilities.Types;

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
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2,
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP(
                IN_con,
                IN_var,
                M_FLOW)), Documentation(info="<html>
<p>
Calculation of pressure loss for a valve with different geometries at overall flow regime for incompressible and single-phase fluid flow in dependence of its opening.
</p>

<p>
Generally this function is numerically best used for the <strong>compressible case</strong>, where the pressure loss (dp) is known (out of pressures as state variable) in the used model and the corresponding mass flow rate (M_FLOW) has to be calculated. On the other hand the function <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP\">dp_severalGeometryOverall_DP</a> is numerically best used for the <strong>incompressible case</strong> if the mass flow rate (m_flow) is known (as state variable) and the pressure loss (DP) has to be calculated. <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Valve.dp_severalGeometryOverall\">See more information</a>.
</p>
</html>"));
      end dp_severalGeometryOverall_MFLOW;

      record dp_severalGeometryOverall_IN_con
        "Input record for function dp_severalGeometryOverall_DP and dp_severalGeometryOverall_MFLOW"

        extends Modelica.Icons.Record;

        Modelica.Fluid.Dissipation.Utilities.Types.ValveGeometry geometry=Dissipation.Utilities.Types.ValveGeometry.Ball
          "Choice of geometry for valve" annotation (Dialog(group="Valve"));
        Modelica.Fluid.Dissipation.Utilities.Types.ValveCoefficient
          valveCoefficient=
            Modelica.Fluid.Dissipation.Utilities.Types.ValveCoefficient.AV
          "Choice of valve coefficient" annotation (Dialog(group="Valve"));

        //valve variables
        Real Av=PI*0.1^2/4 "Av (metric) flow coefficient [Av]=m^2" annotation (Dialog(
              group="Valve", enable= valveCoefficient == 1));
        Real Kv=Av/27.7e-6 "Kv (metric) flow coefficient [Kv]=m^3/h" annotation (
            Dialog(group="Valve", enable= valveCoefficient == 2));
        Real Cv=Av/24.6e-6 "Cv (US) flow coefficient [Cv]=USG/min" annotation (Dialog(
              group="Valve", enable= valveCoefficient == 3));
        SI.Pressure dp_nominal=1e3 "Nominal pressure loss" annotation (Dialog(group=
                "Valve", enable= valveCoefficient == 4));
        SI.MassFlowRate m_flow_nominal=opening_nominal*Av*(rho_nominal*dp_nominal)^
            0.5 "Nominal mass flow rate" annotation (Dialog(group="Valve", enable=
                valveCoefficient == 4));
        SI.Density rho_nominal=1000 "Nominal inlet density" annotation (Dialog(group=
                "Valve", enable= valveCoefficient == 4));
        Real opening_nominal=0.5 "Nominal opening" annotation (Dialog(group="Valve",
              enable= valveCoefficient == 4));
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
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP\"> dp_severalGeometryOverall_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW\"> dp_severalGeometryOverall_MFLOW</a>.
</html>"));
      end dp_severalGeometryOverall_IN_con;

      record dp_severalGeometryOverall_IN_var
        "Input record for function dp_severalGeometryOverall_DP and dp_severalGeometryOverall_MFLOW"

        extends Modelica.Icons.Record;

        //valve variables
        Real opening=1 "Opening of valve | 0==closed and 1== fully opened"
          annotation (Dialog(group="Valve"));

        //fluid property variables
        SI.DynamicViscosity eta "Dynamic viscosity of fluid"
          annotation (Dialog(group="Fluid properties"));
        SI.Density rho "Density of fluid"
          annotation (Dialog(group="Fluid properties"));

        annotation (Documentation(info="<html>
This record is used as <strong>input record</strong> for the pressure loss function
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP\"> dp_severalGeometryOverall_DP</a> and
<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW\"> dp_severalGeometryOverall_MFLOW</a>.
</html>"));
      end dp_severalGeometryOverall_IN_var;
      annotation (preferredView="info", Documentation(info="<html>
<h4>Valve</h4>
<h5>Several geometries</h5>
<p>
Calculation of pressure loss for a valve with different geometries at overall flow regime for incompressible and single-phase fluid flow in dependence of its opening.
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Valve.dp_severalGeometryOverall\">See more information</a>.
</p>

</html>"));
    end Valve;
  end PressureLoss;

  package Utilities "Package for utilities (should not be used directly)"
  extends Modelica.Icons.UtilitiesPackage;
    package SharedDocumentation "Shared Documentation"
      extends Modelica.Icons.Information;

      package HeatTransfer
        extends Modelica.Icons.Information;

        package Channel
        extends Modelica.Icons.Information;

        class kc_evenGapLaminar
          extends Modelica.Icons.Information;
            annotation (Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a laminar fluid flow through an even gap at different fluid flow and heat transfer situations.
</p>
<h4>Functions <strong>kc_evenGapLaminar</strong> and <strong>kc_evenGapLaminar_KC</strong></h4>
<p>
There are basically three differences:
</p>
<ul>
<li>
The function <strong>kc_evenGapLaminar</strong>  is using <strong>kc_evenGapLaminar_KC</strong> but offers additional output variables like e.g. Reynolds number or Nusselt number and failure status (an output of <strong>1</strong> means that the function is not valid for the inputs).</li>
<li>
Generally the function <strong>kc_evenGapLaminar_KC</strong> is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known mass flow rate.</li>
<li>
You can perform an inverse calculation from <strong>kc_evenGapLaminar_KC</strong>, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <strong>kc</strong>
</li>
</ul>

<h4>Restriction</h4>
<ul>
<li>laminar regime (Reynolds number &le; 2200)</li>
<li>developed fluid flow
   <ul>
   <li>heat transfer from one side of the gap (target=Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap.DevOne)</li>
   <li>heat transfer from both sides of the gap (target=Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap.DevBoth)</li>
   </ul></li>
<li>undeveloped fluid flow
   <ul>
   <li>heat transfer from one side of the gap (target=Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap.UndevOne)
       <ul>
       <li>Prandtl number 0.1 &le; Pr &le; 10</li>
       </ul></li>
   <li>heat transfer from both sides of the gap (target=Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap.UndevBoth)
       <ul>
       <li>Prandtl number 0.1 &le; Pr &le; 1000</li>
       </ul></li>
   </ul></li>
</ul>

<h4>Geometry</h4>
<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Channel/gap.png\" alt=\"gap\"/>
</div>

<h4>Calculation</h4>
<p>
The mean convective heat transfer coefficient <strong>kc</strong> for an even gap is calculated through the corresponding Nusselt number <strong>Nu_lam</strong> according to <em>[VDI 2002, p. Gb 7, eq. 43]</em> :
</p>
<blockquote><pre>
Nu_lam = [(Nu_1)^3 + (Nu_2)^3 + (Nu_3)^3]^(1/3)
</pre></blockquote>

<p>
with the corresponding mean convective heat transfer coefficient <strong>kc</strong> :
</p>

<blockquote><pre>
kc =  Nu_lam * lambda / d_hyd
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> cp                      </strong></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><strong> d_hyd = 2*s             </strong></td><td> as hydraulic diameter of gap [m],</td></tr>
<tr><td><strong> eta                     </strong></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><strong> h                       </strong></td><td> as height of cross sectional area in gap [m],</td></tr>
<tr><td><strong> kc                      </strong></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><strong> lambda                  </strong></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><strong> L                       </strong></td><td> as overflowed length of gap (normal to cross sectional area) [m] ,</td></tr>
<tr><td><strong> Nu_lam                  </strong></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><strong> Pr = eta*cp/lambda      </strong></td><td> as Prandtl number [-],</td></tr>
<tr><td><strong> rho                     </strong></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><strong> s                       </strong></td><td> as distance between parallel plates of cross sectional area [m],</td></tr>
<tr><td><strong> Re = rho*v*d_hyd/eta    </strong></td><td> as Reynolds number [-],</td></tr>
<tr><td><strong> v                       </strong></td><td> as mean velocity in gap [m/s].</td></tr>
</table>

<p>
The summands for the mean Nusselt number <strong>Nu_lam</strong> at a chosen fluid flow and heat transfer situation are calculated as follows:
</p>
<ul>
<li>developed fluid flow
   <ul>
   <li>heat transfer from one side of the gap (target=1)
        <ul>
            <li>Nu_1 = 4.861</li>
            <li>Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3)</li>
            <li>Nu_3 = 0</li>
        </ul></li>
   <li>heat transfer from both sides of the gap (target=2)
        <ul>
            <li>Nu_1 = 7.541</li>
            <li>Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3)</li>
            <li>Nu_3 = 0</li>
        </ul></li>
   </ul></li>
<li>undeveloped fluid flow
   <ul>
   <li>heat transfer from one side of the gap (target=3)
        <ul>
            <li>Nu_1 = 4.861</li>
            <li>Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3)</li>
            <li>Nu_3 = [2/(1+22*Pr)]^(1/6)*(Re*Pr*d_hyd/L)^(1/2)</li>
        </ul></li>
   <li>heat transfer from both sides of the gap (target=4)
        <ul>
            <li>Nu_1 = 7.541</li>
            <li>Nu_2 = 1.841*(Re*Pr*d_hyd/L)^(1/3)</li>
            <li>Nu_3 = [2/(1+22*Pr)]^(1/6)*(Re*Pr*d_hyd/L)^(1/2)</li>
        </ul></li>
   </ul></li>
</ul>

<p>
Note that the fluid properties shall be calculated with an arithmetic mean temperature out of the fluid flow temperatures at the entrance and the exit of the gap.
</p>

<h4>Verification</h4>
<p>
The mean Nusselt number <strong>Nu_lam</strong> representing the mean convective heat transfer coefficient <strong>kc</strong> in dependence of
the chosen fluid flow and heat transfer situations (targets) is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Channel/kc_evenGapLaminar.png\" alt=\"kc_evenGapLaminar\"/>
</div>

<h4>References</h4>
<dl>
<dt>Bejan,A.:</dt>
    <dd><strong>Heat transfer handbook</strong>.
    Wiley, 2003.</dd>
<dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>
</html>"));
        end kc_evenGapLaminar;

        class kc_evenGapOverall
          extends Modelica.Icons.Information;
            annotation (Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for an laminar or turbulent fluid flow through an even gap at different fluid flow and heat transfer situations.
</p>

<h4>Functions <strong>kc_evenGapOverall</strong> and <strong>kc_evenGapOverall_KC</strong></h4>
<p>
There are basically three differences:
</p>
<ul>
<li>
The function <strong>kc_evenGapOverall</strong> is using <strong>kc_evenGapOverall_KC</strong> but offers additional output variables like e.g. Reynolds number or Nusselt number and failure status (an output of <strong>1</strong> means that the function is not valid for the inputs).</li>
<li>
Generally the function <strong>kc_evenGapOverall_KC</strong> is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known mass flow rate.</li>
<li>
You can perform an inverse calculation from <strong>kc_evenGapOverall_KC</strong>, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <strong>kc</strong>
</li>
</ul>

<h4>Restriction</h4>

<ul>
<li>developed fluid flow
   <ul>
   <li>heat transfer from one side of the gap (target=Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap.DevOne)</li>
   <li>heat transfer from both sides of the gap (target=Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap.DevBoth)</li>
   </ul></li>
<li>undeveloped fluid flow
   <ul>
   <li>heat transfer from one side of the gap (target=Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap.UndevOne)
       <ul>
       <li>Prandtl number 0.1 &le; Pr &le; 10</li>
       </ul></li>
   <li>heat transfer from both sides of the gap (target=Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap.UndevBoth)
   <ul>
       <li>Prandtl number 0.1 &le; Pr &le; 1000</li>
       </ul></li>
   </ul></li>
<li>turbulent regime always calculated for developed fluid flow and heat transfer from both sides of the gap (target=Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap.DevBoth)</li>
</ul>

<h4>Geometry and Calculation </h4>

<p>This heat transfer function enables a calculation of heat transfer coefficient for laminar and turbulent flow regime. The geometry, constant and fluid parameters of the function are the same as for
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar\">kc_evenGapLaminar</a>  and <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent\">kc_evenGapTurbulent</a>.
</p>
<p>
The calculation conditions for laminar and turbulent flow is equal to the calculation in <strong>kc_evenGapLaminar</strong>
and <strong>kc_evenGapTurbulent</strong>. A smooth transition between both functions is carried out between 2200 &le; Re &le; 30000 (see figure below).</p>

<h4>Verification</h4>
<p>
The mean Nusselt number <strong>Nu</strong> representing the mean convective heat transfer coefficient <strong>kc</strong> for Prandtl numbers of different fluids in dependence of
the chosen fluid flow and heat transfer situations (targets) is shown in the figures below.
</p>

<ul>
   <li>Target 1: Developed fluid flow and heat transfer from one side of the gap</li>
   <li>Target 2: Developed fluid flow and heat transfer from both sides of the gap</li>
   <li>Target 3: Undeveloped fluid flow and heat transfer from one side of the gap</li>
   <li>Target 4: Undeveloped fluid flow and heat transfer from both sides of the gap</li>
</ul>
<p>
The verification for all targets is shown in the following figure w.r.t. the reference:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Channel/kc_evenGapOverall.png\" alt=\"kc_evenGapOverall\"/>
</div>

<h4>References</h4>
<dl>
<dt>Bejan,A.:</dt>
    <dd><strong>Heat transfer handbook</strong>.
    Wiley, 2003.</dd>
<dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>"));
        end kc_evenGapOverall;

        class kc_evenGapTurbulent
          extends Modelica.Icons.Information;
            annotation (Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a developed turbulent fluid flow through an even gap at heat transfer from both sides.
</p>
<h4>Functions <strong>kc_evenGapTurbulent</strong> and <strong>kc_evenGapTurbulent_KC</strong></h4>
<p>
There are basically three differences:
</p>
<ul>
<li>
The function <strong>kc_evenGapTurbulent</strong> is using <strong>kc_evenGapTurbulent_KC</strong> but offers additional output variables like e.g. Reynolds number or Nusselt number and failure status (an output of <strong>1</strong> means that the function is not valid for the inputs).</li>
<li>
Generally the function <strong>kc_evenGapTurbulent_KC</strong> is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known mass flow rate.</li>
<li>
You can perform an inverse calculation from <strong>kc_evenGapTurbulent_KC</strong>, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <strong>kc</strong>
</li>
</ul>

<h4>Restriction</h4>

<ul>
<li>identical and constant wall temperatures</li>
<li>hydraulic diameter per gap length (d_hyd / L) &le; 1</li>
<li>0.5 &le; Prandtl number Pr &le; 100)</li>
<li>turbulent regime (3e4 &le; Reynolds number &le; 1e6)</li>
<li>developed fluid flow</li>
<li>heat transfer from both sides of the gap (target = Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap.DevBoth)</li>
</ul>

<h4>Geometry</h4>
<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Channel/gap.png\" alt=\"gap\"/>
</div>

<h4>Calculation</h4>
<p>
The mean convective heat transfer coefficient <strong>kc</strong> for an even gap is calculated through the corresponding Nusselt number <strong>Nu_turb</strong> according to <em>Gnielinski in [VDI 2002, p. Gb 7, sec. 2.4]</em>
</p>
<blockquote><pre>
Nu_turb =(zeta/8)*Re*Pr/{1+12.7*[zeta/8]^(0.5)*[Pr^(2/3) -1]}*{1+[d_hyd/L]^(2/3)}
</pre></blockquote>

<p>
where the pressure loss coefficient <strong>zeta</strong> according to <em> Konakov in [VDI 2002, p. Ga 5, eq. 27]</em> is determined by
</p>
<blockquote><pre>
zeta =  1/[1.8*log10(Re) - 1.5]^2
</pre></blockquote>

<p>
resulting to the corresponding mean convective heat transfer coefficient <strong>kc</strong>
</p>
<blockquote><pre>
kc =  Nu_turb * lambda / d_hyd
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> cp                      </strong></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><strong> d_hyd = 2*s             </strong></td><td> as hydraulic diameter of gap [m],</td></tr>
<tr><td><strong> eta                     </strong></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><strong> h                       </strong></td><td> as height of cross sectional area in gap [m],</td></tr>
<tr><td><strong> kc                      </strong></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><strong> lambda                  </strong></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><strong> L                       </strong></td><td> as overflowed length of gap (normal to cross sectional area) [m] ,</td></tr>
<tr><td><strong> Nu_turb                 </strong></td><td> as mean Nusselt number for turbulent regime [-], </td></tr>
<tr><td><strong> Pr = eta*cp/lambda      </strong></td><td> as Prandtl number [-],</td></tr>
<tr><td><strong> rho                     </strong></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><strong> s                       </strong></td><td> as distance between parallel plates of cross sectional area [m],</td></tr>
<tr><td><strong> Re = rho*v*d_hyd/eta    </strong></td><td> as Reynolds number [-],</td></tr>
<tr><td><strong> v                       </strong></td><td> as mean velocity in gap [m/s],</td></tr>
<tr><td><strong> zeta                    </strong></td><td> as pressure loss coefficient [-].</td></tr>
</table>

<p>
Note that the fluid flow properties shall be calculated with an arithmetic mean temperature out of the fluid flow temperatures at the entrance and the exit of the gap.
</p>

<h4>Verification</h4>
<p>
The mean Nusselt number <strong>Nu_turb</strong> representing the mean convective heat transfer coefficient <strong>kc</strong> in dependence of
the chosen fluid flow and heat transfer situations (targets) is shown in the figure below.
</p>
<ul>
   <li>Target 2: Developed fluid flow and heat transfer from both sides of the gap</li>
</ul>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Channel/kc_evenGapTurbulent.png\" alt=\"kc_evenGapTurbulent\"/>
</div>

<h4>References</h4>
<dl>
<dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>"));
        end kc_evenGapTurbulent;

        end Channel;

        package General
        extends Modelica.Icons.Information;

        class kc_approxForcedConvection
          extends Modelica.Icons.Information;
            annotation (Documentation(info="<html>
<p>
Approximate calculation of the mean convective heat transfer coefficient <strong>kc</strong> for forced convection with a fully developed fluid flow in a turbulent regime.
</p>

<h4>Functions <strong>kc_approxForcedConvection</strong> and <strong>kc_approxForcedConvection_KC</strong></h4>
<p>
There are basically three differences:
</p>
<ul>
<li>
The function <strong>kc_approxForcedConvection</strong> is using <strong>kc_approxForcedConvection_KC</strong> but offers additional output variables like e.g. Reynolds number or Nusselt number and failure status (an output of <strong>1</strong> means that the function is not valid for the inputs).</li>
<li>
Generally the function <strong>kc_approxForcedConvection_KC</strong> is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known mass flow rate.</li>
<li>
You can perform an inverse calculation from <strong>kc_approxForcedConvection_KC</strong>, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <strong>kc</strong>
</li>
</ul>

<h4>Restriction</h4>

<ul>
<li>Constant wall temperature <strong>or</strong> constant heat flux</li>
<li>Turbulent regime (Reynolds number 2500 &lt; Re &lt; 1e6)</li>
<li>Prandtl number 0.5 &le; Pr &le; 500</li>
</ul>

<h4>Calculation</h4>
<p>
The mean convective heat transfer coefficient <strong>kc</strong> is approximated through different Nusselt number <strong>Nu</strong> correlations out of <em>[Bejan 2003, p. 424 ff]</em>.<br>
Roughest approximation according to Dittus/Boelter (1930):
</p>
<blockquote><pre>
Nu_1 = 0.023 * Re^(4/5) * Pr^(exp_Pr)
</pre></blockquote>

<p>
Middle approximation according to Sieder/Tate (1936) considering the temperature dependence of the fluid properties:
</p>
<blockquote><pre>
Nu_2 = 0.023 * Re^(4/5) * Pr^(1/3) * (eta/eta_wall)^(0.14)
</pre></blockquote>

<p>
Finest approximation according to Gnielinski (1976):
</p>
<blockquote><pre>
Nu_3 = 0.0214 * [Re^(0.8) - 100] * Pr^(0.4) for Pr &le; 1.5
     = 0.012 * [Re^(0.87) - 280] * Pr^(0.4) for Pr &gt; 1.5
</pre></blockquote>

<p>
The mean convective heat transfer coefficient <strong>kc</strong> is calculated by:
</p>

<blockquote><pre>
kc =  Nu * lambda / d_hyd
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> eta                          </strong></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><strong> eta_wall                     </strong></td><td> as dynamic viscosity of fluid at wall temperature [Pa.s],</td></tr>
<tr><td><strong> exp_Pr                       </strong></td><td> as exponent for Prandtl number w.r.t. Dittus/Boelter (0.4 for heating or 0.3 for cooling) [-],</td></tr>
<tr><td><strong> kc                           </strong></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><strong> lambda                       </strong></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><strong> d_hyd                        </strong></td><td> as hydraulic diameter [m],</td></tr>
<tr><td><strong> Nu_1/2/3                     </strong></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><strong> Pr                           </strong></td><td> as Prandtl number [-],</td></tr>
<tr><td><strong> Re                           </strong></td><td> as Reynolds number [-].</td></tr>
</table>

<h4>Verification</h4>
<p>
The mean Nusselt number <strong>Nu</strong> representing the mean convective heat transfer coefficient <strong>kc</strong> for Prandtl numbers of different fluids is shown in the figure below.</p>
<p><strong>Dittus/Boelter</strong> (target = Modelica.Fluid.Dissipation.Utilities.Types.kc_general.Rough)
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/General/kc_approxForcedConvection_T1.png\" alt=\"kc_approxForcedConvection_T1\"/>
</div>

<p>
<strong>Sieder/Tate</strong> (Target = Modelica.Fluid.Dissipation.Utilities.Types.kc_general.Middle)
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/General/kc_approxForcedConvection_T2.png\" alt=\"kc_approxForcedConvection_T2\"/>
</div>

<p>
<strong>Gnielinski</strong> (Target = Modelica.Fluid.Dissipation.Utilities.Types.kc_general.Finest)
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/General/kc_approxForcedConvection_T3.png\" alt=\"kc_approxForcedConvection_T3\"/>
</div>

<p>
Note that all fluid properties shall be calculated with the mean temperature of the fluid between the entrance and the outlet of the generic device.
</p>

<h4>References</h4>
<dl>
<dt>Bejan,A.:</dt>
    <dd><strong>Heat transfer handbook</strong>.
    Wiley, 2003.</dd>
</dl>

</html>"));
        end kc_approxForcedConvection;
        end General;

        package HeatExchanger
        extends Modelica.Icons.Information;

        class kc_flatTube
          extends Modelica.Icons.Information;
            annotation (Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for the air-side heat transfer of heat exchangers with flat tubes and several fin geometries.
</p>
<h4>Functions <strong>kc_flatTube</strong> and <strong>kc_flatTube_KC</strong></h4>
<p>
There are basically three differences:
</p>
<ul>
<li>
The function <strong>kc_flatTube</strong> is using <strong>kc_flatTube_KC</strong> but offers additional output variables like e.g. Reynolds number or Nusselt number and failure status (an output of <strong>1</strong> means that the function is not valid for the inputs).</li>
<li>
Generally the function <strong>kc_flatTube_KC</strong> is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known mass flow rate.</li>
<li>
You can perform an inverse calculation from <strong>kc_flatTube_KC</strong>, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <strong>kc</strong>
</li>
</ul>

<h4>Restriction</h4>
<ul>
<li>According to the kind of fin geometry the calculation is valid in a range of <strong>Re</strong> from 100 to 5000.</li>
<li>medium = air</li>
</ul>

<h4>Geometry </h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HeatExchanger/flatTube.png\" width=\"850\" alt=\"flatTube\"/>
</div>

<h4>Calculation</h4>
<p>
The mean convective heat transfer coefficient <strong>kc</strong> for heat exchanger is calculated through the corresponding Coulburn factor <strong>j</strong>:
</p>
<blockquote><pre>
j = f(geometry, Re)
</pre></blockquote>

<p>
with the resulting mean convective heat transfer coefficient <strong>kc</strong>
</p>

<blockquote><pre>
kc =  j * Re_L_p * Pr^(1/3) * lambda / L_p (Louver fin)
</pre></blockquote>

 <p>
or
</p>

<blockquote><pre>
kc =  j * Re_D_h * Pr^(1/3) * lambda / D_h (Rectangular offset strip fin)
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> D_h                        </strong></td><td> as hydraulic diameter [m],</td></tr>
<tr><td><strong> kc                         </strong></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><strong> lambda                     </strong></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><strong> L_p                        </strong></td><td> as louver pitch [m],</td></tr>
<tr><td><strong> Nu_D_h = kc*D_h/lambda     </strong></td><td> as mean Nusselt number based on hydraulic diameter [-], </td></tr>
<tr><td><strong> Nu_L_p = kc*L_p/lambda     </strong></td><td> as mean Nusselt number based on louver pitch [-], </td></tr>
<tr><td><strong> Pr = eta*cp/lambda         </strong></td><td> as Prandtl number [-],</td></tr>
<tr><td><strong> Re_D_h = rho*v*D_h/eta     </strong></td><td> as Reynolds number based on hydraulic diameter [-],</td></tr>
<tr><td><strong> Re_L_p = rho*v*L_p/eta     </strong></td><td> as Reynolds number based on louver pitch [-],</td></tr>
</table>

<h4>Verification</h4>
<p>
The mean Nusselt number <strong>Nu</strong> representing the mean convective heat transfer coefficient <strong>kc</strong> is shown below for different fin geometries at similar dimensions.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HeatExchanger/kc_flatTube.png\" alt=\"kc_flatTube\"/>
</div>

<h4>References</h4>
<dl>
 <dt>Y.-J. CHANG and C.-C. WANG:</dt>
    <dd><strong>A generalized heat transfer correlation for louver fin geometry</strong>.
    In International Journal of Heat and Mass Transfer, volume 40, No. 3,  pages 533-544, 1997.</dd>
 <dt>Y.-J. CHANG and C.-C. WANG:</dt>
    <dd><strong>Air Side Performance of Brazed Aluminium Heat Exchangers</strong>.
    In Journal of Enhanced Heat Transfer, volume 3, No. 1,  pages 15-28, 1996.</dd>
 <dt>R.-M. Manglik, A.-E. Bergles:</dt>
    <dd><strong>Heat Transfer and Pressure Drop Correlations for the Rectangular Offset Strip Fin Compact Heat Exchanger</strong>.
    In Experimental Thermal and Fluid Science, volume 10, pages 171-180, 1995.</dd>
</dl>

</html>"));
        end kc_flatTube;

        class kc_roundTube
          extends Modelica.Icons.Information;
            annotation (Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for the air-side heat transfer of heat exchangers with round tubes and several fin geometries.
</p>
<h4>Functions <strong>kc_roundTube</strong> and <strong>kc_roundTube_KC</strong></h4>
<p>
There are basically three differences:
</p>
<ul>
<li>
The function <strong>kc_roundTube</strong> is using <strong>kc_roundTube_KC</strong> but offers additional output variables like e.g. Reynolds number or Nusselt number and failure status (an output of <strong>1</strong> means that the function is not valid for the inputs).</li>
<li>
Generally the function <strong>kc_roundTube_KC</strong> is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known mass flow rate.</li>
<li>
You can perform an inverse calculation from <strong>kc_roundTube_KC</strong>, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <strong>kc</strong>
</li>
</ul>

<h4>Restriction</h4>
<ul>
<li>According to the kind of fin geometry the calculation is valid in a range of <strong>Re</strong> from 300 to 8000.</li>
<li>medium = air</li>
</ul>

<h4>Geometry </h4>
<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HeatExchanger/roundTube.png\" width=\"850\" alt=\"roundTube\"/>
</div>

<h4>Calculation</h4>
<p>
The mean convective heat transfer coefficient <strong>kc</strong> for heat exchanger is calculated through the corresponding Coulburn factor <strong>j</strong>:
</p>

<blockquote><pre>
j = f(geometry, Re)
</pre></blockquote>

<p>
with the resulting mean convective heat transfer coefficient <strong>kc</strong>
</p>

<blockquote><pre>
kc =  j * Re * Pr^(1/3) * lambda / D_c
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> D_c                        </strong></td><td> as fin collar diameter [m],</td></tr>
<tr><td><strong> kc                         </strong></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><strong> lambda                     </strong></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><strong> Nu = kc*D_c/lambda         </strong></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><strong> Pr = eta*cp/lambda         </strong></td><td> as Prandtl number [-],</td></tr>
<tr><td><strong> Re = rho*v*D_c/eta         </strong></td><td> as Reynolds number [-],</td></tr>
</table>

<h4>Verification</h4>
<p>
The mean Nusselt number <strong>Nu</strong> representing the mean convective heat transfer coefficient <strong>kc</strong> is shown below for different fin geometries at similar dimensions.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HeatExchanger/kc_roundTube.png\" alt=\"kc_roundTube\"/>
</div>

<h4>References</h4>
<dl>
 <dt>C.-C. Wang, C.-T. Chang:</dt>
    <dd><strong>Heat and mass transfer for plate fin-and-tube heat exchangers, with and without hydrophilic coating</strong>.
    In International Journal of Heat and Mass Transfer, volume 41, pages 3109-3120, 1998.</dd>
 <dt>C.-C. Wang, C.-J. Lee, C.-T. Chang, S.-P. Lina:</dt>
    <dd><strong>Heat transfer and friction correlation for compact louvered fin-and-tube heat exchangers</strong>.
    In International Journal of Heat and Mass Transfer, volume 42, pages 1945-1956, 1999.</dd>
 <dt>C.-C. Wang, W.-H. Tao, C.-J. Chang:</dt>
    <dd><strong>An investigation of the airside performance of the slit fin-and-tube heat exchangers</strong>.
    In International Journal of Refrigeration, volume 22, pages 595-603, 1999.</dd>
 <dt>C.-C. Wang, W.-L. Fu, C.-T. Chang:</dt>
    <dd><strong>Heat Transfer and Friction Characteristics of Typical Wavy Fin-and-Tube Heat Exchangers</strong>.
    In Experimental Thermal and Fluid Science, volume 14, pages 174-186, 1997.</dd>
</dl>
</html>"));
        end kc_roundTube;

        end HeatExchanger;

        package HelicalPipe
        extends Modelica.Icons.Information;

        class kc_laminar
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a helical pipe in the laminar flow regime.
</p>
<h4>Functions <strong>kc_laminar</strong> and <strong>kc_laminar_KC</strong></h4>
<p>
There are basically three differences:
</p>
<ul>
<li>
The function <strong>kc_laminar</strong> is using <strong>kc_laminar_KC</strong> but offers additional output variables like e.g. Reynolds number or Nusselt number and failure status (an output of <strong>1</strong> means that the function is not valid for the inputs).</li>
<li>
Generally the function <strong>kc_laminar_KC</strong> is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known mass flow rate.</li>
<li>
You can perform an inverse calculation from <strong>kc_laminar_KC</strong>, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <strong>kc</strong>
</li>
</ul>

<h4>Restriction</h4>

<ul>
  <li>laminar regime (Reynolds number &le; critical Reynolds number <strong>Re_crit</strong>)</li>
  <li>neglect influence of heat transfer direction (heating/cooling) according to <em>Sieder and Tate</em></li>
</ul>

<p>
The critical Reynolds number <strong>Re_crit</strong> in a helical pipe depends on its mean curvature diameter <strong>d_coil</strong>.
The smaller the mean curvature diameter of the helical pipe, the
earlier the turbulent regime will start due to vortexes out of higher
centrifugal forces.
</p>

<h4>Geometry </h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HelicalPipe/helicalPipe.png\" alt=\"helicalPipe\"/>
</div>

<h4>Calculation</h4>
<p>
The mean convective heat transfer coefficient <strong>kc</strong> for helical pipes is calculated through the corresponding Nusselt number <strong>Nu</strong> according to <em>[VDI 2002, p. Gc 2, eq. 5]</em> :
</p>

<blockquote><pre>
Nu = 3.66 + 0.08*[1 + 0.8*(d_hyd/d_coil)^0.9]*Re^m*Pr^(1/3)
</pre></blockquote>

<p>
with the exponent <strong>m</strong> for the Reynolds number
</p>

<blockquote><pre>
m = 0.5 + 0.2903*(d_hyd/d_coil)^0.194
</pre></blockquote>

<p>
and the resulting mean convective heat transfer coefficient <strong>kc</strong>
</p>

<blockquote><pre>
kc =  Nu * lambda / d_hyd
</pre></blockquote>

<p>
with
</p>

<table>

  <tbody>
    <tr>
      <td><strong> d_mean</strong></td>
      <td> as mean diameter of helical pipe [m],</td>
    </tr>

    <tr>
      <td><strong> d_coil = f(geometry)</strong></td>
      <td> as mean curvature diameter of helical pipe [m],</td>
    </tr>

    <tr>
      <td><strong>d_hyd</strong></td>
      <td> as hydraulic diameter of the helical pipe [m],</td>
    </tr>

    <tr>
      <td><strong>h</strong></td>
      <td> as slope of helical pipe [m],</td>
    </tr>

    <tr>
      <td><strong>kc</strong></td>
      <td> as mean convective heat transfer coefficient [W/(m2K)],</td>
    </tr>

    <tr>
      <td><strong>lambda</strong></td>
      <td> as heat conductivity of fluid [W/(mK)],</td>
    </tr>

    <tr>
      <td><strong>L</strong></td>
      <td> as total length of helical pipe [m],</td>
    </tr>

    <tr>
      <td><strong>Nu = kc*d_hyd/lambda</strong></td>
      <td> as mean Nusselt number [-], </td>
    </tr>

    <tr>
      <td><strong>Pr = eta*cp/lambda</strong></td>
      <td> as Prandtl number [-],</td>
    </tr>

    <tr>
      <td><strong>Re = rho*v*d_hyd/eta</strong></td>
      <td> as Reynolds number [-],</td>
    </tr>

    <tr>
      <td><strong>Re_crit = f(geometry)</strong></td>
      <td> as critical Reynolds number [-].</td>
    </tr>

  </tbody>
</table>

<h4>Verification</h4>
<p>
The mean Nusselt number <strong>Nu</strong> representing the mean convective heat transfer coefficient <strong>kc</strong> is shown below for different numbers of turns <strong>n_nt</strong> at constant total length of the helical pipe.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HelicalPipe/kc_laminar.png\" alt=\"kc_laminar\"/>
</div>

<p>The convective heat transfer of a helical pipe is enhanced compared
to a straight pipe due to occurring turbulences resulting out of
centrifugal forces. The higher the number of turns, the better is the
convective heat transfer for the same length of a pipe.
</p>
<p>
Note that the ratio of hydraulic diameter to total length of helical pipe <strong>d_hyd/L</strong> has no remarkable influence on the coefficient of heat transfer <strong>kc</strong>.
</p>
<h4>References</h4>
<dl>
 <dt>GNIELINSKI, V.:</dt>
    <dd><strong>Heat transfer and pressure drop in helically coiled tubes.</strong>.
    In 8th International Heat Transfer Conference, volume 6, pages 2847-2854, Washington,1986. Hemisphere.</dd>
</dl>
</html>"));
        end kc_laminar;

        class kc_overall
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> of a helical pipe in a hydrodynamically developed laminar and turbulent flow regime.
</p>
<h4>Functions <strong>kc_overall</strong> and <strong>kc_overall_KC</strong></h4>
<p>
There are basically three differences:
</p>
<ul>
<li>
The function <strong>kc_overall</strong> is using <strong>kc_overall_KC</strong> but offers additional output variables like e.g. Reynolds number or Nusselt number and failure status (an output of <strong>1</strong> means that the function is not valid for the inputs).</li>
<li>
Generally the function <strong>kc_overall_KC</strong> is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known mass flow rate.</li>
<li>
You can perform an inverse calculation from <strong>kc_overall_KC</strong>, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <strong>kc</strong>
</li>
</ul>

<h4>Geometry and Calculation </h4>

<p>This heat transfer function enables a calculation of heat transfer coefficient for laminar and turbulent flow regime. The geometry, constant and fluid parameters of the function are the same as for
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar\">kc_laminar</a>  and <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent\">kc_turbulent</a>.
</p>
<p>
The calculation conditions for laminar and turbulent flow is equal to the calculation in <strong>kc_laminar</strong>
and <strong>kc_turbulent</strong>. A smooth transition between both functions is carried out between 2200 &le; Re &le; 30000 (see figure below).</p>

<h4>Verification</h4>
<p>
The mean Nusselt number <strong>Nu</strong> representing the mean convective heat transfer coefficient <strong>kc</strong> is shown below for different numbers of turns <strong>n_nt</strong> at constant total length of the helical pipe.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HelicalPipe/kc_overall.png\" alt=\"kc_overall\"/>
</div>

<p>
The convective heat transfer of a helical pipe is enhanced compared to a straight pipe due to occurring turbulences resulting out of centrifugal forces. The higher the number of turns, the better is the convective heat transfer for the same length of a pipe.
</p>

<p>
Note that the ratio of hydraulic diameter to total length of helical pipe <strong>d_hyd/L</strong> has no remarkable influence on the coefficient of heat transfer <strong>kc</strong>.
</p>

<h4>References</h4>
<dl>
 <dt>GNIELINSKI, V.:</dt>
    <dd><strong>Heat transfer and pressure drop in helically coiled tubes.</strong>.
    In 8th International Heat Transfer Conference, volume 6, pages 2847?2854, Washington,1986. Hemisphere.</dd>
</dl>
</html>"));
        end kc_overall;

        class kc_turbulent
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> of a helical pipe for turbulent flow regime.
</p>
<h4>Functions <strong>kc_turbulent</strong> and <strong>kc_turbulent_KC</strong></h4>

<p>
There are basically three differences:
</p>
<ul>
<li>
The function <strong>kc_turbulent</strong> is using <strong>kc_turbulent_KC</strong> but offers additional output variables like e.g. Reynolds number or Nusselt number and failure status (an output of <strong>1</strong> means that the function is not valid for the inputs).
</li>
<li>
Generally the function <strong>kc_turbulent_KC</strong> is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known mass flow rate.</li>
<li>
You can perform an inverse calculation from <strong>kc_turbulent_KC</strong>, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <strong>kc</strong>
</li>
</ul>

<p>
The critical Reynolds number <strong>Re_crit</strong> in a helical pipe depends on its mean curvature diameter. The smaller the mean curvature diameter of the helical pipe <strong>d_mean</strong>, the earlier the turbulent regime will start due to vortexes out of higher centrifugal forces.
</p>
<h4>Geometry </h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HelicalPipe/helicalPipe.png\" alt=\"helicalPipe\"/>
</div>

<h4>Calculation</h4>
<p>
The mean convective heat transfer coefficient <strong>kc</strong> for helical pipes is calculated through the corresponding Nusselt number <strong>Nu</strong> according to <em>[VDI 2002, p. Ga 2, eq. 6]</em>:
</p>
<blockquote><pre>
Nu = (zeta_TOT/8)*Re*Pr/{1 + 12.7*(zeta_TOT/8)^0.5*[Pr^(2/3)-1]},
</pre></blockquote>

<p>
where the influence of the pressure loss on the heat transfer calculation is considered through
</p>
<blockquote><pre>
zeta_TOT = 0.3164*Re^(-0.25) + 0.03*(d_hyd/d_coil)^(0.5) and
</pre></blockquote>

<p>
and the resulting mean convective heat transfer coefficient <strong>kc</strong>
</p>

<blockquote><pre>
kc =  Nu * lambda / d_hyd
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> d_mean                     </strong></td><td> as mean diameter of helical pipe [m],</td></tr>
<tr><td><strong> d_coil = f(geometry)       </strong></td><td> as mean curvature diameter of helical pipe [m],</td></tr>
<tr><td><strong> d_hyd                      </strong></td><td> as hydraulic diameter of the helical pipe [m],</td></tr>
<tr><td><strong> h                          </strong></td><td> as slope of helical pipe [m],</td></tr>
<tr><td><strong> kc                         </strong></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><strong> lambda                     </strong></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><strong> L                          </strong></td><td> as total length of helical pipe [m],</td></tr>
<tr><td><strong> Nu = kc*d_hyd/lambda       </strong></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><strong> Pr = eta*cp/lambda         </strong></td><td> as Prandtl number [-],</td></tr>
<tr><td><strong> Re = rho*v*d_hyd/eta       </strong></td><td> as Reynolds number [-],</td></tr>
<tr><td><strong> Re_crit = f(geometry)      </strong></td><td> as critical Reynolds number [-].</td></tr>
</table>

<h4>Verification</h4>
<p>
The mean Nusselt number <strong>Nu</strong> representing the mean convective heat transfer coefficient <strong>kc</strong> is shown below for different numbers of turns <strong>n_nt</strong> at constant total length of the helical pipe.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HelicalPipe/kc_turbulent.png\" alt=\"kc_turbulent\"/>
</div>

<p>
The convective heat transfer of a helical pipe is enhanced compared to a straight pipe due to occurring turbulences resulting out of centrifugal forces. The higher the number of turns, the better is the convective heat transfer for the same length of a pipe.
</p>

<p>
Note that the ratio of hydraulic diameter to total length of helical pipe <strong>d_hyd/L</strong> has no remarkable influence on the coefficient of heat transfer <strong>kc</strong>.
</p>

<h4>References</h4>
<dl>
 <dt>GNIELINSKI, V.:</dt>
    <dd><strong>Heat transfer and pressure drop in helically coiled tubes.</strong>.
    In 8th International Heat Transfer Conference, volume 6, pages 2847?2854, Washington,1986. Hemisphere.</dd>
</dl>
</html>"));
        end kc_turbulent;

        end HelicalPipe;

        package Plate
        extends Modelica.Icons.Information;

        class kc_laminar
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a laminar fluid flow over an even surface.
</p>

<h4>Functions <strong>kc_laminar</strong> and <strong>kc_laminar_KC</strong></h4>
<p>
There are basically three differences:
</p>

<ul>
<li>
The function <strong>kc_laminar</strong> is using <strong>kc_laminar_KC</strong> but offers additional output variables like e.g. Reynolds number or Nusselt number and failure status (an output of <strong>1</strong> means that the function is not valid for the inputs).</li>
<li>
Generally the function <strong>kc_laminar_KC</strong> is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known mass flow rate.</li>
<li>
You can perform an inverse calculation from <strong>kc_laminar_KC</strong>, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <strong>kc</strong>
</li>
</ul>

<h4>Restriction</h4>

<ul>
<li>laminar regime (Reynolds number &le; 1e5)</li>
<li>Prandtl number 0.6 &le; Pr &le; 2000</li>
</ul>

<h4>Geometry </h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Plate/plate.png\" alt=\"plate\"/>
</div>

<h4>Calculation</h4>
<p>
The mean convective heat transfer coefficient <strong>kc</strong> for flat plate is calculated through the corresponding Nusselt number <strong>Nu_lam</strong> according to <em>[VDI 2002, p. Gd 1, eq. 1]</em> :
</p>
<blockquote><pre>
Nu_lam = 0.664 * Re^(0.5) * (Pr)^(1/3)
</pre></blockquote>

<p>
and the corresponding mean convective heat transfer coefficient <strong>kc</strong>:
</p>
<blockquote><pre>
kc =  Nu_lam * lambda / L
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> cp                 </strong></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><strong> eta                </strong></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><strong> kc                 </strong></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><strong> lambda         </strong></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><strong> L              </strong></td><td> as length of plate [m],</td></tr>
<tr><td><strong> Nu_lam                  </strong></td><td> as mean Nusselt number for laminar regime [-], </td></tr>
<tr><td><strong> Pr = eta*cp/lambda           </strong></td><td> as Prandtl number [-],</td></tr>
<tr><td><strong> rho          </strong></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><strong> Re = rho*v*L/eta    </strong></td><td> as Reynolds number [-].</td></tr>
</table>

<h4>Verification</h4>
<p>
The mean Nusselt number <strong>Nu</strong> in the laminar regime representing the mean convective heat transfer coefficient <strong>kc</strong> for Prandtl numbers of different fluids is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Plate/kc_laminar.png\" width=\"600\" alt=\"kc_laminar\"/>
</div>

<p>
Note that this function is best used in the laminar regime up to a Reynolds number <strong>Re</strong> smaller than 2300. There is a deviation w.r.t. literature due to the neglect of the turbulence influence in the transition regime even though this function is used inside its cited restrictions for a higher Reynolds number. The function
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_overall\">kc_overall</a> is recommended for the simulation of a Reynolds number higher than 2300.
</p>
<h4>References</h4>
<dl>
<dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>"));
        end kc_laminar;

        class kc_overall
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a laminar or turbulent fluid flow over an even surface.
</p>
<h4>Functions <strong>kc_overall</strong> and <strong>kc_overall_KC</strong></h4>
<p>
There are basically three differences:
</p>
<ul>
<li>
The function <strong>kc_overall</strong> is using <strong>kc_overall_KC</strong> but offers additional output variables like e.g. Reynolds number or Nusselt number and failure status (an output of <strong>1</strong> means that the function is not valid for the inputs).</li>
<li>
Generally the function <strong>kc_overall_KC</strong> is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known mass flow rate.</li>
<li>
You can perform an inverse calculation from <strong>kc_overall_KC</strong>, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <strong>kc</strong>
</li>
</ul>

<h4>Restriction</h4>
<ul>
<li>constant wall temperature</li>
<li>overall regime (Reynolds number 1e1 &lt; Re &lt; 1e7)</li>
<li>Prandtl number 0.6 &le; Pr &le; 2000</li>
</ul>

<h4>Geometry and Calculation </h4>
<p>This heat transfer function enables a calculation of heat transfer coefficient for laminar and turbulent flow regime. The geometry, constant and fluid parameters of the function are the same as for
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar\">kc_laminar</a>  and <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent\">kc_turbulent</a>.
</p>
<p>
The calculation conditions for laminar and turbulent flow is equal to the calculation in <strong>kc_laminar</strong>
and <strong>kc_turbulent</strong>. A smooth transition between both functions is carried out between 1e5 &le; Re &le; 5e5 (see figure below).
</p>
<h4>Verification</h4>
<p>
The mean Nusselt number <strong>Nu = sqrt(Nu_lam^2 + Nu_turb^2)</strong> representing the mean convective heat transfer coefficient <strong>kc</strong> for Prandtl numbers of different fluids is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Plate/kc_overall.png\" alt=\"kc_overall\"/>
</div>

<h4>References</h4>
<dl>
<dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>"));
        end kc_overall;

        class kc_turbulent
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html>
<p>
Calculation of the mean convective heat transfer coefficient <strong>kc</strong> for a hydrodynamically developed turbulent fluid flow over an even surface.
</p>
<h4>Functions <strong>kc_turbulent</strong> and <strong>kc_turbulent_KC</strong></h4>
<p>
There are basically three differences:
</p>
<ul>
<li>
The function <strong>kc_turbulent</strong> is using <strong>kc_turbulent_KC</strong> but offers additional output variables like e.g. Reynolds number or Nusselt number and failure status (an output of <strong>1</strong> means that the function is not valid for the inputs).</li>
<li>
Generally the function <strong>kc_turbulent_KC</strong> is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known mass flow rate.</li>
<li>
You can perform an inverse calculation from <strong>kc_turbulent_KC</strong>, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <strong>kc</strong>
</li>
</ul>

<h4>Restriction</h4>
<ul>
<li>constant wall temperature</li>
<li>turbulent regime (Reynolds number 5e5 &lt; Re &lt; 1e7)</li>
<li>Prandtl number 0.6 &le; Pr &le; 2000</li>
</ul>

<h4>Geometry </h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Plate/plate.png\" alt=\"plate\"/>
</div>

<h4>Calculation</h4>
<p>
The mean convective heat transfer coefficient <strong>kc</strong> for flat plate is calculated through the corresponding Nusselt number <strong>Nu_turb</strong> according to <em>[VDI 2002, p. Gd 1, eq. 2]</em>:
</p>

<blockquote><pre>
Nu_turb = (0.037 * Re^0.8 * Pr) / (1 + 2.443/Re^0.1 * (Pr^(2/3)-1))
</pre></blockquote>

<p>
and the corresponding mean convective heat transfer coefficient <strong>kc</strong>:
</p>

<blockquote><pre>
kc =  Nu_turb * lambda / L
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> cp          </strong></td><td> as specific heat capacity at constant pressure [J/(kg.K)],</td></tr>
<tr><td><strong> eta          </strong></td><td> as dynamic viscosity of fluid [Pa.s],</td></tr>
<tr><td><strong> kc          </strong></td><td> as mean convective heat transfer coefficient [W/(m2.K)],</td></tr>
<tr><td><strong> lambda         </strong></td><td> as heat conductivity of fluid [W/(m.K)],</td></tr>
<tr><td><strong> L              </strong></td><td> as length of plate [m],</td></tr>
<tr><td><strong> Nu_turb                 </strong></td><td> as mean Nusselt number for turbulent regime [-], </td></tr>
<tr><td><strong> Pr = eta*cp/lambda           </strong></td><td> as Prandtl number [-],</td></tr>
<tr><td><strong> rho          </strong></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><strong> Re = v*rho*L/eta    </strong></td><td> as Reynolds number [-].</td></tr>
</table>

<h4>Verification</h4>
<p>
The mean Nusselt number in turbulent regime <strong>Nu</strong> representing the mean convective heat transfer coefficient <strong>kc</strong> for Prandtl numbers of different fluids is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Plate/kc_turbulent.png\" alt=\"kc_turbulent\"/>
</div>

<h4>References</h4>
<dl>

<dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>"));
        end kc_turbulent;
        end Plate;

        package StraightPipe
        extends Modelica.Icons.Information;

        class kc_laminar
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html>
<p>
Calculation of mean convective heat transfer coefficient <strong>kc</strong> of a straight pipe at an uniform wall temperature <strong>or</strong> uniform heat flux <strong>and</strong> for a hydrodynamically developed <strong>or</strong> undeveloped laminar fluid flow.
</p>
<h4>Functions <strong>kc_laminar</strong> and <strong>kc_laminar_KC</strong></h4>
<p>
There are basically three differences:
</p>
<ul>
<li>
The function <strong>kc_laminar</strong> is using <strong>kc_laminar_KC</strong> but offers additional output variables like e.g. Reynolds number or Nusselt number and failure status (an output of <strong>1</strong> means that the function is not valid for the inputs).</li>
<li>
Generally the function <strong>kc_laminar_KC</strong> is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known mass flow rate.</li>
<li>
You can perform an inverse calculation from <strong>kc_laminar_KC</strong>, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <strong>kc</strong>
</li>
</ul>

<h4>Restriction</h4>
<ul>
<li>circular cross sectional area</li>
<li>uniform wall temperature (UWT) <strong>or</strong> uniform heat flux (UHF)</li>
<li>hydrodynamically developed fluid flow (DFF) <strong>or</strong> hydrodynamically undeveloped fluid flow (UFF)</li>
<li>0.6 &le; Prandtl number &le; 1000</li>
<li>laminar regime (Reynolds number &le; 2000)</li>
</ul>

<h4>Geometry </h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/straightPipe.png\" alt=\"straightPipe\"/>
</div>

<h4>Calculation</h4>
<p>
The mean convective heat transfer coefficient <strong>kc</strong> of a straight pipe in the laminar regime can be calculated for the following four heat transfer boundary conditions through its corresponding Nusselt number <strong>Nu</strong>:
</p>
<p>
<strong>Uniform wall temperature in developed fluid flow (heatTransferBoundary == Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UWTuDFF)</strong> according to <em>[VDI 2002, p. Ga 2, eq. 6]</em> :
</p>

<blockquote><pre>
Nu_TD = [3.66^3 + 0.7^3 + {1.615*(Re*Pr*d_hyd/L)^1/3 - 0.7}^3]^1/3
</pre></blockquote>

<p>
<strong>Uniform heat flux in developed fluid flow (heatTransferBoundary == Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UHFuDFF)</strong> according to <em>[VDI 2002, p. Ga 4, eq. 19]</em> :
</p>
<blockquote><pre>
Nu_qD = [4.364^3 + 0.6^3 + {1.953*(Re*Pr*d_hyd/L)^1/3 - 0.6}^3]^1/3
</pre></blockquote>

<p>
<strong>Uniform wall temperature in undeveloped fluid flow (heatTransferBoundary == Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UWTuUFF)</strong> according to <em>[VDI 2002, p. Ga 2, eq. 12]</em> :
</p>
<blockquote><pre>
Nu_TU = [3.66^3 + 0.7^3 + {1.615*(Re*Pr*d_hyd/L)^1/3 - 0.7}^3 + {(2/[1+22*Pr])^1/6*(Re*Pr*d_hyd/L)^0.5}^3]^1/3
</pre></blockquote>

<p>
<strong>Uniform heat flux in developed fluid flow (heatTransferBoundary == Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UHFuUFF)</strong> according to <em>[VDI 2002, p. Ga 5, eq. 25]</em> :
</p>

<blockquote><pre>
Nu_qU = [4.364^3 + 0.6^3 + {1.953*(Re*Pr*d_hyd/L)^1/3 - 0.6}^3 + {0.924*Pr^1/3*[Re*d_hyd/L]^0.5}^3]^1/3.
</pre></blockquote>

<p>
The corresponding mean convective heat transfer coefficient <strong>kc</strong> is determined w.r.t. the chosen heat transfer boundary by:
</p>

<blockquote><pre>
kc =  Nu * lambda / d_hyd
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> d_hyd                    </strong></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><strong> kc                       </strong></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><strong> lambda                   </strong></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><strong> L                        </strong></td><td> as length of straight pipe [m],</td></tr>
<tr><td><strong> Nu = kc*d_hyd/lambda     </strong></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><strong> Pr = eta*cp/lambda       </strong></td><td> as Prandtl number [-],</td></tr>
<tr><td><strong> Re = rho*v*d_hyd/eta     </strong></td><td> as Reynolds number [-],</td></tr>
<tr><td><strong> v                        </strong></td><td> as mean velocity [m/s].</td></tr>
</table>

<h4>Verification</h4>
<p>The mean Nusselt number <strong>Nu</strong> representing the mean convective heat transfer coefficient <strong>kc</strong> depending on four different heat transfer boundary conditions is shown in the figures below.
</p>
<p>
This verification has been done with the fluid properties of Water (Prandtl number Pr = 7) and a diameter to pipe length fraction of 0.1.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/StraightPipe/kc_laminar.png\" alt=\"kc_laminar\"/>
</div>

<h4>References</h4>
<dl>
 <dt>Bejan,A.:</dt>
    <dd><strong>Heat transfer handbook</strong>.
    Wiley, 2003.</dd>
 <dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>"));
        end kc_laminar;

        class kc_overall
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html>
<p>
Calculation of mean convective heat transfer coefficient <strong>kc</strong> of a straight pipe at an uniform wall temperature <strong>or</strong> uniform heat flux <strong>and</strong> for a hydrodynamically developed <strong>or</strong> undeveloped laminar or turbulent fluid flow with neglect <strong>or</strong> consideration of pressure loss influence.
</p>
<h4>Functions <strong>kc_overall</strong> and <strong>kc_overall_KC</strong></h4>
<p>
There are basically three differences:
</p>
<ul>
<li>
The function <strong>kc_overall</strong> is using <strong>kc_overall_KC</strong> but offers additional output variables like e.g. Reynolds number or Nusselt number and failure status (an output of <strong>1</strong> means that the function is not valid for the inputs).</li>
<li>
Generally the function <strong>kc_overall_KC</strong> is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known mass flow rate.</li>
<li>
You can perform an inverse calculation from <strong>kc_overall_KC</strong>, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <strong>kc</strong>
</li>
</ul>

<h4>Restriction</h4>
<ul>
<li>circular cross sectional area</li>
<li>uniform wall temperature (UWT) <strong>or</strong> uniform heat flux (UHF)</li>
<li>hydrodynamically developed fluid flow</li>
<li>hydraulic diameter / length &le; 1</li>
<li>0.6 &le; Prandtl number &le; 1000</li>
</ul>

<h4>Geometry and Calculation </h4>

<p>This heat transfer function enables a calculation of heat transfer coefficient for laminar and turbulent flow regime. The geometry, constant and fluid parameters of the function are the same as for
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar\">kc_laminar</a>  and <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent\">kc_turbulent</a>.
</p>
<p>
The calculation conditions for laminar and turbulent flow is equal to the calculation in <strong>kc_laminar</strong>
and <strong>kc_turbulent</strong>. A smooth transition between both functions is carried out between 2200 &le; Re &le; 10000 (see figure below).</p>

<h4>Verification</h4>
<p>
The mean Nusselt number <strong>Nu</strong> representing the mean convective heat transfer coefficient <strong>kc</strong> is shown for the fluid properties of Water (Prandtl number Pr = 7) and a diameter to pipe length fraction of 0.1 in the figure below.
</p>

<p>
The following verification considers pressure loss influence (roughness =2).
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/StraightPipe/kc_overall.png\" alt=\"kc_overall\"/>
</div>

<h4>References</h4>
<dl>
 <dt>Bejan,A.:</dt>
    <dd><strong>Heat transfer handbook</strong>.
    Wiley, 2003.</dd>
 <dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>"));
        end kc_overall;

        class kc_turbulent
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html>
<p>
Calculation of mean convective heat transfer coefficient <strong>kc</strong> of a straight pipe for a hydrodynamically developed turbulent fluid flow at uniform wall temperature <strong>or</strong> uniform heat flux with neglecting <strong>or</strong> considering of pressure loss influence.
</p>
<h4>Functions <strong>kc_turbulent</strong> and <strong>kc_turbulent_KC</strong></h4>
<p>
There are basically three differences:
</p>
<ul>
<li>
The function <strong>kc_turbulent</strong> is using <strong>kc_turbulent_KC</strong> but offers additional output variables like e.g. Reynolds number or Nusselt number and failure status (an output of <strong>1</strong> means that the function is not valid for the inputs).</li>
<li>
Generally the function <strong>kc_turbulent_KC</strong> is numerically best used for the calculation of the mean convective heat transfer coefficient <strong>kc</strong> at known mass flow rate.</li>
<li>
You can perform an inverse calculation from <strong>kc_turbulent_KC</strong>, where an unknown mass flow rate is calculated out of a given mean convective heat transfer coefficient <strong>kc</strong>
</li>
</ul>

<h4>Restriction</h4>

<ul>
<li>circular cross sectional area</li>
<li>hydrodynamically developed fluid flow</li>
<li>hydraulic diameter / length &le; 1</li>
<li>0.6 &le; Prandtl number &le; 1000</li>
<li>turbulent flow regime (1e4 &le; Reynolds number &le; 1e6)</li>
</ul>

<h4>Geometry </h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/straightPipe.png\" alt=\"straightPipe\"/>
</div>

<h4>Calculation</h4>
<p>
<strong>Neglect pressure loss influence (roughness == 1):</strong>
</p>
<p>
The mean convective heat transfer coefficient <strong>kc</strong> for smooth straight pipes is calculated through its corresponding Nusselt number <strong>Nu</strong> according to <em> [Dittus and Boelter in Bejan 2003, p. 424, eq. 5.76]</em>
</p>

<blockquote><pre>
Nu = 0.023 * Re^(4/5) * Pr^(1/3).
</pre></blockquote>

<p>
<strong>Consider pressure loss influence (roughness == 2):</strong>
</p>

<p>
The mean convective heat transfer coefficient <strong>kc</strong> for rough straight pipes is calculated through its corresponding Nusselt number <strong>Nu</strong> according to <em>[Gnielinski in VDI 2002, p. Ga 5, eq. 26]</em>
</p>

<blockquote><pre>
Nu = (zeta/8)*Re*Pr/(1 + 12.7*(zeta/8)^0.5*(Pr^(2/3)-1))*(1+(d_hyd/L)^(2/3)),
</pre></blockquote>

<p>
where the influence of the pressure loss on the heat transfer calculation is considered through
</p>

<blockquote><pre>
zeta =  (1.8*log10(Re)-1.5)^-2.
</pre></blockquote>

<p>
The mean convective heat transfer coefficient <strong>kc</strong> in dependence of the chosen calculation (neglecting or considering of pressure loss influence) results into:
</p>

<blockquote><pre>
kc =  Nu * lambda / d_hyd
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> d_hyd                      </strong></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><strong> kc                         </strong></td><td> as mean convective heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><strong> lambda                     </strong></td><td> as heat conductivity of fluid [W/(mK)],</td></tr>
<tr><td><strong> L                          </strong></td><td> as length of straight pipe [m],</td></tr>
<tr><td><strong> Nu = kc*d_hyd/lambda       </strong></td><td> as mean Nusselt number [-], </td></tr>
<tr><td><strong> Pr = eta*cp/lambda         </strong></td><td> as Prandtl number [-],</td></tr>
<tr><td><strong> Re = rho*v*d_hyd/eta       </strong></td><td> as Reynolds number [-],</td></tr>
<tr><td><strong> v                          </strong></td><td> as mean velocity [m/s],</td></tr>
<tr><td><strong> zeta                       </strong></td><td> as pressure loss coefficient [-].</td></tr>
</table>

<p>
Note that there is no significant difference for the calculation of the mean Nusselt number <strong>Nu</strong> at a uniform wall temperature (UWT) or a uniform heat flux (UHF) as heat transfer boundary in the turbulent regime (Bejan 2003, p.303).
</p>

<h4>Verification</h4>
<p>
The mean Nusselt number <strong>Nu</strong> representing the mean convective heat transfer coefficient <strong>kc</strong> for Prandtl numbers of different fluids is shown in the figures below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/StraightPipe/kc_turbulent.png\" alt=\"kc_turbulent\"/>
</div>

<p>
Note that the higher the Prandtl number <strong>Pr</strong> there is a higher difference in Nusselt numbers <strong>Nu</strong> comparing the neglect and consideration of pressure loss.
</p>

<h4>References</h4>
<dl>
  <dt>Bejan,A.:</dt>
    <dd><strong>Heat transfer handbook</strong>.
    Wiley, 2003.</dd>
 <dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>"));
        end kc_turbulent;

        class kc_twoPhaseOverall
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html>
<p>
Calculation of local <strong>two phase</strong> heat transfer coefficient <strong>kc_2ph</strong> for (horizontal/vertical) <strong>boiling</strong> or (horizontal) <strong>condensation</strong> for an overall flow regime.
</p>

<h4>Restriction</h4>
<ul>
  <li>circular cross sectional area</li>
  <li>no subcooled boiling</li>
  <li>film condensation</li>
</ul>

<h4>Geometry </h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/straightPipe.png\" alt=\"straightPipe\"/>
</div>

<h4>Calculation</h4>
<p><strong>Boiling in a horizontal pipe (target = Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor):</strong></p>
<p>
The local two phase heat transfer coefficient <strong>kc_2ph</strong> during boiling in a <strong>horizontal</strong> straight pipe for an overall regime is calculated according to <em>[Gungor/Winterton 1986, p.354, eq. 2]</em> :
</p>

<blockquote><pre>
kc_2ph = E_fc*E_fc_hor*kc_fc+S_nb+S_nb_hor*kc_nb
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> Bo</strong>=qdot_A/(mdot_A*dh_lv)  </td><td> as boiling number [-],</td></tr>
<tr><td><strong> dh_lv                         </strong></td><td> as evaporation enthalpy [J/kg],</td></tr>
<tr><td><strong> E_fc</strong>=f(Bo,Fr_l,X_tt)      </td><td> as forced convection enhancement factor [-],</td></tr>
<tr><td><strong> E_fc_hor</strong> =f(Fr_l)         </td><td> as forced convection enhancement factor for horizontal straight pipes [-],</td></tr>
<tr><td><strong> Fr_l                          </strong></td><td> as Froude number assuming total mass flow rate flowing as liquid [-],</td></tr>
<tr><td><strong> kc_2ph                        </strong></td><td> as local two phase heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><strong> kc_fc                         </strong></td><td> as heat transfer coefficient considering forced convection [W/(m2K)],</td></tr>
<tr><td><strong> kc_nb                         </strong></td><td> as heat transfer coefficient considering nucleate boiling [W/(m2K)],</td></tr>
<tr><td><strong> mdot_A                        </strong></td><td> as total mass flow rate density [kg/(m2s)],</td></tr>
<tr><td><strong> qdot_A                        </strong></td><td> as heat flow rate density [W/m2],</td></tr>
<tr><td><strong> Re_l                          </strong></td><td> as Reynolds number assuming liquid mass flow rate flowing alone [-],</td></tr>
<tr><td><strong> S_nb</strong> =f(E_fc,Re_l)        </td><td> as suppression factor of nucleate boiling [-],</td></tr>
<tr><td><strong> S_nb_hor</strong> =f(Fr_l)         </td><td> as suppression factor of nucleate boiling for horizontal straight pipes [-],</td></tr>
<tr><td><strong> x_flow                        </strong></td><td> as mass flow rate quality [-],</td></tr>
<tr><td><strong> X_tt</strong> = f(x_flow)          </td><td> as Martinelli parameter [-].</td></tr>
</table>

<p><strong>Boiling in a vertical pipe (target = Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer):</strong></p>
<p>
The local two phase heat transfer coefficient <strong>kc_2ph</strong> during boiling in a <strong>vertical</strong> straight pipe for an overall regime is calculated out of the correlations for boiling in a horizontal straight pipe, where the horizontal correction factors <strong>E_fc_hor,S_nb_hor</strong> are unity.
</p>
<p>
Please note that the correlations named above are not valid for subcooled boiling due to a different driving temperature for nucleate boiling and forced convection. At subcooled boiling there is no enhancement factor (no vapour generation) but the suppression factor remains effective.
</p>

<p><strong>Condensation in a horizontal pipe (target = Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.CondHor):</strong></p>
<p>
The local two phase heat transfer coefficient <strong>kc_2ph</strong> during condensation in a <strong>horizontal</strong> straight pipe for an overall regime is calculated according to <em>[Shah 1979, p.548, eq. 8]</em> :
</p>

<blockquote><pre>
kc_2ph = kc_1ph*[(1 - x_flow)^0.8 + 3.8*x_flow^0.76*(1 - x_flow)^0.04/p_red^0.38]
</pre></blockquote>

<p>
where the convective heat transfer coefficient <strong>kc_1ph</strong> assuming the total mass flow rate is flowing as liquid according to <em>[Shah 1979, p.548, eq. 5]</em> :
</p>

<blockquote><pre>
kc_1ph = 0.023*Re_l^0.8*Pr_l^0.4*lambda_l/d_hyd
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> d_hyd                        </strong></td><td> as hydraulic diameter [m],</td></tr>
<tr><td><strong> kc_2ph                       </strong></td><td> as local two phase heat transfer coefficient [W/(m2K)],</td></tr>
<tr><td><strong> kc_1ph                       </strong></td><td> as convective heat transfer coefficient assuming total mass flow rate is flowing as liquid [W/(m2K)],</td></tr>
<tr><td><strong> lambda_l                     </strong></td><td> as thermal conductivity of fluid  [W/(mK)],</td></tr>
<tr><td><strong> pressure                     </strong></td><td> as thermodynamic pressure of fluid [Pa],</td></tr>
<tr><td><strong> p_crit                       </strong></td><td> as critical pressure of fluid [Pa],</td></tr>
<tr><td><strong> p_red</strong> = pressure/p_crit  </td><td> as reduced pressure [-],</td></tr>
<tr><td><strong> Pr_l                         </strong></td><td> as Prandtl number assuming [-],</td></tr>
<tr><td><strong> Re_l                         </strong></td><td> as Reynolds number assuming <strong>total</strong> mass flow rate is flowing as liquid [-],</td></tr>
<tr><td><strong> x_flow                       </strong></td><td> as mass flow rate quality [-],</td></tr>
</table>

<h4>Verification</h4>
<p>The local two phase heat transfer coefficient <strong>kc_2ph</strong> during for horizontal and vertical boiling as well as for horizontal condensation is shown for a straight pipe in the figures below.</p>

<p><strong>Boiling in a horizontal pipe (target = Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer):</strong></p>
<p>
Here the validation of the two phase heat transfer coefficient is shown for boiling in a horizontal straight pipe.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/StraightPipe/kc_twoPhaseOverall_KC_4.png\" alt=\"kc_twoPhaseOverall_KC_4\"/>
</div>

<p>The two phase heat transfer coefficient (<strong>kc_2ph</strong>) w.r.t. <em>Gungor/Winterton</em> is shown in dependence of the mass flow rate quality (<strong>x_flow</strong>) for different mass flow rate densities (<strong>mdot_A</strong>). The validation has been done with measurement results from <em>Kattan/Thome</em> for R134a as medium.</p>
<p>
The two phase heat transfer coefficient increases with increasing mass flow rate quality up to a maximum value. After that there is a rapid decrease of (<strong>kc_2ph</strong>) with increasing (<strong>x_flow</strong>). This can be explained with a partial dryout of the pipe wall for a high mass flow rate quality.
</p>

<p><strong>Condensation in a horizontal pipe (target = Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.CondHor):</strong></p>
<p>
Here the validation of the two phase heat transfer coefficient is shown for condensation in a horizontal straight pipe.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/StraightPipe/kc_twoPhaseOverall_KC_2.png\" alt=\"kc_twoPhaseOverall_KC_2\"/>
</div>

<p>The two phase heat transfer coefficient (<strong>kc_2ph</strong>) w.r.t. <em>Shah</em> is shown in dependence of the mass flow rate quality (<strong>x_flow</strong>) for different mass flow rate densities (<strong>mdot_A</strong>). The validation has been done with measurement results from <em>Dobson/Chato</em> for R134a as medium.</p>

<h4>References</h4>
<dl><dt>Bejan,A.: </dt>
<dd><strong>Heat transfer handbook</strong>. Wiley, 2003. </dd>
<dt>M.K. Dobson and J.C. Chato: </dt>
<dd><strong>Condensation in smooth horizontal tubes</strong>. Journal of HeatTransfer, Vol.120, p.193-213, 1998. </dd>
<dt>Gungor, K.E. and R.H.S. Winterton: </dt>
<dd><strong>A general correlation for flow boiling in tubes and annuli</strong>, Int.J. Heat Mass Transfer, Vol.29, p.351-358, 1986. </dd>
<dt>N. Kattan and J.R. Thome: </dt>
<dd><strong>Flow boiling in horizontal pipes: Part 2 - new heat transfer data for five refrigerants.</strong>. Journal of Heat Transfer, Vol.120. p.148-155, 1998. </dd>
<dt>Shah, M.M.: </dt>
<dd><strong>A general correlation for heat transfer during film condensation inside pipes</strong>. Int. J. Heat Mass Transfer, Vol.22, p.547-556, 1979.</dd>
</dl></html>"));
        end kc_twoPhaseOverall;

        end StraightPipe;

      end HeatTransfer;

    package PressureLoss
      extends Modelica.Icons.Information;

    package Bend
      extends Modelica.Icons.Information;

    class dp_curvedOverall
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
Calculation of pressure loss in curved bends at overall flow regime for incompressible and single-phase fluid flow through circular cross sectional area considering surface roughness.
</p>
<h4>Restriction</h4>
<p>
This function shall be used inside of the restricted limits according to the referenced literature.
</p>

<ul>
<li><strong>circular cross sectional area</strong></li>
<li><strong>0.5 &le; curvature radius / diameter &le; 3</strong> <em>[Idelchik 2006, p. 357, diag. 6-1]</em></li>
<li><strong>length of bend along curved axis / diameter &ge; 10</strong> <em>[Idelchik 2006, p. 357, diag. 6-1]</em></li>
<li><strong>angle of curvature smaller than 180&deg; (delta &le; 180)</strong> <em>[Idelchik 2006, p. 357, diag. 6-1]</em></li>
</ul>

<h4>Geometry</h4>
<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/circularBend.png\" alt=\"circularBend\"/>
</div>

<h4>Calculation</h4>
<p>
The pressure loss <strong>dp</strong> for curved bends is determined by:
</p>
<blockquote><pre>
dp = zeta_TOT * (rho/2) * velocity^2
</pre></blockquote>
<p>
with
</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p><strong>rho</strong></p></td>
<td><p>as density of fluid [kg/m3],</p></td>
</tr>
<tr>
<td><p><strong>velocity</strong></p></td>
<td><p>as mean velocity [m/s],</p></td>
</tr>
<tr>
<td><p><strong>zeta_TOT</strong></p></td>
<td><p>as pressure loss coefficient [-].</p></td>
</tr>
</table>
<p>
<strong>Curved bends with relative curvature radius R_0/d_hyd &le; 3</strong> according to <em>[Idelchik 2006, p. 357, diag. 6-1]</em>
</p>
<p>
The pressure loss of curved bends is similar to its calculation in straight pipes. There are three different flow regimes observed (laminar,transition,turbulent). The turbulent regime is further separated into sections with a dependence or independence of the local resistance coefficient (<strong>zeta_LOC</strong>) on Reynolds number. The local resistance coefficient (<strong>zeta_LOC</strong>) of a curved bend is calculated in dependence of the flow regime as follows:
</p>
<ul>
<li><p><strong>Laminar regime (Re &le; Re_lam_leave)</strong>:</p>
<blockquote><pre>
zeta_LOC = A2/Re + A1*B1*C1
</pre></blockquote>
</li>
<li><p><strong>Transition regime (Re_lam_leave &le; 4e4)</strong></p>
<p> This calculation is done using a smoothing function interpolating between the laminar and the first turbulent flow regime.</p></li>
<li><p><strong>Turbulent regime (4e4 &le; 3e5) with dependence</strong> of local resistance coefficient on Reynolds number:</p>
<blockquote><pre>
zeta_LOC = k_Re * (A1*B1*C1)
</pre></blockquote>
<p>where <strong>k_Re</strong> depends on the relative curvature radius <strong>R_0/d_hyd</strong></p>
<blockquote><pre>
k_Re = 1 + 4400/Re              for 0.50 &lt; r/d_hyd &lt; 0.55
k_Re = 5.45/Re^(0.118)          for 0.55 &le; r/d_hyd &lt; 0.70
k_Re = 11.5/Re^(0.19)           for 0.70 &le; r/d_hyd &lt; 3.00</pre></blockquote></li>
<li><p><strong>Turbulent regime (Re &ge; 3e5) with independence</strong> of local resistance coefficient on Reynolds number</p>
<blockquote><pre>
zeta_LOC = A1*B1*C1
</pre></blockquote>
</li>
</ul>

<p>with</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p><strong>A1</strong></p></td>
<td><p>as coefficient considering effect of angle of turning (delta) [-],</p></td>
</tr>
<tr>
<td><p><strong>A2</strong></p></td>
<td><p>as coefficient considering effect for laminar regime [-],</p></td>
</tr>
<tr>
<td><p><strong>B1</strong></p></td>
<td><p>as coefficient considering effect of relative curvature radius (R_0/d_hyd) [-],</p></td>
</tr>
<tr>
<td><p><strong>C1=1</strong></p></td>
<td><p>as coefficient considering relative elongation of cross sectional area (here: circular cross sectional area) [-],</p></td>
</tr>
<tr>
<td><p><strong>k_Re</strong></p></td>
<td><p>as coefficient considering influence of laminar regime in transition regime [-],</p></td>
</tr>
<tr>
<td><p><strong>Re</strong></p></td>
<td><p>as Reynolds number [-].</p></td>
</tr>
</table>
<p><br><br>The pressure loss coefficient <strong>zeta_TOT</strong> of a curved bend including pressure loss due to friction is determined by its local resistance coefficient <strong>zeta_LOC</strong> multiplied with a correction factor <strong>CF</strong> for surface roughness according to <em>[Miller, p. 209, eq. 9.4]:</em></p>
<blockquote><pre>
zeta_TOT = CF*zeta_LOC
</pre></blockquote>
<p>where the correction factor <strong>CF</strong> is determined from the Darcy friction factor of a straight pipe having the bend flow path length</p>
<blockquote><pre>
CF = 1 + (lambda_FRI_rough * pi * delta/d_hyd) / zeta_LOC
</pre></blockquote>
<p>and the Darcy friction factors <strong>lambda_FRI_rough</strong> is calculated with an approximated Colebrook-White law according to <em>[Miller, p. 191, eq. 8.4]:</em></p>
<blockquote><pre>
lambda_FRI_rough = 0.25*(lg(K/(3.7*d_hyd) + 5.74/Re^0.9))^-2
</pre></blockquote>
<p>with</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p><strong>delta</strong></p></td>
<td><p>as curvature radiant [rad],</p></td>
</tr>
<tr>
<td><p><strong>d_hyd</strong></p></td>
<td><p>as hydraulic diameter [m],</p></td>
</tr>
<tr>
<td><p><strong>K</strong></p></td>
<td><p>as absolute roughness (average height of surface asperities) [m],</p></td>
</tr>
<tr>
<td><p><strong>lambda_FRI_rough</strong></p></td>
<td><p>as Darcy friction factor[-],</p></td>
</tr>
<tr>
<td><p><strong>Re</strong></p></td>
<td><p>as Reynolds number [m],</p></td>
</tr>
<tr>
<td><p><strong>zeta_LOC</strong></p></td>
<td><p>as local resistance coefficient [-],</p></td>
</tr>
<tr>
<td><p><strong>zeta_TOT</strong></p></td>
<td><p>as pressure loss coefficient [-].</p></td>
</tr>
</table>
<p><br>The correction for surface roughness through <strong>CF</strong> is used only in the turbulent regime, where the fluid flow is influenced by surface asperities not covered by a laminar boundary layer. The turbulent regime starts at <strong>Re &ge; 4e4</strong> according to <em>[Idelchik 2006, p. 336, sec. 15]</em>. There is no correction due to roughness in the laminar regime up to <strong>Re &le; 6.5e3</strong> according to <em>[Idelchik 2006, p. 336, sec. 15]</em>.</p>
<p>Nevertheless the transition point from the laminar to the transition regime is shifted to smaller Reynolds numbers for an increasing absolute roughness. This effect is considered according to <em>[Samoilenko in Idelchik 2006, p. 81, sec. 2-1-21]</em> as:</p>
<blockquote><pre>
Re_lam_leave = 754*exp(if k &le; 0.007 then 0.0065/0.007 else 0.0065/k)
</pre></blockquote>
<p>with</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p><strong>k = K /d_hyd</strong></p></td>
<td><p>as relative roughness [-],</p></td>
</tr>
<tr>
<td><p><strong>Re_lam_leave</strong></p></td>
<td><p>as Reynolds number for leaving laminar regime [-].</p></td>
</tr>
</table>
<p>Note that the beginning of the laminar regime cannot be beneath <strong>Re &le; 1e2</strong>.</p>
<h4>Verification</h4>
<p>The pressure loss coefficient <strong>zeta_TOT</strong> of a curved bend in dependence of the Reynolds number <strong>Re</strong> for different relative curvature radii <strong>R_0/d_hyd</strong> and different angles of turning <strong>delta</strong> is shown in the figures below.</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/dp_curvedOverall_1.png\" alt=\"dp_curvedOverall_1\"/>
</div>

<p>There are deviations of the pressure loss coefficient <strong>zeta_TOT</strong> comparing different references. Usually these deviations in the transition regime have to be accepted due to an uncertainty for the determination of comparable boundary conditions in the different references. Nevertheless these calculations cover the usual range of pressure loss coefficients for a curved bend. The pressure loss coefficient <strong>zeta_TOT</strong> for the same geometry can be adjusted via varying the average height of surface asperities <strong>K</strong> for calibration.</p>
<p>The pressure loss in dependence of the mass flow rate of water is shown for different relative curvature radii:</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/dp_curvedOverall_2.png\" alt=\"dp_curvedOverall_2\"/>
</div>

<p>The pressure loss in dependence of the mass flow rate of water is shown for different angles of turning:</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/dp_curvedOverall_3.png\" alt=\"dp_curvedOverall_3\"/>
</div>

<p>Note that there is a small deviation between the compressible and incompressible calculation due to the lack of a direct analytical invertibility.</p>

<h4>References</h4>
<dl><dt>Elmqvist,H., M.Otter and S.E. Cellier: </dt>
<dd><strong>Inline integration: A new mixed symbolic / numeric approach for solving differential-algebraic equation systems.</strong>. In Proceedings of European Simulation MultiConference, Prague, 1995.</dd>
<dt>Idelchik,I.E.: </dt>
<dd><strong>Handbook of hydraulic resistance</strong>. Jaico Publishing House, Mumbai, 3rd edition, 2006.</dd>
<dt>Miller,D.S.: </dt>
<dd><strong>Internal flow systems</strong>. volume 5th of BHRA Fluid Engineering Series.BHRA Fluid Engineering, 1984. </dd>
<dt>Samoilenko,L.A.: </dt>
<dd><strong>Investigation of the hydraulic resistance of pipelines in the zone of transition from laminar into turbulent motion</strong>. PhD thesis, Leningrad State University, 1968.</dd>
<dt>VDI: </dt>
<dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>. Springer Verlag, 9th edition, 2002. </dd>
</dl></html>"));
    end dp_curvedOverall;

    class dp_edgedOverall
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
Calculation of pressure loss in edged bends with sharp corners at overall flow regime for incompressible and single-phase fluid flow through circular cross sectional area considering surface roughness.
</p>
<h4>Restriction</h4>
<p>
This function shall be used inside of the restricted limits according to the referenced literature.
</p>
<ul>
 <li>
      <strong>circular cross sectional area</strong> <em>[Idelchik 2006, p. 366, diag. 6-7]</em>
 </li>
 <li>
      <strong>edged bend with sharp corners at turning</strong> <em>[Idelchik 2006, p. 366, diag. 6-7]</em>
 </li>
 <li>
      <strong>0&deg; &le; angle of turning &le; 180&deg;</strong> <em>[Idelchik 2006, p. 338, sec. 19]</em>
 </li>
 <li>
      <strong>length of edged bend along edged axis / diameter &ge; 10</strong> <em>[Idelchik 2006, p. 366, diag. 6-7]</em>
 </li>
</ul>

<h4>Geometry</h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/edgedBend.png\" alt=\"edgedBend\"/>
</div>

<h4>Calculation</h4>
<p>The pressure loss <strong>dp</strong> for edged bends is determined by:
</p>

<blockquote><pre>
dp = zeta_TOT * (rho/2) * velocity^2
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> rho            </strong></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><strong> velocity       </strong></td><td> as mean velocity [m/s],</td></tr>
<tr><td><strong> zeta_TOT       </strong></td><td> as pressure loss coefficient [-].</td></tr>
</table>

<p>
The pressure loss coefficient <strong>zeta_TOT</strong> of an edged bend can be calculated for different angles of turning <strong>delta</strong> by:
</p>

<blockquote><pre>
zeta_TOT = A * C1 * zeta_LOC * CF_Fri* CF_Re <em>[Idelchik 2006, p. 366, diag. 6-7]</em> and <em>[Miller 1984, p. 149, sec. 9.4]</em>
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> A              </strong></td><td> as coefficient considering effect for angle of turning [-],</td></tr>
<tr><td><strong> C1             </strong></td><td> as coefficient considering relative elongation of cross sectional area (here: circular cross sectional area) [-],</td></tr>
<tr><td><strong> CF_Fri         </strong></td><td> as correction factor considering surface roughness [-],</td></tr>
<tr><td><strong> CF_Re          </strong></td><td> as correction factor considering Reynolds number [-],</td></tr>
<tr><td><strong> delta          </strong></td><td> as angle of turning [deg].</td></tr>
</table>

<p>
The correction factor <strong>CF_Fri</strong> regarding the influence of surface roughness is determined as ratio of the Darcy friction factor for rough surfaces to smooth surfaces according to <em>[Miller, p. 207, eq. 9.3]:</em>
</p>
<blockquote><pre>
CF_Fri = lambda_FRI_rough / lambda_FRI_smooth
</pre></blockquote>

<p>
and the Darcy friction factors <strong>lambda_FRI</strong> are calculated with an approximated Colebrook-White law according to <em>[Miller, p. 191, eq. 8.4]:</em>
</p>
<blockquote><pre>
lambda_FRI = 0.25*(lg(K/(3.7*d_hyd) + 5.74/Re^0.9))^-2
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> d_hyd              </strong></td><td> as hydraulic diameter [m],</td></tr>
<tr><td><strong> K                  </strong></td><td> as absolute roughness (average height of surface asperities) [m],</td></tr>
<tr><td><strong> lambda_FRI         </strong></td><td> as Darcy friction factor[-],</td></tr>
<tr><td><strong> Re                 </strong></td><td> as Reynolds number [m],</td></tr>
<tr><td><strong> zeta_TOT           </strong></td><td> as pressure loss coefficient [-].</td></tr>
</table>

<p>
Note that the Darcy friction factor for a smooth surface <strong>lambda_FRI_smooth</strong> is calculated with the previous equation and an absolute roughness of <strong>K = 0</strong>.
</p>

<p>
The correction for surface roughness through <strong>CF_Fri</strong> is used only in the turbulent regime, where the fluid flow is influenced by surface asperities not covered by a laminar boundary layer. Here the correction according to friction starts at <strong>Re &ge; Re_lam_leave</strong> according to <em>[Idelchik 2006, p. 336, sec. 15]</em>. Here the end of the laminar regime is restricted to a Reynolds number smaller than 2e3 w.r.t. <em>[VDI, p. Lac 6, fig. 16]</em>.
</p>

<p>
Nevertheless the transition point from the laminar to the transition regime is shifted to smaller Reynolds numbers for an increasing absolute roughness. This effect is considered according to <em>[Samoilenko in Idelchik 2006, p. 81, sec. 2-1-21]</em> as:
</p>

<blockquote><pre>
Re_lam_leave = 754*exp(if k &le; 0.007 then 0.0065/0.007 else 0.0065/k)
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> k = K /d_hyd       </strong></td><td> as relative roughness [-],</td></tr>
<tr><td><strong> Re_lam_leave       </strong></td><td> as Reynolds number for leaving laminar regime [-].</td></tr>
</table>

<p>
Note that the beginning of the laminar regime cannot be beneath <strong>Re &le; 5e2</strong>.
</p>

<p>
In addition the influence or decreasing Reynolds numbers <strong>Re</strong> on the pressure loss coefficient <strong>zeta_TOT</strong> in the laminar and turbulent regime is considered through a second correction factor <strong>CF_Re</strong> according to <em>[Miller 1984, p. 149, sec. 9.4]</em> by:
</p>

<blockquote><pre>
CF_Re = B/Re^exp for Re &le; 2e5
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> B = f(Geometry)  </strong></td><td> as coefficient considering effect of Reynolds number in laminar regime [-],</td></tr>
<tr><td><strong> exp              </strong></td><td> as exponent for Reynolds number in laminar regime [-],</td></tr>
<tr><td><strong> Re               </strong></td><td> as Reynolds number [-], </td></tr>
</table>

<p>
Note that the coefficient <strong>B</strong> considers the influence of the angle of turning <strong>delta</strong> on the pressure loss coefficient <strong>zeta_TOT</strong> in the laminar regime according to <em>[Idelchik 2006, p. 340, sec. 28]</em>.
</p>

<p>
Note that the correction of the pressure loss coefficient <strong>zeta_TOT</strong> is influenced by the correction factor <strong>CF_Re</strong> only for decreasing Reynolds numbers <strong>Re</strong> out of the turbulent fluid flow regime at <strong>Re &le; 2e5</strong> into transition and laminar fluid flow regime.
</p>

<h4>Verification</h4>
<p>
The pressure loss coefficient <strong>zeta_TOT</strong> of a edged bend in dependence of the Reynolds number <strong>Re</strong> for different angles of turning <strong>delta</strong> is shown in the figures below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/dp_edgedOverall_1.png\" alt=\"dp_edgedOverall_1\"/>
</div>

<p>
Pressure loss calculation of edged bends is complex and there are large differences in literature data. Nevertheless these calculations cover the usual range of pressure loss coefficients for an edged bend.
</p>

<p>
The validation of the pressure loss coefficient for an edged bends shows four possible flow regimes:
</p>
<ul>
 <li>
      <strong>laminar regime</strong> for Re &le; 5e2</li>
 <li>
      <strong>transition regime</strong> for 5e2 &le; Re &le; 1e3 ... 1e4</li>
 <li>
      <strong>turbulent regime dependent on Reynolds number</strong> for 2e3 ... 1e4 &le; Re &le; 1e5</li>
 <li>
      <strong>turbulent regime independent of Reynolds number</strong> for Re &ge; 2e5</li>
</ul>

<p>
<strong>Incompressible case</strong> [Pressure loss = f(m_flow)]:
</p>
<p>
The pressure loss in dependence of the mass flow rate of water is shown for different angles of turning:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/dp_edgedOverall_2.png\" alt=\"dp_edgedOverall_2\"/>
</div>

<p>
<strong>Compressible case</strong> [Mass flow rate = f(dp)]:
</p>
<p>
The mass flow rate in dependence of the pressure loss of water is shown for different angles of turning:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/dp_edgedOverall_3.png\" alt=\"dp_edgedOverall_3\"/>
</div>

<h4>References</h4>
<dl>
<dt>Idelchik,I.E.:</dt>
    <dd><strong>Handbook of hydraulic resistance</strong>.
    Jaico Publishing House,Mumbai,3rd edition, 2006.</dd>
<dt>Miller,D.S.:</dt>
    <dd><strong>Internal flow systems</strong>.
    volume 5th of BHRA Fluid Engineering Series.BHRA Fluid Engineering, 1984.</dd>
 <dt>Samoilenko,L.A.:</dt>
    <dd><strong>Investigation of the hydraulic resistance of pipelines in the
        zone of transition from laminar into turbulent motion</strong>.
        PhD thesis, Leningrad State University, 1968.</dd>
<dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>
</html>"));
    end dp_edgedOverall;

      annotation (DocumentationClass=true);
    end Bend;

    package Channel
      extends Modelica.Icons.Information;

    class dp_internalFlowOverall
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
Calculation of pressure loss for an internal flow through different geometries at overall flow regime for single-phase fluid flow considering surface roughness.
</p>
<h4>Restriction</h4>
<p>
This function shall be used inside of the restricted limits according to the referenced literature.
</p>
<ul>
 <li>
      <strong>developed fluid flow</strong>
 </li>
</ul>

<h4>Geometry</h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Channel/pLchannel.png\" alt=\"pLchannel\"/>
</div>

<h4>Calculation</h4>
<p>
The pressure loss <strong>dp</strong> for channels is determined by:
</p>

<blockquote><pre>
dp = zeta_TOT * (rho/2) * velocity^2
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> rho            </strong></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><strong> velocity       </strong></td><td> as mean velocity [m/s],</td></tr>
<tr><td><strong> zeta_TOT       </strong></td><td> as pressure loss coefficient [-].</td></tr>
</table>

<p>
<strong>Channels with different shape of its cross sectional area are calculated</strong> according to <em>[Miller 1978, p. 138, fig. 8.5-8-6]</em>
</p>
<p>
The pressure loss of these channels is similar to its calculation in straight pipes. There are three different flow regimes observed (laminar,transition,turbulent). The pressure loss coefficient (<strong>zeta_TOT</strong>) of a channel is calculated in dependence of the flow regime as follows:
</p>

<ul>
  <li><strong>Laminar regime (Re &le; Re_lam_leave)</strong>:
     <blockquote><pre>
zeta_TOT = CF_lam/Re * (L/d_hyd)
     </pre></blockquote></li>
  <li><p><strong>Transition regime (Re_lam_leave &le; 4e4)</strong></p>
        <p>This calculation is done using a smoothing function interpolating between the laminar and the turbulent flow regime.</p></li>
  <li><p><strong>Turbulent regime (Re &ge; 4e3)</strong>:</p>
        <p>The turbulent regime can be calculated with the pressure loss correlations for a straight pipe with the hydraulic diameter of
           the chosen geometry instead of the internal diameter of a straight pipe according to <em>[VDI 2002, p. Lab 4, sec. 2.1]</em> .
           The documentation of turbulent fluid flow for a straight pipe is shown in
           <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_turbulent\">dp_turbulent</a>.</p></li>
</ul>

<p>
with
</p>

<table>
<tr><td><strong> CF_lam        </strong></td><td> as correction factor considering the geometry for laminar regime [-],</td></tr>
<tr><td><strong> L             </strong></td><td> as length of geometry perpendicular to cross sectional area [m],</td></tr>
<tr><td><strong> d_hyd         </strong></td><td> as hydraulic diameter of geometry [m],</td></tr>
<tr><td><strong> Re            </strong></td><td> as Reynolds number [-],</td></tr>
<tr><td><strong> zeta_TOT      </strong></td><td> as pressure loss coefficient [-].</td></tr>
</table>

<p>
Note that the beginning of the laminar regime depends on the chosen surface roughness of the channel and cannot be beneath <strong>Re &le; 1e3</strong>.
</p>
<h4>Verification</h4>
<p>
The Darcy friction factor (<strong>lambda_FRI</strong>) of a channel with different shapes of its cross sectional area are shown in dependence of the Reynolds number (<strong>Re</strong>) in the figures below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Channel/dp_internalFlowOverall.png\" alt=\"dp_internalFlowOverall\"/>
</div>

<p>
The Darcy friction factor (<strong>lambda_FRI</strong>) for different geometries has been obtained at the same hydraulic diameter and the same mean velocity of the internal flow. Note that there is no difference of the Darcy friction factor in the turbulent regime if using the same hydraulic diameter for all geometries. Roughness can be considered but it is not used for this validation.
</p>
<h4>References</h4>
<dl>
<dt>Miller,D.S.:</dt>
    <dd><strong>Internal flow systems</strong>.
    Volume 5th of BHRA Fluid Engineering Series.BHRA Fluid Engineering, 1978.</dd>
<dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>
</html>"));
    end dp_internalFlowOverall;

      annotation (DocumentationClass=true);
    end Channel;

    package General
      extends Modelica.Icons.Information;

    class dp_idealGas
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
Calculation of a generic pressure loss for an <strong>ideal gas</strong> using mean density.
</p>
<h4>Restriction</h4>
<p>
This function shall be used inside of the restricted limits according to the referenced literature.
</p>
<ul>
 <li>
    <strong>ideal gas</strong>
 </li>
 <li>
    mean density of ideal gas
 </li>
</ul>

<h4>Calculation</h4>
<p>
The geometry parameters of energy devices necessary for the pressure loss calculations are often not exactly known.
Therefore the modelling of the detailed pressure loss calculation has to be simplified.
</p>
<p>
The pressure loss <strong>dp</strong> for the compressible case [Mass flow rate = f(dp)] is determined by (Eq.1):
</p>

<blockquote><pre>
m_flow = (R_s/Km)^(1/exp)*(rho_m)^(1/exp)*dp^(1/exp)
</pre></blockquote>

<p>
for the underlying base equation using ideal gas law as follows:
</p>

<blockquote><pre>
dp^2 = p_2^2 - p_1^2 = Km*m_flow^exp*(T_2 + T_1)
dp   = p_2 - p_1     = Km*m_flow^exp*T_m/p_m, Eq.2 with [dp] = Pa, [m_flow] = kg/s
</pre></blockquote>

<p>
so that the coefficient <strong>Km</strong> is calculated out of Eq.2:
</p>

<blockquote><pre>
Km = dp*R_s*rho_m / m_flow^exp , [Km] = [Pa^2/{(kg/s)^exp*K}]
</pre></blockquote>

<p>
where the mean density <strong>rho_m</strong> is calculated according to the ideal gas law out of an arithmetic mean pressure and temperature:
</p>

<blockquote><pre>
rho_m = p_m / (R_s*T_m) , p_m = (p_1 + p_2)/2 and T_m = (T_1 + T_2)/2.
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> exp                    </strong></td><td> as exponent of pressure loss law [-],</td></tr>
<tr><td><strong> dp                     </strong></td><td> as pressure loss [Pa],</td></tr>
<tr><td><strong> Km                     </strong></td><td> as coefficient w.r.t. mass flow rate! [Km] = [Pa^2/{(kg/s)^exp*K}],</td></tr>
<tr><td><strong> m_flow                 </strong></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><strong> p_m = (p_2 + p_1)/2    </strong></td><td> as mean pressure of ideal gas [Pa],</td></tr>
<tr><td><strong> T_m = (T_2 + T_1)/2    </strong></td><td> as mean temperature of ideal gas [K],</td></tr>
<tr><td><strong> rho_m = p_m/(R_s*T_m)  </strong></td><td> as mean density of ideal gas [kg/m3],</td></tr>
<tr><td><strong> R_s                    </strong></td><td> as specific gas constant of ideal gas [J/(kgK)],</td></tr>
<tr><td><strong> V_flow                 </strong></td><td> as volume flow rate of ideal gas [m^3/s].</td></tr>
</table>

<p>
Furthermore the coefficient <strong>Km</strong> can be defined more detailed w.r.t. the definition of pressure loss if <strong>Km</strong> is not given as (e.g., measured) value. Generally pressure loss can be calculated due to local losses <strong>Km,LOC</strong> or frictional losses <strong>Km,FRI</strong>.
</p>
<p>
Pressure loss due to local losses gives the following definition of <strong>Km</strong>:
</p>

<blockquote><pre>
dp        = zeta_LOC * (rho_m/2)*velocity^2 is leading to
  Km,LOC  = (8/&pi;^2)*R_s*zeta_LOC/(d_hyd)^4, considering the cross sectional area of pipes.
</pre></blockquote>

<p>
and pressure loss due to friction is leading to
</p>

<blockquote><pre>
dp        = lambda_FRI*L/d_hyd * (rho_m/2)*velocity^2
  Km,FRI  = (8/&pi;^2)*R_s*lambda_FRI*L/(d_hyd)^5, considering the cross sectional area of pipes.
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> dp                    </strong></td><td> as pressure loss [Pa],</td></tr>
<tr><td><strong> d_hyd                 </strong></td><td> as hydraulic diameter of pipe [m],</td></tr>
<tr><td><strong> Km,i                  </strong></td><td> as coefficients w.r.t. mass flow rate! [Km] = [Pa^2/{(kg/s)^exp*K}],</td></tr>
<tr><td><strong> lambda_FRI            </strong></td><td> as Darcy friction factor [-],</td></tr>
<tr><td><strong> L                     </strong></td><td> as length of pipe [m],</td></tr>
<tr><td><strong> rho_m = p_m/(R_s*T_m) </strong></td><td> as mean density of ideal gas [kg/m3],</td></tr>
<tr><td><strong> velocity              </strong></td><td> as mean velocity [m/s],</td></tr>
<tr><td><strong> zeta_LOC              </strong></td><td> as local resistance coefficient [-].</td></tr>
</table>

<p>
Note that the variables of this function are delivered in SI units so that the coefficient Km shall be given in SI units too.
</p>
<h4>Verification</h4>
<p>
<strong>Compressible case</strong> [Mass flow rate = f(dp)]:
</p>
<p>
The mass flow rate <strong>m_flow</strong> for different coefficients <strong>Km</strong> as parameter is shown in dependence of its pressure loss <strong>dp</strong> in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/General/dp_idealGas.png\" alt=\"dp_idealGas\"/>
</div>

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_idealGas\">dp_idealGas</a> is also valid for this inverse calculation due to using the same functions.
</p>
<h4>References</h4>
<dl>
<dt>Elmqvist, H., M.Otter and S.E. Cellier:</dt>
    <dd><strong>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.
    In Proceedings of European Simulation MultiConference, Prague, 1995.</dd>
</dl>
</html>"));
    end dp_idealGas;

    class dp_nominalDensityViscosity
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of nominal fluid variables (e.g., nominal density, nominal dynamic viscosity) at an operation point via interpolation.
This generic function considers the pressure loss law via a pressure loss exponent and the influence of density and dynamic viscosity on pressure loss.
</p>
<h4>Calculation</h4>
<p>
The geometry parameters of energy devices necessary for the pressure loss calculations are often not exactly known.
Therefore the modelling of the detailed pressure loss calculation has to be simplified.
This function uses nominal variables (e.g., nominal pressure loss) at a known operation point of the energy device to interpolate the actual pressure loss according to a pressure loss law (exponent).
</p>
<p>
The generic pressure loss <strong>dp</strong> is determined for:
</p>
<ul>
 <li>
 compressible case [Mass flow rate = f(dp)]:
  <blockquote><pre>
m_flow = m_flow_nom*[(dp/dp_nom)*(rho/rho_nom)]^(1/exp)*(eta_nom/eta)^(exp_eta/exp)
  </pre></blockquote>
 </li>
 <li>
 incompressible case [Pressure loss = f(m_flow)]:
  <blockquote><pre>
dp = dp_nom*(m_flow/m_flow_nom)^exp*(rho_nom/rho)*(eta/eta_nom)^exp_eta
  </pre></blockquote>
  </li>
</ul>

<p>
with
</p>

<table>
<tr><td><strong> dp             </strong></td><td> as pressure loss [Pa],</td></tr>
<tr><td><strong> dp_nom         </strong></td><td> as nominal pressure loss [Pa],</td></tr>
<tr><td><strong> eta            </strong></td><td> as dynamic viscosity of fluid [kg/(ms)].</td></tr>
<tr><td><strong> eta_nom        </strong></td><td> as nominal dynamic viscosity of fluid [kg/(ms)].</td></tr>
<tr><td><strong> m_flow         </strong></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><strong> m_flow_nom     </strong></td><td> as nominal mass flow rate [kg/s],</td></tr>
<tr><td><strong> exp            </strong></td><td> as exponent of pressure loss calculation [-],</td></tr>
<tr><td><strong> exp_eta        </strong></td><td> as exponent of dynamic viscosity dependence [-],</td></tr>
<tr><td><strong> rho            </strong></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><strong> rho_nom        </strong></td><td> as nominal fluid density [kg/m3].</td></tr>
</table>

<p>
To avoid numerical difficulties this pressure loss function is linear smoothed for
</p>
<ul>
 <li>
 small mass flow rates, where
 <blockquote><pre>
m_flow &le; (0.01*rho/rho_nom*(1/eta*eta_nom)^(exp_eta))^(1/exp) and
  </pre></blockquote>
 </li>
 <li>small pressure losses, where
 <blockquote><pre>
dp &le; 0.01*dp_nom)
 </pre></blockquote>
 </li>
</ul>
<p>
Note that the density (rho) and dynamic viscosity (eta) of the fluid are defined through the definition of the kinematic viscosity (nue).
</p>

<blockquote><pre>
nue = eta / rho
</pre></blockquote>

<p>
Therefore if you set both the exponent of dynamic viscosity (exp_eta == 1) and additionally a relation of density and dynamic viscosity there will be no difference for varying densities because the dynamic viscosities will vary in the same manner.
</p>
<h4>Verification</h4>
<p>
<strong>Incompressible case</strong> [Pressure loss = f(m_flow)]:
</p>
<p>
The generic pressure loss <strong>DP</strong> in dependence of the mass flow rate <strong>m_flow</strong> with different fluid densities and dynamic viscosity dependence as parameters is shown for a turbulent pressure loss regime (exp == 2) in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/General/dp_nominalDensityViscosity_i.png\" alt=\"dp_nominalDensityViscosity_i\"/>
</div>

<p>
<strong>Compressible case</strong> [Mass flow rate = f(dp)]:
</p>
<p>
The generic mass flow rate <strong>M_FLOW</strong> in dependence of the pressure loss <strong>dp</strong> at different fluid densities and dynamic viscosity as parameters is shown for a turbulent pressure loss regime (exp == 2) in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/General/dp_nominalDensityViscosity_c.png\" alt=\"dp_nominalDensityViscosity_c\"/>
</div>

<h4>References</h4>
<dl>
<dt>Elmqvist, H., M.Otter and S.E. Cellier:</dt>
    <dd><strong>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.
    In Proceedings of European Simulation MultiConference, Prague, 1995.</dd>
<dt>Wischhusen, S.:</dt>
    <dd><strong>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</strong>.
    PhD thesis, Technische Universit&auml;t Hamburg-Harburg, 2005.</dd>
</dl>

</html>"));
    end dp_nominalDensityViscosity;

    class dp_nominalPressureLossLawDensity
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of nominal fluid variables (e.g., nominal density) via interpolation from an operation point.
This generic function considers the pressure loss law via a nominal pressure loss (dp_nom), a pressure loss coefficient (zeta_TOT) and a pressure loss law exponent (exp) as well as the influence of density on pressure loss.
</p>
<h4>Calculation</h4>
<p>
The geometry parameters of energy devices necessary for the pressure loss calculations are often not exactly known.
Therefore the modelling of the detailed pressure loss calculation have to be simplified.
This function uses nominal variables (e.g., nominal pressure loss) at a known operation point of the energy device to interpolate the actual pressure loss according to a pressure loss law (exponent).
</p>
<p>
In the following the pressure loss <strong>dp</strong> is generally determined from a known operation point via a law of similarity:
</p>

<blockquote><pre>
dp/dp_nom = (zeta_TOT/zeta_TOT_nom)*(rho/rho_nom)*(v/v_nom)^exp
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> dp             </strong></td><td> as pressure loss [Pa],</td></tr>
<tr><td><strong> dp_nom         </strong></td><td> as nominal pressure loss [Pa],</td></tr>
<tr><td><strong> m_flow         </strong></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><strong> m_flow_nom     </strong></td><td> as nominal mass flow rate [kg/s],</td></tr>
<tr><td><strong> exp            </strong></td><td> as exponent of pressure loss calculation [-],</td></tr>
<tr><td><strong> rho            </strong></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><strong> rho_nom        </strong></td><td> as nominal fluid density [kg/m3],</td></tr>
<tr><td><strong> v              </strong></td><td> as mean flow velocity [m/s],</td></tr>
<tr><td><strong> v_nom          </strong></td><td> as nominal mean flow velocity [m/s],</td></tr>
<tr><td><strong> zeta_TOT       </strong></td><td> as pressure loss coefficient [-],</td></tr>
<tr><td><strong> zeta_TOT_nom   </strong></td><td> as nominal pressure loss coefficient [-].</td></tr>
</table>

<p>
The fraction of mean flow velocities (v/v_nom) can be calculated through its corresponding <strong>mass flow rates</strong>, densities and cross sectional areas:
</p>

<blockquote><pre>
v/v_nom = (m_flow/m_flow_nom)*(A_cross_nom/A_cross)*(rho_nom/rho)
</pre></blockquote>

<p>
<strong>or</strong> through its corresponding <strong>volume flow rates</strong>, densities and cross sectional areas:
</p>

<blockquote><pre>
v/v_nom = (V_flow/V_flow_nom)*(A_cross_nom/A_cross).
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> A_cross        </strong></td><td> as cross sectional area [m2],</td></tr>
<tr><td><strong> A_cross_nom    </strong></td><td> as nominal cross sectional area [m2],</td></tr>
<tr><td><strong> rho            </strong></td><td> as fluid density [kg/m3],</td></tr>
<tr><td><strong> rho_nom        </strong></td><td> as nominal fluid density [kg/m3],</td></tr>
<tr><td><strong> v              </strong></td><td> as mean flow velocity [m/s],</td></tr>
<tr><td><strong> v_nom          </strong></td><td> as nominal mean flow velocity [m/s],</td></tr>
<tr><td><strong> V_flow         </strong></td><td> as volume flow rate [m3/s],</td></tr>
<tr><td><strong> V_flow_nom     </strong></td><td> as nominal volume flow rate [m3/s].</td></tr>
</table>

<p>
Here the <strong>compressible case</strong> [Mass flow rate = f(dp)] determines the unknown mass flow rate out of a given pressure loss:
</p>

<blockquote><pre>
m_flow = m_flow_nom*(A_cross/A_cross_nom)*(rho_nom/rho)^(exp_density/exp)*[(dp/dp_nom)*(zeta_TOT_nom/zeta_TOT)]^(1/exp);
</pre></blockquote>

<p>
where the exponent for the fraction of densities is determined w.r.t. the chosen nominal mass flow rate or nominal volume flow rate to:
</p>

<blockquote><pre>
exp_density = if NominalMassFlowRate == Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate then 1-exp else 1
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> NominalMassFlowRate    </strong></td><td> as reference for pressure loss law (mass flow rate of volume flow rate),</td></tr>
<tr><td><strong> exp                    </strong></td><td> as exponent of pressure loss calculation [-],</td></tr>
<tr><td><strong> exp_density            </strong></td><td> as exponent for density [-].</td></tr>
</table>

<p>
To avoid numerical difficulties this pressure loss function is linear smoothed for small pressure losses, with
</p>

<blockquote><pre>
dp &le; 0.01*dp_nom
</pre></blockquote>

<p>
Note that the input and output arguments for functions throughout this library always use mass flow rates. Here you can choose <strong>NominalMassFlowRate == Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate</strong> for using a nominal mass flow rate or <strong>NominalMassFlowRate == Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate.VolumeFlowRate</strong> for using a nominal volume flow rate. The output argument will always be a mass flow rate for further use as flow model in a thermo-hydraulic framework.
</p>

<p>
Note that the pressure loss coefficients (zeta_TOT,zeta_TOT_nom) refer to its mean flow velocities (v,v_nom) in the pressure loss law to obtain its corresponding pressure loss.
</p>

<h4>Verification</h4>
<p>
<strong>Compressible case</strong> [Mass flow rate = f(dp)]:
</p>
<p>
The generic mass flow rate <strong>M_FLOW</strong> in dependence of the pressure loss <strong>dp</strong> is shown for a turbulent pressure loss regime (exp == 2) in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/General/dp_nominalPressureLossLawDensity.png\" alt=\"dp_nominalPressureLossLawDensity\"/>
</div>

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_nominalPressureLossLawDensity\">dp_nominalPressureLossLawDensity</a> is also valid for this inverse calculation due to using the same functions.
</p>

<h4>References</h4>
<dl>
<dt>Elmqvist, H., M.Otter and S.E. Cellier:</dt>
    <dd><strong>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.
    In Proceedings of European Simulation MultiConference, Prague, 1995.</dd>
<dt>Wischhusen, S.:</dt>
    <dd><strong>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</strong>.
    PhD thesis, Technische Universit&auml;t Hamburg-Harburg, 2005.</dd>
</dl>

</html>"));
    end dp_nominalPressureLossLawDensity;

    class dp_pressureLossCoefficient
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
Calculation of a generic pressure loss in dependence of a pressure loss coefficient.
</p>
<h4>Calculation</h4>
<p>
The mass flow rate <strong>m_flow</strong> is determined by:
</p>

<blockquote><pre>
m_flow = rho*A_cross*(dp/(zeta_TOT *(rho/2))^0.5
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> A_cross        </strong></td><td> as cross sectional area [m2],</td></tr>
<tr><td><strong> dp             </strong></td><td> as pressure loss [Pa],</td></tr>
<tr><td><strong> rho            </strong></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><strong> m_flow         </strong></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><strong> zeta_TOT       </strong></td><td> as pressure loss coefficient [-].</td></tr>
</table>

<h4>Verification</h4>
<p>
<strong>Compressible case</strong> [Mass flow rate = f(dp)]:
</p>
<p>
The mass flow rate <strong>M_FLOW</strong> in dependence of the pressure loss <strong>dp</strong> for a constant pressure loss coefficient <strong>zeta_TOT</strong> is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/General/dp_pressureLossCoefficient.png\" alt=\"dp_pressureLossCoefficient\"/>
</div>

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_pressureLossCoefficient\">dp_pressureLossCoefficient</a> is also valid for this inverse calculation due to using the same functions.
</p>

<h4>References</h4>
<dl>
 <dt>Elmqvist, H., M.Otter and S.E. Cellier:</dt>
    <dd><strong>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.
    In Proceedings of European Simulation MultiConference, Prague, 1995.</dd>
 <dt>Wischhusen, S.:</dt>
    <dd><strong>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</strong>.
    PhD thesis, Technische Universit&auml;t Hamburg-Harburg, 2005.</dd>
</dl>
</html>"));
    end dp_pressureLossCoefficient;

    class dp_volumeFlowRate
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
Calculation of a generic pressure loss with linear or quadratic dependence on volume flow rate.
</p>
<h4>Calculation</h4>
<p>
The geometry parameters of energy devices necessary for the pressure loss calculations are often not exactly known.
Therefore the modelling of the detailed pressure loss calculation has to be simplified. This function uses as
quadratic dependence of the pressure loss on the volume flow rate.
</p>
<p>
The mass flow rate <strong>m_flow</strong> for the compressible case [Mass flow rate = f(dp)] is determined to <em> [see Wischhusen]</em>:
</p>
<blockquote><pre>
m_flow = rho*[-b/(2a) + {[b/(2a)]^2 + dp/a}^0.5]
</pre></blockquote>
<p>
with
</p>

<table>
<tr><td><strong> a              </strong></td><td> as quadratic coefficient [Pa*s^2/m^6],</td></tr>
<tr><td><strong> b              </strong></td><td> as linear coefficient [Pa*s/m3],</td></tr>
<tr><td><strong> dp             </strong></td><td> as pressure loss [Pa],</td></tr>
<tr><td><strong> m_flow         </strong></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><strong> rho            </strong></td><td> as density of fluid [kg/m3].</td></tr>
</table>

<p>
Note that the coefficients <strong>a,b</strong> have to be positive values so that there will be a positive (linear or quadratic) pressure loss at positive volume flow rate and vice versa.
</p>
<h4>Verification</h4>
<p><strong> Compressible case</strong> [Mass flow rate = f(dp)]:</p>
<p>
The generic pressure loss <strong>dp</strong> for different coefficients <strong>a</strong> as parameter is shown in dependence of the volume flow rate <strong>V_flow</strong> in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/General/dp_volumeFlowRate.png\" alt=\"dp_volumeFlowRate\"/>
</div>

<p>
Note that the verification for <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_volumeFlowRate\">dp_volumeFlowRate</a> is also valid for this inverse calculation due to using the same functions.
</p>

<h4>References</h4>
<dl>
<dt>Elmqvist, H., M.Otter and S.E. Cellier:</dt>
    <dd><strong>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.
    In Proceedings of European Simulation MultiConference, Prague, 1995.</dd>
<dt>Wischhusen, S.:</dt>
    <dd><strong>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</strong>.
    PhD thesis, Technische Universit&auml;t Hamburg-Harburg, 2005.</dd>
</dl>
</html>"));
    end dp_volumeFlowRate;

      annotation (DocumentationClass=true);
    end General;

    package Orifice
      extends Modelica.Icons.Information;

    class dp_suddenChange
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<h4>Restriction</h4>
<p>
This function shall be used within the restricted limits according to the referenced literature.
</p>
<ul>
 <li>
      <strong>Smooth surface</strong></li>
 <li>
      <strong>Turbulent flow regime</strong></li>
 <li>
      <strong>Reynolds number for sudden expansion Re &gt; 3.3e3</strong> <em>[Idelchik 2006, p. 208, diag. 4-1]</em></li>
 <li>
      <strong>Reynolds number for sudden contraction Re &gt; 1e4</strong> <em>[Idelchik 2006, p. 216-217, diag. 4-9]</em></li>
</ul>

<h4>Geometry </h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Orifice/suddenChangeSection.png\" alt=\"suddenChangeSection\"/>
</div>

<h4>Calculation</h4>
<p>
The local pressure loss <strong>dp</strong> is generally determined by:
</p>

<blockquote><pre>
dp = 0.5 * zeta_LOC * rho * |v_1|*v_1
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> rho              </strong></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><strong> v_1             </strong></td><td> as average flow velocity in small cross sectional area [m/s].</td></tr>
<tr><td><strong> zeta_LOC         </strong></td><td> as local resistance coefficient [-],</td></tr>
</table>

<p>
The local resistance coefficient <strong>zeta_LOC</strong> of a sudden expansion can be calculated for different ratios of cross sectional areas by:
</p>

<blockquote><pre>
zeta_LOC = (1 - A_1/A_2)^2  <em>[Idelchik 2006, p. 208, diag. 4-1]</em>
</pre></blockquote>

<p>
and for sudden contraction:
</p>

<blockquote><pre>
zeta_LOC = 0.5*(1 - A_1/A_2)^0.75  <em>[Idelchik 2006, p. 216-217, diag. 4-9]</em>
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> A_1       </strong></td><td> small cross sectional area [m^2],</td></tr>
<tr><td><strong> A_2       </strong></td><td> large cross sectional area [m^2].</td></tr>
</table>

<h4>Verification</h4>
<p>
The local resistance coefficient <strong>zeta_LOC</strong> of a sudden expansion in dependence of the cross sectional area ratio <strong>A_1/A_2</strong> is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Orifice/suddenChangeExpansion.png\" alt=\"suddenChangeExpansion\"/>
</div>

<p>
The local resistance coefficient <strong>zeta_LOC</strong> of a sudden contraction in dependence of the cross sectional area ratio <strong>A_1/A_2</strong> is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Orifice/suddenChangeContraction.png\" alt=\"suddenChangeContraction\"/>
</div>

<h4>References</h4>
<dl>
<dt>Elmqvist, H., M.Otter and S.E. Cellier:</dt>
    <dd><strong>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.
    In Proceedings of European Simulation MultiConference, Prague, 1995.</dd>
<dt>Idelchik,I.E.:</dt>
    <dd><strong>Handbook of hydraulic resistance</strong>.
    Jaico Publishing House, Mumbai, 3rd edition, 2006.</dd>
</dl>
</html>"));
    end dp_suddenChange;

    class dp_thickEdgedOverall
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<h4>Restriction</h4>
<p>
This function shall be used within the restricted limits according to the referenced literature.
</p>
<ul>
 <li>
      <strong>Reynolds number (for vena contraction) Re &gt; 1e3</strong> <em>[Idelchik 2006, p. 222, diag. 4-15]</em></li>
 <li>
      <strong>Relative length of vena contraction (L/d_hyd_0) &gt; 0.015</strong> <em>[Idelchik 2006, p. 222, diag. 4-15]</em></li>
 <li>
      <strong>Darcy friction factor lambda_FRI = 0.02</strong> <em>[Idelchik 2006, p. 222, sec. 4-15]</em></li>
</ul>

<h4>Geometry</h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Orifice/thickEdged.png\" alt=\"thickEdged\"/>
</div>

<h4>Calculation</h4>
<p>
The pressure loss <strong>dp</strong> for a thick edged orifice is determined by:
</p>

<blockquote><pre>
dp = zeta_TOT * (rho/2) * (velocity_1)^2
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> rho            </strong></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><strong> velocity_1     </strong></td><td> as mean velocity in large cross sectional area [m/s],</td></tr>
<tr><td><strong> zeta_TOT       </strong></td><td> as pressure loss coefficient [-].</td></tr>
</table>

<p>
The pressure loss coefficient <strong>zeta_TOT</strong> of a thick edged orifice can be calculated for different cross sectional areas <strong>A_0</strong> and relative length of orifice <strong>l_bar</strong> = L/d_hyd_0 by:
</p>

<blockquote><pre>
zeta_TOT = (0.5*(1 - A_0/A_1)^0.75 + tau*(1 - A_0/A_1)^1.375 + (1 - A_0/A_1)^2 + lambda_FRI*l_bar)*(A_1/A_0)^2 <em>[Idelchik 2006, p. 222, diag. 4-15]</em>
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> A_0       </strong></td><td> cross sectional area of vena contraction [m2],</td></tr>
<tr><td><strong> A_1       </strong></td><td> large cross sectional area of orifice [m2],</td></tr>
<tr><td><strong> d_hyd_0   </strong></td><td> hydraulic diameter of vena contraction [m],</td></tr>
<tr><td><strong> lambda_FRI</strong></td><td> as constant Darcy friction factor [-],</td></tr>
<tr><td><strong> l_bar     </strong></td><td> relative length of orifice [-],</td></tr>
<tr><td><strong> L         </strong></td><td> length of vena contraction [m],</td></tr>
<tr><td><strong> tau       </strong></td><td> geometry parameter [-].</td></tr>
</table>

<p>
The geometry factor <strong>tau</strong> is determined by <em>[Idelchik 2006, p. 219, diag. 4-12]</em>:
</p>

<blockquote><pre>
tau = (2.4 - l_bar)*10^(-phi)
phi = 0.25 + 0.535*l_bar^8 / (0.05 + l_bar^8) .
</pre></blockquote>

<h4>Verification</h4>
<p>
The pressure loss coefficient <strong>zeta_TOT</strong> of a thick edged orifice in dependence of a relative length <strong>(l_bar = L /d_hyd)</strong> with different ratios of cross sectional areas <strong>A_0/A_1</strong> is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Orifice/thickEdgedOverall_1.png\" alt=\"thickEdgedOverall_1\"/>
</div>

<p>
<strong>Incompressible case</strong> [Pressure loss = f(m_flow)]:
</p>
<p>
The pressure loss <strong>DP</strong> of an thick edged orifice in dependence of the mass flow rate <strong>m_flow</strong> of water for different ratios <strong>A_0/A_1</strong> (where <strong>A_0</strong> = 0.001 m^2) is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Orifice/thickEdgedOverall_2.png\" alt=\"thickEdgedOverall_2\"/>
</div>

<p>
<strong>And for the compressible case</strong> [Mass flow rate = f(dp)]:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Orifice/thickEdgedOverall_3.png\" alt=\"thickEdgedOverall_3\"/>
</div>

<h4>References</h4>
<dl>
 <dt>Elmqvist,H., M.Otter and S.E. Cellier:</dt>
    <dd><strong>Inline integration: A new mixed
symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.
    In Proceedings of European Simulation MultiConference, Prague, 1995.</dd>
<dt>Idelchik,I.E.:</dt>
    <dd><strong>Handbook of hydraulic resistance</strong>.
    Jaico Publishing House,Mumbai, 3rd edition, 2006.</dd>
</dl>
</html>"));
    end dp_thickEdgedOverall;

      annotation (DocumentationClass=true);
    end Orifice;

    package StraightPipe
      extends Modelica.Icons.Information;

    class dp_laminar
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <strong>laminar</strong> flow regime of single-phase fluid flow only.
</p>
<h4>Restriction</h4>
<p>
This function shall be used inside of the restricted limits according to the referenced literature.
</p>
<ul>
 <li><strong>circular cross sectional area</strong></li>
 <li><strong>laminar flow regime (Reynolds number Re &le; 2000) <em>[VDI-W&auml;rmeatlas 2002, p. Lab, eq. 3]</em></strong></li>
</ul>

<h4>Geometry </h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/straightPipe.png\" alt=\"straightPipe\"/>
</div>

<h4>Calculation</h4>
<p>
The pressure loss <strong>dp</strong> for straight pipes is determined by:
</p>

<blockquote><pre>
dp = lambda_FRI * (L/d_hyd) * (rho/2) * velocity^2
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> lambda_FRI     </strong></td><td> as Darcy friction factor [-].</td></tr>
<tr><td><strong> L              </strong></td><td> as length of straight pipe [m],</td></tr>
<tr><td><strong> d_hyd          </strong></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><strong> rho            </strong></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><strong> velocity       </strong></td><td> as mean velocity [m/s].</td></tr>
</table>

<p>
The Darcy friction factor <strong>lambda_FRI</strong> of straight pipes for the laminar flow regime is calculated by <strong>Hagen-Poiseuilles</strong> law according to <em>[Idelchik 2006, p. 77, eq. 2-3]</em> as follows:
</p>
<ul>
 <li><strong> Laminar flow regime</strong> is restricted to a Reynolds number <strong>Re</strong> &le; 2000</li>
 <li>and calculated through:
     <blockquote><pre>
lambda_FRI = 64/Re
     </pre></blockquote>
     <p>
     with
     </p>
     <table>
     <tr><td><strong> lambda_FRI     </strong></td><td> as Darcy friction factor [-],</td></tr>
     <tr><td><strong> Re             </strong></td><td> as Reynolds number [-].</td></tr>
     </table>
     </li>
</ul>

<p>
The Darcy friction factor <strong>lambda_FRI</strong> in the laminar regime is independent
of the surface roughness <strong>K</strong> as long as the relative roughness <strong>k = surface roughness/hydraulic diameter</strong> is smaller than 0.007.
A higher relative roughness <strong>k</strong> than 0.007 leads to an earlier leaving of the laminar regime to the transition regime at some value of Reynolds number <strong>Re_lam_leave</strong>. This earlier leaving is not modelled here because only laminar fluid flow is considered.
</p>

<h4>Verification</h4>
<p>
The Darcy friction factor <strong>lambda_FRI</strong> in dependence of Reynolds number is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/laminar.png\" alt=\"laminar\"/>
</div>

<p>
The pressure loss <strong>dp</strong> for the laminar regime in dependence of the mass flow rate of water is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/dp_laminar.png\" alt=\"dp_laminar\"/>
</div>

<p>
Note that this pressure loss function shall not be used for the modelling outside of the laminar flow regime at <em><strong>Re</strong> &gt; 2000</em> even though it could be used for that.
</p>
<p>
If the whole flow
regime shall be modelled, the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_overall\">dp_overall</a> can be used.
</p>

<h4>References</h4>
<dl>
 <dt>Elmqvist,H., M.Otter and S.E. Cellier:</dt>
    <dd><strong>Inline integration: A new mixed
    symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.
    In Proceedings of European Simulation MultiConference, Prague, 1995.</dd>
<dt>Idelchik,I.E.:</dt>
    <dd><strong>Handbook of hydraulic resistance</strong>.
    Jaico Publishing House, Mumbai, 3rd edition, 2006.</dd>
 <dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>
</html>"));
    end dp_laminar;

    class dp_overall
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <strong>laminar or turbulent</strong> flow regime of single-phase fluid flow only considering surface roughness.
</p>
<h4>Restriction</h4>
<p>
This function shall be used within the restricted limits according to the referenced literature.
</p>
<ul>
 <li>
      <strong>circular cross sectional area</strong></li>
</ul>

<h4>Geometry </h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/straightPipe.png\" alt=\"straightPipe\"/>
</div>

<h4>Calculation</h4>
The pressure loss <strong>dp</strong> for straight pipes is determined by:

<blockquote><pre>
dp = lambda_FRI * (L/d_hyd) * (rho/2) * velocity^2
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> lambda_FRI     </strong></td><td> as Darcy friction factor [-],</td></tr>
<tr><td><strong> L              </strong></td><td> as length of straight pipe [m],</td></tr>
<tr><td><strong> d_hyd          </strong></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><strong> rho            </strong></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><strong> velocity       </strong></td><td> as mean velocity [m/s].</td></tr>
</table>

<p>
The Darcy friction factor <strong>lambda_FRI</strong> for straight pipes is calculated depending on the fluid flow regime (with corresponding Reynolds number <strong>Re</strong>) and the absolute surface roughness <strong>K</strong>.
</p>
<p>

<strong>The Laminar regime</strong> is calculated for <strong>Re</strong> &le; 2000 by the Hagen-Poiseuille law according to <em>[Idelchik 2006, p. 77, eq. 2-3]</em>
</p>

<blockquote><pre>
lambda_FRI = 64/Re
</pre></blockquote>

<p>
The Darcy friction factor <strong>lambda_FRI</strong> in the laminar regime is independent of the surface roughness <strong>k</strong> as long as the relative roughness <strong>k</strong> is smaller than 0.007. A greater relative roughness <strong>k</strong> than 0.007 is leading to an earlier leaving of the Hagen-Poiseuille law at some value of Reynolds number <strong>Re_lam_leave</strong>. The leaving of the laminar regime in dependence of the relative roughness <strong>k</strong> is calculated according to <em>[Samoilenko in Idelchik 2006, p. 81, sect. 2-1-21]</em> as:
</p>
<blockquote><pre>
Re_lam_leave = 754*exp(if k &le; 0.007 then 0.93 else 0.0065/k)
</pre></blockquote>

<p>
<strong>The Transition regime</strong> is calculated for 2000 &lt; <strong>Re</strong> &le; 4000 by a cubic interpolation between the equations of the laminar and turbulent flow regime. Different cubic
interpolation equations for the calculation of either pressure loss <strong>dp</strong> or mass flow rate <strong>m_flow</strong> results in a deviation of the Darcy friction factor <strong>lambda_FRI</strong> through the
transition regime. This deviation can be neglected due to the uncertainty in determination of the fluid flow in the transition regime.
</p>

<p>
<strong>Turbulent regime</strong> can be calculated for a smooth surface (Blasius law) <strong>or</strong> a rough surface (Colebrook-White law):
</p>

<p>
<strong>Smooth surface (roughness = Modelica.Fluid.Dissipation.Utilities.Types.Roughness.Neglected)</strong> w.r.t. <strong>Blasius</strong> law in the turbulent regime according to <em>[Idelchik 2006, p. 77, sec. 15]</em>:
</p>
<blockquote><pre>
lambda_FRI = 0.3164*Re^(-0.25)
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> lambda_FRI     </strong></td><td> as Darcy friction factor [-].</td></tr>
<tr><td><strong> Re             </strong></td><td> as Reynolds number [-].</td></tr>
</table>

<p>
Note that the Darcy friction factor <strong>lambda_FRI</strong> for smooth straight pipes in the turbulent regime is independent
of the surface roughness <strong>K</strong> .
</p>

<p>
<strong>Rough surface (roughness = Modelica.Fluid.Dissipation.Utilities.Types.Roughness.Considered)</strong> w.r.t. <strong>Colebrook-White</strong> law in the turbulent regime according to <em>[Miller 1984, p. 191, eq. 8.4]</em>:
</p>
<blockquote><pre>
lambda_FRI = 0.25/{lg[k/(3.7*d_hyd) + 5.74/(Re)^0.9]}^2
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> d_hyd          </strong></td><td> as hydraulic diameter [-],</td></tr>
<tr><td><strong> k= K/d_hyd     </strong></td><td> as relative roughness [-],</td></tr>
<tr><td><strong> K              </strong></td><td> as roughness (average height of surface asperities [m],</td></tr>
<tr><td><strong> lambda_FRI     </strong></td><td> as Darcy friction factor [-],</td></tr>
<tr><td><strong> Re             </strong></td><td> as Reynolds number [-].</td></tr>
</table>

<h4>Verification</h4>
<p>
The Darcy friction factor <strong>lambda_FRI</strong> in dependence of Reynolds number for different values of relative roughness <strong>k</strong> is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/dp_overall_1.png\" alt=\"dp_overall_1\"/>
</div>

<p>
The pressure loss <strong>dp</strong> for the turbulent regime in dependence of the mass flow rate of water is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/dp_overall_2.png\" alt=\"dp_overall_2\"/>
</div>

<p>
And the mass flow rate <strong>m_flow</strong> for the turbulent regime in dependence of the pressure loss of water is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/dp_overall_3.png\" alt=\"dp_overall_3\"/>
</div>

<h4>References</h4>
<dl>
 <dt>Idelchik,I.E.:</dt>
    <dd><strong>Handbook of hydraulic resistance</strong>.
    Jaico Publishing House, Mumbai, 3rd edition, 2006.</dd>
 <dt>Miller,D.S.:</dt>
    <dd><strong>Internal flow systems</strong>.
    volume 5th of BHRA Fluid Engineering Series.BHRA Fluid Engineering, 1984.</dd>
 <dt>Samoilenko,L.A.:</dt>
    <dd><strong>Investigation of the hydraulic resistance of pipelines in the
        zone of transition from laminar into turbulent motion</strong>.
        PhD thesis, Leningrad State University, 1968.</dd>
 <dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>
</html>"));
    end dp_overall;

    class dp_turbulent
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
Calculation of pressure loss in a straight pipe for <strong>turbulent</strong> flow regime of single-phase fluid flow only considering surface roughness.
</p>
<h4>Restriction</h4>
<p>
This function shall be used within the restricted limits according to the referenced literature.
</p>
<ul>
 <li>
      <strong>circular cross sectional area</strong></li>
 <li>
      <strong>turbulent flow regime (Reynolds number Re &ge; 4e3) <em>[VDI-W&auml;rmeatlas 2002, p. Lab 3, fig. 1]</em></strong></li>
</ul>

<h4>Geometry </h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/straightPipe.png\" alt=\"straightPipe\"/>
</div>

<h4>Calculation</h4>
<p>
The pressure loss <strong>dp</strong> for straight pipes is determined by:
</p>

<blockquote><pre>
dp = lambda_FRI * (L/d_hyd) * (rho/2) * velocity^2
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> lambda_FRI     </strong></td><td> as Darcy friction factor [-].</td></tr>
<tr><td><strong> L              </strong></td><td> as length of straight pipe [m],</td></tr>
<tr><td><strong> d_hyd          </strong></td><td> as hydraulic diameter of straight pipe [m],</td></tr>
<tr><td><strong> rho            </strong></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><strong> velocity       </strong></td><td> as mean velocity [m/s].</td></tr>
</table>

<p>
The Darcy friction factor <strong>lambda_FRI</strong> for a straight pipe in the turbulent regime can be calculated for a smooth surface (Blasius law) <strong>or</strong> a rough surface (Colebrook-White law).
</p>
<p>
<strong>Smooth surface (roughness = Modelica.Fluid.Dissipation.Utilities.Types.Roughness.Neglected)</strong> w.r.t. <strong>Blasius</strong> law in the turbulent regime according to <em>[Idelchik 2006, p. 77, sec. 15]</em>:
</p>

<blockquote><pre>
lambda_FRI = 0.3164*Re^(-0.25)
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> lambda_FRI     </strong></td><td> as Darcy friction factor [-].</td></tr>
<tr><td><strong> Re             </strong></td><td> as Reynolds number [-].</td></tr>
</table>

<p>
Note that the Darcy friction factor <strong>lambda_FRI</strong> for smooth straight pipes in the turbulent regime is independent
of the surface roughness <strong>K</strong> .
</p>

<p>
<strong>Rough surface (roughness = Modelica.Fluid.Dissipation.Utilities.Types.Roughness.Considered)</strong> w.r.t. <strong>Colebrook-White</strong> law in the turbulent regime according to <em>[Miller 1984, p. 191, eq. 8.4]</em>:
</p>

<blockquote><pre>
lambda_FRI = 0.25/{lg[k/(3.7*d_hyd) + 5.74/(Re)^0.9]}^2
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> d_hyd          </strong></td><td> as hydraulic diameter [-],</td></tr>
<tr><td><strong> k= K/d_hyd     </strong></td><td> as relative roughness [-],</td></tr>
<tr><td><strong> K              </strong></td><td> as roughness (average height of surface asperities [m].</td></tr>
<tr><td><strong> lambda_FRI     </strong></td><td> as Darcy friction factor [-],</td></tr>
<tr><td><strong> Re             </strong></td><td> as Reynolds number [-].</td></tr>
</table>

<h4>Verification</h4>
<p>
The Darcy friction factor <strong>lambda_FRI</strong> in dependence of Reynolds number for different values of relative roughness <strong>k</strong> is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/turbulent.png\" alt=\"turbulent\"/>
</div>

<p>
Note that this pressure loss function shall not be used for the modelling outside of the turbulent flow regime at <strong>Re</strong> &lt; 4e3 even though it could be used for that.
</p>

<p>
If the overall flow regime shall be modelled, the pressure loss function <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_overall\">dp_overall</a> can be used.
</p>

<h4>References</h4>
<dl>
 <dt>Idelchik,I.E.:</dt>
    <dd><strong>Handbook of hydraulic resistance</strong>.
    Jaico Publishing House, Mumbai, 3rd edition, 2006.</dd>
 <dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 9th edition, 2002.</dd>
</dl>
</html>"));
    end dp_turbulent;

    class dp_twoPhaseOverall
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
Calculation of pressure loss for <strong>two phase flow</strong> in a horizontal <strong>or</strong> vertical straight pipe for an overall flow regime considering frictional, momentum and geodetic pressure loss.
</p>
<h4>Restriction</h4>
<p>
This function shall be used within the restricted limits according to the referenced literature.
</p>
<ul>
 <li><strong>circular cross sectional area</strong></li>
 <li><strong>neglecting of surface roughness</strong></li>
 <li><strong>horizontal flow or vertical upflow</strong></li>
 <li><strong>usage of mass flow rate quality (see Calculation)</strong></li>
 <li><strong>two phase pressure loss for mean constant mass flow rate quality (x_flow) over (increment) length</strong></li>
 <li><strong>usage of two phase pressure loss function for discretization at boiling or condensation considering variable mass flow rate quality</strong></li>
</ul>

<h4>Geometry </h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/straightPipe.png\" alt=\"straightPipe\"/>
</div>

<h4>Calculation</h4>
<p>
The two phase pressure loss <strong>dp_2ph</strong> of straight pipes is determined by:
</p>

<blockquote><pre>
dp_2ph = dp_fri + dp_mom + dp_geo
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> dp_fri        </strong></td><td> as frictional pressure loss [Pa],</td></tr>
<tr><td><strong> dp_mom        </strong></td><td> as momentum pressure loss [Pa],</td></tr>
<tr><td><strong> dp_geo        </strong></td><td> as geodetic pressure loss [Pa].</td></tr>
</table>

<p>
<strong>Definition of quality for two phase flow</strong>:
</p>
<p>
Different definitions of the quality exist for two phase flow. Static quality, mass flow rate quality and thermodynamic quality can be used to describe the fraction of gas and liquid in two phase flow.
Here the mass flow rate quality <strong>(x_flow)</strong> is used to describe two phase flow as follows:
</p>

<blockquote><pre>
x_flow = mdot_g/(mdot_g+mdot_l)
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> x_flow        </strong></td><td> as mass flow rate quality [-],</td></tr>
<tr><td><strong> mdot_g        </strong></td><td> as gaseous mass flow rate [kg/s],</td></tr>
<tr><td><strong> mdot_l        </strong></td><td> as liquid mass flow rate [kg/s].</td></tr>
</table>

<p>
Note that mass flow rate quality <strong>(x_flow)</strong> is only equal to the static quality, if a difference between the velocity of gas and liquid phase is neglected (homogeneous approach).
Additionally the thermodynamic quality is only equal to the mass flow rate quality <strong>(x_flow)</strong> in the two phase regime for thermodynamic equilibrium of the phases.
</p>
<p>
<strong>Frictional pressure loss</strong>:
</p>
<p>
The frictional pressure loss <strong>dp_fri</strong> of a straight pipe is calculated either by the correlation of <strong>Friedel</strong> (frictionalPressureLoss==Friedel) or by the correlation of <strong>Chisholm</strong> (frictionalPressureLoss==Chisholm).
Both correlations can be used for the above named two phase flow regimes.
The two phase frictional pressure loss results from a frictional pressure loss assuming one phase liquid fluid flow and a two phase multiplier taking into account the effects of two phase flow:
</p>

<blockquote><pre>
dp_fri = dp_1ph*phi_i
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> dp_1ph  </strong></td><td> as frictional pressure loss assuming one phase liquid fluid flow [Pa],</td></tr>
<tr><td><strong> phi_i   </strong></td><td> as two phase multiplier [-].</td></tr>
</table>

<p>
The liquid frictional pressure loss is calculated with the <strong>total mass flow rate</strong> assumed to flow as liquid.
</p>
<p>
The correlations of Friedel and Chisholm differ in their calculation of the two phase multiplier:
</p>
<blockquote><pre>
phi_friedel = (1 - x_flow)^2 + x_flow^2*(rho_l/rho_g)*(lambda_g/lambda_l)
            + 3.43*x_flow^0.685*(1 - x_flow)^0.24*(rho_l/rho_g)^0.8*(eta_g/eta_l)^0.22*(1 - eta_g/eta_l)^0.89*(1/Fr_l^(0.048))*(1/We_l^(0.0334))
</pre></blockquote>
<blockquote><pre>
phi_chisholm = 1 + (gamma^2 - 1)*(B*x_flow^((2 - n_exp)/2)*(1 - x_flow)^((2 -n_exp)/2) + x_flow^(2 - n_exp))
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> B              </strong></td><td> as Lockhart-Martinelli coefficient [-],</td></tr>
<tr><td><strong> eta_l          </strong></td><td> as dynamic viscosity of the liquid phase [Pas],</td></tr>
<tr><td><strong> eta_g          </strong></td><td> as dynamic viscosity of the gaseous phase [Pas],</td></tr>
<tr><td><strong> gamma          </strong></td><td> as physical property coefficient [-],</td></tr>
<tr><td><strong> n_exp</strong> =0.2     </td><td> as exponent in Chisholm correlation [-],</td></tr>
<tr><td><strong> phi_i          </strong></td><td> as two phase multiplier [-],</td></tr>
<tr><td><strong> rho_l          </strong></td><td> as density of the liquid phase [kg/m3],</td></tr>
<tr><td><strong> rho_g          </strong></td><td> as density of the gaseous phase [kg/m3],</td></tr>
<tr><td><strong> Re_l           </strong></td><td> as Reynolds number of the liquid phase [-],</td></tr>
<tr><td><strong> Re_g           </strong></td><td> as Reynolds number of the gaseous phase [-],</td></tr>
<tr><td><strong> Fr_l           </strong></td><td> as Froude number of the liquid phase [-],</td></tr>
<tr><td><strong> We_l           </strong></td><td> as Weber number of the liquid phase [-],</td></tr>
<tr><td><strong> x_flow         </strong></td><td> as mass flow rate quality [-].</td></tr>
</table>

<p>
Note that the (mean constant) mass flow rate quality <strong>(x_flow)</strong> used for frictional pressure loss is calculated as arithmetic mean value out of the mass flow rate quality at the end and at the start of the straight pipe length.
</p>
<p>
<strong>Momentum pressure loss</strong>:
</p>
<p>
The momentum pressure loss <strong>dp_mom</strong> can be considered (momentumPressureLoss = true) for a homogeneous or heterogeneous two phase flow depending on the approach used for the void fraction <strong>(epsilon)</strong>.
At evaporation the liquid phase having a slow velocity has to be accelerated to the higher velocity of the gas. The difference in static pressure at the outlet and the inlet causes a positive momentum pressure loss at evaporation (assumed vice versa for condensation).
The momentum pressure loss occurs for a changing mass flow rate quality due to condensation or evaporation according to <em>[VDI 2006, p.Lba 4, eq. 22]</em> :
</p>

<blockquote><pre>
dp_mom = mdot_A^2*[[((1-x_flow)^2/(rho_l*(1-epsilon)) + x_flow^2/(rho_g*epsilon))]_out - [((1-x_flow)^2/(rho_l*(1-epsilon)) + x_flow^2/(rho_g*epsilon))]_in]
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> mdot_A         </strong></td><td> as total mass flow rate density [kg/(m2s)],</td></tr>
<tr><td><strong> epsilon        </strong></td><td> as void fraction [-],</td></tr>
<tr><td><strong> rho_l          </strong></td><td> as density of the liquid phase [kg/m3],</td></tr>
<tr><td><strong> rho_g          </strong></td><td> as density of the gaseous phase [kg/m3],</td></tr>
<tr><td><strong> x_flow         </strong></td><td> as mass flow rate quality [-].</td></tr>
</table>

<p>
Note that a momentum pressure loss is only considered for a variable mass flow rate quality <strong>(x_flow)</strong> during evaporation or condensation. Momentum pressure loss does not occur under adiabatic conditions for a corresponding constant mass flow rate quality (evaporation due to pressure loss is not considered).
</p>

<p>
<strong>Void fraction approach</strong>:
</p>
<p>
The void fraction is one of the most important parameter used to characterize two phase flow. There are several analytical and empirical approaches according to <em>[Thome, J.R]</em> :
</p>

<ul>
 <li><strong>homogeneous approach</strong></li>
 <li><strong>momentum flux approach (heterogeneous model)</strong></li>
 <li><strong>Kinetic energy flow approach by Zivi (heterogeneous model)</strong></li>
 <li><strong>Empirical momentum flux approach by Chisholm (heterogeneous model)</strong></li>
</ul>

<p>
These approaches for the void fraction <strong>epsilon</strong> imply a correlation for the slip ratio. The slip ratio is defined as ratio of the velocity from the gaseous phase to the liquid phase at two phase flow.
The effects of different fluid flow velocities of the phases on two phase pressure loss can be considered with the slip ratio in the heterogeneous approaches. The slip ratio for the homogeneous approach is unity, so that there is no difference in the velocities of the two phases (e.g., usable for bubble flow).
</p>
<p>
<strong>Geodetic pressure loss</strong>:
</p>
<p>
The geodetic pressure loss <strong>dp_geo</strong> can be considered (geodeticPressureLoss=true) for two phase flow according to <em>[VDI 2006, p.Lbb 1, eq. 4]</em> :
</p>

<blockquote><pre>
dp_geo = (epsilon*rho_g +(1-epsilon)*rho_l)*g*L*sin(phi)
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> epsilon        </strong></td><td> as void fraction [-],</td></tr>
<tr><td><strong> rho_l          </strong></td><td> as density of the liquid phase [kg/m3],</td></tr>
<tr><td><strong> rho_g          </strong></td><td> as density of the gaseous phase [kg/m3],</td></tr>
<tr><td><strong> g              </strong></td><td> as acceleration of gravity [m/s2],</td></tr>
<tr><td><strong> L              </strong></td><td> as length of straight pipe [m],</td></tr>
<tr><td><strong> phi            </strong></td><td> as angle to horizontal [rad].</td></tr>
</table>

<h4>Verification</h4>
<p>
The two phase pressure loss for a horizontal pipe calculated by the correlation of <em>Friedel</em> neglecting momentum and geodetic pressure loss is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/dp_twoPhaseOverall_1.png\" alt=\"dp_twoPhaseOverall_1\"/>
</div>

<p>
The two phase pressure loss for a horizontal pipe calculated by the correlation of <em>Chisholm</em> neglecting momentum and geodetic pressure loss is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/dp_twoPhaseOverall_4.png\" alt=\"dp_twoPhaseOverall_4\"/>
</div>

<h4>References</h4>
<dl>
<dt>Chisholm,D.:</dt>
    <dd><strong>Pressure gradients due to friction during the flow of evaporating two-phase mixtures in smooth tubes and channels</strong>.
    Volume 16th of International Journal of Heat and Mass Transfer, 1973.</dd>
 <dt>Friedel,L.:</dt>
    <dd><strong>IMPROVED FRICTION PRESSURE DROP CORRELATIONS FOR HORIZONTAL AND VERTICAL TWO PHASE PIPE FLOW</strong>.3R International, Vol. 18, Issue 7, pp. 485-491, 1979.</dd>
 <dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 10th edition, 2006.</dd>
<dt>J.M. Jensen and H. Tummescheit:</dt>
    <dd><strong>Moving boundary models for dynamic simulations of two-phase flows</strong>.
    In Proceedings of the 2nd International Modelica Conference, pages 235-244, Oberpfaffenhofen, Germany, 2002. The Modelica Association.</dd>
<dt>Thome, J.R.:</dt>
    <dd><strong>Engineering Data Book 3</strong>.Swiss Federal Institute of Technology Lausanne (EPFL), 2009.</dd>
</dl>
</html>"));
    end dp_twoPhaseOverall;

      annotation (DocumentationClass=true);
    end StraightPipe;

    package Valve
      extends Modelica.Icons.Information;

    class dp_severalGeometryOverall
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
Calculation of pressure loss for a valve with different geometries at overall flow regime for incompressible and single-phase fluid flow in dependence of its opening.
</p>
<h4>Restriction</h4>
<p>
This function shall be used inside of the restricted limits according to the referenced literature.
</p>
<ul>
 <li>
      <strong>developed fluid flow</strong>
 </li>
 <li>
      <strong>ball valve</strong>
 </li>
 <li>
      <strong>diaphragm valve</strong>
 </li>
 <li>
      <strong>butterfly valve</strong>
 </li>
 <li>
      <strong>gate valve</strong>
 </li>
 <li>
      <strong>sluice valve</strong>
 </li>
</ul>

<h4>Geometry</h4>
<p>
Wide variations in valve geometry are possible and a manufacturer will not necessarily maintain geometric similarity between valves of the same type but of different size. Here pressure loss can be estimated for the following types of a valve:
</p>
<ul>
 <li>
      <strong>ball valve</strong>
 </li>
 <li>
      <strong>diaphragm valve</strong>
 </li>
 <li>
      <strong>butterfly valve</strong>
 </li>
 <li>
      <strong>gate valve</strong>
 </li>
 <li>
      <strong>sluice valve</strong>
 </li>
</ul>

<h4>Calculation</h4>
<p>
The mass flow rate <strong>m_flow</strong> for valves out of pressure loss is determined by:
</p>

<blockquote><pre>
m_flow = [rho * dp * Av^2 / (zeta_TOT/2]^0.5
m_flow = (2/zeta_TOT)^0.5 * Av * (rho * dp)^0.5
m_flow = valveCharacteristic * Av * (rho * dp)^0.5
</pre></blockquote>

<p>
with
</p>

<table>
<tr><td><strong> rho                        </strong></td><td> as density of fluid [kg/m3],</td></tr>
<tr><td><strong> Av                         </strong></td><td> as (metric) flow coefficient (cross sectional area) [m^2],</td></tr>
<tr><td><strong> m_flow                     </strong></td><td> as mass flow rate [kg/s],</td></tr>
<tr><td><strong> valveCharacteristic        </strong></td><td> as coefficient of a valve in dependence of its opening [-],</td></tr>
<tr><td><strong> velocity                   </strong></td><td> as mean velocity [m/s],</td></tr>
<tr><td><strong> zeta_TOT                   </strong></td><td> as pressure loss coefficient [-].</td></tr>
</table>

<p>
The <strong>valveCharacteristic</strong> is determined out of a correlation for the pressure loss coefficient (<strong>zeta_TOT</strong>) in dependence of its opening. The reason for introducing an additional variable
<strong>valveCharacteristic</strong> is a different definition of the following pressure loss correlations of valves.
</p>

<h4>Verification</h4>
<p>
The pressure loss coefficient (<strong>zeta_TOT</strong>) of a valve with different geometries are shown in dependence of the <strong>opening</strong> in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Valve/dp_severalGeometryOverall_z.png\" alt=\"dp_severalGeometryOverall_z\">
</div>

<p>
Note that the pressure loss coefficients (<strong>zeta_TOT</strong>) are numerically optimized for very small openings (opening &le; 5%). At openings smaller than 5% the pressure loss coefficient is smoothly set
to a maximum value (<strong>zeta_TOT_max</strong>) to be adjusted as parameter. Therefore a very small leakage mass flow rate can be adjusted for a given pressure difference at almost closed valves. A very small
leakage mass flow rate can often be neglected in system simulation with valves, whereas the numerical behaviour of the simulation is improved.
</p>
<p>
The mass flow rate of different valves at a constant opening of 50% in dependence of pressure loss is shown in the figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Valve/dp_severalGeometryOverall.png\" alt=\"dp_severalGeometryOverall\"/>
</div>

<h4>References</h4>
<dl>
<dt>Miller,D.S.:</dt>
    <dd><strong>Internal flow systems</strong>.
    Volume 5th of BHRA Fluid Engineering Series. BHRA Fluid Engineering, 1978.</dd>
</dl>
</html>"));
    end dp_severalGeometryOverall;

      annotation (DocumentationClass=true);
    end Valve;

      annotation (DocumentationClass=true);
    end PressureLoss;

      annotation (DocumentationClass=true, Documentation(info="<html>
<p>
This package contains documentation that is used multiple times
in several functions. To avoid duplication of the documentation, links
are used in the respective functions to link to the corresponding shared
documentation available in this package.
</p>

</html>"));
    end SharedDocumentation;

    package Functions "Package for utility functions"
      extends Modelica.Icons.FunctionsPackage;

      package PressureLoss "Package for utility pressure loss functions"
        extends Modelica.Icons.FunctionsPackage;

        package TwoPhase
          "Package with utility functions to compute two phase pressure loss characteristics"
          extends Modelica.Icons.FunctionsPackage;

          function dp_twoPhaseChisholm_DP
            "Frictional pressure loss of straight pipe for two phase flow according to Chisholm correlation | calculate pressure loss | overall flow regime"
            extends Modelica.Icons.Function;
            //SOURCE_1: Chisholm,D.:PRESSURE GRADIENTS DUE TO FRICTION DURING THE FLOW OF EVAPORATING TWO-PHASE MIXTURES IN SMOOTH TUBES AND CHANNELS, Int. J. Heat Mass Transfer, Vol. 16, pp. 347-358, Pergamon Press 1973

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

            annotation (Inline=false);
          end dp_twoPhaseChisholm_DP;

          function dp_twoPhaseFriedel_DP
            "Frictional pressure loss of straight pipe for two phase flow according to Friedel correlation | calculate pressure loss| overall flow regime"
            extends Modelica.Icons.Function;
            //SOURCE_1: Friedel,L.:IMPROVED FRICTION PRESSURE DROP CORRELATIONS FOR HORIZONTAL AND VERTICAL TWO PHASE PIPE FLOW, 3R International, Vol. 18, Issue 7, pp. 485-491, 1979
            //SOURCE_2: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.

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

              annotation (Inline=false);
          end dp_twoPhaseFriedel_DP;

          function dp_twoPhaseGeodetic_DP
            "Geodetic pressure loss of straight pipe for two phase flow | calculate pressure loss"
            extends Modelica.Icons.Function;
            //SOURCE_1: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.

            import PI = Modelica.Constants.pi;

            input
              Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach
              voidFractionApproach=Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous
              "Choice of void fraction approach";

            input Boolean crossSectionalAveraged=true
              "= true, if cross sectional averaged void fraction, otherwise volumetric"
              annotation (Dialog);

            //geometry
            input SI.Length length=1 "Length in fluid flow direction"
              annotation (Dialog(group="Geometry"));
            input SI.Angle phi=0 "Tilt angle to horizontal"
              annotation (Dialog(group="Geometry"));

            //fluid properties
            input SI.Density rho_g(min=Modelica.Constants.eps)
              "Density of gaseous phase" annotation (Dialog(group="Fluid properties"));
            input SI.Density rho_l(min=Modelica.Constants.eps)
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
            DP_geo := (eps*rho_g + (1 - eps)*rho_l)*9.81*length*sin(phi);

              annotation (Inline=false);
          end dp_twoPhaseGeodetic_DP;

          function dp_twoPhaseMomentum_DP
            "Momentum pressure loss of straight pipe for two phase flow | calculate pressure loss"
            extends Modelica.Icons.Function;
            //SOURCE_1: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.
            //SOURCE_2: Thome, J.R., Engineering Data Book 3, Swiss Federal Institute of Technology Lausanne (EPFL), 2009.
            //SOURCE 3: J.M. Jensen and H. Tummescheit. Moving boundary models for dynamic simulations of two-phase flows. In Proceedings of the 2nd International Modelica Conference, pp. 235-244, Oberpfaffenhofen, Germany, 2002. The Modelica Association.

            import PI = Modelica.Constants.pi;
            import MIN = Modelica.Constants.eps;
            import SMOOTH =
              Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower;

            //choices
            input
              Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach
              voidFractionApproach=
                Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous
              "Choice of void fraction approach" annotation (Dialog(group="Choices"));

            //SOURCE_3: p.52, eq. 4.6: heterogeneous effects on momentum pressure loss considered through corrected mass flow rate
            input Boolean massFlowRateCorrection=false
              "Consider heterogeneous mass flow rate correction"
              annotation (Dialog(group="Choices"));

            //geometry
            input SI.Area A_cross(min=Modelica.Constants.eps) = PI*0.1^2/4
              "Cross sectional area" annotation (Dialog(group="Geometry"));
            input SI.Length perimeter(min=Modelica.Constants.eps) = PI*0.1
              "Perimeter"
              annotation (Dialog(group="Geometry"));

            //fluid properties
            input SI.Density rho_g(min=Modelica.Constants.eps) "Density of gas"
              annotation (Dialog(group="Fluid properties"));
            input SI.Density rho_l(min=Modelica.Constants.eps)
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
                xflowEnd) "Mean two phase density at end of length";
            SI.Density rho_sta=
                Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.TwoPhaseDensity(
                voidFractionApproach,
                massFlowRateCorrection,
                rho_g,
                rho_l,
                eps_sta,
                xflowSta) "Mean two phase density at start of length";

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

            //SOURCE 3: p.52, eq. 4.6: Considering of corrected mass flow rate for heterogeneous approach
            SI.MassFlowRate mdotCorEnd=xflowEnd*(1 - xflowEnd)*rho_end*deltaVelEnd*Across
              "Correction mass flow rate at end of length";
            SI.MassFlowRate mdotCorSta=xflowSta*(1 - xflowSta)*rho_sta*deltaVelSta*Across
              "Correction mass flow rate at start of length";

            //SOURCE 3: p.53, eq. 4.13: Calculation of heterogeneous approach with correction of mass flow rate for considering velocity difference between fluid phases
            SI.Pressure dp_mom_cor=SMOOTH(
                delta_xflow,
                0.05,
                0)*abs(mdot_A*meanVelEnd + mdotCorEnd*deltaVelEnd/Across) - abs(mdot_A*
                meanVelSta + mdotCorEnd*deltaVelSta/Across)
              "Momentum pressure loss using mass flow rate correction";

          algorithm
            //SOURCE_1: p.Lba 4, eq. 22: Considering momentum pressure loss assuming heterogeneous approach for two phase flow
            //Momentum pressure loss occurs for a changing mass flow rate quality due to condensation or evaporation
            //At evaporation the liquid phase with a slow velocity has to be accelerated to the higher velocity of the gas
            //The difference in static pressure at the outlet and the inlet causes a positive momentum pressure loss at evaporation (assumed vice versa for condensation)
            DP_mom := if massFlowRateCorrection then dp_mom_cor else mdot_A^2*SMOOTH(
              delta_xflow,
              0.05,
              0)*abs(1/max(MIN, rho_end) - 1/max(MIN, rho_sta));

            annotation (Inline=false, Documentation(revisions="<html>
2012-11-28 Corrected an error in momentum pressure loss calculation. Stefan Wischhusen.
</html>"));
          end dp_twoPhaseMomentum_DP;

          function TwoPhaseMultiplierFriedel
            "Calculation of two phase multiplier according to Friedel | constant mass flow rate quality | horizontal flow | vertical upflow and downflow"
            extends Modelica.Icons.Function;
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
            //Pressure loss for total length (e.g., L=n*dx) can be achieved by discretization
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
            //Correlation based on neglect of surface roughness
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

              annotation (Inline=false);
          end TwoPhaseMultiplierFriedel;

          function TwoPhaseMultiplierChisholm
            "Calculation of two phase multiplier according to Chisholm | constant mass flow rate quality"
            extends Modelica.Icons.Function;
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

             annotation (Inline=false);
          end TwoPhaseMultiplierChisholm;

          function TwoPhaseDensity
            "Calculation of mean density for two phase flow"
            extends Modelica.Icons.Function;
            //SOURCE_1: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.
            input
              Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach
              voidFractionApproach=
                Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous
              "Choice of void fraction approach" annotation (Dialog(group="Choices"));

            //SOURCE_3: p.52, eq. 4.6: heterogeneous effects on momentum pressure loss considered through corrected mass flow rate
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
            rho_2ph := if not massFlowRateCorrection then rho_hom else if
              voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous then
                    rho_hom else if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Momentum then
                    rho_mom else if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Energy then
                    rho_kin else MIN;

            annotation (Inline=false, Documentation(info="<html>
<p>
The gaseous and the liquid part of a fluid in a two phase flow are often discontinuously distributed. This complex behaviour is simplified for engineering calculations. The two phase flow of different fluid flow situations (e.g., bubble or stratified flow) is modelled as if the gaseous and the liquid phase are continuously distributed.
</p>

<p>
A <strong>mean density</strong> assuming a continuous distribution out of a discontinuous two phase fluid flow situation can be calculated with a <strong>homogeneous or a heterogeneous approach</strong> (see <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_DP\">dp_twoPhaseOverall_DP</a>).</p>
<p>
The following <strong>modelling approaches</strong> can be used to calculate the mean density of two phase flow:
</p>
<ul>
<li><strong>homogeneous density</strong> (homogeneous approach)</li>
<li><strong>momentum flux density</strong> (heterogeneous approach)</li>
<li><strong>kinetic energy flow density</strong> (heterogeneous approach)</li>
</ul>

<p>
The heterogeneous approaches are analytically derived by minimising the momentum flux or the kinetic energy flow assuming implicitly that the two-phase flow will tend towards the minimum of this quantity.
</p>

<h4>References</h4>
<dl>
 <dt>VDI:</dt>
    <dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
    Springer Verlag, 10th edition, 2006.</dd>
</dl>
</html>",           revisions="<html>
<ul>
<li><em>2 May 2011</em>
    by Stefan Wischhusen:<br>
       Corrected a logical error in use of input <code>massFlowRateCorrection</code>.</li>
</ul>
</html>"));
          end TwoPhaseDensity;

          function VoidFraction
            "Calculation of (cross sectional) void fraction for two phase flow"
            extends Modelica.Icons.Function;
            //SOURCE_1: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.
            //SOURCE_2: Thome, J.R., Engineering Data Book 3, Swiss Federal Institute of Technology Lausanne (EPFL), 2009.

            input
              Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach
              voidFractionApproach=Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous
              "Choice of void fraction approach" annotation (Dialog(group="Choices"));

            input Boolean crossSectionalAveraged=true
              "= true, if cross sectional averaged void fraction, otherwise volumetric"
              annotation (Dialog);

            input SI.Density rho_g(min=Modelica.Constants.eps)
              "Density of gaseous phase" annotation (Dialog);
            input SI.Density rho_l(min=Modelica.Constants.eps)
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

              annotation (Inline=false);
          end VoidFraction;

          function SlipRatio "Calculation of (analytical/empirical) slip ratio"
            extends Modelica.Icons.Function;
            //SOURCE_1: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.
            //SOURCE_2: Thome, J.R., Engineering Data Book 3, Swiss Federal Institute of Technology Lausanne (EPFL), 2009.
            //SOURCE 3: J.M. Jensen and H. Tummescheit. Moving boundary models for dynamic simulations of two-phase flows. In Proceedings of the 2nd International Modelica Conference, pp. 235-244, Oberpfaffenhofen, Germany, 2002. The Modelica Association.

            input
              Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach
              voidFractionApproach=Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous
              "Choice of void fraction approach" annotation (Dialog(group="Choices"));

            input SI.Density rho_g(min=Modelica.Constants.eps)
              "Density of gaseous phase" annotation (Dialog);
            input SI.Density rho_l(min=Modelica.Constants.eps)
              "Density of liquid phase" annotation (Dialog);
            input Real x_flow=0 "Mass flow rate quality" annotation (Dialog);

            output Real SR "Slip ratio";

          protected
            Real MIN=Modelica.Constants.eps;

            //SOURCE_1: p.Lba 3, sec. 3.2
            Real SR_hom=1 "Slip ratio w.r.t. homogeneous approach";
            //SOURCE_2: p.17-6, eq. 17.3.4
            Real SR_mom=abs(rho_l/max(MIN, rho_g))^0.5
              "Slip ratio w.r.t. momentum flux approach (heterogeneous)";
            //SOURCE_2: p.17-7, eq. 17.3.13
            Real SR_kin=abs(rho_l/max(MIN, rho_g))^(1/3)
              "Slip ratio w.r.t. kinetic energy flow approach from Zivi (heterogeneous)";
            //SOURCE_2: p.17-10, eq. 17.4.3
            Real SR_chi=(1 - x_flow*(1 - abs(rho_l)/max(MIN, abs(rho_g))))^0.5
              "Empirical slip ratio w.r.t. momentum flux approach from Chisholm (heterogeneous)";

          algorithm
            SR := if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous then
                    SR_hom else if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Momentum then
                    SR_mom else if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Energy then
                    SR_kin else if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Chisholm then
                    SR_chi else 1;

            annotation (Inline=false);
          end SlipRatio;
        end TwoPhase;
      end PressureLoss;

      package HeatTransfer "Package for utility heat transfer functions"
        extends Modelica.Icons.FunctionsPackage;

        package TwoPhase
          "Package with utility functions to compute two phase heat transfer characteristics"
          extends Modelica.Icons.FunctionsPackage;

          function kc_twoPhase_condensationHorizontal_KC
            "Local two phase heat transfer coefficient of straight pipe | horizontal condensation"
            extends Modelica.Icons.Function;
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
            SI.ReynoldsNumber Re_l=(IN_var.rho_l*velocity*d_hyd/max(MIN, IN_var.eta_l))
              "Reynolds number assuming (total) mass flux flowing as liquid";
            SI.PrandtlNumber Pr_l=abs(IN_var.eta_l*IN_var.cp_l/max(MIN, IN_var.lambda_l))
              "Prandtl number assuming (total) mass flux flowing as liquid";

            //SOURCE_1: p.548, eq. 8: Considering two phase multiplier for condensation w.r.t. Shah
            SI.CoefficientOfHeatTransfer kc_1ph=0.023*Re_l^0.8*Pr_l^0.4*IN_var.lambda_l
                /d_hyd;

          algorithm
            kc := kc_1ph*((1 - x_flow)^0.8 + 3.8*x_flow^0.76*(1 - x_flow)^0.04/p_red^
              0.38);
            annotation (Inline=false, smoothOrder=5,
              Documentation(revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"));
          end kc_twoPhase_condensationHorizontal_KC;

          function kc_twoPhase_boilingVertical_KC
            "Local two phase heat transfer coefficient of straight pipe | vertical boiling"
            extends Modelica.Icons.Function;
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
            SI.ReynoldsNumber Re_l=(IN_var.rho_l*velocity_l*d_hyd/max(MIN, IN_var.eta_l))
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

            //SOURCE_1: p.675, eq. 9.105: Considering of convection enhancement factor w.r.t. equation of Gungor-Winterton
            Real E_fc=1 + 24000*Bo^1.16 + 1.37*(1/max(MIN, X_tt))^0.86
              "Enhancement factor for forced convection";
            //SOURCE_1: p.675, eq. 9.105: Considering of boiling suppression factor w.r.t. equation of Gungor-Winterton
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
            annotation (Inline = false, smoothOrder=5,
              Documentation(revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"));
          end kc_twoPhase_boilingVertical_KC;

          function kc_twoPhase_boilingHorizontal_KC
            "Local two phase heat transfer coefficient of straight pipe | horizontal boiling"
            extends Modelica.Icons.Function;
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
            SI.ReynoldsNumber Re_l=(IN_var.rho_l*velocity_l*d_hyd/max(MIN, IN_var.eta_l))
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
              "Enhancement factor for forced convection";
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
            annotation (Inline=false, smoothOrder=5,
              Documentation(revisions="<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"));
          end kc_twoPhase_boilingHorizontal_KC;

        end TwoPhase;
      end HeatTransfer;

      package General "Package with utility functions"
        extends Modelica.Icons.FunctionsPackage;

        function CubicInterpolation_Re
          "Cubic Hermite spline interpolation of the Reynolds number in transition regime of the Moody diagram (inverse formulation)"
          extends Modelica.Icons.Function;
          import Modelica.Math;
          input Real Re_turbulent "Unused input";
          input SI.ReynoldsNumber Re1 "Boundary Reynolds number for laminar regime";
          input SI.ReynoldsNumber Re2 "Boundary Reynolds number for turbulent regime";
          input Real Delta "Relative roughness";
          input Real lambda2 "Modified friction coefficient (= independent variable)";
          output SI.ReynoldsNumber Re "Interpolated Reynolds number in transition region";
        protected
          // Point x1=lg(lambda2(Re1)) with derivative yd1=1 at y1=lg(Re1)
          Real x1=Math.log10(64*Re1) "Lower abscissa value";
          Real y1=Math.log10(Re1) "Lower ordinate value";
          Real yd1=1 "Left boundary slope";

          // Point x2=lg(lambda2(Re2)) with derivative yd2 at y2≈lg(Re2)
          Real aux1=(0.5/Math.log(10))*5.74*0.9;
          Real aux2=Delta/3.7 + 5.74/Re2^0.9;
          Real aux3=Math.log10(aux2);
          Real L2=0.25*(Re2/aux3)^2;
          Real aux4=2.51/sqrt(L2) + 0.27*Delta;
          Real aux5=-2*sqrt(L2)*Math.log10(aux4);
          Real x2=Math.log10(L2) "Upper abscissa value";
          Real y2=Math.log10(aux5) "Upper ordinate value";
          Real yd2=0.5 + (2.51/Math.log(10))/(aux5*aux4) "Right boundary slope";

          // Constants: Cubic polynomial between x1=lg(lambda2(Re1)) and x2=lg(lambda2(Re2))
          Real diff_x=x2 - x1 "Interval length";
          Real m=(y2 - y1)/diff_x;
          Real c2=(3*m - 2*yd1 - yd2)/diff_x;
          Real c3=(yd1 + yd2 - 2*m)/(diff_x*diff_x);
          Real lambda2_1=64*Re1;
          Real dx=Math.log10(lambda2/lambda2_1);

        algorithm
          // Prefer optimized interpolation formula for Re to avoid cubicHermite function call
          // Re := 10^Modelica.Fluid.Utilities.cubicHermite(Math.log10(lambda2), x1, x2, y1, y2, yd1, yd2);
          Re := Re1*(lambda2/lambda2_1)^(yd1 + dx*(c2 + dx*c3));
          annotation (Inline=false, smoothOrder=5,
            Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Re = <strong>CubicInterpolation_Re</strong>(0, Re1, Re2, Delta, lambda2);
</pre></blockquote>
<h4>Description</h4>
<p>
Function <strong>CubicInterpolation_Re</strong>(..) approximates the Reynolds number
<code>Re</code> in the transition regime between laminar and turbulent flow
of the Moody diagram by an inverse formulation of a cubic Hermite spline interpolation. See <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">
Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction</a> (especially <strong>Region 2</strong>)
for a detailed explanation.
</p>
</html>", revisions="<html>
2018-11-20 Stefan Wischhusen: Renamed function from CubicInterpolation_DP to CubicInterpolation_Re.
</html>"));
        end CubicInterpolation_Re;

        function CubicInterpolation_lambda
          "Cubic Hermite spline interpolation of the modified friction coefficient in transition regime of the Moody diagram (direct formulation)"
          extends Modelica.Icons.Function;
          import Modelica.Math;
          input SI.ReynoldsNumber Re "Reynolds number (= independent variable)";
          input SI.ReynoldsNumber Re1 "Boundary Reynolds number for laminar regime";
          input SI.ReynoldsNumber Re2 "Boundary Reynolds number for turbulent regime";
          input Real Delta "Relative roughness";
          output Real lambda2 "Interpolated modified friction coefficient in transition regime";
        protected
          // Point x1=lg(Re1) with derivative yd1=1 at y1=lg(lambda2(Re1))
          Real x1=Math.log10(Re1) "Lower abscissa value";
          Real y1=Math.log10(64*Re1) "Lower ordinate value";
          Real yd1=1 "Left boundary slope";

          // Point x2=lg(Re2) with derivative yd2 at y2=lg(lambda2(Re2))
          Real aux1=(0.5/Math.log(10))*5.74*0.9;
          Real aux2=Delta/3.7 + 5.74/Re2^0.9;
          Real aux3=Math.log10(aux2);
          Real L2=0.25*(Re2/aux3)^2;
          Real aux4=2.51/sqrt(L2) + 0.27*Delta;
          Real aux5=-2*sqrt(L2)*Math.log10(aux4);
          Real x2=Math.log10(Re2) "Upper abscissa value";
          Real y2=Math.log10(L2) "Upper ordinate value";
          Real yd2=2 + 4*aux1/(aux2*aux3*(Re2)^0.9) "Right boundary slope";

          // Constants: Cubic polynomial between x1=lg(Re1) and x2=lg(Re2)
          Real diff_x=x2 - x1 "Interval length";
          Real m=(y2 - y1)/diff_x;
          Real c2=(3*m - 2*yd1 - yd2)/diff_x;
          Real c3=(yd1 + yd2 - 2*m)/(diff_x*diff_x);
          Real dx=Math.log10(Re/Re1);

        algorithm
          // Prefer optimized interpolation formula for lambda2 to avoid cubicHermite function call
          // lambda2 := 10^Modelica.Fluid.Utilities.cubicHermite(Math.log10(Re), x1, x2, y1, y2, yd1, yd2);
          lambda2 := 64*Re1*(Re/Re1)^(yd1 + dx*(c2 + dx*c3));
          annotation (Inline=false, smoothOrder=5,
            Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
lambda2 = <strong>CubicInterpolation_lambda</strong>(Re, Re1, Re2, Delta);
</pre></blockquote>
<h4>Description</h4>
<p>
Function <strong>CubicInterpolation_lambda</strong>(..) approximates the modified friction coefficient
<code>lambda2</code>=<code>lambda*Re^2</code> in the transition regime between laminar and turbulent flow
of the Moody diagram by a (direct) cubic Hermite spline interpolation.
See <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">
Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction</a> (especially <strong>Region 2</strong>)
for a detailed explanation.
</p>
</html>", revisions="<html>
2018-11-20 Stefan Wischhusen: Renamed function from CubicInterpolation_MFLOW to CubicInterpolation_lambda.
</html>"));
        end CubicInterpolation_lambda;

        function LambertW
          "Closed approximation of Lambert's w function for solving f(x) = x exp(x) for x"
          extends Modelica.Icons.Function;
          input Real y "Input f(x)";
          output Real x "Output W(y)";
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

          annotation (Inline=false, smoothOrder=5,
                      Documentation(info="<html>

<p>
This function calculates an approximation of the <strong>inverse</strong> for
</p>
<blockquote><pre>
f(x) = y = x * exp( x )
</pre></blockquote>

<p>
within &infin; > y > -1/e.  The relative deviation of this approximation for Lambert's w function <strong>x = W(y)</strong> is displayed in the following graph.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/Functions/General/LambertW_deviation.png\" alt=\"LambertW_deviation\"/>
</div>

<p>
For y > 10 and higher values the relative deviation is smaller 2%.
</p>

</html>"));
        end LambertW;

        function LambertWIter
          "Iterative form of Lambert's w function for solving f(x) = x exp(x) for x"
          extends Modelica.Icons.Function;
          input Real y "Input f(x)";
          output Real x "Output W(y)";
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

          annotation (Inline=false, smoothOrder=5,
                      Documentation(info="<html>

<p>
This function calculates an approximation of the <strong>inverse</strong> for
</p>
<blockquote><pre>
f(x) = y = x * exp( x )
</pre></blockquote>

<p>
within &infin; > y > -1/e. Please note, that for negative inputs <strong>two</strong> solutions exists. The function currently delivers the result x = -1 ... 0 for that particular range.
</p>

</html>"));
        end LambertWIter;

        function PrandtlNumber "Calculation of Prandtl number"
          extends Modelica.Icons.Function;
          import MIN = Modelica.Constants.eps;

          //fluid properties
          input SI.SpecificHeatCapacityAtConstantPressure cp
            "Specific heat capacity of fluid at constant pressure";
          input SI.DynamicViscosity eta "Dynamic viscosity of fluid";
          input SI.ThermalConductivity lambda "Thermal conductivity of fluid";

          output SI.PrandtlNumber Pr "Prandtl number";

        algorithm
          Pr := eta*cp/max(MIN, lambda);
          annotation (Inline=true, smoothOrder=1);
        end PrandtlNumber;

        function ReynoldsNumber "Calculation of Reynolds number"
          extends Modelica.Icons.Function;
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
          annotation (Inline=true, smoothOrder=1);
        end ReynoldsNumber;

        function SmoothPower
          "Limiting the derivative of function y = if x>=0 then x^pow else -(-x)^pow"
          extends Modelica.Icons.Function;
          input Real x "Input variable";
          input Real deltax "Range for interpolation";
          input Real pow "Exponent for x";
          output Real y "Output variable";
        protected
          Real adeltax=abs(deltax);
          Real C3=(pow - 1)/2*adeltax^(pow - 3);
          Real C1=(3 - pow)/2*adeltax^(pow - 1);

        algorithm
          y := if x >= adeltax then x^pow else if x <= -adeltax then -(-x)^pow else (C1
             + C3*x*x)*x;
          annotation (derivative(zeroDerivative=deltax, zeroDerivative=pow)=SmoothPower_der,
            Inline=false,
            smoothOrder=1,
            Documentation(info="<html>
<p>
The function is used to limit the derivative of the following function at x=0:
</p>
<blockquote><pre>
y = <strong>if</strong> x &ge; 0 <strong>then</strong> x<sup><strong>pow</strong></sup> <strong>else</strong> -(-x)<sup><strong>pow</strong></sup>;  // pow &gt; 0
</pre></blockquote>

<p>
by approximating the function in the range -<strong>deltax</strong>&lt; x &lt; <strong>deltax</strong>
with a third order polynomial that has the same derivative at <strong>abs</strong>(x)=deltax, as the
function above.
</p>

<h4>Example </h4>
<p>
In the picture below the input x is increased from -1 to 1. The range of interpolation is defined by the same range. Displayed is the output of the function SmoothPower compared to
</p>
<blockquote><pre>
y=x*|x|
</pre></blockquote>
<p>
For |x| &gt; 1 both functions return identical results.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/Functions/General/SmoothPower.png\" alt=\"SmoothPower\"/>
</div>

<h4>References</h4>
<dl>
<dt>ThermoFluid Library</dt>
    <dd><strong><a href=\"http://sourceforge.net/projects/thermofluid/\">http://sourceforge.net/projects/thermofluid/</a></strong></dd>
</dl>
</html>", revisions="<html>
2014-04-29 Stefan Wischhusen: Introduced deltax and pow as zero derivatives.
</html>"));
        end SmoothPower;

        function SmoothPower_der "The derivative of function SmoothPower"
          extends Modelica.Icons.Function;
          input Real x "Input variable";
          input Real deltax "Range of interpolation";
          input Real pow "Exponent for x";
          input Real dx "Derivative of x";
          output Real dy "Derivative of SmoothPower";
        protected
          Real C3;
          Real C1;
          Real adeltax;

        algorithm
          adeltax := abs(deltax);
          if x >= adeltax then
            dy := dx*pow*x^(pow - 1);
          elseif x <= -adeltax then
            dy := dx*pow*(-x)^(pow - 1);
          else
            C3 := (pow - 1)/2*adeltax^(pow - 3);
            C1 := (3 - pow)/2*adeltax^(pow - 1);
            dy := (C1 + 3*C3*x*x)*dx;
          end if;
         annotation (Documentation(revisions="<html>
 2014-04-29 Stefan Wischhusen: Corrected branch for x<=-adeltax, removed dpow and ddeltax.
 2015-10-13 Stefan Wischhusen: Removed noEvent() from if clause.
</html>"));
        end SmoothPower_der;

        function Stepsmoother "Continuous interpolation for x"

          extends Modelica.Icons.Function;
          input Real func "Input value for that result = 100%";
          input Real nofunc "Input value for that result = 0%";
          input Real x "Input variable for continuous interpolation";
          output Real result "Output value";

        protected
          Real m=Modelica.Constants.pi/(func - nofunc);
          Real b=-Modelica.Constants.pi/2 - m*nofunc;

        algorithm
          result := if x >= func and func > nofunc or x
             <= func and nofunc > func then 1 else if x
             <= nofunc and func > nofunc or x >= nofunc and nofunc > func then 0 else (1+Modelica.Math.tanh(Modelica.Math.tan(m*x + b)))/2;
          annotation (
            Inline=false,
            derivative=Stepsmoother_der,
            Documentation(info="<html>
<p>
The function is used for continuous fading of variable inputs within a defined range. It allows a differentiable and smooth transition between function outputs, e.g., laminar and turbulent pressure drop or correlations for certain ranges.
</p>
<h4>Function</h4>
<p>
The tanh-function is used, since it provides an existing derivative and the derivative is zero at the borders [<strong>nofunc</strong>, <strong>func</strong>] of the interpolation domain (smooth derivative for transitions).<br>
<br>
In order to work correctly, the internal interpolation range in terms of the external arbitrary input <strong>x</strong> needs to be scaled such that:
</p>
<blockquote><pre>
f(func)   = 0.5 &pi;
f(nofunc) = -0.5 &pi;
</pre></blockquote>

<h4>Example </h4>
<p>
In the picture below the input x is increased from 0 to 1. The range of interpolation is defined by:
</p>
<ul>
<li>func = 0.75</li>
<li>nofunc = 0.25</li>
</ul>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/Functions/General/Stepsmoother.png\" alt=\"Stepsmoother\"/>
</div>

<h4>References</h4>
<dl>
<dt>Wischhusen, St.</dt>
    <dd><strong>Simulation von K&auml;ltemaschinen-Prozessen mit MODELICA / DYMOLA</strong>.
    Diploma thesis, Hamburg University of Technology, Institute of Thermofluiddynamics, 2000.</dd>
</dl></html>"), smoothOrder=5);
        end Stepsmoother;

        function Stepsmoother_der "Derivative of function Stepsmoother"

          extends Modelica.Icons.Function;
          input Real func "Input for that result = 100%";
          input Real nofunc "Input for that result = 0%";
          input Real x "Input for interpolation";
          input Real dfunc "Derivative of func";
          input Real dnofunc "Derivative of nofunc";
          input Real dx "Derivative of x";
          output Real dresult;

        protected
          Real m=Modelica.Constants.pi/(func - nofunc);
          Real b=-Modelica.Constants.pi/2 - m*nofunc;

        algorithm
        dresult := if x >= func and func > nofunc or x <= func and nofunc > func or x <= nofunc and func > nofunc or x >= nofunc
             and nofunc > func then 0 else (1 - Modelica.Math.tanh(Modelica.Math.tan(m*x + b))^2)*
             (1 + Modelica.Math.tan(m*x + b)^2)*(-m^2/Modelica.Constants.pi*(dfunc - dnofunc)*x
              + m*dx + m^2/Modelica.Constants.pi*(dfunc - dnofunc)*nofunc - m*dnofunc)/2;
        end Stepsmoother_der;
      end General;
    end Functions;

    package Icons "Icons for Fluid.Dissipation and Fluid.Fittings libraries"
      extends Modelica.Icons.IconsPackage;

      package HeatTransfer "Icons for heat transfer calculation"
      extends Modelica.Icons.IconsPackage;

        partial model Gap1_d "Geometry figure for gap"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                graphics={
                Rectangle(
                  extent={{-100,-40},{60,-60}},
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  lineThickness=1),
                Polygon(
                  points={{60,-40},{60,-60},{100,-20},{100,0},{60,-40}},
                  lineThickness=1,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Rectangle(
                  extent={{-100,40},{60,20}},
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  lineThickness=1),
                Polygon(
                  points={{60,40},{60,20},{100,60},{100,80},{60,40}},
                  lineThickness=1,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Polygon(
                  points={{100,60},{100,0},{60,0},{60,20},{100,60}},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Polygon(
                  points={{-100,-40},{-100,20},{60,20},{60,0},{-60,0},{-100,-40}},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Polygon(
                  points={{-100,40},{-60,80},{100,80},{60,40},{-100,40}},
                  lineThickness=1,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Line(
                  points={{-100,20},{60,20},{100,60}},
                  thickness=1),
                Line(
                  points={{-100,-40},{60,-40},{100,0}},
                  thickness=1),
                Line(
                  points={{20,80},{-20,40}},
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
                  textString="h"),
                Line(
                  points={{60,-66},{-100,-66}},
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
                  textString="L"),
                Polygon(
                  points={{-100,-40},{-60,0},{100,0},{60,-40},{-100,-40}},
                  lineThickness=1,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Line(
                  points={{-80,20},{-80,-40}},
                  arrow={Arrow.Filled,Arrow.Filled},
                  thickness=0.5),
                Rectangle(
                  extent={{-84,-4},{-76,-14}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-90,-2},{-70,-14}},
                  textString="s"),
                Line(
                  points={{26,-10},{-24,-10}},
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
                  textString="v"),
                Ellipse(
                  extent={{78,52},{82,48}},
                  pattern=LinePattern.None,
                  lineThickness=0.5,
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{78,-28},{82,-32}},
                  pattern=LinePattern.None,
                  lineThickness=0.5,
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{80,-28},{80,48}},
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
                  textString="T_wall"),
                Text(
                  extent={{-30,36},{-10,24}},
                  textString="wall 1"),
                Text(
                  extent={{-30,-44},{-10,-56}},
                  textString="wall 2")}));

        end Gap1_d;

        partial model HelicalPipe1_d "Geometry figure for helical pipe"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                graphics={
                Line(
                  points={{-60,82},{-60,-84}},
                  thickness=0.5,
                  pattern=LinePattern.Dash),
                Line(
                  points={{-62,-26},{60,-36}},
                  thickness=1),
                Line(
                  points={{-62,24},{60,14}},
                  thickness=1),
                Line(
                  points={{-60,-16},{62,-26}},
                  thickness=1),
                Line(
                  points={{-60,34},{62,24}},
                  thickness=1),
                Ellipse(
                  extent={{38,64},{78,24}},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{38,14},{78,-26}},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{-78,24},{-38,-16}},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{-78,-26},{-38,-66}},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Polygon(
                  points={{-60,-26},{60,-36},{60,-76},{-60,-66},{-60,-26}},
                  lineThickness=0.5,
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  pattern=LinePattern.None),
                Line(
                  points={{-60,-46},{60,-56}},
                  thickness=0.5,
                  pattern=LinePattern.Dash),
                Polygon(
                  points={{-60,24},{60,14},{60,-26},{-60,-16},{-60,24}},
                  lineThickness=0.5,
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  pattern=LinePattern.None),
                Line(
                  points={{-60,4},{60,-6}},
                  thickness=0.5,
                  pattern=LinePattern.Dash),
                Ellipse(
                  extent={{40,-36},{80,-76}},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Polygon(
                  points={{-62,74},{58,64},{58,24},{-62,34},{-62,74}},
                  lineThickness=0.5,
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  pattern=LinePattern.None),
                Line(
                  points={{-60,54},{60,44}},
                  thickness=0.5,
                  pattern=LinePattern.Dash),
                Ellipse(
                  extent={{-80,74},{-40,34}},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Polygon(
                  points={{-60,24},{60,64},{60,24},{-60,-16},{-60,24}},
                  lineThickness=0.5,
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  pattern=LinePattern.None),
                Line(
                  points={{8,28},{-8,22}},
                  arrow={Arrow.None,Arrow.Filled},
                  thickness=1),
                Line(
                  points={{12,-24},{-4,-30}},
                  arrow={Arrow.None,Arrow.Filled},
                  thickness=1),
                Polygon(
                  points={{-60,-26},{60,14},{60,-26},{-60,-66},{-60,-26}},
                  lineThickness=0.5,
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  pattern=LinePattern.None),
                Line(
                  points={{60,24},{-60,-16}},
                  thickness=0.5),
                Line(
                  points={{60,14},{-60,-26}},
                  thickness=0.5),
                Line(
                  points={{60,-26},{-60,-66}},
                  thickness=0.5),
                Line(
                  points={{-60,74},{60,64}},
                  thickness=0.5),
                Line(
                  points={{-60,24},{60,64}},
                  thickness=0.5),
                Line(
                  points={{-60,-66},{60,-76}},
                  thickness=0.5),
                Line(
                  points={{10,-22},{-6,-28}},
                  arrow={Arrow.None,Arrow.Filled},
                  thickness=1),
                Ellipse(
                  extent={{46,-42},{74,-70}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-74,68},{-46,40}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-74,78},{-46,78}},
                  arrow={Arrow.Filled,Arrow.Filled}),
                Line(
                  points={{2,3},{-14,3}},
                  arrow={Arrow.None,Arrow.Filled},
                  thickness=1,
                  origin={-38,55},
                  rotation=180),
                Line(
                  points={{0,82},{0,-86}},
                  thickness=0.5,
                  pattern=LinePattern.DashDot),
                Line(
                  points={{60,-32},{60,-82}},
                  thickness=0.5,
                  pattern=LinePattern.DashDot),
                Line(
                  points={{-60,-82},{60,-82}},
                  arrow={Arrow.Filled,Arrow.Filled}),
                Rectangle(
                  extent={{-18,-76},{18,-88}},
                  fillPattern=FillPattern.Solid,
                  fillColor={255,255,255},
                  lineThickness=0.5,
                  pattern=LinePattern.None),
                Text(
                  extent={{-14,-76},{12,-86}},
                  textString="d_mean"),
                Line(
                  points={{46,-56},{88,-56}},
                  thickness=0.5,
                  pattern=LinePattern.DashDot),
                Line(
                  points={{60,18},{60,-30}},
                  thickness=0.5,
                  pattern=LinePattern.DashDot),
                Line(
                  points={{46,-6},{88,-6}},
                  thickness=0.5,
                  pattern=LinePattern.DashDot),
                Line(
                  points={{84,-6},{84,-56}},
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
                  pattern=LinePattern.DashDot),
                Line(
                  points={{-46,82},{-46,52}},
                  thickness=0.5,
                  pattern=LinePattern.DashDot),
                Text(
                  extent={{72,-26},{98,-36}},
                  textString="h"),
                Rectangle(
                  extent={{-68,84},{-50,76}},
                  fillPattern=FillPattern.Solid,
                  fillColor={255,255,255},
                  lineThickness=0.5,
                  pattern=LinePattern.None),
                Text(
                  extent={{-72,86},{-50,78}},
                  textString="d_hyd"),
                Rectangle(
                  extent={{-36,56},{-30,48}},
                  fillPattern=FillPattern.Solid,
                  fillColor={255,255,255},
                  lineThickness=0.5,
                  pattern=LinePattern.None),
                Line(
                  points={{-40,54},{-40,50}},
                  thickness=1),
                Text(
                  extent={{-44,56},{-22,48}},
                  textString="L")}));
        end HelicalPipe1_d;

        partial model Plate1_d "Geometry figure 1 for plate"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                graphics={
                Rectangle(
                  extent={{-100,10},{100,-10}},
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170}),
                Line(
                  points={{-100,-20},{100,-20}},
                  arrow={Arrow.Filled,Arrow.Filled}),
                Text(
                  extent={{-14,-20},{12,-30}},
                  textString="L"),
                Line(
                  points={{-20,16},{20,16}},
                  arrow={Arrow.None,Arrow.Filled}),
                Text(
                  extent={{-14,26},{12,16}},
                  textString="velocity")}));
        end Plate1_d;

        partial model Plate2_d "Geometry figure 2 for plate"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Rectangle(
                  extent={{-100,-20},{60,-40}},
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170},
                  lineThickness=0.5),Polygon(
                  points={{-100,-20},{-60,20},{100,20},{60,-20},{-100,-20}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward,
                  lineThickness=0.5),Polygon(
                  points={{60,-20},{60,-40},{100,0},{100,20},{60,-20}},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),Line(
                  points={{-20,0},{20,0}},
                  thickness=1,
                  arrow={Arrow.None,Arrow.Filled}),Text(
                  extent={{-14,10},{12,0}},
                  textString="v"),Line(
                  points={{-100,-48},{60,-48}},
                  arrow={Arrow.Filled,Arrow.Filled}),Rectangle(
                  extent={{-26,-44},{-18,-54}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineThickness=1,
                  pattern=LinePattern.None),Text(
                  extent={{-34,-44},{-8,-54}},
                  textString="L")}));
        end Plate2_d;

        partial model Channel_i "Icon for heat transfer in a channel"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/heatTransfer/channel/icon_channel.png")}));
        end Channel_i;

        partial model General_i "Icon for general heat transfer component"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/heatTransfer/general/icon_general.png")}));
        end General_i;

        partial model HeatExchanger_i
          "Icon for heat transfer of a heat exchanger"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/heatTransfer/heatExchanger/icon_heatExchanger.png")}));
        end HeatExchanger_i;

        partial model HelicalPipe_i "Icon for heat transfer in a helical pipe"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/heatTransfer/helicalPipe/icon_helicalPipe.png")}));
        end HelicalPipe_i;

        partial model Plate_i "Icon for heat transfer of a plate"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}},
                    fileName="modelica://Modelica/Resources/Images/Fluid/Dissipation/heatTransfer/plate/icon_plate.png")}));
        end Plate_i;

        partial model StraightPipe_i
          "Icon for heat transfer of a straight pipe"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/heatTransfer/straightPipe/icon_straightPipe.png")}));

        end StraightPipe_i;
      end HeatTransfer;

      package PressureLoss "Icons for pressure loss calculation"
        extends Modelica.Icons.IconsPackage;

        partial model BendEdged_d "Geometry figure of edged bend"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                graphics={
                Rectangle(
                  extent={{-100,10},{0,-20}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Polygon(
                  points={{0,10},{100,-48},{100,-80},{0,-20},{0,10}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Ellipse(
                  extent={{-6,16},{8,2}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{0,40},{100,-20},{100,-48},{0,10},{0,40}},
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
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Polygon(
                  points={{0,-40},{0,-20},{100,-80},{100,-100},{0,-40}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Polygon(
                  points={{0,40},{0,60},{100,0},{100,-20},{0,40}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Polygon(
                  points={{-100,40},{-100,60},{0,60},{0,40},{-100,40}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Line(
                  points={{0,10},{100,-48}},
                  arrow={Arrow.None,Arrow.Filled},
                  thickness=0.5),
                Line(
                  points={{-100,10},{0,10}},
                  thickness=0.5,
                  arrow={Arrow.Filled,Arrow.None}),
                Line(
                  points={{-78,40},{-78,-20}},
                  thickness=0.5,
                  arrow={Arrow.Filled,Arrow.Filled}),
                Rectangle(
                  extent={{-90,32},{-62,18}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-90,30},{-64,20}},
                  textString="d_hyd"),
                Text(
                  extent={{-10,20},{16,10}},
                  textString="delta"),
                Rectangle(
                  extent={{-54,18},{-44,2}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-58,14},{-40,4}},
                  textString="L"),
                Ellipse(
                  extent={{-2,6},{0,4}},
                  lineThickness=0.5,
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-2,4},{2,10}},
                  thickness=0.5)}));

        end BendEdged_d;

        partial model Channel_d "Geometry figure for channel"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                graphics={
                Line(
                  points={{-92,80},{-60,80}},
                  thickness=0.5,
                  pattern=LinePattern.Dot),
                Ellipse(
                  extent={{20,80},{-20,40}},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{80,74},{40,46}},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{14,74},{-14,46}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{0,74},{0,46}},
                  thickness=0.5,
                  arrow={Arrow.Filled,Arrow.Filled}),
                Rectangle(
                  extent={{-10,66},{10,56}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-9,66},{9,56}},
                  textString="d_cir"),
                Ellipse(
                  extent={{-40,80},{-80,40}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),
                Ellipse(
                  extent={{-46,74},{-74,46}},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Line(
                  points={{0,14},{0,-14}},
                  thickness=0.5,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={-60,36},
                  rotation=90),
                Line(
                  points={{-92,40},{-60,40}},
                  thickness=0.5,
                  pattern=LinePattern.Dot),
                Line(
                  points={{-90,80},{-90,40}},
                  thickness=0.5,
                  arrow={Arrow.Filled,Arrow.Filled}),
                Rectangle(
                  extent={{-98,64},{-82,54}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-99,65},{-81,55}},
                  textString="D_ann"),
                Line(
                  points={{-16,0},{16,0}},
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={-74,46},
                  rotation=270),
                Line(
                  points={{-16,0},{16,0}},
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
                  textString="d_ann"),
                Ellipse(
                  extent={{78,72},{42,48}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-22,0},{22,0}},
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={60,60},
                  rotation=90),
                Line(
                  points={{0,4},{0,-14}},
                  thickness=0.5,
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
                  textString="a_ell"),
                Line(
                  points={{0,0},{22,0}},
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={42,38},
                  rotation=90),
                Line(
                  points={{60,72},{92,72}},
                  thickness=0.5,
                  pattern=LinePattern.Dot),
                Line(
                  points={{38,60},{92,60}},
                  thickness=0.5,
                  pattern=LinePattern.Dot),
                Line(
                  points={{0,4},{0,-8}},
                  thickness=0.5,
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
                  textString="b_ell"),
                Rectangle(
                  extent={{-60,24},{-20,-6}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward,
                  lineThickness=0.5),
                Rectangle(
                  extent={{-56,20},{-24,-2}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),
                Line(
                  points={{-16,0},{16,0}},
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={-56,-2},
                  rotation=270),
                Line(
                  points={{-16,0},{16,0}},
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={-24,-2},
                  rotation=270),
                Line(
                  points={{0,14},{0,-18}},
                  thickness=0.5,
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
                  textString="a_rec"),
                Line(
                  points={{-16,0},{16,0}},
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={-31,20},
                  rotation=360),
                Line(
                  points={{-16,0},{16,0}},
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={-31,-2},
                  rotation=360),
                Line(
                  points={{0,12},{0,-10}},
                  thickness=0.5,
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
                  textString="b_rec"),
                Polygon(
                  points={{20,-10},{40,30},{60,-10},{20,-10}},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Polygon(
                  points={{26,-6},{40,22},{54,-6},{26,-6}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-16,0},{-4,0}},
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={26,-22},
                  rotation=270),
                Line(
                  points={{0,20},{0,-8}},
                  thickness=0.5,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={46,-16},
                  rotation=90),
                Line(
                  points={{-16,0},{-4,0}},
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={54,-22},
                  rotation=270),
                Line(
                  points={{-16,0},{12,0}},
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={56,22},
                  rotation=360),
                Line(
                  points={{-16,0},{12,0}},
                  thickness=0.5,
                  pattern=LinePattern.Dot,
                  origin={56,-6},
                  rotation=360),
                Line(
                  points={{0,20},{0,-8}},
                  thickness=0.5,
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
                  textString="h_tri"),
                Rectangle(
                  extent={{31,-11},{50,-23}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{32,-11},{49,-20}},
                  textString="a_tri"),
                Line(
                  points={{36,14},{38,12},{42,12},{44,14}},
                  thickness=0.5),
                Line(
                  points={{-12,-2},{0,-8}},
                  thickness=0.5,
                  arrow={Arrow.Filled,Arrow.None},
                  origin={40,24},
                  rotation=360),
                Text(
                  extent={{12,27},{29,18}},
                  textString="beta")}));

        end Channel_d;

        partial model OrificeSuddenChangeSection_d
          "Geometry figure for orifice with sudden change of cross sectional area"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                graphics={
                Rectangle(
                  extent={{-100,60},{100,-60}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Backward),
                Rectangle(
                  extent={{-100,20},{0,-20}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{0,40},{100,-42}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-80,88},{86,76}},
                  textString="sudden expansion"),
                Text(
                  extent={{-82,-76},{86,-88}},
                  textString="sudden contraction"),
                Line(
                  points={{-20,0},{20,0}},
                  thickness=0.5,
                  arrow={Arrow.None,Arrow.Filled},
                  origin={0,-72},
                  rotation=180),
                Line(
                  points={{-20,0},{20,0}},
                  thickness=0.5,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={-48,0},
                  rotation=90),
                Line(
                  points={{-62,0},{20,0}},
                  thickness=0.5,
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
                  textString="A_2"),
                Rectangle(
                  extent={{-58,6},{-38,-8}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-62,4},{-36,-6}},
                  textString="A_1"),
                Rectangle(
                  extent={{0,20},{0,-20}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-44,10},{40,2}},
                  textString="design flow direction"),
                Line(
                  points={{-24,-4},{16,-4}},
                  thickness=0.5,
                  arrow={Arrow.None,Arrow.Filled}),
                Line(
                  points={{-20,70},{20,70}},
                  thickness=0.5,
                  arrow={Arrow.None,Arrow.Filled})}));

        end OrificeSuddenChangeSection_d;

        partial model OrificeThickEdged_d
          "Geometry figure for orifice with thick edged vena contraction"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                graphics={
                Rectangle(
                  extent={{-100,60},{100,-60}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Backward),
                Rectangle(
                  extent={{-40,20},{40,-20}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{40,40},{100,-42}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-20,0},{20,0}},
                  thickness=0.5,
                  arrow={Arrow.Filled,Arrow.Filled},
                  origin={-48,0},
                  rotation=90),
                Line(
                  points={{-62,0},{20,0}},
                  thickness=0.5,
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
                  textString="A_1"),
                Rectangle(
                  extent={{0,20},{0,-20}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Line(
                  points={{-40,-32},{40,-32}},
                  thickness=0.5,
                  arrow={Arrow.Filled,Arrow.Filled}),
                Rectangle(
                  extent={{-100,40},{-40,-42}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-62,0},{20,0}},
                  thickness=0.5,
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
                  textString="A_1"),
                Line(
                  points={{-42,0},{-2,0}},
                  thickness=0.5,
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
                  textString="L")}));
        end OrificeThickEdged_d;

        partial model StraightPipe_d "Geometry figure for straight pipe"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                graphics={
                Ellipse(
                  extent={{98,46},{62,-54}},
                  lineThickness=0.5,
                  fillPattern=FillPattern.Forward,
                  fillColor={255,255,170}),
                Polygon(
                  points={{-80,-54},{-80,46},{80,46},{80,-54},{-80,-54}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward,
                  lineThickness=0.5,
                  pattern=LinePattern.None),
                Line(
                  points={{-80,52},{80,52}},
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
                  textString="L"),
                Ellipse(
                  extent={{90,26},{70,-34}},
                  pattern=LinePattern.Dash,
                  lineThickness=0.5),
                Line(
                  points={{0,26},{0,-34}},
                  thickness=0.5,
                  arrow={Arrow.Filled,Arrow.Filled}),
                Rectangle(
                  extent={{-6,-74},{10,-86}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Ellipse(
                  extent={{-62,46},{-98,-54}},
                  lineThickness=0.5,
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{-70,26},{-90,-34}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),
                Line(
                  points={{-80,46},{80,46}},
                  thickness=0.5),
                Line(
                  points={{-80,-54},{80,-54}},
                  thickness=0.5),
                Line(
                  points={{-80,26},{80,26}},
                  pattern=LinePattern.Dash,
                  thickness=0.5),
                Line(
                  points={{-80,-34},{80,-34}},
                  thickness=0.5,
                  pattern=LinePattern.Dash),
                Line(
                  points={{-62,-4},{98,-4}},
                  thickness=0.5),
                Rectangle(
                  extent={{-12,2},{10,-8}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-14,2},{12,-8}},
                  textString="d_hyd")}));

        end StraightPipe_d;

        partial model Valve_d "Icon for valve"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                graphics={
                Rectangle(
                  extent={{-6,-74},{10,-86}},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Line(points={{-60,0},{-100,0}}, color={0,127,255}),
                Polygon(
                  points={{-60,50},{-60,-50},{60,-50},{60,50},{-60,50}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Line(points={{60,0},{100,0}}, color={0,127,255}),
                Line(
                  points={{-60,50},{-60,-50},{60,50},{60,-50},{-60,50}},
                  thickness=0.5)}));

        end Valve_d;

        model FlowModel "Icon for flow model in Modelica.Fluid applications"

          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics={
                Polygon(
                  points={{-60,50},{-60,-50},{60,-50},{60,50},{-60,50}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Line(points={{-60,0},{-100,0}}, color={0,127,255}),
                Line(
                  points={{-60,50},{-60,-50},{60,50},{60,-50},{-60,50}},
                  thickness=0.5),
                Line(points={{60,0},{100,0}}, color={0,127,255})}));
        end FlowModel;

        partial model Bend_i "Icon for bend"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}},
                    fileName="modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/bend/icon_bend.png")}));
        end Bend_i;

        partial model Channel_i "Icon for channel"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/channel/icon_channel.png")}));
        end Channel_i;

        partial model General_i "Icon for general pressure drop"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/general/icon_general.png")}));
        end General_i;

        partial model HeatExchanger_i

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={Bitmap(extent={{-100,-100},{100,100}},
                  fileName=
                  "modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/heatExchanger/icon_heatExchanger.png")}));
        end HeatExchanger_i;

        partial model Orifice_i "Icon for orifice"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/orifice/icon_orifice.png")}));
        end Orifice_i;

        partial model StraightPipe_i "Icon for straight pipe"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}},
                    fileName=
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/StraightPipe/icon_straightPipe.png")}));
        end StraightPipe_i;

        partial model Valve_i "Icon for valve"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}},
                    fileName="modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/valve/icon_valve.png")}));
        end Valve_i;
      end PressureLoss;

    end Icons;

    package Records "Package for base records"
    extends Modelica.Icons.RecordsPackage;
      package General
        extends Modelica.Icons.RecordsPackage;
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

          SI.SpecificHeatCapacityAtConstantPressure cp
            "Specific heat capacity of fluid at constant pressure"
            annotation (Dialog(group="Fluid properties"));

          SI.DynamicViscosity eta "Dynamic viscosity of fluid"
            annotation (Dialog(group="Fluid properties"));

          SI.ThermalConductivity lambda "Thermal conductivity of fluid"
            annotation (Dialog(group="Fluid properties"));

          SI.Density rho "Density of fluid"
            annotation (Dialog(group="Fluid properties"));
        end FluidProperties;

        record IdealGas_con
          "Base record for generic pressure loss function | ideal gas | mean density"
          extends Modelica.Icons.Record;

          Real exp=2 "Exponent of pressure loss law"
            annotation (Dialog(group="Generic variables"));
          SI.SpecificHeatCapacity R_s "Specific gas constant of ideal gas"
            annotation (Dialog(group="Fluid properties"));
          Real Km=6824.86
            "Coefficient for pressure loss law [(Pa)^2/{(kg/s)^exp*K}]"
            annotation (Dialog(group="Generic variables"));

        end IdealGas_con;

        record IdealGas_var
          "Base record for generic pressure loss function | ideal gas | mean density"
          extends Modelica.Icons.Record;

          SI.Density rho_m "Mean density of ideal gas"
            annotation (Dialog(group="Fluid properties", enable=useMeanDensity));
          SI.Temperature T_m "Mean temperature of ideal gas"
            annotation (Dialog(group="Fluid properties", enable=not (useMeanDensity)));
          SI.Pressure p_m "Mean pressure of ideal gas"
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
          SI.Density rho_nom
            "Nominal density (at nominal values of mass flow rate and pressure loss)"
            annotation (Dialog(group="Generic variables"));
          Real exp_eta=1 "Exponent for dynamic viscosity dependence"
            annotation (Dialog(group="Generic variables"));
          SI.DynamicViscosity eta_nom
            "Dynamic viscosity at nominal pressure loss"
            annotation (Dialog(group="Generic variables"));

        end NominalDensityViscosity;

        record NominalPressureLossLawDensity_con
          "Base record for generic pressure loss function"

          extends Modelica.Icons.Record;

          //NominalMassFlowRate
          Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate
            target =                                                             Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate
            "MassFlowRate == use nominal mass flow rate | VolumeFlowRate == use nominal volume flow rate"
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
          SI.Density rho_nom
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
          SI.Length perimeter=PI*0.1 "Wetted perimeter"
            annotation (Dialog(group="Geometry"));
          SI.Length length=1 "Length in fluid flow direction"
            annotation (Dialog(group="Geometry"));

        end TwoPhaseFlow_con;

        record TwoPhaseFlow_var "Base record for two phase flow"
          extends Modelica.Icons.Record;

          SI.Density rho_g "Density of gas"
            annotation (Dialog(group="Fluid properties"));
          SI.Density rho_l "Density of liquid"
            annotation (Dialog(group="Fluid properties"));
          SI.DynamicViscosity eta_g "Dynamic viscosity of gas"
            annotation (Dialog(group="Fluid properties"));
          SI.DynamicViscosity eta_l "Dynamic viscosity of liquid"
            annotation (Dialog(group="Fluid properties"));
          SI.SurfaceTension sigma "Surface tension"
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
          parameter SI.SpecificHeatCapacity R_s(min=1)
            "Specific gas constant of ideal gas"
            annotation (Dialog(group="Fluid properties"));

          Real Km(min=Modelica.Constants.eps) = R_s*(2e3)/((10)^exp/rho_m)
            "Coefficient for pressure loss law [(Pa)^2/{(kg/s)^exp*K}]"
            annotation (Dialog(group="Generic variables"));
          SI.Density rho_m=p_m/(R_s*T_m) "Mean density of ideal gas"
            annotation (Dialog(group="Fluid properties", enable=useMeanDensity));
          SI.Temperature T_m "Mean temperature of ideal gas"
            annotation (Dialog(group="Fluid properties", enable=not (useMeanDensity)));
          SI.Pressure p_m "Mean pressure of ideal gas"
            annotation (Dialog(group="Fluid properties", enable=not (useMeanDensity)));

        end IdealGas;

        record NominalPressureLossLawDensity
          "Base record for generic pressure loss function"

          extends Modelica.Icons.Record;

          //NominalMassFlowRate
          Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate
            target =                                                             Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate
            "MassFlowRate == use nominal mass flow rate | VolumeFlowRate == use nominal volume flow rate"
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
          SI.Density rho_nom(min=Modelica.Constants.eps)
            "Nominal density (at nominal values of mass flow rate and pressure loss)"
            annotation (Dialog(group="Generic variables"));

          Types.PressureLossCoefficient zeta_TOT=zeta_TOT_nom
            "Pressure loss coefficient" annotation (Dialog(group="Generic variables"));
          parameter Types.PressureLossCoefficient zeta_TOT_nom=0.02*1/0.1
            "Nominal pressure loss coefficient (for nominal values)"
            annotation (Dialog(group="Generic variables"));

        end NominalPressureLossLawDensity;

        record TwoPhaseFlow "Base record for two phase Flow"
          extends Modelica.Icons.Record;

          SI.Density rho_l "Density of liquid"
            annotation (Dialog(group="Fluid properties"));
          SI.Density rho_g "Density of gas" annotation (Dialog(group=
                  "Fluid properties", enable= (KC == 1 or KC == 2)));
          SI.DynamicViscosity eta_l "Dynamic viscosity of liquid"
            annotation (Dialog(group="Fluid properties"));
          SI.DynamicViscosity eta_g "Dynamic viscosity of gas" annotation (
              Dialog(group="Fluid properties", enable= (KC == 1 or KC == 2)));
          SI.MassFraction x=0.5 "Vapour fraction"
            annotation (Dialog(group="Fluid properties"));
          SI.SurfaceTension sigma "Surface Tension" annotation (Dialog(group=
                  "Fluid properties", enable= DP_fric == 1));
          Real n=0.25 "Exponent in Blasius equation (0.2-0.25)" annotation (Dialog(
                group="others", enable= DP_fric == 2));
        end TwoPhaseFlow;
      end General;

      package HeatTransfer
        extends Modelica.Icons.RecordsPackage;
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

          SI.Diameter d_hyd=0.1 "Hydraulic diameter"
            annotation (Dialog(group="Straight pipe"));
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
          SI.Length perimeter=Modelica.Constants.pi*0.1 "Wetted perimeter"
            annotation (Dialog(group="Geometry"));

          Modelica.Fluid.Dissipation.Utilities.Types.MolarMass_gpmol MM=18.02
            "Molar mass of fluid" annotation (Dialog(group=
                  "Fluid properties", enable=if target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor
                   or target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer then
                        true else false));
          SI.Pressure p_crit "Critical pressure of fluid"
            annotation (Dialog(group="Fluid properties"));

          annotation (Documentation(revisions="<html>
<ul>
<li><em>13 May 2011</em>
    by Stefan Wischhusen:<br>
       Corrected the required unit of parameter MM.</li>
</ul>
</html>"));
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
          SI.SpecificHeatCapacityAtConstantPressure cp_l
            "Specific heat capacity of liquid"
            annotation (Dialog(group="Fluid properties"));
          SI.ThermalConductivity lambda_l "Thermal conductivity of liquid"
            annotation (Dialog(group="Fluid properties"));
          SI.Density rho_g "Density of gas" annotation (Dialog(group=
                  "Fluid properties", enable=if target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor
                   or target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer then
                        true else false));
          SI.Density rho_l "Density of liquid"
            annotation (Dialog(group="Fluid properties"));
          SI.DynamicViscosity eta_g "Dynamic viscosity of gas" annotation (
              Dialog(group="Fluid properties", enable=if target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor
                   or target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer then
                        true else false));
          SI.DynamicViscosity eta_l "Dynamic viscosity of liquid"
            annotation (Dialog(group="Fluid properties"));

          SI.Pressure pressure "Mean pressure of fluid"
            annotation (Dialog(group="Fluid properties"));
          SI.SpecificEnthalpy dh_lg "Evaporation enthalpy of fluid"
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
        extends Modelica.Icons.RecordsPackage;

        record Bend "Input for bend"
          extends EdgedBend;
          SI.Radius R_0=0.5*d_hyd "Curvature radius" annotation (Dialog(group="Bend"));

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
                  "Annular cross sectional area", enable=geometry == Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Annular));
          SI.Diameter D_ann=2*d_ann "Large diameter" annotation (Dialog(group=
                  "Annular cross sectional area", enable=geometry == Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Annular));
          //circular(2)
          SI.Diameter d_cir=0.1 "Internal diameter" annotation (Dialog(group=
                  "Circular cross sectional area", enable=geometry == Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Circular));
          //elliptical(3)
          SI.Length a_ell=(3/4)*d_cir "Half length of long base line" annotation (
              Dialog(group="Elliptical cross sectional area", enable=geometry ==
                  Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Elliptical));
          SI.Length b_ell=0.5*a_ell "Half length of short base line" annotation (Dialog(
                group="Elliptical cross sectional area", enable=geometry ==
                  Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Elliptical));
          //rectangular(4)
          SI.Length a_rec=d_cir "Horizontal length" annotation (Dialog(group=
                  "Rectangular cross sectional area", enable=geometry ==
                  Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Rectangular));
          SI.Length b_rec=a_rec "Vertical length" annotation (Dialog(group=
                  "Rectangular cross sectional area", enable=geometry ==
                  Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Rectangular));
          //triangular(5)
          SI.Length a_tri=d_cir*(1 + 2^0.5) "Length of base line" annotation (Dialog(
                group="Rectangular cross sectional area", enable=geometry ==
                  Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Rectangular));
          SI.Length h_tri=0.5*a_tri
            "Height to top angle perpendicular to base line"
            annotation (Dialog(group="Triangle cross sectional area", enable=geometry
                   == Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Isosceles));
          SI.Angle beta=90*PI/180 "Top angle" annotation (Dialog(group=
                  "Triangle cross sectional area", enable=geometry == Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Isosceles));
        end Geometry;

        record Orifice "Input for orifice"

          extends Modelica.Icons.Record;

          SI.Area A_0=0.1*A_1 "Cross sectional area of vena contraction"
            annotation (Dialog(group="Orifice"));
          SI.Length C_0=0.1*C_1 "Perimeter of vena contraction"
            annotation (Dialog(group="Orifice"));
          SI.Area A_1=PI*0.01^2/4 "Large cross sectional area of orifice"
            annotation (Dialog(group="Orifice"));
          SI.Length C_1=PI*0.01 "Large perimeter of orifice"
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
          SI.Length L=1 "Length" annotation (Dialog(group="Straight pipe"));
        end StraightPipe;

        record Tjunction "Input for T-junction"
          extends Modelica.Icons.Record;

          //T-junction variables
          Boolean united_converging_cross_section=true
            "= true, if A_cross_total = 2*A_cross_branch, otherwise A_cross_total > 2*A_cross_branch"
            annotation (Dialog(group="T-junction"));
          Boolean velocity_reference_branches=true
            "= true, if pressure loss coefficients w.r.t. velocity in each passage, otherwise w.r.t. velocity in total passage"
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
            "Length of diffuser section (parallel to bulk fluid flow)"
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

        record EdgedBend "Input for bend"
          extends Modelica.Icons.Record;

          SI.Diameter d_hyd(min=Modelica.Constants.eps) = 0.1
            "Hydraulic diameter"
            annotation (Dialog(group="Bend"));
          SI.Angle delta=90*PI/180 "Angle of turning" annotation (Dialog(group="Bend"));
          SI.Length K=0
            "Roughness (absolute average height of surface asperities)" annotation (Dialog(group="Bend"));

        end EdgedBend;

        record SuddenChange "Input for sudden change of diameter"

          extends Modelica.Icons.Record;

          SI.Area A_1=PI*0.01^2/4 "Small cross sectional area of orifice"
            annotation (Dialog(group="Orifice"));
          SI.Area A_2=A_1 "Large cross sectional area of orifice"
            annotation (Dialog(group="Orifice"));
          SI.Length C_1=PI*0.01 "Small perimeter of orifice"
            annotation (Dialog(group="Orifice"));
          SI.Length C_2=C_1 "Large perimeter of orifice"
            annotation (Dialog(group="Orifice"));
        end SuddenChange;
      end PressureLoss;
    end Records;

    package Types "Package for types"
    extends Modelica.Icons.TypesPackage;
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
          Energy "Kinetic energy flow approach w.r.t. Zivi (heterogeneous)",
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

      type MolarMass_gpmol = Real (final quantity="Molar mass", final unit="g/mol");
    end Types;
  end Utilities;
annotation (Documentation(info="<html>
<h4>Library description</h4>

<p>
This library contains <strong>convective heat transfer</strong> and <strong>pressure loss</strong> functions written in
Modelica&reg;. Generally the pressure loss calculations are based on incompressible fluids and total pressure difference. For devices with non changing cross sectional area, the calculated total pressure loss is equal to the static pressure difference. Geodetic pressure loss is not considered throughout the library. The functions supplied may be used separately.
</p>

<p>
The library is a non-commercial product of XRG Simulation GmbH.
</p>

<h4>Acknowledgements</h4>

<p>
The following people contributed to the Fluid.Dissipation library (alphabetical list):
J&ouml;rg Eiden, Ole Engel, Nina Peci, Sven Rutkowski, Thorben Vahlenkamp, Stefan
Wischhusen.
</p>

<p>
The development of the Fluid.Dissipation library was founded within the ITEA research
project EuroSysLib-D by German Federal Ministry of Education and Research (promotional
reference 01IS07022B). The project was started in October 2007 and ended in June 2010.
</p>

<p>
Copyright &copy; 2007-2020, Modelica Association and contributors
</p>

<h4>Contact</h4>

XRG Simulation GmbH<br>
Harburger Schlossstra&szlig;e 6-12<br>
21079 Hamburg<br>
Germany<br>
<br>
<a href=\"mailto:info@xrg-simulation.de\">info@xrg-simulation.de</a> </html>"));

end Dissipation;
